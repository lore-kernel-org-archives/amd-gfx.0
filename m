Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F757C3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 04:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A1D10E28E;
	Mon, 12 May 2025 04:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G54F2zXr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073D410E28E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 04:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7KXolbLHjfQloGaDftNd4jX/3us8yN1zRzP+XaJojQVaWbwZFSWy2vU/0EW3V1vlA0qeop0voez8U0uefCGEHg1XcM5eJKxcjky6FS6eqar7LJ4gagpdAsmezX4FRXFtTS3c0cm3kYn6RHQ+cZUXHktY3gjdGukXx9uBqfr0/re6NZMTXoVDzM2ehF1A4Rm0nDXNmjLbWPRxqIgQdOViqqiDYDaSHAzZBsDlBf8XEGR3m3uLv4j2vSJ+CBu/oaPrCDcgB/Y+K38w+QJIiWpIp09rWv0pqKvkHqAcM5HRrcYkeFTIrO+SqL44KVXnmNFabmrNPQInZHzjaqzP5TADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7X0CdrTykY4N9j/d7XlMs2RdYcQyPEumiTQv8JS7cI=;
 b=EcBv2Av91IWEy9UZ6vJBYdzz4AgoKfjcTuG0R3L81Tl5j0Bg67LhEZ/h20eV2wXuUgPY6Uek1O5y8LWAyQfKTI/cmdnngxNCHXEwLUvMSav3PahzrV5B2p6iFuByXKVHFIFMI32Cj/ZK5G+5z4+UtfB1znnWY2s5iyK1egnJ7B5lkBcUmC40ir2l1ldIrSuC7ZxI1PZj24hombn2FbQ1AWeogy6lr5phYZnHWU6A4TZh/5gcS+GIuoJ5IaiheL6fma/Bawjd/Zy3o1xSt0b53eLYrD3InRRYlSxEujQrnGJ5mtaohNhVmmiTSgwsIiUyVxzBT8l/Che4jyR2NTTHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7X0CdrTykY4N9j/d7XlMs2RdYcQyPEumiTQv8JS7cI=;
 b=G54F2zXr7CmVJWxe1JGimEwK7dGbKawjq9wTvZ06Z0n2J4TDBLxH45dZTH6dPgZLWBiKLV2BcFZpRQhdrpaMyJr7TgK5WX+9JbJeQgcoE1Po0F5PIb77vxhBgEvGF8vz1cU+71SGKVaTO0oq+c3JeNDciF6nqs6ertfd5L9Nx+c=
