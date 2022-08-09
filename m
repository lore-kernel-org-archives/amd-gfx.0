Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28386C19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 13:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58FA4D593A;
	Tue,  9 Aug 2022 13:13:54 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4522DD5972
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 13:13:41 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 p22-20020a9d6956000000b00636a088b2aeso8438543oto.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Aug 2022 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=Sdd+bK9RHmv11f3++vQh9ImIZUktfaxA0jV5JhOxtmA=;
 b=kjQ0RlLMCC4YJ9BRxthWKSjW45pMsztJ2A0xHcwazL4Qnrzvi3359zZpv9Nex01wFR
 y0GAianGxv8QqnLP11w7C622EQkyniPrz79JLOiZxFiG3/N4D7RnK102HUv+x0PTT+q6
 rVHhUF9C8y8T7i/+QmsWIdDet5VE6JYESw80OP7BsaOkW6AAL9ijytzKWD7igadWOr8T
 zmR1oh9x5b4hYI2hkHHUasKNamcwMBlNGo5jmEMVwfIM2fGIm1bjOxNfPfAqdYOrJAv9
 fo0tMXgH7b6sQt63nPnOiiR/7s+hIYfMV/Y82WGtfZJVdz9ZLXXNprCKGWcKmxWXUK2P
 RuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=Sdd+bK9RHmv11f3++vQh9ImIZUktfaxA0jV5JhOxtmA=;
 b=CiHotLK8UX4sDd5qtBDh/zemXSq5FvFRLjNsPkstoxb6FcRX0Z8Y+V2gg8gSzQZRtJ
 Xs4A66RrrNC7LUhLFPeL/X1CPdX11U0u2zNnPOggpawkJrFCXGFJlkTxvaVBucyCKr4m
 Wl+MyR3XdilX5pFOKSUnG8xJeZOZLo7e+QtAOwut0OA2BQJwQxmSfp9wDIpJU2t8EvKz
 +wRlHhqLK/wyH0JGPaTUGBM4ojGTSdi6y5vAVzt+Vfgbn/oy7DQuIEcZ/pf90xKj3W3O
 vh1T4KOe0GBIXnwTEVpcRuV8vfFNBNGpGxT4QAjgvjQMTs5bLS0rcttiGDQFL0s0ErIM
 B9Lg==
X-Gm-Message-State: ACgBeo2vOfzlT1XJxcpP+c1ZvSsxCVRqeULSMdMgLm/YghP+Xcc6Q0I+
 l9b0IwWGEzybricvpFBBzDM/7Sq/Pz3p7VU3IK9yNf9e
X-Google-Smtp-Source: AA6agR6rVXyERsRmJYqr0l/jl2aOIhKBvsyBvpdYmBynRn6rGH3tpxdc14ZyrskSF+H8necl355V6o360REwFXweaA8=
X-Received: by 2002:a9d:c64:0:b0:636:df4c:e766 with SMTP id
 91-20020a9d0c64000000b00636df4ce766mr3785591otr.12.1660050820152; Tue, 09 Aug
 2022 06:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220809031956.3162090-1-tim.huang@amd.com>
In-Reply-To: <20220809031956.3162090-1-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Aug 2022 09:13:28 -0400
Message-ID: <CADnq5_MtkmHsxPQNnRZmPpry=Uw=Shq+OrAdTwGtCyxr187kjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: enable GFX Power Gating for GC IP
 v11.0.1
To: Tim Huang <tim.huang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Aug 8, 2022 at 11:20 PM Tim Huang <tim.huang@amd.com> wrote:
>
> Enable GFX Power Gating control for GC IP v11.0.1.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 38 ++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index e03618803a1c..158d87e6805d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -53,6 +53,7 @@
>  #define GFX11_MEC_HPD_SIZE     2048
>
>  #define RLCG_UCODE_LOADING_START_ADDRESS       0x00002000L
> +#define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1       0x1388
>
>  #define regCGTT_WD_CLK_CTRL            0x5086
>  #define regCGTT_WD_CLK_CTRL_BASE_IDX   1
> @@ -5279,6 +5280,38 @@ static const struct amdgpu_rlc_funcs gfx_v11_0_rlc_funcs = {
>         .update_spm_vmid = gfx_v11_0_update_spm_vmid,
>  };
>
> +static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
> +{
> +       u32 data = RREG32_SOC15(GC, 0, regRLC_PG_CNTL);
> +
> +       if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
> +               data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> +       else
> +               data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> +
> +       WREG32_SOC15(GC, 0, regRLC_PG_CNTL, data);
> +
> +       // Program RLC_PG_DELAY3 for CGPG hysteresis
> +       if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
> +               switch (adev->ip_versions[GC_HWIP][0]) {
> +               case IP_VERSION(11, 0, 1):
> +                       WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +}
> +
> +static void gfx_v11_cntl_pg(struct amdgpu_device *adev, bool enable)
> +{
> +       amdgpu_gfx_rlc_enter_safe_mode(adev);
> +
> +       gfx_v11_cntl_power_gating(adev, enable);
> +
> +       amdgpu_gfx_rlc_exit_safe_mode(adev);
> +}
> +
>  static int gfx_v11_0_set_powergating_state(void *handle,
>                                            enum amd_powergating_state state)
>  {
> @@ -5293,6 +5326,11 @@ static int gfx_v11_0_set_powergating_state(void *handle,
>         case IP_VERSION(11, 0, 2):
>                 amdgpu_gfx_off_ctrl(adev, enable);
>                 break;
> +       case IP_VERSION(11, 0, 1):
> +               gfx_v11_cntl_pg(adev, enable);
> +               /* TODO: Enable this when GFXOFF is ready */
> +               // amdgpu_gfx_off_ctrl(adev, enable);
> +               break;
>         default:
>                 break;
>         }
> --
> 2.25.1
>
