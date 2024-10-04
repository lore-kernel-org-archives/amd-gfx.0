Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379ABCF8859
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4AB10EA94;
	Fri,  4 Oct 2024 18:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dibyeRFO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 076CA10EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMoB2Uh1Ar1hJayEHYnI+4FobAeiO5eFZy+ARWc4xXO6ehg86hlnzgWop8m/7szfmZTiTXzSWzOab936qsmokAwsWms7oZg7dnTBjvT/FPjp4yGlyBv6SUmEFL2PXV0w4qv+QtlaTaF8IUqAVvIvW2Xl+RHlBNY932GOyTX3RSCfwqt7JXJb3z4lwC7zyeKldIEDW188cUk4QlHugxEOZyvqSMJw0cZjfVrMKDSImRklgciiAr5GdHb3jBJ5ZBIHedlH3gK1tkc9W9vHuKfD/4hXe/9PFzQJket6NMHbjfB7pie88sFNT7+RyX/b+TDYDEVB4whyMoPXE3YOiRe6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdB4uKIGPV+on6wvn6SPgprD5MD2d1wNMCEGSERxE2I=;
 b=HZ84nw/TmYBkbXkGZTE0pgjvAKdqmLnmXK/cBcfRW0qG4JPf60zMx2f1LVC57lF7JAz8wUoZSs80D6UWLQAEiSnckxsgEE/yb6QlI8E7V/crIgRe5Fm9yuFWzeviGdCbRaap53dpM8Ulm9kW+uXn49x09/Urlox1/jvg+74cf3FA7Stmc9+uNeiwz0E2aMAwWxhkxWyvU0GjXMKavBBl2f6PCjxq20NI1bigz7gNRcurwHdYv9HVlZN79kbK6FtR8nhKO3fkUEOJFPqBR1llvFvvUof3dmXVNIaSoV1DA2G0K4ZYJVsCGWeFVL4K1hibZROy6seFfTw+o4Vma2l+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdB4uKIGPV+on6wvn6SPgprD5MD2d1wNMCEGSERxE2I=;
 b=dibyeRFO44CZpa7ldhyW0REW76tN5pKW7y8JksfXplhW2sxKX4H6i46qpLz4bz2B4t7IJ3oyNp6li3trK28fMiIX5uJCFVpx17+j6K48rOsd16KD4vtI58gfyJCxNOzaI2MLuwP7ZmhywPhvJRJUpTbZWTRtqEMWJ8BWtp3M6Y8=
Received: from BN9PR03CA0630.namprd03.prod.outlook.com (2603:10b6:408:106::35)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:45:08 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::d3) by BN9PR03CA0630.outlook.office365.com
 (2603:10b6:408:106::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:07 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:45:04 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 11/18] drm/amdgpu: power vcn 2_5 by instance
Date: Fri, 4 Oct 2024 14:44:37 -0400
Message-ID: <20241004184444.435356-12-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e8181d-6406-45a6-699b-08dce4a4ab1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LHOBLQ4wtwPRurjjjyLtVamkInjgNYj7uKANYrXCv0mG5KStoSjMFAYs2X/J?=
 =?us-ascii?Q?Lx5I9/bEqCbcPnJd2kl6raj6F/wIff4DeJOR7++gLZztSaOym6TF7Pl2xWh9?=
 =?us-ascii?Q?SdAo/cywFzVkIEJBXTamwHzf965U/frOI0KCb6vaYkCkGvJZxt6q3vB9zaLH?=
 =?us-ascii?Q?a3db7Mnl1WHTm4ns+v6cOKBiVBPbstHOgJSZxDobxYVGHYDPkGi8d2Blzdcm?=
 =?us-ascii?Q?hQobJvIcv6jZdSI/bi8RwEc3/om3s6ybyk2szLuqAwicJjzyGrAZvWnMKFd4?=
 =?us-ascii?Q?JannrcMiGnJ7NwW3K886tM0JqTgdj+faxUOxAKMruC8NM6xgJNpb0kB9oaOJ?=
 =?us-ascii?Q?AaoKM4V9gYtQ+vxOg3M7fJSO/KGjG+yX0Voh5k3JKNzLOrSp1ftTnGnk//Fq?=
 =?us-ascii?Q?lG0tBDpNwORGRqFZif8n4mDmeP7OMb+7IHp3ZCmFpnj20GK+gnhZbqsfA2g5?=
 =?us-ascii?Q?3g1RHNDLaaCDhOt73LsTdQDnEDVACdsuJAgr55QVchJzB1mTVWg390EoCe6u?=
 =?us-ascii?Q?/yxBMfLXtUcjkoiKbVD7vR7OZBaVryjpVMSokWNWFMhn5a+zCi+PAMd/IEQ8?=
 =?us-ascii?Q?P5jFNJPN6osoqvSsYUdzlYFvJsK2OksYXnpOi7TGkYrMUP9cNeo4BqvdQxxD?=
 =?us-ascii?Q?Bt7ITPNaXpZQGHBEO6gJkh2fsCDC4d3Ag3cfO9qsWH9VYpn9EJV9SU9JWYu+?=
 =?us-ascii?Q?qMfMiQZ4NRncNPj+hsFjKnhagzgeeXSty+sg7sAWQB1lMgkupTjiaEUuSYBz?=
 =?us-ascii?Q?Tlaicg0QcQr5/XcvqRcfNah56OH3EufbpFNpuC6Af0Ip6gLOozASywvYQ9Qq?=
 =?us-ascii?Q?ZASVsYjeRTejxnf/cjbweNhb8XtTg/aMdIgvOKBpKBUBkguEYu1jQzQVrtli?=
 =?us-ascii?Q?wFQn257nzl0oSUN88q2OKvex+mwFX72u0+5VBI2cNHgDkQYd20KZqtQ+Shxq?=
 =?us-ascii?Q?u29WfyA9K9lXzC97i7Y2ZZsJTjXVYH8We9YeRoQsWZZBD+JJYmUKxW1ro+g8?=
 =?us-ascii?Q?6DuJazLiCMxK47owolKDGSYysQcDoME6FioaapxJOfREv1zCRHaTA0Psyyzv?=
 =?us-ascii?Q?fL6jfAUusfj0yqiOn1M3LrQwmrXwq5JHiqp6AfXi7c4IIC00Jd7i8N6i6R/2?=
 =?us-ascii?Q?BmSV07TOZxvclZUODJmm+EyByEvn8XWPc3+STtnoxknYP4iHvT3igz49i+8s?=
 =?us-ascii?Q?7lqAX0U40NLOfwGucACjyZGzZhI6WpaoDxil7VR8of5j/QlxgmFRWJio+uJA?=
 =?us-ascii?Q?bmsx37zUs3tFuOhxA8r2qAd0B4rx9MgI5zeWv7GbYfuwwoYbLWRvw1qrp0u1?=
 =?us-ascii?Q?dssci/3ykeT2n8GmDiSTHDjKJt9EHQ8tSPX9RBbbPxF/EdpTBjg3eswf5Zzq?=
 =?us-ascii?Q?Qbuw6AZTHzqjDbV62muEhJz/ip6z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:07.5340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e8181d-6406-45a6-699b-08dce4a4ab1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
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