Received: from BL1P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::23)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Mon, 12 May
 2025 04:31:48 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::10) by BL1P223CA0018.outlook.office365.com
 (2603:10b6:208:2c4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 12 May 2025 04:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 04:31:47 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 23:31:46 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records exceed
 threshold
Date: Mon, 12 May 2025 12:31:36 +0800
Message-ID: <20250512043136.4969-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 703e0f54-8e4e-426d-bcf0-08dd910de89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KykMdqyOF3j70SdN9/VR0woEF4dUIo2NXd+IoCD4QEgjIQq1yJ4OYhIMM/W2?=
 =?us-ascii?Q?PvUDp91BzS8o8aHJYiWmL8tD8Z94hFeuZUEwPUveHYtLuC2/eWfnp9yKlOjm?=
 =?us-ascii?Q?N5SWKdPLadGqKvWIa3Bq9Ev7C2mpgHVeRmVIIzwMuzbjlYxitWQZBvpoVLOD?=
 =?us-ascii?Q?CdERU/XEj2MBLfJgiTTvmirlTJK/id0Nf17jCbr6y2TKGUIukIvQ5Jcc7igt?=
 =?us-ascii?Q?RfyFz5JPnPzTFcxqLy+pfzpUuFbuOt79Aj6uM8JeViiw1/y8Leef6e98ucJu?=
 =?us-ascii?Q?XzI6sd3HgxyEcNSTLc1so/rWfkWLHJAwhwoV6Ss9jlqRATp61UbdsjFxJ/Hx?=
 =?us-ascii?Q?aTd9xmjVBYcOes/LXZ1InQQYG/KCo/ACH36sPF4E/ayXtbO4Xrb31Uy/kz4O?=
 =?us-ascii?Q?EMlwd7EuBhZRxW/xFiFBqICShpFAip/ehhpz3uTPb5ikaExKsIARkVTvG6xq?=
 =?us-ascii?Q?k6hDwtvcn6ng/LvwPaeyq7VmkQzG/IFYFcYfmzQvhcnEgq9Kosdj1GtZQrsR?=
 =?us-ascii?Q?vVEK/V2TtWQUPTUVSkxeJcnawviUBCWmGdSsk3U5Ggir2vul+l6x2143aCK8?=
 =?us-ascii?Q?d6Q882RjEbNvh19YaJrClQR8Sc0w67i0yJN8e08+xtdYxZ6N97Jp+mdj9Fqs?=
 =?us-ascii?Q?aypV6Jeg5gJyFcYWE6QFAzTHduWzPnx1yKAWziEVF0xIA9rwMSdiZNYW2xLP?=
 =?us-ascii?Q?I3deeQhWpcJtLToaXK6UfA+0eFoIrZ8sgY7d3NwkC7TWOGHtutaE2M4ZAf8a?=
 =?us-ascii?Q?bX68MbHWIwYJHjqreK6KVlaR+Fx+O7chOyKXxLz/V++yOVVKBRGHaeQFA2z1?=
 =?us-ascii?Q?Tl0Gz+ro+xHfEi9S1J2DKBM94Ga+i8M6/GyhF3d56aS9d1kt5sDGUJpyerC6?=
 =?us-ascii?Q?Q3i1cqIQ+Af1/y2dkeDg4wtdlYpz5HF4qXdn4zoLM8GFdv/F0rk73Ye6Tn7+?=
 =?us-ascii?Q?19boyrGq3D4tOIfUcuj40h3r0yFHFdQ05T9ySPUDm19mn9jBnL6TLpFhqxAX?=
 =?us-ascii?Q?y4aV12VCJdPuXIpEP6xJSBeIz0qqu5y1S6C+pMNP+fF2H+OTVQOr87NbImY3?=
 =?us-ascii?Q?f7HsqpSdIPRN8ddXwsl6U9Gz1N0kKYaNj5iJBy5hb/J1s3NuOu+ujkWOYHVZ?=
 =?us-ascii?Q?6iv67yZ7UmLUWxMKAG7dBiP9prQSTW/8CjSRU1bE/1ypV/w5jGT/VGxz4K8x?=
 =?us-ascii?Q?BIP7tCizwDHaj/1ssXkJf170mAbhz92YsojAmo9JlikPc4Y1Sh/QGdH3GnsV?=
 =?us-ascii?Q?W4pDpL7SvP6QJpAKmKfaszO+BLLGmKJ7nJl5CbI3AuDuSt+Mu002sI97yY2z?=
 =?us-ascii?Q?k1XL5/+gMRA9epsIOSNcYgx9GmHJPVJuGg3215Sf+wlf8IXvk6GnGxvqI3am?=
 =?us-ascii?Q?4m4Ka9fyLfakCDxqcKQxUnSgL4hg7OY7ZDFIlHaAaLL14xALl0onswCtCkOA?=
 =?us-ascii?Q?BbQXn0Ax1p8Awi/DUfSuOs8Viv3FQ6PFAsy7KK0/LinVkeCfvKYaH/7OsSVI?=
 =?us-ascii?Q?5yVWHx5wueZcf3NI1SaavU2+6mA0LSf9bj7Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 04:31:47.9376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703e0f54-8e4e-426d-bcf0-08dd910de89e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
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

kernel panic caused by RAS records exceeding the threshold when load driver
specifying RMA(bad_page_threshold=3D128)
1.Fix the warnings caused by disabling the interrupt source before it was e=
nabled
2.xcp sysfs is not initialized,null pointer appears during fini
3.Fix the memory leak caused by the device's early exit due to rma

The first reason:
[ 2744.246650] ------------[ cut here ]------------
[ 2744.246651] WARNING: CPU: 0 PID: 289 at /tmp/amd.BkfTLqYV/amd/amdgpu/amd=
gpu_irq.c:635 amdgpu_irq_put.cold+0x42/0x6e [amdgpu]
[ 2744.247108] Modules linked in: amdgpu(OE+) amddrm_ttm_helper(OE) amdttm(=
OE) amdxcp(OE) amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) xt=
_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter xt_addrt=
ype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc overlay binf=
mt_misc intel_rapl_msr intel_rapl_common i10nm_edac nfit x86_pkg_temp_therm=
al intel_powerclamp coretemp ipmi_ssif kvm_intel nls_iso8859_1 kvm rapl iss=
t_if_mbox_pci isst_if_mmio pmt_telemetry pmt_crashlog isst_if_common pmt_cl=
ass mei_me mei acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_me=
ter acpi_pad mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scs=
i_dh_alua msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tab=
les x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 asy=
nc_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc=
32c raid1 raid0 multipath
[ 2744.247167]  linear mlx5_ib ib_uverbs ib_core ast i2c_algo_bit drm_vram_=
helper drm_ttm_helper ttm drm_kms_helper crct10dif_pclmul syscopyarea crc32=
_pclmul ghash_clmulni_intel mlx5_core sysfillrect sysimgblt aesni_intel mlx=
fw fb_sys_fops psample cec crypto_simd cryptd rc_core i2c_i801 nvme xhci_pc=
i tls intel_pmt drm pci_hyperv_intf nvme_core i2c_smbus i2c_ismt xhci_pci_r=
enesas wmi pinctrl_emmitsburg
[ 2744.247194] CPU: 0 PID: 289 Comm: kworker/0:1 Tainted: G           OE   =
  5.15.0-70-generic #77-Ubuntu
