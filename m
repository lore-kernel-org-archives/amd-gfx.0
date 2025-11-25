Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBCBD0E6EC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F4E10E430;
	Tue, 25 Nov 2025 15:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ccJ1Pq7+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D07710E42A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHJ51TdtJF4bnUxfG/o3mViLkVt2eDsmGBF/C+Te5Ti8OuXS6EKXtMi/Sst4kYT0WxsaSEYRedVGz01CNkpsTpB8D5hWBDWxJAWxP5P+gElyJdETqfvkxsB8RDaHrpdk9JfwDisD6mJy0/BOZ3J6vy+8BYOXtwU3yQ7PF8Vi8ERavuGeXMifGeQwwheIRMvuPPHCPH3TXnXOVWm+cdvLW9XZH009Wg00GLQC3eXOQN0i8NIuqVi/SXNp96o7AEE2o4Uvu60SqQbSJTgMreKDrxzOIjxI0mslVH/5pufKaZDbdoZQ5meea3xWtIaa0yd3XNsv2XJLjOiXxDrFZEInCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02ldJAzYErTU8uou6ZjL6YAC7zwdLN4xK0ihNn0Ko3g=;
 b=l3Eh94UZ7kvVbB84kXuUbquu9ttQZcCTDIYvux/AC2nY4M8NG8xRtC+VFGZwcoDU/MBfcjsvFV1JQtPjuHF7TSNiNBGuQA5MgS7EyseHYYDWjnEgs9n3vqUaAuWC6HpJHdoA7t9otxv3K/pjTilUDArlyzqJqrHhZLavKyMiqMJ/1aLSwbOkE24b+u/2Rej5CHqvA81aixNfQ7E75LzoKPVEo33NW2lQ8BgmGPVWo5Mj0wLKtHbzFTPXzhPwlfxlBkC6l76Gl2itW8vewV8HpfJvxS2N6QfCmhUZ6QmyyLTMXsxW59GiKzBXVP1U8qGO/B7W2eHz0JgATrW6ENxXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02ldJAzYErTU8uou6ZjL6YAC7zwdLN4xK0ihNn0Ko3g=;
 b=ccJ1Pq7+lVp70UhlPuP0+gJtOb6ZQVav4iMZ6p3r/PVuGVLnIoZ+DpaGKk1AG+rCvnaTe7g0eyYXtQ8jSkeVzxFhjl0/1ct/WDCXckUSzm0QXHMh+SJ+56hQRG4NfB2quPiv0nuh8i/giIb7/1oEfQcsnd3006I9IWAA2ad07OI=
