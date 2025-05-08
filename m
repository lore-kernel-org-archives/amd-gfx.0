Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E64C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 14:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56342882AF;
	Thu,  8 May 2025 14:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YVxo2fYx";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F3910E91C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 14:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GR5NvMmmtG5GjIPvPFbPTbY2+YB0jGQnMmPYKFHtieyhXx/yS5iz8oWH/AeB+ndShTQeids08C/WWpy2P8XSnVz8J75pjaFcIZzpj6MPoRnmSfIPp1O6EZWfzyO1KS9vdgXh0HzZF+hVoW6TYP+RQNRLqEqtkr+LMXqXviAeZGBahsE2WVQSxsOigvvZPplA9M2S/q8AmZww6JXoRqly2mCdis1Qplg1aaX5/yRNzZDSmRjxlWnRDCHnJzOyEUla+kOSrepnfY9t4yRdNtI2S3kO6dqKV9+ksA2huQhtAj26sgcmy8rtlpJ1i9fnsICxRB3F9cs0Bc/8Kj3BMyLLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7RzeKMzagJ2TyOcorbKzdPOdZ0YuYw/OYGdJwKQJis=;
 b=U4j2aIms22gLrOLdPwDAbZe0GBooTK+H1TM8AfKZjOshvGw0z8BetyKNZhScuf4MjdCWRSEX86IcVOLUN0d33wAglWXtOZPRkL+MJ87yB7isnLVDghGyg7X4gTbVjSSYr1xcwo3VAIY8qRjgvpWP8Y5cZnHhqtVSOp7SAbdstnjvYR6AxqidEWCS5iBmrwqIJMaMpKsCSSa1W2JvVBeQO5JksalAlE6iyrSuA5f8a6DZcpiMz/MqCf6HlnMnPLENw2kAYfrWwbjr4r9rH2SL5hNP5KVCVKslt6zwY5fQ2j6xt7cq0NTJVD9q6o3uXKeX2rttxO3Eic3nwDywXxAZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7RzeKMzagJ2TyOcorbKzdPOdZ0YuYw/OYGdJwKQJis=;
 b=YVxo2fYxTNZOgm7C5VRkEt/x1zpMmCxFfp2w2LVPMJ/fTlL0id0LGZwe0iWN3iQJr+mX5/69QNpA0JdLJjmCGTY+0PblyjceT3mKqfYT8V1cyf13SLhJZPRH7zPrej7SRQI5duXiF8VO8davv0fKvoHuQkwI9Lt4NARXk0Kiqsg=
Received: from MW2PR2101CA0002.namprd21.prod.outlook.com (2603:10b6:302:1::15)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 14:43:00 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::d) by MW2PR2101CA0002.outlook.office365.com
 (2603:10b6:302:1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.5 via Frontend Transport; Thu, 8
 May 2025 14:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 14:42:59 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 09:42:57 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records exceed
 threshold
Date: Thu, 8 May 2025 22:42:48 +0800
Message-ID: <20250508144248.388934-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: d858f660-fd82-42ba-06fc-08dd8e3ea113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dmHuPV65t3oQxjbW/Y51y9kCCiqMQz8+ewfmwRj0sUBmsMjOPNLfdmCSq67z?=
 =?us-ascii?Q?j7NPCTovGitRgIRt24G1oF0AsqYPnolFI4Z297MAaSpbetB19ssRi9tr8q1C?=
 =?us-ascii?Q?Ozq6NOvUKo2egZkM0O+D4ghRJICgLbSxWEC3JdxXK7eo/tcKNauCNNhdyvB8?=
 =?us-ascii?Q?8+ROtb/hAcoS3Pc/P71egLpxsucbJmjWjl9khQQshknbKp+DFCTgUByncazX?=
 =?us-ascii?Q?eKuXAQZpUABEXXvGw2S2Vy41zHA5pZzJwNLOixvh6TNrNZ94Uit3AzCE3ewn?=
 =?us-ascii?Q?JAdEqHrxL22ecUgJspYjvZ0OEk+/wlLdea/qFQiy7Z9kuEDE3cWTH02ZESHB?=
 =?us-ascii?Q?h4RU52sIEad9cnHXhDpOKO+5piuMU/89NEHx8ivEbnjRmOL09IALBNRXoVY4?=
 =?us-ascii?Q?c/UH/GVy6VDYVj1fBt8AbLu3nfmETb7i30VRg4MiwrVtwgMd4UQ+jQ36f5Rr?=
 =?us-ascii?Q?VhJQbgkP25Zzx47LwtFmcDGIjR5BSCQhJdgWTL2YyhbHBgmOv2FzTem1Cfb1?=
 =?us-ascii?Q?7J2elB6R7Ff3+ukoyY7LruhFdnc3HZ+wSFU3PGPenYSFU2ltIxLxgI/vlPxu?=
 =?us-ascii?Q?Xcpx+BQL5py9IEH/62r99aeLcI0Ogc4HuVKAlS3cUoBNdgigyxzB6/Ir65kg?=
 =?us-ascii?Q?9ybjXD8c6yF2Nd/a3XcelZC7V0oW/y0hUGhy9UW85r4sPJRxx7Dxh06K9Lfu?=
 =?us-ascii?Q?oMUi7jXS/M/1BysztzWCnWAWO7GQenrzS+iBUpFzGG2L1IBYZtPqgft6/Aab?=
 =?us-ascii?Q?NEJ2mtWJ3LSWgXH+snXN1nZAUR1wpDfDTESLaCO8NM4gpSCvPvs2uNSyYkaE?=
 =?us-ascii?Q?LWOn3ElfcVyfJ90dZdIv5VfsZ6xKy3sLM5VDDo7CamOxUlSKfMh38BQjwczo?=
 =?us-ascii?Q?DaQRgOPVgq7XAAQyYtlzznM2sB0f36tZO7tYsqfzNPKALjkiWLWukUxEeL3F?=
 =?us-ascii?Q?g0BpUFOmcHgd6R8PCnxSRCwVysw0kHInMn80GYF2iXZQfv4EdHRZHko25phP?=
 =?us-ascii?Q?Y6xNmmR5HfPFcirkX+aLVBcciwZJzYUTUhOU3yJWCfsjjmPX9OXpi1VZEEcD?=
 =?us-ascii?Q?TU9tmBDNQyWZdIHhql+9T+hUAwonyL4o2S18ElJO1Df/WUedxhhWdbZ0ZHwH?=
 =?us-ascii?Q?x5vxWLlzlIEym7IDWqTyiT9DAeo/g/vX5sVY2o4F0oFRNQ0wTrqbLUC4IB9k?=
 =?us-ascii?Q?LxPqfreSz+gIcYOcHeAwyOjESr748tYEcJ8lnoPg6PbpKfkdSX982thlbpmq?=
 =?us-ascii?Q?gh/utOd+YdxrpVcHPwglEKv2Bdv0EDT4chNtC+Sva7Q95SrJs6sc3F06kasT?=
 =?us-ascii?Q?rNpPNHESMcw9mthjweTsPtjAWtalOCdcy7s9+4xo1Pxb1Jo6lk6rQfIVhR8u?=
 =?us-ascii?Q?liVOnyAnxCeqjmd+hulh/8NTj3U9xYUYv2TBhHNYqhKsuXeeL/DfzhZhyODs?=
 =?us-ascii?Q?5IQwH8Tp8lE9jc1Shq4+rN9fqeM7oNpX/kRYSVRgUvZC6hKvI9KPP2iRidRH?=
 =?us-ascii?Q?rpaNBUYvf54kx+ZMDHW+B7YzGeAnflqFh0iZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:42:59.6613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d858f660-fd82-42ba-06fc-08dd8e3ea113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028
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
1.Fix the kernel panic caused by disabling the interrupt source before it w=
as enabled
2.Fix the memory leak caused by the device's early exit due to rma

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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c        |  6 ++++--
 7 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index d4f3fb3519c8..1166093d2b5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -614,7 +614,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *=
adev)
=20
 		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
 		    ring->fence_drv.irq_src &&
