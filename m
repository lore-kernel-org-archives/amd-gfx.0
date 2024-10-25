Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB850D1039C
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DB110E9D2;
	Fri, 25 Oct 2024 02:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zwh2E5dp";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E906E10E9D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vc3ww1TjdvSXNX3OKbCk+V3VIZti7tYKIHlInBCko7J4+7M9lw+DxXAsaZbe79rMKrIsadr8tXLJGtDWRcuxgY2T1vTWp67WYDhxbUTUc86/gcyMDJcpEOQQ3DA/e8ZCUBmrC0nZ6BKvS+razhONK/Q6vpSzkcIqdRLExLTrL/FBt/PazlWPDvHzwc1tQ7VXuisWnMIz+vC6DBW4G/jigi6N40mPURkwQgxXt9UDOHU8m3uhCve2ozjoyEnyG0lg4NX/T6l511Zh4VTMbmE7A4jnPKJrCxCOFfDpq8fNR8BZVkh1VnKmctgW17CGThwfhLB+cE+ItscSCj6ELj5KxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ5Fs0XeRq3IJ4I3Kcxa4VjA1JOg8OYQJGX0kSQTOKI=;
 b=WE/7IH0rMuTLmicj0dyB3asAI4QCEMwjkIPblTCLNWKMcCvvchCaD0rAk52HwssXNbBR90tMVR/13zHTmlGnMrtNzHgCD88WQf/8z0gfjjdLVMV8nFNhnnkLnxc9uAy4ntg1ZwZaMZkvfIqGRsjYqHwwRnTeh1+9E0K0gLQ+QO6lTvciojHbcAAdJUx77ScQWrZeCCp9cOXcpbN1l/VlNlcxY5ty/O0DurtxGxzByD0CZqPbx05bDE+zzZoGDlA6AefyhpFEI71ltx912bRhAdpAZMzWGaBIzVk5pe+ERe/6AGF/NVmDStD0SBzTNMIezmM9zfEfS/L4EyLeuiv+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ5Fs0XeRq3IJ4I3Kcxa4VjA1JOg8OYQJGX0kSQTOKI=;
 b=zwh2E5dp/FHbrKVJiJf+w7hu8eegB8WSZC5zEfSx6UH1Vj7vezQlMeYUC/Byaj4E7DBTDAjAUsMKRyo7dV3Q4lqGTKmuWA+uZkdzKQxzHEVRLpAmROtfIQTom2fBZ7mnQCDMqT+7KfD3nHOFkV9xRQ9dGp4DYXa/jOTnOnBZCYc=
Received: from CY5PR15CA0172.namprd15.prod.outlook.com (2603:10b6:930:81::15)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 02:36:06 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::a7) by CY5PR15CA0172.outlook.office365.com
 (2603:10b6:930:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:04 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 04/29] drm/amd/pm: add inst to set_powergating_by_smu
