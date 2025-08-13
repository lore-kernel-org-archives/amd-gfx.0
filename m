Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4183BCA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 20:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34FB10E7C5;
	Wed, 13 Aug 2025 20:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g1tb8X4E";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA6A10E7C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 20:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unWzq9iO/qhi8u8B/HdFBONoJTpdd83T7EhI10/kBPn7QclwNpL+69W2yD0gSy//rbGOnghsneA8c0PEIRw+p5ovq9rle9s861YgfeNgwq/66u1B2rFsbkZA8ktdm5eduHthcPd5r+dgULbS6de2JJA8qYlOFb6PXGjtAxClALj5pmsJUwHTgMP/M++nU8x7uWoO49O0/DK8zNsC/gEWfVf+dHIRqMnYrY1ts9bh6Ji4OjzRz3jmYW6EEPrS3y1GuAX6aYlfdQ2gQT9cCPcWTO0a4LUgmTdHIbcur0t4IxhSdSfmjahWVC9wtpXPWYIr80FMyhgandiXVyQ8WmTWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzrPi2Ii6R2qWuJfU8Ue5lH5emln8/5LcxAfTWPGs6w=;
 b=Whhk6uFKywkmGR3fqzo44SxluOCRq/rQiCezvY6PAPb/VpTScsmIw61Jj+oRI26jPLVWld0oTDFwOiuE4xfjrZqiizg7QifBvltdMhAZ+wp3cXZGtjDlSuR6fMc9CSvxcbyOuNkbHNBWZVeOlexMGWUgaKZHH54Hlf/VFMnPxfRYFTb3wYIY5T14FPi20QPd1sY/7zrKW1hP+F7yLp74ghQOditgCVtXbMGIufqOvCfRcD61gXa0z/0CrbHcgnhIdO67EieThyCXCRb8N4y02B+vC6ZdG3Jcd4ea6P7j2NmMdh7bivNPMAcfdvweTmjcE50gj0L5m+YA6/CTOj6B6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzrPi2Ii6R2qWuJfU8Ue5lH5emln8/5LcxAfTWPGs6w=;
 b=g1tb8X4EZ+bcB1oE1ZWQi/E6eD4/qMoVZ+B4lBNceBWesTXHPxACP3evk67dTbuPAXjLVTKmVNzn13B/Z1/dH7I4syDdOAoX9b/tqnPu/ZW1T9cDtMrRo9eTqMKWFXuPq8UsPRcHBxthFSYNr12panZeupLCV5PZHbLhoKCUya8=
