Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65807F417F1
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D9E10E524;
	Mon,  9 Mar 2026 14:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u/RfeSRo";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD13E10E522
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS0qqMy5MXY/BJKwVNVP1yfN0rcnzaYO83rDw8mvAXc/9lv5MZfHgQhemzQgc7qcgLNgtH/gBSEDqsvfaS9TLt5j4IcjbQS6cwNYAemGEHeLZGoyWFO/pDxVp7Y9T8y+I0B9cEl8Jy4+3j4NQXF79kFaC62t/fhI0JjQgoHwPqwdPc92iIsuQirDyzqO4v+f141kthHxuZardVmPlFI3HAuz2yJOEwc70eOVgOF8Pp7RdN49AhQJGFQRtC9eKp5/EJAxwLtm2n46OEaBHaYQf4jXGzNEBBhcdvF7UX+W1zlsrtgT9M29yv7WGT2nT/04hA4unAXUMsQOivOhxnDtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4WDusScJJuIxgZSQHocX3M51jwlj7Faqy1ZfhwdNc0=;
 b=uV+lu6Eit52X8CP5dtJBj/ih9zZe57au5H22gwkhPIfXQrGH+3En+N6lbxHOP+f10R3i8CTvb1l6thhjZJ7x4JZS2BNTkIrsfFpl6FzaJWFYz2aejlrPUmXX5vzehcubGRm0PgMDMUS8liMybCZAs0+UjtVYIDt/+sfPuaniy9K3mynYhWihBd4KpcYHk016JrWftLky3EwPAmDjVyIXq0GbZBh4RRYuYRs1NuF496Tg0MyVJoMOKVSD+y7bZDLcMCBbekPNiQMazRQQKwj+pdsEg0YrLSJDhxTRkRrIIFEkAt4m48z2pi6QPODL45umePQPHC0aOedAiX2cEMQYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4WDusScJJuIxgZSQHocX3M51jwlj7Faqy1ZfhwdNc0=;
 b=u/RfeSRoqgKH5VnvSUYsTmPvjAp0wTqFYl91dVvQMHdUsYv9wmPGpqBkgnxQrbDYCs8jCab2HFY5l1j0C5aOD0g4wmeoP8XtSucfLfdsO1jE5TDztUKv0kKJzeIiPj9YKuroD3d6upJ0LChihGget45IvicetuCKtlMrhZo2RU8=
Received: from SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:57:14 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::88) by SJ0PR03CA0378.outlook.office365.com
 (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:57:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Jack Xiao <Jack.Xiao@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mmhub_v4_2_0: expand gart aperture to gart_end on
 A+A
Date: Mon, 9 Mar 2026 10:56:28 -0400
Message-ID: <20260309145629.2844495-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: b17d37dc-acff-44e4-4c94-08de7dec2616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: 0oFriEDSqnPnfRZZGxwxBJsVrkAJJcbBFKU6ua2nK6AWOxtX+WuHc2QwfNYGB2OF+5bxg0o5aFbtCzt4ORk/gCuGggRGSXkPfIxJ5TfLMK4w02mwpOwwCTPcAfNZUpKlCd/Vf6Vb8U9KZ94BLP/mWiQmgSeWA/HhxnrqJg/9oP6NCTvu0nQW2PubtCsOqdNbHd4Iz89oD5giPbxWB2QCzwXOwMhV7dcMMYRHN+iuZHmGLJYiTZJlVY/CKp79Mh20muzQNIVl7dTXeGDI+4dy8bCq0fLT+uQ5ZP9cv7EAOoAgGVdhAIWDsQ4JLWfv7/iVBfm3IqHSaB3iMhquPZmSAT2ucsDzbxUu4nIdwq8Uc+QWNBCA8Manjtu+rmtOAZAoJ6x5y+pmD4bRYatWZeOZ5+2w9aeDVihPiSeoplrGpHh6hn8GyTeGXnbETvrnj60DZLLcknrA4TUtlKmuev0MjKj27HvAoLHjeTbFzCgh/Y5tPpr3mdul0vHPnxgXRGBEx24KCf0LuxUDZvYuaobJ40mhGUVTXbYXYuXfnXoxMWIPMyfbBQv33rgEv9IqrcT/TD8L308H41aoDiTolKSH2nlHzb96c6vEWjEa0rbktydLngIsEc6ipN4tQ4J9JEYA+eM+Qk+nwHIEyd4cWD6QHJFnS/s/ZwNlrrk1RifcTCUQ/kIBQtxK5DH76eG4nxvD+vZDIhpKNeDyOSoizbJskBa7L+mgMV8aa/YR9Ssz6pNXI/TXlBt7Uo9U2eRduGfC/ncWgeLgkC7B44feSYh8Ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7DciqeEKTQllUvICAvzEgRz5lL1r9cisn41alSB1hMVXNxedC3nyvNHRT9guWuwVZe4Z8AGYk8i0h32oou4bv9SI3/A5MaoG1MXsr0jnSbt/OYPL1Vdo2712XjbyaGFOQtjJarBSbpV+r6Rq4Cx1K1OHur4OZJOssoLs/C07VR+oUGUClqKN+Y6iwsgY+u6uCO6qfHFkDGbSrxPauB3/Y4PWtW1Ky9MIpcVFaZHHxhyvM6g9FEKD07PhqXM2O40mZ0PNvSdGdbA5R7KzugGPCFmQ6/ofstOw54JNOPR0JlngvO0uxYdZ7YfXBaLQDcmz97mQUd3Kncxurk/iqYiJ6bQFypWbknUiwxZ9IqAHEknPJzXH+qA1iSB5qRzZNqpVBGpCjGnUJVUwT68JXxsntlBIWVHLSxL3YwHfjUIP5qz6MITYJ9JiCk+kP1GFsvhE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:57:13.7132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b17d37dc-acff-44e4-4c94-08de7dec2616
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524
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

From: Feifei Xu <Feifei.Xu@amd.com>

On A+A, sysvm aperture is used to access vram and gart. Gart is placed
right after vram. Adjust gart aperture range in mmhub for A+A.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index b025c1fdc52c3..97a00075aa7aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -191,10 +191,10 @@ static void mmhub_v4_2_0_mid_init_gart_aperture_regs(struct amdgpu_device *adev,
 
 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
-				     (u32)(adev->gmc.fb_end >> 12));
+				     (u32)(adev->gmc.gart_end >> 12));
 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
-				     (u32)(adev->gmc.fb_end >> 44));
+				     (u32)(adev->gmc.gart_end >> 44));
 		} else {
 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
 				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
-- 
2.53.0

