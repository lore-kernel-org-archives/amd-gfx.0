Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E1CC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 13:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA4310FE7B;
	Thu,  2 May 2024 13:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VlIFbFWI";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516E010FCB9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 13:52:12 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so1396508a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714657932; x=1715262732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+r7cfcQAD25/L/Qh6KOpo7lUQpAZKQ3fAs70iIDomY=;
 b=VlIFbFWIKeNDvVB8jTtndY/mbaFO4p2AWnEpjc9/4PzeC/RsafF9ISrn/mP5n56/eK
 qBSDCjXFsVvq3EgT2oI+rhEY+hxscrg/RXAxWG0CXKwk/noXs0/45ETfgdB5cMbHX6bU
 DrTYsZ9ptQz5ISZjNhzudAJHhqZnrKMLK0KsXLmiQueQHSfgmg4b8+KoZK920WPB82zO
 ZluUfYfgWbzd2OHGPHZrCrHZ+3Fm7jhTuv7AspOUSDr6AY/4OXw4HjCgoGBAHWweFy7y
 uAg0imq7emUH4KrQnkp51RUmvuN9GGL4XdxfiBVkgkvYN1jvD4yBIJa71fX+ojAtlBqF
 kiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714657932; x=1715262732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+r7cfcQAD25/L/Qh6KOpo7lUQpAZKQ3fAs70iIDomY=;
 b=r6iho14z0XrH8InCwlLlXKpi/9n1YpT42JMJv4D8Z/gz+M/QXN+VCWMwXCiVu1cAxB
 jgQrCV13gL4Nwhlxqf0IIXMv6QHV7bo7IBDmClK+nux2RYskYxaW9O9fPk1mhGcnLb+M
 /wmb50ytTPXQK+TGjIobBve5ZiDLaodQmF/2YTlH7OZndqCKVMjUmXasqGV4fcLSNmXb
 1rw4NEN6CWNTRrUYLPzmozkOKAU8ntRE3aB4yqHB6ChvFm4GnosVF/iMhxtp9GSPJiDT
 cU3pdDOGh8xABr1meZqycaDwzXXIIxIouZiVBLeXxyrz28zV+4v3Y/smEOzIOf9JadC5
 li3A==
X-Gm-Message-State: AOJu0Yxg1g/enClcuOJ9PdF99qI7hJ8bW28y4XxV8r6S+kYbXUDxmOJG
 pT+SxesZt8IktlFZbKJPGPr1yLQaV3mKYOu2jXgXJNPkFKRQYpF2IEvT9SLxke2w9EFqx9YFv6t
 AHxyt6i/Rsx3HeN35GpdRRqjc56WNbA==
X-Google-Smtp-Source: AGHT+IFfN1ezxWIofcXchSpFk6PziIZIFaTyLjxGQoZbPSeUak24bPMd0iq/lgpO96Pd2DXLYexsrIes2ZqzM7Qis0E=
X-Received: by 2002:a17:90a:ba01:b0:2ab:454f:a00f with SMTP id
 s1-20020a17090aba0100b002ab454fa00fmr4342555pjr.9.1714657931507; Thu, 02 May
 2024 06:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-2-shashank.sharma@amd.com>
 <CADnq5_ML3xvC1-vP7AO5byS8oxq8_vayrsoWVghUhzqeCabUxQ@mail.gmail.com>
 <39458665-6f59-305c-5b47-70eb1072213c@amd.com>
 <09bd21a0-d796-ad41-da12-38ef611c5607@amd.com>
In-Reply-To: <09bd21a0-d796-ad41-da12-38ef611c5607@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 May 2024 09:52:00 -0400
Message-ID: <CADnq5_MvAistC80PA7ZqCfsrhxEVTm=rFeUi=Mz7OMb65gD9mA@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] drm/amdgpu: UAPI for user queue management
To: "Sharma, Shashank" <shashank.sharma@amd.com>
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

