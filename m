Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCECC3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087FA10E1F6;
	Thu,  8 May 2025 13:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hHylKgPv";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D32310E1F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 13:18:56 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-af5f28ecbcaso53706a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 May 2025 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746710336; x=1747315136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1roDko1XbrOHKIMUjuHPe417xq/761zF6ZWegodHkQ=;
 b=hHylKgPvvnZ2iuCm+IEUtpRtYLcZlGmVT/achzcc7pdlgOjG1FI29IMTdm0e87A8MC
 EbCIJ01iiedIZ/pBGDZ+KETKzfOYTBh6oynIRBDcTBKI37fZHoaQ92/04S8riWATp5R5
 KN2+/IBgjl+6Z51571Uk+ZdqEeF4w+8AEOenCL04r2q1xBUi22O8JhSoeuoAC1tqdGsA
 74uZAPm1F9B3ee8KNkCWuEL6E3HtTIO5XfCG7wNAMGWquLsxK8hbvgeNYey2yX7f6QDK
 f+W4ldjE7WTa2+5iBit4/cHLD1UqE3egGL5VJnn1AOVcwwni0EhLeK4egF0dCK2DQdd7
 lDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746710336; x=1747315136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1roDko1XbrOHKIMUjuHPe417xq/761zF6ZWegodHkQ=;
 b=iUc3vRda0z583Rap5zeF4vbeEe6/EJPgSQun6MR+r/KEluXAitUDag/MOBQhg2HOfk
 kFbWkb5cHqHNBEOtrX927qMZhLDNFIRoa2uTm+dT4LkQN58qKFi2iSetr6i9dKMW6zch
 qcgdpWfoqoaL0h3kQBKJjbaQX0QwjouZZKZwU+wTFNwBZ4o0WI26LPy19ri1gJd3CNkE
 hWQPlaMXAF+mlb9sfzQL3+Tn3qJ+nmW6jv2SruHKbXDylGzkPP6cyPLQdraz17h3aTfl
 OmSS5D4Yw+LnRGIJK0WI274h23VDE/nMgOvm9ET1IXgH3CFmqk/+VIR+C4lkEfS33qaS
 cvYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5xPIhUIqT46f5q88KC+tjIzru0Ix1ZouCaY6qPoMkcVMfcqa3KVES6odV3e99SmPyPBtc6Lq2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGm2j1ixtSRdf8Ag1zWBhohAz2+TuvHji3QGg9zX28rcONZSrv
 25ZmDChPTttUQe/jQ2lrfnsfdpNncPcmdVtj0sC8DE+3OELsgoNZTruAI1P9U/m5ahcHIzSz5df
 bQ1GsUCdD0dpexxr3YHIg8zJxcoU=
X-Gm-Gg: ASbGnct1TFHjuvKBCkjuouTpmDjnNfOOiYMxNTnpxm6psloU7cqsCVt9ehlfmqZoGMU
 RDErgwUUW14k5vcMvgTAbrz1HK7VqSOlrGcBcqv2pwHIxd/Bq/4Ytcm2YsqwnmD3oWbKDXxHuil
 1g37d9ta29y1jgSnlArYSnTA==
X-Google-Smtp-Source: AGHT+IFq0Lg3VZtCXUNslSbOl91jQC1KDok+Cuyoct+R62Hp6QOZMTlt5q0sgQH4VvcvrHtyIRM3g+TIjX0s0JSf60A=
X-Received: by 2002:a17:90b:4a0d:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-30aac168c32mr3996692a91.2.1746710335552; Thu, 08 May 2025
 06:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <c415d9e0b08bcba068b01700225bf560@disroot.org>
In-Reply-To: <c415d9e0b08bcba068b01700225bf560@disroot.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 May 2025 09:18:43 -0400
X-Gm-Features: ATxdqUGPLOFgD59MDg0LhtzD4qji_j1FkqfSHl_wTRX4mI-vM5Sp5qVFzLgtUw8
Message-ID: <CADnq5_PX1dYF2Jd3q7ghaBjpPhNLq9EmFJtN1w6YOSfVo++7sA@mail.gmail.com>
Subject: Re: Unplayable framerates in game but specific kernel versions work, 
 maybe amdgpu problem
To: machion@disroot.org
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com
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

On Thu, May 8, 2025 at 9:13=E2=80=AFAM <machion@disroot.org> wrote:
>
> Hello kernel/driver developers,
>
> I hope, with my information it's possible to find a bug/problem in the
> kernel. Otherwise I am sorry, that I disturbed you.
> I only use LTS kernels, but I can narrow it down to a hand full of them,
> where it works.
>
> The PC: Manjaro Stable/Cinnamon/X11/AMD Ryzen 5 2600/Radeon HD 7790/8GB
> RAM
> I already asked the Manjaro community, but with no luck.
>
> The game: Hellpoint (GOG Linux latest version, Unity3D-Engine v2021),
> uses vulkan
>
> ---
>
> I came a long road of kernels. I had many versions of 5.4, 5.10, 5.15,
> 6.1 and 6.6 and and the game was always unplayable, because the frames
> where around 1fps (performance of PC is not the problem).
> I asked the mesa and cinnamon team for help in the past, but also with
> no luck.
> It never worked, till on 2025-03-29 when I installed 6.12.19 for the
> first time and it worked!
>
> But it only worked with 6.12.19, 6.12.20 and 6.12.21
> When I updated to 6.12.25, it was back to unplayable.

Can you bisect to see what fixed it in 6.12.19 or what broke it in
6.12.25?  For example if it was working in 6.12.21 and not working in
6.12.25, you can bisect between 6.12.21 and .25.

Alex

>
> For testing I installed 6.14.4 with the same result. It doesn't work.
>
> I also compared file /proc/config.gz of both kernels (6.12.21 <>
> 6.14.4), but can't seem to see drastic changes to the graphical part.
>
> I presume it has something to do with amdgpu.
>
> If you need more information, I would be happy to help.
>
> Kind regards,
> Marion
