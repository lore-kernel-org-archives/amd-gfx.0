Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209FEE91269
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF7710E7C9;
	Thu,  5 Feb 2026 06:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DYCKfQg5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA25210E7C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hV5pVGqoqu+zxWJdswoDy/NpHK91dyxwc+UGwRjub0HYhkGJ5m9qhP9rPgljROtWCNpT79NsHh4Q/EEk331d8cP5vuoQ5IWZiX+rPcgbGQ5rUJhtwchCHzutHAlflCP/d+VVa/Ck7fQ6cF40Lcxvp0fTj4AaCKC6hUNPiVTmQ2Feg9xw0AgbrIzWSGMhQZSioLUNN+lGjofxHlcLV4iWA+gFxct2GPx5x0GekojTbwosR5QwsAPwn5BpReAvv9G/p/y9HTsdziqB6dYFWdgcisbRfxEOnXuB6HFveVxXO5oiSpEnLf6pl+1AQqoJWSCXCwFaHkRgGh5txLcbkof6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojqvwa4bmOfBLJ8KhC6qOUhy+5/zAL8F5eu0QcmjQMg=;
 b=fd7nMfno1G9E7R/IZ28w9cxo8/7uCk69LSqf+rTn8C4EhvB5GuZlhXW1Vb0MzlGLw37gykLwE1UuJxWAniwZe9brdwhkAMtxT5jroGEbtFQI/cfnHrmmfXPzh8H9xF3wdq0uinyWS8cmgTASbqW588xjHjVf/kpiE/b5cXRvIHpZVc305g2KATn/+Kw9l078ywFH9MsF1Lq/bwnbf6m9yhff1czZ+bQKd7/PATh18CnPwsinf7jIIIYr686ct/MUr9eZ+S8wZ7X4lbV09pAWLl+VyMENQ/vfjxdpeAkFutLiezNVltnzRaQrL/JHFArvDH6u4qKRvE4oKwWvE/rjuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojqvwa4bmOfBLJ8KhC6qOUhy+5/zAL8F5eu0QcmjQMg=;
 b=DYCKfQg5bNzQ+elEd0w7SXPxn1PqDwaWkAPnPMoa4PQB9vzFJVN2k0Vfpp+yrmmnSLwKxTZ1PAPHOnown0ZwrlHsw7nM7h9hFOiI0tGC5uCRB6GAu8aZcwbi7JF5rAO9cpPd03R8iZBltJeGLGMw7ulr3Jt+8D7E1HOP/AbPX5I=
Received: from PH7P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::24)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 06:52:09 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::61) by PH7P221CA0040.outlook.office365.com
 (2603:10b6:510:33c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 06:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:52:08 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:52:02 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 17/22] drm/amdgpu: group PTL fields into struct amdgpu_ptl
