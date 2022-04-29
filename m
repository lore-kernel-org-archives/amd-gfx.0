Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA80C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D94F10F6CD;
	Fri, 29 Apr 2022 17:48:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C61F10F735
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHOhSYm+4NsVwwJYDWMEvAFOszKSoUyo+YmCRJKttskNTelVarGiVlRhJO3DmWWUeleabBt6rmpCjnpm5KSwAwvgWiBJDcOxFhRIQ5fXy3rztDS6TRIF7s+1bjt9q8ds5BbY2lK0FOdTcjaVhMY+igMz2/6HTNb1xwhZcz083PLsmjRyZ7yaclp1pPTft2grpMdQIQAJqRHrpOq55cFuz+Jpc1qw3Tag34pFb0TpwY71nKuavGPaXPlYrbhyQLRCq+ZsJp/UZmCXN6u4XuxBrP5VVUY1v7juunG8NrXnoNqkMssCV5Z4AtW9QwVwzCLbXBpql8KoTx+TcKWuslofTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0jlevReQJhN1minfGPJEaT7gweNV4JB5ZODM6NkgbQ=;
 b=E9J4AlCUzI106dTToNy2k2GSI+W0P1xXYVQLFkPfEAXqKku818/lBYZha8E7BAg6BeUDL93LDcqy9scW+EpOne6X5cjVcuvLFHnucFylo30zFkzZR6D6yZEuAFIWCipTY8VUVpeoO/q3k22q+hqOlvQ57+YexfIE55FTx17JBKGtuu2u2eEl+ilB8jE2bDgVhKcqiTBqlwz6Bryz8lvxsA85oXrRawPZirsWgxkqUUBWx0mQoIv++39wHWFu9XNyu8pNWPMNhR5Ou/r9U2CgyWjLlp8Mj04QJ26Q6SjMNM5q2FK1ZX7dzf+F1UMe6bxKj4hJ1hCG5nfEcRDH01KMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0jlevReQJhN1minfGPJEaT7gweNV4JB5ZODM6NkgbQ=;
 b=pdMfUBVGaB7XbarQkKT2DK5sGT8KtzohYaqK4t6U/0GmZk9NgEe0cXpMUifhU8j3ks3oRqgAvzYTvstP4LgZNZWrGJujo5VW3BmXbhFqx7pgJCWzwCprUqAFyHDDo3IeRaw9oYJeCbdMf2PQJGzM56ALfL18iDoCIBTyO9MyUqE=
Received: from DM6PR17CA0031.namprd17.prod.outlook.com (2603:10b6:5:1b3::44)
 by BN6PR12MB1315.namprd12.prod.outlook.com (2603:10b6:404:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:47:19 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::97) by DM6PR17CA0031.outlook.office365.com
 (2603:10b6:5:1b3::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 66/73] drm/amdgpu/mes: map ctx metadata for mes self test
Date: Fri, 29 Apr 2022 13:46:17 -0400
Message-ID: <20220429174624.459475-67-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ebc2728-127a-41ff-eb0e-08da2a084ec1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1315:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1315B4732A393F7AECCAA1DEF7FC9@BN6PR12MB1315.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpDZ/zUQHZqUnVlXfNuAbrM180Q4w9cef2gqCgL9KBkBX26LcBKCeLnowrcY7fnXYvhqmVnBn1P7Fllrklcp3C+VV6opmKrjbC0eJ0ANgj8Cafy6bQvZWrWPt+SxojLL9h4fW7fkCJSAqHnflfkMJ5AWllDZA5e7+0RKryeMEgJhwhacj67IKni53VmFNtFx4/nG3jy6C/beXw1/FhwWd5teaMNblP0MrfmpJ2Xl0CxMD2fxCZ2SoVfX9goL1xUoEXZU2XwVXKHhFedr/Sk8UxBXOBW4VBb6V5QnOrCnYDQ6Bbgb05BiaTXGKJv7hcdom2x+EMjraRe5ks/jRCWkZCv5vHn3TWOxqeeNUQtGwbmA8XMDA3N23C3IzkRuKDa4sA9MnNtwFURyFW00ScgNTDy0y11AwamHNMDJfmHMZLnTlDQ+Hwn5D5yjU4oo3+hiRKo3K8rRBdhay4bIJ078GUMm91ktM+0iFaW/wnqZmW3IBkDfmIoqUMkTvIRK2Ebws5Qav7bur0cuqTwIPuiQpZzszT8e/fPO+jSUtZqaOjSGWMYx5OiUg1ZZrYTsWRGfMfOHiyt3SmAp/+NRBgt2Lq1rSLu2CVqlqE39Ay3P6DkimX5Fo2d9q94AiSYKUMI5qkfbsNR9cWOwkIJ23vZqUt0vm8e/OM8jsWW0Z4gxP5842Cph39jyiRXv4WMKKI+4c56LN7gc0DQbgN4rfAar/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(7696005)(5660300002)(26005)(8936002)(356005)(81166007)(426003)(1076003)(2616005)(186003)(66574015)(16526019)(47076005)(336012)(36756003)(6916009)(316002)(82310400005)(4326008)(2906002)(83380400001)(54906003)(70206006)(70586007)(36860700001)(8676002)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:19.4845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebc2728-127a-41ff-eb0e-08da2a084ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1315
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

Map ctx metadata for mes self test.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6c01581e3a7b..b440b36dd98a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -882,3 +882,40 @@ void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data)
 	if (ctx_data->meta_data_obj)
 		amdgpu_bo_free_kernel(&ctx_data->meta_data_obj, NULL, NULL);
 }
+
+static int amdgpu_mes_test_map_ctx_meta_data(struct amdgpu_device *adev,
+				     struct amdgpu_vm *vm,
+				     struct amdgpu_mes_ctx_data *ctx_data)
+{
+	struct amdgpu_bo_va *meta_data_va = NULL;
+	uint64_t meta_data_addr = AMDGPU_VA_RESERVED_SIZE;
+	int r;
+
+	r = amdgpu_map_static_csa(adev, vm, ctx_data->meta_data_obj,
+				  &meta_data_va, meta_data_addr,
+				  sizeof(struct amdgpu_mes_ctx_meta_data));
+	if (r)
+		return r;
+
+	r = amdgpu_vm_bo_update(adev, meta_data_va, false);
+	if (r)
+		goto error;
+
+	r = amdgpu_vm_update_pdes(adev, vm, false);
+	if (r)
+		goto error;
+
+	dma_fence_wait(vm->last_update, false);
+	dma_fence_wait(meta_data_va->last_pt_update, false);
+
+	ctx_data->meta_data_gpu_addr = meta_data_addr;
+	ctx_data->meta_data_va = meta_data_va;
+
+	return 0;
+
+error:
+	BUG_ON(amdgpu_bo_reserve(ctx_data->meta_data_obj, true));
+	amdgpu_vm_bo_rmv(adev, meta_data_va);
+	amdgpu_bo_unreserve(ctx_data->meta_data_obj);
+	return r;
+}
-- 
2.35.1

