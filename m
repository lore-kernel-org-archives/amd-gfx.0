Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E2BD3748B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065BC10E845;
	Thu, 17 Oct 2024 13:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P6hrLUnj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F3710E828
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY3+N2buMI7V7T+cENrLc1Bpe2DHRyonaEr/N1Knyz1Sr41+3oI5fAczxsmUfT4lmB/dZhq2RIfQmKrrmV7fUH+LvBjB5h7G+eNt5aj/Rg9p0/XG4JSmvG7deFcWAcY5qucrbzGYAAcX6KqyoiY8wXgPhYQokz+fCf8eaYk6iyverg0wRC8JJPGfqgeRKo+GYTjaW0O+wFrGhM/Lh8ep8R8he7y9KtD2zkq8c4x8eu5yPRH0+GaL2CgPjZBSF8+fYSiBojUQ7plui4zViQBOK9utXZscD3PszDcpVmWOzQFRaVdX4hZtcbrAJh+ePOxx6+Kesv6dI9iVaHca8NCT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T80VrH5rpnP7x7rs6EtCJpqfi57qCile3WYB90KaJq8=;
 b=bcn5Xz/xOK3qOploNXEEGPkZbobVLBbpKbHYJRnPdKBtYMeEMHHPfB1MS+TJS1393UQX8CXpeu90KYiciNpQA/AXbyhwjvmOs47vNYXWgqru8IeEy+lgLbmY06CL8O16H6mux3vJZNayjNOkiH059NU/ZYWn0eWtMxxFGWSOk8sSKuCoNpf2lShhvR/BywAWcsJX3acb80JIpywhHWaXvHT7ncsWW0nM22hxtm7I0SWjMui/ymqW3f64tikGJkRrqouoYo2I+wLs6s5qc7cTPdtS6T4+e5jxTBJQcgSn1qM3aYbhWetFiB7xlxWLzgUbK6XODJGNqn9+j/n9ga/VLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T80VrH5rpnP7x7rs6EtCJpqfi57qCile3WYB90KaJq8=;
 b=P6hrLUnjaZENAHz+7G26h8Z1NiAdX1jWpUuUmNepOTTN3JFHlQmFwkWo0nRPiBUU1zKmifxd944ifT46erDJhoxjL4N1ttNhzUFZgg4L4ZqMnwdseT96omKcqMDe+7w40Kk2leUXiM2VGdduJU718ubSJkBNuHbEiRN8ODDFcGY=
Received: from BN9PR03CA0455.namprd03.prod.outlook.com (2603:10b6:408:139::10)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 13:21:36 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::98) by BN9PR03CA0455.outlook.office365.com
 (2603:10b6:408:139::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:36 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:32 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 28/32] drm/amdgpu: print_ip_state for each vcn instance