Date: Thu, 5 Feb 2026 14:51:25 +0800
Message-ID: <20260205065130.654921-17-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 491785c6-0bf7-4bad-295d-08de64831518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JhU2il6yW6lsbCSgEJuePqeY+hh2FFPSHgXvHbHC2YeiCJY3SnxXNMc2byLC?=
 =?us-ascii?Q?5xzGwIm86ASHxQgBLxxpZ69dWt9zqv12yzk3+YMVrGLZJwZlIVOzKVlVoyoM?=
 =?us-ascii?Q?n5wS+AHEf+9pF27hBda3MoNw9l5WnU2yxMeps32WHKNEw50/Cpxztpkf9nK/?=
 =?us-ascii?Q?6gpavSL9NWsPfWbiX4VJV2Vak2xl9UiwLAIi6kDtYJwq4Eeyw3yw3Tp1Idxn?=
 =?us-ascii?Q?FoCBo8Iv8asnCRmTyjT2eFdoRFayeCOZ1HKcST96OaL13c4sWhQ/XMPpR/EY?=
 =?us-ascii?Q?VLEtKDoSVzl5CuO0I7pNJCeC/TipiyAKwAFQl2czsZm38iUBWAIz9kXMmnp5?=
 =?us-ascii?Q?4LNw30bHeC0n3JTEAc1tZIFBVy0eF3NrJiI1x2TuzxRqmSfDzcz2wmMHZhyw?=
 =?us-ascii?Q?e15MhZBoM5qIF71YL0Kg8CqYjbf9D+pP7GPGVexB3zCTjq3s9tUoid+toXt6?=
 =?us-ascii?Q?H62QS8gb9hEtZF0FZPHuxQDNqLyC3caYpcBcbioi901WNBmN7KeZX/9EfPtb?=
 =?us-ascii?Q?2J8gV3K/iHBfpyFqlrWMZeQtIMvtgp87AF2lKZ/OOkkDmfcyQGJtoXkxJ047?=
 =?us-ascii?Q?gd4gf6MHkpUn0tRvEK+9iDiSOsxBfmBaYDhjeuS/LN3R/jnU1XXblw1Tqxf4?=
 =?us-ascii?Q?bhidzQPHaKShqAEwP5CFWqDxoV2q7f3FmDekSQUAG3IZsCkPPyhRVPU+0h+X?=
 =?us-ascii?Q?++UBzKBO+Giy19Etjkj31eKE6hXuBQjwc9D5labU+vhRx2ouYDEP2ueTjdXP?=
 =?us-ascii?Q?ye0W6i0KesyauPIp6xwiNxOfQueSLa19LZe5dkt7p37Ik+H4396uOCWw2Rc8?=
 =?us-ascii?Q?l2pLuMrjB85KYMVqDVqVxiO4NPPX9TnEKo0vbgCQ1UNGYyWyUdbcn+iwzV+v?=
 =?us-ascii?Q?wSWI/FhEpdVBG4vcgXTZXgVkNla6ySjwJm9qAY2IGKOKnhZvv8dfRX/MOACh?=
 =?us-ascii?Q?wDqVB2hfspUzaZR4BMfoYrqYdd4REz6AKiGcd71xTCO2JuZ76tM72hUK2hI8?=
 =?us-ascii?Q?yEBz8BcLNANjWFQ7YA5wIUPk5s5TvSbTZh1cVDyP2biVLX6ESwKBhY6ZqREo?=
 =?us-ascii?Q?mW3Pavr52DIY3bNsKMa0/w3ZiGvWoXX1b+Nl4fQNJV8G/0+1ytsjNRn7akvL?=
 =?us-ascii?Q?Ao4zwyfJKxLrFrI+N3E5D0aPudtkaDu6W4xkLBAevFsgL6pT7ZW75ULGZGRb?=
 =?us-ascii?Q?QQH9DG3TTCFDAKjfnWH1A29itaQdiWu7pDvMHN0zvsHqzy3ysgToVOu4fLUw?=
 =?us-ascii?Q?izL/Y61a6GKSNQ9zZQvUNkeyMsQrDmg9MtsaRptby/b/4OevGzc9u9NvZzwn?=
 =?us-ascii?Q?Ehh4H8DpV21m9cHbP2f5Ru53dbNaBbG00krH5V+kDWsKTRlKnitCMzSkhThC?=
 =?us-ascii?Q?XTizzEBkig1he7u9QbdkHZ2Lax26y2HEvx1fn9UJIOJQasDhrHL1MIxTN30q?=
 =?us-ascii?Q?CQ/XrUBGOlEugSMtl7NQ63BQHmgmNiaWrbPg6OfdMG+lOUPycMvFhQQYIrfK?=
 =?us-ascii?Q?Q/xvFOHeh0NPuA26S8S2dKtks1ANPFECAu7uUplCIpAKDQREhqmFzCYR4ivK?=
 =?us-ascii?Q?e6UQv4kNRQrcKMHI8rFBL9DFFuSIiQIxLO7Gn5wtgA+ldlSyrvVWntDoqf8V?=
 =?us-ascii?Q?+fcNx+6HfbchPf/e+2oaMjJjXOM7wkxD0c1hjD9XQp3LE+MZGr8uynTmY5TV?=
 =?us-ascii?Q?pLyi8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3fHlwv+iOL9d+PojV4eIYy/aqDPzop0goJ4Du7rbz2xYHsPqxoCjtl+XNEAtrXTm306lMDK0vfytqM/vCkDJcvbyw4g0cBSIuc3G7AUXQoZI+HS1iIFAIjBkLJMnkr+baTccS8d5KAt5PX2Y1w3ZcNHk4Mlo2f4LZwzstO8j/LlW5RGe+GWRXL9s6TOMcazbkZApZZqC7L/IvQvmM3FT9qgNJwJSZ0UgyMGDM9ruoSrhXCI3Ec2tVJ3n6E2njjYRPTuIhkCdBa+04/QoKAZIyYaMnPg6WOTY1mn05gyQAWahfy9rUIJ6V7/iDnujK4BwgWi9skIPOoJZLA9fG7ZSWop82/8M27st17rZcAjV4XqTTDfbDPvGZc5jvahThS+/iBnGwoSsnSFraXwKKjrEwy7MfWgwDgZea+jmPsBTgPai3lNVqCtcd4uHezaRXfMf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:52:08.9720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491785c6-0bf7-4bad-295d-08de64831518
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
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

