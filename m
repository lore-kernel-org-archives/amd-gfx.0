Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5928DC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEB02073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJbQ5XlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEB02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69B16E330;
	Mon,  1 Jun 2020 18:22:05 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD446E330
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:03 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id k22so8471246qtm.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e9pFqXjO9M/Lpe9Ia/vNg3WdApJV3WwoiXSqeZFBonk=;
 b=dJbQ5XlREjqUJbzrXdZUqhhR529ozXpZ+YlT2J1v1iD9wQYlFslRFWEpZJikoX4+Qm
 vjT+YJNtlGkSYu2FAeZvuhxeFS+1lCQQmLLJ5OfFMr69xYTjnUzIn24c5wrAsZhJ2dfr
 00WXec0Wx2yIPBpkgxRJ10/RYHf3txVmOvVPZiDEwZtr5FmNkn5z1ljqn+1vLRapFvso
 7rYNnrXwYKvftc/yLDwdgIHE7uA9IU6VurTWKaBMjHqTgNdhzz+I8Y50ZbPbaxh2N+rX
 69CDWbvBibFzj0L9SUtxj0uXcA2JRdTCKRwXnhvtbt75FOv3sqQ/5Cy8Iu92uuJagn2F
 o9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e9pFqXjO9M/Lpe9Ia/vNg3WdApJV3WwoiXSqeZFBonk=;
 b=Y7ng07yJsr28U2n8uBW51JNULnQuE2NWG/dtlsb1cxmPW4KEhJBXxE3/MOgTr3CpZD
 Bc2j4tNoQJWecXbWJguMa/cv2EoU3HF4dhMDYGAvPFsSqsv777USLKIkJQdoVvDmGyHs
 qAjMFuW+ATbNA1IWyepN25qCunJWuMkdhUXOsiDrOjoDSeafVFW67kBU6/1SWIwjGxY4
 ukNkCtswAp1NOemd9RY9PUP7VgjLgc2bRTJgvCK+nURescxU+0cAqbCpLrAQ7X51cZpY
 LmtXvZ+gS402rCBl9Lw5LtAI2ofrPL+4jENV88npxQ6FMiJgIGSCT/P7wssr2ANdTSU0
 YUxA==
X-Gm-Message-State: AOAM532LEWAhUhKeioUA2IyG08wXb0eO0KQ6QOpKtX+XbWSfuWEyfZpR
 +c+JH9aAUgeU+6r7UmEy/nvw3WDS
X-Google-Smtp-Source: ABdhPJy0VG9ShOWPbi+HMdlh8zwYI15BP2nsm0Dqga6FjIRo4K5dR4KSMpa9GBpe8BRdpAobmterFg==
X-Received: by 2002:aed:21af:: with SMTP id l44mr24134180qtc.124.1591035722914; 
 Mon, 01 Jun 2020 11:22:02 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:02 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 135/207] drm/amd/powerplay: enable GPO
Date: Mon,  1 Jun 2020 14:19:42 -0400
Message-Id: <20200601182054.1267858-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

GPO is graphics power optimizer.
SMU calculates the 16 gfxclk V/F points according to the CU numbers
and memory activity.RLC picks one of them according to the memory
speed requirements for the data transmission.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h      | 1 +
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
index 3efadf2cff9c..dff2295705be 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
@@ -260,6 +260,7 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(MMHUB_PG),                      	\
        __SMU_DUMMY_MAP(ATHUB_PG),                      	\
        __SMU_DUMMY_MAP(APCC_DFLL),                     	\
+       __SMU_DUMMY_MAP(DPM_GFX_GPO),                    \
        __SMU_DUMMY_MAP(WAFL_CG),
 
 #undef __SMU_DUMMY_MAP
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 8fb08cae5c24..9dbf29e96312 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -126,6 +126,7 @@ static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] =
 static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_feature_mask_map[SMU_FEATURE_COUNT] = {
 	FEA_MAP(DPM_PREFETCHER),
 	FEA_MAP(DPM_GFXCLK),
+	FEA_MAP(DPM_GFX_GPO),
 	FEA_MAP(DPM_UCLK),
 	FEA_MAP(DPM_SOCCLK),
 	FEA_MAP(DPM_MP0CLK),
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
