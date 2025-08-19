Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D6CCA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 09:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C029410E573;
	Tue, 19 Aug 2025 09:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tDghJaFM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5844310E27B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 09:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5NUJIU8lScPzlk3IPKpBGWMNie9GNcM/urRdNnIBCtNKw7ASKCDuBHKuG5vJWJpoyfXHc0Nj14T1edQ4x5/GBEMru2ZsAPXnoK9J+k/xov+1bMMueOIVh+LgtLDaDnFZ2zs6PK/tSnwH/bortFDQw1kI1sQftAdUOHmk5+KwZvoMLX+wOlCwROedptFzrVuwjRrbqsg2RglN60xItCFUzr36JeAwko0OQp+HhjHEfGiRjJtLa6EO2hYT3k/BpZplX2HRXF9Wnw0BTkcZ+RSQR/MDBbU+qv5xW7x2xbfL2lPyld2TU76XbDL+ApFCcG4SyiuJtgr8gA50gN94v325w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQmJnPb595T/hDqLsHWSnAintds4pHAD31hCfREAU80=;
 b=Itiyjbn5b4kQh/hRHLHRQTl1ysDRgLO7+FEtvGcNKUOFjBQgAChPPh4OXnOhcpXI6lp2tJUbtpf0d5LrfdTLWksFrjNtoIUzW68hRGz+g3ABZ9iyPqmSvkS6JBRWLZalwUDdaWtUVSE2/oBhV3gQqYLfMvTlortXEN0nF8nrDvR8XXhITWyqjRTLG5ammP370bthCTIjAiRQoyNTLvMPdCdTHDsj4eNbnOkbI9DMQUEt1ylS11JHNS19CuO/YUTPrutwMwt7y1vKj56yh+uKCz+U+P+STJd/xV0zAPcWTWwro3XqmRksRgra/82+bcCGhhtCz9DSPY5lu8oQbyCAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQmJnPb595T/hDqLsHWSnAintds4pHAD31hCfREAU80=;
 b=tDghJaFMQvAQzKsxEnLkxXgJXB2WWK8xAAi5GzxFjcGwoQdot7+kWr5zyq8REya/pHYRu1ohSFHcSOSZVJKBNJvedTQnU+GWehNVpucq2lqKEcrRAi1zi1RgyiAKLqgbTixIrtJHBR36ZvnkSY3EVraqlQhjq77BRHtN/zBtW3Q=
Received: from SJ0PR05CA0149.namprd05.prod.outlook.com (2603:10b6:a03:33d::34)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 09:18:11 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::20) by SJ0PR05CA0149.outlook.office365.com
 (2603:10b6:a03:33d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Tue,
 19 Aug 2025 09:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 09:18:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:18:09 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 04:18:07 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v2 3/5] drm/amdgpu: Move VCN reset mask setup to late_init for VCN
 5.0.1
