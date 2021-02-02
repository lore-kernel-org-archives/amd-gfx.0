Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68115C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 17:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1FC64E08
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 17:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1FC64E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C569F89CA8;
	Tue,  2 Feb 2021 17:16:53 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE3589C85
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 17:16:53 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id l11so10250562qvt.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 09:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pNh4nM7/sxOtoUx/pCC1XI/SOOKKMO7/2aIWKvIuIqo=;
 b=S8gcbd9DpQnTXpH3N9NocyDNNlJ64BwTrVvlTaA0dKmE5XCd9hdlWynEvoACwYdHAu
 42zz/TQRyqZxUTSmujTa9jx663UI28H7E6w/IS6TlPNCZXYtx4LE7JsRsexdQ1y8u10P
 UwpxDZ/gnL3ggP88QmKnDWBDXwLtR+Fdwk33XmnMn9irNi9p7PUt61uZEhIBOmCTAmxQ
 KIE2zpUz/dbV1w2XRn8Wa2/cQge80xG9a2h7vdqEaiQAjrAkB51DGFqNkxKgQc9mFona
 gh2Bo5wg5FrouNmKFtO4QR8C89C5/rjWZ1bC3ecA7Lxi7lnBA3KmQ9Iz9cDQxrEUuHfx
 4ZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pNh4nM7/sxOtoUx/pCC1XI/SOOKKMO7/2aIWKvIuIqo=;
 b=W74pwNJozXaIPxZ4EZX3e+2ojZgDFTWOZrpavGTLzaDATgt9v/59FAPCfQZND8jG5v
 VuyfPryI+Bn3lbUPr3cXoHYR4gSPtuDFDLS2rYpIpklLEqe/0Y2mHSRvWkCeQZ4IRs6M
 6KooYarezdQZv5/Z/E9d3432LWhwp0WODWpVuMdzR5xtxhcX0pIDsnwD9NnBkkLMH283
 cyMEUFFPyg8TfWMWU4EOk2Q58AGuLni499tw5U6bWMr9H1RTkWksUHwHGKemQz5YBeib
 CbWJqLwc6oMyqVdtqfFgU/WBuNu60rHfSE+BOjU313Wau3hkbfs/NDbbIaQBTLIDV5sl
 2DKg==
X-Gm-Message-State: AOAM530Ustr6RbVAeCZVsYc0nVLt6MHg3WrdcADN5/7h0wS+FN22madP
 dDFbXCIMFXC51aTLJA4FHBxsne1pt1g=
X-Google-Smtp-Source: ABdhPJwkMpL7fwIlie/3D8ThQeIHRJwQC218DxcwEG8LKsK12KutaP2nO4+yW71EfnkizHfr1mlBSw==
X-Received: by 2002:a0c:a819:: with SMTP id w25mr21122464qva.6.1612286212222; 
 Tue, 02 Feb 2021 09:16:52 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id e7sm16977755qto.46.2021.02.02.09.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 09:16:51 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/smu12: fix power reporting on renoir
Date: Tue,  2 Feb 2021 12:16:41 -0500
Message-Id: <20210202171641.1062381-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

Align with Vangogh.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1467
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index ab15570305f7..f6844b90ca67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1129,7 +1129,7 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->AverageUvdActivity / 100;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->CurrentSocketPower << 8;
+		*value = (metrics->CurrentSocketPower << 8) / 1000;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = (metrics->GfxTemperature / 100) *
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
