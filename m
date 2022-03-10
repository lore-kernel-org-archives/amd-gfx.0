Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1F0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 06:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FEC10ECD1;
	Thu, 10 Mar 2022 06:12:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8462B10ECCE
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 06:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZyQ1S3YifjQiyYCGFFmncgT9j2GPhcTsV5SnjS8bkylJwbxXwBCsBuaR/luhTqWRk6cpItuqjdaXihNhDgP/xfrwtnugmYGkCm9hnsf0DV3W30FGyUXriEwZ7rNJYqsTtSEfPxkOmDQMygmemJGRWWGnZMyuj36abNSUtWjLU9U+tJPTyyAFt+JDqlXq+ONYttVLXSFA/CyUph+vpwqyB9fe6KStIQgCinmOvADPwJhrp6GPdWOwjY6Lf51awb0VXunjkSljypJLKqal8rN46iofr9UxQRvOS3Of8U81G27C1+wXa7WWlI6u4ZIBiuvFS2oVmr+NwREgXQts4UjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqKxyOlMQWpNJwi4BdeVdslqBporC7X0z164cnCdKrw=;
 b=VveHwpbi7hzYyurnA8LP4paysqNC7e0eVi0w7gBxoj9feDA7+H6ILGkPw3El5nnmcgTvzpKThtmyZ9T84Q+JgN6ENsH7KNBRXiNEgMHCI23ElsUQOwlkR9j5zhWJTZo9h7t1f4cid5weWNcGLpmfjeYfGB/t+DSv2r/TAjhsd8NOZE39rq9io/D8ab3xIIYiXwX+H7MaFbO3DxVrRDWbF9Fck9KAH6jIWl7rRf/iemDA/mjOAzi/bDMASfqdCbI4fX8yI/BTOYlmFfmhY9MvuZnt42BzfjbO0dXwIvCQi1YPJMUgbNqWn2i+L5bNfzglbkYrC7BsGZLkjXEYnE8FYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqKxyOlMQWpNJwi4BdeVdslqBporC7X0z164cnCdKrw=;
 b=GIsIxpLcVtSZb2UMi4AiR8xo4JgbJ3DNrwd4Y/tjOgWAPBMADyhg/DLOHXUmHQ3/CFRts4NKZ2TF0YXGmcXxSKe83cR9d+Xvnw9BQyWPG5n4ENwx4ZEMj28KmDlpJOL3mOlUsy7qmtqBvAa+W0dScOUJz2Xf+nzRqKZP2W/nUDY=
Received: from BN6PR19CA0084.namprd19.prod.outlook.com (2603:10b6:404:133::22)
 by MN2PR12MB3758.namprd12.prod.outlook.com (2603:10b6:208:169::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 06:12:24 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::ef) by BN6PR19CA0084.outlook.office365.com
 (2603:10b6:404:133::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 06:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 06:12:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 00:12:22 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 00:12:22 -0600
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 10 Mar 2022 00:12:21 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: pass job to check soft reset
Date: Thu, 10 Mar 2022 14:11:53 +0800
Message-ID: <20220310061155.39292-3-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310061155.39292-1-Victor.Zhao@amd.com>
References: <20220310061155.39292-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7e15e4e-71a4-4def-8459-08da025cf1ce
X-MS-TrafficTypeDiagnostic: MN2PR12MB3758:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3758AB1F8FAC137CC0943FC5FA0B9@MN2PR12MB3758.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8naVV0ZCw0orqgLJUw+tt7pHxYMgViDBHFIoLLHlEuDKHXB/OgjD+3fH7PZQRx8I+/Kut8mXPprNmudzM7W2eiX4LfgPbypsYwFEbDOgcSKnrgSI7VoCahLu1FFP/k3VUGDRw3RJ0n7vIg2reCbWaALodJ61XKYvs6U1WekTdAv+wAo+DnRSpRb9TbNtbc4KXZNccakZy+kuvvy6oiPC2/RJ/dUbGqbPqJ6IaclMi1IF4qbYe1uD+j+mNiGsgJfgkZCWUqNSWE53GiJcPxlc5J3JUKfUlFJjeqm2levvCN5D915aLZIwmUKLof0cTqn4c0cAF/6a3HK2m1FxXEuDQWSd/InhGJ26TKF/tK83He3mBSauRjL+DiuVWfYDmrexjU1Onkv9+/7mni3B5gsnk2VGjigduVh/cfhDEdgLxV+aVgnimpXSvF9xnrxOr8SrQ1895iDUq2k//bVhfwnRFagEpxjtt3jTeogFsfBDl113V3ahrnGQW3vVSVJmcN6bEH6BsNYx24k/6p8i6uC1penWbpY8PlGyhERfcIs8HAygkjJn6q9+DWQGT8unPgCCZatfOWK2BQQFZV8nSowuBzKmLUESwaGOIiaHaxGrOncCemRZ4bSCLhoYZGC4LpdNIlK4RPQEu0qDvCnvVzEk8ZICm/YtHQYtmMhvyoKO+NC9yLTinpDmlJKyPMI6IAexXeYt7Gj6bYqIuW3psIewQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(6666004)(86362001)(82310400004)(81166007)(356005)(2906002)(36756003)(54906003)(26005)(7696005)(1076003)(6916009)(47076005)(316002)(70206006)(508600001)(8676002)(4326008)(70586007)(426003)(336012)(2616005)(40460700003)(8936002)(30864003)(83380400001)(36860700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 06:12:24.2655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e15e4e-71a4-4def-8459-08da025cf1ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3758
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In order to get more accurate engine hang detection, pass the hang
job to check_soft_reset to find the hang engine instead of check
register status.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 18 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c          |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h       |  2 +-
 17 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 22b846c359b4..4d6fd69f1bb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1359,7 +1359,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 /* Common functions */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
-bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
+bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev, struct amdgpu_job *job);
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job* job);
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7a513e5f7156..4819aedbfe62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -238,7 +238,7 @@ void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 
-	if (amdgpu_device_should_recover_gpu(adev))
+	if (amdgpu_device_should_recover_gpu(adev, NULL))
 		amdgpu_device_gpu_recover(adev, NULL);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a78a39e3d6e7..c82dc3621781 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4162,7 +4162,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
  * if the asic is still hung or not.
  * Returns true if any of the IPs are still in a hung state, false if not.
  */
