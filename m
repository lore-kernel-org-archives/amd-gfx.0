Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260DAEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC8910E304;
	Tue, 20 Jun 2023 17:16:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACA410E2FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAI4SSYYpFMnzzx8t6tTK7KuMGQrp0L9CxAwc+zdiAEs5FPm/L3zeCHbuFIxZdEnUowMnuJsTxKBA2HlzccvnXnGcwzbViDqAqi9ymKQ/LLvpNVadbXKa1FzLOSdCDd60bEyxrE8FF9afXwYzl8H6yKlBwD5IPtjnBshsYNR8mbVMV1CW993O86RNrlk8bNBQR8qnV5a2y82ySLpgPKI1ubOLVU9R1eAbCs8NVjJ0+eqtbOlT458XaLNMEoF5YpTp/mRp4PRHGixz5jOAYoFrNwxjErm5GXuYmV5J8ePU87Dq0Ant5kesZ26OtPNxDXHuzA0WFk0fK0o0G6DQk6U3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A322Wky6NJOqHfkQTzjs19aiRY27rL7sJwGIcnbXFM=;
 b=EuSwQYbjwvnJC4q4RjCYtuy3NNHDOcbAC6AIGP7az6NTgr3OpdaqbOziA3BRdQrGTzrJ5vhu1XWz2gdgqeglQpv/I8buXKR9Wy3Q/wHWkrakV3GoU6e7DfUp0pemBtwP5gKmJKkHA1MMuG47Nx7MQm92Jdb5sk/icxENBatk5xXF4c7Q1+zkHwOYCVEAdkBCXsv5h0SpZzZOlLJIyMajnfvi217aPUh6ct5Kvfk1rE0q4+KN1YkahgdMpAkVQaxyHeoi3/5CVsH2yjsV80D3601e77VhDuZkNh/j5bS9vs9QrcIRjhWv2DQXtqgOjRYZ0+qt8t9ptAarTu8fEIiDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A322Wky6NJOqHfkQTzjs19aiRY27rL7sJwGIcnbXFM=;
 b=v01d1wHH0tGMsO/5feR3QLhF96yHt4aTlh3urKqW5cQRZtfKISUIBR/7bYs4QCYkAf4wL3n5eCfVeJxVPURr53sq7N+z7AvrpRCExTaKxOhWOFgh4DO0b+JaeKJJZpjrKzBg1yXzA+aSwA9c1a+6SKkDc9VpZi9q+Ae1wXrFN5g=
Received: from BY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:1d0::17)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 17:16:46 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1d0:cafe::96) by BY5PR04CA0007.outlook.office365.com
 (2603:10b6:a03:1d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:45 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:40 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 12/12] drm/amdgpu: cleanup MES process level doorbells
Date: Tue, 20 Jun 2023 19:16:08 +0200
Message-ID: <20230620171608.2131-13-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 167aa176-596c-46b1-eeb9-08db71b21fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOcgp9SDGuesYbDHh67owJkr0PXlKCBwWc0kDXJcchQx2/5HlU3JEXD+ILNNFkJIN4K8J4nD2ZxXa+8sduz00/k2/wB44pG4dReZWvVUoF23/akRjKD4r0WuhIWC88/vR8TU58niMUXhA4uoNN4QdJR6HUEpHXGGCYAL74JnZxZuWnbuPiuwQ2eKRMRzvXh1KzO/HVu1bkjTNBsc/2r8hhrwfuEAeicIzA82C/Ji6jaCXz8s0ioMrPxtIpYr1YxiNsUx6NplSeADaQWPh+MPklOx+VJEKSKNp3OQkSnLlgU0HoAagPbNRaKNVMSvCBbtKmbW7SnI7pAmqnkuHOa7OQxyoAjvPI2kWZyMDHik3LuTE9Tnc6b0/1sXGalRZEa9jkz03kqEEA6Tu9oBRILg8S0+qBFhWvYlHatBhpHjifzgg4RiwXfgzD2fb4xqihf6H7ArIHoImoKK7Io6wtmcm0FOwtDru5h39H0cfu5NeDwONAItcrKpbcVsnsC6G1KHzOn5ptC5ywr5Vp8IVv3LcvoHz+h/wrfM5OCKFEkFfUwHxctzCp4Fag/vALeeDTFSq15BBqlpJLR46rrjl8a9nUWAk0516+GWxVxJfOjz0YcYi5n44ZD7UW1TNgqHT5otsjyKFdsp+svibRcRiOmWvTwIUrbcowqRYnEuQAJcasSHOOjGBMOYeG35ooXpCjSocXcI9i1uLp6wK/HZpzq4xkcVTaSFoY2U6Gn6G4hmxRyqE0fUg8wHKZpqsxJlRGpCtb+b05xWvdd5+xYU88TQhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(16526019)(186003)(2616005)(26005)(36756003)(7696005)(426003)(336012)(6666004)(83380400001)(47076005)(82740400003)(478600001)(66574015)(54906003)(81166007)(356005)(36860700001)(70206006)(316002)(70586007)(4326008)(82310400005)(6916009)(41300700001)(44832011)(8676002)(8936002)(2906002)(86362001)(40460700003)(5660300002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:45.5818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 167aa176-596c-46b1-eeb9-08db71b21fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MES allocates process level doorbells, but there is no userspace
client to consume it. It was only being used for the MES ring
tests (in kernel), and was written by kernel doorbell write.

The previous patch of this series has changed the MES ring test code to
use kernel level MES doorbells. This patch now cleans up the process level
doorbell allocation code which is not required.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 54 +------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 10 -----
 2 files changed, 1 insertion(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 01c3d27512d9..8ab558ceafe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -38,35 +38,6 @@ int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 		       PAGE_SIZE);
 }
 