Move PTL enums and structures to a unified location in amdgpu_psp.h.
Introduce struct amdgpu_ptl to group PTL related fields, replacing
loose fields in struct psp_context for better code organization.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Suggested-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 58 ++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    | 18 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 13 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 49 +++++++++---------
 5 files changed, 74 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index aae2f850b044..827fbdb81011 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4442,7 +4442,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
-	mutex_init(&adev->psp.ptl_mutex);
+	mutex_init(&adev->psp.ptl.ptl_mutex);
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f0b1157d7a21..357357523347 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1243,6 +1243,7 @@ static int psp_ptl_invoke(struct psp_context *psp, u32 req_code,
 		uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2)
 {
 	struct psp_gfx_cmd_resp *cmd;
+	struct amdgpu_ptl *ptl = &psp->ptl;
 	int ret;
 
 	cmd = acquire_psp_cmd_buf(psp);
@@ -1266,9 +1267,9 @@ static int psp_ptl_invoke(struct psp_context *psp, u32 req_code,
 		break;
 	case PSP_PTL_PERF_MON_SET:
 		/* Update cached state only on success */
-		psp->ptl_enabled = *ptl_state;
-		psp->ptl_fmt1    = *fmt1;
-		psp->ptl_fmt2    = *fmt2;
+		ptl->ptl_enabled = *ptl_state;
+		ptl->ptl_fmt1    = *fmt1;
+		ptl->ptl_fmt2    = *fmt2;
 		break;
 	}
 
@@ -1278,10 +1279,13 @@ static int psp_ptl_invoke(struct psp_context *psp, u32 req_code,
 }
 
 int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
-		uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2)
+				uint32_t *ptl_state,
+				enum amdgpu_ptl_fmt *fmt1,
+				enum amdgpu_ptl_fmt *fmt2)
 {
 	uint32_t ptl_fmt1, ptl_fmt2;
 	struct psp_context *psp;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 
 	if (!adev || !ptl_state || !fmt1 || !fmt2)
 		return -EINVAL;
@@ -1304,9 +1308,9 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 	 * Add check to skip if state and formats are identical to current ones
 	 */
 	if (req_code == PSP_PTL_PERF_MON_SET &&
-			psp->ptl_enabled == *ptl_state &&
-			psp->ptl_fmt1 == ptl_fmt1 &&
-			psp->ptl_fmt2 == ptl_fmt2)
+			ptl->ptl_enabled == *ptl_state &&
+			ptl->ptl_fmt1 == ptl_fmt1 &&
+			ptl->ptl_fmt2 == ptl_fmt2)
 		return 0;
 
 	return psp_ptl_invoke(psp, req_code, ptl_state, &ptl_fmt1, &ptl_fmt2);
