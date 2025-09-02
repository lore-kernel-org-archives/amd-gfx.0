Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ECBCA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 03:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D752210E185;
	Tue,  2 Sep 2025 03:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jm9nE8dw";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92AD410E185
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 03:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi9h5y5OqXn7ApjL3viprFS9DH6GBL3VlIabXqs3L1Dx3NPSMbcaeDaTFkjGB3jnlTp9U8XekoDrbFVlSy+BNK7ILabZSbgeqj1eAUnVW6chSgfQJah8KIn8V+9FJcrJmLNBOJWDxK39k/tbzfqGlcxbmp/TlleSz2kE7wzPQNs8aYTNEnALms6yWtXZcHkv6tfIJhwnO/lfOHmN51hq4ry3RnLVij4dBcgdYF9EttAEVICzZpv7QEPfJGVj0IehKz2jnV8l2dbyAZYDzD/KX9cQf2TZ6KL+xX98A6i55vrCVUw6G0CbiuFsJZ2nnpxrUDu611DCmNqnRlts6o0Ucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG92sdH+KCj1UzsRtMx4ZBxJmKtLhPYrd9IvKrVuNaQ=;
 b=ZpBT7hHn805/GakCuHVV1BIWbRgI5lM5tMyv0abuRr9jTh2VzaZ5YJJePAm1ayaGM0A/B6kUaeLW7XKN0mcWlDZwiQCY1/nIa2I28kObIWQ9R1LvWZzFWJfSA+4ztcYkRkiUfRGqx1LQNS3RENwJOvX6VnVvb/eUS0oUgq0iXV1FHlk8HwvjehBTL3c+uDIOOSJi8r6dIVApbaNecDGRPOPtoAeX6j1Nxoem8DYjWGNcwaU1BPUa45n1FOqcc8CC3dqDSSoYCbtF8kUJxI8/ed9ve1M6VhMwN1LLOQpfbBtQCfzXUwtkhBVpC0bMjhC3vsGjYbt0HUneCvb6qcUv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG92sdH+KCj1UzsRtMx4ZBxJmKtLhPYrd9IvKrVuNaQ=;
 b=jm9nE8dwcZXk4yK7TooIBDA5Q4PMh51GPFVUIde9urrds38NR7vUyokqrP/Pu3ZpvIBQxPI3tTN8/BI1vbLSY8oPM33OfwPWJ95OSkJx9UaA2HgT/tWpSdYqhK4I0KAWLtia4z6WWDmL5uBve0tI92Yy/7N4vX38Sxt+tuCuCnk=
Received: from DM5PR07CA0089.namprd07.prod.outlook.com (2603:10b6:4:ae::18) by
 MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.29; Tue, 2 Sep 2025 03:32:14 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::4) by DM5PR07CA0089.outlook.office365.com
 (2603:10b6:4:ae::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 03:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 03:32:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 22:32:12 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Mon, 1 Sep 2025 20:32:11 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 2/8] drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
