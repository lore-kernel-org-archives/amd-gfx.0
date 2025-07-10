Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D619C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0297410E971;
	Thu, 10 Jul 2025 21:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pLLFSfiE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15FE10E971
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyBDRJKhqB8Ri9n0+gejJFOuNGc52djDOjNf0PtIV5fV9gzvM90ufGSoLs7l1okUYDog2NuBnREyGsKKrMcG62x/1wuWpvFdZiLOZ9QUVHT/ElhHKU6gh6emmqYAWP+wTPKpOD954j0Ga6eRtXwDEf3WtIxtpD5wFNT1luVLq6Mc7m6rKObcoe9ManyJXtA3eGGyWQj8BTzzltJFiR7JEexShmnJ+5ML9p3P1UGCJex6fi6EuRQRNPNQ9vyyp3DItc5652/V2QhqWRWXrtijT+NIeXzUFiv7pKJwAVEzDRAuqz+WZE4RnV6/nkpZs/AWCNkSuX8p4zLk60WiGnfHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDp/winJ78WKec48DTljPnpZa+jlg5utCF2Wj2FHgZU=;
 b=wkksFHdMyk3V3Glbmc3a3v5IEXrDOhq7QhT5GI+FIpdhHgrreYwNgnOaJF1DHdeXMaXd4RarqTGJ8lrxKzmgV4j9puEVp4Otc+ZIw2wJYybjMlxYAAc3EyR6qB1Q4b1jLVj1e9oiUB/tc4YMfXIIBIUyB/UB2CsYy8ed3BRzINlfI8f+CJr9Gkx381M+ypsjGymhBpZd/qCtaeR1x3iOLucrcAdHBJHGr604zbjBcpNd/oYu4WIYNt2WfmnLrNNHJly2M1ZSdMD8nJICcrFcf95TNf33Kk6jKY40Dw7bGGP2fYCoSH95OrZFvTNf+pJ5bSr3QRXMoEOLRkH9J2DKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDp/winJ78WKec48DTljPnpZa+jlg5utCF2Wj2FHgZU=;
 b=pLLFSfiEFcwwqX/yXT1K87xr/M3qjMhnXuZTuRf/SGEgSPg91sMSvEUZ3gxjAGRF9/1whHqrM6FoUhyPawPyJQ18NqqKtRp/iPbQRdP81JJHzL6glLCXHK6mTEGiBhLyhmBHbwuRZLaQowVjZXoFGIa61FVUZSqPuwXuvozmDTE=
