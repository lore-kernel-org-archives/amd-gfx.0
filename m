Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4FDD3A679
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4B410E6BE;
	Tue, 29 Oct 2024 17:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SQyGwvCr";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9CE10E6B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEenudyKuY2CFefttBuKGYf4Gny2xj3jFidPqRYL3yUHz1k1Ul7uR8n6XnJhpOiyaWmqNdqLDbM5XwisW8Uer8GBn2l4EaRLdzFBdaF7uO++17SkpSSdcZ2V+xWEi7UY51ji4PW1LIal8HSos1by+Lusc3AjYPnBgJHFSkYvvlEkPpDRVAbOwDXkEKq8uoPykKOHR4bwRDei+f92wuyPZR8860Jd+hQcyirzTl408+PUGcSvthQM8TDWnzJQP8slC7eAI44GZba9UeApyqx01nfNjBswflcHSrx3T9d3YpMCY3om48glkW2HG8LbpYcgUmC2caFDqzvXsOrKjmJuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH6RIwmAEa7SJwdy8bV0gQaEusBUOBGeVWQPovHYKgE=;
 b=L26SriM5plhWflQNIDdlo93EJ3kUEzR5I0kPYsBALgloVObVViMGkwO9Bj7Bj8EiVwMTCtIeCCaj4cP22JsfmxoEZKE9zd2dP9jh40rlvBjW+Hw9gnDQPhhJcl40kR9sxcb8nPLw2pVe0ZPTA0DSFkiyjIXW9G/zfD2hZkRtzCccPPjGYfIMcz8o8wZTW2z021RHSfCSLKcCEBt8I0Z+RkTkFrqkXOv3DWzha6TPvzWgqut/rgASgZwsSxyTv2/KLy7DTo7ldF3cqqMeKwSQliUjApe6GWqxN/dLznM4Rel38wD1mv22KsI6XlrxzDe9DceGskgRGiaiI3CeByttag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH6RIwmAEa7SJwdy8bV0gQaEusBUOBGeVWQPovHYKgE=;
 b=SQyGwvCrj+ep/FuMOE5/VJE1zJbDTFdubkv7E6SXz4UKYTZT+fUFT8BihtKpDFsXTxZOvuLhL0fd9G67iyU/9e7Sn+5RuBpokxtOVjhEDcbz7iIhpjd6sGKZyF/86Hba2NXq2GlgyqoGIVKQz5wK8MkJY1kgupMXa4r1y/edyqI=
Received: from SA9PR13CA0142.namprd13.prod.outlook.com (2603:10b6:806:27::27)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 17:42:56 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::60) by SA9PR13CA0142.outlook.office365.com
 (2603:10b6:806:27::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.14 via Frontend
 Transport; Tue, 29 Oct 2024 17:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:42:56 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:42:54 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 06/29] drm/amdgpu: add inst to amdgpu_dpm_enable_vcn
