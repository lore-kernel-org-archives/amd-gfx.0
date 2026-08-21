Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E515DC5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488FE10F368;
	Fri, 21 Aug 2026 16:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y+peoFj2";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 076B310F364
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqHN7cHJVfgGGSmTzSEZ1wwRSbM5zlNKkAhC505N00+TAoFX+wYxky6ImIXBJKc5f41duielOvATQd4mVoEK82kWwfhKMz7tTvnxS66vD85BH/pvez5ig5j2hKMXmiuLJQZ0Nm8fm+ET/D9ozuAn3q8GJP4y30m2MzRiZqSflO7S/MuVWK7yy6sKpKZZUDXSsnx7DwaKDZhenYYqwBkVm2t6usHWhy2EoRihh+QSXia84TVnVZP9asvmGYWMFEyp7ZE8HXhwFfaPQmJzKjzVr3Z+jviWVyMU4jYhONu8b0j4Bs1LbqarxVR0VnvOs3DM/A1FH+T5OJi/fE+y8Lgikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLWcm9WIExL/akK83xvgfBADD8uMHByth9Gw67f//UQ=;
 b=JZehqGrvN5gEi44wgOOD8DemYtWRkHgktt0R8DEyY2A/7OiRotot34DQCSAOiSHjVnwJFwZ9gMzW0nYh6of1npEtgGN1aIpfI9KL8CKU/qZA1h3OKe84Z9hKsJWx3vGh2+oXKPNHM8+Lem7aLDG23y+j0YZZUIxUpeXJI/2XxID/gL/vYlvUlr/Vx8SdmXmdCwfWQbF7UK19aPVXeRyZyGTqSjQWjHYVJE9IAgBOMikKA67mdP6GdX4qeNZrzk0ueGyNyq4cSVaOaoFsJ2nIbKvdxrQxOdosfM9BzSJuRA3DzHNmZtpku1Q40fXBmnrja2lCsFJEgJSZNDxtHB4MoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLWcm9WIExL/akK83xvgfBADD8uMHByth9Gw67f//UQ=;
 b=y+peoFj2rJ1eK/0/erGYRbxtWMRbsVse9J9qRMaMoL5Oy9tW9Npwg05hMK1IC0qj8uRG7M7fZvzLGLYHhgASsVMkBKtNDYo/2/fQR6iTq3a/7X7Rdtb3ZXphFuy5glOmtoU2FouD5YFF6Tig1ZvrVSI2RIShxP5YRZZ6vWeYhaE=
Received: from SA9PR10CA0016.namprd10.prod.outlook.com (2603:10b6:806:a7::21)
 by SAVPR12MB999168.namprd12.prod.outlook.com (2603:10b6:806:4e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:10:16 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::3b) by SA9PR10CA0016.outlook.office365.com
 (2603:10b6:806:a7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/13] Revert "drm/amdgpu: Set default xnack mode for
 gfx_v12.1 A0/B0"
Date: Fri, 21 Aug 2026 12:09:51 -0400
Message-ID: <20260821160958.753063-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|SAVPR12MB999168:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d78767-1a7e-4002-8f77-08deff9eb00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: niWZarSXhYiSB5GvOd+3aRHLxfv7XUc40FaRtcTnBlk8S30W7OFgAQ6+5svG5IUc7/zZu7kSSMVZtoS7QyhIya687ho5czT6vob9uSzJKfc+AtWPqir47eNeoZJrHQ01ZzBtLjxyAuqKM4o9nYQtGMCyddnztThRuww+/ALLAWSdV/9vzx8YYKAu+Z9FKMhd5rp0TbEtBSdc9B8dCrX9gmLIUE/4hRWeLZYpYau5UNe8rgTKC1+6a4rej+dakkfy24MvV/duRsBSLh47OBRyw5jSYlEohwC+pnVOsTHkQWQ45a6/BPUwQRb1uQNy1EpgS5rgLpOea9qkcXLcjbyyDHGOFZD5IZ7E6620AHVlUfnTTLdjz0mSfHyxuDV1dq+YPOprZ5xoa7XVBFfdMJNF2fm2AkRDR9Fbp54kE4c0tyHcXKDc7dBp5sJphFKLCB8ay9q0BkRXPnLGOuI8NFqBsSWLYJMJRf8XX9rFRwaf7+Lhd5NkaDcZC7YrmqDj2CYnN36Qojv/gBFnLTipxy61SFgeA4fNKCnkl/qtEfMo+K2VwPzcLq3KH2DcUdgBFmD5GrwLtCkPcIdlEy8KR6/ZmjUCXLWnRJGcaEB3C1fvuAeNuFPGTLZhobf30qa1yordtCkvtOyZ82q+nYsP8cqyBHt9GYPdjjxk7rF3lOjrlpbmQWa0EhSxe3Zht5nae4iZYwLcriuhBDkGhiP9kiw0Dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bHD3xfXzOdzG/QmzLXq1eOIPYJKUTzIImBWQHTjhI5klpXvKmLJFOXyd0ACQ1Ni1HHC1lb/DtFDl3MHGopTmRdtVHhTeyRokJQmdJOvq0KfI9mYWIdN2gjgxAzt3bfXrwI80GT9c1PMYGoorVduvdcBPxMwETVkyksSfvqPUkUAH5nBRiT0gFMROVoapAdLwidWHZ6orRPilHgw3YYE5GJBhQkLrGs8R7AHDKv/mJR2hRM5/YDYZG4ZuEH23eRVj3fU+HYXQPDU5hArRssqjTaxhuJV4gYZFcbkFUtxD2QE0q4P2CQvoXcQRaShgOR0DEk6pInRzEsrg4rnNLEtHj7k7UvTK/r/Zp6PPW+/juGFZO3J7ACOQH5suKMEiSVJEHgsEWF1AIZlGbPxijToG47m1v0ypkGdwTC/Xqm6Qrt7CQrgO7dqgFMPICGdMQEEg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:14.1340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d78767-1a7e-4002-8f77-08deff9eb00b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999168
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

From: Alex Sierra <alex.sierra@amd.com>

This reverts commit 9dda228783bd035445cd40bfee8158035a98930d.
Revert the rev 0x1 (B0) special case for IP_VERSION(12, 1, 0) that
forced noretry_default off. Align GFX12.1.0 with the GC >= 10.3.0
noretry default.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2f6d20c00ce29..ea0228129d5a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1017,9 +1017,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 				gc_ver == IP_VERSION(9, 5, 0) ||
 				gc_ver >= IP_VERSION(10, 1, 0));
 
-	/* For GFX12.1 B0, set xnack (retry) on as default */
-	if (gc_ver == IP_VERSION(12, 1, 0) && (adev->rev_id & 0xf) == 0x1)
-		noretry_default = false;
 	if (!amdgpu_sriov_xnack_support(adev))
 		gmc->noretry = 1;
 	else
-- 
2.55.0

