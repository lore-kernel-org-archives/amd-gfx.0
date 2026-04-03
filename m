Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC91BE85363
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 12:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFEA10E476;
	Fri,  3 Apr 2026 12:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iJLAl7k0";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C041810E550
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 12:57:26 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-124a7216c9cso75965c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 05:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775221046; cv=none;
 d=google.com; s=arc-20240605;
 b=L3lCSzyVHiOCzPNjkL00Ai9l6L9PrvYsUxrLypS0N+iG36VmmbiPOXzCn9U/MYKc/R
 K0hOodvJIMBsmm4fjZbxUY1h2MpFNmy0tGGH7b+77pR/n+C2y0dyxo/CtVh2379iTEOY
 Rg3/C7sy5vnbxmY7JgTce+Id2/eKDI79PeUAF6BKftb6d/yQZV8STDx7kQOY6gzuRx/T
 NMylb6MmjjV0HSW7qdwPoV1VA6/ffZrui8GLo1oftJvj/JVh/GhSIZ5yktDRl5PtzivL
 yhxDR4phQkD/DJxRsV7vFxWcYhPATuGNMtNa0CDoGp0ocFtUew1vGx7ytHLdnMb5j3M5
 40qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w5EpPaF03+EWzTT/ksMfj0GtsAPDo2AFHs2WM6xMAs0=;
 fh=ef20Xe9w3moUMLSr91PnwNIFupJfidka0pXpS8D+8d0=;
 b=XxNoNHIKAsyXt70uhU8JZFKL5K4v0kINHGlb7n2b1zCNheYr8M98NpOwm1LyPPzqt7
 37LJXGcfkEbWMaZe0zN/5j9qmGO9wgfjSzpQN8Fbx46i7KIRbudatpTWb+jL7wVmvPtz
 pM+t7zPBIRmeBU3IlfDYZzjhGtJ0wPnvdeFYKFvDWungb3NA1qUY1JtmpNGYZeLbr57d
 wuxmIHQex8aq/TjAKwk0CJj/y+qothcUIhxbbKChiGQBKKMkk+SPa2ejwqAFclJHt6ib
 7lw5SRb+fwh0FUnZiMV9fmsjypAF9e5aytk+xB+J9m1SLCDVRtMo+75l5KlWLpck+JJ2
 ukKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775221046; x=1775825846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5EpPaF03+EWzTT/ksMfj0GtsAPDo2AFHs2WM6xMAs0=;
 b=iJLAl7k0woCSaOMdlD3WAeIPnOR95MZKaBSf7Bq6cP3gAnOCFfuSIWnThRZYIXXwkc
 apKQdkDOV4jJIMozuP6j22mlDHUTS3ZuTnzIL6Os7la0w2yMfpreYQigXMZxt7bMWt2K
 bF6TZJimmohFoRW94chIYfVpskShcqiXs3qM6m/06aE76d7xkZXOJLdh5/cGOgxALAxB
 Ppf/6PhmpMW6WfaIv68tIDzYs3at+Rj/1TmGGufO8N6EQ7pd+mYUlJb+JwAKkf3UFTVa
 YmnmAuk4HLFGau3lsqxH/sjOvv+LFnPAqZE3S03u8/tt66108ml7jUR2YtrK4m8b36ZO
 8Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775221046; x=1775825846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w5EpPaF03+EWzTT/ksMfj0GtsAPDo2AFHs2WM6xMAs0=;
 b=QrspMhh6P530cZGUUGGadB8hw8p+TnaMItmW6gbsP6fOoA2lwCL0PSLj87C3Mz6Aiu
 JN1Dw3Xl0avgtY2WdGt9/ce6i2MwWcZ/xJVl2B4FqMzOkEr483ACtNtWJWUBl8x1am/v
 EkHPA5GpljSbfum2AbNqmsQoDOnjX33fjLxGJv5V5K45nwP66yFXrL/0qHTgTPH0QNl/
 HZi91yxWJieZxVVnMwaSdDk4iw0NzoelhOKzpc5IN8O2dgfwO6MqIVJzbZelkd0Y1jlV
 6yZM9OegbQupZt4PHarBkwUVYX5OdC00ATUlEytsj7h3CyqPlSRZGZhgN8+ghZ7C9/mi
 99ig==
X-Gm-Message-State: AOJu0Yylwsbf8qpKMzoFDyaq6toLuQoDge8gDCEVvFTueOYyNz9CSUUN
 PMhrh251dpm8/K6r165LvTUtG3KzzzRxBGE6wz1sEgsfkxt67mbNwZlKRvU53+QtKYLsI47AuFi
 AOoVsRwxOAppd7xhvFh8+vxofN5Hz+YU=
