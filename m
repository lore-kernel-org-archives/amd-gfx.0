Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED43ECA0ED1
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 09:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9447110E825;
	Thu, 14 Aug 2025 09:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k073dvTi";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3EA10E827
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 09:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8p9zuvFuj0lL+SYKn1uHj5sqi7M3tq+7D0Ncz4gdMRZj08d7wvHYEWDlcHx/jEpVdhSAwLlAWzsi23SNQsluLww65xvVsXRZVLbtcAJSRWDaPPsmztsi7VEO93vTQZqz8NlQndq2Ze3iSRHx2ocgD3YaIUVlMmAvyvvhtFBo4SnTKFrowBQfxnUj2YuNZVsxzV9pz/8MZtHMSStni+Ww4oEc0i/NeNpGWX1bWfudvFPyEsmCZNSkjObvAmbePWqW3TRNCUb77Jn1ksr19g3Txpv2YTiJyU+FWfKK00IQIijUn6YSZe7yj/N9PuvtPiE7Kkja6gmwXJxnEkSUZ6ERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcgJur4BFgc8EVbTeEx/NxEKeG79zrVEUOBnPXxf7/o=;
 b=ZhhdDQl+V8+Ui3R2T4K3N2ssadqhbjsyTNLWiKLGhej8EzzWyVVQtwr7mFh/seVL6U7SLvpN5a7q9J8CEP2zbYc3VQ/CCPeVr0wSdx5iDFkyOf6xFk64vS3JWynbXP/cofaVmaLt1ApQdtjsAN+VShl9Pn1OUUlBcOZrOPm7cAlJ5YGwGvLP6vYymHHtLK468dNeEguknchae66NshaUHLPNbL86UoL5lFcDeC7Xc+tlQTgPEOIosElEsTthw3WNiqR62Vk2tfBSiUP6RmwpfwG3kVdk6T8cfvZUAzDNQo2kS0lNOcSI32JgFM4KLLbdCMVeYR7+5nM/XD3W7p6nxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcgJur4BFgc8EVbTeEx/NxEKeG79zrVEUOBnPXxf7/o=;
 b=k073dvTi0vAHP03xpOmZV1aDyzFEwUuH1w+IHZdDDuklLqdlv6XVe/1kVRbEHMLljoLT0ugqK/rExXnR5FU1+j+/IxE1E7s1wZ8fKHi4+SzGbv5eApoqFYEz7eKuXta2k/5s6zbm6AEnTxzotNKxb47P+spr++Dwvu9lsATqxIA=
