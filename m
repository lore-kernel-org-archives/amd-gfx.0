Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45521C2D0C4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A52F20652
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdn1ehEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A52F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591DB6E971;
	Tue, 10 Dec 2019 21:17:27 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD3C6E974;
 Tue, 10 Dec 2019 21:17:23 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 04A522468E;
 Tue, 10 Dec 2019 21:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576012075;
 bh=R3MtLN1Rj4wCOGDlYX0wo0g3yFmfhogzVgnOrcaB29Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bdn1ehEhzZgeJSGnJm49W5hpc9b23gpjFBw+FoDcPqLXu4kfALMKe2Drrw9T5Mu6i
 n7IGjLTINvjEsVRN+4fN83xmwbIdov16JsBI/T4z6joLE/wQ/lgRfZCuUtBfUEHzQI
 XWXLp1A46Z18+vXK5fxeXGH1641Hh03xeUo5AUK4=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 055/350] drm/amd/powerplay: A workaround to GPU
 RESET on APU
Date: Tue, 10 Dec 2019 16:02:40 -0500
Message-Id: <20191210210735.9077-16-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, chen gong <curry.gong@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: chen gong <curry.gong@amd.com>

[ Upstream commit 068ad870bbd8f4f2c5b2fd4977a4f3330c9988f4 ]

Changes to function "smu_suspend" in amdgpu_smu.c is a workaround.

We should get real information about if baco is enabled or not, while we
always consider APU SMU feature as enabled in current code.

I know APU do not support baco mode for GPU reset, so I use
"adev->flags" to skip function "smu_feature_is_enabled".

Signed-off-by: chen gong <curry.gong@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4acf139ea0140..58c091ab67b26 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1344,7 +1344,10 @@ static int smu_suspend(void *handle)
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
-	bool baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
+	bool baco_feature_is_enabled = false;
+
+	if(!(adev->flags & AMD_IS_APU))
+		baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
 
 	ret = smu_system_features_control(smu, false);
 	if (ret)
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
