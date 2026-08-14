Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EF7C5DF6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4563A10F74A;
	Fri, 14 Aug 2026 21:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C5dvweDi";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7178210F745
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAlfnWPI4VlYU7RizEE+RaIjSCt0dp83QOUE4TVkEzgK7F9wM9pV6Zu2i+yZsfH7OGWhwhdUjTP9UmoFQDIDvMWR1vnVLpd0SmhKeFHDpqzBaQiXWMoT+YmZ1ZpgdU0UslQA70hCaG/M1ME8tk7ZcQsgB47dSuyXQmCT8QpAt9qXZJsAhLx0cTQpBHeanD6crl/ltqv9vpZix30uxRvu/ju5cvLSMC59oLquk2YxK+qa5EA8zMbNd5ebd4EnJW7qSEGHq4f+LRA/DHhWi4rSneOnGFTgTmM9VAKJ3j5qULXaG7+Y0oZKcDmAaKo5eUJSVnj2gk41Uqm/YsNt6K/m5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BokHb/nvPTmyEnde7t/XBhCcuF6A1KlCr65qu1yqb50=;
 b=IHSPE5mt3rwMg5jb4YSkrBILU09PE98Hrk3SaverrK3eDtUyWuQllsKBAZdm1DCBXbCjYeMA9sD61e8uTlgYZF9Q7Ur4OBSeIucyil2ZdNxgA0Dd3OLP6pQgZy+K311l74xnDrF2OzqsYmyx9kaz7gAZCj4WLiP8cTlUX0/OIPKJkbJAUycxW+TMjGOjQ8CQXpEUHY7GxIJ2OAmWyaOMMMe12FsTAtBEiwlsn/tEtPaE5Gw7rE4awybJcVK9CHPHnNJeAF9lA8DoUMIQ9aaLoaywV0lYalCQSpsL+RFE4ywo1FHQXQZ23dpnsbXFdRh2ctHEP4S7x4F0WuGOOJS69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BokHb/nvPTmyEnde7t/XBhCcuF6A1KlCr65qu1yqb50=;
 b=C5dvweDiWtKsnPyCGc7D6+zIvb8Ye06nuUtUQ8FCfCVM7stWiM0/xXm8AiHkegLX8+NNDoLgJNoSgiJytBi36ZJCT/fobAsVFYA1zqdKS+S5tr3Rz0LAuHD6WXF3P27Dr6WUl+w/pFW1POMt/0pUNoZqt00b5QiTPZft1SCkaVQ=
Received: from DSZP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::13) by
 CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.16; Fri, 14 Aug 2026 21:03:57 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:280:cafe::a6) by DSZP220CA0003.outlook.office365.com
 (2603:10b6:5:280::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 098/109] drm/amd/ras: move BERT boot errors to BERT sw init
