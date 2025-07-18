Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C92C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7CE10E9B8;
	Fri, 18 Jul 2025 13:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x6g+IBQP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167D410E9B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJeLSlWmS6879nC591gyzHYh0Qn95oAQqjCNCI3AgAwI34a4SY6E/vpqrp7B5dxA4uYkIL6CIo7RwmB+G7YDjgz6Nqs8XK0LrUZKwjSldet6m2R8Ctf8z133HntqKCK2e4My0MND8/6OCqFVMAYCEBe1gtKcKkJOraLVY4rII24luGA3u7ci6o88xf+i3oJ7VElDdK0OQnCF1x2K8QV8kILDtOGzcVpLx6eifqCtLl96lCIRkLgxOsXnOVzGSoYVT/hrHiZlDELYSNuavT5nYFDrLs10J2zSmdvgpZoM14sbNUaeA8Nut246GGUGNQHkFa5yXEd5u7F2IaqElGH3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AUs3FbVPI/s4FRZPQXvSidm027VZlDiWgR9M1YvMU0=;
 b=cAKo/kmWcHEtmU2xxj1Ng6YernbsaPHY77loIlzszv0ubvcdWACR0Exex9B+jvbx6oZ5XKl80z+DpwbBqcWSowg+/atsX8dGSB/xlFyuNE39vGPtyOpKFcxF5B36lk9KEbeUTzMTgqQEQhVmfaZmMDvKfF7+pqHZ7/Iq1U1zP06I4udKEI+PXM+NcL+nYgDUiq8cr4m3/+Jzk5iHmMcLiILmsHomYMJR+vveMPw8z8YhSNkJtxvtSJzsDtpZ5bAhIFY42a1dhl2BZ0AmjCZhcNYokQBMxARMf8vPpiwCKMDgiawedrmV0ISVRzLo9zWqd4tMbUAaIro7JvU17a58Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AUs3FbVPI/s4FRZPQXvSidm027VZlDiWgR9M1YvMU0=;
 b=x6g+IBQPO5DXILsDplFNgDyHrerteaDxNqA+toUFbgs+pNyYcs7w/cX5VXT9Ybvmf0caAQp8a/ehs9SecmKWwzOTfpNDvLDCECY+DK8QgMmPlSnksmSG49UDgxuV6ezfm3Fd/EhYR31IUBLOSQlQCajJ8JK0Fq87ZDsrw4Nofxc=
Received: from DSZP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::16) by
 IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.40; Fri, 18 Jul 2025 13:47:21 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::c9) by DSZP220CA0009.outlook.office365.com
 (2603:10b6:5:280::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 13:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 13:47:18 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Jul 2025 08:47:16 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 4/8] drm/amdgpu/vcn: Register dump cleanup in VCN4_0_5
