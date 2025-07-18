Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDBDC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8231910E9BF;
	Fri, 18 Jul 2025 13:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="umH9PRf2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFAF10E9BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHlx2Z/R1aNvyxYwzfDozIW2RznaFPoWirQre5/DBZWO6lxRENQHbtQIqIq6obZbbdhG8yRAoYGcRjDkEDjrCWKIpj8OKdj99r518s7AyJT/DfHMkGB0I1pparLVS5rMwXvQZKEYMslaOd0ye2Gu/aHHjK/Nf1ANGqZf43QvCUWsUx5dRrta4TB1iDxLY4HxPKvujg33ARE1bNfYPjCPAv9PSIwswEKTB7EfyZ6nHaXLwbRxlMQIeMsuDi0OtiTk2R4Sfn2zZvbG7CvBKHbAm3zCYfPnYffh9ijVZqBjbGN+NbFVsrPyjhHMxiQDMVHmD6itAihPkaDDUj8TLvJg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1bY6hNlr4+6cgrLocUdJpCa+KFeAMeo95gaG3e3cwA=;
 b=F6f3k74RkDmugYrusnZ/RIIeNzN8NHcfxQa4l6uvgKxHdEY5t4a1bAJc56VWKPGEeAEN6s5FUKjwgpx/hn+UFFSLFtXDB+o0a6+PP2FQiDBv6ek56ynblvIoB7uFrihjWpp+DXm5SAGkf29dZPYTSSRLDx5gh8moIDxZi56vIajZr4QWv7vGkEzKw7gtCaP22YH/+McjrItB2k37dUy66jt/togRy8JnhAawJIXpVF6xTfLRWr5mS/77fF/Wups38yVJ1h+YwlwcjPfqOAr2OJuDoV3lzqGkevdnwQC4rwBgbHbIizAMg6KyEMZS5Eg4BLWtRAgR3bTsqbWZt6FB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1bY6hNlr4+6cgrLocUdJpCa+KFeAMeo95gaG3e3cwA=;
 b=umH9PRf29HWBdAiLMJnEXNRW59+cGTrL/S3e/bnF4hqa15mSVy+4gxmKDZh6mbAnjmr6g4f5V6uzB5iVTkF1Il+mmqd5JEBzLPaEl2Mp/eMB0USiJwULivPpFBvuencM2wMLV9TQJfm6X3Bk/GapzMq5q38hyTUmDZMZ6G0iSzE=
Received: from CH0PR03CA0272.namprd03.prod.outlook.com (2603:10b6:610:e6::7)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Fri, 18 Jul
 2025 13:46:43 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::93) by CH0PR03CA0272.outlook.office365.com
 (2603:10b6:610:e6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 13:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 13:46:42 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Jul 2025 08:46:40 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/8] drm/amdgpu/vcn: Register dump cleanup in VCN5
