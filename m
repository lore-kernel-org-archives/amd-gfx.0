Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE70C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 20:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D65E10EADA;
	Wed,  1 May 2024 20:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TEaphGwT";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F4D10EADA
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 20:39:29 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-60274726da6so4854262a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 May 2024 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714595969; x=1715200769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SM/GgoNLp2YPVW7cEEoAHxak1zV1pA0ANSm6FJfAUdA=;
 b=TEaphGwTqLQErgIkmj5x9vVpsiUsiXF9pho+UhzgEqHo/ZlKVNY+Kc4duy4r/gE5JZ
 STweP2Or+4HV08I2g/EUuKgMAZdsUEGiVO2kySX/jZoDxzuNZAFoRzH+OQNh9KEr8k6A
 2RhPFp/JloEYC1K7ed5eDa7pGFbcYng1sYcAdH6tnzOv0hIQtzs4o/6PinaSIKYEDq5q
 0GTQep8AKh9DQHtElYeDZVL9/RxjHCVnRi6F9IsEvtnA29rb8Wgi9JET1Hrkuh/erXb1
 5AJUIh8Xp+b0o0RIpnlx6psmj8bdghH4Y+2uzFCu3uINaK0FC5BZVdH6q0pF/z8H1BV0
 Rbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714595969; x=1715200769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SM/GgoNLp2YPVW7cEEoAHxak1zV1pA0ANSm6FJfAUdA=;
 b=F0GJOUvLjxNXesC4LxDFv4VBZBKI2eBjRpmjDWpWkNED+7xiBxbWRVgNI4Lx62WL8E
 7VkSTN6+rq78p5Z6DnVKhsaoYFAA1918LDfYKdPnGqRFvUP7QW0eTIN2K8fTf2/tTCot
 zDUpui3Oyk/n2epsZzcCM1rIxPMk2kug9U1+00mp41b2wj8x46fejWA2FWLZHdo5VHwI
 9lVokC3+v3ml/KpU3Rj4NujIZtwedQCH/naXX5JqNiZB8ZfGuzy1mQOH50yNATO26nxK
 47A5vC8LUyM/cWWYY9jgcCjy5HkhOOEOvJ33KHrxVohwwbMUDgig7oievAtRFrk1KegD
 5Dzw==
X-Gm-Message-State: AOJu0Yy+GYBUzQKX6bMJ/OzPJF+6LUQO9IjrkwJ3Mi/7B3v4PRfdc2En
 fJnIQVPN3zZdSukLiFL3HNPAUW5e7jwtefZvzaGWq5RMnSbYKiRSSuT2kmgWzpWgLxzkZVy38JY
 vgzoDJ+yQfWe+bic/MnayJePCEvq+uw==
X-Google-Smtp-Source: AGHT+IFpy0e777idgcD1V+NcsPsSholVV5hYVWtonZV3Mwmmz+mKxo56scf+Bb1UShO/T4HreWTFfhWRUgmAGrJ1wMo=
X-Received: by 2002:a17:90b:149:b0:2a5:3753:6050 with SMTP id
 em9-20020a17090b014900b002a537536050mr3606811pjb.46.1714595968789; Wed, 01
 May 2024 13:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-2-shashank.sharma@amd.com>