Date: Thu, 17 Oct 2024 09:20:49 -0400
Message-ID: <20241017132053.53214-29-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: cf579649-3f01-4739-05da-08dceeaea055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zEVthoTm7bnPfrH/G5KZz1/xxd5KiMyVRhF6nz9515ytlTA7jAEK4zD8xDlT?=
 =?us-ascii?Q?YJ/gZtlWVDWaEBEyAzuNL8H8QdmIJuPkjmwcXsctrcw/fdb4FdCzPefWFNFM?=
 =?us-ascii?Q?WP5H9MV0IesGfaDCbGWp6flCwtud61eMETxq0lwsgSaxH2Znu5EgmNcfIwAz?=
 =?us-ascii?Q?z7rqd1bS6HV08iJGNHgidKXYrQONbi1a5qRYKu55jm/tO416WU9HKsHjtuN6?=
 =?us-ascii?Q?Hio6L8/ISawa12KxGhCarEHlARQ4c46osa6VEhqeD4lz0696AshOYYYohB03?=
 =?us-ascii?Q?u0zRsNlafwbETzQpwntB63jcad2nkXrrXVEjRCM97Efi35gBiG2Vb9VIIpTX?=
 =?us-ascii?Q?F80DLiDKgOgZZ90Gv4iQxaB978aMpgarrIj6xgXFEYX8DIUOYaQLeo7te082?=
 =?us-ascii?Q?UXtbkoGT6n+sCkE8QPjn/NmgKa+2+d6PyKo2B6UCaiVzQi+7jrnR8u/Pn5D4?=
 =?us-ascii?Q?ax2RDnbXh3EOCb8e+wUSdf/YyWf5fRnjiKh6Ztwo6ou+/2r6nV/NQS+m/k96?=
 =?us-ascii?Q?Y4N/UuBTNlJQb7EGfleX5dyIkmAG2VGyzIEF9if5I/naULW/4V0Eop6q+ekY?=
 =?us-ascii?Q?bBoztsmXdbgWyXSGnIUrUWTnrTjmf1M0cCI/QXZPsxcqYP03UkBV8mka15Yp?=
 =?us-ascii?Q?h+6J45WmHnvplREOcvjgtL3rZIj7VPbztcHhJbRbEXpnm5faKh6C92Mtda7f?=
 =?us-ascii?Q?x2JFOfJEEt3/Fe7XEhNDcp0kb6GqMplrKzfFlsHV48GAUFAt7rDmsl9VwFR8?=
 =?us-ascii?Q?a1Wu96H1mxACwMfsqeIt6Aoio77vkKme0oHmbYxO5q1IouCdMkzj5o1Vhq8H?=
 =?us-ascii?Q?uvkX04qIoXMV7Erv3SHRIOuVvGMlsUQUhPpJKmEfv9kTevA5QSKoC4gaSNdb?=
 =?us-ascii?Q?8Bt6Sg1wFakAx5h6HR4HKbXLXvNgK2/xcHS+ubROr6zLG7wnFR7YJlXznh8I?=
 =?us-ascii?Q?EDpj66I163TIUOh1iJQqsFnp+9ocMnY6/cp2dj+lEVB4PYCoce3x1rFWFqau?=
 =?us-ascii?Q?j0K5uc0aiXMrYtZJbCCy5yCiEhGds8tUnoE3UTTwvPYXlljcJiequCKqwTxe?=
 =?us-ascii?Q?M/dQTKA1VxiItA3xdavZ0nKgO0mc0YFu/W4t7bF7EzhdQ1T7wwA++Pg+IAfU?=
 =?us-ascii?Q?icLTBEIUlXaTZdSWgcyPmOnwYGEzcKe+kQG/H2MZsdh47HTRGeJxTMp+6U0t?=
 =?us-ascii?Q?ixlC9Hi87E3axJVqIMuy6Cvrye/dFxAoOOkfEXQkZIDEp+6dGYUY+fzyy20G?=
 =?us-ascii?Q?YiuL7tXTrRL1snthqyRGwFEvuKdgBpIQ7oxgDp0G2E6zSHcVaDFIZEdGPn/5?=
 =?us-ascii?Q?+L0aaOtuW5akxR30VjbztCTRHaZNCtxBFm000KL+6EYPuLKcoWky6x5Fjgkp?=
 =?us-ascii?Q?pGmdaMnIlmo42UP7WUsukPdJXvvdzMPUvPMZJQrGHYDzv59hqQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:36.0789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf579649-3f01-4739-05da-08dceeaea055
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Perform print_ip_state only for the instance of the current vcn IP block,
instead of perform it for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 33 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 33 ++++++++++++-------------
 8 files changed, 128 insertions(+), 136 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index ab06c4173b66..9255bcfc6c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1933,7 +1933,8 @@ void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
 static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
 	uint32_t inst_off, is_powered;
 
