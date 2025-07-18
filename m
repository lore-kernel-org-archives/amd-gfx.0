Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DEFC83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE3C10E9B2;
	Fri, 18 Jul 2025 13:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uNbILy5C";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D6C10E9B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kE87kEAGzHc4rEKzmAwZOUQFrj1QPxGHQvTeuqUyGXdaN0MjVa0qVEx4fi3wy1V44V2aKWQdDRb3lLXogqQ5SJ5dHtJj2tHyQdovmIv6GQ4zWKvRvSN3yE4d2uUAY+wCT3QK1t3Yqkytj5DojL/OHnmpAQidS6mfpB2fRjmneISSAx+l5HYsq/nPLNh/EMfu9b/2KhHo0CSRtrlHYUg3836nXtGxFv4WEhIQfl5KOiheL8E6UfkfmHmM3jh0nxGR83GjJbJkNzg2fFB4J5MAd+BbOccXdeKvMmMnEAkPqnNYByypzqQVgQPtNtoNlLL/KL8sLTtzczx12BBgv1OWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPgY6tqwuBZYCNSGYK42PVCLx/0WbTOjFyklZghRbr4=;
 b=kF9IeoA3H2OC9ekVeWWA9iXSO+DVaxpjn2g9K2YNoprpkgIyLI3cJfc70s6bCo8D+CIv9sGWKeot0q/pNsKzpOfOuLWUlsTMznWezUysRK6Gf68JBGLQxpG0gARy0KN2ySE03QxHfmOv1FHvS+t6QT5J2hFC9JC8W38EGeJ5V6HnXtZKnuNwZqluNJARfoRXT232xBYF4D1l4sNeOWPc7IUHWMQCkxQc+X1pRITFYfnizwr1H5ASLCotW/jfXOHlfy1GCzolwKmEibYWaHD5oADxDMLLZlXtZIMPuj6xYbvjfTfhoiqQGOu24f7eT90LXYqAlFzmvY9RXFeZx9TATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPgY6tqwuBZYCNSGYK42PVCLx/0WbTOjFyklZghRbr4=;
 b=uNbILy5ChJeUqr0hKdhuytbPzCZBPv4qdk8QGt9OuNKFTMqDJv8tSZaWhXoRLgtIiq/95emnktSd9QF+3lhv4WCCJGlOkQsaQCQ8EbQpL8gRNDd1navpE3b2oGx8VpSWvOgxv9zuAx+WfV9lxsomwJ66jgMDwst5a63FkAPT6Vc=
Received: from DS7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:3b8::31)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 18 Jul
 2025 13:46:58 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::e5) by DS7PR03CA0026.outlook.office365.com
 (2603:10b6:5:3b8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 13:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 13:46:58 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Jul 2025 08:46:56 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 3/8] drm/amdgpu/vcn: Register dump cleanup in VCN4_0_0
