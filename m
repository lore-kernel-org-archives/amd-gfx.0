Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73358C83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D4810E9BE;
	Fri, 18 Jul 2025 13:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PeBqcE4f";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E08110E9BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhvjD93tqwclDH0F3AMbt7iOMGLDiannon/xf8bj+rFlPviI0TTxWxzsdqD3v2YH+vl/KKw09ihZ0GOV6Xw4CoVmu9zh1DnFRMSmu2D5bR9qkBFGtlR5RLkxq8zbrwKK/NRB4RoWjJg5XuX6tHkOPhCZCzZD4ZGXGQt+olScaf9aKNNr503g9iBZzOSGurA+PlOEfqqKkKxcqxZDSs2TxEpCCVaDmwNHMzrxeNOcR0Lk1M1k0y1dW45ZoQcqRuQ9DIuZLrKTOfP302IXq3ryGTUBhivQm0KXrd/vMZDlB+eW7K0Xx8VT1AlYBUetBxcby6bQsSJeP8ARt3Ifs75Dfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CK4jBV2mnUB7RulVvoNVMyhq05peAdJy1+oqe7vwH/8=;
 b=qCPXXxX++aXpB37OxzCvDQtuRhszqHC/n7DsM9051kD6Rpodz26ulIFMvPIfzU3O5WYwTfQCnNmdeau0gmIY9+jQblLmOagpsUrzdhAQ3D/i5wCpl/ghK5B4pvJrHlAdufvF4vv3RXmkE8KDDm9bw99hFj6LZQ38SLETCvefR0HTxtTu5SR4z8PQFANNuW1TJsK63/Q9jooHwFkRY0ZZsSXAdQXgZCf9hYQFsy0KVKhPfUQ85WsS5vcmyzbuWpTnT4Mhxw5k1lyN4wI+fzjuvwB0FhgtvJrTBBph4olV6IWoc6eBtxK/8uvJB+lbORzDgKVYFDMEXbrfeRLH1HfI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK4jBV2mnUB7RulVvoNVMyhq05peAdJy1+oqe7vwH/8=;
 b=PeBqcE4fApOYr0AqIKBIgXuLERrT6lZH6nc6lcrpO32GYaemlg5cBUesI8xsEec5rgm+A47kGcYwouJo5+aIrGjN+DCLSarNP0pT6waw5rsQRV41wXSpcR05pxEdj3sbtoyNV82wRlZ3hVl+Qxr4Ut6lMav+Hzdx/vTVExYaXvo=
Received: from DS7PR03CA0151.namprd03.prod.outlook.com (2603:10b6:5:3b2::6) by
 SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 13:48:40 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::fa) by DS7PR03CA0151.outlook.office365.com
 (2603:10b6:5:3b2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 13:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 13:48:40 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Jul 2025 08:48:38 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 8/8] drm/amdgpu/vcn: Register dump cleanup in VCN2_5
