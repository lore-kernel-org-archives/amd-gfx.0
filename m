From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: libdrm amdgpu semaphores questions
Date: Thu, 1 Dec 2016 14:11:32 +0800
Message-ID: <583FBF14.8000506@amd.com>
References: <CAPM=9twrphvnNx99H4r3ROaNaKMKj7uwuii_1Ph57Vv7Z-aFSg@mail.gmail.com>
 <420B93AA-EBE2-4DB4-B0D0-AE574AEFA22B@amd.com> <583FB287.5050602@amd.com>
 <CAPM=9tz2Qv0DXp-Tpfb38b81G1Gbs0MyM4KvUcvj5m+sp3dhoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080201060407020706070401"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tz2Qv0DXp-Tpfb38b81G1Gbs0MyM4KvUcvj5m+sp3dhoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>

--------------080201060407020706070401
Content-Type: multipart/alternative;
	boundary="------------020804020105070103010501"

--------------020804020105070103010501
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dave,

As the attached, our Vulkan team is verifying it.

Thanks,
David Zhou

On 2016年12月01日 13:44, Dave Airlie wrote:
>
> On 1 Dec. 2016 15:22, "zhoucm1" <david1.zhou-5C7GfCeVMHo@public.gmane.org 
> <mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org>> wrote:
> >
> > Yes, the old implementation which is already in upstream libdrm is 
> out of data, there isn't other user, so we want to drop it when new 
> semaphore is verified OK.
>
> Could you post some patches for the new one? Otherwise I'll have to 
> write one for radv.
>
> Dave.
> >
> > Thanks,
> > David Zhou
> >
> >
> > On 2016年12月01日 10:36, Mao, David wrote:
> >>
> >> Hi Dave,
> >> i believe your first attempt is correct.
> >> The export/import semaphore needs refine of the semaphore 
> implementation.
> >> We are working on that.
> >>
> >> Thanks.
> >> Best Regards,
> >> David
> >>>
> >>> On 1 Dec 2016, at 10:12 AM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> >>>
> >>> Hey all,
> >>>
> >>> So I've started adding semaphore support to radv but I'm not really
> >>> sure what the API to the semaphore code is.
> >>>
> >>> the Vulkan API is you get a command submission of a number of submit
> >>> units which have a 0-n wait semaphore, 0-n command buffers and 0-n
> >>> signal semaphores.
> >>>
> >>> Now I'm not sure how I should use the APIs with those.
> >>>
> >>> My first attempt is
> >>>
> >>> call amdgpu_cs_wait_semaphore on all the wait ones, call the cs submit
> >>> API, then call the amdgpu_cs_signal_semaphore on all the signal ones?
> >>>
> >>> or should I be up front calling wait/signal then submitting the 
> command streams?
> >>>
> >>> Also upcoming work requires possibly sharing semaphores between
> >>> processes, is there any indication how this might be made work with
> >>> the libdrm_amdgpu semaphore implementation?
> >>>
> >>> Thanks,
> >>> Dave.
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
> >
>


--------------020804020105070103010501
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi Dave,<br>
    <br>
    As the attached, our Vulkan team is verifying it.<br>
    <br>
    Thanks,<br>
    David Zhou<br>
    <br>
    <div class="moz-cite-prefix">On 2016年12月01日 13:44, Dave Airlie
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAPM=9tz2Qv0DXp-Tpfb38b81G1Gbs0MyM4KvUcvj5m+sp3dhoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <p dir="ltr">On 1 Dec. 2016 15:22, "zhoucm1" &lt;<a
          moz-do-not-send="true" href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org">david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&gt;
        wrote:<br>
        &gt;<br>
        &gt; Yes, the old implementation which is already in upstream
        libdrm is out of data, there isn't other user, so we want to
        drop it when new semaphore is verified OK.</p>
      <p dir="ltr">Could you post some patches for the new one?
        Otherwise I'll have to write one for radv.</p>
      <p dir="ltr">Dave.<br>
        &gt;<br>
        &gt; Thanks,<br>
        &gt; David Zhou<br>
        &gt;<br>
        &gt;<br>
        &gt; On 2016年12月01日 10:36, Mao, David wrote:<br>
        &gt;&gt;<br>
        &gt;&gt; Hi Dave,<br>
        &gt;&gt; i believe your first attempt is correct.<br>
        &gt;&gt; The export/import semaphore needs refine of the
        semaphore implementation.<br>
        &gt;&gt; We are working on that.<br>
        &gt;&gt;<br>
        &gt;&gt; Thanks.<br>
        &gt;&gt; Best Regards,<br>
        &gt;&gt; David<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; On 1 Dec 2016, at 10:12 AM, Dave Airlie &lt;<a
          moz-do-not-send="true" href="mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
        wrote:<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; Hey all,<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; So I've started adding semaphore support to radv
        but I'm not really<br>
        &gt;&gt;&gt; sure what the API to the semaphore code is.<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; the Vulkan API is you get a command submission of a
        number of submit<br>
        &gt;&gt;&gt; units which have a 0-n wait semaphore, 0-n command
        buffers and 0-n<br>
        &gt;&gt;&gt; signal semaphores.<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; Now I'm not sure how I should use the APIs with
        those.<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; My first attempt is<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; call amdgpu_cs_wait_semaphore on all the wait ones,
        call the cs submit<br>
        &gt;&gt;&gt; API, then call the amdgpu_cs_signal_semaphore on
        all the signal ones?<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; or should I be up front calling wait/signal then
        submitting the command streams?<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; Also upcoming work requires possibly sharing
        semaphores between<br>
        &gt;&gt;&gt; processes, is there any indication how this might
        be made work with<br>
        &gt;&gt;&gt; the libdrm_amdgpu semaphore implementation?<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; Thanks,<br>
        &gt;&gt;&gt; Dave.<br>
        &gt;&gt;&gt; _______________________________________________<br>
        &gt;&gt;&gt; amd-gfx mailing list<br>
        &gt;&gt;&gt; <a moz-do-not-send="true"
          href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
        &gt;&gt;&gt; <a moz-do-not-send="true"
          href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
        &gt;&gt;<br>
        &gt;&gt; _______________________________________________<br>
        &gt;&gt; amd-gfx mailing list<br>
        &gt;&gt; <a moz-do-not-send="true"
          href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
        &gt;&gt; <a moz-do-not-send="true"
          href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
        &gt;<br>
        &gt;</p>
    </blockquote>
    <br>
  </body>
