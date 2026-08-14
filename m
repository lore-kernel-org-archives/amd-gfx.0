Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B7AC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 14:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650D010E158;
	Fri, 14 Aug 2026 14:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cTA9D5t6";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88E210E158
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 14:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rgc7CKgrlPWXh74DCdUrbpC0/4PvHC90gCO5Uu8Hunbhipe0LVmFymvudHk5NbrYCiP7TGHuIAXLsujl5NiHkM0RcpmLdJAbBsjKNHj/Mjo2RpHEAI95iJxl/4IAp3ZEaQ9tch5N1NOLxuZLK/qKlA9Ge/8Flm7O1URo2W4NXzFTN342YgGuOmG0x+YKPAH++5wrppcUgwYKNBRgNkQuN00ASu+nifB7hcVve6XvJrmjLRoS+PucshmO7/ujoX5OmPAoJcSCv/oyWEZfqcRID2/ncgbbFGKt4CAIJe8Etc9v9v4NOBvlWeb85eulqKDBLF81XG3mhee1qa9vh+Si1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSzgfNAyJEFb8lszh3bLz5BsS8tWPq9MrOSKY3SRRNA=;
 b=NAA1FKgQl79+OhnDcwBRpeavR980reP7zZMnSyyEHrn4k/+BSjIwUzaac7ufmvQCVYCz8+UmbdTjnTl0qw1XbpT4qO8l+LUsszyuF4fJJqfCN9E7vn8DbutdYB8LQM3EM2FRFNKdenMz7myx59czqur+WOqck7sOscVLvfamTS4Y26i7gvESjJNoWIbAYG3X7ppTrHhdtIShBqSIXE+6C23c6xhc011HyToWoCUyZK0ijDDWobdngGHTEtBv9Fs61/VVPkiG5y3Gl5VXN0Q2msjSQkokTwfDSrGuQSwwjkwS6zrnPsHSe2jtD23eC52G6Hyn116cGwauH4W6XXK+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSzgfNAyJEFb8lszh3bLz5BsS8tWPq9MrOSKY3SRRNA=;
 b=cTA9D5t6WwNCQ3ga6JVjAIpCrVZUENi3385HHiP7WN8pq0PgG8Qbhl5kmaXNAE6EoXnG3xyvv0Po8Vic9W1wfi76zzBgTvL3R53+iW6+2NCBKgBdeWC8j3btON4OeUzrhPUGBTvxceIlNkZC5lgqWZZNWBfTcDrpMLR2XyBqTkY=