Date: Tue, 29 Oct 2024 13:42:17 -0400
Message-ID: <20241029174240.682928-7-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: b392acdd-bf7d-441a-9e9f-08dcf8411f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2RxajE3N2JiTHo0TGlZNXhHRUxxZ1VySUdKRG01b1RFbXdRTCtNTEpZY3lN?=
 =?utf-8?B?RVpLRE15WGc5MWUrY0xOOEZ0SHQ0dDZSdmF0dngvcHBkTmtWcEV3U3krS1NL?=
 =?utf-8?B?enllMTRaTzhnK1lDV3grY0R0WVdYTHY0bVYyRXh3ajhqb0I1WUp4SnpXRE9O?=
 =?utf-8?B?SWJ1MW5pL1NscG53c2I0SklsVHlxL1lkZ0YzTHZNbTVmV25VdHpOaGc2ZnRL?=
 =?utf-8?B?c2dlemlLa0xLeFplUjdoeEUxZDRaZ0p1K29qTnAwaWpJUE9zWHk0MHZ1SHdD?=
 =?utf-8?B?Y1BDcSt1NkVjSENaY1lUTUJlMEVzTjRIU2s1bVBvdXZXczIzMEhoOTZOdDZ0?=
 =?utf-8?B?akpqeCsyMEgzUUZLQzVDbGp4dXhSVzZlMmFXOXNkVVhwNWVsbmxlaXdqSXhK?=
 =?utf-8?B?b21BcEdvSnRXWFBja0RaK2hmc1A5NFMweHllbkxZK2p1NzJQL0NVMWF4Njdi?=
 =?utf-8?B?TjJmYmFHOGFPVkMzQjZ6c0lDcjlRM2NLOUYxQXlOL3NQdndBR1drdTJTSVZn?=
 =?utf-8?B?eThpQzFUZWdPSjJnbGZJclp4VElQMjI0dEd0NFlYMklOSmpnQThGT0YzajBp?=
 =?utf-8?B?Y3pxQitMVTBickFpUXR1ZVBtT0xvM01qT0FxdWpzYW1mN0tNWmFuMENYaGxL?=
 =?utf-8?B?dDJDaW1rRTFYNkJ6UFl5ckcyaGdObkk0YzlDYis5MGpPclVvb1hqZHNCSFF0?=
 =?utf-8?B?d1NxTW9qd2gzTnJIa1B2cDlUYTU5NXJmdHFTZDM3eGV3aE9FTXZqTFlJQ1Vy?=
 =?utf-8?B?S2Q4QU1FalRSQlpBOEhaY1NkOHU3ZFNoZG9idzVqNmoyeHMzTFFjbW92Wk0w?=
 =?utf-8?B?VzNNVXdxQkpsME5JdDJkWUlnT0VONEozcDNVYnhOdHZTV2NrRkoxSnE0ck5O?=
 =?utf-8?B?L055ZG9lRTc3N2oyVk1uUkQzY1E1Um5HV1ByN1NlZDl0cnV0eXlrRjZIWGMr?=
 =?utf-8?B?M3J1NHlwQXpSOWxmck5pMmlYUi9GTVR3OHN2OFBLTzkrSkFDVCtiamVQdita?=
 =?utf-8?B?YWU0NWcraTNnMmlEZGp4Nlpid2QweW9GNEZMTk1jQk4rU0RtZk1EWi9hUE1Q?=
 =?utf-8?B?RW1ndEpIdzkwZmdBWmgvQ05jYmhaUUFrcmlGVmYzSENuZ3FhOG85RHFXeGM2?=
 =?utf-8?B?a0kza0ZRTDZKczltZDU0VldBdlJyWWFyT0J2S2hab3UyazlFODh5Tjl1bzRC?=
 =?utf-8?B?Rm9aRll4UGZLY3FxS040VTgrYjBRT25aNUwwWjdOSWduOXNzZVVQYzFIQ296?=
 =?utf-8?B?RDFGWEh2ZFg1RTJBSmlzdFlEQk1Reng4cmlSSVhidXNkNEszckVBamRaNjZH?=
 =?utf-8?B?d3ZVQmc0OTZjbWJuT2hjUlRHc2hFSi91cTdjTFh4Z2dvRzJ2S1I3RjNBVGZi?=
 =?utf-8?B?eVdudTVUQnQxUzEyeDZHZXgwS3F4WW5laUFaYlBLK3VOWEkrZUNiNHRwTFpY?=
 =?utf-8?B?dkFhRXlZUEJNYTFjSHZPcmpCbkwwR2xsenpEaldob29RTlBQalc0Z2JFaTl4?=
 =?utf-8?B?QVhBQjVTTXFHMkhCWkV6ellWbDRtRzAxZHpHbloxaituendWL0VuMm1jaU9j?=
 =?utf-8?B?Tm5pdWdLSnRUbGxobHloa2JXSWxMMlNILzBaV3ZYajM0UzdhRlI1eTA5Y3Zm?=
 =?utf-8?B?OGhxKzJYRW5od2pSMlp2T1daVUp1WjF2cjVJZzNJVVJVL28zY2JkcmIzUG5N?=
 =?utf-8?B?MWNBUmVFZEowR0RBVFBYWXFneURWSnNtSnVRQ1pzU0tubFNIUTZpNENIb3p1?=
 =?utf-8?B?RndxRFpCYjFvUnJJQTFUR0txTWNiRm9tQm15MG1CYnc0YXpJeWFuRm9xM2xY?=
 =?utf-8?B?aC9kMWE4ZTNNemxHMERjRGpRcnhTUHdTWFA5a29xYTBVMHhITmNiU0k4dE5V?=
 =?utf-8?B?YnJVRDhDQk1TUWZZMksvWVBuQVkrMnIrei9QWkQvc2szQnc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:42:56.3809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b392acdd-bf7d-441a-9e9f-08dcf8411f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

Add an instance parameter to amdgpu_dpm_enable_vcn() function, and change
all calls from vcn ip functions to add instance argument. vcn generations
with only one instance (v1.0, v2.0) always use 0 as instance number. vcn
generations with multiple instances (v2.5, v3.0, v4.0, v4.0.3, v4.0.5,
v5.0.0) use the actual instance number.

v2: remove for-loop in amdgpu_dpm_enable_vcn(), and temporarily move it
to vcn ip with multiple instances, in order to keep the exact same logic
as before, until further separation in next patch.

v3: fix missing prefix

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 12 ++++++++----
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 14 ++++++--------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  2 +-
 10 files changed, 60 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 511d76e188f2..7ad2ab3affe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -303,7 +303,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false, 0);
 	}
 
 	r = vcn_v1_0_hw_fini(ip_block);
@@ -1856,7 +1856,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 	if (fences == 0) {
 		amdgpu_gfx_off_ctrl(adev, true);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_GATE);
@@ -1886,7 +1886,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 	if (set_clocks) {
 		amdgpu_gfx_off_ctrl(adev, false);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true);
+			amdgpu_dpm_enable_vcn(adev, true, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 697822abf3fc..f34cab96d0b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,7 +978,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	int i, j, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true, 0);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_sram);
@@ -1235,7 +1235,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 
 power_off:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 0afbcf72cd51..beab2c24042d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1012,8 +1012,10 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1485,8 +1487,10 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index b28aad37d9ed..6d047257490c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1141,8 +1141,10 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1632,8 +1634,10 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 		vcn_v3_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d87850dec27c..4b836b4935e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1088,8 +1088,10 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1614,8 +1616,10 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
 		vcn_v4_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 6fc52a1bda31..868302d63a4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1091,8 +1091,10 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	int i, j, k, r, vcn_inst;
 	uint32_t tmp;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1365,8 +1367,10 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 		vcn_v4_0_3_enable_clock_gating(adev, i);
 	}
 Done:
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 398191a48446..f0ec8bc031c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1000,8 +1000,10 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1277,8 +1279,10 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
 		vcn_v4_0_5_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 58f0611b8fb4..9f89e152e875 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -761,8 +761,10 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1008,8 +1010,10 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
 		vcn_v5_0_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index d63abcc65948..14a4341d4f0f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -581,16 +581,14 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 			  enable ? "enable" : "disable", ret);
 }
 
-void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst)
 {
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, i);
-		if (ret)
-			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
-				  enable ? "enable" : "disable", ret);
-	}
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, inst);
+	if (ret)
+		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+			  enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index e7c84d4a431a..251b389dcf6e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -442,7 +442,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
-void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable);
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
-- 
2.34.1

