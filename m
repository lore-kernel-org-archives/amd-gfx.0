Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2DAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357AB10E795;
	Fri, 13 May 2022 20:51:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED9710E565
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOnArh5C3HM3wgGBcCBUPoNJ/m1oG+9l/aLfwdOLP6DPL8NGu3dmUVErJzzYMsioCs4mGsEWRHfkm/0uGA2/YjBgC8Wztmlh6DbpDdxZ1MxoQzDqs3PpuLSY0BK9N6nFfX20MtcgN1oJeQInYJcmxlpWpnPww4lDmTYgQnaY4v+Yxb3hCqnPMfifWih47tzHnFk1w2zJqOIOCdc+WSEeY00yXpRqrwjJeCuR8VZ9xTZl1mU0h8ONPsth50Uh/N1mND9AW1SwRE62sSlTlERLUTZKhBjawncJNNNwYJHD1eLus+E4dN6BS80TSwFn1HIrMPeix8vPxPiZpgeAuRTh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAd4RyUEkqGIKZ5FzfqCNEkOvaCKU8zVG0H5AFoc+do=;
 b=htHJ1J1UhsdHFt0ZUJX9KkjGYVZ8QQrNsBjsHSl3sVb/JzbnWjtEg496/XBXAzdPN4NB3OL6KM5QQ2l2i/n1XQ5+CifKmPcOJcGmHFjxNBJIquu6tkBtF2MPdLBhPtV6dIGYsrBSlb/NOklTZR4gPkHgO8iZdFGZdK8cWDY+u2DkqOZY3XnSsW4ac432WKVRf6oc5ByoMRfkP0oTp0NEgOelEYyQ7Lr9MIg6ftTdfYOKAlWH4sZTITj9c7Xf8uYqyohd0ujT+5hWlJfRy+Yl/EQOaO+pZRu451E/9B+gzfDrwSokHui9+oOmJGqhclbMGRexA6xFqykxnBBGnxaX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAd4RyUEkqGIKZ5FzfqCNEkOvaCKU8zVG0H5AFoc+do=;
 b=EhrJG4YWm/YccuOoG83Fbh6zIQP5oRhXRb8dhJ5fR4G9/+axtyNGXSSmdDeuRP9M8GpfZOw6/x9Bd1iDRKAb2NyPZAQzFQcpNMnA9maIpecI27Dtrp8DkqVyZV/YlvVRgZUBtUPoicnfZY111pDLHAuwAwJ7tWOehwsgHE9ybns=
Received: from MW4PR03CA0272.namprd03.prod.outlook.com (2603:10b6:303:b5::7)
 by DM5PR12MB1468.namprd12.prod.outlook.com (2603:10b6:4:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 20:51:27 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d6) by MW4PR03CA0272.outlook.office365.com
 (2603:10b6:303:b5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Fri, 13 May 2022 20:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:26 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:24 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amd/display: Query DPIA HPD status.
Date: Fri, 13 May 2022 16:50:32 -0400
Message-ID: <20220513205041.1311639-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
References: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3955559-51ff-4cbc-6140-08da35225920
X-MS-TrafficTypeDiagnostic: DM5PR12MB1468:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB14687F524346C0EFCDA1EFBAFBCA9@DM5PR12MB1468.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jE3CEkrPWXfJhufkjK9DorHBYjZ+nUoxW9Dg8OrBgm/IiSjyqlKHwwGBZIn0Io5TuZyAGwaWG5w8If5zyU7vbymfU1v+1lp4pN8DBPMVnNzQDfVO4q6PQvQPebXRIEjKcVacWbUsFBTRIvghey/J1mYQm56fAilIBgC5I1hUtWduO3mtSC5x/j1AVeYwkc9aiShHmfhFdLOP8McQcNg5kN7UIh4BYYquG9lfecowutnP95sqmriBEKJKW8D8MOti5a9Czpdw5yyjeisJUxaYpQBZ6SJxdpgLIYl0QCD5N3NuA2+UfWY4OZ+kotB94YYUG9iyh48kvssWWMru8VC1DAMbuaX6OwmBsRT277jAtczLvDpcyz4ln4Mcpau7q1umDEtQbwsNmHkmts6/PjBAqVpilYzpM3WLkFsLsdX1/GgbkPYvVBD/6a8eALKjKNDynUSl+flpo1gnUKBKk8rDBZD5s2ORFYURg2vLCLTSZzzwctChyt34QgGobS8RsFkn2xbfNo9FsxStsm6WDweNnt/7T2Nr0O8r6PNt6FJ1+4TqMqQvKPZBIy3OffnEmGcdf/4EPVOz2feOZ+BEhDwSJj6Lef3CdGv7O27o1LGA6m0CXyxARpOA/Bul+W5uVYd2FJxsIJtjGEpHOAicYfq+hAV1htb3Nbh2cylUoNWOaR28izKGAmtL7LvoLMSog8jEJ77fxHrxNn7w5SH7vVVSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(426003)(336012)(82310400005)(508600001)(44832011)(86362001)(26005)(316002)(5660300002)(36756003)(16526019)(8936002)(186003)(1076003)(2616005)(6666004)(83380400001)(8676002)(2906002)(4326008)(356005)(36860700001)(54906003)(6916009)(70586007)(70206006)(81166007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:26.4926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3955559-51ff-4cbc-6140-08da35225920
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1468
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