On Thu, May 2, 2024 at 8:53=E2=80=AFAM Sharma, Shashank <shashank.sharma@am=
d.com> wrote:
>
>
> On 02/05/2024 07:23, Sharma, Shashank wrote:
> > Hey Alex,
> >
> > On 01/05/2024 22:39, Alex Deucher wrote:
> >> On Fri, Apr 26, 2024 at 10:07=E2=80=AFAM Shashank Sharma
> >> <shashank.sharma@amd.com> wrote:
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
> >>> V2: Addressed review comments from Alex and Christian
> >>>      - Make the doorbell offset's comment clearer
> >>>      - Change the output parameter name to queue_id
> >>>
> >>> V3: Integration with doorbell manager
> >>>
> >>> V4:
> >>>      - Updated the UAPI doc (Pierre-Eric)
> >>>      - Created a Union for engine specific MQDs (Alex)
> >>>      - Added Christian's R-B
> >>> V5:
> >>>      - Add variables for GDS and CSA in MQD structure (Alex)
> >>>      - Make MQD data a ptr-size pair instead of union (Alex)
> >>>
> >>> V9:
> >>>     - renamed struct drm_amdgpu_userq_mqd_gfx_v11 to struct
> >>>       drm_amdgpu_userq_mqd as its being used for SDMA and
> >>>       compute queues as well
> >>>
> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>> ---
> >>>   include/uapi/drm/amdgpu_drm.h | 110
> >>> ++++++++++++++++++++++++++++++++++
> >>>   1 file changed, 110 insertions(+)
> >>>
> >>> diff --git a/include/uapi/drm/amdgpu_drm.h
> >>> b/include/uapi/drm/amdgpu_drm.h
> >>> index 96e32dafd4f0..22f56a30f7cb 100644
> >>> --- a/include/uapi/drm/amdgpu_drm.h
> >>> +++ b/include/uapi/drm/amdgpu_drm.h
> >>> @@ -54,6 +54,7 @@ extern "C" {
> >>>   #define DRM_AMDGPU_VM                  0x13
> >>>   #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
> >>>   #define DRM_AMDGPU_SCHED               0x15
> >>> +#define DRM_AMDGPU_USERQ               0x16
> >>>
> >>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE +
> >>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE +
> >>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >>> @@ -71,6 +72,7 @@ extern "C" {
> >>>   #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE +
> >>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
> >>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE
> >>> + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >>>   #define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE +
> >>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> >>> +#define DRM_IOCTL_AMDGPU_USERQ DRM_IOW(DRM_COMMAND_BASE +
> >>> DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
> >>>
> >>>   /**
> >>>    * DOC: memory domains
> >>> @@ -317,6 +319,114 @@ union drm_amdgpu_ctx {
> >>>          union drm_amdgpu_ctx_out out;
> >>>   };
> >>>
> >>> +/* user queue IOCTL */
> >>> +#define AMDGPU_USERQ_OP_CREATE 1
> >>> +#define AMDGPU_USERQ_OP_FREE   2
> >>> +
> >>> +/* Flag to indicate secure buffer related workload, unused for now *=
/
> >>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> >>> +/* Flag to indicate AQL workload, unused for now */
> >>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
> >>> +
> >>> +/*
> >>> + * MQD (memory queue descriptor) is a set of parameters which allow
> >>> + * the GPU to uniquely define and identify a usermode queue. This
> >>> + * structure defines the MQD for GFX-V11 IP ver 0.
> >>> + */
> >>> +struct drm_amdgpu_userq_mqd {
> >> Maybe rename this to drm_amdgpu_gfx_userq_mqd since it's gfx specific.
> >> Then we can add different MQDs for SDMA, compute, etc. as they have
> >> different metadata.  E.g., the shadow and CSA are gfx only.
> >
> >
> > Actually this was named drm_amdgpu_userq_mqd_gfx_v11_0 until the last
> > patchset, but then I realized that apart from the objects (gds/shadow
> > va) nothing is gfx specific, its actually required for every userqueue
> > IP which is MES based, so I thought it would be an overkill to create
> > multiple structures for almost the same data. If you feel strong about
> > this, I can change it again.
> >
> > - Shashank
>
>
> Please ignore my last comment, I understand what you are mentioning, and
> I have reformatted the patches accordingly. Now, I am keeping everything
> reqd for MES in one basic struture (drm_amdgpu_userq_in) and creating
> drm_amdgpu_userq_mqd_gfx_v11 for GFX specific things (like CSA, Shadow
> and GDS areas). Now there will be one separate patch which will enabled
> GFX_IP on MES code, just like how we have separate patches for SDMA and
> Compute IP in this series.  I will send the V10 patches with this
> reformatting in some time.

Yeah, we just need to make it clear to userspace what buffers are
necessary for which ring type.

Alex

>
> - Shashank
>
> >
> >> Alex
> >>
> >>
> >>> +       /**
> >>> +        * @queue_va: Virtual address of the GPU memory which holds
> >>> the queue
> >>> +        * object. The queue holds the workload packets.
> >>> +        */
> >>> +       __u64   queue_va;
> >>> +       /**
> >>> +        * @queue_size: Size of the queue in bytes, this needs to be
> >>> 256-byte
> >>> +        * aligned.
> >>> +        */
> >>> +       __u64   queue_size;
> >>> +       /**
> >>> +        * @rptr_va : Virtual address of the GPU memory which holds
> >>> the ring RPTR.
> >>> +        * This object must be at least 8 byte in size and aligned
> >>> to 8-byte offset.
> >>> +        */
> >>> +       __u64   rptr_va;
> >>> +       /**
> >>> +        * @wptr_va : Virtual address of the GPU memory which holds
> >>> the ring WPTR.
> >>> +        * This object must be at least 8 byte in size and aligned
> >>> to 8-byte offset.
> >>> +        *
> >>> +        * Queue, RPTR and WPTR can come from the same object, as
> >>> long as the size
> >>> +        * and alignment related requirements are met.
> >>> +        */
> >>> +       __u64   wptr_va;
> >>> +       /**
> >>> +        * @shadow_va: Virtual address of the GPU memory to hold the
> >>> shadow buffer.
> >>> +        * This must be a from a separate GPU object, and must be at
> >>> least 4-page
> >>> +        * sized.
> >>> +        */
> >>> +       __u64   shadow_va;
> >>> +       /**
> >>> +        * @gds_va: Virtual address of the GPU memory to hold the
> >>> GDS buffer.
> >>> +        * This must be a from a separate GPU object, and must be at
> >>> least 1-page
> >>> +        * sized.
> >>> +        */
> >>> +       __u64   gds_va;
> >>> +       /**
> >>> +        * @csa_va: Virtual address of the GPU memory to hold the
> >>> CSA buffer.
> >>> +        * This must be a from a separate GPU object, and must be at
> >>> least 1-page
> >>> +        * sized.
> >>> +        */
> >>> +       __u64   csa_va;
> >>> +};
> >>> +
> >>> +struct drm_amdgpu_userq_in {
> >>> +       /** AMDGPU_USERQ_OP_* */
> >>> +       __u32   op;
> >>> +       /** Queue handle for USERQ_OP_FREE */
> >>> +       __u32   queue_id;
> >>> +       /** the target GPU engine to execute workload
> >>> (AMDGPU_HW_IP_*) */
> >>> +       __u32   ip_type;
> >>> +       /**
> >>> +        * @flags: flags to indicate special function for queue like
> >>> secure
> >>> +        * buffer (TMZ). Unused for now.
> >>> +        */
> >>> +       __u32   flags;
> >>> +       /**
> >>> +        * @doorbell_handle: the handle of doorbell GEM object
> >>> +        * associated to this client.
> >>> +        */
> >>> +       __u32   doorbell_handle;
> >>> +       /**
> >>> +        * @doorbell_offset: 32-bit offset of the doorbell in the
> >>> doorbell bo.
> >>> +        * Kernel will generate absolute doorbell offset using
> >>> doorbell_handle
> >>> +        * and doorbell_offset in the doorbell bo.
> >>> +        */
> >>> +       __u32   doorbell_offset;
> >>> +       /**
> >>> +        * @mqd: Queue descriptor for USERQ_OP_CREATE
> >>> +        * MQD data can be of different size for different GPU
> >>> IP/engine and
> >>> +        * their respective versions/revisions, so this points to a
> >>> __u64 *
> >>> +        * which holds MQD of this usermode queue.
> >>> +        */
> >>> +       __u64 mqd;
> >>> +       /**
> >>> +        * @size: size of MQD data in bytes, it must match the MQD
> >>> structure
> >>> +        * size of the respective engine/revision defined in UAPI
> >>> for ex, for
> >>> +        * gfx_v11 workloads, size =3D
> >>> sizeof(drm_amdgpu_userq_mqd_gfx_v11).
> >>> +        */
> >>> +       __u64 mqd_size;
> >>> +};
> >>> +
> >>> +struct drm_amdgpu_userq_out {
> >>> +       /** Queue handle */
> >>> +       __u32   queue_id;
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
> >>> 2.43.2
> >>>
