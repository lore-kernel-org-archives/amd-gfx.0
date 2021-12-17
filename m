Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC03C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 19:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4DE10ECD7;
	Fri, 17 Dec 2021 19:25:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EDEE10F08A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 19:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL8ReeEDostRtGZ5aWycruxsIpMmFoXGFgMmEOX3S2i9wYDwoxc53m1feKIhI526LC3Fr+3MI/eclseb3eqw8nRK60Wt4mD7QKYoh60Zt+CdbWEOIfIeIa2LcCDql5bVgsSGbdJCj+0LjQVotDr16Syvix/14nnzWnK2iXhJ48y+ODJtz9DpKgctv8qyXPPek5dR4a+cdQpAavI9+mQ617k/XBKG60RZdx7/wWiG3QsQLen3zmQLHzBweFwO/kAewUOrKnyOexNEf+ksOmc/7R2p+XzKJ6NiWt0m8NNj3BmYpBy5+x78sxHzsA1LQEkhR6GG9g86z7kyHtQz1oqPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNyQEJX9BtWwti1l8vV3004bq+5dohCzT/PSjakIhkU=;
 b=QWty+NyzR3NhpSov5dmehmpPt2NdLd5vGVU940K/3wd84feD4Da7gHp8TBJlHkn0hd8OwxpEDeOg49moRkM3xIQg8DQ5gXMEnYMT0Y7BpBrjZRapk0aiNSKMazEI+qdOHM/iqgUqLv42vK8s3BBtT0iZfIjZZ6YyaqUJFylDcjeFf5CqKwNXF8PIfvLefUGGztymuLJ7frGoKCP8BfLZCMlYjikBceznoQN4GBCu0MywOANw9X1xV7wfuoV3lcRLAw/S6y5riYOCT0ijidScGVq8ZTxiTY+DGKua86tcRt3nBw5b0q5JbHXc/EjMvXlbLe+2MlC/Lewk8mxONVTGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNyQEJX9BtWwti1l8vV3004bq+5dohCzT/PSjakIhkU=;
 b=lQtnjUkAwybnMM+yeSj2JCyQhfsizQ9LJXfmxXiKK4s/39A0xeV1aPIdN0raskeqT3o0vFJu4uVYSMuWydcGVeXVly5ynjHLsq7J4IcJjfThpROWut11sSq5ZFH0ojU85PsgwCHfpypTvrH5F1dP62V5wBT7INgkjnb4eSb7Ujw=
Received: from BN9PR03CA0229.namprd03.prod.outlook.com (2603:10b6:408:f8::24)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 19:25:11 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::a7) by BN9PR03CA0229.outlook.office365.com
 (2603:10b6:408:f8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Fri, 17 Dec 2021 19:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 19:25:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 13:25:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 13:25:11 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Dec 2021 13:25:10 -0600
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix USB4 null pointer dereference in
 update_psp_stream_config
Date: Fri, 17 Dec 2021 14:25:02 -0500
Message-ID: <20211217192502.104068-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69a203f9-6037-42ee-398d-08d9c192f1d8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4371:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB43716739CFA257C79344DFCCEC789@DM6PR12MB4371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbUo/7YrBqMCRGIRU5to1cfFs8dr0rd2iUVSiMX6TtQSe/N3kv/iGM2kbn3q96DC4D4r3w+y600cpQjVn3Hci4ha+0phzVPP0SjaVIIPlocLzP+JtnVk72raaU8gXdJoX3nyAcFTTOgpZhvJrfMfiGH3XDdEHgNNqclyHe2p7Ir8pkCnHUV7P8qGQT6QBsdNdg7CW0QzDgzvMBcRxCdeTplNcifXeiu1rFwB5lZOHrmZvGwUsDhcC03849GgBKSUZf29TiaU1T2jHnOHOfxa+2tTPkvPdhO6I2DoE9yNAoES1iq1aI8dNDmXGYP7nFaA1EzJwXyLsXXsqR3K/I57L5i/ilBGsY2Hk240/rQ++5BUqX5szspnKR7dtbeigdC3PuebS2/MulGZJU1u5Br1htcfIUseIsDP7OSc6pNDwkKKtY/tPRjEQu4bO1JmTMIsa2P2ffcRDhgZlSSFfSqB+aEDON+o7usEBvrdJsoSgv/+L0PsbutOihzDW9lemdooWBmdTs11ugHf2TFxrxiY9W8lW2opKmkOav3wtzzuqTXi7BdsKMOnbyygzSSn10AoLBXGaLYqwCDyWp/2XyFQ1H+O6+j262zoHTosE+WcHFxHcqY6qSKrkDYnhFmpSaYksfGnnhHOB/7sg1h04iE+Wpi4YbEQ4nWNecuyX6PuYm0D11uGp7c6YNL4/yQgj4HAmmlfahq1Nn7/pPOEC6w/RJEHN3Y7tSM0yxyebvweJ3FZxPggYPE/L97he7FHltOv6Du9o6mPAPdc8H+2DCIpYbBHj1STWtrYi8+xhz47BjE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(6666004)(8936002)(70586007)(40460700001)(1076003)(36860700001)(83380400001)(70206006)(2616005)(356005)(508600001)(82310400004)(15650500001)(47076005)(4326008)(36756003)(5660300002)(54906003)(6916009)(8676002)(336012)(426003)(26005)(44832011)(316002)(2906002)(81166007)(86362001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 19:25:11.6032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a203f9-6037-42ee-398d-08d9c192f1d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
A porting error on a previous patch left the block of code that
causes the crash from a NULL pointer dereference.

More specifically, we try to access link_enc before it's assigned in
the USB4 case in the following assignment:

config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;

[How]
That assignment occurs later depending on the ASIC version. It's only
needed on DCN31+ and only after link_enc is already assigned.

Fixes: 35b6fe499be7 ("drm/amd/display: fix a crash on USB4 over C20 PHY")
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3d75f56a939c..857941d83f1f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4009,12 +4009,9 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 		config.dig_be = pipe_ctx->stream->link->link_enc_hw_inst;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		config.stream_enc_idx = pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA;
-		
+
 		if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY ||
 				pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
-			link_enc = pipe_ctx->stream->link->link_enc;
-			config.dio_output_type = pipe_ctx->stream->link->ep_type;
-			config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 			if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY)
 				link_enc = pipe_ctx->stream->link->link_enc;
 			else if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
-- 
2.25.1

