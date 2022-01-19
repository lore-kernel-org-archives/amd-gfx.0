Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9711C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 08:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24ABE10E863;
	Wed, 19 Jan 2022 08:40:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 380C310E89E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 08:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fdf7GswSQhQhMeMcQueDm0GZSdcg36WHk7+qGx+D4r+nzfeCR6uWm+WmSVEYObdct/LNyNzOjaaYZVOYagRwbFkrVeDKFSInSCPPb2wVFiNbDWP9+GsHxgx8evNIa9JE8GQY8m7KP0oQtJ+G0cavLx6IsVD34wtkahCGslnB1MIpW/xBNiuUA7aSvGgqJw3zMRk5aPsh5AWx2gJKJiUZNgfSoyevGjpIg6YDvlX4rY1QXfgtvEnDWPRLqbrLQHV0upsr/J4X7YRvHT48C09vvCkyi1sWCeIdb9PP/SJFKb1iO6UkuNXZBOOCIYEdakwWBY/Q8SiEPJGDRCyYqfYxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzlPjg/R0sdLPvYmg9NVbU/x5ECtj0vtmHLVg+kWa5o=;
 b=eVz7ksuAIxxQymghPv/vnuITXKfByWRoxKnJmFIfq7NRJzVjEg5/uFEWqzIOOuheOnxfD+kYkXprVlBCJYWJ/0elqqrOqDf+zN0Vhxhyw8MA3RdsDnw3CSrmFrezBqDTGQe56AOruNDYOjGBI9/cBxnm0MLTu/Thggjh1EXjTpgl4GFMF1TQzp2hT8OYrHxuwFzuR+axeCS2T6yVjrqzGe1Tf3B0VDxVGEYzZbCtr510RgyZix0eknqYzf8GHwncePkeCE4thrAVw8U9VJkRLi+f0mULKGRI+Blu+zBPiGHQGUrFUf59D/v9LGn7r9fBYbDrKOoo/A0He8auMiJzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzlPjg/R0sdLPvYmg9NVbU/x5ECtj0vtmHLVg+kWa5o=;
 b=Dq+6I9+Y6koMskCE4SG1c9MtT3OsYJQpetYDUpiyTwrgKLz0lVgX1nsv8oVE8sPq5PNJxB/W920BCFj47huNhxX1W/H2VWtPNsYMQA5aS8YfR8/43omxCWAQQic/JWJaqVHUut83OPQ7i30sqVqFLgu+wgHT55WQaPxVUC9lguQ=
