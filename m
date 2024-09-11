Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D155EEE57C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79EB210EA4A;
	Wed, 11 Sep 2024 16:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A2eFKjpl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E997C10EA4A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmJYGRCzYB7AWyLnDM2SsyzN5/vTrF9GRZWtmoBjCBvDehxz61JS2LC1zCXIK8vspLudU5JLYAzPqqTMyP49TZ6weoqi0bcvI7vsTu8fec9vt5ms5G4fieajpGU5zgyzX8hsP2xoWgwO82+O0lXQJ89+9EsF9P1sz+hvJGyjBTP7FY6RWfKYvVY46t+I3Fa6t8PsSNuac9PtfZFwTIk3f7WndOfaL/m2bgEe1MOA9vE0DRS/NieQJwArG0o8ONVO5aVr+nyoWdutETNfVFnnYbKVO3Yw92lfIuE47Njv3YOREKjf2J7/wzaaEODyqPihG1Nea5RRxojOUdD6R2xSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jQU41FebDxRm7QampyzErqy0FlFmmmG2W2foL9o5dQ=;
 b=JsVG9vMu9U3Na1HDKtqqZNTm+myrdH1KNSTMHcxU3rFDFrMOPDHG0xiFcsHVKH6HPTsRPGD9cbnOGoxH7Kqg2lyGOl8O/4vvUQL5ln1+9iHG2Tb8q2lVy3VDImoONJe4GbBBE1VbVxZjH/ZmA46fSksHqE+OfpC30J40mh+EM/XrAe89mfPyZ0NnAnBKzdrTWJX8Ny3tAMJgyzJGdrLPsbvwZWRQ3xCtv8iVLZWW+qVIXc1LyDrujbgbkszqZLS5b7QaMTq5SA/lun6SmP6uTtydseDD9Y1UHgN1Sczd/LKp+4jgtEbYQc0f2KZv4Tug7F0S9Ausi7AgSEOOPwDE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jQU41FebDxRm7QampyzErqy0FlFmmmG2W2foL9o5dQ=;
 b=A2eFKjplcv70i64murFpQFkVzI+ecHyVJTZPwqqN90YWUHAIHvbKbowulPqVf8MjToAYocJG0mTtJapXeMydjSkSkJd/2wYvgG/8dwVtChewX5103xPhpZtglZWR4jTmPRzV/ky8dHu6lfo2E/D4gscLMfmxuiSfL4ZnRVh2sl8=
Received: from BL1PR13CA0113.namprd13.prod.outlook.com (2603:10b6:208:2b9::28)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 16:21:51 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::fd) by BL1PR13CA0113.outlook.office365.com
 (2603:10b6:208:2b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Wed, 11 Sep 2024 16:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:21:51 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:21:47 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Robin Chen <robin.chen@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 <stable@vger.kernel.org>, Anthony Koo <anthony.koo@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 01/23] drm/amd/display: Round calculated vtotal
