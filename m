Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A7C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 11:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B941961B31
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 11:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B941961B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877786E7D9;
	Thu,  9 Sep 2021 11:52:14 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEED76E7D9;
 Thu,  9 Sep 2021 11:52:11 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFE0961B2C;
 Thu,  9 Sep 2021 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631188331;
 bh=NFrGmOjQVLMvV/HpF5LMSqtHkHIDEbEEUZZB9yULr2g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XFuiyUEa8Tgw0/Y5l+MMC6j0/UhxIEWQUsinYyAyIp/Ki9VKAEV3fzgAHvMidp+XL
 aPk1AdlUbGVHhW/1eEzIekgHr3BwFVf+74VLAmpon9TeCjH7sGU/lloZ84mELPECk9
 CCnskyOJgMoRckZfZDW4D0GgrbdvJ/5+StyrWvsGhGRgdonUdGoMDRAMODBmL2UdyV
 VlLKrp49CKezDGHG245xP1eCx9Ey7f8x1oGRQ2jzuVTXr03pFFXZR/MNMKWcub87tk
 H/hiuW7m9qGClhNc0z2E+zsW7TIqCqKAZnQ2yhsL3iqRlR6E/0dhtqJP32oXOOdA6x
 +AuDtGhlXJs0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anson Jacob <Anson.Jacob@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 041/176] drm/amd/amdgpu: Update debugfs
 link_settings output link_rate field in hex
Date: Thu,  9 Sep 2021 07:49:03 -0400
Message-Id: <20210909115118.146181-41-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909115118.146181-1-sashal@kernel.org>
References: <20210909115118.146181-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anson Jacob <Anson.Jacob@amd.com>

[ Upstream commit 1a394b3c3de2577f200cb623c52a5c2b82805cec ]

link_rate is updated via debugfs using hex values, set it to output
in hex as well.

eg: Resolution: 1920x1080@144Hz
cat /sys/kernel/debug/dri/0/DP-1/link_settings
Current:  4  0x14  0  Verified:  4  0x1e  0  Reported:  4  0x1e  16  Preferred:  0  0x0  0

echo "4 0x1e" > /sys/kernel/debug/dri/0/DP-1/link_settings

cat /sys/kernel/debug/dri/0/DP-1/link_settings
Current:  4  0x1e  0  Verified:  4  0x1e  0  Reported:  4  0x1e  16  Preferred:  4  0x1e  0

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index e02a55fc1382..fbb65c95464b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -197,29 +197,29 @@ static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
 
 	rd_buf_ptr = rd_buf;
 
-	str_len = strlen("Current:  %d  %d  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Current:  %d  %d  %d  ",
+	str_len = strlen("Current:  %d  0x%x  %d  ");
+	snprintf(rd_buf_ptr, str_len, "Current:  %d  0x%x  %d  ",
 			link->cur_link_settings.lane_count,
 			link->cur_link_settings.link_rate,
 			link->cur_link_settings.link_spread);
 	rd_buf_ptr += str_len;
 
-	str_len = strlen("Verified:  %d  %d  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Verified:  %d  %d  %d  ",
+	str_len = strlen("Verified:  %d  0x%x  %d  ");
+	snprintf(rd_buf_ptr, str_len, "Verified:  %d  0x%x  %d  ",
 			link->verified_link_cap.lane_count,
 			link->verified_link_cap.link_rate,
 			link->verified_link_cap.link_spread);
 	rd_buf_ptr += str_len;
 
-	str_len = strlen("Reported:  %d  %d  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Reported:  %d  %d  %d  ",
+	str_len = strlen("Reported:  %d  0x%x  %d  ");
+	snprintf(rd_buf_ptr, str_len, "Reported:  %d  0x%x  %d  ",
 			link->reported_link_cap.lane_count,
 			link->reported_link_cap.link_rate,
 			link->reported_link_cap.link_spread);
 	rd_buf_ptr += str_len;
 
-	str_len = strlen("Preferred:  %d  %d  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Preferred:  %d  %d  %d\n",
+	str_len = strlen("Preferred:  %d  0x%x  %d  ");
+	snprintf(rd_buf_ptr, str_len, "Preferred:  %d  0x%x  %d\n",
 			link->preferred_link_setting.lane_count,
 			link->preferred_link_setting.link_rate,
 			link->preferred_link_setting.link_spread);
-- 
2.30.2

