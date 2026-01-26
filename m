Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F95D19518
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4A510E482;
	Mon, 26 Jan 2026 20:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PbMBlXyc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D209410E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=putynSRRNdxyv4pCwO6UEcKOok8IPvDyfiCQHKjFzacj544NgtBMokhzqCrCXCn6aecONbTr71E8C0Ej0aMBZPQh6ZNsq5NofOzUry5u1R0XXbzhIwe6QLOMir45Ac5ZdK9mJCiuqdHyvy1vWR8vAwSjLfXvE+/n1N9wPDm39UiMYscerinsS26e3MfqBGRJPSPw+qC27/Y3HI3lcBJzH/b+VdpA2U9HPLewqI/kH2QuePKG4UEr8gQHfaNJ766rJF7NZVcGprI4o2DR7Ypx1LNRxVyKwIoodY45MbiivNtPOG30OJzjOxeTihF9VpPWJUvabcvK0sc2RDpCJtBing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE3YrySjdvYB3S4fpmDlXn8+BKUN13hHTNCdkK08NNY=;
 b=x1qhKPQu5n1cMhPQYKZsBDLAr1+xRfGolSG2Zdlm4fm3RtWQdVpB6J/z6STUhvxQY/uG/S82fe4gaqX2M/gKvmEGz2m4LbTQTtYnsd0hmBt5ek4Rwwj5017dDRfb1JIdD1jk71qtwxeq3+BdzuiVPEDMg2v74Xf+vwdXGp7HFICkUB0Ee8aF3Y7o7+tcWO8Yb9eL1/Ke59MVPUObxKX9DEXPz4fa5i+i3DllfT9YnFFh3P/Qdq3dvWpZI7fcZtMYQ8IvI20n8gppGB46sodzUF3aKC9Bt25Nzz3VZnUeAv9UZbM3sDiEHCOXTgiobJgOrI31jTfGVgR2wkdt3w0XIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE3YrySjdvYB3S4fpmDlXn8+BKUN13hHTNCdkK08NNY=;
 b=PbMBlXycI9ztw5M+IwvHzMaU5gs7q3Q55n5uAN/xJHACRD+JTZaInTOp0rb2usJwa5L1kgblCeJQAdztiGaadBqrpNBvdy8wpDa9Knn/IhOCJ1fMLQccRiF3U4iJNjlGoBJPGETaVUhIoA5NLb4GvlX18d4QoHHZym2ezhOTydA=
Received: from SJ0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:33a::25)
 by DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 20:08:11 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::7e) by SJ0PR03CA0020.outlook.office365.com
 (2603:10b6:a03:33a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 20:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:08:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:08:02 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:08:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 12/12] drm/amdgpu/sdma7.1: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:47 -0500
