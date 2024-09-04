Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7A5CD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 13:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9607110E077;
	Wed,  4 Sep 2024 13:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CsGtSs26";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F5310E077
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 13:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X62dMZAHGS882IXrZF09lHJYjiZPifj9rW1yrxtGnpbh8QWvd1hR4zgONo79lsRlTm9TV/kksdo/E1/D7JCUjPqAb4vbXPQWtPtRNs1hoITIL2Y1T0hPuOzPh2LoHD5zxizm0c3x31ivdvu1FHKUiF0dTo/SQSDIoDtwTBLywSd9KmkrDbygB81SB4duJMwvZR6k7E9mRxm7TzQVVufE/kxQ63tDv1s6ovO3SVB2cAxLsH9yjSM+uIjZQgJKw9/dc1KdbaMYiP2x9IH2KCLbowxoEgp80lLG4ou3VmfqLeR4s7wCfyyxiYDv9FUP43rcdv6Fd3af9DMk4DOELCs6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYnaApZh0RpmRP7kTQCmXA2WIV9g6ONskPhZnjjHaFw=;
 b=Hw7ZkZuhUjXDVR1MABdIYwHALMiIH7Ei0bsJiKQ27fAPU2+W3ywzwAWTHcmkrcgvfELRnh98QLAUz6vQXHXCM2kepKxhcRnjIf4NmQLIMum+d357Ltq1jcpeSV2wa0LveDzdWr13SN3b0PLtcThNk64danPEXbjvWNI5apKZwTbFFWcugM8UI4M0QRfthuF5DtaBTy6kO2qTgHSZ1QorE3pxZiaWKhuD0w0BWV2SfoI41BjdTWaO5Z9A5im+m6aJV/OYDzYwayjfQekhOJLa+rvQ2OIWZrZ3ERrwtpLJ8Jfxo9QWCXKT3toUYCPUPAxj92Jh8F2jE6YPuUgOiUmv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYnaApZh0RpmRP7kTQCmXA2WIV9g6ONskPhZnjjHaFw=;
 b=CsGtSs26IneOBeXXaq3MXUsvOKiPp4o2OreMf3h45bkmJV6N1T5PxE2UwDazBccs3lb3PlP+sKlMdC8gsqgFEL960+41K4vAr3ZqD8r+YOQvdib5aLPjcIgy8ydauesAl2vxBRNWH2kwtfYrjaH4z5jXy8OdzUZBJUBtY2n+aag=
