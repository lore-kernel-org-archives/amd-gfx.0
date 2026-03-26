Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB8B10A1E62
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 10:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF7C10E220;
	Thu, 26 Mar 2026 10:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eNatSJkj";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9245B10E220
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 10:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbrKe2zY23hUk6BqtMZNKDhmzpX7tIWROzBHokq6HHHgYv+d2x6kFXdJ15IdYDccmC1l/UxSZL5weVc6kHgl2Iakj8Q9Yx65sSyQ+gG/2ZGJRK0Z7Omms67bZMAW5pXg2kAHb1zAUGl+Yi+O497jCDYjv5uq8XBLVCFr9DNwii9b4VhwmhDtJOc+U7F4wJRuAttCbv6NSR/H6Q5EcDZ1wIiKAFkqTTPBl/JuAA6vExNSEAs2v0/qXli9Qm+sTFMr2dWYCorO5iSM6hKlXfxPXLxzoGQ2mUQe/pyHkIMq1djq8AZntixvSBD3ztJ9IpGnxyIgWDT73GZPogySl1kL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNY4t8AMIiQ5bWe0ouRY7pzTTGjF7pvFx6eThaDxOF8=;
 b=HyYg4fcINepnqGZbkaGilWTo5i5CjJZkJa8Nox0Q+HwA6EANVVLRBEWiHGfDAVQOTav+1wUU2Vju6C9lS9/tuGEHBSxzK9O2akcbONkSzxaZQEWe4p9MBCtuivzQ0irkUIlb/L1A5O7itdRo6etR+yvyX1T7tCaghBd8zLcqX2ZTUuMLN0Z4+jp+bbLL2VTtCNwLehpLE6k2VWm56KR/6WxtQGhF3KAJcsSPRejEgJY4qW5hUL/zH5bZ/EBfXkHDJGH/vnHirvRtthAT2CYIv1kaF4HGw3pFKoVOtlDlPMY3SrgkKRLAUHXd9sYk7yx2PUviuXu3AubzVDy5f09bmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNY4t8AMIiQ5bWe0ouRY7pzTTGjF7pvFx6eThaDxOF8=;
 b=eNatSJkjf1U64uMU8mfydLigC5t7EvdlW+i34fodzQi0jNxhMHY9cgD56bRvzO1aR7mnagisoKc2Hr4bmOqtOa0CxPJmdu8gsKzQqxHwN/7v/QqRo3v/dwB+XdI2yGom/uWxRq6ano7xTLN9pFQ+t+omPxH93hOS3CvnDkCeLEw=
Received: from SJ0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:33a::15)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Thu, 26 Mar 2026 10:37:18 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::48) by SJ0PR03CA0010.outlook.office365.com
 (2603:10b6:a03:33a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 10:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 10:37:16 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 05:37:14 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YuanShang <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amdkfd: check if vm ready in svm map and unmap to gpu
Date: Thu, 26 Mar 2026 18:36:56 +0800
Message-ID: <20260326103656.487304-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea4144a-1bb1-4d30-ebff-08de8b23a68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: XTcJB6RThRgELjuNcAWEvwJZ+yQxrzWwzhjwlhbzJwBHTR2bhAfznMy7LyPpeKOlmEbhn8JrwsHniFwhobIeZOB8CB9JKnDgG/0elqSwbLw50CCK5lzrRyP5MU/1seJ9TaV6JuG5qWCLni6m+deptySP5SS7EW/UYkWaCMVG9t3S1TfAE9HxfNCq3iO2lp2U8EqJRAlKOGgttQafShmlInR3Q5kf68lmyCsY6KA0JLgq5pkmU/wtcRrRleRtuyCxIS4SqhmrLQxrIvrnDnJOTxXnvAGdy6Dg/cA5kpdu+vVwNBY+abOSBIclYIe/bV52atHnOCLUg9oy5UztQj78hFR8cfYfzSGYqMlixWeoq1RbCDEOQmzmVSaIet2wLYF2hZzhBnWy1GS+5w38R1MKhCMd0O/ANibukTiTSc9glzu1O4VhTTCzn9dUJdISwoUAD/2yIh/mwJwfUvEOgM76sXU8+K7lMBZAMsbnOe+kBKZuG49YbqIuxpNcKjNlyWJOiQXenvcNicyATBAFxpsbc5gxzIXy+1kxjr66E/4+JxY0/TR25AI6+QcSikuNQRKoBRRo/bNKh3YrEsfIeS8gUHVIdTKGlCZxIIROZ8Dkki3wZsFJXz0epSdJlFryow/OGKAIP5D74vRJJB40rYzqsqHt4U7GuIRbBqXfUXFeVs3c3zoGf/NYVHfTg6zYr1IJlgpQs3F9OiyFmuVNQ9qzFRaE9PNdb0RxDoGC4ctNA71K0vk03Wb+crRPGXIbmh/s2W3s3EZk1Rm/MeE+wj98RA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pLLtu3rHkaCdAwAM937Ge0o1BBLqIjl5UXV/j42LSBIO4fA2juhTSfBrjQo5CWOd0bzl2pYfYyh0F1KO6k74Db6dDs9LqL7iKVtYO4JbLF+XD047o83NSn9PJS/KJav0XtvwxBN9ywaYA+WGMEIOoMZNV+CdLt2NjD71ILL+JoED9lcL/K4Vwt1Sa0AbLfD4RxcPSlE1KWiQd8lEQXUGNkXYd2BnMgCxdjg7g3UBUuEcNgflrVzlMLd3bcUspe3HBrY0vyeOuTDf5rCuaw5MFU+fNBBZ++klU8ezAE6KNqBlkbjsxPDK32CQku/RZ4CWUvcW9rgznjjv2DBL5QjkCM82/65c/0bzlulbCZqSiAMX8yW87DWlEUPhiHxST1qLRSl09uGIpUkTXdggXT4tibjJl8efDIPtmQTmY2NNZnYV8I527GPiOp1oC44wW5D9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 10:37:16.6138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea4144a-1bb1-4d30-ebff-08de8b23a68b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084
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

Don't map or unmap svm range to gpu if vm is not ready for updates.

Why: DRM entity may already be killed when the svm worker try to
update gpu vm.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8167fe642341..7f905a7805fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1366,6 +1366,12 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	pr_debug("CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", start, last,
 		gpu_start, gpu_end);
+
+	if (!amdgpu_vm_ready(vm)) {
+		pr_debug("VM not ready, canceling unmap\n");
+		return -EINVAL;
+	}
+
 	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
 				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
@@ -1443,6 +1449,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 	pr_debug("svms 0x%p [0x%lx 0x%lx] readonly %d\n", prange->svms,
 		 last_start, last_start + npages - 1, readonly);
 
+	if (!amdgpu_vm_ready(vm)) {
+		pr_debug("VM not ready, canceling map\n");
+		return -EINVAL;
+	}
+
 	for (i = offset; i < offset + npages; i++) {
 		uint64_t gpu_start;
 		uint64_t gpu_end;
-- 
2.25.1

