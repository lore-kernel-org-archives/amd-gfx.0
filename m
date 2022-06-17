Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB49C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A93710F2A4;
	Fri, 17 Jun 2022 19:35:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F3110F350
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsMnu74xD5zDAnKVgMtLc+NlBhBEufB8eHGupSRQA1CeiBm9Y3QC+y6UrKAbVKxj3JWLB3gmmI8cNP/pUHGAAC2CboxoDecfvwbJ+flEnhVXarinbcmpL+6mFqurFYV3yIQudCOePxM8t4mECl8TI08yQLkAicHXFIRnJelLL1iapkNGUSMR7tyGKz4s7L1MsCChw3NXoRpECruaqPVEMGhMhfR8ceL9ja9CRXuMbynRW05vdLO8/BldIJ3jT4Ybdt6fyG03BwZUScs8iWphDZFYAJWPU89Ef8X8Q8+MZNIr6ntWhBKUWRdPzKFKubL2jl2C5OqXgo6/bQD5FDVwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZD4aLD1Vuq6+8AbcIWumx9xP7gTtdMwQ+B1wty3G5U=;
 b=FnhPWPjFZflQAwZYZER+0jxS/lUIh8RWiQ+CQYAWWDfdCYZmaZFkHIwtsJbQRVbYDS7UihL6ULMM4mxu5Ldd3J6ZLVclBLMvH9eXmgwVwxG0bGePc+mH3ujgRlS5SHaxtAOjrzUp2A4gbE1JfiL2inmwgqPm6b8FSdA1bmyzwRF2hAp1uiX5ypZLUuJdzoESazzr8YF4I4A4mFMGojrfSrYbz0C1yJm+dQd5lUww6nV+vMDOU3K/5bFBnsMQaEmuj0RGe8Hphb6yUIkfNToqIRTOQxx0BIAglcal3p6e42QkpmBUFVAPU7KK1bZPNBV8tVXR+Dkm5ww0ib4mIBq8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZD4aLD1Vuq6+8AbcIWumx9xP7gTtdMwQ+B1wty3G5U=;
 b=J+YfsToLddZiAI5zjrrOoUOuZz/ZrsSORI8rJThUdNB6E1FfVbaDCXb7motbuFzFV1KEBIUk27qpCp7jpYr5z78cud2xDC3jD1nAiH2hgWMs2gZvgtQNo4utRYrpiUwjxDzPsu8aSML4e2APIRl6gz2qWnwxugNlto4H0WF5Q2A=
Received: from BN9PR03CA0121.namprd03.prod.outlook.com (2603:10b6:408:fe::6)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:35:50 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::cf) by BN9PR03CA0121.outlook.office365.com
 (2603:10b6:408:fe::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:50 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:48 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/31] drm/amd/display: Enrich the log in MST payload update
Date: Fri, 17 Jun 2022 15:34:54 -0400
Message-ID: <20220617193512.3471076-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32dcc15a-6583-495e-7a8a-08da50989597
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB523872A3B81A36CBEAC03F6098AF9@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1H0J0rEMft/1EcaaK35W+rxd6WmDdyHWwvyBg9pj0FFizuCoajzZzED0zVgDsJSzJcf8I8soO4s6QLIO+GPIBaJMxQ3cVQekSS7MTC+UCmpayFPFi+Xok+AOUFtuosNvMxXEpndfDdRKnVz0dtzSM8THRRrvbDxoaOsKQ2APcKgeXFKUroH6LRKt3O+411+8JPedC01O+Y9tFsjuXAfbJRFzcfBv2s9eWFmCro93dfxXUejlIyUi66WVwZN6IK2MJmJhVnH7DctYWrGG3PYcmRb5tlrZ21jCrgd0sDqt6pea/IY8zxnsYk2y6BhBBGGzqiMOQUAjUzF+ioMxsFyXslv9JnQF8p7UcSWDUjkeIjsu19lv9rYjUIlFtE79+cisIb6gnC20L5T8Bv2SxJzJMiW7Krq5c7YaDfSCJNpArxAStuApI4JhkzgSU7I5gPFO+aHhpuWSQ8gvygrgEs2wbY0TQ78z37q41tkwE3am2JoDwdM5filhFGP0Ajztl4FtiYojPmxWBDZtIm3ryg0CKkQ/k4L9H/Yo4iwyy8xZNuWK3yRnBPm5Q8u553iY5/nKc5w8HDwNmjr3lDWj1Zn+0Wn93ZuJ5m0WmIWIG/gXwEN5f1F8+lvFPzmKWc5xeAKX4Ub+huju1Ew+FKkNjWa93wCQr25CWIfs3jorLAa79PMHbaZXY9WWsmp3rCAJbJHdIdGPn/joVFU+FN/ZCOwb9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(16526019)(498600001)(8936002)(5660300002)(36756003)(336012)(426003)(2906002)(15650500001)(81166007)(356005)(70586007)(40460700003)(2616005)(1076003)(186003)(7696005)(6916009)(26005)(54906003)(8676002)(36860700001)(316002)(86362001)(6666004)(4326008)(83380400001)(82310400005)(70206006)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:50.0705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dcc15a-6583-495e-7a8a-08da50989597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Ariel Bernstein <Eric.Bernstein@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[Why & How]
Enrich the log to provide more informatio in MST payload update.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fb6ffcb0bc6b..43b55bc6e2db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3831,11 +3831,14 @@ enum dc_status dc_link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw
 
 	for (i = 0; i < MAX_CONTROLLER_NUM; i++) {
 		DC_LOG_MST("stream_enc[%d]: %p      "
+				"stream[%d].hpo_dp_stream_enc: %p      "
 				"stream[%d].vcp_id: %d      "
 				"stream[%d].slot_count: %d\n",
 				i,
 				(void *) link->mst_stream_alloc_table.stream_allocations[i].stream_enc,
 				i,
+				(void *) link->mst_stream_alloc_table.stream_allocations[i].hpo_dp_stream_enc,
+				i,
 				link->mst_stream_alloc_table.stream_allocations[i].vcp_id,
 				i,
 				link->mst_stream_alloc_table.stream_allocations[i].slot_count);
@@ -3896,11 +3899,14 @@ enum dc_status dc_link_increase_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t
 
 	for (i = 0; i < MAX_CONTROLLER_NUM; i++) {
 		DC_LOG_MST("stream_enc[%d]: %p      "
+				"stream[%d].hpo_dp_stream_enc: %p      "
 				"stream[%d].vcp_id: %d      "
 				"stream[%d].slot_count: %d\n",
 				i,
 				(void *) link->mst_stream_alloc_table.stream_allocations[i].stream_enc,
 				i,
+				(void *) link->mst_stream_alloc_table.stream_allocations[i].hpo_dp_stream_enc,
+				i,
 				link->mst_stream_alloc_table.stream_allocations[i].vcp_id,
 				i,
 				link->mst_stream_alloc_table.stream_allocations[i].slot_count);
-- 
2.25.1

