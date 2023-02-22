Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F26CC61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1515410E3C1;
	Wed, 22 Feb 2023 06:41:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BE610E3C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/0iUI41AFE258YIGEFVtCHtdfrwkynFXkfj+uaGGO9DSOcbkW1uq4qgWldCgR0zaUhOlvxxyEBLPEeLvj6FQoxTTyIQXckikLlhgY4HUdYrJmb8KcyVKg6G2+Ikiihyg0qSxSrMoQaELC5ViOp6pQZ7zGW3X73RzB8BWmNcaxNoEzdU+gOVPOl+pRalPV9C7VOgcmcgd1ybUoWrbBACOZ0V6kZ+JDQHhKVr9IRUbpNE5cgs0BNzLj75JEUoeDgExUeqIq+bHtiq0k3LkRHw6Q7WSGvTzGlwVdCa6W+na9IZqBrcXaiyhnbvnPAGgCssHeVb1kfbtraHdfsIwHkLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6b4aczAQjVJabVGYNpsw18/3ZMogGlGmtGzOLQiKSo=;
 b=JJjzme48zSZQpaUC8dDc8081aT41RkpZAjwQtWewsZzzA9yhkqy8MISsUwItWjjGBEQCsDsdW8y5OWgQbW563twZKJRDj07hixTZrQjb/9KLPc8RG2wFhD0wEQC2cmuPZru3XAwBFctZPIPvI4Cp4y5QImk5QPnsD6kSAxoCUvgta/LhOSsTzm8EbO8UipA/w26dzZ0B5WpDkI+dpyyB5858ec+yjOAa1WTk5S4qUdgODdxJfeJrdMUpecKP+jEtS6mA2HoDlwjAtjhfgIGhX2CIB28GcDVGiECF8Heu7rnvNQKzBsGqEi1E/4PjaidtSBPzkbEKnqcXr2h+XQf/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6b4aczAQjVJabVGYNpsw18/3ZMogGlGmtGzOLQiKSo=;
 b=EpdiH6fnwkZxkAFBKiX500wgiPpq7vC7pHZ+E5hVsTIHAwOTmOikYRDm+uEEEbR6/JRE8sE3/6VvZENZ5eE2UN0EiHySuWLLKvCUJmiKRkMtL3Hc6PsGXkBB/MreGlaxZJklZ3NsdxGFb9hDxmKo75WJKYr4tYIRZ+5PkfWM4j8=
Received: from DM6PR07CA0097.namprd07.prod.outlook.com (2603:10b6:5:337::30)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Wed, 22 Feb
 2023 06:41:49 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::1a) by DM6PR07CA0097.outlook.office365.com
 (2603:10b6:5:337::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 06:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:41:49 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:41:42 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/20] drm/amd/display: Allocation at stream Enable
Date: Wed, 22 Feb 2023 01:40:27 -0500
Message-ID: <20230222064041.2824-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d671a1-932a-4842-466f-08db149fe014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gy1QVHVnitV9xAZI7lo6CK/Cj4krRMlTU/WrWR3YVkpd5rY9QB2r8xFqAeWrV0dyZSTyfQ8nxqJbditDIk6q23GLyy/I45duWlM/3BfgToTFcNCNLBiCUEUZmjbTrDf8TAmIZ1sCPxx8IP1Fmghq4AXOhspLq4v2THxgP3+KYsYEPHT1gL98rVA1jFD8SI5/Hj6OIoFiOpJVD2xnw7wvpRVKP6whXZz2QBezAXX8nTtuVeATWSGFJtQTzkkw8CqLzxQHkaYU6DF9LVPERx9xnFILqso6tqcxZLdIklbCPtwpKeAVqrUmqikfFM+aFiWyY8hHDuHF6U9/+pfzxgX6yoO3N4h/T5u7Ful/OjxUgNbFyVBj5iOvs8y/F+eYTLQO0Cgfn9IqG7J7/CKv0cyansG2xwMHZUnO1auRImR1tZ2dbwwfEUlWYD1QS8qMosOvNQbxq8Obw9Koee8uN6Fdi0m8nJPPHm3+Se6DUpVql2th1YvanW471UkIbH0ongLxLrccNFnStLuXq0oj6POKfghW2jGTZ3kG8rw9RHseuMTLOhytJg0TNz6TPG22GcXQzyJJ1tEdMETpmtIb/Egxrbh7DGtlvnhD/Yc9Qa1/NOSdzD4TirPShiq9YtsUK8Dzh0GQCt4vzLNa6xBklEWnT4UKiWwDMmnE6sMS131BFWdvnjGMkgAg2OxbbfW/GglMXEiHTjsm5APpKmNxKFQIWaiJX3xSVZJdsz9uYxVllqc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199018)(46966006)(36840700001)(40470700004)(47076005)(426003)(40460700003)(66574015)(36756003)(478600001)(336012)(86362001)(44832011)(82310400005)(81166007)(82740400003)(2906002)(356005)(36860700001)(54906003)(316002)(41300700001)(5660300002)(70206006)(83380400001)(4326008)(8676002)(40480700001)(70586007)(8936002)(16526019)(186003)(2616005)(1076003)(66899018)(6916009)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:41:49.4056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d671a1-932a-4842-466f-08db149fe014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY & HOW]
After we allocate BW at plug, we will de-alloc
and allocate only what stream needs at
stream_enable()

