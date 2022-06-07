Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB51C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 22:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A6D10FE3D;
	Tue,  7 Jun 2022 22:50:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F8010FE3C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 22:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra9ggm23IP4w3fO0HofmeNtJDYQxpbDAAiiRkoUqPcOv5sMqmQMZupNOFt1kKu62r6sYNMhUDHKlLOYzaovScpo2wW8R2DmZ0aCnMDQxDyKdf5xX/pGT+HYn7sD+h/Jumvx7ybczrdYAvN9/YUaVs7zqlPgX4NIDxfKZJEPcj8Qz7VbCUbKozITiRyPOXiVf7pA0tZGhf5cnIDmQtWr/si672TT7FLkgcwOI9C3x8K6AKL5OQx4NKWm4d0u3k6Ixoto7ZY4MJh/LZH+kFg8Z7raCjf2JTLpnM5NdlkbNp4+NcSWeghe4U6Sgl7Sr6RtdVcH68/LMhINutEKP3VIDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JAckWAYybg8lH4hVhc7gTG3/Z1uPUAccczjsxz6QNo=;
 b=FPW7ZkEawpU+gwUIuP3OVm5Ck2qleSAwA5pJOSiP7unqZo9niyaVLa4UpuH1PEbowMr7bLPIipM2RgjUcTiCxDDuaoL/rXWRN+1o6xXcNtzLmESiWjvQXetYu84Se3zuJTCzeP3kcn5w1iYQ24NhnBHaILLX6cpSq+mxBV0WmazONNYq1uHZysi4mq5+5/BL4jx4LxMzQ9b3Y5V/IiduhomUwQU17TQon3QTDo6piyWdmiEuSobHCl4G3mxnrnCdAay1bGAJKPSg9dgFwoG4n9G1LaA5TN7dxshLEx6iks3iPrelL/R//COeGf2PrhtdsUQ5ABMf5XBqSTm8qc33Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JAckWAYybg8lH4hVhc7gTG3/Z1uPUAccczjsxz6QNo=;
 b=PCCgiLSdkQy5SzLrO4ep+jtkO86oGV7qv+h/VV82T7H2W9LZDUrwO1Ltl28qdnEx/MBvang62EIl90vzTJu8Q3gJCs/QQb0nrmhCbZR4U6A+9ZTmEWN1r6XJ/c/xO2P/VEEW3p+oOKPXk8aOSUYKsyHixioHOmmYOJSfVKTeU8k=