Received: from PH7P220CA0165.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::14)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 13:27:46 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:510:33b:cafe::7d) by PH7P220CA0165.outlook.office365.com
 (2603:10b6:510:33b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 13:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 13:27:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 08:27:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Refactor cleaner shader initialization in
 amdgpu
Date: Wed, 4 Sep 2024 18:57:27 +0530
Message-ID: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9aba8c-3798-49d4-d10a-08dccce55d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkR4eTQ1Wm5FVStvS3BmOVZyYnREMmpQSmM2dzFyY1lNU0wyMno2Sk9DN0Mw?=
 =?utf-8?B?WkFwcmE5ckd5SUxzTXFuMDc0N2F3WnBSNjM0MUtFcGo1T1k1SklRVWxsWlVk?=
 =?utf-8?B?TnliRi9BK283Ulg1dllZYWkvdFRVSEJhWnl5UFd4MnNWeVIvMDFNQm9BeGVo?=
 =?utf-8?B?U1dCVTF6YVpleW1QVkhEb2lUWkdZaXZrRnNubHVqejdLVHk5UkZBWC9TdDhu?=
 =?utf-8?B?aFYyamloaVpEYmlnNjMxOERCWVV4eDlKbFo4OTFuQWZHVmZXdU1Jak5EMHd5?=
 =?utf-8?B?SXdYWm9QKzVIWDI0NjVQUUZxc3NlYm41L1lheGRRQnpweU52cHc3ZGplTzdF?=
 =?utf-8?B?bGxmN1hMa295WER3TEJmbGZ6RTJVdU5mNWpSSmxYVTZ4UGFpeEZyekVtSXdQ?=
 =?utf-8?B?bGxuakxIbWpWTjRGc0NuL0pha25CNXAyaGUwbnNsSVJEYzN5enhoem9RbjBM?=
 =?utf-8?B?L2VEdVpMbVpySjRxRHFTZS9tQ3NuUm9ZQ2M4QzBYbVFoL3JWNnlNbG4zZi9r?=
 =?utf-8?B?cHk0MDl5clhnMGpXOGk0U2dRQ2dMOGE1d1cvRlUwbG03a0J1N0lPeFJxUUxk?=
 =?utf-8?B?S2VvU2NEL2pPbDJya040LzZKUHJhakw2ZUt0S1ZjVmtmZ0huM0pmcXZCOHFi?=
 =?utf-8?B?WEphQkJ5VDdyM0phbnRLQmd4MU1iYXFTUEtXbW93NlhiNUkxWnpIZ25oV1M4?=
 =?utf-8?B?NmMxaWQ0UDYrWHNvUkxoa1NGemZkU0N1d2VlaXdZVC9uTlp6TytIaUhXTzFw?=
 =?utf-8?B?WUxwRlB2YksyOGJvUXJHU3BzTDFockI5MDhyaDNJZjhMdElLSXdEaExwNjcx?=
 =?utf-8?B?MmRZM0RVVm5ZamFobWpiNU5QWnJpaTl0YTJxYi9QbTk3eS9WKyt6NHl6NlVa?=
 =?utf-8?B?NjU4L2xWcVZIa3pJa1kvbnJJNkN4bjNmSTB1ZVZPOE1xRHZYK0ljb3gxMEcy?=
 =?utf-8?B?c2hjOWFBOEpNZmxScWd3NUlkQ3lLdGc4djFzRXRwQTJnYzNzRythWFhOMUtV?=
 =?utf-8?B?WVpvUDVmbW8zYmZSemI0WDRzMGZuanRsamhSTDV2bTVUZnNESCs3TzRUNXZF?=
 =?utf-8?B?Ly8vS2YydzhnaFVCbDJDRnA0STFkUXUySVlNWnRZN1l3Qkl0MG5DRmo2bWpZ?=
 =?utf-8?B?em5Fd3MrYUp4UUVqU2RXbG50bzY1QmY3MDVKQXZBVEVWakJ0OGhydFlZVnZv?=
 =?utf-8?B?LzUyV0l3c3NhN1dpQWFjNTNWOFRRdFo4MHI0ZDhuU0tHWE9VOHpBRW90MDJM?=
 =?utf-8?B?M3grTXJ3RkdUVjRZTytKbW9UcitMS1dsTUZRMWF4YnUxL0F0dXZmYVRlcHRV?=
 =?utf-8?B?dGpza2hiWXZwTWYvUjcyVHNJbHFDek5NakZ1OVJVWFhEZVN3WFd5ZVZia3VF?=
 =?utf-8?B?Q0VrektzMXJ0QnVuYmpYQUJ5UEh2THR5ZmluR0w3Z2RTcGJSUGlvV1M3SGVI?=
 =?utf-8?B?bGhEbzlRQ3oxTis4dm1hUFRFYnVPREJNQkxSSWUzS3RJRXdsRTRJNHZHWldx?=
 =?utf-8?B?RXJYc2h2L1dIa08wT1ViS1JTN25SR2Z6aVVtYTRuN040M3dvU3BzdGxveWpo?=
 =?utf-8?B?d0lTN0tyU1F2cXZROGNhbjNUVnI4S1NVL2hucDZLaThQVWZ2SnJqc0VQSWVX?=
 =?utf-8?B?bkJCR0NFMW91WFhBN0FhRnRvNUJHai9iTHBpSzBpTTNJcEszOGwrNnF3SGN6?=
 =?utf-8?B?T1dIRXlHejBWOEZkVDVkMFBLRW9XeEk3eXdJY0VNSW9NVXJ3eGFCWE1EaFpP?=
 =?utf-8?B?S0ZENkMvWHlsdkN6ejBPUkdRdkpjSllaNXFhNVBCRENOK1RkaG9Gei9La0Rz?=
 =?utf-8?B?Zjl6dEdtMTkwYkEvaGJnUVQxdWh2MjBNK295MU55aGQrTmIrQVIydTVScy9D?=
 =?utf-8?B?aitGZGhWc3VuRjVHQzYzWHNMbGFaL1lRTjhlMEpPdFNFaEZINk9UQWxsa3B1?=
 =?utf-8?Q?OBXajP8+ZoFV2GejrfzxjEDDXKJ9zZ+p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:27:46.1106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9aba8c-3798-49d4-d10a-08dccce55d30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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

This commit refactors the cleaner shader initialization process. The
changes remove unnecessary checks for adev->gfx.enable_cleaner_shader in
the amdgpu_gfx_cleaner_shader_sw_init,
amdgpu_gfx_cleaner_shader_sw_fini, and amdgpu_gfx_cleaner_shader_init
functions. These checks are now performed before these functions are
called, which simplifies the functions and makes the control flow of the
program clearer.

Additionally, the cleaner_shader_size and cleaner_shader_ptr parameters
have been removed from the amdgpu_gfx_cleaner_shader_sw_init and
amdgpu_gfx_cleaner_shader_init functions. These values are now obtained
directly from the adev->gfx structure inside the functions.

Fixes: 63063b6c5a8d ("drm/amdgpu: Add infrastructure for Cleaner Shader feature")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  7 ++-----
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 83e54697f0ee..9891114ae6d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1655,13 +1655,10 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
 	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
 }
 
