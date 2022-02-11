Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92092C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 17:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A6D10E187;
	Fri, 11 Feb 2022 17:15:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F68510E187
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 17:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw1Pr8/T0fMe0rCf1XnqZLsYvW00X5tv57/ettTmumixgD8T19PlqZ9NbuKWrX1vJ/+21RrPG0WqfjdyhxuMsNj3ocU3uXhIGRrla/CKGHTAtNA0ApxC/euHwY4zcchk64ZqWgwLEhMU4KiOjznukUkmXFpOZ4qa7FddNyE1eYxddWpatGnA9upuVPHqrGr0ekR6ZlJ1XNth6m3sdB1OlyCDo2Ln6IPPwbIYeiZY+N0X2ruWKofMN+NdiHglxIS3uh82VrjSYmIX5M61rdgx9QoZhcB6+AwtkYCSgdwkCcDhD0T3WQYi6D604AUAHgyCC8KEami/8z8WpxRJeS4V/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LegoYLBG5vkYDLhn+w18tz0rKv9G5rpeJCMPIkdHF5s=;
 b=N45oqBCk5ima959svBWEOEwcNLItX3fUgWPp/tM99/d8/5LfNc0OZFtWyJzM2xpWXaSqv1XL1lrqOvFqAMOLyqyJRpLkWmtmqJrPh9H/nl36YS/niTviOKqZaZazhDbYvOlvLH5Gu9/HlXS4T+tMIjtpDdXKZUW920rNq12w3TWqjhzeTDyarsSX3rFLQoX75Ub34pV+Usy/J+WKAXLFx/kR7Jgg6D3bd202g0lOyg3JHE+CtrM4CqH0FibM/fwvenTldxtzRgJb9Cv3wdp9tgOgsSXmNQ4Yiq8S6ShNhCCNpKdKyJXDCBDaS32hnGiUMqAn4yvZBNGrS4QCjFaQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LegoYLBG5vkYDLhn+w18tz0rKv9G5rpeJCMPIkdHF5s=;
 b=fXdYdzpjPoNP0JyJbvUg+qzRLahS8FJFc/5Fiii6hPzyGIVTYggkqJSFOLWqByz4Xe0JLN97WyJb4Jr1FfGvz6icTsG565eeuR083AMYWR1E/SNtOl9osSxF9VXVWKRg+gUA2KQcjvjawMmpVeW8tTm8qclxGAWy3IGMjuHRoec=
