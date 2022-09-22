Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D27C32771
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887C010E9EA;
	Thu, 22 Sep 2022 00:19:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8313F10E9EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBtXJAFv/dn43I07dkEBudKPDIpOX+q+RSRC8aO9Xp8oe/rqfYuehXOJjbJSYAMdKddF4uevTCNISpY1pTG422rJTxl1vl5YfmoR0f74/tJUHTvK7y77R8BJUZACMklrpCtvvTYXdHoRbswy0uC5HOT2nFBeBbS7zlHx9cIZBmaPx1MRjOk7hThiWLMApiPF/WO4LDyMjjtdRSfAxSkYk/3IoKxVUHAFijq614ET2DiXk3JyWRGcS9RDAK7VZYnkixEiWWtTwP0bZA70NDLgkC6n1Zc+zCpgNVj/uj+yTRt3hLBd17wr/8dZwuEODwdbBzg4h5rK5unHlDMA/+WiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoSRgVS/PZ39531SvCMBwWF7krjWfHMbMlL4ZNKq5uM=;
 b=QlzgKc1/X/fWQGnbf2l0jepAA/2YvC1i+dXD7vG3wmum3qwdmkjpROFRdsSQZswqZNhELv8LTXeTjVmvq0LZpidiTbCIgPPeIQtU4hRK709Rt9JcppZt20Qr1MWoG9FG9NrV5Swb2WNXwIzmAyHCRg8E9/W7GFMvR4hQKFp83Btu9DB3uPUFcTe1B0pjoK9XWc893STRwCM6Nyyj/AaVSFsINoodp0i66zkjbkBswAX+h9Mb1ysqWtHqGlpY/XLB7wOStFVwrcuPdomoFfUE8UrQJF1kugHE2/0W7EarAFe/OI/K3GF5gXlv5qqTOBVjOAZFIFi2ymXETYW5AfVmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoSRgVS/PZ39531SvCMBwWF7krjWfHMbMlL4ZNKq5uM=;
 b=D65zdzrPRJfsVYyx3WcC2VlgVYlo9Mqhd7dOG8Cu2771csdDMcZOawqhqyoUNj6PXEeM10LuImx/CUNAlLqXVHa3A3sr+Su0ZfXbRIunomyyLZyTDDY9RHHy2jgQi7O1V0MqoOfKWhmcHMF2ZcXh1BRrys39nsBD3H2BnrMDu/c=
Received: from BN7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:408:34::28)
 by CH0PR12MB5044.namprd12.prod.outlook.com (2603:10b6:610:e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:18:54 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::a2) by BN7PR06CA0051.outlook.office365.com
 (2603:10b6:408:34::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Thu, 22 Sep 2022 00:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:18:54 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:51 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/31] drm/amd/display: Do DIO FIFO enable after DP video
 stream enable
Date: Wed, 21 Sep 2022 20:17:58 -0400
Message-ID: <20220922001821.320255-9-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|CH0PR12MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d68cda-6c4c-403a-fb35-08da9c30087b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESosnnlvCANGa4EEk+EDRRUVwFesXAZmpkY9ZZKATCPgbl7CXT5zvS+qeaItK0JnwlrTGC13p+GXv7R2NgiwnhlNQdGt4uQG523kXOn80hoyl3T9BUZUPC96Y2oXW+5A5wOitCdPpn4bZgEbukx1yeS34Eicq2JL+BdsOA4xDVBJpUYvti8ZEL6qKcAxxPoRIV5oKo+BuIyWmbOf3inKHvyWIUfpMcV4i+pHThOqn7GPgQHmG5UGuR9lwBXM7ub7uAH+N/GhuSZg/rDrfDpIC4QSD+mk/a+3+u7Lt3w3H+eEec6UuKyf7x6yWWmrpCiMLd9ZLVoc0mbTR+1VUC2ktOj1nHzQU1XdKuvDE9lY+lvq5qBq1uSiZeRhktP4Rh9Ycps9Yl50WhK4G7c/W+YYGxk3sx4pT1LAWxVoloIS+Rm/j/2YokYIPq3pNP9smNV+LKZ3m+EzeFMKESPF3hcWSC9k9bvBP51PwqT3CjfH6iR/Ll2lS/Gnape1bV5pPTsteM0K7CnPC7mU4mZIH78bx8Zh1y4vQcOP9fslYI+41ZqaUmegiP2CT8rqf4FwHz0H/mhNvADN501HfC4sfZhRCfs1ijAMEG9ZQTrDJuJDwTxln1okNVf+AONdS2wdC8kger8GI0j22e+iZaBYQDijwScowMc1LR3jC+nQEPVZhYK2o0ObNhfdxfEoQeQfiuIpAW7QVaMOfrb6zT1O7ddRMxhJgVHFte22TrvDTbZttHFfvNgqwuXf1ANhLFpMHk4Te9jFkoyZs/Amq2hD3lexYGokSk0cPm3UsQaOQcj+R2V2afZ55ByOdJ8rvLiWdw4M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(2906002)(70206006)(70586007)(6916009)(8936002)(54906003)(8676002)(36860700001)(81166007)(356005)(316002)(82310400005)(478600001)(5660300002)(4326008)(41300700001)(36756003)(40460700003)(2616005)(336012)(16526019)(426003)(1076003)(83380400001)(186003)(40480700001)(82740400003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:18:54.0271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d68cda-6c4c-403a-fb35-08da9c30087b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5044
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

