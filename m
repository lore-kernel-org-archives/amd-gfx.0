Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CA5CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 16:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E6E10E43E;
	Mon,  3 Nov 2025 16:01:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XsBxXQk/";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC7510E439
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 16:01:06 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso3507279f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762185665; x=1762790465; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFOzz0wAZIhOa83lSzYHpWTVENhNfxDx68tajRarAN8=;
 b=XsBxXQk/AQeW4537Bv1iG+SRRePNXTpPKynWPmGm2cONYjYD2NmDuUm4VhEI+5MCNi
 nna7/VsxSYEe66waJmWhwDLn/+lOqQzy5ptZ2eB3GCSteuCQYufcC/qhs7m2MnbLmeI8
 hNdm3DruBzFsG2mPuwx0vUiue0o0yGIrL4o5QTGsgVV+pf4nEFMx3NDlEX/IYlcxqD76
 BZdBEH32ZB3Vql/PWofXZXLk/PD5ZhMqqUYvFvjvkd0fYaOG5OlBGVYTOVgBQHYA6cpM
 3RukExy2ELjNbFSsIWjL1wYAmKO5zVVcSB4MjS69x+4PHROmmjo5thw/xx2hhhiwEXti
 PbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762185665; x=1762790465;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oFOzz0wAZIhOa83lSzYHpWTVENhNfxDx68tajRarAN8=;
 b=PrKrDTPs3mbtBZsW5xOCxD8MUC7x42YSQaWa/eDGHJcOXeuoz/3yycSvy1pJLMPQDT
 RkNn+my2xAkEAUN0/2i7LMFUO80Ex0lHVMu/3xGqSBvTTNW2+NPRUf/5oUKDIODgTt1J
 SJ7bgk/k1C7aZ5nruwbkl3F20rtNFnV8Z4h+SIY4jEJARY/FcymHLPKh7t3W8pDv0Q3R
 EcMjea2HEZIRnvujFpRrwb0V4DY/2c6bjG1iwHHc2WtnW85R+XYzjtxrAeBIo7/qhhu7
 ZHYObg9vyn1T1ZLI3Aiv9a1FdE6z7Mz1YKsqYuH3z+54cmVMIsFXZzJ4ULyyA9LjyZwh
 iGnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyYjTKJklEyr+Y7WD7SQhb1hzX2PHvZkhwiLoaD0X9zeqycf88/dPsqphtbqvPlQb3CrMAmZe8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxjP2a29t0XE9sNo5jJ6ePJ3iTsZ6nEQ005AGw4elF86HhjV9J
 xFNGxPzUuBfsbbiq59Nu4+G39JV7sFWwcfVKEOywQqWmMcng3w6OKD6A
X-Gm-Gg: ASbGncvURaz1Q1wDw6T26kJcKWP6QpAGx1WqaHCrN/7eqwQeZHS+uMelqtPDSNvzp4J
 zYU1NChjHPMULQ97mV2bEEJxrJRz75lzuohHzov+J0VjM29A251fuOvCPtxeboIqf8xNdNSY3op
 ZCTAPVyIeKxfK/BAJywCIi45BmSywhYOhCj9L1mZWnZApnAkRYDNc/wNYaxJnceZVpfXa/Hxm+i
 wMEL9Z6g7nhEcvjn1vJU4R9uX6jlUFgFwmS8J8h41Zxq+021Ol3VhB2wht6tck3s0IDLbbVl/04
 U1Wd1c/tPAgT1L/ZdgHL9H+avNrvDYdZaj1BlppG3V8Q8io6njhmC5aBIpwL5axtzIHK4dA0ZlQ
 CLRhSnPAd3MhCInAoR1prBxpZMLjUjuTecprcIy3fF3s2yGrQK1kJgsdpnjrLAi5lpWHptJgmt+
 RszPYUTEXFpRaQfXMRJCWoSCB1Q1jvGllk45wyMgGscZAh63WStDiMHKyDX12a
