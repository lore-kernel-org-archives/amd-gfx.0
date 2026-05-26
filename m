Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89565CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 13:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F87810E47E;
	Tue, 26 May 2026 13:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="omGoC19D";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE9F10E47E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 13:21:47 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2ee34d7e55aso1246699eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 06:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779801706; cv=none;
 d=google.com; s=arc-20240605;
 b=aQrGngqjBd3+dNRXJMm/xJdxgcBHxkzXHmUVCgWdlqd2THrUxnq9ccPRVEawe4FVsc
 ZhDmfhGoklefrkHeyfdlQbRtntk7747OwqFfS/EJRbOhWJbTXoqwn7uepfVhLZPAFgxu
 1rg0vp/IGeIEL1vAiKgLlf0rq2e1BDAxxpkH5TGUesEVl0RNJveJbsHVv/dc9I3OTsw2
 8EAOceHWgTnvyYn0GUUdPS3Irz6v6eaDr8SSPLzyDhHDo5pHDAWam5NZ+QiaIgmLJ7gY
 vvkozOX2C889HUwyrmc3Tchk39QKsCcZdhhJcvqA+u9wS1HGTv7joKnWAsCfzRFtA+yj
 wWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1DDR2f2wJkv2bljojbmb+TpobDJar8In8RZxgC4nj8c=;
 fh=0+NNu0JCv8eYPVNsNn5QzAjMYsa/uOfuT9mrBHkU1I0=;
 b=OsvYu9PUnKyiGeVTupcrPKz6E5QJ96odeBtVBBy28C1ANtenE7xgfEPyY3ds6bImy8
 3r3G/gYIxfTfowXj29Gv0ZP75hF0X6fEvOtVL23bRFCkqVZw0u7XKVRhjqj2F/rkkqHX
 ezPG9FHIHxextTCZK2qmY+x2O9R9xgWIOXEAOXuATv3EpF/PESdTF6MV+RMDm8fut4SV
 3nKcWAzC73KoyDDhc/Bs+szMtNeaBctHT7vJX4FIOJgP9H5RJVZ9uFNwrmi8nPH1S9VO
 E+bDD6S1yXn6WpJjqUUFCL+FwmmGOxejh804jTWuJdDEWIU1ULIVufWdkJeuVPlWVXcS
 sxuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779801706; x=1780406506; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DDR2f2wJkv2bljojbmb+TpobDJar8In8RZxgC4nj8c=;
 b=omGoC19Do2Jo5gtP/WY9WNtOB2EnbhK2Um+73LvX76DiYpWcrPt/yHJkohX9pxen30
 tjWV48oHfvbWzRrahjuNnH8NL5A1wLZgS6OV+S6TFnzRa1PrDMTRRP/m1wJ8vEn0FzbN
 RTJ7G2BKHJHWEQfstsXtdFXP2FghGyoN9EeHwlE4aE/gSevsLFqhDkHLzSVs+WZd24dA
 TivGMqmx30a3LSmLto84npm30OtHOyKiLMhQ2hgAo521+vfWnschtHCOqkb5Oxb8wgiG
 3Bptj3LwRPLxBdKinSltoW2Y6mI8zpVNbRnuLu1VcTlqd/OLplZvC4BcLQMiFEKBfJkz
 jYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801706; x=1780406506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1DDR2f2wJkv2bljojbmb+TpobDJar8In8RZxgC4nj8c=;
 b=XQ0OkoVLPPAwJU70gn7eCZdFVcZWDvesgSYsGjSXxxqB42vgPJ65MSAxyuxUnyffIk
 pSvDWT2GIaKuR2voOkVLmqKF5pm8rYVgKAUpBhl/GT0q1s2b6LMQnthJa1jTvc7s/YKX
 h5yClflkZbSW4EI7D+NzaePg9uEnmJkLJQD6SrP6VayWI4OZf5dQ/HeJ9YMrelKEbOFG
 DAxZvbMCmxBrxhQxFh0sHfq5n47rZnf+HIM/8x5UJVkzkUfO9p3kBfPbo+jv8+BKNW6+
 9XUQ0pUr24MSsoIWWIkzcp0wU3xmk/tXeRAqngK0Oh2LRbP76MdNF44hY2QUCgowMaub
 OR6g==
