Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDB6F9D0F3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C26D10E65F;
	Tue, 14 Apr 2026 19:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qjs6v8u4";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B1610E65F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1t1sW6tW2bng2bACccgbRhte/dXIIarU8BCp6dS9+VD9StqM5PeZUxXEjYGFn0v7VTZdvNTNeeDFFaUyqD28PxLQzCKRDFtrKSqXCi1cpxXjoDD01zcMMBfHvYDkwoYLvM5b2gbXwp9tTc0F3hw8E9DmK3e5SP5D7bIjb6/3NKfSbiHC4f2DqzeGcE2WxvlOSaDSf3qhtbgZqe5YaH+s7X3wcXLYSJY6cLHNRccZUBfV0JlE/aJQEEDlfePfF51TUu50KCVvwWB9oOUN0+3KKlAyZk2uuxrE2GJtxHs0MBHR0DDlnsgNxKNxI57TwRKpkMSXcWBwsTUMXVbSLCg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhiWoay9B0f7jfyLxp9tc2gZpo5ADJvdUgbVFywHY8s=;
 b=u5ZTAYu3hjF7+iDNB6augFRilFjjzzw5klq53MTIKzk6KWO2N7QXMN8RRB6gmTosiX5KhZiZ9Z57I60E4OldO6p4xIGHWdXi6ujbnVnZaPRG7TGe876jpuUv4s1Vm1GYR7TD3DM8WLEmjsYYbRPXVlCqywASEMi6cD/H/m83QuOICnW1muOQiFHXhRreQvvJcFl7R7f5orCAKFOWKLR0I9CI4U5qg49UaCtJ7Fo5WguoIfHB8k4jYuetfNxTeDz6fu0xfZoQfRwo3hFBhr2+ydUfcVv0NqvN9O7l9YDEvqQcD9NFoz9pujWTvdkXfb5wu4Q2H6dOIVsB9PurrC2aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhiWoay9B0f7jfyLxp9tc2gZpo5ADJvdUgbVFywHY8s=;
 b=Qjs6v8u4y0/jLYzH3Uy1jNc/jfNS6QC8dGGE8saTbDRMdN+DioRMGgnl3qDcKEekEIR8MaKpCkKCQKQ22stdUxNf8IoqCZHuzTGTwPq/LCo4ZbcLqv8/iPaSbkYEegdwrBrOWmo6HtC7lS19TRFYhO1qRRAegl0FqL8nQIOasWc=
