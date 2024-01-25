Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1862C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 20:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F26010F157;
	Thu, 25 Jan 2024 20:01:46 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17ACE10F157
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 20:01:45 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-3bdb42da0e0so3785981b6e.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 12:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706212844; x=1706817644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vhE/4ur4Fnq1QdD+CfW2y+wfFVJy+wkexw9wIw9tx0=;
 b=jR6ftLZp3JmHFtebWXKV6/sPjdcUJcCNYnADokg2ZeZQ/H6jAfr1H+kkeSVclgvcVD
 7TTsWmGS8Np9ipCfhZwX+47pveTQ0Ms+kmRepS67IZYdmsXj2gxEXN6JVHzrWIkTBdwz
 90ThywzXTSqML7d8smiqgYlQRntMgLzVtWmlOYyM9kSaswNWaV9cQlZNxtYlZTJtRaHH
 7I5LBKf3QrTAebXAT9f9qmDt1MmuraMS2Bzlgdbcdp8WnAt0UxLwBLmjrzORjVrosYy0
 +Im7UKNux93EJYlOaQLxz2tm719Bznw/rAw+yhSxeaCv7pm2ok6m8KriN+N/oUVNJXML
 BYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706212844; x=1706817644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vhE/4ur4Fnq1QdD+CfW2y+wfFVJy+wkexw9wIw9tx0=;
 b=CA3PFRJT4PpMoleWa478G9Kky/KTCrDKZoYIVXCDC2Nqqa4rMXlmqLzOq3JrZU0eth
 A/gDsIXk/lH6GnWQDH/d3fh9e2drzdqCLT/oWbL+QkC+IkV3aOfD+uzbZ9+YULo3SOku
 39/xXW8XGwFt+KHz4f7eW+kjOi9yMWrdRkcJf9OD95Bx1JZnliyXTzzs1NwYrXEZ0Dzu
 54pvI0VmDy5XzW5BSP+Kmuu1amNM9IwCYKW28wjTrQ6XCSrqHkTNGxl80tVYjvBflY2t
 N494PZKY0KkDgdEX0ICpofL1VgaS1QYZNXRRJKRxxzuf+RF3AP5q7vz2lT0G9T2erVJP
 VCbQ==
X-Gm-Message-State: AOJu0YwLFOmKoSBC2ezDlcRvateyYt+B3C1Cs0890P5U/g7I/clrY2ED
 17VBooCXhrjlFHtvP+67pRI0NT6xXJSjeGsvXEnSdB/dyiZLJvSr16Dx08yCX/W4dwiBQ60EXKz
 G9Bz+ErqbT3PsEed7fFPCdtCtd4G618zw
X-Google-Smtp-Source: AGHT+IEqCUzfeiq5FPvzF98azEr8EnUNTxfBn9oJZuTnxhS8HbFquBZkqV+Y6SQbk3pYpuQaXDxFWyQxLBSQP4KsLeU=
X-Received: by 2002:a05:6870:51c8:b0:214:94ea:4320 with SMTP id
 b8-20020a05687051c800b0021494ea4320mr222246oaj.24.1706212844277; Thu, 25 Jan
 2024 12:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20240118195106.3669705-1-alexander.deucher@amd.com>
In-Reply-To: <20240118195106.3669705-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jan 2024 15:00:33 -0500
Message-ID: <CADnq5_OXLcjX+FL9k-MYUj=iN+r1mtNYkLn8yDSL0rhDH5eZJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update documentation on new chips
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, Jan 18, 2024 at 3:47=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> These have been released now, so add them to the documentation.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Document=
ation/gpu/amdgpu/dgpu-asic-info-table.csv
> index 882d2518f8ed..3825f00ca9fe 100644
> --- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> @@ -16,6 +16,7 @@ Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /=
9100 /SSG MxGPU, VEGA10,
>  AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD=
 7.2.0, 4.2.0
>  MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2
>  MI200, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
> +MI300, AQUA_VANGARAM, *, 9.4.3, VCN 4.0.3, 4.4.2
>  AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.=
0, 10.1.10, VCN 2.0.0, 5.0.0
>  AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14, DCN 2.=
0.0, 10.1.1, VCN 2.0.2, 5.0.2
>  AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3=
.0, VCN 3.0.0, 5.2.0
> @@ -23,4 +24,5 @@ AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, D=
CN 3.0.0, 10.3.2, VCN 3.0
>  AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH, DCN 3.0.=
2, 10.3.4, VCN 3.0.16, 5.2.4
>  AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.=
5, VCN 3.0.33, 5.2.5
>  AMD Radeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0
> +AMD Radeon RX 7800 XT, , DCN 3.2.0, 11.0.3, VCN 4.0.0, 6.0.3
>  AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, =
6.0.2
> --
> 2.42.0
>
