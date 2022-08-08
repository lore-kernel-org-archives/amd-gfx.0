Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1711C00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 20:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C91A11397B;
	Mon,  8 Aug 2022 20:13:00 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9711139B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 20:12:51 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 m22-20020a0568301e7600b006369227f745so7182463otr.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Aug 2022 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=9nFOgkUWZQoTPi78ykBoe5MsU+w8+emPElqRhRSxuJY=;
 b=o+zY8xOZtm/kUEfW9+LsHNe2Flr3xeeJ/SHSO8DtZj+6R3YqDvlTjci6NOWmRVPusm
 LdBPmzVEne+6YX61KDJJj+Y3kVg8iLzEjEdlXvlmMrnmN8bR1s6BO3tKM4QYmAigFuts
 JLzLD4WrUTD7DB27EYNAnMPwWl2KJnydRJeYktFYqTLEkHMs8B3gceHYDFqJlxpYcWeG
 w1zPE5Q5LLEiYBgQiD/ZN/9jWw+R5bAGWAogWzcaUGnxtaFP6lq4tJI8i7GDcIgpzEyH
 GJajQRKw5pbb8n4KV1oEuwItszpdRCr8nS6guXAiHwRi2McLsbKh5yUeB7em1TWCZEce
 wXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=9nFOgkUWZQoTPi78ykBoe5MsU+w8+emPElqRhRSxuJY=;
 b=GsnD9QF3rp54OtEnkD5Qcl3cPJJ6s8Z/zdJlqT/dPfRn7Y9ZMqmMmLa5PNP1WNECf+
 pm/kiZU+recn9j42HxO8nOjZ0dQpujiL5XPaVMs1PCHJIJMo+ul+4mJ6eeK9D7KWWOVp
 AocJylOWpjmih1azo6xx8FXcJCduLgGYQU/T3wXT4F4wxTuR7HvoQuuzU5rcWEaMM4rg
 AuG6Mrykjx4JdzYJkzbslKwWWJPovg2kHcYbV65N4fU3ZhGi/vEY3yZLs/7WA6SPoYyx
 90c0VRU6TWbiSe9e0J7yTTmhOHqQuMMiFt6EgCMcoe8RAu7XtrVcojRov+9hIWqVK3QM
 EOjA==
X-Gm-Message-State: ACgBeo3RPB9XXfXTIlXB4CXzdsXaheAUiS47d7e7lYbg62+2GfJ/UxSF
 JqnP+YdZI1zbhW3YQP60YzNXASa2TxYThYgu2vQ=
X-Google-Smtp-Source: AA6agR4amgFtXgeRZIrucEQFNJDGdgRXx0xLqtECLdb19c5mLJJI84R0uKrecG7SC/cqM1w0YclDC30X/4OYDIL14y8=
X-Received: by 2002:a05:6830:1298:b0:636:c70d:d4c2 with SMTP id
 z24-20020a056830129800b00636c70dd4c2mr4014188otp.383.1659989571152; Mon, 08
 Aug 2022 13:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220808103103.3143927-1-tim.huang@amd.com>
In-Reply-To: <20220808103103.3143927-1-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Aug 2022 16:12:39 -0400
Message-ID: <CADnq5_NNWH=fatzgnH=N6qrG2AwVJBxRrFsPMR3DnG0cmW7w1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: enable GFX Power Gating for GC IP v11.0.1
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

On Mon, Aug 8, 2022 at 6:32 AM Tim Huang <tim.huang@amd.com> wrote:
>
> Enable GFX Power Gating control for GC IP v11.0.1.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 35 ++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index e03618803a1c..319f07f61be5 100644
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
> @@ -5293,6 +5326,8 @@ static int gfx_v11_0_set_powergating_state(void *handle,
>         case IP_VERSION(11, 0, 2):
>                 amdgpu_gfx_off_ctrl(adev, enable);
>                 break;
> +       case IP_VERSION(11, 0, 1):
> +               gfx_v11_cntl_pg(adev, enable);

do we need to call amdgpu_gfx_off_ctrl(adev, enable); here as well?

Alex

>         default:
>                 break;
>         }
> --
> 2.25.1
>
