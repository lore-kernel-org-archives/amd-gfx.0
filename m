Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ECBC27C50
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310B110E3AE;
	Fri, 31 May 2024 16:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NSeZPsyM";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B7610E4AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtfFP+xQxbVdJUeVy7Mk/6eANv3bdkBiQtjERrrL3IiNj3nyLgHirY1SKZ1dq+8Zd/MzEApO9J6IoMtTN7BJZ81zqB7Gkm3s9NKxh5V9GO8hiMJd3+zyahtJekc/hfh97zQst9GKcOJDtq+nWn0SFla4JkrtyubTItIbSWBIxxtxr9h2Jtzu8ptqpKhNwd4xAknHWj/NACa+VheatXr4kzLxLRA8y9U2sk2YfXJJwjmVjxsJir4kUpXwmM+p4gTe+V/FeafVdzadUskt2riHnuanPOY/pALpDgojf8IUANe+9lGPpCCvyfen3KlK4MIF8rTtZsCcmbbNsnT3uBEcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REdOeUdl4kxohUKFOVBNc1oIOj1TjtgqmWGqnzvwnkQ=;
 b=JhmKhtSxcLfhFKUg1gd//gSSxladCGmENXBM3vTWBd2wMhZPrECi2WZJdXwQObBAWcKfY/huMFdIspVsoSIm/Vt548oQBinpPS/oRsEDVEZ+AW9Ogvs+odup0O02o/fA4lZAt5HWzOwzNdRwVLkmKLE3havgIbyoiUk0sbbzjnbVhDDuAT2B91+1auY5p5ePCfCJSyL12LeU+lWBZ4SUyyNPnrBe4bZk3OzMqnHuqzvvGk0XEii9C8j0BMMIrq5I87wbBMwFgA+iFWGeQGQAZCKAvxeN3VTvu5sxYtbJxrTm7xe/m6aS6roPACgTz1irMCvAvXWZunFgdydM+7hptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REdOeUdl4kxohUKFOVBNc1oIOj1TjtgqmWGqnzvwnkQ=;
 b=NSeZPsyMG3uLWNIx9hXPQbBZ7yE8ssz4YQ2VnAO58rz8mgwKaErHJ5b9CBcPKFp1UJ9qftv073K+GAMZ2dc2xKLfKS9HLG10w2XDBuSX4pzITUkXKUkZ3q+VbZ9+oup/1HcMVRrUjZVV3BcpzGpcVzV47uRRnHr8UseSHG2CSDo=
Received: from PH7PR10CA0009.namprd10.prod.outlook.com (2603:10b6:510:23d::29)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:52:43 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::36) by PH7PR10CA0009.outlook.office365.com
 (2603:10b6:510:23d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 16:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:42 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:39 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Jack Chang <jack.chang@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 19/32] drm/amd/display: Extend PSRSU residency mode
