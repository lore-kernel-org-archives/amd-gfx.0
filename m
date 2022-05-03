Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6C2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9070810F532;
	Tue,  3 May 2022 20:51:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547A910F527
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMPilhONxgpJrwVg/OKaVV+IZNDsigxMh+0IMgsrb9KQeN3xLu68LQD7rFLdQHLkkeRQO2Vf1N8Pesv0xrMP1DXeD+M68+cYyfOB5/tnjYmDn7ADIxxFVXu8OoK9/wGDysE5OlaoOcJ1icsjGZO1Fy3Ut5L+DY0F8FAKaXbobdRuu/VELWYCBcmRUdAFbhXbxuHQkRBHEoGcjoQ0XjtX1dvuqlpNzfunFvFUFuntQfZkhTi/9P24dPcpNl6wpcvSBpEQpdQ1KaLnL1wFSTzih3aWo0luYYTT0/9ZnEtm5WIgn0kmSBLGsEdM9T7VuP8GxP7/j63J8ohJZZapTWcJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HIPBWhO2bB2mrQZKFjPztJNcvNUbPuwDMuS3X4ZX58=;
 b=WQMBDcE8TkOuLr/gTWFgYaQPZ+6FWrmEApaOIA5lbf4rQq5366eggHkPTDLbGug9p6y1d82f0k0CCQ2o3nWDP/GQiI++bxHxLeQMmxGI7l939+tdR2g3/xCAs8Ie8Wxe/uifNS3PFCtU+hTxn61W0LNPEYb+q/bYF+pjKSjynfFjjKDu15FOy4ABGq9KImoeV7Sc2qs8LAd0KQr0o8+ntAYl2xSslYbLFUDLi7/sG8y4/I9Ckm21t760znQSxeHaNvc093WPnr64qWDAEvk9g59sCh7QAa27Xq730Wx1T2w95XzOGJCSe8Nnx3rqa1o2yPXjgu/oBePrLOGKqX1X5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HIPBWhO2bB2mrQZKFjPztJNcvNUbPuwDMuS3X4ZX58=;
 b=HffrrtuQxGbCuk7otqPZhVH5Stj7PgPfewWBDkDRnSOycA6Qa76Cr0VGcWry5MIlxAVxc099OBhIC66WXT8ppithG8rR84FrxUScEyoWuwaqqyYeR3vcaxNcmEZS4Ej/EmmnM+jJe/TwwDUJt5Fm/zUV4lmCWOCzdOinTsXIOrY=
Received: from DM6PR08CA0055.namprd08.prod.outlook.com (2603:10b6:5:1e0::29)
 by DM6PR12MB2841.namprd12.prod.outlook.com (2603:10b6:5:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Tue, 3 May
 2022 20:51:33 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::b0) by DM6PR08CA0055.outlook.office365.com
 (2603:10b6:5:1e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: add GC 11.0.1 KFD support
Date: Tue, 3 May 2022 16:51:09 -0400
Message-ID: <20220503205112.1285958-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ccddd63-23b9-42b3-ccb0-08da2d46b4c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2841:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2841EE68DE20220DFD84C4E0F7C09@DM6PR12MB2841.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bH0gQO+lK6Jf6P1woJxyOzEYL2+SEYhGT9zjpGA9SYGM0bOh3ZhzEnoI/KlQwzmBrDTseYrvIt9CPFqelbroEM12vN7A6iwoEUxkRHqSdRRAOAH6qF1Y3ZuMCEHX+WjgE4/1DHImyqezRSjW/I4hneRU+i8Fc0Sz8jQCwAMjw7+IsnB1I1yPoVGgk/ETH7oP3VL9/o/8SBt5zENrjjohsivj8M2Hqe3uFuEOlSEMEuMGNCGsXccYZmFJ53QfWx87PeFVfVxUU5TZLjaK4bRrRIkQLk6MtcRDW/3UL0oMOubgX8g3zAFmnvWuchpnaFTadQHQqyxvM1w156VCWvbt6R/BxFLsY9mO/QiP0Itd0ryPlrf14NvJpcMa39/W+lGW0hcnO8cSNXqaYwjVNt2hn+/ItgubDSCRFy0kqi15DDsJafWnslkWc/d7ocKZHgty0qWSriSopQFTq5wW14e9y0auusDcTXvruG1Z2ofnyVKKk31cg0Okhth8d4aepJnHB5ICInm4QrWmKKqjcJkx7YW1wNUzTMkJYhxpGfR4gamJcZo1wz4UkoDMIcZBbQKd9W8lrBhdk8jVMMOuSvxhkLgZT2ZemZ2HA9Xn2Bv4yGfXU9+O6ftCbA06qc7o6bwhScIWvEuH3GTMu8JiOmP3q8F95sAgwMWhekw50rqo/sTlAGgEYWAE2WwNGrjmHALWo2MpnviXALUXkVfrSe6teQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(316002)(16526019)(186003)(5660300002)(8676002)(7696005)(8936002)(26005)(2906002)(82310400005)(356005)(36860700001)(40460700003)(54906003)(426003)(36756003)(336012)(47076005)(2616005)(86362001)(70586007)(70206006)(1076003)(508600001)(6916009)(4326008)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:32.9362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccddd63-23b9-42b3-ccb0-08da2d46b4c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2841
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add initial support for GC 11.0.1 in KFD compute driver.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 765602a2cb47..5e9adbc71bbd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1520,6 +1520,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
 			break;
 		case IP_VERSION(11, 0, 0):
+		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 2):
 			pcache_info = cache_info;
 			num_of_cache_types =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index ad41e6018ccd..f1a225a20719 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -73,6 +73,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(4, 1, 2):/* RENOIR */
 	case IP_VERSION(5, 2, 1):/* VANGOGH */
 	case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
+	case IP_VERSION(6, 0, 1):
 		kfd->device_info.num_sdma_queues_per_engine = 2;
 		break;
 	case IP_VERSION(4, 2, 0):/* VEGA20 */
@@ -99,6 +100,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 
 	switch (sdma_version) {
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
@@ -137,6 +139,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
@@ -369,6 +372,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 110000;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
+		case IP_VERSION(11, 0, 1):
+			gfx_target_version = 110003;
+			f2g = &gfx_v11_kfd2kgd;
+			break;
 		case IP_VERSION(11, 0, 2):
 			gfx_target_version = 110002;
 			f2g = &gfx_v11_kfd2kgd;
-- 
2.35.1

