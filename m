Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ECBC982D7
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 20:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF7610F4F1;
	Fri, 18 Sep 2026 20:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aoxkVD12";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED56710F4F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 20:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HASx5vxHvAKpEs+EvMcPlTPjpJYUmKK8HwV10dMqyaLut+k8fAHkSLali96tIs8XcQ0gpREK1rvj1Bub3eL6nX5nxO3AJy4M5a1jGt+7oKiGxC85aFGy9Gnnoefs3Cq0ewSyELtDB23ZwHEWy736JBFkApraVT3MRIRpZBAqvl/M4K4wvcHIQYZSGPnVUUnrO3fAfTn8zqc4NQA1wtbq9g8/yUP+YTUpCFXAGZyGmtp/M5dbK+bJdLmFn3expmt/abhMsyM9usJQpA31qHN55JqMm6dO/yFw5Kl2T7eAA6OCmXBBMSvokjcjtwAfxH+21vWxV34TfZsv9gt6get4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2vbEVtVGUt/2PLj+Xxe8mLDf74bjBE92liJ5UgHhvE=;
 b=zOyyB2SbCF34ufaWkAnbSTCYnnAp9I+D/yGR8nmF+G4nJul0XfQippFdT0ircqCBBjVMYCGh24cku40oPaUjNu2u5VzsQe04zD0eVsUNZVF38Dyqx0wSKAo8Ptw/esnmCdRsU2JQN4BhWV5ax++WJJVa+8Cr9z1kTmj9RzDeq+aUnpt7KkypyFF/9tUXih0TbE531tq30oAHsdv6706ZfKbsXTeIKp38/FFxGEBF5YyPI447KPxXwNZ1cwD2OO2w66UvbASzShtvj2Cl+03XxN4hLg+KpFg0dWPyLdcXLdZCURMm/eTGGzeG7hji0DyORMdqZuRRpFkHYTOU9g9Dkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2vbEVtVGUt/2PLj+Xxe8mLDf74bjBE92liJ5UgHhvE=;
 b=aoxkVD12tw4vS/6IqbxER2j5W+kKF5qjDcovTvwyghKXsojazWVzXQi7nACHdyR459PJnyUETSTVOgVnCr/xI4Y2s1VNWy7aHSXLz6lvaLydMqx1iBDH7h8jR+jf8/CK61oBTFnoIBLiIuZ4fpkEaeIRVT41zPLyoolBsVSUfF8=
Received: from ROAP284CA0244.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:f3::18) by
 DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Fri, 18 Sep 2026 20:04:57 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10d6:10:f3:cafe::42) by ROAP284CA0244.outlook.office365.com
 (2603:10d6:10:f3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 20:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 20:04:56 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 15:04:55 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <SRINIVASAN.SHANMUGAM@amd.com>
CC: <alexander.deucher@amd.com>, <Christian.Koenig@amd.com>, <jamesz@amd.com>
Subject: [PATCH] drm/amdgpu/userq: reserve the VM root BO around CWSR param
 validation
Date: Fri, 18 Sep 2026 16:04:44 -0400
Message-ID: <20260918200444.450067-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 000a4ba6-d114-49e6-2f7a-08df15c01c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|56012099006|18002099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ROGRKvspmGL+Aj/V/SjwD5h8t5PCyUAE2EhiF85ba2DCxzw+p6+WEqt5POkzcN9wy0RLcL81fsuHpJNCDgv9uaPKcHgEsIztLIlkJutshd49C0tcTIdWBrehfzMBHUUYKO30ez4m53vX0V1SvDFaSkYVRN+hQ9EQvGTS8k+8kUVhfov5wwyqVln39sXkW55hul4+Ux5XwgYEL67M6+jSb3QY8UB4aPnCu72hmO3os2d//oC4BJXqK0HQGdFkd7Do+qwCUpeUc1JWa+I6AzjYkobtsPnpnGIvmaQPsoY8MrLMNMS3GZQRAVD6iy4Z83D0Vf0XLq7oWqCjOMfo3iq6dxEMnQF8UoXBb5NWRD5EOmXL4CQ9pfx3EpC7h/35YvO2xvB9M+dcRNW3c3wJxBPZDIljqUEtMcBycA/QBa5jNYZMxfsU5IBH/s5Pmx/YqmYf+tDvNdAZj8XHIqmSZdlsiDHFBK3e+UvWejzOFWk9EGfqth42IHNFqLoiu31CiG7zUvulXVWazu2yIfEx8qM9lBj97ZkEIpkrbll+kbXXjd/jxykSWuo0Xcwi7QkMm59Y151Ij6mlpn/9/bgBTW4duj1gJwMd5FDiA95RX7b38YhlfsAXkAtJWVX3eK4bmqWwsLKLsYzOL9rBFFo2HCifkcJz1a8DdDbb0hIXbTyNkJkSn0gtcL/8OxuEGhEruaEKEFGIYdUzr4SC/ALMzqzGKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(18002099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HRtKf6PP9qcIBp72lUf3DeIeeKWwUSACGVbG0K2htH5a7ZgWoYSbMe+cJ7iFlii2etSSm+tf4Os9qLKhOeOFqUKDrJjUW26tZGWkpV+9nXj5L4HPDlp9yUnqPDIQt7tCyxiPaSu0TbiWFiCs5cJH21sBnW4+/VkXI6LzpcWKFQvaMhSwsQRaaMAYvXskcYTn1jk7MUzaw4UFT10wjc/6dKKEH4iOt0Z71ld4gvZDtQa+Fa6mHYWcBaJu0hywNQvTBmsKDV006cS7CMMWbjw//TUTAinRTspxn6DfgUtkV7L/Im7mI27YdU8t4rvUU40wtBDVs3iZXe6qq3KgQ0cCOSdRey9UNBq/ifmYS2LBlXKKMrSNFPMoj364oMih0M4dXcLSjO3ht1xktTR5AtxpxkOY+twlbAlEOBHqUm4ZI12FB7bA9JJ4WcPKdIuo/IW1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 20:04:56.5609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 000a4ba6-d114-49e6-2f7a-08df15c01c81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_userq_input_trap_params_validate() ends up in
amdgpu_userq_input_va_validate(), which walks the VM mapping tree and
updates bo_va->userq_va_mapped, so it requires the caller to hold the
vm->root.bo reservation. The CWSR branch of mes_userq_mqd_create() called
it without that reservation, tripping the dma_resv_assert_held() on every
compute queue creation when trap handling is enabled:

 WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:232 at
 amdgpu_userq_input_va_validate+0xb9/0xd0 [amdgpu]
 Call Trace:
  mes_userq_mqd_create+0x49c/0x9e0 [amdgpu]
  amdgpu_userq_ioctl+0x935/0x1070 [amdgpu]
  drm_ioctl_kernel+0xb3/0x110 [drm]

Bracket the call with amdgpu_bo_reserve()/amdgpu_bo_unreserve() like the
other input VA validations in the same function.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2150973b947d..16aa22b25098 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -508,7 +508,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			trap_params.ctx_save_area_address =
 				compute_mqd->ctx_save_area_va;
 			trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
+
+			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
 			r = amdgpu_userq_input_trap_params_validate(queue, &trap_params);
+			amdgpu_bo_unreserve(queue->vm->root.bo);
 			if (r) {
 				kfree(compute_mqd);
 				goto free_mqd;
-- 
2.34.1

