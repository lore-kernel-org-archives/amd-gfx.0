Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0C4C5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 12:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4702810E401;
	Mon, 17 Aug 2026 12:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HV784etb";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FEB10E401
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 12:56:20 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38115bbb83dso291136a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 05:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786971380; cv=none;
 d=google.com; s=arc-20260327;
 b=plDbe1LriL1m3ZvJq9xo/oMyr6y3vJ+Oeq9JCYKMmYMhz1/hnzMn0wE+YSFCL8FSR3
 F7n9BtebGQk3xRr0g+KIBuHs6NXV1eauMXbrPIXTUfbYPWPS1xhxj+wW12tvd2ub3SwB
 YVOGeUxrtXI0v1Xlc71s7QRQkaCI/RM1HmoIO6xp+yJ3Lqw8owUDDXo/tpb+34WAnP8Q
 GbE8ysRo449GECXd4Mp6lW3gmZ19nkiSFWNESCYpBd3f6dqNAvLG1oKwlN2Ol8KEc3BE
 CEXG4MO/VxS9twIY1tdWG2kvhUyJOM6To6BzlzPJYvJBEECuig6a6Z+D6zzA89LSOUZS
 I+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2TSzG0gDc5YOf/wEkAdB0Lek1536jtJsus5lQR1M0Wo=;
 fh=nz/Uidsz5Q18abiqcIJ6CUgoCr8Jd55fjnrU+Kttw/c=;
 b=mKTJ/YiL6MUvnItxmuhGh+gLxid/xmyN1vKpDE5FrfKG5J1oOTfXR2gRqD5YQPeic+
 oxAFccjnbVkvVgxKX8J5y6fPDx3yiKReoax+SXfjBhCXD8d5XtwKXZiLi+dkpzIxtIgA
 rpkDaHmINUHKkRn8KQ4nTw+aDzsbPo1lyAZW1UQYBQUxKEhYAk5ZEVJtd6+HtM6MiYzl
 0JZutgbfMBT4NZY382ZAFdQUEZh0+N/LZlOu7EAuQj/VbhR4o3fUBlCUkDUzzDIJKck7
 AKXNEA/p/cd83ZSflLWfKNwh6oOK9XWPfpEVL2hF8Y84NR2Ym10FPnB0T88fw5Mrcw+t
 l46Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786971380; x=1787576180; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2TSzG0gDc5YOf/wEkAdB0Lek1536jtJsus5lQR1M0Wo=;
 b=HV784etbzw5zNfmSg0tDEb/hsBsutMUw2ao4rb6T+GpRI0xfUAd13vi+ROdSPFLPXA
 gaM7hjg1uYcl/NiOlFUZrq3xrmx1lJCP90lNfgqTYDn0hhdV2MU1Gj/5Y7IjJN7vGwmg
 V4wpMbHdFQNoKFS7mgkkgdpRG/J8AOB/V4uYKpM+1DwWUsdnAkY/Cs8p3HQX3O97tJgH
 3Ss/tDTKi5e4q7KdESKn2U+HkKePywLiILCgGzwa0GytQc2vbw58vneLdFvugR5bKiJp
 IcIAYBj+meAbxkPyDzFzFqGucaXX5WC+91AVyO/ffVW2bsK8p5AS5AF9proe9iuRfvYP
 sHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786971380; x=1787576180;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2TSzG0gDc5YOf/wEkAdB0Lek1536jtJsus5lQR1M0Wo=;
 b=aAhTHmzhXUGT+zsUWv+Qw3E6Hjy57fQ3A/hob7SIEWZ6gDH8oYyhKfScI/w1BZ5kZU
 uNr2B7s4NI0mf3z0GGls/Fizuy12oZwjD6auvWe8P4N1YNDIHlSDYetz3BTZmM3y6uH+
 vKVfk0mgVIjabsXP+McXRBIuUBWxF0OJE0P1A8elB77sH29JkYJy415fixrrxI3z6Xo3
 wNh3ShIu0SW8bsgxOCSRP6NCbip4It5h61e0gslRpUncKJjM9KOb6UZGbcgGIswTpcLp
 xp5GK0xux1WA38ZWKb0yiHXFZdSQL8AVJ4r+OMGW7OsbaO3pu5phwr3aaWm+ERNHiG9q
 Tnbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVHJp9DsNmS7bmiJxnpuQ1dGiTnMjbo8Op5BYuUMi9OJYg3Ue++9Sqt++QeZVfZSS3nDYyFrSV@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7uOYUcBsVWVJf4/OSQpO5gWFENtLmoa3LzX/6UzdP/XOMATT+
 rGD8TNqVQlUpgK/eAh/w0BLAjg5UOFN8lULdk/oqMMRdbCTen0MJr8QWE3O7OnH2CMvKKn65TvY
 4HLivxdHXvTP8sBxz3FuPJc3M8BnjEq4=
