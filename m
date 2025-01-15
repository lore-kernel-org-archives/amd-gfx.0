Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D968C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 14:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3989A10E703;
	Wed, 15 Jan 2025 14:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LGlcxqSU";
	dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC9910E70F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 14:44:54 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ef718cb473so1378723a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736952293; x=1737557093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+T0ibS9Muecg0g+9yb54W1/k8m8i41e89s2lHZ6k7I=;
 b=LGlcxqSURVBjCM8IFm6WIl2oELFxMA6q2urdg596ycgMvT9bXJAy+a9e4V5mDnNRd5
 P38qZeDDYQ+LMhu6ubYMUqRnjM6q+PsJXrzKvl50Ouc+5HDT5EIQYRdqHBTl365jza2O
 QKKuLPATSf64ZzUMw9Ep21FHodU83ewJ6Ob2S6A1Dp2BHKK/Id2EdZcTFVigRTxsZAyb
 RgWAMjsQHsGU4JsvtBmsEuM5VkjLsMfpnQB2I6uc79pKWf4u+e9XLQwdQaFpk3W17O05
 eh1puSQgbKKpNKJQPVHjSsFNnrHjsqsx42ZQDzRX/NuFIn3qRJAKURNDOuUHg1x6RKgs
 /GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736952293; x=1737557093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+T0ibS9Muecg0g+9yb54W1/k8m8i41e89s2lHZ6k7I=;
 b=T0o5PaVjZQYeQWuVzJTBpl0cb7X2IGHPyvco7XwaVWU9Yy+RKibr3nmM0uvupp1ki6
 BK4XnhgLGVuSN3f1WQV7wRoXsW6+LOahud4j0e6VvVLTSffu7uebR8mKGw04RT/d6tb6
 X8PC4RippHDAIXjbqFELGBGPQkyRsnGQUkkGeY6TgckoeI4r++4UQLg0flYwtflDIHoW
 bINDo1PT/YPHBfWDhNv3aUhpDPCMVNoV2nNl4Foc5T4HGZEeUdbI71r1YPXZwECvOX06
 9rLQ9SYe2276ZUwLTO5wdW6rkG6WDuBcee/dlGoOn48LloppF9o9sV6/Pre3ddMynVLW
 5l7Q==
X-Gm-Message-State: AOJu0Yyt6aMPAIDFF7xrcqVH4/RUMR2Jz5YSdBzka0zUPeXkzGhf14Tk
 TP+qIBHGbFVQw5jQbPNAORoISe/H1sTcSnPVdpAT4D2dGT7L+nMPY3r1eExzlhTyGGMtdbjtaqS
 Sox5WX2Dpi6vSQT6sp2qiRTnA9Y+9kw==
X-Gm-Gg: ASbGncu/s7BV9Sp9bG+ZSa4X1UsZwJInkXBZTLHexStX2WS0p/6Ck3cD2Zim04dQ0X/
 9lrI27cOzOMPANb9imcAj+DvfNuajaCDV0sdZbA==
X-Google-Smtp-Source: AGHT+IHrXKTWGfJgaO7Q6IFfVo+qli2puSanNaXcGwX3nsZ/lOzr5hqHH963PmBRTFIAjwduDz0tfiKlSR+OzzQDzUw=
X-Received: by 2002:a17:90a:e183:b0:2ea:956b:deab with SMTP id
 98e67ed59e1d1-2f5490fa85emr16612045a91.4.1736952293545; Wed, 15 Jan 2025
 06:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20250115035022.531358-1-shaoyun.liu@amd.com>
