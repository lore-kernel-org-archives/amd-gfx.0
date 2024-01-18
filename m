Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B9CC47258
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 03:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B38F8A01F;
	Thu, 18 Jan 2024 03:26:06 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C3710E12B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 03:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuE3GYUYGFtqHKfys2ag+JgibCjdWVBCoOCkkmri/3PUNdOOuJ+LhXy4Jqj9WXLJ56nHaSjnOaH7xZEzHb7GfYNEqGPXFODzqBNs/aXqc9x9eUdJhDpqIs2ujE+Idw/VngKehtJcJdsq0rbSsdKLgpQx/4yJUYsZ3VMSmhsMIhf6Ik6+YpFmttCIDpdOqdmhVS8syUgf4asVmoAVTjMVVEx/EmZXuQsEjzYSmzsZmdvFw0I0DLPGN/U9Zv884lebE4rFP6L8OZiqi2dlzMI4xEi639v7qTMYDT59QHd3ZEqmkLqZuBgMxxKMDiswUxrJoKpyD0mYB5qCjhXQzAe+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jiz5NNEQHmxu8ISSR6Y93kGMURtexANzd/B2+RYp4E=;
 b=LThfe9THHb04kK3Nxc3eQswPeE7PZwobiX6mtPT+yNvO2SfMeQe7qVWliwF8DNuzRfvTGZBctbLScdkoT/N+b5VxUyrCz/88797HyjHu2SEmjO2ovT08Ogk2vlG3P0MbaVdJlxnOe+RxmhmkJ3FPQBFmxHl7S6K1cPd4KLzXKqt9Ks6f3TnWd4cwtgx6HL+fkWvINKY5i3rUh3T1RQtdSYO+w12bMglF5sczn2SpOMzJ5AOEgbEeHJFtGQNOZ1IEiTrgdBqxrhLxDkF0XI/s9p84w98HomnEALPTUmNuTXYqmqqGF0l7fRrU9fTELHNU7NUtuRh3Efw/IW4w91AOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jiz5NNEQHmxu8ISSR6Y93kGMURtexANzd/B2+RYp4E=;
 b=es/rTmJzwsVaheGHkFWjag2x/mA3fra3HPUcuvkvVc1OzKweT6sJAqGjG5ix1RUKJg3tqAXUY3QxWkA480j0LlFwCKqhPfzvSfivP17GW84JbIZePb8UvhUTl96mhE6XvBUhR5A+D5oQ37m6OD+xkGCaKaLI/CwwWzXQoRG1JME=
