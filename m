Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9142FC05023
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BD2113944;
	Thu, 18 Apr 2024 03:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ip6dqp6y";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66DF3113944
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAxIdNb2RqZm8U4qYLcFNhNC0hzlm4HwqaLnWRDFQSapDKOw8TMIIXYx24fxu8X5T/NoW4uCHVfg587EviLRduIaTkCXK5Je5UYFq/dR8gos635ak+VL/HnWrDbWgO2xK/NiRS2D7SIMbRkmSNA8/0Tf2P2HgL3VeYlmsuXQgXLFEdxOf9EahtySd+7SvBgK8kKaK+E92TYtZzvxQa0lKSJpHoQ53ou3BTIGCIOe2Xn3CKkgYirnpmHH3b2SR45geafatQ5s3qIH2VDHpS+2yvVvffU21Gkql4L3GFrCOrOVKvos3huRt9us19i3Qby5g39sawsiGobOt9v6SEkK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWcorcXV8LCZz5xIJm2UAwz+CkxRTkmJU1fB0zqXCpA=;
 b=f6F9P4UCBMOitTKDCC1FKvw/vb9kvu9fbL+DjLSkwJ94uanrUmreaN1bQ3S/zmY9zyt5Y72xPAN7zfb2KsddpN5lQxjV+VH/yc34yKhJVII02LZJ9LC+kBVJX6Zb/SEEOrO4JK96GCIDr8+OQ3CQe66lgcAtYKccPVhryUV5czg/CextL/+dkWy4DohqPL/+ER3THBZhwCXIq2UD318xQLT7pvZUxFtehh7Du3gvZCB4F+FLuS1CQOId2ehmjT8h/i8kttgRx/992l0dsT3fn47Nk9xxsU5ULEzSQDyPWuGFqRqTxDr/XpgAhElEc2NmzE+jWJVCKqh+9Y5PinoQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWcorcXV8LCZz5xIJm2UAwz+CkxRTkmJU1fB0zqXCpA=;
 b=Ip6dqp6yTyxx1jmEjU/T1vNsCLK11y8w1dPOL6+vfFLPKiiRt/hm1xzzEX/r6SGwPLVHMWinRRobo3XoIV6Zgcvog6UQ3WWL4OW4WzexPRWKulHh3uL0+K9bMrARPR4BrTcnqyRZx4mL9jPikcasbp1vKnRce2MjA+l4Oz/qKjA=
Received: from BL0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:2d::27)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 03:01:48 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::31) by BL0PR03CA0014.outlook.office365.com
 (2603:10b6:208:2d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 03:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:01:47 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:45 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 06/15] drm/amdgpu: umc v12_0 converts error address
Date: Thu, 18 Apr 2024 10:58:27 +0800
Message-ID: <20240418025836.170106-6-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f93fed3-16c5-4b11-158f-08dc5f53e35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OslFzq/gSWvKeD45O9p8uN3nMBTVMTjDm5Wd7X3Nezdbx28Q/tTKFz+jkzmXY4dv7FvDIlnbRdQ4Uvk/y8qyuE9IahxaG774BBC3fdx/jVM/b58ty7JypPgKsZ7MEphFxSYFdqkX5B/74t5SBn28O+2vo2DkX/EKdsrgMvWPhMMbIiznQCQ0AhRhvg6963FZhice3t5+u1rSYxgn/GTdoNo7+HGg0s9DbBtHAc6vptka2dUIUCZOGvTbyJiH/0J8JMY9qTWQfsLSNPn2wXbtk+7O+7A+Xv2n+7wja579+iH25Ma9BpDaataDnDeKYS7cZBn8fVMDtZdZw/7XFkDG19gqKeFz74rdGoo+HODhhNQu9FCh3SXu+yThNBtYDoL4eudl8j+kpI23+7Auur9y0vPsuYUjJWVYlsDbTDiU8pQDfgUD1Dtb4B3X0+0CFKHgWcIU5TJH1w8c2GnbxeHalzHx5BrZwYh7QP+I4EHxzfFWm8VmLav2PfAaNNUVW0GvLCFDou51Pq7CXn59RjnatGkhZkZRLTF3bzAUUuKxMysLXSLEEmL07NNuxY/5N0ItUGMGePzNjBkRsIT9zsg/8INBQTtIKFnO/3fbmVBPHuMUFYtuGke7iZ4ZLsliaHe0knqgJehjB7lpKfS7Ee6ng5V7HKQyC/im5picpBszwHTpFxwu+0usT8IKInIzz06t5eN6Rk2hGncpQrArHmXecPuNtv59VkAhOfeeZDmsEEIHsPaY37rbvuzpj1Pc+TKR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:01:47.9789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f93fed3-16c5-4b11-158f-08dc5f53e35f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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

