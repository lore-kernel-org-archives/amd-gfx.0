Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8136EC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3374210E8BD;
	Thu, 25 Jul 2024 18:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vuyqUqv3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3975B10E8BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwFXayH1oY8HeDyuNGgllFMhsbBgvvb3ry5TxSX2nx1qSlbfinx9iTblzij2Lqr5WvV43ds372XB8ZNiQm5rlznSZYrdLjeDqsXxo1putCTqNwGzNTyY7LE17VEI8OTKsLGD+lzD4ne0NVYz09w48ynvQbNLxAXP05unq6kt7L6azdwj3kRnNg0rL86BAJ7pAntEKunRPCwtzwcVLkx//7XbZKMzpSCUgv3SQbynZa0DV2OMnS/cPrwCb1WVkR8TIqHqZ1VTPvh3QesQ9XsN/gAvaiJHiPKH/rdoBdR9RKVEasLV3jWCdbypuDzri5N2m/vejXTq2LFY4jA7xLJB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRBHue43OFaUrsPwv0YngYTiKzkA1sIncwRphkQseE4=;
 b=ZUlFXP1yt+xX5VrbcYgFIMZc28yuFWEK1B8ePtM5PHoaFB5LB018bQpRoF+JxWowkRd0vrSUloEk/ydYVZ+ijJ2/689q5m5kXd5rkG64bfxpQAWNxHlTA92T4VHwRTeLNma4uUZwW2ODE9YOuNliP5GQG9IGz6sBtliTq8sYkL2squcwBZJJWOXjWF9eJhey1VZvYAI066Ko2GGNicmVFaqyRHYC5GhgEUQUsjVK1p0z842nZc0GHYn11sypeagcp6AjrZ1F4hbt0/3YOzi1xU5m5lGcwJsoNI7EyxyREJxkGomrGkZymPDEY0daOZ6tFFAajYslpSUaawXjTr4Tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRBHue43OFaUrsPwv0YngYTiKzkA1sIncwRphkQseE4=;
 b=vuyqUqv3gk0DZ2Pn9BrqCdVcc173AlFgJV9jgq/feCClnYrRhqlFv4H4hGOH2hwtEdv8AxtQHEAN+r60KrvmM43wfHPuiiH22RyrUHUW2S7/bjiBt/61JxqAQ4aWr/ezPBOY3IxrfAT+SrEzQXHtaRae2xYkHCojnS+MUwKKUXM=
Received: from CH2PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:4e::24)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 18:04:40 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::1b) by CH2PR02CA0014.outlook.office365.com
 (2603:10b6:610:4e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:40 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:34 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 35/39] drm/amd/display: Add missing mcache registers
