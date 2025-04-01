Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB59EC3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 03:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7085910E4D5;
	Tue,  1 Apr 2025 03:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B4on4yTe";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6728C10E4D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 03:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1Y6+BtnElthHpuJYqIfn0nRUClVVUfU2mwdc2/TEsByrzfGwjNrAIMDUuXriEQx9MI4poiOfiQAm5bXC9D7gwLohHZbZeCdRx0tD25ghIYdqNkYx3lzCGzt71MV9TGFCGHtrWihMhBOJPssPsdijrxyzY/P9240JoJBept4GEknOtJy8H6punylhMbpyBuD98/ZeI8rlEj1rZeAfKbvJyIUPIk4oMg8d1lnSn3Y6IKvH9BCttoVBceSNhTh5eZ4tq9UKXOpb5x4CZhPZ78ehDzjNpMKFefdGCN5JNS4xe/kx9rCq78fkTcPki3U02r5Oj8J0Pw44dVs3kWBM9Z4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXJn29JkbqQYI1JQ9pHm9iNc9KTi8BTHnVYbvh2fdf4=;
 b=S+tnJidIHUf2bM54/Eka6bDY1rg7mxQjlNSL3ce+xHUFj0vLx/V0LQOL5XXlDer1NYJ7iei8SD8LIYoSO2f0POVZXNcBflOIbEHv8wWBGxh3sUDwINYbbdpvYX9LlCL575bIHLKya698VtDMqXhtOc24XfqR1ZB4aXHHcR7qLcasRvntL4ukVr7BTYR+BV1O/ELfIRWlwBVOBOy5+xY9Wqxx63AecRleYb/yOFnIOpxV3RM7jF+RyqouZgtXyRY3yqcC7iUYrpRq2n3PAopDtgYdwqa21LCpCsN18bNFCycPYfQ+g/yN9TCWPXIpqezThf2qzKFAytGZt1z7UlKE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXJn29JkbqQYI1JQ9pHm9iNc9KTi8BTHnVYbvh2fdf4=;
 b=B4on4yTeKKEcLntp/h4zVHktfQs/STwR92XQct8nRkqIWTReVvKRQ4hFV5qrAfbjwIspCO/T/kna9tGk/pbmynDNLzkp86MemwigaGvARF3WzBUOyF4VMI6yeHH6xlVBd2yu24sbDfvZfN5Piu1e7fDKwU2MlrtbKC6NEVOM42Q=
