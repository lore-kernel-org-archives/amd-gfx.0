Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E279FC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFA1613F7
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFA1613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101B66ED85;
	Thu, 29 Apr 2021 07:54:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CFB6ED84
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhjohAbt/SzAEa6lGbT7i7kU4zrwaAGrr+lZolKLpdxdEW2zg7SSJOV1PtsZXuOjDUe6O/JmBV/Wal9GfZsir9DFaqU8XypJsvrIQRNSXs61plczJce0ftuoByy2BwEHlCuj+G0RIM5aklytG4caa2zNQ6oClAnSixHAASp34//IfRBk9TIOY6/vR6nAMOAgFh0iG3Ho4crCXlFXfwhIqOuVJK+ccoMkmT6780iBIvpD+W8HVWSZAyLjpIbQBySWXgSQIxNZxPbchYER5SEsjLD2w1YgRCJEoCdFGUyVjbf8sW+cOP60++8P2KFu9kLD8KBLnQswrzADh6pyR3W7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJo5b60VrM6s3iJMh5BrboFdwIvwd5bRidCZmWLUtAY=;
 b=nq3P6IFBoK7+9ojXKIDYr0jbXdx50Iqz4kgyKQ/7fxEf0GbxMiQv2CuE+osgNBOo/D3HFYXAYhuV9h+Cu+IIBX5HpUghsMFmBwXCFwlgGzuF5/vuXVz5M/O8I/YXV+E/Lmfqsq1j4jJEtjzI9s5dYn0z+xQT5DU8EbHiXizygrh1BWvN6tU/Le+lqIHkAj2dtBzDitpzQUiKzlPnyb5lblbt6gyi/q3e3kExvSpTyc3ntPVgjTcX+X8SwIFq8zxynzCHtBqKNm/d2IkjHAbBzWciVhwy8AYcD2L7Cb/zYsmzQGYasADDvtQ1wN0eaynj8MrQKxX/aC0dty76NSLeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJo5b60VrM6s3iJMh5BrboFdwIvwd5bRidCZmWLUtAY=;
 b=d7QcIX3oOFcaR6C3cJS3/wTBSbhE5bV5X1DkyAysd0HMcPzZm4fKacrnMUZTaEit5ilmTMFdU4R3o5//L63VZUT1XIeTcKE/E8OyMOx7Tzu0SNltw39OExq6swzPqfwdw1zf2JvicFeV9tCJfiGskSbJBl2q+hLeKXL7FwMbdts=
Received: from DM5PR21CA0002.namprd21.prod.outlook.com (2603:10b6:3:ac::12) by
 BN6PR12MB1153.namprd12.prod.outlook.com (2603:10b6:404:19::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.26; Thu, 29 Apr 2021 07:54:32 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::b) by DM5PR21CA0002.outlook.office365.com
 (2603:10b6:3:ac::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.1 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:31 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:29 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: Add audio support for DFP type of
 active branch is DP case
Date: Thu, 29 Apr 2021 15:51:59 +0800
Message-ID: <20210429075206.15974-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e371d596-1891-4efd-db08-08d90ae4067a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1153:
X-Microsoft-Antispam-PRVS: <BN6PR12MB11538A1A51312EFE65E889B4FC5F9@BN6PR12MB1153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CkQTCtp2uAPyzDXlqH4LSY3gGh/eyTiTfeT/qGt17jsdzSC9mIl/wL+yHHUiwf7WcXhMugK7sVqPBA9jS1Jc4ny38kCUUtVUHBIq7U3eJjfq4lhArvYHfs2k53M6UJiLIShF3c3TS5bHO8U35uDVgRW/hxZ6cGQmtZacTn0uaxKjsMWUX0GmZiZ0vvmYh677QvNoQh08fM9Vui5Q2WYX5Sl52BNeTfpha5wmombp8YXcZnUb1vYKOF27D0Sak6sQWZTxFS6d6fgv7J1tz/J6tO9uK4vk03u1rzPlch/VfjPrlZjr1HnTE6riLiU6OjiUJq5UsuCwCpBFvv9q7PZMmq/km7rIgzlRj2oWs/0+Jpg0PpWPldjy9ZYJI+HQPp9wUPR7BhXYsCLjuTXV2JgpkTIOX/4rSrq1l68GKKSzh6OSlvbWR5tdaOVN7s0AgIwLFdQeLrvpIcNMJGSLoEvpGMQoQ9Vz5raq2oWpMnhMQbmNDYBqs4Vt1sFmeIPdZAJPkDarZmpZ383A/o8pAVtvTs1Unf74HzM9DAk82ly/L7byGGAsmk6vlSM7uqYcZtvH/OR7aJLpgSLfXTlbFyrBVh05YjsCN7WpByR4eUKPgHFaHatkercrgGcVdyXrPMqInNLi+wA3x6g2C1rV62TucGkhTNNUuNwXsVnHkLSmXbhuwAlr+WnImmvf93wMcWa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966006)(36840700001)(8936002)(47076005)(82740400003)(8676002)(186003)(316002)(426003)(70586007)(70206006)(54906003)(26005)(6916009)(2616005)(356005)(81166007)(478600001)(4326008)(336012)(83380400001)(86362001)(7696005)(6666004)(82310400003)(36756003)(5660300002)(2906002)(36860700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:32.6132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e371d596-1891-4efd-db08-08d90ae4067a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1153
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Dale Zhao <dale.zhao@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[Why]
Per DP spec, for active protocol convertor adaptor, DP source should enable audio
for DFP type is DP, HDMI or DP++. Current is_dp_active_dongle() checking is not
precise, which treat branch device default as active dongle. As a result, we will
mistakenly disable audio for DFP type is DP case.

[How]
Make is_dp_active_dongle() checking more precise for active dongle types.
Rename active diongle type as SST branch device in case confusion.

Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c   | 17 +++++++++--------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c    | 14 +++++++++-----
 drivers/gpu/drm/amd/display/dc/dc_types.h       |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h |  2 ++
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 8bbed9c90c5d..c6b4daf00be5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -762,19 +762,20 @@ static bool detect_dp(struct dc_link *link,
 		}
 
 		if (link->type != dc_connection_mst_branch &&
-		    is_dp_active_dongle(link)) {
-			/* DP active dongles */
-			link->type = dc_connection_active_dongle;
+		    is_dp_branch_device(link)) {
+			/* DP SST branch */
+			link->type = dc_connection_sst_branch;
 			if (!link->dpcd_caps.sink_count.bits.SINK_COUNT) {
 				/*
-				 * active dongle unplug processing for short irq
+				 * SST branch unplug processing for short irq
 				 */
 				link_disconnect_sink(link);
 				return true;
 			}
 
-			if (link->dpcd_caps.dongle_type !=
-			    DISPLAY_DONGLE_DP_HDMI_CONVERTER)
+			if (is_dp_active_dongle(link) &&
+				(link->dpcd_caps.dongle_type !=
+					DISPLAY_DONGLE_DP_HDMI_CONVERTER))
 				*converter_disable_audio = true;
 		}
 	} else {
@@ -974,8 +975,8 @@ static bool dc_link_detect_helper(struct dc_link *link,
 					   sizeof(struct dpcd_caps)))
 					same_dpcd = false;
 			}
