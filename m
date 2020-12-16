Return-Path: <SRS0=VOM3=FU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA29C4361B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 16:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54272233E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 16:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54272233E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024D6896A3;
	Wed, 16 Dec 2020 16:37:36 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31AF896A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Dec 2020 16:37:34 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id 22so12878093qkf.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Dec 2020 08:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xnmdlQHOo2xKzJGX+fqRo1jpHlhWtKtPUfakgjeztn0=;
 b=bl16z9o/wA7eMS7JCxsomQYhxuQQn3PN6NWPmbFThSYVtMU8D7Mp+auu6dhhUrjcbY
 w5XID/OMOvPD/C43mEkZfbjmgFhKUDFYZ3y2SrjrAyVzDugoSbR4UZ5vAUjC6qvteGO+
 iimHv4Q/S3ukUvr9PX3Q/0U7E6iWaVg+MCXxudjU8fArst+teTJhJ5geMuuaPKInlZZ+
 RG1/GPMf59Gifw16QOuwnzk0Jk9fI+nl/lXr5tlfuRsEX2qWe0QrFC7LWN53FkTIWdLL
 ZzKoQ8SWrG9S/wfyf1Tk/uTxSevOWOXb0GDBKVxdN1+JFJOhk2YfVkvFmbyuAQ8a4pBA
 Vi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xnmdlQHOo2xKzJGX+fqRo1jpHlhWtKtPUfakgjeztn0=;
 b=jU9ruYN0b/WAZn51YwtDgSSc//ioqHue3C5m5Fl/uPwhkjiR1HLedtujRGMcAUpAe4
 DiUBSKwl1VoDL0DjMkwv7sC8QAqR6Ypko8s2INxuzI82Q2vHa3f97KSjotFaITcupKkA
 04wTwHSWWDfJDyDw+EjBjOk6OZqMg598ziWUM0e9AdegnpEPxSDwb2u9TH6ELAeNjSVZ
 MVz6sBopGjMxgV88JcobpN8DwE0BkptEmPXpimpBeowqxEo4UGXlVAPuFSjgjpgZJIA5
 AcRKLTZXnH9cpe9mfx1rHS9xoRdd1FHD6DuwcnoB1I+wZSKkNoT58bKxFLdl+NMJ2wPJ
 kMqw==
X-Gm-Message-State: AOAM5307fGD99WOHmF2xTsx4i2VRtXUK8TsLjMrXmE3oRNkJHJPx5tKq
 r869/k6s+XG9LEwp9PLiTf+tL7MqGPA=
X-Google-Smtp-Source: ABdhPJyriqHTApNfpj8DncfIQgVQd5uBVYelFIfD4CT2vAf2yoirBsiXrrjP49tua6HHvG0QLvApNw==
X-Received: by 2002:a37:9687:: with SMTP id
 y129mr42368124qkd.104.1608136653784; 
 Wed, 16 Dec 2020 08:37:33 -0800 (PST)
Received: from tr4.amd.com ([165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j30sm1330697qtl.43.2020.12.16.08.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 08:37:33 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix vbios reservarion handling on SR-IOV
Date: Wed, 16 Dec 2020 11:37:21 -0500
Message-Id: <20201216163721.2432665-1-alexander.deucher@amd.com>
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

There is no reserveration so set the size to 0.  Fixes
a regression on SR-IOV.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c2ced5be6d7b..6e679db5e46f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -496,7 +496,8 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
+	if (amdgpu_sriov_vf(adev) ||
+	    !amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
 		size = 0;
 	} else {
 		size = amdgpu_gmc_get_vbios_fb_size(adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
