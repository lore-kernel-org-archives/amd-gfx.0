Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDF7C021AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 06:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A59A10E154;
	Thu, 20 Feb 2025 06:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jz4+CeV+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C79310E031
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 06:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcHH+HRxW0Tg6qgiSRyngoT4jJkbfOmyUJs1O787JzHodoanZp+I3g7lWs/crv059+LxqF5gZIr3DYfbxt0h2ZOHL+/4DQKpPf6FZWi58/L04+7XK2HiO+UAfSo2vd5MVOCWGRF+mU4MgbR+4lbPaHf/UHM97OUAYFPd62JklK4SLpKBNm/UPy5j/4nEFTrGiED30qxAFkf5hWLtjBb5mES4MuUfYps+nMYZWyzv3ieqEXeLBGAuekeGzYmvPniqZ633E2jRRkOYlZ9uQMOVolt2aIIwVdCJI7zb64SlSxIE3oQWcYl+enMIZBbKELCZVDZe/EKThv69n58OSKWtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxMzbaDziRZ0cY3Du+768mY45rZIC0lXzhQu+FZsQZo=;
 b=r+p0JZEBPNHn0ORxrzQfyuN25W2jGlNo0fk+i2lgl0l0VbAIgPEt1a8vgdn8q+D9zViCdPx0AE8vPNw1U/khSc086gyfiivbB7Le3L/uYriPBVQyk1pY3YII8PJw+9raWmhUUaOXDpckZWSKPloTnuuQnmvOTr9Nuy/DU4alnYAUsc8uHttMjZStnkGyHz9Eiuebpp+umxuh+HJNLzeB+ESm8sTR4zPU/Aav+Jbt3hseCqeiVN4b1LCDj41gEwp6tuo0YdfDUfuqcMfluP8gXaAVSjruHe9R2z/abyfUgtesuJv1j5UZwDbbkjTBb7gBnBHnZx36yApXWZaSy+Q95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxMzbaDziRZ0cY3Du+768mY45rZIC0lXzhQu+FZsQZo=;
 b=Jz4+CeV+nFE71BKZ7qulcKMSkHeArluxmq1BaU8XiYv0VQnz6yMDXLEWQ6GkFv0bCKxAWVzKGrUvCnszL1IwvNAFtUTe0g2Xwo1y8qEorF1S+s2Yamb0UZbz4JUEgpezDESxlq+qwOPZ1+R8qJs44I11OCS2sGa+QHhyl6qHsWM=
