Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC39D5E15E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C38A10E96C;
	Fri,  8 Nov 2024 11:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qy1Baeir";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F7410E96C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odt9b7dMJ1JgN05LLAsd5SP6biQaNTPpi1jwz8Qe4RreqhYoX9bSh6AIb47THXthWNL3bs5NEMh80opFFi6gDm23TCytWZeA83ynOSl9JkUrT+b2udCslioV3f6n/7a+sJdXYujEzewj2HMD7YR3oYV608wLMDpY1/FTQfwkazUzzVzi9Am8ymUTEph8TQmZ/CvG+xOKryNi/R2aY6O+3jiR3xMPPq/bm9T2rlYWp0Iade/X2hT6S39mu8pjOkA2egttJctxKAQsTw2rYXqD3yWZyfUACy65PDQRPerDsPgMmVYVbRNbbu0iOaSVINOkjwOiRB1Dzns1xX2jK2ASZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpnC1K3i+1JvTYOgeE5ZCq6LcZgzTrjd8cWlznd6FA4=;
 b=BigzneNDQDC55mF7Edg/0yocXsanB/NV3oEqOOjUg89mb0fvzDISGI/e2UGr9QiTRyLVZdR/PAkjANgJ+I/CqJEzbMpFITLf4JzwyhEXNZZrBG82sDewrwjp4FMPFXmNsMzqi5YIqep/LWeSd3R+P6iBotzwSIU4IPMZDH0mXXJAxNMwN0ai6JLrZDz4URKEKtOhasmIgJLSGojdJ94eugaJHlJxEKn+vsgyCPN7o+nHe/AaYo8WWf8mohPnz/0enoKsK6rKMRWWrwYnQXxnYAuDh95Nzy/TkzrM1eu7g2zGX1I1atSCTzpI74faWLePQifjvIB/ELkpXf1k/VxVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpnC1K3i+1JvTYOgeE5ZCq6LcZgzTrjd8cWlznd6FA4=;
 b=qy1BaeirjeYjRNwy9tg8IwuFiShbcn7jrzToLt0V5zyWd1Mjrbp0kFvIRqMn6+Rc2Z0RLshje/YpWji8dqAfMt5vAEADHPA8+araaYpSlae2NpHqEj1H9pPKbJ2RRzvgPAuimBal5y3UQPuJKC16wRVDavkro5inkIurkp9BO4E=
Received: from BN9PR03CA0254.namprd03.prod.outlook.com (2603:10b6:408:ff::19)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 11:14:51 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::7d) by BN9PR03CA0254.outlook.office365.com
 (2603:10b6:408:ff::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:51 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:49 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 16/23] drm/amdgpu: save UMC global channel index to eeprom
