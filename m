Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85979C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723C410E54E;
	Wed, 10 May 2023 21:26:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9373810E54D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QChn6qIpY0CrQst41t2exICDZusZezGymvn5m4FL5hPCFtXrFtslM38K9JPH2oSHrGS6mGRMaMMxkIvhG68PGrJ4APgzmgbfn4qrcJlCDCuyVH03dyI7WsWq2q/pyG/HhLLrq67dmxtpHrpuez5IDZuzSlVdB4Xah3jngrC4emLqadSX/Nq+GRVER87CDt5qFUca422POObGGkWyXDN7DqoLny0vS74DdiOvg1ZUR7LozuLmkNRk0yGe81JlzOnn9fiCISDpU77vOPxACu7FwIuSL2zunZQRbLrQ7ECFZbUvKhCRN4wp4sYZEw960qXqaFLd8jphCprbyYfhBpmUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qxddD9LQxXthAqjQz4t94NacRkXuoKtI629WPVSMB4=;
 b=Ja8vbdw0z7RCugTSxRHTd3zTK0ShrE/KCchMyL+1u9lB4kJStCxuETQSvAUf6gLJiCGI+dXXW8/BR1v6R2oWkVo2s671+6YJDqT3KgRBtGtSDfE5jeik6LDNWge8uZKSmyrunwMGfd31sFyM5Rnfhj8mGO0bMaK4GeiLJNiTg5bgix6EfPOM6nfNLEwHPcR8LZGkVEwQsWWY5c+f3Wr5CNKh0UJB1URjA98V//zn6HVu0QwBIYwh6OXg3o6UPJSeM9yHq2a4gHknND4PfXsofww4yjYaKX3f1T8E0VH4Jwf2I8mt+f4eg7v1GZQyuZcqRgr6MB+XdJ7klyoWJe9Aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qxddD9LQxXthAqjQz4t94NacRkXuoKtI629WPVSMB4=;
 b=GIqyZMI5MRZT7v2VYch8Vcc+Ui4QiX0rbbvPYij1MFgK9u45VeOd42+T7ieNLIqbHlwSR1dPTJbBbN/2osFnLQIV/cfumYB1ybYPFzuBvBm96CUVCt16Yd5LlzOoGqpQ2j8E2gP5sM6z+0YssDKFR8jjEH5zx+wFo2ruHKPy7X4=
Received: from SJ0PR03CA0165.namprd03.prod.outlook.com (2603:10b6:a03:338::20)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 21:26:40 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:338:cafe::3b) by SJ0PR03CA0165.outlook.office365.com
 (2603:10b6:a03:338::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:26:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:26:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: reorganize RAS injection flow
Date: Wed, 10 May 2023 17:26:22 -0400
Message-ID: <20230510212624.2071771-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212624.2071771-1-alexander.deucher@amd.com>
References: <20230510212624.2071771-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aac0d27-7cc9-4fc7-ff69-08db519d3e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGUTNGi+c8Ao7RxiTmkqBzJ2PLGAwNIxHsjNvGFh5oHhPbnY2/97YTzzR9JLQL/zvf/8YlQCLRUGRRy3nvNAqeSOHy0/pmpdVo81GH2oBNyi6sXcFuXShLI7RHLVHRdjhPH4CJw1gInpjE+xO1KHR+hTzThETAxbU7yHtAwUDPGNqpkhh7nH+nuCv4tlwe9IBOmyYfFQxfW94KiO8Jej5vvugpGbmelRAQ8R8wfQP3f+a25TXfaWYSALZz4TlXQCmf/SCmarv7I1zHuo5DzW3lk0QPhwvx9g23gLwQSAIAo1g6v3nljGorcP1G9wBLBXZNYeRWjYk2bt4o5ykb9GTxtncWmG2uQJulAVvhFngfHXxsgc+ajaXZxi0t8PYz8EuBYOcO8dPxd/JBfbyGaCjj6TxhtlzmDgZIrLpgXVpFg8ByKHP+pti5p3DyqeMT4aHwVlbC26n6Ote0MMPEu3oXN7446qPLsv+Xqv9524ixbedbLMlK0slkLc9WMiHU7BHZU/qRDSDRFyE4oFAztEQhVX6TMPUdDFDTtvF7vM8HzOqahXiKWqJ7d4f3dx4PXAmA5LyNycUX9ntAwVEcQb2OOq1vyRztQPqA7UjBtxui2lay/KlK/w+Rbs3xPivLno4+AO7FJRt+VXrQtbsvllXtXDlIOS/e8CfzqMX/2uCpekbFjhvA2THy+I4f0mJwmxMAcHLy4420JOlGKOpPmRm29EXu2KGnIMLbkxGsi654IUkd67/+CBtIfckwM1L7yhVLCXyaR2jTiVa1LVySMwXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(336012)(40460700003)(426003)(83380400001)(47076005)(186003)(16526019)(2616005)(2906002)(36756003)(86362001)(82310400005)(82740400003)(81166007)(36860700001)(356005)(40480700001)(7696005)(8676002)(8936002)(316002)(6666004)(41300700001)(5660300002)(478600001)(54906003)(70586007)(4326008)(70206006)(6916009)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:26:39.7026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aac0d27-7cc9-4fc7-ff69-08db519d3e34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 "Stanley . Yang" <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

So GFX RAS injection could use default function if it doesn't define its
own injection interface.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7ae08f168f99..b7d8250a9281 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1123,16 +1123,15 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 							  block_info.address);
 	}
 
-	if (info->head.block == AMDGPU_RAS_BLOCK__GFX) {
-		if (block_obj->hw_ops->ras_error_inject)
+	if (block_obj->hw_ops->ras_error_inject) {
+		if (info->head.block == AMDGPU_RAS_BLOCK__GFX)
 			ret = block_obj->hw_ops->ras_error_inject(adev, info, info->instance_mask);
-	} else {
-		/* If defined special ras_error_inject(e.g: xgmi), implement special ras_error_inject */
-		if (block_obj->hw_ops->ras_error_inject)
+		else /* Special ras_error_inject is defined (e.g: xgmi) */
 			ret = block_obj->hw_ops->ras_error_inject(adev, &block_info,
 						info->instance_mask);
-		else  /*If not defined .ras_error_inject, use default ras_error_inject*/
-			ret = psp_ras_trigger_error(&adev->psp, &block_info, info->instance_mask);
+	} else {
+		/* default path */
+		ret = psp_ras_trigger_error(&adev->psp, &block_info, info->instance_mask);
 	}
 
 	if (ret)
-- 
2.40.1

