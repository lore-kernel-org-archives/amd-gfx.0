Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D74FD111B0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 07:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5A310E085;
	Mon,  4 Nov 2024 07:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CubzZ2/t";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4656E10E085
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 07:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXR3VWmby/khChsgaQ+ckqwFPDIaCc9ws0Y2ssrIbkql5/hXqeJuMF3AOMdArd2LxEoxBqpcTrP4z2xFyYz9bBf9yOu84lt/yepwg1nejXfdq9cJUjvZBT7CxcYvDJ67GBIFIIZX1Z5lAGrxqvSwCjEfzF+dI9r3l+Z0o304I3SYlEKqQigjiCUNTqBJncYyRM6g7Ymq2lih7CVQPHk64u+HYJrZRhQ/d9X2czSW9ChQamExJp+iEt9usMCDfEdZ6+Y6oteKEmkWS1RC6bTC4SMrxl1Kt7lpPjvRE3QJn8VPB3SVrb4qrPJpCilp8nkPTZPIdaV9nUKJGvrtIsEOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txUd1UpmYUwR9umI7dqiGE3pHC7J35uk5kA1pjB7gI4=;
 b=RPk6/iaPWBcBGNPFiW/xY0LRiltaJ34SC4x8TB9Gdz8HHZjoyiUnTeslNxXYmnH+c/vurzCAy7L1kq8/Xa/HxZbz96MQ8Dlu5kjJChPn0yCM0FUueDTe4kXRrCewYoOAoWdVojP5QVIzh1RoeBpUk1oN3WsCi5MtIH1H5/60GxvMsyDamytpSWHlAlf9UCujnv6q4b2K+05FxpsllXNKg6ZBF7pCPMNARBY2kmC2mEm/48OZ+FBJBF3NN9EvIQTGZydfwBWA+L7aTliNNk3esc/CMlDDmes4iIVPS928Q4f+dMW2eT2/NjJZHkT0V2cuuixoDY/C+7jyP8L14E9KJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txUd1UpmYUwR9umI7dqiGE3pHC7J35uk5kA1pjB7gI4=;
 b=CubzZ2/t0XJxq83iY6nT6CWtN0qcvLQ8u4s2MpXSTMgBNVEUJqBN8wN0gpUroGzLEIoTolHTJjC0oBXTqkbeMOkHTo545JKwgjs1BJH1PcJbQe5PP2QkgghZg8SrXJeLVV/BkfIn0iyklo5136o9srD/E1n21aS3Ca6yD5YwA+g=
Received: from CH2PR17CA0027.namprd17.prod.outlook.com (2603:10b6:610:53::37)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 07:06:40 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::d6) by CH2PR17CA0027.outlook.office365.com
 (2603:10b6:610:53::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29 via Frontend
 Transport; Mon, 4 Nov 2024 07:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 07:06:40 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 01:06:38 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2] drm/amdgpu: set the right AMDGPU sg segment limitation
