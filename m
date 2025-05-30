Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2179AC5B552
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31A510E81C;
	Fri, 30 May 2025 09:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="si13lAic";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6051010E82F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLvi5p+mEK+l1N9SlIuarTMUyHnSTnqVlC4kDK4K/xNHf8e1BxlKadO0IwMNXITTFlh4H9MzBDLyMBL2GvLdoFyXGALMsBMJkXvUQ3akZb/TxsqDuSURyj+oP0+zZe15izNbLb+UxbQbeuvbKQc32Ep6hmWz7iKE6IRWHnlkStVe9Re7nWFllHRVj/kNN8q2gkMeFR+JAkh/+EzCXw4Sb2ibHHvhGqu3R5Duc/iujYzsPf1Vt8uyjsA85g6AFS5iqbxbQuJm/UuYvm7Mh1UoS6q7S1u2MqLomoPkl5m74mS+wCrQFy4prmLKS8rxZ7hfTErpkaBf0M+xl0qFe8/ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZXK3VJTLbX1xorGm5OwIRv1zAoYnlCD0GtMJmCvPIE=;
 b=OxXKjv1SCEqSN7/T6/3Z/tOTjwuJCXI6qA3Xes9dMATzKNTX9ysC51pa1WdRETAIrOBfXc03b6vGhaadc6/DanCTk51UpLft6oemgCpznAekkmCz7JA7yZR5X0zM9RBJjXC58VhcoSoeHpaFEfnCyrMWZOaBlvdCw/5sgVpq1FD4gZICrPbqYH59QMLl7jLibAyPuwrKuB+CaJ8SQReWgR6950dQDtTkW3E0fmR2MIKJBT8FncBCVnPyWeKeoMUcUX/cpq/uD5jjez2SdeUq0lFXa8sqt+mJ+HzxzbqLYo46vuaayqhMuVDJACBYzTR8RNIJEwEPJfulDQmSxcBlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZXK3VJTLbX1xorGm5OwIRv1zAoYnlCD0GtMJmCvPIE=;
 b=si13lAicKvakZYnDu2Q2wcNVgH2R+Zy9ipN8k/4+AwuTC9z4jGGTHHLyqaQdKn1rKU43HeUA7sv7sqpzDVB37p7eCQyTedzHZkTnaHXsVp1pfg66seSuNSGdpa9z0TpjjSN9PW7dcH72fwsMNGYOrRm37j/UF7zNUe4H8cubsFw=
Received: from BL0PR0102CA0053.prod.exchangelabs.com (2603:10b6:208:25::30) by
 SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 30 May
 2025 09:04:26 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::f5) by BL0PR0102CA0053.outlook.office365.com
 (2603:10b6:208:25::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Fri,
 30 May 2025 09:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:04:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:25 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:04:24 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 10/14] drm/amdgpu: Implement active VMID detection in MES
 queue reset for GFX
Date: Fri, 30 May 2025 17:00:11 +0800
Message-ID: <20250530090322.3589364-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f21a9eb-ddab-4fc1-e277-08dd9f58fa6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eQXji1nFNx0NGg1GOJsaf02yWeQWjwmlKa2v/mhPFCfQWNu6gZLevm5cFt3+?=
 =?us-ascii?Q?XrmGLrnsBHt17ea5lo50QU+M3XdkbfumW8BLsMjXH+edQPhPwgExXKkH8YRm?=
 =?us-ascii?Q?wbyS6wuP0uziU2X4nQVx8OfVSqN/iPn/9btZd4W6meJl6wrhUyaN9XoZq1/O?=
 =?us-ascii?Q?oNkR4IWt0BS0tqG03zR3Na4JfgUxa4IF1R49X+OozvXo5/aPkFQ5UzBbmXg9?=
 =?us-ascii?Q?ZW2CAHotNDcSuaM7/Pz5wVR8FhZXk8YyespXOks5O1qYgJeh1o0R/URR9kbJ?=
 =?us-ascii?Q?iguoMj9m8JLv6QWUc9qVxJImOkKO8aYSn4u/YvD3TGTvZqFHMYuOIFykbDJZ?=
 =?us-ascii?Q?Jzj+CYUtRsLeS++7mzjqzpy8lpGqSIb/cmYi04D41XB+NEBBT7iuuXXwwTqH?=
 =?us-ascii?Q?pNn19KIFeYL8BivKUDaoX1K9A80D1/nFiXArgwg/uoHXxB5AvP8tpOQPd+wr?=
 =?us-ascii?Q?Xr1wWsX+fb65c/gVB5ug4x1BO4X1MgTOCcZQzRNaygQGKQM4YwbMR0JXOJWd?=
 =?us-ascii?Q?9rLoxl/vz2lhuqo+yCB+jPs10PZPseSwadSpmZEzV35422ZVpXYZ0SGtDBNd?=
 =?us-ascii?Q?l1dvBYLjOllzbMwSuLb9a6TOneDBtGo944IvjguBA5nwFPC7TaS1S0Ibd3/7?=
 =?us-ascii?Q?B+QsL86222M8rf1ui+PsC06USlkov8s8EbiBbbKJC94ZQKvKyw1KeZlIcbpw?=
 =?us-ascii?Q?gWwFi1pvIwWUtUPEZjmx4XSp6lVDplhDNRpiNlRvqt4pvsiXAuxmS02HBo/5?=
 =?us-ascii?Q?3c/LtZmjl7hycBH/tAT+uOYfjnNF0cvZlLBHhDghPYeI8zBkid/bABjCEj7Q?=
 =?us-ascii?Q?197o53WKjjaXiDAT69M9JK4QA45Dc9g7ZqdzxzPu6VMKH0ji+TiGmtYtMDnN?=
 =?us-ascii?Q?6oAkrfozMb4udDNOJMk3LkJ+Hoe/usfTlmiDwmfkYTueSR/sj4D8i2cWDKAI?=
 =?us-ascii?Q?jaDoWevyxNuqNFQ48TSlHPaQwBEZ0+xo5DRYtoA9oWvzYCXVOWMLAMuiWAHs?=
 =?us-ascii?Q?y5IFEVjauBM+twfuU+a5eIiFagSDEBNHul9SB73lethzqbxC9+aHo1T+wA32?=
 =?us-ascii?Q?5MWcoyp6bWxh0MZU4Kz+dv2B01xythlNoK12VmWK2V/1KqzIPU7FAg+BSVci?=
 =?us-ascii?Q?h2lVwolL4I8s2VmDCxixtZE7XZuHnRSpAVTQZET9QT1Go+xrkd7HkfoxXQhz?=
 =?us-ascii?Q?AZhg3rv8TJ4CsUDKz8tGpULQDojo6pSrqjTs9bi3ZOE3r5nZWcHJiAdq3JoR?=
 =?us-ascii?Q?VvLleTKbajhCHIsMT6iMjMdFG0iK7FTgwPtpPfhqTvK1bAAlhCsExR+7yPIV?=
 =?us-ascii?Q?nbf0gBSEDJhrsqfpt8RFohaR+r4PIlrlBbZSTg0NgPEbAQSSxi2lzLdyOaV0?=
 =?us-ascii?Q?ofC1abh3Zb6gkjFZIEImxigNXOxQG1zXLonWRCAGjzKlr7nXx6p0/7pQ0nVb?=
 =?us-ascii?Q?dvr00UGwVN2KHI0UxFR8uGqgPS/W+fUR9jkw0Y1zQWKZjmBADl/gcS1I+gmm?=
 =?us-ascii?Q?cB1Lu8+TUFtqYu9hv+RlM46udmz+WLxSpSeL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:04:26.3550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f21a9eb-ddab-4fc1-e277-08dd9f58fa6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
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

