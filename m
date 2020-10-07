Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E1C4727F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845E12064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPx4fPZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845E12064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027D46E96E;
	Wed,  7 Oct 2020 16:32:40 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193926E96A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:39 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id 188so3409814qkk.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KUNt/P3pq6J6fCaGNQoIDi0hIeF1hJu/6TEiVOmYX98=;
 b=dPx4fPZE13rL85LBq8ES28nXffVeW6g1UK8ngSjPGZlC3JmZ4fjSfqp7sINBpLW05e
 Se+INGYcv4idboMC6PH7ZVYI5RhuhXTZs7VWn5EvPfOHXUps58E7AmYmT0wY9RLmSRgu
 6c29OC+MQNJhYxRU1hTYbKEF9kJphozBqZ57/dLeX8I3X5+J2vV7woeW4kYCEaIMSUcK
 umNXM3RRe+smogpSWorUQUekSVAf55nqxxpaiv2rPvQyGnnAYv39AnDQikcrdyQZFxYf
 4EpNPmopYHvpE36ucGloCQhnXU/llJpM4v/g7eDa3zmd9Mq2DoTddNksQCrMgXS2OxAC
 RZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KUNt/P3pq6J6fCaGNQoIDi0hIeF1hJu/6TEiVOmYX98=;
 b=reQHoUssdK/d/HshNMthJC6O9m4tzzXuDRAZsZw9+/5FJPpmS9/lUMi0hjmB0dpzHW
 v7X49Mr0w5edTNoAdQeGcdavPlfqkl0J/HmEbNgJISZo8Xfd2KimyZC/Ht5Q4sLHZU7Q
 tLbvGOn0Vna1p0bdxpG9MgVfgJji1YjSwjR/T0vEatUDafj0hPSD7XFfLbswFOvaAn+U
 NWv57G3yTInR09kXA3O/u4QcBqhMagGYb3WR2teReNqTzYNREZar5uAHI5mqH1BzTodb
 zLS6Nyt2mp6RwNF8S1UQ2VLuatn6JEdN62R1B8f1eW+IdWs6i09FHtYzuILJdrz4ri6B
 0Uyg==
X-Gm-Message-State: AOAM530X0+n3Ti0JS6tTaZj1Pwx4owVN312fkbQw6IIAEug7u7T8MRG4
 m+V6g9tF1gbHmV+Nz9urJ4zpPHoyzb0=
X-Google-Smtp-Source: ABdhPJyoy5roQJd9GL3wCelYjCo8YHm4V6okF44EMcVumZtQCV5ZdpX1AaPGRZoUWVrd4zp2cwL4Sg==
X-Received: by 2002:ae9:efc7:: with SMTP id d190mr3819206qkg.12.1602088358040; 
 Wed, 07 Oct 2020 09:32:38 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/50] drm/amdgpu/swsmu: update driver if version for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:20 -0400
Message-Id: <20201007163135.1944186-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Update driver if version according to PMFW with version 0x003B0100.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 9351abf99b31..4ce0d484b73c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,7 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x01
-#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x1
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x4
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