Received: from MWHPR07CA0021.namprd07.prod.outlook.com (2603:10b6:300:116::31)
 by MWHPR1201MB0031.namprd12.prod.outlook.com (2603:10b6:301:57::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 08:25:32 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::7e) by MWHPR07CA0021.outlook.office365.com
 (2603:10b6:300:116::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Wed, 19 Jan 2022 08:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:25:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:30 -0600
Received: from wayne-Celadon-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Wed, 19 Jan 2022 02:25:26 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amd/display: rename dc_link_hwss struct to link_hwss
Date: Wed, 19 Jan 2022 16:24:41 +0800
Message-ID: <20220119082443.1046810-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119082443.1046810-1-Wayne.Lin@amd.com>
References: <20220119082443.1046810-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9d9787f-22f6-4934-bc0e-08d9db25424c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0031:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00315BB6E4A73A85438BD8D8FC599@MWHPR1201MB0031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITxcXbBlXItPhcR4adMX87ZHZlrc2KN5N67FOp7Y/j0rtYeR49PnVperjTucPHBl+Qk7RRrrStcqX2/Lvs9jeEMZdboznmeKfvUnpgSaxuo2ccE0hnctk//ozPdUkvgTHPhaj0/2GNMh/BNufvOEI/jzPvVbwZQjG6R3V/lsjXOKyhGTe7IYRkUrUZFqV8GWlJdWXmxX1PnIuF4od0K3JUcJzx2j5EVYSQKRN3zW/MqGQrXJRjRfQibPri1ef3ky8qw/WkrQzS9EPj0UqvHYLAQYJUFbDATf7Uvlc2o0bNDjwhMmWK19PCB/261uQ16ZsgBuT6Rx5neGVLBPCxKld/t1LJKwe7j7Ac3WtMllGJO5ztwz/zK/OVeJ99Sccv16CVJU2C5wynyy0HS/D8Tp8j3dqhQTtWVeSHAR3fL2cvuFpAWljbOoCOTCjSakYUL3noEUM1Dfheb1N9ynlil2xPPfkcIApTkAzyzpn6u3LHzj6t4Fdnt5Gng8Tg0ipwEg0KUJC9oJRgke03eDaJ/nZyY0S49c6+w31Thm7jY8FNipBXxuHohjF2dGDWi7I8r4KL4ZQxob2cnW6nng01iC5/HDKzppVUlemAstAIua5aPY67vLlkrl468gW2hehZWxdY8GXqeaXuo3m5zwaWMzCtjXovelzfoB18EKf0hMotgy3yuNpDos/O5mo/MmjcCeO50wepYtx1n8C3ihsr1DGZrwROWV3z/qvLv1AeTH6Qi1NQmZ4uLrv9wunZk4wPtFswTD2MGq5NHJ4/TeOO2WVd0kxW1bDllv0/zBrQi8zNY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(356005)(6666004)(336012)(2616005)(81166007)(70586007)(316002)(47076005)(40460700001)(5660300002)(2906002)(7696005)(82310400004)(4326008)(426003)(54906003)(8676002)(26005)(83380400001)(1076003)(186003)(70206006)(36860700001)(508600001)(8936002)(86362001)(36756003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:25:31.9890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d9787f-22f6-4934-bc0e-08d9db25424c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0031
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
This is internal to dc so we don't have to add a prefix to indicate it
is dc link_hwss instead someone else link_hwss.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/inc/link_hwss.h     |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6e10d3e7fefa..507ed14a1eb1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3433,7 +3433,7 @@ static enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx,
 	struct link_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp;
 	const struct dc_link_settings empty_link_settings = {0};
-	const struct dc_link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
+	const struct link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	/* slot X.Y for SST payload deallocate */
@@ -3518,7 +3518,7 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct fixed31_32 pbn_per_slot;
 	int i;
 	enum act_return_status ret;
-	const struct dc_link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
+	const struct link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	/* Link encoder may have been dynamically assigned to non-physical display endpoint. */
@@ -3647,7 +3647,7 @@ enum dc_status dc_link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	uint8_t i;
 	enum act_return_status ret;
-	const struct dc_link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
+	const struct link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	/* decrease throttled vcp size */
@@ -3729,7 +3729,7 @@ enum dc_status dc_link_increase_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	uint8_t i;
 	enum act_return_status ret;
-	const struct dc_link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
+	const struct link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	/* notify immediate branch device table update */
@@ -3807,7 +3807,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct fixed31_32 avg_time_slots_per_mtp = dc_fixpt_from_int(0);
 	int i;
 	bool mst_mode = (link->type == dc_connection_mst_branch);
-	const struct dc_link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
+	const struct link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
 	const struct dc_link_settings empty_link_settings = {0};
 	DC_LOGGER_INIT(link->ctx->logger);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index c65955eafaa2..01254b4e7ac6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -864,7 +864,7 @@ static void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 				throttled_vcp_size);
 }
 
-static const struct dc_link_hwss dio_link_hwss = {
+static const struct link_hwss dio_link_hwss = {
 	.set_throttled_vcp_size = set_dio_throttled_vcp_size,
 };
 
@@ -909,7 +909,7 @@ static void set_dp_hpo_hblank_min_symbol_width(struct pipe_ctx *pipe_ctx,
 			hblank_min_symbol_width);
 }
 
-static const struct dc_link_hwss hpo_dp_link_hwss = {
+static const struct link_hwss hpo_dp_link_hwss = {
 	.set_throttled_vcp_size = set_dp_hpo_throttled_vcp_size,
 
 	/* function pointers below this point require check for NULL
@@ -925,7 +925,7 @@ static bool can_use_dpia_link_hwss(const struct dc_link *link,
 			link->dc->res_pool->funcs->link_encs_assign;
 }
 
-static const struct dc_link_hwss dpia_link_hwss = {
+static const struct link_hwss dpia_link_hwss = {
 	.set_throttled_vcp_size = set_dummy_throttled_vcp_size,
 };
 
@@ -936,11 +936,11 @@ static void set_dummy_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 	return;
 }
 
-static const struct dc_link_hwss dummy_link_hwss = {
+static const struct link_hwss dummy_link_hwss = {
 	.set_throttled_vcp_size = set_dummy_throttled_vcp_size,
 };
 
-const struct dc_link_hwss *dc_link_hwss_get(const struct dc_link *link,
+const struct link_hwss *dc_link_hwss_get(const struct dc_link *link,
 		const struct link_resource *link_res)
 {
 	if (can_use_dp_hpo_link_hwss(link, link_res))
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index 8eff386da95e..5b361924ed8f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -77,7 +77,7 @@ struct link_resource;
 struct fixed31_32;
 struct pipe_ctx;
 
-struct dc_link_hwss {
+struct link_hwss {
 	/* you must define a dummy implementation and assign the function to
 	 * dummy_link_hwss if you don't want to check for NULL pointer
 	 */
@@ -92,6 +92,6 @@ struct dc_link_hwss {
 			struct fixed31_32 throttled_vcp_size);
 };
 
-const struct dc_link_hwss *dc_link_hwss_get(const struct dc_link *link, const struct link_resource *link_res);
+const struct link_hwss *dc_link_hwss_get(const struct dc_link *link, const struct link_resource *link_res);
 
 #endif /* __DC_LINK_HWSS_H__ */
-- 
2.25.1

