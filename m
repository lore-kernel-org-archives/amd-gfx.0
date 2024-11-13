Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F11AD41C16
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 08:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA1210E68F;
	Wed, 13 Nov 2024 08:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2F3TSRbL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE1710E68F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 08:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYWXtunA/o3lTUpsXzhhbXEnb5Wl6nCU1YQoE37Vi0255A165FAZ5MxuytMZGmcFERD0yk1xESKgEjA9TKOF200nuYQ3ZOzrnxmYPGiuWypNly7VR+sfCer9UD+tgT9W+4nVG5+MXEJRv+DoFTbG2ZOKc/oIwvZkIQleW+F9VIAO30hFIphXFOBl9jEhveQDKRAn0cos/CLTs9x19xYxNWFhOpLGe8vwU/z8h9uF5TcrHLqIMS6UsGOwz0jWuG26waRHtJTH7qYzNHXt7EF1HqhShYsA6Kv5FV/y6fYIOm2y3gP+DPkT93diy+CALLQcj9PuBRaTtrypRk639XhTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqCYwF/6KYm1euvjuZALumsdIt1utce7D2gJX2HfGus=;
 b=hoFUY3QntaPHV0vcWLoSK64QWQMww+7ooEV7d0U2sc6QP8lVwCQG2G7TIhyybbZnj/V5CCIw25vjNTfcojTcoxIAyQh+Xx6F6Jzm3LM3hv0s5juOooonDiyNVH6ZcXAG9F3zSvtjOFWLerYLEUnUDBsHJno1kMxF78Ty69MevnF5FnOQSD4w7+WclLfXTFO0vWbjpDGW612YbWlXsQDQ8ahI60DVGvLPZFqABQHzNljhf5txZRXtglaDjQ4cMwcrsqPqFGxihQ45noCcnE1IO2IF66eSapGo6ABB53Iqs7Gd57/CFs3T4dtErNyD8ieuWyzZZp4MLDF8Neb9u3O2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqCYwF/6KYm1euvjuZALumsdIt1utce7D2gJX2HfGus=;
 b=2F3TSRbL5NZLtYv1gDbK31AUXnpX2+/FfiR+sNtWo3oj8pjN7tACDcuBmTmI862DKdACVpb6XDv2na9wSVPamZTu7aqm0dFoh9ikIo4MpmVfnW/WyVstH6UfAuP/EwtHkCHAK3VzSquJI9SMwrnnSm0cBTpz4RsQBNQKL4zkR/Q=
