Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BF1C61DA4
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164A610E341;
	Sat, 18 Mar 2023 07:57:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E571310E341
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlKSwa8kU1EF8xbfayDo2t4R6RKToVpKdgx5tHaArhr4OFoUXiZJqSHN+zvnFVgWp6HtUiXqMNgHER5656RzERJVl8ZRtpVnGEckdq2QJKZ11wnMX5Lhiyu2xAUexMXQPz1PZHzWHpDyBlLvonREU+LcWEKpQm44y+Xic2zp7pVV/TRtf+4eqeh2dXdCEMs4AtHao9mftXlwSM1G/GqlRLzB7TzAHW5RPaiu+sNIDP2+GaHi+LUcFhPn4YsaaevMU2zAnw+V4DJbvEzKjmmRj9g2FDVi2ERsnruE/HX1/HQbQiP3DPIdANNRQXBkIGbCfbN33ftwiRIp7he9VnUwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSfAyAwBBDJKa+lP5FPhdWhgCNu+gG8qQdZg/GgIRUE=;
 b=oXO6YE8LtE5qkdJRA1ttW05b93cKtI0BdV9Tn0yMnTiIVFnyEcmiWD3Ym+jK2ypeSPWEF592K/gDGnj6LIuHb0mKtyxHHUgWbr/ycXOoq97DJkAkAoSDSfrXv0UwsdkwhVU04L50aGaYA/ngdDcp1mOhgBCpSOnWkpVUv9wBixRx1Jma2DCh9oOKJW4Itg2i5WPpzjr3/HBaISi59JGY3hF+S3J46xte5XEDyKXfDdfafqeyMte4PGKYQ6rGTJfsdGSbnm+j96p8UA+hJ5sG00L1aA7PI7qmtziruZoZCGzRdDHjTsRoclgfeN8ZeGNlD/S6e1f48AYfgKar/VYxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSfAyAwBBDJKa+lP5FPhdWhgCNu+gG8qQdZg/GgIRUE=;
 b=a2unkMlJfzirO2Dqg/kjc1iYVDH96G5v0q+0Vq8DzWvRJo33Fly4xmeJWggLgtpjlH8aBM8KOukhlngcnDd2VXzDoJujh8JCT94LZvbf9e2HE2aR/7jfNgsoEf8DBnhOhX4L0FKu8ws9MwacV/j6z3j3tYAhuCzGLGoKirM7sEg=
Received: from BN7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:20::16)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Sat, 18 Mar
 2023 07:57:29 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::4) by BN7PR02CA0003.outlook.office365.com
 (2603:10b6:408:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.11 via Frontend Transport; Sat, 18 Mar 2023 07:57:28 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:20 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/19] drm/amd/display: Add CRC and DMUB test support
