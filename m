Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50486C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CB6112BED;
	Mon, 22 Apr 2024 15:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OfGip3Du";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450D5112BED
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/Vs7bRPWbAGHgYJLMtPW5mtrexfrUlo65ddtTUYybWBZbuEOlcs0TSidz2AA1xxWDB7Zu2o8LP1gi1PGKjly/FXhgSxMPOeGDro/Tc2uZfsDN56eRhEYwmHajX2aYKhLbzY/Y62obpIPWzVJn8Jw1jHDg0fImTfkS8bqezUA8RpjJWjn/ZkIJo6f4ym2jHAf+7d3LQWqybR9An59JhU/DN3T33RZa1g+B4Ym95Db4uQWgwBmMP+ea6YxKZ3WKB0u838xYIoyeDVuPdYuooyysCplfdso1NT99N/AJ9O/ImsQSEZ791D4ROR+42DyrWyJNF+kOhjzeiLxdmJ347hkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAL0MYc4lzJ+K9WcTz6jVKsO67XU1QMCSCH+fsR0GA0=;
 b=fClFTsdR5hkROKZ+hnX+7MDmO+9Rt6qEPRLFvG8OSrWKt/Qx/mv/yOpBxpyVZscVF3NmaZhGyskx8m7dy3uOYYrccwaTrz9a2eK6NGRM/yMMHdFHUZUb3JVlqVPCJi6CQkSfbOdvlSbdch1Oft8rqmCTADn1dw/iN6peNEDQDGNeGPBrhDEbLndeDUklIY9TQXMZ80RvQZrSLLu3KaSN5F+PtBWxRGacE+x1vmcmn87728Af9q23rH4togRzFZvmYf/YY3Zd58bOvtSo7CJvVeaBfpHlOWTpF13gDdReSz/jdNaClusdmqTmyqKlDzDa/Xo6jNXq86yt7jc+DKe88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAL0MYc4lzJ+K9WcTz6jVKsO67XU1QMCSCH+fsR0GA0=;
 b=OfGip3DuU6+2mTBiDyx/YWq0HDxd7TiohF3pU0NM8Kzij+I59Rpbyqbs4WrY53RaC5GDU/BQLW/ponhN22Gl2DrD7DSElCSSuSNzYby7tp7fyClgNxOAFRIr5riMmnVy27jO/2oZj2KelqImpGm4QcG1gO0OnRG7Hui63hMsMTA=
Received: from PH7P220CA0110.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::21)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:05 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::98) by PH7P220CA0110.outlook.office365.com
 (2603:10b6:510:32d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:04 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:28:58 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 09/37] drm/amd/display: Code style adjustments
