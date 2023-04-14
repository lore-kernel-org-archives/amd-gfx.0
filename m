Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A028C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4711E10EDE3;
	Fri, 14 Apr 2023 15:55:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEBC10EDE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfwCpn1U8xmZ7gCa0CbDSOtxpPjlQBg1g15Vcic/ZDI7VArYK7mLdwsPyP4ahHLIZIFnj0VeKcy0MLXt6rxZVZpXJp2aPZe9M9NWKhEKISqLdkdgez/e0ngFLo0xkeHkbSGrZoQ1akPV2ECr7A2iDFEIBY9WBEbU/rYRlCHUtyg5RrX295EaWzij8DdYyzQOGFZ9xa2D8w/johzJXrVPpPm09Fgke6N84CN8xcFJgpYG/VgQGQ0zhbuAN7XCkw/VadVDb8OuBOoc8xMQSfcp34sq0Ntv9vO4u+FGp+CidPOeV5anTnD/7hPT32Z+78/zn4Lh2rf5lafSkh4FGeCGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jY6zU0V19ngWbpFr0GylNZb9vWg8e6chKtFiHC0ijM=;
 b=ENvTuCDjDgpvB8TQIZTXXaYH3WazFM7e9Yxxjccf1LrdqQXMn8vvJK0BQ/sidR4Z5NVO6dreFmEGQvMG4KMRuKUrmI7Y9HD23XgEun4/uLmCMRmWCRj+t3XOdCOLxPyDyl8X8TAKSXEU5laDtsIF3GQXPacktKSVP/QMRZb6HrsLJ1HABsSLZGqcvoz0otMEHDUFWbgVetLWiIWGid36otsOIl//pwHwlRA2DEL8hoMdWa0eOfPuq4EuAwGqquTngLuVrvwnudDE2b5PhtidQj1QEWTQQXu4jlBAoUc6PBsvhYoerle6CX/4UqvOfSvMvkWzVIGae76gTpiQY+E+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jY6zU0V19ngWbpFr0GylNZb9vWg8e6chKtFiHC0ijM=;
 b=PPpwmcOJApTyeuUwi7ljj0ERg1aJfmNi61WFYNagrvHKAzljm5f9QpulpAScGPoLh8+sjjXojmzHUpD3dYAOCfH5pcbbNKWkIoKspK7GNMEkuKJlDOppkp9SRkXW6bQPFdZcoWEkI7HsIK0fDvQZJZLN7RUHHognpI8S80gZIjo=
Received: from BN9PR03CA0432.namprd03.prod.outlook.com (2603:10b6:408:113::17)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:02 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::29) by BN9PR03CA0432.outlook.office365.com
 (2603:10b6:408:113::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:55:01 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:58 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 48/66] drm/amd/display: Update bounding box values for DCN321
Date: Fri, 14 Apr 2023 11:53:12 -0400
Message-ID: <20230414155330.5215-49-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: a6812bd2-94d5-4b13-5708-08db3d009b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/70LUK8SlboZ2j/Xy988anhgvFB3mMJ6kyxeijXT9C2hfJF/fPXvf+tXIyC+ufCzxbQ61qA1s+Xa4Hu114oJ2kV7eHDcz2THpEBixbI79RgTobfyW5hiX3obzuNU9L0VsHNGqmng27sUqS58MCzdt+2cQhjZOA+lmM1n3Q+vLgrCf9kVTcw6sfPB7/0snK4Bf/cOxgd4YMzM3OhsQH2FNmGgpJ7co0++9X0rJqCUQs6+OtdRt1QmUBWr+rghsMbgZ2XYg6IbY4TIW3lTGhZYj2bgPh+iV2QN4mgw+BRC3aelVT2vnNkY+Ue5hMmGj/LRUZqiIQ6EotrNS0PzY8uweO+j1+C8RC1Uga5h6FeoprgeD98xvXj9EzVeICLwaoPzJpyrAoi6uBZNQN5I5S/yQ1nukXDA0J6L61Ib2E13ccU6pkHVs1TC7CIayAUhtzeHhBeInfVXN7d2eyItVAmjYsdqp5HQs0dzwvbREd2KqseWNznG7gx/IPqFnTRQ0FbRXvpg4StGy6l2RomrzlW599wXCkkTJEqcaOsQ7x+TzDrbYFLTii2GyX6cBFJmB8rR95R9VvI2ttYDRFO5dW9evHTBhUBuBqAMeEcOxi34lHw0gLreYIH9uW2j7+I/7C8jh42420nwRKU5fGyjQL0gYOB3f14hOkLMkXj7bz9tYfWrDiZnx3ucbT8u/BSyUiIy66R4bTWuJdNb+Cmlk8oShCqHAiLC1epbYtcfE2K5p0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(336012)(426003)(2616005)(15650500001)(47076005)(2906002)(40460700003)(82310400005)(36756003)(40480700001)(82740400003)(86362001)(356005)(81166007)(36860700001)(41300700001)(83380400001)(6916009)(6666004)(70586007)(316002)(70206006)(4326008)(8676002)(8936002)(5660300002)(54906003)(478600001)(26005)(1076003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:01.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6812bd2-94d5-4b13-5708-08db3d009b32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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
Cc: stylon.wang@amd.com, Leo Li <sunpeng.li@amd.com>, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&how]

Update bounding box values as per hardware spec

Fixes: 1951340bd31a ("drm/amd/display: Create dcn321_fpu file")
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 57b9bd896678..342a1bcb4927 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -106,16 +106,16 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.clock_limits = {
 		{
 			.state = 0,
-			.dcfclk_mhz = 1564.0,
-			.fabricclk_mhz = 400.0,
-			.dispclk_mhz = 2150.0,
-			.dppclk_mhz = 2150.0,
+			.dcfclk_mhz = 1434.0,
+			.fabricclk_mhz = 2250.0,
+			.dispclk_mhz = 1720.0,
+			.dppclk_mhz = 1720.0,
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
-			.phyclk_d32_mhz = 625.0,
+			.phyclk_d32_mhz = 313.0,
 			.socclk_mhz = 1200.0,
-			.dscclk_mhz = 716.667,
-			.dram_speed_mts = 1600.0,
+			.dscclk_mhz = 573.333,
+			.dram_speed_mts = 16000.0,
 			.dtbclk_mhz = 1564.0,
 		},
 	},
@@ -125,14 +125,14 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.sr_exit_z8_time_us = 285.0,
 	.sr_enter_plus_exit_z8_time_us = 320,
 	.writeback_latency_us = 12.0,
-	.round_trip_ping_latency_dcfclk_cycles = 263,
+	.round_trip_ping_latency_dcfclk_cycles = 207,
 	.urgent_latency_pixel_data_only_us = 4,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4,
 	.urgent_latency_vm_data_only_us = 4,
-	.fclk_change_latency_us = 20,
-	.usr_retraining_latency_us = 2,
-	.smn_latency_us = 2,
-	.mall_allocated_for_dcn_mbytes = 64,
+	.fclk_change_latency_us = 7,
+	.usr_retraining_latency_us = 0,
+	.smn_latency_us = 0,
+	.mall_allocated_for_dcn_mbytes = 32,
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-- 
2.34.1

