Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97064CCD184
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AA7E10E6DA;
	Wed, 15 Oct 2025 02:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OlNo3vmZ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE1810E6DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZXGmKHhNFrUAPb/rJOZjBIAR2KU7voVVOhcmLOnrh1eRg7OhBMaBMXLTE9LSfFPffj6Te3nQpmFsK9obPqXkH8e/lrYqwUsJJ00DXgmDqAeWPoh3G7RmzRCNsj1G0bLbVcOalZ0fFnAe7xfXR6VknP0NwZCxSeRNJT6TP5iMJkpnARy4gyccWt+Micq24KRsTPCGlgg1l5ll7VnhaKYsdi99z4yZGei1X2T2qIw+knafe8aQPbI804hKCLPTXjMcttL/F2R+rYYB8SNL2urZ+/BkC10UVlsclAMvVDaR4UCYYg1D0RC7zARiBVxPWTuJBTQNBHj6wAEpW/Rc/UzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UNEYCnqhLESar5xL42P/DNXP7G4mupZaGkr4KgcW4s=;
 b=WEp+gsK0wq4hHZRa3GaZv6yHCbUr8guYBN1yIxXgeLiE4dcavqnDv+iRQb2d8A9tNojyIAzXWa6HmeBbndmaf3BAJe6mxqG8sL5RrzJS5fmLArpn0Km1oVPQnawH9ZRJK/jcAsV06PT4q6ou/kg9ywTx1kb1GJyZQMpQyY507Vt1cqW9tJVVh449ogjwTx8nzN9rYcI782Q5lndkh3vPl9e7hn8J9VVyB8J/wKtDVTQCVrwEJJUJjoc3IMl6W16nqwaU4ee7tseAONx8QJyUhq3Gfj9pNzJ6XgkXWkqMPH5mLt2CmP+e7mqRVFCxk9VVq1RPHqsB1WgO4L7dvO/JWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UNEYCnqhLESar5xL42P/DNXP7G4mupZaGkr4KgcW4s=;
 b=OlNo3vmZkPpXLFdXQTGEYatwnPOgBkbdrPJyjAzbOOmFKacj6lwVsCJ7eWTyHDmqvcJWfJ9nTCJrdNYgzSVtMDyUQ77WIC1irOVs/81KASOqOUvhePIgcmFumT8jdMKkK0YXX/mv1e1AJ/SlSlmTx18q5ZCf7GN1ISqOeyB8wSI=
