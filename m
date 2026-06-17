Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8C3CD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 12:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330DD10E841;
	Wed, 17 Jun 2026 12:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wOLlo7Kc";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013055.outbound.protection.outlook.com
 [40.93.196.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8126C10E841
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa6YlWlfIQoOLD2SCABLMXrkkvd82u9d3zls9VM2Hgte7bPMhRsyEGr/WOQwCP/Pp4ySwvVsMgrAD70eT/YWAFTB3rNkON05nvREFRApkFizo/67+9XlTsqBRT/S/6bLkL5YwolEBeqBMiXxI2u1H/j1I2uXvvCL7Cy8HGm4DN7O+Luzrnvnr34tqXyADl84jeyT6os7tv/DeZCYTeKg74QyjAW/533J3mNo41mofxhrA3Z5W5YNkH4+qiXo2hsEKNlhhZWrwv85nobgyFG6OL7zhj9fwlWWv0oXLOkQPbYwq+j9CHiCHPR5BqB7MhcPtrEC6MYHB4G8ntS0QJzDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fpmMqpj1BslUiUFU/tL+O7ktZMZ3VPmCL1SyJfABg8=;
 b=g5HmBvEG9hT31ORFST6KIAvH8qbgv4jKx1+7RM7k83HhZf24xv94OnxzdBlIr54CTKr7xnWCkSuDBOxppAVzOItUKbP5L6U+z9egkjzbY4dF31TNe7hWNWo6f/kT5hsdC5lZ85QbJvvhkQNACywucH9EteTfi2WnQqhByc7dy2xr0gRpJQdcbDR9zYHPow6SNS47AJdXdj9gCSjuMv8PTbb1wbsQ1TxHpX4s7NWuOx6RJlC3O4vOgHxAJSgrA7YOtQt1tA3QmHbnlQxhH6aydIAqfY3LNmrb4xuhQssxVzsZyZQz51dEzRnoFUDb/RriV+67d450zlg7GnUbI5iZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fpmMqpj1BslUiUFU/tL+O7ktZMZ3VPmCL1SyJfABg8=;
 b=wOLlo7Kcw5CIc4Pa4WuZUAWAI2b1NBtDyYjZA3hg1UHzqy6oZhGMb1YpLlaKphore+ebrI3u4w11+fqly6SXZ+PGsFWGO/cBT1WuhpVGlBRS7oiMf/1sdpAbfqfRRY/qOCLXfubmeICZ0XxPKQDtRvVZFCnx4px8BAQinkQRRt4=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 12:51:46 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8c) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 12:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 12:51:46 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 07:51:44 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: return CSA kernel mapping via out parameter
