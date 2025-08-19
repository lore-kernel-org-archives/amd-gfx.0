Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC527CA0EED
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 09:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AAD210E567;
	Tue, 19 Aug 2025 09:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="susZbZU6";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796CE10E567
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 09:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miRG41EC+/CxW6aKYh2mtxx0MQRHMwUKDQ8b4C/8RWbI/k5HaWA9KJ3JRsfg+oA+t6x95AObusqCl14hXtmBH807MGWLvswhermUfy2B8mwYpmxqAAV8wtCHOSAC0lveJJUfenc0i9RsrS6Q54Xf5y12MO7IHQvEdSd8Gq0ai9/MQvS3zOEEC6Flqh7PWv8BP7HKqBvL+XCm4WlwKExL0fPrOUgC3egamBy47aOoxwktyY2wXUsaxnVqlkGnIwfIyXqitJ4zV0YUr69S2MKGNgkS2j4ip+IbXmD0W49U0NdjclLf1esi9y2cBsiZrN/8mlxiKV7TLa+4JeTIV6EZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQZKNm5KGcCLObLhJNZoBZ4lf6K2+o8ENmgi1ILBSyA=;
 b=T3oHpF6hkWF4OCN4R2tEuG0HQfvTN9tISnW9JOiwQnyEeZY+HzP9HR1/NwWKO8x1fKUbU53kSOQKWHib3yFCYxNzRKfEDO/13H0Wo2IkbrS1J/4aAA4PWp8IgmYxKA6X1UycFEhxjZ6Su3buynCk3Mi1ziI5+tgNzmoY/6poGM4PV/cHOjT1/zvO5P3e3tQfLly3WAyU1ayw6UpPActsaLjb9YciqwE+oBxxopz3C1+U3vDra9KCEGqmt/bdqnpgaKLYCFFe1SwljhUnguhx6xsRUuNPcj71COo17zRhqIlcNnYFPafx8Td2EZzGzi2lyd9AnoLmLy0CoebcfCgD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQZKNm5KGcCLObLhJNZoBZ4lf6K2+o8ENmgi1ILBSyA=;
 b=susZbZU6EhIOEY2AwHQ7bqYpxoeZpfBg+QtATbSLJT5KDeO3EqKXTKbdCfxGItmdDRBs+W+eCCT5jqiSwcc/161u8j9Ex8qkR65Z/JK8DiL4z+V2SLDroSwNLvlu+8+EFeY30HPVQ0dyi7PfJUbpp594hj7c63YBnwQ2Z3ErDbM=
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 19 Aug
 2025 09:12:38 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::62) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Tue,
 19 Aug 2025 09:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 09:12:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:12:33 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <sathishkumar.sundararaju@amd.com>, <David.Wu3@amd.com>
