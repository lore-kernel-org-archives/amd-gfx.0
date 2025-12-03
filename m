Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF34D12D5C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C6110E7AE;
	Wed,  3 Dec 2025 13:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Mi66d6k";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C3910E7B3
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLG4hdIXAxRosoZU5HSaVSYAfmS6LPuw/E5QWXDHDUhhQ5yockcHQROUjf3ZgFkhWCVK98uawHJ/64l1dZIkzm8s/31YXeFb13yyjgSLyDg5VfEK3wJcbvP74cfy7pGK/GAU7fKX7AQROCy79UxYe+LhaD3R04zAT9gcd7kDqNr8JqbzvMSzy1TtsikTnNKK/paThBXcGcLXO5Ua4NvVMcdHnRdWFiedr0hgflgrzizc51zhd38VWm9xXw4vNI5SmIxxIrFvj0OHZ+A3j3eQHZzUAngauqeFxPgakjvXQbKPdn8JuDhX1O+FFDbC1MClPqjmvVodi58Hv/7k0Dej/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11nUQEn3kJop3pGS/QywhFL0IBWq0+u431BYRO5Vurg=;
 b=ZZjsteMTY8XXr83nUBXjozCkG61jeCnrRNA+0FVdKZs5g7NI3o5SkZqMMOGEDOpJtkbTWL6d9H44L/bqOvz8iYR8WYaLStzPF2dt2I5jCWqNNYNPPrpXuWVJsaHsYiaRgJqgO/da11x5ZnZO2u0gHXQu14gNunOm8eQD1t+JofhfTjGQ46c5KQ+AfvagM/f+0hNg1HJK7/9sVzYDG1bJxMoVuEY7jCpc1FxfyekYRQpuY2z9kpcr7/isOiFUfkMAwPGDLrTHH4gDBOButVefT6r4U/vC3vYTEgF8vFe5f5ovNO88z6VSgEP0geBR95gjzzb87MeDe4HM1xtFg9eNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11nUQEn3kJop3pGS/QywhFL0IBWq0+u431BYRO5Vurg=;
 b=2Mi66d6krVD74aU0bCSTccUUU+tr72x321n/gxukwUKfNvwzakWw3WNhzgfm0cTHVARzximD8GwseO/jPIpXcFi5I0/dzTxJHOx40/PDn1Tmg06cuuKc7SUWGzaRJMbpsPXG2iErGz4LUCBTTivvZMHG4v48Mrk+FI6d3roFtRY=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 13:05:21 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::16) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 13:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 13:05:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:05:18 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:05:16 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 10/10] drm/amdgpu: Add ioctl to set level2 handler
