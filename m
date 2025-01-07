Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E80AE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3176210EB13;
	Tue,  7 Jan 2025 15:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AKutmsjB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7897510EB0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLI/XHqmKSKpAD8+jwR3YNTuhPzP7ecjP06oBox1GTL3HDs6U+kUc05tq8qG/dG5eoPvzQWX3hDptKlMLc9i0AhubN94kxbwh/yCmcun95OtxUZDsugWeYh8b5rnGxCiCWRkYVOU9YDx6p+8fjZEjmwTn733qwod8jhRNZ21kSG2XkSiSCtuT+pSl+9dZeM9FHTOya54TkecQbNXqX6TYE6m7prlHFERvJgCbI3/wd8VCEW5mvXqyAwG23FAGsKuFwxW97LxFoxZZ79oH+6nRNnTuhp5bhX1oZ0xwk0OveBdY9s3awh1IfAWIdRr0oYTp68j2S/zarDEAjxYnww+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6vKjqeFttJWTOw4TRAX+IbWtAArqSB09USci1aKVJA=;
 b=Wr8pew+u+swVggBfRWrrNLFGE9D0dJBgesBEHIH6sDl2Nw1fn1uRhSd0GT7PcEMLNkLu/lh5ZF11X4pCONKrT04HrNcXSzBOBoH14vT2CgKH17eso6TAMHl1X2t9ZFN1niwKje4exsGvyU586DUoN8e6L/I9qrvLz2qcK0mYno4V3tfEEf8GduHQ6kblnfc/2ElB9G5yG08bQDBYnkZwO8YSKpnkfQTb4EJCb37ELuKpSpZFBAO0hekLsRWcGse0BJ5WJ2nzUtwfIC7S5UgRwq6arx73z+3fTdFmlm08sbq6z+vCMzX3SOvjexDfdnm9e8YC1xIf3v7HHrOKrx9xrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6vKjqeFttJWTOw4TRAX+IbWtAArqSB09USci1aKVJA=;
 b=AKutmsjBP7LQwg5wT+lEGRlbvQh+2ET5os66j3Z5WkOKLQDPE/GCz1hjXF2rVbMmPUc1Vb9+PDsFGNQIBGjPTHBcBY7l91Q2JNMoEwZJqss+QSDmsD79p8VfvyytLsaxH0AFR6/nWaGoCzB00Hh+v0nSJLSa7rKjWBWMlhaLzKw=
