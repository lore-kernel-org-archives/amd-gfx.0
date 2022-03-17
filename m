Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D43CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 11:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9713910E8D7;
	Thu, 17 Mar 2022 11:21:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72FEB10E8D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 11:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvTc7jCyz/fFFW84KpZHX/LKK+QNvOct8rZDyu792k8O7bCOHdfTtZI7xGcP+YM/LkZjwG5TfhyVmbAzS9mOc5UMjM/9O0FiHAog6fuQFGk61LRlOo2GGzVAnKiyIMq8sUsqEttiYMLCm8P0RxRvdV2byP1uuMtWOL0s/OqMIfFLU7byzgVwrwEVOlpobnO3EEuvAZthYB2DIKYImQkTP6lxxpNKrOcN3lXVZAk4U3Iv/YRjlbi5cdlGejik8F5RNQaJt3twE/m3qKWUv8fTRYtbXyy5eTmcE2wm1GAoVI0xhzuM4xcv0LycMacmbTIxav5gLweChQ2Cj7Z/5pQo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx8c0QJOo+7NJ1HK7+hIKZuULg8p09Vkv+XI8HypZcw=;
 b=XfLNTpVqVUkwiBu0K5U8If/qN3h/rdQxOzsDJFdhm9cimgcYS7/kSimSc6loDF6Wn4c8nY7CCI/P9ZGAVgz+OLKY402+jODXEGd59ZfbirwNyKS4XdCjcT1p7k40GZnG7IbdV0Jj1gKCYlBLmTYGkLiVF++H/NC15e3ugCNtgMgrbIH6yn6e6YrpZ+zZhV/VWw6rJRQQoHIq3RBbFM6uxG6zQvRZgLIGa41yDTrJLIc85jupo430ZiUHnchS9IUdHwyFx/aXBkg6smM9KVNrESnaAeHjmf3uGnjnZx8/IkJQkERBYn10jZc79npXb0RmlSAafwH7qWzYhUm3pkPmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx8c0QJOo+7NJ1HK7+hIKZuULg8p09Vkv+XI8HypZcw=;
 b=L1mKNjsdlOI9TcnvRLgQiRh3lJQr4mSnTHjTgFz9xV7NrFSHOLWl59r+Kkl5pggsbahFx0UcsN+jS+FHN5Ewn3Cm1fXt+zZC9IdC9SbtCJ1dzDYkZ1Tl8SUcDc3eznc5oGOCm40mRLGADdMk4pMtxuxqvhWtEwKzfZqrRmDah/U=
Received: from BN6PR21CA0024.namprd21.prod.outlook.com (2603:10b6:404:8e::34)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 11:21:39 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::79) by BN6PR21CA0024.outlook.office365.com
 (2603:10b6:404:8e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8 via Frontend
 Transport; Thu, 17 Mar 2022 11:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 11:21:38 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 06:21:36 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: move PDB bo release into a generic gmc function
Date: Thu, 17 Mar 2022 19:21:18 +0800
Message-ID: <20220317112118.7411-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01767b81-1e09-46fc-3e6f-08da08084e0e
X-MS-TrafficTypeDiagnostic: SA1PR12MB5669:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB566911C7389F5B399815F56DF1129@SA1PR12MB5669.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhGqpEp/FWmdhCq8Ps3Rb+WqzJCski/7UoCqRiA4yn3AvMQ/ceFEVHt/24QNHoYTwOXZFGnr169G5ihZMkIhzvdrsIK2rOHqeD0vMTDSbgtG11W4K/b0/JbPr1e636YovUJL9pxyNFzq4qSW6lqkykLc3kcogXXj4HulOczpuUfnIBxVqXXqj2Fi0q6drT9lGdo62x/C6L5u4wymnjwp8kTRNbsTL3IkYmGAdkvETLapXHRrNNrxUVgT9XuSrlkqhcfm2ILC+NhQuFyGfl34tV20xyN1en/KRcee6/DVYiGlGO3YJocuL0prgrXRlDtaK63fMqH1MUhUgWySQx5Qht61qp8e+E6nPGay0FQ0r8ZpQeObgMqN3AmcVjS6x9Fp3E3dZmycn/tZSzZZ4iH6r/hxgzs5vcZCWx45AHRv9VVvWfFdXTkYbh3nWlO1cCh9pZYO1LwefjS+2Hgia9LWNXhfhkcGua5XPrVNHPkFnbZWjXWoxHBbFq7y0YO0kxR39foNPXdFdbe4qJPH/yiPHb5g6ENwSuLG3VAFCHLUGC4xohqfODPpeDWoTBoicDnAilq+9jOKTd7OTGKteuHV0ALebbh+EAvQkVqEXtQKADd3gBQxMiaN19b6ByQMmYNOlNsfvlgetMqOW0nCtYDfHNZFQoPw86gmgdrE51zW2eLeIX4kyTV8igUNcjnJtv2HB26i9+fCFyY+vOLi0Hdd8tvAE5KJGHkK3JbAUcyK668=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(336012)(2906002)(47076005)(36756003)(110136005)(426003)(6636002)(316002)(81166007)(356005)(2616005)(44832011)(82310400004)(5660300002)(508600001)(86362001)(40460700003)(6666004)(8676002)(4326008)(70586007)(70206006)(83380400001)(8936002)(26005)(16526019)(186003)(36860700001)(1076003)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 11:21:38.7882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01767b81-1e09-46fc-3e6f-08da08084e0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To pair with amdgpu_gmc_pdb0_alloc as a more generic handling
in amdgpu_gmc.c, no functional change.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7021e8f390bd..36f6b321438f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -136,6 +136,12 @@ uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo)
 	return pd_addr;
 }
 
+/* amdgpu_gmc_pdb0_free - free pdb0 vram */
+void amdgpu_gmc_pdb0_free(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
+}
+
 /**
  * amdgpu_gmc_set_pte_pde - update the page tables using CPU
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 032b0313f277..6f425e3a9b6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -299,6 +299,7 @@ static inline uint64_t amdgpu_gmc_sign_extend(uint64_t addr)
 }
 
 int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev);
+void amdgpu_gmc_pdb0_free(struct amdgpu_device *adev);
 void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, int level,
 			       uint64_t *addr, uint64_t *flags);
 int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 08ceabd6c853..ad600f72a51c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1721,7 +1721,7 @@ static int gmc_v9_0_sw_fini(void *handle)
 	amdgpu_gem_force_release(adev);
 	amdgpu_vm_manager_fini(adev);
 	amdgpu_gart_table_vram_free(adev);
-	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
+	amdgpu_gmc_pdb0_free(adev);
 	amdgpu_bo_fini(adev);
 
 	return 0;
-- 
2.17.1

