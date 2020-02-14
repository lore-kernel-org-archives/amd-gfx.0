Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FA4C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A522465D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1e/T+Gz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A522465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01FAA6F99A;
	Fri, 14 Feb 2020 15:52:05 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3A96F999;
 Fri, 14 Feb 2020 15:52:02 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 758C124684;
 Fri, 14 Feb 2020 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581695522;
 bh=D+neHKbsagbM5gghZjxhAp0OTvWEr6J3imn19Va7XuQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1e/T+Gz9JXIQclfWZgS8aVvOzJgCExb2X6PTxKeu8VmwodK1DHnYHwGMBho/Vcvjq
 GPs6Ut4IpEiOP64ph17IbGbVCC+v3PdV/eIXjyhHbViYq8tZbzg7yEo5HUIKenV7cY
 KLqkSd81mHc3JsDHBIaWYz5QM49ZICIyrSXc9mFg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 144/542] drm/amd/powerplay: remove set but not
 used variable 'vbios_version', 'data'
Date: Fri, 14 Feb 2020 10:42:16 -0500
Message-Id: <20200214154854.6746-144-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit cb7709223b39287a020e92ff880d11d377dc53a1 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c: In function smu7_check_mc_firmware:
drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:4215:11: warning: variable vbios_version set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c: In function smu7_get_performance_level:
drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:5054:21: warning: variable data set but not used [-Wunused-but-set-variable]

'vbios_version' is introduced by commit 599a7e9fe1b6 ("drm/amd/powerplay:
implement smu7 hwmgr to manager asics with smu ip version 7."),
but never used, so remove it.

'data' is introduced by commit f688b614b643 ("drm/amd/pp:
Implement get_performance_level for legacy dgpu"), but never used,
so remove it.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index f73dff68e7999..f754fbd70f687 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4238,7 +4238,6 @@ static int smu7_check_mc_firmware(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
-	uint32_t vbios_version;
 	uint32_t tmp;
 
 	/* Read MC indirect register offset 0x9F bits [3:0] to see
@@ -4247,7 +4246,6 @@ static int smu7_check_mc_firmware(struct pp_hwmgr *hwmgr)
 	 */
 
 	smu7_get_mc_microcode_version(hwmgr);
-	vbios_version = hwmgr->microcode_version_info.MC & 0xf;
 
 	data->need_long_memory_training = false;
 
@@ -5077,13 +5075,11 @@ static int smu7_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_hw
 				PHM_PerformanceLevel *level)
 {
 	const struct smu7_power_state *ps;
-	struct smu7_hwmgr *data;
 	uint32_t i;
 
 	if (level == NULL || hwmgr == NULL || state == NULL)
 		return -EINVAL;
 
-	data = hwmgr->backend;
 	ps = cast_const_phw_smu7_power_state(state);
 
 	i = index > ps->performance_level_count - 1 ?
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