-int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
-				      unsigned int *doorbell_index)
-{
-	int r = ida_simple_get(&adev->mes.doorbell_ida, 2,
-			       adev->mes.max_doorbell_slices,
-			       GFP_KERNEL);
-	if (r > 0)
-		*doorbell_index = r;
-
-	return r;
-}
-
-void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
-				      unsigned int doorbell_index)
-{
-	if (doorbell_index)
-		ida_simple_remove(&adev->mes.doorbell_ida, doorbell_index);
-}
-
-unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
-					struct amdgpu_device *adev,
-					uint32_t doorbell_index,
-					unsigned int doorbell_id)
-{
-	return ((doorbell_index *
-		amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32) +
-		doorbell_id * 2);
-}
-
 static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
 					 struct amdgpu_mes_process *process,
 					 int ip_type, uint64_t *doorbell_index)
@@ -258,15 +229,6 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 		return -ENOMEM;
 	}
 
-	process->doorbell_bitmap =
-		kzalloc(DIV_ROUND_UP(AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
-				     BITS_PER_BYTE), GFP_KERNEL);
-	if (!process->doorbell_bitmap) {
-		DRM_ERROR("failed to allocate doorbell bitmap\n");
-		kfree(process);
-		return -ENOMEM;
-	}
-
 	/* allocate the process context bo and map it */
 	r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_PROC_CTX_SIZE, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_GTT,
@@ -293,15 +255,6 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 		goto clean_up_ctx;
 	}
 
-	/* allocate the starting doorbell index of the process */
-	r = amdgpu_mes_alloc_process_doorbells(adev, &process->doorbell_index);
-	if (r < 0) {
-		DRM_ERROR("failed to allocate doorbell for process\n");
-		goto clean_up_pasid;
-	}
-
-	DRM_DEBUG("process doorbell index = %d\n", process->doorbell_index);
-
 	INIT_LIST_HEAD(&process->gang_list);
 	process->vm = vm;
 	process->pasid = pasid;
@@ -311,15 +264,12 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 	amdgpu_mes_unlock(&adev->mes);
 	return 0;
 
-clean_up_pasid:
-	idr_remove(&adev->mes.pasid_idr, pasid);
-	amdgpu_mes_unlock(&adev->mes);
 clean_up_ctx:
+	amdgpu_mes_unlock(&adev->mes);
 	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
 			      &process->proc_ctx_gpu_addr,
 			      &process->proc_ctx_cpu_ptr);
 clean_up_memory:
-	kfree(process->doorbell_bitmap);
 	kfree(process);
 	return r;
 }
@@ -365,7 +315,6 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
 		idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
 	}
 
-	amdgpu_mes_free_process_doorbells(adev, process->doorbell_index);
 	idr_remove(&adev->mes.pasid_idr, pasid);
 	amdgpu_mes_unlock(&adev->mes);
 
@@ -387,7 +336,6 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
 	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
 			      &process->proc_ctx_gpu_addr,
 			      &process->proc_ctx_cpu_ptr);
-	kfree(process->doorbell_bitmap);
 	kfree(process);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 2c604e04fd5c..dc78c9e0697b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -77,7 +77,6 @@ struct amdgpu_mes {
 	uint32_t			kiq_version;
 
 	uint32_t                        total_max_queue;
-	uint32_t                        doorbell_id_offset;
 	uint32_t                        max_doorbell_slices;
 
 	uint64_t                        default_process_quantum;
@@ -148,7 +147,6 @@ struct amdgpu_mes_process {
 	uint64_t 		process_quantum;
 	struct 			list_head gang_list;
 	uint32_t 		doorbell_index;
-	unsigned long 		*doorbell_bitmap;
 	struct mutex		doorbell_lock;
 };
 
@@ -368,14 +366,6 @@ int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
 
 int amdgpu_mes_self_test(struct amdgpu_device *adev);
 
-int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
-					unsigned int *doorbell_index);
-void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
-					unsigned int doorbell_index);
-unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
-					struct amdgpu_device *adev,
-					uint32_t doorbell_index,
-					unsigned int doorbell_id);
 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev);
 
 /*
-- 
2.40.1

