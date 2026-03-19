Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317B41090223
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 12:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B3B10EA08;
	Thu, 19 Mar 2026 12:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OSiWJBb0";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC40E10EA08
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 12:57:32 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-127148c2112so92730c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 05:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773925052; cv=none;
 d=google.com; s=arc-20240605;
 b=Rk4CCDCVdP5FysXshiokAcsNGe1g8IHG8LiE3/1MCTVxnj5Vp06rcdMHpz3dPLkzAb
 /x8D/TSZJb7ZrRfN571gjUh0mrHL4SE819jdA8QlOsqYITtjno3J/tWjNoYv0dEOwRUV
 X5XKRBhBOawik4ik8fSp2ZjRTtCQIGT7g6HZU0Kqsuk9BhySZugMu2Abu5XmLQiuN5fq
 f/dGSKveTy5UkHmK/aaxsCGu6YZVamHuf48euOeROYRXkyuw7BFW3122zs6qUlNp0Hj4
 XqqFED7olb/wYe9s0bJKNrDvW+SnhibMt3xZdAL6A/f3eQU0B6R6RFo/KanD5t0VBPGh
 0ksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=83PwkEGmCKDs3jaXOG2oRx8BToDpLy7MsIIkVBwtad8=;
 fh=ef20Xe9w3moUMLSr91PnwNIFupJfidka0pXpS8D+8d0=;
 b=TMsUD2u9AeQNRO6uZ2NTQHgBdbd2NgW51DIB+WhSKfjKbcWmDFOqbtAcYXuoPdQA/Z
 sPqZ89ZmBA5Xo8HEA8VjOHM8LfXn72kBsv3tptSwVjbqB4KzTuf2hjeP/h8I8/K220Jn
 Zvh4lOcuHDOwLacn6Dnf1TBPcvS3x++8ZaPz+nTP+vhhitHJT3819Xyz9AE/HxRWJC2T
 sMrmZi66+XgqNV5M4FvvMV+HjM2uEEUqiAM1hW2OKo5YfH9WiJEXsxCUhMmt/4yDeKzn
 Smxh4AjE+7r2TVvk/OXD2rLvBsXpX7IEiKGfhoqdbTNc5g3c5IDtQTV5TU1zGP+RSwMP
 K1aA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773925052; x=1774529852; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83PwkEGmCKDs3jaXOG2oRx8BToDpLy7MsIIkVBwtad8=;
 b=OSiWJBb0tLFwAnAWnpL5ZsrQ2IBzX6ROQTdcmiV4AslB2PeSToIAzEKaOybeYql7b7
 YnlcIRwjSYR10gN4ubLpuxT6n/dhcnj2yLO49+LjTIxfX6IxQZ5gWY4SjGMOg/dAczHm
 9+MHPu2EveBpaaVutl0+ssUmA5dTLZImZE3u2r9DcLwDzFF7vILcymKEa3XSEsOFiCeT
 UOcPDL7WCSXO/QxeadBMz8xkcdWvfJMcw8TszkAJu/4Kqmapm2Ob15d40WNCTpKlVynG
 lTLianYto1KkN1EmUP+0KRuzIw8o++UVojIGSy57mCmtVsbBuircxSQmwc4c+N26We9I
 yWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773925052; x=1774529852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=83PwkEGmCKDs3jaXOG2oRx8BToDpLy7MsIIkVBwtad8=;
 b=F8JzzMb3X5gng8SJDvB5CCQ3VeW3UWPlkNdmsvNKUWXR5tyPsgm2Ta3nfmGk/Ox9Bm
 xlMZp+qW17qTJ2ASuIfbQ7uQQx8/yo+mGqERqKqBbLq6KwcI/QyvboAlnyvp/y8y/ah7
 DNyD8CdVxlXFSSezMxTtKocACAwo0mpiV8Ah0Flpxx0M3cVpN/U3N/ZcrfzDJ7gAciA/
 eKTWCc9wMByUYiEDKAmSi+atbGIptgqo0QPriQQGMZUi6KhsSuKdOJR08l5tNJczq2Lo
 VVy1Pl/cPk7KQBFvnNMLHr1PVsmGOdNrfh6CkpB4W+DPZextrgZtWQqMSIs9Fvxriugm
 KYGQ==
X-Gm-Message-State: AOJu0Ywgwp4YiZDI3FdbXn9vpUianqSG/dTPceuaHSdWhQfEM/Xobme5
 5Na/ciIGSCAllfWfQgiETrqG5DQJ3ZeIY1ZbiIk5tdOelNJBAVQTQAuWpmWAJ0DiXHyHzNsgg63
 Sb69hrIW19fKFMYRGpHYRCxBEhvjmyuI=
