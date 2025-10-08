Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B399CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8B410E8B3;
	Wed,  8 Oct 2025 18:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2FLbjKvF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5BF10E8B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1zJ9CY8Nt0N8ZgscSH+OnrJxYH2fgabAx3CcvaAHfkJlDT22/Ipu2/aIlnwClrMDHJFBcQo+AMa8LakqaaluizxeIWS4AfSvHShecaEKg8TfLLr5PTMoXYxpYfMDmBqC5WcKM2Ff1lNQMpbIlpTbYqzFYenLXLjWbY+x6G68Iro3E/UuzkUkL+Ptp22vbTyY3wc7mm82AkS/GzT/8l/d/Pgi5x2HZj+xjszrNebIk3GzTNtWFaRh2cvHPOZNpgYtpoZoXUuIMnj5uZopPS3LdokGbj9p6thctrqRqRO2aEKORLKBwft7ImPQzmN7C2uN3RPdPc6LUlcnjQEp17bBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N+3S/GMO3OxhufPgEKyvC+LFLv5anMwzeShCcU3ocA=;
 b=LVHFcBnOBzRrf1mqon8D/JPHsMBHx9HHuqyLOMSaW5Gl7SyMsjAzQsZvLi1DLqBLJAsVQUr1dYnwNlOqVWPM1CrHAMEbBJwJ0h6oNtu3OgWmtiOlswPnc1M6PbEQ6z3EEEF7h4gNpHmi0Z6eij72UeTZfySJ9NTVx+vQqV0mXr1JqsyVFaj4fggGypV00z2J2Orxje97OQGiJkREFNt8cVMiVruDPrzfn44HTyLOA1/Ou1TzZFWLUgzjDWPG/ZCf7LgMMSOA1+EGwYdmNRPn4+vylGMWKLn6OtR8cr1geMp5qseiMWenh2RN9TCLVppYo6RUDZ0KWuhJokATsdaqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N+3S/GMO3OxhufPgEKyvC+LFLv5anMwzeShCcU3ocA=;
 b=2FLbjKvFGkJ0hT/j6BK6uylZsnqHXC77aqdgkuwtVDiyStianBh0+0GMXhjQFl9SMACaGb2aDYsbEzTyL8sphG2g+hbBLohxZaoi8228G6I9bmh9Dp/IzfCd+36U0BdAW9Fk/mTokcXbPDThz995MPqlnOK3IRaQsWdCIoxjDGE=
Received: from BY5PR17CA0001.namprd17.prod.outlook.com (2603:10b6:a03:1b8::14)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:48:58 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::ff) by BY5PR17CA0001.outlook.office365.com
 (2603:10b6:a03:1b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 18:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:48:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:42 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:42 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:41 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 04/22] drm/amd/display: Fix NULL pointer dereference
