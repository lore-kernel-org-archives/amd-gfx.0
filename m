Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322C5C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF4510EABC;
	Thu,  6 Jun 2024 21:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QgsmUHSV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627E110EABC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxFHvoD3eDvy6IQTi5u9ugGD9OzYb+1z+fQ+B+JcuK94GL72USoWQKGzKneWBbJqCS+FOgF/yIEg/4elKkNfvUWXcp4C6kPSmYjNORlkgIfT4eNmgb+Vc7PL0roXSsng5BI8eakk4JyORh0MomWOrvtmO3/FSc1+fHeYDaXuEpVZS0f9/xhwD0BpieG95Xv0AieLfoI+dQ5kWKB3AQrZpHi7gjdLiN2b7ZacO0EzjXOP0Yxb+CDbsFuhtL67abJxQUpAOk7go3a2a/Vb2yoq5C83eDExUDWUSRJN5A3SkN+H6kXEn3TjeeHZdBPNe6fjinTHpGyOuLnKlRLdW9XFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVcr0MVV2RRLpAi+PS6r9UBy4axNBoGv8L4w+XnziEo=;
 b=VRsf+wJt8KPxEuS5pfXWLKod1oXSMHRo55LpuJzd+FtoxQuq7vneOgFAHoBN+Y3UqzntDOB2KCQP3JVjgSY73x5Ftyi9iPBknK8JQnYxB0G7FnQ1DluO8CP6IJI4LnlWN4BhelhvpRHmfHHzbbR0vNU1ABpouoiE5++1Zh3MCZEuvgTrcLmwWRjOhFNxo4qhXCaaFBgfpZfvKvFlYQ/aAWwm4DCbBZ4zWB7V+O1UIZ18JQT6VOeOhyV/96QHLP0/vEWCrz3SeIkgice/CaEOJaiQE6+LRpVfWY48U4N1ZyTpSecgT0br+URqUb0fpv2tGT6vjE2oeaSzqHDRWMxeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVcr0MVV2RRLpAi+PS6r9UBy4axNBoGv8L4w+XnziEo=;
 b=QgsmUHSVNA1n40RLzdTI/wBmz4M1u3Otkh296EtdDck4ZJiYRb1CFnwlH+3AnT2QD6Sy/S6RthX6F8NzVmFUxF7yCZuJa9FLXpidY6xur/WYv7FjvXimu8brLR71YAfmVkpkaRgypve785iyejXJ1fssR5Uv48kDiAOVDapPtA4=
