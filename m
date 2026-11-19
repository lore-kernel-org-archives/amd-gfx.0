Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F1606A339
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AyjKH8C7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197BD112228;
	Thu, 19 Nov 2026 09:57:11 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61B1112228
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 09:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgZJvpJJpdV2tj7WMwqnfXb3sqvRIqsrPm7E123MOZAcvPKfWbCPo0kFglRBaX1/S7qZGD/OJScs1+YId3bBOnAznPmzgTbCezp61JjHSRwldcHofum+QTRRGN09yiDg5P1EylX+QLd+lxXIrY5y2uAlovBmkCLw3tdde7jcUZlRCTORQ2w/61eL8cV4PNIfxEJOAk/61jyHE5v9tZgRoaQXjWaDNRVA90Q49eNwYIG8sJCLRPxQTLVcNIP0EuKfAOgb0qE7KLlzUhNd2Vhepx5psrhiYVzxf0fCnUbbOKRZ/2SnazCJH5GP2CBHk/T76cpcdqVAuhJpNTJUP1KsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOhVMnCAVnrUP0x2tgMZxlBoENcpFpogZNRoAiw3dnk=;
 b=qIo98vgWB9EGyLXSZGme3lilY4DzymfyzZ3yt+fizX/QWrmKLOwRzaRtsKZv5t9qUc/TRvHKLTrtXxXb+u93SFbGIKQnl3fABfj5cwOyCWzQdfyK4elLD9OlehxHKeNFUz5a3SGKDbBXt5he7WYkhzPpIFKvugR9T9pfXZe8g38z6kqtQmTfPxN92hifTGHGYAOfH3U68EdrRldhVt5eIZbt+SZ8d8/0l55BdKIBQMwnZCqzy7rhBOezdfA3XsvB25wxaParutkhupyZp4CC0n1S1WjaCGOShPM2S3MNbz3gpSO6r/cz4Ive9mKvIZvpNtrrtlK5WdR92RydFd9CGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOhVMnCAVnrUP0x2tgMZxlBoENcpFpogZNRoAiw3dnk=;
 b=AyjKH8C7f1o0cKIR9k/GC1DuU6P9CrpbrwNJJYOMfvtWsao2lY65fMZ1++TIYFZsuyfzNAp4obf4MR/42TEz5RkPaOTl/eLCsbF1nXj8kzgpVtLRT/dVKPl+EiAwkiiXUD+LIHz+KJEjtr6gHUtB6FkM+5gwwYi65RYLvx8SctM=
Received: from CY5PR14CA0027.namprd14.prod.outlook.com (2603:10b6:930:2::7) by
 SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 09:56:59 +0000
Received: from CY5PEPF00000E82.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::2a) by CY5PR14CA0027.outlook.office365.com
 (2603:10b6:930:2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 09:56:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=temperror
 (sender IP is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E82.mail.protection.outlook.com (10.167.247.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 09:56:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:56:57 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:56:56 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:56:55 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: don't unreserve the freed root PD in
 amdgpu_vm_init()
Date: Thu, 19 Nov 2026 17:56:44 +0800
Message-ID: <20261119095652.3510341-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119095652.3510341-1-Jesse.Zhang@amd.com>
References: <20261119095652.3510341-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E82:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8e0929-8b6f-4b56-1d75-08df462372f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|6133799003|18002099003|22082099003|261009223027099003|56012099006|11063799006|261021123027099003|10067099003|261026140227099003|261026121527099003|261102123227099003|261021135927099003|261028144727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: TgGrX5KKzAAD12gxMNWVuptsu2WBwSrjsxc7Za4KsBFLK9+u9CCTwFundt/unGGzsmSv/PBeyiBs5NomMszo3BkOQcg2CwmenIIkgnawSCjKzAeRu8U3nd7fdPcET+nlfLmjwQnoyJO4cxDmU8Bw6ILevjPljBqcYEceeUWGD36Of+tMT2T7SVK3NM9ivZ3eGUbZeyJZRP3zwxD+FcZTG7CT8YwvdqwWzY56ZtCxFKF+4Inpxzzr/yMGPwhQ/NASs9EG4jRf68C8mRpIyROMkhs4VxC+XRvUvjYafNPvITr0wX75wABfp5IqZQaawe2AgEPd432FMPYz8LUK1JhfsksxY8zovXFNFNbsPqANLcQIjNoa6z732Lt/FUp+L0SwYpgits+hiUdvIRzZhMqtVKJD3ZGTv7IiBTjaTSCbuBeeifia0jRZDVr6QqaRonFRDnl6/bT7nuMoiKrrAtCxpvDkG1ZFiiCUWWftYYEmZGv9+zN90TucM8jc9EDWCvQdIJtHSstu/kWFX0OVlu5RujO++TW9OkohYhZzQyQVEGjQ/14bCk7LusyFaIn3yRUaDzhbMpb4OonybJrm5DttEQ7HVApQJlImFKUgRKoW4CTPSO9lc0NcPvX2i94G4+6XgiilowWzBB0bEVVk/etW15fAF5TEPTGpGtyrRKJ3+lSPL+eOZv7kwd6QZWKImLRnskwIscpweQp5Knt0G/L/og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(261009223027099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021135927099003)(261028144727099003)(261022105027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KLQpN+1O3Eu4+jBKAn2rkvrt507St/zbPgljFE6ZEVdFnJtcXwpsm3Uxkzi2g3gSLUyuamkg7i4bcfFoLejQsWswPBqKmBPoMoUPcBfxDBjkhHGrDQgLCGbW1V3a7PIA1RwOnGuoSOtyjaK86ebDde9cC0XrEy/0HAj9YW5okZiVqAPibh6mAar9+tL93l2UL1k85YIXYuKkNTb0nW1jL1J013BBclPOo5e30EjGhwTM4a5SrD1AlCCP6fLqoUStilDakQY5qlcQis0j/LXUyJOyzvqw77fOxchRSjubdaKXx6DfPzrSDx2TtbOWs2W5/avQKvAKhI+q5xJEdifp+eVbUQfKf7oHJAmvevnoRm6XH0STJnSaEUvIUhl6xNqVxG81H2bkBo+C+nHLW2XAo0rbM2MyPo0012DhD9xL9y+ye3EulqnxDQcXGAiyruQ3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:56:57.5480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8e0929-8b6f-4b56-1d75-08df462372f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E82.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The error path of amdgpu_vm_init() frees the root PD, which clears
vm->root.bo, and then unreserves vm->root.bo. On navi48, with an
allocation after reserving the root PD failing through failslab while
opening the render node:

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000005e: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000002f0-0x00000000000002f7]
  RIP: 0010:amdgpu_vm_init+0xa9f/0x1480 [amdgpu]
   amdgpu_driver_open_kms+0x2b1/0xd10 [amdgpu]
   drm_file_alloc+0x58f/0xac0 [drm]
   drm_open_helper+0x1b3/0x4b0 [drm]

Unreserve it through root_bo, which still holds a reference. With this
and the entity fix 4842 opens with allocations failing in turn don't
oops anymore.

Fixes: 8473bfdcb5b1 ("drm/amdgpu: fix error handling in amdgpu_vm_init")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8cc5964f29c0..272eac0ef317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2718,8 +2718,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return 0;
 
 error_free_root:
+	/* This clears vm->root.bo, root_bo keeps the BO alive */
 	amdgpu_vm_pt_free_root(adev, vm);
-	amdgpu_bo_unreserve(vm->root.bo);
+	amdgpu_bo_unreserve(root_bo);
 	amdgpu_bo_unref(&root_bo);
 
 error_free_delayed:
-- 
2.50.1

