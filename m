Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7831C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 16:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A98710E44F;
	Wed, 17 May 2023 16:14:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A4310E44F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 16:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm8KdvlKgsti8s+crYladtyG0v9SIhvpt4W6jqqhK+fZLIhSPLSHAVBOf2SlkUirfZ+IM3Ppek5tRcsq9hs+BVFdkZoK7l/zideSn1BTdPxNE1t+5FCgwOgnQH92v5LPjxMOU6uq8qcnJTWT7ipzB6q1+Efwy2mAJ4vX2LlZD0KOQV8kWlWAvLZf8Xe9pSkMxBwm97/iVu3kUkceuURYixk7/Vow8Frf5t3OP2kC1C/vCNWYu+SnKIHGPTQdgB91/FsywAuTyGf4EUeeLImsm3wePDFXv2G6MpyT9MrUayMvUe04kjBYWAyGvccydg1Wmw8bYQt8tAWXjQO7aChKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkQ9UU+eHO49EfxOWK52dOJwMHSai04u4J14mw+JqZI=;
 b=Igj2RSIZZ1e+jBIdDsot4hIlMD8FqJSgfXRzjtJXWqWAl1ZLLu9HdWE22ZVNlRykrzuDN+/SC48SzPS4N8Bz8yYRJL2+rvTD1YRGSH6cpSj+MwHFMD70QMZlGNHWGv6uJJOYb3XRbrs6yCXKwD2ldRLr0qQxR3rh7k26Dim2DGPuCQDmCIUgK1W/7VVVobZI481rVDAFNxNDh0IVRqATgy7XPo/vxOQFShf+HJ/Zrdm6vcJxnBYqbOQ/cBj/YVk4uv5IhxHZF9IR6VsBk9P/t6uBs0KfHOwXizCB5CK2HlCMxDtUdQZ4jvblUjj07uYhrcKYbAaEG8ITfVsvd3kqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkQ9UU+eHO49EfxOWK52dOJwMHSai04u4J14mw+JqZI=;
 b=uFGzlhJSnqpIcsAu7yIMeoHVD81TzqlnServeVHkx+XL00/bXNk+9/eZFj45B8nrexclD6/7BzBmxX1T9+XpBvPPb3SEn2//CjSwc6yYMNdeQFkQOjcbO3oMgEeo2K/E8GkzeUemL82UF66umcYRc2YNAhBlGEx+5E3/GkPGY5Q=
Received: from MW4PR03CA0051.namprd03.prod.outlook.com (2603:10b6:303:8e::26)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 16:14:26 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::dc) by MW4PR03CA0051.outlook.office365.com
 (2603:10b6:303:8e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 16:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 16:14:24 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:13:45 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/4] drm/amd: Validate gfxoff state for smu13
Date: Wed, 17 May 2023 01:08:20 -0500
Message-ID: <20230517060820.5499-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517060820.5499-1-mario.limonciello@amd.com>
References: <20230517060820.5499-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT102:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: eda230f0-71c6-4762-5012-08db56f1c84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wx6iqhRWdAjQ3svFYUDY4j05xPY04xObMTQ7PnlaC4Jqk6EHna5G+SnYxaW4gVC+IbRUJgM+WdchwtX9GHMJqffm8OGfJwLttsee7vDfmbg0JfUT23QFSJDGd1MATAaVgOtHPNt8Q3tuo1SzFGA/YnAzq5kRjzCHuy6gK5hOmOJy9DFV5KPHnHKR7qjpdq9n3wNTB4b0mlcBqWWYyxqt7mqMlcj/d7sPRRtb3bJdh7p9Qv2EPebJpMD8k1xGvGmZR5630GGJNNS/X1iSXAOPLf6vgw2JpORs/zldkH+YO2ghfFTKS8w1ewY2T6xqOS4p0RzFy5YxhcrZT3vaPdWgixEXTDFC1ugXqaYdjfN7Sad7PceI3YbAExqfYWHNXvHAtDUjebYen+ov+l3uoKGfhILdXzEmzjrDE2REDfFm+VHBU+GFy2mj0xA0YbESbl9HG1G0Dhd+PWvWti1Qm8WtbL6jfygbjzUvWmXoHKHxfHF4MDmcu1tkr327jxSa4eQebk0yUkwEFUefLhTJA3NnB3xUi5XzLsDoDYHIuDaV8FbH02QfEfjPM/e/ECj09h7hIAJBVYUjP6Sc4YY0KT1n0B+iPo2Jo5+rtG3FMZKjeuryFou1JyoaziH4AAIRDh5ToXWT/SGz8cltONTaOeYiGugpUuqaKgRiOQqMDiQ0+1eU2Q7p70LAldYAtd3lliQMwAm7uR+lQUgbA3HN1igzU/+l5Z3Db5EtMfDcCIt2FSH+1VeIolOHYlcSBROw85iyQ2gsTwR6FtwHQXkGc/njyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(70586007)(70206006)(2906002)(15650500001)(44832011)(41300700001)(316002)(86362001)(4326008)(6916009)(54906003)(8936002)(8676002)(6666004)(82740400003)(356005)(82310400005)(81166007)(7696005)(40460700003)(36756003)(478600001)(186003)(426003)(336012)(1076003)(26005)(16526019)(40480700001)(2616005)(83380400001)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:14:24.9136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda230f0-71c6-4762-5012-08db56f1c84b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071
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
Cc: anson.tsao@amd.com, Tim Huang <tim.huang@amd.com>, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, richard.gong@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFXOFF may be flushed at suspend entry and it may be important
to ensure it reaches desired target state. In SMU13 designs that
use IMU, validate the state is reached.