Date: Sat, 18 Mar 2023 03:56:06 -0400
Message-ID: <20230318075615.2630-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: e9224c2f-b1e2-4ead-0142-08db27866b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aubRzd/hMqvBIE52Z8js/tDtCDTeRJIyFSTTRVwhB/MuJMafVZt7EvNDK0IhPe5mFKZekZoa94a/YNgni9Eg4vQqffRYCsWXS1FQo+tFH8M9oOfHbN4oFRDsGlI5Pcu2BCmb0q6Bwij6xIavVHGCGSOL1tx+DTAhhZ2O8WDaxS1SQt8TWkXHGTkUYUQWooZw7nSncYJw5z7zCl2nPXGe9g6OQWOytYjv46xdfmdemhAdh4VBaIVTOjv3NFs9sROqSb4crb9EQh1yejnWv0K7ivN1/OTXO5fe/ZXaBjWh+4lQIub7Bytj3rs4Lu4f0jCByQsoJHy8sBI3dvAS0Z3h0wv0eTZxaJaxQSXEXFsUrUDlmXB8p2fiTRtcDX2BF7aR8XQZIQVLPWGoKKdJqONloO7u/OW4CQ9wLvn8er+OAxI1qZC5AhHLcn5938ixPIEZttO0wmKQojmTzecqAwM7nxT3mspsx4QZMJHjIuWfTH5y0tn7RLddfhoryxcBumKMKt+i44/FpPCXId3BNB8wa9UrbjQmRUHj7thkrY+m/JSf656jZ6qhOcg//cLkqs57qElkHVz1yhpECS2Eevh420TV6CDw0ZJ4psvuRrXu7EVLO28D1NdgTiRLjpjE2MrDP8nw3/smrQML4zElQPHJir3ew4gcS4QYq0CUBbHQRxfDhgGRU1OLlAS/L9tzF37elPRmsOfGAEay4NzWw5W+ameVQGhnKabOkHuc53z8T8w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(4326008)(6666004)(44832011)(41300700001)(8936002)(8676002)(36756003)(82310400005)(54906003)(316002)(83380400001)(426003)(40460700003)(6916009)(70206006)(40480700001)(47076005)(36860700001)(70586007)(478600001)(2906002)(186003)(5660300002)(336012)(82740400003)(86362001)(16526019)(1076003)(356005)(2616005)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:28.5109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9224c2f-b1e2-4ead-0142-08db27866b7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
- Add CRC for test support
- Add params to allow control into to DMUB.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  2 ++
 .../gpu/drm/amd/display/include/dal_asic_id.h |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 0b37bb0e184b..db766689af58 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -161,10 +161,20 @@ struct dcn_optc_registers {
 	uint32_t OTG_CRC_CNTL2;
 	uint32_t OTG_CRC0_DATA_RG;
 	uint32_t OTG_CRC0_DATA_B;
+	uint32_t OTG_CRC1_DATA_B;
+	uint32_t OTG_CRC2_DATA_B;
+	uint32_t OTG_CRC3_DATA_B;
+	uint32_t OTG_CRC1_DATA_RG;
+	uint32_t OTG_CRC2_DATA_RG;
+	uint32_t OTG_CRC3_DATA_RG;
 	uint32_t OTG_CRC0_WINDOWA_X_CONTROL;
 	uint32_t OTG_CRC0_WINDOWA_Y_CONTROL;
 	uint32_t OTG_CRC0_WINDOWB_X_CONTROL;
 	uint32_t OTG_CRC0_WINDOWB_Y_CONTROL;
+	uint32_t OTG_CRC1_WINDOWA_X_CONTROL;
+	uint32_t OTG_CRC1_WINDOWA_Y_CONTROL;
+	uint32_t OTG_CRC1_WINDOWB_X_CONTROL;
+	uint32_t OTG_CRC1_WINDOWB_Y_CONTROL;
 	uint32_t GSL_SOURCE_SELECT;
 	uint32_t DWB_SOURCE_SELECT;
 	uint32_t OTG_DSC_START_POSITION;
@@ -464,6 +474,15 @@ struct dcn_optc_registers {
 	type CRC0_R_CR;\
 	type CRC0_G_Y;\
 	type CRC0_B_CB;\
+	type CRC1_R_CR;\
+	type CRC1_G_Y;\
+	type CRC1_B_CB;\
+	type CRC2_R_CR;\
+	type CRC2_G_Y;\
+	type CRC2_B_CB;\
+	type CRC3_R_CR;\
+	type CRC3_G_Y;\
+	type CRC3_B_CB;\
 	type OTG_CRC0_WINDOWA_X_START;\
 	type OTG_CRC0_WINDOWA_X_END;\
 	type OTG_CRC0_WINDOWA_Y_START;\
@@ -472,6 +491,15 @@ struct dcn_optc_registers {
 	type OTG_CRC0_WINDOWB_X_END;\
 	type OTG_CRC0_WINDOWB_Y_START;\
 	type OTG_CRC0_WINDOWB_Y_END;\
+	type OTG_CRC_WINDOW_DB_EN;\
+	type OTG_CRC1_WINDOWA_X_START;\
+	type OTG_CRC1_WINDOWA_X_END;\
+	type OTG_CRC1_WINDOWA_Y_START;\
+	type OTG_CRC1_WINDOWA_Y_END;\
+	type OTG_CRC1_WINDOWB_X_START;\
+	type OTG_CRC1_WINDOWB_X_END;\
+	type OTG_CRC1_WINDOWB_Y_START;\
+	type OTG_CRC1_WINDOWB_Y_END;\
 	type GSL0_READY_SOURCE_SEL;\
 	type GSL1_READY_SOURCE_SEL;\
 	type GSL2_READY_SOURCE_SEL;\
@@ -525,6 +553,7 @@ struct dcn_optc_registers {
 #define TG_REG_FIELD_LIST_DCN3_2(type) \
 	type OTG_H_TIMING_DIV_MODE_MANUAL;
 
+
 struct dcn_optc_shift {
 	TG_REG_FIELD_LIST(uint8_t)
 	TG_REG_FIELD_LIST_DCN3_2(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index a391b939d709..ba1715e2d25a 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -261,6 +261,8 @@ struct dmub_srv_hw_params {
 	bool usb4_cm_version;
 	bool fw_in_system_memory;
 	bool dpia_hpd_int_enable_supported;
+	bool disable_clock_gate;
+	bool disallow_dispclk_dppclk_ds;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index c3089c673975..e317089cf6ee 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -246,6 +246,7 @@ enum {
 
 #define AMDGPU_FAMILY_GC_11_0_0 145
 #define AMDGPU_FAMILY_GC_11_0_1 148
+#define AMDGPU_FAMILY_GC_11_5_0 150
 #define GC_11_0_0_A0 0x1
 #define GC_11_0_2_A0 0x10
 #define GC_11_0_3_A0 0x20
-- 
2.34.1

