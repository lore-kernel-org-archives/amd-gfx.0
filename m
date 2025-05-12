Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAFEC3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 03:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC7B10E268;
	Mon, 12 May 2025 03:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mqpomQ3g";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD91810E268
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 03:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/LavplqMmoDLgDX6Zb/cYMH+EN+UasUMz+0mGUXNFw1bcw1IDmDX3jkN2uWvoOgmm5fqC2wOpWoWiekxmW4FkhzdjALD56o+NNMqQifYq77GMJjC//WQyanwMTUXMiIoB3l+klOEk9LWafeaea6oPO5D3cM3HjierpsdnwGWQZVdzrQoy96vxA3FDgqpBJH2JIQsXcZVYFNQ2Cu4nHfKoTNWyL08X8jCVOELR28vtnnDu3BognB7NuIHmceuJGsCduOwGNC2Xea7ldp2NPy7J7abaQdpBn3ZJzgkHG/XMsOgtWm9s/a1XLUTLZTm7Qrtm7FWtdOJixmADGpzvjgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZnPBqAm7PMsTdQ6UE0WAF6EwG+/Di7H47AEyvq9upk=;
 b=oE+tWS/cN+P1CTifoOlE8ucA4cOvBy9DkLtMfDuQIwJTUqTZK1fxTklC3T2IZa7ZsNyUnqLdfTnzISwCXSuvshO/Ze/Gx3FT9DT1adhuTNXVy3navAxgUYZi0IfxFXM+4ycWWxgSBzguEznlmL7lHyJM9zBhwQgJKmoHkCmewiB8wzsVPU3oxai+rijjYapFKQjAB1WZXM/HzhLy+OlsYr5f2kzy6BMrV0hOW55aO0QCaAyWApFzUqCrgvTSJDUBQXIQQ9Rq7gVgFPw5pyil0380ZaYZRW/bjo0s7mB/WAToIoa6U20UjPkBNR1tEBrDCtrRHMDPkObg7tKuJ2ffDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZnPBqAm7PMsTdQ6UE0WAF6EwG+/Di7H47AEyvq9upk=;
 b=mqpomQ3gXZN51sWUvnWqamEPfLYkr2EUpnkzZuUPpPebVgqsi6cxgIf+MXLWxXOnHqm4V08GmtzorQ2NzUsmtnWqEb1BHtaTYqIiTztYWm80kcflFbYVFE/mmIwwdn+2BRJLIoYjhxr4SNonPcoEUfu5z0Y07HC7uRI3joosCVI=
