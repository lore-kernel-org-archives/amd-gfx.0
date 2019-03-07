From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: enable bo priority setting from user space
Date: Thu, 7 Mar 2019 18:48:55 +0800
Message-ID: <1d4f0b7d-f726-3cad-13c3-36e670f35baf@amd.com>
References: <20190307091528.22788-1-david1.zhou@amd.com>
 <a8803c5e-d911-992e-2b67-13ed6ca29ccf@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1909917878=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a8803c5e-d911-992e-2b67-13ed6ca29ccf-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1909917878==
Content-Type: multipart/alternative;
	boundary="------------A2AE8D134702821931A6CED2"
Content-Language: en-US

--------------A2AE8D134702821931A6CED2
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2019年03月07日 17:55, Michel Dänzer wrote:
> On 2019-03-07 10:15 a.m., Chunming Zhou wrote:
>> Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
> Please provide corresponding UMD patches showing how this is to be used.
spec is here:
https://www.khronos.org/registry/vulkan/specs/1.1-extensions/html/vkspec.html, 
please search "|VkMemoryPriorityAllocateInfoEXT|".

Fortunately, Windows guy already implemented it before, otherwise, I 
cannot find ready code on opensource, I hate this chicken first and egg 
first question :
https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/gpuMemory.cpp, 
please search "createInfo.priority".
https://github.com/GPUOpen-Drivers/pal/blob/dev/inc/core/palGpuMemory.h, 
priority definition is here.

>
>
>> @@ -229,6 +231,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>   	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>>   		return -EINVAL;
>>   
>> +	/* check priority */
>> +	if (args->in.priority == 0) {
> Did you verify that this is 0 with old userspace compiled against struct
> drm_amdgpu_gem_create_in without the priority field?
Without priority field, I don't think we can check here. Do you mean we 
need to add a new args struct?

>
>
>> +		/* default is normal */
>> +		args->in.priority = TTM_BO_PRIORITY_NORMAL;
>> +	} else if (args->in.priority > TTM_MAX_BO_PRIORITY) {
>> +		args->in.priority = TTM_MAX_BO_PRIORITY;
>> +		DRM_ERROR("priority specified from user space is over MAX priority\n");
> This must be DRM_DEBUG, or buggy/malicious userspace can spam dmesg.
Will change.

>
>
>> @@ -252,6 +262,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>   
>>   	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
>>   				     (u32)(0xffffffff & args->in.domains),
>> +				     args->in.priority - 1,
>>   				     flags, ttm_bo_type_device, resv, &gobj);
> It might be less confusing to subtract 1 after checking against
> TTM_MAX_BO_PRIORITY instead of here. Still kind of confusing though. How
> about this instead:
>
> Make the priority field of struct drm_amdgpu_gem_create_in signed. In
> amdgpu_gem_create_ioctl, clamp the priority to the supported range:
>
> 	args->in.priority += TTM_BO_PRIORITY_NORMAL;
> 	args->in.priority = max(args->in.priority, 0);
> 	args->in.priority = min(args->in.priority,
> 				TTM_BO_PRIORITY_NORMAL - 1);
>
> This way userspace doesn't need to do a weird mapping of the priority
> values (where 0 and 2 have the same meaning), and the range of supported
> priorities could at least theoretically be extended without breaking
> userspace.
First, I want to explain a bit the priority value from vulkan:
"    From Vulkan Spec, 0.0 <= value <= 1.0, and the granularity of the 
priorities is implementation-dependent.
      One thing Spec forced is that if VkMemoryPriority not specified as 
default behavior, it is as if the
      priority value is 0.5. Our strategy is that map 0.5 to 
GpuMemPriority::Normal-GpuMemPriorityOffset::Offset0,
      which is consistent to MemoryPriorityDefault. We adopts 
GpuMemPriority::VeryLow, GpuMemPriority::Low,
      GpuMemPriority::Normal, GpuMemPriority::High, 4 priority grades, 
