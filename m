Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36EBC433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AAD20720
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdtCcagx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AAD20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB22892D8;
	Tue, 21 Jul 2020 18:10:58 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E96F892D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:10:56 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z2so22135241wrp.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7d4gJB3sAqV5KZnKfLezNcBIa55X4V83yW5w6V8773o=;
 b=MdtCcagxDmbltbPc4DpiT4jhxz+SJ8KjHwqkBo4QdiKWvZuZNdKYzxT84uP7/DH/OR
 j/D/5gc2qEm6J86EvmhBWxugSPGwaRbHSDBD2ZERtT0lJAfHRkAXR63izf8b3N/ppH6z
 AvJgxwhD0iuIxYjwO8Bh35A3ThiC4TePUGWtL2ImUhff+TajynoXXGRcvh4ymUbZJPFb
 ppiXE0fdUiH8OTJoey2pOqjpmoyZRG0fAUoiqL7CE/PTmYMZE+OxUM+u25tBaTeomjX4
 INyzwx08Ta8dvhtJ+vcX6DadlMwcRaU5PHqdPhjUFOYaGqszI2V+5zVbZKJWeCcFke5W
 sTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7d4gJB3sAqV5KZnKfLezNcBIa55X4V83yW5w6V8773o=;
 b=LaVX6/oqM3mC2rrn8U6vyuq6yHNmFDRoq2nfecWp8/osW9DonkS0BL4RmEm3jYXdjn
 a18nhRHHvgghCR/l6N4VWhZohmCNNCsn+CCrkcNq6X87dskz1HtldWPgISB3nslCtrnN
 tHEqhoJHIZcbXX8F1XRZsDohHnN3brJNBeskIerBsrn4lLkuwozpBrQO2G7lxYoDHztA
 rS3o6TrA6l5mya5g2EG6kS2Pg3SZGvaf7aCuW3PtcnSfX1g2ODGDGRcJJmOJR4v5ZZ6D
 C7/ERaPpOjhSfIHpMevyPSTQeQRe6f/kvcykeL3ptkX4/WSzEsj3TGoO87VdQvDSywHK
 MQRQ==
X-Gm-Message-State: AOAM530an8dtld2gcL3DFRUzK+J5nEf1DTije9kFFM74FQOzzopFm7UN
 g86tU6q4EmwsGC4Gf2YbwWFvipSJlJyR9jpgP53RDQ==
X-Google-Smtp-Source: ABdhPJwKLT5HJRTydy4ZtLQwkEhGttvMfF8jHaiCy/6bLdp2diFcNuCQ/LNeFuLyiRW54eBg+lrBQkJg9DenOBNJsyk=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr10258526wrw.362.1595355055396; 
 Tue, 21 Jul 2020 11:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200721180722.6344-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200721180722.6344-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Jul 2020 14:10:44 -0400
Message-ID: <CADnq5_OLsoFBCbxqniqnxkoQg=xfN2-QmWHt9bLFx8Tgdi04aw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use seperate dmcub firmware for
 navy_flounder
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 21, 2020 at 2:07 PM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> [Why]
> Currently navy_flounder is using sienna_cichlid_dmcub.bin.
>
> [How]
> Create a seperate define so navy_flounder will use its own firmware.
>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 95185cc58fcb..268eb7ddf364 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -97,6 +97,8 @@ MODULE_FIRMWARE(FIRMWARE_RENOIR_DMUB);
>  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
>  #define FIRMWARE_SIENNA_CICHLID_DMUB "amdgpu/sienna_cichlid_dmcub.bin"
>  MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
> +#define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
> +MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
>  #endif
>
>  #define FIRMWARE_RAVEN_DMCU            "amdgpu/raven_dmcu.bin"
> @@ -1185,10 +1187,13 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>                 break;
>  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
>         case CHIP_SIENNA_CICHLID:
> -       case CHIP_NAVY_FLOUNDER:
>                 dmub_asic = DMUB_ASIC_DCN30;
>                 fw_name_dmub = FIRMWARE_SIENNA_CICHLID_DMUB;
>                 break;
> +       case CHIP_NAVY_FLOUNDER:
> +               dmub_asic = DMUB_ASIC_DCN30;
> +               fw_name_dmub = FIRMWARE_NAVY_FLOUNDER_DMUB;
> +               break;
>  #endif
>
>         default:
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
