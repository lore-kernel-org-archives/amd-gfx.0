Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97622C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 16:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101EA10E11E;
	Wed, 23 Sep 2026 16:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wG4dp5tw";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC9B10E11E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 16:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgrWVrbMEEnj5ZEcIPWv0cjzbTvaS5yBqeKFokZDrfhpt9qcc3Qp8ZINPmDdSvXQzfpducBttb1CKt7kCvf3eu6h27+vvtBg6FHqOonbWBJ1yyP+AsgpKobcANDeEboU/YjdgV3rOvppsD4wiAgfY1HhtWs/kfYrHB2KUFbSsMEg/31v1HpBk5BBwICUqM+gm/7KPCSpICdPyDzAXsTBBi1slxNXSP69vTK3NklH4Wdl4zgGwJcm8ghu4hGeRaoI4l1YPsstkfJbXjrdAmYsGROG76WKaiSgP4J1vuTZRU9VTOBposiKEBKB/it91GK/2Nzg4oNSi6SHePt96AjV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jkxrjrUoOInvK1RUgMeAhxYydfC7wLlj4jYn03Qjhs=;
 b=pGQA+6/CCkmHS4MlOEOmH7M2d5BDoZNtlgRCCjNPdoXvhJgwV8oe8nOHLO+WEyGafvPUeuNezzqirkjZw5m9awWM+JWB41XqnEJ6iuq3csQ47eLEh9BqkrlVqsTRNgm0g3hKjkLT7QuTNfcmxKRL1cwmIDaJaAMiExWNkVrTlJJbQ48R7yt3c1aW6Ul/JmGpd6iHlSs5YGaxfj9dbmfyDfm6xGMrI4qEghxHYUipaISXYAd7f7myQB1jNOlfLaDRH8IxVzqbgD44cmKvl9AYS+MqjGwBYDtK0TDwf37Yn7e05y9OivcIDtXqIsf521HbukEP/Ipq6TKdkE/5OI40Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jkxrjrUoOInvK1RUgMeAhxYydfC7wLlj4jYn03Qjhs=;
 b=wG4dp5twqS5Eor+FkVUpCYL10fViOqGg/fQDBa47nRxgZWcmcdyR8efZtcRkKpmxlfzvrnF7oedzVpstklze4jfVS4i7Q/RN0y+Z6rq6fZe7BkApGQ8hcTEoauoDELP19b4aaXuokO27jNi41UenlPNAVu9MqD/I2AxvljJfWsY=
Received: from MW4PR03CA0202.namprd03.prod.outlook.com (2603:10b6:303:b8::27)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:21:12 +0000
Received: from CO1PEPF00012E7E.namprd03.prod.outlook.com
 (2603:10b6:303:b8:cafe::83) by MW4PR03CA0202.outlook.office365.com
 (2603:10b6:303:b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 16:21:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7E.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 16:21:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 11:21:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 11:21:09 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport;
 Wed, 23 Sep 2026 11:21:09 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <broonie@kernel.org>, <alexander.deucher@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>, Leo Li <sunpeng.li@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH] drm/amd/display: Fix compound literal stackframe limit
