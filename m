Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263EFD111A7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3BC10E742;
	Wed, 26 Nov 2025 23:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xkspaJpT";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C9210E746
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLBgHsQ61ZROYLT2Y0QYSnbCG99sHX7LdTdMZxubXSv6jtkhA39CNU1GCc0+/c4wYjnxcWBKcWndEXSSEW1PN+D3QsFb1c1mif9/n1LQjoLC9XxNlCjhZ0kalENpjIOhv/KBEp/T2y6fqo78KV0TwgtFGQ6nFcGTPP4TEbphdgn9THvG5/fIO0thj1vPueaGxuGXQtp58WOa9ocKhdEbHXROU1BrfPuhbWWczyacnK1qtPGhZG8bC+xtDGqjZ6zUZ458eYkuNYJpXh1c68HivY8xjnKFILmwCwFDxGY0haM0ErhFBrrb5SVtGEk4m8jU/NhgC7GhXq8J/WsodzwTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTk4/LOULoPS3sBMef4j5JZ6F3adz+KbFZyGg9rc6Lo=;
 b=yG+V1f3QAKsucyXPbTeLQLF1UnE5g0h6wIU7ZxN0v1OmAuNkT93Ceo+6emvB0Et0XBdE71mP74MO9APhfFJLV+PwDk3O/EvMkWzJhmYZiy/Yyjc5NZ+MIIRBlVmm5SXd4bZKQT7HZGidYmMG7Sx/26vJEF3hM0UvYq4Dr9EqqwSEVyGRQ8FTuhXA/Ypb+mBf2xufCbh9Q+XYDak1hY5RavUFquloyRMmgDjU6PL2mPSqamhPLVY3Oi4f11ggpufsFHkXuk7C2zy/bSbq0y3eBwh+pV1+V1auwL24ZsmvBsd4VWjDwTqKlb1bLAfjf43MfBE2M81SJinK9QN1U3y7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTk4/LOULoPS3sBMef4j5JZ6F3adz+KbFZyGg9rc6Lo=;
 b=xkspaJpTMPrZKmETCATbzPTBnXw0GoJcd8vVgjApcHedJNAVIJ/o8x3KDQlh+kf7TBKACv7SOn0xyozCf1Urtj7ywOR3y4HSk5pJBHVTF62GOlKTF7pDhA18/d4ocHrj8w5ztRxpodCpt/Z2tEqfNlpXFUSs6Gq+xiWPHE/VGnw=
Received: from SA9PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:20::28)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 23:06:47 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::95) by SA9PR03CA0023.outlook.office365.com
 (2603:10b6:806:20::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Wed,
 26 Nov 2025 23:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:41 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 15:06:41 -0800
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:40 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 12/14] drm/amd/display: Reset pipe mask at beginning of cursor
 offload
