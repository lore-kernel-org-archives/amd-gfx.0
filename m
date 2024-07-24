Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A05BC3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 18:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA9CC10E78F;
	Wed, 24 Jul 2024 18:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BFSCv4n5";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3D510E78F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 18:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPmORdWls+3Ry6k4U5Rt58H1ynAVZsWIqiU+GPGCS7ubkRLgx8LGHImnpwT4uC1M44G1UEICDwm8SEwCUrYoxgk3d+NvOMmVUwufdNFu1yRfN5o6AelKpL/dWQ4IUNNXK8zisQbZcJkO0wbJ9L4dxbHtVCmzPW4oCZEKd7S0o4en1MvDCQQFDDQAwO3PoltxYJRnOgdycrDCFAepPk9osp/bjZhNtglayKBKvc/SrfPR10RAF8Kvd7KUWvzaJ4I5JlO/IOn4U5PKpYCMrn8v6jT2KSEp5wX4sQmEu/XttZLX4McX1ydolHDLYC/9rYrKj4hZV0LK50rZB26ywItW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEuuI8StZXi/Cd19XiLrh2urWtJ7qKgml+Cou6v44fo=;
 b=RaiIJBIhca+IhsIsldc/ej8UnlR5nryLRS7UIEG8JqXp700RGgx3txqUYOjEEbCu2/+SU5kav9UOBhtwbk054vuuYH7pquAkkK1Kx4MlADqWFzn/rdQEKPgOHKLcSaIvhnBbYnEIMirJvsYJ6bUB6yjCPwo2cKJouP+REjpIeSGxqQ+AmO7ZkvSv4GRpv25+4pMATZ64pBkAX/8y9+icTDha6M2VXohQQZ9hHRsjMS0H/P5keLlB3haOlEjWdQwIUWr05RyAGIldBixQ2ObIRqfGWVSvlRWmStlcnBJKTCCTPLTlw9Z1TX4UqHLm4W4GcSMdMAjPIkVa2AeJLQtQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEuuI8StZXi/Cd19XiLrh2urWtJ7qKgml+Cou6v44fo=;
 b=BFSCv4n5Zc5bnScVxZdkcGdqPVbzR8TJ/RfV6HBw4KdmHiIbCArNixlE2tiWjBBQ7r8w+qN2+UhzCwIhKOCJSA5N9djBTIs3N0n/rBzKHz0bA4DOipCkYFiDJTspaN4meb3Y6jd6bGN0rWXapRCfDiMZBNQjOpFCLx/8fjw4820=
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 18:43:10 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::b7) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Wed, 24 Jul 2024 18:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.11 via Frontend Transport; Wed, 24 Jul 2024 18:43:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 13:43:08 -0500
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 24 Jul 2024 13:43:08 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <jesse.zhang@amd.com>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH] drm/amdgpu: Add error parameter to
 amdgpu_fence_driver_force_completion