each of which contains 8 steps of offests.
      This maps [0.0-1.0) to totally 32 steps. Finally, 1.0 maps to 
GpuMemPriority::VeryHigh.
"

So my original purpose is directly use Priority enum defined in PAL, 
like this:
  "
/// Specifies Base Level priority per GPU memory allocation as a hint to 
the memory manager in the event it needs to
/// select allocations to page out of their preferred heaps.
enum class GpuMemPriority : uint32
{
     Unused    = 0x0,  ///< Indicates that the allocation is not 
currently being used at all, and should be the first
                       ///  choice to be paged out.
     VeryLow   = 0x1,  ///< Lowest priority to keep in its preferred heap.
     Low       = 0x2,  ///< Low priority to keep in its preferred heap.
     Normal    = 0x3,  ///< Normal priority to keep in its preferred heap.
     High      = 0x4,  ///< High priority to keep in its preferred heap 
(e.g., render targets).
     VeryHigh  = 0x5,  ///< Highest priority to keep in its preferred 
heap.  Last choice to be paged out (e.g., page
                       ///  tables, displayable allocations).
     Count
};
"

If according your idea, we will need to convert it again when hooking 
linux implementation.
So what do think we still use unsigned?

>
>
>> @@ -304,6 +315,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>>   
>>   	/* create a gem object to contain this object in */
>>   	r = amdgpu_gem_object_create(adev, args->size, 0, AMDGPU_GEM_DOMAIN_CPU,
>> +				     TTM_BO_PRIORITY_NORMAL,
>>   				     0, ttm_bo_type_device, NULL, &gobj);
> Should the userptr ioctl also allow setting the priority?

We can.

>
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index fd9c4beeaaa4..c85304e03021 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -494,8 +494,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>>   
>>   	bo->tbo.bdev = &adev->mman.bdev;
>>   	amdgpu_bo_placement_from_domain(bo, bp->domain);
>> +	bo->tbo.priority = bp->priority;
>>   	if (bp->type == ttm_bo_type_kernel)
>> -		bo->tbo.priority = 1;
>> +		bo->tbo.priority = TTM_BO_PRIORITY_VERYHIGH;
> 	if (bp->type == ttm_bo_type_kernel)
> 		bo->tbo.priority = TTM_BO_PRIORITY_VERYHIGH;
> 	else
> 		bo->tbo.priority = bp->priority;
>
> would be clearer I think.
Agree.

-David

>
>


--------------A2AE8D134702821931A6CED2
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2019年03月07日 17:55, Michel Dänzer
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:a8803c5e-d911-992e-2b67-13ed6ca29ccf-otUistvHUpPR7s880joybQ@public.gmane.org">
      <pre wrap="">On 2019-03-07 10:15 a.m., Chunming Zhou wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Signed-off-by: Chunming Zhou <a class="moz-txt-link-rfc2396E" href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org">&lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>
</pre>
      </blockquote>
      <pre wrap="">
Please provide corresponding UMD patches showing how this is to be used.</pre>
    </blockquote>
    spec is here:<br>
<a class="moz-txt-link-freetext" href="https://www.khronos.org/registry/vulkan/specs/1.1-extensions/html/vkspec.html">https://www.khronos.org/registry/vulkan/specs/1.1-extensions/html/vkspec.html</a>,
    please search "<code data-lang="c++">VkMemoryPriorityAllocateInfoEXT</code>".<br>
    <br>
    Fortunately, Windows guy already implemented it before, otherwise, I
    cannot find ready code on opensource, I hate this chicken first and
    egg first question :<br>
<a class="moz-txt-link-freetext" href="https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/gpuMemory.cpp">https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/gpuMemory.cpp</a>,
    please search "createInfo.<span class="pl-smi">priority</span>".<br>
<a class="moz-txt-link-freetext" href="https://github.com/GPUOpen-Drivers/pal/blob/dev/inc/core/palGpuMemory.h">https://github.com/GPUOpen-Drivers/pal/blob/dev/inc/core/palGpuMemory.h</a>,
    priority definition is here.<br>
    <br>
    <blockquote type="cite"
      cite="mid:a8803c5e-d911-992e-2b67-13ed6ca29ccf-otUistvHUpPR7s880joybQ@public.gmane.org">
      <pre wrap="">


</pre>
      <blockquote type="cite">
        <pre wrap="">@@ -229,6 +231,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (args-&gt;in.domains &amp; ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
 
+	/* check priority */
+	if (args-&gt;in.priority == 0) {
</pre>
      </blockquote>
      <pre wrap="">
Did you verify that this is 0 with old userspace compiled against struct
drm_amdgpu_gem_create_in without the priority field?</pre>
    </blockquote>
    Without priority field, I don't think we can check here. Do you mean
    we need to add a new args struct?<br>
    <br>
    <blockquote type="cite"
      cite="mid:a8803c5e-d911-992e-2b67-13ed6ca29ccf-otUistvHUpPR7s880joybQ@public.gmane.org">
      <pre wrap="">


</pre>
      <blockquote type="cite">
        <pre wrap="">+		/* default is normal */
+		args-&gt;in.priority = TTM_BO_PRIORITY_NORMAL;
+	} else if (args-&gt;in.priority &gt; TTM_MAX_BO_PRIORITY) {
+		args-&gt;in.priority = TTM_MAX_BO_PRIORITY;
+		DRM_ERROR("priority specified from user space is over MAX priority\n");
</pre>
      </blockquote>
      <pre wrap="">
This must be DRM_DEBUG, or buggy/malicious userspace can spam dmesg.</pre>
    </blockquote>
    Will change.<br>
    <br>
    <blockquote type="cite"
      cite="mid:a8803c5e-d911-992e-2b67-13ed6ca29ccf-otUistvHUpPR7s880joybQ@public.gmane.org">
      <pre wrap="">


</pre>
      <blockquote type="cite">
        <pre wrap="">@@ -252,6 +262,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 
 	r = amdgpu_gem_object_create(adev, size, args-&gt;in.alignment,
 				     (u32)(0xffffffff &amp; args-&gt;in.domains),
+				     args-&gt;in.priority - 1,
 				     flags, ttm_bo_type_device, resv, &amp;gobj);
</pre>
      </blockquote>
      <pre wrap="">
It might be less confusing to subtract 1 after checking against
TTM_MAX_BO_PRIORITY instead of here. Still kind of confusing though. How
about this instead:

Make the priority field of struct drm_amdgpu_gem_create_in signed. In
amdgpu_gem_create_ioctl, clamp the priority to the supported range:

	args-&gt;in.priority += TTM_BO_PRIORITY_NORMAL;
	args-&gt;in.priority = max(args-&gt;in.priority, 0);
	args-&gt;in.priority = min(args-&gt;in.priority,
				TTM_BO_PRIORITY_NORMAL - 1);

This way userspace doesn't need to do a weird mapping of the priority
values (where 0 and 2 have the same meaning), and the range of supported
priorities could at least theoretically be extended without breaking
userspace.</pre>
    </blockquote>
    First, I want to explain a bit the priority value from vulkan:<br>
    "    From Vulkan Spec, 0.0 &lt;= value &lt;= 1.0, and the
    granularity of the priorities is implementation-dependent.<br>
         One thing Spec forced is that if VkMemoryPriority not specified
    as default behavior, it is as if the<br>
         priority value is 0.5. Our strategy is that map 0.5 to
    GpuMemPriority::Normal-GpuMemPriorityOffset::Offset0,<br>
         which is consistent to MemoryPriorityDefault. We adopts
    GpuMemPriority::VeryLow, GpuMemPriority::Low,<br>
         GpuMemPriority::Normal, GpuMemPriority::High, 4 priority
    grades, each of which contains 8 steps of offests.<br>
         This maps [0.0-1.0) to totally 32 steps. Finally, 1.0 maps to
    GpuMemPriority::VeryHigh.<br>
    "<br>
    <br>
    So my original purpose is directly use Priority enum defined in PAL,
    like this:<br>
     "<br>
    /// Specifies Base Level priority per GPU memory allocation as a
    hint to the memory manager in the event it needs to<br>
    /// select allocations to page out of their preferred heaps.<br>
    enum class GpuMemPriority : uint32<br>
    {<br>
        Unused    = 0x0,  ///&lt; Indicates that the allocation is not
    currently being used at all, and should be the first<br>
                          ///  choice to be paged out.<br>
        VeryLow   = 0x1,  ///&lt; Lowest priority to keep in its
    preferred heap.<br>
        Low       = 0x2,  ///&lt; Low priority to keep in its preferred
    heap.<br>
        Normal    = 0x3,  ///&lt; Normal priority to keep in its
    preferred heap.<br>
        High      = 0x4,  ///&lt; High priority to keep in its preferred
    heap (e.g., render targets).<br>
        VeryHigh  = 0x5,  ///&lt; Highest priority to keep in its
    preferred heap.  Last choice to be paged out (e.g., page<br>
                          ///  tables, displayable allocations).<br>
        Count<br>
    };<br>
    "<br>
    <br>
    If according your idea, we will need to convert it again when
    hooking linux implementation.<br>
    So what do think we still use unsigned?<br>
    <br>
    <blockquote type="cite"
      cite="mid:a8803c5e-d911-992e-2b67-13ed6ca29ccf-otUistvHUpPR7s880joybQ@public.gmane.org">
      <pre wrap="">


</pre>
      <blockquote type="cite">
        <pre wrap="">@@ -304,6 +315,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 
 	/* create a gem object to contain this object in */
 	r = amdgpu_gem_object_create(adev, args-&gt;size, 0, AMDGPU_GEM_DOMAIN_CPU,
+				     TTM_BO_PRIORITY_NORMAL,
 				     0, ttm_bo_type_device, NULL, &amp;gobj);
</pre>
      </blockquote>
      <pre wrap="">
Should the userptr ioctl also allow setting the priority?</pre>
    </blockquote>
    <br>
    We can.<br>
    <br>
    <blockquote type="cite"
      cite="mid:a8803c5e-d911-992e-2b67-13ed6ca29ccf-otUistvHUpPR7s880joybQ@public.gmane.org">
      <pre wrap="">


</pre>
      <blockquote type="cite">
        <pre wrap="">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fd9c4beeaaa4..c85304e03021 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -494,8 +494,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 
 	bo-&gt;tbo.bdev = &amp;adev-&gt;mman.bdev;
 	amdgpu_bo_placement_from_domain(bo, bp-&gt;domain);
+	bo-&gt;tbo.priority = bp-&gt;priority;
 	if (bp-&gt;type == ttm_bo_type_kernel)
-		bo-&gt;tbo.priority = 1;
+		bo-&gt;tbo.priority = TTM_BO_PRIORITY_VERYHIGH;
</pre>
      </blockquote>
      <pre wrap="">
	if (bp-&gt;type == ttm_bo_type_kernel)
		bo-&gt;tbo.priority = TTM_BO_PRIORITY_VERYHIGH;
	else
		bo-&gt;tbo.priority = bp-&gt;priority;

would be clearer I think.</pre>
    </blockquote>
    Agree.<br>
    <br>
    -David<br>
    <br>
    <blockquote type="cite"
      cite="mid:a8803c5e-d911-992e-2b67-13ed6ca29ccf-otUistvHUpPR7s880joybQ@public.gmane.org">
      <pre wrap="">


</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------A2AE8D134702821931A6CED2--

--===============1909917878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1909917878==--
