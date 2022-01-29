Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE41C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jan 2022 12:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251B51122C9;
	Sat, 29 Jan 2022 12:34:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00DFB1122C6
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jan 2022 12:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8ZLnayL6E8yaVm0TXAXATBsqffUV6VGm6wD+p8Ne7f9EN/nL08kFjR5Hts1L4WvPftEKqfopoQDF+shf3grgfnV/aeK6cKY9L/UD5mZ2MHXarsy6RV/Yb93dTzfe3o3t2BdC/PDS9s0dxSCIhLmLWXt1Q3Wo33SqIn4dHJtifZnGO0AFiaNzU4Zjjjn+bF63LLAkJaazXGMNkpXVB+JdJPxrSjf0BGUWK5prsQrbO0gj45qCF5YM/XhtndeXyMqJiGenBJ3zOSb0N9paEZ6qlR0NjhFo/CpC6miECH/shUI/+oxEyGmIFved5N/Ds8MjBcBNCJ8vrkkof7KJ4/fFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWbojsgY3oPSIPVX07tQoTrS2pF7fwlfKjP0ZchsfIM=;
 b=dL9ni1Ha3b1mH84Xe8ZOg+8eG/T82gPHftRvlBGzzsaaaW0im95qY+SCVd81NkM574qBo1Z/TXFQHeErHuUvZRW/s5uWWd+qjNoSW2JORRon5eGrX7Q2gzKdWtFB/ep/kJMOHDgkQRSeQs88li+ZBPNQjqH97sDquEiV8q8j5uVk3UnO3GEvKmpeL0MfR4UnywVsvKrEdWtLXXqAIQBEg4whjACTmOOnNaelixpRrCihidKe8Kq0Oeba/xPoTIj050CxErfw+CIQlAncansOE4BcjiyUaSkrBQpWwTT+GgEol5fiuT22iISYFoYQSE4CsvzUC8vFfVDw8sKLf1Hodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWbojsgY3oPSIPVX07tQoTrS2pF7fwlfKjP0ZchsfIM=;
 b=LhY3ZOLrD4jSxfPZ6aEnr3x0syY7zOblsKe3sQ296RQ8vG7An2h7VmOWjVyypXuWd+VCmFtf1tB+6PYfu5g0WSQLxk5RdolOv1kE/jiP+uO29ckPovJBKY/2kefFAhD/pWQfT3iNvz8WCPQR4kDSAshgNG67keJdNeeOpIkhlN8=
Received: from DM5PR18CA0090.namprd18.prod.outlook.com (2603:10b6:3:3::28) by
 MN2PR12MB2991.namprd12.prod.outlook.com (2603:10b6:208:c6::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.17; Sat, 29 Jan 2022 12:34:35 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::e7) by DM5PR18CA0090.outlook.office365.com
 (2603:10b6:3:3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20 via Frontend
 Transport; Sat, 29 Jan 2022 12:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Sat, 29 Jan 2022 12:34:34 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 29 Jan
 2022 06:34:32 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Fixed the defect of soft lock caused by
 infinite loop
Date: Sat, 29 Jan 2022 20:33:51 +0800
Message-ID: <20220129123352.3765260-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 676f4180-bb83-432d-0e60-08d9e323b4e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB2991:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2991A765DB0ACA459B7E9060FC239@MN2PR12MB2991.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 401BA60VTJEHa+Z2FCfNIkaeMMkWYieYi0r6db0y8vBvwJrFuIOt7pcurbswJ063Ap1ltFskffpt3wh6RPIjQOE9VxFi9tmysq9xlHfe7WWd4ZsKeRgteU6NcsArA4TEodMmrslHmbAjBlGmx1cr9WY9t6XndQV3jP/y2HUjeL86+ZsgBYnzXkhBLka2C4wGU5pwZw701ZUn3fJ0yvVCWVfndChJqKUCenylcvuYjvkTgb7/upULQ3N6tPuXe6tlAlkKAe6y7wA5K2J5yg+YA6X1d4MusG45YL1TNpouzpDaDuagZb6WwCybWuCf5834WRYhY5I5brwHuE+lcMSvrqdnfRYUXWXlfdUAnrsftBp452LYP0h9FvahTGMy/MOx9dt5P17H++fnJz0p4o+kUzw4HaRqVFcInrHgkanP35yhn2hwpH3e2tNxpByj6xjcCawNQ0Q4hxZYxYLAAWDA21TS3ITP7olx0Uz2fYka7wjkuNv4X2NpslPTqr7k4ugVoWHlBiEVxnkMRJwgEbVWjemA7hEXDn/1PVZ0scSjl5YrB+OutGdc4PDPPN+TSLSBJkP9z6bgX+SGRPiFdbCWUdxhImSp/yI+AXVUIYB7ga6Z5ri+B7j9QZ/5PtD8jfcW+ibzpdpxZXI2CmhtnWnBaKsTWKzXUek2ItpaQsLTmFZfdFb+gbXyabglGlr29gpEzB0pnxdGMvVmOfBPLtXxQxzXLXG1ynA3OqOjs9UOBZ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(336012)(70206006)(82310400004)(426003)(8676002)(86362001)(8936002)(508600001)(4326008)(83380400001)(5660300002)(356005)(81166007)(47076005)(16526019)(7696005)(6666004)(26005)(2906002)(6916009)(2616005)(36860700001)(1076003)(36756003)(316002)(54906003)(40460700003)(186003)(43062005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 12:34:34.7075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 676f4180-bb83-432d-0e60-08d9e323b4e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2991
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
2. The explanation of root cause refer to 76641cbbf196523b5752c6cf68f86.
3. Create new node to manage each unique ras instance to guarantee
   each device .ras_list is completely independent.
4. Fixes:7a6b8ab3231b511915cb94cac1debabf093.
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
index 9d7c778c1a2d..b0aa67308c31 100644
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
+			DRM_ERROR("Warning: abnormal ras list node");
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
+		DRM_ERROR("Failed to allocate ras_node");
+		return -EINVAL;
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

