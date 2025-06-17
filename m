Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E3FC71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64CFD10E553;
	Tue, 17 Jun 2025 08:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cykFRUwR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0F510E54F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzWz3U+0j8EMMkNoEGDEfh4O77mLWQSLn6JAdyJ+5h+DGpSEyMqRF33Ndagk2N569DbtdjKXP+6859x3Z/Wz3s9LLTLe5nqvoFL9+UzLb7FrOOZMRUvmiHm/DP+uYAurWDFx14pr7TX6+zsHtvmewg2UxeMqNEzY1fttKuQTMF7z/hG8Yq4EJtVbBgkdAgzRfbCtxuPw0VZfINVCTdCRSCkWYPU0Th8z+vE3w2N7joVezxkIY8SGZ0B6XAWjHhk/vkoiF6nlIo/p1S/E6RWD8NjdjcnsjX5P8A15WrQ8Pd8rl3R+0GpRnSQkEH29imuTBDc58x871yE5YkoRuZdG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1ZKbjFzxtn9su3VrA9f6buhQ1oz189xeaGiNIFl0XM=;
 b=SL8hM1YOkKugCCs3h5qXXWkFwKy7INkbb4X+7Q8zRYFwPdBcK2qoFvAi42lr89kjZCAA84aN3q4ogmT8C8iEjSFNGjMXsl1vNQwo7NTOSHxpMMuJem4pWFkZmn7ceLK81Z9hIpRaLd62zlrPfPUPsPSV/UlQHB5sYJ5ubEZE0TBstV71eIDvvXDlvsCMLQv5qXvoF8PiWhxcjJlAUA2cJklrPKSj6GJZ0aKpIS0by9XGieV/t92Rgq4VMVkV9L+NlMjx//eb58N0wpuHD6A+e4wToBBZgIbZ992CEW/TcOJf/cr0WdLHThFCXRhmMosZ5eX0Be7I7hWlWKZy4wPYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1ZKbjFzxtn9su3VrA9f6buhQ1oz189xeaGiNIFl0XM=;
 b=cykFRUwRroA1OqVqKrovRQ0tFOlil3iJuwcXCtbdVFQscos5VQ9lpz8FR1XxFmllK1DTZQRQRGnOqoF9DIs9qTyCPaH0ariVUuDmd0vqswSCObDo2r+9gXLB39WMO4+UP98uC9FAaj7QeInwk5B4vB3TY3iQgUI4+q84JildR+o=
Received: from MW4PR04CA0075.namprd04.prod.outlook.com (2603:10b6:303:6b::20)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Tue, 17 Jun
 2025 08:02:26 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::7b) by MW4PR04CA0075.outlook.office365.com
 (2603:10b6:303:6b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Tue,
 17 Jun 2025 08:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:23 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 09/11] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