Message-ID: <20260126200747.13527-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cebf2f0-9349-4064-8eb7-08de5d16a181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oRMKfMRuAr7GdKdAQyGQaj/dpgw2FemNiltxAsFbaGZ0QqM7/T6OHnvKe8Fu?=
 =?us-ascii?Q?1ulw3tDagNuCwKxMtHIMryZHwjlJEBnWGYNxRjsuJgxd7xLqm6oJ35sjWRUI?=
 =?us-ascii?Q?BAxI/rpcbuAWmCHJbeMzqFqb/2+dfbHbdYkhd+CA4wQJF2fVw4jPaiN9teGN?=
 =?us-ascii?Q?TZapmt2MbrAPIafZA/o6bu/UgUmsXfzEJWwKL3vS+aGk0hW9Y33cp2HtC6vb?=
 =?us-ascii?Q?0CN4SBaTlLzkXgd37nS44+Mid9xHWrj1w0G0IL8bgdoG6wdrwLZ146s+ogoZ?=
 =?us-ascii?Q?Er8FhyGIrs4XZzwI78STNr8+PtvE8S4XKC4E5D9+VpdPQEgg8C22Y9jq5XuH?=
 =?us-ascii?Q?ZpO6uB9U+xhml60p4h5XBMUfh/nfDmXcbsljHf/lBWTOKCy+GXSyIAisbZlk?=
 =?us-ascii?Q?7N4GUGxNV/qzObyakw8U8TkhTDdaAF0xytaS7NVNCAvq+nG/h31jtM2OLjyF?=
 =?us-ascii?Q?egS7ePmbLY9QIyjdA26gWsJkfiAhWasgHGfNhsQ0fLklB12TslKx8nxOb7PE?=
 =?us-ascii?Q?+aQj3boCUC5snJrJwMLnUBg/1GKSGwo57HWCRXQhQ0Xctn1OPfoehYBJQy7n?=
 =?us-ascii?Q?c3+xJFt6WHr/oeQn08hVeJtQ1ACmIkkKLZiq/Bjslkcx3gs1qis4/laHHDeg?=
 =?us-ascii?Q?TW/6K6wTtX2H3jsJ7PBZpeaFq76VPsjYqUuQ4k1/Tj8GZ7R+S69tndhZA2Fr?=
 =?us-ascii?Q?M35CMTGAKYj+3FSC/xd9BND0jHQKWAAiCHA5TwGNe/lIXuhi7/DFI7p0ovHf?=
 =?us-ascii?Q?Cfj/siCyBGk6LL53Ens/FsRzuoLlKmk407tQ6xrST+RrXMHCgJVkJnBtx9g8?=
 =?us-ascii?Q?XjaVXcrZ4wR3yMp7Is9zOHsg0tAvndY0JKrckPwoibR4kcFIdshPEsXzl/FX?=
 =?us-ascii?Q?bcxW/YtC7i6e0//Yy6DAg+6Hnw/cqilhjjY5gtU5AmotKu8iKAED79q5ozGd?=
 =?us-ascii?Q?ZsN5opLKXBxYEnAkLeZ1uHllmZWKwwtzB2YAvkBuMRgjl/AFwQSH0UEM6XqK?=
 =?us-ascii?Q?edKYl3SbQ/W/d7MlI1+uBH71rrSSS5rWcq8wfYX7nYSzCLMAB8eTX5GQr/cZ?=
 =?us-ascii?Q?Z4OStOyIcW71gU/9uYYjP1YIS8A/MGcFnqFVL0jmHHd1S9C6CVBuguYnAnhb?=
 =?us-ascii?Q?b1f5Jp8j6Txl/fY888ihDJs0cL4PICN4n+moCaB0zAO8YD5cuFyhc2rWve8r?=
 =?us-ascii?Q?iVCK2OZuw2Ec4NIYC1M9Eaq5+h3xsXy6ui/Uzbtsg+FFX8TzzDsGxY/12zi0?=
 =?us-ascii?Q?YiONuU51okxof0GWV5UeQ+RLklJv6rgMqeURVSNzthb4u0mbX+ys5fkAbi6i?=
 =?us-ascii?Q?nQX/b+EIVi2DmcWiM64O/k+nbYa6paBUTR6LlC5ao9gvGPQRi5YXuhOky9aB?=
 =?us-ascii?Q?gWjdye/QR46ffx7MjFVcUmO53qwwI90EK4a75L2qglo6x5zIoaBlnCTU7HSl?=
 =?us-ascii?Q?+3OX95hyZlFIKi7+bjqzXX2PKVgWOzsYN5ehtKIewO9Jus2VfyACLyoI5kWV?=
 =?us-ascii?Q?zVPuqFW1ZGMFuv+MIn3oYxR9yiUijmZfnQOzBVQt36YR2GXapBYhBoYoQ0Nm?=
 =?us-ascii?Q?upo7zPjCyB2yymI8lrnzHxC19eEhtSUKvUguO3lNRmjoBMJwYYGcMnUI8RYW?=
 =?us-ascii?Q?Nbxi5fpmpFjk1bvBrmWYaNpmZRicyupORfJ4BEm87Qbd3UX9MhI/bH4Xc2g+?=
 =?us-ascii?Q?Vdgv3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:08:11.2784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cebf2f0-9349-4064-8eb7-08de5d16a181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index d8167ce18dbd8..38bc0e9edd86e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1482,13 +1482,14 @@ static int sdma_v7_1_set_trap_irq_state(struct amdgpu_device *adev,
 					enum amdgpu_interrupt_state state)
 {
 	u32 sdma_cntl;
-
 	u32 reg_offset = sdma_v7_1_get_reg_offset(adev, type, regSDMA0_SDMA_CNTL);
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	sdma_cntl = RREG32(reg_offset);
 	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_SDMA_CNTL, TRAP_ENABLE,
 		       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
 	WREG32(reg_offset, sdma_cntl);
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
-- 
2.52.0

