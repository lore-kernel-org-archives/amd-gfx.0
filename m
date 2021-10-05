Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27BCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 08:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A613861352
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 08:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A613861352
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4453A6F5B0;
	Tue,  5 Oct 2021 08:00:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C646F5B0
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 08:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfIa2AwlOTDcUXP9rk4LPRqbKAAaL/UeqR72HUlhaUJVqnqMR/2e7TA0+67zGpIFjufg4jPVBWWw6EKRK8r444/RtK+2MkQBfmaCfjhqC8EW1l+xPLx/DmGG2MaiUE6tjd0qs+DYHuHovATpFQckgFDnzvWfHHyVSgrpWwgy2Tkjma9y+hKXoci9fFLM5L5OYg8BmCzKCkjFfMWVR9Wfy3C0xFI2UikVwO6Sbgxu7aocCxtuMHOAbV6uFGSM5YzAos88FKQuY7eowI3sDvfNf57bZANi3tlHIDqzVMGymosb2ythYO4d7Awadlduq31DMU8YMembHlbv5cLuSekQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkF9DYrc4tSkwuGw1U6PO2GKA8jQdLCcr6vDNzWyhd0=;
 b=bC9qarqR5ZG2i1TNCUtftqiH5JVvpMa+wRmjJ6/fL58DT1s5/c9kCL4pFANQ5+6Qo12nBAYaSkSBu7OSP/lNLATkMU4Jtonf90BQHnQAUsojslsbV54NJex03RIxw6wZrlhbIJXKiXwWzDDS36b0XuWj4GbahT2smgqPMkXCGMH2Mt9E8fbaCwLAI5OMmOJwP6ZPgqOCWC3I3d8faryQShWD5aWpWyArUwjo9I4rIn3DmQbqgreOeH3hWWQf2XbxXvtiXx0itwTkbuzrsd21nG6FrdUmyL8pj2voGchPqJRX8gSsUB3rp6Nw2sYS6nghM+Uqt+S7qsPSyzsTxEI2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkF9DYrc4tSkwuGw1U6PO2GKA8jQdLCcr6vDNzWyhd0=;
 b=LvxADb3rrXLYt+PhT/whLaMZ9tj1X5dsW+0oxH+fIQLYm7B4+xh1bYmi6ZwaIYarVv8monmyOuoxGrb+/aUsZyaiNqdXwGIt4KoBiFtfKeNWTDLdlzxY0xrbuBvNyj9hH7DRYymMBHN7oeiT8T/zbkWv86nONMD2L83HT5hzCJI=
Received: from BN9P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::12)
 by MWHPR12MB1357.namprd12.prod.outlook.com (2603:10b6:300:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 08:00:49 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::b6) by BN9P220CA0007.outlook.office365.com
 (2603:10b6:408:13e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Tue, 5 Oct 2021 08:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 08:00:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 03:00:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 01:00:45 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 03:00:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 19/23] drm/amd/display: Add debug flags for USB4 DP link
 training
Date: Tue, 5 Oct 2021 15:52:01 +0800
Message-ID: <20211005075205.3467938-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64131bab-510c-4e0c-7558-08d987d63e2c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1357:
X-Microsoft-Antispam-PRVS: <MWHPR12MB135761FD0F2BD4044A85B40AFCAF9@MWHPR12MB1357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phSHHMg0fec154sJmspYH5H+m9wG2Og/ZUR+8KKPK24FiXNNU7M1OZQutwIT9lHkBFQ0YRZlg+bmhs23E1tu9wdhdfsq8q87kapi8W5mjQ+dYOWiJhM5hbvB779FbtIfXAFu1xfbU3/lgJgjtzuh2OdHnKJ/0rcKE06H0poNKa6BigodDT61BEDolAuI+biR65QCkJm/9rzuMpySAFZseZlMLYhhW9c6EM0Q5mhwe282qLrk15N+/NQgC/2oyRQz6u8uFf+cPsLpqjSBa07vOlmeJ3fu8DadhqWYtDnX9OLwEkqpNDzN0CFCPG6rmsO4iD30EFOgBvtwndg9qUnm6IA8zKJQt+hzeFCCDOKgJZRG97j++O0hqp3lNmpiv1XLhffUwSYZx/ibmnXlkvjz8/Uzyau4Ooi10hTGsQQQYSsIj8QKwO+mEDf+dbtqfLkYAYrWeHnWuxMjzDzGKP66pcbdvSEwy60tsZG73JZFpjKrZQ7WRp8X+9erTbQze/lHGwkz3wHNEWZ277uPHcbIKmwAP/iGuYf5CM1/4hGAln862+OucMxLM0M3/LT9c8GLi9V3eXv5vlxmrYUU+yKNS7EWAbF15RTmesuDkj4c5aSTZ+cuHLaV1E+2JNRMeYnK1KgYCtNE+noEjdOGcPkkq5GEb4d5iQlByACk+TxdmLHtENBKfuPlsBRvn/9uH14XMnv/T8+9eKyO91UF1h1BgYgQ6uTMJndQm01jhpKjh/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(336012)(186003)(8936002)(83380400001)(6666004)(5660300002)(426003)(356005)(8676002)(2616005)(6916009)(54906003)(4326008)(47076005)(7696005)(26005)(316002)(508600001)(1076003)(36756003)(70206006)(2906002)(86362001)(81166007)(70586007)(82310400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 08:00:48.5053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64131bab-510c-4e0c-7558-08d987d63e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1357
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

