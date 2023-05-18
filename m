Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9127DC7EE2C
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 12:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37C410E518;
	Thu, 18 May 2023 12:21:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FCC10E092
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 12:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nubrNuC7MSi92NLd2xZfvPAWOazBjuaUraJlBF4pwv2Ybto7osfv5GmFqtATLDykRXwRkI1wV4790Izz1ak0XL78eOXfK9Gua0SFitr7NTH1zxGUlmlYCpjGdPalsSBXHqydoIfdu6RjQXFXL6YOhYnnOLNx8K/zGccJ1d5f/la8EvILj98jiw150sv3NoCFf2czH17NONL+YsGSTzg8fdc3sA8sO+1hvbAArWANUPHGj34gwDvBz3CqEUfPtuVKHP+E8Ny6hrbMHix4rG/jnsvLMdaAWIqBr9rZCB1IeAwtelHKkniv77J83ILXuoYA8Od29vwfkZGLXEYl2WqcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIggiX2/sxkqK5YyMzWk/Dmfm1ouT8Pebb/LKU5mt+w=;
 b=LM9HCdft5bQa1Gu5EbquSs8aMoC1v/3lLlIPiWkDhiStLVb9d34c3+Bh79+SZmqaP+DMg4gQEpMMS9+FPMcwK9Ng2/dU8jY5NtNON42AeT+8StNY7zqI4xOj8afY7zyUr8WuxnXfT8vdQPd3PGlnOX9jnXq79eJQT2FCJR09H2PnTEJt1PntYXL1UzB9MGQN1rlyOp1VJ+PBGelz/DVwDxw22AD3+xUpEzRiLYHO7zUHQeORcYRFnoEIefxLJEjI3uQknpyCnqqeSFoKtfMdYBpBTFsrXZ4U71pObBdaMVX0U1g+V6nFE9T9GmYoRvWe5JUp5iDvPhCj22UZxqp2vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIggiX2/sxkqK5YyMzWk/Dmfm1ouT8Pebb/LKU5mt+w=;
 b=T5cjOrOA2//uivFDLefSXrWRoNxJWM3GzhztnZPStENqnEh56+DDtuhAvaclFbvQZ0yjCrrVNvtaFBbA4y6wfQmYq0Galsp9clVmTULOWKn3JHQQFBA1Pg0Xj7FZiyw/R4I7KL86hV9q3a0EXGSi3+/CzBzjTGkTfOQ6Mhjd8Qg=
Received: from MW4PR03CA0013.namprd03.prod.outlook.com (2603:10b6:303:8f::18)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Thu, 18 May
 2023 12:21:45 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::b3) by MW4PR03CA0013.outlook.office365.com
 (2603:10b6:303:8f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 12:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 12:21:44 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 07:21:43 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/6] drm/amdgpu: add the smu_v13_0_6 and gfx_v9_4_3 ip block
Date: Thu, 18 May 2023 20:20:54 +0800
Message-ID: <20230518122059.28815-2-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518122059.28815-1-shiwu.zhang@amd.com>
References: <20230518122059.28815-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH0PR12MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e471f9-fc3b-4959-323b-08db579a71b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhuMhMHUbFX2o9IUprhV+WiDK8wrWn5+bSLQqrmfJTrZhQeESUWsjkfxFFsmQU8Q8MoZ1lwKYhppcis6XcuYnC3ljksQGQZFkDfFiekmi3Oujo3LIwdicTnqAd53Iomj/teAqEOCyUWTf4ZVxeQEGG+ZsC+F0cxmU7RGJP4UlKXAUwt61QhUY73q+XdQwFq8T5j7kzKPyGBDYxkOLMnbiUXqfh3YaHB8NRFpnOs7FYV7oaQGHylqR3Vo137lXBpVLEehNUObZs+Ml/T9nwuGY23uGWkTxDsFrs3jSvuF12SUOMZRXyoHtbAcsD+jCKPNh2SWgWtILG0wwqge7psbYs2z6OLaQiRvHrDdDRhLlbvwFhKS/eYvNoYqC7xtZPQNGyzVAaUElPUUHznLyAj0pa1NcbL4mOJU3nChT3/IqZG45ZUKV9HRS0dR6zr9+cD1FeQ83AF80jAb5wWInfsMc/Z4wqP/DIxpAMlDRXMW65szau3qk79bgrHcxhD31v/+a494WEH5YWE8jgyanrHomkRmi067i7cVzVy4G+BsOTG5EB6BbhkHA6DakQRX82boZ+nARsOowgONfyJjP8Q1avpm5pOpHD4uJyK7ySuuN4G6onMrl7bbRdXccviEe76gWyIfXhBoVXg/Y/4QZekYmuBCSEJclLSp6bfRPlNIhuwWsgyxj5H5Yxxu214zyiLMDjL05LmSiWE6qKXVST8N+kwya48EF7EHtuyiDKMOdJC6Kgdz/gBsZ5qYfrMI5UWIFoQYVSkhqflt4ITpSbHNMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(316002)(70586007)(6916009)(70206006)(41300700001)(40480700001)(1076003)(26005)(6666004)(478600001)(7696005)(8676002)(40460700003)(5660300002)(8936002)(44832011)(82310400005)(86362001)(16526019)(36860700001)(83380400001)(186003)(47076005)(2906002)(426003)(356005)(81166007)(336012)(82740400003)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 12:21:44.5840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e471f9-fc3b-4959-323b-08db579a71b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
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

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index caae6bf2fd30..a0685a5ebda6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -30,6 +30,7 @@
 
 #include "soc15.h"
 #include "gfx_v9_0.h"
+#include "gfx_v9_4_3.h"
 #include "gmc_v9_0.h"
 #include "df_v1_7.h"
 #include "df_v3_6.h"
@@ -1795,6 +1796,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 5):
+	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
@@ -1893,6 +1895,9 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 2):
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		break;
+	case IP_VERSION(9, 4, 3):
+		amdgpu_device_ip_block_add(adev, &gfx_v9_4_3_ip_block);
+		break;
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 1):
-- 
2.17.1

