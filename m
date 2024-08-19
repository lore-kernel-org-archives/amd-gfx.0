Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F106C52D6F
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 15:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD66310E2BD;
	Mon, 19 Aug 2024 15:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L9dYsMiO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3557010E2BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 15:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9W8IBusAM9M0/mKHCQaYjlkHCw7eO67rxdQ6AX6xRcQyVTASy5BZzDbty/XR8b1Eb1WUixzrQldXMRLWqM/H2w0Fi7qrkWHnxvXHa0fQUB89YktBgRH7qGA3nQGxnaPANJ3SWForfVh7HwSORsP4KJAKmOEIJU1EzkXo/Y2YDb4eue4unuodziZRN2FpUaTrVokOHEEnVVKJppfMZBJuw11ye2gMBMv9/Pwi/5M9cHIGqO4hjwPWccjwZdZxZKSrZTPCeMVnWUj591c/dZQbbRdRJ8G20OxTlnhN1bNsss67RVkOvcaJXD0Tyrq+YBv5i48PuVkeAWegrVBd2yUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCgJJVANZJyTdFYPME6NxCm/VlGvQ/nHAkvgDtZ08vs=;
 b=Kl2uBZsHV5jWSyEdkVM8umeRBzt4iCxda1O+PM+Nu7SQEPIv0XbJNCdWt9QT108jQ10SCblx5Zuoc4kfx+60ZOLxmLnLKBLojMXsT9bkZVTlRO6k1SsVFZXCmXGIyIUyZWMHusvEeAekqAgXtAll061x10KNIC2jiS3Ka7vcK8TmB6QGRWtJ6B+getTUNYSAcr1h2YObxv2RXnRJAA6XsSJjX7LiobGPX8lUZg4pkp/BW9s3D8vKFVIUwVwZmhnECNPqHX6yqcUp0iWtf0/MAM2GWxg/UfHcuPq4jDr1n7783yvNLhtAyvPKBwv+D9WDuqnA+VMp8KGZPWRcccxArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCgJJVANZJyTdFYPME6NxCm/VlGvQ/nHAkvgDtZ08vs=;
 b=L9dYsMiO+9rD967K3XFzoPCiiukofkQrVleepr5rzWDUGJRouivHV2zhmkQrNfK27aR1zpFUViY/oWxkwy9jAlQqsZR4/k/UFSag36/GW+H5wkDrgd+PwrgXkD+VMTAMs4jOJP6RRCE07T99diZOpis7s99l1ciKE50TMaT5qX4=
