Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D617CD3438
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA2D10E79C;
	Wed, 12 Nov 2025 18:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WlpQozE1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5015010E796
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSNs8xwh4TYpXJm1drKgb967CC/8EF8enW0MHnM09k7+SSzhoM9J6O/PR7mj3evqHpLrwax8BQNVj1AgzUiZWlsQbO4PfAGUE9VXt9p1OrBX1hevQ+38mls8ut70EhwIKBUs5+4Al52B7hZN0OHeoxbEp3PgfCs1gdAZiPe61DqcW/vzPUJeAM/NJKradQerMEyIQlfLNXzkXuw7zB/0A+nQTkHxVoiD+UaQc8HfhJYBTzyNxvKnpoTYOKpsvFC4jT4wjYL8cyoND8XogSCvUQOhs2CqgIe656nJRJviNGGnShw07xDGA4fM4zhrKbM1dvGmoC4jmZGHBtKXCgMWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD6mPkXEFnX5MLwHV32RyxSJDeQM4YhH6a/qjzeoOSk=;
 b=s45CUeSBMSVrsYXoqUxKH4Lc0GzVyk9e6o/eM8KExtAsbXBbV0CKNi2L5/3fNf/BON6orA2Z6mteIEMQOpaWk+6RyqR7ix1dpTz4j2OgIiUH68VjOxLt3guvGm6dScMjfQitU17rsybG1Np5y4ejDFBUEZfwTJQIwasHZApR96b7Mxn4DzWCFYuCDC/fM9WJp7gVqlEnQgLTGHhew4eLHgNObyOVOG5CCmCSlqRiIGjr4XIPW63AD0uMh5UaN5ODFfWsnM1mNAbU+sZLXRKO3lYYnsHy8iWcEuwWtRafebvAnFvHQRkfNHF3JoyTkaAjN2nzboz2GGxfGtAbxGrDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD6mPkXEFnX5MLwHV32RyxSJDeQM4YhH6a/qjzeoOSk=;
 b=WlpQozE19/qsrONaALS/A7tNbXxNK8c0RSx2R+C5JPbyRRkVE3B2SvVfVMKH4gCpQNPhW9ZkSNGQ904SxieMnFZsRb/66gS8MXwP8OLudZg8ZjeYFqhFOYznerfp+a5rNfL52iuSxOwqk3Kg2CtiPJSRO5Dn3gtsgA91U+MzB9s=
