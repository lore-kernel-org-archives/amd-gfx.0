Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B54CCA47C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A115E10F400;
	Fri, 17 Jun 2022 19:36:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A65610F454
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyxG5gqKSe3D3pc6j1qGbY6N8HOrH8KsVoqqVR8RZaoq4M8DECmy0pI+Iag1etIGXrqnu2BT9jmclqSWrFgmq7Uy8TXjmT8l9EUUSM6zDrWi+xbg8WMczsRZSLKkVFKTt/yFKEwW8ux/J32YX7tgBAMKd6vwdnEzYUpXcKNlDFXpg4JbIxrmSJmeNkQioi9qZ04nx3qCY81OG+L12vL2TP5YW5KlXYeS5iyi0ymCPo0/ViZySXP/PgOTDc6H0QWVeJ/HcK27jHujOfAhazYXMB+lAH1vqogt2IJFMo90/qEWZIdXpxxoZ0kWuq0/nDCS/Kp52FQtixrxNC0EBlAtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwxoYZBdiCZmuaI4qOxRxmZlVvX1HQ62/nxMFSEVHAM=;
 b=XyADBr2gmVLJ/tOxMc5gdh3K0VfUbFUXRtIg+s3xecv6wlSV4SPPUw3poLPTuLrc+XpsnMcKbXm9j7X3lTdAM3yYsWTyibosV7YzJ113qoXlO8Cx/f2IdE9i8fmsOmtKq5mcml4Jhgj0moarWEeeaOCd3Wv1JUtgZQmbO8Zj/H4ie6ePXbUagn77DRSwBtR5Hp1N7fK+/ju7PDe24BBn4pA7ZoWuQfenoUVuhORVS4kEQtilEtxxNA+G3cGHI6T9BNwMMd2uzRx84usw7iZvQZ08hZlqBYnoOMfZciyUQe8hEiBLZ6SH8yoUccobBHnpl2/kHUUISJEDla9j/iXA1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwxoYZBdiCZmuaI4qOxRxmZlVvX1HQ62/nxMFSEVHAM=;
 b=TJ2OPDmtbpMtt/aclI3lstoGb0ShFADgdJW4oe6rz7lSeEMSYwHF1ZdMr0GNxKM5ZzFkFoj//lf+KLXikNFliaSXzjdCIYgixFh4Ik/9QyHOk9rOWKf98k/iLX5+C49TRvUTU431Y690FUfoazJ/zJ0UNE/Qwg7zLFC1Ko87YKE=
Received: from BN9PR03CA0753.namprd03.prod.outlook.com (2603:10b6:408:13a::8)
 by DM6PR12MB5566.namprd12.prod.outlook.com (2603:10b6:5:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:36:06 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::87) by BN9PR03CA0753.outlook.office365.com
 (2603:10b6:408:13a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
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
Subject: [PATCH 22/31] drm/amd/display: Fix in dp link-training when updating
 payload allocation table
Date: Fri, 17 Jun 2022 15:35:03 -0400
Message-ID: <20220617193512.3471076-23-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5b7c3ef9-f0d7-41b4-9e91-08da50989f65
X-MS-TrafficTypeDiagnostic: DM6PR12MB5566:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55664C7FA245171A7A574AC198AF9@DM6PR12MB5566.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gt6QA5Fhbjt3W0Bj0ja4uyQ1san5jfeYoOCpCD7QwmTP+0OGT4h9F/5oOPlJeqUNAbS03Xie4ysyC6Ct+x0SE2sVby4VyIrClSvaBo084fzVsWYYnSYhf4kagwEotfn2Sz11VVuDehsUtGbYiIqIFoPB72W79u5aqR1yERfAP1qff043crIl0CxmAlydmsgOsXI7KBiJf+D9vnobNt6IhwekhnVeMpGcWe+ho4x7/sYaTtaudw3wCiSg51KGfHBR8itssOt7jycBMozHQAaP/aSra3IBXye9VShQ2QLqpAIvZXZ8k0H0ozPvyLjDtF/6OjtIS9zG0qVXRas9cza/nw2tL73iksRkw5COorR0Db3lZqXBh+B+vzjg9+FIsF/JTEL1U2F0ig7AJ3CCORQF5YHn+BEehh0ANp+XV/MUvUcLhDlN3dnO8r1IoeAO9+5kisSwGSwHW134Z2hAUsdf0Toz+MfIylF9Hsn9mGR+RFXXmlqaEgK0ZUWikZnppLoKubsWmC2Ixu0TPl8VxZTdHhascDaSfPdcxXMSvGtXFFmbPY/jiVO+WLr7MfiJ220DKycrCeZ9cy3msXcGwyzVsJyfhwK3by1HUmmy/s3O596Ly5s+lBPjWG/rpZKqgwdaO8d1dQ/sVXp6FOl77xgWieenlULu2Vv9IHhHIVZc7l1rAoZShDZd9Tl1PU+WXrxqnNd4q9N0CkUji71FAkqMXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(426003)(2906002)(36756003)(81166007)(36860700001)(356005)(26005)(7696005)(86362001)(40460700003)(70586007)(54906003)(6916009)(498600001)(336012)(316002)(1076003)(186003)(16526019)(4326008)(70206006)(6666004)(8936002)(2616005)(8676002)(82310400005)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:06.5209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7c3ef9-f0d7-41b4-9e91-08da50989f65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5566
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why & How]
Check if aux is not accessible before updating payload allocation
table.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 76233db6876c..4027f439a5a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -6823,6 +6823,13 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
 		/// Leave req_slot_count = 0 if allocate is false.
 	}
 
+	proposed_table->stream_count = 1; /// Always 1 stream for SST
+	proposed_table->stream_allocations[0].slot_count = req_slot_count;
+	proposed_table->stream_allocations[0].vcp_id = vc_id;
+
+	if (link->aux_access_disabled)
+		return true;
+
 	/// Write DPCD 2C0 = 1 to start updating
 	update_status.bits.VC_PAYLOAD_TABLE_UPDATED = 1;
 	core_link_write_dpcd(
@@ -6890,10 +6897,6 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
 		// TODO - DP2.0 Payload: Read and log the payload table from downstream branch
 	}
 
-	proposed_table->stream_count = 1; /// Always 1 stream for SST
-	proposed_table->stream_allocations[0].slot_count = req_slot_count;
-	proposed_table->stream_allocations[0].vcp_id = vc_id;
-
 	return result;
 }
 
@@ -6909,6 +6912,8 @@ bool dpcd_poll_for_allocation_change_trigger(struct dc_link *link)
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
 	union lane_align_status_updated lane_status_updated;
 
+	if (link->aux_access_disabled)
+		return true;
 	for (i = 0; i < act_retries; i++) {
 		get_lane_status(link, link->cur_link_settings.lane_count, dpcd_lane_status, &lane_status_updated);
 
-- 
2.25.1

