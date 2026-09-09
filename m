Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9F4C79FAD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 11:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187A810F0BC;
	Wed,  9 Sep 2026 11:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nk5toW9u";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9CE10F0C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 11:01:13 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5c7d65c83feso5377807e0c.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 04:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788951673; cv=none;
 d=google.com; s=arc-20260327;
 b=PmltqBkSl+jVJJPczXqtW/l6R/TbSNldBX4bRWwFTDUns9vaGYsqJcnDWpf0ENGoHz
 GWOC2XI39KlYxMv5Y1xPMBYgDsCloTMEcjeja46AiaNRhXYLlbdkJJv3h4PLbD6b4wuL
 oqZZy3D4o4mE33OPPUCokJ56AozkV+CzTFvb+4XU40VCA0S6S3ONl3DQKjvtgGGqJh1u
 7fsLYdnO4w/EkRwlb5KcLPIVvTOFo6WKCHRJ5HMgj0tGkDFo99ZQov7bMWVtLHr4qb6I
 6lIkiG5vUgIMrPY/JDPxYCM0eXyOamG430FgvRGcFWu6sxked0t3vikazyXeZza/9OdI
 w/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=g/39UEqT9toqCrCnxGHkgjqNAqJ77A/mKbtdKnBETRs=;
 fh=Em8y7IySts2JZUuR9e+GndfTIMWL67+qMa3MChsX2tY=;
 b=gpnL59gNMsjmWSt/te7zVw3HuwkN+cXFvTecptcql/0z0qRY3Pip62E0hovdwZ+BjZ
 Syfwl4PNI0Blllp1jEUsdaIFqnPFjKZ7m8LRfed7aKeLm+4Ja+aPXtJxQmyhkreutfEP
 PwuQ3l4wVi11Uie3v37f2yz1dYjVyo+JLb6JCc9M/MKsbmLQBrs58Aj6c9o+sOenxtEn
 XHB/DjWdKFBXsy1u4O6GMCgkjE8tjr4pP0i371jtDO0Hnf2L/4C0CNfqmpxOsqS/dImi
 pj9b7DxEkFxA9HLUuV3tZdFx6bX882HuAVOvhWXZG61PtG4+2J2/ZXlRRSxkOmcYK2Sc
 JU1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788951673; x=1789556473; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g/39UEqT9toqCrCnxGHkgjqNAqJ77A/mKbtdKnBETRs=;
 b=Nk5toW9uXUpLMo5geXNQKiQWFzOFKlM90DaoexbAjMRX4QGJLazYNGHyvF/BgKY6Ei
 XyXVuNFMYn18TToDNFFWzlAeCI0LOAgA7PSMBOlweHeJ9MLbVHtUaJd8rc4ImeuhEhdL
 XFBdeP+g9Y0kbTIw1Y9dvcZ6eQoUjsBOGvdp2gfZo/qzLjOi68oFUrBVwKTBwkDmS7y6
 0pxFwRy8QQeS82zqecZ9ykTndYHmh0Jco+JA2iwl161rJkKIc5UDOAcz9X6p01yqMy0L
 ld2iEktyoeOwNjp4ZNFcfKgSKmNt+YZBESwyd9+1zQCkc2ZXNmXOt01zm3/BDCYX5aaN
 vRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788951673; x=1789556473;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g/39UEqT9toqCrCnxGHkgjqNAqJ77A/mKbtdKnBETRs=;
 b=pKDOxE/jxFuQn/QiHu+y4MxZHxuo9BfN6RZY4nEFAJFxG7MIuR6XBZtgnjtnCyhu+V
 hQGANcpffpHW9PG6IBZYyQa6jglvMDP/4kVAwTuQacUqGC9ivakRdNZvccILdh8VadrI
 6uxF1SQuG4Gd3VLiCIufNaymbBdN3WPKXHpyYNV6U5VXrSpm7Btq4yKPNQR3RkHJqd7a
 rJwm0+nI7rxmzYJqOcn349qZYSwXhfpG2nHDgNep2+iN9rXxgxE6xcuczzOetbUrNrEY
 thAksrud0rc1cAiJrUP89nGcHrXn0vk9mbBTbL6pGGxntkbZS/+J6ZJg7cdbE4710lzl
 jzGw==
