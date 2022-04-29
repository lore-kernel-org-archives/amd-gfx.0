Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470E8C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B01910F6C6;
	Fri, 29 Apr 2022 17:47:18 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF2310F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbCIjvc8BK1Bcf//xogAj+eL0We0cV0BQ2EFSBjpI01Bg/3dnV/MFtvBxuI/kPfC0jZ6rpw0xZQQeNpEw274wKtN3ugMOwLEqZNgTVBdgGUgXpGR6SeL67jEyGq8oTCaWQ6BBvccxouPp/Na2FmTX+fUv5txW/1wkzut/v8q9K5IDt1gPNrO2dnezGOFQakwgwcOE/SclAZWDP3gD4bY9A0ePNky+NT28ZhYm4aUMY4rj8fVth0lrKqGIRAPK8BZd7JrHf3Bb1SYbm3VNjr4qsg6Zf72vduHtcG3k0F17cJlpNsc/6s+8G0cSy+SU//lsB6njhvrEiI0G61yhJ8yUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M757TLFCJdbd3VBPhGBraYbiEt14jEhiexv5yzOige4=;
 b=Fac36ewvpBJ4xLF91y5VuGxnMIV6f1wpNPHN7Q6uLtClO0VK/84dMWRB+UgcCyxK9tpf/GiuKZwgxuMZh96qWgcya00JAZRq3QFD8yq69nQNv0ZnLnvA1LPZkxovFMpUh2rtFUVWo+qMRpQz0cOLM98g1BCoSXGEEOPZU+aMVQ8KiFDa+lQgxGcmYeo8G/b+jjzHR2mmeAUsgKWzz05u6F1M9UbjNWrDD+wa8SaAn1qR+smjCJqLCFo/fLDNLYiPHUUXk38IQMCppCOaUXGFlZaueoRTqqxGEhMR8KYZEgD3z7c+2rP/1nY7zr4SPljqsV8tLj5LhyvOnuZStSlU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M757TLFCJdbd3VBPhGBraYbiEt14jEhiexv5yzOige4=;
 b=PUK5s+E4ezJLSJc7t5KoP2YYSMhPc4LI+4Wz/1DzH2LPVaFxfyckH2YHtWHQ4bQQ0ZjgL2g1G7IeBupiiiN7G4lnoZH7/1aWLf3g0oM6S4qR7rYNFzKQKM6vaI+0gTdN8CISjz/WysAoCAr7rZoZxPB+hF3i7ZDqclfYUMj76kU=
Received: from DM6PR02CA0074.namprd02.prod.outlook.com (2603:10b6:5:1f4::15)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:47:08 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::f3) by DM6PR02CA0074.outlook.office365.com
 (2603:10b6:5:1f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 48/73] drm/amdgpu/mes: implement adding mes gang
Date: Fri, 29 Apr 2022 13:45:59 -0400
Message-ID: <20220429174624.459475-49-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f1ee016-22f1-4cc5-1e33-08da2a0847c4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB59467C034323C2D0B52DAB90F7FC9@BL1PR12MB5946.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6neVNhRI+RepFDAaJMSEyqkpZ4mh4011X08SQyKnwHpaKBO4jyL7ss9oq3Z6SZRWG7byoIFyILh0dlH8pNemsyyxcAAv7tpxBQTlH3haREL2UbOx1OMHcZFapZ0nhAFAmQ5HiSFUOD1FCTFC/Aq7YdWWwu0j3dUcKwTBjszobR+jzRjrjV0N5n39SK321OlHe3Azutyb0Z+IunxyVnVE94owqKHwfs3NqJATEEJye1m2iEv2vCUBAPf5D3T81rM8DcOh8pxQtcZ2wBYUPq9ZydpUp+LyCJDKYzuA8+wqL+lgGyX8VE/trVu1wzZt1yT91PoIiCcUdkpuPX7iP90sEqjxKxJB8mDVVUe2Gpr+ihS7xgGqCEzISsx7UUTiTcKUhmfW2c/1Ap6X06Q5Hv7xZsnR0D5Q5pLOjYf6wtCf9YrECGVdcP2rA1lNDtH6eirxeyzhCYRywrmarN3Ouyalc7LO00D4Zq9Org4N69chDObjPVZ2iowvbkrYvEu05bkH8Udb3whWcSIP0QaPG8bH77aTsXu4iJI5sA1cuRiOo6Cnf+NbvsRS25OTwKEIpS7EwvT0BrJf2YjXwf6iIPNJbF1ruoPyhaCMVXR9KzCvDsp29U9hJdeI89JHLnCx0f208iDVElACKQiwzPfo0VaOnfWIILuPrzftyM8jhJGQP0RJTwQjC44nCsgTo3sQ/wx+xDZGT4g7gBLeMiTyuWYYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(47076005)(82310400005)(508600001)(2616005)(66574015)(40460700003)(336012)(426003)(1076003)(26005)(356005)(81166007)(6666004)(70206006)(36860700001)(16526019)(7696005)(186003)(316002)(2906002)(5660300002)(36756003)(8936002)(70586007)(54906003)(83380400001)(4326008)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:07.7392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1ee016-22f1-4cc5-1e33-08da2a0847c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
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