Date: Fri, 14 Aug 2026 17:02:35 -0400
Message-ID: <20260814210246.3067612-99-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc22620-3ae9-4c44-479c-08defa478e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|22082099003|6133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: +o1j5Q1tDBOASjrDfCUe0wCYiu9pMhIHgT82xpinpq/fVYIh8QDTZ/I02XIbdmLOGB++HN0D7BJVwH7SURza8kvRQZrqBCfLdB/qc1u/XnAkcs7iH3GIs4D6rRyZGPDQPvcTLVB0oiKZGE5MEIG0IaDu4OE0FRaiWmc7YNlNLYmBgZneVKOvcNDQERO7o/XbDBLhxWl+/HBBLJsP1ctamupgVH2gd76Tb9uLxgEwjIpXsalyWXun7vannhE9VgGa8Uj6inTf0maMEjU/FGO5FON+yudvKMmWaYHvFVP6+uBBDsq+VmS+x1bvkMZDALZfEF4e05REZaYek8VB9Bwe1awRT4dObODCMhzHS4EJZy+OgArOYQ0IPyPmy8bqrD9VZOwU6Ee9KwfyNUnwQSq0hmjPYtSD7twKaK0WsAqxwArqBDupnbosRJyy2/wzM4LWOu6Bc/QGwmLlT9Rsfshas9xKc5+vDz/wSX3r2FfG60rP+dQRO0YiTx1n0zLdpIj4fvevFF+RAdtwq5G6RB8nva2pIDTmiAwmlxJ/oq6mV2TCwRC4KxZVQJAv6O/dTBQxYP1xNrLxDtKw1+Qy031AgqOUt77OkA92N+0rVG7j3tkVT4XFbOeXV//sMIfIhyQDnlZuvdmCHnT+QVOGBZ7Q/D1IVcJ2sDIzTUzsBFyIawM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jzH5unEKWdFy1yCVCK9DwEWU4Cd8oqT6be/eBYwzqXpejuSmRMYEOVnNieOUgKrAqQSAkWcILqfJ15ebVvLoe0HuF2ai0Gw1bgE5vZo/9qI1NbbHtTkNMSffko4is228AMe5ZA0zq9GyfiKfmhbOKKmKDIiQzDlu6jcwoPYiNAxfoipqTyaPcDD63bmJC+NuI67LCRT0HvEKUc2NV4/8u8NO6a3RjCje49o6DQ9ZSw1jBGh1UgZj0/1sWQyfxVxN/nVEeE5eIN2QWmE99iE+YhLU+9oAvxUZCL+KyTsNRDsnQjD8/5ymPQY9y2/ehgtyeITFjBNa93vBdwkbtsa82VI5o0/jDUDnGv9jjdkitjOwwjbGFVuGUaASyLxJEq1hPPMpNyb8xAmgvJdHYaKdsj0e6ZZS6y1eOMTmQ3nNRVSdtqvMx4Pw3Gm2MjCYygNs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:57.0673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc22620-3ae9-4c44-479c-08defa478e5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033
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

From: Xiang Liu <xiang.liu@amd.com>

Keep BERT boot-error handling owned by the BERT module instead of letting
the MCE notifier lifecycle drive BERT processing and cleanup.

Group the cached boot-error state into a single structure so the related
poll result, raw record data, per-socket write tracking, and lock are
managed together.

Expose only the standard BERT sw_init/sw_fini entry points. The RAS manager
calls them around the existing MCE sw lifecycle, while the MCE code no
longer includes BERT headers or calls BERT helpers directly.

This lets BERT process cached boot records earlier in the RAS manager
sw_init path and release its cached state independently during sw_fini.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c | 95 ++++++++++++-------
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h |  6 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c  |  7 --
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  5 +
 4 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
index 29111b10b00a3..04490f5173c41 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
@@ -31,15 +31,23 @@
 
 #include "amdgpu_ras_mgr.h"
 
-static DEFINE_MUTEX(boot_err_lock);
-static bool boot_err_polled, boot_err_written[MAX_GPU_INSTANCE];
-static int boot_err_poll_result;
-static u8 *boot_err_raw_data;
-static u32 boot_err_raw_data_len;
-
-int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev)
+struct amdgpu_ras_bert_boot_err_state {
+	struct mutex lock; /* protects cached boot error state */
+	bool polled;
+	bool written[MAX_GPU_INSTANCE];
+	int poll_result;
+	u8 *raw_data;
+	u32 raw_data_len;
+};
+
+static struct amdgpu_ras_bert_boot_err_state boot_err_state = {
+	.lock = __MUTEX_INITIALIZER(boot_err_state.lock),
+};
+
+static int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	struct amdgpu_ras_bert_boot_err_state *state = &boot_err_state;
 	struct acpi_bert_region *boot_error_region;
 	struct acpi_table_header *table;
 	struct acpi_table_bert *bert_tab;
@@ -51,11 +59,11 @@ int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev)
 	if (!ras_mgr || !ras_mgr->ras_core)
 		return -EPERM;
 