Date: Fri, 31 May 2024 12:51:32 -0400
Message-ID: <20240531165145.1874966-20-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: f48ff9d1-6bbe-4797-cb40-08dc819216d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ymKI7CiNH4lHEV96+GkgmN0xLAsLgOUHShi3wnhkF68FemAOysrbA7UyHeVL?=
 =?us-ascii?Q?Ik3zCSWffF72YQ4wl402kC4k3OVIKIaYyQh0GuQLZ5R4/mTPtamI+Hc0YGSH?=
 =?us-ascii?Q?nZKUNGmlhtid4FYDkWxUBL15Rh//a5oG/nBkRNAIEdbPXl1MBRmDogmjFvU/?=
 =?us-ascii?Q?4RqzkviOr0zIBeS8ISiG8qKoR18bHf5TH+AtRo0pBheFr8MrN5M9j0VChvrG?=
 =?us-ascii?Q?RJIS43jHelNAnDLOBgqNPmj5pipqpqA0t+arcTwrxiTNicSWCwpxVnX+vqKs?=
 =?us-ascii?Q?I/zYEwFj80+OHZIoRBPhGH1nftPB76aQRPUYbCCyineC5oL8M3YHHWuWhW9Q?=
 =?us-ascii?Q?3nR8KFrDHEh4JO47i8DZ+n1t1WtkIsj6lxt5dLoJXuCmjO0MDD6p81SgQ7Nc?=
 =?us-ascii?Q?s6RkntFNQKmnJ1IlfcRINeIhuQqVfEtvLJEug/Kk9HbZiMVaLQ1CIjGX997f?=
 =?us-ascii?Q?YDerDNklCPUD6Ndcab15cxsyJvUbS03SH2McrG8DvtGeeHr3yz1mVbnkyLZE?=
 =?us-ascii?Q?BP4jgNfJGPNSHaaQWWuR6CuVpSzDNdBLme7yywShRIkr8eeASVgbfuxo5Ltx?=
 =?us-ascii?Q?jhXD2nUZYAdAXT7Y3qN7xhUfUUQNCEdThhOkoCTUqyYQsK5+bhHIHoo+mdaG?=
 =?us-ascii?Q?IQ6oknv0vKalJ6S782Y3AG5Y/kSEzKStIglKQxtDXKglK+rJlKP933IS6FOl?=
 =?us-ascii?Q?VwUGakwiMLbtvL+/Ep/h+wMVoJHBAmCRwMgF8dS3hM1Tem1hLQLWfEBYg4pg?=
 =?us-ascii?Q?ykur6tDGVbabwIcV9fEAiihgFGNpXzDBRG9bSwdH8CZi+Sh4LcOONny8tmKe?=
 =?us-ascii?Q?Ehx0zxOkchbgekK3VkRUkcTrJ5qr5jaCRZfWec127Q0hfTs0kFO4WeFalFIU?=
 =?us-ascii?Q?52joWc2CGVKVY1EqR63zVw2uAuzfkfoyUSEsUjrnI6XG6jOLt3OAvIqw7ohu?=
 =?us-ascii?Q?syBBbZFNOU+fvq8MxCHiC0RxuFBvUbTx51iaQLf9SUL4FTHViVMmYUmgNTl7?=
 =?us-ascii?Q?WJba2m38wQ/K0WOWy02/i7JrIIdeJWe91tIZGQdPnzvtp6CKg3QQQdctq2hH?=
 =?us-ascii?Q?su8F6SwnMhdRvcn8AlpFWGSpubEI/fyC+W4LpgNw1IeKeuqp6YEcJmx3Ed0M?=
 =?us-ascii?Q?tRydWTnSeJ4dI516SqIH1x3tvHG4pBa5Byn1DIWf8fqWA/rqv6zflXwxVjDk?=
 =?us-ascii?Q?vKj9LzDq4775VRQ3WN03f0QNIwIutn3OgeQd2966F5Vhg3SRkpaLzyoRwgan?=
 =?us-ascii?Q?WqW9sSa/Ltpli7kB5R0C6loG1aRTIcUCR0bxJkYpd26YKFvgalVphct8Z1Bg?=
 =?us-ascii?Q?vDpTezcaWtucQ6c5OLJADogMpv39CY86yBZW/QvU1hk1gKYom6kbIr/V82F9?=
 =?us-ascii?Q?9zYWrNc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:42.7148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f48ff9d1-6bbe-4797-cb40-08dc819216d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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

From: Jack Chang <jack.chang@amd.com>

1. To support multiple PSRSU residency measurement mode

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c        |  5 ++++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h        |  3 ++-
 drivers/gpu/drm/amd/display/dc/inc/link.h            |  2 +-
 .../dc/link/protocols/link_edp_panel_control.c       |  4 ++--
 .../dc/link/protocols/link_edp_panel_control.h       |  2 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h      | 12 ++++++++++++
 7 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 27d5c6077630..8db75afa9fc9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3074,7 +3074,7 @@ static int psr_read_residency(void *data, u64 *val)
 	struct dc_link *link = connector->dc_link;
 	u32 residency = 0;
 
-	link->dc->link_srv->edp_get_psr_residency(link, &residency);
+	link->dc->link_srv->edp_get_psr_residency(link, &residency, PSR_RESIDENCY_MODE_PHY);
 
 	*val = (u64)residency;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 3e243e407bb8..ccf153b7a467 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -445,10 +445,13 @@ static void dmub_psr_force_static(struct dmub_psr *dmub, uint8_t panel_inst)
 /*
  * Get PSR residency from firmware.
  */
