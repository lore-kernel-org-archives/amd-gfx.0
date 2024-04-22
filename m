Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88250C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1620B112BF2;
	Mon, 22 Apr 2024 15:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/rdfxvB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC7A4112BF2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIHaWrB/E6ZnV22506LCRuYuer/Qrdlw3ly97CEauzgMjpyt059hbkMIZjOVsQVMLG0xbEerFmt6AuxVZ5dhMOYPsV13O3bzUZUi/mit7Pq3akGMibagXLqBEZ0/i1MEL13toaoCfCbWIE7z22cAdwvToyPFDz6XIdeWFrDerRsbERoiMMqCMF3MMPPSBXAsN+eTeOUM0K5GEzF2w3+v4XgqL1SJQmpLyWTzRbjbmVEiJhSdDdUH6FpsKk0n+H+7unLyKXPRhKCuJfgI+5mcmf1AZkRBMokQUB7+fFvswNeVNAm+QEZzgw5R+yougOKorur57yOMsCAxUPMoRyhbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBOmne2Smy8kGSuhoFO8DSnTuGuWksbS7WOTN/fT0GM=;
 b=bTBcVpekPzXQ7K3X9N/M1BMvyK9TzS2OkfxnsQX/KKK27g+8COKt5l2ue/eXhM+rN+gX1VeFhmjU0sfbu54ZdPpUQt8VRb56R0CHB7q56MaFsjPrIcy7iZvswN0GxIseaWYFfRj6ZCiCN/4Gv3pUKmg+QLoo4rtSfDG6fdGi/x1GMvNU5qwyG758epIXye3BKCrkSHo5o0eZV28v2fo9WfEh/Ywrbfuiws3BPfw3oEJBH+7zAXn0liQFbZVCiwDpNZo9Ed42TvclIRLvIoSH/hwxvalpmrtyP5ARPb7JsiX2NeZw//0iZyXISiaaafItGB1x9VxDujE3BL0UaAW0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBOmne2Smy8kGSuhoFO8DSnTuGuWksbS7WOTN/fT0GM=;
 b=n/rdfxvBC7fHfydXlrmoNkg9S2/vCK2H9YML65kFkjk/D2kAJ7Tkdiz9ybrGGqDPKOiTSJ4pzk9BLhb/ZgD2OgMtVZns8/p1n511gSa7i4PncMYHzofHUQk7BCOKhqq8I16/L9/MtmVcjti2+i9o/QY6LuB7jfcnMNjGfl0QJY0=
Received: from DM6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:5:1b3::15)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:27 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::68) by DM6PR17CA0002.outlook.office365.com
 (2603:10b6:5:1b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:26 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:29:21 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 13/37] drm/amd/display: Add missing IRQ types
