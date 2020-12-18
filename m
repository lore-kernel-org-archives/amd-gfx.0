Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF80C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 16:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D838323B6C
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 16:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D838323B6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A0A8947A;
	Fri, 18 Dec 2020 16:01:10 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E328947A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 16:01:08 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id b9so1602046qtr.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=we/3rRN4Uw/vkZ5YcsbdjiCOM0ulaTGPOVj+JR94VGA=;
 b=DvvTzahmgv3Caea6pVYF0okkaxBBOwXgbD2vEOHxJyVL/JBT0/MGFors/Sfl55t74G
 KF5BFRk2/CgWX0mwJOQ08T52iKTqrGk85RJahf220Qtwh8OffKIgPYShNf038DgtmR+y
 undSnU6Gt+N+64M5EKmNNctQ2Dzlv0FeMiIpF2vCxC0WugFV0e8v9ZUnJe4F1+sy0Paa
 c71wWjtarxOwEB/Z04fWEcpDvzAAE/mD8PS527VIpHoORc/0Va6nXOqcIuk7XQiN4b39
 RNIR7bjZKD8jOoaumbeY3M/Q/Wjh+A/Dp17vcpHKLIN3nkW8/FmLlUChzOY8FKnmd02B
 olMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=we/3rRN4Uw/vkZ5YcsbdjiCOM0ulaTGPOVj+JR94VGA=;
 b=DoTTOyPV8hMQJEpRAuWkEwbUn5enuiDh9QECqDIn1xs+PZKILTWLxkJYIvP27ZeqLc
 21HIR8LoPGGUvnJwUpxTgG47NATBCH/T/GDBx1hSfQQC2AcWBF26VZXZv83sNcVSZCOf
 yNmCbZvurLXW+3UsUHv2mVnmqBkTiXMJ6zUImy6THfzolieITaH6R6qbs3sHEttP+QPY
 efAvXL1H1A+Ycr2cnU6gx5bwvWW7DcPNLs1pK5z+8kmreAqX2//PJAmzUVK9wt7lJGYv
 M8FYz1pQoIfmplZ1mnmYMyT4QvRUGhFZw0/fvgcET3OcWRdRvqPF4yvt9qVObHBU/nok
 tSSQ==
X-Gm-Message-State: AOAM533ZiQ1K2iesM8ZMyvoQm5UbeU6s17C/TiDFUW46/tGxbaD8zjOV
 /2hh3SDMmSuUu4e/hT45X5cDglVS7L8=
X-Google-Smtp-Source: ABdhPJzfQ32VMh6KpUjVzxaOoxADxVndhOCYQFjq4IT7bAHYGqnxgcvqX7Orgz7r6PKbo3Qk+kYxag==
X-Received: by 2002:ac8:4e05:: with SMTP id c5mr4576957qtw.359.1608307267712; 
 Fri, 18 Dec 2020 08:01:07 -0800 (PST)
Received: from localhost.localdomain ([204.111.139.145])
 by smtp.gmail.com with ESMTPSA id d2sm5259183qtp.71.2020.12.18.08.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Dec 2020 08:01:07 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: only set DP subconnector type on DP and eDP
 connectors
Date: Fri, 18 Dec 2020 11:01:00 -0500
Message-Id: <20201218160100.6477-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Oleg Vasilev <oleg.vasilev@intel.com>, Kris Karas <bugs-a17@moonlit-rail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes a crash in drm_object_property_set_value() because the property
is not set for internal DP ports that connect to a bridge chips
(e.g., DP to VGA or DP to LVDS).

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=210739
Fixes: 65bf2cf95d3ade ("drm/amdgpu: utilize subconnector property for DP through atombios")
Tested-By: Kris Karas <bugs-a17@moonlit-rail.com>
Cc: Oleg Vasilev <oleg.vasilev@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 65d1b23d7e74..b9c11c2b2885 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -1414,10 +1414,12 @@ amdgpu_connector_dp_detect(struct drm_connector *connector, bool force)
 		pm_runtime_put_autosuspend(connector->dev->dev);
 	}
 
-	drm_dp_set_subconnector_property(&amdgpu_connector->base,
-					 ret,
-					 amdgpu_dig_connector->dpcd,
-					 amdgpu_dig_connector->downstream_ports);
+	if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_eDP)
+		drm_dp_set_subconnector_property(&amdgpu_connector->base,
+						 ret,
+						 amdgpu_dig_connector->dpcd,
+						 amdgpu_dig_connector->downstream_ports);
 	return ret;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
