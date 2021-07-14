Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C7BC07E9C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 18:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BC9613C8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 18:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BC9613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541426E48D;
	Wed, 14 Jul 2021 18:36:03 +0000 (UTC)
X-Greylist: delayed 332 seconds by postgrey-1.36 at gabe;
 Wed, 14 Jul 2021 17:14:02 UTC
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491806E432
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 17:14:02 +0000 (UTC)
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D841540616; 
 Wed, 14 Jul 2021 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1626282508;
 bh=DAhaMqtw5C577LQ/86AWeIBpEHxNYnclBIEh7gDqyRs=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=hGj93JOz4sro6FFib6OFcRkkCEj08LkdkXruz9NsF78S3lLGUa9Zc5u/sxX5Si9YR
 3x3gsuFUNOyJa/sno36q9lWN6smJKvXRRPX9MgdnteZZcQE7w3bBStaxfkGuqIPUTW
 uCX3mdzNcdbgsApBlI83EgTGE/ke8I7SGfX9z413ZwPf7sX/45f+Tu6gPEmOPudLMG
 cfeydL7tviF3q9igjU2ar3tPL+ypF+CPkhAULnoUl16h2LclBPPSEzwK5qvN0EpVtG
 syz3WWkyOrdiY7nEULFP2zsFwZZPeuyYf9b9C6ttX4+r5VeGQhZHh66kEpZ+e7kUjE
 WMsSubseTWtog==
From: Colin King <colin.king@canonical.com>
To: Evan Quan <evan.quan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pan@freedesktop.org, Xinhui <Xinhui.Pan@amd.com>,
	David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: remove redundant assignment to usTMax
Date: Wed, 14 Jul 2021 18:08:28 +0100
Message-Id: <20210714170828.147618-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 14 Jul 2021 18:36:01 +0000
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Colin Ian King <colin.king@canonical.com>

Struct element usTMax is being assigned a hard coded value that
is never read and it is being re-assigned a new value immediately
afterwards. The assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index f2a55c1413f5..20e528c166f9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -977,8 +977,6 @@ static int init_thermal_controller(
 			= le16_to_cpu(tonga_fan_table->usPWMMed);
 		hwmgr->thermal_controller.advanceFanControlParameters.usPWMHigh
 			= le16_to_cpu(tonga_fan_table->usPWMHigh);
-		hwmgr->thermal_controller.advanceFanControlParameters.usTMax
-			= 10900;                  /* hard coded */
 		hwmgr->thermal_controller.advanceFanControlParameters.usTMax
 			= le16_to_cpu(tonga_fan_table->usTMax);
 		hwmgr->thermal_controller.advanceFanControlParameters.ucFanControlMode
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
