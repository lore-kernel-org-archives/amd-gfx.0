Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B94BC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD1410E897;
	Wed, 21 Jan 2026 22:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nayw9rpP";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013068.outbound.protection.outlook.com
 [40.93.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB4710E895
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFV5LWPJqSjz4+0pHvUKlzLBIvMGYvYu+kAzMR69Kk2sGQI0bAmfHWuRsSXaOfd4zJtaPyTKGOwktLgqsqqMjaXW1WPwPEAeDiGPtIdF9TbKnWwaoIVIhAeKRHUKXY2jxYP8dqT4PJrNxdj2iwTDbYX9Hjk0OYEbpHKeHmiLgoaeHboO0m+i9qcxXFbKvRjt4+yZnLlIihPCio0k9UuJQgIEOL9CEmCMNdzXkx0dREw8g9vkRRRyHgopfzoAvIWnmghvuG2T9v27uF5msLgVfW8ipnVOjeWyMp6srtA94CJwt2D7sZD26N7NaA6sX32EsOd1pyeNympyYSl43bnrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnUH9v2TUoUtOmZ2iMkMU9ogVZWWoMSzaFrXeLeVz1c=;
 b=AaZ4pMkifxZscfCdvRpKcKVEHkrZ2H9MJL0Bn3WQAxxIgx8K01Hf4yAKU4/Cf7NmJSvlUMjGiYaFRiZ0mRqp4fU3yL5mhyHroDDTHerMxDhz1IMbHcnHSnX3Kz6TWf8onB49G8NvbUzslPe9KnNTpV00LMSha5fpho3qQTLn7dH5UaQPR6Is/YQ21ZQVCBjjELDFrAAObS7/xOnpEMLRnNm/gCcN/ebdXLFS9gDgyWJCPMEF1SGUDuGLk303tstmkD+rrnmsrTq6phaQKo06mGxFoI02Rz8rewEr2XOwtLAu2XskcmEEIVlZ4Uys5MOvQwdQLNczj8RtDruq8BVXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnUH9v2TUoUtOmZ2iMkMU9ogVZWWoMSzaFrXeLeVz1c=;
 b=nayw9rpPCMURWhlor2aBSfWK1x4X9SSgtiNQJx762yhKsLK3NIHADQj7u9cY2jBdPon3bypiSizjsNKAmgEDXj+LTUgdB6uJjlDFBOJVaKrDCEU1HqJLCXs8b+iffffRrgpM5mPy6OapyAZCZZoeHNvJQxJywjMARX34mIqsZD0=
Received: from SA1PR02CA0012.namprd02.prod.outlook.com (2603:10b6:806:2cf::17)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:33:13 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::15) by SA1PR02CA0012.outlook.office365.com
 (2603:10b6:806:2cf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 21 Jan
 2026 16:33:08 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Jan
 2026 16:33:08 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:33:08 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Zhongwei <Zhongwei.Zhang@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 08/13] drm/amd/display: avoid dig reg access timeout on usb4
 link training fail
