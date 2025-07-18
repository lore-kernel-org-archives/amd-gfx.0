Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B178C83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D6810E9BA;
	Fri, 18 Jul 2025 13:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QJ+9hHAv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D90410E9BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EASFEGWLRfdP3QYlFvJi2mqmmFlFG7drXZ73lJPSGR0EEvL9Gb8ibP73z2fzyykPUfUcqA6V6VneG378fM3r3DJfUzidSM95Ww9RaU0yiIM7p0EdYgYikKUBmsXra21/b20Z2MlNWIa9qOity84aCz9Yrn5HpqUTs1/NKTeJ/sRuVPExaufDzko5/ptkAbaGbAFzPgrS+XbPNlYVXIX7qHM+pj9lN/WH/Pmm50QHHTG+Kuq/YSZXM2UzGYfgjED1eWmsffs8DzpsfllO4lsQ3eoZHGB8Tzh1nxeP0wBncxHqfQGCD/uavHLf6eMBFLOJp91DMjsU9z+CtFTDBKrl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xvYL7dwiiWBeC5lN04SORy1e5vjiGcoPhzT3GgLlVs=;
 b=o0QInzg5mLKlN/F52sSoJCSLRvyeelsvFtGORYdD82y4N0+tZVb43iX020tkuITFuqyCWjAfxxDtdAup8L6OlU6311hDvdcrXdmhtg7jZilvrnQyO6LW7Ydk1azXyBJncHvfM+YUZl/LFECJ2B7HQdv8R/4UX0J/ZRN/NAQZWQNzc5ea7qzfxufna/dW9P7Gx16FtFuZq+9LdPaEB3ayYgj31Zj7ID3B+Q1hIz7PCC6JedNVJfNkhfoqezI28Vj87ZKI7pkXZt71FaZHSJ7Rv0K+5HTWJGVYqqg8fmVNVobUda8JNs0HluBiGCX4oIJjXpDvxY5jKPtLcVYMShHjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xvYL7dwiiWBeC5lN04SORy1e5vjiGcoPhzT3GgLlVs=;
 b=QJ+9hHAvzLyQxxApBjLTs0pAbjDNDI3Y9kVCM9mMguhOYdYpLcWIx6Bqt4Ki+UAjRHknsUyNfR7zpkfRvtPK7AhB85Aa3mfO0Y4jbquh+CbH61UAR3f0fBFHD5CYIyHsubN+rtSI0BVqoi6TmVMkXrWPwzoDAMx9bfOTPbd8dYw=
Received: from CH3P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::11)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 18 Jul
 2025 13:47:41 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::b3) by CH3P220CA0029.outlook.office365.com
 (2603:10b6:610:1e8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 13:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 13:47:39 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Jul 2025 08:47:37 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 5/8] drm/amdgpu/vcn: Register dump cleanup in VCN4_0_3
