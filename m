Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98EEC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E89113943;
	Thu, 18 Apr 2024 03:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qqlKwHa/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8463113943
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuMAf8ydOEVBYiLl/BtA5cL2E6Sy8X3s0PlGGSwF2jniimhoNRaMj62SyWUIcICdya9QTVfWhMrbfJPuKxS+fojJcaycPd8GQSe2SZZ5c3NVzP7j26yE/OSbw0siSFZ5sJFixqjpOHJLz1NH1m9ocQWmX7pCDvCn9JP6m4vS7+hhlTSpWbGz85IM2ZQYzeZjXdeEo4nj7jXDfXdH5NooJhLymbNQsw+rxjjgPqnMDUW3r2F8Sby+iYBM0AU9NoE5kd+CUpuZQnKcpH+dDQKrWMmrmpQM1Yltxh7mzZfIQ8AJ1sOSsxB9xvchLTeio/t8HN8Xh9mmNAIve+Oi37CYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG5Ll6MNPj1A2FzgsNUMWjAqSn0Onrb59bYfcZ3NPqE=;
 b=iIkQKuDR6OAmYw15KjpXzXWxg33sD9aSnwQLAnA0YECroTvI6ughv2oF+dYoYDN+nsfQgeo2DiUIoqlZjqisfQ4CBPRg/rQ5t7AOdLSNOisNKAaclH+QQKuHeLEsiLrTwCi6OvvrIYlMS8oGyUXt9HAb9DLiUXy+n3NfctlxRnQPXsy4BhDRNBDInUxt/VDtInB9N4XaeKpfSsR2d5WcLWc+z3xuVV6RWHnHRlRV9rNf/kFuW/ljfNy6GQf3SdsEV101X1PHNRnzEpfOLvirEB+3WpDuDVuWSemYqWEtbYpk0yxRpn9wVwmerW5I7tdF50b7FjjQnLsaZTQE6VT25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG5Ll6MNPj1A2FzgsNUMWjAqSn0Onrb59bYfcZ3NPqE=;
 b=qqlKwHa/M6ipGoWWFzstkkNbPDeGyCzLGROOB71gjG5jbuj7EewGqLsIkm9ab25VTPZ0fo8OcGLV43nO63vQCTFFEWegPAbB1vqRfgsMwGkTQ5FiPVr+RiR1JqODUVKrqTHzEx6ia5VwWwNSD6thxRCSiXtOz04X4o9DVMBVfy4=
Received: from BL0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:2d::34)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 03:01:46 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::55) by BL0PR03CA0021.outlook.office365.com
 (2603:10b6:208:2d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.24 via Frontend
 Transport; Thu, 18 Apr 2024 03:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:01:46 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:28 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 05/15] drm/amdgpu: add interface to update umc v12_0 ecc status
Date: Thu, 18 Apr 2024 10:58:26 +0800
Message-ID: <20240418025836.170106-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: a3817c6a-ae57-4048-f98d-08dc5f53e25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAILq/Kw/1nedvev73G1VILaV9entDrAr8fLTwY1D4HhjuApQvP3UOtKRRoua0ABxie35ODblxzC2RwGMXHbSJnsJxqavCRXWxPTsqln7Tk6tIIbI9qqUYYeKAcXeZQbXMlu/WL5AX+QbB3HOKLWYjpp2DY/wiom87RrVtSaysiNkuIdXwpMuiZx0uhwbePqaTkAlCmDs/hmj7S55x/ey2orc/2z86rg9D+41I+4hhOGINJIXa6zESl51S/T4LGCQ8toTGuU3DNACESCWW+r4iVo6iQYSXpW6eZ8rcgW8ghh7a7fhh4JzPWQRrA50mPVAiLQbP7Adpba3k0esL1/XsCh7IMEYldA+R4Dl2EWV1qGojQZMbfx3/m8wGdHKt7MM86Uo7qGPPhq0pnQsOJEUYSL+QN4Rb3fupC1/dlkhZB0+B21/wBf4pAYwhNMxIVbHnWNmGV7/EkatqFt0janLFh7LJASe2yyA4SrI8neQjmm0WGLIKPiFaEDjKKxUD+HPWrqNCXqYqlR/IjDEnpW3lmMPAAXre6fJmieHWlMnXuMIV67yUXpo+dIU05nW4NMIOIiEJlEMDLkL9EfuPTeYI4qmQdnA6c5F1frUcj2yPvQdnxmD3ztYYXC9FAdybtg8dc+BhaGI3naePc8+PLLz23JXRVPwrrSlhrxyS8az0GSN/c1i9QbaW34RAXqFphF7l9MaeBf/nEPX7aCENN7oyvC4KSaR3YrQvPWB0kK2k+C+icwL5hEbxpo9w6t8Jre
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:01:46.2601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3817c6a-ae57-4048-f98d-08dc5f53e25f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
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

