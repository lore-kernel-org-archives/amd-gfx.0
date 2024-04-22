Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C5FC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C41112BFB;
	Mon, 22 Apr 2024 15:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WS6lnI5S";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67896112BFB
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2mblk7hbQWiWwWQBRHCr6/2HB69S8o67Lg8SEKBOr327RkW8sG6UjsgbfjxbE2eRypKSQMSjnm0j9NS6w3i52GYyuNYGOcCWRE15uXoYjSrA9L07/ekdderpr6pa/MwQjGfmrOrmG6a6rSw0d+hFprdhze8sVflYxD8okH+GaJ2yryVgjrZd0pOh6MH4OCWbpmM2F3ehSmyj1r5elAaompTP9BKUN7/l6FGxVzoTkgeGxcdwLmw0NtUslvJSHpoEjWMkZDjjO/vpEwf70RVMHHte8L22p3sDp0FgeqTpb8AjhhDGN5a4MApV21OxDffksewlOUDVFFUDxqRGBP+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpudXa61SRIUyz3OSTge0uSVbi7ycYakVs9kKRLEXuE=;
 b=hbmmwR34NCooSZRht2+cwzqg8WwGLeYoWd+9Larx+YqGRIh3gumCkoe0uZ/o34/WeSxHxUl6kq19Vea7iArzy3asXxQTPaUMWU7UJftM4U3AIZ61+MFFJnn2kmEnF5P317E0skYd6ykPpl4UkMY57fBlz7zw2U3GmsLZEerErorRrL1caP7486Z9AHsTBe9OtUTbis2m75wbRl0FjaQTwR5W+lDWUfFE9Fiz23kCTFZHS8s3t3Lzo+ZUN/WxxjUuZkc1EF0J8hs06Qpzu8XkrnCEZsZVHtQn5ppCYX1vnvY3jOyBGeMRlaAedKtR9bRT5QWFtWJYmiXPgHQP9X+XOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpudXa61SRIUyz3OSTge0uSVbi7ycYakVs9kKRLEXuE=;
 b=WS6lnI5S9S0+75l/8XRwOilxUD8LRk6zP+KBigEtji9DCo5SofGFpZN1NJCirXU9Slh4xxUYAtdl6TK5Bf6f/yG0SsRAQC99htbp2u3bA+yAk9GYPzz6PanixwKoij4fAW7Dt+AmZ5DLG+JVfSlE6o5EutKso9Nt/23wnSl41m8=
Received: from PH7P220CA0120.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::22)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Mon, 22 Apr
 2024 15:30:50 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::2) by PH7P220CA0120.outlook.office365.com
 (2603:10b6:510:32d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:46 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:41 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, PeiChen Huang <peichen.huang@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 26/37] drm/amd/display: Allocate zero bw after bw alloc enable
