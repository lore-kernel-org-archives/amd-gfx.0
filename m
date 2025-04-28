Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE97DC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A2010E569;
	Mon, 28 Apr 2025 13:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kPvqCn/x";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE57D10E569
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TadmcFT660k8ZGI3qxW5KWCsZvdmYEFkss9B3TL0/mtQBG+hr+I/j/I7mQy6+NE8RcXUoyo8ueay+F6yASly73MI5nEl/QFzOGQK43tnD9+MOIJVoIFMfl3OY9hxMiNx574Fs9H9qMFyXmQTKu7MjmV7LxjQif+Yh525amatl37cTLBQKB8bKxQ05dHN/7+17YWoT5RfD8Q+P5MJut1zpRcoGkHit5/2OA97K5RxRQV+aJ/R+bCdI6JeKZnGOHKoCGPLNGhrE/rGfe7gUVzVuJTKxAA4pJjaGJJGiasgaZD84Gz0xp7OP2r33lRzIO6jTr06hSGdbFp9LZHp/Dl1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AbduObUdbCGWvoNOhYuLAEsWyqzI25IFpRpgK2FZJ8=;
 b=Ehn7b48Y1lfECvdWg8BpnwTEz7YxPgYyAJXJ0BNKZqPl3Fn1Vuu9xCCAG4/OEZKQuYxqbmM1GrTrQd6+6ihVc/N0mPLCSjqk9nid4w9rNh7YOkKMx68o4baskNfFq5SexkS4T7MwAJhzzcSRXrOiNUPCHndifE6IGG9alX7w2ZjWMQUPcsqf/KjZNMpvIbDaj4txUxv7ahchaoy30EhltjpKkYgdKxQ/n/XPQwTtKymbZiET66IbkpzwGyJlwH0xzCxA07mwTvwKKajwekeFhNpyfnpxxC5uYx/On6N3l+NHQZz8quG78qYkLTDoZfJI0j3hJY9vnJVU2F+CNQL6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AbduObUdbCGWvoNOhYuLAEsWyqzI25IFpRpgK2FZJ8=;
 b=kPvqCn/xIqxZcyJzh1bw4egOpXfNCJb3me316yHSeA5LwEDENEBUNRUu7OVopOAHU/kaGeHx0kf+quaDHaFBRfdZnFxNuLxjGLh2lxbD3RLcTHYO6tk8wE4wFpUmgdlag+4sAx5YR3GXfUM4v/zcdRme0oSL5WsYMC0YAT5dSdo=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 13:56:49 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::f3) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 13:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:48 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:45 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Kevin Gao
 <kgao1003@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 16/28] drm/amd/display: Add skip rIOMMU dc config option
