Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585F2D1D478
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 17:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF17C10E7A0;
	Thu,  8 Jan 2026 17:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qYxdNBnH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC12310E7A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 17:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3r8jIycZbvmx98YKCMxVYHdXo5KGaQlw7ER05Lug3exkOXw3x7P6RQkO9Ap+rh0Bcy+snYGwm48eW6VD/lHIJsWUi/UIlGaKLNAQvs8FaTMWFaLMqDcFbgPvCNVlwOWrL6GiDZQ0cuCh8a7jN/hveZWNIbUAC0fzT1jh80u4kd201ceY1sLuVNbwSo8Je+bOwy9pPI6b2m5DPFnhSl/oJXFNQHFYW94CMh9k03Z2P2Dwd/SndQi28B/Or6RIau52VvyHhDbAER+WeXbVR/rEDiHb774PULjIYWgZyDCa6+/zBrl3rHZDVhAyuxWtaVDky2/y323kJ4aZEaaexxvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebdRXbh0guxGQ7c4j5Xi0vzQUA7rb03fhjB8qHsM0+4=;
 b=DXNVwRcCPbUwvNKlFKE/ODq/8Q9w8VcoeOO5AIBc6I8umaOV68lJ/ADN2d6EBM4pW6Pdw3QYzeWvGntq37tm4aS/x8qXIrsazCm2Q1REjS0EEt4zrn/qIq318zchDgTp/CxNLlyl12I4Od0OGukqhN8ij0JJwpWqFJ3OCA9YM4E1RIx6a/ofjgQC0f4PWr86LRG+Zcg5Ab0QS7a020SDtqQjNlu6RPi3YaXjYcxGNI2xcHg9DioUkMqo5e6pkYm77kUZNqplKm+uUGnMP2NEgR1MjxsZ+OC4HlIW+3lX1CreXBJ5LtlTszhwnnPLIb5HJkdX8dhM0DfxS2Gy4bpzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebdRXbh0guxGQ7c4j5Xi0vzQUA7rb03fhjB8qHsM0+4=;
 b=qYxdNBnH1f1r0V/iP78Vd3NVl9lwyg7adh+utsc3jlAbJe/kKULYr7E4R58euFcJLgUBPkxapSAGR6KcgGw9EoWwg1oklBiNhZW2abwXAoWDCb0pjYZScWMtQ89ZaYlIqeRpzyK/uvGBGNexNNihbyiIh2P2jDuqdzrEjM5sds0=
