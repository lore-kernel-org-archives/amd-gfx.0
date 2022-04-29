Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16085C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5AC10F621;
	Fri, 29 Apr 2022 17:48:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5174810F606
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7SaZ7QkUcJH8cbuQubBCUWyY5TRUwWavYtNOtqtzeLTF7Cbvon0gSvZ756L1MGnjyBSk97mQgZcbcvx0S3/dgHDg8y/HD3TdasYjz4+mLH4+XgzBXqvryGXmcc2u0ShezdFsfPi93P9T9yuNvDBLWsSrDV7cv3/R07ffAJN6uF5/0LXSemGiRJZfG2UneqkRqFyoS1TekxY6D19QtB013feVTQCi+qz4WouZMLH/NNSLH0ezMGTGdvvalcDVToWDdv/WsNbhHDuB1L/QZRw2hmYWtFM3m/yu5kYRsQRlY8hIshaVZBRMKij3r0ceKNys1mGlSw2afcW8my18qEmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFPGLVStOKzxwSpl4rYyJ3Fs/ybWltOvt2xDk5HLhsQ=;
 b=aaVsx/lApv0smEk+XSyHg7j3jALkTsECbhhCBR2FLTYYxQNhugrduROuLRnPWxj1zc1sQWdU7bmDZ/J/15hJSL0pfw/FqQ2nMG/X+I84nOqbUYt3R7pdPC0Ovmzjahlrw5FtPS2Rg/Y6A0SBXO6Qd/pUA80nalzUfOiZrLY//cO02lWiL81Afql46gFVddGLJ0KMFQnhMmpPp0V+A/9x8fHcmBizWueFoK65Rr8zNDclVriBLbRGhvXYzK7O++BC0cYYHYeCawAY9FWRETcdbTWzIEaXLnogcTXi9yP2THSKgH5RWT/U5lLB729m5re58LR0ZKCVm7q43KulRjbZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFPGLVStOKzxwSpl4rYyJ3Fs/ybWltOvt2xDk5HLhsQ=;
 b=OsS58cHiJwtKtXeHsvmRNGMRNBPH7YfIOH4z5XoyqCqiBHtcLmNmkMzWJ703y4RDZKAfKZjHpH7u0/47LWU4kfC7iRn80CYHEBceoBOF7OePpYT1Dh5hN2TD4P7YTa4vr3XD6uR0ucqe6RQnFg3bsPwEeWAfwOGjy557gzXl7bk=
Received: from DM6PR18CA0033.namprd18.prod.outlook.com (2603:10b6:5:15b::46)
 by SN1PR12MB2526.namprd12.prod.outlook.com (2603:10b6:802:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 29 Apr
 2022 17:47:20 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::2b) by DM6PR18CA0033.outlook.office365.com
 (2603:10b6:5:15b::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 69/73] drm/amdgpu/mes: implement mes self test
Date: Fri, 29 Apr 2022 13:46:20 -0400
Message-ID: <20220429174624.459475-70-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 72ec1781-e56e-4f85-71a6-08da2a084f21
X-MS-TrafficTypeDiagnostic: SN1PR12MB2526:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25264DDA61C5021D83BA82A1F7FC9@SN1PR12MB2526.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+HRsPEUJBxg1fzNm+OQ0ZJZJzsWXXIogwjx9i2YAN28XLL2dZBYUWY1qIhtTuriVB7oBkkaV0RZo2RbzoW+olWLO6XiQlwC3dEQiI/JM4o50TLqT8Duos1Z2nYMaOHGNFCvOpCB1rnUTB4/kDZYOL5ElioooozuYXhZHAyg2bbeH3lW6UdbB6c2V55VOIApjJ4e7lTJQ/di7NX6FXTMhF68EZzWMhCJPG3Lt8S3FLWAFdRU3qIDiCVuPkySyARH5HFgRoTFbpFkfifMkK1DUIttPX3CQima+Wb+XfHTwaYWiR9BT7bvnLeK3LKZbmTNp+yxSucDfnBf72pYsFdBVs4OLbW6p1SnvPWvHEtTH7+o3ytdp07PtgOpT6g/K0JBEdeiVkX/JHfCjqUMlmMH6SwniKW85RxA/1/HchZEVa58FVVqNruPBsNTgCZ/b3G7c7wcHYdhsHpxcunoQZyBIo80jpgTP/jdO33sJLMz20DhEelEJmbbY4zxLilSnSYUhJj/EigPWJAGhFYoX3tGY+LK2qoQx/ZO6UOlQ5dijgFEInT+0dlVBbzIRMNZh6V+cZJTD5gUb2yH4DkrSkUXkgq0b5atOaYZLd/74qOiBb2BivCivDF7uun/JSt4GrDYlAh1mMk9FDgaBzDN732tBlXR3xtT7648IRJdOgBB1MH2fbIoYfOOXnXlJ0zqzafnpxYPg3fleX4LuMDpFNvU3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(66574015)(426003)(16526019)(83380400001)(82310400005)(47076005)(356005)(336012)(186003)(1076003)(86362001)(508600001)(8936002)(36756003)(81166007)(5660300002)(2906002)(6916009)(70206006)(54906003)(7696005)(26005)(4326008)(2616005)(70586007)(8676002)(36860700001)(40460700003)(316002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:20.1105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ec1781-e56e-4f85-71a6-08da2a084f21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2526
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

Add mes self test to verify its fundamental functionality by
running ring test and ib test of mes kernel queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 97 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +
 2 files changed, 99 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e2b1da08ab64..c9516b3aa6d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -990,3 +990,100 @@ static int amdgpu_mes_test_queues(struct amdgpu_ring **added_rings)
 
 	return 0;
 }
