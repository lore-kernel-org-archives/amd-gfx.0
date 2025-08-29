Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C437CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 05:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D188D10E1FB;
	Fri, 29 Aug 2025 05:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L7PvTyim";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D29F10E1FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 05:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDRfPJVLWTr1fTXsndJ+ltXA6BsWxb+UKQcDFSY9GUWAExHRbm8lJXmNGe0PBHxjxf6uj7WQzMzWGcGBWdnis2QL5YvlMPopA1G8Gd71zyJ9HPZGNlqTTcfh7Y4jHS+dkk6JhS5Z77MiMgqifhMdeVOMhQh1ljFuCqdiffPVR7NNAZmRNENcLz7Y30vXtGDI0TpLYNmGDvDE97i34YQeeXKoymAEzn69RZr7WTRvDQYdLFZZTFK9nW5jWr3csCa+KXEl4GrKLBQM4ZkaX7ZMVZJqwpoXMgalM0CCZxZAm1P3f/kXJ4DFuGON+VQ0IqbiTbo8Fknd0tccirHlAXYfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG92sdH+KCj1UzsRtMx4ZBxJmKtLhPYrd9IvKrVuNaQ=;
 b=wjUUIAJYOo1L/yYFLF3nTKGjgakmOZGoGKYvSwPlczmUz5SrY5Tf0F4UxoeAbQ10HUH7VBhQQhcGXOwX9gWOA4CAtIvASr5bEN/GodUkAXCKqriWnYDpyAxZv3EeK00u+841Z1uAV0So/2eVUvPCnY0dr6ReeYvn/04CB1oyUUuW3U9pow6rtRAs4FKzskjIFLI+iY4MwH+K05m0Bj3NCdtiBjXOOcFelXaM1OyQT0It+wIzrZ7fFXPuUxNbz6Q2ACsAIa4ExTiyXWA+HE2MjpoFSpj5ys9tgzGbIyN6FXY9KxAYuVmAmR6BSjGNzyxFExoFb5ss35dHvpYCfX1P8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG92sdH+KCj1UzsRtMx4ZBxJmKtLhPYrd9IvKrVuNaQ=;
 b=L7PvTyimEB0zk00oqZ6z5IpnRj+BuWitXP1VFA+EVRrVeTCjkI5VgY5byLEMWtw9T3GrkcThDoCs9ZgQQbyOsJuVW6mxtjxO0TUPDZUhjaMG2uG6n3PccSS2rEu1MEtgxM1KugRxlHt9zxVhFCU6l3LLPSTdcq8jjKggZ0fGPsA=
Received: from BN9PR03CA0666.namprd03.prod.outlook.com (2603:10b6:408:10e::11)
 by SJ5PPFA5F0E981D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Fri, 29 Aug
 2025 05:53:31 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::5c) by BN9PR03CA0666.outlook.office365.com
 (2603:10b6:408:10e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 05:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Fri, 29 Aug 2025 05:53:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 00:53:30 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 22:53:28 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 2/9] drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
