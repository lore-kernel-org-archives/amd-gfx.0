Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847EEC761A6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 09:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFF9810E63C;
	Tue,  4 Apr 2023 09:57:33 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B812F10E636
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 09:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOphxdKlkknh9Du/qIVc1uCBZE52gVXYEefovLrnnDfJJGtM++f97g+jiH/lz3fmDJC29aib9aqvA/0c+xwhgepnbjIeukdAhWbLomQ03sJtBz5FC4Dh6BBKY6sZ8ZRftrqUFkBEcfNf+WlKONC95+mbLWQmJ4BUXmlxeJs6jX+t2xeOUcZcEiIJThT8SvNcT9CR2ONOT0Osg4FFDViuTS5fGt5SZRGIUcEmUiH+PkmzRRJ5p3nEfjAcqUG7/rY0vOKU1FJNafqlQiGzcO3widIoXfHgqqgFXmZCieCuKDgodkpLEgHYDgkHOOYxpksAEzdb0ilLt5+EgW4qnPMAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB0U4E+9hluJ5GF8dJq9AYWjT3g6qb3ZsjK8B4JVhDM=;
 b=Hsh6Jv8arRkbO5x7E9spJWK99L8y6lfHLRFhUtr8m1TCxQORBAFpaFR+XomkX6LKEqoC5ouTo2g3KHTyYNNUe9WKpdtGUoBH8ClEcgjvFOkM3jrOFcgWunSWUoUv2Bppp9+BWfw2tucTTRFtWLgimBbNnzu/9irCo6C2vPConeCg2fba8gYi4S2LPpdPIqULGBL7T0C+b5K0d7+Jguk6QtgL1hRVI9lzXQZ2twkMDLN66iaTraNbE+vT142zKOFYpJoahvDIWNrYnf3qHkMywone61z3YWeNmzkh0Vveqj/dxOG01ihs6flnsGSXXat6oXD/i2AQ2go1gbacGryNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB0U4E+9hluJ5GF8dJq9AYWjT3g6qb3ZsjK8B4JVhDM=;
 b=Dk2Gf82eFiY15+JWOi33QOs4ycKvvcQboOgfDo20ccdu1otOOOpscY2v0RmUWWkm+YjcPwjafWf/BzS1/vPG8KufMHTimiwcZBlKCJ1goCkrUkDSMsSOIFAbJWY1vnsnNywRJCVfCF6mvp6phb4TizzZh2uSfaBHBLy38tNBRQ0=
Received: from BN9PR03CA0762.namprd03.prod.outlook.com (2603:10b6:408:13a::17)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Tue, 4 Apr
 2023 09:57:27 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::a0) by BN9PR03CA0762.outlook.office365.com
 (2603:10b6:408:13a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Tue, 4 Apr 2023 09:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Tue, 4 Apr 2023 09:57:27 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 4 Apr
 2023 04:57:25 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <felix.kuehling@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: DROP redundant drm_prime_sg_to_dma_addr_array
Date: Tue, 4 Apr 2023 17:56:40 +0800
Message-ID: <20230404095640.3277840-3-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404095640.3277840-1-shane.xiao@amd.com>
References: <20230404095640.3277840-1-shane.xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 70518a65-c44d-4a13-9467-08db34f2ff45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4yLxTrNXrW5dZRyrdBfJONcwnQDWRspoFXYZ2n6xebp8QlVnlxZrZUeddKESB1TkgyRC1/qcR0zymQ3IBJ1K3a/4+RYSWKFBv7wgq7N1HHIMwnj/stuYbrvn7lS9jpjrIt4PEjOpnGEbg6SoCa1P6ctOtGEVa6JmTQ0BFUCRcuo1jIRPdYFbkw8gyZlJMOzoNIccFOug3RIf8MWRqiuNDXcGrN3a2aRKJ5Q/08wYsQdhzVllJ18RJKXDcYMg5lbSsSvDgXmwMCL0HOFZSpWAqltyzta5uZQXblbaNaCgVzIktvwzyGSM9KWeFwjw8nJVgT+e1JGoFzICKpC63QALYAjqKQ2yA+BjMESPLW9G7Y4xzuz/RiMo15YMIcBiM9lcOHR0WVj+05AEjNsU9WG+Cn85CTO/LJUndkj6T3JGEyRyiL9Q021qWdTE6y7kpk+9XtK/eqynvLJcFz5CbcuA1YXtzeqLQL+h7BtQxnuwbqnacudXYffeCT/n7IEoqgdENWy4jDezjrB2TzZOSGVZELHf4+PJRr0QtI6FtUv83zm7/X2Dqy7A8c5VcuucHSMsrc3d87gJaTeqeQKBXc6NEVZGyfO5AnGzrFv0YmVFS3nGTWHbbejgIDGBS9Q8XM46DzfbaBT2ZcBULixa9BMBUSQoyaZRil7mB6vsOPPz2bazWRptLdTKA9h1qOf/rNwhf5tiGIpwmUBaEQ46SJT7F8NF9cSAeI2vUCRddRS2w4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(16526019)(186003)(1076003)(40460700003)(26005)(44832011)(4744005)(40480700001)(6666004)(336012)(426003)(110136005)(54906003)(478600001)(6636002)(7696005)(36756003)(82310400005)(36860700001)(47076005)(86362001)(70586007)(316002)(70206006)(4326008)(8676002)(82740400003)(83380400001)(2906002)(81166007)(356005)(41300700001)(5660300002)(2616005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 09:57:27.2068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70518a65-c44d-4a13-9467-08db34f2ff45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
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
Cc: Shane Xiao <shane.xiao@amd.com>, aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For DMA-MAP userptr on other GPUs, the dma address array
has been populated in amdgpu_ttm_backend_bind.

Remove the redundant call from the driver.

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index bcb0a7b32703..94ee8f638c12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -488,9 +488,6 @@ kfd_mem_dmamap_userptr(struct kgd_mem *mem,
 	if (unlikely(ret))
 		goto release_sg;
 
-	drm_prime_sg_to_dma_addr_array(ttm->sg, ttm->dma_address,
-				       ttm->num_pages);
-
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
 	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (ret)
-- 
2.25.1

