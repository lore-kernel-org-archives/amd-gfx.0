Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DA1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5E510F24D;
	Fri, 29 Apr 2022 17:47:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6EB110F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXPsUtHM8DHYcZdaC4YaCIqB56QcrfsR/o4ZbbBKQtrHHepSXErigmNtKcXkDUCHTTXbXc5JAqcXMsRrMLIOC+CR1Y/nR0fqf+NBLrMeNy0k8KbLTRfV1GRq/wmDdVTqCY2+q/TW9olKpoH9YNExVUCA/+CwUGX9RoW9OyCaMWRGGF8SSt1DnaNjGVYpC1oERru7/0QPAmDI41bYRLQUlq+/FetSJlCtxNWfx+TStk1UrWM6DaGgMW2r3OGdRRNHnv6hh28au1gOhD9QwHmV/GHd00N5TP/IGMcufGdRQOI1i/01qW5oVdgg1Xc+9FFbxDaH623xdt7bQzHCmO35Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsWtiQNE25HQ+srXLpDF6fTtIiyY21GI0+vLkAVwB+4=;
 b=QBV0HdNygooDatx/WhrpvHEkgvYOwnVZeyRrW4yegux3FHCPETqoLg6smMfHveqGlLbwAOJD+Lc4mxpD5LXFKxnYRCBd6mcVhg7BCwB4SCczt1eg0fQc6ea2DzPTxRPfWWsPirOimUinrqri4V9rS9GdzVun4t9u8221P9RRKzvMb0yt4VQSsXAdeSqT0hECq5hGYPulHy5olRuwuc7D8kFAXt4gT2ZgeeosE1oNVoMihJ6hYencT1uUvdk1UvxaOHLZ3fQ/B2YbH9ar76/Xzji5kCTEuE0y8hmhX4CRjGOK4oTqzcClk/zPsOssBrT1Hcyu9IGSMgJXQP95Iurvow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsWtiQNE25HQ+srXLpDF6fTtIiyY21GI0+vLkAVwB+4=;
 b=NJO8MojeJFA/9/m3spmsT4jSHs86wIGwBNMeQZgBNKSix7OJCQU/RmQC8JY5yy5fnP/ffGJbaYIrfplde4gJJSxUZrCGJN8LUXgZ81qZSFtR45d2kehcxY4Jvitaha4SZNvODOo2mNO0lxeR+6YJZ7Bmi++kr3ZfKpAti822pa4=
Received: from DM6PR02CA0101.namprd02.prod.outlook.com (2603:10b6:5:1f4::42)
 by SN6PR12MB4672.namprd12.prod.outlook.com (2603:10b6:805:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 29 Apr
 2022 17:47:06 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::1e) by DM6PR02CA0101.outlook.office365.com
 (2603:10b6:5:1f4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 46/73] drm/amdgpu/mes: implement creating mes process v2
Date: Fri, 29 Apr 2022 13:45:57 -0400
Message-ID: <20220429174624.459475-47-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f585ee6-b12a-4bf2-7bb0-08da2a0846f9
X-MS-TrafficTypeDiagnostic: SN6PR12MB4672:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB46724D44DD4DAFE15D59E549F7FC9@SN6PR12MB4672.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hiEbr166681HNVkegyAEPuDemZqGcqWzQfNfPdXeMj9pX7l1WQ/ScVPOi9xuRYCev3SB2MBHbknIDNYfb7hkc8hWUgIcF8IXuQywB+n2QUhwKzb58JPhyfXkUP/xRRQAMOSQBwtwlANwj5eEJfKd+lEw7VpjIiXeHZKN8Ge6WzwYQqNfn7eLLApsK5Ii5hvror4yxg1W0sFqdP5OHY2ohLKUfNtYvEEYQFerKI+944nz8P45AqDsEj10sODMs+WoUCgfmNsWpZtsknGnuL5q/bjUI4Rs3W5VcsKMD9YoVaoU8C2mEtnusas4GrgU4AJCqisbKIA/MzsN264p4orrhf+HQIerrphprfVqStFrsZqqi3uq4NXrSj9ynZZcI/rhxTq+Qn/W6iy8VimOiRYLXRrnf5o4OcFuGUGo8CGutmFsX96d9+gaKO2RPBgHBMPcpUQU9iT3xUDC09iM8MhCiLIb1/bBXfJ+dDxseqSSRvoM/+OgaCONCnG0VdI3EkKfDUGE4Ly+LINwjjA7T721ENc3kVSnjUL2SpppI3s+8riaOqcbAEEdJM8FOyrzosruuOXA/Jf00fyv/MQYzGul9zyXVm/jxBY0cb/Vb7hHvlrUrPELDE/IPYiVITctaEQ4B2YodXprl8DwpT49n4utGMtQubEPXqgrAzVhG6LjkUaH6W3gIv3TjbtqiaxB0eu1jzt0fboocFB1DGainjknrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(70206006)(70586007)(36756003)(86362001)(508600001)(54906003)(8676002)(7696005)(6666004)(40460700003)(66574015)(6916009)(336012)(316002)(1076003)(186003)(8936002)(26005)(16526019)(83380400001)(426003)(2616005)(356005)(5660300002)(36860700001)(82310400005)(81166007)(2906002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:06.4113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f585ee6-b12a-4bf2-7bb0-08da2a0846f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4672
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Create a mes process which contains process-related resources,
like vm, doorbell bitmap, process ctx bo and etc.

v2: move the simple variable to the end

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 77 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +
 2 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index a988c232b4a3..55005a594be1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -214,3 +214,80 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	ida_destroy(&adev->mes.doorbell_ida);
 	mutex_destroy(&adev->mes.mutex);
 }
