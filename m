Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBC1C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 07:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF74810E7A5;
	Thu, 15 May 2025 07:50:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U+TnW0Bj";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842A310E7A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 07:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvproJPukCP/MxJdVaD/HgHHb3FY9iwBQYsA+YPwxc+qXOMqGQQ9D7mGguAAZWsNEIIofuBsJ1KKIG9asmvomKjmaMI0ZOBXCSPQT57bUV13aU7x4bKAfLD0opG7ZNRAEAzKYmK9ih7jwXG5qi6cdNHZteB/Hyz0D4cLmYJn9f4vfB0NM1tw6DmuqzzR5amLKO6GcS7QEqC2xdwrbSDSeulYaqeZ2FZSX/Vddy3zAgr18cWu9obBow+GP2CXYneFgznopMzotLDmIVbIu3OHO8l2FCVvFfC0f8xTrv02DvdZq1wNdKYqAFLAG6L0Vhm+qotPmIr1wU0ZFrHtFStTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NBdR43K5NSOKwfLSAp/GNxU7sSo6BUc+zyJbi1ux7E=;
 b=VY1WorjJMgX1ffuYD5wrWOVGSuxtVgaAb4Tdty3bkisnFaDwDauDTyjShW6QiwPwolps8BlG5aipZfXjMHfQfeXwEd9SOBEXVqXc3nipCYVARq2OQ+s4Blbtdn/ad8y5OxB0pqDt2Z+c5+FgckGA4qkBcczfao0oExe6gtShXk6zlurElS30P0Pu8x0oILjyVOMhIz/aU7wOecvb+OQWT3XB83I5CjTEgQ1VWJhdMLrZeUMujkfisZ2CH0VF9x0PwuLO6RF29Z0v4wUyXVi8G6x8ZPEowO5o4lpVybyONO86B1/FUl9wdfq3sIdoeIVDOBgav5IZXlcgiVngqhANPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NBdR43K5NSOKwfLSAp/GNxU7sSo6BUc+zyJbi1ux7E=;
 b=U+TnW0BjLzvt8hqNx0qswj1JUVNpMLweaZ2PHhSBP/q66XH8S6bPyGAh5eGMXRytwnkfxXOPZMhS6JZHeJ+2nY63eO6D/cZ7dUpCzWTloySKQAKGwbTDOsNnIBoZ1om72kDtVvaEERJhmUjLewiS/SXO28XZMxP8WHhux5JuMj4=
