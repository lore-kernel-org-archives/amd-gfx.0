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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C770C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7303C2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LagZiqtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7303C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2B56E351;
	Mon,  1 Jun 2020 18:22:27 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E376E34D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:25 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id u17so7371012qtq.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YO2N1w8vkHyJwiRHx6P1+q22wJgJ8DyOB+lTPWbm4H4=;
 b=LagZiqtWifjuPixBKzMRQ6zt8q3CeiFLFhU07b978GY9EbhuFBCnZNabgngjCP+8N0
 FgKqAv5bDVHJlPBkz2cS8Ku2m6QcgbnSdM8oHbbMuJyxFkOGA1xQcl4Q5K610l6uRUI3
 M2+O3jsz0rVolzfIWRw1f78666qhCuU5gg3e9JXhxzIzyYq2WdCAzoTYTr2H4Y/1wQjK
 DJLsqBHRc2DnCLJ/tcjtII6s/x1gfr/oGiCVL+NLmiRbdPs7uvVN7I5eeiOEc7HlXDYD
 kHhD23wGPowAZduFqLK5pnMLFV6JSDgLVFihuNpeZHmK9zYsh5sWSWiDS1+6i0Y25UgR
 d7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YO2N1w8vkHyJwiRHx6P1+q22wJgJ8DyOB+lTPWbm4H4=;
 b=mFKoBY8QWQwMVkhFT+t+J4sZRcKLP2MyKn2Tq+jkaFeKeDyn3wBz8MKjidyVZuq7Op
 wWgN3C7uRDMFzoquHRcBDzK8BSrgAFjHZIFbh74OSEuZeJNPuLQbIFWoB9bBEYRClTTY
 HgqZELYSXrMpHkP+wEcHmgYlzVzFNmfFAZFCvJ/9Z5e74Jv3M1nN8JNwdvepdtG2BeCQ
 jgXvb4stisozudWUJ6ls9HNNM5O/gPrAo3XHPMuip0kMKd8Milf+SgaEIEwAsqL4zTiF
 5wllh5eF8kJUzApUyTxqvje/760fVy2nL/T1BPMfek8DGgOssSuVx5EGA3PIFFjwXrqJ
 m0Yw==
X-Gm-Message-State: AOAM533pkAnwChK3nyPdInm6+yjzXpuxaMSaAuowm+x6HtrE9NdsLKMO
 NYzXAR/KJFTYD0LLduevXwMHapQW
X-Google-Smtp-Source: ABdhPJwcJcALTDFohAStm+AmOTmkRMB+Lv0wWF0npLUO+XFsuJfI6JLj683Hd9MFlFJa0iAA3IoWJA==
X-Received: by 2002:ac8:37ad:: with SMTP id d42mr23356551qtc.352.1591035744108; 
 Mon, 01 Jun 2020 11:22:24 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 151/207] drm/amdgpu/mes10.1: add no scheduler flag for mes
Date: Mon,  1 Jun 2020 14:19:58 -0400
Message-Id: <20200601182054.1267858-62-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We don't want a gpu scheduler for mes.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 5c28868f7adc..4b746584a797 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -846,6 +846,7 @@ static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 	ring->use_doorbell = true;
 	ring->doorbell_index = adev->doorbell_index.mes_ring << 1;
 	ring->eop_gpu_addr = adev->mes.eop_gpu_addr;
+	ring->no_scheduler = true;
 	sprintf(ring->name, "mes_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	r = amdgpu_ring_init(adev, ring, 1024, NULL, 0, AMDGPU_RING_PRIO_DEFAULT);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