Received: from PH7P220CA0077.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::12)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 15:15:16 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::a8) by PH7P220CA0077.outlook.office365.com
 (2603:10b6:510:32c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 15:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 15:15:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 10:15:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 10:15:14 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 10:15:13
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Shikang Fan <shikang.fan@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Retire query_utcl2_poison_status callback
Date: Mon, 19 Aug 2024 23:14:37 +0800
Message-ID: <20240819151437.13808-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240819151437.13808-1-Hawking.Zhang@amd.com>
References: <20240819151437.13808-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c9f755-039d-47e7-0010-08dcc061bad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HnwonaoZ2kdzGAgpj79vE5WV0IVhJ1JHnXWXtklPorHjGml70oluaeyKTlW8?=
 =?us-ascii?Q?OF1f54gz4i+dJ7IEfa5uhXAin7vzHiutTWvkWGzZJSc0fGB4onCoa5hqLPAh?=
 =?us-ascii?Q?Z3fAekG+0hTMnMPMPCnE+u40tPri/qM2gzu7GykgYfiyi/+RcI+iPJvsV3Ei?=
 =?us-ascii?Q?SvwaPndcBv/SA4gQDGTvlbQQENrTMwBbRh26LGxFMfL//X3/vYqEBDosgJYI?=
 =?us-ascii?Q?9Mh18FLk2tga3NDBHYDXTxnenmHsgYc2H/WwDhLfiHCjvRpCjqOHho7rm4te?=
 =?us-ascii?Q?VhUE7Dv5Bs3PWEBcdeuzLa0i2KbIzh8YJOfMxHHseYBkyGV8TNkfEgtx2Z0l?=
 =?us-ascii?Q?ByVgL6Fx1Yfda9KU1gUl98vqx7idXsBFyepoT5+4iAwNUMHeTn9EjDfnrsah?=
 =?us-ascii?Q?JUtdVaKmBEPiPozcPqo+CGmidvlwE3TfYRGJEoQksxelobt4oYxWZFqCT30c?=
 =?us-ascii?Q?63zRf+k9BrgbgCadIHoKpLSce6nZQLVzry0SRiAyUDx0Mf/zjWCC87M4j/sU?=
 =?us-ascii?Q?M8bt8HKkiH1Vub8EvOGjFtGEitscrv/PzcZtS5BacqqnXIcZH6zB+pr+nCW3?=
 =?us-ascii?Q?kv5ArdKbWmwuHCkpBjD6RZidNTgVpO8GermPApfM2xwWl15ORqYRsTQc0eV8?=
 =?us-ascii?Q?iyxfOk0Ct04jUsk+LrEmw4/b35WFm0ep/AFKSfiJ+R7Q47uxDBl4obCpEIOL?=
 =?us-ascii?Q?lCFhSS/fhCkTx9pN6eU7eJN2nHPQ1T6LihgGqC13Z4A2g6Rv6/ICskGAUMrW?=
 =?us-ascii?Q?ByvABhb5u8vL4RL0xJ9wDLCjPwM8sv/ab2gz/bYwA5crB/zyglH2FpIv3249?=
 =?us-ascii?Q?2IPKEVtvjg82X8nqIxvlIGWXVGVJtHjZczwks7Um9wVAy6FNOKRqamFokjXs?=
 =?us-ascii?Q?nsT+ufltnppSGY8FQAIOd2XDlHOnA6O/tC/8tCvHUcjYqoBMS8jb3bv7+gzT?=
 =?us-ascii?Q?dnbPlAgKad1n0eIKQtGPwgAnympGoUy5I3OAo+KLAFx/+yraWjuFY/gRUU9u?=
 =?us-ascii?Q?qyKa3yKpCoHXqSsiU1RIyKsxLDPbyG+VAbMyVmelaw+C28Dit6PB/9NUnitZ?=
 =?us-ascii?Q?urmyqOEHLa+ic0/jyocOdBQIxYlx7RWvBoqIArAYB7AICaBj+nqrMzJR+Ef1?=
 =?us-ascii?Q?NJyDLQo9R1b6wFN2QLxffhro4ZGl+t7KPpv6R61jSkriYvNjfNbf3gHLR3yb?=
 =?us-ascii?Q?Uy+vbXzEJ93SXLYqigTsdhKrowZyeEKiZJ4I1kMks/rk4opZN+xElqpBq9/6?=
 =?us-ascii?Q?2nMxKRN1051WqmHYIT3RaYjLTkvEDVTm2kzJJSqC43rSQcCAnwx7vMozcxmA?=
 =?us-ascii?Q?Hnynj3ehi696Q8s60qImYuGE7o6fS4dXsMDiinmDdaQ2k3R1m5RQTVN2QWNl?=
 =?us-ascii?Q?ziRJjvdhtnYdxv8ghM8lDZAREsguGaFbxBbWrus/Ra4Pfy5P2N1yORDjQ6h7?=
 =?us-ascii?Q?0Cl2SSR670pBKcVhjuzVvrQ5vhG1/LcJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:15:15.7178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c9f755-039d-47e7-0010-08dcc061bad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
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

Driver switches to interrupt source id to identify
utcl2 poison event. polling interface is not needed.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h  |  2 --
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c   | 18 ------------------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 17 -----------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    | 17 -----------------
 7 files changed, 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 64a989cbc301..4f08b153cb66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -783,22 +783,6 @@ int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
-			int hub_inst, int hub_type)
-{
-	if (!hub_type) {
-		if (adev->gfxhub.funcs->query_utcl2_poison_status)
-			return adev->gfxhub.funcs->query_utcl2_poison_status(adev, hub_inst);
-		else
-			return false;
-	} else {
-		if (adev->mmhub.funcs->query_utcl2_poison_status)
-			return adev->mmhub.funcs->query_utcl2_poison_status(adev, hub_inst);
-		else
-			return false;
-	}
-}
-
 int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev)
 {
 	return kgd2kfd_check_and_lock_kfd();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 825c7ffe4bc9..f9d119448442 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -350,8 +350,6 @@ bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
 bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
-bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev,
-			int hub_inst, int hub_type);
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
index 103a837ccc71..c7b44aeb671b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
@@ -38,8 +38,6 @@ struct amdgpu_gfxhub_funcs {
 	void (*mode2_save_regs)(struct amdgpu_device *adev);
 	void (*mode2_restore_regs)(struct amdgpu_device *adev);
 	void (*halt)(struct amdgpu_device *adev);
-	bool (*query_utcl2_poison_status)(struct amdgpu_device *adev,
-			int xcc_id);
 };
 
 struct amdgpu_gfxhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 95d676ee207f..1ca9d4ed8063 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -63,8 +63,6 @@ struct amdgpu_mmhub_funcs {
 				uint64_t page_table_base);
 	void (*update_power_gating)(struct amdgpu_device *adev,
                                 bool enable);