[ 2744.247197] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C23.A=
G.2 11/21/2024
[ 2744.247198] Workqueue: events work_for_cpu_fn
[ 2744.247206] RIP: 0010:amdgpu_irq_put.cold+0x42/0x6e [amdgpu]
[ 2744.247634] Code: 79 7f ff 44 89 ee 48 c7 c7 4d 5a 42 c2 89 55 d4 e8 90 =
09 bc bf 8b 55 d4 4c 89 e6 4c 89 ff e8 3c 76 7f ff 8b 55 d4 84 c0 75 07 <0f=
> 0b e9 95 79 7f ff 49 03 5c 24 08 f0 ff 0b 75 13 4c 89 e6 4c 89
[ 2744.247636] RSP: 0018:ffa0000019e27cb0 EFLAGS: 00010246
[ 2744.247639] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ff11000150f=
a87c0
[ 2744.247641] RDX: 0000000000000000 RSI: ffffffffc2222430 RDI: ff1100019f2=
00000
[ 2744.247642] RBP: ffa0000019e27ce0 R08: 0000000000000003 R09: ffffffffffe=
41a08
[ 2744.247643] R10: 0000000000ffff0a R11: 0000000000000001 R12: ff1100019f2=
2ce60
[ 2744.247644] R13: 0000000000000000 R14: 00000000ffffffea R15: ff1100019f2=
00000
[ 2744.247645] FS:  0000000000000000(0000) GS:ff11007e7e400000(0000) knlGS:=
0000000000000000
[ 2744.247647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2744.247649] CR2: 00007f3d2002819c CR3: 0000000006810003 CR4: 00000000007=
71ef0
[ 2744.247650] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2744.247651] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[ 2744.247652] PKRU: 55555554
[ 2744.247653] Call Trace:
[ 2744.247654]  <TASK>
[ 2744.247656]  sdma_v4_4_2_hw_fini+0x7a/0xc0 [amdgpu]
[ 2744.247997]  ? vcn_v4_0_3_hw_fini+0x5f/0xa0 [amdgpu]
[ 2744.248336]  amdgpu_ip_block_hw_fini+0x31/0x61 [amdgpu]
[ 2744.248776]  amdgpu_device_fini_hw+0x3bb/0x47b [amdgpu]
[ 2744.249197]  ? blocking_notifier_chain_unregister+0x56/0xb0
[ 2744.249202]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu]
[ 2744.249482]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
[ 2744.249913]  amdgpu_pci_probe+0x23e/0x590 [amdgpu]
[ 2744.250187]  local_pci_probe+0x48/0x90
[ 2744.250191]  work_for_cpu_fn+0x17/0x30
[ 2744.250196]  process_one_work+0x228/0x3d0
[ 2744.250198]  worker_thread+0x223/0x420
[ 2744.250200]  ? process_one_work+0x3d0/0x3d0
[ 2744.250201]  kthread+0x127/0x150
[ 2744.250204]  ? set_kthread_struct+0x50/0x50
[ 2744.250207]  ret_from_fork+0x1f/0x30
[ 2744.250212]  </TASK>
[ 2744.250213] ---[ end trace 488c997a88508bc3 ]---

