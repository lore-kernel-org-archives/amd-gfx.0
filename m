Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0481EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC38D61391
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC38D61391
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0756EA11;
	Mon,  4 Oct 2021 14:45:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2EA6EA11
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk6I8pB6DXArU7/P7oQLmXjHZ08mz7s3C5qhEi8B0bkIHO0LDbnhWRMSMdCUKCl7vA1mcJjjADrESvuSrB7guL279BF2pjV7P1G7/TbddgC/54G6nYujT9364e9BluOAGZOSuoJ3BNgPAXshAnJlMB5PLhhLKZ6kS/1DYPLNQ4n6tBt5kVxUMWEpPsig7JGu1vaEKx9LvEWi1BVZ39NMhWGHcTKtDweXr9tSCUdSGdrNDvIBbzE5Ai9/WAnPhUodJkwPWVeW/9Z7EO0PtV6GNRlHRVNrSTMJUU3F5MqGMH4tUvNQq3HZ/b3pTUP+sJOD4rcxqZI9jpdSa8ASw9TUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkF9DYrc4tSkwuGw1U6PO2GKA8jQdLCcr6vDNzWyhd0=;
 b=N0+j2dH8gXoyEuaBRshyvT78YMcIuIe/UkdNIuWTJdEMdnVdIwOwM4daJCfmoAvks+ha2h1WbXVKyA8A7OuWeQg1fb/DjhXmO5lg9ggmRSsVWWq121V54mQ35u32mlGlpzwbOKukvilvr0HNMvg6jn0V31WOdlFubH2xKoOimdZAQS/BoNhkviOxy4pAWVgmK+pOf1cjLe5XcYl69HaQc1FAFvED7YlyKjDiz13VxR3EzrRA3RNrcOztmOrnhFpFiXPLYXG/WafdfP18uNzZZpHRCzp5a+1QFTLStl2kzWgMeWPIJKh/BLeHkSJbtneL/nutD2QWkBzfZNDBrB7S8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkF9DYrc4tSkwuGw1U6PO2GKA8jQdLCcr6vDNzWyhd0=;
 b=cmY5YAnuHrLWUUfkE5O+NJb82LRVNgKSV86nRZOKFrPb8SrncivYyqSt4W+nrxamHyGKls9Bl0e9BTETZVlMtRWtzQRx2CytSiHFRDDdhs9DJVI3CJDWZwDqxiaRclx/f973fDdqVvta5xmPspkQ4pb0BWnoDfgkCSyhH0JM6QQ=
Received: from MW4PR04CA0068.namprd04.prod.outlook.com (2603:10b6:303:6b::13)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 14:45:36 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::94) by MW4PR04CA0068.outlook.office365.com
 (2603:10b6:303:6b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Mon, 4 Oct 2021 14:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:45:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:45:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:45:33 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:45:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 19/23] drm/amd/display: Add debug flags for USB4 DP link
 training
Date: Mon, 4 Oct 2021 22:40:46 +0800
Message-ID: <20211004144050.3425351-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc59a71-398b-4839-614f-08d987459f84
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:
X-Microsoft-Antispam-PRVS: <MN2PR12MB420894773007DAEC6D2D5B0DFCAE9@MN2PR12MB4208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: se12csxPc4iEqApffsls4trLKiz4jwZOEhQariBND0bUeoA6Tia3MWN6zEbtK75jb6Wr2oCNIIut695Q3dNzro/RINuMks7dNehJF/RcNb6YLEr9c3CcxytgPGzhS5+3FTLJ+bxj06C8GYmQ34vTgHdyRw83uyzmhWpPKsLFwQWEjljrnhln//YOU/DY8p+n/odYowTZjJoSn5WWBeTC9Atd5qtTp1WWmH5WNfzXeSZUjgXMsWbo/AQiGD/2E9n6e3Pm635XfcpudDuJQJTWcTU2JdxAdMQpX7jI+Bl26ndzsC5ua7ZA1RwSrlMbx7EYdbKbcqRvzvytsK+QeycVefrg4Gz7eVboWmlcAHGBxnORo3dtUr2opSzjJX9het3Wk8qQk3zS3uLMik7/ZFhPQRi9T+xpJnz1e9UAI7dDU4J3Y1Gq2qJ7sSnKVIBZ9Qr42KiiLPfb/tzYp9T7pHAtd2/P/i0wcZhPaOl9yr5ddwL1vR0Wh/T6Fm4CNL1bjVBhCGYbAN8QtLF/zFNw2i7ReTXIa8jw3dJY+ouC0N7ze4HgHPpGyE/Beom7aClFqg3nFL/bFazS4DV9YmHlt1MNi5I6X51ZyOmxHxSVltDF/5DYGGI4xOsQXdmzr71XxVz0EyQ3zbZv4plMiUcOH8ZdPXTrwo+686dlfdPbOycdDgvvkaVLtIzogNbMq7eq4zuWxRbP9ovNhSVxpnDMAdtLLLDN9ydYULHnGcmxd6oK4Rk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(6916009)(7696005)(81166007)(8676002)(6666004)(54906003)(1076003)(2906002)(47076005)(4326008)(36756003)(26005)(70586007)(83380400001)(356005)(426003)(5660300002)(336012)(316002)(8936002)(70206006)(2616005)(36860700001)(508600001)(186003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:45:34.6822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc59a71-398b-4839-614f-08d987459f84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why & How]
Additional debug flags that can be useful for testing USB4 DP
link training.

Add flags:
- 0x2 : Forces USB4 DP link to non-LTTPR mode
- 0x4 : Extends status read intervals to about 60s.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 6 ++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h                | 4 +++-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h  | 3 +++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index bfba1d2c6a18..423fbd2b9b39 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4528,6 +4528,12 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 		else
 			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
 	}
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	/* Check DP tunnel LTTPR mode debug option. */
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+	    link->dc->debug.dpia_debug.bits.force_non_lttpr)
+		link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+#endif
 
 	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
 		/* By reading LTTPR capability, RX assumes that we will enable
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 7407c755a73e..ce15a38c2aea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -528,6 +528,12 @@ static uint32_t dpia_get_eq_aux_rd_interval(const struct dc_link *link,
 				dp_translate_training_aux_read_interval(
 					link->dpcd_caps.lttpr_caps.aux_rd_interval[hop - 1]);
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	/* Check debug option for extending aux read interval. */
+	if (link->dc->debug.dpia_debug.bits.extend_aux_rd_interval)
+		wait_time_microsec = DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US;
+#endif
+
 	return wait_time_microsec;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e3f884942e04..86fa94a2ef48 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -499,7 +499,9 @@ union root_clock_optimization_options {
 union dpia_debug_options {
 	struct {
 		uint32_t disable_dpia:1;
-		uint32_t reserved:31;
+		uint32_t force_non_lttpr:1;
+		uint32_t extend_aux_rd_interval:1;
+		uint32_t reserved:29;
 	} bits;
 	uint32_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
index 790b904e37e1..e3dfe4c89ce0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
@@ -34,6 +34,9 @@ struct dc_link_settings;
 /* The approximate time (us) it takes to transmit 9 USB4 DP clock sync packets. */
 #define DPIA_CLK_SYNC_DELAY 16000
 
+/* Extend interval between training status checks for manual testing. */
+#define DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US 60000000
+
 /** @note Can remove once DP tunneling registers in upstream include/drm/drm_dp_helper.h */
 /* DPCD DP Tunneling over USB4 */
 #define DP_TUNNELING_CAPABILITIES_SUPPORT 0xe000d
-- 
2.25.1

