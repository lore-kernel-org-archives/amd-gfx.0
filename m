Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73640D1039E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F062B10E9DF;
	Fri, 25 Oct 2024 02:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UIT7FkRQ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F4F10E9DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwAs1ZdX0Zn8AJJVIpa1pN4uPifCs/3fXPLteVWE0UhHYJVOplS5nhCOKfIVeZjoBc1LFGRWw5mmX5cBHCGAaX46O640kR8QX1FsHELuH8r0WiPMqAmbUO9veAKk9sVEPlXO3k+XhWEF4zaFc8ts6LBOED2ddTGlGbBZMdfVsBkNGMubi7s7bV/kdPDNhEXmbbzYKcMzk3N8IisY2nKJHHXg+OtxY5h17ktDv/RF7G5wUdhyri9CgiD1tMeLAwR6yO8zgA4Gi4YO10CiGAU9pVgpMKNiNT2BLFLspiWLMOatzMajGY/3FgNFRb6Lh0DbORPFpU6Adsff9vcDpq5OKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+geVbY1NY5VPX8qynrmf9w3/46F7NCnHEVj51g6pf7M=;
 b=CboRZvGUECNMWpj0UidRWUKWZTqWeq4ef2WeQlypHUrDwZMwq9il8kuVH4Rn7AOx8GDhuvFDhCSL6MihFnpwTalQ1bbtkCZgzGoAg8I0gp+1UjhkqTSspst8bidosbee1ZXfDrDtT4qOz347MPFVL3uSwDPUwS2KCfxUsfIgiNfvsNLaOphale9fSexzOWLVwPcbVnF3huOfLPjzquozJdetL7GWC/N2Kf53U6Sb7l2EImYCHCmdw6UCHE3wrjQ2LDsq45F0cpqbpaeOO7i5qIj4I2NXWop93Ea7E0qhQlJCS2atXuxppsh8u7fWX6jZXmdAH412HT75ELQtNBD9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+geVbY1NY5VPX8qynrmf9w3/46F7NCnHEVj51g6pf7M=;
 b=UIT7FkRQSsRrrffoMMgtbr88NLcj0Jm0wD39zIDwgYNDBI+12Ka3U4KLmfdC8wVipoz329WJkfzks0ykYEh0UWr3ApBVPgfRhsCyR4/7dwbVGVavSzKMa4SGLRFhXZcdqX+1w6OT84C7YIM5pRqLS/hEzY37EcDePppXBMCG6K0=
Received: from DM6PR18CA0014.namprd18.prod.outlook.com (2603:10b6:5:15b::27)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 25 Oct
 2024 02:36:19 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::29) by DM6PR18CA0014.outlook.office365.com
 (2603:10b6:5:15b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:13 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 18/29] drm/amdgpu/vcn: separate idle work by instance
