Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7BDC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 10:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB7310E8B7;
	Thu,  6 Jun 2024 10:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zNog5vgb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C8DE10E8B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 10:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJNwM0AjErS3QQjoBbNZzKc12xCA4BocggX1Q0Rl6Pb8NDtF/bWYCDqUK2YvFYm4gR01nwm40ZBra3es58S+ygUpeA7tDwU9yuIkHDtMEDMWmDXqYIKWf7Q/f8j6/cRT6D0u7i9DitUA6YOOZjrC2XuLjMWqIgOa4gYqjGLv43Hq3SECpRDDtNoKVZWjiMCrOMKtUB3K06utcQGwZYvWYtmALkK6jNgNRyicu3Hk3hZZuJKYhUsCI+N2dl9mxEBqGO0KHxlluO+f9ZHqTFX9sCdZo1aMvhQKY+oM0vUc17qwhiFx65S0q1lTQm2OZ4o70OflPVx/IocMr67C+idmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2dI4vsEJn/1E1z8MooQv+8TwfFNwx3iFd5Q5fFbDxg=;
 b=K+zJcBuGnqOnh0G2rmCtJx8gtMJM0sBfAOK8U81Lxyajvzop8Fhyn4DH9lMdhbhlinTUy8v6J/4HSWzyuqSrtbZKVRa2NY5UgPSP97xGjawcFiuA8p41aJgxl3qa0Jbrtvr+FQaX+vaDXECEC0dDwqm5FOTI5YwMNaRhKtDZ/Rf+eafOzhNXTSUzZ2pfy1+DnsYIRw1oeuDvC2Sp9mg11jWLRxQquzsGcTdFwk0HYYpeneVBlayiGCgLV05l/Jag5CGzW1K2imqmMMucaIOqMq+Z/066gl3dpMaYyAcXgVZXVdfOYCijCGLMOI+hyJaPhTVs6IuMfz2R3xSgbuUC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2dI4vsEJn/1E1z8MooQv+8TwfFNwx3iFd5Q5fFbDxg=;
 b=zNog5vgbMiyNwhLK/NlWFhiaqI+86qhK/cTLy3AsWinAgLd6fq7k+LKF6A1GtqJLb3eHVplcFMJu0AsLJBP6PlxwWSv40j1S51wqBFZFQrA2fvAz8RC3FEteIN6cWeblDWKM+iMY/CpMceLz0fdKPMNTuGZNAtGvfzNb3lhfn2M=
