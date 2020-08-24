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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AC5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407F520738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFemWSB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407F520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9598E6E2EA;
	Mon, 24 Aug 2020 16:15:46 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FF36E2EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 16:15:45 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id v1so3974496qvn.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1W8I/fI/iKDBgDC4xvNx/Qz0cPLrwCZnp4kM059eolA=;
 b=ZFemWSB2OjgAPDmsAnxOxZr9c2G4oVEuIMbfOsIKPW0eIqEP3HfloKQNTBNvwQR5QC
 ZmEQT3n1WDZuGSAAP0MyLvs8VLgUXq7VzEiqYRKxxV1NgYLosVUAfK0dKMmiiNDuhGgA
 02N2ZyGJEiPpJtWIRlyPdez03jIuTJa9I0UnoGbp/fmqQI2MGpMp+7CMe4iF4hndUFdr
 N4rCemB4Bfte7gzdtb91JHtaijtb4gDzPJbaO54gP0LPSgS4rqz1Y2nzzkQjhbxgXjPu
 XZG8Bncy1NC+UcQlKxhhPa1LyoDTHgdBjLl0kdhL5Zv8Sg+Tzsd8oBU3fru7YW/57fFZ
 JgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1W8I/fI/iKDBgDC4xvNx/Qz0cPLrwCZnp4kM059eolA=;
 b=gxhtxpfLBdYxrwlkEzaE6KfN9n1L7+mPej1n6QsEo8S49KtQSUMl9N46JIyfEKGpS1
 oNomihoqjgX+940shJVeQcxYXWCt0B3UJ3C8KnoXme6Q3No/kzbSqq+LJqr/72WZcsj+
 IY8ygHn+OuUwLIl0G7nPLHId+WEfY7TFmT11mK+kDPhEXWmUESyspAZhEcZauoHlrwIM
 5bVvkVJedRW6ugp0QFacyDqCl42wLnoDY+HUL2a1F/HUg5joTcGgGIiSfqt+X9jzYKh5
 qWnKOufe2wiblKEApiXvyOdQg9M+AFkkMVst/KTEn1gOGKAkqSUABIlMuHIImavhJLqL
 Hv/g==
X-Gm-Message-State: AOAM532ccMhATlpNUfOnRuQv7qpjcKJId+8tUkWwH/T2QIriLxE2oG4Z
 jlMS9O/81U7QS8NOJyGq90Z5mFg4xw4=
X-Google-Smtp-Source: ABdhPJymcV/AkgG6INjdaXpz4sNVviawbLLIN66cWkoutjFq4Kgn/R09TTD2elucZ/Ynn4TpdMRDSQ==
X-Received: by 2002:a05:6214:2a4:: with SMTP id
 m4mr5684343qvv.120.1598285740285; 
 Mon, 24 Aug 2020 09:15:40 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id q7sm9654097qkf.35.2020.08.24.09.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 09:15:39 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: add pre_asic_init callback for SI
Date: Mon, 24 Aug 2020 12:15:22 -0400
Message-Id: <20200824161527.2001591-3-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/si.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index eaa2f071b139..455d5e366c69 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1871,6 +1871,10 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 	return 0;
 }
 
+static void si_pre_asic_init(struct amdgpu_device *adev)
+{
+}
+
 static const struct amdgpu_asic_funcs si_asic_funcs =
 {
 	.read_disabled_bios = &si_read_disabled_bios,
@@ -1892,6 +1896,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.need_reset_on_init = &si_need_reset_on_init,
 	.get_pcie_replay_count = &si_get_pcie_replay_count,
 	.supports_baco = &si_asic_supports_baco,
+	.pre_asic_init = &si_pre_asic_init,
 };
 
 static uint32_t si_get_rev_id(struct amdgpu_device *adev)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
