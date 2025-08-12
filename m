Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56BAC87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 14:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D7D10E0C4;
	Tue, 12 Aug 2025 14:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKTsYI9u";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F24010E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 14:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzglMyyzdte7gvYNFYmilv/BoFtRMIlBhfLl4vtZS5bkWzzkiHOPSrQpop7JzGV3BWquPn4fTM8qVvVZdc/DRH4ewlwjXY2MDjgIMi48Ag7Wg50THMdxTJTaL/wv3xEBblC/6JKasJhZ6z5T7d5sPCwPsbkte0taix5my4IQF0xaF3QbOsKwePaNfrrp2/2Lh7XyjSQOdvguGa2x/nS883yrpEAmNyyj2XRib+nqL7x5QvSKeUHywuO/pbyX2yCTeUWytJ7YfpmeRulVYuNfJEqV9ApHuMChmQHuPH+vnIE/83PZFpN0L5pxqC1FSKpWK+xP3/qgV8m/gTivocbe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHRRkJ6nQ+2Jpi25KkmE6rQ4o/1QKOWIRRlaEHUi0/I=;
 b=j4cIM1JMHjqCdvlVRaV7Tm900kOEowFp/897fS981WSTIvOi/uRAXMNL2ayWROVsvYnQoQttA935+9A7XNX7Yd2cWiJSkDv2Sy+N34IQzCAhk2E5MYN7KI2vaDEnB2lHVIHTBAaA2BPtBywFyKGDiYcgeQLmkVHyOjWxE5usCxBB+ER0g1NatFWN1WX+7xAS+xTap3gv80mofvy1CUbtRI6+Udi2eFLiiZUzmcLEPzFRioH0Bo3P9Hcmb9O1fdhckf0fgTyEMq1x85UoVx70pgh02Yn8B8Z39wbiZrrrGqy/nfSk5QltLJx4S9e+HWuRto5OgChPFrj1s4zmmnpCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHRRkJ6nQ+2Jpi25KkmE6rQ4o/1QKOWIRRlaEHUi0/I=;
 b=FKTsYI9uo1MXQcoRTZTEeSYV/RP7qyiU4LNLQOD48RZ72ydssZdrHLiGmzU3xGVf86VQEliXs3FB1cIdqEA5JA60vHI2Fy6fnWA72SwEBJYkvmBEtsnojEg/L6xMBIbf060YQhuq7q463j2QjfnEPxtjj5O+EBqJuo4igWBSoKE=
