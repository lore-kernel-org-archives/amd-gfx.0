Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52CBC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 21:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CFB60295
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 21:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CFB60295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7496E233;
	Tue,  2 Feb 2021 21:54:56 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A916E233
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 21:54:56 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id v126so21416732qkd.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l5QRczuTjXI6fGjvZvEPxllsrxiIVN1711Us/0+kibM=;
 b=MDg+wfQ/cpLCxrV9zWrlHmYaw+aewejL3/Zw0RQtM753t3CowuFh9ENm54I7sJO/5K
 bcsDFlq3Vv/86u+PWPed8ofPhEqnXT7JgEBuSLTTpckwPO3accf/sC5OArAODaaEmcpX
 nr1SJERhru7L9kEnkulV1JeE5z3PTcH0E6RgpDHAIsmFArDq4s0bhYXT3pO/OD0DqppC
 n4OfSSwM//jUV/pAJqrX4rGv0HX3JIm7GMQ9T4TEjdS1rIYim1ArLEtV0KnTI7ECxVR9
 tYog+I7HXYZJc1o6FDyccCxLLFX2SK2H22yPXaIWCYn7yTcpiuJpams/J1UWYcrQjtBh
 eluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l5QRczuTjXI6fGjvZvEPxllsrxiIVN1711Us/0+kibM=;
 b=P6z7gsqP/yXEeTSg90wlMUmRupJd4nGdRbDx8iSbhZEUmWIZdR3rW47MnstCXQ4VsK
 oKweemYGs2gdgIK23hhHfiYF2NP+UDeoYeBeZQe2Pu0aZgSMTn+GRkNwp84388Gjn8nm
 9bNgd8HsklGCnABXgevN9hUn+ZpetmOByOSXnF4XEHGv2g/He0CSoqU/Z4qtQf1xCIe0
 RoU9Nc5A7TvSdgaF7ZSkFpbONXRjo667wpCU8Quxq54spLFFd7KzSy2Fc/nd9MRo5tmh
 E0PCbZFEkY/V+JiG7WLbz0icRKyi9DhysfK8eaQo6GYPx9Hvy37XFePbqpXCcQdB/vnd
 UkrQ==
X-Gm-Message-State: AOAM531sHdWxtVhp9VXKKuugVooQ9gM5+BgU0nVUJTlMlwW6WX/5YUR0
 KRk3ajGioT/uKqQop5VMuijGHEA9nQY=
X-Google-Smtp-Source: ABdhPJxJxwsMhss56FJphSqtAs+svL1qP8JWims0MN3gx/+LwPUsfN/lV4oTi89XBYhVUB6DsJxE/g==
X-Received: by 2002:a37:a1cd:: with SMTP id k196mr5015812qke.239.1612302894164; 
 Tue, 02 Feb 2021 13:54:54 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id c15sm130453qkj.129.2021.02.02.13.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 13:54:53 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gmc9: fix mmhub client mapping for arcturus
Date: Tue,  2 Feb 2021 16:54:45 -0500
Message-Id: <20210202215445.1505390-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

The hw interface changed on arcturus so the old numbering
scheme doesn't work.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 66 +++++++++++++--------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index aedef9017c4c..3686e777c76c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -239,46 +239,44 @@ static const char *mmhub_client_ids_vega20[][2] = {
 };
 
 static const char *mmhub_client_ids_arcturus[][2] = {
+	[0][0] = "DBGU1",
+	[1][0] = "XDP",
 	[2][0] = "MP1",
-	[3][0] = "MP0",
-	[10][0] = "UTCL2",
-	[13][0] = "OSS",
 	[14][0] = "HDP",
-	[15][0] = "SDMA0",
-	[32+15][0] = "SDMA1",
-	[64+15][0] = "SDMA2",
-	[96+15][0] = "SDMA3",
-	[128+15][0] = "SDMA4",
-	[160+11][0] = "JPEG",
-	[160+12][0] = "VCN",
-	[160+13][0] = "VCNU",
-	[160+15][0] = "SDMA5",
-	[192+10][0] = "UTCL2",
-	[192+11][0] = "JPEG1",
-	[192+12][0] = "VCN1",
-	[192+13][0] = "VCN1U",
-	[192+15][0] = "SDMA6",
-	[224+15][0] = "SDMA7",
+	[171][0] = "JPEG",
+	[172][0] = "VCN",
+	[173][0] = "VCNU",
+	[203][0] = "JPEG1",
+	[204][0] = "VCN1",
+	[205][0] = "VCN1U",
+	[256][0] = "SDMA0",
+	[257][0] = "SDMA1",
+	[258][0] = "SDMA2",
+	[259][0] = "SDMA3",
+	[260][0] = "SDMA4",
+	[261][0] = "SDMA5",
+	[262][0] = "SDMA6",
+	[263][0] = "SDMA7",
+	[384][0] = "OSS",
 	[0][1] = "DBGU1",
 	[1][1] = "XDP",
 	[2][1] = "MP1",
-	[3][1] = "MP0",
-	[13][1] = "OSS",
 	[14][1] = "HDP",
-	[15][1] = "SDMA0",
-	[32+15][1] = "SDMA1",
-	[64+15][1] = "SDMA2",
-	[96+15][1] = "SDMA3",
-	[128+15][1] = "SDMA4",
-	[160+11][1] = "JPEG",
-	[160+12][1] = "VCN",
-	[160+13][1] = "VCNU",
-	[160+15][1] = "SDMA5",
-	[192+11][1] = "JPEG1",
-	[192+12][1] = "VCN1",
-	[192+13][1] = "VCN1U",
-	[192+15][1] = "SDMA6",
-	[224+15][1] = "SDMA7",
+	[171][1] = "JPEG",
+	[172][1] = "VCN",
+	[173][1] = "VCNU",
+	[203][1] = "JPEG1",
+	[204][1] = "VCN1",
+	[205][1] = "VCN1U",
+	[256][1] = "SDMA0",
+	[257][1] = "SDMA1",
+	[258][1] = "SDMA2",
+	[259][1] = "SDMA3",
+	[260][1] = "SDMA4",
+	[261][1] = "SDMA5",
+	[262][1] = "SDMA6",
+	[263][1] = "SDMA7",
+	[384][1] = "OSS",
 };
 
 static const struct soc15_reg_golden golden_settings_mmhub_1_0_0[] =
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
