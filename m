Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316F5EF06E9
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CCA10E2FB;
	Sun,  8 Feb 2026 16:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C/VM+ZET";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D6A110E128
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDCnXTL5HjkaIvzmX8Of3nLlT0LBWXHT9Dlbw1A5xiWXdZENsZS4GrzJT3RVX0/3qQiSz2EWjAlGBneyMlbIRJtrPEbbyx7Qi0vxTYNefkPW3ysUBYlshX1eIVLz8g4E0i4thi8qxwkbgzJkO+m2BxxvmJBbMGaB3UicLOiqB93/P/+g4RAjsHZ/A/As2aesqys8uE1zVzDXzvs9MOFxNpd98qeeVs2z3HEzIAeFdTLlngoeOLqCXYWNDJwonsyG6SsBC+ucC+WeXtlbW8xw3flty6vPxi2PktikUX6x+7tZmXrcbX2S+UYoJssbtG1nxud7dm5qiNVFBL4zP1JdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAMIblUeCUE69WiszyDw8UZNR6GOZoVhAsj5R+Qx+JI=;
 b=boKKbyzodCS6R4ywYRlh6TtK/lkWb8s7I6OS7hRxCA6BSql1WXUFqFqnr8RNdB1WhNfHavLvO97QuJ3MLeOcoyC2Yu5EwP9335Ai6ofm6ACppXhXh/GFdEUpaVa55Ck+3h9ve0iUuG7FAwt/rVZ7Cv6UPIyzwhFhVXQPsdJajSxBVc7MdxRJpVdzhaTERtKLX73ZHfWiltWzYMihfrRS5bEcGfxDV7jLQmTJR5Lf7zaqc5ipaNcSdO5tXs7G5wAkBiShvzcBvpYUfVcz4XEM4ArAbX553rKJ6xQK/nddoXlBeea3jJcmYiu0GGZ0rvymnMPPISeMuSy+ElXo2cvqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAMIblUeCUE69WiszyDw8UZNR6GOZoVhAsj5R+Qx+JI=;
 b=C/VM+ZETsO3aYatnWOc/o+pzIGvp99iC5vXye6tjnDzVd6JaHDdcH1N6+Ms5c04ueQcdQ+ebYXoXkEmS5dLLEaiJIGXkgLjs/80wP7sFPlhsLrkUIS1ogzS5aZfCCh1PqT9tTfXgK/PifpVR9VwBjWy+yqpwk3Ao5VSIdXAzMyw=
Received: from SJ0PR05CA0169.namprd05.prod.outlook.com (2603:10b6:a03:339::24)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:43:39 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::ff) by SJ0PR05CA0169.outlook.office365.com
 (2603:10b6:a03:339::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Sun, 8
 Feb 2026 16:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:39 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:36 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 03/13] drm/amdgpu: add psp interfaces for peak tops limiter
 driver
