# Lab 4: Data Manipulation Language (DML) - Notes

## Part 4 Referential Integrity Reflection

* **What error did you get in Part 4?** 
  When attempting to delete the 'Library and Information Science' department while a student record was still linked to it, MySQL returned **Error 1451: Cannot delete or update a parent row: a foreign key constraint fails**.

* **Why does MySQL refuse?** 
  MySQL refuses the deletion to preserve referential integrity and prevent *orphaned records*—ensuring that a child record in the `Student` table (`dept_id`) does not point to a parent department ID that no longer exists in the `Department` table.

* **How did you fix it?** 
  We fixed it the correct relational way by first updating the dependent student's `dept_id` to reference an active department ('Software Engineering'), and *then* executing the `DELETE` statement safely on the parent department.

* **What other fix could you have used?** 
  Alternatively, we could have configured the foreign key constraint with an `ON DELETE CASCADE` rule (so deleting the parent department automatically deletes all associated students) or an `ON DELETE SET NULL` rule (which automatically changes the student's `dept_id` to NULL upon department deletion). However, reassigning students manually is much safer in production academic systems to prevent accidental data loss.