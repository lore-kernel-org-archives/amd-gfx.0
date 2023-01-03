Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D13C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 19:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D531410E4CC;
	Tue,  3 Jan 2023 19:51:17 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF6710E4CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 19:51:15 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 x44-20020a05683040ac00b006707c74330eso19673625ott.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9VxcJwI/fwCLfUitdoq1UoMg0DbGGLSboPod5AS4C2Q=;
 b=g+hwFOFarSY1PBwiA/BWg8SzJIyBuAbiQpxcnjurCV0Ws//cASKJdVDY1XFxZMTj6c
 glZof8We6ZKwk6sQ2biyUXswmeDecHdxLBEdFpujIn3Id+VJQeI8u7iB51rw6p14FBmW
 LhfDVlKWgW8UBFyI1dBZw6I9QxREDX+MYwgd1wFVdaG6HcpbzxyFBRD/xXK8/VOip++F
 aVvaJLGT/fk+jZHMli6HBvc/1mEwLrx7CkgkyN9ugtB15wZk5HXmFsY++yGyxjbbisn0
 wqKt2nsYOIje9LdmjVrZwHSJhH8ycbYVy4s/+b833qS5ZSLrvAxlCynGS62UPiqOwV/n
 4Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9VxcJwI/fwCLfUitdoq1UoMg0DbGGLSboPod5AS4C2Q=;
 b=tBGKQUmS358CTviGx7zR9Gv1Q9Ar+XNlrAYCEuTmdbC8IKpj3z2N4B8Mmmzjl7YxaV
 f2xld7i665vpm0zk/eu1utWCoW005ce8yDNLqoMFvE9Fqe3Imjob0bzGZntEtOiCIyLd
 TNUSa4yjFdjKNPgYbz72p+bl3kamsm4f4MPEm6AkFTior/PrnUQ7CG7OH08R7FoWDN7R
 bpLqBhxV0En3XQ+3ocei7aSjTSRcRzaVgC7miVzWTBcVCgiqvHk3ALvGIUw+DH9BC2Pa
 urNwKjy9TUrR+AjJD5gtW8qszLhEb42/YhAic93c52rQAQsfN3geswiDOMdk+zog5MpF
 j5/g==
X-Gm-Message-State: AFqh2kpIYHpwxZMjwUQKl9YprHBvxYumOovMBD20knRT67zPuweIZ5aL
 PY7WfTRVt8H++nMFE+bZrO5yscmnJqOeUdBh5Xw=
X-Google-Smtp-Source: AMrXdXspbQS7NPz3KiewoHlrNear9XpGPkAvBrea7oICc2JDtbd5lTY9hLBgNA9vKDuP8iUfFi85+h/nrLXVClpR9PQ=
X-Received: by 2002:a9d:6ac6:0:b0:671:cacb:681f with SMTP id
 m6-20020a9d6ac6000000b00671cacb681fmr2828679otq.233.1672775474970; Tue, 03
 Jan 2023 11:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
 <CAP+8YyGPy5oXpOcuWfaS1vNhGajG1VGZc4p_QiUxaLAFCtt5KQ@mail.gmail.com>
 <CADnq5_MpGojmU3WTNvvOiYie_c5WWAXbMp5W+dWx7_SHKDn9+g@mail.gmail.com>
 <360e4d69-1608-727e-3144-be6e53feec0c@gmail.com>
In-Reply-To: <360e4d69-1608-727e-3144-be6e53feec0c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Jan 2023 14:51:03 -0500
Message-ID: <CADnq5_PjzGan8os8Tf0skJieqSUMyS+KHGLMensE+Tjjft1dig@mail.gmail.com>
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Shashank Sharma <shashank.sharma@amd.com>, arunpravin.paneerselvam@amd.com,
 arvind.yadav@amd.com, amd-gfx@lists.freedesktop.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 2, 2023 at 6:27 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 27.12.22 um 17:58 schrieb Alex Deucher:
> > On Sat, Dec 24, 2022 at 3:21 PM Bas Nieuwenhuizen
> > <bas@basnieuwenhuizen.nl> wrote:
> >> On Fri, Dec 23, 2022 at 8:37 PM Shashank Sharma <shashank.sharma@amd.c=
om> wrote:
> >>> From: Alex Deucher <alexander.deucher@amd.com>
> >>>
> >>> This patch intorduces new UAPI/IOCTL for usermode graphics
> >>> queue. The userspace app will fill this structure and request
> >>> the graphics driver to add a graphics work queue for it. The
> >>> output of this UAPI is a queue id.
> >>>
> >>> This UAPI maps the queue into GPU, so the graphics app can start
> >>> submitting work to the queue as soon as the call returns.
> >>>
> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>> ---
> >>>   include/uapi/drm/amdgpu_drm.h | 52 ++++++++++++++++++++++++++++++++=
+++
> >>>   1 file changed, 52 insertions(+)
> >>>
> >>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_=
drm.h
> >>> index 0d93ec132ebb..a3d0dd6f62c5 100644
> >>> --- a/include/uapi/drm/amdgpu_drm.h
> >>> +++ b/include/uapi/drm/amdgpu_drm.h
> >>> @@ -54,6 +54,7 @@ extern "C" {
> >>>   #define DRM_AMDGPU_VM                  0x13
> >>>   #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
> >>>   #define DRM_AMDGPU_SCHED               0x15
> >>> +#define DRM_AMDGPU_USERQ               0x16
> >>>
> >>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + =
DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + =
DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >>> @@ -71,6 +72,7 @@ extern "C" {
> >>>   #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + =
DRM_AMDGPU_VM, union drm_amdgpu_vm)
> >>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE =
+ DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >>>   #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + D=
RM_AMDGPU_SCHED, union drm_amdgpu_sched)
> >>> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DR=
M_AMDGPU_USERQ, union drm_amdgpu_userq)
> >>>
> >>>   /**
> >>>    * DOC: memory domains
> >>> @@ -288,6 +290,56 @@ union drm_amdgpu_ctx {
> >>>          union drm_amdgpu_ctx_out out;
> >>>   };
> >>>
> >>> +/* user queue IOCTL */
> >>> +#define AMDGPU_USERQ_OP_CREATE 1
> >>> +#define AMDGPU_USERQ_OP_FREE   2
> >>> +
> >>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> >>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
> >> Can we document what AQL means here?
> > AQL is the packet format used by KFD/ROCm.  The idea is to be able to
> > create queues that support either format (AQL or PM4).
>
> Could we make that a separate queue type? E.g. like SDMA, GFX, Compute?
>
> It's not really a flag which can be applied independent of the queue.

