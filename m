Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB0EFCC048
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 17:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CE310EDEF;
	Fri,  6 Mar 2026 17:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0J7FoGSA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E055310EDE5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 17:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl3cvCXN/EPUFVXcCY90ZeiVLFz1qs7lkiwsb2AE2DrGpuYiIKSfP9UiUPBoVccTKEke+owXdXiFLVxDb3cXGhOuFupMMkN3RI2/LEgtBlUDyKIlEZEzweXGr34rFJn0XWuLQGhxNvdC7/oG5/+XCUVVPLk4LCnFKDySt4cimZHW9d2Ni21kqCNd25WyxHH/OxqQcauw1oc7q+9LogM3lPxRsr0/uT4KhKIxTn+em/or50lMQFCjTHQohwjFOIcLBTdrFthDzIMt0adqYRl1toobh+SL+LmffrQI8vUJdDLL83bTLLHOmlh7jzh7GIme3H+plTXQIXeG41heWU7sfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaehuvZQ528PbvNFwq2WZADz+VVkpKXxplEz5IwXnzM=;
 b=u/Mrho1iyW3v1gAN9IYh6JhpZF5J/+L48Bcb/RIKoa9AjI0bqwDYSISpyhpsm0M4uTnCA/gmAGEiBVpnkDFJjRgNAOfYleFXz1pHqzAIdF8ApD5igZ0XxlYNyJ6cRq/KH+lvu2VbCOeUH+MaHNEEswJfbsh6o6YNwnTF9eCyuXS6UZk17RbCj0MO9CuSsV8hDREzbwCh6QpuAhSfffkuOKwllX2LTH6+ziGsWFqb2bG+ZTW62NLK2FGOiAaESK3qf0FSevzfiiuNh9vym/2mlyFnwAgbRVvWHM7hspanlobkyybyE6s0Wv6LnAHDBkPSbMoSEeYhzeY704Vp3T0EGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaehuvZQ528PbvNFwq2WZADz+VVkpKXxplEz5IwXnzM=;
 b=0J7FoGSAdRtJiSAeVIOZyNJgItKgfHMdAQwIqqtYlCrvqO2WtIRbvGtFVYZIY7g/VyFS8Q1J3+Sd1fdFap+U3TXsOXAKkgstNpOY3+O3sdY40sWiFwSlML0lDUikMv+nyHakVNzDciSnkBz1VrMUEGaJhCgnXA/SvDI24Nyft0k=
Received: from BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::33)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 17:24:29 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::c1) by BL1P223CA0028.outlook.office365.com
 (2603:10b6:208:2c4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 17:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:24:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 11:24:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu/sdma_5.2: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Fri, 6 Mar 2026 12:24:16 -0500
Message-ID: <20260306172417.325169-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306172417.325169-1-alexander.deucher@amd.com>
References: <20260306172417.325169-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e36b29f-ae7d-4f3b-2e3d-08de7ba5397c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: fSr4166EZPkMQ+8qfSd0GJGWhgq3pERWysrdMV6JBUfiz9iatOZgkponpCIyZn6fThCqseN3NQw9pZcFRyB+mMfNhj+is1ITfm4qrOMTUDyO941ldKrnW6/T5UB6jBW+6GnWOmnMLuJVhT/jA0WSDceNPr0+RRNZDdRBi6PmQctSeT+79k3ZQDBaWEsmz5EuD7tYFwbHeBgimtaGXsvLO/3DzplHM06iRyr2qQngZst8DU93loDdcc2fub8aEMVtXj2q+Rc0nUrPAOFQvTJyWSRZzmUsRG+0cK94J5hu3MbrGvw5tU/vmzLC0a3Po+fvbozhopx81bMYiN6kCNFn2GcUpwXj6tvNcZQnRZQxOoKTe5UKeAdDl82ZGfNLy2fwLPLfO3C8/gIYPllQfOVvjZ76OFHyABndqQ+DMVJPUOdhRfmFZNib03bBYbzhrQcpjKcBsPZ6kIFnWH1vaIz7AOPPBb2zEgXEVy8QElNKPOfqWOuYe1VrEk87No8JnS/2KyjfX1WeXcUsvJ7KTgeIAfLKopu3pgPfN5lmGg6TCBGlfA3SsO+lQxJFfonQRl6rReiy6UmccwiY8b99iH6JZS/+nPxvVmnPjyIcSYQhh4rVszSLgZpPsLq1tvSDZBN275kMtCPazjujhJF6VTu1X2pcuOiOvL6Va3yyTYA2qNUreodnXYkVAPstaJZRIycwaOXSEx2WT9rzFJQboUjH8qSkcMB8E6IFz138MeKhuwK9Bdqsuu0yqnqs0Wbe5MmMcpiatkME56YMAUXUfVYQHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: carbElKwhGDatZBt3ZN+WmbRZjeBp0ZHkGd249dYdpO7FGEzEc0VL76sFJjc7rvM74xAuBA21LYSVA4gnlcSZ89c7Bzq72t13SnfHabfi+AJmvnEGc+QbB5iCXgPPNhcByGrYErerMvvNgRkZ1kt7Y7BrozV04ysz6LFQN/kyeOxFx1nt+YXCsqGa3yu1lpxkLqNzCDbhD/9b3Xj8exWqa0cqMw7fREKTanAsXnSsg8+MSP3wAh/NrX94irC2YRHZWOQ1TLTLbzTnSbezC816kuuaN7nHa7W/tyyyH3qJbtrnGVFn8b3A9kkzEWNZDWyGIxLNB6T0ZSGlbJjYVCMBmt3E0Ldj8kUO1lqzD+lQviCUmk3EcDspgxKs5THQJIqVR7fo39gSUCrhj8WLWvuuOhtDuplcLB+77G2nzvXdBuysfk9YnkpZkQtKIgnqv75
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:24:29.6997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e36b29f-ae7d-4f3b-2e3d-08de7ba5397c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e7e53fdb9f8ae..95fd392f8ed42 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -547,7 +547,7 @@ static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	ring = &adev->sdma.instance[i].ring;
 
 	if (!amdgpu_sriov_vf(adev))
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 10);
 
 	/* Set ring buffer size in dwords */
 	rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

