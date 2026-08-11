Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E6DC5B574
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 08:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E81B510E296;
	Tue, 11 Aug 2026 08:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZfVJS5+6";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145DB10E296
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 08:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYzK8Vz25TqtyNfpOU6W8BoMAsn1KlIjHzbVOtuD4OjN4gu1ynNeJPwEsPYDLjgwxB7nPqIfMhg/7wP9Ao2xUZMkNfpp21AJKIpqn8tYPk478JkPplGURQQ9ShVVArfiTKSy0mnfkfgipK1z7BdzmoKLIXgy++JlcXdvl+0NOYacvtDQAuWdo8sIoBe1rpaiG+gssXVvB+Y0mvpzsJ8O5b6yYp5oGX5unMeXf+a25qM8f08fECbIe4c8lzLuk8xFyOYOxq8i6nFcthRO9Au2FbEixpm1jdYYQ3xYt9d6zqbH9aF4bhVbtZ25SFRLMKG28vUv9OlfrvGk5lNKH65bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd+4LBOsl8lmp6CvtjKPdolDLEAaDhCFv2TPHbRZnAs=;
 b=EkBzRJ90pvz7MmQ1TjH8QHigIokqU+Iolj2GNEubGwQO7l3FXFvrUsiQqmSwxZd7/QDtbmuSnQuMIeZACcxWOhCH426Ewpyp8pmpZADmj1oQ9BF7K4VeoZUu46MhB9rgRcqXxpGffyL+5shkMMez7ME5jU7qpx+i7A119j6rcMfAfPscqM1eoPqe5yhvrdiTsBskN3fTdrmbRX4aFnzfbTFmShBzzRZFZ+sJFO69TSyf3MjoXslbbKUrWep/+kYOQz1Fa25zvQWnqPVbmM1F3r06d3dRN1xE1XK5x1e8foPX5G4TmE9KwEavizBFIrQFJujvyPErU8YF1x8HjG0kyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd+4LBOsl8lmp6CvtjKPdolDLEAaDhCFv2TPHbRZnAs=;
 b=ZfVJS5+6Ekf8qALUzRd4gPrGYOWsyZFrzME+eoz/UxxPYtwtPtEHOSPCEsU/+qCRouLEI1J1KFLRnaRRzmm2+/K12u9V6IHOkA2STqKZSs+a/QjDNPvAJW36NNKWUjfpH2sOeXh9/4nQyz+vUG+yWLuW6JVfCqxA/VYuwppliac=
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 08:07:37 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::7f) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 08:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 08:07:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 03:07:36 -0500
Received: from yifan.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 03:07:34 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Perry.Yuan@amd.com>, Prerona Ghosh <Prerona.Ghosh@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: bind imported BOs before mapping them into a VM
Date: Tue, 11 Aug 2026 16:07:17 +0800
Message-ID: <20260811080717.547510-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f9b15e-a8ca-4fed-4ca7-08def77f9b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: aVAzuSBb9ZjPB1TFRlonHJEnC2yndcP5Azzkz1R8mfrG8G1mz+wwiLT3YjPkMQMDybGkGzs+JWfoirwkH42oXjlr6cPgB/IMmk89g91Ay0g9kU3050ZvU7a1yNVzcbyTqsztt5K1/dbM/NIW9iBawVlk75uVYz5/Tg5wRikp3EddE8HTaVX+Bpq0FoQB2N2A+6pWc78KfV/fMawxBxotCG64Tx3gLM6ueCwtirlscxDy/J/RXjVfxrCp0htwRftA123S0UJ7JZNcnK20PDzTLhYlb9lPyqosYBf5NNFv8WFd+dwfQrnolRVkf0AWWVqt3Euor77wQar6ZrzhqZYGJUFQl58+G4L0xNfM8duGuzEXJFC8zHfQlyTU/dZEU7/mwssXv7rhh53D9KyBFp2M0PrL5w0vxujlCevP/8zIyU+AqkoFb9BZMD9Ng2aPRfr3Id2YY+PYzrYljCCbdF0wmNYUfRbVfr0CC3lf9pomQGgISG9GVtS/ykHD9t/J2QBFJjRPSTt7Bws//wzc9/PD8H4ZubUBmSz6a4/FWrAQ5z3CV/l6TNSKKBxx5oaJFeXtXYpUrhT/Em4MQ1JpBUxiEfcMWWQRUmZLytg5AqlT1+g3rwUBzHrThnOTUp02U52R/WkQZBzK4kkmL5eTBH2eEVunAjSdMOxzEzoTnBzYaDTTn/0+sjgpjmJmvX7ZHvU28JuOHRV52uklyEMSUbLovA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eI5jBDHbwqX6MxcHeAZgkJyELxvl0bLV/knSHaxv7XumwjHkUEyztXEqoJJxPY/omhWL8htKJWeDM1U3hoVppR2v27clEruKWUvG+LHRKs0O08flFBpUfmq4OmZIWOCg2BczEMTINqvlio8rWdCECdWZY8ChoPyj4FtHzojNYz04oDNohsrRMRSDCUOx/QkG/3B3wfpvvHey/0IhDQE4temiguzWDmxblIouShbdDKolOywFwyYbla0ae9JKCiCIwR52TAPYdN9U42NEbLD4CI9bu8PTYkE9rJ/a9qdvNgwPydxwv6hpNIzNz4DFOQGYyIx+Sksd+6CH1Ziy90XM2Qdw6eXC3drOf1DyMlPihaTuILlz8ZoI6HgFWonifqLHddFnB1aU3qMLzKRdo7ZX8plqxg6lSkSbhYl1Zc1g1GbrZogeC/YhM4VI3uOq7SQ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 08:07:36.7185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f9b15e-a8ca-4fed-4ca7-08def77f9b1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
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