Date: Mon, 22 Apr 2024 11:27:18 -0400
Message-ID: <20240422152817.2765349-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: a81c787e-cfbe-4cf6-19f9-08dc62e0f1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kJHz0v1+4J4PN68nWgJsxqrSsH4LsPO5iPMS7Wx0gfXyYcVntpPHszTdjNJ5?=
 =?us-ascii?Q?1AxAgYSgO1U4hB8aM7VuBbIgxAzbP8aoL9Hg81m/9MTwAxXGnlUShhblhMNj?=
 =?us-ascii?Q?vTEEBTGEqy5nTXbUPGBw60+i7SkKIrz1OT+EwtE9mckVMdFIQTnjv5A2HJJ4?=
 =?us-ascii?Q?1cV2f+Slb1el2hTYHRVxZtn0ikbDM0pIjbTyLclGlP2FtrKHQ6/4TZlVdfFA?=
 =?us-ascii?Q?Jkn54tJDUgrjLCA4K/YDmG7LipR4sI8vCj3nwQA7oTN9PFRdJVB8xxY9rDe6?=
 =?us-ascii?Q?78nRqfQd666DugPU/jCEPMYuHZOG3XdKnc/iVre+ZeVdJermYjt7egbq8KRf?=
 =?us-ascii?Q?2bCdHGAS3xVOL1mJWBwl04L6wEsnltaWfazLEsK6E3LozmGm1Sw5+GfcfACN?=
 =?us-ascii?Q?Fyd75iPazC2XXiJxG5RJnglP5BDoK4DVxk3flZSroh5sAbN26QSjVQ0zZ+Yq?=
 =?us-ascii?Q?r8fFbXgoloqn/OWJ8/D+FDi7D3coymLxvX/CwkiNx601ls2UhYjbt2s9WFNY?=
 =?us-ascii?Q?ZQxs/Ph1I7xlRxc9yY3wtIBeSZTlmgJjXrV1UriDTXBPrhsdI32nOkRFNc6v?=
 =?us-ascii?Q?/3+FFpEkqhrGOmhZxRv4+WkcNjdveCv0V6bg7KwMAedQAvRZPQJXJuws43oq?=
 =?us-ascii?Q?ufDUSBn1k0+6OJNfLCxSIgOD/KVripFn3U0pBWQIGiWtuoRGLKCgH+WyrsJ1?=
 =?us-ascii?Q?nCJIbVgVwFQFB8kD2SWyqLKX2zhgf83YbFs7089WcNAcbSWheTn0nqgNe+Ov?=
 =?us-ascii?Q?DT0mFStO0i5OPNlfPQQ/E5RFRkgQ13aQbe2Gc0dj1wJ5Nwqcq2/SQs3AlYmS?=
 =?us-ascii?Q?4AgoeCAJmM8OEcyJQhbWX/E55aCkDruw3h4XFY0RgwzG52WNQFk7hrCCipbY?=
 =?us-ascii?Q?RHTCMcMxz52XUAx+ykQpykOaK2J9MjKuoZZFsFeZhTCEIMUHjJg/+74KdPVk?=
 =?us-ascii?Q?WxC8Xk7EIx198lT9p3Pcj36fgd2UeqAkcTxuEculYEe5VsBeD3gq0Qim/S7V?=
 =?us-ascii?Q?Xsv/n7f0e6HF97/2I9JnyLgExEomW0tbVeAlbXw/5XVw1ttYuqEUWg+pXOeJ?=
 =?us-ascii?Q?nIWub/Tv81E1Toz60y/qghWD/JgFJPIBHOeO1dnJjt2a2E2DPtxZETU/J7pS?=
 =?us-ascii?Q?5n3EpaUhuBjuv/hJBYRItdCXjO/yw2ATRA34MVf3F8Aw/1yh/ADjVAQAKvsd?=
 =?us-ascii?Q?x0d2calxrynoShsQ0UxY9juyVKDkNi7wq5hoULFDVjr5fywBaXCnOlu/ZWdk?=
 =?us-ascii?Q?e5BsIUDlQd2xh8+Hs8aFuUElWd65071/fg8ZA3u6Y9vkM0jDhrv5Sx+4MdIV?=
 =?us-ascii?Q?wRNocpgIIGnnmpCGD07K2uQq360FbX6BohzRTMU8yrCFt11ZWI9WUhEmOZBW?=
 =?us-ascii?Q?+qAabRTo05FXSNpmArcd+wiGVE/9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:05.0081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a81c787e-cfbe-4cf6-19f9-08dc62e0f1e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit address some small code style issues in DC.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c    | 3 +--
 drivers/gpu/drm/amd/display/dc/dm_helpers.h                    | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
index a406c5619c45..05783daa62ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
@@ -186,7 +186,6 @@ void dcn321_link_encoder_construct(
 				__func__,
 				result);
 	}
-	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
+	if (enc10->base.ctx->dc->debug.hdmi20_disable)
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
-	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 6d7a15dcf8a7..34adae7ab6e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -36,6 +36,7 @@
 struct dc_dp_mst_stream_allocation_table;
 struct aux_payload;
 enum aux_return_code_type;
+enum set_config_status;
 
 /*
  * Allocate memory accessible by the GPU
@@ -200,7 +201,7 @@ int dm_helper_dmub_aux_transfer_sync(
 		const struct dc_link *link,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result);
-enum set_config_status;
+
 int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 		const struct dc_link *link,
 		struct set_config_cmd_payload *payload,
-- 
2.44.0

