Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E83C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E617D10E956;
	Thu, 22 Jan 2026 08:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G8EN3kr+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011063.outbound.protection.outlook.com
 [40.93.194.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6ED10E956
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLIFro/y48oF8Lv1SB1xlbKFtzSGPOro3r/PeO3TqrTEbjk7DDgEp761gqIgZmvwPt1zsGRvGyJAZfAiy5/5ocyEPGG5wjSFu6w/k+PAFFaDPIrXeP4xZb9AlSLveOuYNDa4Hfp0JLG7CkiDUG6kh6fkAWDrNIuhG+Sn/qXhy6ir5J/SOBJgrm1SA/SETFNyQnqnO4WU6YsmDiKl3n88nxzszVs7QJnUc1CW1MmEzlhyqbyLrSoI5iK78Q4t0l8o9LbCCFXZsKG++JqVvEGBdjGwDxUsz3/d4jEqF70UgZhvPVCLP5GbICnsyiHOSN8xxOVm+/EeYf3HqAHH5iv2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Shv3B7Cl/Kw7B3XwrDmkAHJ0LulIFKxt9yV3X5GgHt4=;
 b=F8Njgkd0AgR1Rvah8WtQyu7lm6k/XHuN55nKzkL8SrVKHAf71v5N4jR/ttPyB7tc0FQat+05n2TNpsLQDvQbD+rs9a2kde3zvbbgRkI5nYMRllUqLXLwCToQhn0n8kH1fBY5FLUmZ5U9OcKTEk6Wa5stPIx1on3n9/HR/pfpaF4qRTYS2Lsl3jzIouJQYZkirZNkBkrwVtQaHAOf1OeudtCr15EF52S6wzxJcGX2Wu75ZkzWGLxkJSdblVifUcYREoZmh4F+tMg19ovcIa+pCDBXhuduvXg2OVhaxmh8dvY8UB3UYkVJmMdebmrHyzj5FfScP4KHjA0MEJ0d/33lfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Shv3B7Cl/Kw7B3XwrDmkAHJ0LulIFKxt9yV3X5GgHt4=;
 b=G8EN3kr+4tIbl5715N2P8JsldaGjk7zet3NVBfAlkHKWn3T7UoRbL89wcBWjpRM8NXfn9LoOrlCSzS3Cc++aCenWygxGDLlmKPdGhB9VVsH3HE8s43/+NIhyryw8fuWqDQVjNKTNT3WM/IscUcxOqy8kBCACx3DTa4qOGbWduwY=
Received: from SJ0PR03CA0127.namprd03.prod.outlook.com (2603:10b6:a03:33c::12)
 by MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 08:58:40 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::2c) by SJ0PR03CA0127.outlook.office365.com
 (2603:10b6:a03:33c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 08:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 08:58:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 02:58:37 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 02:58:31 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: Add ioctl for setting user queue CU mask
Date: Thu, 22 Jan 2026 16:57:18 +0800
Message-ID: <20260122085738.1542800-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e73a13-94f6-4887-f069-08de59947023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yu/w7lZT9vWky1V57azzykbLsxYv1h7juhPOD/m5afInUZB7G+EfROfTQuYF?=
 =?us-ascii?Q?d66tp92iIHdb9JtdnayjxQmuElpBA5BpMdEEJwMwogAG73BrbdXl0RFNkjVj?=
 =?us-ascii?Q?HLi48pLhG3aRRj4us1x3LPf/howyFDNtynLtRYZ6sbZhCAVyPw7xFNDYP6Ul?=
 =?us-ascii?Q?Mtw8SeiJl9StN2ezckSVJGgjswWAlkZGII679FFGmTHqVXUuVFTaJIPu8Ic+?=
 =?us-ascii?Q?MoEXoblplY1WhMzU4REYcsr+IyNbcCIbni4j9LBRZda2i/wOs8XZSgGlYXS8?=
 =?us-ascii?Q?U9w/ydvpE7sMTyL5Esw0GeZNLirS6FKWL3BA96deflYzM9TA73gWn5ymqObz?=
 =?us-ascii?Q?JpJK7FsILRUQx3r/Q2XGlBKOK2W76RblRzDFB1aGrYHbSOgCzfHQD9G0c4Ko?=
 =?us-ascii?Q?YDETFIqWv6WYCI88ekqfQGaVxeMkLsD/UFqd3Zm6IP5jcyw6nPVaI0YNJlbT?=
 =?us-ascii?Q?uki9FZsMUctRqy7mXVM59VLLry97PIQgm4g7J1BzxWpZgvTvbSgUK90b3jyd?=
 =?us-ascii?Q?1BQURzOz+6J4cdaFquy1kFuodkFV/2iJzrmXcTOsaye9XoMSO1B7w1+BA1r6?=
 =?us-ascii?Q?OtXR4DeCWMULuRNKR0mwH3MYCdw1wvMbRlGAYnUwxti62oLBGdvG10BFFo2z?=
 =?us-ascii?Q?6Gs9WG3PiEa6VrpivkhgM3YfmuKM/NkrHhREicyHSlOmkSTUMzzWrJr1l+V5?=
 =?us-ascii?Q?iJZcIhD2C03AdgSxLHS6//3a9++YG+tgBW5XEQQmtVoWDW0w+ndyFrs/qdmu?=
 =?us-ascii?Q?Ztu4ssqUHQWgZCRLje1i1AUedPuz5X+BFmoesL6T98Lvnp0i+UvrDhHW8plD?=
 =?us-ascii?Q?WaUr5bScFtRyOhUMWFVxF5MrtQceBiJWtbNDHKZKGQQclLBot1WP8yHFaEQR?=
 =?us-ascii?Q?oIB/CJQEpYftBkMXlnDfsSt+Jt+WneRE/ua6uPcTKYlZl/JHcwf2nQceQqKr?=
 =?us-ascii?Q?j/8T4ir/CJdNfqtMAiB2YyXXacWrTMJNvr1Ee7F6vrbTjRuMBes/jIyufGtm?=
 =?us-ascii?Q?VBUV3n5b11aRS+W8Q5KQxygeGbrQ31F3IpIn9yFrGPnaDC3cU6+55WhdP/MO?=
 =?us-ascii?Q?++QkuhCvUP3u7j1hS+tAuGWy61u10JSr5UA3te9KJmtR7MBPdHoxyoMl5Oa/?=
 =?us-ascii?Q?CKWWQEgp6WBO5hjwhX1viggM06gYZsfwHRFIsbL/EJsIyM8U/BedKrbpmdnj?=
 =?us-ascii?Q?VEifRsj3G6OvExjpcTQ685g6HhpAGT613OKTcIj9nX4pofetIrZ8vfbi7f8f?=
 =?us-ascii?Q?8Iz/Z3tIelsKxK3W3fyjqEXimUy+r4h715Xtbqr8s7a99ongpUwiyD/iOpsV?=
 =?us-ascii?Q?nWe+QC7yxIMDjRWcdUnSa+dmthKbNea+wMQTwgkYyhDDos8u3/Yq4YHncRUO?=
 =?us-ascii?Q?zNRJ7RodXNhL0ufnfeirFE9IDQEXfumlH9FFmUS5O90pk49789u+wKHDmtQQ?=
 =?us-ascii?Q?6Kx9LovU82u0uL7KlFY7/DxA/k4tv4UkX+fKKnCPH2idgvQvcshqAMZPSXBd?=
 =?us-ascii?Q?N3y/efrGq7lVY503NYnlK6XiO8vhSaIDOBNaOPtsVM1xlKbbTNRjSYljHZX4?=
 =?us-ascii?Q?qij8wXCkj4YBjkZLfYdXOsTq1cNUG5HD9WXtPm9TJJEFSDhRS3B8p4/q7dLz?=
 =?us-ascii?Q?TdRufmpWHmJlyfqDjidot4VdtA1NJ81LlohmrnRJDBmwNNgxE7vHJtXZMneJ?=
 =?us-ascii?Q?CASkzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:58:40.3286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e73a13-94f6-4887-f069-08de59947023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491
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

This patch introduces a new DRM ioctl to allow userspace to set the
CU (Compute Unit) mask for user queues, enabling fine-grained control
over compute workload distribution.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 107 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   3 +
 include/uapi/drm/amdgpu_drm.h             |  12 +++
 4 files changed, 123 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d67bbaa8ce02..9c425169a4f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3075,6 +3075,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SET_CU_MASK, amdgpu_userq_set_cu_mask_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 256ceca6d429..4cbf75723c08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -901,6 +901,113 @@ bool amdgpu_userq_enabled(struct drm_device *dev)
 	return false;
 }
 
