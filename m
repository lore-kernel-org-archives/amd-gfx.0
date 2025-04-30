Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFF2C3ABA9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 08:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1E710E705;
	Wed, 30 Apr 2025 08:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KRaYXk++";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F7210E6F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV0nFusM1/k5HaeopLVQqgr0kkm8h4GlYjgCMcOOaV8l7VgI05Peb0ftp1To0eiEohJ2n+2+xssq1G/U7ZTamJYbLh/S5a4MRdJOaqyTp7EX3owuDtSgKhY8G8jyqUQm3cPzpMbGALB11yqHWcaCfKo7oP0A/uAKexzPZWWWo87aLi/bXDGbJPNAYnR345omjHsGFYmaVrsLkd+3TF4dEGa9yV/WhMZRbB0d5Vq45kfYxDcsVWi6klzxcAFO5dYoU/PrDNz6Aijzb86Fgk0M0RisGkU0o+YIGN9I6AJ15AafUyqmMIihBlB5357Gh/1hWdLKKpohOgzoOP4nw5B9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xgon1pONBG6T1UjhlO9nzDw16y4ra9KBU1fsylqFw8=;
 b=BmV2PfvabE3HBuSDadg7ojhqP+I9B6RNR43nQviROat0qc1XZOlUG9AuLZcCc6Q3TxalK5xP9GNvh4hgjPRt/g0GDEiDKsALoJR5MfWeuoelsHOnVHq7fyG9vSNadyWhWveO+oLabcaucRgx6nxF8y9iT+jgOSMMcU6h9yfeLd9WiRdslz442uykmw+z4vIPc0jMwHx+ErEXaky6sk6FHkipQm9/CXfE+U0bkRhVWnJ2PudCDbFD2+CimFoLNzAXVFg1Laqgq6JbXjLztMl98+ujzFM/Gnlh3LWobwjAZJFsLY/Om91XmvtlzqL9PzTkFcY3rLieofm1d0gNnDIvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xgon1pONBG6T1UjhlO9nzDw16y4ra9KBU1fsylqFw8=;
 b=KRaYXk++NUGuMBPJIJT4pi/5nVwD2OFfpaOT7zliTuKEp8Kx0DywZ3ItISp+yQKagLAObadt9sE0Chq5ed3zKwGfNO/Qy0pX5AsA15SKyl7I4gEsdvXWsP9Zu2Vq42Uq6HmFyBiUwf73uMvIFq9JLdK/bmmhxHNvaBN4/Jtc/0U=
