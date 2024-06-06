Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6209C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437DB10EAE7;
	Thu,  6 Jun 2024 21:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dcbcn8Vp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C2D10EAE7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZS5SFqsI3TSHutMp7nFJ73Fqe5LyLwT6iQUKea/VOTAx7U/da4c1bT0DPzF4vCeUgXnYB7pBRNY1ysE2romyzLcpbL7Eok8wPEDgyjKep7+B3eRLbEpd8YcXQ5KMM1b4e8LC29Kq2j1WSDhkR+PBrx7ZUtaHCAF91a8EJkeBFBE+hgapaFzzFdM4xKTPjyhFFG2kbcx6EJ5lWHvPK7Nk/NKbJ7T7GpszTE1ONZKPjTbLk+lkNauLwbUG889eHqtV6+oG2Y9NfabIH6viyqetOiAtDGtPYncrLzCEsQTc9Nmo4A2cBMMcljEQdo3lIw3vMV2iP4KsU47qHTPjPAbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYkW+VHEv7BKZKvPu2jPYQKo471jyTh2Ij1WkseqjI0=;
 b=oNoFgblL3LY2p9NyvVRWDwIdPuOM7Eyy44F5HDiSaCY1h4I9ihsz0QNbEvyZCv0+U48+1mNpUcAWgllTmUe4K/QGsb1WxIQJb9iWKa32em1s1TNM7NnYMDiK9cjGWJkVhciLn0mYtTA76FwLvlOJzgxpy+HqfNcW5nTy0i8od0zUKy0+KazcONogkgTIf5nZo5uy0Q89a6SBPCdm90rY1G2vvjvwc6Vj+PPASIA0K0bI4HKpi7Gx8ERg7NTqfRuvDJuUBW6I++1nEy/KJNnUKL71kJOqrZm8ckk7Xr0XdijA0p9YfBAhpuJcMStb3PJVm2S+Cu8UN+OKIW2KnYuLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYkW+VHEv7BKZKvPu2jPYQKo471jyTh2Ij1WkseqjI0=;
 b=dcbcn8Vp8yXnWFN5Kvffkrd3Ugezfwpmcf9cgsRkIjSA63LK17m+Ap0An/q0Z+ddFGpJRLlZveZgKT7pEj7u4V6Rx54b9SdDv7XsFC1nyg1UkPLcRChRGUvSorVkdrQv9QYaWnUtD3Sa+oyJ0ty1tzvXtoMEvrmzAVtDE7obOZ4=
Received: from MN2PR15CA0058.namprd15.prod.outlook.com (2603:10b6:208:237::27)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 21:57:44 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::c2) by MN2PR15CA0058.outlook.office365.com
 (2603:10b6:208:237::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.17 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:41 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:39 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 28/67] drm/amd/display: Prevent overflow on DTO calculation
