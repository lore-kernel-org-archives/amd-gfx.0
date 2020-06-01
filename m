Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9D9C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96E42074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2tkdgRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96E42074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94EE26E170;
	Mon,  1 Jun 2020 18:03:13 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB1C6E170
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:11 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id cv17so429652qvb.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KsA/xlFKaU61GCxWSDFpZZNi667kl5b4zNzwbLvUytA=;
 b=c2tkdgRdI4++w0Betkio3M2PrutieZjLg3ADRfm3MaS5nJmQ9zx6CkGr+ZODon5Qmr
 rfKBi6oQePLJXDQg8G2I78H5po5UQvOHV9VltgIqaj78N1VeONclTfoYT84cBk3ySxFP
 SZO3Mq/uTUJL1f8aVD4eKqL6/V/sRXvS3bhD0+bBZE2X8dApYmng06MXdl7TRYPm/ba6
 ztn32hjitjhUA0AWDtUx1bKks8MWj7nzPp2IPvMXlbQ/NjYNyokNnByx+/1xh7Lnk3MJ
 j99EvuGKh9Mshj3jF33MQstqxCo9ry2eXdPnK+yYUhThKd91sxE+mvg96VEDtSL8y1K/
 IEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KsA/xlFKaU61GCxWSDFpZZNi667kl5b4zNzwbLvUytA=;
 b=C3Wh8PDNKoKFSLju9/BP1J+Dt1QPWIRdkgO6m06XPJZlzMusjr7jeIYOganWRq74rl
 o1jpg0Xl6mFkcOncPR7Ur9C9tU0XKaYU055rLROsNacDSNqZkqNBsi7mAx6zmWw2ZsWM
 HbnY7i6VnAieu/c3Gg/xNKx24MPIn2d9C1s1a89hXaO8fFSf7ajiNE5FFQcV5go7UXZT
 1Wg6rg4dxkL6IACicmwc0UQnMHmawg4SR7v4YXq1Nl/En0gL3NeNPtwh52nMvF5o1TLh
 zAPUinf++Dd6xLIgW8Rss8RhBxBeMsWNAMt0PavAcKRkPG/e3k+eJkBPZqFB7i0kZt3m
 awcQ==
X-Gm-Message-State: AOAM532Pf9SSESXFHfPEK299Jv0z7bqJOWOIjEBJmfGUxQ74VDbRy73C
 8Lv8SMqw0W3LrTH51Zxh9mbwwFh1
X-Google-Smtp-Source: ABdhPJz2fLgOO8CH2lO0lF2DvRgvXRxa0Wcn2g8qHCDsLNWJAnPazGsVy1tRDSPw46IRdBq0w6L9CQ==
X-Received: by 2002:a0c:b797:: with SMTP id l23mr22526215qve.160.1591034590699; 
 Mon, 01 Jun 2020 11:03:10 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:10 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 020/207] drm/amdgpu: add sdma2 and sdma3 irqsrc header files
 for sienna_cichlid (v2)
Date: Mon,  1 Jun 2020 13:59:32 -0400
Message-Id: <20200601180239.1267430-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add irq src headers for additional SDMA blocks.