Date: Wed, 3 Dec 2025 18:25:01 +0530
Message-ID: <20251203130436.745633-11-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203130436.745633-1-lijo.lazar@amd.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 710fcf65-adff-406c-3dcd-08de326c9d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yM8ERmfKzP/ID4XJTDdlYE7wnhCkZi0gSrdvDwW+QYGzW5yFuMKkgMrRn/mC?=
 =?us-ascii?Q?qZNXSnJJ5vFv4p9KlMd1BnaYX+nq1LFEzEUtuELcqUn7IpbwE48doL+gvZYQ?=
 =?us-ascii?Q?NaD3tfjs57QQv1kDiuYtY0WNcMNfg5xBAMXGWgM4SYNMT0ARt6bDh+WSuQYe?=
 =?us-ascii?Q?N6nKjs4bYq8ai2ASFKtHJgck/eIxYTWinNmxHxxPWqgsYGGgVKZ7LIUFevo0?=
 =?us-ascii?Q?hTeZiJqaMBH3dWOxY5xN3nODTL+nvlWWJ6WeuqtEXyXw0/AaS8PyGZIqtcMS?=
 =?us-ascii?Q?bWgV01YYfn27X0cRH9bjzzF4lk7PGhDtIzCXYhF8glTUsvvzbz2Z941kxAkh?=
 =?us-ascii?Q?yUrVO9FSzfb6oHkNq6mI2dE6aWrfpycYYoU6SC+m6MW42gy1xuYxk7GsWjJd?=
 =?us-ascii?Q?56ew73XbWadGv4Q27NLJDkWUQuoITVTKSyrEOSUaIa8d8yh9huuaTOh/XyQX?=
 =?us-ascii?Q?UpfFY77KuRXB4l9ApUNZs8l5GtuCC6pETagxU+AmGlrRomyeqsL2rmh1gcmg?=
 =?us-ascii?Q?mHqYBRib4xZV2fdeXfEwe/eBmKo49LTC7cSntExxUHGt56hilBLYUMpPi1M+?=
 =?us-ascii?Q?cYyP2ERAov0vX9jrRuJ9XjLZW1kxpgsCnBof/uQzU3zYdEXHLllMUebU0S3M?=
 =?us-ascii?Q?D8zKckZ/9PD+lQh/sj+El0EUKGupljGvTOosA+P2PkK3US09jvc+se/4Qdhr?=
 =?us-ascii?Q?UTHzXnn92fJEdzVlojhQ9B5Mmkyf0wqOuO9hGaXljkbUy1oac5moxXsp6F5i?=
 =?us-ascii?Q?jnOuY3xWsXPDao6MzB7V2DlhAXfjZw3QD91ANxlKQ7JCz7sVRalq9YvNFvJf?=
 =?us-ascii?Q?VG9lYUavnoqyHBSk2Heh0rVD7cYUdkQeHRHob4qv2MFwAksp1Tx/6GjoF8Ae?=
 =?us-ascii?Q?li4Uji5lsxfaL1wugVw5wp25ukkPqK+8pJSK+xmSRTslBi1z7dzA9bI3TGJg?=
 =?us-ascii?Q?hGOC4SkFqwEgTBqT3Pm+reMOqU+1edkWm4zObO5wWGJUZ5IxZURfuMRNVpz5?=
 =?us-ascii?Q?pOi49uvnnCWqba6z7Uv8pInVBOKv0JIJJU9IexNcOt31CVlPP4LXWiG8M5+v?=
 =?us-ascii?Q?C4Ov17H8ZwYcRBWUIAJOfcpsrLbjWHHu5gKdy5REFjtMFWszLbwI1Grfhe7P?=
 =?us-ascii?Q?0ZZ86H6cy4uVIV8ARvOzItfJNUKbkq73T9QDxsRHgquExTwjGdLmMPvxch9Z?=
 =?us-ascii?Q?v5QVkHoNqLHr4c03lu89zAhjXnkQOM4e6sf0wa2rHuAYLq9jcWE8yDYJRFx8?=
 =?us-ascii?Q?YZslmrICoGWBQKE229JeZMdwO4/BMLIMavnO7aGvyZeqDsvi1tDrhcZxYG1J?=
 =?us-ascii?Q?exY541iw2VmNchLADTtiLTE+MU2nIqSq3t1v3nXu73i0KbqnN6TUz1HILZYn?=
 =?us-ascii?Q?vmu3s/ogs2ZDWpv0Kk8PPrha1Y2tk9xW6nZKRfBUKNW2jCMuneHMq63jesOW?=
 =?us-ascii?Q?vB68IecrMqxcgMADKep2mgAYZmrfNIWdZ0FNCeiEEW8oE5nZQ2V+RF53ShIG?=
 =?us-ascii?Q?Vu+qVSszTd+I83dkL4upjAJmd7/bWKMI6g5HnUeYNPYQOlL3t/230qHPLrhV?=
 =?us-ascii?Q?ejrZT4znQOQCXZEEhtA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:05:21.0102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 710fcf65-adff-406c-3dcd-08de326c9d5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

Add ioctl to set tba/tma of level2 trap handler

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 105 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +
 include/uapi/drm/amdgpu_drm.h            |  24 ++++++
 5 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1fb9539f8aca..ed50e4d6e308 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1663,7 +1663,6 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
 void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
 int amdgpu_info_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