Date: Mon, 4 Nov 2024 15:06:29 +0800
Message-ID: <20241104070629.167841-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: a16d9bab-3055-4261-a400-08dcfc9f3b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rDgg4CXmLuSR6igS4dMnxTXobXQ4aCaGAv593JDYnRdlOINDw8XdiK9UH1eo?=
 =?us-ascii?Q?O9+XrlsapRBU3abyXYY2cHirfTqBUTRjXBYN0MosvJoPfoD6q6lgn3vbvlTM?=
 =?us-ascii?Q?uF6t3WzLeIEntCaZEB0yMJ5E8OTan41FHpda0SxmkCOelsfEEiF6jMbkqqMk?=
 =?us-ascii?Q?W1NMM6W2AEazhmu95w4m8StwZ8ljRXkf6LAjF1argSVL+U8uhWT5BDoZWGSP?=
 =?us-ascii?Q?BChUUJrLGHLeIpKjxvRiw/tJtZBqjv/FM0cko8N7G+Az27IEi2ZEQwbx7VQH?=
 =?us-ascii?Q?gPkNygqUGZcjiIxS8tQuJ+Oo7riAwIqBvGkBsHmMUUhx6KSWhN6OlEEQHT1S?=
 =?us-ascii?Q?YKDQavr037CCP5j261tL04PH7GygBYK1ZAZpM/MBpSm4ZAbfeEwRRznsKT5e?=
 =?us-ascii?Q?+1/Hr/HVD8eIjQ5PIVmeqFmtCrYgASiuRIPjalHPhHFxp7lzkKNiU30cLP/q?=
 =?us-ascii?Q?Zj0sx8uN+hLJHp5QNywP/OBHSDTRnrv0L0bKKVE9kJAT0pVPxNzBpCWMOrsU?=
 =?us-ascii?Q?x+d+lRG65IrZTH9z8BmA4Z2BnhfhsViHySSo7kyalj01kPIsRziEdjfQMwbq?=
 =?us-ascii?Q?2BM2Ox+GkOrKWurSllF3f4NwjW+Vkr0M792HqZkIouj80otrmMRWgwGPaubo?=
 =?us-ascii?Q?qQrNhbmE4LOqs59TKyQPaOMff8L0OpaBOKTdJiRiksQC9fbCBqKCtie9AdrD?=
 =?us-ascii?Q?F95axTFt9n3R1469I6uHMoUleuMqy6SKZa+edmqAao2qKdM0yqPl1uON8Imv?=
 =?us-ascii?Q?UYQe0jaLyPXooTZQbLTDsdUjTcJ/gQJWGPB8WCGbrDbhXujzHhzCQnK/UBAr?=
 =?us-ascii?Q?5H5Y2OK8Rqpz/JT+11o0/BkkdIRZb9arI1EYRdklJTl8lrB8lI6FfEMiW5YN?=
 =?us-ascii?Q?kv/hvVhVuuiahIBlY/cSLCQ12N4dPOaHe1CYw91txOW2UzWuWMhqUySxpW3Y?=
 =?us-ascii?Q?uD2hLwJcidA9Vt1msScNFo5k63bme4dQJFq7eX5HjA9Hnrh03zko63BK+qxf?=
 =?us-ascii?Q?7Xjz/MgcST8NAuVQqltHgtuHDQZUCFZipaUHewKQpTUWzsu7ePm+UYy9IQ/C?=
 =?us-ascii?Q?famkZV6t2Ex6ObX37c1frPYhuWGt/B5XHnvl9Q9QziSLj6QWk2E1upnhA8Z1?=
 =?us-ascii?Q?eq4edMSCIS/+Y7/fJX5P+L7zFma2SpF9gyvSMp7bZh6jKGpdLmKaTvGdUi/x?=
 =?us-ascii?Q?/dxCfLOq2Z9VPA0U3sd7vsGl12SAe7FG+aKrIgmgXTfbXQagsuyvOaW81xRz?=
 =?us-ascii?Q?lC/vbFTTOpXwiiymBiTHrm+Pd/KRGFGPJvLWbixZn701r1fjsYPknWnq4KQf?=
 =?us-ascii?Q?O5q6fdPYkxl5M+wxTzMH8mlzOZ8XExvN8WGzVmyiJ6pjAU3Oiz2FPtfmRBmO?=
 =?us-ascii?Q?FrHGtZsL1zAJw8Ne0hLja6mT01+BZrC4q1tNEMYdov/3tMpANQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 07:06:40.5084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16d9bab-3055-4261-a400-08dcfc9f3b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208
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

The driver needs to set the correct max_segment_size;
otherwise debug_dma_map_sg() will complain about the
over-mapping of the AMDGPU sg length as following:

WARNING: CPU: 6 PID: 1964 at kernel/dma/debug.c:1178 debug_dma_map_sg+0x2dc=
/0x370
[  364.049444] Modules linked in: veth amdgpu(OE) amdxcp drm_exec gpu_sched=
 drm_buddy drm_ttm_helper ttm(OE) drm_suballoc_helper drm_display_helper dr=
m_kms_helper i2c_algo_bit rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace=
 netfs xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo =
iptable_nat xt_addrtype iptable_filter br_netfilter nvme_fabrics overlay nf=
netlink_cttimeout nfnetlink openvswitch nsh nf_conncount nf_nat nf_conntrac=
k nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bridge stp llc amd_atl intel_rapl=
_msr intel_rapl_common sunrpc sch_fq_codel snd_hda_codec_realtek snd_hda_co=
dec_generic snd_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel snd_i=
ntel_dspcfg edac_mce_amd binfmt_misc snd_hda_codec snd_pci_acp6x snd_hda_co=
re snd_acp_config snd_hwdep snd_soc_acpi kvm_amd snd_pcm kvm snd_seq_midi s=
nd_seq_midi_event crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 snd_raw=
midi sha256_ssse3 sha1_ssse3 aesni_intel snd_seq nls_iso8859_1 crypto_simd =
snd_seq_device cryptd snd_timer rapl input_leds snd
[  364.049532]  ipmi_devintf wmi_bmof ccp serio_raw k10temp sp5100_tco soun=
dcore ipmi_msghandler cm32181 industrialio mac_hid msr parport_pc ppdev lp =
parport drm efi_pstore ip_tables x_tables pci_stub crc32_pclmul nvme ahci l=
ibahci i2c_piix4 r8169 nvme_core i2c_designware_pci realtek i2c_ccgx_ucsi v=
ideo wmi hid_generic cdc_ether usbnet usbhid hid r8152 mii
[  364.049576] CPU: 6 PID: 1964 Comm: rocminfo Tainted: G           OE     =
 6.10.0-custom #492
