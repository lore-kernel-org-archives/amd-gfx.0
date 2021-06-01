Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D7FC47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 22:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E0A613AD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 22:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E0A613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5B16EB2E;
	Tue,  1 Jun 2021 22:59:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54EBB6EB2B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 22:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkYE+/h5CcizA49PdN4r/vopO889KYbu94HTS/SLUerU12xoKLZvSolkxpKP59qj2hQwhUOD0FYjOWk1Hr7zTwd4T3sJ4JVuGEcCQWpTFBS0BzkQMr5UHAOznhrJgZuoEZXI3f08GqAwH6gUUg3UQIeKLsiy46myZrfAAfGoSdh71Fyz6wCwqgxpMZEk/vDbkexvDZUpeaB7J/U82H2WJCTuVLt3kIYEX2guVVPgPujt+SlRMvIEgTDkcSyV/abHm2UWn2btwWy6bvxvgrFvPBVrjpzNr1wGeILs/PsY0eJ+Tdisgf6RM0SJeE6RkP8J7Hj7Ff93FRGPyeBxRiv+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89gk1+CgO/tNNQGOH5FrOjdMuE1JQzATnmLOmbzPFBA=;
 b=g4WIpR8nA5s0CKq1eeSGpyTe4hXWHM+rTBlm28mT4GOU9r77P+Q8tyZwF4KiXqfkU9wWL014EP/XPL5rtSWu69Rh40Uz0Nyvlz884Dwqt3l/dTEhO830LrtqwXtVY/I6bA0BNKDKmbjlDllhexpTiZ8DNQGwApPcIpyZqnVMW1XFpCkPOlYRnOBZsaPdNU6RVohuwJk1ivNlkKF5+AwwrlAhPQBlpsY8FTvr+XGvRTzpWu5HMVqUaVTTvAdajqDuiHcKjLE6HKXnVARrmBUO+Hi3HwhpMJq7PG+w+EDWmv7wXsXvxjFkMnRIN+R0fKfaEth0Ns98Sh+079hShzcXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89gk1+CgO/tNNQGOH5FrOjdMuE1JQzATnmLOmbzPFBA=;
 b=PjiHhgOPLmI2C07iHIKUioAZ//MOwba/vKncTVPcfESYBC7kKyZSzDXTgfdni8M3aR63TVOXU/ebbjCwQ7dS+Lmh9chRwNlLPh8vhO97ASkw6Wf5B7MW212P/Ara0d8ymWCcrXHBFKcC3IDUtaOikeAfUqJKiU6RZo1ox+/8Kz8=
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 22:59:26 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::4f) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 22:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 22:59:26 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 17:59:24 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Add flush_tlb parameter to amdgpu_vm_bo_update
Date: Tue, 1 Jun 2021 18:59:06 -0400
Message-ID: <20210601225907.749049-3-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601225907.749049-1-jinhuieric.huang@amd.com>
References: <20210601225907.749049-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7b3f010-f6a8-43f1-5d4f-08d92550e7c0
X-MS-TrafficTypeDiagnostic: BY5PR12MB4083:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4083BC312402D2E098CB375C823E9@BY5PR12MB4083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWuRVJVJN/EO1foh+xOYeq+xL/5xzKnMszvio80kVoN07WegTQ0YW219L/bB7wNht7MJo9eW09iB6Z2JOxN1mGasJp3FQK5T9IjNNa4Ecz6QL68j3a0QBEhxZ2rO6MN4rT7bL1eto/kCV1LOjgBFXaR6OGL7y0lhvXVv/WtFiKVw4oJG8Q95TgJE1ozwqxRmTPH4YZouVKZsGRKv+2WBu7IXaG5ev67io5Boi9puy6501sovaOGvyDTg80TkojVuiTo8eHYqiDg1Qfuf11VliIUDxdESTJN2sRO6seI0eH1u3a3qfLuIBZOTGrGLGBoKPtn6y5WCptvZ+wIa8foL4cl1nQBje9Dbfp81xWm3nGRzrhzb5qg3W8T0c27X+EfWbvvIRTuhjCK2cdlurBxIxLAHfW8nP9ND0+jUwNttufpy4VaynxfqDb+n2gH7QZdCxrq/L7/pJFsUYjgo60TcrtB5j0Qc+qnMaP6AcgK6Gy2VW/YEb3ksHIiskWS2RbxzfuEMy5CUAq1o+vKWmPJD3JY0MwyRnh/KU21SayQuXh2uKWkyflDqLlFahiy1b5/dFpbbfwiO0DnAstotveMp7f1fiqnGyqALeHhEQQqfA2O+liQmQW/olu5xadP+eLq/8xJ5Mi7wsxKoetjR2xXvvgx+6LlfbZMRcXuU39Mi8c74IEdzyekuK5SjQMzwDrNr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(346002)(396003)(376002)(46966006)(36840700001)(426003)(1076003)(2616005)(83380400001)(82310400003)(8676002)(86362001)(81166007)(478600001)(356005)(70206006)(70586007)(4326008)(47076005)(36756003)(316002)(336012)(6666004)(6916009)(82740400003)(5660300002)(16526019)(186003)(7696005)(36860700001)(8936002)(26005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 22:59:26.4956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b3f010-f6a8-43f1-5d4f-08d92550e7c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to pass the flag to KFD, and optimize table_freed in
amdgpu_vm_bo_update_mapping.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e9f9f462a652..e3df132e53a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -916,7 +916,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false, NULL);
 	if (r)
 		return r;
 
@@ -927,7 +927,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
 		bo_va = fpriv->csa_va;
 		BUG_ON(!bo_va);
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 
@@ -946,7 +946,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (bo_va == NULL)
 			continue;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2120a87a949f..eac2fd0048cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -696,7 +696,7 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			goto error;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2c20bba7dc1a..fed3d44b5ded 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1729,7 +1729,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	r = vm->update_funcs->commit(&params, fence);
 
 	if (table_freed)
-		*table_freed = params.table_freed;
+		*table_freed = *table_freed || params.table_freed;
 
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
@@ -1793,7 +1793,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * 0 for success, -EINVAL for failure.
  */
 int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
-			bool clear)
+			bool clear, bool *flush_tlb)
 {
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
@@ -1887,7 +1887,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 						resv, mapping->start,
 						mapping->last, update_flags,
 						mapping->offset, mem,
-						pages_addr, last_update, NULL,
+						pages_addr, last_update, flush_tlb,
 						vram_base_offset);
 		if (r)
 			return r;
@@ -2141,7 +2141,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
-		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 		if (r)
 			return r;
 	}
@@ -2160,7 +2160,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		else
 			clear = true;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, clear);
+		r = amdgpu_vm_bo_update(adev, bo_va, clear, NULL);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 67bba8462e7d..24a63e284a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -419,7 +419,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
-			bool clear);
+			bool clear, bool *flush_tlb);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
 void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 			     struct amdgpu_bo *bo, bool evicted);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
