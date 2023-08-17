Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F23C2FC0F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32AF710E545;
	Thu, 17 Aug 2023 18:11:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9928A10E09D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1Y90kEUwCA0PBd56zwRHMDzoqlRY6CPWDhjM7v1ZVWpJabEVvd4N33hTEZHykJddFeZBf8/SEbdFbvyCNqIs6I+8qBLZUECLq0GIuVkeInX2nHF3hg7sWWZE/Vxmxq+4kvnLymvBzZgwLya9j63cKyl8hwNV8LwuEX/I2MZiXzNBiqgZBybLbbux3s34N8wQwGvIng0TE088VkXxfZzyUlY6HFqZnsln5ja0mkc1nR3/vgmv1dIzYzm/0GgURV8IW3roCok6r8CVjkmp1UmRuCLb13f+4FRIqRndKbG3uGiWF4dHn3vF+0Poc5wnLoKRan7q7bhroBqbVAi/Fo8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwuWSXNpO2QYQ36SMFZpKy844HGy0RVfOXVjXqzz74I=;
 b=IWt+VtMV3GDxmC397yxlQzkOj9UW8H+9vYbZy+6jts3N9+KRkGqsguGOeniNIJSPSsZX5qFZSbZXyCYj9LEne9EAJAFTzLXY9VsEc5ndzYEi7kCnw4YlS05L3v/oELNCLD6UNg6h+66YeZ9Ipx4cIukl1rwcLcD5iNCXPjAY2z/ik9GIMEzDN+XATuP5vrY7BFUW7VNCZQrC+8VutREGBnDbhM384iR6PqKlGK2UEYc8OXiinrQBQuI7pROlKDJrRjN7RfdYKtrKi0njAssXebY1oB0cNlI0nBnl4SM4JyPJF2P67k2MKFjjqTAsLhyBmrBYFXfNG7XGS18i8v6+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwuWSXNpO2QYQ36SMFZpKy844HGy0RVfOXVjXqzz74I=;
 b=xpDPqLulqZ9/y+aJvOSedB/adkdboy0dRZYy9t8V0PCo/a8OhCSpG29Jl5/sqcbhUBgYjZIe9rVccXbeugSw89T9D/qBly83auvSa/X7/KGoRYquMv4VwPeV64A0yMozE99MDYG+doIcYLMPO9JznEqpvg4qrPJwYVCl8iRg4nI=
Received: from SN1PR12CA0103.namprd12.prod.outlook.com (2603:10b6:802:21::38)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:11:44 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::f0) by SN1PR12CA0103.outlook.office365.com
 (2603:10b6:802:21::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 17 Aug 2023 18:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 18:11:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:11:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/9] drm/amdkfd: add KFD support for GC 11.5.0
Date: Thu, 17 Aug 2023 14:11:17 -0400
Message-ID: <20230817181122.1543473-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817181122.1543473-1-alexander.deucher@amd.com>
References: <20230817181122.1543473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: aaece3c5-6bf7-4521-f032-08db9f4d69dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjb2vWUjD8yj4X9Yjr5XEuGhWfMrN2i8moJURpjMGII/Opj3Fxxp8cbW86r10eZvOoVp7uW4sUQaOb7AibLQCn2fgRDc75KHQ5MQWL2r+aUAboGMa212wak49fVqOl1tZ6p5NvkYyU3ezvFyu8JNc9gd340mQQhjH1pzE3SsY4HEGn3mVFMykEGVgAb1WFJ/YaXU5kCq3IlYAe2aYe+w4eAmsFckx9D+spmj9sqPsyxE8odFp/FryIP9fNniOVv4GnXFp1sRUFLH0RzDZuUvxwg6B4FjtDKYvqALLUT4BOGha52adhST1UIeL1bTdp2D3FY8F2Zes/HEu7Ere1qcpqKNHJWIDtufvOCvhFI51t2d5LzeBYlyek2hXBw+yhvlm6E2dlpMh9BsSAz1ZanAxrK3uDzQDwPQwBgA5pL2OZy9zTc1MIenXFtBnWBEH5k2KmoPoR8gqXJmT+TJV8UcXxAE3xvUXm55Mn1htg7JFYdwGK3pKDFC9o6ejFJ48sKmXI8x1EhmkJ9UqkFfTbaTSR0U+Eh1ViwbA5Uuxk1OdS7iaV87qvCTnYRRePELGA5H5vtoIERaaB0txkOvhzw6ztpzg7UyiiifPovY45P1RbFspddqlDw+vr1NGisq2SCSgI8MS9q3XA20RzPo7hYJOphc2WpqToz6dJ+yM6uNlKCk/JyQ+ZhhQ1Y7LogIRpisko3aNAssvgjFlHpBzXpjDwTy6WdC6Gn0tQ9lzyyfPIvnQcKcjEnzWinIiVHfVM28VfjnDHnQ3kUeC3O1y1Dv0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(2616005)(5660300002)(16526019)(70586007)(478600001)(70206006)(7696005)(6666004)(54906003)(6916009)(316002)(26005)(1076003)(4326008)(8676002)(41300700001)(8936002)(40460700003)(47076005)(336012)(36860700001)(426003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:11:43.7695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaece3c5-6bf7-4521-f032-08db9f4d69dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Enable KFD for GC 11.5.0.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 86fb7ac7982a..2e9612cf56ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1522,6 +1522,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(11, 0, 2):
 		case IP_VERSION(11, 0, 3):
 		case IP_VERSION(11, 0, 4):
+		case IP_VERSION(11, 5, 0):
 			num_of_cache_types =
 				kfd_fill_gpu_cache_info_from_gfx_config(kdev->kfd, *pcache_info);
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 93ce181eb3ba..ab4a63bb3e3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -95,6 +95,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 	case IP_VERSION(6, 0, 3):
+	case IP_VERSION(6, 1, 0):
 		kfd->device_info.num_sdma_queues_per_engine = 8;
 		break;
 	default:
@@ -111,6 +112,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 	case IP_VERSION(6, 0, 3):
+	case IP_VERSION(6, 1, 0):
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
 		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
@@ -162,6 +164,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	default:
@@ -413,6 +416,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 				gfx_target_version = 110001;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
+		case IP_VERSION(11, 5, 0):
+			gfx_target_version = 110500;
+			f2g = &gfx_v11_kfd2kgd;
+			break;
 		default:
 			break;
 		}
-- 
2.41.0