[  364.049579] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS RMJ1009A 06=
/13/2021
[  364.049582] RIP: 0010:debug_dma_map_sg+0x2dc/0x370
[  364.049585] Code: 89 4d b8 e8 36 b1 86 00 8b 4d b8 48 8b 55 b0 44 8b 45 =
a8 4c 8b 4d a0 48 89 c6 48 c7 c7 00 4b 74 bc 4c 89 4d b8 e8 b4 73 f3 ff <0f=
> 0b 4c 8b 4d b8 8b 15 c8 2c b8 01 85 d2 0f 85 ee fd ff ff 8b 05
[  364.049588] RSP: 0018:ffff9ca600b57ac0 EFLAGS: 00010286
[  364.049590] RAX: 0000000000000000 RBX: ffff88b7c132b0c8 RCX: 00000000000=
00027
[  364.049592] RDX: ffff88bb0f521688 RSI: 0000000000000001 RDI: ffff88bb0f5=
21680
[  364.049594] RBP: ffff9ca600b57b20 R08: 000000000000006f R09: ffff9ca600b=
57930
[  364.049596] R10: ffff9ca600b57928 R11: ffffffffbcb46328 R12: 00000000000=
00000
[  364.049597] R13: 0000000000000001 R14: ffff88b7c19c0700 R15: ffff88b7c90=
59800
[  364.049599] FS:  00007fb2d3516e80(0000) GS:ffff88bb0f500000(0000) knlGS:=
0000000000000000
[  364.049601] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  364.049603] CR2: 000055610bd03598 CR3: 00000001049f6000 CR4: 00000000003=
50ef0
[  364.049605] Call Trace:
[  364.049607]  <TASK>
[  364.049609]  ? show_regs+0x6d/0x80
[  364.049614]  ? __warn+0x8c/0x140
[  364.049618]  ? debug_dma_map_sg+0x2dc/0x370
[  364.049621]  ? report_bug+0x193/0x1a0
[  364.049627]  ? handle_bug+0x46/0x80
[  364.049631]  ? exc_invalid_op+0x1d/0x80
[  364.049635]  ? asm_exc_invalid_op+0x1f/0x30
[  364.049642]  ? debug_dma_map_sg+0x2dc/0x370
[  364.049647]  __dma_map_sg_attrs+0x90/0xe0
[  364.049651]  dma_map_sgtable+0x25/0x40
[  364.049654]  amdgpu_bo_move+0x59a/0x850 [amdgpu]
[  364.049935]  ? srso_return_thunk+0x5/0x5f
[  364.049939]  ? amdgpu_ttm_tt_populate+0x5d/0xc0 [amdgpu]
[  364.050095]  ttm_bo_handle_move_mem+0xc3/0x180 [ttm]
[  364.050103]  ttm_bo_validate+0xc1/0x160 [ttm]
[  364.050108]  ? amdgpu_ttm_tt_get_user_pages+0xe5/0x1b0 [amdgpu]
[  364.050263]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0xa12/0xc90 [amdgpu]
[  364.050473]  kfd_ioctl_alloc_memory_of_gpu+0x16b/0x3b0 [amdgpu]
[  364.050680]  kfd_ioctl+0x3c2/0x530 [amdgpu]
[  364.050866]  ? __pfx_kfd_ioctl_alloc_memory_of_gpu+0x10/0x10 [amdgpu]
[  364.051054]  ? srso_return_thunk+0x5/0x5f
[  364.051057]  ? tomoyo_file_ioctl+0x20/0x30
[  364.051063]  __x64_sys_ioctl+0x9c/0xd0
[  364.051068]  x64_sys_call+0x1219/0x20d0
[  364.051073]  do_syscall_64+0x51/0x120
[  364.051077]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  364.051081] RIP: 0033:0x7fb2d2f1a94f

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 0637414fc70e..9f922ec50ea2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1851,6 +1851,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
=20
 	mutex_init(&adev->mman.gtt_window_lock);
=20
+	dma_set_max_seg_size(adev->dev, UINT_MAX);
 	/* No others user of address space so set it to 0 */
 	r =3D ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->dev,
 			       adev_to_drm(adev)->anon_inode->i_mapping,
--=20
2.34.1

