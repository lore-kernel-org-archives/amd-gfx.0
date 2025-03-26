Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63860C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 17:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0852610E19A;
	Wed, 26 Mar 2025 17:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lwkyJFRX";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4AB10E19A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 17:57:15 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-301001bc6a8so13066a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743011835; x=1743616635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63fjjrVzZF7U9nA12lUfHyh6yrdFiEzR4qrxstyzVz8=;
 b=lwkyJFRXhH3dhF74RZI9CucnJAr375q8VNOQt4WKeyRAF9FnEGKXbv2OGpMI+DbXJ1
 pAIuifnIDF3+g6zNehbb2dBe6OfsY/noX/AhiZOaX7gjY69FiL+3KRMrLBpTSSM/sI/M
 vti6FVBWo973QsFAvcixkmcc54Mh+m1OQ/YlekthdEZ7NafzIZB2fXdN1aKnZLppj78D
 amkHL3CdFSSRT4T0Fa4wDx1QYdnYhjTWc6xEX2gEr7zfcXSyLlXaKAZyW5EUNyNgEJmO
 zTi1s3KkNcUf3jS1NpVnuKwJ3Oovv4fMnP8XlJRXvQpooRoi35DB2SvOB9LKb4qidHND
 iXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743011835; x=1743616635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63fjjrVzZF7U9nA12lUfHyh6yrdFiEzR4qrxstyzVz8=;
 b=S2T2UE4HOklbheQKGJCWx9J72bS6ANK04f+udDJ/m91q3vQzmYV/UElLE1/hslw92A
 f5iZfg83CCdvNbmcU2HXOCJliYI71b9SpBL79n8mPdnzMEX0NGDUlwES8dSJ0Kc1cA19
 aGtoAxxnh+pDqw651X4U0hzL3f9vd7l/6C1UTeW7vIgi/lEeTrHtt5VxHchlwg4KM66U
 Jsd6xdKaMBioS3Kk80GhRbw30XEmZt9SpPO5thRdZ4sU9IDxgSvCwxDkyweYtanbn7xi
 m51U/+/poIRXOnZbdk+Z1/URjjol++79Sg4nYJjaCgT4kZLnr6i3r7P++X99Hya9p5Rq
 LTdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpwvRcZRB3Cs7et2U6loB4VNFlRTt98lgUCmvPr3oW1GVoXV4m1r4LTy94i1pG+Ff32mtm5dKx@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4YmBIY7AdtVLYim2u4sIEoXdyw0kgsKvymiXFMUddJN8DTj+Z
 uSlmvv4uh9EdkjY8TBl7U/LioATv9hCfNAu/d/DTil8QIWA7ygYGvg4BV94+fKuHw/smsKQZbXE
 pvBlw0+o5rlYLwPs5lQJ0tCQ5eAo=
X-Gm-Gg: ASbGnctW5FHoj8FWJGVv/35M9oP72IWNNtFgQzFcYUjHoGzBdDp8rwE0JEmwCjwoNON
 /monpRoUn2GwEPP8HlWaUYZc4DuStvvu9zYxsnGKiiZTgMPhxgiVOeammZ50DZiKngnKoSnG696
 qB4TvZ09GfEcZjb9LGtw8qpaj8Lg==
X-Google-Smtp-Source: AGHT+IFb4SEstX+/J9aVa/lak6Q1K8so67eSN72VztIppG579APDLZXb+PxCLyLaLw/Nuz0xYqGAsd80iPddj13PKM8=
X-Received: by 2002:a17:90b:4b92:b0:2ff:7b15:8138 with SMTP id
 98e67ed59e1d1-303a91b2681mr267988a91.7.1743011834466; Wed, 26 Mar 2025
 10:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250325172623.225901-1-siqueira@igalia.com>
In-Reply-To: <20250325172623.225901-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Mar 2025 13:57:02 -0400
X-Gm-Features: AQ5f1JrJXGbs8Sb8S_t305FOfs8CojJkoSogqnVNxQIYA3I5rXe3UQiJK8no14s
Message-ID: <CADnq5_MEfXnGtGNbBxj-WFZce0Dyf0ikmXqxre+UeFgvoVjozg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Documentation/gpu/amdgpu: Add documentation about
 Pipes, Queues, MES, and others
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Melissa Wen <mwen@igalia.com>, 
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 kernel-dev@igalia.com
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

Applied the series with some minor clarifications per the comments and
my proof reading.

Thanks!

Alex

On Tue, Mar 25, 2025 at 1:27=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> Hi,
>
> This patchset came from my endeavor to understand better how some of the
> amdgpu components operate; in particular, I was focused on the ideas
> behind Pipes, Hardware Queues, MES, and Ring Buffers. In some way, this
> series is an attempt to put multiple pieces of information spread around
> many different places in an organized way in the amdgpu kernel-doc. In
> particular, the following links were crucial to create this series:
>
> * https://lore.kernel.org/amd-gfx/CADnq5_Pcz2x4aJzKbVrN3jsZhD6sTydtDw=3D6=
PaN4O3m4t+Grtg@mail.gmail.com/T/#m9a670b55ab20e0f7c46c80f802a0a4be255a719d
> * https://gitlab.freedesktop.org/mesa/mesa/-/issues/11759
> * https://www.x.org/docs/AMD/old/R5xx_Acceleration_v1.5.pdf
> * https://gpuopen.com/videos/graphics-pipeline/
>
> The first part of this series just updates the amdgpu-glossary with some
> new acronyms (some of them useful for other patches). The next two
> patches are just some basic organization to improve the documentation
> flow. The last part describes pipes, hardware queues, ring buffers, and
> MES.
>
> Thanks
> Siqueira
>
> Rodrigo Siqueira (6):
>   Documentation/gpu: Add new acronyms
>   Documentation/gpu: Change index order to show driver core first
>   Documentation/gpu: Create a documentation entry just for hardware info
>   Documentation/gpu: Add explanation about AMD Pipes and Queues
>   Documentation/gpu: Create a GC entry in the amdgpu documentation
>   Documentation/gpu: Add an intro about MES
>
>  .../gpu/amdgpu/amd-hardware-list-info.rst     |   23 +
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   36 +
>  Documentation/gpu/amdgpu/driver-core.rst      |   77 +-
>  Documentation/gpu/amdgpu/driver-misc.rst      |   17 -
>  Documentation/gpu/amdgpu/gc/index.rst         |   53 +
>  Documentation/gpu/amdgpu/gc/mes.rst           |   38 +
>  Documentation/gpu/amdgpu/index.rst            |    4 +-
>  .../gpu/amdgpu/pipe_and_queue_abstraction.svg | 1279 +++++++++++++++++
>  8 files changed, 1485 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/gpu/amdgpu/amd-hardware-list-info.rst
>  create mode 100644 Documentation/gpu/amdgpu/gc/index.rst
>  create mode 100644 Documentation/gpu/amdgpu/gc/mes.rst
>  create mode 100644 Documentation/gpu/amdgpu/pipe_and_queue_abstraction.s=
vg
>
> --
> 2.49.0
>