Date: Wed, 17 Jun 2026 20:51:19 +0800
Message-ID: <20260617125121.1838486-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617125121.1838486-1-xiang.liu@amd.com>
References: <20260617125121.1838486-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b7d353-9d6a-4663-e1bc-08decc6f309b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eMTKsJL8Z3Tg4ro9tW/hXN/WmpiHFsbGN9qap8hk8MAu6zUsk4ZvSFu2HBSjWhVk8XLJGcW1Vg5/2vwWoS3z6UHwec+RBCkDRefrX/Wdb0rHh4MCQSfKs1LTbuJsgFST+ijB5wcHRt3xsqbag9rrl/7Rf8wMe+Edi1gX++Fbpcuu28lL0KwN/abqvdEoNfbSLHugkJJROota+Osor4IgrhpsBU29ZYvxXVnWc4sFKmgUhmW6EyYz7ajxOeeg4aGxlUexADd0/hTRh3HLZ8i9YHRDc/wgL55RxJUiyo0M2uKlt3EMQyUHCP6RDEo2KRWK+XEXhNEUMKT87x8Jxp/Zkt0gWpOLKwO294wdGSlQYPyCMqmuERTdtr2aLSSgf9o8AljInSbBMDuJVpYS02+6v//wDV6IS/xz9d6YRzppegGNBf1iie18+/LzzhbjjyG/0WQ/iAEdcy0GeKbxXCVe1tMotgJinXvq6hIds3TkMMIkclDdIzcOPLWv2vn63w88HF4/+0M0JcN3AYWA7ge0SvZCC1P5mHkF4pgNmQ2PJMv3u6aA6lQ+VwnGyrmT+eI+K0LfCt+dTfJl/8xfu+oxMb/+z9Nl8AKcDl6MhDxuAwD3sI/ThmzaLmTU3MvMvapNx5j2SO0Cso8zMff9+OucQExDZmgEGjBtCwAlKZ+CJX2KgDStX9ZHcfQIjUHCX+OOil+UPH+JBVJwCqccTlmDxBbJVc+mVQ8GHR3w045Vi28=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HZXp90YUfvOI1v63GTpU3VtX6Z+pP7zR0G616HQXq7jc+qAr07iLRinXnZImopawsJxNz1ujaHgND0CcCV+y/ulDhhOhEu6bypr1mHL0n209pLCPeszAuyHiY5svKyRYT977t8F9gtHhTNzXfbCMRzZ+uFFNOGU5J2LS/ikRX36Wh6//k2Mq1euIBP27YSRg9cPC8EP4XR4mM/F6iFjzF4yD8z+WYyREQouAPoZ/dPT2wdsKc3ExQHSuy56z65c2DZGZ4yAkSqWhZTBE6bHK/7VNk9yEYVulKSyUmKYsgouMsN/gh3k4RPH1XxMfwm5CUEptu1Tzm0fU7t3WxhgW8CUYt5mPDPBJB2EsZuZ0ji4OCA4VHlEEfwlHs2emUkMUE6e+sLP27bYijEBkLZeUCIo7gZKy4hQpA9ObP2gIXyXg6e6wN82UU4xMSyMQZWFy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 12:51:46.0844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b7d353-9d6a-4663-e1bc-08decc6f309b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805
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

amdgpu_allocate_static_csa() stored the kernel CPU mapping of the newly
created CSA directly into adev->virt.csa_cpu_addr. That hard-codes the
single device-global CSA and prevents the function from being reused to
allocate additional CSA buffers.

Return the CPU mapping through an out parameter instead and let the
caller decide where to store it.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 814cb9e903586..083a2cf20324b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -40,7 +40,7 @@ uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
 }
 
 int amdgpu_allocate_static_csa(struct amdgpu_device *adev, struct amdgpu_bo **bo,
-				u32 domain, uint32_t size)
+				u32 domain, uint32_t size, void **cpu_ptr)
 {
 	void *ptr;
 
@@ -51,7 +51,7 @@ int amdgpu_allocate_static_csa(struct amdgpu_device *adev, struct amdgpu_bo **bo
 		return -ENOMEM;
 
 	memset(ptr, 0, size);
-	adev->virt.csa_cpu_addr = ptr;
+	*cpu_ptr = ptr;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
index 7dfc1f2012ebf..34b85cda1cc56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
@@ -30,7 +30,7 @@
 uint32_t amdgpu_get_total_csa_size(struct amdgpu_device *adev);
 uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev);
 int amdgpu_allocate_static_csa(struct amdgpu_device *adev, struct amdgpu_bo **bo,
-				u32 domain, uint32_t size);
+				u32 domain, uint32_t size, void **cpu_ptr);
 int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  struct amdgpu_bo *bo, struct amdgpu_bo_va **bo_va,
 			  uint64_t csa_addr, uint32_t size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1253df9b1a9d2..a8e76fae11282 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2422,7 +2422,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 				r = amdgpu_allocate_static_csa(adev, &adev->virt.csa_obj,
 							       AMDGPU_GEM_DOMAIN_VRAM |
 							       AMDGPU_GEM_DOMAIN_GTT,
-							       AMDGPU_CSA_SIZE);
+							       AMDGPU_CSA_SIZE,
+							       &adev->virt.csa_cpu_addr);
 				if (r) {
 					dev_err(adev->dev,
 						"allocate CSA failed %d\n", r);
-- 
2.34.1