Received: from MN0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::34)
 by DS5PPFDB3A23D1A.namprd12.prod.outlook.com (2603:10b6:f:fc00::663)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 18:22:32 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::51) by MN0P220CA0009.outlook.office365.com
 (2603:10b6:208:52e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:22:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:31 -0800
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:30 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Leon Huang <Leon.Huang1@amd.com>
Subject: [PATCH 03/16] drm/amd/display: Get panel replay capability from DPCD
Date: Wed, 12 Nov 2025 13:20:21 -0500
Message-ID: <20251112182212.559007-4-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS5PPFDB3A23D1A:EE_
X-MS-Office365-Filtering-Correlation-Id: 0834eb22-8b74-49ce-0ed9-08de22187232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CqrKb0FGUAP6IMWCD82r9pW9YYk5onzppHQADr0uqJ5ZcEboJFyAiAw8SeVT?=
 =?us-ascii?Q?orLAi1a0srXhcaxY6vQAEyRjbTqhCEjStnJs2j9xeTyUtUhaBpdDHSkozQD4?=
 =?us-ascii?Q?yuOb+e1s/QmGONuJDjaCgzABeE85hlBLPxRx0L4tldbhJumiIydC8C33i/tV?=
 =?us-ascii?Q?SgQDYHDnoSlwyqKSm1bJx9Njh5FRfUpgGXWI1s3XMJryO9L+xJ/nGBxTz5ll?=
 =?us-ascii?Q?GCVUtaEwWlW1zh8XfInGrvUB0LyJdP+VR+zp32trNCl+pSmlQTToDEdqvqk6?=
 =?us-ascii?Q?G3jDsdpXrHGG7EXIPDc9fekSO9cxmobZlLCaYvp4XtGCL0+fBghTiC64+cNK?=
 =?us-ascii?Q?XMOUU7Iw87pyOCZAyGg9n/EbfnQlhxQGW7dGcsODfKsXWzNtZxPom13SnOuM?=
 =?us-ascii?Q?d2uo+bAX0nk2goi+mLx+VY+bK5PielhsLFYBKYUebDSsf5bA6KneMHfISAf0?=
 =?us-ascii?Q?A6/TWDExKtSFagvXAMNOVKEBPiC5cPUuTNxEUSAUwNeaq5WpwJHa4GlvYmyA?=
 =?us-ascii?Q?x9kczCU7Y03PFN3LOO40RC2UL5Gh9x7ezFA3W5dSai48Wo3VjJdpSxfosO71?=
 =?us-ascii?Q?b+mAUbURwxg6LXF63CzZOuRGQzHDwKpujDz4Rmw2niat7PabIe/00BXzCXjj?=
 =?us-ascii?Q?0cmc3zTbRchAMulD5BnY/cJdrk1GY3gcA6Q6NOojHQ7Tqq+9Y1V5jV2UpPtg?=
 =?us-ascii?Q?wBk9R0DsUJun/q+INKzgiO7tsS1hnTP2pbEGoUpLEHFuVzCkPTMpNZQw7HAk?=
 =?us-ascii?Q?8dFfseEra+jSbWJy6kikMGABbhaOG0wXTBInpfZnQjgwjJmeM2RJ3I51miA6?=
 =?us-ascii?Q?My3A+LotG7uhTsFbM70l4wu3gF0VILi02+hLQnjvs6TQZs44LT7iJBHrTbjx?=
 =?us-ascii?Q?gsp9zzGisNkbyE6zT+61iyL0kS9nmN/j8taIiqvRFQHHWaV3pB5irJGtsppH?=
 =?us-ascii?Q?pdkZasFspz3BX/lFPfr5sRbmhBPTO3V2hjaWRht/FlFjql8JwPlkqdMGsVb4?=
 =?us-ascii?Q?5F2qmffy5Jsl4xUMTCcxHBI7LE4f1NvBrPWz/kqlvQr3EjwcJhAj5NUv591l?=
 =?us-ascii?Q?VB/KrZbbb6c/nL5XmcjzpGGAfUHZqSL0DOUSNUKd8q2YGy6WfO4lU5wE8xkV?=
 =?us-ascii?Q?wLT92HLhLTYVH/H7WvN/kHWlzC0WstWHwn3Af7/iXmZr658suW08KNacnXXb?=
 =?us-ascii?Q?R52QB6nU00YdqiVlUoFL6kl4GTNwa9Fzx819sF20AdhQX0QZr3qz4dhrtHe1?=
 =?us-ascii?Q?KSpF3oZg/j+NOg6DLzdJuNpFRVN65p02SGWK2LP+bQ6SZrnh7Arpz5Pk1JCt?=
 =?us-ascii?Q?PLSV8pF1rbWsdhQLwjuiluAlpyg0riCaWqJb8IdHq1tSVgQkg3GAdsOwF12z?=
 =?us-ascii?Q?F7MYvg/3AWklADNMvIqHOON2vZ27mDvrNGFjynmrk0e+LeL4rWOV2pHKG89I?=
 =?us-ascii?Q?b8AzV8qBJjkSH18bxfyo0bC1dg+UcdnumbLaU55gA6jQ79qUb9kUxTRn96tb?=
 =?us-ascii?Q?cNXHU1aptMdwiCAlOo0SLAeUqdwgko5gB7nQmJO6SsuNJdCGa3XD8pQgG67R?=
 =?us-ascii?Q?e5pfWKTxvstqqtjU0ZI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:22:32.3196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0834eb22-8b74-49ce-0ed9-08de22187232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDB3A23D1A
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

From: Jack Chang <jack.chang@amd.com>

[Why&How]
Read Panel replay caps from DPCD when retrieving link capability

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h          | 11 +++++++++++
 .../display/dc/link/protocols/link_dp_capability.c    |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index db669ccb1d58..55413923ea86 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1157,6 +1157,16 @@ struct dprx_states {
 	bool cable_id_written;
 };
 
+union dpcd_panel_replay_capability_supported {
+	struct {
+		unsigned char PANEL_REPLAY_SUPPORT          :1;
+		unsigned char SELECTIVE_UPDATE_SUPPORT      :1;
+		unsigned char EARLY_TRANSPORT_SUPPORT       :1;
+		unsigned char RESERVED				        :5;
+	} bits;
+	unsigned char raw;
+};
+
 enum dpcd_downstream_port_max_bpc {
 	DOWN_STREAM_MAX_8BPC = 0,
 	DOWN_STREAM_MAX_10BPC,
@@ -1280,6 +1290,7 @@ struct dpcd_caps {
 	struct edp_psr_info psr_info;
 
 	struct replay_info pr_info;
+	union dpcd_panel_replay_capability_supported pr_caps_supported;
 	uint16_t edp_oled_emission_rate;
 	union dp_receive_port0_cap receive_port0_cap;
 	/* Indicates the number of SST links supported by MSO (Multi-Stream Output) */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 750147c52c8a..168c59bf1f16 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2091,6 +2091,11 @@ static bool retrieve_link_cap(struct dc_link *link)
 			link->dpcd_caps.max_uncompressed_pixel_rate_cap.raw,
 			sizeof(link->dpcd_caps.max_uncompressed_pixel_rate_cap.raw));
 
+	core_link_read_dpcd(link,
+			DP_PANEL_REPLAY_CAPABILITY_SUPPORT,
+			&link->dpcd_caps.pr_caps_supported.raw,
+			sizeof(link->dpcd_caps.pr_caps_supported.raw));
+
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
 	if (status != DC_OK)
-- 
2.43.0

