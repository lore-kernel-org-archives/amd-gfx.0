Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADFACAC5AA
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 02:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C334010E1D9;
	Tue, 23 Sep 2025 02:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PbVADMfZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49AC310E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 02:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN7MVFOgpaA7pCS3Of4miChwsEKo4vH3jv5T4FWxNR9X3/9v95vmE+JXbgLtixsAhce2XjQgA/R4KmFc22wOpMyZMBVAlAQJQAy8zfa+lQeSAY5W3EjmFDpdO8IMCj7I314vfLhc5sbWJMQFaiKvxW2Jl6taQz50N/zXUOKOgReLxiE7Q3A1o5kLbYivNCz0q7iNs2A6OgO/YW93DhHZZMCnV+praJqLsRU5Oz98nnyorNtlU0hde9QeZJqW1m8pRIBYQAyZOiXiLytZElzbdgd+W/P64BTUax5tGgeL4kD/DUAzZPYWhm+fj6TOcdcVxt3loGjQmdv8WCIEj3xcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pt2nxMp0gZtfhd/kb0GiUus6PRTCOIrJuQYZEPI5mI=;
 b=bZmQ5MDF0TCWgU+617DdnhKVrLaYrwpJG1dGBQ7yqwIdJKXWJawctSkdU3MEKHeU36RaxQiUOt4pROM6ECotKQ72Up7Qeq+rc0ZXeNVQ9mRzrffG6ufd1nNAekJIffS73IADs6yOEavypG1uzR77ua2D3/LmVISrETk7LLYOaSn/5P1tCO+7BlVoqmRDDXhUusQ3tepwZM+Y0bHy8eHCY+pS/dK5SRG2UPtg8BsOGYLtXmj/irdngT9T7wg6tGylmK1xV/NPxvFVF248Rw1pl9cA/HRW9v6D88dun5idVFRnyFY6yVeXWKbEkVYZFzxGHlH7q4Y9EWbq8AWX0pByeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pt2nxMp0gZtfhd/kb0GiUus6PRTCOIrJuQYZEPI5mI=;
 b=PbVADMfZvv6vG92286vHXqb2uJMXrOhtHuM/gqGtEqt+fi8dYjlxorKKdS0vwWJCWqL1L1h0Sehu/LKDDKQbAB8dWTTHtvWHwFO5bqe00PyB9SB4kNm7Fp8gwJeGKUP/5Bi/za57dMUx6L5Gt0ScLvSRnSIrRdM5BG7yIvLfoY8=
Received: from DM6PR11CA0016.namprd11.prod.outlook.com (2603:10b6:5:190::29)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 02:59:13 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::13) by DM6PR11CA0016.outlook.office365.com
 (2603:10b6:5:190::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 02:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 02:59:12 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 19:59:10 -0700
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <Philip.Yang@amd.com>, <Lijo.Lazar@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v3 2/2] amd/amdkfd: enhance kfd process check in switch
 partition
