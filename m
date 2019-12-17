Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FECAC3F68F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EFB21582
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5/Hv6E1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EFB21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64586E147;
	Tue, 17 Dec 2019 21:45:57 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD49D6E147
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 21:45:56 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id x138so2550929ywd.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oYKJgrHPFUyUfnSIVXAefgzyEaw5upaKBPay0t+VC1E=;
 b=j5/Hv6E1uohflS+4hNF1i9KruU/3Z0OUCP53eWYw8cpM3g7BAlQ0RHz7RDxz5MjjDX
 0y24KmxdCjTzxvLI6BaJRLW3CAHqomVCw40nlFdAO4CLuDRFx7+4lCwz5XItJmPu2uIR
 VipZLbukS9zeG3ShwgZRzGtxvAJZhlJuQy71QI/McsrtzC2NBca0+1LKMEdxhlHNYu0q
 FuvkqC4bPDyOiLZTO1CYhOTJlsxrf9VR7IdQpAIVK9/v8Y7elxXhPZZhj7RedZwngZeu
 PJNDV9dm3aHRNlWb67C7erB1kd4OrGOFjrJlVcrOQQJe4/Xy2lkpmccIS6JK13D+UGXv
 eKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oYKJgrHPFUyUfnSIVXAefgzyEaw5upaKBPay0t+VC1E=;
 b=CU4PjY0+IXwKvUYm/iIBNl80HV1HJjSd5g5GOA2vbPL/SAln8Nc77iV4hJk8F4l4wT
 epy6zT/yCX45wsxw7Kg3VV85VRFofjM83zpBF5scz4r/2bmAN1q11eMSwRz8JOTG+ZtP
 2AmJuxs2SfG1WlTHMCCogrdwh+XFUNPrCaE+A06nBcv9y7qscmmN0dNxX0IZZadU4h3Q
 lfoCA7+e6JHwRot/3dldVgoScUvwi89u1FPbTjUtTBaqG4jwuzQhBENc70V7kstTsmJI
 B19qT3UWgBAq96JIfS25aTeW9bTQaIqi7lZsPejj/z97nSoYEdjs4nRdnUd6dSwGj0WE
 d90Q==
X-Gm-Message-State: APjAAAUR8O71jQcc1Y65OzFDHK1OcW8Y3oofGxrrW4FmR8aXT3e5MoJe
 FjU2goeIdtBCb9howU5eyX64ZSRp
X-Google-Smtp-Source: APXvYqww0JB8BkS/oSbF4NZgqvnQSgXDFPw+v26+XzZXoDgCQJeFTKItLy2cgyp2tVEUTJ7QThgpCg==
X-Received: by 2002:a81:3dc5:: with SMTP id k188mr763685ywa.257.1576619155879; 
 Tue, 17 Dec 2019 13:45:55 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c1sm32728ywe.67.2019.12.17.13.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 13:45:55 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 4/5] drm/amdgpu/smu: add metrics table lock for renoir (v2)
Date: Tue, 17 Dec 2019 16:45:42 -0500
Message-Id: <20191217214543.2285700-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217214543.2285700-1-alexander.deucher@amd.com>
References: <20191217214543.2285700-1-alexander.deucher@amd.com>
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

To protect access to the metrics table.

v2: unlock on error

Bug: https://gitlab.freedesktop.org/drm/amd/issues/900
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 81520b0fca68..979772dbe6a9 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -171,17 +171,20 @@ static int renoir_get_metrics_table(struct smu_context *smu,
 	struct smu_table_context *smu_table= &smu->smu_table;
 	int ret = 0;
 
+	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time || time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
 		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 				(void *)smu_table->metrics_table, false);
 		if (ret) {
 			pr_info("Failed to export SMU metrics table!\n");
+			mutex_unlock(&smu->metrics_lock);
 			return ret;
 		}
 		smu_table->metrics_time = jiffies;
 	}
 
 	memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
+	mutex_unlock(&smu->metrics_lock);
 
 	return ret;
 }
@@ -239,8 +242,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
 	memset(&metrics, 0, sizeof(metrics));
 
-	ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
-			       (void *)&metrics, false);
+	ret = renoir_get_metrics_table(smu, &metrics);
 	if (ret)
 		return ret;
 
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
