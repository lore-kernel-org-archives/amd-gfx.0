Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B9AC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 21:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846F520707
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 21:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846F520707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suffe.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359B36E44F;
	Tue, 23 Jun 2020 21:33:18 +0000 (UTC)
Received: from lb3-smtp-cloud9.xs4all.net (lb3-smtp-cloud9.xs4all.net
 [194.109.24.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C51A6E44F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 21:31:01 +0000 (UTC)
Received: from kirika.xs4all.nl ([IPv6:2001:985:5198:1:dced:2021:4507:6be6])
 by smtp-cloud9.xs4all.net with ESMTP
 id nqVOjidOvvh6gnqVPj3Ee4; Tue, 23 Jun 2020 23:30:59 +0200
Received: from mireille.lan (mireille.lan [192.168.1.3])
 by kirika.xs4all.nl (Postfix) with ESMTP id 9BDB01A40227;
 Tue, 23 Jun 2020 23:30:58 +0200 (CEST)
From: John van der Kamp <sjonny@suffe.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Unlock mutex on error
Date: Tue, 23 Jun 2020 23:30:54 +0200
Message-Id: <20200623213054.8847-1-sjonny@suffe.me.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CMAE-Envelope: MS4wfP671NncTkw+IKxGj7S3t2640Swpd+e5dbEWRhKf/VgJPRPFHTcKd0q/Zx35e+GpIljyPNn0lIQH2mFiYcmMt/fB6FVadaLh8BavF76ohHaKL1Avu0QX
 +lMpdpQvvoyJzN1pFPkPWdfQDybrrGn5ef3WDHQtRZLkvQm1C07+0DODLZPnd1o6t3aRTNvg4FLILCPZHJFAxTmXmBJjkVc2NVokBio1GWtiIkK86B1BBOYM
 1DLhYRNU/UKUGMq/e43I6Q==
X-Mailman-Approved-At: Tue, 23 Jun 2020 21:33:17 +0000
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
Cc: John van der Kamp <sjonny@suffe.me.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure we pass through ret label to unlock the mutex.

Signed-off-by: John van der Kamp <sjonny@suffe.me.uk>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index dcf84a61de37..949d10ef8304 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -510,8 +510,10 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
 
 	srm = psp_get_srm(work->hdcp.config.psp.handle, &srm_version, &srm_size);
 
-	if (!srm)
-		return -EINVAL;
+	if (!srm) {
+		ret = -EINVAL;
+		goto ret;
+	}
 
 	if (pos >= srm_size)
 		ret = 0;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
