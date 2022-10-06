Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896ABC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92FB10E8C2;
	Thu,  6 Oct 2022 21:28:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F321E10E8B8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lqs31STrVtusvCYqqTfbjAW+/j/2hZQFFm5oztmSGnwC3FBF+j6/T/I4fJTx0uoTPoO9wQh/p1WhGB26z7Rdr4f1OZfcF7nyOk/MttCAYfBkAjM8/u+78MrZJ3MU6BtsFK7dDO5rfazfUCAy3z1fBsFdlbpn+yrxQw/+LIxu/Qf1LqinjWWBDVg7nIiUMrLWDOYzSLuZOcJwvutbAxYx4gRZcz7LQOVwjjT08acqfxJe2E8zgj0TLCWnnjYf8HcB6zWwSwIi0mlvZOSvELCNdzKouPVuC6ZFIlVX4C71m9kALrbcNOnIis8IoaHMM5F8RO10/28l4j4bHRnKlbuXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfgUpaXLUQvZdVRF8IOBtYeG9fJmZQJ2gjSTdLLzNwY=;
 b=kNTLHTrgQfNmUKbSZHgX63OEwM/4+xm+QBYBejUv6SCM2QEWaA/RrdYSgwHOt6cppuU5Q9oQs5EStoz3TZUySsRzUFyoww4dO/7WrDDf/Lz/5HZJttg3ryettRzaIZriDr7Q3RoEHfNlvBhjyCJFOiMRLJf9nrOFNTziIxXo+qfod6iA8KKf5ypqZGCSEnB85mhM0p9U190O+0xna2jmPB1WYKDcaTjL2XLiellYHfASOUmyVF3Tt++PMQ1NTeyX9kbmGN4nb8rLmFVRe81SUIgxx6+nzOg4E1fZb5qlOqYXSlDQOOWbFn0lDyJXCL9FgYAlHRZ/wS5KtRsxPpcRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfgUpaXLUQvZdVRF8IOBtYeG9fJmZQJ2gjSTdLLzNwY=;
 b=lqHEZDaTUhMA8fUfDuwsl+0lueqFbAepXxdn/u0gpvzUvzE8w9nUIsyDnOz/kedB0XY5fAMBRthob14yGfolkxe7WFQVApJ6jX8DT4XBHE8ghJGqzzMaxM0XpYvL+rHuQi1KJkWBOaAacqpVcmDeGNPuJCitjknV8fEgM0Bdql4=
Received: from BN9PR03CA0299.namprd03.prod.outlook.com (2603:10b6:408:f5::34)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 21:27:54 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::e4) by BN9PR03CA0299.outlook.office365.com
 (2603:10b6:408:f5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:54 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:48 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/23] drm/amd/display: Clean some DCN32 macros
Date: Thu, 6 Oct 2022 17:26:44 -0400
Message-ID: <20221006212650.561923-18-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f9c87a-b801-4a3f-2948-08daa7e1a149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uycV4IFQaC6wduK6P3k4eBnYKNz/aRG4PDHAa9F4qdon07zaL3CCj/F5JH6ltgN4xub5h4q3ODhx0+L0GJL1QSaaG94F01YYLjjQqgrY2aqrK8m0MWHsGrawlVNkpUl+eTCmgnw/dDqQ3Wjc5wdWV6N9qNuD0Ns7HruxxHl6o6jr34AXpCazE97Yn8jP4QqXYCc+CBBr6QJAxuHs1rdscRo3n+T5Aifx5LyapZlFafTsRu6j5U9DXbbLw3tK+ajUjV1g3Ppg0M4+SitgnDdunKs9Z8uzAqo2GdtY0UVvGw9nP3Q+g92prTrp6+uYnbCO3+Rtry/KoK8vhlKo5NZDOLJ2kyuJaWoG4/gLPbyI2IqZbWicrl/QmilqRtjYhWtx6mm4YJDIiOpaL5IEp/bVhC2yTGcbokd0J5CA/0KF+r1En2btN8ZCuqA7XngI8HxaSf2FMm82aB+b0WC9r+EzHEMn1oizjIfve2BPahf+DGZ9bncbq4YSFGqS0RvzZ5MwQziqM7XfdaRG/0522pL6Q3YjI1AqG7VSp9arSddsIjco+cpprN9/NLJslaUgUVXChHwtcEA5UTgkIjdz1V34ssYTzFY03juJUEfssRpk+h8QL/QHy/FTnroJ6XDEs05Axy/nAp46MzOvuUgAIHysQUN5kl+o5Yv0N6N/hWGPu9AOaO9rSkzB+nXmnT3w6R1CTIm1iCqPAhyJcHZagSDHbvQ8d2tZtfdKtIWnoJB5KBFTUZGX8V4bNOzzXYSe5i7qQcrkvMal52zPQ3N0Cmtx9+VOqQBAs/IzQub9z9YLOA0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(36860700001)(44832011)(86362001)(356005)(2906002)(5660300002)(1076003)(426003)(186003)(16526019)(336012)(81166007)(2616005)(82740400003)(47076005)(83380400001)(82310400005)(478600001)(316002)(26005)(6666004)(8676002)(4326008)(54906003)(70586007)(6916009)(41300700001)(40480700001)(40460700003)(8936002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:54.0503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f9c87a-b801-4a3f-2948-08daa7e1a149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Some unused macros might mislead developers
during the debug, which can be removed without
any issue. This commit drops some unused references
to SE_COMMON_MASK_SH_LIST_DCN32.

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn32/dcn32_dio_stream_encoder.h   | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
index 20e5f016a45a..ecd041a446d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
@@ -95,7 +95,7 @@
 	SRI(DIG_FIFO_CTRL0, DIG, id)
 
 
-#define SE_COMMON_MASK_SH_LIST_DCN32_BASE(mask_sh)\
+#define SE_COMMON_MASK_SH_LIST_DCN32(mask_sh)\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_ENCODING, mask_sh),\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_COMPONENT_DEPTH, mask_sh),\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_PER_CYCLE_PROCESSING_MODE, mask_sh),\
@@ -247,15 +247,6 @@
 	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, mask_sh),\
 	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
-#define SE_COMMON_MASK_SH_LIST_DCN32(mask_sh)\
-	SE_COMMON_MASK_SH_LIST_DCN32_BASE(mask_sh),\
-	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, mask_sh)
-#else
-#define SE_COMMON_MASK_SH_LIST_DCN32(mask_sh)\
-	SE_COMMON_MASK_SH_LIST_DCN32_BASE(mask_sh)
-#endif
-
 void dcn32_dio_stream_encoder_construct(
 	struct dcn10_stream_encoder *enc1,
 	struct dc_context *ctx,
-- 
2.25.1

