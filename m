Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17224C001B0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 15:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A52510E1A4;
	Tue, 15 Aug 2023 15:51:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1275410E1A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 15:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rvs9oVoZA3YCFLuoTIGv1NdWfpPsS8eiQH3VwXS0dG2DiyZl1wSEFsdtcg1HVL4lCbC0o/ScC46v1RMwAXNPs7rqVHr2NMwBCfajuNEG57+0h3J26t7mcbhT7y0JkE2644aTuqbVrfpxPP/H+OXTIaX3QAug7y8zSijjZpdi4jalEFHTUPXkUsC9fJD0SHzJe3gtZfjVjgn8m4iGrodDph9dSTePo2UQ3GL97EYejsBmBjyYIEByWofrLoV70f4NQQ1rHXdg5vTdEkrCFSSgAHUgQ5DYGIl++xzrRvh5C/E6qj26MiuoStDc4o0C3P20Ha+fXUgNK8mYHbTSWauGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sb3RLZq44QxzzXAtiI8fK4asHNvr84QXV2A+/SVhlQ8=;
 b=QE8l3u0jh45YmAr9ysZQVwgzwQJUgvJSRa7yUdVSRmHg39dMwXmekL5pSMGOlFmI2BviSy5BL6Wg1n9/0+lIMtygAWFKh9W7bp1cum0wySBp8e5RxhKv5DAdzEySPfdx8wfRiXwDgijCGwHazOLl7sCX7covas9WbIWFJ/pVs5viYHZqeri3r6Nq6Xq8kFqJnFjbq2k5a7Mbo1xQiQ7ox1fq2P97bK2S82QoG6mFd4WZaRDffs9JdX7r/xgXIPnx3WBDZ4q6PxUD169rSxhWkp+a9wyd4or3YTxVPHlLKtnU2tBixN41mVo24qnU5sy9twhcS5hEtmX/I/RMnNU9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb3RLZq44QxzzXAtiI8fK4asHNvr84QXV2A+/SVhlQ8=;
 b=foPiwEBcOyYLimzaIGXPaiKXotcwAaacU/Elitsi0MLKQKlJKZjFLQhhlycroJdg3d4Tpmfw/keooaz/eyw1ky1u5u7eeNmFsPl5O9O/H+z8W6W2Ov4d2RvHaWFbnrm92f6SV264WM4L7SQTsZuUWtr16bdOKmksLhnplueRaD0=
