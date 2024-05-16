Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090ADC25B7B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D7610EDA9;
	Thu, 16 May 2024 19:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Im13qG70";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE2910EDA6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py8+J/cW2TCJz6pnqd9At7La49utFAEyfC96bkwmykfay/Gr+q4WiZeDX7jApT95u3QTVrHoMyMGIp4SwkvNE+O2cgxAAiuKYxwV0yqexpsJZDiB9cLc3qG20sV6gqytSY+40Mp68Y6KCQlFNEhkMmcjsK24923aQQOqh6WbddVpwi67hKsvGRtQgUW4SFJd7vbfDQUYBBnVDmSL5qB1qsJaoKtb02XZHrb229OrDi3MEZV58CFitn5ssH7A99Vce/qMHznA/y7B845kK8R1FDDaWkA3L5s4g2ULnGYv8eLNUsNDqsdnX2JmxhNZKfyseJgcaUbkr68Vfbc0AD70Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPcLKpW3TptzlOVstUUQE3jeih235GVyycjK1dHJ2EI=;
 b=Q6eBrSlqyB70i7wiGDJNvXsA29YfDmSz2lyUbqf5MNdOt5yiwB6jYGek3dAUhl2RU+OhzBwDvb+EcaIeTsPoM9zyjhJuQZxiFyB1qDAb1T29zVbgrBMPODSFUbgYmHzSVN/utIUwlLG4S3xT9cXSw/jhza6HyLIvy1EmTJT0+VPL2B3A/hsnq3Sz0GLty9AW9GfuzKdSv0S8h4LUQ+ofijx29EncbQEwYU6qzSKr2R6fCBAXlrcQQdsXj8kQj1KtksUqS2r0zgX5EF5JSllvbrWnPEQIkPO96uvJ6I3mldIhDPfSXVd7C1Md1jlnQfxPi5nOpUWSaYU2GcAF7omfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPcLKpW3TptzlOVstUUQE3jeih235GVyycjK1dHJ2EI=;
 b=Im13qG70vMHNItkoAHecwzAIabWkOwTLxrgYpTZLc21mRHPLKl6YU9LVzM8YjymVrr0empItSmFTOrRoXfebzyqebVA1FxXKHULoHuPf8Bdsr1mP0P2D+kB6N/dR454VxF/pBLPym2HmhOHLPQK5rT/xbVXIzYl8Ld3nPcq6jDc=
Received: from BN9PR03CA0686.namprd03.prod.outlook.com (2603:10b6:408:10e::31)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 19:26:58 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::a7) by BN9PR03CA0686.outlook.office365.com
 (2603:10b6:408:10e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 19:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:26:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:26:57 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:26:57 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 05/24] drm/amd/display: Use the correct TMDS function to avoid
 DVI issues