v2: Add missing licenses (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/ivsrcid/sdma2/irqsrcs_sdma2_5_0.h | 45 +++++++++++++++++++
 .../include/ivsrcid/sdma3/irqsrcs_sdma3_5_0.h | 45 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/sdma2/irqsrcs_sdma2_5_0.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/sdma3/irqsrcs_sdma3_5_0.h

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/sdma2/irqsrcs_sdma2_5_0.h b/drivers/gpu/drm/amd/include/ivsrcid/sdma2/irqsrcs_sdma2_5_0.h
new file mode 100644
index 000000000000..daa498478ba6
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/sdma2/irqsrcs_sdma2_5_0.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef __IRQSRCS_SDMA2_5_0_H__
+#define __IRQSRCS_SDMA2_5_0_H__
+
+
+#define SDMA2_5_0__SRCID__SDMA_ATOMIC_RTN_DONE				217		// 0xD9 SDMA atomic*_rtn ops complete
+#define SDMA2_5_0__SRCID__SDMA_ATOMIC_TIMEOUT				218		// 0xDA SDMA atomic CMPSWAP loop timeout
+#define SDMA2_5_0__SRCID__SDMA_IB_PREEMPT					219		// 0xDB sdma mid-command buffer preempt interrupt
+#define SDMA2_5_0__SRCID__SDMA_ECC					        220		// 0xDC ECC  Error
+#define SDMA2_5_0__SRCID__SDMA_PAGE_FAULT					221		// 0xDD Page Fault Error from UTCL2 when nack=3
+#define SDMA2_5_0__SRCID__SDMA_PAGE_NULL					222		// 0xDE Page Null from UTCL2 when nack=2
+#define SDMA2_5_0__SRCID__SDMA_XNACK					    223		// 0xDF Page retry  timeout after UTCL2 return nack=1
+#define SDMA2_5_0__SRCID__SDMA_TRAP					        224		// 0xE0 Trap
+#define SDMA2_5_0__SRCID__SDMA_SEM_INCOMPLETE_TIMEOUT		225		// 0xE1 0xDAGPF (Sem incomplete timeout)
+#define SDMA2_5_0__SRCID__SDMA_SEM_WAIT_FAIL_TIMEOUT		226		// 0xE2 Semaphore wait fail timeout
+#define SDMA2_5_0__SRCID__SDMA_SRAM_ECC					    228		// 0xE4 SRAM ECC Error
+#define SDMA2_5_0__SRCID__SDMA_PREEMPT					    240		// 0xF0 SDMA New Run List
+#define SDMA2_5_0__SRCID__SDMA_VM_HOLE					    242		// 0xF2 MC or SEM address in VM hole
+#define SDMA2_5_0__SRCID__SDMA_CTXEMPTY					    243		// 0xF3 Context Empty
+#define SDMA2_5_0__SRCID__SDMA_DOORBELL_INVALID				244		// 0xF4 Doorbell BE invalid
+#define SDMA2_5_0__SRCID__SDMA_FROZEN					    245		// 0xF5 SDMA Frozen
+#define SDMA2_5_0__SRCID__SDMA_POLL_TIMEOUT					246		// 0xF6 SRBM read poll timeout
+#define SDMA2_5_0__SRCID__SDMA_SRBMWRITE					247		// 0xF7 SRBM write Protection
+
+#endif // __IRQSRCS_SDMA2_5_0_H__
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/sdma3/irqsrcs_sdma3_5_0.h b/drivers/gpu/drm/amd/include/ivsrcid/sdma3/irqsrcs_sdma3_5_0.h
new file mode 100644
index 000000000000..e0ee820d5097
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/sdma3/irqsrcs_sdma3_5_0.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef __IRQSRCS_SDMA3_5_0_H__
+#define __IRQSRCS_SDMA3_5_0_H__
+
+
+#define SDMA3_5_0__SRCID__SDMA_ATOMIC_RTN_DONE				217		// 0xD9 SDMA atomic*_rtn ops complete
+#define SDMA3_5_0__SRCID__SDMA_ATOMIC_TIMEOUT				218		// 0xDA SDMA atomic CMPSWAP loop timeout
+#define SDMA3_5_0__SRCID__SDMA_IB_PREEMPT					219		// 0xDB sdma mid-command buffer preempt interrupt
+#define SDMA3_5_0__SRCID__SDMA_ECC					        220		// 0xDC ECC  Error
+#define SDMA3_5_0__SRCID__SDMA_PAGE_FAULT					221		// 0xDD Page Fault Error from UTCL2 when nack=3
+#define SDMA3_5_0__SRCID__SDMA_PAGE_NULL					222		// 0xDE Page Null from UTCL2 when nack=2
+#define SDMA3_5_0__SRCID__SDMA_XNACK					    223		// 0xDF Page retry  timeout after UTCL2 return nack=1
+#define SDMA3_5_0__SRCID__SDMA_TRAP					        224		// 0xE0 Trap
+#define SDMA3_5_0__SRCID__SDMA_SEM_INCOMPLETE_TIMEOUT		225		// 0xE1 0xDAGPF (Sem incomplete timeout)
+#define SDMA3_5_0__SRCID__SDMA_SEM_WAIT_FAIL_TIMEOUT		226		// 0xE2 Semaphore wait fail timeout
+#define SDMA3_5_0__SRCID__SDMA_SRAM_ECC					    228		// 0xE4 SRAM ECC Error
+#define SDMA3_5_0__SRCID__SDMA_PREEMPT					    240		// 0xF0 SDMA New Run List
+#define SDMA3_5_0__SRCID__SDMA_VM_HOLE					    242		// 0xF2 MC or SEM address in VM hole
+#define SDMA3_5_0__SRCID__SDMA_CTXEMPTY					    243		// 0xF3 Context Empty
+#define SDMA3_5_0__SRCID__SDMA_DOORBELL_INVALID				244		// 0xF4 Doorbell BE invalid
+#define SDMA3_5_0__SRCID__SDMA_FROZEN					    245		// 0xF5 SDMA Frozen
+#define SDMA3_5_0__SRCID__SDMA_POLL_TIMEOUT					246		// 0xF6 SRBM read poll timeout
+#define SDMA3_5_0__SRCID__SDMA_SRBMWRITE					247		// 0xF7 SRBM write Protection
+
+#endif // __IRQSRCS_SDMA3_5_0_H__
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