From: Prerona Ghosh <Prerona.Ghosh@amd.com>

An imported dma-buf with a dynamic attachment is not bound to GTT until
it is validated. In a VM that is not a KFD compute context nothing does
that: amdgpu_gem_object_open() only validates and fences imports for
compute VMs, and clients submitting through HW queues never go through
amdgpu_cs, so amdgpu_vm_validate() does not run either.

AMDGPU_GEM_VA then maps the BO while its resource is still
TTM_PL_SYSTEM. amdgpu_ttm_tt_pde_flags() drops AMDGPU_PTE_VALID and
AMDGPU_PTE_SYSTEM for that memory type, so the range is programmed with
PTE flags 0x60 (readable and writeable only) and the first GPU access to
it faults:

 amdgpu 0000:26:00.0: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:3 pasid:46)
 amdgpu 0000:26:00.0:   in page starting at address 0x00007f142d6d8000 from IH client 0x1b (UTCL2)
 amdgpu 0000:26:00.0: VM_L2_PROTECTION_FAULT_STATUS:0x00301011
 amdgpu 0000:26:00.0:      Faulty UTCL2 client ID: TCP (0x8)
 amdgpu 0000:26:00.0:      PERMISSION_FAULTS: 0x1

Validate imported BOs into their allowed domains before MAP and REPLACE
so that the mapping is always created from a bound resource.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Assisted-by: Claude:opus-5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f754a4a3a1c2..214ae2a95da2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -747,6 +747,27 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+/**
+ * amdgpu_gem_va_make_resident - bind an imported BO before it gets mapped
+ *
+ * @bo: the BO about to be mapped into a VM
+ *
+ * Imported dma-bufs with a dynamic attachment stay unbound until they are
+ * validated. Mapping one while it is still in TTM_PL_SYSTEM would program
+ * PTEs without AMDGPU_PTE_VALID and any GPU access to them faults.
+ */
+static int amdgpu_gem_va_make_resident(struct amdgpu_bo *bo)
+{
+	struct ttm_operation_ctx ctx = { true, false };
+
+	if (bo->tbo.resource &&
+	    bo->tbo.resource->mem_type != TTM_PL_SYSTEM)
+		return 0;
+
+	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+}
+
 /**
  * amdgpu_gem_va_update_vm -update the bo_va in its VM
  *
@@ -962,6 +983,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto error;
 
+	if (abo && drm_gem_is_imported(&abo->tbo.base) &&
+	    (args->operation == AMDGPU_VA_OP_MAP ||
+	     args->operation == AMDGPU_VA_OP_REPLACE)) {
+		r = amdgpu_gem_va_make_resident(abo);
+		if (r)
+			goto error;
+	}
+
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
-- 
2.43.0