Date: Mon, 9 Feb 2026 00:42:02 +0800
Message-ID: <b144ba775c0c2aae58e9977107cf61f11bf64058.1770568163.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1770568163.git.perry.yuan@amd.com>
References: <cover.1770568163.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f518f9-8905-4cb2-71e6-08de67313620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wd7bUrZpMjF2ofB68RqyKpB4Ytlic87UXm70FZ9iLml+Jsq0TVfoN08IDaGG?=
 =?us-ascii?Q?acDdqYw9ywWUQGmjrFbp6oO6/XYmauo//WcsmJlz3+CbEQ0GQdP5D60xZf84?=
 =?us-ascii?Q?5MPIv3A814QvhVEKcUj8VCVuVCstC6EluXnxCEBDUc2rRG/ATIzDjLm6rYwr?=
 =?us-ascii?Q?rYLTRgv+qHuyX/TaDm+h1UWBeU3jMVGAoN614pXNaieIyn+hdYl7Vns6j+px?=
 =?us-ascii?Q?v2E1Y0EUR+LJQ+/gUDAXfIqRkJWY8BnEE4JVhZTWOhULCvQdqTKIpndfva8p?=
 =?us-ascii?Q?jnoZRwcuzBNsNZcOBnyDVFAeCYXLP6PCrDx/5UcqyRidrwRwHsHqDeblJQu3?=
 =?us-ascii?Q?WEsqo8brU1fRGMKp1B7iP4yNGSm7rSV18cFS1HjovKX89RrPauFU/mZ+mjzY?=
 =?us-ascii?Q?B08Tz/5tJ1JmvPimeroEOQgY1qu4RSV/qr+q1BB0U3LWR7v2RnLeb5wWXvJ0?=
 =?us-ascii?Q?udFAdeAp0G/xMFePuTJcPyc0lc7JARUXgDreM90dnoB3Sm1K5fNl8Zngq3++?=
 =?us-ascii?Q?TNEXOIrRyj2lhGhYvs95WJ2lwQNFZWQ5/eEX386KO51mbyTM5jR2hongZg5V?=
 =?us-ascii?Q?AKyvri/oryhHHagn85N1cedcBdXGAoIr+RwHVFSDSgrf6c6w4yw9GGl1sUa6?=
 =?us-ascii?Q?OlKvoOEtgPQSV+bcoysbLFrxPb9mcb3nWjVNSKMrGP7EWKnk/mQJPmv5lRxg?=
 =?us-ascii?Q?d7BiLi0COcboS+mCl5ATRlzuQJJfbZN8I8LZTlq5+L95Y5n9Bwyi0+d/Nxf2?=
 =?us-ascii?Q?33RquEQE5MduhV7fhLnoiycFCTDEDpmzfujJf54kqFGvHZehg9FQmI0rkpdF?=
 =?us-ascii?Q?2bLutHUVPRl/kiWxbQgBU6SQd36HNqVhJ4CnYB+S94BBuPHGCzUnhNFmtz0g?=
 =?us-ascii?Q?WWad3Pmi1Gg/1zqvHyUrBXv1UFi9VATaOnaIWBWmkv2uRw4Q8f52oxJ7Urmn?=
 =?us-ascii?Q?q7z0MiDwK8g0ly7G4lcvXlDrlXJPi4f/GJbLRyipv8fvuJuDTfyQQclVOd41?=
 =?us-ascii?Q?CZX3vdSnhWhmsu8nedVoMheOVOV6XSzepdIfBIeXPa2LJi9PlytiPMq3U/YX?=
 =?us-ascii?Q?F8s+cN2pdmGDaApkCRGSRPuDJwaeDBMg3RUr6q+QU9nuhQsJnyprrCLqQnWl?=
 =?us-ascii?Q?fn0LEFovDiwZHfxAPGYOko0es8E7J72tzSWlQ578C8uQlF9cNtE0D1b/HuAx?=
 =?us-ascii?Q?m7iDpfC4+Vg1vSoTqk4dWg2lpr+dK+jl5s9/U2RMRjdEgMjklQo40e6j3Zoh?=
 =?us-ascii?Q?gGfc+5Gie+pS25y57YJzM47E6SrocQ3ZpGBRkt7uOUMEAMVSCpZOXT1pfazc?=
 =?us-ascii?Q?/ZpnuBdwiI3jVWoHopzM8b2kUqlbNY5tfXf/lirig9gDwVYUxrfYQKdfeuDT?=
 =?us-ascii?Q?zTNRGdQAhWWgUb15Nz7gCGgJcBb0Wm/V3HFvwjTX7Irw7rpD7pTYWAOZkWYy?=
 =?us-ascii?Q?9wL5gZ+hmqYqhVJV+Ts5eDZM0hy6mYvsEv45AwudB7m1rXnz0o6udsssbzsu?=
 =?us-ascii?Q?QGYUxhvyR6oIgzjUIeNpRzZVnkglNX5TPVh9pU0fm61ibFg93KYSVPEuGpKM?=
 =?us-ascii?Q?sbXdSn0GrT9NvpRBY09IF5P9vkPnLno/0nFfYaFK9BYgEdM27rZfnp2F3W5o?=
 =?us-ascii?Q?pTQ1YH9G1FxjpgHMfzjLdgZE8jcw2dWiU/eCnJ6MKRiJ5WnTLxtfXXIS1RKz?=
 =?us-ascii?Q?qnEd7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Le99dXIRSNGa92n/N2zrAF0ZITlzZN/ukEe6mR+NqT/m6E4cP9H1NNbkqlXB6f0Bn67AecccSv8ZbqgEgKisa/57SsgcRWwK2dfSnpQWckrfyPx27J/4xfvYTiewzDFKYSfZujylhNK5w+vsRcyEqgSzxJK01tT6t+bHCsnpiy6zRfl96bFqkdk6zzNbx6f71jIEZZL8Vz6tNQMcfENtY0MjH9GIUmB4vo0ljltwhSQVeJ/zGe9IQdMxIBQyT6+GZVgGz0A2g1pGSxngypGiLB6enX8FzoweZXUjXJ7r28O1QOm54dPOCUl2yrMUkzXeyQeImjvmWxLcO+dte/i2lwVJAJcxNekws9HBgR53agAxSoczGRZDX/a8w+6RijpQAPRSoN+W+mcvB1FB93yfepMgZti1cIJgf25gzIOWPl5F2g02iCTe+kAowDaV/0Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:39.1021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f518f9-8905-4cb2-71e6-08de67313620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
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

