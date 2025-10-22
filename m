Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EB6CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298DB10E6FA;
	Wed, 22 Oct 2025 07:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="phNlXRvy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE8610E6FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbYmq1PmVnItsCsB3intHxlI5ix55RSxDphPfJGdFpjq2r2tR9lBh+uTZyPs0G6Cx+IcZuqmJ9B2bP+hma8lwjf0St+A9hz+Q4S0NABc8OqOxUGFIWbWLBrHby6qF0+cpZB4YnE/cmjMngbMA3SOnU8j7pFcmpQiq2mZSz641hESv1GnAuqwajX93PgpldRarYsnGzpkrqoYyVlwG8VtrQWSIxt+5kuYxJdPYwWvW3ynIDNx75DcuS8vKy5Ao35wf2bt1ZSNNMbNNTkRTtsznE16TVtTtCr8z/3WkXu0xGfBjYEWoC4sSIThvLOBSNEkcp62lj5N3FDcbODQUfMpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLyPOxr8d4grpmordBokpvVxN15ehjX9tg3odEhW5ZI=;
 b=g4EqaofAK0UhVSB57RsAJmbdPqPnfxN7WSMUD2+9f70P2TgpEs37FbA22rp0k+NcTv+OuhIuMCImNuKcpViUYLMYnmyIzRj63SLZx2yoGV86S57TFPRb6bZOQw36VoLWuDzADiVVKipPq+edPgy8ojBXLqZvQomTqsuDMbFwL5OJwxzdYJz3zhD1aIL2ACMF5t4RKgdnMg0wYsWABHQVk9TshYkCwBXpxVvZAeu5ec4Zw8ee4biLP0IJYXJ9KnAeZotkeCaVP22CXgVh96R2KaN+c4p6Nh350pALlcPvr/mc3rZUqCaSkLvHHedSv+KUNmrccqK8XTn8vCpasyEAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLyPOxr8d4grpmordBokpvVxN15ehjX9tg3odEhW5ZI=;
 b=phNlXRvyKwAqSSfejCqS5ociphvedKm37oIDjzqAlL8+C/GxYRPXcRX1BfCd0SYqYZewjRo8/UytJoLNj69bRLQXW15zohlpN4hjTm99PeJ4Z57RQEcM6jxQ2jN9tEQs0dcyxV9Da8Xx0GkUqG1L2bvx1gcZTuC2V7b398KhYxQ=
