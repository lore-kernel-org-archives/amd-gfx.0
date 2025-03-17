Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC4FC282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4267410E15B;
	Mon, 17 Mar 2025 14:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KlaKI/uh";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF87910E15B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:38:41 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso414488a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742222321; x=1742827121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAqtaU5oACD42/QlvsiNql3rvLJ4hnVuDexEygcE9Pw=;
 b=KlaKI/uhNGmvCS6NljST4I8ac4xMcrGyO4BoFqhyyulBrgDI8P3SpvZrXMssyySkG6
 Z4mNYFSuORd4YooMTsci/ygPCrGGPvtMxoAZL8Cg8RL4b/QGjnbIDNbM/CFMOP6cgSPl
 OMz9rshTWEogjnamfwjjRxsQ5FApTGUy+T6VwcVcjz/T904ZJd4gOgkzKgUebX5OGD8n
 MKwnmPM4MBzPEkTEELTp8sL82/6bg78tNfHZU/f+ljSUDXtKuQb9DMh2WAT53b3SGI20
 rh1horjrMPFkn7RZa12O4yfPfB0rsguDvqhbedRLzwm+ChjL79rcFN/ZIR3afB8TqfVN
 auvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742222321; x=1742827121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAqtaU5oACD42/QlvsiNql3rvLJ4hnVuDexEygcE9Pw=;
 b=dlheVngOJNgyBBOAd0nWwZQceLPkuZvKHGUooM6A9zdnrumTdfRB6nE+6E1qDJyjFF
 EtwqMzo4wo08tDwNILJk5iY7h6i5DcsLLQBzEUB7IH4QcnYkx9QEPl+ZoC6IzKf/vT/F
 rhmI3SuRK8po4V0Bh0X0PqRE7+cork1mhX0oq3kcJ04qE58R+UFe6/q2bFkut6YG6NPR
 vH0Yb1BmR4ROGLRle051HLFAPQyPgxMy2r8AdTr3NFTbywT0g1raIi+LaGqSfFIvvPMu
 +VPb3zuRkFgIgn+dj+qdoES+9wEsBRAA5d9WX6pJOgGTu1mLvZqdVbhcDwpQlIFL9JL+
 k5cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXzf3XAOYw93llneAMw2eTcmWoN0RJeFGhkiSlC4XcUEkw9bGWpZTxFkUO82yD7KDXLyxWhoBv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGQlmrL04LGmQltvFvTFcaMcmtEypH0cJHWXBxNa7NAmqTab0h
 TkL6neb63CIr2z5QwYVJA5At18RN0SxSi22G1GflXe/Mg+NC5kjt+dtggazTk6ZTY2xrLbekFEb
 I6TjCknHHhLWCE3AZNZmHwkxklOE=
X-Gm-Gg: ASbGnctXGM4APh0sokNkhsRNXtNWh5yOOPYJai1Ndle7ViFmlst2E1ek0AHTm55uKBp
 +eczFNHPd2YKWv6XK8z5s7/n94YQssghV/WXlgvZ/XZSaM5qPv4iKvDGL3Qt5R/9Fuj7b3M66DN
 TZpZhTpfaqg3oR227weOcYz64DXQ==
X-Google-Smtp-Source: AGHT+IGrbgzP9rMk/aueo/55CQAdTj4xPIHtMQjUUbYegCULL1EaLSlGRGdTP3uW5Th8NroUlVWkvtd5FgJXFQXKUMc=
X-Received: by 2002:a17:90b:388e:b0:2fa:6055:17e7 with SMTP id
 98e67ed59e1d1-30151d8eb02mr6166151a91.8.1742222321241; Mon, 17 Mar 2025
 07:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250317134710.764906-1-alexander.deucher@amd.com>
 <20250317134710.764906-2-alexander.deucher@amd.com>
 <fe300995-19cd-4b60-ac63-31778ca28028@amd.com>
 <BL1PR12MB51441DF52D9DD1DF26BD6456F7DF2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <193a6fa0-de96-4b51-a90d-92960ea544a2@amd.com>
