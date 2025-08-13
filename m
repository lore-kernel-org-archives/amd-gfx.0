Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D29C87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 05:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A96410E1B9;
	Wed, 13 Aug 2025 05:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TMKsifRc";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A6710E1B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 05:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osCvH41CcBT2ZamKwaYkjE3G0e68fvceS9Zu0Xwwjy7HavAQfmkCdeTmRWrR9N05VafgV/byhP5lD9tluhSgI73JbJvqDrMgnpT4bu3vlF/RuXWI3nCWwdqyb8RM+Gk3BcwoGjO28VMyuPjgp4tHxrUlWImm57hWtx8Wlc+6JeUlIyhIfyFb4Wizx6NldFdbqiKrdIxlMeHUZqKaI0TyR2crMh+y0co7X5Gm8vijnbsRPQew2MiHvaq2oRIfqr7B59hHWyXEg5PDXDyszqtiLrOszXQyHk95QYDJkc/xrsB3iZjbErav03ZlCP2OJYOFifzv9KUgCXcl4CLEqPDJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOxulAweBoH2FONjd3cNfd1o6VaY4M+M3iQi5/sbZlo=;
 b=FT61YzOea13k+SprdFAeEqinJs/V2J/TthQznV6gP35e7V9YULPA1nazqWdb/TeUsPJT34p7nFHJ0R0rXRiXihIfDrD0SRbZgeqFiFd4ldrP7s853MEBAT5XFSEJgBBFD+EmTT90l/ErQeuoYYg860Zy0M9FW57o+t0T/UVFIRDig3NNpc1H+GjBvLOE9n7iJXOjdHaCuORBqREW39l50jvY8+wKWI4eXB2y1+zg8rhJ1FG27Nlf/Mufnx4mmWh455f6s2K4tyaM2sAY0QJiNU1nEsyj7UMI1/YWifCgvTC+9d0CyjirwGH4eUFgV8uB8yxLLMZdx5JJ5m6ctuxyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOxulAweBoH2FONjd3cNfd1o6VaY4M+M3iQi5/sbZlo=;
 b=TMKsifRcvusSVQE5wQ4MWaMv9WJ3cQoVJfowZU9lYYQw4dyC6ubpeHhU/ZoS72V4N8XRHx5PJc4S2lHN/bOjVzzjr+O48rvE2i67vXHzrrO1c1w1SVDJzkGlX9wYkjMaeryBywYZOdgbcITuBgQ9cz+LIzj9oJgqaH/gbnkSHEE=
Received: from SN6PR04CA0107.namprd04.prod.outlook.com (2603:10b6:805:f2::48)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 05:21:11 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::7e) by SN6PR04CA0107.outlook.office365.com
 (2603:10b6:805:f2::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 05:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 05:21:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 00:21:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 12 Aug
 2025 22:21:09 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 13 Aug 2025 00:21:02 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v5 1/3] drm/amd/pm: Add VCN reset support check capability