Date: Mon, 28 Apr 2025 21:50:46 +0800
Message-ID: <20250428135514.20775-17-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1c3e6b-2f9e-4b76-eefb-08dd865c8571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DmWvTVzfcWKWXHy8v5aCtloVqWqKy85omwh6VeD6ygnoWfrsUGjCdsGA6QG4?=
 =?us-ascii?Q?PoZIqQG+E+hhWnN90dbdLmMFUEKgUmJ9ITTlaXPHbrYtOVn9w0/ufN+DCXEW?=
 =?us-ascii?Q?zWpyYKlxfGn6MMQzE1hj5s0J3FQFuS/+BXUk2LszxE+5a3RXphoIEbH4UhDt?=
 =?us-ascii?Q?2tIEjdpGvga+FXWAUkgHVl9OcLkvbqErefwUWULbxaWmSiFRh1CqXDLaU/fW?=
 =?us-ascii?Q?6QbZkecGV2Tu4OMWcemroRuGvlTvUdk7BbBrhJyr0S9zyWSVXE23Ne0XdBU7?=
 =?us-ascii?Q?qZV/pN7CLKkN9RdFit/PRKy1q2m/hyjEMEQTPw5Sq/yidCewW2JQWSoKlaGp?=
 =?us-ascii?Q?R62CP81xf/fj2ZlMqMv4Wq0/x79ksfsOCk2Y7UOEZcwgpN0H2D+eBHhbxuZZ?=
 =?us-ascii?Q?urzaZxA4zMYrckS6wFSYLNMRZRULMUO/VuS5a8A7Kmg0gX0Sd9Bb3/XWd2DE?=
 =?us-ascii?Q?erECPKb4lbhi3I1fe1KlPGIzf27ByWW5PNnN48KWidC0M0VS3UGOETvnQ7aQ?=
 =?us-ascii?Q?vciAFP7vemK5Q91ksF+kgAeRIpehFvLJWd1PBbtFMVjORZ6239hHrt67l3mT?=
 =?us-ascii?Q?bXE4bEq+xwnNzQPpsS3zs+4/ngFQzjrJVRXsaJ+08hc9IUrdSjaCbKuExu2O?=
 =?us-ascii?Q?rKZ+W4NJ0Uy+6Dmj3tu5AHdgRUQxxwKPTJV06Qh21WNUE3NJqSx4GyVkunL0?=
 =?us-ascii?Q?UbENwTJcmH7X5fAK87om1vJ21Zhi56kK6hWA8aWHqhaskTjxRis16tCtlFJg?=
 =?us-ascii?Q?Flm12vUwm3rnfvCfJXNKHDLP8FPuf8KA9fU/mnpjZNfzJ3sIkTZwVyVeBcft?=
 =?us-ascii?Q?mzzXOROy73km5baJgSUGfJ4AttJrbbh/EcAoiINPEH5h/Wdln4BFT9ANkdob?=
 =?us-ascii?Q?rFXoPfdfPxcTuegLpuph3Pgfd/PpLfFm2ZvMbhXoTjvDBTjvoa7fYRmn5Yh6?=
 =?us-ascii?Q?SUt0dvXfVmpyJsy1DKnPcEgJ82/ZH64xYd16eNlTiUVHaymgRvhJX9kApQXd?=
 =?us-ascii?Q?oIdk6w3M9FhAb1QkD4iIfARlmOXixoWK/dc07Xt9MVnFEzA8jDlsUqPU9XDR?=
 =?us-ascii?Q?vJzsC51fUYv6nHjk6ajYrbv3H2OfKQwb6pYdT+VEX1FZzns3WoLBSJipnXHW?=
 =?us-ascii?Q?+kc1WNeqE9gytN+ep3XyevfqG+b5y4v3WOiCg9o3yRNDHz/LekJ1OajYuN7/?=
 =?us-ascii?Q?4v9wsRb53vw9teUmmAV8U6jWpPrb7NLXkkXXyMa8IvhebIcgfpG3GZEkFBnU?=
 =?us-ascii?Q?G3Z3zxfHHtZ0Zya2/rZa0eNSi5Zafd7R2dpmJI/VkFq4jiOwUsb1TnE9eLGo?=
 =?us-ascii?Q?R19OWPYjt9aizNQJWEP3i2cNLliU03CE9zNca2tAxGQOmiJAnXvKJDiFxGxb?=
 =?us-ascii?Q?y9lWjjnz6MHU34ZEjT7PrytE7j13/taGHuiVQR2rg2vPXc1sLLAVmtTM4MpE?=
 =?us-ascii?Q?EHL12dazYkHMY/IvesZHt5df4B1+3FyAkicjFELZH5jvMLw4IPqYLFbb3gNT?=
 =?us-ascii?Q?w8ye48+b/RCLAz+vp02amg1nonUMiWw8c3wR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:49.0005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1c3e6b-2f9e-4b76-eefb-08dd865c8571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
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

From: Kevin Gao <kgao1003@amd.com>

[Why]
Need option to skip rIOMMU calls for dcn21.

[How]
Added rIOMMU dc config option and check for whether to skip
rIOMMU calls.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Kevin Gao <kgao1003@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                        | 1 +
 drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a5cbbee02380..96020bbb1797 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -448,6 +448,7 @@ struct dc_config {
 	bool enable_windowed_mpo_odm;
 	bool forceHBR2CP2520; // Used for switching between test patterns TPS4 and CP2520
 	uint32_t allow_edp_hotplug_detection;
+	bool skip_riommu_prefetch_wa;
 	bool clamp_min_dcfclk;
 	uint64_t vblank_alignment_dto_params;
 	uint8_t  vblank_alignment_max_frame_time_diff;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
index 2546224b326a..e4496ad203b2 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
@@ -132,9 +132,9 @@ int hubbub21_init_dchub(struct hubbub *hubbub,
 		// Init VMID 0 based on PA config
 		dcn20_vmid_setup(&hubbub1->vmid[0], &phys_config);
 	}
-
-	dcn21_dchvm_init(hubbub);
-
+	if (!hubbub1->base.ctx->dc->config.skip_riommu_prefetch_wa) {
+		dcn21_dchvm_init(hubbub);
+	}
 	return hubbub1->num_vmid;
 }
 
-- 
2.43.0

