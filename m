Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E11CCD4F52
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF2F10EB14;
	Tue, 19 May 2026 08:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iJor/2If";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD8810EB14
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:42:05 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so35675825e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779180124; x=1779784924; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbkVZm9huwk5DqPliqJm3CtpFt7jRXNZ8wXXHRzSOM4=;
 b=iJor/2IfMgDg6fmo5Fe6Ua2va6CQqQsvsfLAizJjYcA+CBt0cmNDAPnyM+7dRg4tU+
 n/UdYJ6hH0PcNSm/Ho5v31KFedI8YGwV6JVSrCgSmeZyHcO5y+SUF9mgeb2C+tdNZQoA
 W/01YrVLMFklrjszWcWXxWnVibIeu1za/NxzC+kfgcLXRI77rUtvAjFi+ueyFCBbPh95
 MhapFuszZfaSEOGt9A4c8SkSYVLUJTW9gMlHDaW4Oc5ZXtp0ADnadDOFQZskOrly1z/0
 nf3+VpEAcjPKHJ4XSX2l/8Rh433Ghj5XoxYsPm9WZG+FcuraONJhpjnHK5EvqFDoBgt+
 7P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180124; x=1779784924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bbkVZm9huwk5DqPliqJm3CtpFt7jRXNZ8wXXHRzSOM4=;
 b=BkvZvI4E1PTelkre7meGylU3fXzfRLm9+nyA3EPbpQfYKOsAHHFVAWewQCffBtzHqO
 7+ziGSAPs1ntVLG4nksLSRq0HAs1SlWc6jhBbAupQ2+bOqibqbeCYrRr0pbX3QGPqThS
 PaaaM3dE8OrJbiKrhXG/6QR4cg6oCxRSy+NLe2C6NafE/xB5qYmNCeLkqBCSuZDsnfAC
 BpvMeKT+CHi/sMzNUOz6BxfMEnpHmd/CNKl4ilQSjYq80s+2pmsCAsP2T3eZQOWuiL0S
 fn/C+zyzvmwfASGzwaNCt+B7gZveEz6I8aR8PXI6JMsAc10W0PnU+IPZzdZJ9Jwjwaly
 oOAQ==
X-Gm-Message-State: AOJu0Yz1Is5B2bzcbrZxgYPNio8uPdtEnAvI8YuaP66C5Jc7fuQia4S1
 aghRmFJwbQI15WEG9+A+kJJeBRzE526u7mjQ7TCOswjT94m16GWFXiN0c+Dnag==
X-Gm-Gg: Acq92OESjNGmn05Blh0t7jsL1MDBirS3eLjHgCafXYW/+fbW+XUoNhtkmlSosdDZXUR
 4TATd3c4IxXNaJBjyAAqySYkmoMARbTU8w75EAdKTjXPVSJBorWtE+ip2A72+AzUOd7dKoegAs7
 gUl9TwlwGJbl1Kvq1rmY7GhTsyQTkFo/smCdvoElGKzyjp6MZoExKklBGmfyDg3uF3OSwMeSmvO
 Un9NaYp4HoC4ioGkEMoKsS7B6GA0NHZcbOpcfr6ZhxVpxdRO8xrKus9BdMauWuPPNw3N8n4DX15
 9OytH3On2QHfXRGUIlIMzFEZgoYvWL1TsN3TBXy908pOfa3WY8RZ9g/Oif4HxexIs/XwvSm5Y4/
 KIdL6reALcad8O8GgJBlQ0PLdjTP+u0VQJ/mBv4pau0bpZMNBUXhGca5qjhoDB51eb2yPqDhkYQ
 7vZgq8KnOzNin1iDigTCAacfJ1IbG1t9Hq7mPC9EglJ9sn7qYgIBIN28dDuwp1u4tt
X-Received: by 2002:a05:600c:46cf:b0:48e:8974:c377 with SMTP id
 5b1f17b1804b1-48fe6626ba1mr274274775e9.29.1779180124187; 
 Tue, 19 May 2026 01:42:04 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff2cb4ae0sm141935945e9.0.2026.05.19.01.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:42:03 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/5] drm/amd/pm/smu7: Notify SMU7 of DC->AC switch
Date: Tue, 19 May 2026 10:41:56 +0200
Message-ID: <20260519084158.72960-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519084158.72960-1-timur.kristof@gmail.com>
References: <20260519084158.72960-1-timur.kristof@gmail.com>
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

When ATOM_PP_PLATFORM_CAP_HARDWAREDC is set,
the SMU has a GPIO pin for detecting AC/DC switch
and everything works automatically.

Otherwise when there is no GPIO pin, the SMU can
automatically detect switching to DC, but needs
to be notified of switching to AC.

Use PPSMC_MSG_RunningOnAC to notify the SMC
when switching to AC.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 ++++++++++++
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h      |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 0bbb89788335..19e74baa2b85 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1550,6 +1550,17 @@ static void pp_pm_compute_clocks(void *handle)
 			      NULL);
 }
 
+static void pp_dpm_notify_ac_dc(void *handle)
+{
+	struct pp_hwmgr *hwmgr = handle;
+
+	if (!hwmgr || !hwmgr->pm_en)
+		return;
+
+	if (hwmgr->hwmgr_func->notify_ac_dc)
+		hwmgr->hwmgr_func->notify_ac_dc(hwmgr);
+}
+
 static const struct amd_pm_funcs pp_dpm_funcs = {
 	.load_firmware = pp_dpm_load_fw,
 	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
@@ -1615,4 +1626,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.gfx_state_change_set = pp_gfx_state_change_set,
 	.get_smu_prv_buf_details = pp_get_prv_buffer_details,
 	.pm_compute_clocks = pp_pm_compute_clocks,
+	.notify_ac_dc = pp_dpm_notify_ac_dc,
 };
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 4436ab2bb51f..416b9380a70e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5854,6 +5854,20 @@ static int smu7_power_off_asic(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
+static void smu7_notify_ac_dc(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+
+	/* Check if the platform already manages the AC/DC switch via dedicated GPIO. */
+	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
+			    PHM_PlatformCaps_AutomaticDCTransition))
+		return;
+
+	/* The SMU automatically notices DC, but needs to be notified when switching to AC. */
+	if (adev->pm.ac_power)
+		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunningOnAC, NULL);
+}
+
 static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.backend_init = &smu7_hwmgr_backend_init,
 	.backend_fini = &smu7_hwmgr_backend_fini,
@@ -5916,6 +5930,7 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.get_asic_baco_state = smu7_baco_get_state,
 	.set_asic_baco_state = smu7_baco_set_state,
 	.power_off_asic = smu7_power_off_asic,
+	.notify_ac_dc = smu7_notify_ac_dc,
 };
 
 uint8_t smu7_get_sleep_divider_id_from_clock(uint32_t clock,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 3ae45eac0c5c..84de2ccad7a3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -364,6 +364,7 @@ struct pp_hwmgr_func {
 					bool disable);
 	ssize_t (*get_gpu_metrics)(struct pp_hwmgr *hwmgr, void **table);
 	int (*gfx_state_change)(struct pp_hwmgr *hwmgr, uint32_t state);
+	void (*notify_ac_dc)(struct pp_hwmgr *hwmgr);
 };
 
 struct pp_table_func {
-- 
2.54.0

