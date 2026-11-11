Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4A606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbnD2TDo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0408D10E233;
	Wed, 11 Nov 2026 02:40:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C909410E233
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 02:40:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6006843F83;
 Wed, 11 Nov 2026 02:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592001F0089F;
 Wed, 11 Nov 2026 02:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794364834;
 bh=7WX1G6+ktrzrYe81d7r8LDzTp8bhfw3CI+SJD6UOSx8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fbnD2TDo3nIPlZPLq77gTlkKiW32wuwflv7k/RYG+fX5rpoK5K+UnMOYffoxMCvpB
 QjoZHUoLm477ErGm8kHNSLV6T5IY+zo6dRFlW0efUpiqBPUqnF6wZDZXp3N28QLtEf
 cDK2kpvRhtDXwNYQAt3zInpc2q+hHyWieyuTBT2A3wq1zmb+GqVA1saVuKf8MlWjwJ
 pyFpiOai+0hImMYeE3heFWfIdGDFIsZV5x1CnBPUA9Wl2iBUHhFfXKkA2h5OCJ0yox
 7qr6Ik3lKV3N/XhnZhaxXrDJkhQhZpitGzlkgxtlFx9B/h6KNAo7y5r0rbUK8Sk7Mf
 +BoUEqwowTfsA==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Ilya Shidlovskiy <shidlovskiyilya@gmail.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Kevin Wang <kevin.wang@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: [PATCH linux-next] drm/amd/pm: bring back od_uclk_changed dropped by
 the amdgpu merge
Date: Tue, 10 Nov 2026 21:40:32 -0500
Message-ID: <20261111024032.760400-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avNxxfHK_Zh2GN2o@sirena.org.uk>
References: <avNxxfHK_Zh2GN2o@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The amdgpu tree adds od_uclk_changed to struct smu_table_context in
commit 62d932f72037 ("drm/amd/pm: smu13.0.0: refresh the UCLK DPM table
after an OD_MCLK change"). It sits right next to user_od_feature_mask,
which mainline added too, so amdgpu_smu.h conflicts, and the merge
dropped the new field.

After that, commit c62c2736d82f ("amdgpu: Merge merge merge cherry-pick
cherry-pick cherry-pick") made smu_od_uclk_changed() return false and
removed the code that sets the flag. So DC never re-reads the UCLK
levels after an overdrive change, which is the whole point of
commit b7483797b085 ("drm/amd: let DC re-read UCLK DPM levels after an
OD_MCLK change").

Keep both fields and put the removed code back.

Fixes: af8e519642bd ("Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux.git")
Link: https://lore.kernel.org/all/avNxxfHK_Zh2GN2o@sirena.org.uk/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Mark, this is against next-20261110. Please fold it into the amdgpu merge;
it replaces the smu_od_uclk_changed() part of c62c2736d82f.

With this the three files are the same as in the amdgpu tree.

Found by comparing with our llminus-assisted integration tree. Build tested
only.

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 9 ++++++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h        | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ff51ff875bfed..86e34e814fe6a 100644
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
 
@@ -3701,7 +3704,11 @@ static int smu_baco_set_state(void *handle, int state)
  */
 bool smu_od_uclk_changed(struct smu_context *smu)
 {
-	return false;
+	bool changed = smu->smu_table.od_uclk_changed;
+
+	smu->smu_table.od_uclk_changed = false;
+
+	return changed;
 }
 
 bool smu_mode1_reset_is_support(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 41d665591d62a..2a0cdc6e80596 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -434,6 +434,8 @@ struct smu_table_context {
 	void				*user_overdrive_table;
 
 	uint32_t			user_od_feature_mask;
+	/* Set when an OD commit/restore changed the UCLK levels */
+	bool				od_uclk_changed;
 
 	struct smu_driver_table driver_tables[SMU_DRIVER_TABLE_COUNT];
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 02bd2b15066cc..1a02ba70d3000 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1306,6 +1306,8 @@ static void smu_v13_0_0_od_refresh_uclk_table(struct smu_context *smu)
 		dev_err(smu->adev->dev, "Failed to refresh UCLK dpm table!\n");
 		return;
 	}
+
+	smu->smu_table.od_uclk_changed = true;
 }
 
 static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,

base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
-- 
2.53.0