Date: Wed, 23 Sep 2026 12:20:13 -0400
Message-ID: <20260923162041.724466-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7E:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfaa47f-d996-43e4-c0a0-08df198eaf09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|13003099007|6133799003|10086099003|10067099003|56012099006|11063799006|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info: ORXeBdW4Tiij3qpg3G/xFIJGOUMnPoYrHilb5NKjs0PyvFi6v3DEel52D3IKHfw9CJIhWovOs6wUOjxucecAKn50/bW8Nucyv4xth1bQ7CclebquTBP/vwVSls7pQCBxKA9jDatD8h2EpZO5QDdba2X9FcF013vnlFuJ1qOJe1XQ+c9AqCr2z/8/aMNLldJH4vH2HJmgcXnaWTNkUY8DdZVRQtcFEW74kJujTmD19MyLvPry25s6OFZabOef77JMP8H9M805W+MvHEPiAnceqfPDONPQT0hv7Bhuu26Loi48Ixbuj4/F9DDK/RazuzyEGworDKKBQJDjqOdR/iMgeyvtS+G9JQa/R80aQ0Vx0Zqw6B54SyPcMpjUmRPRNZICzebbN+vqgaUAW+G/3unLR7D+8Z3RMfoGrkTaZmpFyHk+Z/lqWsJ4IZZ/mgJKfz7VBCuSbQ25A3W8xKoDkQdcV6hjKYxpdi4YxWZqDcX17Xm0PwVm/aObI7xZDlM0JyMXaJgHvNb1+qeAzEnKOEcyZdMJQEqCOjs/Ik2fX5mcVElKg/s2CLzALmnpqSwjzbjOs1MX6rMxcM3Wm88KZnmQ0hVb6rWu6vCNotUpwKXoO7CXuUHpHPh2ZOa00dvjTfGy9iDVGGX3YnU7wMhByRxZNZIUcYZH9Z0CTI6x1eVbt/A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(6133799003)(10086099003)(10067099003)(56012099006)(11063799006)(18092099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lqvDxXgYKMmb9x1gedZwFHeXROQscPSYzK+ZKXOg/EOcCy3F47+ZYR0FzY9GUWhBH+/iwjZr11AIcleh3f2QGcpgVpDVSO4tBxJmzLTRql8j0TicE7k0Z9c4aPs6wLBmUyEdlkZSBTlTiNvZtQlMS9yL+LriIyik8RAPZS60ocac/ih3FhUFC4MLVOSscz/ADU2Guv3UrbgAr48qnMI3tkT2eq912ik5JhWsesOm2YAwRzr6kH4Ao1AbSTCvZHWefphCTwhDep50TGCEkBeSQEF40yo1/YJl9WAqJ8MUPWteFWNdfY0fZc5TTBjhnP5xkmHxatRTm2VPVBMlat/8Lv92Mbb7wJFwyIbAScBQwAE8LS4bqaj7d4Jse2wMgjJn+9F3vR32UIRHU6pzpey4BozcTCISlG07WoJD2gKT9rxenfyYYAj8ulBb8T/2skaH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:21:12.1253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfaa47f-d996-43e4-c0a0-08df198eaf09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
Use of compound literals to initialize heap objects may create stack
temporaries when compiling in debug mode. For large objects such
as dc_memory_pool which is 2 pages large to avoid cacheline sharing,
this causes function stackframe to exceed kernel limit.

[How]
Replace compound literal with field-by-field initialization.

Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
---

Hi Mark,

This should fix the build error mentioned here:
https://lore.kernel.org/all/aq0vYhZXtMqA41wZ@sirena.org.uk/

It looks like our clang CI builds didn't have UBSAN enabled, which
expands the stack size. Enabling it will hopefully prevent repeats in
the future.

Thanks,
Leo

 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
index 904f8c4a47833..087f04d314592 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
@@ -107,16 +107,14 @@ __must_check struct dc_memory_pool *dc_memory_pool_create(size_t size,
 
 	struct dc_memory_pool *pool = page_align_up(unaligned_pool);
 
-	*pool = (struct dc_memory_pool){
-		.size = size,
-		.capacity = capacity,
-		.unaligned_pool = unaligned_pool,
-		.unaligned_memory = kcalloc(lines + 1, PAGE_SIZE, GFP_KERNEL),
-		.free_list = kcalloc((uint32_t)capacity, sizeof(atomic_t),
-				     GFP_KERNEL),
-		.free_head = ATOMIC_INIT(0),
-	};
+	// Compound literals create temporary in debug driver, exceeding stack size
+	pool->size = size;
+	pool->capacity = capacity;
+	pool->unaligned_pool = unaligned_pool;
+	pool->unaligned_memory = kcalloc(lines + 1, PAGE_SIZE, GFP_KERNEL);
 	pool->memory = page_align_up(pool->unaligned_memory);
+	pool->free_list = kcalloc((uint32_t)capacity, sizeof(atomic_t), GFP_KERNEL);
+	pool->free_head = (atomic64_t)ATOMIC_INIT(0);
 
 	if (!pool->unaligned_memory || !pool->free_list) {
 		dc_memory_pool_destroy(pool);
-- 
2.55.0

