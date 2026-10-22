Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6F606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q9aCG0M8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71920112468;
	Thu, 22 Oct 2026 09:45:05 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1091123D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:10:31 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so7057755e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 01:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792656630; x=1793261430; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yZVew1Z8l9Ck2vct8o4l+zBAm6EjxHjgzj6xHVpZw3Y=;
 b=q9aCG0M8Z7BR82l5kqMpgAab8fEPpDuIvcBrSV4/Bq/P49xH22+jEC3c/Imr4Ev9xZ
 WRDKUxZ3KCmCMDR7VXh9H/EmRQIhOt+kdji+X47dChi32Nq6pHLICzymRqEClg5UGZ38
 nzaiSqlTvqAeqHkTH47Hhdng8rR2YiqJH2XeCJAx56s+RfhNubz6OxCKVa8tNC5CyOva
 bmU/5py4wcaJSXXU0PxV35W7XPedCbS9ZI7skiGLRpi3ia+IOqI5bbjFzLJTomhX8B9I
 tdkikU/Q5Q0M19A4XjpchGGthrt/+Ut0uUJvRIc0/L97xJjxLYthIiE+Rp2uTWB1vHQn
 nZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792656630; x=1793261430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yZVew1Z8l9Ck2vct8o4l+zBAm6EjxHjgzj6xHVpZw3Y=;
 b=cnsXcVcLwm9TQqTfVT6sV0Bbm2/t/9V+XcgeiCEC7oTCv35fsRzKxtMMDCwfrdF0Tm
 fuS6vpqGxOil4aGt6TYeHZ7WwBblEPlQHI2e7DOQcklDX76U0MzxDuo/DvLU7mCo8mqV
 DkqUojJ9CyDJUKdz4m0j8NR7h2FHWycZrKsjhcPje0WlT6UqJJ6LEzW5MoMRXU4ip+VL
 IVF74/hJoQTBF2P75+huiNOM6ONrN2HTVtQt1beu9ngo/KF3SP/pDXBy940kfBK5ycEa
 A53xiG31ZPSFPwPnE+4IP3VgXxGovCSYjsK5Nxt26fuXu9mwkrgizl9fgdYnmlestIqY
 d2KQ==
X-Gm-Message-State: AFq9FYLkVodhEXM0jhCprz3Swn6LTY3D/UIgrd3Z/muyq90ycov00fr2
 dg08gqASdXDbVsscKgSB4s0bW+4vuEhpDvXfh3/f7WT58w7e5bTCk4ih/XKDH4sVzIiT4g==
X-Gm-Gg: AYBFou18twbWrPxghrySIWn5xB+PmYGIvhu+d+UgbumSRP9Su+1DWUxmJETNtrnkD/2
 Z2R8JiV+9SUTrp2eCjBz2IJUdMFtQCfzy8omOpzJPkWdihQ0KJAJAxJ7HhJTCTWBCZMavUzTbwK
 Fu5PAqCTZRWA1X6AhlqVijNBQ4z5UfTcHnMFgdIc5fbez4ib4XLxgz9Vx4nSSANaV/b9n8N+iQS
 Vs1xTAFChG3q8/sl9+dkGpcWr+tIeEQ9YEWljFXipVpKKJPmHqJibA0s1eZe0XZR33fFfNMzQBG
 KJPtn3GA2pHXbfCIwa2shV9oEUb8OuSrX+4FemSATBxf4sJwn0YM6/O6AAeEsQaTCU8Zudnz+aD
 X8UBReL1HLzZpfDYB8Abi6jLWN0BMC6FN93VrXKUbD0AQz9whgTq0tk1GA61VOfgB5AIVIL84vC
 qakWlyS7xbs26ooj+4lIwTrDw+vxGM1nloe3FgEMGpMtlJ9zaR+PPrIQoUF8iXM1X8QbkDw4qZw
 aursmzcohuHgKrIGo5w+AsejcrBWVSCFvgI0nHcR9WKCn6oJX09FwSC07/KO/WsYlru5feC4AbT
 kaw3cpYmomIi+6l1YN5g+ApV2cYOJOcAoMtc2ldXVhkDxlR+dg==
