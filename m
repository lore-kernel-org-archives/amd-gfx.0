Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A42BC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C18D20738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgJBnUKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C18D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3EE6E2E6;
	Mon, 24 Aug 2020 16:15:44 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595606E2E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 16:15:44 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id t23so6565534qto.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w1RxilnAk64Ue8kavIL9UgQkrO3vygEHe9JUJ/xgiIs=;
 b=FgJBnUKQFrkaRj8VaOWSPBa1WvPTtaFU/FU8Fv7rMV+hKYqw8Vgl25bqi3cvRKSPeg
 h76HslEYdrgvXKrvO8qFnH8tL8hY9yoOIMLS7DmYl4HRuZ16ywA4G3mGS7xYeAGLdWgv
 Opm05QeKKR2cJEOkFa8ELk1XWpXsXAfbTO5ES1OIQIljvOe3zh5/Qa2ExlqNyc6KMObl
 0boB6t1RkbEkt8qxvdj63ugnJZsut2nVPwvjXNHmMIlCM8xDA6iFW8IR6wt+AU03/qE8
 NqMaMcx2NDTAf9bvZpDpbfrP8Azr1IPmRvokVD0tAjm/Akd1aQzZT41ALcPnJ+9ltd6r
 NT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w1RxilnAk64Ue8kavIL9UgQkrO3vygEHe9JUJ/xgiIs=;
 b=Lp4zmQqQAnwTs6UVOllZlr8aIuMscChsAO2HGtBQeswX8JagdnwxJqj9yg4II59+sj
 BKWXopwtKqx1yhMkO2vaU5RhPs2oPke3u6BhWU/TV39SGCDdGaOKHg5YVwn6z0rih4h1
 i35zglzyrWYMWJllDMz0C8j8uvzX9kVJl2CrIO9d019+wiMIXB3ZMB8nX0ZP69MQSsZP
 DechtJrGOV+9CrgRrEz8OTE6PKz4icD+1tBOZJQebQoqW81fKIiX2wjKDRDmDrS4cR4l
 rcMkakJLTe40MyEwhQxepQflLYrCfUAJnIvOpvu7+V2V+4+ojN1evBcdoPpAeayNgT84
 o7AA==
X-Gm-Message-State: AOAM531ZbUYkC1F1jbApENhcDY2iazxRpRewYF6hjmSiVw8JkAkvY5CB
 Kn5hLuAMux0V3LHiyUWBniJgwgYLXbQ=
X-Google-Smtp-Source: ABdhPJyy4kEbBa0TG0xhExWdV6z3Z+BAYW/OHDgyedZUY2I1lk44qr9XJHFx9K0PyTk5LN+YUKHocw==
X-Received: by 2002:ac8:45c3:: with SMTP id e3mr5496743qto.149.1598285739307; 
 Mon, 24 Aug 2020 09:15:39 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id q7sm9654097qkf.35.2020.08.24.09.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 09:15:38 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/amdgpu: add an asic callback for pre asic init
Date: Mon, 24 Aug 2020 12:15:21 -0400
Message-Id: <20200824161527.2001591-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200824161527.2001591-1-alexander.deucher@amd.com>
References: <20200824161527.2001591-1-alexander.deucher@amd.com>
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

This callback can be used by asics that need to
do something special prior to calling atom asic init.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 54666eea1863..4746b60b5327 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -617,6 +617,8 @@ struct amdgpu_asic_funcs {
 	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
 	/* device supports BACO */
 	bool (*supports_baco)(struct amdgpu_device *adev);
+	/* pre asic_init quirks */
+	void (*pre_asic_init)(struct amdgpu_device *adev);
 };
 
 /*
@@ -1129,6 +1131,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
 #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
 #define amdgpu_asic_supports_baco(adev) (adev)->asic_funcs->supports_baco((adev))
+#define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
