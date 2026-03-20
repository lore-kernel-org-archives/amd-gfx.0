Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A6A1099B33
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 18:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2AB610EA21;
	Fri, 20 Mar 2026 18:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ExUtI9Ju";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D6010EA21
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 18:15:17 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1273c690e5bso213018c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 11:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774030516; cv=none;
 d=google.com; s=arc-20240605;
 b=f1i44I5sFxyoisMAYPpKD1ZjbOaTyka7cPokdrL/3e2qqssw6NPXCE0UD3JDbYibfy
 FydNOvOP7zyEP9tyR/w6jy9yA+AWGZ+MZC+MQt3DfYfnoG11Z9CG++CKjJ8c7oobGCW6
 oxbN4VSrm9AieUzf5t7wV15YC8Sw0nhrHHUoKe0Sig0fxr4KGN74QXvHWOfN1ZMYxpci
 tibJ1C+H0SE4xsTSX7yp7CS8GKuyo1ACLnopDvIDdq9JWmys7BOlMXoo+uBG2sSHx9Z+
 5hrts+xFSeeuIGCvnpN+3fA0hvV8eamk1PWo+p8aWSGCFOaIAmN0LvC7pRZ0Z+hxLMC8
 hX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3gYu0lPwzdGEz1Yi5GTTKkhY/44T3z177ERghSZGOPM=;
 fh=71VkXJtsWnrS0YqLNTqW148VSsoh0S3c+hQD0YDWlqM=;
 b=EBULWNduN9hR44olsXi4HErx/pAvdk0zpRaKRtCoP6GSurX8JC/BY1GKa1FNYldbQ4
 T7FgfCqyCclvoGcIuuM+OEspZWWabZQJ3y5A1wABWmOsGeqDvb3FVdw/h79tRjsx6Hjw
 eNI2GFculFgaUE/87TBdYcMX16Y615pP1ZgI9DJGs1QQorFuLABcgjIVG8J0r9KTvvsx
 XWD1SiOTvGbyLnr9iVND2AdfzgXXL5w6ylqYXeWIoJ3yjFF6XeFJ52WKo4T2OOWmh8zz
 64rkTML5FEnjDMa+RdSyeqSzqufD68fbGDMwadTiCR7uZNV6visKHsk1UzR/RESycs6W
 InrA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774030516; x=1774635316; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gYu0lPwzdGEz1Yi5GTTKkhY/44T3z177ERghSZGOPM=;
 b=ExUtI9JukNuu2ygUjsrFAtZPg0ysOYs8wqG5c3b+naoPgFMmjDwHRWuhM6+wfwhPoz
 OVXlb+CYk9XUaucZWt9nHbip5tRpzoit8YlkR8J3AtZi3l3lQZ/nlhFzeOzBBQvBABop
 29x6vX5X5VE5Zus71C3m+krhGRQsZ6m7fHzTjSA6W5JOQhvD/2iXZND43uB/Q6kqqML/
 xDIg/dnIHH2I0fuamcZrDtV7VqE3h3Zld+wevISclmwIU06wzhBimAcZsBA4TmO/gsyJ
 GfyZBOYgdjZuOGrT107PBtxeY5bV7v/kY8uo+fMA+USS20n7vcUJK138v+U9cMhM9tgz
 bqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774030516; x=1774635316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3gYu0lPwzdGEz1Yi5GTTKkhY/44T3z177ERghSZGOPM=;
 b=GHc5ZPyoN/mkMC1ezYv9vnQts9+sg7LFwQTXj4xv7Tx2xvOS9uHrpE7tqirblIp8m3
 Raj5k+hlc4VVqPCezxaAb8qKsmEui2Eo+mXGb7JL00ObwZCiS1EYDIxhe0YRhujP1tSb
 RWr2XyzkJYFfWWi4rtvtz2JbwAZVNgyV5j5HjOtZt8llp+58XuIibPEP52piyb1jsHMU
 IrmMjywonVKwNJ6RZheqdMSJ5TXK1arJPoho9RhBNcVkss3dpiXvDWXl4ICxMUOomPSo
 dqC/o/WVyHsJxHrodg+5em2M4NIKCwvrBA34nLvot1uVhIT1Gn0lTaT96VNndTyDsx5e
 TdtA==
X-Gm-Message-State: AOJu0Yxvg/Ix3uADa+8PHQzaBiXDgvLGtWk7QRZsOrILRHg6oinI2SKG
 s7GSpaBei7n8rIkQiBXrkDdgwL/ib3hyN2+54KSGiFKj2MWhmgeehkAp1oBy+yjngCZpq6IzKVD
 oYTCypZwDR7tG7FN5ZCw03TcWKNJ0z5I=