Date: Tue, 17 Jun 2025 16:01:49 +0800
Message-ID: <20250617080151.1093481-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 1838470b-fb0d-47d5-2655-08ddad754c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ijmkW3czB3z9mcuWBVR6XP/2y2EMQfFi/j2vLXYOSXj+pHkVP3RjB+3zZj7?=
 =?us-ascii?Q?YfzpqcaWodTRDM7L3KPjBGtuQ+n6V8rDEPx3UHtRCw2lxwu4Ym6EEYMAS6Qv?=
 =?us-ascii?Q?0qqZdaDeOIahNOS8yG6Dvo7ifH6JCsQTbWIBCRqxijmR3NiSYct+8jR8Qu82?=
 =?us-ascii?Q?ZKEhU3yFVXL294zArexwBLC8AnQ2nOBnhvQjHzPCJvCE68iJX0d2lkQpySzm?=
 =?us-ascii?Q?QajgjuDVjGaOVg4JjiHBVZ8BUYHtg2YjoyqwrGrG2QWL5ofvEL7/PCXfcgMJ?=
 =?us-ascii?Q?PoNksx135duygoYg3ayZLH09w2ryjk4zQjuJfb3DvvHIBBOi2aw2XY+Kq2Dy?=
 =?us-ascii?Q?6o0T9WHrioTC56dQ0oUR4r91jcE+vJ8zYHGL4UYW7qLlBEJqj+KGZftNY3Mv?=
 =?us-ascii?Q?eDFlWIugwuDYdLVIlzMAHa1dIpNa95Ud6cjX6NAuebojqKfKZztVz/brpyMn?=
 =?us-ascii?Q?1PjkVhJ3TpHxrwGe00aj5gQlXcoJdWh9OcIzUUkhGCcjy6ewzWF5Em0ST/Yj?=
 =?us-ascii?Q?JGCKspYt1tfEq3KLV4LKIhxGBPDhywJRd5haBr963GbHpUcaUp6t2Vkt5H2Z?=
 =?us-ascii?Q?LNnK6QxU+f+y07Mee+qokUidxBcDO0rMCAMhEGj/67fO7PYRLrO9mtkjzn5t?=
 =?us-ascii?Q?umo5eDrTXiOIrgkgT0xSMhXffnyrwS99Q4wG9EJCpNVjkrhHLlUrNnuJmS4N?=
 =?us-ascii?Q?zorqp8ZhN93OluQlv50Z3P8rB/ss4gzu+0c2q2jyBKoau4Luy60VtcVEokp1?=
 =?us-ascii?Q?K4brAmpM0zXANrPTF53xl1wiDxOHiy9dYQDD92QAAlT7Zz2OzhZgjNgJAHzr?=
 =?us-ascii?Q?k5UbyxLfXQeHMWHOiH4EoWb/1LYHCafK2kcuBZvou1TJ5BCudf7Odp3LB1Gp?=
 =?us-ascii?Q?VFowbECtC0IG8V+U7fQI+wD6DG0nO5RpHVv3Kf+DyZJ7G9kJ2gFqbxTvMlcX?=
 =?us-ascii?Q?xnpdqcsd7fuQOfF6e5nkNfcbCdPGL5s4eIyWcI38NTTdplGMfYBn/Y9LgJvC?=
 =?us-ascii?Q?qM4q9d5oAX4n/fpL1Y7syDZwSNOCM61zLio1BG620wmqWHYcAzAVNVnd0q0e?=
 =?us-ascii?Q?wiL/pJCQT/fKc/F6RCrb8lyJhWouYNcmeINV7PlVgnrNBzxJXh0jw1lGHJWy?=
 =?us-ascii?Q?Y8tXM0A4zBYZbBlAD95yaNoENIiEi1ZHwvtWL72ZiU69gJW/rcjOgIC+2FJP?=
 =?us-ascii?Q?IDjskNvptm6XOa5COUuyrFXVj6HghZfOGMNUWcmFdbiNIyKz+48yn39aiAaZ?=
 =?us-ascii?Q?bj3qPEHm/NGsjSKtPPMXfbFCNmWWj3c+VzI63K+h2Jt/d5uXP51Pdv2zZGbS?=
 =?us-ascii?Q?FgPqlwy3VpJ8c5jS71p7y5+TJK+BQAulXydz+d7mreto7L052Crof513j6Gh?=
 =?us-ascii?Q?sBdxHSz+l143900sgGmBWkmF5whu5iBkuNgEcHTQEcPMNL4mpHX3l3yV9KP1?=
 =?us-ascii?Q?SOWULkVas5wCwSkOkkjw+WZAjyjnSWLShwJ71nbb14ZC0GL0MRTcIvygfz4g?=
 =?us-ascii?Q?KNaYXrIvI8TeR07T/NkCoiphiSnQKfmO/R37?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:25.7720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1838470b-fb0d-47d5-2655-08ddad754c48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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

The userq VA unmap requires validating queue status before unamapping
it, if user tries to unmap a busy userq by GEM VA IOCTL then the
driver should report an error for this illegal usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f04b51ded06f..be3220a973ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -225,7 +225,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -234,10 +234,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 
 	if (f && !dma_fence_is_signaled(f)) {
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			return -ETIMEDOUT;
+		}
 	}
+
+	return 0;
 }
 
 static void
@@ -453,7 +457,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
+
+	if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy userq\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
 	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
 	if (!r) {
 		amdgpu_bo_unpin(queue->db_obj.obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5e075e8f0ca3..afc493f43256 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
+	int r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1949,6 +1950,13 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 			return -ENOENT;
 	}
 
+	/* It's unlike to happen that the mapping userq hasn't been idled
+	 * during user unmap vm except the vm unmaped forcely from user space.
+	 */
+	r = amdgpu_userq_gem_va_unmap_validate(vm, saddr);
+	if (unlikely(r && r != -EBUSY))
+		dev_warn(adev->dev, "Here should be an improper unmap request from user space\n");
+
 	list_del(&mapping->list);
 	amdgpu_vm_it_remove(mapping, &vm->va);
 	mapping->bo_va = NULL;
-- 
2.34.1

