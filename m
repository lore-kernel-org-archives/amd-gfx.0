Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBACC388F9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 15:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBAD20657
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 15:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ+RsvRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBAD20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA66D6EB86;
	Tue, 27 Oct 2020 15:19:29 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 439A46EB86
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 15:19:28 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id n6so2311325wrm.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aH3UymlTE+YQJp5aFpn6tVq7OyUiSl7/agRuSnxW/Tg=;
 b=cZ+RsvRY0oBtDXMPMeh/RYxA1FXx370F8oIA2L1VSP/CJJ5vHp9A8jQvQc8absZWc1
 k99Yq1SFlAYRmQgGLAHNN0Gv/+LQv5iSVoTxYYZALui69mprwZcRa20xVu12mMe9zj5W
 SzALPuACpgvVbCLSeBDalRgZIhHYUQN/lJXYiOXZQVFsl8rnQ1bN0GjEIpwoFP6YyoEs
 wYraZxrt+LHcjzLVjEO7WUjXCNEhlMAO18L5pGgUWC54UpVpxV3ALpVNdHp/nMg7Fl+P
 7Vm7HxUhbTo1fSQpzgp/f7FXAomC2EGPrV4LmemNAdLz9sAV4OQI0Mh6wR4WtycnGl1w
 Yr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aH3UymlTE+YQJp5aFpn6tVq7OyUiSl7/agRuSnxW/Tg=;
 b=XjctvoB4EPJXSahhhin80n1QfGESjg+BtSyr1lme2NlFVYCL3euICQSZniiFF5+0iC
 ijQ5tDNcn1gbfpNWXkaEhUEyEAdvIvcy/mkmw1FUXvG1rmjPu+CpjPDcp9+VrwymTpun
 f3kRv/BvezkMmJFHhkHMWEEKZ33wrFzNgGQLwcrCDezqiF/cQceWvLlUvqdAC7qDERqI
 vnzwS52OX9PGItSQISoR6MHHYTM1+ruNaukP9enS/uMShXJe8lIUa2pTQUcilQR93ueG
 A7LZ1VPZ2xv4lD5ci4x4Wo6npBn5YfbOfjtsSg1daRV5v2jBmJxPk80Pt8dfvnp1U2lW
 AwFg==
X-Gm-Message-State: AOAM5328jZZQyv7PD7iisBaB3YSo0ewENt6XWCopj9tMr1oucbMu/0Zn
 EntLs96Jdois7tp04xCyuRpD4HS8V5sBbExb/Rk=
X-Google-Smtp-Source: ABdhPJwJzpFSJQ7ANO0CWqVVIP21Wkw2O3EWjtwnOBBzTFIUXctda8Yv8ViagH5suPuKUtB4L4H6jHBmchcGNyGrepg=
X-Received: by 2002:adf:dd50:: with SMTP id u16mr3623913wrm.419.1603811966859; 
 Tue, 27 Oct 2020 08:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
 <CADnq5_M99PBm-GS55m3Q4aFY5U8xgb86zUTf4dX-1nhRoK7-fA@mail.gmail.com>
 <CADnq5_O+_fL7ssPgS94ib6=f=0+zbs48qvyO4MBtE9qce4=kbA@mail.gmail.com>
 <61f7a8cd-2548-8661-116c-fa6a7c4d882f@amd.com>
In-Reply-To: <61f7a8cd-2548-8661-116c-fa6a7c4d882f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2020 11:19:15 -0400
Message-ID: <CADnq5_PON1F0bzbiGyw3Y1wRVpCpxYhOuO=YSyOaOfFecZeEbQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE
To: Luben Tuikov <luben.tuikov@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 26, 2020 at 7:06 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Consolidating DCN seems like a good idea.
>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Is this for the whole series or just this patch?

Thanks!

Alex

