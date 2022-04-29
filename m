Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93542C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8736410F72F;
	Fri, 29 Apr 2022 17:47:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61D210F305
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le+mf85B7bK8+7rvIvRemiA5Jc6DyJtW4i8QTo9JIMX4w0LEtvhMH9aVXMJB5hKz2eE0OAMyPwIpFfzizlFYc/usUjq8VyNZ6Oyh8YSmKbyUl3tm5JOOLNTL05ejJDl6bU716tkZM2FHs0xJkmj92ysCUeTANNOWR1KB3brfcPBwTQ9vZtSoYyrhmIJT5Fvw5z5MAwiEpUcThDVTJONlJLfZsHOToHS+316kEl3Qj+BgRrKMjzWDcLKSAPzBf0efqXLcafxzSrHLDx34iVf8Yaw5xLQbboimPRyfomIXDOWyxytLDB2KG4rumVaD6phMl8gw+1c+ELETSGd0DyacHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xFhsxwuZbiLHJsASCWsvZJaXWF3yC+sQG2Cvdq39t0=;
 b=S+knYpCB49n/NXAsaY8ftU6zwq2VC/oIxwymEgM5c/ol1Y/os4l+45XVwRM/TfqXnndT/AQKT3HHc308H/NrGK9hTF/iqjXqxvWKWItMc9jXN1CyGeWf8Q28fT2LBkwWGZqbOJ5qggXhip+EwuXlp6ODqPUJnRu2WQ1ji7Gk9MtZCGrcEyTHySBQa+OxvlU6+6wkwdlcYbEHPoAFVMZc73jz4/+hx8OaiNtFutkxGYqNWv7gtuh9Xps8e33xCQxQDYKXRCiJDwaFsGci9fKROQKyv/DYThZ72SSt5oJDGdxhIC+2KXMWfX6k64el/3LZxGJPOLgOtAVFcJPztqI9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xFhsxwuZbiLHJsASCWsvZJaXWF3yC+sQG2Cvdq39t0=;
 b=M/3pgIHnKRijRRDACwbAEWN24HF9beqMzgcwJkk/cMhzFG0OaccKrGoPXPl09IMDGPQpXj2HhTwsUY5ttMKwsX7DDLtsHdt5FHVQ44z/LzORUwClRmcDZaEobimTt8/s6yRVRPY8wB4F8LORBAMz5pNcXZNsWZ2jvp9PkhyBmfE=
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by CH2PR12MB4024.namprd12.prod.outlook.com (2603:10b6:610:2a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:47:02 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::74) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 41/73] drm/amdgpu/mes: initialize/finalize common mes
 structure v2
Date: Fri, 29 Apr 2022 13:45:52 -0400
Message-ID: <20220429174624.459475-42-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b0908097-065e-4bc6-08de-08da2a0844af
X-MS-TrafficTypeDiagnostic: CH2PR12MB4024:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4024A5ACDE0E190CEE42CDBEF7FC9@CH2PR12MB4024.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhx8HymgYZM3rCEwASNOwb0lRnTCXuODx7SHQmFXUB9m1dTU6tKDErWBX/oYQfGZbm+zhCtwYVKa4o5QLXL0nc0ASJs9xq8oVeZ2CaRnw7ziolZ6Or4js5Yv5rCe6o60qrXRhHJqeJePYGz1pJppDQkg0zLDgciBrKAs5zm0F2ciZXCMg2BTbyMCVxP37SKLIXbgqEqFzVnf51LjZL+VXU6BsPCV3T2Q0hSrJRWue3tfYCTnXx3rZkuTd5Zku3HJXi7kR1VXGFJDZH9xPaZt4OGSyhj0qSt+8nTJQ5GS1tKFq21vITe15BW3Lg59qizmPuVEYPU6SWhKzl54tzrjUDG9PnoJcgyig6i0ToATgxTiiNujxvkNnQ61iQ6cfP+NwEjY8jtnFSN+R4/sI8+7LgCLWJT8tni8UfDX9qV2DoaCmC3YiVFkwwqgL/W44lxIh+J7P1pv1fYC1TWb2zC/3sEWKdEIdfxYilbL9aiv3785zcPHje0J27Pn5hKskswPxy7l0bkBCVy3WII2tSTdBgZyL4lmLvOT2MTTS4WJvjj49mtmcFqnReMm+mK6AwplNMLQ7iu/zdoStSkG8nH+bjiiAJHHicMHbHUVKuXvM3Sdr3Wo44qNpD6WqpE6QSkA0CXK00JKdFbz3Gww1LpIw73KLdS8Uepc8T2nNNt+brBQTFtI+ul0UDzU7lYlcybqdyRarpXq+KfnEz7ZTadTlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(7696005)(81166007)(356005)(86362001)(70206006)(70586007)(4326008)(36860700001)(82310400005)(8936002)(8676002)(2906002)(83380400001)(66574015)(47076005)(2616005)(1076003)(426003)(16526019)(186003)(336012)(6916009)(40460700003)(54906003)(316002)(5660300002)(26005)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:02.5679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0908097-065e-4bc6-08de-08da2a0844af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4024
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Initialize/finalize common mes structure.

