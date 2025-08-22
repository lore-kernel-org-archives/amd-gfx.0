Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369A4CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 08:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA5910EAA0;
	Fri, 22 Aug 2025 08:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pCLJC7v5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8966710EAA0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sO6Zbgbc1iGhwrWYnunIOaEH8aXsAAvokiNXXgZUA1H0WoZIDaH2mGWFPzckidltsKVIvVFYoYJg41uReZAuOA3/vmefWwqrGlx0RrV5GVMh2u/+SSKqINSdnhrpU6fVcnEXP+lhs0NFNKVZ106NOh+KyaVrA1HI0s+fEX5JQDPT1TDOEWmqWi/mn3MbS1ACw4hDnWdcMvdzm5K9trd/YbTeqJ0TWGAsrPeFr+4jQuVs5ZluNzya//oFw5J5BYn8hYFkQVxc1Jwm9CjKc/FPNpsCVLgV9FHs2TZBwC4mnz0plSX5Vm5THUfxUs6IjpqOxKBHMCgq27Pv7xWesDsd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=VmBKCt/Nati9vHZPCamNb1jg8aqoryR2tir6/XdeA0dPNTKSCadOQ8RjQePlBANtCo+ndCCmmBN2hvTePLYieDuzESpRNMQlXxSLwpaAGFWwiKGGTDWPuHgd0qLs7OP7uNauKT4sBBttu2wUlHnvNv6v2hcV7db8UBaGuFWH4DXuggPhIwmDbehMoHZCcnaHeD8oQrb91JE39LhovHb16PONQAF2GPoJrYD42MmV0WbfSBzjpAfoCMnfP3dBi2KXnbJZThPaZr2JcXfUvxmzyhSHUYLYSXQQxSgFN/B7k0fp77VvWMYEGEmJMM+LDhs//jMdWbwFEV/fr/tUMtBflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=pCLJC7v52Rom1bHeG9/ufKJ+cWZpjlKcrLdMIRLIRi4SkSmlRKRDzEuWj6zitISHBK4CrdBBDtXm/WBZPTrcYcQTU/rGf0Mh4ZpH1Y7tRM1/6rtb6kQ7nx/sbmi58gqHUm90SCbMYL9n66qDKwzOMdbV2wulvXy9oGIQAsOOmUM=
Received: from CH0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:b0::24)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 08:55:30 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::64) by CH0PR03CA0019.outlook.office365.com
 (2603:10b6:610:b0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 08:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 08:55:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:55:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 01:55:28 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 03:55:22 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v10 08/11] drm/amdgpu/userq: add force completion helpers