Received: from SJ0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:a03:3a0::20)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 14:55:18 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::2e) by SJ0PR03CA0255.outlook.office365.com
 (2603:10b6:a03:3a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 14:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 14:55:16 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 09:55:15 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Implement insert_end for VCE 3"
Date: Fri, 14 Aug 2026 16:54:49 +0200
Message-ID: <20260814145448.11178-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbf312a-cd53-4657-8a14-08defa140dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: UomtXgpAnBQKa5avjwVZY+ZpaK7hJIWhkMe+uwCT6V4BuDXbmvedo/wwoyhg62YFfmh7xVEgM+5xCL8ORsD67eerm3nIM/lnvpNX2Jf5kopKTK2N/6yXUFepuhhWgogflrNMC4mlCWILxxywTC28Hc9YOR9us3YVp0Ma/ROBiqA7DwiCO3ZcKNC6JnbANLz0KBzC1qh6euV9jbcaUumrSGgLNszO/j3CuWk5ITHUZnKxwfe7sLTBkYZL2UfbnjDIOcaWKwMmSUUWsAMCPPVNdgdaVg5hBC2dubzCC72P4Secc45mXunnAeGxGfLhwWbrDsc7bsw7e8iZJBIXKF1/87H8OkTASDOej5CPCfVOnEqWPXQtQLOsWM4FmPooV7CX2mYmQAEJ8Ts1u6NiKTNHPZRZJrxeSRWkSZ774kmHdmU/dCOUlZAHT/96OliYaHZFA8P1fbbgxXBoVV//OdxjXYjL8hG6R5g78hGa9Weuav6j+QQIMimBuPwqlbLwL/hNc9Ql9RKrop3epDGtGhFuCFCuKdkhP0NOP31y46aSJ/YFy7Anoge93eOEwkeu6MpIQ+MP12X0GwvXvXMVN2O+yqFsjlp0YRgPrVMNxoZW/bod4WP6GTHBo9UHGZCh/YoHQXLr1S7dqY8AWWdcBAqBYYP7G3mqAjBjdLgl7u7U/Tdv3z2KSUYaj/HAPNS1qj2OIHaHJQMTbUBznYgfrdYQyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RuU6l96zo/5vwyHd1m8bLdEaLWeEXCe18qzViLdmSvFsQ4nrDvLbs2j8q49+dBQR5USpXnNb8QzkZ7cBEIdk+fgdjlg8HPX5RxmxsW129r4Ks/XkxgrFaPd561Xkjsif6y22E+Gf3TNk+/wnktMWSEcwNfahpbM37wsTHoNe2BQixkFIGflEFZM8joAjp0rVkMvGi/EkXHdT1FeTBzE+WmU8Dh6KSE2xAxzoZa1gvtLDSsCM8QXkaZVFgXfuyDls9G88kIlbjDpkdFkmHpboeAejhsi8gE5OGxQMk3dzum+qFE5WQ+p7jO0BwVzl+yHw4PkDROPPoQWj1DjXfjhDy3YQjv2jOvocB+zzaMnm+pBH2KtQF77LN1L/gu17BBZ33bRrjitZ7Ep8/QbDMxYv6MZHxChXhKn+G5am1ng58COjZ/OBXc2xUqj6qHhJY4ji
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:55:16.9977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbf312a-cd53-4657-8a14-08defa140dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281
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

This doesn't solve the issue, VCE still hangs in some cases.

4959138b6461 ("drm/amdgpu: handle GDS and SPM without a VM fence")
fixes the regression, originally introduced in
83a8dee2bdfb ("drm/amdgpu: always emit the job vm fence").

This reverts commit 7591335141a06d5b176510054576d9c64519f348.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index a9497e2e07f7..9f4e88440c0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -809,23 +809,6 @@ static void vce_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, ib->length_dw);
 }
 
-static void vce_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
-			u64 seq, unsigned flags)
-{
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
-	amdgpu_ring_write(ring, VCE_CMD_FENCE);
-	amdgpu_ring_write(ring, addr);
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, seq);
-	amdgpu_ring_write(ring, VCE_CMD_TRAP);
-}
-
-static void vce_v3_0_ring_insert_end(struct amdgpu_ring *ring)
-{
-	amdgpu_ring_write(ring, VCE_CMD_END);
-}
-
 static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
 				   unsigned int vmid, uint64_t pd_addr)
 {
@@ -835,6 +818,7 @@ static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, VCE_CMD_FLUSH_TLB);
 	amdgpu_ring_write(ring, vmid);
+	amdgpu_ring_write(ring, VCE_CMD_END);
 }
 
 static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring)
@@ -900,19 +884,17 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
 	.set_wptr = vce_v3_0_ring_set_wptr,
 	.patch_cs_in_place = amdgpu_vce_ring_parse_cs_vm,
 	.emit_frame_size =
-		5 + /* vce_v3_0_emit_vm_flush */
+		6 + /* vce_v3_0_emit_vm_flush */
 		4 + /* vce_v3_0_emit_pipeline_sync */
-		5 + 5 + /* vce_v3_0_ring_emit_fence x2 vm fence */
-		1, /* vce_v3_0_ring_insert_end */
+		6 + 6, /* amdgpu_vce_ring_emit_fence x2 vm fence */
 	.emit_ib_size = 5, /* vce_v3_0_ring_emit_ib */
 	.emit_ib = vce_v3_0_ring_emit_ib,
 	.emit_vm_flush = vce_v3_0_emit_vm_flush,
 	.emit_pipeline_sync = vce_v3_0_emit_pipeline_sync,
-	.emit_fence = vce_v3_0_ring_emit_fence,
+	.emit_fence = amdgpu_vce_ring_emit_fence,
 	.test_ring = amdgpu_vce_ring_test_ring,
 	.test_ib = amdgpu_vce_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
-	.insert_end = vce_v3_0_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vce_ring_begin_use,
 	.end_use = amdgpu_vce_ring_end_use,
-- 
2.43.0