Date: Wed, 13 Aug 2025 13:19:59 +0800
Message-ID: <20250813052102.3438895-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6d9676-2a27-4bf7-4b6c-08ddda2936d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kfHM3YdKuccKG3o5JC88VeVaY/lxCP0ie0g9MflUllveoBI0RpCyhUXJ3sva?=
 =?us-ascii?Q?/om4d3q4+gLz1G7b8R9oq8ETmtZYOYmK3wnntAIK2C8W0bYwxNGiSPKcE345?=
 =?us-ascii?Q?c6dmrko6Hoz7Ln1u948dWBVGAk5PdMqhg4kInamvC5gOzmbHeWc7Jk/peSx1?=
 =?us-ascii?Q?HvrFv9qXX+E8Jvlp4Jk1w8e0An8Z/wx1G1ikgtR2v9iy+yPlUsBDMXJlsmMQ?=
 =?us-ascii?Q?AJlbg9WWddInifWWcYTU9VGSJJMTEEQwfKhVq14Odj+Ht0xWljX5voTdEwfF?=
 =?us-ascii?Q?R040Ts1Syd27jZxs0xztbcbMMklVUt7DNnhhpNli8jO2hXw7btuonsHv8xjD?=
 =?us-ascii?Q?U/odWNRXg/1NASiXvlOA7eAUHSbnJtIlRMdejdw6zjncGQkOsSw1/kGe84qQ?=
 =?us-ascii?Q?kmSrReKchzJlhXsgzxUA1GOt4fLoDS7Jj7FNUFx8KKTkuFBRTHMInsjhEK77?=
 =?us-ascii?Q?Z5ObM6I9YNhneDT8N7E5xOxFik+q9ruZjM/W0RGmGEuJywlH6QMXY+MWcyuD?=
 =?us-ascii?Q?zLzx+YnvKuogjZjTdI3JM7xgop1V4W200fC3N1rjhx6eWkDsqaG3+8s8ZY4G?=
 =?us-ascii?Q?relLZ1ea05WBuro4olEOeVYGj3eGNPNrPVc/gnsuI2hOwXhcv8H7B9Zwg2cz?=
 =?us-ascii?Q?LafOQ6OHat/IkURkYaNEYG5hmtb3xY5od9J4lsy0qi/rkTgx/Yrc1a5/6TvI?=
 =?us-ascii?Q?BvzAoh8noqy2JkZcERC12IR7EC5T8JcRzhufAZ0l25UmnsNjGhQ+HVAyN1Lw?=
 =?us-ascii?Q?SOOZP3pLXHrOxzGxH1MhXGn09sYf/3bEMTREP6FdGmcBXqa4XTK1tfD3HET6?=
 =?us-ascii?Q?j1COdof9Wt8QhCUXE3sj1wTzLIhr0D5tY7prjKhr4TYRAJmt4CarrjD8uKB+?=
 =?us-ascii?Q?3OFoY4EgQ4BGFzYDBkeMK1MZabizihdyQE+dhYQj7lpP/VqyrL9IQWKEWNaG?=
 =?us-ascii?Q?4OpJ3BFZUgzFIk6r1T8M4mudozlJZ9f2wKo92/keEWyW5G7uiP5pfYEGV09S?=
 =?us-ascii?Q?XkEBuJFyKbJoIR01V6f3SVetiaWsgBZqOyrB16+N5BmuM+8aSOjwsjtAJgSD?=
 =?us-ascii?Q?ciiEyaiDx3P+/UNwEdSfgWbeo+iA/wj1jmXLkRK2z3Zjy8Z3tq+w7Aa+WaEW?=
 =?us-ascii?Q?iLe8VjFH7Kui49RWldg2aq/sBQ9sNnuio+XWa0Os3t+DG+kqEMoYGje1+bpI?=
 =?us-ascii?Q?ZlA5r5yQ0MXTnvGVf1Q/MXBNKhiB5d/o0edWubG7Hg3IILQY9dWB8SC1te9X?=
 =?us-ascii?Q?SZaaU2lis+jfh7J/mVT9HUjFZgNJPoY4+ncwS8Ibwh7L0aB1ymNDLdch/a6I?=
 =?us-ascii?Q?mJfLHv30UkODgmxUvNneY+4R7+7xj2lsJ5Rn8SUIYsct7MkKDF7n+oi6vGEZ?=
 =?us-ascii?Q?hJq3xjuXq5N7ZX0GRcH+8NTTaBE+KCoGu9BPhnUX6AZTw2OFcgKj8KQoWUq7?=
 =?us-ascii?Q?JpljLKkZGwinwC0aAq9adPBp548hJONU07EH/qGaYnoKTT2Gchoch7ba+1Ym?=
 =?us-ascii?Q?5IFIdzulI+9pbeh++kc1foKhKREhsaMo3UjN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:21:10.4476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6d9676-2a27-4bf7-4b6c-08ddda2936d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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

This change introduces infrastructure to check whether VCN reset
is supported by the SMU firmware. Key changes include:

1. Added new functions to query VCN reset support:
   - amdgpu_dpm_reset_vcn_is_supported()
   - smu_reset_vcn_is_supported()
   - pptable_funcs.reset_vcn_is_supported callback

2. Implemented proper locking in the DPM layer with mutex protection

3. Maintained consistency with existing SDMA reset support checks

The new capability allows callers to check for VCN reset support
before attempting the operation, preventing unnecessary attempts
on unsupported platforms.

v2: clean up debug info(Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6e0d711820ea..518d07afc7df 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -820,6 +820,21 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
 	return ret;
 }
 
+bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	bool ret;
+
+	if (!is_support_sw_smu(adev))
+		return false;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_reset_vcn_is_supported(smu);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 09962db988d6..9748744133d9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -615,6 +615,7 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
+bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0a40ab817634..c5965924e7c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -4124,6 +4124,16 @@ int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+bool smu_reset_vcn_is_supported(struct smu_context *smu)
+{
+	bool ret = false;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->reset_vcn_is_supported)
+		ret = smu->ppt_funcs->reset_vcn_is_supported(smu);
+
+	return ret;
+}
+
 int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 {
 	if (smu->ppt_funcs && smu->ppt_funcs->dpm_reset_vcn)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 2edd867f203e..5dd49eca598d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1435,6 +1435,10 @@ struct pptable_funcs {
 	 * @reset_vcn: message SMU to soft reset vcn instance.
 	 */
 	int (*dpm_reset_vcn)(struct smu_context *smu, uint32_t inst_mask);
+	/**
+	 * @reset_vcn_is_supported: Check if support resets vcn.
+	 */
+	bool (*reset_vcn_is_supported)(struct smu_context *smu);
 
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
@@ -1776,6 +1780,7 @@ int smu_send_rma_reason(struct smu_context *smu);
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
 bool smu_reset_sdma_is_supported(struct smu_context *smu);
 int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask);
+bool smu_reset_vcn_is_supported(struct smu_context *smu);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
-- 
2.49.0

