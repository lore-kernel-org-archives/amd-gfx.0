Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D47CA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 11:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E9810E88C;
	Thu, 14 Aug 2025 11:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="svMeG2sa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043DE10E876
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 11:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taSPU6U+oNWvKkAmra6/yQCWRlotDdXVwAHSy/bchWmcIHA0+JZpSTxtvfre0pst+fsYhUZ6/GWSJ5+eho8boddigCLqWG5kE/yZsdHT2TfCRNgaq0qYG0b+3OgEnjN5BpqbEgr4uGnA5nXXXO+/eRqO8GRk+L3CuZ2QeE0OFn3FSt+9kkLtUodGgk8J4eRZwWsVjkJN061G1AokOMqOS813ASg44tDzLfJeLDqu4ERG/bjAEPoVHWLly8N9tWa/U8iltTuzXVm8d5plyEHXhkk0N/y0thIKsS71Zd5/myiY42jTiTO7YXxUshZkb+jlldbdUmVC8ektYFCq/HETdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiezuK2bEyenEh4R9iDw6shhB+NVCFsE9mSaot+jPTE=;
 b=vDubjMYo77FXp+Tp/7N6XcoTnljtr9rx4XbULjcNZiM6tEDminYLftNgbsM1F6yhXIJr0+NpEZA7Rd+yKYbg/br84MfUsCNFxVGSdGOFjYI9Pn2nQDxExRsKURmpOjHo5qzvdI+WHQehkOndp+uCkC8Jr92XJYDMKVW9z2YybN92zUyQEM2IKwq94OW/dKc5Tip5IxFFjJHMWdha26MR7kLN+ZDG6OGITcRkOGS4uJOtrc47mtaC+RHN5ZiaBZGWd66+67dO5wLkxbJNFwy5PhPvfa22V47Go8FI/U4dCuf45r15zhI/sUeSlWHU7Qm349evKt8HnKf/YO/5qXJ+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiezuK2bEyenEh4R9iDw6shhB+NVCFsE9mSaot+jPTE=;
 b=svMeG2saZEcumE/zR+c7AfGieeHkNHajEeoBXyDXzC+VnyxvFriyZxM8OGGxUcsClTIqYKUNDSwbgBidBgXC3D0T/riFsubXUa3+8zZWofjRDZUddSfQuIRx9IE/gp2IVbEMf8+GWVaS3CJp9EnYZ9U3DIvcMBFmals/R6boWRQ=
Received: from CH2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610::14) by
 BN5PR12MB9537.namprd12.prod.outlook.com (2603:10b6:408:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 11:53:05 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::11) by CH2PR05CA0001.outlook.office365.com
 (2603:10b6:610::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.4 via Frontend Transport; Thu,
 14 Aug 2025 11:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 11:53:05 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Aug 2025 06:53:02 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>, 
 Wu David <davidwu2@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v3] drm/amdgpu/vcn: Fix video_profile switch race condition
