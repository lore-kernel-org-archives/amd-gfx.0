Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D314C282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7404B10EA6E;
	Thu,  6 Mar 2025 18:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2B/NY0ST";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B33D10E752
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYWOyHFnxuSpHdeM2+KTDMJvg3DCUQQcyAJTL17VjjDslcIszxtET8tHM00hZyRHOYrdlQ5piUHRvDNjYz5up4SgvABz/FF8XQaxUHZ1J1WkxbkGNpjqKGIz6CEz29GeWdC/Q6wqZ0N1X4adGUJi0KhOwmfKxsOJM1+LsgvcwJ29EHqoWLQUq1DNe4fKGTVRjYchNFCBA47HKfBE0NNWOjDH+BN6KrFR5JwtdQ3rqbcIzROlw08qLhS7hX7MNsQXKnLbk+c03t2/t++unFdECPOGKRKDr6zPjjZOKtwO8NhFujvTN/MaorMM8byl+EOvQ0NxKb5/foW49DFhOOF3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL+cbhtfLsRaOfC8SjkTfGA/E5gJffmyWg9HEtDnubw=;
 b=xHQCuJjOCvtix/tMtfPUGH6IAOAmVpv5060IU/OI29sf/b1Q3VNDMZww5WLkm5WWzAlHp3mtTSbPvUxrfVlcqElorVt1CbaKapbb0bXUqPv8fH1v31lHBm1rYj0AGkBtpTG/DR72oMphklmprMD/vDZWDHbnChJIlVyFyDB0tYcX9yFFW0V5q9HKpi1fGBsCpehKpAf42ohh4/bTPn5I0+gTYztrQVRdoLMa3E21SzFHW1qSjjEIKirpkXV/r0LqyKl5oKVgemURJiLbDQ51xsDLDt1hHiINHzmYRk2tSQnd6IhUkbG4jDiiQZGeaeX7NVfE6gazl+yv7yRBIJzxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL+cbhtfLsRaOfC8SjkTfGA/E5gJffmyWg9HEtDnubw=;
 b=2B/NY0STCsYdJpCufEvZznx/ec2DQ0jcmIym6FIgsM/EDyfTXQsoealOQfZ49BlHrfhLRCJg7XpDVH6qUyiFrc5tNlu2NmXnpCNri6pexYE/W7ZMt38KMRn26hYMEx7dLS+ni2mUQtBaWCAdAXI3rHGw5MtLO5xHxALhSb2yGDg=