-	mutex_lock(&boot_err_lock);
+	mutex_lock(&state->lock);
 
-	if (!boot_err_polled) {
-		boot_err_polled = true;
-		boot_err_poll_result = 0;
+	if (!state->polled) {
+		state->polled = true;
+		state->poll_result = 0;
 		ret = 0;
 
 		if (acpi_disabled)
@@ -67,7 +75,7 @@ int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev)
 
 		if (ACPI_FAILURE(status)) {
 			RAS_DEV_ERR(adev, "get table failed, %s.\n", acpi_format_exception(status));
-			boot_err_poll_result = -EINVAL;
+			state->poll_result = -EINVAL;
 			goto out_unlock;
 		}
 		bert_tab = (struct acpi_table_bert *)table;
@@ -75,36 +83,36 @@ int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev)
 		if (bert_tab->header.length < sizeof(struct acpi_table_bert) ||
 		    bert_tab->region_length < sizeof(struct acpi_bert_region)) {
 			RAS_DEV_ERR(adev, "table invalid.\n");
-			boot_err_poll_result = -EINVAL;
+			state->poll_result = -EINVAL;
 			goto out_put_bert_tab;
 		}
 
 		region_len = bert_tab->region_length;
 		boot_error_region = acpi_os_map_memory(bert_tab->address, region_len);
 		if (boot_error_region) {
-			boot_err_raw_data = kmemdup(boot_error_region, region_len, GFP_KERNEL);
+			state->raw_data = kmemdup(boot_error_region, region_len, GFP_KERNEL);
 			acpi_os_unmap_memory(boot_error_region, region_len);
-			if (!boot_err_raw_data) {
+			if (!state->raw_data) {
 				RAS_DEV_ERR(adev, "failed to cache BERT raw data.\n");
-				boot_err_poll_result = -ENOMEM;
+				state->poll_result = -ENOMEM;
 			} else {
-				boot_err_raw_data_len = region_len;
+				state->raw_data_len = region_len;
 			}
 		} else {
 			RAS_DEV_ERR(adev, "failed to map BERT region.\n");
-			boot_err_poll_result = -ENOMEM;
+			state->poll_result = -ENOMEM;
 		}
 
 out_put_bert_tab:
 		acpi_put_table(table);
 	}
 
-	if (boot_err_poll_result) {
-		ret = boot_err_poll_result;
+	if (state->poll_result) {
+		ret = state->poll_result;
 		goto out_unlock;
 	}
 
-	if (!boot_err_raw_data || !boot_err_raw_data_len ||
+	if (!state->raw_data || !state->raw_data_len ||
 	    !(adev && (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu))) {
 		ret = 0;
 		goto out_unlock;
@@ -122,31 +130,50 @@ int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev)
 		goto out_unlock;
 	}
 
-	if (boot_err_written[socket_id]) {
+	if (state->written[socket_id]) {
 		ret = 0;
 		goto out_unlock;
 	}
 
 	ret = ras_bert_process_records(ras_mgr->ras_core,
-				       boot_err_raw_data, boot_err_raw_data_len);
+				       state->raw_data, state->raw_data_len);
 	if (!ret)
-		boot_err_written[socket_id] = true;
+		state->written[socket_id] = true;
 
 out_unlock:
-	mutex_unlock(&boot_err_lock);
+	mutex_unlock(&state->lock);
 
 	return ret;
 }
 
-void amdgpu_ras_bert_reset_boot_errors(void)
+static void amdgpu_ras_bert_reset_boot_errors(void)
 {
-	mutex_lock(&boot_err_lock);
-	memset(boot_err_written, 0, sizeof(boot_err_written));
-	kfree(boot_err_raw_data);
-	boot_err_raw_data = NULL;
-	boot_err_raw_data_len = 0;
-	boot_err_poll_result = 0;
-	boot_err_polled = false;
-	mutex_unlock(&boot_err_lock);
+	struct amdgpu_ras_bert_boot_err_state *state = &boot_err_state;
+
+	mutex_lock(&state->lock);
+	memset(state->written, 0, sizeof(state->written));
+	kfree(state->raw_data);
+	state->raw_data = NULL;
+	state->raw_data_len = 0;
+	state->poll_result = 0;
+	state->polled = false;
+	mutex_unlock(&state->lock);
 }
 #endif
