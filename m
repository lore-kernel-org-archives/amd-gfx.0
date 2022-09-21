Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13AEECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 23:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11BEF10E9D9;
	Wed, 21 Sep 2022 23:18:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D4410E980
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 23:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmBNXXmeYsa6fkrlMTlkj0BPdR2BsdSNSzG0gJn+/V4M965SAdltNo3U3GYozrDyZgju39i7AmDsjW+8spFOcdZP0YkGdCgmIoQubGVETbxDOh9dXX+DK/bg6Pusynq1rkfuT9ER1uMQ1OhlDw0JXqfJtCzf8fVyR3LolGgjyedxitaAaGrMBmM2uk8RNKtTIerWg712qn2+C0OHvmiASCd7nI2OOhmq8Q0CTjXd7lSS7Edp7neUrXDpmi+5QQv4qRockZxe5qcWGN/r+cNbdF4Ip9gL5u2PVDDYaE/pm5VKt6qmHJk2dAzNR5xNWJ7y92leJ/4dPvoG0UrFCUv++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoSRgVS/PZ39531SvCMBwWF7krjWfHMbMlL4ZNKq5uM=;
 b=WajKRIsdgRp2tBxxcx51zvjd6pLYv/D9ZihPizNUXn0KmK6CQ7XelEknhciRTrsUtnka6n9Z15+5BcCrIDguu/FtiHfUALk3IRbgEaTg+ZSdsSgtMPNKHmjNMpl3xb/V6LXBeWxRAX9+myu+Zj2QDC+SHbYaB5m9RlQoQo2vfppIZjFhlqN/QKNzXMnGbQZhAyyZA3eOT3/8LdKXaVwgeNDObTO5wsmWZCYDSu0QZ0WT9PlJBxb+/jASuKTHDN/WnAVPmh38s4AJmdZMQyw7gJZ6a/ADmovdClLQFyK6nAIHWm0owTHJFJe2pFTlt14HXrTfFVHqi5HbdrGcxiC+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoSRgVS/PZ39531SvCMBwWF7krjWfHMbMlL4ZNKq5uM=;
 b=TDKjyLIU/bnUEUbShQ9vEsA55bMFQUIN9Ynqn2y4RlHO2qBdoh2+xodz+2VdqLxbSme/pNKrmvC0hGKFglnO9kztva1ppm2Zx4p7RxTPzfhBqmQTWJRdiHm2auZE+PJ6H19EY0qQEYdyWJVFe8eAHrg2xb72MlNiRlnCx24qcDM=
Received: from MW4PR04CA0320.namprd04.prod.outlook.com (2603:10b6:303:82::25)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Wed, 21 Sep
 2022 23:17:44 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::b1) by MW4PR04CA0320.outlook.office365.com
 (2603:10b6:303:82::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Wed, 21 Sep 2022 23:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 23:17:44 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 18:17:41 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/31] drm/amd/display: Do DIO FIFO enable after DP video
 stream enable