MES queue reset functionality for GFX queues. The changes include:

1. Added detection of active VMIDs by reading CP_CNTX_STAT and CP_VMID
   registers to properly identify contexts that need resetting

2. Implemented fallback to HPD status method when no active VMIDs are
   found, checking both pipe 0 and pipe 1 queues

3. Extended the MES reset packet with:
   - active_vmids bitmap
   - connected_queue_index for pipe 0
   - connected_queue_index_p1 for pipe 1

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index f763f91ff9d7..86d51614f207 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -840,6 +840,12 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 				    struct mes_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t active_vmids = 0;
+	uint32_t connected_queue_index = 0;
+	uint32_t queue_status = 0;
+	uint32_t connected_queue_index_p1 = 0;
+	uint32_t queue_status_p1 = 0;
 	int pipe;
 
 	if (input->use_mmio)
@@ -856,6 +862,52 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 	mes_reset_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 
+	/* Add VMID detection for GFX queues */
+	if (input->queue_type == AMDGPU_RING_TYPE_GFX &&
+		input->hang_detect_then_reset) {
+		uint32_t cp_cntx_stat = RREG32_SOC15(GC, 0, regCP_CNTX_STAT);
+		uint32_t cp_vmid, grbm_gfx_cntl;
+
+		/* Check active contexts in CP_CNTX_STAT */
+		for (uint32_t i = 0; i < 8; i++) {
+			if ((cp_cntx_stat >> (0x14 + i)) & 0x1) {
+				grbm_gfx_cntl = (i << 11);
+				WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, grbm_gfx_cntl);
+				cp_vmid = RREG32_SOC15(GC, 0, regCP_CP_VMID);
+				active_vmids |= (1 << cp_vmid);
+			}
+		}
+
+		/* Fallback to HPD status if no active VMIDs found */
+		if (active_vmids == 0) {
+			uint32_t hpd_status;
+
+			/* Pipe 0 */
+			WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, 0);
+			hpd_status = RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
+			queue_status = hpd_status & 0x1F;
+			connected_queue_index = (hpd_status & 0xE0) >> 5;
+
+			/* Pipe 1 */
+			WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, (1 << 6));
+			hpd_status = RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
+			queue_status_p1 = hpd_status & 0x1F;
+			connected_queue_index_p1 = (hpd_status & 0xE0) >> 5;
+		}
+
+		mes_reset_queue_pkt.active_vmids = active_vmids;
+		if (active_vmids == 0) {
+			if (queue_status != 0) {
+				mes_reset_queue_pkt.use_connected_queue_index = 1;
+				mes_reset_queue_pkt.connected_queue_index = connected_queue_index;
+			}
+			if (queue_status_p1 != 0) {
+				mes_reset_queue_pkt.use_connected_queue_index_p1 = 1;
+				mes_reset_queue_pkt.connected_queue_index_p1 = connected_queue_index_p1;
+			}
+		}
+	}
+
 	if (input->legacy_gfx) {
 		mes_reset_queue_pkt.reset_legacy_gfx = 1;
 		mes_reset_queue_pkt.pipe_id_lp = input->pipe_id;
-- 
2.49.0