Received: from DM5PR20CA0034.namprd20.prod.outlook.com (2603:10b6:3:13d::20)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 17:15:39 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::4a) by DM5PR20CA0034.outlook.office365.com
 (2603:10b6:3:13d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 17:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 17:15:39 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 11:15:38 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: remove unneeded unmap single queue option
Date: Fri, 11 Feb 2022 12:15:28 -0500
Message-ID: <20220211171529.923453-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4252b5f8-3a88-4038-377a-08d9ed82209d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4147:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4147735BCF12795D8BE052BD85309@BY5PR12MB4147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhES4onpOGIHVjhnmyJPLkJteyotjoTRFl5yw3QY7woi5vWgf85noC+sONxioJmwlR3KN6E//2onPJLMX1cr7n7M9nSC5ECKDVExnepWBWxBMd+FSoGZrnlMvdRZPRW2eTikR4W84PpulMidNbVlIvqJdS7M/cj9PNGOnMcf6larbxwW5fNaS70rZDzviOWwJ8pFuxk06It7oW0IL9AVmqCudSG7Xe+EkCHiwU/JJ/jgr20GksqwGI4PTobHxJ2H+ZvUx09AWU+1vYsR3O9j2c404LeK3bLsLBodlY2lJOX1r+ocQwmE5HZjegNdPFMyRfD4s3T599x+r9eNAFD5bfY7kf357jiLK5GFG57dIVfbreJqYQ2/ZdyPFJmYxqcvnKDjUm7XenOCZKEv/7xmssHDn/yPOq4fwcWQU5w8l9nhhgOb54/ArkWy+9oFMcLw8Uoppq5Y2mq9SPTD3zuSEBe/sh0f1Dzi5AGtmb/QO3/bLuuyzrJ5STagmJ3CDaXtc+NWjsv1dvDmm+iwTML5HJCO+jTDf8s6Ke9hOKDBT6NJKKybBRHOkCgX6+SzhEPfkuCXo8cjONr3V3+ACpPbt1hU9KL8WYVYyz90cz4jju9LGjAc1P8ZoSpQifRCC8BzI8YZA6I1J3PNT3eXg+7JoQZsFnPCoj9sai1mMUMupap4vwpksKls4oG2STv9L5MwqVhTldTL/Hd0VXdUr8tj1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(5660300002)(47076005)(8936002)(8676002)(83380400001)(4326008)(44832011)(82310400004)(70206006)(2906002)(36860700001)(508600001)(356005)(426003)(186003)(54906003)(16526019)(36756003)(336012)(1076003)(7696005)(316002)(26005)(86362001)(2616005)(40460700003)(81166007)(6916009)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 17:15:39.7247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4252b5f8-3a88-4038-377a-08d9ed82209d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The KFD only unmaps all queues, all dynamics queues or all process queues
since RUN_LIST is mapped with all KFD queues.

There's no need to provide a single type unmap so remove this option.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  8 ++--
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 40 +++----------------
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    | 26 ++----------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 ++---
 5 files changed, 16 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 7f6f1a842b0b..c8201638fca5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1554,8 +1554,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	if (!dqm->active_runlist)
 		return retval;
 
-	retval = pm_send_unmap_queue(&dqm->packet_mgr, KFD_QUEUE_TYPE_COMPUTE,
-			filter, filter_param, reset, 0);
+	retval = pm_send_unmap_queue(&dqm->packet_mgr, filter, filter_param, reset);
 	if (retval)
 		return retval;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 1439420925a0..9a44b34abaed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -368,10 +368,9 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 	return retval;
 }
 
-int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
+int pm_send_unmap_queue(struct packet_manager *pm,
 			enum kfd_unmap_queues_filter filter,
-			uint32_t filter_param, bool reset,
-			unsigned int sdma_engine)
+			uint32_t filter_param, bool reset)
 {
 	uint32_t *buffer, size;
 	int retval = 0;
@@ -386,8 +385,7 @@ int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
 		goto out;
 	}
 
-	retval = pm->pmf->unmap_queues(pm, buffer, type, filter, filter_param,
-				       reset, sdma_engine);
+	retval = pm->pmf->unmap_queues(pm, buffer, filter, filter_param, reset);
 	if (!retval)
 		kq_submit_packet(pm->priv_queue);
 	else
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 7ea3f671b325..ed4f2d3c6dcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -246,10 +246,8 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 }
 
 static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
-			enum kfd_queue_type type,
 			enum kfd_unmap_queues_filter filter,