Received: from BY5PR17CA0053.namprd17.prod.outlook.com (2603:10b6:a03:167::30)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 06:25:22 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::95) by BY5PR17CA0053.outlook.office365.com
 (2603:10b6:a03:167::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 06:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 06:25:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 00:25:20 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Feb 2025 00:25:19 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add amdgpu_sriov_multi_vf_mode function
Date: Thu, 20 Feb 2025 14:25:13 +0800
Message-ID: <20250220062515.2050499-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f1f8d1-9516-4ee7-b019-08dd51775a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P06iluk+731CyQK5J8RnZoABl32dW//nUvtM6k5Lahfd/ap/At9Y9OVHQB0r?=
 =?us-ascii?Q?67cbKf7Of/agzyXIpec4xqruzExdy7s8X2Qux7yDFx+JJ4PmvpDfyQ9qjecK?=
 =?us-ascii?Q?h0OAtwjCu5k/u3AYn6hRTYXCrvguaDY9pzbyYGcGI3Wp0WpjYTFnQZzv8Q8D?=
 =?us-ascii?Q?P4e5tSdunc7bv6uRt4ySp4iPJfJ4LDRezmD/8/WYr4T7vHueMUJ2VqykL1r1?=
 =?us-ascii?Q?0f+MktLMfNZWDxMp8OAbdc6UQsHMd7GN5ODrYEYofTT27wCypQheuySLNeGa?=
 =?us-ascii?Q?peuVUPN1kUfe0zdBI8BKAG/ViTSIZDNTSi6kB8VDPHeLthPxgtzw69slq4zr?=
 =?us-ascii?Q?cKN0rKC20CGCVnwd+ZSZXEKihipE3WVTslIOaZWs7nVlu2VSyxIx3JHIksHN?=
 =?us-ascii?Q?MIOhEtjwQrZFpad/9tDecHDy5FeYmsyrL/A55+jJ8iD8LXF0PL8rwr7sLN9a?=
 =?us-ascii?Q?7sN7RAIByT0Ng+F02faHhBBeAzhlKrzracEFa7dw4dwLBGKbFRLwG9ZRSG2q?=
 =?us-ascii?Q?JPsr08kC9Jp/23qZurz7IVjaNsKA37ODU/y0PfFPK0NkEaDadosa7NKVJ/HW?=
 =?us-ascii?Q?NX5O4xzmVWl14s0OGMpeqLFMVT1JsTE/T68yXGyt4ckJhA+HZ3OsFGeIeVRv?=
 =?us-ascii?Q?KtKpI9V2U5z03QiJAmEfhDUjXyzNaj6DqFZjgm/uJnlpHI8qr2QYQYwYrCq0?=
 =?us-ascii?Q?Q9s3Pjn3a1PGwst73fGRa+BgToIG2jaED4IEEtvtxsjKRjH0YHJypotI1HEm?=
 =?us-ascii?Q?zlIxyxCVtBHITzNWbB/xzuveJkblut2ANe9sCXQAuEF9/BUTP1fSeoT7jhDq?=
 =?us-ascii?Q?a4KwntpKND1mNc9r/6muXTRUhT3v3MbESrXlm5qRhbDefuwPLA6grSK8m2Ui?=
 =?us-ascii?Q?5voLkflN+QGNKR00j9WxEZKBfxcGGxmSay694JylZafsBXBaFrLaQMvOk+qB?=
 =?us-ascii?Q?JP3SjsKyVor80CiJ0Ep/yfi8/tbenKYVUcIH5QlH8ZZktsf9ZgE4i1pvOOFm?=
 =?us-ascii?Q?PCa5UKiGDGBa6Jj1fOlFf+KoZCC0zy0eVutUVeRAXZceMkl7jWMZB0K1obBF?=
 =?us-ascii?Q?40dYEuuHYwh2Mx7zNwNaSQgdbj+oI1Gv0eDFI0GM7GUYGDm7yHohryxa+QX1?=
 =?us-ascii?Q?Zy7ryeTE4Zl2fVWqnlDzmz+Gxumh36IudGH3uGOk+QNVro9GJjZFix4y+bqY?=
 =?us-ascii?Q?nTsRr1ZlB6nDgXO8yALSnhFLuWSxr2H28WgYH0TTpIdIriyZrWSvY+rMKL+O?=
 =?us-ascii?Q?tuyRsCRdGAapm8iho5bAWCVPOe4Jq3Tv4lwM8ow0Q6VuBJaOPtrlMwo8MFQM?=
 =?us-ascii?Q?JvQPXtfTnvsITvQV8ut2K1n/gpY+lQFc4WLj9PUUTa7tV7awmwpor70M6tIg?=
 =?us-ascii?Q?Kyqs2Ha9ItiJmF4CWfpo685xEqfzVYVATvOTLj02+rw6dAbbnG9AFcWGKUbF?=
 =?us-ascii?Q?9FYjUwS4P8Qiexqrz/J4Uf6B8ha/AM6wlShUIEXQ+KTqQ2cKiCHxWJKujOdM?=
 =?us-ascii?Q?8UkjRdIpeMS98ks=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:25:21.6166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f1f8d1-9516-4ee7-b019-08dd51775a81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
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

Use amdgpu_sriov_multi_vf_mode to replace amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev).

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c          | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   | 8 ++++----
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 49ca8c814455..a1450f13d963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1990,7 +1990,7 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 	uint32_t max_freq, min_freq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 270a032e2d70..0ab5f0ca2c8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -352,6 +352,8 @@ static inline bool is_virtual_machine(void)
 
 #define amdgpu_sriov_is_pp_one_vf(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
+#define amdgpu_sriov_multi_vf_mode(adev) \
+	(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 #define amdgpu_sriov_is_debug(adev) \
 	((!amdgpu_in_reset(adev)) && adev->virt.tdr_debug)
 #define amdgpu_sriov_is_normal(adev) \
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 1d04f1b79ded..178d4b5d4209 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1936,7 +1936,7 @@ static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdg
 	if (gc_ver == IP_VERSION(9, 4, 3) ||
 	    gc_ver == IP_VERSION(9, 4, 4) ||
 	    gc_ver == IP_VERSION(9, 5, 0)) {
-		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		if (amdgpu_sriov_multi_vf_mode(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 		return 0;
 	}
@@ -1971,7 +1971,7 @@ static int pp_dpm_dcefclk_attr_update(struct amdgpu_device *adev, struct amdgpu_
 	 * setting should not be allowed from VF if not in one VF mode.
 	 */
 	if (gc_ver >= IP_VERSION(10, 0, 0) ||
-	    (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))) {
+	    (amdgpu_sriov_multi_vf_mode(adev))) {
 		dev_attr->attr.mode &= ~S_IWUGO;
 		dev_attr->store = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 488360d2aaae..40a1fb741ec5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1812,7 +1812,7 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
+	if (amdgpu_sriov_multi_vf_mode(adev)) {
 		smu->pm_enabled = false;
 		return 0;
 	}
@@ -2035,7 +2035,7 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int i, ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
@@ -2103,7 +2103,7 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
 	int ret;
 	uint64_t count;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
 
 	if (!smu->pm_enabled)
@@ -2139,7 +2139,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
 
 	if (!smu->pm_enabled)
-- 
2.36.1

