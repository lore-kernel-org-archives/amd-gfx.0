Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D049C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C7D310E958;
	Thu, 28 Aug 2025 09:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vs54gMu3";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2BD10E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJ5SV3T3rlyeEsznOr/7j6iV7oA+twSxk7EY/WlqP+n9x+OpPi+d6uG92JSxteMGhqK9zhwb/2su+ygfSMDq+lPia7csridxyo2YldMYuPmHj55oZeTKA+hHOdeCqFAuWDgxo5TD0/me7BRE55Skq/E3SzxY3rO/T9jhyRul5y9sCYUPIS2FLlD/eiTDOrcFJL6s0/dqFdUDupoQnlGBWu/yqpdymJNgA4m8gO796DYK5UE17yDBG9oTA25lQCkMAhVX4eJW9d6rcVu/R8PfyV3lX8J7dpsNUso28zsUy7g0D5+LbP8zxJ0l5TJBCcokFeN23LOyBM+KYWTJUw88Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KihEqS3qAlY9Bc1+rihompldm1hWvMJ5M3ZDDqQVhyQ=;
 b=grY8uXdDX6xlIDwbD9vuvOTLnKONr3irgb+i7cjZICv28mlBTT/I4mn9mTu0uSQ3OqguCCRvqiw7gUPuBZ74hVQuYaGpLxnkMMyrnhCU1xcWIuBXyBS004vAXWqj2QtnZt7UUvzZUnQ0L8MIlHs7pRbfefzbnxFgZJOsX9CReJ972GRsricMpWFoprbD2LE44ltJ52oviy9gE3Y3i0QhgBhd2gjD5bPZ7j3u6QYeEpOfk5IBjkhWXB064HdPqr628UQnxsQjY9wUhG2HLwFSg2gI4vqyzCjdAfar3l3hLQr8/KPC322cxJUrrXM72v2IMoppTnegXcWtuAJQ7QvwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KihEqS3qAlY9Bc1+rihompldm1hWvMJ5M3ZDDqQVhyQ=;
 b=vs54gMu3FtxLR9I7fjAh5pNepVgsEL+4VLybjSD3hwnL5ofoD0zLNTsv8QCnjFBbJK3bOY8jiALDbUxScxIBJuvohrJgo9S4xDqISgW3bgQme5rZvFRsXTmJFeh09c2f2Y/ARjdfqC/CGmjUMyf5r1UN/ZIchAUUVk2HSMl1V1w=
Received: from BN9PR03CA0721.namprd03.prod.outlook.com (2603:10b6:408:110::6)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Thu, 28 Aug
 2025 09:21:16 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::94) by BN9PR03CA0721.outlook.office365.com
 (2603:10b6:408:110::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Thu,
 28 Aug 2025 09:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:21:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:15:00 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:14:59 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 1/9] drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
