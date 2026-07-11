Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A65C4450D
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 15:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C7B10E4C5;
	Sun, 12 Jul 2026 15:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=murena.io header.i=@murena.io header.b="2lJg0bz7";
	dkim-atps=neutral
X-Greylist: delayed 469 seconds by postgrey-1.36 at gabe;
 Sat, 11 Jul 2026 19:43:03 UTC
Received: from mail3.ecloud.global (mail3.ecloud.global [135.181.139.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B86910E0A3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 19:43:02 +0000 (UTC)
Received: from authenticated-user (mail3.ecloud.global [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail3.ecloud.global (Postfix) with ESMTPSA id 994B6883824;
 Sat, 11 Jul 2026 19:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail3;
 t=1783798511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJ78cX5XhC2JGOtn0+rOIAZ6Qt08IpVtPC1zY7SfI3o=;
 b=2lJg0bz78nUSBHePrHSlMDhb2Z9iv+zrFvBV0qEtKoZeNvkpwfv5lzzA8mX8uhMC3o2AxF
 Xk8UPS8QJabfJYiQrjR9St2WFU+E/GiZ3R/dxMGekptYyIH/6HOP7fO04og8NVhJOclEB3
 Q5GyNPj0cVgPlDw71Y4U+qG8HSMwU/s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
 s=mail3; t=1783798511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJ78cX5XhC2JGOtn0+rOIAZ6Qt08IpVtPC1zY7SfI3o=;
 b=kWWI4e0tpln3TX7uPy/nctgHS64TM2QROzUARQYbiCZE+eYtc/XNWVZ1/TK3JWTO3ARrvm
 t4zOaXa0qvDjcfYfzgls7yu0FupGnxodSom/L/ci0EHAf+AR2X3b4oHCo0CwdfZJsQCJ7x
 HeR20LU+5bL3rDc34YfRXd0WI0bc+p0=
ARC-Authentication-Results: i=1; mail3.ecloud.global;
 auth=pass smtp.mailfrom=lionso@murena.io
ARC-Seal: i=1; s=mail3; d=murena.io; t=1783798511; a=rsa-sha256; cv=none;
 b=A2fc5yr+2syBcEqMvEu7oMqfEnB0Vnfuonrh7F2+Q1zIi/Rt9jjUeEfqIdOMzi0QW6WcID
 etqRafpnGavM3j7fkgMio0y/WPTrN1PMYMXaf3rpUqn2MrVABIYI9iWSNy+rb3WYvt1CWu
 oPyoHZA++J5T9hL+Pqy/L2PzagklngU=
From: Lionso Alejandro Pacheco Vacacela <lionso@murena.io>
To: Timur =?utf-8?q?Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Fix preferred link rate for NUTMEG
In-Reply-To: <20260529090909.13206-1-timur.kristof@gmail.com>
References: <20260529090909.13206-1-timur.kristof@gmail.com>
Date: Sat, 11 Jul 2026 14:35:07 -0500
Message-ID: <178379850751.8410.12007342378134020217@murena.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 12 Jul 2026 15:22:44 +0000
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

Hi,

I independently hit this regression on a desktop Kaveri system and can
confirm this patch fixes it:

  - AMD A10-7850K (Kaveri, DCE 8.1), MSI A68HM-E33, VGA monitor on the
    onboard output (NUTMEG DP-to-VGA bridge)
  - Debian kernel 7.1.3 (amdgpu.cik_support=1): VGA monitor receives no
    signal from KMS takeover on; dmesg shows
    "[drm] enabling link 2 failed: 15" (DC_FAIL_DP_LINK_TRAINING).
  - Applying just this patch (1/2) on top of v7.1.3 restores VGA output
    with DC enabled: the link trains, the CRTC comes up at 1360x768@60,
    and the fix survived three consecutive reboots.

Tested-by: Lionso Alejandro Pacheco Vacacela <lionso@murena.io>

Two notes:

1. The Fixes: tag references b74322eea36b, but that hash does not exist
   in mainline — it looks like an amd-staging-internal id. In Linus'
   tree the offending commit is:

     a62346043a89 ("drm/amd/display: Fix coding style issue")

   It would be good to correct this before the patch is pushed so the
   stable tooling can resolve the dependency.

2. Since the offending commit shipped in v7.1, could this be annotated
   Cc: stable@vger.kernel.org # 7.1.x (or nominated for 7.1.y once it
   lands in mainline)? Every Kaveri/Kabini/Mullins system with a VGA
   monitor loses display output on release kernels.

Thanks,
Lionso
