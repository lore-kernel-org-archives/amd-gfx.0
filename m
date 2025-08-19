Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35102CA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 02:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AF110E503;
	Tue, 19 Aug 2025 02:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RvrLMjSs";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A4A10E503
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 02:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JttsZNVLcq+vmcylNAoGvLGI7noQvt2N5fEI6CXna/gLIzIo3uw/ILO+SzjzTIC6JNv70ljbQiN88cpIm6vbReSkge21Ck+faSWbv1A8ky5F54Djcqgw/WtoB6XiTQbeF/1RLDvCwBc3o7qUWE09E2xRqVDNWvFknfUH3yTaiZEgKmuIDZJU36405JlTHwDbQQYQgTB61sMxVF6oAtt35NiwWbJwUMKBqqjyRFbn1MvohL5H/3kqksNWfzViGL8ruRW+HjQmyf3TJYc3pvuBJnZkg+VB8dCeL6r4UM57TGVOOUYcW9muXKfIjmt6+1FFTsVnmpBX8X3ONRJovTk0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCCLPyR32Pz1Xld+ZvxnW0U/3X1//rIIzN1J7D1nGac=;
 b=BJ4S+MSxBAippXCgLoHnKD6Hk9k3LHrfmKXurxTBF9WbeGeLLOradu7DKHUjhUkLN6SvqiFynm9G64BB4VN+hszAQoP3dRQbkfPB9tcQ8JzBBNlntzodw4ty8JqILAB7++DsF94cCvW0X84yZypR1C3/YGDnubM6huVDkV/Rlq1Xxfo7B3301lzmgjCaM3zj7ttbv67+Lh/+Z4NYGcmoX8mnXX9obeWvx69euq+yku1H6sypOMInYbzLVucMPKwMZjq4ym5VdU5aLNDQiouxGorR/C/SqKdSS4c/9sRS6wJiWEqicFqXkSONLiVAvOE6rWMPbjW61QHAKVMHk9m2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCCLPyR32Pz1Xld+ZvxnW0U/3X1//rIIzN1J7D1nGac=;
 b=RvrLMjSs2UiGl9f8Es62DFgVN/gxxGZoVsiGtZIWyO7k5Ayc+RjduhFbJIBPMobn4BvWydcKP2y9WEsMcFL2fq6QO5nAzNPWE+9mImalfYBRs/F2Jpt+QMqCrK5u7M9W7kH0yAAnjk8ZMORrYYsTkJWCN2t4Jj5EYlCJlRIps90=