Date: Mon, 22 Apr 2024 11:27:22 -0400
Message-ID: <20240422152817.2765349-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d85e500-cc16-45b9-128e-08dc62e0ff4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2DENQqVTiujZ5F3wn3fVIKmuYG1BvrR1c1a35hANZbA3H9RQ58xI4it95OzM?=
 =?us-ascii?Q?ljmX1zu/ovkD4Kdk87Exdf662MtURj0Xg+LeH7RuWKiL5lG+y8QLNyPV7iKI?=
 =?us-ascii?Q?GaEiVLEu+6WHHLMfcJgc0ZO04CzUlEKSC3fls3DTtdOCiYzU4qzv1w5j1nHm?=
 =?us-ascii?Q?InJZD+dJqRGBZWfEdXxXEaNiw2x/jaIVj8ZioxyazIS2T5dq+7IBdUExum9k?=
 =?us-ascii?Q?aeoUVm/PRxLD2MvcO95xhzGIzXnOsp3j6V6JJavJDpt4FQvvdopb7ioGsvZy?=
 =?us-ascii?Q?gHvhCYV0U5vjRsBcMk21rKiHANn5GHzggGK38OWV3poIQtxZiVg/VefXO2JA?=
 =?us-ascii?Q?SoZFq54RwwrGnGLYHEQIbsv6hiHoowCRaM5Ymwyxck6yTvQcmrUXWj2rgDW4?=
 =?us-ascii?Q?mvjorH0u/NR7ApKZVldNvApYlYwByjyIYKEq6vfLqD54EmKjC4TXE7Lv2Z1D?=
 =?us-ascii?Q?kFLGv44/9e1nGM67UeeqD53BVne7n+zo7NXRsJwSvfQBgKW0ZyHa60BBpuTW?=
 =?us-ascii?Q?BGGrAwVNsJkPD0MPwxihtgpzVcy9lY8FcWTWtw91XulVIiicRBYYWi/q17yI?=
 =?us-ascii?Q?Ptf5ykJq/OE8yyxu9GCMbqpJ22xVCf3JXOQq2G3O6wgKtifJ1fFBm55YfQBl?=
 =?us-ascii?Q?gys+q89mnxKaF4TsLWHvd9fedd+hDrFCUkSHn77Z0/hC1KHHIv+ZFtXDtwBR?=
 =?us-ascii?Q?4ecIo7OVfp+p5Hr47jrg5jW9zo77JMOgPJ0QKS1Kzbd+2Y7UYyBeJ1XHICgT?=
 =?us-ascii?Q?t0XgOYRHmg5Gx3BjFeaysWsg9KuCulEOMT51cc4RboDFJqwGvO0bYEJkP81a?=
 =?us-ascii?Q?zqKL+DnkMwgWcx5hs2WE1MESRJQ9NoT9ziSasUAl5HiQQ6h7bfVLS06yFmzG?=
 =?us-ascii?Q?fe83pK1vxAmp6o8eGDjfDh5lXD8fR9UJ6WQXAIqgLz9/Z9x/WU5WVndBK9PP?=
 =?us-ascii?Q?MlVOegIYN/a4zWJr4R87LAP/9jWgZ+XAuXDWlqoJ86hf9Q3z3tYWt/N8eOfK?=
 =?us-ascii?Q?z59qxFhKxhRpoYEJ2oZJCZC2wt66heUqD9XcJpVmqvOYcMEjNlAlc9DUFpCZ?=
 =?us-ascii?Q?4ZwjmoGdmj7OsxIvGKluclqcCNiR2xGzWVv/Vnod3nSXVD/Jba1F0gHn4FkC?=
 =?us-ascii?Q?Pwf6ukvp6ZhBv/cs5euUPkhOHglRXdiCtLE2RqEu3c/IFE9PE6EpR1oYmN/h?=
 =?us-ascii?Q?VH2mCNIekq/wtsn251YXcOCcEezj8GQeR6jrpts4mTpPF5+dgycD04i/xofJ?=
 =?us-ascii?Q?tbEKXVZfbBC0+f5jInHU+cdrQnrdWbd4iOq5QTl0ws/KSQRxfnabxk/dbrZc?=
 =?us-ascii?Q?Bd26AQVEgFAwt7LgdfwYAgaJYwmgcAYmvAOicUrhw40mGzvm+/0ssap+f65d?=
 =?us-ascii?Q?hkYRxitkBTAvGCm2KOQ/PaXdp6yH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:27.4136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d85e500-cc16-45b9-128e-08dc62e0ff4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit add some DPCX IRQ types.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq_types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index 93354bff456a..e962c426beda 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -153,6 +153,14 @@ enum dc_irq_source {
 	DC_IRQ_SOURCE_DMCUB_OUTBOX,
 	DC_IRQ_SOURCE_DMCUB_OUTBOX0,
 	DC_IRQ_SOURCE_DMCUB_GENERAL_DATAOUT,
+
+	DC_IRQ_SOURCE_DPCX_TX_PHYA,
+	DC_IRQ_SOURCE_DPCX_TX_PHYB,
+	DC_IRQ_SOURCE_DPCX_TX_PHYC,
+	DC_IRQ_SOURCE_DPCX_TX_PHYD,
+	DC_IRQ_SOURCE_DPCX_TX_PHYE,
+	DC_IRQ_SOURCE_DPCX_TX_PHYF,
+
 	DAL_IRQ_SOURCES_NUMBER
 };
 
-- 
2.44.0

