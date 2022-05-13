Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8025C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA8510E5DD;
	Fri, 13 May 2022 21:17:33 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3E510E562
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joyCunJYZzXoNRLrwtkYhcdL3+ex63ikSIMKsztsn4l2MB4686AcFoVHxhQmj2OtwudDI7dEd7Kuzdx80EsmiaMg6mn134WWMq2s8r2YKaU4A+IYoHMqMklSJSaRWZJ/cSu++GuE3ZITfkKtNnsnqZ6+xqNfh+j93wDFquG3oYuemOfjD5ncBRofKesGs6+wdffvtjkc1iWsnxLuXNJQnxovYmkAu8WTGkThFNkQzLzbnyScoLwRFfSUENfRqoEn/rrbYWuVRw6Di4llJIB9LiCk72/7WEO2zfesrd0Ztipb4g1jE7Sck0WmcFOcTwQnEjN2+vduPu6cG/SjY9k8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAd4RyUEkqGIKZ5FzfqCNEkOvaCKU8zVG0H5AFoc+do=;
 b=M/Ejhtpis2Nieo/wcgK1xOlMdNKHoVZai4cbLf5n58JYiEgxe0oqJg05ZHUSm0hQ1xWYIV2jvRxFpgh6r74MJoJj4Sz4UTukH97WlF0fDeudIPcLlYP6QJRelmUO7FI7QMg3wGtwio1nAXdmaKiVb2nX1HZoxn5Vj73flNGzCTi3C7/kZDJDS7tGRpKXehcrcJuLDXsDNFBjAPRB0ZbNKYTsKf2ZwqCALAplZit4PZqOo89TGe1ltr6/QF+Fp0Tc7waVSVDI78/OJWGWx9vZA7qZccEtket097T1ONv9PBKNRQ5xT0+Sn/GgLw4iIKN7xphj5P4X4aURuJH3L0Oohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAd4RyUEkqGIKZ5FzfqCNEkOvaCKU8zVG0H5AFoc+do=;
 b=5iD4JanBnHvJL5VJjD3CmZ7quaDxaEzzu3qFJB9KGw+mBkvWsmY5iR6wl436ikBTNUnNpw27ddIlGXusO4GBRYMQl0Zx97bz3HTy1b+8bQPsBpolB52QmQEww7YOF1TDZUbAjW3K7oXD5W+F/8u8pe/D1PDOfuC/G/YgBjJE5os=
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 21:17:20 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::79) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Fri, 13 May 2022 21:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:19 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:16 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 02/11] drm/amd/display: Query DPIA HPD status.
Date: Fri, 13 May 2022 17:16:42 -0400
Message-ID: <20220513211651.1312846-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0ede43c-24ad-4e93-de9e-08da3525f6ba
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB491597AD332645E160F911EEFBCA9@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bh6aXBPuM/FCGn+GQ+yoBmWl6X4xum5zCF53xxYKznZF80X0YlODotOg/BMibrHzD7TyI1Mg9hLYP3eiGcbeRZCSvyA7tt3rFpeYfFNj8Fo0FpRAL+3BfNUqerU/wdspZSS0X3ULdX9U7N4JpnG9CcmuMwF3PdNddbux27c7tAmmilozl51h6+TKqOhFjRHShjdn9hCo2Vr1DFwfBV6Gd9JxTQczLFbPOEr8qjOkjydL8u5gL9HgLBGfZxTqyV3K/rV5OsdMm7OF8aXaLXkSNOj5pKTBrfCujGIjg89or79dKzofq4VX/Bf9yBCiCB5sN92vMGqu4bbZI0/tc/5NsOdpTqMPAXRmee1bNSgI4/EGuNhhLA6MAxe4uendOvTpOoMI46JYq6mafWQ0Aec5ODkWNjVm9wthoam/1s42NZn7IrqlKBTr7rkNhhZbZvJdzP/5yLLhWw/anW3U/TODOnV3tCh5ckUCPmlKf3kUK2/gMbV+FfZIro7crazWWgcP32F9Op2NzfXOWXQ665QgYrqcX1aRPYqvco0iNtcgrRV3kFwKFIZ9bUU6qPWVW8macRY8LHGNSebbRxqueYDIg6gDuy0SIO9oDoRIkzdwGY3nQ68h9bvD85k4bThEdOAzaS+gvw+LMz6tepDtSIY4Hb2t7SDiR9ajekUAYJj0IsK/ZZz+P7y55cH3cAo2i64TH6XHEUCe5A8BPdkGhb3PUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(5660300002)(2906002)(44832011)(508600001)(8936002)(26005)(2616005)(70586007)(70206006)(86362001)(4326008)(8676002)(6916009)(40460700003)(356005)(54906003)(316002)(36860700001)(82310400005)(81166007)(426003)(83380400001)(186003)(336012)(1076003)(36756003)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:19.3975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ede43c-24ad-4e93-de9e-08da3525f6ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com,
 Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Driver needs up to date DPIA HPD status.

