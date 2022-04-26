Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE36C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 12:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E73F10E0D6;
	Tue, 26 Apr 2022 12:56:13 +0000 (UTC)
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E8E10EA5B;
 Tue, 26 Apr 2022 10:18:32 +0000 (UTC)
X-UUID: 839b2cb5bfb342069a8d8897af33cbe3-20220426
X-GW-Reason: 11109
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 106 audit/email.address 1 meta/cnt.alert 1
X-UUID: 839b2cb5bfb342069a8d8897af33cbe3-20220426
X-User: oushixiong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
 (envelope-from <oushixiong@kylinos.cn>) (Generic MTA)
 with ESMTP id 1529660238; Tue, 26 Apr 2022 18:10:05 +0800
From: oushixiong <oushixiong@kylinos.cn>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd: Fix spelling typo in comment
Date: Tue, 26 Apr 2022 18:11:26 +0800
Message-Id: <20220426101126.1417207-1-oushixiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 Apr 2022 12:56:12 +0000
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
Cc: oushixiong <oushixiong@kylinos.cn>, Jiawei Gu <Jiawei.Gu@amd.com>,
 David Airlie <airlied@linux.ie>, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, John Clements <john.clements@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: oushixiong <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 7bd763361d6e..b7a1e2116e7e 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -3,7 +3,7 @@
 *  File Name      atomfirmware.h
 *  Project        This is an interface header file between atombios and OS GPU drivers for SoC15 products
 *
-*  Description    header file of general definitions for OS nd pre-OS video drivers
+*  Description    header file of general definitions for OS and pre-OS video drivers
 *
 *  Copyright 2014 Advanced Micro Devices, Inc.
 *
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
