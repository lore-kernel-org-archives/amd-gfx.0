Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E245C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE95810EADD;
	Fri, 21 Feb 2025 16:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m/cL9HMQ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F7210EADB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snHJ6YYtT7nZVAxInrqj4ma0MNodBXf+S8V2nL4KL3AUSHjmoMlUYL38NM9QwCE/mzNjruNk43lN3x//3Vg8SSsFJk/8r1Ka/LefPgX+ODtJSEQmhbiu0OBDOd8Qxi9J690oPc9ANMxw77fM210HSQrW/o/diK68PwUbgQ1YQzifxq8FTQYzfk/QfesjdHH7Vb44cApPzcP8vADmgMrX1bc+bMiLMZDu9RXfjSdo66phTwzIYwmVXN28N9Zf2M8Ji4lf7rpm+o884+NS5yYAMUjiikdJNTzqh4hcl+PhwDD+krEc6UvfZ12bIfBt2sCBPODF779yY03W7WcXwIjQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R081jv5q5ZnRdjnlvuRbkOPLqptYpuS5ij+Y4wn93yE=;
 b=qLvGAowSEXOA0yZD6s+tabcJN5h6wBg2aMJxHHG94h03NkrtXjUoCQXu5z43HcfQcBGvpeGmHBR20rGXev5EaSb5pwLGkprKgzw+vLmN1cYS1y3b4+A1R4/DrA0lkbe6uTJXkfFh2AZFD3iZLo8RBVzhkiwNJARer/jVtLZsSgHCDnvly0fAwBJ32AtNQGWokD+dSsafPkoqqE2iOsLJ0S9sLdtOyM7Y0FBwgopwr2+xpoqIdISSiZxzFLT8jHprCFBf5NVqml1CYQpad/qw+y9SElD5RYuLN0ppJtx6tWakR/chdwsMQzfxWr5izkC0WRr3Q+x97JZ3eQr4GFTuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R081jv5q5ZnRdjnlvuRbkOPLqptYpuS5ij+Y4wn93yE=;
 b=m/cL9HMQO+Z9k6KwMUIm+pugASdKpzJsYlqIurb8p5OE41gdofO1n589p9YiNY69fA7ddsdQxFb91NUEvNGHYsEd9AfV1J4xzsnA78hhYpuf+4W2DY8L7VxDEvPbj7lf6+97kY+7RNeb0SDLyBaIVr1TqVEZt7ksi6ZcjUNZwIU=
Received: from PH7P220CA0057.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::20)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 16:02:22 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::49) by PH7P220CA0057.outlook.office365.com
 (2603:10b6:510:32b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:21 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:12 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 09/24] drm/amd/display: Fix unit test failure
