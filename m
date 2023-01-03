Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCA9C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 19:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3ED610E4CD;
	Tue,  3 Jan 2023 19:52:46 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7112210E4CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 19:52:43 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-12c8312131fso38029464fac.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 11:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ty9vAMQngB66V/rJnPoyowqvJvB2Fvst9Tf5/Ktv6lA=;
 b=GqALH6Z/4eze8Ie+mA7a8tkQIg6zFmbRdlOFw0Kmon6S3ZyS4CZQmILek9HB6KaEgc
 MZW0Ax7dnOPCI5EVVACE5/IDsvl7Sy6FRoPdfC0bL1kaQG6Jb8/WKpcScoUCl0iSA8Kt
 r845leZ05o3JmRLHsPSWgtuNDdUogmNKjy5LWJpUUAf4NCZecTabRC5P+05NsP23Hoyk
 D7BOOUpdRV9bk4nQtI7taXFD7n0t0D6q2txf13sMPM2FPU8m39w+WHV2xxDzydJDmwpl
 +K9RAOAkxYqkMW5FmuWvqXYithMrnWIxzZNs18+YbAjwHXKaVfmJ5ODNtcUESHIufM9j
 uNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ty9vAMQngB66V/rJnPoyowqvJvB2Fvst9Tf5/Ktv6lA=;
 b=vsJbZ/cQelFzBh+t7Dw4R9dd2op7em+F3UdPXGaJOOn9OmiobDP2iV8/r0Pq89FDO7
 uImugFtqneHYf9nypy+hu9s+mEZNDuI/ABTTY98pR7VyAYRDyRiJiDHQ+4Mix3GqWaCp
 mDzofs79PIJsPNgSIsbYm9XnIPdnBSTEPUyXHrn/SMAi9D4ShnZ7v5ZwwqIPveM8+M2Z
 oknB5z3+wIZBozrM6CHLvvyXKwiUh9E2OUtRueQ2nBlqY4zSh53d3ut+EBQZG/r7KxUQ
 qBUKlVNMgaOfNrHQa7rZ7UjTxRcUxhVuygRfz9WobmmJiBKyZUIGyU2KFfXREe42LUJ+
 fvAg==
X-Gm-Message-State: AFqh2kqppBlMettA1wc5JRwDZQTX5REeclp2tSG+rhlOmpEuS1sNsBro
 k+9rNbf/+QOQEjxt7XIg5gdWu5RqsfBdoxx2qVM=
X-Google-Smtp-Source: AMrXdXtZTe4IxQsHOy2/HoF0zAYHPHffR1NxZYTG9oJfCm5Fm67fjFHjCz0ReIaiwe0YcvcpwiE8Lgpwkb7+eI5LFbw=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr231175oab.96.1672775562671; Tue, 03
 Jan 2023 11:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
 <97583f26-81be-f6e5-ac62-45a3bca40e43@amd.com>
 <CH0PR12MB5372BF7A0FAE2CAC070D2AB9F4F49@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CADnq5_NxBW+074+sYwuOC11wShDLFFX0Hrsa54m9fYYBWeSpPA@mail.gmail.com>
 <CH0PR12MB5372F9A6C6ED7917D25EC1C4F4F49@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372F9A6C6ED7917D25EC1C4F4F49@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Jan 2023 14:52:31 -0500
Message-ID: <CADnq5_Npi92uYpKNcffh8MXB7Ks0RMkXQwSM2Pfp9TXntVsv8w@mail.gmail.com>
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
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
Cc: "Sharma, Shashank" <Shashank.Sharma@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Yadav,
 Arvind" <Arvind.Yadav@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 3, 2023 at 2:25 PM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> What about the existing rocm apps that already use the  hsakmt APIs for u=
ser queue ?

We'd have to keep both APIs around for existing chips for backwards
compatibility.

Alex

>
> Shaoyun.liu
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, January 3, 2023 2:22 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Sharma, Shashank <Shashank.=
Sharma@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexand=
er.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yadav, A=
rvind <Arvind.Yadav@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerS=
elvam@amd.com>
> Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
>
> On Tue, Jan 3, 2023 at 2:17 PM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
> >
> > [AMD Official Use Only - General]
> >
> > Hsakmt  has  the  interfaces for compute user queue. Do we want a unify=
 API for both  graphic and compute  ?
