Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E16CEBF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 10:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9348510E1FF;
	Fri, 27 Sep 2024 10:36:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M+nEamuh";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C8510E1FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 10:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VX8MWo0XKMEOvCcw3ORmxmJhxlxXBolrnNzaeXf04uE84I+RmJHpG+c9dyk7PUwe4OBb6g6B+wW0mFy+ms1wq2iZBAaHN8z4dJ/MNjVtFUK1isrjW0/kOl0W4YviF0XAUMxfVy+s+i3ZS38aXUPwKltVrIPGA7jzL4z/lohwvFrK0C7hR/P+Bstr4xfEIOynQEEZWtJccoCalCgDgIvR0llcFAZxDrggEoQcGeFGm+tyLD3TpP3e9/ChqPAmEv5mtScNpRy1NJTnpqeR85X6pI4CAyUWz9sZM6AUft2fI+kNS5ZubYhbebbsCxipTTY3bzXXe4ou/cQc+ISrCJqE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3AhczZhL3jP7+khxysF/89919V4hS5VwvZGV2AUVD0=;
 b=PnXmy4y/upae8jR1lZuMQIBGxGWkZnXZr2DgcKWHfjL1gVLN3CHagP707H+wjAEiMGt8yJB++rWj29kIUNbXnBYskDlocWEmztCpX7acLNT1zD6A1Ln94kWFXFO+z1G+RkuRIWT6c4/SCNYJwDd1B8YPEhrD+vE8iqxIN2cvMoqtFhNEMYBJchRPQ7gs9Z1ZrBxPQREutEBv02pKKWO4NWvQgUrwhyH4SlnoCuRi+tRBoM8cCTQejdSlwpwUwpe6J/M7X44Xsh3lmaMXydCKU2dyfaaNJs2e6E6+0aUy23qekcRUY0YoF9M6x1v7q8Baw72D3A2opnbMaxhzjU3A8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3AhczZhL3jP7+khxysF/89919V4hS5VwvZGV2AUVD0=;
 b=M+nEamuh1sDMH7fq6ABYG8EG/0qBUnKL2bxJpgcFTmEXSor3omQlScIBlIDpsK51Z9Vj/7H/FfeRioEldCSoWnVEgDkbPrC6fRZhUn1ChIBKO/RDgPMGbQBcXOvHeA/PIxzMu6Jpknsqg6bLsBakuX1x0M6cgY6ExsMWqzLX6U4=
