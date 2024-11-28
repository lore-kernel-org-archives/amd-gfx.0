Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59E4D69114
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9531710ECA5;
	Thu, 28 Nov 2024 14:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2j13Tnu2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C5B10ECA4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ln/ogg38IBzuOpzF4np0V17A34GPNUS5P1fZBNiOMTCcpCFBzg4fbAqSheizJIB1SGO1xIcF+iIREF1igYEUMPfzN/VDNosygahRZfqBVJvt+lxzQTAINdnMcKkzroZpGVwS9phah95vLIrQmFPhQO2kfUSVVFcaBrdsxPbPMzgVsrQenSNxP8b4IlunVR1f4anv8UEC6ROlGHcFmiSruW2T2spQ1rrEdtJxTi1L1mjuhxSvbkOAx2I3sXOUgkc7neMQF/DiSIaEFDdYH/90cajrfv5fe8wzv8M6TmnYmlUE4uXJaZyzOGDXRrOijnuBmjZFf2BAwUkl876gbOrNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEzvbdnda1f+ysXvxLU0baOWqDqHiu+GgS+sVGbRaxo=;
 b=jaVJ5seOuSm85AAngSYHaeHWCHq203rRQI/Co/almqtXcj/vfoCYoeCSQkTSX7TIwdQ/ff9G+p6HQJH5Ece9oRJ9Z0wDt9vdo0Vf5pFY2jWR5RVMXoIyLzD/Vs/u5sH+dQTqsxZ4jggna+qOYBoaMNXpE07IQFhAt9hgaHdfQ8EfNpK9r6KsqNuLmWOzf91MU1xm7NhjP4jyVUcoSht+HZbUX9ukfigA1NWy001t+c4KvehZ5/p9VSIXYBQBoSJ+tQttB4OWkEPtMs3GRYxZkxsHJjUbgfRBU3aE2H6v3knXUHBbhYZzpKOIbz5LNXp/6aMK8N487L6jYz3NF+zufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEzvbdnda1f+ysXvxLU0baOWqDqHiu+GgS+sVGbRaxo=;
 b=2j13Tnu2RldVZEYtu0iQ34JsGHQMXSp9pvbmKrSe3Rc4JUxDiDD1ZMyCGcLIC2pg0zO4KNKpTCOU5PQBNyT3E7WPJHsHo46kzQZ/iYiycvwajiDFIz+W8BjjGUpqegGSJWWwX7Qdc0pVnmxkQru4So/EfhWgVgJs5v983CxDDQQ=