X-Received: by 2002:a05:600c:4fc9:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4a204b2032cmr34901355e9.12.1792656629756; 
 Thu, 22 Oct 2026 01:10:29 -0700 (PDT)
Received: from tvab-pc (v2202507270734364850.supersrv.de. [152.53.198.198])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd234fasm72133325e9.3.2026.10.22.01.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 01:10:29 -0700 (PDT)
From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 3/3] drm/amd: let DC re-read UCLK DPM levels after an
 OD_MCLK change
Date: Thu, 22 Oct 2026 11:09:25 +0300
Message-ID: <20261022080925.13994-4-shidlovskiyilya@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022080925.13994-1-shidlovskiyilya@gmail.com>
References: <20261022080925.13994-1-shidlovskiyilya@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:44:57 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DC reads the UCLK DPM levels from PMFW only during init_hw
(dcn32_init_clocks() -> dcn32_get_memclk_states_from_smu()).
Committing an overdrive table with a different UCLK max (OD_MCLK) changes
the top UCLK level in PMFW, but nothing tells DC about it. On resume it is
even worse: DC init_hw reads the stock table and the user OD table is only
restored afterwards from smu_late_init().

With a stale table, DCN3.2 keeps using the stock max_memclk_mhz as the
UCLK hard min whenever the current mode does not support P-state
switching ("to disable P-State switching, set UCLK min = max"). After
raising the UCLK max, that value is no longer the top level, PMFW
switches UCLK outside of vblank, and the display shows stripes and
eventually hangs (seen on a Navi31 RX 7900 GRE driving 5120x1440@144
with ODM 4:1 + 2560x1440@100).

Add dc_refresh_memclk_states(), which re-reads the memclk states (bounding
box and WM ranges included) through dc_lock_memory_clock_frequency(),
re-applies the UCLK hard min/max for the current mode and re-sends the WM
ranges to PMFW. Call it from a new amdgpu_dm_update_memclk_states() helper
when the SMU reports that an OD commit/restore changed the UCLK levels
(smu_od_uclk_changed()), after pm.mutex is dropped, and after the user OD
settings are restored on resume. Limited to DCN3.2/3.21 for now.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/6009
Acked-by: Leo Li <sunpeng.li@amd.com> # display part
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
---

Notes:
    v2:
    - call amdgpu_dm_update_memclk_states() only when the SMU reports a UCLK
      change (Kenneth), both after an OD commit/restore and on resume. The
      check lives in the swsmu ASIC code, since PP_OD_FEATURE_UCLK_BIT is
      ASIC specific and amdgpu_dpm_odn_edit_dpm_table() is shared with
      powerplay; amdgpu_dpm.c only reads the flag under pm.mutex
    - display part unchanged from v1, added Leo's Acked-by for it
    - rebased on amd-staging-drm-next

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  3 ++
 6 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bdabb4bf1..9cc27d552 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6843,3 +6843,36 @@ void dm_acpi_process_phy_transition_interlock(
 	// Not yet implemented
 }
 EXPORT_IF_KUNIT(dm_acpi_process_phy_transition_interlock);