Subject: [PATCH] drm/amdgpu: Check vcn state before profile switch
Date: Tue, 19 Aug 2025 14:42:17 +0530
Message-ID: <20250819091217.2115134-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 6517d474-7d36-4e5d-c2c0-08dddf0089f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6fVagXyRQhNgQoJESwhOJyrs3MY60W6EkUeOPb63+M6LoWGsd5pf6c62k5vk?=
 =?us-ascii?Q?/sKAz1utrF8vAeOVwSmUbnb8q831RICEzgX4m42vzO/DsQi3gyi8/cKRHP/0?=
 =?us-ascii?Q?wPmn7tafTU9S4dp48FGQ8Ci42276oNh/JxjbtoiHO2Zq35pCX95G+K9xVzpw?=
 =?us-ascii?Q?4XVjDoyCzUCVQKqavy4ef+/uyn8iswHBAkR03Nr5Zt6V88bVIOu6raWFDdO3?=
 =?us-ascii?Q?7gbot3vJdE5D7K1/FXQQx+/41B/XoclUexI0QMCoV2S0kSN7kSEUMPcSQPtx?=
 =?us-ascii?Q?Q1iJnZO405fFySJtgjfrecnzk/O1wg9jtQtAruRUEYcP4RPfDJY5oSAew4ql?=
 =?us-ascii?Q?zKDfA//ErNd520pQsHLhcM6lHUTLaSBhFFwdqgjsF1YXNMjG3hRm3wTObBhc?=
 =?us-ascii?Q?oaxWeMQzRf/Bq5rWAHfF1JzDXKGvi/KwbPUV6sZPq97olbM7F7SU/t+nvXVW?=
 =?us-ascii?Q?aIXULCA66PuP573Xy8S3REctmBY4otBkwwtzAcAa/VTzdb5nrpsEapcdhkkX?=
 =?us-ascii?Q?B+Ud4rlM0YImNqVRue6M5LpeAMIolfEmiE1uegnGHCfhzi9/LVG+lijGv9ep?=
 =?us-ascii?Q?PGfCA/bZqbRktWfndlLx6sI7HUaBZgAY2jpe3J8r3d6ZTBOkMkoJZ7TpFP9W?=
 =?us-ascii?Q?+zAAItkMTESTnetDo2DEQzI5agkVmhD7/fLX4H1DDbACZVVKdp2kkGly69+R?=
 =?us-ascii?Q?DNdZUjR1l73n/SW9W15cqP4giwGsabdWXN5I7mZNiYhGbUdwPuvdywghNTVt?=
 =?us-ascii?Q?dD5qomRnUoBpoa9vwHsBRxdO5JX9MKHNEoRwaCqEwdV8eTCRXaVGursgCjfI?=
 =?us-ascii?Q?RTkm7g5jv1tWV34ylVV9mXsaQX1Yn7NjSo75JBjahiKwDfDvJF8vr0aTfLc2?=
 =?us-ascii?Q?vKSgBXYPHYOByZVEP83645Exk0TP0SGHHkgUH8I7ezJRLGq5d/rSJ8eKgmkv?=
 =?us-ascii?Q?0M//4CZ1pggjhznsSnZSjupAtrBCI81Qx/3OQvGYVIMEE6Je/o9WuHdrDZxl?=
 =?us-ascii?Q?H8Avr94Ovt2D+LiGPOlR50W1DXc2i1Lyh8OafCJepFJuWMY4hClzuWXGWyBO?=
 =?us-ascii?Q?XPmPvtK4gTqJLDxQtZy2/v9LhIu/O+k+O8UiCmT8SBrl3FNbYC6rcPhRvOaz?=
 =?us-ascii?Q?fW4zm4BShq1lUMJv6kuQQtEZwxVPhL+FsP5DdHQClWUwmPmXEeOC7I/t4fls?=
 =?us-ascii?Q?T6btN1NRmxZrO8IjyCKVhYvzoC7yd7OiFtiGrVyVbxBafNPGjng/U/Exhq4Z?=
 =?us-ascii?Q?GmHjuTbYvTHSWB/174/RTV2peytrtc0oP+OyViSL88lPcpZWBLsEj2Jfg2AT?=
 =?us-ascii?Q?VBK72g7OU0XtWrryMmzCWVK7yk8jBPEdnt601XZFxnoz6I0jzY2mnPeNE4RG?=
 =?us-ascii?Q?VoGeIFlXlBPCZtogjlcpo/crM3zyJh7YxWGAGFhikJww+y1g6IQrRd70Xoeg?=
 =?us-ascii?Q?FzGUVFt6dcIb4sDuPueBvRzUMUQh4489dCztjXm2yG8M/BDXHLZcGjTM436L?=
 =?us-ascii?Q?3gj3PHW3cMpzOaFrEntVV0FkYS+wOKZjgmZE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:12:36.2649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6517d474-7d36-4e5d-c2c0-08dddf0089f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
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

The patch uses power state of VCN instances for requesting video
profile.

In idle worker of a vcn instance, when there is no outstanding
submisssion or fence, the instance is put to power gated state. When all
instances are powered off that means video profile is no longer
required. A request is made to turn off video profile.

A job submission starts with begin_use of ring, and at that time
vcn instance state is changed to power on. Subsequently a check is
made for active video profile, and if not active, a request is made.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 85 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 27 +-------
 3 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c18..f3eb64edf6d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -410,6 +410,59 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev, int i)
 	return 0;
 }
 
