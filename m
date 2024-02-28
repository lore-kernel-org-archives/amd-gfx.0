Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD806C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3BC10E6A4;
	Wed, 28 Feb 2024 18:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CGJKRC/d";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4870710E6A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbHoZEbyZvN/R3QEye16aERzpC957ckWhv4d/QLwoOneyzk7VVUxcY7qo751alKFCW5lkl5RTjJezYicyVu//jWqH8wry6Hkf3wXETwVMlt8/Wve6/3YGsG3/ouSZWbWrfzGDO02tLw7ACgOk4BXS1fPkLAcby8i7+HcXtDUg3+2aurZK1EnZhMjMl7jBthU+LllbRT9oHlqT0Sjfu/tM0LARz2EpE9o+3mGuLEHx7hnKEFddF1ta+YKWbCXibM7RLIaDQZYV3GERQU0zhluTE5W2VBZvyfaIDjOTYSZerOwckG2qsZJeiMvttoCax963eQm5e1QtfH4yjbT86XfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z5tMJJfuAX6ZR+xIpd1fPEVBCf3tipObP0dlCyNcPs=;
 b=NISHY0r//tOYS2I4TFU1CxfCQvvoQmZbypuzVWK6wrjrZkBur9ppzN1NUp1SwgYKQ1xx7s8aE3YkJ2HUi5PMCituYz94QgfFwFZPWBUIURdMuYodcj6xiAfwycTSSQ+2zzzrRAefCK9okNzMJ8cFK8lOT43NrGxluhVht6irEQgk7IKwNMxHNrGOaibcXb5VjyI7YVCM9kDK05UwHMRK6axFHtZgRbokDO1CEbSu91nfyTOX1X2DCHhhpeML1PpbPqY4vaxrXtU4zxEpJCgBvT8kr9z21eU/wQYdyjwx8BXu6YFAaS9fF7PiCdbJ35BDr9QHxz8kCTc/Zi8EVilobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z5tMJJfuAX6ZR+xIpd1fPEVBCf3tipObP0dlCyNcPs=;
 b=CGJKRC/dKL8xrYDonhhSGz77dXpwND9TQxvg9HvM3Hyco9ej7IcfSdtaZvWPEcWkG/zT9vBoZV0jvVxuI8ADvPamKkiV1kqTCpfhRdAq4Wj4N9mMjRlYvMiiVd3kNEsY6G0/E3SAjoVH6IF5prkPPiaPhzVBogkHsnL0gE0JYeY=
Received: from SA1P222CA0098.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::8)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:48:13 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::e1) by SA1P222CA0098.outlook.office365.com
 (2603:10b6:806:35e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 18:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:48:13 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:48:11 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 33/34] drm/amd/display: Add comments to v_total calculation
 and drop legacy TODO
Date: Wed, 28 Feb 2024 11:39:39 -0700
Message-ID: <20240228183940.1883742-34-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9ea4d5-7eab-4c47-66ba-08dc388dd1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uu6eQeHM+ugJFKyF4QqAW/rzoGSllHKNVQW/ZcXtKaVz0xRnUJoVXPSK4T6qb7lo0HTkBK4IYZGBG4A1A3A8sFNNDVP3KcPGy2nWzWRLjVb/YYWSneYqnKdpCJlxIUFda9X87/DqAN5NlbYG7hlYkfziaKc3ioNgbDtugo9ojTEDYKe5D8eiZ4NTA5bMzYZ22zhLNtXgtGzf8JM8ghNwRegWfzij4ctBN2mG1QjWCw3s/WU2FWDnwSJcPB1H3bF3qXQAkwFz/FdI+7QBWCACR9AqyNtDj4m2z+uPMUU8eUgVgW2M8HBQjBcyaRf1yTRCFsN1lTavhpEfWIIgUQfFRHHemsyrqWG7B6+bRCSmDKjmneq71sRyfK4Lhr+xFdHNge5HOGLhtZueNNIJM2gIpGttnjY+5PmxMIlrUsZyqxY2I0mTWiJ5IJjMr/aAyGUu1Wal9BsLk1saH2BmvIOigOfhXmwRwdorbdoRe5QwigNfFBC6VsNePhrZaI6pQ5ur2Zis/covibi5Tt2olvyrCvtVx1JMcI+O2kKRN4Lt1aqggFBbOHFOEbi6+hmPHvUVrRGpFZ3eDMv2+61mJwhYrrJI8clMhKP29pMXghBY0qxp/T4/kfJhqXMfLiuLFXrOzCJwvBfzPoCGg3xlZYLj4VajAsVdtIHhOsyzTcmizspUBHGGZO0pcDyMOuNCQk8wwmu9socTFkKv+7z9moCUqxwt0MPNGC+/zH6NBhTKXRo+xkcnHD2Rzn0JQj/i3KGv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:48:13.8095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9ea4d5-7eab-4c47-66ba-08dc388dd1a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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

[WHY & HOW]
This commit just adds some simple comments to help understand the
calculation of V total duration for Freesync. Also, remove a legacy TODO
comment from link service type.

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/include/link_service_types.h | 1 -
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c  | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 92dbff22a7c6..1867aac57cf2 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -73,7 +73,6 @@ struct link_training_settings {
 	enum dc_pre_emphasis *pre_emphasis;
 	enum dc_post_cursor2 *post_cursor2;
 	bool should_set_fec_ready;
-	/* TODO - factor lane_settings out because it changes during LT */
 	union dc_dp_ffe_preset *ffe_preset;
 
 	uint16_t cr_pattern_time;
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index fbaa6effd0e3..b19ef58d1555 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -158,13 +158,13 @@ static unsigned int calc_v_total_from_duration(
 	if (duration_in_us > vrr->max_duration_in_us)
 		duration_in_us = vrr->max_duration_in_us;
 
-	if (dc_is_hdmi_signal(stream->signal)) {
+	if (dc_is_hdmi_signal(stream->signal)) { // change for HDMI to comply with spec
 		uint32_t h_total_up_scaled;
 
 		h_total_up_scaled = stream->timing.h_total * 10000;
 		v_total = div_u64((unsigned long long)duration_in_us
 					* stream->timing.pix_clk_100hz + (h_total_up_scaled - 1),
-					h_total_up_scaled);
+					h_total_up_scaled); //ceiling for MMax and MMin for MVRR
 	} else {
 		v_total = div64_u64(div64_u64(((unsigned long long)(
 					duration_in_us) * (stream->timing.pix_clk_100hz / 10)),
-- 
2.34.1

