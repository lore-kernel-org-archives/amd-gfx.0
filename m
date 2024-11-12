Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A1DD42B88
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 14:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC14C10E5F1;
	Tue, 12 Nov 2024 14:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nLLsv2Jz";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97ED410E5F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 14:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKNyffCEqigqDBjJ3h0IgG03HSQm0oaLYszlAq5s0akk0d74gb3gE2WvPNCOgoRWbBXo6F6svNjqurSFSMvUDG8eEa4b8jFLpXWXfE+QUk+1XQJwHjr0BIVZUaBCjqa/G3qzOh7IT+RI955N9u8vs0LyZ6iCeSU04UvgGZXi/YMEd16xLw3Hu1dPrtwOcukLwXtJCdmWGBu9EppfhfZ3DAu/eE+oA4xJwvLjhkzJkb0f3dLy9QAG4ao+py2LxubxjmHsqEXOR+40F7SfPTx577wkeT2gYilGrZzJ78q6oHNyC1kSRP0+/1zRsg7Dt3bBO3Jni2coVHHfjeCC469dHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=850GqoxMXWBODN7wbwE1YWTbkNqSNHYkEqqHrxeyL9E=;
 b=POYEBz86FGfpgyOunpFAQDesI6Vl4kHZAwr9Xzr1M4e0/odB42t9ngxSsdNsqkq4P6NZtABn7RAwXOV9xWvdIE+B1zRESP33ttzASMv6GdK+xwBtKpKHDxB4pM2GZcl+XK+Uvlg+M/gPtbBw+AgCerh4dENeZrIQ5vOgOSuz5trLr5lAiyPBREM2dHUpJYvDkjfEzpX52Q55A0YaB1mFoC7F1y+IsEM35rBy8umJ+JqptuwKHbn9QC3i90J+tdkKmxDmLT6CfwDdeTe1b6Usdfiz5fmj0HqE9OHw0RWCuhQS0yo/j9sFKQGNOTbGlZzAgXO0r3IENjch4XqwTbflwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=850GqoxMXWBODN7wbwE1YWTbkNqSNHYkEqqHrxeyL9E=;
 b=nLLsv2Jz1T4cGIwmkzo4leAhN149bAhLuLDT+c5WNZ/XRfp51IbVZiLDtF74ShuaWFw0+T4jSleeX1gOk2+o8Xpfz3ezL0UyqAYAm8IGYBFzqnFrfm0oh7j7rYSv27lBxUObPUw8sCkBfjxoRY8iLQ4/ETCahUS3L9Azk4F0JK0=
