Return-Path: <SRS0=fKyo=G5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F380C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 05:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040E92223D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 05:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040E92223D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890206E3CE;
	Tue, 26 Jan 2021 05:43:21 +0000 (UTC)
X-Greylist: delayed 912 seconds by postgrey-1.36 at gabe;
 Tue, 26 Jan 2021 05:43:17 UTC
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 291AC6E3CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 05:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=TFaAQqi0ePIBeZ922U
 YhnHbUrMolrLx63evCPMQfBFU=; b=Irc3R8VLkGyg87/RAl3v7VwFi5sl7gJB8W
 8oqyKrSN/picKhHLockuIQACJf0vaQMsDin8hSXDLWc/G9z7oY6+4KXdLo5ir61I
 9oXcApm00xUjAxOT1Pe3Paef7Qi8ajlwHNofT9ij8fSG2a6vzN9I+tvVpmnUG26K
 Boe93l+pw=
Received: from dcu.hygon.cn (unknown [118.242.3.34])
 by smtp9 (Coremail) with SMTP id DcCowABn5DlTqA9gC98Ecg--.9494S2;
 Tue, 26 Jan 2021 13:27:52 +0800 (CST)
From: raykwok1150@163.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] register refresh to add mmGC_CAC_INDEX_AUTO_INCR_EN
Date: Tue, 26 Jan 2021 13:27:45 +0800
Message-Id: <20210126052745.14033-1-raykwok1150@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowABn5DlTqA9gC98Ecg--.9494S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1xJFy3Cr4xuFWxurWDtwb_yoW5GryfpF
 W3Ca4UKr1qqrsa9rZrZa1UKrWDW3W7Wr4qka45uwn5KFyUJws0qanxKFZ5JrWvgay8t39r
 X3W8Zay5CF4qgF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ujg4hUUUUU=
X-Originating-IP: [118.242.3.34]
X-CM-SenderInfo: 5ud1y41rnrikqq6rljoofrz/xtbB8REmYF2MYyaUSgAAss
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
Cc: Guo Lei <raykwok1150@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Guo Lei <raykwok1150@163.com>

sync form drm-next

Signed-off-by: Guo Lei <raykwok1150@163.com>
---
 src/lib/ip/gfx90_bits.i | 7 ++-----
 src/lib/ip/gfx90_regs.i | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/lib/ip/gfx90_bits.i b/src/lib/ip/gfx90_bits.i
index 6741947..8aabb8a 100644
--- a/src/lib/ip/gfx90_bits.i
+++ b/src/lib/ip/gfx90_bits.i
@@ -8711,11 +8711,8 @@ static struct umr_bitfield mmGC_CAC_CTRL_2[] = {
 	 { "CAC_SOFT_CTRL_ENABLE", 1, 1, &umr_bitfield_default },
 	 { "UNUSED_0", 2, 31, &umr_bitfield_default },
 };
-static struct umr_bitfield mmGC_CAC_CGTT_CLK_CTRL[] = {
-	 { "ON_DELAY", 0, 3, &umr_bitfield_default },
-	 { "OFF_HYSTERESIS", 4, 11, &umr_bitfield_default },
-	 { "SOFT_OVERRIDE_DYN", 30, 30, &umr_bitfield_default },
-	 { "SOFT_OVERRIDE_REG", 31, 31, &umr_bitfield_default },
+static struct umr_bitfield mmGC_CAC_INDEX_AUTO_INCR_EN[] = {
+        { "GC_CAC_INDEX_AUTO_INCR_EN", 0, 0, &umr_bitfield_default },
 };
 static struct umr_bitfield mmGC_CAC_AGGR_LOWER[] = {
 	 { "AGGR_31_0", 0, 31, &umr_bitfield_default },
diff --git a/src/lib/ip/gfx90_regs.i b/src/lib/ip/gfx90_regs.i
index 1342a66..a9ef9c6 100644
--- a/src/lib/ip/gfx90_regs.i
+++ b/src/lib/ip/gfx90_regs.i
@@ -1418,7 +1418,7 @@
 	{ "mmDIDT_IND_DATA", REG_MMIO, 0x1281, 0, &mmDIDT_IND_DATA[0], sizeof(mmDIDT_IND_DATA)/sizeof(mmDIDT_IND_DATA[0]), 0, 0 },
 	{ "mmGC_CAC_CTRL_1", REG_MMIO, 0x1284, 0, &mmGC_CAC_CTRL_1[0], sizeof(mmGC_CAC_CTRL_1)/sizeof(mmGC_CAC_CTRL_1[0]), 0, 0 },
 	{ "mmGC_CAC_CTRL_2", REG_MMIO, 0x1285, 0, &mmGC_CAC_CTRL_2[0], sizeof(mmGC_CAC_CTRL_2)/sizeof(mmGC_CAC_CTRL_2[0]), 0, 0 },
-	{ "mmGC_CAC_CGTT_CLK_CTRL", REG_MMIO, 0x1286, 0, &mmGC_CAC_CGTT_CLK_CTRL[0], sizeof(mmGC_CAC_CGTT_CLK_CTRL)/sizeof(mmGC_CAC_CGTT_CLK_CTRL[0]), 0, 0 },
+	{ "mmGC_CAC_INDEX_AUTO_INCR_EN", REG_MMIO, 0x1286, 0, &mmGC_CAC_INDEX_AUTO_INCR_EN[0], sizeof(mmGC_CAC_INDEX_AUTO_INCR_EN)/sizeof(mmGC_CAC_INDEX_AUTO_INCR_EN[0]), 0, 0 },
 	{ "mmGC_CAC_AGGR_LOWER", REG_MMIO, 0x1287, 0, &mmGC_CAC_AGGR_LOWER[0], sizeof(mmGC_CAC_AGGR_LOWER)/sizeof(mmGC_CAC_AGGR_LOWER[0]), 0, 0 },
 	{ "mmGC_CAC_AGGR_UPPER", REG_MMIO, 0x1288, 0, &mmGC_CAC_AGGR_UPPER[0], sizeof(mmGC_CAC_AGGR_UPPER)/sizeof(mmGC_CAC_AGGR_UPPER[0]), 0, 0 },
 	{ "mmGC_CAC_SOFT_CTRL", REG_MMIO, 0x128d, 0, &mmGC_CAC_SOFT_CTRL[0], sizeof(mmGC_CAC_SOFT_CTRL)/sizeof(mmGC_CAC_SOFT_CTRL[0]), 0, 0 },
-- 
2.17.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
