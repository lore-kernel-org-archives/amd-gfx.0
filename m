Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA0C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 15:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8797D21D7E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 15:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc8I73Nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8797D21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C486E0C9;
	Fri, 20 Dec 2019 15:28:10 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53956E0C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 15:28:08 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id y11so9801574wrt.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 07:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UaauBeOCt91+KlXYmb1FKmwW8yXVkoo2/GamSyDQeCM=;
 b=Zc8I73Nu0bsNbaOcg8td4BG3At/TpsAkvyhOe9NM0XAOMDOwDOvlJExNjZQ4+QRqLi
 L/tjoMno2DJFwVXK716UpHJQGv0a+oDLVlodk3ia/6Hgoi3jB1qJSp1azPE/ltiLK2JE
 xKV68Q8a4IeZE6scLbOUx5QOuS2NTXEgXUZe9tbjGPK3gBRk35xHEdgkUM7VIyQMCKm/
 cnyFq0paq6DvjLzQRCKqvs2AegMyAGI+VjbgTC27MAeG0tlwERImPQcGY0t5Ogrccfuc
 inoIiWvZR2UTkAkBNxzHVEWvGTdx7q93InX/dZjzUtI/kfi3WaBuAUZhhj525Qd/Aly3
 Qzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UaauBeOCt91+KlXYmb1FKmwW8yXVkoo2/GamSyDQeCM=;
 b=ijB3P1v5dyN0aYoqoxda7Vlx/Q0g8iDQWjQQOQ+PXd61ZqHYznVzUdXyRsyunYRcm6
 71cSgqCIU6m6SEZevunsjjst+6v1dK3d0C+8JCFwS+h2vZz3GUrNLhLBI0PefEcUDYAQ
 8DGdu+ZsypNsvVzEyMm6DJj3CQOP1YmM697AxEWLp+gK1lEmXual5qdSvDvdELpJsYLY
 W/YRJmu5xkF1qOU0Wn2MCYP70qTwenXZ1FaL/VR/i+GjCVch4c+qkUrWXSFn6pDNFKBx
 iAdBQ6R638KuliXdgJKWTMnTNYINVqUou4HIyp8cjX9oj5WJK7CzleD2kAG2oc9zR7jO
 AM+g==
X-Gm-Message-State: APjAAAU35RUwMQf0ajqRTzNZ9+kAHMwqJ6aF4oNm0CbWj3jaITOiihR5
 Pln6hbvKiKZeZjFYDbwwgNc+ArpCBsQxd5pRmyA=
X-Google-Smtp-Source: APXvYqy373o2CxYwNhsmolsas/ROGYU5dBgXyaVOo1k/DZDQa6TW+coHOhruZJZ5zKClm5NSRY5vl+uXSud9VBNSaq8=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr16137963wrn.50.1576855687119; 
 Fri, 20 Dec 2019 07:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20191219091623.3922-1-tianci.yin@amd.com>
 <ae29000d-fb99-4846-6d66-3ce5f67013c5@amd.com>
 <MN2PR12MB29574DEB22704EAD912B00A8952D0@MN2PR12MB2957.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB29574DEB22704EAD912B00A8952D0@MN2PR12MB2957.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Dec 2019 10:27:55 -0500
