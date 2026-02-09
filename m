Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357DCE81BB1
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87DD10E3E2;
	Mon,  9 Feb 2026 13:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vVjCvtCe";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0FD10E3E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SknZuzAb6bnwwEV5ZGmKEwnQC5ouV1VGzpUJ1aAilVExeYhXSItc/S8mgWkjlcLt455vi0m84VLHfxsubrq1764dLzFSBdZpkYyU0BuNgx0hcgK26smtHP1Vc3qzv0Z5MipZKlRVL57a5jvAt4EcQpwWpemXlG2QIlQXXOYl+EydPoiQOLLts72y9MnmmDT0lH2QEY3IaGe8IIEgCHqjjs5qFzmCM1SKiImK7BRQGWBu/1x4GIzp06RApKO7jSvE2e6UIMNIXBt27jE6rVrzfhtefvviUI/243PssAIkKab19OvG0ScxRZMWCFr5+HwnlMHl/w8/p171OynRFAGHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QCo/XrGNGmvHcVA8N228CswQsrkvvo0zno8yM2u+x8=;
 b=STlf1h9j38xeT7icUrkLlkfJgH6Kp/vsDUJogaljWK+iBL3jAsCx8jEI104ObGngzVfOdSbTDF2xKDJmvT5dpV0i+ucnYfhGGHk/wM9kvphZQSlMOfZdq30CZYPxLng4WFbxgMre0IiBfq/tE8ijN+sjgu0viaj0QSnJYiYehMaCz6RfjCbX4uX1RV3D7AS0wblyYICOuOmT3GDDn8dkQQzjsysOMhzrVf2gJGp0jlqgsG2U+0UuNO5KXNaWY8x/H2HxSM35rHddbxPTxPgy0NKmfUebQG3QHET8pg/WOc+y8f8CeqEfcF6U6qOZOeTP1hAhPGkoFi2S3ZFeIH2Q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QCo/XrGNGmvHcVA8N228CswQsrkvvo0zno8yM2u+x8=;
 b=vVjCvtCewnDEylNgghikm7yCYFwB/o6p7yoEo+u3wPyVonqZvPaV8cuP2BvZvXGaS/EYao/HWLY17s3YRc/Ph80rv2oGQPgM4Qc2cNDXhg9A9W/na0cYPr31NfbXF+MX57iEECs8YC/8inrkVRJzjhJEHrvYadEvdscVhCtnplI=
Received: from CH2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:610:51::30)
 by LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 13:05:00 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::75) by CH2PR15CA0020.outlook.office365.com
 (2603:10b6:610:51::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 13:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:59 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:57 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 11/11] drm/amd/smu: Fix User mode stable P-states SMU15
