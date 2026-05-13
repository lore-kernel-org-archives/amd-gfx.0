Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6332CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6787B10EEDC;
	Wed, 13 May 2026 14:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o+Fd0cQl";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2372310EEE2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1Cyvf6ogail//WBBiAn7yIR29Rq81dHJ8UJv/U3BFFcVSUBxbp2XWB0MyeYLl+i+JeFpavdUht70huKo1gVDGxcxBEYKBFTmfwozGJbSG1aQRpkc09DAddm06empeg+NRlIL15TyzV6aSMWdqGfE7f55gnrbu+BJhii7+fgpBL5N9/gGkw3Y5wl7jfcUfNhpdS/TPpTt8jV22n3c+0n07x9GnL1blcud2JRE44vuHDUqAwbs57IwBIKy29R8ruGOQssMKDNOvtGFiAttTjdjJ+QYEL8nqbqtoXlBY6tbpBdKGIskMYrcFLmQc1Tf/PIok6yCP5JYnBCB/oFvtj5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ/pa4KBfHQgdKL6pQL66+AfMPf9tU6+jkj2EhVUJgc=;
 b=mzFtvf2m3ksnD3CqtpnObdWMihO/c+FwAx4GMVF8yOJYEKQminyekWjngbimGBYxIjfdMbufEOwqhxhV9H9ToxD7aTPxo97QsLKVtyGQ+dv3bH2F7daHR8XqvPiIdUloRXlbWMb6FxO+F+ovQCBVvrx8V+7bauzok19H0UdFAn385s167ykY/uEegesS/F+WgoOflp9A7kO53L8qizg5Wit7+JrQ0LsDPeKl+VhSJOfu4uXsvONXF3/Rh1QOtqi1XQ89M09q3HP2j1GBm9zhdHOx/IgrdYur5yBiW/9tWvX/n+RNyR/s52h3eGBL1YmgKsv69+Wb8yHiqzrsBS7fyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ/pa4KBfHQgdKL6pQL66+AfMPf9tU6+jkj2EhVUJgc=;
 b=o+Fd0cQlMZovY8vt+y9UI7itq1+C6cfwD4TC/HwK6ufyE8j9Vfb+aN2gtt4b5csMWs7J+n0GMqUna4VoGBvekreNxdPfCTQdUQMe1CAahHjBWsduAvCkjE7Fta18Ty2L61OvhOm4K7MoBBnEDL4YNcpr8e4hDLHKjDbnrjM2Ads=
Received: from BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 13 May
 2026 14:33:47 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::33) by BY3PR05CA0028.outlook.office365.com
 (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 14:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:39 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:38 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 22/28] drm/amd/display: Fix integer overflow in
 bios_get_image()
Date: Wed, 13 May 2026 10:29:44 -0400
Message-ID: <20260513143213.1852892-24-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1814bb-3d54-4191-cc0c-08deb0fca4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: INmMcuNPZcc02jcAoTcp90TVJXEUt2q/VxW/0rDugJowJgIfEpx49M5YNbCb9wevqBFSqcLhA3qribrQhsb0RpTSpk6MCBWLoSLiU9MR2zvA4Ovgf69zOpD17baLGPghtZnWAKk5Ct9j2jAl7elF3SeiCabCuKVnWDHQExUOkJINYRLVp17rjYjBT6CmsaQ2KinZVHxQ2IAW4BF1PkONlbwf8XJHEl4/mnV5qMQ586AV1XGJFKbfSEILOcyP6HqrZ/G0VkTt5Qys8oM3ifCm2YMyB7tDepsxKnxOHNe9ToqMaXcCMMmZ2KyuA6bGQFP8MmN8Ih9s2yaRwQWW48qjmeSblRZtIR8yz1c/6ocUH4iM+PJ2AkAsX4b50ozWQEPJ+55OpHq++SNGsDXva0gU3AQAtSI1KXpq/vvy971H2EBSpbytX4KuzSdRrMfccTMZLRt0NYN3Moo7ArcFE/pE3myOGuZtj8O6gPPu45Ejiraxvciftr4LOhkEgVfLtRMfeazx280y9Eozyp4OQXU1MytH8Bo0fIPQEqe23DZ+BuI0C5ICWT+DKyNYLHphq3hzYp6+ZzatFp5bWXyDFA7BfSVKTJfQuvT7j1gJ0mMdz0XJXggnBQMyxTbBTMPseR72hRBIsIk3S+4EwfhzuhQmrXTRMXaJHi1I95NM9gAynJuJxrxbvoPG1vte60n8EY94KoQJNnJYXmCYeJlJFsmSty7pv8UjxtLaiaJo9XNw8AY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5EPf4sQbdYrhGrF27eO3mVIFHeUF4c1rZMRCkEytPnxAEyulJYripAFSLxHIaYjodRBdmy45V0pn0q4RUnN/BHMCoSXbQXNPTxYDobz74A9SVA9+pQzzGfnHMDOUZ9FNHnoDzUEdzBowkKsWhMo6Za+VCoZk2NCU60U/HehBR3mBfbrOEmhoj9ETsEXQANTkNp2DZAtjnPIWGD21IhiQBkle/k6YxE/vNlLV8SiGaqvbZ0Wbzhb4THoCKsBcOg5FE05cjyJexZ8S9ytHbwLj0Ni01AdnXFT6c+5hjo8DB7RwSz0nJJCHcS8AiZpDALr+FYFKRls1lHHtOsomFj07tSOPD38rMZL/w/HcGQZcux2HiM8rFR5qfOpi0U1DI11gVRcyoO/Gc/hrDOsinKIS6u9v2XVm22ZNGJ1ICt+KyfOV2YLjeDYfP1YJjXraDLaX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:47.2467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1814bb-3d54-4191-cc0c-08deb0fca4a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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

From: Harry Wentland <harry.wentland@amd.com>

[Why&How]
The bounds check in bios_get_image() computes 'offset + size' using
unsigned 32-bit arithmetic before comparing against bios_size. If a
VBIOS image contains a near-UINT32_MAX offset the addition wraps to a
small value, the comparison passes, and the function returns a wild
pointer past the VBIOS mapping.

Additionally, the comparison uses '<' (strict), which incorrectly
rejects the valid exact-fit case where offset + size == bios_size.

Fix both issues by restructuring the check to avoid the addition
entirely: first reject if offset alone exceeds bios_size, then check
size against the remaining space (bios_size - offset). This eliminates
the overflow and correctly permits exact-fit accesses.

Cc: stable@vger.kernel.org

Assisted-by: GitHub Copilot:claude-opus-4.6

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
index 8d2cf95ae739..e00dc05c2d9d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
@@ -37,10 +37,13 @@ uint8_t *bios_get_image(struct dc_bios *bp,
 	uint32_t offset,
 	uint32_t size)
 {
-	if (bp->bios && offset + size < bp->bios_size)
-		return bp->bios + offset;
-	else
+	if (!bp->bios)
 		return NULL;
+
+	if (offset > bp->bios_size || size > bp->bios_size - offset)
+		return NULL;
+
+	return bp->bios + offset;
 }
 
 #include "reg_helper.h"
-- 
2.43.0