Date: Fri, 18 Jul 2025 19:15:39 +0530
Message-ID: <20250718134544.2594829-4-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa9a0b9-b1f9-41a5-6f9c-08ddc60190aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3FlNTF5OVhaM0VSc2NFOG9xcURpQS9mNkFndVpvaG5ScUJ5TWpEaWJ1Q0Jj?=
 =?utf-8?B?MGhMMm8vcW9sRUlSTGd6djFheHFzYVhzSHR6RmFDNzNhZW5QMWVUMTF2REJC?=
 =?utf-8?B?UDdYVUtOZGMzcTdobmR1aXNIaGdFOS8yN0swSHNCVU5ka3kwTGtDbityOE1L?=
 =?utf-8?B?YWNUM1FVaGh3OFlCT24wS3JaUEVYZG9SL0VsV3haTkJuME5QN1RlVEdlNHRR?=
 =?utf-8?B?dS94Y2lBZHMvR0VIN2ZZdVJST1ZjUzdJSzdaQjdQaW9wUm51RHdTQUlpMlNR?=
 =?utf-8?B?b0ZZRFZ3T1M4ZDJ5OHo0b0UvcVpGekZSeGh2bEY0ejBYNG1FcmVrTk96L2dF?=
 =?utf-8?B?S2N1KytDb1Z3Um1ML3lmUjdjSCtTdUxscE5zbTI2WVIxeSs0TUtXdlZMTkJj?=
 =?utf-8?B?KzkyZ2hDeUZ5VFl1dW14NEp4ME41bGJuaUR5YTZzRzhZdHo0c0d6MlpiZnAr?=
 =?utf-8?B?UTNxMXhtd1pkcjFHV0J3eHRkYUpoRkJTL1lHSmdmOXNFbGRqRUJOS0lXN25x?=
 =?utf-8?B?WXJ2SnVscFEyL0dhUWtUc2tsUGxWYzg2ZG0rMGp0TnNDaHdOUnVubUxMVFFu?=
 =?utf-8?B?cTJhakJNOEJlcGRJUmpLSXpSSGp0ZVpnNUszakJQT2dNS2tYN3V4TDlZcys4?=
 =?utf-8?B?dEhpUVRZTjBXYUV4emJBa3pFby9DK1VDekVLWTJ1MTVyRXFjeHQ4QThNdEl4?=
 =?utf-8?B?N3pnOE16bU1lSkM5VC9WSmFxVkRwYytMSnNnWWxQMzdTeWx5TUVkb2hFL0N4?=
 =?utf-8?B?TERIUzRhWFM2eWVodE4rWHJHblpaYlhNUU9VcjkxcjBoZ0ZOM1k5U2JHaVc2?=
 =?utf-8?B?QzhlRXlNR1Z4aUpqWk5jSVZ0N092Q1Y5ejJWRWFCRDdhdkJRcTRvSGNMV1Vy?=
 =?utf-8?B?WGNvanVtS0xGZ3BzL0pkVDl6cVl0VjlSUERjZEF0a2ZJQUo2VlFjTm93M0k5?=
 =?utf-8?B?N1lZRE1WeUNIaVhmRkNvQTkyS25MMWlKeTM1bE14V0FXUWZnaFRaeUcxakdO?=
 =?utf-8?B?UUlZbEVlcXhlKzdSR2s4U1lKaW1vUXp6Zzd2c1RLVGR2UnZiVy9KWCtqZTY4?=
 =?utf-8?B?NC9tMlo1OWowQ1BPSmhhaDBjNmhlRW9EYk1LR0xzREtrT3lac1V3eTZzUmUz?=
 =?utf-8?B?dHNBMGRZdTFXS3JvSmxQUm83MnNoMURHVi9HTDhLdEhQcEdjT3FMZ3NxdUtS?=
 =?utf-8?B?MGRlenhMKzh2TE1UdmI0Y05CR0JoM2NiRkN3WXJuU0pobTBmMUE3ZVhZK0Nt?=
 =?utf-8?B?OU9tVGtLa08vTVlRc3lwRDZCRGM2clJLRkovNXUwQkthcDR2eklxMFZiY3Jo?=
 =?utf-8?B?L3BUcUVWR3RBSEVOeE5mdXdwU1ZGUDVwbDYyTnZ5R01meitmUytxVzUrYUk0?=
 =?utf-8?B?ZUZ3S0p6VWZWN2tkaGNLNjdlOHBmdUV4d056c1ducmFvM09zN0JtaUQzbmsw?=
 =?utf-8?B?azU4M1ZOa05TbGhJTVVrYXhRbFJReE8xZUxlT0ZaRVp3NWp5dm1lSmNSM1lS?=
 =?utf-8?B?VHJLV3RHQVZYUDVyeTlabDV3RWdQOW5mWkZqTG5lclFhQmxPREIxQ0J4OWx5?=
 =?utf-8?B?MGowYlllY0JGZlNSa1V6VktjaWJBWkFtN2VVamYxOGtJYmJUUzR3R1VmZmFJ?=
 =?utf-8?B?Z0J5K3lNaW5rNUpwcTNpckVXZG9ScjgwRitWUkIzbFJqeHhFczZiZkJwR00r?=
 =?utf-8?B?WW0veU5kQ1JRcUt5UzgyYm1jWG1RUjJpZTcveThNbS8vMng2ZWUzSGVxU2pE?=
 =?utf-8?B?ODZ5UnZoN09EM3BvaUgwNmFBcjJEVlZuU1BHL3cwNndpQ2hJZHZaTWszRFQ2?=
 =?utf-8?B?NTVyUzJTODBObEt6RkdXOFhYb2RyRGFmajZrV3Q1VWI0Ukl2UHNrazN5ZnBF?=
 =?utf-8?B?dGN6eXhFc1ZaTy84ZGZxOFdUd0lVdmlJKzRHYlB2Wi96dUQzZ0JZSGMrV2pI?=
 =?utf-8?B?cmd3QTA2Vm1IYTJneEwzbHhjRUM0d1RHY3NoZ1dib2FvaDMvanUvcVVDM3Y3?=
 =?utf-8?B?SlNHdGdXYUswSkNROEdHcHZNUEZ6WXJselU5V3dQVTlUSjdKRnFGV0ZjNzRL?=
 =?utf-8?Q?mb+tiL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:46:58.0075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa9a0b9-b1f9-41a5-6f9c-08ddc60190aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
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

Use generic vcn devcoredump helper functions for VCN4_0_0

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 79 ++-------------------------
 1 file changed, 5 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index f642a06a77b5..a490c697fa53 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -183,7 +183,6 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t *ptr;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
@@ -255,14 +254,9 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
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
+	r = amdgpu_vcn_reg_dump_init(adev, vcn_reg_list_4_0, ARRAY_SIZE(vcn_reg_list_4_0));
+	if (r)
+		return r;
 
 	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
 	if (r)
@@ -315,8 +309,6 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	kfree(adev->vcn.ip_dump);
-
 	return 0;
 }
 
@@ -2249,67 +2241,6 @@ static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
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
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_4_0[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
-	}
-}
-
-static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	bool is_powered;
-	uint32_t inst_off;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
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
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
-									   i));
-	}
-}
-
 static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
 	.name = "vcn_v4_0",
 	.early_init = vcn_v4_0_early_init,
@@ -2323,8 +2254,8 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
 	.wait_for_idle = vcn_v4_0_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
-	.dump_ip_state = vcn_v4_0_dump_ip_state,
-	.print_ip_state = vcn_v4_0_print_ip_state,
+	.dump_ip_state = amdgpu_vcn_dump_ip_state,
+	.print_ip_state = amdgpu_vcn_print_ip_state,
 };
 
 const struct amdgpu_ip_block_version vcn_v4_0_ip_block = {
-- 
2.48.1