Date: Wed, 11 Sep 2024 10:20:43 -0600
Message-ID: <20240911162105.3567133-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f371a52-097f-47b3-a2b4-08dcd27dd7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4d1cODlNKcGXsd97izJF1Pwtc1zX8TzPy9055AUn1Nn/QdgkOb5TOVtNmc0+?=
 =?us-ascii?Q?DHLNzBCS7OAdz4fyGztzmQoDjq6H8IM2Cr6xrIl7KsJ9WztVmSw7Lz7B5YjZ?=
 =?us-ascii?Q?YC/LS9WNhlkCIZ8Alm2BMOZFybtMntzH9InRz77wl/GOEUlQ2oxYkoU92YRL?=
 =?us-ascii?Q?OdTldX8t0vm8MZyVRSSmJrCfH6gqhNL7nCXEX4SG958/ZofbkKwMdvMM3ebM?=
 =?us-ascii?Q?2DiJ+0nuIFrZO36dopx7uLDjYvGdDYHkXUmbpBjwZnkDdcZ+Th2UqF/lbcLe?=
 =?us-ascii?Q?I7K48HNMFKS7MvtBUAl6fLWz74vwgIbTbuSN/uDJ8z+pQyxNQLzQKiouaCjI?=
 =?us-ascii?Q?veq2cam5K/tQ4fEKJy4CqwOsrq+BVTh7MIV3RCvkBxMWWUgctk4gp1xi3FWn?=
 =?us-ascii?Q?vZeso2hdHuips1rVCjwgA5XQGTGQy9n+EwxjFE6eG5v1QH2rYgKBCHIjbDL0?=
 =?us-ascii?Q?sMw1oLNspU92ZqeFjou7zct722NihpV19TQEMrtQ2shDa5HK8TA6vesNd2ZO?=
 =?us-ascii?Q?WvpuWB6W91lkZl0uauJGG12jbF8MneV2okwqyM236jZtUxNf5nQRwrvy4hHr?=
 =?us-ascii?Q?ohXGVRTSrIrCF0b+bZ1m35rYd/uKCHMzmagnE5BEBqVIsGc4jBKq2S8UjE6k?=
 =?us-ascii?Q?hQxHoxGKuJiqDpPHMhAaNrsd1Tcoz7JEbQcpENsiDUTSEH4L7UkrJacvmcpc?=
 =?us-ascii?Q?SQya54djzVVcUOHqapU+HjGWsZf+kay1PXoR5QAO0BXzYI3slJZCd8ticFjs?=
 =?us-ascii?Q?+9txShZjxvS+BoN1x4GqbRfj3AFoLI/F4uWlrmLKFYwt6NyNNHjY19AKZA7j?=
 =?us-ascii?Q?qsDyTkYFDjvlWJPxC3YrjD8sd/DCscRE3umLpC/9NjnsRlI9SYeimdnhH3Hc?=
 =?us-ascii?Q?xLwfmThuE6ePVIS++oUiMTCUooi2rHGshTzOgelu9oIX9URVI0xvXz0f+Hjo?=
 =?us-ascii?Q?q7VFs6RyL+Q34QgzvnGnhPnAQ1HryXluPpCbIm5KfTPsOLNLcoc45ar5de97?=
 =?us-ascii?Q?VWA5XP8a6+TtO2TKokpRp0kUAxKN123BhFbRf9v41mcl/UGwn0PbWXcQSRHI?=
 =?us-ascii?Q?JVZllvwkRmJ+Oy5vFvf+djcmUlDiN5wWVf7yOgMVzIVgX4Vu62Nxg3KaV6AB?=
 =?us-ascii?Q?cxSeZg69JppBuiaFv9SvkBjGKapH3Jmq7K19vmWXGwo5NSxIBPLizRxN8CUE?=
 =?us-ascii?Q?TSs5OLLfNpDEop81bZNxb1LhEEn6xraNz7gNPew8qZeP9aiyuq2nlNzwv4IS?=
 =?us-ascii?Q?C8UrlySbndZ5egzEUMVRbAx33lH6qhrBER31Ky5efKKtPSTJDzAx+F2G3jOX?=
 =?us-ascii?Q?vhlAsppaU2JyYZVoFx9XqxnT8MnoaIkR72u7NjTow7AanNT6vGaacQVfext9?=
 =?us-ascii?Q?HAyqxCbVLL2l2tWDjsa83lLqEl2x/B9RC+IKcjSW/2Yuy9zv9rbA2DlhbkaG?=
 =?us-ascii?Q?vQIbcxW76yEwYpIkbqx65tyaLziecmS3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:21:51.4865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f371a52-097f-47b3-a2b4-08dcd27dd7f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
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

From: Robin Chen <robin.chen@amd.com>

[WHY]
The calculated vtotal may has 1 line deviation. To get precisely
vtotal number, round the vtotal result.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index a40e6590215a..bbd259cea4f4 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -134,7 +134,7 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
 
 	v_total = div64_u64(div64_u64(((unsigned long long)(
 			frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
-			stream->timing.h_total), 1000000);
+			stream->timing.h_total) + 500000, 1000000);
 
 	/* v_total cannot be less than nominal */
 	if (v_total < stream->timing.v_total) {
-- 
2.34.1

