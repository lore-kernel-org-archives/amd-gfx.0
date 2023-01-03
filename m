Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4087FC3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 19:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A1A10E4C6;
	Tue,  3 Jan 2023 19:18:48 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC94910E4C6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 19:18:45 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 y18-20020a0568301d9200b0067082cd4679so19643123oti.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kV4q6AWWGrMErTz2tgz2U4qCzMYT4m4V6jdxoBY8jZI=;
 b=noAXAtFzHwSRLFJnmvT8zfdpZ1PPnxLRjaayjhww7xafpL/K1zKOte7063JmKS+ypn
 xfCDS0SdyO9ywNZsUAQ/eqcLR4/9e0XAQlka4FnNa0XARDYAbBxS7B+HCeKQcP0akr5S
 CZmCbAXXdCYtZGQmzIDHLFYqTX9RZIee5UYFVpot9XCpGAKPEQeWnx0/XIEcV2Tx1kNG
 QmrGWpJBopPpYYRCKOcnXNreJY8Xo3C0bF1xthPMyJc7z0nG74mEtKV3Eyg9fV3fwLjS
 lFcCt+FsZ8ngKC7atNz+yeT1TAJsIJ1Vf62Xv06vZiXQ9mzUwOqgAdYY/WNBYT4S5nOa
 0HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kV4q6AWWGrMErTz2tgz2U4qCzMYT4m4V6jdxoBY8jZI=;
 b=HKJwREOq804JEOunQWbIHw4Kxih4cF01ML/68sEEbT5bF1fMrN6etCiSs2ckW4kvgB
 gxQ1uON3Q8IOU7iFdEevl97lTnQnNggenOXtgejDZteOfLWuZuBq5eDdrbNS/pvKUoNT
 S3Yn5GYmIm+uBfZl1xYpA/Shu8/1qvjYbhDcBtnLEfr5q15/9vUM4GN/qvv71xNUsCoG
 NQ8lu4UC9AbY1Pm5epa5STjgKEFI8D7EkJX6QDi1cHXaSBCgXCcnJodLrFonoej+YNkc
 R688pcEvtPxkKT8wqf6HHUb1by3PoJqgPUTl3MNBVqCkLZPXS3QFK6WVzCpuC5nc4COy
 /yPA==
X-Gm-Message-State: AFqh2kpR+CR0lYKiwshxrD1yQvU46FNImBsnUJ1aAoxxEn9DBqZ8aIHm
 hcuoGb9Dta9+dGvJJZZRijCQgkBi/0/KmeAcNiU=
X-Google-Smtp-Source: AMrXdXue//QlA+73zhTOUNP3wRqxHtj1wCBwHx/nsrO/rrEowUAgJUEej6eXg9v5oXzFL/vu7oQk2thucblQBPBbgkQ=
X-Received: by 2002:a9d:62d1:0:b0:675:cde9:90b9 with SMTP id
 z17-20020a9d62d1000000b00675cde990b9mr2942367otk.123.1672773524920; Tue, 03
 Jan 2023 11:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
 <97583f26-81be-f6e5-ac62-45a3bca40e43@amd.com>
In-Reply-To: <97583f26-81be-f6e5-ac62-45a3bca40e43@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Jan 2023 14:18:33 -0500
Message-ID: <CADnq5_NEfQR+9-rVEn5q5Dqk2cDcLPRXt5aiBOSjvs+_nOQdXA@mail.gmail.com>
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
To: Felix Kuehling <felix.kuehling@amd.com>
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
 arvind.yadav@amd.com, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 3, 2023 at 1:30 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2022-12-23 um 14:36 schrieb Shashank Sharma:
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
> >   include/uapi/drm/amdgpu_drm.h | 52 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 52 insertions(+)
> >
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> > index 0d93ec132ebb..a3d0dd6f62c5 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -54,6 +54,7 @@ extern "C" {
> >   #define DRM_AMDGPU_VM                       0x13
> >   #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
> >   #define DRM_AMDGPU_SCHED            0x15
> > +#define DRM_AMDGPU_USERQ             0x16
> >
> >   #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >   #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> > @@ -71,6 +72,7 @@ extern "C" {
> >   #define DRM_IOCTL_AMDGPU_VM         DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
> >   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >   #define DRM_IOCTL_AMDGPU_SCHED              DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> > +#define DRM_IOCTL_AMDGPU_USERQ               DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
> >
> >   /**
> >    * DOC: memory domains
> > @@ -288,6 +290,56 @@ union drm_amdgpu_ctx {
> >       union drm_amdgpu_ctx_out out;
> >   };
> >
> > +/* user queue IOCTL */
> > +#define AMDGPU_USERQ_OP_CREATE       1
> > +#define AMDGPU_USERQ_OP_FREE 2
> > +
> > +#define AMDGPU_USERQ_MQD_FLAGS_SECURE        (1 << 0)
>
> What does "secure" mean here? I don't see this flag referenced anywhere
> in the rest of the patch series.

It means the queue operates in secure mode (i.e. encrypted for content
protection -- TMZ in hardware parlance).

Alex

>
> Regards,
>    Felix
>
>
> > +#define AMDGPU_USERQ_MQD_FLAGS_AQL   (1 << 1)
> > +
> > +struct drm_amdgpu_userq_mqd {
> > +     /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> > +     __u32   flags;
> > +     /** IP type: AMDGPU_HW_IP_* */
> > +     __u32   ip_type;
> > +     /** GEM object handle */
> > +     __u32   doorbell_handle;
> > +     /** Doorbell offset in dwords */
> > +     __u32   doorbell_offset;
> > +     /** GPU virtual address of the queue */
> > +     __u64   queue_va;
> > +     /** Size of the queue in bytes */
> > +     __u64   queue_size;
> > +     /** GPU virtual address of the rptr */
> > +     __u64   rptr_va;
> > +     /** GPU virtual address of the wptr */
> > +     __u64   wptr_va;
> > +};
> > +
> > +struct drm_amdgpu_userq_in {
> > +     /** AMDGPU_USERQ_OP_* */
> > +     __u32   op;
> > +     /** Flags */
> > +     __u32   flags;
> > +     /** Context handle to associate the queue with */
> > +     __u32   ctx_id;
> > +     __u32   pad;
> > +     /** Queue descriptor */
> > +     struct drm_amdgpu_userq_mqd mqd;
> > +};
> > +
> > +struct drm_amdgpu_userq_out {
> > +     /** Queue handle */
> > +     __u32   q_id;
> > +     /** Flags */
> > +     __u32   flags;
> > +};
> > +
> > +union drm_amdgpu_userq {
> > +     struct drm_amdgpu_userq_in in;
> > +     struct drm_amdgpu_userq_out out;
> > +};
> > +
> >   /* vm ioctl */
> >   #define AMDGPU_VM_OP_RESERVE_VMID   1
> >   #define AMDGPU_VM_OP_UNRESERVE_VMID 2
