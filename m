Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE77C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 03:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEBE10E03B;
	Fri, 17 May 2024 03:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dc6UQpsQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7CA310E03B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 03:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdJ4LafnkvamXhh6iubQ1MJR1bUTDb8gDiA6PDM44ZGUeokk0sm/wsOzaSBA4Z8bxI/sDgK5i5Hb8pbC7g5qIIMUKzmpVRBnAKH3CAggf64wQAm/GacZ3ynuNr8fD3Bo3/lsY49XZBzmE1H0SJyhL4yTphzUcrt4XReZCeJz6a5tAA2aaIteQTkuwmQ0n33Q3jrHrytsBJcVdR2xTkjkmi/XIQ/W2Ple0gGHmMhskiAg9cnWF+E3fOucDO3JZZ1BFKBg+YGvm/OG/wDyAABJrYdhqMOMFHoYtiP44coZpf4O3gE6x8pREUhWwx8eC6qubtW4BGWBjaDEGNrmctBVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0vN0qj8ppONTvxgr6zCP1zmfP6AQAF75X5G6LWvz2s=;
 b=lFQhfoZyW5I9Op0IZz0qiK8BWWLHxIa/f2UB+WtDGARX/a8htpZbo+2ZPInUIlgVWmXQ+WoS+EzYN+brXaSsLk3mxwgrHaiVmU3X751Qu39wWVD4rHpRd3Gq6hFaa9Ommxdrbekenxo+g0b5nm4z6xOVfQW26SpjjFF4dVdC3BmBiAXb2WIXzHMAEl36cbWpPBWtonJ3i9h3X0C4bW/+UVMbfY25NsyfW7Mxr+jIABY9LjwgK85G1CL642NHdNXS2JmY3tQlK+5CzEUA8i8jqhthfle4xGvZlETYEdMH1dqc5AAKuXDRo5ycAwzXHcjuMucQNNiS2PAy62r7PkhY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0vN0qj8ppONTvxgr6zCP1zmfP6AQAF75X5G6LWvz2s=;
 b=dc6UQpsQ2tQnf4KdO6RUNiftzxqCEGF5M+uGqaRyRMl6igJisGLZcNkX82tSIpFyaPvFYxsXAELZvpagYl0LbSZtspXR036kd0/GAupE0KjdFMQ/NZ0TG71mHfifqBJdupSGf0K/sTWhgD7/6vR0pjLg9gIM/ln2ZjKk/rbgFRg=
