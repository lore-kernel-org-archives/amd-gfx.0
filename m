Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D14C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DDB10E9BD;
	Fri, 18 Jul 2025 13:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SfUnuMW6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C51D710E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbSYqxWY06zHGHQ6xMNXjIQ9jX7L10eE04osbta17kMXJxvtd8JfPv3SMaMho6Wngr0yZYaRN7jzswYPDQHNgfE7KSxC5RifS2znU1i8NToCpIUWqdahBM/QKFxJ4lH5q/wpnRxgBkN+w8y6lVR2Vpwa7naSpOXHq5PRYDmtzlAbrhZzV6dZEUBoigOac1rCT+ZUi4Yhq277PDVzotrnP+G+Z64RiE6orwPa6Of7ynzNgEVGE97FgNwtGbeKBpE0I+4ywrTL+i/cxak8dSFopF891gI3maGUkCTuRqo0/AxqyAvu0dKeRhDEXIXhVfRC4Y8sYakwFiyYhGfKjcktPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O8C/zN7mh/NIAka9IR1ZB8rRvTmi/uveJKygjv/gkY=;
 b=t0uOzShKFsNJB/SgmKYaeKL1v+HEPeV5Rp2WZwW7JpBvek77SsICw3LMh6dSQ+jeItF0NapuGaEocpfn0Yp7k1tbimb7kFj91xaiD5kKUbbkcaCvDUHJiPCJ0j/mWBg0vCyYGRxJCN8lrcK9MhAxBvoy2SEB3Pr2PEOpfeTsQUBL8YQtUJi2D2OUUOY8NCJpI1PDdjIZH8SRVlfUJfeHRTMHGcJtU3FIo9DevbdjEHKYGYNu14JCjhv81oTXTbIfyQMej0XuK4skuI+hJB9PEwyYnTj/+NyrzsqlHFxXeRcxZMeuWwowDCnTsP/EkggTayOfye7Oem2WDRyMqE7Kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O8C/zN7mh/NIAka9IR1ZB8rRvTmi/uveJKygjv/gkY=;
 b=SfUnuMW6AJEXwqI2xOYBfwvUppUlTz7Q7OU4f4BgDGZg5Q9NWKtOVGdsdp9v4ehYQpL/dRCUMeEOH/yc01IeQ70F879D6xqqtGn6UwYcXf3/WRAmunt1hP/MUo6WFahYOnQbzrj0KcF1lSGpV/b/Qogqisru0+TjxAhbA/Kb/C4=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 18 Jul
 2025 13:48:19 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::65) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Fri,
 18 Jul 2025 13:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 13:48:18 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Jul 2025 08:48:16 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 7/8] drm/amdgpu/vcn: Register dump cleanup in VCN2_0_0