X-Gm-Gg: AR+sD13N4ildQLUx8AoE13oYNshiEaXwBZXAVQFmd/EgXKTu8qlEoU8K43Hu1IIE6tX
 cZYNrNNre5MORJKBaEsGtCxAaICRN1OnBOL4C7nF2vlbF0o/F2InMzTm1y4GzqA7vMKwHc6077D
 lpCxYzOPlPbCBywSa269Yzc7LRja8+JmdflyG7p79JVwRbtHiIi0OAoF0LtXhTsUgCzlV9BC43U
 WZBjVjzXN/tqsy/tet3Ttf3HhyEfENwLpeNEt3CPe1cnnMDOPKbdO7sHeuEpBPFreY4tSWkvVnX
 F1/da3Y0tBfPiTILjosFAEIXxiRWe+p91G+9vxzre6DlIvaD99hwCNZPwUV+ilvZDlQr0vCUD62
 5Tvw7b+B5hrgmwhI+X1Vz7cjpqti8DuY=
X-Received: by 2002:a17:90b:4c87:b0:38e:549:9e04 with SMTP id
 98e67ed59e1d1-3933b7d1d85mr18048933a91.1.1786971379738; Mon, 17 Aug 2026
 05:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260817053024.277429-1-Shubhankar.MilindSardeshpande@amd.com>
In-Reply-To: <20260817053024.277429-1-Shubhankar.MilindSardeshpande@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 08:56:08 -0400
X-Gm-Features: AcwNN1WDKk9-iiIKKcg_zWSZ5vz5UoPiNx4z5Kwztdct2hvJDyX4AKTfqOnnWVw
Message-ID: <CADnq5_Nh7DWamw698=c5sBXfRF-=we0A2csQ8Gzu1VfmAVPNGA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing nbio_v7_11_5 callback
To: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Cc: Alexander.Deucher@amd.com, Pratik.Vishwakarma@amd.com, 
 Christian.Koenig@amd.com, amd-gfx@lists.freedesktop.org, 
 Veerabadhran.Gopalakrishnan@amd.com
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

On Mon, Aug 17, 2026 at 1:30=E2=80=AFAM Shubhankar Milind Sardeshpande
<Shubhankar.MilindSardeshpande@amd.com> wrote:
>
> Add get_clockgating_state() since the missing
> get_clockgating_state() caused a NULL pointer dereference when reading
> the amdgpu_pm_info debugfs node.
>
> Fixes: 0453ccd3237a ("drm/amdgpu: Add NBIO 7.11.5 support")
>
> Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpa=
nde@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c b/drivers/gpu/drm/=
amd/amdgpu/nbio_v7_11_5.c
> index 9bb998a47ef6..0ea6e091a24c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
> @@ -249,6 +249,12 @@ static void nbio_v7_11_5_ih_control(struct amdgpu_de=
vice *adev)
>                 WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL, interrup=
t_cntl);
>  }
>
> +static void
> +nbio_v7_11_5_get_clockgating_state(struct amdgpu_device *adev,
> +                                 u64 *flags)
> +{
> +}
> +
>  static u32 nbio_v7_11_5_get_hdp_flush_req_offset(struct amdgpu_device *a=
dev)
>  {
>         u32 offset;
> @@ -337,6 +343,7 @@ const struct amdgpu_nbio_funcs nbio_v7_11_5_funcs =3D=
 {
>         .enable_doorbell_aperture =3D nbio_v7_11_5_enable_doorbell_apertu=
re,
>         .enable_doorbell_selfring_aperture =3D nbio_v7_11_5_enable_doorbe=
ll_selfring_aperture,
>         .ih_doorbell_range =3D nbio_v7_11_5_ih_doorbell_range,
> +       .get_clockgating_state =3D nbio_v7_11_5_get_clockgating_state,
>         .ih_control =3D nbio_v7_11_5_ih_control,
>         .init_registers =3D nbio_v7_11_5_init_registers,
>         .remap_hdp_registers =3D nbio_v7_11_5_remap_hdp_registers,
> --
> 2.43.0
>
