Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B2FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 15:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0A910E1F7;
	Mon,  7 Feb 2022 15:59:11 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A613510E1F7
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 15:59:09 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 o9-20020a9d7189000000b0059ee49b4f0fso11222545otj.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 07:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FitzRtk6uPcfGvYcK4WVO9XF3EN6382UpaUDKShlj98=;
 b=Oj2fFgCUXZyDdGetTBTB9OEdQMJZLhuUjWf5iS4R5F4zQcMeQkHZuP+WQ3WIkhBEQr
 n87p4H+YAUjIuSVY3y+wiCTNmq6Xm9quJiyQAts0M2zRxsOaTXkEE7fL1Lv2vP7ZK7Kj
 3mgiSMXCdpLm/ydTkJZr3u04Njm9ubqqYFyi204Z8e8jJQ+FAorIXul56+06bWj5JXX6
 zrl9kf1WzVpzbhs0eTArq1MRhTBlW+VtoI45TSESWLaAHjV2UTodZddlFZB8Fq/Wn8T2
 elqh8EmiKzXBUkwphofPR+eedcIm8I9LPytmbqydPqLFh+nHbGcmYHndkUVQAPGsImso
 dpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FitzRtk6uPcfGvYcK4WVO9XF3EN6382UpaUDKShlj98=;
 b=YqA+1Xx4InQv7COtqRZ9/Ob4n4+i0JxlSDD+eQCUmxyOzqzGFwcGJ3kTaIyfSjVseO
 i2V596kvIIw0PDanZQXcNKbu069a4ZQgoJbj+eOqUC39OuxhEnd9UzTKp1nS/0jT7sxi
 PG4sviSOkyyE4ejnsWAj7R7kvYEasq0HusUIhJKQiaLV3xgLuiYQp2fkaf28r1TqeV/m
 mBgF6bJL9zkvhflnZmpSQpcXvB7wBSlLu9g+hnlDEQtlChfuFftTwGasdsxvX15fnO/D
 QbQ8Qs5LI0aSnSGQ81YC+m93vTA6GiCFUUhip2mvZhonVbDTH9RLpbSKlvsHCtX7irdK
 gEvA==
X-Gm-Message-State: AOAM533HyhaquAp2x92BB3zHAselONMdVw7g5pf/kzJORGCejkD0uOy5
 BALKtcSrwh+B6p6kZO16MAe1/O4HDw06jM5fJRg=
X-Google-Smtp-Source: ABdhPJyFcpGfvkRnoV5Z7m63sZmQQ1bWNxZCPBSA5sI7LvFUYt2Mc8G6/8SljYNkTlETBjChvG981b6E8lFzZzpu2pM=
X-Received: by 2002:a9d:e94:: with SMTP id 20mr171919otj.200.1644249548863;
 Mon, 07 Feb 2022 07:59:08 -0800 (PST)
MIME-Version: 1.0
References: <20220205043310.165991-1-jdhillon@amd.com>
 <20220205043310.165991-14-jdhillon@amd.com>
In-Reply-To: <20220205043310.165991-14-jdhillon@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Feb 2022 10:58:58 -0500
Message-ID: <CADnq5_PuP=WFtoF-yBZKq_WDF9dcpCZ0k3dxNzAWtCAMNYgngQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] drm/amd/display: Basic support with device ID
To: Jasdeep Dhillon <jdhillon@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Stylon Wang <stylon.wang@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
 Oliver Logush <oliver.logush@amd.com>,
 "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Solomon Chiu <solomon.chiu@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <agustin.gutierrez@amd.com>, "Kotarac, Pavle" <pavle.kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 4, 2022 at 11:33 PM Jasdeep Dhillon <jdhillon@amd.com> wrote:
>
> From: Oliver Logush <oliver.logush@amd.com>
>
> [why]
> To get the the cyan_skillfish check working

NAK.  This is still not correct.

