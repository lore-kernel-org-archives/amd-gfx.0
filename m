Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEADEC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 14:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69DB210E002;
	Mon, 20 Mar 2023 14:09:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264F110E002
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 14:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEpA/35IJ/CTeULsNEztoc8dMjlrauy0T0Jj+s/rN2Tosd2S/KelCqwPGu68OSXg+5/oPhcq8okUE23J/mGt7pFJfZtqMZXwJV4hYl+7PHcj+81uwO1Zxon8uLuUsltkoDgO+iwHOxhetKOgidkvq5MUBsk9V+Eq1UNHrkkWYs/NfDpQUKmnexztwHpTwY9MDUlwV/wAKuwhh8JANK+gJ5lDRIwoY8vANILLuqlrHRJh3XtyB+LZXQyVGHhhdq3ED1THgMsDcWCQVgf4qFpvkHapfjd0ukgoroKk1mnxhH5fa0M7NvKqpE/d1i+fPWWEhUKWlIV4PZ/LForHE7aW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vbk7fwnfBd7g8Vyl+FkuSxhD6IgQYszsoQNgCgR5YxY=;
 b=crK9tCo17Fpqvza86DcCXlVX0X1C2+bENy4DIEjNZKLYgqyN+tT04B6K48zYgha3xXjeHqLEnS5QXDNtqI2CsIoBV1OODfU80ZqOrrUWVX92dlW5bUdBNjbHpWZxKW/M762NZlU3GZmRpvbKxDRF06lj917ZC9IxDqAqnyK/8whQ9wwIMM48JGxTEYLPtArXkaqAo3HuJmd1gYPXwJb+fIRZr0tcjb5ZTv9Zu5Hh6IDSuF8PkwJxfUfZe/eBnG+cJfGsSmQXk8PyLuOSAM/icazRarjSHBRyIRvJSdzFdIhEvyyO7AtUbUTZHX4z/1fIkTWuXoVThF5aJFoBAE2U4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbk7fwnfBd7g8Vyl+FkuSxhD6IgQYszsoQNgCgR5YxY=;
 b=k0UYaMx34VMjAlsKMg/YzvYT+fnL23H/IrFSmA6j13casl2KHFODVPk6ZtypI/bIHChMoC2Bt3OqKRsDsD4VUZlauXhKNhUgg45snCacSVpXebzuaC2qokWvkZ8VnFmni1rF+dPu2xohl46kmLQn2PFMG4rUamKeR+XEd9+zbH8=
Received: from BL1PR13CA0434.namprd13.prod.outlook.com (2603:10b6:208:2c3::19)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:09:50 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::9a) by BL1PR13CA0434.outlook.office365.com
 (2603:10b6:208:2c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.15 via Frontend
 Transport; Mon, 20 Mar 2023 14:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 20 Mar 2023 14:09:50 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 09:09:48 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: add print for iommu translation mode
Date: Mon, 20 Mar 2023 10:08:58 -0400
Message-ID: <20230320140858.1420216-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e86a54-a62e-4e02-81d9-08db294cc507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKXITmxwUD0Uc9WgCjY4IuNPT2A0oVdir6IuutYyQ1ugnUtGUi81P+7hxj3d2jEPN3W70VJl0PcspmFU9f50OuzoHmy3L0awS4oqkocby2rAhHKF3bhtILccQzHfaQtBgw76IMdHGEdYPlf2Mb96dR/brKo5Ojy2lodoyHnR+9BXosF7+KcNsRkZIyvPhqS3cLFPe3fYHmwZ3nxjqQQF87tc6W5Abl78TjRDe7cbDeU+sQoFHtDgpa1FHEdJamiLs3dWWDcLq0QLTBSb4t2/Lt8tI24tV/uwIMwE1pz5GQdThOAbR0SMAVe+UraI2qPe5HEPycyI/8M43e2Gi+hJ2Mmb7dEkmPfZw73WrzjlPsKCgHlvT/QV5dfl25IgcUVFBpFH2XJnKRvNJG+HovX4lOoRBiVJr/+lEoLK3c9KhXQMFRAjqnvV68Xw9F8FKovVwWDCPyQY7O3KN/onuCdJv6GhpPQDhR8uy79i4ISl3tM0ND+t2Vo7JQ4ebn/dvq2yyhSPrL1zp+vSRy4GW7KprbEY2wNKCLRliCkw6ysdjzOONghuOByO1cwNh0/Z3c3Tv5pQJVkeA58ois7WxG09/sjBOIBSamg1K3I+Uo8k2bwn4uGOPZVyxNSWGvccghRm7FKgDqo+DVwRPU6IB8pptAHUslFehjdgdG7LDnuPUsBjECzwZNF+fI1cQb8lOnWp8Suvs44OetkokEvyXLPI5cMMXwZhIlewniGjWrVJ39s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(316002)(7696005)(54906003)(6666004)(81166007)(6916009)(70206006)(70586007)(8676002)(4326008)(336012)(478600001)(47076005)(82740400003)(426003)(2906002)(36860700001)(40460700003)(2616005)(41300700001)(186003)(26005)(16526019)(356005)(86362001)(1076003)(8936002)(83380400001)(40480700001)(36756003)(5660300002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:09:50.2445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e86a54-a62e-4e02-81d9-08db294cc507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027
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
Cc: Felix.Kuehling@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add log to display whether RAM is direct vs DMA mapped.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3bd6c5aef796..83774824694b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3528,8 +3528,12 @@ static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
 	struct iommu_domain *domain;
 
 	domain = iommu_get_domain_for_dev(adev->dev);
-	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
+	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY) {
+		dev_info(adev->dev, "RAM is direct mapped to GPU (not translated by IOMMU)\n");
 		adev->ram_is_direct_mapped = true;
+	} else {
+		dev_info(adev->dev, "RAM is DMA mapped to GPU (translated by IOMMU)\n");
+	}
 }
 
 static const struct attribute *amdgpu_dev_attributes[] = {
-- 
2.25.1

