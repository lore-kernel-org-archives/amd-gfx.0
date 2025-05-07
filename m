Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EAAC3ABBE
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F7DF10E733;
	Wed,  7 May 2025 02:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qWHxDn96";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B6010E733
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MksuLBCDkL7G30j8QL4WpSVTWLTGz2ktRMV3SFPdRtY02LwHO/E0xWx9F0wUpqOnRm3oDGXitTzucICkJJ3rjHHOT/ixbvxcCY0sCmmE7XF4k9kuPZLH9Aw9Gv8BUJBAjIyxgunr6aSt0pRE0bwHoF6z5yY8aaF0ZorPg2MBn/KAN0ovAvyD6Wl9sNvNTyar7K8WEqaX2Nj2ky1RwWZLcH2cCR9vXmZFZi7Xa/lscS94DaUEzazfB5fjlmYoeappdF05AsXn9dO20NHbbrvhb8bHcOMzpF5+SSoVyZiMVcstPMmriZFw+KNWI6JJxbvbzgYDKdy2NIquCN3wpDRggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUCZqfTqNyUTpVC37OjpfSgPLxPaq201eQaH6WznfTg=;
 b=hLExLqx7E+P5dGdSo7vnqOxBQoylZ9N0vz1M/oDrWqjqc3SUHtNQWAW7ZLgW9bKXrdy0W9Yw+VlFHEEWUi6Gmq0J66yIBUal8UjhtUIEkzj2BRn5PsspidsYGVlbf5CxphUQxKEHpymRknOph5rinbOu0Unu7SRlLC6mETSODBi6c/eUywvAamqbcHrcSQ34jK7GyXU+RBQe5aTXUnHk51CezfFnAk7F9KwOpErxtSfjO57sEvEKwCxMlX6bylNbzU5uLmPYMtmFoxFRZfDxOPtotxxUh9pjOymcdTWs23yM4dCTgGt/VL/XU4eKcmy+d62jZTZLjcBvqKvtLxXjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUCZqfTqNyUTpVC37OjpfSgPLxPaq201eQaH6WznfTg=;
 b=qWHxDn96V6iL3OswcVPGOpVOS6B5owFqFuHSwjzqlasja80mhPMYOBPkaqSuuk7VATwh7Jd7EA7RuqKPbdzHK91hPYZ+SCpmRVxnzuUsVO48S52nHMvJiPzLZYTYmWa0/RTDwyk3VdRjsv6ISvK44YEl0WrMoEzpGBcWKbmH2E8=
Received: from MW4PR03CA0136.namprd03.prod.outlook.com (2603:10b6:303:8c::21)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 02:43:37 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::8e) by MW4PR03CA0136.outlook.office365.com
 (2603:10b6:303:8c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Wed,
 7 May 2025 02:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:35 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:31 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 06/14] drm/amd/display: fix link_set_dpms_off multi-display
 MST corner case