Received: from BY5PR17CA0044.namprd17.prod.outlook.com (2603:10b6:a03:167::21)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 20:59:47 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::1e) by BY5PR17CA0044.outlook.office365.com
 (2603:10b6:a03:167::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 20:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 20:59:47 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Aug 2025 15:59:44 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>, 
 Wu David <davidwu2@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: Fix race condition during dpm off
Date: Thu, 14 Aug 2025 02:29:23 +0530
Message-ID: <20250813205923.1343041-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 700379ef-027a-4cf9-c6d5-08dddaac563e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2NIb0dKcXZvclVmOVFTR3c1NGl6L0FrZlQ3VE1vMC91ZytncXk5ZTd6eUFP?=
 =?utf-8?B?UnZCcHNzV2F1QWhqOHdxSmpGMVh4SDhEQmZidXJxWmF6a05kMW4rZmVpbGhy?=
 =?utf-8?B?WURhdDBKcGptK0FvRUw2bTF1dEI0TW42WkdZcGhGRDJqMDVpc0ZOMC92U0NJ?=
 =?utf-8?B?cFBoYkVPS1NSNlphK1pHaFFqLzJjcG5zamlzT0ZNVVRPTWtJRWZkaGFURkdk?=
 =?utf-8?B?WTRFL2t2RGJWSkluTEJldjhIZFNqZkpEamIyL2RFYVl4a3VMYU14ZmZFM09R?=
 =?utf-8?B?KzJvdHpDN1c2SDBkT1pvSGFkNGprQkdsNWJTTWxSdjNxOTBBcUJnczdRQVJS?=
 =?utf-8?B?MVFzbUttSm0xSUZiUDBjV1M0aXVneUJ4aGtaZlVnMVdvQTB6dHpGRFp0S0Uw?=
 =?utf-8?B?YStzbUpZMis4K2kyblluZHdIcU1JVEttRzBMOGRTZkhxSFN3NDJZSlg3emxr?=
 =?utf-8?B?STBocGIvS3ZLZk1vaHdmYkFZcUhvWTdVcWxyeFBBdktTV3VvNkhwU0p5c2Ev?=
 =?utf-8?B?cVVrblhkL2FjUkhscHRlWTRaTkZWMFppWWFkalVzakN5QUtvdVQwQzd0MXQ1?=
 =?utf-8?B?T2FwbktXSnJwSG1GK2tkOVI2M3V4SmszOTN1SGlhTTl1NlVQcXZMMFFobUxD?=
 =?utf-8?B?QXFFbVFmVnlHbnFDekhNTHJKUXpmVGViangyWnpTSGRLR09rbU5lRWY1c2FY?=
 =?utf-8?B?WHNrcTZtV1ozMW1uT3MvZFJrUmhLVUV1SXUvVzVueFpTWDcwYXF5NzkxUi9v?=
 =?utf-8?B?MDg3TndTdEVtRXhsdkhWWG96Wi9FWFNWNmJPZWQzejZJNjlJdVlTZ1A2UzhC?=
 =?utf-8?B?aHZuczc2cFNTelFjMWpaR0Nyb2JTdDk5TEYxRlFTYWlBSGRWWXNpUHl0Nyth?=
 =?utf-8?B?MXZsdlRBWFo0NGlKcEVPTzRsZnVnWGxlYVo2NXB6N1p2b1ZqaCtDNzN0NjUv?=
 =?utf-8?B?ZjJzeHQ4ckc5N0hQUFFPMjVkSnV3SHR1Ri9vbEJpYVRnbGFISlJMRnB5ay9s?=
 =?utf-8?B?M0U1VTl2bUp4RTkrTjY3NnNVaUMwVHVFL3BBdUw4WnpzNXdwMWtReTN3dEFS?=
 =?utf-8?B?TkJXcFk2MFBHTDZ2djZxbitTUWNCTk5Tdy8vSXRuOUdQM3ozLzM4RUNhVDZW?=
 =?utf-8?B?alQ4L0xSZ0F2anJjVWNtaTFTRFNodHhXYXpPaFNNRjdGQnhRcnlmNDZHTFZ5?=
 =?utf-8?B?bGlySXRKQTdNeWJQWGtXT1Z1dDg4TkprZzQyNmZrMjhYK29EZ3dRdXVRcjR5?=
 =?utf-8?B?ZytNYlMwakV3UFFmQWZMTGNHZ2ZHZEw4aUtjbDJLekY2VXVRc1gxZTVxQmx2?=
 =?utf-8?B?STA1cndUVVgxVnl2Wjd2VWxWWVZJRGZRR05XVkZYN002RURwelNRRVhlRFlh?=
 =?utf-8?B?S0xROURXWGN2NjJXMjFGLzEwUlVKd2lYMXlGMWlCYkNiVjdyVXRITWx3aHlh?=
 =?utf-8?B?U21UR0g3eDJibjNORU50SVVrdUVzMjFTM2RpNnNXSEZUR2RyajR2MGV4RTVO?=
 =?utf-8?B?RzJFd3lZb3NGU1N3WHB6S1k5TmgwNHZITW9VUWs5ekIrZGtCcVk0R0JpeGhI?=
 =?utf-8?B?NnhDTHZ3YmRHZ3ZkUDBzeEZGWWpqcmk0bVNuRSthQ0h6MS9WeUJrcEpTd3Bs?=
 =?utf-8?B?RFZoNGNHdSs2L29xOE9aNmU3SGx5dWd4ZVVSSUJuM05QZWNBMVVPZVorVXdP?=
 =?utf-8?B?RFV0dStLYlhJZlhnb012Y3hEcSttbmowRnZnWnRPclVhVzUrRk5tVXFRSWdF?=
 =?utf-8?B?SDBkQW11bHN4RU82dGdPa2dycGZRQ1pYNzVxN0duU01vcnVTN0hETkVLV0Qr?=
 =?utf-8?B?RENUaWF5eG1hQllpK29vZzg0d05GbEpVMFZFYzYrZVlYUHJROTlSVzk4YWcr?=
 =?utf-8?B?Q0lvUGR3T1J1ZlNtcUFkcDhSaDRtNnhIS2pQNmtnVURpc3E1elJ0elhLa3U3?=
 =?utf-8?B?elpRUk5pYUN5c2gyL3hYY0RRbEdPdVJUeDc1dnBiUFFQZWNLbldwL0VDWmRr?=
 =?utf-8?B?c29PdFNQcXNkclJIYXVoUmlmUHdDWGs5ZTBQZVhBTE51VDV5M2ZUckNSeG5B?=
 =?utf-8?Q?VWmHTZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 20:59:47.1326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700379ef-027a-4cf9-c6d5-08dddaac563e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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

There is a race condition which leads to dpm video power profile
OFF during active video decode on multi-instance VCN hardware.
Add flags to track ON/OFF vcn instances and check if all
instances are off before turning OFF video power profile.

v2:
using per instance lock is wrong, use a global lock (David Wu)

Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling")
Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    | 31 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h    |  7 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      | 18 +++----------
 4 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f7d7e4748197..69a889b3222a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4444,7 +4444,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
-	mutex_init(&adev->vcn.workload_profile_mutex);
 	mutex_init(&adev->userq_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c18..e034baa77977 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -102,6 +102,7 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i)
 	adev->vcn.inst[i].adev = adev;
 	adev->vcn.inst[i].inst = i;
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
+	mutex_init(&adev->vcn.lock);
 
 	if (i != 0 && adev->vcn.per_inst_fw) {
 		r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
@@ -134,7 +135,6 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 	int r;
 
 	mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
-	mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
 	mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
 	atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
 	INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
@@ -290,7 +290,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 	if (adev->vcn.reg_list)
 		amdgpu_vcn_reg_dump_fini(adev);
 
-	mutex_destroy(&adev->vcn.inst[i].vcn_pg_lock);
 	mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 
 	return 0;
@@ -443,18 +442,18 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fences += fence[i];
 
 	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
-		mutex_lock(&vcn_inst->vcn_pg_lock);
+		mutex_lock(&adev->vcn.lock);
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
+		mutex_unlock(&adev->vcn.lock);
 	} else {
 		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -470,14 +469,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	cancel_delayed_work_sync(&vcn_inst->idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev->vcn.workload_profile_active)
-		goto pg_lock;
+	mutex_lock(&adev->vcn.lock);
 
-	mutex_lock(&adev->vcn.workload_profile_mutex);
 	if (!adev->vcn.workload_profile_active) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    true);
@@ -485,11 +478,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
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
@@ -514,7 +507,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
 	}