-static void dmub_psr_get_residency(struct dmub_psr *dmub, uint32_t *residency, uint8_t panel_inst)
+static void dmub_psr_get_residency(struct dmub_psr *dmub, uint32_t *residency,
+	uint8_t panel_inst, enum psr_residency_mode mode)
 {
 	uint16_t param = (uint16_t)(panel_inst << 8);
 
+	param |= mode;
+
 	/* Send gpint command and wait for ack */
 	dc_wake_and_execute_gpint(dmub->ctx, DMUB_GPINT__PSR_RESIDENCY, param, residency,
 				  DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index 289e42070ece..a6e282d950c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -27,6 +27,7 @@
 #define _DMUB_PSR_H_
 
 #include "dc_types.h"
+#include "dmub_cmd.h"
 struct dc_link;
 struct dmub_psr_funcs;
 
@@ -46,7 +47,7 @@ struct dmub_psr_funcs {
 	uint8_t panel_inst);
 	void (*psr_force_static)(struct dmub_psr *dmub, uint8_t panel_inst);
 	void (*psr_get_residency)(struct dmub_psr *dmub, uint32_t *residency,
-	uint8_t panel_inst);
+	uint8_t panel_inst,  enum psr_residency_mode mode);
 	void (*psr_set_sink_vtotal_in_psr_active)(struct dmub_psr *dmub,
 	uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su);
 	void (*psr_set_power_opt)(struct dmub_psr *dmub, unsigned int power_opt, uint8_t panel_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 7ab8ba5e23ed..72a8479e1f2d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -272,7 +272,7 @@ struct link_service {
 			uint16_t psr_vtotal_idle,
 			uint16_t psr_vtotal_su);
 	void (*edp_get_psr_residency)(
-			const struct dc_link *link, uint32_t *residency);
+			const struct dc_link *link, uint32_t *residency, enum psr_residency_mode mode);
 
 	bool (*edp_get_replay_state)(
 			const struct dc_link *link, uint64_t *state);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 89f66d88c3b0..b0e17064a960 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -853,7 +853,7 @@ bool edp_setup_psr(struct dc_link *link,
 
 }
 
-void edp_get_psr_residency(const struct dc_link *link, uint32_t *residency)
+void edp_get_psr_residency(const struct dc_link *link, uint32_t *residency, enum psr_residency_mode mode)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmub_psr *psr = dc->res_pool->psr;
@@ -864,7 +864,7 @@ void edp_get_psr_residency(const struct dc_link *link, uint32_t *residency)
 
 	// PSR residency measurements only supported on DMCUB
 	if (psr != NULL && link->psr_settings.psr_feature_enabled)
-		psr->funcs->psr_get_residency(psr, residency, panel_inst);
+		psr->funcs->psr_get_residency(psr, residency, panel_inst, mode);
 	else
 		*residency = 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index cb6d95cc36e4..8df8ac5bde5b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -51,7 +51,7 @@ bool edp_setup_psr(struct dc_link *link,
 		struct psr_context *psr_context);
 bool edp_set_sink_vtotal_in_psr_active(const struct dc_link *link,
        uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su);
-void edp_get_psr_residency(const struct dc_link *link, uint32_t *residency);
+void edp_get_psr_residency(const struct dc_link *link, uint32_t *residency, enum psr_residency_mode mode);
 bool edp_set_replay_allow_active(struct dc_link *dc_link, const bool *enable,
 	bool wait, bool force_static, const unsigned int *power_opts);
 bool edp_setup_replay(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7f08e95140ef..d4d046ac82a4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3249,6 +3249,18 @@ struct dmub_rb_cmd_psr_set_power_opt {
 	struct dmub_cmd_psr_set_power_opt_data psr_set_power_opt_data;
 };
 
+/**
+ * Different PSR residency modes.
+ * Different modes change the definition of PSR residency.
+ */
+enum psr_residency_mode {
+	PSR_RESIDENCY_MODE_PHY = 0,
+	PSR_RESIDENCY_MODE_ALPM,
+	PSR_RESIDENCY_MODE_ENABLEMENT_PERIOD,
+	/* Do not add below. */
+	PSR_RESIDENCY_MODE_LAST_ELEMENT,
+};
+
 /**
  * Definition of Replay Residency GPINT command.
  * Bit[0] - Residency mode for Revision 0
-- 
2.34.1