Date: Thu, 24 Oct 2024 22:35:20 -0400
Message-ID: <20241025023545.465886-5-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d64987c-b51d-4cc2-9ad3-08dcf49dc6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmJsNkF6bmhCWGtyM2xZeGRIRStNU0xTa1VDQW5jd0NVdTY4TGJMdHEzb1Fk?=
 =?utf-8?B?b2FHKzE2QUFQRXJTUkk3anVmdnJJTW1lNU1YZXVPUEcrdmhJb2RUQ3A5bFBl?=
 =?utf-8?B?UnhuMW1KVi9nRjdmN2dTME05bUlQWTVMY2N3aEpQSDFudmlWdTVYd0hIRDVT?=
 =?utf-8?B?cjFtRjV4RHBQM3k1N013TGRPUUptVTdsbmdiMHNaaXdnWE5wSHVMaEZtUDNR?=
 =?utf-8?B?T2JPaFpiNE1rd3BkVjZOalBQVnNIRlBwRit5QWJsNlFscWoxalFxK0JLV3JG?=
 =?utf-8?B?TU5ZenRzK2luT2sxRG5xeUtWeUlIQWVGK3VjN09pUTFRUEJKd0ppR0QxeWNM?=
 =?utf-8?B?RjRpTFo4ZTJHdjRpUjhQRmxjLzRkTUFDWmp6VXgyRldPZHMxcEdPbzBiS1JY?=
 =?utf-8?B?OE5JYUw2OTdNcnE0NlFGZFlaZEYyQW9BaCt6UG44Siswd1prY1BLTGV0b0lx?=
 =?utf-8?B?OU5Md2EzTVlldXk2NUZ4VlR5ZGpNMjFtYU1pU0VSQnYwdUR1aVg5MjU4V2o3?=
 =?utf-8?B?ZS9VcXV4bHIxRGJaN0R3MWxsRmFNRXVXOTNEUWEzWmwzb21pTTg4WlNLMWMv?=
 =?utf-8?B?bUgycXBHbCtQUU0weU5NcThDdmo5MWNzTzZSNVhWZXhnVWV0RTJhQ2lLU0Qx?=
 =?utf-8?B?RW1yQlByd1VjUmUwc1ljZjdza1ZPYm4wdjRsZ2J1UmtlZVV2WktXV3BkNnZt?=
 =?utf-8?B?bEJxWUtJZlFTTHpXQmdRL2ZWcGlnR2FFMEdZSmthaTY2NCt4dWZBZEt3TFBT?=
 =?utf-8?B?STAxU2RzdXVwbzJJaFRUUngwVmZ6QWtCbnFxZ0ZaRXY0WDBYZzhZNmVZOHEz?=
 =?utf-8?B?ZSt3anU4aVRtTGJ3L1RlSDdHRVQvcGpLR212MXkyNzVZK29yLytGb1hJem1Z?=
 =?utf-8?B?MmoyRDZpWjA5a29NN0lWUFpWeDlGb2t0NFJXMjhlV2pIQy85L1NHdXBIYVlZ?=
 =?utf-8?B?ZVY3VmJUY3ZPbjE5NkVCM1U0ZGt4VG1ZZFl1UkQzR3lGRlkvYzNWSkIzMzRr?=
 =?utf-8?B?SkdlekFETldaU20wODV2QUFYQTZvWlVEeE5OTjZwc3UwQU5ROVNqQ3BkRFIz?=
 =?utf-8?B?WGZtRE1mdng1U3A4dERHbVhaU3VYSVlad1hWdnJ1bDFBMS9sZXkwbWhOdHZM?=
 =?utf-8?B?NzVyazFvQW5qYWFBZDYvVUtCS1NqNGxNOXZDU1Yxb2FPZmR5SjgrbkY5R0FY?=
 =?utf-8?B?QjhaREpTdGQ2WjkrLzk3U2tQQmRyOVI4K0tIaXR4bjlGTGo1V01CN0pvcDFj?=
 =?utf-8?B?R0ZFZlVHMEIyaUt3dkFZRzJDUnNhMFY1alpTMlpMbUlYTGwyRTc2U1cwQkRK?=
 =?utf-8?B?SU9iZnBzSnhBcGFoNW5UY2hQRjVTd2ZQWXhRamgybjJGU1kydWM0eHgrZGFX?=
 =?utf-8?B?RWZabWxpYzRJSmpJcDM3eWpjeG9rUytQSWwvUGg0S2F0eHNCdnpORzNkS1dI?=
 =?utf-8?B?RnpyVEo3c0dVcEJlejVsa2xPTk1mQ0N0WXQrdE9MYUt0aDJXekU3Mk9kZVhH?=
 =?utf-8?B?SXJZcFJaSGh2cnY5QjNiNnFMekt6NDZUaGRZYVJnRU11V1U4R2JodXBlbHM5?=
 =?utf-8?B?NGNSa2MyMWFTZ3lTOENYZVBKT0hmNjI4T3lCZkRMZFlIRGRXeTZzendzRXdG?=
 =?utf-8?B?UzV3b2JuQW1manljbkQzKzFmWDQwZEFnOWtBT0tnNmtRR05aWkZvdmM5a3Yy?=
 =?utf-8?B?Q3ZCR1FWRHR3RGVzT1JYRURvbWhJdlZnSWViYlg1Z0hKS3lRcXI1eHVQTkVJ?=
 =?utf-8?B?b244VG9MdGFwb1NoSWVIZjh0cjRnS3NHazFYb2Y5WEFydXBEUmQvek1yWE1y?=
 =?utf-8?B?ZEd1VGQ4eGpwelErZ05XWkZ3cFlVSURIc2M0cDU0MWx6SDdNb1NYMjVCQ213?=
 =?utf-8?B?QXVwOWJUVS9IN0ltTXozSnRnVGJQR0VFWlJsQ1MxQWdiNmc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:05.8101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d64987c-b51d-4cc2-9ad3-08dcf49dc6b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add an instance parameter to set_powergating_by_smu() function, and
