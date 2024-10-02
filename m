Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F6ECF3194
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E9910E684;
	Wed,  2 Oct 2024 04:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EE0PvC6S";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AE410E684
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ7dE/TunhCCs2E+urLsdE9y309kPQLQzgegbjzmu5yTBhxsj7CeApSdqFXuydQo5iocckeLd67fAlBidZBiTCXr18yn4N0HC3nqVBG7QelD/jJ2sV3mVPGN/hkUW3hVUX53w9GNWQaG4NS6jiiIxTXVHhfJ342Ep5WJGeKeoZn9wYhqzPuV9EVLKT7AL5NaUWZu5megILpiZp1u+CuW1KBjqPDyiGxLDjAS61m7rQSLAbmd2GRgC7K5BNnMQvpn3pBNAvGntuXhAFw1jGFziR0sIFvFnGzumWL3l747YUMjZ/J0GJEE5kPe+c5NR0BMgOhGnxGYK3HKNgVXIEgV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWF8FlHq5tfqFTVBfgGoT250pJ1bebDgxgc1zDtNvzE=;
 b=GmXfHOhVzlj6mmWtw4fldb+qhG0T6YPqogjWE8dbi2R+Ah6DnTIFsjHyZntYC9fJ+Hhk19azdFVBLCdPFBTFPU39soGgWIQzmVPHU3cBl8iZ8QRKkNhMgmOOXzHGTlS6ejnlZt62vmehsW0HnrECpY7ckJB+0jgOrWez96DGIAw2bJTRwzrk6aa0t4HTFGhaLAEsfOZQcnymOnUOS8MvBeKaXdWf9Dlv/0G54Ue59Hobfa4OxfkCCRHJgHbVGf0Hb3QRbyMV+SIRtqOiCB9bkssSZLVD3VF++HI9ZVKq7DoWEPjT2A/xJf4P5oBVwWhAqMLkW2+XRGl+13/KDdrqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWF8FlHq5tfqFTVBfgGoT250pJ1bebDgxgc1zDtNvzE=;
 b=EE0PvC6Sp5HA9qEphp2S0xuJAkbC/MtcErQmCUh98sRtz42HfttzBqmHJ1ySyEWRDQt6PMulFdktsy+rSBLM34ts8zq3WnWtAK01QywaDqfhb5t0iYJuI7FRCA9juNZYhDkcq+TcPoftE5llo+9vfGmxtheirL8AWX8pMA8r2zQ=
Received: from SJ0PR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:334::20)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Wed, 2 Oct
 2024 04:38:52 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::39) by SJ0PR05CA0105.outlook.office365.com
 (2603:10b6:a03:334::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:52 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:47 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 06/18] drm/amd/pm: set powergating by smu by instance
Date: Wed, 2 Oct 2024 00:36:15 -0400
Message-ID: <20241002043627.102414-7-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cb77c9-6b52-460f-ace7-08dce29c1dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zVxCcviHR76I6Y8bDHnzyEqF5nnLm04vMx5goZR70UBcgOhQsVvwrtcM6Q8V?=
 =?us-ascii?Q?mp/j+hKsWJP1i8xTa8O7nWBRegPptIZ4meiarmH4J1AbylVRu2NYZiVsOBOs?=
 =?us-ascii?Q?CsNLfe/yjBTH4rnkj1YFwIRWEs24N9Oi3BpdXFIsdZjYR6GNSwqtS8AA72eC?=
 =?us-ascii?Q?PHw6ahOkbydw3TP+hCHM3b9WsThp/0QZVOOBf8dWAgt4YEHJN0CehqJuw7yO?=
 =?us-ascii?Q?zIwcABK8Z834bFcW7tU644g9So+bwEU9jXKEvJkE6PVr5CA8O840ZQ2fJoQL?=
 =?us-ascii?Q?eqtrRpf/OsMKATAWE0CYcL9jFuxVaGajB/32OtbVOIIIa0K+e9woqQfA1bYj?=
 =?us-ascii?Q?FCDBYXgfa3w6MClAOUkRhIrTBsv4JXmFkTr0z6TeOUKD4Lv3d0f3wPrjfKIf?=
 =?us-ascii?Q?0PlqiOjMLO9CgFt2fVO9rRT9CzQXdwwTLv5JyWrshqwSjC73qPgXQykU/xVV?=
 =?us-ascii?Q?7S2KKPMeZll0FIlmqE2MQCa6KHv635GcOaiJXH9Nx3FJVE0ATwrlOS2vWX8f?=
 =?us-ascii?Q?0LLpW8fpsJYfcuhPutUNRWpoVSkS9w5zQc5eAC3NzLIFD+yO4covD8Fk4/GW?=
 =?us-ascii?Q?+nUSKjwnyoWoUgHwo8KUM2vJvqSJuDn9y3H0kv2Hn5IqpoX5X6EWDSpWGgjZ?=
 =?us-ascii?Q?oEs6KEWLZ1D+yrR4NTt6I/FBrS3KlD9fROrloM1Cp8rI5QCJUqD5UsXFh49z?=
 =?us-ascii?Q?wj5FhT6vxyZkIBm9M+BMsSGm4dYZIufQ/g2YhrkW8lr+fCYEUEEmTM/f4779?=
 =?us-ascii?Q?18MBT8vLfmchsX/cMIZB4jgNUxUMmQ6d7gnb6UNEAeNdvO4Wkc7tDn2roWTl?=
 =?us-ascii?Q?nbfm7rs+sDe+uObMgQBGhdwbEWQh+S3eBu/vqci97c0b+necqAEqe1cmgIJt?=
 =?us-ascii?Q?ovgc9BXbcTRI26Od5kVmqkW7gkBkZV3+hW0CL92FzkMk39M9L7YAtef5UMtl?=
 =?us-ascii?Q?ek+MIYilkE19JTDPEFbNesySSEPNNWqc/Bi+8Gc/0w1N6YHdRPGxjHW/xfe7?=
 =?us-ascii?Q?Im0f6yzDICwhS3s9MT00h/SymcU528Mg+FcpsnziFmF1PNNHXT3yneqH1gVP?=
 =?us-ascii?Q?3nNB7UN1uBWemq85KoEiNzmPZ5ciw8Ia/FguKS3g+7bh2wbKUDpzsycAYgq1?=
 =?us-ascii?Q?bUQu+nMR/0wfB7nxgtpSSpgyXY2MuHw5OBg5VEQC9Q3BBWf65z+PJWeG7cKh?=
 =?us-ascii?Q?CJyeYpV76bui6nTs8ZMESgInUnt+BLdDsz5AsTSyjJSk39Ksj30rX23dphKA?=
 =?us-ascii?Q?1NuwqXLgBVX0WwMg+cZxieEGJptDZh7I6LQB4LtsVI4XlP5wsj1Z4HFNamFy?=
 =?us-ascii?Q?RRg2zPx+4VHDY4qL/lKdQDVFREMZkIpo+Jy9t4kxtpZshDeZ6csn9J4JIqRh?=
 =?us-ascii?Q?LZOcIkQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:52.3056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cb77c9-6b52-460f-ace7-08dce29c1dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
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

