Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D174FC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63412077B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2pEo0erx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63412077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C877A6E987;
	Tue, 10 Dec 2019 21:17:30 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3516E97D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 21:17:23 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ED99F246A5;
 Tue, 10 Dec 2019 21:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576012152;
 bh=tuAaTuL8euIcbGtYBkcietDdMq711xgJAVedFgWRTR4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=2pEo0erx/FZPIVgCRRxr+b5XY38Qh+/f9bcyZBgkKfasVuvtUJwJYZQA3Hol7uj5d
 ziS24lXub72Lbadix4sYcGNmt/pHPgvsghGWYfwoysAVAG2Hxf838klw+jMyoxTvlm
 ltAJT8o750VCwaTj7+9dKzlErapqizuxLoodV6SQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 115/350] drm/amd/powerplay: avoid disabling ECC if
 RAS is enabled for VEGA20
Date: Tue, 10 Dec 2019 16:03:40 -0500
Message-Id: <20191210210735.9077-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
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
 Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

[ Upstream commit df9331e561dab0a451cbd6a679ee88a95f306fd6 ]

Program THM_BACO_CNTL.SOC_DOMAIN_IDLE=1 will tell VBIOS to disable ECC when
BACO exit. This can save BACO exit time by PSP on none-ECC SKU. Drop the setting
for ECC supported SKU.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c
index df6ff92524011..b068d1c7b44d2 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c
@@ -29,7 +29,7 @@
 #include "vega20_baco.h"
 #include "vega20_smumgr.h"
 
-
+#include "amdgpu_ras.h"
 
 static const struct soc15_baco_cmd_entry clean_baco_tbl[] =
 {
@@ -74,6 +74,7 @@ int vega20_baco_get_state(struct pp_hwmgr *hwmgr, enum BACO_STATE *state)
 int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	enum BACO_STATE cur_state;
 	uint32_t data;
 
@@ -84,10 +85,11 @@ int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state)
 		return 0;
 
 	if (state == BACO_STATE_IN) {
-		data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
-		data |= 0x80000000;
-		WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
-
+		if (!ras || !ras->supported) {
+			data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
+			data |= 0x80000000;
+			WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
+		}
 
 		if(smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_EnterBaco, 0))
 			return -EINVAL;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
