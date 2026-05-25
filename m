Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC227CD5BB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 15:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7565810E3A5;
	Mon, 25 May 2026 15:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kzii28DP";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8AD10E3A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 15:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWMIqL6WGNxD9ongN2UFBD7NJT67hCeebuUq/3MEUIuNK2EHtkgNWvguIS34Xy8lJbVp/HwcuLvnrfEUmwB8M6gMDYWdv4KlYANMARPInMT1RuqgSvQ0Q8iCLQKCUT7uxe/vt8Ffxcyzc0s7xMgL4O14l4wSuV6+LxkBzncR1CIWtVsuhSeQQL/iwlci7Yi6CNxOs1nylZO6JeDNnZiHGVVEDc9kTcd2cSU9Yxes0dwrEbvDxVRyKYylmGiRLoUUpL+J8EslA0Mzz06Q3+owlWFKcbbPxn9nurlKmQHfRAz/6yh/kZOcUQruC7aGvpQKKxfHwmyLe6mv+SyEIgJs/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohTx7sv64V7dZmuYe9LWOuWbIqQoP7WcdtRlc+kpawQ=;
 b=OJtwYBEj641VUdNM3V/IwLlH/95OMv/5xTIIYwR+3CglrclZpYEyF+4J7mJOe0CIdKRyDPA1LCp5rC9nGfAFC8kuZBnxq63E0/iu6Hdaa1CgAlSszS8hI4l+RJe2eK3hjFEhHXTvBDZpP8Bs0GYaF3OFr+hJ8CPcUbxlz6k2YGHGttufLAPj/4/J9X2PqrH2M/WGJYIbFgxVahsSWsu0KgxKAJ6vqIteoBA0Emy48IN3JydTNTpGhXxrphbSscoQv+x5n2HtUdjj5xgbqEuQZci5GLBQKQDEIbABeX4nL6z/xHo2U8wHF1xeeNCNESU7ylfuVlNDT5eMoZCh+u1iQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohTx7sv64V7dZmuYe9LWOuWbIqQoP7WcdtRlc+kpawQ=;
 b=Kzii28DPoqBSL9XYdVLXsMHFhZAEcCI4HxM+6or3bgiwGXi4J2+O5CljiOvXydo34e1+F7WflMYHHhKZxF+ekcXXCWpCfR1JV18WyyUfZLJcyofzpq9ip/ZKy8sxzqa9i1LSFQPFCr28Fyv34VLWdZejPsATIi29wItdXr/b5U4=