Date: Fri, 18 Jul 2025 19:15:43 +0530
Message-ID: <20250718134544.2594829-8-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: da16318a-0490-46df-e19f-08ddc601c0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c05OTk5SSW81VXNhSDJPRG1MRGQ5RmFUR01Fakx5c3MwdzlmQ1dLYUJXNS91?=
 =?utf-8?B?bGNZNEN1WjM4aFJLUDlpa2tVMjdydmFtWTYxbjIyYk1TMFkwbXJCejgyTkNL?=
 =?utf-8?B?YXBPb2xLV2MzZHFxQzRXY0FTMEVnVVZVUDUxWlIvODFJN0xaRUdYRkhJREEy?=
 =?utf-8?B?YnYvWWRmcVloSFp2ekZ5SldEUGo2a09uRit2WHpPTkpicGgvN0xldmVWeGxV?=
 =?utf-8?B?UG92SDk1RjlHcDRoRGNramVVOHduY3B3SXJsU3lQQ25xbDE4a1ErZy8xUlNP?=
 =?utf-8?B?dENHamp5U0hmVGFFbHRvcWNEUlNvV1doeG82UVlnRGx6bWFKb0dKZzZHUDEw?=
 =?utf-8?B?ckdlTk5MR2JUYnZkWS9UU3RrZkwzWkFmV3p5cDhCbDVtNU5iNjNZaW5yZmZ3?=
 =?utf-8?B?U21lUWN6a3M1eUZmbGxjNGVYaldaQ2twaUg3TE51MFpPT1k3eFIxa0hIZWQ4?=
 =?utf-8?B?YjRGN0FiREdIZGs1QzkzTVcvWjVMcFNDVGhEejBnbVU0ZXlDaDQxYnRvbnpP?=
 =?utf-8?B?dXlYUEFXWnlmNGV1Vk5lS0NUNWUzdTlBcmRKaGExb1lVUUswQ1NNN2F1bUJH?=
 =?utf-8?B?VFlWRTkzYlR6TVhWOExreTBVdGJ1aHZ0TTMyVk5rUmphZDV6NkYyOXdWU0Nt?=
 =?utf-8?B?c3ZURE0yZDRKMnM0Ylo2eVZjUllBNit1eFEwOStzY2hZU0Q2NUZDRUUvMXRt?=
 =?utf-8?B?UTN0NEEvRU1xUi92dEhyajlnS1RncisyT1VURUFnaGIzazJrNFIzUVZTOThx?=
 =?utf-8?B?UWdDNGRJTzJzTk54WUpPNU1VUDVhNUpvWS9NV0tQL0dkM2EwaFAyWjYvOEk5?=
 =?utf-8?B?TVkxWmJ0Zm1oSjN4RWd6MXVsSk51QUJnYjNBdlFnTm5tR1ZhNkZ2dEtheXpJ?=
 =?utf-8?B?N3FqQXdESVNNNUs3V2lGYTNGd2xmMTJ2SjZrS0k4Vmk1SWd6S0ZFVWtCUnA0?=
 =?utf-8?B?ZTIyM1JndWhlcWJaWG02dVplc2daNEttODJYRzQrc3FLMzEyZ0lyKzZqc2FH?=
 =?utf-8?B?MXRMeFFOWnVFUzNidVcyNjRtS2wzb2ducFhIN0c1cFlxZE5TdlduM01kbk1j?=
 =?utf-8?B?ZjNzTWRpRnkrdk5TL3F4NThoR1dxazRwSU91ZERwUVdubkY0TzExbW5xd3JQ?=
 =?utf-8?B?WHUvS1NuOGljaHJKR0wwQ3p3M1hmQlVGemNjeGVQVEhnK0xHR3RqNHRYY3lO?=
 =?utf-8?B?cjNnb3dONDNUczg5R2l0QkYwa2RCL0lXWWpkdytFeVVrcnhCbmpLZmdoSkxZ?=
 =?utf-8?B?OXRpa2ZqWmZ3OFlUNFhJa0UyWGZGYnozREJRb05JWE93bG4rYVdVRWNBUHc3?=
 =?utf-8?B?SE5MT2l4TmovcVdtaGkvZWZZdk1qWEdObytqVFFvZUQ3d3RpL08rTUJESFFY?=
 =?utf-8?B?eU42RWJOK0RJUWZGS2NoNVp4WnBJZjY0K3B5cDJ1SEd0QU5NR0MzVFoyN21K?=
 =?utf-8?B?b0V0QkpkaVdiVnZ0M1lVUVBJUTFCYTdhWThNVXFWOXpmWkRRWjRyYkdUTldU?=
 =?utf-8?B?eEhnVUdKTDlqeldIWm9oR2xJa3BENlQ0U2FaVzhzNGptb21ZbWJ2dTNXVkd3?=
 =?utf-8?B?Y2tnUDJLL1ZoZVU2K0ZuTHNrdjhVd3FBT0FBU3hGV3EwU2pScVd1OCs3TWh4?=
 =?utf-8?B?cHBPejI2QTBiWmFHNVhUbkV3eFpGWkpua04yTXEvWk4vcHBCMTgzUDdnRG92?=
 =?utf-8?B?bG1ueTJONkNUczR3eUk2OGNQQ2t1ZFJod0dSQmdzTkhsSG03UFh6SWxLd2Np?=
 =?utf-8?B?VVZQSW1nVEV1dHhnNExxQmJFN1JYQ0F3N2t2N0U0eHJxREt3UFgwQ1JHeElD?=
 =?utf-8?B?WU12bHdQSVhydTg4V2Fqc3ZKYUNSTXU0L001VmFUbUx0TnpFWUttYWVBaklR?=
 =?utf-8?B?UXpzUDhGc25ucHVKZDV0aFphNE5idEQwTUxnWTVyRS9hMytHUCt6cW0wS1JK?=
 =?utf-8?B?NGxtUnk4K3ZUNldURmNuRjN2TVBIWElvcnJmTmx4WVpHdWVnMnljWk85M0gy?=
 =?utf-8?B?eWNBQjRPc2VUUXpNZGRId0VIOE9LUHdycmNWM0NQMStIb2N4MXpwWHZUbS81?=
 =?utf-8?Q?Vke6tt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:48:18.8985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da16318a-0490-46df-e19f-08ddc601c0e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
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

Use generic vcn devcoredump helper functions for VCN2_0_0

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 78 ++-------------------------
 1 file changed, 5 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 68b4371df0f1..86634f70c866 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -136,7 +136,6 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int i, r;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
 	uint32_t *ptr;
 	struct amdgpu_device *adev = ip_block->adev;
 	volatile struct amdgpu_fw_shared *fw_shared;
@@ -232,14 +231,9 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_vcnfw_log)
 		amdgpu_vcn_fwlog_init(adev->vcn.inst);
 
-	/* Allocate memory for VCN IP Dump buffer */
-	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
-		adev->vcn.ip_dump = NULL;
-	} else {
-		adev->vcn.ip_dump = ptr;
-	}
+	r = amdgpu_vcn_reg_dump_init(adev, vcn_reg_list_2_0, ARRAY_SIZE(vcn_reg_list_2_0));
+	if (r)
+		return r;
 
 	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
 	if (r)
@@ -276,8 +270,6 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_vcn_sw_fini(adev, 0);
 
-	kfree(adev->vcn.ip_dump);
-
 	return r;
 }
 
@@ -2095,66 +2087,6 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 	return vcn_v2_0_start_mmsch(adev, &adev->virt.mm_table);
 }
 
-static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
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
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_0[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
-	}
-}
-
-static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	bool is_powered;
-	uint32_t inst_off;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
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
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], i));
-	}
-}
-
 static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.name = "vcn_v2_0",
 	.early_init = vcn_v2_0_early_init,
@@ -2168,8 +2100,8 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.wait_for_idle = vcn_v2_0_wait_for_idle,
 	.set_clockgating_state = vcn_v2_0_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
-	.dump_ip_state = vcn_v2_0_dump_ip_state,
-	.print_ip_state = vcn_v2_0_print_ip_state,
+	.dump_ip_state = amdgpu_vcn_dump_ip_state,
+	.print_ip_state = amdgpu_vcn_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
-- 
2.48.1

