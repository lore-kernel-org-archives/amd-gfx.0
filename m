Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D83CD1288
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A27112E88;
	Wed,  3 Apr 2024 19:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cVrQc28c";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6756112E83
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb/TvvHwloeOaJcap/8q+x/OG6mlOmC1J8IHs1c9jKWoudWZA1bsfLAgYuk0aG4AR/QhOQlDPibe2Ww4QFI4uKHS1SqNZUgMB0MqME43brOHAjULLmG+3+STMhtgWVa4AZxb+akRuVqeNFh9Jiu9GobULU5Ml5qi4kXHWxRR9VEnX8R5QSeHo3qulNExTtQJfm9xRCO7++ehe0OyNoSybfdJ25mJArxeBHbW3QAGLsS5uo4HtT7UHHNiwpFzWkSbIode1DMzQrlsljNfQPcRn8kJlYOkS3d0TxksTkcuWnxyfKY6nveNftJnPK63l20qad3ytn80YQUzsKf3q5pQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZa01buEr19oPf/ha6/wS/UIiR3yIC31WEdtey2sDtc=;
 b=iG23XmeHGi7daiHsEJ0IQ+wsuhntLIdX0GLeIni/jHxoJA3/R5ex/7xo6qwWuvUkPT0+SVlKZH/tRwHZ/QT8kJ28z4i2FGTuMGfVhKr5D3C2wuJ+u5STJxz1A8NnGJgpSpU+WW6fjRnOeiFGruo4TZOD172I8VPB16GG5VJdjlA5AbnTGDBQwpCGFaSrm1jYYIOq5EtPRGmQYUvTWLCNtaz0c6P5c47hmjkZHxr+7Y3vYDGX85CPzRo8xYn1bF3ip83rNlcmuAphrPYk/81+6kFd/7U8Hi32zdg/xCher545PhT7h5Zkg4pm9BkGin6NW0j9gK1E2gE1gJQbxJP1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZa01buEr19oPf/ha6/wS/UIiR3yIC31WEdtey2sDtc=;
 b=cVrQc28c+rDVZzKE88+rjUNaX+d+/KhMvSjFRGFiulIKD4qymsSxB8tXtVlUrKMGMuex5dKKyyZMuT+Ba/kHf43YYcQn9mcpHYKpUmoshJKZdz2+rMxRtQpyvhjOumv4aD3gNKVx58CflNLZkjVCW9ZLNkt7XDPxWKg/mIDyuPA=
Received: from CH0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:610:74::28)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:52 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::78) by CH0PR04CA0083.outlook.office365.com
 (2603:10b6:610:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:52 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:46 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 18/28] drm/amd/display: Add comments to improve the code
 readability
Date: Wed, 3 Apr 2024 15:49:08 -0400
Message-ID: <20240403195116.25221-19-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 682dbe4a-4f13-4db5-5b62-08dc54178231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFWpZLbsW66yIwXT63weeSIB34tg6RyBmXeeaPl4jJfXn3bIPnAQSQJd/amp20i4ZvcZ3m/hIGY6YrHBAt5DOFRtoxhKVrzBb1MFI5P4sbxJ074zEQeCbOcc/2QAmJNF2DDTADFUNhGFEXO0BErmhUWmYXWyHLSb1e/bh7y8/HnaMcV1L5mIm2T0P1hcLKTMPkWTS+krmvlNeHZiifFmSwmcWMgCVww9k7Xg3mznwgsUhYoM997gPoT4htdN37LPszS3dYELi4Tj8HNPJf4PubohgBWmk0CwmI9Ke3etfu/7r1Qc0HOhCEDEIryrVjFj8Xn3gDhO7eX1tILFQhDG5QDBb0HChJntDdZGnRTlmi45ItIM1XjXfcVyqeVySkmpm9/0ivUmpbXOqEPii9ppk5pxSdcp/b4Q2XE28VNusmmKphqocoTx/6M4lZyAkkHcKN+VUNhQROqAv9rC0vMnHoNcNpmegWQTlHkzfR9SBD5pL+D4aJiT28GPSKtUDL+qPck4+86j8wS9rQC2e2jpxQtHkcf7sfzlCFJLXADcUFNHW/eRKHSniVDKFrClY2ebwOGqvtbQKN7QjJ57wpzp1wSl7/KKXSKo7a5k7nPsqMkLntdKlZ6qHraNQh/j7dOGTrMdn7KHZZ3vfeKwzJTCLcr5hszBH8bnahC9m6sWnER6jVD8kV2lfNtZRoQhQO9AtdtU8bZcen8szjMagKRb2PWcpGDx40Sh95WCNYT99AoTup02z7fELX89kGw8Nta9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:52.4396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682dbe4a-4f13-4db5-5b62-08dc54178231
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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

This commit just introduce some basic comments that helps to understand
the overall behavior of some structs.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/core_types.h                 | 2 ++
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c  | 1 -
 .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c    | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 3fab7c5bf093..028b2f971e36 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -339,7 +339,9 @@ struct stream_resource {
 };
 
 struct plane_resource {
+	/* scl_data is scratch space required to program a plane */
 	struct scaler_data scl_data;
+	/* Below pointers to hw objects are required to enable the plane */
 	struct hubp *hubp;
 	struct mem_input *mi;
 	struct input_pixel_processor *ipp;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 35a2cce0c2b8..56ee45e12b46 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -56,7 +56,6 @@
 #include "dce/dce_aux.h"
 #include "dce/dce_abm.h"
 #include "dce/dce_i2c.h"
-/* TODO remove this include */
 
 #ifndef mmMC_HUB_RDREQ_DMIF_LIMIT
 #include "gmc/gmc_7_1_d.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 914b234d7f6b..0d2974c9c823 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -182,6 +182,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn201_soc = {
 				.socclk_mhz = 1254.0,
 				.dram_speed_mts = 14000.0,
 			},
+			/* state4 is not an actual state, just defines unsupported for dml*/
 			{
 				.state = 4,
 				.dscclk_mhz = 400.0,
-- 
2.44.0