Received: from BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::18)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Tue, 7 Jan 2025 15:30:48 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::56) by BL1P221CA0028.outlook.office365.com
 (2603:10b6:208:2c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 15:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:48 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:47 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:44 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Peichen
 Huang" <PeiChen.Huang@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 22/24] drm/amd/display: improve dpia pre-train
Date: Tue, 7 Jan 2025 23:28:53 +0800
Message-ID: <20250107152855.2953302-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be5630a-5484-4e0e-0190-08dd2f30431b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YGNHfDxzfolJN+7rBfUrnHnXM0yVLI9+ekfH32ZHNb0P4I3K5VxV0lX4M403?=
 =?us-ascii?Q?1/eyeUG/IHZBJdIV6hVOPZcEKRnr3NxyqQvH9hl/089LWlw6eYN/chyVVnnJ?=
 =?us-ascii?Q?Hbgwa30qvt6FEYeutDU9tm8c34Wv1em2sX6281APwLl8dYbaeegbFNsVRCx2?=
 =?us-ascii?Q?tL9e4H4MeyEjByPFvok91fTwTr94q5t/uhtUa/c/Z0anMo77GXPrtkZUea0Y?=
 =?us-ascii?Q?UmILn7Vw5Q4uqt1NT368MzRbAgVb/+5YO+INdJ6sNsRMu/I+hj5ZWpqhJcRC?=
 =?us-ascii?Q?/M4n7m91yY/G7Uh/brD83rVBWjOAbAJDoqH/EHFlQrPN3Ixv1KX7OC2ZX+Qs?=
 =?us-ascii?Q?LZX2p6VmJNJzl7FDOuqYqr0nPV2byfbSse8V2QxBkeFrycwfmq4VVO/n6rZT?=
 =?us-ascii?Q?8UzFSoqtRNhQh8/MNcU0cAXiEUA6BX8tlhClwd9mP/wxVPpwZTOLuo7aysGG?=
 =?us-ascii?Q?yroqh8GjJs1MUo+xGmxCYfKWTAyXorWaGXdWKEczE0tRMsVbEtUyf8a3g/8o?=
 =?us-ascii?Q?08gd0Xq3w2PvTWO+kgXLkoNgb05erX7Fh6iIWx0YSM9yFL8CXeAbR6gCGvdk?=
 =?us-ascii?Q?63ErNCgKFcrT8Z6Z+GfDMtce5K277/vB5rITbxI2nwTYIQ7JOdg9zzTqA0Nd?=
 =?us-ascii?Q?VbCSgYIUgZgY2T7N4xnG8OQ0uTcupIu7PsJCjv8bF3Y3SMRDLQnIPXH0n6J4?=
 =?us-ascii?Q?xVooLaBlVx69JJdlOc0eMDAkU30hqI+z3IL6GcG5SOpuw3vVIXaQha3XxNaF?=
 =?us-ascii?Q?CD4a8lMdJ9KtYoGb88EGvdEpyCB7xoJo2OC6ixaHo+pLMu+4qP20L/TUC4iR?=
 =?us-ascii?Q?yFMmzodCpJsJraMEdnhRssntMT5Df81yUjAXVZ8ptP1+nFEFoCdFHwM0Iwyj?=
 =?us-ascii?Q?y5NzdJTmJ6psKmjGGcr1vdsSUz7b6n0jtIWvwKmak/9ejlpR5TYyu8T8kQGB?=
 =?us-ascii?Q?A+gwUAd9+cs80wBAk+07ySiT7P1nQtxpg4TNiCRfHlmSL8yAvjSiuDemeykz?=
 =?us-ascii?Q?Gr/HeFIspCcDVWUUO2QAShDlIO39wMhka8Wt0lfrmEYj85ttVS3DSxrbyaxP?=
 =?us-ascii?Q?oRlybCI1rq85HdA+F8miMr1RLHJZzLnKPPOmXQRqm9mGvKmhCvAIQI7CePrM?=
 =?us-ascii?Q?hKrE5tF0JX3X6mnFz+n8NcmlU6cYYB/moP/ZqPYguxNIT80etgpmyXyC3Zwl?=
 =?us-ascii?Q?o6yyw5HJifQSMiKTegFOUE+jDh9OrQiXwBAT/zLj58teJfOcq5AqYeBzXXEm?=
 =?us-ascii?Q?EsTNPWf9CnjKrTDUtr9KKOp6xdAzfxm/SPRtGVljKwPpwDNwW/VrbeaKT9je?=
 =?us-ascii?Q?zb9AwI6Pbw0mY1UD5WfeevwANGx4eqr6lXmOT0boBgkcwYpNqm05DXGrzgaE?=
 =?us-ascii?Q?dg6auqf0dvTt9iMS8kE4BCug458L5CtLXN50bzCWJI1pKYYkrvLEu7/aNprt?=
 =?us-ascii?Q?w00QJwj2lM0F3Tt7bdL9zBjeegwcwHf0xZRSMd1ZQAFIrjevFwX22g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:48.6476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be5630a-5484-4e0e-0190-08dd2f30431b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
We see unstable DP LL 4.2.1.3 test result with dpia pre-train. It is
because the outbox interrupt mechanism can not handle HPD
immediately and require some improvement.

[HOW]
1. not enable link if hpd_pending is true.
2. abort pre-train if training failed and hpd_pending is true.
3. check if 2 lane supported when it is alt mode

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c    | 5 +++--
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c          | 9 +++++++++
 .../amd/display/dc/link/protocols/link_dp_capability.c   | 8 ++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
index b2cea59ba5d4..9a92f73d5b7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
@@ -653,8 +653,9 @@ void dcn31_link_encoder_get_max_link_cap(struct link_encoder *enc, struct dc_lin
 		if (!query_dp_alt_from_dmub(enc, &cmd))
 			return;
 
-		if (cmd.query_dp_alt.data.is_usb &&
-		    cmd.query_dp_alt.data.is_dp4 == 0)
+		if (cmd.query_dp_alt.data.is_dp_alt_disable == 0 &&
+				cmd.query_dp_alt.data.is_usb &&
+				cmd.query_dp_alt.data.is_dp4 == 0)
 			link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
 
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index b8cfeb98e229..ec7de9c01fab 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2548,6 +2548,15 @@ void link_set_dpms_on(
 	if (pipe_ctx->stream->dpms_off)
 		return;
 
+	/* For Dp tunneling link, a pending HPD means that we have a race condition between processing
+	 * current link and processing the pending HPD. If we enable the link now, we may end up with a
+	 * link that is not actually connected to a sink. So we skip enabling the link in this case.
+	 */
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && link->is_hpd_pending) {
+		DC_LOG_DEBUG("%s, Link%d HPD is pending, not enable it.\n", __func__, link->link_index);
+		return;
+	}
+
 	/* Have to setup DSC before DIG FE and BE are connected (which happens before the
 	 * link training). This is to make sure the bandwidth sent to DIG BE won't be
 	 * bigger than what the link and/or DIG BE can handle. VBID[6]/CompressedStream_flag
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index d0fbf9c44a29..44c3023a7731 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2312,6 +2312,14 @@ bool dp_verify_link_cap_with_retries(
 		} else {
 			link->verified_link_cap = last_verified_link_cap;
 		}
+
+		/* For Dp tunneling link, a pending HPD means that we have a race condition between processing
+		 * current link and processing the pending HPD. Since the training is failed, we should just brak
+		 * the loop so that we have chance to process the pending HPD.
+		 */
+		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && link->is_hpd_pending)
+			break;
+
 		fsleep(10 * 1000);
 	}
 
-- 
2.34.1

