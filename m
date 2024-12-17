Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC42EE7716A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 09:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6406610E8B9;
	Tue, 17 Dec 2024 09:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cPXyijdV";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C8710E8B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 09:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRVL60YlQOh/zUspAeDdcNZDUxQU8NsR/WwHAAbX+XWijFLmWthHQfC6LpvPmIsrFD6Kc2A4jOJSunIFkecdIaJXB3Cpv+Cv/WDGdrSjLXUk49JeRGN0BS1UI13QvwKZtm5XMRkMa7EN66jQlne7B3LXmXCSgqNLMKa3/MeR+T92tBDAmLO5g2tJWItTnPwXV4avqldAlB5Z3r6YT9F1d7j0p/4gCaOs4atmlQu5x2M+Mpa+ZmOvxtlxavxX60LBLiyjtlkTXg6rjKDjBszGEv3tcNJR6PUBFJtogzRvFJ7QaJlNLpPD6TTCPX/Z2dZ9flmmf8dmEX/CBTMyD6K9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34+bd44Y6AiYk6X2I8q9MRZySJ2FYA071sTU6Pef8KY=;
 b=Gg3uTpkJu8nbFg0TSb83QSU3ppQO+HHflMt0igdPBmKyWLzE2+BkuwE0pOv5RXWPj3YfFL4J6XCoWWyv192l13RbL4Q9v90kHHSQpsfC8hKJvn0+pG475550nSUadFCYfoXbGPGR48KtWc8AvK2xFpSmaxgTQFU7NjcCpoYY3VDGnbQW0UNleT1G8SFnV0nLYaz00oIMWkspXnIKSLNW93y0GZw4lzB99Lxp2PIoZeMNpKofSeurEDQ9b/AWLYaHZAnQ424V0Y50LOtkPWQ6fTaPBrqqJwYSkrWQ8hmMdkGsn80WH28qzYnvKfU6lIkAYC3GZzEoiEWVMxKQGymh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34+bd44Y6AiYk6X2I8q9MRZySJ2FYA071sTU6Pef8KY=;
 b=cPXyijdVsafGUFsJuAfXRjlahHwaavIyzOCQdjIZRjO1xjrU3uen8aFh8AvIisEjYp/LVWf0wN+u0JPuFHUD7vXy8jtFiNcMrCQSHR5hwhdU/g2qiGq9TymZUNc8CogxSQqoqVBlJ6HdlDUkoDaNoVGlkMbQ/B36w5l4hGXwT7s=