Received: from DM6PR07CA0106.namprd07.prod.outlook.com (2603:10b6:5:330::15)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 14 Apr
 2026 19:48:30 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::ca) by DM6PR07CA0106.outlook.office365.com
 (2603:10b6:5:330::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 19:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:48:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Apr
 2026 14:48:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Apr
 2026 14:48:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:48:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>, Michael Chen <michael.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amd/amdgpu : Distribute inv_tlbs on individual XCC
Date: Tue, 14 Apr 2026 15:48:15 -0400
Message-ID: <20260414194817.2213993-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414194817.2213993-1-alexander.deucher@amd.com>
References: <20260414194817.2213993-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf95b9c-c60f-44ed-9f47-08de9a5eccd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|3613699012|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: sr0Ndmzmnqw87W4TKuGZug3HYtvMYmiAjgm15DD+HDilnRq1ZCJsFRl5+ZxaMdXiurwIE0kFP429sd0R0iU6a30+UdZSiM+VHNwy5SGPrFgPaYlkkz6SgJRCHitsRd9NsTACinew1fX87EZ3PN+ycEh7pPRSlhBCTKdDVzOSSm5H24KoqccMsLA3RfH8W1ygxp/X/KXwVxg4aCTQF5o19wiA1eqDR0Ghtz1wd/pfLK7wVQTSv5qdbbKZ8fWvOBbHCCY3VaXwfP7vpGCXLBmHGmZUvjQZUVhRS5In97Mcp6zeg/CvYBLZyntFtYtjhzpK+tzPvZZ4uxKgwl0MQk9symcSEEdHX6JevReFCb+P0jwcPtsPFCORTakAFT+TFKvRT7w9a3IjHxHP9R5SPPDcqYnQjhO7b3ku2A2Lf9Z2P7SfVNZ8vsNdZsHRo/c4yUHaVKANKFOcAiSLNz2BvUrSIR6LDADvdGyQgHrOQN6PeoDDFFP7dG6TNBjOZL6anXyxNv8O0Vq0aGIbl6b7oNdXjhP1C93lhOvBew5lpB4OV75s2uQ2JL8hJVMZkY1g9dKXE21nrRF4kRI77GmAr9UAdKer913+kXw1ZLPT3/QAyR/3Y6aSCn6VFuOrYie3UrEgU/8nHdm/58sZ6re68Ap8lXbY/QcKYs/1J5hY7NjFQHh5aajDFYw5BUextH1h9s5e6XW6eHEzmNYVBBXH7fn0WK4bXbSgYNAeCdwV+gDtpe+ycspdHPEyALNSWi740JiiNBua5PKQ+7GWJGEIBnQPYebSG/+MN+LNGsuw6jbbCiYVvfqMNUL9xmmvsQ+DiFqz+fep1omzpnBiSJqVBor+5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(3613699012)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PNtUN8tDPFNFrR1ZLIDHLhs2fdNsgLDclVK9XEj/xTS91rwIj3GYH+aLJp5nK8RkX9563EhTBiNVcYraUhYd+k6xunnwDMoWjmC6ykMYGPYVPI62YsBoQn1i8G49cE6eSfEogYf+oyMhC5oJQGm6B84k8lS2AXVjG0G4PxbhX0fowhWb7MZfRndfnIyXfdt6NMN+IigKi+gAyvgGJ52Htdy8YF+9mrJZ+aza1ruXEFRZQGDPgZHmKCgNcOvbTDbps3h3Nhd1kHjMKBDQmvVtGoezlmej1oAwSC5EsPuctxv/avPptQZj5LAwC/hz0MNDSTZ6yjpocqdXjM19OnmlArowLjSwmZrQqoyawd+TU+Lkwa8wYpAH3aodeqxrnT7dC7XvW2RPly7iIvxRM2MfA0PYTxSvOKPefu2fyP+Kua7ufl3BMBCGdXdxlMqWaoBN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:48:28.6793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf95b9c-c60f-44ed-9f47-08de9a5eccd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
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

From: Shaoyun Liu <shaoyun.liu@amd.com>

From MES version 0x74 and above, pipe 1(kiq) support use the
shared command buffer to distribute the tasks among the xccs
within the same partition. It's more efficient for tlb invalidation
been done individually on the each XCC at the same time compare
to let master xcc loop all xccs.

This requires the coop_mode been set before kiq set_hw_resource.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 456dbbcfce1e8..3023cf6ab1ba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -44,6 +44,7 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block);
 static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id);
+static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id);
 
 #define MES_EOP_SIZE   2048
 
@@ -621,11 +622,15 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 	mes_set_hw_res_1_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 100;
 
-	if (mes->enable_coop_mode && pipe == AMDGPU_MES_SCHED_PIPE) {
+	/* From version 0x74 above, pipe1 support use shared command buffer
+	   to distribute some tasks on individual XCCs*/
+	if (mes->enable_coop_mode &&
+	    ((pipe == AMDGPU_MES_SCHED_PIPE) ||
+	    ((mes->sched_version & AMDGPU_MES_VERSION_MASK) >= 0x74))) {
 		master_xcc_id = mes->master_xcc_ids[inst];
 		mes_set_hw_res_1_pkt.mes_coop_mode = 1;
 		mes_set_hw_res_1_pkt.coop_sch_shared_mc_addr =
-			mes->shared_cmd_buf_gpu_addr[master_xcc_id];
+			mes->shared_cmd_buf_gpu_addr[master_xcc_id + pipe];
 	}
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, pipe,
@@ -1148,9 +1153,6 @@ static int mes_v12_1_allocate_shared_cmd_buf(struct amdgpu_device *adev,
 {
 	int r, inst = MES_PIPE_INST(xcc_id, pipe);
 
-	if (pipe == AMDGPU_MES_KIQ_PIPE)
-		return 0;
-
 	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_VRAM,
 				    &adev->mes.shared_cmd_buf_obj[inst],
@@ -1714,6 +1716,10 @@ static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id)
 		goto failure;
 
 	if (adev->enable_uni_mes) {
+		r = mes_v12_1_setup_coop_mode(adev, xcc_id);
+		if (r)
+			goto failure;
+
 		r = mes_v12_1_set_hw_resources(&adev->mes,
 						 AMDGPU_MES_KIQ_PIPE, xcc_id);
 		if (r)
@@ -1836,9 +1842,6 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id)
 		goto failure;
 
 	if (adev->enable_uni_mes) {
-		r = mes_v12_1_setup_coop_mode(adev, xcc_id);
-		if (r)
-			goto failure;
 		mes_v12_1_set_hw_resources_1(&adev->mes,
 					       AMDGPU_MES_SCHED_PIPE, xcc_id);
 	}
-- 
2.53.0

