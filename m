Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58151C021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0979210EABB;
	Fri, 21 Feb 2025 15:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCmpK4pt";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160E010EABA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDn54rJEmF/G6jq9suncewW3YK4I9BxxknlG026QRJipRPC1ix9vN2FElK4Snz/3En8h84ipQaMV8+Tirnqipm0dn7pVoiEK2Hgb8h5bJ8Trccnb2SObgTs785aQ+0tn1VgiwGVsJWhZokCbHIp0y6ITCmslJfjXwrwZ2iDrD6osZdVtfYjrZVIztifrNXBWDzFXtooT6bnJVIpnpqEJvkcqSxnWSFLlsAxEUS3lcA9lQErIiEicZBTX4OnMpLjRc81uFypuAU4jvNFs8eiTH5FwjUaE9+veC3SeArfE1VHflrj+xTLCO73GPeOPkmEXPCJlrRvGgJxswJrszP2HsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjB9yZVEv7VcvpAIR7uRIINFsKrr9P+sYKLwuV8tkEY=;
 b=qZowzr3VMg7fiT6skN4IPaHD+oTCWPDgKL1msGhehOIJz18ylzQBVaTLkVr4qtGKcYLuX97ybNV29srsZbF4BPpS0A83lJPVfIPwGv+7Pvun9q6Cdj7UUi4kBaEDF1wbzCtd6QArwcNmSIubn/4/o1urVR1fR8LcvRYjxD7ooZLNJvP6TWt9rWEWiPodfL7h+zYvcP/ptpj+TSICoiWb390befrpttaoC01vCIRzj0GvZxMOrAuAQ0xpZotA1KZ4DRpqJAxycHhUCbqL0wGHeG+dlTun3VChUnzKJY90KPodaIXbq5NdXxdrkO94KrFH1Xh6b2XMkN35sB8dGaIBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjB9yZVEv7VcvpAIR7uRIINFsKrr9P+sYKLwuV8tkEY=;
 b=wCmpK4ptMVNkati00iafvKqCI9Ny+6kjxZPxpdxgHzUZ82pMomlaODig4n+Guvl2iEJmFFvHKKlzv4fzBHAzg6HsUg+As5t+uOihzNffQtzBGh/lGOcnLFrOIhuixTLTSTI3qETskDk8Y9Uj7gflhElVpaLUnKkY7vZIg5w0ZRM=
Received: from MW4PR04CA0109.namprd04.prod.outlook.com (2603:10b6:303:83::24)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 15:43:47 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::b0) by MW4PR04CA0109.outlook.office365.com
 (2603:10b6:303:83::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:46 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:42 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <Samson.Tam@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 08/24] drm/amd/display: fix check for identity ratio