Received: from BY5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:1d0::26)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 08:26:06 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::94) by BY5PR04CA0016.outlook.office365.com
 (2603:10b6:a03:1d0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 08:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 08:26:06 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 03:26:04 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: implement get_retire_flip_bits for UMC v12
Date: Wed, 30 Apr 2025 16:25:47 +0800
Message-ID: <20250430082550.60109-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430082550.60109-1-tao.zhou1@amd.com>
References: <20250430082550.60109-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: c56cb866-aba1-4288-8556-08dd87c0a6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x2vOJJ07DdJNfQGYqiGTGu5gaSMRWeIV1GDzwD5NeeKDEzwa44LeNprFtgIG?=
 =?us-ascii?Q?TAMMA2IPAy5JFbFoc3+8eco0N679bjFQJnT+iMvcl561RxpqkSutycwhbIcO?=
 =?us-ascii?Q?SwexZK8eV1syhqwboDGNEbOa61t77XTHzd83SA4p1zQ7gUUbgUI0H6HVBqsn?=
 =?us-ascii?Q?ucMCAsRWp885QlB/lXAXK67bivDe42ZZDUXZq44wCUvKeLVabBvDqsipz1VH?=
 =?us-ascii?Q?fOs6NJV1VNy79FlB1DBbAP57ak6MefhQ9ENcYtw43GId63LvaZdpkLyqNuYY?=
 =?us-ascii?Q?zlBzg6FvZZA1vXLfc6w4xf4wGU62YZoYwLVsb7SojJhE9mThv1bGg4qVpNxK?=
 =?us-ascii?Q?Nx4n71piv3cIqay+ZcKQv9VeQDw/uYF5xRfok5rWiaKt24ulwYWuwzo3n5O3?=
 =?us-ascii?Q?iZCIENX9oqNk0I+o2188foYg6sL9wPtlMX1k/MiLh9qsBZIWeVUcYW8kd7gl?=
 =?us-ascii?Q?e+apFtp2HH5xbR0ZB47qlU1Lco47RYgqXCXuW7thEgSsV4IZttaj1GwLAwKZ?=
 =?us-ascii?Q?UVuy+dJ5tUm8sLsQ1nCnaYXreGWg06RjZVv6FoKuIZcHQIMnDc8zWRj3MK40?=
 =?us-ascii?Q?5S6PK/Een3R/fr2yThxkWQlQAGdLLT/fRlaG/ZX7MDVt5Ojk6q1S6A39w2vI?=
 =?us-ascii?Q?U87CFCv08mIIbmTZWODIAX7L41AtdpSgsATINHKMp8q1giMA0oElgA+bQDS3?=
 =?us-ascii?Q?zBH2pvAAFrrhMJyp5PAts2DfPBlUeYrB7EXfH8IT7nHT/MPLADTqSVLkwP2W?=
 =?us-ascii?Q?8MwkVNN4oU9ADsNXZ+x/ZrFAf73DLci0zxaHtDemXB+UIq7Xm/BXVyKu8/Us?=
 =?us-ascii?Q?lD+C1ikGJVe5+eHfcPYolOBNpx8ZkZzHhYm497ygB+uXdv7d8o9XHEhyrS1Y?=
 =?us-ascii?Q?McxihS88R/I/hLei2I0K57ROdRHc2xon338Y7XlLUwXJUlPa4ht94XDApIBW?=
 =?us-ascii?Q?7wthlur7URJKOgAOg9qj2bxbwUMkMDA1fRNFhv66501FfIST6S25FFUmeuFj?=
 =?us-ascii?Q?qXmnCf8M5psAPWQNFoanFcbAH9FpPEnXzUT41LFBxvkWizFWD4zTcesKg1F+?=
 =?us-ascii?Q?etSIgioG8kTOWZXRipcXc5Tp4PjVNkQ+tELYSjYsnSm1jeaXUzvR9myD+xj0?=
 =?us-ascii?Q?Vnln2MUi0rCUmSCJLuNAxufgcYe4G0bw3aYhf6ZVz+VFvXHU0I+NVIGEaOFE?=
 =?us-ascii?Q?ULXAlr7qq8iXMVcjxdVnPYC327UnX/ZwwPl9O+M4ZflhgG0Rjia359481C3Q?=
 =?us-ascii?Q?UjGhUldHw2n8fgWNn97ct3StwYtM0LwLblFysnPXHbRp3FQ0j8+GzRAnf2PM?=
 =?us-ascii?Q?n2+FGFMV1ya7tzoJZYhuaT/DZ8eDcwYibeoXIoNzFh1mTPIn/R7ZObLGqP0s?=
 =?us-ascii?Q?qKMOTxrDwvPV0RiYQAZfx2oyDg35I4vClN2WBXy0QT8vI4axyowpqPn0vB2j?=
 =?us-ascii?Q?ClNy50W/R9hUydPNyz7nAHrRQNTONyxrLeyzYDkYJQ3Am9W0oDBojIrmY9Hs?=
 =?us-ascii?Q?6SqriWg1obNlGrGGDfSfulxPiO73NJwyHJjx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:26:06.0221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56cb866-aba1-4288-8556-08dd87c0a6f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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

The RAS bad page retire flip bits can be set per vram type,
vram vendor and NPS mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  1 -
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 82 +++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  2 -
 3 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3caebe7c25a5..464015fc2012 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1504,7 +1504,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.node_inst_num /= UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V12_0_PER_CHANNEL_OFFSET;
-		adev->umc.retire_unit = UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
 		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 			adev->umc.ras = &umc_v12_0_ras;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 5201c106e369..05e3b34927c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -174,6 +174,49 @@ static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
 	umc_v12_0_reset_error_count(adev);
 }
 
+static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
+{
+	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
+	uint32_t vram_type = adev->gmc.vram_type;
+	struct amdgpu_umc_flip_bits *flip_bits = &(adev->umc.flip_bits);
+
+	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+
+	/* default setting */
+	flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
+	flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
+	flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
+	flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
+	flip_bits->bit_num = 4;
+
+	switch (vram_type) {
+	case AMDGPU_VRAM_TYPE_HBM:
+		/* other nps modes are taken as nps1 */
+		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+		}
+
+		if (nps == AMDGPU_NPS4_PARTITION_MODE) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+		}
+
+		break;
+	default:
+		dev_warn(adev->dev,
+			"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
+		break;
+	}
+
+	adev->umc.retire_unit = 0x1 << flip_bits->bit_num;
+}
+
 static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ras_err_data *err_data,
 					struct ta_ras_query_address_input *addr_in,
