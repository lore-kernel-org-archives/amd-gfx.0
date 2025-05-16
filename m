Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B849C3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 09:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D74010E9F5;
	Fri, 16 May 2025 09:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZQdWJKw";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCED010E9F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 09:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYNRenkaOhU+7hMVFNlqlLfayqR0dJuQ0JZzFbi23Pq0zr5Ay6XurxT7+rdOqj4ADkJb+ftHNP0JEmuxWIqyg/8YyRKvg4/fQ/x35HNoGeyF9kFS9eZ3QSKD3lch0hcDNWMHRVbj0SaTQ5y2gir5A5GVWpdjpvgeoN2baCqQNzKAH02aIvfySrVvz7tdeaYgUS/8mEyBy48jW5Ns1UJNp1QeY7SyybzWMRyxk2RrvMd/19MYLYZ9XPWUizL0ng4B9uHYdCduNGzeHrwlPEksANh566Slg6BMrTZMbcApiVWiYorux4C/7bREup8Txn004XxoJkqjUjP1Wv5T6p+JOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeE6d3GsIM/28Dqt6QHD3+ulEtOK6XGDoZO9rsh6PbQ=;
 b=i0+bT6VX0ppgmIvVdgtY81WcWJuY+D3D+x5fk/OFYmMwLHDNIP8LUrODNXezPJOseEOzHM3DB2pvT3NK9+LkUCE8SSemSgnxcXHSwvmNP7qjh2z79ySrI1EH7SL1LKARuYdYGWftP1l2chqEaTgRvxwCJi8pxDrGejcYr7fIQXceMDo3pSrhZ76L2mSldpDVe+6d+1mW6IkrazFzCp51m4ZeUT7/qoJkLHMpZa8XvqMGMcYkRtZexTIhTHygRn5J9RTJDhRc3EuTGt4h001s23YmPIJxZ9vfmX6bsMa41acwfcQdZGxrPkRvNUpsMZS3oNsU6bVjMwj8/vOq1M9rPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeE6d3GsIM/28Dqt6QHD3+ulEtOK6XGDoZO9rsh6PbQ=;
 b=JZQdWJKwWn9QgeYAcueKU32LIBs6PO78SueduQuXvAsAMBfU3nXVIxFzc/DSsGjPOP1dxResd2vlkpe1X3irR9VG0/7744nFd12KgQQkDQnp+pjjmbSqsfhPQrg0luA6+YxsHniixtD1Yxjy63rNPhz+4ASGt4e99b+d6G1cCwQ=
