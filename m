Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855BBC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 08:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A0D10E3B8;
	Thu,  2 Mar 2023 08:12:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F72810E38D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 08:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk+ZoPna2UJJz35kmex0yIcxabJCLZTG5qFW/4Rc+D35Ugt/oDb9V0ALptIi3DRAHgk7UfGExsKqaWkXDZeC9fHfoUUBwMUaPiQtzX7H5dHn4IMxsb9jFncI8mIgAfoOWlJ3+WC49tN/vtHWC6i+4dmAM/5YxJOVVfWQIQYXGuZTyhB5ucbbwYjujAf1l/fDRQUq12J9iU/HcI4Wja48WrMAf29dOfVn9zZdiJPZmV7ScM4PmFvWW/Qjqir35LXNFadXfdOAg+AG8y5WE37KHdHjU8u1o0whZoRDQRgQiB+0c6sNwHBSkXsYgl7nO67Jv8Ed02MvioylS84F9A490Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17phVKB+hDshanC8t43GyLSRaDvcpxsJmyBADSCMxps=;
 b=jevez/Nm05Eua5C+19ypiofFHdqQRR/La0Iy9ZKK7iuymBUnVc3lVKi7j6pTGNAe5aSBNlE1J3EjUmI3dOCaNsCmHFeYgM1w5YT8ytnvC3q+81SJ8etW/DjrDRWCg0M/bJRPYkbu2rkbPKgnmvEAxZyBoq8XRvSJ96rnZR7UCJMz1bqhCHpxv7JxHcyIBnmhnRcNR/o8QK3RG9OWllguAS7PNathXHLWD/EUaRh/VZkco0Wy/MBppOG052CFQd0GpySdJyEebhaxu4w6X35TNoivP/Y87rfVqazF+p5SuGx8BlN88CmB5UYKrfjCcivPiQIOI2DsWvBVJwYrl96RyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17phVKB+hDshanC8t43GyLSRaDvcpxsJmyBADSCMxps=;
 b=UTWpUDgWvvqp/uAgybuKmRtMyKfMiPjsq0ZF76Wd9+7Mm3o3Y7p0MiVuDx4t14zNf9xxxyGfAxVonwqnW4sSABuNDKCVEjdYQHRV7zk+5LZEW0u1Fuu6GMRR1f6uuMzcVv5QHDqgaPmWPJ9aqqm97uPraexFvTvG47f72MypIYM=
Received: from MW4PR04CA0218.namprd04.prod.outlook.com (2603:10b6:303:87::13)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 08:12:43 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::4a) by MW4PR04CA0218.outlook.office365.com
 (2603:10b6:303:87::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 08:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Thu, 2 Mar 2023 08:12:43 +0000
Received: from leiyaoyao-Super-Server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Mar 2023 02:12:37 -0600
From: Yaoyao Lei <yaoyao.lei@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10: Drop unused variable
Date: Thu, 2 Mar 2023 16:11:29 +0800
Message-ID: <20230302081129.3143796-1-yaoyao.lei@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e41692-210d-4cfe-fdae-08db1af5e614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0D0AnoXD80PKoAMkL6xE/vBWsyC05xagn6AgLkBv4IG7VfUPjAzjTQgHrOXXusMILQCSoAj8KvD6ijaOjUWXKcNYUN151EWj7LL0MxWgrrLLa2QnoJm6FvFa7uUcb1lqZ5s89fJHT5d2VnSJtwnMfwVBikt6K0D9AEwHp6Ot8rusWF6flKL3eRu/xSfc8B0ylqxUgT5c9kd9Ea4C+iK2yzY2GcBflJwJsBWIBvI37YqjO3XwrpcBDrMXnZBNT6mtfKKATnUoBcMOzD6BABBdSREyHD3zWcRPnzrqsT8hLL48EKNoRiJZg4e0GC/LrUlEGT2b0lcYYA9Bx6XN0BzhE7FWjpVX2b1b1DrhaW7qItp/f+1sKRh8dc3+GIulK2Sw0+98h6LsMvyY48Dfts9KW5zHAqsiAsfrgAYkddw+B1rTc5mXrhaSoBgrK6KxzhJCnqrHhUXgVSF2gZzYnjsIdNWKS1dDTBXZpCEwIbPP69ioU8eo9bk/bMJKePBfqO3tuI9d+2QQuGAqucBhg4JtUNzNjhIAmMOMAzs68VO9V7AqO5Hck//uwVAp/aPoeVoSiESD84tC4IzAGL1n51DMteRcsMGnfSsE7c0WRb0twunDTO2ZB2upfn+/8Tzuis+oM++UP4O+XvCeYcte0jd76LiGIOx0Jv66d0nXtnTCRohQh8hBjkx6lCMtd7g5N6aAH5LB6DHjITbIdVLAJ8kyVXtkrRBogoqVTtO9bsvlA7Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(46966006)(36840700001)(40470700004)(70586007)(70206006)(426003)(47076005)(2906002)(186003)(36756003)(40460700003)(16526019)(478600001)(40480700001)(86362001)(1076003)(26005)(6666004)(7696005)(356005)(336012)(2616005)(316002)(4744005)(44832011)(41300700001)(8936002)(81166007)(82310400005)(5660300002)(82740400003)(36860700001)(8676002)(6916009)(4326008)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 08:12:43.0627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e41692-210d-4cfe-fdae-08db1af5e614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: yaoyao.lei@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Trivial.

Signed-off-by: leiyaoyao <yaoyao.lei@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 073f5f23bc3b..516409989235 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7266,7 +7266,6 @@ static int gfx_v10_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
-	uint32_t tmp;
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
-- 
2.25.1

