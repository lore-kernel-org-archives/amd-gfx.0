Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0DDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 09:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FC510F26E;
	Wed, 11 May 2022 09:44:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9945B10F26E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 09:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIvXUJTHcS1Ej57dgFsTXLfWr0+iqizF+uyrHl3cO0WwxwFDagXVWht+DKdC3pz0bgo6LJP/zjMfxZAxv+dOonCgIyNGat57as8FP3cQBqOwnSsWLD4Wu0V8T0dOKzZPASoS5IwiWRiziOQojtFip+kfzh7r1byc6eDcdcLyglKibMIQDjhEbm60DuhfPPhcq7dNJqqz2SM8TWhjnv/P1pCtIKwJpEGNlKOiFctZBjy+hwcGcu/Tr9Cvh02vSLolen4xEmG8gmPYbjanWXizpQuoEBX3XSi70uM6/sToQZiaR8vFECmVMWrEePZaBhMmIfFHl/p3j1a8mqZtZRwrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8tmHo0kDm+6/djonQhvySElASLDQOQ88J1OPy/uedw=;
 b=UH902XMYQe5LLTlM06sZVbMhzHB5MsiiG6wJQngLE4bOMzA+WHC1nmucF9tLfi5+DXvd4ukxTRpfWD64zN1edMJsJz/Uq3fstC6HDwd24yolf5Lle86NuYC2UaDVAh+ROqQlmBw3hz8SKt2ZZzqwnqdpjuu3xoeHJEmgs2pcPhPssgGaRJqRWbu9gLMvYe8liFAkc4fGeGVIshU3aZQ/rGJQF5yCxu0o8ifOkAd1RTyTvsqn/iS5ZG5+XWPHzxcRXa+3BfwMcMcLFHwlzaDhuQLs0xSiI9dLNvCQo4rKEtzRRtVHQ/aEVNPB3MbbtxB8/8bvXlycDDI2PKN6D/8lfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8tmHo0kDm+6/djonQhvySElASLDQOQ88J1OPy/uedw=;
 b=wl9SAVF0I+EAoagnMSyJRHmFPvkfFw+3Ej2lpmOgg6c73OOJwRYSwIfMvE604Ltp62gJnANN11JF454BLxERjzEUe/wuixMoET3eKW76CLHayTuEvxjtoRhOB2wq/EVpYjFJLQBGs2jRGaRYXJr/1ySmfx7rJdhIj238+RWEUGI=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 09:44:23 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::bb) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Wed, 11 May 2022 09:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 09:44:23 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 04:44:21 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: allocate MMIO/DOORBELL BOs with
 AMDGPU_GEM_CREATE_PREEMPTIBLE
Date: Wed, 11 May 2022 17:44:07 +0800
Message-ID: <20220511094407.266336-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bc0a294-cdef-4a7a-8961-08da3332d496
X-MS-TrafficTypeDiagnostic: DS7PR12MB6189:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB61890AA204F47712346A8BBBFBC89@DS7PR12MB6189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwmcMTow7OTNcm+4x3dbDVH7LL22/1xDHklJvDn3U+4Ic+Zi3XXQFOw2xo6OhrzmjyLVpi06maoVMIBg0q/VvzBNdjueCjm+uKwE0+QMyPe83vZYTS97Zyx8cU5U0PCPoRAYeearXSe6Q5kCxrsLnOzhPfslFlrL2XyNkYix7veuVCniulLt24mhAuXbMOTL5RxZ3E8OxAuYD1hKVaGl7s2Vf5mgev+V71zoyIbS3PjsHXg+qEITfWT2j9bF1NywfNjxNzE1/DOc0macWjXSqlZM7bg5IHFWAdSovGxpVMRd5f958q1vouL/BzRMN2FK8wBiJwmXoiXzaN6Jw8jZA1YviEKekkAT/f7B62IgWe2bijbYmzYE/Ul0cknFH0SpCzPbbbC24+3WFJTsN0Re51cSExwbh0hoZp3xp3a2W7BLYWeQwdQdcFdrZVNj2osMKh28scvWd+AwRzx8iT/OPHSkklf+b0DoOBKUhQ9PGR8we0NvO5s9YRk9bMzku+b1hPJZAwFcF8Ls1wQ+sbIm1BoauIIArFX9TjdZ5eNFVsBmkudTXmIA3exlW8kv79D3m+CxXBraasalwAEtpX58cjAEMu/MQkiqpVCzcRWR2ptqw6zvvAkmPWranpJXARg7hFx8Op0Qqxl3QbqCmH/wnqLFMhA/GIr6i/9d0k25BeYbSHUTbj3KlQj5irG96Mtmdhe1TXqv0IrEEboD7zI2tQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(1076003)(86362001)(316002)(426003)(2616005)(336012)(82310400005)(16526019)(47076005)(26005)(5660300002)(40460700003)(186003)(36756003)(36860700001)(8936002)(508600001)(81166007)(2906002)(70586007)(70206006)(6916009)(6666004)(83380400001)(7696005)(54906003)(356005)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:44:23.3425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc0a294-cdef-4a7a-8961-08da3332d496
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MMIO/DOORBELL BOs' backing resources(bus address resources that are
used to talk to the GPU) are not managed by GTT manager, but they
are counted by GTT manager. That makes no sense.

With AMDGPU_GEM_CREATE_PREEMPTIBLE flag, such BOs will be managed by
PREEMPT manager(for preemptible contexts, e.g., KFD). Then they won't
be evicted and don't need to be pinned as well.

But we still leave these BOs pinned to indicate that the underlying
resource never moves.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8b14c55a0793..fada3b149361 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1518,26 +1518,26 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_flags = 0;
-	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
+	} else {
 		domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
 		alloc_flags = AMDGPU_GEM_CREATE_PREEMPTIBLE;
-		if (!offset || !*offset)
-			return -EINVAL;
-		user_addr = untagged_addr(*offset);
-	} else if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		domain = AMDGPU_GEM_DOMAIN_GTT;
-		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
-		bo_type = ttm_bo_type_sg;
-		alloc_flags = 0;
-		if (size > UINT_MAX)
+
+		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
+			if (!offset || !*offset)
+				return -EINVAL;
+			user_addr = untagged_addr(*offset);
+		} else if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
+			bo_type = ttm_bo_type_sg;
+			if (size > UINT_MAX)
+				return -EINVAL;
+			sg = create_doorbell_sg(*offset, size);
+			if (!sg)
+				return -ENOMEM;
+		} else {
 			return -EINVAL;
-		sg = create_doorbell_sg(*offset, size);
-		if (!sg)
-			return -ENOMEM;
-	} else {
-		return -EINVAL;
+		}
 	}
 
 	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
-- 
2.25.1