Date: Wed, 21 Sep 2022 19:16:51 -0400
Message-ID: <20220921231714.303727-9-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921231714.303727-1-jdhillon@amd.com>
References: <20220921231714.303727-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 04afafd4-e833-4acb-4c40-08da9c277d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRfLB1Ysd6O6WbjESNJGF+hI3B5kO6JLBZBYtXoFOgnI/zOwQ8jWD24+ba1RsQDXZ0pE6MPGj0xuXbgjNyQ30LZ128AMDD5S+AJTNhZNKGjY04BvQfWnY1KGjJmZcUYzajMZiFAnTn7/kLPRqwL5KrC9Cg1xVoyF+vLHP/Mf5ImYYbuJW/cT5xT87OVcC6iL5x8jWLVRIJJ8teypzbeJp4FCgCfLN2Msx7dorKRyz/S7FmBowzpF9Xyy6eReQdzLw01U5Rn/IzX13xW/y9PlfjmZnRV/s9Sw9sufMP1MiEAJdl1LZApnFSdnpoSvPC0kFF+UkLekSxgNJUnPnv2c8nmtMXiJHya4pZvzfdi3FIO9Gjnf1BfiwXSnNnK5EemXzeI7j80WuDpmyGyxB69nuRzBgy743UgNFTJGN2c5okPi9QiX3/6F01Wrf32SsS0wi8Mfv1dUm8gBaybedArFf6jEmCqIRAE31ahZJfLMZ8jg/EplA7vpPA6Wa+bvQxaWvMzgHK9wH/zIP4WEjkb+Q26+3F8UWyfiaXCsNbeFudhbqCxcAg668P0YlyycEPlaY29p+aWMMpeIHitdExtGLJ2juAMmQuEvD3XcCyMutMMREZZsaAy6IdLLtB0UpuguNqfU8eQuARkEtJkUKaLGMMLYl+KMwh8wmux+fAX14TGb3ESowgP+52sLRvlpQjuTvd7kgnqk0KPjIPS5GpiTY3/WRpqNa/QyvHwKlh6ShGKnMnHfus7ZMN8WSRnafRLVjMDJyek/b0iNHtrZTars0pR1g9h7gKKXI+qU8OkD9sfdXwQ8vJa/2FmJl2CjTOOs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(8676002)(70586007)(8936002)(5660300002)(70206006)(36756003)(478600001)(336012)(47076005)(2616005)(16526019)(186003)(316002)(426003)(54906003)(1076003)(6916009)(81166007)(2906002)(82310400005)(6666004)(26005)(40460700003)(4326008)(82740400003)(41300700001)(40480700001)(83380400001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:17:44.2511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04afafd4-e833-4acb-4c40-08da9c277d31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
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
 qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Syed Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Avoids a race condition where DIO FIFO can underflow due to no incoming
data available.

[How]
Shift the FIFO enable below stream enable.

Make sure fullness level is written before the DIO reset takes place
and that we're not doing it twice.

Reviewed-by: Syed Hassan <Syed.Hassan@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/dcn314/dcn314_dio_stream_encoder.c   | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index eeee3107bd57..0d2ffb692957 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -56,7 +56,8 @@ static void enc314_enable_fifo(struct stream_encoder *enc)
 
 	/* TODO: Confirm if we need to wait for DIG_SYMCLK_FE_ON */
 	REG_WAIT(DIG_FE_CNTL, DIG_SYMCLK_FE_ON, 1, 10, 5000);
-	REG_UPDATE_2(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 1, DIG_FIFO_READ_START_LEVEL, 0x7);
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, 0x7);
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 1);
 	REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 1, 10, 5000);
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 0);
 	REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 0, 10, 5000);
@@ -326,15 +327,11 @@ static void enc314_stream_encoder_dp_unblank(
 	/* switch DP encoder to CRTC data, but reset it the fifo first. It may happen
 	 * that it overflows during mode transition, and sometimes doesn't recover.
 	 */
-	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, 0x7);
 	REG_UPDATE(DP_STEER_FIFO, DP_STEER_FIFO_RESET, 1);
 	udelay(10);
 
 	REG_UPDATE(DP_STEER_FIFO, DP_STEER_FIFO_RESET, 0);
 
-	/* DIG Resync FIFO now needs to be explicitly enabled. */
-	enc314_enable_fifo(enc);
-
 	/* wait 100us for DIG/DP logic to prime
 	 * (i.e. a few video lines)
 	 */
@@ -350,6 +347,12 @@ static void enc314_stream_encoder_dp_unblank(
 
 	REG_UPDATE(DP_VID_STREAM_CNTL, DP_VID_STREAM_ENABLE, true);
 
+	/*
+	 * DIG Resync FIFO now needs to be explicitly enabled.
+	 * This should come after DP_VID_STREAM_ENABLE per HW docs.
+	 */
+	enc314_enable_fifo(enc);
+
 	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_DP_VID_STREAM);
 }
 
-- 
2.25.1

