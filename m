Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2BDC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BAD112BE6;
	Mon, 22 Apr 2024 15:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EeQVE17s";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB4A112BE6
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6Lb7nCgb1VSXBeOykYYtgdpCuKakNSNJdCCmDxfKyeUc+tQJ7JHxlMTWb+qkHODbsxqqvzvFXuwHs5hIjV7sfIDKOCYTZ9b6vHUQ4QjiAeETQgFKlmczE6ZXugQrSq7gr0QIPTwg5cVYYx7Uht0lA2wsSzQg0Clpx4EBpHDBF3GQ50Z9CAVOUnMnG8/AUgLhrQk+qnIGefJP7Kf13mt52jPdb5OPpdTGNT8vp1nmuqOw4B+PaKrsPWuRn+lONT6BjZsNCQeGJeIdYrq25LRF7KmJJ47K2kp3/c2EiODJQDW6lm3Y9XaEhaGyUEBcikJmiZE+w4J4w598+YzUsv5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkKVdaLpkzoSVgnI6USjwBv0ZGuFVPOLhH8jfODbyXI=;
 b=Cc/2LJCp0lYadfg8Y8J7AZkY4pFP/cD9Z/d24yXSl86TZHUSQcqnCt8sgWlCwYq4Iof+1XGzAc412GNM5WWFthwfLHWGXUGzMZZsgHVHyfRyv4/bzMs8cWTBvA22D98vOMNifbddyLiIS52agqP7E6Abr7ChEZF4fzSK8nkUDf9mstW23+oPJD1s0WS4vcmgrlhjdci62mn5oy2kUqUakcaPVUCY0ngxR18qmSGelwWZST3h54oPdaTRfsy4hNY8Y6u/QFhhLlP/0yN0T32LHTmzOJVIG/bSGYkJp6MPOCCAxktIJn3r5be8/YUCH6yYQUUPjTzK1QjpRghAobKO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkKVdaLpkzoSVgnI6USjwBv0ZGuFVPOLhH8jfODbyXI=;
 b=EeQVE17sy23vFH7rrYnCAAwxH2xGc9pfkFnlpLNFtS6csPoXaqdubNeSOjpubWWOM0T92dXtZfsLGPJkld/0dA+tm3QpdiGOj8vbpLTrBE+DcEc3TZBvWtHrocohiDDCN8PQM9lQgE1D6Q3y2cvk1+hAlFnZ/ln8t1AkVlSDUJg=
Received: from DM6PR06CA0090.namprd06.prod.outlook.com (2603:10b6:5:336::23)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:28:41 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::5d) by DM6PR06CA0090.outlook.office365.com
 (2603:10b6:5:336::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:28:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:40 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:28:34 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 03/37] drm/amd/display: Add TMDS DC balancer control
