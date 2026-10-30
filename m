Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E2606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHt6GgSF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB6110EBEF;
	Mon,  2 Nov 2026 08:06:55 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26CD710E188
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 16:58:51 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so587835f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 09:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793379529; x=1793984329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lYcL2axkmr3ZrTDwADBv6/3UKC/fQEDkO1p/3LLuR+0=;
 b=JHt6GgSF/dVfmE0Ln3dbmevX4AV9tW+bjIsaGOM1eCe3oh+bEVEzbyRo04bedCiSXa
 uZXDJhRkSnbJUX7h8UXLK3qoin4z5h6WtytYx9hLMYQ+cqyOjfq/DKndgy6rYRDTCl50
 0JB9+ubjLvT7AdUrRjwhCQbdc4sHZo9T2n2F+WzpxlXqsRuoGesBI1D+Xp9vBqfoAQUU
 s4+Yq+mzoLBMqSViRjuocbdoyBi2pW9yX+CBZGfv3pslScp/weHP1OoWiE0ZEryyIihv
 g7ezESlAJUUhzDc+GyVKEEX0dFgDlTTZhCvZcdPTreWAR2xbEPNguUxTPPz0wvepQDdr
 aqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793379529; x=1793984329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lYcL2axkmr3ZrTDwADBv6/3UKC/fQEDkO1p/3LLuR+0=;
 b=nLwez1ya4WruhQ8kWGCxsYkkWmUPScwXkKuUfExMw2llbsC5klwMd9IUtzVoHqC4n9
 B2q62/30K5BCQ/ugKRciV/0lPewX4NXp2KtKnkwv2UjM652tjKs2O+Ki3Mzf1RO7hn8k
 DnDa6vNSUsfKT39Knitj8kEdcoY0YX6haUyrkphmKeir/wC0q/dAQ6Pw1t5/uJbxz8F7
 +ccYNAa0d8C+XpVe0CMow70KFcqUDrWPWrht/E9mBkmJVRKKaTY77pwH8+VoA1fZLMIw
 LKmOscdij9+BegFUmhjeOPmLTQyQswLCQ5/+f9SuznYa8aMBM2ns6CKzC1NM8vqRy1hl
 gw1Q==
X-Gm-Message-State: AFq9FYIEEqeE+BVSf7r0DQzGNf7VF5e7ceWR4oX2MzFUgIMnG5Q5r44S
 sSxnMDnKlVQXNXY6dJT9W3mRx6PoEXf2iGPrZWpShpctuOfaCW+bu1GoiOHqyvIDbC+haw==
X-Gm-Gg: AYBFou2i7W3vjVWNok0CCFP/y5b3HgGXGOJvdLYQvjFygMkszYzKDiIcp7OiuIpNK9/
 bsDvQLDaV5tim5GbA9UhZ2tJnGoSRZC4iKIY2rDU672K1D2mlOoU5X4Wfrtag78pmW+1KMWrR7A
 Df/gmqvIXyRLbvWvVwJMxIvLiYqMGQLFFmEzRByZ13lEyqVghO5lcJOuON2o6WuZgs1p4qdAh7h
 Fpg7P5M5k+M4wZw5HS8K5Fzokyoph1kuavJ0WQE1KKIWYPHUZeaCbKgBY+eckWfaTj9BLfisv0k
 c4/WvoE1W2cA3DZGcBGGYSttKxpOyQ2IafTW00LwxZb8JHYM6KIslZufAGAiHwVuIhzos+YFj/A
 GdQtqUVP2rL8SwPPy2sbHcFbeRyDtXstbDMZVxSBOAxNwe0Auwi1xvMLYQAA/gF+beSO1ngmndI
 knvDJjOXbRRlDRkRHmarqQ89LB4JzLjU+T8x/Nt8hhq53fc0nfpBKeR2fqTQ8tcqA6q3A8FKZdu
 K1jgtgvBL3yZr1g9OX3k2fpyk4M5RXTzplInkR/hfN4q16U1OnEWHxILv+KWINVo4DWB5m5dxW6
 k/ADJKsINKoom16pe/49OboGkfs2kprbn9YFWo6InoI7VVdh0vq2FFvjegtdpxKIZ2jbrTAxluP
 k6O0+weVTv48zLebeQ66QQ94=
X-Received: by 2002:a05:6000:98b:b0:48e:3484:8af2 with SMTP id
 ffacd0b85a97d-48e64d10510mr15093152f8f.31.1793379529468; 
 Fri, 30 Oct 2026 09:58:49 -0700 (PDT)
Received: from tvab-pc (v2202507270734364850.supersrv.de. [152.53.198.198])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba24f6sm4033465f8f.51.2026.10.30.09.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:58:49 -0700 (PDT)
From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Kevin Wang <kevin.wang@amd.com>
Subject: [PATCH v3 2/3] drm/amd/pm: smu13.0.0: refresh the UCLK DPM table
 after an OD_MCLK change
Date: Fri, 30 Oct 2026 19:58:37 +0300
Message-ID: <20261030165838.248622-3-shidlovskiyilya@gmail.com>
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

The UCLK DPM table in the driver is only populated by
smu_v13_0_0_set_default_dpm_table(). After an overdrive table with a
different UclkFmax is uploaded, pp_dpm_mclk keeps showing the stock top
level, and the "high"/"auto" soft limits are derived from the stale table.

