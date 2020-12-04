Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9AC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 20:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3272D22CB1
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 20:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3272D22CB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE4F6E21C;
	Fri,  4 Dec 2020 20:44:47 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA10A6E21C
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 20:44:46 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id z188so6754011qke.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Dec 2020 12:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6p3ox3lU2riY5D+Ek4bmlWT560GtYa1Er2ft4DSrU2o=;
 b=kskVdSJeElxXdRcFBGYpBmxkdm/NSX1daUTS/vo5MrjNjrEC+mFzyT4B0ONn0N3ssh
 aVH16AWdFu8RwCb3nCyvefXgJA8e2WCUP0BZJotRGwmRm4NxoiX8PC/FkgYnEsdl7MiU
 XwBE4dBi3c0J+7KacpJx8Clqd2FD3hQW41OL2TkS++eKDOZxAt9oSg4Y0w8ghK8c2zSO
 Oy/j2BjZzNObVTGpXR3vqFpOoNznEumLxbxhjJYvwn4hJKUetrQi8Wh4X9JR1AVKkOCw
 fEdac1d1kKpR5ndjcJNbPZOg6bc2QqeGAwska6YRdkgS6nRmdHodviqr3XZEIyjUjbPs
 e0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6p3ox3lU2riY5D+Ek4bmlWT560GtYa1Er2ft4DSrU2o=;
 b=q50hL9Yzrjp71Lju8KwVl7u0X/5exhjqA29uMpliVZVXA59p64DiQo+R2+s1ZeoA6h
 bORUlE1ehBCRGKOBQJ6x+O3nBp71tVnOYKrcKucSseIrNO9rePjrkLgsSxupOxcJzAsV
 qdUKzsfmIoEQcDrOVAwSyOnkBdiie2+IgWsewYbuoYfSlA9HJcbDMzRzXtkZ8DelsgCs
 9BNzT+15SXUuuHtJbidNzhA8F9fhgLF6XG2nKkauXP3smQY+4HRXB+x8jHFw6DLFuYZ5
 KkmywkuG0Es0ggDUKLgG0OzNehhx4bbq7FSXYGlSBNz5+Jn9jV4s3Ss9h+P5mEclHBfG
 nMyw==
X-Gm-Message-State: AOAM530OiZMRWMcl9KEmGxpfiz1GHR65jjv33Gzv56ZeBRovNrKAExFi
 XsansALm5Y+yL/gFnB7LdXcI6UQjYmA=
X-Google-Smtp-Source: ABdhPJx1CW842eeHZ92ojiojD2pnhiiR2r91+RGzPUEU3khGOsn/OP3h8zOcAqVX/98IXl5lQS08lw==
X-Received: by 2002:a37:a70e:: with SMTP id q14mr10507775qke.337.1607114685993; 
 Fri, 04 Dec 2020 12:44:45 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o13sm5646581qkm.78.2020.12.04.12.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Dec 2020 12:44:44 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/cik: enable BACO reset on Bonaire
Date: Fri,  4 Dec 2020 15:44:35 -0500
Message-Id: <20201204204437.3845-1-alexander.deucher@amd.com>
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

Works now that the BACO sequence is fixed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 5442df094102..13737b317f7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1336,10 +1336,6 @@ cik_asic_reset_method(struct amdgpu_device *adev)
 
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
-		/* disable baco reset until it works */
-		/* smu7_asic_get_baco_capability(adev, &baco_reset); */
-		baco_reset = false;
-		break;
 	case CHIP_HAWAII:
 		baco_reset = cik_asic_supports_baco(adev);
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
