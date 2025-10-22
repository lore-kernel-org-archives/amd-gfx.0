Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C682ECCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE1510E6FB;
	Wed, 22 Oct 2025 07:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ALHcs0wa";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963DC10E6FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeBWjE0ihJ30xnQ2JgjhOvsSpyq+W7gzhWwa4qTfQaXgWc21lf5DCXHq4xXWg1L1Au95B3ni42vDGy5l6y2cRATvbJ4N6s09hm1QkVZdpP6NTvPPB/p2lbHAKYTp0amGmUE9+82d1YzinPOfsHMitDVmdk5jrredsikb0nXjvCS+rl8qh7CmNFMb8SCBFb6qUisRKKMN4zBuKFmuMr0WH8hOYdVvnRB5B/sDNJqUVxRAP9k1I6EP+x4KGTwk7mcE0fiPrMG1ThFFxsS4/t4Ob+SX1Gt3xSK5vl34BejP5H+v2fCVZ3AS1iB0lBK5n+iE9AfHV0RKn0B8026VagJ6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztlGuKPdT40pjTBFoVadkJf/bwxOfiusj85enBkUW30=;
 b=T4Q3j94lF0j3ZD1AX8WdwEJu3IIP1slc9Od+byhFk3sHDZQeHPTwfKiK+72r1hlR6Zm+FGnJjLqFGt3bP+N+bfXmXmYyDFY6A8TATEjrzOh1u9SIBo7NXgSbpsvuQArkN53sDbUPMKVWTTGhxjkBHy7Vg5VyzNMfaX/YZcCLkeeAO1k6mvgW20RHpYKOuKE16FyTIqGBukFfFforQi/1pTaA2o7HGLhLJDusEkdbpk3pviuEmgPsmz3YJrbn7pDDIaKm6dK1CoL2Kk9HL++nR4c3OUQ6fb5Bn7xhj5dgwjRtNvpQpGeJmdBGpWJ73RdW0toPMWU5BSY8az8wF56efA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztlGuKPdT40pjTBFoVadkJf/bwxOfiusj85enBkUW30=;
 b=ALHcs0waTWTWgt/ivMKwqbzw9v8HmnQWe3SVByRAqknunfD+v8pJT2vJeA0nzNPimjqFu4JBB+wXEbnjzWSpuWeItsIDCzsKUf8u/1bk6xq5Ibv2Z5Hxo8/fZ1XgPDyposNbyMQ8ZdjezZDUqpDIXDKbmdHQRhjUcjV8tPOlJ9s=
