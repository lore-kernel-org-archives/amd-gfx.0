Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59577E6F093
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 14:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961F410E20C;
	Tue, 23 Dec 2025 14:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RELM3MEt";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9125C10E20C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 14:14:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjyR6+he9Ck3r1tsLAQIiS1vU3xChlbr6h3T/NC2e/fK1pv9257zg6fCBYTDYbFFupPJRKhmEZeRJd5rxTXmKH6ueA8hzdEZX+Q4IPqmGqPBl76e3udUinMtctwBX6HZ0UO7vrj1uyVkYYCdtnaJL1A3IeRV9BdRpai4IaW20BETDXn6piz5aS37PH63syqrCVZwnso5fhiAVgt1rqZvs1oQsbUz9ln4VctjGtc/Dn3Ss/uR5Y37BJ+h+OloC4zgiwsjoKTCyfsTwV09EA+v7WHh/abyNfSjo2vifeaI9d0KxqYwc04IECK/hh+cRcvoPeG/ddgCw3sxHAQVRpplcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqM9mCGzkJtxCau+YbTgg14eGviKpuINbVlhkDX7GtQ=;
 b=Sl5ynTeROI2h+8uVq72j11RMx2dEO5ivYzXlqHntUF5KeGlc1Y8GgwX5WKA7hRe2A/voUxzwH+yEjh1io6Un1ZZeSpYDtf9RxgCM3MBBHYyvktL5GCLXfRJ6TnsGTfqa2g/tujJpFmZoP65z+XnV9OujLpHB8bixf7kLWy46ugwU1ejQ+uSopczXs2yB1RyxXua0VBv3PmAzd1cDwpuIgPZgQpojXWhoroCHzoCCfoY0c6UVd6DbrYMh1KCGW6OmigjcmV/xvPDJ1dDZnqcMejbnoCn1yAI/D8iYIYemK9qeQv70oMAgd76tT5V+NriTMd3NoKStDmcUSjJrBoMZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqM9mCGzkJtxCau+YbTgg14eGviKpuINbVlhkDX7GtQ=;
 b=RELM3MEtpZtXaATIUmi80TdBTWDJ6s6217LMQr/1nbB7Nmr4V7Aw1Q1OmgfbtK9KvXW3SlQwrxeWpg9enSKbXhvkseFhiUgGu29ZAKkH2QtK2pEHB294seREHDQ1PeEXGYlN+Suucb3HHcxhDVnAjBeGXecH46tgobpEvfi4dh0=
