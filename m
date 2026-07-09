Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89B6C44503
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 06:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B225E10F3D4;
	Thu,  9 Jul 2026 06:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rVm+sOYt";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1AA10F3CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 06:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsTyZiK4WDnj2M69V0EaQDfi1izIXPJLeY/e6xN4MfJYswllqyZfAlHitVamJP4vYan1QXQ5bUu+uI/pieQYG1MY+mfmX4p2IZEUeP1s3mFSIzhzynlqRVVMc6rcv8IuiD+obd/XQXOVV7ev81gilHy5GlmN2/XQKOymv++ZZFvxFxzomq//bSqArtQVCxtHl8MS/b/1RWK22nRgwS2+L+7dibaR7s6eEq7QcsX5DbTCUoaXO5lEMlH+cLe/MTAb8E3n/sRHMUpG4sbDxP2qNwc2dnFkYqOP3h2MayaVqv029kTt6mjHUBWbObWNItLSCDmWTUmMQg/ZEGt7ejplGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbPxSMQ1hxoQDPbGi/WrQLFmAAzqoPcwl23Z2tRJ6tU=;
 b=OAPXzPwzJtc/Ehip5nO0ya0hz/UioETnOJXmbHmGhaB04Asbs07Pg9keEVxsbG4dC8JQl+mvhFo5Qi3XCUMqDyfU1xh/HusIIumRMbU84cfd5DmkN4Igmk/2ZtohGkbF84zPs34MO4wh4vKnp2Y3KmvSbJ7HKxBi2gF7Az2TazVbGCRbmGBBCm9K3OLF12xt6lzdh/SHj1KzpdlpYTBAstXavYZxD81kl8qCuwc6vuEP09fZdh7G4WJ/F4hkDzhpRy9h0i1kJXHxXJpNUuV5OFofN9hx72YQi4M3UjK3Dw78iVr3M2ahtueM+0e5d6E20sWhnJfsnqtIIDmAl6ACew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbPxSMQ1hxoQDPbGi/WrQLFmAAzqoPcwl23Z2tRJ6tU=;
 b=rVm+sOYt+1x3pmCcrUFWlE7Rg/uVZD+KZMJ+XX2KyWU5NUMf22lxsTAeGR7aw02teNHBN2gBxgWp4aDqZ2GmLWlMtaJTIOvJquL9EMhv0jslEFUmQMBo2Fw1gIFlrQ5KZRIdEk1cCL3OBiTEJg+kXB+QcF75X+tXoz4gp1Kzk1c=