Received: from DS0PR17CA0004.namprd17.prod.outlook.com (2603:10b6:8:191::12)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Tue, 1 Apr
 2025 03:05:54 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:191:cafe::e1) by DS0PR17CA0004.outlook.office365.com
 (2603:10b6:8:191::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 03:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 03:05:53 +0000
Received: from ruili-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 22:05:51 -0500
From: <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Leo.Liu@amd.com>, <Sonny.Jiang@amd.com>,
 <Shimmer.Huang@amd.com>, <Jenny-Jing.Liu@amd.com>, Ruili Ji
 <ruiliji2@amd.com>
Subject: [PATCH 3/3] amd/amdgpu: Implement VCN queue reset for vcn 4.0.3
Date: Mon, 31 Mar 2025 23:05:34 -0400
Message-ID: <20250401030534.3880347-3-ruili.ji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401030534.3880347-1-ruili.ji@amd.com>
References: <20250401030534.3880347-1-ruili.ji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: db55a0e1-ac31-433e-69d7-08dd70ca1da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ANcGYU8R74HZ5deSZmUz5PsMJRERubaBx4H7KJEwtv7gODb9Bx0ts8XzO75T?=
 =?us-ascii?Q?JpUxVLygkID4UME83qEExUP5YJel3+og2LHkTi/3WtG1dPHUlAKFdJZXaXIU?=
 =?us-ascii?Q?XjRhivCZJfzjsQ3wMVVAlNUrApg1XZfwYYm38gTJxYcIT47X4FpxF1u9V79D?=
 =?us-ascii?Q?8OvZkJRTyh5NsWBLqaycShxIntNGBwfX4fP2JP+PPWJjXYfjoOI6+WYRSqhG?=
 =?us-ascii?Q?hDVEXJPlmxvHz4vQ9Jn2Hyyaou0m1toWAR5fgvsMq0tBGnWAuV36TO9/k51O?=
 =?us-ascii?Q?BFAFrN0+YJgozZXBWBWvH/SRkX6ezAHVn6SW6lTtvnUQSub0qjDb3PrmHvUE?=
 =?us-ascii?Q?NHkalizKa2sL6rZ2S/dXFlX/wSdGi8Cq2iLhkktsZ9G16KU2Nv0AgwmgvDgm?=
 =?us-ascii?Q?7HKCQFOFSygzLNCrb7SywJ9stM5eqRHcXW0cdcrCxDbQC/VQmFAOMdlsKJjd?=
 =?us-ascii?Q?2madXqziLORUrbc91Bfba8ovftk/qa02SfGQC3GxvndUtRcimDokpuL00zsz?=
 =?us-ascii?Q?s00bk8coyu5kdPxrbSJyB+Im7GQ32F3O+SS9jEwgIXWRJtblKEFkrC3KLYYN?=
 =?us-ascii?Q?7l9wS7vkCcJMMOCRP7ij52ARTzexDMNzV0j34vpvn22zrSYW/cH8eIBszBB2?=
 =?us-ascii?Q?Iiy36VgXTo1DmmI+qtHXRgWgF+TYO6aXJxLM9lXV2jHGv9jrkwXhr0pUByCC?=
 =?us-ascii?Q?Z3YSsONfXubXbCpLYay8a3fVirVald3BTRjzQE3Mw15btTJPAm+5ewfIz0MH?=
 =?us-ascii?Q?rE7W/ICYJcpjQxXsN8BqZwV2pkjKQZm7V9RGRykEzH2MwOm17fFZ3jIVOfrn?=
 =?us-ascii?Q?xHJqhg9xbxywDFS11NJxFvK0Iq/dCVo1xAoKx28jPxYYb1kZoc3S5EgsAWxu?=
 =?us-ascii?Q?d3vGXG1LbhrlGggt2HvOPSyo4zShuXDDGBwTh/Qk83mcm5tgktfSHXd/h1gU?=
 =?us-ascii?Q?5zWe6ibECKp+1jDbUc9ZoY9PaAbpc0gi2j3hq9FL/Bt+Kyrcv7PZD6TGFst4?=
 =?us-ascii?Q?b4YmYY+DgST2hiy/srj1gpryscuhsKDq9MKsLUCrOl0yf+Xus8iUeLinyZnB?=
 =?us-ascii?Q?QDhGC579kN2x13WKYjxRxOyYtMd9YYjs8pz7bvmp1z49bZglZ+Q1bNPpQ9Kz?=
 =?us-ascii?Q?PUFyoCYdP/edSJgixUw7ZgcN+fo9wcP0tedUn77FydCHwrckkhcWBtXvZpOr?=
 =?us-ascii?Q?GT5rideamAdbmsVJKfhZqCWoyUZli4LoAzM+8tDIenyjiirp8BRJUjGPXgOn?=
 =?us-ascii?Q?ooQAM+zWRvCw2pRUl5Ge2ut+Y4JvuGDkywvnULsV4y5F6sYP3QGA8ggo73dQ?=
 =?us-ascii?Q?NogTxrA9L1UfNmdKHpaxJuhonvHl9fzZ9iZnASEySHg5iNFiHwgYyX/HGYzR?=
 =?us-ascii?Q?wJ6n0u8fQ3iVdtcjqXOcz9bxP0ngBF5QtPmgfyCyToW/S+DBoE794XEV/ZSN?=
 =?us-ascii?Q?JWAZBVOvIPqVClX8nYeCrdsABD1DepDYd728vm4X+K0CKas9Nh5Q8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 03:05:53.8363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db55a0e1-ac31-433e-69d7-08dd70ca1da1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
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

From: Ruili Ji <ruiliji2@amd.com>

Add function for vcn queue reset to make driver to
do fine-grained reset instead of the whole gpu reset.

Reviewed-by:Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by:Leo Liu <leo.liu@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index b27e26e21ca6..3c43f5c1a08c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1576,6 +1576,37 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	int r = 0;
+	int vcn_inst;
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EOPNOTSUPP;
+
+	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
+	vcn_inst = GET_INST(VCN, ring->me);
+	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
+
+	if (r) {
+		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
+		return r;
+	}
+
+	/* This flag is not set for VF, assumed to be disabled always */
+	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
+		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
+	vcn_v4_0_3_hw_init_inst(vinst);
+	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
+	r = amdgpu_ring_test_helper(ring);
+
+	return r;
+}
+
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1604,6 +1635,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v4_0_3_ring_reset,
 };
 
 /**
-- 
2.34.1

