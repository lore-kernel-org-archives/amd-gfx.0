Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D919C55184
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 13:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E27010EA58;
	Tue,  4 Aug 2026 13:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tk8pQgXq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FC210EA58
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 13:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbp4g7bi/t72ht9KKiZIFjk6UlmB7pSakpwNXejBxM3YrGG8HoDWY7LvyGJpImrdZV+gD04jREclzvAXvr8Ngbt7Tzs+DVvjyr7rWZzn5lBrs4Z3Lyoz1rbLPUfI+KjzjE8qi9jCoJBigSaCSDb5E3UKuTdLt/R/RrpsIi4xqJpyDpt/dpp9HLKaOr7EJ3akri88qeFZku9Z+QNSYcE83oJdnz0Rvg8T8Cjboec3RUqJMuEOK1V3GjZ4xbOFmAhL+w850rTjVnGNiOEpCXhER8Xc1w7ykRu286aQxPiWCU3neOYTJxZD4KkjD8tx93YBFubfLIl5K5g3z9Se4t0SUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayjuI7yjZuvFubzo9Mw7ctKjMZ9lP9YkB1TzCmj03qc=;
 b=wPzPtilzOpPjetJ25XdDkAH9/WkQYNrl+uQ15gdRpTovqvF4VPJxKptxoKC/7igO0t7/lhwZnJP5GMr6KoMtsDzWhNM0NOcA+/Mtpml3TdPxOhHtTrQeqO22tDQJJ2z1t2nLpiC3X99MSMX5z/TjnUo0KQW5eZpxccEltpn+SuIkF91BsGEnYx25lXOB20z/LMaeAH9hikPoxkP0iZhLpPlbXwVFcZ0qTPM5OU3XQOgT69twY+dvfi5zBp77KmF7uP+jAyC7UbsOShk59Hyl56u6ayY0oO/jd68dyc8WS8hPuF3eIcQ+ZFIsM3Fneih0d0r0vyYK8QcfrBm9dwpmfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayjuI7yjZuvFubzo9Mw7ctKjMZ9lP9YkB1TzCmj03qc=;
 b=Tk8pQgXqDWaGAte4HwH6mHOjvoKHUPKz53YalIZrCCXgYtct/q3dKQcYCLXyvtC6vhO4jA7yhHMRcT1aqQKARRhUiVoozBjRVACcJq3nwQMdoSCrxxEKBkb29wEDbE0pDzNoFdCZlvwoBcgBslIVujyV11BXDKx9T8ejdCUFlpI=
Received: from SJ0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:2c0::25)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 13:32:03 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::56) by SJ0PR13CA0020.outlook.office365.com
 (2603:10b6:a03:2c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 13:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 13:32:02 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 08:31:41 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Perry.Yuan@amd.com>, Prerona Ghosh <Prerona.Ghosh@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: bind imported BOs before mapping them into a VM
Date: Tue, 4 Aug 2026 21:31:10 +0800
Message-ID: <20260804133110.2474269-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: c897ff91-6d0f-48c1-30eb-08def22cc4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: dPuOLcObMDQxSogn+HkoCSDTyp/JNZF42Gry6wG85UFC+AoyQHy5liwl2KgyukzYJj56/4SIHc37WqX1lma88NVol7p0zlLpGSNMDFTfVYkyIL8Tb2j9p+FiStgeeFOVMamz+535Hoj6cVqhDX7FGLHxvLPyBdHQdDpiKEnMHFWKrEBZhek3ovwKzNvLc07wwiphWejkS8sMZj06SlTSzw3yBsvY8NAMUBB0dwp2w+AehLN9RZDH4mtSWNcje9SvzIP2gooiof0UINvG4iDzJJtj3HHSIkKFZ3etS9V23Scz2kb8SIz3XonsgrFv5nx4fqMa7PfL1zFANeBP4TF8sVEPtAog9HM8No/31qRq+nc+aWFbY1Ri6MFDAedgyoCuJ9TNLbDbwXzOglnHofhkvBSd4pZvldStfYfoXNRyKJQ7LfpjyLUnwojSS9LaRjsxUIjUwyaUtB3cqbM9tcJXogAVAhEq85C1q7OtTzqvUO7MQdCBu6eeB4ydX+yfmwoY/9R/26AzlG1YzaEkOThO53jv5KYAxGKtDbD8RVs/MH86PwRaWvFoC3eIE7mUblQoKFKOql/dq+2k0NQ5/oho9LZ+fs6ItNvfPYedXh07Ye9dOvWys6oQc+xQWP9VwwTqVZXvzribtweQi6HOte1p7TpQXy4iaFQANexnCFSIWT3GiQY1+6BeErY12lWEHM5BSCcqs6Dh/VsyP8uVYT+mVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WDyFhmbdEZqIhglZa78LTBgx/VRRvQwWe3G0WGuxqbGNVsvSdAozzy+su0CzChYRUdt7KJGbL8pxBameCkXRX4znnOu5zMS9Ezc6j42uXQ/6a9uUyh1ivC0td5X7hIKWAvHs67hAgLqvJb9jMm9Slr0VtGI/0D6TpP+IVSPn8NkW04daE9fVmKHUEhPnmBSx0nGwSH6Vq4Thq2jsscAdmN//+iJmLrjwvWJ3y+CAtYw0it5qUolJ7+a7i8OWp+sjy3JCf7VWLf4bXQJFaXovQjBkjh7RUy6s+2P8YRRpkir95x9/Zz/a0ELCYgfanTZgVlT9TnZ1ajS7jCSRJfOxtQAAhqjFiPjl97/x/h2irCcoEOWFwl89Gen4/sQGtF63axqz/ol+pn6+k8zPdyQ2lqyXAjpjNsKa/qm45lnJRyVUXK4QzrwTkAu4u9gq4FEL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:32:02.6442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c897ff91-6d0f-48c1-30eb-08def22cc4d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6a0699746fbc..d1ffc4e2f501 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -726,6 +726,30 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
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
+	if (!drm_gem_is_imported(&bo->tbo.base))
+		return 0;
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
@@ -941,6 +965,13 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto error;
 
+	if (abo && (args->operation == AMDGPU_VA_OP_MAP ||
+		    args->operation == AMDGPU_VA_OP_REPLACE)) {
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

