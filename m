Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB00CE7A88
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Sep 2023 11:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9EC410E04E;
	Sat, 23 Sep 2023 11:17:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2AB10E04E
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Sep 2023 11:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/vk8XT3rSaWAEuaNNpN+pxlj9+BgqJ5K4NRAmQr7KvwX751InoSWRL6EtWKF9ClRTXc3rpEXc9fvVFd7VplRACnFh6YqVTJB7LlDjXIsCqD/AUl4oY1pMHHAqk2ZCikxFKt3amaXp1R9La0b8BCZ1nucShIxF7QLbQdPhQLSwV9Y9xFLDOnD/q8X464H+81DgdOQdHpxRtRbIxBQOeqE3Va706M92FWDJK6HvhIdpMSkq60IM1R328+WF/Vsh+pRgkLzhq7qz6C9sJ7NBRyGhwLbn3vO9Kh7qR99VqTZHxfqyLAF4FpYlYWrymPTB0nZQgWG2fqvIyfSHg0zyTD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fSuK73v7CwVAglr6s3NrhiKE8GonSZfAUf0fWhhZlQ=;
 b=FgOhvWFU5nrLBJrrMdCmutevdVyZLVWGz6Xa9T9R1uY1Xd5Fwd0usevIb33V535fy9D5G7E+9l3bOWCjfouHeIZjBqCKwPapGziyfwXLTNPD/jTEoKTzWy29dl0Pm4fB8t406u52wQWtOWJo5rO/i8aL+XlEHj2P3l73XGXlP41y2+nog15GlsE601WzmlVy9Hi0Ra/uE1xhMBxItOjyzj0xOFAtI4t8VWAkz7MT124ZDRBhU53QYTRInilMK3Dpj3Pe7fk2kypYA4Hc9y2fL/ScYa2jHMn7FtpYEyMtZHIs+89jnzxN+tra0HWQpRxmt4pcznwG4/RaUAkhJR40+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fSuK73v7CwVAglr6s3NrhiKE8GonSZfAUf0fWhhZlQ=;
 b=X0WEMXxsoqW8dU+x1rzT+Q43UypPMJa7YgA8ktOrviHHM41C5Y0+vRCKpxNtt1e4zf4OvMKcIOQsBj9uQVvNXGoR/DO2aP7qxCLNGgWqVEiyA1gnodA8VSE6GEQhVyVt5Y6QQmcCYJvkOup4JKfx+L7GY529Rc/AAqDVoYMJx7A=
