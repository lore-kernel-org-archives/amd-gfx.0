Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BCCCA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 03:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E738A10E563;
	Tue,  2 Sep 2025 03:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n5ytxH7c";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5AE10E563
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 03:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2zvitgtcXoNCMxokGfJ60L+NDEqGKtue1duK2T7OqidA4qbuPfs2hTErL1mdEWyL6Q8t3v2syIQgj8A+aLzfOyrQvgz2kNz1AVQQv+5M97J9v3QsUOt8YV1NHEfdwLEB0+oaVOHGY9AY1r+vXRd7XNSgh7qjcvupwfO0W3N0ymn1GwOXJDr5fdehd5lRzuwyauCnZ/CgbuysGTg6JH6NYYM9o8aCEIG+G3LJ6ofRFRlM6Xl2A0wAPWudrMo7JoDkEE1U5EzqYBNujIsHa15Rfgb+8RlIeQUVeBUJQKpm5CKrMDPO3uh0SAAg9xhaiIC6hwTamzzlqeFUopwLjUdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm2h85JyFDA5SD97SMK6p1ZQlcTrJX9XPIc1zKamh0c=;
 b=wkqomaDpKqsxCuRpRsLNHy8cuVohASXORUBdSIUwlGWVkAi4KbAXmIqy7BgfyJqQ2KU2FUaxv1eVhaadsMCkpvD15MY7Gl/tAZylUa83bs+T2VNJwXNaUujucTwaAOeTYLzTqfi41mzGYsuQc1un5BktoARratsrAuw/HHMf6IVrSxk815mSGPb7M/I/YH4MKEfdpApqgpVDxuJ/aHIwZ0DW8b7jtxoMxlDtiyiySAxivcuvga1O5hPNtkQxAv857TnZS13wletAhqIR3fpfMnr4W300ZOjVMGmv1FVzwMp7dh/4Mpyij4HMbpgdrM4/rvO0ttgvgN1BBK1RcF2eXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm2h85JyFDA5SD97SMK6p1ZQlcTrJX9XPIc1zKamh0c=;
 b=n5ytxH7cv3ezmLPt8Qmm6lMnpzgYdYy7MtAozETVSMd8FlAxgKAA5x1LEJjW+PUwtHBXH0cj7l1QxJU1YoaklLrlrjy+BDe3wcKnChNSFuWshfJRfhSxxeizlHpRPdpxISsZEv2AhU99Mzox9HcShiKJurBx+UlrYnM0Sf+z7og=
Received: from SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 2 Sep
 2025 03:39:10 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::e9) by SJ0PR03CA0053.outlook.office365.com
 (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 03:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 03:39:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 22:39:09 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Mon, 1 Sep 2025 20:39:07 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 8/8] drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton
 in GEM_CREATE
