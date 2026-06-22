Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BA6CD98F2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 15:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B58310E751;
	Mon, 22 Jun 2026 15:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RN5ThrBZ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC32B10E751
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 15:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPSGiVPGZ6ZMj91GHZsVsf8wLaENIjcJj+MvLyi+CWZSZb6+NpuE6TACJwkyCycuw2lQUU+VZlA2QG8Ph74k7oOc1kTYu8KeaO326okWsz4Xzqez6+ovwRZp+rzMMZsYzTTB4x0ITVh4lGBUafy5oYJLtpvlVH78KmfqOGQhoYq54dloXzcgcpv9o/zICIPsSKblKUt1uC03AQ6OVCkxpbZU+IIu1gcW2FuhAY423rNiOQUbdj1vsRQmAx5+w77387xrwupOIJvSTpBu6oQoz0PIpzUV973zeN+ylHE5oyvfwPqm00MsmYc7lpBRNW2anQIOHiKleYkJ7hcPbE4kxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIm3S4+3aku0u0Vwvn9IQWbp1lhdZk8CTGQuvNw4Gk0=;
 b=pa7f9F1rTZwgu6C0eWOzfFlwpA6eSHHqdSc943djAxHtQCglTq9EMxn2gzMrd90PdHV1zzbCeSrE9FOe4BETyrKRYkNJlzVFIoVcGSDWxIzVYajoFeEQ3/H/Nlo6pRwdQw+Bi/x/HfRC0PlozxfGEAE8WX+O/HnpNyjw0IQhMb9zR8UzZnZ3Tx/65NasMYHj+RXu1XK1wWMM719BLOIJuVDhIg/rIzz7m56jHO7cNfY2s1phNmJxVthwPV5Y9pf5XqtYw5hjknH5/fbUcGFtf/x+7Zc+B7UQTaC/uY2EtNC9DKq4SDj6/tQarARb/0O22YWVj3EcyFZ/HoadrHu5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIm3S4+3aku0u0Vwvn9IQWbp1lhdZk8CTGQuvNw4Gk0=;
 b=RN5ThrBZ5yk+SjZMiMMkXnyvjoqxVt5nH7d0tDGpDsuFLV0fgnscqJUNO3M1ulgFfVlAEILIHrNG7dYY+ttcp76kDw07kQpFd06UuJ1YmFFhj0VGpSaPWzXVy6iL6PiBTv08Q6eLWwaUZo1ZjUu+zFysuVK3yQs2LjpPybLZbKM=
Received: from BN9PR03CA0552.namprd03.prod.outlook.com (2603:10b6:408:138::17)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 15:16:50 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::29) by BN9PR03CA0552.outlook.office365.com
 (2603:10b6:408:138::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.17 via Frontend Transport; Mon,
 22 Jun 2026 15:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 15:16:49 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 10:16:47 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: invoke pm_genpd_remove() before freeing genpd
Date: Mon, 22 Jun 2026 23:16:38 +0800
Message-ID: <5db799323a211d12937f69a1ba28d3c740bf2569.1782141279.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 364fc0a2-12e8-4c51-9e4b-08ded0714847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: y9wS7tL+Kldxog3eff5uLruBiCTtx3549FKmjHViPT008kpkL0/bO3YPX4p3fKzbXlQwUw7NQQTwN9ERo+tFYugrsNxbasQk4NDfbhJ453X3huv5xGjDnSKEl5BpR83XJntB3XvYDkyTnY66fFcCRLHdHWgeWsDgzIWfkqgX3JsN6OK05no0jEqFLtvoT1AJhJSTsDEHsfPWLZYcEEEzzWOPWQqBN5de1BF6nNm2mTphvNOSWdVudqTNfLZHnOJpLwbl6zh4L2UQ9cJsFytvweAVHzQTZ3AfO25AqS/JsQnm1SdnT38tIN+MdwUvD6vEgJ4mbzQxk7xRyLlOtxahnIALUVpAdQDW2ER9nLIfXS2YvrJVaBRMWGOl6g2wnKKltR3J4xMy13y8YDZhg6m7BrXtPFbhA7ouYyS72fsatigPmsoTyF+XxkE9wmQ2lHK0Y19rOZ4j0y04aSkldfWPx7CyROvhzdg8cKj1HWqiQ1BQ7I2+/eejYnE5bTmNHa0EWzcCW7dp5xcwC5omShYJeBBeW/jjDMp5lzxK/ZIbhwKHlePtxroiyg7fNwiHcVZUYB3jwRi8exff6yYnwx/P+X5d8EQYUT9mN13LFzkwi+GNJz31wVesHav75jV9zgSFkbWPTQ8n+36zekEarjVqNjHqjIn9LOWi1hJIlzlK6RTnnqM4RSTNbR9yikBw1HyOJSyyi5Z6r3blwoo6sbdB0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: plt8lSMRbugwfaf4wrwhlA9ZycFDltkBGDWAvtj+mEGMLdpYj+qwGuxBtS/Af7+weYbyi05UbHRw2VazYIJR/AJkTRzlvdnjw9ywpo+YDuPfHKCNkHqEn5tCXjBHk+V4L+wdE3ZsXMZQgHV+twgKAMs4h/pZ4WwE8xvyzoxGnxqIHThomXEzFVQ29d8CLduGfPACZXTNvNLuKCErOqg3OMjJrKmUlqMDT2+p7yCpI9aISgc3qL+DzDqWRezTEO14+45KeNr78uCQ65KR4x+5K9Hz3oIFFlUhUvV59sFNFLdaK7IeTB2Fxdx5T/2mdVbcz2gbXxUaLb6qkh7w6I40iOw/P4YNiRSI1s0vxW4KwoYidCH8AtkKDWjUpc8YmcKF1nfbJQjuguXMSWSzyhRQcxJ967RgXlPA7lYT+uOa27LDjDRCszSCWSFS3ARBg0B1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:16:49.5301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364fc0a2-12e8-4c51-9e4b-08ded0714847
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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

Call pm_genpd_remove() to unregister from global list prior to releasing
acp_genpd memory, and clear the pointer after free.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index c1307dfccf92..b0db0834bfff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -559,7 +559,9 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 	mfd_remove_devices(adev->acp.parent);
 	kfree(adev->acp.i2s_pdata);
 	kfree(adev->acp.acp_res);
+	pm_genpd_remove(&adev->acp.acp_genpd->gpd);
 	kfree(adev->acp.acp_genpd);
+	adev->acp.acp_genpd = NULL;
 	kfree(adev->acp.acp_cell);
 
 	return 0;
-- 
2.34.1

