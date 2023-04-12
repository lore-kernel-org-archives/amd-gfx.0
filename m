Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326FEC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D3F10E8AC;
	Wed, 12 Apr 2023 16:26:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E776810E8AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUVcZzBBublP49843gGC2mHY/2q4j5o9L2EiDikA2lZZVKr6O2A0EwMiNuRIiGaghvTFOHfMG5QuIGi0REck+J06JWy7xupe02/LEPn78DzmlqB7hrYMkLSkrW2R3qhw41VyRiYh5VwrzSsNQwudZLEjOe+DN1ZwbT9W7Y1iZ+jVR8X0aso/FLa26GEeBeEBP/c8uUflEL9cleKgPDqzPUwiqtO0OC7tQkwnWrrBnST+yYkouFk+I91o5okvLp/eV7OaACkLeAD6VpXKeg9/oz2Qa4Iy5KV/ov/L3rSFqujTzv00nvVvGYZb28Lemu+Uiek+4vJeP1FCngHN0/ALiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+8XHJ4LLQEJXwyIG5GYiOp/4r4k9Gt2/tfmK49JsEk=;
 b=KgnAeftBuip2UhY3cwa5ijOTviBKvIBJVD5zBApuJZ8sa6JccIjGsBkUYLIAkpfrwPnPEOPl3b0V1pbqZxONrFjk84RZH+eJYtjYEFbHbTOXGnpRLlYOsKoxn5K7Dsr2imZtKwsXLsxXoNV3+YSBbJZ07psk0jcpICI9l+ce5bl+hu4HRZPlW3apKUSheZYR45YxkVYlRq0QDpMQ9Ubj4/g/mFU+KP+x5jlkUG0rwcmHwIdQucZoJ6CNtkmSs+mj/YQRRQF2AkCMwLUCBTCr9VNsanzaqtG0FVd5O/SntOnQVWOTeuEG6VL5SMRUhpPnqe25GwbvchlZ/vpGS/B1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+8XHJ4LLQEJXwyIG5GYiOp/4r4k9Gt2/tfmK49JsEk=;
 b=yjg3j+PWY8JW8X+CIcSeagGCMCS2p7sjKTIABIveXhTNu76OmoxkxcYuJ+FzPvcGtpHIrwTEzXClsYDrEAMaCroyZbOrotym2V6+Fnk2qBHrrtVNeM5IJuLCO++5o6KBMDtzeB5sDwo/vVffLYcpFEdnuWio4ppyjHHTErn1UMA=
Received: from BLAPR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:32b::20)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 16:26:42 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::e5) by BLAPR03CA0015.outlook.office365.com
 (2603:10b6:208:32b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:42 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:26:41 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 12/12] drm/amdgpu: cleanup MES process level doorbells
Date: Wed, 12 Apr 2023 18:25:36 +0200
Message-ID: <20230412162537.1357-13-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c992af-8922-437d-0a5e-08db3b72b394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXylnyIfuLZ39cVrv4vBkRgiFjKHZu4AfuWbQIx/i6JKy7/ySg9guOHmvFsRL2dGliyajqP+EtPvwQuz0/rC5fjqX2Toa/+C3Yns52bcMWsy1TGNz1lzzV7JGA4PIa4LiyyP8epJw7LD8IPxbsevfJF1tIWjAmm5VsjSSFs4y8e/LSWaRVarqISZMvk6eEuFWcS3SXn5/o602T30Jikba/3xWIsT/Q4FAoTF0/AUTVl4SGNURa3W3Abyl8XvAVNwGX8IUPze6bA3iv7RolXDgQpwXv4v5dOJl2d4o8Gpza/cjr7Cu9oVT7eSln4fWRnHqkcdMoNuCqqPrmQ5q7bY0DwMI5R5+I9lQLGIDiyKpsh7Bph1nRNdtgoBdqfnqTCqP/T+8ld2U6IXg/cis+K+ufhTy5Ac6RoTdTkCtL+jId4EZtFyywROnzS4VdRo24fTXZ6gsRh9ZJGbD7zyR0eyCs6TFjY6n8FIArefTWykMCxmrEP7imwOdrwqXA03IfYXYgr26sajY1pBA66eLRdWWF1vXyemoc6kocmVwYlQHaSqktGpuSg7trvAO2VBR8XGtZ7zKh5Y9WnVKMOkpqHAT+fBe8rPIccvxuo0tY/Ar51dS7/Qr7z76vT1vFye/8ArPYXBrhqUom4lZFRh1PHeGwggC2QWm8girDA5q3g54lcyonp5cSs7XvYIdcC2GU6Zi7hHubB4kluBkm0lslIeVLNr5jTAfbrI2GeTNGt4zHo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(7696005)(26005)(16526019)(44832011)(186003)(5660300002)(54906003)(1076003)(316002)(2906002)(4326008)(70206006)(70586007)(6666004)(6916009)(82310400005)(8676002)(8936002)(41300700001)(81166007)(356005)(82740400003)(47076005)(83380400001)(40460700003)(40480700001)(36756003)(2616005)(426003)(336012)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:42.7722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c992af-8922-437d-0a5e-08db3b72b394
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
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
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 54 +------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 10 -----
 2 files changed, 1 insertion(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index cd3ee851f0a4..2180e8e2c82e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -36,35 +36,6 @@ int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
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
@@ -256,15 +227,6 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
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
@@ -291,15 +253,6 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
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
@@ -309,15 +262,12 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
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
@@ -363,7 +313,6 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
 		idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
 	}
 
-	amdgpu_mes_free_process_doorbells(adev, process->doorbell_index);
 	idr_remove(&adev->mes.pasid_idr, pasid);
 	amdgpu_mes_unlock(&adev->mes);
 
@@ -385,7 +334,6 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
 	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
 			      &process->proc_ctx_gpu_addr,
 			      &process->proc_ctx_cpu_ptr);
-	kfree(process->doorbell_bitmap);
 	kfree(process);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index b04225585757..f96010dbd12a 100644
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
 
@@ -367,14 +365,6 @@ int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
 
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
2.40.0

