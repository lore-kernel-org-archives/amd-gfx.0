Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB017C001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6027B10E4B2;
	Wed,  2 Aug 2023 06:52:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB1710E4B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9lbti4EXFSlC2o1mPJeTdzwQOZDen5wdK06+5V+Le1OhnGytkRafT1ePmmI3lV4lII93NQFgG7afVd2xAMj27SchMqAtvnomDDxCwzbgpZTGTUbtVRVPsr+GVlMGaU+z/L1PputxiaXplFYidGU/Kx7w17kAm5SDd6/ql7zcDDzTfE0F67vx6STmbxfIO5ir+jdkn4ng0Mskh4Xj6Sl7Yn429K8MIAti22Fkay+edoptSUoGrofi9WqNfNhj9R1FYW8pvtMO/2gywZAAzywpCz6dVVL4/JgWbJcuAczJg+NIAMebSNh0HxJjYmIcvGf00AQUGmdpuj0MLyWqEFk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mKOQa2rxM93bqP/eruS7b3PBVirDPdxiPoDUV335lE=;
 b=atK1cAzlAR/T1JkMB7AXsEu7M2v1VvHAAxSeQ/NopNdDroM5RIaRs4oARV0ZdmIOc+R9D9Emx6BFYgzhrN8akQSiwkx9OP7EFnrkJri4F80dvgR/4L7tdXwXaLjtOsy/rGGzb5vqZB2EyETL7CxmjV/9IOfuN+cUR+vby3hRQXI4Na80f/MttTcPg/q1zvbTruiNOa3cudmXmxDPkbyn8TJ89UJdejw8BI1AfeKQXnvpy6gDK8+iJ9gHJ1dPtjaa7IcsuNdgWvrwAuu6MDP4x4qagwgfwLKg7hOTytEPm09A6r/fINA+EPMUCtxjB1iMZYaxViZ8Sq86lBTO65JTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mKOQa2rxM93bqP/eruS7b3PBVirDPdxiPoDUV335lE=;
 b=Q/OyiOlNT9+o7zINuOSizkAy0289lgOeOgoNfH6iIthGInnpS7dFYcCluRA3Wu8MRJtueHWoYndvbhwe2khvCJWedHW84RkwyAzKFBY+7w3e1zYF4euXX8OOg8z7+A22uQLxHAlHvYEkViuWgqVLH/g21JJy7ywIXv1fudg/YgE=
Received: from MW4PR03CA0179.namprd03.prod.outlook.com (2603:10b6:303:8d::34)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:52:47 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::c) by MW4PR03CA0179.outlook.office365.com
 (2603:10b6:303:8d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:52:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:45 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:42 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/22] drm/amd/display: adjust visual confirm dpp height
 offset to be 1/240 of v addressable
Date: Wed, 2 Aug 2023 14:51:21 +0800
Message-ID: <20230802065132.3129932-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 6111245f-d129-4a4b-91f2-08db9325146f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EW3wzttLehpQSP1nBcMoZCZLfmDXRo9wBA6QNH0IttvsJR4R1S6M1MzuaJAfp7Z/mVeGOSZEEVsn1HQFD5vFD2WdIq3ih2nmcM0WwRUpJbLZZWCrObQOt9zeKryMgeNwdDVzBTXu2BVmfjq2unTWIscc9tiqBKQd72ZMARpcqkOP3/UxPTLMgDRY7V+bz3e/BmFe51XX2RuYd2Lp9DGFOIcIx812A1QxWDRDeDVb286fvRB9w3ucfN+88Bm8GMbPPI00HDTtnFm2AzC/SNMmVbwmtJDR10g/fHTZNgiodSHDbTvn74TlRJ+Ge6HqpOnnFduZ1ZkNfNgU4lHqikAFUnxEqNdA6qjavCD4yxEELNaqk/nWjh5KlGAfGsCLNeKGbI6KTdq+9CusHo55ijbOCeUZ5/Fu0V1LasukvlaXFP8g4PFpDQ7vpYk4N3UXy9Dnr50jaYuvkTFLOz27kkZcVXQ5J2ZA+39PampBW6qJHdAiD7CBj1IjCUPpummVuV9gA6WD4lDlwmft3gdyN7OKLcCq2z+zjhqduM8l7y+qrHFrqkJNK3vyqUy6tho/QmMxLUTb0JmvNbFUEBCWG03GUmPMrkhuOnLQ1CxilZg+FWY3vpg+/nHIpxu6tRcH7tgenS0Ow7eyBknoPoXyhmI+FM7wOXamnNaXz/unMgmPyKtTtlx4jRKcwbEkujNuxKEbkxcwId/dIQRcYiIF9NA3VGykQx8icu/lp1N66ObPcrrFW/xx7LfY40QOc0liAgqryODGqfr8OpmNvW/13HwiLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(40460700003)(70586007)(70206006)(2906002)(426003)(2616005)(81166007)(82740400003)(356005)(336012)(186003)(1076003)(26005)(83380400001)(47076005)(36860700001)(54906003)(40480700001)(86362001)(36756003)(478600001)(6666004)(7696005)(41300700001)(8936002)(8676002)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:46.7423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6111245f-d129-4a4b-91f2-08db9325146f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
For timing with large v addressable visual confirm is just too small. It is difficult
to tell visually which DPP we are using. On the other hand with timing with small
v addressable visual confirm is too large and covers the UI area.

[how]
We calculate visual confirm dpp height offset based on v addressable so it stays
relatively the same height i.e. 1/240 verticle portion of the screen.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 43273e54147b..218fe2c401e1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -72,7 +72,12 @@
 #define VISUAL_CONFIRM_BASE_DEFAULT 3
 #define VISUAL_CONFIRM_BASE_MIN 1
 #define VISUAL_CONFIRM_BASE_MAX 10
-#define VISUAL_CONFIRM_DPP_OFFSET 3
+/* we choose 240 because it is a common denominator of common v addressable
+ * such as 2160, 1440, 1200, 960. So we take 1/240 portion of v addressable as
+ * the visual confirm dpp offset height. So visual confirm height can stay
+ * relatively the same independent from timing used.
+ */
+#define VISUAL_CONFIRM_DPP_OFFSET_DENO 240
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1002,7 +1007,8 @@ static void adjust_recout_for_visual_confirm(struct rect *recout,
 	if (dc->debug.visual_confirm == VISUAL_CONFIRM_DISABLE)
 		return;
 
-	dpp_offset = pipe_ctx->plane_res.dpp->inst * VISUAL_CONFIRM_DPP_OFFSET;
+	dpp_offset = pipe_ctx->stream->timing.v_addressable / VISUAL_CONFIRM_DPP_OFFSET_DENO;
+	dpp_offset *= pipe_ctx->plane_res.dpp->inst;
 
 	if ((dc->debug.visual_confirm_rect_height >= VISUAL_CONFIRM_BASE_MIN) &&
 			dc->debug.visual_confirm_rect_height <= VISUAL_CONFIRM_BASE_MAX)
-- 
2.25.1