Date: Fri, 18 Jul 2025 19:15:41 +0530
Message-ID: <20250718134544.2594829-6-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 81afe0be-93a6-4eca-1c99-08ddc601a958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTNQV0IwbWRoaDdJSHd1UTRrWXJ0c0lMOWZBUVFwcFhEOFZrYTBzQTF1dmNl?=
 =?utf-8?B?ZkFYRGFEZVY3NUV0cStxQ3lxd3ZVVE93S083TER6cWVBbDRIdmNIZTlkY2Yx?=
 =?utf-8?B?a255K0RoT254WEZOSXorU3hDdUFrckdDREVsMkkzUlVWK004S2xhQXZweFQ2?=
 =?utf-8?B?cXhiZnY3T3JtVW94ZDZNeGFCOGxTMHREaHVGa3IzZ2NMWU9BK2dTbW9iM1hB?=
 =?utf-8?B?UmN5eTJFVjFOQ3BGVzFTVDN3bjdIQ2VxU1MrYndmT2c3M1lmc3JMMjBVbi85?=
 =?utf-8?B?c2JKblUvcWNkK2ZSNHpYT0w1MGlOMHpVYzhaR0YzM1dySTc2UEwvdlAycXpQ?=
 =?utf-8?B?Q1BkWHZPYlRCbXdUaHdDek55eGNTTng5ZGJsOHVnSklkWGRoMzRuemNZR05H?=
 =?utf-8?B?d0FpS2RWQUI3VWJzK01OVGZ4eHlvUUxGWHpxa1BTbjhHSEJSYUwyRUhoYzFJ?=
 =?utf-8?B?cTFZVkhoZlRUU2l0cjBDV1F5T0xpaUZUTStFNFlRUUFrMUxnM2YyalcrcFZJ?=
 =?utf-8?B?eXNqYnZKbkY3M2tlNU9aUDA0NnIrYzJVYWtFVDFkNkZEV3I4UXVhQkNFZ25y?=
 =?utf-8?B?RDlHcjZ5Y3h3QmNOalVQNmpKbWdGN2R1YlQ4RXdEcXVSN1Z5N2h1VUMxVHE4?=
 =?utf-8?B?ZTQ1VFZFcFhIcnJJTStrWnUyS2s4MnFLNUxVMHgySERRRUExYmYvOFJHdFM0?=
 =?utf-8?B?ZFdzaURIalRQQXg2SVFBYVJVS1liZXFVTUozc0hqM21IU1RpbUhOdkhkV0ow?=
 =?utf-8?B?MU8ydllESmZVdS9PcTVxdTlydDUvNUpjMTF2TFM4dkZRb0lCdW5XMUdqWDFR?=
 =?utf-8?B?QUc4TlBDMnJSTzlqSHlPa25MUTBaUDBsRU0wRWxIbm8ydGw1eEhOVXIwUnNF?=
 =?utf-8?B?bTIrRStrYkEzWGdSdGtScURkeHdOSGxsNTVmaW9hWGtJQkE1SXBzU0ZpenNs?=
 =?utf-8?B?ZitwNUdvV1VnN2VlREMvSTVhbzNmRjFCTVU1K3FRLy9IVnpLaTZQQWdHOVhh?=
 =?utf-8?B?akYrZU84RkY0ZFhPUG4rS0NzWGUwMFp1Y0grS3lkYjZTVitua3lrM3p1RXNs?=
 =?utf-8?B?WlVOTUpxenU0N3dKVExyV0xvdXdrbk1FVkJmOEpBaDdJS0pPcGlSbEYyTDJE?=
 =?utf-8?B?aXdUaUpPdm82MW05dlBMTXBGYkYydm4rbUJ4QUUvYllZTnV5cG9wT2dybHVQ?=
 =?utf-8?B?UmtkU1l6UThzT05kVlZQazFMUTZGVEp0YzMxYkttQzYrME11bzN3VzVMUlhE?=
 =?utf-8?B?WDM5VWEzMjMwc2ZETDVZRG1SRm5QbTM2dmJxTkpqRWt2ME4rbENUSkNBRkVL?=
 =?utf-8?B?Ni9CUFRnYmJTMExZTjZuZ2NuemFDMTV3Nm42d2pYenhrZ2VwS25VazZpWE5S?=
 =?utf-8?B?eFJuZlV6ekQ3OWtybEFaQXBBN3RRNW4wODJnc0REbnZzeTlyVXc1WCtOc1JG?=
 =?utf-8?B?dFIySnZKQ240d3BvVTh0S0xobGtxWUx1bkZPWnVGcmlJU293cFdKblpFQWtk?=
 =?utf-8?B?a0pFQkR0UVk5K0s2R01kM01aQVlBN3cwT0V0Y3JrN3c1V3NzQ3dBMndmK1Fi?=
 =?utf-8?B?Q0JYOE9pUUhJM0pCWW9adGZiNzlhdGFRRUNNWHJKZWNOZkVQZml3bVNoQlRq?=
 =?utf-8?B?Z3djL2tLU1pVM0hwNlU2bmhGMjdNNzJpRUlFUDBwOFRDTmczc0R0YitpSVA2?=
 =?utf-8?B?bFFQaUkxa2RETUNwejFMVjJ5L0dvcktXdFZ3N1orQXY3NjRjNW4vS1Fua0pH?=
 =?utf-8?B?dlRQWXpWbllRdk11amllZCtydDMzcHNUczBUS3crU3ZYRjBjRm5tczdLRUZu?=
 =?utf-8?B?ejhjVngzN2I1ZThYY3l5TjQ0SHVQWkNVcHFBV0lZT2p2Wnl2RCtoeU5jb0FR?=
 =?utf-8?B?L3hJYnVYQVlKeUVTR2xwUEF5blNaZzNmdGYyL3paeG5pMmc3UGxYY3EwQTBH?=
 =?utf-8?B?OUFONVAzRnhFVkNycnAvYlZ3WUpzVHphdzVZS3E0U2I4OXBNa1hvTjhGRTdB?=
 =?utf-8?B?VGN2VGNyNy9hbXE0MlFKeWdFS0FwY0gyM2FQRTZMTmR5U3B4RDFaWU53bnpq?=
 =?utf-8?Q?Dxsx+Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:47:39.4106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81afe0be-93a6-4eca-1c99-08ddc601a958
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7
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

Use generic vcn devcoredump helper functions for VCN4_0_3

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 78 ++-----------------------
 1 file changed, 5 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3bda19b92cde..91b4fedb0a88 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -160,7 +160,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int i, r, vcn_inst;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
 	uint32_t *ptr;
 
 	/* VCN DEC TRAP */
@@ -231,14 +230,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	/* Allocate memory for VCN IP Dump buffer */
-	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
-		adev->vcn.ip_dump = NULL;
-	} else {
-		adev->vcn.ip_dump = ptr;
-	}
+	r = amdgpu_vcn_reg_dump_init(adev, vcn_reg_list_4_0_3, ARRAY_SIZE(vcn_reg_list_4_0_3));
+	if (r)
+		return r;
 
 	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
 	if (r)
@@ -1878,68 +1872,6 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 	adev->vcn.inst->ras_poison_irq.funcs = &vcn_v4_0_3_ras_irq_funcs;
 }
 
-static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
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
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_3[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
-	}
-}
-
-static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	bool is_powered;
-	uint32_t inst_off, inst_id;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
-
-	if (!adev->vcn.ip_dump)
-		return;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		inst_id = GET_INST(VCN, i);
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
-									   inst_id));
-	}
-}
-
 static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.name = "vcn_v4_0_3",
 	.early_init = vcn_v4_0_3_early_init,
@@ -1953,8 +1885,8 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.wait_for_idle = vcn_v4_0_3_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
-	.dump_ip_state = vcn_v4_0_3_dump_ip_state,
-	.print_ip_state = vcn_v4_0_3_print_ip_state,
+	.dump_ip_state = amdgpu_vcn_dump_ip_state,
+	.print_ip_state = amdgpu_vcn_print_ip_state,
 };
 
 const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block = {
-- 
2.48.1

