Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE08C44512
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 16:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934C410E524;
	Thu, 16 Jul 2026 16:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q6qnpq2I";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6B010E524
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 16:11:28 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-ca6a6181273so546535a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 09:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784218287; cv=none;
 d=google.com; s=arc-20260327;
 b=MCE426QOhpAd+CNL34CUGiBBUaAGVYMno4G6HndMbabP2reC8xersaSG/DgORZ0xFL
 9LlHMkokMJuq2QwSFQUur+DjVO0BpKrChft5Y5spVBEqzH3bcxrYC+YQc9EpDV4EwumP
 vWv4vHAtXikgFiiq6eIUtd+9R58IoIWjik2MSRO7rDzKWZLx9/IYr+E4Yh6wh83PzB8+
 udTs3L7d+5YKjrukIpsSJ9+fClNMAXI5cEap5wcAa3LsWUykBi922lq7PgnN+2nT1AHA
 5s4EJN7IkEwX80Egum6Vje0UYC4skXM5sWNdhtFsT7kzxshTurJX9c1fN5ljt/vEHlwT
 hB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jR1Y5r7I4M7vLOlnIqx8RnOmATrvV4sXGXCLpvOUAvE=;
 fh=o5uh0/ZziMmBX0jY1NrVc/wFowl4SecZsIjpyIS9ggo=;
 b=ReD8z7l1O5U4sycZBz3ocULpQGqW3wR1OFlEDUo5dXJY2K/OARx8dH6m7ePmiVwQhB
 keJtbou6IBdiwCop71tmx8Tx9jCh0og51Gzqn6iF9mPLRTthjV6wfbuMb64o1ls6lLSd
 7cmSae6ewiy+zQVu3do3+TrJgjpaGGg7WyvYK3xBQq3YVIxyrm9th0tmccjV71hvbF6o
 wPUUT3rt+FwEIVRoBOtOPvOaA+TUy8Dy/s8vuJbFlR5fGp3dtYRAG4keHLTKCiSoohrj
 eAWpyFwQDc7S6QspPYIfRevSX1GvuALSjLZdaH2a2DtUIzvzm7kxvtC4DCoXQeJ6p7Wr
 4paw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784218287; x=1784823087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jR1Y5r7I4M7vLOlnIqx8RnOmATrvV4sXGXCLpvOUAvE=;
 b=q6qnpq2IIumL7Ulxbo2SFWbjdXUWrpdbSwyxoAYjPwEVBGJsACbCTFaDt2H9OfUbWO
 Hn8064DkuQkI3L9op7OfkqBjtkeDSfR5RlAYCzTPPl5HjYDkS21aHbEPr9ZrzqsHadJs
 PPTQQZ4t07TUD92x6/HtZe6Ef6e8/CiWtiv9spCux+vT+irocugFebVZX6xy4GJut0TU
 NbHJOoZlw/kyp9C0Oh63kRR1hm8H9QNCZIEVyHVF91kUFkWF2vKDhrt2e5mZeqYx3IqQ
 x4MDhjkPnYWss6Aacqb7R+BPi2NVnpVna5XlFEbL3DykypQOZmOo/ulpQcd7PgMyU4VG
 U4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784218287; x=1784823087;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jR1Y5r7I4M7vLOlnIqx8RnOmATrvV4sXGXCLpvOUAvE=;
 b=QeiLZG4JevMsNX0+VNCSmPe1U1JmFJIRy3EfvgUVSZemG7enenZeI2ClX7BwjvzMrP
 EvEH1ISkIOU1OYu4cv1IGXD+pF4KR10UHj1kWme2PrO6uikSE9LekJOJA3zGrqV98RyV
 IfC30zgeMTjPYVirOerygfo6JRZ36Jbtcf4HkulKgfhRKAJIsK34tab2n6A1p17x4Pyx
 IdBn66CF7Uf8a68o/6B+NSYN/lobJD8JpQ38lkBPb055Zl8kc8RioItZGxyPAeM/DSy5
 OznJ6CeX2DrTV+O8HWmFXT4yvu10iItJ2d3ucpISZppP100V/K4K6/4k63Uc+H7rYQkN
 rm4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwfkVUzmvlgKHV1Ohk6PK8fCwhAo/euKfFmjtADD3Ylesm2b9l53+K4xea0iPQYHTnbTHKHuBY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/tBdzb56HJ71VbYtYASNsi4FQ/xRcltdu1/maFTy3hb5OjN0m
 90TyglruxawZvORr4Gh+O1Vta+g6llAl9DO8ReXqmB1ymy53xMrpBgQmwRfzqpRovk+dJe9v2l7
 JKsgeqHe1LSCwwTwPAqFov+8jLQFoYYg=
