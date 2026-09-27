Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A4BC98338
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 19:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FFAE10E69B;
	Sun, 27 Sep 2026 19:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hI4AaC92";
	dkim-atps=neutral
Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com
 [74.125.229.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A44810E032
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 19:26:58 +0000 (UTC)
Received: by mail-dl2-f41.google.com with SMTP id
 a92af1059eb24-141a5cf1370so61738c88.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 12:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790537218; cv=none;
 d=google.com; s=arc-20260327;
 b=gehJg0e5NiZ3P5EBmZamzAuP3v7i4ME+VrzOtGC8ahGeSAHp5uKyC8iMuXk7Ql/fgq
 MGzPycu26tCO6nS4Ro7KcjE3YvmCUD2TRToAeh8tSzSJWLiA9kcfRPN1mwUS0nVqZ3nY
 WvagV6kuPqJfMnSGbnLQqCrDzBfiJJ+66snF7ZQRBzsucFaE3xCs4HOsLc1+IGZHPYyd
 Oz99s+sKcT/oOf/6JVHbwkzTFi/4QOb3d8hNMiPct5U4vUl6qknZvzXSiRSivBiUtob9
 i8hD30hbpLbX340EnF4VnpHc22OtrI2qYJBgqUqvQ7Ob+21Jd4bTGU8Qc+TZr6Zb06Wi
 jfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bLQ6al9H/Dbtt02cX9S5WR+KWcZ7MbpFtL/ELZ6WlQM=;
 fh=cL0nr/MuDyukwBhLdQuDMe552S4lA4QXdnexC0pKAMs=;
 b=kzxqQ8zlZFQBSb568+C0C/2ssTr5DqhIUQdj2CislpwqKiRTe9K2h6bhTVbA+CxBfA
 KRcvvucp69szh9KQhou/Chaupmt1/SgC8eBmxSmwT6lVo/5BuPEyP1LG1CQbD/YhrI8P
 6bGOXb+yMGeNROib4NE0F8w1c1tgaUZCXa/KvKF46eJRlpdnl8K2b4tQPwYbJ8AtcQDz
 3ChcoyMq+2VuSKPhNiEi95qb+fAtbAfaFtYaTX28YeRnBtqoZP0qWBrdtMbsZtHbNxz+
 iac/xnaVEB2oJRTDxIMlF9LD07tPba2i0YkPHiMbxuxC/XD2YjahGtiH6IqjudM07HW4
 dRzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790537218; x=1791142018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bLQ6al9H/Dbtt02cX9S5WR+KWcZ7MbpFtL/ELZ6WlQM=;
 b=hI4AaC921+ZrtA1BntM3zL+ZCbY4/B6h8Lr2Mz9JJWxwtfglmN3LFBDpuLyrwQ5pV9
 UwLkm9UKeN/7f0fFd1nqaRwqS333HHDMrPsG+mKKQzgBpVlEuwfXpqjRdwe+7MwLr4HQ
 ZUML3UUNo8LqK6A4wBy9OAsdX/5IAavSfjtFxU+hFWs9GmwdYq14KIkZltBgMmZ/IpId
 go2b41sp7E7Lx3ju32VQdEmGNGbEnH2p81ZsyhFso+OaPxidl8Mc47bjc7kTvj2riLPA
 35ROB/zsxXbgE2+3nU1wUZ1yG0nUCmOiIZXFb31DyXBSOprHKeCctq8ttxeAPSmNPoK6
 j2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790537218; x=1791142018;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bLQ6al9H/Dbtt02cX9S5WR+KWcZ7MbpFtL/ELZ6WlQM=;
 b=xZ5Ab2TSIlSm0P8wdC4zCBUOlRipFQxuwJgjnGJv1wnI1kb1gqesqEJRppCiTzw9Xv
 UbH9Bx/b1r61aRR77zHIvsVBOPiVP9P0iLdl6ls5RffXGto0ViN0L/QWMucqWHVYSFXt
 YWY8yucCmlGCt853J4ZV8PhXH1tWJptntWtBNAfccpCixQWiuxlt7fQDsLpsfqNIOjG9
 nW+jb7GXp22bZQh5FtKmnLQTLn9ABtipc31BTOGHZfmibUZQdfjNf5K5NLp26FwRzcl/
 F4reMew7mb19RL+Aao3LojWeSXvD4EoI7TqA/cQDSvHOns1QmG8AkmNgD735jOBmE2N8
 48Rw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDXNalCmOTxWIKRJcjAKsV+mWNhRFCPX8DzqOZfJpPaImHK2N1XZV2JmJgSPsff04a/aXUoFL2@lists.freedesktop.org
X-Gm-Message-State: AFuF++k0kkS5hMWqhMhr6wW1z/E9+2a2ya3RFDEzGPcZChFTWhs8cpb0
 CXVYyFX3j0MAaRpmaR54TEdJV+tnZIcY9Y9UmPeeE3CuhYZx5XRIRTjO0lzXwLNW5trQ9CycXAu
 ThT/J2D86MjMq6ViH5tdz/eoxaZZo/JA=
X-Gm-Gg: AYBFou3YXRI7PmOma/MluH3A1tZEWY45fm7KcPlN315DL6mI8vsjHGDLSzByrRLy8vO
 mPgnkbupeQLGe0fVo/8M5IyZdvm3t0Hh2+qTjky6Zdy7KqFq9JsS2ACOaUbrX9i0+FGUDMev8Uk
 2OSYlLT6GaT97BNyQ3l3Kjlwz1u1M5IPhz3hqzcmbv9pdC/jqO1W0AjTpE1hf6WnvmVEn/Ii27g
 LBPmH21SE2/0nzbUjn5H8ym4NVUzUGXFO8LlFhfGkyV8I18jHfnpE9COcXRQZ7laQbtChJefUV/
 rUs8rcuWk17Bgf3Kk8ic8VlzBOvrgZyztUxYO3wv1wiJlAVVIHrVBUNeH4jXb9e2F6I26O0cmy6
 o9RS5JuD7ppOs7gZ6ZLZewBPFoqfRvnK1jRszS7ZjUQ==
X-Received: by 2002:a05:7022:29c:20b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-146cfdd1a65mr11563219c88.2.1790537217579; Sun, 27 Sep 2026
 12:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260927145505.16883-1-kaloz@kernel.org>
In-Reply-To: <20260927145505.16883-1-kaloz@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 27 Sep 2026 15:26:45 -0400
X-Gm-Features: AclHuK-CrK0NLf-dOyv1g22nCfXksI0ZY8rCmFNjK9n1wbeXqCSPRlaJ6RVXPAU
Message-ID: <CADnq5_OB21LmvT-J2Ou_v1cNPNwQHz9wapwgauNzuDthRHcMiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/radeon: Sun XVR-300 support on sparc64
To: Imre Kaloz <kaloz@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Sun, Sep 27, 2026 at 11:06=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrot=
e:
>
> These two patches get radeon KMS working on the Sun XVR-300, a
> FireMV 2200 PCIe (RV370) board, in sparc64 hosts.
>
> Patch 1 fixes an Oops that any posted radeon card on sparc64 hits in
> igp_read_bios_from_vram(), which dereferences an ioremap() cookie to
> check the VBIOS signature. It is tagged for stable.
>
> Patch 2 adds a legacy connector table for the XVR-300, which has no
> COMBIOS for the driver to parse, so both DVI-I outputs are found.
> The XVR-300 needs both.
>
> Tested on a Sun Ultra 45 with an XVR-300.
>
> Changes in v2:
> - Read the signature with readb() before the allocation instead of
>   checking the RAM copy, as radeon_read_bios() does (patch 1).
>
> Imre Kaloz (2):
>   drm/radeon: Read the VRAM VBIOS signature with readb()
>   drm/radeon: add a connector table for the Sun XVR-300

Applied the series.  Thanks!

Alex

>
>  drivers/gpu/drm/radeon/radeon_bios.c    |  6 ++-
>  drivers/gpu/drm/radeon/radeon_combios.c | 51 +++++++++++++++++++++++++
>  drivers/gpu/drm/radeon/radeon_mode.h    |  3 +-
>  3 files changed, 58 insertions(+), 2 deletions(-)
>
>
> base-commit: fe2ec83746e501645709761605c2464a44fd2929
> --
> 2.47.3
>