This mirrors the implementation done for SMU10 and SMU12.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        | 10 +++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 42 ++++++++++++++-----
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
index 484e936812e4..cd9c4b77e026 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
@@ -36,6 +36,7 @@ struct amdgpu_imu_funcs {
     int (*start_imu)(struct amdgpu_device *adev);
     void (*program_rlc_ram)(struct amdgpu_device *adev);
     int (*wait_for_reset_status)(struct amdgpu_device *adev);
+    int (*get_gfxoff_status)(struct amdgpu_device *adev);
 };
 
 struct imu_rlc_ram_golden {
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 4ab90c7852c3..719c4e5c2243 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -375,6 +375,15 @@ static void imu_v11_0_program_rlc_ram(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, reg_data);
 }
 
+#define GFX_OFF_STATUS_SHIFT		1
+#define GFX_OFF_STATUS_MASK		0x6
+int imu_v11_0_get_gfxoff_status(struct amdgpu_device *adev)
+{
+	uint32_t reg = RREG32_SOC15(GC, 0, regGFX_IMU_MSG_FLAGS);
+
+	return (reg & GFX_OFF_STATUS_MASK) >> GFX_OFF_STATUS_SHIFT;
+}
+
 const struct amdgpu_imu_funcs gfx_v11_0_imu_funcs = {
 	.init_microcode = imu_v11_0_init_microcode,
 	.load_microcode = imu_v11_0_load_microcode,
@@ -382,4 +391,5 @@ const struct amdgpu_imu_funcs gfx_v11_0_imu_funcs = {
 	.start_imu = imu_v11_0_start,
 	.program_rlc_ram = imu_v11_0_program_rlc_ram,
 	.wait_for_reset_status = imu_v11_0_wait_for_reset_status,
+	.get_gfxoff_status = imu_v11_0_get_gfxoff_status,
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index b24c8549d0b1..31797d629379 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -789,10 +789,16 @@ int smu_v13_0_set_allowed_mask(struct smu_context *smu)
 
 int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 {
-	int ret = 0;
+	int ret = 0, timeout = 500;
 	struct amdgpu_device *adev = smu->adev;
+	int target;
+
+	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+		return 0;
 
 	switch (adev->ip_versions[MP1_HWIP][0]) {
+	default:
+		return 0;
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
@@ -802,18 +808,34 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 11):
-		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
-			return 0;
-		if (enable)
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
-		else
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
-		break;
-	default:
 		break;
 	}
 
-	return ret;
+	if (enable) {
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+		target = 0;
+	} else {
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+		target = 3;
+	}
+
+	if (ret)
+		return ret;
+
+	/* confirm gfx is back to intended state, timeout is 0.5 second */
+	if (!adev->gfx.imu.funcs || !adev->gfx.imu.funcs->get_gfxoff_status)
+		return 0;
+
+	while ((adev->gfx.imu.funcs->get_gfxoff_status(adev) != target)) {
+		msleep(1);
+		timeout--;
+		if (timeout == 0) {
+			DRM_ERROR("%s gfxoff timeout and failed!\n", enable ? "enable" : "disable");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
 }
 
 int smu_v13_0_system_features_control(struct smu_context *smu,
-- 
2.34.1