Introduce a Peak Tops Limiter (PTL) driver that dynamically caps
engine frequency to ensure delivered TOPS never exceeds a defined
TOPS_limit. This initial implementation provides core data structures
and kernel-space interfaces (set/get, enable/disable) to manage PTL state.

PTL performs a firmware handshake to initialize its state and update
predefined format types. It supports updating these format types at
runtime while user-space tools automatically switch PTL state, and
also allows explicitly switching PTL state via newly added commands.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 112 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   1 +
 drivers/gpu/drm/amd/include/amdgpu_ptl.h      |  48 ++++++++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   1 +
 7 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ptl.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index cdbab7f8cee8..4fee011c2e26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -38,6 +38,8 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_xcp.h"
 #include "kfd_topology.h"
+#include "amdgpu_ptl.h"
+
 extern uint64_t amdgpu_amdkfd_total_mem_size;
 
 enum TLB_FLUSH_TYPE {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5e73b9d67325..a07fe386d275 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4440,6 +4440,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
+	mutex_init(&adev->psp.ptl.mutex);
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b0540b009e84..19b81f515374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -679,6 +679,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "SPATIAL_PARTITION";
 	case GFX_CMD_ID_FB_NPS_MODE:
 		return "NPS_MODE_CHANGE";
+	case GFX_CMD_ID_PERF_HW:
+		return "PERF MONITORING HW";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1197,6 +1199,116 @@ int psp_memory_partition(struct psp_context *psp, int mode)
 	return ret;
 }
 
