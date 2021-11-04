Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1DFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABD861207
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AABD861207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EB5737A7;
	Thu,  4 Nov 2021 20:52:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC5187379E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gefAiM2NUt0ftlvTKSb0jhXpBU+BrTTD6rMcxIJrUxousKVHofL4xkuxQnoTE6oNWpK3on+2/CPNmI2i/zrb+xD18w/h2Cf+TVIj3ckuvTIIYbeZxGaNI5izllfyOgngqdd5DLGKRbyAZIGbqNSQlJpFVzKvw/bgZGKrQ/PpXbF+Be4Pp0SvFNSIxAiUjcOkCQ6vuCETGzczjTKEylE1TM4G3KWJ741Mvc+ir+rwJSSxkNRs92j2N1uRGnFTQ1odEE7ToYtPM8bFlVOuXtPa/6RmlUoCI6sdoLe+SQhWQxNlibmoMXBeqXj75HwwRlZugeMhhK2RRvgHdytGY3jFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSZzILhznqjWNXYTCq4NybFOupvBZCh973zvjXja5xE=;
 b=Zw5utJZbvutDlx9DVrM5d6qcJ+JTrH1L+yrgMsnQSxvOlmez/GqzgT7ndiHFnByJRyPTQ3N92WVCzO+yKTbYO5l7XzUow1qgUN8mDreIokcUIBqmFVHX/9Wvh+9+DUgxb4PBO/gOhSw/gvgOukM+MBImRYO+iNE9/M5pxCq28fcHeheg47A7mjT8v7T78/SYueCcryWLoBeQKqjBgATgqIkJdaSmBu7x2+PxYJ+cQUORNGZ7D0IjpU07pGLXqOfr/u5jisb0e39jt4QEsRAAgLxSE+ZoqRvxXZeVrwjYWZSh1WrTteoRUx0qbnbwBk4VnAJ4wHqoUakvrOr8JBaMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSZzILhznqjWNXYTCq4NybFOupvBZCh973zvjXja5xE=;
 b=WVMglKY1cdG3ChHOTHikohQgD4/AWDsLmZ4caI8oCvwcRVl13kL5ekKTJZT3fbBJLX4qgr+6mcF2hS6Z+xdoE6TgjHPzC/NNfIxlfpr3SkOhFJfkQV2Yuh4L2Xb0IeecpmeyjV0WNTV2DmpIDmKfBuSds+s0SWCAyEpzRy73lMs=
Received: from DM5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:4:2::28) by
 MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Thu, 4 Nov 2021 20:52:45 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::65) by DM5PR10CA0018.outlook.office365.com
 (2603:10b6:4:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:38 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:38 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/22] drm/amd/display: retain/release stream pointer in link
 enc table
Date: Thu, 4 Nov 2021 16:52:05 -0400
Message-ID: <20211104205215.1125899-13-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98a37ac9-1b91-449d-ebcc-08d99fd50d42
X-MS-TrafficTypeDiagnostic: MN2PR12MB3455:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3455C872E26F723D439CA184EB8D9@MN2PR12MB3455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qq/KhdFOToVdmJUK7o37c2DFFT4lpcdY/zWKuOqZpCnBEBXkU2NVtMn29ARNqa+/odsEzgnGK54CiAk/pVVK2P9Jbos6PBdZf4nRttKsXJoS4j4Z2QVl+zMVoHK0Syqb5rcxa+e6qhBBXNZMbyLm3EWV3FlUs7IWyA/5b/aJDtvg3JOekSWoAQyq53dkjinbUR9/avwZoLuyzqp1JbRfxvplcssSn7xVg4Vbgq3h7XHNBfkrVWUIKZgLF1Cv2pIg0700JKhGiSqW1Jt2zBFqIBZ77J2320hX0HK6YZJCVrriUq9S9jQJrV1RMEskhSvhRG8rcplhqPB/Gi33a/7bY5DF0W7G1JmHsLorGcrJ164DtNV5pjecqAEPRtXPMx6rXEwy8FnluXQoU+1lzm9L5tx+VtMetp637Wj1GYsz40qQCSkg+rfGWrP0xFpxtvkHucaN09q9DAIJ8PgJNVkOBJAnDkqkBupKoVV7HK3T3Jh2RtRDyLrwOB69t8kaB6UE7+48ixz89BtDblAW0UHvFhiHoLk+Pt9Rb69R9AwKRVSctUBkPqJADtGgk8znk/OrhTM6nh2zYrCZpmdbgU2zjiuFlxq/t9OGRDCDIosmRUkggSmNhrUGY3cvN8XLD3T1WOTHOVtMG+NkBDyDiJ263iV7eMnf9gZnmYcDwO1gjZ0jgEX6+9ADrbwuKyMgVd1sHl4lMVpObev17qJ1sLBRyOxPgOhfzbxFZ11au2EcZ1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(47076005)(186003)(1076003)(4326008)(356005)(2616005)(5660300002)(316002)(54906003)(2906002)(82310400003)(336012)(81166007)(26005)(426003)(7696005)(86362001)(36860700001)(70586007)(508600001)(6666004)(8936002)(8676002)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:44.8126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a37ac9-1b91-449d-ebcc-08d99fd50d42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3455
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Sung Joon Kim <sungkim@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
At every reference to stream pointer, we need
to increment/decrement the kref_count.
Not doing so will result in invalid stream
pointer still alive after hibernate cycle.

[how]
Call stream retain/release whenever
the link encoder assignment is set to
true/false since it indicates if we want
to reference the stream pointer or not.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 13a9d55930ed..b96e301f64f2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -122,6 +122,7 @@ static void remove_link_enc_assignment(
 				stream->link_enc = NULL;
 				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].eng_id = ENGINE_ID_UNKNOWN;
 				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].stream = NULL;
+				dc_stream_release(stream);
 				break;
 			}
 		}
@@ -144,6 +145,7 @@ static void add_link_enc_assignment(
 		 */
 		for (i = 0; i < state->stream_count; i++) {
 			if (stream == state->streams[i]) {
+				dc_stream_retain(stream);
 				state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i] = (struct link_enc_assignment){
 					.valid = true,
 					.ep_id = (struct display_endpoint_id) {
-- 
2.25.1