Add a new function to set powergating_by_smu for the given instance

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 67 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
 4 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2fa71f68205e..cdd891f51422 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -406,6 +406,8 @@ struct amd_pm_funcs {
 	int (*wait_for_fw_loading_complete)(void *handle);
 	int (*set_powergating_by_smu)(void *handle,
 				uint32_t block_type, bool gate);
+	int (*set_powergating_by_smu_instance)(void *handle,
+				uint32_t block_type, bool gate, int inst);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
 	int (*get_power_limit)(void *handle, uint32_t *limit,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9dc82f4d7c93..f2d2f85476dc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -110,6 +110,49 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	return ret;
 }
 
+int amdgpu_dpm_set_powergating_by_smu_instance(struct amdgpu_device *adev, uint32_t block_type, bool gate, int inst)
+{
+	int ret = 0;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
+	bool is_vcn = (block_type == AMD_IP_BLOCK_TYPE_UVD || block_type == AMD_IP_BLOCK_TYPE_VCN);
+
+	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
+		(!is_vcn || adev->vcn.num_vcn_inst == 1)) {
+		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
+				block_type, gate ? "gate" : "ungate");
+      return 0;
+   }
+
+   mutex_lock(&adev->pm.mutex);
+
+   switch (block_type) {
+      case AMD_IP_BLOCK_TYPE_UVD:
+      case AMD_IP_BLOCK_TYPE_VCE:
+      case AMD_IP_BLOCK_TYPE_GFX:
+      case AMD_IP_BLOCK_TYPE_VCN:
+      case AMD_IP_BLOCK_TYPE_SDMA:
+      case AMD_IP_BLOCK_TYPE_JPEG:
+      case AMD_IP_BLOCK_TYPE_GMC:
+      case AMD_IP_BLOCK_TYPE_ACP:
+      case AMD_IP_BLOCK_TYPE_VPE:
+         if (pp_funcs && pp_funcs->set_powergating_by_smu_instance) {
+            ret = (pp_funcs->set_powergating_by_smu_instance(
+            (adev)->powerplay.pp_handle, block_type, gate, inst));
+			}
+         break;
+      default:
+         break;
+   }
+
+   if (!ret)
+      atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
+
+   mutex_unlock(&adev->pm.mutex);
+
+   return ret;
+}
+
 int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -572,6 +615,30 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 			  enable ? "enable" : "disable", ret);
 }
 
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst)
+{
+	int ret = 0;
+
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		mutex_lock(&adev->pm.mutex);
+		if (enable) {
+			adev->pm.dpm.uvd_active = true;
+			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
+		} else {
+			adev->pm.dpm.uvd_active = false;
+		}
+		mutex_unlock(&adev->pm.mutex);
+
+		amdgpu_dpm_compute_clocks(adev);
+		return;
+	}
+
+	ret = amdgpu_dpm_set_powergating_by_smu_instance(adev, AMD_IP_BLOCK_TYPE_UVD, !enable, inst);
+	if (ret)
+		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+                enable ? "enable" : "disable", ret);
+}
+
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f5bf41f21c41..f4cd60ffba47 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -395,6 +395,9 @@ int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_t limit)
 int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 				      uint32_t block_type, bool gate);
 
+int amdgpu_dpm_set_powergating_by_smu_instance(struct amdgpu_device *adev,
+				      uint32_t block_type, bool gate, int inst);
+
 extern int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low);
 
 extern int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low);
@@ -442,6 +445,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ddfed7189708..449925105889 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3744,6 +3744,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.dispatch_tasks          = smu_handle_dpm_task,
 	.load_firmware           = smu_load_microcode,
 	.set_powergating_by_smu  = smu_dpm_set_power_gate,
+	.set_powergating_by_smu_instance  = smu_dpm_set_power_gate_instance,
 	.set_power_limit         = smu_set_power_limit,
 	.get_power_limit         = smu_get_power_limit,
 	.get_power_profile_mode  = smu_get_power_profile_mode,
-- 
2.34.1

