From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/syncobj: extract two helpers from
 drm_syncobj_create
Date: Sat, 30 Sep 2017 09:55:21 +0800
Message-ID: <53eb9f85-e57f-fe8b-8bfb-967db2370c28@amd.com>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
 <4ae21aee-0b51-8338-b205-25d8910e2b86@amd.com>
 <CAAxE2A42G4-eD4x6VunDe4rW2c_GuaChn0Df+HE7wbvQYK0QFA@mail.gmail.com>
 <CAAxE2A6ecZnArHSu8P_DuHPOGhz0+6TfXtQshKWvhU1=1V4Lyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------5E4E7815664D7D694DF0C769"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6ecZnArHSu8P_DuHPOGhz0+6TfXtQshKWvhU1=1V4Lyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--------------5E4E7815664D7D694DF0C769
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

My mean is like the attached, I revert part of yours.

Regards,

David zhou


On 2017年09月29日 22:15, Marek Olšák wrote:
> On Fri, Sep 29, 2017 at 4:13 PM, Marek Olšák <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Fri, Sep 29, 2017 at 4:44 AM, Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org> wrote:
>>>
>>> On 2017年09月13日 04:42, Marek Olšák wrote:
>>>> From: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>>>>
>>>> For amdgpu.
>>>>
>>>> drm_syncobj_create is renamed to drm_syncobj_create_as_handle, and new
>>>> helpers drm_syncobj_create and drm_syncobj_get_handle are added.
>>>>
>>>> Signed-off-by: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>>>> ---
>>>>    drivers/gpu/drm/drm_syncobj.c | 49
>>>> +++++++++++++++++++++++++++++++++++++++----
>>>>    include/drm/drm_syncobj.h     |  4 ++++
>>>>    2 files changed, 49 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>>>> index 0422b8c..0bb1741 100644
>>>> --- a/drivers/gpu/drm/drm_syncobj.c
>>>> +++ b/drivers/gpu/drm/drm_syncobj.c
>>>> @@ -262,8 +262,14 @@ void drm_syncobj_free(struct kref *kref)
>>>>    }
>>>>    EXPORT_SYMBOL(drm_syncobj_free);
>>>>    -static int drm_syncobj_create(struct drm_file *file_private,
>>>> -                             u32 *handle, uint32_t flags)
>>> You can add a new parameter for passing dma fence, then in patch3, you can
>>> directly use it for AMDGPU_FENCE_TO HANDLE_GET_SYNCOBJ.
>>>
>>> otherwise the set looks good to me.
>> Sorry I just pushed this.
> Actually, you commented on a deleted line. The function already has
> dma_fence among the parameters.
>
> Marek


--------------5E4E7815664D7D694DF0C769
Content-Type: text/x-patch;
	name="0001-drm-Don-t-split-drm_syncobj_create.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-drm-Don-t-split-drm_syncobj_create.patch"

>From a34c466f4a8617c18bf191d83bff3a3382166b00 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Sat, 30 Sep 2017 09:53:53 +0800
Subject: [PATCH] drm: Don't split drm_syncobj_create

Change-Id: Icc6e4d8e94236675d6267d211e53698834d29869
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  6 +----
 drivers/gpu/drm/drm_syncobj.c          | 42 +++++-----------------------------
 include/drm/drm_syncobj.h              |  7 +++---
 3 files changed, 10 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ab83dfc..882becc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1351,14 +1351,10 @@ int amdgpu_cs_fence_to_handle_ioctl(struct drm_device *dev, void *data,
 
 	switch (info->in.what) {
 	case AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ:
-		r = drm_syncobj_create(&syncobj, 0, fence);
+		r = drm_syncobj_create(filp, fence, &info->out.handle, 0);
 		dma_fence_put(fence);
 		if (r)
 			return r;
-		r = drm_syncobj_get_handle(filp, syncobj, &info->out.handle);
-		drm_syncobj_put(syncobj);
-		return r;
-
 	case AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ_FD:
 		r = drm_syncobj_create(&syncobj, 0, fence);
 		dma_fence_put(fence);
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 62adc7a..28e1463 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -268,8 +268,9 @@ EXPORT_SYMBOL(drm_syncobj_free);
  * @flags: DRM_SYNCOBJ_* flags
  * @fence: if non-NULL, the syncobj will represent this fence
  */
-int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
-		       struct dma_fence *fence)
+int drm_syncobj_create(struct drm_file *file_private,
+		       struct dma_fence *fence,
+		       u32 *handle, uint32_t flags)
 {
 	int ret;
 	struct drm_syncobj *syncobj;
@@ -293,22 +294,6 @@ int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 	if (fence)
 		drm_syncobj_replace_fence(syncobj, fence);
 
-	*out_syncobj = syncobj;
-	return 0;
-}
-EXPORT_SYMBOL(drm_syncobj_create);
-
-/**
- * drm_syncobj_get_handle - get a handle from a syncobj
- */
-int drm_syncobj_get_handle(struct drm_file *file_private,
-			   struct drm_syncobj *syncobj, u32 *handle)
-{
-	int ret;
-
-	/* take a reference to put in the idr */
-	drm_syncobj_get(syncobj);
-
 	idr_preload(GFP_KERNEL);
 	spin_lock(&file_private->syncobj_table_lock);
 	ret = idr_alloc(&file_private->syncobj_idr, syncobj, 1, 0, GFP_NOWAIT);
@@ -324,22 +309,7 @@ int drm_syncobj_get_handle(struct drm_file *file_private,
 	*handle = ret;
 	return 0;
 }
-EXPORT_SYMBOL(drm_syncobj_get_handle);
-
-static int drm_syncobj_create_as_handle(struct drm_file *file_private,
-					u32 *handle, uint32_t flags)
-{
-	int ret;
-	struct drm_syncobj *syncobj;
-
-	ret = drm_syncobj_create(&syncobj, flags, NULL);
-	if (ret)
-		return ret;
-
-	ret = drm_syncobj_get_handle(file_private, syncobj, handle);
-	drm_syncobj_put(syncobj);
-	return ret;
-}
+EXPORT_SYMBOL(drm_syncobj_create);
 
 static int drm_syncobj_destroy(struct drm_file *file_private,
 			       u32 handle)
@@ -568,8 +538,8 @@ drm_syncobj_create_ioctl(struct drm_device *dev, void *data,
 	if (args->flags & ~DRM_SYNCOBJ_CREATE_SIGNALED)
 		return -EINVAL;
 
-	return drm_syncobj_create_as_handle(file_private,
-					    &args->handle, args->flags);
+	return drm_syncobj_create(file_private, NULL,
+				  &args->handle, args->flags);
 }
 
 int
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index 43e2f38..4e3025e 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -136,10 +136,9 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
 			   u32 handle,
 			   struct dma_fence **fence);
 void drm_syncobj_free(struct kref *kref);
-int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
-		       struct dma_fence *fence);
-int drm_syncobj_get_handle(struct drm_file *file_private,
-			   struct drm_syncobj *syncobj, u32 *handle);
+int drm_syncobj_create(struct drm_file *file_private,
+		       struct dma_fence *fence,
+		       u32 *handle, uint32_t flags);
 int drm_syncobj_get_fd(struct drm_syncobj *syncobj, int *p_fd);
 
 #endif
-- 
2.7.4


--------------5E4E7815664D7D694DF0C769
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------5E4E7815664D7D694DF0C769--