Date: Tue, 2 Sep 2025 08:59:38 +0530
Message-ID: <20250902032938.468332-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a97d3f-7df7-43f3-f348-08dde9d2473a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDZuYzdvL0YzU1RNR09zbXpWR1E2amEwbllLbU55L1VtR3pFaHBIYWM1TWtH?=
 =?utf-8?B?YVljWHFYNEZDekJjTE1LeGd0NGkxcE5WdTR5YStiTUErL3dZbUtiNFFkYXFL?=
 =?utf-8?B?WGJRK1Q3MHF4NFVZdk1EOHpDU2M0cmNJSW1pZWJnbkpVSHlRbFg5UDMvU0NZ?=
 =?utf-8?B?Z3FHdzh4V0R5d0hPMXdWR25pRXk1b1NpZm5rNEkremZmY2t2OExpZEpSR0FX?=
 =?utf-8?B?OXJSc0dzdVZuMWY1ZEdmZTRZR1lmbWlmVktnalhTQ0c5VDV6dnNNMXp0V1Bn?=
 =?utf-8?B?TmJjU2RwUlVEelplc3JyR0lsaEd0WE9vR0R3NjR6a3kraTBkR1BPUmV6T210?=
 =?utf-8?B?MnJTU0lpNVhta2hyUkYvSWlZY1Q0YlM3OGpRa0tpanNWcjBmSUpGMTh2c2w3?=
 =?utf-8?B?VFRUdVJTT2g2VjFoZUhtU0RHdlFFYmJ5UndIblpnQUt6RGJjTVNVSTk2VG5v?=
 =?utf-8?B?Zmd6Z0ptaklhdVpuU2JKVnErT0dEQmE3dkFBN2JHN3ZFUUdJYjM1SDhRaEVz?=
 =?utf-8?B?b25SYk00VFhicFdTd3VOR3kxaGZISmY2MHY5Wng1YlN5c0ZJc0FWeURPSjN1?=
 =?utf-8?B?TnBKVk1OM3J2ZFVZTGxvTWZxaXJDL0FISVFSTENpK2kvRS9jN2JQdFdSS2lR?=
 =?utf-8?B?bUppemhySDJ3dDJmM2VCVEp5TFhJYU9iKzZrMnNtMzUxQ1ZmY3Y1bEpCVnhE?=
 =?utf-8?B?TWc0ekplaG1PRDJmeW1OMXRrRlA0Q3RXekQwRnhCTGlVa3hOMUlxYzRDUFNV?=
 =?utf-8?B?WVlEZlFTR3A0bWQyTTlKYXZNbUhoK1czcEN2MEo1ZWdqc05NUnRSc1VwcmM0?=
 =?utf-8?B?QWRvWUMxTnJJeXpuV25ZMDRHaEE4UjZ5S2p5cnJwOGl3eUd4ZU5HVDUvYk5D?=
 =?utf-8?B?Y0Q1RjlIa3hNTUk5RGNJMTU5ZGlGMkowcHBOV3BTZHRTWmVVQWlvV24yeFZh?=
 =?utf-8?B?SEdQVmRzbVJyOUpUMG5UNHFDQ0JrMktNaFkxV1hRRWJpSWEzNk1ZTFZpZVJG?=
 =?utf-8?B?aWJ3U2VSYWt4bDJSNmpjWlFaZkVadk5Md21XWmxEUEhpK1pmS0xuVmZuUVpp?=
 =?utf-8?B?UUFEK2xkQTcrSFJDWGU4TzJZbGlSZG51SkkzVnMxc1lXaVBzbHNuZCs3Vzg4?=
 =?utf-8?B?Zyt2clpUdXQzOEpmQ0M3YmRsQjhWa2FSa2ErWXgxak1lNUJRYkpRWDVqbUN0?=
 =?utf-8?B?MTFXdnlVY3BsQkxrY1FxVjRnNGM0ejJ6bXFkdlZEdEhFaEo1MDJ5VThzYXBE?=
 =?utf-8?B?V0t5c01JUnRCamc1dHNnRDN5STFENFdCWHp1NkRUdW1YdEptTmpDOGpzY0F5?=
 =?utf-8?B?YjIvSjJ0UXNYc2ZtQ2VsaS8rUmVUaGxzK0ZSWVh2Q1JhbW4rTlpOakVzczJw?=
 =?utf-8?B?SnhCNnpFaWNzUWRQSHZZb1c1OGc5WFNQUnFjV2JYMkZOT2J2YzNrTmZLNGZW?=
 =?utf-8?B?NWtLZlRMTytBNTk0QVlLVEtIeUlzU3daU3hVYWI5RjgxcnoybGdIRGR2aEw0?=
 =?utf-8?B?WSt1bVNZNUpJQXNzUlVsdGxwTVhhM200VS9PeXV3OFJFK2ZaZnh5SXFqcmtY?=
 =?utf-8?B?cW84NlV6YmZxc050RVNXWkVJK2tJOVRoelFlWWxTQmpkM3dvc2ZJUVNSekVF?=
 =?utf-8?B?MHVKQmV3alpUUzR0a2xLQ0E1eU9IczR0eDEzdTlNK2JOd2hGMWdOL3ZYcjFq?=
 =?utf-8?B?Z245SFBVRUx1ejNDZm5hNnk1MlNkemw2Ui9VazlGbkVaemxCT1loaWNLZis2?=
 =?utf-8?B?RXNjWThvTEtUYU8xRTNSYmUzQlgvdWttcEhaSTFOVWIydnRIdFJjNjNNWWdR?=
 =?utf-8?B?VEQ0OXdlTmpiVUxBMkV0ZlFXMEE4WS83VnBGeVlxUS9ZWTJVQzErTmlDUjFW?=
 =?utf-8?B?RjVCdXhjSms2a1kzVHVPR0h0Y0dBQ0xpMU9vbExsR0VjUmlXQmM3WllSc29D?=
 =?utf-8?B?YXQ5T0dKMFd1ajIzbmo2eGR3bzcrYTBFMEE3emFVc29zQVBubUNHVHltL1dO?=
 =?utf-8?B?U01XSUxvQUVzZGc0VTdJSVAyemFCTDdZZ05ldGxKZ1pLTTJWK0ZxK3hJcmxa?=
 =?utf-8?Q?a5vftW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:39:10.3245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a97d3f-7df7-43f3-f348-08dde9d2473a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
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