>
> Regards,
> Luben
>
> On 2020-10-26 12:35 p.m., Alex Deucher wrote:
> > Ping again?
> >
> > On Thu, Oct 22, 2020 at 1:31 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >>
> >> Ping on this series?
> >>
> >> Alex
> >>
> >> On Fri, Oct 16, 2020 at 12:50 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >>>
> >>> No need for a separate config option at this point.
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/display/Kconfig               | 8 --------
> >>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ------
> >>>  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 2 --
> >>>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 --
> >>>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 --
> >>>  5 files changed, 20 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> >>> index 93cdcd1ee9ff..cf87133f88e6 100644
> >>> --- a/drivers/gpu/drm/amd/display/Kconfig
> >>> +++ b/drivers/gpu/drm/amd/display/Kconfig
> >>> @@ -17,14 +17,6 @@ config DRM_AMD_DC_DCN
> >>>         help
> >>>           Raven, Navi and Renoir family support for display engine
> >>>
> >>> -config DRM_AMD_DC_GREEN_SARDINE
> >>> -       bool "Green Sardine support"
> >>> -       default y
> >>> -       depends on DRM_AMD_DC_DCN
> >>> -        help
> >>> -            Choose this option if you want to have
> >>> -            Green Sardine support for display engine
> >>> -
> >>>  config DRM_AMD_DC_DCN3_0
> >>>          bool "DCN 3.0 family"
> >>>          depends on DRM_AMD_DC && X86
> >>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> index 8a90063ac08a..2aa810d3554b 100644
> >>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> @@ -100,10 +100,8 @@ MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
> >>>  #define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
> >>>  MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
> >>>  #endif
> >>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >>>  #define FIRMWARE_GREEN_SARDINE_DMUB "amdgpu/green_sardine_dmcub.bin"
> >>>  MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE_DMUB);
> >>> -#endif
> >>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
> >>>  #define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
> >>>  MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
> >>> @@ -985,10 +983,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
> >>>         case CHIP_RAVEN:
> >>>         case CHIP_RENOIR:
> >>>                 init_data.flags.gpu_vm_support = true;
> >>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >>>                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
> >>>                         init_data.flags.disable_dmcu = true;
> >>> -#endif
> >>>                 break;
> >>>         default:
> >>>                 break;
> >>> @@ -1289,10 +1285,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
> >>>         case CHIP_RENOIR:
> >>>                 dmub_asic = DMUB_ASIC_DCN21;
> >>>                 fw_name_dmub = FIRMWARE_RENOIR_DMUB;
> >>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >>>                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
> >>>                         fw_name_dmub = FIRMWARE_GREEN_SARDINE_DMUB;
> >>> -#endif
> >>>                 break;
> >>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
> >>>         case CHIP_SIENNA_CICHLID:
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> >>> index b361dc6c3489..19d97ed6beb8 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> >>> @@ -170,12 +170,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
> >>>                         break;
> >>>                 }
> >>>
> >>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >>>                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev)) {
> >>>                         rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
> >>>                         break;
> >>>                 }
> >>> -#endif
> >>>                 if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev)) {
> >>>                         rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
> >>>                         break;
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>> index ab105f26b511..419c0df08602 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> >>> @@ -126,10 +126,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
> >>>                         dc_version = DCN_VERSION_1_01;
> >>>                 if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev))
> >>>                         dc_version = DCN_VERSION_2_1;
> >>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >>>                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev))
> >>>                         dc_version = DCN_VERSION_2_1;
> >>> -#endif
> >>>                 break;
> >>>  #endif
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> >>> index b4c3838322af..2bf60ac2974f 100644
> >>> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> >>> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> >>> @@ -209,12 +209,10 @@ enum {
> >>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_02)
> >>>  #define ASICREV_IS_DIMGREY_CAVEFISH_P(eChipRev)        ((eChipRev >= NV_DIMGREY_CAVEFISH_P_A0) && (eChipRev < NV_UNKNOWN))
> >>>  #endif
> >>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
> >>>  #define GREEN_SARDINE_A0 0xA1
> >>>  #ifndef ASICREV_IS_GREEN_SARDINE
> >>>  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
> >>>  #endif
> >>> -#endif
> >>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
> >>>  #define FAMILY_VGH 144
> >>>  #define DEVICE_ID_VGH_163F 0x163F
> >>> --
> >>> 2.25.4
> >>>
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7Ce6faf7405e70424a369708d879cd2eb4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393269481241813%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qMugHyx6d2fLC3oZxvDpoCDt7rN%2BvHTJj9dU81QAYpQ%3D&amp;reserved=0
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