Date: Fri, 22 Aug 2025 16:51:11 +0800
Message-ID: <20250822085434.970798-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822085434.970798-1-Jesse.Zhang@amd.com>
References: <20250822085434.970798-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: cb19c953-fda2-462a-4e49-08dde159a581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm1IeVRvQjlwS0FmMzFWcFB5b3ZRU3N3aEpZYUNxdXBjWEYxb3p3aUZCbWdE?=
 =?utf-8?B?c2dSVFZZTDFhWi9vZlZHc05QN3lvN3BMcHY3cVJ2WmNnS3VZZFB6MmhDNklN?=
 =?utf-8?B?TUlqd0JhYmFwdFYzd01BVW9HSk5lcEZNbWxJUm45ZFhWRHVpL1JvUUhtTnQ1?=
 =?utf-8?B?RmZrM1VEN3hFclpuYU9sUnZnTWxHY0krWjk5cUh3N3JDVUNLbjJrUGppeHlT?=
 =?utf-8?B?VGtYK2h5OHBEczd3S3FUZU5xeHJndndQdVNKMllNd001emxQbWVEZVlRdkJY?=
 =?utf-8?B?V2Iyc24wQm5sQVZ5QXROQi9EM01SNUdlcHJFZUdhR1dEK01XU2VGSlhRclFD?=
 =?utf-8?B?K3ZrR0Era3k1SGg5dVVDVENoOEtwVmU4U200UDU0a3JxRTN4V2lhS2ZlNG5W?=
 =?utf-8?B?aEl5cUdJc2FYMjRFajR0VzQ3TkYvTW9adWpLMXM4ZXBpcXh0SlcvRll0TXJM?=
 =?utf-8?B?RFl2MWFVZVkzQ0J4UFlRM1MrdGVGZnprUjdDMTNZYWhZNStrSGN0TW44ZzQy?=
 =?utf-8?B?WUJYUHlUbzc2Wk52VkdpY1o5WGY4QUVGVTVWQ3NKZFp6L3UwUiszVXlucnll?=
 =?utf-8?B?cWNEM3hObXpqdGFETGtUVVpzWHZldXJ0SVVySHRyWEFFcURlelhJcmZWMUJD?=
 =?utf-8?B?WWxweUxPOHk5dUh3Q2w3SUx1TVFwYmw3N1pEb29mWTFHVURnZjdOUUtsOXR1?=
 =?utf-8?B?c21vWGJ5eVVFNG9rZ3BrNmN1Tm5WTyszT2VaaHJYWXM4U1ZlcXZnQk01anpr?=
 =?utf-8?B?elVTS1NXQXhnZGxDejNmVTdTM1VZSWdFMWFFZE1PU3pkSHdicWxuM1QzV2o1?=
 =?utf-8?B?cGx2MHF0TnpIUFU4QkxGTDJJTGZLRGxOMDdoZ0plbHdQUEFpS0NDT2JReCtp?=
 =?utf-8?B?dnhNZHZzSENkeFQ5T2dJQ1FWR2NiMm9yLzJWVFhxSStpRXpSclVxaXdQY2Y5?=
 =?utf-8?B?SzFiUnhTc1daR0tSMGJ4UHdqRWtLbWIzK2FURS9HVEk0NU9JdXVIb1UvbEty?=
 =?utf-8?B?ZnRMdUREQ3B3SXpQQXdqSmxWOEYrRkZKWnRaMHNuMzFOa01zN1ZOWDZJWlFO?=
 =?utf-8?B?aVp1cXFuT3RCY3AxYXlyaFVpbWJIbTE1VUFKMUxmQW9lZjZDcDdVM0lGYW5G?=
 =?utf-8?B?dmpJeGZHWHE4QTVXZ0hZK0xvMCtXTndWUkVDTGwyNFE4bHRTdE50NUp0VERT?=
 =?utf-8?B?NzVIU3RIaWhCR3huVUVIa2w0V1B5aU1pTVc4RWZWMFJzMlZRblpmRldYWHVx?=
 =?utf-8?B?SUsyY3RuaTJ5bktWL0paRmdnQVBzVnJ1NjJaVC9zczVLQTBlaHZrZTkvNmh0?=
 =?utf-8?B?TThuNXRheUxtdzA4MFd3YzUwREFzYmNMYUFYUFRzSWxCSVpacTZreThoVnRZ?=
 =?utf-8?B?NmdjNWRSSjlQU3ZNWHB0eTNzVjNIbDhiNlJDdlpCTWtHVjNONElBekYyM1RZ?=
 =?utf-8?B?WlgxejF2ZFZCVkg2L1BCU1RoK2FHd2RvZmIzYWJsa0psRkgxQ243YkN2SlNs?=
 =?utf-8?B?bllxWThiTEk2QjZERmNWSnNJUGluYlgrWjRmaXdnYVFEVE55blJzb3B3L3Yy?=
 =?utf-8?B?S1BxRkVYVCt5bk40YVpyQWdkeDd5R1Rvd0lBR1dCcGlMcEp5aGw1bURnclVy?=
 =?utf-8?B?aE5COUFrbTY3c05QVzBDTzQ4U2IrS1ZpRUlBbytGUWdPMWtGUjdrQU42WUFU?=
 =?utf-8?B?aXZHc3R1VFIyS3BiRElHYWxjNHNFSGQwdXlTQTNqZ2trdDRCUmtRcStJekxX?=
 =?utf-8?B?TUlZMmR0bWRmUWhwWkhkVnNUQ0NXL2VXRFk4S1BmdjRYSEp3bTJHdEJZWDVV?=
 =?utf-8?B?VWN6N25CVmJYZEVvTDlyS083RmNtYkVPVGs5V3haeWhvZzBsUVV5VVlTcTRP?=
 =?utf-8?B?VmoxTGFQcXJKcWEvQ3ByaHVleE9YV2NOZXdtZEM0L29wUzB4MXB3OFIvbERZ?=
 =?utf-8?B?cW5OOUgybXRWZ1E1dHMxQmMvU29xYVVMRE8zaUFLY3AwUkw1Y0d2bjF3bkJy?=
 =?utf-8?B?Yk1IdmRlaUNtdk0wQVRCM0J3UThKRHdJaW0yaXFESlFjS1BySncwblQ5Q3VJ?=
 =?utf-8?Q?0gQLQb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:55:30.0996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb19c953-fda2-462a-4e49-08dde159a581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
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

From: Alex Deucher <alexander.deucher@amd.com>

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deef..01688bbf3f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
 	return le64_to_cpu(*fence_drv->cpu_addr);
 }
 
+static void
+amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
+			 u64 seq)
+{
+	if (fence_drv->cpu_addr)
+		*fence_drv->cpu_addr = cpu_to_le64(seq);
+}
+
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
@@ -409,6 +417,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static void
+amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
+				    int error)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	unsigned long flags;
+	struct dma_fence *f;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+
+	f = rcu_dereference_protected(&fence->base,
+				      lockdep_is_held(&fence_drv->fence_list_lock));
+	if (f && !dma_fence_is_signaled_locked(f))
+		dma_fence_set_error(f, error);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+}
+
+void
+amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
+{
+	struct dma_fence *f = userq->last_fence;
+
+	if (f) {
+		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+		u64 wptr = fence->base.seqno;
+
+		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
+		amdgpu_userq_fence_write(fence_drv, wptr);
+		amdgpu_userq_fence_driver_process(fence_drv);
+
+	}
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 97a125ab8a78..d76add2afc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.49.0