Received: from CH0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:610:74::18)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 17:14:23 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::1a) by CH0PR04CA0073.outlook.office365.com
 (2603:10b6:610:74::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 17:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 17:14:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 8 Jan 2026 11:14:13 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Leo Liu <leo.liu@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, David Wu <David.Wu3@amd.com>
Subject: [v3,2/2] drm/amdgpu: Add AMDGPU_GEM_OP_OPEN_GLOBAL
Date: Thu, 8 Jan 2026 22:43:54 +0530
Message-ID: <20251223141427.36850-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223141427.36850-2-srinivasan.shanmugam@amd.com>
References: <20251223141427.36850-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Patchwork-Id: 696200
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 24994b31-d5af-481e-03c9-08de4ed95e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmRmMDRJUGFWVXd5T3pORktwdlQzQk9RNDNGRURPQXhibUNVekZlVlBkM1cw?=
 =?utf-8?B?emxVUVdmRlgwelVoemM3eGd3RE90YVJyRWpVQlhzRUN2enJJdXVCYWZSMVVO?=
 =?utf-8?B?Mjl3bU5oSkRVb3NvbWt5R1JNOU5FMmFkRkhZcHM4TUp3aW5VOVdzeHg0L080?=
 =?utf-8?B?VlI0cGV4Rk5JaTZEMGhHQU8ySEdJSXRmVmlRQyt2T0kySlZ2L1YrbWEwQ0lL?=
 =?utf-8?B?eUVvVWJLOFdKQk1sU2xjUmpPaExUeFpxTnhMUlFOOVAvQjBSWGRiZVZ1TDg1?=
 =?utf-8?B?ajdnMUhZekRXb2JVTy8xMDlZaElYOXF3RSt4ZnFjOG15Y3dVazhYY29JUVNP?=
 =?utf-8?B?ZEJyeDFhZHBtclRVRDlpVDJ3anBQNmp4UUsyd2pWQ3lrSDdMMWFDNERXZW9D?=
 =?utf-8?B?WkpWQ1dybCtCWG91SkMvUGNXaUhwWFNGbWFSeTYxWVM1QVRXc1lndGhKNE1k?=
 =?utf-8?B?aGZNS1ZGRWx6SnFoMmlCMzdMblc0bmFONS9NQmFOakVrR01kYmtwQXFVUGV3?=
 =?utf-8?B?RDQybFBVRGF6OHdTRjZ3TjBTZkV6Q2FQTWgramF4aDVIdm1xRnE4U2ZIQ2o5?=
 =?utf-8?B?MEhleEZrd3ZPbmpaRldnZ00xcHEvdVEySDMrTTZGdytkZ2lqYkp1VEpmc21G?=
 =?utf-8?B?dWJzU256VDhwTHFta2lCVmdKMjZOeVVFZ0pUejZ1RVAyMkE4M1ZvS055RjhH?=
 =?utf-8?B?RzlpWXNOT3Rpb2lBallCYWlkcXVMNjBzSy9YOHJTWVpkYmZhRWpDQk5MMDhn?=
 =?utf-8?B?THV4UFlSM2JoUmI5M0hLSEY3M1FFVXd2QzUvNHE0cDdzeElzZ09iNW5FbytI?=
 =?utf-8?B?QUw3TFBFbFJmTWFJMVJCY29qNVhoaHFKdEJVcUhSTnBOY0Q4cGlmTWl3ZndY?=
 =?utf-8?B?MzVJY0ZLYU5VakVFcUcraU1sY2tsNDNyWG5ZY0ordjhXaHlIUjlQRzhLZFQr?=
 =?utf-8?B?WEI0ejlpRThPRm9BRG1LdWpqNG1qT2gydVVMR3Z0NGRKSHRDUi9kSGxUOEJ4?=
 =?utf-8?B?eWFHeGdSM1VJSDl1SEpmSlVQSEt1VnpYZWtXQVpmQ2FKcHVkOHR1aTBmcnds?=
 =?utf-8?B?dkcxVUFxdFl1NlB2blljbEMzVUhLSjIrVVV0YlRpeExqa2RzSlREREpQbkNU?=
 =?utf-8?B?VDk4T2RhQmNhVHU1dVJqVzBrbm8vT0MyNlBkdmkyNjdGbkl4ZE1NeE9Rd1JR?=
 =?utf-8?B?TlYxTjlrMGpia0kwaE01RE0vaWpWVlJnR1FuRm5xQWo2UGZRajNGWmNoTFVZ?=
 =?utf-8?B?UGcxaDB2WUdXV3JzSlRBOE5EWnRIdUpVZU82L2RrLzRBVTNEc0JTQXJXOFB3?=
 =?utf-8?B?a2xzWXZWelhpNUEySHlSVjVJOG82NkhoU3JwRlNuRCtsNVlKSEV5Tmc2cWlD?=
 =?utf-8?B?UzcrREQzMFpIUXJqWmc5MUIvbkwzU0NqS3FDS0hyMjNLbFdYT2hTbC93R0o3?=
 =?utf-8?B?VjJoM2FKVlc1Z09mN0YwaDBWQ1dvZ04wZTNJSlhEQ3pTVEdjNWJZZzdQL201?=
 =?utf-8?B?c3Q1VWtvWGVuWmQyVUNaT2hxbVoxZEdOeEQ1MVhqWHdFWWYwdHdnZjZNVjRP?=
 =?utf-8?B?NlREMk93SkVoU09VZEhQaXQxc0FjNFNNdjJKUFhia29teWV0WGtaV3dlMU1P?=
 =?utf-8?B?Q1ZXQll0S3UrNldLTHluVnRJOTNOckZUVkZPMGl6K3V2TnRyR3dDNnI5Yllu?=
 =?utf-8?B?UkxLR0ZzclV6dDYyKzl5WDhpZ3I3bDhlSDl1bHp0Ukd2S1JTNlA3UDhURHJW?=
 =?utf-8?B?NTQ0eWZwbWo4U1NNaTBjSlVCZmE2TUlVYnplc2l2d2ljM1NYbHZFaDhjT3B5?=
 =?utf-8?B?eHZEZDUxZ2VmdjhGZmp3L2xsTVZpZzNZR1cxelRKaldtdFJXN09DNTJnWHJK?=
 =?utf-8?B?UVJ6UVFZT0o4bElkSWIza01hMlEzZ2pWS1p2NFFyaWJWNGY1R0p2N2pvRGha?=
 =?utf-8?B?akpJckFtN3JBeFp4RzFGRU9LQnczeGVVYStoL3FNamV0OWthSTV2S0svc3hC?=
 =?utf-8?B?ejJZdU9rUU5EbjViZ0MxRDhBTmNjc0JDaGZ4ak5YYzV4WWNEcERPMitveUtn?=
 =?utf-8?B?dytPVnpoaEhwbzlpOU5wdWZKd0ljZWpiZDJGejV2TC9BVENoaEVtSkpsT3lS?=
 =?utf-8?Q?dh2U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 17:14:23.3333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24994b31-d5af-481e-03c9-08de4ed95e85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Message-ID: <20260108171354.KxpEcDTorutE7wTZybfbA30q0H5pKC10y9nW-pzPN20@z>

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Instead of abusing the create IOCTL to open global BO add a new
AMDGPU_GEM_OP_OPEN_GLOBAL functionality.

The new AMDGPU_GEM_OP_OPEN_GLOBAL functionality expects an enum which
tells it which global BO to open and copies the information about the BO
to userspace similar to the AMDGPU_GEM_OP_GET_GEM_CREATE_INFO operation.

The advantage is that we don't start overloading the create IOCTL with
tons of special cases and opening the global BOs doesn't requires
knowing the exact size and parameters of it in userspace any more.

This keeps the GEM create path simpler and avoids exposing internal
allocation details to userspace.

v2 (Srini):
- Centralize global BO ID to BO mapping into a helper.
- Return -EOPNOTSUPP if the requested global BO is not available.
- Allow args->value == 0 for AMDGPU_GEM_OP_OPEN_GLOBAL so callers that
  only need a handle can skip the create_info copy_to_user().
- Clarify the input/output semantics of the handle field for OPEN_GLOBAL
  in the UAPI documentation.
- Avoid potential NULL dereference for MMIO_REMAP on unsupported
  hardware. (David)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Cc: Ruijing Dong <ruijing.dong@amd.com>
Cc: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 44 +++++++++++++++++++++----
 include/uapi/drm/amdgpu_drm.h           | 11 ++++++-
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b46b61297f68..950e3f1e83cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -962,25 +962,44 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+static struct amdgpu_bo *
+amdgpu_get_global_bo(struct amdgpu_device *adev, u32 id)
+{
+	switch (id) {
+	case AMDGPU_GEM_GLOBAL_MMIO_REMAP:
+		return adev->rmmio_remap.bo;
+	default:
+		return NULL;
+	}
+}
+
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
 	struct amdgpu_bo *robj;
 	struct drm_exec exec;
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	int r;
 
 	if (args->padding)
 		return -EINVAL;
 
-	gobj = drm_gem_object_lookup(filp, args->handle);
-	if (!gobj)
-		return -ENOENT;
+	if (args->op == AMDGPU_GEM_OP_OPEN_GLOBAL) {
+		robj = amdgpu_get_global_bo(drm_to_adev(dev), args->handle);
+		if (!robj)
+			return -EOPNOTSUPP;
+		gobj = &robj->tbo.base;
+		drm_gem_object_get(gobj);
+	} else {
+		gobj = drm_gem_object_lookup(filp, args->handle);
+		if (!gobj)
+			return -ENOENT;
 
-	robj = gem_to_amdgpu_bo(gobj);
+		robj = gem_to_amdgpu_bo(gobj);
+	}
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
 			  DRM_EXEC_IGNORE_DUPLICATES, 0);