In-Reply-To: <20240426134810.1250-2-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 May 2024 16:39:17 -0400
Message-ID: <CADnq5_ML3xvC1-vP7AO5byS8oxq8_vayrsoWVghUhzqeCabUxQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] drm/amdgpu: UAPI for user queue management
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 26, 2024 at 10:07=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch intorduces new UAPI/IOCTL for usermode graphics
> queue. The userspace app will fill this structure and request
> the graphics driver to add a graphics work queue for it. The
> output of this UAPI is a queue id.
>
> This UAPI maps the queue into GPU, so the graphics app can start
> submitting work to the queue as soon as the call returns.
>
> V2: Addressed review comments from Alex and Christian
>     - Make the doorbell offset's comment clearer
>     - Change the output parameter name to queue_id
>
> V3: Integration with doorbell manager
>
> V4:
>     - Updated the UAPI doc (Pierre-Eric)
>     - Created a Union for engine specific MQDs (Alex)
>     - Added Christian's R-B
> V5:
>     - Add variables for GDS and CSA in MQD structure (Alex)
>     - Make MQD data a ptr-size pair instead of union (Alex)
>
> V9:
>    - renamed struct drm_amdgpu_userq_mqd_gfx_v11 to struct
>      drm_amdgpu_userq_mqd as its being used for SDMA and
>      compute queues as well
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 110 ++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 96e32dafd4f0..22f56a30f7cb 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -54,6 +54,7 @@ extern "C" {
>  #define DRM_AMDGPU_VM                  0x13
>  #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>  #define DRM_AMDGPU_SCHED               0x15
> +#define DRM_AMDGPU_USERQ               0x16
>
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -71,6 +72,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_VM, union drm_amdgpu_vm)
>  #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM=
_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>  #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AM=
DGPU_SCHED, union drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AM=
DGPU_USERQ, union drm_amdgpu_userq)
>
>  /**
>   * DOC: memory domains
> @@ -317,6 +319,114 @@ union drm_amdgpu_ctx {
>         union drm_amdgpu_ctx_out out;
>  };
>
> +/* user queue IOCTL */
> +#define AMDGPU_USERQ_OP_CREATE 1
> +#define AMDGPU_USERQ_OP_FREE   2
> +
> +/* Flag to indicate secure buffer related workload, unused for now */
> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> +/* Flag to indicate AQL workload, unused for now */
> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
> +
> +/*
> + * MQD (memory queue descriptor) is a set of parameters which allow
> + * the GPU to uniquely define and identify a usermode queue. This
> + * structure defines the MQD for GFX-V11 IP ver 0.
> + */
> +struct drm_amdgpu_userq_mqd {

Maybe rename this to drm_amdgpu_gfx_userq_mqd since it's gfx specific.
Then we can add different MQDs for SDMA, compute, etc. as they have
different metadata.  E.g., the shadow and CSA are gfx only.

Alex


> +       /**
> +        * @queue_va: Virtual address of the GPU memory which holds the q=
ueue
> +        * object. The queue holds the workload packets.
> +        */
> +       __u64   queue_va;
> +       /**
> +        * @queue_size: Size of the queue in bytes, this needs to be 256-=
byte
> +        * aligned.
> +        */
> +       __u64   queue_size;
> +       /**
> +        * @rptr_va : Virtual address of the GPU memory which holds the r=
ing RPTR.
> +        * This object must be at least 8 byte in size and aligned to 8-b=
yte offset.
> +        */
> +       __u64   rptr_va;
> +       /**
> +        * @wptr_va : Virtual address of the GPU memory which holds the r=
ing WPTR.
> +        * This object must be at least 8 byte in size and aligned to 8-b=
yte offset.
> +        *
> +        * Queue, RPTR and WPTR can come from the same object, as long as=
 the size
> +        * and alignment related requirements are met.
> +        */
> +       __u64   wptr_va;
> +       /**
> +        * @shadow_va: Virtual address of the GPU memory to hold the shad=
ow buffer.
> +        * This must be a from a separate GPU object, and must be at leas=
t 4-page
> +        * sized.
> +        */
> +       __u64   shadow_va;
> +       /**
> +        * @gds_va: Virtual address of the GPU memory to hold the GDS buf=
fer.
> +        * This must be a from a separate GPU object, and must be at leas=
t 1-page
> +        * sized.
> +        */
> +       __u64   gds_va;
> +       /**
> +        * @csa_va: Virtual address of the GPU memory to hold the CSA buf=
fer.
> +        * This must be a from a separate GPU object, and must be at leas=
t 1-page
> +        * sized.
> +        */
> +       __u64   csa_va;
> +};
> +
> +struct drm_amdgpu_userq_in {
> +       /** AMDGPU_USERQ_OP_* */
> +       __u32   op;
> +       /** Queue handle for USERQ_OP_FREE */
> +       __u32   queue_id;
> +       /** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
> +       __u32   ip_type;
> +       /**
> +        * @flags: flags to indicate special function for queue like secu=
re
> +        * buffer (TMZ). Unused for now.
> +        */
> +       __u32   flags;
> +       /**
> +        * @doorbell_handle: the handle of doorbell GEM object
> +        * associated to this client.
> +        */
> +       __u32   doorbell_handle;
> +       /**
> +        * @doorbell_offset: 32-bit offset of the doorbell in the doorbel=
l bo.
> +        * Kernel will generate absolute doorbell offset using doorbell_h=
andle
> +        * and doorbell_offset in the doorbell bo.
> +        */
> +       __u32   doorbell_offset;
> +       /**
> +        * @mqd: Queue descriptor for USERQ_OP_CREATE
> +        * MQD data can be of different size for different GPU IP/engine =
and
> +        * their respective versions/revisions, so this points to a __u64=
 *
> +        * which holds MQD of this usermode queue.
> +        */
> +       __u64 mqd;
> +       /**
> +        * @size: size of MQD data in bytes, it must match the MQD struct=
ure
> +        * size of the respective engine/revision defined in UAPI for ex,=
 for
> +        * gfx_v11 workloads, size =3D sizeof(drm_amdgpu_userq_mqd_gfx_v1=
1).
> +        */
> +       __u64 mqd_size;
> +};
> +
> +struct drm_amdgpu_userq_out {
> +       /** Queue handle */
> +       __u32   queue_id;
> +       /** Flags */
> +       __u32   flags;
> +};
> +
> +union drm_amdgpu_userq {
> +       struct drm_amdgpu_userq_in in;
> +       struct drm_amdgpu_userq_out out;
> +};
> +
>  /* vm ioctl */
>  #define AMDGPU_VM_OP_RESERVE_VMID      1
>  #define AMDGPU_VM_OP_UNRESERVE_VMID    2
> --
> 2.43.2
>
