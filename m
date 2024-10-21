Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E440D3C53F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 05:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 030F710E0A1;
	Mon, 21 Oct 2024 05:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kfb/uaFU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 548E910E0A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 05:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKPg9sGudajxGrst7wUJNiuEVbcynr8uo8JI+sql4nkmcqToTy6WSFrtKqEhmGBuwcBtTPnAKX4RWQCAWFBBS6AfIcct9Qg84zFqT3l5aApLaLc/FZboUvFmCob+8Q+40EwBwTmIiB5hyi13YIS91M/NDxQ4rizqhGg4gUXa3S7qeh6KiT2BRQUGadsvMMFdTECECvweH1YflbHzmXECUB28CDxmI1rOtm2jESPhWYFuq6XLtu0ZcQzejk+m+2Y0m3UKNCDNqzXPrA8LzJIbZxoS1vw5xOv8z4i9NGDSkFc7ddLb2R74sgW+jGtPBCKmpQqWAOo91lqPfs39bR3DzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSA4Ww9+68Gb1rVKlFDNVWBAZYmwUlvr5N8MjogJIWg=;
 b=Ij18HopdF8U07MbHwG5IU3O3sO1PVvh+y9iU+9JlXXqNtYkJnlaJx/NYkHqAwEBFmzZ6uNnB3crqi/C1v9Zu2NrZRU8YrwBnzh3U3JKa9d1PjcRA2DD9iD1dCQH9G6FspVVDPGApMOF8HaODV/fOAKE7ffYmWFlDk/WYLOxf2Ms/9ARLSwvinJirdIG7pCTMy+8Tg17y55cfXG1Nw44kmZo9V/W036Pv61EGLcOhZZ4NJ1cbtTZfftuy7vhvwJBQB6WVeqPNfKCEDJsDFdMBuoT3Y0BQzNrwgBDeJ2fAoBeUx8goRpHCO/DaqNpCKupxr0exlOVNyOp7CB8i2PX06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSA4Ww9+68Gb1rVKlFDNVWBAZYmwUlvr5N8MjogJIWg=;
 b=Kfb/uaFUcvGRFtf8AGbPwAVtcagqW2dSYIc56ETPwVqv6zn/uor+hYUNn8AnEg857/+OqD6HPc2Bsin6BM9lLxe/QeshH93HE4IdbF6EY++fy+xZcUQXWIMwXzoWKCgrVaMnvd4MyP7lq37+DOyLtTLqlfx3BEPglj4txEVmL84=
