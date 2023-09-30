Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF59E77350
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Sep 2023 03:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A9410E148;
	Sat, 30 Sep 2023 03:23:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8894710E12D
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Sep 2023 03:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhiNyUDhkScsluCB9LSVEJEzYfu3cVi2zqOQT4xvodgxHkni02hkjn8aRgOxP4zfPoDV/uAK3dReeha2G0qfrL657mqSGq69En/DrVYnhQwGC3B5XfUofc1SGtHcoeKw0P6dtGFJqPgSHYufCbGP60GlyGwLq3RbDT5E/K4DEgd7yctpTEqoW1nQKEdwPxntKsZkQC9esghoR+eJdgDXJ9DMJgMtbusBPoGSEHNs5CtXhn0yc8Ggff8+03TiFBqukQb7rzLoweAvQWh+/O+lTupxjfgGXtZEimSiI7VMSfiYt3PTYjDQkKh2NFlXsI17PpCCr2+GU8mThDQE8uyBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ugm6zzCgS8mijRF7KIc0VqPs8qKiH/HOD5T8a75hRW8=;
 b=Yy4z/+IhC6cWTTw5jjvgEkFlF2lGEVe5jEkxpth19C2WXtWQTt2TXq8GCR4iCB+6yKg7M2zKORVUbsouxgtzBccv8iiSLLfGCaCVEqO7CbojqmbwzGg7ikwhMsgmMJE8/SSsAzoq5Gx/OEWv9claaSCKwGdXYolX/emYfiGDrtInlvxQRuJhddhruR072Wbc405AsjKzLr+aXfrhpGWbmHDlbAJtHRY+jnfDMKHkSNr4QeH9+JqOAsv36OfBSdzmVwxsd17R+K7B+1mbiYl/0Ru888k/h7zTtCz0PfMGHP/KRalJcKvnS/obQ0+nXOGvzsuczSZxxK2HAMKxDb1y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugm6zzCgS8mijRF7KIc0VqPs8qKiH/HOD5T8a75hRW8=;
 b=N+VuBzPrrGNE3Re2KOpC87JFsXiCu+zpESVZ6aRqko7XYSOYuB3BeCe0zQgGPhvsW8y/LVUtshqp9ardntMaySwZke93D/qB00/o2x1Gw3g6mIY2sJKpph7thvr9m9ZmKEicUDyawMrqFYAD0r7ybygiBGW6vqDMvUPGp1IZVlw=
