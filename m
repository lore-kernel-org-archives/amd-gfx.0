Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3907C3DA4B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 08:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671D210E9F5;
	Wed, 17 Jul 2024 08:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B/4ZtGvV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E1D910E9F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 08:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jspJDTpbg0GTMIDnHrFNw6EHX8zZGCBAO1GbAR0eo8kKiANHClVie4qiquxvhNKKOz9oG6IjlZZ0vMDW0s7YgXCWFInqkX1ZpiZx6l5Ageqp3QwZC8LjLSXSSl0LhzADnT4+Y+p3qlzv+Zs8G612Qm/M8FWyeoMTiwJ12HI3dPT4kR3cGYg6mpIuYzNjl1L+tXEYsxVoRcyVUKnYedEjwhXlvymczQOsvu6Qc93OXrK30xNub0S8+0nFtwJ/htfVmSdFiowga5GQ+M/c0YAav4ZMqyRZyLbvPnuMhezw91RHQFygkBjNUXxexhDPCdLmGZ5kvpll9EX8XypojypsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcDhX7ivDQ3PQjVHQKxHAXrwt/ZnH3L0ZXjTFGqvVJk=;
 b=kvQROmWT9wwKcD6RVhpTqJgs2B0rj6LmgoXNFy0GvzBX+yJwJhvDJ4HAAFhmhyHJ1EDCsR7ut2Qov+JMH5nzgfT4Loxg3pxLLoZYHEMV8E0kUsbifH7K1l12nGRd/L5nvuyAqL8UyLBzO85Rjmb16PbiYAp5rx192T0p3pIDOHYXOsVwlKBrRoCvu/ViHJwjmFDW5ZQphUTrz6Ltdgfabz0Hbwey0wCJ5d3faYefeFSDK+NIr/29pCtA5oaCSnzYscDQr1CxDtSAvT00+0AYapF9RA4EoLsWbz+qYRM7om7hdP0ytUL+J1hpzTao8XaQAKpZmBt2EtqiVSUroypwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcDhX7ivDQ3PQjVHQKxHAXrwt/ZnH3L0ZXjTFGqvVJk=;
 b=B/4ZtGvVhb5hbIFvW42iz2dY27Q9t+1fIzOI1UaOux4Cqnfs4usSu2f+GMpuKqwMc918lspERvr+X6tCvCXJfkNRhI6YVyaQ3H+AqKUgWwTGOok7kg5u9KzVcu9CZaJ7hYrrWz9t9UvZqTnK3b1xaxNSrCrfSFAkf+zVpool9N8=
