Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A34BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AACB10F67D;
	Fri, 29 Apr 2022 17:48:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20E510F742
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAMtZ4bfPASK+RkHgUXA/ENjhGayLCbS18XkI4xNhn1V9QeRI1Kb1KGA8H4C1O9cbiZlIQ9nfdQ0R5sC7at3A+2Mrh+/Vr2DBzxzkEjZQePLMX+ULGPxw8kSqrJH5cTbKjWxktwuYKb2SLfboU5EFHBDluIjl+10REMfv7aCO7WEEsKnkme7B0v00eLj5vEWZUSt9ZIRjFAVWgpXlfotJ1smQTtpELPAIjR+/l3772vPZDVxrfpnvzMiNHm64//zG9E8Zqf7L0JWWjpq7umWJr4YvCRu0yQ4NrQub3q2QqOxFTE7CA0N5smX0qKFKGMmQqTaqZVGAqwQUeZLeurVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h695aeN1m/1VCtqMf0IhUbVuk3YrtlsyD8vP35M0Sg=;
 b=bKXxOewINmoUw18Yr+Gm/Is5dg0RUdKPHDcrzQUc1NJkqJKpZz/zYbvSMle4UMMLKOnHxK6nG0WxClKWPISN2m/x48ogRhPBKmFvMaqwRkBpLSr7wMktil1kdkLpINrkfTvpeB0ojFkKwxTohPi7LvPoixRCHiYB8te/cPIBezxFfhZ7t826DDxW5pev12dWF857Xpb7qkCMHWPfLcfzDxGwNlHBdwUXLpIw7KTXXEvO0iN2VT7zpKmMXFqK7i7TAmdP6AK6/DHE4N4v1ifcrVugcjp0dFoF9IUVfFDgfzDKFIK76znfW+2thjoAb85eQ8wa7PCet7azWAebIdKWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h695aeN1m/1VCtqMf0IhUbVuk3YrtlsyD8vP35M0Sg=;
 b=vCvaOuOhxl75+yUAwdRFn9AgymsYyLefhBuFn+tVXzrcvC1F1tLjSlsg3uFpPMLG5KhBsvM6urWbBpnL2YoZqdM95n6ua6B9FfF00+jJQUl7M6j6lfwPVRIMIJUHXnBGzMUeaVx0h4+izqm06+om91v7A2/EgWY6yw71HZC30qY=
Received: from DM5PR21CA0003.namprd21.prod.outlook.com (2603:10b6:3:ac::13) by
 BN7PR12MB2642.namprd12.prod.outlook.com (2603:10b6:408:26::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 17:47:14 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::56) by DM5PR21CA0003.outlook.office365.com
 (2603:10b6:3:ac::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.8 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 60/73] drm/amdgpu: skip kfd routines when mes enabled
