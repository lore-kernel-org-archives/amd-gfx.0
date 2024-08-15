Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DF9C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA3B89823;
	Thu, 15 Aug 2024 00:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U/6ELoP2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 182D910E331
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9Wkc0EcmiMOF3ljh713b4ZwPkTYSrydyqw3lcBfraopLS/5dQKFx7YDpzPoqfKUX7w97Hu8IGrhM073DBL9dwI1PlNJFU+XpRQ9nd0QXR6TqErGruWP83mz+madmGNqbhtItVLlniQvS1WKiSIU5mcHfYbJF5Dz2CluTp/JyzE2UEUK7qz0c2j/YQw35krZDapdZ20UtHNJkF3aMbLTUh8JC9Bbv3HrVtZt4wNTtqTrWuSTbut/udcUbZXGqgLbIiG3l4XgNO1IXoxlymigYRvz6yLOyt5htw0Pb0RHDnKgDEKbp1X4hI8EomC/ZPj5Ur66lPIMoLXP5CZT/3RYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2oaHRG+0bM29ZlE153aWRC36mRDbntnv0lmC7+t838=;
 b=wACRI+VJEk07lf/ODQU6382xUnPxUJTf/XTU4kWoQyKGWEJ6m5QxoLnECZrbshEZoyhfbr3f06rxY3n7P75/THld/I+yUrnIm5tjUUNZPne/INp8Oiwj+QWPrcTkPAvdX/rZHA5Y9dDjcuIMabOijHpd/Weidv/dg3i6T8xHzyLiIZ5cZI+C1nPGkVB/8J5ZwIdllXeH+nhJQX+Dfz9IfWJQErzgr0CrlEogz5P+xXmCTUekuPyvao9XfsJ4htkWnwuSxL/rM3qwMskzl2z3ZSoXOBRfHdhBqGa4AEhe8fo7g2z1sRCmEA91yi27L0Wr0rPm+cIS8isEAiE/AzbZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2oaHRG+0bM29ZlE153aWRC36mRDbntnv0lmC7+t838=;
 b=U/6ELoP20MzLnAEBO64R2+bUlfyLjgaN5GEOHhXZ7E3NUX24opBr6KOek4QLwlDbok2Efldn5FwERvqmOTAHMgaj33PVgEMy6EGB4T/ikhjUXeQJ+huLtl0GVBrDn+5cUIy9W3+NgDJ4x24ypCpYzG/F6956MYiJRvKtLAAWS0k=
Received: from BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::12)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 15 Aug
 2024 00:05:22 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::85) by BL1P221CA0001.outlook.office365.com
 (2603:10b6:208:2c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 07/17] drm/amdgpu: Add sysfs interface for running cleaner
 shader
