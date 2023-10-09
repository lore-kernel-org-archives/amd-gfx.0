Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F07CD612E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5814A10E2AB;
	Mon,  9 Oct 2023 18:34:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF3BA10E2A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHOgGzZd6UZjFeVQnhYxHpEArkvgn0s7C5xjQrAFknC8obsdA8+EIijqV4Y9nBqWf10Z21ASGaESVasRuN51L1365NJbtN8+MWhIStF/UJ9KCWL8dQa0wOQzMeHdW//gkS2yRo1eFIlYhMVDnt75VqbBQYJxUW7gWMn0szHezE+B6AQp4l2V2wt6ziGMv+/uorxYAYQGXSWhGx8H7v5lKhX98t24ZoqO/Q7KFrPm8y8KxsTo/Jg9MmBtCWkhxbiQ01U2RZWdkQkKCtYvcUR8cmh0sTc2CveCoowfW2pPJ5ySj1vGgqqvJDcc5KRyj8QmV7mJXFQYZHqEdbl/LtlyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMlGsmyixqi/QrijfjyCp9DZjz7IeddeKbUOfvqzuyQ=;
 b=ERaV3HOE2DB9v8G5FIdZ7Zpnvy0KeNIXtZGb1pPeU3tQP78YDdfjKi1OfeK18dodnq2WqvGz2VAjy5heRy+tHTFnpRh7Lxxiam8BhIkYvMuw77IDBQq3VNRGMdO8S/mRDkWv3R/Z4tiqltkx2XmZxKkMadpIJbiatGkDPWcM6zpWZym/Fsnl7Q3QwAJEQjVQQ9+4DPLcDgNwHLmTD8jC/dVDjqjuiw7y9fDsm0QN7fKLdnhcE167StKbvjEV0n3ByDlssb6s+epidF1cwaywtq9juPHVE01F2yVB4jX/IFDtj1h3Xbc28JYcX0/Knd13ydROrPxbyhoFlsq/ccBKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMlGsmyixqi/QrijfjyCp9DZjz7IeddeKbUOfvqzuyQ=;
 b=uuZtFh4I5Ky4rf0r9TWpBq0snoqhCMr6/dpVlKhReh/wapbzqFaP+ivXe8s0tkykrSUwku/FCIO4zFnqZmuCiaMQiupU8YrXByop0jfyeoTNtMT2ma6fPi7WdcJcHb+GaceFOQA+tMai2CG0kXc4CVHM9d5DqM4SJ8AftjB3dkU=
