Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E02C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 19:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE772072B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUF9c+9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE772072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DECC6E13A;
	Fri, 20 Dec 2019 19:57:33 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA106E13A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 19:57:32 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id n66so4010320ybg.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 11:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/uhc8GOB+NuC+0lWeHBZP+2nOdsFlOMpF+mhj3dKnpc=;
 b=uUF9c+9xwyS07r8nKpXxdZ6pBEO1ZN0vig0kNmzjCVcMMeflUxniKxsOaP5RDUmi99
 MB9KlI9OEPlFJYmK837yfDYbLtlvNRIdgrkC6dY1usDVAxygynnpaJ6HGM1faTuHh9/5
 JZ8KSUZGKJPT08vSocw8rdfY+7qDkwtMwq/+b7Lgoxq+X+oFqfXXxyX3RHiixod6jYIk
 a56TcSXGRS5yAWGzXGS97dKcLphICDOUZcQthleVasGBPxBQLWzTLyeF1Qs7Wmo6VrUc
 WteO/7oB/J+Mm7tkwiCBg+hrOC9YI2JsWl0chPBJYK1YzDRTdmuDsHPgsSGK8hA3HMuL
 itOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/uhc8GOB+NuC+0lWeHBZP+2nOdsFlOMpF+mhj3dKnpc=;
 b=Bb6Njg3KqLnVBzj0wSIBPAiABJYlooR2/yn+Tot+yVMoslzsXumFlOsuIZSSKMKts3
 wBzY3HzY08sCK89CBidcQw96nHyznWS8GOnHoTmszxCzXfRXQwga1Wbcf7kVttawy2XM
 XhpGk/qESdDZpF5zLoytxJolt/UPHba50WJTnF138Sw8OLtfWrIzZGIHrHig+edQ05al
 E0lSxzv38exi+KOTSAAVbk8uY6dv96ueT1GgylLvmxLolLXbHnGicI6fK3q7X0me8gmO
 8wqyp2DdKlArYoywg4CIVNFLynULjJV8X+iv/V6JIBPRwfMj0zyuxNmRTfKkjKu/Wr8C
 MCCg==
X-Gm-Message-State: APjAAAVLT/TXbIbvAuJ4RDkcZLzn044USQi2qRJ1TIgc5VICsA85gbyZ
 +mnT6awrn4zKotj4UB/AKl9I5J+M
X-Google-Smtp-Source: APXvYqwUyklgmgQQg5smWe0gohBmTJLGsXdN7QDylab6STe+LAbZcpQyMkW6fSjFLr+uhp/9QDYMrA==
X-Received: by 2002:a5b:d41:: with SMTP id f1mr2710946ybr.108.1576871851548;
 Fri, 20 Dec 2019 11:57:31 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id i127sm4348323ywe.65.2019.12.20.11.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 11:57:30 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/smu/navi: Adjust default behavior for peak sclk
 profile
Date: Fri, 20 Dec 2019 14:57:23 -0500
Message-Id: <20191220195723.1082294-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fetch the sclk from the pptable if there is no specified sclk for
the board.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index bf87e93b26fc..c33744a0d46b 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1587,7 +1587,7 @@ static int navi10_set_peak_clock_by_device(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	uint32_t sclk_freq = 0, uclk_freq = 0;
-	uint32_t uclk_level = 0;
+	uint32_t sclk_level = 0, uclk_level = 0;
 
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
@@ -1629,7 +1629,13 @@ static int navi10_set_peak_clock_by_device(struct smu_context *smu)
 		}
 		break;
 	default:
-		return -EINVAL;
+		ret = smu_get_dpm_level_count(smu, SMU_SCLK, &sclk_level);
+		if (ret)
+			return ret;
+		ret = smu_get_dpm_freq_by_index(smu, SMU_SCLK, sclk_level - 1, &sclk_freq);
+		if (ret)
+			return ret;
+		break;
 	}
 
 	ret = smu_get_dpm_level_count(smu, SMU_UCLK, &uclk_level);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
