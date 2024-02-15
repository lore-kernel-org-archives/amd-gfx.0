Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1EBC48BC4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468A110E89C;
	Thu, 15 Feb 2024 20:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ISmA9Ewa";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2230510E77A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tvemp6Yxpm15gox2PY4CIFm3K3kc86M3NWAuNHCgRX5dC5MWo45O9nzKpCHkciQbeJQq5lnvqoHhbS4HYrBsPFqAlVVsjaNZs3K86sNQhWBrecDY1I47ohGEfzbCJrrkYQOZA5OeIT6hxLYMIHfg/yIqvGeMyAIWL5WMdtf7YECJXVJK4+U63GfEmGN4FSgM5XNrgQBRN1DP+MPl8IAbZUOka+RdiyGBLUY2Jh+28zx2oFUSUWR50ye522rbPUOsavFekpOGZQY6gX/1vh1ycLuGcjbQnSWxCSEya0FWEzIk1HSfxYGKACvW/AEkUO6L9LYDtBMStIkPP4adGY+UlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sMx/1LbxqMCmAxSKfFO8ychY6qZhDqMP3K4YXjbeoc=;
 b=cM1IurttMJ6ZbeCzQp61FNpuHQ9oX6s9YL3KPjxguflNl63Q3E7IsmtZKBLfQ8/DwvN/D8sFFDwXU8A0sGu+6V7E3re6HpQgdGkJRdMv9uVn+Dtw415MIovl3+vQF1FFvAl9zWJ84s7CMNQHWbe4Scs/d+qfCywbWBbKnb+ArdHJ84kvv+oq37/ELJDGyCYQ3a5V3/XAa33PEvBBvM+ZxGu/m0ZUSm074wFPw0xUPEBeyS8AZ7pOBH/5nHsT9zYHopTkSRJaEtmSKVnvxurdtrvPGeCC618Su1c1Gn+esl+R9i52YFoxLAmBLfxdCBNAc1sWfDyuoqM6yim2Sf2Wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sMx/1LbxqMCmAxSKfFO8ychY6qZhDqMP3K4YXjbeoc=;
 b=ISmA9EwaUKf9MIe5E/LiBUGah233SROrFhT+KuMWJi6ciDg1JeMJa0zdIbV21H6AYKb51Ea40T8qG0fCszRQyXE9W2QdHsHKEtqYLjNT5S/5qId25NZGRgpA/EQApoQ+JkKegB7p40HehYHOkRRC0QN59juSOVndngFxfhOlC/0=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.30; Thu, 15 Feb 2024 20:40:23 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::a4) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 20:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:40:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:40:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 7/9] drm/amdkfd: add KFD support for GC 11.5.1
Date: Thu, 15 Feb 2024 15:39:53 -0500
Message-ID: <20240215203955.415314-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215203955.415314-1-alexander.deucher@amd.com>
References: <20240215203955.415314-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH0PR12MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 129fee60-3baf-49ce-52d7-08dc2e6655a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qVscm+mG6uK1vEa/V+db4Xi3PIvmvapAIJaVJrY4t/F+VGl4tFioamIijIejdaGACNFddiL+FKXo5Bu+KVRZixaqAcTLNIfXhRF0fU1KMsb0BC6uCs4WuylmG+TmAT1PAk24uTXfashdyBr1xdmnSHJl6ESiB1YiLO0H26T+1mig5BzKx38XiKbUmC5NV+WtICERqLd2IRHFJH8c42DrBvS8cq/RyGquLLrpkl2BwyP9nZ27UXQw9FCAtCkx7oOUCYldeRCyM2uffhyr/2IZmnAphMbNFdsH+eA7ehgEw5Ac0AoYzfstAmTBDpW6ODXkx6gx2eTplKT8iySyyh5PBqv4H16VXilEVJu2jRyKWEQiVddDkmk1hel8+216VXCQYeK2d/nqKHyJeMquXiPW3szTI05GDWrPsJ/ZdV4KpCs4pv8HLzE+y0iPofeBf1+MhwColuyGjiC10Xkhd1XB2f301dXoBnlSIwGpYvTXSu+7nb53tI0eA4eRCTai1PDRM+m8RLDvunJX/RfnJjRzIv41N/KyH6Ga79ZfZ85zWbBr14xSVloChezrhZpzrHUP31IlP7v3sg9Rf8F4AzYTinyATjwU4fAO5AU7nyja9ayTBHlH7PQVSbPPtqAhVI+nbYEULsqvxXZDLFwy8dQ+IW6d8aAzHbSrK1hff44O/M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(36860700004)(64100799003)(1800799012)(186009)(82310400011)(451199024)(40470700004)(46966006)(6666004)(478600001)(41300700001)(2906002)(5660300002)(4326008)(8936002)(8676002)(54906003)(316002)(70206006)(70586007)(7696005)(6916009)(2616005)(426003)(1076003)(336012)(86362001)(356005)(81166007)(26005)(82740400003)(36756003)(16526019);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:40:23.6866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129fee60-3baf-49ce-52d7-08dc2e6655a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
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

From: Yifan Zhang <yifan1.zhang@amd.com>

Enable KFD for GC 11.5.1.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 002b08fa632f..7f2ae0d15d4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1676,6 +1676,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(11, 0, 3):
 		case IP_VERSION(11, 0, 4):
 		case IP_VERSION(11, 5, 0):
+		case IP_VERSION(11, 5, 1):
 			num_of_cache_types =
 				kfd_fill_gpu_cache_info_from_gfx_config(kdev->kfd, *pcache_info);
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0a9cf9dfc224..4d399c0c8a57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -96,6 +96,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 0, 2):
 	case IP_VERSION(6, 0, 3):
 	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 1, 1):
 		kfd->device_info.num_sdma_queues_per_engine = 8;
 		break;
 	default:
@@ -113,6 +114,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 0, 2):
 	case IP_VERSION(6, 0, 3):
 	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 1, 1):
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
 		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
@@ -165,6 +167,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	default:
@@ -420,6 +423,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 110500;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
+		case IP_VERSION(11, 5, 1):
+			gfx_target_version = 110501;
+			f2g = &gfx_v11_kfd2kgd;
+			break;
 		default:
 			break;
 		}
-- 
2.42.0