-	bool (*query_utcl2_poison_status)(struct amdgpu_device *adev,
-				int hub_inst);
 };
 
 struct amdgpu_mmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index d200310d1731..0e3ddea7b8e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -443,23 +443,6 @@ static void gfxhub_v1_0_init(struct amdgpu_device *adev)
 		mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 }
 
-static bool gfxhub_v1_0_query_utcl2_poison_status(struct amdgpu_device *adev,
-				int xcc_id)
-{
-	u32 status = 0;
-	struct amdgpu_vmhub *hub;
-
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 2))
-		return false;
-
-	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	status = RREG32(hub->vm_l2_pro_fault_status);
-	/* reset page fault status */
-	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
-
-	return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
-}
-
 const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
 	.get_mc_fb_offset = gfxhub_v1_0_get_mc_fb_offset,
 	.setup_vm_pt_regs = gfxhub_v1_0_setup_vm_pt_regs,
@@ -468,5 +451,4 @@ const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
 	.set_fault_enable_default = gfxhub_v1_0_set_fault_enable_default,
 	.init = gfxhub_v1_0_init,
 	.get_xgmi_info = gfxhub_v1_1_get_xgmi_info,
-	.query_utcl2_poison_status = gfxhub_v1_0_query_utcl2_poison_status,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 72109abe7c86..ed8e130c7d19 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -622,22 +622,6 @@ static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
 	return 0;
 }
 
-static bool gfxhub_v1_2_query_utcl2_poison_status(struct amdgpu_device *adev,
-				int xcc_id)
-{
-	u32 fed, status;
-
-	status = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regVM_L2_PROTECTION_FAULT_STATUS);
-	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
-	if (!amdgpu_sriov_vf(adev)) {
-		/* clear page fault status and address */
-		WREG32_P(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
-			 regVM_L2_PROTECTION_FAULT_CNTL), 1, ~1);
-	}
-
-	return fed;
-}
-
 const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.get_mc_fb_offset = gfxhub_v1_2_get_mc_fb_offset,
 	.setup_vm_pt_regs = gfxhub_v1_2_setup_vm_pt_regs,
@@ -646,7 +630,6 @@ const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.set_fault_enable_default = gfxhub_v1_2_set_fault_enable_default,
 	.init = gfxhub_v1_2_init,
 	.get_xgmi_info = gfxhub_v1_2_get_xgmi_info,
-	.query_utcl2_poison_status = gfxhub_v1_2_query_utcl2_poison_status,
 };
 
 static int gfxhub_v1_2_xcp_resume(void *handle, uint32_t inst_mask)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 915203b91c5f..b01bb759d0f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -559,22 +559,6 @@ static void mmhub_v1_8_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 
 }
 
-static bool mmhub_v1_8_query_utcl2_poison_status(struct amdgpu_device *adev,
-				int hub_inst)
-{
-	u32 fed, status;
-
-	status = RREG32_SOC15(MMHUB, hub_inst, regVM_L2_PROTECTION_FAULT_STATUS);
-	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
-	if (!amdgpu_sriov_vf(adev)) {
-		/* clear page fault status and address */
-		WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
-			 regVM_L2_PROTECTION_FAULT_CNTL), 1, ~1);
-	}
-
-	return fed;
-}
-
 const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs = {
 	.get_fb_location = mmhub_v1_8_get_fb_location,
 	.init = mmhub_v1_8_init,
@@ -584,7 +568,6 @@ const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs = {
 	.setup_vm_pt_regs = mmhub_v1_8_setup_vm_pt_regs,
 	.set_clockgating = mmhub_v1_8_set_clockgating,
 	.get_clockgating = mmhub_v1_8_get_clockgating,
-	.query_utcl2_poison_status = mmhub_v1_8_query_utcl2_poison_status,
 };
 
 static const struct amdgpu_ras_err_status_reg_entry mmhub_v1_8_ce_reg_list[] = {
-- 
2.17.1

