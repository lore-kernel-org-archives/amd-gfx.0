Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F5FC76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 20:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A36A10E2FB;
	Thu,  6 Apr 2023 20:01:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9369510E2FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 20:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jowVFK3fJGqZEKLpxsYtb8C/Pu6Su7V7XYEE3EMF6yv4m9Ac/WsQdiSmUpF78futlFHxbFQT2V1NbEKzw+PSaj9enkPUt3ig6KIHbmbnK2WqTNlNlFs/PPCPHOsyH+a+ib0Psnl3SHkon41+jiRj9B0jS9IXzN3k42vTJiBROun4aC/fe+cmXJvcOi6ZYoly4Cn52jx4L97M5NIJlr2NVfdHJxQe/ZuKktxZoTBbxkVlvzMOMwc4P4nS238UZcqOiMgm4wvIQkvoX5+SCcafHjFYk8Hg17MAmYOAM90/QuRgzWXkFRvg4O4s1BAkOJowDwe/Zw0rD3kRsPqyUzVdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki7cx8reuAduvvzgmJheLxMKc0mb+W80E3C75NEJWro=;
 b=CKFFpKAXk8oAfS0UUchyy8EyWkGM3TShGyvI3NzOcfnZj6OzXgNS4qVxZAN3ZmaOYOXnIq7kOGdLlBq1aWbTsfp2dH7c8y40USZ+gLg4+8QaMMXnCy7KSGoJzEm9wV7zpOw3lRYIkP9dbahOfxyxXJSEl3A3uRcYnxcFiuBxkOFv9qqEMxq0KLxF8uQnDRCHuyuUxNvYwpjn9Jrnh5nGw1cHmg390kDp8gZGIvDKhgD3sSE6/mSdQ7dhDLy7kfGb0g6IxYpwGYcQmBs5su1vK6CplDn3cqHIrnkEMPrIk1/OB8sJ/H8xjzvTK8Yy98aXT7uqoxiSIUTcXWp4LDppYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki7cx8reuAduvvzgmJheLxMKc0mb+W80E3C75NEJWro=;
 b=h5O0KlXsKzW9T/S4kkF7oVr8ua9Gb7MMC+xgm6vxc4QQMc150kzytqyMcrdg/neZfD6Fkx7+n0K3WaLOTGicapH5utMPZMJh9q1LDc33Z2WMf17l7dcKTKs81hw5nQ4lXu7r+PRmjQWPYHGzDrywCxUnD0W6VH9Q1zJqseDZnew=