X-Gm-Gg: ATEYQzx3DYJhggFb/Kr5fX56/VsQGwm8CEvVD3ya6x7EqZQJZTmQQOz6U+CJP2/wRkQ
 eQB44zE4r3pnlwkLUpw/V9WIRLetPEI2mH8Mg84AKFLxs00kIDtfqKsXpOOTsTyEh+U3oAICFDU
 pi+hokPrNAmDGoOc/BO+fNsTRGQPWr7Obtzopu+M3GOR+tOAkq/4ohFCb5yP5QcMzjCSgVbGU8w
 i+635Ew2ZCuCpr4WXVaz4bAhp08wMMc1iBPzaDpRTPYIXC4yFbeT8UdDanUOaNBMdPGrnpTjbVt
 JpMQvsBInVdlLmwAmdB3J9ss4iCSLEYXLqqZkrJbMQPCCtFV8wspeCmpwJqt6OE2XoJSGg==
X-Received: by 2002:a05:7022:3f08:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-129a7147f94mr1328047c88.4.1773925052003; Thu, 19 Mar 2026
 05:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260319081541.70848-1-kevinyang.wang@amd.com>
In-Reply-To: <20260319081541.70848-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Mar 2026 08:57:20 -0400
X-Gm-Features: AaiRm51nsY2aRrLVaolnIqh1CS94hUIXnbBj0Bb0TKQpsHW2Jv-bnP2ydvH6N-I
Message-ID: <CADnq5_N3E70+QCZGDY11BoRJNm-+EtvRgDAQBMgE7HB0dv8PrA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range
 invalid
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

On Thu, Mar 19, 2026 at 4:24=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> Forcibly disable the OD_FAN_CURVE feature when temperature or PWM range i=
s invalid,
> otherwise PMFW will reject this configuration on smu v14.0.2/14.0.3.
>
> example:
> $ sudo cat /sys/bus/pci/devices/<BDF>/gpu_od/fan_ctrl/fan_curve
>
> OD_FAN_CURVE:
> 0: 0C 0%
> 1: 0C 0%
> 2: 0C 0%
> 3: 0C 0%
> 4: 0C 0%
> OD_RANGE:
> FAN_CURVE(hotspot temp): 0C 0C
> FAN_CURVE(fan speed): 0% 0%
>
> $ echo "0 50 40" | sudo tee fan_curve
>
> kernel log:
> [  969.761627] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) mu=
st be within [0, 0]!
> [ 1010.897800] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) mu=
st be within [0, 0]!
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 33 ++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 0b78e62cd3b0..8ab99a8e2790 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -56,6 +56,10 @@
>
>  #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.sm=
u_i2c))
>
> +static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
> +                                             int od_feature_bit,
> +                                             int32_t *min, int32_t *max)=
;
> +
>  static const struct smu_feature_bits smu_v14_0_2_dpm_features =3D {
>         .bits =3D { SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
>                   SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
> @@ -928,8 +932,35 @@ static bool smu_v14_0_2_is_od_feature_supported(stru=
ct smu_context *smu,
>         PPTable_t *pptable =3D smu->smu_table.driver_pptable;
>         const OverDriveLimits_t * const overdrive_upperlimits =3D
>                                 &pptable->SkuTable.OverDriveLimitsBasicMa=
x;
> +       int32_t min_value, max_value;
> +       bool feature_enabled;
>
> -       return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature=
_bit);
> +       switch (od_feature_bit) {
> +       case OD_FAN_CURVE:
> +               feature_enabled =3D !!(overdrive_upperlimits->FeatureCtrl=
Mask & (1U << od_feature_bit));
> +               if (feature_enabled) {
> +                       smu_v14_0_2_get_od_setting_limits(smu, PP_OD_FEAT=
URE_FAN_CURVE_TEMP,
> +                                                         &min_value, &ma=
x_value);
> +                       if (!min_value && !max_value) {
> +                               feature_enabled =3D false;
> +                               goto out;
> +                       }
> +
> +                       smu_v14_0_2_get_od_setting_limits(smu, PP_OD_FEAT=
URE_FAN_CURVE_PWM,
> +                                                         &min_value, &ma=
x_value);
> +                       if (!min_value && !max_value) {
> +                               feature_enabled =3D false;
> +                               goto out;
> +                       }
> +               }
> +               break;
> +       default:
> +               feature_enabled =3D !!(overdrive_upperlimits->FeatureCtrl=
Mask & (1U << od_feature_bit));
> +               break;
> +       }
> +
> +out:
> +       return feature_enabled;
>  }
>
>  static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
> --
> 2.47.3
>
