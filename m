Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28389C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD20F10E28F;
	Tue, 11 Mar 2025 21:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3iPvd+Y";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D49B10E28F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiUIGfuGuUT/3unGUXX/BM396L2BpOlkZ9qXeZobZ2PzrkUCdEgNVLd1NtC+k73QEKwddzy8uCQkl5iMv+i1Vm/g24kYRNTiLIbFHnUF/BFqgFPaDW1BF2wMFOoo3P5XVHhsDhHPw74QE/kbXdjvwTfoeYsW8342gy2ZOIj1iAn3lCEEcSS5WJ0hwFfiO3e/+52LioXeq0zDx7niOLnR3DiRHITKuo7tvuG1O0FEbzG5qV0xvRc94j60LW1HqoV8ht223Zj/rGqt07/MbXQzYKAHG2xJPiGem2t0n7dTMqtWTD5fOh+37IbqWaOZn6A6Av8Bzb+xsmEyDujS4uNMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwMqMi/MlIfzq233EbA9aQOXTmkwc5ZjIIvDBlNq3co=;
 b=xfHq8UJ058yuFHFF7exR8IoK37Vusdrbj+KR/hiVdviH4kBty0DaLw4U0NhJ+3wKCDQEST8daweZ4TLU4Txik8g4GN4I1O2ndxaxc/XRCU2B+6+UoszrbHfLxB2EIVF2RrwLM+6qcWhX2cH7x7M7yuooWmejxLu2Ant4dePCSHHezu2ZCvBXBI9b2dXFvLEnvGslzwe77PehSJIW/wALmDF/46qrk4C8tq7oIRB8Yb1+TEonA4SSNxLSolqU2J6kTlnCUeRLBqQ8UNiArq+TpdctSm4BD1zos7XBreGuiNPMFktSc/ykIHpA/sW5Gp3Syer0h9jyWYEUIJJBArCaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwMqMi/MlIfzq233EbA9aQOXTmkwc5ZjIIvDBlNq3co=;
 b=i3iPvd+YH0aM9FU9HPx9moroLF5LNoR4rf6cXbM9h5BHF8Im5C3/443zrYqBoPyxEZ5St+MQeA2PpVDct0XXBfQ23UlI1N6hzOfOss3zBoujtao7whLuBY91Fv+teFKmN/KTS1s1TCbakNYg36wEjheFrnTR57ceB7VHC5AmMJg=
