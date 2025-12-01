Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD7FD116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 18:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCAA10E449;
	Mon,  1 Dec 2025 18:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lOkZtHAy";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0345010E44A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 18:13:18 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7b8ba3c8ca1so620425b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 10:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764612797; x=1765217597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZKFL/JEwbljEDVnMiN+HCxuZU9kf3npT0jz2xRcA7Q=;
 b=lOkZtHAyjPxl5v7Q7po+95F7+Crdz+v5UaaeZ0LkDFL0QYwl21GI/xj6tj6Svnit2D
 aoROb8O/mkpvc1gkxEwrqw5gwiVyfTdhUY7aJ+SJLIJvAUJKPb6hPt0MGwodGeCdX2/S
 u2JPIUIlf589NDK58ShyN+pN2YRnOhz2rwXcbNlPRMZBJGxt2lsNzlPc92LDzqcwI6VY
 KuysVJQ8VGaCYIVG+7WWCocbaxsaS85ktDjRv1+P0vv7YB2nQoKbxJs+GYialFULcWHI
 6/5rMFsc5ma6Cz9iQO1Q7f27WhFKiCtPdxhq7hPGo+Qrl1EUcxa3YQo6xWDS0EMpERQP
 KAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764612797; x=1765217597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rZKFL/JEwbljEDVnMiN+HCxuZU9kf3npT0jz2xRcA7Q=;
 b=g6crNTE7wJ5WN7JLw49cF0T3zLaMpLJ7HEyC/Ui4PWXQMDEbF3vB+1Ks+y806AY518
 lDNUzF4wajWcnQ7PP3lK1X7LngZ9x1lNfQjIeqwdNDqD7NrJsND9y/PoofwbmNLEJwWC
 zDiWVev9mkP/fC7GS+ugnoYgwVKUEtcqJXb11ka71QlnKKRLgc+WQyHip51OCUAAGHSN
 us7N2i1CMj51+m7LIiuP1KKSLdrIl2TtjEeKnsRoXGJgia70WSFsVmgpnVnicosxbjBC
 ElY7ZV1GVWe1KK7SwIVvv4liP0FyFjgr9l0/j51bORP0cUAqCPHrbDNnESwjYAtaJV+c
 VNfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUrPWQcgvcLD0qJ1G6ecYSWIZAm1oyATTOpyonYnqAT2vnhx/CoZ7TPv4Ih8cuxrCG+oeb3V/Z@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yznry+tb6dYFtguvPaADApuhnXGqW/soYt+nlZwqLH5xVc5gfWD
 EehV+leVK+YZvTRkxwux9hbZd9LoRd2jzYuLmNox3J2ViVqIYNxCPPXxUbQAvvNlEv4XZ6+t7bS
 MuT6lpo4Ybrza8lmcWpMWfUAfZcbqO0o=
X-Gm-Gg: ASbGncvu63aJuct3LAuevYDtGME+RYo+vojGPFk+r32nIvnyKVx6priuUVv/cCou4Tw
 +5X6VsUHPNm6OokIlY8c4DaIZGw2e16XLgkTZWsZnQdcHuXTuRCc743I2ToN8Lb6t+rsTaODuRX
 TUBzj7hXX2NkL/NKIWqI95N9xwL3ub0F5O0ee60Xxabz+hKVMTHL24mvT7sqESDmfLIeQIph7It
 8vlefn/KDvnLO4EQlfZPErNIlX2y1ygbnn0yLHkAU3UOOMsHIizmivKgNed7ZvM3Q+ANJY=
X-Google-Smtp-Source: AGHT+IEko7+6ZQfi2SHPHswwqWhnkJEszsunfElDB7n2BH9Cvzj1GBhb6ZX5FoUjJkiIep9k8GRdbYR+fNG/2OVGzQI=
X-Received: by 2002:a05:7023:c007:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-11c9f3a16demr15258433c88.5.1764612797406; Mon, 01 Dec 2025
 10:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20250325210517.2097188-1-bradynorander@gmail.com>
 <CADnq5_MNBUY=jWbnq-gZQ_4_M_sBJGAgMD0bj2cMdnkoU9G=HA@mail.gmail.com>
 <9ab05b38-6f77-4b0b-8a1b-8314e2873047@gmail.com>
 <CADnq5_No+w+tco9j35GBM3+CYBTo018eLwWec278d3VBJHPQxw@mail.gmail.com>
 <7462992a-fdc1-44ff-9604-ca5a9feaef07@gmail.com>
In-Reply-To: <7462992a-fdc1-44ff-9604-ca5a9feaef07@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 13:13:06 -0500
X-Gm-Features: AWmQ_bk2sFxl2w_v6h4bWnH-9snjeEy59H2TxSLFYb1U9EE4s8zd-Xrk4mUxofc
Message-ID: <CADnq5_Mat5hBpBFit+ETwOSv8m3vdZVo02Zk6F4GrmJzNGvksA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use static ids for ACP platform devs
To: Brady Norander <bradynorander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 sunil.khatri@amd.com, boyuan.zhang@amd.com
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

Applied.  Thanks.

Alex

On Sun, Nov 30, 2025 at 8:48=E2=80=AFAM Brady Norander <bradynorander@gmail=
.com> wrote:
>
> On 11/10/25 14:14, Alex Deucher wrote:
> > On Tue, Mar 25, 2025 at 7:11=E2=80=AFPM Brady Norander <bradynorander@g=
mail.com> wrote:
> >>
> >> On 3/25/25 6:12 PM, Alex Deucher wrote:
> >>>
> >>> While you are at it, can you take a look at
> >>> drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c and
> >>> drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c as well?
> >>>
> >>> Alex
> >>
> >> I think it makes more sense to handle that in a separate patch as it i=
s
> >> an unrelated ip block.
> >
> > Sure. Can you send a patch to fix those up as well if needed?
> >
> > Alex
>
> Sorry to nag again, but can we look into getting this patch merged? The
> ASoC patch has already been merged and it would be nice to have audio
> working on this platform.
