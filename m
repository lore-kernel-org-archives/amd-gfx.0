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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E10C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC202073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfXWe9Vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC202073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798F46E2FF;
	Mon,  1 Jun 2020 18:21:26 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216006E2FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:26 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id u17so7368199qtq.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5gMI2zBvIjEbZuyy6Cwyjnyti5uuXTWGJktvH04cdm8=;
 b=lfXWe9VkZ1MCylpcRgivYycts7IAj0ZguD7wwd71G9OzuxFHASbrtHFDRHcyV3FPZ+
 pGSxez7SiV0jZGKzqdjlUbRrQ1O3a7EXHPcN7xKmh4UvZP8OnSqasKTIEh0vI7NM8iq1
 uYlIjoqGjzT7mvSA+HHv+aN63sd1OGIQ7tF+EPj9GcrGDFUIGyxYJ8vcYxnyW2+fNzbB
 fCdOvM17H2yW0eRq333OkBJ0H93M42lVaX/tLPtx/83xFMZYTh0rHBDyZYMiiNJOjhct
 sMFjMBzvs/Umv0wjRKi7y8spqp/7Cguaia1duB6In5VeFv2jdQrh7ZIF2er2i5YBhv3H
 6Tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5gMI2zBvIjEbZuyy6Cwyjnyti5uuXTWGJktvH04cdm8=;
 b=iKK22w6BCosAWRFTCjGO5h0yU9FxPCAQdeMl/7onfG1ICfgZYOR1uqYoe05AuFsT35
 j0xA6KNGYDQ+s0ypRD29Mvzzf9Ucpcdj3JguHPDygEwBkUoHqDlAw4BQeI1zgTnZIfVl
 1bvOEKg2siaPyqZYvk2u5WUqXEw24++VfsU+cB8XAneEtse0h+xpiwz549c7o4AX/DHo
 RqX5YVSa4anL2xaWANgULN1DZEvlOKxJ/NvBTCnEmPoXtLZylDgeKTf4TKwSN/f15UtS
 Z8EwXNx/PSl6jspGyBmuGIXGDMEt7qDk/NOiy27xbZmyOTnygjxF1gsTviOo7L36l5Bj
 QJcg==
X-Gm-Message-State: AOAM533BJzXz05g8jVi+KdTlbclFFSPjheelDSZFO6UajG87j8HLwRBt
 YVZTKtVoB/O5p2g66LTvNRux6JVI
X-Google-Smtp-Source: ABdhPJx9Q2HRQohyTzryO1uiqVwioIhYJ3F4N3E7ELE+1cosWG6oEgGLGzHlOR/Cyhh+dVhv1b0sYA==
X-Received: by 2002:ac8:4e4a:: with SMTP id e10mr22498392qtw.203.1591035685073; 
 Mon, 01 Jun 2020 11:21:25 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:24 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 106/207] drm/amdgpu: update golden setting for gfx10.3
Date: Mon,  1 Jun 2020 14:19:13 -0400
Message-Id: <20200601182054.1267858-17-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update gfx golden setting for gfx10.3.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ce6ba3ba9223..752032eba6ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3082,6 +3082,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xf7ffffff, 0x10f80988),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0xf17fffff, 0x01200007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1, 0xffffffff, 0x00070104),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_CONFIG, 0xe07df47f, 0x00180070),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER0_SELECT, 0xf0f001ff, 0x00000000),
@@ -3101,7 +3103,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00000000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00800000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_sienna_cichlid[] =
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