[How]
Use HPD query command to get DPIA HPD status.

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 ++-
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 19 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |  5 +++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 67ef357e5798..b40abd2bf7f6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -33,6 +33,7 @@
 #include "gpio_service_interface.h"
 #include "core_status.h"
 #include "dc_link_dp.h"
+#include "dc_link_dpia.h"
 #include "dc_link_ddc.h"
 #include "link_hwss.h"
 #include "opp.h"
@@ -240,7 +241,7 @@ bool dc_link_detect_sink(struct dc_link *link, enum dc_connection_type *type)
 
 	/* Link may not have physical HPD pin. */
 	if (link->ep_type != DISPLAY_ENDPOINT_PHY) {
-		if (link->is_hpd_pending || !link->hpd_status)
+		if (link->is_hpd_pending || !dc_link_dpia_query_hpd_status(link))
 			*type = dc_connection_none;
 		else
 			*type = dc_connection_single;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index a5765f36d86f..1b7a8774b0c9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -34,6 +34,7 @@
 #include "dm_helpers.h"
 #include "dmub/inc/dmub_cmd.h"
 #include "inc/link_dpcd.h"
+#include "dc_dmub_srv.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
@@ -69,6 +70,24 @@ enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 	return status;
 }
 
+bool dc_link_dpia_query_hpd_status(struct dc_link *link)
+{
+	union dmub_rb_cmd cmd = {0};
+	struct dc_dmub_srv *dmub_srv = link->ctx->dmub_srv;
+	bool is_hpd_high = false;
+
+	/* prepare QUERY_HPD command */
+	cmd.query_hpd.header.type = DMUB_CMD__QUERY_HPD_STATE;
+	cmd.query_hpd.data.instance = link->link_id.enum_id - ENUM_ID_1;
+	cmd.query_hpd.data.ch_type = AUX_CHANNEL_DPIA;
+
+	/* Return HPD status reported by DMUB if query successfully executed. */
+	if (dc_dmub_srv_cmd_with_reply_data(dmub_srv, &cmd) && cmd.query_hpd.data.status == AUX_RET_SUCCESS)
+		is_hpd_high = cmd.query_hpd.data.result;
+
+	return is_hpd_high;
+}
+
 /* Configure link as prescribed in link_setting; set LTTPR mode; and
  * Initialize link training settings.
  * Abort link training if sink unplug detected.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
index 74dafd0f9d3d..39c1d1d07357 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
@@ -87,6 +87,11 @@ union dpia_set_config_data {
  */
 enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link);
 
+/* Query hot plug status of USB4 DP tunnel.
+ * Returns true if HPD high.
+ */
+bool dc_link_dpia_query_hpd_status(struct dc_link *link);
+
 /* Train DP tunneling link for USB4 DPIA display endpoint.
  * DPIA equivalent of dc_link_dp_perfrorm_link_training.
  * Aborts link training upon detection of sink unplug.
-- 
2.25.1

