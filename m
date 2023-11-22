Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F899C072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 07:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F278C10E5B5;
	Wed, 22 Nov 2023 06:59:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C697910E5B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 06:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgCsKNkah5PLch2sHX4Ed6owVlG4npt0KGViQLAmy+pGkRLnklEBqm+30rrHO2CzKePXFe1AwAnxAhUL4SJXEB4AENjuvQRnTWNCC0hX9tJICwWSl79fP8+v1TNsyKZcHMMVPNP+Cdg/jFWrVDdyWpRCf5yQ/Nr8bbul4EkonlNA23qk+IQQWr26Q32VAOTDdJW07LVLUOiQRNTkgNlIqrYTZJ6kdeN52zIOQ+viHmwSIsHCot71B0ZSCUgbFuVP+zTlK0LavcMRhZeoYZQ5VnG0/gkqeh68NGg1Mefm6GlYPYjNNMAS6is1FRPeVW5/Skh9cJXwFWlfTltkTHIbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nStJKdGrtzNWI3TyKs2vh+9bWw0JLTnrnSGJ6JlUG24=;
 b=W9kiZC0F/30k7xqRhg8V4MZd8XlynTDZfOIxEcdwF1VM+LSQBXYtKx6wjX+LhVfkgVDCXfP4kZRI+y3/J1fk5GYM3sy0ic2nYZOBLi7Z2aRVu2Q3vfQyhE2IhFt3r5xtcFuf+K7A6i9T8Ew0Xie8HwmN7VKJh+lE7qSFEbTVzOHxCrAhkCksdRSpxtlUySUQdiCeAM54aJle7JK1mmhBdDOKs8kQhOdQg7JQ5MOSaMF/9nFN+YwIblRI7+xxn1OmSsZ9dJI/6wmc/5izdGMRmipeY4CFWG7x3FhLthmJ8Z7yAsDOkOPXZboKQ7R37WSAH0zcyzCTipB4hmelf40hNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nStJKdGrtzNWI3TyKs2vh+9bWw0JLTnrnSGJ6JlUG24=;
 b=4DBSPH4U5Wrt1mq6IniY6u4ETiuU0nQerVJybY2vdHnBjWaP7PXsBitaIN3+LPjpZ1wGZ8wMG/X2x3/vyIw2gMCPR+9yBfbUsUMNmNy3zV2WAO/eKALu/IqfMuUFfbswYWTHX2wdB1kmuKXuVG0U4UcwOxg1C8lE9+W73Yqgkcc=
Received: from CY5PR16CA0029.namprd16.prod.outlook.com (2603:10b6:930:10::12)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 06:59:53 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::f3) by CY5PR16CA0029.outlook.office365.com
 (2603:10b6:930:10::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Wed, 22 Nov 2023 06:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 06:59:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:52 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:52 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 00:59:45 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amd/display: Add DSC granular throughput adjustment
Date: Wed, 22 Nov 2023 14:58:40 +0800
Message-ID: <20231122065841.2267110-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
References: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fc8fce-dc5e-4d8a-e0ba-08dbeb28a0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6Lox5sFZRntKY4f7dFqY/cI628pDIibQotJKnpiFgdWO575FRNxpdc5bG6rGMSOLUVtv33s8K0ZrWx4XIeGNYDB5OxYJZiPI1RmeueBHn7lSaj29LUbXQxvPVKDlzCDEGzVhTnkzx+d0Yb+IcM+S8jCuznNcrLuzGKrPP5z8G4JpCRWnz7h+nwsU4wqcJbmBLsG9xZFw00pqejLqlwK/dQt0ws889Kr9iegTm64QRvD6zo8FDb9+ayTIlVouxff5COE1J/XMNJ0vCkjGBlcggx80SiPc6Yrfm3ssCTMCeBCkFGWMYwfvdHbZde8U/QuhAXvTn70Pksz51XhtOCJfqum4lZo22xMb5hWGWiemwwwmfrJtjtoLwA3/zcSouNnwBa1J7MOxkeVhGbl4fuhk6ujJIY/3JEbY7DGhpw8VrZjhKFr4xAV0mk6SH9eCf//suu71uIbm3umyQbHKvy18SQdlCy/sD7xQ/0UrrWPuHAuyCprLXxjyl9crQ7dS3jxnd+Q+/b4luoicuKCygSObwWlHZM3Kv1IoO3/nmR48Nyd2sm5oROtT3vr4vdGMR1bfv1CJ32VUzqYy9oJYd6ATZpC25fiol7abp7vqeE2wk6L5/IKQeWZOxm8OyvYwgjsXGd/aydtI5yZ8uayygvhcFArpfVveYzzYRA9zujdf2o+gqrrnTWOeeQAVCMJqfk46/ufVs2zoKAWVxKaheidKRWAho0zDDBRLSS3GAkH4wrj+nxOA9x0Zqnu82sW52RT67xd0siMFCArz9OTT4kagA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(1076003)(26005)(83380400001)(6666004)(7696005)(2616005)(36860700001)(47076005)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(478600001)(316002)(6916009)(54906003)(70206006)(70586007)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 06:59:53.2315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fc8fce-dc5e-4d8a-e0ba-08dbeb28a0e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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
Cc: stylon.wang@amd.com, Ilya
 Bakoulin <ilya.bakoulin@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why/How]
Update DSC DPCD parsing to take granular throughput adjustment into
consideration.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index e8b5f17beb96..0df6c55eb326 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -331,8 +331,9 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 		int buff_block_size;
 		int buff_size;
 
-		if (!dsc_buff_block_size_from_dpcd(dpcd_dsc_basic_data[DP_DSC_RC_BUF_BLK_SIZE - DP_DSC_SUPPORT],
-										   &buff_block_size))
+		if (!dsc_buff_block_size_from_dpcd(
+				dpcd_dsc_basic_data[DP_DSC_RC_BUF_BLK_SIZE - DP_DSC_SUPPORT] & 0x03,
+				&buff_block_size))
 			return false;
 
 		buff_size = dpcd_dsc_basic_data[DP_DSC_RC_BUF_SIZE - DP_DSC_SUPPORT] + 1;
@@ -357,10 +358,15 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 
 	{
 		int dpcd_throughput = dpcd_dsc_basic_data[DP_DSC_PEAK_THROUGHPUT - DP_DSC_SUPPORT];
+		int dsc_throughput_granular_delta;
+
+		dsc_throughput_granular_delta = dpcd_dsc_basic_data[DP_DSC_RC_BUF_BLK_SIZE - DP_DSC_SUPPORT] >> 3;
+		dsc_throughput_granular_delta *= 2;
 
 		if (!dsc_throughput_from_dpcd(dpcd_throughput & DP_DSC_THROUGHPUT_MODE_0_MASK,
 									  &dsc_sink_caps->throughput_mode_0_mps))
 			return false;
+		dsc_sink_caps->throughput_mode_0_mps += dsc_throughput_granular_delta;
 
 		dpcd_throughput = (dpcd_throughput & DP_DSC_THROUGHPUT_MODE_1_MASK) >> DP_DSC_THROUGHPUT_MODE_1_SHIFT;
 		if (!dsc_throughput_from_dpcd(dpcd_throughput, &dsc_sink_caps->throughput_mode_1_mps))
-- 
2.25.1

