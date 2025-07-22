Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B87FC83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9C010E731;
	Tue, 22 Jul 2025 22:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UZAdNvyi";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FBF10E726
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaHFW+13Ek/d6H4DCN8c3VP7QWMoxw5kxsqo3PAFNjKjq76eMDc0kSYM6uxa/MA/QQJUlW24fBeG4jK0hOD0rgfCULS6WQIW9KbWqzzssBNWo9CZROVyLqXC8v9cx8SIZ5jWstS9ZlF1TIJ4KOJHSlZ+N+RdPD5nzgI+sspI1mqGb0+FYUaLdgPFATHPbWRpiBIItwMiFWFln1lwhdWL4FQk6OcoXjCae5vcISh+tj1OKnstWxfcLuHFOY2l9BlI1zjjfz+d0wmKMu8qaqTH9vNu6lCE+mb257QmomxV/EuUWC4Jua+rDf++QAa/6UWZ4WqWBNEG7bPYXG+HkgULew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIx2woDIgn++Oqb4J9d4W4cjSdKLexnh+ckWOtdcLPI=;
 b=pWW+MOcS1xdGrhVV7XuBB9FfVxse7jGsClN8Kce1cxxMlxH6b1BVZxS0WZOXz79lI5B0RcZi5kKXZ2cCQ36yakJvlmy7b5C5FHelj4og8mVxltP22As+1OvH+nYzCUjzzX8haFIUNjf93TwGeICNNzA1OsjYOGEgzc1mn70LmN05gH3Mc2NiWu6V1L0yndnJw5C5HlMbyVdu7XRTQuj5xLOLFwTf/dTA23t7WPBW4YYLcd2Z4cAcJrjlhniWpNYi3PzBlBS7OiNTHczqE3df+vaeOZRiUzsggwarz296Mq7D6+BFlpkNYSFFwm2jJEVT115hKdv5J7hHHU0ThmA4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIx2woDIgn++Oqb4J9d4W4cjSdKLexnh+ckWOtdcLPI=;
 b=UZAdNvyi3OcizZItLH2IrvwgSM1hdjqUfj9QVNw5L/v4GRN1alWHJzDiHkcNT7xrXS0hsiXxlFHY6hnOa63hyBozFXYUpAEVaMb+lkmhN4CfEW7l37PtJixWi+U7kOl1/aVRSa1CqXPa8KptP/f6VPirv5/XPKWikLf1HgAVWGY=
Received: from SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19) by
 MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 22:45:55 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::d3) by SN6PR01CA0006.outlook.office365.com
 (2603:10b6:805:b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:45:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:45:54 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:45:54 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Cruise Hung
 <Cruise.Hung@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, PeiChen Huang <peichen.huang@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 17/25] drm/amd/display: Add debug option to control BW
 Allocation mode
