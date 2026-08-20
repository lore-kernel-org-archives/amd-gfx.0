Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E84C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 05:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B3F010E5D0;
	Thu, 20 Aug 2026 05:06:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mGRQiZWH";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011025.outbound.protection.outlook.com
 [40.93.194.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6497E10E5D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 05:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=od90E60BEaIwbdXDGCoiNeVnNxxRJrVX5sC/vkOF+z8tj2tjxEefnoT0RnGVoU8rzWqLtX/BIQcStZGZXHzImuXheQW33JYQrM4siMGtXD++oGjUlqIHoLs9wQR+He3PDRF+8ub7dr0kcx7gJ7GuJmhzacQ30OkOM5s3Un7WzcJsUxHYnkvlDxE9TbSGHC5o+wmuArhwQutcWVC56zmI0M1QPyvJO/tErQLm8VZWf2mEyuBezOvzR4oI1AiDmlgGcbSsdfQ99X3GV4Rys/O1bY1/u9di5euOrIwazcmYVvisM4jsKu+lNPh0LD6zkv/PEmD6Y6YLWCK8dvZXGGZLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFPQlDBz2WNSKcYAFF3COf0LVN0RHShkALVQ18mLbJo=;
 b=Mghx7fwevL8sScshvnlccAGSsRp/WCU3lvW6esP9i659HTgFPv7NfaOF7fIUrBhSHRy7gl3jM7LZ9b64GsA2luW2hwzuktFOfIYQZ/LWmiBrS1qgP7pXasIdxyd4ghih9Uxf2IYDsMqTi4PafnkTKikNR+Dey0JeZHwyeo6sF/Eot0uo1haWH8JevNe/xvEMRL0IgH3aUEg70+SLHWBF3fvagtfqdmndWAwX+5pRL73HDbUBghq+9bPv77JvUZOnViatG3b9vRQwH0X6szHgU0igmyMSSDSmtzLEExsf9YyLmCmg4rhhJYkBj1B5QPSjxPc2OAu6U24IGwfbKk1gKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFPQlDBz2WNSKcYAFF3COf0LVN0RHShkALVQ18mLbJo=;
 b=mGRQiZWHaHsTJPcuznAJ7wpTcYhYuZoNqJF4fYq5d6nbOI/J1NoOuWYoi9FutqUJ4AnO9aiPb4Qg2yUlqGSU7XLWTpeMxpiULYPo5mZ3lSIIKaWkK3xojNfAOPN+ZwjSdokiU/3o4CmW4oVNtoxb802/1R7gOUvPJLg9WqvvdAE=
Received: from SJ0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:a03:333::12)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 05:06:02 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::40) by SJ0PR03CA0097.outlook.office365.com
 (2603:10b6:a03:333::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 05:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 05:06:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 00:06:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 00:06:00 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu/mes_userqueue: refactor mqd_update into
 per-IP helpers
Date: Thu, 20 Aug 2026 13:05:35 +0800
Message-ID: <20260820050600.1249902-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0b3511-07d4-4000-9f60-08defe78bb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: rLOs8Fn3IpoQd/fnYT7pjTo9VTQClhU/hOC5dAlu0E3umOX40A91pgJMt7YRPs76f8J5l893kNR0NPNhVwPgpu/eIVaOhs43xzJfIqpKQjj0j4Z+f9DbOEnn9js2UG5i58Y8+QkedvL14R5UKsmet7L+xFAYRhlAorVz+nKK6yHr767x2gkqbo3mrMeLB8sVfTANfqlgZPCURwMVYEIatymgjYuV7GttM8eswDTt0CgLT623hIRvUzQO/WYbF4FvySMes42D15DxatLvj5u6im3sUzCUc2rn+SBxBnNzbzTh+VazqlaceRh02m1bDPpMY6BzAktfGHV6JP1A62bfh8u6PEhZzaXzGgnssNX+ciksnBUnOHcctObdN3Bxz6Y8xoVAWSDo80mrhdJfOZ1GcW7gxw/smDll1+IpSl3v8TG1AJG9IK0kzaHucb4tNgFyMlyDYzTr+2xILqdQ5gdF41X8CzPy3+rreUi6It38N3EX7dvAgGwj2yER9awyvd6hU66LkNQoB6Ittky+ls2Q61iIYPMl11OBpa7LDRFxemGp80KD9t3K+w9Z8UszUh5yOXa/rNDEIf/nZn6P0ASPnvaQn39AGlKVyWtfN35TJlyBuCnz0PtuEmhiPYfHAJ26di/aDxjWk9Z1Xi3SpGlL82jY30GCSQjFnIZhVvE6mjbYc0oTDp9DCZvj1pVRxUUraJrJFX/A+jxtYtRCoAsK0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NLNJgK9F8PiFhmCcmQnnloXBTwXEpCmXV8fTBLY32cKBBCiHkc7ta8mcg8H/BJyonfgTuDZkfs06Pk79uA7gMzw86NPSAvXRRJM3QvqgmzBMcDL3MCDHCSrtfUvA8Cm9aH6V4YWjw8ZWbmyaJqLHOa0xrUDxvCdDigGeTxWgKJu8BUDuVzVkMqg15Zr5r3RzRyTWXnvGmhzoPl/29UuCCAxqU85M9BoWZjXKG3/Doio1lsRY9J1bzbo/UZAKSo6CHcrR0E9ilcE7R0nwpK60nM50hOB1TkWkdoWYPDcaQeykvD9DfIJMqEfjtfNJL+289942FJq/JHPsA59ysR5SJpXmuipPMgtJAxCeoNdoJBaipz1ZRClkAqLvb9CHg9ASfWtP57yjSuwZSwhXJu71V1s1wy2cjm58S0ZiAq3fGi2G2YeeTxT7wbJ/p7FPgA+v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 05:06:02.4045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0b3511-07d4-4000-9f60-08defe78bb4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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

mes_userq_mqd_update() inlined the compute path and rejected every other
queue type with -EINVAL. Extract the compute path into
mes_userq_compute_mqd_update() and turn mes_userq_mqd_update() into a
plain dispatcher that switches on queue_type, giving new IP types an
obvious place to hook in.

No functional change.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index ad72ced472dd..82bb4369451e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -681,7 +681,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
-static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_amdgpu_userq_in *args_in)
+static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
+					struct drm_amdgpu_userq_in *args_in)
 {
 	int retval = 0;
 	struct amdgpu_device *adev = queue->userq_mgr->adev;
@@ -689,12 +690,6 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
 	struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd_v11;
 
-	if (!queue || !userq_props)
-		return -EINVAL;
-
-	if (queue->queue_type != AMDGPU_HW_IP_COMPUTE)
-		return -EINVAL;
-
 	if (args_in->mqd_size != sizeof(*compute_mqd_v11)) {
 		DRM_ERROR("Invalid compute IP MQD size\n");
 		return -EINVAL;
@@ -720,6 +715,19 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_
 	return retval;
 }
 
+static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_amdgpu_userq_in *args_in)
+{
+	if (!queue || !queue->userq_prop)
+		return -EINVAL;
+
+	switch (queue->queue_type) {
+	case AMDGPU_HW_IP_COMPUTE:
+		return mes_userq_compute_mqd_update(queue, args_in);
+	default:
+		return -EINVAL;
+	}
+}
+
 static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 {
 
-- 
2.49.0

