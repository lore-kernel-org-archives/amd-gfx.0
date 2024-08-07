Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C96C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 09:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B497110E4B4;
	Wed,  7 Aug 2024 09:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vE7iXmaX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C9F10E4B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 09:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeQKQL87tM7S+jY3vE/SosZm5tfUh6MWFAnrp3GgdjwpkNzq7mU+tHftI96wFmun+L6yqrpzknuIFOUjxpKVYs6zgVaUIEbbJw2kONf4094EYprDSZ9XOqN0ZbWcRn4+hg7A8DtQXSel7DRhyVdp4G6l+59H8YeZDxD9K+2kmn1UNyMobksR1sqrY79UWCy8H41nc5M/lB60UyLwBcuzNwVqSnKNmgSLYMooSjhrGbJOUsHoVdJUT3FhsBzINhiru8BH/cO7MmhsNJDG49wpjocGk2liOM/PYp08qvwc/c1pjbM9mpqf8lmzBdyt2FwhDui0klzHdpOL4iGwMBuOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfwzQZKNVRxDQ9SV+9xKMl2aq8936Yk/61kVGXahRts=;
 b=klC/6guYe3b9YV0J/if81h0r7EFNnpF6f51gvcPl3eyRF86NgBVr7jGxzb4m25Xa3b7GKbk3wWskL8u32o6omNR29qCcxK3lQg+1Ap9bMmRJpfrbWuNfYMDIcV/Oh5MN26OzWZzM4DoLTNReX19bi5a5RMSPytJDi+Jjy75yafBjlZq/BYNg/V8VCzXqvZiZv+PEcwlrZ+RMGfpwM2P4R23j3SNSZTs6HHl9EFwNNjdb4pLqaDSy7MwAT1ZdUcaIINflKkJVv4ZASeO+8fQvcp+KvCP0fyaMZsbo30fJ7lX6fJmzdKQ18hUSJcgGo86puEg8uTcJOQBHFEgTPvDciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfwzQZKNVRxDQ9SV+9xKMl2aq8936Yk/61kVGXahRts=;
 b=vE7iXmaXz44NIaHv3NVmEvAiyskf5kVfsxB6TV467o691ichvwmx2YNgF/+VvTZnjs63mcJKeoo4bUKViAK33YYWCAJmPAKQKV8rsvGincdV/lyS5TM7c+bRFlupHAXT/f7OH5QLIXpwWDj5+1Z367AQsvDkJqGydR+luUY7858=
Received: from CH0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:610:e5::35)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 7 Aug
 2024 09:39:18 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::8) by CH0PR03CA0270.outlook.office365.com
 (2603:10b6:610:e5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 09:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 09:39:18 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 04:39:16 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 6/8] drm/amdgpu/mes12: configure tow pipes hardware resources