Received: from BLAPR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:32b::31)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 10:06:02 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::60) by BLAPR03CA0026.outlook.office365.com
 (2603:10b6:208:32b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 10:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 10:06:01 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 05:06:00 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: set RAS fed status for more cases
Date: Thu, 6 Jun 2024 18:05:46 +0800
Message-ID: <20240606100547.22269-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: eb158bdc-36f1-4eda-1624-08dc86104554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RYfqGZwu+WtvIsYoq+M5MJ23ET/v5+yBVAl9a6EceMGUBW948tsCJeam5iGY?=
 =?us-ascii?Q?k2fRpEzmQOSZ7WZuCCYy9JBLkFTw7HwoCTDD7ReTY94ReQItrjK42zuginsS?=
 =?us-ascii?Q?w956Y6W+qUO+NgBriulcP8IDxMgjwCQdNgNqpbQn2kCbA5CpuK0pPJ7OziG3?=
 =?us-ascii?Q?kQlhPVtsDVCsY23/SUUJQF52jl89R/p0jS8I8snxgHusEZKYLbhA/IFl5+I6?=
 =?us-ascii?Q?cJnBqSbWg2bWrdr7eeWaS1TUftDRjq2AcUHhBe+hzB1KHKON/jepisLCk61d?=
 =?us-ascii?Q?7tVOuufhzeLjsuednmvuWO2ifqRDyeGybLT8ZHPOwtEWbGRT3hH5SMM/IAj7?=
 =?us-ascii?Q?ju0VEpwl2uBmpQ138EF0uPNbYre4fjA+hEnyNqneQS8bd9XnpqSDLDQdo+ku?=
 =?us-ascii?Q?6UM0/ISsvM6/2qGtoaR/WG5jXd6jspnVkkPv1lxYVDtTMiSI/ZZmkAmt+tK4?=
 =?us-ascii?Q?5aKD+Re3rTuJ4Pvu3lbvU5hQl6b1wv3LmAC1OmzUUJDdhxDgVF3/NL5vOjR/?=
 =?us-ascii?Q?vyJoiQV7l0REghmqY4SDqR7L1BsO/2f6Rk6w6CSHcZA8IMKOcnX/c+6+KDkV?=
 =?us-ascii?Q?l0kSpAhZBOvFTPQM5+2cwFQUOM2EDHXRkBl8bp+WIbGU/omUSQgNNlXrMSs2?=
 =?us-ascii?Q?Bl9qZoaLC9Ys2ugokU0Z72szzjl503iu6my8vINrce9hItW/1DRphdmvaaEq?=
 =?us-ascii?Q?5RBBGCLwRtAoWHf9NQmeJ+8iC37dvtAlZKyC0U8TuB+4xuvfysOETmhG4nQa?=
 =?us-ascii?Q?shYC72us4TyKIfn97DbL+G0Eod6FYvZXQeIJ627TfM3Eo0aWXZ7LzCadaQjB?=
 =?us-ascii?Q?sTk/2NorSUaodwPcdCJw1C5C5SuW2CVaYQ2yUCrF1Ite/9A6dJJuAVf906pq?=
 =?us-ascii?Q?wcgkH61yLSWn3Fy+dXVaUu4VmLgQW4/HsH2z0MHWhOZCPWPMY+9emVmPsxvv?=
 =?us-ascii?Q?X7z6r5wlrCQv6eT3fGy40l3uCh08Pute7f53lF7Ale3E2RR5GHP7RoiY35Zh?=
 =?us-ascii?Q?2/Wh1iJ6E/z4SOpai4IhiZudllxhKrpVg36q69+coqngqjzyInFWAVgONkuY?=
 =?us-ascii?Q?NCNgJh9fdwXxJ++ieKUR5X5d89qXQjHYgba24sou19GFA0dhg8TXmavPXvLX?=
 =?us-ascii?Q?O2YBFwYOHbt+c+gDneckv170ttwy1kCJPy8mGrirKCUh5Uy8jFz7vUkwap7Q?=
 =?us-ascii?Q?N6LMDoD/joCaA8T2hqJIHmWvk7b2OM7mC22tLafbTZlRo5yRrK+iTvyNgifb?=
 =?us-ascii?Q?S82sbaTa99jTwFE8my4GPSEgKEAAjJ5l2KxZX4S51ry/fXD69CLn/cnvZHdN?=
 =?us-ascii?Q?EvQ+K1mwCkz/vLKg1GmkJ0L1ujk+WQvmw9idFW1Da6u3Dxf5wdWq3ThK+Vag?=
 =?us-ascii?Q?/mj6umTavtMhgCNzwrVjjGR1CTwVSvRNmcyeXNlq3PsrGAtRlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:06:01.9880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb158bdc-36f1-4eda-1624-08dc86104554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
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

Indicate fatal error for each RAS block and NBIO.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 77566dcc0852..183eae22b687 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2114,6 +2114,7 @@ static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
 	/* Let IP handle its data, maybe we need get the output
 	 * from the callback to update the error type/count, etc
 	 */
+	amdgpu_ras_set_fed(obj->adev, true);
 	ret = data->cb(obj->adev, &err_data, entry);
 	/* ue will trigger an interrupt, and in that case
 	 * we need do a reset to recovery the whole system.
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index b8fc9e126e0d..9446bf6f82c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -414,6 +414,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		/* ras_controller_int is dedicated for nbif ras error,
 		 * not the global interrupt for sync flood
 		 */
+		amdgpu_ras_set_fed(adev, true);
 		amdgpu_ras_reset_gpu(adev);
 	}
 
-- 
2.34.1

