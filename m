Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3879BC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 08:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF19E10E3EF;
	Mon, 22 Jul 2024 08:16:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJIoEsLb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B0C10E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 08:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQPnCW7mEsWrzbAiXlhVitW70QivymivJmtUziTaT7qR6OxDhzLYFpt8Vev2zwX3qsYElYbWDPrX3BUoX2uicRG55DcxW2YUJywVmF6us8t7NxJowlKEuoIxEbwbRLHv6eX7gFmgabO+uwm///3AkHWdAiFGYdQYTMlVljgIs01j9Bn4/CjJXNouSDaXEbh4OW6L5PKCsPhsrsepcfvMNPNPMquD/aizIBRQu+pJQGqyz4Hz+d2QevrFxEUxGIXGLmgPbiJpvTjIzfnNWjE4MA1Q/2ukOB/rIvSVNLjM0PeiMwrHD0gtJKcyWXC91D/1/XN4bVP2os8k1Vlp8Rz8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2upZQrvSL5AKq2vzgVH0ROMb/+LbQSP1R8C4Ml5lay4=;
 b=CmunhhefOhdERlV76gH9uqUuQdFdtmQxHvB/GDrpqUq9OKisn7JlG/GOXNe44tp20/tE3BHuIW6SgT9LWfU0cr6mrwTbZ24Cu+XghX0NYG0EQtlmC90i6KJ6SFB6YJQYBu2LrxEC/6PsDzpAm7KZ/1wEpIVkjPCH3C9sfhFR6YBUrzykcQ7/QmhRy5FzKMHOSu7dmV9fpPWqRdH4xMUTBe0Qv3KBdKKpBt0RdOHoQhSlnM0908qTJWjNPQVlxr8gi3XA5u/dgk3xdjy7WeQDrSIzczDThB4PrqPF5JXLMwv3AzNE7dSXQoebShOh6DHCjC3CqTqis4xwTs3+1P/q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2upZQrvSL5AKq2vzgVH0ROMb/+LbQSP1R8C4Ml5lay4=;
 b=MJIoEsLb/jQTW1wq57qo5hiP92q6+bU2uXTo5KzA6Edn731Rfy5OGthitm/REOZa6ZS7oHJAn5e8YYOjbieczM1eZAYp0K274CM3SRkRJ9RFgiejC8VssWJ8Uv2WDVyfeygO67EArpb5S2LVUe66ckBzQ2YR9aPtfFnMaVwAye4=
