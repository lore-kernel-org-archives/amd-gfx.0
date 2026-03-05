Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A54EEEF306
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 05:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 236E710EB17;
	Thu,  5 Mar 2026 05:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nhZuyDc0";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDE610EB17
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 05:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDDxvoezvluOl7XeIZS/+xrgFkdDgjcrEp9iNXVZcKm80CgtBHDNEzpOaJswa3S3+FBx+RmirGSqIhNBvzAazjHja/5O7UK8In0BKW32dXLrh5p6LuvRgpzCmmRiC8Y/Qx82w6OWG66JYW/oFU6dK5wybg0gFbhI9oi2C5DSVKQxaaaR9TA7ij7/K5zrY4YK+W3KvkKwT7yzs5XiIzwrgCe0bRXYjnNqHC81Kh5e4pOKhwiiQqzIEQ7K+Tf2C+e7BhrSby7SUGVtJ/ZD5b+PMuXZTw/9ngdyA1fxRrQ0XO0VavK6TLmo+H8gEY+jze1P47kejUt1GVWHHN1uErgGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03ylj6B5thJn3FQs0MJGn2SD4kjqLKlnciJ0Y5VAJLQ=;
 b=P9yPeVYVNhNopvhLUjCB2vq92LV8TpERy4nekN6fwiurpjugbMeTnG0MpO/WEsdSQBbS5uTg9GCa9z0XHHjgihWd15Zv+s6aX/E10Lrh2P6zOHlsx2krXKXdK2KpqDHjho7z+m836QCWEwKEAneei1QmyWT8/YlEjp9SQEtz3OhSo9ShQno4wFLNdyVuKa1WkJv+AAr/3lTD0qNDQEFPq5DHFs6yFXNm0SCWqLn9NQtBJwqZvffCcRkSGyS8qjjnA8rCehVPVbU8m2Am2c1WafJAkj7r5P0KYU+yelyRqVio/Itu+Fs//ZaHdxSq/mPxRvhkPlofeukxKOX0MxrCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03ylj6B5thJn3FQs0MJGn2SD4kjqLKlnciJ0Y5VAJLQ=;
 b=nhZuyDc0UaQgCfBSCs2h9hhGpR9v6SyEcv41OStFla1xAsZ1oX0kBSJibpFB4wQTozT6YitRHW+H9jSM3ThWV5NykmRTeRcLoSNxjv1+zNq1s2xrRU9xXMiRNd42eERd5CDhL+FaI07ux4InJkgDWutTGwIMNEiGD0lAOD3eKXI=
Received: from MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.17; Thu, 5 Mar 2026 05:48:47 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::9b) by MN2PR01CA0060.outlook.office365.com
 (2603:10b6:208:23f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Thu,
 5 Mar 2026 05:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 05:48:47 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 23:48:45 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu: fix gpu idle power consumtion issue for gfx v12
Date: Thu, 5 Mar 2026 00:48:35 -0500
Message-ID: <20260305054835.962639-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 61eb66c3-d3f8-4f78-b36d-08de7a7ade92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: s8zN8olNGDiCNVXqX2E43yM30aNe0/Tt3uqHdzkMLnmjV1lZFMrVwEpRycZPLz9FZZNkyIrqDK+bbYK6HLPHkxi4WzoBnybsvuamlcos5hNsOYnX1GqOelRj9oDTKkLMbcHdc/Nmg37kzc0OSCN0DPWJn6RtIhJprfMH0Yg9JztLZJzU2EcLiYlK8IEgaGysItKy6SjmIg4S7ToSjwcGM59DwJ+KbNUFLtpok5Xzjc1tuyHmwOmSuCyoxoAGOYIaBMN7RoOmK+NOKqd9QJvwOAHzsG4jYLe6Y6lnqHj7Si2HUGLf10j7q+AlVmq6O3jJyEkf1/xAEpubfQS22nIfpKShy9j4Kgi/dKqplZYJkCxQoFXhbOJfARMGn9QzIQ1VgM+l4k4Gnn1aKvqr6PQIhNEENCeAaVDCUCmYHqQJop4WsmBRe5TYs7NLgMmCoCNvzPKEgK7BSj0ms2neIzFIcaANp9kifFAtB3qIcipAsMoZl8Pnx7MnUsImBEmHIJerCS51jCSjylBBihFuUelk/Ee73roBnBLmjFot4oRbJhJ9DYePC5ef2G+KH7uMyFk5orRrjy7qmOgDnfbocbir6Yu6vk0OsP6OomG/nqrBUQ2hbHGpbESDUEWnSHBYIBZeMFCoSTGeuVsBOxEydXBS9AjJ44IqJCK4N3nroYCLFY55UBS6oPYHDAex0b/trNkHbVgZjyDpeZl2L+HR5EKewJZCJQ6wyYUiTrR+g/rqfbGt1TvAcVTZf6Y5G8VNPI9NPhBrEYX6X5umYPTHZ40DPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: //Fq2MlBQElJLgj6d21LTfg4Q9/cLlbjPco8G0OpYeUwh8oZOe1/lOMQ2AnPmhA5DXeIWuEP4CGWy1kUXN2sfTex6WP6X3XKkFxSJ7jFk2bOx2Nnx0LL5pLWyK2gFCSQi8voMX54wBw1JTnKY4DL+1cpMAm4xBYc5ljCtItgYx0nbwqSlkJTUHe4gJeH1LfpUw3cjUMudf4Xjr6vwVHr0GXrQSialeNxgQGL+PASIM5HXwbW1oEhnkueHqlzJ9VmXevSYbrBYpGP1moFYhIycAKiDHvmi62t7LaHLvcOaCfzwaiHfuFSNeHUFuL6iZGQzbjdNn+y3p7lDEeMKzPNW+CQ1no2UXC4v0DXxqGSeLEj1nPYBJCfXyE2fhLEZ6sqPIklmo9vrzRS2oTli8Y9cKM8hNR7GIK8sWEmgy6lJ/0X7bwEzbnOXGyWlhSH5pCj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 05:48:47.1516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61eb66c3-d3f8-4f78-b36d-08de7a7ade92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

Older versions of the MES firmware may cause abnormal GPU power consumption.
When performing inference tasks on the GPU (e.g., with Ollama using ROCm),
the GPU may show abnormal power consumption in idle state and incorrect GPU load information.
This issue has been fixed in firmware version 0x8b and newer.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 5bfa5d1d0b36..023c7345ea54 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -731,6 +731,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	int i;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
+	uint32_t mes_rev = (pipe == AMDGPU_MES_SCHED_PIPE) ?
+		(mes->sched_version & AMDGPU_MES_VERSION_MASK) :
+		(mes->kiq_version & AMDGPU_MES_VERSION_MASK);
 
 	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
 
@@ -785,7 +788,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	 * handling support, other queue will not use the oversubscribe timer.
 	 * handling  mode - 0: disabled; 1: basic version; 2: basic+ version
 	 */
-	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.oversubscription_timer = mes_rev < 0x8b ? 0 : 50;
 	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
 
 	if (amdgpu_mes_log_enable) {
-- 
2.47.3

