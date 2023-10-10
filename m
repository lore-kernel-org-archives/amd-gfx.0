Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFBCE95A97
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B230C10E336;
	Tue, 10 Oct 2023 10:18:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F59210E331
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNLlXxye1IvkPmo9qR+YYSWqPRxTfJdw9NPavXW41pJhpXiKZhV+h/XkpCP9xQ82+ChQqdZgdli73HmeVqEduEcpBSGHYM4AGA1oWywccFsjnjZ4ZmRZhGPGcMJSLW8mISwr/E8HuPg4emtMGBQdwnGkEljdwMWnOuLGXtgtlHGym9efROJTFe/LTMZ5AridA0dRHWRN589UjMrKerSvafATifDE9Juqf6E9Bb9SvDiLkZV+uvpRo/AeoucxQnv5RuF4s/zCt4EmtGLD2PtqBmqAf0OmK6yy4RvR/BkQUvlCkF7BDIs0LJDnYb+6fSZEBKL8M38K9HVYKo4r6zSvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH1D3A1QaXB29tTAQFQK5KOiNXNpG4Nw6RvTb8VnM8s=;
 b=X2ABixwwxA3ehXrpJPdlyPfA/ZbRP2N3kX1dsxP/bW6tZaJjY+KexIKH3LicikFBJfk++JWdYTM9QSNE8bhhMwo688VwSyX9434/cp9op0VeDDtO8JcnCV7DlkQSy8wydkMqvHZr+uY7NJR5wLNPCZ9z6VDSzY9grk+nptGBifvYpqqmQ1XG1Z0IQGc0et7fF88+FETrPPVwvqNE2uF7f/HA/i1rP7FerAGcSjRrz/dvFuJFN0Gx5sMZX9jwtRc3jQ+0J+nOY/eKjiu7l/KftIEELn0hExi5zOs9QdMw43Fl8ry2pdDErojW4tnhFstW7DwIJu7fKxuroM3zjQPefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH1D3A1QaXB29tTAQFQK5KOiNXNpG4Nw6RvTb8VnM8s=;
 b=ARMWpkfUMbOALHKJ/m6/mmP3UnTVSLvF6SsxRmyg7VQbcgTcv0idH+FbKyA/HzsuW1ccdkQToFjjfia0AjSY3dN8O5sXFd/yhiQG89v/CtSJfgsRKYewdNQReF1A22uThgbWl9blGHeY3PJlhneh5Aj3NqY3qc0FWXmKWQ52GfA=
Received: from PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::9) by
 CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 10:18:45 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::a6) by PH0P220CA0021.outlook.office365.com
 (2603:10b6:510:d3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:45 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:42 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 08/12] drm/amdgpu: map wptr BO into GART