Received: from SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 11:17:09 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::a5) by SN6PR05CA0010.outlook.office365.com
 (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.17 via Frontend
 Transport; Sat, 23 Sep 2023 11:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Sat, 23 Sep 2023 11:17:08 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 23 Sep
 2023 06:17:07 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init
Date: Sat, 23 Sep 2023 19:16:51 +0800
Message-ID: <20230923111651.719593-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|BY5PR12MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b99b56f-00be-40e1-f140-08dbbc26a057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HACHEo65DcuoXMlqZvfQ6s8YyrGE38kOW7qkSR50DMwpaXuB1kLJDCBNcyEJBoW+5TLTbIkY6ZOp04snYSyDJYFGhzQSTalzrMHpuDEsYl/DM5HUSsATPDeRne2H9141FTI7yLaul/WdaPG+Eu/5UZ0cX+vNFXMRki2ohc28sXqsMvQWtae79Tiz1rGdmCxEPU/dcy21AvDtBOgrCCUG8Sr1XqKpB+6lDwh9FlXlvmgyQM8oogi8OiWpjBNVcTSYu1ynPgZ2yA+Lnd/5BcGu24MeKX9W7ocia+znF94Z+rHzn7aPPkdfKKwOdJ6W0Wg6gvTsmpYIMnRn+HE/XhHOQlI9hlVz0mmDTve/UU1Njtq0qcSDoNU79I9ifWkJUkvfKW1TbaQE9/uo5pEzv7pSAOVH7zKwYQOlK/yk9zmN+la/5/4kz9DeOqQmItzu64ru2kt0GhwpPMlo0cIZt5jPo2us3Uahs8nmqjBOwKUoAAoYZ+RWmb6z92VRHVcUzxcBelyDtDX7FEkZezd+nOOl67E9OSZWCstvfsDLu6rAuwxN3MfUsRgJtRO2uH74yBm+ai2Nlc9KXX9x2viZklyaV0xLdnrG51shfrZCe3h584XCQhxG4jdz6yCyBGyK9jf/fn3vBRqljrhYg9EKJtKR526mzqjx0abS6ibwgoqI5g3iJPefHD4VuiBgR9NuL6WDo+ntUanSLV9AmeXYKVhPfaM7R9XYGdXM0UA+hxk6o8Su6O8nJk4mEzUy36TDJNVOwfG+7kgHw0taxo/P//idug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39850400004)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(81166007)(6666004)(478600001)(336012)(426003)(2616005)(36860700001)(26005)(82740400003)(16526019)(1076003)(86362001)(356005)(40480700001)(7696005)(2906002)(5660300002)(4326008)(8676002)(8936002)(6916009)(41300700001)(70586007)(70206006)(54906003)(36756003)(316002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 11:17:08.7329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b99b56f-00be-40e1-f140-08dbbc26a057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gmc11 hw_init depends on adev->gfxhub.funcs->init now, move
it to gmc11 sw_init. This patch fixes below driver load error on
GC 11.0.4:

[   43.928149] [drm] amdgpu: 512M of VRAM memory ready
[   43.928151] [drm] amdgpu: 7641M of GTT memory ready.
[   43.928168] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   43.928182] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   43.928185] #PF: supervisor read access in kernel mode
[   43.928187] #PF: error_code(0x0000) - not-present page
[   43.928188] PGD 0 P4D 0
[   43.928191] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   43.928193] CPU: 7 PID: 1278 Comm: modprobe Tainted: G           OE      6.3.7+ #73
[   43.928198] RIP: 0010:gmc_v11_0_flush_gpu_tlb+0x59/0x4d0 [amdgpu]
[   43.928406] Code: 8b 4d d4 48 89 4d c8 83 f9 0d 0f 87 7c 04 00 00 48 8b 45 c8 44 89 ee 44 89 e7 48 8d 04 80 48 c1 e0 04 49 8b 84 07 90 eb 00 00 <48> 8b 40 08 ff d0 0f 1f 00 44 8b 45 d4 41 89 c5 45 85 c0 0f 85 c0
[   43.928409] RSP: 0018:ffffae24c28277f0 EFLAGS: 00010256
[   43.928411] RAX: 0000000000000000 RBX: ffff95bf0ed80000 RCX: 0000000000000000
[   43.928413] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   43.928414] RBP: ffffae24c2827848 R08: 0003000000000077 R09: 0000000000000401
[   43.928416] R10: 0000000000001000 R11: 0000000000001000 R12: 0000000000000000
[   43.928417] R13: 0000000000000000 R14: 0000000000000000 R15: ffff95bf0ed80000
[   43.928418] FS:  00007f2703c83000(0000) GS:ffff95c26e7c0000(0000) knlGS:0000000000000000
[   43.928421] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.928422] CR2: 0000000000000008 CR3: 000000012c300000 CR4: 0000000000750ee0
[   43.928424] PKRU: 55555554
[   43.928425] Call Trace:
[   43.928426]  <TASK>
[   43.928428]  ? show_regs+0x6e/0x80
[   43.928434]  ? __die+0x29/0x70
[   43.928436]  ? page_fault_oops+0x154/0x4a0
[   43.928440]  ? amdgpu_bo_move+0x25b/0x790 [amdgpu]
[   43.928612]  ? do_user_addr_fault+0x325/0x710
[   43.928615]  ? exc_page_fault+0x7a/0x180
[   43.928619]  ? asm_exc_page_fault+0x2b/0x30
[   43.928623]  ? gmc_v11_0_flush_gpu_tlb+0x59/0x4d0 [amdgpu]
[   43.928797]  ? amdgpu_gart_bind+0x64/0xc0 [amdgpu]
[   43.928974]  amdgpu_gmc_flush_gpu_tlb+0x258/0x2e0 [amdgpu]
[   43.929159]  amdgpu_gart_invalidate_tlb+0x66/0xa0 [amdgpu]
[   43.929332]  amdgpu_gtt_mgr_recover+0x67/0x80 [amdgpu]
[   43.929504]  gmc_v11_0_hw_init+0x4c/0x130 [amdgpu]
[   43.929690]  amdgpu_device_init+0x1766/0x2d60 [amdgpu]
[   43.929858]  ? pci_bus_read_config_word+0x4b/0x80
[   43.929862]  ? do_pci_enable_device+0xdb/0x110
[   43.929866]  amdgpu_driver_load_kms+0x1e/0x1a0 [amdgpu]
[   43.930032]  amdgpu_pci_probe+0x16b/0x4e0 [amdgpu]
[   43.930201]  local_pci_probe+0x4c/0xb0
[   43.930204]  pci_device_probe+0xcc/0x280
[   43.930207]  really_probe+0x1c4/0x430
[   43.930210]  __driver_probe_device+0x8a/0x180
[   43.930212]  driver_probe_device+0x23/0xc0
[   43.930214]  __driver_attach+0xfb/0x200
[   43.930215]  ? __pfx___driver_attach+0x10/0x10
[   43.930217]  bus_for_each_dev+0x7e/0xd0
[   43.930221]  driver_attach+0x22/0x30
[   43.930222]  bus_add_driver+0x120/0x230
[   43.930224]  driver_register+0x68/0x130
[   43.930226]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   43.930394]  __pci_register_driver+0x6c/0x80
[   43.930396]  amdgpu_init+0x67/0xff0 [amdgpu]
[   43.930549]  do_one_initcall+0x4a/0x240
[   43.930554]  ? kmalloc_trace+0x2e/0xa0
[   43.930559]  do_init_module+0x52/0x230
[   43.930563]  load_module+0x2386/0x2880
[   43.930566]  ? security_kernel_post_read_file+0x60/0x70
[   43.930571]  __do_sys_finit_module+0xc8/0x140
[   43.930573]  ? __do_sys_finit_module+0xc8/0x140
[   43.930576]  __x64_sys_finit_module+0x1c/0x30
[   43.930578]  do_syscall_64+0x5d/0x90
[   43.930581]  ? syscall_exit_to_user_mode+0x2a/0x50
[   43.930583]  ? __x64_sys_mmap+0x37/0x50
[   43.930586]  ? do_syscall_64+0x6d/0x90
[   43.930588]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Fixes: c6f52f1ffd91 (drm/amdgpu: cleanup gmc_v11_0_flush_gpu_tlb)
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 42fc0cc13fdd..9c4562bda8cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1329,8 +1329,6 @@ static int gfx_v11_0_sw_init(void *handle)
 	struct amdgpu_kiq *kiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->gfxhub.funcs->init(adev);
-
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7d61f66625fa..d0e3583a3cac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -720,6 +720,8 @@ static int gmc_v11_0_sw_init(void *handle)
 
 	adev->mmhub.funcs->init(adev);
 
+	adev->gfxhub.funcs->init(adev);
+
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
 	r = amdgpu_atomfirmware_get_vram_info(adev,
-- 
2.37.3

