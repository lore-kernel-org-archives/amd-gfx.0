Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D031C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jun 2022 10:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D2611A73D;
	Sun, 26 Jun 2022 10:16:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4ADF11A73D
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jun 2022 10:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nq/gy5qaXZTwliBtWkfd2W4DB32SlNNTdHvCetbXAO36TQ0RbIVdPTTJXuNrqmxLDRjfvLqdEdmdWTaz1d6kiX8lF61ZXU/nWUZt2P3/MpL/psTrp1tGNnrVC3BZoQO9y97SQOrJgafI2rw8I8DjSnh2i75NaNBWQwC7tZa42s0KS0Apb/8VAQntEQAOczXwW6f2Ie/5rYjj0DGS+bwNHK9dJKX+ABI99hp5D/wVbVNy96ipYLsQo4gn2LLTSPMGA/pXnTTiECyqSIdOjZQjRNcQSW7g3Wfq3Qr0ftatTZ28OxjhdWoKVmup1vtat+MyP8rKgpkd1cnLR68p/v8S3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srcR4gX/Gnkwg9BXyBLvsjC8hwOqVIvfsZcN4IjoUHU=;
 b=UU+qdygdW+9Qu/arM+Wu0cQhIqJ0oAlxeXsAfeLR0okOwUZy4fW4Oj+qJEN9opL+KRtqnht5tzxk5fsMW25sjupNXSwAZEGDKDcsoO8cUinR5KwHZ6nfDmg7HmfAQ5aFhnHw8AaGjdwyYL6Ov4IoR6xW6SYR5cdq80/opVoEimlNnm0nb7RA3OxitYI37oYVTpr/S6d5NRK7jDynqL2T+7w4UvPf2QLIe5bnFl9RY3H/weV2f9dqAvb409itUPeOWKDgVM6Cnj+Nvri3X5EBYVBcRk51XZEEEgOQjERuNodg5kbYecCkS4+Ihq1XSUYlsEFE2T+mPowO8IUBd7f6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srcR4gX/Gnkwg9BXyBLvsjC8hwOqVIvfsZcN4IjoUHU=;
 b=Rb2BnHarD974g5FHvv9n80RFIAUv4QoSm8rVskqudN0ouiAT/n7xw11nzzHihuGhJjsRFE/gbOywE1GSAxnxVasF5R/+7SX+EekruYgN9pSEbDKiABEpjyb2LIYRoYNIAlWcoMt46lxdH+5fjR2hFW0FphNQjEldTZigR9QaMzQ=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by DM6PR12MB3883.namprd12.prod.outlook.com (2603:10b6:5:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Sun, 26 Jun
 2022 10:16:03 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::69) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Sun, 26 Jun 2022 10:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Sun, 26 Jun 2022 10:16:02 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 26 Jun
 2022 05:16:00 -0500