@@ -1345,22 +1349,23 @@ static ssize_t ptl_enable_store(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct psp_context *psp = &adev->psp;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	bool enable, cur_enabled;
 	uint32_t ptl_state, fmt1, fmt2;
 	int ret;
 
-	mutex_lock(&psp->ptl_mutex);
+	mutex_lock(&ptl->ptl_mutex);
 	if (sysfs_streq(buf, "enabled") || sysfs_streq(buf, "1")) {
 		enable = true;
 	} else if (sysfs_streq(buf, "disabled") || sysfs_streq(buf, "0")) {
 		enable = false;
 	} else {
-		mutex_unlock(&psp->ptl_mutex);
+		mutex_unlock(&ptl->ptl_mutex);
 		return -EINVAL;
 	}
 
-	fmt1 = psp->ptl_fmt1;
-	fmt2 = psp->ptl_fmt2;
+	fmt1 = ptl->ptl_fmt1;
+	fmt2 = ptl->ptl_fmt2;
 	ptl_state = enable ? 1 : 0;
 
 	cur_enabled = READ_ONCE(psp->ptl_enabled);
@@ -1372,10 +1377,10 @@ static ssize_t ptl_enable_store(struct device *dev,
 	ret = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
 	if (ret) {
 		dev_err(adev->dev, "Failed to set PTL err = %d\n", ret);
-		mutex_unlock(&psp->ptl_mutex);
+		mutex_unlock(&ptl->ptl_mutex);
 		return ret;
 	}
-	mutex_unlock(&psp->ptl_mutex);
+	mutex_unlock(&ptl->ptl_mutex);
 
 	return count;
 }
@@ -1386,7 +1391,7 @@ static ssize_t ptl_enable_show(struct device *dev, struct device_attribute *attr
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct psp_context *psp = &adev->psp;
 
-	return sysfs_emit(buf, "%s\n", psp->ptl_enabled ? "enabled" : "disabled");
+	return sysfs_emit(buf, "%s\n", psp->ptl.ptl_enabled ? "enabled" : "disabled");
 }
 
 static ssize_t ptl_format_store(struct device *dev,
@@ -1398,17 +1403,18 @@ static ssize_t ptl_format_store(struct device *dev,
 	struct psp_context *psp = &adev->psp;
 	char fmt1_str[8], fmt2_str[8];
 	enum amdgpu_ptl_fmt fmt1_enum, fmt2_enum;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	uint32_t ptl_state, fmt1, fmt2;
 	int ret;
 
 	/* Only allow format update when PTL is enabled */
-	if (!psp->ptl_enabled)
+	if (!ptl->ptl_enabled)
 		return -EPERM;
 
-	mutex_lock(&psp->ptl_mutex);
+	mutex_lock(&ptl->ptl_mutex);
 	/* Parse input, expecting "FMT1,FMT2" */
 	if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) != 2) {
-		mutex_unlock(&psp->ptl_mutex);
+		mutex_unlock(&ptl->ptl_mutex);
 		return -EINVAL;
 	}
 
@@ -1418,20 +1424,20 @@ static ssize_t ptl_format_store(struct device *dev,
 	if (fmt1_enum >= AMDGPU_PTL_FMT_INVALID ||
 			fmt2_enum >= AMDGPU_PTL_FMT_INVALID ||
 			fmt1_enum == fmt2_enum) {
-		mutex_unlock(&psp->ptl_mutex);
+		mutex_unlock(&ptl->ptl_mutex);
 		return -EINVAL;
 	}
 
-	ptl_state = psp->ptl_enabled;
+	ptl_state = ptl->ptl_enabled;
 	fmt1 = fmt1_enum;
 	fmt2 = fmt2_enum;
 	ret = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
 	if (ret) {
 		dev_err(adev->dev, "Failed to update PTL err = %d\n", ret);
-		mutex_unlock(&psp->ptl_mutex);
+		mutex_unlock(&ptl->ptl_mutex);
 		return ret;
 	}
-	mutex_unlock(&psp->ptl_mutex);
+	mutex_unlock(&ptl->ptl_mutex);
 
 	return count;
 }
@@ -1443,8 +1449,8 @@ static ssize_t ptl_format_show(struct device *dev, struct device_attribute *attr
 	struct psp_context *psp = &adev->psp;
 
 	return sysfs_emit(buf, "%s,%s\n",
-			amdgpu_ptl_fmt_str[psp->ptl_fmt1],
-			amdgpu_ptl_fmt_str[psp->ptl_fmt2]);
+			amdgpu_ptl_fmt_str[psp->ptl.ptl_fmt1],
+			amdgpu_ptl_fmt_str[psp->ptl.ptl_fmt2]);
 }
 
 static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
@@ -1454,7 +1460,7 @@ static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attribute *att
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
 	/* Only show PTL sysfs files if PTL hardware is supported */
-	if (!adev->psp.ptl_hw_supported)
+	if (!adev->psp.ptl.ptl_hw_supported)
 		return 0;
 
 	return attr->mode;
