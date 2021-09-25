Return-Path: <SRS0=BWIR=OP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEAFC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Sep 2021 13:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA10C60F3A
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Sep 2021 13:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA10C60F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24FE6E25A;
	Sat, 25 Sep 2021 13:38:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2776E25A
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Sep 2021 13:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYnl+e0Zp5gL2UJEUfzJC+MhPLKqLqq2HG9w2RO3//mu8Ozf3TS9kdCAdhxETYqw+hpoRSU4qO5T0rS+94Pl9bdC6S0uYZQdLFtt9BOlj5fGfRyi0zwHAHFP8+3cdk7b2SEtXDltU/zEz6no0g0guvZ0sUPjXjrh3CCnSO0nLTWDcSV6zm/EddiqhwrSSd8kVC/HNk+27+Uu6lyxIpGIrmMHr0dcKZnIlKzCoL8Kin8FCdCfUTpS07manyLVQGzZ88fd/kRZG4Li1lRm+GPy1vUPJKEVKDX4ZRQGwTIeR+VJYnizmCokWTJwsBdYmNivrwcb+7gcFARNhWQO+PVikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=flyP6kWRv2oiLm+IQPpNQ/4PxlZYwnN1xVobiVPkQno=;
 b=L8L8903p6dlfmxS+uwejlrzjRbo5S9HV8tS0BdvEDba0bCQnrx3WFZsjQz1ma8XicrEjI5OFIXjc/n+zmCUtsKhPw75Leclu3vUYZUyNUqvmFUU8zcoBUxIV1iXQ/qEOOv0hnmuQu8SZhPZ3PWqKHcuqAYEQt8Ddr0Bg9le5BmyZ3wokc5Vf2T8ZL/JKJDgqfD5Rp/KXMv5hFO18z8hUhtg8yydxemqC+Ravkh0g0bbNsnhmfQo9Hb4Xzmfzy1WMLgraHurLCWocC4YPrnq//RN1YM0Hkh1fetKmqTHaWBpxur1SRHCKLXhX8gRGLyBZLEYQKoVCvrG7Ksar32v13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flyP6kWRv2oiLm+IQPpNQ/4PxlZYwnN1xVobiVPkQno=;
 b=NucGNUgX/HRfKKPf2nAQrhgyAhMmOEeGYz/f9bHOH1sIOSGcP4R7TNSUf1Fp8KZfqqhuWqAB8P4zrbhkkM4LJB/SlREUIV+LJz4Bsn3ADDKppkpMBabWa98x8DgnakNSFrSgasAmMd8Qjz3dkjVJQIXheAviiLPZvxSMA41fgBM=