X-Gm-Message-State: AOJu0YzCAwSRawZRuifU9PQMX4Y4FykbqZsGEj44ZNG9odK0f/QC0w3Y
 zDrWbP/fNJ8OPsZ9H8gCFXdqIh65WGBFIbe99dXus7Z0s95XyETE2/Y+ePGOQkVA4rUiJ4C1BFm
 5cxuOw751LeZFlInUVX1bBtqsC3ULtp4=
X-Gm-Gg: Acq92OHk+4Bkg/u571Vgwu0HG5oRz1swAdVaGzhR8v0xOLndgWcRqbaE+iku1/c1OaS
 FbEBqGp57xRELcpov5Fod1s1EdxmBTOJdJ8cBtjuZurTsI1diMOXC3tRda3h3lpNZyfhGaDXfLC
 04mHZnNDyaWWx+QC4zsbeG/+5RB9wTHggfsd1MHzCO9LoRCdL9CRbF/hd2RfnqN6X+zszPQDX2Q
 YBOEvP5qrpqVMvnJziiI3pkU7jLDl6MAUivPVOf6aU7GZ6dEpFq79fvmR1xcGBqynelKeqNd/gJ
 Ur1AVkbMYPPrTa6LUykkC4M5tey5H9d6gQyII0RV43NOvOFD2lF2ru06CBP56Sv/G8vK7A==
X-Received: by 2002:a05:7022:f90:b0:132:1e00:de4f with SMTP id
 a92af1059eb24-1365f6f5a09mr2982765c88.1.1779801706326; Tue, 26 May 2026
 06:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260507080137.841442-1-Priya.Hosur@amd.com>
 <20260507080137.841442-2-Priya.Hosur@amd.com>
In-Reply-To: <20260507080137.841442-2-Priya.Hosur@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 09:21:35 -0400
X-Gm-Features: AVHnY4LTACR6iAn57W0wISsgRwuSDEAGV0RHM8aJlyxaDdX4GF-ykmRoYcnTDzU
Message-ID: <CADnq5_OmROsjeOQa89TDM0oeM4Qa-ikKa7JPfwzOiK=DwmKiQA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
 set_soft_freq_limited_range
To: Priya Hosur <Priya.Hosur@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lijo.lazar@amd.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, 
 Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
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

On Thu, May 7, 2026 at 4:19=E2=80=AFAM Priya Hosur <Priya.Hosur@amd.com> wr=
ote:
>
> In smu_v14_0_0_set_soft_freq_limited_range(), the gfxclk floor is
> programmed via SetHardMinGfxClk together with SetSoftMaxGfxClk. Under
> power_dpm_force_performance_level=3Dhigh this pins HardMin to peak gfxclk=
.
>
> In PMFW arbitration HardMin has higher priority than SoftMax, so the
> firmware thermal/PPT throttler cannot clamp gfxclk via SoftMax once
> HardMin is set to peak. Replace SetHardMinGfxClk with SetSoftMinGfxclk
> so the driver still requests peak performance but the firmware
> throttler retains the ability to clamp gfxclk under thermal/PPT
> pressure. SoftMax handling is unchanged and no other clock domains
> are affected.
>
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index c76b1f07885e..2fe006de927a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1231,7 +1231,8 @@ static int smu_v14_0_0_set_soft_freq_limited_range(=
struct smu_context *smu,
>         switch (clk_type) {
>         case SMU_GFXCLK:
>         case SMU_SCLK:
> -               msg_set_min =3D SMU_MSG_SetHardMinGfxClk;
> +               /* SoftMin lets PMFW throttle gfxclk; HardMin would overr=
ide SoftMax. */
> +               msg_set_min =3D SMU_MSG_SetSoftMinGfxclk;
>                 msg_set_max =3D SMU_MSG_SetSoftMaxGfxClk;
>                 break;
>         case SMU_FCLK:
> --
> 2.43.0
>
