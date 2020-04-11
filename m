Return-Path: <SRS0=mFKL=53=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C5FC2BBC7
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 23:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5898B20CC7
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 23:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVIYHio2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5898B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6426A6E15D;
	Sat, 11 Apr 2020 23:04:18 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C932F6E156;
 Sat, 11 Apr 2020 23:04:16 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D8315214D8;
 Sat, 11 Apr 2020 23:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586646256;
 bh=b9PSEA+YG/1WY21aDwSoSP7Lj/mwh9DIxAkoaspyNac=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cVIYHio23RN4BzYBpS9VtpxCDtuSlMVnIDGUz1V2B8PouGi3q4w2ZmdY2+CM361RB
 +VRyIHFPRiQvsUE6j0gXo/of6n4w7bQCLiXdC2B3iVoBVOBFywdwJ3tR98SiFvPu3/
 dGqCBNl5tw4soaBdCo+l1unDZ/Eq64nXNjhcdgsg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 023/149] drm/amdgpu: check GFX RAS capability
 before reset counters
Date: Sat, 11 Apr 2020 19:01:40 -0400
Message-Id: <20200411230347.22371-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
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
 Monk Liu <monk.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

[ Upstream commit 06dcd7eb83ee65382305ce48686e3dadaad42088 ]

disallow the logical to be enabled on platforms that
don't support gfx ras at this stage, like sriov skus,
dgpu with legacy ras.etc

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Monk Liu <monk.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 889154a78c4a8..beba9c596c493 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6326,6 +6326,9 @@ static void gfx_v9_0_clear_ras_edc_counter(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return;
+
 	/* read back registers to clear the counters */
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index f099f13d7f1e9..9955532345ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -897,6 +897,9 @@ void gfx_v9_4_clear_ras_edc_counter(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return;
+
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_4_edc_counter_regs); i++) {
 		for (j = 0; j < gfx_v9_4_edc_counter_regs[i].se_num; j++) {
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
