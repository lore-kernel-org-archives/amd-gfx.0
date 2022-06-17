Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C02CCA479
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCDB210F456;
	Fri, 17 Jun 2022 19:36:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA0110F456
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSi9LVZ0IQn4mGbfY9nVFOw+J+jICMDljx4x8jRwtZPVix5yyopaCJbPRWk4WJA+mAc94f6P4V0uhBKnaUG5Zx3Pl8TX3E5I4IqqwV4nM5GUNECaoxOB3KKLEWkgHzuQ4ZAAHIccTkwXbohrRbmxSsV07UHtMF9q+5YRpe9RsombayTueQnHOfjadl79lV3CEjyf4Qacmk10uO2cMMsLGY2ZN6X2KgJOnoMsjwkcjv4IStCipaocKlVn1K5ARWBNxQMdiuAFtGzi9q/ew7B4K3nkmUY3yZzocvmWOLmWX47kWApdz5XJf0KKqYxbt7tI6pvpKBDmZfPPppkYl4xxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN6IIism7Dlw5o3ksfkuMD+353+fhNnrCipd+Cuh2Og=;
 b=BwhXYLD8JMTi4RpJl0517HODWX2LohZh3qoOXGki7xFtXTO6R+qvyTqyUiE6aDyIuvGX8eiSi72ZbbAuf+/hh3kD+YQGIdh2b+oMYvzAgrxksQqgpM/umxA6ub/liOAms8qG1/IevfDAD8qADkI/Fnv7zadFEw8WNwyePf/H4Fdm51gH9mJt2DWOHrMR13Js/pbyv01HRkeEZoBgTzEuxuQZSdXXREuiLtpQobPOBHMI2ntNbiXdinBMZoQg5nskbEklp/oLVK4lAiLHlBXpCUn9TQOKbsckoWg7P9peUgUp0vufc1Yz4U5vBOQloq7h3A0huzrHPoTkg8nUOt9LFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN6IIism7Dlw5o3ksfkuMD+353+fhNnrCipd+Cuh2Og=;
 b=jimgJ2fcJ/W8AiNrTXhm9MflcB59yW5M7V+Eostvkh3sv3iwIvHrtb7C5/4BBx6naDRAG3E+lJ3te1JpBFAcB17EXRtJFKGv+t/ooQLaSvB5BOYNQK1Uf5OrnAXbICYRyV838KaM3jQOl6fMlrudyHfpbdg7hwkJbr/Zlw0HpAA=
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by MW3PR12MB4586.namprd12.prod.outlook.com (2603:10b6:303:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:36:06 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::24) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:06 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/31] drm/amd/display: extract update stream allocation to
 link_hwss
Date: Fri, 17 Jun 2022 15:35:02 -0400
Message-ID: <20220617193512.3471076-22-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94f74455-8144-45ad-dbf6-08da50989f41
X-MS-TrafficTypeDiagnostic: MW3PR12MB4586:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4586D93BDE49464D67DAAB5398AF9@MW3PR12MB4586.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dT+UqxY2iwBIp4yRIx0e3yhwmWTV0yCUOb2FJKS7+99aP/Os7gbT+aa9f9bKWyNfmPALxlr2BwA84DlwNonow4ZFgywt5Oi/8eJNsxI4ApTJPRT5BhHpqORo25zR5Wd159lYgBsfjTOFIN5VoB7wi2SI4NrFceza+1P8PzCQHoeakbAFy3l+RsUdyDgdZzGxTF2tr4Ha37ZEoiM4XC5fvJAsVM2Es1qWGB69IbtzKqI/z3hrSUfINwsUpK+lshRFeVeJwN0qdFIeIyBflVpbPsFnvim0nro1y0etWaX7unrFOD+GrNzucLYDSOyIMVOo0vnqpH4ULZ7SHuzkr3TKDFfhzkBmCrupae4oip325pLjh5xDqod4aXzevz8SJe7lC/oCdmCgl7D5siqCZokFBy0g0tb0GCzVYo1NS4puR7D68E87vFSHJowhCbpLYOb0veNEs8yNb51GiPqxVcYixgMeRWCrCjpaXUYboMQLrSqDt6cwT/kAXGW2iJZS6eGBDt/fMTEU+yDbPxdQeSB83Y12ExHKkAOGvY5+h+UMrWUkRuhnDpPX1Zy1NvzVZL/4hGulC/mX1evRuhQNkXNgAmgA4cSVJ99pm7R0AWuhgjEsJOYG74PRADk1EQRCsdFPvbXdpOLevPm2ry4ZfARs8XdPqBctlh9bgub67wN9f0/wJrZmJ/6WB/z7uEwaUrid+ifsVAJHWN4idDo8QKCW+EY17Qm19V6jE8wnWw6gWqclzc/tVfw8LJZYM9tqw8/VEW62P/QeZ08+JIC+4cyNgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(15650500001)(26005)(5660300002)(36756003)(356005)(83380400001)(2906002)(81166007)(36860700001)(82310400005)(7696005)(40460700003)(70206006)(4326008)(498600001)(2616005)(16526019)(86362001)(6916009)(426003)(70586007)(186003)(336012)(8936002)(8676002)(54906003)(316002)(47076005)(1076003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:06.1459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f74455-8144-45ad-dbf6-08da50989f41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4586
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[Why & How]
Extract update stream allocation table into link hwss
as part of the link hwss refactor work.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c  | 10 +++++++---
 drivers/gpu/drm/amd/display/dc/inc/link_hwss.h |  6 +++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b021ea49bece..f327d7327f7f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3873,7 +3873,6 @@ enum dc_status dc_link_increase_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t
 	struct fixed31_32 avg_time_slots_per_mtp;
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
-	struct link_encoder *link_encoder = link->link_enc;
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	uint8_t i;
 	enum act_return_status ret;
@@ -3917,8 +3916,13 @@ enum dc_status dc_link_increase_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t
 	ASSERT(proposed_table.stream_count > 0);
 
 	/* update mst stream allocation table hardware state */
-	link_encoder->funcs->update_mst_stream_allocation_table(
-			link_encoder,
+	if (link_hwss->ext.update_stream_allocation_table == NULL ||
+			dp_get_link_encoding_format(&link->cur_link_settings) == DP_UNKNOWN_ENCODING) {
+		DC_LOG_ERROR("Failure: unknown encoding format\n");
+		return DC_ERROR_UNEXPECTED;
+	}
+
+	link_hwss->ext.update_stream_allocation_table(link, &pipe_ctx->link_res,
 			&link->mst_stream_alloc_table);
 
 	/* poll for immediate branch device ACT handled */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index e6c49ef8b584..3482a877b6af 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -62,9 +62,9 @@ struct link_hwss_ext {
 			const struct link_resource *link_res,
 			struct encoder_set_dp_phy_pattern_param *tp_params);
 	void (*set_dp_lane_settings)(struct dc_link *link,
-		const struct link_resource *link_res,
-		const struct dc_link_settings *link_settings,
-		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
+			const struct link_resource *link_res,
+			const struct dc_link_settings *link_settings,
+			const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
 	void (*update_stream_allocation_table)(struct dc_link *link,
 			const struct link_resource *link_res,
 			const struct link_mst_stream_allocation_table *table);
-- 
2.25.1

