Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF233C77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 20:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED23110EC46;
	Thu, 13 Apr 2023 20:21:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4ED110EC27
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 20:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI4aFdx0zgJM0JAIDejYuyXcLzZUuWZuOijVLsRjDLIOu5zAhPV09clXD0ZzBbwVgzHpJfucczAHBjuQVuXBkMWF0ps0CSRXISCYqU5cd4ElAJIiby4LFWWIWU13lAhmoyqTT70e2h2iINgvf3WUMCxzQfVirRSjD64bPerhONJt5lXrWQMgGq0V9+j6GPnTqfanP3TkIo9VAxzKYDNIElnpFHWWIP025W35L6PK6UpkJc2Np9K3BLdh0Vh0usIx9DRUIORmhEs+lrXdC3FMPLzoHw1kYVKcyjPyWoL+9iaTfA9kYmSKDkaSCS93zgNhK+myHTUbRigLD8nqjCjMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+MYr2OV64ThDxk8UGHrqUc6Pa82kZHNsNRouYHsSOA=;
 b=MzDxqSewXfanfYYoAB9q68+tos3yjnuBN2V/Ymlpo5JnpSzDwqj0vNcaEbTe/31YSTZq8nt91+Qac8A70lTWF3hqFUhtydnN2s6G90GG/Bau1Z+56z31OyXP3fvSNMl2/ookJwARyACcJrY+6mDzGAYpLNaDV50Hw1Fd1y5/h0l3z+bVkwyEyfLBrA9aFNwpQt8YjMh5jYQgVaIu2TNcrcY5mQBEIRndsCxTzk0n2RRj11JOkiKDe4uuZvYKQx+vOt0vnSVOJeftfG/iTkQrepbXiWY2z5zkOhnAW+iKfXsrE/7E2PbmNP06ZLcOsLhz7I1V9jfP16c1oWSlYEeHXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+MYr2OV64ThDxk8UGHrqUc6Pa82kZHNsNRouYHsSOA=;
 b=obRZTQVdn4B5N5DAle33dpS5k+0dYMeVrtOwLBrRh3rquw8Txbpc/nJgIJbakbzcFY2TUjfVlVaPIFhXsGdUhW/wOY0167aqvNP4Hvxc77FjXVlALNzJjR3g5cZdBtxSFyUErjspg0fL/+1TJQBbdC3Re6SWSIKNUrD5Xp0mg0c=
Received: from DM6PR05CA0047.namprd05.prod.outlook.com (2603:10b6:5:335::16)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 20:21:02 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::a) by DM6PR05CA0047.outlook.office365.com
 (2603:10b6:5:335::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4 via Frontend
 Transport; Thu, 13 Apr 2023 20:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Thu, 13 Apr 2023 20:21:02 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 15:21:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH v2] drm/amd/display: Add logging when DP link training Channel
 EQ is Successful
Date: Fri, 14 Apr 2023 01:50:45 +0530
Message-ID: <20230413202045.2378151-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 93938e10-0281-4260-2015-08db3c5c9a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xQ0QUwThlgF/lq8iS8KEyN0QEUEnKDNSl75myeip2Sp1H7lvOWtXLYvnAnW7aZpfCGVIj48qD69reKLC/56MBd43Y3SHElPgAE331UgshEZbVVM8hZon96kkRZqP5cckBqam/bT9NMIMZT9UoUtAhwLtv7dB8nTq30bmizOE6XGHWwSWB+kFIz9wkrXth5Um7NTDpwTVsSvJTA07+EprdFCaQRCetEeW45Le3jsBG2CpBaTVUXjSjEQRl4IDMEX/WPOrZ/a/9/Qw08LGaga8W+6vXVFbjm8wyQf6PKqGxY1fikBvZ3Tw/CXzTWWyUOjqDmG5h3saoZGT2gJqy5XoKzfCXtFlcVko6I5z5vBeYHBR9pDvIpCHLov69DW8CLZRNHSS5dujrtLJzoQLMEziKW7fgsvEel8baoUBUcoZiQ9xbZPC3rO5bpcqVVZk+8Z0RCfAq8tERDurNNKbCHX4V1ASFiqeawAWfeIYfLlTwJSh91L1C031iXNXyvnMI5S/RoFWp69j6/V06Yfh4+anxicluu6OopQU0kgwmLjU2MhSH5FsXhC8HF5y7TZxuNx/i0xEl4AXVtK8AsYR/nE2TKhxXDo1abiU/jNTc1f3XGIKxWfk2UFCqZTr+J+4/0OccZSmx6vWsxYMbFyetImhJfCVUeEVmG4FUacBpk6VVYJl//52zFQbhPBXSFjP78qFJ9Ca9q29iH20ZTcaAgUJ+vko51HOGz2rCKSs+8i2qQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(44832011)(5660300002)(8936002)(8676002)(36756003)(82310400005)(86362001)(40480700001)(6666004)(7696005)(316002)(54906003)(6636002)(110136005)(2616005)(36860700001)(47076005)(83380400001)(336012)(426003)(186003)(1076003)(26005)(16526019)(70206006)(70586007)(4326008)(82740400003)(41300700001)(356005)(478600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 20:21:02.5024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93938e10-0281-4260-2015-08db3c5c9a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Log when Channel Equalization is successful,
and DP link training completed.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:

 - For consistency of the printed messages, dropped  %s for both the
   lines (Aurabindo)
 - For 128b/132b, moved the statements after EQ interlane alignment
   is done.

 .../display/dc/link/protocols/link_dp_training_128b_132b.c   | 2 ++
 .../amd/display/dc/link/protocols/link_dp_training_8b_10b.c  | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
index 23d380f09a21..f7d62b79008f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
@@ -136,6 +136,8 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 			result = LINK_TRAINING_ABORT;
 		} else if (dpcd_lane_status_updated.bits.EQ_INTERLANE_ALIGN_DONE_128b_132b) {
 			/* pass */
+			DC_LOG_HW_LINK_TRAINING("Channel EQ done.\n");
+			DC_LOG_HW_LINK_TRAINING("DP 128b/132b Link Training successful\n");
 			break;
 		} else if (wait_time >= lt_settings->eq_wait_time_limit) {
 			result = DP_128b_132b_CHANNEL_EQ_DONE_TIMEOUT;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 14b98e096d39..e10b2db87001 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -337,8 +337,11 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 		/* 6. check CHEQ done*/
 		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
 				dp_is_symbol_locked(lane_count, dpcd_lane_status) &&
-				dp_is_interlane_aligned(dpcd_lane_status_updated))
+				dp_is_interlane_aligned(dpcd_lane_status_updated)) {
+			DC_LOG_HW_LINK_TRAINING("Channel EQ done.\n");
+			DC_LOG_HW_LINK_TRAINING("DP 8b/10b Link Training successful\n");
 			return LINK_TRAINING_SUCCESS;
+		}
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-- 
2.25.1