Date: Fri, 21 Feb 2025 11:01:30 -0500
Message-ID: <20250221160145.1730752-10-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: d156fc91-f479-40d2-3369-08dd5291201a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6/urNT2/cGv/odflmNALEVYRBTMZVl96SI4BBm9F4lHNPpnvUH38R3r0z9U1?=
 =?us-ascii?Q?oqAbNewYChxhlgWWfZbDcEJujPDhYbNDrjx1wsWXWPSNt9VQBl1KSQ7taK6B?=
 =?us-ascii?Q?3GNpj0S51uxua2VarP53kYnKsZHFezsXnrpejt1iNLpz9rSiJMn0RYVGgVm4?=
 =?us-ascii?Q?J+sWfCg8yNwvPofYSg05ERbx+jhdzxJ86IBfNSCjTqfwD9xVuuVy1/H5aOD9?=
 =?us-ascii?Q?9hyIEIzvojlR6fNDEGDm6pTRlZI1/5jNt2T8zPCtE1YZ+G2QYYBBrw1JNUws?=
 =?us-ascii?Q?Xle10bnDP5V4k/aaNLZgDpzk6NmOBcfN7v3ZcxEdE/5+dgRSHd0Bz2G1dV6p?=
 =?us-ascii?Q?o1HRT5GJxL4ceYCOMLZNT2HENB6+tUSGctllGjWg5yVXwuV9BAvZ0GzojCLn?=
 =?us-ascii?Q?Ju58GwwTNC8ammEUCiTWEkqdFd0Bs7ntVj18jUwNG5m8rLw+mpUzE2mJx/pq?=
 =?us-ascii?Q?X4lf0zauezG3KKAOuIDkvAMwPmQdoOYazYJQngYsHTXlzig8tisjqa/aOD9Y?=
 =?us-ascii?Q?4ZFUIWcr5eMVH9amU6io8aYNB6LG6sNjmVlEdU62J6AtKhK2E5KB3r36TjiW?=
 =?us-ascii?Q?4kXBmttLeXFyugIKVyjOLoBClwNo+iL0uzNE7bKDdMtnmQzUkNv2wiGJrrC7?=
 =?us-ascii?Q?7h0THbiec/M4UnZh29nvuJt8ICKyM31JjNDVjb5xbw9CBmacAbL9M+9GWxRc?=
 =?us-ascii?Q?v9XzDvbxfGIZqHzzEAmB5AqkU3xx5KCcwpDlkqe0qoSRW4e8IKaPAPEICTDM?=
 =?us-ascii?Q?Vt7h+XJxI4slw0yWZy/+shEl/rTytbrsDSH6l5IR3FwENuzQ/8AqbSot9cSj?=
 =?us-ascii?Q?qCTUqMcAWDv30mHviytdyRGlZyMpU/n2V/IF17xc48vXthg1hiSqEEuO6f8L?=
 =?us-ascii?Q?VTn6Wo+RjWXdphrQGZYQ+6zCesxz8E4ZoLydASXj18QrMdX24eAemHulQNNN?=
 =?us-ascii?Q?yYPmEtvDiISGKw1eYOBSxj9ZZ6LHr3Ljx6Heies5hFZveTFELanBuM/8d7Ms?=
 =?us-ascii?Q?OAMSI4Jzj/acSXOo+slcmMNlh3J0OWnxdyv+hRr8E9z24NXVA6/uYsc0j/BZ?=
 =?us-ascii?Q?edcWv5nIC2NE+Yyi/2GIP0SelG+62PLwrOMek3cUrfryIQUoWvrDsxT+muOp?=
 =?us-ascii?Q?R5dB9zryJnWtKAbRiQ7YFXyPw7jg7qzv0qV2RnfS/5p+S/95JKZ8fbb56YQe?=
 =?us-ascii?Q?XCebs4j9aSKV+sS9MaTAoiKCUkVsAnYf7oMDhNXhhkY+1Eb6pNeTktT/bc6W?=
 =?us-ascii?Q?3i8gMPTxEN03CPgtURAd19ghTIgSFuphGUUBCEDAtBGy0Z/Pv88V4dCXPvtj?=
 =?us-ascii?Q?o+JfQ8jcZg5LtOMgKOp24EkrAYJmkr9n3wy1wq0IiQNjcLP0ojtqAOchzndg?=
 =?us-ascii?Q?nzxbc3F4siJVx4Gmctk7SLGOuGqvmYdD57SESWBz9INlWHtF4tIv09XwCELJ?=
 =?us-ascii?Q?SlwC1igjEM4MPoA662hlBzb4ehIBTK9Me7c0DXz56MvIdA7IwS/nopOUg5Oi?=
 =?us-ascii?Q?5PnADo8Sa2B5Ovs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:21.7239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d156fc91-f479-40d2-3369-08dd5291201a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Some of unit tests use large scaling ratio such that when we
 calculate optimal number of taps, max_taps is negative.
 Then in recent change, we changed max_taps to uint instead
 of int so now max_taps wraps and is positive.  This change
 changed the behaviour from returning back false to return
 true and breaks unit test check

[How]
Add check to prevent max_taps from wrapping and set to 0
 instead

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 047f05ab0181..ad77cef57ac7 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -1026,12 +1026,18 @@ static bool spl_get_optimal_number_of_taps(
 			lb_config, &num_part_y, &num_part_c);
 	/* MAX_V_TAPS = MIN (NUM_LINES - MAX(CEILING(V_RATIO,1)-2, 0), 8) */
 	if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) > 2)
-		max_taps_y = num_part_y - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) - 2);
+		if ((spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) - 2) > num_part_y)
+			max_taps_y = 0;
+		else
+			max_taps_y = num_part_y - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) - 2);
 	else
 		max_taps_y = num_part_y;
 
 	if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) > 2)
-		max_taps_c = num_part_c - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) - 2);
+		if ((spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) - 2) > num_part_c)
+			max_taps_c = 0;
+		else
+			max_taps_c = num_part_c - (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) - 2);
 	else
 		max_taps_c = num_part_c;
 
-- 
2.34.1