Date: Wed, 8 Oct 2025 14:46:58 -0400
Message-ID: <20251008184839.78916-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 29379f74-fee4-44fe-fd78-08de069b56dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P8kIkZyLXIZXimKaHz3gZVm4DHsR9DEKmflOu53//qGg0qQL3239D6YLDB8L?=
 =?us-ascii?Q?Ocg3rhYskZAzwNmyIpLZneCyMJc8aQDijADpFSY9aYfRTZM1m8YFSs7TkaYa?=
 =?us-ascii?Q?ouszNoZfeBylRQWK/uKKCrOMlsmAEuQhql+FMA9qBee4uWu+20ebpa+rZjKf?=
 =?us-ascii?Q?/VcNMjqkOZG9O9hqUQU8j9Ps5wAWLsgnJ239xdw4fdtu/J+u7L29bvo+Ii0B?=
 =?us-ascii?Q?Wvsjd2NOkyTvnmQ9HqEQ4esEut3tEbozNl6phtaFVtexnzFjnw94KnoehFDi?=
 =?us-ascii?Q?V1sWOVDdRzk9Auw3N9Cjxi3yS7dsXpqJk+HrS6asHAsdxB13Qg5ux0Yd6hOA?=
 =?us-ascii?Q?SUOev82PpdeVbe/+PkcV76u5i+Oi8J/IsX6gAb1Zxi83bZsI0SJ5O3qYURTj?=
 =?us-ascii?Q?6O7Hiuo862uuM1QY4+A2X4tPPqWMoLfh914eYY89aYktn9DJmv/0RaUa4yFh?=
 =?us-ascii?Q?BIpKUDtfDQUx8xC0tKoMeQ7PSrixbvQO/+9OJT6/oBkZZLRBEHLqNbWl3qdc?=
 =?us-ascii?Q?vZK6OPoFSQO4D+kxY55kj+2DNIB09fVp4E193BKu5SDy8hc5qXCRYcJzm4CQ?=
 =?us-ascii?Q?kjvaRY3ibxEvCWbd3rEpbEdZCilaEQwBVV5LY9EGDkPyJBFrbPz7TDBSKE+v?=
 =?us-ascii?Q?payWXtUWLBMk9G8iNJs1iNxhvewD5jK4rNrH5/NcfR04qh0zwAuPQkbz6Yu4?=
 =?us-ascii?Q?Y1JDfzeekvnOdlOXIeGQDwF7eItwMKWKWxezRZLgxl618mrTEqNjMTXbBuUc?=
 =?us-ascii?Q?3vgpeHoh/WYNQBjBIm8wh/chEN5S8wpyVbNwRgpFz4IKz4osNwJ8uQ5V5TTs?=
 =?us-ascii?Q?ktKDlNcuyt1bvQrBYxpwL+madX4sEBFelc3FbF4g9YglFTGyL6GyRqSNosD7?=
 =?us-ascii?Q?yHRZzUAIEpnz78TVTPGzCbnEXefWre22K0gDtjvcXOM6CXBpLxXbb0SUwjbN?=
 =?us-ascii?Q?4o2ZNP4/FtmWoG0xsl658EAnCXMssUMXwBnoOoGxSxyuagZUm7UnJte8k683?=
 =?us-ascii?Q?X0mTDk0OR/8lpTcnKy/rXfbS6AEsoH4Gy8pHWH/ZnJjWmAgfnuNX5MvQZ3Jr?=
 =?us-ascii?Q?pO6OYHGwv1VeV3iLrgxxMJtlvKQbzCMEvCdES81hQwDLA9rZ3fW4d/9w037U?=
 =?us-ascii?Q?gxgpcUQRBF1uqKBePWr6Gg7jDJYdWpS8mstdNyEmBeC9SKBlsvFF1bhmnsE6?=
 =?us-ascii?Q?HU1lyZCvhpqXW1lt/zXCWmq0j/CvSiOq33TLcvM/g+gE+g5jVYjp8T9qoXdX?=
 =?us-ascii?Q?xDH+qDjf17hotcrVrtt6bhtE++zrqyiPkNS6I5kB+F0/rCtnF8Bcehvu/L/k?=
 =?us-ascii?Q?GvPXilg/z6dtKJIo0/rVYrEwjS8L0BkCy9dSqu9YW+HzkZHprFaZYAN7x4it?=
 =?us-ascii?Q?W+mfZvZKf72Q4Yneo2IQVTtL1aVw7NPIZ/iwFderBKNwaXt+nI/tF3sBWZ39?=
 =?us-ascii?Q?47bAMh7ZgQGZgfn1lVLM4lhqfK0bmnGFzhI0ZC+MpH49WAEAfZlLv3wnkn0j?=
 =?us-ascii?Q?nBrafVluXM5yDl4RH/OPfkngR9wCdOyzl9TM3RpImaoown8Sui8mxT5S4OdU?=
 =?us-ascii?Q?xGDRND+dOn4P7VoeV+g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:48:57.8882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29379f74-fee4-44fe-fd78-08de069b56dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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
On a mst branch with multi display setup, dc context is obselete
after updating the first stream. Referencing the same dc context
for the next stream update to fetch dc pointer leads to NULL
pointer dereference.

[How]
Get the dc pointer from the link rather than context.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 1593412354cf..1045c268672e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -78,6 +78,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	struct audio_output audio_output[MAX_PIPES];
 	struct dc_stream_state *streams_on_link[MAX_PIPES];
 	int num_streams_on_link = 0;
+	struct dc *dc = (struct dc *)link->dc;
 
 	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
 	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
@@ -150,7 +151,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 		if (streams_on_link[i] && streams_on_link[i]->link && streams_on_link[i]->link == link) {
 			stream_update.stream = streams_on_link[i];
 			stream_update.dpms_off = &dpms_off;
-			dc_update_planes_and_stream(state->clk_mgr->ctx->dc, NULL, 0, streams_on_link[i], &stream_update);
+			dc_update_planes_and_stream(dc, NULL, 0, streams_on_link[i], &stream_update);
 		}
 	}
 }
-- 
2.51.0

