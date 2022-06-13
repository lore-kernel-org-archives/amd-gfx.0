Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F85C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 15:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4625610E8AE;
	Mon, 13 Jun 2022 15:20:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437D810E8D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 15:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6Mo7oC82/tAP+8/A5KMnffMnLkJ/g2zAytE27e+bjznUca+lL9yw7n2ZpWn5DuvTPrMTpjX3jmHbt35Bo7q/94phKo7yv2Ea5vTdV1i9MwIyhbKednaD3WXdaZo6xph+2iZKjHvjO4XU2uBKWtUwr/SzNrKXKivQVf5VwgxCNJirQoyPY1URru7oqNB04vL/7bOvwj4uD2ovyzEdvte2zsTeJATMZP+0oy+W1NnnsckUZK6cew0d0/XlxAbmivrjCFEVBr3JN7VXc1Gk+4HPASNWzuN797bkxl2N8MLrTyWYmoe9dU2/VW70krd4scfMy16Po3mZNQCILu/fIwddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JAckWAYybg8lH4hVhc7gTG3/Z1uPUAccczjsxz6QNo=;
 b=Tnmq19igYmEhD3V6gqI42qshDbclE9h1Z3SJj1kteh4zQezFxPSg3LEc1p3EX4zqy5aLhkmBXCL2k896UIVV1m1FaM++72LjamXKJZnkJTry1uaEUlISCEITd3z7dsF8WUzdmIziabSxIcQkEWg3Q7EZn1iEujO6mcn3Am59HMApzlcALzLVMuRRjr64PduImnix9KZ3aCJJ9DE1PDOjGLEO1XXuIThXhKSinllEoVlGVjJ/v2WESB2TYg9YR7YRTEDnW9L2jHxpkQDPMSt6ZEM4aw78dSfr2zCWPv+vzrLNXwnr1RHbIun+oGdNTCssRWuGx1d0wdK8+dpPUuzePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JAckWAYybg8lH4hVhc7gTG3/Z1uPUAccczjsxz6QNo=;
 b=rq4NfJjUKPV3u8I5VV/SqogsRnagqfdPtIoc1GYcUV10ai6f1ij42KGZddlriX78AVvUtyPUdPm+Bfh2apzV3jXPk0yRoiF1B0Gz2fm4gnpH6levkGxDf3xLviLwzlrTPTC3lRD/8K8Pni7eObVjmN8HIK711JN1iyo9wqMe3LE=
Received: from MWHPR11CA0010.namprd11.prod.outlook.com (2603:10b6:301:1::20)
 by DM6PR12MB4928.namprd12.prod.outlook.com (2603:10b6:5:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 15:20:18 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::9e) by MWHPR11CA0010.outlook.office365.com
 (2603:10b6:301:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Mon, 13 Jun 2022 15:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.13 via Frontend Transport; Mon, 13 Jun 2022 15:20:18 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 10:20:16 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/3] drm/amdgpu: Update mes_v11_api_def.h
Date: Mon, 13 Jun 2022 11:20:01 -0400
Message-ID: <20220613152001.3045911-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613152001.3045911-1-Graham.Sider@amd.com>
References: <20220613152001.3045911-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a62bf687-b4b6-480d-7c89-08da4d503977
X-MS-TrafficTypeDiagnostic: DM6PR12MB4928:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4928BF4C761A8D65FC06ADD38AAB9@DM6PR12MB4928.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mr6HMqjxkCC2uvIFyvYG6jYrKjFCWoIBPHXaXdspKmfO+k8O1MyHNkHZkGWMoxO0UeyTHeGuuwM8QEbo7bJW30R+fn3QuAYzg9rYx/VtRBkxLb/XRgckXxyky69vt1a36OC3i9N4z4Cu1xkAL38vi1NxoYnZO3/HbHQ2RQtjSFRtHv3iWJtayuzyxqiqTd3zou1fiuXv05446jiEgaRvDZlJE28rmCLrxhENxEsy9NminIY8SjqkrNw3lLIjDxLZN44mK0cmeGrP2EBI7L5xazhg9dSR5ZSrCUzw5y25rR6iaIBQYP7P4HhH+DTdDV5zlfx1t03mkv8Ko4VPKYwE79YywSkGnakrRT9MRbtYC8wMVkLeXzdXrJVrNvNp+keSAMEuSTXnHyCx7iny2MkhGUhNryck1Ub6uKh5sTkOt4XEUXnl1BDHHziQDqzEQflG0/DfZCIrACmJ94X2jsECEfXvvo1EFD0iMx9dGWcx4sxqBC8lvwLiYAhzd2PiwVKYpgVGQx7vsjI9BTrExlb3li4Tn7MkC0bDGfgA2dv+MUkKsKGJCvb/WkQbasrRhvNpqBrcw7QCW8v2AEODR8ED3zT+Z+/UUYVeot+O/yWweTY4yEwJBkk2NrbmDhGimXDlIFIhgYDCyTp7aQZzxV7ISGXUZCyTcMIDDqO+Q4fulBNQ88fjkxXlSN3mvNsU5KTS7SFUIJ+lvWo9GJrQEGSlpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(6666004)(83380400001)(81166007)(7696005)(16526019)(26005)(316002)(15650500001)(2906002)(1076003)(36756003)(5660300002)(186003)(8676002)(82310400005)(70586007)(8936002)(86362001)(4326008)(508600001)(356005)(70206006)(36860700001)(426003)(336012)(47076005)(2616005)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 15:20:18.1326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62bf687-b4b6-480d-7c89-08da4d503977
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4928
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