Received: from DS7PR03CA0140.namprd03.prod.outlook.com (2603:10b6:5:3b4::25)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 08:16:38 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::81) by DS7PR03CA0140.outlook.office365.com
 (2603:10b6:5:3b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 22 Jul 2024 08:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 08:16:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 03:16:36 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 22 Jul 2024 03:16:30 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix gfx10 kiq ring_lock warning on full reset
Date: Mon, 22 Jul 2024 16:16:25 +0800
Message-ID: <20240722081625.85392-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6a7655-a2b2-45b4-6307-08dcaa269c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E8obyRfFdHy1fbS/2EmapuYGM/A+QdyFfDoYL+Yw2ape6uD/81s35NqOhbIB?=
 =?us-ascii?Q?V/8QEN1NYIIbTq5uleCkDOw6QGW8BAUhOIbsHMyXbL0pPsYbzAhVJfIQl3Ey?=
 =?us-ascii?Q?+h8M0Fbs+CNuU3+zrn3SS4YCn8JEiqXIQeTbgLcOKl331z/r98tDZrrfwEGG?=
 =?us-ascii?Q?a3Ao9BHq+olb+OYvfr5com4w0Vof3CjL0RA4kYlr+ybaic2E7gO4RiXhJYCa?=
 =?us-ascii?Q?U7IvGHWAg9ElbsR3OCFvCSYMypzYJNqX2o0Ld5tRZRSdwi3NGh4SSCPL3Xcu?=
 =?us-ascii?Q?i/cIZNzhCfxx4lAY9TveWmGSX5T91qNUUJbiG5Wrpi2jbC2MoKuYFx11X6g6?=
 =?us-ascii?Q?sft087Qh6ZDvwPkf3xHM7/1HYO6QuHwYS+A0smltalviJhVe2xCC0Wal3a+h?=
 =?us-ascii?Q?oWjx6M8cocMXFEKeS8mFO0NzeeB7Hg5jyGdXcB2CmT+ekCDiOvp8uMUe446s?=
 =?us-ascii?Q?kgM4Qsu3M6g9eP68yLKnZ7PMCO7VQ4lV18FKgToJQWxPSh/rbdUZ6PYIMvgj?=
 =?us-ascii?Q?Cb+hSfhec+lIFm7vWi5BKWhkryyM3NHqXMl3a9efT//U7jNt/YVAQ0XIVfp1?=
 =?us-ascii?Q?jQQa4v3fBIVu5R3QN/6jt6Zf5wuN+PuPLdB65g5GPw8xOEfGg61BPQU2N9TS?=
 =?us-ascii?Q?h0qHFrkHMsDiM5ZtddYAJWhwPIWsoYZOhT/CF5kH/1GpfA3FPwFCtQ1UNW5D?=
 =?us-ascii?Q?bD8hFIa93GEDMtGcbYPXwqDfP2O5LfpRhtFq08txLeRB/ajS+0VQfq6oFLxr?=
 =?us-ascii?Q?+bRmeIPky9hLSAJ++MVgILESls5jNQlgRjuBbNj61yPbDd2A14omKOUw78YE?=
 =?us-ascii?Q?Go6uXks6Va0ixI4a/3cKDMg1KUCcHoDvpAcpYy4UgrSZi2xuvCIaxrGBURUY?=
 =?us-ascii?Q?M+mZ6qOkTW/g5Wa31HkfFQnA6XMSBIwA+PRTRY+43meHkIsdbzvP8wYF7kCE?=
 =?us-ascii?Q?0W6bbWKnwzRZVzvdE0QHVPq4FcWIKTdzhruRPJI0xL57Qk1Z91Y7LIsjAnsb?=
 =?us-ascii?Q?FAYHv/ShyUe/lw6cov/N/rqeoihDIkdJno30zIoVFrD4nnnycg1rtvK0mUWz?=
 =?us-ascii?Q?s8Ls9OjMpIut8Ihet1/rZ8QN9NhawqJGQsBhtS9D2uzZHp22y1EJZvz5Ruju?=
 =?us-ascii?Q?UdOaUI/4lvdnuyXy3jAEi7rtgGXI5IYk5ESOyyETrfrI9h8PktVrKPL4n4Wv?=
 =?us-ascii?Q?pTuEh1XOF+TQ3JsxGpwMUJcSwueVVXQsZ0IhjoZZ0d8LrAyEmLnv10Ilk86I?=
 =?us-ascii?Q?DTLvfUQ3A0XLsRVQ4LkCS5Gp6KthDbeVJ0lg3MIk8a8J3xxx2PJnLB3MLNpP?=
 =?us-ascii?Q?gX3Ifx35o0qg3czahmDoiJk8FC6B3/daAYXQu8G7q28btDly8Vs5LiGr6c+P?=
 =?us-ascii?Q?nX9mMBaSDjV8D2VbLaXWcx25/AKgs8n3qwJAOrDXjB0x/Ogygqvg7GNmqgN4?=
 =?us-ascii?Q?TKopc847w6RgbS7hH2sbx0l2ap7hPEhg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 08:16:38.3017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6a7655-a2b2-45b4-6307-08dcaa269c29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix warning about kiq ring.
Unlock kiq ring when queue reset fails.

[  285.999224] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
[  312.018425] watchdog: BUG: soft lockup - CPU#11 stuck for 26s! [kworker/=
u64:2:878]
[  312.018428] Modules linked in: amdgpu(E) amdxcp drm_exec gpu_sched drm_b=
uddy drm_suballoc_helper drm_ttm_helper ttm drm_display_helper cec rc_core =
drm_kms_helper i2c_algo_bit rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd gra=
ce netfs xt_conntrack nft_chain_nat r8153_ecm cdc_ether usbnet xt_MASQUERAD=
E nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xf=
rm_user xfrm_algo xt_multiport xt_addrtype nft_compat nf_tables br_netfilte=
r libcrc32c nfnetlink bridge stp llc r8152 mii joydev input_leds overlay sn=
d_hda_codec_hdmi edac_mce_amd snd_hda_intel snd_intel_dspcfg snd_intel_sdw_=
acpi kvm_amd snd_hda_codec snd_hda_core snd_hwdep kvm hid_generic snd_pcm c=
rct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 ae=
sni_intel snd_seq_midi snd_seq_midi_event snd_rawmidi crypto_simd usbhid cr=
yptd hid snd_seq snd_pci_acp5x snd_seq_device snd_timer snd_rn_pci_acp3x ra=
pl snd_acp_config snd_soc_acpi snd ccp snd_pci_acp3x wmi_bmof soundcore k10=
temp mac_hid sunrpc binfmt_misc sch_fq_codel msr parport_pc
[  312.018466]  ppdev lp drm parport efi_pstore ip_tables x_tables autofs4 =
ucsi_ccg typec_ucsi typec nvme crc32_pclmul nvme_core xhci_pci i2c_designwa=
re_pci i2c_piix4 xhci_pci_renesas i2c_ccgx_ucsi video wmi
[  312.018475] CPU: 11 PID: 878 Comm: kworker/u64:2 Tainted: G            E=
      6.8.0+ #171
