Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97302C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 22:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6683F60524
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 22:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6683F60524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BA26EC78;
	Tue,  9 Nov 2021 22:43:41 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD3C6EC78
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 22:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTtFoGBg388ef9iPaOIRbQ5z36augdbtpDorC+GFAyaW6RVeEFVj+NPkF42GkO25xE17s0EUIfr/4n+yaYOQdoYu8Q/YIOOdSkidcrmYx3mBW9nfQUop0J+pFGOGh4JQds1F8Jl73lqej9kAJRIjzfe5PDVjW+F/l5q4WzcoACAPJIIjCKkzpJKpNHlDy+8b5szXIXWK+hSQD9QrCv5ViN5qZtOK9SOcFXtD7dp+ATAzTov67XSvH5OjpSuP7Y2mXPqemOT+kjplXy08qL4gnCO4XOzt2ItYDZuL2P5frGbvvDwBy9WTEJbUE1Vy5rpe70po1NGfU7Se3nB4yISb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2A0/K+hnC4o70AATa1Iwz3P2th15lAsHBGlKeRI3k0=;
 b=bYMXwtGihp7kNgle54gZYwySxl+U268OUlGTEOzbDMSwYrbC7Xht6r80XUtRRfOqmZfQXWQOcygelMOQyeRBnWZeA4dFsG2GMECKNWu1F7URicq5x2cDW4ULib5iISKMFxWIjnUSBQVYapcSQSdSS3FJSCwSexLZsqEn/ZohhW7NfZeKhChcdkCA3x9yiXSa0y4/1j2spFT+LF/922al95k1L9zn4c4xEqvGKgbKLCV1DXr727Nvf8e6t9vpoCefLCaIpxbB0RyrmqYA4uWSfUEJSydkQFQEGzJRy0C3oIiJm56+n51UL4Xw68XbFt/spwhzvkZWNKggQb/Rgm6M8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2A0/K+hnC4o70AATa1Iwz3P2th15lAsHBGlKeRI3k0=;
 b=p3kzQpIoRdipQWM+HUcRGJzg5zH4+gqteY6ea8q2bceumF2YLb9LiIvrCTvQ1x2nQjDPE5J2moVhEaDTZZzk5miKo4+Ud+ab6mpCkZeyOLthrSnAayibsIUkXmMU/PPA3o0x4wcjFYVre+KFbzcQEj/zKe04eGIRBiFBx/qtHko=