Received: from MWHPR03CA0008.namprd03.prod.outlook.com (2603:10b6:300:117::18)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.15; Tue, 7 Jun 2022 22:50:23 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::65) by MWHPR03CA0008.outlook.office365.com
 (2603:10b6:300:117::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 22:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 22:50:22 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 17:50:19 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Update mes_v11_api_def.h
Date: Tue, 7 Jun 2022 18:50:07 -0400
Message-ID: <20220607225007.1372343-4-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607225007.1372343-1-Graham.Sider@amd.com>
References: <20220607225007.1372343-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c17a80e1-52da-48f8-dde1-08da48d81ad4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355112DDE55999519D5EECD8AA59@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2q2K6V4tvnv+hs+2l3b6TJUIxDpQf9qAUWaSG38yXb3JLx2i3+kXNXWxErAE+lhKLygQLcRNm0xRD9BeB1oTFnW/noxxWhgDLdMdBAu7B8lKmknWHl1Sev2KjgdgmGFLUDNmDenePT2sTjhMZ7wfWzwcCSeAtg2uMbugyPCCGnsHTac+on3Dtl/ZFVmkhFGkfepIjKLYslLSA/Z8C5QVMoAAzdviIlkbdMArSgo/4zn3hqzmK/OkKLentQOIIsOUAQrwOlhpd8P9rgfLoJJcOsYykVexfkv60qA9HXdJctDyvQO8o6nphHptYXb5ZW6/IOm++UmIij+9rt9KD/BvHBp98nz4YMMF08a2/YocX5QEaMFXib2xtKvT1nV0y5EnFw1CovRXJSYxVAN0C0bDQgM2fH/r5Fw1UeA1EG5uajoIsDlk9NT1ue/whGFcHxCzcvwuHNodK83ntgpTg0LcPKcR2EMI6xRY234qz+3fWEsUQMR4DlOgWw5Qm1Gk19eXQIq+1eJzD3J79Sbn3aLDORIfLTwTSW2hHhEKgimz0Qa0EyQiZab/lPtGLl/Z1wrJb0mCoEurlVtI1w7RpPS2P32EgbD7XjJqa2bV6Tc4uyOuoAM+YKCJ+aqxoFbWkKA+Omh6Tp5z6aGj1Z5USy33rT4vhWQhoB23WwqvlzeGso14WXsKbGXHaOe67Y+A5Gp9sWOt8ceVPxlD1XORED4pXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(8676002)(2616005)(2906002)(336012)(15650500001)(1076003)(81166007)(426003)(7696005)(6666004)(82310400005)(316002)(54906003)(26005)(4326008)(86362001)(47076005)(70206006)(6916009)(186003)(36860700001)(83380400001)(40460700003)(356005)(508600001)(5660300002)(8936002)(16526019)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 22:50:22.4765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17a80e1-52da-48f8-dde1-08da48d81ad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Mukul.Joshi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update MES API to support oversubscription without aggregated doorbell
for usermode queues.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 ++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h         | 4 +++-
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 2e86baa32c55..3d9a81a8fa1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -681,6 +681,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	queue_input.wptr_addr = qprops->wptr_gpu_addr;
 	queue_input.queue_type = qprops->queue_type;
 	queue_input.paging = qprops->paging;
+	queue_input.oversubscription_no_aggregated_en = 0;
 
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index aa06c8396ee0..26765a9946a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -207,6 +207,7 @@ struct mes_add_queue_input {
 	uint32_t        debug_vmid;
 	uint64_t	tba_addr;
 	uint64_t	tma_addr;
+	uint64_t	oversubscription_no_aggregated_en;
 };
 
 struct mes_remove_queue_input {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 2a9ef308e71c..95a1394d3943 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -163,6 +163,8 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.gws_size = input->gws_size;
 	mes_add_queue_pkt.trap_handler_addr = input->tba_addr;
 	mes_add_queue_pkt.tma_addr = input->tma_addr;
+	mes_add_queue_pkt.oversubscription_no_aggregated_en =
+		input->oversubscription_no_aggregated_en;
 
 	mes_add_queue_pkt.api_status.api_completion_fence_addr =
 		mes->ring.fence_drv.gpu_addr;
@@ -341,6 +343,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.disable_reset = 1;
 	mes_set_hw_res_pkt.disable_mes_log = 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
+	mes_set_hw_res_pkt.oversubscription_timer = 50;
 
 	mes_set_hw_res_pkt.api_status.api_completion_fence_addr =
 		mes->ring.fence_drv.gpu_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d8de2fbdfc7d..762bc6059387 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -235,6 +235,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	} else
 		queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
 
+	queue_input.oversubscription_no_aggregated_en = 1;
+
 	queue_input.paging = false;
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index f9d02d7bdf77..95f0246eb045 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -226,6 +226,7 @@ union MESAPI_SET_HW_RESOURCES {
 			};
 			uint32_t	uint32_t_all;
 		};
+		uint32_t	oversubscription_timer;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -265,7 +266,8 @@ union MESAPI__ADD_QUEUE {
 			uint32_t is_gang_suspended	: 1;
 			uint32_t is_tmz_queue		: 1;
 			uint32_t map_kiq_utility_queue  : 1;
-			uint32_t reserved		: 23;
+			uint32_t oversubscription_no_aggregated_en : 1;
+			uint32_t reserved		: 22;
 		};
 		struct MES_API_STATUS		api_status;
 		uint64_t                        tma_addr;
-- 
2.25.1

