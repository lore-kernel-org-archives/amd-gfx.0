Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C93F9D0F1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025FC10E663;
	Tue, 14 Apr 2026 19:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="180S8wfF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7511810E662
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAVqCZNrVSr3sksOvO2xyeCAIyUlrYC6wRIvI56Eql62JQd3Z5KFMiEQJAXHdZfN0vSC0sEeY/37Wi3XkxyMLOIP1I1p13UYduPF2MkwiS3dlDUBGOLBlqOlMRycCOqB16Ix5/421x4P5wMYKt/hXjJgbq9DOiUXOxPCE2Dg9dXSuCpe5Bw3RM45kYb6e3Jqvhz0fKG3LNcJ7Ym3t5thnKPjJqstpOP77gWi6B40P6A26U2N8LAeKB1fUPWthDUn93dN1pCF+vd95Ne4XJQsUFcZyNqg3zNwgHnHgHUzU3nmthWNRVKqeRSq6gLP/VcSWFVteQhRq9Uh0NEcs+R4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI+cCTdbKh40L0rzL1LqILr5hV2Cd5gxCgaZpib41ZI=;
 b=BzqErMe/Mp7sRyc860DTXppFHXo4hCOdmqwa8wmr2IZVWBdByAz2l0oNAlfSvYNl+bbItFkFknvqIs38SgwZsrsE4nUivgQwYvxVw2VDmn8uuF2U2U7OPBSjIIJq7MUoBXRBt/DdukLmxgSWwlT4XXq4m4yBJVEMN51f15p+OFHLnkp2U3ypa5GyS6CzSFejEijKG98+JJ61EoxCNWrSCTjFfvCC0HihLx6YblkS7cn9qxkJ9ckFN6MBhjQlpxPkK86x0Yx7O9+Ut2e1EOTKsDzCDgNqHh98cx2jmIj1Az6Wq0EpzDlWIr0lwxdktGRBzvwo4DzoLkJRFSyopyepLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI+cCTdbKh40L0rzL1LqILr5hV2Cd5gxCgaZpib41ZI=;
 b=180S8wfFn0NQpsNdF07ElQKUcgsZ1rvPiO9YVTkemhnSPd/WPgFpuKIR6t+MoT7UnmH/Vzd/rPBkCGk4P0WXNGpRIEtteP7n1NMVujzkY9KorMxgBHVQ8gKN2keBRIWKK4HA/+9NSbXT2/d6eY7/aQDQFvPjOItiz8jlj2bZr+E=
Received: from BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::15)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:49:41 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::d1) by BL1P223CA0010.outlook.office365.com
 (2603:10b6:208:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:49:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:49:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:49:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: make driver manages local vram allocations for
 for gmc v12.1 A+A
Date: Tue, 14 Apr 2026 15:49:24 -0400
Message-ID: <20260414194924.2214196-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414194924.2214196-1-alexander.deucher@amd.com>
References: <20260414194924.2214196-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d67595-395b-4857-3dd0-08de9a5ef80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mjE6qrbEycvCTnK5wE3QAaE2J3wa6+/+m+0uwMKbs2FZgihgK57KQuHyDMiyhw8nZ4tWzOkJjunn8YtkpfLr93rVlLghFPYawmLn4vVW9d73llLcSpQ2I0z4FXvfq4JWoHayUCMPXWzwKhHeNcCeTELoNxWdqw5fwrVFo2XEjnyGtjk7WDunuzxPZYUDaueRSvtuoF5/L8WmQYsBDVAb/ALErTVb6kKxugXtX9hzpu/9FBlSa286hWQRAC0wpE3uC5G1Y47yoPuDz9TjZUnYThXzdOiJ/GCWHnzcaJyndwBPZFtvvR2J0fluGcAq0wpzeLBq6l3KT9EH/LflDCebIzEb9t8NRPEqJpT7psxYVWYqFzdP+8zMddQdtEPnVW9qDHOigpcwCkQTT0T4B2X1qNlsJuME5V8uDRA+UwdWqNMIt6QcDT/dvWwmIoS+EQeBeMlB2LNyTN4IoTg9KmEdPzst31B8V49uZbJ0Qc7/IVqThCY5p9z5sXRw0oRkZTEXRg5uzY9LwbW+gAhWjzxQkMGu87rYnBrtBdgN8tSDBryrAcTo77H1sIkDSXqdrMuCB8Fb5bAxqrf06NVKrDO+wSp6dvqc3izvik/6hWnI7bmo7Vtj5OBd1vL56a1mZMXYCm5Rh+LNNJzwyzHQsWnhhUN0k+PgFJQsEXmf+b1UftLKKsq0WdA4JYSDdj6wZAQl8/icpIvFLQalZxKX+NrgiCdlsqQ92AAhwh3/uPIxI/0o7j3leMSkBkWEhnM7wlQ5Wb3xxiVZGLsBlF7ImOqyiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dcpf8EkZYeDjTEX20expQ6ZhxhEokDC6sy9jobdcwfSOyzLCzZBh6buDguo5kWijWg9a/2oUqLM5QXrUJmfclb7d0w0aIaJAdTiJnKtxnUyA9oIOi8oHE26erhTY//ThXXINzha1IEQsaY5jN8za/OpGaiFJk2Z4qMqweS5cb2sHHS/ubVDhyvnL+tOGgayck+wY0zA+0NaJDKDz1NYBu9D4MOBCC+VwD2ga4JdXQn1iylQ1uqokb7CJO1MDrOsFr70ZCTdk98K58gYpZF9bqJbgFiupIh+oq8zkF6D6GwbInDUIile6xRkBXSph/C/ClGix1UjMWKq7Ya93bqefHDeY7G03DrBU+eIr3Gsk4ea8M84ygw0rsFaMbXp/CM+LxcEHPiNNmFgw8mD1PIAxDGGS0pvk7SFli3aUoeEPdEez9Vw68LQSiZo3K3CIAkSr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:49:41.2105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d67595-395b-4857-3dd0-08de9a5ef80f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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

Limit mc_vram_size to node_segment_size to prevent allocations
to prevent allocations on remote HBM.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e10ac9788d13a..5bdd4b9b78934 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -729,8 +729,10 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
 	int r;
 
 	if (adev->gmc.xgmi.connected_to_cpu)
-		adev->gmc.mc_vram_size =
-			adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
+		/* On A+A, manage driver allocation range to the local
+		 * node segment and prevent allocations on remote HBM.
+		 */
+		adev->gmc.mc_vram_size = adev->gmc.xgmi.node_segment_size;
 	else
 		adev->gmc.mc_vram_size =
 			adev->nbio.funcs->get_memsize(adev) * 1024ULL * 1024ULL;
-- 
2.53.0

