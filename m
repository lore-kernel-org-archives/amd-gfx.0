Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A245CEE345
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B03FA10E7EA;
	Wed,  9 Oct 2024 19:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rArQkmNH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B8110E7E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQfa/J4Mzna/jvNhVp2m9vfNnVoEAT31m3tVmRoZGNlAw6BIsrAxeF00bcvOqOn1waNtbvW8kh3z7lx2IipcwDxCAJQupgsBrOxmfaEQMhMPNaHyegNxEPoD3+6JV2QhafR+II4ZQjp2zVIeOmCOVfrPjugqxQZaGe5nkK/5Eizs29M8/AJIuQhkFqi0XvlJ8b3MV0gctICgPfgRV9Gv15nS8k5nfM8/YBnluxiP73iQw/alpdlUg/CBYYK9OPzHLq0COIw1MhimG8jKoJAIpngp9FfMOOT5i/C9NH1yibE4t+h8P0HhKbviTjdOohz68KpBHhFvMc7Y5yqQzLLB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjn5AEvM1Wrj6AlzgdbBHMITGxndRYUbqC78d1suLxo=;
 b=XL4on/6+eGpROUkS54vYN04W6cA+c7jFQ6T17ZhswhFvPWvG9u7gcl/y2syL+gwNQyS83bUHRB26BQ2pTXBG7Wc5wkYLVGwlifkl+f6FTPA0lRtnjhTluD+jOo0g2p/WOwf2RyrjHttQ1gkpKv1WmgxjI72B83AQKhoYr5e2uOn+6H1xycHC1+7Vr+gGyLkOhbUblwNA+V6XueeVCUhoVqOIq/tI/Ap/AYG1GXmjBzF3oXxyWaAWzzfKbuv1yvElHuhwxdLcXq/medcDHXs9y/RUEnTxZlXbsmFGcTGbnE34i8iIw+3aQ542zkIduvZaldAN12TZX98bQKnfoMZDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjn5AEvM1Wrj6AlzgdbBHMITGxndRYUbqC78d1suLxo=;
 b=rArQkmNHGCYHTRFz6/HQmS9zAJdH78mAFL+9JLhXx9rkOp19z2Kfvi6ykqNCrd9JaXMYaW6x8aST+e0xHaPIyKu5VfwM5fT0pzXfl8XqKaHJImkpWsxuKKfrjuF0u8jJtDzagww7mYk3R2pKzVVV4Vz37IP0Vn0NxXad2oTdd4c=
Received: from BN0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:408:ec::15)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 19:26:08 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::e0) by BN0PR04CA0100.outlook.office365.com
 (2603:10b6:408:ec::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Wed, 9 Oct 2024 19:26:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:08 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:07 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 15/16] drm/amd/display: disable dynamic ODM when sharpness is
 enabled