-int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
-				      unsigned int cleaner_shader_size)
+int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev)
 {
-	if (!adev->gfx.enable_cleaner_shader)
-		return -EOPNOTSUPP;
 
-	return amdgpu_bo_create_kernel(adev, cleaner_shader_size, PAGE_SIZE,
+	return amdgpu_bo_create_kernel(adev, adev->gfx.cleaner_shader_size, PAGE_SIZE,
 				       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT,
 				       &adev->gfx.cleaner_shader_obj,
 				       &adev->gfx.cleaner_shader_gpu_addr,
@@ -1670,24 +1667,18 @@ int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
 
 void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev)
 {
-	if (!adev->gfx.enable_cleaner_shader)
-		return;
 
 	amdgpu_bo_free_kernel(&adev->gfx.cleaner_shader_obj,
 			      &adev->gfx.cleaner_shader_gpu_addr,
 			      (void **)&adev->gfx.cleaner_shader_cpu_ptr);
 }
 
-void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
-				    unsigned int cleaner_shader_size,
-				    const void *cleaner_shader_ptr)
+void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev)
 {
-	if (!adev->gfx.enable_cleaner_shader)
-		return;
 
-	if (adev->gfx.cleaner_shader_cpu_ptr && cleaner_shader_ptr)
-		memcpy_toio(adev->gfx.cleaner_shader_cpu_ptr, cleaner_shader_ptr,
-			    cleaner_shader_size);
+	if (adev->gfx.cleaner_shader_cpu_ptr && adev->gfx.cleaner_shader_ptr)
+		memcpy_toio(adev->gfx.cleaner_shader_cpu_ptr, adev->gfx.cleaner_shader_ptr,
+			    adev->gfx.cleaner_shader_size);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5644e10a86a9..07bd27c066c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -573,12 +573,9 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
 		void *ras_error_status,
 		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
 				int xcc_id));
-int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
-				      unsigned int cleaner_shader_size);
+int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev);
 void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
-void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
-				    unsigned int cleaner_shader_size,
-				    const void *cleaner_shader_ptr);
+void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev);
 int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
 void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
-- 
2.34.1

