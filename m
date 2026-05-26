Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC03CD5BD1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D8510E4E7;
	Tue, 26 May 2026 07:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j0LpHCBp";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61EA10E4E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4cfilZohdSfjjH27LhZloGecit/EpUgU0dX3Ra2iRElDn1wtdMI/2oP1zfioU4TiQGLSQ4wmM9Mnd/gioNKuYfyo/0c74MMjTU7RSsISAhgC+BfKlT/ORy5QjysvDMpiocrgi4U/tzh67OqtTcvJqC7+62m6Bw3RyUPqHZSguXKX87wfPKYHScoMAbqmzeR9SDFVT88Aw2KShi3V9k0dUEcHq6UhQLuJ4Ew+UjcsZTNP28oyDVRi2RGJDiJqdKwkCk5lzwH1BOwBbuTaZMi1srBskg7+nbps9CGvA5Ir0vAvkaUdVTTcSn2gjSz1Fe1f1LIW+0fkY3MNagemfSqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS6jORhziz+yFhlPO9Mm6LkdFoQav821aLKRUMCTlwg=;
 b=INEd+Ds3l2VWcPqQz00PVVI/Fc4KQ13m/WzP6lc0deCyrJna41LR0p0a594Xs+HzhO48flRfRbnzW5lPP1yZD7VcfgstotKZg26XDByewEtkRTea9OXZkfy2wBtbQ3P+sMmulifc7KJY88crWhuRKJJAaGT6SDsTeEy5qBSSNiziWFViDzzMWqK8Zm+XzkGMrdm4Dnl0plEUzTAVYPH75clfrKyBCVlhNGmXUb9fi1C1qvUEAx+hV2dfFCu5Ct+wZN9wS+bjKVWgbv7TXDfRBrgkCHAgM2zqO26BDBn/90lKe+O58XWWxQ2jChNaT0OHr2SGLF1xKxT7ZQMLHWpB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS6jORhziz+yFhlPO9Mm6LkdFoQav821aLKRUMCTlwg=;
 b=j0LpHCBpXCbdyqJ77GgTJ54MIB7UIu64Klv+kDa3d5fWBKMOhLrNpZb0e/sTfy9TLtEGb233S8V9BqIyRm0fqqwA45pbBWf3Q9X8uwTwu1w0dAc1GNIa/Z8uGhRdUH/U3IFGQmGpEWSCzdFQ1X7dc6sLwfqAV8UjBfOgbF7gICw=
Received: from PH8PR02CA0030.namprd02.prod.outlook.com (2603:10b6:510:2da::34)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:16:16 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::88) by PH8PR02CA0030.outlook.office365.com
 (2603:10b6:510:2da::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:16:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:16:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 00:16:13 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:16:04 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 13/41] drm/amd/display: Avoid DPMS-on for phantom stream
Date: Tue, 26 May 2026 15:01:36 +0800
Message-ID: <20260526071413.2181251-14-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4989b7cb-1837-4699-1e98-08debaf6ac8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 8HBsbq1MMQxmLYn1sz1h2YX9gXEkfDlXhopD+wfRTYQg/JRTa3XG1NWqnGo/aivAQ1WqIcj8dzc9eGWQvSi/JdKlVY8HaOUMihjx57UPkM8RBC/jaY/LkAUY5k0E2RWnstW7Ab4YjJW/8Z7wSu2RK7cRQWQlEXFn1szvEC9eBbVmNWe93PxOnoj+gIuHXxpCp1TIhSTnTdf0fDff3LCu99vYh9MFOgiFw8rKGcprTjM75Mz2dEKKUxI1uFQkVGihv+g/tM90w8qkGmnBn+gvi/bPEQjkf+6J+08/eCQwOkeWYy8EdHNzqnRZs3ne9o1z3xj2hWOQclr2nPPVmprt+bc3ZNAVwNnReVboshelGgS5FJPHch89R/GzakJvD27dDoqM6d8bUEYZ/W72C//3nDogQy00oA7C+GPUv4uzovjdkTxP51ztTUGX0njQNgkWM6QFougi3n1kbyYJnytu9aNnyXyLEnwgFj03UzyUo2rNuMKj5qL1ha0oIoZKh/4iXmSirgI9k/OzV6iKf0i+G4k4/WvY/XnyPbJ+fedJrsVoF+vyRrzqGKP/UBLMOdwol//qQ8x/vqY3xPZZlemoi/ylZDqhbztsohpwmdcCmVRk5SNU1W/4r1qVf2RhM+QqK8G77m/VyFuZmunmhwXF9MGD0/+d7CT8Bz0kdo2QHTroAnkQuo5bspg0zDW9Ba0sTq2wHnrOd9PZloQwLlhbT+Pe3K7p8OlVAmVc58hjdG0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HTwW/Dj5o5x0v2uthVKgi9xK8WjoMfX5ZCXTv5mESEkRn1WaFfTXoMLXA5GTrHEL0FV9pgdKZoKJXUD6TH+aSlhy6Qkv+6wkI7eBZt8+sTppgA1Q8MbIPPoyf7/XVx6MVqwnyjlUAJnusc7o7PJJHeLfwp6rIws92E2YCqTXszQ3LMqgPEN9QtTGNOjRAN4+Pm3v8ikjp1PTBxvlzOJqssnfzNTd4617qOkq/GHDGva/6Mk93oUu8vb3XfZDAbtETs5zT/A0c0p//cX0Q1BtgF7ZDQUmWpe6QErv3QPEc+iKLTBSsrt/d3/nB9eAKGw8G3ydlHDMNQlV5mrE2yevMf0nCLyk58a1PcEc2AlqJyhrOgEv6BE/kewDFYuSTkAIO8w6jTC1X1PAcB0GJALquvtTDCZ/sIcm5C3q4RRMXD+Q2SJdot3FCC8rVMRIZnvU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:16:15.2569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4989b7cb-1837-4699-1e98-08debaf6ac8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why & How]
Calling dc_update_planes_and_stream separately for stream and its
phantom stream causes a NULL pointer dereference, since the phantom is
destroyed on the first call.

Skip the call for phantom streams.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index ae6ed3a52d53..d3172dbdcdf0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -145,6 +145,8 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	// Set DPMS on with stream update
 	// Cache all streams on current link since dc_update_planes_and_stream might kill current_state
 	for (i = 0; i < MAX_PIPES; i++) {
+		if (state->streams[i] && state->streams[i]->is_phantom)
+			continue;
 		if (state->streams[i] && state->streams[i]->link && state->streams[i]->link == link)
 			streams_on_link[num_streams_on_link++] = state->streams[i];
 	}
-- 
2.43.0

