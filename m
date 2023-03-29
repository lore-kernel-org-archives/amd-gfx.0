Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E165CC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 19:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5373D10E53C;
	Wed, 29 Mar 2023 19:46:17 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320EA10E55A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 19:46:16 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id l18so12469859oic.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680119175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QwOgKQe27tzg+VWTCO2hW1dvLef8CJRGIFc2ESPd/8=;
 b=akBD4TXEFBZ7lf15Q6hdb/Fw7zEoHZ5azA8i7m0oQd79Pwy/ozht7IwAps9ghBrB6B
 X3oVECq25H7xGx5hZVuqGNNsbBMTEsP+//g9U0xE7bMw8rZ4HaQhDPoEvIi9zvHbfbkr
 F3tt8VKrdpoZiUS1vWwz2KkMfGm3/aeF4GH/BPTNK+/kLviD58nvd7oOyBW87qc0Skrr
 jOnLVOR1uK20tpQOr1G7fABKhrQt7sHBfB5tQZf1EDWg7Se10w0TA5Au1NbYCTKXOxjU
 FBCLln3bRshBAzmzMROyA7WRTu+T+zOiu9O42cKCRmcK16/BMfv266V6D9nkBH3zjCSW
 63Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680119175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QwOgKQe27tzg+VWTCO2hW1dvLef8CJRGIFc2ESPd/8=;
 b=IX3S/H2miaw5Fsb71nRqK2PB3x56ghM/8/3Hphyx2IV1mdBpAcSHf3wIhlOWvj13oP
 4Q1amWvCnHz5g9bL9Rmm1tz0yfDLh90Q/y1HWg9XtTPDss7rUnWbXbkcaBE80eIP2Cui
 C4p8VlnB6AaIHIQCVdjyf0bJ/YLRtVOKG8BXvGldxXhThHxdvPypIeZhwNVBELlSD8Os
 6Ep73wxudrPqaapL/62rchW+IXSA3c+6vHT9Kl7mMorNIM8PPgk6HevIlDD2QuwZ6JyK
 RSGKtW4tbgRuW2YD88o6hCyRMwMjEH9hEhhuTTyiCoUPNzP1/eN38vgUK8LBQdAAcMQw
 XrTg==
X-Gm-Message-State: AAQBX9fAcl54ndv7pX5KZpC7xoUCR5X3BH8b7GgYrstsxIy5ln+Mgz5A
 1O5BzAWEUTeTaIKbDmNsb3mKrXSycRh5irc2BQ1bNcRvmCDA5Q==
X-Google-Smtp-Source: AKy350ZpaqevhXk0dJxM0zsOuUqHB/InsAIU4DpDV61ZIY0phyhSaUOgaHoj01lE0KMIxoOZDymXnwcGaoePDVqrMBs=
X-Received: by 2002:a05:6808:15a3:b0:389:6d65:6215 with SMTP id
 t35-20020a05680815a300b003896d656215mr432071oiw.3.1680119175426; Wed, 29 Mar
 2023 12:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-2-shashank.sharma@amd.com>
 <CADnq5_PL8sVkpmEff2P03s0PRHsfsqWh1z6GtKZJCR0EDwzdjQ@mail.gmail.com>
 <fafdfdbf-bb51-54ad-7412-5c689ff5c4ce@amd.com>