Date: Mon, 22 Apr 2024 11:27:12 -0400
Message-ID: <20240422152817.2765349-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: abd26665-ab28-4762-22a1-08dc62e0e3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f73TW+iCSbcKX5HBKprmJMJ+2y0XS/bl2O20/WVFGsN/z7tVZjGTPy87Jajq?=
 =?us-ascii?Q?tIohfigQ8mMgsNe5lpm51w14+v5OT36OOAgW6VVRPAvppqtByW1Su6fWW22n?=
 =?us-ascii?Q?57fkLE0SenYbGsXaft1Pogd4peLQZnVD2dYopdCvZ6vIdFkIyQhUiBJL6Htl?=
 =?us-ascii?Q?fhN9nRvmCjTAPuS9x0BH6YRaW2CXAtpeWr3X3UXcjEEmRpm262la0n8zUA5O?=
 =?us-ascii?Q?xxU3Ab+SER8CStmdo78+YiBJ+wpsvb6BUkTaQbT8TUbRB81Fh+iO1wTf8nmp?=
 =?us-ascii?Q?SYko4HIBGF9GFn0S7gXGk5Rq7k3LfFB3x2ae217wR2cs+rBT3O/DyuYu5pbJ?=
 =?us-ascii?Q?uUoVdPYakHiIHB9gKhUe1Dk+zjKKuhkMOjnGULcZJ8fv156sfuKLGLN//e56?=
 =?us-ascii?Q?qJmn7vH2S+1f3ehZXIVSk4yTKWMxErA3tibUWN6tNAw9WKy8n3nY18288YJW?=
 =?us-ascii?Q?o4oZ8PDP6uvvA2IDA530Fr5F7gBPKegY0H/wUse41STBOUCyowGZlHjP4Cm2?=
 =?us-ascii?Q?yr3uOwMlvN/Q0thLU08wlcLnKF0hP/1gluRwC8xZ49zH5r/XCy1LCSLSaLU+?=
 =?us-ascii?Q?nsFkwHtuCpFbZoYrhsLL+K/ub0pQyGlQ88FlGGmEIVeMs1cM/VHUiJNNEPue?=
 =?us-ascii?Q?vEc4QhKV4eaoGx/OiT0aNCmDmfCP43tSClmFoYFieRtac8gS7ESu8fWUobGb?=
 =?us-ascii?Q?RzntXtcLzcXu3awn1/GDoKARhFDrPBuVJ2KQ3hrWtR/7FH03alukEJDG/zzT?=
 =?us-ascii?Q?cB0H5QieZm+15njV58Yy+jG9aX1tZKcrJowhl/GeHwisXl8RYqaTLkIWvYJ0?=
 =?us-ascii?Q?a/s2tS0emU1ouWmD+6UotxPz8uwo4pGXQc0LAUEFYsU9GiXjmueKOAehjqMJ?=
 =?us-ascii?Q?u3kzt7wxe9/6plxpe0P2WJBQmfPAnmq08pABrXz6m+rDdcVxCu2Hn6LXHyKj?=
 =?us-ascii?Q?EyVh0qKjZOVizSOvnvaKU792ib0okIAfsXOg0eo+UhV3V0jI0nOOKqAFbvoy?=
 =?us-ascii?Q?jvMXyrnuSCKSk2heIFZdarmwWTwy1Z3gSbJrnJihKbAqmPyth/wE4Va4EaDK?=
 =?us-ascii?Q?6juiWh2Avys71IMndZqoPOacLYlRZ8pY2y68/I1fhVhURYY9fJlpQw8EtzT5?=
 =?us-ascii?Q?ul2ep7hVqzx2TNkjFQO54ocUgb21Fouu/1FBdLgI4JolTQnZt7dMp6jUl1dl?=
 =?us-ascii?Q?pVhpOrv5fc5Lfs74oaSrcYkwHeFu44agew384szgkD/X0EXhyI4JLVRuY2+i?=
 =?us-ascii?Q?yYM6g84YtUuI3CSDsPNqdGcBxhlQDukJ9QeUwZE4z4shcL7xSNPQ2EQne5R6?=
 =?us-ascii?Q?rb4fr35JD+BGgUbRf1GaRgFD3k3iTcLkXL0iQ3tVS0XvOK4JNnBd1NsN2/AI?=
 =?us-ascii?Q?E+g0KS084KdbuV2amPpPUhBZiiVZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:28:41.2364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd26665-ab28-4762-22a1-08dc62e0e3cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
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

Add TMDS balancer control to the list of available encoder registers for
DCN 30.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
index f2d90f2b8bf1..5b6177c2ae98 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.h
@@ -55,7 +55,8 @@
 	SRI(DP_DPHY_HBR2_PATTERN_CONTROL, DP, id)
 
 #define LINK_ENCODER_MASK_SH_LIST_DCN30(mask_sh) \
-	LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)
+	LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh),\
+	LE_SF(DIG0_TMDS_DCBALANCER_CONTROL, TMDS_SYNC_DCBAL_EN, mask_sh)
 
 #define DPCS_DCN3_MASK_SH_LIST(mask_sh)\
 	DPCS_DCN2_MASK_SH_LIST(mask_sh),\
-- 
2.44.0

