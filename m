Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1426CD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 22:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA0810EFC8;
	Mon,  8 Apr 2024 22:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LREPEZkf";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EFEC10EFC8
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 22:53:00 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-6ed691fb83eso644180b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Apr 2024 15:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712616780; x=1713221580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfJh8d387N7rSSjcIMDr9KOCrpACJYFzOd9e4x1vZA0=;
 b=LREPEZkfv/4OZvR5bhIESQkXs64KZPg/pZScxt2NX0QSpvAmm1xnYt5gbQNQaNqmdJ
 +2j58ZoDA4H6ximUrdHXFt2JASIMh4fCl0rI2ovjGPhA4gY6dV6uOdtftqY4Ryxr3Hd2
 4joS4rK5qxwLzvDr6StEJuVqQ0GRSQLQ+CxxRMxtamGAcWLqqb0L0igVpi+0BqKxI4Uh
 mXpihYJnHeyzC0Fy1ZwSZG2g5/OoVS/BFnpjZkJxlWZ84URJgt6FThWGTpvOIalSy21I
 3diPQwOgyysST2Gc+RwN7mPlqM7k2NNdzMhgeEELoDTyJfbS/GwWsUu8OXRKFrc9EOo2
 fD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712616780; x=1713221580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfJh8d387N7rSSjcIMDr9KOCrpACJYFzOd9e4x1vZA0=;
 b=w9MME5bxm3DWk6Rxq7XCmnhO1rYEjMkHsQEOSfnl3R9qYWUX5Qt6auNlvybMa11RiD
 4+3nXiRbF78HuSXIGe/HqZVnxm7A5EtJiY0+C67kQs5icQ77Ydx7kCnT+fjZvMQsU4rF
 gfgaHGBCTHI0wE/SnVWm/gqcKJ3T8yUVBE2Y6X556BlIVGZiltcja9Bv/4LvtbNFg/n0
 3g4uYnUf3jLfTIV5m8mUpWSld8HJvljHJXnaBEogwKTpoIjocngDo2X2VlJgQ0CBLMSo
 LEraXG0qYLhX78WaRC8NwWKkX4/nzywLxCIOZLbarjZrP9vATwJnw1NWUWeXt9e7rNdo
 axKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNcYLROjsU8wr0EMdMtKkKqH510foWXO9VTxBuE9RbGD2pqzKmaXY4q3upWnn8KqUlgmXCeciyQ8ANBoRGD4UQW6quFwHDBi7MfJAokA==
X-Gm-Message-State: AOJu0YxdTXOr1tAgeQhsLoTy0ZptLHAqjnzjkVGcWz6ArDufiN5e1tl4
 PZN6bB1JL56wHFSwM0PGhoCPBDiJqzMArybTWCF4G1OG76LTfPUdD2HVCsufsVqBDv71k5yV12u
 cxbvywlv+AZ895yAX+wEEE7E6wx4=
X-Google-Smtp-Source: AGHT+IF/qCwCMXstJyhBYi2r/FOGdr+2OEy0jlCB7RA5oy8mD8/vMM6IqVY5tFC55wdoyhY6OL596/NJR44k2FaGzns=
X-Received: by 2002:a05:6a20:6f8a:b0:1a7:48dd:3737 with SMTP id
 gv10-20020a056a206f8a00b001a748dd3737mr9780283pzb.41.1712616779625; Mon, 08
 Apr 2024 15:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240406-doc-gpu-v1-1-fe0ad057ac7e@kernel.org>
In-Reply-To: <20240406-doc-gpu-v1-1-fe0ad057ac7e@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Apr 2024 18:52:47 -0400
Message-ID: <CADnq5_NcJppSveEKAEWFQ5WJmKu4QwZYff=LN8Rvxd9MfzMN5g@mail.gmail.com>
Subject: Re: [PATCH] Documentation/gpu: correct path of reference
To: Simon Horman <horms@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Maxime Ripard <mripard@kernel.org>, 
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org
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

Applied.  Thanks!

Alex

On Sat, Apr 6, 2024 at 11:52=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> The path to GPU documentation is Documentation/gpu
> rather than Documentation/GPU
>
> This appears to have been introduced by commit ba162ae749a5
> ("Documentation/gpu: Introduce a simple contribution list for display cod=
e")
>
> Flagged by make htmldocs.
>
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  Documentation/gpu/amdgpu/display/display-contributing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/amdgpu/display/display-contributing.rst b/=
Documentation/gpu/amdgpu/display/display-contributing.rst
> index fdb2bea01d53..36f3077eee00 100644
> --- a/Documentation/gpu/amdgpu/display/display-contributing.rst
> +++ b/Documentation/gpu/amdgpu/display/display-contributing.rst
> @@ -135,7 +135,7 @@ Enable underlay
>  ---------------
>
>  AMD display has this feature called underlay (which you can read more ab=
out at
> -'Documentation/GPU/amdgpu/display/mpo-overview.rst') which is intended t=
o
> +'Documentation/gpu/amdgpu/display/mpo-overview.rst') which is intended t=
o
>  save power when playing a video. The basic idea is to put a video in the
>  underlay plane at the bottom and the desktop in the plane above it with =
a hole
>  in the video area. This feature is enabled in ChromeOS, and from our dat=
a
>