Received: from MW4PR04CA0084.namprd04.prod.outlook.com (2603:10b6:303:6b::29)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 06:59:12 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::99) by MW4PR04CA0084.outlook.office365.com
 (2603:10b6:303:6b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 06:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:59:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:59:08 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Michael.Chen@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/mes11: get MES process/gang contex size
Date: Thu, 9 Jul 2026 14:58:53 +0800
Message-ID: <20260709065856.472296-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709065856.472296-1-Prike.Liang@amd.com>
References: <20260709065856.472296-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: e8415828-e8da-4328-6510-08dedd87948e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|22082099003|11063799006|56012099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: zYeCl9dY9hajhFIGQY9UDEIDqCYY1fufX29jMExNkoQ0KlG8ZO2+vWPt42SLQivzK2a86C5g0x2Z3j01qj7CaFol/eopj2OnML2KSiuAWnEi4L+aAH3dwlqY7xslVe9nWoosVU0uKGvYfLlAcqVl51S64OKoE7U7DKX1CU0agLBGSTnGCJ0oPdcHn9F7J+GSX0l7Raho7H/YHBeh3yNYFZSc2WSfrRDq1pyD5rgVz8ffAuvmrVfF5byxGxaVtThzElf/NRRoaDCQg/mQfxQ8BrJeNyLGWIhjP9+bvbfGLDBz3gk5vv4kBUPXmUNVtxgl+zFHs5JpVnmREPFy1nZAVTm7hPiXN+X+AX6rvxn3KDwOJbfelkhxupYhSDsSr6/L3N5o66I8fjF24tNOzrzDIZrRDwsE5GcFSBuaYBJtWl7/vlfGIMzpJl1ltj/j94mZRD6LlotZJGEthdXnFnCwrv3d61WURKJmDLg/A86t2O6c3J/XHrltwFRr1gtVURXNTslHUm1A7VIpHvEh7vcmoK8sSsIpNzOFNDhjiFrwHO+Zq54ZE2DaemtkdQ0kxj43JbulVCQvCx8mlXq700l4UF81KO7td7ntm7o1z2Ege9xf3BpUGaaD2URFSn6SBG/4n+MIWW6u9UTBGCQTKg0V30TWB2bcbj2HiXfSk1oD3p2xKNgms7M7e0ADePk3PEf/g/151jEI8pj+gNr8qt4V7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(11063799006)(56012099006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eeXbFyvpCWc9WR7ClAQsiKDViOp3Drhmf3l0vq1ZOaIADJsFoJvI3LgconYlCb23nCcKJKHEmBgdk5cLAcOEx6tiMhgk0ahrRS9Fs7q1WRR11J445f07kaCntT115BS1fq65nISe83ZsFNlv6hKp/25ZY5RUun2gSpvx0VWAAEwTBQAYp7oL725gshYnLibpul3MXxrt2BkNd48hCBtO1Sw+3Y4Lxa6jh9dvlfk0gWgQHvIAmnF5o7ynQuUJE81tbSQecV806RtnpS0it9RoMXMMMnDp1bbpNkjBWj/i9Rt8PukzRqW2BOYCiwA8mGOl36fF2PnLBNF/3YVcJU+oWcGDVanZvFMoR9h8n4BNr/i0JQ0gOP27zIb4czAhHTLItxTG/hFbNQ/sG4AK8uH92LvSpG6JgEJXsmBmeRJhW0GS/rSlyNRD12/ML7gNHlCA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:59:11.4595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8415828-e8da-4328-6510-08dedd87948e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

Setup the MES_API_QUERY_MES__GET_CTX_ARRAY_SIZE MES firmware
command request, and get the MES11 process/gang contex size.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 79 +++++++++++++++++++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 61 ++++++++++++--
 2 files changed, 132 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c721a90051e9..195dc3b4058d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -832,6 +832,58 @@ static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
 			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
 }
 
+/**
+ * QUERY_SCHEDULER_STATUS: get proc/gang context array sizes
+ */
+static int mes_v11_0_query_ctx_array_sizes(struct amdgpu_mes *mes)
+{
+	struct amdgpu_device *adev = mes->adev;;
+	union MESAPI__QUERY_MES_STATUS mes_query_pkt;
+	int r;
+
+	if (!mes->ctx_array_size_cpu_ptr)
+		return -EINVAL;
+
+	/* Clear the output buffer */
+	mes->ctx_array_size_cpu_ptr[0] = 0;  /* proc_ctx_array_size */
+	mes->ctx_array_size_cpu_ptr[1] = 0;  /* gang_ctx_array_size */
+
+	memset(&mes_query_pkt, 0, sizeof(mes_query_pkt));
+
+	mes_query_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_query_pkt.header.opcode = MES_SCH_API_QUERY_SCHEDULER_STATUS;
+	mes_query_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_query_pkt.subopcode = MES_API_QUERY_MES__GET_CTX_ARRAY_SIZE;
+
+	/*
+	 * MES FW will write the array sizes to these GPU addresses:
+	 *   proc_ctx_array_size_addr -> uint32_t N (e.g., 50)
+	 *   gang_ctx_array_size_addr -> uint32_t M (e.g., 300)
+	 */
+	mes_query_pkt.ctx_array_size.proc_ctx_array_size_addr =
+		mes->ctx_array_size_gpu_addr;
+	mes_query_pkt.ctx_array_size.gang_ctx_array_size_addr =
+		mes->ctx_array_size_gpu_addr + sizeof(uint32_t);
+
+	mes_query_pkt.api_status.api_completion_fence_addr =
+		mes->ring[0].fence_drv.gpu_addr;
+	mes_query_pkt.api_status.api_completion_fence_value =
+		++mes->ring[0].fence_drv.sync_seq;
+
+	r = mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_query_pkt, sizeof(mes_query_pkt),
+			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
+	if (r) {
+		dev_err(adev->dev,
+			"MES QUERY_SCHEDULER_STATUS (GET_CTX_ARRAY_SIZE) failed, r=%d\n", r);
+		return r;
+	}
+
+	/* MES has written the sizes - now set up bitmaps */
+	return amdgpu_mes_rs64mem_setup_bitmaps(mes);
+}
+
 static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 			     struct mes_misc_op_input *input)
 {
@@ -1907,10 +1959,33 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
+	/* Allocate GPU buffer for array size query results */
+	r = amdgpu_mes_rs64mem_init(&adev->mes);
+	if (r)
+		dev_warn(adev->dev,
+			 "RS64 local memory init failed (%d), "
+			 "falling back to system memory path\n", r);
+
 	r = mes_v11_0_set_hw_resources(&adev->mes);
+
 	if (r)
 		goto failure;
 
+	/*
+	 * QUERY_SCHEDULER_STATUS to get array sizes (N, M).
+	 * MES writes the sizes to the GPU buffer, then we allocate bitmaps.
+	 */
+	if (adev->mes.use_rs64mem) {
+		r = mes_v11_0_query_ctx_array_sizes(&adev->mes);
+		if (r) {
+			dev_warn(adev->dev,
+				 "Failed to query ctx array sizes (%d), "
+				 "disabling RS64 local memory\n", r);
+			/* Continue without optimization - not fatal */
+		}
+	}
+
+
 	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x52) {
 		r = mes_v11_0_set_hw_resources_1(&adev->mes);
 		if (r) {
@@ -1948,6 +2023,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (adev->mes.use_rs64mem)
+		amdgpu_mes_rs64mem_fini(&adev->mes);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index b06412ac8583..dfc27be4454d 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -329,6 +329,7 @@ union MESAPI__ADD_QUEUE {
 		uint32_t                    pipe_id;
 		uint32_t                    queue_id;
 		uint32_t                    alignment_mode_setting;
+		uint32_t                    full_sh_mem_config_data;
 		uint64_t                    unmap_flag_addr;
 	};
 
@@ -358,6 +359,7 @@ union MESAPI__REMOVE_QUEUE {
 		uint32_t                    tf_data;
 
 		enum MES_QUEUE_TYPE         queue_type;
+		uint64_t                    timestamp;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -516,14 +518,57 @@ union MESAPI__SET_LOGGING_BUFFER {
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
-union MESAPI__QUERY_MES_STATUS {
-	struct {
-		union MES_API_HEADER	header;
-		bool			mes_healthy; /* 0 - not healthy, 1 - healthy */
-		struct MES_API_STATUS	api_status;
-	};
-
-	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+enum MES_API_QUERY_MES_OPCODE
+{
+    MES_API_QUERY_MES__GET_CTX_ARRAY_SIZE,
+    MES_API_QUERY_MES__GET_CAPS = MES_API_QUERY_MES__GET_CTX_ARRAY_SIZE,
+    MES_API_QUERY_MES__CHECK_HEALTHY,
+    MES_API_QUERY_MES__MAX,
+};
+
+enum { QUERY_MES_MAX_SIZE_IN_DWORDS = 20 };
+
+/**
+ * Obsolete
+ * to be removed once KMD stopped refering to it.
+ * use MES_API_QUERY_MES__CAPS instead
+*/
+struct MES_API_QUERY_MES__CTX_ARRAY_SIZE
+{
+    uint64_t    proc_ctx_array_size_addr;
+    uint64_t    gang_ctx_array_size_addr;
+};
+
+struct MES_API_QUERY_MES__HEALTHY_CHECK
+{
+    uint64_t    healthy_addr;
+};
+
+struct MES_API_QUERY_MES__CAPS
+{
+    uint64_t    proc_ctx_array_size_addr;
+    uint64_t    gang_ctx_array_size_addr;
+    uint64_t    features_enablement_addr;
+};
+
+union MESAPI__QUERY_MES_STATUS
+{
+    struct
+    {
+        union MES_API_HEADER            header;
+        enum MES_API_QUERY_MES_OPCODE   subopcode;
+        struct MES_API_STATUS           api_status;
+        uint64_t                        timestamp;
+        union
+        {
+            struct MES_API_QUERY_MES__CTX_ARRAY_SIZE    ctx_array_size;
+            struct MES_API_QUERY_MES__CAPS              caps;
+            struct MES_API_QUERY_MES__HEALTHY_CHECK     healthy_check;
+            uint32_t data[QUERY_MES_MAX_SIZE_IN_DWORDS];
+        };
+    };
+
+    uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
 union MESAPI__PROGRAM_GDS {
-- 
2.34.1