I guess so, but the IP types we already expose don't different queue types:
#define AMDGPU_HW_IP_GFX          0
#define AMDGPU_HW_IP_COMPUTE      1
#define AMDGPU_HW_IP_DMA          2
#define AMDGPU_HW_IP_UVD          3
#define AMDGPU_HW_IP_VCE          4
#define AMDGPU_HW_IP_UVD_ENC      5
#define AMDGPU_HW_IP_VCN_DEC      6
/*
 * From VCN4, AMDGPU_HW_IP_VCN_ENC is re-used to support
 * both encoding and decoding jobs.
 */
#define AMDGPU_HW_IP_VCN_ENC      7
#define AMDGPU_HW_IP_VCN_JPEG     8
#define AMDGPU_HW_IP_NUM          9

I suppose we could add a new AMDGPU_HW_IP_COMPUTE_AQL.

Alex

>
> Regards,
> Christian.
>
> >
> >>
> >>> +
> >>> +struct drm_amdgpu_userq_mqd {
> >>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> >>> +       __u32   flags;
> >>> +       /** IP type: AMDGPU_HW_IP_* */
> >>> +       __u32   ip_type;
> >>> +       /** GEM object handle */
> >>> +       __u32   doorbell_handle;
> >>> +       /** Doorbell offset in dwords */
> >>> +       __u32   doorbell_offset;
> >> What are the doorbell handle/offset for? I don't see any of them used
> >> in the rest of the series (we only check the handle isn't 0, which
> >> isn't enough validation for a GEM handle to consider it valid), and
> >> the kernel seems to allocate some kind of doorbell index in patch 4.
> >> Does userspace need to know about that one? (similarly use_doorbell in
> >> that patch seems like it is never explicitly written to)
> > The doorbell is how you trigger the engine to start processing the
> > user queue.  The idea is that each user process allocates a page of
> > doorbell space (one of the PCI BARs) and then each 64 bit segment in
> > that page could be used for a user mode queue.  So the UMD writes its
> > data to the queue, updates the wptr, and then writes to the doorbell
> > to tell the firmware to start processing the queue.
> >
> >> The other questions I have are about how this interacts with memory
> >> management. Does this have access to all BOs allocated with
> >> AMDGPU_GEM_CREATE_VM_ALWAYS_VALID? What about imported BOs? How does
> >> this interact with VA unmap/map operations? (AFAICT we have no way to
> >> tell if pagetable modifying operations are complete from userspace for
> >> now). What happens if we need to spill BOs from VRAM due to
> >> (cross-process) memory pressure?
> > Effectively everything you map on the GPU would be valid.  If there is
> > memory pressure, the kernel driver will behave similarly to KFD.  It
> > will unmap the queues (which preempts all work on the engines), do any
> > memory migrations, and then map the queues again.
> >
> > Alex
> >
> >>> +       /** GPU virtual address of the queue */
> >>> +       __u64   queue_va;
> >>> +       /** Size of the queue in bytes */
> >>> +       __u64   queue_size;
> >>> +       /** GPU virtual address of the rptr */
> >>> +       __u64   rptr_va;
> >>> +       /** GPU virtual address of the wptr */
> >>> +       __u64   wptr_va;
> >>> +};
> >>> +
> >>> +struct drm_amdgpu_userq_in {
> >>> +       /** AMDGPU_USERQ_OP_* */
> >>> +       __u32   op;
> >>> +       /** Flags */
> >>> +       __u32   flags;
> >>> +       /** Context handle to associate the queue with */
> >>> +       __u32   ctx_id;
> >>> +       __u32   pad;
> >>> +       /** Queue descriptor */
> >>> +       struct drm_amdgpu_userq_mqd mqd;
> >>> +};
> >>> +
> >>> +struct drm_amdgpu_userq_out {
> >>> +       /** Queue handle */
> >>> +       __u32   q_id;
> >>> +       /** Flags */
> >>> +       __u32   flags;
> >>> +};
> >>> +
> >>> +union drm_amdgpu_userq {
> >>> +       struct drm_amdgpu_userq_in in;
> >>> +       struct drm_amdgpu_userq_out out;
> >>> +};
> >>> +
> >>>   /* vm ioctl */
> >>>   #define AMDGPU_VM_OP_RESERVE_VMID      1
> >>>   #define AMDGPU_VM_OP_UNRESERVE_VMID    2
> >>> --
> >>> 2.34.1
> >>>
>