Received: from DM6PR02CA0118.namprd02.prod.outlook.com (2603:10b6:5:1b4::20)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Wed, 22 Oct
 2025 07:34:09 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::e0) by DM6PR02CA0118.outlook.office365.com
 (2603:10b6:5:1b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:34:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:02 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Oct
 2025 02:34:02 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:33:59 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alvin
 Lee <alvin.lee2@amd.com>
Subject: [PATCH 04/20] drm/amd/display: Fix wrong index for DCN401 cursor
 offload
Date: Wed, 22 Oct 2025 15:30:16 +0800
Message-ID: <20251022073332.666119-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: f9daf87c-4df9-43d0-919b-08de113d637c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qwp9iTkMsP+4qR8Epdp9XqMQauub/9R2HdlfzRUzuSfajxVNup1jIy9I9WTM?=
 =?us-ascii?Q?91PBZMEZ7NOCkdtB6pGl0iQoo4RCb4fXi9wYg6szM9Cj7NKChkQYtwhbn5aC?=
 =?us-ascii?Q?2Wx+HYbAd9B69UpaEXRFVLPLM538p9ZPb4nKeByJCgNuSi+niH6+rKnrqhXw?=
 =?us-ascii?Q?msBoGyCjMC7cImy1e19DGyJkUGmMHh4fpkKfWj6p8OrK+O4criP/ZMT0vNH3?=
 =?us-ascii?Q?l9ogoR913gcL1VEaBk5yxkhZtWbHflyM4UBDFewFRIMQ4w921/3kVWToWRiN?=
 =?us-ascii?Q?wOJm0Z6ielLx8pDvu6SU8TKwCIwKT8Ku/xzIKkobeye9Bam27Rg3OrQONJ4u?=
 =?us-ascii?Q?u/N1jSwIYsOhZ1SmDIlIsJEJOXQJJ8E2Fa0Fc0Hx2Q2b8O3X15VImcZ6njbW?=
 =?us-ascii?Q?0N8BPTIKXvyG92sc2KwzllOIIUlufE2V00yljdTl8XXpmkx+Bqx8n+jtINA8?=
 =?us-ascii?Q?uCOnY0pkos8HxtqPAxBQHuXAItsjC1h88Fbwm8+n2Adr/9EaFO8q9cmwVH8b?=
 =?us-ascii?Q?bTm/aw/YJ5tmu2Q+fGaaCMlFMUSu+3D3XoQsQPql2bsPYLf2/MCtHLe71a6k?=
 =?us-ascii?Q?pgnYbW3knlVHdbSCYq2JlgOlEuMnOXe3XcjQ2H2CXsxQecpLiY84IRNrpn2i?=
 =?us-ascii?Q?Nziw2SP1h0PGGCVpBjHqWUNFTZnSZkciq41bUU1NfNNpHqUVDu3JSym5bE3x?=
 =?us-ascii?Q?lmkgjwWElct61IqDjiCvkDdITlMq+YgMfjNxFVBhTuX4QuhyooNahJX7JWsh?=
 =?us-ascii?Q?qj3JxAGZj2NhaXf5cmo9eCfiCzDSeHfZHUqfI1YhJE7Tusa9IAEOM2GP96H4?=
 =?us-ascii?Q?zr+HDw9btjsHQvgtKIddSk/Mjj3TwnD15BJlzDhFujR/t/4lSuY1eFZLnveo?=
 =?us-ascii?Q?+48Sbl0RtTfUtaxx6u/0IzwnDY+ndoxgVhFBh5KkOdjL5FB0jw2MOMKdKV/g?=
 =?us-ascii?Q?gHCHr8Qwg0elrGki39a/5lqJ6Yf0o6bgSQ4cRH2QrYV5qm17JI3dZYJUze8c?=
 =?us-ascii?Q?pPCyowkhe2NLe6H8CXcZ1ajqBjW498pCywhKnIPEtpe6mXeei0LLxyqwCFjS?=
 =?us-ascii?Q?DQb45ha5MiUx3Q/7l6wMoZO3EJPykeb3n4RanTlHj4z/+WIcie64kfGce7iu?=
 =?us-ascii?Q?QlIydRqB3eEdqZbfN8isZTafQCIT2dAkqUo/5AfMGtO5JfduJCbblRuKoSUh?=
 =?us-ascii?Q?hEasbmq5VPtWWghWHRPHuRQDKYDZGBtlvjoc27mfTnqHmBoaFBU2lqSjaL08?=
 =?us-ascii?Q?pGdOEkBAS1/zDEWgFp7zJMoZOXuyq5DLMUKi7VLwF2wW+C7PQ3MULru1kfJJ?=
 =?us-ascii?Q?eyQu18hLLFZtP5pJu5PKj/DBFQXaLAm2r3mEv0uXd6RatN2R9BmcOUCUBnsb?=
 =?us-ascii?Q?uKIi2JYxPFjvDeqDIgzBQhUs8E8nVyGtJkDesjfm0/mUBChP2uWSlsuSl9d9?=
 =?us-ascii?Q?nwuOwShvchdrlcUd5If5psq5H5hLSxas7Dhc/Ag/qnyRQMlPLkhUCatcai1m?=
 =?us-ascii?Q?vVcfMdBxYlE/aiiMCB0fMnY3KaDN+vdM+1/02ZdvMIpHRqU7ddnrDDW+ZGJk?=
 =?us-ascii?Q?kCGxzGCD3IpMiv9q5nqiLbQuulptvLLN4B2p21f+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:34:09.2182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9daf87c-4df9-43d0-919b-08de113d637c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Payloads are ignored because the wrong index is written as part of the
pipe update implementation for DCN401.

[How]
Align it to the DCN35 implementation and ensure the + 1 is added.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 23ecab4bcbba..b9c357a40707 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2978,7 +2978,7 @@ void dcn401_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pip
 		return;
 
 	stream_idx = top_pipe->pipe_idx;
-	write_idx = cs->offload_streams[stream_idx].write_idx;
+	write_idx = cs->offload_streams[stream_idx].write_idx + 1; /*  new payload (+1) */
 	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
 
 	p = &cs->offload_streams[stream_idx].payloads[payload_idx].pipe_data[pipe->pipe_idx].dcn401;
-- 
2.43.0

