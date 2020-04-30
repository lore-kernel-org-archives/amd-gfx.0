Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C0C47253
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4F920787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGzl/Qle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4F920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4E66E947;
	Thu, 30 Apr 2020 18:37:34 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACD16E955
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 18:37:32 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id l78so6807036qke.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 11:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qtDlzr4Lrl3R5Pcg3gHiMyGdDQbCGHQevLIUqI7/Z3o=;
 b=qGzl/QleThH1KyAPKe6N5Z1OpN+FxIOX+3jQBNl66pCaqtRUROaGBhkfXn/Fv0QAIh
 iNG0MI9NhU7kWxQPYhaZpnzIC2Gum9Q70P79fOzeHQQ4Ay95DPXBIOs/6HRTHgsayiVF
 rO8Kc1krrq0K1rz29sQuMWKBPAq/ryxZXzAtME+IsvQpxQoJLvh2ocw9js0baP2AnmcF
 CgFRiPScj8TK4XIIvapiXzfOUqiOZDRLOrskqfE+Xx1UyKiG7MD3Zh2rxt1LIrx+lt+H
 1AnC3nMLv7JvamG0TWexSuDtNxbQcpKpYkrGgSknnhYklyXbUd5CTeJK/5LDBEYqo8GH
 LSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qtDlzr4Lrl3R5Pcg3gHiMyGdDQbCGHQevLIUqI7/Z3o=;
 b=cXG5QqBjk8AEfgL/cUPMfuOUi3p972dbre8jEnBEutph5Y2lLqQv5K8ZtDNunWG4U5
 DyIGVFocBfObP5bAsNSw0440XxwXrTkBRK9p67ofsQVOgFo/WuJsCseU9fxky0Dfz8R4
 ZpRYcoimapad/OyxyKWp7zOcVuV0cFbZ7YRj9mRa2ABxQAPpiQgPpq0ho2iWfR8TQB2h
 W/QuvFEnV9ULsuXO/tsmFevNGbhYoY2QiF86sRVr0Cm4pcZ2pChrcV96hNZ1U0lAGftH
 MhumMExHiY7mwgiaAuf41yLVMofH2v30zWPfP8eig6kPJlB+nJNGj5DZKmHGwzCiIsRj
 qo+g==
X-Gm-Message-State: AGi0PuYqLSL7RLsCsoyuEInqyQXrKI7b0BkLCcfhmwrHaavVclNDYcNT
 361QeYYpFZcSdTEyy8jaSi4ogp9H
X-Google-Smtp-Source: APiQypI+OpiUXL9ZiJDb9wHqpM1Jl7F93qPNbCzvyd2HWUNqra6gtT6Sv0ve93KaGX/GWYX4Of9pmw==
X-Received: by 2002:a37:a60c:: with SMTP id p12mr5003459qke.430.1588271851879; 
 Thu, 30 Apr 2020 11:37:31 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c139sm693510qkg.8.2020.04.30.11.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:37:31 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/amdgpu: check SMU NULL ptr on gfx hw init
Date: Thu, 30 Apr 2020 14:37:13 -0400
Message-Id: <20200430183719.419549-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200430183719.419549-1-alexander.deucher@amd.com>
References: <20200430183719.419549-1-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Check SMU NULL ptr before load smu fw.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 63ac4308b9c4..20258c5d335f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6540,14 +6540,16 @@ static int gfx_v10_0_hw_init(void *handle)
 		 * loaded firstly, so in direct type, it has to load smc ucode
 		 * here before rlc.
 		 */
-		r = smu_load_microcode(&adev->smu);
-		if (r)
-			return r;
+		if (adev->smu.ppt_funcs != NULL) {
+			r = smu_load_microcode(&adev->smu);
+			if (r)
+				return r;
 
-		r = smu_check_fw_status(&adev->smu);
-		if (r) {
-			pr_err("SMC firmware status is not correct\n");
-			return r;
+			r = smu_check_fw_status(&adev->smu);
+			if (r) {
+				pr_err("SMC firmware status is not correct\n");
+				return r;
+			}
 		}
 	}
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