Received: from SJ0PR13CA0212.namprd13.prod.outlook.com (2603:10b6:a03:2c1::7)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 08:25:38 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::41) by SJ0PR13CA0212.outlook.office365.com
 (2603:10b6:a03:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Wed, 13 Nov 2024 08:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Wed, 13 Nov 2024 08:25:37 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 02:24:50 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: Get xgmi link status for XGMI_v_6_4_0
Date: Wed, 13 Nov 2024 16:24:33 +0800
Message-ID: <20241113082433.1308830-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241113082433.1308830-1-asad.kamal@amd.com>
References: <20241113082433.1308830-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac8d416-fad3-4365-b7f9-08dd03bcc0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TtGfjflZRWbQx56u4MwDRODdJBIBAe95JZuOXtAOmEngCu7C8tZJApqxh5JX?=
 =?us-ascii?Q?vKmy4kpmBLSCA3puIs/OtY+DSoOpv0a2sRTAAH8vMG/lvRHWjelyM6vUMXVf?=
 =?us-ascii?Q?XiYthdydbOHCiTu9G561cz44yV2+RqcJrn0HYa0RULzb3FtGER4BPOqAyhRa?=
 =?us-ascii?Q?Ji0iPg1gwirRiktKIg6vFlMuazN04bLc1T5I2QNcWeyQ/jDh+oBAzgIhFLN5?=
 =?us-ascii?Q?A9peTht8K3EbJwIxbOPxIOxvhHKZsNYOxpxKDaVPHphfz1ZxZSzw+6b9cjko?=
 =?us-ascii?Q?gHlPJJZLrc1gf3huxM/Xs33Qin0EderK1l3EYYf9O7P+nR794lh3e9hRJWiE?=
 =?us-ascii?Q?p/H7r2KGXecpPrlgfxV5v7kGs45CVNbYWrfe6JLggr1uhZ/sEwtF006Xl6/g?=
 =?us-ascii?Q?ftnGyDb9zcDj/DTNMEzsGc9dF6As+FnzoYJVrMKnyBdeRIsVlj3t2BukOi2o?=
 =?us-ascii?Q?EzEij0x0IlLVNqncNySSOiSLdLK9spN7LSzCr9I1pvLSQ04P/AdoMnaJUyKN?=
 =?us-ascii?Q?pKQsbo2Gz/YNGN9Bv+ZVdsvDSXGV7uEa6i7yaIt278DFS7DBA3lXlnJNqOu5?=
 =?us-ascii?Q?prFe+deCNEvWvtQc/GTCwpjeMBefxBwuJ4KEbwaxnEYxzrxaG6pwy9u0QNC/?=
 =?us-ascii?Q?udS2i8Q7RlL9OEXG0vTfoMWl3OvwujkB0FaMR5/kAxiYc8qePHo3rSweo8G7?=
 =?us-ascii?Q?pS9yDVl5KDY7qRCNDInDf6dooXsELWKb9SBcYpTzIyCGYJlDsbixDstw/0+z?=
 =?us-ascii?Q?qObBPYWZKbTB6YT3HqFa/QNbj6ZFK5YZICfz2K4bd+hb00UZJvS8+L5VxC0i?=
 =?us-ascii?Q?iJaeH0w4RZUJHiUechiB0G9KSQIqpAUqZRfF5T5sWp2jSjs1sY5utf9bRfMG?=
 =?us-ascii?Q?Ae6gKhYEKR1IVDsUwShdMLLWlH3nI8DMvRAuk8sPE0gdD5FyW4zaXdddRP0F?=
 =?us-ascii?Q?XfcB5IT4n2txRNrXZLQmAuyIRcCtSfWtGA5CFygePiliyneJVEB4QCOww1mR?=
 =?us-ascii?Q?GrUUR5NZ5uzEVL9q70hBCnlWChRvq83RolYic+Zehwv5/MxaGyCdEpmG1oF3?=
 =?us-ascii?Q?lPgXdKQ54l08W1CA2nXpakPzHVyPhxYPhxVrX3Mk4/9q4EqH9hAeURp6ya8z?=
 =?us-ascii?Q?2vIEYfb2hGMHSZ1zeIWZoh110IOTDe8c7dK5aPZ5M7gZq9pgBCtk69iM4F4j?=
 =?us-ascii?Q?LkR4O/7LFszObTDKNoIFaQbbjYGTP1rxdT7OEysYhr7EPu+NyQ+qCktDmpFU?=
 =?us-ascii?Q?NSpGIxVNE7674hAkobgab0fro8IjPTAntdUqupXZTAtvly3srm9DXa3PKx95?=
 =?us-ascii?Q?IO+zXmBWwxQ6++MnICyFb62R74+64qYcEVQrUPRarLsDV2/El4ZJ65hAyplA?=
 =?us-ascii?Q?Vce1w9CdRAnEuquMLyEtRa16huBp1F2cTaGFK5Y/2cAK+U4xig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 08:25:37.7682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac8d416-fad3-4365-b7f9-08dd03bcc0d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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

Get XGMI_v_6_4_0 link status and populate it to metrics v1_7 for
SMU_v_13_0_6

v2: Get link status register value for each soc from separate
function (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      | 41 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |  2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  4 +-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index b47422b0b5b1..74b4349e345a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -40,6 +40,11 @@
 #define smnPCS_GOPX1_PCS_ERROR_STATUS    0x12200210
 #define smnPCS_GOPX1_PCS_ERROR_NONCORRECTABLE_MASK      0x12200218
 
+#define XGMI_STATE_DISABLE                      0xD1
+#define XGMI_STATE_LS0                          0x81
+#define XGMI_LINK_ACTIVE			1
+#define XGMI_LINK_INACTIVE			0
+
 static DEFINE_MUTEX(xgmi_mutex);
 
 #define AMDGPU_MAX_XGMI_DEVICE_PER_HIVE		4
@@ -289,6 +294,42 @@ static const struct amdgpu_pcs_ras_field xgmi3x16_pcs_ras_fields[] = {
 	 SOC15_REG_FIELD(PCS_XGMI3X16_PCS_ERROR_STATUS, RxCMDPktErr)},
 };
 
+static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int global_link_num)
+{
+	const u32 smnpcs_xgmi3x16_pcs_state_hist1 = 0x11a00070;
+	const int xgmi_inst = 2;
+	u32 link_inst;
+	u64 addr;
+
+	link_inst = global_link_num % xgmi_inst;
+
+	addr = (smnpcs_xgmi3x16_pcs_state_hist1 | (link_inst << 20)) +
+		adev->asic_funcs->encode_ext_smn_addressing(global_link_num / xgmi_inst);
+
+	return RREG32_PCIE_EXT(addr);
+}
+
+int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev, int global_link_num)
+{
+	u32 xgmi_state_reg_val;
+
+	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+	case IP_VERSION(6, 4, 0):
+		xgmi_state_reg_val = xgmi_v6_4_get_link_status(adev, global_link_num);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if ((xgmi_state_reg_val & 0xFF) == XGMI_STATE_DISABLE)
+		return -ENOLINK;
+
+	if ((xgmi_state_reg_val & 0xFF) == XGMI_STATE_LS0)
+		return XGMI_LINK_ACTIVE;
+
+	return XGMI_LINK_INACTIVE;
+}
+
 /**
  * DOC: AMDGPU XGMI Support
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 8cc7ab38db7c..d1282b4c6348 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -84,5 +84,7 @@ int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev);
 int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
 				   struct amdgpu_hive_info *hive,
 				   int req_nps_mode);
+int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev,
+				int global_link_num);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 11ecaa62f419..ab3c93ddce46 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -96,7 +96,6 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
 #define LINK_SPEED_MAX				4
-
 #define SMU_13_0_6_DSCLK_THRESHOLD 140
 
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
@@ -2448,6 +2447,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc, flag)[i]);
 		gpu_metrics->xgmi_write_data_acc[i] =
 			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc, flag)[i]);
+		ret = amdgpu_get_xgmi_link_status(adev, i);
+		if (ret >= 0)
+			gpu_metrics->xgmi_link_status[i] = ret;
 	}
 
 	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
-- 
2.46.0

