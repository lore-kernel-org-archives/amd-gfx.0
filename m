Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CFEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C32910E3A4;
	Thu,  5 May 2022 14:23:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2399F10E158
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aaq2wDiAY43wiygjag6evs/NSpk+40v9d7CaibBzomYaSOPyeEfLFpKEk3Wnd9NtmfHms0vFfUQOPAEFWfNbLV1jqqZjzkmQnzmzpztfKjoCUUYOQKuG8JscwSlXoESnGWZ5B7P7QtMk8X2oLw/rdBJejsWLnODuOd0ww17FSIZpO4iyjCSp+vGCTOjBZn1ubG09Tp/+fmLshspifjuTvU4cnh54iDuM/86Oc+soGKb1ONGqbGAa7ri6v9+96kGTbW4wgIES/24RAJpaDhFHZzJjHX/6wXgc8hk6bhwaol680xhVMw1QZf8zrjQL3fWjhTZLejSb1UzyM4pu08eVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDEZiTzmBJO89h6oXfGJFs+5W3yKesEMKcBUwVyD2PA=;
 b=T1/wTYjpsyMy6t4Neo4aFtXiD29HdScOjjYgGfRX1QERWp2Rr9hpYjWYOeC4ZJIigSCaMnTvWDo1ehS7LkGg1QpbsOhTX8txS75aVVjFbQWXXTbFIzCr6GbKBgRG8decD2cEfNJBgoVvWALv461tVcKiQe7ZBvUupQpin6WxwOX2CVCwVVw9vMPmPzs6UyOU0BFDWaIwIDHgKMUk+JnlKV6VVQGXLx0e051aOUioTt9q0P8Dju4kfBwzprOigMok9R+vIorRIQzser8p+S+H21/Fx849h9Wtf40fvO4iruvCegbF4/Q99JyEBDNu+Tqy8qIRubNnM/X4XX/ldSDPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDEZiTzmBJO89h6oXfGJFs+5W3yKesEMKcBUwVyD2PA=;
 b=3O7JUrbsDCLubWL1tZxxPNO2Vkr0Bca+rtX/t55zp60AadnyoCc/NA05G/pWY1hbG/YFSgNwBOL6iVugkU8mWgcEVwg4bJQxRLEhykdGoZ2ugRjg5yLW3lBSsatckGhDmq4U5rPCBas3ARoS7lHaH0VFBCcH1ZMKDuJ76uAqsg8=
Received: from DM6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:40::29) by
 MWHPR12MB1373.namprd12.prod.outlook.com (2603:10b6:300:14::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.25; Thu, 5 May 2022 14:23:49 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::a0) by DM6PR03CA0016.outlook.office365.com
 (2603:10b6:5:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 14:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:48 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:45 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/17] drm/amd/display: program PSR2 DPCD Configuration