Received: from SN7PR04CA0156.namprd04.prod.outlook.com (2603:10b6:806:125::11)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 03:33:03 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::72) by SN7PR04CA0156.outlook.office365.com
 (2603:10b6:806:125::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29 via Frontend
 Transport; Fri, 17 May 2024 03:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 03:33:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 22:33:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Likun Gao <Likun.Gao@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amdgpu: Remove duplicate check for *is_queue_unmap in
 sdma_v7_0_ring_set_wptr
Date: Fri, 17 May 2024 09:02:44 +0530
Message-ID: <20240517033244.1825782-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d55723-4268-4741-21b7-08dc76220ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkw3NlV5cnVFTlRFQ2RaclNrZWN0TWRKMUhBQUpaZ1dzdEZRdmRBRXBISEI3?=
 =?utf-8?B?Vy9oVkx1YXpyOUh3MlhtM2I4OVNNYmtXMjZMZWhrekVrMFdiV3ROKzVONy9V?=
 =?utf-8?B?K0xJSTVkbVJBQmY4T0xpM3puclc3QWlZem14UXkwWHEySWdYMExCdTNoMklS?=
 =?utf-8?B?cE1NV3FqMHVRNmNlVStwd2trRFpETXcxa1BIUkRXQ1JFdzA0N0hWaEo3eGlh?=
 =?utf-8?B?RUkvY1A2Y3lOU2JwblRvTnBSRXRVcHdJYzJUNUtCTUZYUVN4WDhlQW9RZ1R3?=
 =?utf-8?B?QlRmR0pvK1k0N09TZHloVXlMQWYyYmFjSE9iOWc5L2NZOGo4bTVycUUxeEt4?=
 =?utf-8?B?N3RYWVU3ei9Yb1k4akVHb1FpZ0lGMlVFT1RybFIwUDhDbVk0YVowYS9GTEo1?=
 =?utf-8?B?cEFSSkFVWFIvSExtMmlCem5EQU1zQVRQSXF2Zzg2ZTVCZHNFdmEvWTBGZm5I?=
 =?utf-8?B?ZVB4UWNYYWJ4bWxOeXRLOHI1Mjg1UFZYZXQ4d3B0TnlKcEIwU25kYzRyWWlv?=
 =?utf-8?B?V1UxOTl3V2xOMTZxWjE0SHhEdm52R0Y1R0xPbmlnNXlJVFJ3Y0dab01pK2ZQ?=
 =?utf-8?B?Tnk0R0RLTXpFd3lteGQvS0hVY09QcHZKS3hpanBTVlJTcUN4aTRTeGd2RmN1?=
 =?utf-8?B?U0t6Z0FOTW5GUUtqcTU5NklxRWZOWGRBTDhRc01oM1ZFYzRzRXM3N3dudWRl?=
 =?utf-8?B?MHN6SXVlSjl0VytpbitDazR6c2E4UTlKeXFMQUhQT3N3eFJaWCtFM2dXRm9k?=
 =?utf-8?B?WWRRTGhYOXRwRWhMUHFGVkR2d1JoT09mNFBxcXg2TkppZk13cXQ1ZVJ2T0I1?=
 =?utf-8?B?YWdpd0tkcTNsTTczK3hveW1FeWQvM3V5TEZpZk01aHRlVXZBbGpjQUZ6NmpS?=
 =?utf-8?B?NVUxcmpicHNzdEsvYnJSRkNtNkJueUtta1dtOVpDU2pRR25ZRHc1bngrR29Y?=
 =?utf-8?B?dmcwd3JZYWNmZUt4TThxQXlQU2hLV2lKQ2xIcFNOaFpUTGlYdDhqcGlaRnI3?=
 =?utf-8?B?SjhZZldZcVluL1JVV1VaS2hDanRBZFBMSkhMeDBYSUFyQkRNYzhCMG11dnVX?=
 =?utf-8?B?OFA1ZlVUckxWakw2K2xsZWIwaFFKbmg3MmF0TkdCbGREcjlTRFlUclhmOE13?=
 =?utf-8?B?c1o0T29WSWhTekZnOUxGTmNyVklpK0xZVzN1UFMzNzdzM0FNKzhEWUE0S3c2?=
 =?utf-8?B?K3VlMys5cW1HTlhLMTB3R1lDcVlSVXFNMGk2aFpBQkp2TkszMFBaWEE5Rysr?=
 =?utf-8?B?UDIzak9vR1VlR2J1RkdBOFFjemdodkJKSGdxRXdGTUhCclhXN3FGclBPSHB0?=
 =?utf-8?B?MmVSNU5ubUN6SEtzckFpeGxsb284N01JNGp6TkRKVlNRT09ESm1PQVYvSVBv?=
 =?utf-8?B?NnlYOGpNUEhETFBzcXFKYTh6M2NnODF6aVQyTG93ZDNJcWhJRGdLQjd0YnM5?=
 =?utf-8?B?MzJ0SUMzRzlFY0lMbUVHeU5teUJ5VzFEbjJKRjQ4cU1obHBQdk51OWdlczFx?=
 =?utf-8?B?dHd0QTRYSmJRc0RaT1QyREdoM1ovVjZIbXBwNmNhd0FvMDBLYWFVb24rdlov?=
 =?utf-8?B?TEFONXBOWmlpcjNhNUVhZnp6RllCVVBqNkNlUnR1UDl1Zy9Dd0k2VmJhQW8r?=
 =?utf-8?B?bHRKK1ZkWDc0MmFQaWtoYngzdXlsYmRBTmFiYVhDNEsrTHliRUpsdXhtMEZU?=
 =?utf-8?B?SFBIcFZJcStrY3l5My9TNm9oN0p1K3NlcERDVEp0SjQ3UDY0bmx6b3RwY2ds?=
 =?utf-8?B?NGNHMktibndSSTZ4UVh3OEhIays2bE1YWEpqMUJ4M3NvekVrbHM4b0huTWNs?=
 =?utf-8?Q?qReIxGI2aI1Fhitl5v3podaxfm8RkmC1u2Pfc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 03:33:02.8301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d55723-4268-4741-21b7-08dc76220ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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

This commit removes a duplicate check for *is_queue_unmap in the
sdma_v7_0_ring_set_wptr function. The check at line 171 was considered
dead code because at this point in the code, we already know that
*is_queue_unmap is false due to the check at line 161.

By removing this unnecessary check, improves the readability of the code

Fixes the below:
	drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c:171 sdma_v7_0_ring_set_wptr()
	warn: duplicate check '*is_queue_unmap' (previous on line 161)

drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
    140 static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
    141 {
    142         struct amdgpu_device *adev = ring->adev;
    143         uint32_t *wptr_saved;
    144         uint32_t *is_queue_unmap;
    145         uint64_t aggregated_db_index;
    146         uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
    147
    148         DRM_DEBUG("Setting write pointer\n");
    149
    150         if (ring->is_mes_queue) {
    151                 wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
    152                 is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
                        ^^^^^^^^^^^^^^^^ Set here

    153                                               sizeof(uint32_t));
    154                 aggregated_db_index =
    155                         amdgpu_mes_get_aggregated_doorbell_index(adev,
    156                                                          ring->hw_prio);
    157
    158                 atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
    159                              ring->wptr << 2);
    160                 *wptr_saved = ring->wptr << 2;
    161                 if (*is_queue_unmap) {
                            ^^^^^^^^^^^^^^^ Checked here

    162                         WDOORBELL64(aggregated_db_index, ring->wptr << 2);
    163                         DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
    164                                         ring->doorbell_index, ring->wptr << 2);
    165                         WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
    166                 } else {
    167                         DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
    168                                         ring->doorbell_index, ring->wptr << 2);
    169                         WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
    170
--> 171                         if (*is_queue_unmap)
                                    ^^^^^^^^^^^^^^^ This is dead code.  We know it's false.

    172                                 WDOORBELL64(aggregated_db_index,
    173                                             ring->wptr << 2);
    174                 }
    175         } else {
    176                 if (ring->use_doorbell) {
    177                         DRM_DEBUG("Using doorbell -- "
    178                                   "wptr_offs == 0x%08x "

Fixes: 6d9c711786e6 ("drm/amdgpu: Add sdma v7_0 ip block support (v7)")
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 4a5252e08883..ab1dea77be6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -167,10 +167,6 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
 			DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 					ring->doorbell_index, ring->wptr << 2);
 			WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
-
-			if (*is_queue_unmap)
-				WDOORBELL64(aggregated_db_index,
-					    ring->wptr << 2);
 		}
 	} else {
 		if (ring->use_doorbell) {
-- 
2.34.1