Date: Thu, 24 Oct 2024 22:35:34 -0400
Message-ID: <20241025023545.465886-19-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee42792-5134-486a-2ac1-08dcf49dce68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUZmaXdZM0UyZFcwNDllVE0vL1E5dW5wNFFYVnhSMHFsbkxKNG1FQWU5NUE2?=
 =?utf-8?B?TVFIaHBOdkJKakRDOHJpU0g2QWlQSjQwU3lWNXkrQnFPOFVqQnkrRkRjelRW?=
 =?utf-8?B?QTM2MTVxSzFQY0w0d3JqR3R0amtyZ013U3llZmNkV0prSW5NeWtwTytSWW8r?=
 =?utf-8?B?aDlUcytkSSs1b21TMHMwMmd2aUlOckxkc0p6STQ2VjVuSGs1QVJmb1UzTFVM?=
 =?utf-8?B?eHAvVHhTU1NnbC90dVlrdUdhQ21IeW42OW5wRTJmUU9wWWJUR2pFQmw1M1FN?=
 =?utf-8?B?S1dpamRyTHh0QVpuWC9qaEU4ckJQaXdOK1N4eW9PNm4rd0I2bk9qU3FIK1dL?=
 =?utf-8?B?Y0R6SzBZR2hrZzk5eXlyR3VzY1NRREc3ZDNqa0Y0YnY4YmFReEErMzZDL0VN?=
 =?utf-8?B?TlZVYXN5M0kyMFQ2a2g2em80NG1LOTFmTWxzNGtWN0J6aU5qMGE2ZnhsYVBU?=
 =?utf-8?B?VjhpM1d1OXdJRHZtMnR1eVVHSkNzVGl1VFRqbUQ0MEdlYXlRdVpDb1BFbXY3?=
 =?utf-8?B?dTU1dGtlaTRva1cwTzFIbFRUM2RtUy9RQ1BFdzV3b2NtVEl2dzREdHNsNGNq?=
 =?utf-8?B?NUFweEVCT3ZFdVJhVWttNlNrOWR0SmxXajFkeGkyamJJRXJDUnd6am51ZCts?=
 =?utf-8?B?cHVyTXFYa3lCZFRHQ2NXdVorYmFkS1RlZTV0bExYKzhRTlJoNHcrU3BpYVZ6?=
 =?utf-8?B?VE1pd3h6QlJkaWtRL2NQY2cyb2JVUDdjeGVIQ0hxdUNrVk4xWkg3eFc5UlZP?=
 =?utf-8?B?NkhQWUVRMmNxMmorcm90T3BoZ0dTK2wzRTE3QitVcWlpQjNDc1RrNWl4OG03?=
 =?utf-8?B?dHhYbit4V2J4U25hbnAza3ZleHF0QUlWd3BEa0FYYzZpcXdsZHdwdVVOUHVQ?=
 =?utf-8?B?UjhNNHlpYUdEL2U0UkJvK3hzZ0JYRVRtMXp6OU1jWm9CcWhrMUx5a2NlTURq?=
 =?utf-8?B?ODR5cnlKYWxBQ01mNzJsdm1OQk5QUFVqelRhSkxSQ3h1c3JkWE1qK2VFb2tD?=
 =?utf-8?B?VUt3bCtyQXhiQWVvMTVnVk5RUnlncjVIQXBGaUxwYzVKWEhybzEzeGJEN29l?=
 =?utf-8?B?Smkza21PeFJxaFlIY1hiaFovQ3JKNHFpMmUycGNIQ2NteXhEYjNaNXpwaXJs?=
 =?utf-8?B?dXc4SDlqVnRZUHhXNHY5L1ZwWFIwT0NKVjk1WnhzaHRhaE81RXkxM2IxenB4?=
 =?utf-8?B?TlV0TnpTMmFOT1R3OGNpS0lqZnVSNkF1dFJjcGFmNm1TdENIRDdkUmZrei9M?=
 =?utf-8?B?bklPTjhTa2RNRDhRdXlYcGNDK2ZFRWdrVWhFN3pIY1NBWTRvcjEzbUF6NkZy?=
 =?utf-8?B?T3ZxTXc4am5JTGg5bEt6VXg1MW1sMVJZM3dlRXV5VGU3MmNocGZUeTVrRk5R?=
 =?utf-8?B?ajBUekpNRTQ2OHplV3kyQm1rRUJYaXNKMkxEY2orbGxNbExUZ3JwTmxKQ1Bi?=
 =?utf-8?B?VkRpbXcxUnhVY0EvWVkvVWNNYzR5UzI3OXhxVHJVRk5ZNGoxdFVqLzcrNzVi?=
 =?utf-8?B?VXlSZVZpMEN0Y0FkOVEyZ3dVQkJHNERPTmVDNFRHaUhrcitUd3dPVVlCUG5S?=
 =?utf-8?B?VDF0V1RaRmk0M2YrSjZjNFNiYjU5RVBhY3NRK3dkdTJ3TTZKK2VGVUV6aG4w?=
 =?utf-8?B?L1U5NGlheldSZjZPSGxIZzczb1JnV0hPdHgrMVQyRkxnVG9RZjJHam9lNytH?=
 =?utf-8?B?TGxVdVNvNWJ2M0Y5OHZUanJvSFErNy9lTWdOUE1SOXhCZTQ5OWh1aWEwei9Q?=
 =?utf-8?B?MVVCdEZvb3EyYUVmWDdPT2JGZWJQU1plYk9wRXQ3TG8xeitXOE5LTUpYKzBH?=
 =?utf-8?B?Zmd0Z3VmY3hyazRiN3hvUElEQ0N2TDg0MUE2bnJ2Wk9CS3Fad3JnMmxUNllG?=
 =?utf-8?B?a0hTZnkrOS9WdW0xNU1SYTBqWUFFNU8yMnZzZldjVWdEQ2c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:18.7868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee42792-5134-486a-2ac1-08dcf49dce68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
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

Previously idle working handling is for all VCN instances. As a result, when one
of the instance finishes its job, the idle work can't be triggered if the other
instance is still busy.

Now, move the idle_work from amdgpu_vcn to amdgpu_vcn_inst, in order to
track work by vcn instance. Add work_inst to track the instance number
that the work belongs to. As a result, the idle work can now be triggered
once the job is done on one of the vcn instance, and no need to consider
the work on the other vcn instance.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 66 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 14 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
 17 files changed, 58 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 49802e66a358..3d2d2a0d98c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -118,7 +118,11 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	unsigned int fw_shared_size, log_offset;
 	int i, r;
 
-	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		adev->vcn.inst[i].adev = adev;
+		adev->vcn.inst[i].work_inst = i;
+		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
+	}
 	mutex_init(&adev->vcn.vcn_pg_lock);
 	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
 	atomic_set(&adev->vcn.total_submission_cnt, 0);