Received: from BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::26)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 20:01:31 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::8) by BL1P223CA0021.outlook.office365.com
 (2603:10b6:208:2c4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 6 Apr 2023 20:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 6 Apr 2023 20:01:30 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 6 Apr 2023 15:01:29 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/sched: Check scheduler ready before calling timeout
 handling
Date: Thu, 6 Apr 2023 16:00:54 -0400
Message-ID: <20230406200054.633379-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: f9799726-a3a6-410f-3290-08db36d9b703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBAPf6i1LjUWaNCMzjOS+Ht/EBBGIPXyDM+K4TnjZY9DMEi7jWwBkmzVUKrNfi9eGL2GOzUqVUTNunKH3UnjgAWtQ7nBnl2HV6db5D3rJSIx/6UdJf3bY56tmKnDyhlmeDExpxYh+H+A6ZMFumA3tRXH6jme8EwKLOjj0ibtWMmHHgsK7kbnxnX1hMfEGyMhS40gsk+zb4SP0riX6oVRfOhAusjvWpSThC2liehtKjmFpSEo3cVso+GOj/b/25q1XA2KReEwF0JJhBvaHVe/6ZOLV/d8pOOaa8Ehus4Uu/uIcN/jEy/oBE1K1G/uH2J5gHDgQ8HSN/eNqol2QnpwXVweagQJdFO1LcL1lI5ETkE+97eAv37HGWMohslzscQpkqyKKZbxYorff63B9EZF9IUrI57RoffDhJa4ajVVDLBFuoYN4pNQVZov2Kutd/YPKfQTFP54nAB/9+poiQHwotDnOAxSit/mzJyiP+Ch7CK5la9bh4R66u4im5GxQVvrILpl4+i8k+dmEfv7u4Ci+HME/QT6gEt9CYPqNbmvjIRwJ6njrKZKVAvTjiPH2J9WT6MgJvPYQE1FHuqV+RXD/ruU4gdzbAoCXBN29ciCVczQs1vsg2T/SLi5rEqjIGhqZ7c/SIf8lRZzq3jeSEbAGzrQrHh6wMKCEOzpptlpYChYPs4MewgYs2C9Hih0kM8RRVREBkNjP+dSCBHmEm94O9WVyR9xiAnH3U/5xDhe+No=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(16526019)(82310400005)(41300700001)(54906003)(4326008)(316002)(66574015)(70206006)(426003)(2616005)(478600001)(8676002)(70586007)(83380400001)(1076003)(6916009)(45080400002)(81166007)(82740400003)(40460700003)(7696005)(36756003)(86362001)(2906002)(8936002)(5660300002)(47076005)(44832011)(186003)(36860700001)(6666004)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 20:01:30.8831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9799726-a3a6-410f-3290-08db36d9b703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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
Cc: Luben Tuikov <luben.tuikov@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

During an IGT GPU reset test we see the following oops,

[  +0.000003] ------------[ cut here ]------------
[  +0.000000] WARNING: CPU: 9 PID: 0 at kernel/workqueue.c:1656 __queue_delayed_work+0x6d/0xa0
[  +0.000004] Modules linked in: iptable_filter bpfilter amdgpu(OE) nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_generic intel_rapl_msr ledtrig_audio snd_hda_codec_hdmi intel_rapl_common snd_hda_intel edac_mce_amd snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core iommu_v2 gpu_sched(OE) kvm_amd drm_buddy snd_hwdep kvm video drm_ttm_helper snd_pcm ttm snd_seq_midi drm_display_helper snd_seq_midi_event snd_rawmidi cec crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 snd_seq aesni_intel rc_core crypto_simd cryptd binfmt_misc drm_kms_helper rapl snd_seq_device input_leds joydev snd_timer i2c_algo_bit syscopyarea snd ccp sysfillrect sysimgblt wmi_bmof k10temp soundcore mac_hid sch_fq_codel msr parport_pc ppdev drm lp parport ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 hid_generic usbhid hid r8169 ahci xhci_pci gpio_amdpt realtek i2c_piix4 wmi crc32_pclmul xhci_pci_renesas libahci gpio_generic
[  +0.000070] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W OE      6.1.11+ #2
[  +0.000003] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming 3/AB350-Gaming 3-CF, BIOS F7 06/16/2017
[  +0.000001] RIP: 0010:__queue_delayed_work+0x6d/0xa0
[  +0.000003] Code: 7a 50 48 01 c1 48 89 4a 30 81 ff 00 20 00 00 75 38 4c 89 cf e8 64 3e 0a 00 5d e9 1e c5 11 01 e8 99 f7 ff ff 5d e9 13 c5 11 01 <0f> 0b eb c1 0f 0b 48 81 7a 38 70 5c 0e 81 74 9f 0f 0b 48 8b 42 28
[  +0.000002] RSP: 0018:ffffc90000398d60 EFLAGS: 00010007
[  +0.000002] RAX: ffff88810d589c60 RBX: 0000000000000000 RCX: 0000000000000000
[  +0.000002] RDX: ffff88810d589c58 RSI: 0000000000000000 RDI: 0000000000002000
[  +0.000001] RBP: ffffc90000398d60 R08: 0000000000000000 R09: ffff88810d589c78
[  +0.000002] R10: 72705f305f39765f R11: 7866673a6d72645b R12: ffff88810d589c58
[  +0.000001] R13: 0000000000002000 R14: 0000000000000000 R15: 0000000000000000
[  +0.000002] FS:  0000000000000000(0000) GS:ffff8887fee40000(0000) knlGS:0000000000000000
[  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00005562c4797fa0 CR3: 0000000110da0000 CR4: 00000000003506e0
[  +0.000002] Call Trace:
[  +0.000001]  <IRQ>
[  +0.000001]  mod_delayed_work_on+0x5e/0xa0
[  +0.000004]  drm_sched_fault+0x23/0x30 [gpu_sched]
[  +0.000007]  gfx_v9_0_fault.isra.0+0xa6/0xd0 [amdgpu]
[  +0.000258]  gfx_v9_0_priv_reg_irq+0x29/0x40 [amdgpu]
[  +0.000254]  amdgpu_irq_dispatch+0x1ac/0x2b0 [amdgpu]
[  +0.000243]  amdgpu_ih_process+0x89/0x130 [amdgpu]
[  +0.000245]  amdgpu_irq_handler+0x24/0x60 [amdgpu]
[  +0.000165]  __handle_irq_event_percpu+0x4f/0x1a0
[  +0.000003]  handle_irq_event_percpu+0x15/0x50
[  +0.000001]  handle_irq_event+0x39/0x60
[  +0.000002]  handle_edge_irq+0xa8/0x250
[  +0.000003]  __common_interrupt+0x7b/0x150
[  +0.000002]  common_interrupt+0xc1/0xe0
[  +0.000003]  </IRQ>
[  +0.000000]  <TASK>
[  +0.000001]  asm_common_interrupt+0x27/0x40
[  +0.000002] RIP: 0010:native_safe_halt+0xb/0x10
[  +0.000003] Code: 46 ff ff ff cc cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d 69 f2 5e 00 f4 e9 f1 3b 3e 00 90 eb 07 0f 00 2d 59 f2 5e 00 fb f4 <e9> e0 3b 3e 00 0f 1f 44 00 00 55 48 89 e5 53 e8 b1 d4 fe ff 66 90
[  +0.000002] RSP: 0018:ffffc9000018fdc8 EFLAGS: 00000246
[  +0.000002] RAX: 0000000000004000 RBX: 000000000002e5a8 RCX: 000000000000001f
[  +0.000001] RDX: 0000000000000001 RSI: ffff888101298800 RDI: ffff888101298864
[  +0.000001] RBP: ffffc9000018fdd0 R08: 000000527f64bd8b R09: 000000000001dc90
[  +0.000001] R10: 000000000001dc90 R11: 0000000000000003 R12: 0000000000000001
[  +0.000001] R13: ffff888101298864 R14: ffffffff832d9e20 R15: ffff888193aa8c00
[  +0.000003]  ? acpi_idle_do_entry+0x5e/0x70
[  +0.000002]  acpi_idle_enter+0xd1/0x160
[  +0.000003]  cpuidle_enter_state+0x9a/0x6e0
[  +0.000003]  cpuidle_enter+0x2e/0x50
[  +0.000003]  call_cpuidle+0x23/0x50
[  +0.000002]  do_idle+0x1de/0x260
[  +0.000002]  cpu_startup_entry+0x20/0x30
[  +0.000002]  start_secondary+0x120/0x150
[  +0.000003]  secondary_startup_64_no_verify+0xe5/0xeb
[  +0.000004]  </TASK>
[  +0.000000] ---[ end trace 0000000000000000 ]---
[  +0.000003] BUG: kernel NULL pointer dereference, address: 0000000000000102
[  +0.006233] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx_low timeout, signaled seq=3, emitted seq=4
[  +0.000734] #PF: supervisor read access in kernel mode
[  +0.009670] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process amd_deadlock pid 2002 thread amd_deadlock pid 2002
[  +0.005135] #PF: error_code(0x0000) - not-present page
[  +0.000002] PGD 0 P4D 0
[  +0.000002] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  +0.000002] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W OE      6.1.11+ #2
[  +0.000002] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming 3/AB350-Gaming 3-CF, BIOS F7 06/16/2017
[  +0.012101] amdgpu 0000:0c:00.0: amdgpu: GPU reset begin!
[  +0.005136] RIP: 0010:__queue_work+0x1f/0x4e0
[  +0.000004] Code: 87 cd 11 01 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 49 89 d5 41 54 49 89 f4 53 48 83 ec 10 89 7d d4 <f6> 86 02 01 00 00 01 0f 85 6c 03 00 00 e8 7f 36 08 00 8b 45 d4 48

For gfx_rings the schedulers may not be initialized by
amdgpu_device_init_schedulers() due to ring->no_scheduler flag being set to
true and thus the timeout_wq is NULL. As a result, since all ASICs call
drm_sched_fault() unconditionally even for schedulers which have not been
initialized, it is simpler to use the ready condition which indicates whether
the given scheduler worker thread runs and whether the timeout_wq of the reset
domain has been initialized.

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index fd22d753b4ed0c..fcd4bfef741580 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -308,7 +308,8 @@ static void drm_sched_start_timeout(struct drm_gpu_scheduler *sched)
  */
 void drm_sched_fault(struct drm_gpu_scheduler *sched)
 {
-	mod_delayed_work(sched->timeout_wq, &sched->work_tdr, 0);
+	if (sched->ready)
+		mod_delayed_work(sched->timeout_wq, &sched->work_tdr, 0);
 }
 EXPORT_SYMBOL(drm_sched_fault);
 

base-commit: 49144cd279d047c1d572a57323df3af8e1461894
-- 
2.40.0

