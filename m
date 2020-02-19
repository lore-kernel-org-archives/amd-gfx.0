Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3384C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 14:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29662176D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 14:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9g3qoiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29662176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB126EBFE;
	Wed, 19 Feb 2020 14:24:42 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F296EBFE
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 14:24:41 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id l21so281666qtr.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 06:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9i9qAuY4YNzR5K+TUxIWGhb+hR8p68MY7KTYVd6XK0s=;
 b=F9g3qoiugvwT5LmiMDCKBdcu4MNw6fOFd176OmyCECKrHo3PWTCsIX54vk3F6wt9xl
 dgsCjE2aWpIGIZWVVCue9PIRvxzNUbijAIGwdUTkCEKYgDx0a8Btgk+GM2VkyNn8CdlD
 kqf30ziOmxrvCO4pysp32MZm/GVGTW7xhoH7DL7VAemFco852RfzJyzUgNTbeBTy1YUb
 jiUe5k/baSWU0Aa1bbuYvDuuW0HzB8RNyh4/b1itNX0N1SxRRGPU6szzQRaDxionzZvz
 xKm/pcV1C5B7Vl2SK8oaQFoLuamdpwW5M4cY+vms1+UGnz6mY49aQldCPP0E303wMSUH
 bOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9i9qAuY4YNzR5K+TUxIWGhb+hR8p68MY7KTYVd6XK0s=;
 b=DrwuDqBRM2yCJkN62Wh6WhrK7Z9AeAC1713XK+GH2lf5JX5THX1fje3Spw9y+DLipr
 msqFDkB+FUcOU6m66KqIeanNvw8Hcopm7fwHnU/kZqAgTjnzfjZuAmU5YKV+07jn6H9g
 hoKpSb5XsDNoIuIc9Mn4AXByvFX9nvnmFS1ihW5Q+v0avfkOHqSXrrSYIG0NcgHZHVdt
 7zv9WhLBz9GnMoD50Ox8XvXyRPrqLeAeFGzIMbnvM09zA4isqZx0txcpVlBlTGOh88kb
 ZCqjXmd4cBCnhpIkO8kpUsVK3aKpHyyk3olgA7d/GdtpgpqzKJQcOjFO7RIoRExK7tIZ
 EC0A==
X-Gm-Message-State: APjAAAXQtP3Tc4nZcSkOk7UOmem7NMlIJaOwSRaucOzAeUXZfnBF/AJ3
 rS4JbYrx1jHiQs8vcP3zVT/NI0wb
X-Google-Smtp-Source: APXvYqwOm2xWOxjKHfAiMif1ihzzOjAZvCoctTJ9QRtdRBxqZzDHZj1JOc0nLk4keS4TBpUXX3+2fw==
X-Received: by 2002:ac8:5502:: with SMTP id j2mr22831484qtq.127.1582122279712; 
 Wed, 19 Feb 2020 06:24:39 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id e20sm1086673qka.39.2020.02.19.06.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 06:24:39 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: clean up hdcp workqueue handling
Date: Wed, 19 Feb 2020 09:24:30 -0500
Message-Id: <20200219142430.2109710-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Use the existence of the workqueue itself to determine when to
enable HDCP features rather than sprinkling asic checks all over
the code.  Also add a check for the existence of the hdcp
workqueue in the irq handling on the off chance we get and HPD
RX interrupt with the CP bit set.  This avoids a crash if
the driver doesn't support HDCP for a particular asic.

Fixes: 96a3b32e67236f ("drm/amd/display: only enable HDCP for DCN+")
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=206519
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f7d541030698..4cb3eb7c6745 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1961,7 +1961,7 @@ static void handle_hpd_irq(void *param)
 	mutex_lock(&aconnector->hpd_lock);
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-	if (adev->asic_type >= CHIP_RAVEN)
+	if (adev->dm.hdcp_workqueue)
 		hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_index);
 #endif
 	if (aconnector->fake_enable)
@@ -2138,8 +2138,10 @@ static void handle_hpd_rx_irq(void *param)
 		}
 	}
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-	if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ)
-		hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
+	    if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
+		    if (adev->dm.hdcp_workqueue)
+			    hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
+	    }
 #endif
 	if ((dc_link->cur_link_settings.lane_count != LANE_COUNT_UNKNOWN) ||
 	    (dc_link->type == dc_connection_mst_branch))
@@ -5836,7 +5838,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		drm_connector_attach_vrr_capable_property(
 			&aconnector->base);
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-		if (adev->asic_type >= CHIP_RAVEN)
+		if (adev->dm.hdcp_workqueue)
 			drm_connector_attach_content_protection_property(&aconnector->base, true);
 #endif
 	}
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
