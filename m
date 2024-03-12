Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BE3C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58940112D42;
	Tue, 12 Mar 2024 09:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1wNoZ69N";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2E8112D42
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI07DvIU6ni8M2FS0+S02XUJGqP3ls9vDQSI3L+M9JwlNg/y860bbecwIdWl07/zkouH4UaOCo+UBpMw8er3gIOLjr5QfOuAaYn1MBiVP5ZmwaHXPIgEVmY7gZgWkProRaoUg+9/FXtEbakPCzMZVszJ51NxbMK1n/oc88zC6TCZ8q9L0I2cul6Q3iDp9IMST/7Pp4pCQZzwNz/jgoxKpJS4IfD/gbPeXC0Ey871e99kLcXUouNdI5pQSaXZgc7g996AGF3YDKAf8k7HyNa1lDArfLqeJf/rBVPAwvkYKmVCB79Yyf/w9lSAIhZDvaWvJ+nwd6aV3rb7mwxRkLkpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIXEyF2i1zC8glJzBBF4c/Zoqb4kqKpf45aLVgXmF4w=;
 b=fhf7eMcY2Kt9Ss5HH1+hDeqbmEZmU9xjqLHm2QkZrm3s06iNZf6f1IyZthmPdSeshRY11UmQ4OeLwZG5Jzk2NKcbdjaABQqZ/UylDliaBKWAseeYWYBXAsQpdpjA1kD4o9kb1BmLLMCI/SRJRfLcAlU7jF4KFPFkD6H0Wt/rIve5EjpV43lOf7LHva4KHiI2DHOVIo2Pru2p6UhYMJuVjubCHAUfUiylCPIEu2kU53v0G4HcgHspNk4p0EPbrPXJG1cElBrKtwyLQjTxIctJ43nqafF65xu/thoTVLfwM7CznmEHUgbbzBOZAO/EselCqrM1zariRtgjH57K6ZksqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIXEyF2i1zC8glJzBBF4c/Zoqb4kqKpf45aLVgXmF4w=;
 b=1wNoZ69NBUAyNkZqGaL4JRiD50pzJgO4XDMSmqguHW9zffrBUNykAA/MsNvlpPFlBvLfIIQcwI9xyhIoN1lweIlaz83GnDPJVfRXabKytYwxn6QuVrKqNUv0Q/vIwL6XgaF4Nf3w54sMZNqX+emlHysQWdzAa8fLHBDmOlGkQQo=
Received: from CH0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:b0::9)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:24:51 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::49) by CH0PR03CA0004.outlook.office365.com
 (2603:10b6:610:b0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 09:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:24:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:50 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:24:45 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Xi Liu <xi.liu@amd.com>, "Sung
 joon Kim" <sungjoon.kim@amd.com>
Subject: [PATCH 38/43] drm/amd/display: Remove unnecessary hard coded DPM
 states
Date: Tue, 12 Mar 2024 17:20:31 +0800
Message-ID: <20240312092036.3283319-39-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e5ed52-3688-45bf-d4d2-08dc427644ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQdYgU+9F16Wr2XQ/wH48nZ8+qSpihSMPlLyVvRLFFXD+SMD3S94akLce7+M2DfHd93+/GRymLsTBHyVJxNigc7okVxhcMRJYLhEv+q0TrxIJZsZNi+uonK4zQ0UEXQml/+K4HeXjAnoqz17U1icEkH47PG5DWjIWVAuT8peeC0Xz7AI9P2PZ/8c1HHX1Y1pW0VqH7l5Y4RNPsoskA7ChpCAZC/z63Ws2x0qSqW3wdY5DMdbI4JzQ7KeBBlEVJHymDmBmeMq1mdwwQrTtYkBPZgBEZWcv18PXkFQXQydT6NVTxsDK8URoHLFn3puSr8GMX4PRsNcGL01va+QbJ6expgiM5oeeaXFR0l4r4GPssSozaphjHmvVMwCKvZ5fJsVQDmvJkLqAvBYrhyEljaYWp1YTK02F1qWc/C3qYf9h4pHO2l+iErySwVsxxIOmBK6Eeo8GLmG2h0LbRSPEw5E3R/vPut+vgs2ySZ+islNAOxXoCJLy5yFFhSCG+kZgsUU41TCr3bKanN8zezmq0Y1rEMQmMuJ3k+TnW4NYw5dEYFfbDCLvT+39yfE3vmBzMwc8vUEZhDoqTm7yTFZBHi6v7aPu/5ctobcCvfwADK4FEnbmEvpgJ9UQiPNYSmvpRFGkUxnDau9EzLZRS6tcgY5PUsB5UvsplzrpOcg9YUIcFBthyS7U+x/Mtd1dq9maOiHJbh4e5rjL1HEEHwDH95lwWmUL1fnBE2FzRlb76XTz9CUlfs+vPWNVR6gEYmuqttH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:24:50.8841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e5ed52-3688-45bf-d4d2-08dc427644ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547
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

From: Xi Liu <xi.liu@amd.com>

[Why]

The hard coded DPM states are only used to fix mismatch states numbers from FW.

[How]

Remove when not needed.

Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Xi Liu <xi.liu@amd.com>
---
 .../display/dc/dml2/dml2_translation_helper.c   | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 17a58f41fc6a..0a4dff45731f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -30,6 +30,10 @@
 
 #define NUM_DCFCLK_STAS 5
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_51)
+#define NUM_DCFCLK_STAS_NEW 8
+#endif
+
 void dml2_init_ip_params(struct dml2_context *dml2, const struct dc *in_dc, struct ip_params_st *out)
 {
 	switch (dml2->v20.dml_core_ctx.project) {
@@ -254,11 +258,21 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	struct dml2_policy_build_synthetic_soc_states_scratch *s = &dml2->v20.scratch.create_scratch.build_synthetic_socbb_scratch;
 	struct dml2_policy_build_synthetic_soc_states_params *p = &dml2->v20.scratch.build_synthetic_socbb_params;
 	unsigned int dcfclk_stas_mhz[NUM_DCFCLK_STAS];
+#if defined(CONFIG_DRM_AMD_DC_DCN3_51)
+	unsigned int dcfclk_stas_mhz_new[NUM_DCFCLK_STAS_NEW];
+	unsigned int dml_project = dml2->v20.dml_core_ctx.project;
+#endif
 	unsigned int i = 0;
 	unsigned int transactions_per_mem_clock = 16; // project specific, depends on used Memory type
 
 	p->dcfclk_stas_mhz = dcfclk_stas_mhz;
 	p->num_dcfclk_stas = NUM_DCFCLK_STAS;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_51)
+	if (dml_project == dml_project_dcn351) {
+		p->dcfclk_stas_mhz = dcfclk_stas_mhz_new;
+		p->num_dcfclk_stas = NUM_DCFCLK_STAS_NEW;
+	}
+#endif
 	p->in_bbox = in_bbox;
 	p->out_states = out;
 	p->in_states = &dml2->v20.scratch.create_scratch.in_states;
@@ -436,8 +450,7 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	}
 
 	dml2_policy_build_synthetic_soc_states(s, p);
-	if (dml2->v20.dml_core_ctx.project == dml_project_dcn35 ||
-		dml2->v20.dml_core_ctx.project == dml_project_dcn351) {
+	if (dml2->v20.dml_core_ctx.project == dml_project_dcn35) {
 		// Override last out_state with data from last in_state
 		// This will ensure that out_state contains max fclk
 		memcpy(&p->out_states->state_array[p->out_states->num_states - 1],
-- 
2.37.3