@@ -182,11 +225,10 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 {
 	uint32_t col, col_lower, row, row_lower, row_high, bank;
 	uint32_t channel_index = 0, umc_inst = 0;
-	uint32_t i, loop_bits[UMC_V12_0_RETIRE_LOOP_BITS];
+	uint32_t i, bit_num, retire_unit, *flip_bits;
 	uint64_t soc_pa, column, err_addr;
 	struct ta_ras_query_address_output addr_out_tmp;
 	struct ta_ras_query_address_output *paddr_out;
-	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	int ret = 0;
 
 	if (!addr_out)
@@ -211,34 +253,15 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		umc_inst = addr_in->ma.umc_inst;
 	}
 
-	loop_bits[0] = UMC_V12_0_PA_C2_BIT;
-	loop_bits[1] = UMC_V12_0_PA_C3_BIT;
-	loop_bits[2] = UMC_V12_0_PA_C4_BIT;
-	loop_bits[3] = UMC_V12_0_PA_R13_BIT;
-
-	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
-		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
-
-	/* other nps modes are taken as nps1 */
-	if (nps == AMDGPU_NPS2_PARTITION_MODE) {
-		loop_bits[0] = UMC_V12_0_PA_CH5_BIT;
-		loop_bits[1] = UMC_V12_0_PA_C2_BIT;
-		loop_bits[2] = UMC_V12_0_PA_B1_BIT;
-		loop_bits[3] = UMC_V12_0_PA_R12_BIT;
-	}
-
-	if (nps == AMDGPU_NPS4_PARTITION_MODE) {
-		loop_bits[0] = UMC_V12_0_PA_CH4_BIT;
-		loop_bits[1] = UMC_V12_0_PA_CH5_BIT;
-		loop_bits[2] = UMC_V12_0_PA_B0_BIT;
-		loop_bits[3] = UMC_V12_0_PA_R11_BIT;
-	}
+	flip_bits = adev->umc.flip_bits.flip_bits_in_pa;
+	bit_num = adev->umc.flip_bits.bit_num;
+	retire_unit = adev->umc.retire_unit;
 
 	soc_pa = paddr_out->pa.pa;
 	channel_index = paddr_out->pa.channel_idx;
 	/* clear loop bits in soc physical address */
-	for (i = 0; i < UMC_V12_0_RETIRE_LOOP_BITS; i++)
-		soc_pa &= ~BIT_ULL(loop_bits[i]);
+	for (i = 0; i < bit_num; i++)
+		soc_pa &= ~BIT_ULL(flip_bits[i]);
 
 	paddr_out->pa.pa = soc_pa;
 	/* get column bit 0 and 1 in mca address */
@@ -259,10 +282,10 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		goto out;
 
 	/* loop for all possibilities of retired bits */
-	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
+	for (column = 0; column < retire_unit; column++) {
 		soc_pa = paddr_out->pa.pa;
-		for (i = 0; i < UMC_V12_0_RETIRE_LOOP_BITS; i++)
-			soc_pa |= (((column >> i) & 0x1ULL) << loop_bits[i]);
+		for (i = 0; i < bit_num; i++)
+			soc_pa |= (((column >> i) & 0x1ULL) << flip_bits[i]);
 
 		col = ((column & 0x7) << 2) | col_lower;
 		/* add row bit 13 */
@@ -684,5 +707,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.update_ecc_status = umc_v12_0_update_ecc_status,
 	.convert_ras_err_addr = umc_v12_0_convert_error_address,
 	.get_die_id_from_pa = umc_v12_0_get_die_id,
+	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 056bbc038312..ccdd6cd430f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -55,8 +55,6 @@
 #define UMC_V12_0_NA_MAP_PA_NUM        8
 /* R13 bit shift should be considered, double the number */
 #define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
-/* C2, C3, C4, R13, four bits in MCA address are looped in retirement */
-#define UMC_V12_0_RETIRE_LOOP_BITS 4
 
 /* column bits in SOC physical address */
 #define UMC_V12_0_PA_C2_BIT 15
-- 
2.34.1