+static int amdgpu_userq_update_queue(struct amdgpu_usermode_queue *queue,
+				     struct amdgpu_mqd_update_info *minfo)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *uq_funcs;
+	bool unmap_queue = false;
+	int r;
+
+	uq_funcs = adev->userq_funcs[queue->queue_type];
+	if (!uq_funcs || !uq_funcs->mqd_update)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Unmap the queue if it's mapped or preempted to ensure a clean update.
+	 * If the queue is already unmapped or hung, we skip this step.
+	 */
+	if (queue->state == AMDGPU_USERQ_STATE_MAPPED ||
+	    queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = amdgpu_userq_unmap_helper(queue);
+		if (r)
+			return r;
+		unmap_queue = true;
+	}
+
+	r = uq_funcs->mqd_update(queue, minfo);
+
+	if (unmap_queue) {
+		int map_r = amdgpu_userq_map_helper(queue);
+		if (map_r)
+			dev_err(adev->dev, "Failed to remap queue %llu after update\n",
+				queue->doorbell_index);
+		if (!r)
+			r = map_r;
+	}
+
+	return r;
+}
+
+int amdgpu_userq_set_cu_mask_ioctl(struct drm_device *dev, void *data,
+                                    struct drm_file *filp)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_set_cu_mask_args *args = data;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_mqd_update_info minfo = {0};
+	const int max_num_cus = 1024;
+	size_t cu_mask_size;
+	int r;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	queue = amdgpu_userq_find(uq_mgr, args->queue_id);
+	if (!queue) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
+	if (args->num_cu_mask == 0 || args->num_cu_mask % 32) {
+		r = -EINVAL;
+		goto unlock;
+	}
+
+	minfo.cu_mask.count = args->num_cu_mask;
+	/* To prevent an unreasonably large CU mask size, set an arbitrary
+	* limit of max_num_cus bits.  We can then just drop any CU mask bits
+	* past max_num_cus bits and just use the first max_num_cus bits.
+	*/
+	if (minfo.cu_mask.count > max_num_cus) {
+		drm_file_err(uq_mgr->file, "CU mask cannot be greater than 1024 bits");
+		minfo.cu_mask.count = max_num_cus;
+		cu_mask_size = sizeof(uint32_t) * (max_num_cus / 32);
+	} else {
+		cu_mask_size = sizeof(uint32_t) * (args->num_cu_mask / 32);
+	}
+
+	minfo.cu_mask.ptr = memdup_user(u64_to_user_ptr(args->cu_mask_ptr),
+				    cu_mask_size);
+	if (IS_ERR(minfo.cu_mask.ptr)) {
+		r = PTR_ERR(minfo.cu_mask.ptr);
+		goto unlock;
+	}
+
+	/* ASICs that have WGPs must enforce pairwise enabled mask checks. */
+	if (minfo.cu_mask.ptr && adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0)) {
+		for (int i = 0; i < minfo.cu_mask.count; i +=2) {
+			uint32_t cu_pair = (minfo.cu_mask.ptr[i / 32] >> (i % 32)) & 0x3;
+
+			if (cu_pair && cu_pair != 0x3) {
+				drm_file_err(uq_mgr->file, "CUs must be adjacent pairwise enabled.\n");
+				kfree(minfo.cu_mask.ptr);
+				r = -EINVAL;
+				goto unlock;
+			}
+		}
+	}
+
+	r = amdgpu_userq_update_queue(queue, &minfo);
+
+	kfree(minfo.cu_mask.ptr);
+unlock:
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return r;
+}
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 1ff0f611f882..43bf104d2fb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -115,6 +115,9 @@ struct amdgpu_db_info {
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
+int amdgpu_userq_set_cu_mask_ioctl(struct drm_device *dev, void *data,
+					struct drm_file *filp);
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev);
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ab2bf47553e1..41b6b3cea834 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
+#define DRM_AMDGPU_USERQ_SET_CU_MASK	0x1a
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_USERQ_SET_CU_MASK DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SET_CU_MASK, struct amdgpu_userq_set_cu_mask_args)
 
 /**
  * DOC: memory domains
@@ -428,6 +430,16 @@ union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_out out;
 };
 
+/* IOCTL arguments for setting user queue CU mask */
+struct amdgpu_userq_set_cu_mask_args {
+	/* Target user queue ID */
+	__u32 queue_id;
+	 /* CU mask bit count (multiple of 32) */
+	__u32 num_cu_mask;
+	/* User-space pointer to CU mask data */
+	__u64 cu_mask_ptr;
+};
+
 /* GFX V11 IP specific MQD parameters */
 struct drm_amdgpu_userq_mqd_gfx11 {
 	/**
-- 
2.49.0

