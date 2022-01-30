Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37605C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jan 2022 07:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7215810F5C7;
	Sun, 30 Jan 2022 07:12:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA31210F5BF
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jan 2022 07:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2dvdTA5tXgYnXTwhBEsjKHGYibm/gQo1yyOUXbEBqO5d5PjUhSH2mPQZKRWcHFS+yoJjQmqUB+Vx39l+SNc/D4dicvy912dJrKm/2zCGHnOT5ZhO9HYctvrkju5xooEqVMdsEKzwxRSUlXN14QKnuVissh7S/27dyGmFoDoVoPgC00nw3a6sk4p/2ixAZygdrY1UebnO6ogyWU0Uu6dMBvXs+RYh6j6FA9YTwYjcoh040bRAjMTjlrsk/D6g6b3dkPeVvz9hTXgcDR3AhHscsF3kFYEhFD2zbqNeC6YnA1K4Db0BtEyTlsch+V9btQLqPJ2TVfiX9JAQT42iypM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuuDSjTVcG/gAWHPkxUBX4JrFakw4rA8VKiIznecBsE=;
 b=NiXag8WjrLJwXxMx7DRxk3JJbCpe/Mz+xtvltjHoBSIkgP/osyHq9v1eGU9yhnA6kqRkRtswBFFwBrkXn0ySCR7i1GuWMaAeHa5q5u+B7Pl4jdWvPXn0eN/eSM4M19sTSYdCcTYzMDbY87MkkozVwMr+dFcKV9//SHd/k1LmjoXLISpvJpIOz1GDeOffeo/bsOxra0dIJMaRr52ZSRH0jzeQZ+kcdX3RcV38wjIw9X/pB/LzQUrXk6NFccM4WJFnGU4uCq4aYdAP1yLCLh2V4//OolyFFRoTxN/Sk6prSDsW8sq41FxX3C9RLw/SQE4g1qovcnIsy3H9JoNQLZLpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuuDSjTVcG/gAWHPkxUBX4JrFakw4rA8VKiIznecBsE=;
 b=2HWgaXsiXp7zqdcvRqvaUER2tOQ4bT11A95P+RQKPff1zkRSDbew8XktqzpDNagvZyLXnlVULSzEMTS+6qIqjvygAIf3f95utG3A6R2FckTSBIjIbERaVF5i9SP/b59f9btPpTZXAv9Xj943VSqu25KGlFhoZ/+HKgWcnAj9cS8=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by BN8PR12MB3297.namprd12.prod.outlook.com (2603:10b6:408:9f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sun, 30 Jan
 2022 07:12:12 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::24) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Sun, 30 Jan 2022 07:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Sun, 30 Jan 2022 07:12:11 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 30 Jan
 2022 01:12:09 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/2] drm/amdgpu: Fixed the defect of soft lock caused by
 infinite loop
