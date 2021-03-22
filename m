Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72C9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 13:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFF56191C
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 13:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFF56191C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148D76E157;
	Mon, 22 Mar 2021 13:23:35 +0000 (UTC)
X-Greylist: delayed 906 seconds by postgrey-1.36 at gabe;
 Mon, 22 Mar 2021 08:31:35 UTC
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4F589FFD;
 Mon, 22 Mar 2021 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=AOj1KLDMOWvHBGXOOf
 nN3WKopE7N9vEYfmfmtmIwbrQ=; b=LIy2BIyA2+Zhlqp5krdHEz4pnj48Czlezb
 HzyExMuPooTogFvLgYr1ZkUy1WLbqd+t1v8dv8Z/GWWjh7agnspnfkPDHT7mw2Ua
 OUKDqIZ8OPzuacJk0eqhnSLAzFLBKSWBES9mGf7QBLW8+rS1ftvDywoQsQiMWgSe
 GJqGgHuoY=
Received: from wengjianfeng.ccdomain.com (unknown [218.17.89.92])
 by smtp5 (Coremail) with SMTP id HdxpCgBHfDk6UlhgLSO1BQ--.5281S2;
 Mon, 22 Mar 2021 16:15:56 +0800 (CST)
From: samirweng1979 <samirweng1979@163.com>
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, kenneth.feng@amd.com
Subject: [PATCH] drm/amd/pm/powerplay/smumgr/smu7_smumgr: Fix some typo error
Date: Mon, 22 Mar 2021 16:16:06 +0800
Message-Id: <20210322081606.25116-1-samirweng1979@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: HdxpCgBHfDk6UlhgLSO1BQ--.5281S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1UAr4fAFW3tw13Wr1xXwb_yoW8GrW3pF
 s3Cr43Z3yxA3W7Ka1DWa17Xry8C3W8XFyqkFsrC3s0934YgrnYvF98Gayavw4UGa4xCw1x
 t39Fg39rW3WIv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b5JPiUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: pvdpx25zhqwiqzxzqiywtou0bp/1tbiHRxdsVSIp0RWJAAAsg
X-Mailman-Approved-At: Mon, 22 Mar 2021 13:23:34 +0000
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
Cc: wengjianfeng <wengjianfeng@yulong.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: wengjianfeng <wengjianfeng@yulong.com>

change 'addres' to 'address'

Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
index aae2524..0de9e0e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
@@ -97,7 +97,7 @@ int smu7_copy_bytes_to_smc(struct pp_hwmgr *hwmgr, uint32_t smc_start_address,
 	addr = smc_start_address;
 
 	while (byte_count >= 4) {
-	/* Bytes are written into the SMC addres space with the MSB first. */
+	/* Bytes are written into the SMC address space with the MSB first. */
 		data = src[0] * 0x1000000 + src[1] * 0x10000 + src[2] * 0x100 + src[3];
 
 		result = smu7_set_smc_sram_address(hwmgr, addr, limit);
@@ -127,7 +127,7 @@ int smu7_copy_bytes_to_smc(struct pp_hwmgr *hwmgr, uint32_t smc_start_address,
 		extra_shift = 8 * (4 - byte_count);
 
 		while (byte_count > 0) {
-			/* Bytes are written into the SMC addres space with the MSB first. */
+			/* Bytes are written into the SMC address space with the MSB first. */
 			data = (0x100 * data) + *src++;
 			byte_count--;
 		}
-- 
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
