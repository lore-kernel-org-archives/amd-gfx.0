Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F85CC677F1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 08:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B8910E59E;
	Fri, 24 Feb 2023 08:33:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFCD10E593
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 08:33:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBNWm6BsoZ6ErrGKSZo7+3hhTzZCaga7BdKWBca96RU5wX8jYFS4BMaTGxdQkrjxJLiMG4qIKueEFLOB/NDlqmiCz+j6fexmUEtLWvjLUTWRVk8fraT4J3vynzQ4mFtkAMydgSXZEHGriGOExrjqSjmqg2DIn20DYA27WlYCVLp7m73oRNFidObmoyqPcD8TchQpcrHirbg1tp4l0iuFVyVoKQfdpwIn1xXC3ApjFfbp64Jci1GP9pEDWS4ObkhgUdq27UyfBmVvdeOEylH2nYjgdPGq4CdaUNDR1PyxV1dC7c6e6Gor8WcABPKIMcXSEsO1r7XHjL4LzVUgYhlHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtZPxwO29nP4watyvAuSJj4KQ1q/n5iWV5QdsD6wnN4=;
 b=Nnm9+jHk4iRNhQsRVeZWPb1CDIS54MKOYbl9UFWEw3oJrThGMQ3i36RNj0+jLCQOkmWB6+exHldFuQRK9RQ4NJGizimco4IEge/ZHKIYFc2xwGjAun2e6dmAN5yvKbYXzF30Z8IP9EHaYGapgFk04zYMhwym406/NHyGPXBh45QMWRIGzZs6zEOShnJjNHG7jPoYXKiemxEo/P7ITNqQuOIrwp4Fo2Wc8rigJoJDzMwlayZ+FLmocOM49Fpd1BEhJys0oUptD+39iUgBl+Gt5p2XMBINCQeipXVkUGN5cD4iDt7l3HjFJ69mEWPWi2mOBNaNlXu6na4+UMNde/v75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtZPxwO29nP4watyvAuSJj4KQ1q/n5iWV5QdsD6wnN4=;
 b=BFU2KcjDx9jJdGFQuugPZuHI3cxSuGWKk8cGY2rvZqvOijjJX3LR92OC0ugKBz49CjwOfFitz6Z0RjT5ft4jkF4bB0Tk8i06CegpjkAo4m+5rn8VZjv13m916ZCqZ/i9gfEZGdQYnc9G2z6CnvsDwrY0ny8awQEPoBYYc3DJudI=
Received: from BN9PR03CA0420.namprd03.prod.outlook.com (2603:10b6:408:111::35)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 08:32:57 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::12) by BN9PR03CA0420.outlook.office365.com
 (2603:10b6:408:111::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Fri, 24 Feb 2023 08:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 08:32:57 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 24 Feb 2023 02:32:54 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>,
 <Candice.Li@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: map new capped and uncapped mode power
 profiles for Vangogh
Date: Fri, 24 Feb 2023 16:32:34 +0800
Message-ID: <20230224083235.3448477-3-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224083235.3448477-1-perry.yuan@amd.com>
References: <20230224083235.3448477-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|BL1PR12MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b13073e-6133-4a91-9c39-08db1641bb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+s9MR0SJUm0+Tyt85ADmWgq3lCqsgWipFRaCLpu5Y0CRLP5d7/4u+J+D5WMVFuLtZrcElH8hSeshH94cm926XYVOEO850SUsubPGxAkHuav3Ct9EaYHtzKhop2TV+3owoBuvQwXrM1RVYLF46Y+xfbgR3wdoEO3DpsK86toUqTHdxxUi9LLNJiqZxC7w9vMdYDZxbx0t9z4VKpBQZNWbm1AH3Y3vRJHDr7RjErJysEY6cyHD/y+6ODx6T3P/T+jPpdR/oi3hHKMSD9n2w5mVAPr774hn4n+4fU1ZpOB3HY+Kcz261oDFgpV23YqtMu1GLFIZG4Pqx+e2RKWMcIYb5rg3V9yGC+MAQMX7M0JjTPZ693ksCll28dzcIqanhCAQ/FfgXx1ZCbCEb2a/A5ifRqVE+LQCLS/MqFd8A1GxdeHXns1VwNbRmLnN6TObNecZ5Ah3IOzl+AoM3j78eOuA6GYacgOXoHuyDK2QWTPCzLDoqvi4eli5qOztHtMgyHZEAVF2UFwmkDE6Oe9TuiO6MGRKtPF4LgUyjC8PWX+Sc8uf7uhsX4ShYEl+FQGT88wLlhtb8hD06EHulHjljpzmiudsFHtjT5Qz4cXHA9kcuWSF7iW7oO9xFLvJ6lA5cokYGvTPX16EJY4ib2Fh6PmBDeR2Mq8vPtVhE1uHisUDQQ9yCmSGl1pBy+nApJ1478eSx97nAlXgIr/9d5ZcMy9o+6j5F+GwXT7SztMxMMdLTE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(83380400001)(316002)(8936002)(36860700001)(8676002)(2616005)(41300700001)(6666004)(4326008)(70586007)(54906003)(110136005)(1076003)(186003)(16526019)(26005)(426003)(47076005)(336012)(478600001)(7696005)(70206006)(40480700001)(36756003)(82310400005)(86362001)(2906002)(81166007)(44832011)(82740400003)(356005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 08:32:57.7828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b13073e-6133-4a91-9c39-08db1641bb8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
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
Cc: Shimmer.Huang@amd.com, Kun.Liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Capped and Uncapped workload types are supported, each workload type
has different performance thresholds and pstate conditions.

* capped mode is used by power centric workload
* uncapped mode is used by perf centric workload

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h  | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c            | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h
index 8361ebd8d876..21e6028a49e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h
@@ -238,7 +238,9 @@ typedef struct {
 #define WORKLOAD_PPLIB_VR_BIT 3
 #define WORKLOAD_PPLIB_COMPUTE_BIT 4
 #define WORKLOAD_PPLIB_CUSTOM_BIT 5
-#define WORKLOAD_PPLIB_COUNT 6
+#define WORKLOAD_PPLIB_CAPPED_BIT 6
+#define WORKLOAD_PPLIB_UNCAPPED_BIT 7
+#define WORKLOAD_PPLIB_COUNT 8
 
 #define TABLE_BIOS_IF            0 // Called by BIOS
 #define TABLE_WATERMARKS         1 // Called by DAL through VBIOS
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index cb10c7e31264..3673ba1a2cad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -203,6 +203,8 @@ static struct cmn2asic_mapping vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT]
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CAPPED,		WORKLOAD_PPLIB_CAPPED_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_UNCAPPED,		WORKLOAD_PPLIB_UNCAPPED_BIT),
 };
 
 static const uint8_t vangogh_throttler_map[] = {
@@ -1046,7 +1048,7 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
 	if (!buf)
 		return -EINVAL;
 
-	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
+	for (i = 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
 		/*
 		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
 		 * Not all profile modes are supported on vangogh.
@@ -1070,7 +1072,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 	int workload_type, ret;
 	uint32_t profile_mode = input[size];
 
-	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
-- 
2.34.1

