Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7877CA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 08:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770AE10E816;
	Thu, 14 Aug 2025 08:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bRgeXu0i";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F5C10E816
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 08:07:26 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-afcb7aea37cso81250166b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755158845; x=1755763645; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZUcotvsDquL9lgAeBohW6dqhI66JLHJfCu1YqNlm5U=;
 b=bRgeXu0iDKpwgcFihg17CAiMb3NrESgkBGwZteznz75jRveA8uU301B193uuo+FYFG
 CLmGZZQrzWUq6rtWIFefD6Qh2mCppsj7zuqjvGfgMO5HUDcJiVAZGKnbAHPvs5JHdydP
 /yLOxcm7F9Z+eSPm1XreWm6AcTx36xNXWa3e6B3RiGr2uuBjHSzVSG/8Styl/2MDsDX6
 RnPOV3kDXZByiWH3Ofh+vsJDmX6VxJHBekfrPMM3Z10ca+qvHFmNCkJvEH8bsn/mhdmX
 Kju0M0ZlFEjMwZZ2zhvLFjb5341o3QJWsjfWJZbXe/ijSpHQSk7aEpjJBoLyNt5pJ1ku
 FL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755158845; x=1755763645;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hZUcotvsDquL9lgAeBohW6dqhI66JLHJfCu1YqNlm5U=;
 b=vmNnX1+9bA8x6HhfbvcYuEX/192A9FrrydQFQQtl9EiQn4uaDbxU/kSPiHKgzmsv0n
 N6Wyd3LdiX+SXvZMWM3lTqvX5SbZP5aumIHl+F7QaeCnFiWghIF7XNFN+t6p0nP328H+
 hUkoAMivk2Wx8NMoWYi7OXtxWGM9WCpcJVNw/LhWAfgDpR+1qyzN/tSC6eM3gvk9y6Os
 6i+BYO5uyZ0tg1UnF5iTb9s03rIaWWlWZw0JMjQl7FHGVRQzkqIhI+rn8w0D+UBv6Xhi
 nBunf3x9z6FyPXHJA16zsiq0KWQ0XGOdc6rFn8KfguhRpq3DdFnjM1omRfC8DvJFiSZY
 XSMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTYHz7ym5cVB+8Vmh+Tno/s+gvlwxGkvOjr/Fg7/Pyy9z9O1W6ssDOy13TSZOW9bMj2mHAy4cu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqF/OfxlARc8D0iaZIUpw5zJCU8DV+0SeAsFLJy9ZOoqzAhlqP
 jGorvYaS1yPckxtU2XD+xk0YQdREhK5/0V2dkwZX/E+e7dUfQKvKOY4B
X-Gm-Gg: ASbGncsTvrTS3R+D9KQ/TivsltHTYeHJXcuNJoW2wSM1jgJDny2GQx+Jaow8zaUCPFo
 8eaeQcFOpE9oJSP1n+qHUnQ7T6b7y59HzGwWTFfRc/q4CVWKMQ0BmDY8I231QXclzDUxjNjtR+t
 9nGB2yHHwXF896FR0Q/uNBDZgPvw0U7+AsSLqTEjHcqeF7S0NEO3oQ0DfNaSSrzIRLgO+pKt6Pd
 0pd+Wu9uF/eJs2fCEKdM8oMKIbhCLSta93lbFEt1eduE8HoavFMnE6Bodkj/wE9vN3iXhqXiva9
 S6loeu2rUiUThI6Z1htcFCL81I1oqPWUPbddKFEAapF+cfqVziFVIkVf92kpuXrtWMf8Ehr8xgD
 jle9qAYz4xPMW2JlLnvhLTNwmcIyisy8=
X-Google-Smtp-Source: AGHT+IEryq1CwGpZXQB9rGdw/oHdLosyr6tJdMWj6hzLzhRRZOSV3e6qWh3w6lwmPq7meB9ukn/oUQ==
X-Received: by 2002:a17:907:7f04:b0:af8:fb0a:45b4 with SMTP id
 a640c23a62f3a-afcb985b6efmr213879866b.18.1755158844736; 
 Thu, 14 Aug 2025 01:07:24 -0700 (PDT)
Received: from [192.168.88.21] ([212.92.10.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a21b0d0sm2506015366b.107.2025.08.14.01.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 01:07:24 -0700 (PDT)
Message-ID: <1ae6b702dc5a5fe062b843d6176bb4a4c962fbcb.camel@gmail.com>
Subject: Re: AMDGPU's rings VS Radeon's
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alexandre Demers <alexandre.f.demers@gmail.com>, Freedesktop - AMD-gfx	
 <amd-gfx@lists.freedesktop.org>, Alexander Deucher
 <alexander.deucher@amd.com>
Date: Thu, 14 Aug 2025 10:07:23 +0200
In-Reply-To: <CAPEhTTH90Rz-UFVJCdsi=vP5BSuQxVB3W-Qe1yVKH93txBLFsA@mail.gmail.com>
References: <CAPEhTTH90Rz-UFVJCdsi=vP5BSuQxVB3W-Qe1yVKH93txBLFsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
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

Hi Alexandre,

On Mon, 2025-08-11 at 18:00 -0400, Alexandre Demers wrote:
>=20
> 2- Under AMDGPU, SI's GFX (GFX6) ring size is 2048, while this value
> is 1024 for all the other GFX versions. Under Radeon, the GFX ring
> size values are all the same (1024 * 1024) under Evergreen/SI/CIK/NI
> and others. Is there any reason why SI's GFX6 ring size would be
> twice the size of the other values under AMDGPU?

The ring size determines how many IBs can be submitted by userspace at
once. Originally, RADV developers chose 192 maximum IBs per submission.
As far as I'm aware even today there is no way for userspace to query
the kernel for the number of maximum submitted IBs. (Someone correct me
if I'm wrong about that.)

I think the kernel developers chose to stay compatible with RADV and
the ring sizes are chosen to ensure that there is indeed room for 192
IBs per submission, based on the IB size and the submission frame size.
These are currently not set ideally on GFX6 (and are wrong on GFX7 -
I'll send a patch soon).

That being said, modern versions of RADV will attempt to use "chaining"
to reduce the total number of IBs submitted, when possible. We deem it
possible when the VK_COMMAND_BUFFER_USAGE_SIMULTANEOUS_USE_BIT isn't
set on a command buffer. So, practically in a typical Vulkan
application, it would realistically submit just somewhere between 2-5
IBs per submission. However, if an app uses
VK_COMMAND_BUFFER_USAGE_SIMULTANEOUS_USE_BIT excessively then RADV will
still submit those IBs individually, up to 192 of them at a time.

In the context of your VCE work, this isn't really relevant as I don't
think RADV can use VCE.

Hope this helps,
Timur