Received: from MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::21)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 22:43:37 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::65) by MW4P221CA0016.outlook.office365.com
 (2603:10b6:303:8b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Tue, 9 Nov 2021 22:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 22:43:36 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Nov 2021
 16:43:33 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdkfd: convert switches to IP version checking
Date: Tue, 9 Nov 2021 17:42:50 -0500
Message-ID: <20211109224251.3484398-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109224251.3484398-1-Graham.Sider@amd.com>
References: <20211109224251.3484398-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59c85c93-7d73-477a-1e59-08d9a3d25e56
X-MS-TrafficTypeDiagnostic: MW3PR12MB4364:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4364B173BB32708F650B085E8A929@MW3PR12MB4364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:21;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmT5MXWrq6S9T74VQwOVJMgNjnvbbKkejQcjsqPU8lsdc0bt4iOo5LVqCDgG+dWze/JUPaVmfbcmNExLGuTm1dKFoHxGKqf6mX2q1xrgAnyPo/QlfEZq7y2h+MeevKInCRFBKV0tsiiYtFTmO8SPSxKlj+rT5p+MWyqhcFWit6hbRl3+/TWHnPHysDg13MXBPhRA526PydMg+x1BDNv53FzCpMuf3tneXAHWWULzDSpQs8mSfcu5mBS5UrMcC3zwbJOMyk/+np5g/WP1ogKrE40ttTRu5Ku/g6PDLS7TyGQEN9niqJHqn4JJpKi/xfeqt3dMWX/RqNp8h/wEVEEXFiCQhtWDQ0YNiabCnN4OjZtHzL021J+vJhmlE2XH7cIL8TFgMuQSHB6tOk7KH6dp8xwjw7CZhOHZnbKdU+S4lV2Vz02qdheiiLwIErssR+OibWJEPkjxeN+9D1FOimS2bMLxW4GQty46h13VBO60aojc/QFdMqqSxpsIA7UPcH5qiLgTJ8Itd5FKTo8ZGZawkHz1c7/BLwbKl39lvCtoW87uSD1gyrR4D9TWfiFbChsMigReKNfgsQtKHGnrLnD6pbliNftpcebFZLX2kfcbQeO/QfKQQXDpgVH8eZ2NNU1gjzL2hZT/1vP8prAKtdY/brZ0pfHdNk6jb67BIOMPN7rEF3716FZmCTYy+x3+LGihBSHX93VsW9BXqnrrLrNUYKiGS+lmjbKZlRF+iZ2xcYs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(81166007)(316002)(6916009)(47076005)(4326008)(70206006)(8936002)(1076003)(30864003)(508600001)(70586007)(36860700001)(8676002)(7696005)(356005)(86362001)(2906002)(336012)(36756003)(2616005)(186003)(5660300002)(426003)(6666004)(16526019)(26005)(54906003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 22:43:36.9068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c85c93-7d73-477a-1e59-08d9a3d25e56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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

Converts KFD switch statements to use IP version checking instead
of asic_type.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 124 +++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   8 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  33 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  29 +---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  33 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  30 +----
 6 files changed, 102 insertions(+), 155 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 1dc6cb7446e0..19dd472e9b06 100644
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
+		switch(KFD_GC_VERSION(kdev)) {
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b752dc36a2cd..ee813bd57c92 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -814,8 +814,12 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 	}
 
 	if (!device_info || !f2g) {
-		dev_err(kfd_device, "%s %s not supported in kfd\n",
-			amdgpu_asic_name[adev->asic_type], vf ? "VF" : "");
+		if (adev->ip_versions[GC_HWIP][0])
+			dev_err(kfd_device, "GC IP %06x %s not supported in kfd\n",
+				adev->ip_versions[GC_HWIP][0], vf ? "VF" : "");
+		else
+			dev_err(kfd_device, "%s %s not supported in kfd\n",
+				amdgpu_asic_name[adev->asic_type], vf ? "VF" : "");
 		return NULL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4f7aec6a481b..93d41e0b9b41 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1947,31 +1947,16 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
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
+		if (KFD_GC_VERSION(dev) >= IP_VERSION(10, 1, 1))
+			device_queue_manager_init_v10_navi10(&dqm->asic_ops);
+		else if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 0, 1))
+			device_queue_manager_init_v9(&dqm->asic_ops);
+		else {
+			WARN(1, "Unexpected ASIC family %u",
+			     dev->device_info->asic_family);
+			goto out_free;
+		}
 	}
 
 	if (init_mqd_managers(dqm))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index d1388896f9c1..fa3ec3ed7e39 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -406,29 +406,14 @@ int kfd_init_apertures(struct kfd_process *process)
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
+				if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 0, 1))
+					kfd_init_apertures_v9(pdd, id);
+				else {
+					WARN(1, "Unexpected ASIC family %u",
+					     dev->device_info->asic_family);
+					return -EINVAL;
+				}
 			}
 
 			if (!dev->use_iommu_v2) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index e547f1f8c49f..88dc0e451c45 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -236,31 +236,16 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
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
+		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 2))
+			pm->pmf = &kfd_aldebaran_pm_funcs;
+		else if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(9, 0, 1))
+			pm->pmf = &kfd_v9_pm_funcs;
+		else {
+			WARN(1, "Unexpected ASIC family %u",
+			     dqm->dev->device_info->asic_family);
+			return -EINVAL;
+		}
 	}
 
 	pm->dqm = dqm;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index ae7c9944dc4a..a4c0c929444a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1425,30 +1425,14 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
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
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(9, 0, 1))
+			dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
+				HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
+				HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
+		else
+			WARN(1, "Unexpected ASIC family %u",
+			     dev->gpu->device_info->asic_family);
 	}
 
 	/*
-- 
2.25.1