Date: Tue, 19 Aug 2025 17:17:07 +0800
Message-ID: <20250819091802.445099-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819091802.445099-1-Jesse.Zhang@amd.com>
References: <20250819091802.445099-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 4338e6d2-2c29-4276-3fe1-08dddf015111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W3uitVcreLGi6RUOnBKz8fxINta/y+pJcJqU4i1dvNeOmjjHUFv5OnWB5VBO?=
 =?us-ascii?Q?cZ4O8INtKieKziqWGbwZDFdNiEMfbqWiMCfULYPfdFeAQHNQm+kYiIgZ93rR?=
 =?us-ascii?Q?IK5lfUafUkdbcVw6Lz4Fd09CFaYUlTQTfN8we+XvrW8eXBSBg5xvztsfju40?=
 =?us-ascii?Q?ZCNdLS+un5H/POt560cnnEh0yIw7RtRh44axOCksGgYFQzdbINActzRIJ6HG?=
 =?us-ascii?Q?EH3qek/3/tIPsB57kZSas9SvDhIs2GW+r7zUrJvPg76TU0wNO0wDRzzGbGn2?=
 =?us-ascii?Q?4Y2x4aKnWgTdy4XUdQD1I2ShnRvlQPnTcqHrE9CHoQH7eQWxj/2dR/tquVvo?=
 =?us-ascii?Q?VL+chZm9efsJsFaQ46k5fWUEh1LMQG8szIIgRKkTj71Wol4Ae72bg5N4uGOf?=
 =?us-ascii?Q?xPZzDH5/8XPLFGQgwYS/4s1jSA1tEGgWx4LDlNL4Jv8r0uDsIThApC/GUvpw?=
 =?us-ascii?Q?elZpeAAneVvUdxd3pZJEJgmRJwZF0oG+1Ar/sI2dzK/tIrtSj9e/Iqftzy2l?=
 =?us-ascii?Q?Qhj0kwyP76IB8l+zv9nIQRDzcXXqpYhnmkky940JLMZUN5pcQSvZClATzSeC?=
 =?us-ascii?Q?WnQQU/wgvT+khhT6qXZuaG5BxyPlw7S6WHTZ5fIyls8yBuE5eipfN2rTena/?=
 =?us-ascii?Q?GG922EkIdIbtllGkg8NB1OSk7Ymp+cpxWctMMq1vsMZOs+Ylvs3gvmuzxV2p?=
 =?us-ascii?Q?diDVdN7Hj1IGOPBe4wkji5PUfFRq9Gse4WauvHcFWsXea1Mrb5JAr7wim73T?=
 =?us-ascii?Q?aA+epTPiYY0TJK4nIfGx6AHRGK8nIDtUkUdaj75C0juL0d6h457dTrJpyft7?=
 =?us-ascii?Q?MIpa9SKR+2bAl0dJo0EW08PojMnGXF4j18Kb4YyfPggvruDLx7m9dvtz3f05?=
 =?us-ascii?Q?+XKGvm2lxR+DAM7J9HTiX3MXPfPgGhIG/LtXdPGhZUjvzdeBrlwErTJKcqBf?=
 =?us-ascii?Q?HpMJPk8ymPdGdfU5XPvKpzpbo7rDgbzRRLNK+eLGjPFXYOtSuo90jHLle1dC?=
 =?us-ascii?Q?ccDqvo/BDNEfVEz5UNr85KP9OTRCTU+RZF/kYVO+IbOtiIp9o4Rh+hkQYk2o?=
 =?us-ascii?Q?9UW6KHZoOuNAdtLWQIuPfR4bwfArUjjlJm/T4JiOB+EHOiePYb0zijlUu/oB?=
 =?us-ascii?Q?/4d/umek9X/IubM1HncNzj5BH+m0QAJSK61y8/Q/0TEt7Pnc7R87klHfvyW0?=
 =?us-ascii?Q?TEmGyoSA2RlgMOvzJJY6uVbkWJIB/pl6Thsw8FZz8duBdwpoRC/WXM3JLQ3e?=
 =?us-ascii?Q?EZw9BBbe4ZDP+1c4FVierS4aToEZWV7/l3d893dIQqNwfISGSMoo8GhRpQSJ?=
 =?us-ascii?Q?2XrNEi5NISUvaw9kSos8IOQDaRolDhOw4wtV5B99vYX/MZHgxxpbOXpINb8u?=
 =?us-ascii?Q?ifFCtv7LNM/4a/VJEhtPsHo/L6bpYg2RaLRZq122zh3hmyWKveqaZnaTmuEx?=
 =?us-ascii?Q?Fu0XbDbZrbPVIP2RjPiMieTNE0WsdDCrLaRUvbQLZLcQYVlRcxaTcJzgOnbf?=
 =?us-ascii?Q?uQd0enuj1FzCCSx6XvYy+MWwxstU2tOZDp0m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:18:10.3647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4338e6d2-2c29-4276-3fe1-08dddf015111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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

This change helps ensure proper reset behavior by waiting until all
dependencies are initialized before determining available reset types.

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