+static int psp_ptl_fmt_verify(struct psp_context *psp, enum amdgpu_ptl_fmt fmt,
+						 uint32_t *ptl_fmt)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4))
+		return -EINVAL;
+
+	switch (fmt) {
+	case AMDGPU_PTL_FMT_I8:
+		*ptl_fmt = GFX_FTYPE_I8;
+		break;
+	case AMDGPU_PTL_FMT_F16:
+		*ptl_fmt = GFX_FTYPE_F16;
+		break;
+	case AMDGPU_PTL_FMT_BF16:
+		*ptl_fmt = GFX_FTYPE_BF16;
+		break;
+	case AMDGPU_PTL_FMT_F32:
+		*ptl_fmt = GFX_FTYPE_F32;
+		break;
+	case AMDGPU_PTL_FMT_F64:
+		*ptl_fmt = GFX_FTYPE_F64;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int psp_ptl_invoke(struct psp_context *psp, u32 req_code,
+		uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	struct amdgpu_ptl *ptl = &psp->ptl;
+	int ret;
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id                     = GFX_CMD_ID_PERF_HW;
+	cmd->cmd.cmd_req_perf_hw.req    = req_code;
+	cmd->cmd.cmd_req_perf_hw.ptl_state    = *ptl_state;
+	cmd->cmd.cmd_req_perf_hw.pref_format1 = *fmt1;
+	cmd->cmd.cmd_req_perf_hw.pref_format2 = *fmt2;
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+	if (ret)
+		goto out;
+
+	/* Parse response */
+	switch (req_code) {
+	case PSP_PTL_PERF_MON_QUERY:
+		*ptl_state = cmd->resp.uresp.perf_hw_info.ptl_state;
+		*fmt1      = cmd->resp.uresp.perf_hw_info.pref_format1;
+		*fmt2      = cmd->resp.uresp.perf_hw_info.pref_format2;
+		break;
+	case PSP_PTL_PERF_MON_SET:
+		/* Update cached state only on success */
+		ptl->enabled = *ptl_state;
+		ptl->fmt1    = *fmt1;
+		ptl->fmt2    = *fmt2;
+		break;
+	}
+
+out:
+	release_psp_cmd_buf(psp);
+	return ret;
+}
+
+int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
+				uint32_t *ptl_state,
+				enum amdgpu_ptl_fmt *fmt1,
+				enum amdgpu_ptl_fmt *fmt2)
+{
+	uint32_t ptl_fmt1, ptl_fmt2;
+	struct psp_context *psp;
+	struct amdgpu_ptl *ptl;
+
+	if (!adev || !ptl_state || !fmt1 || !fmt2)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	psp = &adev->psp;
+	ptl = &psp->ptl;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) ||
+			psp->sos.fw_version < 0x0036081a)
+		return -EOPNOTSUPP;
+
+	/* Verify formats */
+	if (psp_ptl_fmt_verify(psp, *fmt1, &ptl_fmt1) ||
+			psp_ptl_fmt_verify(psp, *fmt2, &ptl_fmt2))
+		return -EINVAL;
+
+	/*
+	 * Add check to skip if state and formats are identical to current ones
+	 */
+	if (req_code == PSP_PTL_PERF_MON_SET &&
+			ptl->enabled == *ptl_state &&
+			ptl->fmt1 == ptl_fmt1 &&
+			ptl->fmt2 == ptl_fmt2)
+		return 0;
+
+	return psp_ptl_invoke(psp, req_code, ptl_state, &ptl_fmt1, &ptl_fmt2);
+}
+}
+
 int psp_spatial_partition(struct psp_context *psp, int mode)
 {
 	struct psp_gfx_cmd_resp *cmd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 58f691db2e97..332633f6f4be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -31,6 +31,7 @@
 #include "ta_ras_if.h"
 #include "ta_rap_if.h"
 #include "ta_secureDisplay_if.h"
+#include "amdgpu_ptl.h"
 
 #define PSP_FENCE_BUFFER_SIZE	0x1000
 #define PSP_CMD_BUFFER_SIZE	0x1000
@@ -470,6 +471,7 @@ struct psp_context {
 #if defined(CONFIG_DEBUG_FS)
 	struct spirom_bo *spirom_dump_trip;
 #endif
+	struct amdgpu_ptl		ptl;
 };
 
 struct amdgpu_psp_funcs {
@@ -653,5 +655,4 @@ void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
 int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 			   enum psp_gfx_fw_type *type);
 
-
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index dbb111a33678..9c37e8248540 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -44,6 +44,7 @@
 #include "kfd_smi_events.h"
 #include "amdgpu_dma_buf.h"
 #include "kfd_debug.h"
+#include "amdgpu_ptl.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_ptl.h b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
new file mode 100644
index 000000000000..12c9e0b4645a
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __AMDGPU_PTL_H__
+#define __AMDGPU_PTL_H__
+
+enum amdgpu_ptl_fmt {
+	AMDGPU_PTL_FMT_I8   = 0,
+	AMDGPU_PTL_FMT_F16  = 1,
+	AMDGPU_PTL_FMT_BF16 = 2,
+	AMDGPU_PTL_FMT_F32  = 3,
+	AMDGPU_PTL_FMT_F64  = 4,
+	AMDGPU_PTL_FMT_F8   = 5,
+	AMDGPU_PTL_FMT_VECTOR  = 6,
+	AMDGPU_PTL_FMT_INVALID = 7,
+};
+
+struct amdgpu_ptl {
+	enum amdgpu_ptl_fmt		fmt1;
+	enum amdgpu_ptl_fmt		fmt2;
+	bool				enabled;
+	bool				hw_supported;
+	struct mutex			mutex;
+};
+
+int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
+		u32 *ptl_state, u32 *fmt1, u32 *fmt2);
+
+#endif /* __AMDGPU_PTL_H__ */
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 9aba8596faa7..6df5afb242ae 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -33,6 +33,7 @@
 #include <linux/dma-fence.h>
 #include "amdgpu_irq.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_ptl.h"
 
 struct pci_dev;
 struct amdgpu_device;
-- 
2.34.1