In-Reply-To: <20250115035022.531358-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jan 2025 09:44:40 -0500
X-Gm-Features: AbW1kvYDcn_f3pmGcm1LbLSGEbm72TAJZMEZrmMNsv0gXrhBoRT1-HUIFkAG6uo
Message-ID: <CADnq5_PYHnaBE-pAfarEtf65fXz_7G8RyiRhu3QynHmWzkHZ6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Enable scratch data dump for mes 12
To: Shaoyun Liu <shaoyun.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, Jan 14, 2025 at 11:02=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> =
wrote:
>
> MES internal will check CP_MES_MSCRATCH_LO/HI register to set scratch dat=
a location
> during ucode start, driver side need to start the MES one by one with dif=
ferent
> setting for each pipe
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 43 +++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index d24a0e7fff15..f79edff19333 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -992,29 +992,47 @@ static void mes_v12_0_enable(struct amdgpu_device *=
adev, bool enable)
>         uint32_t pipe, data =3D 0;
>
>         if (enable) {
> -               data =3D RREG32_SOC15(GC, 0, regCP_MES_CNTL);
> -               data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET=
, 1);
> -               data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET=
, 1);
> -               WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
> -
>                 mutex_lock(&adev->srbm_mutex);
>                 for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
>                         soc21_grbm_select(adev, 3, pipe, 0, 0);
> +                       if (amdgpu_mes_log_enable) {
> +                               uint32_t log_size =3D AMDGPU_MES_LOG_BUFF=
ER_SIZE + AMDGPU_MES_MSCRATCH_SIZE;
> +                               /* In case uni mes is not enabled, only p=
rogram for pipe 0 */
> +                               if (adev->mes.event_log_size >=3D (pipe +=
 1) * log_size) {
> +                                       WREG32_SOC15(GC, 0, regCP_MES_MSC=
RATCH_LO,
> +                                               lower_32_bits(adev->mes.e=
vent_log_gpu_addr + pipe * log_size + AMDGPU_MES_LOG_BUFFER_SIZE));
> +                                       WREG32_SOC15(GC, 0, regCP_MES_MSC=
RATCH_HI,
> +                                               upper_32_bits(adev->mes.e=
vent_log_gpu_addr + pipe * log_size + AMDGPU_MES_LOG_BUFFER_SIZE));
> +                                       dev_info(adev->dev, "Setup CP MES=
 MSCRATCH address : 0x%x. 0x%x\n",
> +                                               RREG32_SOC15(GC, 0, regCP=
_MES_MSCRATCH_HI),
> +                                               RREG32_SOC15(GC, 0, regCP=
_MES_MSCRATCH_LO));
> +                               }
> +                       }
> +
> +                       data =3D RREG32_SOC15(GC, 0, regCP_MES_CNTL);
> +                       if (pipe =3D=3D 0)
> +                               data =3D REG_SET_FIELD(data, CP_MES_CNTL,=
 MES_PIPE0_RESET, 1);
> +                       else
> +                               data =3D REG_SET_FIELD(data, CP_MES_CNTL,=
 MES_PIPE1_RESET, 1);
> +                       WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
>
>                         ucode_addr =3D adev->mes.uc_start_addr[pipe] >> 2=
;
>                         WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START,
>                                      lower_32_bits(ucode_addr));
>                         WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START_HI=
,
>                                      upper_32_bits(ucode_addr));
> +
> +                       /* unhalt MES and activate one pipe each loop */
> +                       if (pipe =3D=3D 0)
> +                               data =3D REG_SET_FIELD(0, CP_MES_CNTL, ME=
S_PIPE0_ACTIVE, 1);
> +                       else
> +                               data =3D REG_SET_FIELD(0, CP_MES_CNTL, ME=
S_PIPE1_ACTIVE, 1);
> +                       WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
> +
>                 }
>                 soc21_grbm_select(adev, 0, 0, 0, 0);
>                 mutex_unlock(&adev->srbm_mutex);
>
> -               /* unhalt MES and activate pipe0 */
> -               data =3D REG_SET_FIELD(0, CP_MES_CNTL, MES_PIPE0_ACTIVE, =
1);
> -               data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIV=
E, 1);
> -               WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
> -
>                 if (amdgpu_emu_mode)
>                         msleep(100);
>                 else if (adev->enable_uni_mes)
> @@ -1488,8 +1506,9 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         adev->mes.kiq_hw_fini =3D &mes_v12_0_kiq_hw_fini;
>         adev->mes.enable_legacy_queue_map =3D true;
>
> -       adev->mes.event_log_size =3D adev->enable_uni_mes ? (AMDGPU_MAX_M=
ES_PIPES * AMDGPU_MES_LOG_BUFFER_SIZE) : AMDGPU_MES_LOG_BUFFER_SIZE;
> -
> +       adev->mes.event_log_size =3D adev->enable_uni_mes ?
> +               (AMDGPU_MAX_MES_PIPES * (AMDGPU_MES_LOG_BUFFER_SIZE + AMD=
GPU_MES_MSCRATCH_SIZE)) :
> +               (AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE);
>         r =3D amdgpu_mes_init(adev);
>         if (r)
>                 return r;
> --
> 2.34.1
>
