Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E89BC982D3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 15:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD3D510E8C9;
	Fri, 16 Jan 2026 15:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gkyKVlFa";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4266110E8C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 15:45:51 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1232c98f98cso152033c88.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 07:45:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768578350; cv=none;
 d=google.com; s=arc-20240605;
 b=QVQhvt46iuf6PjjRGUHWjm07boaTPvUb0Khn5cFXSUrjJ7+t7kdXxAKhH9WP4GHGPd
 Y1qfIK7zxEUC8KYqfz2S0V8VexRoql+ja/cOHzK1sKgrLFFqMDkybtGt2XkTKOTqupIe
 4WW6VJ47MGf8fjBhNwRyS6IyMIu2iDj5z1rhbJXbeR686pIT5KHYQpg+wd/0TDMS7SlH
 F1DhDjXU9QPSe5aSxDLDn7sLFEElFYFSTjtfu2oMfO4bjSGbmS2EQV8P/+pmMZ06Zt8Q
 rkJ4ocwSfc1z6F88B9gr6417Z+2olpVkTzLRmGzi64idYcaHPwbqckF2KtrtTFlwGZMX
 5ASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CgMycUQ+Ss/D/44IB+g5TIUBd5exAdjjtucP80RUIfk=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=eZ07qybynNBcavCd5ruEym1SNDu2+W04NaO4tzwRx055e+TBFyZcw9WBDPVjlTCTx5
 8uRE0PCUXbK6lgUIPnLZhGgJWr+fpFa9OIo3xmDTkhJkNxvQu83WWfaycB+vdiaj4b3E
 KCjex4vdz/lLvhiGvdNuwHMVfEgyy2n8V4mMG1OpT2lHJJrwT32bkmhCh6gxz/Ot06/W
 M5Qj3A8P7O4wn10EN93FEk0QhxjawPGsRWwTDt4fIidOIxQGJ5QBIQJaeSRrJgAwVeNI
 QK6egf934sxrIXihyRs6ron0ysIjw53N3NKvMUYh5w2Ud3OZmGCCTnEqk2zu3wNAvuCA
 DKqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768578350; x=1769183150; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CgMycUQ+Ss/D/44IB+g5TIUBd5exAdjjtucP80RUIfk=;
 b=gkyKVlFaGSuGAWMTA4dAfp3dfnOZwreZo5GN5el+InHFsIY5Q8eWCUy2+F6feD1Jvo
 9xP/zdsYfLZPFOyJ7JhhIU6KGnNTxaRkqbW0ywLYpux3AEsKiMg+6pRyUf+t5mf1tJhE
 k4mcdzwNEKiYaK8Xuuy2Zx4VTXp1EAV3X8zgw2EXf+Rx5PqTqXxCmx/4G5Mh6wx2Ib2C
 ktmaBF/+gJKXRM/J6ZkI5eWmE9Y4lNmgdiMEMJ8+hwu34sIhN3ZZQXUbtuFfrh9BKgqY
 WJeoyN7fENYZSOJr249N0ISPZ0RYUhi6D5rTbZwsUxu9GPxnYWLM9zRRiPxCjOpsRAOq
 q8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768578350; x=1769183150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CgMycUQ+Ss/D/44IB+g5TIUBd5exAdjjtucP80RUIfk=;
 b=BQdhqiVLnCiXNPAVBpQBBkyzbAh5/eExWIalnn1ipBtZcrazHIdlFs5FdYdKJFOrpE
 3AeSBl7BD493IZWVacIQyiLJv1yS77DHpv0IWx6Q5Zk+w1PVlsAkWmcTdU2VG56vdztX
 /gA2Ly+5fyIr96bN2iqfAqNbmKmYy8IMEV8KAyRw0+WLah3LUTCteBonwzr3mNRo8n3X
 vG7X3o+Td8PF6/UtsctlehcZvHCJGUkA2X3Tj/DxvAo2qUxywkqCnJxdXtw6NDjK12aJ
 ZuICM0DzA7R3wcNxukRb9ftQ4brILV4x6u1nViWJF552SxUpEjb5bezMGFeT6HwxpwC3
 4s9A==
X-Gm-Message-State: AOJu0YwJfBqEjaYyuQVDUTg2GDsQXkK3jz5zOzjaaMGSpghcJ4ECoHaM
 NMBOSq7aunYnsrMN31TKLuGBEOwUQjKfPfgXuxjRWJ8lFryajTg953Cv+LgYMVVUVAF0NZcwlRS
 2UyL4aByZOzgAeRZEIxcM+QPum3vG6jVZhw==
X-Gm-Gg: AY/fxX7NUj2q0w9UPOK8xsx5+qxvyKAZkKrQr3T2Wq1jToVz38HLTyb/9/bgGGRUqSS
 Z6vkJurB8xmb6r2vQJpK8Wr3x/xwVeI7RKc8zk84EtCFfsvgZDVAENEaLNlHEE9nx4E3eEpMO3e
 KGW/SEdRsADwBuQNr2RFKuscLGJngv6zkdm7DQTvu6MNY9FpgM+HUT4B5k2v0XbUnFKtvkuqHq7
 p+qZ08UurglYqjefceavw2SOAvpLNabOF28Zs79ZNulfRtarXahzfPzQ561J7zn/EU0ZAad
X-Received: by 2002:a05:7022:3b06:b0:123:308f:667b with SMTP id
 a92af1059eb24-1244a724e94mr1711110c88.2.1768578350394; Fri, 16 Jan 2026
 07:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20260115214726.900171-1-mario.limonciello@amd.com>
In-Reply-To: <20260115214726.900171-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Jan 2026 10:45:39 -0500
X-Gm-Features: AZwV_QgPyWWX-APp1JuPEwqDpM369KyAd2f722ZAzX9DLfIrFVqq0jzVgXq8doM
Message-ID: <CADnq5_Op6fpsUP+PPzPaQA4sD9FdMZ6hXu4U2W68yCaRP3dohA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Update IP versions for Gorgon Point products
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Jan 15, 2026 at 4:47=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Gorgon point products were announced. Add the IP versions for each
> product.
>
> Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-=
series/amd-ryzen-ai-9-hx-pro-475.html
> Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-=
series/amd-ryzen-ai-9-hx-pro-470.html
> Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-=
series/amd-ryzen-ai-9-pro-465.html
> Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-=
series/amd-ryzen-ai-7-pro-450.html
> Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-=
series/amd-ryzen-ai-5-pro-440.html
> Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-=
series/amd-ryzen-ai-5-pro-435.html
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/gpu/amdgpu/apu-asic-info-table.csv | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documenta=
tion/gpu/amdgpu/apu-asic-info-table.csv
> index dee5f663a47f..f4c0f93c0582 100644
> --- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> @@ -16,3 +16,6 @@ Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5,=
 6.1.0, 14.0.0, 14.0.0
>  Ryzen AI 330 series, Krackan Point, 3.6.0, 11.5.3, 4.0.5, 6.1.3, 14.0.5,=
 14.0.5
>  Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4,=
 14.0.4
>  Ryzen AI Max 300 series, Strix Halo, 3.5.1, 11.5.1, 4.0.6, 6.1.1, 14.0.1=
, 14.0.1
> +Ryzen AI 9 475 / 470 / 465, Gorgon Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 1=
4.0.0, 14.0.0
> +Ryzen AI 7 450, Gorgon Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4, 14.0.=
4
> +Ryzen AI 5 440 / 435, Gorgon Point, 3.6.0, 11.5.3, 4.0.5, 6.1.3, 14.0.5,=
 14.0.5
> --
> 2.52.0
>