Date: Fri, 18 Jul 2025 19:15:40 +0530
Message-ID: <20250718134544.2594829-5-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c19021d-4d90-4d36-1829-08ddc6019cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUZ2dS9LNFN0cWFmczNRYndiNHhNclg4T2RXckRnOTRQWm1wUUF4aEp1WXh1?=
 =?utf-8?B?QlZwK3ZvNzFhNm9aUDdmSFcvV2VHa2JPUnU3am1mbkhKcnc5WHBhQk5nZjhM?=
 =?utf-8?B?QjZTd1JFb3RjNHRma0tjMVl6QUtrZ2NXRlVuVzF0NnFhcmoyRGVsamZkK25u?=
 =?utf-8?B?VEhUNUlmeVRYZTdWZ0FIN2pGVkQvekFLOHRQM0JjbUtwdDNxQkVTZk9OOVJr?=
 =?utf-8?B?MnE4U04vWU5CcGppZ1ZlWkc4U3ByYWFITEx4YmNnUzZKTm41L3lPYTNHb3Zq?=
 =?utf-8?B?aDg3YkxtL2tKQ2xpYTdHZFFFSU9hSGw0V3RrMkpDZExXZHltdkhMNnordTg4?=
 =?utf-8?B?QXpqckhmamlYRExubXF3K05Yd01PT1BBWTBERjJnMmtXekpzT0wxVWUwNGs2?=
 =?utf-8?B?UnhGSm5DY29DS3pGcVBMci9YV2ZMcXFlSlJDcGJ5SUlCNS8wRkNQRW5uRGFD?=
 =?utf-8?B?bUx1N09ETklQMkFFSGFDODFBQ3JiV2FreXlkQTg5WTNjL3BDL2FpaHkzWEd6?=
 =?utf-8?B?RnBzL3J2b0RTY24zNXFQUnVtRVhqU2pkcWJPSXIzUjEzUkRsQ0JXNlIwOGs0?=
 =?utf-8?B?MDNxbHk2Q0RIcVZ0U1BMc2thN2tDUEtQV3gzREwwY3d1QTRKVndyc2NsVUl0?=
 =?utf-8?B?OXU4a2V4N0NhZEZGQTFmaTZEQVh4ZGNSRzBLVWNjektHQ1U4VXEwbk1DNTNn?=
 =?utf-8?B?R2lrZW4zM2E5LzhxQnZNUXRKU3F6eGlVTFNyajJDQ2ttaTFnZVUvRXJyTXhT?=
 =?utf-8?B?M0w4Z0wxSlNOTmpiRkM5ZlJPYmo2YjV4Tk8rUllySGJyeUpHdEQxT2lwTVRL?=
 =?utf-8?B?Z29JQTUxaWg3enNXRWZwVytkdmdxTHY0Mnd5MEo0ZXpvS2MwTHhuRHBNVzFB?=
 =?utf-8?B?MW4rcTM0eHVzdXZDK1R3bVk4M2dsY21xelplTS9oMmwzb2owL2ZVMkphYUpm?=
 =?utf-8?B?VDBJTTV2Q3hheUk3TkNqcWJJbk1Wc09ibElDZHY5cGc3MlNibkMwWmdvRXUz?=
 =?utf-8?B?b0pucnFrWXhmYXVrSzcxeDY4M2YyNkFxWTNISmlBZ21IeHMraVpKL1pYdi8v?=
 =?utf-8?B?RTVZNFd0R1R3QnlKYzMwRWRVdU41MnJldHR5ZWx1QU5sSURwcFBNTXI1bzda?=
 =?utf-8?B?Vm5ZNk9Pc291K255Unk2UWY0NDdLdDIyZ3dBdXgyY1UwQmlERS9OdTZoNmRO?=
 =?utf-8?B?b2VNOEt3MU9DOFVlRjVTZmNTSkhJdHlVcVhaSXZBZDNIeTdtQndZc3FhbzIr?=
 =?utf-8?B?M0pxazFvS1pZRk1PNGNlV3cxL3VWbFJUcGVCRTlaejBGc2hSVnFrb2dSN1pw?=
 =?utf-8?B?cEJVckFTUkFEUXI5akRybUdVdU5TbE5YZjFBY3lDTVpETlVTS2dmVllVcjB3?=
 =?utf-8?B?L0ZWZVRrM3RKc1NMQWZnUUNBZmRBWEgxdlRQczR4K1E5eDJBWHFFSnIrT2kw?=
 =?utf-8?B?VHBaYTZSeW9UVU9BZTFNUmZ2NnFDSnB6Wkcya1hhVStTQUlpWVlneHVySDlT?=
 =?utf-8?B?ajRLUENiSmNoV3IzbmpyaWUvSSsxRkxxMmtZTnUwYXBNclNmVzhWL2FDaEda?=
 =?utf-8?B?bXQvbkpPNkdyQjJCTmZNeitUaFNVOUJxYzZpNTR4RlJzbm0zdTVHL3hFTy8x?=
 =?utf-8?B?VnBPRFdZNkJpWDcxRDFCYUp1eWZFanhyMkhaQ01qZGFZUEFoRnpyME5FOVlj?=
 =?utf-8?B?QVI3ZklHOFNVUFE5K0FEbmRaOG1rRDRIWXNpenQ5U3lSTytUWHhhd2NCM0Fw?=
 =?utf-8?B?UTZieUFyandSOXNVQnVpU3R0WjhDTTFpbXpkTTA3b29xQXFGZWJJdlRobkJl?=
 =?utf-8?B?aUc0dkF4MHY2MW11c1VUak4zUzIwcE9xa2xVNThmdmhKa2N4L1dOejFsa2VW?=
 =?utf-8?B?dFBwNEx6ck5HdElOZVhVUHpaa21FRWw5R3hBL0syempMb29TdGpWRURqRm5z?=
 =?utf-8?B?YXdac0hRWEU5Nkk1VmdDdVhuMmpMazMzSHBBZ3Nvc0NaeWRPKzFKMDJISXll?=
 =?utf-8?B?NU9ZTzdzRjIzT3pDL3J0ZFZnUnB4REhlZzhWSEYvay9lKzRkTTNsOHBzNkpm?=
 =?utf-8?Q?4YV7N8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:47:18.4153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c19021d-4d90-4d36-1829-08ddc6019cd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
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

Use generic vcn devcoredump helper functions for VCN4_0_5

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 78 ++-----------------------
 1 file changed, 5 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 039989ab452a..86615a0f5c1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -147,7 +147,6 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t *ptr;
 
 
@@ -233,15 +232,9 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	/* Allocate memory for VCN IP Dump buffer */
-	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
-		adev->vcn.ip_dump = NULL;
-	} else {
-		adev->vcn.ip_dump = ptr;
-	}
-	return 0;
+	r = amdgpu_vcn_reg_dump_init(adev, vcn_reg_list_4_0_5, ARRAY_SIZE(vcn_reg_list_4_0_5));
+
+	return r;
 }
 
 /**
@@ -1707,67 +1700,6 @@ static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
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
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0_5[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
-	}
-}
-
-static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	bool is_powered;
-	uint32_t inst_off;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
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
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
-									   i));
-	}
-}
-
 static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
 	.name = "vcn_v4_0_5",
 	.early_init = vcn_v4_0_5_early_init,
@@ -1781,8 +1713,8 @@ static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
 	.wait_for_idle = vcn_v4_0_5_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_5_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
-	.dump_ip_state = vcn_v4_0_5_dump_ip_state,
-	.print_ip_state = vcn_v4_0_5_print_ip_state,
+	.dump_ip_state = amdgpu_vcn_dump_ip_state,
+	.print_ip_state = amdgpu_vcn_print_ip_state,
 };
 
 const struct amdgpu_ip_block_version vcn_v4_0_5_ip_block = {
-- 
2.48.1

