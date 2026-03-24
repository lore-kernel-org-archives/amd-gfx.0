Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED1CFEC0E6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7204F10E604;
	Tue, 24 Mar 2026 17:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vpyYLzHr";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9657610E61F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX1oQJnMcl3cqmIWqF6AxcAs7/u84G/qAZabUkFdPkymepRVNOZ8nAzAF9ElN1NKtvy4wY7ycCZeqSVeRiC4VTmAWzEhS83PgOcAWkDv+X2Xq/vX091zm8WKrWkX+zvwC0Bfqr5WfExReoMpZU3WTcw+E2n0s5vlKVE/yz6VOUlIUz+MRbSyel9lYFzNKeOn5lKR4BaMIaSYkK7o+MncaRlPQswwqcYV0kACaaIvd66po+oBRCOfK2acchSS+vVC1E5jePpaSfQ34f9LcsUOREAlFSd/rBELtQCi+Oc6oxnMqY72ItvUhfcBTz7Am13MMOxsMHD2jONgfpJdQoFUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uapQuN8t70i/cGkZeN5IsC7UEVDc9URbvZSrh0ImjFU=;
 b=cq4Ydk0GmFRLcbM6LtcroYKdOrmYj0FUkdcX3sZa8bh4244EHekrNMKcWjOiXHGWw2yfMoKCNGxe/CfPPZwHWodIFU1CMZ9IlJMPT9vXfhT7qYpR12xPyetS2DHQlnjhuqHLDD5JRc1TGJAkFigivBH1J0qfRohFjJPusA/lywFovH0fdCjx0yHunix0N1jf5wTMTznNwrWH7r1ZKV5H00UnTfu7DMDdyCzo8xuwtDcW758clWZ16Hpvm7m00UHe2lwvgSgbctftSHo2OeF4sYcAh+s6zAaKReNY+WZ1C6KAIN40gCJXOhCooFScVzOx9m+K/8HlusZVgDHgZxlfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uapQuN8t70i/cGkZeN5IsC7UEVDc9URbvZSrh0ImjFU=;
 b=vpyYLzHrv5K/l2hM7iJsE9qpUPqEuqsdIuqzMbv1FW8gCXtCpJhkBMFxyrOV92P6TP7r/D9rbyT+x4iiborNS4eHZzTGQd+L6ZabfVSzhEQTobzsrf/YG+f//DB5SY0XZUQQLfpngqT6g7zDGs9GxGZsIKtDMqumUT2/BlMQTG4=
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:57:43 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::49) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:42 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:39 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH v2 02/10] drm/amdgpu: Fixup boost mes detect hang array size
Date: Tue, 24 Mar 2026 13:56:44 -0400
Message-ID: <20260324175653.1325754-3-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324175653.1325754-1-Amber.Lin@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9e2d92-1021-4868-d398-08de89ced8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: UhvCC/lPhh8YHBe4ayNl0n4YnTFLIxkGZwcyKCbpGFcJ7WGbpu6WFg/wS6aQ2QFkWwBmrBuZyIymr5UwMmzIqFwCqpCeF6YpYEj9ewEyYWSJq/vLoYIUJ8Os/d3sUNUZMmv1DWmrlbAOfEbh36A7ocJMw8TxbEfEkoSwJMG3f8U/4gB0Bif8m9ensLrCU7CZUatxdVb7Xbyo1Xz8lrW5Rg1pLP5IOxw0gbtNPKsu+oxIMPmCRXK3EmOC3NFoplqduJlpdWjMrqttriQUnNabmfGMzvUGumsdgted/Z5S/98zCovbWcROawU6KccLOOyJEwpsUcyRaYgvt96M8pWQCrleLUeuax7rKLLB48M+2J7wXjXBAwmIXX7e/8myBJUZrFVtZsJZuJsoClSk7Vny26E90eptYPf5G25rsx2fnkRZ9+Syw3dBu7vnZuBqFfMEAet6we/WDesNB6DODSzFjGrfw3ZR4LpbEOy7wbNRUIE40Rzi6zFSZmcfTdB0P4OBnNwYQHonUuwx1vm74y9OJ7xR/cpgsnexD3y+Sum5rxvknH0xQbTajsvcHI2DuwgRcCizwYlTP6LAHcdbJGiG1d5N5Uy8GBT9GGt4TexCe2QEka9z71dWJK4If4BD/wrVHl9Y+hAkPZvyo6QfhsrkVERlXEZW3oB71S6qEtwedA8P/gqLk5G1kpKFa9DXdMQ1YgziirDQU+2tpKmrtc+mPVThuMFYfjs45ujqr3ewhSMC6JaMJZ2gmqiSwvQtp0dyuPassPOq4oANpblPnyct2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9zf5TiX91VBLcH8luE6HkzLlt0ZrArdXb17hnBAAsdILXVRusMdhWJVyaqnflQQgVJwFLnUciW1+yvamM4nwkSfPhSfI7MwHTwr8zG7Dpy1AKZABbZWYPID7j8VWQphFCEy+4FA3GqAIYzzms781eIam5bUlGTaR7WpUXFFhDBlumPv71LTQLg/+ae3OXleN0qoHISsYSHFluO1fWplfm28gZ8fAh2AzVJVH2gytfPpgNubqe3GfpkNoMF1HMCK04wHGKI6Um4Sh6ZuuhnOdHfFco3WZqCPHB7akiEzDJTr5L7FET+dKkAjzFUSGqCyGwH/U2L6deKRhbrcXZY9x4If1WLV/yiwHdP3RUTwLdD3SAeMqIEWQH7mY3FlvnDRIjE7u+OiLZkoO7r/aJiSmTbaOVgzPFNN/4nTj+L7PSB7xAK9j0MsmMu208BTYBTHV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:42.8765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9e2d92-1021-4868-d398-08de89ced8ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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