Date: Tue, 2 Sep 2025 08:59:32 +0530
Message-ID: <20250902032938.468332-3-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 9788ca8a-f84c-4559-6e85-08dde9d14e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2JRQmhaZklERkpmY2ZET0doM3NSSU40bWNSVTQ5UWM0MnNOU05ja05aRkM5?=
 =?utf-8?B?OW93VUYvL3BMSm9ocUJKM2ZQNWIvbDBKeVFxRDM5djBBejF0WFRoZ0JCVThF?=
 =?utf-8?B?UzhabWxZb1AzZlRLRHQ0dExDV21DZEU0dXVaNlcwaDJvend4NGRENXFzdERC?=
 =?utf-8?B?RkF1MHNFay93QWdZOGVlVStzSE4zWG5NdHVXbndERlV1WDV1ejhOeGIvd3V5?=
 =?utf-8?B?L0wyZGVrSDBkQm56TWdmMDBYM0QyeXBJeXRnSkpyZkZ1MjRCak5vT0Y0K01m?=
 =?utf-8?B?TU9NQUZXcEh2SkNWdkFRSGV6NFRuM3ZReDRkN09lSUdEK1Q4dGZsaW8wN1VZ?=
 =?utf-8?B?Z2ZrMUJ4YThiZ0ExV0l2ekRFWUplVDY4WlZrandDRjNUUHlIbm80eVZPbVE0?=
 =?utf-8?B?ZytQVm9TSm16Z1FIVDNxRkZ3czF5S0JORTN2aExoWmJyd1BYbkNMZmtURjd6?=
 =?utf-8?B?bkIxODRXWjVXVC96QUE5MTYwOE1tQlJ1Q3d5bmtJUEdJcmFVY25BUCtRZzJq?=
 =?utf-8?B?VDZFMXlUWVdyLzdvTjl6QkhIVDFKQWRLaW12SFlGOWN5aTgrSFphZFZIbDhH?=
 =?utf-8?B?S1M2SnZpRk1EN2l0VDhSQXl3U2x6MFVDSjBSRWhudllDUUVqQXVobnlFZ0Vr?=
 =?utf-8?B?NVB6eVVwYWx6dEVxWjRIUHl5UnJWb25nb1Z0SFhpWkFVUFBYRkNtSG8wb0Jt?=
 =?utf-8?B?ck9ITXoxdUh0L2phRllZUjI3ODMvZlU4VTR4UWxzM1VkME96K3ZPb2lKak5s?=
 =?utf-8?B?NGdwSmM0bG1aY1VxZm9DQ1QrZFFBUXJzbHZxUEtWVHJ4eVZybzZUWG9GVDc1?=
 =?utf-8?B?cndWbEI1NGtTcmpvcXo4MUxVaTlQamUyazV2dWZJdnFRbWI1RktHK1NUdzNB?=
 =?utf-8?B?VjNYSTJsL3Q4QzJCMFNheG4wZnpYbGQrc0tRSDM5QWE3MjNjUEN6bytMVDh3?=
 =?utf-8?B?NU5BcHR3VXZGcWtvaVlCc0lYRWREaVhDZ2RYbjNqWXc5K0Jua1JBa25TL0hR?=
 =?utf-8?B?RWdIcFQ4aDdVclpTYmlpNFNlcm1wVUdlazF4TUNhWVQzUDIzZWk4aENHOHQ4?=
 =?utf-8?B?TjU3Z0NhWXFOTnV6WDJ1RE5GQkRMVFZhOEtnam44dVB3Z1hIdWVDamNjZTZR?=
 =?utf-8?B?YVlvZTJCa1UrcXdkTEJ3SUdZOXpLTzNPNmdWTkd2d0NrS2UvOEhUZXU3S2JQ?=
 =?utf-8?B?RlhvTXNUVGl6YTR3QnlSS0t3RVFiYmw5VjBFNXh4YzJUbWZyT2RvWHlsNU5N?=
 =?utf-8?B?MlIxK0pzMlh2ZXpoMkZYSzNzL3JzdE5mTkRESTF4eWpPT3lnTmNibVRlWnNL?=
 =?utf-8?B?YlhaTDcxNUxIdEF4VWN1YzlBQnNnY0JxTncrRlF4UTFWSTlXYzdtRmpUWVhq?=
 =?utf-8?B?Ny95RXFRN1A5YnU3blBaOU5kUVNxU2ZWNjROVUVibkVnRmRyNndrc2t1dmFh?=
 =?utf-8?B?bnNvQnUwbENRMG5MbHN3Tk1McktNQ2ZnVXdnTW5wdUxGV3hFUGptQnFaMjYw?=
 =?utf-8?B?T1RKWnFLMTFWZU90YlhsbWJsN2pNVys2YTh4QUw1U3Y3VmJMUmJxK1FSdlJy?=
 =?utf-8?B?M3ErSm0xa3VEMkRDMVpZU2xyTXhsNm1iRjVtQXpqaDgzRFA3Zk5rRU9SeTVI?=
 =?utf-8?B?ampGR3dkM0FsRzhyM0VLdlk2b0dDcEw5OEJiMW92ZFdsT2RNYnR2dEdVeG5w?=
 =?utf-8?B?SUtmZ1hxSHBlTytvREdtR0V1YlV1K1c5Y1h0QUhBWW1ISTY0M2dhSEYzRCtR?=
 =?utf-8?B?QkNIL3BONGFiMXMxd3FvdjNRcGdFOG9XWi9PYjlVTDdiS085QXJiUlJTR1gy?=
 =?utf-8?B?VzJYQmdyOCtXOVFGaUdXQ1FyQkEwY3pEYWhZTjhTdDBhTWt5R2lvUWtEYm9N?=
 =?utf-8?B?VTJycEhIT3B5dU9YZm5SeDRjcW03Z09pZjhxWGFUWjJkSDhPVnJqc2s0dzI3?=
 =?utf-8?B?VkVxaSs2UXJXa0hvK2F6eG14M2NPQi9kTTlzSGd5V1FYUmtwVStJblBaMEhj?=
 =?utf-8?B?MzhoU2ZnWURhNW9XZ0cvNHlKdHVidUpra1YrWG5XV3YvcnZVUmpabkdvNC81?=
 =?utf-8?Q?CL0fuY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:32:12.9359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9788ca8a-f84c-4559-6e85-08dde9d14e74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

Add a new GEM domain bit AMDGPU_GEM_DOMAIN_MMIO_REMAP to allow
userspace to request the MMIO remap (HDP flush) page via GEM_CREATE.

- include/uapi/drm/amdgpu_drm.h:
  * define AMDGPU_GEM_DOMAIN_MMIO_REMAP
  * include the bit in AMDGPU_GEM_DOMAIN_MASK

v2: Add early reject in amdgpu_gem_create_ioctl() (Alex).

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
 include/uapi/drm/amdgpu_drm.h           | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e3f65977eeee..d3c369742124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -465,6 +465,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* always clear VRAM */
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
+		return -EINVAL;
+
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bdedbaccf776..fc44e301adbb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -103,6 +103,8 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
  * signalling user mode queues.
+ *
+ * %AMDGPU_GEM_DOMAIN_MMIO_REMAP	MMIO remap page (special mapping for HDP flushing).
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -111,13 +113,15 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
 #define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
+#define AMDGPU_GEM_DOMAIN_MMIO_REMAP	0x80
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
-					 AMDGPU_GEM_DOMAIN_OA | \
-					 AMDGPU_GEM_DOMAIN_DOORBELL)
+					 AMDGPU_GEM_DOMAIN_OA |	\
+					 AMDGPU_GEM_DOMAIN_DOORBELL | \
+					 AMDGPU_GEM_DOMAIN_MMIO_REMAP)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.34.1

