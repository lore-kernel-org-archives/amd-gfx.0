Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF43FCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567C1112DC8;
	Mon,  1 Jun 2026 05:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X3g3vDGQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E2B112DC8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOAijUL09UiomtyuxPHabwK1iWHB5/PJBSVCgKjbevI0m48WkwQZGndDv/8xk6xApqlfryoycQb0h3vUVfSkvvgOeCTvY2U/p3pXFrcsJUT5A5c9E71RxUeGJCHAm/TDSKpcOnNHz5odL5IL4vl71yMOBURG9c7o0fDLlSYIZD/cxqe8G75R/XiEAMQDHiagn0BPsrjGqRIwpmZIHg5XVe+wrw2uX/EF9PX9odruiL2pZpUgQ6jD4VPIEad7eZ1UjKK/kG7ix89M2KxXoF2VJhVD+cy9smfN2ouKbPuf4T/DQkp9eE+bLHlNmhrbkAFnuM0bIROnoLdOY1Ai7rXIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJt1zN+MtSXsx4AxdkD2m6iRAWt7uLXrG4S190rOdvw=;
 b=exZTpdfR4hMAZmYnd5lpQhUAuYIdIJUtJb0khrauPwoy5l03JQHGeAiJJoE+hASyEV9dIbkgPyKtwWZUeWnB8bl9WrezW1QNZ0lMHi8rNOAAsHmXwE4Q9uMkS+FvYyYeo4waagNXuVJMB9e5EilB+4zDtt0zUfwBcB0HtjPdqNXJxRC5vstGRxxWbHLqH/b26u3dfMl1q9IfcAtKB4EOsnxKJUjVDxb23TxRzAADHabR+q6AJWvJo4S/vu0srx0XZhWWPbNY2Yd64nLGUVntas5xFqryyD7HC33HBl8lNQ4nz0OrNLo2KdZ9w0vTDChEwmnTqWDM50f5nrBMxXB9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJt1zN+MtSXsx4AxdkD2m6iRAWt7uLXrG4S190rOdvw=;
 b=X3g3vDGQezIKwTwpjv6Veqdr68tPBEsoKbmRCHbAsNdlcF50IbVg3ZODL4qh982ibvQB2MUaQm9+oEPuMCBJ50oQVKIH8AwIKQ3M9wdj7ox0r/Z9W9+CJ60qF4oEBdsvH6DUYlRZnX+ZTmE771zX8bTC/wtTc0pPqYZXhE7ZmmA=
Received: from BL1PR13CA0089.namprd13.prod.outlook.com (2603:10b6:208:2b8::34)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:52:52 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::a1) by BL1PR13CA0089.outlook.office365.com
 (2603:10b6:208:2b8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Mon, 1
 Jun 2026 05:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:52:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:52:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:52:45 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 17/42] drm/amdgpu/mes: add userq reset helper
Date: Mon, 1 Jun 2026 13:49:03 +0800
Message-ID: <20260601055034.3700921-17-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c7bf31-f947-4427-d797-08debfa204f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PRlBenrq6e9BV6jnkDs8n6FN/HwOL7bc9iQmbQSs7Xy1THtEfE2euQr1vfJbSFKnZE1KIiVK9LCbatGqLiyKQHvPQ9gerx7LZdk10oBlxqvOxwexCDWAsIEtOO2Sb5Vx6xwSj6QeeBB9cB0sRDAsVaOM/1c0E/2TcKEf0G3CTGT/axTvs5jsVrTpZ3UQyzUAKgvFJnZqqCQDdcdaZjkpDCljkUBZVfnoNy6vQd0XYluPV5d0baEhhoOwR8B3sYZjed5jFdGYj9au0edtGvAq0VHdNJYZyYKhWaydaSvyYGZHlwMpG4EZlljejnu6ccoz4MAnMaWVxMDvOdFQBOd2MP9WJNi11qWHyP/rKRHRMQ/6TxIMDW0Uk80OnAsCI9tBmvm5iNUWR9sbvUK6aJZmuP9FnAe66k2S4GL2wbmIDBq3a3eEBiyVRh1N5BUlRgJbATlAeHaHlCrU5nJVGQwmbY59am1YCU5+ZFVfz0YWJ5Y/XqM0NNH/fJNNkC8LZ6J6XKq+4FXXD1tfT1+I72ADzPTAixN0lraqSwRY0nOGy74yBJvOekwd/2e1HFx2fqc2X07mlpGI2tWWUf0gvCwjqNR5H6LydhCo4uIJlvYdFWqSURR3ngzXYc1GLizt02sCNglYvZ5+V+/5rxpsDtJJG0Qa+b5Bw+cUwaJ5Tq7/TEZBvs5n0pt+qXssA2gAjOyjxz/je4SM5HvVsTuSlJ/XkjUMaqD0jbpYQ6wt+xA61ak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FgaXoWyajwpVZj7qc/SzWCexG9xrFyG2EemeivWwMNzgfLbaQNkZ9ZrvKoy99ZTEBSoNP3gcDWxMwmrgRnvRCs7Uv3hEEravX9kyKtUjmzVWY7ukcQPDaHkNKFTGuQrrfPTLMfnO27wUgvKs4lRP5qw/bvXkzuS82YgiT13fI10mUwSy8GeSbXzC56IXE+79AXby7iE0UU2cuD89qVckvJEDdt5OjSEzEpLvT/guwyBfnzXEJ7fWOFmhu7iI7arQABZyo0OyaAz+R5mV0z4IKEyJUA4kdcq9WWdy1Xvc2PswCwUUHdzOLdAovaTXRgPz7mM6rCFJvGJ0d57pAWn4Xu+7h8zoDbqAMxrpWoLuRQ1DA5cAzjq5kPcB3Kg36wgBkrbqBa71I6C54I5gEcD+oxYTvMqniH+hLxIPOtjRGt5DzYteiCeKLT+qulHVgUHw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:52:52.1535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c7bf31-f947-4427-d797-08debfa204f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

From: Alex Deucher <alexander.deucher@amd.com>

Implement a userq reset helper using the doorbell
index.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index c9467b26e42c..00682bcf4019 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -439,6 +439,29 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_reset_user_queue(struct amdgpu_device *adev,
+				int queue_type,
+				unsigned int doorbell_index,
+				unsigned int xcc_id)
+{
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0, sizeof(queue_input));
+
+	queue_input.xcc_id = xcc_id;
+	queue_input.queue_type = queue_type;
+	queue_input.doorbell_offset = doorbell_index;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "failed to reset user queue\n");
+
+	return r;
+}
+
 int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev)
 {
 	return adev->mes.hung_queue_db_array_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 93990d4990f2..e0d4abfeb27b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -458,6 +458,10 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  unsigned int vmid,
 				  bool use_mmio,
 				  uint32_t xcc_id);
+int amdgpu_mes_reset_user_queue(struct amdgpu_device *adev,
+				int queue_type,
+				unsigned int doorbell_index,
+				unsigned int xcc_id);
 
 int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev);
 int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
-- 
2.49.0