The second reason:
[ 5139.303446] Memory manager not clean during takedown.
[ 5139.303509] WARNING: CPU: 145 PID: 117699 at drivers/gpu/drm/drm_mm.c:99=
8 drm_mm_takedown+0x27/0x30 [drm]
[ 5139.303542] Modules linked in: amdgpu(OE+) amddrm_ttm_helper(OE) amdttm(=
OE) amdxcp(OE) amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) xt=
_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter xt_addrt=
ype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc overlay inte=
l_rapl_msr intel_rapl_common i10nm_edac nfit x86_pkg_temp_thermal intel_pow=
erclamp coretemp ipmi_ssif kvm_intel binfmt_misc kvm nls_iso8859_1 rapl iss=
t_if_mbox_pci pmt_telemetry pmt_crashlog isst_if_mmio pmt_class isst_if_com=
mon mei_me mei acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi=
_power_meter mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scs=
i_dh_alua msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tab=
les x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 raid456 asy=
nc_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc=
32c raid1 raid0 multipath
[ 5139.303572]  linear mlx5_ib ib_uverbs ib_core crct10dif_pclmul ast crc32=
_pclmul i2c_algo_bit ghash_clmulni_intel aesni_intel crypto_simd drm_vram_h=
elper cryptd drm_ttm_helper mlx5_core ttm drm_kms_helper syscopyarea sysfil=
lrect sysimgblt fb_sys_fops cec rc_core mlxfw psample intel_pmt nvme xhci_p=
ci drm tls i2c_i801 pci_hyperv_intf nvme_core i2c_smbus i2c_ismt xhci_pci_r=
enesas wmi pinctrl_emmitsburg [last unloaded: amdkcl]
[ 5139.303588] CPU: 145 PID: 117699 Comm: modprobe Tainted: G     U     OE =
    5.15.0-70-generic #77-Ubuntu
