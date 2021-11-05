Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A57C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 19:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09CA61157
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 19:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B09CA61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA456E42A;
	Fri,  5 Nov 2021 19:58:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5644C6E42A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 19:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Re22+VnTLvQo1h9YyBxQ20BMhfx6fu6xGaGzwZ1qFR0vUsWmthe1y0wJbFVP0BcJeXRIG6hsaQ2hLPXswXEJat4pHg02vKf5TWJ6iQgh3pAiMoobLFZq5lXSQL0s3xyrR1hOsbbrmhOp7p1UK4tA+ngp3WlJZUgJZPGRFLTpOlGt9TTQS+UT2mJ8zngHtxBgURg7Yp2yZHChSSznwNbOKYVuKz05tVxv/wYoeiJtnFLENBGMGCft1UxpQyUc6DES30Maxjcxe+6RyS3FvpfAl1V/rgvCAyiU/4kRQsF9hTDnoQ1ToARdGL/T5DRmXdPuYA5iVXB3UZqwi6q/XGXwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz9x0Goz52XXKADAF8ZngQOL+83nMZxdTFSi5cMT1uU=;
 b=LIMzBsJw0uAxz1HHhe0fhJB4imMrlaO9/zWX01BAhH2+PJUKcS+EaPSmOA3T1egFrVMu8+SyCE+yznkNfSplEnBTcTjr95XRBCGWg3DpcA1fa6glCl4bKOodZMuwPd4G9DpqNNBHuDZ6bOvWYTxP3O1rCAqOKNlUWQmptovs1eb3oLNyOvl0+LZ7rRUwZVbOtsHjAi2MIo+8yZ/6ZLTaYdsCoDyxmu9MKrs+MJaISCyC2Iui6MeGSfXUQJ0I7bgt6ILMBoF0jwqfoe0tAF4TOnvsKlXik5Esvq5FUZYfeETttkw2gbzESBuF9FBP9IuxSZS7AE/QtN5QBfsKGtztbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz9x0Goz52XXKADAF8ZngQOL+83nMZxdTFSi5cMT1uU=;
 b=flBiLDxetXk1jnUd3WKk68sQvITWYfiheM1GUh8eKLqxiyuBXmMJs6h3etIsru/AaYBystZ5DOVa+meiK493Bj6sRoQVGAecCwnlvek5V8dzBGXgwlFMaMNmUXiMQTt9sFJcjDFHgs4EImCq3ZQPDp3h8zOAJmlu3+8mxpY9O3Q=