Date: Fri, 18 Jul 2025 19:15:38 +0530
Message-ID: <20250718134544.2594829-3-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250718134544.2594829-1-sathishkumar.sundararaju@amd.com>
References: <20250718134544.2594829-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: a19d10d1-676d-47cc-4e79-08ddc6018752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzRNVkF2bk9CZkJNdGxlaVpSakhydHJLd20rTkU5Tm5pMHBDaDVsdlF1Z1B1?=
 =?utf-8?B?K1VJYnk5N2RvV1d2Ym9KTkg3YXhLQTJNaFBtbmxUemNaSlREWW1JbDhBaDIr?=
 =?utf-8?B?aXJZNWdZb2JmZXhPWU1wZzhicldzS2xPazJoc1dCS1FydlIzQ2lISlNLYlRJ?=
 =?utf-8?B?Y3QrSmQzWS9NS2J5ZGFOM1d3SDZ1elpTWTA5Q2thcEFFZVgrRFNOOFlJcXZC?=
 =?utf-8?B?Q3ZkcnFUNllaRnVpRlk2SlR1S2xKaU15cG9obGxuM1duNjh6OG1LWnBnbHJD?=
 =?utf-8?B?NTNLM1VpZVU0aVBwQ3M1ODkyUDRjKzVUV285ZGxXNlFTTjJ2dFluV0FGLys3?=
 =?utf-8?B?ZGNEdFdNK2UvaWxrdDZGZ3AweDk2bkpZb3ZVUlNnOTFwSC9jdjZHSVhza1JW?=
 =?utf-8?B?d0w3Qlc3ekVzcGRQZnBBWDFpSnJDRDlQVjk3WXdRRTY3MkZZVDJxeVAyOVlW?=
 =?utf-8?B?a2hLWXFyRmltQnhQNEVFVy9BdzNSZCs2Sml4allnOW1jWnZKblNGTEZRVFJN?=
 =?utf-8?B?dVhKa2RoSDF0c1dLRmYvLzhjTjNhRmRWSGRQUk51b000STRFRXUrRk85MkxF?=
 =?utf-8?B?ZVhBMnJnaTJLbU5CcmlZbm5ZL1VMdG94STg2dHlJd08wQUUrYkVRNlpjNTBU?=
 =?utf-8?B?L2t2L0t6d0x4SEJxUWJCMTlQS2MrNW1FZUtlV1ZQVlVUazFGQ1N6dys0aVZt?=
 =?utf-8?B?Nm55Z3ZMakVubEJ6a1NlOVlZZFhKR1I2VnFRc3hmdjh2d1pmVmg4K0YxRXg1?=
 =?utf-8?B?Ny9ybWtXYmhzeHJzaTZWUjZQZmtBOTREbTI3TmJndUp2Z0xCYmhMOWhYRlo1?=
 =?utf-8?B?OEwwakh6N0IyLzZMbGJvM1hTSFhDMnVSaWNQSTg0b0dPMW54SVM3RUNmckdv?=
 =?utf-8?B?MVRhWHBVeUVhKzlUQ1l6SlM2Q3pBdFk2K3F4Q254TCtzd2dQVVlHREl4RVZi?=
 =?utf-8?B?R2JLZm5pbWdNN3gzdGl3OEw2WHV1NG9TOWRucStjdFNUcnVMby9sNVIzcjRQ?=
 =?utf-8?B?ZGZwRTJ2dXR6MEYwbVNmeGxRK24xL0pxSStsdkdZWlFIcVJubUxQU0QyMkVO?=
 =?utf-8?B?c0o0WHF2bkoxa3pWZ0k5N1VxenVtMmJ2T2tkYVo1czBKdWpZakFMQTF6N3dy?=
 =?utf-8?B?c29jY3dmRW9pcjVldFlBd0EvK3ZWSGczUXAzaHZENFFjZkhXdXgxaVBMZnpK?=
 =?utf-8?B?emQ1MFlXdDZiN2RrY2dXMVN2R1hKcitZNVJNdmh6L2lPbHlnWGk0d1k2OVdx?=
 =?utf-8?B?TFQ0OVRsVm5VbllIRGozajlxVHpoTk9EOTYxYm9meFk2eCt3UUgvZlFDTTJW?=
 =?utf-8?B?MGdvME04TU1DU05NZnVhZGxPWERqK2V4N2dqb2kvcDNiRER0VXZ6QUVSZktq?=
 =?utf-8?B?eFZoQ1hyNCsyVVc1M3FNVE51eFV5cUFVUUYzV0UvTjlYNTJvNGM3VWQxUHMx?=
 =?utf-8?B?VHJWU1htaHBMcVNENXNVSzVlRUQzWWZBZFIxZnZ3VnpuZzZ0aUplVHg3TUlj?=
 =?utf-8?B?VW8zZzN1dkpQcXRJWlEzQjM4R1dsQ0diTVo5dFJVVnRielNoMjZ4R3lPZ3ZN?=
 =?utf-8?B?WEFmUDFzZWJ6M05yZW5nZkJoYlE2SlRZVGFwKzFlU0NDTEFUdE9KTE9PQ2hh?=
 =?utf-8?B?bVVydmh5MWxKa2ltOE96YUVsWjdqTm1WaThFazl0KysrL0wxWGx6L2pNZlpy?=
 =?utf-8?B?c2lFMnJMdkVGQ2g3RDltSlpsRlZXMnF5QWgwK0NGZHFDd3lLc2phWnhucUUr?=
 =?utf-8?B?alZ5QW40YmFNd2Q3Rkg3NTZFakxNYy9zVWQ4UUlhTXpRUmUwMXFIQ2gwR0lr?=
 =?utf-8?B?OUFrbE9jWVZQcVZyQlh1M1hTeXVqdTdBcDZCZGNodlhHK1hwQlFTc3MxWUxF?=
 =?utf-8?B?OE9JWXpHTGdqYTRGbzAwZVN2L2IrK0ZGQ2ZSaHBUejdUeForekZYR2NRWmp1?=
 =?utf-8?B?VEY4VUM1L05kQis4ODd6YXJkTk9pOEErUHdVang3TTM1NHdXclU0RmFtLzRT?=
 =?utf-8?B?MHp1aHRybnVqaUd2cVdVbi9LUGN1bVhzOUU2OGJYV3I4dGZjeHJrMkpVTlBV?=
 =?utf-8?Q?WF+Jk/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:46:42.3244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19d10d1-676d-47cc-4e79-08ddc6018752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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