Date: Tue, 23 Sep 2025 10:58:52 +0800
Message-ID: <20250923025852.1679262-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923025852.1679262-1-yifan1.zhang@amd.com>
References: <20250923025852.1679262-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb6d15a-e3c3-4a61-7b6f-08ddfa4d2cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?abZ2OaXc/mas/jSzHZoM0rfLTqeVq+Q6AowbZatmxcU5LLVxoLzOC+nb+e4Y?=
 =?us-ascii?Q?HG2mreEVt3xpofN+mIN03mPTa6NZdS5EKhS1FDrXxr5YzBfU4unLjpqAvKpc?=
 =?us-ascii?Q?WQI9WeuhTI0lcUtmn8uyXMXx2Wuj42IaPb9PpzeiE+p1Upb8ofxxpF/hxahm?=
 =?us-ascii?Q?gRu+xmaKWzz2vkZC7BZJ33Gs8k4faDL9sTCAedYjQdEhQ0BpKLtxSadvKEei?=
 =?us-ascii?Q?Y8mK1cHTh1TTem1S+mh9VxUyP9cMmNiDUzU0oAhkOJM0GaBew0MY1qQIZ4NT?=
 =?us-ascii?Q?ZnoqZQ6TpnItW8S8SHP7JpbmhTB+exHHdai06j7uy7zJRV4s+NgiFuooyefl?=
 =?us-ascii?Q?7NKJ3lwmqx5gDA6BFuxzSlSTbguCVYNJBaoQGv7bYzQgVmWHgQxBaL/q2Rdk?=
 =?us-ascii?Q?v0Gke8Pv1JOCpICODSS0ZZ0ikZH4mG48wAw7tOUC+GwIvzLawcWC5k1P0PqE?=
 =?us-ascii?Q?JYwG84WDL8AorgdnTu+G0fKJFat4c96+hG1QDZv1wH3JBmT9W9YTIaD98tFx?=
 =?us-ascii?Q?C1GFwuDRIgR4bCJNt89jmIY4WSK8Qzj7U11WC9treIGJT7PXUCokmv8KbYKO?=
 =?us-ascii?Q?cH8kOBgnj5fZlaLeEMWLBQloP98ZhsbctvVGYDxEcn4q23X1oOTzAXXjerf3?=
 =?us-ascii?Q?686+uGJ0YXYzb2R/oit48ZAVYR8MkiFsCamaZ8qPo37HEdJdEOWQZ1Vzn8Wo?=
 =?us-ascii?Q?di+MROS/aLSZiE3AlGMF42Xv3VjG8/r6Qu53IJBU+ijwYGY+g+2t1lWx4iAI?=
 =?us-ascii?Q?w0407EgDrqW8NRIvdoy55euj8bf1JfLFmbEmfFXHTMsWIJQihKKAu3tH08ce?=
 =?us-ascii?Q?j1cmWbs/kg5A/gdyvUHjQ1QWeBXzrevyiU7NMrr8NwxDzzhU5/wNDLObt7aH?=
 =?us-ascii?Q?yjXXfUNiXn2Rt+tswwKiscv/C+yKvoIuUtLPkhF6oZMLdRGocRVVEfbHNVC0?=
 =?us-ascii?Q?ZE8Mg6dRbYCSuB+lge1b3E/TLMNOTrTj/tZlrXx2kzpWRPdX0s9QEIekXU6t?=
 =?us-ascii?Q?539i67fnRimHqTUaIAXVPnotnBEqpBbgNC4Wci47gqmnDhoJCRjd0S4ACtwf?=
 =?us-ascii?Q?TGTOCZPm3D2eRphPxVpaNf7Uk6iCP4o3Gw3Y+mGgHXXZnZZBZMU45RCqCBHl?=
 =?us-ascii?Q?1HPlxlIMIYL2mUWW/gDMd9hCTkeO1W5sDah0YN7Pvj5I/SMGVA2CluGCbuH7?=
 =?us-ascii?Q?dJVpqXwrmE4f5+5FsnZt8i738shVoqsDOfJ7/Sx+yX2pTlXPd5pT+yLdx/k0?=
 =?us-ascii?Q?X+CgnpSz//Q9IGsk0chq2bew0h8+RN/VD9YoVjrKVBVshLZ6s0uWRlMVEsji?=
 =?us-ascii?Q?Mm+QniiVdE7zw/3JO2iSRCl5CNVt+7izZeWLssOXcTrKXje+MNqwMaPowHzs?=
 =?us-ascii?Q?/RtCodSFmAxWjVeCEif2HOXVTxiTLVrpi2K+QlqJOTGo+GGqQNc9fUpg1KIM?=
 =?us-ascii?Q?Smsqb93DEghPUQVLJYrvAsFwMTNAc63SctyyMB3l7Q60wiCn9FHUWIPTNPGU?=
 =?us-ascii?Q?Lr/HkYZgjFyVrXZG3R212RLq4MiZoxclroz0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:59:12.9376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb6d15a-e3c3-4a61-7b6f-08ddfa4d2cf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
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

