Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A74C64E7A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 03:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD35A20C56
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 03:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD35A20C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038886E9A0;
	Wed,  2 Dec 2020 03:05:16 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D286E9A0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 03:05:14 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id i199so59601qke.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 19:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/+bWujkiLNTU6rB+x3AIavr8WqNp/OnG5OjrB2ee3IM=;
 b=AcUam7Ru7nu1kfVv1HGD/aUSEEFD95wP/SfUkTerG3WncTeuYkn/k83uPYXP+b7bq0
 pkS1yFUHv8Nmq3tq51y8CJmIhbg9VZbLyypyaIisi26wtthgs4avtPM8l1EH+Bh9AKvp
 lNTR8wRB+/lzbb2F41gabPsufxlomjRBkdsPZsI3EhF8giAAofcuMv7E8Oxq/ikziIIS
 ebJTTc3oF5OT/xtpGomOsWWaTXRd4mUID5MIImFVIMlC4vqHqVNvn/azGISPOxEo8x0J
 LjLuvrlHE6PzOY3bQF64TBVxquunvQmY3yzsJg3fjzY2cr0WMsAVSPAx4XtJazubkdlH
 0T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/+bWujkiLNTU6rB+x3AIavr8WqNp/OnG5OjrB2ee3IM=;
 b=SCeE8zHYW2UvCsdduXDR16n5qrNANvfmGbErGbhz/OMayxBwSACjtvi/3bfBrn4PFK
 K20un59DFhJsR43wmSBIwaxL8Uw6UfG/hqjUF+6bj7SoS4SsWf6uWxL0n4teIY8+IqIc
 5PBJXFVoWGyT7UtSqlEXh5QWiT1Vmyrl2J5tYWKsBStuE6A/wIT1PMMzHG1gOxLol2+D
 mu/8pD+C/O6HcjJag3dq8TRSUFR+PFrLfBW9WRQqak4xaGbzwyG55voo0n+8izPBQEJ+
 +E98l0n6wGo4Kxt/Ou5cfl/S+1KzbMX/y8UekC7ePApzBU/Mk16EBEAQ6ZBUZ3LGlkjX
 3dDQ==
X-Gm-Message-State: AOAM531TR+0H6KiHZQ3OAAGSwohRfnhhNA2+IbcYt0PcD15AoZud6Ed4
 JgOniTfvb6w+zgAYGJsiYMjhamX2U0E=
X-Google-Smtp-Source: ABdhPJx5sVGP9BoameGdfoutfF6fEaw5CrVENZA8oRHH1EGf5QTQ+IfiHzn7Lft9syD7oCzyX+45Lw==
X-Received: by 2002:a37:4e0f:: with SMTP id c15mr563932qkb.449.1606878313480; 
 Tue, 01 Dec 2020 19:05:13 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id b64sm471411qkg.19.2020.12.01.19.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 19:05:13 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu/swsmu: add metrics enums for voltage
Date: Tue,  1 Dec 2020 22:05:02 -0500
Message-Id: <20201202030505.1310154-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

To be used in subsequent patches.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index a559ea2204c1..89be49a43500 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -613,6 +613,8 @@ typedef enum {
 	METRICS_TEMPERATURE_VRMEM,
 	METRICS_THROTTLER_STATUS,
 	METRICS_CURR_FANSPEED,
+	METRICS_VOLTAGE_VDDSOC,
+	METRICS_VOLTAGE_VDDGFX,
 } MetricsMember_t;
 
 enum smu_cmn2asic_mapping_type {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