Received: from CH2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:59::25)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 09:19:11 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::81) by CH2PR03CA0015.outlook.office365.com
 (2603:10b6:610:59::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Fri,
 16 May 2025 09:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 09:19:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 04:19:09 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: Add support to query partition metrics
Date: Fri, 16 May 2025 14:48:49 +0530
Message-ID: <20250516091852.447786-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e70b25-f264-403f-9621-08dd945ab7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|30052699003|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mABB3uXY9M1qnSAatIVtgzyk/nxijx081LHsbudDGt0a/IgbM9iuWCGcS+24?=
 =?us-ascii?Q?27chA1XaAwR1+HQvEE2PojpCovOYLbr1WjZqVapvgDMx99bsmSUk5rpglI4C?=
 =?us-ascii?Q?4gVqh1w2/9eFp3jFpjLok12HCv+pOwOtZs65yDcmw8JzxPTJZvdTZMKwDGI9?=
 =?us-ascii?Q?QAIiahoTHTjvBgIJ6vIYIB952t37LVBY/ywjOz0cv1JA8fvfsMl053hlAx9y?=
 =?us-ascii?Q?ez4wXiFlBW3yD0Nr7azjZDA0jzQzPzKrYWYi/8Fo2ge5AROwJbES5FXkC2v+?=
 =?us-ascii?Q?75TyTjDhoFkEAfOXqlYgszHuo1j2MWUhQormZ4doC5E2TslNHl1Mw2DVST9l?=
 =?us-ascii?Q?xoAprQ5x9nRYgJ5f2blP1sFo8UQPAWTXsY76+MHk+GoP+bw5ezCGZVknlu9h?=
 =?us-ascii?Q?iGfgDPuSFWtKbjwiCoqnRWA+QFlkjCfCIOhGwZ7WNoKxWb7ve/QVZHe2YrB5?=
 =?us-ascii?Q?ibAwZIuY0CDJWdu6+WqnbwkFJACjCrfTJSAcTCRsIntdbgY/wxhrgQ58ArC5?=
 =?us-ascii?Q?xDuOtUD1VTE7GtAW5oDkuDIzipwBAIUhOeiYmnfcoFFx2lzpGaII+xEAocGv?=
 =?us-ascii?Q?fhQwNJhVtGtcm6be0wKR+kb7BxDZHMXh8Ol/sy1Oe6rTH0Wq4bep2MKpEBoZ?=
 =?us-ascii?Q?0cctnVlei8k5tICw7DxVq2LAkiVQR+osyrF4Lsfy9ALHZ9pA4PTeJIlama2b?=
 =?us-ascii?Q?wZhwSzTBm1s175UmCR5xHeOWH6fH6sEEeaUvB3SE8Y5k6ciXEwKlna4bhFWZ?=
 =?us-ascii?Q?Cc+Alk5Yi/9Cp6OLUAL7PJSVv/T5ujrkWBS+qqO5qmPOO32fZzgYkPzYkUQz?=
 =?us-ascii?Q?go4wFSgl8VEvCRlooYAddr0mO0CwOkYp75JVv22LQQWE8xFtZ/WTRUIb4Gz/?=
 =?us-ascii?Q?DzdvYnBpaK2pnKAS96vxwhQRrDkpOU6szrV3eFpXyFQOtjAnlnUGtuj50GuN?=
 =?us-ascii?Q?bktXcm1BKIIew3PYIaKyOBbaUYPNzP1pXqH29bbwr4Cc44g9ITookk6KE+gH?=
 =?us-ascii?Q?rr+g3JyrPLfx2P/JExfo/Q0T3ovum4mvT2X2250fYkTYOUINT6h381TwtTOE?=
 =?us-ascii?Q?w7EUBeVQ0RO8gC1LWO3op4/wW1GKExK3AOaRnbpjDQstTkXisfp+ZR+kw8Im?=
 =?us-ascii?Q?xlGmE4IGR3gTA8NKrZQ96iNsL/dsMU3GB4YIlmv/6dvJ2Cu64pllaRp7OxvZ?=
 =?us-ascii?Q?t00BTdnwNme7Sc0GkqZ1MYQqz7Jx0KcGeVAaEuollimcugCe6d9+183BK3mU?=
 =?us-ascii?Q?0TnsxF7vxwgj69Td3aD7YnX6qVPxGCptRASJcjv0AsR84aldKlvxkI+dMVs/?=
 =?us-ascii?Q?5bi1GklretOwTHIFuGuBDdBVsOMl9iJMg24FVWL4a/kADPk/lk7vrvZ0/A6D?=
 =?us-ascii?Q?TbhbivbIKZ+Tl3AW12jte0B7dyUUjCn2kwuGv+x2LKOCuMfL+3cxaU5+Vyxf?=
 =?us-ascii?Q?j5llWME+U55g54FVMJqQ1yAKKLZhQPjZtL2gOjHS7PuY9zgAgJotx2PEF5Lf?=
 =?us-ascii?Q?5vJxipP2JRhixkpRh/Rmnr3kBbj+/CY8Mgo/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(30052699003)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:19:11.0615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e70b25-f264-403f-9621-08dd945ab7fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

Add interfaces to query compute partition related metrics data.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 24 ++++++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 32 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 10 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 12 +++++++
 6 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 9538357b6ba6..30c532ab11e4 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -503,6 +503,7 @@ struct amd_pm_funcs {
 	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
 	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
 	ssize_t (*get_gpu_metrics)(void *handle, void **table);
+	ssize_t (*get_xcp_metrics)(void *handle, int xcp_id, void *table);
 	ssize_t (*get_pm_metrics)(void *handle, void *pmmetrics, size_t size);
 	int (*set_watermarks_for_clock_ranges)(void *handle,
 					       struct pp_smu_wm_range_sets *ranges);
@@ -1601,4 +1602,27 @@ struct amdgpu_pm_metrics {
 	uint8_t data[];
 };
 
+struct amdgpu_partition_metrics_v1_0 {
+	struct metrics_table_header common_header;
+	/* Current clocks (Mhz) */
+	uint16_t current_gfxclk[MAX_XCC];
+	uint16_t current_socclk[MAX_CLKS];
+	uint16_t current_vclk0[MAX_CLKS];
+	uint16_t current_dclk0[MAX_CLKS];
+	uint16_t current_uclk;
+	uint16_t padding;
+
+	/* Utilization Instantaneous (%) */
+	uint32_t gfx_busy_inst[MAX_XCC];
+	uint16_t jpeg_busy[NUM_JPEG_ENG_V1];
+	uint16_t vcn_busy[NUM_VCN];
+	/* Utilization Accumulated (%) */
+	uint64_t gfx_busy_acc[MAX_XCC];
+	/* Total App Clock Counter Accumulated */
+	uint64_t gfx_below_host_limit_ppt_acc[MAX_XCC];
+	uint64_t gfx_below_host_limit_thm_acc[MAX_XCC];
+	uint64_t gfx_low_utilization_acc[MAX_XCC];
+	uint64_t gfx_below_host_limit_total_acc[MAX_XCC];
+};
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 2148c8db5a59..a130afb22826 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2019,3 +2019,35 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 
 	return ret;
 }
+
+/**
+ * amdgpu_dpm_get_xcp_metrics - Retrieve metrics for a specific compute
+ * partition
+ * @smu: Pointer to the SMU context.
+ * @xcp_id: Identifier of the XCP for which metrics are to be retrieved.
+ * @table: Pointer to a buffer where the metrics will be stored. If NULL, the
+ * function returns the size of the metrics structure.
+ *
+ * This function retrieves metrics for a specific XCP, including details such as
+ * VCN/JPEG activity, clock frequencies, and other performance metrics. If the
+ * table parameter is NULL, the function returns the size of the metrics
+ * structure without populating it.
+ *
+ * Return: Size of the metrics structure on success, or a negative error code on failure.
+ */
+ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
+				   void *table)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (!pp_funcs->get_xcp_metrics)
+		return 0;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_xcp_metrics(adev->powerplay.pp_handle, xcp_id,
+					table);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 2c3c97587dd5..c0f9ecb97fcc 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -524,6 +524,8 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 				      long *input, uint32_t size);
 int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
+ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
+				   void *table);
 
 /**
  * @get_pm_metrics: Get one snapshot of power management metrics from PMFW. The
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 475555af3e75..de794bdb7ae3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3758,6 +3758,19 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 	return ret;
 }
 
+static ssize_t smu_sys_get_xcp_metrics(void *handle, int xcp_id, void *table)
+{
+	struct smu_context *smu = handle;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (!smu->adev->xcp_mgr || !smu->ppt_funcs->get_xcp_metrics)
+		return -EOPNOTSUPP;
+
+	return smu->ppt_funcs->get_xcp_metrics(smu, xcp_id, table);
+}
+
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
 	.set_fan_control_mode    = smu_set_fan_control_mode,
@@ -3816,6 +3829,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_uclk_dpm_states              = smu_get_uclk_dpm_states,
 	.get_dpm_clock_table              = smu_get_dpm_clock_table,
 	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
+	.get_xcp_metrics                  = smu_sys_get_xcp_metrics,
 };
 
 int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 69a48bd041e7..e60f8942b001 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1495,6 +1495,16 @@ struct pptable_funcs {
 	 */
 	int (*set_wbrf_exclusion_ranges)(struct smu_context *smu,
 					struct freq_band_range *exclusion_ranges);
+	/**
+	 * @get_xcp_metrics: Get a copy of the partition metrics table from SMU.
+	 *
+	 * @xcp_id: compute partition id
+	 * @table: Pointer to which table needs to be copied, if NULL returns
+	 * the size
+	 * Return: Size of table
+	 */
+	ssize_t (*get_xcp_metrics)(struct smu_context *smu, int xcp_id,
+				   void *table);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d843cced8069..31660bcb7938 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -52,6 +52,18 @@
 		header->structure_size = sizeof(*(ptr));       \
 	} while (0)
 
+#define smu_cmn_init_partition_metrics(ptr, frev, crev)                     \
+	do {                                                                \
+		typecheck(struct amdgpu_partition_metrics_v##frev##_##crev, \
+			  typeof(*(ptr)));                                  \
+		struct metrics_table_header *header =                       \
+			(struct metrics_table_header *)table;               \
+		memset(header, 0xFF, sizeof(*(ptr)));                       \
+		header->format_revision = frev;                             \
+		header->content_revision = crev;                            \
+		header->structure_size = sizeof(*(ptr));                    \
+	} while (0)
+
 extern const int link_speed[];
 
 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
-- 
2.25.1