@@ -1462,7 +1468,7 @@ static umode_t amdgpu_ptl_is_visible(struct kobject *kobj, struct attribute *att
 
 int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev)
 {
-	if (!adev->psp.ptl_hw_supported)
+	if (!adev->psp.ptl.ptl_hw_supported)
 		return 0;
 
 	return sysfs_create_group(&adev->dev->kobj, &amdgpu_ptl_attr_group);
@@ -1470,7 +1476,7 @@ int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (!adev->psp.ptl_hw_supported)
+	if (!adev->psp.ptl.ptl_hw_supported)
 		return;
 
 	sysfs_remove_group(&adev->dev->kobj, &amdgpu_ptl_attr_group);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 711f15d21940..d8591602b304 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -382,6 +382,16 @@ struct psp_ptl_perf_req {
 	uint32_t pref_format2;
 };
 
+struct amdgpu_ptl {
+	enum amdgpu_ptl_fmt		ptl_fmt1;
+	enum amdgpu_ptl_fmt		ptl_fmt2;
+	bool				ptl_enabled;
+	bool				ptl_hw_supported;
+	/* PTL disable reference counting */
+	atomic_t			ptl_disable_ref;
+	struct mutex			ptl_mutex;
+};
+
 struct psp_context {
 	struct amdgpu_device		*adev;
 	struct psp_ring			km_ring;
@@ -472,13 +482,7 @@ struct psp_context {
 #if defined(CONFIG_DEBUG_FS)
 	struct spirom_bo *spirom_dump_trip;
 #endif
-	enum amdgpu_ptl_fmt		ptl_fmt1;
-	enum amdgpu_ptl_fmt		ptl_fmt2;
-	bool				ptl_enabled;
-	bool				ptl_hw_supported;
-	/* PTL disable reference counting */
-	atomic_t			ptl_disable_ref;
-	struct mutex			ptl_mutex;
+	struct amdgpu_ptl		ptl;
 };
 
 struct amdgpu_psp_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 1682adb1231f..f53934edfd3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2374,17 +2374,18 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool sta
 {
 	uint32_t fmt1, fmt2;
 	uint32_t ptl_state = state ? 1 : 0;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	int r;
 
 	if (!adev->psp.funcs)
 		return -EOPNOTSUPP;
 
-	if (!adev->psp.ptl_hw_supported) {
+	if (!ptl->ptl_hw_supported) {
 		fmt1 = GFX_FTYPE_I8;
 		fmt2 = GFX_FTYPE_BF16;
 	} else {
-		fmt1 = adev->psp.ptl_fmt1;
-		fmt2 = adev->psp.ptl_fmt2;
+		fmt1 = ptl->ptl_fmt1;
+		fmt2 = ptl->ptl_fmt2;
 	}
 
 	/* initialize PTL with default formats: GFX_FTYPE_I8 & GFX_FTYPE_BF16 */
@@ -2393,9 +2394,9 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool sta
 	if (r)
 		return r;
 
-	adev->psp.ptl_hw_supported = true;
+	ptl->ptl_hw_supported = true;
 
-	atomic_set(&adev->psp.ptl_disable_ref, 0);
+	atomic_set(&ptl->ptl_disable_ref, 0);
 
 	return 0;
 }
@@ -2405,7 +2406,7 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, num_xcc;
 
-	if (adev->psp.ptl_hw_supported)
+	if (adev->psp.ptl.ptl_hw_supported)
 		gfx_v9_4_3_perf_monitor_ptl_init(adev, 0);
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index bccb857c81c4..efdd19d6d6da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1767,12 +1767,13 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
-	enum amdgpu_ptl_fmt pref_format1 = adev->psp.ptl_fmt1;
-	enum amdgpu_ptl_fmt pref_format2 = adev->psp.ptl_fmt2;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+	enum amdgpu_ptl_fmt pref_format1 = ptl->ptl_fmt1;
+	enum amdgpu_ptl_fmt pref_format2 = ptl->ptl_fmt2;
 	uint32_t ptl_state = enable ? 1 : 0;
 	int ret;
 
-	if (!adev->psp.ptl_hw_supported)
+	if (!ptl->ptl_hw_supported)
 		return -EOPNOTSUPP;
 
 	if (!pdd->dev->kfd2kgd || !pdd->dev->kfd2kgd->ptl_ctrl)
@@ -1795,22 +1796,19 @@ int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
 int kfd_ptl_disable_request(struct kfd_process_device *pdd,
 		struct kfd_process *p)
 {
-	struct amdgpu_device *adev;
+	struct amdgpu_device *adev = pdd->dev->adev;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	int ret = 0;
 
-	if (!pdd)
-		return -ENODEV;
-
-	adev = pdd->dev->adev;
-	mutex_lock(&adev->psp.ptl_mutex);
+	mutex_lock(&ptl->ptl_mutex);
 
 	if (pdd->ptl_disable_req)
 		goto out;
 
-	if (atomic_inc_return(&adev->psp.ptl_disable_ref) == 1) {
+	if (atomic_inc_return(&ptl->ptl_disable_ref) == 1) {
 		ret = kfd_ptl_control(pdd, false);
 		if (ret) {
-			atomic_dec(&adev->psp.ptl_disable_ref);
+			atomic_dec(&ptl->ptl_disable_ref);
 			dev_warn(pdd->dev->adev->dev,
 					"failed to disable PTL\n");
 			goto out;
@@ -1819,30 +1817,27 @@ int kfd_ptl_disable_request(struct kfd_process_device *pdd,
 	pdd->ptl_disable_req = true;
 
 out:
-	mutex_unlock(&adev->psp.ptl_mutex);
+	mutex_unlock(&ptl->ptl_mutex);
 	return ret;
 }
 
 int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 		struct kfd_process *p)
 {
-	struct amdgpu_device *adev;
+	struct amdgpu_device *adev = pdd->dev->adev;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	int ret = 0;
 
-	if (!pdd)
-		return -ENODEV;
+	mutex_lock(&ptl->ptl_mutex);
 
-	adev = pdd->dev->adev;
-	mutex_lock(&adev->psp.ptl_mutex);
 	if (!pdd->ptl_disable_req)
 		goto out;
 
-	if (atomic_dec_return(&adev->psp.ptl_disable_ref) == 0) {
+	if (atomic_dec_return(&ptl->ptl_disable_ref) == 0) {
 		ret = kfd_ptl_control(pdd, true);
 		if (ret) {
-			atomic_inc(&adev->psp.ptl_disable_ref);
-			dev_warn(pdd->dev->adev->dev,
-					"failed to enable PTL\n");
+			atomic_inc(&ptl->ptl_disable_ref);
+			dev_warn(adev->dev, "Failed to enable PTL on release: %d\n", ret);
 			goto out;
 		}
 	}
@@ -1850,7 +1845,7 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 	pdd->ptl_disable_req = false;
 
 out:
-	mutex_unlock(&adev->psp.ptl_mutex);
+	mutex_unlock(&ptl->ptl_mutex);
 	return ret;
 }
 
@@ -1864,8 +1859,8 @@ static int kfd_profiler_ptl_control(struct kfd_process *p,
 	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
 	mutex_unlock(&p->mutex);
 
-	if (!pdd)
-		return -ENODEV;
+	if (!pdd || !pdd->dev || !pdd->dev->kfd)
+		return -EINVAL;
 
 	if (args->enable == 0)
 		ret = kfd_ptl_disable_request(pdd, p);
@@ -3322,6 +3317,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 	struct kfd_process_device *pdd;
 	struct kfd_dev *kfd;
 	int status = -EINVAL;
+	struct amdgpu_ptl *ptl;
 
 	if (!p)
 		return -EINVAL;
@@ -3334,6 +3330,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 		return -EINVAL;
 
 	kfd = pdd->dev->kfd;
+	ptl = &pdd->dev->adev->psp.ptl;
 
 	mutex_lock(&kfd->profiler_lock);
 	if (op == 1) {
@@ -3341,7 +3338,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 			kfd->profiler_process = p;
 			status = 0;
 			mutex_unlock(&kfd->profiler_lock);
-			if (pdd->dev->adev->psp.ptl_hw_supported) {
+			if (ptl->ptl_hw_supported) {
 				status = kfd_ptl_disable_request(pdd, p);
 				if (status != 0)
 					dev_err(kfd_device,
@@ -3359,7 +3356,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 		status = 0;
 		mutex_unlock(&kfd->profiler_lock);
 
-		if (pdd->dev->adev->psp.ptl_hw_supported) {
+		if (ptl->ptl_hw_supported) {
 			status = kfd_ptl_disable_release(pdd, p);
 			if (status)
 				dev_err(kfd_device,
-- 
2.34.1

