Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C58C64E8A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DC420870
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+IMIYdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DC420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F9C6E87A;
	Tue,  1 Dec 2020 17:44:26 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725C86E842
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 17:44:25 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id i199so2096242qke.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 09:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vsII7laRqYJOAv6hktbCtmrRioJEBhrchV8sly0Liio=;
 b=q+IMIYdAVdagL9+GV1wvflzMcRfhxHEhnl7aHH10zgx94wUxK/n2xdJ6TXN6ex5ftE
 YjLmpZuhFtwwY+K4x4ArZw1hYs7f4CK2diXydNQOUTmkIYOhfiCtFsb9IYEg0STWjBrz
 xu00L0H4TVJwkUfMc2zZ74wmRLb9ABEpuVhwL0nkzZoIEMIbQqOIRfJkWtrCrqL9bOcY
 Y7pc8SV8xymTMw6fvmtqN7YSinQ1XP57d2TTdagIFSjC8fS31ANRvoGw4ergFwWAFt5T
 v1O2R1rvCqNx3egRvYKNfk3mw2AZdJ+jaoCJ34MnDVDJw32A+APgHwehDs80/U2cSOeM
 gknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vsII7laRqYJOAv6hktbCtmrRioJEBhrchV8sly0Liio=;
 b=R5atX0jUylRICSRYgQr+bXF9gAOHBL86be8aRT2g/dVCl4r5T6ku3ujeBYUyoFMVlj
 gYsjoadicatXSKD7OzDpS0p8vrPs8pauit8bYxyzfvxz5RcvUQW/ugaoEz0fhkR7lBa6
 39Empixdzat/VId7pkte+hq96cK0VlNYidbUKa3Y9xbScJThgUUtq7/rcg5eeRt2q9Uu
 eKmMzevM0+Uy/0OZYqs9V8zBk+iyACg0hQJ9z8b2yTUTWNl26WNFRSMt0IbSFmvrnam6
 Ymuh7juXxYlcnMkTVWx5OYLxBZOSdLuXV/XzaEkGPXc1gWPt7ebyzQ2Dp0sHu8FH6Da3
 9JMg==
X-Gm-Message-State: AOAM533Sy9VeTB3QQ1CKERTVGbP6Ntpo3qmdId3J7KUBNecFDNlTR2P7
 m/uPnCh2u30/Mxex9mYR5VeRL2Y4Fe4=
X-Google-Smtp-Source: ABdhPJwLhhmqLFdPymStdMA34iFf5A+iVMLCNNck7u26OfesuLTYfTV2GnUXQwvTHKJLZGskk/A53g==
X-Received: by 2002:a05:620a:11b7:: with SMTP id
 c23mr4003774qkk.156.1606844664417; 
 Tue, 01 Dec 2020 09:44:24 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o9sm302170qko.53.2020.12.01.09.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 09:44:23 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu/swsmu/vangogh: use metrics table for voltages
Date: Tue,  1 Dec 2020 12:44:12 -0500
Message-Id: <20201201174413.643254-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201201174413.643254-1-alexander.deucher@amd.com>
References: <20201201174413.643254-1-alexander.deucher@amd.com>
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

Fixes voltage reading for vddgfx and adds support for vddsoc.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 1645509cdab8..3bc7395c5fb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -265,6 +265,12 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_THROTTLER_STATUS:
 		*value = metrics->ThrottlerStatus;
 		break;
+	case METRICS_TEMPERATURE_VRGFX:
+		*value = metrics->Voltage[2];
+		break;
+	case METRICS_TEMPERATURE_VRSOC:
+		*value = metrics->Voltage[1];
+		break;
 	default:
 		*value = UINT_MAX;
 		break;
@@ -469,13 +475,21 @@ static int vangogh_read_sensor(struct smu_context *smu,
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
 		ret = vangogh_get_smu_metrics_data(smu,
-						    METRICS_AVERAGE_GFXCLK,
-						    (uint32_t *)data);
+						   METRICS_AVERAGE_GFXCLK,
+						   (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VDDGFX:
-		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
+		ret = vangogh_get_smu_metrics_data(smu,
+						   METRICS_TEMPERATURE_VRGFX,
+						   (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDNB:
+		ret = vangogh_get_smu_metrics_data(smu,
+						   METRICS_TEMPERATURE_VRSOC,
+						   (uint32_t *)data);
 		*size = 4;
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
