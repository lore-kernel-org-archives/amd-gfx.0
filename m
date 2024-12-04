Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA33E7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 07:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E9C10EC20;
	Wed,  4 Dec 2024 07:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DotVx/tD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB5B10EC20
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 07:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vwbjk1pOjs9JCUVFC3+Ne9wae6HQ5g7DARhc2Cad7BEqQC3qfYS/p+JW3ocrhugaETh9Lc4Xp99/OyyjY0M2/JpqXykUEtwdwHBUMgpm0xXx52xlMlbUkQBKPzJ3eR/AJ18hn6ScV5Ydv1STAKf50K493oJv7AttIwGhNXw+JoihHFLHiwGj1d5x7Y/pH0D9MNi3eFUO9ZdKEGwvaLB8+zRlvZyIaixe0vj2LUFQACX7/kAKmZ1IRyhNAj/aCahr0LTwL/tAnlDkQN8pDfc+ytwmee9WQvCtxAHrJme78/ZrQHdr2MvpIIqL4D1OOfPTuRjWsKlgmAm5416jVNGA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex4HYIpPUJ3JHJtxeh5QEefyR3vBqgEYuXYm3/BN/+A=;
 b=l+S/CYDkO7zT7gDLDZAOQSFQRqgkZSVrYlOfEbE0r8eXMMBGMUOTJG/KJze/X9txQPk5z7+t3T4WqVbh6JeQMXto+MzVsWMl5qhXyUhr1D6Y4dQRYvBNWpTMt2aMo3jSKLqT0ky7Viy3DlUDywkSDquldTApfefo13QM9wyBmctAeymz8ju/WFg69ahYhGC7CY6EVGk+jDe5Mtj7FkOvFZ+rLDEt2ElZQ6TZRyJ2gCac2bJxBPNG8UkSNVdZIJPkLNr9mDjDTbxM85EzHfOaYTcX7c6lSqzp7wXGmruyPoD3uHAqrNP4O7IgaovlHTTqodNPapBl0XxdSFbLLL0cVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex4HYIpPUJ3JHJtxeh5QEefyR3vBqgEYuXYm3/BN/+A=;
 b=DotVx/tD0CRczw8R28gtgN8QrpRNZu+9ghNbsKHWr83WeM/VkSBvToGO8FDb/yJO2dXNqppPx5++qOkSYzp5WAWWX+aQR8aj2keU65dkJIzi0itNyHKift1U7rRQbdJ3MM81kshiDCetSRdZ4nadugQKpiXXUbEuxHt/fD2QIPc=
