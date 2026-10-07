Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7187CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F1710F58F;
	Wed,  7 Oct 2026 13:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xjDZfRmU";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB6F10F58F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYHYU/BTnx91bCjI+oKD42yEVjcemDE7oHJ8PJaTjdcpuUZ/ccIOw4DbThqQRHa/8fNGFMNxVn4Iv9a4qVBKLLT5MHI4hLD4H+EHGWUQvj++XpDeE3tafFhvEn2cCJBwh27aoS0T5Wc27f5tMt2gKlQ3FuiQiPRVoo0xC5TIgoyRkaD+rosxEH1/9OTuXN2BGrt17NVuej8BBZ9039bdV6gGW9Z/9SlLIFrfEEpBHVKw1YlCfLiS0/Wln7IKyvHzRI6QT3WG9XBTeYbcTsaXMBnsUH/3GHA1zmbYVKPBvB/l3isnDs8ts7NrLG766oMyKG0RUhjYZ6LSQhClfwqdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ycw47iG3zVozxoG0D5nkJ8ihBH6S9Ndgxjz5OjnUTxI=;
 b=C2s9EHo0YYwtxPWJfCAYmjQNq05CPVGFCT0z0mR+aNTnWDUxH48j9Z7cWD6oLs0iYCnhZVHPK0yiy73bXuXJ9adyPDMmWnohWSLFHc0PDaiiibF8yl69Hb/57If3VSFUURUxqfRQ615iqS4Vq9ncMHLcR1w6zgiOTVMWvpg7Sv+d4PzLFfk3nlEvHpJbypRhKJV3ALXpsLLA91Hgszho3tHpDM9arXg+IcrHMdW1piVAFdMQ8KIh+FeVlOKIQMpipJHFs9p4JaVL0/HQV2XZQ6q1sLr37UVNFKaTxqH6z3Nc5FPPPPhwGDeCExk3hyD98Qaj6eX967GfIDo3301LiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ycw47iG3zVozxoG0D5nkJ8ihBH6S9Ndgxjz5OjnUTxI=;
 b=xjDZfRmUEAJ/92GZbUcnniIPXSZuTDQolM7hZCrvTGrhUQW88yJoE50CDVq5nBu4tOc0a4UR1nuDjLMS/Uv8mOyAYKgZg1xuBPqVswj21zUc+tmVcEbgPH81VTec+Imo9xBYL+XgpT9Dp0CuJeXkfUpkotf/x0fOl0I7DhWJKIU=