Received: from BY5PR16CA0001.namprd16.prod.outlook.com (2603:10b6:a03:1a0::14)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 14:30:25 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::2e) by BY5PR16CA0001.outlook.office365.com
 (2603:10b6:a03:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Thu,
 28 Nov 2024 14:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.0 via Frontend Transport; Thu, 28 Nov 2024 14:30:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:23 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:23 -0600
Received: from jzuo-linux.phub.net.cable.rogers.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Nov 2024 08:30:22 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Navid Assadian <navid.assadian@amd.com>
Subject: [PATCH 7/9] drm/amd/display: fix v tap calculation for non-adaptive
 scaling in SPL
Date: Thu, 28 Nov 2024 09:26:29 -0500
Message-ID: <20241128142958.28370-8-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128142958.28370-1-Jerry.Zuo@amd.com>
References: <20241128142958.28370-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b39d4d-9d67-456a-f77e-08dd0fb93275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XPDB1cIbch+k64ft6wwK4iy/Vq3RKjNI+RxkBJKP6YYhw2KtCY/vSt7CEYdB?=
 =?us-ascii?Q?I86Q7ECQA7R/pCpuzLgUugzbsZJJc7gwwFeZoftSUYU0CKvNOAgs4Wdf4OBF?=
 =?us-ascii?Q?jytKfALdE308YMxTRT4dZn9BlivcgjpA3MXs92GNdTf4H2Fo3kZ728S2xqMq?=
 =?us-ascii?Q?lPJ46FH9BO2uz3ORxDXVCLPyNZhqef3b7wgdGU8hA0Bk4jWPlwLDs9xOM7E5?=
 =?us-ascii?Q?8rxpAH/xMG3RgjAr8mbZdQX0AVWspViF3znjacc3uCDl60uNv8++SVN17B18?=
 =?us-ascii?Q?tsGb2ZxTR8y+b2BIxrZFev1k4F9O+UvMnXvmlZxJQJBXWcDR+641ToHqTO/B?=
 =?us-ascii?Q?RTireh1GD01AW/UWsWViTHxWY8Chl5oODEiWYll9V2ewQl1+Wy7N/I9AIuc8?=
 =?us-ascii?Q?mgmh+kepm9A8b1gAi+BC/9QJBHzdRwL5M71v4IK9k0Aa6y+MfLiTcB2nEUCE?=
 =?us-ascii?Q?TK25jY+Y1auuwGMS7nPjkCawk7E/drtvGn19zHlciJtTAKDhzcRz6xhdb+jU?=
 =?us-ascii?Q?d/OwV0J4AyTWkd5pA+vgz0ZZhN+RzZTYyx+Hk9zvKKrGUBW5ypXdoqvAtL/R?=
 =?us-ascii?Q?e9M/fDRTYX25qMFwCWwWMtX1JFEzI43BlIBKngdmZsEL61aPdU1hR/0QzKpM?=
 =?us-ascii?Q?LIijEJNX3rk2qujsVQODv/ytnU8H0gpwKs/A2vaJwWikAMwP5+2nKfGEJqTE?=
 =?us-ascii?Q?b6SqkBhw7EoBVGtAke6VpnF8b9QSxh3PlKh8+ekLm95740fpfoSLVUVwBRsI?=
 =?us-ascii?Q?XsMMbzMuGocQIgn1K6fZByJSm+k09lE6CuKCXoWjJKXUkDemcyjIwxt9gkDm?=
 =?us-ascii?Q?YDxN3TgyM8Fj5qUnJC4hFihxmZrw263CvJwqKNO+5ht8thFcIrCfzaJHdAFg?=
 =?us-ascii?Q?xwWNKy+ENZBcm/4Bf3r2Y0awBFZDv9k3M6nyWQd/0S825Ztdrrh2bWy6iEhr?=
 =?us-ascii?Q?pygaO8cXgEoXajfHhACENt1/IIW605AeJXBb3rcZDOxKx6lG3Tanv97yTt8R?=
 =?us-ascii?Q?Sf1V9hWNJlyzYuJ/sgPd0l5cfMqBtgaWdvf1Wa4vaqs/GgMpcMT5vUWMMTQI?=
 =?us-ascii?Q?m5tDE9B4eEif4v2pU+7mxO6BZHg/pdAKrAGpdA9ezutKERVUwe916eIDbi8x?=
 =?us-ascii?Q?0wN9PU50mwsuCVPB5ojKFdldZk1OmOzktGeQ5rltt928KyJJuTOz4EcqkQNY?=
 =?us-ascii?Q?cESsmJSpl174LCKZQ6wi3vfN75qfRoc0KX4UD249d6SeNfbsE3bni07cR7WH?=
 =?us-ascii?Q?dCl8NjidzyZ6+ryHrCKj3BpnceSvZIS7DGgHvl8GB3zlGc6kEUIKO9SC2OpZ?=
 =?us-ascii?Q?8t7sqdRQK4fBXyuU7fcidWXUYkPw6TFHiBbYNWqUKPiV9rFjuoS1L2rg4b70?=
 =?us-ascii?Q?NvN8pAu8xAch/z3eygmtU9Y2aXOsRozAY5ceQ3awZqE8hscfqZWXtF3tKq+T?=
 =?us-ascii?Q?QQ+tjt+Rd/FQvjwtZkBDwU8gDD7U+qtJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:30:24.4874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b39d4d-9d67-456a-f77e-08dd0fb93275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

[Why & How]
v and h tap calculations slightly different
Use h tap calculation for both v and h tap

Reviewed-by: Navid Assadian <navid.assadian@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index c92312fec7a9..72d55e9a4fd7 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -899,8 +899,8 @@ static void spl_get_taps_non_adaptive_scaler(
 
 	if (in_taps->v_taps == 0) {
 		if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) > 1)
-			spl_scratch->scl_data.taps.v_taps = spl_min(spl_fixpt_ceil(spl_fixpt_mul_int(
-				spl_scratch->scl_data.ratios.vert, 2)), 8);
+			spl_scratch->scl_data.taps.v_taps = spl_min(2 * spl_fixpt_ceil(
+				spl_scratch->scl_data.ratios.vert), 8);
 		else
 			spl_scratch->scl_data.taps.v_taps = 4;
 	} else
@@ -908,8 +908,8 @@ static void spl_get_taps_non_adaptive_scaler(
 
 	if (in_taps->v_taps_c == 0) {
 		if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c) > 1)
-			spl_scratch->scl_data.taps.v_taps_c = spl_min(spl_fixpt_ceil(spl_fixpt_mul_int(
-				spl_scratch->scl_data.ratios.vert_c, 2)), 8);
+			spl_scratch->scl_data.taps.v_taps_c = spl_min(2 * spl_fixpt_ceil(
+				spl_scratch->scl_data.ratios.vert_c), 8);
 		else
 			spl_scratch->scl_data.taps.v_taps_c = 4;
 	} else
-- 
2.43.0

