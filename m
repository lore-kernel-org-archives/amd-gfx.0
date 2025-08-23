Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84735CA0EE4
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Aug 2025 07:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2421A10E1C2;
	Sat, 23 Aug 2025 07:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dj1qfNvk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A42210E1C2
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Aug 2025 07:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOhPiNdy3SruMbNBoYFlPggxspBuiRSgbW9qp8ahq61aKC/U9a5S5iqKK789GMAshf4j0PcuMMDzcZuvxfRdJ7qcpTql7t9q2sSQwrG3LuCD0EVt2MZVae2MyZ88ezx2MBHXfWCyJt8Snn6vSCsRvd64c0DQ4NqSU2N4owo5e3FszHJDV4307u1FK3UhrEejWNlzwkUjczFtUJg46qloWeaVSbfve8jBTUIXHWq8FE/pm+UYm/RxV+x6hIQOcgI0XjaoVdsAL0r7dwON6wC9Ey0SAtad8cxGd3ZQ4hVDQ/na8DD6Q9sOGhs2fS2ms+kpzD8XCPijqA54HS4V4fAmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqN/0yIcW59LAiJbS42yxn364qWEfYqxZSe4kcXhJrE=;
 b=hhrLhivr+QDMdiKPsdh0SWQILWBHOATPfu3WmuFVLchukFIl/CY/k0rut6z1cMi6wwTYUXjz9idt2pVWZHo9dMZ+n9slTRcKgAbyxH81ybeC0QEjMNlWcPX3GuRolRGBQ3nS99i9JIYzKK9Qe8fBRHXgvSH6yz290smLyRL4pWvalmXVraMqRHQZBsG7ctnrdjUlyJkqXdA9QtwmWyzezfB/Sp+QA3bwJWSapMMvNWsEjJ36O4cvnyRqgjZlQgsNey/LRXQkMFxAIv93FuXALDTTA149AHQJjvDTvXuybgmggD0vtpYJQkzxuUGAW989tu/niVSGq16wv6Kodcw9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqN/0yIcW59LAiJbS42yxn364qWEfYqxZSe4kcXhJrE=;
 b=Dj1qfNvkEa8ogBiOXCfcSesBTJp0y5IC9lKszIZ6EAmzjM0saMwN+otOqRPydP9MlojhU+eBuIaSrapHcAR5YyeRGTcL5RlH9dzSfOm9+r3rtLxczNJpB+rLwMpk8Ympk02BAVB7GoIvFqxz4je/CqSfT6o3XrfSjHoD1Tr8sX0=
Received: from SA1PR04CA0012.namprd04.prod.outlook.com (2603:10b6:806:2ce::15)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sat, 23 Aug
 2025 07:20:48 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::eb) by SA1PR04CA0012.outlook.office365.com
 (2603:10b6:806:2ce::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 07:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 07:20:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 23 Aug 2025 02:20:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 8/8] drm/amdgpu/gem: Return Handle to MMIO_REMAP
 Singleton in GEM_CREATE
