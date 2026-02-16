Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE863E81A3A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC1010E3AB;
	Mon, 16 Feb 2026 15:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k2iCE4Bu";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D2110E3A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:19:10 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso39572115e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 07:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771255149; x=1771859949; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=51JcnekwqebbaSED4b3NvK+5WOLeiVoorNL/sf7mMXE=;
 b=k2iCE4Buu/jMhaAN3/nS1PacD2Bqkc12PJSFk1JWedCybJ71dv4YW05i+1FpLGgC3X
 ifiibKWFp4vp6sOSkmXVPhse6nBqrz1TJxYvSAE7KOP/X7fWXuuagRTE77XOPmJpIqjs
 4PrkzZX3v4R9V317U+B2WU4clmc6nQ27vZOYEpnTzltWx8Lc0ffsR7mlazqEve/RGSal
 CSKQthJ80MY9Bpkr6a0Pi6iraVKjiAK1HQqWcCz0gfQNbIcjbV1NjN7DPdmS+/YP+Bud
 u5jxJn6Cmnwx8+8dlC57TCxg7ET0SLspBOsQ8JTOvIthRXtGamxZ9eCFSOi2Bi+J6iWw
 OOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771255149; x=1771859949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=51JcnekwqebbaSED4b3NvK+5WOLeiVoorNL/sf7mMXE=;
 b=ctKT5inSuFgFynbnm0Ugx083oTCjrTO5NY8QrbrV+LGEXZMW5OXpf0bw4ChG8hiFvf
 gXWWkM2+3h8u4wx61m3UucVmC8/DfHCtdItZNtS4MyJCOeYv4USZZ7lR/LmwwT08AQzu
 YzwztxJ1F60iCKUTlnvnVj5r0s0cyMFDIMXXD9vvI0nrN/BhfsH5IrKLUkNOpPliVYBa
 fp0Ft6keHROzMkHPUvx4nBXMQyjznmkUfrPU7VnrPZc9zMaZEcu26gKFIVwCqhomejUy
 Hs5zU1xUAvxcaETypjYIeLhJu4eXPp+svkBA6IMEZ7mqunKOr7LEMUYFFWkJ+H42vUIW
 Pm2g==
X-Gm-Message-State: AOJu0YyuYpE1nQH3DJafbEjTGJWwu8gN/wIBMAArFUWysK9Kr3KKThlK
 3GBHhcG0o9Q2llD7NgQWG42HKuXJPM93/8NN6pSJBWuGaYJRm8BgppteOW6rXA==
X-Gm-Gg: AZuq6aLAaa/YqjQLgFfurzp3XGoVRCasC7GXZ8RVn6s5q9rcajcqWUhfh2X8T3Vxd54
 j6sV5xWCEl72q6EEv2z2+3hS+r3Mwk673hKnFlwxPTgFcguDJyCqMdyTJadbj/DRkVUCuoHX33P
 Uw8v4QUDU6rncUlzeReJ0HfR6oQ2ExC2UllpLPrfAkoQFzJLW9uJvv+gmbG48k2ZLjQTNL1jUVO
 qz1LmwYALUpmaaEIaSyfO/7DnkIvOkuEvX1rkVeddbCN42wVE7XrcLCgzXX76IirAnGcJs+np15
 hNR37lx8Lruw7Xb1hKI2JerGA4ONmw+f3ZBvGnocCi5oT03xw33wU3eURClhiK0lpjJofcTqEMV
 VVfz3txzxWnj5T77V033WnnegkJEDaX6D402XCnduivD/BzmTkNJrEWKHjVJ5j+ApZ2kZ5jat/w
 pSizcMQ2UUTviGy+Vu4KnOe/U4YiIfHVPoqM5t0EFkFjgfi7GgOpvorLBzu4gbYNiJocXZmwLaB
 G16xO8b2JTpMzXR5RN9Vk9/hLzv
X-Received: by 2002:a05:600c:4eca:b0:47e:e87f:4bba with SMTP id
 5b1f17b1804b1-48379bfc3bamr136657125e9.29.1771255149213; 
 Mon, 16 Feb 2026 07:19:09 -0800 (PST)
Received: from timur-max.localnet
 (20014C4E24C3010030B5FA8521127642.dsl.pool.telekom.hu.
 [2001:4c4e:24c3:100:30b5:fa85:2112:7642])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm248535045e9.15.2026.02.16.07.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 07:19:08 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: Re: [PATCH 4/5] drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
Date: Mon, 16 Feb 2026 16:19:07 +0100
Message-ID: <3689606.dWV9SEqChM@timur-max>
In-Reply-To: <376e868d-8962-416f-bdd9-a1eaf1094cc3@amd.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <2869796.vuYhMxLoTh@timur-hyperion>
 <376e868d-8962-416f-bdd9-a1eaf1094cc3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. febru=C3=A1r 15., vas=C3=A1rnap 6:06:33 k=C3=B6z=C3=A9p-eur=C3=B3p=
ai t=C3=A9li id=C5=91 Alex Hung wrote:
> On 2/9/26 15:11, Timur Krist=C3=B3f wrote:
> > On Monday, February 9, 2026 6:21:38=E2=80=AFPM Central European Standar=
d Time Alex
> >=20
> > Hung wrote:
> >> Hi Timur,
> >>=20
> >> I just found this patch won't build unless that CONFIG_DRM_AMD_DC_SI is
> >> not set, or with the following change to Makefile. Can you check?
> >=20
> > Hi Alex,
> >=20
> > I didn't see any problem when I submitted the patch, but it's possible
> > that I overlooked something. I will fix it in the second version.
> >=20
> > Thanks,
> > Timur
>=20
> I can fix them them manually.
>=20
> This series is Reviewed-by: Alex Hung <alex.hung@amd.com>

Thank you Alex.

I will send a second version of this series where I fix this and the other=
=20
feedback that I received.

Timur


