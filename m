Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DB1C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AC822CE3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn61ZB2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AC822CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7980F6E2F3;
	Mon, 24 Aug 2020 16:37:02 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F42F6E34D;
 Mon, 24 Aug 2020 16:36:59 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C29F22EBF;
 Mon, 24 Aug 2020 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598287019;
 bh=Qb8aFC6TvWQKenk2+lVWb3TA3O+op2FVQc9sneFbMwg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gn61ZB2Feda4wJ0VboChj9+18dDyN3LT2UYHNilO9pm4FZJnCTVTe5kxntE+ExRIZ
 +v2Dzsg/nstD0+F0PLHv+gcpbNOUXkA9qWyoK8tMS+c0NtIzKHdntrewpKAnb5WY0f
 a2QIQ1o+5wTPcIq56S4vSvfM1M0dCxEwHpK0kwwU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 18/54] drm/amd/display: Fix LFC multiplier
 changing erratically
Date: Mon, 24 Aug 2020 12:35:57 -0400
Message-Id: <20200824163634.606093-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163634.606093-1-sashal@kernel.org>
References: <20200824163634.606093-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Aric Cyr <Aric.Cyr@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[ Upstream commit e4ed4dbbc8383d42a197da8fe7ca6434b0f14def ]

[Why]
1. There is a calculation that is using frame_time_in_us instead of
last_render_time_in_us to calculate whether choosing an LFC multiplier
would cause the inserted frame duration to be outside of range.

2. We do not handle unsigned integer subtraction correctly and it underflows
to a really large value, which causes some logic errors.

[How]
1. Fix logic to calculate 'within range' using last_render_time_in_us
2. Split out delta_from_mid_point_delta_in_us calculation to ensure
we don't underflow and wrap around

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/modules/freesync/freesync.c   | 36 +++++++++++++++----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index c33454a9e0b4d..85dcb3b078df7 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -324,22 +324,44 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 
 		/* Choose number of frames to insert based on how close it
 		 * can get to the mid point of the variable range.
+		 *  - Delta for CEIL: delta_from_mid_point_in_us_1
+		 *  - Delta for FLOOR: delta_from_mid_point_in_us_2
 		 */
-		if ((frame_time_in_us / mid_point_frames_ceil) > in_out_vrr->min_duration_in_us &&
-				(delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2 ||
-						mid_point_frames_floor < 2)) {
+		if ((last_render_time_in_us / mid_point_frames_ceil) < in_out_vrr->min_duration_in_us) {
+			/* Check for out of range.
+			 * If using CEIL produces a value that is out of range,
+			 * then we are forced to use FLOOR.
+			 */
+			frames_to_insert = mid_point_frames_floor;
+		} else if (mid_point_frames_floor < 2) {
+			/* Check if FLOOR would result in non-LFC. In this case
+			 * choose to use CEIL
+			 */
+			frames_to_insert = mid_point_frames_ceil;
+		} else if (delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2) {
+			/* If choosing CEIL results in a frame duration that is
+			 * closer to the mid point of the range.
+			 * Choose CEIL
+			 */
 			frames_to_insert = mid_point_frames_ceil;
-			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_2 -
-					delta_from_mid_point_in_us_1;
 		} else {
+			/* If choosing FLOOR results in a frame duration that is
+			 * closer to the mid point of the range.
+			 * Choose FLOOR
+			 */
 			frames_to_insert = mid_point_frames_floor;
-			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_1 -
-					delta_from_mid_point_in_us_2;
 		}
 
 		/* Prefer current frame multiplier when BTR is enabled unless it drifts
 		 * too far from the midpoint
 		 */
+		if (delta_from_mid_point_in_us_1 < delta_from_mid_point_in_us_2) {
+			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_2 -
+					delta_from_mid_point_in_us_1;
+		} else {
+			delta_from_mid_point_delta_in_us = delta_from_mid_point_in_us_1 -
+					delta_from_mid_point_in_us_2;
+		}
 		if (in_out_vrr->btr.frames_to_insert != 0 &&
 				delta_from_mid_point_delta_in_us < BTR_DRIFT_MARGIN) {
 			if (((last_render_time_in_us / in_out_vrr->btr.frames_to_insert) <
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