Received: from MN2PR06CA0010.namprd06.prod.outlook.com (2603:10b6:208:23d::15)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.39; Sat, 30 Sep
 2023 03:23:22 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::c0) by MN2PR06CA0010.outlook.office365.com
 (2603:10b6:208:23d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27 via Frontend
 Transport; Sat, 30 Sep 2023 03:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sat, 30 Sep 2023 03:23:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 22:23:13 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: Drop all hand-built MIN and MAX macros in the
 amdgpu base driver
Date: Fri, 29 Sep 2023 22:22:54 -0500
Message-ID: <20230930032254.580-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930032254.580-1-mario.limonciello@amd.com>
References: <20230930032254.580-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a0475f-9a0e-4b0b-c6b5-08dbc1649971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nyt6ERZiGuk2U62EWjFVYX2oqnYNJeDwh9L/FhJSDa5yLipgiHnejSDgiqWpDdYCzFrv58rA4jdbdfbwQLD7wsYSLY+qs2s6nBOPdxmfH/w90MT2g9hKPOnsW+ccAAmEUHgrxhBfM5vInoKB9It0UisbCXmeWXZmF0r/c+J2PS0gG/hnmPBUOeSbpWjdAHaBS+QIKalYD7zfWWhZoZ30aGAtrxSD98Qkppc3ow2NeQIESLTPoAyUJZHVvb5LcZ8M/pzab76WofGDge6Q2pst1SlgSfv7uXyuGJ+SJNUR84B7WIN9WnQPuXDCU2ckQ5pBuUTfXiR+MoHxmhJOThFZWxJm5i/sBrSX/FJL1eEbgT3MryTn1EJg51sv4OokkXKWjrhQhRqOZ/OF6uux4Bn0gfXjtmloUU4OTFMXQllBbfT9fI7qVo3/aP9bzoZ01FkTIEPpcIiWWDdFIOoelCRxAihvMthD5V/Fvnw+bP0pR+q46yOiuGFEEQcqu5gOaJaRDXimIuZ7bfacCDuhkIn5BOR5oHRr/x9T1KNWY5+hcigXiNSKRdyS7Ob4SFHk8Zr1NM5U2G+8k0dMsr5LrdcWHb0hLfsG5Pr7KRCqlpyvGWR4U/6SNqvWVprH1WW4YYQSYbWY93fmxfyFYiyz7yvgjEklwcSyeFjJR95tsXeM99RJW49FvpU2G/4J9A83pJMC89jr7CUGLNQ8kieIA+YJvs48yt3uxErGcHQHs4YK0vRkfvl9T/RnfDLNChG1sa91wAqUXWhbfMfk7VQ3syPiwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(86362001)(82740400003)(356005)(81166007)(40480700001)(36756003)(30864003)(2906002)(6666004)(7696005)(44832011)(336012)(5660300002)(426003)(2616005)(70586007)(26005)(1076003)(16526019)(70206006)(6916009)(54906003)(41300700001)(316002)(4326008)(8936002)(478600001)(8676002)(36860700001)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 03:23:21.7849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a0475f-9a0e-4b0b-c6b5-08dbc1649971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Several files declare MIN() or MAX() macros that ignore the types of the
values being compared.  Drop these macros and switch to min() min_t(),
and max() from `linux/minmax.h`.

Suggested-by: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                    |  2 --
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c             |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c  |  4 ++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    |  4 ++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c    |  4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c      |  4 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c         |  4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c         |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  7 +++----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  7 +++----
 11 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 73e825d20259..d23fb4b5ad95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1329,8 +1329,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 	for (i = ffs(inst_mask); i-- != 0; \
 	     i = ffs(inst_mask & BIT_MASK_UPPER(i + 1)))
 
-#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
-
 /* Common functions */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
 bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 02e69ccff3ba..fc8e4ac6c8e7 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6600,7 +6600,7 @@ static int si_dpm_get_fan_speed_pwm(void *handle,
 
 	tmp64 = (u64)duty * 255;
 	do_div(tmp64, duty100);
-	*speed = MIN((u32)tmp64, 255);
+	*speed = min_t(u32, tmp64, 255);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index a6c3610db23e..a8fc0fa44db6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -72,7 +72,7 @@ int smu7_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 
 	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
-	*speed = MIN((uint32_t)tmp64, 255);
+	*speed = min_t(uint32_t, tmp64, 255);
 
 	return 0;
 }
@@ -210,7 +210,7 @@ int smu7_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 	if (hwmgr->thermal_controller.fanInfo.bNoFan)
 		return 0;
 
-	speed = MIN(speed, 255);
+	speed = min_t(uint32_t, speed, 255);
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 190af79f3236..379012494da5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -81,7 +81,7 @@ int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 
 	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
-	*speed = MIN((uint32_t)tmp64, 255);
+	*speed = min_t(uint32_t, tmp64, 255);
 
 	return 0;
 }
@@ -255,7 +255,7 @@ int vega10_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 	if (hwmgr->thermal_controller.fanInfo.bNoFan)
 		return 0;
 
-	speed = MIN(speed, 255);
+	speed = min_t(uint32_t, speed, 255);
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index e9737ca8418a..a3331ffb2daf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -131,7 +131,7 @@ int vega20_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 
 	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
-	*speed = MIN((uint32_t)tmp64, 255);
+	*speed = min_t(uint32_t, tmp64, 255);
 
 	return 0;
 }
@@ -144,7 +144,7 @@ int vega20_fan_ctrl_set_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 	uint32_t duty;
 	uint64_t tmp64;
 
-	speed = MIN(speed, 255);
+	speed = min_t(uint32_t, speed, 255);
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		vega20_fan_ctrl_stop_smc_fan_control(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 6e2e665ad383..a2bbc180b160 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1203,7 +1203,7 @@ static int arcturus_set_fan_speed_pwm(struct smu_context *smu,
 	uint32_t duty100, duty;
 	uint64_t tmp64;
 
-	speed = MIN(speed, 255);
+	speed = min_t(uint32_t, speed, 255);
 
 	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1_ARCT),
 				CG_FDO_CTRL1, FMAX_DUTY100);
@@ -1267,7 +1267,7 @@ static int arcturus_get_fan_speed_pwm(struct smu_context *smu,
 	if (duty100) {
 		tmp64 = (uint64_t)duty * 255;
 		do_div(tmp64, duty100);
-		*speed = MIN((uint32_t)tmp64, 255);
+		*speed = min_t(uint32_t, tmp64, 255);
 	} else {
 		*speed = 0;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index dd07662262e4..ad2884088e69 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2089,8 +2089,6 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
-#define MAX(a, b)	((a) > (b) ? (a) : (b))
-
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 						 uint8_t pcie_gen_cap,
 						 uint8_t pcie_width_cap)
@@ -2106,12 +2104,12 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
 	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
 
-	min_gen_speed = MAX(0, table_member1[0]);
-	max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
+	min_gen_speed = max_t(uint8_t, 0, table_member1[0]);
+	max_gen_speed = min(pcie_gen_cap, table_member1[1]);
 	min_gen_speed = min_gen_speed > max_gen_speed ?
 			max_gen_speed : min_gen_speed;
-	min_lane_width = MAX(1, table_member2[0]);
-	max_lane_width = MIN(pcie_width_cap, table_member2[1]);
+	min_lane_width = max_t(uint8_t, 1, table_member2[0]);
+	max_lane_width = min(pcie_width_cap, table_member2[1]);
 	min_lane_width = min_lane_width > max_lane_width ?
 			 max_lane_width : min_lane_width;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index ece43b41141c..5a314d0316c1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1174,7 +1174,7 @@ smu_v11_0_set_fan_speed_pwm(struct smu_context *smu, uint32_t speed)
 	uint32_t duty100, duty;
 	uint64_t tmp64;
 
-	speed = MIN(speed, 255);
+	speed = min_t(uint32_t, speed, 255);
 
 	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
 				CG_FDO_CTRL1, FMAX_DUTY100);
