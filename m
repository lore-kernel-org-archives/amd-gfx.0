Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44265C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8E310F66D;
	Fri, 29 Apr 2022 17:48:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FE810F67C
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTWKR/vqG+QPVgb2k7IttD6p3SqN87sPEtyO0oIga58tdCNwWoeLNXog94zGvPp8CuhbZPD+p3647+1J/19Aq5DjiSAfDxpBLQEfymG488FQ80phbrxE0XjOVLOryXi34LvUSIGVSCc9yQidetSI4U8z/LrOntl1Lgkfrz9Q5EvOBbBEzS8P4U6/4/45FGlgF2UlUxsHKCO3AU5i+xXMbIb4L1o31byQqiyQtGTzXtac5YwotUYNGnmogyZBQZXVhBooyHTVx+Ao9H4CnzQVdhypuCMPMfd/5sHMf6s9c4yKkt+0aZs8oVfxK9CEITQeWAKozBcTMPF5Q9ABJdzUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSY08L+8K4oOuvWLSoW+nmykcjeleMBcCl8UvDaWJ1s=;
 b=AZHHF7vMNQmjN9vzFgAv4DEM0zdahjy+OtpJ+uzZxcJEtaY884vCdCY0rBNZYg51SzKUd+h+pRsBXzIYnHtJAvUL0oMb+MxzVw4Ok/OQ2hxwDvF+LJlRMZJEJdkmAzNS/8ITxskF4yZcmyHS8OMONtwXkpr4ktBR82KjHoZUq7DO/Z51NMwRMS7PZkL5atXFzK+zJAZNJF2uPFM/xEDqeLvHTwUzVlXrbKE9No54oT2PNbiW2XFwH3KbLswoUjaEjm5WEaJTf4T20IRIa97KlIPQTs4HCesMusHDYPyyl93te1he3KGdXEhX4WvFXCrSI07Iu+h0/itwD7xcb1OEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSY08L+8K4oOuvWLSoW+nmykcjeleMBcCl8UvDaWJ1s=;
 b=KPbehChRgWp2E1O/LuJCdjYVsZ23CEOGGfVfDrOu3fXoLIfToSSPtTrXQb6zzbzSst1TbJpnKv6YvNmQoJQWLGy/X1rj/xoid7PQb/yTnIKKyq7FZqq/p/47mZbWE+YSkL7buFIa/Gh7k4veK2c0QDKVE3DNaUMXBaXEd/imqcQ=
Received: from DM6PR17CA0032.namprd17.prod.outlook.com (2603:10b6:5:1b3::45)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Fri, 29 Apr
 2022 17:47:17 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::76) by DM6PR17CA0032.outlook.office365.com
 (2603:10b6:5:1b3::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 61/73] drm/amdgpu: Enable KFD with MES enabled
Date: Fri, 29 Apr 2022 13:46:12 -0400
Message-ID: <20220429174624.459475-62-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb2e042d-d0aa-42e0-8ec0-08da2a084d57
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3073C07C408088B585A7DD0AF7FC9@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkY1Q0g2Nr2wTpdghhGGVbav5aT+HymCTKc6LcJFtzZZTEkyJ5g+3tDT/2a42UF5j/rYVECk3OmjdgMSevrwMvku51XZy7Rc4e4lAE8YG+GkYH2pi4ujznKHC9dQdgfQdBBEXKjPUdKdFT17X4o27hXfDvk9/qFZ8iKX5J/QvTbjQ15zco0JBLcOCaHyEAoE2fpDn420aCELo1o9dnTRr30HicQyv5EgiBy2/wBtkFKjGicUjbLtMkaoURPDf5iv+S1ELb5l2/DPsfyw/LKd+rUT/hdjs1LsxJQyujZ1OoIQjOz5w+arQUi9zR3+YIKtMjX9mIRlf1kTwzbALS+0xCSyTHz3QA4fDP0Zq+OERtRVpGFTimX20cQh89YiRgsHahy09eOHqbfem2EIA0bRE9witHthUAILkolEID2aC05TCeVMlboD+jkFcogQHh275HpdXy0e2w5a5jtol7PPuS6Cs9rnYgKODihl1Od/s7QJWTNmu8rzaDeiAk/4rNdsL4aDuKbiDQaOyJQ+YlCG00q3Uf0P3hwPZCKBDW0S/Zyauv14kLY9xKAVyHDbaZ6pamgW6N7kjiz6H7Sdl33VfFHw6auA2DlACM3AkCiologMUZGd3ygK+07qQOsg5Gbx3CUgmk5bLgP2hFZfEW85lNlS3j5EKUDa22X7Pr7p4vGCMQ1UMzOnXBuCLCOWEs7a382O1537XYFtPHFtElZnVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(7696005)(2906002)(8936002)(54906003)(6916009)(16526019)(186003)(316002)(47076005)(40460700003)(1076003)(36756003)(336012)(83380400001)(426003)(2616005)(81166007)(26005)(36860700001)(82310400005)(508600001)(4326008)(8676002)(356005)(70206006)(5660300002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:17.0941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2e042d-d0aa-42e0-8ec0-08da2a084d57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Oak Zeng <Oak.Zeng@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix
 Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Enable KFD initialization with MES enabled.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Acked-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++--------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 728e7be54a59..e582f1044c0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2171,8 +2171,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
 	}
 
-	if (!adev->enable_mes)
-		amdgpu_amdkfd_device_probe(adev);
+	amdgpu_amdkfd_device_probe(adev);
 
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
@@ -2499,8 +2498,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		goto init_failed;
 
 	/* Don't init kfd if whole hive need to be reset during init */
-	if (!adev->gmc.xgmi.pending_reset &&
-	    !adev->enable_mes)
+	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
 
 	amdgpu_fru_get_product_info(adev);
@@ -2863,8 +2861,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_remove_device(adev);
 
-	if (!adev->enable_mes)
-		amdgpu_amdkfd_device_fini_sw(adev);
+	amdgpu_amdkfd_device_fini_sw(adev);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.sw)
@@ -4125,7 +4122,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev->in_s0ix && !adev->enable_mes)
+	if (!adev->in_s0ix)
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
 	amdgpu_device_evict_resources(adev);
@@ -4179,7 +4176,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
-	if (!adev->in_s0ix && !adev->enable_mes) {
+	if (!adev->in_s0ix) {
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 		if (r)
 			return r;
@@ -4462,8 +4459,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	int retry_limit = 0;
 
 retry:
-	if (!adev->enable_mes)
-		amdgpu_amdkfd_pre_reset(adev);
+	amdgpu_amdkfd_pre_reset(adev);
 
 	amdgpu_amdkfd_pre_reset(adev);
 
@@ -4502,8 +4498,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		amdgpu_irq_gpu_reset_resume_helper(adev);
 		r = amdgpu_ib_ring_tests(adev);
 
-		if (!adev->enable_mes)
-			amdgpu_amdkfd_post_reset(adev);
+		amdgpu_amdkfd_post_reset(adev);
 	}
 
 error:
@@ -5148,7 +5143,7 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		if (!amdgpu_sriov_vf(tmp_adev) && !adev->enable_mes)
+		if (!amdgpu_sriov_vf(tmp_adev))
 			amdgpu_amdkfd_pre_reset(tmp_adev);
 
 		/*
@@ -5271,8 +5266,7 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		/* unlock kfd: SRIOV would do it separately */
-		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev) &&
-		    !adev->enable_mes)
+		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
 			amdgpu_amdkfd_post_reset(tmp_adev);
 
 		/* kfd_post_reset will do nothing if kfd device is not initialized,
-- 
2.35.1