</html>

--------------020804020105070103010501--

--------------080201060407020706070401
Content-Type: text/x-patch;
	name="0001-amdgpu-add-new-semaphore-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-amdgpu-add-new-semaphore-support.patch"

>From 9110b529019fbac27a95ce3090d305c528e0999b Mon Sep 17 00:00:00 2001
From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 22 Sep 2016 14:50:16 +0800
Subject: [PATCH 1/2] amdgpu: add new semaphore support

Change-Id: Iae7e4157d6184dab1cd4a944ae9cb803f9b11670
Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
---
 amdgpu/amdgpu.h          | 74 +++++++++++++++++++++++++++++++++++++++
 amdgpu/amdgpu_cs.c       | 90 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/drm/amdgpu_drm.h | 29 ++++++++++++++++
 3 files changed, 193 insertions(+)

diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index 525bf8e..bd6265d 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -137,6 +137,12 @@ typedef struct amdgpu_va *amdgpu_va_handle;
  */
 typedef struct amdgpu_semaphore *amdgpu_semaphore_handle;
 
+/**
+ * Define handle for sem file
+ */
+typedef int amdgpu_sem_handle;
+
+
 /*--------------------------------------------------------------------------*/
 /* -------------------------- Structures ---------------------------------- */
 /*--------------------------------------------------------------------------*/
