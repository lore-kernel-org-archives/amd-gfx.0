Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6D5C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4171113966;
	Wed, 24 Apr 2024 08:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PS1a01Pa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9129D113966
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xry9G8II6GA/ZDu5hA6KZU/ZsRoBQRRAzhV8dQYiWmuPeseljiaRdj8bm/dp2UJOmnJtw+LaHfwFnvjKdBvEi47bdhp+qORzbRUhOxAXIOs2gzrYz/hDpDMsZTGUkMYKkljvr1NWTVQmGwVIc4bmmvOFL0ehq8W+pIPFkkSfE9DRYFAh0vbHDBcDCNcWV9IMYXyVi3JcbEKc4Yn27D+24uNRaiMbzGOQkhhAKcfNErpE7JcknAgxA+R7Pir0wxPrx7/qQMKnx3r31r5fMY/2hvP507XvRIUm9uUsSaXNMgq79FfqB1o5RjEL3JkDJHtKaeVZyzU5ofgO0vZp173nBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewkHzMyW/RhItr9xTwCd58VRKg8dNhPoqRoVH0Na/gA=;
 b=evZ0MpiBho/jFQ5yT8JuBG4QZV2d4aDskMRm2uT0CLnKJbmxbgwpYSOeZUgRH2q210QYhZnsxLzoT0R8pQYYB3fmWhV2I32NTcAW0hA3WlQf+K8yftOQI9hGKrPEI8kYORZqNAylOtK8U5S6KnS6al2jShVnVNsEdRQKy/QcvE+8QRSFkwHSeMdRkR5MhMGAUxmr1NyyZ2RwXalM81vPBTc6gn/h6pjFxgglsxVhs7kLr6FKJm2pB/QY1abYeKI220w5hvSJrOgM+gS4G3I3wla0Rl25ORnxV2cBmBvMXT996Fdth7Wh70edOUOwimrP1DznlR5QwOboNo5lVdRq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewkHzMyW/RhItr9xTwCd58VRKg8dNhPoqRoVH0Na/gA=;
 b=PS1a01PabTidxBo4DXRitih40WBcxn5O64u+9v/Usvj+ThG1sEiUhdDBZB9LNTvigB2mJUdlyPIpF/miKVUC/fjViC3T02qpmzfhInJBauToNtGvpj8BM+h1c97sV0iYv1Guk4r+SeAHJ6AA3mFvXwfnBPQoRp9QQflFE6qbWX0=
Received: from BN0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:408:e5::17)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:52:17 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::11) by BN0PR02CA0042.outlook.office365.com
 (2603:10b6:408:e5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:16 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 20/46] drm/amd/display: Handle the case which quad_part is
 equal 0
