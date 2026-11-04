Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADD1606D831
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tKrEvJFP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA15F10E8B4;
	Wed,  4 Nov 2026 18:59:14 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5774D10FCA5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 18:59:09 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-7cc2b6b0237so48607137.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 10:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793818748; cv=none;
 d=google.com; s=arc-20260327;
 b=EzQVObCFz45p/qkzEAAA9OQVcnC2rNlrgUPCGTlHoPzUQpJ8mpvgGDvC/hn/X7r7xM
 yDMWomY3J/TLf0g8gDHFCGLwCVpaRNMWO71hFK6/q2SH3h3a3AnQTUf7NO1RFTNCZzEA
 d9uIZ5A72amnPY+zxj0nzdqd6VVWy4JhTNr7qzKDcP/QM/cXK71wi987kv+ettuX/emZ
 bbaXi8tWRQ9FRUQzsyRFzdhzcL5ND0qoSCeFXLEpTXGiSjY+jeVEE10SCmD1D+FCG6YU
 TS34P82J/a0YU+bpgWdYmrQ9E3Zqxpd14PFj3yPmW43ydsK6r8RIUpTuKlrk7UpdcyB2
 Zqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2pBMHDHkZsLX+B/NKfcm43crboq8aloqZf+8x7l5o/Y=;
 fh=g53YyxbtHtQ1FtEBdBj8r+DYdPJVgsRhFfM6Qx2n5B8=;
 b=ih6YVX1CslzTsCtYlghReSgN8gh561YPTtV8wjIRxrwiNcUtB9fAYww9KLVImX61be
 Inuep6dasnaJmRRmFWND7IT7797dg8bMHXmlu52E3O40p7aFfFRKkc48M0bKjwLXTuK6
 a5vSLBxh/PMlTOWB4wKoYrH2tVRd/d1AInEC5ck2MtCIPcmgSeRStnxXm0APsSqnZF0c
 9VNAbS0HhGn1RKmh5Du5nlTpUNTgQN7N1zoN9YGz9B6lV9uUhS2sZYK+cwNEzPov2cdu
 Ba9Hc410kKpl/sqTJo4sGjccS+New7LYIdV6K5O/2zb4g8hRoK5yZdLfJk+9/k2QYsgP
 FTng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793818748; x=1794423548; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2pBMHDHkZsLX+B/NKfcm43crboq8aloqZf+8x7l5o/Y=;
 b=tKrEvJFPwRr6csy3CKdrr1pJXhBGMlBLlIRCzQdBK2MQ4+l03LeDGUnk5YWav280t2
 ySL/QM5diI0DAeweQ4o5Pq4Wl3iwMcWfJ6BUqk/OmQLbXL1KC99wrz6dCY0vY2KheMb0
 rcI6w7MvIT7fqTFmPyNQ8goQ3s+KRJOsxr1y0r3QLqfubxS3pZOVBfSC6UkHObkCiEpB
 TCs9cBGuvxTxjE6gTl4X1EVjfrtpYWi9RJwivG0vtbnr20BW3Mf8w07jTyMcY6/sFFcg
 T+zn9IlbAXYSW/WQZGFPgtRibnioh+axTw4QsrTjlhhbkcCpSQ67V8oAehzkHx2IGJKW
 LQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793818748; x=1794423548;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2pBMHDHkZsLX+B/NKfcm43crboq8aloqZf+8x7l5o/Y=;
 b=1o1HzmxFMk0hm986qNnHXIs2KuTpvtOQeNVqd+zaoMfLdp9D+TSjp9v9ybW5WUsQs+
 WATp4QmLK+wp+Nv4cj0IVfoOegU0zsM/l7YJHcJIvjnMMeRt8O6WvpgKp3yfo16VrynR
 Jpwt/sfDo8qVLWcQTDvjY7l9gVz1+NwDnRmVRbFPktDednQinDqj6l/leAGkM9UoaRGs
 kjOxpeDDu5nN1fYI5d8iBh9CTGyJ5+7ihuDOaCx+ia/qBn3qrH2ypEDgZUPGmOg81D1A
 EsYYnHxaP6EBibwmoeFo0C5etWe18INuLnI8asMjm1F4cR8U82UKgtt2u7vO9dz+W9Pe
 Cdaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzM4WzwlWww6Gafj2+seveQ+/yBwON7mjjASGNaIY6Qn6WZCFggb4MiqNAyJ2d2ulMMUGuVWLJD@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ynamVx2GVM6XpzDiPaRV9WNVy7iNWxaE06dRdwbz9iFAzVEW+
 kLS0gW8RJpzx3wygSh7JuzSqJxY5VO29KtzYrVQwXdn6hx+4siLEUpibkh+jAkPP++IgL2tJtCu
 rq7KfmooS0l5MiWtEkUD1PAUQthBSLAA=