@@ -1529,6 +1535,74 @@ int amdgpu_cs_wait_semaphore(amdgpu_context_handle ctx,
 int amdgpu_cs_destroy_semaphore(amdgpu_semaphore_handle sem);
 
 /**
+ *  create sem
+ *
+ * \param   dev    - [in] Device handle. See #amdgpu_device_initialize()
+ * \param   sem	   - \c [out] sem handle
+ *
+ * \return   0 on success\n
+ *          <0 - Negative POSIX Error code
+ *
+*/
+int amdgpu_cs_create_sem(amdgpu_device_handle dev,
+			 amdgpu_sem_handle *sem);
+
+/**
+ *  signal sem
+ *
+ * \param   dev    - [in] Device handle. See #amdgpu_device_initialize()
+ * \param   context        - \c [in] GPU Context
+ * \param   ip_type        - \c [in] Hardware IP block type = AMDGPU_HW_IP_*
+ * \param   ip_instance    - \c [in] Index of the IP block of the same type
+ * \param   ring           - \c [in] Specify ring index of the IP
+ * \param   sem	   - \c [out] sem handle
+ *
+ * \return   0 on success\n
+ *          <0 - Negative POSIX Error code
+ *
+ */
+int amdgpu_cs_signal_sem(amdgpu_device_handle dev,
+			 amdgpu_context_handle ctx,
+			 uint32_t ip_type,
+			 uint32_t ip_instance,
+			 uint32_t ring,
+			 amdgpu_sem_handle sem);
+
+/**
+ *  wait sem
+ *
+ * \param   dev    - [in] Device handle. See #amdgpu_device_initialize()
+ * \param   context        - \c [in] GPU Context
+ * \param   ip_type        - \c [in] Hardware IP block type = AMDGPU_HW_IP_*
+ * \param   ip_instance    - \c [in] Index of the IP block of the same type
+ * \param   ring           - \c [in] Specify ring index of the IP
+ * \param   sem	   - \c [out] sem handle
+ *
+ * \return   0 on success\n
+ *          <0 - Negative POSIX Error code
+ *
+*/
+int amdgpu_cs_wait_sem(amdgpu_device_handle dev,
+		       amdgpu_context_handle ctx,
+		       uint32_t ip_type,
+		       uint32_t ip_instance,
+		       uint32_t ring,
+		       amdgpu_sem_handle sem);
+
+/**
+ *  destroy sem
+ *
+ * \param   dev    - [in] Device handle. See #amdgpu_device_initialize()
+ * \param   sem	   - \c [out] sem handle
+ *
+ * \return   0 on success\n
+ *          <0 - Negative POSIX Error code
+ *
+ */
+int amdgpu_cs_destroy_sem(amdgpu_device_handle dev,
+			  amdgpu_sem_handle sem);
+
+/**
  *  Get the ASIC marketing name
  *
  * \param   dev         - \c [in] Device handle. See #amdgpu_device_initialize()
diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
index 73fde25..1018f76 100644
--- a/amdgpu/amdgpu_cs.c
+++ b/amdgpu/amdgpu_cs.c
@@ -25,6 +25,8 @@
 #include "config.h"
 #endif
 
+#include <sys/stat.h>
+#include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -639,3 +641,91 @@ int amdgpu_cs_destroy_semaphore(amdgpu_semaphore_handle sem)
 {
 	return amdgpu_cs_unreference_sem(sem);
 }
+
+int amdgpu_cs_create_sem(amdgpu_device_handle dev,
+			 amdgpu_sem_handle *sem)
+{
+	union drm_amdgpu_sem args;
+	int r;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	/* Create the context */
+	memset(&args, 0, sizeof(args));
+	args.in.op = AMDGPU_SEM_OP_CREATE_SEM;
+	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
+	if (r)
+		return r;
+
+	*sem = args.out.fd;
+
+	return 0;
+}
+
+int amdgpu_cs_signal_sem(amdgpu_device_handle dev,
+			 amdgpu_context_handle ctx,
+			 uint32_t ip_type,
+			 uint32_t ip_instance,
+			 uint32_t ring,
+			 amdgpu_sem_handle sem)
+{
+	union drm_amdgpu_sem args;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	/* Create the context */
+	memset(&args, 0, sizeof(args));
+	args.in.op = AMDGPU_SEM_OP_SIGNAL_SEM;
+	args.in.ctx_id = ctx->id;
+	args.in.ip_type = ip_type;
+	args.in.ip_instance = ip_instance;
+	args.in.ring = ring;
+	args.in.fd = sem;
+	return drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
+}
+
+int amdgpu_cs_wait_sem(amdgpu_device_handle dev,
+		       amdgpu_context_handle ctx,
+		       uint32_t ip_type,
+		       uint32_t ip_instance,
+		       uint32_t ring,
+		       amdgpu_sem_handle sem)
+{
+	union drm_amdgpu_sem args;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	/* Create the context */
+	memset(&args, 0, sizeof(args));
+	args.in.op = AMDGPU_SEM_OP_WAIT_SEM;
+	args.in.ctx_id = ctx->id;
+	args.in.ip_type = ip_type;
+	args.in.ip_instance = ip_instance;
+	args.in.ring = ring;
+	args.in.fd = sem;
+	args.in.seq = 0;
+	return drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
+}
+
+int amdgpu_cs_destroy_sem(amdgpu_device_handle dev,
+			  amdgpu_sem_handle sem)
+{
+	union drm_amdgpu_sem args;
+	int r;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	/* Create the context */
+	memset(&args, 0, sizeof(args));
+	args.in.op = AMDGPU_SEM_OP_DESTROY_SEM;
+	args.in.fd = sem;
+	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
+	if (r)
+		return r;
+	close(sem);
+	return 0;
+}
diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
index bb60504..cb784fd 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -47,6 +47,7 @@
 #define DRM_AMDGPU_GEM_OP		0x10
 #define DRM_AMDGPU_GEM_USERPTR		0x11
 /* hybrid specific ioctls */
+#define DRM_AMDGPU_SEM                  0x5b
 #define DRM_AMDGPU_GEM_DGMA		0x5c
 #define DRM_AMDGPU_FREESYNC		0x5d
 #define DRM_AMDGPU_WAIT_FENCES		0x5e
@@ -69,6 +70,7 @@
 #define DRM_IOCTL_AMDGPU_FREESYNC	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FREESYNC, struct drm_amdgpu_freesync)
 #define DRM_IOCTL_AMDGPU_WAIT_FENCES	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
 #define DRM_IOCTL_AMDGPU_GEM_FIND_BO	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_FIND_BO, struct drm_amdgpu_gem_find_bo)
+#define DRM_IOCTL_AMDGPU_SEM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_SEM, union drm_amdgpu_sem)
 
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -193,6 +195,33 @@ union drm_amdgpu_ctx {
 	union drm_amdgpu_ctx_out out;
 };
 
