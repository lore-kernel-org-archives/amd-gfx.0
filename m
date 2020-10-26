Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD086C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 16:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635D6206FB
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 16:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0+wEDOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635D6206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D5B96E3DA;
	Mon, 26 Oct 2020 16:35:40 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B5E6E3DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 16:35:38 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id h7so13416171wre.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8gBgNx6zESMixgIedbcEBia6aCQNDQY4JxjM3SiAIEw=;
 b=R0+wEDOzonsnfEv4onFd0anmHmVoP83yskxQZ9rSMyBJG6K81yyeA022Tvs+rcIZFI
 /JW2V0bkLutSXsZubTkqT8xMbxPOQ0QSwo0viYjYAcATK4G/WKo13b5AJ3zqeG0n0Ms0
 KS3+NWCKXFNYMvn+B0ATuy7poL77/Zvih+PzmhjMNLIjlUlfod4umLrH6R0kxcd+ayXW
 vdn18hfrCcjxxDzHMTpD6nrVbwFV4bBRTLc3hpMeUCopX/bi1JgpbApgCfpr4CTfchsM
 R9r5gCtRoSgX+7QbLyLEmsF1Tn4GTcnBU1TZxpKy5km+DNsspysgp3vzYObcTJCL12DF
 H5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8gBgNx6zESMixgIedbcEBia6aCQNDQY4JxjM3SiAIEw=;
 b=K5T28D9ffZhMPSogWN5fVP1W0/XGvivX9DvYFggiMExLw9Aqakcqs37Pk3/kCfr03x
 loqTXxAf8Y3RKqVjzBm5AfvukJjmYC1nWP1mC9sNCY6PhVsZlv6cM3He0fgIgYUx8xPP
 WdNWh8TdszwW7Su3rkv0/b1WdDIDwiyZGukqPrByJJoGl+2IcBZW8RAFboo6WrMqMVxj
 j0j/hTb5udKnQUMTNTIeMJmMSWHH6NL+hjWjxyWVNyrd2N74fR3vfy08QjPCmixk5uls
 fK9k2H/wera6vVOtXms/lthNS5Lu6XE7IGI8b15JeayZwdzM/YoTlsFR597KAd8tZP6V
 WlAw==
X-Gm-Message-State: AOAM530LUV1au0ePJQ08StcIF9Wv6QHr9gOakRhkDF6LLGVUSBX9WFQi
 bXhnvrBmT2zEsgGbqdxxXLeqiFYMgoU+6xzSBKgUM4aM
X-Google-Smtp-Source: ABdhPJylh+Zzp0WOxBfR75pg98OZvYTmmFJNiU7hz7+w2RfoaxQKDub+cyZo2MAaaIzXvgCgJGYV+NLKwhRgK55HKYk=
X-Received: by 2002:a5d:6642:: with SMTP id f2mr19414231wrw.374.1603730137267; 
 Mon, 26 Oct 2020 09:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
 <CADnq5_M99PBm-GS55m3Q4aFY5U8xgb86zUTf4dX-1nhRoK7-fA@mail.gmail.com>
In-Reply-To: <CADnq5_M99PBm-GS55m3Q4aFY5U8xgb86zUTf4dX-1nhRoK7-fA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2020 12:35:26 -0400
Message-ID: <CADnq5_O+_fL7ssPgS94ib6=f=0+zbs48qvyO4MBtE9qce4=kbA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping again?

On Thu, Oct 22, 2020 at 1:31 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Ping on this series?
>
> Alex
>
> On Fri, Oct 16, 2020 at 12:50 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > No need for a separate config option at this point.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/Kconfig               | 8 --------
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ------
> >  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 2 --
> >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 --
> >  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 --
> >  5 files changed, 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> > index 93cdcd1ee9ff..cf87133f88e6 100644
> > --- a/drivers/gpu/drm/amd/display/Kconfig
> > +++ b/drivers/gpu/drm/amd/display/Kconfig
> > @@ -17,14 +17,6 @@ config DRM_AMD_DC_DCN
> >         help
> >           Raven, Navi and Renoir family support for display engine
> >
> > -config DRM_AMD_DC_GREEN_SARDINE
> > -       bool "Green Sardine support"
> > -       default y
> > -       depends on DRM_AMD_DC_DCN
> > -        help
> > -            Choose this option if you want to have
> > -            Green Sardine support for display engine
> > -
> >  config DRM_AMD_DC_DCN3_0
> >          bool "DCN 3.0 family"
> >          depends on DRM_AMD_DC && X86
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 8a90063ac08a..2aa810d3554b 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -100,10 +100,8 @@ MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
> >  #define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
> >  MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
> >  #endif
> > -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >  #define FIRMWARE_GREEN_SARDINE_DMUB "amdgpu/green_sardine_dmcub.bin"
> >  MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE_DMUB);
> > -#endif
> >  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
> >  #define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
> >  MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
> > @@ -985,10 +983,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
> >         case CHIP_RAVEN:
> >         case CHIP_RENOIR:
> >                 init_data.flags.gpu_vm_support = true;
> > -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
> >                         init_data.flags.disable_dmcu = true;
> > -#endif
> >                 break;
> >         default:
> >                 break;
> > @@ -1289,10 +1285,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
> >         case CHIP_RENOIR:
> >                 dmub_asic = DMUB_ASIC_DCN21;
> >                 fw_name_dmub = FIRMWARE_RENOIR_DMUB;
> > -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
> >                         fw_name_dmub = FIRMWARE_GREEN_SARDINE_DMUB;
> > -#endif
> >                 break;
> >  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
> >         case CHIP_SIENNA_CICHLID:
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> > index b361dc6c3489..19d97ed6beb8 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> > @@ -170,12 +170,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
> >                         break;
> >                 }
> >
> > -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev)) {
> >                         rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
> >                         break;
> >                 }
> > -#endif
> >                 if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev)) {
> >                         rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
> >                         break;
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > index ab105f26b511..419c0df08602 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -126,10 +126,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
> >                         dc_version = DCN_VERSION_1_01;
> >                 if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev))
> >                         dc_version = DCN_VERSION_2_1;
> > -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev))
> >                         dc_version = DCN_VERSION_2_1;
> > -#endif
> >                 break;
> >  #endif
> >
> > diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> > index b4c3838322af..2bf60ac2974f 100644
> > --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> > +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> > @@ -209,12 +209,10 @@ enum {
> >  #if defined(CONFIG_DRM_AMD_DC_DCN3_02)
> >  #define ASICREV_IS_DIMGREY_CAVEFISH_P(eChipRev)        ((eChipRev >= NV_DIMGREY_CAVEFISH_P_A0) && (eChipRev < NV_UNKNOWN))
> >  #endif
> > -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >  #define GREEN_SARDINE_A0 0xA1
> >  #ifndef ASICREV_IS_GREEN_SARDINE
> >  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
> >  #endif
> > -#endif
> >  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
> >  #define FAMILY_VGH 144
> >  #define DEVICE_ID_VGH_163F 0x163F
> > --
> > 2.25.4
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
