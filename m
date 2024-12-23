Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E09E7718B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 15:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A3A10E0B0;
	Mon, 23 Dec 2024 15:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cz1g6iUZ";
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 189AA10E0B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2024 15:08:55 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ef7733a1dcso807170a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2024 07:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734966534; x=1735571334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tF0sOZnUj8sAyucMQ2ztc2c0IcnVX/ElkSfDdu250GM=;
 b=Cz1g6iUZ9/eexemqKqYGAh7QM/Gb6BRccXcEXDRFAts+8yLUJs1VQEP5NBtDeNEQfI
 UOx4qY3xkMa2vF0hO1bfXXZKtTA1+PYdpCpDveZGfEp/cRqPbj1caRLxYQJI+v5K6wbC
 eIdMGbHA3XwvkxNVVgTcNRlVWlHTwfDyARUc7W0o18u/aXvRjK9aY/z/TpOEMxzKV+GC
 TpDJTcEMnNBkvRCq5G5+bv2BpKD04IhsOemlfy8QiIvHTdfgDX2H5D7DsPM5PHNiowee
 /MPdn6cSUYYvbNvaFH5B0wxrJWyvLYb4QcMbZPFWGUOWQ3IkRE3T2FNFPXcKDCstHb/I
 AD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734966534; x=1735571334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tF0sOZnUj8sAyucMQ2ztc2c0IcnVX/ElkSfDdu250GM=;
 b=P6AZMHSODapLL8uFeAvGYaC2Z88ZktuWNDaTT5wXMsvE3pDb24DqIvyg0ZItpCJ2ZB
 O8u0RJNCEvuh8tTY3ZI+gh2ILoclo0vvzeffSPc4UTeiToiInSVgxMOh1Zp3R3H9lU9U
 IgBfODcTOKeqxpsrnNhrl1kRyqZOD4KjGplb0LBNmASdjaOPDuk3h2wsGxFm00cfXhgl
 nsUz8NKEdSrRskh6UUSzZ1XlCsM/u8tMBAzAf1U1+uCzQytGHfvTRQgPploQfhiG8j4g
 n0UUWfvFirtbc+G1sgZPXMRNxJt0HyELPUnpH8EdTLn/NjKz8fJZul+xaqXSioIn9SWj
 xU+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1hjSDzKLOVO9cdx7Bxb4f4dtDnzJFs2TcO8ni3T/0kWVmt+IqGAwd8bype3Q8FCDnnxImhriS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQUZLohSGOXiF5ed9lvUtbzitQtj59e1Ek7mLFLOgsxCxSp6B5
 G+SfGrPrrhLhKIZdgoluK66QpSqs/r6z+0ULNvA49kDPiLRm5Lif+yiqYakJvM1/O2gx4+/beyz
 m+aFQHjX22sJg6A2zu9XWO4nw5S23av1V
X-Gm-Gg: ASbGnctyPLbmcNaW63A5chXbBCE3bKZBxfGotR09fOeXFUOq3eRQ83L7y8EdpSu/vK6
 EdMIiukoZRmhsMoemZ0f9/gU0eFg3wdUEle+AYw==
X-Google-Smtp-Source: AGHT+IEkapHYNlUUKAjZj8egJF18AjyOabciUQrTJCmtjvX4x7gga/YoC2xZlf0T/eu7KxDIYeGVatztWXLKQd3DHZE=
X-Received: by 2002:a17:90a:c884:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2f452debc21mr7690176a91.1.1734966534558; Mon, 23 Dec 2024
 07:08:54 -0800 (PST)
MIME-Version: 1.0
References: <D6HQK0PSRVBC.XEUGZC9N1O5K@svmhdvn.name>
In-Reply-To: <D6HQK0PSRVBC.XEUGZC9N1O5K@svmhdvn.name>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Dec 2024 10:08:41 -0500
Message-ID: <CADnq5_M-aPD6tNppQ3_6dC8dgt7zeLXZPE5CdCjQEuEDxS=mWA@mail.gmail.com>
Subject: Re: [REGRESSION] amdgpu: thinkpad e495 backlight brightness resets
 after suspend
To: Siva Mahadevan <me@svmhdvn.name>
Cc: alexander.deucher@amd.com, regressions@lists.linux.dev, 
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Xinhui.Pan@amd.com, christian.koenig@amd.com
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

On Mon, Dec 23, 2024 at 4:08=E2=80=AFAM Siva Mahadevan <me@svmhdvn.name> wr=
ote:
>
> #regzbot introduced: 99a02eab8
>
> Observed behaviour:
> linux-stable v6.12.5 has a regression on my thinkpad e495 where
> suspend/resume of the laptop results in my backlight brightness settings
> to be reset to some very high value. After resume, I'm able to increase
> brightness further until max brightness, but I'm not able to decrease it
> anymore.
>
> Behaviour prior to regression:
> linux-stable v6.12.4 correctly maintains the same brightness setting on
> the backlight that was set prior to suspend/resume.
>
> Notes:
> I bisected this issue between v6.12.4 and v6.12.5 to commit 99a02eab8
> titled "drm/amdgpu: rework resume handling for display (v2)".

Odd.  That commit shouldn't affect the backlight per se.

>
> Hardware:
> * lenovo thinkpad e495
> * AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx
> * VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
>   Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile Series]
>   (rev c2)

Please file a ticket here:
https://gitlab.freedesktop.org/drm/amd/-/issues
and attach your full dmesg output and we'll take a look.

Thanks,

Alex