Received: from SJ0PR05CA0192.namprd05.prod.outlook.com (2603:10b6:a03:330::17)
 by SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 05:57:35 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::dd) by SJ0PR05CA0192.outlook.office365.com
 (2603:10b6:a03:330::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.11 via Frontend
 Transport; Mon, 21 Oct 2024 05:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 05:57:34 +0000
Received: from lc-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 00:57:11 -0500
From: Chong Li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <lincao12@amd.com>, Chong Li <chongli2@amd.com>
Subject: [PATCH] drm/amd/amdgpu: change the flush gpu tlb mode to sync mode.
Date: Mon, 21 Oct 2024 13:56:43 +0800
Message-ID: <20241021055644.158966-1-chongli2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e060c82-1745-42c3-047c-08dcf1954296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WiGcWmAUwBmo1dSGjlM2nsvRlxs4oGq37KnMbm7TpGQbzfAEivvK3oaBN8Bf?=
 =?us-ascii?Q?VcHKTBvIsdS1YPfRECC/rJ7VFWEEti7ezW8Ssj1BqdrcsVVoF2h0r+zkDriX?=
 =?us-ascii?Q?whEwc33DFsBned3zm4vrcaMu7wOAV8SWN48fQKwH5BJPaCDpHbdeeQe4jbvV?=
 =?us-ascii?Q?rADW+iHLbg8tlKtz4RkikqQWkpANB2jmbI7D55mpJenTRdzTCTum/BqgFNZA?=
 =?us-ascii?Q?HimWdrs08+QfwmyCpc5CzEAnk1kSHR1T+pdJs7hvtErckEA6wfhWkcDstq7b?=
 =?us-ascii?Q?VxXQ0p6Y6WHpJL0EbZO+VsMWLu2w3FZkgkHC/kxV4qm6dILA4Uylok7udgu2?=
 =?us-ascii?Q?f0Z+M8eMTO7cLZoApC+03mAfXGv3L2mBuN7kbvmEU4cTR0zpNHyxLBb8cfcn?=
 =?us-ascii?Q?8NXIRMjKkgSieDumO7JNOvrwenUvMTwrFPPsKcrYSswnhmrZog21bdxmC03i?=
 =?us-ascii?Q?p6pLNE9jOWz2AnVADT4JVzi6YlAEd8EsQqxOPcwNoDmZ35Fgg9b30+MtnbIk?=
 =?us-ascii?Q?18XBf1/xnT1X+Cbo8Ygvkprcmq9HADfffBO+WRntbipOA172EQBzSy7udjcO?=
 =?us-ascii?Q?tVkwtNyMBgJgl1ERzqbzT675YeRjj5Li1f2/uzUN639NgcJXDYct169IeSc3?=
 =?us-ascii?Q?pYEl5qOxEQihVO+FA1VsWrC1XjZEiekaQRiIsMjfrWR0zA5XGu7+V7PxA15P?=
 =?us-ascii?Q?gR8q+NaNj6ov2MN+Tuyr1jzl2y8zzcdkHvyKN2Yl/N82Xp6BAZ/FINosSsNv?=
 =?us-ascii?Q?lCIswg3AhB3PdReUYxMeQFyq0BDWXcofEtXZHR2jBylXNyNBTSxqPOPxYeL2?=
 =?us-ascii?Q?GS6bgTtNVhoJmmtyTmOXiAOgofzgb/uofIN4qAzNBnKFzIvNE0VjMPr0AEaL?=
 =?us-ascii?Q?xKLuIp8sfGZ9o0Qh7zOjLQzDTtPKeFkmflbFIyYKIw268hwBtD3eapYbmfJB?=
 =?us-ascii?Q?Vp/Vujar8ZG0Rfqhg/ejbQBeCnKqAfh/06Zehu0RoePHsIKbnLlSCCEE82uF?=
 =?us-ascii?Q?L1mCWZtl+nM/6BXAnFyXyjzFzr5O6vB8OALErVSRwJI8sShfr/2Zrvm6UMb+?=
 =?us-ascii?Q?qjRgMrBzLwXBdsdEeO06WNWxWk9rjpU/SK+7PsAFC7vUUg39sgzY5Aju+6lF?=
 =?us-ascii?Q?4TpplMJF1m44yxhZJEqGmkTLf8GZFPnFZ5JssMZeqt+knZiMuN2E65T7sAJg?=
 =?us-ascii?Q?TT6rbkL72RxVuo0m24EMsGOYuwtZQ75MqRbEWA+lGUy5lEjqu85FeyMknR+X?=
 =?us-ascii?Q?VQn+AqR8058e4ok3YQQEaNgILYVBzbRLjbo4AlFLobhtGdyeg7f50KV2M1Pq?=
 =?us-ascii?Q?3aOo2IxxUf07HfqsYE9Fo/I8coRquw0fVjq3j8IImMZ90f7QUd4QCOPKhQZ5?=
 =?us-ascii?Q?/8t/R+WurwvQY/sUOSVaH5ZktjIUusvHJ6tTKCeyQyJAQ/3CbA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 05:57:34.7754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e060c82-1745-42c3-047c-08dcf1954296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697
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

change the gpu tlb flush mode to sync mode to
solve the issue in the rocm stress test.

Signed-off-by: Chong Li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index 51cddfa3f1e8..4d9ff7b31618 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -98,7 +98,6 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 	f->adev = adev;
 	f->dependency = *fence;
 	f->pasid = vm->pasid;
-	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
 	spin_lock_init(&f->lock);
 
 	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
@@ -106,7 +105,8 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 
 	/* TODO: We probably need a separate wq here */
 	dma_fence_get(&f->base);
-	schedule_work(&f->work);
 
 	*fence = &f->base;
+
+	amdgpu_tlb_fence_work(&f->work);
 }
-- 
2.34.1

