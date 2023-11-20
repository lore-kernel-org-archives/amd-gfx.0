Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A4FC072A2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 02:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B1F10E211;
	Mon, 20 Nov 2023 02:49:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB6B10E211
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 02:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsDRNoJSu3g2GOQmQ1zBNyGqS365K78fw3wncqP4OLTPTiUt61JEcsgU4Xt2z1OdORzbVKcPrdtkCnlfoCv3PDPTPQxv33k8L1Iwdb3lR0JvTql+tGXV4Pr+37sox2Kz0MwwSy7XyanpSYiFC2FE4R7CRQVFt5bMGJKZvwXXrpxAXhx69SLtZZr2rIbVAk6/dXcWPHV8laOyHR5RkOrwrSpIdVvVCxJ0B5FkVH+C6Zj88xmEvlNCplXlvrRugJT/mQHnlL/WxVMUlY1m0hAEdCObW6AJYXo0LIuolzUrb+fIEQNZBvxZEZCpwzyBPIdDoIkzoxDbWyse7SZwyHO+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff0Vi01CMf2DMiJn2kt7KbXP8fMxwvWZnsbPhYeL/L8=;
 b=VTDqt9L91aY6giktSsSiWHLUscaCh88Hlp9wkWhnjSfKdBVBz3eJIQ0oMzbG2H25/K6vZ9RHLKvQ3NhvYNVzpvJCz6ZJwKS2vn/M/0YY4437Jmt7TVa+y1eIhMGhxcZHyrZ/TUbU4ar2QzPxXbJD6aqhcQVRtFpMULu0kwTu+YcRtkdznyETp+fGUx86Q08Ju1OzuSEwm7/rUCZd1zgGkeDT7OKZmGyVUSHD4SZPAC0FsKjlixzNw7lcQop4f8jntCHQKr7fTVqfEW0BV9iRcJGYwZlM3tUTiCynLIy/GNOefXEMFMAsOzAqcNjbD1c2GY/XyknAVAIQ9KFf4Rejkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff0Vi01CMf2DMiJn2kt7KbXP8fMxwvWZnsbPhYeL/L8=;
 b=3/cSjPffXFsfKZtjmn4hTOr9524kBoF62187TILQ0H29vFEY0mcpyomiHWodtl9V45Lhh5GfMCiTyZD+wQMygQDGquTII1Gjp3Ssbe97JoygXALs51F9ughayijFbKHF3kvWg6NurFj/qH2JOq5Gb2+9fquh+8MZn04jogBr9sQ=
