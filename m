Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7889CF0434
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765DA10E5DB;
	Tue,  8 Oct 2024 21:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FN0xJzqK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB46010E5DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuQhTXeUqp+DqGRFD3/gafKCdne6GsEhUtgU+umrhzhWettSV2IFX2fPVm3N1x2OgDkK4SF9/Mej+f69/rBumrF+or7SzsywA/J5SAwTGUalf+zw3T+SItbd82g9HQfAjDmmSkZFg6QwzIDI6GaautazmRQCb8mFIeckND2iZPAZNa71gBGnyukjFtiki2BrMGqjUhkIPbxiFIshb8VmGE+U7hokd+XZ1OQbtZT8HUz5ITSjbIwPoBQ8e6ffe+jMxZ5B9nlHaHKGW6KIsBfuuYecCdZecZsxIbBZ5+3/A0RnthqyObC1SUVu3G9rEKSyhXcd64bfHEHFieUNUi3W9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr2kBb4NZ98nwKNyfqdHwLKnX2Kze8OTBHQNYurJhp4=;
 b=dgbcLYA3EzjlzGzeYwVbHc7WuL/N2+3hOX+p1Hc0KSvswnqDwC3QZuBrWZQBBlmoGqRsmWePGodWDs+bX5l7tDOeS4KjfN7HKMNFMqKEJQHs7eyaGHitP0Jiba4qhxEo7FvnW3ad2PI+ToD706723mJP1bmVfXOu8S0dlvkLSdVNVpgATAyB7ASW1Thf6F45I29/F9YlDBZkE2sjesDfaA2eEV5Yw03iCu9v43vHSx5HYz49VX2oxulcFrh2vSByvwo/CRfjU34nAxrw9aeqEVYBnzImdX4BWMj0H65RJolAtE1OjwxOYLB3FHDvwPAq6soCs0DrYtzCM3U5zhNg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr2kBb4NZ98nwKNyfqdHwLKnX2Kze8OTBHQNYurJhp4=;
 b=FN0xJzqKIUoQ1hnB5sVXKjYTyxDbkCb/LNkHvI4gJ/3T6Xk44KeQzYT4Ep9Y4OMz0MZBr+gcTOHttuNz96OcpMw+7Y33NfcIaWN65QvYvbBrMpB146A9DupFQOWgwiT+lPaefF1sznr1adynnPqJ3HfLVqYKcstCBbPGmJyHLeM=
Received: from CH0PR03CA0420.namprd03.prod.outlook.com (2603:10b6:610:11b::25)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 21:16:30 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::aa) by CH0PR03CA0420.outlook.office365.com
 (2603:10b6:610:11b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:30 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:26 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 20/32] drm/amdgpu: early_init for each vcn instance
Date: Tue, 8 Oct 2024 17:15:41 -0400
Message-ID: <20241008211553.36264-21-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7f2b3c-66ae-40cd-8e02-08dce7de7a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yo4izOm5bE7yGgTzFaJ0QLSJI7aENWsnrxi7e0KXaBf/f49mtDYla22SVSRq?=
 =?us-ascii?Q?+FkbZhaNYexyPYcM2gBaNp1QJLS+tpd+Nj6+yGgGAYPJ1GtB9lCCZe2Q7Vvf?=
 =?us-ascii?Q?XytHNwsqfruWwZCx7k/icD1DdDwzsoToU8NOr6sPvWJdszZG2qtoSkBv4Hyh?=
 =?us-ascii?Q?pv4mOV+WHwPUPhLQaxJqTmxBWdWiYxZrpcq/z0ING7TFQA4zOobQeB2xl5Da?=
 =?us-ascii?Q?v6tmHIcTmHupNCjDJek1W7Pujv9bJGcjldsh/8UA2NFMW0dS7o2xmkA2ZF4o?=
 =?us-ascii?Q?dpyInbqEGsKGeI9eJ+1AFe++yk8qe3euawEy8CVMQgAjnqAEfG2/g3IoBF3I?=
 =?us-ascii?Q?JpFm+WHJUOcWjlnRa+FHLT6Xmm5kFOZd4fqr0OoTrOu+nzwfJmJfUnlQjarp?=
 =?us-ascii?Q?RuE/Yo87SZ9e95Z/dbi9xTAwtRraII1cb+YRVFRpT+cxZL4QSGJBABEKnJh7?=
 =?us-ascii?Q?rPIMJ3EnnIlksPnIfBrkS9FxV0mNmxgv9C4NaYYLkgl50ZV4GtO+Hjxj1PLo?=
 =?us-ascii?Q?n4V6AFjRv5kU797X7IEmVL/k7vsnLP+tt2diiDBYWC9Fl2HbUEO1W9lGU3ps?=
 =?us-ascii?Q?WxsJyoOaWrz3CdVBCglDkkDwNY4JnIMKuhILXgwZPYqwoIv8fGnwRZQBEIJ5?=
 =?us-ascii?Q?NqhKyN7G0CSaiOkTwipWwnIIvUh81C0t0qKm1kKy49kj6zhKkP5A8qcXXPPa?=
 =?us-ascii?Q?L6q+s1A8MyHVSYix/LsIkzK46rw4W9HEMaoGq/RwqWv/yH0iRZtFZ1c2Wb+2?=
 =?us-ascii?Q?iDSZR2HkymtgyrA0EQYZAdybLBvHCMFpdRy42Ut3mbZuDIKTcC2AiYuCiodR?=
 =?us-ascii?Q?CEhB7xkPPGN3swcmmq4g4bZKTjhbFKf68ykKtJjVMksk0cuubWwzk2FOG/54?=
 =?us-ascii?Q?Kt2L9O4emYbtOFShL8KKc5NiX5dWp/2V9OZKHnX0tZYhDYZrRDxZ9xaHHIVb?=
 =?us-ascii?Q?En4S3dnMDFF2I+mGxMFv/YWckHJLUvLW88y5K40psY0bDUyVkZ27xdVa6T2G?=
 =?us-ascii?Q?ZGWjeyfT2LYShrtdmSaMy6ufxLUuXInULaIDimZxetfkfmcXqhpb/x2JpcAH?=
 =?us-ascii?Q?lRzSk06Fy0ArJUHM8Ppyrjkah9TDGbwou9Ktwk0hJcP8fA63MAT1LYey7TE9?=
 =?us-ascii?Q?q8tvYscTg5mDvKwGuwcWJ8NX/B6juX+StVCjjsnHtgRID/bbl1zC6jib93en?=
 =?us-ascii?Q?UavWjID//f3jDGvL3LEbTRXpL5MfuaKJ89z0qAPJ1tszGMzAdYxO9+a+3DU4?=
 =?us-ascii?Q?xLOCsu81g4RLlzLVse/0mpFRp05KQih/Ill6MsMXqpV2IgfLVcYvt6crgHnv?=
 =?us-ascii?Q?eP0YysXh6W7cZ+V5T0f3sxzsR0mHE5WO0dPv5woCydWaQB/y8rZdzYF7bUag?=
 =?us-ascii?Q?S418oPI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:30.1082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7f2b3c-66ae-40cd-8e02-08dce7de7a76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

