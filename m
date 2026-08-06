Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D77C56207
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 15:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E506010F21B;
	Thu,  6 Aug 2026 15:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pCc/gxeT";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF0A10F21B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 15:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTZi1BQgXanNbkybyPoCpk5mcsXkPImc/RcL/4796Dq5E3xgMTTVFpcGkcZZVZhy3AU/mL3Aay1Lc75yxFAYcn3xp6zt6qD7XSgvTzPWJqy4xFot8LohIO0doI2p9bo8hxy3/L/JW93ZrXvvC031Ws3R7XM5eq/CI5xoOi/f6O8wo2vi1/iSe+SzZVEqpJ3OsorLXEll4O06PDjZZqb73IHuA9z0lkfhASfzuVqNXNulC1hLIM2BJnUkDV/5ndFtu/OgH6bs1kX5hnGhhAXAVK8zkS7teiy0+fpBVtbeypQdl6suHTMQYtbax4ED3w8t85ToFHzz0ogRnTzbLzYpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zw9ngcT0h1dSWK2Sopzzr2BS+8CEX68fBLdKTGgGza0=;
 b=skoMdJ/i8NWQ9m4Db1PSkcbiqGvRfZoxTnJnUB5cRI8IoGuUrtiUI4cVBWKicBjpqSdW44ploBv/+JW9RRuUMJzTiDkttD7BF6tBt6kdKikpLtqGihJNiPh5Da8yyenbX8ivY/m8Adq6LOr2v1wvYFFuwTVC5DFEymxbWyEztq0fO1PYuFf45ppZgOBQKcrvAFZlH5VCObtyJ6agk/I89OjdmH9Mle6zTknQwqkwfXUIzF4cIGf6omeBt933hF7260qBUuBZqSDQeTyh4kl3PKedDNcw8Pnu5ciHC8X8w7VH/70qJtoiYH0froIenDg0odYBv0qEM1uTRqwyzcVfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw9ngcT0h1dSWK2Sopzzr2BS+8CEX68fBLdKTGgGza0=;
 b=pCc/gxeTaX3dbOaFTbEgmjP6iyol1yJctYHIuPWoVH3eaW8HH1UrDMWD+jVESfgsCBdvMoOZxqDs9ymaflrA1HRGWmGJN8bmrSHOShxv0k2CLID7v3GXE+Ozyqn37LBc5ouCQjRtTG3fIiwHYCgzHrn6iyF+p3SkyQMSUf2lGBE=
Received: from CY5PR18CA0036.namprd18.prod.outlook.com (2603:10b6:930:13::21)
 by PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 15:11:23 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::17) by CY5PR18CA0036.outlook.office365.com
 (2603:10b6:930:13::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 15:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 15:11:23 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 6 Aug 2026 10:11:21 -0500
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Sunday.Clement@amd.com>, <Philip.Yang@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Reject zero-sized AQL queue allocations after
 size halving
Date: Thu, 6 Aug 2026 11:11:03 -0400
Message-ID: <20260806151103.122321-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|PH7PR12MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ce8721-9ac3-4bb1-78f6-08def3ccfa49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Z3s1HJyEilMI70QHnnhDUQ+YT417VUkH4FrNHUSZwpPh6mCIlKcnUAQ55X84Pq8bjfXbl0uKZBM9mSHPlK83NyU10cUt2u/b7asUsGmtLdugQCMtlEwxW+emryZiTqaNxAwZk9vj8ZddTKoRVWGn8AX53+aa0zyDD4zh1x/3Sb6c6buqyu/1lgVHJkDaLew91febZ9RK++eeFiY1wLeqd2SZSjYoHVoY9sg2TdAWhyRnTtZRMFWRMH8ilHAoPW7ZJdgT6Wsi8bu1EwWuwLa6it6MjFxiKPd2b92RAXVPfEKFzX7zg0qiaLJMCLbHd9LYwxKtDucVl4c4AVnxeZG6dXsci9Vi7ZCfhkS1GFY8Z56fhY9iijveCzoaxpL4CK4Qeu9exhB5Iq0V9/fwG9odZqHAo+n3akNE296hxAe5ACg4v7WEB1USgPq/V8uUvHfScxTxsqJaOxco+nsnsNR51e1O+ld840WgCZuwTAA4ofNo8c4fh4wX74AtdolydTpkURpi9jcLWe2Ua6EWuqj2xh2ptCgjVO+ITa60er9JXElHKsoNtUMdviRriS7FDBUWUluXsgDqP0Olfstk0GMfTs1XwlLpsisUTxYv8TDhO5P/53zP/viDteXZyI5aS2CAMJFiQi5uicaHVMERlaX8UmDoOmKZPzwrky/c7EB004/CyZgQDfCYRvgUiALACmxyMMV2zh10/CkTj9SJACDykw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bmzuhr7kNyiONjgxGVGb3hfzZf0iiV/vSytxu3sUzumPsHeUgCzQdD5cBPsLqkvokVa5IE+pb/5E5rhMZFFYWOrgEHHNf+KUys5oBi0a4JMdsj8L281C8lIZuvBrhidwjaJXCSXvYpnWMANesCWViFHcJaLgAeZrECQ11SyukIPFYvMUbXPP5ovO2yags9Te+MjXRdGVarcOVMRQRNQcg6AJBNP2NJ8OtltB9U5RkiZ/8zsnhNpKYNaYGVq/lpx4qYScK5zY4hJWJKpNyWm3V7EkyPIZgQi+4mNjouQKtRKP4gVY/tVpAU8ENzaOINlk/mIYN6hjMMCbH/KxzwMGTFBeKIRTZ6m1UMx/pZW0tQW7oD4wHar8pyFZexHRErJ2nmG2LFb9aMzqNs8wk5Xa2uS7CV7s0jXiKFHv4eXHXj9WCGdR4djq4ofyQd8KEQW5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:11:23.0305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ce8721-9ac3-4bb1-78f6-08def3ccfa49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980
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

KFD_IOC_ALLOC_MEMORY_OF_GPU with flag
KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM and size=1 triggers the AQL
wraparound workaround (size >>= 1), reducing size to 0. The resulting
zero passes through PAGE_ALIGN(0) = 0 without validation, bypassing the
per-process VRAM quota check in reserve_mem_limit()
(vram_used + 0 > vram_available is always false).

The fix adds post-halving zero-size validation in the primary
allocation path (amdgpu_amdkfd_gpuvm.c). The check happens after size
halving but before reserve_mem_limit(), and uses err_alignment_size
error path to properly clean up the allocated kgd_mem structure and
mutex.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 1e71829e0fc6..90a4a68478f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1795,6 +1795,11 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		size >>= 1;
 	aligned_size = PAGE_ALIGN(size);
 
+	if(!aligned_size) { // reject AQL queue with size < 2
+		ret = -EINVAL;
+		goto err_alignment_size;
+	}
+
 	(*mem)->alloc_flags = flags;
 
 	amdgpu_sync_create(&(*mem)->sync);
@@ -1886,6 +1891,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags, xcp_id);
 err_reserve_limit:
 	amdgpu_sync_free(&(*mem)->sync);
+err_alignment_size:
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
 		drm_gem_object_put(gobj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 309510e23315..bb0a2c615326 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1200,7 +1200,8 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 
 		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
 			size >>= 1;
-		atomic64_add(PAGE_ALIGN(size), &pdd->vram_usage);
+		size = PAGE_ALIGN(size);
+		atomic64_add(size, &pdd->vram_usage);
 	}
 
 	mutex_unlock(&p->mutex);
-- 
2.43.0

