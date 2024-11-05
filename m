Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6328D36138
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A9F10E609;
	Tue,  5 Nov 2024 20:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6PFbKlO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042B710E60C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqcjLaedKeTxtd0lHp2ZQJhPB4OHDBSLpSfOv3Xj88qU9pSde4ssPltgPrk8wn3uGqKEnzuiHqLoke5ibbLVTrbSnGcfGy8jzT52axnjUxOeeoQ4kkdy6oK1wRMMta9PIGSH0ccE4NuLhJBd5OYxB2t6zQW6URAscawdTn9s6KaSJ/PD/nJwxVCgPeM91HrjFYdBb6xqoomspNPOLJK9y26a49LhhtftrdApcmxTgkWqcluLjOypvKuw/sZgo+mPlKSOMRtqWd0u++WwPwizNYIuqy/U8m7Eh4olgZkYmwNQk/NhJfxuCO2bzW6Mi3pwcnsxRA+ixhq7JQ1xtwZGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOkRa7JdoUD7smREHzUbsBN6yjcgOQZxdB/FvIiTedE=;
 b=Nr8cwURnTZbbYNcL40gr6gTJQhUy7xlHYnZgLNG7vxOIkkpqdvYmWBI0AsdO42Z5nGzFhpm/5cUJbdKi1vVwyygyqhOOXwF5w7DGScmp3y4Nfi/kdy5vcQk9KOulZm4tfASah+hu9alGmo0hhCKDKUZdEJMeJNWvCmAQ2V/nkFNeQ18W2DVHCgrEiXfSSK/fiRN4Xp+o+nlH16rKT4Vao+1WKjAtgLbKNsezXJywxQX5+2UNjr51SBsVYHwq9kadEZK00k+tv6QVpMmLxJS2sj/1weHA0JsC326PTO7QOtSnKUomvt5dcXZh3bAY4ynC5z5ERUsr3RtBNn3uasu6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOkRa7JdoUD7smREHzUbsBN6yjcgOQZxdB/FvIiTedE=;
 b=C6PFbKlORYWdNWMJMmj7Dgiwtw4U0b5wko+cSJcAPeuN9DV9AeCSvqXhv9yIf666BPua/JWSBVkH6O0Y+1Jqsx1gMRkuqrqYaGRpKHIxhzjBtt4W6nIshzIOkDMEDNaenH4H/dIcIBILYTRK+5bgmtVBqNfujKKCnKkfVOwtp0M=
Received: from BN9PR03CA0271.namprd03.prod.outlook.com (2603:10b6:408:f5::6)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:24:24 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::1a) by BN9PR03CA0271.outlook.office365.com
 (2603:10b6:408:f5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:24 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:20 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 06/16] drm/amd/display: Read DP tunneling support only for
 DPIA endpoints
