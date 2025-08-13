Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1EDCA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 14:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 226B710E735;
	Wed, 13 Aug 2025 14:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PBVCdrE6";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E840E10E1E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 14:15:39 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-24286ed4505so12279745ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755094539; x=1755699339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFLPY45ROz0kfPTcGhabqXQUl5X5wqn3yijwjWJOUtw=;
 b=PBVCdrE6vpPvkKapLpq/IFFg3A7eUDxhKIMSCeKfnyTNcZosNaKKxL+r+tQcFniz97
 liJMojGJfh2HPKTEGt4OYohELnf2M9dgBMIJHcSaRkDaRPbsMvlG/KuhLV+RQMt2yIQJ
 n+Aq1p0bkGWxwAIZmiTgPcl7AbhlX33VZgN2dnZ756CI4Pl7E/Z5Ay03EwGLO44Vu20d
 JMIrFqrE5FMV9yFy77SpCb7hEuZ8ZbguLS/gVthfMzo7IW2TjDL5qHuslYhDkvXBzl+G
 3/zyOSmOZevKjfRbbzZrB9idprsZR5MXoxOubAOAJkjNGAxfYrlVWFKSLOZoUTREm+VM
 qokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755094539; x=1755699339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFLPY45ROz0kfPTcGhabqXQUl5X5wqn3yijwjWJOUtw=;
 b=K+Q/7SAhR3jKY/cnMX98PyMVgykemOIKao7PF4oj74RjxE1DnXUPKjh5rM2MHem6LZ
 KJ60I4nfEVXTCHoTed80nHkplJ9eStCqWgMajtUyMAsCHXamq3CQYDeJ+TgSLQYIyhOZ
 +AWGN3cfIq6jJ3SIb4UGzi7f29NpNXKIiP0YASKmRRTqOlMwGjlu/raR1ZWPfOhd3gnM
 AAdk32uykQIBMnhcxN7QDzauRZkc7rDPaV7PIaWcgGXVJBUC6l9sVaaTUVAtH5wVLJZV
 yOXbCoLp/5326nVlFwj60LgjylxDZO0R5Tv7iY6PjUKPoj7g2QJvZJLMSv/YUCwr9Mht
 V4Bg==
X-Gm-Message-State: AOJu0YzNEPpm5iYMj4x3fFhSF/teEree+6Mp0OhsQamTEViumnbmtofC
 VvY8xwnFqppB2Rc8vA3j2bxKh1gHaYNmF3JKeC0urzA/8DREFn96HS6OrvAhSQscTliyhFzojqH
 L3Gfga86rA9aWoVqL09toxOOTmsMzcbU=
X-Gm-Gg: ASbGncs0fnbcWdR7K6CJqS1m3uRdvk9ybQvQBKMMjiFV4d0AeLbNK8zlr/dvCn2KIv1
 9NsHOdrA26JBFY8w9fEh5ntNblytT7ciAlwcGJWPwqlETCA/Vr3EbJ86m1KkNwPHj3DZl10mGst
 b2BckZj11fl1wtCDE5+y+TGfNUiwevumnlPa05u50tzEY4P7vlSg9X+btNTFCkNlOClglP2B+S7
 /dYSJNCvkiHPTdSbQ==
X-Google-Smtp-Source: AGHT+IE7LYG50b0kOtdul89aBlxk6Nwh+5QL882N44thXiB2jmJKdm1mSD/RA1qZsGjjqwLQAXeMLkeHBIGACu4mbw4=
X-Received: by 2002:a17:903:41d2:b0:234:df51:d190 with SMTP id
 d9443c01a7336-2430d119e07mr21276885ad.4.1755094539242; Wed, 13 Aug 2025
 07:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 10:15:27 -0400
X-Gm-Features: Ac12FXyqHgnsF2e4SFsySWtlBPe9B6KkZ92-4FfVudIYURNXJV5y_MSIeK7gtYo
Message-ID: <CADnq5_M8gjwe8q1ZZABOSz42RDCzDPjQGQQdQ0OxLV2BB8y38A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add and use "name" member to radeon_ring struct
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Tue, Aug 12, 2025 at 8:08=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> This series adds a "name" member to the radeon_ring structure and
> uses it instead of ring indexes in logs and std outputs. This change is
> proposed for better logs readability and ring identification as much
> for the average user as for debugging purposes.
>
> It uses the same naming convention as the one used under amdgpu for
> coherence between the two drivers.

What about the other devices supported by radeon?  If you are going to
change this, it would be good to fully convert the driver.

Alex

>
> Alexandre Demers (4):
>   drm/radeon: add name member to radeon_ring structure
>   drm/radeon: rename ring to ring_idx in
>     radeon_fence_driver_start_ring()
>   drm/radeon: name rings
>   drm/radeon: switch from ring->idx to ring->name for printouts
>
>  drivers/gpu/drm/radeon/cik.c          | 33 +++++++++++++++------
>  drivers/gpu/drm/radeon/cik_sdma.c     |  6 ++--
>  drivers/gpu/drm/radeon/ni.c           | 10 +++++--
>  drivers/gpu/drm/radeon/r600.c         |  8 ++---
>  drivers/gpu/drm/radeon/r600_dma.c     |  8 ++---
>  drivers/gpu/drm/radeon/radeon.h       |  1 +
>  drivers/gpu/drm/radeon/radeon_fence.c | 42 ++++++++++++++-------------
>  drivers/gpu/drm/radeon/radeon_ring.c  |  4 +--
>  drivers/gpu/drm/radeon/radeon_vce.c   | 13 +++++----
>  drivers/gpu/drm/radeon/si.c           | 36 +++++++++++++++++------
>  drivers/gpu/drm/radeon/uvd_v1_0.c     | 14 ++++-----
>  11 files changed, 109 insertions(+), 66 deletions(-)
>
> --
> 2.50.1
>