Enable userspace to obtain a handle to the kernel-owned MMIO_REMAP
singleton when AMDGPU_GEM_DOMAIN_MMIO_REMAP is requested via
amdgpu_gem_create_ioctl().

Validate the fixed 4K constraint: if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE
return -EINVAL; when provided, size and alignment must equal
AMDGPU_GPU_PAGE_SIZE.

If the singleton BO is not available, return -ENODEV.

v2:
- Drop READ_ONCE() on adev->mmio_remap.bo (use a plain pointer load).
  The pointer is set `bo = adev->mmio_remap.bo;` ie., The pointer is
  written once during init and not changed while IOCTLs run. There’s no
  concurrent writer in this execution path, so a normal read is safe.
  (Alex)

v3:
- Drop early -EINVAL for AMDGPU_GEM_DOMAIN_MMIO_REMAP; let the
  MMIO_REMAP fast-path (For MMIO_REMAP, if asked, we don’t allocate a
  new BO — we just check size/alignment, grab the one pre-made BO,
  return a handle) handle it and return the singleton handle.

v4:
 - Return -EOPNOTSUPP if the singleton isn’t available; drop PAGE_SIZE
   check from IOCTL; inline the MMIO_REMAP fast-path and keep
   size/alignment validation there. (Christian)

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 56 ++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d3c369742124..8781b2e16f54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -424,6 +424,45 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.vm_ops = &amdgpu_gem_vm_ops,
 };
 
+/**
+ * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_REMAP BO
+ * @file_priv: DRM file of the caller
+ * @adev: amdgpu device
+ * @req_size: size requested by userspace (0 means “unspecified”)
+ * @req_align: alignment requested by userspace (0 means “unspecified”)
+ * @handle: returned userspace GEM handle (out)
+ *
+ * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer object
+ * (adev->rmmio_remap.bo). The BO is expected to be allocated during TTM init
+ * when the hardware exposes a remap base and PAGE_SIZE <= 4K.
+ *
+ * drm_gem_handle_create() acquires the handle reference, which will be dropped
+ * by GEM_CLOSE in userspace.
+ *
+ * Returns 0 on success,
+ *         -EOPNOTSUPP if the singleton BO is not available on this system,
+ *         or a negative errno from drm_gem_handle_create() / validation.
+ */
+static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
+					    struct amdgpu_device *adev,
+					    u64 req_size, u64 req_align,
+					    u32 *handle)
+{
+	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
+
+	if (!bo)
+		return -EOPNOTSUPP;
+
+	/* Enforce fixed 4K constraints when explicitly provided by userspace */
+	if (req_size && req_size != AMDGPU_GPU_PAGE_SIZE)
+		return -EINVAL;
+	if (req_align && req_align != AMDGPU_GPU_PAGE_SIZE)
+		return -EINVAL;
+
+	/* drm_gem_handle_create() gets the ref; GEM_CLOSE will drop it */
+	return drm_gem_handle_create(file_priv, &bo->tbo.base, handle);
+}
+
 /*
  * GEM ioctls.
  */
@@ -465,8 +504,21 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* always clear VRAM */
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
-	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
-		return -EINVAL;
+	/*
+	 * === MMIO remap (HDP flush) fast-path ===
+	 * If userspace asks for the MMIO_REMAP domain, don't allocate a new BO.
+	 * Return a handle to the singleton BO created at ttm init.
+	 */
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
+		r = amdgpu_gem_get_mmio_remap_handle(filp, adev,
+						     size, args->in.alignment,
+						     &handle);
+		if (r)
+			return r;
+
+		args->out.handle = handle;
+		return 0;
+	}
 
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
-- 
2.34.1