Received: from CH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:610:32::8)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 03:44:25 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::53) by CH0PR07CA0003.outlook.office365.com
 (2603:10b6:610:32::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Mon,
 12 May 2025 03:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 03:44:25 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 22:44:22 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Ahmad.Rehman@amd.com>, <Vignesh.Chander@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/jpeg: sriov support for jpeg_v5_0_1
Date: Mon, 12 May 2025 11:44:03 +0800
Message-ID: <20250512034403.381441-4-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512034403.381441-1-FangSheng.Huang@amd.com>
References: <20250512034403.381441-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f259b09-b33a-49fe-57cf-08dd91074a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b5M6YEZr5DSMYACThwd5gEkzJ+2/zq0i6HBFZoUEfufoi330fu6BJ81Ai8bF?=
 =?us-ascii?Q?Tiw1/42ufq4UCzx4W7spuUIzk+3dqsQGuXgp4o5mhhybGr9KXtw+H/Sq55OD?=
 =?us-ascii?Q?yBXMskxjbAXgGAE+mqFmDkhGy4WzE2ua+YxE8fohpnsl/JnVNyGUdpXDGel3?=
 =?us-ascii?Q?kCoHGkx7Nv3DDhYayPpi4xyOHRROzbDQ75vORD15WLxSWpVIpw9CLKVteF9D?=
 =?us-ascii?Q?DBIFJ3muUCYWoVpMeOM1bOelW6Wjg7M+lkcGcJxo+iAFFmRSCAbMll1uOq3/?=
 =?us-ascii?Q?SUHPHEPcR2v9nXL/BSt1o7cE8v7n3rWjkZ0rJlhYJO18ZggAAPz8oWIWUZNE?=
 =?us-ascii?Q?wCK/qP8mRMqxSKVo+rOcOWsMlhyC0cZPaZg3qWsqDRg/7IwQ1GcCf0afHh1B?=
 =?us-ascii?Q?cWycPcodjhfUTcVuALn77TYKZN/KkAaRQe3jJV2sbgEVOMv0lzDlygCO4C51?=
 =?us-ascii?Q?wUYiij34vMH2oakfKyH2U+7nHSBifA2syzGmbnZVPVLnsr47xhVyV7uL1lgL?=
 =?us-ascii?Q?DkdRTWf03UG94yjBEXNd6LlgmUSW9DGE/UQIrznbXqNNw0WX+7nVHd5rvbDr?=
 =?us-ascii?Q?P/ONBQUCh4gBZSnogi+VAFFoqdVqX9Q8U8i8OAFZFWBeenw+kj828PBNGENq?=
 =?us-ascii?Q?vG29O09KdMLEkRVGW9sbhvj93ogm5O/LnsMNIrLP+6UYAbmguJ7tO9Raek6B?=
 =?us-ascii?Q?VCYKQOnTcQfPTzuRuNiYt37yLV0FHPmeyjSN3z0kfCrcBYPjUEgLb444iS5S?=
 =?us-ascii?Q?WTyW11V8wNfTwks+jTKx8hfg9Ax8CIQ1fyhZVS4lp1wOwtqK8HS6Xh+5QUkh?=
 =?us-ascii?Q?pJDaT60uAQE/QOsm3U78n7qmBhoLBR+M2BY359P3UOGT6MwAKX+BX/o6dLnn?=
 =?us-ascii?Q?x7m7TAqmYcPYn8L55uXz1f6HTyxLqEFxH4a3aEkVv46oKFZqXUE1XMa+DxSw?=
 =?us-ascii?Q?qalxJXzOlbbf2DMyifTtEflddorx3D+q6DlpjTKR4RP6W6yNbywxVnXulNBi?=
 =?us-ascii?Q?JLcaSWCgp4oN56/bbQgDf2Su9G039zVNY5UAMz7wT3K1uJMFCmMhFeqjkX7i?=
 =?us-ascii?Q?Lu/6odHt1iQYJir0vlOZmDtShl+FwoTP6vz8+rUoUjWLs0o9UBnNtAHUT1QW?=
 =?us-ascii?Q?r/P36M0NshIji7JzzNYyOgZo0cvr19bkVL4GD1OwbDQuOWeoQB1gvq7M6HW/?=
 =?us-ascii?Q?Gk+DsJOWFxps6hL1r04HzTMkLP1AKRnGeqJcPR8ntj2X0aWTYo1CaHfQ9oS4?=
 =?us-ascii?Q?J/KYm7O9aj/L6+WVFuUUKpmFlVoW0ORNoP0zN9+wh6Z995EWgQ2hQk7jR811?=
 =?us-ascii?Q?rWiv+SpuFUAHIhW4o+BKKjg8oSMg4C9jPEa5mpmkoCrCxtKhKvMeRF8fnTRE?=
 =?us-ascii?Q?mFHm05FBysg7cUIv8vWqK79C+crTqIIh5rh0prss+AlTFyr1CTMj23vJH6XA?=
 =?us-ascii?Q?7BxiritbFExdNn473/zwVXxk+glwWDsQYKaS3WGMUKZhVLqLAfEvCpz5Bj1o?=
 =?us-ascii?Q?ruHErWq85dAgI0lZpx7wUIKpOVL1DrNhJmKnLbXW0NgqVuBsAWlRiXjBJw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 03:44:25.0432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f259b09-b33a-49fe-57cf-08dd91074a21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
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

initialization table handshake with mmsch

Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 142 +++++++++++++++++++++--
 1 file changed, 131 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 6f73033d78b5..cb94bd71300f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -28,11 +28,13 @@
 #include "soc15d.h"
 #include "jpeg_v4_0_3.h"
 #include "jpeg_v5_0_1.h"
+#include "mmsch_v5_0.h"
 
 #include "vcn/vcn_5_0_0_offset.h"
 #include "vcn/vcn_5_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
 
+static int jpeg_v5_0_1_start_sriov(struct amdgpu_device *adev);
 static void jpeg_v5_0_1_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -163,14 +165,9 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 					1 + j + 11 * jpeg_inst;
 			} else {
-				if (j < 4)
-					ring->doorbell_index =
-						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-						4 + j + 32 * jpeg_inst;
-				else
-					ring->doorbell_index =
-						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-						8 + j + 32 * jpeg_inst;
+				ring->doorbell_index =
+					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					2 + j + 32 * jpeg_inst;
 			}
 			sprintf(ring->name, "jpeg_dec_%d.%d", adev->jpeg.inst[i].aid_id, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
@@ -237,7 +234,10 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 	int i, j, r, jpeg_inst;
 
 	if (amdgpu_sriov_vf(adev)) {
-		/* jpeg_v5_0_1_start_sriov(adev); */
+		r = jpeg_v5_0_1_start_sriov(adev);
+		if (r)
+			return r;
+
 		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 				ring = &adev->jpeg.inst[i].ring_dec[j];
@@ -291,8 +291,10 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
-	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
-		ret = jpeg_v5_0_1_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+	if (!amdgpu_sriov_vf(adev)) {
+		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
+			ret = jpeg_v5_0_1_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+	}
 
 	return ret;
 }
@@ -422,6 +424,119 @@ static void jpeg_v5_0_1_init_jrbc(struct amdgpu_ring *ring)
 					 reg_offset);
 }
 
