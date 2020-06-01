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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3F8C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834DA2077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGNSgPnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834DA2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE136E26C;
	Mon,  1 Jun 2020 18:03:33 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7EA86E26C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:31 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id s1so9925685qkf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FmMhmvkNUU9BIhg17AUH/d/FOC7PFTb/Q1C68DWcT8Y=;
 b=jGNSgPnP7PjpHbm6k9iUafNW5aYq+srbQeycqHADN5AbwtDs48IlU7ancIYOxUe2Lu
 +kpsSEUYOU1W/TgDtgBBHH3ESTfntwhBvKnl359Z3nbRWi4Z6R+nVsYplilGR32G8tBY
 4Ootqbr/QKZNN6Ysk2Fot4CyEGq+gXK09MghG/XZLgthZZQcs675zX7dWpYT8AlYYGBv
 bEj52y7Kkp/2yBgAzd7ICorspjCDndaI/nV5rFcOLWpj9j0//9ujAhMieLBVozbkDAEa
 6tP2pOyykdA9k4INp4epfVGuk4fTp1bm1eSmcxBnVuZjxjP9lcx+n1anuxCrEid1uDtl
 n9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FmMhmvkNUU9BIhg17AUH/d/FOC7PFTb/Q1C68DWcT8Y=;
 b=plBZMJ4Uajb5WzOYSAcGp98iWITvnaH13d+4XUsiQWJS/ybiSsDDQhfJ02Ry4JSU2U
 1tg5uwoyqCxKrcTYgcKIjQYRu5mD5ycftCQrwXRIWu5JFWOaC2YllE78t6tRRFZ9XNTc
 /q5yT/WjCRCtF/2W7rWAUFOQiXXtH1pvEXf3Myq3aZqWBr8spdhRlytAoFfg+PU0UH0J
 V5kkRfDZpsbthLc9FBqgyuL00Cu/SuykYbSq2yMivxGUELiP/0wWtx1sKm7WpvlDM0UK
 9aeNobskGIgJbawNhJ/2keuk7dD9UtgS+Swv9m3B1v9XUu+IwXXH4KFi7P828cL3o+1j
 3dow==
X-Gm-Message-State: AOAM5306IYJOvpb2n97xVnnIvRh+haLChKOGNNZs0xZ5T9ETRnTJTXCX
 QjciUtCSAgguU33W/HBAaReikUFW
X-Google-Smtp-Source: ABdhPJwF13xNTmocqdJ3b0czmNHivLLSv374DDvVAfMB+l2p7cjSDu8OyA7k2Lxw9z/PHHet/7b2Eg==
X-Received: by 2002:a37:a152:: with SMTP id k79mr22664048qke.144.1591034610675; 
 Mon, 01 Jun 2020 11:03:30 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 029/207] drm/amd/powerplay: enable Ultra Low Voltage for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:41 -0400
Message-Id: <20200601180239.1267430-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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

Support Ultra Low Voltage for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index f1aeef79e204..75310858dc0c 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -277,6 +277,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
 
+	if (adev->pm.pp_feature & PP_ULV_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_ULV_BIT);
+
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
