Return-Path: <SRS0=mFKL=53=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80145C2BA19
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 23:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568D1216FD
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 23:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+S58iBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568D1216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DE26E3A0;
	Sat, 11 Apr 2020 23:10:54 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CACC6E39B;
 Sat, 11 Apr 2020 23:10:52 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5357A21924;
 Sat, 11 Apr 2020 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586646652;
 bh=JKifc22C2UL+b3jQWkj/4fHSC1WFMr8V0XiS/e49728=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s+S58iBHl+TaPsMDf5PfA7GxFAGfx3ah7gPrivEnyAL8i+m5HRCUYzX+m5wZ60bfU
 hTyRantXQfcm8EMGNnVIBDpFpbd6Z3wfUOB3uVOcuQ4g4ZBa/xXftbiCOcoeRm03cb
 4uLFUoXIi9Q7AmRX/czaf3/ZQXSpzIkK9KSDyr9I=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 055/108] drm/amd/display: dc_get_vmid_use_vector()
 crashes when get called
Date: Sat, 11 Apr 2020 19:08:50 -0400
Message-Id: <20200411230943.24951-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 Peikang Zhang <peikang.zhang@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peikang Zhang <peikang.zhang@amd.com>

[ Upstream commit 68bbca15e7062f4ae16531e29893f78d0b4840b6 ]

[Why]
int i can go out of boundary which will cause crash

[How]
Fixed the maximum value of i to avoid i going out of boundary

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index a96d8de9380e6..f2b39ec35c898 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -62,7 +62,7 @@ int dc_get_vmid_use_vector(struct dc *dc)
 	int i;
 	int in_use = 0;
 
-	for (i = 0; i < dc->vm_helper->num_vmid; i++)
+	for (i = 0; i < MAX_HUBP; i++)
 		in_use |= dc->vm_helper->hubp_vmid_usage[i].vmid_usage[0]
 			| dc->vm_helper->hubp_vmid_usage[i].vmid_usage[1];
 	return in_use;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