Received: from BN9PR03CA0119.namprd03.prod.outlook.com (2603:10b6:408:fd::34)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 15:08:33 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::2d) by BN9PR03CA0119.outlook.office365.com
 (2603:10b6:408:fd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 15:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:08:33 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:08:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Setup PCIe atomics bit in PTE on GFX 12.1.0
Date: Tue, 25 Nov 2025 10:08:09 -0500
Message-ID: <20251125150812.2046438-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125150812.2046438-1-alexander.deucher@amd.com>
References: <20251125150812.2046438-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: a12cb64d-fe3a-4098-fbde-08de2c348001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dWcOgzF3QnH+9jUf8n5QoPo4NasIV3cbj68x4qUlWZgoe3GrlxHPARFvuYzS?=
 =?us-ascii?Q?byJVV3VVs8h+obDbkhmFNK/wqsW16zTRKFPCuVW6qNSytUnI4tgule76YUz5?=
 =?us-ascii?Q?XSr/7B8cpbEBhYyxKyof6qd3wejM19o/mEG4/10G6ZGcXbDGK+uOEcB+YGpN?=
 =?us-ascii?Q?o9ywt3ZjWawOZy3FJXIkaYO6x0FNhAL6JwkZHvQF1K5QtieWI1X1fWtT1+Ir?=
 =?us-ascii?Q?IlutDTq+b3DpwXiHtRBk0Qx46Z1AF2KRvYRbohk8HLOtZBWs3YDEbl9BgrjU?=
 =?us-ascii?Q?68wysxIdy7wKvzaKGjHUUdxgeE3A5QVm9DBwABekm7wqXb060im9TA/6ij2s?=
 =?us-ascii?Q?NnM7qQDljTEnMAwq/8dmACA5Z37PyzyUcRzmMecpKG6nIlq309+WSIB5WTi9?=
 =?us-ascii?Q?lMeyWcJ5UaB6NO0ADiLAUzWXsVKpbVgd0oNJoUBiD3xhP27/6UqL1WEbCE1L?=
 =?us-ascii?Q?nu+mFnEfU+kA2nGjVSxx/ntjNLVdNr/v7IdUUsTNYNtSrt2zI4O3Xnm9pL7J?=
 =?us-ascii?Q?WsgC/q8x+f3WfbgwURdRZQM89nSzA+w+lhy0EHdKtPCMfTuQlwQpmzxD2hiV?=
 =?us-ascii?Q?n5EdBB7LNr0sKWbUqlZTRWLtVXcfNubxOTP+cr5WbGvu7FgSOoQnzl4ULnse?=
 =?us-ascii?Q?CcgpmkIfr5BvQt+gK/OvyrlXekIf54dUzNeTdCXU+8YFyR7kXhVnZZ35ufCa?=
 =?us-ascii?Q?Ov6Rok4gYFZW3N7m3LwCYKawJPu5dmZtgSZstWCo8seTQD6JD8GYs8ZuR0cc?=
 =?us-ascii?Q?jTCfYFRcmacQqktlfpsdbSw93vzXINkXWLUdTka5kG0Hh3loCc6FC3Jk4AUi?=
 =?us-ascii?Q?MeuOQNXeJo+bTyuEQM93i4lgWXgfiAk51nk52EcynpGRILy8Ky9w50XeQ4Th?=
 =?us-ascii?Q?Rv1D6631kbzVPfItWJCTkwu+a1XJx5diIjUfaWZLrMAnuucdUSzmoisen7qG?=
 =?us-ascii?Q?PBQJRdgTofxVnamV2qVMHbWPCrLGGBVGgDnJJxOpFD692h1ugJTwT3UVx31p?=
 =?us-ascii?Q?K4YnbfhWRnKg9LusVkyW+jsoxH2+jflLPxbi7AAWUKqS8vX5BiLF2oJq01ps?=
 =?us-ascii?Q?nZ+uXGJLB1FnGMTsOlLLurOMAEVEkvpcAs6h5a4iHlsi00RdgUxJEfgvDm7v?=
 =?us-ascii?Q?kxEFTOz4rmedFQx5KnRB4tWtDsDR0jZSCu4JcTEVwND5bRxT7ytib8YtUrxa?=
 =?us-ascii?Q?qfUGIZyUKdnENx28i/t/qkPtgfZYiqeG50XOR6QJE3dYYintFwRt7uqYuR6N?=
 =?us-ascii?Q?FmiUO3+t/aFdx0Op80bDIZWvhv+gkbs37jadjp9X+HbQBGAUGWBAr/7+7h/G?=
 =?us-ascii?Q?puNGXN66eOzsKRWO4yMNzt9p4RODLgdXlXwCxFc48nYdczLjRpjorIM9Rx/G?=
 =?us-ascii?Q?3/K37p55/rKiOgdVEnZPbPg+ibPYeHYCEOpMpq063xLokRMTCfUMgK8wPh1i?=
 =?us-ascii?Q?Sv+gBRDsEETDelUzuZbvp+XJykODB9W7/fQGb6+cNkkBqTlIbVJjIbD54Tv9?=
 =?us-ascii?Q?yY89MIOSwzMcvO9lzf02Pnzy8b4T6ouXFeQprC9AmcR4sH6Cs9DzSliiHv8j?=
 =?us-ascii?Q?IbsNjIYneQINucwcmPI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:08:33.0304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a12cb64d-fe3a-4098-fbde-08de2c348001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
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

From: Mukul Joshi <mukul.joshi@amd.com>

To enable atomic access to memory, setup the new PCIe atomics bit
in PTE on GFX 12.1.0.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index ae08f8b3bfbc1..4ead488261a68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -308,6 +308,9 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 
 	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
 		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
+
+	if (adev->have_atomics_support)
+		*flags |= AMDGPU_PTE_BUS_ATOMICS;
 }
 
 static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 24a698702da75..903064610c23c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1305,6 +1305,11 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 	pte_flags |= AMDGPU_PTE_READABLE;
 	if (!(flags & KFD_IOCTL_SVM_FLAG_GPU_RO))
 		pte_flags |= AMDGPU_PTE_WRITEABLE;
+
+	if ((gc_ip_version == IP_VERSION(12, 1, 0)) &&
+	    node->adev->have_atomics_support)
+		pte_flags |= AMDGPU_PTE_BUS_ATOMICS;
+
 	return pte_flags;
 }
 
-- 
2.51.1