-
 /*
  * functions used by amdgpu_encoder.c
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index 1b4483b5d5a7..531be17aab1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -491,3 +491,108 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	kfree(*trap_obj);
 	*trap_obj = NULL;
 }
+
+static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
+					  struct amdgpu_vm *vm,
+					  struct amdgpu_cwsr_usr_addr *usr_addr)
+{
+	struct amdgpu_bo_va_mapping *va_map;
+	uint64_t addr;
+	uint32_t size;
+	int r;
+
+	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
+	if (!va_map) {
+		r = -EINVAL;
+		goto err;
+	}
+	/* validate whether resident in the VM mapping range */
+	if (addr >= va_map->start && va_map->last - addr + 1 >= size) {
+		amdgpu_bo_unreserve(vm->root.bo);
+		return 0;
+	}
+
+	r = -EINVAL;
+err:
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+static int amdgpu_cwsr_set_l2_trap_handler(
+	struct amdgpu_device *adev, struct amdgpu_vm *vm,
+	struct amdgpu_cwsr_trap_obj *cwsr_obj, struct amdgpu_cwsr_usr_addr *tma,
+	struct amdgpu_cwsr_usr_addr *tba)
+{
+	uint64_t *l1tma;
+	int r;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
+		return -EINVAL;
+	r = amdgpu_cwsr_validate_user_addr(adev, vm, tma);
+	if (r)
+		return r;
+	r = amdgpu_cwsr_validate_user_addr(adev, vm, tba);
+	if (r)
+		return r;
+
+	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
+	l1tma[0] = tma->addr;
+	l1tma[1] = tba->addr;
+
+	return 0;
+}
+
+/*
+ * Userspace cwsr related ioctl
+ */
+/**
+ * amdgpu_cwsr_ioctl - Handle cwsr specific requests.
+ *
+ * @dev: drm device pointer
+ * @data: request object
+ * @filp: drm filp
+ *
+ * This function is used to perform cwsr and trap handler related operations
+ * Returns 0 on success, error code on failure.
+ */
+int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	union drm_amdgpu_cwsr *cwsr = data;
+	struct amdgpu_fpriv *fpriv;
+	int r;
+
+	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+
+	if (!fpriv->cwsr_trap)
+		return -EOPNOTSUPP;
+
+	switch (cwsr->in.op) {
+	case AMDGPU_CWSR_OP_SET_L2_TRAP: {
+		struct amdgpu_cwsr_usr_addr tba;
+		struct amdgpu_cwsr_usr_addr tma;
+
+		tba.addr = cwsr->in.l2trap.tba;
+		tba.size = cwsr->in.l2trap.tba_sz;
+		tma.addr = cwsr->in.l2trap.tma;
+		tma.size = cwsr->in.l2trap.tma_sz;
+		r = amdgpu_cwsr_set_l2_trap_handler(
+			adev, &fpriv->vm, fpriv->cwsr_trap, &tma, &tba);
+	} break;
+	default:
+		return -EINVAL;
+	}
+
+	return r;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 96b03a8ed99b..32f3f23abd79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -31,7 +31,7 @@ struct amdgpu_device;
 struct amdgpu_vm;
 
 /**
- * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer tracking
+ * struct amdgpu_cwsr_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
  * @bo: Buffer object for CWSR area
  * @bo_va: Buffer object virtual address mapping
  */
@@ -63,6 +63,11 @@ struct amdgpu_cwsr_params {
 	uint32_t cwsr_sz;
 };
 
+struct amdgpu_cwsr_usr_addr {
+	uint64_t addr;
+	uint32_t size;
+};
+
 int amdgpu_cwsr_init(struct amdgpu_device *adev);
 void amdgpu_cwsr_fini(struct amdgpu_device *adev);
 
@@ -79,4 +84,8 @@ uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
 int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
 				struct amdgpu_cwsr_params *cwsr_params,
 				int num_xcc);
+
+int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
+		      struct drm_file *filp);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16adeba4d7e6..8f5fcbe48a28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -52,6 +52,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_cwsr.h"
 #include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
@@ -3060,6 +3061,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
 	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_CWSR, amdgpu_cwsr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	/* KMS */
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1a27e218d4ea..f3b3c238d6d9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
+#define DRM_AMDGPU_CWSR 0x20
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,8 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_CWSR \
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
 
 /**
  * DOC: memory domains
@@ -1668,6 +1671,27 @@ struct drm_amdgpu_info_cwsr {
 	__u32 min_save_area_size;
 };
 
+/* cwsr ioctl */
+#define AMDGPU_CWSR_OP_SET_L2_TRAP 1
+
+struct drm_amdgpu_cwsr_in {
+	/* AMDGPU_CWSR_OP_* */
+	__u32 op;
+	struct {
+		/* Level 2 trap handler base address */
+		__u64 tba;
+		/* Level 2 trap handler buffer size */
+		__u32 tba_sz;
+		/* Level 2 trap memory buffer address */
+		__u64 tma;
+		/* Level 2 trap memory buffer size */
+		__u32 tma_sz;
+	} l2trap;
+};
+
+union drm_amdgpu_cwsr {
+	struct drm_amdgpu_cwsr_in in;
+};
 /*
  * Supported GPU families
  */
-- 
2.49.0