Received: from CYZPR12CA0013.namprd12.prod.outlook.com (2603:10b6:930:8b::6)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 15:32:10 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:930:8b:cafe::72) by CYZPR12CA0013.outlook.office365.com
 (2603:10b6:930:8b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 15:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 15:32:09 +0000
Received: from jeevana-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 25 May 2026 10:32:08 -0500
From: Jeevana Muthyala <jmuthyal@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Jeevana Muthyala <jmuthyal@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/vcn4.0: enable secure submission on unified
 ring
Date: Mon, 25 May 2026 21:01:55 +0530
Message-ID: <20260525153156.1258211-1-jmuthyal@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fd000d-841c-4e3b-6b7e-08deba72c94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003|6133799003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: QbTABWqidSD7ORXPwn0ajyRyDDfPX/C3pNYa/QxR8t/GyiEPeOoKOZtkTciWDEm2amY0ogIAM1mZ3yvOlq54C13XAWN5tOMNioGqTIxQu0Vxgw3JM7bbGj9REVHfmsC55NVzcgjaSthF42LZHlVxHPa3zZl7henYBYescL6MFVs1DLo7hARx3QhmKYJJ+8+B1j4ERF5t/IOVvB49JW+4VIh6kcbP9JhUgOcUO7urUSEJfARLhK37BN/GlNlNNC7ldHlMLO/EC0JnKviEhW7WUKszuGmskDAiHz7hJIULQqD5uM7MO127c4O9MYcc1IjHl3YR/saNCg5zfTFVTE26dfjGKXIb6m/eR/m+euGtYmEbMKzqvM3a96KlMKn387sHIUYfLkilkFdH6IK8/QhowUCtguj1cJmtvgV5qGYy74b6xl9JXY97ufHmYlkA3tSjOw1xgp9r8P0BasfjdEllcWIgqxS6CD5f2Yx3SEZ7l4vq2WgfXqFyOkZoxljv7xnc7zrS+BnrfWiiCC04ZCJ8+grbOFt4TRBXOTjTytXY/zS5UHW65iZMWdOWwXJbLOzWBgosejcvPP/zKRqlwMNRLvWByFGeebvbtKc7lJcwNd+/FPjLNcpAIcR2ty+plsBLuRz2FnNA7jXdd1AtLKF9CZYsb62f0YjZo6HBhEGEre+YLiv9kIdRexwp+i2hvAGEUODoo1iiFCZ5Rg57OBpvlmiKPlXyNRqBtVjQbgosIJs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003)(6133799003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zzoSBVYZ/N3gDuMr5UYZEsk2AiKmgkwfAo/nfo4UvSQCOg2vGRhRdGdketgWI2wkA6hi6g2H2Vm3Oa98RRUSCeYvFjQYFaHG1wSSFsTjShkSjYsmuH/Ks9tn9m0TaJAmOGd6IbptFWQ9hAThJm+uxP9ogEdaqwA+FG3gVKZEhRSoH378Z1912191nfR6EFY7JRs7Se1euX2FDKZT78K8JRcrijJ7y5aPkGr49z1DWb9/WCrN3KRGkGDGPCmUuXXFpyTHGrtH2IDMpiVzQA8nD/z3anhxWhIjEMr//anEcx1xSe0OPud/k5CAezN08UW5jgOogzrz7jnVuIrk5A92Ea6uA4vZxRfiFR6JkY8ixVU/z6VI4LcWc5/KrMLQNMxdjZlf89k7ZcuLMT0PQe1xx2Ykf5Bp9OskVl3Je4SV4HOiA3TTtKFoFd+WeLX0mqbv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 15:32:09.9014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fd000d-841c-4e3b-6b7e-08deba72c94d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
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

Set secure_submission_supported = true for the VCN unified ring funcs in
vcn_v4_0.c so secure IBs are allowed on the unified ring.
Without this, protected decode submissions are blocked by the
common IB gate and can fail playback for secure content.

For vcn_v4_0.c, the secure ring funcs are selected for the secure-capable
IP version.

This change only advertises existing hardware/firmware capability;
non-secure decode paths are unaffected.

Signed-off-by: Jeevana Muthyala <jmuthyal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 43 +++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ff7269bafae8..f7053f85593d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1992,7 +1992,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
+static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
@@ -2025,6 +2025,40 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.reset = vcn_v4_0_ring_reset,
 };
 
+static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs_secure = {
+	.type = AMDGPU_RING_TYPE_VCN_ENC,
+	.align_mask = 0x3f,
+	.nop = VCN_ENC_CMD_NO_OP,
+	.secure_submission_supported = true,
+	.no_user_fence = true,
+	.extra_bytes = sizeof(struct amdgpu_vcn_rb_metadata),
+	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
+	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
+	.set_wptr = vcn_v4_0_unified_ring_set_wptr,
+	.patch_cs_in_place = vcn_v4_0_ring_patch_cs_in_place,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
+		4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
+		5 + 5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
+		1, /* vcn_v2_0_enc_ring_insert_end */
+	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
+	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
+	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
+	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.test_ring = amdgpu_vcn_enc_ring_test_ring,
+	.test_ib = amdgpu_vcn_unified_ring_test_ib,
+	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_end = vcn_v2_0_enc_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_vcn_ring_begin_use,
+	.end_use = amdgpu_vcn_ring_end_use,
+	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
+	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v4_0_ring_reset,
+};
+
 /**
  * vcn_v4_0_set_unified_ring_funcs - set unified ring functions
  *
@@ -2041,10 +2075,9 @@ static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 			continue;
 
 		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 2))
-			vcn_v4_0_unified_ring_vm_funcs.secure_submission_supported = true;
-
-		adev->vcn.inst[i].ring_enc[0].funcs =
-		       (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
+		   adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_unified_ring_vm_funcs_secure;
+		else
+		   adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_unified_ring_vm_funcs;
 		adev->vcn.inst[i].ring_enc[0].me = i;
 	}
 }
-- 
2.43.0

