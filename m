Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCA7C3601E
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Apr 2025 18:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AF810E23D;
	Sun, 13 Apr 2025 18:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ojkUFeLj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D38D410E23D
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 18:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOsLseyZ6SHAwCp/BTg9PfqlzFIwnwUtphS9ARMXAaep27DGsBk1szldMjcoD2kb6QGlXShXWkskP0ZgdMWEEKJbovxATiBDBKDu0+/f9FL/27BEdPNvvWqTeQYL7qwovklXtZxUXjsyIysRly/gUsz7kCZJSbwFAedlhmQl6TwsKLhDqpE1+TvzsXqpV5ROuQHgAUPlBMLKeyGLMHASle2+SCJ5/u+sjnaoqqV/V7YaiiaHBeEbtGbLH6DpJdD7IzaRh9jNSwrT7JKXvOcDk+ARSY1RkRr5LOpJnSTsPjBz73xlXzVdlPKBL7y9R+mCtm894B+yFgYjvQY7BDyaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4XF0+451oKaGnANG7DbFUzQwWFcKWKac0FKmWCWV4c=;
 b=M5tFp266Alo681yfzbV2VynB+VL2oX11z2gZf7kpmyWCO3AnAW/mbxip0soF8w8kiUmdRwvPUb6Ff8EiJdBHavC5aZmEN6kg88DlY5G+w1c9hFQBPfXLuUcqQHmF9CJVk/ShLWqUkEe3elA0zrlhUkDDyi/fP1foRJiE7vzg3Xbv2EElngp7y1Xj6u0hq77S3I/C6H8+1h0xjzGle7cOlWFmomSUGRGdudsDg2KMJ1CV9wrgTN66zF7NidOfbskrzmIzwnhPGDA7juxdlAq3o4L/UOMN2jD+4ry3Bnunsav2mTYjP63L66eVgGTzdo/Xboq9U9Fcq+Xs/2lNwSYupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4XF0+451oKaGnANG7DbFUzQwWFcKWKac0FKmWCWV4c=;
 b=ojkUFeLjO0SG6igSNP1Ro6hoDlzuBZFml4kt5iuoeNkRlp5hQw/DTQVReiwDuRSxHoVTBMK3YHSNCeMZMtTDbAHcGViiDcSQ3fiwnMB4L0MxZPT2ndO9iUDFiMjbMKd77OSLWTamGM67mc+oLsDkaW+MSysMW83N/8agQOl4L2Q=
