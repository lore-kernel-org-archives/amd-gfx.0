Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19F0CAC5A0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 13:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3E610E8B9;
	Thu, 18 Sep 2025 13:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1AKORD62";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2AF710E8B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQs00kMEEX+ubSNf8Wqq6BTs+/yZyW/36PV53gL3NmbI47fIEwe2O2JU4PvHlKlV2JYJtZmEC2/nuUCvs5AiM1S+t3ujmLZ9UhfQ00Znd+HdZ/+FMeU8qdXPF5xT8qq9uDN3ET41lPI8AwIuRTBmfBI5b5yZ155bZ++imyDW4AHQGCAM0TmGrpwUzM46whkzWd5LjTIgDlke8sWPxEVScsBO7TS/dVcJQFXrcixA/uspvNoLbGDZiVWT2PNuXHT8QopO2TbNsYRmjLmtnq6sR/0M+zvYBZlbtbCIKBu9zix/ACgDCkrxa6+NrVHD8qD5yXT+RiYg3gPRNrBTUG9vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/qMLpHlMelGif8uo3kwgKJXI8J3OkUtg5DlKvTb81o=;
 b=XhJPNs8WvIRIDrgiFfQ7RlRe8qRx6k4OComKPYeF4LXr4Db57fBB8SPXLYwmX4eOpJ5CQLJbyYg53BPC5bDi8lRAomTkVC1c2ufJsWwKJWtkrY4TcXt4IOvUy1CGx7Nm5bwoR4Gm7K5y5LfibqIlnq8da2jJfPbytcfUOdVt2tHebfLbt27fX7XfgZoASRvU612U9TbAtXyY9pH8n5lOVXjBdEwgufh5DUvmZwecCABBzQ7mHEiiFytb1JgqKT5ZKOEQoSwhHetJpmsiWVQWJNSwwHHf5kBtKZzQWCZ+j58N5H8SIcacYyg11ktoPl27My93fvqFlI/1yiXspEqiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/qMLpHlMelGif8uo3kwgKJXI8J3OkUtg5DlKvTb81o=;
 b=1AKORD62zNN0jK28/9zIR1/bbIYm4LjRIhGfAk5zDUC59eJKK1hbFsKTlC7Y81GikhV+AFLIBXfsDKaqSZn+JPllWHbFkyGOwsxUtfyxzt+jolNB7SC+I0keJ/66NDqrAt9uGpeQmIyEV1Sf2sW1glRRpvF86iR4cokVOGSQti8=
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Thu, 18 Sep
 2025 13:40:25 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::4e) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 13:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 13:40:24 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 06:40:22 -0700
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <Philip.Yang@amd.com>, <Lijo.Lazar@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v2 2/2] amd/amdkfd: enhance kfd process check in switch
 partition
