Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3529BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 10:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0545F2070B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 10:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JM/nWUoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0545F2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CC56E392;
	Mon,  6 Jul 2020 10:01:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA186E047
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 10:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2RaeGz74bq1L6ew9dnZSODiIzu3cou15ZVsPqcKTKJhO/Jke/KhIr+a2QVAJlKGlDvarf2/YNQwtQXQf8WywISMZcztoGNQXDCkkbBWBQybcvFxIE+z1v9mJvthENLLCdJEPDfEUwRjKJeIvbn6V/oy7yxXIsEr7g5XP1xh/86I2418z94eZPnSPIbgcBFk2K7RdmldOLfI+ABBQ94ZAPd6/56sBDFALMP+tBnWLEvVcG49HB9Pp0SiQhd/32k/EQ4RLdsoGR5ntoFh+pkfYMhZu1H0fWWDLKQVgHHKHNbM8G87kayJ2FeWZC75Nq4vpQq8+K5xLn++n1XHnJ1ztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejDgPGXD46im8qJGYcAKErVVQFdop/eVu9Td5Gm1294=;
 b=ajGSocjIizswOeLoNX5PC/DbyK9QGWpc4Fb/+KQu8bYRt1uH9jsaIOzY28KXR5bI1InnS01ETugOZcajOokKMORNpshVBpGnz7cqaS8DeK6vJt98g6Cp+cpHE+GoWR87yjzRZ0hOrMoKIHQIaKCZMK/x80qY8WO5L18lsm8bAiQ/czZk6Ux1NTUFiw3IXEwK/2lsa6xRQpu2qty+zNIdYWNdG35A9d7DEXa+CSgugWDFGWe8vhpWh76sNyGre1Xg4r+gQCQq9BALSXYQERP38n+9ipyq+TGUvYFQJ6hsGpKm0u+WP2TFyYxlfjsAkNmcYBPxULN5LBJwczvI8RmEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejDgPGXD46im8qJGYcAKErVVQFdop/eVu9Td5Gm1294=;
 b=JM/nWUoC8PpmQnTiS1ZoUPv4m3pk8AEh/BhhxsppqbN/1x3GUCuiLBnHoq/dkmBdsH1Wh/hTEnsgCILrRG0hmEMtAwCsgfdIRygCaOvK7dRYdAZjEMdHh6azHhtNbVmbnXpA+sGf+zHYDgZ/+viIn9yWwcYM9VzgoBMtHrYxZ1Q=
Received: from DM5PR21CA0018.namprd21.prod.outlook.com (2603:10b6:3:ac::28) by
 CH2PR12MB3976.namprd12.prod.outlook.com (2603:10b6:610:28::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23; Mon, 6 Jul 2020 10:01:30 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::90) by DM5PR21CA0018.outlook.office365.com
 (2603:10b6:3:ac::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.4 via Frontend
 Transport; Mon, 6 Jul 2020 10:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 10:01:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 6 Jul 2020
 05:01:29 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 6 Jul 2020
 05:01:28 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 6 Jul 2020 05:01:21 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: fix system hang issue during GPU reset
Date: Mon, 6 Jul 2020 18:01:13 +0800
Message-ID: <20200706100113.25141-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966005)(54906003)(36756003)(356005)(110136005)(26005)(8936002)(1076003)(6666004)(8676002)(316002)(82310400002)(336012)(2616005)(86362001)(186003)(426003)(4326008)(83380400001)(2906002)(82740400003)(70206006)(81166007)(70586007)(6636002)(7696005)(5660300002)(47076004)(478600001)(30864003)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3070f5ae-b71c-478f-35fe-08d821938e00
X-MS-TrafficTypeDiagnostic: CH2PR12MB3976:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3976567D7727DC14AF27B411ED690@CH2PR12MB3976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfMVjTT0hmG4hOCKBJPIw7MQszRJ3ne3nAx9cx3kP6pxSZmuOT5m9JdZPubPMGT/eoWh/3EwRhaYzlMw1rmalckxogAA1sRR2votVGDEQIs4boaEz2NR/JN1e5ViSfWFQcq3pNZNOQU0TgMmS8AX6HNhjTtOdYBhsvyt/BaM1/KVY7y3AJUJFnQ0DodOL+2qhi8Ei9y1OW9hJfg7cnkpXBXpmG0xEZo0oDbkckPUEJfv436YIRPE9tVl7B9Xj0l68FcjAdvIZT52e0SxyaPpTKIvupdPg3j+3DxNrjQBVs1IJK5zZjoq6SoizKvglEO/8Lzpko+Uu7+5TVrsAQSzaxqtPmMsObBY+vFf9dhHDrI1IG3XLU0MyfpZ5PgMmj9fzr3r5nBmknNlA/P3TOu/l4pnxxPfjyhAPrDJhfXyl9Q=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 10:01:29.8363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3070f5ae-b71c-478f-35fe-08d821938e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3976
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
Cc: Dennis Li <dennis.li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During GPU reset, driver should hold on all external access to
GPU, otherwise psp will randomly fail to do post, and then cause
system hang.

