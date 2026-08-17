Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BE8C5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 13:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B20F10E7CE;
	Mon, 17 Aug 2026 13:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XpO4O54I";
	dkim-atps=neutral
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C2310E7CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 13:26:59 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5c3a84d3739so116505e0c.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 06:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786973218; cv=none;
 d=google.com; s=arc-20260327;
 b=kY72o8snpIg5ascmor7wwakPdcRTl1sKiF/2x84/fN70mBVnG+2p+zLdkWyPJFIQcC
 A/B+fjQFHhqOaWvySwTOtK6dWwGKSuY2m5603wLHHGRYf9HOHOrLWSeTjUBvl3oZcyBH
 zJk2Grp1EW6RX3qxhAOUxtd63XBHzbetOhTmwgZkq/PyAmtg2fXSgbv53E5KZvdfmSUd
 CSbyl5i8i6ma9kQWmZgvUoG2msVWvsofx/3g1J0cIQwbUgJmhQIXPmUBtIUDb4+EIm4r
 rAhgpdw93JKdkO7NnxOvB2v/PHrDr8shb3vnzLpAHSLRJliM0dJ21Rv2I1dKpEtZMnlo
 OmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iVd1i3NQ6ZOfITrD5COPv3UDlwNHN7CLeGfwkbUqtUM=;
 fh=ef20Xe9w3moUMLSr91PnwNIFupJfidka0pXpS8D+8d0=;
 b=nD4he9+E3iZW/sxvU59Uarp7i2zgyYsB9kwqdyIEcplZzdssJg+eF9/XGtSiQbVLN3
 aApsFUCmMH6vcNBtTgaRINkzKAfsjhahHnuRe9qNVuAPUpPfPYG/PI1F4sHEAiU9axxS
 YmmdTBojpoS03tuzQK8J+fijw3wGG23SJ/4XRo/NY1ZvH7au+LSemSTkdfzC/3OZuOIF
 UBKgmyfXiow/ZPR+81MY6QjjbI2GE9aE3VBg9uEF0mjk02gEetKUfVZnauWWSfuWik8w
 4PyjO0rk+Vfvig+Xizv5CpGdWNSDSK3kZoquG3cSKDgKkVO1YzFEaz8xV3ETZYtlflVX
 HnXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786973218; x=1787578018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iVd1i3NQ6ZOfITrD5COPv3UDlwNHN7CLeGfwkbUqtUM=;
 b=XpO4O54IY1MFKV03jgre6dRrYE/lFyoskD0ShacOSmJ6y6KxJDjk8aAEF8xu3tQCL/
 xvrdba9mo5SjSB1B51IoXhHKxKlh8aVSdlBsdcfLSzg3PdOQTqBCKhPXVUqbalCzOTiI
 WxcEMhKHUTd3jJWkQzQVl7Ofj6rFpz62h2L8iXxfubWN2wnZNFibeEDkQNxsDOEoSFqR
 i1YMCTxtqITb79v9p7YRjbZFYZzrDpG/okEiDIWhFpkmHFPGA7w0sXTKLd2go+lINdma
 Y6RfmCQy+LFA2RdkNKFS0g6GerYmgx+BroDhkeKdTY5SVrLJK9wShuL1nViKoG43aN3e
 XAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786973218; x=1787578018;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iVd1i3NQ6ZOfITrD5COPv3UDlwNHN7CLeGfwkbUqtUM=;
 b=D6TDq7hzc9vqYv/FcMYpJFL1nkqjFN+gaYXCcHVN1y1s8SL3kvuEDsnxQZPMXV0sbP
 fnD7RnDCSdMun6fmKgTuBsavaXzfwyDfnifeFHgWHkpmECdTPC+ErU1vywb2Y0DcRekS
 mjCHkcxgtraUNMbWzy0aOW+3kpslemtn4RmFSsXVfvtjht02uWMiqyjfuWYaArxIcXY2
 pHWrH9fC42F8GoZu4AXTrAa60m7zqvThSfTtAY55H9Cv+eV2zTTeRvSwSZM44/5Mf2ae
 oM2YuQ8w+VvURrhaKnTpz6O2LcdI1yMcxgPvBdXdPUQYcSz69ZFYwbON2TmUlDrc9IXj
 e9SQ==
X-Gm-Message-State: AOJu0Yxcs3QAxtrkt/31R7xhcXj3fwCLe+XZponkJqADbAWjvVzupqeY
 yreAYYci8rNmd+XpCE9hPHYwVle7Ol2OSRumZ8WukNKIJfefrrGYrTHNg8KJeXqGxXZ1azdOAeI
 2UpG/xcu6AsG0iYlxPCVAw87jNE7m8Yw=
X-Gm-Gg: AR+sD13TGJjBNCAZlWwL7vxjIiK5gjcgymp4DfVNGwgCe6/mWjcOvJCgkFn83KHvvzD
 x6KLy+N2ix/ynp2KFbEKxExdIsiyPb1eHCAJm2zM2Pg8lPBrrNDK4uzKrFaehnbWjpV3pDBj8fM
 6fHUoEdorIPOUCOBHi2EyRSRYIgw3HwN2eyuzq6gjfvf/WYcN+AEP0RMBnjmDK57co+55hWdT7I
 ETBSf5UYB/pFL17izyrmn2dHo+mYOE72poF16tI5am/qUze6hczPdpsqXWiUOKjbFeEUWKD8/bC
 uFjZPiQc6wGd/hjlQfzXcBes30sYfE9z6/uyeRKmhBuEOzZmYt8elwCgff0x53p1P4wlyibH3Dm
 07NczAGtp+fD4xwvGVPeduwggmG/sRsg=
