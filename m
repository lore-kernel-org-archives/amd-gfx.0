Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AA9C4828D
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Feb 2024 14:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 342D710EF9D;
	Sat,  3 Feb 2024 14:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wpRzzVxZ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8B710EF9D
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Feb 2024 14:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7si8fr1VQazBNES8TS6RXyRgSAviZAfrDngK3DAUB7PBgbei2xHNAshtpUvoVExipB+eVudHaBzJt2NP0jMlqP0d8UKkkTxWc07mhlPFRuJhtPgu/7if6ndfH4UBEUl0YRgfG8nuv++yjh17MGk2jKf0lT8njuwgMYLCB+6fgtBxXRaCgMNOj8piz6eT4FufKwPWKpuXZUZoPXjEbtq//OXtlJTlXX2Fa9np1COnGiHm1F/x1R4IHc+1d2lrEe3Zlj/xWnRt2oc3/4PAqgIMbg/hFWEG7nYpC+8500+PZTt4L/2km5DFe5dlKGlyx27Q6lv9+dLJH2S9kJlLlO0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7u+TRu72pXa3NIIS7gPxOYgPPT6yITA6Cx+yD+DW2c=;
 b=No2l7SnfMDJLGB0MYcwydvwK8xOw8vzUWnMEeflYb9+j3Bxx6yZezXSF2ZJXPnkzVrnyp5dkLRi/AeLMoP65qdi6OYP3wtK1dzSRIWJ8LTXkYEZrb1+IkZ/5+F14tY69cztQXMMRWc7s6s8nJYvA9v8oTffEWHsdepW7bBwnQN3ZK6I/tK45Pi6oyh2s5vQ20GbJBYEmwpZS4wd/RcZLXD4MWbFf6uGMZHUnaDFKfmyeivKHx1prYVLSdE2auYsqt3KfGW4f4jGrCIPyO3+uztfR5vH+pDS9+qPrRMz73XhzxCq9obzxgJHJZZcXyyI8wUkb/hC1l2n7XZsZ4VBFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7u+TRu72pXa3NIIS7gPxOYgPPT6yITA6Cx+yD+DW2c=;
 b=wpRzzVxZaNS48/sGLQlTfCF6RkdnULvJWTsVAYfglor9J+hFFvNrqB3U9W0ONoh4FYLjHQohaE0lBOyBGm9D8mhszdtc9Ucdjyk6HzRVBeMX4TrrZR/uGe2pYBMehT+zTJytMdoPvwJ8L3jqcxRwZ6mcvRWWfR9u0jQB2ii/2Qg=