Received: from SJ0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:a03:3a1::24)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 09:39:19 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::d3) by SJ0PR03CA0379.outlook.office365.com
 (2603:10b6:a03:3a1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 09:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 17 Dec 2024 09:39:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Dec 2024 03:39:16 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, YiPeng Chai <yipeng.chai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 "Tao Zhou" <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix error handling in amdgpu_ras_add_bad_pages
Date: Tue, 17 Dec 2024 15:08:58 +0530
Message-ID: <20241217093858.2867451-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213121019.1385312-1-srinivasan.shanmugam@amd.com>
References: <20241213121019.1385312-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 476bacf3-022f-4ac4-2cc0-08dd1e7eae2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHpVWkVFSGlEWVdSRlR3TFYxQi9DZG1DREJ5elkzR2p1K0tMeXczZWxRYkdY?=
 =?utf-8?B?dzh5NjJZZFRjTEpLMzdxVS9SLzhsb2xmYUFqYUxnTTEyRmxEVkIyOWc0cjBI?=
 =?utf-8?B?Z1luOUFiK0NpNlp3QThpT2ZHWVd2bHpCekxuYS9Gdm4xR2s1d0NSdzM3Z1Ri?=
 =?utf-8?B?ZzVMMUVUemRrbTF0NWZvYjZZSkFNSWVmcnNLRW5YSWxpTlVhRnZqcnQxdGho?=
 =?utf-8?B?eS90eEdsMnFJczlTSVVydmlURlVaamdGNTd5QU84WE91cFg1K1hVbE02dHN4?=
 =?utf-8?B?RGo5dXNWVUpkdFdBOGRxMWlNb0pXQlNOMWtmbG5TZUtpRmFWMUV3NnZRNi9h?=
 =?utf-8?B?L291N1ZvcWFDQnVDOGMwV21GUnE0cG14bFoxYjlBNTZRUEhsZzdydUdjem1m?=
 =?utf-8?B?bFZpdDRTL2RML0dBVG1PcXZ1RlY4S1dzdHQ5Zm9mTGlpY0kzRytkdDB6RHg4?=
 =?utf-8?B?YnFJQVVwMGdwNi9lL0dqREdzNEJyUTdmMTNSZDg1MHIvMHRZMktuY2RhRHcz?=
 =?utf-8?B?ZmhoRW9iay9WQTBIUVhMTXBudmUybHJCWnVIYm44UmJhWHVvVHZWUE5pVVoz?=
 =?utf-8?B?M3pGSE5JczVxcThBTDVmNlBTUG1tVjltZlFEc0dBRlU3TzZaSm95RldteVZL?=
 =?utf-8?B?NTQ1T0htVlB4VGdMVTNXUUh4bjcyLzZ6c3pkTHg4dkgrancvd1pJTWUxY3pF?=
 =?utf-8?B?c3VGZGJ5STJGSEtvOFFVRklqWFhpN1lLek13aHVBL1BFTm1FVXlwTS8wcm50?=
 =?utf-8?B?UXordmNtN01zT1lES3J0aSt3WWpSNnhCRHFhdDc5cTNOUitCc1hVVkNEUkdK?=
 =?utf-8?B?TlRna0IwdmF2WjlqVnhkVUlEV2FmeXVJOUh0emJPWTI5d3F5clgzQTZvbzQy?=
 =?utf-8?B?Ym4zS1VSaVpPTUl2WnpYNGtoMmJnRHpYMUVueXBzTGJucnZBTlA3T1dRUDk1?=
 =?utf-8?B?ekNjYXF0ckZ5b0M5dDB2UlhSTWJxN09YT1d4OWJZc0pPdmErMnIzQityTTVo?=
 =?utf-8?B?Rm1EdWliNzJldHhMbU85cVJTbkRtc2hlUUhGUFBOdi93VzZYeEpGcyswdFhn?=
 =?utf-8?B?Nnd2V25TWHNENmJJR1labjFteUJCUFBoVEN0VXFRaWMxQnZYTWNsdHRZNEcr?=
 =?utf-8?B?VUMyOGltYXdkQUxVSWt4d3FIbWdLRDU3SVpFcEtiamZodDVEekE1UWk1SWxt?=
 =?utf-8?B?eWMyTlovUVhPRE50RENLZmRiOWwwN0pIYXpHMk1mWE55bkNBeGpYQ05LeVIr?=
 =?utf-8?B?aFFEaVNDcDJKcEJZaGpIWXpwNVFSeStYZFRqbW9MV1pCN2IwYkVEZ2JTRTlk?=
 =?utf-8?B?cFEwaEs0WWhGd3pXMjUzK0NzUG1SK3NXU1BVbGY5citySGxZUDVZdG5RdXIy?=
 =?utf-8?B?KzBEeHVtTGpOejhGQit5WHpYYk5hVVlPalFraWJDa2llcW1kYWtkN0J0ckQr?=
 =?utf-8?B?dWZQTzdBdlMyWktoVFlJZmtJQWRSUFcySDRXSjlYd3JoUUJ0akVIOUQ5eUpD?=
 =?utf-8?B?cXZ6VFVvRUo4UmZDOUFDQUk2S3NLc0tnK0NYQXBEandweG9xYVMzbHpvNGVs?=
 =?utf-8?B?N2FyZDcyUG9wMEhseXRpY1MzN0tXUjE2RXVUU2F3WlJnTkdoTmFaTnVLL3NJ?=
 =?utf-8?B?SWlhZ2U0L0tMUHptQWJja2lBM1IwR1NVUkJsazlEZGhzRkc3RjlFOXl3V1pT?=
 =?utf-8?B?dlgvdmg1dHQzbnpKTUlZVWZqQzUxQjN2SHNQdFVBaVloSDFWZFZJM1ByMkNs?=
 =?utf-8?B?MGR5MkN6WVZtcVV2bkxXQVNNbTZwWDI1Nm5PMTJLaXR3TEl3LzJieE1lQmdI?=
 =?utf-8?B?Y28rUzdsbTBjb2VESlV4YVFhRGlSa2Z3cTIwVWs0dVllL3BSczhkM3c3QWQr?=
 =?utf-8?B?K0NXOXJCS0ptWFlsTEEyOGluZ3JMd0pHc1VZeHUwTGdQcHQxT3hCanVFNEFn?=
 =?utf-8?B?dFQrU09EazM4M1dJNDNpMzRnaWp1cGozRGphRG02UHNHa3lRdndyTU9nQjdB?=
 =?utf-8?Q?9rVSRHk3icEbaDz2PyIAOoOm87OcjE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:39:19.1537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476bacf3-022f-4ac4-2cc0-08dd1e7eae2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
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

It ensures that appropriate error codes are returned when an error
condition is detected

Fixes the below;
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2849 amdgpu_ras_add_bad_pages() warn: missing error code here? 'amdgpu_umc_pages_in_a_row()' failed.
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2884 amdgpu_ras_add_bad_pages() warn: missing error code here? 'amdgpu_ras_mca2pa()' failed.

Fixes: 9fe61c21405a ("drm/amdgpu: parse legacy RAS bad page mixed with new data in various NPS modes")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: YiPeng Chai <yipeng.chai@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - s/-EIO/-EINVAL, retained the use of -EINVAL from
   amdgpu_umc_pages_in_a_row & and amdgpu_ras_mca2pa_by_idx, when the
   RAS context is not initialized or the convert_ras_err_addr function is
   unavailable. (Thomas)

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 01c947066a2e..f1371d1f8421 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2832,8 +2832,10 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 	mutex_lock(&con->recovery_lock);
 	data = con->eh_data;
-	if (!data)
+	if (!data) {
+		ret = -EINVAL;
 		goto free;
+	}
 
 	for (i = 0; i < pages; i++) {
 		if (from_rom &&
@@ -2845,26 +2847,34 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 						 * one row
 						 */
 						if (amdgpu_umc_pages_in_a_row(adev, &err_data,
-								bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+									      bps[i].retired_page <<
+									      AMDGPU_GPU_PAGE_SHIFT)) {
+							ret = -EINVAL;
 							goto free;
-						else
+						} else {
 							find_pages_per_pa = true;
+						}
 					} else {
 						/* unsupported cases */
+						ret = -EOPNOTSUPP;
 						goto free;
 					}
 				}
 			} else {
 				if (amdgpu_umc_pages_in_a_row(adev, &err_data,
-						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
+					ret = -EINVAL;
 					goto free;
+				}
 			}
 		} else {
 			if (from_rom && !find_pages_per_pa) {
 				if (bps[i].retired_page & UMC_CHANNEL_IDX_V2) {
 					/* bad page in any NPS mode in eeprom */
-					if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data))
+					if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data)) {
+						ret = -EINVAL;
 						goto free;
+					}
 				} else {
 					/* legacy bad page in eeprom, generated only in
 					 * NPS1 mode
@@ -2881,6 +2891,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 							/* non-nps1 mode, old RAS TA
 							 * can't support it
 							 */
+							ret = -EOPNOTSUPP;
 							goto free;
 						}
 					}
-- 
2.34.1