Message-ID: <CADnq5_N0QbrFs3pvyd7gT0_5=+KXk1COj5K8-Dw=N6K-AW+P=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V4)
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 19, 2019 at 9:00 PM Yin, Tianci (Rico) <Tianci.Yin@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Hi Luben,
>
> May I have your Review-by?
>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Thanks a lot!
> Rico
> ________________________________
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Friday, December 20, 2019 3:47
> To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory training(V4)
>
> Yep! That's perfect--good job!
>
> Regards,
> Luben
>
> On 2019-12-19 04:16, Tianci Yin wrote:
> > From: "Tianci.Yin" <tianci.yin@amd.com>
> >
> > The method of getting fb_loc changed from parsing VBIOS to
> > taking certain offset from top of VRAM
> >
> > Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539
> > Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
> >  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 38 ++-----------------
> >  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 10 ++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
> >  drivers/gpu/drm/amd/include/atomfirmware.h    | 14 -------
> >  7 files changed, 23 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index a78a363b1d71..fa2cf8e7bc07 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -642,9 +642,8 @@ struct amdgpu_fw_vram_usage {
> >        struct amdgpu_bo *reserved_bo;
> >        void *va;
> >
> > -     /* Offset on the top of VRAM, used as c2p write buffer.
> > +     /* GDDR6 training support flag.
> >        */
> > -     u64 mem_train_fb_loc;
> >        bool mem_train_support;
> >  };
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > index 9ba80d828876..fdd52d86a4d7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > @@ -2022,7 +2022,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
> >        if (adev->is_atom_fw) {
> >                amdgpu_atomfirmware_scratch_regs_init(adev);
> >                amdgpu_atomfirmware_allocate_fb_scratch(adev);
> > -             ret = amdgpu_atomfirmware_get_mem_train_fb_loc(adev);
> > +             ret = amdgpu_atomfirmware_get_mem_train_info(adev);
> >                if (ret) {
> >                        DRM_ERROR("Failed to get mem train fb location.\n");
> >                        return ret;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > index ff4eb96bdfb5..58f9d8c3a17a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > @@ -525,16 +525,12 @@ static int gddr6_mem_train_support(struct amdgpu_device *adev)
> >        return ret;
> >  }
> >
> > -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
> > +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
> >  {
> >        struct atom_context *ctx = adev->mode_info.atom_context;
> > -     unsigned char *bios = ctx->bios;
> > -     struct vram_reserve_block *reserved_block;
> > -     int index, block_number;
> > +     int index;
> >        uint8_t frev, crev;
> >        uint16_t data_offset, size;
> > -     uint32_t start_address_in_kb;
> > -     uint64_t offset;
> >        int ret;
> >
> >        adev->fw_vram_usage.mem_train_support = false;
> > @@ -569,32 +565,6 @@ int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
> >                return -EINVAL;
> >        }
> >
> > -     reserved_block = (struct vram_reserve_block *)
> > -             (bios + data_offset + sizeof(struct atom_common_table_header));
> > -     block_number = ((unsigned int)size - sizeof(struct atom_common_table_header))
> > -             / sizeof(struct vram_reserve_block);
> > -     reserved_block += (block_number > 0) ? block_number-1 : 0;
> > -     DRM_DEBUG("block_number:0x%04x, last block: 0x%08xkb sz, %dkb fw, %dkb drv.\n",
> > -               block_number,
> > -               le32_to_cpu(reserved_block->start_address_in_kb),
> > -               le16_to_cpu(reserved_block->used_by_firmware_in_kb),
> > -               le16_to_cpu(reserved_block->used_by_driver_in_kb));
> > -     if (reserved_block->used_by_firmware_in_kb > 0) {
> > -             start_address_in_kb = le32_to_cpu(reserved_block->start_address_in_kb);
> > -             offset = (uint64_t)start_address_in_kb * ONE_KiB;
> > -             if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) ) {
> > -                     offset -= ONE_MiB;
> > -             }
> > -
> > -             offset &= ~(ONE_MiB - 1);
> > -             adev->fw_vram_usage.mem_train_fb_loc = offset;
> > -             adev->fw_vram_usage.mem_train_support = true;
> > -             DRM_DEBUG("mem_train_fb_loc:0x%09llx.\n", offset);
> > -             ret = 0;
> > -     } else {
> > -             DRM_ERROR("used_by_firmware_in_kb is 0!\n");
> > -             ret = -EINVAL;
> > -     }
> > -
> > -     return ret;
> > +     adev->fw_vram_usage.mem_train_support = true;
> > +     return 0;
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> > index f871af5ea6f3..434fe2fa0089 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> > @@ -31,7 +31,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
> >  int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
> >  int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
> >        int *vram_width, int *vram_type, int *vram_vendor);
> > -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev);
> > +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev);
> >  int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
> >  int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
> >  bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 2ff63d0414c9..1515413fd356 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1687,6 +1687,14 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
> >        return 0;
> >  }
> >
> > +static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_size)
> > +{
> > +       if ((vram_size & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) )
> > +               vram_size -= ONE_MiB;
> > +
> > +       return ALIGN(vram_size, ONE_MiB);
> > +}
> > +
> >  /**
> >   * amdgpu_ttm_training_reserve_vram_init - create bo vram reservation from memory training
> >   *
> > @@ -1705,7 +1713,7 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
> >                return 0;
> >        }
> >
> > -     ctx->c2p_train_data_offset = adev->fw_vram_usage.mem_train_fb_loc;
> > +     ctx->c2p_train_data_offset = amdgpu_ttm_training_get_c2p_offset(adev->gmc.mc_vram_size);
> >        ctx->p2c_train_data_offset = (adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
> >        ctx->train_data_size = GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > index f1ebd424510c..19eb3e8456c7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > @@ -66,6 +66,13 @@ struct amdgpu_copy_mem {
> >        unsigned long                   offset;
> >  };
> >
> > +/* Definitions for constance */
> > +enum amdgpu_internal_constants
> > +{
> > +     ONE_KiB = 0x400,
> > +     ONE_MiB = 0x100000,
> > +};
> > +
> >  extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_func;
> >  extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;
> >
> > diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> > index dd7cbc00a0aa..70146518174c 100644
> > --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> > +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> > @@ -672,20 +672,6 @@ struct vram_usagebyfirmware_v2_1
> >    uint16_t  used_by_driver_in_kb;
> >  };
> >
> > -/* This is part of vram_usagebyfirmware_v2_1 */
> > -struct vram_reserve_block
> > -{
> > -     uint32_t start_address_in_kb;
> > -     uint16_t used_by_firmware_in_kb;
> > -     uint16_t used_by_driver_in_kb;
> > -};
> > -
> > -/* Definitions for constance */
> > -enum atomfirmware_internal_constants
> > -{
> > -     ONE_KiB = 0x400,
> > -     ONE_MiB = 0x100000,
> > -};
> >
> >  /*
> >    ***************************************************************************
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