Date: Mon, 22 Apr 2024 11:27:35 -0400
Message-ID: <20240422152817.2765349-27-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: a62f9386-998e-45dd-f651-08dc62e13015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?THv7sBCqPgl02HF721ExtdBMPEQn3OS//5J66KCxZPqZChlTOYwgYP9IiRmU?=
 =?us-ascii?Q?h14ipu/Gs14sXAxIZdYJZu/Q09wT+oeK4Wu9UxNvVAupwe773NWGXhD8TseE?=
 =?us-ascii?Q?MeVUnDlR6nEDdR/IYc44jSV+XcA+cCFqow9B2omoxuyO1NF5G8ghAjg4/G3C?=
 =?us-ascii?Q?i42lGj+UAWBL5jTLpYcVG2+C+TpMjuzttw7qbZLTqKdhp7pOHBZ+qHMncWMI?=
 =?us-ascii?Q?G1kIzmAJZhZUO//8AEdhghOFEfe9t6wwE7nhr0b8KswpawCRq9GKHebXchiI?=
 =?us-ascii?Q?JoKoKBZj1OLwrgQ+qSDGImIbPRxL0PTfI5yOCbuJPOa3OqpC7TBAdclpF/Zm?=
 =?us-ascii?Q?12T7TASqwXmmlR16Ga4OVyCqOB05EmIwR99ykqPq+0vTiYe/CzLX4xRZxrgb?=
 =?us-ascii?Q?PEGa4C00D7UJog0mATzzWbtDLojX+LhoaA+nUwwsMyHtM3iIpbhgIEIS19BG?=
 =?us-ascii?Q?Lh5nOHTCFSOeB0+9iEMaFUKT5xcbf4QpRDgDR5MmbycpJZ0V8q2p/YjrMHsl?=
 =?us-ascii?Q?avdOgBvjSNuW2mh9X82RBg4jzxGyVb2bXCFFhJEE6QTMMMjN9s/TaHqRFYLX?=
 =?us-ascii?Q?p05Q4iUL9+cb10SHvw/UzGzTXFREjSbIZMsIoE1hTaUc5jM0aPOl50Oxqfu4?=
 =?us-ascii?Q?cTSx1ELo2oY5F6xk9Iaw0gzjhrgf0HNTfkxOYhd8klBsLlgH2+qED2VIL/eQ?=
 =?us-ascii?Q?fRfOjQ2++fzd4AOT0S4kuF8bg9S/gX0MxD21/qbLaRSZubBnu9NhjdLTgKb5?=
 =?us-ascii?Q?yN7CHdE+E9u/G/JAtGqXKheu7yWDCn8n7BkfOq/03nYWUvd0w3Bs/UfLaeMs?=
 =?us-ascii?Q?ocYSnAVpXZrkm/X8UTj4moEmOWXbLfMsncRPvnMwdZR/r8WWiWWh02p+mpli?=
 =?us-ascii?Q?sN++WLV1bNfmCZ0KtqLt14o1Pi7Xg15Lb1bf6ujQ/VW6LuEz4ZqTV53VPfeX?=
 =?us-ascii?Q?/g9+esJUO8TU77R2vYAmPjbLsy5fxKHin4g2A3cG0z37DlcmsRWij0Z+yQMf?=
 =?us-ascii?Q?Jkp73wQcbbdVsHS37ZotLgdB7iBDzvopAt1aBFoBVnExaU2XNfCj5hGU5DcS?=
 =?us-ascii?Q?ND/ZX7LEMTkbKeFXFM7ToAtxMpDVdcNIMyLVxCtakWho+Ef0oMBUyhy/w2iu?=
 =?us-ascii?Q?1Z6ZGCq0qkUu7LwTtuQ7QYv8/z3mAafwjnPuUjEgoxH9lAHzG1QQE5d1YjKk?=
 =?us-ascii?Q?LYU6gnZzTXqGyqNZhvrFiONvCdflxdcGi9XEcnCqfJ9Qp7gdj3VQFi8uZRpJ?=
 =?us-ascii?Q?+p3aK/9307BuS/Q7ArSi2pybwscW59lWMiN1IKn7mdoRyiYX0TGA2OuFhMoJ?=
 =?us-ascii?Q?eMqA2nvKV4fdPTevcICeYieYmzQXdFs+cF1nVaeNCWGUtvWlBtCfD8GrQhqk?=
 =?us-ascii?Q?lAv9++cE1cy9P3g4nyPcWP95W/v+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:49.3052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62f9386-998e-45dd-f651-08dc62e13015
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
During DP tunnel creation, CM preallocates BW and reduces
estimated BW of other DPIA. CM release preallocation only
when allocation is complete. Display mode validation logic
validates timings based on bw available per host router.
In multi display setup, this causes bw allocation failure
when allocation greater than estimated bw.

[How]
Do zero alloc to make the CM to release preallocation and
update estimated BW correctly for all DPIAs per host router.

Reviewed-by: PeiChen Huang <peichen.huang@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_dpia_bw.c    | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 68a8fd7f84d0..0f1c411523a2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -270,7 +270,7 @@ static void set_usb4_req_bw_req(struct dc_link *link, int req_bw)
 
 	/* Error check whether requested and allocated are equal */
 	req_bw = requested_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-	if (req_bw == link->dpia_bw_alloc_config.allocated_bw) {
+	if (req_bw && (req_bw == link->dpia_bw_alloc_config.allocated_bw)) {
 		DC_LOG_ERROR("%s: Request bw equals to allocated bw for link(%d)\n",
 			__func__, link->link_index);
 	}
@@ -341,6 +341,14 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 			ret = true;
 			init_usb4_bw_struct(link);
 			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
+
+			/*
+			 * During DP tunnel creation, CM preallocates BW and reduces estimated BW of other
+			 * DPIA. CM release preallocation only when allocation is complete. Do zero alloc
+			 * to make the CM to release preallocation and update estimated BW correctly for
+			 * all DPIAs per host router
+			 */
+			link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, 0);
 		}
 	}
 
-- 
2.44.0