Received: from CY8PR11CA0046.namprd11.prod.outlook.com (2603:10b6:930:4a::6)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 18:34:19 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::bf) by CY8PR11CA0046.outlook.office365.com
 (2603:10b6:930:4a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 18:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 18:34:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:34:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add support to powerup VPE by SMU
Date: Mon, 9 Oct 2023 14:34:00 -0400
Message-ID: <20231009183402.518574-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9f28f2-e580-4a0d-be3a-08dbc8f6595b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6d3wGla094tTQOmc6VovbwAdcADbpXg3+ran+DP9HKzYrYB5vWQQ2JOibFPAgQ/1Ausb7cSsr9Bm2df3QzMB3rGVV/BXIKwKlqQqhtt2SQO3lO2dy/ky+Jc9irPmR77bqq6IXDwm5LSj4XIjgByd14YTHN4cXByIbhZhoipRKEIy3KTHgbShHVvt7MXdmZdmwVkdM7cVkWLCoiO3naNYib7fn14GgilNI/N3HOftDTa6/H1aXkR5qOAmgkU08bB2yGFhfRRyQRePITbJeimiEKuVI6kuY616Hr1uBeVfjH6yUtErIEth6+KIK4BQF3sS2azj+PzCPq1P4FdI7LgGDyH9tk2DkKNPPPJUaPB4tMvriDwTR9RBtAV/3LrugPMPxC4vNJ9C3YYqjEenbmVvtzySJMG/uV8vnc9fTbzSJ5XJMSTEb39KlfFmOGaajPw95fIzswvXHNpi5KzdfhRnBj8X/iihdkbz8T3bWUx9z5BS3srqFqrBOcV83a6p1oKM5+z1/feSGpIh3KzB7liU2fsLBgrjls7foYl94kgl2BJbKMdKMorn80WmE8x+gvA/CXwXP5EUVwDtJFMHxuB4RPNZTcRGUbKqntoHF0kySIWNaZvvw+WpV/oF0WObz2SqSuq03+BBW6Xk6NXR7gFpJQDPAVg49E5ScNyX7AoFYIROn4T6fqrQ+AcYOfOSkBIYh04vOqxXHsLC4/kgTZFj/MpIM/W16frphCGTqdX0zXcnC5d+jk/E2IFNk/zXYDfUEq5wJSuIaChTpNTdv4Yxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(336012)(2616005)(26005)(1076003)(16526019)(426003)(2906002)(8936002)(36860700001)(8676002)(6666004)(5660300002)(47076005)(83380400001)(4326008)(478600001)(41300700001)(70206006)(70586007)(54906003)(316002)(6916009)(36756003)(40480700001)(82740400003)(86362001)(356005)(81166007)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:34:18.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9f28f2-e580-4a0d-be3a-08dbc8f6595b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Powerup VPE by SMU.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 1b17a71ed45e..acf3527fff2d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -93,6 +93,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_JPEG:
 	case AMD_IP_BLOCK_TYPE_GMC:
 	case AMD_IP_BLOCK_TYPE_ACP:
+	case AMD_IP_BLOCK_TYPE_VPE:
 		if (pp_funcs && pp_funcs->set_powergating_by_smu)
 			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0b4f9f2ca529..df513347cb73 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -279,6 +279,26 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_dpm_set_vpe_enable(struct smu_context *smu,
+				   bool enable)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int ret = 0;
+
+	if (!smu->ppt_funcs->dpm_set_vpe_enable)
+		return 0;
+
+	if (atomic_read(&power_gate->vpe_gated) ^ enable)
+		return 0;
+
+	ret = smu->ppt_funcs->dpm_set_vpe_enable(smu, enable);
+	if (!ret)
+		atomic_set(&power_gate->vpe_gated, !enable);
+
+	return ret;
+}
+
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
@@ -337,6 +357,12 @@ static int smu_dpm_set_power_gate(void *handle,
 			dev_err(smu->adev->dev, "Failed to power %s JPEG!\n",
 				gate ? "gate" : "ungate");
 		break;
+	case AMD_IP_BLOCK_TYPE_VPE:
+		ret = smu_dpm_set_vpe_enable(smu, !gate);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s VPE!\n",
+				gate ? "gate" : "ungate");
+		break;
 	default:
 		dev_err(smu->adev->dev, "Unsupported block type!\n");
 		return -EINVAL;
@@ -1169,6 +1195,7 @@ static int smu_sw_init(void *handle)
 
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
+	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 
 	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
@@ -1521,6 +1548,7 @@ static int smu_hw_init(void *handle)
 			return ret;
 		smu_dpm_set_vcn_enable(smu, true);
 		smu_dpm_set_jpeg_enable(smu, true);
+		smu_dpm_set_vpe_enable(smu, true);
 		smu_set_gfx_cgpg(smu, true);
 	}
 
@@ -1697,6 +1725,7 @@ static int smu_hw_fini(void *handle)
 
 	smu_dpm_set_vcn_enable(smu, false);
 	smu_dpm_set_jpeg_enable(smu, false);
+	smu_dpm_set_vpe_enable(smu, false);
 
 	adev->vcn.cur_state = AMD_PG_STATE_GATE;
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 72d632be0ee6..c8cd4e3a3d3b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -374,6 +374,7 @@ struct smu_power_gate {
 	bool vce_gated;
 	atomic_t vcn_gated;
 	atomic_t jpeg_gated;
+	atomic_t vpe_gated;
 };
 
 struct smu_power_context {
-- 
2.41.0

