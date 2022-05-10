Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B392AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5168010E8BC;
	Tue, 10 May 2022 20:46:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C69510E8BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcbvEBgIVkSVY78LbOW+XxMBlziQoMSSBRuokbTD49v3hfQ2RtKqdDKLDKhu5yxt92igk/9e0Sl7htzmOoX6/VL6hMS1wNWeXh1LEREXmhPmzpVQdQ6khj0+6g/kW8mc/7BFQ/0cZRKp4nRBCTvLVMVzKbMeb4UZ0VVmg7SNz5bJ8wcVKmxfUwxR3+pIFTzACj1EUmpCPRPrsG545dCXzNRliJ3hvAymfDSTs8Jmcmh0vL6l2jn+FnknjUI4vrouAp/Ye2vEW5Dk/8QD0/0Q9PFBDXWwG/3UXdNs+Fmrrj/lzm7yB82Cmf0KGRdvfyWJ4U3G7p8AlKUXdn0eNnSqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fTd0B3/iIjnI5YCAQyrq5DTlyrYShC0ixJJnZWz5NQ=;
 b=V2CPG8te3KsFrHSFy9drJp8r+OYpNe8FP0fsDtYiMUrWmO9Swm6bqHZMYpZvRGn2caB2FDUVb4JgYFcrbxiy0XRVnfpvO0mB+eWBJMjqgVbPT6nhWj5Kq01rSAnsuLcxhmNfVgp1NhQc0h1S51beJVtweN87u7/QSm2NRUs5pOGb4pHq+ZmVadBCRFr+Slu0/Yr5RFrqDmfPHDLJCEpk8fnmU0/rtdcq/ca2gwnbF6C49Xahi3cAU905CFXfZPGolVxkBLXsRkdccXGxwCjVvVLTHXmR7ofYXdLjgmCHDOTfCTi/qcPSDahf7lsPc54apOJ0oDqEcvmujhZ7bPvYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fTd0B3/iIjnI5YCAQyrq5DTlyrYShC0ixJJnZWz5NQ=;
 b=nE7f4HzXRNyT47i2jG8KW8NTVovJQqk4FJtz2R3q/ILD6KgSOtlZgM2hia9osfymIwaLdR2tTBVUxMgAxwlWRW4PAINqzr9cRtaEvLZv3OZQRYP/4C3WdWO5fqFOWKtv2ZimRQWeiLWuQR0eslU5s8JbgQ3SzCrIhVoi6p7hl6Q=
Received: from BN1PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:e1::15)
 by MN2PR12MB3869.namprd12.prod.outlook.com (2603:10b6:208:16f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 20:46:10 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::8) by BN1PR12CA0010.outlook.office365.com
 (2603:10b6:408:e1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Tue, 10 May 2022 20:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 20:46:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:53 -0500
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:45:49 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 07/19] drm/amd/display: Passing Y-granularity to dmub fw
Date: Tue, 10 May 2022 16:44:56 -0400
Message-ID: <20220510204508.506089-8-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10125812-7714-4df2-b16c-08da32c61d3b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3869:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3869495AD9E0874106BE3D7A8DC99@MN2PR12MB3869.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3f+2u8JD2BQIPKf8SAXkXEZZK7MlOK+3iw+USm9wuV5/Y9IsU1LysRU0yFa22p9T+BJqskdx2ahBjJay3L+4qr44Pa6gF2/YwvE8mdUHeAZB9bESvmAUDQSjWklXFynYJIBpB0oS0bKLOYP4SgguxBZ9UPoEtzVlMHSHtXOXJptnkjcx9UTDczU4RIBFLn4cHWpBCeaiYRohfg3H6lHlh2VcfX1zOjh3m9/kxaYAGPLasZrvmDoHP1V37PwwRDwBvvePc/N7ZaObz3xeNAxsOOws7JB5nEepw+qwkoSY8nO7muIfFjPbT7RGLfFLq/GpuCyROVjEmRrT1KWOCP2lemzsiOC/3SEYo3EIlo/0evAZ79RDQYe7MqQ5thJXJY8l1VgrHtPMdAgB7mobFVwlAI6OZURaRYKvcUjLfZ/VrA2ba4rBr2YAd1CCy4UuBipjBZf2nFqKPLdi7dMkCSnG5WuERlSHa3pubEyX2qIKqVbQueoqcjZiAaM1u/+SohApwhhwKqyVHe8lc8CnxjBAl1HerABKPFtel5xuDzurydSA2KBd9RI5T1pJ4dPn2/WU1KTlrF6YZYE5NXJczoHMhKyd73VfPEpLIn6mpRPVPKqaf9IgYQlbECehpYhqj71dd6O7sJKp8f63JBfwx0vwGBqQqs2aATtVE/yvBzfANwdciRcbD+JeLviwWbz1xIXCbb8zDhIobjl5ZHvccyaHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(1076003)(426003)(86362001)(186003)(316002)(4326008)(336012)(82310400005)(26005)(47076005)(40460700003)(5660300002)(36860700001)(8936002)(81166007)(508600001)(36756003)(70206006)(70586007)(2906002)(7696005)(83380400001)(54906003)(356005)(6916009)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:10.1086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10125812-7714-4df2-b16c-08da32c61d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3869
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
The Y-granularity panel parameter indicate the grid
pattern granularity in the Y direction for PSRSU.

[How]
Send the Y-granularity data by PSR_COPY_SETTINGS dmub command.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a391a58252bc..d972dea21b2d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3239,6 +3239,10 @@ bool dc_link_setup_psr(struct dc_link *link,
 			DP_RECEIVER_ALPM_CONFIG,
 			&alpm_configuration.raw,
 			sizeof(alpm_configuration.raw));
+		psr_context->su_granularity_required =
+			psr_config->su_granularity_required;
+		psr_context->su_y_granularity =
+			psr_config->su_y_granularity;
 	}
 
 	psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 2ba9f528c0fe..d61ea3e2bfbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -672,6 +672,10 @@ struct psr_config {
 	unsigned int psr_sdp_transmit_line_num_deadline;
 	bool allow_smu_optimizations;
 	bool allow_multi_disp_optimizations;
+	/* Panel self refresh 2 selective update granularity required */
+	bool su_granularity_required;
+	/* psr2 selective update y granularity capability */
+	uint8_t su_y_granularity;
 };
 
 union dmcu_psr_level {
@@ -775,6 +779,10 @@ struct psr_context {
 	unsigned int frame_delay;
 	bool allow_smu_optimizations;
 	bool allow_multi_disp_optimizations;
+	/* Panel self refresh 2 selective update granularity required */
+	bool su_granularity_required;
+	/* psr2 selective update y granularity capability */
+	uint8_t su_y_granularity;
 };
 
 struct colorspace_transform {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index f1411a22cf1e..6883dd5b80d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -333,6 +333,12 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->debug.u32All = 0;
 	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR;
 	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
+
+	if (psr_context->su_granularity_required == 0)
+		copy_settings_data->su_y_granularity = 0;
+	else
+		copy_settings_data->su_y_granularity = psr_context->su_y_granularity;
+
 	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
 	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
-- 
2.25.1

