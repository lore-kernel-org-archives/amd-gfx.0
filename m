Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084D1C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 18:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA5210E8FC;
	Fri, 26 Apr 2024 18:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rHhqE9Q7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B8FD10EB1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 18:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpFBLOXSb+F4/rkEhITL1URM47lYWyYoN/L0Yc8zhr2OXAznlIgyuYcNsK1xRNDxbwpAQdx/zdB5D3cSGDBD8NeeK6JiGHK6SsDYQQLYcH92xadKLZ2G2nEZRWJHU1HJJ65l3S7rlx0WvBjnX7IYINE/8e8BGw+bF4f88Se4yr5PBvuR1K0qgDNvlfgFL62ohfrbVlwmVRygLKxeF9Zl0hBr9NkVbLo1T7ptS5WHPgyTPPOtw+WPvrHBXWpFESZJnGssuzuImpUXbVg6/BMCkElQMJZJ5SH1SjxDSPC+TZukkMPk2Rdd5viSIxL9CPe33rUkIoUpr7oP9deeb0NDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwEn1dOaMmG2LML5YyxAMSpa7Pg5eL60o7FeD94aGFM=;
 b=VjDy0DuoQtP1AJHm1ZFrS+gNYaQHqsgpYR2ATmNQVI0eyYWCntPHp0fih7+TmDYUjAxHD8Yr4j9k3sHtcGADd5UT8w1wMHxhSCFnq28nfpWmr9uMnc45lV3lUgJUeOon7omru52PoFVVrLTp7UI1mZoXgzZ2OJ97nxL8aslKlg1KqKmCRWOf9CK9IYHr2GWwirdg2VD7PB9370aToh4//dHJv5v4s0I3XnaNjTGyMXsZTBViHBFrEH/FerTUA76HJwfQ9/EgWzpOwP699pEXAOFeFMRm8Gpn6KzuAQuwc+pHhI5ndPPTsHDx6ZtBIOfhLDRlHdMPUG765reIW30WQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwEn1dOaMmG2LML5YyxAMSpa7Pg5eL60o7FeD94aGFM=;
 b=rHhqE9Q7D+BlE6cZnKrPXjqRyrouksT0bh3eQ+JZn3uSZmpch8Qhk0XMmGqmOiguKyT1+dpDQPkxJg4IrWaEGWEdBqMy9CMlhOOoh+WJikjP7nCf5GDbn4TUjZZ6lP+ZgDv/Rf0Gm609f4CIa5J4yTFcjsaP5j7iCDAC+cmcdcM=
Received: from BL6PEPF00013DF9.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:c) by MW4PR12MB7215.namprd12.prod.outlook.com
 (2603:10b6:303:228::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 18:29:39 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2a01:111:f403:f902::1) by BL6PEPF00013DF9.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Fri, 26 Apr 2024 18:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 18:29:38 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 13:29:36 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, <felix.kuehling@amd.com>, <emily.deng@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry logic