Received: from SJ2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:a03:505::24)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Thu, 10 Jul
 2025 21:31:28 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::d3) by SJ2PR07CA0022.outlook.office365.com
 (2603:10b6:a03:505::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Thu,
 10 Jul 2025 21:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:31:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:10 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:31:10 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Clayton King
 <clayton.king@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, "Ivan
 Lipski" <ivan.lipski@amd.com>
Subject: [PATCH 15/18] drm/amd/display: Free memory allocation
Date: Thu, 10 Jul 2025 17:25:48 -0400
Message-ID: <20250710212941.630259-16-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: be600540-e4d1-48a2-a43b-08ddbff92141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vSpHGEApvmxbxR9A84X1mEC/T10aqKYakoeLip03lGFU2w92kNRzftMtBEDL?=
 =?us-ascii?Q?tBgz3hH2ddJVy4SeCXWHgzfp47ofJDNDx+o40FAd6yPIv9qdlqQwQ+5dePN5?=
 =?us-ascii?Q?9jkAgOrfcqdMtKg3Y1nbMRwNCD9aiAYwqA5A8eJVrsaVG9mgve0n1lm/7NBl?=
 =?us-ascii?Q?ugIkHDktNgp5/3UVra+MVNsWOjYWFkJazfXNarHikX69d22GNuJFMQ0eApkC?=
 =?us-ascii?Q?b816pIczBX71Q7R9CNJHJNx7IBX/L5Hi8wCivEOcQNkrPKWQfBz+gentvnZ/?=
 =?us-ascii?Q?++p3p0Zhsh+4fgSpPm9ytJE2ykRrWUQBEtui0d46nfOGGkeIAATTUYVSZ8z/?=
 =?us-ascii?Q?Kby8MByPkSeWnnrtFMLe6j+hcOFpn30wPxaTgC5kdYu7HWHD1C9/YFA30wrS?=
 =?us-ascii?Q?W9Yp8ms40cAmvQbv0a2fBLhDaveKaxYMn9aJiaox3wdeXxIGsYsub0MgRrlt?=
 =?us-ascii?Q?g3GwMYAVweG8HFmw2dN4NxyltoYGL/twHMOcbyii3CBYSeOSsSF0VjqAoixR?=
 =?us-ascii?Q?rWU86M0JxQ5LxDPT4s2C7sORwgJ8mrbEefQ6JvMwXTGnMUhZCUOIzZg5czTU?=
 =?us-ascii?Q?jyoNKeSF7aGebPSEzsOLYHNBaYQCmCaJ8AkH2eiHF9Gob7hKCrN+M/TW869U?=
 =?us-ascii?Q?nc0mrVtopp/FliFmZYYTLCdPWb772F3SvU63/qUMazj+rR/Owfdbju3xALhE?=
 =?us-ascii?Q?FxOFl1aeis2o3+rXK6aet/zi+5d3UOyMmWt4YIIlbIpNT9fuFZTOhq2/9ECn?=
 =?us-ascii?Q?/Gm+q7eLWm6xwp0FG0U+wk0VdBg4Byi8vbAzv734CCuDJRL0cHTThArIy+GO?=
 =?us-ascii?Q?Zf/t4EmQpjMiBexBEpBlUM08lfXsdod5Tf8Iwt5TuLF/3NwFQW9/aO92OYUp?=
 =?us-ascii?Q?nGXghIQLGvoBZ6SkrSzBceT9sr1/dKldRZCX1G3Xkg5xQl3gWK3luMsh/Lvw?=
 =?us-ascii?Q?ANwOT+oyVMbofugoT1XUgUqwDPu76pjkY1t9YYgHlpKl0mfISQpB4FNJh7zU?=
 =?us-ascii?Q?Uj81DS6DYNevdoV6Adzi6LkzVIJKD41XW/AxdYh/xVBmxNxNQtnaFrUq0Dxr?=
 =?us-ascii?Q?NYrU8xIv4+v2jPbj6Dtj6pxJN5KAF8HKOI0oHSw2uJ6/caBroNDhwQhdCdcI?=
 =?us-ascii?Q?3sNLIOI6O6/A/bfhbH2QnTCC2V/YXynIp+7EBeYzn1f0eDpxjPLxvzdg2HTI?=
 =?us-ascii?Q?I1Il4j5/9y/+s4xO62IQYJjRKsM7ECRFl/fewc3dbvKEZAex2IqgpNXUnPfU?=
 =?us-ascii?Q?7idUH3ujUz2FaA21PlWVfF2LToYV+zI2fDZvAfQdj8SYfzHqihQwfpcDcDyP?=
 =?us-ascii?Q?BRm7QnRsFvcMZ2hVf/DwJknsJbBB04atLnnHJT7yVX9YTT8lAPGpL8t6wJk7?=
 =?us-ascii?Q?3va+A5QqFtUBCe47c/QqpwWBZ11Tj59ezWWZasOZRnUN3tBnCNfPrVe19zPz?=
 =?us-ascii?Q?6BbOwESsHdRDvCgXdO1jw/l3yO7vj/xZItI/3rV1WQV2KXnK+u1+mFjaPAG7?=
 =?us-ascii?Q?pItHSgfvchrBHyr6YHXa7eF0G917asaqvGb5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:31:28.0906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be600540-e4d1-48a2-a43b-08ddbff92141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF
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

From: Clayton King <clayton.king@amd.com>

[WHY]

Free memory to avoid memory leak

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Clayton King <clayton.king@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 724484573a2a..b59703467128 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1606,7 +1606,7 @@ struct clk_mgr_internal *dcn401_clk_mgr_construct(
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
 	if (!clk_mgr->base.bw_params) {
 		BREAK_TO_DEBUGGER();
-		kfree(clk_mgr);
+		kfree(clk_mgr401);
 		return NULL;
 	}
 
@@ -1617,6 +1617,7 @@ struct clk_mgr_internal *dcn401_clk_mgr_construct(
 	if (!clk_mgr->wm_range_table) {
 		BREAK_TO_DEBUGGER();
 		kfree(clk_mgr->base.bw_params);
+		kfree(clk_mgr401);
 		return NULL;
 	}
 
-- 
2.43.0

