Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF2606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h79clWfj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD59711246F;
	Thu, 22 Oct 2026 09:45:08 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEC31123CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:10:30 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso13972555e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 01:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792656629; x=1793261429; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3viAaaeGHs/eFB1QgBr7nY3V9SlWJ9SjPgw/p2jPkTI=;
 b=h79clWfj3iovOV+tbkXCr/9ZdwUt+6TU3m+qgeLHO6n0ApdOqcVLobJqBLpieCBD4t
 irJXDsztSmZgF9a50+flw+8SKvJhXz82CX2Qv43vzR3Sb6Z7gWr7qaFaffiog/tb7TZi
 m3Bv8i+sFfDQCO2QO7l66wsOh0jkwdpLmReEy8N4UidS5BK8PAeKR/8yZceNS5b8+qtH
 FboiF6xsWmracpLc1MICsiRkXOSWKpiyl1WN6l9VdrxCLlEa0KeFp+eXFXKPZtHbs1nz
 Alq0OzE03a/XrOPqpbNUWflQ3BEVuYYvsnYwDIUCUQicLNCKisfJm2J2EydrAyqZIjez
 RWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792656629; x=1793261429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3viAaaeGHs/eFB1QgBr7nY3V9SlWJ9SjPgw/p2jPkTI=;
 b=KLseCmE2ttXbspzyz/07wdWSnnppZJybSUAK5J6DdumcxX1F/xX/UJmgBY1khELX9M
 3lDz5hc1Ohqiyms8GVRAP3Bd4YWs35twUXq1CfLrXhQ91Rz/H/9uJ3NLjDOH6m5alt+z
 QHVF8QoTo1jFOVKrKVqmbnGKyLvMA13HqUbI+hznouQnHb1d8DUiEzGYgB5ch+eeCu63
 4xnqDd2tI1GsKCCD7qNTI5HzjG/w0PV74WU5QlWe3yVCZItt2gdOMxsNo2MdIX0X3Ze8
 FNcVgMAJnNuRQtOUqSRTOXeW1Xu6JL1GSYMhy2UUpojsTNsj16cZsKSuAePfUsy2Sw/C
 1rtg==
X-Gm-Message-State: AFq9FYJIqkNXtyk7HYANvbbBgzrZWvzFypKev3p97mZcIMq3ow4HUyDa
 g1lC+dVOZe99+8261eSivNGY/U2cLE8gjFKbc+NHcJNkfzxB1Y93QoNJkagiY/GUnGSYYQ==
X-Gm-Gg: AYBFou2qrpaAsudPY0xiAJLUhxsoMJAlCmiNUGJ0zMo5sQJ1DnUjAdv3yM8StH81+zT
 0JhnKudazD9sK9kfVdUMJ1/PD0TwAj+ZCN38rQdeYv6epRnkBLPnWbXgdl1hSTpe2ZYJaTXpfcX
 LkokHnZado72H4A+Rh8K2oXb0bQV7hHzLQM7XValFDGVseU5+YRDPCEM29MPEi5djYyZHVDFnKp
 XCw+smdBnhNmGuzJ2C07V0RgZeSpJe//VVTyHkDidc2oBg8e5gW3w2lBpyavi5eQVr/AuDpd0oU
 fSFavIp9XHEj6g9YcgkAn4QkCbH5i5GcBJkL9+mpCHa5mcof5DKkYp9V8TEgF46QwkD+gvHm4Si
 PmvWcgJdrnz/eszeDmVSyqMM4y2RotEPzUm3X7+ptN0KsCF36fb0OAHAKb/gW6yRU2anTt4JvKt
 etOGelspP81sB3j1NOANCeZaGf2fmJfL/pf3Sx/1yiD5XZAfCZY5+RD9QO3y5w6JCBvzZcNlPr2
 pxR2qoavHah/CSJ5gcbT/ZdrBJM4Narob+qnWQEegMshRwzx2SszCBYV0Jp0TFowpu+Ibe7CRby
 3ypVElPGwr8Sp/Miwi9Qzmt2j5WuyBU6FJuP26sCa6drxxAi
X-Received: by 2002:a05:600c:34ca:b0:4a0:eae0:769a with SMTP id
 5b1f17b1804b1-4a1fdd39e68mr93400395e9.28.1792656628485; 
 Thu, 22 Oct 2026 01:10:28 -0700 (PDT)
Received: from tvab-pc (v2202507270734364850.supersrv.de. [152.53.198.198])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd234fasm72133325e9.3.2026.10.22.01.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 01:10:28 -0700 (PDT)
From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 2/3] drm/amd/pm: smu13.0.0: refresh the UCLK DPM table
 after an OD_MCLK change
Date: Thu, 22 Oct 2026 11:09:24 +0300
Message-ID: <20261022080925.13994-3-shidlovskiyilya@gmail.com>
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
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
---

Notes:
    v2:
    - only refresh the UCLK table when the user has customized UCLK
      (user_od_feature_mask & PP_OD_FEATURE_UCLK_BIT), instead of on every
      OD upload (Kenneth). The mask from before the operation is checked
      too, so that restoring the defaults still refreshes the table.
    - add the od_uclk_changed flag and smu_od_uclk_changed(), used by the
      DC hook in the next patch
    - moved before the DC patch (was 3/3), since that patch now depends on it
    - rebased on amd-staging-drm-next

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 +++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 ++++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

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
index a9bf68678..d3b452772 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1198,6 +1198,28 @@ static int smu_v13_0_0_upload_overdrive_table(struct smu_context *smu,
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
@@ -1567,6 +1589,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)table_context->overdrive_table;
 	struct amdgpu_device *adev = smu->adev;
+	uint32_t prev_od_feature_mask = table_context->user_od_feature_mask;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
 	int i, ret = 0;
@@ -1912,6 +1935,11 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 				return ret;
 			}
 
+			/* UCLK was customized before (restore) or is now (commit) */
+			if ((prev_od_feature_mask | table_context->user_od_feature_mask) &
+			    BIT(PP_OD_FEATURE_UCLK_BIT))
+				smu_v13_0_0_od_refresh_uclk_table(smu);
+
 			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
@@ -2250,8 +2278,11 @@ static int smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
 		table_context->user_od_feature_mask;
 	res = smu_v13_0_0_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
-	if (res == 0)
+	if (res == 0) {
 		memcpy(od_table, user_od_table, sizeof(OverDriveTableExternal_t));
+		if (table_context->user_od_feature_mask & BIT(PP_OD_FEATURE_UCLK_BIT))
+			smu_v13_0_0_od_refresh_uclk_table(smu);
+	}
 
 	return res;
 }
-- 
2.55.0

