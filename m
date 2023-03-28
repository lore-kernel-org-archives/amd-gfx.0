Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C64C761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71AA810E92F;
	Tue, 28 Mar 2023 15:18:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EB510E489
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT6mSfuxhWa051Mw7S+QtCIeGns/8njLrdQaXyhK3QcIrhzDbkVSqgW9JaTiH8YNl39M/PmjrHe5p6uNKJiBQc+0GehgqIJ283ozqoOpdWic4U6zbmiWf5ZDwmo4kqraO5Didyv9Q95XpQJpgJ4fxUVLHVeUOh84tAOh89DWEP9OCRpK07l9Ekr9qkG319+uYMHF+vNPvhxHmHt+yJoh4c1245azO/1G+nRkLPkFoUbTAiDMfLoMpqQHpYR4aeIas/pQIlPiYr0XEDaqw0MmBCCipXmLW97wAAKHXnmXnf1ybU6CVgC0qg32010KFOBBfHpS5XLe2whXAENVxr3PgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ca9s1hClSJVmeqrEoVOghhmjE57xCQxy2M1slkU/K0=;
 b=ApkQcCnE7sePdGHL6unNvwUnYZhfus46VFrtHAdT5wlK9uzkUqamGSaVr6+jDn5LoKIzJuwynwdDeH+TVypSEMj1IqvBMoaMIWTZdk73JJ75UwyK64yWJ54SQX1Y86aC50MgDBoHLdBGntcOqFVfuU35/T+kitfzrla+unMLi/3/75R7TRqd4LZpCZ20xb/4l93MDoizamrMmlSjRjhDj+IXn/7U3GSKFTVLRmsfEQ8K9EVSI1RrH0WTKYJJ5azsvVzwDfrFDe+f0e1sFWkcyjm6DYhLjcpCm4VaTdtVK2Uy7iENtxH12WPLlD00/1n3tuWIDRSKMHJr/tUNTgHnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ca9s1hClSJVmeqrEoVOghhmjE57xCQxy2M1slkU/K0=;
 b=PQLT87l7SMnHg5U19nduVmyM6XvzAEv/b6OhpBkYQBNfiYokQjABKn/NIpJHwi8nMpbGK3FhtANbOGSQ0J1DiTFkSQNVMzNtLZI0cB1YHFJ/ctGkl92ERKXvl7oNuaTV9cTIFR+G9ENDQ67iNM2D4Mz+tBkmWpQ+M5UiVW3weuo=
Received: from BN0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:408:142::33)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:18:40 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::c0) by BN0PR08CA0011.outlook.office365.com
 (2603:10b6:408:142::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:18:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:18:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdkfd: Populate memory info before adding GPU node
 to topology
Date: Tue, 28 Mar 2023 11:18:21 -0400
Message-ID: <20230328151824.1934600-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151824.1934600-1-alexander.deucher@amd.com>
References: <20230328151824.1934600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d07358-42a4-4815-5548-08db2f9fb5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBsghRpzrZFcEsvVoXWeNS32qHPz2uM2NWX19wUJv5+uJoo3V7CmR/Aq/xE4vBOvlxlTUd27Ia3sVGb4JZiXcut1m47MqWKQuadIHerLAcuC5xRipjTIXQXwP0D8DXgiHTV+0HDXEBZd1ZvnGohVelHCqm1vBuzFjkCpB0w/90KqaKS/nmU4JxA3NLVaBFI/LMne6HZdQq2nuDjdUjjxfItyAbZUC+QEu6AOPnaMX36WUcoi8BHRlluvsieIOWcFTY4i3cWB+IvbFfu/nvOoIREBuseQDCZUgCPnZTyWgMXNOUUIoODTlMLdejcwXcpYQLYuRjZyH72I6T71d3qi/is9JhPlXPq4mxHlNh42a1lQYGuDVqIlQqgTNlqSY4p/C+HuUpvcV+Y/DnL9oL7fm3N9I6Yvx80eMypLtBkvgqggFAKZNE5xJpCljMpDeFFl78GY11M0ntvGElpdZs+BSJPnAMDJ+Jqnh1eMIPsIM7P7b367hOmippVs/Ia/NLcgH3g/ieKd9leA2gZUPIo86sbWUYPTZ9hCVdk0AruJPhABA8BoFFSkvnJQsGwuGZRmf4WmWxJETdMFTl93Ya0lsxqan0y3O95KcSkCOj2eFIN7S5GF0dN8Th13M373RVyNfzYiSg2EevRb/AbZqmPMfCuuIeL0yN/6QGEyJAU4lFpQmZ0aSkTf8BqmHYWG7rsMsRmCsNjqOxOQdIKiDJ+iv27SDoKNHXJR1VznxaLhhAs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(336012)(2616005)(47076005)(426003)(36756003)(16526019)(186003)(26005)(1076003)(82310400005)(6666004)(7696005)(86362001)(478600001)(54906003)(316002)(36860700001)(6916009)(41300700001)(4326008)(40480700001)(40460700003)(356005)(82740400003)(70586007)(70206006)(8676002)(81166007)(8936002)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:18:40.1804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d07358-42a4-4815-5548-08db2f9fb5f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

The local memory info needs to be fetched before the GPU node is added
to topology. Without this, the sysfs is incorrectly populated and the
size is reported as 0. This was causing rocr tests to fail. This issue
was caused because of a bad merge.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index cd1aa711dd0b..1b4f3d34731b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -735,6 +735,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	node->max_proc_per_quantum = max_proc_per_quantum;
 	atomic_set(&node->sram_ecc_flag, 0);
 
+	amdgpu_amdkfd_get_local_mem_info(kfd->adev, &kfd->local_mem_info);
+
 	dev_info(kfd_device, "Total number of KFD nodes to be created: %d\n",
 				kfd->num_nodes);
 	for (i = 0; i < kfd->num_nodes; i++) {
@@ -785,8 +787,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	if (kfd_resume_iommu(kfd))
 		goto kfd_resume_iommu_error;
 
-	amdgpu_amdkfd_get_local_mem_info(kfd->adev, &kfd->local_mem_info);
-
 	kfd->init_complete = true;
 	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
 		 kfd->adev->pdev->device);
-- 
2.39.2