Date: Tue, 22 Jul 2025 18:44:26 -0400
Message-ID: <20250722224514.2655899-17-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
References: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9d849c-cda9-47d7-d0b4-08ddc97184e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bh49xlmMsuMMae7mFnVO7U3V5UOzyN8zUZCkhmtaT0wYGZqihXprjyjEMsHy?=
 =?us-ascii?Q?62jvkI66vqIl47r49dqoPFkGRN9e+hoUpKgxGHfi5yw2zhigNLR3lhj9fipE?=
 =?us-ascii?Q?mXE4o7p8RVkId7QKP5+5l+zR96Xu/P7/NZusD8k/R/jnnpyKM+cdwpGohcsL?=
 =?us-ascii?Q?LVncz0QyjsufjRVgA9ELkubXlFrj6R9qlPnzzZjJV/Y8gWNIurMvks39ySvE?=
 =?us-ascii?Q?o0LBrtG7FzhIm8yulxr/qVG5c2K+JrgHFNZShkvRG/NNFaAAA1RwugnXwGm5?=
 =?us-ascii?Q?xDNfluzC5Poug9MQ4FI/SPOlkiQsIAdlE1daI5lwhf29FQtosK0XdWK6s4q7?=
 =?us-ascii?Q?zpZwph4WzU15ocvKIRP+6hNE753rwzvtNe9PufOM4B/7ZsTbYHGkN3i+no8m?=
 =?us-ascii?Q?HhKT12YMvvOwXG3EaG2HwBctZprN3iV5G4FQO2yOnwBJp7w6ztUyKYNk/5m9?=
 =?us-ascii?Q?/qbOPrViJ0ne/imSUpNR1alrG6JFxKz6/goODT2o1m1NdPnVhD+8bmhj/DzN?=
 =?us-ascii?Q?5HnLVw+24P8XKBn9zxFAgw+C25Rp0dfbkwcjNVJFrMQHmSxTqqNWpjzOUpF2?=
 =?us-ascii?Q?GoD0w4nRFE5H3I83J1R3iItoaMewb+SDjK7i/zTv3+ebMtRCLm4u7Hooe3yH?=
 =?us-ascii?Q?2rlj/CU4rjtHLNUmOvKrdURyK3XaUV10ICKYpTNNBAxsF2oGo9GIajfvZlYg?=
 =?us-ascii?Q?8yjQw0LqzWuiFQxdNOAq2+IzBw0uPHQ3zoIhr0MqQbDT4D4xtiZD/0AaN7SF?=
 =?us-ascii?Q?jrw54EdFaWB+N1tVBJ+7ErqED9JOlRI72CYe0obiHnBAR8r/hkkwkHPqElDG?=
 =?us-ascii?Q?m+wOscmYECAe+u7u1TmDabA7MNClrsyji4i+P1vaZ+Gfx2cOslB0tmeGl8cf?=
 =?us-ascii?Q?IXUCa2FDwlKskm05Qx+WvYAHBZddSD4cjJ00w7+diIj21WJESW4gCH+H3ylC?=
 =?us-ascii?Q?Sf4StgoB9o34T1BQKG5LJRVVvU4M0HCFz4UgcFu2SoKc5O4nWeQhQtYdYKpx?=
 =?us-ascii?Q?1TTjMDpEr2bflbCSlstdKLyF1aYTOespkqfVpHhcNECtSojwO38y+AXQBCD/?=
 =?us-ascii?Q?F/gAzQy8t9+1CYM5rlolIAq5zVQqfnF2yK5Uu6Wly58XmaXpkA6pYfuBRIuJ?=
 =?us-ascii?Q?t28yAKYJlEN6CWho1qU9rFr/dkr/rc+hFhtuRfVnSj4GgAwy165KfIpQNHcI?=
 =?us-ascii?Q?uk+Ah4q037q5Gr3k7n9OoLygGWv5Ktfk+eNmtqwDryNs3ChHC1ZHa8FGEVtC?=
 =?us-ascii?Q?AUypULfJLEd+j6H1DOXey0xH0qqlTtoCVZ9zpgxC+ZrYB4tLTDc1gUgkZduE?=
 =?us-ascii?Q?91Z4KS6QNDkmuWg1rj9bUN96YttGNGTqBZmPSHZyQQo+G1SdJlC0//Pm51DN?=
 =?us-ascii?Q?7Brt/M6XW6RsKMsuw1NUX/8SYL5tSQnVAnTMzlWonMDGFv/OPyipv4E4rxqF?=
 =?us-ascii?Q?wBBOdLFQ9By2t7JA6VpMl0HvMH58tN7OiRXlmPzfYriRcDAk8Q3Zpq872RRV?=
 =?us-ascii?Q?zs4zLSxwFBKzV8A6F+HVq7jo7vZx65Rl/95H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:45:55.4076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9d849c-cda9-47d7-d0b4-08ddc97184e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
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

From: Cruise Hung <Cruise.Hung@amd.com>

[Why & How]
Add debug option to control BW Allocation mode.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Reviewed-by: PeiChen (Pei-Chen) Huang <peichen.huang@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                          | 3 ++-
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c  | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fee54cc0f7d4..57f4a9445b7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -839,7 +839,8 @@ union dpia_debug_options {
 		uint32_t enable_force_tbt3_work_around:1; /* bit 4 */
 		uint32_t disable_usb4_pm_support:1; /* bit 5 */
 		uint32_t enable_usb4_bw_zero_alloc_patch:1; /* bit 6 */
-		uint32_t reserved:25;
+		uint32_t enable_bw_allocation_mode:1; /* bit 7 */
+		uint32_t reserved:24;
 	} bits;
 	uint32_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 906d85ca8956..8a3c18ae97a7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -225,6 +225,11 @@ bool link_dpia_enable_usb4_dp_bw_alloc_mode(struct dc_link *link)
 	bool ret = false;
 	uint8_t val;
 
+	if (link->dc->debug.dpia_debug.bits.enable_bw_allocation_mode == false) {
+		DC_LOG_DEBUG("%s:  link[%d] DPTX BW allocation mode disabled", __func__, link->link_index);
+		return false;
+	}
+
 	val = DPTX_BW_ALLOC_MODE_ENABLE | DPTX_BW_ALLOC_UNMASK_IRQ;
 
 	if (core_link_write_dpcd(link, DPTX_BW_ALLOCATION_MODE_CONTROL, &val, sizeof(uint8_t)) == DC_OK) {
-- 
2.43.0