Received: from BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::17)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 14 Aug
 2025 09:11:27 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:10c:cafe::69) by BN9P222CA0012.outlook.office365.com
 (2603:10b6:408:10c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 09:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.0 via Frontend Transport; Thu, 14 Aug 2025 09:11:26 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Aug 2025 04:11:24 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>, 
 Wu David <davidwu2@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: Fix video_profile switch race condition
Date: Thu, 14 Aug 2025 14:40:32 +0530
Message-ID: <20250814091032.1354857-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 863ee71e-2269-42bf-1a71-08dddb128c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjZONEhpczZrQjRNdXVWYm5VaTR4OWd0TnJET25xazh6bVNvVjdPYm1ySXI3?=
 =?utf-8?B?S2luVG1IcWhtVEFka25DUGc1Yi90ZVFZdlpkRjJnNTJuK1cvSENvdGRMeEpU?=
 =?utf-8?B?N0kyMEx4dGl0cWZ6U1NnNllCbnNyRDY5TzNLVWMwa0toSXpVWFAvQ01NQndK?=
 =?utf-8?B?ZzNKQ3UxenI1NTVUQ2YvZUdtOFhEeG5EK3UzbHVuWkhEL3pnV0srZ2F2cjdx?=
 =?utf-8?B?OGhabHpxYmhERmozbDNBeG1yWUJOTk9rWHc5ZTlYOUdncmRkNDV0ZHBIUFZj?=
 =?utf-8?B?YnNwNi80Zis0TXZjMkR5ZjZ6YW90Ump0cXVJazBNWnVvRHZBaUF4b3RYeXVp?=
 =?utf-8?B?SnRLV092ZkRRTW41UmV6WjlUN1dxTFlZK2pEMUwvdFBxQUNFc1U4Q1g1Wmd3?=
 =?utf-8?B?RU5JenVFYWtEVW5FWVI4bFNkUlBJVC83NElONFQ0RjZBOGk5b1hUS2RBcmc4?=
 =?utf-8?B?ZTU1Z082aUwxN2VCaGZlaExzQkN2L2I0azU2R3VUdmI3cWRkVkt5STVmMlY5?=
 =?utf-8?B?M01RTk5XRVRGSElYS0R6YkdpTWRvRFYyaER1bFpZUlBMYituTTNiWGxmc1hj?=
 =?utf-8?B?QnlkMFVKL21oVS9tUUhyYXkvR014UVpXZlVQYWRHazBPcHRsbDNUcDFIM1lR?=
 =?utf-8?B?c0xIY3ZKWHZjMmY5TGsxaHlBYW1idE4zcmpoVTJ1azdGS3p1MjF5emV4TElv?=
 =?utf-8?B?SDhuVXVCTzArOXJ0YVpNdTNoQkgyTHcvVk1zcGgrYXpqQWZXM1duRlBXRG14?=
 =?utf-8?B?N014Z1dTbUl4eFV0SEFrM09FRkMvNWw4dnQ0MFM5Q2htNitnNHNKMUxMK1pv?=
 =?utf-8?B?SyttMHhrbEpKdVVlaDdSMU95V0lTeHpuNklGWDA0YlNyNytveDBWN0lqL09l?=
 =?utf-8?B?V2lzNWo3bnNzbkd3WWNTOEIxajBLYVZXamppeFVJcTBncE1ub2RKTk5kRC9x?=
 =?utf-8?B?MEhZMVdPam5pdG5HaXBvL2NDVGV3dllWVzY4elhvY0U1VDNuNWJHYjYvSnRo?=
 =?utf-8?B?cytPV2xWbG82ZXFvY3kxeXNNeFg1RUVqMmp4R0hQMDNOOVBTanJNRW5lMFNm?=
 =?utf-8?B?TG9oUUJleDNqYVpVZFlMbVlhZVpMNDlZd2Y2NFVkZ2prbndjd3laMVB3VXd1?=
 =?utf-8?B?a3g3WThXdTB3aEZkaUhRRnFzYlFRdGFJZGdTM0pibnQrMzBUL0tEeHdPWGor?=
 =?utf-8?B?VnltMzltNEtneUVLVWtTbFN6KzluK3BNbUxZS3JJRG5DMDFlMHFZTXM4WW1L?=
 =?utf-8?B?d2V3eU9BbFFubTA2bUJ0M1BhcjEzQnNleDl4WUJQM2VFS2pCUXoyeHQ4a1Q2?=
 =?utf-8?B?OS80Tzg2RERiZlBKWjVmcld6T1JJb0NNcENGekEyT0QydXFac25CaU5ORDkw?=
 =?utf-8?B?K0tnT25KOU54QkEzclJmWlF0TjZwL1hKUjk3b3RDc2J0aExEV3hWNExmVmdm?=
 =?utf-8?B?ZFJyZnRwL0hoYXM3OGNXcEJ6RlpCbStBYXdkTHJteVM3WVJxcTJRaUVPNUFz?=
 =?utf-8?B?UHo3UlJES3B6eDJhVHhDeUcxaUpvb0ZaQkZQSFF4UE54M2ZLWXFNTXZMdEdQ?=
 =?utf-8?B?eTJycHIwOWNadm5ZK2dIVUJYcU83NGp6SU9PQnY0SE9Tc095akNDN0drZ25l?=
 =?utf-8?B?KzNoOG1POEgrcnB6SXQwWFZFWnVXcU5wUmZIWUl1elg1KytWOUttWmJWRWhF?=
 =?utf-8?B?NmJNUWt5VWg5ZFhOMFRnckNOQVJYNmhrOHdaOGVlTXNIbkg1U0piU01JZGZF?=
 =?utf-8?B?UGM4QmhEc2hwYmQ2dEc5QjVHS2taVzQzc3ZXS0pWMjJ1Y2xWZmRmUFBESjAw?=
 =?utf-8?B?YUI3bkRXTDRycHJjN3JFNk9GbzZmRU5kU2UrREVDeVNsSVNEVUNDT1BWYm51?=
 =?utf-8?B?TkpuemZOZVlIMWhHSTJLOW5GTVlhOU5iRDROdk51RXhHNExTRTRHa1l2Vzdu?=
 =?utf-8?B?RHA2VGowMWFqTG5aU2o1dHNOVEl5a285dDNzOS9NTVRpeG5RWmRYWHFXZitP?=
 =?utf-8?B?bHpZYjRINkJOUzNzSmE5Qnc2SEhLZWQ1dnNub2QvRFVXWm5ucEJxV0FyL1Ns?=
 =?utf-8?Q?gPNkO3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:11:26.7184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 863ee71e-2269-42bf-1a71-08dddb128c62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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

v2: (David Wu)
 - pg_lock is per instance it doesn't help solve the issue.
 - protect flags also with global workload_profile_mutex.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c18..b677b287dd49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -447,7 +447,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
 		mutex_unlock(&vcn_inst->vcn_pg_lock);
 		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (adev->vcn.workload_profile_active) {
+		if (!adev->vcn.workload_profile_active &&
+		    !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->vcn.num_vcn_inst))) {
+			/* video profile is active , we are holding global workload_profile_mutex.
+			 * it is safe to check if flags are 0 here and be assured that all instances
+			 * are off, since no other begin_use paths can be holding this lock now.
+			 * so off video_power_profile and update workload_profile_active = false
+			 * since all vcn instances are inactive here.
+			 */
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
 			if (r)
@@ -470,24 +477,23 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	cancel_delayed_work_sync(&vcn_inst->idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev->vcn.workload_profile_active)
-		goto pg_lock;
-
 	mutex_lock(&adev->vcn.workload_profile_mutex);
 	if (!adev->vcn.workload_profile_active) {
+	/* If inactive proceed to ON video_power_profile and update workload_profile_active */
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    true);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
 		adev->vcn.workload_profile_active = true;
 	}
+	/* Holding global workload_profile_mutex, so none of the idle handlers can access flags.
+	 * and cannot OFF video_power_profile at this point. Can safely update vcn.flags to
+	 * indicate active vcn instances, which is visible to any idle handlers who later grab
+	 * this lock and check flags for any active vcn instances.
+	 */
+	adev->vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst);
 	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
-pg_lock:
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
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