Received: from DS7PR03CA0318.namprd03.prod.outlook.com (2603:10b6:8:2b::32) by
 DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.31; Sat, 3 Feb 2024 14:14:50 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::5) by DS7PR03CA0318.outlook.office365.com
 (2603:10b6:8:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Sat, 3 Feb 2024 14:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sat, 3 Feb 2024 14:14:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 3 Feb
 2024 08:14:48 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <aaron.ma@canonical.com>,
 <Hamza.Mahfooz@amd.com>, <mpearson-lenovo@squebb.ca>
Subject: [PATCH] drm/amd/display: Force full frame updates on DP 38-ec-11
Date: Fri, 2 Feb 2024 19:26:57 -0600
Message-ID: <20240203012657.1507-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f77859f-684a-42c9-2546-08dc24c27ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWUEr6wRjN9W9GffzUfkZiTjcIeV1HBW+4B1mX2SvfLw2MtHrHBYXEjSOCUzt1+q+rwuu0ehSzm0skA2dO4wdrvSnwae7NB+wLGzA8pMt2FSNt2IetUHe5g86eZ+2ofAb04UgtPqpF+MRTfQfyOf9aiHEoSNRE39acO+pbri77rOnhOHZSwfUuT0JQ01xobw5GIw1p/pQkd3Y4z6GXz1AebyuG9EbdtsmGjIzHWPNNErV2JRgZrTWiCk3icj0i1KiSuTU04jrXlMjdWF5VTsZ7DKnTDMosStq9mc5lfJj1Ym96gnJrVfIKBQUDdQAo1Iw+VDmXc4bDPxjbgGZZ+0Kfy3Gix/xMUuyAWgRsyuQhq/OGuGmDm2sO0sTC/BL1iChRU7GSqSu0+Blt/NUWMV5ESW9z/FFg5x2dLvj0UqC8GjFcGRvI3ow0tknlRyl4eld3Dvn+iWeL/+uRgdA+DP5vG7BZE5z93Ky3liTKdsd8o5pB/IB0vzAStxupvraFVfhUhpqBvBzv1nsrMACBpmeYskYPHEgHPI3SpZSX2a68hTH9QwE+nju8+pqWwu1m71B5MD+C8op+gRkWV9G7YFeE3ib26IY7KQPnF5+LOa00Vi/egK8iaCq6KjJBIGxWvy8jRyQjD7heYl5CMme2BRNxIKhcOmpt0+Qbtr8KekavP+bTwZZj8EHP8yxHYouWNqWjASMFPKV9u81T7EGUxvL+ecpELz6j8nqFUsBizpzLKkpkscAfp0iHbq6hJgS+An0d6X1P/RNvHrD7Z5NsM4GQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(7696005)(8936002)(2906002)(316002)(70586007)(6666004)(36756003)(47076005)(82740400003)(356005)(86362001)(36860700001)(83380400001)(478600001)(81166007)(5660300002)(8676002)(54906003)(1076003)(426003)(336012)(16526019)(2616005)(15650500001)(70206006)(26005)(4326008)(44832011)(41300700001)(40480700001)(6916009)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 14:14:49.5309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f77859f-684a-42c9-2546-08dc24c27ba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208
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

The 38-ec-11 TCON contained in some AUO panels will hang when used
with PSR-SU and changing the brightness.

Forcing a full frame update works around the issue, so add a quirk
for this panel to do just that.

Reported-by: aaron.ma@canonical.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Hamza.Mahfooz@amd.com
Cc: mpearson-lenovo@squebb.ca

 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 3e243e407bb8..68c619b43cbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -36,6 +36,7 @@
 static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
 static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
 static const uint8_t DP_SINK_DEVICE_STR_ID_3[] = {0x42, 0x61, 0x6c, 0x73, 0x61};
+static const uint8_t DP_SINK_DEVICE_STR_ID_4[] = {0x0, 0x0, 0x0, 0x0, 0x0};
 
 /*
  * Convert dmcub psr state to dmcu psr state.
@@ -284,6 +285,25 @@ static void dmub_psr_set_power_opt(struct dmub_psr *dmub, unsigned int power_opt
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
+static bool dmub_psr_need_force_ffu(bool dsc_enable_status, struct dc_link *link)
+{
+	if (link->dpcd_caps.sink_dev_id != DP_DEVICE_ID_38EC11)
+		return false;
+
+	/**
+	 * WA for PSRSU+DSC on specific TCON, if DSC is enabled, force PSRSU as ffu mode(full frame update)
+	 * Note that PSRSU+DSC is still under development.
+	 */
+	if (dsc_enable_status &&
+	    !memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
+		    sizeof(DP_SINK_DEVICE_STR_ID_1)))
+		return true;
+	if (!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_4,
+		    sizeof(DP_SINK_DEVICE_STR_ID_4)))
+		return true;
+
+	return false;
+}
 /*
  * Setup PSR by programming phy registers and sending psr hw context values to firmware.
  */
@@ -378,14 +398,8 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->panel_inst = panel_inst;
 	copy_settings_data->dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
 
-	/**
-	 * WA for PSRSU+DSC on specific TCON, if DSC is enabled, force PSRSU as ffu mode(full frame update)
-	 * Note that PSRSU+DSC is still under development.
-	 */
-	if (copy_settings_data->dsc_enable_status &&
-		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 &&
-		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
-			sizeof(DP_SINK_DEVICE_STR_ID_1)))
+
+	if (dmub_psr_need_force_ffu(copy_settings_data->dsc_enable_status, link))
 		link->psr_settings.force_ffu_mode = 1;
 	else
 		link->psr_settings.force_ffu_mode = 0;
-- 
2.34.1

