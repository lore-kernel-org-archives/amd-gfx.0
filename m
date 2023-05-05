Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D4CC77B7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 12:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63F910E5E0;
	Fri,  5 May 2023 12:44:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C12D10E5E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 12:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azoRRK5NBZBxRME3VR+zfIZ9U6DLJ2fHh+i+DsXTmGHMHbgCeCp3Sn8doJNd6xqmP02Bw0m6eG/1DUh/Uwp50DV0pUSu9poz7XPMa52uYd16rsNPSaoLOlnPcAxufZ0rOHxw0nJXic9nJAa5N6nVvP8UBk/Ac6Wk0hJyIdl7tpvOV4frMpmAcrmsVvtQE48avHvjPNbDdY+WyfKyKWtpIBpNL2tTBiN2VvK/iRT0mM69xJTRXGGlpT/J6PYfdXnM4Enl9A9CjtIQ1LXaB6m2Zu+NaZ+inFPzQaLwx3OHEVFc/OPQBPNRkBupIy0TSFLxnkgknUIz1fQJhOuYXjRNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/zF3Ts/KvB28RhajnDVvP/AN1vHa+WnFgZ68PAZvZI=;
 b=ERJO+JLMTbV3DcMGamIyuR7qyyT6pCfLUcnwv4y3/fzUwQByEq2PRzXm6xNzSFHDXl1DcXEdGu63JrAxRs0zuGavULRhU7G7XiBmKaBXSOjXvVW7tV7DMkY+9U/2UJu+dSd7UuPw5IKPJrhLIO2s76M3kB6NazXHQ14SpLjxKH7TPr4W/igltDuEBifBzc8BwjZS2KqKYP0idJy5qQ3btvIx1zHRJZMcZ8/K3XG9c7FVy8EGX/awzYyWrrgyGk1EE6romQwRW2V66gC/wyBUrApeq/Du1/fXuOCvfgjyyuEDYocevb4Mcz/okiIVwFwIgwCNgtpJavITkzZg5KsWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/zF3Ts/KvB28RhajnDVvP/AN1vHa+WnFgZ68PAZvZI=;
 b=Gn2skChrch7R9Q2any5NfcDx2kftoTdFDJ1TJxe5mTNGvv0ZShYmxKCJF9oV5B/s7zAEI72WUN2F7zEeMQdJBGWi3E0EEGR+nsJaiQPQfDVmt6f0atuHb1Ofs33mnNuAcBEfc5IBwVblAPn99T803R0uPOVduAAdlv5p8/jSbqw=
Received: from DM6PR03CA0005.namprd03.prod.outlook.com (2603:10b6:5:40::18) by
 PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 12:44:23 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::9d) by DM6PR03CA0005.outlook.office365.com
 (2603:10b6:5:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 12:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.29 via Frontend Transport; Fri, 5 May 2023 12:44:22 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 07:44:21 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: install stub fence into potential unused fence
 pointers
Date: Fri, 5 May 2023 20:44:07 +0800
Message-ID: <20230505124407.44496-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e123b4e-656b-408c-50d5-08db4d6673c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Yx4b4W1Ia+v56z0n2rCTR9x3lmgCJqbilTFPGRFurxNwdl5U15jw6I1fi/cM3GMQnBordhfik9Eco1imyFc61zYCA5Cs2twwEzzYRf4WcjGLPeh9d7IJxo8F4pLwCBmotGcJiqhYMTX6aaul/UswXihuwgrKzzXuLMpoeYV8Ht1pGNei62+HJnT+Le0zgyiGzmTvpqbm42JzkwGvL5iML2+vXCxrM3k9wDjy01QCx/Pe/DjAzuh3Jc8iHkgAw+BjXPA7qvROV6WyoJOcWQZ/vdA9kLvkyF4hKiejnJniGosgTZXBi85O7nY1/NitBQi1SblfJ9lj15BiePKztJ4Rvtildp+NtDHOWJKhqBCQoJWjwvKNiQWjuYVbeXqPbBubTa0GsC1KCUiK/3+XzuHbf2vqqEgib+IN+y0vDG544irY/FIKFIyIwpLg7R1/qtattrbHsCT+xVElnORpMsCRnufL2ZZR6Au68D1aT+vZYJQsE/1yCgq8YIR93LTooKRz4CKwKLS+OcYCXlsRJbj0IamuD5/V5yN5WDuezB8iJ+HbHFFXTXE2Kbet49O0znQKBl3WH/86qkfIsEVYUT+T0Ded3lPMPeM3KiGwSubmKSpfp4RptK6ThTr7c9ym/xuU3sFcGNu8N0cc2PaMHiGa8QjKJtzvBbfbl8H3HcZgW3T/CqHOrfvPpH1rQi1r66GQFp81cahGV2IDZfRhcPNF1txJuKJaV7DGY2e+qBJYV8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(86362001)(36756003)(54906003)(316002)(70586007)(70206006)(6916009)(4326008)(7696005)(478600001)(336012)(41300700001)(82310400005)(40480700001)(8676002)(8936002)(5660300002)(2906002)(82740400003)(81166007)(356005)(186003)(16526019)(426003)(2616005)(1076003)(36860700001)(26005)(66574015)(47076005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 12:44:22.6393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e123b4e-656b-408c-50d5-08db4d6673c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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
Cc: Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When using cpu to update page tables, vm update fences are unused.
Install stub fence into these fence pointers instead of NULL
to avoid NULL dereference when calling dma_fence_wait() on them.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 78daf6e2f337..aae70a16fd46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1444,6 +1444,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo);
 
 	bo_va->ref_count = 1;
+	bo_va->last_pt_update = dma_fence_get_stub();
 	INIT_LIST_HEAD(&bo_va->valids);
 	INIT_LIST_HEAD(&bo_va->invalids);
 
@@ -2144,7 +2145,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	else
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
-	vm->last_update = NULL;
+
+	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
 	vm->generation = 0;
@@ -2267,7 +2269,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		goto unreserve_bo;
 
 	dma_fence_put(vm->last_update);
-	vm->last_update = NULL;
+	vm->last_update = dma_fence_get_stub();
 	vm->is_compute_context = true;
 
 	/* Free the shadow bo for compute VM */
-- 
2.25.1

