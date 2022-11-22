Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F06C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777A110E386;
	Tue, 22 Nov 2022 05:54:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E7A10E1C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvDcLjzfE8+os6isX9T4hvaLh2rCI3BN1DzmKNmAdvGx12EnewPBXSOTX+uJVNsw62NjSV1l0uqFEw/eZzqPiIScMr7Kznht34rfXft/ErJLRwNr9rjXOgUgx0U8nUeY5QKuO9w4RS4OWSb8FD4bGPervD9HM94QDZwpzcDi9kQVNn7MVZfozBcOkvjxZqU3YjMcAtTzFgU9+lpJBi0+9E4Ca9fZ+5QOvA9E1zdwvxVE9GAHlmY24rLRMMvXxM3NWQWHATbI3sieXVo7DflqmtYbwJvcw+oXjx2IW0LVZcUo/9KqPioxtjybZwtcmC3Q9ro3rnlNK8gcuUMrtqnrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F02YzU8Uv/FmiHNGPVuaZ8w9/vFVCKjE5oZUtMtUpM=;
 b=XMtQZPTYSeqVv1K8CptSBItAAV9/bBqiDf6RpjvO7WXAPdnrsgK0k8uI9o1WMJTImG4E0sxq1VlaTZKx8rUXxqMJyRqqMai6n+OwKm5li0G3IHJcpImlFd6m0NglxAjaSOuq6h9Ji2Iu3NsOu113hP+jtXx5hh3Bp1t5p7INr1jQawo4NLlNVEDHMVlUeaxJuFU5TmN8eYTwB1R/0VzeiBbkyrjDh4zYOPzL7Ax0Wpsd1Dd0XV24we8j4VPY/W9OCbBiBVl0QepWEe0F35/cYlXmKl7z9zLVbbaTZFkbegRQF+vOEC+8MX8xWq5zAdzMQQuNSSsLr9D6GfRfGyAprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F02YzU8Uv/FmiHNGPVuaZ8w9/vFVCKjE5oZUtMtUpM=;
 b=15SMxnUddlXxv6hMLtpo9G2jT+qtXdKodAt35mXKInFWAfaXQUdmOmSSlT5lbPAHoDg2cK2sOxN5seEz4xnTEnI022HJrYxATD3c/x5VesBHf3ZLmIDYwIBlN9qc98Kjhml3eQaTIQ5BtmXtYcjHm2pDurY0tethp8by8uPwVh8=
Received: from CY5PR13CA0043.namprd13.prod.outlook.com (2603:10b6:930:11::33)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:54:45 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::93) by CY5PR13CA0043.outlook.office365.com
 (2603:10b6:930:11::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Tue, 22 Nov 2022 05:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Tue, 22 Nov 2022 05:54:45 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:54:42 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/19] drm/amdgpu: Enable pg/cg flags on GC11_0_4 for VCN
Date: Tue, 22 Nov 2022 13:50:24 +0800
Message-ID: <20221122055025.2104075-18-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c123e45-42f3-4a42-13c1-08dacc4e0eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aj0VpIe/DD/Wzxx/RGe17wLeAsxoeNCUIwupUmMbOtow6ByNbJVRBHWjEdJEBsOynjRpWPD4jlypsn+RJJb9asXhvtROxybbUEpcKlNXkbPzmlBFw0uPWXSvjiu48AF3RsHlIzHzmzu1QIMKhyZOTFW+7ITiNdYiYRsvRT3mQoud8ztWiQMB00vthN0KtofKRZBiU3ygQEzjBvoX4lxXr55fFBONGUk8ccv+o4GU/9/LDjYHNe006TbG0yZiTaMEV7J3ApOfqBni0iDVOtgiiab+ExVwafrmush2uX3wmcuKjinmoB8A1bkqrdi0m/0Le404fXqAO/cCQnUWhx3wP0e2aSLprEO8tLS4lKR/9Ie5JDWjxujjBmGgDTXl5FEOrWYpIHfYKPjzbPdf//iaswcnMEiPuWpwLm4eLW76JKMFpKSPgmlrR/uc2YYQmxvsquyc1KwKFE66FYe32uc4N/LC/5SV5mzB6siOiLBtKrJ3KIfyRYUCsddLLI3ZujzFpqsnMjKg9olTRcl+ecORkgsgxfg+FN/Vz03FK+y+Jj/gm7lMiN/NRsakNs4YSlPnL25eAjflBUCU5t59KPnoxnvLA8F90mmi4OBBOK2zIXWWxqEn6l0IkRmi4EvMaPX5BeV1KyAmaI4NEZgW9AKmCpuOm295nRqiVi0X6kfeWOonUVUH1TyFKpl7n0EbP0nVHRyZOe33/Pgv3ECRSGasvtpUTvkHjQEO3ma+vsmCrnQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8676002)(70206006)(70586007)(4326008)(8936002)(5660300002)(4744005)(82310400005)(41300700001)(2906002)(82740400003)(83380400001)(81166007)(186003)(478600001)(36860700001)(1076003)(16526019)(2616005)(356005)(47076005)(336012)(426003)(40480700001)(6916009)(54906003)(86362001)(316002)(6666004)(7696005)(40460700003)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:54:45.0861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c123e45-42f3-4a42-13c1-08dacc4e0eab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Leo Liu <leo.liu@amd.com>,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

This enable VCN PG, CG and JPEG PG, CG

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index ba11e06d6941..7ec428279d78 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -646,8 +646,11 @@ static int soc21_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x20;
 		break;
 	case IP_VERSION(11, 0, 4):
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_GFX_PG |
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
 
-- 
2.37.3

