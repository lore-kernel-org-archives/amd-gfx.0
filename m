Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6517CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F4210E70D;
	Tue,  2 Sep 2025 13:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xw+J86SD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0A510E70D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZ+yuEhIni/t6uiS6o+v5gkt7KXgtcDuz4pt8EazfejDyVjO+ysXaq1V2jNSyjZ/F7IJNcKXTJuL1ec1DIYhSOmUw5aHe/ynTfPDDJXRbxOulD8nB9smRp2fV64MPKIbQVW24EiN9WrsxLRcPeprZS9CqEY8heUvM+1Mq4H3+1E2qC3ph5Rha3Hj2P5BE0NK++rnrtOMeB/2nUp+/iy10tNA0E+ayrlg3SO94QJZ4IJf8POjsY2rm4T/dmcpwLiDlCYC/rcF1Ry7Tm49KzgaMj9SB0qwJRqnDgD8TpGxeTgpdbq562K5mVhbfIdHAgAPh4kz/yhU94k63OfXJS062A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br15R2WdULxx42+eJjjCfRRtYELYp+jALj17gwNoEIA=;
 b=NAwhsS0li+O107CVqkZMla5Ine8IvnU7Ol/mlR4NgqQNjlXnSBK7Zoh+lvrYsWLWTWwTh6fnwak6AuXv6Va3IL8R9t1K8d7fwFszHXj7+OBYCBJDUApQ4iRbhogxuQwIKaZHAdSybEM6QvqygqHmO0493CatC8sdu0EnYqK5zpLQDBnpB7OR/E1TWuUMw75moYG52P9Hv23aSxDN0pQaFBBsIp2GIGpLL5Gltt3tQBZBizLbRQPRQH8V9mbpCXfacIavNHgikHN/zulq96Qz8EgZkj5ysJmyqM3dk8I8YfG97Jht3g3L50Ue5Bq4tBnnX7BCLa5Q5Q6eyjEg+44V4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br15R2WdULxx42+eJjjCfRRtYELYp+jALj17gwNoEIA=;
 b=xw+J86SDk0lk7qTgwMp4lCrICK6snxUuM2MIAvdAssZ3y7aMvwgQuYqZjH/ojUpYvaj9dHCXE2NBPEsMx7T9ztvNzkv1gR9YXqm7HeD+yhvd6e9DR6r0n9Rok5qUF6rJgHyi8PqdTj/itmAG6AKB2WnG3cjXSWuOhXvDPqNUz5o=
Received: from CH2PR12CA0007.namprd12.prod.outlook.com (2603:10b6:610:57::17)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Tue, 2 Sep
 2025 13:35:55 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::10) by CH2PR12CA0007.outlook.office365.com
 (2603:10b6:610:57::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 13:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 13:35:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:35:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:35:54 -0500
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 08:35:54 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 5/8] drm/amd/display: Clear the CUR_ENABLE register on DCN314
 w/out DPP PG