Received: from BL1PR13CA0269.namprd13.prod.outlook.com (2603:10b6:208:2ba::34)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 08:16:16 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::9b) by BL1PR13CA0269.outlook.office365.com
 (2603:10b6:208:2ba::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Wed, 17 Jul 2024 08:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:16:15 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:16:10 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion function
Date: Wed, 17 Jul 2024 16:15:45 +0800
Message-ID: <20240717081547.224193-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: e51ba597-5b89-45ed-053c-08dca638ba85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MBIZpsiWSPnDrAsH5WI9jEae2Arva576qYFhMA7hWDFLmlNGVOzjcnRvh/b8?=
 =?us-ascii?Q?AW2IKjFCHF6R8uI9KDm0R55m5a9cY6IXaM4BrP+Q2D+bWOk2AOz9DCE1KbqO?=
 =?us-ascii?Q?xzzfrKto1bCwYn3z+SB8KkjN+NnymcLeRuTPOsBuWFj7fLAyDK4raxuRlHSl?=
 =?us-ascii?Q?dN1SJnlufYXrFSPiACupvdV67NHfBfmXPiexii9p7qc9zXaqpZyJ1BWOKE6l?=
 =?us-ascii?Q?JBgwjDi26gzRrPpre7bf609Pjca9fTk90no0salxlm8FoWMJe5cDh6qwfJu5?=
 =?us-ascii?Q?NBmPL181OpHv0WB3kVu52WmK60owv3ORp4291mmBejMpDM0/0VT8o9NqavU5?=
 =?us-ascii?Q?OtIn9ZdwfeaU694XF26UM2ZUT2uZ5MXn3AMDx/8lrYqf3joN+JL4TFZZdaq1?=
 =?us-ascii?Q?w6cI7opImgEgMAmBEHXqICzCSbPk6fZ6ph1hi6j/E53u7tVS7xno8nYizKDQ?=
 =?us-ascii?Q?skyHyGlIak8LDoTDYDhp1VzOF2L/B3CTmfCG3Dc5o2Iq/xwr8ovVSogstHPF?=
 =?us-ascii?Q?zynQfuKu/0l45O7t5rWnzVdc2ljsvc0Wc169hcrH+Wng+62RfsKVEXnFsRfH?=
 =?us-ascii?Q?TIBY5oQGm7193TJAuLm9U89tgvifuRhIIbKXYtQOzmfjidLg9KGcPoRLaCdF?=
 =?us-ascii?Q?vNElWbxNsTfz7TWjVeN3SdaZhdMYd4Y5P4uiHBrLmUa0WVMoxmxd3TeEUr68?=
 =?us-ascii?Q?5rRzVdNZ7hvnnwhPCsVdqHrx1EY/VAEu4FlzqnJF13lZXB3+22iYT8kV4AxE?=
 =?us-ascii?Q?tojn36HI3/DnmTy5x3Yl0oGbGqtUoM7xMdw2NhNyTvUwL0yQR9JhqHjmb32n?=
 =?us-ascii?Q?rvP+6K61umlArnA5e34PmoO3umb1s8rwQ9ph9P/Y30bZRGkyNNxokfbqo5EA?=
 =?us-ascii?Q?+HV6yr2MEiKt6lXhGd7zMsbj+LmtEg0KPUA8MP39BhlKUuGA0gTnhzEs2UTh?=
 =?us-ascii?Q?UnKUlPbS55oWouALhbjjt5vt60rsJ49Cj2kb3MlTDSfK4bmLQOjBC9q3pzJD?=
 =?us-ascii?Q?0l+Q/sxAWuLaQKrvz9AKTMbE3eHlfJHokJvjIUYGngUQITRzFXcuXZyVgLZG?=
 =?us-ascii?Q?C9sSHyoTMuPEY2oWQlP1MtH0/kswOo19o7sWjKjYoao/OIN+nmuI5pCCzBBX?=
 =?us-ascii?Q?eGL3D8LAzB9cl1LSj94pYDXxqMZOPGXQwrVvdUjkuIIxY+n1XSXQIyLVzEv9?=
 =?us-ascii?Q?PLkErOBDwb0yIGVNI/3mWPUJKbMTOBL6Ou8sQ37kn9dNk3mhuQu+J8BRCoV1?=
 =?us-ascii?Q?7FTWa1ewoT+dVBlgwp+ZHYZymnT14R5S2mbYQ8Pl7mFj9WYH9TCu/5YQHckf?=
 =?us-ascii?Q?BVslD4BnN98mKegJ0oYm5rc79c5onyVy+LRpGm4jtbVcQN0l0Kor5azKlgBb?=
 =?us-ascii?Q?dxtkwHMdmx2M7gY+kQ9xHUOl9yqiqIm43Pilqku9yucH0PVjiM5PvL9aRSqm?=
 =?us-ascii?Q?4LL6jVmgwIEling9Y8DI1Zw/OuyNUAkY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:16:15.6802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51ba597-5b89-45ed-053c-08dca638ba85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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

Split into 3 parts:
1. Convert soc physical address via ras ta.
2. Expand bad pages from soc physical address.
3. Dump bad address info.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 116 ++++++++++++++++---------
 1 file changed, 77 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 9dbb13adb661..eca5ac6a0532 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -225,26 +225,16 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	}
 }
 
-static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
-				struct ta_ras_query_address_input *addr_in,
-				uint64_t *pfns, int len)
+static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
+				struct ta_ras_query_address_output *addr_out,
+				uint64_t err_addr)
 {
 	uint32_t col, row, row_xor, bank, channel_index;
-	uint64_t soc_pa, retired_page, column, err_addr;
-	struct ta_ras_query_address_output addr_out;
-	uint32_t pos = 0;
-
-	err_addr = addr_in->ma.err_addr;
-	addr_in->addr_type = TA_RAS_MCA_TO_PA;
-	if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
-		dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
-			err_addr);
-		return 0;
-	}
+	uint64_t soc_pa, retired_page, column;
 
-	soc_pa = addr_out.pa.pa;
-	bank = addr_out.pa.bank;
-	channel_index = addr_out.pa.channel_idx;
+	soc_pa = addr_out->pa.pa;
+	bank = addr_out->pa.bank;
+	channel_index = addr_out->pa.channel_idx;
 
 	col = (err_addr >> 1) & 0x1fULL;
 	row = (err_addr >> 10) & 0x3fffULL;
