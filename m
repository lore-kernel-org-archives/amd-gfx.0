Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F3BC2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D470B222C4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIAINiU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D470B222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A8AE6FA04;
	Fri, 14 Feb 2020 15:59:24 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D356FA03;
 Fri, 14 Feb 2020 15:59:22 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCA2D24654;
 Fri, 14 Feb 2020 15:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581695962;
 bh=Yi9pz/ne4bmU10ZVJ5yO0fZjC2dJYgduYi8RFyzbxhU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DIAINiU3O6pm5gi3fE3grBTqBVU74I64iHO+9TRBpc36+LapCl3czkStRgyecp2yl
 CDPOgw9ruiAz+8HO/1Ft2JKhegGs/pt3zFOWtVY+26AOcgE+xW5iBhh+Hdt2co0bRZ
 GWQvEs4hiDcT3xR8c/136QwlI9pcT2S+pU2Ysr5Y=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 491/542] drm/amd/display: do not allocate
 display_mode_lib unnecessarily
Date: Fri, 14 Feb 2020 10:48:03 -0500
Message-Id: <20200214154854.6746-491-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Dor Askayo <dor.askayo@gmail.com>,
 Leo Li <sunpeng.li@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dor Askayo <dor.askayo@gmail.com>

[ Upstream commit bb67bfd2e7101bf2ac5327b0b7a847cd9fb9723f ]

This allocation isn't required and can fail when resuming from suspend.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1009
Signed-off-by: Dor Askayo <dor.askayo@gmail.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 32f31bf919151..8904a85186aab 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2396,12 +2396,7 @@ void dc_set_power_state(
 	enum dc_acpi_cm_power_state power_state)
 {
 	struct kref refcount;
-	struct display_mode_lib *dml = kzalloc(sizeof(struct display_mode_lib),
-						GFP_KERNEL);
-
-	ASSERT(dml);
-	if (!dml)
-		return;
+	struct display_mode_lib *dml;
 
 	switch (power_state) {
 	case DC_ACPI_CM_POWER_STATE_D0:
@@ -2423,6 +2418,12 @@ void dc_set_power_state(
 		 * clean state, and dc hw programming optimizations will not
 		 * cause any trouble.
 		 */
+		dml = kzalloc(sizeof(struct display_mode_lib),
+				GFP_KERNEL);
+
+		ASSERT(dml);
+		if (!dml)
+			return;
 
 		/* Preserve refcount */
 		refcount = dc->current_state->refcount;
@@ -2436,10 +2437,10 @@ void dc_set_power_state(
 		dc->current_state->refcount = refcount;
 		dc->current_state->bw_ctx.dml = *dml;
 
+		kfree(dml);
+
 		break;
 	}
-
-	kfree(dml);
 }
 
 void dc_resume(struct dc *dc)
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
