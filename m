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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA178C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817402073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUJce/KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817402073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C786E37C;
	Mon,  1 Jun 2020 18:23:01 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94306E379
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:58 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id b11so8506214qtt.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HmmoDfq0Jd1KCVzz3GU84B3kX8WVujfb3OVAJc7UgCA=;
 b=FUJce/KNsv+zWKn4RDcSbdKBlG7DGwpsoleE2T7K5SGlh+c7XlUg6ytrCXsjN/pgtE
 p48ur20ap4xhDKQJ5eiP4oUu2wxiRKQ3fU1DLDAQwxh6q2Wywnpr0x/ZOxAuTOjvY05W
 Vg5lkfpYyDYPsfRwecrL2XDaHBdSMzW4s53VU5rnEML8L5W5loOpNmMAygNICFaJzaxz
 oinSUCjE3tjL0OuJH5kuMa3PDdfmsXM6bQRzuzmOIR/gu2EUsbkCVR+lt2fRao6CNr1u
 WlDo92O2N3WhVxrnQi2XN7teLFI5uknYK2KMqun8kBhL40h/b+FSn+TQX+JhGjPD0dYg
 f79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HmmoDfq0Jd1KCVzz3GU84B3kX8WVujfb3OVAJc7UgCA=;
 b=oiUwxmFnvhtw3pZF0meMMGnrrbe5nHGn2HkFKVqDuwxT5mo3GNQxUkk9ZVf0l57FPG
 nWPcHBX+4USJYtgD7lD/78WCf6lVKft8XiUEbp7FeLsXajrBXupyoMw7sKy55D3vK1a3
 k8MY1pyKTy9AzZGsDLBe76S9GoV0L8w4x+CtWqf0Smqdv2Tw9D/TD1CoM9mGPCaeu+EQ
 ldngfbwozd1zMPYyHFP1SJr2wAxZnFxlhR9nfopIXtXBo6UMpwpm6vzDOfEDabP/4bB3
 l+UgBu4+uzrKaZpMd3HFTj4EKWiSp1a1dxnJ6AXUXiglxIScJYZB8OivEWL89Ow/jObM
 5cXg==
X-Gm-Message-State: AOAM532JxHqT7WSSb8kKI9kGOcNQMeSI01YIOY7YD+GM6wrIexm3ZgIC
 LSwEuZ2RQ600/5ov1fwEEIXvz+Wi
X-Google-Smtp-Source: ABdhPJxC3/BWXC2aFjZZ7S5bjAsuo/uEc8N601NClcR1U6a2gkcOScdFaw0zMHPzKlgoWlHlnfH+Dg==
X-Received: by 2002:ac8:dd:: with SMTP id d29mr23935304qtg.392.1591035777852; 
 Mon, 01 Jun 2020 11:22:57 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:57 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 176/207] drm/amdgpu: support memory training for sienna_cichlid
Date: Mon,  1 Jun 2020 14:20:23 -0400
Message-Id: <20200601182054.1267858-87-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add memory training support for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index a9adccfda4c0..2b55ccd5cb44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -532,6 +532,7 @@ static int gddr6_mem_train_support(struct amdgpu_device *adev)
 		switch (hw_v) {
 		case HW_REV(11, 0, 0):
 		case HW_REV(11, 0, 5):
+		case HW_REV(11, 0, 7):
 			ret = 1;
 			break;
 		default:
@@ -561,7 +562,8 @@ int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
 	adev->fw_vram_usage.mem_train_support = false;
 
 	if (adev->asic_type != CHIP_NAVI10 &&
-	    adev->asic_type != CHIP_NAVI14)
+	    adev->asic_type != CHIP_NAVI14 &&
+	    adev->asic_type != CHIP_SIENNA_CICHLID)
 		return 0;
 
 	if (amdgpu_sriov_vf(adev))
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