Date: Fri, 29 Apr 2022 13:46:11 -0400
Message-ID: <20220429174624.459475-61-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6f1ed31-0466-4438-f545-08da2a084b8d
X-MS-TrafficTypeDiagnostic: BN7PR12MB2642:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB264295E97FD5D81AE2EE7D45F7FC9@BN7PR12MB2642.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8NiK3vOjARtHdhHLx9oWQfLoLVER1VddVOMZG0BFsvXueBaPJUDQjlnmar5YiR772EQzKaymvkGb9FUYz7IxpNFQkVTZQQb5/SwWNFvLg6fCYcbXoIKjKQDVmWJr8Q4mkipmYcWtKEvYJSPF+c+amaO5YopGr3c3nQwHrLpW33C13hLTJMCrZv0a2TOenAY7DEE+Y7ptn/SZsK7xu7kGgKUIrmlVyj8dTNtjGe3uksNyYO7KruIE3FhHlaXPlMxngR/632xXxUDJ28Q2leF3OY+cmoGBEMsk4kSu5zXOJoODH147Pe/b3ZP+scbAUM4XV1Sn69Lj7j8mZiRuwfSHGL5eeqtBAeRbatGuACgTPj4kMa3GsxGdZgHHLjRSZhpSPuvOHQE1b2WNjOoS5mX8lgl1tN5LOQx/6wljqb91FYTnolMxOzxT3UMrfLROxqPRNYSor8LIKRz1dQ1Er2niJuaKex+TxzeA0mUu0MnRcPTt4B6BGoZinJxMoOpezl1peAeWUq49klodwWE+4Tjd4aj/nJm71qqFBFhgoDGkoNrFUkPPgbNnxY/iwYZK0q7ZU/m8BsHGAHNczw4doildomtsjvQZYmBXM9RoJBbSAgMtZ4/RSYcS2PHg20vQf/1UO3WH+Oa+jCGwMsLZywcpmGuiQufU+NYAiQVbKJLZ8WE0wRpbw6580NAFvb4eoaGh6jYtpLFt7deUdfW+5TgqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(70206006)(336012)(4326008)(8676002)(186003)(82310400005)(16526019)(426003)(36756003)(26005)(7696005)(6916009)(316002)(47076005)(81166007)(2616005)(356005)(1076003)(5660300002)(54906003)(86362001)(2906002)(36860700001)(83380400001)(40460700003)(66574015)(8936002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:14.1108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f1ed31-0466-4438-f545-08da2a084b8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2642
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

For kfd hasn't supported mes, skip kfd routines.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++--------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b2366d0d3047..728e7be54a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2171,7 +2171,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
 	}
 
-	amdgpu_amdkfd_device_probe(adev);
+	if (!adev->enable_mes)
+		amdgpu_amdkfd_device_probe(adev);
 
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
@@ -2498,7 +2499,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		goto init_failed;
 
 	/* Don't init kfd if whole hive need to be reset during init */
-	if (!adev->gmc.xgmi.pending_reset)
+	if (!adev->gmc.xgmi.pending_reset &&
+	    !adev->enable_mes)
 		amdgpu_amdkfd_device_init(adev);
 
 	amdgpu_fru_get_product_info(adev);
@@ -2861,7 +2863,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_remove_device(adev);
 
-	amdgpu_amdkfd_device_fini_sw(adev);
+	if (!adev->enable_mes)
+		amdgpu_amdkfd_device_fini_sw(adev);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.sw)
@@ -4122,7 +4125,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev->in_s0ix)
+	if (!adev->in_s0ix && !adev->enable_mes)
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
 	amdgpu_device_evict_resources(adev);
@@ -4176,7 +4179,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
-	if (!adev->in_s0ix) {
+	if (!adev->in_s0ix && !adev->enable_mes) {
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 		if (r)
 			return r;
@@ -4459,7 +4462,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	int retry_limit = 0;
 
 retry:
-	amdgpu_amdkfd_pre_reset(adev);
+	if (!adev->enable_mes)
+		amdgpu_amdkfd_pre_reset(adev);
 
 	amdgpu_amdkfd_pre_reset(adev);
 
@@ -4497,7 +4501,9 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (!r) {
 		amdgpu_irq_gpu_reset_resume_helper(adev);
 		r = amdgpu_ib_ring_tests(adev);
-		amdgpu_amdkfd_post_reset(adev);
+
+		if (!adev->enable_mes)
+			amdgpu_amdkfd_post_reset(adev);
 	}
 
 error:
@@ -5142,7 +5148,7 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		if (!amdgpu_sriov_vf(tmp_adev))
+		if (!amdgpu_sriov_vf(tmp_adev) && !adev->enable_mes)
 			amdgpu_amdkfd_pre_reset(tmp_adev);
 
 		/*
@@ -5265,7 +5271,8 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		/* unlock kfd: SRIOV would do it separately */
-		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
+		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev) &&
+		    !adev->enable_mes)
 			amdgpu_amdkfd_post_reset(tmp_adev);
 
 		/* kfd_post_reset will do nothing if kfd device is not initialized,
-- 
2.35.1