[ 5139.303590] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C23.A=
G.2 11/21/2024
[ 5139.303591] RIP: 0010:drm_mm_takedown+0x27/0x30 [drm]
[ 5139.303605] Code: cc 66 90 0f 1f 44 00 00 48 8b 47 38 48 83 c7 38 48 39 =
f8 75 05 c3 cc cc cc cc 55 48 c7 c7 18 d0 10 c0 48 89 e5 e8 5a bc c3 c1 <0f=
> 0b 5d c3 cc cc cc cc 90 0f 1f 44 00 00 55 b9 15 00 00 00 48 89
[ 5139.303607] RSP: 0018:ffa00000325c3940 EFLAGS: 00010286
[ 5139.303608] RAX: 0000000000000000 RBX: ff1100012f5cecb0 RCX: 00000000000=
00027
[ 5139.303609] RDX: ff11007e7fa60588 RSI: 0000000000000001 RDI: ff11007e7fa=
60580
[ 5139.303610] RBP: ffa00000325c3940 R08: 0000000000000003 R09: fffffffff00=
c2b78
[ 5139.303610] R10: 000000000000002b R11: 0000000000000001 R12: ff1100012f5=
cec00
[ 5139.303611] R13: ff1100012138f068 R14: 0000000000000000 R15: ff1100012f5=
cec90
[ 5139.303611] FS:  00007f42ffca0000(0000) GS:ff11007e7fa40000(0000) knlGS:=
0000000000000000
[ 5139.303612] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5139.303613] CR2: 00007f23d945ab68 CR3: 00000001212ce005 CR4: 00000000007=
71ee0
[ 5139.303614] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 5139.303615] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[ 5139.303615] PKRU: 55555554
[ 5139.303616] Call Trace:
[ 5139.303617]  <TASK>
[ 5139.303619]  amdttm_range_man_fini_nocheck+0xfe/0x1c0 [amdttm]
[ 5139.303625]  amdgpu_ttm_fini+0x2ed/0x390 [amdgpu]
[ 5139.303800]  amdgpu_bo_fini+0x27/0xc0 [amdgpu]
[ 5139.303959]  gmc_v9_0_sw_fini+0x63/0x90 [amdgpu]
[ 5139.304144]  amdgpu_device_fini_sw+0x125/0x6a0 [amdgpu]
[ 5139.304302]  amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
[ 5139.304455]  devm_drm_dev_init_release+0x4a/0x80 [drm]
[ 5139.304472]  devm_action_release+0x12/0x20
[ 5139.304476]  release_nodes+0x3d/0xb0
[ 5139.304478]  devres_release_all+0x9b/0xd0
[ 5139.304480]  really_probe+0x11d/0x420
[ 5139.304483]  __driver_probe_device+0x119/0x190
[ 5139.304485]  driver_probe_device+0x23/0xc0
[ 5139.304487]  __driver_attach+0xf7/0x1f0
[ 5139.304489]  ? __device_attach_driver+0x140/0x140
[ 5139.304491]  bus_for_each_dev+0x7c/0xd0
[ 5139.304493]  driver_attach+0x1e/0x30
[ 5139.304494]  bus_add_driver+0x148/0x220
[ 5139.304496]  driver_register+0x95/0x100
[ 5139.304498]  __pci_register_driver+0x68/0x70
[ 5139.304500]  amdgpu_init+0xbc/0x1000 [amdgpu]
[ 5139.304655]  ? 0xffffffffc0b8f000
[ 5139.304657]  do_one_initcall+0x46/0x1e0
[ 5139.304659]  ? kmem_cache_alloc_trace+0x19e/0x2e0
[ 5139.304663]  do_init_module+0x52/0x260
[ 5139.304665]  load_module+0xb2b/0xbc0
[ 5139.304667]  __do_sys_finit_module+0xbf/0x120
[ 5139.304669]  __x64_sys_finit_module+0x18/0x20
[ 5139.304670]  do_syscall_64+0x59/0xc0
[ 5139.304673]  ? exit_to_user_mode_prepare+0x37/0xb0
[ 5139.304676]  ? syscall_exit_to_user_mode+0x27/0x50
[ 5139.304678]  ? __x64_sys_mmap+0x33/0x50
[ 5139.304680]  ? do_syscall_64+0x69/0xc0
[ 5139.304681]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 5139.304684] RIP: 0033:0x7f42ffdbf88d
[ 5139.304686] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
[ 5139.304687] RSP: 002b:00007ffcb7427158 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[ 5139.304688] RAX: ffffffffffffffda RBX: 000055ce8b8f3150 RCX: 00007f42ffd=
bf88d
[ 5139.304689] RDX: 0000000000000000 RSI: 000055ce8b8f9a70 RDI: 00000000000=
0000a
[ 5139.304690] RBP: 0000000000040000 R08: 0000000000000000 R09: 00000000000=
00011
[ 5139.304690] R10: 000000000000000a R11: 0000000000000246 R12: 000055ce8b8=
f9a70
[ 5139.304691] R13: 000055ce8b8f2ec0 R14: 000055ce8b8f2ab0 R15: 000055ce8b8=
f9aa0
[ 5139.304692]  </TASK>
[ 5139.304693] ---[ end trace 8536b052f7883003 ]---

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c        |  7 +++++--
 7 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index d4f3fb3519c8..5e9980a48085 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -595,6 +595,7 @@ static bool amdgpu_fence_need_ring_interrupt_restore(st=
ruct amdgpu_ring *ring)
  */
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 {
+	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
 	int i, r;
=20
 	for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
@@ -614,7 +615,8 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *=
adev)
=20
 		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
 		    ring->fence_drv.irq_src &&
