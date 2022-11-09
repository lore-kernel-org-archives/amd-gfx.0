Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE04C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D5110E588;
	Wed,  9 Nov 2022 06:18:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3253210E58F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+dnCWKuV4gXAZXYTzmErkF8jwBT176B0kPnokBlSYIWHknu5LYNDW5xNReMpEDBiGJQGoHYlxXDt5TCGFZrMleumgvGLOwzPB4qH/l7vdgcD2FlgJTi6ATlNvAzN1/yydgNzhk/6WPqk6Fh1UQrysF+CHOCxVFpbPR3AXDVMubWxj4gfVF6js3XO8kSJM6ux95OxzNAp/+zuomqPiJmWiLEUmTynRMN6kHm7kObTRPyfgj+a25jRME33P1JZEcsKQROedKDuTUESWPxjS/w0D+VkaRoZ64i/rJJRNmf0girdf27to8WueHxap+cMHOMLrTw65Gu4dBqhUsdirudfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSeIvQR1qFz9y7T164tBa+XO4MTRgJi/X3XqqCfP+mw=;
 b=F0z1b9YhIgAP43zuiiktp2+0AshbhDm8ixZsEbwJK4bfrko40jsZ3KHbdY0OJvsFAZAooFuZavboUpuyZRgmpeimGtQsqoGBoe5UyXWSmwTKpLVfpMrkigLdFGJDXIuxp9jo6HMNwGSXh2KDJZMAOeqPpqBfstpwcM5/AzVajVoxmVkw35Ubk1hwW6WuEyJGTHDIvH+5860oTWV7af53EvVjVhpZ+6vUhzEUL4ChhyPubyL/s3ScxW6afvPvQ0/yo1lNta4rYYKeUUnWJaqhHK5SipcMT1VYBhFMsIRwYHXcNjWUL1/jy1Y0/fOon/9WGa4t8OkCp6dvTqgZJt4nNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSeIvQR1qFz9y7T164tBa+XO4MTRgJi/X3XqqCfP+mw=;
 b=URsSekC2/osaEAyuEs6/dHe7ZyYOp7hwVOXp5ohLop2LqkKRdcpQQrOeVz3D34+RY3/GvCQv313VHFQ1PX9CUcKze8AFk8Mix3Ad/pM0x2VaXvDxotNc4oXv1IAw4sCgzlbBJihmMG7Lwi9i/PC7r+GVCxjZHB7YFNA8i79ILGs=
Received: from MW4PR03CA0056.namprd03.prod.outlook.com (2603:10b6:303:8e::31)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:18:20 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::20) by MW4PR03CA0056.outlook.office365.com
 (2603:10b6:303:8e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25 via Frontend
 Transport; Wed, 9 Nov 2022 06:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:18:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:18:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:18:18 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:18:11 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/29] drm/amd/display: Adjust DP 8b10b LT exit behavior