Use generic vcn devcoredump helper functions for VCN5

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 86 ++-----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h |  5 --
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 44 +++++++++++--
 3 files changed, 44 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index ec0268b5666c..e1fbacf15d08 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -115,21 +115,6 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-void vcn_v5_0_0_alloc_ip_dump(struct amdgpu_device *adev)
-{
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
-	uint32_t *ptr;
-
-	/* Allocate memory for VCN IP Dump buffer */
-	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
-		adev->vcn.ip_dump = NULL;
-	} else {
-		adev->vcn.ip_dump = ptr;
-	}
-}
-
 /**
  * vcn_v5_0_0_sw_init - sw init for VCN block
  *
@@ -201,7 +186,9 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_sriov_vf(adev))
 		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
-	vcn_v5_0_0_alloc_ip_dump(adev);
+	r = amdgpu_vcn_reg_dump_init(adev, vcn_reg_list_5_0, ARRAY_SIZE(vcn_reg_list_5_0));
+	if (r)
+		return r;
 
 	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
 	if (r)
@@ -251,8 +238,6 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	kfree(adev->vcn.ip_dump);
-
 	return 0;
 }
 
@@ -1431,67 +1416,6 @@ static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-void vcn_v5_0_0_print_ip_state(struct amdgpu_ip_block *ip_block,
-			       struct drm_printer *p)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
-	uint32_t inst_off, is_powered;
-
-	if (!adev->vcn.ip_dump)
-		return;
-
-	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i)) {
-			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
-			continue;
-		}
-
-		inst_off = i * reg_count;
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered) {
-			drm_printf(p, "\nActive Instance:VCN%d\n", i);
-			for (j = 0; j < reg_count; j++)
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_5_0[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
-	}
-}
-
-void vcn_v5_0_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	bool is_powered;
-	uint32_t inst_off;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
-
-	if (!adev->vcn.ip_dump)
-		return;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], i));
-	}
-}
-
 static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.name = "vcn_v5_0_0",
 	.early_init = vcn_v5_0_0_early_init,
@@ -1505,8 +1429,8 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.wait_for_idle = vcn_v5_0_0_wait_for_idle,
 	.set_clockgating_state = vcn_v5_0_0_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
-	.dump_ip_state = vcn_v5_0_0_dump_ip_state,
-	.print_ip_state = vcn_v5_0_0_print_ip_state,
+	.dump_ip_state = amdgpu_vcn_dump_ip_state,
+	.print_ip_state = amdgpu_vcn_print_ip_state,
 };
 
 const struct amdgpu_ip_block_version vcn_v5_0_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
index b8927652bc50..51bbccd4360f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
@@ -32,11 +32,6 @@
 #define VCN_VID_IP_ADDRESS                         0x0
 #define VCN_AON_IP_ADDRESS                         0x30000
 
-void vcn_v5_0_0_alloc_ip_dump(struct amdgpu_device *adev);
-void vcn_v5_0_0_print_ip_state(struct amdgpu_ip_block *ip_block,
-			       struct drm_printer *p);
-void vcn_v5_0_0_dump_ip_state(struct amdgpu_ip_block *ip_block);
-
 extern const struct amdgpu_ip_block_version vcn_v5_0_0_ip_block;
 
 #endif /* __VCN_V5_0_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index cdefd7fcb0da..00b6809fb3a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -40,6 +40,40 @@
 
 #include <drm/drm_drv.h>
 
+static const struct amdgpu_hwip_reg_entry vcn_reg_list_5_0_1[] = {
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CONTEXT_ID),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CONTEXT_ID2),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA0),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA1),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_CMD),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI2),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO2),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI3),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO3),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI4),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO4),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR2),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR2),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR3),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR3),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR4),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR4),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE2),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_DATA),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_MASK),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_PAUSE)
+};
+
 static int vcn_v5_0_1_start_sriov(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
@@ -163,7 +197,9 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	vcn_v5_0_0_alloc_ip_dump(adev);
+	r = amdgpu_vcn_reg_dump_init(adev, vcn_reg_list_5_0_1, ARRAY_SIZE(vcn_reg_list_5_0_1));
+	if (r)
+		return r;
 
 	return amdgpu_vcn_sysfs_reset_mask_init(adev);
 }
@@ -209,8 +245,6 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 
-	kfree(adev->vcn.ip_dump);
-
 	return 0;
 }
 
@@ -1475,8 +1509,8 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v5_0_1_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
-	.dump_ip_state = vcn_v5_0_0_dump_ip_state,
-	.print_ip_state = vcn_v5_0_0_print_ip_state,
+	.dump_ip_state = amdgpu_vcn_dump_ip_state,
+	.print_ip_state = amdgpu_vcn_print_ip_state,
 };
 
 const struct amdgpu_ip_block_version vcn_v5_0_1_ip_block = {
-- 
2.48.1