Date: Thu, 25 Jul 2024 12:01:19 -0600
Message-ID: <20240725180309.105968-36-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a5548d-7b07-4f21-d88f-08dcacd44124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9QgZenkUUEGXUsognxGSJD1rus5wddtgjMZq5uAytgYOka6Z4lQdEyYnHfnR?=
 =?us-ascii?Q?Gu5K9hJGUthJbrAy7jaGx9j0jyKJlfK5AE0IScUuAPRhR57gSX/FdEBzkzz0?=
 =?us-ascii?Q?E9Q8NGoJ/2BcBNAg9vNsmthcSvN5MTJ0ccYKNyxB/byT/N3QhXZqbVX6p/lK?=
 =?us-ascii?Q?nXkL6ZJ9RCif2lOdEgBpn8L00gDPk/sHZU+KwP6+A0mgTr83lpTqGgxHva6w?=
 =?us-ascii?Q?xv4WqeLsJrOFAiGTedO4fuJ/ErQ2Ey++UZ5uBt/LUk65Y75UlGFiqpvXAvS7?=
 =?us-ascii?Q?4uDsecmm6+I0vDwKMBQNHvCt6JhEc/CLBN3xFel6nmD6rlh3ALae3Qa2weqI?=
 =?us-ascii?Q?7Gk4N86GGQ73aZGANwkElwFqrPoHtbdRcfZ6ULdB76Ty8d8GCCwfPDKndRFO?=
 =?us-ascii?Q?fEMGVmNIQpd/N15k8b2ohF1rpdRlGiHBJfdXIX5t1sb7uY0P8jyr17rcjGL5?=
 =?us-ascii?Q?kjLqx4DZSIX1+Bd/lgpBPlV9/tAKKilt2ekY558feWS+K8klQBNZRCsE5u3g?=
 =?us-ascii?Q?6qAWOVhHufuFZoKJjgFYDoTigJHjbE0rCxJnfNPNvF6z39T4+NGYyCJn9a+w?=
 =?us-ascii?Q?oQMVGaPe4mJ8OcMc2WET5JuGIifWw0RnXQn5ptKO2JRl73VVgEGExXdcmhmV?=
 =?us-ascii?Q?8HuoIjC0pLDTP1Rcnj/PN4F9YKxd4TNQuzV8sKdpTTHUAoYkiJJYkoFPN2XF?=
 =?us-ascii?Q?90A4asP/SfswroQBqE6Aw5GcXS75dHPi8bKd7kKCtJBkTAavNhaY0bVOxs+q?=
 =?us-ascii?Q?SQPABLmq13KaZhAGPzYf2AdWkXPVb+3KyN/XBGeZBypz7omG0i7o6KEOSz8P?=
 =?us-ascii?Q?C45XeHvUDPIS/Lemw+fhHaKXnLh6IzFHXExAiF4sdJ5XPsIYtLR9pE15kmbm?=
 =?us-ascii?Q?e8kFqiukqE8hNVprSX9JT2NDWg8qtAz9cHsPA5DKNwcDbLKewLrory7TP3pA?=
 =?us-ascii?Q?P9wrT0/XK4iXv0S/79Dr3n037AQMlKs9j6Lmbh67PhYDWvDJnTy0SDxil7Oo?=
 =?us-ascii?Q?6S1YQ8nAslualf/L6Atfyp6ilj4HPykaX17mKaX17rP5wDtEClOnb+IQzUCl?=
 =?us-ascii?Q?jfANw7/nkbXSjB2djrU5ZKtwWKnZeHfcSVKhxVMSiJG4/3X0JgMS0/EzPnSK?=
 =?us-ascii?Q?4VKWKs5S7aJpO8eQywOeY4J029Gf5GzEUhgwBx4VDuKZ2lQxQfsxDZOH7GWX?=
 =?us-ascii?Q?yPi/PPMY9pj0xlgztyp0u/bhKt71qOfgQn+M+CrK5YyG6oaNuYU7Qj0iBrJz?=
 =?us-ascii?Q?P3Y5aGeDAcb2IObzpCS1Y82i0AXwIWr621nclHvWt0CpH8ZnX6+55USJyeG1?=
 =?us-ascii?Q?AUXkOCxg1whZdI1989rSwnViVtp9ZVCpeCj3hK/H6gDHNjMnwGUn1tM8pAnb?=
 =?us-ascii?Q?3oHWA6NDY1MUtcHEa6aMIIqqIvBHJMf+kLrruNei16FlhB2IQlz77oFqDUFP?=
 =?us-ascii?Q?qkp3hu0Vf3WcaHs0wwYqPrkfcPELWi1l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:40.3402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a5548d-7b07-4f21-d88f-08dcacd44124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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

Add missing register programming for mcache in DCN401.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 106008593464..514d1ce20df9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -138,7 +138,9 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 	SRI_ARR(DCHUBP_MALL_CONFIG, HUBP, id),                                   \
 	SRI_ARR(DCHUBP_VMPG_CONFIG, HUBP, id),                                   \
 	SRI_ARR(UCLK_PSTATE_FORCE, HUBPREQ, id),                                 \
-	HUBP_3DLUT_FL_REG_LIST_DCN401(id)
+	HUBP_3DLUT_FL_REG_LIST_DCN401(id),                                       \
+	SRI_ARR(DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE, HUBP, id),              \
+	SRI_ARR(DCHUBP_MCACHEID_CONFIG, HUBP, id)
 
 /* ABM */
 #define ABM_DCN401_REG_LIST_RI(id)                                            \
-- 
2.43.0

