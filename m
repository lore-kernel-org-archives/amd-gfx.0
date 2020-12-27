Return-Path: <SRS0=dnVN=F7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D116C433DB
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Dec 2020 20:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAC922513
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Dec 2020 20:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAC922513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 515E1897EB;
	Sun, 27 Dec 2020 20:56:47 +0000 (UTC)
X-Greylist: delayed 1948 seconds by postgrey-1.36 at gabe;
 Sun, 27 Dec 2020 08:57:26 UTC
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2D8893E8;
 Sun, 27 Dec 2020 08:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=m5oVi0TtWHQkthGZkb
 SLeLd7sFG2BGbk2xXapv0duR4=; b=eL7TScYOee7UjWzkvmx0DdVX31cX73QcLX
 9oZZVrlz9cccRKGpRZ0az7Jn4lulbkJuDoUQKzlpdegPmo/ehwTqSZhLto6gRLzj
 +chCXQ4zUAu3vBLFacn/EGx54FjlPGWQ10OQjqjPlT5r0oW9xy5Mn8FMu0nS+mWz
 I1I8cdDhk=
Received: from localhost.localdomain (unknown [36.112.86.14])
 by smtp7 (Coremail) with SMTP id DsmowADX32_DROhf0ypiMg--.29381S2;
 Sun, 27 Dec 2020 16:24:37 +0800 (CST)
From: Defang Bo <bodefang@126.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH] drm/radeon:avoid null pointer dereference when dev is not
 bound
Date: Sun, 27 Dec 2020 16:24:29 +0800
Message-Id: <1609057469-3844200-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsmowADX32_DROhf0ypiMg--.29381S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKryxurWxZFWUKw45ur47XFb_yoWkuwc_uw
 10va4xWaykZwnYqF1Y9F1Ivr9rtFsY9rZ5WFn7ta4fXry7X348ZayUXFyUWr47Wa1UAF90
 vF4vq3ySyrsFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUgTmDUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbi6wUI11pD9bQS2AAAsj
X-Mailman-Approved-At: Sun, 27 Dec 2020 20:56:45 +0000
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
Cc: alexander.deucher@amd.com, Defang Bo <bodefang@126.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Similar to commit<0fa375e6>. If the set_state/can_switch code access the drm_device when dev is not bound,
a null pointer dereference can happen.

[How]
Add sanity checks to prevent it.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 266e3cb..50a1a60 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1224,6 +1224,9 @@ static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	if (!dev)
+		return;
+
 	if (radeon_is_px(dev) && state == VGA_SWITCHEROO_OFF)
 		return;
 
@@ -1257,6 +1260,9 @@ static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
 static bool radeon_switcheroo_can_switch(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+
+	if (!dev)
+		return false;
 
 	/*
 	 * FIXME: open_count is protected by drm_global_mutex but that would lead to
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