Date: Wed, 9 Oct 2024 15:23:43 -0400
Message-ID: <20241009192344.650118-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: cdaa8864-805e-444a-d647-08dce8983a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EILAM7vEX1dKhdpAWt7KOVBjsRMi/hrAg06X+GQymsAF6dUBifGIRYkD+Xt2?=
 =?us-ascii?Q?cwcbWrf/ntnabdWaVnyulmY0oKNC+1xBuFulIeVGZVOSQKRRlqoh6mOOxJqf?=
 =?us-ascii?Q?8hApgO9mSL2k2KWUw3OyMCzc99CNVXA4PJcw+UbVNoPJT1ulGhsHW0MflSfC?=
 =?us-ascii?Q?EPqGC7swAeyO8j3d1NOr95GU/psSptIhK2vs2cxWbyUdruRpbR/jmgXNqbu/?=
 =?us-ascii?Q?/rHyW03RFH8I8zvgrG8HgoVIaxjdoo9MmHMUD1ODZ0JbLYrnz0vYQB7XYxnb?=
 =?us-ascii?Q?k+UoeosbXGXxPFPgQSbjR40XHRGwaib1X8ZeUHPk3j4wnMq5TVe0L2K0qbXe?=
 =?us-ascii?Q?FQcSKAl/slwIeGzmXoPGdNhGi+dPsy9Pnsujht9B5/qkdhkXC6LIJ3A0/BLU?=
 =?us-ascii?Q?iyvQinn5Ah4QGoImBhcP+Zok7YHfCzmt7rdW7HEq1n3m5DZ5o5YULPan9IkQ?=
 =?us-ascii?Q?ZZSYPkfFdR41+t5ljspCga/W7PTnMGc5hJMqWD1HJp6wQZvxJgzVcqFbhJvE?=
 =?us-ascii?Q?2x+UDC3g30jm/1BD3HIWtFFly+EQl7ojCS++AAOtHZSP4o5N4JPQZEP7j/r0?=
 =?us-ascii?Q?/qnwE0NoxBYXzmlStKJ4AZDiP35yzOBqVlql50Dj5mzPEuIEyM6N46nsWYcs?=
 =?us-ascii?Q?fPNYvvpPFQFFDu6CP7ucbh9WiRdyBQzKDgaopL5wXHqm84dkpCjpAuKitJxg?=
 =?us-ascii?Q?QaLhA00ntP/0k0pNx6YrjFeULuBxaQc/H9zeKxfWII/LG76X30ATuPgX+hiH?=
 =?us-ascii?Q?prJteKGXKNAIw2pm8M3g5snhfYQV/0XU+C0fvoYpkJMVjWpA+CDVSwkzk8sm?=
 =?us-ascii?Q?9hpqxN/rfUzrXHNb5MEI8YDsZtD/HhikyKvJOOD6am51xia/A8O4RM2tFqxo?=
 =?us-ascii?Q?fOibIhayeftqVzTVYvdgmkoxkXmUXUDYPFDyWKStfrV/g1bHZPrThmtT3g/b?=
 =?us-ascii?Q?r5nM4oRnI/z/zg39FZHjw/S8t1gcisn0B2BIYgEbgs7xKsbIjAWQZbVbc4VP?=
 =?us-ascii?Q?dhbJ41RuPVAFmnlleNyhv0ptBLB4r52a+n8yipTJdNXY7sy+S3oJzegB6DUw?=
 =?us-ascii?Q?7tYzpSWRGfIAe6LnVWrQ75IYYa71v7ltopMbSxcucyfRVHY6dm8KqS0DIG8b?=
 =?us-ascii?Q?xvlae94PfWpZINOnMA4UXRwH4Ht9lNm0Mp2TMaDgouxYWRiDtlCxTvz6oncf?=
 =?us-ascii?Q?dnN4pBwYxvoFuFVts/6HT15fUBAZTlN8lczlURyxnhnv26WEwplbUvhdCKwp?=
 =?us-ascii?Q?7H9N3q198kdrqFdpQVqN0ywjltzZL4Zw6xVhdrxjHpaR+KMAB7AHpoEgxQou?=
 =?us-ascii?Q?IbmRd1elHu9GYP5bf+8/oapeUAfKKO9zsgp/iT6JiQKoknVrYo4ijQvsHXGd?=
 =?us-ascii?Q?OlH+x/I4jPGZM9hbN+d5nlfiQP1a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:08.6194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaa8864-805e-444a-d647-08dce8983a13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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
Disable dynamic ODM when sharpness is enabled

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 7a01a956e4bb..d901b9f7bc6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -514,6 +514,7 @@ static void populate_dml21_stream_overrides_from_stream_state(
 		break;
 	}
 	if (!stream->ctx->dc->debug.enable_single_display_2to1_odm_policy ||
+			((stream->ctx->dc->debug.force_sharpness > 1) && stream->ctx->dc->config.use_spl) ||
 			stream->debug.force_odm_combine_segments > 0)
 		stream_desc->overrides.disable_dynamic_odm = true;
 	stream_desc->overrides.disable_subvp = stream->ctx->dc->debug.force_disable_subvp || stream->hw_cursor_req;
-- 
2.34.1

