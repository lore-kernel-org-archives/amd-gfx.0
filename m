Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E97FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 15:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B15223382
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 15:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B15223382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCBC6E157;
	Wed, 13 Jan 2021 15:26:58 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4671E6E157
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 15:26:57 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id w3so2191741otp.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XxVchBrZ+tdZ6B3wV8T71RDISn7qOyUHij+qe/jeUFw=;
 b=tLeX7h6Ke0GGufpmBm+juIzMWev/qTkZXdajOcjw/KCCe907E3mHH6lDWO10pf07wo
 vW6bzGdNmXmXA/+KSPVCJkfLwut0LJadV/OqTG0MWvnGL+rG2AkGM/s9VUM51QDN337N
 R/5mrDkgN5QrybOdeuBhgoHVysA0G9KzrULCTlWfSUVa5tc+QrHhU/OGmJ4XLwscnvK7
 RfQiBZMZFt9yh4JlEiapsZVNxhYfPn0FqwM47Tvwkv1rFk+GOwmoVlb8zPFgEdyj/XfP
 NJe2sQXlUwBVpezaOefGPWhpcUdnPo2AcUuOAch998r6zwNeeSVHHL0MA3hSVHKDafN0
 b1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XxVchBrZ+tdZ6B3wV8T71RDISn7qOyUHij+qe/jeUFw=;
 b=dCNTsyEJt4PQTCgnqgTF2qRjjCM8hMke0Ox3ysVSlc1eak3SIrrmc0G+/pOTCOEPxu
 mgo3IPrZAzvdp+0qojUrh1zIEhztYWOn2PNoBnIvL9s/9t7N9m0OzFA+YsQBvc0UwVtx
 b4j+sie/3IEnaFKLl1q9amK40z1dkbZ1AD9OZKGjD78Vf1NL+1yCirtcPT6E8jDg31LZ
 vxwUUdEZO/wrErJZrWid/ekFvGlV4Q49+rWfVN58aVABzFqIL88lpikibTfKe2SdaVHZ
 7lNy7f28nPo1r5+ILUigmb1E0/It3hC16zNsRn9ZGt3gLYHqsnY/Xmii8f6Y6k5ec16+
 PUUg==
X-Gm-Message-State: AOAM530CyQmqUkhxIkujzJNl6SToKIS2ilxnRInblhGnAjSijFCMCLfc
 IBSWRrJbfnj9I3CXqiRAjJiP5Ki/CyjkKukFcndYSC3a
X-Google-Smtp-Source: ABdhPJzoPLo0DPz2TfM3aZL80R0UeWVzuh1SFsmopxoSFLE5vOvg/0hw+7JYycaAPDCrW6SgvH3nkqThB+lIujJm7jc=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr1568601otb.23.1610551616655; 
 Wed, 13 Jan 2021 07:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20210113122948.218187-1-ray.huang@amd.com>
In-Reply-To: <20210113122948.218187-1-ray.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Jan 2021 10:26:45 -0500
Message-ID: <CADnq5_P6joKVEvf-9KAYYYiF2bLHgXQZA-Hhr+6-uLUps6_p8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix vram type and bandwidth error for DDR5
 and DDR4
To: Huang Rui <ray.huang@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 13, 2021 at 7:30 AM Huang Rui <ray.huang@amd.com> wrote:
>
> This patch is to update atomfirmware parser for the memory type and
> bandwidth of DDR5 and DDR4.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 53 +++++++++++++------
>  1 file changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 306077884a67..6107ac91db25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -112,6 +112,7 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
>  union igp_info {
>         struct atom_integrated_system_info_v1_11 v11;
>         struct atom_integrated_system_info_v1_12 v12;
> +       struct atom_integrated_system_info_v2_1 v21;
>  };
>
>  union umc_info {
> @@ -209,24 +210,42 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>                 if (adev->flags & AMD_IS_APU) {
>                         igp_info = (union igp_info *)
>                                 (mode_info->atom_context->bios + data_offset);
> -                       switch (crev) {
> -                       case 11:
> -                               mem_channel_number = igp_info->v11.umachannelnumber;
> -                               /* channel width is 64 */
> -                               if (vram_width)
> -                                       *vram_width = mem_channel_number * 64;
> -                               mem_type = igp_info->v11.memorytype;
> -                               if (vram_type)
> -                                       *vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +                       switch (frev) {
> +                       case 1:
> +                               switch (crev) {
> +                               case 11:
> +                               case 12:
> +                                       mem_channel_number = igp_info->v11.umachannelnumber;
> +                                       if (!mem_channel_number)
> +                                               mem_channel_number = 1;
> +                                       /* channel width is 64 */
> +                                       if (vram_width)
> +                                               *vram_width = mem_channel_number * 64;
> +                                       mem_type = igp_info->v11.memorytype;
> +                                       if (vram_type)
> +                                               *vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +                                       break;
> +                               default:
> +                                       return -EINVAL;
> +                               }
>                                 break;
> -                       case 12:
> -                               mem_channel_number = igp_info->v12.umachannelnumber;
> -                               /* channel width is 64 */
> -                               if (vram_width)
> -                                       *vram_width = mem_channel_number * 64;
> -                               mem_type = igp_info->v12.memorytype;
> -                               if (vram_type)
> -                                       *vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +                       case 2:
> +                               switch (crev) {
> +                               case 1:
> +                               case 2:
> +                                       mem_channel_number = igp_info->v21.umachannelnumber;
> +                                       if (!mem_channel_number)
> +                                               mem_channel_number = 1;
> +                                       /* channel width is 64 */
> +                                       if (vram_width)
> +                                               *vram_width = mem_channel_number * 64;
> +                                       mem_type = igp_info->v21.memorytype;
> +                                       if (vram_type)
> +                                               *vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> +                                       break;
> +                               default:
> +                                       return -EINVAL;
> +                               }
>                                 break;
>                         default:
>                                 return -EINVAL;
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