+static int jpeg_v5_0_1_start_sriov(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	uint64_t ctx_addr;
+	uint32_t param, resp, expected;
+	uint32_t tmp, timeout;
+
+	struct amdgpu_mm_table *table = &adev->virt.mm_table;
+	uint32_t *table_loc;
+	uint32_t table_size;
+	uint32_t size, size_dw, item_offset;
+	uint32_t init_status;
+	int i, j, jpeg_inst;
+
+	struct mmsch_v5_0_cmd_direct_write
+		direct_wt = { {0} };
+	struct mmsch_v5_0_cmd_end end = { {0} };
+	struct mmsch_v5_0_init_header header;
+
+	direct_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_WRITE;
+	end.cmd_header.command_type =
+		MMSCH_COMMAND__END;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		jpeg_inst = GET_INST(JPEG, i);
+
+		memset(&header, 0, sizeof(struct mmsch_v5_0_init_header));
+		header.version = MMSCH_VERSION;
+		header.total_size = sizeof(struct mmsch_v5_0_init_header) >> 2;
+
+		table_loc = (uint32_t *)table->cpu_addr;
+		table_loc += header.total_size;
+
+		item_offset = header.total_size;
+
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; j++) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			table_size = 0;
+
+			tmp = SOC15_REG_OFFSET(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW);
+			MMSCH_V5_0_INSERT_DIRECT_WT(tmp, lower_32_bits(ring->gpu_addr));
+			tmp = SOC15_REG_OFFSET(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH);
+			MMSCH_V5_0_INSERT_DIRECT_WT(tmp, upper_32_bits(ring->gpu_addr));
+			tmp = SOC15_REG_OFFSET(JPEG, 0, regUVD_JRBC_RB_SIZE);
+			MMSCH_V5_0_INSERT_DIRECT_WT(tmp, ring->ring_size / 4);
+
+			if (j < 5) {
+				header.mjpegdec0[j].table_offset = item_offset;
+				header.mjpegdec0[j].init_status = 0;
+				header.mjpegdec0[j].table_size = table_size;
+			} else {
+				header.mjpegdec1[j - 5].table_offset = item_offset;
+				header.mjpegdec1[j - 5].init_status = 0;
+				header.mjpegdec1[j - 5].table_size = table_size;
+			}
+			header.total_size += table_size;
+			item_offset += table_size;
+		}
+
+		MMSCH_V5_0_INSERT_END();
+
+		/* send init table to MMSCH */
+		size = sizeof(struct mmsch_v5_0_init_header);
+		table_loc = (uint32_t *)table->cpu_addr;
+		memcpy((void *)table_loc, &header, size);
+
+		ctx_addr = table->gpu_addr;
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
+
+		tmp = RREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_VMID);
+		tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+		tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_VMID, tmp);
+
+		size = header.total_size;
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_SIZE, size);
+
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_RESP, 0);
+
+		param = 0x00000001;
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_HOST, param);
+		tmp = 0;
+		timeout = 1000;
+		resp = 0;
+		expected = MMSCH_VF_MAILBOX_RESP__OK;
+		init_status =
+			((struct mmsch_v5_0_init_header *)(table_loc))->mjpegdec0[i].init_status;
+		while (resp != expected) {
+			resp = RREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_RESP);
+
+			if (resp != 0)
+				break;
+			udelay(10);
+			tmp = tmp + 10;
+			if (tmp >= timeout) {
+				DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+					" waiting for regMMSCH_VF_MAILBOX_RESP "\
+					"(expected=0x%08x, readback=0x%08x)\n",
+					tmp, expected, resp);
+				return -EBUSY;
+			}
+		}
+		if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE &&
+				init_status != MMSCH_VF_ENGINE_STATUS__PASS)
+			DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init status for jpeg: %x\n",
+					resp, init_status);
+
+	}
+	return 0;
+}
+
 /**
  * jpeg_v5_0_1_start - start JPEG block
  *
@@ -581,6 +696,11 @@ static int jpeg_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev)) {
+		adev->jpeg.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if (state == adev->jpeg.cur_state)
 		return 0;
 
-- 
2.34.1

