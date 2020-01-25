Return-Path: <SRS0=ij9B=3O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972ADC35244
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 18:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3CF20716
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 18:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlVgNsyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3CF20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C6766E8E9;
	Sat, 25 Jan 2020 18:48:56 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF576E8E7
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 18:48:55 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id e5so4278803qtm.6
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jrdAiBs/SSPAiykov+ZluNeNUPA+g3P0nHWF4rVAM4Q=;
 b=AlVgNsyjSlElFPiLTzq+5ufowqKQqdSHWo19Yi6ud4JB524x3zQSg3sZiJOV5kQC5Y
 Syu4csueyoukPXOgR2e2yAeNu8awYntlbnX0VSO+NgDJAmuihF74HVugRoNVLkJdl8eT
 Zi+LwEgCpE9uS9/pGs/+nw1CvkCD0Kd8rASgsfI3yYLGY9h1CWYLKChTkWYhVW/MVcHI
 TgFyzdH9RtYmkHbGxTSSpyZzCSQrXJkxlyxiOkaCyo5IV1Mcz6/fpPPP2coR0eubJABG
 jFBaf10erPXZNzwVHa6eufVE8Ea+V9fKBlABnC6k6TlES+4mJc7sIyJTXHUHOy/wWHJ6
 G9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jrdAiBs/SSPAiykov+ZluNeNUPA+g3P0nHWF4rVAM4Q=;
 b=npcQm0387Km4o3F/0PbznweZK/2erD3I41t4WqB5uUzfp5MrSHDmClV87KAY75KXWv
 FGjN26VqJRCVM0G82yhHoxgonfdToPr0OUX5g0POQuojMJ+SvHWrS/CXbAumkKoYnJep
 nhT8jE32Zxyk8+FwW48DEwIaQG8EMq/zfXHQMH/an0y+0BGNv9C5s4TuCApUAbxrh3Cu
 cR/8592/6mEQlXiMXbWSnM8P4TBMJOxjnAJoPLFNVo0pRO9osIsZIE23bRmypMq1EpBq
 6gcB9BvJ2LqnL261LVXDpLQ6hu8fPrDgEdL4CHPgJ3nifN4oFqTfFwgTkYJPNArlaOaA
 9Duw==
X-Gm-Message-State: APjAAAVDrYqOFFbB7+Da+/h5iQO1GwxJMl9GtlsOVFj1kW3tDHHL/Kgj
 kTcuBC+P2a9vtzI6yIRxEsNTLD0I
X-Google-Smtp-Source: APXvYqxIX6bs68X0XZKEH4gY3PoimiyI0OgWp2uswvF/c/O7LU4uv5Juylgj6pYpchrglb6ZsFZ9+A==
X-Received: by 2002:ac8:2ffa:: with SMTP id m55mr8582324qta.189.1579978134206; 
 Sat, 25 Jan 2020 10:48:54 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id z6sm5565118qkz.101.2020.01.25.10.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2020 10:48:53 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/navi10: add OD support for restoring default
 table
Date: Sat, 25 Jan 2020 13:48:45 -0500
Message-Id: <20200125184845.4233-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200125184845.4233-1-alexander.deucher@amd.com>
References: <20200125184845.4233-1-alexander.deucher@amd.com>
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

Was missing before.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d2d45181ae23..f60762f9b143 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2062,6 +2062,14 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 		if (ret)
 			return ret;
 		od_table->UclkFmax = input[1];
+		break;
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
+		if (ret) {
+			pr_err("Failed to export over drive table!\n");
+			return ret;
+		}
+
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
 		navi10_dump_od_table(od_table);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