X-Received: by 2002:a67:fe10:0:b0:772:cccb:f851 with SMTP id
 ada2fe7eead31-772cccc075emr358743137.0.1786973217597; Mon, 17 Aug 2026
 06:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260817062728.2535467-1-kevinyang.wang@amd.com>
In-Reply-To: <20260817062728.2535467-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 09:26:45 -0400
X-Gm-Features: AcwNN1UbGgH9T6q8Hw38z65PPRB6RgiKr8o72m7duJkYNgLo1JzpQEvh1nyf_i4
Message-ID: <CADnq5_PhiEzW7eA311hSyCo=ve1Bx2dBUEf3LArLbPTK2s==Ww@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix smu messages after system resume for smu
 11.0.x
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 hawking.zhang@amd.com, kenneth.feng@amd.com
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

On Mon, Aug 17, 2026 at 3:45=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> SMU 11.0.x can retain an unfinished command across system
> suspend, causing SMU messages such as RunDcBtc to fail during resume.
>
> Prepare MP1 for unload during system suspend and record successful comple=
tion,
> reload SMC firmware after PSP restart before resume sends further SMU mes=
sages,
> then clear the reload state.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Is there any reason not to do mp1 unload for all dGPUs in this case?

>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5620
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  9 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  2 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 38 ++++++++++++++++++++---
>  3 files changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 04f6ebf31cca..5c00683c1edd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3512,11 +3512,16 @@ static int psp_load_non_psp_fw(struct psp_context=
 *psp)
>         struct amdgpu_firmware_info *ucode;
>         struct amdgpu_device *adev =3D psp->adev;
>
> -       if (psp->autoload_supported &&
> -           !psp->pmfw_centralized_cstate_management) {
> +       if (psp->smu_fw_needs_reload ||
> +           (psp->autoload_supported &&
> +            !psp->pmfw_centralized_cstate_management)) {
> +               if (psp->smu_fw_needs_reload)
> +                       dev_dbg(adev->dev,
> +                               "Reloading SMU firmware after MP1 unload\=
n");
>                 ret =3D psp_load_smu_fw(psp);
>                 if (ret)
>                         return ret;
> +               psp->smu_fw_needs_reload =3D false;
>         }
>
>         /* Load P2S table first if it's available */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index d80c85793e3b..20338caa4921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -443,6 +443,8 @@ struct psp_context {
>         bool                            boot_time_tmr;
>         /* flag to mark whether df cstate management centralized to PMFW =
*/
>         bool                            pmfw_centralized_cstate_managemen=
t;
> +       /* SMC firmware reload required during resume */
> +       bool                            smu_fw_needs_reload;
>
>         /* xgmi ta firmware and buffer */
>         const struct firmware           *ta_fw;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 559afdc5815d..8d499d9a86df 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2182,12 +2182,36 @@ static int smu_smc_hw_cleanup(struct smu_context =
*smu)
>  static int smu_reset_mp1_state(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
> -       int ret =3D 0;
> +       u32 mp1_version =3D amdgpu_ip_version(adev, MP1_HWIP, 0);
> +       bool needs_mp1_unload;
> +       int ret;
>
> -       if ((!adev->in_runpm) && (!adev->in_suspend) &&
> -               (!amdgpu_in_reset(adev)) && !smu->is_apu &&
> -                       amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D IP_VERS=
ION(13, 0, 0))
> -               ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
> +       if (adev->in_runpm || amdgpu_in_reset(adev) || smu->is_apu)
> +               return 0;
> +
> +       switch (mp1_version) {
> +       case IP_VERSION(11, 0, 7):
> +       case IP_VERSION(11, 0, 11):
> +       case IP_VERSION(11, 0, 12):
> +       case IP_VERSION(11, 0, 13):
> +               /*
> +                * These SMU versions require MP1 unload before system su=
spend.
> +                * The shutdown path already requests it through mp1_stat=
e.
> +                */
> +               needs_mp1_unload =3D adev->mp1_state !=3D PP_MP1_STATE_UN=
LOAD;
> +               break;
> +       default:
> +               needs_mp1_unload =3D !adev->in_suspend &&
> +                       mp1_version >=3D IP_VERSION(13, 0, 0);
> +               break;
> +       }
> +
> +       if (!needs_mp1_unload)
> +               return 0;
> +
> +       ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
> +       if (!ret && adev->in_suspend)
> +               adev->psp.smu_fw_needs_reload =3D true;
>
>         return ret;
>  }
> @@ -2279,6 +2303,10 @@ static int smu_suspend(struct amdgpu_ip_block *ip_=
block)
>         if (ret)
>                 return ret;
>
> +       ret =3D smu_reset_mp1_state(smu);
> +       if (ret)
> +               return ret;
> +
>         smu->watermarks_bitmap &=3D ~(WATERMARKS_LOADED);
>
>         smu_set_gfx_cgpg(smu, false);
> --
> 2.54.0
>