Signed-off-by: Dennis Li <dennis.li@amd.com>
Change-Id: I7d5d41f9c4198b917d7b49606ba3850988e5b936

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6c7dd0a707c9..34bfc2a147ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -965,7 +965,7 @@ struct amdgpu_device {
 
 	bool                            in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
-	struct mutex  lock_reset;
+	struct rw_semaphore	reset_sem;
 	struct amdgpu_doorbell_index doorbell_index;
 
 	struct mutex			notifier_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index ad59ac4423b8..4139c81389a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -611,7 +611,9 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 	/* This works for NO_HWS. TODO: need to handle without knowing VMID */
 	job->vmid = vmid;
 
+	down_read(&adev->reset_sem);
 	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
+	up_read(&adev->reset_sem);
 	if (ret) {
 		DRM_ERROR("amdgpu: failed to schedule IB.\n");
 		goto err_ib_sched;
@@ -649,6 +651,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 
+	down_read(&adev->reset_sem);
+
 	if (adev->family == AMDGPU_FAMILY_AI) {
 		int i;
 
@@ -658,6 +662,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
 		amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
 	}
 
+	up_read(&adev->reset_sem);
+
 	return 0;
 }
 
@@ -666,11 +672,18 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid)
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	const uint32_t flush_type = 0;
 	bool all_hub = false;
+	int ret = 0;
 
 	if (adev->family == AMDGPU_FAMILY_AI)
 		all_hub = true;
 
-	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
+	down_read(&adev->reset_sem);
+
+	ret = amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
+
+	up_read(&adev->reset_sem);
+
+	return ret;
 }
 
 bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 691c89705bcd..db5d533dd406 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -542,6 +542,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	unsigned long end_jiffies;
 	uint32_t temp;
 	struct v10_compute_mqd *m = get_mqd(mqd);
+	int ret = 0;
 
 	if (adev->in_gpu_reset)
 		return -EIO;
@@ -551,6 +552,8 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	int retry;
 #endif
 
+	down_read(&adev->reset_sem);
+
 	acquire_queue(kgd, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
@@ -633,14 +636,16 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 			break;
 		if (time_after(jiffies, end_jiffies)) {
 			pr_err("cp queue preemption time out.\n");
-			release_queue(kgd);
-			return -ETIME;
+			ret = -ETIME;
+			goto pro_end;
 		}
 		usleep_range(500, 1000);
 	}
 
+pro_end:
 	release_queue(kgd);
-	return 0;
+	up_read(&adev->reset_sem);
+	return ret;
 }
 
 static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 0b7e78748540..cf27fe5091aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -424,10 +424,13 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	enum hqd_dequeue_request_type type;
 	unsigned long flags, end_jiffies;
 	int retry;
+	int ret = 0;
 
 	if (adev->in_gpu_reset)
 		return -EIO;
 
+	down_read(&adev->reset_sem);
+
 	acquire_queue(kgd, pipe_id, queue_id);
 	WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, 0);
 
@@ -506,14 +509,16 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 			break;
 		if (time_after(jiffies, end_jiffies)) {
 			pr_err("cp queue preemption time out\n");
-			release_queue(kgd);
-			return -ETIME;
+			ret = -ETIME;
+			goto pro_end;
 		}
 		usleep_range(500, 1000);
 	}
 
+pro_end:
 	release_queue(kgd);
-	return 0;
+	up_read(&adev->reset_sem);
+	return ret;
 }
 
 static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index ccd635b812b5..bc8e07186a85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -420,10 +420,13 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	unsigned long flags, end_jiffies;
 	int retry;
 	struct vi_mqd *m = get_mqd(mqd);
+	int ret = 0;
 
 	if (adev->in_gpu_reset)
 		return -EIO;
 
+	down_read(&adev->reset_sem);
+
 	acquire_queue(kgd, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
@@ -504,14 +507,16 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 			break;
 		if (time_after(jiffies, end_jiffies)) {
 			pr_err("cp queue preemption time out.\n");
-			release_queue(kgd);
-			return -ETIME;
+			ret = -ETIME;
+			goto pro_end;
 		}
 		usleep_range(500, 1000);
 	}
 
+pro_end:
 	release_queue(kgd);
-	return 0;
+	up_read(&adev->reset_sem);
+	return ret;
 }
 
 static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2ac5e7..341ad652d910 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -540,10 +540,13 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	unsigned long end_jiffies;
 	uint32_t temp;
 	struct v9_mqd *m = get_mqd(mqd);
+	int ret = 0;
 
 	if (adev->in_gpu_reset)
 		return -EIO;
 
+	down_read(&adev->reset_sem);
+
 	acquire_queue(kgd, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
@@ -570,14 +573,16 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 			break;
 		if (time_after(jiffies, end_jiffies)) {
 			pr_err("cp queue preemption time out.\n");
-			release_queue(kgd);
-			return -ETIME;
+			ret = -ETIME;
+			goto pro_end;
 		}
 		usleep_range(500, 1000);
 	}
 
+pro_end:
 	release_queue(kgd);