-		    amdgpu_fence_need_ring_interrupt_restore(ring))
+		    amdgpu_fence_need_ring_interrupt_restore(ring) &&
+		    !ras->is_rma)
 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index cb7991362b5d..6f24e95c9112 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2496,6 +2496,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_vram_mgr_fini(adev);
 	amdgpu_gtt_mgr_fini(adev);
 	amdgpu_preempt_mgr_fini(adev);
+	amdgpu_doorbell_fini(adev);
+
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index cd6e4c0b94da..e970a1427fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -719,10 +719,10 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *=
adev)
 	struct amdgpu_xcp_cfg *xcp_cfg;
 	int i;
=20
-	if (!adev->xcp_mgr)
+	if (!adev->xcp_mgr || !adev->xcp_mgr->xcp_cfg)
 		return;
=20
-	xcp_cfg =3D  adev->xcp_mgr->xcp_cfg;
+	xcp_cfg =3D adev->xcp_mgr->xcp_cfg;
 	for (i =3D 0; i < xcp_cfg->num_res; i++) {
 		xcp_res =3D &xcp_cfg->xcp_res[i];
 		kobject_put(&xcp_res->kobj);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index dcc6752c3ece..4ae19a9cf843 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2377,12 +2377,20 @@ static int gfx_v9_4_3_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
 static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev =3D ip_block->adev;
+	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
 	int i, num_xcc;
=20
-	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	if (!ras->is_rma)
+		amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+
+	if (!ras->is_rma)
+		amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
+
+	if (!ras->is_rma)
+		amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+
+	if (!ras->is_rma)
+		amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
=20
 	num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
 	for (i =3D 0; i < num_xcc; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 59385da80185..95dc408faa02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2491,6 +2491,7 @@ static void gmc_v9_0_gart_disable(struct amdgpu_devic=
e *adev)
 static int gmc_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev =3D ip_block->adev;
+	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
=20
 	gmc_v9_0_gart_disable(adev);
=20
@@ -2513,10 +2514,12 @@ static int gmc_v9_0_hw_fini(struct amdgpu_ip_block =
*ip_block)
 	 * are not enabled.
 	 */
 	if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
-		amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+		if (!ras->is_rma)
+			amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
=20
 		if (adev->gmc.ecc_irq.funcs &&
-		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
+		    !ras->is_rma)
 			amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	}
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 11f9c07f1e8d..788f035424f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1606,6 +1606,7 @@ static int sdma_v4_4_2_hw_init(struct amdgpu_ip_block=
 *ip_block)
 static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev =3D ip_block->adev;
+	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
 	uint32_t inst_mask;
 	int i;
=20
@@ -1615,8 +1616,9 @@ static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_block=
 *ip_block)
 	inst_mask =3D GENMASK(adev->sdma.num_instances - 1, 0);
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
 		for (i =3D 0; i < adev->sdma.num_instances; i++) {
-			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+			if (!ras->is_rma)
+				amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+					       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
 		}
 	}
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index c457be3a3c56..23722367bda8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1317,6 +1317,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
 static int soc15_common_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev =3D ip_block->adev;
+	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
=20
 	/* Disable the doorbell aperture and selfring doorbell aperture
 	 * separately in hw_fini because soc15_enable_doorbell_aperture
@@ -1338,10 +1339,12 @@ static int soc15_common_hw_fini(struct amdgpu_ip_bl=
ock *ip_block)
 	    adev->nbio.ras_if &&
 	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
 		if (adev->nbio.ras &&
-		    adev->nbio.ras->init_ras_controller_interrupt)
+		    adev->nbio.ras->init_ras_controller_interrupt &&
+		    !ras->is_rma)
 			amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
 		if (adev->nbio.ras &&
-		    adev->nbio.ras->init_ras_err_event_athub_interrupt)
+		    adev->nbio.ras->init_ras_err_event_athub_interrupt &&
+		    !ras->is_rma)
 			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
=20
--=20
2.34.1

