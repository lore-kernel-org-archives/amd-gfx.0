Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D66EF8FEA
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 13:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106E910EA03;
	Wed,  4 Mar 2026 13:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e4gFlKVt";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8427D10EA03
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 13:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4xrm167KFbM9gj0XEBNOsK6xA+ayeWrinJFzNiUCAM5aTufXbbyopYd4ts5Nhp2eFCNGhbiE9bnfoXVgd9jzum7tJ6EO1QRI1pI54jYxf3Kjaox5HOtNvDLD6eoriJyTzr2M1qVS8ZJMD6R8W26qg7aPm2vdHkp3TwV49KCccPf8rzXXDpw52keUVxp2sm3QjRwfcaDWmKy3HGax26TAOi4AVc4dSuzVLONyZKauJnBCeSNXC2UENzkssC5Nby2uaZEiu5TGrhhQJJa4YAdJdy3S/Cr6uZIUmTS9TQ8AhydWqVSUaw2aJIbPtKLkpyAZy6bs99LXP1Gv4Ny3nz0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyAENaV7krBCtpoq2anBKmH0g4tyk4/aVdR/j3JiPss=;
 b=ArV3qlWWpwq7kjYWd4x79LiThH1tk6Vpz4dexJprREOSBlnh3Wl/Me0k5s3DIGwCt7i2HT17Ycq80L92QKUCry9X5M6SRMyJYW9hqd0UCNS0f0RPqk8XSP/KiQxO6VSbbJUlIiBBoODGy1+bEjmh3HHcJEn+ZHSHKaWjlYVnOIsGxsptjgpfryjyiim54wNozMPeb5U5MWKRVsGXfSJF4r9KGJHikrws9eOREuLhcbVMX4Eb5bVQzfPDDfKNKEEPW73V5Z6wFWnE0hsPXfcpHU0pkmqrHNTBStHGvH30AZvCcpynMY82mbhp7DOHoJyNlV2QNKRy9sItd9uyJQHGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyAENaV7krBCtpoq2anBKmH0g4tyk4/aVdR/j3JiPss=;
 b=e4gFlKVt9hTLyM5pQDzNclE3nHLDfkOP9bBwtQ/+DyweejAMfa4O+qUVbAJwSThBDmHYgM21Rq85zLisrgDugApsND+TQLPz+lPDaEj1gWJDZqbKoD2cujb8YBNoTpkOD43cPiupuBcAHljxVQGLO7IQJxds7WRpexD0BFuXSXk=
Received: from CH0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:610:11a::15)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 13:54:33 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::20) by CH0PR03CA0353.outlook.office365.com
 (2603:10b6:610:11a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 13:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 13:54:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 4 Mar
 2026 07:54:32 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Mar
 2026 07:54:31 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 07:54:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
Date: Wed, 4 Mar 2026 08:54:25 -0500
Message-ID: <20260304135425.18729-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: fc839e65-c87e-4375-5066-08de79f59024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: KIR8r3oz71V+mHjrGi7/dMfJ61Hlmn/eLoR4jk7ugT21XyMM4pXto7FfI0wj/TWe/s+qNde0nZHJRziEDncVpYE0gaWpL4cqwMeYwJUWOFSf6VpEaSb77dO/cOqc0KswbbifdHohuNRkgS7BO5R8Zvh4IShSl/rHLxLzn7BJGPsqtnS7O1C4VzPfBaU5x/kJj99KE5BzP3spMJpHLcXQWJPZGOImD/3VPwIrFOT8ZmIEGEq8VX0cHr/i/RL+Bf1+1yLjvYx5XO91/zpkcRPYO4wioybxR197JJsCDAW+9KNkd0w3dn8y3Muu8x7QEsmAMzwW3X1dtxGEnIupPKo1ltQT9+lpa2ZW/4Ph8VkD/jet4ulQe9rClgDOKwsRP0LrP+yjjPiD0YEFFBzw+zfvq5hQsa5CoglXzbVhBbPfN/ByWXzsDgPJ64RZ34jD2PIrKMsUPCoTf9KGAo45cVy9frd5Wo+kZOOjgXQpzFOHmk/1CKxyb4+IclT5g+7hCmijX3tm2OJwuxT0PEJ0b6190msTYIktrMT1MfnUP8p+1wrg7Oaarxm9YPbThrc15/ygFiP11D8KMlkTZ+t/cxHdngr1u72tbBvg2JgsH+UQyXv64m66RxfRl2vaPkttiFut24KssAqMoyIvw6Ej2847CSlULmZO7vySEryacjjKVwTgpvzrKxTC1R+22mXL5b/F8696QRcLPjqogLZNeDAmbcRb5o95gS/7PWTpA82KOlc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7gpD3jcjJDfHxaeq3kaNleCS9B4/S2JWMftnn/no3S6TM4qfnp9J1oP3fg5syKOhmohkZ+Lksm4iWcHzkLHccRzm171fjx0yQreql09LGuIhuiqc3V2EzyAyoistdU1lN+vpjw5/nLY6pWn7kF+m66o1FGpFCP9GRsM+kzXYDqpOVUWthbVIg5v5Pkc/DabayagSY5uhE1pZ5V4rlyM4qWSdVUkqr2kDlUC5+q5qCsEG86hw+9J5OqGmxV2DYugMBLEIzwZu6ONB0bA/viMQtxbbCJkm97rstogEGmnC4btWvbrLmsr+gRQl9hcYWakaOHcl70dc8Gd87TxPirmVDk5ZyZ/Ayc4jF+BiskQ4dHaCFDb9U7mqlyg5IhSxIsPwrJ22tgiNocKb9TQp4RiANsvbQc7nLDzhtsGFmsMnq+CQchQXF5z1fLSPGaFigh/Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 13:54:32.4895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc839e65-c87e-4375-5066-08de79f59024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
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

This reverts commit f3854e04b708d73276c4488231a8bd66d30b4671.

This causes framebuffer corruption after suspend.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4798
Cc: Christian König <christian.koenig@amd.com>
Cc: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 01fef0e4f4085..25b1d679ba262 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1073,7 +1073,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 
 	/* Prepare a TLB flush fence to be attached to PTs */
-	if (!params->unlocked) {
+	if (!params->unlocked && vm->is_compute_context) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
-- 
2.53.0