+
+int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
+			      struct amdgpu_vm *vm)
+{
+	struct amdgpu_mes_process *process;
+	int r;
+
+	mutex_lock(&adev->mes.mutex);
+
+	/* allocate the mes process buffer */
+	process = kzalloc(sizeof(struct amdgpu_mes_process), GFP_KERNEL);
+	if (!process) {
+		DRM_ERROR("no more memory to create mes process\n");
+		mutex_unlock(&adev->mes.mutex);
+		return -ENOMEM;
+	}
+
+	process->doorbell_bitmap =
+		kzalloc(DIV_ROUND_UP(AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
+				     BITS_PER_BYTE), GFP_KERNEL);
+	if (!process->doorbell_bitmap) {
+		DRM_ERROR("failed to allocate doorbell bitmap\n");
+		kfree(process);
+		mutex_unlock(&adev->mes.mutex);
+		return -ENOMEM;
+	}
+
+	/* add the mes process to idr list */
+	r = idr_alloc(&adev->mes.pasid_idr, process, pasid, pasid + 1,
+		      GFP_KERNEL);
+	if (r < 0) {
+		DRM_ERROR("failed to lock pasid=%d\n", pasid);
+		goto clean_up_memory;
+	}
+
+	/* allocate the process context bo and map it */
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_PROC_CTX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &process->proc_ctx_bo,
+				    &process->proc_ctx_gpu_addr,
+				    &process->proc_ctx_cpu_ptr);
+	if (r) {
+		DRM_ERROR("failed to allocate process context bo\n");
+		goto clean_up_pasid;
+	}
+	memset(process->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+
+	/* allocate the starting doorbell index of the process */
+	r = amdgpu_mes_alloc_process_doorbells(adev, process);
+	if (r < 0) {
+		DRM_ERROR("failed to allocate doorbell for process\n");
+		goto clean_up_ctx;
+	}
+
+	DRM_DEBUG("process doorbell index = %d\n", process->doorbell_index);
+
+	INIT_LIST_HEAD(&process->gang_list);
+	process->vm = vm;
+	process->pasid = pasid;
+	process->process_quantum = adev->mes.default_process_quantum;
+	process->pd_gpu_addr = amdgpu_bo_gpu_offset(vm->root.bo);
+
+	mutex_unlock(&adev->mes.mutex);
+	return 0;
+
+clean_up_ctx:
+	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
+			      &process->proc_ctx_gpu_addr,
+			      &process->proc_ctx_cpu_ptr);
+clean_up_pasid:
+	idr_remove(&adev->mes.pasid_idr, pasid);
+clean_up_memory:
+	kfree(process->doorbell_bitmap);
+	kfree(process);
+	mutex_unlock(&adev->mes.mutex);
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e64b2114c7ba..010a9727cbec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -213,4 +213,7 @@ struct amdgpu_mes_funcs {
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
 
+int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
+			      struct amdgpu_vm *vm);
+
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

