Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4E0C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 347FF10E877;
	Thu, 11 Jan 2024 09:04:26 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
 by gabe.freedesktop.org (Postfix) with ESMTP id C5D5510E08C;
 Thu, 11 Jan 2024 03:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=JwXJ7fsA7cmpEsjrHf
 poNIoh9mNuYfp1hWQOmX7j+rI=; b=IzoZqaRilSg/3KjdcmmV4DW+TUw3wiBcXH
 tAqOrsPjVitnUOVRQyuBwBbXc/uPn0FKCrq7eI85Flvb1Sx1tmGGJYhygijxuB8U
 RydRgK8Ni6K/lNyVIaQ9gVQyyNx12ndHPy60O4JZGP2AAPWjzk7vBqM2EtHEm/zh
 GgeQR1RGU=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDnj8b0Yp9ljy6eAA--.25586S2;
 Thu, 11 Jan 2024 11:39:32 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: daniel@ffwll.ch, alexander.deucher@amd.com, airlied@gmail.com,
 Xinhui.Pan@amd.com, christian.koenig@amd.com
Subject: [PATCH] drm/amd/display: Clean up errors in renoir_ip_offset.h
Date: Thu, 11 Jan 2024 03:39:30 +0000
Message-Id: <20240111033930.8056-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDnj8b0Yp9ljy6eAA--.25586S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48KF1kKF4Dtw1DKFg_yoW3KFX_Ca
 4xGws5WrWI9FnIqF1IyFn3Za4q93W09FykWw4rtFy5trnrCr1UW3y5Jr9rXr4ruFZxGFsr
 Zan5WFy5XrnagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhdixWVEuXuEDQAAsg
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:24 +0000
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
Cc: chenxuebing <chenxb_99091@126.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/renoir_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/renoir_ip_offset.h b/drivers/gpu/drm/amd/include/renoir_ip_offset.h
index 7dff85c81e5a..fa023cfdf72d 100644
--- a/drivers/gpu/drm/amd/include/renoir_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/renoir_ip_offset.h
@@ -25,13 +25,11 @@
 #define MAX_SEGMENT                                        5
 
 
-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
 };
 
-struct IP_BASE
-{
+struct IP_BASE {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 } __maybe_unused;
 
-- 
2.17.1

