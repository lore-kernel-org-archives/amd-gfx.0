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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA341C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43342077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdwMjz3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43342077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2886E2C8;
	Mon,  1 Jun 2020 18:04:32 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 037646E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:32 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id q14so8172184qtr.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DnFmtdcVSjuuKZai+avebqJRGYqkI1sd7W2EW4DL62Q=;
 b=YdwMjz3qvA728AtfNMMYe9VciJKQgwB05AoSx+OMwqaKaBisxzNv4UKua7K1clZ2G8
 I/PkYoggAzVkUJhyGHcgZY9m0F03tKZIUpKi/H5tims0s5MPd/+CUmA1Hkg0q3jBjK9G
 6YdH3h/eIwT/6MrbDfhIouXcV8zeNlLYvRm1MlM+FPI6qyYkh2A4q3gsAN/G3VP/bd/z
 pk8JF1E78mlfCmszRwHA0xTpzIRFXukDWtLo+yV6DF15h3NOqVklEuPh1PGSk+PR2uCw
 MlawUSEJnz7fgiPijcF9Kyg6uCr/brbBlTXLshDUQk1Q8du6EuwTd1h1HTTih/Mykm+Z
 AWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DnFmtdcVSjuuKZai+avebqJRGYqkI1sd7W2EW4DL62Q=;
 b=YolQnT1yhJvDp6oTRYqgrA24oK5z126chRZmNmJ+l9yFkcndglLMgb67ec2xH/1iHK
 yXClql+qztdyHpvzJ+eNMBBhePselmMHhmEx2/OPN0B2Ekwts/KLNPtVwBTtNwZYQTyd
 /ei2PZTVe4dVED5OvW/ZkmkEYYfTbEqEfCnr5XwxNVOeiPdmwKct23i/+g0rUbmuSshW
 EnKUl2r0DYzLd9sp4lzHoV0vayTcOjPY62XqPhJYdRd9eISjLkqsA8nOXdd0bk90NSLs
 jluiZ+IyCI5Xsxre1TrLH7lXr2C36f/MD/s8aecYOMhyw0hGD2MhDIX4cUqV/bQ9WTfr
 pebg==
X-Gm-Message-State: AOAM5305mIbdvyBys9KOjHnGeyzBsm8u6QjMwXen7J3UH3hSTvk4IGwG
 glPTxERLHo322w4Z1zrbKj1nnz7/
X-Google-Smtp-Source: ABdhPJzB0+JfwBi2WjmDwF2dmslWblmanqFIzcOVJeXenh93DG2mnp9I8ZqtCuXMlQFuXSLVYL8ePg==
X-Received: by 2002:ac8:4e50:: with SMTP id e16mr23642304qtw.149.1591034670995; 
 Mon, 01 Jun 2020 11:04:30 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 073/207] drm/amdgpu/mes10.1: add sienna_cichlid mes firmware
 support
Date: Mon,  1 Jun 2020 14:00:25 -0400
Message-Id: <20200601180239.1267430-70-alexander.deucher@amd.com>
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

Add sienna_cichlid mes firmware support.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 8102ffcf949c..a6a96cf96b22 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -32,6 +32,7 @@
 #include "mes_api_def.h"
 
 MODULE_FIRMWARE("amdgpu/navi10_mes.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_mes.bin");
 
 static int mes_v10_1_hw_fini(void *handle);
 
@@ -275,6 +276,9 @@ static int mes_v10_1_init_microcode(struct amdgpu_device *adev)
 	case CHIP_NAVI10:
 		chip_name = "navi10";
 		break;
+	case CHIP_SIENNA_CICHLID:
+		chip_name = "sienna_cichlid";
+		break;
 	default:
 		BUG();
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