+
+/**
+ * amdgpu_dm_update_memclk_states() - re-read the UCLK DPM levels from PMFW
+ * @adev: amdgpu device
+ *
+ * DC reads the UCLK DPM table from PMFW only in init_hw. An overdrive commit
+ * (or restoring the user OD table on resume) can change the UCLK levels, which
+ * leaves DC with a stale max_memclk_mhz and bounding box. On DCN3.2 the stale
+ * max is then used as the UCLK hard min when P-state switching is not
+ * supported by the current mode, so PMFW is free to switch UCLK outside of
+ * vblank and the display underflows or hangs.
+ */
+void amdgpu_dm_update_memclk_states(struct amdgpu_device *adev)
+{
+	struct dc *dc = adev->dm.dc;
+	unsigned int max_memclk_mhz;
+
+	if (!dc)
+		return;
+
+	if (dc->ctx->dce_version != DCN_VERSION_3_2 &&
+	    dc->ctx->dce_version != DCN_VERSION_3_21)
+		return;
+
+	mutex_lock(&adev->dm.dc_lock);
+	max_memclk_mhz = dc_refresh_memclk_states(dc);
+	mutex_unlock(&adev->dm.dc_lock);
+
+	if (max_memclk_mhz)
+		drm_info(adev_to_drm(adev),
+			 "DC memclk states refreshed, max UCLK %u MHz\n",
+			 max_memclk_mhz);
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 594d27591..f5137c15a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1175,6 +1175,12 @@ void dm_free_gpu_mem(struct amdgpu_device *adev,
 
 bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
 
+#if defined(CONFIG_DRM_AMD_DC)
+void amdgpu_dm_update_memclk_states(struct amdgpu_device *adev);
+#else
+static inline void amdgpu_dm_update_memclk_states(struct amdgpu_device *adev) {}
+#endif
+
 bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc);
 
 void retrieve_dmi_info(struct amdgpu_display_manager *dm);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f84f659c1..ddb84cc48 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6587,6 +6587,27 @@ void dc_lock_memory_clock_frequency(struct dc *dc)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 }
 
+/*
+ * Re-read the memclk DPM levels from PMFW (e.g. after an overdrive change),
+ * refresh the bounding box and WM ranges, and re-apply the UCLK hard min/max
+ * for the current mode. Returns the new max memclk in MHz, 0 if unsupported.
+ */
+unsigned int dc_refresh_memclk_states(struct dc *dc)
+{
+	if (!dc->clk_mgr || !dc->clk_mgr->bw_params ||
+	    !dc->clk_mgr->funcs->get_memclk_states_from_smu)
+		return 0;
+
+	dc_exit_ips_for_hw_access(dc);
+
+	dc_lock_memory_clock_frequency(dc);
+
+	if (dc->clk_mgr->funcs->notify_wm_ranges)
+		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
+
+	return dc->clk_mgr->bw_params->max_memclk_mhz;
+}
+
 static void blank_and_force_memclk(struct dc *dc, bool apply, unsigned int memclk_mhz)
 {
 	(void)apply;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f4fefa7c9..fd82d2d33 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -3244,6 +3244,8 @@ void dc_unlock_memory_clock_frequency(struct dc *dc);
 /* set min memory clock to the min required for current mode, max to maxDPM */
 void dc_lock_memory_clock_frequency(struct dc *dc);
 
+unsigned int dc_refresh_memclk_states(struct dc *dc);
+
 /* set soft max for memclk, to be used for AC/DC switching clock limitations */
 void dc_enable_dcmode_clk_limit(struct dc *dc, bool enable);
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 75d8bb486..afa3d9c7e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1329,6 +1329,7 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
 				  uint32_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	bool uclk_changed = false;
 	int ret = 0;
 
 	if (!pp_funcs->odn_edit_dpm_table)
@@ -1339,8 +1340,14 @@ int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
 					   type,
 					   input,
 					   size);
+	if (is_support_sw_smu(adev))
+		uclk_changed = smu_od_uclk_changed(adev->powerplay.pp_handle);
 	mutex_unlock(&adev->pm.mutex);
 
+	/* The OD commit changed the UCLK levels, let DC re-read them */
+	if (!ret && uclk_changed)
+		amdgpu_dm_update_memclk_states(adev);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 490640053..5fa7dd570 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -601,6 +601,9 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 			ret = smu->ppt_funcs->restore_user_od_settings(smu);
 			if (ret)
 				dev_err(smu->adev->dev, "Failed to upload customized OD settings\n");
+			else if (smu_od_uclk_changed(smu))
+				/* DC read the stock UCLK levels in its init_hw */
+				amdgpu_dm_update_memclk_states(smu->adev);
 		}
 	}
 
-- 
2.55.0