@@ -258,11 +248,6 @@ static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
 	for (column = 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
 		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
 		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
-
-		if (pos >= len)
-			return 0;
-		pfns[pos++] = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-
 		/* include column bit 0 and 1 */
 		col &= 0x3;
 		col |= (column << 2);
@@ -270,6 +255,35 @@ static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
 			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
 			retired_page, row, col, bank, channel_index);
 
+		/* shift R13 bit */
+		retired_page ^= (0x1ULL << UMC_V12_0_PA_R13_BIT);
+		dev_info(adev->dev,
+			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
+			retired_page, row_xor, col, bank, channel_index);
+	}
+}
+
+static int umc_v12_0_expand_addr_to_bad_pages(struct amdgpu_device *adev,
+			uint64_t pa_addr, uint64_t *pfns, int len)
+{
+	uint64_t soc_pa, retired_page, column;
+	uint32_t pos = 0;
+
+	soc_pa = pa_addr;
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
 		/* shift R13 bit */
 		retired_page ^= (0x1ULL << UMC_V12_0_PA_R13_BIT);
 
@@ -277,14 +291,40 @@ static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
 			return 0;
 		pfns[pos++] = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
 
-		dev_info(adev->dev,
-			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-			retired_page, row_xor, col, bank, channel_index);
 	}
 
 	return pos;
 }
 
+static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
+			uint64_t err_addr, uint32_t ch, uint32_t umc,
+			uint32_t node, uint32_t socket,
+			uint64_t *addr, bool dump_addr)
+{
+	struct ta_ras_query_address_input addr_in;
+	struct ta_ras_query_address_output addr_out;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	addr_in.ma.err_addr = err_addr;
+	addr_in.ma.ch_inst = ch;
+	addr_in.ma.umc_inst = umc;
+	addr_in.ma.node_inst = node;
+	addr_in.ma.socket_id = socket;
+	addr_in.addr_type = TA_RAS_MCA_TO_PA;
+	if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out)) {
+		dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
+			err_addr);
+		return -EINVAL;
+	}
+
+	if (dump_addr)
+		umc_v12_0_dump_addr_info(adev, &addr_out, err_addr);
+
+	*addr = addr_out.pa.pa;
+
+	return 0;
+}
+
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 					uint32_t node_inst, uint32_t umc_inst,
 					uint32_t ch_inst, void *data)
@@ -483,12 +523,10 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	uint16_t hwid, mcatype;
-	struct ta_ras_query_address_input addr_in;
 	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
-	uint64_t err_addr, hash_val = 0;
+	uint64_t err_addr, hash_val = 0, pa_addr = 0;
 	struct ras_ecc_err *ecc_err;
-	int count;
-	int ret;
+	int count, ret;
 
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
 	mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
@@ -514,17 +552,17 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 		MCA_IPID_2_UMC_CH(ipid),
 		err_addr);
 
-	memset(page_pfn, 0, sizeof(page_pfn));
-
-	memset(&addr_in, 0, sizeof(addr_in));
-	addr_in.ma.err_addr = err_addr;
-	addr_in.ma.ch_inst = MCA_IPID_2_UMC_CH(ipid);
-	addr_in.ma.umc_inst = MCA_IPID_2_UMC_INST(ipid);
-	addr_in.ma.node_inst = MCA_IPID_2_DIE_ID(ipid);
-	addr_in.ma.socket_id = MCA_IPID_2_SOCKET_ID(ipid);
+	ret = umc_v12_0_convert_mca_to_addr(adev,
+			err_addr, MCA_IPID_2_UMC_CH(ipid),
+			MCA_IPID_2_UMC_INST(ipid), MCA_IPID_2_DIE_ID(ipid),
+			MCA_IPID_2_SOCKET_ID(ipid), &pa_addr, true);
+	if (ret)
+		return ret;
 
-	count = umc_v12_0_convert_err_addr(adev,
-				&addr_in, page_pfn, ARRAY_SIZE(page_pfn));
+	memset(page_pfn, 0, sizeof(page_pfn));
+	count = umc_v12_0_expand_addr_to_bad_pages(adev,
+				pa_addr,
+				page_pfn, ARRAY_SIZE(page_pfn));
 	if (count <= 0) {
 		dev_warn(adev->dev, "Fail to convert error address! count:%d\n", count);
 		return 0;
-- 
2.34.1

