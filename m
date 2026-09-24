Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F588C98321
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0476810F740;
	Thu, 24 Sep 2026 18:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YhjIISiG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEDA10F732
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCsuNfizrxq/L8xGc3x8Lj8LOCBVncmSg/0mTP8/LA6zeHY77PooRBWoY6GLLcyRophzdty2qy8BVTUF5jSMivBfLbkRgOcVgI7QTyoDuyi4j6e6lvTMskcNBLb298tP6DP7/uaHJ/GEkxLvYiCrITAeXBVvPP1B3yMx/EShCiKvbDrQ18QrqvLc9DXZH6kog3FdI9oMiDoROsHQ1UQXA83ioM1jcLu6nfCE3gcW75bvOScjqKG3kDmMIM46VyM6T7xDHHoKTF0unXy+PWE1t7OzR9fjKVRo3h1mMu7rA2fnL1/lWrtBxtY44if9Th0151hBFWec8QIbWBBNKqx3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFmYTiZW4dzJqudf08BbGV0H02b/ZNtujh8xzWzl0H4=;
 b=PXx9Yu9m/BbR6iL8efenrmJL8Z5eEGQrn/qpGbzwvbdHqIopaT9l9Es3twxZYZm9FoNxD8M2hgp0oIlWlX9+usdnn6ug4BLCsbMlkCSSlyALwiStVr9f4GTIbfVzNyqD5KWE1QkmfWQiVR5ovFalwkAxGa4Fee5Ue80HdpuWJXuyHDVmh5ZuborPHFP1+Wui/yBhfkGtU/krJ4eaQhOaagZU1Zc9fc2DYU3E8e9aDJVtMX6fS2X2ssYLpHt6xInxLQ62WhDuOnB4KKK8wJtZOQ/cJ3KJZkenEIU3gJNBmXA80wKgbbO/XT6qdLcm6Gk/L+zDz8pRuo2V/tuy88gkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFmYTiZW4dzJqudf08BbGV0H02b/ZNtujh8xzWzl0H4=;
 b=YhjIISiGmVjbEDvgaozdD0Eozn6QRcif+5RLtDFShWinH3U2LDDK+mOR3wZSGXk0pM0pE4ryXI/E9Coy4WNsdBKUuvU9ucqmr7nlCuYVnivYl455Ic8954Pkfrqdr6RI4U9kBPZ6mC4jgTJxBEOaF7G4vInbJsgut8Gyg/QDKBw=
