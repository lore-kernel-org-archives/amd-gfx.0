Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB98C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A81410F3E0;
	Thu,  9 Dec 2021 16:55:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BDA289F8B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 15:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETXhIsIIVfk+dxVrQ2YFeYziAboHz37woDY6NTrNzqfB8IKon1g0UwhmZjm3O+ApiqnWXZQxsTd0MAvVV/raIIxpnVtQ3vRCqMMcyJRUylNwschjVBi0bTMCzFHxC09wI4CwNNTAIBrnjhgp5NvwGZJB09rDzAFIYHeD7mvNFbJ6xdR4bJa5Aa6gq7kf/Il2yd4iFGUf/jmQTtJf/hJ3A93rtucm0GmRUZjdg8743geeY5frlPyLJE22Zysp2XfjUeW1nxgcfruqfTPB0qXF0+WRskjjMz9xA4tb4OmZInDVN8nDX1M1GRl9XCjBLqKA7BEFrgWzyoVJFv4QghbiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqJJF2woCy+yXFo7eNUl7zNd3LL778bOYrNKVOA3pHI=;
 b=DrBTDjCqvanAFiipZppePVYppyTf3hmVVeqDAXNKNHMhvzm2meHv+wwRcamn8JV41XZC6vcJLhI0HmJRCOqUlB6vI7GYy2PsjdwySa4Fa1wcONkguAS/BdshycRsgEjR3p6s/0gIq4aIZ6lWJtDJ/BIJ2oTMy5iZnoDsl5xx5EdyuN6CGJPvmYsFnT2v8/IrLOmVSYTvWsnVJLGyIyIhctAhgRaqCuCwz61ETT0/evduM1HZuGLizs79nB++K16xDqACtHTxki9N2Itd9/AcU2S0YkgPfnTaC9WlgQi6RLFBr4iEoBgqI72u9Hmcv1Ie54RdwBT+45zLRR+aELoBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqJJF2woCy+yXFo7eNUl7zNd3LL778bOYrNKVOA3pHI=;
 b=p6Qa95j28ZURkRhkVOLPQolPzEEdze3p2+RiWU9H/+AkkjZ+PpwDvdlcN7c+daitMcHnt+o67A5gXRU4N6+XnIOWBhaqf6F6UMAVcKcFPm9BFYnxNs5BbglIedusublyQAJfaYPYlY9aWc3B5qtmgI2ugCjgjZ+Ng8bDLKyhIP0=
Received: from DM5PR22CA0021.namprd22.prod.outlook.com (2603:10b6:3:101::31)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 15:47:51 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::36) by DM5PR22CA0021.outlook.office365.com
 (2603:10b6:3:101::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 15:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 15:47:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 09:47:48 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: Detect if amdgpu in IOMMU direct map mode
Date: Thu, 9 Dec 2021 10:47:14 -0500
Message-ID: <20211209154715.20956-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6589ed4d-70bf-4a71-252a-08d9bb2b41e6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4144:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4144F8788400BA618FAFF109E6709@MN2PR12MB4144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2dnaxm6wDCBfbQWGPOCgjK+SI0wnl7PzYuiEvzkE2m2LesPiLNv4wiv5Rh8+Lvx8xtId/ryLn/4WO+KZj2eqqWxWmUVceDAAoSeuvbxiv3nLkGeJjpEe3OD8VSasA5JS2nch7Oji6Yc6SLHtBItNN3oU1To5yi6CmWb4jOO+soNOJd1XJvZ7bZuc/XpxZALwsqSpnYrjHaGgINlKn0uI+wjXjkKnXBAuoeABWu4QblVTzl2u8bKSdWgKZ/vEuEa/ONfnoFonrZQtHq1FSlmCE6wdICR1ahrgPvQOZ87d7O6GF7TQNBXUMUe/E9wJg5qWQYpI20LfF6S4RTfkbQ4LJDEII3IOjqCtHahNgoVfL9MjsdcdtF1BDjmOgl1CP+zVxEhU9anGL9JFOMlTkRK7CM6KxoKtuYddnOyvHPYjYc17fDAA+zKEqv3juSUD0RcMyMfBw98zdXxJ0kHfbrV+qZThlVxSvnTkdEb2of1iAfuMr/XCTxocSPVyjXxL2jEMnGQ9WOyeVknsZp0kl9WIpZWC6xefebsSQ2STR2HMMH5TZhpHKMFvaXN0rkdkgvSv4UMEUalGQfRzdpVUbAN+92WcDTn+zWsz7A4RKqaJMk8XE8SgoE4FZzsyrWV5/AOK0lFQya/cOs7wqSYEhY+ppmflf3wnuUP2VVuNOrfSyzZCNT1PxIf48QN0Eh0URGY6hq+C2wC+/RcoEWNsNYlwqTho60bPqIWAGwLMZBG+xt9S1ST4eCZcak4cIBlfv7BkmqJ2iQHEEfLJEi+qXLdFNWrZ30w9xsKf9oIsOvde2w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(336012)(6916009)(8676002)(70206006)(70586007)(36860700001)(16526019)(186003)(508600001)(426003)(8936002)(316002)(7696005)(2906002)(26005)(1076003)(47076005)(6666004)(2616005)(86362001)(54906003)(4326008)(40460700001)(81166007)(36756003)(356005)(82310400004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 15:47:51.2357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6589ed4d-70bf-4a71-252a-08d9bb2b41e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If host and amdgpu IOMMU is not enabled or IOMMU is pass through mode,
set adev->ram_is_direct_mapped flag which will be used to optimize
memory usage for multi GPU mappings.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 54c882a6b433..0ec19c83a203 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1097,6 +1097,8 @@ struct amdgpu_device {
 
 	struct amdgpu_reset_control     *reset_cntl;
 	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
+
+	bool				ram_is_direct_mapped;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ce9bdef185c0..3318d92de8eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/console.h>
 #include <linux/slab.h>
+#include <linux/iommu.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
@@ -3381,6 +3382,22 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	return ret;
 }
 
+/**
+ * amdgpu_device_check_iommu_direct_map - check if RAM direct mapped to GPU
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * RAM direct mapped to GPU if IOMMU is not enabled or is pass through mode
+ */
+static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
+{
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev(adev->dev);
+	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
+		adev->ram_is_direct_mapped = true;
+}
+
 static const struct attribute *amdgpu_dev_attributes[] = {
 	&dev_attr_product_name.attr,
 	&dev_attr_product_number.attr,
@@ -3784,6 +3801,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
+	amdgpu_device_check_iommu_direct_map(adev);
+
 	return 0;
 
 release_ras_con:
-- 
2.17.1

