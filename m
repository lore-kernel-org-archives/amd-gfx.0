Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE87FC76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 18:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B5B10E038;
	Mon,  3 Apr 2023 18:00:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2923010E0BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 18:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf9NqGo6WCFMcntnAHHSAfDxm+2XSMWJpGMNlnL2bkvsiwp2TtxmCIPypIISnCsKbJAWssPeO0vp9smKVoBa01rshTAOpfdHeqQFKQuNmrKVQ30g8miRHfx+CM2X1hmJrqkMt3Utcaa4fzMAdVdZjiVILER0L9nCFXueykCPqK4p9BcMIbdgGpYsZ1hEY/OJBJ6lFtb2w/JKf6GoEBFFaz/bhPh8sYYgKCI46EIneqyIJ+vyKogXn4tFkGxSptUX/cHb51Q5wGoySz4rQE+cdGojwlz9cvoscupDAmqwxxjcTJrzyYK1e12KS0ldx4LUDqhgS+5xuSu3rxd0dZvEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtiMRMtZhELG4cWU4GgyN/IQegD4k4wBL7SkFGCsu6M=;
 b=GXRRBxiF8p0PE3t3BIpHwjCG7ZD+86qDyBFIEe+rU41S3THtiAs4WG2sy0QoDaBI8vlgDD/cWHPOMks1EkqPk5MywbsNUTel+tBsl/dOOilxBVCsufnwDwEu1jjj+9gk4IAZeDpBCosR9Dw4IFzmztLruQyeRmRgHhL3JYWDzq/MgZlRQpLPpkUQNno51fS9dVSbq/OhR9nWXOE+TwxeSAXLPHehS8mQWIGTfBMfEOeNIT+B6Mwi0EdQiJ+KFGioov1Otqy6CycejxpG/FrM7CtYajL6fDq9Tql9CHBgli9AkpdrxaZNNMW/Mkn0fDQJCulQ3W5hst7pWbzE2DcMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtiMRMtZhELG4cWU4GgyN/IQegD4k4wBL7SkFGCsu6M=;
 b=z19ov0Z329VZ64fJbY+gzEtxESe9idAlCLlvSsM1vvEinCzhr6scHfDRuov5oghRDB9nXcBtLZsN9hcKxfwzX1ELUGT6+mRNDXb8MekB1ut7zryZ7eQ1quDbxpl/IlXzZN1aaAPDVzvY/Dj4wkLZCzaClplvT/EuqvH7jo6l9y0=
Received: from CY5PR22CA0008.namprd22.prod.outlook.com (2603:10b6:930:16::31)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Mon, 3 Apr
 2023 18:00:05 +0000
Received: from CY4PEPF0000C96B.namprd02.prod.outlook.com
 (2603:10b6:930:16:cafe::25) by CY5PR22CA0008.outlook.office365.com
 (2603:10b6:930:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 18:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96B.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 3 Apr 2023 18:00:05 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 3 Apr 2023 13:00:02 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix dmabuf's redundant eviction when unmapping
Date: Mon, 3 Apr 2023 13:59:49 -0400
Message-ID: <20230403175949.131530-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96B:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 00039fdf-e3a3-4ccc-2f90-08db346d416c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHN8Jv2VQ8bewaFIft3tzhNtRbi/mdHsK+PSNzPvWotmKiht/iS7Xx6VMYNhR7fZNTnRYLKXuaFPr/HRf8NQ+hRLMyqpB8giOGzT6JYJPMN3EO8x9paAnMy9WgxFgonjIPKMCcqDtyrYEyeV2LYL9nIOZgBnXvkAnKtWWCy3hY2cpXtfdqQmhqapgzibsZx6TB3dMVnlxVOiAay0b+zw+eSPIxBVV5BBRyU3ga79P3RFKB4b/thdmloouTKVKUAS2pU0l+yDWdN4uq+YchOoVo3VTbv3fJLnZ2d30hC4s7c3ygFf8doomvCjSSlUiWqrjKW9WtlSyoVlT0V6p1rfb+cP6GkwSx8XW56afcHS/OR9tIIpOJv0qKmmYhUVA80DI9bUqKGZTTFN6Ttm82whrioZQc8MURqx86lK1oBdy1DyNi+IJKd12cGv0i6MYTydTfvEJBPjz9TlUuv/P5Ca9r8qmTUqqT3Qo/jP/SkWar1m6bDt2DFBUyFVjNa4aIpmv75jsMl88Ng7FQY9UqT6T+bUH+NXbOFQurrE3W6LnkRQKkO+3w+lojlY+UJ2/tXPe19hE3ejwpP9kw79v33f9g/1ocgQtglG9JxD/tNTlUutFTYIp4FzSQxxlqCAemViiWe0IVyuoiOyLXTmjHBfyiiJDLO03fHWI+keoWjnmsw+LhdRfhUxeSiIaKi/pqvIrSXnwACfDwflY/JvxbG9nCUgS2qOHGldRyN+v4tAVEs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(6666004)(7696005)(40460700003)(70586007)(6916009)(8676002)(4326008)(70206006)(316002)(36756003)(2906002)(82740400003)(81166007)(82310400005)(356005)(41300700001)(86362001)(8936002)(478600001)(36860700001)(40480700001)(47076005)(1076003)(426003)(336012)(26005)(16526019)(186003)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 18:00:05.5808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00039fdf-e3a3-4ccc-2f90-08db346d416c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dmabuf is allocated/mapped as GTT domain, when dma-unmapping dmabuf
changing placement to CPU will trigger memory eviction after calling
ttm_bo_validate, and the eviction will cause performance drop.
Keeping the correct domain will solve the issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a3b09edfd1bf..17b708acb447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -642,7 +642,7 @@ kfd_mem_dmaunmap_dmabuf(struct kfd_mem_attachment *attachment)
 	struct ttm_operation_ctx ctx = {.interruptible = true};
 	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
 
-	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
 	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 }
 
-- 
2.34.1

