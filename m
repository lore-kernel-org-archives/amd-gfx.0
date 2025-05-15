Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95290C54754
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 07:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1D410E76C;
	Thu, 15 May 2025 07:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0tp5/sfA";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF77310E76C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 07:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJSzqCr3ZweT6tkERdz3UO2xLHxQoIwsaT9MwEvf1SjAPNtqtEOZd2+8N1PhjwArD2JNeXSZGP4MMjqLapIynb4zhOmYuPkrcpYbRmtHbzUDTA19GGgwf5BAldDwM5uKguoke8q5ip5QXO/2U1hRP8udMeCY3slTjJBbQdY0ZyOtA0wCTWkuc3dPBhcNnETRFabIJ25sjBpFroFJotp5zFhLKllkJArMc4l/wNpkgE6AVb0/LUbJh9m4mIWOZNcMh6xE3HBW5GNSSdHbEL5IvLHNhCaRdDwpVUgpB5QSKeNaSROYBDm2oG7rQQ7QJ/sjsMSYa3bEVMbqqn1o8sR4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTbVzSzJYkn8u1HMwvaqppCSrEcg263OKogSXQPb+eE=;
 b=ZF0kf2lwyWnDWWkbGFRQDNYkCT7P/QEnzm60fe4OzvDB4waOSLi0BV8KxjyjdkZclFrqcWC166y4E3QLYVK9nh5HRpHTqmlIlcdrT/NG8lESjd/FcJcNXHBbIZVnz+m/pWt5fXGnqwwMiBMihkBjwZ86TSbB+iWkQqVQno10urxr9FHVQ7nlyXZ07nyAob1X+ukZ/j5TfcSQmzKvmmlmmREXjpHgY/qyqsnkz/P9Mn0vLblPlqNQNcVjdP/qJkEJuN7UGHf6bwltaKspiQzvRqXlPEB8Dr0xuaWn2q1v5Wjnn3K9HBQcksbgFPbqfX3o/DwkEe0jRquyfltIzLfjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTbVzSzJYkn8u1HMwvaqppCSrEcg263OKogSXQPb+eE=;
 b=0tp5/sfAZpvxWfoFCK63yjgf9WYPQsIoy5PoW054o2YxKXFyf14MH9KNHYWYiuvMLM0SHsNnTLaHEOQPZp2TZ6UDFFycHLUYBLgIa2X7tWP0vLsvSsjLRWcD689RZiyMoZiJ02B4WihKEzw+ahxVFPQOV5ngGHKYBXC7E19H1c8=