@@ -1249,7 +1249,7 @@ int smu_v11_0_get_fan_speed_pwm(struct smu_context *smu,
 
 	tmp64 = (uint64_t)duty * 255;
 	do_div(tmp64, duty100);
-	*speed = MIN((uint32_t)tmp64, 255);
+	*speed = min_t(uint32_t, tmp64, 255);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 208db8b580eb..8dc683c02a7d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1169,7 +1169,7 @@ int smu_v13_0_set_fan_speed_pwm(struct smu_context *smu,
 	uint32_t duty100, duty;
 	uint64_t tmp64;
 
-	speed = MIN(speed, 255);
+	speed = min_t(uint32_t, speed, 255);
 
 	if (smu_v13_0_auto_fan_control(smu, 0))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1c15fa911176..a52da7bc787b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1998,7 +1998,6 @@ static int smu_v13_0_0_get_thermal_temperature_range(struct smu_context *smu,
 	return 0;
 }
 
-#define MAX(a, b)	((a) > (b) ? (a) : (b))
 static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
@@ -2022,12 +2021,12 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->temperature_mem = metrics->AvgTemperature[TEMP_MEM];
 	gpu_metrics->temperature_vrgfx = metrics->AvgTemperature[TEMP_VR_GFX];
 	gpu_metrics->temperature_vrsoc = metrics->AvgTemperature[TEMP_VR_SOC];
-	gpu_metrics->temperature_vrmem = MAX(metrics->AvgTemperature[TEMP_VR_MEM0],
+	gpu_metrics->temperature_vrmem = max(metrics->AvgTemperature[TEMP_VR_MEM0],
 					     metrics->AvgTemperature[TEMP_VR_MEM1]);
 
 	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
 	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
-	gpu_metrics->average_mm_activity = MAX(metrics->Vcn0ActivityPercentage,
+	gpu_metrics->average_mm_activity = max(metrics->Vcn0ActivityPercentage,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
@@ -2286,7 +2285,7 @@ static int smu_v13_0_0_get_fan_speed_pwm(struct smu_context *smu,
 	}
 
 	/* Convert the PMFW output which is in percent to pwm(255) based */
-	*speed = MIN(*speed * 255 / 100, 255);
+	*speed = min(*speed * 255 / 100, (uint32_t)255);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 430ad1b05ba3..b8a7a1d853df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1946,7 +1946,6 @@ static int smu_v13_0_7_get_thermal_temperature_range(struct smu_context *smu,
 	return 0;
 }
 
-#define MAX(a, b)	((a) > (b) ? (a) : (b))
 static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
@@ -1970,12 +1969,12 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->temperature_mem = metrics->AvgTemperature[TEMP_MEM];
 	gpu_metrics->temperature_vrgfx = metrics->AvgTemperature[TEMP_VR_GFX];
 	gpu_metrics->temperature_vrsoc = metrics->AvgTemperature[TEMP_VR_SOC];
-	gpu_metrics->temperature_vrmem = MAX(metrics->AvgTemperature[TEMP_VR_MEM0],
+	gpu_metrics->temperature_vrmem = max(metrics->AvgTemperature[TEMP_VR_MEM0],
 					     metrics->AvgTemperature[TEMP_VR_MEM1]);
 
 	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
 	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
-	gpu_metrics->average_mm_activity = MAX(metrics->Vcn0ActivityPercentage,
+	gpu_metrics->average_mm_activity = max(metrics->Vcn0ActivityPercentage,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
@@ -2210,7 +2209,7 @@ static int smu_v13_0_7_get_fan_speed_pwm(struct smu_context *smu,
 	}
 
 	/* Convert the PMFW output which is in percent to pwm(255) based */
-	*speed = MIN(*speed * 255 / 100, 255);
+	*speed = min(*speed * 255 / 100, (uint32_t)255);
 
 	return 0;
 }
-- 
2.34.1