Date: Sat, 23 Aug 2025 12:50:16 +0530
Message-ID: <20250823072016.1272328-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 4091568f-ad1a-4887-b832-08dde215952b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnBvbDhrU2xTM1VyU29SekxGNUlBQTRlTHliUXZlaU42RTZHTFlZa1dvMVo5?=
 =?utf-8?B?aHhucWh3TEcxVFlkbTN2Zld2Nm9Id0ZKTDFDVXNhV29DcmZvS0xUQUpFN0I2?=
 =?utf-8?B?blZBWVJUUlA4cDVzOGZ0cWt6NVJQRVpZRUZNdTBiSUFqcFUvVDQvaDNXcHdB?=
 =?utf-8?B?NDJmWE5rbXJ6WFRHclBORjRwbnJZMFZheGRuU0pVbi9jeHk5NjJRUXFaN3du?=
 =?utf-8?B?L3ZOOEYzSWxBaDNPOER1bVdqYzJtTGx4cnVMVkxKdmdPT2ZWRDZ5MVgvUnZ4?=
 =?utf-8?B?TkNpL013eDN3aDMxTitwQlkvcmdSQjNOVU9BKzdwMjhkZGF2TjJVWVNRcFBW?=
 =?utf-8?B?T2M3OWFlU3lEYjJIR2NWTmRQcTJTVmdiVEZ3T2J1c05zaWxVKzN5SVFvSkgr?=
 =?utf-8?B?b3Ewd3RmNTY0SkhVa09iYVJpMllrSU5XbTlRMldydFlSd0dOSE9BQ3J1dGpR?=
 =?utf-8?B?TFNDbHRwWDVhaDZCdVhHL0hPbU50eXJvdHNHTC9uOEN5UWtPN0ZqbDFhMWMz?=
 =?utf-8?B?YWNCdVZkT25tNGVxdVpER0xKNmRVMHBXRjJ3cUtvMi9wbytFYXpwK3A0RHhJ?=
 =?utf-8?B?T1hlZ08wMEM4aUJoZVlRZys2S0NyTHFxRFB1aHl0bEpvTmUzM29mZURMWHBV?=
 =?utf-8?B?ZjJkNnRyZE1obEs3Vmc1eUJ3ZFZ1bnV1TU5vRnJIajMwcXhCcU94eDR6ODIw?=
 =?utf-8?B?WjVVRENCZEtmMzRZNktVRTI3NTVIdU55V0FMdGlPOVRvTzdHSlZESURnN0w3?=
 =?utf-8?B?bXNpZko0dTY0NEpoUzZOOWtsbUtZZnZRT29xK3hycG8xRVVUc1l5NG1vSnVm?=
 =?utf-8?B?L1p2ejM5Y3dOc2NUNVFZQkZZNmZTNnRjcjhFVW5xV3lUdHAwWUlRV3VXcStE?=
 =?utf-8?B?cmZJSmZnd0ZRSTZyS0JnWFVZTEdsOVNjUytXTDJNYllvVFZFemdXMHYwU05V?=
 =?utf-8?B?NUNDVEc5UEN5VG5icmpWMlE2Y1IvbW5NRWFQYlp0YUZGY2VOd3VWbUxsd2Zl?=
 =?utf-8?B?aEEzYTRKMUw3bmhaMG1NdlEzZVg0VW1WN2FGalpNazZ0WlFHelZ6bjlTRGp5?=
 =?utf-8?B?cW94NGRITHhtM2FpaE9VSVJnV3NrYStHUU4xNEF5QnRCTVUxVnJ4MlRDYlNy?=
 =?utf-8?B?T3dMcWhlUEVxNGZLMW5zZFJtMk1yYW1pczFuQkYrR2ZNb2dOS3pZa1hyWWFN?=
 =?utf-8?B?K1ljMktOVndkRVg1QnNxaXU4VGtzQTR0dXJGZ1FjOTNLRnVZRS9vOE5tYm12?=
 =?utf-8?B?WGU4Wi9qSkhLdFBtWnQ2VW5senh6ZDFDTmF1cUFjZEdtamxZQ05ZVWQ4dGZY?=
 =?utf-8?B?cG5DTkh1dXVLMWc4RExFY1JuQjU5WFlWTWc5Wk1mZnZ1Ny9wK0ZrSkUrd0JT?=
 =?utf-8?B?YkRoRVQwUGhmN2RqSWR6UlpiVmc1VDVLM2YxeW9DeGNVaGJzblZuWTk4OEYr?=
 =?utf-8?B?bGwxb3BzUmZIUEZpcVc2OXQyR3lFRG8yNEgvK2dYRDdVcDladCs2YmhTemdR?=
 =?utf-8?B?aGRRZ2tUaDBORkZZdkpjb2tSNlEzQlJaTVRCSTVHVUN5bm1PZENkWWVYWmJ3?=
 =?utf-8?B?MlVRc2dWN2JKQnpSR0JpUkRYZkdSa2t4bVFQU1VPd0luR29udEs4NUJOQWdH?=
 =?utf-8?B?dWpCYTYxdVNoMjh2S3NOS3IrNlFCWVVaTUxWdU5SUVUyeW5yZXNXR2RxTTlP?=
 =?utf-8?B?bVVZc1JwdENzcklvbDhzK0t2d3RsVldQSnRpMUVHUjErM3lmVGxrT3hvbDRm?=
 =?utf-8?B?eUVhU0hKNlppRUZYd2Zya1QyWC9jUzJ3S2YrN1B5dFJKM0k1dXdlcDl2S1N0?=
 =?utf-8?B?d0cwcHdSWjU0V0pLZ3I5cE5GdWNaVXpYbVFkaUd6YUFBcG1hVWdLd3hNdmtT?=
 =?utf-8?B?VUQ0OVZvdVBOZjhJVnBoRXltemhNeEQrWFJhOFlYL2JUam5DeHJ4QzE3VnB0?=
 =?utf-8?B?dkVMdWJJamNVWS9FRHdsRWhrMEJhY2hHRzBJUzg4dWVOT3YybnFOMnVZS0Q0?=
 =?utf-8?B?MytHcExqelFGaXFwMkMyOG8wSFExMy9RVldzbTlXL1JaNmtrMWVlZGVYdjJC?=
 =?utf-8?Q?8O7vkj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 07:20:48.0684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4091568f-ad1a-4887-b832-08dde215952b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D
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

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 59 +++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d8cffd26455b..655281f57a99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -424,6 +424,38 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.vm_ops = &amdgpu_gem_vm_ops,
 };
 
