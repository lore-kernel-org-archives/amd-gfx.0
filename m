Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED86606A320
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Oct 2026 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GX0nNouJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4015210E28E;
	Sun, 25 Oct 2026 17:14:44 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2376810E1BB
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 17:14:38 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so17933195e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792948476; x=1793553276; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sEy0j/RTCNKSx/ZED7H6UZ0ZuCG3MgcRugWXcsq/UZc=;
 b=GX0nNouJ5DuYhvHnSC9cE3DhbEa5pjQZzxNrXa3J9A8ugazj8eVCb2A8dOymSy1X5+
 L8Hl0Sp7q66nWH21JAVY9mClX/m0jptSCPyRibkBm7GR0iHt4zXq23UzuN1stTY+f7pt
 TT6naU8Z8blD7ZvzrbAMNEZakA64nc9Y8eVenHrsaaduIkUGDPhuG+1uWGbzrcKxaAKh
 TGHrzyNII95gvdZ5g8pIlviuJ8S61SjGRdaCZTVL82rVCIfT5dP+KzJL/k12uOS+dQGE
 EqDEsRz4nA3X0A9OLvslXCq1aHHTgeFaO/CroSgwLxVV+amNfKPxalLb/P2erN1vQQ/y
 JZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792948476; x=1793553276;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sEy0j/RTCNKSx/ZED7H6UZ0ZuCG3MgcRugWXcsq/UZc=;
 b=Q0ufy+vVd+zlyzfBxkGbHVGENo85L9Kg2257I107NwNZLsEXr0kllK2/pLxZJkoxgC
 2dWFH82gNbxMxisZoVWS5e7N6gqyi1NgsJVD/WOE4Zp03o6B3Ek2dHmebZiSClpmn85t
 gGun8FkPu0q1h+02rWUqLlVPON644kw9z3DO7rEDnnK/ff2i7oIY0KZcKVANBoG6/Vtc
 9vcQtVOdNHrncDpMeCHh8uTh7ocR8ORuxmXdGIPZ9BOvOEYGUk7G7yrQXn9zGYsbZ/p5
 lsE0+YNw2CrW6weluh9EpdJK99kT/mYoZuj7kAK7P0Hr9Vqm4JyF/O8J3qTS9dVIsDJs
 VRYQ==
X-Gm-Message-State: AFq9FYI82rpaxrVxaeTwTK0lQT69D5Ti9H0D2yz4HTtz14a/0qHQYeiv
 MkJpHi1hQk6URiuiambQZwaoEFZcG/d5ekvKMbLOtNE2ppAEBLtlXU0c
X-Gm-Gg: AYBFou3BhoYTBC6uYpthGsJzl0muj/soShUbsaqopcaTzdk+cupzaPQudKTSiDZVA1i
 L6nQcDWMlP66HWS1ZmZaA5XGCd6J98DM/nUcoC59k54wAM53hMw3Khxy31OmUqlYAtOU4nuUnIQ
 3UIrT0FYhl+jtsfVWD/3NiyVe18syJJ6fZFclcW/YNofjizz8wzKVp18ahitnFr8rabc2eSuTlJ
 LkmoFbrkJEIvVTUcfQYoswoXYNBXKdxfO0xVSsAxXbCk3R4ay1yxVH4Kik802oeUxZNdpZiwf+f
 R8FV0bc3HHhEkUvlbYD1RJHzg9gSS2kKIsMwjSXqK/3eJScWirWB6TPGD2SJEzMTQBVHGiRWiaa
 ENNGf3gDtT+rRcP+LxNb8Vg6EuTqV5S9DBtTqJg/JzXNpoadpfNxyO8/sg66CH+0DC2fDji/G+p
 24Drz8qC07H+mabNBeVR+uP/Mh6Yu58n3jYDCmIqvRRsuK/chPoxAvFp9j2DJ2GhQcuxbsqsI++
 Y7xavWrl30xXWKsR5N9pZvObfvR333y9Dhzsb9ed9TsWmXDXmRN3LBkv0P1Fg9f7WjUvQ==
X-Received: by 2002:a05:600c:3155:b0:4a2:1cc:6551 with SMTP id
 5b1f17b1804b1-4a35accc591mr91899325e9.35.1792948476454; 
 Sun, 25 Oct 2026 10:14:36 -0700 (PDT)
Received: from timur-max.localnet ([62.245.128.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a56992dsm126575185e9.6.2026.10.25.10.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:14:36 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: qchcio@gmail.com, amd-gfx@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 stable@vger.kernel.org, Brad Drury <drury.brad@gmail.com>
Subject: Re: [PATCH v2 1/3] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM
 at 0
Date: Sun, 25 Oct 2026 18:14:35 +0100
Message-ID: <oVwVffbwQ9mrJnRml_R8-Q@gmail.com>
In-Reply-To: <20261022073638.724414-1-drury.brad@gmail.com>
References: <20261015095713.20560-1-qchcio@gmail.com>
 <20261015095713.20560-2-qchcio@gmail.com>
 <20261022073638.724414-1-drury.brad@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026. okt=C3=B3ber 22., cs=C3=BCt=C3=B6rt=C3=B6k 9:36:38 k=C3=B6z=C3=A9p=
=2Deur=C3=B3pai t=C3=A9li id=C5=91 Brad Drury=20
wrote:
> One thing I noticed: on 2 of the 4 resumes, about a second after
> resume, vce_v1_0_stop() logged:
>=20
>   amdgpu 0000:01:00.0: VCE busy: VCE_STATUS=3D0x2, SRBM_STATUS2=3D0x80
>=20
> VCE encode worked straight afterwards, so it doesn't seem to break
> anything.

The following patch should fix that:
"drm/amdgpu/vce1: Fix checking whether VCE1 is idle"
https://lists.freedesktop.org/archives/amd-gfx/2026-October/154367.html

Best regards,
Timur