Received: from BYAPR11CA0048.namprd11.prod.outlook.com (2603:10b6:a03:80::25)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 07:07:54 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::b3) by BYAPR11CA0048.outlook.office365.com
 (2603:10b6:a03:80::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.24 via Frontend Transport; Thu,
 15 May 2025 07:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 07:07:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 May
 2025 02:07:53 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 15 May 2025 02:07:52 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix eviction fence worker race during fd close
Date: Thu, 15 May 2025 15:06:44 +0800
Message-ID: <20250515070751.497828-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 211d3e36-b107-484e-d780-08dd937f366c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TuwZZ2ej1jQG46AsxouuR/mJSXuKJipCMjX1au6n4kKASMYDOh316YuQ9cnI?=
 =?us-ascii?Q?Gsb76Lb8Ql+8kVX5njVhb4EctdCf/NldXoEDiy4WgllHzawm8Q0duO3ms//k?=
 =?us-ascii?Q?2pAr8tzxxEDT/gCu6uXj/6xaugRpkLJ/XkAR8iUPIizh0bL5SDlF5pSUs4KX?=
 =?us-ascii?Q?6keHnZJviy7wwGvNHz0VCr4eBS016BXdEL6VZyP/7pV0MmgA3R0IrzbB89yN?=
 =?us-ascii?Q?77+i/HwJH6Qm6o8PNliRvb1QNjr2Krryj4PirxL2dliiYbtpyX6M2eheGQit?=
 =?us-ascii?Q?9AvKmvqunL5UIkiSRvkSlBw8beuG1kpL5F6CpDOUaCnjsGujcmqiEXYQg867?=
 =?us-ascii?Q?KLDAiAF7IRHoLZtjRXqxx0wuDB67SRjnA7l3sw8i0De3IU2yRGecw6/gc0DL?=
 =?us-ascii?Q?SPNOXluJWIpQDrcHdcdNO4KbPGYB6YVNWoxR+xTSEnDerXJFcvFkqbuWBnpk?=
 =?us-ascii?Q?+mMBGvwFr8RCbksKShDMqQG+Lf0y5ihMr/phw2454hubhWkb3650mX16BtCj?=
 =?us-ascii?Q?3M/+ePm7QMNsfJX4cR/hZ/YEjLlysdAe4S1vS92yGjcnUBxDxjFH3TxEKwJa?=
 =?us-ascii?Q?jlrrueWpv1lm0xRxBrpVE/PmMW1P1jFVF+u7c5Tr2BbZF4V1Mvmzd7O/0Gc8?=
 =?us-ascii?Q?ReG8flWsYCIlvIPYp9FY9DMoDX0xz68ymcxppvA1ZgTq+14Tf8fqX12cHS2w?=
 =?us-ascii?Q?/hg7ic6cXHiyh8HCdzq/Q/yEpIpkaG117jogIL1pwLITqKKQbcicPl33QUYQ?=
 =?us-ascii?Q?GPEUUKzn+VJ4bVuG/aQ+jEcPlYtq1BhRiT7gJou/4xRxbo06BLzSvg77nxOH?=
 =?us-ascii?Q?nY1LIVgt9JDUkoaDTIPqs4M0HWEeavIYCHJ9004YSBYGI6TixlpTInBLV59w?=
 =?us-ascii?Q?h4HHkT58VC5oKHhUmyO8UaSTtdKkTxwuWHW6t1mPMk0e28p7xxjOHI+EN42K?=
 =?us-ascii?Q?JfuGMPy/mLubzeEwcy9wXnslzXWA9Kg6hDJoz4sLkI+uCuZ9cNsv2cXl+Ukh?=
 =?us-ascii?Q?XLIkI8EQNrA1GUeIIWKPeIDgUyFUQiygWKMssjvqUH2BjD2UJBIpHDVmzX/u?=
 =?us-ascii?Q?jYbluUPVsf9jzCczpmWEr76k6MBjxCifrkJ+ZjYUVj7zNfudbmhzNvZU2Sl5?=
 =?us-ascii?Q?leth4BRCo8YyFkpdbVVQ/faBC2Nlhrk9NQEwrUGTOuXXnm94IarQZrndWkbR?=
 =?us-ascii?Q?9X4jeA7QpTO7EpKDX0R+l5TowcbZT0ZMtSQ6limAzCWy5d5yA4AYYKf1huY7?=
 =?us-ascii?Q?utPljC3yjsRw1MtB3Kw6ERNpDun2z3xoGlv8OENDCxGG78QUOpet13LYBJ1f?=
 =?us-ascii?Q?yb51SxRlObkl6OA8yYRbPjEdyCa2WAVlvEcIoXOY/OGH1qZvBuNvoXfUO/fY?=
 =?us-ascii?Q?F2yQWaWlkpQLhFRhWYabYYoBkbAtDF4FfQ3URhu+E88xSGg+vcC20Da3Ck0q?=
 =?us-ascii?Q?uYgKqGyuzmf3sStZTZpbX/eMSUG65CWqUtvOlKv51EZPXVrq7Ba9dm99zyvn?=
 =?us-ascii?Q?5NjmYJ6yAOKubNPxOeN+2Ys7eMyU/LP1Pr2B?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 07:07:53.8253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 211d3e36-b107-484e-d780-08dd937f366c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

The current cleanup order during file descriptor close can lead to
a race condition where the eviction fence worker attempts to access
a destroyed mutex from the user queue manager:

[  517.294055] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[  517.294060] WARNING: CPU: 8 PID: 2030 at kernel/locking/mutex.c:564
[  517.294094] Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]

The issue occurs because:
1. We destroy the user queue manager (including its mutex) first
2. Then try to destroy eviction fences which may have pending work
3. The eviction fence worker may try to access the already-destroyed mutex

Fix this by reordering the cleanup to:
1. First mark the fd as closing and destroy eviction fences,
   which flushes any pending work
2. Then safely destroy the user queue manager after we're certain
   no more fence work will be executed

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4ddd08ce8885..4db92e0a60da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2913,8 +2913,8 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 
 	if (fpriv) {
 		fpriv->evf_mgr.fd_closing = true;
-		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
+		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 	}
 
 	return drm_release(inode, filp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9fbb04aee97b..1fec3713fbf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1504,8 +1504,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	if (!fpriv->evf_mgr.fd_closing) {
 		fpriv->evf_mgr.fd_closing = true;
-		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
+		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 	}
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
-- 
2.49.0

