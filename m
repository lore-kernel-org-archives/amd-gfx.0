Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F99D3A67C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0014110E6C7;
	Tue, 29 Oct 2024 17:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2g8myVd+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B07C10E6B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/k+suLMx1WZ/vUNSnGnjtlIT1MjtikHpbA3qP1Ra/U8EOo4xaJPUECNGcq2MlyDQ88q59a83d9vDF3H2rcLgLVOYvovFe8Rl91HKK8/MSD60zjuMuBgKJ183KupbPpnqyl4MI/6rvSWqFvembsHFeuNYHfgPnvxxXmDLPOCcGjBWx+ljvNyQxPk6sVsUW4xl4Cn40SWr43fiJFhkY98UHg54BndErE3aCmcqZcvQ1Mjh5EOONsJMd/Oo2AtTrQjDkxVcOeBEfAC5KQjdX1QuCPR58MMtKcxdpz2NINfmvyxdvv7pd4vEYM+sCvU+Swa/zAlm6pSWrh2ek8Y6HIpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVReZTQAZeV2ZYgrGPWEq/DqCTy1m2J7Y47kG+qCVxs=;
 b=ZhAMbKlIMmtCWV7LNQlVwv/LgmfVvH+OV7NFYvtVGc8rYcRnHv+NR2AoGZVA3i8BtoFMDutky5k1PoIQxydLgD2naa712b9XNnxeaX6pSUUb30es8Om1hGF9S7o33q6ic156X8poM2Mfzu5OlqfezYGCj+7n+FHxmBSAvgdrintzxJlcS5W1yUmSsN2kHVZGdriev/dtBSMR8+q+SZnwt/8L3uHjyVrcQy9CCI7/AcvOJE4T8XciFHvpTSsaODmvJqZViNtUv5em0HAt4fysv5hBwDJm/+UfrXajGjRya0FnDeyTqfKov/SkRNJ2efXbyhVI+G/3lYKnJTheVkIasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVReZTQAZeV2ZYgrGPWEq/DqCTy1m2J7Y47kG+qCVxs=;
 b=2g8myVd+IXMaHmhVbqAVzQYdoJ+LOfo9lJz1HSUJ6yAplt0Dd/N1x+lP+uSzojwZZbFGRAutrFYnBiU247zS9ghRwGf6c8IqJLCd28ueplTxQTR99fsUZu3RwyKwIl2Jna+5Jb9Z8yHRAjSrB6Q16ayz7oWulw30vCfb7MHaLy0=
Received: from SN6PR16CA0042.namprd16.prod.outlook.com (2603:10b6:805:ca::19)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 17:43:10 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::95) by SN6PR16CA0042.outlook.office365.com
 (2603:10b6:805:ca::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:10 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:43:03 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 26/29] drm/amdgpu: setup_ucode for each vcn instance
