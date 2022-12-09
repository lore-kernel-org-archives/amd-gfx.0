Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE63C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 03:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA92010E21F;
	Fri,  9 Dec 2022 03:48:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F5710E03C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 03:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXk4aPsJX0uQ6CgtWWIJWZLN4w2oF1Acl3K/mVEi8bgkdP+JxPC/7n6FWkUg9ZvQyRRKr53ZDne++Q4V/heQDDXDJrqxtnydkTWWEMlwN3qX3h3Wrri1xiZui/5VUz5hIiOQxaK2VsRX8yWA+Aw+C6CMKIyfV/eZbR39145VUD8JUJ9DALXCGpWRyiIczHU1J5iwvQLDSWst82KnUNRHhl0knl+pTo2YyOA373xEJSMRnjEar6vI8JiOmYDajlWF2XJlrScqV+JINqz96DLLsEzfPN/L4i5V5PqF9B+nZ+KIrVKvQv+nXX2nnqT8AnejxYq4BKkPhwacF41ZKlZiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8UwiRvtOq/RkFYyzzBjdJaRwt3QVQYlifjRJCyBctc=;
 b=hJYJZMGO01M6t+WAca//4VqzEtgfzX4KKjePmOFd6J8hur5DZoGPf12WoRaf4C5/0dJV6LtZ7I61iUEtga6tVNyykH5fqJl6V96IXGPTxDlXfnRow95QiSN/XhWbfSYjI+SlnC951bpTKj39tkJH5El47NwFHOPhpn3sQJcWd1k4fpnyXyIu5XsRpV2Ew4I4sD9vFz8DW2KZ3BquPWg0Z6bci3D91eW/YWnXppV4V7vvWr0Vs+5WG98/mncMxNG0hUxdA0jB3+A8fXSlDPYzA98RySySwWpi6tF/idBpYZ7SKfo12wMTa1VwlW54/+eOXF5AMqQk+Hz5dm0DKvvM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8UwiRvtOq/RkFYyzzBjdJaRwt3QVQYlifjRJCyBctc=;
 b=LfbLrZ0pkkcMNGXXJX20hRNy3peb3uYXF/SjoAxJYg9eRc3ln4tHb2cJu7eKvcGbh9jdJfyGddCIUNSx7NBOLe+VCYH9vUee0xHa0OSG2gSAfXR/TXkcR3pNuO6u7CwFwca7U0y1/HwjCpZzqyKkBOog5PUIhkXtf9z8K1DKgzs=
Received: from DS7PR05CA0060.namprd05.prod.outlook.com (2603:10b6:8:2f::13) by
 DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Fri, 9 Dec 2022 03:48:45 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::c7) by DS7PR05CA0060.outlook.office365.com
 (2603:10b6:8:2f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.5 via Frontend
 Transport; Fri, 9 Dec 2022 03:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 03:48:45 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 21:48:43 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/10] drm/amd/pm: enable GPO dynamic control support for
 SMU13.0.0
Date: Fri, 9 Dec 2022 11:48:04 +0800
Message-ID: <20221209034813.2373727-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 014c77cd-4322-4a68-5049-08dad99845b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbUMBVcpl7Pi3H4JTASlt89eB3Bz0MVlrUdgBKfyDG16BhGI5AceBg61a719hBMdxqdm44H/KA8RHq7ke3t8JikygZpm82eYHDDeulHCtPUopVnJp9FOfE310yDfFUN0IoTrygKyLZHTbaC2hPd7nctsSP1W3ze2qEJA5wutziPHgPEFDIeRdKkyFrqHb6d+G8w5lo0dDKDRnTnl5UyM/Gk7xYM7K9+GOBXpkkofEf67Sdm7E/roj+j4oU0aabHxPfBqpgEN4P7yvIfx1Gr9G65MmANugvTSpa6k+KsOvjVfszovLLiNnKRxBBU0vCRT3dadSEo3zKkDI0+ExHNPW8r+6sbgzHQioSAMmh09uXncSDbT+HODMdM541a1LgQwGuQcDaHE5HwEzJfdS/pLDwLKNrnizytWTNlvX+rhXzfBp0CF2VnD5PO3u9j+BQWWYBG/cLiPjwyhHXO8aCrjxYcDESqgNFdfHM/D8Dy9v/bERtatx/1Bv6pJZk7d2fakb2lfT4EHun8Gwtf54aijen4OOnTgmkbtyInVXrPCLk4OQlEwAIsCwtuzBuz3iOtMbAALJMdS7QVK/99vhFUyCDC9B+Y0qL+rZ1LYWfDV2E53uNq2oOmrRmFYLi1gekaDoMrTltNxIfemde+sZu3V45Owt5XPcv0VXBgB3hxonxrEwiC68G+6yVDzfEfrdTLxYbN2UIuecRG7UV2oST4x7UtQVzWbMufTj+gowJlALlY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(40480700001)(36756003)(1076003)(26005)(47076005)(2616005)(186003)(426003)(478600001)(336012)(6666004)(7696005)(36860700001)(82740400003)(66574015)(16526019)(81166007)(40460700003)(356005)(83380400001)(86362001)(41300700001)(316002)(5660300002)(70586007)(8676002)(70206006)(44832011)(4326008)(6916009)(2906002)(8936002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:48:45.3357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 014c77cd-4322-4a68-5049-08dad99845b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To better support UMD pstate profilings, the GPO feature needs
to be switched on/off accordingly.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I162139a9e1ecac0a75d0fc3f93f608bf2223ac8c
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h      |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h      |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 15 +++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 ++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index a4e3425b1027..4180c71d930f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -241,7 +241,8 @@
 	__SMU_DUMMY_MAP(GetGfxOffEntryCount),		 \
 	__SMU_DUMMY_MAP(LogGfxOffResidency),			\
 	__SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),		\
-	__SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel),
+	__SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel), \
+	__SMU_DUMMY_MAP(AllowGpo),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 9c7941ae3844..46d472310b7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -273,6 +273,9 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu);
 
 int smu_v13_0_run_btc(struct smu_context *smu);
 
+int smu_v13_0_gpo_control(struct smu_context *smu,
+			  bool enablement);
+
 int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 				 bool enablement);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index f9c8af984a45..38517fe3317d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2180,6 +2180,21 @@ int smu_v13_0_run_btc(struct smu_context *smu)
 	return res;
 }
 
+int smu_v13_0_gpo_control(struct smu_context *smu,
+			  bool enablement)
+{
+	int res;
+
+	res = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_AllowGpo,
+					      enablement ? 1 : 0,
+					      NULL);
+	if (res)
+		dev_err(smu->adev->dev, "SetGpoAllow %d failed!\n", enablement);
+
+	return res;
+}
+
 int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 				 bool enablement)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index eba3d7754532..c2fcff384bab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -144,6 +144,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetNumBadMemoryPagesRetired,	PPSMC_MSG_SetNumBadMemoryPagesRetired,   0),
 	MSG_MAP(SetBadMemoryPagesRetiredFlagsPerChannel,
 			    PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,   0),
+	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -1948,6 +1949,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.set_df_cstate = smu_v13_0_0_set_df_cstate,
 	.send_hbm_bad_pages_num = smu_v13_0_0_smu_send_bad_mem_page_num,
 	.send_hbm_bad_channel_flag = smu_v13_0_0_send_bad_mem_channel_flag,
+	.gpo_control = smu_v13_0_gpo_control,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