-static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
+static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev, struct amdgpu_job *job)
 {
 	int i;
 	bool asic_hang = false;
@@ -4178,7 +4178,7 @@ static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].version->funcs->check_soft_reset)
 			adev->ip_blocks[i].status.hang =
-				adev->ip_blocks[i].version->funcs->check_soft_reset(adev);
+				adev->ip_blocks[i].version->funcs->check_soft_reset(adev, job);
 		if (adev->ip_blocks[i].status.hang) {
 			dev_info(adev->dev, "IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
 			asic_hang = true;
@@ -4466,11 +4466,15 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
  * Check amdgpu_gpu_recovery and SRIOV status to see if we should try to recover
  * a hung GPU.
  */
-bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
+bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev, struct amdgpu_job *job)
 {
-	if (!amdgpu_device_ip_check_soft_reset(adev)) {
-		dev_info(adev->dev, "Timeout, but no hardware hang detected.\n");
-		return false;
+	if (!amdgpu_device_ip_check_soft_reset(adev, job)) {
+		if (job) {
+			dev_info(adev->dev, "No matching soft reset found, do whole gpu recovery\n");
+		} else {
+			dev_info(adev->dev, "Timeout, but no hardware hang detected.\n");
+			return false;
+		}
 	}
 
 	if (amdgpu_gpu_recovery == 0)
@@ -4616,7 +4620,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			amdgpu_device_ip_pre_soft_reset(adev);
 			r = amdgpu_device_ip_soft_reset(adev);
 			amdgpu_device_ip_post_soft_reset(adev);
-			if (r || amdgpu_device_ip_check_soft_reset(adev)) {
+			if (r || amdgpu_device_ip_check_soft_reset(adev, NULL)) {
 				dev_info(adev->dev, "soft reset failed, will fallback to full reset!\n");
 				need_full_reset = true;
 			}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e0730ea56a8c..dc9a2390cf39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -62,7 +62,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
 		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
 
-	if (amdgpu_device_should_recover_gpu(ring->adev)) {
+	if (amdgpu_device_should_recover_gpu(ring->adev, job)) {
 		amdgpu_device_gpu_recover(ring->adev, job);
 	} else {
 		drm_sched_suspend_timeout(&ring->sched);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b642dde8833b..f2aa65016d1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1871,7 +1871,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		amdgpu_put_xgmi_hive(hive);
 	}
 
-	if (amdgpu_device_should_recover_gpu(ras->adev))
+	if (amdgpu_device_should_recover_gpu(ras->adev, NULL))
 		amdgpu_device_gpu_recover(ras->adev, NULL);
 	atomic_set(&ras->in_recovery, 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 22f9fedadbb8..cc042db4c823 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -3033,7 +3033,7 @@ static int dce_v10_0_wait_for_idle(void *handle)
 	return 0;
 }
 
-static bool dce_v10_0_check_soft_reset(void *handle)
+static bool dce_v10_0_check_soft_reset(void *handle, struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 1a476de20d08..a55d4a7914bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4974,7 +4974,7 @@ static int gfx_v8_0_resume(void *handle)
 	return gfx_v8_0_hw_init(handle);
 }
 
-static bool gfx_v8_0_check_soft_reset(void *handle)
+static bool gfx_v8_0_check_soft_reset(void *handle, struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9a3fc0926903..a3cbdb5703b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1311,7 +1311,7 @@ static int gmc_v8_0_wait_for_idle(void *handle)
 
 }
 
-static bool gmc_v8_0_check_soft_reset(void *handle)
+static bool gmc_v8_0_check_soft_reset(void *handle, struct amdgpu_job *job)
 {
 	u32 srbm_soft_reset = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f8a9b5e4f5e4..a3d5529b3642 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -274,7 +274,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	up_write(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
-	if (amdgpu_device_should_recover_gpu(adev)
+	if (amdgpu_device_should_recover_gpu(adev, NULL)
 		&& (!amdgpu_device_has_job_running(adev) ||
 		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
 		amdgpu_device_gpu_recover(adev, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 1b0a1550a352..708f9aa3ab23 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -303,7 +303,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	up_write(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
-	if (amdgpu_device_should_recover_gpu(adev)
+	if (amdgpu_device_should_recover_gpu(adev, NULL)
 		&& (!amdgpu_device_has_job_running(adev) ||
 		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index aef9d059ae52..1321c70bbccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -520,7 +520,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 	}
 
 	/* Trigger recovery due to world switch failure */
-	if (amdgpu_device_should_recover_gpu(adev))
+	if (amdgpu_device_should_recover_gpu(adev, NULL))
 		amdgpu_device_gpu_recover(adev, NULL);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 135727b59c41..223f7411ea71 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1250,7 +1250,7 @@ static int sdma_v3_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static bool sdma_v3_0_check_soft_reset(void *handle)
+static bool sdma_v3_0_check_soft_reset(void *handle, struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	u32 srbm_soft_reset = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index b08905d1c00f..b222a003a9b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -380,7 +380,7 @@ static int tonga_ih_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static bool tonga_ih_check_soft_reset(void *handle)
+static bool tonga_ih_check_soft_reset(void *handle, struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	u32 srbm_soft_reset = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 2d558c2f417d..b2f5f15ea575 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1159,7 +1159,7 @@ static int uvd_v6_0_wait_for_idle(void *handle)
 }
 
 #define AMDGPU_UVD_STATUS_BUSY_MASK    0xfd
-static bool uvd_v6_0_check_soft_reset(void *handle)
+static bool uvd_v6_0_check_soft_reset(void *handle, struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	u32 srbm_soft_reset = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 142e291983b4..2e69ba269e5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -629,7 +629,7 @@ static int vce_v3_0_wait_for_idle(void *handle)
 #define  AMDGPU_VCE_STATUS_BUSY_MASK (VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK | \
 				      VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK)
 
-static bool vce_v3_0_check_soft_reset(void *handle)
+static bool vce_v3_0_check_soft_reset(void *handle, struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	u32 srbm_soft_reset = 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4a5523c3e75b..732d0d660c0f 100755
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -317,7 +317,7 @@ static int dm_wait_for_idle(void *handle)
 	return 0;
 }
 
-static bool dm_check_soft_reset(void *handle)
+static bool dm_check_soft_reset(void *handle, struct amdgpu_job *job)
 {
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f1a46d16f7ea..c202ebc2b231 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -287,7 +287,7 @@ struct amd_ip_funcs {
 	int (*resume)(void *handle);
 	bool (*is_idle)(void *handle);
 	int (*wait_for_idle)(void *handle);
-	bool (*check_soft_reset)(void *handle);
+	bool (*check_soft_reset)(void *handle, struct amdgpu_job *job);
 	int (*pre_soft_reset)(void *handle);
 	int (*soft_reset)(void *handle);
 	int (*post_soft_reset)(void *handle);
-- 
2.25.1