Received: from MWHPR12CA0031.namprd12.prod.outlook.com (2603:10b6:301:2::17)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Sat, 25 Sep
 2021 13:38:14 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::c5) by MWHPR12CA0031.outlook.office365.com
 (2603:10b6:301:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sat, 25 Sep 2021 13:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sat, 25 Sep 2021 13:38:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 25 Sep
 2021 08:38:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 25 Sep
 2021 08:38:12 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Sat, 25 Sep 2021 08:38:11 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>
CC: Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH] drm/amd/display: Align two DP2 headers from drm
Date: Sat, 25 Sep 2021 09:38:07 -0400
Message-ID: <20210925133807.684459-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e64adb-5a30-47f4-7a98-08d98029b94b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5181:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51811F5EF2D739C134F6CB8DE5A59@DM4PR12MB5181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xgJBvLudSuay09QlYgR8IjgZSCO8/7YYeLK5B2Tf0Uwy+oHMUDuz+zgy2s3FVyvEyyINmvTjhRnKt4I9Va0D1ycF/JL01/hasc6ciJAFCrYXC8vvV6MEsRdR+AT622PrzYgcL7qnLW+qGTTkcoD1N+NGOKMbWEV8NoTgFzkswLPDtJpl8UaZ6kg9Jt/iBSO3eC5rrWrlR35zu6MuFQyqQxqvZxi0vAKeIBVZch5Pl9l9K+xEnvM2/QWTtL1p44wNdPpTNLJxfCjlkKR+Ek348ycaCidnbIJsn8v6TXPLCAbLYnf0Z5h3TOcWthL1gLhpKfxJ2rIQDI4O7/8siwe/XPL0Q0LdxSmmGE72YXY5701SuyqWI+1kee9eiOHg11wJZ7r1U1PmFtapz3mfc60beruEIm8XBhXG5pFWIT9Km4Hy7VuB8xW9Djp3xUdWpo0pqrPoZ7v1pYw/LUiuJ7GZd6nTQnV7yjfzayKAP+R76K5gg2zevh/DjrzP6YXFIQ25AuVYiW7Ihk40jZaqKCOrMZqa/ZPmnnbEiTrkULZ8TA/w0SuKG9kgRKfyWkc7yDnqHyo2nnpA9r42eucxSBJ6MpizBZzWv0Kw/cLxIicvMZslVCFVMpNP7lb0eNjljE3I1loG7wsFZfN2B/1qTeYYzae28ooUgCRkNw4sQ2ErkactvnDTGWpef2v3QHI4w+hP1FqYMlS5u13qVbucNNmfhfy+LCo+ah3Q9VXpv3/Bw2RzH6dio2XP/ckCJX3kKPwEvtJZuj34HhdEuKJn0qPTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(1076003)(508600001)(6666004)(70206006)(86362001)(8676002)(110136005)(8936002)(6636002)(36860700001)(26005)(426003)(5660300002)(2616005)(4326008)(70586007)(186003)(336012)(7696005)(356005)(36756003)(81166007)(2906002)(83380400001)(316002)(82310400003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2021 13:38:13.8922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e64adb-5a30-47f4-7a98-08d98029b94b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
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

Two DP2 headers are available in drm that local ones should be removed.
Will submit a separate drm patch for all other DP2 required headers.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c |  4 ++++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |  7 -------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 120c9955cafb..6be944ac46e2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -146,7 +146,7 @@ static uint32_t get_eq_training_aux_rd_interval(
 	if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING) {
 		core_link_read_dpcd(
 				link,
-				DP_128b_132b_TRAINING_AUX_RD_INTERVAL,
+				DP_128B132B_TRAINING_AUX_RD_INTERVAL,
 				(uint8_t *)&training_rd_interval,
 				sizeof(training_rd_interval));
 	} else if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING &&
@@ -2107,7 +2107,7 @@ static void dpcd_128b_132b_get_aux_rd_interval(struct dc_link *link,
 	uint32_t interval_unit = 0;
 
 	dpcd_interval.raw = 0;
-	core_link_read_dpcd(link, DP_128b_132b_TRAINING_AUX_RD_INTERVAL,
+	core_link_read_dpcd(link, DP_128B132B_TRAINING_AUX_RD_INTERVAL,
 			&dpcd_interval.raw, sizeof(dpcd_interval.raw));
 	interval_unit = dpcd_interval.bits.UNIT ? 1 : 2; /* 0b = 2 ms, 1b = 1 ms */
 	/* (128b/132b_TRAINING_AUX_RD_INTERVAL value + 1) *
@@ -4593,7 +4593,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
 		link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.raw =
-				lttpr_dpcd_data[DP_PHY_REPEATER_128b_132b_RATES -
+				lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
 								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 #endif
 
@@ -4875,13 +4875,13 @@ static bool retrieve_link_cap(struct dc_link *link)
 		link->dpcd_sink_ext_caps.raw = 0;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	link->dpcd_caps.channel_coding_cap.raw = dpcd_data[DP_MAIN_LINK_CHANNEL_CODING_CAP - DP_DPCD_REV];
+	link->dpcd_caps.channel_coding_cap.raw = dpcd_data[DP_MAIN_LINK_CHANNEL_CODING - DP_DPCD_REV];
 
 	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
 		DC_LOG_DP2("128b/132b encoding is supported at link %d", link->link_index);
 
 		core_link_read_dpcd(link,
-				DP_128b_132b_SUPPORTED_LINK_RATES,
+				DP_128B132B_SUPPORTED_LINK_RATES,
 				&link->dpcd_caps.dp_128b_132b_supported_link_rates.raw,
 				sizeof(link->dpcd_caps.dp_128b_132b_supported_link_rates.raw));
 		if (link->dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR20)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
index 7f25c11f4248..ff06d6060e9a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
@@ -127,7 +127,11 @@ static uint32_t dpcd_get_next_partition_size(const uint32_t address, const uint3
  * XXX: Do not allow any two address ranges in this array to overlap
  */
 static const struct dpcd_address_range mandatory_dpcd_blocks[] = {
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	{ DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV, DP_PHY_REPEATER_128B132B_RATES }};
+#else
 	{ DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT }};
+#endif
 
 /*
  * extend addresses to read all mandatory blocks together
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index a5e798b5da79..04a71e10bb97 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -860,14 +860,10 @@ struct psr_caps {
 };
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-#define DP_MAIN_LINK_CHANNEL_CODING_CAP			0x006
-#define DP_SINK_VIDEO_FALLBACK_FORMATS			0x020
 #define DP_FEC_CAPABILITY_1				0x091
 #define DP_DFP_CAPABILITY_EXTENSION_SUPPORT		0x0A3
 #define DP_DSC_CONFIGURATION				0x161
 #define DP_PHY_SQUARE_PATTERN				0x249
-#define DP_128b_132b_SUPPORTED_LINK_RATES		0x2215
-#define DP_128b_132b_TRAINING_AUX_RD_INTERVAL		0x2216
 #define DP_TEST_264BIT_CUSTOM_PATTERN_7_0		0X2230
 #define DP_TEST_264BIT_CUSTOM_PATTERN_263_256		0X2250
 #define DP_DSC_SUPPORT_AND_DECODER_COUNT		0x2260
@@ -877,9 +873,6 @@ struct psr_caps {
 # define DP_DSC_DECODER_0_AGGREGATION_SUPPORT_SHIFT	1
 # define DP_DSC_DECODER_COUNT_MASK			(0b111 << 5)
 # define DP_DSC_DECODER_COUNT_SHIFT			5
-#define DP_MAIN_LINK_CHANNEL_CODING_SET			0x108
-#define DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER	0xF0006
-#define DP_PHY_REPEATER_128b_132b_RATES			0xF0007
 #define DP_128b_132b_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1	0xF0022
 #define DP_INTRA_HOP_AUX_REPLY_INDICATION		(1 << 3)
 /* TODO - Use DRM header to replace above once available */
-- 
2.25.1