X-Gm-Gg: ATEYQzyWikhjc+LXEVR3PPtQ2yNSqoToSDcv38zzbJVPPnYfTBDChXALOqH9a1lvjSC
 882xW9BqUZ3xMK3UUpjpS/uvXCQW9XJI/19WZNEJEnsMWHwqHSvAqjqn9mZVdi9dvC3Asl35Y5u
 5fL5dSl7AM6no5vzFpgotPeWSwHwvNZgoMk4qT3SJbtpswSLyi2jDQMRAyVcrKEN9uEjHt/U5sG
 /uzm2GbBABkFBVaiA2WGdZxGoa/8NCt4JzZnCKBIUCIK6G/carAxKWvqOtWvmokxx7faDh1Wse/
 xlK4AIJRs0Z536M5voMfjSCQGoM36PwOAUXZyClog7E6DRInteE/fjP1M6zfE9UGoFVIUMG/TpB
 rgVu1
X-Received: by 2002:a05:7022:699b:b0:12a:716c:d27c with SMTP id
 a92af1059eb24-12a726569ecmr892155c88.2.1774030516193; Fri, 20 Mar 2026
 11:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260320014800.228582-1-kevinyang.wang@amd.com>
 <DM6PR12MB2972DD522606573881D360A8824CA@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2972DD522606573881D360A8824CA@DM6PR12MB2972.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Mar 2026 14:15:05 -0400
X-Gm-Features: AaiRm52leodgeIrk-FlZME-OPWBSET3TcPTz66w-E4exI5OZ73uYWRWnxYbQWrk
Message-ID: <CADnq5_MO0L=BXcwMi3-Xe_OErm4n=+2h2hJdwuPMZQXBHUcLTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range
 invalid for smu v13
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
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

On Thu, Mar 19, 2026 at 11:24=E2=80=AFPM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Extra information:
>
> [Issue]: Can not set fan speed on Radeon Pro W7900
> Closes: https://github.com/ROCm/amdgpu/issues/208

With that line added to the commit,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang W=
ang
> Sent: Friday, March 20, 2026 09:48
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawki=
ng.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH 1/2] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm rang=
e invalid for smu v13
>
> Forcibly disable the OD_FAN_CURVE feature when temperature or PWM range i=
s invalid, otherwise PMFW will reject this configuration on smu v13.0.x
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
> [  756.442527] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) mu=
st be within [0, 0]!
> [  777.345800] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) mu=
st be within [0, 0]!
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 ++++++++++++++++++-  =
.../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 33 ++++++++++++++++++-
>  2 files changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index cd077151f3e4..9be7a2af560d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -59,6 +59,10 @@
>
>  #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.sm=
u_i2c))
>
> +static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
> +                                             int od_feature_bit,
> +                                             int32_t *min, int32_t *max)=
;
> +
>  static const struct smu_feature_bits smu_v13_0_0_dpm_features =3D {
>         .bits =3D {
>                 SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
> @@ -1044,8 +1048,35 @@ static bool smu_v13_0_0_is_od_feature_supported(st=
ruct smu_context *smu,
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
> +       case PP_OD_FEATURE_FAN_CURVE_BIT:
> +               feature_enabled =3D !!(overdrive_upperlimits->FeatureCtrl=
Mask & (1U << od_feature_bit));
> +               if (feature_enabled) {
> +                       smu_v13_0_0_get_od_setting_limits(smu, PP_OD_FEAT=
URE_FAN_CURVE_TEMP,
> +                                                         &min_value, &ma=
x_value);
> +                       if (!min_value && !max_value) {
> +                               feature_enabled =3D false;
> +                               goto out;
> +                       }
> +
> +                       smu_v13_0_0_get_od_setting_limits(smu, PP_OD_FEAT=
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
>  static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu, d=
iff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index a1d50654db72..5cc15545da6e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -59,6 +59,10 @@
>
>  #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.sm=
u_i2c))
>
> +static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
> +                                             int od_feature_bit,
> +                                             int32_t *min, int32_t *max)=
;
> +
>  static const struct smu_feature_bits smu_v13_0_7_dpm_features =3D {
>         .bits =3D {
>                 SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
> @@ -1054,8 +1058,35 @@ static bool smu_v13_0_7_is_od_feature_supported(st=
ruct smu_context *smu,
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
> +       case PP_OD_FEATURE_FAN_CURVE_BIT:
> +               feature_enabled =3D !!(overdrive_upperlimits->FeatureCtrl=
Mask & (1U << od_feature_bit));
> +               if (feature_enabled) {
> +                       smu_v13_0_7_get_od_setting_limits(smu, PP_OD_FEAT=
URE_FAN_CURVE_TEMP,
> +                                                         &min_value, &ma=
x_value);
> +                       if (!min_value && !max_value) {
> +                               feature_enabled =3D false;
> +                               goto out;
> +                       }
> +
> +                       smu_v13_0_7_get_od_setting_limits(smu, PP_OD_FEAT=
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
>  static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
> --
> 2.47.3
>
