Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2563DC52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE1A10E712;
	Wed, 21 Aug 2024 22:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z0zlfFUk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83B210E70F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YopKy7zJvVMFvPAEEk4gv+T097L7XpGTCIJXx5eO9fvpQdgQv2DA41q+O+FVG7RkHrWvRH5TaOKVz5f6O//wmifiLn3iXdKTKEQKN53JlNPKgTQCpVltK76/KwQWelKSF+AliHiqo3PwMkkXby065On8QNZheqaDSPUKnaiHkuq5NbjgPuQSD5/HxLvThc0EgEuZ+/v1o6BzCkQOyqPY6B2YPZM6nnRLysfUm84vXtVACCqxUd3SyyqkbOKaRZqllV5yQduxGoj/SFrDUt6wsKfqPtYcXuwiu7BqonnqgOv8IO618vKsbXKTtbOqyj2JBmhUNPpjYlyHRFmfJYdWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vM0vkzBcfKJyafhojxpZpmMFjRhnmG//nByGJ7m+AsU=;
 b=ybSO3wGZOZnMSxfkAwTQy67yzn/6UkL13+cv5DDJVHlLf8TQX9VuGRlGdPDoJc7u3uaf1xXoP+rdVqWfA+mH29oeq8k0EiBh1jeLd5ct2R1TNME/XGudAHd44ip3AItFOSoidq4prsI3KD92pSCv3d1+GMj0zzNoycD8NRu0FimZ9L85/oe8HADV5sd5MbMqhJVhxqhUmzuX9cOZP56R25ymgqUGdXAADR0aS3yjIyC2TR/srcV8nWI2WTcVP07nftB78v/tGQAXR0mp/sAhsRcMNlPn8ay+utVinSwjy7kWYagf6vJFSYNCs2sJoRJHOBHB4Ug9HbHURRuCcmWkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM0vkzBcfKJyafhojxpZpmMFjRhnmG//nByGJ7m+AsU=;
 b=Z0zlfFUk64WZZon2Gghp2WZ+Q/LYdcArrXWyTvznlUg0GqPFCzyNemj/6YW5mOiZlELqTdX5pt+1Owxfd9q/M9kr7Qjd36YTriEuddeZJywGpsFiwCb/26N+mOm9wJX9FE86FAw1PR86vgON07Y2n658DHqXjtav5/7nwvwelhw=