Received: from BN9PR03CA0810.namprd03.prod.outlook.com (2603:10b6:408:13f::35)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 14:30:55 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::e2) by BN9PR03CA0810.outlook.office365.com
 (2603:10b6:408:13f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 14:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 14:30:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 08:30:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 08:30:54 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 12 Nov 2024 08:30:52 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
Date: Tue, 12 Nov 2024 22:30:50 +0800
Message-ID: <20241112143050.1931822-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241112143050.1931822-1-jesse.zhang@amd.com>
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a173d20-ba59-476e-ba2f-08dd03269e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oelqsz7/+HqmEWaVujhOCufkwlgmNIol6+JEPFUFyrzEM/rWOMa5oCEe2qW2?=
 =?us-ascii?Q?geuYjkqRSvtQtXV7OTHjDHZLBnqUpwXnhw3UynJEzacgmqvasqw3EA9kxO5e?=
 =?us-ascii?Q?pX+5scTA0OyqIkfiqpN4O23oSwAjVEh/9oQ3MPHe4o0Zwbb5Xw3vuNCiAikD?=
 =?us-ascii?Q?0XqxP+7q9mw/xzJso2d1XxuTZN5a1+FAoQep6GevlYpt4XDbscrirhh1Qu+l?=
 =?us-ascii?Q?Bjyu4mlAkTHvVUo0+7dlxsLMf7zsLMFqNGcjPhZNP9+owlCTtxaiFGG8C2KT?=
 =?us-ascii?Q?p42pKxMZ7VqzO2GzCUEIUi3mMY1Wa7gkVIQ1zStrtJy+2cYVH82Td//6Zef+?=
 =?us-ascii?Q?04hOHdtHbQLJN4bLXGbbiLwjdTmMhWTRIjfs7oBRC2GZIvHmcvAFjCl1MM8Z?=
 =?us-ascii?Q?sTFtG7LKLiU5w+bK74p1yiUvqDy85eK3v0OcfQWXxTtSRKErlIEea7q0+RC+?=
 =?us-ascii?Q?MLZno0Fl4kPZzLy3sm0ScaC0GPGXo2gCDU90OZFcWI3l4ckaPM9wCNc4tz62?=
 =?us-ascii?Q?2vUwtY4OypsRLxelaMYuWGPCWnI6cpTXoeDUuoNIMafolEROiV6XrA9w8Xqn?=
 =?us-ascii?Q?BqFauAuO1Jn2SdV1qSeuu69TmmP9KspSPaePzYUzSXU4K2ZJ017TvQ0ZkX4Z?=
 =?us-ascii?Q?WVhG1EwGl/lgaTEauolbZW9JPD3SiIc628v/w1nzfLU7Y3Ag0VQLFvY1fajk?=
 =?us-ascii?Q?8vmhcoMtYycbLpGRhcFYQnkgcTEgt8rj9WuWxsZihtlYVWuX9RmDeATbf8mm?=
 =?us-ascii?Q?F3AwAQsfWiquEiK/UGLxJT09z82+8xwFfI+lfPfKT7LkxaWjyZZ2TfHFp0GV?=
 =?us-ascii?Q?Mq4C/FTEi1ZNagM3cB/A9jwqKlnnzP0qLaxsuGgXUWHNVt+J0MW8k8y3mv22?=
 =?us-ascii?Q?/PHZZiu0HcdMtqF0Ln3CuqE16eAPb6TU5XWZJsjT0VJZixQOAcqMy6jgUL/T?=
 =?us-ascii?Q?5+wYWr0qMZ067bov8/LyXyziorRhtfCnlFVz6kBzPAdiz6VRvB1vW6sQlYev?=
 =?us-ascii?Q?6de3ATtJcz3vfNoEVOJkBCycUuIRrgzdt91T6URB/KWiSgui8Q65te/c6uHs?=
 =?us-ascii?Q?xcRb7pn0mHptD+F81xXREh+oyIOVG1V2wpLyWynM+cMI120BbNeaDqGa9lFj?=
 =?us-ascii?Q?GCM4CYaCW/XNN2BFkxl+hlIUCJ0gBEwedLEqLR6oY9FTTq8Te8lYoqLtyB9I?=
 =?us-ascii?Q?H0S7je7pnv0A0K26f1fTIN/lYpVI5xmjbVqm0cFZD0/0SqHKOdNxT/bLjvKu?=
 =?us-ascii?Q?4d4yaxqoAnFt6fgi+aFi4Tz930TaWMJ3IL7wBcROCtrE1wFSuKPUivGa/VL+?=
 =?us-ascii?Q?PbBm18rWlO22R/M/8Lysmu3WJga6atNt/GXZp5TEfLvoE1jZ+m2Pk+Mbr3xj?=
 =?us-ascii?Q?GGiZQekVVXDJYBn30iVG5r6Sdx8cNj6yWFN+rtcdUjUoyNGf0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:30:55.2610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a173d20-ba59-476e-ba2f-08dd03269e25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
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

[ 2875.870277] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP block <vcn_v4_0_3> failed -22
[ 2875.880494] amdgpu 0000:01:00.0: amdgpu: amdgpu_device_ip_init failed
[ 2875.887689] amdgpu 0000:01:00.0: amdgpu: Fatal error during GPU init
[ 2875.894791] amdgpu 0000:01:00.0: amdgpu: amdgpu: finishing device.

Add irqs with different IRQ source pointer for vcn0 and vcn1.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ef3dfd44a022..82b90f1e6f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -83,6 +83,10 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 
 #define NORMALIZE_VCN_REG_OFFSET(offset) \
 		(offset & 0x1FFFF)
+static int amdgpu_ih_clientid_vcns[] = {
+	SOC15_IH_CLIENTID_VCN,
+	SOC15_IH_CLIENTID_VCN1
+};
 
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
@@ -150,9 +154,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* VCN DEC TRAP */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-		VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
+	/* VCN UNIFIED TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
 	if (r)
 		return r;
 
@@ -174,7 +178,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 	ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
 	sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].aid_id);
-	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
 				 AMDGPU_RING_PRIO_DEFAULT,
 				 &adev->vcn.inst[inst].sched_score);
 	if (r)
@@ -1734,9 +1738,12 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
  */
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst)
 {
-	adev->vcn.inst->irq.num_types++;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
+
+	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
 
-	adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
+	adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_3_irq_funcs;
 }
 
 static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.25.1

