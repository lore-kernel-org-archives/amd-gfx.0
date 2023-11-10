Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195ADC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 07:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FAC410E945;
	Fri, 10 Nov 2023 07:56:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432F210E943
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 07:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/j54h2EJnE9D8HMu6roEwjMsy09TMlHeB07lM6625irPD+TIFlJZA+bvrqJNuf9e8YtfSjKqm20+zn4F01EAuJMPQqzeP37HUCtnNyzX4eqUGoM4lrSXXqM7/EEfejUzfHiu+tNVzTqNIbXo48vytQ0L6N9cZ3KKD0LE9gHrIH/4Qu9YdJOB031bE81B9dEmIxrSJL2uidRDu0xcn2oSeRiHkXS4Jg0qtfvx88Guld4b+v+r3hVtXwUOOfgQIj6b4h3QUIFQD+3m2zHuWEjCknqE/U8SHEhhiqy5DfDVBRSa2x8yTblpbI3JwE3tYYGYS17TUg2ZbxXLSs0z2nqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjxvNeFqjkNGMNKNC4o1PdUpo2/l3zoOoSLvv51AA7k=;
 b=K6I/Yq3vriMOl7ZI3vIMcLy3UY/+qKxIVer5ZjFaa7i94zh3PcWqyVGQCwWYup2pvrB76UcAkudH9d14yDhqmZXJtunRtSOY/4RBFJws94XchohcSFLGQotOS+t6MVQvyUuh4QPMMbhQY4zf1OGjscdLdmsYyNKQLWzZBExpr1tIwjcodxuTuumiA/3e53pXLaeNULoaSyyghxR+3Fy1fUOG3bRb6k2QgbrO9V0iFPBjTyMJzKXt4kNySkh6UMOhj2mj7S+oJwkaI2hStXQOO28Ow1ceCD3xl6h4EtrlOp6pHYY7ns/wqqxEBe6uRwKAQ/uc8P2avf0f+RBmCqGUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjxvNeFqjkNGMNKNC4o1PdUpo2/l3zoOoSLvv51AA7k=;
 b=tdbQdl4OaMZ2UzSmKEquBnH82fOWWjWztbMNNqpUi91Et/aFHbHsAL1TrEYfDEsZhBPTRhIsab++zgGt/7lzxs+LtbjkyBEZ1ilv2gr2/2hYUz0homNhcvmj76AiWjkLyxzch9FZcX+TFGhlO/bEWzk8sRWK4IzlJGEdOzfBL/c=
Received: from DS7PR05CA0015.namprd05.prod.outlook.com (2603:10b6:5:3b9::20)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 07:56:05 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8f) by DS7PR05CA0015.outlook.office365.com
 (2603:10b6:5:3b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 07:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 07:56:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 01:56:02 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Move mca debug mode decision to ras
Date: Fri, 10 Nov 2023 13:25:47 +0530
Message-ID: <20231110075547.565860-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d2bfc8-f906-4b4e-800d-08dbe1c27d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZrRaxvap3o2rA3W+MNWhh6JusxaakGLnORkrY/BjQ0dNB2kYhnTzz4ehZkBLxNEU8ty1EE+4u4IdWS+XZiamcllkZl9oDtbE3uqCBD/Lwy1VKpODTo/KeWbAGVfKjlBzs40pZO+sY2KyOm+yyhRRMQd4eLhxf7kYG9eedi0GhO+GNOuMIuf0px+iJ0cDFDR4+luqHBkpR6zg2o2oDxblD7+5bGbIm37aaUYCvIz53viLwOS1ufn9yEZn1Z3b+Y5uXGeS/ri4ub23F+QhIwJhwcczZghUddILG4NQjKixmwxbnXNyih6MhXdtQm1PeRGKzhcdkPN3QSJR5ZXVWbRxJCOvT2BiUXeL3jhXz32kZIQst5dmPT8pHMwpgyJXIVez3PufnvCcq+bpWFCTcPtF+7DevoiqCgdwcOogM03yvCBaPkBOVW1O8BeMCMIZ3QtAbaSJaulMkPyOVnz4uWE+fdTiIXAoKaePKo5PvKW5Pq3cv+SSubzXVsCb331cqaFFKIxpvuiKupHCOyAtQcc/eXM/EPxOf1zm6tC3wq8o6b/nakmN9rY9NyzQKbQo/fxA4nQC2yL0JUJep8ikK3uFm4oiDYcsuvtoA2jycPVktkXCwsdMKQ4euYBZqbvTk1QaSIU91U8A1SSidZQhLHDwkC1GBzptH9hZzbEKBbaerh8p1inJJZznOXuRzaYc44F6bxLuolPGeMxCQPaHmiJqdI3yaxzRwfWggpONU2AE4NSV/ngZppTA1NNEcweNL3BC7Ec33LkOFFlQGgZ73VSotQlfc4/QVxSOW8fnGsw26gL5K2t5HflK58RUXwe6kR2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(7696005)(44832011)(86362001)(478600001)(8676002)(8936002)(4326008)(6666004)(1076003)(5660300002)(36756003)(54906003)(6916009)(316002)(70206006)(70586007)(2616005)(40480700001)(426003)(2906002)(26005)(336012)(40460700003)(83380400001)(47076005)(16526019)(36860700001)(41300700001)(356005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 07:56:04.6967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d2bfc8-f906-4b4e-800d-08dbe1c27d74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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

By default mca debug mode is set to false.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v3: Default mca debug mode is set to false

v2: Set mca debug mode early before ras block late init as ras query is
initiated during late init of ras blocks (KevinYang)

 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 12 ------------
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index cf33eb219e25..54f2f346579e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -377,7 +377,7 @@ static int amdgpu_mca_smu_debug_mode_set(void *data, u64 val)
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
 	int ret;
 
-	ret = amdgpu_mca_smu_set_debug_mode(adev, val ? true : false);
+	ret = amdgpu_ras_set_mca_debug_mode(adev, val ? true : false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 84e5987b14e0..6747fbe4feab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3132,6 +3132,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	amdgpu_ras_set_mca_debug_mode(adev, false);
+
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		if (!node->ras_obj) {
 			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
@@ -3405,12 +3407,18 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
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
index 19161916ac46..6a941eb8fb8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -773,7 +773,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
-void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
+int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
 bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 				     unsigned int *mode);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6cbfb25a05de..f09f56efbdc3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1516,7 +1516,6 @@ static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 	if (smu->smc_fw_version < 0x554800)
 		return 0;
 
-	amdgpu_ras_set_mca_debug_mode(smu->adev, enable);
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
 					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
 					       NULL);
@@ -2338,16 +2337,6 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_6_post_init(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	if (!amdgpu_sriov_vf(adev) && adev->ras_enabled)
-		return smu_v13_0_6_mca_set_debug_mode(smu, false);
-
-	return 0;
-}
-
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -2904,7 +2893,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_init = smu_v13_0_6_i2c_control_init,
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
-	.post_init = smu_v13_0_6_post_init,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

