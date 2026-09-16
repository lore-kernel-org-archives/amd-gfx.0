Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D5AC982D8
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB3310ED0A;
	Wed, 16 Sep 2026 17:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zrd8XgPH";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4B610EBD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc3S1Wh3U5+YgoYyqoxnpsDiNGkN5jN2g2Tb9Pk2DaO8uPazpPg2K50ldVokScMAJBzRd43XuBwe+F/bnM62vplEjChDp7AB34wojZAm9pTtCpwDfO/ibU1LL+e5VqPAmtnnnuGenp3V0HWFJ4IHTmZ24bgpvK5DZ7AvJI0YvsjhvaMLCpIfMDuBBZU7bqmWKtTsBhW6wMHLQQ7kY0RwknF8wzVbXc3RobpNOwNZPcfkdutMhDp97bJohcRKP1KugY3EaqlWmDnJofeiXsAWl5KUuiMgqd1+Pqv/VYCEHheoXTTo3Et3uFrzU255wqpq4RdUWAovMvakuhuAOUEe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JylVdz3cpGB/Um86arNEgzja+R8dzewBF7tDoRw1cfw=;
 b=qcNK10NCLcMbqa41FS2ZwetghLBN2GUxT344SoqRVPW7USPP4A8FIdDiSClMTEhfI0oM8eJsLTuxWlu+QxntwCw1EpJgBczjF/MeZE9yYQ0JcSgpe6WnUm0l9cDFdpP6Q1PUa/OfQLNFqbxiRZn3f7EiIaTOIlVtO4yR9w5NsvpqPLhTjiy42a74bsdq8y/RZdVyXriM79CEUyPM0MyAJ7EZHKZwKdB0eIVmtE2aTcNB9O33WgPa4NM8DKXD7tAYi33aGcnlk3K/Kls9tlV7edhqC2YeS78kQrsaO+VL0ju94JEj3XaUULQGWHEazVHgLrN7LDK7+Iaf4sy2hOXgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JylVdz3cpGB/Um86arNEgzja+R8dzewBF7tDoRw1cfw=;
 b=Zrd8XgPHdpHxIS/xrZtfEnK6okeN2/dwJ3nJWC01Yqq2sn6Qcp6QkGZfxm0UaxnbWTCXOEGTME+gi07mlWNfC1llkOyiPw9o459NFXtoAnbkb69sMXto5jXWPBD3/sLkxQCKTmM0b37zMcpaMRGLcVqYBRZMfJpO+mr4rzxHms4=
Received: from CH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::29)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:53:14 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::66) by CH5P220CA0006.outlook.office365.com
 (2603:10b6:610:1ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:13 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:53:02 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <austin.zheng@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 62/64] drm/amd/display: Fix LSDMA divide by zero
Date: Wed, 16 Sep 2026 13:52:17 -0400
Message-ID: <20260916175301.368306-63-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfa2ce2-8247-4db4-f844-08df141b6152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: byHoGZzazKm0ERdqvhrFKmBpbMadnPwU0pLfa8qsU3QBwjf7HkKmG7bN1BD4lUujlEBgkOVh48mKmtOTRg34oL4C+Hk6vEuBMA9Bqa/snH0Dpn1NEPI8xlion0DEmxLbfkAOuZbMRy7PbQHdj0MMK5+01MTrmUrPYLp6hmbh96+99CLJv16QgOrxATGJ2cJ2NYGE8ETepMbaWRT+zgjM1/m3dAj/v71o8OGovPLKvWcJc8T4GwTYOdfKRdhnwQfqvr3nvwDM3s6U8aA+nUWKv3jmt17WRzH8mu8tQCT0i4CgFgJFd50kzEBlbNSixlazpPgoEkcOPplMU+Nunj6+iIlZbLnR+qXAHtHnXQkQ6l95P4+y6BW2L4QIVD9d3o9zshUdCW1SCmbYcPCVNXoWbij+347cH8XG3DJExWSoS1VGy3lzhPXIZgTQBKZCwXRcr+j1VlFt+x4xLmT5j1DW4LQTARCblw9U18/IbX2ERtyoxotRtDqP6ftFV3kObCiOqQFu6Tg2Js0jdIVhxca9lguLCjXbWhFYIYv9kNB9fg45E/RtGiYvG2tkmllAsR9JJjz5HZPexxwzNKp96jOlYLjSIKEbJ/t1sUIwpKBATWZ8rWXw0J2r/9v4w5U4rUs5Y12hj7tm7cEot8wEgXbbLaq6IdaUfNezN+dxTZhf17mnjmJg/RWrxP8AecN4Z6y+IwBxd2+j7QF1RdkjEjEG0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZKesoiZLji/PVmgC5OEf5WYkqQw4p9M4RWkN7lOZ5IEx+HYU6m8fnPpsQVRIeT1lRCre97g0LRguNyD3JF5OUyUHzSmA5Kq01HWGS4MVGVuTjzelSyi+B23f7GZ4NzSz82UJNfehTUe4Sn/i1qSLnuiGypnemD8F5GuVnod7G2yiyOLpVb9aNSSceOgrEhNSJXLEKWHZKtbZIiJJQpeMKQHLyIT6cydWkFj+PuzieU66Ce8eY4AAScaIuOnalFEn4xB7hs03ZrEpckCRxcKkKTXk/DVm5kHxJlD09aB5MErndCe4egbTqYb0YSrmJpQhkfjNkRWsvXvr+tEk9jSGGRehJlRFEz6Tr/1S65JzCqPTObZMVYqRgqhzA+mgFHdyae4KUaNRJKaxQeJtR5GEd17G4EntxeEtomfVEOry3T5dbui7LLAWrfS56FkhJFbM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:13.9015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfa2ce2-8247-4db4-f844-08df141b6152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
element_size_to_bytes_per_pixel() handled only element sizes 0 to 4 and
returned 0 for every other value, and an unexpected element size caused
a divide by zero.

[HOW]
Derive the size as 1 << element_size, which matches the existing
encoding, and fall back to 1 for values of 8 or more to keep the result
nonzero.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../alternate_pstate_shared_lib.c             | 22 +------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
index 53ead9f687ac..f082f058001e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/alternate_pstate_shared_lib.c
@@ -884,27 +884,7 @@ static void populate_lsdma_start_end_lines(
 
 static uint8_t element_size_to_bytes_per_pixel(uint8_t element_size)
 {
-	uint8_t bytes_per_pixel = 0;
-
-	switch (element_size) { // 0: 8bpp, 1: 16bpp, 2: 32bpp, 3: 64bpp, 4: 128bpp - Values supported by LSDMA Controller
-	case 0:
-		bytes_per_pixel = 1;
-		break;
-	case 1:
-		bytes_per_pixel = 2;
-		break;
-	case 2:
-		bytes_per_pixel = 4;
-		break;
-	case 3:
-		bytes_per_pixel = 8;
-		break;
-	case 4:
-		bytes_per_pixel = 16;
-		break;
-	}
-
-	return bytes_per_pixel;
+	return element_size < 8 ? (uint8_t)(1U << element_size) : 1;
 }
 
 static void populate_lsdma(
-- 
2.55.0

