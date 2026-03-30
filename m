Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D044F1061B0F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 15:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DB110E5C2;
	Mon, 30 Mar 2026 15:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AMUvAKQ8";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2491D10E55A
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 15:52:33 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1273c690e5bso201911c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 08:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774885952; cv=none;
 d=google.com; s=arc-20240605;
 b=BIzT4MXpDUIPdZhxA3t2IeZ9uLiyUHcyqyr0WiS3E7F/tDv8H9h4ihzWxmua/tTDdg
 RnbRp+rI3QsTpPZlOQYEDceCqckTh4JentrUL1oOMXnkt2jnfwZaAmejQbstk6Pk0s1v
 aR4O6QfcwbzUtp1cVsNqvfCNZ6cbLESLc3ytAcG7+2980jMXT7UxAQhlamsaFZTjQT+L
 7jxo3NREHR6NTA0pKaFFD3jLw9b5Ge0+lyCINfD2Ku/8HyY+s1zhFStzf+P1I+GLpk66
 sSSMvcFaTjPi7LMjZnUtjwWMTejYpGOSJ8/Jj8yBlYvPf0eNFAjj2Gm3aVdHzCo/2Pww
 gVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+L54xNwdPuJKbn5Kq/l02/ECq7OPHsDjDzcFU/A3BQM=;
 fh=3V6ati5Ghj/fqJ+W4rg/EJ36AH88XLx7CPYEk7dK5aQ=;
 b=jLLt+XAg1UBSTQ+z2OqqTNzJokZH1kbeYipmCfP2cqjD+wpISJL4FIEVh+hXMr7Rcj
 4NZcT9fK2Vp9Bdq/jwdYzUM8gnsfkSrq4T19jdQz45asEuq7dr9uiJDAWcYDe9jzVw9m
 LIziMBhp9TzhwV0DzJqpJu+YNsHe2H1RHFbQv2o3JSDU+k+E7PGMmtTcGiUygYuQbZmy
 JuL0q0++n+UdtEkwarB3PQq2+2UGYkhG8N0cJrGSvSotypRCm+08L2OIkESNmA3n72qW
 m1VPqKdIUxgDCKGPDEfFmilBr9asKpJ8DGuIlWCgrlQU6ifJj8i8FdyRG1zz6WWl6SXB
 lLWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774885952; x=1775490752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+L54xNwdPuJKbn5Kq/l02/ECq7OPHsDjDzcFU/A3BQM=;
 b=AMUvAKQ8yKiGu8jHVCjOT5CFrZ/PyMUCY2/drUG2yy3ucAJgaj3Sb1d0NJyXYWiJMe
 Gh4fgmZYMcuOEKQGJQAHF02jnD5GFkzkZLeqEPA5Sozm51j607cEcftMcm1LSH9lvkxP
 tziUuvn916I9oDIHY534l1U7XvzCs46G3i43lOB1Fkfx+uCrGDmTazyrGmCUdCtohzoH
 d3gZdZJdo0ekOYJtyXvgK6lqBcSDmsC+ZEhdqhyJRWJIgq07VLB0aggPqWPQnvuLvsNR
 U/bjZponWTXeh0XEwcA5yv+puzon1hpTZTg9VKGcd3qWEZy7UJRmKb1WFi819LpwBl2H
 iO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774885952; x=1775490752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+L54xNwdPuJKbn5Kq/l02/ECq7OPHsDjDzcFU/A3BQM=;
 b=JA3+8n3Ujl+Q2BI8Mqlqqmd25gSXX33bYPnSQMu2d8V4oHrY5IRY4QtSp09tD3Z9YA
 0B7Z7N+aziPYMDNEipkwrXHq+K6G3CbxicoSMGZJwcQ0huo84hwmRSFrpdieyh2k7O2X
 BEuVxqufU2Ue+wPvix8Cm/yf4IyF+c1jraXQBDRcdqTDvssuE060hwUt46ZWVwO4NF3O
 J7i8r3G/LUlNyZqazbOuIgRJdWeJC3oOi3pz1TS0lCbGvj2GjPgQURpQaayrruumll2t
 qbv3zT5VDNQejMiQ2G4mPSu8EHS9owJLk9zLy9nEr9fXA3NzL7Pc4jlEJhiI9G9zZwS8
 zGPg==