Date: Thu, 14 Aug 2025 17:22:53 +0530
Message-ID: <20250814115253.1380290-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|BN5PR12MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: 51130e37-66b9-4a09-2407-08dddb292161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmZrbGFrcGNDV3FVOERVcVcvL3ZvNW5HS3JPekJaNUQ2Z1dSdE9rdWFJNWtC?=
 =?utf-8?B?bTV4eitXd0VnMy9WUGZ0SkpIMFhqL09xb2NQQUsyeGRDZU54MUtNOWFoMVBI?=
 =?utf-8?B?cjVwbUt2VDJPVGJYSlh6elpYZTBMTHJDUnRTMkpZczJMa1k4ZHNQa2NxL2ZW?=
 =?utf-8?B?bmdaMjZYZDR5NTYvZENwVVN6VlJFR01VYzc5T3IyaHFjdFhLZkdWQVZYYlZV?=
 =?utf-8?B?TlBTWGFWRE1HVnhnUy9JUW5VRW1YMExTSjJMT3I3MlFyM3RDcGRyc2RWTnRu?=
 =?utf-8?B?VUg0OFJqaWIxVjRxQmxMWUZjNklDeCtud1RBQlVYZXpQUmVKRmN5ZHU4OFdx?=
 =?utf-8?B?UUw4Zml1aE5mS01UVDRjM1RRaE9meitIUDNpdmxjMU1UaWRuZm80Q2RQeldG?=
 =?utf-8?B?YUQzRmxaNHpYbWkrNWNWVHdGUSs5cXJOV1grQzNhMXBmblpOcmw4QzVNMmFR?=
 =?utf-8?B?ejZ4UnlocW1XRHNmS1AraHZlcVZJVjBRb2l6a3MwUmhPUEZJTExxMlpzRTYz?=
 =?utf-8?B?c1VtbXZsaUNtYzFKVzFCRzJPT1RsKzJRU1QvUW8raWxRMGsrTk1JYXhQbkE1?=
 =?utf-8?B?Wk01aXRUZDBHeWR1S2orNFJMQjBBTWFIaDBST3h3VzZUL0ZqR3pSTnBnMmN4?=
 =?utf-8?B?RllldWlMdnBLc3p5VlQwQXY1OUFyTGxjekhwc0ZxWW9ZaWZVRWYrTnlqb2pC?=
 =?utf-8?B?VzduejVkcENCZkxkR0NZSDBPZWR5TEZ6WmFoZ3dpb3FZQ09BZmpkTnhDRDll?=
 =?utf-8?B?VmQ5VHVIa1BUaHVHWVpxQ1hUSG5mNi9NM0FtNVNuUlBtUEpYWkIzeElFbjhS?=
 =?utf-8?B?blYwQ3ZSUHlUTStTOURrMy9qanFwc3lNckdjUWFOcGhTN3VqYk0zYWRLblhy?=
 =?utf-8?B?Qm9kOVhIeFl2RCtyZkRTSTJiS0kzdnpVSmY3RStxbXVVUjZhOEZOMDN0ZHFl?=
 =?utf-8?B?Uy9nSXBsR0lkeWN5YkNNaTJwTVFoREVlMjRna1hQblZDZm92eHBvL3d6NHI5?=
 =?utf-8?B?S2RsQXlITzAyRDNmMmJWdjVWdWM3cjJJRkVYcDR3Q2NIVEdMM3pwbTZrSVov?=
 =?utf-8?B?dGkxeGVmL0JPYkh3d1FPQW94cWNLSXRWd3hkcTI5dE1CSldsT1BpdUFUaDNO?=
 =?utf-8?B?L3VvbGxSSlJRZlk5OTNTL2tvZUdoTTF1L3hZWWhmdTIxcWNiNUM2KzNsVUpz?=
 =?utf-8?B?aFhVS09Qajc5ZjNQSlVyVWJqQ0VxbjFBcldvUTFacEg4SzlReXhuWHhLVi9v?=
 =?utf-8?B?MmlMcUxVUmtMcUhDTndBTWl3WkpNVzN1MWIzTlJ1dmg5TkJjSFc5WDMxSWJP?=
 =?utf-8?B?U1FCVmpsWDIvV1d1YXhJd1lMOWQ3cHZNcGphbU5SeFpLL292akxTUG1CejA5?=
 =?utf-8?B?aHc4Z1lvMkxsVHJQeThRRTRBRU5lZThDR1VyNlJCSGZYSDJwVlk1WXNiN1or?=
 =?utf-8?B?UGlNLy9WTU9raC9nWjNiekRlTVhwU0I4VlJIcFN3M2lwQ29HNFl0SHRQeTda?=
 =?utf-8?B?V2hFQUg0d2lNZlZxR0ZmaXEvMUxzNXpoZFRDcnNPV0FaYU5jM05jUkNrekI0?=
 =?utf-8?B?WGlHeWErV2NqWVYwbVhBSE84cWhUQ2tyUnR6SHkwVDRHY0F2cWVablBnNnY5?=
 =?utf-8?B?VDNNaDc5eUhDcDZlQk4yekNxWk1meXpDQ1drNFBkOG9EeWE1TjVaSWkrWjJC?=
 =?utf-8?B?UFBHN3RBUENTS3YvdHVvaGNzeG8rMWhXMFFNRE9ST0wyV0NDeFhjVms0YTVY?=
 =?utf-8?B?TkMyUUhOeGczMmJkeE02TTd0OUVzdldSNDg3Y3ZvOGRLVFZ5S21kOXRmZGlE?=
 =?utf-8?B?clFEaGdZRzVlSU95WmtsaVBIL1A2N1RwWUFFV0tCMkJYMlFZTG5qbmNySWpE?=
 =?utf-8?B?WERWUmZUUFlpdG9MUnd6TkdjdE9abi9pY0JxQzlsVUwxVFAxSFd1aWRrVnBZ?=
 =?utf-8?B?R0NLUzJaK1p5djN1alFxRG5kMFZmN1RZMGRWODRUN2RMVW56Rkw4aGZnN2Fl?=
 =?utf-8?B?ZStHRXhDSUdyUXhRR0pNR3BaU0NNL0QyRFA1djRMaU5icHRGNC81MFEzbEcy?=
 =?utf-8?Q?5T51Zh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 11:53:05.6074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51130e37-66b9-4a09-2407-08dddb292161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9537
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

