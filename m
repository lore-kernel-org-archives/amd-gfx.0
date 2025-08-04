Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D6EC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF7110E1B4;
	Mon,  4 Aug 2025 11:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gwikzpox";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF08410E1AE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+M8hSRlhPw5VRCcA6ZN3SSBUlvnm0oQaOVYyQSaMbNhV/bGdyHJbgFfw4W3tNV9nQmmMfvm2ozHRMhDm6//R8F+Os1R6VLW5czemNf8GEgGdoBuXHZhiyXRYreBbv5u0LwnxgOfc8h/uDIOZd5KV7wm1SfzwxzdsKlwezYJtgoOremLDSBa+4fzl+3lYDcpjhoFEVkLxKRxTaIz33/WJf5/cymOZVyTfOWTe4KqzW8Vjol0W2+zqP+aCVPwYWUeiWoNiRe4WJtMYWMZ833zol3dqY4M+5soeBPOqZpzQP7t+Sz+lyjIoy55nbAe9WgJ7ij6RulZxgbAnfVZkighGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMaJzbM6my4HLCzC0xUCRvpMlom9siPsEQ5Rqq6i3SY=;
 b=laf/c4KDVJfnf7zINaO3du5PRhp+yTBNMc/Q6T43T2BerL6YMywyv2cBSHnu4sgjDqYhvOO17MPFm5T1T544SMmck6/YOj4Q4ZGa+h1N/VFgXZXz1cCMZ1XeR1Kj7CSh8BN+NnKDPLlF0tJ0tGJbGwkoiikU+zACaxUz+uwLVqXzan2MXGe5AxAdftSHf2+c+6bHUf7iiDwjnbSmjcEYGET1yoddfUWjad4+gXCbzhltt/RzE98czgv1d5qtZlxJRkdS+Y1zcmT36DHLOaeg9yNQWtItvK3ixqHctB1KFG4e+xwUE5m+F0xBe795VWudIMikiJIKm61RVkz9uIgM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMaJzbM6my4HLCzC0xUCRvpMlom9siPsEQ5Rqq6i3SY=;
 b=Gwikzpox9DABzibBBC0y3ddDwdnpFAfYkWcX0xN9uJeSkK1Wb6hIHz/xNhMWF53TWMb0cwlfRU7G1+IMa8ZYINTLovhmAQsGwdFrbav/7UpRv8fswoZ9n3yw02RiKqKcYbv3mAoodD65u0YqidHPZsMsUVw0y/QJFgtPv74U97Q=
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 11:05:58 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::f1) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 11:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:05:57 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:05:54 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2 2/6] drm/amd/pm: Add smu interface for temp metrics
Date: Mon, 4 Aug 2025 19:05:35 +0800
Message-ID: <20250804110539.637463-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804110539.637463-1-asad.kamal@amd.com>
References: <20250804110539.637463-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac64895-61a2-43bf-d76b-08ddd346e3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E6MJ0E97CS5UWT4oZEIA2k6JDu7REXTfwBpwzI4xIhSKcPXx+5TO9fREZGYM?=
 =?us-ascii?Q?jzZkT6OJdxhFwgPdJ/7StFIS3Y24djvID5Xv0uGfbdlbUHfrInustBtFA1KK?=
 =?us-ascii?Q?mCV/3XYfeEEGdO1FQOcciVgJSjQ3Rr8Rh63shhCBUy9ORiwDOJ+QecEUWHw7?=
 =?us-ascii?Q?4G+Tuzn5MypYye6ra9eUnuk2wILQaC5gOqXNo0SEns+xAq7Q/0VATuywImHl?=
 =?us-ascii?Q?ZbMaul2QMf05zgIgfiz55L8dTj2ixEfhRzrwpckshESfezlD8aA5A5Wo/R/G?=
 =?us-ascii?Q?yTDaIs4yK4T+i5j8QcmTQY4jXmmEjcROUebkesmn+CDhhhqn17CfA3RPmYVt?=
 =?us-ascii?Q?FFnIsD13IFqj8ct7YixQl620GXTjbfcs1g8XoOV3q4kdirgEfv229gelSkpC?=
 =?us-ascii?Q?T9gVbrJ/1iv+GfQAmvhS9jQVd5dvFix+XQtYR/KVFfKKM9uq6TzK8gGEJf6J?=
 =?us-ascii?Q?mUD/pDxLfJfBa7qA96cmq8fbZ9Z2nUe29SSxWm1GQKuR3xLBbbmSi1d31D/v?=
 =?us-ascii?Q?fUBCDU1USYvwiJCXRiOWdkMymxJSADpyKw9nerUejws9C2g5dJlE9YtOYRhQ?=
 =?us-ascii?Q?RnjWVqfsiTVxADvETZuUp15xuInWsQsf+B0k5sPiQzW/Ocz9MLbzN5Es8xrt?=
 =?us-ascii?Q?OSVL2i4EjW8XguRzoeKpiQJODHMpg2k1v7YPgZJltUcIrOfqAL8SUx+HmYPu?=
 =?us-ascii?Q?3QTGjfLCVEfhObj7l33sGkPS48LBE7K/nY/6fgBSitliP4OrqP35/HeQCY1u?=
 =?us-ascii?Q?mB7HWe6ZHhsL3ZckumXP3c9Z2WIa9qNaQgqUQzIb2S8CcxqRaMNRUL31VDx8?=
 =?us-ascii?Q?YjnOVr+uGnppxdwILJsKXuhJ800+Ns2EgKQjvAOkrZO/fte6bxwCoVpfG6qO?=
 =?us-ascii?Q?xHQXak5WHV+Ssom+X49sGB5dErw3eAaIAAIQl/JQnAPD9ulbCfpeTYHgjq+u?=
 =?us-ascii?Q?Xy9dpG3ZvN/SykA/fFVvKaBbYD5PT8kB1DjIxfG3bPzZ1FbFE3A12up2KG3a?=
 =?us-ascii?Q?p7x74wjw7fg2HDOgGLqzlh1lF7Y4/VPKty//yJzcu4irdl5yz+u4nYCIkAQ/?=
 =?us-ascii?Q?MKEOlTscyTH22VvE1pKTsg7rD5AhtQQyZLRFrbwc3Ze9AzWuMN+UnloIeLtm?=
 =?us-ascii?Q?msxScZTnYItehpwBkWssmMEPXmk9YXl71rArZBDGsQ9axPEVB+0HapCgrKDX?=
 =?us-ascii?Q?CYF1iNqbIdFX1esZK4FYvOh5d+cteVoQt3C+Im3DO5deEuBNw5G9md85HNp+?=
 =?us-ascii?Q?DbxyV6ztUPt0yygcySkWDxwGfcAnOdHlREPX/dcwGHNrx80KiAY3CkdWiDtF?=
 =?us-ascii?Q?Ud4eFkRJeIlWKONiTFGXnaLM4LQSJjCbRvXKIbXLE6b65vKsRz+KrnChNHPY?=
 =?us-ascii?Q?Ufu6HGmGVKA8b7QNn1DFEqJTK90pYay7nT3Jmi2oGzKumkYWO2efjfYe2lnP?=
 =?us-ascii?Q?5I2YvRGlX62CoBm2zShZ5Kq8O6H+2v3EAfMnwVro5ShQ7GFqfeLk4UQM4uSm?=
 =?us-ascii?Q?fIfEhW5h12S9zUspx712s+crBv9qmdZy7hFi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:05:57.6838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac64895-61a2-43bf-d76b-08ddd346e3aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113
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