Received: from PH8P221CA0053.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::18)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:37 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::38) by PH8P221CA0053.outlook.office365.com
 (2603:10b6:510:346::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:35 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:17 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Michael Strauss
 <michael.strauss@amd.com>
Subject: [PATCH 23/34] drm/amd/display: avoid to write signal specific for tmds
Date: Thu, 24 Sep 2026 14:45:36 -0400
Message-ID: <20260924184824.596894-24-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a314b9-720a-4150-bce3-08df1a6c28fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ySCr5PyHBa/XPbPYwnw7ffbbsPPDnhVAN7h3NJyqk8IY93cNGvGiayZpyvcNwvOqDW11xmqc4SdJ3epd8DkSAX3eocl6kX+vQ8uRPmSpEEFL6fgUzyGKxn9iYucaaf+jmsID7h0VjwjBwOlAoX7uR9BWSKpG/gGM1drFs9tuTOK/i2ETjRaj+qMqRApz4gUuUeocIx8rJt7u9Z9wqccFC99JBpNsuhGKJ1+dVLoaPhyP00jTOYG42OICF3YrpOlmxNuL9VAaw/c6kxS6nEresIbtH9qBqon+XbkMehyzjuUslOBqfoCVVCjtkw1n9aC0KcucNtlWFCDtzG/7RNmPSGtlNtBIwhHFCSu3wux6/TqxIcULw7J3FZTSbE5c966i7f2K0asKzUAgdSIR/FZ8HeZDEOJxPbvA2WYZY7sYmNCc/2A+TiSCj0AJ3aR2UUIOxCUrJuEnbVCRm6t9NpTKk3d31ggFDp/dwjztwKyGx4gJWTTBJ9cvRAoUlwKjmvruq60XKOtOnOtGzHHh7/500mMtzLHOuVz/FedJK6eLvUfvx+iWHKMrhZ3d7+gfnvQmHeyndaRJ87LtuVadpdmRbKCL3gH3Jbygz5z/9XKKj5EoWbu/9HwZGwzK7jaLD640kwBb2X0wMWQaSxLM2Fs05g6piMKYeRgRbWMKggj5eYtHYbeCcbwePFKxdp8F+2+CsBe7u3uAfDdIJz0ykBi3bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F4hvDBH8LHpGYzjXVPN8iZ1gHhdoctMBuVSoetxDAjwCiKTMWJTHKTO1qNW1MI4WWjU4b6YJAZyoQ/4Bs7aALzSJzksPgT3dqMImNRjSdvY8ZvRXEWXnMoKLULi98rq2hPNlnBBVHt4qGaK9XoqpsxH/lcwcChBctq4b2HOFP33Spv31pL/dNjCH+5rnhiasoM4P8HmvPEiKW4gI7cGHw00ObtwuHgHKTIfwDNT3ujhtmskf7W85/XSgyrsWV76Z0++ZNzw/Rj99S4FGM8H9JxKpucEt5D8T0H6RBMzgUMB7Z14bEjtWGkNpwUIEmYCPoArBLyrhgVQeUE7x1CQafXnd2ctavcOV8RfokbRX6P/VrjyO8+Pp7LHPaPbAeUrR4DePuCLzueqzyYCrUJFru/p8Er645Ad4NThca50BN5U0vt8U/sE+TIlZneY7CYPT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:35.5156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a314b9-720a-4150-bce3-08df1a6c28fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
some panel will generate HPD if receive invalid the action.

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c          | 2 ++
 drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c | 8 +++++---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 48b086d15ab0..c009d0fb14ca 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1898,6 +1898,7 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 		write_scdc_data(
 			stream->link->ddc,
 			stream->phy_pix_clk,
+			dc_is_hdmi_frl_signal(pipe_ctx->stream->signal),
 			(stream->timing.flags.LTE_340MCSC_SCRAMBLE != 0));
 
 	if (dc->debug.enable_hdmi_idcc) {
@@ -2438,6 +2439,7 @@ enum dc_status link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		write_scdc_data(
 			link->ddc,
 			165000,//vbios only handles 165Mhz.
+			dc_is_hdmi_frl_signal(stream->signal),
 			false);
 		if (masked_chip_caps == AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_TISN65DP159RSBT) {
 			/* DP159, Retimer settings */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index 6123b10977bf..d87f6f377d06 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -570,6 +570,7 @@ struct ddc *get_ddc_pin(struct ddc_service *ddc_service)
 
 void write_scdc_data(struct ddc_service *ddc_service,
 		uint32_t pix_clk,
+		bool is_frl,
 		bool lte_340_scramble)
 {
 	bool over_340_mhz = pix_clk > 340000 ? 1 : 0;
@@ -583,9 +584,10 @@ void write_scdc_data(struct ddc_service *ddc_service,
 		(ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite ||
 		!ddc_service->link->local_sink->edid_caps.scdc_present))
 		return;
-	hdmi_frl_LTS_clear_Link_Setting(ddc_service);
-	hdmi_frl_LTS_clear_Update_flag(ddc_service);
-
+	if (is_frl) {
+		hdmi_frl_LTS_clear_Link_Setting(ddc_service);
+		hdmi_frl_LTS_clear_Update_flag(ddc_service);
+	}
 	link_query_ddc_data(ddc_service, slave_address, &offset,
 			sizeof(offset), &sink_version, sizeof(sink_version));
 	if (sink_version == 1) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
index fdd8a3dce97f..200823954fc6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
@@ -91,6 +91,7 @@ uint32_t link_get_fixed_vs_pe_retimer_write_address(struct dc_link *link);
 void write_scdc_data(
 		struct ddc_service *ddc_service,
 		uint32_t pix_clk,
+		bool is_frl,
 		bool lte_340_scramble);
 
 void read_scdc_data(
-- 
2.53.0

