Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833A3D30008
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 13:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D5110E1A1;
	Fri, 18 Oct 2024 13:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CTosD4w8";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2207D10E1A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 13:23:13 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2e2ab5bbc01so300835a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729257792; x=1729862592; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1enGlvy2SdEJ3WTfhO1Io9V1ZHxjfZrboQ37ohKiYSA=;
 b=CTosD4w8xNhi7NCiS+7M6PWmxhCkzYi6i4oZWjWS2uyB/cP2WnJ5nbPYBXWmvUrqiF
 90sV+B/u16WvCNt01Dll5TOpPkEOVXmLSeJ7Wrg2C0RiSowDLaQFzhFhGXvNb+sfTlXx
 wFFTIC4UhIPMAOvmtMbLSe1kM58i6saH87uFX1IbljF8wrB52gdHFob10wEub5U5MZCX
 pBv9w6Av6Byrj8R6+++e4wY9FeBOahnxsJJZVDcZN1tojOIV8lHMIQiGurzGWhVVB6EJ
 pFwPmSJGSav4v5wmIWIJVnTCLgvEy/zBoNLVGU4/kewTsjg5x+wxi7pqgnYopC4QIJYE
 fdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729257792; x=1729862592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1enGlvy2SdEJ3WTfhO1Io9V1ZHxjfZrboQ37ohKiYSA=;
 b=hrgPYCb6smBYRl/2jS32zLWKdmdLhd6+s+nE+jCoHr9F4BIVg+w+b28y+oRUc/6moL
 rdSik7lYVCYWfpjs8KQjWev/IXawZaVxq+5X+UbdcbSNNAJAjwGzKm8SDsITA/C2DOA/
 txKHiPsT7nkOCEwAqtninhupr+OcUkR4wcG4nK0dkEymGQbJcyrZKvx3k0eTjrlY9tzj
 rrYCwiGTyrgDFSEs3Vg2hNVDu9OtUPqi/lWTU60ObnjLkVr15UORUHqbx0bl5zZ+u7hq
 K7+GTJRKYXoz0l0dp3JqfUZOh451d4ApCxD4dBjF/mVq276fn3aY4Xi+BkOxORFmhfyO
 DcsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW89SotWFO0KjeFK9GIog7jkUphiMzoLCzdmncak5s0urVgLZevhNN7y08IQp51N2G83NFK3/e1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVkCVbIUE4uLstts6N88jp1T6HSQbWjnLYI726lgEJriFaLm73
 f1+Z/dEveR9P6tlEhi0dxXEmp7fmI4nfIvVTaMz2uqzHqlkGUEFT23r3TcTPPKK8FKlRrizFgXK
 FdjgaLRG4ah9ixkT0i9QTTwgZgWP8i8fr
X-Google-Smtp-Source: AGHT+IFtiprfz2BSax6fAIrx3E/E20EFMN33sA2i1T+938YNkpMz9A5fXLlvoX3kJcWSfOU9mAMaOOwJzLpxued0vBE=
X-Received: by 2002:a17:90a:e607:b0:2e1:682b:361e with SMTP id
 98e67ed59e1d1-2e5616eb630mr1308226a91.4.1729257792555; Fri, 18 Oct 2024
 06:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241018081934.2185681-1-jesse.zhang@amd.com>
 <5963f22c-eba6-4c9a-a341-a5a1b6d45f37@amd.com>
 <DM4PR12MB51521F1CA0607071EE23EDC8E3402@DM4PR12MB5152.namprd12.prod.outlook.com>
 <fc91c475-1c9c-4835-a203-86f0cec6198c@amd.com>
In-Reply-To: <fc91c475-1c9c-4835-a203-86f0cec6198c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Oct 2024 09:23:00 -0400
Message-ID: <CADnq5_P5UMoJw+NK48uT5AKDSd1E_j_AZ_N6SijQ5CkiknXFow@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add the command AMDGPU_INFO_QUEUE_RESET to
 query queue reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Fri, Oct 18, 2024 at 7:19=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 18.10.24 um 11:33 schrieb Zhang, Jesse(Jie):
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Christian,
> >
> > -----Original Message-----
> > From: Koenig, Christian <Christian.Koenig@amd.com>
> > Sent: Friday, October 18, 2024 4:47 PM
> > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.=
org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: add the command AMDGPU_INFO_QUEUE_RESE=
T to query queue reset
> >
> > Am 18.10.24 um 10:19 schrieb Jesse.zhang@amd.com:
> >> Not all ASICs support the queue reset feature.
> >> Therefore, userspace can query this feature via
> >> AMDGPU_INFO_QUEUE_RESET before validating a queue reset.
> > Why would UMDs need that information?
> >
> > To verify queue reset.
> > Now the igt uses many asic filters to hard code if queue reset is ready=
.
> > Alex suggested that we can get the information directly from the driver=
.
>
> Ah, ok got it. Mhm in general sounds like the approach is cleaner, but
> the IOCTL interface is supposed to be used by the UMD and tested by the
> IGT tests.
>
> The problem is now that it's documented that the justification for
> having the IOCTLs is the UMD and not the IGT tests.
>
> Could we also do this as debugfs interface?
>
> > Another problem is that our driver has added code about queue reset.
> > The reset function is complete (adev->gfx.gfx_ring[0].funcs->reset),
> > but fw partially supports it.
> > For example navi31,   KCQ invalid opcode case can be recovered by queue=
 reset,