Received: from SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::9) by
 MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 02:49:35 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::58) by SA9P223CA0004.outlook.office365.com
 (2603:10b6:806:26::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 02:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 02:49:34 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 20:49:11 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Stanley Yang <Stanley.Yang@amd.com>,
 Candice Li <Candice.Li@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Retire query/reseet_ras_error_status from
 gfx_v9_4_3
Date: Mon, 20 Nov 2023 10:48:53 +0800
Message-ID: <20231120024855.27697-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c8617e-7487-47f6-206f-08dbe9735429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2fPVEbDFTFvRx2+AaHLZsfGbCcbYsCHV4CdD3KaryQGA3ApWBXL5tVqjoIaY4MOb8TfdDkopkcD2kwv1vaAGgGp/FMp8T6uUtnvLjcI0YJVwsJsHblBZg3ayEXn5PALzeP7vPkalLHp/9HnJiQ4d/7yuCNXiv01W3QlZAd/T/9JLPQPajdk9CBzOgN4Z7bMUnkXm83oS6aq83JOJ9+11J6NEHQuAMiXFVs5FOzcmAa1N68DTPe55+6pRuC5AdoPPBWJjQN8vFTo43jTi+Q/UV8i6zmh9MWhsJ0BOi1zj1c+pJArg/GwZDMoTNKxMVz+gzJIxdfBynsCOow9ESHVRqDBVM+cf2p9LCJ1/aWwl2P0LjkmPgYQnYKVeaRPwCEAkEpVYwGmrvCLA/dfpkw0z2UFIgAuNUEco7O8AZznEn7Crm33h2C1ppfDSsTEQhzJ8vAUWJ2TTAM32Y+9tIbSR7ug+emGmm1EBrf0rScusKk/yvnTEeyb24XxEbzseDr/7W9obd/DIIINXez1NxCiAXkve0TtlPvHtqEXQTQu3RRV3eAcjEO8ZaxVGRf7UgA1buhOPjmI0cDMHyxrmWFCaq3dpvMHIiyCJWhX6H2mOKqRplr+jIEJStlQOIe3cPMHvu7GJAQaeymqkUxNSI/Mnhk21sZW61Trsn/LTEXd3Xf0iXaOCH88XomLowk6weUj4tB9icFgwWx5v4CHzNdPbc2XhJ/rJz7zGdGiX2Xph4nhCo4ufsn1f0KyJ0iIkNBcw/jKL2ACcWWFs8ASKxO/hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(4326008)(8676002)(8936002)(86362001)(5660300002)(41300700001)(36756003)(16526019)(82740400003)(336012)(426003)(26005)(81166007)(356005)(83380400001)(7696005)(2616005)(1076003)(47076005)(36860700001)(316002)(6636002)(70206006)(40480700001)(70586007)(110136005)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 02:49:34.4924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c8617e-7487-47f6-206f-08dbe9735429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not needed anymore.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 114 ------------------------
 1 file changed, 114 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 40d06d32bb74..5df727be88c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3882,32 +3882,6 @@ static void gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev,
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-static void gfx_v9_4_3_inst_query_utc_err_status(struct amdgpu_device *adev,
-					int xcc_id)
-{
-	uint32_t data;
-
-	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regUTCL2_MEM_ECC_STATUS);
-	if (data) {
-		dev_warn(adev->dev, "GFX UTCL2 Mem Ecc Status: 0x%x!\n", data);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regUTCL2_MEM_ECC_STATUS, 0x3);
-	}
-
-	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_MEM_ECC_STATUS);
-	if (data) {
-		dev_warn(adev->dev, "GFX VML2 Mem Ecc Status: 0x%x!\n", data);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_MEM_ECC_STATUS, 0x3);
-	}
-
-	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
-				regVML2_WALKER_MEM_ECC_STATUS);
-	if (data) {
-		dev_warn(adev->dev, "GFX VML2 Walker Mem Ecc Status: 0x%x!\n", data);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_WALKER_MEM_ECC_STATUS,
-				0x3);
-	}
-}
-
 static void gfx_v9_4_3_log_cu_timeout_status(struct amdgpu_device *adev,
 					uint32_t status, int xcc_id)
 {
@@ -3950,82 +3924,6 @@ static void gfx_v9_4_3_log_cu_timeout_status(struct amdgpu_device *adev,
 	}
 }
 