+/* sync file related */
+#define AMDGPU_SEM_OP_CREATE_SEM       1
+#define AMDGPU_SEM_OP_WAIT_SEM         2
+#define AMDGPU_SEM_OP_SIGNAL_SEM       3
+#define AMDGPU_SEM_OP_DESTROY_SEM      4
+
+struct drm_amdgpu_sem_in {
+	/** AMDGPU_SEM_OP_* */
+	uint32_t        op;
+	int             fd;
+	uint32_t        ctx_id;
+	uint32_t        ip_type;
+	uint32_t        ip_instance;
+	uint32_t        ring;
+	uint64_t        seq;
+};
+
+union drm_amdgpu_sem_out {
+	int            fd;
+	uint32_t        _pad;
+};
+
+union drm_amdgpu_sem {
+	struct drm_amdgpu_sem_in in;
+	union drm_amdgpu_sem_out out;
+};
+
 /*
  * This is not a reliable API and you should expect it to fail for any
  * number of reasons and have fallback path that do not use userptr to
-- 
1.9.1


--------------080201060407020706070401
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-add-new-semaphore-object-in-kernel-side.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-drm-amdgpu-add-new-semaphore-object-in-kernel-side.patc";
	filename*1="h"

>From 37dafc14c11593d313c29eff314c6d51f39a084d Mon Sep 17 00:00:00 2001
From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 23 Sep 2016 10:22:22 +0800
Subject: [PATCH] drm/amdgpu: add new semaphore object in kernel side

So that semaphore can be shared across porcess across devices.

Change-Id: Ie82cace6af81e2ddf45f4bbf9f3c0dafd6bcc499
Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/Makefile               |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sem.c           | 268 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sem.h           |  44 ++++
 drivers/gpu/drm/amd/include/uapi/drm/amdgpu_drm.h |  29 +++
 8 files changed, 360 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sem.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sem.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index bb5ec0e7..007e6f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -32,7 +32,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
 	amdgpu_prime.o amdgpu_vm.o amdgpu_ib.o amdgpu_pll.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
-	amdgpu_gtt_mgr.o
+	amdgpu_gtt_mgr.o amdgpu_sem.o
 
 # add asic specific block
 amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o kv_dpm.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 431cc14..2665f2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -968,6 +968,8 @@ struct amdgpu_ctx_ring {
 	uint64_t		sequence;
 	struct fence		**fences;
 	struct amd_sched_entity	entity;
+	struct list_head	sem_list;
+	struct mutex            sem_lock;
 };
 
 struct amdgpu_ctx {
@@ -1884,6 +1886,12 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 int amdgpu_freesync_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp);
 
+int amdgpu_sem_ioctl(struct drm_device *dev, void *data,
+		     struct drm_file *filp);
+
+int amdgpu_sem_add_cs(struct amdgpu_ctx *ctx, struct amdgpu_ring *ring,
+		      struct amdgpu_sync *sync);
+
 int amdgpu_gem_dgma_ioctl(struct drm_device *dev, void *data,
 			   struct drm_file *filp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 4dd4e1c..9af7ffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1021,7 +1021,7 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
 		}
 	}
 
-	return 0;
+	return amdgpu_sem_add_cs(p->ctx, p->job->ring, &p->job->sync);
 }
 
 static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 3fa99f1..53794eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -42,6 +42,8 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev, struct amdgpu_ctx *ctx)
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		ctx->rings[i].sequence = 1;
 		ctx->rings[i].fences = &ctx->fences[amdgpu_sched_jobs * i];
+		INIT_LIST_HEAD(&ctx->rings[i].sem_list);
+		mutex_init(&ctx->rings[i].sem_lock);
 	}
 	/* create context entity for each ring */
 	for (i = 0; i < adev->num_rings; i++) {
@@ -74,8 +76,10 @@ static void amdgpu_ctx_fini(struct amdgpu_ctx *ctx)
 		return;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i)
-		for (j = 0; j < amdgpu_sched_jobs; ++j)
+		for (j = 0; j < amdgpu_sched_jobs; ++j) {
 			fence_put(ctx->rings[i].fences[j]);
+			mutex_destroy(&ctx->rings[i].sem_lock);
+		}
 	kfree(ctx->fences);
 
 	for (i = 0; i < adev->num_rings; i++)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fefb29e..ce4cf79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -813,7 +813,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_FIND_BO, amdgpu_gem_find_bo_by_cpu_mapping_ioctl, DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_FREESYNC, amdgpu_freesync_ioctl, DRM_MASTER|DRM_UNLOCKED),
-	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_DGMA, amdgpu_gem_dgma_ioctl, DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW)
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_DGMA, amdgpu_gem_dgma_ioctl, DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_SEM, amdgpu_sem_ioctl, DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 };
 #else
 const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
@@ -833,7 +834,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_FIND_BO, amdgpu_gem_find_bo_by_cpu_mapping_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_FREESYNC, amdgpu_freesync_ioctl, DRM_MASTER),
-	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_DGMA, amdgpu_gem_dgma_ioctl, DRM_AUTH|DRM_RENDER_ALLOW)
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_DGMA, amdgpu_gem_dgma_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_SEM, amdgpu_sem_ioctl, DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 };
 #endif /* defined(BUILD_AS_DKMS) && LINUX_VERSION_CODE < KERNEL_VERSION(4, 4, 0) */
 const int amdgpu_max_kms_ioctl = ARRAY_SIZE(amdgpu_ioctls_kms);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.c