Date: Thu, 5 May 2022 10:23:12 -0400
Message-ID: <20220505142323.2566949-7-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ab6b855-a149-4d73-762b-08da2ea2df01
X-MS-TrafficTypeDiagnostic: MWHPR12MB1373:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1373F603D726C44BC6700E038DC29@MWHPR12MB1373.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bu/mAXsYvZeUfVOtjkQZsZxMxLXVxnIegcitBMcDzeIjvGE9o5/pVdQdUWEoWop5ut6jKh+TaY+3Tq8BZ8j/FnXvZ3SzN6f7u5pHcnjpcqTOMCxrj/8H+gM/8PK2yson6BRypjTN74uUtsqVWZ0BFA190wOffdCsqfAxpiRWZ49EcF/TjSjbWpfQ6O2xYxBiFLCAMAvbkvgadBQdBsI0dZoROUsYlgtVIKEqoX2hyhHRtB0hfE2+t2q9uOyVz4prjDPDphsxY0MTlO8qQ5CljBCxzSAa+SjrP6tbgbL/fa3pT0S94ssvHFFRe7adkpB4ogI/7N/MJZ9Wy+8Z6JKgO8TdZbUM9xbNqR6zK5syPAN6p6c5mF44SzBmejCqyExvd16GGO+CSYdLqfZtIBXApN2TGw/4LbA7l0Hm8FkL0qEZMRZzu/a/epz2D5DE7aqbEQdNAiAobcoQvZNg5r3D17yLWBhga5zL6ZZDchN3nEJwHVjNQVYQ6N8Y8hwXH53LJQ8zuD6SdAg+AwqoHc79gVHhyRwkdewIdA12NNHOynH7PK3EPpvRRTgNezw5Oc3AnIsIgHfc/j/pEIpLXly/8nmyVLK5LplOI4sJLOigWUvCd7/SXITC4WuflM4ghnBCbcRlNLdtWcidVKlYy5OR4y9CAGX5yNUBEaC/K9rzrEf7EyOGpKCG6mdh6ucfW9WcrrannnC/7+oTpa/EZy7ewQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(336012)(426003)(2906002)(83380400001)(26005)(40460700003)(6666004)(7696005)(70586007)(81166007)(70206006)(36860700001)(8676002)(4326008)(8936002)(36756003)(82310400005)(356005)(54906003)(6916009)(2616005)(16526019)(186003)(316002)(5660300002)(1076003)(508600001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:48.6403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab6b855-a149-4d73-762b-08da2ea2df01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1373
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
To support PSR2 Source DPCD configuration

[How]
Update the PSR2 Source DPCD settings while the PSR2 enabled

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 23 ++++++++++++++++++-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  | 13 ++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3d13ee32a3db..b1811eb7609f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3181,6 +3181,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 	unsigned int panel_inst;
 	/* updateSinkPsrDpcdConfig*/
 	union dpcd_psr_configuration psr_configuration;
+	union dpcd_alpm_configuration alpm_configuration;
 
 	psr_context->controllerId = CONTROLLER_ID_UNDEFINED;
 
@@ -3206,7 +3207,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 			psr_config->psr_frame_capture_indication_req;
 
 	/* Check for PSR v2*/
-	if (psr_config->psr_version == 0x2) {
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) {
 		/* For PSR v2 selective update.
 		 * Indicates whether sink should start capturing
 		 * immediately following active scan line,
@@ -3217,6 +3218,14 @@ bool dc_link_setup_psr(struct dc_link *link,
 		 * IRQ_HPD when CRC mismatch is detected.
 		 */
 		psr_configuration.bits.IRQ_HPD_WITH_CRC_ERROR    = 1;
+		/* For PSR v2, set the bit when the Source device will
+		 * be enabling PSR2 operation.
+		 */
+		psr_configuration.bits.ENABLE_PSR2    = 1;
+		/* For PSR v2, the Sink device must be able to receive
+		 * SU region updates early in the frame time.
+		 */
+		psr_configuration.bits.EARLY_TRANSPORT_ENABLE    = 1;
 	}
 
 	dm_helpers_dp_write_dpcd(
@@ -3226,6 +3235,18 @@ bool dc_link_setup_psr(struct dc_link *link,
 		&psr_configuration.raw,
 		sizeof(psr_configuration.raw));
 
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) {
+		memset(&alpm_configuration, 0, sizeof(alpm_configuration));
+
+		alpm_configuration.bits.ENABLE = 1;
+		dm_helpers_dp_write_dpcd(
+			link->ctx,
+			link,
+			DP_RECEIVER_ALPM_CONFIG,
+			&alpm_configuration.raw,
+			sizeof(alpm_configuration.raw));
+	}
+
 	psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
 	psr_context->transmitterId = link->link_enc->transmitter;
 	psr_context->engineId = link->link_enc->preferred_engine;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 2013a70603ae..66132f3cac42 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -85,7 +85,18 @@ union dpcd_psr_configuration {
 		unsigned char LINE_CAPTURE_INDICATION   : 1;
 		/* For eDP 1.4, PSR v2*/
 		unsigned char IRQ_HPD_WITH_CRC_ERROR    : 1;
-		unsigned char RESERVED                  : 2;
+		unsigned char ENABLE_PSR2               : 1;
+		/* For eDP 1.5, PSR v2 w/ early transport */
+		unsigned char EARLY_TRANSPORT_ENABLE    : 1;
+	} bits;
+	unsigned char raw;
+};
+
+union dpcd_alpm_configuration {
+	struct {
+		unsigned char ENABLE                    : 1;
+		unsigned char IRQ_HPD_ENABLE            : 1;
+		unsigned char RESERVED                  : 6;
 	} bits;
 	unsigned char raw;
 };
-- 
2.25.1