re-write all amd_pm functions accordingly. Then use the instance to
call smu_dpm_set_vcn_enable().

v2: remove duplicated functions.

remove for-loop in smu_dpm_set_power_gate(), and temporarily move it to
to amdgpu_dpm_set_powergating_by_smu(), in order to keep the exact same
logic as before, until further separation in next patch.

v3: add instance number in error message.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  4 +++-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 10 ++++++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c       |  4 +++-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 14 ++++++--------
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2fa71f68205e..f24bc61df9a7 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -405,7 +405,9 @@ struct amd_pm_funcs {
 	int (*load_firmware)(void *handle);
 	int (*wait_for_fw_loading_complete)(void *handle);
 	int (*set_powergating_by_smu)(void *handle,
-				uint32_t block_type, bool gate);
+				uint32_t block_type,
+				bool gate,
+				int inst);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
 	int (*get_power_limit)(void *handle, uint32_t *limit,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9dc82f4d7c93..bcedbeec082f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -88,7 +88,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCE:
 	case AMD_IP_BLOCK_TYPE_GFX:
-	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_SDMA:
 	case AMD_IP_BLOCK_TYPE_JPEG:
 	case AMD_IP_BLOCK_TYPE_GMC:
@@ -96,7 +95,14 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_VPE:
 		if (pp_funcs && pp_funcs->set_powergating_by_smu)
 			ret = (pp_funcs->set_powergating_by_smu(
-				(adev)->powerplay.pp_handle, block_type, gate));
+				(adev)->powerplay.pp_handle, block_type, gate, 0));
+		break;
+	case AMD_IP_BLOCK_TYPE_VCN:
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+			for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+				ret = (pp_funcs->set_powergating_by_smu(
+					(adev)->powerplay.pp_handle, block_type, gate, i));
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 8908646ad620..f0f81ecd9ad6 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3276,7 +3276,9 @@ static int kv_dpm_read_sensor(void *handle, int idx,
 }
 
 static int kv_set_powergating_by_smu(void *handle,
-				uint32_t block_type, bool gate)
+				uint32_t block_type,
+				bool gate,
+				int inst)
 {
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 26624a716fc6..90500b419d60 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1227,7 +1227,9 @@ static void pp_dpm_powergate_sdma(void *handle, bool gate)
 }
 
 static int pp_set_powergating_by_smu(void *handle,
-				uint32_t block_type, bool gate)
+				uint32_t block_type,
+				bool gate,
+				int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index bb7980f48674..c5ef8806dbb3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -354,10 +354,10 @@ static int smu_set_mall_enable(struct smu_context *smu)
  */
 static int smu_dpm_set_power_gate(void *handle,
 				  uint32_t block_type,
-				  bool gate)
+				  bool gate,
+				  int inst)
 {
 	struct smu_context *smu = handle;
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
@@ -374,12 +374,10 @@ static int smu_dpm_set_power_gate(void *handle,
 	 */
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCN:
-		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			ret = smu_dpm_set_vcn_enable(smu, !gate, i);
-			if (ret)
-				dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
-					gate ? "gate" : "ungate", i);
-		}
+		ret = smu_dpm_set_vcn_enable(smu, !gate, inst);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
+				gate ? "gate" : "ungate", inst);
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
-- 
2.34.1

