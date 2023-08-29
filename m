Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F17C83F14
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 14:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D72610E110;
	Tue, 29 Aug 2023 14:55:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B3F10E110
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 14:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSFd+LMxNrFLNWNJMxyckFFDyk6ljFsGHLYwGk1ku/5cXimZwhYKQ1oYV+jqSuXPrIMpwsNuh67a2NV6p048PLAoU3qQryFOTXR/aU367WqbovkfpV9Y+6O0RwEGhRlW7EcvxMqG9emn7S5z47blByC9RXcgDWd00FWeq5DokB8eZA03e1rXfWLGzManY+c5juqGBN5Gg19GwftGnLHgeua3N35jmft4B8jGG+RAAytwEhx2d8JTwslqCjgIVuR35S/j/P7aPFktuhU4aGDLqYJ5q/34nKsetreDeU15FEtNPxyrvT9fxROTE5pBt+11zAoaYruFyz1V8P+zphCsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI1wzv972hySKsjvEr4I/Fe/PvzBIT8SPOxTTjZloa0=;
 b=Y0XmZR3u3P6gSw48FYTsUa7iF1aUHNsoE9duFbR0d8/OBX8SCTMtKFRxpFgiDSgkKbQ9qSfbIVSbwDJMisjH/LQsONpapYVsggdHO8noI+8clfhkfSXWZpero7KTsxTJeL92hQ4NhNU2rYuoh7D3dIfe4kNKRZguHys7+DZdnH+rcSOMiYdrzPHJUG/UfnoApR4zdlh+Ery44PEPgAlAyga3wLwOqTW+lTy3ESveRlvekUJUVB7KgQ1q0SziQ5S5gaGe6brnFfC9NP/zRmcS0wbdynaUHo8tNrDEPrrdAqxL0G/8w2hl+OybJYV/CmjWhqv54aGq7RgtnP9+xVqQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI1wzv972hySKsjvEr4I/Fe/PvzBIT8SPOxTTjZloa0=;
 b=foNSaY+DklBW6IXS96SOXlYv/Fia/xq7RkcpqKqMtxwauA23ac8eemNOCuKwbv9l01jOSt/qb42ElNBiah9dvT/XA4uNf6KOTnPlHoRyc4oV+hSZTKZn7jo2QSHU+rPfcu0hpd1xHf8yDusgm9VMGH+SLILNXPovNWpQICIRCes=
