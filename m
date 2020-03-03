Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1570DC3F2CD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 08:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96E8208C3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 08:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96E8208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069346EA37;
	Tue,  3 Mar 2020 08:24:19 +0000 (UTC)
Received: from yyz.mikelr.com (unknown
 [IPv6:2602:ffb6:2:0:f816:3eff:fe0d:377b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC6C6E968
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 03:41:56 +0000 (UTC)
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com
 [198.84.194.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by yyz.mikelr.com (Postfix) with ESMTPSA id 1FCFC3CF26;
 Mon,  2 Mar 2020 22:35:03 -0500 (EST)
From: Mikel Rychliski <mikel@mikelr.com>
To: amd-gfx@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/4] drm/radeon: iounmap unused mapping
Date: Mon,  2 Mar 2020 22:34:56 -0500
Message-Id: <20200303033457.12180-4-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200303033457.12180-1-mikel@mikelr.com>
References: <20200303033457.12180-1-mikel@mikelr.com>
X-Mailman-Approved-At: Tue, 03 Mar 2020 08:24:15 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Matthew Garrett <matthewgarrett@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Mikel Rychliski <mikel@mikelr.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now that pci_platform_rom creates a new mapping to access the ROM
image, we should remove this mapping after extracting the BIOS.

Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index c3ae4c92a115..712b88d88957 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -123,6 +123,7 @@ static bool radeon_read_platform_bios(struct radeon_device *rdev)
 		return false;
 
 	memcpy_fromio(rdev->bios, bios, size);
+	iounmap(bios);
 
 	if (size == 0 || rdev->bios[0] != 0x55 || rdev->bios[1] != 0xaa) {
 		kfree(rdev->bios);
-- 
2.13.7

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
