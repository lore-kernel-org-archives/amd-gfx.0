Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DB3C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F155112419;
	Tue, 28 May 2024 17:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wuhb1e/s";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86DB210F818
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuPZXl2RDZTidZ0iRDzssrrqBR41b789tWiRUa7dAmEkZdiodfMZQKYaWFEKHN4v5zDRr71fFcXOf8N4c3VyUeDuXSBgHX9PIeRyNY4mBOVay6HcEzy7g8YUR/g0PltJqBKDTgDA8syxhJs52Z8CbuPlKNS2ti5WYmBCSStlyuaOeUaQG/GZ7SyyQzJXAy68AJx+hVKFJiI2Ybn4TM+kDjpAa0FNKu7jof9qtOCkkjHXOOtKtcwPlW846ZfX//JPeSVCGyOMHY/Zeixm5O1AmRI3+b0mUD3VZsX+MS07hP3qbCWgyCpJvdSx0m9mJIV8GAQ+9DESQW4qABP/+jOljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3Nxawf7eeLnxdyyrNqws09xonEMX9X82v81nCFbOMc=;
 b=EqdPhlTpg5KK55IRaU/3xeYIZT0Zcn1xjmZo+wuREHioqCg1rrCqHrAYxmWKltXexqQtFGsdulU+Wx+JoCdt96BnWlE3aXOt6XaSe5+SjT2oF4LSwhST2HVOepP/2tNhD8qfpgIQ6PNMYUPzJHCYrpmtKhCLbG6Yrcj35yj+hpAcI5Hmu0odxPanLcQcWruqJs6MDOMW2z7JOjcx4xxD3tEONbSvFklqERdiHeXtoyff5tx7t9jh0AKsp4QLRjIXJpEbo+BtEQH+W6NZldoKi1ys3r3GufoNE2yaUET61MG9FV/aNuFE+FnnAAs7/Dn3oSrQGcjcVDPxRmQBimEa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3Nxawf7eeLnxdyyrNqws09xonEMX9X82v81nCFbOMc=;
 b=wuhb1e/syN3ZZTT3SUHMIu7/SjpQa0cTXXJrxU3pg+cYhxmC6Is9/2WrVa83LRGcLj7QsbW5I3IpcM+RfMsEGXm+Q4yMhVVMNL/9azfVfth8ulj9d52jgsBrwRYQhU5tRqUEYyX4gtm/rv5pAtKssQclCkFhkcRU6dkQQ7W6TzI=
Received: from PH1PEPF000132F4.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::39)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 17:24:18 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132F4.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 17:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:17 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:13 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 08/10] drm/amdgpu: fix locking scope when flushing tlb
Date: Tue, 28 May 2024 13:23:38 -0400
Message-ID: <20240528172340.34517-9-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: a52d70b5-7bf9-4275-5ff3-08dc7f3b0137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pCOr7D1LSpBqAQegvW7hdc9Ps80grat9UoSaz0cL7hCRy9lyrYUVM7LRzolM?=
 =?us-ascii?Q?WD0YVWcf9N9yuf6Ltn+3QwxmtQZIPUcF2y6ORvRDjc78TN+UaVFFJap2Ghk4?=
 =?us-ascii?Q?CflMytAfPw4dt34Y6yAR5PWMF5FqO0psdPc7VlPx9K4X3CjLtKWm4DjZnr9G?=
 =?us-ascii?Q?gJVcNwNl1/SDlNU5wdTwA/Jad0xXf6LCbAjVGn/K8twSGUgKc2CKOV+p8UYN?=
 =?us-ascii?Q?eTzutJwejKFnMbzH+tjcPFJozOzl0RN6mlnJpqy8U+wyKHOXk9eeBdqowkiE?=
 =?us-ascii?Q?0okQvqs4tqCZJZnOOg0D4x8qnPyf/wyvbcs3ji0eufduOLH4fsFZvKon40cq?=
 =?us-ascii?Q?t7d2ZGyqVOvl5X1niTb7hDb8NQ4XWQy2/eVwyaSbfhup3ZOFOGQHUfBZAPSW?=
 =?us-ascii?Q?fcQDwNEiAJodFDu7vfjYiHlpgdKP4rfE3zZIe0IomDMTza/QuHhmy0tt1Uij?=
 =?us-ascii?Q?toDj1k5C9PP41XhzhhC6mCBHUVsTwjClo2WQK8OJ8qb6IQ0IF8UtKLZlw3/J?=
 =?us-ascii?Q?lAmLTIeL7/AAcprxxXWWDIZPRel8ZoP0LLLoMmAI0KanTqBOqCEEDj0EQy6T?=
 =?us-ascii?Q?CKJzA/W1+0syCLnBJnVUIXOpqJSyGGa0jzw+X8HBd31+peBhUQMJxEAITkLf?=
 =?us-ascii?Q?LFbuGpYLHG8SccvIMG4rQXQ1CJUR+w8RE96awcuXx27FvSTITR/iNJRympKQ?=
 =?us-ascii?Q?IWJHL3gQHjVtKrdu1LhOm+7O5ps/RJ0OH4UKQuLOWAvOnXdsKGcc7PPffcVg?=
 =?us-ascii?Q?kNtdg8gS6xaPIBW3yxnZBLsUz2/tS109jhVJ9eqfqcmcdTOvSp0kW3X6XudK?=
 =?us-ascii?Q?qrgpLH7KcuqV1v+I0ZuPSKGv0UtrqGJ2AG+EaxOHwaP+68YMQFrCBF3WurMg?=
 =?us-ascii?Q?NdbfGLZjy7TfCeUJXAD6TCBCp0ZOpwiizChl3AOkFj40D3zcDwO833jBu+7t?=
 =?us-ascii?Q?sSi2LcVOu1IO6OUlbxcrbHOxb/0jLJ5/cOmauxPRdCNF1VyMzgmAV8/hO1LJ?=
 =?us-ascii?Q?g7c6B44reoI3WSCidH8/hN3BnVi3UYEL6oZF9yG8OiqVjZBYiDSp0ihTJ00K?=
 =?us-ascii?Q?0vcKJd1icfGXjueodAHRBFw/J71jx3/5KgpOOjSiSKBeZOsY+S0OO+vDrD/q?=
 =?us-ascii?Q?aWZH8rRgmqqFbmFYz9UQX8bQETHmOlsPzZ1ah2dHXvEq2zztj2Ld2OqW09/0?=
 =?us-ascii?Q?9MMknH40JHY7I/BlxIKb6xwEVMIuQ6hqLQw9TQYpQD4Q2js6BQW4QDJzR3Ye?=
 =?us-ascii?Q?cnZKyI4+PUFgxLAOXCsbhTslFzP6Sc1QsEw2gczunc+Zp/5oy6xY5ELevRK6?=
 =?us-ascii?Q?dSSVpYLzQC/q0ejySiCz0hIrPZaXl9HKZZ+5PGv6KDqiwaWdqrPHvcSmd+d6?=
 =?us-ascii?Q?fcathG8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:17.9034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52d70b5-7bf9-4275-5ff3-08dc7f3b0137
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
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

