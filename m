Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C028BD38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C1D10E637;
	Wed, 14 Jan 2026 16:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J6WncxqE";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E36910E637
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDOciy4/T+hl7XmiwI8+Vw6NF8QRNqhzjGt4fA5PH6l84hEw2obxyDA+tlUUr63zGoVa1QOefL6tj9auDCNsOdRqgbHy8SQuSquMohbO+2MyJCx6QFOzrS0P2iuij9BJ6+DThznkUnTKw0V2yz2Kh3fmDit8+v21wfGag/4P+bFPJNJ25ya05WM/Spue+pSkuJYiLPPalCBW+tpVN3oegxfYOGuJgyo+IE0LHiwUrOwgqM4IcAtBZGCvrIPGW+6qzt8Lb5qRgcTrXVngUQTXCNxEp7Q0Ke3ZrrJLd9SWIRFgMkggK6ZFeVqvBFHi5xRBr2iIZuUMgdXHwmZGM/OeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCMhjV0YyDqQpkN2jjl8tyFfdZUNjIPi0MyDAvZUw/g=;
 b=BmBxduenGt+CSaqq/wE//+CV19TWgpJjYx/t1t77g/FVWlrIP+FfKtlw2FuFGtz9mjFSbOpogYstDSs9cc//Ck5x/vH7/3NB7wA8IuYtvt/hydj46zzwAyBrMn+4aW44gnTQq3wQh8RwSW5mtsg6H9O/WXzTJh9lxkN1IFAPUyQ0qOnKpWk5VxMMvfCaa+KRfQhEwAJka7tsFeKQ8WU8GiiYC18Fzs0t99l3R7x2O82tBSeUSjD/Icq0lG3P8qk+40lN0M39izvmohYmz+cmOP3b9UQ9CrbpD6r6+DS3uQm7hEvUDs02v89YFZTpt37R400xpSrx1hrYqlOqeV7CUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCMhjV0YyDqQpkN2jjl8tyFfdZUNjIPi0MyDAvZUw/g=;
 b=J6WncxqEAQHanuERJmNwTf+jew2X6be8aoU267jZzfLM4IWAajeVsHoAs/8c0G558bC885cDayhYHeHqU0BSA0aI4HSzwjrWcXf3rmrAQyccpJA7RD83SzH+ebCeYbVXG7ZwDbr38EOeDwuFGWYHKLD6ChZyn8XrwTQwFkBisco=
Received: from SJ0PR03CA0241.namprd03.prod.outlook.com (2603:10b6:a03:3a0::6)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:47:45 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::f1) by SJ0PR03CA0241.outlook.office365.com
 (2603:10b6:a03:3a0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:42 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 08:47:42 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/42] drm/amdgpu/si_dma: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:58 -0500