Date: Wed, 7 Aug 2024 17:38:45 +0800
Message-ID: <20240807093847.2084710-7-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240807093847.2084710-1-Jack.Xiao@amd.com>
References: <20240807093847.2084710-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6c3bbc-2817-4011-aec1-08dcb6c4cef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tWc22MxR3vZ54d5pjaLvu/JXt9GR1qMK+vf/2HlesDEkZ1oEUlHRUxUUCcoS?=
 =?us-ascii?Q?avwkpu+wB1FulZvKagVi4JsA4B6Gr5qHWF5eiHPtT2o5pS1XiHWdeTPQW/Yt?=
 =?us-ascii?Q?Z3hLoxFHcFnFvFPKJ+EXAFtai8e3pkD8sLWlsMblvxpfFS/TnNW300zRQiUW?=
 =?us-ascii?Q?7TCyDoKLqiuxECd5AnVAswfFQtlmSspG294J1THZIIY/cXp+CeNney+PApUP?=
 =?us-ascii?Q?TrMVIRjWusXDxielLH1XuhV3tpjg+Udt0OWjoTXv7X6tqZtcUx/bE+X2Di0V?=
 =?us-ascii?Q?oY1bjB//XtkcHtqI0FfSY31Vfe565xzuoQxLx5KHgHr/cOmusnXoXhcVyAzB?=
 =?us-ascii?Q?tqP/kSsVPxI8LAl+31IUnlgQoHNOPm5CPwSjQSYckLBUDGcy+15ote6969hm?=
 =?us-ascii?Q?zHRHoSXGjBXKxuGe8PnOLEClcU3lzaZNnPcYPDI5Yyv/gMikl2GK8ruPjVqm?=
 =?us-ascii?Q?j9jvD83tlKZOkLio9+1xeJQJTqDlsWmzUrrETFwMYIgraU74FaHgeGx8oSd8?=
 =?us-ascii?Q?WxG1AJcowrfreim67ELyITqj+JdLU7Pnov2BRyqYHxlhEiq0BOZGALov3lij?=
 =?us-ascii?Q?0qBCZtBSgaPAX4wT0fDGStgn0ElCOKB+Pkz0Kk3fYEEC7Yntin7eC8K5WlUu?=
 =?us-ascii?Q?cOaZ2gldqtRiK02u2/hfIxk//WL4Do/IFl03+uBFV4c8mP8NK7T6Zy/iwzX3?=
 =?us-ascii?Q?tND7AeQ0IkZr9NN09ROkZtHZeWd3OFsPtcpuKUx4qXsDjXZS2UveWad+gE//?=
 =?us-ascii?Q?e/Ogl9mziEejNzp9uG9z/hwTu0Fgvn72dqPNV+4a30OrtRLK7J20Z9+iZDH7?=
 =?us-ascii?Q?DLWWcODrJwruZ0tz7ReA7ViNu+fI3Xs4+vZSPdS65bd0xkIKb7jv4tg8HA3H?=
 =?us-ascii?Q?0SGuOCMvvFm6ifYkU17lJL3eRHYFOWL4AlK26DQUAtzPw34r9aKEARqJCJJD?=
 =?us-ascii?Q?I4+c6TWjEh2A2CWqw8yHPffSo3WAWIpY5ZOSU2/04cR0NhI4FnCe6qBqK6XT?=
 =?us-ascii?Q?kjZmzmFGDNc7J9Fjb2DRdkzsbUC3MUoPyIvpVqyYZ+Oai67L0WU+at5dwiEf?=
 =?us-ascii?Q?9wDE2DDSwVMCmv0WG4/qvAk17yzWbi5QukZo9aU56LJV/SpEj/TEbzRqv58y?=
 =?us-ascii?Q?kX57eFEUklH8RBt3Cu7ZfxcqJHT5hgMgwiUWCC3trooP5EI1ySiK//FXVpY7?=
 =?us-ascii?Q?ZeLRx1c2B15GPs5apx5Qa3EiKHR36db/LBTW56YkQG2QBN1hfvVcsqinh7x4?=
 =?us-ascii?Q?y+eKVCcnUmJWfkXpZpOnikNqBU2eV4MHidwowPrPiXPv3BDuca03S5aoesMC?=
 =?us-ascii?Q?RK7mKP5VG5zvR2/hAGoKZNO+70luJhGErSb+6V42ILApcyngXs3Vcq4J/np5?=
 =?us-ascii?Q?xCh5URhtZJBt3aN0u5/N46NlUd89H62pIkBHw17IqbVBQTUJ9j9RWj30QDwZ?=
 =?us-ascii?Q?IZqSVp4ZF19IN7GSwH9lKMaCLWhuZS2E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:39:18.0530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6c3bbc-2817-4011-aec1-08dcb6c4cef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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

Configure tow pipes with different hardware resources.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 77 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 12 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  7 +--
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 49 ++++++++--------
 4 files changed, 81 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 52277129ea5d..f2310075545b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -165,36 +165,38 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			adev->mes.sdma_hqd_mask[i] = 0xfc;
 	}
 
