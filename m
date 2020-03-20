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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8466CC4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D08220767
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m59Wa9OX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D08220767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0FE6EB5C;
	Fri, 20 Mar 2020 18:27:52 +0000 (UTC)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 266806EB48
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 18:27:51 +0000 (UTC)
Received: by mail-pg1-x542.google.com with SMTP id d17so2935864pgo.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hl8dBoKRKHEgUBGqdOBVKbo+anx261TFHiMTTazQpos=;
 b=m59Wa9OXsDx4l9J9Dg1MAOcm7KWXSbQYWSEJpVMsmwAhzMKaTNHYrwUkqmDWJ6ISYD
 iIdB8w2Rg5MlcTbqEQR3WEXlkAoAyhCXyLeFgP/hV1aZeAeMyE9445L1ohn8WsYVv1R1
 3uqSE/Nmv9RAqIxlHO9Qg1la5Hw0QpOAudN06cutkdhTpqFKnqjjLSpxweBSj01OinoE
 XeZGIFg0eKaQZZpcFGZ4liNSv0kMLZadiwSkk57oixHm+C1qnOMqHurEoSUV8QIsC4FN
 8ok8CTa1VmXubgg1M+Wq0aCIi1kD20UZ2biTcSwcEJFWMxc6dpWOo08dj4R3ggXCw+hM
 JNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hl8dBoKRKHEgUBGqdOBVKbo+anx261TFHiMTTazQpos=;
 b=rVqeJAffkNb36YKSjl1g7D/B8wGLLzNoNMDo5Wg30TQ6+rHtEye502OsZrK2dJPS4Z
 f6zekmMY92dctf2yZAXfdi95nA8pGG8ker3DyFg0VX3NUTTvD6ua07ce1qruEoQWlrOZ
 I5MjshHcwrvngBERx6D9QNiYpoYyAmjbsMWL6iQFfehAkoMzu8XqYRZNHuXRIZ+T2Iq+
 HE6yyDpX3tZyitv0UEwj13Pkt4Nt8ZoX78+kAQoqnLWqP0ajpBuoBLz2sQnT3aIQhfhE
 IXMZcPUiTFFcQnR6u4BE/OUNA2v/YIqUfZFEw8DEJ8+EMaB5l+0q6DJ7BqIhIShKTfaU
 IPxA==
X-Gm-Message-State: ANhLgQ2CWgT8HvWxoZ/swWt+W2+C1Xo0ty47aTR2D9zoIa1R2lU3HGWs
 88oneAEgsisxUtI8Hx13llmUx0OZ
X-Google-Smtp-Source: ADFU+vsDfgMKU13ONWK7Ae1frrwPnk7KDO2N+jVx+MVEkZ4LN4zkfv9ACN+zhs/zjDkbVZH/h2LHbA==
X-Received: by 2002:a65:428a:: with SMTP id j10mr6579290pgp.272.1584728870509; 
 Fri, 20 Mar 2020 11:27:50 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id v185sm6233850pfv.32.2020.03.20.11.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 11:27:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amd/swSMU: add callback to set AC/DC power source
Date: Fri, 20 Mar 2020 14:27:20 -0400
Message-Id: <20200320182727.3805-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mcoffin13@gmail.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

This is needed to tell the SMU firmware what state is in
in certain cases.  DC mode does not allow overclocking
for example.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 657a6f17e91f..323e7e61493b 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -570,6 +570,7 @@ struct pptable_funcs {
 	int (*override_pcie_parameters)(struct smu_context *smu);
 	uint32_t (*get_pptable_power_limit)(struct smu_context *smu);
 	int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
+	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
 };
 
 int smu_load_microcode(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 6900877de845..40c35bcc5a0a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -211,4 +211,7 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 #define smu_disable_umc_cdr_12gbps_workaround(smu) \
 	((smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround ? (smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround((smu)) : 0)
 
+#define smu_set_power_source(smu, power_src) \
+	((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_source((smu), (power_src)) : 0)
+
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
