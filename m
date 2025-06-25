Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C423C7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D554810E652;
	Wed, 25 Jun 2025 04:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hK7n2duq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 265F810E64E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUGr48MG14/XFd6TfBlUmrKqguKZCL9PvoWCGnHxZsUFLQIDWcR7gXIwpr0y0vMBTuLIXII5tIwnL0IMlWt0l4XRtS2ktSYkw8d5i55OXOJcc+AwuABvCUODVxcNpbrK4lewdfYrTCRsSzQhoaJ9woK0awLl5VX7f6Fx/K789RuL/3XJbDgpB/x/OASI+uTah4BaG6X3zVZMNURfPKT2WUaMRGITy3SnNUfrL5UrGEGFhG6+JKg7yIF/DAEruxd9WEd8BCEdE+7kF9iEcp+UYBXkXBkLvmNOW3fk+8RPIhicBx252QMDW0JXOuPUNt6jdk+MNThcUETEfwejyuaTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBplBHRxzE3Xe8BsUDfn6NLPn7xEZCgOOPafkhAT42A=;
 b=qUPf1NVWttNL4Ht/JJ7X38QdJyutqenpbo3eM79TCPMY5wMzkKpgkcVqTsWIKDEcc+oiRFVpS5tZHyCMMyvOaBvtT/bGMVlNQBvEkHUID0Y4DKHOVcaY5xG8+CliT6MzAAeIaWhte/bQPs0nNX8FTfs7xI4IXwYYrmG/RvZDiCTTcjQPuwvq2F3rTTZw6FE/1Y6fdg5GSY66HHbd2StW7rF+9Z0RzKj8mzkCjIfJP7IZLHJWfHsFL4IWB2pYpk5siLRFPfEOSZw1muhNuXshL26u/Kwe7g36qLIfkEPpkkHDMzqHwyG/OZkhKuC6spTJLc2UEF+JH6M657MdA4kJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBplBHRxzE3Xe8BsUDfn6NLPn7xEZCgOOPafkhAT42A=;
 b=hK7n2duqMtATlBlwvfDps/YXMVWgaBMrbFytknn2yMdXFms4vw5ELRVvoacal9MI3MEdqoCWr4pdmX7ad5xes22blIVNKfJ5+OXboh/fIX2Wc32N929Y9KciQ+HW7+TNR80ohwe5uemlo1Rou/sLYMRTXcp6CYhAHk+Ix5pvCxM=
Received: from DS7PR03CA0338.namprd03.prod.outlook.com (2603:10b6:8:55::31) by
 DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.16; Wed, 25 Jun 2025 04:05:27 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::26) by DS7PR03CA0338.outlook.office365.com
 (2603:10b6:8:55::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 04:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:25 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:22 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Karthi
 Kandasamy" <karthi.kandasamy@amd.com>, Nevenko Stupar
 <nevenko.stupar@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 03/11] drm/amd/display: prepare for new platform
