Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1B7C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57668207F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqPjcvyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57668207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A4C6E5D2;
	Wed, 29 Jul 2020 17:35:04 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE046E5CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:35:02 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id b2so657457qvp.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dQ+ioePqy3WB9Vvw4p2ICHHRrJEuCY1buN5X4vbhV3U=;
 b=mqPjcvyLkReLisU/8ZF4qpOBwD95Yd/UNOQ/dvWfNbXOBjf9b+iYG2Kne+0CxQKg4h
 IsbMvxaG0E6JlbQ278QwhXDU0ArsutDbope1hBkVkWGJyewK9CvHj/cLCFZZniQ5h8jA
 +Jtbr+3/TgEW03yFdNA4zkIpBBXIWN52Je+D2ado7rCKQ9zQPeNtwQnz5gAyoo2Fb6jb
 SJt85OI+Q2MSk4FIz25HDbTE2RgrLppUSZ5L/RlX3MYAf5WnKlQ8f5/toLEABXp/7J15
 uo+9eaPPxUureZlUO8TWLk0WSOW+nwL+AuM2EyY8Ua4ryjvL3f1q/Aut9ulDatZFDjUe
 8uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dQ+ioePqy3WB9Vvw4p2ICHHRrJEuCY1buN5X4vbhV3U=;
 b=UNU4SybUiNWg7GamgjmEy5tC/qFkYAStWmCB7I5gpUEMFScllkbMF0y2kBC9m227y0
 ADyJrotmYo5QyoOoODpFRkCENRn42DdW5KJGqzCXrPyVlgMqaZdOOnHSDdAtmSRbHg6X
 1+Qyrf7EP+nT53HqIt+BWSmrkFaY9TKxstThGuCwU9Nn+NQhdW8czfn3+KiILaagIc6o
 SRaIGRIaFPpIlwe0cFPoLqsRd9hKCNYGXN7dOlxnx3o+BemoOPmVY8eLoMrmRhQWF/el
 Z4YiNLLcpbMB3eTWRH2/g3J/LVYd8zdJ98V11IzEUpd8qIG0YDAlb/vmy+7cqMhiFvZN
 ziPg==
X-Gm-Message-State: AOAM5305HYeryVkCQrrCB7qktENmm2ba8JsUjiExjJbWZNKcbdFlZgPL
 ZoPzs3XZCPHgMW/Ub21W0JMGMh2z
X-Google-Smtp-Source: ABdhPJwtqxrYYIFvmh0G2zRO3DJHeE+8YJ3pTbWOoryf07ZY46iz0ZPrycIneBNKfMrtboSby1dk6g==
X-Received: by 2002:a0c:ec86:: with SMTP id u6mr20220763qvo.58.1596044101804; 
 Wed, 29 Jul 2020 10:35:01 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:35:00 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/17] drm/amdgpu/gmc: disable keep_stolen_vga_memory on
 arcturus
Date: Wed, 29 Jul 2020 13:34:36 -0400
Message-Id: <20200729173439.3698-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729173439.3698-1-alexander.deucher@amd.com>
References: <20200729173439.3698-1-alexander.deucher@amd.com>
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
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I suspect the only reason this was set was to avoid touching
the display related registers on arcturus.  Someone should
double check this on arcturus with S3.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index fc9e18aaa76e..0bd7b3797534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -448,7 +448,6 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
 	case CHIP_RENOIR:
 		adev->gmc.keep_stolen_vga_memory = true;
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
