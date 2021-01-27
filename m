Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7E2C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 04:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4767564D9D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 04:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4767564D9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4C18984C;
	Thu, 28 Jan 2021 04:17:04 +0000 (UTC)
X-Greylist: delayed 1963 seconds by postgrey-1.36 at gabe;
 Wed, 27 Jan 2021 13:07:38 UTC
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1516E2D8;
 Wed, 27 Jan 2021 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=VzzfyvKJgizs2qT6Ty
 lyZTIrBZLhf//f2J7zrq55aCc=; b=j4+ZX0V42mG9H55Yrv6XHa3TDRa/GHe5Gy
 MVUSO7cLzhXDLOguEN1DVAzKvBENEcQH7xWL+vNv9PE3kpaUiDHVI0H1tdpbf6Qt
 49HlBZEuwSrhMivlXK2XghaWz718ZI7xE0/6qdRLcRGpPVvIHkZzXPNWC+8oo3zq
 vpyUyQyMA=
Received: from localhost.localdomain.localdomain (unknown [182.150.46.145])
 by smtp2 (Coremail) with SMTP id DMmowAB3fPiXXRFg7qs1Lg--.22168S2;
 Wed, 27 Jan 2021 20:33:29 +0800 (CST)
From: Qu Huang <jinsdb@126.com>
To: Felix.Kuehling@amd.com
Subject: [PATCH] drm/amdkfd: dqm fence memory corruption
Date: Wed, 27 Jan 2021 20:33:26 +0800
Message-Id: <1611750806-10730-1-git-send-email-jinsdb@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DMmowAB3fPiXXRFg7qs1Lg--.22168S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFyfKFyfAFWDGFy3Ar4fKrg_yoW8Jr13pF
 WkJryUKry8Ja12v3s7Xa18ZFy5Ca1fWFWfGFy2k39xua13XFy5ArW5Jay8K3y8Wr92ya17
 trWDArWDuF1DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8xhJUUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: pmlq2vbe6rjloofrz/1tbimRknDl9E18PRmwAAss
X-Mailman-Approved-At: Thu, 28 Jan 2021 04:17:03 +0000
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
Cc: airlied@linux.ie, Qu Huang <jinsdb@126.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Amdgpu driver uses 4-byte data type as DQM fence memory,
and transmits GPU address of fence memory to microcode
through query status PM4 message. However, query status
PM4 message definition and microcode processing are all
processed according to 8 bytes. Fence memory only allocates
4 bytes of memory, but microcode does write 8 bytes of memory,
so there is a memory corruption.

Signed-off-by: Qu Huang <jinsdb@126.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e686ce2..8b38d0c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1161,7 +1161,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	pr_debug("Allocating fence memory\n");
 
 	/* allocate fence memory on the gart */
-	retval = kfd_gtt_sa_allocate(dqm->dev, sizeof(*dqm->fence_addr),
+	retval = kfd_gtt_sa_allocate(dqm->dev, sizeof(uint64_t),
 					&dqm->fence_mem);
 
 	if (retval)
-- 
1.8.3.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
