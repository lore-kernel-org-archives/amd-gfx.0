Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA80DCA0EDB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 20:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C82A10E641;
	Tue, 12 Aug 2025 20:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qGkRqpx2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0A810E641
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 20:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcktSeGSVzfljozQfG9siNsaq+lMK5dyp5lTkEyrPXz3/d7S5IjDKW1bjpmRcKxWEkmKT8j7n8P3T0BarJOlGmgnIAKBYOzy0BBmM2/S2c/owbNNbD4eSEOECtF1BzP9A2l1THOJcypRK8pNMtaQlmngFr9AtqwdpMHUuVbr1QiFQK0ggyOf3A9wzi9igp9rye4p1h+216oJa/GIqDvtE1mQvo7xkcZF28VpnFUcwKEELU26mvqct4SnCwMNm4L0WRSLmkfLUKmhLJpRvJXILyYH4csQ/6oVy7BYBK8xRyaGToNwSJAd4JzbPBKiaLMNRA1bdHEtb9IsksmVFj5DZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kX6iuNo7X34xeAnWhF98ErlqdyuVfrUUU8qX/rTkZ7k=;
 b=GHPiVjNNAKxLcJkTV6SaWWSgrF0xkqb/3Rn9f4ser5nc3m1O5F1wcCvXkTkNWEHOx8FZmZCI+jZ+1I4g3uvjGrnxrWGkSFAspxI2+HAv5C9G6CRD5TBPu5glQsBMzm5RoW7RMciSFJr8VTm/N/jYVqz3gbsd+vFlyyxjG1reVs0AGNrImMp7knmgPywX6GUUQt2fm9KbFbPJnJeLL7rnWRcwL1n3H9ednptmKwunlOokfJ3WMwxg2JMkvAGqsr1+ii96NVEjF04W/CfnQD9zQRwK8Uok+ImF0LIwV/piKf/kMJb8JEJzxFmDU5vLpO3tUOCyffNVLWsJ4NFY8I6qRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kX6iuNo7X34xeAnWhF98ErlqdyuVfrUUU8qX/rTkZ7k=;
 b=qGkRqpx2mBZ8t9jKiPsMllBtBMfTPYlAwPqR+dkn12miT79Bil+Yx+/yxs3jkYXT+H5E3m+koxW+T97r1OKUjo7uEJp23klT+1zWFl6+gcUz7AMn/hu6JFGTlI+jtPUfJ1u0SCImMoPAJi8zTA1VAgOGP4eWPbmY4+XoeNQ44XI=
Received: from BN0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:e7::15)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 20:58:31 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:e7:cafe::e7) by BN0PR03CA0040.outlook.office365.com
 (2603:10b6:408:e7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 20:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 20:58:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 15:58:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v2)
