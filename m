Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4721C4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B4320767
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9WyQq+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B4320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593756EB48;
	Fri, 20 Mar 2020 18:27:53 +0000 (UTC)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973326EB5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 18:27:52 +0000 (UTC)
Received: by mail-pf1-x444.google.com with SMTP id 23so3735169pfj.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p0Nmk8bt6ORcqF1ozmG3Vgk759IcO7q91Amith9+chg=;
 b=O9WyQq+irOyIZFIx/S4Pft7oMiZ15iwrvHRJrVETi08YnW6QSZLMrPgW4rB1e+0Oav
 +kEhCv6FDlvxbJ9NGBB/nRJsMIeAGb339CbYJnDtftaMHB8IlNuR0XdQdo6Pz1fLfDg7
 c27uxLz5O6i3DPfuHedqKwo/OObj2rpImurizBcyhPjFQAl0X/poPxzD6dlZLG7uDHtu
 OySdO6wj1ncbFsMEsJ5Q911uWRtvTP0cjyXCIV8O1guBmxrVlrHfbcdcCv7sbmqFlP2T
 XbXmEY60GL9oB/oGs2z6IS6tWUXB247G0NMlQl2rj+yy1DnU8Vnp8eGFbHzKyNRxhMWS
 UKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p0Nmk8bt6ORcqF1ozmG3Vgk759IcO7q91Amith9+chg=;
 b=n9oejdI/ZN9Aaf8qxlPlQUSY7C1r85alYo9WHWCEYe16OwCmWY2G/cATXUNoXqj5ux
 mUieJ/px2CsGi0J+ikmmnA6AlYn0LU1cvNJreeiEpaG+4XYt7rZOzRz0YV/czpavb4yU
 OOoeUjtBhcvIhTV6k9EIR0oE3P/9to6BAjB3pSSwUUONvGC9O2C2qEKjCCWQMzDH6drx
 iAhXfPW8aLe0TXcvzXL21deR2QYIFVkK1/1N/tKS++44M4swNALAIx5RQaVmW6ObUjPu
 dUziXMWLXAtg81a6j8gmCXSZE/B71bQjb6eLuE7vgmLuujKg0HTvuA6AB6b20qZhAfNp
 FbRA==
X-Gm-Message-State: ANhLgQ07OLjSYXdteu4S8pudBaePbTKJvnp+Z3ExSkOPlL5E+5D3Ccqg
 sFHvXc2j1HuYj5LsI08p/a4N/2IG
X-Google-Smtp-Source: ADFU+vt1xv4OsR8POs/bh6ZrwEi+3Wa5INDFGCLLLVqWkdRYiSig6Hdd8v4gFQnEi69m3tjzmOlNCA==
X-Received: by 2002:a63:714:: with SMTP id 20mr10365425pgh.271.1584728871870; 
 Fri, 20 Mar 2020 11:27:51 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id v185sm6233850pfv.32.2020.03.20.11.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 11:27:51 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/amdgpu/smu11: add a helper to set the power source
Date: Fri, 20 Mar 2020 14:27:21 -0400
Message-Id: <20200320182727.3805-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320182727.3805-1-alexander.deucher@amd.com>
References: <20200320182727.3805-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mcoffin13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a common smu11 helper to set the AC/DC power source.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  3 +++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 1c88219fe403..674e426ed59b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -267,4 +267,7 @@ uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu);
 int smu_v11_0_set_performance_level(struct smu_context *smu,
 				    enum amd_dpm_forced_level level);
 
+int smu_v11_0_set_power_source(struct smu_context *smu,
+			       enum smu_power_src_type power_src);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 4fd77c7cfc80..20174bed11ce 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1939,3 +1939,18 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 	return ret;
 }
 
+int smu_v11_0_set_power_source(struct smu_context *smu,
+			       enum smu_power_src_type power_src)
+{
+	int pwr_source;
+
+	pwr_source = smu_power_get_index(smu, (uint32_t)power_src);
+	if (pwr_source < 0)
+		return -EINVAL;
+
+	return smu_send_smc_msg_with_param(smu,
+					SMU_MSG_NotifyPowerSource,
+					pwr_source,
+					NULL);
+}
+
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