Pass instance parameter to amdgpu_vcn_early_init(), and perform
early init ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 13 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  3 ++-
 10 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e93d3ef2fdd1..e2986871f3a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -91,22 +91,23 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
-int amdgpu_vcn_early_init(struct amdgpu_device *adev)
+int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
 {
 	char ucode_prefix[25];
-	int r, i;
+	int r;
 
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
-			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
-		else
-			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s.bin", ucode_prefix);
-		if (r) {
-			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
-			return r;
-		}
+
+	if (inst == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
+		r = amdgpu_ucode_request(adev, &adev->vcn.inst[inst].fw, "amdgpu/%s_%d.bin", ucode_prefix, inst);
+	else
+		r = amdgpu_ucode_request(adev, &adev->vcn.inst[inst].fw, "amdgpu/%s.bin", ucode_prefix);
+
+	if (r) {
+		amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
+		return r;
 	}
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 38488194a1e7..acf4b88e2797 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -483,7 +483,7 @@ enum vcn_ring_type {
 	VCN_UNIFIED_RING,
 };
 
-int amdgpu_vcn_early_init(struct amdgpu_device *adev);
+int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index f093d66df1a0..1a3907295e36 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -104,6 +104,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
 static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	adev->vcn.num_enc_rings = 2;
 
@@ -113,7 +114,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_early_init(ip_block);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 15c498b2b0de..d14062e1dd31 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -108,6 +108,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
 static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	if (amdgpu_sriov_vf(adev))
 		adev->vcn.num_enc_rings = 1;
@@ -118,7 +119,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v2_0_set_enc_ring_funcs(adev);
 	vcn_v2_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 880dc4790a96..5d145adbe932 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -118,6 +118,7 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.num_vcn_inst = 2;
@@ -125,13 +126,11 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.num_enc_rings = 1;
 	} else {
 		u32 harvest;
-		int i;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
-			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-				adev->vcn.harvest_config |= 1 << i;
-		}
+		harvest = RREG32_SOC15(VCN, inst, mmCC_UVD_HARVESTING);
+		if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+			adev->vcn.harvest_config |= 1 << inst;
+
 		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
 					AMDGPU_VCN_HARVEST_VCN1))
 			/* both instances are harvested, disable the block */
@@ -145,7 +144,7 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v2_5_set_irq_funcs(adev);
 	vcn_v2_5_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 464394989dd6..464a502a7cd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -124,6 +124,7 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
@@ -147,7 +148,7 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v3_0_set_enc_ring_funcs(adev);
 	vcn_v3_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 2994328982ce..58fdc07d9641 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -114,15 +114,13 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.harvest_config = VCN_HARVEST_MMSCH;
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
-				adev->vcn.harvest_config |= 1 << i;
-				dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", i);
-			}
+		if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, inst)) {
+			adev->vcn.harvest_config |= 1 << inst;
+			dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", inst);
 		}
 	}
 
@@ -133,7 +131,7 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_set_irq_funcs(adev);
 	vcn_v4_0_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 166e86fa7daf..4641534bb768 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -105,6 +105,7 @@ static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
 static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
@@ -113,7 +114,7 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_3_set_irq_funcs(adev);
 	vcn_v4_0_3_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 26de66ac0af3..d5ef1b0bcf54 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -112,13 +112,14 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
 	vcn_v4_0_5_set_unified_ring_funcs(adev);
 	vcn_v4_0_5_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 5987a8af22cc..88248fcfa138 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -95,6 +95,7 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	/* re-use enc ring as unified ring */
 	adev->vcn.num_enc_rings = 1;
@@ -102,7 +103,7 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v5_0_0_set_unified_ring_funcs(adev);
 	vcn_v5_0_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
-- 
2.34.1

