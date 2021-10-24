Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C9C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF23600D4
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DF23600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4506F6E134;
	Sun, 24 Oct 2021 13:32:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6F989E3B
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8Qz30bqmcF6o8P1S9eYsy8srZ00NEOUUPZ4/rEi3B+2I7lruYtZTP+YLCi+33ADBxX2LzO9oSylSW0feqUgwHpS0XdZm2KawwgbE7e6NW7Zbx2bTXZDrvsbbeShUSjJ4iG1KJceBuIsrc4EcsHDfMpzN5Bu2Trrk0gHVXPjfwivUGIa5VCn6V0uQA4U1muAN6VnFAboCodVXJEScRIwBSFtEzTo1ji7g0e8aUtRgX5gu4qdXpuE6LSMf21LABK+plF1v6dUGfnA5soADihBLHze4ApDU62siXWPfB26+llQWr2KdNobf5xEVegzT5Mau2CpFxdTN+jpcMPDwQiQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzR2KWdAb7QOEOf637ewHl1lXNbK6YkoGnSOGgv/pTg=;
 b=OX7q76lA1FvysckeGbskdHx9jhsC6f7FbyNloVmFvoWC9H3ulGgWtreKVVLm2mGDh0M5wgQPxS3hXegiNFQqsNmY4E/hOnBwCwkyxIGBC1AHod9XIqreH5fB0wXM2emDkwVFYH8Y1DuC6omwpAaythFEWqjci5zpi178wxRKfbv8FvZY/OqAI/b8LeriFitfoqBvh8oQtj9rqPMUxt6XvSM3EKrSGnCMQp9FEaDOrYn8t+/2fNzYQrtpAQojjJUBZhuXbGkCuIqJdNa+AoO2VSt0eieoTRD8f3jDybxchmQayQNAcAM71G2LrfrV9d2bfhMJ6zW8zvmyevF9m7MiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzR2KWdAb7QOEOf637ewHl1lXNbK6YkoGnSOGgv/pTg=;
 b=AToDRQU/AcXZcZMr5aOnFTrs0aVew1bV77oSJ87SiSU6opfS+0CYCkWvWAaLlwYq0h2TBxyL8ccdRkDRO2DuuX+BFusTigj3ejSBVXAPZZxUit6VdKz7ErZT7oAzP7YY1exZQyKwJTWKc47uFWTjy0pHsSSKukmTbYi0dX7N+v4=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Sun, 24 Oct
 2021 13:32:40 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::c6) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:40 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:38 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 28/33] drm/amd/display: adopt DP2.0 LT SCR revision 8
