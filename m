Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D7606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PiZovqsx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257D910F94C;
	Wed, 21 Oct 2026 06:26:40 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC4510F950
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDrMJJJz5+LERN6Bwt7XFHvTrJgNBSDvmdCTWPmIfvuLzIfoBcLUj/bw6+PuVyvjMDb3iPDtSdCGv8Faz4DKGAJUvuHWjzLh0Uc7hFq09bCR2BeBvXwoBsvKHwtbLRlcorwsTcJZ9lu+2vpfMwHOptH/g6fu4L9spiuzjiTiRlQgEJiZd9FIV5Bvt3DKeCf1abkxaEn+s7xw9KQLWwU2MBu5bXQqoqTtOKkODihydIVigf+qKxN0JnzysaMa9rciZnYM5mPzU9EzT5t73CmUhHls+lJ4ZL0dq6mydITA5opENvgplLsiitRT1I2fI6cH9PduW28zLOU9XouqwuJ8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvcvHtwLnPqTqoXXmIyKQ4VwRNrinCPZ+V3h06jiG7o=;
 b=jwpUzQ4wrWYWy9aDScV7fZuBXeTQs7t/2ZmfsNFxQ5zoykmByIyPWmVtTTEeyLA0cD7ydZYXzqmpAi79h42eM+LWwzwbmc5aVyjmqTlRgzbjP/v3l6byMB7aokB9eQFciyJ8+0NCwfidny1ovGgBWG0rvsJPtR81HEQpJ+kAGe/b06vK6GUsc6SWLioBmklHdFpswAxIaZ/kpjlU7WX//lUqCQ9EdMIcdgkLxnDwM6LOFTuH3+crFPmb+JQ3Gpii5lmLJfsFAeMBabe0wZmRW4Lp1k/ZFcJnThpXMWzHetx9il8D6MGa+Y8j+2Bc32Bb6sDBbRrCyMRy6g/lE7TkQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvcvHtwLnPqTqoXXmIyKQ4VwRNrinCPZ+V3h06jiG7o=;
 b=PiZovqsxZA8lgc93cYN7ZCG1KILtwFqwYh9UUy/tLCLvCDzu7QcKv8BHoZi3QahgDnIiwMgcYnMHk3FtNxlHLWp/LZNLzCULbMXzAkd+KwycgwVT6Q/o1IIzPDwW8aNmCV4j34AvUAEcffKrDEauR27NjoDu4EVDkr7qq+pgXTM=