new file mode 100644
index 0000000..e86dfa1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.c
@@ -0,0 +1,268 @@
+/*
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
+ */
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/poll.h>
+#include <linux/seq_file.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/anon_inodes.h>
+#include "amdgpu_sem.h"
+#include "amdgpu.h"
+#include <drm/drmP.h>
+
+static int amdgpu_sem_cring_add(struct amdgpu_fpriv *fpriv,
+				struct drm_amdgpu_sem_in *in,
+				struct amdgpu_sem *sem);
+
+static const struct file_operations amdgpu_sem_fops;
+
+struct amdgpu_sem *amdgpu_sem_alloc(struct fence *fence)
+{
+	struct amdgpu_sem *sem;
+
+	sem = kzalloc(sizeof(struct amdgpu_sem), GFP_KERNEL);
+	if (!sem)
+		return NULL;
+
+	sem->file = anon_inode_getfile("sem_file",
+				       &amdgpu_sem_fops,
+				       sem, 0);
+	if (IS_ERR(sem->file))
+		goto err;
+
+	kref_init(&sem->kref);
+	INIT_LIST_HEAD(&sem->list);
+	/* fence should be get before passing here */
+	sem->fence = fence;
+
+	return sem;
+err:
+	kfree(sem);
+	return NULL;
+}
+EXPORT_SYMBOL(amdgpu_sem_alloc);
+
+static void amdgpu_sem_free(struct kref *kref)
+{
+	struct amdgpu_sem *sem = container_of(
+		kref, struct amdgpu_sem, kref);
+
+	fence_put(sem->fence);
+	kfree(sem);
+}
+
+static int amdgpu_sem_release(struct inode *inode, struct file *file)
+{
+	struct amdgpu_sem *sem = file->private_data;
+
+	kref_put(&sem->kref, amdgpu_sem_free);
+	return 0;
+}
+
+static unsigned int amdgpu_sem_poll(struct file *file, poll_table *wait)
+{
+	return 0;
+}
+
+static long amdgpu_sem_file_ioctl(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	return 0;
+}
+
+static const struct file_operations amdgpu_sem_fops = {
+	.release = amdgpu_sem_release,
+	.poll = amdgpu_sem_poll,
+	.unlocked_ioctl = amdgpu_sem_file_ioctl,
+	.compat_ioctl = amdgpu_sem_file_ioctl,
+};
+
+static int amdgpu_sem_create(void)
+{
+	return get_unused_fd_flags(O_CLOEXEC);
+}
+
+static int amdgpu_sem_signal(int fd, struct fence *fence)
+{
+	struct amdgpu_sem *sem;
+
+	sem = amdgpu_sem_alloc(fence);
+	if (!sem)
+		return -ENOMEM;
+	fd_install(fd, sem->file);
+
+	return 0;
+}
+
+static int amdgpu_sem_wait(int fd, struct amdgpu_fpriv *fpriv,
+			  struct drm_amdgpu_sem_in *in)
+{
+	struct file *file = fget(fd);
+	struct amdgpu_sem *sem;
+	int r;
+
+	if (!file)
+		return -EINVAL;
+
+	sem = file->private_data;
+	if (!sem) {
+		r = -EINVAL;
+		goto err;
+	}
+	r = amdgpu_sem_cring_add(fpriv, in, sem);
+err:
+	fput(file);
+	return r;
+}
+
+static void amdgpu_sem_destroy(void)
+{
+	/* userspace should close fd when they try to destroy sem,
+	 * closing fd will free sync file
+	 */
+}
+
+static struct fence *amdgpu_sem_get_fence(struct amdgpu_fpriv *fpriv,
+					 struct drm_amdgpu_sem_in *in)
+{
+	struct amdgpu_ring *out_ring;
+	struct amdgpu_ctx *ctx;
+	struct fence *fence;
+	uint32_t ctx_id, ip_type, ip_instance, ring;
+	int r;
+
+	ctx_id = in->ctx_id;
+	ip_type = in->ip_type;
+	ip_instance = in->ip_instance;
+	ring = in->ring;
+	ctx = amdgpu_ctx_get(fpriv, ctx_id);
+	if (!ctx)
+		return NULL;
+	r = amdgpu_cs_get_ring(ctx->adev, ip_type, ip_instance, ring,
+			       &out_ring);
+	if (r) {
+		amdgpu_ctx_put(ctx);
+		return NULL;
+	}
+	/* get the last fence of this entity */
+	fence = amdgpu_ctx_get_fence(ctx, out_ring,
+				     in->seq ? in->seq :
+				     ctx->rings[out_ring->idx].sequence - 1);
+	amdgpu_ctx_put(ctx);
+
+	return fence;
+}
+
+static int amdgpu_sem_cring_add(struct amdgpu_fpriv *fpriv,
+				struct drm_amdgpu_sem_in *in,
+				struct amdgpu_sem *sem)
+{
+	struct amdgpu_ring *out_ring;
+	struct amdgpu_ctx *ctx;
+	uint32_t ctx_id, ip_type, ip_instance, ring;
+	int r;
+
+	ctx_id = in->ctx_id;
+	ip_type = in->ip_type;
+	ip_instance = in->ip_instance;
+	ring = in->ring;
+	ctx = amdgpu_ctx_get(fpriv, ctx_id);
+	if (!ctx)
+		return -EINVAL;
+	r = amdgpu_cs_get_ring(ctx->adev, ip_type, ip_instance, ring,
+			       &out_ring);
+	if (r)
+		goto err;
+	mutex_lock(&ctx->rings[out_ring->idx].sem_lock);
+	list_add(&sem->list, &ctx->rings[out_ring->idx].sem_list);
+	mutex_unlock(&ctx->rings[out_ring->idx].sem_lock);
+
+err:
+	amdgpu_ctx_put(ctx);
+	return r;
+}
+
+int amdgpu_sem_add_cs(struct amdgpu_ctx *ctx, struct amdgpu_ring *ring,
+		     struct amdgpu_sync *sync)
+{
+	struct amdgpu_sem *sem, *tmp;
+	int r = 0;
+
+	if (list_empty(&ctx->rings[ring->idx].sem_list))
+		return 0;
+
+	mutex_lock(&ctx->rings[ring->idx].sem_lock);
+	list_for_each_entry_safe(sem, tmp, &ctx->rings[ring->idx].sem_list,
+				 list) {
+		r = amdgpu_sync_fence(ctx->adev, sync, sem->fence);
+		fence_put(sem->fence);
+		if (r)
+			goto err;
+		list_del(&sem->list);
+		kfree(sem);
+	}
+err:
+	mutex_unlock(&ctx->rings[ring->idx].sem_lock);
+	return r;
+}
+
+int amdgpu_sem_ioctl(struct drm_device *dev, void *data,
+		     struct drm_file *filp)
+{
+	union drm_amdgpu_sem *args = data;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct fence *fence;
+	int r = 0;
+	int fd = args->in.fd;
+
+	switch (args->in.op) {
+	case AMDGPU_SEM_OP_CREATE_SEM:
+		args->out.fd = amdgpu_sem_create();
+		break;
+	case AMDGPU_SEM_OP_WAIT_SEM:
+		r = amdgpu_sem_wait(fd, fpriv, &args->in);
+		break;
+	case AMDGPU_SEM_OP_SIGNAL_SEM:
+		fence = amdgpu_sem_get_fence(fpriv, &args->in);
+		if (IS_ERR(fence)) {
+			r = PTR_ERR(fence);
+			return r;
+		}
+		r = amdgpu_sem_signal(fd, fence);
+		fence_put(fence);
+		break;
+	case AMDGPU_SEM_OP_DESTROY_SEM:
+		amdgpu_sem_destroy();
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.h
new file mode 100644
index 0000000..56d59d3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
+ *
+ */
+
+
+#ifndef _LINUX_AMDGPU_SEM_H
+#define _LINUX_AMDGPU_SEM_H
+
+#include <linux/types.h>
+#include <linux/kref.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/fence.h>
+
+struct amdgpu_sem {
+	struct file		*file;
+	struct kref		kref;
+	struct fence            *fence;
+	struct list_head        list;
+};
+
+#endif /* _LINUX_AMDGPU_SEM_H */
diff --git a/drivers/gpu/drm/amd/include/uapi/drm/amdgpu_drm.h b/drivers/gpu/drm/amd/include/uapi/drm/amdgpu_drm.h
index 9376887..8086483 100644
--- a/drivers/gpu/drm/amd/include/uapi/drm/amdgpu_drm.h
+++ b/drivers/gpu/drm/amd/include/uapi/drm/amdgpu_drm.h
@@ -51,6 +51,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_OP		0x10
 #define DRM_AMDGPU_GEM_USERPTR		0x11
 /* hybrid specific ioctls */
+#define DRM_AMDGPU_SEM                  0x5b
 #define DRM_AMDGPU_GEM_DGMA		0x5c
 #define DRM_AMDGPU_FREESYNC		0x5d
 #define DRM_AMDGPU_WAIT_FENCES		0x5e
@@ -73,6 +74,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_FREESYNC	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FREESYNC, struct drm_amdgpu_freesync)
 #define DRM_IOCTL_AMDGPU_WAIT_FENCES	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
 #define DRM_IOCTL_AMDGPU_GEM_FIND_BO	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_FIND_BO, struct drm_amdgpu_gem_find_bo)
+#define DRM_IOCTL_AMDGPU_SEM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_SEM, union drm_amdgpu_sem)
 
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -203,6 +205,33 @@ union drm_amdgpu_ctx {
 	union drm_amdgpu_ctx_out out;
 };
 
+/* sem related */
+#define AMDGPU_SEM_OP_CREATE_SEM        1
+#define AMDGPU_SEM_OP_WAIT_SEM	        2
+#define AMDGPU_SEM_OP_SIGNAL_SEM        3
+#define AMDGPU_SEM_OP_DESTROY_SEM       4
+
+struct drm_amdgpu_sem_in {
+	/** AMDGPU_SEM_OP_* */
+	uint32_t	op;
+	int32_t         fd;
+	uint32_t	ctx_id;
+	uint32_t        ip_type;
+	uint32_t        ip_instance;
+	uint32_t        ring;
+	uint64_t        seq;
+};
+
+union drm_amdgpu_sem_out {
+	int32_t         fd;
+	uint32_t	_pad;
+};
+
+union drm_amdgpu_sem {
+	struct drm_amdgpu_sem_in in;
+	union drm_amdgpu_sem_out out;
+};
+
 /*
  * This is not a reliable API and you should expect it to fail for any
  * number of reasons and have fallback path that do not use userptr to
-- 
1.9.1


--------------080201060407020706070401
Content-Type: text/x-patch; name="0002-tests-amdgpu-add-sem-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-tests-amdgpu-add-sem-test.patch"

>From 4fe868d8927dcda425179bb4840217c23960d429 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 25 Aug 2016 17:06:37 +0800
Subject: [PATCH 2/2] tests/amdgpu: add sem test

Change-Id: Ibeb173d980a516845d4df7dd23dc54ff1c06f63a
Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
---
 tests/amdgpu/basic_tests.c | 130 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu/basic_tests.c
index e1aaffc..6cc8442 100644
--- a/tests/amdgpu/basic_tests.c
+++ b/tests/amdgpu/basic_tests.c
@@ -50,6 +50,7 @@ static void amdgpu_command_submission_sdma(void);
 static void amdgpu_command_submission_multi_fence(void);
 static void amdgpu_userptr_test(void);
 static void amdgpu_semaphore_test(void);
+static void amdgpu_sem_test(void);
 static void amdgpu_svm_test(void);
 static void amdgpu_multi_svm_test(void);
 static void amdgpu_va_range_test(void);
@@ -63,6 +64,7 @@ CU_TestInfo basic_tests[] = {
 	{ "Command submission Test (SDMA)", amdgpu_command_submission_sdma },
 	{ "Command submission Test (Multi-fence)", amdgpu_command_submission_multi_fence },
 	{ "SW semaphore Test",  amdgpu_semaphore_test },
+	{ "sem Test",  amdgpu_sem_test },
 	{ "VA range Test", amdgpu_va_range_test},
 	{ "SVM Test", amdgpu_svm_test },
 	{ "SVM Test (multi-GPUs)", amdgpu_multi_svm_test },
@@ -646,6 +648,134 @@ static void amdgpu_semaphore_test(void)
 	CU_ASSERT_EQUAL(r, 0);
 }
 
+static void amdgpu_sem_test(void)
+{
+	amdgpu_context_handle context_handle[2];
+	amdgpu_sem_handle sem;
+	amdgpu_bo_handle ib_result_handle[2];
+	void *ib_result_cpu[2];
+	uint64_t ib_result_mc_address[2];
+	struct amdgpu_cs_request ibs_request[2] = {0};
+	struct amdgpu_cs_ib_info ib_info[2] = {0};
+	struct amdgpu_cs_fence fence_status = {0};
+	uint32_t *ptr;
+	uint32_t expired;
+	amdgpu_bo_list_handle bo_list[2];
+	amdgpu_va_handle va_handle[2];
+	int r, i;
+
+	r = amdgpu_cs_create_sem(device_handle, &sem);
+	CU_ASSERT_EQUAL(r, 0);
+	for (i = 0; i < 2; i++) {
+		r = amdgpu_cs_ctx_create(device_handle, &context_handle[i]);
+		CU_ASSERT_EQUAL(r, 0);
+
+		r = amdgpu_bo_alloc_and_map(device_handle, 4096, 4096,
+					    AMDGPU_GEM_DOMAIN_GTT, 0,
+					    &ib_result_handle[i], &ib_result_cpu[i],
+					    &ib_result_mc_address[i], &va_handle[i]);
+		CU_ASSERT_EQUAL(r, 0);
+
+		r = amdgpu_get_bo_list(device_handle, ib_result_handle[i],
+				       NULL, &bo_list[i]);
+		CU_ASSERT_EQUAL(r, 0);
+	}
+	/* 1. same context different engine */
+	ptr = ib_result_cpu[0];
+	ptr[0] = SDMA_NOP;
+	ib_info[0].ib_mc_address = ib_result_mc_address[0];
+	ib_info[0].size = 1;
+
+	ibs_request[0].ip_type = AMDGPU_HW_IP_DMA;
+	ibs_request[0].number_of_ibs = 1;
+	ibs_request[0].ibs = &ib_info[0];
+	ibs_request[0].resources = bo_list[0];
+	ibs_request[0].fence_info.handle = NULL;
+	r = amdgpu_cs_submit(context_handle[0], 0,&ibs_request[0], 1);
+	CU_ASSERT_EQUAL(r, 0);
+	r = amdgpu_cs_signal_sem(device_handle, context_handle[0], AMDGPU_HW_IP_DMA, 0, 0, sem);
+	CU_ASSERT_EQUAL(r, 0);
+	r = amdgpu_cs_wait_sem(device_handle, context_handle[0], AMDGPU_HW_IP_GFX, 0, 0, sem);
+	CU_ASSERT_EQUAL(r, 0);
+	ptr = ib_result_cpu[1];
+	ptr[0] = GFX_COMPUTE_NOP;
+	ib_info[1].ib_mc_address = ib_result_mc_address[1];
+	ib_info[1].size = 1;
+
+	ibs_request[1].ip_type = AMDGPU_HW_IP_GFX;
+	ibs_request[1].number_of_ibs = 1;
+	ibs_request[1].ibs = &ib_info[1];
+	ibs_request[1].resources = bo_list[1];
+	ibs_request[1].fence_info.handle = NULL;
+
+	r = amdgpu_cs_submit(context_handle[0], 0,&ibs_request[1], 1);
+	CU_ASSERT_EQUAL(r, 0);
+
+	fence_status.context = context_handle[0];
+	fence_status.ip_type = AMDGPU_HW_IP_GFX;
+	fence_status.fence = ibs_request[1].seq_no;
+	r = amdgpu_cs_query_fence_status(&fence_status,
+					 500000000, 0, &expired);
+	CU_ASSERT_EQUAL(r, 0);
+	CU_ASSERT_EQUAL(expired, true);
+	r = amdgpu_cs_destroy_sem(device_handle, sem);
+	CU_ASSERT_EQUAL(r, 0);
+
+	/* 2. same engine different context */
+	r = amdgpu_cs_create_sem(device_handle, &sem);
+	CU_ASSERT_EQUAL(r, 0);
+	ptr = ib_result_cpu[0];
+	ptr[0] = GFX_COMPUTE_NOP;
+	ib_info[0].ib_mc_address = ib_result_mc_address[0];
+	ib_info[0].size = 1;
+
+	ibs_request[0].ip_type = AMDGPU_HW_IP_GFX;
+	ibs_request[0].number_of_ibs = 1;
+	ibs_request[0].ibs = &ib_info[0];
+	ibs_request[0].resources = bo_list[0];
+	ibs_request[0].fence_info.handle = NULL;
+	r = amdgpu_cs_submit(context_handle[0], 0,&ibs_request[0], 1);
+	CU_ASSERT_EQUAL(r, 0);
+	r = amdgpu_cs_signal_sem(device_handle, context_handle[0], AMDGPU_HW_IP_GFX, 0, 0, sem);
+	CU_ASSERT_EQUAL(r, 0);
+	r = amdgpu_cs_wait_sem(device_handle, context_handle[1], AMDGPU_HW_IP_GFX, 0, 0, sem);
+	CU_ASSERT_EQUAL(r, 0);
+	ptr = ib_result_cpu[1];
+	ptr[0] = GFX_COMPUTE_NOP;
+	ib_info[1].ib_mc_address = ib_result_mc_address[1];
+	ib_info[1].size = 1;
+
+	ibs_request[1].ip_type = AMDGPU_HW_IP_GFX;
+	ibs_request[1].number_of_ibs = 1;
+	ibs_request[1].ibs = &ib_info[1];
+	ibs_request[1].resources = bo_list[1];
+	ibs_request[1].fence_info.handle = NULL;
+	r = amdgpu_cs_submit(context_handle[1], 0,&ibs_request[1], 1);
+
+	CU_ASSERT_EQUAL(r, 0);
+
+	fence_status.context = context_handle[1];
+	fence_status.ip_type = AMDGPU_HW_IP_GFX;
+	fence_status.fence = ibs_request[1].seq_no;
+	r = amdgpu_cs_query_fence_status(&fence_status,
+					 500000000, 0, &expired);
+	CU_ASSERT_EQUAL(r, 0);
+	CU_ASSERT_EQUAL(expired, true);
+	r = amdgpu_cs_destroy_sem(device_handle, sem);
+	CU_ASSERT_EQUAL(r, 0);
+	for (i = 0; i < 2; i++) {
+		r = amdgpu_bo_unmap_and_free(ib_result_handle[i], va_handle[i],
+					     ib_result_mc_address[i], 4096);
+		CU_ASSERT_EQUAL(r, 0);
+
+		r = amdgpu_bo_list_destroy(bo_list[i]);
+		CU_ASSERT_EQUAL(r, 0);
+
+		r = amdgpu_cs_ctx_free(context_handle[i]);
+		CU_ASSERT_EQUAL(r, 0);
+	}
+}
+
 static void amdgpu_command_submission_compute(void)
 {
 	amdgpu_context_handle context_handle;
-- 
1.9.1


--------------080201060407020706070401
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------080201060407020706070401--
