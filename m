Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD48AC3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 19:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2009910E4C7;
	Tue,  3 Jan 2023 19:22:36 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D9510E4C7
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 19:22:33 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 v15-20020a9d69cf000000b006709b5a534aso19626048oto.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 11:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8DlvEBIi/O6075pfZJpcLJxp50N0ithcW8Ga7tDj/YY=;
 b=ZU1GJ0OSph/Zobn5r/ovB4A5ABnb8EWgK1rjkJgWLVd8CLwPJOkWFm+X7rPKM2UB7j
 5Qia5TiGOI1/3PQpvkeDlwcBuFedGDMia8mFW/CVmq1ECeX2lrbchkCbjWydgzGl5zS6
 yHEi04QJXx8FhRIMubzzWD+oqUroB3XHk/xyZUEkjvVI4Wj6/1E2H2c6Flm+mFVak2Sd
 EouULmFRIcx3ECCsCfO84yDMBsIqfy8NbQG2tF6uXziKbcUULkx1ZetF0TuFx7vsS6i7
 2Sy54lrfAgK4XvFcVfrNnwwRp6m4PBg7abXaep+JjD0tVTuElsyLoarj4NiE6mp65hYP
 i4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8DlvEBIi/O6075pfZJpcLJxp50N0ithcW8Ga7tDj/YY=;
 b=MdAehH/wmey+yo5cPvsxudJ5ZopbPMZRAWzC3wP/3QQFquM4fEhih+jbMGtBgR0/F3
 w6LJXfGxAT47c4yDcggt5XCFTZ7zAQicG0HLjux2BOGzf/jKhy7+sQ2QrfG/yLtSU/Fs
 Rgz/hq6rIhqqNq68cFLzL1HnCI6f+vVwGnqQICzKlZy2piIc0d2RoIXQCAdiKtXwwIp3
 vYkTAn1wctRhgNZY6dynaQiDTl//xCQbK0g3eaQOWSKGSuQm1+XhPer935QhLEh0zKBj
 rG+v0IEOkqjCn76saez9Ptlt4EDEKsYToRphNQhHywGbhgYIJP+uh3PwFf/x1N61z9sv
 JhuA==
X-Gm-Message-State: AFqh2kq04HwTGxoxGe2Oife5jFXJA3jS0WJ2Kj+QK7gFFNbeVei4QTHW
 b9Tpwn5VIWPvy7xK1/t0sCs6tOVDj9fNSzGPU0yEdOAP
X-Google-Smtp-Source: AMrXdXuTKSLFw3XL2t1KRg2kFwQ+drhUJD2ANCP+JnljvusPCHuRVMlTCaeIGXCrsW7Uv6XzoZXfuUPJ9terfxFxHco=
X-Received: by 2002:a9d:6ac6:0:b0:671:cacb:681f with SMTP id
 m6-20020a9d6ac6000000b00671cacb681fmr2822564otq.233.1672773753036; Tue, 03
 Jan 2023 11:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
 <97583f26-81be-f6e5-ac62-45a3bca40e43@amd.com>
 <CH0PR12MB5372BF7A0FAE2CAC070D2AB9F4F49@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372BF7A0FAE2CAC070D2AB9F4F49@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Jan 2023 14:22:22 -0500
Message-ID: <CADnq5_NxBW+074+sYwuOC11wShDLFFX0Hrsa54m9fYYBWeSpPA@mail.gmail.com>
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
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
Cc: "Sharma, Shashank" <Shashank.Sharma@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Yadav,
 Arvind" <Arvind.Yadav@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 3, 2023 at 2:17 PM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hsakmt  has  the  interfaces for compute user queue. Do we want a unify API for both  graphic and compute  ?

Yeah, that is the eventual goal, hence the flag for AQL vs PM4.

Alex

>
> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
> Sent: Tuesday, January 3, 2023 1:30 PM
> To: Sharma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
> Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
>
> Am 2022-12-23 um 14:36 schrieb Shashank Sharma:
> > From: Alex Deucher <alexander.deucher@amd.com>
> >
> > This patch intorduces new UAPI/IOCTL for usermode graphics queue. The
> > userspace app will fill this structure and request the graphics driver
> > to add a graphics work queue for it. The output of this UAPI is a
> > queue id.
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
> > diff --git a/include/uapi/drm/amdgpu_drm.h
> > b/include/uapi/drm/amdgpu_drm.h index 0d93ec132ebb..a3d0dd6f62c5
> > 100644
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
> What does "secure" mean here? I don't see this flag referenced anywhere in the rest of the patch series.
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