Date: Wed, 7 May 2025 10:34:50 +0800
Message-ID: <20250507024242.1928299-7-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8aed17-8c37-42b4-f62d-08dd8d10f71f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LyJgduP7vIPiYYJqqkIn54zIw5Nnadh6sCHcTdH0/EFw45cKKAfDA/b416ag?=
 =?us-ascii?Q?nE8jBkp7yFd0Ix2N08WwuLdDsA4DkLsFvY4dpb3m41j4QgFiDjIZueRJ7ZRb?=
 =?us-ascii?Q?dSwor6xLowNzVz1PChr/U6z9bqIn5NFnARe2tHNcA9sAgzxTVPFrhmbUvFTC?=
 =?us-ascii?Q?MjEyMLy5ekdyNSa1bWV2Wxx91WuoZDtP4QC56BEABFq7qDrPMrRYWe5Lwpyw?=
 =?us-ascii?Q?AjJFiNmutxe5DGGGKMDuuAfasF4jlUBNs9M+118+u8wmxE9OWdmlSl38tWIX?=
 =?us-ascii?Q?Sc3ebCdNJHK6bWlV8Cmz00dDkU2KZQzyU2TwpbN3Iv+WRSrhYfuZm+dy1171?=
 =?us-ascii?Q?3uRdZA9HCI/9N4RuHMSR7blQhqo3KJLieSSsetQWGzU+Uby9mJDwi7FgGyMl?=
 =?us-ascii?Q?spS7x15f2tl5Vyeh0xs5+q9ot8TiBlpU0ZS3JSj66IOOkcMCEQHOYVPvQ8rd?=
 =?us-ascii?Q?xaxCs+EpACXqDo1zJD7kuVTOtUe5Mm5BnBkUYp9Ojx+iTVf7778MKLeiM08n?=
 =?us-ascii?Q?qFzOlEPsFR6tV8rMYg7fiVCHAZ+6FlBI8rEBBKq5m1rYa8py32xTUGqeQFXe?=
 =?us-ascii?Q?CXnI1RuO1UW6zkvPiC3TY6nqC6pPwfamuReDGczqTyuztSig4vLsLCZBGsPB?=
 =?us-ascii?Q?dcIRh9qZSGsK3CE1SPwt3jCUP6cMWBTbZTNSfahVYMByi1En/GPgFaMsQQX+?=
 =?us-ascii?Q?q6qoSPQkdVFVj5A1sKPg3QZ4AygK8gUb8mW9u8v2BhF2GwuDOjVUztkQtmq+?=
 =?us-ascii?Q?r1JTmi1mIilPj6AQrXb1+KkgiA/Zrh2cZoY8NWMUfTCWcWxRwPw/V+dtuWlb?=
 =?us-ascii?Q?fbbJgf4dlTCfeqvkVWBeDaz7AXiDEMazuHIHKTIMlaXgiPGowo1a+GNHBEe2?=
 =?us-ascii?Q?YGX3QIeHthEVi78rRTgVnVY9SQajf/A4IBtdFxCV95OMg2byCAke3wLrKkP8?=
 =?us-ascii?Q?BjQ8T29wRbalXiJfZ8A6RN2aIVhwc3ZByVz+tyjbvpjA7rpesNF+9YwDsCtg?=
 =?us-ascii?Q?0cyHLETrKrzEruQrJgvOCOnIiuN0hoRWNch4DX9hPjnWPblHsJyTCxXL0JcY?=
 =?us-ascii?Q?7tjCXIg0KrcmfhBAiUnmppKvRmNrlwt7bJIKp1EuZaY4c7t7IOmGY0h3wx6h?=
 =?us-ascii?Q?5BMlx7pkIGVju9xw00zDsxsIEm4EQZvmMLZRMzr1fEuR/N5WW3tcblH3GzK/?=
 =?us-ascii?Q?al/9hVSJdax8U/SKcXP+M/Zl1hRs4pqqVHuGFmtDmzLqjVN9dtFbutqZbvbb?=
 =?us-ascii?Q?kgesfO7l8Z7+63we6zEADAZHEP5rrQDFUcVCSRxTje+paHvBzeKVSVltc6LR?=
 =?us-ascii?Q?7t+aCgC2FHrrJVSPAIJeYJ8z0NWkxNRwy/nIBFQc7TlrT/MGOPzknG218c/B?=
 =?us-ascii?Q?ysfpaltHPxYC+6jj/WQLEh//0ELmIA6IYFL17Ux2wrw/GTcHJ2WrZdqfN7qj?=
 =?us-ascii?Q?U97yPAuc2moQX0DeIp5h83rmJ1dxiLhIuN1RVuQ+qvt/yin6fu2xGWJ+DDVk?=
 =?us-ascii?Q?28GpdHrY/BmmnQKZxGZqKNQoWuYQHOo2kc5S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:36.0134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8aed17-8c37-42b4-f62d-08dd8d10f71f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
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

From: George Shen <george.shen@amd.com>

[Why & How]
When MST config is unplugged/replugged too quickly, it can potentially
result in a scenario where previous DC state has not been reset before
the HPD link detection sequence begins. In this case, driver will
disable the streams/link prior to re-enabling the link for link
training.

There is a bug in the current logic that does not account for the fact
that current_state can be released and cleared prior to swapping to a
new state (resulting in the pipe_ctx stream pointers to be cleared) in
between disabling streams.

To resolve this, cache the original streams prior to committing any
stream updates.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 268626e73c54..53c961f86d43 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -148,6 +148,7 @@ void link_blank_dp_stream(struct dc_link *link, bool hw_init)
 void link_set_all_streams_dpms_off_for_link(struct dc_link *link)
 {
 	struct pipe_ctx *pipes[MAX_PIPES];
+	struct dc_stream_state *streams[MAX_PIPES];
 	struct dc_state *state = link->dc->current_state;
 	uint8_t count;
 	int i;
@@ -160,10 +161,18 @@ void link_set_all_streams_dpms_off_for_link(struct dc_link *link)
 
 	link_get_master_pipes_with_dpms_on(link, state, &count, pipes);
 
+	/* The subsequent call to dc_commit_updates_for_stream for a full update
+	 * will release the current state and swap to a new state. Releasing the
+	 * current state results in the stream pointers in the pipe_ctx structs
+	 * to be zero'd. Hence, cache all streams prior to dc_commit_updates_for_stream.
+	 */
+	for (i = 0; i < count; i++)
+		streams[i] = pipes[i]->stream;
+
 	for (i = 0; i < count; i++) {
-		stream_update.stream = pipes[i]->stream;
+		stream_update.stream = streams[i];
 		dc_commit_updates_for_stream(link->ctx->dc, NULL, 0,
-				pipes[i]->stream, &stream_update,
+				streams[i], &stream_update,
 				state);
 	}
 
-- 
2.43.0