Date: Fri, 29 Aug 2025 11:23:20 +0530
Message-ID: <20250829055320.3983386-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SJ5PPFA5F0E981D:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a38679-4e95-43d0-bd29-08dde6c0620c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0RhUGkxcE1iMDFNNEQ1TWRIbC80K2VVMHpKUStRa0s0a3VaQmE5MzFRMG40?=
 =?utf-8?B?aVRmOEdOMzN3emFwSVFVSkdtZTczSlRSLzNONmVIN1VnSW1nMDBTM2lzZ1Aw?=
 =?utf-8?B?Vnk2SkpCbk5uOUkvWTY2dktjT1d4dGV1azNwQmpEdjFLejJmUkhIanEwUlkx?=
 =?utf-8?B?U0tVRHRJU0hRL3MzOW9FVVRqeWpaK1ZLU1ZCODJ1ajZPMUZZSlo0ZFlFczZ3?=
 =?utf-8?B?Wm9lZ1hYMzNKcUtzbU1yb1BTbis2UDNwc0Rxbjl5RXpENG5pMWVyZGNxejlo?=
 =?utf-8?B?TzFHR1NBU0hDdkdqWlRyd1RmeDNRdFB2azJQdDJBejQ5aTNnWjIxWjdSUnpO?=
 =?utf-8?B?ZFlOUTJuaVhzQ1UrU0JDYmdQOWZJNDJPajVkUktiM2JoSnp2NUxOSDA0MFpq?=
 =?utf-8?B?d1A5UWQ3Z3M2Vmk3emlQVTFwdGwzZnhyL0RUalA3ZlFUVC83ZEU5R010ZTdX?=
 =?utf-8?B?OGovMSs3QTVjYXNaSnlROE1CN3FhcUk3bjBRKzRja2xUOTYvd3FSOEZ1bUY3?=
 =?utf-8?B?STl0M1JUYVMwTmJnUG9mTUlSaXVONVNPSE9rY3d4Ny9OVFkvTFNwd25kdGx2?=
 =?utf-8?B?SnZBbk5SWnFwT0x0aEZhTGFyRFRKR2NBOXNkaWE1cEZSdU4xRU5qNWNaZWxl?=
 =?utf-8?B?K1NjZGQ2RXlGQTArSXc2aFZaSVRaTmRYWHZoaGxLNUgrc2laNVY5WDVoSFdO?=
 =?utf-8?B?TUVoUUJidHRLSnpMaVk2MUF5V3V5dUpoU0QreGRNWHFiT29UT2diUzZ5RFpv?=
 =?utf-8?B?aC9XQ3VMWDdWK1VDOGRDdTAzUWd0YnJBT0thWTM5TEdxMXRmSjdDU3ArWFBx?=
 =?utf-8?B?NVlLZ3VDdHp1bStpQzEyOE92N05KQytDK2R5dUt0aWRCZ2lVWDY1VjF6aTc5?=
 =?utf-8?B?dG9wZVVWTmx3eDBUYVBOODZPT1BFVTkzbmNMUXp2c3NoOWFmTFBxUmNwOE12?=
 =?utf-8?B?WnhNYXk3R3dyS1VnV0gvakFqM0xvYkJiWlBsc2hSZnZBSTE5RjdacUJlQkF3?=
 =?utf-8?B?azVEYkYvU0FtNmNBYXlWK1dlYkpqN1dlVEdwc3pkVGsyZmJVeWwyVGFyWWpM?=
 =?utf-8?B?c2VvRE85WkxySnRtUXMxMEdkRHlqRTFnRkhGd3pxemdWeFRaZkhvMUJiYkg3?=
 =?utf-8?B?Y0JCcXJubzRrNHgvcmQzNGRHbWY5WVFJSm53SzhJZldsMEdHLzR2TzFyandM?=
 =?utf-8?B?UHhIRTlUTktIQU1WeXNieFQvOVd3TDZSd2gzVXFJVGZ2cFBLOEthQzJMV05P?=
 =?utf-8?B?b0lIY3NQR0E0dzhtRmdMN3NPRGJmQkpyL0hsM2J4eWgwdzBhamdLMUQ3ckVD?=
 =?utf-8?B?VUgrakVMT3N2aHVrb1VDakQ1ZVNMODFWWmhPVng5eE4vQUJWV3o0bU5Db3Ri?=
 =?utf-8?B?Q0FHL2VmVmFHeHVsRm5zTUdheHV5ZXNGbFlpZmN3aHNnS1pzWnV4ZjlCWS92?=
 =?utf-8?B?aDhiOFUwTHB4MGtIdDFSZ3djTDkwaTJGaWFTa3dVMkc3b09PTjdreXlYeTlW?=
 =?utf-8?B?bStNbk9NVkFDNkExVG5ITEh0c0xXQTJPWEJSdVltSkVUekhCMEJabUxRUklP?=
 =?utf-8?B?TnVpYTFLeFVFMUdVckNDSTNFUXF6bzhtRmRNQm9WdWFXZThVUkJsVElJRzY3?=
 =?utf-8?B?QisyMy9QYkM3c3ZmZzk0bUNwUzhNYloxb3Jxa3BSdWZodkx5bUpVS0V5Y21Y?=
 =?utf-8?B?TjducHJIK3R2WlNXU0Faa1VrTEw3RUM2VTBDNlZWbHFVNWtzNDcyNFh1N0Vl?=
 =?utf-8?B?RkNKR0xBQ1lkK0d6YStXbFJXWlhnTTFRSWxTaTBTcmR4S01tVE8yampvSzVx?=
 =?utf-8?B?UkJGM1FpQTNFZWdoY0VuYVoxVWREVmNjOW14dVgrR2xHREZhRmtsWU5kK3Bm?=
 =?utf-8?B?YTE2YXQ4N2JWNVc4MUN6TFk3N0NMQWI2R2srYS9hUFVBREpmYStEWkhCZERD?=
 =?utf-8?B?aXZDRjlpVmkyaUlxeWVRMjVjem5Ua2N0QmQ5UkpOaFFSeVMvcTdvWG9aK0hK?=
 =?utf-8?B?MjNVUFhrcnBEM1MyamlKVk0wZW5QR0Z6dWhxdy9HNkRzRjl2cFBsSUk1VWtF?=
 =?utf-8?Q?T5uc6q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:53:30.9159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a38679-4e95-43d0-bd29-08dde6c0620c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D
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