[HOW]
Introduce bw allocation check at link_enable()
for DPIA links

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 ++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 11 +++++--
 .../dc/link/protocols/link_dp_dpia_bw.c       | 33 ++++++++++++++++++-
 .../dc/link/protocols/link_dp_dpia_bw.h       | 14 +++++++-
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index cecd807f5ed8..bfe0f6877d9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -293,6 +293,8 @@ struct dc_link {
 
 	struct dc_panel_config panel_config;
 	struct phy_state phy_state;
+	// BW ALLOCATON USB4 ONLY
+	struct dc_dpia_bw_alloc dpia_bw_alloc_config;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 180c92a9f117..a1214e5606dd 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -46,6 +46,7 @@
 #include "protocols/link_dp_capability.h"
 #include "protocols/link_dp_training.h"
 #include "protocols/link_edp_panel_control.h"
+#include "protocols/link_dp_dpia_bw.h"
 
 #include "dm_helpers.h"
 #include "link_enc_cfg.h"
@@ -2044,11 +2045,17 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		}
 	}
 
-	/* Train with fallback when enabling DPIA link. Conventional links are
+	/*
+	 * If the link is DP-over-USB4 do the following:
+	 * - Train with fallback when enabling DPIA link. Conventional links are
 	 * trained with fallback during sink detection.
+	 * - Allocate only what the stream needs for bw in Gbps. Inform the CM
+	 * in case stream needs more or less bw from what has been allocated
+	 * earlier at plug time.
 	 */
-	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
 		do_fallback = true;
+	}
 
 	/*
 	 * Temporary w/a to get DP2.0 link rates to work with SST.
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index fcb82bb855ed..9d3df69fc340 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -246,7 +246,7 @@ static bool get_cm_response_ready_flag(struct dc_link *link)
 // ------------------------------------------------------------------
 //					PUBLIC FUNCTIONS
 // ------------------------------------------------------------------
-bool set_dptx_usb4_bw_alloc_support(struct dc_link *link)
+bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 {
 	bool ret = false;
 	uint8_t response = 0,
@@ -439,3 +439,34 @@ int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *li
 out:
 	return ret;
 }
+int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw)
+{
+	int ret = 0;
+	uint8_t timeout = 10;
+
+	if (!get_bw_alloc_proceed_flag(link))
+		goto out;
+
+	/*
+	 * Sometimes stream uses same timing parameters as the already
+	 * allocated max sink bw so no need to re-alloc
+	 */
+	if (req_bw != link->dpia_bw_alloc_config.sink_allocated_bw) {
+		dc_link_set_usb4_req_bw_req(link, req_bw);
+		do {
+			if (!timeout > 0)
+				timeout--;
+			else
+				break;
+			udelay(10 * 1000);
+		} while (!get_cm_response_ready_flag(link));
+
+		if (!timeout)
+			ret = 0;// ERROR TIMEOUT waiting for response for allocating bw
+		else if (link->dpia_bw_alloc_config.sink_allocated_bw > 0)
+			ret = get_host_router_total_bw(link, HOST_ROUTER_BW_ALLOCATED);
+	}
+
+out:
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index c2c3049adcd1..46d141a1366f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -42,6 +42,18 @@ enum bw_type {
  *
  * return: SUCCESS or FAILURE
  */
-bool set_dptx_usb4_bw_alloc_support(struct dc_link *link);
+bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link);
+
+/*
+ * Allocates only what the stream needs for bw, so if:
+ * If (stream_req_bw < or > already_allocated_bw_at_HPD)
+ * => Deallocate Max Bw & then allocate only what the stream needs
+ *
+ * @link: pointer to the dc_link struct instance
+ * @req_bw: Bw requested by the stream
+ *
+ * return: allocated bw else return 0
+ */
+int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int req_bw);
 
 #endif /* DC_INC_LINK_DP_DPIA_BW_H_ */
-- 
2.34.1

