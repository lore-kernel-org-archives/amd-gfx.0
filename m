Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E6CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E75310F68C;
	Fri, 29 Apr 2022 17:48:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C7110F3A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oL8nWja77hEttSm+goNIDXOgI72gngrDBqcQOi6yi2bDr0xX9rSlLmjaQ+ihsOyP5QtyRPNaGWFzWi05KV6o40xhLoojA1npu1eAo8Ufvb/PjyGftAN4XKqeP9QMcL7d2KR6IS8ymYXbY36+e4lZAovItxbRhge4Dk9G0mt0+q3h7xpt1IjXyLdMW568p+ulIIG5RaRGMDqoPqF61TsP8PcJRvcRGqSm1n8YPYAir3FJZ6nLft5jtkY4ZRmx9fhhvpiJxpwBBE/3TnMh6DT3qmyIOkpdj39Uh9JxTS7N4lzzj7oadlL6cl7qcmM8o9hS12opycR9Hd3OaZmTvkH9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3/xI2GIyweCsA1t/aJh3g2Afo4NhZ1PaJhQQLfp2og=;
 b=QR4IHjg7zewX2nohUVRTsx3gs5Psaj/9VG5/YNVy+sQW4bKJY3mgic2xMMV/t5EYxlj8uFrsiJYsqug6YekhSPfDRauvwA0Ota+VvR8fCnItvrNfvGqOVyBqSPgka2Dn+pA4bj7Yv3Dv0qM0QEyu81SgVpN0SXfpX3Eny/z0j4rJTMsKvVGjb4d7s2L0FXEnyW6F94lrqKREOvPd4koE9KRiPGMXuxpfV7I9iUR8CSPpdrEl1itsvuPGEyQtA4q6sta0kyYOSJu+9RlBhdvY69vP8kpHLZJGqxak48FfHgX0lBQXzD58/Et04LcqHU1AY8j0Y2LhsTUd+71kNoPmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3/xI2GIyweCsA1t/aJh3g2Afo4NhZ1PaJhQQLfp2og=;
 b=F8mCsSDr0aJ2qxnZt8V4KjMula3ws4KDidffLn41g+RAJYOxVD62V/EislTuFaGsHNfDKMhV3dNECCXMM1jJeKyPJhuyh6Y24oXrpY4uDlIsb2Sb3Kn0Zp4Trhi4R5AYcwmvaO9wJByTohxybzdrN25RxGOgrpZCg36tG/mZ/Tc=
Received: from DM6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:5:1b3::25)
 by DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 29 Apr
 2022 17:47:22 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::87) by DM6PR17CA0012.outlook.office365.com
 (2603:10b6:5:1b3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 73/73] drm/amdgpu/mes: Update the doorbell function signatures