-	return 0;
+	up_read(&adev->reset_sem);
+	return ret;
 }
 
 static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aeada7c9fbea..d8f264c47b86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -100,14 +100,14 @@ static int amdgpu_debugfs_autodump_open(struct inode *inode, struct file *file)
 
 	file->private_data = adev;
 
-	mutex_lock(&adev->lock_reset);
+	down_read(&adev->reset_sem);
 	if (adev->autodump.dumping.done) {
 		reinit_completion(&adev->autodump.dumping);
 		ret = 0;
 	} else {
 		ret = -EBUSY;
 	}
-	mutex_unlock(&adev->lock_reset);
+	up_read(&adev->reset_sem);
 
 	return ret;
 }
@@ -1188,7 +1188,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	mutex_lock(&adev->lock_reset);
+	down_read(&adev->reset_sem);
 
 	/* hold on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
@@ -1215,7 +1215,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 		kthread_unpark(ring->sched.thread);
 	}
 
-	mutex_unlock(&adev->lock_reset);
+	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -1395,7 +1395,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		return -ENOMEM;
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
-	mutex_lock(&adev->lock_reset);
+	down_read(&adev->reset_sem);
 
 	/* stop the scheduler */
 	kthread_park(ring->sched.thread);
@@ -1436,7 +1436,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	/* restart the scheduler */
 	kthread_unpark(ring->sched.thread);
 
-	mutex_unlock(&adev->lock_reset);
+	up_read(&adev->reset_sem);
 
 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2858c09fd8c0..bc902c59c1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3044,7 +3044,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
-	mutex_init(&adev->lock_reset);
+	init_rwsem(&adev->reset_sem);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
 
@@ -4150,10 +4150,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 static bool amdgpu_device_lock_adev(struct amdgpu_device *adev, bool trylock)
 {
 	if (trylock) {
-		if (!mutex_trylock(&adev->lock_reset))
+		if (!down_write_trylock(&adev->reset_sem))
 			return false;
 	} else
-		mutex_lock(&adev->lock_reset);
+		down_write(&adev->reset_sem);
 
 	atomic_inc(&adev->gpu_reset_counter);
 	adev->in_gpu_reset = true;
@@ -4177,7 +4177,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
 	amdgpu_vf_error_trans_all(adev);
 	adev->mp1_state = PP_MP1_STATE_NONE;
 	adev->in_gpu_reset = false;
-	mutex_unlock(&adev->lock_reset);
+	up_write(&adev->reset_sem);
 }
 
 static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 2975c4a6e581..d4c69f9577a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -225,8 +225,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 	if (finished->error < 0) {
 		DRM_INFO("Skip scheduling IBs!\n");
 	} else {
+		down_read(&ring->adev->reset_sem);
 		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
 				       &fence);
+		up_read(&ring->adev->reset_sem);
 		if (r)
 			DRM_ERROR("Error scheduling IBs (%d)\n", r);
 	}
@@ -237,6 +239,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 	amdgpu_job_free_resources(job);
 
 	fence = r ? ERR_PTR(r) : fence;
+
 	return fence;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 13ea8ebc421c..38a751f7d889 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -121,6 +121,7 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 void amdgpu_ring_commit(struct amdgpu_ring *ring)
 {
 	uint32_t count;
+	struct amdgpu_device *adev = ring->adev;
 
 	/* We pad to match fetch size */
 	count = ring->funcs->align_mask + 1 -
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 5fd67e1cc2a0..97f33540aa02 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -244,11 +244,11 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 *
-	 * we can unlock the lock_reset to allow "amdgpu_job_timedout"
+	 * we can unlock the reset_sem to allow "amdgpu_job_timedout"
 	 * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
 	 * which means host side had finished this VF's FLR.
 	 */
-	locked = mutex_trylock(&adev->lock_reset);
+	locked = down_write_trylock(&adev->reset_sem);
 	if (locked)
 		adev->in_gpu_reset = true;
 
@@ -263,7 +263,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 flr_done:
 	if (locked) {
 		adev->in_gpu_reset = false;
-		mutex_unlock(&adev->lock_reset);
+		up_write(&adev->reset_sem);
 	}
 
 	/* Trigger recovery for world switch failure if no TDR */
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index ce2bf1fb79ed..484d61c22396 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -265,11 +265,11 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 *
-	 * we can unlock the lock_reset to allow "amdgpu_job_timedout"
+	 * we can unlock the reset_sem to allow "amdgpu_job_timedout"
 	 * to run gpu_recover() after FLR_NOTIFICATION_CMPL received
 	 * which means host side had finished this VF's FLR.
 	 */
-	locked = mutex_trylock(&adev->lock_reset);
+	locked = down_write_trylock(&adev->reset_sem);
 	if (locked)
 		adev->in_gpu_reset = true;
 
@@ -284,7 +284,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 flr_done:
 	if (locked) {
 		adev->in_gpu_reset = false;
-		mutex_unlock(&adev->lock_reset);
+		up_write(&adev->reset_sem);
 	}
 
 	/* Trigger recovery for world switch failure if no TDR */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