From: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Re-org and cleanup the redundant code
Date: Sun, 26 Jun 2022 15:45:37 +0530
Message-ID: <20220626101537.3317253-1-chandan.vurdigerenataraj@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 676d4563-ab99-4deb-95d5-08da575cdfcf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3883:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpJ+ifa4w76RK3fBw6PtJ8tzq8Ig/D3AjPxukZcw2BVg1DnHb3ODJm+aChgq7qbLL/DpSvYEis+skJGCuO3rQZrUmSO30cfxii4GPivFjHI9o94XShLaIllPtYUHnaW6JFMotUq7N4rL0GilVzKSMDRTFQyF/vw1OWecsNfKmCQk8DjrtvQvPaxPqwnTgs6GZq+zauHWJ+OH5ezsksCuRdnqb7tNKZuQvBAJLezcTaz+DyLYbbJpTQPt+cYNpALwF710pPQSIdnjz0noKKv5dQnAQeGA7340vGgaq8S7fAVSfvO3Pp8xYxT208MimymrMIToWNAR4INGnWuUyeFZUjQLb6ogN2QmIFKStzhkEFggDOqu4pUHQjH9U8Rr8TCsMSqWNHdb11wOf1nVQzgKSPI42WyZ+badYH8X39HzzivEmOdLoRbFQwlCBKe0yEMtgKdiK7WA2/mNuPA7xrL0AT1t4kJmG5XdEu6ydQfTtfdC9nAfABjGQH1VPZ0U/fj1oGntZZPrQAaq/Nfqs3YxAlOU/xy8p6S+AGIfMLnvHw9zEFbhgqt+jYhx3K5Snyoeq/5Vj8+yVawpskGBPgBPuA3FkDBkx9Qv2P5eNT1lbybqM9Vz9YZkjO/X4FwFkdHwPNBfMTRngJkMaV7PSw0bNuf0OyNQkfIlhiKKY011FdfhQvZ/7eMWqrNPjdHzaXYSx/lx2jX4AoRcwYv29JVBzRQ7pJGg1fuCTg5ARdb/4Iw/WFAPNu7gBxkGJm0M2w89BLEE/7tKElOMUCXsBRsQEQwbPPEeO0T58nAKvn8MNixVefGXpB0WuQAsdsgXTuNGDFtj46f1hWROFjrKAsJi+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(2906002)(478600001)(19627235002)(6636002)(26005)(316002)(110136005)(54906003)(5660300002)(8936002)(36756003)(86362001)(2616005)(41300700001)(70586007)(70206006)(8676002)(4326008)(81166007)(83380400001)(40480700001)(82740400003)(336012)(1076003)(186003)(16526019)(6666004)(47076005)(426003)(7696005)(356005)(36860700001)(40460700003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2022 10:16:02.8002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 676d4563-ab99-4deb-95d5-08da575cdfcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3883
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Redundant if-else cases for repeater and non-repeater checks

[How]
Without changing the core logic, rearranged the code by removing
redundant checks

Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4027f439a5a4..e3254ac05191 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -907,25 +907,17 @@ enum dc_status dp_get_lane_status_and_lane_adjust(
 	ln_align->raw = dpcd_buf[2];
 
 	if (is_repeater(link, offset)) {
+
 		DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
 				" 0x%X Lane01Status = %x\n 0x%X Lane23Status = %x\n ",
 			__func__,
 			offset,
 			lane01_status_address, dpcd_buf[0],
 			lane01_status_address + 1, dpcd_buf[1]);
-	} else {
-		DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X Lane01Status = %x\n 0x%X Lane23Status = %x\n ",
-			__func__,
-			lane01_status_address, dpcd_buf[0],
-			lane01_status_address + 1, dpcd_buf[1]);
-	}
-	lane01_adjust_address = DP_ADJUST_REQUEST_LANE0_1;
 
-	if (is_repeater(link, offset))
 		lane01_adjust_address = DP_ADJUST_REQUEST_LANE0_1_PHY_REPEATER1 +
 				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
 
-	if (is_repeater(link, offset)) {
 		DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
 				" 0x%X Lane01AdjustRequest = %x\n 0x%X Lane23AdjustRequest = %x\n",
 					__func__,
@@ -935,6 +927,14 @@ enum dc_status dp_get_lane_status_and_lane_adjust(
 					lane01_adjust_address + 1,
 					dpcd_buf[lane_adjust_offset + 1]);
 	} else {
+
+		DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X Lane01Status = %x\n 0x%X Lane23Status = %x\n ",
+			__func__,
+			lane01_status_address, dpcd_buf[0],
+			lane01_status_address + 1, dpcd_buf[1]);
+
+		lane01_adjust_address = DP_ADJUST_REQUEST_LANE0_1;
+
 		DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X Lane01AdjustRequest = %x\n 0x%X Lane23AdjustRequest = %x\n",
 			__func__,
 			lane01_adjust_address,
-- 
2.25.1