@@ -1941,24 +1942,22 @@ static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i)) {
-			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << inst)) {
+		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, "\nActive Instance:VCN%d\n", i);
-			for (j = 0; j < reg_count; j++)
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_1_0[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
+	if (is_powered) {
+		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
+		for (j = 0; j < reg_count; j++)
+			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_1_0[j].reg_name,
+				   adev->vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 59c6458c99af..94f000ed4895 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2041,7 +2041,8 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
 	uint32_t inst_off, is_powered;
 
@@ -2049,24 +2050,22 @@ static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i)) {
-			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << inst)) {
+		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, "\nActive Instance:VCN%d\n", i);
-			for (j = 0; j < reg_count; j++)
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_0[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
+	if (is_powered) {
+		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
+		for (j = 0; j < reg_count; j++)
+			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_0[j].reg_name,
+				   adev->vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b0d14330722b..7c9a0169215e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1915,7 +1915,8 @@ static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t inst_off, is_powered;
 
@@ -1923,24 +1924,22 @@ static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i)) {
-			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << inst)) {
+		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, "\nActive Instance:VCN%d\n", i);
-			for (j = 0; j < reg_count; j++)
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_5[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
+	if (is_powered) {
+		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
+		for (j = 0; j < reg_count; j++)
+			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_5[j].reg_name,
+				   adev->vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9a9acec4c4ce..061c958700d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2237,7 +2237,8 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t inst_off;
 	bool is_powered;
@@ -2246,24 +2247,22 @@ static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i)) {
-			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << inst)) {
+		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, "\nActive Instance:VCN%d\n", i);
-			for (j = 0; j < reg_count; j++)
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_3_0[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
+	if (is_powered) {
+		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
+		for (j = 0; j < reg_count; j++)
+			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_3_0[j].reg_name,
+				   adev->vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ff256fb4d054..fdf346bf3e34 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2146,7 +2146,8 @@ static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t inst_off, is_powered;
 
@@ -2154,24 +2155,22 @@ static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i)) {
-			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << inst)) {
+		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, "\nActive Instance:VCN%d\n", i);
-			for (j = 0; j < reg_count; j++)
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
+	if (is_powered) {
+		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
+		for (j = 0; j < reg_count; j++)
+			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0[j].reg_name,
+				   adev->vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 544c96e082b9..daaf2fb6b3e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1726,7 +1726,8 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
 	uint32_t inst_off, is_powered;
 
@@ -1734,24 +1735,22 @@ static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
 		return;
 
 	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i)) {
-			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << inst)) {
+		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, "\nActive Instance:VCN%d\n", i);
-			for (j = 0; j < reg_count; j++)
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_3[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
+	if (is_powered) {
+		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
+		for (j = 0; j < reg_count; j++)
+			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_3[j].reg_name,
+				   adev->vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 880353f75296..ff8db22b9614 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1607,7 +1607,8 @@ static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t inst_off, is_powered;
 
@@ -1615,24 +1616,22 @@ static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
 		return;
 
 	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i)) {
-			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << inst)) {
+		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, "\nActive Instance:VCN%d\n", i);
-			for (j = 0; j < reg_count; j++)
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_5[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
+	if (is_powered) {
+		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
+		for (j = 0; j < reg_count; j++)
+			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_5[j].reg_name,
+				   adev->vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a4d1b9a086b2..c83a5c09f410 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1334,7 +1334,8 @@ static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
 static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
 	uint32_t inst_off, is_powered;
 
@@ -1342,24 +1343,22 @@ static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 		return;
 
 	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i)) {
-			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << inst)) {
+		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
+		return;
+	}
 
-		inst_off = i * reg_count;
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered) {
-			drm_printf(p, "\nActive Instance:VCN%d\n", i);
-			for (j = 0; j < reg_count; j++)
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_5_0[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
+	if (is_powered) {
+		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
+		for (j = 0; j < reg_count; j++)
+			drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_5_0[j].reg_name,
+				   adev->vcn.ip_dump[inst_off + j]);
+	} else {
+		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
 	}
 }
 
-- 
2.34.1

