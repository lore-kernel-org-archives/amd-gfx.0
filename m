Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD528C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 02:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B91410E118;
	Fri, 16 Dec 2022 02:57:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA0A10E118
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 02:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilDQ3zhpBhxJRReZPJqMEv0orw5LPZSkGGWiHIJPYq19jKdD8c5KQupOk4zbBRGbsuzKdYfLTVVTvWTHWa0f3zUrPmsV84bT1/mC0Jsl4gN30fmKALHO4KdlnSuEjLlRKA+tify+93uiITuDM1suIS36VdROxBr8t715UKTktG0F4GzwdyDQnXl8B1RNpKssXlMt36EK3K8UR/yzF81bBFcvoABw/l7/uVVKc9guHSr/s0h4+XZQM207yquPlLIJoh2/Mt+5+RWCZrd3Cuynl6WM0L6ptAwdPu3GgCQ8fqwWXEdIlQYCJccC926uAmeYlSA44Rql6AYWo/T8FUpJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42NoQxDLvlAev+K1KNNbi2KumL95xESbOnNIUtX/XeU=;
 b=iXTNCZpfp66Tp3cfZvsWNu73kGeDXsCOQ1GmILoIfJrLp1aSXTC28S+qr0AJEpWPAFxXthkZVqvRsX00lKPIqRUgMsUOoXC4qdGy+LE+VreI5QUeI5CdEUShSxD92JDUbe6GpVOCklb5PovtOOru0ISI6tnjgBR4rKOs692DxA71VZM3jzFiGD7sxN849spqJWg+gfOBzNS32xHO5UH3a7X+5vDUfdfp/YOUQwvTLGka0NvFBIme27d5+CJKSB7glYeDBOpFOvlcE9XarPX/BRwB7VTTeJyNNNzFysbf1RsCrRXO3fCUlPHEbOvjyeXdmQWcTILOSfhDP+wCPYaDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42NoQxDLvlAev+K1KNNbi2KumL95xESbOnNIUtX/XeU=;
 b=hjM89GTH+aOzvjHmGsUyQ9OCf8J5GpbZMGa7SXjzcC+NRWMpb9LN96vEXoPXomZxzEs1ttsY2yjxLe1jYSy0dwGH1yuz7PRw/uivZC6o+HvNJfb4SnGPCLmsq7nEa2EXTNzl5xUbB5vccxFCZEwbOGfnqLFHhhMwyJG+rCFMx44=
