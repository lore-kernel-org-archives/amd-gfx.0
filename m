Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53E4CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 13:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3936710E883;
	Wed, 14 Oct 2026 13:40:55 +0000 (UTC)
Received: from mail.rostovtsev.org (mail.rostovtsev.org [69.164.217.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DA910E8A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rostovtsev.org;
 s=20250925; t=1791985247;
 bh=qpXKah35NhLVj75L1nqohjmeIYwlVziO8+90j15kR9I=;
 h=From:To:Cc:Subject:In-Reply-To:Date:From;
 b=cvB8hVwaKLK7JChIK8zWedIEwNW+kKOy4kdQ2xR07YE3HFVF2b/2fFoF3+bRwM1yj
 ohVSMjLz/64cJl3XKmRaLMiPgt4QyvgI8pApgukxGlTsUKfwdLkJ2UFAwqBdQldeAw
 veDiqsG1Etw/3bfYXLAMlHl6OwT2eBh1DcgCAEEIpE29rn3YuUY2bmCYZMzGPDdOX6
 ExZmD/jso6wZmfu2HZ2GE5m/ndSdTwjd0SnBpIAkZDEs2AUpk+nRCd/hAnU0a5o2F9
 jIpsg6zq1MmdfkA3vTxZ+0W0YWED0pZVPQrwyvwjq5svbe25g0gOayfhrn3iIdDtyY
 F5P3NoiwTr/PQ==
Received: by mail.rostovtsev.org (Postfix, from userid 1000)
 id D3BCC20209; Wed, 14 Oct 2026 13:40:47 +0000 (UTC)
From: dan@rostovtsev.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: Can xf86-video-amdgpu be used as a replacement for closed-source
 AMD firmware?
In-Reply-To: <CADnq5_OQK-z-H1z-=K84E6nrraiFbOyh9E2-KP0uE=jm1RNzUQ@mail.gmail.com>
 (message from Alex Deucher on Wed, 14 Oct 2026 08:50:19 -0400)
Date: Wed, 14 Oct 2026 09:40:44 -0400
Message-ID: <85jynk2yeb.fsf@rostovtsev.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Good to know, thanks!