Date: Sun, 24 Oct 2021 09:31:36 -0400
Message-ID: <20211024133141.239861-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f12bb8b3-0c44-4235-42b4-08d996f2c082
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54448981C9FFF08E6F0D173F98829@CO6PR12MB5444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VI1ra+0ITrUX05RjEkBkKTGNgud+MHJbyCsYRC8waPoyHD193MB3gDl0EixqnpBCVmY9Z9+Jhb/hf4qLbT2zU4TJzGfiiliiSt1ulN4CuIL+3QQcsD1KfBlQml+9CKyy0gPBHZJzZS6KrPoTHliuiCCme4ttl83dZKAjbN2etT50a8Nbmt4M9HrcjVLnXWoin/I9Blte9GN2rsB2dLC0c3uns7MlWNZkmnR2TztpLArm0LZ4XRSZrFmVwkxbf23/uOVpZT8ds+yMm+ckyxwZ1L8UyXT7ijN7YzgjlDw+4OQRBLFu76lAeGPk+WyAW3BLqtNyvguQrndQxYS7qU8qQLTGLzdMIAcmtqZiZD5zH2sMYtELBdnqnWkwFVgQIYKqGG6p73iiD8PtYVH1+H2FA2XEalYr1vVvJz6C2V1VpSZWr4JYgFoD1C/ctb2L95EP1vLBEoBhE5mktR24S4QPBgN4BrM7Fj+2tXaV6e5iolDU5tip4u67ER6kT3KdwnPwR+jZNMat5a/HUmOGAjlfwiGtzPh1oz5IeiUjK7/chnM5NtB9Udq2LTrJpMur/wq3WA+Wyfa8JrXlSUnPWWZJBC8+bpJYHFAyVGNNSJihrJuA/HZsSVjoGqNs1Riw2wsE5YNh98cW9rEexbKgysh18jQ0GC9c1xHCqz9713OX237xIyzB40cZwysWlF6VHCkz7LUQ/cs8XxSWKy811k/3I+zfesGdfn+tLbh6GMQOv2w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(4326008)(54906003)(2616005)(5660300002)(36860700001)(186003)(336012)(426003)(83380400001)(6916009)(16526019)(47076005)(316002)(81166007)(2906002)(8676002)(70206006)(508600001)(86362001)(1076003)(70586007)(82310400003)(8936002)(356005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:40.4141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12bb8b3-0c44-4235-42b4-08d996f2c082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
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

From: Wenjing Liu <wenjing.liu@amd.com>

[how]
revision 8 SCR requires DP Source to write TPS2 and FFE lane adjustment
in one 5 byte write aux transaction.
It specifies to read aux rd interval value as soon as we turn on TPS1
pattern.

Cc: Wayne Lin <wayne.lin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ec269b7e91c3..a7ed88b75042 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2080,7 +2080,7 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 		struct dc_link *link,
 		struct link_training_settings *lt_settings)
 {
-	uint8_t loop_count = 0;
+	uint8_t loop_count;
 	uint32_t aux_rd_interval = 0;
 	uint32_t wait_time = 0;
 	struct link_training_settings req_settings;
@@ -2088,25 +2088,29 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 
-	/* Transmit 128b/132b_TPS1 over Main-Link and Set TRAINING_PATTERN_SET to 01h */
+	/* Transmit 128b/132b_TPS1 over Main-Link */
 	dp_set_hw_training_pattern(link, lt_settings->pattern_for_cr, DPRX);
+	/* Set TRAINING_PATTERN_SET to 01h */
 	dpcd_set_training_pattern(link, lt_settings->pattern_for_cr);
 
-	/* Adjust TX_FFE_PRESET_VALUE as requested */
+	/* Adjust TX_FFE_PRESET_VALUE and Transmit 128b/132b_TPS2 over Main-Link */
+	dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
 	dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
 			&dpcd_lane_status_updated, &req_settings, DPRX);
 	dp_update_drive_settings(lt_settings, req_settings);
-	dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
 	dp_set_hw_lane_settings(link, lt_settings, DPRX);
-	dpcd_set_lane_settings(link, lt_settings, DPRX);
 
-	/* Transmit 128b/132b_TPS2 over Main-Link and Set TRAINING_PATTERN_SET to 02h */
 	dp_set_hw_training_pattern(link, lt_settings->pattern_for_eq, DPRX);
-	dpcd_set_training_pattern(link, lt_settings->pattern_for_eq);
+
+	/* Set loop counter to start from 1 */
+	loop_count = 1;
+
+	/* Set TRAINING_PATTERN_SET to 02h and TX_FFE_PRESET_VALUE in one AUX transaction */
+	dpcd_set_lt_pattern_and_lane_settings(link, lt_settings,
+			lt_settings->pattern_for_eq, DPRX);
 
 	/* poll for channel EQ done */
 	while (status == LINK_TRAINING_SUCCESS) {
-		loop_count++;
 		dp_wait_for_training_aux_rd_interval(link, aux_rd_interval);
 		wait_time += aux_rd_interval;
 		dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
@@ -2125,6 +2129,7 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 			dp_set_hw_lane_settings(link, lt_settings, DPRX);
 			dpcd_set_lane_settings(link, lt_settings, DPRX);
 		}
+		loop_count++;
 	}
 
 	/* poll for EQ interlane align done */
-- 
2.25.1