Received: from BN9PR03CA0962.namprd03.prod.outlook.com (2603:10b6:408:109::7)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:26:29 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::80) by BN9PR03CA0962.outlook.office365.com
 (2603:10b6:408:109::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 21
 Oct 2026 06:26:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:28 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:24 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Shen <george.shen@amd.com>, Michael Strauss
 <michael.strauss@amd.com>
Subject: [PATCH 18/49] drm/amd/display: Preserve planes on DPMS-on during DP
 test link retrain
Date: Wed, 21 Oct 2026 14:22:24 +0800
Message-ID: <20261021062519.674697-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: 594e78d0-dc3c-47cc-a64e-08df2f3c3db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ms5vrIl8gci0sOAcxVmgFklzZoqq2T+rlpacnH9ZgOb8ce/ZuPabDQir6znKZH9KScQ7JTKbWsfOTVew0lU4Ati7Bc8fsFgbgQ4cU6wEiVRScZ2IWfvKHCL3bjdZThv3onuJcX3KVtLW71nII7VvwI4n/1+oo6HXQv4w0n1ZIwQQD9m45qXGTy9GAVB5RQOtDNTJoTILCpOAWqLV8DY59J0JJ/w8gfrhjE+8D6Mu6Z4N5CwJE4vrTo0JHQyqqMIbdaP+rN6q64KNVWJz2AVlJfHDaWnG+GH8dfSN+3iVfZgTeJ5s87abFVq6nIcGf4zlJQeR1qSQ8VIuYxBCdKhxE9zrwBoRv2EVejDbte+yre0Wd6UxV4ErasEtnjeu+S2LGM5uyLTMy1B0w3AIZd495IeLaOaHmkvnc0Dqm8vwOMgWizSWUDwH4EA9oOyBLToLlfJ69WzfMjZvCvF6JcyCvHk5xoGIJ4MhQmD/B1qI0MR7PFHm1Uoc6cl6FnABSryaOy7bQJQXikCQYtGFBnsipD/TCAc5GqMvRJT6H9Q6+D+R1kqfQeRQBnewR4pnCb97727w0SLW8L/Ybi7RxGQJ2r4mLr+PzKapsI5qxoTk/iq5ysGW3/mcNfeuezJQdrNuOVvJWucD7nduYefOMj1IQIYlXV+Euu00MRH1YcBp/MMRA6TbLfwPTOGJ3LLaG82b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ysszrRjwoLHCr4D9rbA91cfdoFlC6x4J4D+Im3BMilgtRW8mYsA0DV+3kbr97OT2hYvnOFJmwONk0DyiY3K7sgYkBf7YFZ52APsU2mwlDtKUXJ8mHccyinzxf4qUVOyzlmW0YsA0OHl/XELiZhttvD2qq9xA68GLvQ7NUtTK8WH8GVFPYGjVTE9MaXIoEeQxYfDcO7QedhQfGKdujDeN1cpbsywf84NAf5dD1EAXWcSlzkhwss0no4VKs1KGot9WNUoRAHB/jRmdIleru7aQAr40BNuo4SG5jKXi1V++u6hDbqsubRcsWEbBMWT33QBVCT2Ig5paSDKhJZJ3MNCTusns64iZtA5GRrEm2lR0dUw/XfZ3QMjPibhRQvY7UGL2/77PjFJLCFFrgVVVdirkod/uCMBHRaDuBvgajUp7dwTe46TlQk7r1aEJ93KOLLlw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:28.9133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594e78d0-dc3c-47cc-a64e-08df2f3c3db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: George Shen <george.shen@amd.com>

[Why]
When a DP compliance link training test request comes in, the driver
turns DPMS off, retrains the link, and then turns DPMS back on with
dc_update_planes_and_stream(dc, NULL, 0, ...). A DPMS change is a FULL
update, which removes every plane from the stream and then adds back
only the planes passed in. Passing no surfaces leaves the stream with
no planes, resulting in an inconsistent state.

[How]
Before the DPMS-on update, build a surface update list from the
stream's current plane_states and pass it to
dc_update_planes_and_stream(). The FULL update now removes and re-adds
the same planes, so they stay attached to pipes.
If there is no stream status, fall back to the old zero-surface call.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/dc/link/accessories/link_dp_cts.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index d3172dbdcdf0..83f676a49fd1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -80,6 +80,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	struct dc_stream_state *streams_on_link[MAX_PIPES];
 	int num_streams_on_link = 0;
 	struct dc *dc = (struct dc *)link->dc;
+	struct dc_surface_update *srf_updates;
 
 	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
 		link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings))
@@ -151,13 +152,29 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 			streams_on_link[num_streams_on_link++] = state->streams[i];
 	}
 
+	srf_updates = kcalloc(MAX_SURFACES, sizeof(*srf_updates), GFP_KERNEL);
+
 	for (i = 0; i < num_streams_on_link; i++) {
 		if (streams_on_link[i] && streams_on_link[i]->link && streams_on_link[i]->link == link) {
+			struct dc_stream_status *stream_status = dc_stream_get_status(streams_on_link[i]);
+			int surface_count = 0;
+			int j;
+
+			if (srf_updates && stream_status) {
+				memset(srf_updates, 0, MAX_SURFACES * sizeof(*srf_updates));
+				for (j = 0; j < stream_status->plane_count; j++)
+					srf_updates[j].surface = stream_status->plane_states[j];
+				surface_count = stream_status->plane_count;
+			}
+
 			stream_update.stream = streams_on_link[i];
 			stream_update.dpms_off = &dpms_off;
-			dc_update_planes_and_stream(dc, NULL, 0, streams_on_link[i], &stream_update);
+			dc_update_planes_and_stream(dc, srf_updates, surface_count,
+					streams_on_link[i], &stream_update);
 		}
 	}
+
+	kfree(srf_updates);
 }
 
 static void dp_test_send_link_training(struct dc_link *link)
-- 
2.43.0