Date: Wed, 24 Apr 2024 16:49:05 +0800
Message-ID: <20240424084931.2656128-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ea9bf3-8795-4338-46b5-08dc643bd830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ej4OclEby4oce05kwgrjIiURq/jq/WHlUZE01w907EkufFC7xK5vE2Cy8cWP?=
 =?us-ascii?Q?gGr74FjwXzKBNtaIEHfguFl1A5iz6Amyjia0IeFcg0co3kYwcRtD7oSt3zfv?=
 =?us-ascii?Q?k3MuZBBkzxFyrjP9K7e+OOJT8zlxF8LDKVhZa1bp1FpqXsP/tHvOfue3VJau?=
 =?us-ascii?Q?74mduYZu11btF83KMy/sIJ63Blvchdw1d/0aooOy0CgFJs6Fy4pcYcaY+Vl8?=
 =?us-ascii?Q?+ZC0HSGiI9Polfz3x3Bdgr5kkjl+x115VWdpXtT9E4K6VGcTdAlccEpe2mJ8?=
 =?us-ascii?Q?0ngrtUYiKT4f0OjIrQOVefMg3809s3bD1Q7yVsoskveH81fzevg0q2ZeEwsJ?=
 =?us-ascii?Q?Bl+hFivAyQeUH1xdNaL6F+VrEfAM0yc57dRobwRytYeuXioaZFoKY5Rw+ptU?=
 =?us-ascii?Q?lE7Rlj2F2b6bn48cqab4uvQoGHW49HvdGVmXBNY3xKzP1EL73WoyHHtI2piC?=
 =?us-ascii?Q?sG4E3Di2mTeJPKfDo1LFcAwYd6KbsVfKldYOSWxg1kaSCf5lsQ9Oo1u48sfQ?=
 =?us-ascii?Q?NYLSvMjKopJFZhMe+agjS7+9C1adMaFw8oCim4OTUMVeSHZNWepoMo+MlCdi?=
 =?us-ascii?Q?RtER2fK+G/9K/wVBfyWUOlaIVOjAVuTAvD03z+/RjYudTnOaDKb+fAX2A/KZ?=
 =?us-ascii?Q?npfv8SjjJabnZDeYLm/Dqs5R20QJG/oquaSexwb3UKAyFIAyWIQZxbzWQNH3?=
 =?us-ascii?Q?jzoVPZJ8x+PTO4YHyLP7Rt0w7UrVMkTJMHa/5M4b01pp1lyMVjf9CEOoFAO/?=
 =?us-ascii?Q?CAQ20Xcl77o6/XXVGeGePokf95cJGt6MqQ21gyTFY0B38qqK8I0QNB55L5Vf?=
 =?us-ascii?Q?RbAffgI9WdOHp640zamio7jY50Rh7p9G7MCMemI2megQgT/qQzguAr6O/pzG?=
 =?us-ascii?Q?7x+8bdv/ohlxRqF8fWBZucwRt/NbZsXoryXgPJVEjgfgly0IB682k91i1pC4?=
 =?us-ascii?Q?ZernFZsHj7NKcEwudV/VtsG6i8LwJVDVKICWtMKIaZ2g2TalHBeMAZKZqQym?=
 =?us-ascii?Q?hCREHK7BdgPfEcmZ1+mtHvdD56V+MwHjsaNwmTwzQTtFA4K/uIiJPf0IeveH?=
 =?us-ascii?Q?WlP9SNOko0xScT6QDrKIpu44rKngldw5ErFnzroVusWtOvEVKO0jmWM+YbRc?=
 =?us-ascii?Q?agR3oXcI4GSZIeeIaASQrqYCbE7rEnqomIXkk2WPYc67IrjhNZ3NIJZCVRLN?=
 =?us-ascii?Q?8o2D6qeU+Q+p4N3ZfQCyEDyNFqMo7MkzCtTkiVzUiMCd1c4WbjBz/WZOCFB9?=
 =?us-ascii?Q?J9On2F2dbc+F5sVaAiI9ZiOAjqhDxXtCsZl9HkIr+8g0GIqrrb3q7e2ow3v2?=
 =?us-ascii?Q?vsipaD7OmKcb1tczifyhNGjP0cYdDbGqI1XsM2tDNjvSTQDwou6XDChmn+gE?=
 =?us-ascii?Q?7mrSzE6HjLlzKXHGX14q8XBxwsp5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:17.2189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ea9bf3-8795-4338-46b5-08dc643bd830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
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

Add code to handle case when quad_part is 0 in gpu_addr_to_uma().

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index d5769f38874f..7f7b6bf76a8d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -95,8 +95,11 @@ static bool gpu_addr_to_uma(struct dce_hwseq *hwseq,
 	} else if (hwseq->fb_offset.quad_part <= addr->quad_part &&
 			addr->quad_part <= hwseq->uma_top.quad_part) {
 		is_in_uma = true;
+	} else if (addr->quad_part == 0) {
+		is_in_uma = false;
 	} else {
 		is_in_uma = false;
+		BREAK_TO_DEBUGGER();
 	}
 	return is_in_uma;
 }
-- 
2.37.3

