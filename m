Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6C3C5320F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C54910E34D;
	Thu, 15 Aug 2024 00:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uu3SPjxl";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9831910E33F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVunBTPAW9qLtD6o2fiInxGvYUtwRn21Isttq+3JcTKzOVyWBmUYNC1sAdQIXL/Hhyt91CTbet+Y2K5CbMGqsnG0/0fnAj8i4PiyW7M6MdUCP+EUMf3SzSYGvJo7CkFnqOyDWHIg4Wm/BorWxD5Na949cdH4R6UqH0CDOf/mBL/wIteUrNsZh3zuco7pSnHYQ8e2gMzsFPukFLPkeHqkuZVBjg2WToqlyAer7vnqdEBKIF2gCRr7R3rTC6XH03VcW3vzS/3WH4g9aMVzM4DhVbHFh1FybSAOrJ0r6iLQCDOgxBIFyOeMODdDgtM53+49F1+F64oBoPpf5jg/ASdESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phhzFDgmJ4IDIf6n5MAuLEeyQfV+pXuenNWCnlRMyz0=;
 b=h0iGMnsTvf+u1jh6Gve/iZ//q1j9BHD20G0Us1yJH9JSAVzzw/O29rmKk+HpGdhNYq/JupmmVe5iJ9O2QTQ0MhUX5Cmnw7GoPXg5NsvIxgCswWuXq5Z3VKIB33GKXMHKABZSj5B1dPdvKNB4h7RCp7Ro/IwUbjZ2p3UsAWTekSbt6G1UXsxGRtDdyZf58oKFFN6EEPDAyYtVG1dofElgoVfafYMG4sBzbATqn2BUR5y0ehnd9MhZqlsWbCUcXMj3DPDqS77MzFD/aA5HdEpbFla4LjP4ttAmWRXVRMXp1k1VQ0QVmauPa4d4VUGqwXSbOR+kMVlpIaFibu6I9ItO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phhzFDgmJ4IDIf6n5MAuLEeyQfV+pXuenNWCnlRMyz0=;
 b=uu3SPjxlCekPO+hqpm92ZRdgzuqsm0yEvFbeKpC0Y/VBjWropEqy9uSMGd9Iug9Q+DfJ7b9ThX64q75lDK83LRLim4MrDdRYsHoh3YqjqVomF30Dk2Wgl+2CEshMz5h6rY4lJP0+dS14KeNcTMyg+zjReZPRAduDj1q4Mhyz7fE=
Received: from BN0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:ea::6)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Thu, 15 Aug
 2024 00:05:25 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::e2) by BN0PR04CA0061.outlook.office365.com
 (2603:10b6:408:ea::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 12/17] drm/amdgpu/gfx9: Add cleaner shader support for
 GFX9.4.4 hardware
