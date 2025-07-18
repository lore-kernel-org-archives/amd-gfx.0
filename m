Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D3BC83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88BA10E9BC;
	Fri, 18 Jul 2025 13:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wUq8zKCC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F153610E9BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLvbUJdaFV5ZLutBtvgIA2GIQVV+0Dnu2kiRDh/j9jmdqivQ5s9z4Mkf+FnTnBq0hVHa+zGVQUl1tlx2LTpWlgZvPeRVM4pSseClmJIjEP8DSzVK1hFw/u9bpZUkxtBbFI07zozIaYHHlOZEfuFMkZvO91m3aqD7WZ77emzjf2lrzJVjcV2WZWGlcZaQaTkuLewOEZ68cmVxjtuZGpXXwvrPVR+Q9YxjONZpMgP9ra+EqFrk1X0za+E+gyETtV37yq4dsl+YoZN9nI84xLsTUhqdpAv4DDCHbmfWYE0cfVyq9DX6d/GcG80bGy5ebkI8sl5EegfoZmfswSU1wBpWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7xHYGxsrUOungN0UiBt0ZZF8IdNTHyLCq/+zbSHeK0=;
 b=mNrezyKa5odZXGe9nYgWWGyawG5yzXiRiQs/F/OJX2B3Zs5G2E3/DHgK7Zk9WfgCGEl0PM2GtD/mEFTG2ElgVzdreQ+ZCdCIHt2RwKr869MCN5FG/WUMoeQ41z5Ba+WWQxwxdGkM1MFCGZOfWOdluP7k3VnNh6H7aWCeR5D5KkIVI+aVSEGdOEUhg3Mv2thMsPkBtK/LMLUWLIPKINrQl491PD4g3uUXOGXQC7doFbqhY3CBZ75CHXS4kzNbxcH2VAbJDMCtya7FxYT2/qPCI4SW+3uAx1xVKIkKVX3op/qi8lG4MaxXgfPUJa+1lQ9Z/mtMGZPe5u2OhYm53yFsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7xHYGxsrUOungN0UiBt0ZZF8IdNTHyLCq/+zbSHeK0=;
 b=wUq8zKCC0n8M6D0u0jVcMoxky+JwvIp+Q8qCwLQcNByX7+wFyUcg2ExXoibseljcMnIqg9rKrZqM45qFUljnIf5P0YWUv+GZ452VYXIFswwvQmvPev3a3dUAm+Y9FKIpNCYuYeI9kopDaw8gHXBh3oQHUAscjjR2hVW90wr+dcE=
Received: from CH0PR03CA0331.namprd03.prod.outlook.com (2603:10b6:610:11a::22)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 18 Jul
 2025 13:47:56 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::71) by CH0PR03CA0331.outlook.office365.com
 (2603:10b6:610:11a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 13:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 13:47:55 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Jul 2025 08:47:53 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 6/8] drm/amdgpu/vcn: Register dump cleanup in VCN3_0