Date: Fri, 29 Apr 2022 13:46:24 -0400
Message-ID: <20220429174624.459475-74-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9dfe52e-8b31-4340-1e4a-08da2a085044
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1947729442981762A26EF2F9F7FC9@DM5PR12MB1947.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvfoxoCf+rggNhJMlkrPCn3uP2SeNVtoQDIg7AxYUhyc4foPYRlZl8uPaRm9m8KsMtM38hBHLG2/gwtv+gDzL7Gd3oCIQLZIyy2pIeCtvFeawAxKBYSxxRoMbv7w7Z69ZuQZs0MlNvS8lxCF9GlLcyZbwM9j9iHXkdv62eE2erT4+t4PtPpBNEvNiPJVrbCOojjdZ5MFDX5eBl0KLVeltUSqEcb++evjHJPQuFANNbbPqxeZ6X+OaEltmxhTC8NS4FkD1WHInJAs5PEbCJI5jx+gwiQ+Q10K7kUwWeP1q1ygF0Wn/ogpanpQsEM4WcQgd6Hwxruk1YrdnYS8JoukD3RwSzZfYn/LShJ2JbN1GDJtEeinauq+OsITR3r6pTvqt4ymmHotl1rq4hGqqY6HkebmdJLl/c6YtfcmFYuETh+pZPwTxFP43wWPiP47ovJniXAd3KzGgXPd7MuNf27cx3S/ZJgAKV8QJMldKcz2AuZpQpOITKVpG1WuwuMRaeXVDHLiCZFIW2veNBUSSLF6XAENAx7+QkguRnv+46R3O3FX0BmwwgQ6RKJyuv8cM95ZXyth+tcXI4KcRO1KKbtAgfREm4+S1i5xYPyqONHGSOlUSEvglvRyDf/CN71KnUDo/pG+GvOjNN9FznfpQSlb1nyPytgFB5oAdiC3EoMiZm2y3YNZFLcWAhUiPvl0ANhTx8bFSbGWoE1wXHQytLMi5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(16526019)(1076003)(2906002)(86362001)(26005)(7696005)(15650500001)(6916009)(82310400005)(316002)(8676002)(4326008)(36756003)(70586007)(54906003)(70206006)(508600001)(5660300002)(36860700001)(81166007)(40460700003)(47076005)(426003)(336012)(8936002)(83380400001)(356005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:22.0155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dfe52e-8b31-4340-1e4a-08da2a085044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1947
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Oak Zeng <Oak.Zeng@amd.com>, Harish
 Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Felix
 Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Update the function signatures for process doorbell allocations
with MES enabled to make them more generic. KFD would need to
access these functions to allocate/free doorbells when MES is
enabled.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Acked-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 37 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  9 ++++++
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e23c864aca11..5be30bf68b0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -29,31 +29,40 @@
 #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
 #define AMDGPU_ONE_DOORBELL_SIZE 8
 
-static int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
+int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 {
 	return roundup(AMDGPU_ONE_DOORBELL_SIZE *
 		       AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
 		       PAGE_SIZE);
 }
 
-static int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
-				      struct amdgpu_mes_process *process)
+int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
+				      unsigned int *doorbell_index)
 {
 	int r = ida_simple_get(&adev->mes.doorbell_ida, 2,
 			       adev->mes.max_doorbell_slices,
 			       GFP_KERNEL);
 	if (r > 0)
-		process->doorbell_index = r;
+		*doorbell_index = r;
 
 	return r;
 }
 
-static void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
-				      struct amdgpu_mes_process *process)
+void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
+				      unsigned int doorbell_index)
 {
-	if (process->doorbell_index)
-		ida_simple_remove(&adev->mes.doorbell_ida,
-				  process->doorbell_index);
+	if (doorbell_index)
+		ida_simple_remove(&adev->mes.doorbell_ida, doorbell_index);
+}
+
+unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
+					struct amdgpu_device *adev,
+					uint32_t doorbell_index,
+					unsigned int doorbell_id)
+{
+	return ((doorbell_index *
+		amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32) +
+		doorbell_id * 2);
 }
 
 static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
@@ -79,10 +88,8 @@ static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
 
 	set_bit(found, process->doorbell_bitmap);
 
-	*doorbell_index =
-		(process->doorbell_index *
-		 amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32) +
-		found * 2;
+	*doorbell_index = amdgpu_mes_get_doorbell_dw_offset_in_bar(adev,
+				process->doorbell_index, found);
 
 	return 0;
 }
@@ -262,7 +269,7 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 	memset(process->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
 
 	/* allocate the starting doorbell index of the process */
-	r = amdgpu_mes_alloc_process_doorbells(adev, process);
+	r = amdgpu_mes_alloc_process_doorbells(adev, &process->doorbell_index);
 	if (r < 0) {
 		DRM_ERROR("failed to allocate doorbell for process\n");
 		goto clean_up_ctx;
@@ -338,7 +345,7 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
 		kfree(gang);
 	}
 
-	amdgpu_mes_free_process_doorbells(adev, process);
+	amdgpu_mes_free_process_doorbells(adev, process->doorbell_index);
 
 	idr_remove(&adev->mes.pasid_idr, pasid);
 	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a965ace0fd0e..ba039984e431 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -270,4 +270,13 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
 
 int amdgpu_mes_self_test(struct amdgpu_device *adev);
 
+int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
+					unsigned int *doorbell_index);
+void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
+					unsigned int doorbell_index);
+unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
+					struct amdgpu_device *adev,
+					uint32_t doorbell_index,
+					unsigned int doorbell_id);
+int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev);
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

