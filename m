Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45026C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 21:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8EA10E64A;
	Wed,  2 Nov 2022 21:11:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6688710E64A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 21:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwthUXMb08c9gNPGRqyrSN9M2tzg3KPHM3kau87rGINv4CGKLYNmBRCR1Mkz2KPR9N5BqEiJEIju2CP/RoZqwXnR1gDm3mBV1GkWMps9u5xaoFK4PcFcGZf/E+omqjEd2muTAbuKpsDBZTNXHeaWy5Tfy4ncbO4VoVfNXtSWGTJKmEc+ruml/bc4SkY9Src772nbBj6oA+BXMs9T4/gwuqjUl4BCOY+yzWklDiW7z/4IiPvWx6n3Gyssi00H4UEuGmzME77f9qwpuu6Fu9NMN20/CMZbtxH0EozF+DPBp6gL6ewRwIM9EPEr7brT6PPDHg9CFqoO8RiP838jrRm02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4o3s78nFsd568SMIrD1hSezynMYbhMcQT1V2KhG6Cg=;
 b=cuiQdJwj1bdntgDJVjv4083FJv7q91IYoQoE4tcCJS/7tQxL+RfGn94eE/ATtBQ3RHUKl+hnIypJxgXOCL0MsbUbZxouW8RJ0pAjKtEkkZ8nh7xWlHxwQI3Myfz7B7BGjPCRKbtXA2K/jz4hR8zKwSm4xaljMx10msDQdVOpg0s0tIYXW04UpeFhWBh3pFTHnNaO86X0gL376DWlfbogjUBsbufphPkg2JZFkzImw3ErFtTQnwrl5uCLlZOAm2NIKxgIv/VFxfonGm1C37okqTcucAUul5uXlxdUYwS+RSfr7ufUfjBqk5m6FiNuPi6dH6yG00MerSOgy3rTeRAxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4o3s78nFsd568SMIrD1hSezynMYbhMcQT1V2KhG6Cg=;
 b=W0aci+JT8BiLPdaFp1db6NXWcJ/Ci79r+Cs2EqrIeti587mjVKn/BgbbXqx7wwHF0qXeafZFyYm9nm8uspPznEVkc9YowmK3ZRQNuZiYY1rmDulf8Dk+UWlEErtywPe4kvtpgDnq7wDdGHuRJ40EFMtC5iOM21ldjybN8dhEacA=
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Wed, 2 Nov 2022 21:10:59 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::16) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9 via Frontend
 Transport; Wed, 2 Nov 2022 21:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 21:10:58 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 16:10:57 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Drop eviction lock when allocating PT BO
Date: Wed, 2 Nov 2022 17:10:36 -0400
Message-ID: <20221102211036.27784-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: abe078b3-df4d-4474-bfa8-08dabd16bd45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3k/YrIhtJEO9BFmjSQw5kS4pYshBdUOrI2tTCMOHttQd2CbqeCGkW5aXV4PYyJN6KLPBXNElG/wP9EkZkzcNczugko0qDNTSDTldRGzHxuzxbWaCZIKnNNqSyD7aufT+k6dkUN14Lt/bKxMwCLeqQYYM7Wapzo4p5DrnG6OpGYOi/uFtk6YDSUro+fpGnwktSWth/8CkMYgs61A+rcpZqjh20KcX7hrjSMBK2ClupV0pn02DxEJT1Bey4GTiPEUfwYn4TzcprLB4K3se3VSo86B+lUGSqeyYXT44CE+c6Uj+n84ZApQPUoc3ptaTVHcNfomkAhwPdjOEss9se8Bnr3Zng2QBrQpPApfRJ37nh8T1WS/T2a1qgqnINyrnxXiqNimGWX6MYcYETmo0oTF+c/qprgfeaRW3HD+cleJ2sEhRj+/PZ3OrG5IXoGME54HntCQfPfjvT7FmnhAcEcZbQVaH47MaciG8mHJlZ1+W1aWioOrQ92h9GovcbKmIJnOAI/pUlLdH22In0+fQBpVIysAylnmrstZ+HZ0x+Hi+0HvNSpGT7eudi9Eaq/23xZn8dk/WVdmJQtPosv0C2xqVuQva/ix486z56MRkCulyvJve9u7J131WwvU549tywIw0tTIc4DK/qs5jU6YJDjb3Jq0ruDNCbQTPENmgAGMYH1ss3mENcGLpVoy7l9mMeVahHaQbl1z6btu8OcvrGEgHQfMbMlE1eXJv2LHBK803VNb4QT4XH3QxroXZRn/6BCikZIVAgYF7CmLD/kkjG7TFN9Q5ir3kw5X2jo8Ba7ixqYm84dijZ7Wb+VGkjri8CUM5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(316002)(6916009)(40480700001)(54906003)(8676002)(6666004)(4326008)(7696005)(478600001)(70206006)(70586007)(41300700001)(81166007)(26005)(5660300002)(8936002)(2906002)(1076003)(16526019)(186003)(336012)(83380400001)(36756003)(36860700001)(40460700003)(2616005)(47076005)(82740400003)(426003)(82310400005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 21:10:58.7960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe078b3-df4d-4474-bfa8-08dabd16bd45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Re-take the eviction lock immediately again after the allocation is
completed, to fix circular locking warning with drm_buddy allocator.

Move amdgpu_vm_eviction_lock/unlock/trylock to amdgpu_vm.h as they are
called from multiple files.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 26 -----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 26 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 ++
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2291aa14d888..003aa9e47085 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -143,32 +143,6 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return 0;
 }
 
-/*
- * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
- * happens while holding this lock anywhere to prevent deadlocks when
- * an MMU notifier runs in reclaim-FS context.
- */
-static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
-{
-	mutex_lock(&vm->eviction_lock);
-	vm->saved_flags = memalloc_noreclaim_save();
-}
-
-static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
-{
-	if (mutex_trylock(&vm->eviction_lock)) {
-		vm->saved_flags = memalloc_noreclaim_save();
-		return 1;
-	}
-	return 0;
-}
-
-static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
-{
-	memalloc_noreclaim_restore(vm->saved_flags);
-	mutex_unlock(&vm->eviction_lock);
-}
-
 /**
  * amdgpu_vm_bo_evicted - vm_bo is evicted
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 83acb7bd80fe..02240dc2f425 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -495,4 +495,30 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
 	return atomic64_read(&vm->tlb_seq);
 }
 
+/*
+ * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
+ * happens while holding this lock anywhere to prevent deadlocks when
+ * an MMU notifier runs in reclaim-FS context.
+ */
+static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
+{
+	mutex_lock(&vm->eviction_lock);
+	vm->saved_flags = memalloc_noreclaim_save();
+}
+
+static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
+{
+	if (mutex_trylock(&vm->eviction_lock)) {
+		vm->saved_flags = memalloc_noreclaim_save();
+		return 1;
+	}
+	return 0;
+}
+
+static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
+{
+	memalloc_noreclaim_restore(vm->saved_flags);
+	mutex_unlock(&vm->eviction_lock);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 358b91243e37..b5f3bba851db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -597,7 +597,9 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 	if (entry->bo)
 		return 0;
 
+	amdgpu_vm_eviction_unlock(vm);
 	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
+	amdgpu_vm_eviction_lock(vm);
 	if (r)
 		return r;
 
-- 
2.35.1