v2:
 Pg_lock is per instance it doesn't help solve the issue. (David Wu)
 Use existing global workload_profile_mutex. (Alex)

v3:
 Use per instance dpg_lock to protect dpg state changes which
 need to be protected agianst concurrent use among users of
 one particular instance only, global worload_profile_mutex
 need not be used to safe gaurd this and drop pg_lock.

Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling")
Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 14 ++--------
 3 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c18..fc61d8875502 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -134,7 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 	int r;
 
 	mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
-	mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
+	mutex_init(&adev->vcn.inst[i].dpg_lock);
 	mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
 	atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
 	INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
@@ -290,7 +290,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 	if (adev->vcn.reg_list)
 		amdgpu_vcn_reg_dump_fini(adev);
 
-	mutex_destroy(&adev->vcn.inst[i].vcn_pg_lock);
+	mutex_destroy(&adev->vcn.inst[i].dpg_lock);
 	mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 
 	return 0;
@@ -419,7 +419,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	unsigned int i = vcn_inst->inst, j;
 	int r = 0;
 
-	if (adev->vcn.harvest_config & (1 << i))
+	if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
 		return;
 
 	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
@@ -427,7 +427,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-	    !adev->vcn.inst[i].using_unified_queue) {
+	    !vcn_inst->using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (fence[i] ||
@@ -436,18 +436,18 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
+		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
 	}
 
 	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
 	fences += fence[i];
 
 	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
-		mutex_lock(&vcn_inst->vcn_pg_lock);
-		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
-		mutex_unlock(&vcn_inst->vcn_pg_lock);
 		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (adev->vcn.workload_profile_active) {
+		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
+		adev->vcn.flags &= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst->inst);
+		if (adev->vcn.workload_profile_active &&
+		    !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->vcn.num_vcn_inst))) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
 			if (r)
@@ -470,13 +470,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
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
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
@@ -485,12 +478,14 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
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
+	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
+	mutex_lock(&vcn_inst->dpg_lock);
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
 	    !vcn_inst->using_unified_queue) {
@@ -514,7 +509,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
 	}
-	mutex_unlock(&vcn_inst->vcn_pg_lock);
+	mutex_unlock(&vcn_inst->dpg_lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b3fb1d0e43fc..54cc7646001c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -320,7 +320,7 @@ struct amdgpu_vcn_inst {
 	uint8_t			vcn_config;
 	uint32_t		vcn_codec_disable_mask;
 	atomic_t		total_submission_cnt;
-	struct mutex		vcn_pg_lock;
+	struct mutex		dpg_lock;
 	enum amd_powergating_state cur_state;
 	struct delayed_work	idle_work;
 	unsigned		fw_version;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 3a7c137a83ef..4bd0ca26a5ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -147,9 +147,9 @@ static void vcn_v2_5_idle_work_handler(struct work_struct *work)
 	}
 
 	if (!fences && !atomic_read(&adev->vcn.inst[0].total_submission_cnt)) {
+		mutex_lock(&adev->vcn.workload_profile_mutex);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 						       AMD_PG_STATE_GATE);
-		mutex_lock(&adev->vcn.workload_profile_mutex);
 		if (adev->vcn.workload_profile_active) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
@@ -173,13 +173,6 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 
 	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev->vcn.workload_profile_active)
-		goto pg_lock;
-
 	mutex_lock(&adev->vcn.workload_profile_mutex);
 	if (!adev->vcn.workload_profile_active) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
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
+	mutex_unlock(&adev->vcn.workload_profile_mutex);
 }
 
 static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
-- 
2.48.1

