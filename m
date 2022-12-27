Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F83FC4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Dec 2022 16:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032D210E04D;
	Tue, 27 Dec 2022 16:58:23 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F69110E04D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 16:58:21 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1433ef3b61fso16005783fac.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 08:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AyXseZFZh5knyyF3iP8g85eQ12QVwnloyhpXOn65cKU=;
 b=FOHPUIrujIlweCY1xrUaXQY+Z/m8pCGlDXBzUa9AfCw7YFE6gM+Lg3GObCQ/+yCOg9
 3DUqihNERLVeFGBxfB1NqHli044n4qB64mWdkxWkIvZ83IbfAboGLEw6qdwBpAiUm014
 ugaqy6ZmBZdRTKwkfvv2S4i8BzDus8knJJLCSllYopZnkaYO/x/nPrv2mwsGkbVI8iqq
 8MpPynzZsMqNkfrNFWAjQz4LIwkDsajqsQjaf8jSJzJiZgHSqEx5a9UWlijKakIKbWQQ
 aYlNAAOYocIdMri90WDqYRzn4vCrEiPLsMEdExdT9Od0tSUO1pZvJVryMQ7eZN4DqJHG
 PUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AyXseZFZh5knyyF3iP8g85eQ12QVwnloyhpXOn65cKU=;
 b=M+opemTnIIgLcmxaBExETKj0GLBglo2FLU4cEM7Hlq0WYqnpBjS5Fz2whiP/9I/UGC
 GKJ9ev6rpitgr/s0EFBQ+7GqQOdQK3f9+dvy5dQLxCbPWM+2d7E+yItXNfrRVY/qEQ8N
 uYZ+r1x0vGwCMLGNwHCFh5bvLFUZ9j3onVOTgPFMFVydq77BO+GYfeYSTkzuXtlDZgEC
 2zcpJPwcr9+sKjXLGwUA3FLpbZ1dgJFlr27wiZ3/nXDdYUIBwaAxz9Su/R/qYXw0ZKSm
 RBeTY31jcRY2aFTuezpKJ/UF/adodJzLHZe8rtYYGz+L/e6tS6RP9OJI3V7yzr2XfvxP
 gg2w==
X-Gm-Message-State: AFqh2kogpv6IlgS+/qhJVKPanL7XRILDnKhvgEOCm6vXLc0hLojLCa0n
 T/GVt4SGCopNNir8bmDv80J42isK/GBRDfn4oFk=
X-Google-Smtp-Source: AMrXdXvO8dJqNXsfa1snHbWatUW7r5dUjJrfgVi6E4PD64kszc6N6Htr4JYhp5dalAS8vdVo9SJqO6blRHuG4B9u9ac=
X-Received: by 2002:a05:6871:4410:b0:14c:6b59:b014 with SMTP id
 nd16-20020a056871441000b0014c6b59b014mr1636858oab.96.1672160300459; Tue, 27
 Dec 2022 08:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
 <CAP+8YyGPy5oXpOcuWfaS1vNhGajG1VGZc4p_QiUxaLAFCtt5KQ@mail.gmail.com>