Add smu interface to get baseboard/gpuboard temperature metrics

v2: Rename is_support to is_supported(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 27 +++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b47cb4a5f488..8b015107f761 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3831,6 +3831,33 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 	return ret;
 }
 
+static ssize_t smu_sys_get_temp_metrics(void *handle, enum smu_temp_metric_type type, void *table)
+{
+	struct smu_context *smu = handle;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (!smu->smu_temp.temp_funcs || !smu->smu_temp.temp_funcs->get_temp_metrics)
+		return -EOPNOTSUPP;
+
+	return smu->smu_temp.temp_funcs->get_temp_metrics(smu, type, table);
+}
+
+static bool smu_temp_metrics_is_supported(void *handle, enum smu_temp_metric_type type)
+{
+	struct smu_context *smu = handle;
+	bool ret = false;
+
+	if (!smu->pm_enabled)
+		return false;
+
+	if (smu->smu_temp.temp_funcs && smu->smu_temp.temp_funcs->temp_metrics_is_supported)
+		ret = smu->smu_temp.temp_funcs->temp_metrics_is_supported(smu, type);
+
+	return ret;
+}
+
 static ssize_t smu_sys_get_xcp_metrics(void *handle, int xcp_id, void *table)
 {
 	struct smu_context *smu = handle;
@@ -3903,6 +3930,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_dpm_clock_table              = smu_get_dpm_clock_table,
 	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
 	.get_xcp_metrics                  = smu_sys_get_xcp_metrics,
+	.get_temp_metrics             = smu_sys_get_temp_metrics,
+	.temp_metrics_is_supported      = smu_temp_metrics_is_supported,
 };
 
 int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b52e194397e2..b490c39e313e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -396,6 +396,10 @@ struct smu_dpm_context {
 	struct smu_dpm_policy_ctxt *dpm_policies;
 };
 
+struct smu_temp_context {
+	const struct smu_temp_funcs      *temp_funcs;
+};
+
 struct smu_power_gate {
 	bool uvd_gated;
 	bool vce_gated;
@@ -529,6 +533,7 @@ struct smu_context {
 	struct smu_table_context	smu_table;
 	struct smu_dpm_context		smu_dpm;
 	struct smu_power_context	smu_power;
+	struct smu_temp_context		smu_temp;
 	struct smu_feature		smu_feature;
 	struct amd_pp_display_configuration  *display_config;
 	struct smu_baco_context		smu_baco;
@@ -623,6 +628,28 @@ struct smu_context {
 
 struct i2c_adapter;
 
+/**
+ * struct smu_temp_funcs - Callbacks used to get temperature data.
+ */
+struct smu_temp_funcs {
+	/**
+	 * @get_temp_metrics: Calibrate voltage/frequency curve to fit the system's
+	 *           power delivery and voltage margins. Required for adaptive
+	 * @type Temperature metrics type(baseboard/gpuboard)
+	 * Return: Size of &table
+	 */
+	ssize_t (*get_temp_metrics)(struct smu_context *smu,
+				    enum smu_temp_metric_type type, void *table);
+
+	/**
+	 * @temp_metrics_is_support: Get if specific temperature metrics is supported
+	 * @type Temperature metrics type(baseboard/gpuboard)
+	 * Return: true if supported else false
+	 */
+	bool (*temp_metrics_is_supported)(struct smu_context *smu, enum smu_temp_metric_type type);
+
+};
+
 /**
  * struct pptable_funcs - Callbacks used to interact with the SMU.
  */
-- 
2.46.0