Add interface to update umc v12_0 ecc status.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  9 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  6 +++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        | 24 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h        |  3 +++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  5 ++++
 6 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 126616eaeec1..702229abe7ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4213,6 +4213,8 @@ void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info, struct ras_err_a
 {
 	struct ras_err_addr *mca_err_addr;
 
+	/* This function will be retired. */
+	return;
 	mca_err_addr = kzalloc(sizeof(*mca_err_addr), GFP_KERNEL);
 	if (!mca_err_addr)
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f486510fc94c..7006a57277ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -437,3 +437,12 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+int amdgpu_umc_update_ecc_status(struct amdgpu_device *adev,
+				uint64_t status, uint64_t ipid, uint64_t addr)
+{
+	if (adev->umc.ras->update_ecc_status)
+		return adev->umc.ras->update_ecc_status(adev,
+					status, ipid, addr);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 563b0249247e..4f3834fa10a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -66,6 +66,8 @@ struct amdgpu_umc_ras {
 					void *ras_error_status);
 	bool (*check_ecc_err_status)(struct amdgpu_device *adev,
 			enum amdgpu_mca_error_type type, void *ras_error_status);
+	int (*update_ecc_status)(struct amdgpu_device *adev,
+			uint64_t status, uint64_t ipid, uint64_t addr);
 };
 
 struct amdgpu_umc_funcs {
@@ -122,4 +124,8 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 
 int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 			uint32_t reset, uint32_t timeout_ms);
+
+int amdgpu_umc_update_ecc_status(struct amdgpu_device *adev,
+				uint64_t status, uint64_t ipid, uint64_t addr);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index a0122b22eda4..81435533c4a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -479,6 +479,29 @@ static int umc_v12_0_ras_late_init(struct amdgpu_device *adev, struct ras_common
 	return 0;
 }
 
+static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
+			uint64_t status, uint64_t ipid, uint64_t addr)
+{
+	uint16_t hwid, mcatype;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
+	mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
+
+	if ((hwid != MCA_UMC_HWID_V12_0) || (mcatype != MCA_UMC_MCATYPE_V12_0))
+		return 0;
+
+	if (!status)
+		return 0;
+
+	if (!umc_v12_0_is_deferred_error(adev, status))
+		return 0;
+
+	con->umc_ecc_log.de_updated = true;
+
+	return 0;
+}
+
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
@@ -489,5 +512,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ecc_info_query_ras_error_count = umc_v12_0_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v12_0_ecc_info_query_ras_error_address,
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
+	.update_ecc_status = umc_v12_0_update_ecc_status,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 1d5f44dcffdd..5c2d7e127608 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -62,6 +62,9 @@
 /* row bits in SOC physical address */
 #define UMC_V12_0_PA_R13_BIT 35
 
+#define MCA_UMC_HWID_V12_0     0x96
+#define MCA_UMC_MCATYPE_V12_0  0x0
+
 #define MCA_IPID_LO_2_UMC_CH(_ipid_lo) (((((_ipid_lo) >> 20) & 0x1) * 4) + \
 			(((_ipid_lo) >> 12) & 0xF))
 #define MCA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 55d11ea8c717..8370c2130476 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2681,6 +2681,11 @@ static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, struct
 	    umc_v12_0_is_correctable_error(adev, status0))
 		*count = (ext_error_code == 0) ? odecc_err_cnt : 1;
 
+	amdgpu_umc_update_ecc_status(adev,
+			entry->regs[MCA_REG_IDX_STATUS],
+			entry->regs[MCA_REG_IDX_IPID],
+			entry->regs[MCA_REG_IDX_ADDR]);
+
 	return 0;
 }
 
-- 
2.34.1