-	r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs);
-	if (r) {
-		dev_err(adev->dev,
-			"(%d) ring trail_fence_offs wb alloc failed\n", r);
-		goto error_ids;
-	}
-	adev->mes.sch_ctx_gpu_addr =
-		adev->wb.gpu_addr + (adev->mes.sch_ctx_offs * 4);
-	adev->mes.sch_ctx_ptr =
-		(uint64_t *)&adev->wb.wb[adev->mes.sch_ctx_offs];
+	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
+		r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs[i]);
+		if (r) {
+			dev_err(adev->dev,
+				"(%d) ring trail_fence_offs wb alloc failed\n",
+				r);
+			goto error;
+		}
+		adev->mes.sch_ctx_gpu_addr[i] =
+			adev->wb.gpu_addr + (adev->mes.sch_ctx_offs[i] * 4);
+		adev->mes.sch_ctx_ptr[i] =
+			(uint64_t *)&adev->wb.wb[adev->mes.sch_ctx_offs[i]];
 
-	r = amdgpu_device_wb_get(adev, &adev->mes.query_status_fence_offs);
-	if (r) {
-		amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
-		dev_err(adev->dev,
-			"(%d) query_status_fence_offs wb alloc failed\n", r);
-		goto error_ids;
+		r = amdgpu_device_wb_get(adev,
+				 &adev->mes.query_status_fence_offs[i]);
+		if (r) {
+			dev_err(adev->dev,
+			      "(%d) query_status_fence_offs wb alloc failed\n",
+			      r);
+			goto error;
+		}
+		adev->mes.query_status_fence_gpu_addr[i] = adev->wb.gpu_addr +
+			(adev->mes.query_status_fence_offs[i] * 4);
+		adev->mes.query_status_fence_ptr[i] =
+			(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs[i]];
 	}
-	adev->mes.query_status_fence_gpu_addr =
-		adev->wb.gpu_addr + (adev->mes.query_status_fence_offs * 4);
-	adev->mes.query_status_fence_ptr =
-		(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs];
 
 	r = amdgpu_device_wb_get(adev, &adev->mes.read_val_offs);
 	if (r) {
-		amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
-		amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
 		dev_err(adev->dev,
 			"(%d) read_val_offs alloc failed\n", r);
-		goto error_ids;
+		goto error;
 	}
 	adev->mes.read_val_gpu_addr =
 		adev->wb.gpu_addr + (adev->mes.read_val_offs * 4);
@@ -214,10 +216,16 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 error_doorbell:
 	amdgpu_mes_doorbell_free(adev);
 error:
-	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
-	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
-	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
-error_ids:
+	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
+		if (adev->mes.sch_ctx_ptr[i])
+			amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs[i]);
+		if (adev->mes.query_status_fence_ptr[i])
+			amdgpu_device_wb_free(adev,
+				      adev->mes.query_status_fence_offs[i]);
+	}
+	if (adev->mes.read_val_ptr)
+		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
+
 	idr_destroy(&adev->mes.pasid_idr);
 	idr_destroy(&adev->mes.gang_id_idr);
 	idr_destroy(&adev->mes.queue_id_idr);
@@ -228,13 +236,22 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 void amdgpu_mes_fini(struct amdgpu_device *adev)
 {
+	int i;
+
 	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
 			      &adev->mes.event_log_gpu_addr,
 			      &adev->mes.event_log_cpu_addr);
 