Date: Tue, 12 Aug 2025 16:58:16 -0400
Message-ID: <20250812205816.1773798-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 736c9041-c2f2-45ae-95b2-08ddd9e2fdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UwPr7kTG4yAHQgCAVVelJ92/3ZnDpPNdNcaQmeQBmdPRN5x6QoZYxSaN48y8?=
 =?us-ascii?Q?+2ogtTDXLUSrADPhn7Vl7GYdjZSdBtAtf+GBVup9GhSEgCF7CahsBsgV/a3g?=
 =?us-ascii?Q?Rw+2VcwdoHx9SoPrkV6yGDth1DIQdfpZj5qQarheCjq1xI064X0GZSKQg840?=
 =?us-ascii?Q?RKapkHgDITJ1Q+h47jHiRZUK2nU9NP46rW2NYVBf5/XJElDTj1335KptsL/C?=
 =?us-ascii?Q?WdOgXQexmrkJxicWYrwebXBOLij4uxi6Uecqxya74JclQyzlxf3T2OeBP1/V?=
 =?us-ascii?Q?DzfJRUyKNz/201z5DyUfdRfPbfKCp+qEfexzNP08rPQyuoy3vp3gH4qIa5MU?=
 =?us-ascii?Q?0UutO72Op1WwF8gItnmkANal4hpYkwqyiOoahT6x6pHmHXIlBr2lHRJRw741?=
 =?us-ascii?Q?FUD31h07YninItXiwuSYheI2hE2yZtGbXB91+Cg4uZIz6MOfn7VSVLnODyxQ?=
 =?us-ascii?Q?ZwK7RynNTKRo2+lZigMp1BuEt+iA7iwVILd/W0Uy8mGIdo8nQyFo7WSJI5AL?=
 =?us-ascii?Q?YkeNmk8V6lUtIN5N5VEb7b4LEQrfNer2O+ivphDvQBsujcfdz7HlSNBAdQpZ?=
 =?us-ascii?Q?uGPDsEsWBNHjNZ2R40i+Nshyl4Sp9IHu66YaCAmKC61BznPu/46XNsYCRSk8?=
 =?us-ascii?Q?kSjwy5whQ6IN++o1baUaHO4IGYV6ENH563yfVb/ks2iKAK+14CNbsvRmUR+F?=
 =?us-ascii?Q?1JqI9D7fpZx1Dug/d46fCIG+Wb7PKOSavuW2LWH6Da2OOclfJ0CDsbD+LakO?=
 =?us-ascii?Q?MafRHSmxzhny5QQI4pKGCy5xehXxnj1vEFtdf5J0z51UNoANvR1T7VzNJuvK?=
 =?us-ascii?Q?OeYNX2NxC7rES1ozlfTxzuAYL6Dn0fW4unnGn0e9GHu09FJgcc712LvHIGg8?=
 =?us-ascii?Q?358naDTayozW8Z86HsAZ3ij4rzIxo6APmmAqYsml61LMR0+VB9DEUr1fMwH/?=
 =?us-ascii?Q?vyjuhsmybpbSdoV3x8omUZnPgQSZ0eKUYbCtNEWrWI1j+1asjV1NH8m9W93h?=
 =?us-ascii?Q?J6zQ2wG1zd7ReMcopuinezSK+vTb8wormRn+kz1UNJB8hRgQTf7IZoUlSLY7?=
 =?us-ascii?Q?RztKI9zsnn11HekvhEmx73lhlMcPZg/pH6dxRvCfR02iF6Wip8ZFc9Zc3VVq?=
 =?us-ascii?Q?lNeLUPXGuHWfb+MLk83ld9P+A6rP0r781X6vpRE14IeciyL4aggCKorSfCLj?=
 =?us-ascii?Q?G6GK74dQXuNPFzSsaiZERSO3dr//LrO2/Fideu4+X92K52P0W+DH94ekIKo/?=
 =?us-ascii?Q?Czofgd4bQM5yweozfpXNXwlikFYXAqgxatK9DwVdCN1iMrTcFAYA4as9AXWU?=
 =?us-ascii?Q?Seu9PZ6ud0ecuzw/NnsOdwRIkooRpQ2ff56IAWQsjh3YebOHKMvQqmX9N2vF?=
 =?us-ascii?Q?FwRJq6P/ExGicLnK6nsYGV5WV+AwMLtAENjtGfGuT3/ONz07698PsCSDC4CV?=
 =?us-ascii?Q?8bM1/857yv8imVJjwMFjEWKrgAdASBnlkb1A3VQsduP0ysP7wjlMrUSBCpjq?=
 =?us-ascii?Q?ALsARDon/RCwHIQQeSjGN7jW4DzYpDLJLoE+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 20:58:30.2676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 736c9041-c2f2-45ae-95b2-08ddd9e2fdf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
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

If there are multiple instances of the VCN running,
we may end up switching the video profile while another
instance is active because we only take into account
the current instance's submissions.  Look at all
outstanding fences for the video profile.

v2: drop early exit in begin_use()

Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling")
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++-------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c184..fd127e9461c89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -415,19 +415,25 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	struct amdgpu_vcn_inst *vcn_inst =
 		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
 	struct amdgpu_device *adev = vcn_inst->adev;
-	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
-	unsigned int i = vcn_inst->inst, j;
+	unsigned int total_fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
+	unsigned int i, j;
 	int r = 0;
 
-	if (adev->vcn.harvest_config & (1 << i))
+	if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
 		return;
 
-	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
-		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
+
+		for (j = 0; j < v->num_enc_rings; ++j)
+			fence[i] += amdgpu_fence_count_emitted(&v->ring_enc[j]);
+		fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
+		total_fences += fence[i];
+	}
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-	    !adev->vcn.inst[i].using_unified_queue) {
+	    !vcn_inst->using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (fence[i] ||
@@ -436,18 +442,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
+		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
 	}
 
-	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
-	fences += fence[i];
-
-	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
+	if (!fence[vcn_inst->inst] && !atomic_read(&vcn_inst->total_submission_cnt)) {
+		/* This is specific to this instance */
 		mutex_lock(&vcn_inst->vcn_pg_lock);
 		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
 		mutex_unlock(&vcn_inst->vcn_pg_lock);
 		mutex_lock(&adev->vcn.workload_profile_mutex);
-		if (adev->vcn.workload_profile_active) {
+		/* This is global and depends on all VCN instances */
+		if (adev->vcn.workload_profile_active && !total_fences) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
 			if (r)
@@ -470,13 +475,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
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
@@ -487,7 +485,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	}
 	mutex_unlock(&adev->vcn.workload_profile_mutex);
 
-pg_lock:
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
-- 
2.50.1

