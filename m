Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAB9C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 09:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5420310E5D2;
	Tue, 25 Feb 2025 09:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="KDSdgppN";
	dkim-atps=neutral
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com
 [51.81.35.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 662A810E5D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 09:10:53 +0000 (UTC)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
 by relay-us1.mymailcheap.com (Postfix) with ESMTPS id A15CE200C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 09:10:52 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
 by relay5.mymailcheap.com (Postfix) with ESMTPS id B7CF9200C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 09:10:47 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 7F61B3E953;
 Tue, 25 Feb 2025 09:10:31 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 by nf1.mymailcheap.com (Postfix) with ESMTPSA id C6CDE4023E;
 Tue, 25 Feb 2025 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1740474629; bh=BlPAHvfr56Xzs9kzXIbb24Tm1e3gCNoKq24dLNBdikQ=;
 h=From:To:Cc:Subject:Date:From;
 b=KDSdgppNJPIVOGi+X/GxDP54gHTHeCy2vCN/vqoWGDjN8w9uZEtxQvUOiG+NQjT6b
 d7Oi4vd6APdQ4di+yugiZlSf1rak+fpr8y7rfxs/vWi+YX7uwBGXdNdq0A2n5lErRZ
 7cKGckwc0yWQuo/ipRwXFFhMPm3N3HCeAZl3Cw9I=
Received: from JellyNote.localdomain (unknown [203.175.14.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9656F438AF;
 Tue, 25 Feb 2025 09:10:26 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Kexy Biscuit <kexybiscuit@aosc.io>, Mingcong Bai <jeffbai@aosc.io>
Subject: [PATCH] MAINTAINERS: remove undeliverable entries in RADEON and
 AMDGPU DRM DRIVERS
Date: Tue, 25 Feb 2025 17:10:03 +0800
Message-ID: <20250225091003.890770-1-jeffbai@aosc.io>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: C6CDE4023E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.90 / 10.00]; MID_CONTAINS_FROM(1.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_ONE(0.00)[1];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPFBL_URIBL_EMAIL_FAIL(0.00)[kexybiscuit.aosc.io:server
 fail,jeffbai.aosc.io:server fail,hch.lst.de:server
 fail,ralf.linux-mips.org:server fail,postmaster.amd.com:server
 fail,jeffrey.t.kirsher.intel.com:server
 fail,amd-gfx.lists.freedesktop.org:server fail,xinhui.pan.amd.com:server
 fail,christian.koenig.amd.com:server fail,hamza.mahfooz.amd.com:server
 fail,alexander.deucher.amd.com:server fail]; 
 SUBJ_BOUNCE_WORDS(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCPT_COUNT_FIVE(0.00)[5]
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

While running:

./scripts/get_maintainer.pl \
    drivers/gpu/drm/amd/display/amdgpu_dm \
    --no-rolestats'

For a list of Cc's, I got two undeliverable address errors from
postmaster@amd.com:

  Xinhui Pan <Xinhui.Pan@amd.com>
  Hamza Mahfooz <hamza.mahfooz@amd.com>

I tried to contact Alex Deucher and Christian König back in early
Februrary, but received no reply.

To avoid warning emails from the future, remove Xinhui Pan from
MAINTAINERS and add Hamza Mahfooz to .get_maintainer.ignore.

Suggested-by: Kexy Biscuit <kexybiscuit@aosc.io>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 .get_maintainer.ignore | 1 +
 MAINTAINERS            | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
index b458815f1d1bf..3343330fb11df 100644
--- a/.get_maintainer.ignore
+++ b/.get_maintainer.ignore
@@ -4,3 +4,4 @@ Christoph Hellwig <hch@lst.de>
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>
 Marc Gonzalez <marc.w.gonzalez@free.fr>
 Ralf Baechle <ralf@linux-mips.org>
+Hamza Mahfooz <hamza.mahfooz@amd.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 4ff26fa94895d..d6ea828345fdb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19657,7 +19657,6 @@ F:	drivers/net/wireless/quantenna
 RADEON and AMDGPU DRM DRIVERS
 M:	Alex Deucher <alexander.deucher@amd.com>
 M:	Christian König <christian.koenig@amd.com>
-M:	Xinhui Pan <Xinhui.Pan@amd.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 B:	https://gitlab.freedesktop.org/drm/amd/-/issues
-- 
2.48.1