Received: from BY5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:1e0::16)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 13:14:47 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::29) by BY5PR03CA0006.outlook.office365.com
 (2603:10b6:a03:1e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 7
 Oct 2026 13:14:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:14:46 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:14:43 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: Add set_npm_limit function
Date: Wed, 7 Oct 2026 21:14:26 +0800
Message-ID: <20261007131428.351196-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261007131428.351196-1-asad.kamal@amd.com>
References: <20261007131428.351196-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: b930b3f0-5d61-45d2-617c-08df2474f5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WQ6E0GeLqFmYniF+PM+jnKl4SFuihuG9D4AfdCO3ox9CvhaOuyK/8WYSMwpEx1nw6zweaGCUrj3/Z83a3Hh0Z2zyVNsF+IJUc8DJetmgjv6qEfHEJhlWQcgy2iBiAVAfpRj+iBxenrWRN2rHnDg+LYh4wf5MhZPfStOvCoXV5t+KqsyEQovn4xGNyj0M8hLTi8wYukw9nsnHPT83x5UJfFMBacQFdY4ZAeVfjmrAN47vwhYLlR/lW5Kq0gh4U9Tes6LPa3d9in4Gx8xDPzsvpTrmmDyy4kDE+6zhdt/wNQAZJu7tq0hh3fGTNAE3PKfrI1rUIeDiTK0gbGX6aIGie9uOWxyTlWsqsmlYMHTirVN8pABrKHWSgkmLRcypQXx8FsHRVSCQjzsE7lyWzyNiYJZSm7tNEz40EtckCRu+HqzS/ddXUHcRaTJy9hgKnbo/nSfc0U526xecg49k1LbDAFsZ6+yd4wJGrEdDJdA9Ujps+REL8EOaYkGaTnuf887y2J3OA52zC7SfIe3UkB4wAldBzz2GR8bszRQHpJO2tHfC43nQbDPas+0biIgQb2dvso96DSbCn4j1uqExaWnP67ht1vQZ0eCZTsGV5yziFIegqXLVuL3p5AHJHm4c+7v4oSCc8mQCN+lrrruVe7xHqMg4ju/aBld/rkwR/8HcxENK+DJWEXMF/ZykaJnL81NL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cxnReoDwbWWF1qinG7D0gC/gdSZDCtwmsu4leD0HkNqqpgJCoz5oqWl7QuwCGaFGlEcp6R3kSsDrk3/TgmViMnCx9Qss3Rr/bY1d4T8n9BkW2OgOpA2ZgPRg/mMDlAbVIqwRezuSTL9G2UfIfhhknhscSe/ECOvxJj1FNVmaiDiakSRBYbkRzRXVd+SO8Y4ZjgB9HKwzgTMUlC7ZbgCkCW2sC6deD3VPJ4beGWNmM2wYDxsfkEsWpNugp/XKw/5/lylang7342w21O6f4uu4FJB+w8ZYsoiG+6yyW0wx2lFN85gaWAsAtWWI91U58SSqqBJ9p0EGOcWm/to703J4npW50fXko3g2G1HN6N7UI2WKrn/DTEzPRSZqClS67hQTYM4LeR1LiVuozJMMyA8vB9E9wXA4h/4WiJh9RRszBIi0JE947+endU3l72cDqPJa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:14:46.7723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b930b3f0-5d61-45d2-617c-08df2474f5d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444
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

Wire up the set_npm_limit callback from pp_funcs through
smu/dpm to the PPT layer.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 14 ++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h   |  3 ++-
 6 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 4b863a2e38f1..ca818965afe1 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -530,6 +530,7 @@ struct amd_pm_funcs {
 	ssize_t (*get_temp_metrics)(void *handle, enum smu_temp_metric_type type, void *table);
 	bool (*temp_metrics_is_supported)(void *handle, enum smu_temp_metric_type type);
 	u64 (*get_npm_cap)(void *handle);
+	int (*set_npm_limit)(void *handle, uint32_t limit);
 	ssize_t (*get_xcp_metrics)(void *handle, int xcp_id, void *table);
 	ssize_t (*get_pm_metrics)(void *handle, void *pmmetrics, size_t size);
 	int (*set_watermarks_for_clock_ranges)(void *handle,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index df5bbdab1ea3..0394085a0328 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2124,6 +2124,24 @@ u64 amdgpu_dpm_get_npm_cap(struct amdgpu_device *adev)
 	return cap;
 }
 
+int amdgpu_dpm_set_npm_limit(struct amdgpu_device *adev, uint32_t limit)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret;
+
+	if (!pp_funcs || !pp_funcs->set_npm_limit)
+		return -EOPNOTSUPP;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EPERM;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->set_npm_limit(adev->powerplay.pp_handle, limit);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 /**
  * amdgpu_dpm_get_xcp_metrics - Retrieve metrics for a specific compute
  * partition
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 64d68a905f86..72b13ece22ef 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -617,5 +617,6 @@ bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
 u64 amdgpu_dpm_get_npm_cap(struct amdgpu_device *adev);
+int amdgpu_dpm_set_npm_limit(struct amdgpu_device *adev, uint32_t limit);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a65aa2129845..3bb36668eb39 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3995,6 +3995,19 @@ static u64 smu_get_npm_cap(void *handle)
 	return smu->ppt_funcs->get_npm_cap(smu);
 }
 
+static int smu_set_npm_limit(void *handle, uint32_t limit)
+{
+	struct smu_context *smu = handle;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (!smu->ppt_funcs || !smu->ppt_funcs->set_npm_limit)
+		return -EOPNOTSUPP;
+
+	return smu->ppt_funcs->set_npm_limit(smu, limit);
+}
+
 static ssize_t smu_sys_get_xcp_metrics(void *handle, int xcp_id, void *table)
 {
 	struct smu_context *smu = handle;
@@ -4069,6 +4082,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_xcp_metrics                  = smu_sys_get_xcp_metrics,
 	.get_temp_metrics             = smu_sys_get_temp_metrics,
 	.temp_metrics_is_supported      = smu_temp_metrics_is_supported,
+	.set_npm_limit                = smu_set_npm_limit,
 	.get_npm_cap                  = smu_get_npm_cap,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1e5fc6ff76c8..f516d0d3bb92 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1626,6 +1626,12 @@ struct pptable_funcs {
 	 * unsupported.
 	 */
 	u64 (*get_npm_cap)(struct smu_context *smu);
+
+	/**
+	 * @set_npm_limit: Set node power limit in watts.
+	 */
+	int (*set_npm_limit)(struct smu_context *smu, uint32_t limit);
+
 	/**
 	 * @ras_send_msg: Send a message with a parameter from Ras
 	 * &msg: Type of message.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 2631e12b5e59..f86201764814 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -305,7 +305,8 @@
 	__SMU_DUMMY_MAP(SetSoftMaxFclk), \
 	__SMU_DUMMY_MAP(SetSoftMaxGl2clk), \
 	__SMU_DUMMY_MAP(SetSoftMinGl2clk), \
-	__SMU_DUMMY_MAP(GetSystemMetricsVersion),
+	__SMU_DUMMY_MAP(GetSystemMetricsVersion), \
+	__SMU_DUMMY_MAP(SetNpmLimit),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
-- 
2.46.0

