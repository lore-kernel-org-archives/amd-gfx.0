Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4AAC5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3789210E1A0;
	Mon, 10 Aug 2026 03:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AGiOlC5b";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C4610E1A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzzEXM9zA9DlMx0MWjW6xgM8DmfM0CWS1coe/4jI005mmu5s5KsjcABAe9LpWvyLFN8MDkVN5rByYumNp3CRzleyskWrFebBMlyEeoxncaTysySrP7Z/K+pN8AqR6Pdlsw2WVL1IcY6V/g3eYl2UJRVOozIUB1VODxwptGqyHLbVKiTeqegbklM6WJU1wJMUZHGPzPb2JcFyE7GbmoDrinANXAis/QcTX72T7JBq/0DKEdJ3XEl23KrOTeU35BLBvYLgJ0vUghNNdHBiJtrDIhiW/QDmh2Et4TWN1kfA4BzrK4Of+4bwor0tV6DFGuAQxOPI9hyxiqrOUFhkAyl73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH4j8bLFbqihp6PwJhaUPwhrIz4js77EOieDkvmjlTY=;
 b=wRFcZ9gFBvr0M5SqT5Z8iXYpICvHgNGLk370jKMvcsf6AE5C2e22+hdMRUxf57iFwpcJrv+9fNygWrt/SRiK1V/U7nru6zl8zKJCIsP5PbLOAM68lVccL1OpUeyHtxkCHNEXQl7ibfr7NhvAtf5T2eNBCh0qCOHq9Fa2bMsv0YD1gyflRsZQ0bCDvFk/wBNK9TBpDC5BPMaAoe6RqT3n7G6/W2Sfvfq7PNXMqGxj5O4EI+0S1Q1wTVyS8ycvhwZnkqcZOZW9ff8dd1o4dL+WG7JBPCLOs+5OH7qIIVymrtr3bUf4uOYleRLcguIisg47xBZIVtmqdUBGpE9Nog/KkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH4j8bLFbqihp6PwJhaUPwhrIz4js77EOieDkvmjlTY=;
 b=AGiOlC5btbIV0/vj913XIsT9vmO70+9pJVju7l0nsamHcLptpLU6PBpXxQri2dw10o66xpPgYV6qxWIoYMsYCvyLJYaLEK+H8W1Rzp/xr/VGehFS1ypKwFXpPSOKVasVNkY0vnwCLcHc1ZZ2zQw3Bszhgn6UU0NYyuo1B20i0EU=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:06 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::8c) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:06 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:03 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>, Boyuan Zhang <Boyuan.Zhang@amd.com>
Subject: [PATCH 04/13] drm/amdgpu: Correct VCN V5_0_2 doorbell index setting
Date: Sun, 9 Aug 2026 23:36:35 -0400
Message-ID: <20260810033644.118194-4-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 6831e81c-e1d0-4feb-aac1-08def69135b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gr2/r7jJWpThjkEswfWe4XH6ILcEg6iP42YOdS0GhLVCzhSkeoNylRcKop3XPI3gxj8Q/kZrhi77R1W3hW1bd9mqQEp8sTdAWonTCpRG7xdOcN6JxzNzbyrV9QvjCSCogydKvd+yxbFrwTLj7pkRjETJ4aQU29LBGv2Pnid7L/7ihelOWJ4rWVLv1b20pBA1L/mLtGDpYnXgldK0zhhNidv7cubdsk12nVrvwnNv0aq+tkYz4oX0aeF1X6Th5ru9q9BsaD7AcjdmTiSO2EAVloeDGP6g9wPCSaVMCxu2F0GWNg4nkaRi/2T30i3AMTjSou+Bgy6Cl/kbb9ollwlxn2fwTcrZLCkVqujNMfxtLEfSIKs1L2QNU6zLff/agOYDFltgl/UDnfTiqy9OU47CUK5NJeq8e0AEocnGq1z+R6mOvwDUHu9A9VkzH9BajgP0N5VWwSi4QxH3i+/B7CILWLC3Zu1Wze9KPFCexmOJXGiDBguUha3d9TxOuoulgE47t0BZ/sRri6FQiP9kuZAcQCxxttHYnSZz8fwCs0WP8MJr1o3cnjIezAy2YZm6v8uhPXGv9c37zl9t3+UmosFmTUOrwr7okjriabqQj/RnorwOl2bWiMOt+9z8fWCGW0ngnQtGO9Y+y54ludjomZQ4z04zfSD8Nz7XIh5W6ZUbHSCNTUoR6UjbIvILC+62uOA4HYs2y2Q07s/FtGO4WPhPtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5ey9EBe2rIdwEszeRl8eK9Ulqf3kiJKPND+ej63peoZB1TCwu/GRyrNlb2+Uw7Esutd/rLdUYAdvwHHY8z4qxbjUhYBf0Bg6lbzVy1DtyC60HWkw/lUSWXuIqfH6nQ2OeJ6vQi6+rc+qSwP/JnlMlt63c3m8Fkq/lVCjrTmbE52UZFo9KELG2nWTFgOw50ryPiQ+GeDyX0QRiVWCwvVeTRgeCRidSFKdc1NpziyUnl5QZrTfCYJWNFMZcoBUz+zYyQb9puqly7yEop2Ccwt5xF5LO7t7yuthRiMe2HFeba+PrmiXnnne9erXah7sahoek5qyUu/+tlYnshgqURWxt91HYfgAP65k24ddFuDxESAC3kwXwU/MQn+QguBQnsijylS/ZnfanLSN5pTRdZTdeeCDykd7tU/LBJAzk9Zqf+sXcRWQSF6jbRAlQUbFKa1B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:06.4221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6831e81c-e1d0-4feb-aac1-08def69135b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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

From: Sonny Jiang <sonny.jiang@amd.com>

Each VCN 5.0.2 instance has 11 doorbells. Use an 11-doorbell when
calculating the per-instance VCN ring doorbell index.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index b9f6ae75ea72..5291ebbc5c3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -129,7 +129,7 @@ static int vcn_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->use_doorbell = true;
 
 		ring->doorbell_index =
-			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 32 * vcn_inst;
+			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 11 * vcn_inst;
 
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
-- 
2.43.0

