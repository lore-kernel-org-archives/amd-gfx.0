Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABF1E77198
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A27910EB0A;
	Tue,  7 Jan 2025 15:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r4ahDl9U";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D929910EB0A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8tMFBZnA73vX11muGpPVM0OmBUj5SjF3KN5HEr+CqsWnFtul1e60E7VOvq51mRqCoAukmMB5LbbqvrpNA9q+8V1tIv0SMBgNclEQbpu/ZrG76Imy6F6FUbQqLEfhIguVSUDLP7ASREoorFy+cjKVKOPRYQCigECEFwIzjNUhA0htlaig7VMUHrA8ct6qHqy7/1U01/PGbISjP9jG07FDFSqgNCvWerrumZvKSwkoNU3BmRWmwoTIz13FcoyPq+zdQDSSc7VK+NFB1kEqM30ZlYDPRd5DxoTAy2+x0U9n0hMfsUbB1F/DCGAomjKmAGGIfBF0dE7A4lXHd/LPSEd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEC3tqzyirgVb77tgIoDsvvrKVJWTX2xwhZzcjVpeYo=;
 b=uvhVjhv4oJ8PPvq3OLDb9PeDHXTsnzAcpidIpE1YHfTR9tH63T/OZz6PKjguybWhVav6+nwJl47Ao434wCHD+3LHaaAKDvSafsMto9p2U/jFofrq5bVmKFbS1PhnQrv4NXx1yDhVCAHGZkeHdJE7TMWJ7BTJsw4CtcUKR7hWIdZRDx7Bphtp/9gFi/DU9p9Lt0G/MsMNGnoJs8MZtHh4Ha9MGD0Bp3qGmFG6NuQaqT22+6LrB6Cg7calVUQoeFMBMb+r7tC9l3arqBjaPk4k1GPUzgxiI2Mka5gi7ioIP4emzplCATOTDqz32NS5ZFUH+Uc6FqHfIHmplOvdv6RKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEC3tqzyirgVb77tgIoDsvvrKVJWTX2xwhZzcjVpeYo=;
 b=r4ahDl9USk44PWyZDAfM01ADvP74dE/K7oSB7jwuMrLy5zDemUrrbje6WUh33wqajCikBY4ykbXnh+2r1HGyTEieyfNTgdgTETXXVLBGA/EdJicm+Dx/slwcX9IaW5XFInXUdLksbCleU+nfpBtetZxGOGIsEL6bYsvyoTSV4ok=