+
+int amdgpu_mes_self_test(struct amdgpu_device *adev)
+{
+	struct amdgpu_vm *vm = NULL;
+	struct amdgpu_mes_ctx_data ctx_data = {0};
+	struct amdgpu_ring *added_rings[AMDGPU_MES_CTX_MAX_RINGS] = { NULL };
+	int gang_ids[3] = {0};
+	int queue_types[][2] = { { AMDGPU_RING_TYPE_GFX,
+				   AMDGPU_MES_CTX_MAX_GFX_RINGS},
+				 { AMDGPU_RING_TYPE_COMPUTE,
+				   AMDGPU_MES_CTX_MAX_COMPUTE_RINGS},
+				 { AMDGPU_RING_TYPE_SDMA,
+				   AMDGPU_MES_CTX_MAX_SDMA_RINGS } };
+	int i, r, pasid, k = 0;
+
+	pasid = amdgpu_pasid_alloc(16);
+	if (pasid < 0) {
+		dev_warn(adev->dev, "No more PASIDs available!");
+		pasid = 0;
+	}
+
+	vm = kzalloc(sizeof(*vm), GFP_KERNEL);
+	if (!vm) {
+		r = -ENOMEM;
+		goto error_pasid;
+	}
+
+	r = amdgpu_vm_init(adev, vm);
+	if (r) {
+		DRM_ERROR("failed to initialize vm\n");
+		goto error_pasid;
+	}
+
+	r = amdgpu_mes_ctx_alloc_meta_data(adev, &ctx_data);
+	if (r) {
+		DRM_ERROR("failed to alloc ctx meta data\n");
+		goto error_pasid;
+	}
+
+	r = amdgpu_mes_test_map_ctx_meta_data(adev, vm, &ctx_data);
+	if (r) {
+		DRM_ERROR("failed to map ctx meta data\n");
+		goto error_vm;
+	}
+
+	r = amdgpu_mes_create_process(adev, pasid, vm);
+	if (r) {
+		DRM_ERROR("failed to create MES process\n");
+		goto error_vm;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(queue_types); i++) {
+		r = amdgpu_mes_test_create_gang_and_queues(adev, pasid,
+							   &gang_ids[i],
+							   queue_types[i][0],
+							   queue_types[i][1],
+							   &added_rings[k],
+							   &ctx_data);
+		if (r)
+			goto error_queues;
+
+		k += queue_types[i][1];
+	}
+
+	/* start ring test and ib test for MES queues */
+	amdgpu_mes_test_queues(added_rings);
+
+error_queues:
+	/* remove all queues */
+	for (i = 0; i < ARRAY_SIZE(added_rings); i++) {
+		if (!added_rings[i])
+			continue;
+		amdgpu_mes_remove_ring(adev, added_rings[i]);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(gang_ids); i++) {
+		if (!gang_ids[i])
+			continue;
+		amdgpu_mes_remove_gang(adev, gang_ids[i]);
+	}
+
+	amdgpu_mes_destroy_process(adev, pasid);
+
+error_vm:
+	BUG_ON(amdgpu_bo_reserve(ctx_data.meta_data_obj, true));
+	amdgpu_vm_bo_rmv(adev, ctx_data.meta_data_va);
+	amdgpu_bo_unreserve(ctx_data.meta_data_obj);
+	amdgpu_vm_fini(adev, vm);
+
+error_pasid:
+	if (pasid)
+		amdgpu_pasid_free(pasid);
+
+	amdgpu_mes_ctx_free_meta_data(&ctx_data);
+	kfree(vm);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 50d490e69cb7..5c9e7932c7a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -265,4 +265,6 @@ int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
 				   struct amdgpu_mes_ctx_data *ctx_data);
 void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data);
 
+int amdgpu_mes_self_test(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