@@ -326,7 +330,8 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 {
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	/* err_event_athub will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
@@ -382,46 +387,43 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
-	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device, vcn.idle_work.work);
-	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
-	unsigned int i, j;
+	struct amdgpu_vcn_inst *vcn_inst =
+		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
+	struct amdgpu_device *adev = vcn_inst->adev;
+	unsigned int inst = vcn_inst->work_inst;
+	unsigned int fence = 0;
+	unsigned int i;
 	int r = 0;
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
-
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
-			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
-
-		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-		    !adev->vcn.using_unified_queue) {
-			struct dpg_pause_state new_state;
-
-			if (fence[j] ||
-				unlikely(atomic_read(&adev->vcn.inst[j].dpg_enc_submission_cnt)))
-				new_state.fw_based = VCN_DPG_STATE__PAUSE;
-			else
-				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-			adev->vcn.pause_dpg_mode(adev, j, &new_state);
-		}
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+		fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_enc[i]);
 
-		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
-		fences += fence[j];
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+			!adev->vcn.using_unified_queue) {
+		struct dpg_pause_state new_state;
+		if (fence ||
+				unlikely(atomic_read(&adev->vcn.inst[inst].dpg_enc_submission_cnt)))
+			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+		else
+			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+		adev->vcn.pause_dpg_mode(adev, inst, &new_state);
 	}
 
-	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
+	fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_dec);
+
+	if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-				false);
+											false);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
 	} else {
-		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+		schedule_delayed_work(&adev->vcn.inst[inst].idle_work, VCN_IDLE_TIMEOUT);
 	}
 }
 
@@ -432,7 +434,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&adev->vcn.total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
+	if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work)) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 				true);
 		if (r)
@@ -481,7 +483,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 
 	atomic_dec(&ring->adev->vcn.total_submission_cnt);
 
-	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work, VCN_IDLE_TIMEOUT);
 }
 
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2b8c9b8d4494..2282c4d14ae7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -279,6 +279,7 @@ struct amdgpu_vcn_fw_shared {
 };
 
 struct amdgpu_vcn_inst {
+	struct amdgpu_device *adev;
 	struct amdgpu_bo	*vcpu_bo;
 	void			*cpu_addr;
 	uint64_t		gpu_addr;
@@ -301,6 +302,8 @@ struct amdgpu_vcn_inst {
 	enum amd_powergating_state cur_state;
 	uint8_t			vcn_config;
 	uint32_t		vcn_codec_disable_mask;
+	struct delayed_work	idle_work;
+	uint8_t 		work_inst;
 };
 
 struct amdgpu_vcn_ras {
@@ -309,7 +312,6 @@ struct amdgpu_vcn_ras {
 
 struct amdgpu_vcn {
 	unsigned		fw_version;
-	struct delayed_work	idle_work;
 	unsigned		num_enc_rings;
 	bool			indirect_sram;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 03b8b7cd5229..8031406e20ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev)
 static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct	amdgpu_device *adev = ring->adev;
-	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
+	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	int		cnt = 0;
 
 	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 1100d832abfc..aed61615299d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -150,7 +150,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 3d72e383b7df..28a1e8ce417f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -211,7 +211,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 200403a07d34..f83c7a58b91a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -164,7 +164,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 0a4939895b6a..568ff06b3b6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -195,7 +195,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index d89863213ae7..3d57607bb3f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -219,7 +219,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 09eaf7f07710..124cb15e3980 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -161,7 +161,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index c2eb187b0a27..f07a5a8393c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -150,7 +150,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	/* Override the work func */
-	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
+	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
 
 	amdgpu_vcn_setup_ucode(adev);
 
@@ -277,7 +277,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 		(adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
@@ -301,7 +301,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	bool idle_work_unexecuted;
 
-	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
+	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
 			amdgpu_dpm_enable_vcn(adev, false, 0);
@@ -1830,7 +1830,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device, vcn.idle_work.work);
+		container_of(work, struct amdgpu_device, vcn.inst[0].idle_work.work);
 	unsigned int fences = 0, i;
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
@@ -1863,14 +1863,14 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_GATE);
 	} else {
-		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	}
 }
 
 static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct	amdgpu_device *adev = ring->adev;
-	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
+	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
 
@@ -1922,7 +1922,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 
 void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
 {
-	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	schedule_delayed_work(&ring->adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 04edbb368903..419ecba12c9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -313,7 +313,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 010970faa5fd..7e7ce00806cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -387,7 +387,7 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 690224a5e783..ca4ee368db02 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -420,7 +420,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 0cc0eb52b54f..ee6c08707312 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -349,7 +349,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index db6f8d424777..2c66a7a4ff25 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -315,7 +315,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE)
 		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 0f3b25d3b9d8..d725c12ffdaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -298,7 +298,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 15620e111d04..3856388179b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -262,7 +262,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
-- 
2.34.1