[  312.018477] Hardware name: AMD Splinter/Splinter-GNR, BIOS WS54117N_140 =
01/16/2024
[  312.018478] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sche=
d]
[  312.018485] RIP: 0010:native_queued_spin_lock_slowpath+0x88/0x300
[  312.018490] Code: 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 41 8b 04 24 30 e4 =
09 d0 a9 00 01 ff ff 75 5e 85 c0 74 14 41 0f b6 04 24 84 c0 74 0b f3 90 <41=
> 0f b6 04 24 84 c0 75 f5 b8 01 00 00 00 66 41 89 04 24 5b 41 5c
[  312.018492] RSP: 0018:ffffa327c0de7b80 EFLAGS: 00000202
[  312.018493] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000000=
00000
[  312.018494] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8ab913e=
16cf8
[  312.018495] RBP: ffffa327c0de7ba8 R08: 0000000000000000 R09: fffffa40070=
40000
[  312.018495] R10: ffffa327c0de7bb8 R11: 0000000000000040 R12: ffff8ab913e=
16cf8
[  312.018496] R13: ffff8ab913e00000 R14: ffff8ab913e00000 R15: ffff8ab913e=
00000
[  312.018497] FS:  0000000000000000(0000) GS:ffff8ab9956c0000(0000) knlGS:=
0000000000000000
[  312.018498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  312.018498] CR2: 00007f44b24d319c CR3: 000000023b83c000 CR4: 00000000007=
50ef0
[  312.018499] PKRU: 55555554
[  312.018500] Call Trace:
[  312.018501]  <IRQ>
[  312.018504]  ? show_regs+0x6c/0x80
[  312.018508]  ? watchdog_timer_fn+0x206/0x290
[  312.018511]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  312.018513]  ? __hrtimer_run_queues+0xc8/0x220
[  312.018517]  ? hrtimer_interrupt+0x10d/0x250
[  312.018519]  ? __sysvec_apic_timer_interrupt+0x51/0x130
[  312.018522]  ? sysvec_apic_timer_interrupt+0x7f/0x90
[  312.018525]  </IRQ>
[  312.018525]  <TASK>
[  312.018526]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[  312.018529]  ? native_queued_spin_lock_slowpath+0x88/0x300
[  312.018530]  _raw_spin_lock+0x2d/0x40
[  312.018532]  amdgpu_gfx_disable_kgq+0x6f/0x1d0 [amdgpu]
[  312.018646]  gfx_v10_0_hw_fini+0x111/0x130 [amdgpu]
[  312.018742]  gfx_v10_0_suspend+0x12/0x20 [amdgpu]
[  312.018832]  amdgpu_device_ip_suspend_phase2+0x244/0x470 [amdgpu]
[  312.018909]  amdgpu_device_ip_suspend+0x4b/0x90 [amdgpu]
[  312.018989]  amdgpu_device_pre_asic_reset+0xda/0x4b0 [amdgpu]
[  312.019068]  amdgpu_device_gpu_recover+0x319/0xe20 [amdgpu]
[  312.019147]  amdgpu_job_timedout+0x177/0x280 [amdgpu]
[  312.019266]  drm_sched_job_timedout+0x7c/0x100 [gpu_sched]
[  312.019269]  process_scheduled_works+0x9a/0x3a0
[  312.019272]  ? __pfx_worker_thread+0x10/0x10
[  312.019273]  worker_thread+0x15f/0x2d0
[  312.019275]  ? __pfx_worker_thread+0x10/0x10
[  312.019276]  kthread+0xfb/0x130
[  312.019277]  ? __pfx_kthread+0x10/0x10
[  312.019278]  ret_from_fork+0x3d/0x60
[  312.019280]  ? __pfx_kthread+0x10/0x10
[  312.019281]  ret_from_fork_asm+0x1b/0x30
[  312.019284]  </TASK>

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index fde11159270c..59024fbf8c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9478,6 +9478,7 @@ static int gfx_v10_0_reset_compute_ring(struct amdgpu=
_ring *ring,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
=20
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r =3D amdgpu_ring_test_ring(kiq_ring);
 	if (r)
 		return r;
@@ -9530,8 +9531,6 @@ static int gfx_v10_0_reset_compute_ring(struct amdgpu=
_ring *ring,
 	if (r)
 		return r;
=20
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	return amdgpu_ring_test_ring(ring);
 }
=20
--=20
2.25.1

