Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EA1CDB483
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74EEB10E422;
	Wed, 18 Oct 2023 17:42:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCC510E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhU1PCHun2SyNKdTHG6W60Aa4SgMYaJo3tubhfWGxOgS8jDKmIEvVywTmDbyKHB1oQggovGa10Ia4vNQys/ZxuGlSabHW1hDLGn/BWsmTsLJjwGz+lkcTVtIsCLtrFMcg70BSWl0uBMqV5vZ95fh1f5GY3Sf380iTv2H5FE8QDiXaSGhW0f15+KDfHD4WImsM/ji+WotWxh1G8cvknvaY3+t8X+KWrQPVeRWuRy6fBfke9FN8IS7nlOL/t291JdBPKlul48eZEZUISIu3lFHlLqZiAnPB43l5zS0zlEptYc5EGLrWiswkIATBEre8DFPkSzj4G8T0CvPKPHa17r3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohlRxjDjiv4yVC/hLmmze7jmOUxZsfbEF0qljsyYHQ4=;
 b=N4nO/7bmidkCM1WI1k49vxfqk9NpU+fpUXRXCdYJW4xwf5Hk6AsLuNn6TcN6lqWM1pIt+wKc4MwNU28pSLylIIU8ijUW7OudgK0aDjBukbm5m5kb/o+VnBJ55Sg8XsXPlKaxj96giEggrD+fSLseIi3nA5Z/RjHrDOFLYqmPkabROm9ST8pxcNWQbr4oBLYzH6+zx5U5U5KHuOmEenC+Lz4JwFVZ5Ebkhja4BkNyT+C67NfnYiFl6Z/bSksFtdT+/0uREQdoJVvYLOc0/s1OwKtLZl7n0yggf24aeB7FCVwLR3IORssBXNYkSTvtJTKqVnn1t4jwbMPs107pNNl3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohlRxjDjiv4yVC/hLmmze7jmOUxZsfbEF0qljsyYHQ4=;
 b=OoaYcJSJ5v1JIVvJBfcIoSbeF0Ara8gmlqg0CH1HEeS85Lduk82tBYTmviARMHf5seGsG24ibJ39TGCVyxAlkFiR+SXsvAoF/nGNs+dCjr0RrcPl7Ei9ufjRV+QbDvbCJmqR+gmfl+pMZRlGcZsb2zlSzfnLBIwoLlaDLWlHWt4=
Received: from DM6PR02CA0093.namprd02.prod.outlook.com (2603:10b6:5:1f4::34)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 17:42:36 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::dc) by DM6PR02CA0093.outlook.office365.com
 (2603:10b6:5:1f4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 17:42:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:31 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:42:30 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/26] drm/amd/display: Fix HDMI framepack 3D test issue
Date: Wed, 18 Oct 2023 13:41:19 -0400
Message-ID: <20231018174133.1613439-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 990732cc-7388-45d9-6615-08dbd0019dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYiBxSmeKzMFsRFqrAGwFyr1IGMq9G2tA3NUr9zIDEgTA9KLRl+Or1EaccEp3YFz2sZ2jo1I1mIi5GYw+UGJrwoZjg4n9fSCvbbJjH65x9YyujaqXTjkMgEmASh+Mbyt4fbleTvgTZdBxat7L8oRQYKINTi4SIOWwaXlJX4T3s4IvmycrR08bbzFGzAYy4bwempWjNcbV5ploeJ1mNTkkagvEiNuCdUWTk6yMRbaCfXnYqDZModm+d2QthxdTrek6xghk2n2jM7ditzbXgPGYJQR1k3dcRaEv3I1HeVfIc1LY3Ul1BbqMlQZSHSRIOR5nmxkmyOfpjKUXG7QAHE/n2s9rkZwrbOLsxzVWINik7MzDglAsKOz6+QUtinYDos4UeMHKbq0d8O7ZpCaUQGPs0G7cTT0366Px3e2aTF05VwXo7ftkFLKCF0sXOjuV5wj2Da6HNHhV7bHvC0qMPIJeT0fMcymUSqw8b8HMM1V24spKmsx7LaYQ8x3nLG2WPFnUCOQBE1lsg3THBsfshZoMtGkX1RHAyX8q+NbOCV85G9tWnYRTL5zIL57kCeuaPq0J5JXgrJbjlAjJyGd9MVct0s9mOZ8i4ZYdhQJPT0wwJZ/qXxDvmclc9HwupUznEbCvIUDF751y7A5IgbYn7ALqYanaGjZ4PKywvd/plciF65VDWtVefG8wgPFKnngKOdlK4u8iwmVDblhACxg2pr++1UV1XYUMknltlkl09EpBKWae26Gj3fAxMK1S5axdDfcwFYd6MqP5mhsEsCvRhesVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(36756003)(40480700001)(40460700003)(26005)(70586007)(6916009)(54906003)(70206006)(86362001)(81166007)(356005)(36860700001)(83380400001)(336012)(6666004)(7696005)(2616005)(1076003)(426003)(8936002)(82740400003)(2906002)(478600001)(47076005)(8676002)(316002)(5660300002)(2876002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:36.3566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990732cc-7388-45d9-6615-08dbd0019dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Sung Joon Kim <sungkim@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Bandwidth validation failure on framepack tests.
Need to double pixel clock when 3D format is
framepack. Also for HDMI displays, we need to
keep the ITC flag to 1 by default.

[how]
Double the pixel clock when using framepack 3D format.
Set hdmi ITC bit to 1.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c             | 2 +-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 97f402123fbb..f0e437f8ea3f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4228,7 +4228,7 @@ static void set_avi_info_frame(
 	switch (stream->content_type) {
 	case DISPLAY_CONTENT_TYPE_NO_DATA:
 		hdmi_info.bits.CN0_CN1 = 0;
-		hdmi_info.bits.ITC = 0;
+		hdmi_info.bits.ITC = 1;
 		break;
 	case DISPLAY_CONTENT_TYPE_GRAPHICS:
 		hdmi_info.bits.CN0_CN1 = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index e5ccd2887c94..adf835279d6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -569,6 +569,8 @@ static void populate_dml_timing_cfg_from_stream_state(struct dml_timing_cfg_st *
 	out->RefreshRate[location] = ((in->timing.pix_clk_100hz * 100) / in->timing.h_total) / in->timing.v_total;
 	out->VFrontPorch[location] = in->timing.v_front_porch;
 	out->PixelClock[location] = in->timing.pix_clk_100hz / 10000.00;
+	if (in->timing.timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
+		out->PixelClock[location] *= 2;
 	out->HTotal[location] = in->timing.h_total;
 	out->VTotal[location] = in->timing.v_total;
 	out->Interlace[location] = in->timing.flags.INTERLACE;
-- 
2.34.1

