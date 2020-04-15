Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A35EC2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 11:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE2C208FE
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 11:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkILaa7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE2C208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12FB6E977;
	Wed, 15 Apr 2020 11:35:58 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3287A6E977;
 Wed, 15 Apr 2020 11:35:58 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 47B9E2078A;
 Wed, 15 Apr 2020 11:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586950558;
 bh=uC9JFgoKOhfTK98rPb7jgE0oqaQzBDX/tz1p1CqrX0I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KkILaa7gsvdkLsSqT7xFTSG/6ZreZ50rfR+GJLvyTPywPp2W+VmXqS3j8naKOvyoD
 VzAw4cOv13OSA+ud1awhVGSsP0EloBtLrVqHUT5vaxhUEIgw7h1kvEmVTrDFBi+AVr
 Qw0/aKFra7PpYLrYF13fpuYDiqgDBZppTsGz2sp8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 063/129] drm/amd/display: Don't try hdcp1.4 when
 content_type is set to type1
Date: Wed, 15 Apr 2020 07:33:38 -0400
Message-Id: <20200415113445.11881-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[ Upstream commit c2850c125d919efbb3a9ab46410d23912934f585 ]

[Why]
When content type property is set to 1. We should enable hdcp2.2 and if we cant
then stop. Currently the way it works in DC is that if we fail hdcp2, we will
try hdcp1 after.

[How]
Use link config to force disable hdcp1.4 when type1 is set.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 0acd3409dd6ce..3abeff7722e3d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -113,10 +113,13 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 
 		if (enable_encryption) {
 			display->adjust.disable = 0;
-			if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0)
+			if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
+				hdcp_w->link.adjust.hdcp1.disable = 0;
 				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
-			else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1)
+			} else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1) {
+				hdcp_w->link.adjust.hdcp1.disable = 1;
 				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_1;
+			}
 
 			schedule_delayed_work(&hdcp_w->property_validate_dwork,
 					      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
@@ -334,6 +337,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	display->adjust.disable = 1;
 	link->adjust.auth_delay = 2;
+	link->adjust.hdcp1.disable = 0;
 
 	hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
 }
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
