Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41321C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F3123DE3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F3123DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E52C6EB6F;
	Thu, 10 Dec 2020 21:45:41 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 749666EB6F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 21:45:39 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id a13so3228997qvv.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 13:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=blZh7FwkV34quuPck4M2Sb9yStE/XggHo/8FtkLMoKY=;
 b=FWN84L2nBUOX2Q1pNCWCmXm3P37BucptSC9ImTOk4k1xUVAcMav11TMeqShaNUHQE/
 rTyZgZLD80I0y22V/5Sdcg+huGT2FYOcEodm7A2amOTSRX1s+RojwggTH4mFsOP9iKZE
 sKQwocjUWfzLgO9l3xLWuz4afXsIMuKRVM3slz8no6yq/aRwyc3IH3RyXWcHWC3/Cl2a
 vtJWsSMdtro2Mq9gCBmcHdfx0iq1IF8zTYoM/a4KG64iqOfubtnIH68kere/+/wRyUJg
 M2BMWmRmt81fk8v2ebnhiemrg5ref2ZfUIzL3omVzTcE7rJv1Z8bULtF89zWP6EVsNBY
 NQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=blZh7FwkV34quuPck4M2Sb9yStE/XggHo/8FtkLMoKY=;
 b=OqPZ8HIoPWFOfGuFClqkDawrj6xMvJ2EySaFAijAW8+/WH7IiiRitt+N/ylYWrrEcN
 5zWSEja/muj9lySJWUkOUboEoEZzsM+GK2cnrurQCb82hrcggbj6rbo3V86xFAzoxAdn
 oQx1WeV4kN7VY6RwKxzZjR6sb98Jnyv3vDCBK66Z9SYr8/awfhDJ8C/UXydx32jKAy1V
 67lOnKBu1vVSo579GBQ9G2Ry6sIrow9cDNDim6vA8ArmOAS/erTddaYI97puXb9DUlo1
 NCL5ZCCV7/36/EUfWEClbSQjDRXOj5KY6SsBkWvnSGhzPKL4mtr56p+KZUDxRyHsXDP4
 J5TA==
X-Gm-Message-State: AOAM533dw/4alVDlDEpseuDxz0sbQ+7NYTgBdZjSrcnyC6N2qg4q/3bB
 5nkvkpd+s9XvcykMp8XIHStpFZNGPOo=
X-Google-Smtp-Source: ABdhPJw9Or4WlK1IpExdPJ4qm5Xnc3EbvWmYzqPm1uAKpODj1+6EEbiC5UyzOViESMkqRtu9r+v1Wg==
X-Received: by 2002:a0c:f107:: with SMTP id i7mr11439209qvl.35.1607636738606; 
 Thu, 10 Dec 2020 13:45:38 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id y9sm4776989qtm.96.2020.12.10.13.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 13:45:38 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu: support runtime pm for GPUs that support BOCO
Date: Thu, 10 Dec 2020 16:45:15 -0500
Message-Id: <20201210214518.704305-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201210214518.704305-1-alexander.deucher@amd.com>
References: <20201210214518.704305-1-alexander.deucher@amd.com>
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

Enable runtime pm on non HG/PX BOCO capable boards.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ec8fff7839ef..af049041ea3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -161,7 +161,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	}
 
 	if (amdgpu_device_supports_atpx(dev) &&
-	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
+	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
+		adev->runpm = true;
+	} else if (amdgpu_device_supports_boco(dev) &&
+		   (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
 		adev->runpm = true;
 	} else if (amdgpu_device_supports_baco(dev) &&
 		   (amdgpu_runtime_pm != 0)) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