Received: from CY5PR20CA0019.namprd20.prod.outlook.com (2603:10b6:930:3::12)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Sun, 13 Apr
 2025 18:24:30 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::e) by CY5PR20CA0019.outlook.office365.com
 (2603:10b6:930:3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Sun,
 13 Apr 2025 18:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Sun, 13 Apr 2025 18:24:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 13:24:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/userq: move runpm handling into core userq code
Date: Sun, 13 Apr 2025 14:24:15 -0400
Message-ID: <20250413182415.2712146-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 640630cf-7898-4121-2b10-08dd7ab86e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IIftnb8ih0c8y+OgvtdIB2Xjc1K509FrftAdVm52PFqfb+zFYmsGvjZKadKU?=
 =?us-ascii?Q?Dcc6Z+py40DdRWCOcGBAqa0uyXm9iVfO7nEsqTwjsTSrYpkJ3dKDYKI9NWhD?=
 =?us-ascii?Q?rn3dJJKPa+xBUgMlrQtsoRcxDudew4zv4xyIHYfX/F57O6Ac55M5CHqqPoem?=
 =?us-ascii?Q?cQijSHXXsuwc2yQiJqEhqJc0GzTanuPo8Ohr43hf4SUmdvn5PNNDvqaF3q0B?=
 =?us-ascii?Q?GTHCdZoclhj4/5AMXCpgAQpNThxfK4EeQRHSVxkCGjLn69WPMX4i29oS8xw2?=
 =?us-ascii?Q?fdfMameTI24Cw3ct9srN8Xord7pVGmkNoCdNkOjLC55BV4gfwoGUxVlpDepa?=
 =?us-ascii?Q?havNRq6fqk4ey1cXQI1RhlrkpCYlfuQXtZM+mVWPYfRiOo37R4F3yT2ij87v?=
 =?us-ascii?Q?0/IWva5UoVzST2Xbp2GgwAp3JVOT675E/FZ3/7PTr80p3I+HoBSalzayBnxl?=
 =?us-ascii?Q?D1jMvXDe1oj4orzpiMNoO1HVA7spViuclGil+YoLX52yiocbaODNaYl26kT3?=
 =?us-ascii?Q?WxzEXq5FiP5KbydS1VPbOmafm0bsv1EYlSqHEbXuyo+JEM7+R5F0+jHEFolI?=
 =?us-ascii?Q?fyZP5W6lSnSCx0V5MwB0juGejfTtJFj6oz0VjA7U9CtRzLq0pnYRKBL3nTSl?=
 =?us-ascii?Q?kH9x2ZtTuz3+jfrCs0sfIKdvOpDjQtd5vNq18CRtG+/D5RBuWMiL08CUlcTX?=
 =?us-ascii?Q?NfjEHcsPVv/cwCQ9eNA/MHZpm5WKejc+ItNTvREqq1gk/1RqHRxN6PwYaphs?=
 =?us-ascii?Q?wcJZcKni1WXtvxjacz3kCRoBjjUBzC/SBuJR6H0/w4uMqToeHQSJhDSTJPPT?=
 =?us-ascii?Q?qd/4uBhAqjoFbvT0FMa7LtJTIAcuomAGD/XCW5Afirw68cLm3qmC/qr9CdZU?=
 =?us-ascii?Q?EnbnzztfAvBoKp3gnQqoJye3PO+uTZkVctXTaF/q2t2dOLZPrvYBRzYyWk7w?=
 =?us-ascii?Q?67+1VTF5SjMpG7poFHTKnHW9MCv+XiNwKZjpHYrBZMtBfTKKonAgCJYlQmcO?=
 =?us-ascii?Q?ydZFKflm1ZAfZKX0jMRwx/vEWZUUyre4FWUhrZuq5Y5a3iiMGRozDkG25LDZ?=
 =?us-ascii?Q?4LQWAqKfN98SvEyDnTF9kTxu7d2oJ3xRVyVMorXLCzVaw5AdsN7tsQukjO5q?=
 =?us-ascii?Q?2e4MS/kdy4glt4RidqmXC76ALiM0hGMd4E4HJc9C3Dpf/SRp0zssLBGEzT/s?=
 =?us-ascii?Q?0S5udnOfC/vok0MqKe2PjIpy6aACV8kBQI9PUedN9MHcLi7yPxlgewTsb3Mm?=
 =?us-ascii?Q?Qx18nsnGeJyTICUed5MTfpQ6rqpja9KMaCAMxWF7CuiKWB/Sx8luAo92cBzd?=
 =?us-ascii?Q?YzqhXjkW/SlthnsvOIhIUCrQ6OxdG9kq58oi5U3FODj+Hq73/0UZm0+qdsNW?=
 =?us-ascii?Q?Ysu7W1QKMtj8+0szMkU741muEh/u0gaijK2j5eRiUOLa3vjSVnn5UXv8FMM/?=
 =?us-ascii?Q?rb8ceJC4GodsIRGHIwmu1JtvceewybFLT8kjN8xwRqoHTwP3dk/C8P0p0hRW?=
 =?us-ascii?Q?7q2dJVqF1w7jIWHevxhnm39a9xQbbOCB7fFh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2025 18:24:29.5769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640630cf-7898-4121-2b10-08dd7ab86e28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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

Pull it out of the MES code and into the generic code.
It's not MES specific and needs to be applied to all user
queues regardless of the backend.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 15 ---------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 98e1ed794c346..08a94822eb17c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -24,6 +24,8 @@
 
 #include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
+#include <linux/pm_runtime.h>
+
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
@@ -258,6 +260,10 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
 	return r;
 }
 
@@ -311,6 +317,13 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		return -EINVAL;
 	}
 
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		dev_err(adev->dev, "pm_runtime_get_sync() failed for userqueue mqd create\n");
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
 	/*
 	 * There could be a situation that we are creating a new queue while
 	 * the other queues under this UQ_mgr are suspended. So if there is any
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e175f05bba6a9..b3157df8ae107 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -25,7 +25,6 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
-#include <linux/pm_runtime.h>
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -313,12 +312,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 	queue->userq_prop = userq_props;
 
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		dev_err(adev->dev, "pm_runtime_get_sync() failed for userqueue mqd create\n");
-		goto deference_pm;
-	}
-
 	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
 	if (r) {
 		DRM_ERROR("Failed to initialize MQD for userqueue\n");
@@ -346,9 +339,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 free_mqd:
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-deference_pm:
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 free_props:
 	kfree(userq_props);
@@ -360,14 +350,9 @@ static void
 mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_device *adev = uq_mgr->adev;
-
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 }
 
 const struct amdgpu_userq_funcs userq_mes_funcs = {
-- 
2.49.0