Date: Wed, 9 Nov 2022 14:13:17 +0800
Message-ID: <20221109061319.2870943-28-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|MN2PR12MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c60855-7db0-4fe7-5087-08dac21a32c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2r9acQ+oCnCxBc+Q/YcPknB88aOMy+btlReoIXhtgJ8iLxNOCiNAazbYJPr8paRo89MqGcHwIs/1ZMNKFudYm4Gdbc+LBEWlO5USVK+etl+bwJgZ9IQc61/7iYY008tS7JcZsjLcMSOmDiUaVcCLAoPFtcJC4kV0QMn0aaZGEpjRPKrfUgHTj92WbPJHhj0W1+sZR/nbJxZVwlA9FvPUR72GYwsNcp5cKyetdwwUhWUJCcAaK4opiDXTkoMAghkTIm39drt03v6aSG7r1Szd7+i6PrJQF4trxc6ThkV8j74K+LLMe5ZR3JlmzP29UIWxxk/MxHeDRexfkqmzX4APatc9aEs93JLB2G66nDGDzqmUm7xDRiDksh1A/jrwxiw9cpVnLtwGSthYbHJKMKoLzGUXWWO816OAm/xZKtNda9TLVcSSkbBVyAR0Az8Q8gro9e4EXa97/J0dVlRFoOxqznghaGP/HbE4NJFIyDmWAodKm8dAVcZzpPNuJuc9cQYthB+FJpTQYx+0Bnx12FAVutSUbKQfKaJlWl+4hIbxaGw0ai23rNEl62ZIEWGExdQ8xwsWSTJIIOruG/vv65vaClBLBaVpn/p0dFH3Cm5iWRJM+fheOWw5VdnlI79Nqn9/010l+J+p6kzIg/aoXHcA7mPJ2DbpIigsbuheYAhlSA8xmwkQ89jsFuAsQ92pbz7ezU/Uik03nAgL3N3RqK+TLjAzBwrY0icOjYn1hkl4YQ6S/fiXV0OBGV1w9NREV9Tkp//FxYM8fuZiwSE8ov6Br5+EV1VE20785gtoAM6n0rt06jm77djWjtbBkLn0cCy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(70586007)(70206006)(82740400003)(26005)(8676002)(4326008)(316002)(7696005)(40480700001)(47076005)(2906002)(426003)(36860700001)(336012)(83380400001)(40460700003)(41300700001)(86362001)(5660300002)(186003)(1076003)(2616005)(8936002)(36756003)(82310400005)(478600001)(356005)(81166007)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:18:20.1095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c60855-7db0-4fe7-5087-08dac21a32c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Polling SINK_STATUS DPCD can cause some non-DP2.0 LTTPR hubs to hang and
no longer respond to AUX.

[How]
As a workaround for the problem hubs, and also to more closely match
DP spec 8b10b behavior, don't poll for intra-hop AUX reply indication
on 8b10b-encoded links.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index b772d7f2301c..dedd1246ce58 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1912,7 +1912,7 @@ enum dc_status dpcd_configure_lttpr_mode(struct dc_link *link, struct link_train
 	return status;
 }
 
-static void dpcd_exit_training_mode(struct dc_link *link)
+static void dpcd_exit_training_mode(struct dc_link *link, enum dp_link_encoding encoding)
 {
 	uint8_t sink_status = 0;
 	uint8_t i;
@@ -1920,12 +1920,14 @@ static void dpcd_exit_training_mode(struct dc_link *link)
 	/* clear training pattern set */
 	dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
 
-	/* poll for intra-hop disable */
-	for (i = 0; i < 10; i++) {
-		if ((core_link_read_dpcd(link, DP_SINK_STATUS, &sink_status, 1) == DC_OK) &&
-				(sink_status & DP_INTRA_HOP_AUX_REPLY_INDICATION) == 0)
-			break;
-		udelay(1000);
+	if (encoding == DP_128b_132b_ENCODING) {
+		/* poll for intra-hop disable */
+		for (i = 0; i < 10; i++) {
+			if ((core_link_read_dpcd(link, DP_SINK_STATUS, &sink_status, 1) == DC_OK) &&
+					(sink_status & DP_INTRA_HOP_AUX_REPLY_INDICATION) == 0)
+				break;
+			udelay(1000);
+		}
 	}
 }
 
@@ -2649,7 +2651,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&lt_settings);
 
 	/* reset previous training states */
-	dpcd_exit_training_mode(link);
+	dpcd_exit_training_mode(link, encoding);
 
 	/* configure link prior to entering training mode */
 	dpcd_configure_lttpr_mode(link, &lt_settings);
@@ -2670,7 +2672,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 		ASSERT(0);
 
 	/* exit training mode */
-	dpcd_exit_training_mode(link);
+	dpcd_exit_training_mode(link, encoding);
 
 	/* switch to video idle */
 	if ((status == LINK_TRAINING_SUCCESS) || !skip_video_pattern)
-- 
2.25.1