In-Reply-To: <CAP+8YyGPy5oXpOcuWfaS1vNhGajG1VGZc4p_QiUxaLAFCtt5KQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Dec 2022 11:58:09 -0500
Message-ID: <CADnq5_MpGojmU3WTNvvOiYie_c5WWAXbMp5W+dWx7_SHKDn9+g@mail.gmail.com>
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: arunpravin.paneerselvam@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Dec 24, 2022 at 3:21 PM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> On Fri, Dec 23, 2022 at 8:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
> >
> > From: Alex Deucher <alexander.deucher@amd.com>
> >
> > This patch intorduces new UAPI/IOCTL for usermode graphics
> > queue. The userspace app will fill this structure and request
> > the graphics driver to add a graphics work queue for it. The
> > output of this UAPI is a queue id.
> >
> > This UAPI maps the queue into GPU, so the graphics app can start
> > submitting work to the queue as soon as the call returns.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> > ---
> >  include/uapi/drm/amdgpu_drm.h | 52 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> > index 0d93ec132ebb..a3d0dd6f62c5 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -54,6 +54,7 @@ extern "C" {
> >  #define DRM_AMDGPU_VM                  0x13
> >  #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
> >  #define DRM_AMDGPU_SCHED               0x15
> > +#define DRM_AMDGPU_USERQ               0x16
> >
> >  #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >  #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> > @@ -71,6 +72,7 @@ extern "C" {
> >  #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
> >  #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >  #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> > +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
> >
> >  /**
> >   * DOC: memory domains
> > @@ -288,6 +290,56 @@ union drm_amdgpu_ctx {
> >         union drm_amdgpu_ctx_out out;
> >  };
> >
> > +/* user queue IOCTL */
> > +#define AMDGPU_USERQ_OP_CREATE 1
> > +#define AMDGPU_USERQ_OP_FREE   2
> > +
> > +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> > +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>
> Can we document what AQL means here?

AQL is the packet format used by KFD/ROCm.  The idea is to be able to
create queues that support either format (AQL or PM4).

>
>
> > +
> > +struct drm_amdgpu_userq_mqd {
> > +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> > +       __u32   flags;
> > +       /** IP type: AMDGPU_HW_IP_* */
> > +       __u32   ip_type;
> > +       /** GEM object handle */
> > +       __u32   doorbell_handle;
> > +       /** Doorbell offset in dwords */
> > +       __u32   doorbell_offset;
>
> What are the doorbell handle/offset for? I don't see any of them used
> in the rest of the series (we only check the handle isn't 0, which
> isn't enough validation for a GEM handle to consider it valid), and
> the kernel seems to allocate some kind of doorbell index in patch 4.
> Does userspace need to know about that one? (similarly use_doorbell in
> that patch seems like it is never explicitly written to)

The doorbell is how you trigger the engine to start processing the
user queue.  The idea is that each user process allocates a page of
doorbell space (one of the PCI BARs) and then each 64 bit segment in
that page could be used for a user mode queue.  So the UMD writes its
data to the queue, updates the wptr, and then writes to the doorbell
to tell the firmware to start processing the queue.

>
> The other questions I have are about how this interacts with memory
> management. Does this have access to all BOs allocated with
> AMDGPU_GEM_CREATE_VM_ALWAYS_VALID? What about imported BOs? How does
> this interact with VA unmap/map operations? (AFAICT we have no way to
> tell if pagetable modifying operations are complete from userspace for
> now). What happens if we need to spill BOs from VRAM due to
> (cross-process) memory pressure?

Effectively everything you map on the GPU would be valid.  If there is
memory pressure, the kernel driver will behave similarly to KFD.  It
will unmap the queues (which preempts all work on the engines), do any
memory migrations, and then map the queues again.

Alex

>
> > +       /** GPU virtual address of the queue */
> > +       __u64   queue_va;
> > +       /** Size of the queue in bytes */
> > +       __u64   queue_size;
> > +       /** GPU virtual address of the rptr */
> > +       __u64   rptr_va;
> > +       /** GPU virtual address of the wptr */
> > +       __u64   wptr_va;
> > +};
> > +
> > +struct drm_amdgpu_userq_in {
> > +       /** AMDGPU_USERQ_OP_* */
> > +       __u32   op;
> > +       /** Flags */
> > +       __u32   flags;
> > +       /** Context handle to associate the queue with */
> > +       __u32   ctx_id;
> > +       __u32   pad;
> > +       /** Queue descriptor */
> > +       struct drm_amdgpu_userq_mqd mqd;
> > +};
> > +
> > +struct drm_amdgpu_userq_out {
> > +       /** Queue handle */
> > +       __u32   q_id;
> > +       /** Flags */
> > +       __u32   flags;
> > +};
> > +
> > +union drm_amdgpu_userq {
> > +       struct drm_amdgpu_userq_in in;
> > +       struct drm_amdgpu_userq_out out;
> > +};
> > +
> >  /* vm ioctl */
> >  #define AMDGPU_VM_OP_RESERVE_VMID      1
> >  #define AMDGPU_VM_OP_UNRESERVE_VMID    2
> > --
> > 2.34.1
> >
