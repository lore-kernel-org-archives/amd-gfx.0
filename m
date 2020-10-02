Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E48C4363D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BC020708
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEy0h1zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BC020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE676E9B2;
	Fri,  2 Oct 2020 15:09:58 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A086E9B2
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 15:09:57 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id y11so1452860qtn.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2020 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8BddKfMNi7bIYsbR/+Zwhf05YHc1QMtfUos2A3Z1h9I=;
 b=NEy0h1zqsJlc1eLqhwR2pQ32dzxaaEa0OOlr7v8NebO+64LYSkpZL3c2V5rw0M9Vte
 TotDaC+1MEkObd4tPcXzwqyq86Fv7WmRu92HNXQzvw4RiDQlmrxpUXyP32/sFydx9hCN
 Sq24zHNiyU6bgr7ypzpFXDY1OE0WrqmqethUn6ipbeR3gGp5VjIl34UQOTASUyyMlnnn
 0hHm1pOKJOIbwnb5CgGVIbQPvvILyYfFdA+jNsxfbP45PCwUdrWUkUnNriclwFVD2GYn
 5ZfNWqDx/zxgrHW6NDwLWBBBcpdMjgE2MogcofuvowNsL9vccPJN/jvkpj34mLUyrvyQ
 UiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8BddKfMNi7bIYsbR/+Zwhf05YHc1QMtfUos2A3Z1h9I=;
 b=ddFQeTyuzwJebVUMOQDF93VIHnRzbnvRc0w7FmyPgFLwiRP4QdfBfPOJuH3I5tRmMA
 n7MkEoXwUzDBUtDUC7NofALnjqBIQCY1N9bIfLmx5DOfP4uIa0KEZB00dumD2Swmypdo
 qAbnbbb69zISFom1Bfy32Y8EVkIJfUF7OHWjSf9bVp+P7kkgxRLTA6/NluBpSUzQKe9i
 ocdv6yyLNvGyJRKuDpN27rCYuNMYby3PXyX2PM6JMqHlUqhVCk109I666QG7O26S5FmE
 SZuqzKUuEBCPSyHLWfOZokfhqmNCcwo9126dXuCt1JxRBKjMsdh2oxQB2gDGjEejyULg
 CgzQ==
X-Gm-Message-State: AOAM532slwa8eAsPL12AbK8ZB/gOSwfwTFj7fxgegftIAEvbJh/nZXMP
 dNqs08F1xWQS3shpkeGLuNggcZVC07Q=
X-Google-Smtp-Source: ABdhPJzsOWXNSQTh2JcV9dQV0E9wS3BPv6cfXIqQ0JcU0xrcFVvu4e0ls+5kvBTsTx1fBRoUibYwwQ==
X-Received: by 2002:ac8:f04:: with SMTP id e4mr2704122qtk.342.1601651396383;
 Fri, 02 Oct 2020 08:09:56 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm1248435qkf.98.2020.10.02.08.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 08:09:55 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu: add gfx support for green_sardine (v2)
Date: Fri,  2 Oct 2020 11:09:37 -0400
Message-Id: <20201002150940.1103949-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201002150940.1103949-1-alexander.deucher@amd.com>
References: <20201002150940.1103949-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Enable the gfx base HW function of green_sardine.

v2: use apu flags

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6959aebae6d4..0d8e203b10ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -117,6 +117,13 @@ MODULE_FIRMWARE("amdgpu/renoir_mec.bin");
 MODULE_FIRMWARE("amdgpu/renoir_mec2.bin");
 MODULE_FIRMWARE("amdgpu/renoir_rlc.bin");
 
+MODULE_FIRMWARE("amdgpu/green_sardine_ce.bin");
+MODULE_FIRMWARE("amdgpu/green_sardine_pfp.bin");
+MODULE_FIRMWARE("amdgpu/green_sardine_me.bin");
+MODULE_FIRMWARE("amdgpu/green_sardine_mec.bin");
+MODULE_FIRMWARE("amdgpu/green_sardine_mec2.bin");
+MODULE_FIRMWARE("amdgpu/green_sardine_rlc.bin");
+
 #define mmTCP_CHAN_STEER_0_ARCT								0x0b03
 #define mmTCP_CHAN_STEER_0_ARCT_BASE_IDX							0
 #define mmTCP_CHAN_STEER_1_ARCT								0x0b04
@@ -1630,7 +1637,10 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "arcturus";
 		break;
 	case CHIP_RENOIR:
-		chip_name = "renoir";
+		if (adev->apu_flags & AMD_APU_IS_RENOIR)
+			chip_name = "renoir";
+		else
+			chip_name = "green_sardine";
 		break;
 	default:
 		BUG();
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
