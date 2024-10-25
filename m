Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BE9CFA478
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EBD10E9E0;
	Fri, 25 Oct 2024 02:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jM/Q0YzL";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B5210E9DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCUBRJm+C+vN92WTbP3DykAZnHC1/YodpzzeEf92dyyxUCZ8H7QxeqGL7869kQ7bR17hdWaFkJoPOpkj0svw4P4KKpO+CMfgYG5MGx0bnEGVIMyPzoXPqXMkcMyLeUVNrAKaNCBQwQxZUCdvXkIvwxF0F/zncA/nWEzgbDehQJeNExVv4nI+26HlA4rDlhcv2t3cAxhreAt5ERq2dYc1fwPl8mKPKStXtoa6DCH4whfVkOW/JIFRAUNL5H78XQsmdRisCBqh/zrDMf7fJsB3A4KjRZu/VjXse0q/FqrEbYX+IfLI3EeSmr9yFVnj4lBS7ORlgWtZEj1zjRGA9L5ukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwBvVjJ6NTgi4Twam1ol4F0GEhUX0q9vwdw1IMmM99E=;
 b=ZvcNaLGqX9ODxeq83JVcMkKuM3n90Jh3IZt0yLlXiZyEiS2MAwvqP5FAEIJvhsjvyU6MIsS1dnFy7xVR4lX3iBDZQZImirQvfkGdf7irMkrKx4BRAREL3CuGOzAVCp89Z7/QgumoaYM5C5yhhy8sHfn9JdN0f93UeYr0xECFPkbfw6h6KO7VH3D9we36P0mZE9aR7tb42kOhhvBGtLneTgo0lu8zEmpCaefswre4+JjjZfV6qGtOtHNnj+1+yBIf/hIjUO+qFAhADydRc08wBUlqBPJf+KgXvbeAnuWZjVcbWB6LOk1hV6CEsyoi3+emRUTxyCe8nIucNeSuzCdslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwBvVjJ6NTgi4Twam1ol4F0GEhUX0q9vwdw1IMmM99E=;
 b=jM/Q0YzLwWx5lrzdo0aVwFQRCRJopf2HYc4myYv+vw6bJ+plw5DDKCwrHs8reIOuqlo5LmctXUzUg9EXmhBUubHPuvtcArBXBLXkDPkfD3YdIS75nZ/JR4Jp/HLpwXJMkLGfmNiN2B82HiDwcsb/SFMQoX/ryTvBX9nEizKuBe8=
Received: from DM6PR18CA0024.namprd18.prod.outlook.com (2603:10b6:5:15b::37)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 02:36:20 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::6d) by DM6PR18CA0024.outlook.office365.com
 (2603:10b6:5:15b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:14 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 20/29] drm/amdgpu: early_init for each vcn instance
