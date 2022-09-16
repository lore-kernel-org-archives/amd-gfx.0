Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6FCECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 15:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F35910ED71;
	Fri, 16 Sep 2022 15:05:40 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6036610ED71
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 15:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjaos4DC/O3/MtJwPKfW3HZuBgJMWADIEzwFA8fID0srsS3h8/T4H43GkYM1SYx2rAW981n+ertOCm4tHJGeQOW6iPZy2RXptyOqTFBGEpXjNL6HV7RICn5kdacSZiEeaWUdurSrDAPWg1N+hMmPyJlkhCBVxSF3hx6qbUDIva0D2FwiCxLt3Ri+DJ5INsPAC4mgtqqy5X1HMexOu+ZZo42pU76CLMlTGjOIRZI7uLAyHbsla4CyzkEj4WPLoOP3YNBElGzY1MoC53d/aJF/7UTGZFEZYVWtvLZhJLsAesJZalgEdknfgH+WRL5emh8O3dW4WeTHcWy9j5bZwEQMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5ZPFLtvF9as6QIPB/cZkC9ptvzRUqYWTSGhDtvujxI=;
 b=oMU58D+ygjzB/2F4434tcQ98HAiC3T/usdGikPw5783F/gUdKeNdFHys6IMOdqXVZQXKDabNh56rMTOVqHNO6T6Z6RhjohlSOOrTTE+GEFr944hnRgo0+zggI3MNjRTCOG7N6zz1Jj6WVuqzc0D1u5GJZIs1QinqT8y61z3WMb8Uah/4J51ezhFz/f1I53K1kN/k+pGqViWrE3Z5J1B01jMKpgBMy+HlUN8yPaVL5CV1gWUwlteTzBK858r30iSXcl7sYiiFA2jZQIVJV/iuPESvru6hFd0fJMOz6bNLnMGfJjwfyRVmZZjFGkB8sMV6ffoYr4H0vyyBloNtyb33ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5ZPFLtvF9as6QIPB/cZkC9ptvzRUqYWTSGhDtvujxI=;
 b=esMKoO8nT7nbhQcah4J5/ucg9Pocz99QR6dm+oiOoM6pUyvhN6gc5MYdsYcxpzwQh7a1jpHR5KtF3OaOUjukrOtrcxqLhu/NlZJ1l2jEngnxDPMiNCUlffjNyI+lab0UK6drJRCdYhjflewXKAtsgQJuiWXC1tP1I0gOICS8sDw=