X-Gm-Gg: ATEYQzwLC8ibmQkRnSnaTuUYEJbprCOXPzH9UVNIKtuIi7o0JnUEVkvA3x+RB404+qd
 tS1jtSd6LiNNcDnB6LatMkqDoAX371s/BK5Ar4D8C9dJwmFps8nDVpWH5bRI4apn1/xC+2Ij+0x
 lVWZasyF+HyzDfROK2+AkV9o5+p7+lCFlbUx9A/K85ZKhR0gJxb0Ef7rVfS57z3VCnF7NSmFh0e
 yevgdCArPuN/o/ZnlFMKgcB/YAYbsOXwAa/XaWl1lg5QoaeVBe7MfY8xMXk0lrkIOdxZ3L39ChI
 haT25J+Bpp3T/pJ5294XAqYh1uVdb+Kx3tK7qPkwi7iNqtwXet4hw0q76epIE2ypgZhXUQ==
X-Received: by 2002:a05:7022:b81:b0:127:332d:63e with SMTP id
 a92af1059eb24-12bfb76050dmr523549c88.5.1775221045886; Fri, 03 Apr 2026
 05:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260403025710.1891947-1-kevinyang.wang@amd.com>
In-Reply-To: <20260403025710.1891947-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2026 08:57:14 -0400
X-Gm-Features: AQROBzDbGGn1BDYMeubhaFiSEgE6jA7LCqmgx8Z3o71idqEWgBFUQjiTwqpaR_A
Message-ID: <CADnq5_PTy-GNY7oL1DG6BUTn8vsH6qfbSfgEk63A1VADTnHWjA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix incorrect FeatureCtrlMask setting on smu
 v14.0.x
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

On Thu, Apr 2, 2026 at 11:04=E2=80=AFPM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> OverDriveTable.FanMinimumPwm and FeatureCtrlMask.PP_OD_FEATURE_FAN_LEGACY=
_BIT
> have a hard dependency.
> Invalid handling of this dependency leads to disabled thermal monitoring
> and temperature boundary validation.
>
> Fixes: 9710b84e2a6a ("drm/amd/pm: add overdrive support on smu v14.0.2/3"=
)
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 2be080b4cbc3..bc1bfb618aa0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2390,6 +2390,7 @@ static int smu_v14_0_2_od_restore_table_single(stru=
ct smu_context *smu, long inp
>                 }
>                 od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               od_table->OverDriveTable.FeatureCtrlMask &=3D BIT(PP_OD_F=
EATURE_FAN_LEGACY_BIT);
>                 break;
>         case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
>                 od_table->OverDriveTable.FanZeroRpmEnable =3D
> @@ -2418,7 +2419,8 @@ static int smu_v14_0_2_od_restore_table_single(stru=
ct smu_context *smu, long inp
>                 od_table->OverDriveTable.FanMinimumPwm =3D
>                                         boot_overdrive_table->OverDriveTa=
ble.FanMinimumPwm;
>                 od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
> -               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_LEGACY_BIT);
> +               od_table->OverDriveTable.FeatureCtrlMask &=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
>                 break;
>         default:
>                 dev_info(adev->dev, "Invalid table index: %ld\n", input);
> @@ -2588,6 +2590,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu=
_context *smu,
>                 od_table->OverDriveTable.FanLinearPwmPoints[input[0]] =3D=
 input[2];
>                 od_table->OverDriveTable.FanMode =3D FAN_MODE_MANUAL_LINE=
AR;
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               od_table->OverDriveTable.FeatureCtrlMask &=3D ~BIT(PP_OD_=
FEATURE_FAN_LEGACY_BIT);
>                 break;
>
>         case PP_OD_EDIT_ACOUSTIC_LIMIT:
> @@ -2657,7 +2660,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu=
_context *smu,
>                 break;
>
>         case PP_OD_EDIT_FAN_MINIMUM_PWM:
> -               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATU=
RE_FAN_CURVE_BIT)) {
> +               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATU=
RE_FAN_LEGACY_BIT)) {
>                         dev_warn(adev->dev, "Fan curve setting not suppor=
ted!\n");
>                         return -ENOTSUPP;
>                 }
> @@ -2675,7 +2678,8 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu=
_context *smu,
>
>                 od_table->OverDriveTable.FanMinimumPwm =3D input[0];
>                 od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
> -               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_LEGACY_BIT);
> +               od_table->OverDriveTable.FeatureCtrlMask &=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
>                 break;
>
>         case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
> --
> 2.47.3
>