+void amdgpu_vcn_get_profile(struct amdgpu_device *adev)
+{
+	int r;
+
+
+	mutex_lock(&adev->vcn.workload_profile_mutex);
+
+	if (adev->vcn.workload_profile_active) {
+		mutex_unlock(&adev->vcn.workload_profile_mutex);
+		return;
+	}
+	r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+					    true);
+	if (r)
+		dev_warn(adev->dev,
+			 "(%d) failed to enable video power profile mode\n", r);
+	else
+		adev->vcn.workload_profile_active = true;
+	mutex_unlock(&adev->vcn.workload_profile_mutex);
+
+	return;
+}
+
+void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
+{
+	bool pg = true;
+	int r, i;
+
+	mutex_lock(&adev->vcn.workload_profile_mutex);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE) {
+			pg = false;
+			break;
+		}
+	}
+
+	if (pg) {
+		r = amdgpu_dpm_switch_power_profile(
+			adev, PP_SMC_POWER_PROFILE_VIDEO, false);
+		if (r)
+			dev_warn(
+				adev->dev,
+				"(%d) failed to disable video power profile mode\n",
+				r);
+		else
+			adev->vcn.workload_profile_active = false;
+	}
+
+	mutex_unlock(&adev->vcn.workload_profile_mutex);
+
+	return;
+}
+
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
@@ -417,7 +470,6 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	struct amdgpu_device *adev = vcn_inst->adev;
 	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
 	unsigned int i = vcn_inst->inst, j;
-	int r = 0;
 
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
@@ -446,15 +498,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		mutex_lock(&vcn_inst->vcn_pg_lock);
 		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
 		mutex_unlock(&vcn_inst->vcn_pg_lock);
-		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (adev->vcn.workload_profile_active) {
-			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-							    false);
-			if (r)
-				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
-			adev->vcn.workload_profile_active = false;
-		}
-		mutex_unlock(&adev->vcn.workload_profile_mutex);
+		amdgpu_vcn_put_profile(adev);
+
 	} else {
 		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -464,30 +509,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
-	int r = 0;
 
 	atomic_inc(&vcn_inst->total_submission_cnt);
 
 	cancel_delayed_work_sync(&vcn_inst->idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev->vcn.workload_profile_active)
-		goto pg_lock;
-
-	mutex_lock(&adev->vcn.workload_profile_mutex);
-	if (!adev->vcn.workload_profile_active) {
-		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-						    true);
-		if (r)
-			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
-		adev->vcn.workload_profile_active = true;
-	}
-	mutex_unlock(&adev->vcn.workload_profile_mutex);
-
-pg_lock:
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
@@ -515,6 +541,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
 	}
 	mutex_unlock(&vcn_inst->vcn_pg_lock);
+	amdgpu_vcn_get_profile(adev);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b3fb1d0e43fc..6d9acd36041d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -565,4 +565,7 @@ int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
 			     const struct amdgpu_hwip_reg_entry *reg, u32 count);
 void amdgpu_vcn_dump_ip_state(struct amdgpu_ip_block *ip_block);
 void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
+void amdgpu_vcn_get_profile(struct amdgpu_device *adev);
+void amdgpu_vcn_put_profile(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 3a7c137a83ef..904b94bc8693 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -116,7 +116,6 @@ static void vcn_v2_5_idle_work_handler(struct work_struct *work)
 	struct amdgpu_device *adev = vcn_inst->adev;
 	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
 	unsigned int i, j;
-	int r = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
@@ -149,15 +148,7 @@ static void vcn_v2_5_idle_work_handler(struct work_struct *work)
 	if (!fences && !atomic_read(&adev->vcn.inst[0].total_submission_cnt)) {
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 						       AMD_PG_STATE_GATE);
-		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (adev->vcn.workload_profile_active) {
-			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-							    false);
-			if (r)
-				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
-			adev->vcn.workload_profile_active = false;
-		}
-		mutex_unlock(&adev->vcn.workload_profile_mutex);
+		amdgpu_vcn_put_profile(adev);
 	} else {
 		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -167,7 +158,6 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *v = &adev->vcn.inst[ring->me];
-	int r = 0;
 
 	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
 
@@ -177,20 +167,6 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 	 * the delayed work so there is no one else to set it to false
 	 * and we don't care if someone else sets it to true.
 	 */
-	if (adev->vcn.workload_profile_active)
-		goto pg_lock;
-
-	mutex_lock(&adev->vcn.workload_profile_mutex);
-	if (!adev->vcn.workload_profile_active) {
-		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-						    true);
-		if (r)
-			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
-		adev->vcn.workload_profile_active = true;
-	}
-	mutex_unlock(&adev->vcn.workload_profile_mutex);
-
-pg_lock:
 	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 					       AMD_PG_STATE_UNGATE);
@@ -218,6 +194,7 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 		v->pause_dpg_mode(v, &new_state);
 	}
 	mutex_unlock(&adev->vcn.inst[0].vcn_pg_lock);
+	amdgpu_vcn_get_profile(adev);
 }
 
 static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
-- 
2.49.0

