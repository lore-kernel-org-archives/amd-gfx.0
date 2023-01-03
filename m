Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8948EC46467
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 14:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3C810E3E8;
	Tue,  3 Jan 2023 14:23:48 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CAC10E3E7
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 14:23:46 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id d127so25819205oif.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rF6NpjsI0k/1usx4V64O2gI1yTIw6L8Dhikle2JuPQc=;
 b=GcjL3MZfHRZ3nSiRRpEse131+qeT/IjDx+xFtAbxQvWGm8H7hW3ZzyghvwIR03vmab
 WayeZzksNrxLvDQ2fMJX2u5aV7x9Dhl2LQRfzvcF3t1xGqXowOsks++huHndqhoTkmIQ
 tGk3eP7hVbh4xBVVOhMeoddknJF2TRXTtiFOsAoTNFblZlPRIWLKgIW7YYzpsovBiYtc
 1OFlXn3QKzwFNu2D/2UPzCVYEUGC2OqVYFPK6HL7Dj/CAc07VIuo6FPsOXKhRRqyE6hL
 BRoWIXqBGysnRWABpesgZVeqrF6jkokuEKSBqma0H5vt3X8DyvixOHZuzYLVcm9t/007
 MHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rF6NpjsI0k/1usx4V64O2gI1yTIw6L8Dhikle2JuPQc=;
 b=YIuWdrXyThxfbZzpZyGyoW8DA4oWp5TzsOIuDFq24YFhPFrKO8pKkSH8vxD8Y4dIwC
 IAgZest/88OmkpOSwXvRKfqHLT3juljlej6J1eTp/NSafZZEy3uPZiIxoNkPpVRsxjWa
 kXNg3UwCpinG9YiifpGh8r4T9jFFGCXfzOsfIGHi+7Xnx11/DZVkWjA0poaFv4Y7ldoi
 O9Zz0I9wil99moVBieCnRSw+Cd/dSIACR51VTryjvpCE7kZlDhgGeoBbr+xPd0s90fVK
 siDxEI3LX9Np9MoyMPc/c9549tQxCoSaBdRZN8bDbPDXpg4jAbKoqJwCAIvNKAPw8QWB
 LLLA==
X-Gm-Message-State: AFqh2kpL9/PXPhTE6KhfxdVojTSMRz1wO8HYZpSUqQlzxYEpKitEhyFF
 sVzjLL56rAHgUzq1VilSxWn5e3scWBMVOmqsUVU=
X-Google-Smtp-Source: AMrXdXsqo+tDA2tNAp2oLuRcxrYnIwO+pVY+uGpFW5iD4SN7zuGookRD9kbFodVN9n9wnucPuz3PC4fvL3ZB/Z3RHYA=
X-Received: by 2002:a05:6808:2994:b0:35b:f5f7:3ed0 with SMTP id
 ex20-20020a056808299400b0035bf5f73ed0mr2891243oib.46.1672755825598; Tue, 03
 Jan 2023 06:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
 <43f6b308-520b-30e6-5367-98ade8202e80@amd.com>
In-Reply-To: <43f6b308-520b-30e6-5367-98ade8202e80@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Jan 2023 09:23:34 -0500
Message-ID: <CADnq5_M5v3FL-BNw-F+O8HeoBCeMMV_8H7QgBC+GvAK43P3FvQ@mail.gmail.com>
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arunpravin.paneerselvam@amd.com,
 arvind.yadav@amd.com, amd-gfx@lists.freedesktop.org,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 2, 2023 at 8:26 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 23.12.22 um 20:36 schrieb Shashank Sharma:
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
> >   include/uapi/drm/amdgpu_drm.h | 52 ++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 52 insertions(+)
> >
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 0d93ec132ebb..a3d0dd6f62c5 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -54,6 +54,7 @@ extern "C" {
> >   #define DRM_AMDGPU_VM                       0x13
> >   #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
> >   #define DRM_AMDGPU_SCHED            0x15
> > +#define DRM_AMDGPU_USERQ             0x16
> >
> >   #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >   #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> > @@ -71,6 +72,7 @@ extern "C" {
> >   #define DRM_IOCTL_AMDGPU_VM         DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_VM, union drm_amdgpu_vm)
> >   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + =
DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >   #define DRM_IOCTL_AMDGPU_SCHED              DRM_IOW(DRM_COMMAND_BASE =
+ DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> > +#define DRM_IOCTL_AMDGPU_USERQ               DRM_IOW(DRM_COMMAND_BASE =
+ DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
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
>
> We should probably note somewhere that those are inputs to the queue and
> need to be allocated by userspace somewhere.
>
> > +};
> > +
> > +struct drm_amdgpu_userq_in {
> > +     /** AMDGPU_USERQ_OP_* */
> > +     __u32   op;
> > +     /** Flags */
> > +     __u32   flags;
>
> > +     /** Context handle to associate the queue with */
> > +     __u32   ctx_id;
>
> Uff, this is just blunt nonsense. Queues are not related to ctx objects
> in any way possible.

I thought we wanted to have queues associated with contexts for
hang/guilty tracking.

Alex

>
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
>