Umc v12_0 converts error address.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 94 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h | 12 ++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 81435533c4a7..085dcfe16b5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -222,6 +222,66 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	}
 }
 
+static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
+				struct ta_ras_query_address_input *addr_in,
+				uint64_t *pfns, int len)
+{
+	uint32_t col, row, row_xor, bank, channel_index;
+	uint64_t soc_pa, retired_page, column, err_addr;
+	struct ta_ras_query_address_output addr_out;
+	uint32_t pos = 0;
+
+	err_addr = addr_in->ma.err_addr;
+	addr_in->addr_type = TA_RAS_MCA_TO_PA;
+	if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
+		dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
+			err_addr);
+		return 0;
+	}
+
+	soc_pa = addr_out.pa.pa;
+	bank = addr_out.pa.bank;
+	channel_index = addr_out.pa.channel_idx;
+
+	col = (err_addr >> 1) & 0x1fULL;
+	row = (err_addr >> 10) & 0x3fffULL;
+	row_xor = row ^ (0x1ULL << 13);
+	/* clear [C3 C2] in soc physical address */
+	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
+	/* clear [C4] in soc physical address */
+	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+
+	/* loop for all possibilities of [C4 C3 C2] */
+	for (column = 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
+		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
+
+		if (pos >= len)
+			return 0;
+		pfns[pos++] = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+
+		/* include column bit 0 and 1 */
+		col &= 0x3;
+		col |= (column << 2);
+		dev_info(adev->dev,
+			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
+			retired_page, row, col, bank, channel_index);
+
+		/* shift R13 bit */
+		retired_page ^= (0x1ULL << UMC_V12_0_PA_R13_BIT);
+
+		if (pos >= len)
+			return 0;
+		pfns[pos++] = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+
+		dev_info(adev->dev,
+			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
+			retired_page, row_xor, col, bank, channel_index);
+	}
+
+	return pos;
+}
+
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 					uint32_t node_inst, uint32_t umc_inst,
 					uint32_t ch_inst, void *data)
@@ -482,8 +542,12 @@ static int umc_v12_0_ras_late_init(struct amdgpu_device *adev, struct ras_common
 static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 			uint64_t status, uint64_t ipid, uint64_t addr)
 {
-	uint16_t hwid, mcatype;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	uint16_t hwid, mcatype;
+	struct ta_ras_query_address_input addr_in;
+	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
+	uint64_t err_addr;
+	int count;
 
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
 	mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
@@ -497,6 +561,34 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	if (!umc_v12_0_is_deferred_error(adev, status))
 		return 0;
 
+	err_addr = REG_GET_FIELD(addr,
+				MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+
+	dev_info(adev->dev,
+		"UMC:IPID:0x%llx, socket:%llu, aid:%llu, inst:%llu, ch:%llu, err_addr:0x%llx\n",
+		ipid,
+		MCA_IPID_2_SOCKET_ID(ipid),
+		MCA_IPID_2_DIE_ID(ipid),
+		MCA_IPID_2_UMC_INST(ipid),
+		MCA_IPID_2_UMC_CH(ipid),
+		err_addr);
+
+	memset(page_pfn, 0, sizeof(page_pfn));
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	addr_in.ma.err_addr = err_addr;
+	addr_in.ma.ch_inst = MCA_IPID_2_UMC_CH(ipid);
+	addr_in.ma.umc_inst = MCA_IPID_2_UMC_INST(ipid);
+	addr_in.ma.node_inst = MCA_IPID_2_DIE_ID(ipid);
+	addr_in.ma.socket_id = MCA_IPID_2_SOCKET_ID(ipid);
+
+	count = umc_v12_0_convert_err_addr(adev,
+				&addr_in, page_pfn, ARRAY_SIZE(page_pfn));
+	if (count <= 0) {
+		dev_warn(adev->dev, "Fail to convert error address! count:%d\n", count);
+		return 0;
+	}
+
 	con->umc_ecc_log.de_updated = true;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 5c2d7e127608..b4974793850b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -69,6 +69,18 @@
 			(((_ipid_lo) >> 12) & 0xF))
 #define MCA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)
 
+#define MCA_IPID_2_DIE_ID(ipid)  ((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) >> 2) & 0x03)
+
+#define MCA_IPID_2_UMC_CH(ipid) \
+	(MCA_IPID_LO_2_UMC_CH(REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo)))
+
+#define MCA_IPID_2_UMC_INST(ipid) \
+	(MCA_IPID_LO_2_UMC_INST(REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo)))
+
+#define MCA_IPID_2_SOCKET_ID(ipid) \
+	(((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
+	 (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
+
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
-- 
2.34.1

