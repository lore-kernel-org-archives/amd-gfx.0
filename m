Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8054C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591DE10E943;
	Thu, 28 Aug 2025 09:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHRKCmrC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5A210E943
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctsXadB8xMK/ywtAJkv8qpuK4TSSaBw+98Jmn339K9PbYEg0h8VA512apXGbIAkDf9visDfIgXurGrQc4MXozaSwPsvttLltxFM56kHkB+5YorfNjUKjxaHLoRMQOqqiZ2e+caou47U+4nhKJLk6tpD66F24dlWW9Q0yjUrgH6y1nTNOructFj9yE+bCqzmbEdUffwC6bJ4PYUBbnPAzGudn9UOCIjr5EoMq/4sTW1B4MVNSlxFf+aFr6wN0J7WFKlx0kDobgm3as9ZFWTdozdER2gdJTeEa8q8GdZpitRkm5kTMenyNRoJUifgxQ+vqZlsh02rlLBlZDldbAc0brA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KihEqS3qAlY9Bc1+rihompldm1hWvMJ5M3ZDDqQVhyQ=;
 b=S0VELMNQhKPFE820PYkQ81niU3oT3TlvrLMMqV/PDZjcRWOk6WoVzbs5RYtpO+K0qyJbjIz+KpiP1ANU7Qqd4AhOG1cxcuymCM4C3DdYH3NE4A+/yr/FVBc+QCAg2vEsm3hkDztg9b0gme46/nNHISLyO9B59h+fYKlm9Ub/TvXf27RaAKS/3AYvTspgr4Lm2iZXkCuQKNysmWaz0mhXNfpE8xr7pbbJiE5RuycwEezPdymgMRbpHtvW/bs5CgnKJa1TpXKmcIuzQ/R7MrY9IcDNH9CeC41wQ935KJNj8G8k5A6Ds1/u2WatPWpQZL5B+yOEedEMfr0B2Il7JOhXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KihEqS3qAlY9Bc1+rihompldm1hWvMJ5M3ZDDqQVhyQ=;
 b=UHRKCmrCDxTDmmi9TVFEDxsxSYopmtkabYQQsDaDsNjCpzd2CS74daEXtXM1DgLVXRVRtQttWY73iyc2ed/GkVAwi8WyyVhXXGrw0swd9j55zYp/l4uh56+OkeFI1QIqJ8vs+aMtvpGu3CM9AxZf1RtA3BGhnY/NOFLNLWGWqW4=
Received: from CH5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:1f4::29)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:16:14 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::50) by CH5PR04CA0018.outlook.office365.com
 (2603:10b6:610:1f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:16:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:11:43 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:11:42 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 1/9] drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
