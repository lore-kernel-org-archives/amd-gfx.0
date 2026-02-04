Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1B1EA7940
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 19:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B7C10E754;
	Wed,  4 Feb 2026 19:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HuwM0nZS";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D9F10E754
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 19:22:09 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b8095668ebso8517eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 11:22:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770232929; cv=none;
 d=google.com; s=arc-20240605;
 b=ZfM7V7i7ISMs6fZB7DYzDTXg049C98C0YK9wdnhZdmZzgefPq8DVEQSPeDl1PleJE3
 Bc6oXuxzQh9EsfN55vlCTpTDwTOyWs/WEkYRrJLIgchVMz4bPA5I8BO3TX2DFj3uMvH9
 C3u9H0lij1MY1qWMgTJd3ppZnTMNeXFQ8Wyw+YcY+hEDx71gPgXR0qkIq78DCcE65t3l
 flL7aQLxqlNLiS5CKyoQBZ/FLI393G1TXpbf/fsVhXc64rlBbvCYPmQqSi4xqERZPkVM
 ea+GEmh7XIJozxdO/gBQEiyMkTz5v4bPVYXI9fp0GGivaiJKNa2yw5zmRoiMuAOxUmxC
 h/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mE1/Pt75GGZx/Fi3uKQHLotNtMJWCRmJeboIaXlAvCE=;
 fh=xwkvyiG8Y44ZJ3eEhCuhphRG1UNZNJmtpngduIOG7dg=;
 b=V7Op2R5Qp1JTJLQRx4BNaQD6tqHCWgfpU0N/tEHwRRtR8o7ogm8x6YhET0DbzUONlj
 XzhCSWZvrDgyUe021IHD25T+s57iAxxOLbVNVyFET7xf/C5RHITdWQ6glB1x/b/BKxfl
 VvWQKelEqayt7R83URKjB1aSPURXDMZbjeL+rInvwxkxhfXpcmZfyEifU68meu1fM1L4
 kozjP/nLNpWXGeMQQOO5zcX2822Rbd/OjGBeezaqhNxS/vokX29OYJZ8npztvZ8+2ODb
 QbOryuGl2rArYcn3aoRBAy/8tb1AdYpu5YfP0Gh2oFhvHydisJnMc9rlxFhWSWxCRWeF
 Wo4g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770232929; x=1770837729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mE1/Pt75GGZx/Fi3uKQHLotNtMJWCRmJeboIaXlAvCE=;
 b=HuwM0nZSo3hyfOk1ySdUUivNUT5LFhrW++CHaA01ZaprkkTsDPydcD7hTc3/JbN8Vi
 i60M6xMs0VomRI55A+JAp93T1RJ88bFTIoqnCcL2UhODRY7hpakHrLNGRTvOU7eMHcyG
 nPTGBRWYMD7gTUP/Bct2vO8dUA8I5lvbQd6hg6ySB2Acap64OddIYv7DcsB5KNIMqQDO
 Jj3t2/mmnXbaADNWcC+y3pIsXmhNvOOFyn6VdRCzAr40GYtyb+qdly924YlJEoRwpGU5
 5AZoc3nWikD6ApzX4/8wNgMDSdlv9A8HuJy12UToh1NylkJM9S5LvW7mlXU0D1C4yQNg
 GC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770232929; x=1770837729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mE1/Pt75GGZx/Fi3uKQHLotNtMJWCRmJeboIaXlAvCE=;
 b=Xz0aHM4/dRTqlXkkDJ/gxjPj3mBOtpNlwAUqNF0Z+VtvbkslEpt+8QPBDHrEN9v3Bk
 hLBk0q+L1H0jwjB+NihapRDvV0DzM7+1Ahb+lxCw1A9Jn9Rnu6rQvktECMZtnArWRxFx
 XTgkK6+tdzYuS9fx8ofprq9JhXRYWNliIIsj8uobPMeXZEniowBGkFUwyPR0ABF6uNkw
 ZvnDrUKnt+HjHQ38w5e/Cxg62npV2R8TdFlsM5j1nAOf2tYF475fUga5Z8dKWl7/+UmV
 qekssZqIpfOuZhQ5+IzD2qUrL5mD6FmQTDNq0YHSr4t/QJGdDh+d7Q57f/sAPMD4w4h9
 MKAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYX4smpVsjkRk1y6eLxV3i61a7/Vv3Soh7bx/FUBsaI4jqz5W98giYVWBWaTG5d8Lv77Uz7u51@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwR3CbHYUVqA3XVcEQY6hUfd37H+R3nDsBzFu+i8Ran8FJqZ9+F
 WiJWJIzIQCgW4VvKcyIj/ajxg4whXfP6T2UYMRR1pnscXz85LEeHUzMAxALkGyT3WdUA53V9kV7
 c9vQWg6UQ1cymn4DbWk/Gtbbp8lSsE6k=
X-Gm-Gg: AZuq6aLjFWayyc57AGclMS+/dAi0HwG52UmKa0CSxX/ytbs+d2B53sxfoGacOVhuOt9
 L0DZWSPcKwLV0qYQ6h6+eNj0ZtGwyDWlw5T7ssXSrYwWQ3VP7V564pLSyj2ZaEtNfatquq/8FKl
 zOMbtMI97MEN1CpvHVqPgmRSqwp8ZmL/xtbUtnLg9Tz41Jh+ftbZl2t6qZHsadV5CZYG1i8Crhp
 VpLY+VUI4W8Zco1rZ2c6GrSBJ/uzr/xWZJByItbpBBIj2JwoqwGzjHdiVa5fwy4hjCyOmhW
X-Received: by 2002:a05:7022:f8c:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-126f47ca5b0mr921494c88.4.1770232929034; Wed, 04 Feb 2026
 11:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
 <20260204044338.96093-7-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260204044338.96093-7-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Feb 2026 14:21:57 -0500
X-Gm-Features: AZwV_QjpAejUAW2ozFjVNbY65C20Gfvy-T1ah2b7nip8Pi_PV_jkt_HBFatAFWk
Message-ID: <CADnq5_O6hsm-UN7Q=eN1ufeyq7a58PtuXE_FaOF6PpO+vQ5SyA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] drm/amdgpu: Drop unsupported function
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 3, 2026 at 11:44=E2=80=AFPM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> drop set_driver_table_location
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index f90d274c0f67..7331c7559454 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -1389,7 +1389,6 @@ static const struct pptable_funcs smu_v15_0_0_ppt_f=
uncs =3D {
>         .get_gpu_metrics =3D smu_v15_0_0_get_gpu_metrics,
>         .get_enabled_mask =3D smu_v15_0_0_get_enabled_mask,
>         .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
> -       .set_driver_table_location =3D smu_v15_0_set_driver_table_locatio=
n,
>         .gfx_off_control =3D smu_v15_0_gfx_off_control,
>         .mode2_reset =3D smu_v15_0_0_mode2_reset,
>         .get_dpm_ultimate_freq =3D smu_v15_0_common_get_dpm_ultimate_freq=
,
> --
> 2.43.0
>
