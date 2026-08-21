Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BBFC5DF98
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7792C10F357;
	Fri, 21 Aug 2026 16:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vN7hWf20";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013043.outbound.protection.outlook.com
 [40.93.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F42010F352
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iG7jER5r3yt+z5dmyuXgmnHtAXAzAf/pWvTkUoe7BfW/hjhNv6CyitwL7kLwf2bwVmHPSDZNIZcCgDU4TSFQBdd+RwsgHp8Wr7I1WWwOV/qPidy05evtGEYYx5IyxU7JHO5EWmVQohUDp1ARdl1k4aJncwwqAsvTxt/6/HvWlKYuDscJUPaq9jG+CVVMre+B/ducfwbWYf0mRvKoshSGySk4jvR6IsNdnwdkeTDnG0S9AjjAAbS42fIJaekkY3JPfPzMWIdOUx9qW6YCx0iWAtkom7HnBXB+2f4vYUNiinpTLaVaJC4g2FzcN2ROMe/IQ802F8ihu5crYRAgWBItbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzVSUiGiJqIuf5Lzt96qU34UwuYswps4pT5sKPs7MmQ=;
 b=UiVgPQRJHRls+18C8XpF8j0eVHisoD5WX2/R1wkKzlPQVXkGhLsl0hjlaF8Yigh/5WocYt755HhFAYpn6HytGHeCKKVNHMMpajK3nDqI6YYr/I6USBFHKwGg9JyLO0wKKa1jTRwGhfTQaaxqsfeKFpueP3Qor+HEXWiHvl/OuTkKtgbjU/DIz/kK3kX9UdndQWv1oUsGXAhyS3Ldx/SRzQPNuQcKTbPYdSo5mWL62cQ5TI5S497KmJIltYL+k71JTiywAqxXHnkUUAGN7efo/p+tZLXa82rVdZMyjfNfqpHt9Q4PtlSl9HDYWdXuAcgXoGk9ViQtxIfjF+M+5pwyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzVSUiGiJqIuf5Lzt96qU34UwuYswps4pT5sKPs7MmQ=;
 b=vN7hWf208B+axP/j4lAicg0FgakqBBCSJhCkZUIXuGhEbtiCbyh6coQiqsnBxYHB6TUHc2D7S3xqlun6NT03etF4SwgejNU5WOSRHAoJCq1AonqfjJSZHZWoL4n/G5VqLmQdSge6aO1rzhljPBwRdCxQEnRc07HOlHLuhu6Qg7k=
Received: from MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:07:30 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::a) by MW4PR04CA0370.outlook.office365.com
 (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 10/15] drm/amdgpu: disable GFX clockgating for GC 12.1.0
Date: Fri, 21 Aug 2026 12:07:05 -0400
Message-ID: <20260821160710.752459-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f376020-7560-4e2e-543f-08deff9e4d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|11063799006|56012099006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: KOFO3kgyg2w94+KN3LtORj9OB5KDPR2l/1ZHQ+WaxZQM1UoJ7C0MmLUe/NsMUr8cXOE+J3w+5kdv8revksyZnZF++2fPrx0kG/OGY39nJ5EMSZY0H4o9U24tv0S4QW3z4Di7bazNI8E/MrQTga3BjKhHQm+9Z2XIoqTBsCciAkl+h/Ha62dNY45e6bjIZBDmzfNX1QwRwu2Vpyoci+y+6Bzv/bCDXqnfktI2N6cVXvEGTNwveMpvODxzH+6kUVIvbpgKjv3nWZyVlBAy8xUfCj133HflLEcYqLzop1nO3E6rvQ11WGR+s2WlLf7P97nS6lwJpDHDSp21AYdy8Y/yS4xn6fqY2mB3GcMogcrS/7EOHd53oR6DIxXwzVVMW7Z0JC6FsYpXeV6aOC0qn81lstD1sVKlm7Fto0okT9x4jRemslc/MfzHGkURngoiypuCzI/jANJZgwABvVIqDiO1FyFxzRodEMgMM7NcMh1Qfm3kbjz6yQ9XmB15GA3xln9iiReiFlIheKmAAggOoZUtQi2V44DEWanq6b6FIaKiSy2aVzBXxu9JE96o1KcmTDC0s2mWmffWtJEhmWDyySAogmoB/HieOnXPb9WEAGuXVGbJn/PjC6GGF9DyvZTQJuOrIhl+N3R8VyRbH/ujc52eaXTd9tcWKZ1fRVAkFsGEMdYvYoJIF2rUK6CKO+f5qhAe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q85f7JhNNmvhyR0mrl8VmlEmLG90S8O4Cc12pX5QXayv5LgL7e1jvmu2H4WyOPoL9niFp7VsU3JR6A/kOl9GagBZ7veq7Ds2XlSwD7N5DFlHSlkHQBATQ5LE7jYZ4w8ujSmDPI4V1wOc+SKepnLp7qNyldWbjsteMdoiiSYmhnzmvzoDasLrLg/CEgBZ0Vaj9fS3XZvZBUsV8roe3lXolYFj/Rrb2dY7HSIBpN7PTs7t92JlL12WZJ+AE6S0oPhZ/aof5G2lFd57EU4500fO8vPPcVgZCEa7OzZPej2T56g0jTHs363U5TrVbEQS9WRrEdFqPF3DlDBsMN/HbzfjiUt/Lsh4tjnZFX2s0yNQQDP8PtMk23BIIGk1x6WGhWEr0loEKJ6HURUxdApcmda41F7ExqqqMgjHDYtniwpAzrvVm3pBU6nQ7JCnPLSAHn7R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:29.6450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f376020-7560-4e2e-543f-08deff9e4d2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327
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

From: Le Ma <le.ma@amd.com>

RLC fw disables GFX CGCG and CGLS on GC 12.1.0 by default, so clear the
corresponding CG flags and keep GUI idle interrupts disabled during gfx init.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 5 ++---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c  | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 41b92d0685178..123fb904f4bf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2754,9 +2754,8 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 				return r;
 		}
 
-		/* GFX CGCG and LS is set by default */
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
-			gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, true, xcc_id);
+		/* GFX CGCG and LS is disabled by rlc fw */
+		gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
 
 		gfx_v12_1_xcc_cp_set_doorbell_range(adev, xcc_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 15923d2e05a54..8a1365ae9db6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -293,8 +293,7 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 1, 0):
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS;
+		adev->cg_flags = 0;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x50;
 		break;
-- 
2.55.0