Date: Wed, 14 Aug 2024 20:04:51 -0400
Message-ID: <20240815000501.1845226-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: eb235810-fa82-4ab0-dcb1-08dcbcbdf519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0pzbWRxSS96TzhRaFlZalBRQUFqQ3ROWWVkTmRHUjQwVnhWM1JGSVMxT3Vm?=
 =?utf-8?B?alFGcXpKZGYwWjA0OEIvUkVxVGdtZFljSHBFZS9XSmhhSllSYUxyY3FZMk1P?=
 =?utf-8?B?TGZ5M2tDZG9CaGhScEVON3VjbEx2RUZ1YWtWclgxU2htN1J5K3QzYXNQdkxr?=
 =?utf-8?B?V2FjL3ErN0Y5NGlobFdQNGlLb205WjY5bVVJNXdXYjF1dGcyVmJ3bUIvYytY?=
 =?utf-8?B?OURsRzJudHZsd0JWZFp2WTNsNkN0cU9kNmdaMnA0MlN5R1J2UU5wRXhCamh4?=
 =?utf-8?B?T0k3enFpOUoveGQ1alZ3ZnhjbTNWTFpMbkNwRjdVTEg4TllVeHU0NTZzb25X?=
 =?utf-8?B?c0piWHhGRno4SmZNMjR6OURiMmY3bWlSOEYwMzhLVENzOWFpUk95NDdORlBs?=
 =?utf-8?B?MkcrU1FBYXgxcSt3RFpSTG51dHRWOXRkSHRMY0hhYVhTWHpXOTluMVVDYytu?=
 =?utf-8?B?eFBBc0RPUnlVejFtMnhBWGNudXZpTmY2Y09rRzB3bFU3WHl1UEhOZGdVeWFk?=
 =?utf-8?B?QlYyV2FuT1hpbm5kVjhXTHd1YUxPRSsrMk5taDg2Snc5RVdRQ1I0Lzh3ekFz?=
 =?utf-8?B?YkRKSlhnbzRtTW10M2tQaldEUEc5ZVVoR3hsQkFvQkFkWXQxRTg5dkNoSTIx?=
 =?utf-8?B?RGJLeWhwdG16cDZtT1BTZVRoajlJQlRDNVh6ai9MVnBFd0NCZUg5UzNlOGRT?=
 =?utf-8?B?djROU1BKL0RZcEcvVWZBSmo3WGpnK1FueVNXOGxRK01vd0RqVkdaNVFyMGsw?=
 =?utf-8?B?a2M5dmpuVGpNV1Q5ZUxiUDNWdXY1NEw4UzlZa2FFdkxxa09KRFlVSlY5YURJ?=
 =?utf-8?B?QUkvdzFyemwvRjN2WS9VeTJ5bkFYVmwrQ0xSOFVMeDRSbmNINis0NTdLSWds?=
 =?utf-8?B?UDh2bVVoWDZLTDl2QjZtYjA1YVZyT2ZnV0lSdzM5WVpZV05KQXhGa0xYOFk4?=
 =?utf-8?B?NXd6aTBNb2RxMkFhREFDY0F5dms0b3B6VWtZbTB5T2hHeHFIYnE1L1lyTUNO?=
 =?utf-8?B?VW5PSEszU3NGclVvSi93NVM2dlZSZHVGb25QNWl3bDZzeFBMVGIwTnZZaGww?=
 =?utf-8?B?K2txU3NnTThMK2NPNkJBTnVPMmpvT1duYXE1eWcremJDd3U5eG93S2xMQ3hY?=
 =?utf-8?B?V0QwTlN6K0tQUllSL0lHTUVxQisweUFuUk1xNGpCMUNCKy9QUGcrRGYrMWtV?=
 =?utf-8?B?L3RqTjMyR0xudHFISmJ0bHoydUVmd05GR2p3UUR1TzM4cHF5WUw0aXM2Nzhs?=
 =?utf-8?B?Ym82UHJic0NyZmtCYlBYLy8xZDRyY3V0MkN5cEtZKy9YNGQrbzFWQndSWm5P?=
 =?utf-8?B?Zmp5ZTRKRTdMd2FRaG1aTGdIQ1VtVklBZVB4bEt4N2JieitLQ016aTh3UFZI?=
 =?utf-8?B?bFdEM25yTkN1aWdObmVRZUY5Q3hraWJBZ1dUa1NJTGpIamo5Tk1GOGhLbmk3?=
 =?utf-8?B?M2YwNHJvdkdCb2ZPTkZWenlrUEN6ZzZuYWxrSHA5TGlPdC9LMHNXcnJiQm1T?=
 =?utf-8?B?N1o0ZGxEb2NhVGZqSEFEZUh4cEcwOXlRdW5tWWg3aVpTc0gya2lkSitKT2hl?=
 =?utf-8?B?dVJVZFNWR0xwUTRVVEhWdnJzbzFWSksvRnJVdWdianB5cmZ5UFVNWHByNS9M?=
 =?utf-8?B?N3FEY3UrWXdML1pvQkNRYkdEU3NtWjZYZTVnbVAzVTVjU0hTVVZHN1ZqblRH?=
 =?utf-8?B?QnRFWXh0cVZUenhpZkRUcEtFZk1NWVUxQjNrbzM1enhnV055VGN5Z1BXZ3dM?=
 =?utf-8?B?RDlDbkM2U0hWL1UxcFIzbExwTjVFcGFBK2tDVzkvR1RaSTNOZCtleDN2THpw?=
 =?utf-8?B?UllPUEVwa29aSUVpNmNUZVF4Tk40Ni9YTFlxcFRYT29wRW0xZVA3cFRDK2xs?=
 =?utf-8?B?QzA1RUh2dHUyVE42bmNxeVZLSC9wR3NReW5yYXZsNmFKV1E0emtNVjh4N2pK?=
 =?utf-8?Q?1mju7EhFdlgTrmWCkm7fKKtmGz1vFnn/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:22.5940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb235810-fa82-4ab0-dcb1-08dcbcbdf519
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This patch adds a new sysfs interface for running the cleaner shader on
AMD GPUs. The cleaner shader is used to clear GPU memory before it's
reused, which can help prevent data leakage between different processes.

