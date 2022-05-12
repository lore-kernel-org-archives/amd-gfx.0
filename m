Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35B1C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 12:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA5110FFCE;
	Thu, 12 May 2022 12:53:51 +0000 (UTC)
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DBB10FC07;
 Thu, 12 May 2022 10:50:28 +0000 (UTC)
X-UUID: 42638307e20445239de8faf503934731-20220512
X-GW-Reason: 11101
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 116 audit/email.address 1 meta/cnt.alert 1
X-UUID: 42638307e20445239de8faf503934731-20220512
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
 (envelope-from <pengfuyuan@kylinos.cn>) (Generic MTA)
 with ESMTP id 124501943; Thu, 12 May 2022 16:52:21 +0800
X-ns-mid: postfix-627CCA00-974326314
Received: from localhost.localdomain (unknown [172.20.4.120])
 by cs2c.com.cn (NSMail) with ESMTPA id C3C48383C640;
 Thu, 12 May 2022 08:49:03 +0000 (UTC)
From: pengfuyuan <pengfuyuan@kylinos.cn>
To: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Remove macro DC_DEFAULT_LOG_MASK
Date: Thu, 12 May 2022 16:48:51 +0800
Message-Id: <20220512084851.104099-1-pengfuyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 May 2022 12:53:46 +0000
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
Cc: pengfuyuan <pengfuyuan@kylinos.cn>, Leo Li <sunpeng.li@amd.com>,
 Xinhui.Pan@amd.com, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
The DC_DEFAULT_LOG_MASK macro has not been used for a long time, so remove it.

Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 .../drm/amd/display/include/logger_types.h    | 34 -------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index f093b49c5e6e..a31d7c959f2c 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -131,37 +131,3 @@ enum dc_log_type {
 #define DC_MIN_LOG_MASK ((1 << LOG_ERROR) | \
 		(1 << LOG_DETECTION_EDID_PARSER))
 
-#define DC_DEFAULT_LOG_MASK ((1ULL << LOG_ERROR) | \
-		(1ULL << LOG_WARNING) | \
-		(1ULL << LOG_EVENT_MODE_SET) | \
-		(1ULL << LOG_EVENT_DETECTION) | \
-		(1ULL << LOG_EVENT_LINK_TRAINING) | \
-		(1ULL << LOG_EVENT_LINK_LOSS) | \
-		(1ULL << LOG_EVENT_UNDERFLOW) | \
-		(1ULL << LOG_RESOURCE) | \
-		(1ULL << LOG_FEATURE_OVERRIDE) | \
-		(1ULL << LOG_DETECTION_EDID_PARSER) | \
-		(1ULL << LOG_DC) | \
-		(1ULL << LOG_HW_HOTPLUG) | \
-		(1ULL << LOG_HW_SET_MODE) | \
-		(1ULL << LOG_HW_RESUME_S3) | \
-		(1ULL << LOG_HW_HPD_IRQ) | \
-		(1ULL << LOG_SYNC) | \
-		(1ULL << LOG_BANDWIDTH_VALIDATION) | \
-		(1ULL << LOG_MST) | \
-		(1ULL << LOG_DETECTION_DP_CAPS) | \
-		(1ULL << LOG_BACKLIGHT)) | \
-		(1ULL << LOG_I2C_AUX) | \
-		(1ULL << LOG_IF_TRACE) | \
-		(1ULL << LOG_HDMI_FRL) | \
-		(1ULL << LOG_SCALER) | \
-		(1ULL << LOG_DTN) /* | \
-		(1ULL << LOG_DEBUG) | \
-		(1ULL << LOG_BIOS) | \
-		(1ULL << LOG_SURFACE) | \
-		(1ULL << LOG_DML) | \
-		(1ULL << LOG_HW_LINK_TRAINING) | \
-		(1ULL << LOG_HW_AUDIO)| \
-		(1ULL << LOG_BANDWIDTH_CALCS)*/
-
-#endif /* __DAL_LOGGER_TYPES_H__ */
-- 
2.25.1