Date: Thu, 24 Oct 2024 22:35:36 -0400
Message-ID: <20241025023545.465886-21-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d662eb-133a-438d-fcb9-08dcf49dcefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vR34FEXvQ7H7bz7YaqFwLpL9b+kuCvuN/mb42+9QmklBobeTrzfcJksNQiPJ?=
 =?us-ascii?Q?XQYCO8TeMb9ol50cwlly93YcqEhqWYSVorQEANPL1kJx50sQQ030siYGJxqi?=
 =?us-ascii?Q?axXDt2l2e1vkVET729/l0jXQqFBcDjn1kasmLtXkCuYse38jPFNxEI1g1gEK?=
 =?us-ascii?Q?8JEzh6Jn8KULAln1QY/LhWD/8nYxBD7si8aibZohSw0mmhnIsfoNKwCfdute?=
 =?us-ascii?Q?LAW7vqvFGoGSpAHD5UQ2VIusesqjZmuk9vzQ7qHd+h69D1rZUTMKTrNF8VWg?=
 =?us-ascii?Q?ERW4rKd2Mc0UCTR/bknSsFHrV5Xpz+/yuyNpI3aL45bPOogyyieA/2jixBYY?=
 =?us-ascii?Q?H+wmuzfc9VFDvN1waDmeM6AzRMHoE8hrUHjW5nvVWSgyUFEhrLto7AeGBe+5?=
 =?us-ascii?Q?xikmaXvAxxWuFxOBCUW6zztyF3cEQJ3dDFuCxz2r64Unj1uHKXKpB/T9uKGt?=
 =?us-ascii?Q?2A45siqCiHe1P9KmE3sRbYiNzPJja8fIj9Y7yoTUlDQtgpaA9JKYacq2H8yr?=
 =?us-ascii?Q?nScRIvXAWy3ibxVJ4P87ZQ8c4hZfR6Ge0oswPuN2+P+DJ4C4w7NhZx+vhUnP?=
 =?us-ascii?Q?YxbSy6jnmtxQHGzWSK6HKF4UoRzkmOaDhbc03hX2Um6AZj2UeOG+s4DUNnfK?=
 =?us-ascii?Q?cbz0kqztiUgPFS1ZUp84TvZe2KLXcs1f/R1usr9SwOgAEVhW8sFhXKjTI0Pt?=
 =?us-ascii?Q?3GVpOm1HF8qgp7/TPQo30/FW68TyUgYPCjqgZKfWYNWobN4Xr3Q7ie2Yrw6b?=
 =?us-ascii?Q?AygvummInXYJtEFJgZgFs0rCEx29lJhdNJfafjk2OTNNOD8/hV2ZgYGFPNo/?=
 =?us-ascii?Q?JkgSIPjAs9bUOcbBikYTmPqygyvy58F37b1Gxu1eEdC5qfZmGuC6NJaRYQtj?=
 =?us-ascii?Q?d+ZHHfRYNMHRk5GS2r9rv8bPDAK0op6v3LFQQw8euVwCJOH/QQnP/r1cLk2X?=
 =?us-ascii?Q?tCaouKJ9+BN7o+n6nAe9ltE9MrQoyYt0hmEpIsZXag6iqIyX7cc+BIODQ/9U?=
 =?us-ascii?Q?YCirv6zdsqNgyA+QjMz3CLj8VKxySb8J+M1n/OfChoP62M364M10HqGaaDeK?=
 =?us-ascii?Q?E0CJgatLAJQ4EikF/RtBLx2ZU9+t1SpXhkV3kXiGEIaMz4+kB7VVoyAGstGj?=
 =?us-ascii?Q?4j6y5+zcbN9MZTjzTrzaCy7LJtEa7zlHmYj2P4uGYAYag7VRvP8f9qxAavvF?=
 =?us-ascii?Q?sAT/rKp0daWvLoV0Dc0gP0L5dx52r2zjpnesT0S0dC38/HPqxWDk7CG3FtHw?=
 =?us-ascii?Q?meVp3IhS1rqvreLud0p7JMr3E+pt+8vkWh7X8ZMcF1O2eblIKw0WyQK7zsch?=
 =?us-ascii?Q?vlHh3zYxtYsCUC8zne7F0k6nnMEoJSF2nBIgWDBADG5DDMxO1jkqNyzS/4ou?=
 =?us-ascii?Q?I7P7du76zADRUlNXSsjcySShwAs/WmyE8rnK9duR7z2/qJqhkw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:19.7400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d662eb-133a-438d-fcb9-08dcf49dcefb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125
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
index efd6c9eb3502..21701738030f 100644
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
index 2282c4d14ae7..58fbb87e5ec4 100644
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
index 8b860db34584..6fd509e6744d 100644
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
index 419ecba12c9b..8f7038190a43 100644
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
index 7e7ce00806cc..74814370ddc9 100644
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
index ca4ee368db02..a7fb5dda51dd 100644
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
index ee6c08707312..c0c2a071ea15 100644
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
index 2c66a7a4ff25..1d1ee6da7647 100644
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
index d725c12ffdaf..81efc53e7cd3 100644
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
index 3856388179b8..7873ca91da4c 100644
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

