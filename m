Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E432C79FBF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 13:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B639810F14B;
	Wed,  9 Sep 2026 13:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XTCV+r5S";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1061310EFA3
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 08:05:34 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396672b2565so1088696a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 01:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788941133; cv=none;
 d=google.com; s=arc-20260327;
 b=AmnUJLXDRTCb9voxNtEhnF1D1nEMk8RM08OGLj7hhwdDJbXG7Q9JRa6bN9PTFfRKTB
 iSdFPYGxgf3YMWLXm5MEwWZwErZrCLN0frIiPlA5FyYqrR7rHp9r8NZhUxpa06/9KxKO
 i9H6jooCoAyP+P7tgC5ba8PpZUE1bU9g02dCS2xGAmC6bnZZbVF89OFOqYuMqxjiTQF5
 JxavDcvMp+oTCvjyKoq+OvCCOq0hWoZcyU2gMTVQMADL3oNfhm8QNKLXjLm23p//haUZ
 QkxAeNS7N7adCPyHHpVh90k55joVuOFoNp2zQub+z+PZb7w02318Lq3rSe1yxX6F1qKe
 tXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PFzJhTwC5v2xxJH8grG7O2UX6Uz5UZc0kMv7qk7w9wE=;
 fh=/fz2v4l0iSUevEW7LlOsd0bt23fg+14gcg8LxdhkQL4=;
 b=fwbsiC0BEiQSSWueHnBgh1BHE1CnEpgLoZGq5VtnUtXnfH8sriQnc83wyS0gj48MyZ
 AgoJlOArlXTt11r+xkgSCaqJaTl5lxvpm0DNYSIlXGRxbTlBt1Ygnsztx461cwO3jFlU
 +oVohTjrn9vqE5kdkPws90RIw/ITgJd9wBDbrtwXoj0CKiVOEdUDHYw6YPjPzBJM7C71
 ImXTdytIDG4rp5zaf6rZADuqWQNMP6HCDFfASckzWTmFzL5o1DLes2vp4hwllIkNuDza
 zgtHybSPBlyaKwl9rd8+wUGdJgiP6LUBcBnnjhaTO2yOu1bg4tBoqsE7FSx4EQwyDvAC
 urTg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788941133; x=1789545933; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PFzJhTwC5v2xxJH8grG7O2UX6Uz5UZc0kMv7qk7w9wE=;
 b=XTCV+r5SFH0XdE4qfFcGVaOgX8sw9wXFdpvdyPYQrl5B+gHuKZicQNIaWdBymA6+3h
 unWi5iOcLCBgMhQxRTTf5krPV5g1X9Bli2SvccoUU/6USMom9t7ZVxGQmtfAJ2h84940
 HiWIKeMRrnam0K9HKO04byRLJJFNZspeCboiigCDrOGpUH8smerfClCymsKUKjrMzr3y
 sV2kYW/GvR6sgIOiizyIAuztmWYJ4SSZI3Q3aR3LG401mB7VkB3Wzs6H+LvjJfLthK4E
 6zGiaE+d19rBwpiKh1yEsev4NNPVzVuHPLZqIN7rFhZG+wZcUuHFe+upTowOPLaGP7Hz
 zjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788941133; x=1789545933;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PFzJhTwC5v2xxJH8grG7O2UX6Uz5UZc0kMv7qk7w9wE=;
 b=KdDHtlykLHKERFChDToDa5Wk4Za8ri+P3fN2SlEY94m4UAhxIyXBmR6GkZm+VRqp7X
 NTRWVjfJ92R/TzatY1XUszOtoNrNOgfzY6BW58ZGnzjeK/V45mMKVWQwedPXqOj6ZqjK
 GblIu02NVQJMXRMOPLZe8EE8J8AxRe6j7LWt/GwrfVAr9sVUYLQclxOAPfhE4YWK1CVQ
 NhMoNtwACp8LeKXEBMoFy0oMy9hRM+5nNijl8/zObmcbWgzlsregec0Zginhx4gUuzvg
 vDmG7V1s/3/IzRgYiMm1HM7vlTVO79iV0G74qUzmh+ZcjdzoqQXn+TDNrA0fh+MAnUr4
 1DwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzz+7d1diUs7hTdRmPb2D768iOJKu+BSavgDX1pFOtFebtysbyAncKg+L7hcRAaWWzToOryEcUJ@lists.freedesktop.org
X-Gm-Message-State: AFuF++nckpurLiTTTiZbxTR24Dcp6Azd9AulZAZUq1Vi+K0PxZLc+4WR
 juyvgI+cR1BneTWaZ3JLrJCuWJ1Rbvco7ZZ09UOqCxVeET+o7l1fqIok66b/bpKibA380500YAW
 n38smFv2ZENNTdy8OPoA5/gFoLucodGo=
X-Gm-Gg: AYBFou06P/aTCG6G0H4iwD0fK2R1l/atiy01vk78qbgujB+k0pb6O9P3wKO2nGF1VBF
 PkRYRf/1Xb19Df5acn7eUMkBduYGJLdK++wfPBsjMJy6PXJSj25YRtaWxyihk2vW4e80wpiskJV
 3oTrXjQ75DRRn1S8PHSd23T6Kf6qSwV9a5FOwTADX+XFM1Q04w9clc4x29xanTCNnfm/z/klwVQ
 mZ8JSnF1sKOGHCrNa6hFAtKJ8nIQ3mdHbbg3+0I/EF32ppENjmTsAUvlpZTgiEgaaasg3ZClxJy
 ArbrIJXud5mY2tLqDNbnjNjJAFN7fu3rI0DVCLKyWyir+awQEsvxIvarvkak72WeCcyWKZ8Pbi6
 2QWLKwYrdZ2FL2qgkzpL/qJQoyN3CuHvDu3EMY3fAXt3HNfE1fWLUXgqwMSs47EDjvkojE2UzPk
 56QMpy3M0ciR03t4xxcSL9hEvsYTS8XBPVFxnhR+aQjTYXHbX5B2I=
X-Received: by 2002:a17:90b:498c:b0:398:a2e4:c784 with SMTP id
 98e67ed59e1d1-39b3d5c4449mr23521825a91.1.1788941133232; Wed, 09 Sep 2026
 01:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260908175427.47207-1-klarasmodin@gmail.com>
 <2642740a-b894-47bd-b26e-cabdaa14d8b8@suse.de>
In-Reply-To: <2642740a-b894-47bd-b26e-cabdaa14d8b8@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 9 Sep 2026 10:05:20 +0200
X-Gm-Features: AcwNN1VaFSH3EyJDGBY_TKDiMWxaUjeqs441wwiCpqb3pVX1iCtXogyjN7rFa0g
Message-ID: <CANiq72ntt_2n03UReCt6zFD_AvTMvNE6O+v3E3sURTsqW6x4Ng@mail.gmail.com>
Subject: Re: [PATCH] rust/drm/gem: initialize callbacks with
 ..pin_init::zeroed()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Klara Modin <klarasmodin@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Thorsten Leemhuis <linux@leemhuis.info>, Manuel Ebner <manuelebner@mailbox.org>,
 Gary Guo <gary@garyguo.net>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 09 Sep 2026 13:00:09 +0000
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

On Wed, Sep 9, 2026 at 10:01=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Please see my bug report at [1].  This patch fixes half of it. I still ge=
t

I think fixing that is the respin that Klara meant in

  https://lore.kernel.org/rust-for-linux/aqBf1UYNR-Q3T-cs@soda.int.kasm.eu/

Cheers,
Miguel
