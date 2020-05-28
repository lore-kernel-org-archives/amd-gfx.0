Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ECEC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC65B206DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa2YZUwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC65B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BA96E802;
	Thu, 28 May 2020 21:35:46 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF066E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 21:35:43 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id b27so410350qka.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WPfX3Bk1QbG3V5AMtYKNZWP23zt5qGOSUhcrMaDIimw=;
 b=Fa2YZUwgdlZwbSgSCDOky7jaOQ70PZDjep1ktfFP5o6u5etkMgxwi7m/FGiDHHal39
 dKX13Y4UEbZ6zfwzyreSyHb7CLpSkBMB0nrM1PMUW1QidDLUGzK4pg3NBRuP4dE6ngwB
 Vee8D6mbP2UJ1dyM5TJ3XEGzHd0yinrOq4rf+pNBRzQd0XzeQtuavHH0/p/pMs1VYrz4
 Qu1u7cGrfL43laD2EeZ02RxnUJ7WKfGoaFH5quthyXP5+4S1wpbmQ9netpXdpMpc+b2C
 3tNhz0NqVqZ8NNE098w7+9g5lP3FChvWvuL4C1Ysck/Rfo52AMdQbzAjwtzIbjT2tbFC
 FkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WPfX3Bk1QbG3V5AMtYKNZWP23zt5qGOSUhcrMaDIimw=;
 b=HghBeEXzeD/CW4SAu7M9HxNbtsX5mC6gs+fXd83NCRt07vDsg00AGTCXf58qghw1dz
 YtGsI2+LwNp9SwA4/iFFdzSVqN/oX+qq0+pqdvokP/HxxJ0h1dkMnGHqQmeUEdl7oW5N
 hC/q/3lNtemELsYIn6j6FcAtX5JvUOXHzXnNT8EyEAM2PwPf/1sDTWkCXKX4UErNoyvD
 bQYIS9i71Pasvx923Nh0nzQuB7nnVZ95n01n1tOLhhfd5QMCfGQvkFkz7IDbHsJgd1Nq
 otGQgcbX5eWQdwJLPVQxvIod1WOn9ic8uBYoXyIDKrO0/G/kkswYdfZ8KQ5uCN5AXltG
 zlfw==
X-Gm-Message-State: AOAM532nScnIxWAMyrWOYGq4RM96fqYXCj1OVu2yI6DLUiTJ5+x/EIjn
 uRip0ehOVsXzW8Ulk56Eo+XKflbg
X-Google-Smtp-Source: ABdhPJxeiSsVkGOlc6/nk1cpjTqYint0sXMMeTsc1kUNf3yuFq5C/SQRnit/gvoxqx2YDiTQuhrFVA==
X-Received: by 2002:a37:6590:: with SMTP id z138mr5172999qkb.202.1590701742543; 
 Thu, 28 May 2020 14:35:42 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k43sm7027851qtk.67.2020.05.28.14.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 14:35:42 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdgpu/nv: enable init reset check
Date: Thu, 28 May 2020 17:35:29 -0400
Message-Id: <20200528213529.673145-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528213529.673145-1-alexander.deucher@amd.com>
References: <20200528213529.673145-1-alexander.deucher@amd.com>
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

gpu reset is implemented for navi so we can enable this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 0f927fcff0d5..fd3b9e21a5bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -41,6 +41,7 @@
 #include "hdp/hdp_5_0_0_offset.h"
 #include "hdp/hdp_5_0_0_sh_mask.h"
 #include "smuio/smuio_11_0_0_offset.h"
+#include "mp/mp_11_0_offset.h"
 
 #include "soc15.h"
 #include "soc15_common.h"
@@ -514,7 +515,6 @@ static bool nv_need_full_reset(struct amdgpu_device *adev)
 
 static bool nv_need_reset_on_init(struct amdgpu_device *adev)
 {
-#if 0
 	u32 sol_reg;
 
 	if (adev->flags & AMD_IS_APU)
@@ -526,8 +526,7 @@ static bool nv_need_reset_on_init(struct amdgpu_device *adev)
 	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
 	if (sol_reg)
 		return true;
-#endif
-	/* TODO: re-enable it when mode1 reset is functional */
+
 	return false;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