Date: Wed, 25 Jun 2025 12:02:21 +0800
Message-ID: <20250625040420.886013-4-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 0879977d-0c33-45ae-0705-08ddb39d8458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?71SUXOsu4ZH0piGlWPVdy6IMdomE4r57/3gNLqZa+ag09DULd3nYeRSCkeju?=
 =?us-ascii?Q?9bwjlukBNhcfbtPIfjZpdS0bpR4t6Vud1zoJxNYmGmxjzMbyJX8HyaG9NTgF?=
 =?us-ascii?Q?wW7jI/eWijcqanyESuHpBnsZCWsAVvsOu5g5uqz73gJXQS63NWmtwMAuFcLg?=
 =?us-ascii?Q?1Xh4iGHIp3wPtbeSmOmt3YcxksolBP02Je7Kg1liEr0a9MW6gs2dnLzWERDV?=
 =?us-ascii?Q?9TF2YZmG4Ke0YLJOvdG7YHsnwHzaEwMipnKM2OVrFb+2P9+9iMQbtDMIc48y?=
 =?us-ascii?Q?AHoJdVYqUpGpj1+xD4X6DhF2WJq6Ec097geEAQVZAiIkOtArLqxIOcgIt+me?=
 =?us-ascii?Q?7cLw6Yvheg6M6zYn5sljVb0W5BlUyQ2a0iSz/bWRW3mqMArJW3J2hE5KalUR?=
 =?us-ascii?Q?r/WFj2EGQdxG9k+u0DhFx7VohOjhQt1+V/irYnK/yrQBv0tu8DcpDgO2oaSE?=
 =?us-ascii?Q?KYQxEjz28fickOERtKdqC4tiKKJW8xNN1FMHuR5jUlw/gK6gJeFpnsWANleU?=
 =?us-ascii?Q?AzkEMKEQwTuw7RFWqZ1p7gJbk0d027mG9v0OI/Y4/szYORNGryA/VBc1dRbN?=
 =?us-ascii?Q?Ss3t56by1pRHV5qBqb4YAqeb6w+HnpYLgVOqbayM6cUrOAm+jE9OlfEZwD4l?=
 =?us-ascii?Q?RyEI78mGOPM6aPkNrcU44TiRoIM5IknC4oII03lGoQwcLOozqEyNnt7Rhv+J?=
 =?us-ascii?Q?gi4aRqvUcN1KJw71/zNx1LkIp1lUl92OOeJtrNUJywbEbijQjKMckg0T+8qP?=
 =?us-ascii?Q?BUqzZzWLbof1dQQuatZdQ/w417V4x31KOkvhzuRCV5mSz0OL8a+STouzV9Ib?=
 =?us-ascii?Q?KoeoJ402QVK5ToIPfd2dIWmzYjoCxxaJAs7Gbzf2rlEaPRNS3+J29bBzyJun?=
 =?us-ascii?Q?xsx1/uK8aRgfk0sFf0Ln66lHSET0c4RBNhu0IvVaEibtTdSJt9Z6j+Z1xLBj?=
 =?us-ascii?Q?bqo/4LO+IYHwl3O/Y17B5p6bm5JY32AElwzvTX46WIq2ghi31Gkf7Qd4+opb?=
 =?us-ascii?Q?N7AFeiPU/CVC3ITQoaqrmq8YMA01DSuFj4aHUrf3sT6ZKoqz3bMcn/A8oUdd?=
 =?us-ascii?Q?b3HK7+OFdM96hhWe/bVT31ylOty8u4k05LdkvVV67PxQrsNZkwuIRKSQw093?=
 =?us-ascii?Q?Asf4vjFuc+AAvCgcWKzhS4v24ORkMlsco/pAQo47azsvcwaodykycaK7Omx4?=
 =?us-ascii?Q?PvE7z+IyYyGF/RoTQLeksB5xncrhZJJJjWgnfAMuEYBlwEzxriOO6Pcx2Taf?=
 =?us-ascii?Q?phl6w1PrOHWQQ0Sp2C9mVKvvQgIUClk8LLjg4IXunAcEsNmIvlf16mf8qX31?=
 =?us-ascii?Q?HesAJdOubR79oZDhP46HZ8ERVfRI9RZU6ZmQhp1GlZd7DrqATz9552A5qW6d?=
 =?us-ascii?Q?Sl/wsYHpkN2n2FFSbjXQwswlac++erk48WOKaARKoeACwgxjeOYERrHjYJAp?=
 =?us-ascii?Q?vj5vxgc1PEnyyDzlBsI7J2YNn9AIloxcFSjG/7+dEQBJaIYMEgJUkSbpKlHO?=
 =?us-ascii?Q?02fy9V3GQCgy8rPZSsrHawtka2MV6QIlDguq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:26.7265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0879977d-0c33-45ae-0705-08ddb39d8458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

[Why & How]
Expose some function for new platform use

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c | 6 ++----
 drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index 4222679fd4c9..af5de564faec 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -17,8 +17,6 @@ static void dsc_write_to_registers(struct display_stream_compressor *dsc, const
 /* Object I/F functions */
 //static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
 //static bool dsc401_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg, uint8_t *dsc_packed_pps);
-static void dsc401_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
-static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
 
 static const struct dsc_funcs dcn401_dsc_funcs = {
 	.dsc_get_enc_caps = dsc401_get_enc_caps,
@@ -66,7 +64,7 @@ void dsc401_construct(struct dcn401_dsc *dsc,
 	dsc->max_image_width = 5184;
 }
 
-static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
+void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
 {
 	int min_dsc_unit_required = (pixel_clock_100Hz + MAX_THROUGHPUT_PER_DSC_100HZ - 1) / MAX_THROUGHPUT_PER_DSC_100HZ;
 
@@ -191,7 +189,7 @@ void dsc401_disable(struct display_stream_compressor *dsc)
 		DSC_CLOCK_EN, 0);
 }
 
-static void dsc401_wait_disconnect_pending_clear(struct display_stream_compressor *dsc)
+void dsc401_wait_disconnect_pending_clear(struct display_stream_compressor *dsc)
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
index e3ca70058e64..1d927d8e83bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
@@ -341,5 +341,7 @@ void dsc401_set_config(struct display_stream_compressor *dsc, const struct dsc_c
 void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe);
 void dsc401_disable(struct display_stream_compressor *dsc);
 void dsc401_disconnect(struct display_stream_compressor *dsc);
+void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
+void dsc401_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
 #endif
 
-- 
2.43.0