For vcn 2_5, add ip_block for each vcn instance during discovery stage.

And only powering on/off one of the vcn instance using the
instance value stored in ip_block, instead of powering on/off all
vcn instances. Modify the existing functions to use the instance value
in ip_block, and remove the original for loop for all vcn instances.

v2: rename "i"/"j" to "inst" for instance value.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 565 +++++++++---------
 2 files changed, 280 insertions(+), 289 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9f9a1867da72..de1053cc2a2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2278,6 +2278,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 
 static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 {
+	int i;
 	if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
 		switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
 		case IP_VERSION(7, 0, 0):
@@ -2321,7 +2322,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(2, 0, 3):
 			break;
 		case IP_VERSION(2, 5, 0):
-			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
+			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+				amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
 			break;
 		case IP_VERSION(2, 6, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d00df51bc400..1f8738ae360a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -158,35 +158,34 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	int i, j, r;
+	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t *ptr;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
-		/* VCN DEC TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
-				VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[j].irq);
-		if (r)
-			return r;
-
-		/* VCN ENC TRAP */
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
-				i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[j].irq);
-			if (r)
-				return r;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto sw_init;
+	/* VCN DEC TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[inst].irq);
+	if (r)
+		return r;
 
-		/* VCN POISON TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
-			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].ras_poison_irq);
+	/* VCN ENC TRAP */
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
 		if (r)
 			return r;
 	}
 
