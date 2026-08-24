Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0CCC5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 18:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A3910E7E0;
	Mon, 24 Aug 2026 18:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H5WggGcj";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3772E10E585
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 18:31:46 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cb2513ec378so269623a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 11:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787596306; cv=none;
 d=google.com; s=arc-20260327;
 b=Eqy3iRP6+c9EeYxrmXd7cehSB4waqxxYey9cgV268d5xZcuDZdtApo+zF6ZQ5RbTQt
 /gNo75TJHpO/GRL1lQ053JQXpTau5aYcEbAHsnha4QMRUnoB1McV+DWZ8F9wz71J4iAB
 SSVJYBjdayGcLpBMiPJwZ3TsKsUp9+iJCJP789kfhAfYmmIDlauNYtoMQ15rAeT+cPd1
 9ZNNy7k6kjoMgTHd+Do3cYdAeVqZGVbpaInut5AQjDADaCU+5fHTJRVPKWVh0kaKLXIW
 H098/75gi2rQ/p3vwVaxPKuNmA4WSYTRA+rLGbw4+SHfpwjqM9VxNB/mXePhhAwMsY1g
 /aYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vJtoyxpAuKAFerPlGSQxOgsaspj02cFCH/n6OuEN4+I=;
 fh=+HtJfrqdzjrp2YWDzHTzmQ3etLwu7LlEjZ2EqLXECpc=;
 b=NXU7Ch5hWaTQv0XBvWHioNv/x9MZdURTNIkXp2nIZgkPcl7UQ3Gb2JUwHhHuUrABdI
 S9PmPfjgsZrxCPWb8IyFrTN9dGxf8xp0lKKo0xo0VBZE8HWQZ4X2AG0zfftG1k6TmRtt
 q6mnhobA6gNDYLpL7Gn1J92fTwUXg2ew5Moml+36JG0QbHbMVLBkEvzyi5mONntbxH1F
 93qN1TCcl0FWHPZmID3pV80o4KGirtgMvizyownWEPZMN5eMTyh7MjeqY0XKooIrcTFc
 EPXhA5hoi+jNfCO3iv1ImUdFHXOirtqqAjW4oouozI2OVVCCtdiF37wyZJU2yd3PqkUK
 qgYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787596306; x=1788201106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vJtoyxpAuKAFerPlGSQxOgsaspj02cFCH/n6OuEN4+I=;
 b=H5WggGcjFVfRvT5zh344lOA+bNJcVyvjZFVqr5o6ZlJGW3AsrXtDovba+RyyxmFY89
 0Zv5NCvdauE2ehUXzHP3G5eojgkBK+3/QRxk6T/BR/w6qnAWJXU7ka4yn9FQU+VWW+uL
 +2iJXFxDYu9iSEJq/btRdwnJpPDPVRmlOrutrAg3v64NOoCfUgbxEaOWU1A+qC2TGZdL
 g5fPlIJIhp9Z8sBKy/aAuu8Qn4ZnOX7hozrCGp3AjKXGI3Vv5Fy26tyQdFarK0VeSms/
 uFrM8wpKyBl2MaDbgUGrWRqLPwxUgMbAEGS4oo8AYlXdxl27SoLUVVs/aS+dhRewThTM
 JZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787596306; x=1788201106;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vJtoyxpAuKAFerPlGSQxOgsaspj02cFCH/n6OuEN4+I=;
 b=QOQPl757QN/q2uAbigCv99O30a+GOwPfB+gej8VkKYIwnpTdIHLQzmLGfDcqYLaYWd
 QrSpGeaFu5qkNBe17bN17MAfQz0AetfaUWZ9rxj4xuv8c/nSDXKLBbOjxS7q4sU6O3ml
 yUSwYyOktOxjb63SdqD4lRPRRx0+4vZT2bOKr7X1WFJwpLu+rtdWkQGR82F+2xc6lluE
 4a9oe0BUiasC2CCRscVJg/nuHe8I0ygg3kkNLN4fdUs9le1zkYJ9VU8vps68f2FutZ0k
 cz3ME72epKvd/gMIV3itwRkiSvBmHShpZDm3QN4RSnt1BC4L7cUK6JkQxebLcu5007lH
 xqRA==
X-Gm-Message-State: AFuF++m7AY32aINQ3mWWyeuQSGggoEzMbA4BAWJb1BNMp3pxO4YZxPdO
 FNDr9tPlhyeJThDzzHb/KZayV2FmRr2G64clW2t0hpAFKnSFvolss0MV/VN636EZ4NKesDv9KR5
 dX+XQeaQ4+HOKFtNfUBKgc6stGeffXsI=