Date: Sun, 30 Jan 2022 15:11:39 +0800
Message-ID: <20220130071140.3846493-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7daeaed-2e3b-435c-4d72-08d9e3bfd5ff
X-MS-TrafficTypeDiagnostic: BN8PR12MB3297:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3297F69E77716DD2CE11E1FBFC249@BN8PR12MB3297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AM0It97U7ZEIIlxhAQU81FILkpksStqnLzUyBA/nvdv50Be+FQYKCu1PduzoRsbGbhTc8SgHYzBC823WANRDsiAaVkXf49uPQNbZLTK2QcNQOu8YYxiKxYfyYteK18aa+WWYbxt/iyvFsItf4pf4ROe2lRb3FN8BqLV9qsvGFBCtPTk6Ny563On7s0XMM2OgEUHeI0oqIO1j+uyCctoCEKNXes/2MSJiUJVOsOogB4Om/edN3kj8NhVguLn5ODxSYq1sOc9gc0bDaAdL38jZfSfIKLhb3+lYTtXTF0HBmcJvAvedDd26vqwgn2NXTZGNBtgW8rvw+0GFEtnd3bAD63gqKaeTCVjEwhUS9CzrBMzIeyhnSww6BzffSyNsW68mi41KcSF+RpCJuhvhA58gMIt/8WI9eKoeDbf3m1PtEebUZA73Woa5at/xFmlr+jqlJTIkEW8Qjtd4GbJCaOM3n/q+rhhTI8feVO+P7mH+fKspDe20AD3+eo7lDSTOaEsl+f5HxVFX6ChX/Htf7TvwV5xos2zs7FyrBWkd705pFhcdPtpykLE36xa1mudPkaf/Oz2mAgoyvZW7PRy9TXhFn9yrwZ9De32bdzLBsTiUl+2knbWtkCmKvD9DOiaOwGyY+quea600q9YPp0b7tP7whpIdNniNfIE2TZtW/C+gTBDs+/fQcHl9Y5ObyHlZSY9RcsuPrL17Pzt0bDPOpo5NN1kMu5taSi7LMCrwR6HGq34=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(82310400004)(8676002)(4326008)(336012)(186003)(2616005)(86362001)(426003)(1076003)(83380400001)(26005)(70206006)(70586007)(8936002)(2906002)(356005)(6666004)(7696005)(81166007)(40460700003)(316002)(508600001)(6916009)(54906003)(47076005)(36756003)(5660300002)(36860700001)(43062005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2022 07:12:11.7548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7daeaed-2e3b-435c-4d72-08d9e3bfd5ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3297
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. The infinite loop case only occurs on multiple cards support
   ras functions.
2. The explanation of root cause refer to commit 76641cbbf196
   ("drm/amdgpu: Add judgement to avoid infinite loop").
3. Create new node to manage each unique ras instance to guarantee
   each device .ras_list is completely independent.
4. Fixes: commit 7a6b8ab3231b51 ("drm/amdgpu: Unify ras block
   interface for each ras block").
5. The soft locked logs are as follows:
[  262.165690] CPU: 93 PID: 758 Comm: kworker/93:1 Tainted: G           OE     5.13.0-27-generic #29~20.04.1-Ubuntu
[  262.165695] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU, BIOS T20200717143848 07/17/2020
[  262.165698] Workqueue: events amdgpu_ras_do_recovery [amdgpu]
[  262.165980] RIP: 0010:amdgpu_ras_get_ras_block+0x86/0xd0 [amdgpu]
[  262.166239] Code: 68 d8 4c 8d 71 d8 48 39 c3 74 54 49 8b 45 38 48 85 c0 74 32 44 89 fa 44 89 e6 4c 89 ef e8 82 e4 9b dc 85 c0 74 3c 49 8b 46 28 <49> 8d 56 28 4d 89 f5 48 83 e8 28 48 39 d3 74 25 49 89 c6 49 8b 45
[  262.166243] RSP: 0018:ffffac908fa87d80 EFLAGS: 00000202
[  262.166247] RAX: ffffffffc1394248 RBX: ffff91e4ab8d6e20 RCX: ffffffffc1394248
[  262.166249] RDX: ffff91e4aa356e20 RSI: 000000000000000e RDI: ffff91e4ab8c0000
[  262.166252] RBP: ffffac908fa87da8 R08: 0000000000000007 R09: 0000000000000001
[  262.166254] R10: ffff91e4930b64ec R11: 0000000000000000 R12: 000000000000000e
[  262.166256] R13: ffff91e4aa356df8 R14: ffffffffc1394320 R15: 0000000000000003
[  262.166258] FS:  0000000000000000(0000) GS:ffff92238fb40000(0000) knlGS:0000000000000000
[  262.166261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  262.166264] CR2: 00000001004865d0 CR3: 000000406d796000 CR4: 0000000000350ee0
[  262.166267] Call Trace:
[  262.166272]  amdgpu_ras_do_recovery+0x130/0x290 [amdgpu]
[  262.166529]  ? psi_task_switch+0xd2/0x250
[  262.166537]  ? __switch_to+0x11d/0x460
[  262.166542]  ? __switch_to_asm+0x36/0x70
[  262.166549]  process_one_work+0x220/0x3c0
[  262.166556]  worker_thread+0x4d/0x3f0
[  262.166560]  ? process_one_work+0x3c0/0x3c0
[  262.166563]  kthread+0x12b/0x150
[  262.166568]  ? set_kthread_struct+0x40/0x40
[  262.166571]  ret_from_fork+0x22/0x30

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 --
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9d7c778c1a2d..9b94c9c4960c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -75,6 +75,13 @@ const char *ras_mca_block_string[] = {
 	"mca_iohc",
 };
 
+struct amdgpu_ras_block_list {
+	/* ras block link */
+	struct list_head node;
+
+	struct amdgpu_ras_block_object *ras_obj;
+};
+
 const char *get_ras_block_str(struct ras_common_if *ras_block)
 {
 	if (!ras_block)
@@ -880,7 +887,8 @@ static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_de
 					enum amdgpu_ras_block block, uint32_t sub_block_index)
 {
 	int loop_cnt = 0;
-	struct amdgpu_ras_block_object *obj, *tmp;
+	struct amdgpu_ras_block_list *node, *tmp;
+	struct amdgpu_ras_block_object *obj;
 
 	if (block >= AMDGPU_RAS_BLOCK__LAST)
 		return NULL;
@@ -888,7 +896,13 @@ static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_de
 	if (!amdgpu_ras_is_supported(adev, block))
 		return NULL;
 
-	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
+	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
+		if (!node->ras_obj) {
+			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
+			continue;
+		}
+
+		obj = node->ras_obj;
 		if (obj->ras_block_match) {
 			if (obj->ras_block_match(obj, block, sub_block_index) == 0)
 				return obj;
@@ -2527,6 +2541,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 
 int amdgpu_ras_fini(struct amdgpu_device *adev)
 {
+	struct amdgpu_ras_block_list *ras_node, *tmp;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	if (!adev->ras_enabled || !con)
@@ -2545,6 +2560,12 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	amdgpu_ras_set_context(adev, NULL);
 	kfree(con);
 
+	/* Clear ras blocks from ras_list and free ras block list node */
+	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
+		list_del(&ras_node->node);
+		kfree(ras_node);
+	}
+
 	return 0;
 }
 
@@ -2754,14 +2775,22 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 		struct amdgpu_ras_block_object *ras_block_obj)
 {
+	struct amdgpu_ras_block_list *ras_node;
 	if (!adev || !ras_block_obj)
 		return -EINVAL;
 
 	if (!amdgpu_ras_asic_supported(adev))
 		return 0;
 
-	INIT_LIST_HEAD(&ras_block_obj->node);
-	list_add_tail(&ras_block_obj->node, &adev->ras_list);
+	ras_node = kzalloc(sizeof(*ras_node), GFP_KERNEL);
+	if (!ras_node) {
+		dev_err(adev->dev, "Failed to allocate ras_node!\n");
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&ras_node->node);
+	ras_node->ras_obj = ras_block_obj;
+	list_add_tail(&ras_node->node, &adev->ras_list);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index a51a281bd91a..a55743b12d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -493,9 +493,6 @@ struct amdgpu_ras_block_object {
 
 	uint32_t sub_block_index;
 
-	/* ras block link */
-	struct list_head node;
-
 	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
 				enum amdgpu_ras_block block, uint32_t sub_block_index);
 	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
-- 
2.25.1