Date: Tue, 5 Nov 2024 15:22:07 -0500
Message-ID: <20241105202341.154036-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7a4859-2083-43e8-08fb-08dcfdd7d6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GYI3VvNYyz93fGV+9rvfhyl9wINoSAQ/twIeTm3P2F4mn7YMqLGylcpPuUr1?=
 =?us-ascii?Q?n3vqX9wnTXXsXP0jKK1T7t4NkhvVV2JGj0gHGHZfDlmyVV4m1qXeoFPBccyN?=
 =?us-ascii?Q?CZTHtekywTZqwgoxcqkff5sr1a1oWbuCKh5Xkg2StIQ7UboiNpLZp5U67nh4?=
 =?us-ascii?Q?u3fkSutz3gnLhBLGIy5QxGJASgFFuf9Yd3yPUEgdd753lsIdiCdXKxF7pXg6?=
 =?us-ascii?Q?COoLa05MQvZ8f5o6zkAuiW9L/d1vgMLeF5OwOyrL5DHZxSMiaiIfpEPo/Qg0?=
 =?us-ascii?Q?voCuJAif1RenhJE0Q+fayvRVsHzvSJ76bFts7fdc6VQXzEopewYWn0CRAlTg?=
 =?us-ascii?Q?/wo38kLubuhBHVSC59cTUMPvekxV9QG81wL51Gark5t2UNKdbChTWvCyyTfG?=
 =?us-ascii?Q?a8ZhApxD3nZXhbXbHV9orn1AeSd8po7PKMj8AGtY7rigJWlm+J68JcCdYDv2?=
 =?us-ascii?Q?TJ5YT26NloV4ZMB4q4lsiJoSEwNHu131mZoAdwz/r4WbyhEmHabxic1eglk+?=
 =?us-ascii?Q?7z1cY4J+FeRLNj30vG4dprsgSriDpVrKf4jjACDT9FZ8euu0/8Ezt8YVTgkr?=
 =?us-ascii?Q?VUDy24xRkIiYKr3I27JfG+oQqsbCtyytHqeCX2G/UllVgf6mCOjNba9FVhD5?=
 =?us-ascii?Q?UjfuLSRDy+yl1Cw7TwSzBjeu/Eu8tV08EcjWs8dJioE/RMHTMwDZEHasgXbj?=
 =?us-ascii?Q?9xtZXyRAHlG2s6MrVVKubFvr59V6G3q/xnqv9MQKZVu6i+Jg7EQFaDhSvAQ1?=
 =?us-ascii?Q?QsEaxH8jNK/pYSdo/hVoyD5sjochYM5edRpTK2tmM+G+Fkyd4qC25cm83mEo?=
 =?us-ascii?Q?dC5N6rLGyyp/m6Z1HYii0tWEP2U4OFu9G3wkry+6VT3YwEzU9h0rJkuxdE5k?=
 =?us-ascii?Q?52kuSi20awkbZbrMlmyA4mRr1CCMGtNsJmdCzRSvO0r2gpt9M5j4RnDtqyvC?=
 =?us-ascii?Q?ACtMl/vThpewRgtCsTwt0bnB6coTKq7idy6bMYkun9NxnBWhGk8O6J8uDLhI?=
 =?us-ascii?Q?bkRD1YlBGv4imw5f812N3yhxtun/UTSbg7J2wcV7FfqpnP8oa7kokiCCkWDX?=
 =?us-ascii?Q?KsCZZaQPzOy1ldlYamOCU/7bvjjw888jeh4W//RwMcdOXizwWtI1W+5Qyh6d?=
 =?us-ascii?Q?OLoZDHMn4HXzPVqi2oxzc4OBeSDilsjoR++bFFGrYNTFGrPHK2r5r1Q6/xsk?=
 =?us-ascii?Q?Lsrh3XZdVtbIzBVkYV47Z2fpX1INL+cR97gcDjXlXI/InuCBTEH+UKAQOIWT?=
 =?us-ascii?Q?yfa2/0Kf2dxNNd7EhQzbs2dEacSEsJNA6a89L9B0BeaTP9qxev5EDJCFkEzT?=
 =?us-ascii?Q?QXKwvhhs9/pOEQWOGGbUbg3bt6i31hJ32mgy9Ny8wl4mbw5yT62L1iYA6/Vx?=
 =?us-ascii?Q?gPOiE1l/QpcAkPSx8XqRJ9viDgMgLv308U2IWwY8KnWJK4w+0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:24.0346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7a4859-2083-43e8-08fb-08dcfdd7d6b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Unconditionally reading DP tunneling support results in extraneous
errors messages on certain devices. Fix this by guarding the DPCD read
for DP tunneling support for USB4 DPIA endpoints.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_capability.c    | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 72ef0c3a7ebd..9dabaf682171 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1633,9 +1633,11 @@ static bool retrieve_link_cap(struct dc_link *link)
 	}
 
 	/* Read DP tunneling information. */
-	status = dpcd_get_tunneling_device_data(link);
-	if (status != DC_OK)
-		dm_error("%s: Read tunneling device data failed.\n", __func__);
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+		status = dpcd_get_tunneling_device_data(link);
+		if (status != DC_OK)
+			dm_error("%s: Read tunneling device data failed.\n", __func__);
+	}
 
 	dpcd_set_source_specific_data(link);
 	/* Sink may need to configure internals based on vendor, so allow some
-- 
2.46.1

