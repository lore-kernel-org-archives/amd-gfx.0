Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CBCC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E136E110;
	Wed,  8 Dec 2021 03:16:43 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2684E6E176
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 01:32:47 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J7zyj5PQszF3Ky;
 Tue,  7 Dec 2021 17:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1638926781; bh=A+fOJQselGf0RleybLU2lsXF40RrwLD4hRed4Gb3FXg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C7v4xVuvF32K+qVdfv6fplUUS0invMv4iz0HkPBMf48gk6PQkuZUGWPT26cAb3iVc
 CbjIJ4rrWR6S5iKDyH8ggSlsHDc1JC20FKF+igO+9V6stXhi+eCY8U25oxtEkmDuNG
 8AWzWNsnW8Fefsbrp/0hAqLuCeXzxRKu6Ty9ulFk=
X-Riseup-User-ID: 809FF48AC1D7FBDEC4BDE7B2A2B149F7F2A316583DCD5E737DBCA8D10FC57A9C
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4J7zyg30DKz5vkY;
 Tue,  7 Dec 2021 17:26:19 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH 01/10] drm/amd: Mark IP_BASE definition as __maybe_unused
Date: Tue,  7 Dec 2021 22:25:20 -0300
Message-Id: <20211208012529.372478-2-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-1-isabbasso@riseup.net>
References: <20211208012529.372478-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Dec 2021 03:16:41 +0000
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Silences 166 compile-time warnings like:

 warning: 'UVD0_BASE' defined but not used [-Wunused-const-variable=]
 129 | static const struct IP_BASE UVD0_BASE ={ { { { 0x00007800, 0x00007E00, 0, 0, 0 } },
     |                             ^~~~~~~~~
 warning: 'UMC0_BASE' defined but not used [-Wunused-const-variable=]
 123 | static const struct IP_BASE UMC0_BASE ={ { { { 0x00014000, 0, 0, 0, 0 } },
     |                             ^~~~~~~~~

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h | 10 +++++-----
 drivers/gpu/drm/amd/include/yellow_carp_offset.h       |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h b/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
index 9cb5f3631c60..ce79e5de8ce3 100644
--- a/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
@@ -25,15 +25,15 @@
 #define MAX_SEGMENT                                        5
 
 
-struct IP_BASE_INSTANCE 
+struct IP_BASE_INSTANCE
 {
     unsigned int segment[MAX_SEGMENT];
-};
- 
-struct IP_BASE 
+} __maybe_unused;
+
+struct IP_BASE
 {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ATHUB_BASE            ={ { { { 0x00000C00, 0, 0, 0, 0 } },
diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
index 76b9eb3f441d..28a56b56bcaf 100644
--- a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
+++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
@@ -9,12 +9,12 @@
 struct IP_BASE_INSTANCE
 {
     unsigned int segment[MAX_SEGMENT];
-};
+} __maybe_unused;
 
 struct IP_BASE
 {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ACP_BASE = { { { { 0x02403800, 0x00480000, 0, 0, 0, 0 } },
-- 
2.34.1

