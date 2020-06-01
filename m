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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3DC433E4
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F912065C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNNaNYVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F912065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709ED89EBB;
	Mon,  1 Jun 2020 18:02:54 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9735D89745
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:02:52 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id s1so9923308qkf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xqw5yNFuA4e0eftk7Hr2SsipD0shdRSzbFC8XXBXss0=;
 b=VNNaNYVhccI5ZbZalC7NtTaVL0BbSuisjEnu4xgz8VAVEWSADP1woXChJpL1A6r4ms
 KrpgB591uZVbUeXxiUPWE9RQhIXWCCQws3nJ1GvMhVrxFhlXFPGnYAPorp51Hw3H2bkz
 zVC1CnLF3HseliXdLcH+2Q16sLOQ1eVzOaZS7rV4FkxwJ6Spagzd7AnHTK0Lwz0V/FDf
 qmm9i7KMMUTba5CIsEvkN8wp9sfKikr4fBZ5R+hN685eIpCDmZWmn14PEQzILAtDGtDj
 IYqjN3K3aWbtpvovQclgUck2mIBxBLJE9dC+WE9Q8+mX3MiD2vL5sqb0dW/YFRYXEcVF
 mpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xqw5yNFuA4e0eftk7Hr2SsipD0shdRSzbFC8XXBXss0=;
 b=K58tDllj/gVwiNS4vsx7YwtzPDxWoFGc40UrTEBWJgZ7gPDM7BGlyk1qbAGxICUqEk
 PRqfRhPofLmoG5zQio+eZqUrA7ntORnQTrjJVa5N8Wv3sLllaYwhgPMgBmuQhXfxBN/P
 ZE8p8rFK1Eic+zWBFkmMmay/qCu5Jr6A39jrcxINf2rsvr/5Pqjhr+EGaBEGGBtwNo0y
 YYUDT6NPeMEuQUjH+f24ZzOfKGMdjiJkFuEbeS7cz8qvGGYY0TKTNrrWD83clpC7ekdH
 vA4qugL7GnMgnO+RDtftupXXgbQcFHjkR0GA2Ln88Ehfi9TaheHB3PgF+Oar2uxN+ffL
 Y3/A==
X-Gm-Message-State: AOAM53071M3n18JkpGlPsIE9lpFp3AJFSUO0UHORc6/Q45UejpvlLmfV
 ElA6z9jCWbV04zJblpZXI/174XnK
X-Google-Smtp-Source: ABdhPJwRsczY8uBREeDQrPWYFxa/0oAVTrgQWtrq3k/OkNyPe2DMZbvtwIGn1gizvtFrUWVTRNkBAQ==
X-Received: by 2002:a37:84c5:: with SMTP id
 g188mr20122692qkd.344.1591034571434; 
 Mon, 01 Jun 2020 11:02:51 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:02:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 006/207] drm/amdgpu: add sienna_cichlid gpu info firmware v2
Date: Mon,  1 Jun 2020 13:59:18 -0400
Message-Id: <20200601180239.1267430-3-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

gpu info fw contains chip specific parameters.

v2: fix fw_name

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5d1e445eef21..2a284d4bcf3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -80,6 +80,7 @@ MODULE_FIRMWARE("amdgpu/renoir_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 
@@ -1528,7 +1529,7 @@ static void amdgpu_device_enable_virtual_display(struct amdgpu_device *adev)
 static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
+	char fw_name[40];
 	int err;
 	const struct gpu_info_firmware_header_v1_0 *hdr;
 
@@ -1595,6 +1596,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		chip_name = "navi12";
 		break;
+	case CHIP_SIENNA_CICHLID:
+		chip_name = "sienna_cichlid";
+		break;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