Which method is used to flush tlb does not depend on whether a reset is
in progress or not. We should skip flush altogether if the GPU will get
reset. So put both path under reset_domain read lock.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 66 +++++++++++++------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 603c0738fd03..4edd10b10a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -684,12 +684,17 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	signed long r;
+	int r;
 	uint32_t seq;
 
-	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
-	    !down_read_trylock(&adev->reset_domain->sem)) {
+	/*
+	 * A GPU reset should flush all TLBs anyway, so no need to do
+	 * this while one is ongoing.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
 
+	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 								 2, all_hub,
@@ -703,43 +708,40 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 							 flush_type, all_hub,
 							 inst);
-		return 0;
-	}
+		r = 0;
+	} else {
+		/* 2 dwords flush + 8 dwords fence */
+		ndw = kiq->pmf->invalidate_tlbs_size + 8;
 
-	/* 2 dwords flush + 8 dwords fence */
-	ndw = kiq->pmf->invalidate_tlbs_size + 8;
+		if (adev->gmc.flush_tlb_needs_extra_type_2)
+			ndw += kiq->pmf->invalidate_tlbs_size;
 
-	if (adev->gmc.flush_tlb_needs_extra_type_2)
-		ndw += kiq->pmf->invalidate_tlbs_size;
+		if (adev->gmc.flush_tlb_needs_extra_type_0)
+			ndw += kiq->pmf->invalidate_tlbs_size;
 
-	if (adev->gmc.flush_tlb_needs_extra_type_0)
-		ndw += kiq->pmf->invalidate_tlbs_size;
+		spin_lock(&adev->gfx.kiq[inst].ring_lock);
+		amdgpu_ring_alloc(ring, ndw);
+		if (adev->gmc.flush_tlb_needs_extra_type_2)
+			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
 
-	spin_lock(&adev->gfx.kiq[inst].ring_lock);
-	amdgpu_ring_alloc(ring, ndw);
-	if (adev->gmc.flush_tlb_needs_extra_type_2)
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
+		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
+			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
 
-	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
+		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+		if (r) {
+			amdgpu_ring_undo(ring);
+			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+			goto error_unlock_reset;
+		}
 
-	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
-	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-	if (r) {
-		amdgpu_ring_undo(ring);
+		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-		goto error_unlock_reset;
-	}
-
-	amdgpu_ring_commit(ring);
-	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-	r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
-	if (r < 1) {
-		dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
-		r = -ETIME;
-		goto error_unlock_reset;
+		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
+			dev_err(adev->dev, "timeout waiting for kiq fence\n");
+			r = -ETIME;
+		}
 	}
-	r = 0;
 
 error_unlock_reset:
 	up_read(&adev->reset_domain->sem);
-- 
2.34.1