Date: Thu, 18 Sep 2025 21:40:00 +0800
Message-ID: <20250918134000.948525-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918134000.948525-1-yifan1.zhang@amd.com>
References: <20250918134000.948525-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: c75eece4-307a-423f-5907-08ddf6b8ebfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ezCdW27F1vEdmeMAze5UEI8DHpKCZ2xFrbq29RHVwHAZ3oSxZfMZyRlbhFzG?=
 =?us-ascii?Q?1t2yidaHvQfmGej0Yelv0DPGUHVdj7Pp4TA2w8vI6HXB7KNJ1BrprPjo26TX?=
 =?us-ascii?Q?/Ut+VaSF1ckpD146FbmNcaCpkBW70Ao6yFE+yusG3nQt/xjzdWY11BFuX2xk?=
 =?us-ascii?Q?+2bISEyH5/h8AY8CQ7KgSEh9KYp69HJAi+EcxWX19wVetx+7LL2oKDbUY3uF?=
 =?us-ascii?Q?JpQPG4jechN+6vsDXNHmi6doijTh64366Tj2kVVtLp0UCiBwzo6t8ebVeYH5?=
 =?us-ascii?Q?YLDJA4qLrm/KimCilr+bE/9i6/cDjOgadDbamra7/FJyX/nDkSsvdRQbHAe9?=
 =?us-ascii?Q?yM2O33pAr6RD2dURP9c5Y0GPWglka/mSQhNcqPJqv4l0p1wV2fpf8QwFy+Ue?=
 =?us-ascii?Q?L/iWVKwtSKYjHAgEE1cN8yuDNzdWijT2OfMjC4I4Rb623NlW2CTLge1G6avZ?=
 =?us-ascii?Q?I9Ie/Yt6kYCd1b7evVWPY7mW5Safw7TSY3nBEHwfPqLyTY8/mWNhKj6nZ+ZP?=
 =?us-ascii?Q?D7WVLy5p7MWpVnJ0JlDR9F5s2o24MuXdLIUlwHBGVB/iIc/NqdSPCtGfrGcf?=
 =?us-ascii?Q?fRv0G/dDAYrTugejxssOeTZ0ZcxQ9sEC0BYXwqBgz8Lz7GPIa6H0t5HrJ/I/?=
 =?us-ascii?Q?/T+Rhk0T7D9XqGx3w/5WMof5g0WbdZGW+gvlKaEI2Nfu/GzDMdiSxiShZvLT?=
 =?us-ascii?Q?OQP+SoLYqSQ5oQcHg/1cG24M1m8Wy0ywMduszhGHB3h8MBfdvVRGpy6/UYRm?=
 =?us-ascii?Q?28TM0P4K5Oxqz+jmMqnSt19KcVKoVtl84tIomHSxkPvAXfZkq0q/6qhfLVcG?=
 =?us-ascii?Q?UbnKQFo4SNgvUxqMXXQHOJKge9JopjdcmNdmrY5gL/3vwtFw4ublHbfCa2g7?=
 =?us-ascii?Q?GRl6UCkn0sigtbl8HHJOK2pdhU7eqC8vvqOA/2U32fB/Tl2nYVi77pmNA5A9?=
 =?us-ascii?Q?h1RMAQsKFJ59sq0xMgPOlcYCVarGapbgTxbAlT87lA/b8dKGAGduCJPs1Gpq?=
 =?us-ascii?Q?2t0UrXsDddGb3O9UaECA35RYG9Jq+K595oO3AjVRYgMEWgwj+49589OqoNWZ?=
 =?us-ascii?Q?jSgMpEy7QohfIXDTIpdCRCTiqq2qmzcRglQHhFnDyLE/BM5slxKuHTpGPQoo?=
 =?us-ascii?Q?4fIryLzCYTXJmS2lvXTw8TDrEoNrxrP4IgEzNYvNEbb8I/BS5nXje8odCGv+?=
 =?us-ascii?Q?Lymz03gefZNubyE1roHn0GCY51Ls7NlOVrhyduvXvAFYwTBcAbpaZduIZaW4?=
 =?us-ascii?Q?EOxpyc8cq3ePEgpe+LiwHXIU7paeA5IERCiRcDBtVAPk4aLqWHTWC7hGiekg?=
 =?us-ascii?Q?UQpslSa2ow604pQ8BnUChqQlniWH0Ax1LwkxnSZmeAKl1OKhrIyEl1ABTALU?=
 =?us-ascii?Q?ns73AuVCzi8CXeKVAqtBkvGAhB1huIbTFnMWx9iW5y2m41JtCSNwZQxcfP8g?=
 =?us-ascii?Q?cNJlTsGqLnenSocmkNbGIlJkq45fuSxae1OvTL1nTskdxsoKU6f32X7RswVU?=
 =?us-ascii?Q?QvfwAXCoh29ZcYYZmqlKydmyMeYHqLXgAYmj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:40:24.9777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75eece4-307a-423f-5907-08ddf6b8ebfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
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

Process A workqueue -> kfd_process_wq_release -> Access kfd_node member
Process B switch partition -> amdgpu_xcp_pre_partition_switch -> amdgpu_amdkfd_device_fini_sw
-> kfd_node tear down.

Process A and B may trigger a race as below:

This patch is to resolve the race by adding an atomic kfd_process counter
kfd_processes_count, it increment as create kfd process, decrement as
finish kfd_process_wq_release.

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
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 5649cdb3f9c2..1cdb21c90bd3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1521,6 +1521,12 @@ int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
 
 proc_check_unlock:
 	srcu_read_unlock(&kfd_processes_srcu, idx);
+
+	if (!!atomic_read(&kfd_processes_count)) {
+		pr_info("process_wq_release not finished\n");
+		return -EBUSY;
+	}
+
 out:
 	if (!r)
 		++kfd->kfd_dev_lock;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d01ef5ac0766..870c621a410a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -204,6 +204,8 @@ extern bool debug_evictions;
 
 extern struct mutex kfd_processes_mutex;
 
+extern atomic_t kfd_processes_count;
+
 enum cache_policy {
 	cache_policy_coherent,
 	cache_policy_noncoherent
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5be28c6c4f6a..c1d9799bf94e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -52,6 +52,8 @@ struct mm_struct;
 DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 DEFINE_MUTEX(kfd_processes_mutex);
 
+atomic_t kfd_processes_count;
+
 DEFINE_SRCU(kfd_processes_srcu);
 
 /* For process termination handling */
@@ -871,6 +873,8 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		if (IS_ERR(process))
 			goto out;
 
+		atomic_inc(&kfd_processes_count);
+
 		if (!procfs.kobj)
 			goto out;
 
@@ -1194,6 +1198,8 @@ static void kfd_process_wq_release(struct work_struct *work)
 	put_task_struct(p->lead_thread);
 
 	kfree(p);
+
+	atomic_dec(&kfd_processes_count);
 }
 
 static void kfd_process_ref_release(struct kref *ref)
-- 
2.43.0