Date: Fri, 8 Nov 2024 19:14:16 +0800
Message-ID: <20241108111423.60169-16-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f7ecf3-a764-4adf-cf66-08dcffe690b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0pWOmQRf6qV6uoyO5sE0nn3j7FF8CFGju9LwRVew5QfOs59fDhxDQHqChAMD?=
 =?us-ascii?Q?QB+UvzRU6irF6yR471zVTX00b/XgxO9nDpiVjHGB1sVexArtiWpb81m6WhSc?=
 =?us-ascii?Q?t5XpmhbahgtkLGsFP6ISO2MWM0OgCqVXGYSJJewHuxN9vJMV+KJMx7GoBV6W?=
 =?us-ascii?Q?EqBQWBgBMgl0ZivqZ1nXAGRy5AFN9G2MaZSzDCBhY3DMHvEMt7IpuUB5EfMK?=
 =?us-ascii?Q?rCX/HSTB56L8SUT2brPb+nMcsbdN+ta03LfJI94p37dQKUPELuspRFatxaF+?=
 =?us-ascii?Q?lhQ9HSr5irqDuu6PkOV54fvgXW77nSVpBYKAs93CTZA+dJEMwFhS+sLij0OH?=
 =?us-ascii?Q?49KrXEEwQVYvcSY2jvtvKahP1StccnNxgFUFeE+exuSDmEqvVzRLQ/s8PKm4?=
 =?us-ascii?Q?s89iU+1XsNfoRJE1NSqi0P2PJ592NueF/1rBttXh8ulh4f0AwroLFWsUFGYb?=
 =?us-ascii?Q?hR+v89a5Yr12pA8sDH790ceSvEhzKrVESU/FqGeQXPc5EwF41kiyixZwZrrF?=
 =?us-ascii?Q?3EN202BZ4dStiqr5JiAQDHSTshd1CjY7AcbgRs6VqepDikBVpEoDUyALxeox?=
 =?us-ascii?Q?yVbv3BTLEA2Ml3tKOdVk7McFMqnzUMLWoAcn6YaZLMU4mhI9QaUgBWsZyHMD?=
 =?us-ascii?Q?7FWB283sRu2PfEyCfEDDH1nFJ8WRzaDCzWmXVsIaogS7TEyHCtAnikH2TGL4?=
 =?us-ascii?Q?0vwuo0yNv1rWhX1oks0vHaS1+cbWyKC+U7k2Kbo2M8hq+DGvrixDsqeyp9mK?=
 =?us-ascii?Q?dtMlk97b4NksuzUYdj1lAfp1GCd/KGHoAqaiibgaI1rqR6I8JT13KK/c1YlZ?=
 =?us-ascii?Q?iKypj99XgxL+EOheeRFAceKH/VDCYGHDiMdljgL7R204R8FUcUXYJwvfbaCJ?=
 =?us-ascii?Q?W0d1P8Ta5OuaSp7FGwisVkARAEAFd4oLrLvLdyV7jjhNocbLmQAQwFgOMZSd?=
 =?us-ascii?Q?XE3sXyc+p1imV/3RkuuRbIV0UxKJemO9BfOetrFQFYtBfdLLErIkAjmuOyC7?=
 =?us-ascii?Q?F7QRpi0Ff4pfJ1+CrZqWLmu7zKrmy6F9qbUNeQUQa38DsoZvh+2Xxe20sXXV?=
 =?us-ascii?Q?SAkRlfulMojtABmnDRTnH1KTmSKJn8vgxm/MBLLNkMR/ToTxpL4N2rw1iJLo?=
 =?us-ascii?Q?xx2BEiCn3iydSfy47Jm9xN7ALmgaw5ozOVUxSN60n1PDQfe16FLBB64RweBi?=
 =?us-ascii?Q?kV4q8Ads4TaojbbQWe0hW3CphZEg6A21WRsrSVTIx5RaRqx4RpJNcxoNIT5h?=
 =?us-ascii?Q?qFqhrvT8Afsjix/IUYgHdzU1dfvxy5OrhBiBfFxDZ8d7JCpx3zgbnc0uvYjr?=
 =?us-ascii?Q?CZwDj6vk3dOSFiGGK8XKBR/ow7t6nPPdeyOl79KRe8BFSEB7bIBkYp2sBVzG?=
 =?us-ascii?Q?Y2AKUz7BYSSaCtPsU8NTw792VOgXjCD6eiL6BqTX+ZXo8c+Wnw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:51.4472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f7ecf3-a764-4adf-cf66-08dcffe690b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
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

Save the global channel index returned by RAS TA to eeprom.
We can get memory physical address by MCA address and channel index.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 13 ++++++++-----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 871b2d6278e0..252e360c6416 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -481,6 +481,8 @@ struct ras_ecc_err {
 	uint64_t ipid;
 	uint64_t addr;
 	uint64_t pa_pfn;
+	/* save global channel index across all UMC instances */
+	uint32_t channel_idx;
 	struct ras_err_pages err_pages;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 11f7299f773f..17659fa4450a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -498,10 +498,9 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 			uint64_t err_addr, uint32_t ch, uint32_t umc,
 			uint32_t node, uint32_t socket,
-			uint64_t *addr, bool dump_addr)
+			struct ta_ras_query_address_output *addr_out, bool dump_addr)
 {
 	struct ta_ras_query_address_input addr_in;
-	struct ta_ras_query_address_output addr_out;
 	int ret;
 
 	memset(&addr_in, 0, sizeof(addr_in));
@@ -513,14 +512,12 @@ int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 
 	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
 		ret = adev->umc.ras->convert_ras_err_addr(adev, NULL, &addr_in,
-				&addr_out, dump_addr);
+				addr_out, dump_addr);
 		if (ret)
 			return ret;
 	} else {
 		return 0;
 	}
 