Received: from DS7PR03CA0168.namprd03.prod.outlook.com (2603:10b6:5:3b2::23)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 14:55:18 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::79) by DS7PR03CA0168.outlook.office365.com
 (2603:10b6:5:3b2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 14:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 14:55:17 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 09:55:16 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix reg offset for setting CWSR grace period
Date: Tue, 29 Aug 2023 10:55:00 -0400
Message-ID: <20230829145500.90708-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 76994258-807c-4997-6786-08dba89ff5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brru3mUuz3iKfjGVT4NzgEYDBuE9YMLpajfP4i781c8l/hvtDsT8rLaFCDHUvfG16DAa/ElmuTwxWINhdx+AsFmj0DL8jOniHnqF4Nl350R+pSlE5yuEqz6Tjr0EdyY/RDKm7Ko1Kfs0+wK6MPBr/XogZqdcmmmfqLTOEsuP2+Rt8fWcR3SDtOPpSHr25/GUadNpPPc/GIBhsIGTLU183lXliJwns69XwvK9zxvb2LJF7krwxlgeII+gzI6i/DOPPwxyDxFrnp60+HNg2RBEIrYFCUfg+uuu043nOn4FyNkL0+me8XZgob8o3NHGBNzbWsHhnvfonpDrq3bh9sR4VCuQ9uTgQ5fsA3HyAUTNpwRiNiTjZ2yAvgScLh1A6Psz7SvPaFv28OAH5LpmSy7B1O8wqODI+VqZBMoL9gNBOkNmtcgbCgYyIApMuaqu1g6yG06oCiT+rYp+Ik6m9/ssKRXAcfuk8xRopifwn36h3R0Lu19+uwUoSh/IDy2TnH7ZmDd2MD4KgCjwq9fbUG0eCGxl6DFOhXGFgLombi/JWqclQ/czM21TrNjcoT52jXazLqTDID54Q+Gv+w3o3evqnqvNdAJP52UJ2wpWZ11xKi/wv0LwXf7nWGYOOccCVc891SL4iv9r4lrzyS9Ru0kw7YYLwsnXgYCsOcIh5aGGvOmYtk9JX4ytKb00Ulb8uaf9UAl6q6A3oC2VVVXdhV49FL2IKbbpLcg8A63/ICCwu/MRxEpPFtqeWwfOhbAPaAhh1/0XswIjnGXnUF7g+RXf0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(478600001)(356005)(81166007)(83380400001)(82740400003)(36860700001)(26005)(16526019)(426003)(336012)(47076005)(1076003)(2616005)(40480700001)(7696005)(6666004)(44832011)(2906002)(6916009)(8676002)(4326008)(5660300002)(70206006)(316002)(41300700001)(54906003)(36756003)(8936002)(70586007)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 14:55:17.7823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76994258-807c-4997-6786-08dba89ff5b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, felix.kuehling@amd.com,
 jonathan.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch fixes the case where the code currently passes
absolute register address and not the reg offset, which HWS
expects, when sending the PM4 packet to set/update CWSR grace
period. Additionally, cleanup the signature of
build_grace_period_packet_info function as it no longer needs
the inst parameter.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c     | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h     | 3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c    | 3 +--
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h       | 3 +--
 7 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index f1f2c24de081..69810b3f1c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -980,8 +980,7 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 						uint32_t wait_times,
 						uint32_t grace_period,
 						uint32_t *reg_offset,
-						uint32_t *reg_data,
-						uint32_t inst)
+						uint32_t *reg_data)
 {
 	*reg_data = wait_times;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index ecaead24e8c9..67bcaa3d4226 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -55,5 +55,4 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
-					       uint32_t *reg_data,
-					       uint32_t inst);
+					       uint32_t *reg_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index fa5ee96f8845..3c45a188b701 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1103,8 +1103,7 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 		uint32_t wait_times,
 		uint32_t grace_period,
 		uint32_t *reg_offset,
-		uint32_t *reg_data,
-		uint32_t inst)
+		uint32_t *reg_data)
 {
 	*reg_data = wait_times;
 
@@ -1120,8 +1119,7 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 			SCH_WAVE,
 			grace_period);
 
-	*reg_offset = SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
-			mmCP_IQ_WAIT_TIME2);
+	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
 
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 936e501908ce..ce424615f59b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -100,5 +100,4 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
-					       uint32_t *reg_data,
-					       uint32_t inst);
+					       uint32_t *reg_data);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b166f30f083e..8a6cb41444a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1677,8 +1677,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 			dqm->dev->kfd2kgd->build_grace_period_packet_info(
 					dqm->dev->adev,	dqm->wait_times,
 					grace_period, &reg_offset,
-					&dqm->wait_times,
-					ffs(dqm->dev->xcc_mask) - 1);
+					&dqm->wait_times);
 	}
 
 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8ce6f5200905..1a03173e2313 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -299,8 +299,7 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 			pm->dqm->wait_times,
 			grace_period,
 			&reg_offset,
-			&reg_data,
-			0);
+			&reg_data);
 
 	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
 		reg_data = pm->dqm->wait_times;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 679e8d6a5a2e..3b5a56585c4b 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -326,8 +326,7 @@ struct kfd2kgd_calls {
 			uint32_t wait_times,
 			uint32_t grace_period,
 			uint32_t *reg_offset,
-			uint32_t *reg_data,
-			uint32_t inst);
+			uint32_t *reg_data);
 	void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
 			int *wave_cnt, int *max_waves_per_cu, uint32_t inst);
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
-- 
2.35.1