Received: from BN9PR03CA0450.namprd03.prod.outlook.com (2603:10b6:408:113::35)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 22:04:57 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::9e) by BN9PR03CA0450.outlook.office365.com
 (2603:10b6:408:113::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:56 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:52 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: [PATCH 14/16] drm/amd/display: add sharpness support for windowed
 YUV420 video
Date: Wed, 21 Aug 2024 18:01:56 -0400
Message-ID: <20240821220156.1498549-15-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 03849628-29ea-4cd6-f9fb-08dcc22d4aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bL7wFhI/GV8vRE+fOhr/LZNsoiyo90uirrNU5JZr1+qbjd+FWTiZna+iru7K?=
 =?us-ascii?Q?oyGP99T7BPchjJ8m+1yahdRiiHh66TUqVhWblPtHfRhZdv/yz4xNgHvLKym8?=
 =?us-ascii?Q?eclqu0ysA0A+ZWLJoyJjveZ1zdFFdKZew+gqqzWR7hb70Zr181vdywpmuWdx?=
 =?us-ascii?Q?rgyy1m1T8VYwrvlEm491sGQmtGvr8gKii1MeHqRAJWLH2Chw/GsFEcbdw31C?=
 =?us-ascii?Q?f9TeGto1l34OuaD++8usyhWuglEBzzRmrjPBJBA0WnQzmn3uHj6qIbrE1Nf5?=
 =?us-ascii?Q?YKT2somDGL/wFeaC8Nsyuh9PVX02fAQFFDPZD6ocIr+i4icVzOZQ0vTyqtbF?=
 =?us-ascii?Q?eV9pSORgEy68TlA+YCalPMh3X9kSoG820yqHmH51TaMZrNuThXfp1+0r48Lu?=
 =?us-ascii?Q?Z8MngZGqOKQWzzqIqees3yutfIavuJZUQdSC/MI8XQUYNPfCDCAoN/CaYv8o?=
 =?us-ascii?Q?TUnZwFOWNQ1JTbwxKSU5oE9heY5wX+o0Gg3lNM/1IDzzjahyBUb/PFkHTg3c?=
 =?us-ascii?Q?E14Ez/SjOHApGMYfvhXHD0goCVMtSLCSUweBo/K/xu3U8gIS+Eu2V074AEu8?=
 =?us-ascii?Q?rlyeMV8jPEF7lKY5uu9zeyLCC9MWCZ6o94wUhtIOzkO0hLeNQ+y9fwQkhPCs?=
 =?us-ascii?Q?whpXB3fZhxetZDG9p1bXDjNOTbRe7CDXorPTqVLqdU8PxBdVRq8877izbqck?=
 =?us-ascii?Q?Zqheu80DUHXXCuv2qrUj6JTSSRQruHOU27nPHZEhxHXQe2+fWhJE9mZLtRQh?=
 =?us-ascii?Q?x8fmSlOPyx4TCibLMtBSbvJBsjCn6kzcXSqLT7yK4rwWm4M6C6W6xRj3+IvM?=
 =?us-ascii?Q?g+tEt76qVoLslxebiMcdS4bPFboseyUHU2K/rphF7w1f06yicu53geIDQAco?=
 =?us-ascii?Q?cbrb08DDIzBC5xQctwp57x8tpQZpyFg4X+bKksBhkQ3hP3AKp91LozP7+ki8?=
 =?us-ascii?Q?pubnABE/tiaaQsjQtzEt9Pe7qFBZJkohL6eJtNn3Krc4fC47ptUrUz0c+QmH?=
 =?us-ascii?Q?jl+cdAO1LFq8FwaYV5XPRhAW5LAKbMEdHnDJU2xvqL74zoiz1zgbnSg1NheR?=
 =?us-ascii?Q?817/qNYg1zzmvihJlInHdvl77bGKgQkIp/l3StjDq/mWJaY2ydGtfMpASCLe?=
 =?us-ascii?Q?L6QvrGhkyo+cCdyVHrKnjFm7DKOAiRWC2SF7yKap3OEwM/t9ysCJylxnUOvT?=
 =?us-ascii?Q?ljZBWBaZd0qgNWtm8Kd7PhdxKQUr9WSkCzoAR5bDh+lSPc6uxe/GkBostd3Y?=
 =?us-ascii?Q?0XLKW9SmO56bnNInFDNcpliSUPG7pN6xsl9JebDDyGwAIjHLu6IjvDbenUZS?=
 =?us-ascii?Q?wRzYLf3TG74rPlchngVWMYc8REPynNaCS5B1dAxBYa91QRVHw0R07ftiEzc2?=
 =?us-ascii?Q?PJeEonUwSgl2X5lhwXwl6WncSDgyRXnwyJppjSvMJdHhEFDo+fjJAFoL8YCF?=
 =?us-ascii?Q?kMNbr7xzf9YJgJf1hDgQsqySF/v+lDnK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:56.5216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03849628-29ea-4cd6-f9fb-08dcc22d4aea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
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
Previous only applied sharpness for fullscreen YUV420 video.

[How]
Remove fullscrene restriction and apply sharpness for windowed
 YUV420 video as well.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 059d144bab85..b6d1cfc494fc 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -813,14 +813,6 @@ static bool enable_easf(struct spl_in *spl_in, struct spl_scratch *spl_scratch)
 	return skip_easf;
 }
 
-/* Check if video is in fullscreen mode */
-static bool spl_is_video_fullscreen(struct spl_in *spl_in)
-{
-	if (spl_is_yuv420(spl_in->basic_in.format) && spl_in->is_fullscreen)
-		return true;
-	return false;
-}
-
 static bool spl_get_isharp_en(struct spl_in *spl_in,
 	struct spl_scratch *spl_scratch)
 {
@@ -828,7 +820,6 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 	int vratio = 0;
 	int hratio = 0;
 	struct spl_taps taps = spl_scratch->scl_data.taps;
-	bool fullscreen = spl_is_video_fullscreen(spl_in);
 
 	/* Return if adaptive sharpness is disabled */
 	if (spl_in->adaptive_sharpness.enable == false)
@@ -845,10 +836,8 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 
 	/*
 	 * Apply sharpness to all RGB surfaces and to
-	 *  NV12/P010 surfaces if in fullscreen
+	 *  NV12/P010 surfaces
 	 */
-	if (spl_is_yuv420(spl_in->basic_in.format) && !fullscreen)
-		return enable_isharp;
 
 	/*
 	 * Apply sharpness if supports horizontal taps 4,6 AND
-- 
2.34.1

