Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A61E68949
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 03:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DC810E14B;
	Thu, 31 Oct 2024 03:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wuQAGR01";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418E810E14B
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 03:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ5mKiDnn1BlDTJZxJyOlEyUy51bRWXowdqMcTbXaW99Lep2tbvKzwkhQvqNsyh90RqUP7nCs01RKlWeDY6cwxPYEEWQVS1ilE5xoedYNsK5G1C4Z1fiFQ5AljHVg+k3HxT+E7gJuRR2WjbnkbqCHH/MqdQq+uPUdTPG2EqnXoRfJWIZPCRbqYRSMhfHiUgVg9jyTAuooqqHduD6Qd9BIxwpHKl7R356QMU62Q58cVL2qNuREAKZNVdWuRtyD1ij/7KrRroa//FXj7E14ag3cYtzKMmDj+srRleSOHCn0zEQDAy6D9DR+EtVCvEmSKbhe90zmxrcD/Qq7rTB4x9Q5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Os1JR8XvpnN1m5E2cWeGhvEUbnOkZwpkgCAcY4Gybl8=;
 b=fUkrd1SG9KupXR3PjEgTPNfZP7LOpfQNpe3KYU1yYtdOjwgwLXBEWuARRrBGk2U5vuNVGJUFGeyrWyTfhHo+RcJ+3cmImCyTX44CF73fW9HyCMmrza649rFdTY7yvfKGf0HvSu0OEHt+d+gLyZ7vs4DmWclo4s+QlT11CLNGwR/oXHOdehSdvjfm82Doha2FSMFJ7A9T0A8o/VUbME4c9zTc/4BlT58aOe8uFBjOb8FJFRhcqQ/uURwhTT5tOcDn8rRoDvLNTOkdGAdi4472eE6UfLZpVsBUnOKaFkVwjdT7EQIAdR/q6OMKaH+hM2QtjuTPaTVK6Cn2rhuJM7Utbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os1JR8XvpnN1m5E2cWeGhvEUbnOkZwpkgCAcY4Gybl8=;
 b=wuQAGR01lS8IK2WdpwTdkr+GeRs5g+OX6yZZ55F/56HigpRhv60WXVfxy3oOpIrYi4jIRQonbwrSC0yMHEZ4mtPB/5ERAvFbFLC27To0/5M+T3ppWZksxcQmprsG8xeEczaFA/WMRAUuD53KkaJRfmKhHkmIHEmLlOpQ6xWLhrU=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 03:30:30 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::1e) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 03:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 03:30:29 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 22:29:59 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: set the right sg limitation
Date: Thu, 31 Oct 2024 11:29:36 +0800
Message-ID: <20241031032936.118005-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afd7af8-21f8-49eb-6c1d-08dcf95c5e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X/tnL5cHqXPPq/Df2ZVN29Msep0GbycO6OiXUWsp743ddI3PY6MJBhGWO0zj?=
 =?us-ascii?Q?hfdPqGER1IX/VbDClxk4/EYUbAoSO5bDWjCxf8byxGcA6ykZpJojKjOeqip8?=
 =?us-ascii?Q?GDBrAXB0Es5BsNSD5diVHV/Q5Fd9vek4pmXwy5DWzrZ9+E6/UDPbL0Zk7+er?=
 =?us-ascii?Q?Knr+0du3vnF1H14JTaEEcWdMeEZzzWLG6n1rEQJVJNrHG6qzWSj1neWUvdWu?=
 =?us-ascii?Q?pcb7sskMRELovFvEdYEOKW/Tn+NPCes9fPhyfeoNhozntrfcDwYyoddJXEnd?=
 =?us-ascii?Q?/NxkuKRziTo3PRsjQt7Mh0N4/+RoLkQlNIFAVmZziFYxwtXbWHpdLqx5RScZ?=
 =?us-ascii?Q?M99PoyoC8rLw4sTAPd2V2wBU9Qvczb2hFfWByJe3Zjui1XoaI43CWoCIAet5?=
 =?us-ascii?Q?xi8oMOlUZCA++52aZIa+wvQC25jLm5jukfz4k18khE0hebPiRm2ABv6GRK0v?=
 =?us-ascii?Q?yOpZfWo1U1P4M8ZgaSldVu+pxT2dtOgZuHLmg7URbsrHyKgq4JA4rKjpdqnl?=
 =?us-ascii?Q?QZWTgeVZVD3BV0nXOqfeR/0MScrBwGPyBzUFvcpua3T5sLli6ay0Wfyy7j4k?=
 =?us-ascii?Q?AVgPY99pFSwClnXEf0UK+Y3b8lT/1uZlXJvOwe9+xRXgY1j6x5q9pMkhjgOy?=
 =?us-ascii?Q?MimKA7jqslmwpoYIPxIc/EWUs0uchmnwlWdspVRy3GoNpavBRACWtrZ1LQbh?=
 =?us-ascii?Q?0vRUxjkuQIoIBO89PMBaom/UdC/rnp1ARPcXYQyQ7qxNvVscvgJt+baGISDb?=
 =?us-ascii?Q?wkq3cJX83LFNmNDcsqxpNUwNGGSyDNxN92vnnFV1xv61HKy6uYmGsPrfzUNV?=
 =?us-ascii?Q?oC1tbAGU4jViHOLF+B3ansVZVuBBVXtiDCdYOBZhMcq0W2PcoxTC/T0qx4V3?=
 =?us-ascii?Q?Qg1UIpH7bPLf2jzxTSz/8BYKVNwmC/t7PP097mi9IUAUbwJjV4rpOdNqR40+?=
 =?us-ascii?Q?rYJsTkt22cL+oV4jI/Bub+nMxMpIYzfqbAMJ+IIqzH7RHQvZEkMikZP584lc?=
 =?us-ascii?Q?2cT/9bhotqs39Slfv3AeFkI9R609yXn/OB8jWwTv+TxYQ7JD82clYW2VqVS3?=
 =?us-ascii?Q?oNq7v7VWwknxfvuZ7x0YgXgW/f/QObYNyXZjt7KrkpmS1wGlgw++3l+JSnD6?=
 =?us-ascii?Q?ToyeGRLpJFzRN6MLrmPrd2Bbe5horiFIxduifviUTcOWTZ+AZGK8UcAGmcVD?=
 =?us-ascii?Q?HNUZmwIiEszCg5D2ichG+KlpMAUFB4GKio0q9pfYyhOb3em2zi2Cz9U0aTc+?=
 =?us-ascii?Q?mI7pNuiD50TV0vIYT+N08L1iE3Hh8vnL4igg+6oOBsbHtJnMcj5s/d+3vsa3?=
 =?us-ascii?Q?U0x5R9sZPiuYe3J7rwDuUivK8LBqfTxNIebNHkRcLKawB6sMHXNXXdY4qdnl?=
 =?us-ascii?Q?Z8lgHA+u/4CDdS3BoXFR2QMSFJ+poPaKlIvcUAsJt7b1hLy4Gg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 03:30:29.5004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afd7af8-21f8-49eb-6c1d-08dcf95c5e71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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
over-mapping of the AMDGPU sg segment as following:

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
index 0637414fc70e..78e6e72143e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1851,6 +1851,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
=20
 	mutex_init(&adev->mman.gtt_window_lock);
=20
+	dma_set_max_seg_size(adev->dev, dma_max_mapping_size(adev->dev) ?: UINT_M=
AX);
 	/* No others user of address space so set it to 0 */
 	r =3D ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->dev,
 			       adev_to_drm(adev)->anon_inode->i_mapping,
--=20
2.34.1