Received: from SJ0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:2c0::29)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 02:59:24 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::95) by SJ0PR13CA0024.outlook.office365.com
 (2603:10b6:a03:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Wed,
 15 Oct 2025 02:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:59:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 19:59:02 -0700
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 19:58:59 -0700
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Cruise Hung <cruise.hung@amd.com>
Subject: [PATCH 7/8] drm/amd/display: write segment pointer with mot enabled
 for mst
Date: Wed, 15 Oct 2025 10:57:08 +0800
Message-ID: <20251015025816.1542507-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
References: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 66eec476-ef9c-4db8-3b49-08de0b96d88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kq3jAMla0wokDlWOyVkYLO9I6MU3zf4Mt/fgZL3mtqKGQK7pA5mXTx9QI5BX?=
 =?us-ascii?Q?DXVp3qpgg+TDWxbnVkE/lYQppfGzjfeOnJ0Rlr2sSbdmWuCadJOUKkdA0nIw?=
 =?us-ascii?Q?Q4rxOXrR1eqEuGnhuy2tFS8DgxpRFeC8CjGgxW6TjJEBKP1Otet7mBw7fx2X?=
 =?us-ascii?Q?Bef2DDFkFfSh1aCDA45VJbFxQyj86XXU81Ii+louZ/eG7K3a0qbaGZG3jxsU?=
 =?us-ascii?Q?NE6HN6NIj+ap8xUBYoyZrFM/8mQCdIEVH7rBVhjyyDOGDtwN2C1O9U/pbusb?=
 =?us-ascii?Q?cYUUbkc0Itkm7Z01sxY6naLcIyIsNIJSH0ZBUzOtuQ3m81XU0R/cenA3zwLM?=
 =?us-ascii?Q?h7HhW7+pFecJG/04VNyjTkvis6mVqDudCm0Df2SxLXxDQQMcHFyqd/Ne+8UD?=
 =?us-ascii?Q?YPpJMCHIam4wgQqqfRbk5g3Yr4VuP2czJ7XaYSzae00mk9fUQB/bF/r8wJHw?=
 =?us-ascii?Q?/1KPYxGpXkK12iFHhi3sw/HQMEseF+uqhocL+zli5ZCQL5KfYPHchN+ZCSfV?=
 =?us-ascii?Q?4Lk4EhM8dj+Gvq6ga/bg3b6ZTKjtTjLm3mF61nTdez/mkyXpJHPujAIAkDZb?=
 =?us-ascii?Q?Zw3jAbM1RXOy+CbwjWm0Jg+fm3cNS62C/z1JtsjGZHqnGuMPqhfGQJNIoTcX?=
 =?us-ascii?Q?8qIAyWDS/8I3BkMK0/5dQgNvZktrWRvMr+ghanSyzs48dvBWZ8rZOF27hqDA?=
 =?us-ascii?Q?fGBLseOVQksMGrUXGkFBqzKp5HozSLVHJ11GmH0+RqSZqwaxE7p5brVB34Yt?=
 =?us-ascii?Q?aii8BOtUHQSNbZd1pQRpK9649r5vWuwMomm8l9GBRpC98LXPm6GDQCFTELGJ?=
 =?us-ascii?Q?qnWz/UZQMEyOqdSRRZ0fklgCBHzpQb+4GvXmqR6mUOu6K9Et2oG0wuxCz7QR?=
 =?us-ascii?Q?vdSPfbXnQx/z/jAKDZS5lCWFCZ5yfwq6xlCLYp81U+32M9SYvnqwmzpdapv0?=
 =?us-ascii?Q?Iq5r7mrCiN+FEg3Q5vRQJAHDVmWDi3Hdw7+x1o5d8PhePK/nS/yCSlQSYd6S?=
 =?us-ascii?Q?xeZKCF7zQTeeP0RLBHxNUh5BEzURbLZ77iVxt25zJTX5nvFpbJlqRm66TSbQ?=
 =?us-ascii?Q?EQs/XXptODE6X/OoxH+7MexkCPODJnDQsoQTtvcf56r7PCtCqF9aQAUckXCv?=
 =?us-ascii?Q?ty2JaDLUHUcW34T8lHDLoSPq27xT/V5W0drHUPtzMeYft7QG0gAwaRzgRkCN?=
 =?us-ascii?Q?7+yk/zhxzSRdK6T8ZO+rpO+94WpxH5wgp7C3u8+sh6t/tIue1a+TqnZSenCM?=
 =?us-ascii?Q?HTkl87UJx4KsktcScmtaJlOgsicdSnz0xp0hneFysVhuEpiv4EIecq/8xTNb?=
 =?us-ascii?Q?tZPQPjOxZdIEGwLOXUe7dqQZaq6xzBCFxUDcYLXQ0q9XobHPRLEVg0pY8VTB?=
 =?us-ascii?Q?A/eyKfMGWjdWZ4hDCzSq6Y46cJWj9aeM0DaF7yOWnH4wIWG6IVZ6V96a2icE?=
 =?us-ascii?Q?0VgqImw93X6myGtF373gFPrXY3Cc65fyNY30jjvgapSsLxBMsvSMFQkwr7Pp?=
 =?us-ascii?Q?xBu8hQBxFD8niJm7RH3xqkBZ6UIVrJia0tCQWZmdJeZ8vGeMeGbDxT9WoVEE?=
 =?us-ascii?Q?LCGEmrQJsAVY3YbemW4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:59:23.8104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66eec476-ef9c-4db8-3b49-08de0b96d88f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
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
Some mst branches NAK's segment pointer writes with mot disabled.
So reset of segment pointer to 0 should be performed with mot enabled.

[How]
Write segment pointer of mst branch devices with mot enabled.

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c          | 3 ---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 31a73867cd4c..f06af98d46ee 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -817,9 +817,6 @@ static bool construct_dpia(struct dc_link *link,
 
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
-	/* Some docks seem to NAK I2C writes to segment pointer with mot=0. */
-	link->wa_flags.dp_mot_reset_segment = true;
-
 	return true;
 
 ddc_create_fail:
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 701afd2d4ab1..750147c52c8a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1867,6 +1867,12 @@ static bool retrieve_link_cap(struct dc_link *link)
 	link->dpcd_caps.is_mst_capable = read_is_mst_supported(link);
 	DC_LOG_DC("%s: MST_Support: %s\n", __func__, str_yes_no(link->dpcd_caps.is_mst_capable));
 
+	/* Some MST docks seem to NAK I2C writes to segment pointer with mot=0. */
+	if (link->dpcd_caps.is_mst_capable)
+		link->wa_flags.dp_mot_reset_segment = true;
+	else
+		link->wa_flags.dp_mot_reset_segment = false;
+
 	get_active_converter_info(ds_port.byte, link);
 
 	dp_wa_power_up_0010FA(link, dpcd_data, sizeof(dpcd_data));
-- 
2.43.0