Received: from SJ0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:a03:331::32)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 02:15:20 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::5b) by SJ0PR03CA0087.outlook.office365.com
 (2603:10b6:a03:331::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 02:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 02:15:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 21:15:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 18 Aug
 2025 19:15:19 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 18 Aug 2025 21:15:17 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Move VCN reset mask setup to late_init for
 VCN 5.0.1
Date: Tue, 19 Aug 2025 10:12:22 +0800
Message-ID: <20250819021511.4002952-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819021511.4002952-1-Jesse.Zhang@amd.com>
References: <20250819021511.4002952-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 3185da1c-e2df-46f5-88c8-08dddec63f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u/Pv8S+VGj54JFQ9gt98x6mbVKI2SNlzR76cfSp6yoScPm3qlu/7E4sFoy/3?=
 =?us-ascii?Q?fLVjxI5ueE0OLue6BEHelHgFN5HUYDI9MSIqJASkfo6XhFHDNszxVJCZllrs?=
 =?us-ascii?Q?KK+myHADgdWGZz10+Tr6ZYPKNFj+VeP8NGac/vZD8p00TBnx2VVnK2DSNlVP?=
 =?us-ascii?Q?wZ1U8h1Kgq8FBAzQwPphvaK5OZjkHwSVNZ8bRqnRaj7D7J4r5DlqUFai7yct?=
 =?us-ascii?Q?9QBFOZLiXV3KJZjVyk2IK+OtoRUDkcQBC03P7cA0wz0joaSBWJmIX5OBqng5?=
 =?us-ascii?Q?gb/aqmurM+vkqYizhRETiCwt/wXb0nIdnnVeR9csfhPl7tWP7d/DSDMaB64V?=
 =?us-ascii?Q?pZAgm6PgotNAI0P+F4+7XSEsr+X4nA0gBZCX8U4L5Llc2ARRmrh/paCIPwV3?=
 =?us-ascii?Q?XuOa7xThAmBGJm7b7R21LAoIjWqChLzTi93zu1xqLXccSgjFaVm0QhPKEEpY?=
 =?us-ascii?Q?1fRPC/m2atepq+0C03FPg0RtC/5Wl/qhLBP8qQN0meey4nkvv+mPmM81EeY9?=
 =?us-ascii?Q?J8h0pk3PIMf3gYYSDZtmn5WaKnRBzxLugYv/k9o6DZVyZZW5bQap6Yj889ZF?=
 =?us-ascii?Q?Yaeywb95SRukLDVHj4KUZ0F3TSIsfYZsfxYULCpwIwXdkh91d7GIRfbyRMHK?=
 =?us-ascii?Q?a5CLPilTXoDx1KjZ4VN1NuyENLknKKOUKec6fRlSpmAKbxoprLE0H0btKNFC?=
 =?us-ascii?Q?7B8KZi58ekXsRNIvDBdzbBHSBvgcwhc9IrOigcHoStN1b1mqboXnsIoQ0iba?=
 =?us-ascii?Q?ID+PnBnQxEvYvOtuPRxdzmCu5OkP55lnEPK8U0ysWQBPzavUEfqojOoIqAUs?=
 =?us-ascii?Q?gpke29gB5vgj+Fb6GZ/7Ha/dJrQumK4xRNbZYm14fO3h4FBtwOYsE/5ITfYq?=
 =?us-ascii?Q?x+/FQxyB29ZcqbHSax5q13GniYseN8zS3csGbWm0UTK8dWJQAeEch/XH3CUJ?=
 =?us-ascii?Q?Iu9BUUO+oN9lxuvTE0uwf9jQ9IVqNT0ZIrIQ1SnU6P07baC8f1mtUVnTJ3se?=
 =?us-ascii?Q?OPbPzPczJe8Qyr60sMW2EwO4aY5BZTmEdbOAoXIjnRtZBdSX2n3sT/gXIxot?=
 =?us-ascii?Q?7HjFEizv/kJibbf171EXJ4zo2iBclkPOcLIFIXzmO+Y0THK0F5Xgf4QPol3O?=
 =?us-ascii?Q?2zouKlOWr19e5Zt3kHHLAiBoCxop1fH3yum0La6Up80yjkPqmUuQxMRluxnf?=
 =?us-ascii?Q?NTYqrWhxTf8LzTx2OtGSrFFkGVWKMsLsMGW4gqZ/w9k2/IvDFY1XKxyUBSNA?=
 =?us-ascii?Q?5GV9zAhcbrKP748KaLAr5mdjWoijEBCNZsYhvWkeW5KvjiQhSyps6on/tSEs?=
 =?us-ascii?Q?0n5r9K/EL79ZZM9wjepXDqF+x/RPuDh1Zsp9MNg0j/oc7jujOSWnrGR1e5vU?=
 =?us-ascii?Q?RMoCSVYl+E0BkvzU/c85FuK4pvSKXOGz6EOBIRwCasMCHdHYPnImxLSNn3Zj?=
 =?us-ascii?Q?w5SyM3v2vquKdX+V7LhUHP+5gjLw637u/ENxU0KMvyPg1GxwWtr/pgvQ9YLi?=
 =?us-ascii?Q?H/3ys3gtLGKyaNaYBhk41NrFqR+Zk/C8gG/X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 02:15:19.7681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3185da1c-e2df-46f5-88c8-08dddec63f0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410
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

This patch moves the initialization of the VCN supported_reset mask from
sw_init to a new late_init function for VCN 5.0.1. The change ensures
that all necessary hardware and firmware initialization is complete
before determining the supported reset types.

Key changes:
- Added vcn_v5_0_1_late_init() function to handle late initialization
- Moved supported_reset mask setup from sw_init to late_init
- Added check for per-queue reset support via amdgpu_dpm_reset_vcn_is_supported()
- Updated ip_funcs to use the new late_init function

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 3b6c5bd8abdc..672821f9c47e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -113,6 +113,19 @@ static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v5_0_1_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
+	if (amdgpu_dpm_reset_vcn_is_supported(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	return 0;
+}
+
 static void vcn_v5_0_1_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
 {
 	struct amdgpu_vcn5_fw_shared *fw_shared;
@@ -187,10 +200,6 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		vcn_v5_0_1_fw_shared_init(adev, i);
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->vcn.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
-
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1549,7 +1558,7 @@ static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev)
 static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.name = "vcn_v5_0_1",
 	.early_init = vcn_v5_0_1_early_init,
-	.late_init = NULL,
+	.late_init = vcn_v5_0_1_late_init,
 	.sw_init = vcn_v5_0_1_sw_init,
 	.sw_fini = vcn_v5_0_1_sw_fini,
 	.hw_init = vcn_v5_0_1_hw_init,
-- 
2.49.0