Received: from MN2PR20CA0065.namprd20.prod.outlook.com (2603:10b6:208:235::34)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:56:56 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::76) by MN2PR20CA0065.outlook.office365.com
 (2603:10b6:208:235::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Thu, 6 Jun 2024 21:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:56:55 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:56:54 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Leon Huang <Leon.Huang1@amd.com>, Rodrigo Siqueira
 <RodrigoSiqueira@amd.com>
Subject: [PATCH 03/67] drm/amd/display: Expand supported Replay residency mode
Date: Thu, 6 Jun 2024 17:55:28 -0400
Message-ID: <20240606215632.4061204-4-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a2c5d7-3fcf-48fb-050a-08dc86739513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OIPHOxPppXQXwx6QX8v3PdL7m7wcwDvR5IsG0IskcIn8c90YQRFKIowH3LJp?=
 =?us-ascii?Q?UGpkr+iki9nvUnRkqds/bG/6MyHz9vkJUK0lu8qeiVadFBMAIHguNfuKOZ+j?=
 =?us-ascii?Q?j7kXIpuV6a0Js7zA88qlf4RyyrEvrxzYMd57KP7MXC2hLmnES308sPtXSTnn?=
 =?us-ascii?Q?ghN4KKEJpE7ENEXKLKOIQb//WyYbmD6jcH2Dz2+4S033Bcy9UhGtn/AySeSs?=
 =?us-ascii?Q?fedm0K9rUF/HSXNZdW1UWpLbUK9pT88sl5Pyfr8buQQfpMigy3kVyBPI8xT3?=
 =?us-ascii?Q?GnCokjqdPoFszoG7d4GVT2B816Pu6hN5qcJX2ZnimbcVo0vHXxx6CWI1sCUJ?=
 =?us-ascii?Q?h2jA90nbxwwoAZEz0/slAYM8+Ew5MfHot9p+undpHq4XzAJKPITvlhrr87nx?=
 =?us-ascii?Q?3WSPYOVZFIHe6mS6GRlLlkW/KXqQu5kgd55Fo1a+y4i5Zwi/vw9DyDv3xHic?=
 =?us-ascii?Q?K/uhR6dApJPV2EZQp12mrKUZI2js30/WkDl1bCHhSEWUWsP8jVahRQFbfBRh?=
 =?us-ascii?Q?3sVTghyuPpe8GpZ2hbQBJdTCMkNyRErStAuYncbQgNv5ngSsQ2GSRYt5H1K8?=
 =?us-ascii?Q?TUarUCXteZTfx0ucxG0DCGdsilyGxJp+htFKx3WAdWJwt08pEy8cHQlGeZlH?=
 =?us-ascii?Q?Cy1ttKRYW1W0GxQ1DeDj+FvQA0LRoFTGGT2CSih1w6oj4XoOqgycjq4aRBYP?=
 =?us-ascii?Q?4bAFBB5+EeYeY+s9QvdE0tQNjg8oqHOM3rg5BI7BnFngxQ1IlzObusdidtQi?=
 =?us-ascii?Q?M/F5isl7ypdIq5aJ/ADSXto/8r9rPOhF4BLBq3m8ByiQDQgPqYfrYVVhNrLj?=
 =?us-ascii?Q?o3FkskVQheb0QlVx8+KCdHonkRnh9aUPUATrfxyKpHCHkJ0Sn05uw75U8avr?=
 =?us-ascii?Q?CdFBpevq6DPS7RKglPyHzu6dwdtbu9DUCjnkR3ZkOyGW6CxVBsQGzrbxYMcu?=
 =?us-ascii?Q?yffiuKWUre4aFuju6U+cOm6sXNHM+xmbv4L6GGbB/yoqWqOP0+vQL8G8duRV?=
 =?us-ascii?Q?H00x0EJSBMf/6hDnqk+lvCADUTDSbQIurnck1GJxvlDm3uE8HI4SDj8RsPhP?=
 =?us-ascii?Q?/qAyRyH2BfdVwHr6M70tYNPLvnV5Ok+9vW6AFOhQl8xDfkRlSTjkd9gtl1Ns?=
 =?us-ascii?Q?OMEmh8DLbtmXPVfHRtvmSXttE665XUL7JK5hgIGM5HRrqVFDx86b1RJy85si?=
 =?us-ascii?Q?OpIysvxtNpj/Y0NQxLVHntwOIoLRvtpKKe2kgAuVZG713A/gIkin0DNG05eH?=
 =?us-ascii?Q?bfXpKMfnGQ67sY/gJOxBUIbpNtcfEwvNCk1Md9Tv5fZ5BbkCCVXjkxPmT7Ua?=
 =?us-ascii?Q?+CSkK3bV8wLBd4QDGAFPyM8tqFBZeV3KeH9ssPF6ZHUwDw1H5fwP7OKybZae?=
 =?us-ascii?Q?hTNtMyAH0S7HOI7IJVCasZj7g2jCkVISwihpyRNtHj51wn1ZUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:56:55.9399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a2c5d7-3fcf-48fb-050a-08dc86739513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leon Huang <Leon.Huang1@amd.com>

[Why]
Dmub provides several Replay residency calculation methods, but current
interface only supports either ALPM or PHY mode

[How]
Modify the interface for supporting different types of Replay residency
calculation.

Reviewed-by: Rodrigo Siqueira <Rodrigo Siqueira@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 32 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  2 +-
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index fd91445d4d8e..be27ab7ef2da 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -239,23 +239,39 @@ static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
  * Get Replay residency from firmware.
  */
 static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
-	uint32_t *residency, const bool is_start, const bool is_alpm)
+	uint32_t *residency, const bool is_start, enum pr_residency_mode mode)
 {
-	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
 	uint16_t param = (uint16_t)(panel_inst << 8);
 
-	if (is_alpm)
+	switch (mode) {
+	case PR_RESIDENCY_MODE_PHY:
+		param |= REPLAY_RESIDENCY_FIELD_MODE_PHY;
+		break;
+	case PR_RESIDENCY_MODE_ALPM:
 		param |= REPLAY_RESIDENCY_FIELD_MODE_ALPM;
+		break;
+	case PR_RESIDENCY_MODE_IPS2:
+		param |= REPLAY_RESIDENCY_REVISION_1;
+		param |= REPLAY_RESIDENCY_FIELD_MODE2_IPS;
+		break;
+	case PR_RESIDENCY_MODE_FRAME_CNT:
+		param |= REPLAY_RESIDENCY_REVISION_1;
+		param |= REPLAY_RESIDENCY_FIELD_MODE2_FRAME_CNT;
+		break;
+	case PR_RESIDENCY_MODE_ENABLEMENT_PERIOD:
+		param |= REPLAY_RESIDENCY_REVISION_1;
+		param |= REPLAY_RESIDENCY_FIELD_MODE2_EN_PERIOD;
+		break;
+	default:
+		break;
+	}
 
 	if (is_start)
 		param |= REPLAY_RESIDENCY_ENABLE;
 
 	// Send gpint command and wait for ack
-	dmub_srv_send_gpint_command(srv, DMUB_GPINT__REPLAY_RESIDENCY, param, 30);
-
-	if (!is_start)
-		dmub_srv_get_gpint_response(srv, residency);
-	else
+	if (!dc_wake_and_execute_gpint(dmub->ctx, DMUB_GPINT__REPLAY_RESIDENCY, param,
+				       residency, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
 		*residency = 0;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index d090ec900c08..63bbb1bb0ad5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -50,7 +50,7 @@ struct dmub_replay_funcs {
 	void (*replay_set_coasting_vtotal)(struct dmub_replay *dmub, uint32_t coasting_vtotal,
 		uint8_t panel_inst);
 	void (*replay_residency)(struct dmub_replay *dmub,
-		uint8_t panel_inst, uint32_t *residency, const bool is_start, const bool is_alpm);
+		uint8_t panel_inst, uint32_t *residency, const bool is_start, const enum pr_residency_mode mode);
 	void (*replay_set_power_opt_and_coasting_vtotal)(struct dmub_replay *dmub,
 		unsigned int power_opt, uint8_t panel_inst, uint32_t coasting_vtotal);
 };
-- 
2.34.1