Received: from DM5PR08CA0043.namprd08.prod.outlook.com (2603:10b6:4:60::32) by
 DS5PPF266051432.namprd12.prod.outlook.com (2603:10b6:f:fc00::648)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:34:06 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::83) by DM5PR08CA0043.outlook.office365.com
 (2603:10b6:4:60::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:34:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:06 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:05 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:34:02 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alvin
 Lee <alvin.lee2@amd.com>
Subject: [PATCH 05/20] drm/amd/display: Fix notification of vtotal to DMU for
 cursor offload
Date: Wed, 22 Oct 2025 15:30:17 +0800
Message-ID: <20251022073332.666119-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS5PPF266051432:EE_
X-MS-Office365-Filtering-Correlation-Id: dd90bdd4-0786-43e3-d76e-08de113d61e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?umIrTyhpoFhlfZhWuEtc3tBJblyeMIYGyVmNiEhCi0YwYySVAZzimPd+0J4f?=
 =?us-ascii?Q?0xnthNTFkqMwGb/pn+BGV3YadpyAgYdlk+KBtAWdhK45frFKNSrV3yqbmpLt?=
 =?us-ascii?Q?V6o5QIG4asCGk8eWvZtEwpV5PaJkEKkO/dy7OE3R/TV5DIEjNkLFa2l+wCPN?=
 =?us-ascii?Q?1x6bvrjdQrcFRqUAJhM3NmA+hpyfcmHu9jo+qUu0RJ75/yOJP0ymRZCvFzj3?=
 =?us-ascii?Q?REZQkXrzYM7uYHZLkYFgPHy6yrsuT67MD1GS6XMmSELSkcFDH7t5R0cjgWvB?=
 =?us-ascii?Q?Esm0bh4Js1qa9bUUsmyjteUrHmeL0YDXCrAkd9L29qh3n0A9O5A2Y4J/7G+m?=
 =?us-ascii?Q?qX2IuohadlCThXovsQRwhtwjLI1qKhO3AsNo2jb84tDgb0au7+lN1SMX/orX?=
 =?us-ascii?Q?bsxD+/J58nvr/zyZAcgEYP9agEom9hRadcMnmLinlidnd4iI7uz5q8lAX7yG?=
 =?us-ascii?Q?EPor3GUGpzwwHEQ3/PQVrpnbOmgaJo9EmhPV6qcLSThc3D+CuMdybUbF+b0e?=
 =?us-ascii?Q?UvRPMRvPWv1ib9tfA1mUhlHYEvYWsiqblyaYrCzuI6LBDpCB3fiGjZqqZcRi?=
 =?us-ascii?Q?6hu2qHath0NQaEsS8KXEagwUjc9vNBbX5XxkEYI/w4pdEc7ljwxIk8UlgzSg?=
 =?us-ascii?Q?a70n9bbsrcijoL04KxofvwPIvvDNRq6+aFNOB9ifcKOzNcY7/+hmzGIfKOBw?=
 =?us-ascii?Q?Dp5hqr8qHj9obLULTY3DoF6ONT9AyygynYmQ2yarhaoodmrnHLcLnAYY1crj?=
 =?us-ascii?Q?BdObJqS4ex1zfXlLvG/aDRfuGHGbZp3+h+xOWO2fcgP6fHvwaOK9olhAty4o?=
 =?us-ascii?Q?vMNqKvAV5MKhw7WtxZelfjTFpPvC6jQACRKTUijXKH1kSEBXrXw6GmpHDu02?=
 =?us-ascii?Q?PquR4sr5QvSKmBXYc26FfDFxMLQXUDBffPcwoUwrZ1wO9sAZww02KKrZGIOX?=
 =?us-ascii?Q?9ZKL4zDLw8UIafPHoc2CAmH6gIbg/LFL3o1C8bpkNcKLcIu1e28SaDu5MjxM?=
 =?us-ascii?Q?PYOpbyjC2pwRlY4WH47hHYeOvNEujZNF+HDRnE0edWYLUEdrsErg38AxA/3e?=
 =?us-ascii?Q?NwU/dcZsdtSrWYf6PfdUoDMN0qxhgKmOzTOdJuPMrf5wNkbPf2WSDzsugnVT?=
 =?us-ascii?Q?AGAn9FcdhoNR44dsHCHpYQ9FRCdE8A1JtP5MEqmhgM+l4TStFmHCbn41e2eY?=
 =?us-ascii?Q?nQOWXg0A8It1HIn+TcKuWpUcBanu9PnDk8vb6vflLUG8OHE8aTgtor4VYY4L?=
 =?us-ascii?Q?bNlaITqsqRGi8rLHgfPuobP/9r+VkDpbb/7KGGzqiTsYLd/E2PYDXZpmNm0i?=
 =?us-ascii?Q?F0sSUWDDhsY9MhYjyTrlNwa0rY5379vm123ys3VxD+svGBirimZ1AmwjaBzF?=
 =?us-ascii?Q?xq1iXSz7ra1kNyiZBb3MHcy+tsO/hh9pB21fKTxKjAybGCVfhM5APGaqq8Rm?=
 =?us-ascii?Q?OWCNzB7r7cMp8MNO65oJdXSaDLsyD+M3OlZubzRx+q/AS1hzO7IcDMKEDSxO?=
 =?us-ascii?Q?7PlGXnXh1CYsAR4rlAl2qouh19Yk/RdtyWSc5ncNCx+vA2hMgPOmJ9Ix/p5G?=
 =?us-ascii?Q?bHX6rqP/25MWgBplrjLxm4NwxAImQhcSxcO5HUsK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:34:06.5601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd90bdd4-0786-43e3-d76e-08de113d61e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF266051432
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
It was placed after the early return and the notification is never sent.

[How]
Place it after .set_drr and before the return.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4c964cf28f68..c4ef63011f47 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -493,13 +493,14 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 					1,
 					*adjust);
 			stream->adjust.timing_adjust_pending = false;
+
+			if (dc->hwss.notify_cursor_offload_drr_update)
+				dc->hwss.notify_cursor_offload_drr_update(dc, dc->current_state, stream);
+
 			return true;
 		}
 	}
 
-	if (dc->hwss.notify_cursor_offload_drr_update)
-		dc->hwss.notify_cursor_offload_drr_update(dc, dc->current_state, stream);
-
 	return false;
 }
 
-- 
2.43.0