X-Gm-Gg: AYBFou19y7gilFbvaUBGB1hcYpAxMBSfqSqcL9o8UHBw+jBBua40rpTk1u/eSADBvHV
 GjsW2t21q3uIfAzhF8DVtmAt7zAtxJ15jsjlodhPL0GP0JcSxUF+kw+HH4KVaB4FS2rBc7qjd/h
 /17l3W3Dhymfd60URgNa3iZNv1y2yZ1xpsElcyANPPDR0a6mHx8E363MSlyLNImLx/8kh1Y6aF1
 WxdH8KWLDfRoo4MHqL76gtRpRySy/ET/5tU4reJIfEo7bz9AKnzn5eTQMa7HPlAHEKd82ww7t3g
 glpij6yg8YOjNzb6+ftXWiwoSt6JTl8FUQVTU/SdLFBjlaYo3eucSRLhl+gXrzZizsKu03Pb02R
 N4GR255T6/Jrrc2dpEyR6h59iWnEfOeDVFxp5llQxadF+jTzlnMtopyrPfLTIy3nfpbP5u72RcI
 4pluP7yPcxM1VEwlIxjjCBkwRBs8QvZpSelPlaNYl5V+FB
X-Received: by 2002:a05:6102:8346:20b0:7cc:174b:f7b7 with SMTP id
 ada2fe7eead31-7d07239e743mr8692683137.0.1793818748168; Wed, 04 Nov 2026
 10:59:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Nov 2026 13:58:55 -0500
X-Gm-Features: AclHuK-jG89f-LaNwqBFzncJaUM8Iyl3vAea5ur5DYeBuZowc4Rx1fTfjbh6dCQ
Message-ID: <CADnq5_OkJf_YuM7X31fRQFOHNqaDLyg_WL346c1_GL3atQQkxg@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND 00/13] amdgpu: implement Performance Monitor
 Counter support
To: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com, Benjamin.Welton@amd.com,
 Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 2:31=E2=80=AFAM Zhu Lingshan <lingshan.zhu@amd.com>=
 wrote:
>
> (Add Benjamin's Reviewed-by tag and resend)
>
> This series implements PMC support for amdgpu. Including two parts:
> 1) PMC Enablement
> 2) Profiler Reservation
>
> The user space should take the reservation, then set PMC.
>
> Changes from v1:
> 1) remove per-IP set_mqd_perfcount, use init_mqd with modify =3D=3D true =
instead
> 2) squash amdgpu_userq_xa_find into the caller patch
> 3) keep CWSR registers when modify mqd for GFX12
> 4) minor improvements

The series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>
> Zhu Lingshan (13):
>   drm/amdgpu: implement PMC ioctl framework
>   drm/amdgpu: add device-wide PMC config
>   drm/amdgpu: introduce PMC ioctl handler
>   drm/amdgpu: implement reservation mechanism for PMC
>   drm/amdgpu: set device-wide PMC enablement indicator
>   drm/amdgpu/gfx11: set mqd->perfcount from mqd_prop
>   drm/amdgpu/gfx12: set mqd->perfcount from mqd_prop
>   drm/amdgpu/gfx12.1: set mqd->perfcount from mqd_prop
>   drm/amdgpu/gfx11: set pmc_supported for GFX11 family
>   drm/amdgpu/gfx12: set pmc_supported for GFX12 family
>   drm/amdgpu/gfx12: keep CWSR registers when modify mqd
>   drm/amdgpu: implement device PMC handler
>   drm/amdgpu: set userq perf state before publish it
>
>  drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   9 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h      |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 183 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  38 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    | 164 ++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |   3 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       |   9 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       |   1 +
>  include/uapi/drm/amdgpu_drm.h                |  36 ++++
>  13 files changed, 451 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>
> --
> 2.53.0
>