Received: from BN9PR03CA0092.namprd03.prod.outlook.com (2603:10b6:408:fd::7)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 15:05:26 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::51) by BN9PR03CA0092.outlook.office365.com
 (2603:10b6:408:fd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 15:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 15:05:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 10:05:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: Use vm status_lock to protect vm evicted list
Date: Fri, 16 Sep 2022 11:05:08 -0400
Message-ID: <20220916150510.31321-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916150510.31321-1-Philip.Yang@amd.com>
References: <20220916150510.31321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 529af404-9ed9-44d3-e161-08da97f4e31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1R3f/+EG+2Mrlw0AZx1mCl27DJ4dvokja7qO9UIPYD3DMy7+gL9c5qPAFNNE6FM6t4BR6dgisv43OUlKjjUmaNO0a3BFprA7bNsHaZc9v0+UCa296Oi5G+Pwrf06qlsg0A0awnNgYtDWr1qKtlzBSuD8O5WbobP/BwjM9H5rIexx2Jp5h7e2jtd734LsQUKoyzZr54pB5TmQEbqe2qnAAXZilst/Ixk/CMNDDDM7fltKfcwfmW67L6i9OjKbArcoMbla0rPNTyLDUtashI35sKwNkgpoDMYUb3267TkKsym0LrXQUb7LYzzLU59+XzeC3x28Zpw+QKiMCIzDr89u7s8AwI6LPARjo0l0//3unGzoHJV8e2Hu5PnTuFe0d4eR/XG+D8xCTQ0N+MXq8NWo08ucmVy8YZW5CJM2o9pnwSH8gGLNc3ZlIhB0/a+uC+z7o5RXXaD6cAwbTr0VTojjysHp7M0JR/h75vh4PagM9YqtE4j1rAabmkqL/2eKT14pCV/NBxqHxabgb5HBog84Af/+5bCNwLG6t2U+cXVAfLpEGla6pGZlkusbl7+VmniUCl65DpWiXXpLy+Vm6i8i/uOHt6VlIcUpDCtAEaT6d9zJlWaKq74eq/UFz9z/0Ii6joUvNhYKYpUHy3/QfbkUZ+A6CL0nYB6yfeTfScDtknkjo0pBUotCNI2ENeBqkWZ3UQwzwUmEbQcEIWCH0nTOfWDUIy1fWLVoosdHUGwWxb7v/cnQMMyZVLhYsQY2rxhRNgJUZCbIVsgVo0uEPVBzF6w5SsTqeAoYaZmn+H1Sq1akEU7DVFGbTcD3+oe/ifNC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(26005)(7696005)(6666004)(41300700001)(36756003)(36860700001)(40460700003)(6916009)(70586007)(8676002)(54906003)(4326008)(70206006)(86362001)(81166007)(82740400003)(316002)(478600001)(356005)(426003)(1076003)(16526019)(336012)(83380400001)(186003)(47076005)(2906002)(82310400005)(2616005)(8936002)(5660300002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:05:26.3725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 529af404-9ed9-44d3-e161-08da97f4e31a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 +++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d5d170de51ce..9d7f9b3670d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -183,10 +183,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 	struct amdgpu_bo *bo = vm_bo->bo;
 
 	vm_bo->moved = true;
+	spin_lock(&vm_bo->vm->status_lock);
 	if (bo->tbo.type == ttm_bo_type_kernel)
 		list_move(&vm_bo->vm_status, &vm->evicted);
 	else
 		list_move_tail(&vm_bo->vm_status, &vm->evicted);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 /**
  * amdgpu_vm_bo_moved - vm_bo is moved
@@ -370,12 +372,20 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			      int (*validate)(void *p, struct amdgpu_bo *bo),
 			      void *param)
 {
-	struct amdgpu_vm_bo_base *bo_base, *tmp;
+	struct amdgpu_vm_bo_base *bo_base;
+	struct amdgpu_bo *shadow;
+	struct amdgpu_bo *bo;
 	int r;
 
-	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
-		struct amdgpu_bo *bo = bo_base->bo;
-		struct amdgpu_bo *shadow = amdgpu_bo_shadowed(bo);
+	spin_lock(&vm->status_lock);
+	while (!list_empty(&vm->evicted)) {
+		bo_base = list_first_entry(&vm->evicted,
+					   struct amdgpu_vm_bo_base,
+					   vm_status);
+		spin_unlock(&vm->status_lock);
+
+		bo = bo_base->bo;
+		shadow = amdgpu_bo_shadowed(bo);
 
 		r = validate(param, bo);
 		if (r)
@@ -392,7 +402,9 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
 			amdgpu_vm_bo_relocated(bo_base);
 		}
+		spin_lock(&vm->status_lock);
 	}
+	spin_unlock(&vm->status_lock);
 
 	amdgpu_vm_eviction_lock(vm);
 	vm->evicting = false;
@@ -413,13 +425,18 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  */
 bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 {
+	bool empty;
 	bool ret;
 
 	amdgpu_vm_eviction_lock(vm);
 	ret = !vm->evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
-	return ret && list_empty(&vm->evicted);
+	spin_lock(&vm->status_lock);
+	empty = list_empty(&vm->evicted);
+	spin_unlock(&vm->status_lock);
+
+	return ret && empty;
 }
 
 /**
-- 
2.35.1

