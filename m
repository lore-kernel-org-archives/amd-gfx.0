Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A05FC25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 08:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB54110E60B;
	Thu, 26 Oct 2023 08:36:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4293510E60B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 08:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/KBWZt/DO6dpgyG8Cl1VUlnqmIgKw76WqmkWA5uHo8mNoh3FhshGPfOW7inpkqEQXLNtI2s9FNdaAdyF2ErFiSRQrzYpt2aJbB2p/480MUbDvvoYQOjMWXnXHBk74Ex4hCSSfDlffMkvyJQ2ZjfGRH5IPdf4OBqrSpBb5qEBiELYD+y0pJtVtTnHPa6mr6Bdd98D9D7vkmiyWksb4gK/W1BKCPjxvAsoVrlwZ+w5Bx1v9ToJT2lWoMYcTuuYFo4hnl4YEyvFiETyyXyAV9dXNfMtCBVqZ1ic7AGretjbtxIdM+eEpoD1+rp6/O1G8MY5Tr1ThvTGoRk+abwFGzyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZyi1Z9k9860UqV8OS60184OpAJoa1fZMYamV6SgMCI=;
 b=dNXbrs7tFykqadWZ2pbz5KPTmc6S9QBa+zpCBQMyDiwyvp+wd7TbfMbgT4CJHsB86Ih78IFxjH7YyCHOqRAcDV1RxyYmHWKQe0BK68yLGGl/aFzFIyqA0RK4jo6CHI5NHnlBSS5Ae7yYvFHEXoOtbvTL59wE5M99HGb/bDW1vrh70LIiy0lFTEAy/tXay4ezoZQcQSEx6yx0QjR4uvvsHb4zbOPjmXMJhuJ9FQlBZOQyCj1IZeyd55XaFVF1EabZgN86wliHvho/ejIPkGNewxehUaK9huQYCt0r/gUCMPhmdpmaklk2wZ5OfTnaBnDlpqjGh6X7AxGsGgEDrkg91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZyi1Z9k9860UqV8OS60184OpAJoa1fZMYamV6SgMCI=;
 b=1vlnaManQMWtgdyut5Bly+rcQKENpVE5z6wnSaM+aiXjENVIvhqlP/w9g5crG9ZWo1y6F5uJ3TJDNN5q/WD6S35n6K7qoIjbY6W3x11IsnOleNi0SWiJkxy98r+CH1oE12KcpBzrT2zxjsWlBferNpkb4Djb6fYw5Mf/qZzpmBo=