Received: from BN0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:e8::19)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 14:56:29 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::f) by BN0PR04CA0044.outlook.office365.com
 (2603:10b6:408:e8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 14:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 14:56:29 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Aug 2025 09:56:26 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>, 
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: Fix video_profile switch race condition
Date: Tue, 12 Aug 2025 20:26:10 +0530
Message-ID: <20250812145610.1300497-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c75ac9-b488-4e10-3147-08ddd9b06b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzRPVDU4c0orNnRFdXZLbjhmdERLVlhad0UwQ24rZnpPeVVVVFZ3eW5nRU0v?=
 =?utf-8?B?eDFNZzl2V0M2cXR2MC9PYWRqaEg2em5tK1k1ZGV5NkFEbVVEZVYwbnJZa2Nv?=
 =?utf-8?B?RDFIT3JIQmxSbzR3WGxGcVl4ZmNGMloyQUUxdUhnNktyVXUyY3A1cFFGVjl1?=
 =?utf-8?B?OGJMQWU0OFBjaUxjRk1XTW81VCt0dVF6QzNYVEJtTUM4UGlMcVBHMk5uNmlC?=
 =?utf-8?B?SFhITFJQUDJzck9aNFpCYjJRNm16REs5RTF6aExiRlZZMTF0Nk15SEJaSTMr?=
 =?utf-8?B?cnhGQ0czSDFsWWV1OU95bWtTcFFQMlE4RFpYK1hIVU9mNzhLdlNwZTkrbllj?=
 =?utf-8?B?SzkvTDB6eW14eFVQYkJ1UWlqcFBHVFlsbFJPb2tQR3Z0cmNFZ3FxdjFFS1dU?=
 =?utf-8?B?aWtkV2FZNUwvV0E0UGcxQVJ5dGVYaWpIYnhLSWxseVVtR09VRGdxQjF3T3NN?=
 =?utf-8?B?ellqMVpteHJxT1luMTJiMHJJMGVwa0FQY0tWeGlsL1FsemRxZGpXellYUGlT?=
 =?utf-8?B?N2JxMDVrOFhhcWRqQ2xoaGlLOVJXV1JZUUU2ZkZJRXFPM0VFNTdEWXYyTm4z?=
 =?utf-8?B?THpMNUFPdjQ4N0NKbWtQMkkybFk4dGU4dC8yL3ZHb0svRnNuRGJCTXQ1L1pQ?=
 =?utf-8?B?OEdIZVdjUWZYQjI4UGdoS0lzc3pxeDNUSDRFRTBHMmpOaEdtdkRIRm53Ykl0?=
 =?utf-8?B?cC9GVnVYOXFoeVh2TUdJMTVJbHFCV3RjbFdGN0Z4YnV6TEkyOUNQU0w3cG1B?=
 =?utf-8?B?d0JITklMdVBublByaE8reUJ2RWxSeTJYK3RCNEhGRnFRRFdTWXZpQ1AvOFk2?=
 =?utf-8?B?Q01neEMwRU5oTDdCSEZuaGRvMkdqa0RmYzdPRUUrOE52Tm9PR1VZcTR4MUV3?=
 =?utf-8?B?S3BzejBUMVdEZDZMbExxaGw1cG00SkIvUmtaVXFJZll4bWUxZHUyV2hSTVNF?=
 =?utf-8?B?VnpKVng1L1RmcGRlOGhUMnIzc3Ntam9rK3MxV2FqUG5EWHZVc1hLMnJIS01B?=
 =?utf-8?B?OUNTL0V0ZlR5azg1UTl1SzlldXFuZHlBbzJHWE5kYVNnWEw2K05BT0dHWnp3?=
 =?utf-8?B?elJhcEVNeloxVzhkeitnSXd3WjJISUdWTTBydTZmTHZCaWo2dTl5YWJxVTlv?=
 =?utf-8?B?ZEYxczd6VEI3RC9QWHNUZ2VWYjkwMzZ2MnNlRkl4bkIwL1JNZFpLYURPQ29H?=
 =?utf-8?B?QWNiemx0aXBFUFZFai85dlFQYmQrUXZjNEtvbEo2dHkwTjZVM2UzSDZ0bjZ4?=
 =?utf-8?B?V25Ec0VNRXVGY2Vqd3pKYkEyQWI2dk5aRlEzUFdtQWdRZDBqUnE3YXcxR2Rr?=
 =?utf-8?B?VDBwNU0xMDJzZ1J4R1FXQzBYVEVJcXBRZ1NpTENGMTYrWGF5a1Y5SXpneW1Q?=
 =?utf-8?B?RytCOVBVNWVzTTl1QjBIL09pdTBRNWZjcXMvWW1LdTlyam40RDhDY3lJc1NQ?=
 =?utf-8?B?WDJZa01HVjlpK3FUUmhNMlZkWG1UalVUblZoMExYU2xLaW1CWHlLeEdmeWpE?=
 =?utf-8?B?OW85NUV6WWthaFJCRGRNWFhBR0lvc3h3ZGw0eTdldlVGZVU4M2k1TlgzbW1L?=
 =?utf-8?B?dXBsUGJ2VU1nRDVRdmF6bkVrWVRPcUZKRzFoYVg0dUk5bCtWOGJ6RkVteGNi?=
 =?utf-8?B?ZC9OTEQ4MzhaN3ZBdFU3alU5cTdVWHdLOUtZMzBaOE5yUVhxTS9XbjBwZ2My?=
 =?utf-8?B?MThtNkJLcEtXZ21aU1NST2QvK2xsWmNiMnNDdjFZMDhHWVJtdHJXUS90VjFN?=
 =?utf-8?B?MDRDaWpkNXlWbFo0RkFPQWhTdWY4eGF4SEdMdnhMRHBEQUVOOEVOSzg1Rysy?=
 =?utf-8?B?RzhMUTVpWk1rZUV1TXpndnNxQjFyT3JnblNhVFdlTVkxd1NjSUxSSFlTNURP?=
 =?utf-8?B?WGVSUGtEVG0vTXYrV2pHUGZiUEIvZlFOU3U0Y1VEZ0NEQ2NFa3JOSnlJTTRV?=
 =?utf-8?B?VGQ2U3FpZUhSb2ZwMHhrOFJSUkdmVWdjSmVCeUMwU3NUWE9RSktlcHhWMm03?=
 =?utf-8?B?bTY4U2pweXRRVHRRVlVIZTRZRCtUVElXTUgvZS91RnBWYUgzbzVLc2cwQXZS?=
 =?utf-8?Q?vOx7sw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:56:29.0984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c75ac9-b488-4e10-3147-08ddd9b06b23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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

There is a race condition which leads to dpm video power
profile switch (disable and enable) during active video
decode on multi-instance VCN hardware.

This patch aims to fix/skip step 3 in the below sequence:

 - inst_1       power_on
 - inst_0(idle) power_off
 - inst_0(idle) video_power_profile OFF (step 3)
 - inst_1       video_power_profile ON during next begin_use

Add flags to track ON/OFF vcn instances and check if all
instances are off before disabling video power profile.

Protect workload_profile_active also within pg_lock and ON it
during first use and OFF it when last VCN instance is powered
OFF. VCN workload_profile_mutex can be removed after similar
clean up is done for vcn2_5.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c18..da372dd7b761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
 		mutex_lock(&vcn_inst->vcn_pg_lock);
 		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
-		mutex_unlock(&vcn_inst->vcn_pg_lock);
-		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (adev->vcn.workload_profile_active) {
+		adev->vcn.flags &= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst->inst);
+		if (adev->vcn.workload_profile_active &&
+		    !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->vcn.num_vcn_inst))) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
 			if (r)
 				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
 			adev->vcn.workload_profile_active = false;
 		}
-		mutex_unlock(&adev->vcn.workload_profile_mutex);
+		mutex_unlock(&vcn_inst->vcn_pg_lock);
 	} else {
 		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	cancel_delayed_work_sync(&vcn_inst->idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev->vcn.workload_profile_active)
-		goto pg_lock;
+	mutex_lock(&vcn_inst->vcn_pg_lock);
 
-	mutex_lock(&adev->vcn.workload_profile_mutex);
 	if (!adev->vcn.workload_profile_active) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    true);
@@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
 		adev->vcn.workload_profile_active = true;
 	}
-	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
-pg_lock:
-	mutex_lock(&vcn_inst->vcn_pg_lock);
-	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
+	if (!(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst))) {
+		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
+		adev->vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst);
+	}
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b3fb1d0e43fc..a876a182ff88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -366,6 +366,10 @@ struct amdgpu_vcn {
 	struct mutex            workload_profile_mutex;
 	u32 reg_count;
 	const struct amdgpu_hwip_reg_entry *reg_list;
+#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
+#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
+#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
+	u32 flags;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
-- 
2.48.1

