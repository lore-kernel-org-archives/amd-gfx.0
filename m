Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BACC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73DF10E3A8;
	Thu,  5 May 2022 14:24:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 465AD10E3C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNqjD1mSTFJTFmcov47UqRPYYyoglMGQ+P3GR5KASdtAc0pvBUaimtrOLVxczRrg2W/Ngjs+2VelW9sRfNCT4r7e9/f8TSQBfMol89TN+EJ8pHRLrs1YLOtX0WZmlkbijLlqOO+NakyklbYHLxe3CwxvFsx1Hk1bW23XZa+5C5NyrG3iDuyP22Q/6Cyp86NahtuGhLeVVt/jLPTjY/1EutnfxiIk0Ne/Ifn5i2YNsRjA5IUKh+YwcqQxyVTfzi2aofU0mhkBbHq8shP1oADNuSBdItbqqlTmx1T3BYJWGWdcf2QTn4GG3J9O10nGF7592MJK+pU0w8lmqQDnGpLrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZaN52GZrqiPlNHr9MsD4QCY/32n11hu7mh0hpHf5kk=;
 b=ZPFYZa3wP8vaUvd4ufwXtqlhG09XeSa4stJ5fx9YK0YJ6JR7CmOKRl6z2blNkptm0elL7WZgW6vPoxqs+GggrdnVjKKBs16F010uTNLrnCIHUgSWmI5VHQ5SNhSl28etqTDXEN6stUPKAVDGoKcjuZoicZzGlZ5ezxxpSMmHeTH9rjSSPHMXb0aKPKWOEoN3v1ZBvBuKY6ULqJXhb5imqdpDmfN4w3/gWy837LFdMYe/0/bYbJvVabokTi96/odhjKnYgCGWy5YjaXV1MEzzgVvAVZzM4ml3MM/P6Obt+XM5bqOz3TEF4YZos4h8vHlICBYDh++Ts7LU4egPhl6iTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZaN52GZrqiPlNHr9MsD4QCY/32n11hu7mh0hpHf5kk=;
 b=Xx52HQdJHmOi9dEffliU9SMu+f7U07tbywASw4Jsz2P5eq8ojnsatQeM72u2aGukNKvNXu6peGOP5D1Ix0o/fhVTXwfsSzusnYjfQQ6XtyAsm9CovOnZdT/dvSYXDwTPqAF9jnC+h4mu/8yoKNZoxK6bCWcMbMX/iTciEp/DpYw=
Received: from DS7PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:3bb::21)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Thu, 5 May
 2022 14:24:03 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::88) by DS7PR03CA0076.outlook.office365.com
 (2603:10b6:5:3bb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 14:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:24:01 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:58 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/17] drm/amd/display: PSRSU+DSC WA for specific TCON
Date: Thu, 5 May 2022 10:23:19 -0400
Message-ID: <20220505142323.2566949-14-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 898cd901-5976-4adb-67de-08da2ea2e6d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4011E80209310F2574296AE28DC29@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRTu1PsRlnyBu/xRAa1NxhJHn9e1X6FaGpsU4N3xu98RGmRYLV4PGChYy1kvUM9wasZXDaaDu+v2A9ugqg5KwdeBnzQbvzeYoaZ56DKaGWzIvrwzAsNmpo6bZsLlDU6LTTDdcqEuriUV+mLSI3SK6Z1v88gShlmNf+4pgSjknIcTBRwjfsUL254Ryk69CqzWPcAuWOJiKdMHQC9/L/G46bW+ZSor48KoljTcIv9jGUCkMrBy3vq96sK0eoQG6uwergta9lLukTUDOKji7a5PV25UxKpbDwl6NBsRAW5bUKMYMRxXBw27y25W4XIr/f76byi/hV4T29KdSA6XTbI/Eysyu7JCBDypOmWZyfXlWInyzhc0mvZ2cm8v/XbcSu/Y6yGJQv2istalCzz3Rh8bKbPM/lxv2rGduRrOLveGz7OqbQeTeciY1UxZ9eHjMADBAAjh4vf5aUxRsXnNcBnUTsdxV+KCcP45wWRkH3cRZuSu87z9azcN2mCJ/wY8Lj2q19bOyZKQLlTtJruVptupWLycEkn0414QiGegh8wDBerK01H9LMIPlCABWNscIDzRCAJ+yqx0NaakBhzxnKga7Pa06OkOx1VX9u1qm/+C1DUG+u4v/Y8r61Vr62UgxGYw8EyCm6NoAxqBiV9yBAWpEwr/7iz4k12aROyIt5izODXf0Bb9Y2sN4AaiUNn84vF0VG+mIx0ZE6vlm1D24VcThw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(47076005)(426003)(83380400001)(1076003)(26005)(81166007)(82310400005)(356005)(6916009)(2616005)(54906003)(36756003)(4326008)(8936002)(70206006)(70586007)(6666004)(8676002)(86362001)(2906002)(316002)(7696005)(186003)(508600001)(16526019)(36860700001)(5660300002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:24:01.7840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898cd901-5976-4adb-67de-08da2ea2e6d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Some specific TCON chip has HW limitation to support PSRSU+DSC.

[how]
Force ffu mode when DSC enabled if we detect it is the specific
model from sink OUI DPCD. And disable ABM update for this case.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index a3c37ee3f849..0bec986a6de8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -108,6 +108,7 @@ struct psr_settings {
 	 */
 	bool psr_frame_capture_indication_req;
 	unsigned int psr_sdp_transmit_line_num_deadline;
+	uint8_t force_ffu_mode;
 	unsigned int psr_power_opt;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index e784002fe312..9ca0cbb0af9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -349,6 +349,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->debug.u32All = 0;
 	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR;
 	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
+	copy_settings_data->debug.bitfields.force_full_frame_update	= 0;
 
 	if (psr_context->su_granularity_required == 0)
 		copy_settings_data->su_y_granularity = 0;
@@ -363,6 +364,19 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->panel_inst = panel_inst;
 	copy_settings_data->dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
 
+	/**
+	 * WA for PSRSU+DSC on specific TCON, if DSC is enabled, force PSRSU as ffu mode(full frame update)
+	 * Note that PSRSU+DSC is still under development.
+	 */
+	if (copy_settings_data->dsc_enable_status &&
+		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 &&
+		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
+			sizeof(link->dpcd_caps.sink_dev_id_str)))
+		link->psr_settings.force_ffu_mode = 1;
+	else
+		link->psr_settings.force_ffu_mode = 0;
+	copy_settings_data->force_ffu_mode = link->psr_settings.force_ffu_mode;
+
 	if (link->fec_state == dc_link_fec_enabled &&
 		(!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
 			sizeof(link->dpcd_caps.sink_dev_id_str)) ||
-- 
2.25.1

