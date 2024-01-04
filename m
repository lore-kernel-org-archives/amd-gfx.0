Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EB2C47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 10:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE38910E402;
	Thu,  4 Jan 2024 10:05:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC9610E400
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 10:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn+aBNZbJqT62Gz9OK9RG1Zpn7hk74FxagpfeVky89zRXj1nookA7DsDP0oOPFojLH9ojCCF5+37zbzuks3vnt1GnoNSZM7rqto95Dh51upGeTSHrQckFcC/3Nin893V5f9PABXv7CiuCW90N5sOKYh96UdRb6Mjtm3xgjq/S1/gJuxtpuOLudWlW98WuYiOEZt6g3nxc03wHFTj5L4yngK2JX8HhNKIOPIb7i8JRNMjEGxWu+fn0ktOHMiWqOIxbM47R4VJ7t9BAEjznekkCZRzfHjqaElX8nj7y94XyBXlIdjDX2WvkCGLCNf2vmgZC60HR3k+L2cu3ITfXYs0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKDc4AxsPsd66bVVAoNFU3E6jIwQxlY5s1WIeiH6iEs=;
 b=nESA+Oz0SAoec/6knGKd2aDC67f4l5S7N2WosaAyXGNVlIDax4kJZGiirdWbx00ZubW+ErKKEBmPHahgjAtA4Yrerfiz0AAPO72itAbgjRyVp7rM529rRsfFVH6eL1ln8rLsL472PHSYeavl/FKMJTraw5Q7q8DVjrsdSQzjnfluisdW8FPhMmLKRFtQuE8Pqe1ply3Jksk39WSMF69IowyLHSnzK6O20FJwcQ9rWKWDJ62QxgG3eIu9e/InHo1C2UxAmRtP3oRBaEzHXhl0Hhb2AgxI5MWybWRctzfM8dZOA9UzKqXO6bBTX8JiG5Q0pAY9bQIXXUNoBNJBYLF9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKDc4AxsPsd66bVVAoNFU3E6jIwQxlY5s1WIeiH6iEs=;
 b=B/XQ1DVJoVn2DSZEUTKeivNJSpdvyaPtPmfE10kj4t1rwuqBnh7jsFl4nhm5A6Dg5LnoQ9bailgXMm+YNAMOFeitG0CD2Ly1H2FmMs+EhM0fut21oI98XbaIqUyWiYe92MAxEY0fgMA6DKlws1QPBtc+EWW3X2FZ0u/6+ls1syw=
Received: from CY5PR15CA0111.namprd15.prod.outlook.com (2603:10b6:930:7::25)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 10:04:59 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::fe) by CY5PR15CA0111.outlook.office365.com
 (2603:10b6:930:7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 10:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 10:04:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 4 Jan 2024 04:04:56 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix with right return code '-EIO' in
 'amdgpu_gmc_vram_checking()'
Date: Thu, 4 Jan 2024 15:34:38 +0530
Message-ID: <20240104100438.2363885-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 6094fb40-1275-451c-444d-08dc0d0c9c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPa0IYOoCnINBqLezmTjUaRP7lnPDAQI2o+q1aOtFMDZS4OeSJWshiGkoxCb8OVCseB1TuOuSxRIs/qebUS8aLfRlwNxOd412ALYnsXGDfutFxt/R9qkDgHMvGDGLoE3KskhgLuqU2HGdHufNbqVTssrn5fUbxM3h2ExEUKhmT5nnKU2rYKK6mpFwxZaUnpTx0KaiJwavig+cbPiJMbnw/hXtFtP+yFRi+Amdv2H3RytQKW6gNgRUgSfNZ2gtBmFw/1zLbuACMJH8Hoxgk4LlrS76/mTtTaRPJawzGjbk9UCjQYfbW/TaCgZQncQWX/7mzvDqSwN07Ihzc0ozOhjUwtk4vmMthepz7qfoGtCDAfahWCNW1jVXOTRPYFnsAEmflnv1COwzsVg5h0qcVm2/TC8MyZnfX10OC4DxrFEJTHkdw1GPqLByrul+samm/tEkQ/4FgDX3DUwwHlEOEKumVEbm8N3nC63M9F9rPrKLhMKK5cUVLVxGkJTAvihjXrAOEecKOCK4HlUTCEnZAXMAgup/986qqg2Yp9Q48D9PGZnDBK/jp74G1QP9NEhCwMDYJG2GwsDWgvifqL7RMXWYXxGF3bRM1g2WgEE5bWoboCwJJAK8YcZX5LkCAJ0w+dY+/tQZpkwPpovYzlSlzACxhHhgGjcovTS3GY81PuOSJNDGOTDBFnNMgSG+dgKPOqxCVb6UjEPWYm55wB7BRqN/Q4VQn1MEKyCLi/dOJqwse2RFbR6iEv2YfxK+A9xAQdj9TxPhNjiAKMDR3i1oHEqPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(83380400001)(81166007)(86362001)(316002)(41300700001)(70206006)(82740400003)(70586007)(356005)(36756003)(5660300002)(36860700001)(47076005)(336012)(1076003)(2616005)(26005)(2906002)(54906003)(478600001)(6636002)(7696005)(6666004)(4326008)(8676002)(426003)(110136005)(16526019)(44832011)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:04:58.9654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6094fb40-1275-451c-444d-08dc0d0c9c2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu_gmc_vram_checking() function in emulation checks whether
all of the memory range of shared system memory could be accessed by
GPU, from this aspect, -EIO is returned for error scenarios.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:919 gmc_v6_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1103 gmc_v7_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1223 gmc_v8_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2344 gmc_v9_0_hw_init() warn: missing error code? 'r'

Cc: Xiaojian Du <Xiaojian.Du@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d2f273d77e59..de9576b243aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1046,15 +1046,15 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 	 */
 	ret = memcmp(vram_ptr, cptr, 10);
 	if (ret)
-		return ret;
+		return -EIO;
 
 	ret = memcmp(vram_ptr + (size / 2), cptr, 10);
 	if (ret)
-		return ret;
+		return -EIO;
 
 	ret = memcmp(vram_ptr + size - 10, cptr, 10);
 	if (ret)
-		return ret;
+		return -EIO;
 
 	amdgpu_bo_free_kernel(&vram_bo, &vram_gpu,
 			&vram_ptr);
-- 
2.34.1