X-Gm-Message-State: AFuF++l7XCOjhW441kvCbsp+ObTpXvOB5T5H8fd1NMr+6I2ITYNhXarz
 18xwH5m4DJYhwxK9fzexSvHaLy7m45ID8+YezT/Ybr5ucyqY4XP9xCaJVASQHMePYYuYFjuRLxl
 6AaMxkx+S8HBmUz/GIuMLqIo/Q5FtBtWfZYSdba0xJg==
X-Gm-Gg: AYBFou2R6AVhZiQhUxtAIiaPeeXpJ2Y/W03Crdu5pPHEZAdk2yz0bPA8X1hOaFfoPiM
 yAVDOdUhuQPDr7+ADCm/ad0rzVsV6qrRhehabTmRSLiCt8Y+IcdmH853Qv2We2b1U/ustsgQsr1
 Iz8ft+gcPiqZel3cn2K0CREkp3D12saRF67NgdqZLRfsDEOwjuPgo0j37V28r+LwM9hYY9w3zeN
 3AfGIoDux0vr6AtA3MuKv6QaRzfc3DD4pZEaJdV1TBZ5Ub1jZGfxtNmJU4zZLQZN8HTotnkZV4h
 9d7dI4DoH+4LJHndds4XrHY92Hn8jw6hYz8aYumemKJNS73HwA5Vslk338ZBXF7bZwW/iVYF5dX
 TSGYnx4uoEIQzRm7ZDjVXRYdkA7A8em7xUplbmZ4=
X-Received: by 2002:a05:6122:d90:b0:5c8:2c83:9cb with SMTP id
 71dfb90a1353d-5c82c830f80mr1746396e0c.2.1788951672620; Wed, 09 Sep 2026
 04:01:12 -0700 (PDT)
Received: from 313336824172 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:01:11 -0700
Received: from 313336824172 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 03:56:23 -0700
MIME-Version: 1.0
In-Reply-To: <20260823120039.A7B3B1F000E9@smtp.kernel.org>
References: <20260823120039.A7B3B1F000E9@smtp.kernel.org>
From: Julien Le Bourg <julien.lebourg8@gmail.com>
Date: Wed, 9 Sep 2026 04:01:11 -0700
X-Gm-Features: AcwNN1XvXL1SjFRBtFvxbHrfryC6LwXZDTu3lMkv6bOZrarcI4At3uMGcycC3NQ
Message-ID: <CAAK4M4VkRxnG9eYZWSiwqBKCMeWbF6XCGxekZLc-+8gt_R4hVw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Restore self-refresh fallback in
 DCN21 bandwidth validation
To: amd-gfx@lists.freedesktop.org
Cc: sashiko-bot@kernel.org, Wayne.Lin@amd.com, nicholas.kazlauskas@amd.com, 
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Aug 23, 2026 at 12:00:39PM +0000, sashiko-bot@kernel.org wrote:
> This isn't a bug introduced by this patch, but since the stutter latency
> leak is explicitly left unpatched for DCN 3.01, will it remain vulnerable
> to MPO flip_done timeouts?

Yes. dcn301_fpu.c has the same calculate_wm_set_for_vlevel() helper and
only restores dram_clock_change_latency_us. DCN 3.01 also still calls
dcn30_internal_validate_bw() with allow_self_refresh_only true, and
watermarks run only for DC_VALIDATE_MODE_AND_PROGRAMMING, so the check
vs commit_tail mismatch is the same shape as on DCN 2.1.

I left it out of this patch on purpose: this is the DCN 2.1 regression
(360 Hz eDP dropped after b96150a70696), I have no DCN 3.01 hardware,
and I would rather not touch Van Gogh watermarks untested. Happy to
send a follow-up if someone with DCN 3.01 can try it.

v2 is otherwise unchanged. 1920x1080@360 is in daily use here on
Cezanne with this applied. A human look would be very welcome.

Thanks,
Julien