Received: from MW4PR04CA0061.namprd04.prod.outlook.com (2603:10b6:303:6b::6)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 03:26:02 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::a5) by MW4PR04CA0061.outlook.office365.com
 (2603:10b6:303:6b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 03:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 03:26:02 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 21:26:00 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Skip do PCI error slot reset during
 RAS recovery
Date: Thu, 18 Jan 2024 11:25:31 +0800
Message-ID: <20240118032532.821661-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118032532.821661-1-Stanley.Yang@amd.com>
References: <20240118032532.821661-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf5ffb9-fc2d-4bdc-7c38-08dc17d53291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11lEYFQSPxuhCkotuAMaKIuhdDAsy4eEAbz2Qcdii5SKqyMKVgvtjkoJCQHLcOIuXshfyYBOw8Z3MqhJKLJ+WKZdyCY9HO6uxAJaUDqyivopELfH+iT1Os3+elUAPSNm2dI+FcF5u/dNNVAM1dNwD9/MdU9LhxHJtAkTX/ijMSO4bjA3aIFX/whyZwVYuCh6Y1/W+IyLzhDoGZYapuh5lTrtQRywjWXTzcHKbYHyvnQv4exJ7kWCMClOMrxFl3J8/OPaIH5SXufHAYiozU1oTXltudsXFhAQH4brRp5VjDbWeHYttOhLKIpVvEyoauyLhHTzwYvr9y+SEWH0cdrZwMpmJ1zLvJHiucEFDZLC/IZ3DY0Mi7sw+JyV9ttH64Xd7yRacWciHocLVsO81bxTp43/QHwuErwyKueHVrDMnDpWLltcQGPCONY0RZ3uEAjcDkhQw3KMM8qsQaMQ04OXHgTPGZCDc22wOvNaOmdbFCZlhkAa9KAsEb/QvAMywZMSaNPBZ/IOUG5DzOZ0xTf/AMCs04wTaaldGlU6xbWTDXJ+AKWYdiKRqB1m6O51UnqtLpl4AQuLbaJQQ4LCnVjR/2cv0ubYoU4Z4G0qJeQseyviOdqJUoZJUxGF6xwfNdlTay0SsYmM/Zk3g709PXbe6NBKIDjuO4Xrby4dlugwsixDXwd89W6SLGgJTX9+SPPPHwA+HjWewYaxJK+Z6o2mNiv8QCD1LBShOPWh1DeptVZ1dm6LRUmac5SsEgDGeEyMvuAKMcVENMnL6vkwxsSM2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(8936002)(8676002)(4326008)(5660300002)(6916009)(70586007)(2906002)(70206006)(316002)(54906003)(1076003)(426003)(26005)(16526019)(2616005)(336012)(81166007)(86362001)(36756003)(40480700001)(40460700003)(45080400002)(6666004)(7696005)(478600001)(41300700001)(82740400003)(47076005)(356005)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 03:26:02.2229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf5ffb9-fc2d-4bdc-7c38-08dc17d53291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Why:
    The PCI error slot reset maybe triggered after inject ue to UMC multi times, this
    caused system hang.
    [  557.371857] amdgpu 0000:af:00.0: amdgpu: GPU reset succeeded, trying to resume
    [  557.373718] [drm] PCIE GART of 512M enabled.
    [  557.373722] [drm] PTB located at 0x0000031FED700000
    [  557.373788] [drm] VRAM is lost due to GPU reset!
    [  557.373789] [drm] PSP is resuming...
    [  557.547012] mlx5_core 0000:55:00.0: mlx5_pci_err_detected Device state = 1 pci_status: 0. Exit, result = 3, need reset
    [  557.547067] [drm] PCI error: detected callback, state(1)!!
    [  557.547069] [drm] No support for XGMI hive yet...
    [  557.548125] mlx5_core 0000:55:00.0: mlx5_pci_slot_reset Device state = 1 pci_status: 0. Enter
    [  557.607763] mlx5_core 0000:55:00.0: wait vital counter value 0x16b5b after 1 iterations
    [  557.607777] mlx5_core 0000:55:00.0: mlx5_pci_slot_reset Device state = 1 pci_status: 1. Exit, err = 0, result = 5, recovered
    [  557.610492] [drm] PCI error: slot reset callback!!
    ...
    [  560.689382] amdgpu 0000:3f:00.0: amdgpu: GPU reset(2) succeeded!
    [  560.689546] amdgpu 0000:5a:00.0: amdgpu: GPU reset(2) succeeded!
    [  560.689562] general protection fault, probably for non-canonical address 0x5f080b54534f611f: 0000 [#1] SMP NOPTI
    [  560.701008] CPU: 16 PID: 2361 Comm: kworker/u448:9 Tainted: G           OE     5.15.0-91-generic #101-Ubuntu
    [  560.712057] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C11.AG.1 11/08/2023
    [  560.720959] Workqueue: amdgpu-reset-hive amdgpu_ras_do_recovery [amdgpu]
    [  560.728887] RIP: 0010:amdgpu_device_gpu_recover.cold+0xbf1/0xcf5 [amdgpu]
    [  560.736891] Code: ff 41 89 c6 e9 1b ff ff ff 44 0f b6 45 b0 e9 4f ff ff ff be 01 00 00 00 4c 89 e7 e8 76 c9 8b ff 44 0f b6 45 b0 e9 3c fd ff ff <48> 83 ba 18 02 00 00 00 0f 84 6a f8 ff ff 48 8d 7a 78 be 01 00 00
    [  560.757967] RSP: 0018:ffa0000032e53d80 EFLAGS: 00010202
    [  560.763848] RAX: ffa00000001dfd10 RBX: ffa0000000197090 RCX: ffa0000032e53db0
    [  560.771856] RDX: 5f080b54534f5f07 RSI: 0000000000000000 RDI: ff11000128100010
    [  560.779867] RBP: ffa0000032e53df0 R08: 0000000000000000 R09: ffffffffffe77f08
    [  560.787879] R10: 0000000000ffff0a R11: 0000000000000001 R12: 0000000000000000
    [  560.795889] R13: ffa0000032e53e00 R14: 0000000000000000 R15: 0000000000000000
    [  560.803889] FS:  0000000000000000(0000) GS:ff11007e7e800000(0000) knlGS:0000000000000000
    [  560.812973] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  560.819422] CR2: 000055a04c118e68 CR3: 0000000007410005 CR4: 0000000000771ee0
    [  560.827433] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [  560.835433] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
    [  560.843444] PKRU: 55555554
    [  560.846480] Call Trace:
    [  560.849225]  <TASK>
    [  560.851580]  ? show_trace_log_lvl+0x1d6/0x2ea
    [  560.856488]  ? show_trace_log_lvl+0x1d6/0x2ea
    [  560.861379]  ? amdgpu_ras_do_recovery+0x1b2/0x210 [amdgpu]
    [  560.867778]  ? show_regs.part.0+0x23/0x29
    [  560.872293]  ? __die_body.cold+0x8/0xd
    [  560.876502]  ? die_addr+0x3e/0x60
    [  560.880238]  ? exc_general_protection+0x1c5/0x410
    [  560.885532]  ? asm_exc_general_protection+0x27/0x30
    [  560.891025]  ? amdgpu_device_gpu_recover.cold+0xbf1/0xcf5 [amdgpu]
    [  560.898323]  amdgpu_ras_do_recovery+0x1b2/0x210 [amdgpu]
    [  560.904520]  process_one_work+0x228/0x3d0
How:
    In RAS recovery, mode-1 reset is issued from RAS fatal error handling and expected
    all the nodes in a hive to be reset. no need to issue another mode-1 during this procedure.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6b9e0dcf9d7d..0bb02291a5a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6175,6 +6175,20 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	struct amdgpu_reset_context reset_context;
 	u32 memsize;
 	struct list_head device_list;
+	struct amdgpu_hive_info *hive;
+	int hive_ras_recovery = 0;
+	struct amdgpu_ras *ras;
+
+	/* PCI error slot reset should be skipped During RAS recovery */
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		hive_ras_recovery = atomic_read(&hive->ras_recovery);
+		amdgpu_put_xgmi_hive(hive);
+	}
+	ras = amdgpu_ras_get_context(adev);
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) &&
+		 ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
+		return PCI_ERS_RESULT_RECOVERED;
 
 	DRM_INFO("PCI error: slot reset callback!!\n");
 
-- 
2.25.1

