Return-Path: <SRS0=7Usp=F3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B275C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 02:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF56A23159
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 02:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF56A23159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B176E898;
	Wed, 23 Dec 2020 02:16:58 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896096E892;
 Wed, 23 Dec 2020 02:16:54 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CF432312E;
 Wed, 23 Dec 2020 02:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608689814;
 bh=Vx3ezAW5GJLBA67L7m77bVSFJqgm6ZZ07DOmRVrLuZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Krz+61sH3vYZl1a28xJqKdjQU2B0vvkNOyjTW7amKFEhEd48T1CH/EAgvwH+23FNI
 TEf2qpbjHgVh0gFuwujnYjw+8753nE6cwDOzn8c/Rk7T/HS4SIvk45PKSG4V9Jsrqo
 vymIRX5u2+JqWd5HzT8tMx/4wsELm2PfW18rpiOLP3DWXoGbmYbVxhG2DRHRa5LSPQ
 4prMWkWF2AxfBLwMyrerN9NJeMS2igqIzER36tV+n7SD7D4grnjjdM3rcVziux8C/U
 Yc1OjSHKFBm4jnzkoQnmus0rs4i0tjU9yTTHrNbkco5J726frHJ6rOqSGuXWJ6Q48N
 c3iPRJlGnYiiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 021/217] drm/amd/display: stop top_mgr when type
 change to non-MST during s3
Date: Tue, 22 Dec 2020 21:13:10 -0500
Message-Id: <20201223021626.2790791-21-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021626.2790791-1-sashal@kernel.org>
References: <20201223021626.2790791-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Lewis Huang <Lewis.Huang@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[ Upstream commit e748b59fb74e8725c8774a4b0753fabba9de7b97 ]

[Why]
Driver keeps the invalid information cause report the
incorrect monitor which save in remote sink to OS

[How]
When connector type change from MST to non-MST,
stop the topology manager.

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 5b0cedfa824a9..59c5915665112 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -854,6 +854,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 	struct dpcd_caps prev_dpcd_caps;
 	bool same_dpcd = true;
 	enum dc_connection_type new_connection_type = dc_connection_none;
+	enum dc_connection_type pre_connection_type = dc_connection_none;
 	bool perform_dp_seamless_boot = false;
 	const uint32_t post_oui_delay = 30; // 30ms
 
@@ -889,6 +890,7 @@ static bool dc_link_detect_helper(struct dc_link *link,
 
 	link_disconnect_sink(link);
 	if (new_connection_type != dc_connection_none) {
+		pre_connection_type = link->type;
 		link->type = new_connection_type;
 		link->link_state_valid = false;
 
@@ -962,6 +964,12 @@ static bool dc_link_detect_helper(struct dc_link *link,
 				return true;
 			}
 
+			// link switch from MST to non-MST stop topology manager
+			if (pre_connection_type == dc_connection_mst_branch &&
+				link->type != dc_connection_mst_branch) {
+				dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
+			}
+
 			if (link->type == dc_connection_mst_branch) {
 				LINK_INFO("link=%d, mst branch is now Connected\n",
 					  link->link_index);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
