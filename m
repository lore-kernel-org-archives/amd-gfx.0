Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16554C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8F82071A
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi1Xfmhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8F82071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DF0898AA;
	Tue, 31 Mar 2020 14:33:03 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23381898AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 14:33:03 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id o10so23115885qki.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wDlEbsFR9wfK8UYpijn60YjY4wV3laaXEWDjeLV5ric=;
 b=Xi1XfmhlvLcSAIGIn41KuXvSlAbce9Q+szCzyaHDYDdP16WyOSUDn8g5GvbE1bthbZ
 Ff5wPXuLmZ8OB2riDxy6EyCjQqLs8QgSy4dNQVM9SRe5viQbYm9vjKtyyud1chNOrofY
 GLEbWhacEhiJRFcpa10wKmLi7rLKSmmW5jU/wlgVu4b8ffoLCSoh/Kdkh3vTDYx2VV33
 CNDQHIDfSRbrnbD5MIpuxfaq2ONLzm99ZQPmNf4UEauuAnPnJZ3NW1EahsXCeS4Arh5j
 2Zo2e6YNyV4v090TcwoOh9f5NqaR/YPBmJ8M5PYwMi6xzF1cvySq0wvcrqEsSstH5/eL
 y51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wDlEbsFR9wfK8UYpijn60YjY4wV3laaXEWDjeLV5ric=;
 b=ejoonwqzmIr56yBFNmwLzHEcKaiQXrP237ykPqjiLwVM0uPTq6p9lL7dFtgBtgON8P
 MhOMJmnjJkxpCdDXiQxdGJVqqcQ9onecg8LCcw1wQ9+gmFZdyk8MUk7aGpShnqoVIvDk
 UuQUsei/IXSBiDu1EiC8DLv4A1v9PunktIGPwYCBtL7fqq3siWZaIfRZBZ55ERs8h8Rd
 VCEQkUSt6Jr0KHAA5YXTYg+sw50HgFyXY6yChSpgp2bHfO1uGdT2a7ArkuX+wNagceWN
 3JHJ2+cROz4jHRyQdcsnCbGRCG/DOMWHrYi0UplyrL5PAnKI7Pbd7RInO0TzOEBbJ6D6
 vU5g==
X-Gm-Message-State: ANhLgQ2/NljKHKgrYKA4AaIoGXH9enJN9ze5J9KmiGtLsUipeixiDno5
 MtAfdexLJztcsQtABorfJylAd8Uf
X-Google-Smtp-Source: ADFU+vvoOKEXa9Bb9cfO5VqE8fQTr7PDxMDK36+Th+jo93nyZH4qIeQata+M8kojiB0nxcwoSdAEcA==
X-Received: by 2002:a37:aa14:: with SMTP id t20mr5372137qke.401.1585665181986; 
 Tue, 31 Mar 2020 07:33:01 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 193sm12999583qkj.1.2020.03.31.07.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:33:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/sdma5: silence a warning
Date: Tue, 31 Mar 2020 10:32:49 -0400
Message-Id: <20200331143249.758402-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This isn't actually a valid warning, but initialize the variable
to silence the compiler.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index f485b97ed760..06411fd099ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -554,7 +554,7 @@ static void sdma_v5_0_rlc_stop(struct amdgpu_device *adev)
  */
 static void sdma_v5_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 {
-	u32 f32_cntl, phase_quantum = 0;
+	u32 f32_cntl = 0, phase_quantum = 0;
 	int i;
 
 	if (amdgpu_sdma_phase_quantum) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