current switch partition only check if kfd_processes_table is empty.
kfd_prcesses_table entry is deleted in kfd_process_notifier_release, but
kfd_process tear down is in kfd_process_wq_release.

consider two processes:

Process A (workqueue) -> kfd_process_wq_release -> Access kfd_node member
Process B switch partition -> amdgpu_xcp_pre_partition_switch -> amdgpu_amdkfd_device_fini_sw
-> kfd_node tear down.

Process A and B may trigger a race as shown in dmesg log.

This patch is to resolve the race by adding an atomic kfd_process counter
kfd_processes_count, it increment as create kfd process, decrement as
finish kfd_process_wq_release.

v2: Put kfd_processes_count per kfd_dev, move decrement to kfd_process_destroy_pdds
and bug fix. (Philip Yang)

[3966658.307702] divide error: 0000 [#1] SMP NOPTI
[3966658.350818]  i10nm_edac
[3966658.356318] CPU: 124 PID: 38435 Comm: kworker/124:0 Kdump: loaded Tainted
[3966658.356890] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
[3966658.362839]  nfit
[3966658.366457] RIP: 0010:kfd_get_num_sdma_engines+0x17/0x40 [amdgpu]
[3966658.366460] Code: 00 00 e9 ac 81 02 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 48 8b 4f 08 48 8b b7 00 01 00 00 8b 81 58 26 03 00 99 <f7> be b8 01 00 00 80 b9 70 2e 00 00 00 74 0b 83 f8 02 ba 02 00 00
[3966658.380967]  x86_pkg_temp_thermal
[3966658.391529] RSP: 0018:ffffc900a0edfdd8 EFLAGS: 00010246
[3966658.391531] RAX: 0000000000000008 RBX: ffff8974e593b800 RCX: ffff888645900000
[3966658.391531] RDX: 0000000000000000 RSI: ffff888129154400 RDI: ffff888129151c00
[3966658.391532] RBP: ffff8883ad79d400 R08: 0000000000000000 R09: ffff8890d2750af4
[3966658.391532] R10: 0000000000000018 R11: 0000000000000018 R12: 0000000000000000
[3966658.391533] R13: ffff8883ad79d400 R14: ffffe87ff662ba00 R15: ffff8974e593b800
[3966658.391533] FS:  0000000000000000(0000) GS:ffff88fe7f600000(0000) knlGS:0000000000000000
[3966658.391534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[3966658.391534] CR2: 0000000000d71000 CR3: 000000dd0e970004 CR4: 0000000002770ee0
[3966658.391535] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[3966658.391535] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[3966658.391536] PKRU: 55555554
[3966658.391536] Call Trace:
[3966658.391674]  deallocate_sdma_queue+0x38/0xa0 [amdgpu]
[3966658.391762]  process_termination_cpsch+0x1ed/0x480 [amdgpu]
[3966658.399754]  intel_powerclamp
[3966658.402831]  kfd_process_dequeue_from_all_devices+0x5b/0xc0 [amdgpu]
[3966658.402908]  kfd_process_wq_release+0x1a/0x1a0 [amdgpu]
[3966658.410516]  coretemp
[3966658.434016]  process_one_work+0x1ad/0x380
[3966658.434021]  worker_thread+0x49/0x310
[3966658.438963]  kvm_intel
[3966658.446041]  ? process_one_work+0x380/0x380
[3966658.446045]  kthread+0x118/0x140
[3966658.446047]  ? __kthread_bind_mask+0x60/0x60
[3966658.446050]  ret_from_fork+0x1f/0x30
[3966658.446053] Modules linked in: kpatch_20765354(OEK)
[3966658.455310]  kvm
[3966658.464534]  mptcp_diag xsk_diag raw_diag unix_diag af_packet_diag netlink_diag udp_diag act_pedit act_mirred act_vlan cls_flower kpatch_21951273(OEK) kpatch_18424469(OEK) kpatch_19749756(OEK)
[3966658.473462]  idxd_mdev
[3966658.482306]  kpatch_17971294(OEK) sch_ingress xt_conntrack amdgpu(OE) amdxcp(OE) amddrm_buddy(OE) amd_sched(OE) amdttm(OE) amdkcl(OE) intel_ifs iptable_mangle tcm_loop target_core_pscsi tcp_diag target_core_file inet_diag target_core_iblock target_core_user target_core_mod coldpgs kpatch_18383292(OEK) ip6table_nat ip6table_filter ip6_tables ip_set_hash_ipportip ip_set_hash_ipportnet ip_set_hash_ipport ip_set_bitmap_port xt_comment iptable_nat nf_nat iptable_filter ip_tables ip_set ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sn_core_odd(OE) i40e overlay binfmt_misc tun bonding(OE) aisqos(OE) aisqos_hotfixes(OE) rfkill uio_pci_generic uio cuse fuse nf_tables nfnetlink intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm idxd_mdev
[3966658.491237]  vfio_pci
[3966658.501196]  vfio_pci vfio_virqfd mdev vfio_iommu_type1 vfio iax_crypto intel_pmt_telemetry iTCO_wdt intel_pmt_class iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq
[3966658.508537]  vfio_virqfd
[3966658.517569]  snd_seq_device ipmi_ssif isst_if_mbox_pci isst_if_mmio pcspkr snd_pcm idxd intel_uncore ses isst_if_common intel_vsec idxd_bus enclosure snd_timer mei_me snd i2c_i801 i2c_smbus mei i2c_ismt soundcore joydev acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad vfat fat
[3966658.526851]  mdev
[3966658.536096]  nfsd auth_rpcgss nfs_acl lockd grace slb_vtoa(OE) sunrpc dm_mod hookers mlx5_ib(OE) ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm mlx5_core(OE) mlxfw(OE)
[3966658.540381]  vfio_iommu_type1
[3966658.544341]  nvme mpt3sas tls drm nvme_core pci_hyperv_intf raid_class psample libcrc32c crc32c_intel mlxdevm(OE) i2c_core
[3966658.551254]  vfio
[3966658.558742]  scsi_transport_sas wmi pinctrl_emmitsburg sd_mod t10_pi sg ahci libahci libata rdma_ucm(OE) ib_uverbs(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE) ib_umad(OE) ib_core(OE) ib_ucm(OE) mlx_compat(OE)
[3966658.563004]  iax_crypto
[3966658.570988]  [last unloaded: diagnose]
[3966658.571027] ---[ end trace cc9dbb180f9ae537 ]---

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 051a00152b08..97d3158a67a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1521,6 +1521,12 @@ int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
 
 proc_check_unlock:
 	srcu_read_unlock(&kfd_processes_srcu, idx);
+
+	if (!!atomic_read(&kfd->kfd_processes_count)) {
+		pr_debug("process_wq_release not finished\n");
+		r = -EBUSY;
+	}
+
 out:
 	if (!r)
 		++kfd->kfd_dev_lock;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d01ef5ac0766..70ef051511bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -382,6 +382,8 @@ struct kfd_dev {
 
 	/* for dynamic partitioning */
 	int kfd_dev_lock;
+
+	atomic_t kfd_processes_count;
 };
 
 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5be28c6c4f6a..ddfe30c13e9d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1088,6 +1088,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 			pdd->runtime_inuse = false;
 		}
 
+		atomic_dec(&pdd->dev->kfd->kfd_processes_count);
+
 		kfree(pdd);
 		p->pdds[i] = NULL;
 	}
@@ -1649,6 +1651,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	/* Init idr used for memory handle translation */
 	idr_init(&pdd->alloc_idr);
 
+	atomic_inc(&dev->kfd->kfd_processes_count);
+
 	return pdd;
 }
 
-- 
2.43.0

