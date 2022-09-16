Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E05ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 15:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13CEB10ED72;
	Fri, 16 Sep 2022 15:06:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1005710ED73
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 15:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAzkiVy7Jrx9/Xf2jqQt16gWzi+5IEPk885JHP6vmc54ssv1uin9FOzrQ+Twf+zjyxjbMS2R7gGi6lYK0uFZSVXYoj6uAOVrIxAK9LSL7b5gWwegk1slGjmxrbztCKp3+ijq3XBqCuziXyZAY4hiNzhWMJvxFgfVBNnqYIlSxMEYkcYuzIX8ugfHSpOFbiP0Mrdve8X7c+rzBPd6Ba7zp4E//aaNfbOlqeqg3xaDW4MjR8neX7AMguB3wcRPMmYL2o9M0/r9PUuzy/sN93TU3VciUU1w+6KTsVckodmqbJ/I2PzyH5m35h3AhcKYaKe6PTX82Kfuj1+dzaT4hrqHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/0saI1SrOaYKRXeSKet7tnPpWYOBbI9zK1NWG3dUxs=;
 b=Z1HyyDTyHp0roxs0t457Pc6HAbBh28LaKlgVLdaja8s2SquMH83AFIsfA3ISykv97bfmb+aR4HDsP9M/H9DUCwa3EszwppVSLckH/RF0UwQ1uz10O+U9XctlfqWftzQxgjbEky3wUqDcVF4bHEQo1uuaxg4VbaVRp1ihc9d49yYnR607P8bciVzuUtLBx2Z/5OAQwbhXpmpow83yccMGlucO0ulj6kGfjMg+WpiVZUBk1DGo6UsSYdnhG54JeK+KAQj/yiEN1vKDdgZEIibEzrP3kqUtOLViRVTRWdk/kLJxCGU5gA9J9fSdLoYisQr/go9xtiHYT4L5DLQ845r1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/0saI1SrOaYKRXeSKet7tnPpWYOBbI9zK1NWG3dUxs=;
 b=x2PbvHWzms0Sfnaglgo2XpMwyJdC1kd+7B4EN9ijbBvCo+f0yhz7QuG8npBmWwyBq2aUl/PKBzjYgSey+lQiDkpDpgfS1K3pICmHUE4y21MvdnkcCVOkSN8yOjNZDVwPGmPx3Dqg8L1HS2TR8tRw1Z80o5rVGEoePvZMGZ35OQg=
Received: from BN9PR03CA0117.namprd03.prod.outlook.com (2603:10b6:408:fd::32)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 15:05:24 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::f1) by BN9PR03CA0117.outlook.office365.com
 (2603:10b6:408:fd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17 via Frontend
 Transport; Fri, 16 Sep 2022 15:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 15:05:24 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 10:05:23 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: Use vm status_lock to protect relocated list
Date: Fri, 16 Sep 2022 11:05:05 -0400
Message-ID: <20220916150510.31321-3-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ef85e4-f00f-4cb7-bc6d-08da97f4e1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IczzPKZ5EvOSkC2rX9G0N7d0fhQs+84+LXlNMElP/ZBwEMHw8u5ALKDQGgAPZenpFSq6qodYX/sK+kGBGvYSPDJ/kpIGMDkJ6gr3sXHqnP7/wCYnl5ErdDiVm/t2XietZvx+yImxmWD5YmEhVgJEIP9cq5RBafx3EQsm0tSAVua47e41BiwHyiYJibB9FjAwdIIcOiJPJlZuIk5bFUrZBK5Ggh+TJn7pb1FsBZXTYWNbOzAj91IXr+knK7aEmVzyoS6AAnzco20RHACGmwTrNR+ENqxasHYB4vic+dOCMcFvRYzfwWvvgs/+wlN/W1feFZ9C33/WeS2v5x6zpR+qMoJBQ2Q94GhIFhUgysbuwoPcLIYa44b215VPOvpWUCin8CJ2uwystcs1PUlR69I88bSL1ZoA3xsILkoUslescfEwwE3EpbLPzzpdH0NJtNbbQWxUbBeHzNPfaj1mf1yFgYJXZ7hZSACS44pK1uj5bouxGHixUm8KeVoxhLMa5ub8srWgfMnhH1Vk+TMM8xO2HNkDlfAfbFhpwmxyLBemNzv7kq/JeCVjPwmnQ0DWJqitYRzRQPj0oZd76eLYfUNDApdfGZIHdqYJNifpQC5h+EQVa5kEcwO6Wddd/lsKUn1+KCgPSY1Z7i8VJoByJdhvANO2NzHvFIebczU7dtO+FgvcS0qs9WNMCdnAOP48kiyyFyoJUIPhl+UYbQ03kr8xfTwK1NrRHFYb60/CpeJq25aF7CAyPZDmGjtynq8/eo7Yggd1fwe8Pp02Jj9wNX3Jd3rXPe89Cv4/QoKDPh3+cE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(6666004)(40480700001)(426003)(1076003)(54906003)(2616005)(41300700001)(82310400005)(26005)(336012)(83380400001)(70586007)(81166007)(86362001)(8676002)(82740400003)(47076005)(478600001)(70206006)(2906002)(5660300002)(16526019)(356005)(40460700003)(4326008)(6916009)(186003)(36860700001)(316002)(8936002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:05:24.1071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ef85e4-f00f-4cb7-bc6d-08da97f4e1ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 596f1ea8babc..4a1cb20deb2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -240,10 +240,13 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 {
-	if (vm_bo->bo->parent)
+	if (vm_bo->bo->parent) {
+		spin_lock(&vm_bo->vm->status_lock);
 		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-	else
+		spin_unlock(&vm_bo->vm->status_lock);
+	} else {
 		amdgpu_vm_bo_idle(vm_bo);
+	}
 }
 
 /**
@@ -680,9 +683,14 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_bo_base *entry;
 	bool flush_tlb_needed = false;
+	LIST_HEAD(relocated);
 	int r, idx;
 
-	if (list_empty(&vm->relocated))
+	spin_lock(&vm->status_lock);
+	list_splice_init(&vm->relocated, &relocated);
+	spin_unlock(&vm->status_lock);
+
+	if (list_empty(&relocated))
 		return 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -697,7 +705,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &vm->relocated, vm_status) {
+	list_for_each_entry(entry, &relocated, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry->moved;
 
@@ -713,9 +721,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
 
-	while (!list_empty(&vm->relocated)) {
-		entry = list_first_entry(&vm->relocated,
-					 struct amdgpu_vm_bo_base,
+	while (!list_empty(&relocated)) {
+		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
 					 vm_status);
 		amdgpu_vm_bo_idle(entry);
 	}
@@ -912,6 +919,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
 {
 	struct amdgpu_bo_va *bo_va, *tmp;
 
+	spin_lock(&vm->status_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
@@ -936,7 +944,6 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
 		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
 				gtt_mem, cpu_mem);
 	}
-	spin_lock(&vm->status_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-- 
2.35.1

