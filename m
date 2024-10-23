Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAB8D2E010
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368F710E71E;
	Wed, 23 Oct 2024 04:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JqDLq/JI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64C010E71E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8uhR9QKjniVq3Twu90jRJSVgrgnN4ZAtJQEejP22Axs+1X0Ijbvkp00stCv+wYv/HQzN5QtlWIH7G0KpQ2ZvOzf1Qzwj/czxlJyLi91d1zsyaYUV6N25S5uKx0O9IJ+c8sRnmQ8JBDCBKoT/2VmnajkdjFXbGnWtVE451z/TuUKIFsL5OXmcR3Iz6N73LS9S+zSoX80KVCP0yO93XHHDA831bUZiyJkD7/MHWxvgc0N3rOXh2bFWPDq6N3QqPxyDppiO6aSDI40j59lKN8JLlbWXza6ZApd8iGxYLvY8k319J0N01UWkbP42Kh7IAc6J72n5npkMRwkTMZIMDqZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmcb98zTNG2m3RpVxuCjSG9TT+WmpI7yAEHNueTg9wI=;
 b=jbLTE1BZbp5CUOWL94ZhNZrMXYEhURo6gDaE6/vXIaU8ehUBImrWKE1/8/jDxxiI6LU2EKcvYfTqU/otvTlbMIaI9KaVHU8nXxe8KIzGsA5WC8jaKFsJnKT/8N7hN78C9E6AASF0riOEJbuu4JipBuD8WM23sB0Rpq9qAI6USPwBx1M2OYub700TImQyFHiAmoBNFhVwr7sjdx3+lDljDk5XsA5KZ/2W0Fo+VLc8wctb+DBcE+IVPrinuAoURcWtLyh9knmzFhr3VBpx8iCJUlIfym3ocaCkuO3gN1Bh3dAUZV+QqT3nL8Jqdmy9W282ngs+I5zZtetnq3F1n76XaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmcb98zTNG2m3RpVxuCjSG9TT+WmpI7yAEHNueTg9wI=;
 b=JqDLq/JI1XkzbnaI2sPNYafgnaqfsQNqQ6yxsqgMNiKLx2H8x1XKVNfHCu6OwXuqLjiIMplKwNzKTFIplD5Sn67HDLvF31E0o/m6Yn1vbN7dLT4/NXenwQzn3I1s+XMZB/0JOwWtjKis7l3mwjLbARNB8tr6YaaEe5dYEli3xVI=
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 04:54:58 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::bb) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:54:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:56 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:54:53 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ovidiu Bunea <Ovidiu.Bunea@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 13/16] drm/amd/display: Do not read DSC state if not in use
Date: Wed, 23 Oct 2024 12:53:33 +0800
Message-ID: <20241023045336.1557443-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: d51262fa-ab68-4a3f-86fb-08dcf31ed851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KmdYNoddb8SOmFU/Am6QsdA95r8dt/0IxZ3zpOrdDR8ebIY2cQLkfCS4hqT/?=
 =?us-ascii?Q?h9vIIjPIPsarNndmo3dmBU9E0mFlsr+uOkmk41MXzzomOSFHqANvZTRTLP2g?=
 =?us-ascii?Q?tuZBhjH49ov39TLUb9EHWrDIx3GnvHkCV4ED0wEVbh5Hy0cSVzyd1qgkqF2E?=
 =?us-ascii?Q?xu4nwOoAQlbanAVwF5bqplJVEFKc1y1SoILruT8SNafJlKFypDdqvMEw8b13?=
 =?us-ascii?Q?3cvBoKky4mVuOsMjSLoVvInURrehlPmbeaR9xsb7Y7WC9mvfTMXeg1kcOopM?=
 =?us-ascii?Q?1+Gq3z3mTae6Yx3/WmeRMOFcewt44hPCaPYAYM9J+y6DtQlAR3blAFTgc6dO?=
 =?us-ascii?Q?9w/C8gGcyhMGr/PhNJ+5EM6Z5q3KCM4nmyQSzfer2lYmxhliMpmYS5nlTrar?=
 =?us-ascii?Q?BZ4tlIIr+j1GLR9NLSSKEtzATTd4t09PuJq2WFr96GNLQLPCXXFXO8P8Huo9?=
 =?us-ascii?Q?IqOYN5TfirHPdfG5GqMirbL4VRGpVz518vhknTdQsb3KPLLf2tl8MsdBT3bc?=
 =?us-ascii?Q?4BNCV2rdzI9Vmz0NyVux6tj2BFR3coD4yFOoXCLiA54c7iZ8+pr5BUhHDU7D?=
 =?us-ascii?Q?NPyw4rYBJ/vJaU4IgkBQ4Uaia47S0QvPJ9FmZnnxgoeXIkpTtgK10ICtfK9g?=
 =?us-ascii?Q?GdA9MHH2w01tJnbP8lXzu7PJYUN5gLaJCGlRi8ZyaHEdaievi1JOOttxiWnw?=
 =?us-ascii?Q?7VAFO/rqiE3DKMcOifQ7NEasuyHyxgso7rndin2CNQ1fjRuDk6qvYBM5gpdG?=
 =?us-ascii?Q?YQ68eQf29K2r/WMBNmK1m56gkBxVJydDqZGJLl1l5fBxLRp6tayUTQ1ACG3F?=
 =?us-ascii?Q?IbBDs9clofYD2FEJIwO0HGTdYsz9mgJTlKujmeR07MWhaO1NWN7qDPbcT0D2?=
 =?us-ascii?Q?0ewplQd30pPOUAsaEJGrk+yfjHy/32VDCvAWWffbrbXZP/iAFY1kUSpTuEHi?=
 =?us-ascii?Q?1uUgNScLbTzIf3RhE/f9E1FHvv7TtA7dIvOY85n9b9mFZPzu7qpi2htemKsk?=
 =?us-ascii?Q?wr7h3DUW0CgCMjc/BMfcw5Du84RkLpnNFJNK/VMnJ+417uNTbfFgEWgzb7E3?=
 =?us-ascii?Q?ofjm1h979bWWrOxv38Pa8fcnKKxH8gRQk32nXJxjTGC0J2itPRJbwtKNObBI?=
 =?us-ascii?Q?I/06Pr8Zl58vF/zV3DXJKJHATMtVfSRHLlzU19jR0NYK6duVb0TNyMtMd+0O?=
 =?us-ascii?Q?GJTk4setgwox2zQZtP/kZcpc2K0BURM12xpThrv5sMtRjuJrR/Qj5skbQOf0?=
 =?us-ascii?Q?f2O6o5QbGzZibyT4zW1hJaZY6x6Ea+nW8Fz2ZnP4JtRWbjfG/lB6P9ttioD9?=
 =?us-ascii?Q?uvWcsahUksx+SakYAd7MiuTLu5qDnWckLX4AYHO2l8xL+z1hTCkSd1/EmQe7?=
 =?us-ascii?Q?XQ7E2Dr7J0yGbzqSDZULHgrRf05X+B9yb+kr5I8FGI1VhmSTEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:54:58.1839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d51262fa-ab68-4a3f-86fb-08dcf31ed851
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