+	/* VCN POISON TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+		VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[inst].ras_poison_irq);
+	if (r)
+		return r;
+sw_init:
 	r = amdgpu_vcn_sw_init(adev);
 	if (r)
 		return r;
@@ -197,76 +196,74 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
-		volatile struct amdgpu_fw_shared *fw_shared;
+	volatile struct amdgpu_fw_shared *fw_shared;
 
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
-		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
-		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
-
-		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN, j, mmUVD_SCRATCH9);
-		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA0);
-		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA1);
-		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_CMD);
-		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j, mmUVD_NO_OP);
-
-		ring = &adev->vcn.inst[j].ring_dec;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
+	adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
+	adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
+
+	adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN, inst, mmUVD_SCRATCH9);
+	adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA0);
+	adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA1);
+	adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_CMD);
+	adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst, mmUVD_NO_OP);
+
+	ring = &adev->vcn.inst[inst].ring_dec;
+	ring->use_doorbell = true;
+
+	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+			(amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
+
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
+		ring->vm_hub = AMDGPU_MMHUB1(0);
+	else
+		ring->vm_hub = AMDGPU_MMHUB0(0);
+
+	sprintf(ring->name, "vcn_dec_%d", inst);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq,
+				 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		return r;
+
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
+
+		ring = &adev->vcn.inst[inst].ring_enc[i];
 		ring->use_doorbell = true;
 
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
+				(amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2 + i + 8*inst));
 
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
+			IP_VERSION(2, 5, 0))
 			ring->vm_hub = AMDGPU_MMHUB1(0);
 		else
 			ring->vm_hub = AMDGPU_MMHUB0(0);
 
-		sprintf(ring->name, "vcn_dec_%d", j);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
-				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
+		sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
+		r = amdgpu_ring_init(adev, ring, 512,
+					 &adev->vcn.inst[inst].irq, 0,
+					 hw_prio, NULL);
 		if (r)
 			return r;
-
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
-
-			ring = &adev->vcn.inst[j].ring_enc[i];
-			ring->use_doorbell = true;
-
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
-
-			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-			    IP_VERSION(2, 5, 0))
-				ring->vm_hub = AMDGPU_MMHUB1(0);
-			else
-				ring->vm_hub = AMDGPU_MMHUB0(0);
-
-			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
-			r = amdgpu_ring_init(adev, ring, 512,
-					     &adev->vcn.inst[j].irq, 0,
-					     hw_prio, NULL);
-			if (r)
-				return r;
-		}
-
-		fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
-
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+done:
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1005,197 +1002,192 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v2_5_start(struct amdgpu_device *adev)
+static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int inst)
 {
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, inst);
 
-		/* disable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
-			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		/* set uvd status busy */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v2_5_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
+		return r;
 	}
 
+	/* disable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
+		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* set uvd status busy */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return 0;
 
 	/*SW clock gating */
 	vcn_v2_5_disable_clock_gating(adev);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* setup mmUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
-		tmp &= ~0xff;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup mmUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
-			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
-			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup mmUVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
-			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-	}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+		UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
+		~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* setup mmUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
+	tmp &= ~0xff;
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
+		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
+		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup mmUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
+		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
+		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup mmUVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
+		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
 	vcn_v2_5_mc_resume(adev);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
 
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
+		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
+		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+		~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		for (k = 0; k < 10; ++k) {
-			uint32_t status;
-
-			for (j = 0; j < 100; ++j) {
-				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
-				if (status & 2)
-					break;
-				if (amdgpu_emu_mode == 1)
-					msleep(500);
-				else
-					mdelay(10);
-			}
-			r = 0;
+	for (k = 0; k < 10; ++k) {
+		uint32_t status;
+
+		for (j = 0; j < 100; ++j) {
+			status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
 			if (status & 2)
 				break;
+			if (amdgpu_emu_mode == 1)
+				msleep(500);
+			else
+				mdelay(10);
+		}
+		r = 0;
+		if (status & 2)
+			break;
 
-			DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
+		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__BLK_RST_MASK,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-			mdelay(10);
-			r = -1;
-		}
+		mdelay(10);
+		r = -1;
+	}
 
-		if (r) {
-			DRM_ERROR("VCN decode not responding, giving up!!!\n");
-			return r;
-		}
+	if (r) {
+		DRM_ERROR("VCN decode not responding, giving up!!!\n");
+		return r;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
-			UVD_MASTINT_EN__VCPU_EN_MASK,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
+		UVD_MASTINT_EN__VCPU_EN_MASK,
+		~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
-			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
+		~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
 
-		ring = &adev->vcn.inst[i].ring_dec;
-		/* force RBC into idle state */
-		rb_bufsz = order_base_2(ring->ring_size);
-		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
+	ring = &adev->vcn.inst[inst].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring->ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
 
-		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
-		/* program the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring->gpu_addr));
+	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
+	/* program the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
 
-		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
-				lower_32_bits(ring->wptr));
-		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
+	ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
+			lower_32_bits(ring->wptr));
+	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
 
-		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
-		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
-
-		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
-		ring = &adev->vcn.inst[i].ring_enc[1];
-		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
-		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
-	}
+	fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
+	ring = &adev->vcn.inst[inst].ring_enc[0];
+	WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
+	fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
+
+	fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
+	ring = &adev->vcn.inst[inst].ring_enc[1];
+	WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+	WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
+	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
 	return 0;
 }
@@ -1424,72 +1416,69 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v2_5_stop(struct amdgpu_device *adev)
+static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
 {
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v2_5_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v2_5_stop_dpg_mode(adev, inst);
+		goto done;
+	}
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		/* block LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* block LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
+		UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+		UVD_VCPU_CNTL__BLK_RST_MASK,
+		~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+		~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		vcn_v2_5_enable_clock_gating(adev);
+	/* clear status */
+	WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
 
-		/* enable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
-			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
-			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-	}
+	vcn_v2_5_enable_clock_gating(adev);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	/* enable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
+		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+done:
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, inst);
 
 	return 0;
 }
@@ -1838,9 +1827,9 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_5_stop(adev);
+		ret = vcn_v2_5_stop(adev, inst);
 	else
-		ret = vcn_v2_5_start(adev);
+		ret = vcn_v2_5_start(adev, inst);
 
 	if (!ret)
 		adev->vcn.cur_state[inst] = state;
-- 
2.34.1