Received: from SJ0PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:33f::31)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Fri, 27 Sep
 2024 10:36:24 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::3b) by SJ0PR05CA0056.outlook.office365.com
 (2603:10b6:a03:33f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Fri, 27 Sep 2024 10:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 10:36:24 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 05:36:22 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdkfd: Fix an eviction fence leak
Date: Fri, 27 Sep 2024 18:36:05 +0800
Message-ID: <20240927103605.136921-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a6d2e6-fcf4-4f6b-65fb-08dcdee03c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vdrx8YuZpqjZISrqQEyA4TRW4/zZBAslkmyUUdKiItN+TyYVSN8yx4/wllFG?=
 =?us-ascii?Q?nwPwCDdQZ8y/E5XbEheWaRzEfxKn8NUaRF59kGxJUV8/4gIqSnP+DWDQBsYq?=
 =?us-ascii?Q?kolgJZjhiMuOgV0JS8jBpQaEASgBZTBdsg/IvVMYUJJ2IcC+t1Hl6OVYiVMo?=
 =?us-ascii?Q?FdQIVmy+uptgUJAfqGd/AY/F8mbLktTcba9B0BQDxNbopi9sXA3fEBLKTByg?=
 =?us-ascii?Q?YysxMKNZvJbP1CcdhbmDWMKq1r8VJK4/snKG2KrvxrczQLi6wanH6XVpY+gW?=
 =?us-ascii?Q?Rju8wryvlBWbH/KhbgzRqY/V8OTSon32rzEYuhnvh9+CC9ZJDw93ai96Uk4j?=
 =?us-ascii?Q?E/MpjhxjnviDtYtZL6aPOYOV3u7mRw/jXtCI28i1HixwKW5bjU9MrV1tYAoJ?=
 =?us-ascii?Q?eVMfIsyUqUEdLu7wn4Dgt8TT1ZhJK+PW9W77JHnVIyPkGAy0cucxbGlnZbPo?=
 =?us-ascii?Q?GQobp/sNfuBDF/uZK/KDEGzmbwsitxhwKQxye40qSbIPFikpxeca4O1AopLN?=
 =?us-ascii?Q?BtKOKOSMy0r+TIZBNJTq+xiWDlpLV1BFkRVqAsWvLJAk1zlpcifHgMz4+0fM?=
 =?us-ascii?Q?LYSRVPNC5SDg6NkBf5KCK8qXs5fT4lN/OmztS33QXr0IqMalkGHvtTiI6hav?=
 =?us-ascii?Q?NxI1XWECeXveMM9G8wMLh/jYT6DnJoGfpMkmYxKPaTsbg1gNlrxwneuXOkAd?=
 =?us-ascii?Q?DIDOFKcUh3YaGemvASv71UA6txvsNAAC/l5vHQQXOY3YFvMjE4cJjTNLEoQ8?=
 =?us-ascii?Q?Iawi7GrquhAJEO133KxYfjOp7h9i7EXYfREdLWgbDPrS2iZ/KtgAmrtr8hvw?=
 =?us-ascii?Q?yVMiAah+qeGnosObnFwCLJiYYaTrcEF3c5TFUS9yO0GPC3kkIRhYtfp4w+rO?=
 =?us-ascii?Q?ObUqIlPOHZoG8I1DUNGsoxbMD8rJSDik7l3o32bESHpp9zXm8XSU+ppltle5?=
 =?us-ascii?Q?s7ePtzyyZ1/4fPW3gOrSmQUCmF3p42Xn2uxE4sN452qu2X5MDxI5N//kImna?=
 =?us-ascii?Q?pQEzAiu9T2OxQQ62sRus+A+YBjqjvzfk91/AqkEM3qIzIzmzddio0uK5+UAa?=
 =?us-ascii?Q?eEE4Lfl0k7vGDLd9RVutzk79Rxio5x5V2KrrXbIxgq3qcDLrNtSsYFA58w2B?=
 =?us-ascii?Q?yyRzGTNgj1GqcgM/acYemmbNjJTOdmbpQqmatW7Y8CSBHd3pbBPsPc8fYv4g?=
 =?us-ascii?Q?hlQ+Km5G1v3qyYEUZjoIhYsP0RCz/Y/NKSzDg7kODElFrF7BWfae1o8iBDVl?=
 =?us-ascii?Q?2dyxZndsG6uljsS4fkhie5WQoR3L1Mx0JFz1UgO5gV1eCVXRQzNY7LxRzvN+?=
 =?us-ascii?Q?C/v99GjJjlv/noDXxF3TeYMMOdLQEzTn8mhmb8p04YXBpz560ZQHKik0vZIM?=
 =?us-ascii?Q?OmwYTP74E8ljWkhllMlZn7U+Jspj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 10:36:24.0765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a6d2e6-fcf4-4f6b-65fb-08dcdee03c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137
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

dma_fence_get/put() should be called balanced in
init_kfd_vm() and amdgpu_amdkfd_gpuvm_destroy_cb().

Fixes: 9a1c1339abf9 ("drm/amdkfd: Run restore_workers on freezable WQs")

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ce5ca304dba9..c3a4f8d297f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1586,6 +1586,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 
 	/* Update process info */
 	mutex_lock(&process_info->lock);
+	dma_fence_put(&process_info->eviction_fence->base);
 	process_info->n_vms--;
 	list_del(&vm->vm_list_node);
 	mutex_unlock(&process_info->lock);
@@ -1598,7 +1599,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 		WARN_ON(!list_empty(&process_info->userptr_valid_list));
 		WARN_ON(!list_empty(&process_info->userptr_inval_list));
 
-		dma_fence_put(&process_info->eviction_fence->base);
 		cancel_delayed_work_sync(&process_info->restore_userptr_work);
 		put_pid(process_info->pid);
 		mutex_destroy(&process_info->lock);
-- 
2.25.1