Received: from MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::13)
 by CH2PR12MB4874.namprd12.prod.outlook.com (2603:10b6:610:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 02:57:36 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::c) by MW4P223CA0008.outlook.office365.com
 (2603:10b6:303:80::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Fri, 16 Dec 2022 02:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.12 via Frontend Transport; Fri, 16 Dec 2022 02:57:36 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 20:57:31 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fixed bug on error when uninstalling amdgpu
Date: Fri, 16 Dec 2022 10:56:21 +0800
Message-ID: <20221216025621.176460-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|CH2PR12MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: bd207692-d123-41ab-d0da-08dadf114958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4u7tzw2Ja0K6bQnNgUiPjOtZtiqKpYami6TRE9rVq8Vuj89fhoLOP8uE9VdgJSovMZfgepFpJlLBFWRgW1i1tMKmpDg4P1upW81hqBmyD4Wck2xPHVWTJLrO3uQAvdLFUCiE7aKFTrLWHGxYTy2QHThCnFJIQk9ysZqxGXelMPtdtBM5tL6cuT3kbAk9+Sww//Lq7IaU5xMX6ncvtcRWagVGqRq5AL4Wt1bRHuYpJKY0EhOC8xVFjRYZmjVjebqpyjWpXBxeXxhhhAD8pcQEj4r8T7k7Cz84zw2Z8tHZX8rzOHzc0KPdAsl+1JY2dLSIiqamzxvf2kzbl7cmevziI3w9woylf6UXxxP6vOPbgNM5k0yK/fF9YjoJDFnQqvykJrKBQaCW21aJrS8NsE6iMoCivKtTWQ4GhdJofb1d8nHmAXtoHG0k/7UR/3t9qwzf1RiobRzdBOQTdhOnPHQuczrm1XQT39pHu/+jkQj5duB1wRCkQ4FUVXXfgpxSijaoMQhH9febB2pbZ1qJzCPeGbnFTj3HejFtCTvAn5SEqOgka+CDJ1uVwIYLcEq+14iaW/ZAtITMMFH1uXho/AXxp3DI7eLB9v9z6clh5CGjGd2TsKB+LZSbLYDA+r8CNpdYNwpq1CBv8tOJ+IhQZMpRpufNoivPth2cgtP5MQ5XQy/d3ktJVng4kaZTisLmtKKREIaawEgtWokv7Rwi2ECgNftoOh33NVdOnXZmZvnIhs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(316002)(356005)(83380400001)(6916009)(426003)(47076005)(8936002)(36756003)(336012)(41300700001)(5660300002)(81166007)(1076003)(82740400003)(70206006)(70586007)(8676002)(2616005)(40460700003)(4326008)(54906003)(478600001)(26005)(6666004)(82310400005)(186003)(16526019)(36860700001)(40480700001)(86362001)(2906002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 02:57:36.2779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd207692-d123-41ab-d0da-08dadf114958
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4874
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng
 Chai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixed bug on error when uninstalling amdgpu.
The error message is as follows:
[  304.852489] kernel BUG at drivers/gpu/drm/drm_buddy.c:278!
[  304.852503] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  304.852510] CPU: 2 PID: 4192 Comm: modprobe Tainted: G        W IOE     5.19.0-thomas #1
[  304.852519] Hardware name: ASUS System Product Name/PRIME Z390-A, BIOS 2004 11/02/2021
[  304.852526] RIP: 0010:drm_buddy_free_block+0x26/0x30 [drm_buddy]
[  304.852535] Code: 00 00 00 90 0f 1f 44 00 00 48 8b 0e 89 c8 25 00 0c 00 00 3d 00 04 00 00 75 10 48 8b 47 18 48 d3 e0 48 01 47 28 e9 fa fe ff ff <0f> 0b 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 55 48 89 f5 53
[  304.852549] RSP: 0018:ffff9afac17bbcb8 EFLAGS: 00010287
[  304.852556] RAX: 0000000000000000 RBX: ffff8dacd37fd778 RCX: 0000000000000000
[  304.852563] RDX: ffff8dacd37fd7a0 RSI: ffff8dacd37fd3b8 RDI: ffff8dac672a5f80
[  304.852570] RBP: ffff8dacd37fd3a0 R08: 0000000000000001 R09: 0000000000000000
[  304.852577] R10: ffff8dac68185500 R11: ffff9afac17bbd00 R12: ffff8dac672a5f80
[  304.852584] R13: ffff8dac672a5fe0 R14: ffff8dacd37fd380 R15: ffff8dac672a5f80
[  304.852590] FS:  00007f0fa9b30c40(0000) GS:ffff8dadb6480000(0000) knlGS:0000000000000000
[  304.852598] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  304.852604] CR2: 00007f4bf1a1ba50 CR3: 0000000108c58004 CR4: 00000000003706e0
[  304.852611] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  304.852618] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  304.852625] Call Trace:
[  304.852629]  <TASK>
[  304.852632]  drm_buddy_free_list+0x2a/0x60 [drm_buddy]
[  304.852639]  amdgpu_vram_mgr_fini+0xea/0x180 [amdgpu]
[  304.852827]  amdgpu_ttm_fini+0x1f9/0x280 [amdgpu]
[  304.852925]  amdgpu_bo_fini+0x22/0x90 [amdgpu]
[  304.853022]  gmc_v11_0_sw_fini+0x26/0x30 [amdgpu]
[  304.853132]  amdgpu_device_fini_sw+0xc5/0x3b0 [amdgpu]
[  304.853229]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
[  304.853327]  drm_dev_release+0x20/0x40 [drm]
[  304.853352]  release_nodes+0x35/0xb0
[  304.853359]  devres_release_all+0x8b/0xc0
[  304.853364]  device_unbind_cleanup+0xe/0x70
[  304.853370]  device_release_driver_internal+0xee/0x160
[  304.853377]  driver_detach+0x44/0x90
[  304.853382]  bus_remove_driver+0x55/0xe0
[  304.853387]  pci_unregister_driver+0x3b/0x90
[  304.853393]  amdgpu_exit+0x11/0x69 [amdgpu]
[  304.853540]  __x64_sys_delete_module+0x142/0x260
[  304.853548]  ? exit_to_user_mode_prepare+0x3e/0x190
[  304.853555]  do_syscall_64+0x38/0x90
[  304.853562]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 0b598b510bd8..eb63324c30d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -829,7 +829,7 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 		kfree(rsv);
 
 	list_for_each_entry_safe(rsv, temp, &mgr->reserved_pages, blocks) {
-		drm_buddy_free_list(&mgr->mm, &rsv->blocks);
+		drm_buddy_free_list(&mgr->mm, &rsv->allocated);
 		kfree(rsv);
 	}
 	drm_buddy_fini(&mgr->mm);
-- 
2.25.1