Received: from SA0PR11CA0077.namprd11.prod.outlook.com (2603:10b6:806:d2::22)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 07:50:27 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::ba) by SA0PR11CA0077.outlook.office365.com
 (2603:10b6:806:d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 15 May 2025 07:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 07:50:26 +0000
Received: from rtg-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 May
 2025 02:50:15 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix use-after-unlock in eviction fence destroy
Date: Thu, 15 May 2025 13:19:57 +0530
Message-ID: <20250515074957.2830-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: a39d38ed-4ac7-4e76-14fb-08dd9385281a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDk1aWg5dVZRV20rWjVHaU9hbjgrSXVNTW1EZnRTZEdqZ2JJeEFlYSsydjRC?=
 =?utf-8?B?YU9KZHRyZkJSd0xYYU9tOFpjSzh4UWx5VVRHU0lPN0lMSzBUVE1QSGJKT3kr?=
 =?utf-8?B?WXVJeWRYOWZCRG9Za3hZVEVVZDNtYjRGakFnZ0ZPRkFGQUNYNzUzeFpIYS9K?=
 =?utf-8?B?b3lydEdFZld6NVBmNVRtaFFIbjJaMW9TNTR5a2Z3WHozZTNrMGpLNmh1NDgx?=
 =?utf-8?B?Uk9lVTZGR0pJQXVzcXU0aHlpbGVReFBzaVVyWGh0VnRNVnFXYUw0eUFqeDQv?=
 =?utf-8?B?UTJ6bFhrUlRERnhtbzFTc0dBTWR5blU0alIyL0JUSnROZDhoa3dQRCtFODlD?=
 =?utf-8?B?cVd3V2JsWm13RzZtOHhlUXh5ZGhydDJjUjUwR1ZRTEVDSlkxaks1enJvQjQ0?=
 =?utf-8?B?cVIrWVRscEpOOGpWaWE3RzN4UjVnT0tPSS80VjNnVXBFdno5MGlKMWdLSUNN?=
 =?utf-8?B?ZnZzaU5mZVNleGlydWN2OVYyU240UVAyei9KQUYza0RNL0JDUXUwYkErM2dF?=
 =?utf-8?B?cUdPWEMwcmhtdVo1T1FlWG5RUngwaGo0bWJUcHdPeDVPQnRuSmt6eDRSVkJ1?=
 =?utf-8?B?NExNVUg5NVNoZS8zcDhBaUZnbUZ0SU4yeHF0QXJEcXI1T2EyeTU0S2xRalkw?=
 =?utf-8?B?YUFPREc5YmVXalNxaUR2QjlQenlUUHN0bWJIVGwrTHdyeEpIRE11WHRyLzJM?=
 =?utf-8?B?QUlHTURJbGhsWWtLVVdzeGE5d29VdElNRHZIZ0dNNDVLRVdEWCs4ZlRhYlVz?=
 =?utf-8?B?bUZndjFxeEFVZlpRb083QUtsL29Cay9CQUJ2bGxIbWJsMTNSeVBWdG5UU21O?=
 =?utf-8?B?NG1JcFRwQUNZOHdYcGRLNkUxQmtycGNVamRNVGlmbUpzUTFiR2ZXSmJQWWtW?=
 =?utf-8?B?SnZodHlMTVRLSHpVR2Y4bzV3V0JkeVNNMjFDNHBTdW81UUdqc0ovY3hUS1BI?=
 =?utf-8?B?ZDBOM251eUxtMTZCTkJHcjFmQ2JXTUFheGEvN1lwdUV6RzV5bDcwODlsMU1v?=
 =?utf-8?B?d24xc1JxQlJpcHAxSFpIZTV4a0I3TzY0VC9ZKytZZG1FTTl6bEcxaXpLMGlp?=
 =?utf-8?B?d0pTR28wOTdkR1lUa3FYSFZkTzFsVG5aUStJbGhoaW9IN0VDUE0vNmNxa2l3?=
 =?utf-8?B?QjJVYVRiUTcvY01sRzl0ckFjWDViWk5MeVl3d0ZPYlF4V2hyUE1LQzMvakwv?=
 =?utf-8?B?VzFSaEpJTEY3VVd5K2pSbWR4V08xVCtOTkxCZnpLZmsvblNvUkYvb0NUVnlG?=
 =?utf-8?B?Uk5qODByR1g3aUlRUzExdk5WbU5YQTF3UnFXR2xrYkhycDhqc2JZSlozM1Rn?=
 =?utf-8?B?T0pMZ0U5RDdXZCtxV1QyZWdNOTNVNGtEY0hDL2RkcnErSXh6ZmZmalJEWXVk?=
 =?utf-8?B?SFVHU2hMOTNJY3dXVmZqdmlKdXYrWWxqTWlodmxwdmQvOU9kLzA4TE1aK2pp?=
 =?utf-8?B?K3A1NTZ1NGVsckVSNDlPV0NHbUlzVjhPb2dEWHg1cEE3c2tUajZZWjgwVEFX?=
 =?utf-8?B?bG50R0xnWFpoaCtndm9Sc1R2TjhQTlJuSzZBYlN1eUhPdXJweWZuSGU2Y3dx?=
 =?utf-8?B?VGZGUmZJZ0ZzbHlpS2hmb0ZRQURJMXkxd2lrbU5helNiSWxoYkJBVkNVTjN4?=
 =?utf-8?B?aERjV0dYdGJnalo3Z2lHUEplYXFYc1FHMFk0eFJSTXZxamVMNHRWUTJuMVZY?=
 =?utf-8?B?ZUFoeUc0SnBRdmxMbHRyM0ZyWVYvUGNvMVh5T3lGSGZDSEpVODAyT1Jrd2hY?=
 =?utf-8?B?cHd5S1lORTJidzRrM1B3UThtN0ExaUVtczI2cGhuV2ZkK0tmR0x1U3dvQmxC?=
 =?utf-8?B?ZFdCVFZRd0daLzRCZzFIMnliSTdFUUlKTGRvMDF3OVFaZ3FoUDM5TDhBbU9G?=
 =?utf-8?B?K002QkJTRWNsZ0wrdFhRb2FrcU5adUhOZ1dPTGd5RUdGdjdtL2ZyNVQ1RElB?=
 =?utf-8?B?TlN0Z1B0eVlGWXRkRkdJR20rQXR4UmJVa01ncnppRVVPVjVPZGFCWjNwS0dJ?=
 =?utf-8?B?VWZNSGF1WC9Tcnp0RVBldzd1ZjgxalZRdWExemJVOHNQWlBrNGdWQ0tMZ1NP?=
 =?utf-8?Q?+kbIoV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 07:50:26.8093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a39d38ed-4ac7-4e76-14fb-08dd9385281a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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

The eviction fence destroy path incorrectly calls dma_fence_put() on
evf_mgr->ev_fence after releasing the ev_fence_lock. This introduces a
potential use-after-unlock or race because another thread concurrently
modifies evf_mgr->ev_fence.

Fix this by grabbing a local reference to evf_mgr->ev_fence under the
lock and using that for dma_fence_put() after waiting.

Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 1a7469543db5..73b629b5f56f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -183,7 +183,7 @@ void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
 	dma_fence_wait(&ev_fence->base, false);
 
 	/* Last unref of ev_fence */
-	dma_fence_put(&evf_mgr->ev_fence->base);
+	dma_fence_put(&ev_fence->base);
 }
 
 int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
-- 
2.34.1