Gang is a group of the same type queue, which is the scheduling
unit of mes hardware scheduler.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 67 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 12 +++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 05e27636ce20..74385e4b45c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -349,3 +349,70 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
 
 	mutex_unlock(&adev->mes.mutex);
 }
+
+int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
+			struct amdgpu_mes_gang_properties *gprops,
+			int *gang_id)
+{
+	struct amdgpu_mes_process *process;
+	struct amdgpu_mes_gang *gang;
+	int r;
+
+	mutex_lock(&adev->mes.mutex);
+
+	process = idr_find(&adev->mes.pasid_idr, pasid);
+	if (!process) {
+		DRM_ERROR("pasid %d doesn't exist\n", pasid);
+		mutex_unlock(&adev->mes.mutex);
+		return -EINVAL;
+	}
+
+	/* allocate the mes gang buffer */
+	gang = kzalloc(sizeof(struct amdgpu_mes_gang), GFP_KERNEL);
+	if (!gang) {
+		mutex_unlock(&adev->mes.mutex);
+		return -ENOMEM;
+	}
+
+	/* add the mes gang to idr list */
+	r = idr_alloc(&adev->mes.gang_id_idr, gang, 1, 0,
+		      GFP_KERNEL);
+	if (r < 0) {
+		kfree(gang);
+		mutex_unlock(&adev->mes.mutex);
+		return r;
+	}
+
+	gang->gang_id = r;
+	*gang_id = r;
+
+	/* allocate the gang context bo and map it to cpu space */
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_GANG_CTX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &gang->gang_ctx_bo,
+				    &gang->gang_ctx_gpu_addr,
+				    &gang->gang_ctx_cpu_ptr);
+	if (r) {
+		DRM_ERROR("failed to allocate process context bo\n");
+		goto clean_up;
+	}
+	memset(gang->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
+
+	INIT_LIST_HEAD(&gang->queue_list);
+	gang->process = process;
+	gang->priority = gprops->priority;
+	gang->gang_quantum = gprops->gang_quantum ?
+		gprops->gang_quantum : adev->mes.default_gang_quantum;
+	gang->global_priority_level = gprops->global_priority_level;
+	gang->inprocess_gang_priority = gprops->inprocess_gang_priority;
+	list_add_tail(&gang->list, &process->gang_list);
+
+	mutex_unlock(&adev->mes.mutex);
+	return 0;
+
+clean_up:
+	idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
+	kfree(gang);
+	mutex_unlock(&adev->mes.mutex);
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index fa2f47e4cd5a..3109bd1db6bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -158,6 +158,14 @@ struct amdgpu_mes_queue {
 	struct amdgpu_ring 		*ring;
 };
 
+struct amdgpu_mes_gang_properties {
+	uint32_t 	priority;
+	uint32_t 	gang_quantum;
+	uint32_t 	inprocess_gang_priority;
+	uint32_t 	priority_level;
+	int 		global_priority_level;
+};
+
 struct mes_add_queue_input {
 	uint32_t	process_id;
 	uint64_t	page_table_base_addr;
@@ -217,4 +225,8 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 			      struct amdgpu_vm *vm);
 void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid);
 
+int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
+			struct amdgpu_mes_gang_properties *gprops,
+			int *gang_id);
+
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