Date: Tue, 29 Oct 2024 13:42:37 -0400
Message-ID: <20241029174240.682928-27-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8cc9a2-f2c7-43f0-ba30-08dcf841279e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JTgsWJlqBaagOIrI7nIEHazpoBK9/5fxT4znqoRomIwXwVeF+496qquIpBZL?=
 =?us-ascii?Q?hyBGeApPqo29lFtx66JQTdLnYmV3h6BhvdcAj9exVA3OKzb4ErRVJOGpMULk?=
 =?us-ascii?Q?bsFgOWgnGZvEoLtRp+ShIuI6VIcXVrGELC0YZxOPGhcGsuOumV3yxzRC81Dl?=
 =?us-ascii?Q?uJ4WKoXC8xm2urjM3qfiAZc2BxoJ6Xh0eF0pkelLlQoCzNugDZ2TB27mKfa2?=
 =?us-ascii?Q?pS4dD98sNZrUJVzfPUaOeQD1n0/kbpigB/4IeaoLEfEE4xMelgLZhnViAMH3?=
 =?us-ascii?Q?IvbRTx+64IojkLsTfB5UzQxqF2C30nh7hvFeSASqGDlL7vl9ksFfE1Fbdcdf?=
 =?us-ascii?Q?txnjrJoMzOGsXW2yZl+dI+ypRDfaV0vfHTiiIxw3YLrTyPfmjOUbhhroX9qK?=
 =?us-ascii?Q?oQ78thZqRD/a9a0HZGqk1424e5LKMSAdeApVW5iHK2+L0Hf1BN2UuKDS49N+?=
 =?us-ascii?Q?Pgk6GreIIgGJF39G0SUX62pb67fiZfza4tXahHEayZcJPkRw3SX74+zETpSM?=
 =?us-ascii?Q?Rn4sRYQJMphXvgsDwmYry7HElJf38MmTqI/TqN38SGRFyW1S/65aHN8r8A9T?=
 =?us-ascii?Q?qBsC4/C7CeGEZjaaH6jShlcPRCtLZE4qm+MnkEv5oQC7/de5agzJcMfbvX55?=
 =?us-ascii?Q?VXQrR0EaUjV0eQTeRSjLXvqk+V3RXyW1/C4D9db6j2pT4iVDf71Dhv+ncfDM?=
 =?us-ascii?Q?Ox6OpWZHKPDST4LRqw8KlJj4J5xO+qSrACIJiWi1Ue+X/daQEdqHHo/1Ljjz?=
 =?us-ascii?Q?eGoD8FOvBL48kSp/OfLSMEX8pi9RhN0TzQyJ0gwX2MAJhmBJTd5zDxw/FOyL?=
 =?us-ascii?Q?V4D/NIWDBmCdDmBLzFREyMpX9gozu/3WL4JV+H60MO6dwjjTmYAko7AjfYTA?=
 =?us-ascii?Q?W0rPPt8T1RCKKIlytrqriuqP3qGg3mMwMZSadDzTFPvMJ51XgA38mkRxs6I0?=
 =?us-ascii?Q?MFBiGtCdG4hakZQxYkejY36X9IJucjeiGLlFOOigYODpFPNbKDAzhqpGkFB7?=
 =?us-ascii?Q?zkDCcLZe7c7fkgDQP/SSKQMM9hyjf5yKCL9g8kesHo+/IjJuc3aAIkzU8jr6?=
 =?us-ascii?Q?8Vc27zPySgBZsmO0bIolJqjTzgFT8hXF8C4QZM8bBnM9y6ADCVHixr7jpzYZ?=
 =?us-ascii?Q?ZIlYW81t+EPMfTQMTCWh1VEUPf4GtE7oTEc8ZCinqVYwzvJP3Mq2RA6LsL0/?=
 =?us-ascii?Q?j7cDdbu+i2DVDsRyU38YshdUYqsy6YbPJSXyPmz7CZx++o2JSEPRKZcRRlpc?=
 =?us-ascii?Q?Tk8r2hGtCjqYSx46/KkvfFnvAvpsus3OFG6tII+JYcTR8EKsVyXR9bUa9JfM?=
 =?us-ascii?Q?tsFgozC7c5W6Lh3GLblm4YSCEssSzZk0yHBZ1nvkEmftRo2yuJWUGwkzZuPo?=
 =?us-ascii?Q?trVS0w5VWkgFn+3v0HBpiBC4NTv3I7ZRuUhl7+SMjIH7W80ruw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:10.0263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8cc9a2-f2c7-43f0-ba30-08dcf841279e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
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

Pass instance parameter to amdgpu_vcn_setup_ucode(), and perform
setup ucode ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  2 +-
 10 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c4e1283aa9a4..29f6a2b76919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1049,34 +1049,31 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
 	}
 }
 
-void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst)
 {
-	int i;
 	unsigned int idx;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return;
 
-			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
-			/* currently only support 2 FW instances */
-			if (i >= 2) {
-				dev_info(adev->dev, "More then 2 VCN FW instances!\n");
-				break;
-			}
-			idx = AMDGPU_UCODE_ID_VCN + i;
-			adev->firmware.ucode[idx].ucode_id = idx;
-			adev->firmware.ucode[idx].fw = adev->vcn.inst[i].fw;
-			adev->firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-
-			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-			    IP_VERSION(4, 0, 3))
-				break;
+		hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
+		/* currently only support 2 FW instances */
+		if (inst >= 2) {
+			dev_info(adev->dev, "More then 2 VCN FW instances!\n");
+			return;
 		}
+		idx = AMDGPU_UCODE_ID_VCN + inst;
+		adev->firmware.ucode[idx].ucode_id = idx;
+		adev->firmware.ucode[idx].fw = adev->vcn.inst[inst].fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
+			IP_VERSION(4, 0, 3))
+			return;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 75cfdb770672..6cd094ee8218 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -505,7 +505,7 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
 
-void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst);
 
 void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
 void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 77f9f34eaca8..7638ddeccec7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -154,7 +154,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Override the work func */
 	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 87293bb777d4..a327c3bf84f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -159,7 +159,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 62266db72531..0d84cb4279e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -189,7 +189,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index d29c49d061d7..03fc50b3aa05 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -172,7 +172,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 509dc6b5f43b..c52ed8166d9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -180,7 +180,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 070cf516f365..2468a5e409c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -137,7 +137,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ad9e67d9134d..f43604d7fb1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -142,7 +142,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 9999c8094920..d61428c75c88 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -126,7 +126,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
-- 
2.34.1