> > but KCQ invalid packet length cannot be recovered now.
> >
> > So for this case, I am not sure whether we can return true for this fun=
ction.
> >
> > More information can be obtained from the link:
> > https://confluence.amd.com/display/AMDGPU/Phase+1+-+Validation+of+Per+Q=
ueue+Reset+for+Kernel+Queue
>
> Oh, yeah good question. Alex should probably answer that.

Maybe a better option would be a reset_mask sysfs file for each IP
which we could have a bit for each reset type.  E.g.,

gc_reset_mask
sdma_reset_mask
vcn_reset_mask
jpeg_reset_mask
vpe_reset_mask

AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset, mode1/mode2/BACO/etc=
. */
AMDGPU_RESET_TYPE_SOFT_RESET (1 << 1) /* IP level soft reset */
AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2) /* per queue */
AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe */

Then the IGT tests could query the mask and determine which tests to run.

Alex

>
> Regards,
> Christian.
>
> >
> > Thanks
> > Jesse
> >> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> >> ---
> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 27 ++++++++++++++++++++++=
+++
> >>    include/uapi/drm/amdgpu_drm.h           |  2 ++
> >>    2 files changed, 29 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> index b53c35992152..87dee858fb4c 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> @@ -577,6 +577,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
> >>        uint64_t ui64 =3D 0;
> >>        int i, found, ret;
> >>        int ui32_size =3D sizeof(ui32);
> >> +     bool queue_reset;
> >>
> >>        if (!info->return_size || !info->return_pointer)
> >>                return -EINVAL;
> >> @@ -1282,6 +1283,32 @@ int amdgpu_info_ioctl(struct drm_device *dev, v=
oid *data, struct drm_file *filp)
> >>                return copy_to_user(out, &gpuvm_fault,
> >>                                    min((size_t)size, sizeof(gpuvm_faul=
t))) ? -EFAULT : 0;
> >>        }
> >> +     case AMDGPU_INFO_QUEUE_RESET: {
> >> +             fpriv =3D (struct amdgpu_fpriv *)filp->driver_priv;
> >> +             type =3D amdgpu_ip_get_block_type(adev, info->query_hw_i=
p.type);
> >> +             ip_block =3D amdgpu_device_ip_get_ip_block(adev, type);
> >> +
> >> +             if (!ip_block || !ip_block->status.valid)
> >> +                     return -EINVAL;
> >> +
> >> +             switch (info->query_hw_ip.type) {
> >> +             case AMDGPU_HW_IP_GFX:
> >> +                     queue_reset =3D adev->gfx.gfx_ring[0].funcs->res=
et ? true : false;
> > Please never ever use this coding style.
> >
> > If you want to convert anything into a boolean use the !! operator.
> >
> > Regards,
> > Christian.
> >
> >> +                     break;
> >> +             case AMDGPU_HW_IP_COMPUTE:
> >> +                     queue_reset =3D adev->gfx.compute_ring[0].funcs-=
>reset ? true : false;
> >> +                     break;
> >> +             case AMDGPU_HW_IP_DMA:
> >> +                     queue_reset =3D adev->sdma.instance[0].ring.func=
s->reset ? true : false;
> >> +                     break;
> >> +             case AMDGPU_HW_IP_UVD_ENC:
> >> +             case AMDGPU_HW_IP_VCN_DEC:
> >> +             default:
> >> +                     queue_reset =3D false;
> >> +             }
> >> +
> >> +             return copy_to_user(out, &queue_reset, min(size, 4u)) ? =
-EFAULT : 0;
> >> +     }
> >>        default:
> >>                DRM_DEBUG_KMS("Invalid request %d\n", info->query);
> >>                return -EINVAL;
> >> diff --git a/include/uapi/drm/amdgpu_drm.h
> >> b/include/uapi/drm/amdgpu_drm.h index d9bff1c3b326..3b17d82fd1ee
> >> 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -1052,6 +1052,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> >>    #define AMDGPU_INFO_MAX_IBS                 0x22
> >>    /* query last page fault info */
> >>    #define AMDGPU_INFO_GPUVM_FAULT                     0x23
> >> +/* query queue reset */
> >> +#define AMDGPU_INFO_QUEUE_RESET                      0x24
> >>
> >>    #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT      0
> >>    #define AMDGPU_INFO_MMR_SE_INDEX_MASK       0xff
>