When allocate the hung queues memory, we need to take the number of
queues into account for the worst hang case.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 33 +++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0d4c77c1b4b5..e639d6c329e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -103,7 +103,7 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe,
 
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
-	int i, r, num_pipes;
+	int i, r, num_pipes, num_queues = 0;
 	u32 total_vmid_mask, reserved_vmid_mask;
 	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
 	u32 gfx_hqd_mask = amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pipe_per_me,
@@ -159,7 +159,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		adev->mes.compute_hqd_mask[i] = compute_hqd_mask;
 	}
 
-	num_pipes = adev->sdma.num_instances;
+	num_pipes = adev->sdma.num_inst_per_xcc;
 	if (num_pipes > AMDGPU_MES_MAX_SDMA_PIPES)
 		dev_warn(adev->dev, "more SDMA pipes than supported by MES! (%d vs %d)\n",
 			 num_pipes, AMDGPU_MES_MAX_SDMA_PIPES);
@@ -216,8 +216,27 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	if (r)
 		goto error_doorbell;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 1, 0)) {
+		/* When queue/pipe reset is done in MES instead of in the
+		 * driver, MES passes hung queues information to the driver in
+		 * hung_queue_hqd_info. Calculate required space to store this
+		 * information.
+		 */
+		for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
+			num_queues += hweight32(adev->mes.gfx_hqd_mask[i]);
+
+		for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
+			num_queues += hweight32(adev->mes.compute_hqd_mask[i]);
+
+		for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
+			num_queues += hweight32(adev->mes.sdma_hqd_mask[i]) * num_xcc;
+
+		adev->mes.hung_queue_hqd_info_offset = num_queues;
+		adev->mes.hung_queue_db_array_size = num_queues * 2;
+	}
+
 	if (adev->mes.hung_queue_db_array_size) {
-		for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
+		for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
 			r = amdgpu_bo_create_kernel(adev,
 						    adev->mes.hung_queue_db_array_size * sizeof(u32),
 						    PAGE_SIZE,
@@ -264,10 +283,10 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 			      &adev->mes.event_log_cpu_addr);
 
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
-		amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
-				      &adev->mes.hung_queue_db_array_gpu_addr[i],
-				      &adev->mes.hung_queue_db_array_cpu_addr[i]);
-
+		if (adev->mes.hung_queue_db_array_gpu_obj[i])
+			 amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
+					 &adev->mes.hung_queue_db_array_gpu_addr[i],
+					 &adev->mes.hung_queue_db_array_cpu_addr[i]);
 		if (adev->mes.sch_ctx_ptr[i])
 			amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs[i]);
 		if (adev->mes.query_status_fence_ptr[i])
-- 
2.43.0

