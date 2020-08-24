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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0348DC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCFD20738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfsMVeQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCFD20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A016E34D;
	Mon, 24 Aug 2020 16:16:01 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3990895E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 16:15:58 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id m7so7865367qki.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0SR1xregzojvXdhnB2BPK5dTcF4znRDs3kVkhE/RVu4=;
 b=GfsMVeQxIuUiyDkdXToMLrjqHcVehC/wT2epMi5yzYmX+QYt8JqqhQ+LIz7Hwkspbb
 qDvaAQY3pA5yko2UrwhNZlRXtPFffJ4NfAvEvXOeESnvfR9B9kkzUvWrUozpXEDJL+2y
 ucGFlegnqxqrG5Ug9GeiwukAOiqbRFDSa6lAXnzQ2gsSD+GMw52VEnbdFamExgGuhNuw
 /4+XWQPxV3XGokygL2fP+8UpEG0/desux/9ce0eE7yu/UVRu1U5dy+mD+uzZsf3nDf6T
 LrU1SbbVXoirCyfqtsjqBl2j5HSqowiC4mw73vud6iFmId3vspo6zJawTtvX+NcmZq/Q
 knmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0SR1xregzojvXdhnB2BPK5dTcF4znRDs3kVkhE/RVu4=;
 b=Q9NkREgERFScTt/CvvVpRkk39MGHrzx5oI+1GWSG9+ekiZYkfnVZASMJ+RkCQ1x1CL
 NVcok9k4/sUkKn39XZx6M/N8zGkXI2VNYFOIz6SifGb38h+t5voPjXQ5lEA410RrvoVN
 kNJ0QRKrPjVpoGpkEkj3pJR1Zhqw28kSSIU/tqu82Hj37+aWYv8uyuJYbgshSksukeVH
 Ob8Fbb4acI73kIsOva1aAYm96Gwsei/L5a0DgcYteZS/dsUdV0WfJeMZP+3w4AcKzcKf
 EsrYqXsd12wHp76ZD7FGA3zZ1Bl70QRsjaNcGDwziD8lTOfogk9moA7Mu9asn60TDU5O
 hCHQ==
X-Gm-Message-State: AOAM532onPBd0PgcDvZ5nvwlyJALKSP20adrIERExzsiyunJ3B/fBh/X
 dDFqmj93/ZEdScjB7zVQyPOyj4tMMsg=
X-Google-Smtp-Source: ABdhPJyK0J481z28x+CMsS82GGswAXjHnIuV+3HdC92uscYm0ujw/4zKe2sv0xqjCFWxNhd7UVRrXg==
X-Received: by 2002:a37:4ca:: with SMTP id 193mr5431389qke.198.1598285753906; 
 Mon, 24 Aug 2020 09:15:53 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id q7sm9654097qkf.35.2020.08.24.09.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 09:15:53 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdgpu: add pre_asic_init callback for navi
Date: Mon, 24 Aug 2020 12:15:26 -0400
Message-Id: <20200824161527.2001591-7-alexander.deucher@amd.com>
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

Nothing to do for this family.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 54e941e0db60..33a6d2d5fc16 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -691,6 +691,10 @@ static void nv_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.sdma_doorbell_range = 20;
 }
 
+static void nv_pre_asic_init(struct amdgpu_device *adev)
+{
+}
+
 static const struct amdgpu_asic_funcs nv_asic_funcs =
 {
 	.read_disabled_bios = &nv_read_disabled_bios,
@@ -710,6 +714,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.need_reset_on_init = &nv_need_reset_on_init,
 	.get_pcie_replay_count = &nv_get_pcie_replay_count,
 	.supports_baco = &nv_asic_supports_baco,
+	.pre_asic_init = &nv_pre_asic_init,
 };
 
 static int nv_common_early_init(void *handle)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
