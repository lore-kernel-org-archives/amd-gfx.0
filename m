Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9809CD6E56
	for <amd-gfx@archiver.kernel.org>; Sun, 31 May 2026 10:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C7810E613;
	Sun, 31 May 2026 10:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBArmemC";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E21410E612
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 10:57:51 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490a765d410so4791725e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780225070; x=1780829870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tCVxwZ/2kSCfKPYf/iRfAPTkHxcF6iOZxH1syXDR7Q=;
 b=RBArmemChd7or4EuvavBp3wIF4ZO9RYmwZvNwvsMwJSSufu1OOOgLVzHCi5ud5az76
 yktRh66V27VcuaDwUnzNzJailhVdSOraaGJW2ceWKM10DF8Jxd6zMDYCdgTfdCzXe/97
 3+iothDmM1oDNLFMt3mc5vpPLqOdyMuFWAUB5pdtGfyP4w2zV1bjyte0trsNYNqipsBh
 +k2lkw6+BgB6kdF9WpGgVlLm3MLTzgAw0Q6hbLuuGKyD8eL3ChRWL/eZnywv1FlvwAEQ
 SLm93yyCBIQHPmkF1Ii0JPzVPpSxJQ3MN5HO0lmwC+my/qFTduAgSUOQHtsBt0TovNsd
 6JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780225070; x=1780829870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6tCVxwZ/2kSCfKPYf/iRfAPTkHxcF6iOZxH1syXDR7Q=;
 b=tFIZyY9SZHFABiFY0xXzsEABEA47ZCLIRM2j/9P5Si6r2NOhs3zkdH7GNKpNKCfDrV
 6WsRYGckHp2np0JLQ9gt2PPJp9TmMQlijZZjfsnwDsm6Uu6WUzTTTC65UKCfp30TPl+W
 wPFZY32eKP4qalx8uZI0sCdJcCbewjPFIyFVQaU/ZP2b/wJInwnvSKAaMLmrXQTNPFWC
 qUnaF34nw/9hAqjaTVCCfz+k/Tp5PKYPbVlAF0G7/pakgAT6g/VNJke6w8zCKPSdrZdt
 g2s1TBEhSLVWWtB2lgBKieRSwTwc8XRPsUUQzae9rU7pWDFJa9bAIZvAvo39DAcgMitw
 5PeA==
X-Gm-Message-State: AOJu0Yyz5mxr3Wji8L2yh9IqbGblYuVlV63Oz7cRrTdk3z6zF+18Izbd
 5xdO/lSVZs34M7DnviT/LGLixuWj1VAn2mkSNOqQ8GMj8Ss9qCOJFIYavmSbMkJJ
X-Gm-Gg: Acq92OFHqKtSyQ95mnhdrfdfGYoaQGZ+nDgfdT/vwFVZT5uADcs3oSBuuxRwe5BDZQ/
 tASWFDfysuhy8+StTl+XSwfw98N6MNwmuOI3j4URYu5ua6tJrhUQaUMDd5YXel568cXlBQvz6CQ
 P1Ugf3HDQZEsYvCDiXFyvJtTixE+hcGQ7SG0jkHZ6JuROS+gW60ExZYpnk3EAr0WU/N9qu/S6V1
 paWOqKYtkCcgeGSXk11WNdDYF7HI08vFLbGEOhKZ5q4zgJ+Znels3c3p2yG8KzHqXP5VLozOcFY
 BOGptWNAIDgzLSxHLrz+y27bwpCAXo1Wc6EJBIjwYJMyDku14d92VSM35/l+YQpMlEvFnKmdrKo
 KcJTgrb/XO7scsDRnLJVl68IQJ/swGV0sQ19FbjoiruSq69tfLs0SF92O1HcOQmFCgEm6RR82+V
 brMSDhv4GseIQzRkGPhyALMDhnTOdGArfXp3HJrmE6z9bsJF/mv0dcq8OWvQ9WO8pYi7pgxfhb4
 keit+XZZ6iuTtN/
X-Received: by 2002:a05:600c:5306:b0:490:a455:f882 with SMTP id
 5b1f17b1804b1-490a455f915mr114445635e9.24.1780225069808; 
 Sun, 31 May 2026 03:57:49 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68980csm192904065e9.1.2026.05.31.03.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 03:57:49 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/5] drm/amd/display: Use handle_hpd_irq_helper for HPD RX
Date: Sun, 31 May 2026 12:57:41 +0200
Message-ID: <20260531105744.28717-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531105744.28717-1-timur.kristof@gmail.com>
References: <20260531105744.28717-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove duplicated code and just call handle_hpd_irq_helper
with the appropriate detect reason.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 +------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c071c27d8313..28092ac052ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4436,14 +4436,12 @@ static void handle_hpd_rx_irq(void *param)
 	struct dc_link *dc_link = aconnector->dc_link;
 	bool is_mst_root_connector = aconnector->mst_mgr.mst_state;
 	bool result = false;
-	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	union hpd_irq_data hpd_irq_data;
 	bool link_loss = false;
 	bool has_left_work = false;
 	int idx = dc_link->link_index;
 	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
-	struct dc *dc = aconnector->dc_link->ctx->dc;
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
 
@@ -4512,44 +4510,7 @@ static void handle_hpd_rx_irq(void *param)
 out:
 	if (result && !is_mst_root_connector) {
 		/* Downstream Port status changed. */
-		if (!dc_link_detect_connection_type(dc_link, &new_connection_type))
-			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
-
-		if (aconnector->base.force && new_connection_type == dc_connection_none) {
-			emulated_link_detect(dc_link);
-
-			if (aconnector->fake_enable)
-				aconnector->fake_enable = false;
-
-			amdgpu_dm_update_connector_after_detect(aconnector);
-
-
-			drm_modeset_lock_all(dev);
-			dm_restore_drm_connector_state(dev, connector);
-			drm_modeset_unlock_all(dev);
-
-			drm_kms_helper_connector_hotplug_event(connector);
-		} else {
-			bool ret = false;
-
-			mutex_lock(&adev->dm.dc_lock);
-			dc_exit_ips_for_hw_access(dc);
-			ret = dc_link_detect(dc_link, DETECT_REASON_HPDRX);
-			mutex_unlock(&adev->dm.dc_lock);
-
-			if (ret) {
-				if (aconnector->fake_enable)
-					aconnector->fake_enable = false;
-
-				amdgpu_dm_update_connector_after_detect(aconnector);
-
-				drm_modeset_lock_all(dev);
-				dm_restore_drm_connector_state(dev, connector);
-				drm_modeset_unlock_all(dev);
-
-				drm_kms_helper_connector_hotplug_event(connector);
-			}
-		}
+		handle_hpd_irq_helper(aconnector, DETECT_REASON_HPDRX);
 	}
 	if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
 		if (adev->dm.hdcp_workqueue)
-- 
2.54.0