@@ -999,17 +1018,27 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	}
 
 	switch (args->op) {
+	case AMDGPU_GEM_OP_OPEN_GLOBAL:
 	case AMDGPU_GEM_OP_GET_GEM_CREATE_INFO: {
 		struct drm_amdgpu_gem_create_in info;
-		void __user *out = u64_to_user_ptr(args->value);
+		void __user *out = NULL;
 
 		info.bo_size = robj->tbo.base.size;
 		info.alignment = robj->tbo.page_alignment << PAGE_SHIFT;
 		info.domains = robj->preferred_domains;
 		info.domain_flags = robj->flags;
 		drm_exec_fini(&exec);
+		/*
+		 * For OPEN_GLOBAL, allow args->value == 0 when the caller
+		 * only wants a handle and does not need the create_info.
+		 */
+		if (args->op == AMDGPU_GEM_OP_OPEN_GLOBAL && !args->value)
+			break;
+
+		out = u64_to_user_ptr(args->value);
 		if (copy_to_user(out, &info, sizeof(info)))
 			r = -EFAULT;
+
 		break;
 	}
 	case AMDGPU_GEM_OP_SET_PLACEMENT:
@@ -1093,6 +1122,9 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		r = -EINVAL;
 	}
 
+	if (!r && args->op == AMDGPU_GEM_OP_OPEN_GLOBAL)
+		r = drm_gem_handle_create(filp, gobj, &args->handle);
+
 	drm_gem_object_put(gobj);
 	return r;
 out_exec:
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ab2bf47553e1..9e4692c270fe 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -803,6 +803,9 @@ union drm_amdgpu_wait_fences {
 #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
 #define AMDGPU_GEM_OP_SET_PLACEMENT		1
 #define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
+#define AMDGPU_GEM_OP_OPEN_GLOBAL		3
+
+#define AMDGPU_GEM_GLOBAL_MMIO_REMAP		0
 
 struct drm_amdgpu_gem_vm_entry {
 	/* Start of mapping (in bytes) */
@@ -820,7 +823,13 @@ struct drm_amdgpu_gem_vm_entry {
 
 /* Sets or returns a value associated with a buffer. */
 struct drm_amdgpu_gem_op {
-	/** GEM object handle */
+	/**
+	 * GEM object handle or AMDGPU_GEM_GLOBAL_*.
+	 *
+	 * For AMDGPU_GEM_OP_OPEN_GLOBAL:
+	 *  - input:  handle = AMDGPU_GEM_GLOBAL_* ID
+	 *  - output: handle = per-file GEM handle to that global BO
+	 */
 	__u32	handle;
 	/** AMDGPU_GEM_OP_* */
 	__u32	op;