Date: Mon, 9 Feb 2026 13:04:13 +0000
Message-ID: <20260209130413.118291-11-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
References: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6a7879-ffa0-42df-9cd4-08de67dbd4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KR27Mu+At2ncuNqzX1AZR/J72Iq5FR3Ddm7SrAmyc8R56nDeFeaiQZb9Gesa?=
 =?us-ascii?Q?QvgM52hk3gQykUtqOvEzmkDPlhjbdSBUHzVI3qCcFSVIm43STbFcSgxo8QZV?=
 =?us-ascii?Q?qzltTim74B85Bg9CLFA3z38cNq6iIc0dlfd5MlbavuvZ7Xi1BVysWm9VPzKM?=
 =?us-ascii?Q?ohy/Hk0CTlthhstlhn3NcZpOEbWrofweWgResbgZSaGBA5NBAJNZepLGeq+o?=
 =?us-ascii?Q?2lR8T38Y6byRBDLKo04ZrktOoxNegjpO4O9RwaT9zMdVk3REQOntq6zEHLEZ?=
 =?us-ascii?Q?IZ+0khjaRUJiXth1AGWH2ZbSTlUqmDq/18ULvcpeS2xlnyQqgaFfEx4KNyZi?=
 =?us-ascii?Q?FYAsCNVaXYFvdMpWKme4VfvN6wqakRsdq3megFg1cLEzbycz7l4W2Xy1NQDh?=
 =?us-ascii?Q?91E+JTNh7UgNF7xsHVgan6toKnSfa69yqHNfTlpmLx99H75erQyvoRQ17x2N?=
 =?us-ascii?Q?jxaAnHXLVWzYQOMvFbUIt2ir34xSrZwGDOD4HNZpXv2eyVslZYMy3N2a8HuV?=
 =?us-ascii?Q?GJLz9cEztalYlSwyk8C5b9Ipk+8qlUlwGVwREClemuaWfOWUYD0Cnf/e0MYk?=
 =?us-ascii?Q?j1gYUTUDks2sp0fNclheteqxPwK9RikwWBCYzfx6ZVXMFqrA53DcwLKHqXQ7?=
 =?us-ascii?Q?3iyPp6DF/K2qy84YTK54g83jKO20g//HbuTNBZgCSQMY/TZXkf0k6Fq0tEuF?=
 =?us-ascii?Q?VS0MEOHEPRdNW6/Awr2iZLjf7uUlPdqGC9oaq77uy1YdoicFT+8mDXmUtVCc?=
 =?us-ascii?Q?L8NelrDtTAyRum4RARWjnEcXExhzaCAlapezpkMZ2nawfDgz7R9YQ/SpqJhG?=
 =?us-ascii?Q?pWzBjS8G+1C7q2lTt+/CK1bHWrcAZZVUd9WiEqbZw3uG7f4fieHgl/CeHh1o?=
 =?us-ascii?Q?5UfP9Lm8L1RuWtEhHIB9xu41FEE9+ToAoA0haMy0h7RBmjkXA4kGWfkivizW?=
 =?us-ascii?Q?Eqg/ZyfYfIuaDpslSvyxpLdE/acPJ6PSWsLewRW8gMT1jDznNzBpOkqmsgmT?=
 =?us-ascii?Q?SAkBdivXjY+caOEGnezzuRWyZldbZj1MjfeX8y3Ij3x1SGohCxpvf4fzyPsz?=
 =?us-ascii?Q?U60WL/p3pD65zn/eDR48zZp/KH5t4ePny6gFKcjOKyl0F+MS5YgxnB4uuqrg?=
 =?us-ascii?Q?xbSTjOccUmELhjjuKO/dw10f7ZsCsACBGRMZG7nsGEMA3DLkh/hWEP5aoJar?=
 =?us-ascii?Q?jUhkpkB13jaibf4PMMx4PCs11pQRRLGUZOQsgL2DBn21T4NFcGmCGdRtqT9D?=
 =?us-ascii?Q?TffGGcV+EW443zXG+3RgBupKSphtzuRYbxpB8fjmSL4Rb0fBtGkDBS2+3u3n?=
 =?us-ascii?Q?wH1gVAV2RhuD8TGrowXzwZRsGkG/wOrRzKAvsiXAWNVF7091sortKGe69Jyv?=
 =?us-ascii?Q?UkkZDj/pH7yl0u5VhBlJg+bzSycS61PME/tlY86nb2ZZjEsPjRRtzcYK+pqK?=
 =?us-ascii?Q?VXjclWyylsmqNHKQRPtOA6E3FWWjyZ8JGnCtW3PhP0VdGBaL901cj8/E7zas?=
 =?us-ascii?Q?bpoXxCjFTdlrzUyRTMdxorOeOYKmLtRHx6kAbj0to2MVzh/7xIOIr94DJCKL?=
 =?us-ascii?Q?eV6U8+BGb3THe9iSJPvwA38Jsq3VgOuPmHuABeCj8+0OpNOKH2o6YivB51qW?=
 =?us-ascii?Q?08RYunQfZZnPrllshUeNJ0cRlCDuxVDSLbjU/PIKrt5R6TkSlhN7URvHraMP?=
 =?us-ascii?Q?PKYPOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U0OrSyF21nXhZwqb+D6G6S+7u+a0/nMX5QDnYy8SLX4JN2xXGliJUcK14ELPwVF21ZouJxcO5vUFECllXM5yKQbREqyA0eGZGH2lwpHOLc6prFL7YvShD/06hfyUOXgcUyNh4Xqs/L2ate/nKmOrjGe41MFLYCgcBfA2yWI0g6xJoJH8G6vHY2r6V15jjyCCwl7QSCWHbM+zzmHaTlXkh1FURRl1iJe3uiytEQ39nS5Cu0jHJlPIh0KMyw/zxzh/oAxJxEKnVyuxzq1B/dQ3xAxGTKVtMAiM8iuCRiLW1Xq7aqBcMudJF50jQG+KTW7l5rCDCvOZ9+UWOy0Wp6HLg7WU74jXmhbSIYSHJ+qNyFt53SxGcq/7ZMpvJwD3zFO/ytgOCum97V9DWuQ4GldRGaAIWMSJfH/X3kUxelGlDl/JiJQOej0PS/Tw7POPuXsc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:59.8963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6a7879-ffa0-42df-9cd4-08de67dbd4d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831
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

SMU 15_0_0 exports only soft limits for CLKs
Use correct messages

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 72a78fc5c827..4dc8f0095713 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1026,26 +1026,21 @@ static int smu_v15_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		msg_set_min = SMU_MSG_SetSoftMinGfxclk;
 		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
 		break;
 	case SMU_FCLK:
-		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinFclk;
 		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
 		break;
 	case SMU_SOCCLK:
-		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinSocclkByFreq;
 		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
 		break;
 	case SMU_VCLK:
 	case SMU_DCLK:
-		msg_set_min = SMU_MSG_SetHardMinVcn0;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn0;
-		break;
-	case SMU_VCLK1:
-	case SMU_DCLK1:
-		msg_set_min = SMU_MSG_SetHardMinVcn1;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
+		msg_set_min = SMU_MSG_SetSoftMinVcn;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn;
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0