v2: add mutex_init for adev->mes.mutex

Cc: Le Ma <le.ma@amd.com>
Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 72 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 ++
 2 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 1c591cb45fd9..90c400564540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -131,3 +131,75 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 	DRM_INFO("max_doorbell_slices=%ld\n", doorbell_process_limit);
 	return 0;
 }
+
+int amdgpu_mes_init(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	adev->mes.adev = adev;
+
+	idr_init(&adev->mes.pasid_idr);
+	idr_init(&adev->mes.gang_id_idr);
+	idr_init(&adev->mes.queue_id_idr);
+	ida_init(&adev->mes.doorbell_ida);
+	spin_lock_init(&adev->mes.queue_id_lock);
+	mutex_init(&adev->mes.mutex);
+
+	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
+	adev->mes.vmid_mask_mmhub = 0xffffff00;
+	adev->mes.vmid_mask_gfxhub = 0xffffff00;
+
+	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
+		/* use only 1st MEC pipes */
+		if (i >= 4)
+			continue;
+		adev->mes.compute_hqd_mask[i] = 0xc;
+	}
+
+	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
+		adev->mes.gfx_hqd_mask[i] = i ? 0 : 0xfffffffe;
+
+	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
+		adev->mes.sdma_hqd_mask[i] = i ? 0 : 0x3fc;
+
+	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++)
+		adev->mes.agreegated_doorbells[i] = 0xffffffff;
+
+	r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs);
+	if (r) {
+		dev_err(adev->dev,
+			"(%d) ring trail_fence_offs wb alloc failed\n", r);
+		goto error_ids;
+	}
+	adev->mes.sch_ctx_gpu_addr =
+		adev->wb.gpu_addr + (adev->mes.sch_ctx_offs * 4);
+	adev->mes.sch_ctx_ptr =
+		(uint64_t *)&adev->wb.wb[adev->mes.sch_ctx_offs];
+
+	r = amdgpu_mes_doorbell_init(adev);
+	if (r)
+		goto error;
+
+	return 0;
+
+error:
+	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
+error_ids:
+	idr_destroy(&adev->mes.pasid_idr);
+	idr_destroy(&adev->mes.gang_id_idr);
+	idr_destroy(&adev->mes.queue_id_idr);
+	ida_destroy(&adev->mes.doorbell_ida);
+	mutex_destroy(&adev->mes.mutex);
+	return r;
+}
+
+void amdgpu_mes_fini(struct amdgpu_device *adev)
+{
+	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
+
+	idr_destroy(&adev->mes.pasid_idr);
+	idr_destroy(&adev->mes.gang_id_idr);
+	idr_destroy(&adev->mes.queue_id_idr);
+	ida_destroy(&adev->mes.doorbell_ida);
+	mutex_destroy(&adev->mes.mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 117c95acfd48..e64b2114c7ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -207,6 +207,10 @@ struct amdgpu_mes_funcs {
 			   struct mes_resume_gang_input *input);
 };
 
+
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
 
+int amdgpu_mes_init(struct amdgpu_device *adev);
+void amdgpu_mes_fini(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

