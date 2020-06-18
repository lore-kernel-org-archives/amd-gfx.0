Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F99C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 01:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACEF2193E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 01:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnVJ46bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACEF2193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD9F6EA38;
	Thu, 18 Jun 2020 01:15:12 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E376E388;
 Thu, 18 Jun 2020 01:15:10 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B7BD4221ED;
 Thu, 18 Jun 2020 01:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442910;
 bh=21amvfPGX3hDybz2dRXi+ckX1IpZeShBQQLLp7v3wQM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DnVJ46bFKVS9PRyMS+MKqgFFv5Rw74IdNnUMm10xMfvfX5WC9QrMGTwvNjMFnbDhK
 smKe97Zets8J4ysvnBx51cu+8G+XqeenZNAFgoFXBdjOb/O6dqYAt7D1/TqbtbA+i9
 ZnyaGJ5TOmosZ91oytSH6P2AEzud+yqOTSDM22mI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 329/388] drm/amd/display: Revalidate bandwidth
 before commiting DC updates
Date: Wed, 17 Jun 2020 21:07:06 -0400
Message-Id: <20200618010805.600873-329-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
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
 Hersen Wu <hersenxs.wu@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit a24eaa5c51255b344d5a321f1eeb3205f2775498 ]

[Why]
Whenever we switch between tiled formats without also switching pixel
formats or doing anything else that recreates the DC plane state we
can run into underflow or hangs since we're not updating the
DML parameters before committing to the hardware.

[How]
If the update type is FULL then call validate_bandwidth again to update
the DML parmeters before committing the state.

This is basically just a workaround and protective measure against
update types being added DC where we could run into this issue in
the future.

We can only fully validate the state in advance before applying it to
the hardware if we recreate all the plane and stream states since
we can't modify what's currently in use.

The next step is to update DM to ensure that we're creating the plane
and stream states for whatever could potentially be a full update in
DC to pre-emptively recreate the state for DC global validation.

The workaround can stay until this has been fixed in DM.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 47431ca6986d..4a619328101c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2517,6 +2517,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
 
+	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+		DC_ERROR("Mode validation failed for stream update!\n");
+		dc_release_state(context);
+		return;
+	}
+
 	commit_planes_for_stream(
 				dc,
 				srf_updates,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
