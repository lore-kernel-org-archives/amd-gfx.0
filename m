Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368D9C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 13:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C2D610EDD9;
	Wed, 29 May 2024 13:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OPfGpurK";
	dkim-atps=neutral
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF87113915
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 11:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 sang-engineering.com; h=from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding; s=k1; bh=setKG9FGDtL/mG
 82WsX06rmtzy5NTTWcpcUdplSUhcc=; b=OPfGpurKNBji1cepO43EY2TXOKHYaR
 bmXQRx/Ac8ic5PCsnBCjeQYk3CcO6j94J0A2CogKuX+mMYvdYmUfAKP4cKQfj80m
 2A3XYVVEJxktTREcfrs4r3P1X1GXO0H2XW+2oVXaWweHJoSDg5KDCYc9MOwW4QMS
 COR2/g4oQSF/r/RXGeXjuCzX10D0c8JMkrn8ACRJIi2G7qWSnAkX2wA4c/aMP4VJ
 5oAWkcIxpO2cWg9rDFGYjd+doA9uanlYezo2pgU+OTyAltzBzNDc2xOU77+Yr7XE
 XmD5SJ/TFfeHFfT21i+FrAFT4oyVAjvqoV3tsh0MDOYnRd57UyZX8H1w==
Received: (qmail 558637 invoked from network); 29 May 2024 13:46:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 29 May 2024 13:46:28 +0200
X-UD-Smtp-Session: l3s3148p1@tDcGTZYZvLwgAwDPXwS5AFh1mWvQq9Po
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Evan Quan <quanliangl@hotmail.com>, amd-gfx@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: update email for Evan Quan
Date: Wed, 29 May 2024 13:46:03 +0200
Message-ID: <20240529114621.11795-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 May 2024 13:24:12 +0000
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

The old email address bounced. I found the newer one in recent git history,
update MAINTAINERS accordingly.

Cc: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Against v6.10-rc1. Still needs ack from Evan Quan

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..b2fd2a19277e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1092,7 +1092,7 @@ F:	Documentation/ABI/testing/sysfs-amd-pmf
 F:	drivers/platform/x86/amd/pmf/
 
 AMD POWERPLAY AND SWSMU
-M:	Evan Quan <evan.quan@amd.com>
+M:	Evan Quan <quanliangl@hotmail.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/agd5f/linux.git
-- 
2.43.0

