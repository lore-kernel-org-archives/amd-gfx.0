Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAB6C2FC0F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69DB210E09D;
	Thu, 17 Aug 2023 18:11:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8F510E09D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:11:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX+0VL5ZJ//7/FJ3deSb+rQCKB0sQUnCq9Xo1N25JNFtIH73c6lrJFvNuScfHCqV/wKl63+2IXuQ6/XUtHVyJa2G2S/masULrHyfapi/qLdYLRYaIrpWiOCBoJ8HkQmBpGbfXJltXPrydxC/IncVoEdxQvg3Go28rg9mnyRJZ0dg+WmbdR+5c+NSN4sC/sqvVMuyt7pwLp4Z0UsDKrOEuSjcSUgFzgDMb5avNKPmYMtZ0AHEn5E84kg92UzZiPa/x1bynJeN+CHQybins2E4xOSLHUbJ5dLqWG2bMnxdr4/T4BEKl5s0k9j421vf/202l+2j5kRU8OktV7Z5ikeXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAcmELAAeYml+JWCGlIC9puAtjHXwnbk3g6+f8SKgQM=;
 b=ZfS28RptsVWVDofBiX4ix54hRcXcyuYeH+HvXRsBi8DIrLpuVIYH7LB5DzLHzyQNRCvvpTG24D1yJDHuNoF6HQpEOld+a4SpsQ8MYtn6gYoYOjSJwy0F1jYBbLeFXIzbZduNvPBLvtQhGtD1kdzh4ygq0UlquCIi3RZlAZAqb/wvf+pT/vMrQHEju2AtRSp3Pgump9U8dqNbqNf6lBd0tDxxE4MJVIFyif2gep+SqAiJutuZIMeGGrjqexqV4gUv0NtGxzUbRrYg2UQ38f+DmQYwh0wUOklV0UZVCPqNuSa9Kdga7kgduLTy/yR3cSfhBi6prJzyVvcuxfzvesaQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAcmELAAeYml+JWCGlIC9puAtjHXwnbk3g6+f8SKgQM=;
 b=EiMeQQb7BCeXyv+XYitNwhdCW5EQnlr1aCi0ESm0bYYpechZ4sPhYenqAlu1efdnnYoODeQhcsP6nPUsafW5mF31pjF3nKgjISAiE2AaHWaDHQ+YMn9RpeqfxnqWKhALG+zPk3ZmleVzN/J1GverhjhDFSyEx9mQIwDwlz01EyE=
Received: from SN1PR12CA0080.namprd12.prod.outlook.com (2603:10b6:802:21::15)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:11:42 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::60) by SN1PR12CA0080.outlook.office365.com
 (2603:10b6:802:21::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 18:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 18:11:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:11:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/9] drm/amdgpu/gmc11: initialize GMC for GC 11.5.0 memory
 support
Date: Thu, 17 Aug 2023 14:11:14 -0400
Message-ID: <20230817181122.1543473-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817181122.1543473-1-alexander.deucher@amd.com>
References: <20230817181122.1543473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b983168-a0af-4564-3a3e-08db9f4d6884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itnT2LEbgpFam03S4W98Ffwk5DP1mDbCNSndtao4mPFzgdJfOE3V3SQI9EaqE80gBr4UN0BcyY7+ypNM9ORWLGN2vC5YepyodWZ4w3366PfyQ7ubg7Wos4bfhvCE4cC9ly1GFPjpqx7F3dYyoN7aeEcIWFO67CjtUv6nCbqXcT44gexjXBQTU1QLUdRqL0R08qMLURE65qOKcDXe/Wl9UXdUq9j1PVNrwxN30nGntmz2HfArE77dvAq8rSqpBlr2akhPDOBBFnsg3Ja3u594o4qTRrmmLIvbj/v/CE8EjATOJKHY7pwjpzs7hqkKNx0NysTlCZmi09m+Yug7LARtBHFjksSi/gNgxm46hawtjRy+5NmnBaQDrupSQNM94WzYX1AjvDb6aX4rVtgqYdZ1xebcWZqiK8mSsRfSYsWzjHr66aPfBKM8dfkSoHwjEC0zN0Qzmumui3MMs6TJCtSt1nJEv5N97Uk8FHby/OQsr/Mdz1zxuu/10TUzaIWj60Ff5C/Vx+7T8F9ufcRfqVfwMA0FqAzO5ISBChE8medpS5dIcNrVCP8sL/LKA5oaVbO87TrsVWF8mPyaPZAuZk9tXy+0jy9vErE91/TY3Q6P6TI+U4o9BdDcp9EcJI2Mc1p2rQ6CmcGq0lpmCfprApZGeVBT6nQVqyE5/G2W5M8Zl2Fi+Pp9YQw71yPOu2H6Nj3vRoe3xmI8uU45zhDmNrYMlt+5SSUoEwcpVHZ7Ykixc0bBM2YP0F5OtSpohAbnkwfpUpggve74ukDGIp6HpL8Ndw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(4744005)(2906002)(426003)(336012)(36860700001)(70586007)(70206006)(6916009)(54906003)(316002)(6666004)(478600001)(7696005)(5660300002)(16526019)(2616005)(1076003)(26005)(41300700001)(8676002)(8936002)(4326008)(36756003)(86362001)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:11:41.7382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b983168-a0af-4564-3a3e-08db9f4d6884
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Initialize vram attribute and VMHUB for GC 11.5.0.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index e3b76fd28d15..596571c94529 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -781,6 +781,7 @@ static int gmc_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
-- 
2.41.0

