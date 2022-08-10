Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFE8C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 08:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B22FF38DF;
	Wed, 10 Aug 2022 08:50:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA425F3983
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 08:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbMN7Ie7LiUYLAdJ/TQBnwZbzeEtFXhEO5BwvZT0a6kjt4/TP6CCdjrVGibhGcNGg/SMugiSP2TQaA2NoTiUPVmWCR0U0aAtD6JcbI2W022v9vfV7qrgjoFc8K/7Wi/wHkXcl+bmMCV9TFBIU5E3Ml80wKtysROg82yIW2KqnH0tsuhPWKEp6+OyE9Hgv4pE+RYaeNgIvhNEuWR7Erp6ANaGamhKzxNWZUUtrCSm17qVA/Bu6GWWjLohNm6FNf2l7QBa+4gtSWJVCCbKDD9zTjaRUWDzxGZ9gWUa7w0Myrto83NgwLSv7mi872aA/fH0HYBQEuLpYYqSTYy8zlmm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ul7fJj3n0cuyBKbf1b4x5DIvCCUSpJ6aWfQ4yfNlurE=;
 b=M+QdOHwavCMhJDJdrusuU7gZQOKiqQjm6Xoa6k3jK6NTxqBTYEdKZnd5e1R8UjY/zWPu6NvrBVaMQ8s57lgwM3qRaSwfBUoHm0v+dfc9NnJNmJMRB+UvuHiQMEg8UIHyJQVAUPW/XsPOpmo+VyPjgkc4lyCn+lEDEW5qIpXt76BY2B1JLDoT6rbeIGmH5xCzFiEW8O+fCiBR9aJMNMKrosykAGU/cghfvMX+/9EixlRarqwJPg+/2fsVzW1yiOymNUzvG7AlrzMBoqtLsq5xd+qIKFCVfGQ/1wGFDUk3eM9yk0JVwzuCVKlzulm6edk6eGem3cHlMr60VflfOGdfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ul7fJj3n0cuyBKbf1b4x5DIvCCUSpJ6aWfQ4yfNlurE=;
 b=ZHNcytVKh6TioLdT/lrImUyaNfZ1RvH52/0P8aWRnrbbCa0nnEMMF7zWWbFhTUZB05eK4uXxEGomH1imGzzD/HqZEp32dgw+eEnig0NTaYk+fL2xnehwUTnt1iZEGBygONXSnQB/o0Jj94+jM4T3N/WvAh55snY2HmnX0MrUnzU=
Received: from BN9PR03CA0898.namprd03.prod.outlook.com (2603:10b6:408:13c::33)
 by BN8PR12MB2898.namprd12.prod.outlook.com (2603:10b6:408:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 08:50:09 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::46) by BN9PR03CA0898.outlook.office365.com
 (2603:10b6:408:13c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Wed, 10 Aug 2022 08:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 08:50:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 03:50:08 -0500
Received: from sriov-SERVER4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 10 Aug 2022 03:50:07 -0500
From: Dusica Milinkovic <Dusica.Milinkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [Patch V2] drm/amdgpu: Increase tlb flush timeout for sriov
Date: Wed, 10 Aug 2022 10:50:04 +0200
Message-ID: <20220810085004.107210-1-Dusica.Milinkovic@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acb0be47-8db0-445c-27fe-08da7aad5467
X-MS-TrafficTypeDiagnostic: BN8PR12MB2898:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unxXFAwdTzAmuHEf3Ce0o3LWjr9SBCSaSMCJQXdmgJ5H2l528PS6IEsRKR76HO0Q6tiplwB1EoNYwrOoqlHudkXE8k0QtXQwGe20Qv/pQ5RMIIidhuDcH7ICd+HrhLYBz5FlVmWmeDtnoP8EJ8TTgq+bhHpP6WenyL0W4Ll5k3Ncjn7/H+3HrcCD65HoO4M57eC4tTgn1VF+kmgeiBAh9X8762F3UJhLUFdQnznXG5vruZIRfnhVYtUzrdSMgxx+29LTWIBCGuJKm8R9SKF30TUAdcHYWKbAXoHImTqArFIOUPsYG+VNSh9Z2WIoXf1PAl3TREdRD0X8t5kJxC5RBl0jse31ZDGLmgr+PjYpwcEMg8Upv+XKmXqZzVJc6zlUXm4f/TS2wbiNwiSlwUw1883p/F5WUapY3KuH9PhEFcL7VlpvJhc4KZjbu0vJUspWzqglE2E9WThLUgTni1p+99fsv403N94A8a4Dkd/mPlsHRzx1jznQmqOpCNBVAfQDnO5JeC+BdjZb39saD4Jc/5DUM1l+WX+nJuHBVdVKsYl0r0k00+jcx8tmuPlECEh4dsLz//zK2kgxQoe/JKFeGz/NrCEBMPJ/iEz1L8q201A7riNIRKFLdkpZyRnCaNGSyh51HB8iNhS9+r5bIwL3Wnbx99YiByge8R8HMDzsedBEjgQFI1CxO1pEU66n+ZDBms+01R9yhg1dK6ND8yp7QVIGSOETXTG/NM+5fbqov4d5mXD+/upwFZo29LRcEsae5zLUw72qToL9ykWlVXLqgKjdWMJDxo8/Qz6wb0GDZQQQD6M3aSildF4mtzDi3O3BvBT1pt3+G8/ycCfIOAVr1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(40470700004)(46966006)(426003)(336012)(81166007)(47076005)(6916009)(478600001)(40460700003)(4326008)(70586007)(70206006)(8676002)(82740400003)(5660300002)(40480700001)(356005)(316002)(8936002)(36756003)(7696005)(1076003)(86362001)(2616005)(41300700001)(36860700001)(6666004)(26005)(83380400001)(82310400005)(186003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 08:50:08.9542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb0be47-8db0-445c-27fe-08da7aad5467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2898
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
Cc: Dusica Milinkovic <Dusica.Milinkovic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
During multi-vf executing benchmark (Luxmark) observed kiq error timeout.
It happenes because all of VFs do the tlb invalidation at the same time.
Although each VF has the invalidate register set, from hardware side
the invalidate requests are queue to execute.

[How]
In case of 12 VF increase timeout on 12*100ms

Signed-off-by: Dusica Milinkovic <Dusica.Milinkovic@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9ae8cdaa033e..5743975efea5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
+	uint32_t sriov_usec_timeout = 1200000;  /* wait for 12 * 100ms for SRIOV */
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
@@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
-		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		if (amdgpu_sriov_vf(adev))
+			r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
+		else
+			r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			return -ETIME;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ab89d91975ab..bab26982b3f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
+	uint32_t sriov_usec_timeout = 1200000;  /* wait for 12 * 100ms for SRIOV */
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
@@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
-		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		if (amdgpu_sriov_vf(adev))
+			r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
+		else
+			r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			up_read(&adev->reset_domain->sem);
-- 
2.25.1