+
+int amdgpu_ras_bert_sw_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
+	return amdgpu_ras_bert_process_boot_errors(adev);
+#else
+	return 0;
+#endif
+}
+
+int amdgpu_ras_bert_sw_fini(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
+	amdgpu_ras_bert_reset_boot_errors();
+#endif
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h
index 27e2378ea5f3a..e56aa143ad952 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h
@@ -24,9 +24,7 @@
 #ifndef __AMDGPU_RAS_BERT_H__
 #define __AMDGPU_RAS_BERT_H__
 
-#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
-int amdgpu_ras_bert_process_boot_errors(struct amdgpu_device *adev);
-void amdgpu_ras_bert_reset_boot_errors(void);
-#endif
+int amdgpu_ras_bert_sw_init(struct amdgpu_device *adev);
+int amdgpu_ras_bert_sw_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
index 97ef50149fdf9..bc7a44618ac6c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
@@ -23,7 +23,6 @@
  */
 
 #include "amdgpu.h"
-#include "amdgpu_ras_bert.h"
 #include "amdgpu_ras_mgr.h"
 #include "amdgpu_ras_mce.h"
 #include <asm/mce.h>
@@ -123,9 +122,6 @@ static int amdgpu_ras_unregister_mce_notifier(struct amdgpu_device *adev)
 	if (atomic_read(&mce_mgr->ref_count) <= 0) {
 		atomic_set(&mce_mgr->dev_count, 0);
 		mce_unregister_decode_chain(&mce_mgr->nb);
-#ifdef CONFIG_ACPI_APEI
-		amdgpu_ras_bert_reset_boot_errors();
-#endif
 	}
 
 	return 0;
@@ -243,9 +239,6 @@ static int amdgpu_ras_mce_notifier(struct amdgpu_device *adev,
 
 int amdgpu_ras_mce_hw_init(struct amdgpu_device *adev)
 {
-#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_ACPI_APEI)
-	amdgpu_ras_bert_process_boot_errors(adev);
-#endif
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index bda1f76d2dbf9..64622b593ab94 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -33,6 +33,7 @@
 #include "amdgpu_ras_mp1_v13_0.h"
 #include "amdgpu_ras_mp1.h"
 #include "amdgpu_ras_nbio_v7_9.h"
+#include "amdgpu_ras_bert.h"
 #include "amdgpu_ras_mce.h"
 
 #define MAX_AID_NUM_PER_SOCKET_GFX9     4
@@ -356,6 +357,7 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev, struct ras_module_param *
 		goto err2;
 	}
 	amdgpu_ras_mgr_init_event_mgr(ras_mgr->ras_core);
+	amdgpu_ras_bert_sw_init(adev);
 	amdgpu_ras_mce_sw_init(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -370,6 +372,8 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev, struct ras_module_param *
 	return 0;
 
 err3:
+	amdgpu_ras_mce_sw_fini(adev);
+	amdgpu_ras_bert_sw_fini(adev);
 	if (ras_mgr->ras_core)
 		ras_core_sw_fini(ras_mgr->ras_core);
 err2:
@@ -398,6 +402,7 @@ int amdgpu_ras_mgr_sw_fini(struct amdgpu_device *adev)
 		amdgpu_virt_ras_sw_fini(adev);
 
 	amdgpu_ras_mce_sw_fini(adev);
+	amdgpu_ras_bert_sw_fini(adev);
 	amdgpu_ras_process_fini(adev);
 	ras_core_sw_fini(ras_mgr->ras_core);
 	ras_core_destroy(ras_mgr->ras_core);
-- 
2.55.0

