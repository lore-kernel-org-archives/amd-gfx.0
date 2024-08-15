Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70D7C531DD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F9310E322;
	Thu, 15 Aug 2024 00:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VMX9112M";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5153010E322
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXMycpnkvm3oi4NaJmuyjZg6MQLRFvJRaNyKs1qj6d1pfo/y7GYzgLcioNebZo+xNxAMJTS0hcXvGJ7QiG0A+ft0FpOX3jUE621hRscChOSjreTllSEGpiQ6ilsxHwk9kImnn58Ktc3U8a75CNVBw8iqfo1sSDSNQZdCbPdyWnHeM9wsw2JL5CCktrt0LID0p53EP5srA4liyZfYn1UK8Sg6QocrYV14QHbo+VgXEZIr6QoOdaVZUKw4wn6C2NFJX+ONwCL+FlPdETMIXxlP18JmG+YnikotFGpjhMmzTtcqHjzVNrrWFxlPzUNeTnK22+uBsOQ19nXroanSS9b51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cK06XYXZmkW3MJLs0jdlvW6TQDf9/im31WPzESs85aQ=;
 b=lB6Z8JcLV21FgTDFPUJgyOONjy2THheb8bzepExMPzSD5KpF8bygJ9dZ4HnYPpfkeyXRjhLraT3zP0Oc3bUG2rQjcrn+DwOsBS6zQrvpxWdoEsVE5ytrg0UVdLZu0uXl5eRRlCxZR4m9Fx5q4SaFiL5hl4BaHPdCPsgnwI1DQ5zngQYSwWfmsLsQVQO2sqSuJouOu4GAHTJHtap583bpIV/3E4SBKlBWaHyllL0vzyQkHrqBM1Z264/CSThWOQjw1/NhAOzfyMK2nr175NV40Gezw0LIrFG5XFAcVkE+GQNyScN2ilOemNXRWW4yRER+2JX3Xte45bftuCodleWtew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK06XYXZmkW3MJLs0jdlvW6TQDf9/im31WPzESs85aQ=;
 b=VMX9112MEbdZiIOTHcFrfizaKqSV6hKaDBREqRuiF6hwYCx8/8kP2z69c+sPmXpfUQG/3rf0EtCh0Stn1G4iDUh7XwrmM9cvZxycm+y5KfYIKdO8kioUXwq+ICIt+XT2wR5rWuLoTdr2cMAw6UNgC20PjGrUwPhWxnDBcTCN/hY=
Received: from BL0PR0102CA0001.prod.exchangelabs.com (2603:10b6:207:18::14) by
 DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.15; Thu, 15 Aug 2024 00:05:19 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::ee) by BL0PR0102CA0001.outlook.office365.com
 (2603:10b6:207:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 02/17] drm/amdgpu: Add infrastructure for Cleaner Shader
 feature