Received: from MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) by
 CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 18:46:31 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::4) by MN2PR01CA0061.outlook.office365.com
 (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 18:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
 disable_kq=1
Date: Thu, 6 Mar 2025 13:46:06 -0500
Message-ID: <20250306184612.8910-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2392a0-fc55-4901-7988-08dd5cdf3620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ke3MHrjNLBAL37Ko22xdUjHlDBMmNAIdHM9bcgfOGQP0D0DS9JVAWEsApS82?=
 =?us-ascii?Q?HZFjouURwPnD4siIx8zTbaeO3fb0dL7Xa0uX4BkoF0NdGUsWpBvFRQToEzOv?=
 =?us-ascii?Q?LzDQ45HF9fXDqZosbsXsU6c5G0/EA3ZIMekceN6fNlL4t4VN4po+jS2XFu2F?=
 =?us-ascii?Q?G1ZJhFtLubMJzJHFlbdKsf60vUhbp+9f+Gmxo/JxszaR4SfPEr516Xz//Wlx?=
 =?us-ascii?Q?Ayim34aN0f3ZgIjpJPdeiStZF6lGcgFqQOc2MZ89+pZ7CM4cJrhv4vc3xiqN?=
 =?us-ascii?Q?9K7FIvyCeV/sVtc85IY3hIAuV2colfAUGGZLm6Y+OKzSbVdNgU28LrazbCAU?=
 =?us-ascii?Q?nVZP+LVl8i8Lae/81ya6LFrxJfwZ5XZrn5ifyeE68V7+5Dw9BEnFV7p5Sm/r?=
 =?us-ascii?Q?Li/lsWpsVPJ4IoXcg48OOkeWpKECxGWYAOAee+ImchvLpmHpdGOCiBsVovbK?=
 =?us-ascii?Q?NU9aU9HScI6p72R8eJ+CKc53XluxXB/nCwF0P5GiU+2N+5FOmS+Dyq1RCd8K?=
 =?us-ascii?Q?xQc7u8NC5HGNSBULBjtSr56Oh/N9M2TAXRlSUNEcBB8dH3sPyyjRfN0dWUaf?=
 =?us-ascii?Q?+ZT0ir/RN8w4eDuFqkTqYsNBoKl2nzruEYE/Nu7aZtdm/xYEJlyrHbSbr8wW?=
 =?us-ascii?Q?BfWmZMxiFHflqjFo1YvZVfwpEgEpHAPIf7q7pcRkrV+gjFM340X1Ad8sWm1q?=
 =?us-ascii?Q?ogLUcIaZseZlOwBCUhWDRGzeuBA3dBnjRJCcAtv2GDPZOB7QDSUuq3dthYXz?=
 =?us-ascii?Q?1FDFgcsfJuHlsbm4oCpe/AG73+Auk18WwDBgfxW475EtNjeFLn+OJOJR6W6E?=
 =?us-ascii?Q?y8GVrb7i9+VoH3rzS29staa0TBh+2CnWOw/tUzoaNsO5aMkuy0hGkeyf0ppv?=
 =?us-ascii?Q?D4ItN37DB4ZPolKqHgJLKpoiE9UBAyL9K7LQebWccdvDWzlLpPQ3jNhkszbT?=
 =?us-ascii?Q?XQxFvurytxGonam0vaNNN0RxNphTW934XCULd5ezHCOIetjH3pFKfAidx5P0?=
 =?us-ascii?Q?vd9OsMpLhwT4Qvi7tgkk2Gt/8amCqlDmGHdSsInhO+wi+5gdmuosH7I8ny4x?=
 =?us-ascii?Q?hPkbRi5YYEm5W5lj8unQRxxTlPzUZqrbiFLAQHvorcie+VSUgKaE6T+bUZw/?=
 =?us-ascii?Q?iNkTimoUqV2H6JOSDUMW7n/PMu/KqikYJ7VLQwhe9pRkEhZGy6cPNyW7rV8B?=
 =?us-ascii?Q?KHgOX9mCWAxPFeKnqzDVOYl+grD265BLI9Z6tPgVVzZ1/w14FiyYORVsgq2E?=
 =?us-ascii?Q?CC+4xws7EazzyPsa3S06eBPTbz2iMpshfqZHBgWOKwoVJPgL6CGzvMG43mKx?=
 =?us-ascii?Q?yD6Wp9qnQOTZMxq9KL5e22j4z/mOol/2mmiAb7FziWlhf3qyXx3S8WzvRkpm?=
 =?us-ascii?Q?nzI9pRqIB9vzgoSHIyMG3DHKKSL0MuGJh3/sSlwemkfDDGIodg5nuAM2qjvZ?=
 =?us-ascii?Q?pAmuAWxR77mf1x1SQny/yeu1qfHqTtelV/3zvcFAT5vRajmHoKIJcp0foOtr?=
 =?us-ascii?Q?jkmsB9nLgK9uGt8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:31.1570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2392a0-fc55-4901-7988-08dd5cdf3620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458
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

If we don't have kernel queues, the vmids can be used by
the MES for user queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e585e8690edf0..d7cdd2895889a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -142,7 +142,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
-	adev->mes.vmid_mask_gfxhub = 0xffffff00;
+	adev->mes.vmid_mask_gfxhub = adev->gfx.disable_kq ? 0xfffffffe : 0xffffff00;
 
 	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
 		/* use only 1st ME pipe */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 95d894a231fcf..19a5f196829f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -900,7 +900,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index ea7c32d8380ba..598324e736092 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -837,7 +837,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.48.1

