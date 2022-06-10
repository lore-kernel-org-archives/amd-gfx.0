Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7D3C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 17:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D45E10E8C1;
	Fri, 10 Jun 2022 17:13:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BD210E1AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 17:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUsBqNZWGbzVALhwVmDplQltm5tpCZedgzuTgMHxgufm2vKCuKlqBW5MMHKKtSLCsCXe75wJST1xmMjeYZzdmlrijy61+ZjZOz5JLlOxq+M5yLrvYH1AINwxBmpfEY9kB+T0MuNeOtCivKr4dJR9QNAXU00YkNcKvY/dPmjvMWhf1De+XBYbL1E4OEMF6UVbr5JL0jZK9l4bZkTRGvjUOYqg/tvgZllbYjOPIj7WcjFVyY5CWNasX5ky6aJmdWTr3bG//AHswDffuQb/RZg0UqpcnSDDFAjNOIIiBDB2FeMyyP7+CypdPqSEednECZADqmaoAQC1LHn0XKRsrTyQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JAckWAYybg8lH4hVhc7gTG3/Z1uPUAccczjsxz6QNo=;
 b=UH6TjRrGgWd3yT/2/neXbRgrl/IeFvGd9vu/ECjkvjno6IHqFQzZ85sGJvokoGamnPmxIl1z5z0x99TaAUFxgBuBpkLKfaYjQtH0cxFXMsWFFD6xrT24MTkU6mSqj/ma5AeZX9aOqqSPgV9FonJJi4MuiwnOSDxC+idnHSBR4ydAk3m/I/1VS1U0vToXYsqC4Hx+Er7FJm2pqJ+J8bIdvHAna3/O/oe0JVBA+Hnr9O/VSyRTIr63eGEilXSVnw5x4uaNRj3DgYtoErvBBKrL+0cgcoO9CP2Lnv8aSh+3CxvapPUJBgg4puca/7Gx1y+q6en1RBk2IkS5edSKt+GBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JAckWAYybg8lH4hVhc7gTG3/Z1uPUAccczjsxz6QNo=;
 b=huWwVou9FHB2DaPAe+CivbGisn7Ljz9m3vtJtC8xbge19RfpsMdnbGaB0/UbG+joGvUh1wZ+lIyRbZO4HKQFG9ZfKbQfL/62ZktIrJTjMoj02MCX9DkgRA8rzMOmYX9kwLQvkSRH/RN0bu1jnaG8ZuGUkdQx7lBAnUxgWIL1PRs=
Received: from MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::8)
 by DM5PR12MB1465.namprd12.prod.outlook.com (2603:10b6:4:7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Fri, 10 Jun 2022 17:13:32 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::18) by MW4P222CA0003.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 10 Jun 2022 17:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 17:13:32 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 12:13:30 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdgpu: Update mes_v11_api_def.h
Date: Fri, 10 Jun 2022 13:13:16 -0400
Message-ID: <20220610171316.2668611-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610171316.2668611-1-Graham.Sider@amd.com>
References: <20220610171316.2668611-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b43c789-a10e-48d7-0bb1-08da4b048be1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1465:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB14651469D1523AFC4A7B3F6F8AA69@DM5PR12MB1465.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUPyx6k0urn1pivAk91T9rcJMzqYgQ/OA24dDaTPo+VcwFgPh0DLFvpCc6hW2JFEjToHFDE+5zbiYNFLnltCOfU5ILscQZgpTHR8B21pqSkOxLhLtfCkOS8qpGRZDkJixNuzOkfisMLLZVebubVFtWdJ9BktetVoa9u3ShPcaChWvDBYohiRh9Q/lT1Qve6J18dd5v9GgRkuSgw09iArAXuLLkro/5AtN52bTMSGsprDQP/iA58SYGbzSjzr0JgAIAOinBpsauDAqwOH0CMQdwlejMqWymZpM+eMEwcIPqUBPfK86DCogDtRtKjOz4LW8bXBQrdrkfKjacWuUZo/MArHYifUOT9o7Q9N7hZ2qmFf7+lSwp1LpnOvj19ReoZPUUw07Ja3mTiySOjCJGUIoPQ9ZAMNjcG81bRJluIKoZwMTPoj0RLUUpwrQuRbWuOsEJyIrozX35h/jmAOX7ztKK+T8J1mgLduSIhH8rNacjkyhMmyy6Z13gNYwckaK3I73//T4tVvnwVPyBD7Fcv6fDn3GlQqxFV2vfjHXrXZMu98hgzbt65tafWqif7/bNC0dUpGt4In+QLLZCMkfRJTHFR9R1eyO3rQIABHJ9b1SNV40mk9pbWYuOIEaUT7nQC8/DxBdG/uI0PQN5FT6gh/GnVZ2wrz1dcz+abBwIsPXosey6hMVzLy2lvPmnDBmFeKi9J4p3Bb+wWcMGpQDdlM6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(7696005)(6666004)(26005)(15650500001)(16526019)(40460700003)(47076005)(508600001)(426003)(2616005)(1076003)(336012)(86362001)(186003)(83380400001)(8936002)(356005)(36756003)(36860700001)(82310400005)(5660300002)(316002)(6916009)(54906003)(81166007)(70206006)(4326008)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 17:13:32.3205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b43c789-a10e-48d7-0bb1-08da4b048be1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1465
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
Cc: Mukul.Joshi@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Philip.Yang@amd.com
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

