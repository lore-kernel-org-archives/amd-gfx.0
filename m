Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA049C369D3
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 09:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F1E10E359;
	Mon, 21 Apr 2025 09:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="YXx0Kgkj";
	dkim=pass (1024-bit key; secure) header.d=tnxip.de header.i=@tnxip.de header.b="QibqLAjq";
	dkim=pass (1024-bit key; secure) header.d=tnxip.de header.i=@tnxip.de header.b="LHikL5oW";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="rwzoNeL4";
	dkim-atps=neutral
X-Greylist: delayed 347 seconds by postgrey-1.36 at gabe;
 Sun, 20 Apr 2025 19:44:33 UTC
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC3B10E00D
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Apr 2025 19:44:33 +0000 (UTC)
Received: from gw.tnxip.de (unknown
 [IPv6:fdc7:1cc3:ec03:1:6878:2204:c74b:bf0d])
 by mail.tnxip.de (Postfix) with ESMTPS id 8FBB5208AD
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Apr 2025 21:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
 s=mail-vps-ed; t=1745177919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VIbjyIjJEN93mrlZtI4dXkBeej/gN+HDsNlizDzfgsg=;
 b=YXx0KgkjDMHITDMaH4hopkvPsqvhZgc1YErLBTaMKLWMjK+KrXrUCTMYdB9CBOUwh+IlCK
 BbcEl4WKt5cNKdAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps; 
 t=1745177919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VIbjyIjJEN93mrlZtI4dXkBeej/gN+HDsNlizDzfgsg=;
 b=QibqLAjqWpdz+XLICe376WXx/OotCl1uPHOK4kU4vYmFCo2LHtYC8h6vZgM07lgEjdbl1h
 pwtSvKGiD204ZtVFe5DAdTNFqrzZamHLzVw4yrjoo13xxs/cWkqXmR17J3adW/KWGia5JZ
 qhqx+vENmetqeAuqRBPu1Kjb5Q8iIw8=
Received: from [IPV6:2a04:4540:8c0d:500:5c42:8296:e6ef:fe7a] (unknown
 [IPv6:2a04:4540:8c0d:500:5c42:8296:e6ef:fe7a])
 by gw.tnxip.de (Postfix) with ESMTPSA id 606805800000000001982
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Apr 2025 21:38:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
 t=1745177919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VIbjyIjJEN93mrlZtI4dXkBeej/gN+HDsNlizDzfgsg=;
 b=LHikL5oW1TZYFxsFkL4IegYYWYgy2V73ILC0WJy/2euhTszZZsDpdPRRKVkvC2oGJx8gsu
 dxqyVadPw+BzR6DYjNWDGz1/s1B9wdA6a0Xt4DbpCYhmS2SvsgDdeRQPYhhVeolb64veaY
 mCiIkzO/GZ4jryh5UtLLgOqbAyiGof0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
 s=mail-gw-ed; t=1745177919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VIbjyIjJEN93mrlZtI4dXkBeej/gN+HDsNlizDzfgsg=;
 b=rwzoNeL4V4LyNoiUh3ji6OHyNtfWexYWgJFFzNmRRkcBhKq0AUnoQXHQ3ZkvNtn39MQyYd
 tFL6Gayj0ZFT7NDg==
Message-ID: <63d93ed2-1ace-430f-980d-27199ffc5b3e@tnxip.de>
Date: Sun, 20 Apr 2025 21:38:36 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: en-US, de-DE
To: amd-gfx@lists.freedesktop.org
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
Subject: possible bug with RDNA4 and AMS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Apr 2025 09:34:38 +0000
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

finally found this list, I hope it's the right place for this. I
recently swapped my trusty RX 6900 XT with a shiny new RX 9070 XT (aka
RDNA2 to 4). Now, when I start kwin_wayland my desktop is a flickering
mess. As a workaround I can set KWIN_DRM_NO_AMS, it is working with
this. Afaik this disables the use of atomic mode setting. So I guess
there is a bug in either amdgpu kernel side, libdrm or mesa.

Versions are kernel 6.15-rc2 + drm-fixes-6.15, libdrm is from git
(2.4.124 fdf384d4), mesa is 25.1-rc and kwin is 6.3.4.

I am happy to provide debug, but I need some guidance to it.


Regards

Malte