X-Google-Smtp-Source: AGHT+IEx1gOV3AVO2j7wPuEIxhA/P+Vyjw7q2fy65B89euTQsKt5iU2WFAWQH8TAjmimRYL9ZII8pA==
X-Received: by 2002:a5d:4b0e:0:b0:429:b9a1:5a8 with SMTP id
 ffacd0b85a97d-429b9a106e5mr10579584f8f.7.1762185664818; 
 Mon, 03 Nov 2025 08:01:04 -0800 (PST)
Received: from ?IPv6:2a0a:f640:1510:1ea5:fa4:fee7:921f:73f6?
 ([2a0a:f640:1510:1ea5:fa4:fee7:921f:73f6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c4af7c7sm166446905e9.7.2025.11.03.08.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:01:04 -0800 (PST)
Message-ID: <ce0fa589d4e2416947b7e448a96c7c5a9957135b.camel@gmail.com>
Subject: Re: [PATCH 14/14] drm/amdgpu/vce1: Tolerate VCE PLL timeout better
From: timur.kristof@gmail.com
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"	
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"	
 <amd-gfx@lists.freedesktop.org>, Alexandre Demers
 <alexandre.f.demers@gmail.com>,  Rodrigo Siqueira <siqueira@igalia.com>,
 "Liu, Leo" <Leo.Liu@amd.com>
Date: Mon, 03 Nov 2025 17:01:02 +0100
In-Reply-To: <BL1PR12MB5144EEC673FEA676A56B31A5F7FAA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-15-timur.kristof@gmail.com>
 <48516ce1-37ac-4278-ae35-57f641ea1efc@amd.com>
 <BL1PR12MB5144EEC673FEA676A56B31A5F7FAA@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Wed, 2025-10-29 at 19:46 +0000, Deucher, Alexander wrote:
> [Public]
>=20
> > -----Original Message-----
> > From: Koenig, Christian <Christian.Koenig@amd.com>
> > Sent: Wednesday, October 29, 2025 8:02 AM
> > To: Timur Krist=C3=B3f <timur.kristof@gmail.com>;
> > amd-gfx@lists.freedesktop.org;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Alexandre Demers
> > <alexandre.f.demers@gmail.com>; Rodrigo Siqueira
> > <siqueira@igalia.com>; Liu,
> > Leo <Leo.Liu@amd.com>
> > Subject: Re: [PATCH 14/14] drm/amdgpu/vce1: Tolerate VCE PLL
> > timeout better
> >=20
> > On 10/28/25 23:06, Timur Krist=C3=B3f wrote:
> > > Sometimes the VCE PLL times out while we are programming it.
> > > When it happens, the VCE still works, but much slower.
> > > Observed on some Tahiti boards, but not all:
> > > - FirePro W9000 has the issue
> > > - Radeon R9 280X not affected
> > > - Radeon HD 7990 not affected
> > >=20
> > > Continue the complete VCE PLL programming sequence even when it
> > > timed
> > > out. With this, the VCE will work fine and faster after the
> > > timeout
> > > happened.
> >=20
> > Mhm, interesting. No idea what could be causing this.
> >=20
> > Not sure if just ignoring the error is ok or not. @Alex?
>=20
> Looks like these registers can also be accessed indirectly via a
> different index/data accessor besides SMC.=C2=A0 I don't know whether it
> matters or not.=C2=A0=20


I've tried various things to work around this issue, including the
indirect accessors that Alex suggested, but they didn't help with the
timeout.

After some trial and error I think that on this one specific chip, the
PLL takes forever to wake from sleep mode. Unfortunately, just
increasing the delays or adding an extra timeout does not solve it.

However, if I never put the PLL into sleep mode in si_set_vce_clocks
then the timeout never happens. It works if I either just leave the PLL
in bypass mode or if I put it in reset mode when turning the VCE clocks
off.

I would lean towards leaving it in bypass mode, because that seems to
be the least risky and simplest solution. Does that sound OK to you
guys?

Thanks,
Timur