X-Gm-Message-State: AOJu0Yw5O90AtU95zSAieBL50Kd0OTFa3rV1a7dmu7j5mDg4ASy6xXTX
 qlaH+oojgMnkhv4Y0wuIk6H1U+bEAZern6M4BhmE7MisHdDXJU/OPdJg4obsmvLgq05df8YCQTQ
 HJZvVGWmJqV3YAPlFOA66VM5CyDSkZy5gzA==
X-Gm-Gg: ATEYQzzNQnVc3BAwxK1v3WRoz10XF2oigWe5JNjJhVbzvDUzUMV7HdW2bCwC78P8wLb
 gwFzSe1vB+nKsIejjLdSJRT8iuXgh5p0Y9w4hwaajfCLLTqF/iiFgFgUZQ/ovD+UsQ2MmXKM2PF
 AGmxHDsFwwNWkY/mneMxISoPQskm/FgaxdppMn1aj2bAmvgedZFko1ax4djQxC55xLu25WklwzP
 f4H4lB31TgqnVBMb1F7Wl4/CAvR+yfFc2ja9EiGtF8k3GAEmbka/sGYXHFZoxxeA1DPae3yx4l/
 0vQiBG0X4YYj0fuF0aalesOI3jQqIMqEj+2HukWZSwJX6kcBPwBEAuotP+kt/ofwZVqkIA==
X-Received: by 2002:a05:7022:2209:b0:128:d4d5:93b9 with SMTP id
 a92af1059eb24-12ab290a664mr3031497c88.7.1774885952215; Mon, 30 Mar 2026
 08:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260329160306.3417458-1-timur.kristof@gmail.com>
In-Reply-To: <20260329160306.3417458-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Mar 2026 11:52:20 -0400
X-Gm-Features: AQROBzC0DJc5XGOnwsDULZ32zI2Th_I5gzSJNd8yIQEzg2a-sfX0pxzMsK_1Occ
Message-ID: <CADnq5_PoeTef0D2Ku2WtA=dpZupPxJXRuyJrdR7nnbiZRc57bw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Various SMU7 power management fixes
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, harry.wentland@amd.com
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

On Sun, Mar 29, 2026 at 12:03=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> This series fixes various issues that I found on two GPUs:
>
> R9 390X (Hawaii, Asus ROG branded):
> Add SCLK cap to fix stability issues, fix PCI ID typo.
> And a few minor fixes affecting CI GPUs.
>
> R9 M380 (Bonaire, found in an iMac from 2015):
> Disable MCLK switching, use highest MCLK.
>
> Additionally, fix possible black screen on boot caused by
> a non-functional implementation of the voltage dependency on
> the display clock. The fix affects all GPUs with SMU7,
> hopefully improving stability for CI, VI and Polaris GPUs.
>
> Looking forward to reviews and feedback!

Applied the series.

Thanks!

Alex

>
> Timur Krist=C3=B3f (9):
>   drm/amd/pm/ci: Use highest MCLK on CI when MCLK DPM is disabled
>   drm/amd/pm/ci: Disable MCLK DPM on problematic CI ASICs
>   drm/amd/pm/smu7: Fix SMU7 voltage dependency on display clock
>   drm/amd/pm/smu7: Remove non-functional SMU7 voltage dependency on DAL
>   drm/amd/pm/ci: Fix powertune defaults for Hawaii 0x67B0
>   drm/amd/pm/ci: Clear EnabledForActivity field for memory levels
>   drm/amd/pm/ci: Fill DW8 fields from SMC
>   drm/amd/pm/smu7: Add SCLK cap for quirky Hawaii board
>   drm/amdgpu/uvd4.2: Don't initialize UVD 4.2 when DPM is disabled
>
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   5 +
>  .../gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c    |  15 +++
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 123 ++++++++++++++++--
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h   |   1 +
>  .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   |  84 ------------
>  .../drm/amd/pm/powerplay/hwmgr/smu_helper.h   |   2 -
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   2 +-
>  .../drm/amd/pm/powerplay/smumgr/ci_smumgr.c   |  15 ++-
>  8 files changed, 142 insertions(+), 105 deletions(-)
>
> --
> 2.53.0
>
