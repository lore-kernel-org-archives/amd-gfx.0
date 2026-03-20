Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE3F1099B30
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 20:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA57F10EC14;
	Fri, 20 Mar 2026 20:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3zmLZuS/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6EA710EC14
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 20:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Po4Kf42CIlcv7QIxxNRzNnXjua8vO8iw7Z922wtDFyvb3WrGNMNDi4yhMmd/pbH3OWRDB7l/rVIbwXCebzonSaYXN8j94Z1W58pZJ6oS05wY8dPU7WDNdjdpIRpOL1jHlDM/eJCxbt6OPhKWPJHuFpSQvGR8FJmCOGxAKty3cQFOM/+e2litz8WJRhQp9o+ch+uayEFrZIHktN3s5r9wuEiecPioljRknuxkp3ijsfTGCxvmFYJf1tv7AMukRbrAjDT2cV/ZS3G1tE+hgEiEmdW6l+VCFtwAUQgej3FgfPELPmZLPMczYCo6Ahn19IAADgB0GiQljtRL6j9/taR6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMP0BlSLM0pHe0k8MrNx6TUPuAZVRykDFZdBdj1pZNE=;
 b=sCI3xzBsraxhFVPvf5rcxcIItJlKkFC06nUB64QscsX/0YAS4h0qIq7sNmTuAZEbDaIMsh3oJU/izd2BNrJbEJSfyF0VSjcbRkexU6Mwbd4RpRz291mr0cqGQjMZnXD+2yJdiaB4Wb0AC6WtYQ13/EAh2iQPyu6V3swtuzE5t33QLuMhQKrX90U4H9g5PE1/OwkB5T1UKkHDpYf/RX/bmSn5ej3CreLwuODy6MR7eA+a++85H0rbN81oFfm9UG4SXdP79NOLA0Mez1g6E5+9NeEhUwombJHzbcOR7S0uku3MWVqEcG3ADHPvh7H+mqUdo1e8c/Cm2P6+5TBgyWg2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMP0BlSLM0pHe0k8MrNx6TUPuAZVRykDFZdBdj1pZNE=;
 b=3zmLZuS/Q5Mkf6iSnGCp+pbQ0hRNmmA9wc8wc8PDsN2H0izPz9VBmh0Cxna8nOL95i+2ZCWqkglmYzgiRpjtrPm1B6k0IEfx1NuGMOjdPrBZtJrFcQmWdyg8z+2AgaqQIF5ZavqoKKwmWRrgp8ZhRWhJD9ifkJds+y1Og324iFQ=
Received: from CH2PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:4e::19)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 20:02:37 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::1) by CH2PR02CA0009.outlook.office365.com
 (2603:10b6:610:4e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 20:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 20:02:37 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 15:02:35 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: Fixup boost mes detect hang array size
Date: Fri, 20 Mar 2026 16:02:02 -0400
Message-ID: <20260320200208.1188307-3-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320200208.1188307-1-Amber.Lin@amd.com>
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c2d5d2-90be-4aa2-ef8f-08de86bba277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: D33H/qRQjxmGyYhXua0Zy65giTSEjw1Sq0sbDuGZQK/Cv6Pc9IndCb3sRN82MuBtRW8GxHEZmeP+ojvZpICE3b+4fOwVZqFec1nG38ZL4MD7jCI0GI3dhxYZL/SKVwBWKHe5n8foYiHCJPt10MXr1BB4CPHh6bKMdy1ELWVEczFVumsOZ3ieV1/5aSbrjFUTN+QLKeMnc9yUCiQUXFWjPF6gAdjtN1u7dSA6qi1R5buOPTwvF51OdUOscyhjsyoIbC8Z5JC5nnzePZ5Gr1RRYzXwsoEfTDgA43GQiyLkWiNEqAdKnZcuwDufYaOhQK2oEyFY7+OUhCfoEbLYiAeMD1iuf04yMA1FAXtR2U4JHWtqWBEqCEToP73HkPxLqJ5zC5l4V0+ULH9jrsOeA0D8JSLWmejh78LXTN3Kaft9NCpRJNju8FZCUyU6slwS4FrT7vd+WNr6HFr9PEzvI0FOhe0ewbSOo9oxQ+dpGxGzEAGOaARURZ38wrAPq5wQF/97XsHR4ySTBvGugBt+aOx9dX3atqOVOcordosYA38+maDUclFvrO9ZseUFjul/32c6IDO9iXqlhskD8ygJMh/dRkZm4Tscjvf40/Z9zjSImBJHypSD5Wo/vPwB36hI7KTZaZCSzeXVvdD3Uk3A0wgwyRjNpgglVn2gENCBAn3A6P/glm/F6p2QyYvagwAc6qvLBHQ9DoVvde9sZwLCY8Sk1t3INWIiD4H0A6/w5+nVO8RnL63kFX72GlhmmV2nxF36PkGLXP6F0eb1dMrS7IYA4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /xM5fnplvHDeZqw0H7uCom23O9Wb8K61p6rZm1d+wQg5zLrCmPMGgTEXFulXxSTM41eDEyoubeJaS+WJ96JMc7U8lvYyX3+aCOENuOZTVKsm6DgIestlJhZUFsfwl+VqY2jksbN/G7YZpcMoN3Q0BqgABi5LckEt+YjW+NJd4l6LaAjzzcJbSI7BszWyV00uVskff3U3kSUkj3R1N1L7UAnWhmHZyj5IjGU3YXXjRc9kGAwAlj0RxHQTmTzQVWGdMlo5KkX5/1l53UGs4B8RAaZzfHJSC8CXML+VXHRTNVzMsBenCI53VbTGnMHkPFYc43yz+j5amlASX4hf51GXKXaCKg6CKZ2cNAb5xOu6llwEzeZdKIot7X4R4MzkpSTbCgEXGCMvIbFpSJ23St8ivFE2heBqgFWRzvypaqi4oLpFR283BgbFi+KzAIAHQSsN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:02:37.5410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c2d5d2-90be-4aa2-ef8f-08de86bba277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441
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
index 0d4c77c1b4b5..b68bf4a9cb40 100644
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
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
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