Received: from DM5PR07CA0114.namprd07.prod.outlook.com (2603:10b6:4:ae::43) by
 BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:36:42 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::95) by DM5PR07CA0114.outlook.office365.com
 (2603:10b6:4:ae::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 08:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 08:36:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 03:36:41 -0500
Received: from dev-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 26 Oct 2023 03:36:34 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix NULL pointer issue
Date: Thu, 26 Oct 2023 16:36:33 +0800
Message-ID: <20231026083633.947965-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: a72a7bda-df0a-45ce-8485-08dbd5feadee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMQNeCFEHmnXdZqd6uY2L88DFCpzvN/OcOKZMoO0C750/XODJJlPSAA3reWpBgWjpHN6cRRnrGukOlD2ac+wU7CKs+6EEzhjH+U+QYI2wV+28bzby+RIvQO4V9oAs8mj83Phv53bRVn7s6buWeeNvjP8TurS69BMxrfHYF5eHPD8VQoqdyUuERQ56vzb3O7ZEB8BbuO4DCY4BQzdJsq2NHeVqIRxlXFNPJ3UfQHC6Kux/wh0ordVHxMUtjr8SFAhNKAIcFDj57CYx6TkeatbFL3dp5b1zkZMasGC5ok/IbLhsXo7U0TEdSwqJAUsZAUl4xMnuMUdDILsbKtQ8n3QJCyOytx13CMHeK3+UMkqbbPOtkcxRi6ryrLY8ouVQ5E6/AOdB241ELHe14Lz8o7OS3BalGDhEe224ut0uUZR++X8CS0Y5HWZvAsRuTUkTyDck1Sl0jHLXhCQ1iep8zvu83qLwmtYXyXqqWmEChdKJtyas83sBDsgiFS+dyiJ7LlyZj1lO99DF8rXmVSXsgjMNW89PLFlmfO/rmP2CPp5lsQ0nzbwybtXXn+PYpaTR7u/yxyz8LDxj1NhLBz/46EMnyMpvBXA5Hm/zmvRvpjxfW+134K2LrU7nA6iZwsfPWTjr8p7GLcoGTVZfkc2ouGS+Z3jbKwCf1lj3q5c4JM2fWHrzY9vYMiIuWAOE9V9ZD0YX36BWzD0FJU2O7mWN3KUfAfPeNomt3U903In4p0DoZy2dfyOLGfog4ShEOCS2j9LJgVbSj6Uveko8RwMclvnKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(36756003)(44832011)(2906002)(82740400003)(356005)(81166007)(316002)(6916009)(2616005)(70586007)(478600001)(7696005)(1076003)(54906003)(70206006)(26005)(40480700001)(426003)(47076005)(83380400001)(336012)(41300700001)(86362001)(5660300002)(40460700003)(8676002)(36860700001)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:36:41.8775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72a7bda-df0a-45ce-8485-08dbd5feadee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
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
Cc: Alexander.Deucher@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Jesse Zhang <Jesse.Zhang@amd.com>, Yifan1.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add check for ras pointers.
Issues caused by this commit: be5c7eb104067d61

[ 2312.987618] BUG: kernel NULL pointer dereference, address: 00000000000000e8
[ 2312.987622] #PF: supervisor read access in kernel mode
[ 2312.987624] #PF: error_code(0x0000) - not-present page
[ 2312.987625] PGD 0 P4D 0
[ 2312.987627] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 2312.987630] CPU: 9 PID: 1749 Comm: modprobe Not tainted 6.3.7-38fc8aadcfb2 #1
[ 2312.987632] Hardware name: AMD Celadon-CZN/Celadon-CZN, BIOS TLD1001Bb 12/01/2020
[ 2312.987634] RIP: 0010:amdgpu_ras_reset_error_count+0x126/0x140 [amdgpu]
[ 2312.987852] Code: 10 48 c7 c1 ec 6a 54 c1 77 08 4a 8b 0c ed c0 35 59 c1 48 8b 33 48 c7 c2 78 a7 4d c1 48 c7 c7 60 a4 5c c1 e8 8c 9e ca d0 eb bf <41> 8b 86 e8 00 00 00 85 c0 0f 84 37 ff ff ff e9 26 ff ff ff 31 c0
[ 2312.987855] RSP: 0018:ffffa40402e378e0 EFLAGS: 00010246
[ 2312.987856] RAX: 0000000000000000 RBX: ffff90cf09580000 RCX: 0000000000000000
[ 2312.987858] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff90cf09580000
[ 2312.987859] RBP: ffffa40402e37908 R08: 0000000000000000 R09: c0000000fffeffff
[ 2312.987860] R10: 0000000000000000 R11: ffffa40402e37640 R12: ffffffffc1593d80
[ 2312.987861] R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
[ 2312.987862] FS:  00007fb5d3b33c40(0000) GS:ffff90d006840000(0000) knlGS:0000000000000000
[ 2312.987864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2312.987865] CR2: 00000000000000e8 CR3: 000000010ae24000 CR4: 0000000000750ee0
[ 2312.987867] PKRU: 55555554
[ 2312.987868] Call Trace:
[ 2312.987870]  <TASK>
[ 2312.987872]  ? show_regs+0x5b/0x70
[ 2312.987877]  ? __die_body+0x1f/0x70
[ 2312.987879]  ? __die+0x2a/0x40
[ 2312.987881]  ? page_fault_oops+0x156/0x470
[ 2312.987884]  ? dev_printk_emit+0x87/0xc0
[ 2312.987889]  ? do_user_addr_fault+0x34a/0x720
[ 2312.987891]  ? exc_page_fault+0x75/0x180
[ 2312.987895]  ? asm_exc_page_fault+0x27/0x30
[ 2312.987898]  ? amdgpu_ras_reset_error_count+0x126/0x140 [amdgpu]
[ 2312.987980]  gmc_v9_0_late_init+0x7f/0xc0 [amdgpu]
[ 2312.988064]  amdgpu_device_ip_late_init+0x49/0x2b0 [amdgpu]
[ 2312.988144]  ? mutex_lock+0x12/0x40
[ 2312.988148]  amdgpu_device_init+0x2253/0x24e0 [amdgpu]
[ 2312.988225]  ? pci_read_config_word+0x23/0x40
[ 2312.988230]  amdgpu_driver_load_kms+0x1a/0x1a0 [amdgpu]
[ 2312.988278]  amdgpu_pci_probe+0x16b/0x4a0 [amdgpu]
[ 2312.988278]  local_pci_probe+0x4a/0xb0
[ 2312.988278]  pci_device_probe+0xd9/0x240
[ 2312.988278]  really_probe+0x116/0x3e0
[ 2312.988278]  ? pm_runtime_barrier+0x55/0xa0
[ 2312.988278]  __driver_probe_device+0x81/0x160
[ 2312.988278]  driver_probe_device+0x24/0xb0
[ 2312.988278]  __driver_attach+0x10e/0x170
[ 2312.988278]  ? __device_attach_driver+0x120/0x120
[ 2312.988278]  bus_for_each_dev+0x7b/0xd0
[ 2312.988278]  driver_attach+0x1e/0x30
[ 2312.988278]  bus_add_driver+0x11d/0x220
[ 2312.988278]  ? 0xffffffffc0b56000
[ 2312.988278]  driver_register+0x5e/0x120
[ 2312.988278]  ? 0xffffffffc0b56000
[ 2312.988278]  __pci_register_driver+0x68/0x70
[ 2312.988278]  amdgpu_init+0x74/0x1000 [amdgpu]
[ 2312.988278]  do_one_initcall+0x48/0x210
[ 2312.988278]  ? kmalloc_trace+0x2a/0xa0
[ 2312.988278]  do_init_module+0x4f/0x1f3
[ 2312.988278]  load_module+0x21fe/0x23f0
[ 2312.988278]  ? kernel_read_file+0x291/0x310
[ 2312.988278]  __do_sys_finit_module+0xc0/0x130
[ 2312.988278]  ? __do_sys_finit_module+0xc0/0x130
[ 2312.988278]  __x64_sys_finit_module+0x1a/0x20
[ 2312.988278]  do_syscall_64+0x3a/0x90
[ 2312.988278]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 303fbb6a48b6..33801a5bb460 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1223,7 +1223,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
-	if (!block_obj || !block_obj->hw_ops) {
+	if (!block_obj || !block_obj->hw_ops || !ras) {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
 				ras_block_str(block));
 		return -EOPNOTSUPP;
-- 
2.25.1

