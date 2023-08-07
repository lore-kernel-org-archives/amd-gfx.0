Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6F0C04FE2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 22:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E0410E38C;
	Mon,  7 Aug 2023 22:06:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04A210E38B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 22:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQJ2AN/egWsP6nnhcZrZaU5R2j7rPOH9+HvGWBBfEezbqWkW+P99uzeYu/uV5z+ahtMuOKrbaSfFQaL2jjeoO22ALMDm0wP12loFfGj2b7VF70ficzi8qAYDwO1HTn/AgiKXvh4RCFgwqiTXnaLMxj1XO5VfpzNMvNfpGZPgKTYOqg/x2Ovhqj7QzqRjOfZeCVpaf8VB9KlxA4m5XGadgsK7BvfwbOM1f7qE+JSv3wV74x4SdEoh1j/sYNt54UQQCZq4oJlTzHvGICV7n3GNCd2STBH4Y2lY4keOdHVoLP8VJF8AOP8x9iG8wSsOSoduAw0qzvXIaeoT/E8xmQsgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQJSFBZODO5amcixZM14BlDze7LT37vGVKsHKGpiMS0=;
 b=i6F/XNwM0h4mmRt76E52EtWsKsN/2yJuRo+nHSGmYEKVjU+52a9Cioh6wYSsk/YEZjMFOXWvI2ou9JN8YxnW8u3mKurqJvBGkmTuCYM9XQS9fBm6LgDqp6KnrDKt+taBpRkSG4LuJMIkuCOsxNi6vnbCALgD94qIa9ZyfqT0CA5SFJKbktxPqyqYDm5gffPGqSvMkQ2rd1ZC7TL5o2OYR7teVQ69QFzoENydHOTEqjF5sXIdVXfKQhcbSzlexh8B8GjR/xf05iqjHHt+2btm81fWeIsTwuQp3EKqiDUgCpSA7vCIJut7jxWK5g83+2RHM9iY2u7ACVkbiLtcDX/eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQJSFBZODO5amcixZM14BlDze7LT37vGVKsHKGpiMS0=;
 b=ReUVOMZEq1Lk4oB8uW0+OOX07zuFAMz9ymYfa42ur0V2dbTsUcZTtcFeWBOQBVkKPrbgxAazFjWiztMUdr16/mZsQx8yZnAL2JmkuqNXtNOFhbL+B7p9YrWevaopYDabq2uZ1JLCpCVDPYs8cZo5soeeZ8CHdyTp7SI6xEVPgVQ=
Received: from DS7PR07CA0017.namprd07.prod.outlook.com (2603:10b6:5:3af::14)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 22:05:57 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::88) by DS7PR07CA0017.outlook.office365.com
 (2603:10b6:5:3af::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 22:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 22:05:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 17:05:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/5] drm/amdkfd: disable IOMMUv2 support for KV/CZ
Date: Mon, 7 Aug 2023 18:05:42 -0400
Message-ID: <20230807220545.1320198-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807220545.1320198-1-alexander.deucher@amd.com>
References: <20230807220545.1320198-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: d382af6b-7ab3-4f9a-2f49-08db97927a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OICYiUXuMO+4rQOEXrqUNZfEihmrBArFEwq3Uooj9lg8gxSg7QbT4ryMOlwo0Jk95lz5RXaLrRHq1oGFjbXSey4TTnDnYwwpQm6cakyhO0wXTrW53Nn0cTLEqVGTJlq6bDoF9rwDkWN9Obhm7wZIWMygKqMmBmQQpD7m8s9GQb13lOFREkZ/3+wCMKq7t6qqMo5VdZXUbEtZDS4BDK3Pfu7LdXVhHuBtRThGJNWTQ4DuBYS+jqojOXyR+D50Ifb1qcRb3oYJa5UqLPMSrSMYB4e41hp+wU1AEsoJFv9ns3o/RJ3iH6ma58pJYEE5vtlY/dL+9tiYjITWOK0X51nTJWtNAlNzyGAJQPHzwxtw9GQb36W27GO5uQFyUvAM18q/oO7J4OUUnsgGIVZOWdJtuAQb/FAF6t4K3zjdi+U1MXZL/Y+0DJO1HP/JJVssXuAXAkalsQa9wHYJRLhWzGvmY4v+ByTqOUO7426QEF05KYfhcfhvtE6TBoiEHeRL8oEnkMhBTxEZcad96xTaTWMphjShRh65DsGNFcBJokWC74G/+9AbbyPlqprc4MmbPxUmM3CKzwc19/ApbZL6b1l+oCPFgZuFSi7DULTpDWUlrR3u4BYL5qqmEIohfZqdB79WODnpsvKj+xNdaAcxAiUbImGrxXRasTJ9/TQP+9pQRzk6wn6TdTx2udjhsicaOc/SpJ7T4xeVii2X8NguRrXO4A74hM+Eh+9rlKuHV6PiCXc45y5UpXHBTfhetltlVRTmT1zjQAdBY5HqXunPA4rGRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(1800799003)(186006)(82310400008)(40470700004)(36840700001)(46966006)(81166007)(40480700001)(40460700003)(2616005)(7696005)(6666004)(478600001)(86362001)(82740400003)(26005)(356005)(36756003)(1076003)(316002)(5660300002)(8676002)(4326008)(8936002)(6916009)(2906002)(70206006)(41300700001)(16526019)(70586007)(336012)(47076005)(83380400001)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 22:05:57.4599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d382af6b-7ab3-4f9a-2f49-08db97927a49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the dGPU path instead.  There were a lot of platform
issues with IOMMU in general on these chips due to windows
not enabling IOMMU at the time.  The dGPU path has been
used for a long time with newer APUs and works fine.  This
also paves the way to simplify the driver significantly.

v2: use the dGPU queue manager functions

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c               | 6 ------
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +-------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 4827aa72dc748..44d87e04677b4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -234,10 +234,6 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 		    asic_type != CHIP_TONGA)
 			kfd->device_info.supports_cwsr = true;
 
-		if (asic_type == CHIP_KAVERI ||
-		    asic_type == CHIP_CARRIZO)
-			kfd->device_info.needs_iommu_device = true;
-
 		if (asic_type != CHIP_HAWAII && !vf)
 			kfd->device_info.needs_pci_atomics = true;
 	}
@@ -250,7 +246,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 	uint32_t gfx_target_version = 0;
 
 	switch (adev->asic_type) {
-#ifdef KFD_SUPPORT_IOMMU_V2
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_KAVERI:
 		gfx_target_version = 70000;
@@ -263,7 +258,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 		if (!vf)
 			f2g = &gfx_v8_kfd2kgd;
 		break;
-#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_HAWAII:
 		gfx_target_version = 70001;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 05909c366504c..53b83ffe72158 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2558,18 +2558,12 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 	}
 
 	switch (dev->adev->asic_type) {
-	case CHIP_CARRIZO:
-		device_queue_manager_init_vi(&dqm->asic_ops);
-		break;
-
 	case CHIP_KAVERI:
-		device_queue_manager_init_cik(&dqm->asic_ops);
-		break;
-
 	case CHIP_HAWAII:
 		device_queue_manager_init_cik_hawaii(&dqm->asic_ops);
 		break;
 
+	case CHIP_CARRIZO:
 	case CHIP_TONGA:
 	case CHIP_FIJI:
 	case CHIP_POLARIS10:
-- 
2.41.0