Date: Thu, 16 May 2024 15:26:28 -0400
Message-ID: <20240516192647.1522729-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 35127703-dbfc-4a8b-022e-08dc75de2724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UmeCjx9DTVTuFzKmXIl76J7rAvj1w8RIIxT4vtBwnu2la+Cq9mE+iSzR2zmk?=
 =?us-ascii?Q?hd9CPlSosNUz3SV238Z5cLh5l926Fb5kXFkT/fwUrw8XRaOb93y8TOrtmvf7?=
 =?us-ascii?Q?lbzg5jIeCwKNe94GnO3r7THNCkdHL5+s3P7H03dzeDeh0DDRmlWdOfHJ6nHa?=
 =?us-ascii?Q?yMk8MXMohkz0TdrfqJrYIJULu9js2fUpvpdT290iSZ3sy5BqRAhZ9Yt8poG/?=
 =?us-ascii?Q?T/ysIuprRhSqDeXWFR33UreJ3R8Z7V20Kuhp0SVeryN5DxT/vOCg3B7nL9JJ?=
 =?us-ascii?Q?lOXylw7r6GpKQ98YfzDHYv/k3tu1++l2Z1eDwrjRKvJANZoPgXOtCAkBasPo?=
 =?us-ascii?Q?GHDdzg5mMk8RJkhMZ5hkaXBCOamEw64fLKxqtQP9qa5L4tijyWazHOIyAvT7?=
 =?us-ascii?Q?BEIGXaZPysPSOmT4PstuNnELOK6ipeAEVf2sLAyWuFq9trRILOdGgbqoYkEI?=
 =?us-ascii?Q?GnNmoXbxJ181pdIz/wL5ia2OW8erW4jgCEMLs9NSaZlL9LT4XVErXwk8SUV2?=
 =?us-ascii?Q?5AMoTOdaKqukTjIj5ciWL5w4hLZmcvW63dllHvQz/jCMvdgVpI6anoGOOelg?=
 =?us-ascii?Q?UhQkWNZnnYNPADfjFiKNbtq3tGTFs9VqLgQZl3K/zxaeWiAW9V2E+VE8YIp5?=
 =?us-ascii?Q?dtH2PkGUo5pUpRH9kvvHQff4oqxaletrpEMy0wRs2RKN9zO2nfcnd751jb91?=
 =?us-ascii?Q?okhmPSOpJ56FrkGLTqyxBdG859qzIQKSEsi2+CuJIayDiSoksduYJLAQT7J1?=
 =?us-ascii?Q?i5dwjMuBjhfLMB5mZFYjzq7AMtq2WJqAQxe/F6TJC9yjS+Im+NErujO3a0Th?=
 =?us-ascii?Q?jR8bSeGG7FmB4isVpJT3P5F4wqAvGHoepjoAcwG6umN0bpXhuDGVlHaYxtYc?=
 =?us-ascii?Q?Db/7sVsIJJaaB69YiJKultcmST6h5aL3QZHXJ0hb9CWoExvIJff+cJlGhdDq?=
 =?us-ascii?Q?XMZe3d8jNTHtxQBHfZo213210LnezbkN0tj99wPsiPhp8X4Q2Ed+AJ+2mSnd?=
 =?us-ascii?Q?o3GXCLhtk5CG45egxwUPNKW8bgFSBzAu9y+Gc5/TG+kAXaA7dj3cBYqog87z?=
 =?us-ascii?Q?x7hJiWDwmCQ+hIhbVSvV8Eo4EsX2GKAweC/GMAOwKWWC8Ee/WLDT7lMAMQyX?=
 =?us-ascii?Q?BQZzD8c4NX0uWWBrVfuCXAvt0VpT+fes63d8bE9SsnFMKSdS/6ZcUdzVY4AY?=
 =?us-ascii?Q?UNiVlZjQrnyObeGhlqzG4d3G+HDZJtoBfWPEIPniReJuuQVKGSUqJluoeu/C?=
 =?us-ascii?Q?0WM3bseD/Gv7nvPHHqWsC4c4qw/KFaZC6qUT47GGYOND0TBjzSh77x5+XhNh?=
 =?us-ascii?Q?WbQyrhsQnm4m6e94NeyS5WyMN1jDyuxpcoBOs+xWUc4k7NhKoCl9zqOvNbvM?=
 =?us-ascii?Q?u6RMFEVaYZL+7acr8VlTovmxn91C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:26:57.9159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35127703-dbfc-4a8b-022e-08dc75de2724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071
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
DVI is TMDS signal like HDMI but without audio. Current signal check
does not correctly reflect DVI clock programming.

[How]
Define a new signal check for TMDS that includes DVI to HDMI TMDS
programming.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 6b33117ab5fc..f39700832639 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1081,7 +1081,7 @@ static bool dcn401_program_pix_clk(
 	dto_params.signal = pix_clk_params->signal_type;
 
 	// all but TMDS gets Driver to program DP_DTO without calling VBIOS Command table
-	if (!dc_is_hdmi_tmds_signal(pix_clk_params->signal_type)) {
+	if (!dc_is_tmds_signal(pix_clk_params->signal_type)) {
 		long long ref_dtbclk_khz = clock_source->ctx->dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(clock_source->ctx->dc->clk_mgr);
 		long long dprefclk_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
 		long long dtbclk_p_src_clk_khz;
-- 
2.34.1