Date: Tue, 2 Sep 2025 09:33:34 -0400
Message-ID: <20250902133529.4144-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902133529.4144-1-Jerry.Zuo@amd.com>
References: <20250902133529.4144-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e00733-6e5a-4ed4-e114-08ddea25a497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UMcozxDG6V3Eq7b5Tonin4+vYleREY6zWScrGvgPmeVveyikdWI/EUiaF//S?=
 =?us-ascii?Q?XGa9DIvl8G/rVXQF3ILIB6pCjJp9CMfe7kINR2M/pz/A2amIBbANwQq8RDHb?=
 =?us-ascii?Q?nj3yN9wdAp+IlD1IpbuwJ0leHJuGzVY28wEfctmvUzi3NOZTxlPFxhMM2KjG?=
 =?us-ascii?Q?uxKRe1vD5dWisoof6S1FGbE8M3Wsu8MwubOl+KHA9zxC8AjAu+digOQJEGrk?=
 =?us-ascii?Q?z3p3tJNFbyPSztCY/CIm8dyOR4opv/dDb+giPXCeshCDoupA+cEesclQk/e5?=
 =?us-ascii?Q?KfJqjWspmtbJL1xjve0CKVnNx0sJZrA6lfWQIqqx5z7QBs2ExIH886F3+kiR?=
 =?us-ascii?Q?gccPHVlxnkrcroF3Hh2vbhI0QFx9v9M4C4/kn0a0QDh6QR1J7kqJzFK041hN?=
 =?us-ascii?Q?QrOYP4Ts1nF1l5owuv3JamOC+pttxfLco0Y9sJC3tvu5JnIQrPnoCCEphjVy?=
 =?us-ascii?Q?HoHV7E73EJM3zmOJZ4RAHDFz5f6y6v1vWB/biH72bhGf1ftXdoS5pxWAlgBt?=
 =?us-ascii?Q?OaMeF5xAsykMk/+YwD10j+RvorLq5KThwEThkZ7I3cIbFG3QERI44XHS7JOX?=
 =?us-ascii?Q?lJl5KwmJmHngJJxVYNRgq/Ru+XBAa6wumS6X9he1v3qKAbQ+RBqZK9U55zDP?=
 =?us-ascii?Q?HqUA7+GIqGVtrZ4Ydp6mefyKCcDzrSi6z9sY+s1qwVK6Ji/uzZM8wZRXtzff?=
 =?us-ascii?Q?idBSDM1f2NPSTL4kWZ29D/mlsdAWdfCBJgdkPev/jsqdxD1oy6D/bVq+WOOF?=
 =?us-ascii?Q?r+Bddxf+w9ZU8K6mEJOhP71lEY66UKbQIoHYac/KSUmFOBJrbAcbetfhAoRS?=
 =?us-ascii?Q?6Sq6b7G43LpQz0bZE5swlfZK0e/baUJzMW6zMTA3Jh9R+GlAOWKim873q+Ai?=
 =?us-ascii?Q?pmZKeVudMPArvGrjmoZkeN/p4AepTnSLA2uWvrmzKGVu1PUtrqJ49YBD9m9g?=
 =?us-ascii?Q?nZK/NnX279F30Av8BLZmoxq6yRroi23m2p4plP/fD30edJaTZymGIIL38kYw?=
 =?us-ascii?Q?J2TcWpjC+bNMwxs1huxYxRPiqO5wLZKOXRKCMUpnxBhEWK29YTltVMNmpmdc?=
 =?us-ascii?Q?AxZwX55RC10bylT1oMTqaPARm7i9nvGdjpUHrF3tGrHeCUkGPUwLkVC4l5mM?=
 =?us-ascii?Q?B+4Pwjgl/nkzEpQ7JP/Efkeuden/yj4mjBs4GZDodO+ZSbZbAB+fXq+/2O2L?=
 =?us-ascii?Q?ugU5Uycny/o6AAPFfElnhEEVrBde5T7zuk26VUG3nCsH7WOq3j2tvgYvRk/L?=
 =?us-ascii?Q?bXXZYFko0eLh9vLO5Le94mDk1skt96ea8pK99m4ahkqhPOtUAx2GdvS+6f5P?=
 =?us-ascii?Q?giZxBK3GpEyJSUGdsWlBCtBOrxzwNPe0pGDPA6ap+RWEYwTWew3i4jOzClT1?=
 =?us-ascii?Q?B6MUau6iimXNXt5hpBXaut9HiY3PWQCh4Bzr76MtJDW6nOW02h+S0nVIwAZR?=
 =?us-ascii?Q?TB8hJcIc2BvOiohQk7c7+SbJC9ApxD9cmXqUXP93jy5vlQeXJcTDFpLnA2jX?=
 =?us-ascii?Q?ojKiihKDbvN1PwSFVNfsySVCBxg6iq8lM6ec?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:35:55.2037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e00733-6e5a-4ed4-e114-08ddea25a497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
ON DCN314, clearing DPP SW structure without power gating it can cause a
double cursor in full screen with non-native scaling.

A W/A that clears CURSOR0_CONTROL cursor_enable flag if
dcn10_plane_atomic_power_down is called and DPP power gating is disabled.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |  9 +++
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |  2 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  1 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 72 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |  2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  3 +
 7 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index 75fb77bca83b..01480a04f85e 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -520,6 +520,15 @@ void dpp1_dppclk_control(
 		REG_UPDATE(DPP_CONTROL, DPP_CLOCK_ENABLE, 0);
 }
 
