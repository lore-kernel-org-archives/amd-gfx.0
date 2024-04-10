Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6744CCD1284
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD53B1123F3;
	Wed, 10 Apr 2024 21:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WbKLO1aU";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE9010FA91
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIytIe8giTwyfBFI0ciqYzsVcQUdxQUEXAnZukkREaIJJBrA4hV6ZlbGEK2bO9iS+e7HY/EoAaycbug/nQOYWxX3wbZfyNmE2dkLScsL2lpO/vZwZ2jYLoG+QMpzbSso1kEZMieA0CceETp8OS46whlTUxnBSLK/cONrr4qpE+TLT/DfeqNT76eVY6G+iv5wdHsMQnSJlGOHzMlh7sZD2Pa4grxoE9J/daMlsE/jjsfawghvYJYDU0mlKNw3kNS4Ed3lO4fCnXOCk3B/H3PY4IULYxRyECxU3GJjev0sZWhFF3j09PohFVlA08VTzA8hwKcg2tUyJZz4AuiP03XsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqOTDLwjUgMsueccXF6tTGrPm0PO4ftYUDbg4/KKL+Q=;
 b=hHv0QKLe6D304aJArGmWG/K8CavnOi0igQ7DvikBknZL8YtQ1zkWw/eKAfMEd1gT48itfAkIjq+5XYJoXO5m9s7ngqLPSEY2l76DkYC4KYU4ZyhB+I5gaEu9NZjWI/J5wk4dIISkwkq/PfYImebJEb/wk+AMB02LzPKgncn568txaqxeBsNaRcfZWTeqZKTnkPmJBKp24nNTGo9XPXPBYyGwFk4+b2NRjmtsoZW8V6VmYKYS34gewlDyHJi2eJ/diFVHDthCfDN/RTUz2A09LSSbbDp1bzAmMBqDPBLNi3KeJkxSCRkYWTo5UqW6v2zzjfNjv4OZUIjHS1kxstQ4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqOTDLwjUgMsueccXF6tTGrPm0PO4ftYUDbg4/KKL+Q=;
 b=WbKLO1aUnR0cveBElFac/nZKxyj/LMPwmtX/nLGpLCqpT04K/bS8E5U9X7PnNahLc9m2bQxJmykdkY3dybR/4EVmJd2cLiEqKPxVUH8prMcN7NkNfa9bSTIEsSaASsLj9NVcm4HPi0yg/sfpnBKVuVph3fNYeKuhU6kBiM08cjs=
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 21:28:21 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::20) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:21 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:19 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Eric Bernstein
 <eric.bernstein@amd.com>
Subject: [PATCH 19/25] drm/amd/display: Update FMT settings for 4:2:0
Date: Wed, 10 Apr 2024 15:26:08 -0600
Message-ID: <20240410212726.1312989-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 930ab881-8883-4fd9-8623-08dc59a52599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DT1Twgm/haWbdpk+3DB3LFtRXYO9VVoJ3yuaG+FLt2cBOHLVrTDRfbhQHrYgYwn3BlM5aZTplpBUh9+f4MQIx/F3IlvmtBEGfrR3+cly/MfKzkfmaITPeuoQa3qV83tGheq4C/ZlbsPPDaSNbscPtUftMQOfOVe1iao3H81yUVuhmm5S/4lGpsw3N4vzp5QyoVIg4O3X+NBgWd3s37nnIqNWZ9s+WEca7r6KLrXk1u9zoH89TCGUGW92UEVV3JjX1I228K9rSex31kgxpWMG5c4AP1JOmTiuTeoV+Zs1PiLqeC+JrbHrwnN9T624PNAQW66qH1ADCObIu19dtgSvFDY8+kxro5NJasRb3+wYWIt2popsCe5Chhpopdgg6MZiA9n+p+TvBGG6fxWD5TlIgDu/9TNQgYoEFm9TEYTha5vpmrC+z27y2ERcDefc6YL0r2Fh83C/UH2RxUt0Hv2z2j96Uj+yTXdGOFLCSPPrX/KWJWnSL1T0eAm7dFL/usZKieHpbNsQ3EbZ2U7iXG/wC2w1ai+gNXmkbwQ/LfN1T9xHihpXEuejKa0iIuu5c3FyO8t1d3kK3qXV55hoJZ7u1wGoTEgZaCGYsnCpf5cWwzgbyw+e3nxMD005OS0NQSJtXTOpWSTAVCcexk0XqZS28THhcr6Jd97XD4cmJHNXyf8LvGnWO6xr+kNPvdHNKh8wA3H5GCNmjdHND9x5vuxdAnUnscEA119XEKfR85bMAlGlJuxr6YjnIy0yhkJT6fF2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:21.3968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930ab881-8883-4fd9-8623-08dc59a52599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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

From: Eric Bernstein <eric.bernstein@amd.com>

[Why] Update FMT_CONTROL settings based on HW spec
[How] Update FMT settings for 4:2:0

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c | 9 ++++++++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
index 5838a11efd00..71e9288d60ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
@@ -168,6 +168,10 @@ static void opp1_set_pixel_encoding(
 
 	case PIXEL_ENCODING_RGB:
 	case PIXEL_ENCODING_YCBCR444:
+		REG_UPDATE_3(FMT_CONTROL,
+				FMT_PIXEL_ENCODING, 0,
+				FMT_SUBSAMPLING_MODE, 0,
+				FMT_CBCR_BIT_REDUCTION_BYPASS, 0);
 		REG_UPDATE(FMT_CONTROL, FMT_PIXEL_ENCODING, 0);
 		break;
 	case PIXEL_ENCODING_YCBCR422:
@@ -177,7 +181,10 @@ static void opp1_set_pixel_encoding(
 				FMT_CBCR_BIT_REDUCTION_BYPASS, 0);
 		break;
 	case PIXEL_ENCODING_YCBCR420:
-		REG_UPDATE(FMT_CONTROL, FMT_PIXEL_ENCODING, 2);
+		REG_UPDATE_3(FMT_CONTROL,
+				FMT_PIXEL_ENCODING, 2,
+				FMT_SUBSAMPLING_MODE, 2,
+				FMT_CBCR_BIT_REDUCTION_BYPASS, 1);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.h
index 2c0ecfa5a643..c87de68a509e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.h
@@ -79,6 +79,8 @@
 	OPP_SF(FMT0_FMT_CONTROL, FMT_SPATIAL_DITHER_FRAME_COUNTER_MAX, mask_sh), \
 	OPP_SF(FMT0_FMT_CONTROL, FMT_SPATIAL_DITHER_FRAME_COUNTER_BIT_SWAP, mask_sh), \
 	OPP_SF(FMT0_FMT_CONTROL, FMT_PIXEL_ENCODING, mask_sh), \
+	OPP_SF(FMT0_FMT_CONTROL, FMT_SUBSAMPLING_MODE, mask_sh), \
+	OPP_SF(FMT0_FMT_CONTROL, FMT_CBCR_BIT_REDUCTION_BYPASS, mask_sh), \
 	OPP_SF(FMT0_FMT_CONTROL, FMT_STEREOSYNC_OVERRIDE, mask_sh), \
 	OPP_SF(FMT0_FMT_DITHER_RAND_R_SEED, FMT_RAND_R_SEED, mask_sh), \
 	OPP_SF(FMT0_FMT_DITHER_RAND_G_SEED, FMT_RAND_G_SEED, mask_sh), \
-- 
2.43.0