-		    amdgpu_fence_need_ring_interrupt_restore(ring))
+		    amdgpu_fence_need_ring_interrupt_restore(ring) &&
+		    amdgpu_irq_enabled(adev, ring->fence_drv.irq_src,
+				       ring->fence_drv.irq_type))
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
index dcc6752c3ece..dd0a2cfd85cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2379,10 +2379,17 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
 	struct amdgpu_device *adev =3D ip_block->adev;
 	int i, num_xcc;
=20
-	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
-	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	if (amdgpu_irq_enabled(adev, &adev->gfx.priv_reg_irq, 0))
+		amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+
+	if (amdgpu_irq_enabled(adev, &adev->gfx.spm_irq, 0))
+		amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
+
+	if (amdgpu_irq_enabled(adev, &adev->gfx.priv_inst_irq, 0))
+		amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+
+	if (amdgpu_irq_enabled(adev, &adev->gfx.bad_op_irq, 0))
+		amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
=20
 	num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
 	for (i =3D 0; i < num_xcc; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 59385da80185..05599c253e24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2513,10 +2513,12 @@ static int gmc_v9_0_hw_fini(struct amdgpu_ip_block =
*ip_block)
 	 * are not enabled.
 	 */
 	if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
-		amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+		if (amdgpu_irq_enabled(adev, &adev->gmc.vm_fault, 0))
+			amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
=20
 		if (adev->gmc.ecc_irq.funcs &&
-		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
+		    amdgpu_irq_enabled(adev, &adev->gmc.ecc_irq, 0))
 			amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	}
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 11f9c07f1e8d..60f5f3b367d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1615,8 +1615,10 @@ static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
 	inst_mask =3D GENMASK(adev->sdma.num_instances - 1, 0);
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
 		for (i =3D 0; i < adev->sdma.num_instances; i++) {
-			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+			if (amdgpu_irq_enabled(adev, &adev->sdma.ecc_irq,
+					       AMDGPU_SDMA_IRQ_INSTANCE0 + i))
+				amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+					       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
 		}
 	}
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index c457be3a3c56..5a60cf679307 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1338,10 +1338,12 @@ static int soc15_common_hw_fini(struct amdgpu_ip_bl=
ock *ip_block)
 	    adev->nbio.ras_if &&
 	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
 		if (adev->nbio.ras &&
-		    adev->nbio.ras->init_ras_controller_interrupt)
+		    adev->nbio.ras->init_ras_controller_interrupt &&
+		    amdgpu_irq_enabled(adev, &adev->nbio.ras_controller_irq, 0))
 			amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
 		if (adev->nbio.ras &&
-		    adev->nbio.ras->init_ras_err_event_athub_interrupt)
+		    adev->nbio.ras->init_ras_err_event_athub_interrupt &&
+		    amdgpu_irq_enabled(adev, &adev->nbio.ras_err_event_athub_irq, 0))
 			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
=20
--=20
2.34.1