-	mutex_unlock(&vcn_inst->vcn_pg_lock);
+	mutex_unlock(&adev->vcn.lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b3fb1d0e43fc..4457dcc5f9dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -320,7 +320,6 @@ struct amdgpu_vcn_inst {
 	uint8_t			vcn_config;
 	uint32_t		vcn_codec_disable_mask;
 	atomic_t		total_submission_cnt;
-	struct mutex		vcn_pg_lock;
 	enum amd_powergating_state cur_state;
 	struct delayed_work	idle_work;
 	unsigned		fw_version;
@@ -363,9 +362,13 @@ struct amdgpu_vcn {
 	unsigned		fw_version;
 
 	bool			workload_profile_active;
-	struct mutex            workload_profile_mutex;
+	struct mutex		lock;
 	u32 reg_count;
 	const struct amdgpu_hwip_reg_entry *reg_list;
+#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
+#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
+#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
+	u32 flags;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 3a7c137a83ef..344ab5c4cb18 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -147,9 +147,9 @@ static void vcn_v2_5_idle_work_handler(struct work_struct *work)
 	}
 
 	if (!fences && !atomic_read(&adev->vcn.inst[0].total_submission_cnt)) {
+		mutex_lock(&adev->vcn.lock);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 						       AMD_PG_STATE_GATE);
-		mutex_lock(&adev->vcn.workload_profile_mutex);
 		if (adev->vcn.workload_profile_active) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
@@ -157,7 +157,7 @@ static void vcn_v2_5_idle_work_handler(struct work_struct *work)
 				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
 			adev->vcn.workload_profile_active = false;
 		}
-		mutex_unlock(&adev->vcn.workload_profile_mutex);
+		mutex_unlock(&adev->vcn.lock);
 	} else {
 		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -173,14 +173,7 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 
 	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev->vcn.workload_profile_active)
-		goto pg_lock;
-
-	mutex_lock(&adev->vcn.workload_profile_mutex);
+	mutex_lock(&adev->vcn.lock);
 	if (!adev->vcn.workload_profile_active) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    true);
@@ -188,10 +181,7 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
 		adev->vcn.workload_profile_active = true;
 	}
-	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
-pg_lock:
-	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 					       AMD_PG_STATE_UNGATE);
 
@@ -217,7 +207,7 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 		}
 		v->pause_dpg_mode(v, &new_state);
 	}
-	mutex_unlock(&adev->vcn.inst[0].vcn_pg_lock);
+	mutex_unlock(&adev->vcn.lock);
 }
 
 static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
-- 
2.48.1