Date: Tue, 10 Oct 2023 12:17:48 +0200
Message-ID: <20231010101752.1843-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20231010101752.1843-1-shashank.sharma@amd.com>
References: <20231010101752.1843-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 375e22f4-8ee5-4da6-c50b-08dbc97a493d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXlrKDdF+SCjWGeUWReIXegDfw6GszMDzegiC53ooHYbIif7CVPZjmjgwoBhFy/AbZG3v++IiM8i+dkFX81c4YLq1YUBDllxVZLF2WNtn4kkgJrjyw5Sz4OC6OqGI6zCAkbk2e35iymNEtFcKhAh46nKaxJ4eApmOecGtlgpR64fmPB+m2dSecgTvxvtM5qErWomXpDeS0DKfsjWQEMioBZj4NYPE0Cd0ATCWhdZwsi7/+zq0cIINwtsJOU50qXSABEN7PkqO0+qqGehZxPP+Y5QEUNuJcgw1gbTGUUhGIF+0an+tyrLA1OSTgBDYtHwPRcyxOOpxZFRjHpLwgA56cHZAKkPBeKdpy5rkYoTXI2OA8oq1f7Q6FcjdClXWL+9KYsMj52yksAxsLF68Q92Ipo59ZtIVICmihRTaZUIzAFxFUvVlBvCpkHsS8cHYQvj0srTtRpuV4CUANhCZ6C2d4e0SsoXYB/KqgRuHD8cYWpcdNnhWraj1credkwNZic0JXMtyl7oVjgWw1X0AevITBCAMvP0l4s4OSHSdHQJspnYhX/jy5HYOavB09Y332G6I2B/1IGxJAn+9zOkSQuAuZqxUjLXfhjcW4kvqciMPSKmpAzhxFvBVpEZLbv+2JOUDMhUYc6rw31CAZ/fLcSlwd1kOWWFZL/QS0rps4sXVYC3yqjqQthf7t+NX5puOPPVuNmsRAzGR2x/5zv2gZduyBLvGCHlizND9oaWCiyxbRORhBYaVnkQIwQO6sdpnBg+w7l11iTiPO3Zq1L60lFSVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(316002)(70206006)(6916009)(54906003)(41300700001)(44832011)(5660300002)(8936002)(4326008)(70586007)(8676002)(40460700003)(36860700001)(1076003)(2616005)(86362001)(83380400001)(7696005)(81166007)(2906002)(40480700001)(82740400003)(356005)(36756003)(426003)(336012)(26005)(16526019)(478600001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:45.4410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 375e22f4-8ee5-4da6-c50b-08dbc97a493d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
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

To support oversubscription, MES FW expects WPTR BOs to
be mapped into GART, before they are submitted to usermode
queues. This patch adds a function for the same.

V4: fix the wptr value before mapping lookup (Bas, Christian).

V5: Addressed review comments from Christian:
    - Either pin object or allocate from GART, but not both.
    - All the handling must be done with the VM locks held.

V7: Addressed review comments from Christian:
    - Do not take vm->eviction_lock
    - Use amdgpu_bo_gpu_offset to get the wptr_bo GPU offset

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 76 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 2 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d7d374822352..8c62a51025af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6405,6 +6405,74 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
 	.funcs = &gfx_v11_0_ip_funcs,
 };
 
+static int
+gfx_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+	int ret;
+
+	ret = amdgpu_bo_reserve(bo, true);
+	if (ret) {
+		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
+		goto err_reserve_bo_failed;
+	}
+
+	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
+	if (ret) {
+		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
+		goto err_map_bo_gart_failed;
+	}
+
+	amdgpu_bo_unreserve(bo);
+	bo = amdgpu_bo_ref(bo);
+
+	return 0;
+
+err_map_bo_gart_failed:
+	amdgpu_bo_unreserve(bo);
+err_reserve_bo_failed:
+	return ret;
+}
+
+static int
+gfx_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
+			      struct amdgpu_usermode_queue *queue,
+			      uint64_t wptr)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_bo_va_mapping *wptr_mapping;
+	struct amdgpu_vm *wptr_vm;
+	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
+	int ret;
+
+	wptr_vm = queue->vm;
+	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
+	if (ret)
+		return ret;
+
+	wptr &= AMDGPU_GMC_HOLE_MASK;
+	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
+	amdgpu_bo_unreserve(wptr_vm->root.bo);
+	if (!wptr_mapping) {
+		DRM_ERROR("Failed to lookup wptr bo\n");
+		return -EINVAL;
+	}
+
+	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
+	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
+		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
+		return -EINVAL;
+	}
+
+	ret = gfx_v11_0_map_gtt_bo_to_gart(adev, wptr_obj->obj);
+	if (ret) {
+		DRM_ERROR("Failed to map wptr bo to GART\n");
+		return ret;
+	}
+
+	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
+	return 0;
+}
+
 static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 			       struct amdgpu_usermode_queue *queue,
 			       struct amdgpu_mqd_prop *userq_props)
@@ -6434,6 +6502,7 @@ static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	queue_input.queue_size = userq_props->queue_size >> 2;
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
@@ -6551,6 +6620,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	/* FW expects WPTR BOs to be mapped into GART */
+	r = gfx_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props.wptr_gpu_addr);
+	if (r) {
+		DRM_ERROR("Failed to create WPTR mapping\n");
+		goto free_ctx;
+	}
+
 	/* Map userqueue into FW using MES */
 	r = gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 643f31474bd8..ffe8a3d73756 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -45,6 +45,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_vm	*vm;
 	struct amdgpu_userq_obj mqd;
 	struct amdgpu_userq_obj fw_obj;
+	struct amdgpu_userq_obj wptr_obj;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.42.0

