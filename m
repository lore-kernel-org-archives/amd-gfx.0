Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD01F9D0F3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A4910E679;
	Tue, 14 Apr 2026 19:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ln6aHuMb";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED89210E670
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erUwqpdThyMWRUfXAK5UgcAdLLb8VJGNtY7oJ2OoolzgEOORVXelrH9fu75WNwEpE4JwBRf1SLAKgJPqy5WP9/wl46N9BtE0nEzKbjjXapR4At9pQ45F2vmJsquxsuDUx/1tFYUk3iGt16bY0+ZH45QgkSKosSsaAFJflLIxD5dY2I8X+xPHwzA0yqt50Bpzlefft4ysUYXdOJfmbOMdHihK5+KVrEvweJC90T+1IjJDMOvh0UKsL8vxi4iaG+gces1m+5GbaBRlEDyn6UWQIxwN+MfZxIMm2nHDTGuD8bV799nar+UczAzaIpfGxYMN2NXdeNeM4UBpH55y3cLGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/Bjtzs5Eld7MK+f9cbMa9asVIWClAvRopMzHyOfFYw=;
 b=r5jNL+MHaURGDd32FUq1wD9Qy6uFhMrMfsWss/YMAdbodsiRfhkPPSU+GyFsUfgspFOnB3zIhhgaYsiwbAIoMdd74y6dL1rWeswKwj/eWwy3SHSRmUoHBe+0eQTp68DKdGok1p0htVqJZzrlCL43E5TcI2n48JJezRn/vXC1BxuQz4HYI/+T+DMy9ZvGeJNo1U+f41h7emN7cr2dh2/Uaw0ob+FZrtLlmX+IlD8aoy0JV6qrA1cERL38xOURRDNDVmzzlGyXNq5TXIEV0k2HVybjLKamPqCi5zaiioE/sxD1muC8MnYlFhKo0ZgcQljxQHmAD+gpnufDsVvOErmsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/Bjtzs5Eld7MK+f9cbMa9asVIWClAvRopMzHyOfFYw=;
 b=ln6aHuMb1dYruQI4kWMOqVwkeG2qRuOm7tDunL65w8q5rEI3HgDg2eoX8czQG2obohpIULUfdbizkN7mWiQ8EAe7JoF++F0YDVDNpv9G0K0una95WQjUSTOBlLaZBQUXS0fo/tb47BlvyKFP/SEkwb2HzaI/RUdKEKIVO650Pek=