Received: from MN2PR05CA0052.namprd05.prod.outlook.com (2603:10b6:208:236::21)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:49:46 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::9c) by MN2PR05CA0052.outlook.office365.com
 (2603:10b6:208:236::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 21:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:49:46 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:49:44 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Yilin Chen <Yilin.Chen@amd.com>
Subject: [PATCH 04/11] drm/amd/display: Fix message for support_edp0_on_dp1
Date: Tue, 11 Mar 2025 15:42:05 -0600
Message-ID: <20250311214618.3106637-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: f518113b-ee09-490e-da1e-08dd60e6a3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oa+VQ3wIrRDhlIyCmGhs+OrJ2kHBWYpMqn4hN4Yy/wLfchwBTCXXjyiPptSb?=
 =?us-ascii?Q?WVd/mTN5pJVdeE9tC9IU/v1yzpOdR7ALuOvhhQ7+1etx54Fl+oMK63ofGzWp?=
 =?us-ascii?Q?z+RJjM5ntfNuNZ9TxMus+uqG4aUnF696+xJqL0na34bUv9Bgt+RxeCkbRRZY?=
 =?us-ascii?Q?XDPbH8HXD9nBDtiW554iNV7gbMec8ymy8qeNGtbBdc2o1KLdV+rFj2afQs6H?=
 =?us-ascii?Q?pc4AxVwvNbId6GHUClGFpQE25IS3uFPxZJhSZ9OwVDH3QtTKDvScLIINfOSC?=
 =?us-ascii?Q?NV6KrKB8mbTNfg/nGsPlfAohA9dmCZrT3AdynHnqq2gCFindfmbRfFCNo8oF?=
 =?us-ascii?Q?Lwo3TIK/qb55d2evsdRLsBajSIZYwtbd4Ik+4hdjAPgosk3lqvW2mjNdMR42?=
 =?us-ascii?Q?gxyzC2YzjHxKIYbEMyU6y4tD1fcBE5zlb/rV/W6fAcoYOZ7JezjA4kk7B/z7?=
 =?us-ascii?Q?+cIgejr0jZat+n0Z9vNQ4DDCcqpw0LXu05YtQLT346lKJ4VrIw7Bah8n78CT?=
 =?us-ascii?Q?CdUpg8/MFaJALH73PWABhUuuVaEh+ppdH/NXl/LkZX1lWoy+Iuf6X31T4drE?=
 =?us-ascii?Q?xlfCqZq6osgVwrxUNifc7i+Y/ZtQNWQVK9cEsU+2YnbvpE2AzKe0nKASAGCA?=
 =?us-ascii?Q?bd8zy99GeUC3Esa7YUGjPXpRPzsHvuIlY1l9YcKW+6CQA1OXCEpfuvbm2DiM?=
 =?us-ascii?Q?2HuQgvFBtzy4KdDrSrT4mH3XqmxcLyzITPynzCV642iMLYYbGMMT+9Pm7jBU?=
 =?us-ascii?Q?hawi4lusYoqax/imRHGPC8mnkpiADRJaguqJJWSogTy56ojenB8fzLBeh0js?=
 =?us-ascii?Q?mjVSjMxm7LxR+nILXdAfKLDgT7lljZMiEc22UQ5yV7woBhjsQq6kIxJ/L9Lh?=
 =?us-ascii?Q?WnUeT6xjk/Y5+7aD/5sItfpNdDiyoXGqzut9xxGfnRMuFBzXfodbpKENZ9RA?=
 =?us-ascii?Q?OagbM3cJt1+9Agv5byLUnTEaDrMVgq59Ax/Mj+IAB0TPh2+qbB1c2qvLmmli?=
 =?us-ascii?Q?Eotv2jihgr/jJe8VFvDdyPLRoUc0FGNzKhBM6WG+pPNRYPxiuYX7aEENJFI3?=
 =?us-ascii?Q?i6vikie6r3RXCCCAbcNQvUkPxmD6hQLI6FthdYIDsOAzxLU1Ql6EgVIkyUEJ?=
 =?us-ascii?Q?tmH1rqLPtaFpAOt3f5MmLRGKIqmceNas3luj0LStebcoBRroV/spiT41QIUm?=
 =?us-ascii?Q?NVt0ickMVFCwyf7mAdxzBB93MRxUSLB52fAz+oSJub4v/ss9Mnm7vRF5pnGE?=
 =?us-ascii?Q?67tfUR01/1+TV8XkOq67D5YzJ4TcUeZmwKCIdU1T0lgykT4V0RahZzQh//mW?=
 =?us-ascii?Q?P3tW141/a8zHcDFrUahGYlGkkhHsI90uEoRqB990YbjvJq0mvORs/OuPd/70?=
 =?us-ascii?Q?xC4WDxX8xtSss06jVbHwHgzt5Wqx7sRErb7vOn4GB2udfus2Vkt73KhGWUd/?=
 =?us-ascii?Q?NtZSrkzhfpyx7Ld7l5IdN7aeYlmY9m9Uor0omh2HvFaLvSk2h1Z4EIIsRjpB?=
 =?us-ascii?Q?XVM01m1pS6GGt9U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:49:46.5749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f518113b-ee09-490e-da1e-08dd60e6a3f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
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

From: Yilin Chen <Yilin.Chen@amd.com>

[WHY]
The info message was wrong when support_edp0_on_dp1 is enabled

[HOW]
Use correct info message for support_edp0_on_dp1

Fixes: c1037b2ed7ba ("drm/amd/display: add a quirk to enable eDP0 on DP1")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Yilin Chen <Yilin.Chen@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1b92930119cc..8dd9bf58eac5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1749,7 +1749,7 @@ static void retrieve_dmi_info(struct amdgpu_display_manager *dm, struct dc_init_
 	}
 	if (quirk_entries.support_edp0_on_dp1) {
 		init_data->flags.support_edp0_on_dp1 = true;
-		drm_info(dev, "aux_hpd_discon_quirk attached\n");
+		drm_info(dev, "support_edp0_on_dp1 attached\n");
 	}
 }
 
-- 
2.43.0