In-Reply-To: <193a6fa0-de96-4b51-a90d-92960ea544a2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Mar 2025 10:38:29 -0400
X-Gm-Features: AQ5f1JopXqKs-0HrwfSzTlhFRoXSBSmPPzh7r1vm-2jVUQviajCTPUtzUjTmY8I
Message-ID: <CADnq5_NbWQRnDERsyJ=z7khYL6_SkkjC8fQjL90026azAucQPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/sdma: guilty tracking is per instance
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Mar 17, 2025 at 10:34=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 3/17/2025 7:59 PM, Deucher, Alexander wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Monday, March 17, 2025 10:19 AM
> >> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> >> gfx@lists.freedesktop.org
> >> Subject: Re: [PATCH 2/2] drm/amdgpu/sdma: guilty tracking is per insta=
nce
> >>
> >>
> >>
> >> On 3/17/2025 7:17 PM, Alex Deucher wrote:
> >>> The gfx and page queues are per instance, so track them per instance.
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 ++++---
> >>> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 +++++++++++-------
> >>>  2 files changed, 15 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>> index 8e7e794ff136f..dc1a81c2f9af7 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >>> @@ -65,6 +65,10 @@ struct amdgpu_sdma_instance {
> >>>     uint64_t                sdma_fw_gpu_addr;
> >>>     uint32_t                *sdma_fw_ptr;
> >>>     struct mutex            engine_reset_mutex;
> >>> +   /* track guilty state of GFX and PAGE queues */
> >>> +   bool                    gfx_guilty;
> >>> +   bool                    page_guilty;
> >>> +
> >>>  };
> >>>
> >>>  enum amdgpu_sdma_ras_memory_id {
> >>> @@ -127,9 +131,6 @@ struct amdgpu_sdma {
> >>>     uint32_t                *ip_dump;
> >>>     uint32_t                supported_reset;
> >>>     struct list_head        reset_callback_list;
> >>> -   /* track guilty state of GFX and PAGE queues */
> >>> -   bool gfx_guilty;
> >>> -   bool page_guilty;
> >>>  };
> >>>
> >>>  /*
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> >>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> >>> index 927db7a080f0a..c485b582a20f6 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> >>> @@ -989,9 +989,10 @@ static int sdma_v4_4_2_inst_start(struct
> >> amdgpu_device *adev,
> >>>             uint32_t temp;
> >>>
> >>>             WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> >>> -           sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.gfx_g=
uilty);
> >>> +           sdma_v4_4_2_gfx_resume(adev, i, restore,
> >>> +adev->sdma.instance[i].gfx_guilty);
> >>>             if (adev->sdma.has_page_queue)
> >>> -                   sdma_v4_4_2_page_resume(adev, i, restore, adev-
> >>> sdma.page_guilty);
> >>> +                   sdma_v4_4_2_page_resume(adev, i, restore,
> >>> +                                           adev->sdma.instance[i].pa=
ge_guilty);
> >>
> >> I think passing the flag is no longer be required as the instance id i=
s passed already.
> >
> > We still need to determine which queue needs to be reset and restored v=
s.just reset.
> >
>
> What I meant is it can be checked from within the function -
> adev->sdma.instance[i].page_guilty. Second param identifies the instance.

oh, yeah,  Will adjust that.

Alex

>
> Thanks,
> Lijo
>
> > Alex
> >
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>>
> >>>             /* set utc l1 enable flag always to 1 */
> >>>             temp =3D RREG32_SDMA(i, regSDMA_CNTL); @@ -1446,6
> >> +1447,10 @@ static
> >>> int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
> >>>
> >>>     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> >>>             mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
> >>> +           /* Initialize guilty flags for GFX and PAGE queues */
> >>> +           adev->sdma.instance[i].gfx_guilty =3D false;
> >>> +           adev->sdma.instance[i].page_guilty =3D false;
> >>> +
> >>>             ring =3D &adev->sdma.instance[i].ring;
> >>>             ring->ring_obj =3D NULL;
> >>>             ring->use_doorbell =3D true;
> >>> @@ -1507,9 +1512,6 @@ static int sdma_v4_4_2_sw_init(struct
> >> amdgpu_ip_block *ip_block)
> >>>     r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> >>>     if (r)
> >>>             return r;
> >>> -   /* Initialize guilty flags for GFX and PAGE queues */
> >>> -   adev->sdma.gfx_guilty =3D false;
> >>> -   adev->sdma.page_guilty =3D false;
> >>>
> >>>     return r;
> >>>  }
> >>> @@ -1686,9 +1688,11 @@ static int sdma_v4_4_2_stop_queue(struct
> >> amdgpu_device *adev, uint32_t instance_
> >>>             return -EINVAL;
> >>>
> >>>     /* Check if this queue is the guilty one */
> >>> -   adev->sdma.gfx_guilty =3D sdma_v4_4_2_is_queue_selected(adev,
> >> instance_id, false);
> >>> +   adev->sdma.instance[instance_id].gfx_guilty =3D
> >>> +           sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
> >>>     if (adev->sdma.has_page_queue)
> >>> -           adev->sdma.page_guilty =3D sdma_v4_4_2_is_queue_selected(=
adev,
> >> instance_id, true);
> >>> +           adev->sdma.instance[instance_id].page_guilty =3D
> >>> +                   sdma_v4_4_2_is_queue_selected(adev, instance_id, =
true);
> >>>
> >>>     /* Cache the rptr before reset, after the reset,
> >>>     * all of the registers will be reset to 0
> >
>
