Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E06D41149
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 09:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4722110E715;
	Thu, 15 Jan 2026 09:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=worksmobile.com header.i=@worksmobile.com header.b="BdwAZmnn";
	dkim=pass (1024-bit key; unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="Ty6cAw7z";
	dkim-atps=neutral
Received: from cvsmtppost102.wmail.worksmobile.com
 (cvsmtppost102.wmail.worksmobile.com [125.209.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F44A10E2AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
 s=s20171120; t=1768408689;
 bh=jW3niGFTEaJ0K8AOflj/yHyQ/c0Y6u8SGkEJ2hz38xQ=;
 h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
 X-Works-Security;
 b=BdwAZmnnGqiDtl3wZYKy92Dj6P8VeaRR6Sbriy9rkaW1gNB5/qZx2BQ7G74HQIYmp
 LRGSr4guFUxvSFwtePymXlka/Ci4Tpu7mIg4zBNhgiYxmrFLONOviei/d8LDA04WRa
 AzA5JquArkU4CyJffNEDl7avmB3akbqgrvkGDTy5QyJazjaVfQl9ScGqNQExK6sbek
 ks0NutArnszIDINpN/tQ7IylsE64ATqM0SUqy0PwUm9mj4shj1vPLLjs7+kZPiMX/v
 TVwfwWijf/EOTy1BtxT+5ceo/HASxaZCAOzPjFFW721qXJL8RpIDRg4rk5O7AliDWt
 o2TWDz0v62zqg==
X-Originating-IP: 163.152.163.130
Received: from cvsendbo002.wmail ([10.113.20.164])
 by cvsmtppost102.wmail.worksmobile.com with ESMTP id i51mi-OtQ0CUP7grTeIvRg
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:38:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
 s=naverworks; t=1768408689;
 bh=jW3niGFTEaJ0K8AOflj/yHyQ/c0Y6u8SGkEJ2hz38xQ=;
 h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
 X-Works-Security;
 b=Ty6cAw7zGaqdn2cwWho9cvxmzy4f2if5VE+bIcAi8embs9gZFRogxUuALapwsRBcG
 aaRMPbspd5/ZpzOkTWcJ47h0mcAiD01VCkKzQUtLaFHgWneD7Ce+Dac6BqJtpNkSd5
 WYYWqULuEvfjBkqpJXnT24y064b1mjtixhAPMpNc=
X-Session-ID: Ot37YJnORnuHHAgqcZ+spw
X-Originating-IP: 163.152.163.130
X-Works-Send-Opt: EenqjAJYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: g9bXKq2rFqJZ+HmlaAUr+6E=
Received: from s2lab05.. ([163.152.163.130])
 by jvnsmtp401.gwmail.worksmobile.com with ESMTP id Ot37YJnORnuHHAgqcZ+spw
 for <multiple recipients>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 14 Jan 2026 16:38:09 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: amd-gfx@lists.freedesktop.org
Cc: kenneth.feng@amd.com, alexander.deucher@amd.com,
 Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [PATCH] drm/amd/pm: remove dead code in
 smu7_patch_dependency_tables_with_leakage()
Date: Thu, 15 Jan 2026 01:38:07 +0900
Message-Id: <20260114163807.2525868-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <BL1PR12MB51443B02293AA31A924754C6F782A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <BL1PR12MB51443B02293AA31A924754C6F782A@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Jan 2026 09:24:59 +0000
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

All smu7_patch_*() functions called in this function always return 0.
They internally call smu7_patch_ppt_v0_with_vdd_leakage() which is a
void function with no error paths.

Remove the unnecessary return value checks that can never be true.

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 61 ++++---------------
 1 file changed, 12 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 9b28c07282699..cabf1a5db5e61 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2784,55 +2784,18 @@ static int smu7_patch_cac_vddc(struct pp_hwmgr *hwmgr, struct phm_cac_leakage_ta
 
 static int smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr *hwmgr)
 {
-	int tmp;
-
-	tmp = smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_sclk);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_mclk);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_vddci(hwmgr, hwmgr->dyn_state.vddci_dependency_on_mclk);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_vce_vddc(hwmgr, hwmgr->dyn_state.vce_clock_voltage_dependency_table);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_uvd_vddc(hwmgr, hwmgr->dyn_state.uvd_clock_voltage_dependency_table);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_samu_vddc(hwmgr, hwmgr->dyn_state.samu_clock_voltage_dependency_table);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_acp_vddc(hwmgr, hwmgr->dyn_state.acp_clock_voltage_dependency_table);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_vddc_shed_limit(hwmgr, hwmgr->dyn_state.vddc_phase_shed_limits_table);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage_on_ac);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage_on_dc);
-	if (tmp)
-		return -EINVAL;
-
-	tmp = smu7_patch_cac_vddc(hwmgr, hwmgr->dyn_state.cac_leakage_table);
-	if (tmp)
-		return -EINVAL;
+	smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_sclk);
+	smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_mclk);
+	smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
+	smu7_patch_vddci(hwmgr, hwmgr->dyn_state.vddci_dependency_on_mclk);
+	smu7_patch_vce_vddc(hwmgr, hwmgr->dyn_state.vce_clock_voltage_dependency_table);
+	smu7_patch_uvd_vddc(hwmgr, hwmgr->dyn_state.uvd_clock_voltage_dependency_table);
+	smu7_patch_samu_vddc(hwmgr, hwmgr->dyn_state.samu_clock_voltage_dependency_table);
+	smu7_patch_acp_vddc(hwmgr, hwmgr->dyn_state.acp_clock_voltage_dependency_table);
+	smu7_patch_vddc_shed_limit(hwmgr, hwmgr->dyn_state.vddc_phase_shed_limits_table);
+	smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage_on_ac);
+	smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage_on_dc);
+	smu7_patch_cac_vddc(hwmgr, hwmgr->dyn_state.cac_leakage_table);
 
 	return 0;
 }
-- 
2.34.1