>
> Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
> Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
> Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
> Signed-off-by: Oliver Logush <oliver.logush@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++++++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
>  .../gpu/drm/amd/display/include/dal_asic_id.h |  3 ++-
>  4 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8f53c9f6b267..f5941e59e5ad 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1014,6 +1014,14 @@ static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
>         }
>  }
>
> +bool is_skillfish_series(struct amdgpu_device *adev)
> +{
> +       if (adev->asic_type == CHIP_CYAN_SKILLFISH || adev->pdev->revision == 0x143F) {
> +               return true;
> +       }
> +       return false;
> +}

I don't see why we need this.

> +
>  static int dm_dmub_hw_init(struct amdgpu_device *adev)
>  {
>         const struct dmcub_firmware_header_v1_0 *hdr;
> @@ -1049,7 +1057,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>                 return -EINVAL;
>         }
>
> -       if (!has_hw_support) {
> +       if (is_skillfish_series(adev)) {

Why this change?  won't this break other asics with no hw support?

>                 DRM_INFO("DMUB unsupported on ASIC\n");
>                 return 0;
>         }
> @@ -1471,6 +1479,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>                 default:
>                         break;
>                 }
> +               if (is_skillfish_series(adev)) {
> +                       init_data.flags.disable_dmcu = true;
> +                       break;
> +               }

Should not be necessary.

>                 break;
>         }
>
> @@ -1777,7 +1789,6 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>         case CHIP_VEGA10:
>         case CHIP_VEGA12:
>         case CHIP_VEGA20:
> -               return 0;

This change seems unrelated and may break other asics.

>         case CHIP_NAVI12:
>                 fw_name_dmcu = FIRMWARE_NAVI12_DMCU;
>                 break;
> @@ -1805,6 +1816,9 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>                 default:
>                         break;
>                 }
> +               if (is_skillfish_series(adev)) {
> +                       return 0;
> +               }

Why do we need this?

>                 DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
>                 return -EINVAL;
>         }
> @@ -4515,6 +4529,12 @@ static int dm_early_init(void *handle)
>                 adev->mode_info.num_dig = 6;
>                 break;
>         default:
> +       if (is_skillfish_series(adev)) {
> +                       adev->mode_info.num_crtc = 2;
> +                       adev->mode_info.num_hpd = 2;
> +                       adev->mode_info.num_dig = 2;
> +                       break;
> +       }

Same here.

>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>                 switch (adev->ip_versions[DCE_HWIP][0]) {
>                 case IP_VERSION(2, 0, 2):
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index e35977fda5c1..13875d669acd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -82,7 +82,7 @@ struct common_irq_params {
>         enum dc_irq_source irq_src;
>         atomic64_t previous_timestamp;
>  };
> -
> +bool is_skillfish_series(struct amdgpu_device *adev);
>  /**
>   * struct dm_compressor_info - Buffer info used by frame buffer compression
>   * @cpu_addr: MMIO cpu addr
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index b36bae4b5bc9..318d381e2910 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>
>         case FAMILY_NV:
>                 dc_version = DCN_VERSION_2_0;
> -               if (asic_id.chip_id == DEVICE_ID_NV_13FE) {
> +               if (asic_id.chip_id == DEVICE_ID_NV_NAVI10_LITE_P_13FE || asic_id.chip_id == DEVICE_ID_NV_NAVI10_LITE_P_143F) {

I think these last two hunks are the only ones you need.  The rest
should be unnecessary.

>                         dc_version = DCN_VERSION_2_01;
>                         break;
>                 }
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index e4a2dfacab4c..37ec6343dbd6 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -211,7 +211,8 @@ enum {
>  #ifndef ASICREV_IS_GREEN_SARDINE
>  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
>  #endif
> -#define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
> +#define DEVICE_ID_NV_NAVI10_LITE_P_13FE          0x13FE  // CYAN_SKILLFISH
> +#define DEVICE_ID_NV_NAVI10_LITE_P_143F                        0x143F
>  #define FAMILY_VGH 144
>  #define DEVICE_ID_VGH_163F 0x163F
>  #define VANGOGH_A0 0x01
> --
> 2.25.1
>
