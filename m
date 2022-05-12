Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FD6C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 03:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B22C10E5E4;
	Thu, 12 May 2022 03:09:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0599510E5E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 03:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN6yIoNRgmQH5c965yFzI5n/x/W0K6CeML0P4j1e9cbomUbl7Gby/SXFTNuF7V2b1MR3r56egPhFV3oC1ZAikaIT9wVNIWy4UQtgpFbbcaRASLWRVcxO8kIUEqvabJdnFg4xT5IQ9GrllFIKTJbGg1+oLDOQ1mHgeNWJXxSnT4V8fHdg3IEfwcufrlrd5GihNB6Ov6YPvKi+GjVLY7RRw4FbCLwrmnEx/lTHP4Rtk9jv1icCL4vc7wS5jU6hHjGHCAE/VkLB34XR7a4y/jpX0IEI9ChjXUhh5JuucVh/ORuWkyElFMgEeLrjQuW0IFxGXmzTmnGPb14rv2jNlUaxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQV9H5QTW2geHylmao8voUQneAhbrzK5dgcx0bI8ILE=;
 b=mob6WXwj031XDSITDFxzZafq4uLFmOWBw+sU7lYEppqpQwrxXfietTzcBsUOax96JzVaL5PiVEpWTjtadQ4JI6OszH0Bnj7nOCmuZsGHifXgQcxYMB2bWYxqh2Gtip++wbVVPLjPMRBp7Mf7B1/31MPc9nQRjapTHIIS+irzI7OR4vrlBxrHdmmrFqjs70vPxRIhWlIbeSGCXs/pY5Hoyisui6nPlNGA1XCX5mZ+nszZCrq0AsOiHoh8D21TZ49AGH+IMfETDRCkPQseFdpDq0OduBl/XBVOzl5nsQ1oz0QDNGL+JhcDowQz12Yy7CO8K8iPgUVpL4vxAiTEWXTdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQV9H5QTW2geHylmao8voUQneAhbrzK5dgcx0bI8ILE=;
 b=MgwZCEOMhXfy9hhrokLmvc9dRn0uYF8GVU2TCq6Ulkp8kskA+y2W9aOgNoOhHs+hG2JPYDeeNv+vGv2XL/qbIWaoVL5ib2dte5nnti7T/yOa5aHsApq8ic+Q2bRnW2PwgyHMtw0VZJjmBhmRKqs9HPFUcBTzn77mUJiUvA9yR0U=