Received: from DM6PR07CA0104.namprd07.prod.outlook.com (2603:10b6:5:330::30)
 by CH1PPF8423FDA82.namprd12.prod.outlook.com (2603:10b6:61f:fc00::617) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:48:31 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::71) by DM6PR07CA0104.outlook.office365.com
 (2603:10b6:5:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 19:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:48:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:48:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:48:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:48:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>, Michael Chen <michael.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Move get mes version info to the end of
 set_hw_resource
Date: Tue, 14 Apr 2026 15:48:16 -0400
Message-ID: <20260414194817.2213993-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414194817.2213993-1-alexander.deucher@amd.com>
References: <20260414194817.2213993-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH1PPF8423FDA82:EE_
X-MS-Office365-Filtering-Correlation-Id: 66170574-7387-49d6-3437-08de9a5ece20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: eE3OYwFMFKsDoadJMwGuVjxCrSKdVn7d+cAwRfJJWXhq8MttauoHC8whnfn1oFhrDcQDqjUwaq0AZ03Rrvjdkfja7+Ks7Js703lp6BK4QXKIF9L6hm0RFKDXfwtsGRVh3EM+1wvVGutUcgwFEu0MIfyVYlUXTtPvExPKZOQhOp4Y+CEd7QTByC3PZyySZ0LtsWR4Ks/hQjmFFgvK9Sa0el2G07/2zkB6wXAI79xHjO5JXb7WN54+jUhtVeZ5xHJEMzXL4DJZmcGRXtCUFZtCterlkiPCUbwLX5rTuFkT2cy/yjAH+ru815f4Ah0Znv8V1zGYVNk1JdnePZ351KsIEtEIwxHmULnQ/dR8UvlHHyMfMNMTcBezyBqM9PMIZ6KVnleJTPuNnWJZce56AzpZqtfoKjXm/lHHBZAxJcMOBPKQqdq84csYq4ZMlG2pGYEtqhlyHTWt8HBDkRmWnS8dvJ5F8+thXn2mbAOlY5IxQ3qU8EOvxpT7N2mhHragzWuxl4BVpNzBNjEBVc0l9TLLAS6ZvCz9nG9lNL69R+vosv3+icznjZhwF2bfIDdp803VaclgSECz7LqU/QXXpMPWBESZyqQ5E6w8RxlQ9jbo+eZPI3DI9CfZrMyd3FYDfsul3nEVRpllm15tDbY7nUir08auqzSW1JG9oj33B3J7azo41HTCjJ92jMi14Dfm0yZS3BqhDe+iEHlyi2B83V0of0J/cMS5fyNu7r2jZXbWI/83SpHJ7uqGECloDuqoWsoqAGNyPiq5SJgfGtheC1gnww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pv2gwRRaTBH3rvq/pTiRqbXhkNT9CBdACwT0cJpjXz1b4j3+U/7vQf13a8RmS+Gs/XoEkMK/qq1/NzzhhwVFZqK3sk8RZ5NdS493puEMxCg7ZfNtoyUi0NFMUIKBsIcFC72PlltUwcu9WHrvfR/KdUqiog4ZHE74JcbRY03w3tkQCnwAzRrFmpD/Wz+JRpa0ZqTuv+X1nUTXPS3zQo8aiKoapedtIc7BnR7pBFvLOsrp3njetLUyYd+9T5DKmSWNYziZRj3PM3IJ/iQeyxer7CsC4v+SqpaOGgum0YvT58rvYwoFHf84fhaHF4sSOWFFzals6vjfJtdsvAYRO+e4WmI9peAwjZHJ+XGxr9XJY1UvMgrA8lnrQRWVEBF2wuFbGg38qT+QoEzeAQ+2jYzsAhX06GH7pUA/Y9w2MdMFL3grbcVsnW7O1fmbtJUTtXWn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:48:30.8186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66170574-7387-49d6-3437-08de9a5ece20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF8423FDA82
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

After init mes queue, it require some time for mes to execute init
code including setup version info in CP_MES_GP3 register. Put it after
first MES call(set_hw_resource package).

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 32 ++++++++++++++------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 3023cf6ab1ba5..d87ec61cac88b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -626,7 +626,7 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 	   to distribute some tasks on individual XCCs*/
 	if (mes->enable_coop_mode &&
 	    ((pipe == AMDGPU_MES_SCHED_PIPE) ||
-	    ((mes->sched_version & AMDGPU_MES_VERSION_MASK) >= 0x74))) {
+	    ((mes->kiq_version & AMDGPU_MES_VERSION_MASK) >= 0x74))) {
 		master_xcc_id = mes->master_xcc_ids[inst];
 		mes_set_hw_res_1_pkt.mes_coop_mode = 1;
 		mes_set_hw_res_1_pkt.coop_sch_shared_mc_addr =
@@ -641,7 +641,7 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_mes *mes,
 static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 					int pipe, int xcc_id)
 {
-	int i;
+	int i, status;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
 
@@ -711,9 +711,23 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 	if (adev->enforce_isolation[0] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
 		mes_set_hw_res_pkt.limit_single_process = 1;
 
-	return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, pipe,
+	status = mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, pipe,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
+
+	/* get MES scheduler versions */
+	mutex_lock(&adev->srbm_mutex);
+	soc_v1_0_grbm_select(adev, 3, pipe, 0, 0, GET_INST(GC, xcc_id));
+
+	if (pipe == AMDGPU_MES_SCHED_PIPE)
+		adev->mes.sched_version = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES_GP3_LO);
+	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
+		adev->mes.kiq_version = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES_GP3_LO);
+
+	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
+	mutex_unlock(&adev->srbm_mutex);
+
+	return status;
 }
 
 static void mes_v12_1_init_aggregated_doorbell(struct amdgpu_mes *mes,
@@ -1398,18 +1412,6 @@ static int mes_v12_1_queue_init(struct amdgpu_device *adev,
 		mes_v12_1_queue_init_register(ring, xcc_id);
 	}
 
-	/* get MES scheduler/KIQ versions */
-	mutex_lock(&adev->srbm_mutex);
-	soc_v1_0_grbm_select(adev, 3, pipe, 0, 0, GET_INST(GC, xcc_id));
-
-	if (pipe == AMDGPU_MES_SCHED_PIPE)
-		adev->mes.sched_version = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES_GP3_LO);
-	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
-		adev->mes.kiq_version = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES_GP3_LO);
-
-	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
-	mutex_unlock(&adev->srbm_mutex);
-
 	return 0;
 }
 
-- 
2.53.0