+void dpp_force_disable_cursor(struct dpp *dpp_base)
+{
+	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
+
+	/* Force disable cursor */
+	REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, 0);
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = 0;
+}
+
 static const struct dpp_funcs dcn10_dpp_funcs = {
 		.dpp_read_state = dpp_read_state,
 		.dpp_reset = dpp_reset,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
index c48139bed11f..f466182963f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
@@ -1525,4 +1525,6 @@ void dpp1_construct(struct dcn10_dpp *dpp1,
 
 void dpp1_cm_get_gamut_remap(struct dpp *dpp_base,
 			     struct dpp_grph_csc_adjustment *adjust);
+void dpp_force_disable_cursor(struct dpp *dpp_base);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 2d70586cef40..09be2a90cc79 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -1494,6 +1494,7 @@ static struct dpp_funcs dcn30_dpp_funcs = {
 	.dpp_dppclk_control		= dpp1_dppclk_control,
 	.dpp_set_hdr_multiplier		= dpp3_set_hdr_multiplier,
 	.dpp_get_gamut_remap		= dpp3_cm_get_gamut_remap,
+	.dpp_force_disable_cursor 	= dpp_force_disable_cursor,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index e68f21fd5f0f..560984533950 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -528,3 +528,75 @@ void dcn314_disable_link_output(struct dc_link *link,
 
 	apply_symclk_on_tx_off_wa(link);
 }
+
+/**
+ * dcn314_dpp_pg_control - DPP power gate control.
+ *
+ * @hws: dce_hwseq reference.
+ * @dpp_inst: DPP instance reference.
+ * @power_on: true if we want to enable power gate, false otherwise.
+ *
+ * Enable or disable power gate in the specific DPP instance.
+ * If power gating is disabled, will force disable cursor in the DPP instance.
+ */
+void dcn314_dpp_pg_control(
+		struct dce_hwseq *hws,
+		unsigned int dpp_inst,
+		bool power_on)
+{
+	uint32_t power_gate = power_on ? 0 : 1;
+	uint32_t pwr_status = power_on ? 0 : 2;
+
+
+	if (hws->ctx->dc->debug.disable_dpp_power_gate) {
+		/* Workaround for DCN314 with disabled power gating */
+		if (!power_on) {
+
+			/* Force disable cursor if power gating is disabled */
+			struct dpp *dpp = hws->ctx->dc->res_pool->dpps[dpp_inst];
+			if (dpp && dpp->funcs->dpp_force_disable_cursor)
+				dpp->funcs->dpp_force_disable_cursor(dpp);
+		}
+		return;
+	}
+	if (REG(DOMAIN1_PG_CONFIG) == 0)
+		return;
+
+	switch (dpp_inst) {
+	case 0: /* DPP0 */
+		REG_UPDATE(DOMAIN1_PG_CONFIG,
+				DOMAIN1_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN1_PG_STATUS,
+				DOMAIN1_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 1: /* DPP1 */
+		REG_UPDATE(DOMAIN3_PG_CONFIG,
+				DOMAIN3_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN3_PG_STATUS,
+				DOMAIN3_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 2: /* DPP2 */
+		REG_UPDATE(DOMAIN5_PG_CONFIG,
+				DOMAIN5_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN5_PG_STATUS,
+				DOMAIN5_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	case 3: /* DPP3 */
+		REG_UPDATE(DOMAIN7_PG_CONFIG,
+				DOMAIN7_POWER_GATE, power_gate);
+
+		REG_WAIT(DOMAIN7_PG_STATUS,
+				DOMAIN7_PGFSM_PWR_STATUS, pwr_status,
+				1, 1000);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index 2305ad282f21..6c072d0274ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -47,4 +47,6 @@ void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 
 void dcn314_disable_link_output(struct dc_link *link, const struct link_resource *link_res, enum signal_type signal);
 
+void dcn314_dpp_pg_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool power_on);
+
 #endif /* __DC_HWSS_DCN314_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index a99145a30230..79faab1125d4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -142,6 +142,7 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.enable_power_gating_plane = dcn314_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn314_dpp_root_clock_control,
 	.hubp_pg_control = dcn31_hubp_pg_control,
+	.dpp_pg_control = dcn314_dpp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn314_update_odm,
 	.dsc_pg_control = dcn314_dsc_pg_control,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 0c5675d1c593..1b7c085dc2cc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -349,6 +349,9 @@ struct dpp_funcs {
 		struct dpp *dpp_base,
 		enum dc_color_space color_space,
 		struct dc_csc_transform cursor_csc_color_matrix);
+
+	void (*dpp_force_disable_cursor)(struct dpp *dpp_base);
+
 };
 
 
-- 
2.43.0