Received: from DM5PR06CA0084.namprd06.prod.outlook.com (2603:10b6:3:4::22) by
 BN6PR1201MB0258.namprd12.prod.outlook.com (2603:10b6:405:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 19:58:48 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::a9) by DM5PR06CA0084.outlook.office365.com
 (2603:10b6:3:4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Fri, 5 Nov 2021 19:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 19:58:47 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 5 Nov
 2021 14:58:46 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: convert to IP-based version checking
Date: Fri, 5 Nov 2021 15:58:04 -0400
Message-ID: <20211105195805.2275921-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a76e6dac-7c5c-45e7-5766-08d9a096ae3e
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0258:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0258B01EDAAB20DB217C0B7E8A8E9@BN6PR1201MB0258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PcLXRnpswDPbP3Cwq0XoZKWM1/2f1gZxmeCFUTYWxAJNQwR9y36RcoOM8Vj5TNeEUIgbxQA8CGjMaB44/GhHfWU/s0tsjSALhh33FLPjt7/ARAFbyo8xL2wAfnyiDAQ65lzL0B/MT4mMzM9hWOEhLi1nlMhFdDd3Wl7FHbZrmiLYfmsGuC1daBbaD0tPfkIIyAPM1zR7MJSq+Kw68Lb0abBa4pilnTvga/rSr6s5ruOPBy0XFpq5OWUxRi2Fv/SUWxCTSVs8aMSj+fCOi8219kpZ5hf8zbb8Rw/NvS/5aCftpqvfbx+IyQy1nMDa/ph/1fnu4OQl/q933nnRzQcLSGPrBNYCBclJOR1viC1GjlpKBvyL1czUPkDWqNpPIOKu5Z1C4jsMsYCbGXsNnSGf4Bemfld+4dFRWCj/W9Zsc2/5svZZIyW8tz9WCARN7W/5X7jIe94UmtFg0c/QBUdZ2rssXs0OoDhAk+5JS8LAByej7gkuwrm3yASd5ajgjkJj6SBojdWtrIEH0vpcE4a035ja+vFYnp/lPKewH1oIOD9yvJWfFWrs2kdyXXq801aHEhsL40s9ynoZIebCKndX/4MNSczOIBjw2ApyYac+vEVIfhxbHtQeutYKgkjSEaqaOd8EIffY6kcVOCq6zVljONa0M8yACfiVhRyC60kpZrKTPJVR/dngQdQ31Q5kSxD+kxa2/FwY/b1rz/XNG5GVbTg+P27uZXZ0r1R+6jNqiE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(4326008)(5660300002)(2906002)(26005)(54906003)(316002)(86362001)(6666004)(36860700001)(6916009)(47076005)(83380400001)(7696005)(336012)(82310400003)(8676002)(70586007)(426003)(30864003)(81166007)(356005)(2616005)(8936002)(1076003)(186003)(70206006)(36756003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 19:58:47.7626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76e6dac-7c5c-45e7-5766-08d9a096ae3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0258
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
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patches to change KFD to use IP versions rather than asic_type.
Converting IP version checking in main switch statements.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 124 +++++++++---------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  56 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  52 ++++----
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  56 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  54 ++++----
 5 files changed, 189 insertions(+), 153 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 1dc6cb7446e0..500bc7e40309 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1377,67 +1377,71 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		pcache_info = vegam_cache_info;
 		num_of_cache_types = ARRAY_SIZE(vegam_cache_info);
 		break;
-	case CHIP_VEGA10:
-		pcache_info = vega10_cache_info;
-		num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
-		break;
-	case CHIP_VEGA12:
-		pcache_info = vega12_cache_info;
-		num_of_cache_types = ARRAY_SIZE(vega12_cache_info);
-		break;
-	case CHIP_VEGA20:
-	case CHIP_ARCTURUS:
-		pcache_info = vega20_cache_info;
-		num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
-		break;
-	case CHIP_ALDEBARAN:
-		pcache_info = aldebaran_cache_info;
-		num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
-		break;
-	case CHIP_RAVEN:
-		pcache_info = raven_cache_info;
-		num_of_cache_types = ARRAY_SIZE(raven_cache_info);
-		break;
-	case CHIP_RENOIR:
-		pcache_info = renoir_cache_info;
-		num_of_cache_types = ARRAY_SIZE(renoir_cache_info);
-		break;
-	case CHIP_NAVI10:
-	case CHIP_NAVI12:
-	case CHIP_CYAN_SKILLFISH:
-		pcache_info = navi10_cache_info;
-		num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
-		break;
-	case CHIP_NAVI14:
-		pcache_info = navi14_cache_info;
-		num_of_cache_types = ARRAY_SIZE(navi14_cache_info);
-		break;
-	case CHIP_SIENNA_CICHLID:
-		pcache_info = sienna_cichlid_cache_info;
-		num_of_cache_types = ARRAY_SIZE(sienna_cichlid_cache_info);
-		break;
-	case CHIP_NAVY_FLOUNDER:
-		pcache_info = navy_flounder_cache_info;
-		num_of_cache_types = ARRAY_SIZE(navy_flounder_cache_info);
-		break;
-	case CHIP_DIMGREY_CAVEFISH:
-		pcache_info = dimgrey_cavefish_cache_info;
-		num_of_cache_types = ARRAY_SIZE(dimgrey_cavefish_cache_info);
-		break;
-	case CHIP_VANGOGH:
-		pcache_info = vangogh_cache_info;
-		num_of_cache_types = ARRAY_SIZE(vangogh_cache_info);
-		break;
-	case CHIP_BEIGE_GOBY:
-		pcache_info = beige_goby_cache_info;
-		num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
-		break;
-	case CHIP_YELLOW_CARP:
-		pcache_info = yellow_carp_cache_info;
-		num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
-		break;
 	default:
-		return -EINVAL;
+		switch(kdev->adev->ip_versions[GC_HWIP][0]) {
+		case IP_VERSION(9, 0, 1):
+			pcache_info = vega10_cache_info;
+			num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
+			break;
+		case IP_VERSION(9, 2, 1):
+			pcache_info = vega12_cache_info;
+			num_of_cache_types = ARRAY_SIZE(vega12_cache_info);
+			break;
+		case IP_VERSION(9, 4, 0):
+		case IP_VERSION(9, 4, 1):
+			pcache_info = vega20_cache_info;
+			num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
+			break;
+		case IP_VERSION(9, 4, 2):
+			pcache_info = aldebaran_cache_info;
+			num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
+			break;
+		case IP_VERSION(9, 1, 0):
+		case IP_VERSION(9, 2, 2):
+			pcache_info = raven_cache_info;
+			num_of_cache_types = ARRAY_SIZE(raven_cache_info);
+			break;
+		case IP_VERSION(9, 3, 0):
+			pcache_info = renoir_cache_info;
+			num_of_cache_types = ARRAY_SIZE(renoir_cache_info);
+			break;
+		case IP_VERSION(10, 1, 10):
+		case IP_VERSION(10, 1, 2):
+		case IP_VERSION(10, 1, 3):
+			pcache_info = navi10_cache_info;
+			num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
+			break;
+		case IP_VERSION(10, 1, 1):
+			pcache_info = navi14_cache_info;
+			num_of_cache_types = ARRAY_SIZE(navi14_cache_info);
+			break;
+		case IP_VERSION(10, 3, 0):
+			pcache_info = sienna_cichlid_cache_info;
+			num_of_cache_types = ARRAY_SIZE(sienna_cichlid_cache_info);
+			break;
+		case IP_VERSION(10, 3, 2):
+			pcache_info = navy_flounder_cache_info;
+			num_of_cache_types = ARRAY_SIZE(navy_flounder_cache_info);
+			break;
+		case IP_VERSION(10, 3, 4):
+			pcache_info = dimgrey_cavefish_cache_info;
+			num_of_cache_types = ARRAY_SIZE(dimgrey_cavefish_cache_info);
+			break;
+		case IP_VERSION(10, 3, 1):
+			pcache_info = vangogh_cache_info;
+			num_of_cache_types = ARRAY_SIZE(vangogh_cache_info);
+			break;
+		case IP_VERSION(10, 3, 5):
+			pcache_info = beige_goby_cache_info;
+			num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
+			break;
+		case IP_VERSION(10, 3, 3):
+			pcache_info = yellow_carp_cache_info;
+			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 
 	*size_filled = 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0a60317509c8..8a39494fa093 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1947,31 +1947,39 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		device_queue_manager_init_vi_tonga(&dqm->asic_ops);
 		break;
 
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_RENOIR:
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
-		device_queue_manager_init_v9(&dqm->asic_ops);
-		break;
-	case CHIP_NAVI10:
-	case CHIP_NAVI12:
-	case CHIP_NAVI14:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
-	case CHIP_CYAN_SKILLFISH:
-		device_queue_manager_init_v10_navi10(&dqm->asic_ops);
-		break;
 	default:
-		WARN(1, "Unexpected ASIC family %u",
-		     dev->device_info->asic_family);
-		goto out_free;
+		switch (dev->adev->ip_versions[GC_HWIP][0]) {
+		case IP_VERSION(9, 0, 1):
+		case IP_VERSION(9, 2, 1):
+		case IP_VERSION(9, 4, 0):
+		case IP_VERSION(9, 1, 0):
+		case IP_VERSION(9, 2, 2):
+		case IP_VERSION(9, 3, 0):
+		case IP_VERSION(9, 4, 1):
+		case IP_VERSION(9, 4, 2):
+			device_queue_manager_init_v9(&dqm->asic_ops);
+			break;
+		case IP_VERSION(10, 1, 10):
+		case IP_VERSION(10, 1, 2):
+		case IP_VERSION(10, 1, 1):
+		case IP_VERSION(10, 3, 0):
+		case IP_VERSION(10, 3, 2):
+		case IP_VERSION(10, 3, 1):
+		case IP_VERSION(10, 3, 4):
+		case IP_VERSION(10, 3, 5):
+		case IP_VERSION(10, 3, 3):
+		case IP_VERSION(10, 1, 3):
+			device_queue_manager_init_v10_navi10(&dqm->asic_ops);
+			break;
+		default:
+			if (dev->adev->ip_versions[GC_HWIP][0])
+				WARN(1, "Unexpected GC HWIP version %06x",
+				     dev->adev->ip_versions[GC_HWIP][0]);
+			else
+				WARN(1, "Unexpected ASIC family %u",
+				     dev->device_info->asic_family);
+			goto out_free;
+		}
 	}
 
 	if (init_mqd_managers(dqm))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 2e86692def19..6c56e43e2f7b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -406,29 +406,37 @@ int kfd_init_apertures(struct kfd_process *process)
 			case CHIP_VEGAM:
 				kfd_init_apertures_vi(pdd, id);
 				break;
-			case CHIP_VEGA10:
-			case CHIP_VEGA12:
-			case CHIP_VEGA20:
-			case CHIP_RAVEN:
-			case CHIP_RENOIR:
-			case CHIP_ARCTURUS:
-			case CHIP_ALDEBARAN:
-			case CHIP_NAVI10:
-			case CHIP_NAVI12:
-			case CHIP_NAVI14:
-			case CHIP_SIENNA_CICHLID:
-			case CHIP_NAVY_FLOUNDER:
-			case CHIP_VANGOGH:
-			case CHIP_DIMGREY_CAVEFISH:
-			case CHIP_BEIGE_GOBY:
-			case CHIP_YELLOW_CARP:
-			case CHIP_CYAN_SKILLFISH:
-				kfd_init_apertures_v9(pdd, id);
-				break;
 			default:
-				WARN(1, "Unexpected ASIC family %u",
-				     dev->device_info->asic_family);
-				return -EINVAL;
+				switch (dev->adev->ip_versions[GC_HWIP][0]) {
+				case IP_VERSION(9, 0, 1):
+				case IP_VERSION(9, 2, 1):
+				case IP_VERSION(9, 4, 0):
+				case IP_VERSION(9, 1, 0):
+				case IP_VERSION(9, 2, 2):
+				case IP_VERSION(9, 3, 0):
+				case IP_VERSION(9, 4, 1):
+				case IP_VERSION(9, 4, 2):
+				case IP_VERSION(10, 1, 10):
+				case IP_VERSION(10, 1, 2):
+				case IP_VERSION(10, 1, 1):
+				case IP_VERSION(10, 3, 0):
+				case IP_VERSION(10, 3, 2):
+				case IP_VERSION(10, 3, 1):
+				case IP_VERSION(10, 3, 4):
+				case IP_VERSION(10, 3, 5):
+				case IP_VERSION(10, 3, 3):
+				case IP_VERSION(10, 1, 3):
+					kfd_init_apertures_v9(pdd, id);
+					break;
+				default:
+					if (dev->adev->ip_versions[GC_HWIP][0])
+						WARN(1, "Unexpected GC HWIP version %06x",
+						     dev->adev->ip_versions[GC_HWIP][0]);
+					else
+						WARN(1, "Unexpected ASIC family %u",
+						     dev->device_info->asic_family);
+					return -EINVAL;
+				}
 			}
 
 			if (!dev->use_iommu_v2) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index e547f1f8c49f..0bee4b965e1f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -236,31 +236,39 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	case CHIP_VEGAM:
 		pm->pmf = &kfd_vi_pm_funcs;
 		break;
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_RENOIR:
-	case CHIP_ARCTURUS:
-	case CHIP_NAVI10:
-	case CHIP_NAVI12:
-	case CHIP_NAVI14:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
-	case CHIP_CYAN_SKILLFISH:
-		pm->pmf = &kfd_v9_pm_funcs;
-		break;
-	case CHIP_ALDEBARAN:
-		pm->pmf = &kfd_aldebaran_pm_funcs;
-		break;
 	default:
-		WARN(1, "Unexpected ASIC family %u",
-		     dqm->dev->device_info->asic_family);
-		return -EINVAL;
+		switch (dqm->dev->adev->ip_versions[GC_HWIP][0]) {
+		case IP_VERSION(9, 0, 1):
+		case IP_VERSION(9, 2, 1):
+		case IP_VERSION(9, 4, 0):
+		case IP_VERSION(9, 1, 0):
+		case IP_VERSION(9, 2, 2):
+		case IP_VERSION(9, 3, 0):
+		case IP_VERSION(9, 4, 1):
+		case IP_VERSION(10, 1, 10):
+		case IP_VERSION(10, 1, 2):
+		case IP_VERSION(10, 1, 1):
+		case IP_VERSION(10, 3, 0):
+		case IP_VERSION(10, 3, 2):
+		case IP_VERSION(10, 3, 1):
+		case IP_VERSION(10, 3, 4):
+		case IP_VERSION(10, 3, 5):
+		case IP_VERSION(10, 3, 3):
+		case IP_VERSION(10, 1, 3):
+			pm->pmf = &kfd_v9_pm_funcs;
+			break;
+		case IP_VERSION(9, 4, 2):
+			pm->pmf = &kfd_aldebaran_pm_funcs;
+			break;
+		default:
+			if (dqm->dev->adev->ip_versions[GC_HWIP][0])
+				WARN(1, "Unexpected GC HWIP version %06x",
+				     dqm->dev->adev->ip_versions[GC_HWIP][0]);
+			else
+				WARN(1, "Unexpected ASIC family %u",
+				     dqm->dev->device_info->asic_family);
+			return -EINVAL;
+		}
 	}
 
 	pm->dqm = dqm;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index ae7c9944dc4a..5353f43c67f3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1425,30 +1425,38 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
 			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
 		break;
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_RENOIR:
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
-	case CHIP_NAVI10:
-	case CHIP_NAVI12:
-	case CHIP_NAVI14:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
-	case CHIP_CYAN_SKILLFISH:
-		dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
-			HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
-			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
-		break;
 	default:
-		WARN(1, "Unexpected ASIC family %u",
-		     dev->gpu->device_info->asic_family);
+		switch (dev->gpu->adev->ip_versions[GC_HWIP][0]) {
+		case IP_VERSION(9, 0, 1):
+		case IP_VERSION(9, 2, 1):
+		case IP_VERSION(9, 4, 0):
+		case IP_VERSION(9, 1, 0):
+		case IP_VERSION(9, 2, 2):
+		case IP_VERSION(9, 3, 0):
+		case IP_VERSION(9, 4, 1):
+		case IP_VERSION(9, 4, 2):
+		case IP_VERSION(10, 1, 10):
+		case IP_VERSION(10, 1, 2):
+		case IP_VERSION(10, 1, 1):
+		case IP_VERSION(10, 3, 0):
+		case IP_VERSION(10, 3, 2):
+		case IP_VERSION(10, 3, 1):
+		case IP_VERSION(10, 3, 4):
+		case IP_VERSION(10, 3, 5):
+		case IP_VERSION(10, 3, 3):
+		case IP_VERSION(10, 1, 3):
+			dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
+				HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
+				HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
+			break;
+		default:
+			if (dev->gpu->adev->ip_versions[GC_HWIP][0])
+				WARN(1, "Unexpected GC HWIP version %06x",
+				     dev->gpu->adev->ip_versions[GC_HWIP][0]);
+			else
+				WARN(1, "Unexpected ASIC family %u",
+				     dev->gpu->device_info->asic_family);
+		}
 	}
 
 	/*
-- 
2.25.1