Received: from SA1P222CA0158.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::18)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:51:10 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::71) by SA1P222CA0158.outlook.office365.com
 (2603:10b6:806:3c3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 15:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 15:51:10 +0000
Received: from navi32bu-james.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 10:51:09 -0500
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC support
Date: Tue, 15 Aug 2023 11:50:26 -0400
Message-ID: <20230815155026.197131-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b737e90e-10f2-4ef4-b49a-2eba5f83afef@amd.com>
References: <b737e90e-10f2-4ef4-b49a-2eba5f83afef@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee05e33-529b-4aba-6e9e-08db9da77209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vBX4c0+OZ9o1p1NESDf/AC/tYCCQhm16sKHqwiPr/B+6IzxUbTugitltpQINRLf+YZ3cYrbd/DX9ar7QMClHKEnND5pbppeHzWqcijtpuOCyEMfWzDHyqT/shiclG7UNPvDBjeUsce2KRrl2slCi1t/DkmTGTQ1UWUxDvmkZtJIiGlXBfsaBg1WCnXzJe0LiZyjrQ6Wq5NP63PDcClmAj5RLiq7+7gbwKLQy0JCSbNOChjN+xxBdrG1pjNAbZm0WozQAtR0Tv+3+cYtOMbhBxfCTHTAwdOx7/TZOFC4APbeqw9pJq8/ZprBZZgEEfaxfEsnZajHI7fY0aR86tR5GcuYuoDu7auuO0qNX9qvMijyXAHWCPKAWqXKigTItF6J/f9FHIGWe3XYkB9Ea1v6pCph9lTh970Z/EaoKy7WcZ5BpQ99dVj4Ws8Qnp73fwC6Hl/vZMk1JNBrT+SxiUFDqt5QvvGhmCHh90o4QG1FD74uNGlAsOnhxlaPzgspr/cFKnJPXt2JCj5/w/PGWqMKUaz7OCC5NQ8MR9uoaauOTi8sfOcs5iAqqrbgj3LnwflPYDHAMNRjl7Rh0lazyBNoBjgi5zz16POFOPYt26YXzVDdzeYX8q840hOBebX19EkvIZUKbytxH1WqFZHlpdS8+2piDC7n5xjm8rL/dVVetieMzfWuk7VT1z/Gafm+cYTjxFbm7rUlWRXYR+ERznRkbrAG19diwBRX3/xyq97iifCrA3I5pgvV8ZHO3FJECWSHGqvSLZ1Wz3JV6rIB8epGpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(70586007)(82740400003)(2906002)(5660300002)(54906003)(36756003)(2616005)(41300700001)(336012)(7696005)(426003)(47076005)(1076003)(4326008)(8936002)(8676002)(316002)(6666004)(26005)(16526019)(356005)(70206006)(15650500001)(81166007)(83380400001)(40480700001)(478600001)(36860700001)(40460700003)(86362001)(44832011)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:51:10.0595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee05e33-529b-4aba-6e9e-08db9da77209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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
Cc: Bokun Zhang <bokun.zhang@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- There is a DPM issue where if DC is not present,
  FCLK will stay at low level.
  We need to send a SMU message to configure the DPM

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                  | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h              | 5 +++++
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h   | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h               | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c       | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h                | 1 +
 6 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f005a90c35af..c65bebdbec11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1410,6 +1410,12 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	if (!amdgpu_device_has_dc_support(adev)) {
+		ret = smu_notify_no_dc(smu);
+		if (ret)
+			dev_warn(adev->dev, "Failed to notify no dc support, driver may not reach best performance\n");
+	}
+
 	/*
 	 * Set min deep sleep dce fclk with bootup value from vbios via
 	 * SetMinDeepSleepDcefclk MSG.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 6e2069dcb6b9..c8fdc3d0aa25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1356,6 +1356,11 @@ struct pptable_funcs {
 	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
 	 */
 	int (*init_pptable_microcode)(struct smu_context *smu);
+
+	/**
+	 * @notify_no_dal: Notify SMU that there is no display and SMU should control DPM
+	 */
+	int (*notify_no_dc)(struct smu_context *smu);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
index 10cff75b44d5..e2ee855c7748 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
@@ -138,7 +138,10 @@
 #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
 #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
 #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
-#define PPSMC_Message_Count                      0x4D
+
+#define PPSMC_MSG_DALNotPresent                  0x4E
+
+#define PPSMC_Message_Count                      0x4F
 
 //Debug Dump Message
 #define DEBUGSMC_MSG_TestMessage                    0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 297b70b9388f..f71fc99447f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -245,7 +245,8 @@
 	__SMU_DUMMY_MAP(AllowGpo),	\
 	__SMU_DUMMY_MAP(Mode2Reset),	\
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
-	__SMU_DUMMY_MAP(GetMetricsTable),
+	__SMU_DUMMY_MAP(GetMetricsTable), \
+	__SMU_DUMMY_MAP(DALNotPresent),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 48b03524a52d..41412cf891a7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -160,6 +160,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
 	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
+	MSG_MAP(DALNotPresent,		PPSMC_MSG_DALNotPresent,       0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -2601,6 +2602,11 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_0_notify_no_dc(struct smu_context *smu)
+{
+	return smu_cmn_send_smc_msg(smu, SMU_MSG_DALNotPresent, NULL);
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -2680,6 +2686,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.send_hbm_bad_channel_flag = smu_v13_0_0_send_bad_mem_channel_flag,
 	.gpo_control = smu_v13_0_gpo_control,
 	.get_ecc_info = smu_v13_0_0_get_ecc_info,
+	.notify_no_dc = smu_v13_0_0_notify_no_dc,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index bcc42abfc768..9b9a13fdcef8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -97,6 +97,7 @@
 #define smu_get_default_config_table_settings(smu, config_table)	smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
 #define smu_set_config_table(smu, config_table)				smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
 #define smu_init_pptable_microcode(smu)					smu_ppt_funcs(init_pptable_microcode, 0, smu)
+#define smu_notify_no_dc(smu)						smu_ppt_funcs(notify_no_dc, 0, smu)
 
 #endif
 #endif
-- 
2.25.1