Received: from BYAPR08CA0015.namprd08.prod.outlook.com (2603:10b6:a03:100::28)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 14:14:54 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::ac) by BYAPR08CA0015.outlook.office365.com
 (2603:10b6:a03:100::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 14:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 14:14:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Dec 2025 08:14:49 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Leo Liu <leo.liu@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, David Wu <David.Wu3@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Add AMDGPU_GEM_OP_OPEN_GLOBAL
Date: Tue, 23 Dec 2025 19:44:27 +0530
Message-ID: <20251223141427.36850-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223141427.36850-1-srinivasan.shanmugam@amd.com>
References: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
 <20251223141427.36850-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: cb855e05-6563-4f51-f949-08de422da435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFhBZE5ybkdJbnVudWlZVVg3RG9kWUV4MnFZQ21ISjZhMUtrZU9kUk1Na2tr?=
 =?utf-8?B?M0gwM1Z5aTRMaVNMK09OTXhFbHhNK0VpdnJyWVNkVDVneUdIMDlqK09PRXRO?=
 =?utf-8?B?bWtHcU5VdW5XSjU3M3lxelkxRExNQTJXN1E3d3BmNXlzMVB1WEtMLzFBRFVx?=
 =?utf-8?B?dmJhOTdCUlcwYXRwTHphRVRFb2xqTU14YkpjTVhJc0NBTW51Z0Fwb05VQUxp?=
 =?utf-8?B?USs1UlloTmZpZ09xL3BxRDRRMUg1V0FySzdSdWlsd0FYdmJqVEFnRU0xWDdx?=
 =?utf-8?B?WjNyVWlENjQyQ1Ftei9pQ2txNEZ4Ulc3UEo1ZXdleXY3RnJ4T1dTQnROT3NH?=
 =?utf-8?B?cmV0UUo1aGRCSTljR0xIMElPRXFEZ09GRlRSVHBENnY5enkybEN1RGxXOXpr?=
 =?utf-8?B?N05MeGRyRGJTQjFmWlpmTnVGbmRkVWt3eU12RkZ0SWtHNHVBb3JnZmxzVE5h?=
 =?utf-8?B?emhsK01uclRnSWRiM1hhQWRMaUZyOTVqbG11eFFES3BtVWtRN3FwQWZrVk1x?=
 =?utf-8?B?K01zK0pvTmNEdDcxODZxUjZ1YlppZHVXZXM1dFArVUVjWjRramJIeG9GMmVW?=
 =?utf-8?B?dVJnRVRIMERxTVRkTXUwbXhhcG5LNEtPNncwSjhuNWtwdVp3VEl0UlZQdG5z?=
 =?utf-8?B?QS90aGxhVzF0OTFWMWh3UlBKeVUzOU5iZ2pLeDcvNENhVlNaZXdmYlBMKzBU?=
 =?utf-8?B?K1k2Y20vZ3dsaVp4VXZwYkh2NFRPVFRhMVY5WDVyam5rd25RNVpqaStPcUUr?=
 =?utf-8?B?aUhYRWlWWXo5TTNGZEtNUmlBZGhCR2trMHRKMm5yQm1IZ1pMUEtxVWdwQkFm?=
 =?utf-8?B?bklMQ2RGMEpaVXFZbi9vcnRmLzhQTlRSOER1aUpQTS9iSkJKUmIvTDIxUk1s?=
 =?utf-8?B?alZFenVQSVlldWtpSVNHaHpSRGcvT1I4d2VxZk8xQUxPUDJieW85QU5BeG83?=
 =?utf-8?B?VlJ5bEkvQjkvNnk1RmdUajR1TVNHbjBSNlBuTXYrOUpvR2dtZW1MbkZEQWJC?=
 =?utf-8?B?YUZmcmFRemZpbVBzNStjdTZybHJtZUw1MlJQcUpPNmFxRkFTV0UrVmdITTdp?=
 =?utf-8?B?ZnRJWktRdGYza1duR1dZSExWMGJib2ZqYTRNT1VVWG1Qdk9JYTZzV1Mzck9h?=
 =?utf-8?B?bWpFSldxOWZ0MjRndHNraDVxSWpNSWhZTWRGM3JhQlMxNWVOUHI2U3pETjQ2?=
 =?utf-8?B?SDJhb2JrMEtNK0JsYVdGZ0ZvSEFtRkxyQ09rVlVGS1ArSWwzSDJhZHFsQ0dj?=
 =?utf-8?B?K0RRd21jVVpBMWhGK3RWYUREZ1VzbnRUcTZUL1h2RFNwNSs1TjlWcFFXN2Fk?=
 =?utf-8?B?eXNpaFNPTlhzak85YStEUWRlTHNGamZicmtBYnVCeGp6aFdoa2NrdHIvOTZh?=
 =?utf-8?B?SVhPUHIvNlkzRWNPQjBJMnJuWHJVNmZQL1Q2VGV6QVdxMjU2alBTMUlRRS85?=
 =?utf-8?B?ZjBTOHdzK2g5L3lKS2tVcTkyQXJHV0drWUlyRS9zbzJCTlpKcHE2NWwxazhB?=
 =?utf-8?B?R09BSngwVlV3SjhTbWwyVWdidVV4VFNRUlQrLzJRdVBsRHlrY3A4YmRiOVk5?=
 =?utf-8?B?cjdiZXR6VkZKdUFiUzMyS0NMT1YvektzMS9yd1JaMHhTWDJsdW9iWXdQcEN3?=
 =?utf-8?B?SlZSTEMwQmxUR2JzV1BLVU50dCtvS0ZvM2RxZFFXT3E2dEZQZDBWd0NPUkJu?=
 =?utf-8?B?QmdPU1paMUR5SWx6a0ZobFZ2SUN0VXQ0UTR4ZTBQNmJFMDBnbllOQ3dGcm01?=
 =?utf-8?B?OHZUeW91QTdsY0FlYnprL2JUU1lDcFNlZnY0c2hZQ1g3Rit4WDNtOEF4Q0JC?=
 =?utf-8?B?ZWRSZTNTU1JDTkx0WlgzeWgrRTJvSTFKVmRTK0hqTlZ6ZDl1RFV6aDVWZS94?=
 =?utf-8?B?Ylo5UkxTQWF5cVkrUnZMQWVjNDVqUzZhckdxdSswSVFsUW9yeDBWbWhZRVFM?=
 =?utf-8?B?YU05T24zYXJmc0MxS0d6aHdoVEpWcjNQMy9ya3B3T0RuMlFyblYrTXVVeEZy?=
 =?utf-8?B?VG1SckRObzB5VzVqaURRM2Z6ckQ0Zzltdks1eFhkcHMwVTlHWHB3ZlJtTzBj?=
 =?utf-8?B?V0ZGQUozemZ6MUI4VWk2OTlRQ3FZZTN1VFJKdE5KaGZtTk95VE9yNU0yWWc1?=
 =?utf-8?Q?Xv38=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 14:14:52.8051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb855e05-6563-4f51-f949-08de422da435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144
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
-- 
2.34.1