Re-read the UCLK levels from PMFW after a successful OD commit or restore,
but only when the user has customized UCLK (PP_OD_FEATURE_UCLK_BIT in
user_od_feature_mask, before or after the operation, so that restoring the
defaults is covered too). Do the same when the user OD settings are
restored on resume.

Also record the change in a new smu_table_context->od_uclk_changed flag,
with smu_od_uclk_changed() to test and clear it. PP_OD_FEATURE_UCLK_BIT is
ASIC specific (8 on SMU 13.0.x, 9 on SMU 14.0.2), so this lets the generic
code tell DC to re-read the levels without knowing the OD table layout.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/6009
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
---

Notes:
    v3:
    - rebased on top of Kevin Wang's "preserve committed OD features" patches.
      The commit and resume paths now upload a copy with next_mask; the UCLK
      check uses (prev_od_feature_mask | next_mask) on commit and next_mask
      on resume. Same logic as v2: normalize clears the UCLK bit when UCLK
      is back at boot values, and the previous mask still catches that.
    - prev_od_feature_mask is u32, like the surrounding code
    v2:
    - only refresh the UCLK table when the user has customized UCLK
      (user_od_feature_mask & PP_OD_FEATURE_UCLK_BIT), instead of on every
      OD upload (Kenneth)
    - add the od_uclk_changed flag and smu_od_uclk_changed(), used by the
      DC hook in the next patch
    - moved before the DC patch (was 3/3)

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 30 +++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a901f8535..490640053 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3665,6 +3665,22 @@ static int smu_baco_set_state(void *handle, int state)
 	return ret;
 }
 
+/**
+ * smu_od_uclk_changed - test and clear the "UCLK OD changed" flag
+ * @smu: smu context
+ *
+ * The ASIC code sets the flag when an overdrive commit or restore changed the
+ * UCLK DPM levels, so that callers can tell DC to re-read them.
+ */
+bool smu_od_uclk_changed(struct smu_context *smu)
+{
+	bool changed = smu->smu_table.od_uclk_changed;
+
+	smu->smu_table.od_uclk_changed = false;
+
+	return changed;
+}
+
 bool smu_mode1_reset_is_support(struct smu_context *smu)
 {
 	bool ret = false;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 9d47d2ab1..2a0cdc6e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -434,6 +434,8 @@ struct smu_table_context {
 	void				*user_overdrive_table;
 
 	uint32_t			user_od_feature_mask;
+	/* Set when an OD commit/restore changed the UCLK levels */
+	bool				od_uclk_changed;
 
 	struct smu_driver_table driver_tables[SMU_DRIVER_TABLE_COUNT];
 };
@@ -1948,6 +1950,7 @@ int smu_get_ppt_limit(void *handle,
 		      enum pp_power_type pp_power_type);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
+bool smu_od_uclk_changed(struct smu_context *smu);
 bool smu_link_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
 int smu_link_reset(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 14b2acd36..1a02ba70d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1288,6 +1288,28 @@ static int smu_v13_0_0_upload_overdrive_table(struct smu_context *smu,
 	return ret;
 }
 
+/*
+ * PMFW rebuilds the UCLK DPM levels from UclkFmin/UclkFmax. Re-read them, so
+ * that pp_dpm_mclk and the soft limits match, and flag the change for DC.
+ */
+static void smu_v13_0_0_od_refresh_uclk_table(struct smu_context *smu)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	int ret;
+
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
+		return;
+
+	ret = smu_v13_0_set_single_dpm_table(smu, SMU_UCLK,
+					     &dpm_context->dpm_tables.uclk_table);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to refresh UCLK dpm table!\n");
+		return;
+	}
+
+	smu->smu_table.od_uclk_changed = true;
+}
+
 static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 				       enum smu_clk_type clk_type, char *buf,
 				       int *offset)
@@ -1653,6 +1675,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	OverDriveTable_t *od = &od_table->OverDriveTable;
 	OverDriveTable_t *boot = &boot_od_table->OverDriveTable;
 	struct amdgpu_device *adev = smu->adev;
+	u32 prev_od_feature_mask = table_context->user_od_feature_mask;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
 	u32 next_mask;
@@ -2007,6 +2030,11 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 			table_context->user_od_feature_mask = next_mask;
 			od_table->OverDriveTable.FeatureCtrlMask = 0;
+
+			/* UCLK was customized before (restore) or is now (commit) */
+			if ((prev_od_feature_mask | next_mask) & BIT(PP_OD_FEATURE_UCLK_BIT))
+				smu_v13_0_0_od_refresh_uclk_table(smu);
+
 			memcpy((u8 *)user_od_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
@@ -2362,6 +2390,8 @@ static int smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
 			!!(next_mask & ~BIT(PP_OD_FEATURE_PPT_BIT));
 		memcpy(od_table, user_od_table, sizeof(OverDriveTableExternal_t));
 		od_table->OverDriveTable.FeatureCtrlMask = 0;
+		if (next_mask & BIT(PP_OD_FEATURE_UCLK_BIT))
+			smu_v13_0_0_od_refresh_uclk_table(smu);
 	}
 
 	return res;
-- 
2.55.0