Received: from DM6PR14CA0060.namprd14.prod.outlook.com (2603:10b6:5:18f::37)
 by BN9PR12MB5274.namprd12.prod.outlook.com (2603:10b6:408:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 03:09:13 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::a3) by DM6PR14CA0060.outlook.office365.com
 (2603:10b6:5:18f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 12 May 2022 03:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 03:09:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 22:09:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx11: fix mes mqd settings
Date: Wed, 11 May 2022 23:08:56 -0400
Message-ID: <20220512030857.525411-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512030857.525411-1-alexander.deucher@amd.com>
References: <20220512030857.525411-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37ce156b-934c-410e-89da-08da33c4cae7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5274:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52743DBFD8B59764798D39AEF7CB9@BN9PR12MB5274.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YiykLYoH8mRrA1u7bjaE7lyUylPMJiNRSv0OBLrvf9LkvRWm9Ctn08+yyinYOVRIsjG71aDGPuTZ0sZ+7Jza26vLdeBCB6Xxb01J9YUfSiWYDGC3pxsnZZ0rsVQZl41xeVGVlljzt5Q+hEd/KofLJmkejgK9ZtWtxKCNp6WoHktoPt2js7c1GZsRuS+prLNKb2OrWGQmD++HmtI4rL1TN0n1Tba2UKgXKl7RpFKUC1rUZmjA7DcV/LDHxO9SKRVneJt0lD8CMMppxt47zU/3/pp57EX01Qv1Pelr25CZsmIjQuXe4p5L/ntZHo5uXeWQz7AyiagGthWPJW7YjURrLyI86/vAtWoxWChSbdKPxDf+XinxtlKcTyaCa5xAHKE2MSxwDYfBPWJSmYZiYa1yWxMW/51X4K0reYWgFag9QvFW2/fQ65S8d5KANv6l/wlga7ABNTAmlyaQy6xCtU4sM7ouYUyxsm610U6lj8OilkYdXg2X8dV5GuXiXWesVLweugQYNqjVKwm6PEvVBmiL/tonUnL1LIpFiMYD5F3PmWiLPmWpCk6wfwwvP59vBWNYyXHJYlx7kUOC0pYD7S8QSiHO+5uKqIBvXvbVsqvd73VOjZ100spj3RLJi8vuHGELQQzJy+sNSQ309nglfSFkm/xD8mrPZ8nx3UVxUOuy7b07UIW5cWOJ4Pm3KXPEgBawzURHL9assp5EzuxL2U/clw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(40460700003)(82310400005)(36860700001)(83380400001)(70206006)(186003)(1076003)(8676002)(4326008)(426003)(70586007)(47076005)(336012)(2616005)(16526019)(26005)(36756003)(81166007)(7696005)(8936002)(2906002)(356005)(86362001)(5660300002)(54906003)(6916009)(6666004)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:09:13.6187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ce156b-934c-410e-89da-08da33c4cae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5274
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Use the correct Memory Queue Descriptor (MQD)
structure for GC 11.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5d4d54cabf70..fcf51947bb18 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -29,7 +29,7 @@
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 #include "gc/gc_11_0_0_default.h"
-#include "v10_structs.h"
+#include "v11_structs.h"
 #include "mes_v11_api_def.h"
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
@@ -637,7 +637,7 @@ static int mes_v11_0_allocate_eop_buf(struct amdgpu_device *adev,
 
 static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 {
-	struct v10_compute_mqd *mqd = ring->mqd_ptr;
+	struct v11_compute_mqd *mqd = ring->mqd_ptr;
 	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
 	uint32_t tmp;
 
@@ -724,22 +724,22 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_vmid = 0;
 	/* activate the queue */
 	mqd->cp_hqd_active = 1;
-	mqd->cp_hqd_persistent_state = regCP_HQD_PERSISTENT_STATE_DEFAULT;
+
+	tmp = regCP_HQD_PERSISTENT_STATE_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE,
+			    PRELOAD_SIZE, 0x55);
+	mqd->cp_hqd_persistent_state = tmp;
+
 	mqd->cp_hqd_ib_control = regCP_HQD_IB_CONTROL_DEFAULT;
 	mqd->cp_hqd_iq_timer = regCP_HQD_IQ_TIMER_DEFAULT;
 	mqd->cp_hqd_quantum = regCP_HQD_QUANTUM_DEFAULT;
 
-	tmp = regCP_HQD_GFX_CONTROL_DEFAULT;
-	tmp = REG_SET_FIELD(tmp, CP_HQD_GFX_CONTROL, DB_UPDATED_MSG_EN, 1);
-	/* offset: 184 - this is used for CP_HQD_GFX_CONTROL */
-	mqd->cp_hqd_suspend_cntl_stack_offset = tmp;
-
 	return 0;
 }
 
 static void mes_v11_0_queue_init_register(struct amdgpu_ring *ring)
 {
-	struct v10_compute_mqd *mqd = ring->mqd_ptr;
+	struct v11_compute_mqd *mqd = ring->mqd_ptr;
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t data = 0;
 
@@ -910,7 +910,7 @@ static int mes_v11_0_kiq_ring_init(struct amdgpu_device *adev)
 static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 				 enum admgpu_mes_pipe pipe)
 {
-	int r, mqd_size = sizeof(struct v10_compute_mqd);
+	int r, mqd_size = sizeof(struct v11_compute_mqd);
 	struct amdgpu_ring *ring;
 
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
-- 
2.35.3

