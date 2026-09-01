Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60429C624D6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA66C10EEF3;
	Tue,  1 Sep 2026 20:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k9g6+zvD";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8820410EF12
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2iJjuJ6K2nEHqK9DgsEGth3q8zbh99ZDXn+AvbDdzYWehbjQnEY18DXeClf7nfro1S5dDITwCwzS9i1bSfWAw4x4MhuW8FOSnrpxLSelJY7JEFfT0zxlPIkA6WAq/L0Dh6La/oDUDF1V74ISl8P1IXBTxCS6ITVMXHQGxJH2kkb1xJqQrubdWNzZkL1XSOA1+SaiKubL2PPbo8kSx3A6EzqHrFH/MAPSyisOpS1agIpKb9VrPH/381NSO35I6BXQWF5qdMtIxLvrmtw36bTQf15k/vrGq5n0XGE1K39d5VfCXVZnjoJXlHNPKV1spdD3qZEKjRk5r3+N8dAoEMfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFv3TDGl8c8AOSbifSatSoez5ILbuhkmSBUuMTe88Z0=;
 b=A2E2e3jdmgzXTtPGOGxcZvt4r3B6lQ+6ggkySVNCu7VfmNdg6w7YM7+6UjCGjV4pk2oAKjkUMgUqkH1VLwB0MP3FugbH38SeGS8DtZgxCx9fa7jPPy8Q1kh3GSMG+jdZ6ppkD3p9BpQknfBi/pgXX9Z41mVQ/AfovOkTAvBtWCC2tD+MQuRtQFVCKMqzMplM+IsSpZAjWBr5JT4sHSXpHf+VJOdvHEazNDKWTsIgsGh23GdV5238LWp2IY8ves8c19h95FJvtNitomaEWXE2k3Bwkc+KYQLpgVfxbhPIQ9yb13mgFNofWKAgSzYjNUcHIPLyZiUHcR33XjVes+AtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFv3TDGl8c8AOSbifSatSoez5ILbuhkmSBUuMTe88Z0=;
 b=k9g6+zvDvVTUhPAh/oYwIBT+z5d4ETXiyxIM9ISg16C0fIaV0NP+Vpq4UfVQ0x4e+Az+IEcTYberlrRcMZvzAQFVubh/PbnKkzwI6OmwXma4aiYBe3pu9NNsBb39O5UJqIo/9Z2Q6McD/JiOoggKyfKLTYRpP9uNe+J3IUWSVfw=
Received: from PH7PR02CA0007.namprd02.prod.outlook.com (2603:10b6:510:33d::13)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:02 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::7f) by PH7PR02CA0007.outlook.office365.com
 (2603:10b6:510:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:11:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:11:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:11:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/31] drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
Date: Tue, 1 Sep 2026 16:10:27 -0400
Message-ID: <20260901201034.2960437-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b308a2c-6e15-49a3-0cb8-08df08652513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: j9yAdR6ODEY1t183ZKShfyY6jw5z0wwH+RZuUp2CoLnCoSyIz4g9Ajwkc6YCD/E6wuJ6wgiewXQuwggHX5munGSIxItyScTW69Mq25jYizSa7teBxqrKAoAdXoCcVHnGZyaAUaBfhNic1/+CbQZVcYTpYz428myfHlouWZaB73ajTRBeQyoeTxKBaxeP0fEOYVonpo2ldCGtltoWybIAxLJ0Kzy8pfqPYQjbO8qcfg1mIyi1Y9herUpbkKsYRSNveq19PNnfTd10YYi4I/E0bFJRlHkN2QT1Avp6LxIQcw6Lja7gcno1ZgFL6WlPI7z3ZCd983agFo2weQCuQsFWEPRM3gSTFhEA8QnGqJrXeh2y8DxJ01Z3gqbkkIH8kywlfBkYEUjteL+y+y/s9n9SOMA+M1sQ6/LhOD1NqIyPHSYj+rsyWsKQ7/xu5vE2D/m5i7LzDoVHK9RQbfHYY36Diz5gwHkJosY2vrLoSLZ+oiau2o8u6P11z4Bmnf7sMcG+r0O5EhPfL58k8F5x8A2pnSTCg1WQs3370/vK31faQ6E9nFETz4sHrnHgI0qT/N6cVaq1v0xdLCN8B9moupbn0mBr2bhq76d1eeokCICTodno4Zhv7h4/iwm5tS6YM/VlaL83DLNWvbawRi4ix4eCGDpX+Gx1NlBVli8QGahB+a1zoYxFe7hJAH6/gBWFXUlcYjjjL7xz2krGfjXbkt9nYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 72lkpKvGkqeyiiuo7iivfSkIvUpfQukJ8a4hxdz4UIksgvWaF68iNfiufK5yWI4pU5CPv1SwzWPQ/HcPHUxPxU7AYaFrWnTp+F8ic8LW7yRtm4K474MJFJe48i/zb1dPt0NND2w7pK9QEuDdrMinmyXQH0QZf5ut/oRhpeX29oPbxMxoqY617IGPPFYz+da/1BPHLhLjF/MVOdix7bksASsk7bEZGy/422rrx+RrzSvPznFTn170Vl6JD0ypaskATk1cv1ClD2jmIZq4KGMIFCAnsEx1TLKnu08KfqAMz4rOrKmMPMh8QOCcv4e1ywjsmN5QU5SJDLpRmtabRMdUG7LMXIA6gklZM/eh9NNJ0SCCod+B9Z7YmcT0VWdeD7y73lRcP1RApsApxWRAqeZ9DC9NCySeg7I4PQ3N5A1o7yelUM0lJ4zs5wT+uGYccRMp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:01.5718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b308a2c-6e15-49a3-0cb8-08df08652513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648
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

Use SDMA rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e7c529620199b..7eb34d55565cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -976,6 +976,7 @@ static int gmc_v10_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
 	if (adev->gmc.flush_pasid_uses_kiq)
 		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v10_0_init_golden_registers(adev);
-- 
2.55.0

