Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E158C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 22:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E06B2078C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 22:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6Oe7ste"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E06B2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE596EB72;
	Fri, 20 Mar 2020 22:03:10 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A4A6EB72
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 22:03:09 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id j4so8668449qkc.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S1Rp6jxDEfO+zeYEZ/1d9nBsj3M0sAX6dK5xSwMnqzs=;
 b=t6Oe7stela0gX6MAPCVoZbuFf+WyASrL+HY/7a/VianWNIeHuK6uJX6jGK91EMiGK+
 rImijmGcNHbsrdXtKT0Eg1DdT1+BU57ZRTt2BWtsI/AqaeJPD6JAPiaqAINndpi1rWWA
 QLQfp5udiEr9WiWIN1MbecExBylqufHEaolxQXrg3c4w6Y7OAbPbJw/qqGImmUpLM315
 K724AWUPfluVXkyVdbL88j6fu382bueVZ26tUPa+WhLO3NFiT9DsGr4TUgxnmBTEDrU0
 lOUhhJO38z2o8KTmI3eBKADy9r9rc7Q3aTrxx70SKR2uyGOche65U38pTcFdlUiRYBQo
 x1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S1Rp6jxDEfO+zeYEZ/1d9nBsj3M0sAX6dK5xSwMnqzs=;
 b=hrhGBXhTtWIBTOvHBYNjRFTUtIedWYLT3McZSR5TkhF4uUXtWeX4AAFLG9+4fIJ43o
 tmMbdhmv1YrxCFcaGwKJpAQzc7unZNEM2ulOZXwTUoHbHhQM+ioUWp/cmZ9GNGLbYqi+
 Ofwnp9JsSZe3rbXUSlKGZuB1hCYZFnivwa0l7ZZcuq49LI/YA8yctY2Wirul/1rKOs9O
 bIeBvwuVHeixJrI3aH+UlUj2sMNQ2Tr/YrH63vRd/RqMQIRo6u38mxwF3EQo2lcVggrb
 s9onEE+w2s/d/5oyUpwjCyuyScmflv1mVhwipiinFS1KL70p9tNCWeZVC90KbHorfROh
 R9wg==
X-Gm-Message-State: ANhLgQ1krI3wTiRtrVbDD0QXJktCyXOgjVP9j1WGCMeTTphDgkIL/yk5
 /p52cjpYR3cxKi1wW7uja1oNC4Nv
X-Google-Smtp-Source: ADFU+vtqBsWAJfjTCn7nL/hNVEZBxF7j81hxKPP6GWo7k1u1CXMjMczuY6rDKWisPOGSBsj2bsPUxg==
X-Received: by 2002:a37:702:: with SMTP id 2mr10195728qkh.134.1584741787827;
 Fri, 20 Mar 2020 15:03:07 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id r10sm5099919qkm.23.2020.03.20.15.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 15:03:07 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu/swSMU: set AC/DC mode based on the current
 system state (v2)
Date: Fri, 20 Mar 2020 18:02:48 -0400
Message-Id: <20200320220248.22501-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mcoffin13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check of the pointer exists and we are actually on AC power.

v2: fix error message to reflect AC/DC mode.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 2cfb911ab370..9a9eb23d8540 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1155,17 +1155,17 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 			}
 		}
 
-		if (adev->asic_type >= CHIP_NAVI10 &&
-		    adev->asic_type <= CHIP_NAVI12) {
+		if (smu->ppt_funcs->set_power_source) {
 			/*
 			 * For Navi1X, manually switch it to AC mode as PMFW
 			 * may boot it with DC mode.
-			 * TODO: should check whether we are indeed under AC
-			 * mode before doing this.
 			 */
-			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
+			if (adev->pm.ac_power)
+				ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
+			else
+				ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
 			if (ret) {
-				pr_err("Failed to switch to AC mode!\n");
+				pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
 				return ret;
 			}
 		}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