Date: Wed, 14 Aug 2024 20:04:46 -0400
Message-ID: <20240815000501.1845226-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: d667aeae-38d9-410f-efaa-08dcbcbdf339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXRvWm1rQldqZnhnSzNOR3VtWWIwQW5UWU16UzV0SWt0WGpHT3hONU00S0ly?=
 =?utf-8?B?NitUeDFmbi9CcFU1MjVyNFFBTmtsSklZZWlPYktaaEdjTnRnbEFCWnRrMDJZ?=
 =?utf-8?B?dVA5NnBFTERmWHBQbDNJajNUL0FJeEhvUVc5MmZhY0VLRG5NSDgwSnpuS1N4?=
 =?utf-8?B?cmRCb3I3ZVVUTzhqNFUxTEVMTjEzTnpIWmlBTGR6VHExTXAxWjBtcW1GMVZ1?=
 =?utf-8?B?djhOTTluWG05NUEyRVA1YUEzRmJJblJUOWphc1FERCtIR3poVjhtT05OK2lo?=
 =?utf-8?B?ekN2VXIzTytPWFA3eVNOZ1VtdnQ2cEoxeW94Z0JFbHAwOHlPckp6c2t0TGZy?=
 =?utf-8?B?cTg5YWpFWVk0MjNWY3NsQWxBMkY0eTFBZUtDVGZQRTBSU0wzRlN0RG14Y0Vp?=
 =?utf-8?B?QUtSN1U2M2JGNHErM2JYVnY3YU8rcU5ST1RoK3VTc2FIL1pLVW85bkYxcVJ0?=
 =?utf-8?B?ZHV3cG9ha056WFFiWlppRzhjay82RHhyaUU2aWQrdFM2Y25kT3pNYWg2Q3Yr?=
 =?utf-8?B?ckN6YWxObDFhYTljR2RPZ1hiWkNxajdBM3QxditmNmNFZU5SNzR3VEFZV3VQ?=
 =?utf-8?B?OTRuVDhsdHROekIwMEorMnphMHdWN0NCQWJQczZlY01zNmRvM0lGWnNaNUE3?=
 =?utf-8?B?dkpTRnFNVDlXZzBaay9lNlRVOWxZbmZ5NG5zT21WblBSb1haNnZ2azAxMkVj?=
 =?utf-8?B?WnZXY09sVXR3RkprUUNCajZxTjFFNGc3QVJQZVlDRjVUTVpQSFRsdEZiTW5S?=
 =?utf-8?B?dStaWVVmREZVRE9INzBEOHZ6MjRvbWl1cWVBd3ZUb1VuT3hucWRjblBQdG94?=
 =?utf-8?B?UzR5Y0c3MEtkNGdKcysvWUxiZE1oZ3NuWTVEZTFQM3BHZWNOYm9zY2hPV1d4?=
 =?utf-8?B?d0pCN0s5U00xM2RJNzhENTY1SnU2K1NMRWYwQzBlMlM1R3RLYVRybU9yK0gx?=
 =?utf-8?B?SExiS1dqaXNkOC9jVnlPaE1xM3NOd0w5RGN5WSsvQmY3dXVzblFQZkpXMlVw?=
 =?utf-8?B?YzdPVTEzbityNkdtNEZBZC82NVlHK1cxZk5sM3VGYTJFNFE5QmpBK1pYd3lD?=
 =?utf-8?B?SnExYzVoZ0k0eUZRSDJ1c2VLYVhENEttK2pCdU45NGFxeTl6cHI4MkY1UHFq?=
 =?utf-8?B?SHV0NEFIRWNudGpWRWJVWElONUdIbFd3blJmK3B2a1JTa3RDblF3RFR0WWJJ?=
 =?utf-8?B?M3p0MXRxK3JER0NkZVlCRHZsTjBOODh1ODVlanVSbzQrbC9XZ2djbzVRSjNR?=
 =?utf-8?B?djZyanVuQkVOM1FLRnVQYVIxY3ZYYWhyemhzVVNkZmRWQ2hyYkw2UGx4d0Nu?=
 =?utf-8?B?SHcwT1U2a1NCQU5EWHBJMjUwaDBxUzhmS0NSRHlXUzdBenRSZHdZUjdVWHZ3?=
 =?utf-8?B?OXRNbmNyWHFONjJxN3JsNmxVOFF2U1A5b3Q5b083VjF0OHRsUGIxR0JPNVFs?=
 =?utf-8?B?OEU1c29QT0YzQlFnZ2o0WTBpc2MwRlVkbmJIdHBrVXUvRlRYbDZDNitiZDFx?=
 =?utf-8?B?QlNOYnRJOHZNR2htMUE5ejNIb3BNZ0lzL0tQRjhyMDVsS1RZTWJYMHgzMlRi?=
 =?utf-8?B?VGlSdWNWSkt6SUo5cUFHdVlxZC9QbXdZZDh4Z1J1bHhQRGkxVlEwS2FWelk2?=
 =?utf-8?B?YVMrTlVneDNBVWM1ekdkbHhkaThCK0g4bW9wdUVqVVZxUVdneEM3MjQ0eTlN?=
 =?utf-8?B?S1dBZXNRUXdrSnUwaEVxVWRabmMwRnVlN0x5NVV4V1l3TmxPcE9kOUZEWGNn?=
 =?utf-8?B?M1lqNEFzdndBbldLMlh3QjJWNDhZVTVzWDJ0bEs2UldwaTJDbTUwTDFDUVRk?=
 =?utf-8?B?aFdSRVlGd3ozRzF5bXhRVXNXdG9VL00ybzJyMlRlQm9IaU52TThzaDF6L2Fl?=
 =?utf-8?B?WHdnYlB6RDBtUW16ZDFvZlUzMHZBZ2JTOVl3YlRWM1gyanNGUDdvendaTGJH?=
 =?utf-8?Q?rcAMrHW6fiMPaRUQZZkM0LIY7TralDQk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:19.4643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d667aeae-38d9-410f-efaa-08dcbcbdf339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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

The cleaner shader is used by the CP firmware to clean LDS and GPRs
between processes on the CUs.

This adds an internal API for GFX IP code to allocate and initialize the
cleaner shader.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 35 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 14 ++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9be8cafdcecc..4ed69fcfe9c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1416,3 +1416,38 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
 	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
 }
+
+int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
+				      unsigned int cleaner_shader_size)
+{
+	if (!adev->gfx.enable_cleaner_shader)
+		return -EOPNOTSUPP;
+
+	return amdgpu_bo_create_kernel(adev, cleaner_shader_size, PAGE_SIZE,
+				       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT,
+				       &adev->gfx.cleaner_shader_obj,
+				       &adev->gfx.cleaner_shader_gpu_addr,
+				       (void **)&adev->gfx.cleaner_shader_cpu_ptr);
+}
+
+void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev)
+{
+	if (!adev->gfx.enable_cleaner_shader)
+		return;
+
+	amdgpu_bo_free_kernel(&adev->gfx.cleaner_shader_obj,
+			      &adev->gfx.cleaner_shader_gpu_addr,
+			      (void **)&adev->gfx.cleaner_shader_cpu_ptr);
+}
+
+void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
+				    unsigned int cleaner_shader_size,
+				    const void *cleaner_shader_ptr)
+{
+	if (!adev->gfx.enable_cleaner_shader)
+		return;
+
+	if (adev->gfx.cleaner_shader_cpu_ptr && cleaner_shader_ptr)
+		memcpy_toio(adev->gfx.cleaner_shader_cpu_ptr, cleaner_shader_ptr,
+			    cleaner_shader_size);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6fe77e483bb7..5ff3ab7d429a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -444,6 +444,14 @@ struct amdgpu_gfx {
 	uint32_t			*ip_dump_core;
 	uint32_t			*ip_dump_compute_queues;
 	uint32_t			*ip_dump_gfx_queues;
+
+	/* cleaner shader */
+	struct amdgpu_bo		*cleaner_shader_obj;
+	unsigned int                    cleaner_shader_size;
+	u64				cleaner_shader_gpu_addr;
+	void				*cleaner_shader_cpu_ptr;
+	const void			*cleaner_shader_ptr;
+	bool				enable_cleaner_shader;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
@@ -545,6 +553,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
 		void *ras_error_status,
 		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
 				int xcc_id));
+int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
+				      unsigned int cleaner_shader_size);
+void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
+void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
+				    unsigned int cleaner_shader_size,
+				    const void *cleaner_shader_ptr);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
-- 
2.46.0

