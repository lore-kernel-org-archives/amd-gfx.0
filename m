Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D4EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9712396F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9712396F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2AE89F6B;
	Fri,  8 Jan 2021 10:55:11 +0000 (UTC)
X-Greylist: delayed 371 seconds by postgrey-1.36 at gabe;
 Fri, 08 Jan 2021 10:55:10 UTC
Received: from forward104j.mail.yandex.net (forward104j.mail.yandex.net
 [5.45.198.247])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18C889F6B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 10:55:10 +0000 (UTC)
Received: from iva4-12d38d5d3a8a.qloud-c.yandex.net
 (iva4-12d38d5d3a8a.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:1293:0:640:12d3:8d5d])
 by forward104j.mail.yandex.net (Yandex) with ESMTP id 09BB74A2905;
 Fri,  8 Jan 2021 13:48:55 +0300 (MSK)
Received: from iva3-dd2bb2ff2b5f.qloud-c.yandex.net
 (iva3-dd2bb2ff2b5f.qloud-c.yandex.net [2a02:6b8:c0c:7611:0:640:dd2b:b2ff])
 by iva4-12d38d5d3a8a.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 DFmw48kcAB-msEGEnRd; Fri, 08 Jan 2021 13:48:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1610102934; bh=eCCurf7Yw1BIH5wLCF9i8whOrtHpEnFBaenCk/0z2zU=;
 h=Subject:To:From:Message-Id:Cc:Date;
 b=azboT+KE8NUtrSvq9zv21HPgS92+UYeeNfhrFSXEz90XKg9qETv36Wtv87k0ZKuxD
 w9PKqbMaMlhPCWeG1XMWmqiCc8j80ZMshkvjehuMtof5G+viIcfSTGYPet4cDqy6WG
 gQSxLRnFwEJiFvqkB+mnfSJCdXrIUGuYcoNS4htQ=
Authentication-Results: iva4-12d38d5d3a8a.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by iva3-dd2bb2ff2b5f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id HWNH9I13va-msI8n5uu; Fri, 08 Jan 2021 13:48:54 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: Fixed Intermittent blue screen on
 OLED panel"
Date: Fri,  8 Jan 2021 13:48:47 +0300
Message-Id: <20210108104847.152847-1-Hi-Angel@yandex.ru>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Naveed.Ashfaq@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit a861736dae644a0d7abbca0c638ae6aad28feeb8.

This commit led to a power regression where AMD cards draw lots of power
while being idle.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1407
Cc: <stable@vger.kernel.org> # 5.10
Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 .../amd/display/dc/dml/dcn20/display_mode_vba_20v2.c  | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 860e72a51534..80170f9721ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2635,14 +2635,15 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 	}
 
 	if (mode_lib->vba.DRAMClockChangeSupportsVActive &&
-			mode_lib->vba.MinActiveDRAMClockChangeMargin > 60 &&
-			mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
+			mode_lib->vba.MinActiveDRAMClockChangeMargin > 60) {
 		mode_lib->vba.DRAMClockChangeWatermark += 25;
 
 		for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-			if (mode_lib->vba.DRAMClockChangeWatermark >
-			dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
-				mode_lib->vba.MinTTUVBlank[k] += 25;
+			if (mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
+				if (mode_lib->vba.DRAMClockChangeWatermark >
+				dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
+					mode_lib->vba.MinTTUVBlank[k] += 25;
+			}
 		}
 
 		mode_lib->vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vactive;
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