Received: from MN2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:208:fc::21)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 15:30:37 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::41) by MN2PR02CA0008.outlook.office365.com
 (2603:10b6:208:fc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 15:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:36 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:33 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Dennis Chan
 <dennis.chan@amd.com>, Allen Li <allen.li@amd.com>
Subject: [PATCH 19/24] drm/amd/display: Revised for Replay Pseudo vblank
 control
Date: Tue, 7 Jan 2025 23:28:50 +0800
Message-ID: <20250107152855.2953302-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c6c70b-6728-4190-f9d8-08dd2f303c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K+ZMrqj5ImRe/FotzORok4jj5oXs5yqRL/wnD2hxK2YqKm5ISCjxxV6ekrgl?=
 =?us-ascii?Q?X5/NAuuZRi0T83aP7RiDpwROC3/7fGltCvigcQU9YOQ87S5xeTsWWwwVY7Pm?=
 =?us-ascii?Q?Io72R0dCaVpfUxIdBcK58+zfSY5hko+eYtEfuqVIsS7nlXjIGPnebmvE7G0e?=
 =?us-ascii?Q?FhubMhhCUvGlwrJ3AicY5MK68H5nzxtB47ewLi+d3gYp8bXJMbIFa6XY1JoO?=
 =?us-ascii?Q?4E//0qdmVfRVP7Q0I9r/OF3coV6Ib0fnnFsmSNUbNUZaH7rBl/QElfLy7o7J?=
 =?us-ascii?Q?aHx5Befupq5iiQDdwcMdRoLkS0CRD0/DkyY9+jQcgC9XYgeji8U2mziXo6B4?=
 =?us-ascii?Q?MlPo8we+U6njKeqWNuUUCFm5ptMmwKKfDe4R3uEq4Vo8qZau7sOPltHsNXkF?=
 =?us-ascii?Q?MgTPynggWNAT/OWtc+pfb3k1jkewBDvTaJOy54/PQj7xIRwNSdvY7LdQETT1?=
 =?us-ascii?Q?QoxCLjUf6/rj0i/nWrL29PZstV5eRBIV3viQMUlTx7068DywKJIA3tXwW+kF?=
 =?us-ascii?Q?+zGBzVoxNsI0H/cVjT8n6KZ47/je1DS5nx+6BH9AmTxn2MBLKXmtfMM2pELO?=
 =?us-ascii?Q?WJwc3xGP7eTzk9vlL9Iq8HBAN0ZdulcemBL/I2oTlx9EYI1b/QsZyw7BBmRj?=
 =?us-ascii?Q?8jqbBAlUHUoYQP6LbpCbkkAywSS5ekcW/4/U7pG1xf68FKGuHz8ea8iGEMHY?=
 =?us-ascii?Q?huENc+gzsEOESeOUxEMwBXmNwll1Gk3wx7f3AWEiz3a1gWrv+y+FAQCoqAG4?=
 =?us-ascii?Q?nywdSm6LLPgZCAtycY+nQUZZ499kR3bO/tMBQJ33Xxklq8W7p37ss8UJD6kq?=
 =?us-ascii?Q?2kELGIupvoHlHWyau0UEJfFBg24Sqr41p/NRiTsQB0bZKlPB50ptCfonGyS6?=
 =?us-ascii?Q?bL1gwD4mYVs9h3mCA4RFTarJaTgF9BfnjFG6PCCZ6AFaWOU3wZ+GZIuJP8Oh?=
 =?us-ascii?Q?mG5qoL4XXMucD29vzijuTSqUD58adZnljGBnDZh3kIvrzlx49v6Xe7MKEq06?=
 =?us-ascii?Q?Nb8VRsTISN72tm9lzU6ZBxT4tOt0Pe4CbItwKtOkr1Bwh/XG2avtnOQ24qrU?=
 =?us-ascii?Q?wl6YJXNfZ9JS04oijDwfaoNYJ/Rlpi7j+uAeQCrIn/ie0ZwV/tTQ3DLMXuXs?=
 =?us-ascii?Q?QYDE2NHNPrLKN+qPwKagc+couqXi8zYABcyMqUAlqAxe3j2wBBEHgFn+01iz?=
 =?us-ascii?Q?et7DMMzp0wqmwV5OEgxNprBZ5lvic2rtkegGuIBaVNjTzP8Zq+VvpSRayUmj?=
 =?us-ascii?Q?j/JxZMr+lR6YM0n09ofLNnTQw/pjaFjrxgEYOeP8lt/TexxI0U6hMzaFlvRj?=
 =?us-ascii?Q?OVJTs4BpuHg/YjiyJ2SyTtRDDY4zxF8aHAx8pucDmqipbsfnlzA1x+IPB7zT?=
 =?us-ascii?Q?3Of/k7sE6Pwc1ydhLgDfsMwOpxd0oO/Txk3wthJQg8pNFA5jjqLDiWBqlpUc?=
 =?us-ascii?Q?eyiUczg7q4xwgAVDPNp0jcOJ//GrS1a4oLW1suYLT/9VMjEe8sUwRbrCFpzJ?=
 =?us-ascii?Q?6i2tlp2/2PCcCfk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:37.1876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c6c70b-6728-4190-f9d8-08dd2f303c43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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

From: Dennis Chan <dennis.chan@amd.com>

[why & how]
Revised Replay Full screen video Pseudo vblank control.

Reviewed-by: Allen Li <allen.li@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 4 ++--
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 4 ++--
 drivers/gpu/drm/amd/display/modules/power/power_helpers.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index d7242dd83def..0c2aa91f0a11 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1145,8 +1145,8 @@ struct replay_settings {
 	uint32_t defer_update_coasting_vtotal_table[PR_COASTING_TYPE_NUM];
 	/* Maximum link off frame count */
 	uint32_t link_off_frame_count;
-	/* Replay pseudo vtotal for abm + ips on full screen video which can improve ips residency */
-	uint16_t abm_with_ips_on_full_screen_video_pseudo_vtotal;
+	/* Replay pseudo vtotal for low refresh rate*/
+	uint16_t low_rr_full_screen_video_pseudo_vtotal;
 	/* Replay last pseudo vtotal set to DMUB */
 	uint16_t last_pseudo_vtotal;
 	/* Replay desync error */
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index f4b86a63f25d..29ccd3532d13 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -996,9 +996,9 @@ void set_replay_coasting_vtotal(struct dc_link *link,
 	link->replay_settings.coasting_vtotal_table[type] = vtotal;
 }
 
-void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal)
+void set_replay_low_rr_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal)
 {
-	link->replay_settings.abm_with_ips_on_full_screen_video_pseudo_vtotal = vtotal;
+	link->replay_settings.low_rr_full_screen_video_pseudo_vtotal = vtotal;
 }
 
 void calculate_replay_link_off_frame_count(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 94ade0ef18a3..758a8aa31fbe 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -62,7 +62,7 @@ void set_replay_defer_update_coasting_vtotal(struct dc_link *link,
 	uint32_t vtotal);
 void update_replay_coasting_vtotal_from_defer(struct dc_link *link,
 	enum replay_coasting_vtotal_type type);
-void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
+void set_replay_low_rr_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
 void calculate_replay_link_off_frame_count(struct dc_link *link,
 	uint16_t vtotal, uint16_t htotal);
 
-- 
2.34.1