Date: Wed, 24 Jul 2024 14:42:50 -0400
Message-ID: <20240724184250.183154-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e350632-8343-4e13-35ce-08dcac107715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c1wy/Hy5DcHVrmz3Lch2+np3dCqmvcSiEnUlbAj8h07ncF2Tgz8QnFgU3EuT?=
 =?us-ascii?Q?UpN7Fax/fHQwXvlrSwEJ8r76UwyV0Cjnb/AaCMW6O8aaGFc+vssGyNZrZ0Jq?=
 =?us-ascii?Q?txfpRSPzzF+8SSiEgicUUmGr/vcXxsp0goR/DEE0AX+1sNH824HzlGcnQbd6?=
 =?us-ascii?Q?oSXPcqBXblxDzXmmNZv6/LkFAL4MFEZ6KVgxiKySLF4QKvw7Kvn94I2oEwow?=
 =?us-ascii?Q?BubjXqzjZDSzlKQEjnnFZxtmEszftnbi/KN3JQoiMPffWHlC6MhQcwLjKcmW?=
 =?us-ascii?Q?w3gaTxqb2bzAxjhlsKkBriuy7OckmiIsYBgtkBWys6U9/omdyoYsPbAvjwCa?=
 =?us-ascii?Q?RqXciCjWeJ2PQwBpI1qOaB8mSD9eM6HqUvgKSG4W3szkMGSJb13lnUq5uLYy?=
 =?us-ascii?Q?NUVFjmAI6zipPlURBFj1bhv48Xl25QWLepYuON7wE985EjE1JSYtxtBv38rZ?=
 =?us-ascii?Q?LcpHL8ZGCrlQrGeUf4J//nhWt3LNXiCxEn10Xhc3RyasvQ8ZwdTDpHZKCXxa?=
 =?us-ascii?Q?k/FhMZKcVsV1XSmN2Wa5YnMkiESXGZ0GJJr4iojqAl2ze/Q9ludSWx7T2rsi?=
 =?us-ascii?Q?HRp7bXJzIPDjNmXS4B1bjZXfX5Gxr0IErY+FsxzmK4+0Q8ij10Ykklk7H/FI?=
 =?us-ascii?Q?F6TU9KDf0TB8vdSrT4yDaTMM7YC3f9+L15nCLxtbd7CGHu4bc4HfzK/PxCOC?=
 =?us-ascii?Q?AXAN8LrFO87pNet3e9wfDZW6OaGbYPZMWjRdas0QdZ4x5DfJ7QcmPjLRvFT7?=
 =?us-ascii?Q?AIUdzBZ5gchsXx2RY31GauID8RHH8T4cHfvK1kbVCl+mp9a7rLX3XU/wy05V?=
 =?us-ascii?Q?s/+Z0tq+z1pDrDFhXmxRy/Aluq8P9tafQ1Ttg6WTA9djIAjRZ/v+bQHL7pSY?=
 =?us-ascii?Q?sx/ISDlrDtqNz2KIPnolTVX+fftBAdHBvhd4W6qyC+NzcWdPgh0Upok29/pi?=
 =?us-ascii?Q?vnU2sqn/83berbNRJj2W0LDnN6PsbWFAIVm3m/iX25uSqWHNPSqr6xM6kjqA?=
 =?us-ascii?Q?bpZJR18UXHcUSAZy6TwTye9p9Ib3x/drgqxKtJvUWunGpVbkx4abnOhLhaWc?=
 =?us-ascii?Q?0HSyBWYhfSBI17JaE4dvhOFV/CUZ1fTloVseeHvEuY1bOiA96lfPyP1O0v7F?=
 =?us-ascii?Q?ptrvCZadx5BUb1RBPGDCaD5Ga+u7P9qdWjX408y+H733a7n2S24SMLfFcF27?=
 =?us-ascii?Q?cSzv2FchgWQB6OLFRW7FZFIaUashWo3g56GMB2tN3xRUM1E3b6jEmY0R+hEj?=
 =?us-ascii?Q?p54FkR7QBBoagSxqVSsXn7NtC6EOynFecN7s8AWkj61+qQZ2oH5EaouKazlw?=
 =?us-ascii?Q?+7F4KLO2ugy4aqe4F92X8AWGktq26wKnNBsGCUPxl4+b7KytvgtzvxZfOWRx?=
 =?us-ascii?Q?N55TVsfPFknrElOpetDsN50uY56ma1YmeIx8z0M8oHcz2RAB0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:43:09.5381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e350632-8343-4e13-35ce-08dcac107715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

In the case of a queue reset, we need the ability to customize the
error code from -ECANCELED to -ENODATA for scenarios where the queue
reset is successful. It was decided to use -ECANCELED for GPU reset cases
and -ENODATA for queue reset cases. This change introduces an error
parameter to the amdgpu_fence_driver_force_completion function, allowing
us to specify a custom error code for these cases (queue reset or GPU reset).

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0e1a11b6b989..a2b42c079bbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1960,7 +1960,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		/* swap out the old fences */
 		amdgpu_ib_preempt_fences_swap(ring, fences);
 
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, -ECANCELED);
 
 		/* resubmit unfinished jobs */
 		amdgpu_ib_preempt_job_recovery(&ring->sched);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 730dae77570c..441eb8757d09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5308,7 +5308,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		amdgpu_fence_driver_clear_job_fences(ring);
 
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, -ECANCELED);
 	}
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf..ac4942fdbae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -610,7 +610,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 			r = -ENODEV;
 		/* no need to trigger GPU reset as we are unloading */
 		if (r)
-			amdgpu_fence_driver_force_completion(ring);
+			amdgpu_fence_driver_force_completion(ring, -ECANCELED);
 
 		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
 		    ring->fence_drv.irq_src &&
@@ -757,9 +757,9 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
  * @ring: fence of the ring to signal
  *
  */
-void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
+void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring, int error)
 {
-	amdgpu_fence_driver_set_error(ring, -ECANCELED);
+	amdgpu_fence_driver_set_error(ring, error);
 	amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
 	amdgpu_fence_process(ring);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 582053f1cd56..045a2a548b80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -130,7 +130,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
-void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring, int error);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 07d930339b07..ec440bb763d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -511,7 +511,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 			/* to restore uvd fence seq */
-			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring);
+			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, -ECANCELED);
 		}
 	}
 	return 0;
-- 
2.25.1