>
> Yeah, that is the eventual goal, hence the flag for AQL vs PM4.
>
> Alex
>
> >
> > Regards
> > Shaoyun.liu
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Felix Kuehling
> > Sent: Tuesday, January 3, 2023 1:30 PM
> > To: Sharma, Shashank <Shashank.Sharma@amd.com>;
> > amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>;
> > Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
> > Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
> >
> > Am 2022-12-23 um 14:36 schrieb Shashank Sharma:
> > > From: Alex Deucher <alexander.deucher@amd.com>
> > >
> > > This patch intorduces new UAPI/IOCTL for usermode graphics queue.
> > > The userspace app will fill this structure and request the graphics
> > > driver to add a graphics work queue for it. The output of this UAPI
> > > is a queue id.
> > >
> > > This UAPI maps the queue into GPU, so the graphics app can start
> > > submitting work to the queue as soon as the call returns.
> > >
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> > > ---
> > >   include/uapi/drm/amdgpu_drm.h | 52 ++++++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 52 insertions(+)
> > >
> > > diff --git a/include/uapi/drm/amdgpu_drm.h
> > > b/include/uapi/drm/amdgpu_drm.h index 0d93ec132ebb..a3d0dd6f62c5
> > > 100644
> > > --- a/include/uapi/drm/amdgpu_drm.h
> > > +++ b/include/uapi/drm/amdgpu_drm.h
> > > @@ -54,6 +54,7 @@ extern "C" {
> > >   #define DRM_AMDGPU_VM                       0x13
> > >   #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
> > >   #define DRM_AMDGPU_SCHED            0x15
> > > +#define DRM_AMDGPU_USERQ             0x16
> > >
> > >   #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM=
_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> > >   #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DRM=
_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> > > @@ -71,6 +72,7 @@ extern "C" {
> > >   #define DRM_IOCTL_AMDGPU_VM         DRM_IOWR(DRM_COMMAND_BASE + DRM=
_AMDGPU_VM, union drm_amdgpu_vm)
> > >   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE =
+ DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> > >   #define DRM_IOCTL_AMDGPU_SCHED              DRM_IOW(DRM_COMMAND_BAS=
E + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> > > +#define DRM_IOCTL_AMDGPU_USERQ               DRM_IOW(DRM_COMMAND_BAS=
E + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
> > >
> > >   /**
> > >    * DOC: memory domains
> > > @@ -288,6 +290,56 @@ union drm_amdgpu_ctx {
> > >       union drm_amdgpu_ctx_out out;
> > >   };
> > >
> > > +/* user queue IOCTL */
> > > +#define AMDGPU_USERQ_OP_CREATE       1
> > > +#define AMDGPU_USERQ_OP_FREE 2
> > > +
> > > +#define AMDGPU_USERQ_MQD_FLAGS_SECURE        (1 << 0)
> >
> > What does "secure" mean here? I don't see this flag referenced anywhere=
 in the rest of the patch series.
> >
> > Regards,
> >    Felix
> >
> >
> > > +#define AMDGPU_USERQ_MQD_FLAGS_AQL   (1 << 1)
> > > +
> > > +struct drm_amdgpu_userq_mqd {
> > > +     /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> > > +     __u32   flags;
> > > +     /** IP type: AMDGPU_HW_IP_* */
> > > +     __u32   ip_type;
> > > +     /** GEM object handle */
> > > +     __u32   doorbell_handle;
> > > +     /** Doorbell offset in dwords */
> > > +     __u32   doorbell_offset;
> > > +     /** GPU virtual address of the queue */
> > > +     __u64   queue_va;
> > > +     /** Size of the queue in bytes */
> > > +     __u64   queue_size;
> > > +     /** GPU virtual address of the rptr */
> > > +     __u64   rptr_va;
> > > +     /** GPU virtual address of the wptr */
> > > +     __u64   wptr_va;
> > > +};
> > > +
> > > +struct drm_amdgpu_userq_in {
> > > +     /** AMDGPU_USERQ_OP_* */
> > > +     __u32   op;
> > > +     /** Flags */
> > > +     __u32   flags;
> > > +     /** Context handle to associate the queue with */
> > > +     __u32   ctx_id;
> > > +     __u32   pad;
> > > +     /** Queue descriptor */
> > > +     struct drm_amdgpu_userq_mqd mqd; };
> > > +
> > > +struct drm_amdgpu_userq_out {
> > > +     /** Queue handle */
> > > +     __u32   q_id;
> > > +     /** Flags */
> > > +     __u32   flags;
> > > +};
> > > +
> > > +union drm_amdgpu_userq {
> > > +     struct drm_amdgpu_userq_in in;
> > > +     struct drm_amdgpu_userq_out out; };
> > > +
> > >   /* vm ioctl */
> > >   #define AMDGPU_VM_OP_RESERVE_VMID   1
> > >   #define AMDGPU_VM_OP_UNRESERVE_VMID 2