Date: Wed, 21 Jan 2026 17:31:44 -0500
Message-ID: <20260121223247.186241-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fca136-f261-4a80-b670-08de593d1044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YqCzELg8YiamzTmwZbgCsNVtXzptFzyN3W7W6ATPRhK8ZM2S8/f9VJD10wjf?=
 =?us-ascii?Q?QsGhtU5Gk0zDCFzG4hS26Qh1PfVJZVO9m9/7iGg/qrJk0rnI4XJ6FOdLYdp8?=
 =?us-ascii?Q?oX++KJinA3rvLdFiAVYUZPHRT7Iwhjva7LNm+CwEKowsTh4UGHUo3cizrXy8?=
 =?us-ascii?Q?IZqruuwRjIvr29H2yLYBnymwWhXrYlIjDKEfiJuCZaTixsCHRWXNmO+ZI4RV?=
 =?us-ascii?Q?FxWVb8vcXM8rFqEdqJcy2TRmZ+2mVxQr6Dka3KJjYxSGzZau34adTKM+vbcL?=
 =?us-ascii?Q?eSBaMJLsmNu5Jbpo7T6ftPbwLB9StGUmsyfCfVss4Axw5k3a+DMgv+5bS0PM?=
 =?us-ascii?Q?2lAvGeLjrkmj6YVf9Aq8VSb4oQwLfCwXtocPHEFEQmynPe6l69Zhw3G7Loui?=
 =?us-ascii?Q?wevR2pUPGLfDmhlNpOMMcI4G8UpyznovfyERncduzLpXkhPY9Bek/xVrEsfJ?=
 =?us-ascii?Q?n4T+zOzz1ZIHBA0WFu+K6ok3Ek1+E679er+kWGAWAQ7it/9iTH6wcfuL0MYg?=
 =?us-ascii?Q?O6ewc5NqTuP5Jat7YHHxANRCHPWW7kiVBRBOju/9TT6+Z9eP94JJZUqVw38X?=
 =?us-ascii?Q?EV4D0+ZgG9DOwLDoQbAR0At81hta7NjPTqwFtVspGg/erSg7hDorEZkT3V3D?=
 =?us-ascii?Q?pPVuWAOWqSYaQ14eUfXn4k8AngLGmmlQ8EPuPpbrUYPiXaUdxFsti33vPfuf?=
 =?us-ascii?Q?v7b5CUG1BZdL0XDcbo/7iWeVCaRw9r0SQyks+raNebUXr5t90IHEibh5GXy4?=
 =?us-ascii?Q?cw/CCmwRAYCcxaRD6zbsjWro/UfdBgvA9hhZ/irGDiRlLQ7+d1Eg3TuuaqXh?=
 =?us-ascii?Q?qEF5jwQFWbyep/mqsLp1CxDS7HU6iGJx3WNowGjwx07xp7PRfTcTyh5E8UfG?=
 =?us-ascii?Q?r9XXICEpspBhThTKyRO2PpJpf1hF3Zm+YF4/qFr9Wqi8geQmCpLjT8aEua94?=
 =?us-ascii?Q?/kn2/lg/0zYVAxK8JMEtZt0KCGgb3EDY+kx8lLJRom5dl0Ij4OOk1mlgiql7?=
 =?us-ascii?Q?2UxnpdV8gChsZkzC2ccZOlsfn7IcHbAUigduoynLfaqqyEksVg1/IX8FnQKS?=
 =?us-ascii?Q?BJgv4WyftNxSvegQe74LRG3e5q2guI9kTjFSdJ54ZGbQw+EidcptW7QHzm1a?=
 =?us-ascii?Q?YQELm6mBMyta73PN/F2kekKPgx/Snt/PJxF20vRqmZVCsFrIuzStMy2/5FOv?=
 =?us-ascii?Q?1dURnJeTw5Q2Apk8FKQwKhsktprO9RRzkmi1VYM3XXqamQGKiK5EyGkhKn5y?=
 =?us-ascii?Q?P5yZ5pbFzhMyuI/2GV4fibW+ed1BvEejWwsi/V+0Is8alCge7jdgvQdP5/vZ?=
 =?us-ascii?Q?6Mz2/XUOiK7C7dlu5E75K2xjulH6mYUyWtDEf8YZDkfJ7GRif5CP89S4oeCu?=
 =?us-ascii?Q?KrrN2z/DyH1rKzA7018g5rP3ztjyfyoKXtADw54wCdFBzUARfe4L7rgqHqPb?=
 =?us-ascii?Q?KQvlQ5e3TLOLnlFpfLENunDoWoD743pJbssWDgcRxbbuK/UD5nQeNMC1xZER?=
 =?us-ascii?Q?bkIsb61++E7uJLZ1D/lQe7vMBz0su+iGlgpCdCvPj0z3kF4hLS00WkfRGoTR?=
 =?us-ascii?Q?PLBp255bUcR+CPMh5ieTxsAVZYCbfs1beZwOu/pl/YTxIwWsf8y2qWi+YTMb?=
 =?us-ascii?Q?sObv/5CUUllSzFdFpX730ffsLiLr/hRsmYBE8NU4cOT8qIeH6tZYOBzgide1?=
 =?us-ascii?Q?50wnSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:13.3661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fca136-f261-4a80-b670-08de593d1044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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

From: Zhongwei <Zhongwei.Zhang@amd.com>

[Why]
When usb4 link training fails, the dpia sym clock will be disabled and SYMCLK
source should be changed back to phy clock. In enable_streams, it is
assumed that link training succeeded and will switch from refclk to
phy clock. But phy clk here might not be on. Dig reg access timeout
will occur.

[How]
When enable_stream is hit, check if link training failed for usb4.
If it did, fall back to the ref clock to avoid reg access timeout.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Zhongwei <Zhongwei.Zhang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c  | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 77ac7b22b8dc..16ea6179640e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3058,9 +3058,17 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 			dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
 		}
 	} else {
-		if (dccg->funcs->enable_symclk_se)
-			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
+		if (dccg->funcs->enable_symclk_se && link_enc) {
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA
+				&& link->cur_link_settings.link_rate == LINK_RATE_UNKNOWN
+				&& !link->link_status.link_active) {
+				if (dccg->funcs->disable_symclk_se)
+					dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
 						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
+			} else
+				dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
+						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
+		}
 	}
 
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
-- 
2.52.0