Message-ID: <20260114164727.15367-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 870838f5-5c0c-4d5f-9f47-08de538ca452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bhM/6yHsWqeF5IQw5URgWlM//3346mLjWY+jzeEHfGUZaW8DNL8j5S109oEc?=
 =?us-ascii?Q?kLYouP5j0s3EqySraPxZ2pesK0vGmeutjLR5Ffv0Bp5m9ht39exWJdEJJtG8?=
 =?us-ascii?Q?vF72ajAIMlhS5RgiEhfUGpScFqqTHS4ZMNrG8K5nlFsUpSwlejbB2ntPn2Tj?=
 =?us-ascii?Q?yOXw0VNQFXyf5Xp7oPXFFRsIC0dhRbZe1zzqf1UkyDfwb5bGY44k5SBfFidF?=
 =?us-ascii?Q?7tlpxQy7l0EtRkMLEcF43COwymqqEWeyNUDIB2dwGF6klICBXYk8tGpfymDI?=
 =?us-ascii?Q?KXt97PREjyAKDR2Zl9MnWrIYNqUV3NnmVlx0j9/zXh1p0exfRWfeiGsO3Go5?=
 =?us-ascii?Q?bdEewy7TaH+roZYkxz3lCJnL3ogwXY3ztym1IkSShjoh4ePaeeAoKvOLz/6V?=
 =?us-ascii?Q?3Sg8L4AEF2LNi6UGzXG2RjmEseo2+OyNmbmBKFzEBY0VsXmm3+dBHQgb/QFl?=
 =?us-ascii?Q?Utf4YXuoMpAUX/s7/YrDz9J8kXAeZwDFjax/MlNROLWB+RHpS++R+m6LaVw8?=
 =?us-ascii?Q?2aoCSx8kS9ktf/MP6Xop6eeUZYL3ASV7VyqkZhSEnip+9GVcRaxqKwY25koz?=
 =?us-ascii?Q?7VDxGRs/rZ3R2O+vlN4q38azkfLISW0kOyUBpeLHgfldh3hlhjLDTZAA4OdW?=
 =?us-ascii?Q?6gLmjosa+jIxFHcqSG4FJqDavD1VhNENo8OYU7lwiqZVDwFue6mPHbkslefu?=
 =?us-ascii?Q?KRKPSdyqB9iwu3nWwLu5jMfPdhvbGVXDbipu3wqxNROYIZyoSJEFtsGY62p/?=
 =?us-ascii?Q?dAXYMjs0ca+4960QPrkIKRXql97TwTp8olvkgxnJJftUh91c0Iq7c0y+MwsU?=
 =?us-ascii?Q?VTwlluqyD6GPQxFEgdaxpqhBInQDCs5vgn/hxK37oebKja/N6OLJpAz31cYp?=
 =?us-ascii?Q?JKOpcsfBZI2hBG6rCwpdlNGsL2IMs4J8JcqfTYK0+1LL+1Mlpub7iqpH7UyJ?=
 =?us-ascii?Q?1bOe+wnQVMbPi7DYavjyHR0BT2PFswAHtCRcT6E0RwilyvCucD6xDZCBYZh2?=
 =?us-ascii?Q?H7pPrLWhaTzdExl6UCN7/kbBua0i8thmNoVi6vV9tb1f+E+U8HYp76EQCccI?=
 =?us-ascii?Q?3y/TWAjLUauGfSsPMd4AZtzsLQvb3UD+i4OIZQ9Q3gLmUNecTRfJhs7BOhe4?=
 =?us-ascii?Q?i0mVIXLIZrGoAacCfDt8iRWctraX19OMsVfdjvXsSZLQT134j8i5lfM7YH6x?=
 =?us-ascii?Q?mgAhHeoyScV3eDpENgzl29Sie7qcjcOLDIsDaXEW5lNPZDt4AustCumx8Ecf?=
 =?us-ascii?Q?X+qm+WFAiN/KsL7AXQPr0aI/fyYz3NoNAgNMtzDiO79jkjg7p1PZyb1eupl7?=
 =?us-ascii?Q?jKnJGA8LBkv7VShIFFMnp+SA4bAZDiCtTA3LsJ/of+fM7AdIN+IuPZ7YShyn?=
 =?us-ascii?Q?zowGsaRwyDKTcFpv8r4wIX7m4Ev1POdhPQp75QsHKiZJSIOMYdS0+WMFJJsg?=
 =?us-ascii?Q?BdsbI1y8HacIXJ1Ln8e0LSRosuzms/4Gj9+plVxAe5swOTKRBiUHAf+C+FPg?=
 =?us-ascii?Q?BUkZZ4VEvL8Js3Z4wo6N6MLCyQ6XipaFaLPqhhIRQ1aLohOSIW7gXIg1Woqu?=
 =?us-ascii?Q?ZiitlrKAvacKVud51i+u5Qf6B2TK1F403Gg6RHen0qYbNzZSjXfwzicECAzg?=
 =?us-ascii?Q?/H4JqY69RKks83TxeYuxTXBZdkGVDUnZevOcgv/iM1ztByVKAyf5Uan3/m99?=
 =?us-ascii?Q?hlayNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:44.9264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 870838f5-5c0c-4d5f-9f47-08de538ca452
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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

Switch to using a job structure for IBs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 74fcaa340d9b1..b67bd343f795f 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -259,7 +259,8 @@ static int si_dma_ring_test_ring(struct amdgpu_ring *ring)
 static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -273,20 +274,25 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r)
 		goto err0;
 
-	ib.ptr[0] = DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, 1);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr) & 0xff;
-	ib.ptr[3] = 0xDEADBEEF;
-	ib.length_dw = 4;
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib = &job->ibs[0];
+	ib->ptr[0] = DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, 1);
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr) & 0xff;
+	ib->ptr[3] = 0xDEADBEEF;
+	ib->length_dw = 4;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -302,7 +308,6 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

