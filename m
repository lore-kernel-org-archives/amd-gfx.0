Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B12C433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D2020706
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw69EUgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D2020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FED6E0BE;
	Tue, 25 Aug 2020 14:18:20 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBA96E0BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 14:18:19 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id x7so5524994qvi.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zv0/JVCAc5hEfyRvZxWba8YEKPDyGhsnJVMazT1++f4=;
 b=Kw69EUgzdIfi8m+A5sMtmhRcMpVwqXXR5iU2PfeyS0003MBjk3EE+qP1/B2bXWzBlZ
 4a57V2QLB/OgETNbAfCclhD4ReZS/UR6PLrboA2nkUaapCbvPT1GYhW5xwKocowsBe1G
 MB7q9lhenw/+wFaO5O8v48BvKJR0WzUYboDvjOaXTQDTcOMtectiHULF0RjPuTfCtkUY
 gAZGn3Jk432zuzi/yR8KBwyHgZSKzaDh4l3WoH5SNCVq7D1YM0wAiz4tyWTdZxreKGor
 In6ULBzsU1FUqT12rY7xjpAXkxmMYKBdhYTKyWKLLOZxv79ODJ5x3U+udymWGyabEVPx
 5W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zv0/JVCAc5hEfyRvZxWba8YEKPDyGhsnJVMazT1++f4=;
 b=nfAjd8r5CccKErZ7a3bnAgr8l8R2CPDFPjVaFHG5I1jD6NcZoYuqSK2BnxU9cBOIwa
 1mzzMI8nHs6qy6/NbkWLCyyKKEsZLypzRo9fjgUkz+gxt/L3/xzTjIHO0Qa5WDaExVEY
 aQ2FghXtacuLYE5p0DpDmP9z9OiCVe4Cl7uTAfD9hvslZD1glEWTkXYbIXRLfSdHqIMA
 2i4eUMq5XfT+K166E8b7McIf73GYXxilpgQRSMeJeqPdrPYZhIiRhFn384a4Ht5j6A2X
 LY0gPnnt6h+mhU2bzTKstT0/QsYT3Sqnrne1eilQgSbc1qY5ZHifW1bt3T0gBPHglBu+
 iMxQ==
X-Gm-Message-State: AOAM533UjR+VdcnFnLy0ogPGSha45K3C5+bKKDDfzZncICCmMCzV7pKt
 J5fl1XGZKkKqj2VfVhPqR2stCCY41jc=
X-Google-Smtp-Source: ABdhPJySPBxMdplkf5FZMKbgUWXCb/uGCfrhDxA8340XCEPt++vkbNEpUsrYuKxqfmtsr2xq6h77Og==
X-Received: by 2002:a05:6214:140d:: with SMTP id
 n13mr9642848qvx.69.1598365098572; 
 Tue, 25 Aug 2020 07:18:18 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id r73sm12161836qka.76.2020.08.25.07.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 07:18:17 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: report DC not supported if virtual display is
 enabled (v2)
Date: Tue, 25 Aug 2020 10:18:08 -0400
Message-Id: <20200825141808.300152-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

virtual display is non-atomic so report false to avoid checking
atomic state and other atomic things at runtime.

v2: squash into the sr-iov check

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5a948edcc93c..8f37f9f99105 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2861,7 +2861,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
  */
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
 		return false;
 
 	return amdgpu_device_asic_has_dc_support(adev->asic_type);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
