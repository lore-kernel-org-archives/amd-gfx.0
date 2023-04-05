Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86EEC7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 15:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5EF10E9F0;
	Wed,  5 Apr 2023 15:31:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B684E10E9EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 15:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/m7d2qyRKkRe70XkyIY4NNwKt/Mkb5BNJKVnN8hxV6ed5Bn2h2C/l8ZK+7jdWvyPLiBbf1C1G+JKDJqRjwKL9rSb5CYYmaVt+2QYsDzhJaoNwOcPwqJlthPLkeLyc2dcrYxcmPqcDQ3l6Er5FSA8mVbPBYrRXzQEvyXthvd/tAG9Uo6k4/2hFT9gvaF+sSMuQ0sUyXwp+m6vnaoMjSO3W/NGUah69SXTKm10r2I+BKll0f1ycLqKzl+sdBEfNBfsZZziJ7ApBYjXbGcVOEwnHVnXgodidGk6SqwMTMbuawyt2VPlk8ium7WufdZkOkdsUOkKbpbzn4TMw2QeKxJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEhscBjIjtuZKAMd2KWhdLpFq0ZEs3dk6kTExwQFC0c=;
 b=SkqKW10qc8iqRooFSCQNE0s0ZFEWGAPf+ti+TyokRW4pbWNuEnUWfSyt2EPqcTYTi0DEkgkDAcx2RDS4rJD4dEEoQ0scS8GPIdkggKLYXo/918ltQRbrSX+iprGduH7QqyBpgcZv0ZpQGnC1hjTDmUnS9+Osy15HWGiOIISKvbcOyOO1+iloG/3ykalpHkPejaJbgIB9Jc0EXpnKXy3t7TJKTXj4kbyBaUwmrv/EkOzlOxbwj1BSejrI4fkQ/hvaK8jaZEZh7gI2a1V3UkrFZCIHGX8s97VzWtIa4KFYmGU9l5VMgHSEvO5q0ddNg8QCOmr5eHFAMhnj3ofZytWjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEhscBjIjtuZKAMd2KWhdLpFq0ZEs3dk6kTExwQFC0c=;
 b=VgErwq5o0D7dECWtjsdOojYoVaKILw+R/raLhsRetmEh2rAFDMYXuVhNseHN3IErBaYaS+tQkI+6etPEiwRNLLMY8a6EbTWzWIdl9KmIy2UStWZYZA/94mkrQ47Se6pZ0yrzpy40rnAs1gkXpg9J4xDR2W1/YvwyJft5ivLePfQ=
Received: from BN0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:e8::19)
 by BY5PR12MB4935.namprd12.prod.outlook.com (2603:10b6:a03:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 15:31:39 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::23) by BN0PR04CA0044.outlook.office365.com
 (2603:10b6:408:e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.44 via Frontend
 Transport; Wed, 5 Apr 2023 15:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.30 via Frontend Transport; Wed, 5 Apr 2023 15:31:38 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 10:31:36 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <christian.koenig@amd.com>, <Philip.Yang@amd.com>
Subject: [PATCH 2/3] amd/amdgpu: Inherit coherence flags base on original BO
 flags
Date: Wed, 5 Apr 2023 23:31:20 +0800
Message-ID: <20230405153121.3324620-2-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405153121.3324620-1-shane.xiao@amd.com>
References: <20230405153121.3324620-1-shane.xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|BY5PR12MB4935:EE_
X-MS-Office365-Filtering-Correlation-Id: 4caaeb0c-3bad-46aa-ede9-08db35ead962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omS6TuHCHs9g2t0Rc65O46GLxQgH67vOl4hoRDjdaBIgWYodKSIAHNRs64WB7UsWaqHrEHN9C52DBS0EdVJwrJkiUdzZdtS4S+j1K2iz4zQzaC5LLAbVARrx6rZY9yq0sG1NG73sc8GhzQOkgnOlV/ah1z8TLW8kTyfVKY9vrEgaHqKUjVDYZC89zkitMY6kLswMD3LNJ40gXctAKdip9YG5hvMi82nRsQRhV1JQVeaYBGx92fZEs/jB1+/yqtJdkxs81khGU08Lk9UW9/4ullMwDtef90B7fjx8BtZGnZhqz1EQWH7Mbd+ZghEY8+0RQNSoSj7z979UYDHwN9p40QrLsNq8P8sbxiea1+2FwPQ3itmLiGvDKsFiczGquHb3gmdJJXnEZm5zANbhO8u3rgX1FI8Utnxyr6Mne8aqzvnoubCbgQ1PfLcigK3lY+cR+kVGB1CZkc4jleAUe4Se4OLYkzA4jH03A+RdrgmMUpsIYwVT8GBEQQ7ImyqwEF8o99JsCyVXDMg5i5IqT0AX9OFX69zPvG1QGIf/4bXbOeUT/AA72PxqtbIWRSRRcfa/RC+s0JQFlO7b9qc+lVmVGFCKsWQYrKZgwPrK5k6Uh0ypCV/1ti9rsI7zdkqkniziw92wOAsrGpzyguauoriDvfcUtJNV3aycuBRa50YGiRAxCXC3jce/k+7NhyTeYKqEWRQcf+C/kQCNngbL/3gQt3MFgBJXxLbtk+/+gVkVLRk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39850400004)(451199021)(46966006)(36840700001)(40470700004)(54906003)(478600001)(36860700001)(110136005)(316002)(40460700003)(5660300002)(8676002)(8936002)(36756003)(4326008)(82310400005)(86362001)(44832011)(40480700001)(82740400003)(6636002)(2906002)(70586007)(70206006)(81166007)(356005)(41300700001)(186003)(16526019)(6666004)(47076005)(1076003)(26005)(336012)(426003)(83380400001)(7696005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 15:31:38.8347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caaeb0c-3bad-46aa-ede9-08db35ead962
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
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

For SG BO to DMA-map userptrs on other GPUs, the SG BO need inherit
MTYPEs in PTEs from original BO.

If we set the flags, the device can be coherent with the CPUs and other GPUs.

v2:
  1. Drop unnecessary flags check
  2. Remove local variable align

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2fbb9db64ad5..b181bb373783 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -271,15 +271,19 @@ create_dmamap_sg_bo(struct amdgpu_device *adev,
 		 struct kgd_mem *mem, struct amdgpu_bo **bo_out)
 {
 	struct drm_gem_object *gem_obj;
-	int ret, align;
+	int ret;
+	uint64_t flags = 0;
 
 	ret = amdgpu_bo_reserve(mem->bo, false);
 	if (ret)
 		return ret;
 
-	align = 1;
-	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, align,
-			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE,
+	if(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)
+		flags |= mem->bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+					AMDGPU_GEM_CREATE_UNCACHED);
+
+	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, 1,
+			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE | flags,
 			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj);
 
 	amdgpu_bo_unreserve(mem->bo);
-- 
2.25.1