X-Gm-Gg: AfdE7cnWR0a61msiXx1VvMh94iOIedTQTIy4qstWhgTyEja3vlchfsR0D24HeXhDUQf
 od6hqJ09Df1LDoTHw4FsXJh2+uWZBcuNQ2o/lJS32FKDMFiWBwY02El2zD5lci7nQui04wUVpGG
 Jbxkv7Za+5fJHIoV7v95O4a02+YwZ5YTrkX8x0ULjIVbrrcHHu6Xv1L+6gOztAMNErcaPESZ0BT
 SQjiuytrNV8pat3/l3vibaU9NlA1iUK624UfuJEemzsOLuQf6pv2wTlzNezdrb/KEDyauv4eob6
 jhIsEXR2othFRhyXYC15q5cQKRwe3O1Z8ctCHiRKYa+xgO8A
X-Received: by 2002:a17:902:e5ce:b0:2ca:ecf6:9115 with SMTP id
 d9443c01a7336-2ce9e7a4c64mr180759065ad.2.1784218287438; Thu, 16 Jul 2026
 09:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jul 2026 12:11:14 -0400
X-Gm-Features: AUfX_mzTaIWsqWYnwhXx-_2z66JfKiWoX7LqHjFXrrawwHeR-BajknGjQHY4-II
Message-ID: <CADnq5_PFDW_ek=OU6BtL51J2xUPCD5+YWL1R4fkbh0xXCgVD8g@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] drm/amdgpu: Add WAIT_EVENT ioctl for render-node
 events
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jul 16, 2026 at 9:21=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This series introduces a render-node WAIT_EVENT ioctl for retrieving
> AMDGPU event records and associated metadata.
>
> WAIT_EVENT complements the EVENTFD notification interface. EVENTFD
> provides lightweight readiness notification, while WAIT_EVENT allows
> userspace to retrieve the corresponding event record and associated
> metadata.
>
> This series builds on the previously proposed render-node EVENTFD
> infrastructure and adds WAIT_EVENT support together with USERQ_EOP and
> QUEUE_RESET event producers.
>
> Changes since v11:
> - Use an unsigned absolute CLOCK_MONOTONIC deadline for WAIT_EVENT.
> - Preserve zero timeout semantics as an immediate check-and-return.
> - Remove the special handling for indefinite waits.
> - Improve kerneldoc for timeout handling and WAIT_EVENT manager
>   lifetime.
> - Clarify the existing teardown ordering that guarantees the embedded
>   WAIT_EVENT manager remains valid while USERQ producers are active.
> - Address review comments from Christian.
>
> Srinivasan Shanmugam (5):
>   drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata structures
>   drm/amdgpu: Add wait-event manager and per-file lifetime plumbing
>   drm/amdgpu: Remove queue-scoped WAIT_EVENT records on queue teardown
>   drm/amdgpu: Record USERQ_EOP WAIT_EVENT notifications
>   drm/amdgpu: Record QUEUE_RESET WAIT_EVENT notifications
>
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  35 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +
>  .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 490 ++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    | 101 ++++
>  include/uapi/drm/amdgpu_drm.h                 | 114 ++++
>  9 files changed, 751 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
>
> --
> 2.34.1
>