Date: Fri, 18 Jul 2025 19:15:42 +0530
Message-ID: <20250718134544.2594829-7-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: baebef1d-128a-4864-3234-08ddc601b2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K25kZktmTnJnYW9BVHdVZ1BFS1ZXMHNNZXh5Wm9YVkFRbHo3OWJBRDNSS01D?=
 =?utf-8?B?Y08vVm1vVHJYNG9yVEV2NTdSdDcwaTN3Nnp2OEEvaFpLcm5qRmtodzduYmxO?=
 =?utf-8?B?WFNiZUtia0hVaXQ3Tmp2RUlFTnhORy9OeFh6V1U5UEFtMVJYOTY4RDlBeGpp?=
 =?utf-8?B?WXkxQUY2Z3Q1bU1HbkQ0b0c2NHh4Nkg4WXpyMGpkV1MwRFN5UHk2ZTV0WUhT?=
 =?utf-8?B?OXJ4MU9UNmZIMEJwZDlQMndjbFFtd2RZS2RHUTE3eC92Rkc3RVlNTkVpQUI3?=
 =?utf-8?B?VzBWRVpBODhyL2dLM3QzUGVzb3VQZmFvS1BXcUc1MDNmWDlMaGZyTHdGUEkz?=
 =?utf-8?B?c0dxdjFIb0pxS2FLbVYyNnVoQVdYWm9EM3lkMmJTMkprSnU4TjExc04wam93?=
 =?utf-8?B?Ti9iU0REaTh0N00wRGtJcUNFTXdNNDFUOXlPVmRQV3lZVXBuYW9yaHUwRFZP?=
 =?utf-8?B?eXJYeFVkUXFBNTlCV2hBekM2WXhuNTlUMXdMVkorK2x5QVpSZEhTVVdXTWlh?=
 =?utf-8?B?SEllRjVqRnVsK2ZaSFhaSDRQRFBYeWZpOWUyOHVON0VyT3Rxb003QVRQZUtU?=
 =?utf-8?B?SXdPOUJuRjgyelJmWHFNNDUydmZuaVJ4dDdWbnRXT09jNCtZVDJ4ZldTaUZz?=
 =?utf-8?B?MlNlR253UHBkQjJkVHduSmR6NFptZ2g4cHY1Y0g0bWkzckJWVnlxVHdBL1g2?=
 =?utf-8?B?eFpmWEZTdldpWFcvanl3RWNkN0g4REFsUE1qS2xJZzY2T3FYM3ZkYUl5amxu?=
 =?utf-8?B?TEhCTWYrTEs5N0J0RlJRanpLYUJWZkdtRFlpeDM3dTlKdG5wV01XTzBSQW4z?=
 =?utf-8?B?VjJYYkdmZXVONFh2SHpBWTl3NlRacXFib0xPcGIvQmtnZHBCaHQybzRXek80?=
 =?utf-8?B?R0w1N2JNVDh0bTdjRU9GRXU3Z2NXWUVYaVExbEY3VXNra2JLOGlOWHFVNzQr?=
 =?utf-8?B?MVBVQU9wdnlyRGx4bmV2OWtmVWZ1ZVRvdy9BWE9QZk1RUGZwcENSSFY4YUtH?=
 =?utf-8?B?YzJpVTdPcis2OE92SXVGVjlsbnFPeVlCRTdFd3FQYStsci9HWjdvNFBaSkFU?=
 =?utf-8?B?Q0R6bExCWXl4bWFpMXk4ejZTUlFaSUE5V1NDU0dIM2VUL2Uya2pzRU5COXdC?=
 =?utf-8?B?NnJrMGxBdmtlOHNjUG9ndUdjQTVjQWlkUDlpUGZTZXhrZWN5QmJqWURuTHpY?=
 =?utf-8?B?UmVVa3VWcmJlbHB0aTNhWGhWaHpRR0ZvUVBmblFtWFV2Vi9idUhVRzhSWGhu?=
 =?utf-8?B?NmdqV2Y1QXQ1Qk1QNXhNM05UZzZoYUNmY0x3YXcrOUF2eXJycjJpS3FOKzZ0?=
 =?utf-8?B?eWZxYTlEa2ZRdHBXaFpmVGp5UHFOaHQrc3Bzd09BVy8zbDBOWFc5cmhweFpJ?=
 =?utf-8?B?Y1Z4OGgreERDMXJzckEwVE5zUVRXMzkyZHhUcE50MTJ4V2NUK0IwYVhvZzVU?=
 =?utf-8?B?Z09xWFU2eDlHWHZuTzRjbDBKM3JwbjE2NUxGcXJFdEF0eDE2OU5yMW84SXJZ?=
 =?utf-8?B?am5jREkzQ3lqeE1lQU1EdXV4d3g2c0NmSUJrQ3VJL1U5NHM3bU9hVVJocGZk?=
 =?utf-8?B?RXRaQjRneHEzS09QRWsrNHBacnBHL1BTaklLa0FqN2k1NVdnbTdzcTBJbkpQ?=
 =?utf-8?B?dzZTaWJVTU5yTXdGY0V4L0NZVXVkZkZyNVJWbHVZVFVlYnlFWWxibm9DY0Jx?=
 =?utf-8?B?S2QyK2FUYzY2NmNyR0tCOHlJTkJhNmpaa1RNN1F2dSt5UjlHNFJCNHg1c3Jo?=
 =?utf-8?B?TjZzYVBlRE05MU1za0FyQ2lmM2RybG9jOEFhRjZ4eStGSjR0VzViYWJSbjg3?=
 =?utf-8?B?Nkw0ZWZGaUJyMHBPb1lJWm5GSEN3UmsyaWd3dTRONjIrRloxcE52bjF1cXUw?=
 =?utf-8?B?ekZac2dMMjE3aVdLOEVORkJFcW9PYk9DTGswL3lLK2pFaU1zUnZ5b2ptUUhz?=
 =?utf-8?B?blZXdjZCRzZQR0RlcnJySVhyK3pLUm9GbEwzeXJhOFUwK3JmbXNaaWhPT0pu?=
 =?utf-8?B?Vk1TcEptS29FY3JRcXJLNzhpRkJtalhlc0NTblVTWUFsbm1yMjFYU1NwQlZR?=
 =?utf-8?Q?HRF/yu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:47:55.5617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baebef1d-128a-4864-3234-08ddc601b2f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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

Use generic vcn devcoredump helper functions for VCN3_0

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 77 ++-------------------------
 1 file changed, 5 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 4b8f4407047f..7824118d4dfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -175,7 +175,6 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ring *ring;
 	int i, j, r;
 	int vcn_doorbell_index = 0;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t *ptr;
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -304,14 +303,9 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	/* Allocate memory for VCN IP Dump buffer */
-	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
-	if (ptr == NULL) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
-		adev->vcn.ip_dump = NULL;
-	} else {
-		adev->vcn.ip_dump = ptr;
-	}
+	r = amdgpu_vcn_reg_dump_init(adev, vcn_reg_list_3_0, ARRAY_SIZE(vcn_reg_list_3_0));
+	if (r)
+		return r;
 
 	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
 	if (r)
@@ -2342,67 +2336,6 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
-	uint32_t inst_off;
-	bool is_powered;
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
-			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered) {
-			drm_printf(p, "\nActive Instance:VCN%d\n", i);
-			for (j = 0; j < reg_count; j++)
-				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_3_0[j].reg_name,
-					   adev->vcn.ip_dump[inst_off + j]);
-		} else {
-			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
-		}
-	}
-}
-
-static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
-	bool is_powered;
-	uint32_t inst_off;
-	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
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
-			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], i));
-	}
-}
-
 static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.name = "vcn_v3_0",
 	.early_init = vcn_v3_0_early_init,
@@ -2416,8 +2349,8 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.wait_for_idle = vcn_v3_0_wait_for_idle,
 	.set_clockgating_state = vcn_v3_0_set_clockgating_state,
 	.set_powergating_state = vcn_set_powergating_state,
-	.dump_ip_state = vcn_v3_0_dump_ip_state,
-	.print_ip_state = vcn_v3_0_print_ip_state,
+	.dump_ip_state = amdgpu_vcn_dump_ip_state,
+	.print_ip_state = amdgpu_vcn_print_ip_state,
 };
 
 const struct amdgpu_ip_block_version vcn_v3_0_ip_block = {
-- 
2.48.1