The new sysfs file is write-only and is named `run_cleaner_shader`.
Write the number of the partition to this file to trigger the cleaner shader
on that partition. There is only one partition on GPUs which do not
support partitioning.

Changes made in this patch:

- Added `amdgpu_set_run_cleaner_shader` function to handle writes to the
  `run_cleaner_shader` sysfs file.
- Added `run_cleaner_shader` to the list of device attributes in
  `amdgpu_device_attrs`.
- Updated `default_attr_update` to handle `run_cleaner_shader`.
- Added `AMDGPU_DEVICE_ATTR_WO` macro to create write-only device
  attributes.

v2: fix error handling (Alex)

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 134 ++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2e35fc2577f9..76f77cf562af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -24,10 +24,13 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/pm_runtime.h>
+
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_rlc.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
 
@@ -1391,6 +1394,129 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
 	return sysfs_emit(buf, "%s\n", supported_partition);
 }
 
+static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	long timeout = msecs_to_jiffies(1000);
+	struct dma_fence *f = NULL;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	int i, r;
+
+	r = amdgpu_job_alloc_with_ib(adev, NULL, NULL,
+				     64, AMDGPU_IB_POOL_DIRECT,
+				     &job);
+	if (r)
+		goto err;
+
+	job->enforce_isolation = true;
+
+	ib = &job->ibs[0];
+	for (i = 0; i <= ring->funcs->align_mask; ++i)
+		ib->ptr[i] = ring->funcs->nop;
+	ib->length_dw = ring->funcs->align_mask + 1;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r)
+		goto err_free;
+
+	r = dma_fence_wait_timeout(f, false, timeout);
+	if (r == 0)
+		r = -ETIMEDOUT;
+	else if (r > 0)
+		r = 0;
+
+	amdgpu_ib_free(adev, ib, f);
+	dma_fence_put(f);
+
+	return 0;
+
+err_free:
+	amdgpu_job_free(job);
+	amdgpu_ib_free(adev, ib, f);
+err:
+	return r;
+}
+
+static int amdgpu_gfx_run_cleaner_shader(struct amdgpu_device *adev, int xcp_id)
+{
+	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	struct amdgpu_ring *ring;
+	int num_xcc_to_clear;
+	int i, r, xcc_id;
+
+	if (adev->gfx.num_xcc_per_xcp)
+		num_xcc_to_clear = adev->gfx.num_xcc_per_xcp;
+	else
+		num_xcc_to_clear = 1;
+
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
+			if ((ring->xcp_id == xcp_id) && ring->sched.ready) {
+				r = amdgpu_gfx_run_cleaner_shader_job(ring);
+				if (r)
+					return r;
+				num_xcc_to_clear--;
+				break;
+			}
+		}
+	}
+
+	if (num_xcc_to_clear)
+		return -ENOENT;
+
+	return 0;
+}
+
+static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf,
+						 size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int ret;
+	long value;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	ret = kstrtol(buf, 0, &value);
+
+	if (ret)
+		return -EINVAL;
+
+	if (value < 0)
+		return -EINVAL;
+
+	if (adev->xcp_mgr) {
+		if (value >= adev->xcp_mgr->num_xcps)
+			return -EINVAL;
+	} else {
+		if (value > 1)
+			return -EINVAL;
+	}
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	ret = amdgpu_gfx_run_cleaner_shader(adev, value);
+
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
@@ -1469,6 +1595,9 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	return count;
 }
 
+static DEVICE_ATTR(run_cleaner_shader, 0200,
+		   NULL, amdgpu_gfx_set_run_cleaner_shader);
+
 static DEVICE_ATTR(enforce_isolation, 0644,
 		   amdgpu_gfx_get_enforce_isolation,
 		   amdgpu_gfx_set_enforce_isolation);
@@ -1509,6 +1638,10 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 			return r;
 	}
 
+	r = device_create_file(adev->dev, &dev_attr_run_cleaner_shader);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1516,6 +1649,7 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
 {
 	if (!amdgpu_sriov_vf(adev))
 		device_remove_file(adev->dev, &dev_attr_enforce_isolation);
+	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
 }
 
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
-- 
2.46.0