Date: Wed, 26 Nov 2025 18:06:12 -0500
Message-ID: <20251126230614.13409-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: fef9bf61-15df-4261-8272-08de2d40794c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uf0Qtr/L5o+iDlRJ65YhM60cK+Qs9XjgL4Y+DQ6DB/n6/eX8ic22ax8/Lflo?=
 =?us-ascii?Q?WmsP244VWMsprG6tLXj5Vji/r2LHPj7LsuE6ef4c09u8krgkKRFNPwrwv8oB?=
 =?us-ascii?Q?JZDOWHjFbHgNv4uygMFbIT2j7V6/iPNuWxPVRNPHse2PHMlfMbnKXovKcUt+?=
 =?us-ascii?Q?pS31VpXzLZEEeweukHY+RDRihqmilAG02mHtZCOlTd522sx6y8PI8np0Uicw?=
 =?us-ascii?Q?FDV/fgEQ4EbOFxgWkYW3JZx8ztPi/9USMD92N8KPQgpvCg8UgwhFQ1J2Vkvs?=
 =?us-ascii?Q?UP3BwXMH2w/hCqT6/GDttx9XN5Uj+DQh4rcgyTW289YLz3gWUfuHLbipEPpr?=
 =?us-ascii?Q?gSkd1icBCdpwVVX8yPr7O4Q4bb9SKYbuznl9wAHO11/D+W1iggJEprOttNT0?=
 =?us-ascii?Q?xoKzoxyPVeCmXK7PDlg3Pu+N/KKsPuxadz6ZPQFd8HdTifvSU1toAHzLlBVD?=
 =?us-ascii?Q?oQnmIw/s6hr/FetTnJYptAEtU5fJ8UqVFEwinHmY1y+CLMWydLGu4jni5yaJ?=
 =?us-ascii?Q?0wOwMOTDXNxCdxPK8VEOA/BTDZ6cYKV0swUtXKmz84edcndWwnY9evTzx0pc?=
 =?us-ascii?Q?A4ucpr7OczYDGOs4zP8bhjrUG5bNp1FkHgkwnPkzEBbQmQe/SNfjckuEw9XN?=
 =?us-ascii?Q?A10cydZKnDNYIfBDmOTRVnqPjcbIoPPX9dTV+q+f0VKPpQyuOpRJ+elnBTNO?=
 =?us-ascii?Q?BN7m/UdahlKAAEpo4ov7b5L8s0ttl/yNbSovySrH5WTvdBc3QL9mo+nVgaaE?=
 =?us-ascii?Q?tH3xhkv647UlfjCNo0idPnACN0Njb9Mp3qR0SjMy6ayB+PLu/qR9HMwd9SG4?=
 =?us-ascii?Q?ZF5rws6NyjdoE0Kg9KGEaSRpo5ZcueGCh5Arpcf5m3TzvCdhyx63Sc+l4Jp/?=
 =?us-ascii?Q?VESbckVYMWFWJpfPOQ2uUrT0ThU9wy0VK1M36xHmIKRATdE07blklooCcyUJ?=
 =?us-ascii?Q?a9dt12bdUoi8jBPKYivPmDFyyMc0JKPc+Tg6k3uJ0CujK3YQsHmWwDkbab4K?=
 =?us-ascii?Q?iPbKMs2Hn2uiS+wZMI7jJ6nIbKifZQa3x3BF16n6aexhnbM49t0JTaKg0AUa?=
 =?us-ascii?Q?nqaEjUQyBZuTEQogYNQOC3voo/e58AZNKU+qX10eicB+iXvzMw+hWBOmrWx5?=
 =?us-ascii?Q?xVyh1FNSJxuIzcSTSSj8EMVsYHnERlk84xCsTrMHe14WCa8UPwElVL1X6UEw?=
 =?us-ascii?Q?1y3PrFyGH1Dr9dSWP2cyUu9Aw5/Nzze5CMpjbIhZ68Cf4rbXw0euxAXUM3YY?=
 =?us-ascii?Q?NOBWDEPgUVDfp8NWJhbDBW5Rha5YjxdUV1Fv3u+usmrxAUcx/q1ZmIiNfBDU?=
 =?us-ascii?Q?2pq6TC0unTjjfzIbtHpuxKq9qdj5Z68VnJXDpHyIUd5ORpwEsweix6JHwVuC?=
 =?us-ascii?Q?ge77REGTXuYVjuT+T7F4vj7g1tnODD9UDIBkesVRAaHyBQi3Q35fnRIIgnvR?=
 =?us-ascii?Q?ka5lCR7mhD7iSEbZURGLagAxUsK6dK8yadMLZfz2+9nuEm/oCZ+/vFlc8hJM?=
 =?us-ascii?Q?l1XGmrqP7yLLBKjBS3mOim0m2x6IRCJoAi5zB+6Uad8NQdOkmO0Ey2I04H4D?=
 =?us-ascii?Q?zOqqcBcy5z4dkcraE8o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:46.8762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef9bf61-15df-4261-8272-08de2d40794c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
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
Double cursor when switching between hardware and software cursor when
dragging an MPO window can occur with cursor offload enabled.

The abort cursor update in the full programming path is responsible for
this issue since it does not reset the pipe mask when attempting to
submit an empty update.

The firmware programs the payload as requested which may contain
invalid or stale data for the previously enabled pipes, resulting in
an offset or double cursor.

[How]
For performance we don't want to memset the entire payload structure
due to its size, so just reset the pipe mask which will indicate the
payload data is empty.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index cb2dfd34b5e2..1271bf55dac3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1631,6 +1631,7 @@ void dcn35_begin_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pip
 	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
 
 	cs->offload_streams[stream_idx].payloads[payload_idx].write_idx_start = write_idx;
+	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask = 0;
 
 	if (pipe->plane_res.hubp)
 		pipe->plane_res.hubp->cursor_offload = true;
-- 
2.34.1

