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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABB0C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544DC206E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6Tgb2Kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544DC206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5BC6E2A5;
	Mon,  1 Jun 2020 18:04:08 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084016E2A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:07 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id z1so8470423qtn.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=trChD28lI+3+dcB5J1UPiOSAN1i6lK2r3bslViIznTk=;
 b=I6Tgb2KggE4Kw+lo/6mDRMS2fr7FD2RucFzftp7alp1PeaUa/sC9ZrBChp8XFmFA0M
 xtf6pPA8ypwcL33bzM012BPgY5OEvTHuuWIOs3W7Z1RAZa0l523DN3Gxc+nGz0s3d6E0
 IlZ69u50iE0T6EB0I3HdwHMz99549HPTX/Fb1c6OB3k853hESK7jeOsDbInnLtLzCemE
 XXtBIOtbNRZsRK8VfqpzddP/R4S5bFa96huntZiKb2BXFQEb466I9nZZvIuZl1xJ5R0Z
 PVAWvMSoXNrcIdVxK162dh5xDIwQxGmcu7aVEKPjEy3rjMsNA380MMOfSrx7J5cSbsV1
 f+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=trChD28lI+3+dcB5J1UPiOSAN1i6lK2r3bslViIznTk=;
 b=ZISkVcHtYbTxxL2ruojkYiMzDNsmiTwMkDt7FgGfkMzqB52bkvoaVy4KocY+NODJ2I
 tpLGnyFDq874u2la5k5Ofst0LUEylbDuMF7hp3pbmClyqGX1zrlhZcbDFWEXgT/XyOuA
 IZAp2MZKs4HeFWba45BNcizqGhUiJrkCnLwHCNVcTyM6S131NsZoQGaa9l8CEqPppaqz
 2zn50Zir1AfQX5BPPA7XrC36gVQQ+8+yfH0/q6/rZXYxLKTt2nt0O4wISwYNRlXOK4aK
 Sui+cge76zK05cWi6aIIys9n8TU0i/rZfMv0poFImpafe/BR3W0U/XbFOw72Eqoq2L1v
 II3g==
X-Gm-Message-State: AOAM5325SFW1hT4vxyKIGUDcSK+OpJdodB/9D2JzQ2kq9VFa5Cqn1c67
 06Hln/8QfD3C2DR0gwIyDYhPJuBn
X-Google-Smtp-Source: ABdhPJz5ExJXAZY27tuTDnNg70LWnpt3N1Jcl6glE78WDUNYe0ZGRC/1WQk93IU+kjPKjFrJbzPtKA==
X-Received: by 2002:aed:206c:: with SMTP id 99mr23200326qta.87.1591034644962; 
 Mon, 01 Jun 2020 11:04:04 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 055/207] drm/amdgpu: assign the doorbell index to mes ring
Date: Mon,  1 Jun 2020 14:00:07 -0400
Message-Id: <20200601180239.1267430-52-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

MES ring will use the assigned doorbell index for
command submission.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/nv.c              | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 821289bff93a..89e6ad30396f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -53,6 +53,7 @@ struct amdgpu_doorbell_index {
 	uint32_t gfx_ring0;
 	uint32_t gfx_ring1;
 	uint32_t sdma_engine[8];
+	uint32_t mes_ring;
 	uint32_t ih;
 	union {
 		struct {
@@ -177,6 +178,7 @@ typedef enum _AMDGPU_NAVI10_DOORBELL_ASSIGNMENT
 	AMDGPU_NAVI10_DOORBELL_USERQUEUE_END		= 0x08A,
 	AMDGPU_NAVI10_DOORBELL_GFX_RING0		= 0x08B,
 	AMDGPU_NAVI10_DOORBELL_GFX_RING1		= 0x08C,
+	AMDGPU_NAVI10_DOORBELL_MES_RING		        = 0x090,
 	/* SDMA:256~335*/
 	AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0		= 0x100,
 	AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE1		= 0x10A,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b4178ce267f3..cad66cb1b6c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -573,6 +573,7 @@ static void nv_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.userqueue_end = AMDGPU_NAVI10_DOORBELL_USERQUEUE_END;
 	adev->doorbell_index.gfx_ring0 = AMDGPU_NAVI10_DOORBELL_GFX_RING0;
 	adev->doorbell_index.gfx_ring1 = AMDGPU_NAVI10_DOORBELL_GFX_RING1;
+	adev->doorbell_index.mes_ring = AMDGPU_NAVI10_DOORBELL_MES_RING;
 	adev->doorbell_index.sdma_engine[0] = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0;
 	adev->doorbell_index.sdma_engine[1] = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE1;
 	adev->doorbell_index.sdma_engine[2] = AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE2;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