-			uint32_t filter_param, bool reset,
-			unsigned int sdma_engine)
+			uint32_t filter_param, bool reset)
 {
 	struct pm4_mes_unmap_queues *packet;
 
@@ -258,31 +256,11 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 
 	packet->header.u32All = pm_build_pm4_header(IT_UNMAP_QUEUES,
 					sizeof(struct pm4_mes_unmap_queues));
-	switch (type) {
-	case KFD_QUEUE_TYPE_COMPUTE:
-	case KFD_QUEUE_TYPE_DIQ:
-		packet->bitfields2.extended_engine_sel =
-			extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
-		packet->bitfields2.engine_sel =
-			engine_sel__mes_unmap_queues__compute;
-		break;
-	case KFD_QUEUE_TYPE_SDMA:
-	case KFD_QUEUE_TYPE_SDMA_XGMI:
-		if (sdma_engine < 2) {
-			packet->bitfields2.extended_engine_sel =
-				extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
-			packet->bitfields2.engine_sel =
-				engine_sel__mes_unmap_queues__sdma0 + sdma_engine;
-		} else {
-			packet->bitfields2.extended_engine_sel =
-				extended_engine_sel__mes_unmap_queues__sdma0_to_7_sel;
-			packet->bitfields2.engine_sel = sdma_engine;
-		}
-		break;
-	default:
-		WARN(1, "queue type %d", type);
-		return -EINVAL;
-	}
+
+	packet->bitfields2.extended_engine_sel =
+		extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
+	packet->bitfields2.engine_sel =
+		engine_sel__mes_unmap_queues__compute;
 
 	if (reset)
 		packet->bitfields2.action =
@@ -292,12 +270,6 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 			action__mes_unmap_queues__preempt_queues;
 
 	switch (filter) {
-	case KFD_UNMAP_QUEUES_FILTER_SINGLE_QUEUE:
-		packet->bitfields2.queue_sel =
-			queue_sel__mes_unmap_queues__perform_request_on_specified_queues;
-		packet->bitfields2.num_queues = 1;
-		packet->bitfields3b.doorbell_offset0 = filter_param;
-		break;
 	case KFD_UNMAP_QUEUES_FILTER_BY_PASID:
 		packet->bitfields2.queue_sel =
 			queue_sel__mes_unmap_queues__perform_request_on_pasid_queues;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index 3c0658e32e93..131f685acf41 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -197,10 +197,8 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 }
 
 static int pm_unmap_queues_vi(struct packet_manager *pm, uint32_t *buffer,
-			enum kfd_queue_type type,
 			enum kfd_unmap_queues_filter filter,
-			uint32_t filter_param, bool reset,
-			unsigned int sdma_engine)
+			uint32_t filter_param, bool reset)
 {
 	struct pm4_mes_unmap_queues *packet;
 
@@ -209,21 +207,9 @@ static int pm_unmap_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 
 	packet->header.u32All = pm_build_pm4_header(IT_UNMAP_QUEUES,
 					sizeof(struct pm4_mes_unmap_queues));
-	switch (type) {
-	case KFD_QUEUE_TYPE_COMPUTE:
-	case KFD_QUEUE_TYPE_DIQ:
-		packet->bitfields2.engine_sel =
+
+	packet->bitfields2.engine_sel =
 			engine_sel__mes_unmap_queues__compute;
-		break;
-	case KFD_QUEUE_TYPE_SDMA:
-	case KFD_QUEUE_TYPE_SDMA_XGMI:
-		packet->bitfields2.engine_sel =
-			engine_sel__mes_unmap_queues__sdma0 + sdma_engine;
-		break;
-	default:
-		WARN(1, "queue type %d", type);
-		return -EINVAL;
-	}
 
 	if (reset)
 		packet->bitfields2.action =
@@ -233,12 +219,6 @@ static int pm_unmap_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 			action__mes_unmap_queues__preempt_queues;
 
 	switch (filter) {
-	case KFD_UNMAP_QUEUES_FILTER_SINGLE_QUEUE:
-		packet->bitfields2.queue_sel =
-			queue_sel__mes_unmap_queues__perform_request_on_specified_queues;
-		packet->bitfields2.num_queues = 1;
-		packet->bitfields3b.doorbell_offset0 = filter_param;
-		break;
 	case KFD_UNMAP_QUEUES_FILTER_BY_PASID:
 		packet->bitfields2.queue_sel =
 			queue_sel__mes_unmap_queues__perform_request_on_pasid_queues;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b6790a637f5c..5989b5df8402 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1246,10 +1246,8 @@ struct packet_manager_funcs {
 	int (*map_queues)(struct packet_manager *pm, uint32_t *buffer,
 			struct queue *q, bool is_static);
 	int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
-			enum kfd_queue_type type,
 			enum kfd_unmap_queues_filter mode,
-			uint32_t filter_param, bool reset,
-			unsigned int sdma_engine);
+			uint32_t filter_param, bool reset);
 	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
 			uint64_t fence_address,	uint64_t fence_value);
 	int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
@@ -1276,10 +1274,9 @@ int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues);
 int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
 				uint64_t fence_value);
 
-int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
+int pm_send_unmap_queue(struct packet_manager *pm,
 			enum kfd_unmap_queues_filter mode,
-			uint32_t filter_param, bool reset,
-			unsigned int sdma_engine);
+			uint32_t filter_param, bool reset);
 
 void pm_release_ib(struct packet_manager *pm);
 
-- 
2.25.1