Received: from BY5PR16CA0026.namprd16.prod.outlook.com (2603:10b6:a03:1a0::39)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 07:43:12 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::bb) by BY5PR16CA0026.outlook.office365.com
 (2603:10b6:a03:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 07:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 07:43:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 01:43:09 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Harish.Kasiviswanathan@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdkfd: Correct the migration DMA map direction
Date: Wed, 4 Dec 2024 15:42:59 +0800
Message-ID: <20241204074259.530839-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec40cda-d0c0-4d82-ad89-08dd14374df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ikq0vFK2fnaYjD8/3CUdoHzdWQm458bCGNJhCmdle08SqgOIFS3rkLvUUusr?=
 =?us-ascii?Q?3GDUtJ4VPG654TWVbP3X2iOe8pmz4mgcUsQSSnziUdy78vAI9fgJof/VucQ1?=
 =?us-ascii?Q?Rsy45PYC80MoCC0WzMHmQzTK5qOGBExbPd2EjHv7l+qH1MnAML5HQl4dZFr5?=
 =?us-ascii?Q?WKkDHV0z9M8xTY1XVu5Hs5T4XsN/AChxWoGLZv2Yf+ioaqqCQlKGSxgFT4tp?=
 =?us-ascii?Q?TSdn/a6QtX256ypTCNxMYiOZP771iS/z4YQoJQMVst7Mp3rgEhyXCpKDlgNJ?=
 =?us-ascii?Q?6JaRP2PESnmuN6a0pr/n7J+Cht8i5m8fLEDolFkl3azqWLZYheOHzv1HXJaN?=
 =?us-ascii?Q?0bJF+z1ZODJ7+T9L9KQZptd26hw4RCn2Ljjq1WUtwyPt3o8WRSFX2yXZvkis?=
 =?us-ascii?Q?quiIP+XXpb6YzNJWc76FIycwnvMb33RWW+BN8M/3drGaQ0itbsJd7EGWB36z?=
 =?us-ascii?Q?/USdhUtDQq5JlS+I+O0w81qFyIOvUELdNa0H5PF8w2MsxCFf1kqDbgSpxhAc?=
 =?us-ascii?Q?9l9cwk71y2G7fjNyidUwMqm/YZw0IjI9W4U80KQefSffWkpgyDBd1dgqhDxi?=
 =?us-ascii?Q?8UfYcIhSf2fSuMntZu80AfLhP6Nf0dG2fF0kGFhtcabZLmlH9VH7ZbXxMsBP?=
 =?us-ascii?Q?IPf7Ka9wan7K+UHQQ8oDm70uQvpxT2OPxu5M/5HS+ngrGoA0WtdidDQcubLB?=
 =?us-ascii?Q?r3v8pOHp4QNLEcLYN2i2mekVEo9o1pKmf+6R2qJguTdcwc9fhvTJms95UZct?=
 =?us-ascii?Q?aUi4EzjeqSFktL0ydmrpru1r/DD9boXGLlPXYD6P4wtFO6hbHhxKbgJeCjUP?=
 =?us-ascii?Q?hdHySLt9KWPn0mT9dPXebkbF+A4cG6Em6BwrhhhiyQ0D4C+npoXWpQKl5xsC?=
 =?us-ascii?Q?2Rg5zzuz5uhBqS5Qm0gHnH5Mdu/l23irOhvzKYkH4p9ve6fzr2bN9CoqEZNN?=
 =?us-ascii?Q?7hiW53T41Bb2u+uUwp0wZFTr4JQIXkPOFTOKETjatjX0kh2LmhqTu9hdGFJf?=
 =?us-ascii?Q?FiKpZJ91z+L4JTRbzA3TKZlES9WrzcV4bpt06h5xHuxoEW7muk7z2iS9q5zA?=
 =?us-ascii?Q?bYioBP9D4ax8ybWeFmxfY7t5snUFaU+hv4Bzl8sgUjJT4+JYy1VoUDq9wg/t?=
 =?us-ascii?Q?MDHSEm9B2FjD2ZwY0vp1KBY0FIy6HjPCDmDERbViuRos+pcMjiNfLQbI1qZ9?=
 =?us-ascii?Q?BxiFrg0b4LFnEY546cxVxq1oVz87EOoFoBx3bhLxMI+4PfzjVy/4TQ65cFtt?=
 =?us-ascii?Q?F9fK06g8Zp0S/ltGZRUWKPw1LziVWCrnvwFaRgpVUxkNgBhytQc2rQV07O35?=
 =?us-ascii?Q?ZWOZlEAjI7xX71QlHMOZ1UZA08evWg+Fc8/EToGmU3xkMqMdP7LNTCwALczV?=
 =?us-ascii?Q?hxKzC9of7Sijg8E2SBWI0VpryRrltA/v6gpkWoE5FY47+VjFew=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 07:43:11.8775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec40cda-d0c0-4d82-ad89-08dd14374df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

The SVM DMA device map direction should be set the same as
the DMA unmap setting, otherwise the DMA core will report
the following warning.

Before finialize this solution, there're some discussion on
the DMA mapping type(stream-based or coherent) in this KFD
migration case, followed by https://lore.kernel.org/all/04d4ab32
-45a1-4b88-86ee-fb0f35a0ca40@amd.com/T/.

As there's no dma_sync_single_for_*() in the DMA buffer accessed
that because this migration operation should be sync properly and
automatically. Give that there's might not be a performance problem
in various cache sync policy of DMA sync. Therefore, in order to
simplify the DMA direction setting alignment, let's set the DMA map
direction as BIDIRECTIONAL.

[  150.834218] WARNING: CPU: 8 PID: 1812 at kernel/dma/debug.c:1028 check_u=
nmap+0x1cc/0x930
[  150.834225] Modules linked in: amdgpu(OE) amdxcp drm_exec(OE) gpu_sched =
drm_buddy(OE) drm_ttm_helper(OE) ttm(OE) drm_suballoc_helper(OE) drm_displa=
y_helper(OE) drm_kms_helper(OE) i2c_algo_bit rpcsec_gss_krb5 auth_rpcgss nf=
sv4 nfs lockd grace netfs xt_conntrack xt_MASQUERADE nf_conntrack_netlink x=
frm_user xfrm_algo iptable_nat xt_addrtype iptable_filter br_netfilter nvme=
_fabrics overlay nfnetlink_cttimeout nfnetlink openvswitch nsh nf_conncount=
 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bridge stp llc=
 sch_fq_codel intel_rapl_msr amd_atl intel_rapl_common snd_hda_codec_realte=
k snd_hda_codec_generic snd_hda_scodec_component snd_hda_codec_hdmi snd_hda=
_intel snd_intel_dspcfg edac_mce_amd snd_pci_acp6x snd_hda_codec snd_acp_co=
nfig snd_hda_core snd_hwdep snd_soc_acpi kvm_amd sunrpc snd_pcm kvm binfmt_=
misc snd_seq_midi crct10dif_pclmul snd_seq_midi_event ghash_clmulni_intel s=
ha512_ssse3 snd_rawmidi nls_iso8859_1 sha256_ssse3 sha1_ssse3 snd_seq aesni=
_intel snd_seq_device crypto_simd snd_timer cryptd input_leds
[  150.834310]  wmi_bmof serio_raw k10temp rapl snd sp5100_tco ipmi_devintf=
 soundcore ccp ipmi_msghandler cm32181 industrialio mac_hid msr parport_pc =
ppdev lp parport efi_pstore drm(OE) ip_tables x_tables pci_stub crc32_pclmu=
l nvme ahci libahci i2c_piix4 r8169 nvme_core i2c_designware_pci realtek i2=
c_ccgx_ucsi video wmi hid_generic cdc_ether usbnet usbhid hid r8152 mii
[  150.834354] CPU: 8 PID: 1812 Comm: rocrtst64 Tainted: G           OE    =
  6.10.0-custom #492
[  150.834358] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS RMJ1009A 06=
/13/2021
[  150.834360] RIP: 0010:check_unmap+0x1cc/0x930
[  150.834363] Code: c0 4c 89 4d c8 e8 34 bf 86 00 4c 8b 4d c8 4c 8b 45 c0 =
48 8b 4d b8 48 89 c6 41 57 4c 89 ea 48 c7 c7 80 49 b4 84 e8 b4 81 f3 ff <0f=
> 0b 48 c7 c7 04 83 ac 84 e8 76 ba fc ff 41 8b 76 4c 49 8d 7e 50
[  150.834365] RSP: 0018:ffffaac5023739e0 EFLAGS: 00010086
[  150.834368] RAX: 0000000000000000 RBX: ffffffff8566a2e0 RCX: 00000000000=
00027
[  150.834370] RDX: ffff8f6a8f621688 RSI: 0000000000000001 RDI: ffff8f6a8f6=
21680
[  150.834372] RBP: ffffaac502373a30 R08: 00000000000000c9 R09: ffffaac5023=
73850
[  150.834373] R10: ffffaac502373848 R11: ffffffff84f46328 R12: ffffaac5023=
73a40
[  150.834375] R13: ffff8f6741045330 R14: ffff8f6741a77700 R15: ffffffff84a=
c831b
[  150.834377] FS:  00007faf0fc94c00(0000) GS:ffff8f6a8f600000(0000) knlGS:=
0000000000000000
[  150.834379] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  150.834381] CR2: 00007faf0b600020 CR3: 000000010a52e000 CR4: 00000000003=
50ef0
[  150.834383] Call Trace:
[  150.834385]  <TASK>
[  150.834387]  ? show_regs+0x6d/0x80
[  150.834393]  ? __warn+0x8c/0x140
[  150.834397]  ? check_unmap+0x1cc/0x930
[  150.834400]  ? report_bug+0x193/0x1a0
[  150.834406]  ? handle_bug+0x46/0x80
[  150.834410]  ? exc_invalid_op+0x1d/0x80
[  150.834413]  ? asm_exc_invalid_op+0x1f/0x30
[  150.834420]  ? check_unmap+0x1cc/0x930
[  150.834425]  debug_dma_unmap_page+0x86/0x90
[  150.834431]  ? srso_return_thunk+0x5/0x5f
[  150.834435]  ? rmap_walk+0x28/0x50
[  150.834438]  ? srso_return_thunk+0x5/0x5f
[  150.834441]  ? remove_migration_ptes+0x79/0x80
[  150.834445]  ? srso_return_thunk+0x5/0x5f
[  150.834448]  dma_unmap_page_attrs+0xfa/0x1d0
[  150.834453]  svm_range_dma_unmap_dev+0x8a/0xf0 [amdgpu]
[  150.834710]  svm_migrate_ram_to_vram+0x361/0x740 [amdgpu]
[  150.834914]  svm_migrate_to_vram+0xa8/0xe0 [amdgpu]
[  150.835111]  svm_range_set_attr+0xff2/0x1450 [amdgpu]
[  150.835311]  svm_ioctl+0x4a/0x50 [amdgpu]
[  150.835510]  kfd_ioctl_svm+0x54/0x90 [amdgpu]
[  150.835701]  kfd_ioctl+0x3c2/0x530 [amdgpu]
[  150.835888]  ? __pfx_kfd_ioctl_svm+0x10/0x10 [amdgpu]
[  150.836075]  ? srso_return_thunk+0x5/0x5f
[  150.836080]  ? tomoyo_file_ioctl+0x20/0x30
[  150.836086]  __x64_sys_ioctl+0x9c/0xd0
[  150.836091]  x64_sys_call+0x1219/0x20d0
[  150.836095]  do_syscall_64+0x51/0x120
[  150.836098]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  150.836102] RIP: 0033:0x7faf0f11a94f
[  150.836105] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41=
> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[  150.836107] RSP: 002b:00007ffeced26bc0 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[  150.836110] RAX: ffffffffffffffda RBX: 000055c683528fb0 RCX: 00007faf0f1=
1a94f
[  150.836112] RDX: 00007ffeced26c60 RSI: 00000000c0484b20 RDI: 00000000000=
00003
[  150.836114] RBP: 00007ffeced26c50 R08: 0000000000000000 R09: 00000000000=
00001
[  150.836115] R10: 0000000000000032 R11: 0000000000000246 R12: 000055c6835=
28bd0
[  150.836117] R13: 0000000000000000 R14: 0000000000000021 R15: 00000000000=
00000
[  150.836122]  </TASK>
[  150.836124] ---[ end trace 0000000000000000 ]---

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c
index eacfeb32f35d..4b275937d05e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -306,7 +306,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct =
svm_range *prange,
 		spage =3D migrate_pfn_to_page(migrate->src[i]);
 		if (spage && !is_zone_device_page(spage)) {
 			src[i] =3D dma_map_page(dev, spage, 0, PAGE_SIZE,
-					      DMA_TO_DEVICE);
+					      DMA_BIDIRECTIONAL);
 			r =3D dma_mapping_error(dev, src[i]);
 			if (r) {
 				dev_err(dev, "%s: fail %d dma_map_page\n",
@@ -629,7 +629,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, str=
uct svm_range *prange,
 			goto out_oom;
 		}
=20
-		dst[i] =3D dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
+		dst[i] =3D dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
 		r =3D dma_mapping_error(dev, dst[i]);
 		if (r) {
 			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
--=20
2.34.1

