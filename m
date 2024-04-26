Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A464C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 03:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB2611A9D5;
	Fri, 26 Apr 2024 03:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EXLfNviA";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A3211A9D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 03:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFBW+9Y2tHR1V8gIl9G9gr0cPx0mmlHwHfUWvmfLKSiF9ILMiVS20y9Fq9lsJoOdli/MF8UDEuzDurcDgALzn5o6uFnhBf0NqkYEx19QP4Z9pmlmZ0UGdRST3Teza0FkMc4urva4qwbE8CDeusIhx53777otTjDG9ZVyhigQBZ/hAIKVcKCmbzI+o2P0AyUTWlDKpkxWjD3AdOl7pFRmKOpdB7Pbk5+k3+qR7uTapglRsAHupIkB5COtFHDxwqL1Mc1YzvfyonvXTv2Sm6zxO55eeDwMPorgkZYUqAUbkTa+XrLQEV/egSNp259wtnvQhgutnyfjGKAZm7zD+Jhnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwMY4Yde8vuebV8mH9Livz0nP351rR1TKC24IHtm9og=;
 b=hbunWkcgp8bjf2bKAB3Js6R3cDLnKikLi9bZPsUdsDp/RdKcuYSYzYW+iov9GCTrE+oX5uuwwYE6eH1hkvjr/m825G5DAGLuS/WBbCNGFX+X0Y6lfuyTBjlbTXUWA+OCKYTBiLrAmzbWo4Q1+ia9wXScEsd7yC82xf9niwVibQHVg3QrROLYWtBUOrdSEJBcEQ8E0ON7rd3SK7rwc70vPwNNLyk38y42LvhVIf7E/CrfoYTTpbpKOT80Gt7s8PV7dLh4O2sPZOrsb2tZNJppcSFxBZdSPwv1aReWH3c4UONCSUVFmivkl4T3fPBImdhtSHzEx03vZKFZOSlu+vZAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwMY4Yde8vuebV8mH9Livz0nP351rR1TKC24IHtm9og=;
 b=EXLfNviAV4mxjq1PlF+rffCqxQ+kAsw11hycSdnBnFsIqUjr7a64qSlN7UduochW2luOHR0zUAeqaCw0gDHxSOVPXjKt9H0TgHF2sBEatIG30ZvQL1G7mIqRkhhh3DkhKkS0AD/xUnhbBUKrF8R9Ju4EiPcsoaWjthhqVXc/iKw=