Date: Fri, 26 Apr 2024 14:29:28 -0400
Message-ID: <20240426182928.98181-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426035742.90560-3-Yunxiang.Li@amd.com>
References: <20240426035742.90560-3-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: fe234bf8-b0d0-439b-aa1f-08dc661ed4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GD4o5iKD4/z7gxh/g9fxAiwOWJxu7/MrwBYxOrXs79fJQKv2NuWEUqnEfWGU?=
 =?us-ascii?Q?ZrXkAjaCaS/Bg3qLCFzee5Jk3SKEKHJGSXAF3i+RPbw73sVtVjuyMmPZHIYt?=
 =?us-ascii?Q?2wZeAuSZRQ4sQVajK7JVatiDiYqcurUZeG7XQ/qJgOJAIiOPM7VnukOuWKGu?=
 =?us-ascii?Q?hrOmdwEsNvEete1L4hFfXfT0xFRsGOtmi21yFfSWjXPSzJRy7XWdYhg89oX0?=
 =?us-ascii?Q?yBegskw5icXet3CJSX+xTUpmmeeMxOJCyogZBQLTnfBcB/dcBssxyubXvy4P?=
 =?us-ascii?Q?zoA8a2cT62cLUcYcHOrxzLYITXJj2qQlOBREzz2c5wPjdpL80KmIN2WRpb7P?=
 =?us-ascii?Q?8WaZSgfSLh8HTrrsyZ2OVvbsbjNaIqQORBHZlWI5KAe9KQUri1enG0i+ZjD4?=
 =?us-ascii?Q?7S4hSTN5qxDy8gV0rgvo9+OkgRMGe4fP7G8CXUVQy5eAfVp0eoYaxAf0EYTl?=
 =?us-ascii?Q?QnPXvVBTSZGYADASCIq+qnODeXFGGzbLh+xsbDBcjVf2icab6U6pPXwYzERs?=
 =?us-ascii?Q?zIUvAAgf75gPU0puzAkgxWGEmKigsVH8VNj4BmkRmejkTXSKHiHJo/2UkdSm?=
 =?us-ascii?Q?gBEH6d48cTLMUONgoueKSjwNzCpJChQIF/UoRAZjly5P/Gie9eWRVEVd2rUE?=
 =?us-ascii?Q?0EaxA4DY+Aga3Zk2QXLkBfcLc8Rkyywi4JJqEg2XwNCBldzSfDq5ihLZytD4?=
 =?us-ascii?Q?vDthmYkaUlTUx5XkWsanVtv5rgif6/l2LNq+Lro6NFFK8psaunmZFbk2MdKw?=
 =?us-ascii?Q?B0luB4jrDnK/Iwkc1a1lbbNc63vKwENF1Tfp7bEqlS8j+uazCZGt2t0PxQhw?=
 =?us-ascii?Q?w0zIcTXGP2AcMI586W9xiWFQLlzUI9SpkSBKDgcUTE+8FMZxsCHvz3p2rGAS?=
 =?us-ascii?Q?B4WE+Es2dUZET0bK/3hNtyvYxIIFt/UnhESniEqpwK1mckK77jblKc5IHfUm?=
 =?us-ascii?Q?PMWcFmbZu4gzUOE9yDmcsgyS6nwNhwGREv2rSA5df4aK0ULgz5YW+Nkvp7Vc?=
 =?us-ascii?Q?BGxN8i2uHnctWXAuTGy7cd0ccc4IKTcn7qxaLrS4gkuZzjjfnNRSDOznL7VD?=
 =?us-ascii?Q?ZVREGCY/LmO/08DQTf4jlCfuOwqf/gG2wJf5IfqTdo8CyGSX4bc5J3lNWyX8?=
 =?us-ascii?Q?D+jFAjfgoUN+cIAHLk2A9EbfB3GWT0sPVA1lMsM477bXJQLGevAZTJyqlOaT?=
 =?us-ascii?Q?RnmyJfTP+OztgyhVjouRdIvWCN8PEgcT44APpfZDDW7fy+QPuiGLXhy1ug0g?=
 =?us-ascii?Q?/jNCkRwouijcxeCXPLejVtqhbwRi3EnbVc0DPqKJ1X+OGdhaEir4Vpw/2zgo?=
 =?us-ascii?Q?DF3B9xT3Z90kNtfDYPnS6rMicdc0GZzIH/zjnZBfjGjzB3gELnFyDSI/xg9w?=
 =?us-ascii?Q?CJ5S1P3fM/WinRyRU5iHJs9Z82w5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:29:38.2572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe234bf8-b0d0-439b-aa1f-08dc661ed4ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
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
v2: put back release full access and the missed return

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 33c889c027a5..b23645f23a2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5065,10 +5065,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 {
 	int r;
 	struct amdgpu_hive_info *hive = NULL;
-	int retry_limit = 0;
-
-retry:
-	amdgpu_amdkfd_pre_reset(adev);
 
 	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
 		clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
@@ -5088,7 +5084,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-		goto error;
+		return r;
 
 	amdgpu_virt_init_data_exchange(adev);
 
@@ -5099,38 +5095,35 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
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
@@ -5689,6 +5682,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
+	int retry_limit = AMDGPU_MAX_RETRY_LIMIT;
 
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
@@ -5770,8 +5764,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		if (!amdgpu_sriov_vf(tmp_adev))
-			amdgpu_amdkfd_pre_reset(tmp_adev);
+		amdgpu_amdkfd_pre_reset(tmp_adev);
 
 		/*
 		 * Mark these ASICs to be reseted as untracked first
@@ -5830,6 +5823,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_device_reset_sriov(adev, reset_context);
+		if (AMDGPU_RETRY_SRIOV_RESET(r) && (retry_limit--) > 0) {
+			amdgpu_virt_release_full_gpu(adev, true);
+			goto retry;
+		}
 		if (r)
 			adev->asic_reset_res = r;
 
-- 
2.34.1

