Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FD8C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 04:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2276F10E446;
	Fri, 28 Aug 2026 04:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HYc6KAa9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47D610E446
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjfSF4QRh6wa7/L0uxDiX6sHfOXjCEuDQTRVCiOaNmLnOjF7SXCejzhjRtDFKLpuOnBXayHSzbziiXSzKFh3ojuZPzoWpD8evO7B34ckyCRIzWX2VcMMrH2v1yZ/3xrel2w33+6pUN975XV0Mt165pYjpxnLmeGimuDa4bi5rQqUr/aErN9jtOdTN9rCXWVIaYOo3XxN3IHKup15uaytNICdpwFS6g+hkHIRrK1eiJcx7ChbJOfnRxKen/4IxUxDVkaH2xM1CX8pmr0uJJnilI2REIAW/jCEdSRNoMJFbcQ6pxkQ/kkKCHhe/7DRTfs2kYTnjkQUe481cPRONZayLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ0oTGXcAjdk4OL3zH9oLM3QlJxaQ73qKA1e2wSu2io=;
 b=W77txnDc5w34XQCR5FTHCLdsKs0NzTWu1cT+jjjsX9WRjXFHZbjINhqW2FRQJo41id6mwVg95gzLj4TKyklpeKxcLcVSzovaHSIUOHOQT3BlS2Qqbz+1UdecZlLj2C7oizAjhornZStSD15+CILWWilrOHkjKXp4ByF/FpsZvVPahQ5bHRXLai+b+mPIaw89HIuR5e6jbhkh8ZcpXWpfcwz/WsGFn0y3wSwMO4+/88STgP7I8IYhvVCr0eSMLAOrA1zg0Z61kS2OOXaZKJAEJH6lEr4KLKtZp51Hk15wGsdeJoAi7J0GhrxF+BluUYBFy269iw81DkeDF8v+LA7SwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ0oTGXcAjdk4OL3zH9oLM3QlJxaQ73qKA1e2wSu2io=;
 b=HYc6KAa9IuABq+1NulqJ62m2OyxrcZeNoTsC1LPnLtIgnH4CD0iojQw0JS7BlozcmZrPq7tOogBg8tHnj5lQVnjMUb/y5KzSOt1BS0XL2alQBHBrH/DhUgUsunGwdsRG762QImRiGN4rBbcQ7sM1srk1/Oxz6szP0luODvBMSA8=
Received: from IA1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::14)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:15:45 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::8a) by IA1P220CA0008.outlook.office365.com
 (2603:10b6:208:461::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 28 Aug 2026 04:15:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:44 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 23:15:43 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 01/10] drm/amdgpu/mes_userqueue: refactor mqd_update into
 per-IP helpers
Date: Fri, 28 Aug 2026 12:15:07 +0800
Message-ID: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2f79ea-9775-42f2-d965-08df04bb0818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: PRQSN+ona4FjMWqRVgvfl5vk3mUpkIjeVQmV6q+jXzlM2+LTUA3C43K5EMI7VMTs4geUn11avj9FQK3LMnQtctn1bHyTvfKb7oZtYYUqJdLL/kQPFgMU1ceA2mZMdXQedm3aAktViSWCwRjXEu1bUIYqWWGjxCEvLxC1lm5C6CEgMH78+3FHX84Bid++d6qamtbP+ga3ls9Q47OUB4SF08VYQ/BZAHK2eAhfDT9QwKj716QR93hkY4Zr2twYW0ckj9iSipdPb7P0Vib3nw01gLlYJq1HX+zS73JkdePUHRGb3O2wdZ7Edl0Rn8LCrGs8BR4taq0X9xWPus4U/w8O4kzRqOa0V/rqCFrGPAXBrVC38uxcEiArPmfJJZuQCVRx7f+2akh36euJWSUQQHZel+BB9wdB7Yn+oMwFV8IDjZ50FynRIjBkeGINXeQQToZZyn8KLrTEGkdkT9L+6Q3iA7pfB1OJSeJ9C6ojlKGSqmmh+RcanPhzBH5b5T5PoVL/5yp9dXKuYwkRq5sNGjnj0t66qXVd95zvr1iFdJjqvhMXQQ/zP+eZqZwFhcKHwDAZP61icxvMEIoT+YY3FULsCP7PxomW8ku6W25GzXnQcxMeBCJIGqjBZT3kKHwd2OOLiSQE5aVpQMcfDKVXutg0/GqbSa0tGcV1BPL+YMe3VZbfYhWT8dJp/32n7sgTjsZbixT8WtnV+ZIHgzZH1Aawpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qb3E7/bmEV2oT3O43+kyGVxbvy1cRk6Xt2H7hitdK7hssWQWDkZGB5wxim6S00GwIBM+vCAHhL8texl2xvvZjJcGcEVDSy6SAL03mVdVQhWoHuJheIuL+FRuGcprHg8MizSndUsnXEgukp2jyNn+mjoii/n/6EEaqtAnB/EgBep0qom3BaWNrq2khQ4pJjgUdteUaST5XphPrI7DRsdcAW/XInycaApXDrEInctaKpY5hWdVkC5Jmu2qlqvMh/fdNCVVcTVSTs6yzs6EaRm7gLgG2wybfWWND2PoXIVBb8UteZq19Sjgy4piUmMEoy1HVsGWE0bwZkztunFY/ceJ2KU2q6RogBH4qUQhqx+D4dvZQTrKdovsPb2ma0bdiEtJZLpCPyq4vKJZlXVmIFnpgU4Zc0LoIQK2ux0wBmgstjoYPv6l3bHe/xLWFhRhoGsv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:15:45.0689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2f79ea-9775-42f2-d965-08df04bb0818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582
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

Split the inlined compute path out of mes_userq_mqd_update() into
mes_userq_compute_mqd_update() and turn the former into a dispatcher that
switches on queue_type, giving other IPs an obvious place to hook in.

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