Date: Thu, 28 Aug 2025 12:43:27 +0530
Message-ID: <20250828071335.3948819-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e805617-399b-43ef-2348-08dde6143d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZS9YYjliKytIV3NMTC85N2YrMlBJNGgxWmVSem1JQXB4WS9UWmV2aVQ5VDZY?=
 =?utf-8?B?ckdXcVNHZDFib3Qya2d3RFpLTVp5RXpBd0orZWtWd3J0Z3VQK1RHVGZmZUpM?=
 =?utf-8?B?MzE1UXp5SzErVEFYaHZ4UDVGbmtUMzNQamtmcXhLU1BmYWlSVUdrYXJibnE3?=
 =?utf-8?B?bE8vUEtQeTBCMHRxdXZYV0ZNNWVUbVFNVVNJS2Zaelo0em9aMTJldTZ3eHZK?=
 =?utf-8?B?YXJmbC9jRlo1UTNOaU0xbE9WaitLSlZpTGVaQURpa011RHExKzAvRGhxRll4?=
 =?utf-8?B?YWxxTnhtWGhwRGp3Ti8zOGxlMGpteStTOWFNK2IzMUc0ZExlQkZXVUVlbTRV?=
 =?utf-8?B?cnUvd0JpSWJkZy8vUWNEeFI0SGZ6Z29hWUE5RVZTMmxJQ1RmNkJDTW5iQUNB?=
 =?utf-8?B?QXE3bHlKazlMOVN0TklxYVZOR1ZoSEl5UUh0ZFFwUWQyajZ0c1pOMGptOUh2?=
 =?utf-8?B?SkViQjRiZExaajA1R2VVemRaU2hMTENqa2FWVTlveUhFVE9kTEh0MlUxeUQ5?=
 =?utf-8?B?N1hUWmNuSVFnRFNIa0ZkaGV1SUlrWTJ5RTU3ZHRlb00zUzdacnhlcHVlanov?=
 =?utf-8?B?QlZaWlVIb0syRk9nT09mTFVKcWhwUFpGKzNpZ1lDZTBycmhnZVU3R3BwS0ZJ?=
 =?utf-8?B?dW8zVnJ3K3k2YmNsaHBGWWtINHJWSnVJNHdEOTNHTWJKcFh4WlU0OTFQeERQ?=
 =?utf-8?B?UnhUa0FCRkg0L3dKcVQ4aUVPYlhRTDdDanZ4eTVSbWtHUFVYcGdablVFTXFr?=
 =?utf-8?B?b29PLzdnNkhCMzI0d1FWWlZaTjFmazVpWjk5QUVRZHJYRDg5dURrT3Z0OUs1?=
 =?utf-8?B?NUgxZ2RjNjdLRHNFZjlJRXhaVVpFWFFzQ0xYTTJJRS9tSk83S2swaEg5eXMx?=
 =?utf-8?B?VGhsaUZURWRWazJYUVVaTTluTURoUTVnd1Ntek9pNEYySTFJeUF4ZGRTZ1Jw?=
 =?utf-8?B?cHQ5cStsa1JxWE43eTNlazVGS0ZEN1JhQXdwWXE0WFpaZjVZWTVUWDJBN1pY?=
 =?utf-8?B?VEl5RzZRejJBWS9ZMHFqV3g5VVBZbTMyaTluL3cyRmtESnhzVVpXT1g3Q0Rx?=
 =?utf-8?B?aytPNyswL2FPblE1OGZzbWNWVVIyRUswRVNvSDN3Z2RabzNydVArV2pRM2VC?=
 =?utf-8?B?eXZmUjhKbWFBbU1zc1ZVcWtrSHRGR01pQmNZZUVpdmxYSWVWcTZFcXNaVkg4?=
 =?utf-8?B?a2Y0d0lwL01OanFRSFFiYjBFclBObmN6SWM2UDhWTU5DTVJMaXAvNXpaNzNF?=
 =?utf-8?B?U1Y5NHFWNk5DdWsxQlpRVmNMaVpiVEQzbzRPeXFzMGpSNlJ4VzFPZW5Fbmpz?=
 =?utf-8?B?enJSL3B1dUd6Y0JLV0ZiK1JDTy9laERwMHFZdEwyZ0tYMjYzT2p1SktWQkxF?=
 =?utf-8?B?SnFpbEFhVFBSV0NyL0twa0FVL0tPV1NMTzBRN08wOTVOS1VlQnoyd0UrOUtR?=
 =?utf-8?B?U0lpT2sybW9WRzI1NU83VXk4OHNMTHAyRE94Ylc3R2tBQnpTOGl6b1IzYlAv?=
 =?utf-8?B?UFFySnlhWSt1b2ZRTXljRlNndXI3c0VDekN4N3E4cnJuQmNOQVBaT3lNOVE5?=
 =?utf-8?B?R2ZqSTYzK1RTVXVhdml3ajYybzZiL0Z5bkRmVjVFeVoxVEdKc2l2WkpLbVZH?=
 =?utf-8?B?V3VVNVU4cG1GN3lISU1xWjJraExlZnlwWnBQMEhFa0JuMGMzSVEvL2JTRnNV?=
 =?utf-8?B?dnZ4RHg2Uy9FL083U01qRlM3Zm1oZ3ZzS2NORStKMWxnYVh1dlZoY3FsQW5a?=
 =?utf-8?B?OUpmcStEdm1RMWZuSkdSZDg5eDZ3eWdmNUh6Wmx1eG1uZnRNZkFmM1hQS285?=
 =?utf-8?B?UGZKSy9qLy9oS3Z0ZDJ3U1hIOXhuOWdDQysvV1JQMHI0WGhHOVpqV1VlNzVw?=
 =?utf-8?B?NXNaYXF5eGZrakd3eGRrMlhSOTVxeXh1WWhkWkp1RFhJckcySGRlejZ4NHJH?=
 =?utf-8?B?VUxxZWhKNDFQbzQ4MXpuWDdiaERwbmpNcUZUWjdMOHlNdW8rOSsyTWxiUzd2?=
 =?utf-8?B?bGYya2JmUC96UC9JaDdVS1lnK2xLcUV3YmErb0w3bDFLeTJKWjZhc0k1TWVG?=
 =?utf-8?Q?nuc4yI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:21:16.1634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e805617-399b-43ef-2348-08dde6143d81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
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