Date: Wed, 14 Aug 2024 20:04:56 -0400
Message-ID: <20240815000501.1845226-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: f64baed1-cd10-4081-ac1c-08dcbcbdf6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHBjSzFZb1VXNlZIbkZXMUp0Nlk2MHZMLytkZFFGL0lzVUVZNVlJRDFiMUcz?=
 =?utf-8?B?bHJGb0dBcGI4R3h1anF4UUNSdmFXOE5Xc0pFbHZQZ1ZSU0NJVmpvTG5rNTd3?=
 =?utf-8?B?OTVFcnZuaWtjK1paTVYyNGwxWGVrcnZZaUZ5cXlhbktveHVqSStyUHMxK1Vt?=
 =?utf-8?B?UWVqU21IWENhNHR5V2s4WVlZZWk3UGd3OGIrWC8rT1h1YXRwQzl2V1Bhbmt4?=
 =?utf-8?B?R0FqSzBSOHI2K2kvU3QvZXJPSHhlWXVQT3V1RlJsL1JUc2R1SFdkdnNzNVlk?=
 =?utf-8?B?cjc0U0lkd0p0NXNrZFZtbDRqYk5hVEc4d0w1czdIVHFrcG9URHVYYkwwakR6?=
 =?utf-8?B?eDVvQjFEYllZUXI5V3NZL0RXSWRXT3doOWJKT1orS2NVcXNveEs5VjlycVdF?=
 =?utf-8?B?WW8zZjgwUTRjVUNYRU4vRjJKdGFDZVdwNDMvWXZjSGVlbzRLWjl3ZlVhdFp1?=
 =?utf-8?B?eG00OXc5SWVDZUZjQ0hkeTRzb3pBVUp0Qk4zczYvVEhOZjRJRzdpS1RocU0z?=
 =?utf-8?B?Mjg1clQ4M2cwRzhkUnRIbFg5WUlIYVFWV1lYSTl2SFBxcCtVeGhyZTdTQVdD?=
 =?utf-8?B?elVPd253VlZSd3BjU20wcm10akR5OUM2ay9TWHVNQmhkUzFTZ2NNN2tzM045?=
 =?utf-8?B?S05iRGRFaDZROHFla2w2RXFjMUJpelFTUlBGVmpURFpuN0h5S1BETDRQTnpH?=
 =?utf-8?B?NDZvQUlweml6allEVXNKdVBXdEFqdldkaFZ2TG9nQWY4ZXN4UGdUTHlRN0tk?=
 =?utf-8?B?N0lQL1MyVVA3dWptcGs4K1hNa3RYWFYxSk9BSWdMczZHT3Nnd0dpei85emZI?=
 =?utf-8?B?elFyMDEzWHdVQUw0NldpQ2hVZXluQ2REeVgwVitLVEF2SHBLMCtBaU9lc2tx?=
 =?utf-8?B?OTE2V2tSWi9GaTJkUjBSZ0hrai96MENLMzd3b2hodkI2SVVqaVNxandPam9q?=
 =?utf-8?B?cTNESVBwdW9GOFUyYmRRS0YxcXNRRGpacFVUT25HTWJsbTRRMzVNQWJTOHlD?=
 =?utf-8?B?RTJ1Q082RDltUnNkSU9FV2JKaHFnaStreWlLMTBrUjVCWm1mUnpJTmo1TWxw?=
 =?utf-8?B?T2ZubW9OTVZPUjhNcEpucy9qNVhMYytTVlVxWWlpSC9tdU9aNkNpa3pLdTRO?=
 =?utf-8?B?QUJJUFhsRU14Q3U3S1J2UnpxWWJrZ2EwaWpnYkhvTHpFY1RCaXZzV1JsSkVH?=
 =?utf-8?B?RGUzZWV0T1ZDZHNZSTBnaDhMZXBrZm43S0NiQjNIY1I1dFNzMWFaOG9sV0Np?=
 =?utf-8?B?U2E4RHBQbkRZcWlybVlIcGhBTHN5TE9ZSkwzNzhlbmIxSVNnV1JYakYvQjJN?=
 =?utf-8?B?SkI2RUxpYlhGWTE5T1paak9NcUpQNTZXaGNQUUdWWE0vekFmUlJGR3o3VC9j?=
 =?utf-8?B?MDczc1hrWnU2SWhyakZ1MWVzak93UDFBU0NMZEpWbVpxNUQ5ZHdUTUJxdEpz?=
 =?utf-8?B?bjhjZm1EQzNiRHA1enlqUi9lOXFld2lScUpCcmNBZUpvTDAvbU5JNExOeGVQ?=
 =?utf-8?B?Y243UXVUL2pOYjFOMW5Hc29NaVN6LzYrU0ZLUGFtcGNHQWJySnZmcWRlTlFF?=
 =?utf-8?B?OGhoMTZ5M1dLSkVNZFdGMjlPaVlMOGRoTUpwSDZ4OUV0cHlVTUZCbXZCWm1Z?=
 =?utf-8?B?dFB1elZGZDdMMFA1Q21HY0FqVmIxaGt1RzFxRDdxY3h4K3ptS0d1OFJaK0VP?=
 =?utf-8?B?NC81Ukd2QzNJSTZ4cDdXa3YvMU9WWnRTT1ZNT1NMSm5wbEtSV2MxYWpzaDhv?=
 =?utf-8?B?a3ZDWjBLdnZhc1VqK1AraEh1WUZERFZEVmhwdnd3NlNuTnVCVXExV3NYdnR3?=
 =?utf-8?B?bHR1UE84My9qZkRNV05LK2tQNTNrUTAydUZvZDdNL1V6bUNuNVFHenpVWFoz?=
 =?utf-8?B?OHV4UGtxMmY4S3h6dVFGQmpsY2ZyVnFUTjBFemEzYU1yd3NvYkFSUVVWTHBs?=
 =?utf-8?Q?i5N87CNy1cSU+yjmsolwW2G+t6LRoLIG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:25.4461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f64baed1-cd10-4081-ac1c-08dcbcbdf6ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit extends the cleaner shader feature to support GFX9.4.4
hardware.

The cleaner shader feature is used to clear or initialize certain GPU
resources, such as Local Data Share (LDS), Vector General Purpose
Registers (VGPRs), and Scalar General Purpose Registers (SGPRs). This
operation needs to be performed in isolation, while no other tasks
should be running on the GPU at the same time.

Previously, the cleaner shader feature was implemented for GFX9.4.3
hardware. This commit adds support for GFX9.4.4 hardware by allowing the
cleaner shader to be used with this hardware version.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 28f4212a8db2..fa6752585a72 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1056,6 +1056,7 @@ static int gfx_v9_4_3_sw_init(void *handle)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
 		adev->gfx.cleaner_shader_ptr = gfx_9_4_3_cleaner_shader_hex;
 		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_3_cleaner_shader_hex);
 		if (adev->gfx.mec_fw_version >= 153) {
-- 
2.46.0

