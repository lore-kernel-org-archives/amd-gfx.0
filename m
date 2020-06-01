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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73777C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5FB2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAWp7Ogk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5FB2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C6F6E365;
	Mon,  1 Jun 2020 18:22:39 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6AD06E365
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:37 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id c12so9964179qkk.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=obrJQPfHGcHU1XcM2gVAhLndmMVjxMkLjBYQA62u5Jk=;
 b=pAWp7Ogk7dFvce6fNe0o3zyltF9bwa2B83pIfuxybDhaB4u/VzHEN9LtMi+TiM7yyf
 qfJoTgp6W9qcJIerraiT0Q8ATxFdkApCxibwxRb2pvEYnbyeu4cR1i9NaZr9f86eMM1e
 lf1kOwlQy0SCXY+XNaC51pXySn62CFNe5q7NKduR0b548kZvot2C6CmY7P2lKYcOq2nj
 9ruFD3Q6C6TSHXdh9VyveL2Bj5rismkvjCXRdPmZePK4PPyFESpzm322PIS7aIhY8u+w
 TAF+uRMp44GdU+m/DhcxoqGPaOVn8KAEqQCLwaykbRdQNzS5pifwiM0W/XhIbBBcmEBM
 eptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=obrJQPfHGcHU1XcM2gVAhLndmMVjxMkLjBYQA62u5Jk=;
 b=XvwCQiN8tkW9CgbVWa0FT/wgFuEnFt3dvOEmWSUfeMv08EeKhs2YmeJ8QK9bvqwK30
 QcLkpmvQ6DKrolO+xpBno+PpgS1jfSF4hEWmnFEJKD6HOW5WqlT0YdWaV+Vwda47sP/k
 UJ71PRztEuIZyjXKGXfpXQSUr6dCnsU7I20DzRlZQgTkW4fuJRe5tMB9A5eU/3A2jXPm
 74ne9YejbZNVzG8vlrdKfVNTsAvQ/ufmjg2z9ZeienFovXE+l53W2jY8GfU9MAKsDfWy
 v6b0wsqoXuOIECfkuhaaEBoENL41+SRNhlAoe5dKHbZJKzuVqzAyp/JirQwWfgbTeHbt
 V3Aw==
X-Gm-Message-State: AOAM530howcLzJbG9wg21oTlTjbX7g2h1Ps9jf6jaLhzddWaaSfQQs80
 6EC3S3qtYW40nM/YyG/97au2qMVy
X-Google-Smtp-Source: ABdhPJyxq1gWP7KhKLhNi1kd7+uw6BE70h+kVU5TriuPtRtjX+twhSKFJ4s+m+WRirq9tQkDDrNeiw==
X-Received: by 2002:a37:a511:: with SMTP id o17mr21650958qke.141.1591035756900; 
 Mon, 01 Jun 2020 11:22:36 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 161/207] drm/amd/powerplay: drop jpeg instance1 dpm setup
Date: Mon,  1 Jun 2020 14:20:08 -0400
Message-Id: <20200601182054.1267858-72-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

VCN removed JPEG for instance 1, so drop jpeg instance1 dpm setup.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 512fa07ab2b2..667c912e47fd 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -645,9 +645,6 @@ static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enab
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
 			if (ret)
 				return ret;
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0x10000, NULL);
-			if (ret)
-				return ret;
 		}
 		power_gate->jpeg_gated = false;
 	} else {
@@ -655,9 +652,6 @@ static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enab
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0x10000, NULL);
-			if (ret)
-				return ret;
 		}
 		power_gate->jpeg_gated = true;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