Received: from BN9PR03CA0499.namprd03.prod.outlook.com (2603:10b6:408:130::24)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 03:59:06 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::6b) by BN9PR03CA0499.outlook.office365.com
 (2603:10b6:408:130::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Fri, 26 Apr 2024 03:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Fri, 26 Apr 2024 03:59:06 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 22:59:04 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, <felix.kuehling@amd.com>, <emily.deng@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry logic
Date: Thu, 25 Apr 2024 23:57:41 -0400
Message-ID: <20240426035742.90560-3-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426035742.90560-1-Yunxiang.Li@amd.com>
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: e31d3656-6d97-452c-2829-08dc65a53854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7tiTATvbkO/IA5el4IXvTi+xPJQRlBZL+4YBzcjNpJY3UnBOI+gRqLumW2h9?=
 =?us-ascii?Q?KtADL/U/X8pjGy7Zqav5SzsVk0gF5f8mp4Ae6WokEx5YhmXdN+8pFHmstrML?=
 =?us-ascii?Q?EJ3a2HYw19GHztot2sbOP3+suZbFUsXRG5AdvmfrKzUfNgPMONro+I2EeP7z?=
 =?us-ascii?Q?H6IiWMeHBqvq3XR4bfx3LiNuA71kSxrnHJmyeJKzD0tR3ef3Ukcvk2SoY4HW?=
 =?us-ascii?Q?57Lsw4mZ4QF/DuxAC3hd7NG7w49Ze3cwq6CQBbXm44wmtfbM/rt8hbYbimU8?=
 =?us-ascii?Q?rCzDFttpZHWQYNiS6goLcWXF+uFHlk5hzR9AXSobvXtXAZEcp9RZW3IlerdS?=
 =?us-ascii?Q?dULUoCsAU5mfhwjcJm3BLgo4T7WTypMbc62toLoYumKHrgf29XZqZwYzE64G?=
 =?us-ascii?Q?pUcbnnhc6sz4UAPllpJSXIxDizipo+HNDH+dxI33yQ6lIe8CFxNkmtWyEIDI?=
 =?us-ascii?Q?7yWTmlPQpDrcMD79vjB5aGGYeppjDpdC30BxjbCwIIAL/e8wIgDawmV3t8kq?=
 =?us-ascii?Q?CersuU+n91xODtQDmk7RRsH9IbF/DuRoM0KSYTr4ntpRgP9XDcNoHCzGLve8?=
 =?us-ascii?Q?R/zbq2XJCoH9v9O+W4cvW37GcrqjAs+beRXkrT3ZO+/fYe3EddSkKyndkSXd?=
 =?us-ascii?Q?Cszf6Qkp0xJhuLorXADfO1jr9wBQpErQJX1Ff5HRe6hvkEY5xd2Rnv+Cl2L6?=
 =?us-ascii?Q?vfqVWcKRUpopcG/g5robkj/t7inCWjDXT3MrHk3WhB48R/WGdTPZh4L8yuJ8?=
 =?us-ascii?Q?Jg1e4PMfs9tEZADhkcMFKxGjY3pwQnHoK0DgQFGCaTM+Rr+epGpqV6u0EGWe?=
 =?us-ascii?Q?KGPlWvOs/1K72waHq61lr7jYlx0VSzfRHl1tI6GwD/uwxbM+lheO3n0ZsAP3?=
 =?us-ascii?Q?QBd7xYa3pMfGRoc3ZTDRT9+z6gev7At7uvkOFWwWl7Ql+7wXMLEJx3J2bkfm?=
 =?us-ascii?Q?VWgPN1+DZ/4DQsYSg/6+ini7i1nm2AlScWiYWbdmeoTaTh/gF0NAxf+0KtI4?=
 =?us-ascii?Q?MmYkr0vqqO6Bo6OB0E6id9qKuZqkj+vJpeyAa5XtTJL9Jqji7HTIasen+vzP?=
 =?us-ascii?Q?HpRAclqN+LQznAQTGwhDCaZ4/rkooMYXWDtxbI/3DIc20ryDR18yKNu8wtkF?=
 =?us-ascii?Q?7BnuH6l8vAjdjeaUGUuqckzB4pfRESCFTonz7aIaeOP3OzRLJcWg/iLHWG9k?=
 =?us-ascii?Q?jqI6ZaZ228sZx8sPa1iLoGqPJlDGIPmjbdlEUUbDeDRiXZMrhFpKLukk8rZ/?=
 =?us-ascii?Q?AO/ygzXW0W4KRMHe1jf2GAq+NqokZeh1WtyGD83eHvZR8BSRNSBDtsblm+JT?=
 =?us-ascii?Q?Wc303CpeCdi1gP2VsBo+aMB6RqoP2iBB/DR+8ZkIU5xnuQKT84LEnBmSrCa3?=
 =?us-ascii?Q?hZHRy5fnX7+7eQI61KvSR+H0nNDx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 03:59:06.8191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e31d3656-6d97-452c-2829-08dc65a53854
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
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

The retry loop for SRIOV reset have refcount and memory leak issue.
Depending on which function call fails it can potentially call
amdgpu_amdkfd_pre/post_reset different number of times and causes
kfd_locked count to be wrong. This will block all future attempts at
opening /dev/kfd. The retry loop also leakes resources by calling
amdgpu_virt_init_data_exchange multiple times without calling the
corresponding fini function.

Align with the bare-metal reset path which doesn't have these issues.
This means taking the amdgpu_amdkfd_pre/post_reset functions out of the
reset loop and calling amdgpu_device_pre_asic_reset each retry which
properly free the resources from previous try by calling
amdgpu_virt_fini_data_exchange.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 ++++++++++------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1fd9637daafc..3c4755f3c116 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5063,19 +5063,14 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 				     struct amdgpu_reset_context *reset_context)
 {
-	int r;
+	int r = 0;
 	struct amdgpu_hive_info *hive = NULL;
-	int retry_limit = 0;
-
-retry:
-	amdgpu_amdkfd_pre_reset(adev);
 
 	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
 		r = amdgpu_virt_reset_gpu(adev);
-	if (r)
-		return r;
+
 	amdgpu_ras_set_fed(adev, false);
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 
@@ -5085,7 +5080,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-		goto error;
+		return r;
 
 	amdgpu_virt_init_data_exchange(adev);
 
@@ -5096,38 +5091,35 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	/* now we are okay to resume SMC/CP/SDMA */
 	r = amdgpu_device_ip_reinit_late_sriov(adev);
 	if (r)
-		goto error;
+		return r;
 
 	hive = amdgpu_get_xgmi_hive(adev);
 	/* Update PSP FW topology after reset */
 	if (hive && adev->gmc.xgmi.num_physical_nodes > 1)
 		r = amdgpu_xgmi_update_topology(hive, adev);
-
 	if (hive)
 		amdgpu_put_xgmi_hive(hive);
+	if (r)
+		return r;
 
-	if (!r) {
-		r = amdgpu_ib_ring_tests(adev);
-
-		amdgpu_amdkfd_post_reset(adev);
-	}
+	r = amdgpu_ib_ring_tests(adev);
+	if (r)
+		return r;
 
-error:
-	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
+	if (adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
 		amdgpu_inc_vram_lost(adev);
 		r = amdgpu_device_recover_vram(adev);
 	}
-	amdgpu_virt_release_full_gpu(adev, true);
+	if (r)
+		return r;
 
-	if (AMDGPU_RETRY_SRIOV_RESET(r)) {
-		if (retry_limit < AMDGPU_MAX_RETRY_LIMIT) {
-			retry_limit++;
-			goto retry;
-		} else
-			DRM_ERROR("GPU reset retry is beyond the retry limit\n");
-	}
+	/* need to be called during full access so we can't do it later like
+	 * bare-metal does.
+	 */
+	amdgpu_amdkfd_post_reset(adev);
+	amdgpu_virt_release_full_gpu(adev, true);
 
-	return r;
+	return 0;
 }
 
 /**
@@ -5686,6 +5678,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
+	int retry_limit = AMDGPU_MAX_RETRY_LIMIT;
 
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
@@ -5767,8 +5760,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		if (!amdgpu_sriov_vf(tmp_adev))
-			amdgpu_amdkfd_pre_reset(tmp_adev);
+		amdgpu_amdkfd_pre_reset(tmp_adev);
 
 		/*
 		 * Mark these ASICs to be reseted as untracked first
@@ -5827,6 +5819,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_device_reset_sriov(adev, reset_context);
+		if (AMDGPU_RETRY_SRIOV_RESET(r) && (retry_limit--) > 0)
+			goto retry;
 		if (r)
 			adev->asic_reset_res = r;
 
-- 
2.34.1