Date: Thu, 28 Aug 2025 12:41:23 +0530
Message-ID: <20250828071131.3948765-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828071131.3948765-1-srinivasan.shanmugam@amd.com>
References: <20250828071131.3948765-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d82a183-c4b6-4595-71f0-08dde6138961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHZHS1N1ZlZCMGVZOXBncU1ydU1QYVFUMkpodUFmK1htTk93MEt1M3B5dU1Q?=
 =?utf-8?B?cERKeS9qa2RzS0h5NnBIdzh6aWRBMGJHOVlQSmZwZjBLS1JlbDMwL1hHTkdw?=
 =?utf-8?B?Tm1aaldBK3FoRTVnMEdGOERwU1lnRVhHMGttdjNLdkZJaGRxNGVFbmdSNjV4?=
 =?utf-8?B?Yy8wR0pXWkhtL3R0ZTYyNUE4Tk96Q2ZMZTArcVlaVURrcitCN3Z3Z05ScWRT?=
 =?utf-8?B?TU4wajI5VlJVQUkvU1VoSFF0R1VzcmxSVjgzd24renNLKzM2bW8zd3lnb1dW?=
 =?utf-8?B?Ym9XSnhhOG9LcHI2UEFLOGI5NlhmQXpKNXZab1RPazR4c254NHV3S0J3ZGpT?=
 =?utf-8?B?bFpDMEtseW9hdGNiOVFCSEZUZlhLMWp6V0pUUVlJNHZHckx0RmtQeEx4R1o1?=
 =?utf-8?B?cUV5cGNXUEIvcFBqeTgxdU9DK1IvUG9GL2pIM0wyaDlNU1dWdWdRdVB2UUkz?=
 =?utf-8?B?R0VyYTIyaWdEMGJOQWVxcFZCVkdaeEJrR2pobW9pU3MyUVZSTTFDRVBCUE5V?=
 =?utf-8?B?WnFZWFJaOHRlVGtTUXJ3R01JYW9wQkxXL1NRcE5pa2RMNm02cko4ZGtXUWJs?=
 =?utf-8?B?K1kzazJPTGh0Vit1eXJxdDM0WTBjcVU4QkUvUUZuaklDRFZxM3JNWVlxd3NL?=
 =?utf-8?B?LzAwN3lRc1c0dzMwYWt5TmdtbUpQZGVINlNNeFFkUlhMSzlrbXFuMWVabGcv?=
 =?utf-8?B?R0N3ajhZTzVzOVFBQ0NhcXZJUU5TYlZoQXBTUHVXN2FNM1RFL2Jod3J1VkUv?=
 =?utf-8?B?czA0Y0xVM29rOTdhTXVxWnpsbEpaYW9Vb0lCK0dmRFNtZFlPWVJOeXNJR3NG?=
 =?utf-8?B?bEFDc2Q4TWp6WXZmek1kMEt6ZU9oa1JKbXFQMnhGNjNieHJKOU5INkZSOGRX?=
 =?utf-8?B?OXlnZVZ0Z1NPL3dqRXFuQXR4V3V2WnRlTlZ0SS8venF0clZYeXBoRlBtSG41?=
 =?utf-8?B?WHIyVkt2Y2p0VlB2aXdDM3BiZGtkb2tsemlUM2ZXbjdqZ3dqdWZIRDlFaytU?=
 =?utf-8?B?R29mRWkvbGc2QXJhWXRscUJ6TVhrYWR0R0prdUJhQkxFeVdzTy9wK1Q3N2p0?=
 =?utf-8?B?UWNrM3IrYjFQejdJVGpNQVBOZGc1aExwNkJNNTdRSVJBdkxOR1JGOEJoZXIx?=
 =?utf-8?B?U0VySjBRQ0srYUZ2S2FxOFJhZ2VXMjhpU3FpRmhEekdMTHYwMWp1Qyt1bGF2?=
 =?utf-8?B?dWNqci9DUE02ZGxUa2VmT0tmYUhSYm5XVndEZXZmaDg4WkpFZEVhR0c5Wnpo?=
 =?utf-8?B?dnhFUlh4dXROWXdMc3ZqbndkcjFZWFlVVE9KYUpBNTYxYTlKdGlpYmFTYmpQ?=
 =?utf-8?B?enF3SFQ4K05RNTArVDlwdWFBVGE4NjdQc2U4RTA5cUFzVjNJVGRYeGZYbytz?=
 =?utf-8?B?RXM1elJRaCsyaldITVFWbWY5TVZFM2oyWGxsbVZhd3BjT2o2TTM0bEM3OHBU?=
 =?utf-8?B?eGhCeG1kNWs1MGZGWmxidkhjWXg1RGxUVzBFN3NDanEwQ29FYWtxYkRSQkZE?=
 =?utf-8?B?Si85aTQ4bE8yVHZyWjQ4OWVrRk5FSU5HTXI2dlJWODVpWFVmSXVOVFdZYjRh?=
 =?utf-8?B?SnovWktGQ3JOVXVubVhUSm90OVB5c0p6QWpIL2lNcmVuNGpvcmN4L3UyVGw2?=
 =?utf-8?B?akdnbDNCZVhaL3dieng1WE5qclZFaSsrbjRTNjIwQTBHV0VIaXlaWjM4djBt?=
 =?utf-8?B?T2VQQzMzc1VQbGFhWC9lRWFRRlhySXJHTW95SU9qMUMyT1NLTEhXem1ranpx?=
 =?utf-8?B?SjlGeVo0UzVlMHlaL2w3TWttTUFhVkJ2TjgvdXU5OEpPOWw4MWh4VWk3UmRs?=
 =?utf-8?B?VitTUnYzSG9LQVdWMEN6ekJ0dHFCL1JvYjYzYnM0Z3RQcWcxMzBCUUh5OWVx?=
 =?utf-8?B?TzBYS053SVA3RzljUERvMXBjeWZObXQxOFpIMFNCRnk0M2c4d2NFZGVFcHlW?=
 =?utf-8?B?Ni9VMGphcitTYU5xNm1iYlQvd2o4TG91dEhya0dKZ3cwM3JUZU9kM3hvSFNN?=
 =?utf-8?B?SlhBOGNKS3VtTG1CMTg2Q1lieUE4TDBQZnBtMURnVlF3OTBqUFF6VDJhMUNp?=
 =?utf-8?Q?6Ww05a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:16:13.9564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d82a183-c4b6-4595-71f0-08dde6138961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
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

