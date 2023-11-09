Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ED6C4167D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 08:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C35010E1DF;
	Thu,  9 Nov 2023 08:05:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32A610E1E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 08:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsYGAn/sO/w3uVzSPHLahKAmSySBPZPXWOwYqqe44EMBsfiM8lqTtX6EqeARhIZjmXLV9rm5NqAMnE6wtMb07rh5TrHeF8/T07BUDLzHnm0+pPfaqUJOHzhSyIg13iFC7J5LDByjDOJxNcriNEOTWC7dP72ujMJAIjA5ixYEomRPv/ABGo0SxHemy1jLWowE08j1eyY+o1Zzjxn4ZQZ2JcCTtbJdGObSJeUI0Rn37zFJADJU+tE990OsP8ufRc8BTEFoFkbgCOARZ1AK/yiKXHKTQtT5D/iNvXeJKezejwOxmwIFwQ2hpANUdW9GOMzYPRMZsh2fheWfpfUQwEsU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXnQETDta/aePRE6bWm7I8Yst9NSYe0LUSUj8VTIK+c=;
 b=Wo7EUlMLsHuNM1dVGmmggo8s1yqXHaAPW9rR55QbZumEPImhl6A79C/wpzV3D161WXRq4op4DQLRx9TF6zz/hnvVWE+2aqvT0n4LEtHbf3EVvgF62VwBrC+MY5dqn6cbhfvLzF8mQe3GE35/rEpMdO0Q8QP8mioEcVJGkzS1weOyN+pnceaeALmX2e/uVdImQAkw5oExu9R4DQj+sT1qJ72N/b7RcdZdL94y9t/FmfC4vBybIL4AxAYefbM7ac837PKO/YzaY8a6Jmp6UCjSHdyq2gDzi7eRKHQsQ09mMefVusFxVDgx2ufrRNJ37GP6cK/UvbRNyjmRsrbOnrnR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXnQETDta/aePRE6bWm7I8Yst9NSYe0LUSUj8VTIK+c=;
 b=ObowVSTapNBytaxswCHFluwrG1XPY6qFAcokDdd6f6fzZ3r/3UjT90Faib0xjQ3UX6Z3/cFjoMq9IM9W7PqdjOV1kIBxQHI3zRz2tdC7KBejuXrTWbpFZrAU65ZM39Ny5Hq+bR4/YrMReMs7cqkHt9fS4/yjH32e4r1Sp+1w6xc=
Received: from MN2PR19CA0042.namprd19.prod.outlook.com (2603:10b6:208:19b::19)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 08:05:12 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::7d) by MN2PR19CA0042.outlook.office365.com
 (2603:10b6:208:19b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 08:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 08:05:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 02:05:09 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Move mca debug mode decision to ras
Date: Thu, 9 Nov 2023 13:34:53 +0530
Message-ID: <20231109080453.553639-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|BN9PR12MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 6adc16ce-71b8-4b78-2e4f-08dbe0fa996d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITMc5jFnThGYJNdpDPq5lHtF2vWSAY1etbBiSg7X+0cni8DGWIKIZspwmVWkK7wVzPVTCfsI+A7xzGJ2q7tebieTXxNhJWKegye9qKEwNRydZX6RQpYTEBWf6Hle5LLhTB66Ba1wUyQMJyToxOS8ZI3VSizFm388yoHIO/+zZuFG2WU/cOZw38lkXqOWI04VbVD+TgtUoGZkHRRbUINjiY1iiC8NCxf9Qo0f3K4ny85T2tUcOpEFMlXlxjTMuDjpncxBoM4PKxT1p43ORhJLHh6AweE97n8wemNalPR3vG3IaVFeh3e2lFm7LKZceoZ9gbuC5SyV9gHOnVvPdyOmSSDOjP73TIIZkq/KCu3Es/E99FtDZ4c+1rmw/TwxVpwaEg7no0wfRC7w0CZI8znXUlbDTVuWV78FMW99ouE9yNFuZtRFGGzsFUGQLcLlOKZ+b7KNtW6DAgf9L/9rnkBSVtZigFw8AIaIArnUClRXgYji9pXToNo0+XxmwtWAK5ilepIV6L36EGhHzFsZLGC4QvYZTk+zbiP4Dqv+77A/dPX55ZwXAUOOrTZQhfoSF12cDN6DLGQIKKO6yNZqRRRDwUPHMckI7gAXEcaJ9oG5jvxxbDMDGP3ZDVcu3WD+Gfiex+isivWwKi8YRgCQs1nJA3XpeYZLyG/JhkoH0dELDFEIPv+m1gmHauD1qatxtVjN+8gCVvnH7loIs/5NwEumCwK57KaGrRdheqRXBGpYrXYKWt5rK5WRj7dF0vJ7QsX72CHlMq/5jP3YrEadHon2LDQJtlBMK2g8fpoaeATKb6zFM02mQANgBMsihjIUAlRW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(44832011)(316002)(4326008)(2616005)(8936002)(8676002)(7696005)(6666004)(5660300002)(478600001)(2906002)(26005)(1076003)(426003)(16526019)(336012)(41300700001)(83380400001)(36860700001)(6916009)(70206006)(70586007)(47076005)(54906003)(40480700001)(356005)(81166007)(86362001)(82740400003)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:05:12.3103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adc16ce-71b8-4b78-2e4f-08dbe0fa996d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
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
Cc: Alexander.Deucher@amd.com, kevinyang.wang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Refactor code such that ras block decides the default mca debug mode,
and not swsmu block.

By default mca debug mode is set to true for now.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Set mca debug mode early before ras block late init as ras query is
initiated during late init of ras blocks (KevinYang)

 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 12 ------------
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 5a828c175e3a..cb51a46e8535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -218,7 +218,7 @@ static int amdgpu_mca_smu_debug_mode_set(void *data, u64 val)
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
 	int ret;
 
-	ret = amdgpu_mca_smu_set_debug_mode(adev, val ? true : false);
+	ret = amdgpu_ras_set_mca_debug_mode(adev, val ? true : false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b7fe5951b166..bb4f1e60c099 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3102,6 +3102,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	amdgpu_ras_set_mca_debug_mode(adev, true);
+
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		if (!node->ras_obj) {
 			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
@@ -3375,12 +3377,18 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
+int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	int ret;
 
-	if (con)
-		con->is_mca_debug_mode = enable;
+	if (con) {
+		ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
+		if (!ret)
+			con->is_mca_debug_mode = enable;
+	}
+
+	return ret;
 }
 
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 665414c22ca9..e1e0fc66ea49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -767,7 +767,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
-void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
+int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
 
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cecd210397d6..404db2b0fb71 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1524,7 +1524,6 @@ static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 	if (smu->smc_fw_version < 0x554800)
 		return 0;
 
-	amdgpu_ras_set_mca_debug_mode(smu->adev, enable);
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
 					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
 					       NULL);
@@ -2346,16 +2345,6 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_6_post_init(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	if (!amdgpu_sriov_vf(adev) && adev->ras_enabled)
-		return smu_v13_0_6_mca_set_debug_mode(smu, true);
-
-	return 0;
-}
-
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -2945,7 +2934,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_init = smu_v13_0_6_i2c_control_init,
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
-	.post_init = smu_v13_0_6_post_init,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