-	*addr = addr_out.pa.pa;
-
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index ce1e4fb385b5..2f71194d5da8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -146,5 +146,5 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
 			uint64_t err_addr, uint32_t ch, uint32_t umc,
 			uint32_t node, uint32_t socket,
-			uint64_t *addr, bool dump_addr);
+			struct ta_ras_query_address_output *addr_out, bool dump_addr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 17ef9a6743f5..cce93b4ffb58 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -180,7 +180,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					bool dump_addr)
 {
 	uint32_t col, col_lower, row, row_lower, bank;
-	uint32_t channel_index, umc_inst = 0;
+	uint32_t channel_index = 0, umc_inst = 0;
 	uint32_t i, loop_bits[UMC_V12_0_RETIRE_LOOP_BITS];
 	uint64_t soc_pa, column, err_addr;
 	struct ta_ras_query_address_output addr_out_tmp;
@@ -193,7 +193,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	else
 		paddr_out = addr_out;
 
-	err_addr = bank = channel_index = 0;
+	err_addr = bank = 0;
 	if (addr_in) {
 		err_addr = addr_in->ma.err_addr;
 		addr_in->addr_type = TA_RAS_MCA_TO_PA;
@@ -206,7 +206,6 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		}
 
 		bank = paddr_out->pa.bank;
-		channel_index = paddr_out->pa.channel_idx;
 		/* no need to care about umc inst if addr_in is NULL */
 		umc_inst = addr_in->ma.umc_inst;
 	}
@@ -228,6 +227,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	}
 
 	soc_pa = paddr_out->pa.pa;
+	channel_index = paddr_out->pa.channel_idx;
 	/* clear loop bits in soc physical address */
 	for (i = 0; i < UMC_V12_0_RETIRE_LOOP_BITS; i++)
 		soc_pa &= ~BIT_ULL(loop_bits[i]);
@@ -466,6 +466,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
 	uint64_t err_addr, pa_addr = 0;
 	struct ras_ecc_err *ecc_err;
+	struct ta_ras_query_address_output addr_out;
 	int count, ret, i;
 
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
@@ -495,7 +496,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	ret = amdgpu_umc_mca_to_addr(adev,
 			err_addr, MCA_IPID_2_UMC_CH(ipid),
 			MCA_IPID_2_UMC_INST(ipid), MCA_IPID_2_DIE_ID(ipid),
-			MCA_IPID_2_SOCKET_ID(ipid), &pa_addr, true);
+			MCA_IPID_2_SOCKET_ID(ipid), &addr_out, true);
 	if (ret)
 		return ret;
 
@@ -503,10 +504,12 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	if (!ecc_err)
 		return -ENOMEM;
 
+	pa_addr = addr_out.pa.pa;
 	ecc_err->status = status;
 	ecc_err->ipid = ipid;
 	ecc_err->addr = addr;
 	ecc_err->pa_pfn = pa_addr >> AMDGPU_GPU_PAGE_SHIFT;
+	ecc_err->channel_idx = addr_out.pa.channel_idx;
 
 	/* If converted pa_pfn is 0, use pa C4 pfn. */
 	if (!ecc_err->pa_pfn)
@@ -577,7 +580,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 		ret = amdgpu_umc_fill_error_record(err_data,
 				ecc_err->addr,
 				page_pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
-				MCA_IPID_2_UMC_CH(ecc_err->ipid),
+				ecc_err->channel_idx,
 				MCA_IPID_2_UMC_INST(ecc_err->ipid));
 		if (ret)
 			break;
-- 
2.34.1