-static void gfx_v9_4_3_inst_query_sq_timeout_status(struct amdgpu_device *adev,
-					int xcc_id)
-{
-	uint32_t se_idx, sh_idx, cu_idx;
-	uint32_t status;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	for (se_idx = 0; se_idx < adev->gfx.config.max_shader_engines; se_idx++) {
-		for (sh_idx = 0; sh_idx < adev->gfx.config.max_sh_per_se; sh_idx++) {
-			for (cu_idx = 0; cu_idx < adev->gfx.config.max_cu_per_sh; cu_idx++) {
-				gfx_v9_4_3_xcc_select_se_sh(adev, se_idx, sh_idx,
-							cu_idx, xcc_id);
-				status = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
-						      regSQ_TIMEOUT_STATUS);
-				if (status != 0) {
-					dev_info(
-						adev->dev,
-						"GFX Watchdog Timeout: SE %d, SH %d, CU %d\n",
-						se_idx, sh_idx, cu_idx);
-					gfx_v9_4_3_log_cu_timeout_status(
-						adev, status, xcc_id);
-				}
-				/* clear old status */
-				WREG32_SOC15(GC, GET_INST(GC, xcc_id),
-						regSQ_TIMEOUT_STATUS, 0);
-			}
-		}
-	}
-	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
-			xcc_id);
-	mutex_unlock(&adev->grbm_idx_mutex);
-}
-
-static void gfx_v9_4_3_inst_query_ras_err_status(struct amdgpu_device *adev,
-					void *ras_error_status, int xcc_id)
-{
-	gfx_v9_4_3_inst_query_utc_err_status(adev, xcc_id);
-	gfx_v9_4_3_inst_query_sq_timeout_status(adev, xcc_id);
-}
-
-static void gfx_v9_4_3_inst_reset_utc_err_status(struct amdgpu_device *adev,
-					int xcc_id)
-{
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regUTCL2_MEM_ECC_STATUS, 0x3);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_MEM_ECC_STATUS, 0x3);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_WALKER_MEM_ECC_STATUS, 0x3);
-}
-
-static void gfx_v9_4_3_inst_reset_sq_timeout_status(struct amdgpu_device *adev,
-					int xcc_id)
-{
-	uint32_t se_idx, sh_idx, cu_idx;
-
-	mutex_lock(&adev->grbm_idx_mutex);
-	for (se_idx = 0; se_idx < adev->gfx.config.max_shader_engines; se_idx++) {
-		for (sh_idx = 0; sh_idx < adev->gfx.config.max_sh_per_se; sh_idx++) {
-			for (cu_idx = 0; cu_idx < adev->gfx.config.max_cu_per_sh; cu_idx++) {
-				gfx_v9_4_3_xcc_select_se_sh(adev, se_idx, sh_idx,
-							cu_idx, xcc_id);
-				WREG32_SOC15(GC, GET_INST(GC, xcc_id),
-						regSQ_TIMEOUT_STATUS, 0);
-			}
-		}
-	}
-	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
-			xcc_id);
-	mutex_unlock(&adev->grbm_idx_mutex);
-}
-
-static void gfx_v9_4_3_inst_reset_ras_err_status(struct amdgpu_device *adev,
-					void *ras_error_status, int xcc_id)
-{
-	gfx_v9_4_3_inst_reset_utc_err_status(adev, xcc_id);
-	gfx_v9_4_3_inst_reset_sq_timeout_status(adev, xcc_id);
-}
-
 static void gfx_v9_4_3_inst_enable_watchdog_timer(struct amdgpu_device *adev,
 					void *ras_error_status, int xcc_id)
 {
@@ -4067,16 +3965,6 @@ static void gfx_v9_4_3_reset_ras_error_count(struct amdgpu_device *adev)
 	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_reset_ras_err_count);
 }
 
-static void gfx_v9_4_3_query_ras_error_status(struct amdgpu_device *adev)
-{
-	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_query_ras_err_status);
-}
-
-static void gfx_v9_4_3_reset_ras_error_status(struct amdgpu_device *adev)
-{
-	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_reset_ras_err_status);
-}
-
 static void gfx_v9_4_3_enable_watchdog_timer(struct amdgpu_device *adev)
 {
 	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_enable_watchdog_timer);
@@ -4394,8 +4282,6 @@ struct amdgpu_xcp_ip_funcs gfx_v9_4_3_xcp_funcs = {
 struct amdgpu_ras_block_hw_ops  gfx_v9_4_3_ras_ops = {
 	.query_ras_error_count = &gfx_v9_4_3_query_ras_error_count,
 	.reset_ras_error_count = &gfx_v9_4_3_reset_ras_error_count,
-	.query_ras_error_status = &gfx_v9_4_3_query_ras_error_status,
-	.reset_ras_error_status = &gfx_v9_4_3_reset_ras_error_status,
 };
 
 struct amdgpu_gfx_ras gfx_v9_4_3_ras = {
-- 
2.17.1