Date: Fri, 18 Jul 2025 19:15:44 +0530
Message-ID: <20250718134544.2594829-9-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 4210eace-8b05-4a63-cb20-08ddc601cd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anIwMCtsT1ZBY0xieG81QitKdUdPRHgyTkFKR1FTbDlueDJKRFk1MXBFMUxj?=
 =?utf-8?B?TDRpU0YxTzBwTFRDZHR2S3R5ZHlHMkpvQW12QnZrcC95dURLTEwvakNlZHU2?=
 =?utf-8?B?Vnd0QzVPaGhHT3lERTh1TlEvZUdETkUyN1MzaHlXTUx4NkVOWElQN3Yvdkcv?=
 =?utf-8?B?NkRqaTVhaHRwWWhMenAxeVQrazA5R0J0eVlhVlhzL3pkam1iaS9VRDN1VDJQ?=
 =?utf-8?B?RTI5SnpESkdvb2ZLWENVQlNsOGJ1NXJJRnY4K2dsZjlRRHhCMFpuRUdnVzBL?=
 =?utf-8?B?cWRPeVZKaVVvd080dmlYOVFMNXdoSURsaE5zVGNnMmExVGdYNi9Kdm1CQ1Fw?=
 =?utf-8?B?VGxsUE5OdkFveEJGT0M3b3lHbkZldER3dVRzL3ViUkZOekxQUldOM0NpR1N3?=
 =?utf-8?B?SVdPL3BVcUZyL3JtUVMvRW5wZThtT2tEYXFxRWQ3ZHFLZkNJVnVPZHV2K3p3?=
 =?utf-8?B?dWJXT01WTEFSMnZzWXNrcmlmS2I3dG9RcElsTnVwcnBldUt3QzVodExtMWdR?=
 =?utf-8?B?Y01hUTRtSVhENFBFNHExblJSV3p1dWltT0ljWFdYNXl0OHVBTks1cWVPYkxP?=
 =?utf-8?B?dklHTmdOZmxwWWdCNklWYWxielJNNUpXaDZ2MzBjMjRlZ0VpakJQNGR5bFc5?=
 =?utf-8?B?QTJpd3YvRWZtaFVPcWRiVlVtNXVCYjdiNi9uSzZtdWVHaVFPakFSVlY0NVdZ?=
 =?utf-8?B?WDJpZzUyRGdhUkp5Z3Q3cVRQSktBa2UydWgwU3NMNnFDV1d1UlhtcitveFFk?=
 =?utf-8?B?NVpqT0xObjZZaDZ2UlhEdkxDd2VxekYyZ2xFcS8xZTNyNnhhTDVPVkNEL0Fn?=
 =?utf-8?B?OU5UQW5LZHlJeEhqRDg3RUNoZ1lXbU91dmRQVFlyMnBZQlpBclZvTVl6ZnBZ?=
 =?utf-8?B?WCtqT1lQeDc5c0c0aXNoR21rSHdJd2ZydC9zVG9RbTY4dk81cW53TkFMcGox?=
 =?utf-8?B?ZzFoRXBCQVJBeVo0R0JKQVlTUFArbllybzlSZDVhcGRreHlmQ2s3Mnk3YkJ3?=
 =?utf-8?B?UEorYWNvZk83alU1cmkzQW5rNkhCSnplUzNIZDVDQWZFSzZ6anVEMHFzOUZR?=
 =?utf-8?B?Wm4zcEhYaWY3djVET0phcFBjTlZ6ZnlqcGNlNFpOK2RyTi9DblNHNUdOMFIv?=
 =?utf-8?B?UXpXTVJETlRFT3ZVZUFQUlM4ZHk0R0JOdWVZRVJoUWk1YnUxY254YjFNSWpW?=
 =?utf-8?B?K0dpY003VTZITHE4aGVqN2htWFdKNzZJb3BjWmVpM3NNMldZdHc3TlBFWkdP?=
 =?utf-8?B?MFpJUzgvWld2WTMyeWFLQWxxRGJLcHN6T0tURlN5cWFjSnBzUkdHaE0vWGpJ?=
 =?utf-8?B?THphOFgvN2p2QTJjUHMvWFd1MEpQa3dPOGxuejYrbHNmZEJxbnYyaGplNUo2?=
 =?utf-8?B?cnpUNDNqOGczQ29Vc1ZGakxtQ1ZJYlJWMXAyYSthbWFPTktaMDJWYndVWDZP?=
 =?utf-8?B?N2tia3FuZkw2UXhHaVB2aEF2a2VTbWduMU1sTDh5NHkya1NFSFE2bUhmRlZU?=
 =?utf-8?B?VU45Q21vcHo4cWlwSnNaL05IZ3BLdUZKMTBodVRJcm84WmxwNzluTGMvNXc4?=
 =?utf-8?B?cG8vbC8yWUd2Z2ViOFlJZi80V3lBNVJIYklnMnk5anN6ZWdpZXJYelM1ZnVx?=
 =?utf-8?B?clhBRTJrdkFqVUdXeHZJcXNQRUhMY0Fwc1VKQ3I5a3lJd1NpN0VwbjRwUWpH?=
 =?utf-8?B?bjFmT2dYa3Rab2plUjhib0dXTkNHVVhhaGQ1K0pvUjR0N1l0V2ZiRHU3VWsx?=
 =?utf-8?B?QW1KUGFvRldialBQOHhuTXA1UnFKazBYaFlQc3I1L0pYeW1OZlRnMnM2MEdT?=
 =?utf-8?B?YitVV05QeTRDZituQWY1MW9sZ0RJWkVLU21OZFdZQU95VHlkbE55eXlyK0pK?=
 =?utf-8?B?cEMxL1U3QnBBT3RLWGFLM3NTUHZaK3VTc0VXdDRnODdPVExXYWhaMEkyUktZ?=
 =?utf-8?B?WllWaWxRYWNvZE1UWldlSGZ4Um43VUVaK2xUckxTNlpobk0vbmIxNGJDajhx?=
 =?utf-8?B?dFpZSGc5N0srMDUvZnRTU2E0UElZbGZ2aVEyL2w1alE2bFhCUjhabi9GOUo1?=
 =?utf-8?Q?1MqVCG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:48:40.1037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4210eace-8b05-4a63-cb20-08ddc601cd85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
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

Use generic vcn devcoredump helper functions for VCN2_5 and VCN2_6

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 82 +++------------------------
 1 file changed, 7 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index bc30a5326866..1e8e2dabc213 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -297,7 +297,6 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int i, j, r;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t *ptr;
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -423,14 +422,9 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* Allocate memory for VCN IP Dump buffer */
-	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
-		adev->vcn.ip_dump = NULL;
-	} else {
-		adev->vcn.ip_dump = ptr;
-	}
+	r = amdgpu_vcn_reg_dump_init(adev, vcn_reg_list_2_5, ARRAY_SIZE(vcn_reg_list_2_5));
+	if (r)
+		return r;
 
 	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
 	if (r)
@@ -477,8 +471,6 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	kfree(adev->vcn.ip_dump);
-
 	return 0;
 }
 
@@ -2127,66 +2119,6 @@ static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
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
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_2_5[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
-	}
-}
-
-static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	bool is_powered;
-	uint32_t inst_off;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
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
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], i));
-	}
-}
-
 static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
 	.name = "vcn_v2_5",
 	.early_init = vcn_v2_5_early_init,
@@ -2200,8 +2132,8 @@ static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
 	.wait_for_idle = vcn_v2_5_wait_for_idle,
 	.set_clockgating_state = vcn_v2_5_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
-	.dump_ip_state = vcn_v2_5_dump_ip_state,
-	.print_ip_state = vcn_v2_5_print_ip_state,
+	.dump_ip_state = amdgpu_vcn_dump_ip_state,
+	.print_ip_state = amdgpu_vcn_print_ip_state,
 };
 
 static const struct amd_ip_funcs vcn_v2_6_ip_funcs = {
@@ -2217,8 +2149,8 @@ static const struct amd_ip_funcs vcn_v2_6_ip_funcs = {
         .wait_for_idle = vcn_v2_5_wait_for_idle,
         .set_clockgating_state = vcn_v2_5_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
-	.dump_ip_state = vcn_v2_5_dump_ip_state,
-	.print_ip_state = vcn_v2_5_print_ip_state,
+	.dump_ip_state = amdgpu_vcn_dump_ip_state,
+	.print_ip_state = amdgpu_vcn_print_ip_state,
 };
 
 const struct amdgpu_ip_block_version vcn_v2_5_ip_block =
-- 
2.48.1