Date: Fri, 21 Feb 2025 10:42:56 -0500
Message-ID: <20250221154312.1720736-9-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
References: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6f1957-4003-4ca5-3494-08dd528e8759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?No1bXuocG3SgLggIQzGiaJ384p9wX/R+x5MLCTn2Oukcr4rmCKkvBe34yeRA?=
 =?us-ascii?Q?knSjBlw89RWu9AVsoZxvRWbOoFMfQbhGpbFWqViuVtMb2+8m3unYbeSiO4XW?=
 =?us-ascii?Q?d/K1yhXenx51pvsn1D03TF/GJdp3rzTIHtT0p2YkNf73HuDDIQLpR0gnETz9?=
 =?us-ascii?Q?sR671F4h1dCnZSSvISuaoOMGHXHJjyY4QvsQHdkPVRu6N1ZypCkJhj7Irwc3?=
 =?us-ascii?Q?XW/N8m90hluLCVY9G/y8UHt425wYe0YW24CtHO8SXl58hBuEa72h724NWezm?=
 =?us-ascii?Q?cDiUj9LHjZh7dZWpYcaz+2rYLvugS4L2ikdi6TlngFtZdCeFaJeUE2QYBJMH?=
 =?us-ascii?Q?JMciY/gSi5yNzFF6lAo2zqMK68RIJFag8CLBf0rTVT5dBUNc0D0U+Yj9zUng?=
 =?us-ascii?Q?ZeTZzEiIaI6Evk/ZWJanGmsd+8xdIwi24I0vTMnZ6N5wy/vt8vnpnlWHZ/JP?=
 =?us-ascii?Q?HtAWMz7r0DXY756r1mzKIgsFvghYLhtpdCTJU2CvUuPMFT+n0tWyUJLEsCNg?=
 =?us-ascii?Q?Q0hs7LTwfhYycJiktdTe7Rt69hnVHFNt3RwnGSjf1mZ/JdqhV5GMkcRemMP6?=
 =?us-ascii?Q?u/Nj3u+X8zekWiZF6TwW1zSlJbKNZXUlaeKp+yrAWi0Bx4VVMkMRDfXOPjnM?=
 =?us-ascii?Q?Vk+MsSosyvSE0iixsvXQHY8fv3EM81XbKO50jEwXb0Q9AHhSFF/+nXAuXRLs?=
 =?us-ascii?Q?zpEq03GkeoWVcaJD/n7hFliu7Pf5h+DUsxgsTd3SISQCgBIeYxLJu2a38gq9?=
 =?us-ascii?Q?6VFv+PscdkXqg08JFZ0Hqy0YFCFpuWPmExFCzoOh57aLvOfibLKFFuRczGNf?=
 =?us-ascii?Q?eMvKhNIQ5NAzLajWI6OH3WYJFNGBecqhsdiXW1pcW7LAqPEQml0E4bpZSMhT?=
 =?us-ascii?Q?d+nq/AjyManXLu6qpuxvyrBM+dcyXpyYKTOBIT+IVJRTtNV05Qjfuj8sUeBO?=
 =?us-ascii?Q?xhEZDSQwixXjndITiHPRFuxVx3pcfr3XygFaO+g20w8gxfkCXX6ir3otgUG5?=
 =?us-ascii?Q?eDksOmGijdzsuWb3+cdSIOSC3nsLxtVrV4oPjcxfU+cuQEbfM+i/ccWRRgjG?=
 =?us-ascii?Q?Lm9QKWNhWpM7IfxJPqgPfThS9ce5WwoK78u/hXlwIdaKuZlyqJLgml0lorHY?=
 =?us-ascii?Q?CVhyyMWIECEK9Il1SGl/g1L2cshHCHlyTNhnMlYGoxg2pPaHdwbsUzbzv/zW?=
 =?us-ascii?Q?VruYUiJQAFbLHJjY0gdPDrUl+hfLUYvxGrrtu1QrtmMyZVs+G6LRpXTWeMXw?=
 =?us-ascii?Q?bUWXX6vl/v5FaVvsF/tEj6/ENRw9Ckq41CbQEFCwM7MUsFYkLO1n9yJf79X6?=
 =?us-ascii?Q?7izn0+sP+s7jnmE8UhqyhCtMJxmk4mja/8ZVoXfgRiOpkcE8BNt0/pOXmgOJ?=
 =?us-ascii?Q?lRWlAKXUXzOGOkgBcgrMtwNzJCHz6uxN52ZLGYbn4ObeNCw5NAKOcJTwx33B?=
 =?us-ascii?Q?4rw3PNDJ1Ru7sdS7Ga57KCd78HyERtg2NGcLIiBS/LfHnwdqJrT+oCk3LqDU?=
 =?us-ascii?Q?UyCdcLOvrCpkz+4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:46.4518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6f1957-4003-4ca5-3494-08dd528e8759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
IDENTITY_RATIO check uses 2 bits for integer, which only allows
 checking downscale ratios up to 3.  But we support up to 6x
 downscale

[How]
Update IDENTITY_RATIO to check 3 bits for integer
Add ASSERT to catch if we downscale more than 6x

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 21 +++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 3d85732cc0f5..047f05ab0181 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -8,7 +8,7 @@
 #include "dc_spl_isharp_filters.h"
 #include "spl_debug.h"
 
-#define IDENTITY_RATIO(ratio) (spl_fixpt_u2d19(ratio) == (1 << 19))
+#define IDENTITY_RATIO(ratio) (spl_fixpt_u3d19(ratio) == (1 << 19))
 #define MIN_VIEWPORT_SIZE 12
 
 static bool spl_is_yuv420(enum spl_pixel_format format)
@@ -887,6 +887,8 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 static void spl_get_taps_non_adaptive_scaler(
 	  struct spl_scratch *spl_scratch, const struct spl_taps *in_taps)
 {
+	bool check_max_downscale = false;
+
 	if (in_taps->h_taps == 0) {
 		if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.horz) > 1)
 			spl_scratch->scl_data.taps.h_taps = spl_min(2 * spl_fixpt_ceil(
@@ -926,6 +928,23 @@ static void spl_get_taps_non_adaptive_scaler(
 	else
 		spl_scratch->scl_data.taps.h_taps_c = in_taps->h_taps_c;
 
+
+	/*
+	 * Max downscale supported is 6.0x.  Add ASSERT to catch if go beyond that
+	 */
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.horz,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.vert,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.horz_c,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.vert_c,
+		spl_fixpt_from_fraction(6, 1));
+	SPL_ASSERT(check_max_downscale);
+
 	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz))
 		spl_scratch->scl_data.taps.h_taps = 1;
 	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert))
-- 
2.34.1

