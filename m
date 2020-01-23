Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE3C3F68F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 17:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA821214AF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 17:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4Dt73+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA821214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F89C6E0FB;
	Thu, 23 Jan 2020 17:05:59 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD5786E0FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 17:05:58 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id m14so1833259qvl.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 09:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=709MIAajnnA8n8gEqT/2OEjfpQPn3L1HdGZMU03IGcY=;
 b=t4Dt73+I8rcBZauVHI6L/i3zpm4TFLibmpp3UJuWnVagFmJGQH6Qe7nJlWK32WmDD+
 4BTA8SGutRATLAmCXCs5oOAOpXhDQfwst7j4vwa5Pfn7tlDfzu6Al1/nZuQaiNKgu0JN
 G4HW7lFEnZ65QD7FqDBlnUf5F2/suwlSGgtd6tViV3zEA26hrEaRzr7D4Dge0WhbNmOg
 +ieiYDfa06uBnLKmnVLA1iqUhrWIkTqNx5/0eaGAprJ1fATtsu23TNYXl+Nyxf3sebFh
 f2KX5XynlyPg92aVLa1Al4gb5rSDL8JKOBaGR7hha3h4BBF79utF3cZ4e8pPZVs2uYG9
 rEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=709MIAajnnA8n8gEqT/2OEjfpQPn3L1HdGZMU03IGcY=;
 b=nDO067NJpK//4zbAjCEym8EGJKoz5+9HMKC3oVFC9dF3RV0odGfA9zsVneXHOdXtEU
 64tn+d3Y13vCYXlLrgbLJk1VRhl0zQ9qP4cg/RUAkf40WoX98kF0e24QEHKVI5DzKekL
 qWrxDYJHYmeDSHFW+CNvZh6gp8zchbJov8iwHsnj6XLEXBKcEUdcH3Od8NnQLiwMIz3b
 qmxMadlCt0++/jamFrvoKHY0iC7YCq8l5qUfOwSNm1GDHx3OTLxb7YdmRxvNLU77bE0s
 XORewROae0dZKvAwlcKaHueEt3dPAtyNjyVoKaMu6jA7yj4nBpfWLU/RrFhG+NghNUEs
 YSCA==
X-Gm-Message-State: APjAAAUHFZFub36xvPH+OxRHo1bsofW/7iyFT9DiFMfpxuFd7hj4XMpr
 al/iWms0GxMdQ5DJU3z6syZ8/pUK
X-Google-Smtp-Source: APXvYqxD2vq3AFZBsIraPes/ZEVuFu295ZaqvdihGCDh1SEPQfwoQFDZAG9tVhLQgLIadwTB851ErQ==
X-Received: by 2002:a0c:8e08:: with SMTP id v8mr17169964qvb.4.1579799157846;
 Thu, 23 Jan 2020 09:05:57 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id d9sm1202507qth.34.2020.01.23.09.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 09:05:57 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: original raven doesn't support full asic reset
Date: Thu, 23 Jan 2020 12:05:49 -0500
Message-Id: <20200123170549.4179-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123170549.4179-1-alexander.deucher@amd.com>
References: <20200123170549.4179-1-alexander.deucher@amd.com>
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

So don't use it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index af41ee4c9639..15f3424a1ff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -537,6 +537,10 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 
 static int soc15_asic_reset(struct amdgpu_device *adev)
 {
+	/* original raven doesn't have full asic reset */
+	if (adev->pdev->device == 0x15dd && adev->rev_id < 0x8)
+		return 0;
+
 	switch (soc15_asic_reset_method(adev)) {
 		case AMD_RESET_METHOD_BACO:
 			if (!adev->in_suspend)
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