In-Reply-To: <fafdfdbf-bb51-54ad-7412-5c689ff5c4ce@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Mar 2023 15:46:03 -0400
Message-ID: <CADnq5_OjMFBDRo4hWPn-OiBH1Dj+YaEQ7RP1qBVktTo+Atrdnw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] drm/amdgpu: UAPI for user queue management
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 3:21=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> Hey Alex,
>
> On 29/03/2023 19:57, Alex Deucher wrote:
> > On Wed, Mar 29, 2023 at 12:05=E2=80=AFPM Shashank Sharma
> > <shashank.sharma@amd.com> wrote:
> >> From: Alex Deucher <alexander.deucher@amd.com>
> >>
> >> This patch intorduces new UAPI/IOCTL for usermode graphics
> >> queue. The userspace app will fill this structure and request
> >> the graphics driver to add a graphics work queue for it. The
> >> output of this UAPI is a queue id.
> >>
> >> This UAPI maps the queue into GPU, so the graphics app can start
> >> submitting work to the queue as soon as the call returns.
> >>
> >> V2: Addressed review comments from Alex and Christian
> >>      - Make the doorbell offset's comment clearer
> >>      - Change the output parameter name to queue_id
> >> V3: Integration with doorbell manager
> >>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >> ---
> >>   include/uapi/drm/amdgpu_drm.h | 55 +++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 55 insertions(+)
> >>
> >> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_d=
rm.h
> >> index cc5d551abda5..e4943099b9d2 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -54,6 +54,7 @@ extern "C" {
> >>   #define DRM_AMDGPU_VM                  0x13
> >>   #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
> >>   #define DRM_AMDGPU_SCHED               0x15
> >> +#define DRM_AMDGPU_USERQ               0x16
> >>
> >>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + D=
RM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + D=
RM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >> @@ -71,6 +72,7 @@ extern "C" {
> >>   #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + D=
RM_AMDGPU_VM, union drm_amdgpu_vm)
> >>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >>   #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DR=
M_AMDGPU_SCHED, union drm_amdgpu_sched)
> >> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM=
_AMDGPU_USERQ, union drm_amdgpu_userq)
> >>
> >>   /**
> >>    * DOC: memory domains
> >> @@ -307,6 +309,59 @@ union drm_amdgpu_ctx {
> >>          union drm_amdgpu_ctx_out out;
> >>   };
> >>
> >> +/* user queue IOCTL */
> >> +#define AMDGPU_USERQ_OP_CREATE 1
> >> +#define AMDGPU_USERQ_OP_FREE   2
> >> +
> >> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> >> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
> >> +
> >> +struct drm_amdgpu_userq_mqd {
> >> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> >> +       __u32   flags;
> >> +       /** IP type: AMDGPU_HW_IP_* */
> >> +       __u32   ip_type;
> >> +       /** GEM object handle */
> >> +       __u32   doorbell_handle;
> >> +       /** Doorbell's offset in the doorbell bo */
> >> +       __u32   doorbell_offset;
> >> +       /** GPU virtual address of the queue */
> >> +       __u64   queue_va;
> >> +       /** Size of the queue in bytes */
> >> +       __u64   queue_size;
> >> +       /** GPU virtual address of the rptr */
> >> +       __u64   rptr_va;
> >> +       /** GPU virtual address of the wptr */
> >> +       __u64   wptr_va;
> >> +       /** GPU virtual address of the shadow context space */
> >> +       __u64   shadow_va;
> >> +};
> > We may want to make the MQD engine specific.  E.g., shadow is gfx
> > specific.  We also probably need the csa and gds buffers for gfx as
> > well.  Other engines may have their own additional buffer
> > requirements.
> >
> > Alex
>
> Sure, we can call it drm_amdgpu_userq_mqd_gfx to clarify that this MQD
> is specific to GFX engine.

We can make it a union and then add additional entries for SDMA,
compute, and VCN.  We should also move the IP type into struct
drm_amdgpu_userq_in so we know how to interpret the union.  Or make it
a u64 and handle it similarly to the chunks interface in
drm_amdgpu_cs_chunk.

Alex

>
> - Shashank
>
> >
> >
> >> +
> >> +struct drm_amdgpu_userq_in {
> >> +       /** AMDGPU_USERQ_OP_* */
> >> +       __u32   op;
> >> +       /** Flags */
> >> +       __u32   flags;
> >> +       /** Queue handle to associate the queue free call with,
> >> +        * unused for queue create calls */
> >> +       __u32   queue_id;
> >> +       __u32   pad;
> >> +       /** Queue descriptor */
> >> +       struct drm_amdgpu_userq_mqd mqd;
> >> +};
> >> +
> >> +struct drm_amdgpu_userq_out {
> >> +       /** Queue handle */
> >> +       __u32   queue_id;
> >> +       /** Flags */
> >> +       __u32   flags;
> >> +};
> >> +
> >> +union drm_amdgpu_userq {
> >> +       struct drm_amdgpu_userq_in in;
> >> +       struct drm_amdgpu_userq_out out;
> >> +};
> >> +
> >>   /* vm ioctl */
> >>   #define AMDGPU_VM_OP_RESERVE_VMID      1
> >>   #define AMDGPU_VM_OP_UNRESERVE_VMID    2
> >> --
> >> 2.40.0
> >>
