package org.swe304.schoolmanagement2.domain.mapper;

import org.swe304.schoolmanagement2.domain.dto.req.CourseCreateRequest;
import org.swe304.schoolmanagement2.domain.dto.req.CourseUpdateRequest;
import org.swe304.schoolmanagement2.domain.dto.res.CourseResponse;
import org.swe304.schoolmanagement2.domain.entity.Course;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface CourseMapper {
    Course toEntity(CourseCreateRequest request);
    CourseResponse toResponse(Course course);
    void updateEntityFromRequest(CourseUpdateRequest request, @MappingTarget Course course);
}
