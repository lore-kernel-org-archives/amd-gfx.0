Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C67D3A67E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA0910E6D4;
	Tue, 29 Oct 2024 17:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k/pKIDNm";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4827010E6B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luq8ehhrIsGy0FDQ3L9bxBAnbZ7Ph+2mEe/Pl7fyEdUW6taZmANdybszMusfF3dUqfn8XIlX+fZFGECdLpvgOD1MJpYb/4t7m9CzXJolqZ9G19Zx/k1oxWvoE9p58iB4ECwap6tgoynUEt1wY34JjaMqp9++/o1iFgYd6NZKsONAHvnC1GWRPL93bdacEXxpNP9jZSVDJnE4h2mGQuGM79iOE/XYV5k52sdotjUWXvnpygwd/vH5pj0nMKJBcgPiJ3RWCSJJvKVDyJwGlpZ9++A0ccajwyE4MW/RsdN21gi9aRrAXZTMelJDn+zb3g4KKYdCOrUx51qHVM9hLhS7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icORp1mk7GVTB41E20xbUOLT/KI4HnF0mdMlG1Is4CY=;
 b=RmkyZSCimjNjtWDKNEEmkk/OjJVVkVIWMGQNCvoEv6wCIiFiOoZv66XmXjfz/k9TY2ERyn6U/oYvyVlhtbP8mR8ScZ/VUT+mWpBayNprk/GJ4kW//98Qkd6+XYC1WZCXBnFV/Y03B5ikkcxhkf3HFRLe5VheWoNwDphZxET8kcRs+hZgh7pPpY7i0hyDZASvJFiIAV1Szzv2um6+/J5rp/fNcGB1fnMl5NiQymEs7pU8EEDnZCriIeCLKwRUIsTG8gXs3JSlhMG6YtIUO5JmVwAYTZTz3vprY3YK0xyCdG+VaOVwdVC3pn3m0SS3x8JgLqd9rJ7+jWgGw0bAWH370Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icORp1mk7GVTB41E20xbUOLT/KI4HnF0mdMlG1Is4CY=;
 b=k/pKIDNmTRlvGK14c7xMnPFKQJpqbNnEltBzii3tCLR0fLnnsQSUGIhjq8Nf5wofuVimboc5dDp9PGN1WXc34+Zp8Kex9wMc/5yjTgUiJI8zt2OCno8I2Ucc9utHGGX7XW6yPI9iitR961A94Nv5WiJVgUJH1xIjnRCZmFVp8U0=
Received: from SN6PR16CA0065.namprd16.prod.outlook.com (2603:10b6:805:ca::42)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Tue, 29 Oct
 2024 17:43:08 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::4b) by SN6PR16CA0065.outlook.office365.com
 (2603:10b6:805:ca::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:08 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:43:01 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 20/29] drm/amdgpu: early_init for each vcn instance
Date: Tue, 29 Oct 2024 13:42:31 -0400
Message-ID: <20241029174240.682928-21-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 606dd796-c524-4ccc-4e5f-08dcf84126b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DHNOGIFnT8cR/e7FrFwoZyNuap88R4g29hh5H4dYJdrj+beZV5k26JfmzVx+?=
 =?us-ascii?Q?LfS7wwXdIL976CApRAbaq2BoXf8m09AShiyb9JdWo469UHwSQhpNvrbUcE9/?=
 =?us-ascii?Q?yD/2vayR25sHh9eQqdtNDg29J2WnsPfilZFrSIjkyqfRHCyEi7SZv2AJnTcd?=
 =?us-ascii?Q?whbC+ARNHjjiMu0203adkwCZT0/2U1IsLDANhT6DiSvs/cP059liISbK+Srs?=
 =?us-ascii?Q?U4W3o+9DutcGzkqaJIzt0iKRern9OEuY/PB3P27euUde/+UptsCgAZ0yBVdx?=
 =?us-ascii?Q?PXQKNaJE1UVLLnedvDXujev428xeS5r3/lDziXsZjpKAtAy4bKSn4yqY7KYd?=
 =?us-ascii?Q?jBXlltlg5js6d92Xktqm3ZR+L1plH2w1/yUAGHD2uiDjyAAbOaib4A/1rxY+?=
 =?us-ascii?Q?JaUoyU/8VRcpuB9YS0T/rphBgyfwVO9uk58ohYfHPU9fAObKNTMQ2VasNgoX?=
 =?us-ascii?Q?/ruL7/uWi/5ZO7carV4MLUaIgr1VsHT7oJZHL7Qezn75269/MBkQm0eMZTIw?=
 =?us-ascii?Q?XC9gUZDHO1n/Br9yrML8OokJWpEGGI13P043xI+tiH0rpTfi+E1rgAvP8ASz?=
 =?us-ascii?Q?yLN6GlKyYnjfbhatNFMH2KYBf+Ch9/xyoVF9Fx6B+zD033W4sVgfw1aWL4r5?=
 =?us-ascii?Q?QxPhjulwdYTG2q2cYrXmZgSWgJ1fdwOywtX2FpwNVGAbbAvRySMBLBifcxEs?=
 =?us-ascii?Q?Rzeg6bnbQ5aoRCtgiabySPHx4XWdxKmskq8/AT1T/JlXdxtnNBASk6o2dAc5?=
 =?us-ascii?Q?aoFsdIf625ZfsMW2xadd2HpLMIj7dMDihXS5yv0OaMUZUJye0JcV85bNQm7P?=
 =?us-ascii?Q?k7LlXbno4+kz9DNuDiHYjoL0B/gn0IJ3aj4RUoHCbbLLnkm6EIk6F3xgIe+B?=
 =?us-ascii?Q?2iMRlLtRRYW8C4eVfww+vZvAYrJ5x8bakg5Fim4zQNEZKVD0qYY7mOLnw4bj?=
 =?us-ascii?Q?jK7WRXLS2/c+3zY1wFXWgVcBwBmg7fvK7xbx4aI2ECZsJ1nUCJGiH3MRfXZj?=
 =?us-ascii?Q?zSNk/T3jAoS2paCj2rL53cIrVYPLjuZlpQUmY5d1CIr1QIUXmB71Na2+XcR9?=
 =?us-ascii?Q?3YaQSn0rCvmiMjaJ31+vKvEk8fdecVJhEGzzYgdVQwM+85ox08Rv3QQPWQh+?=
 =?us-ascii?Q?UoOsRUiZYfy2gyLEC56yFswryaEE9f6YCHgzEbnKLpeUY2K20x/ejaTFaYlY?=
 =?us-ascii?Q?SAhp6hXUIdocJITHNL1xDSOTnowoW09PfYmQ28VgeYxQaku8l3ecaUHuU8mb?=
 =?us-ascii?Q?loFuQ5TM5qKDxSY0RGAwbfV2uTaVyXyU20iN3VZFhSwEOGSgZ0RLF37qseAD?=
 =?us-ascii?Q?kqJ2pRpPs/mSE63cMqYt5ixYi5xG2JOR+iDBhFgkr5IhX+Pz7STiEJPP6q69?=
 =?us-ascii?Q?w2BzsLZajjHkwAQjVG9iMgYY9UeM28/0KmtLjx6wXzapQdU8uA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:08.4637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 606dd796-c524-4ccc-4e5f-08dcf84126b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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
Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