Date: Thu, 6 Jun 2024 17:55:53 -0400
Message-ID: <20240606215632.4061204-29-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 714335e7-632a-4de7-36f4-08dc8673b069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?snB8OEU7pEYTNtb0Ey4w4ai+yua9+I18QMqZ3rYKwcwtT3SNCN3hit57rlhB?=
 =?us-ascii?Q?RXpqqCi3HvWVJxe7dSTGW1cxCfCMKf2RMWLs2ooj6lQinX9d2rM3y4kjYfQZ?=
 =?us-ascii?Q?vG50//GrhPR1eWaLqmuHePdqrZ/WzHQI44/fPCvxuKuijQUODX9Np5IFt4Ki?=
 =?us-ascii?Q?QP4qLtw7C3Hm6QhAWanLUdE23nsKvSYQ/woCHSSi+GPz6grL7VFbytyLq/v/?=
 =?us-ascii?Q?zeJCiZKtp17Nu2iuxDbUn806t8mfsfkA6LFY1NQgJK5x2vpaSmFcgd5SZV2X?=
 =?us-ascii?Q?rPIQJ1ArzCEYjdyHJ99PjCID9CKWzZQdmXJ8TDIzNG9IT4qGtvIaEGH2CRx5?=
 =?us-ascii?Q?dAkm1MoihnqdLsyF3eQQe2/v9Wi6gWrUhaZoKD+xg0Kr2Lae4IuQzWTEW9gT?=
 =?us-ascii?Q?TZZotYQpsM8N3FOsYYl59WMSYP+Ma8saaOMCO+taoSSCp0apflM5he7ACrik?=
 =?us-ascii?Q?qFS9X6O1AOUaQbGKpEAmzXGkGbl2cbCJ3t04aWjSYEFiAtsaHKvDT6LnjtJe?=
 =?us-ascii?Q?k9P64/ddhqZbX/C3PUM0JMRzSTA4mz2I8ZuzGxvnav4+mwtnE5guLU/pNnvJ?=
 =?us-ascii?Q?tm9/UY4xLitX54ypaI8OVraMLCm8Fo2PGwAbrgv76JFOisTDi1J1Q5w4kd7J?=
 =?us-ascii?Q?w5iT1I+mU/eHjsimNO++n5mgeiPwQvUCm3WvX4mUXiv/LckZhWVS1A2m9gyH?=
 =?us-ascii?Q?cTCTCswo7SM9nFmjFyuINZ2K8IElfkQAjSSjDDEdZ5VkOErkxdkUNUPS+ahY?=
 =?us-ascii?Q?wnvFt1VEQ3wlQuIO590n6f6rnYy8Tw3ZiP773k0fFxamWi5vbnX6wKKgIDAc?=
 =?us-ascii?Q?mu0tT/CGvXyycjbzk4joiCh/HXuy/isEgxt0cRUuZ1nGGEMVWBFZRvYEn3rL?=
 =?us-ascii?Q?D4jUSlAoJa1042QcL3rHJz5WEjYSsoC/N5TSnDr8vuGsyb3QzpgeKLn0/Xn4?=
 =?us-ascii?Q?n1aYC2gvGVEPLCwVbX+621D6DTPG7XDRJiQV7dsaPdIQncDmllpYJHe36Iyb?=
 =?us-ascii?Q?D0PrTHBVt9sv2pgUfWyAzOSGnmZHERZgVMuD3IzchJ6L0qyO1ww7cTtLHa+e?=
 =?us-ascii?Q?WZ6WUMstt4wVJS6Luz6oIibEm/Zxah95crLynlG0HJ+h29xmYAgZ5h0o3Iqa?=
 =?us-ascii?Q?8l/zpkx9S2hTSj3EDRM/citJ3KXrOQcq6lKj0EuLTd8V7+o4YCxFzeZp9Cw4?=
 =?us-ascii?Q?4nOcDp2ont/kp6eRf6a3NYKDa0W64kBtizirYwfiv9DImx4+sSbf3aejhQOx?=
 =?us-ascii?Q?E+jrTq0rQ6rQwMEVyQJpTjmUO8obgsxowkWvVIsInJeexXFQ9R9f7EFY4g+/?=
 =?us-ascii?Q?UqXM5QIrzyCSriUxdkXtSh1QnqrerS8U1CMbWa2a4/xOTikXMlinpMb1IlOf?=
 =?us-ascii?Q?5/NyMomenL/Kr1/OTHyhLofSFaNz7SQxvSgzwyhHJlcWVKUhrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:41.8032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714335e7-632a-4de7-36f4-08dc8673b069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

From: Chris Park <chris.park@amd.com>

[Why]
uint32_t is implicitly converted to uint64_t while multiplication
still happens on uint32_t side.  This creates digit overflow
for large pixel clock which is meant to be retained in uint64_t.

[How]
Calculate multiplication of units in uint64_t domain instead of
uint32_t in DTO parameter clock caculation.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 63deb5b60548..042a4187fff4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1088,11 +1088,15 @@ static bool dcn401_program_pix_clk(
 		dto_params.clk_src = DPREFCLK;
 
 		if (e) {
-			dto_params.pixclk_hz = e->target_pixel_rate_khz * e->mult_factor;
-			dto_params.refclk_hz = dtbclk_p_src_clk_khz * e->div_factor;
+			dto_params.pixclk_hz = e->target_pixel_rate_khz;
+			dto_params.pixclk_hz *= e->mult_factor;
+			dto_params.refclk_hz = dtbclk_p_src_clk_khz;
+			dto_params.refclk_hz *= e->div_factor;
 		} else {
-			dto_params.pixclk_hz = pix_clk_params->requested_pix_clk_100hz * 100;
-			dto_params.refclk_hz = dtbclk_p_src_clk_khz * 1000;
+			dto_params.pixclk_hz = pix_clk_params->requested_pix_clk_100hz;
+			dto_params.pixclk_hz *= 100;
+			dto_params.refclk_hz = dtbclk_p_src_clk_khz;
+			dto_params.refclk_hz *= 1000;
 		}
 
 		/* enable DP DTO */
-- 
2.34.1