[why & how]
DSC may be power gated when coming out of S0i3, so avoid polling
DSC registers since it will fail anyways. Only read if it is known
that DSC is in use.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index bd309dbdf7b2..3cb4e9907411 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -841,6 +841,7 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 			uint32_t num_opps = 0;
 			uint32_t opp_id_src0 = OPP_ID_INVALID;
 			uint32_t opp_id_src1 = OPP_ID_INVALID;
+			uint32_t optc_dsc_state = 0;
 
 			// Step 1: To find out which OPTC is running & OPTC DSC is ON
 			// We can't use res_pool->res_cap->num_timing_generator to check
@@ -849,7 +850,6 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 			// Some ASICs would be fused display pipes less than the default setting.
 			// In dcnxx_resource_construct function, driver would obatin real information.
 			for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
-				uint32_t optc_dsc_state = 0;
 				struct timing_generator *tg = dc->res_pool->timing_generators[i];
 
 				if (tg->funcs->is_tg_enabled(tg)) {
@@ -864,15 +864,18 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 				}
 			}
 
-			// Step 2: To power down DSC but skip DSC  of running OPTC
+			// Step 2: To power down DSC but skip DSC of running OPTC
 			for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 				struct dcn_dsc_state s  = {0};
 
-				dc->res_pool->dscs[i]->funcs->dsc_read_state(dc->res_pool->dscs[i], &s);
+				/* avoid reading DSC state when it is not in use as it may be power gated */
+				if (optc_dsc_state) {
+					dc->res_pool->dscs[i]->funcs->dsc_read_state(dc->res_pool->dscs[i], &s);
 
-				if ((s.dsc_opp_source == opp_id_src0 || s.dsc_opp_source == opp_id_src1) &&
-					s.dsc_clock_en && s.dsc_fw_en)
-					continue;
+					if ((s.dsc_opp_source == opp_id_src0 || s.dsc_opp_source == opp_id_src1) &&
+						s.dsc_clock_en && s.dsc_fw_en)
+						continue;
+				}
 
 				pg_cntl->funcs->dsc_pg_control(pg_cntl, dc->res_pool->dscs[i]->inst, false);
 			}
-- 
2.34.1