-			/* Active dongle downstream unplug*/
-			if (link->type == dc_connection_active_dongle &&
+			/* Active SST downstream branch device unplug*/
+			if (link->type == dc_connection_sst_branch &&
 			    link->dpcd_caps.sink_count.bits.SINK_COUNT == 0) {
 				if (prev_sink)
 					/* Downstream unplug */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3ff3d9e90983..ffb4f9027d5e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2593,13 +2593,11 @@ static bool allow_hpd_rx_irq(const struct dc_link *link)
 	/*
 	 * Don't handle RX IRQ unless one of following is met:
 	 * 1) The link is established (cur_link_settings != unknown)
-	 * 2) We kicked off MST detection
-	 * 3) We know we're dealing with an active dongle
+	 * 2) We know we're dealing with a branch device, SST or MST
 	 */
 
 	if ((link->cur_link_settings.lane_count != LANE_COUNT_UNKNOWN) ||
-		(link->type == dc_connection_mst_branch) ||
-		is_dp_active_dongle(link))
+		is_dp_branch_device(link))
 		return true;
 
 	return false;
@@ -3164,7 +3162,7 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 			*out_link_loss = true;
 	}
 
-	if (link->type == dc_connection_active_dongle &&
+	if (link->type == dc_connection_sst_branch &&
 		hpd_irq_dpcd_data.bytes.sink_cnt.bits.SINK_COUNT
 			!= link->dpcd_sink_count)
 		status = true;
@@ -3214,6 +3212,12 @@ bool is_mst_supported(struct dc_link *link)
 }
 
 bool is_dp_active_dongle(const struct dc_link *link)
+{
+	return (link->dpcd_caps.dongle_type >= DISPLAY_DONGLE_DP_VGA_CONVERTER) &&
+				(link->dpcd_caps.dongle_type <= DISPLAY_DONGLE_DP_HDMI_CONVERTER);
+}
+
+bool is_dp_branch_device(const struct dc_link *link)
 {
 	return link->dpcd_caps.is_branch_dev;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 432754eaf10b..205d8241c4fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -404,7 +404,7 @@ enum dc_connection_type {
 	dc_connection_none,
 	dc_connection_single,
 	dc_connection_mst_branch,
-	dc_connection_active_dongle
+	dc_connection_sst_branch
 };
 
 struct dc_csc_adjustments {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 3ae05c96d557..699de64a7e44 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -75,6 +75,8 @@ void detect_edp_sink_caps(struct dc_link *link);
 
 bool is_dp_active_dongle(const struct dc_link *link);
 
+bool is_dp_branch_device(const struct dc_link *link);
+
 bool is_edp_ilr_optimization_required(struct dc_link *link, struct dc_crtc_timing *crtc_timing);
 
 void dp_enable_mst_on_sink(struct dc_link *link, bool enable);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