-	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
-	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
-	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
+	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
+		if (adev->mes.sch_ctx_ptr[i])
+			amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs[i]);
+		if (adev->mes.query_status_fence_ptr[i])
+			amdgpu_device_wb_free(adev,
+				      adev->mes.query_status_fence_offs[i]);
+	}
+	if (adev->mes.read_val_ptr)
+		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
+
 	amdgpu_mes_doorbell_free(adev);
 
 	idr_destroy(&adev->mes.pasid_idr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e7915a24dfdd..c5fe404d4e12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -113,12 +113,12 @@ struct amdgpu_mes {
 	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
 	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
 	uint32_t                        aggregated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
-	uint32_t                        sch_ctx_offs;
-	uint64_t			sch_ctx_gpu_addr;
-	uint64_t			*sch_ctx_ptr;
-	uint32_t			query_status_fence_offs;
-	uint64_t			query_status_fence_gpu_addr;
-	uint64_t			*query_status_fence_ptr;
+	uint32_t                        sch_ctx_offs[AMDGPU_MAX_MES_PIPES];
+	uint64_t			sch_ctx_gpu_addr[AMDGPU_MAX_MES_PIPES];
+	uint64_t			*sch_ctx_ptr[AMDGPU_MAX_MES_PIPES];
+	uint32_t			query_status_fence_offs[AMDGPU_MAX_MES_PIPES];
+	uint64_t			query_status_fence_gpu_addr[AMDGPU_MAX_MES_PIPES];
+	uint64_t			*query_status_fence_ptr[AMDGPU_MAX_MES_PIPES];
 	uint32_t                        read_val_offs;
 	uint64_t			read_val_gpu_addr;
 	uint32_t			*read_val_ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3d103a5ca184..1b7e1faaa421 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -522,9 +522,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
 	mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
 	mes_set_hw_res_pkt.paging_vmid = 0;
-	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr;
+	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr[0];
 	mes_set_hw_res_pkt.query_status_fence_gpu_mc_ptr =
-		mes->query_status_fence_gpu_addr;
+		mes->query_status_fence_gpu_addr[0];
 
 	for (i = 0; i < MAX_COMPUTE_PIPES; i++)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
@@ -1208,9 +1208,6 @@ static int mes_v11_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int pipe;
 
-	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
-	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
-
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		kfree(adev->mes.mqd_backup[pipe]);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 4218ac7d4372..aa56034f9e65 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -542,27 +542,33 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 
-	mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
-	mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
-	mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
-	mes_set_hw_res_pkt.paging_vmid = 0;
-	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr;
-	mes_set_hw_res_pkt.query_status_fence_gpu_mc_ptr =
-		mes->query_status_fence_gpu_addr;
-
-	for (i = 0; i < MAX_COMPUTE_PIPES; i++)
-		mes_set_hw_res_pkt.compute_hqd_mask[i] =
-			mes->compute_hqd_mask[i];
-
-	for (i = 0; i < MAX_GFX_PIPES; i++)
-		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
-
-	for (i = 0; i < MAX_SDMA_PIPES; i++)
-		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
+	if (pipe == AMDGPU_MES_SCHED_PIPE) {
+		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
+		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
+		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
+		mes_set_hw_res_pkt.paging_vmid = 0;
+
+		for (i = 0; i < MAX_COMPUTE_PIPES; i++)
+			mes_set_hw_res_pkt.compute_hqd_mask[i] =
+				mes->compute_hqd_mask[i];
+
+		for (i = 0; i < MAX_GFX_PIPES; i++)
+			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+				mes->gfx_hqd_mask[i];
+
+		for (i = 0; i < MAX_SDMA_PIPES; i++)
+			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
+				mes->sdma_hqd_mask[i];
+
+		for (i = 0; i < AMD_PRIORITY_NUM_LEVELS; i++)
+			mes_set_hw_res_pkt.aggregated_doorbells[i] =
+				mes->aggregated_doorbells[i];
+	}
 
-	for (i = 0; i < AMD_PRIORITY_NUM_LEVELS; i++)
-		mes_set_hw_res_pkt.aggregated_doorbells[i] =
-			mes->aggregated_doorbells[i];
+	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr =
+		mes->sch_ctx_gpu_addr[pipe];
+	mes_set_hw_res_pkt.query_status_fence_gpu_mc_ptr =
+		mes->query_status_fence_gpu_addr[pipe];
 
 	for (i = 0; i < 5; i++) {
 		mes_set_hw_res_pkt.gc_base[i] = adev->reg_offset[GC_HWIP][0][i];
@@ -1288,9 +1294,6 @@ static int mes_v12_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int pipe;
 
-	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
-	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
-
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		kfree(adev->mes.mqd_backup[pipe]);
 
-- 
2.41.0