+/**
+ * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_REMAP BO
+ * @file_priv: DRM file corresponding to the calling process
+ * @adev: amdgpu device
+ * @handle: returned userspace GEM handle (out)
+ *
+ * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer object
+ * (adev->rmmio_remap.bo). The BO is expected to be allocated during TTM init
+ * when the hardware exposes a remap base and PAGE_SIZE <= 4K.
+ *
+ * drm_gem_handle_create() acquires the handle reference, which will be dropped
+ * by GEM_CLOSE in userspace.
+ *
+ * * Return:
+ * * 0 on success
+ * * -ENODEV if the MMIO_REMAP BO is not available
+ * * A negative errno from drm_gem_handle_create() on failure
+ *
+ */
+static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
+					    struct amdgpu_device *adev,
+					    u32 *handle)
+{
+	struct amdgpu_bo *bo = READ_ONCE(adev->rmmio_remap.bo);
+
+	if (!bo)
+		return -ENODEV;
+
+	/* drm_gem_handle_create() gets the ref; GEM_CLOSE drops it */
+	return drm_gem_handle_create(file_priv, &bo->tbo.base, handle);
+}
+
 /*
  * GEM ioctls.
  */
@@ -468,6 +500,33 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
 		return -EINVAL;
 
+	/*
+	 * === MMIO remap (HDP flush) fast-path ===
+	 * If userspace asks for the MMIO_REMAP domain, don't allocate a new BO.
+	 * Return a handle to the singleton BO created at ttm init.
+	 */
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
+		/*
+		 * The MMIO remap page is fixed 4K on the GPU side. Do not
+		 * allow use if the system PAGE_SIZE is larger than the GPU
+		 * page size.
+		 */
+		if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
+			return -EINVAL;
+
+		/* Enforce fixed size/alignment when provided by userspace. */
+		if (size && size != AMDGPU_GPU_PAGE_SIZE)
+			return -EINVAL;
+		if (args->in.alignment && args->in.alignment != AMDGPU_GPU_PAGE_SIZE)
+			return -EINVAL;
+
+		r = amdgpu_gem_get_mmio_remap_handle(filp, adev, &handle);
+		if (r)
+			return r;
+		args->out.handle = handle;
+		return 0;
+	}
+
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
-- 
2.34.1

