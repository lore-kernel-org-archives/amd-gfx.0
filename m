Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BC606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNLJIK9D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 404AB10EBE8;
	Mon,  2 Nov 2026 08:06:54 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430F710E281
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 16:58:52 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so618477f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793379531; x=1793984331; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8q5+7PBZtozw8r7APGhn8aKv1nVUTP5aRAm+isDToPg=;
 b=PNLJIK9D7czkKlDvj1JYqbCp6SfADefM6UN7T62nE6NUEkltJ7TmbAU+4IdC2ZFEtp
 9mDaxJWkLZjJXmVDia3CxdM2OAoW/hzAEOqI7o/Xz1WMJR2LYvCPuJoJwmzRfK4AE2tD
 XpcVLn2jKjZo189Q/78SKMU3uehcssSGmiRIqXaWPZaiFm4YIzyMlgrSMHCPSdhQ595Y
 8FfWx865DGx9peGhh03Y8GG3ehNkJ3s5tzzsET1B1XMywvhNOQN+acA8qTwQz53cjRdN
 6/NUjDYIOZm3U69xMtGArEW6ss/K7YDkAUf/uwTWKSthw0ugDuK3c7iWtKx2ifffKFDF
 duMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793379531; x=1793984331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8q5+7PBZtozw8r7APGhn8aKv1nVUTP5aRAm+isDToPg=;
 b=Iz469yYQ6FBrhLj9SdmT0OWkOyYGBEOya7PbjNsboODs0BLUyjHLfpsf8dAp8PIhFN
 hP44Mwzl3D4GZiurtU17ISzcJu4TucwZaXaJmvC3LIQJ9doXd9gftoxaOVPKKrQ66DAJ
 S9jocA5gYsOyiTW2d6WWghR51PWgzVq6wG2DRVG4P5HN/NvInWfgD5pvGRpgV3EEWlkB
 QQDZiIq/O/We+IKGxPBpTvo/GymrzBcrWTm4zhZ+zdPoSYIBJpeUAcvVB/Ze/iffQkJg
 +v/owQ2TmF1+PzbSx9gDs0JcTuc8GgigFKpWw8XAN5EU8CHvBO9WMqsZp5HXPDR64CO/
 d1Ug==
X-Gm-Message-State: AFq9FYK5JSsZbgpoLanOA0Tqeh5WdY3oAO3wYN9HFET2fCXH3r5JTefL
 y5lSYzyetHyMLqM7biGJkX5rOLl50AITTBwAO+nTCfqCnA/ZQD8bL0lfIfLSS60YbrXZ6A==
X-Gm-Gg: AYBFou0VgAIJ4j0xoq+O3ZiWBml6E/2nKsJRYnk1wfqVwCzG7TbZ1j/MRZ9+Maj1o1f
 a+z3IoY+qU8IJinFQ609yHPEOLFIs8qG33igKiHGS7G6AZSqulmzlmsjThDu6aYilej+jT4+aSI
 ao+yvAQsnYQM66fh510JgNBbDFiO6LFGRXUjiOpoCfJ9ou0CtGylRI49EBOhOYZ5aZV4SjZPil1
 AOeSKdog6ide/MD4YbbwmlpreSZFjGavZG1fND9L+zOcQXDT5vRrdwEs6tX4qTSBeDeAv+9G9LN
 Y31X7gxPEoAaay3wLQ20ZrFTUd4lUSE2E2jCRi4pq5/bRh9pIrLJ05dFEsXSiLKOJ1IlgKiukdN
 kxej15UJj7fg6sDVJs03MCakC8f93JGkcNav/ObE1m6dSo2LcaT+MM+fEMOwnvPHGclxsiz6guS
 XYAhbPlMGbj5zN7zjGeqkZJQLNPEefgBZFhQ0veCPwIwrsbxZWn2HPCjLNxTZdtP4nWojDT00Us
 sNdeEhi2wVsrNki2R/cx5oMFFkXpKfyzAQ56na2fo1ujYJRfD2X+JIQd+PfQK/xh1x0IJttj1i8
 FDseEQ+5cSbmyfpb9H2hb+EaB/QL6MQ2eRtPjzKZE9u+PmyTaM7bEU/B+GU4jXLmTPTv0xqfcxu
 wGvdQo5Wami32y3hc7DtVHC8=
X-Received: by 2002:a05:6000:2dc5:b0:48d:ef0e:b791 with SMTP id
 ffacd0b85a97d-48e6e52c720mr7111596f8f.54.1793379530381; 
 Fri, 30 Oct 2026 09:58:50 -0700 (PDT)
Received: from tvab-pc (v2202507270734364850.supersrv.de. [152.53.198.198])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba24f6sm4033465f8f.51.2026.10.30.09.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:58:50 -0700 (PDT)
From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Kevin Wang <kevin.wang@amd.com>
Subject: [PATCH v3 3/3] drm/amd: let DC re-read UCLK DPM levels after an
 OD_MCLK change
Date: Fri, 30 Oct 2026 19:58:38 +0300
Message-ID: <20261030165838.248622-4-shidlovskiyilya@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030165838.248622-1-shidlovskiyilya@gmail.com>
References: <CADnq5_Pv0wkPx9AzooUf=dyWgQuneMc6K9-qcT6PW53Gg4L5rg@mail.gmail.com>
 <20261030165838.248622-1-shidlovskiyilya@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
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
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com> # display part
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
---

Notes:
    v3:
    - rebased on top of Kevin Wang's "preserve committed OD features" patches,
      no changes
    v2:
    - call amdgpu_dm_update_memclk_states() only when the SMU reports a UCLK
      change (Kenneth); the check lives in the swsmu ASIC code, since
      PP_OD_FEATURE_UCLK_BIT is ASIC specific
    - display part unchanged from v1, added Leo's Acked-by for it

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  3 ++
 6 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dfbc384fb..370d349cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6837,3 +6837,36 @@ void dm_acpi_process_phy_transition_interlock(
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
index 656aa0e46..95a4b0d50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1179,6 +1179,12 @@ void dm_free_gpu_mem(struct amdgpu_device *adev,
 
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
index ae5f03a73..471cb99a1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6628,6 +6628,27 @@ void dc_lock_memory_clock_frequency(struct dc *dc)
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
index d983bab7e..bf8e1aba3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -3263,6 +3263,8 @@ void dc_unlock_memory_clock_frequency(struct dc *dc);
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

