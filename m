Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC80C4167D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 16:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83CC610E626;
	Tue,  7 Nov 2023 16:58:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C08210E14F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 16:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlL5j40RrBLd6F6016CPdk5CIEdF6lUewxQVrTWhYkSg5VRQ8CAFVrtVw+NSmUiRmyDzan73RV/Api0vRGbLJ74P7WhX+FpC9ro+r0bA3q7RdHvxvx8lYy5uumByHCygvYpNXCMG2eQKuezMFN49IMhI8eQyVfCQbHS8PAG23GgvP2X6X+6m32jkkF5RmePokquT2snBfUlb87VFWmIVy+AKkkGu6sLzbk0lWa4nOPXkNKS2QjAVYq4vn0aez3nMAQ7eji7aTFD7lMWPkDeTKccNaxrTPMbafHJP5/RiumkvDX0t75WyfoFEJPz525muX9472nwKHkooWan/0bip+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3rZO/AcziclJDwIrRzq3kWg45yuBa9Hn1XMMobmOx8=;
 b=fw0U5nbEdxOMa2+ceTHt51Ql1SW0WKfBK90dzwxvhfqEU1UxoKKjoRYLgz2oHAPkrTWxzmZDLuiDX87SU8B2v3JhSPD3P2veib08si3sRjTZZp+YUFdJPL7te/OEVcF5+x9CiLWsw1LPDaNWOY2kwCGdYRKAuHa4C/S4Baesg2gakItasGjaby6xdK0QdQ7wZGuhSi7daB29vP9Tw+KbnLwbZKxclMWA0JAzEK7xLr+da4nKcShI3eG8JCLBBCXUc06WM+xvIs9Pj0H1bXp6FIxEPlVkvHFPr2wj+XiwREB3LLvS2F6QG1psn6h/1q//g6UpySEcAjUYLe9hmCOqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3rZO/AcziclJDwIrRzq3kWg45yuBa9Hn1XMMobmOx8=;
 b=pt+9aXWmYRrMb91WoDZnOoFvjhhFRZLsWZi+rqTbZgpEPYoLaW7HqkGMEkA0laNWj4ClvDJSflpTlvdu4pq334UPIlCVXxbjkU1sBrAcrlxE15QnIS9hjSCnpG+Lc2whsTsqZbEHheNrZQPG6NZt91x6hKu88/tduWzh82ex7Kw=
Received: from CH2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:610:4f::24)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 16:58:32 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::94) by CH2PR18CA0014.outlook.office365.com
 (2603:10b6:610:4f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 16:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 16:58:32 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 10:58:30 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: New VM state for evicted user BOs
Date: Tue, 7 Nov 2023 11:58:10 -0500
Message-ID: <20231107165814.3628510-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 731b8855-400d-4e0e-df96-08dbdfb2c5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPDjYKMOVqhjyFHEWfooR6Pv+na5Yxf7ZEcl4gSDqNmzZc43qIZW8NHuFKWXs2OnmHc66jBpQSsShhal4AVP56t8Tb+RvhzlfsaRz1ZbXj8nHkiie6pYimvPRf8qnqO5fUSm20cPt1ft1U2ZR6xgtuPxzmuwIKOXGOXS/P8ayX60CliTj9DVyjnJMbbQ6laNbUmALIyqWi31SOvVeP/6lubKkskLvV4xGTQ1Dk59nP1hRZ2+i+Ju6tMz9XHgvNUmppu6UZTT/bZOSC+KU577guSKgK+WDj57XRDXfYpkvQY0OkInlxgf1WSrSea3BZ+qfupjfg+R3kKabvwLd5yCUxv3qBdFL+eA2HIS6xWx/hmb9SYGEwLjeQdU6x+CDTb8apnrCkYYnQfrfOK8DT1/1lsjiE0DF8B3F72SHAoFm9hK2xk0BSfVXtMD2Z/IOUgIXghSi3YZJw7uYI0F556ffPy183JhFWPbBEZmvWEgeNEGOFVst2b0B2zu4gKeGxkVPjlsE3IuogPT9bDQCM4VBUGgt+dcCXaHGBvxrGhFscxAyhn6hMStOdaYPOyqf+plX2pX0aSlTpXnIiPXKSGt/NlDy+N5gStPCu8w1wQfCj0rQU30YbOIMo8JFuiZFkBe80MfBvKl2vRyLe9mzKf1yH58BWrANY29NCaRuI3fQHB98ad82GK7QPioKA4UbJeGi83vdOvHtYSXpxkBATY8s2x48bG05+iEktK+mM4m0WwvAPikdI6Lb2CnD1Uba42zpgVD4r8K4rtwiyQSNpgKsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(16526019)(2616005)(83380400001)(26005)(1076003)(426003)(8676002)(8936002)(36860700001)(2906002)(4326008)(316002)(6916009)(5660300002)(54906003)(47076005)(41300700001)(6666004)(70206006)(7696005)(70586007)(478600001)(86362001)(36756003)(356005)(336012)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 16:58:32.0164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 731b8855-400d-4e0e-df96-08dbdfb2c5f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Create a new VM state to track user BOs that are in the system domain.
In the next patch this will be used do conditionally re-validate them in
amdgpu_vm_handle_moved.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 ++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1442d97ddd0f..0d685577243c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -232,6 +232,22 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
 	spin_unlock(&vm_bo->vm->status_lock);
 }
 
+/**
+ * amdgpu_vm_bo_evicted_user - vm_bo is evicted
+ *
+ * @vm_bo: vm_bo which is evicted
+ *
+ * State for BOs used by user mode queues which are not at the location they
+ * should be.
+ */
+static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
+{
+	vm_bo->moved = true;
+	spin_lock(&vm_bo->vm->status_lock);
+	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
+	spin_unlock(&vm_bo->vm->status_lock);
+}
+
 /**
  * amdgpu_vm_bo_relocated - vm_bo is reloacted
  *
@@ -2110,6 +2126,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 	INIT_LIST_HEAD(&vm->evicted);
+	INIT_LIST_HEAD(&vm->evicted_user);
 	INIT_LIST_HEAD(&vm->relocated);
 	INIT_LIST_HEAD(&vm->moved);
 	INIT_LIST_HEAD(&vm->idle);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 12cac06fa289..939d0c2219c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -286,9 +286,12 @@ struct amdgpu_vm {
 	/* Lock to protect vm_bo add/del/move on all lists of vm */
 	spinlock_t		status_lock;
 
-	/* BOs who needs a validation */
+	/* Per VM and PT BOs who needs a validation */
 	struct list_head	evicted;
 
+	/* BOs for user mode queues that need a validation */
+	struct list_head	evicted_user;
+
 	/* PT BOs which relocated and their parent need an update */
 	struct list_head	relocated;
 
-- 
2.34.1