X-Gm-Gg: AR+sD13xMPENIVOAnB0FzD4DIGMIff5ZshU9bzK7JdKwrrArgPftlp2DbNa/DT/cUA4
 ZkxGaxMD+1dEp3wrVmkuQBQSNUUqsIOj1AYO7v/ieJonvajkmAMhfYAHNFJoUfZ+6g4a1g7wJQh
 5I45nNePh2unK7NEps+zHs3J1u9roN3oqo1Mv9oKZpXTovceeLbSY/y0YLa5saleDzOImTogn45
 bwik26J6gdb7RYv9js9Ain9KsLONjq7wbnm6O6y4kCZEMlDSw0TKMVLyCCTDYvBECcY9kWZbrmn
 BIjczCD1oqMRmvPAyOrgs+3c6rUZagMFipHcK89d5NiSyGMql332NJYub0StaIPT/uKqIwZmGD4
 iEalhUf70gYlDtHzvU8ETgtdVWXSbtQE22swbuuphrA==
X-Received: by 2002:a17:90b:1642:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-395c33b86bcmr22444305a91.1.1787596305560; Mon, 24 Aug 2026
 11:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260819185349.29407-1-pisarevden@gmail.com>
 <20260824153542.491012-1-pisarevden@gmail.com>
In-Reply-To: <20260824153542.491012-1-pisarevden@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Aug 2026 14:31:33 -0400
X-Gm-Features: AcwNN1UPHsH6u8MQ3-dz-R7n3llHB8rXojPRmivVrINOZe7FEthOUqaTO0ipPmQ
Message-ID: <CADnq5_MEb72btY3NtbEVgZm=H_7OV6k1xC_t5YXVM_ONrZ2b3A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/1] drm/amdgpu: MMIO TLB invalidation fallback
 when KIQ is wedged after S4 resume
To: Denis Pisarev <pisarevden@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, mario.limonciello@amd.com, ionut_n2001@yahoo.com, 
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

On Mon, Aug 24, 2026 at 12:30=E2=80=AFPM Denis Pisarev <pisarevden@gmail.co=
m> wrote:
>
> Hi,
>
> v3 addresses the two findings from the sashiko-bot review of v2.
> Failure data and trigger isolation are unchanged (bugzilla 219492):
> S4 resume on Cezanne (gmc_v9, GFXOFF) wedges KIQ TLB flushes at
> 80-140/hour for 9+ hours with sched.ready true throughout; holding
> GFXOFF off across the S4 cycle produces zero errors.
>
> 1. [High] "VFs and interrupt contexts silently drop TLB flushes once
>    the threshold is reached" - correct, and fixed. In v3 the latch
>    only reroutes bare metal process context to MMIO. VFs and IRQ
>    contexts keep submitting to KIQ exactly as before this patch, with
>    per-failure logging, because they have no MMIO alternative; there
>    is no longer any code path that drops a flush without attempting
>    and logging.
>
> 2. [High] "KIQ and MMIO race on the same invalidation engine if KIQ
>    recovers" - this remains the documented open question; no code
>    change in v3. Our analysis: once latched, this path submits no new
>    KIQ commands, so the exposure is limited to already-queued stale
>    commands and the recovery transition window. The engine serializes
>    requests internally, so the realistic worst case is a lost flush
>    request caught by the existing ACK timeout ("Timeout waiting for VM
>    flush ACK!"), not silent state corruption. If maintainers consider
>    a fence necessary (or a dedicated invalidate engine for the MMIO
>    path), guidance on the preferred mechanism would be welcome.
>
> Full patch history: v1 (initial fallback+counter), v2 (GFXOFF hold,
> per-instance counter, irqsave, VF/IRQ restrictions, MES error
> propagation) - all from bot review; v3 (this one) fixes the VF/IRQ
> drop regression the bot found in v2.
>
> Also still open from the cover letters: the alternative direction of
> fixing the S4 resume ordering itself (RLC/ME vs GFXOFF) instead of a
> runtime fallback. Happy to run tracing on the affected hardware.
>

If that's a problem, that should be fixed.  That said, did you have
any success with the branch I proposed?

Alex

> Patch 1/1 follows.
>
> Denis Pisarev
>
> Denis Pisarev (1):
>   drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
>     unresponsive
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  18 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 123 +++++++++++++++++++-----
>  5 files changed, 114 insertions(+), 33 deletions(-)
>
> --
> 2.55.0
>
