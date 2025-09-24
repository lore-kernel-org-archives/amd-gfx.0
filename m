Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3640ECAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 15:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C970510E766;
	Wed, 24 Sep 2025 15:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Z7q+9p2";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A862D10E765
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 15:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=planbrEabamBGYMYSpu2R5MNfV1DctFA+r/BGDIevFuyAv2DEWMwXQ3Nlm0w8T0p9YZm+XGPQnmo9YJ6GGhhY13jmoptqu5tUMRIkGEfey5Z3BQ1d/LFOWBbaqnWCzSlZQ8lQNGW4AYp4WKbDPMswICX+lSNDraCqQL4D0DzE6WkX+YITN291EqRcLXv9uAUtyAKVrc6IieB4tjKRkmRsh6b7Vep6ZBzqm3ImZfYMdMaSVVSBkdZEYuKhKtYqqExc99q/gLOhZbIlck8JLr/rFJNqBSzKdo39FAIncDG2Dsrj7LwnsT7gYjxQ8b0mknXDutfpFUOtfkKK7Rg04Farw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze+T7rd61l4wFImwiIOFJj+S81c1ksmZ8Mmv20QqWFM=;
 b=E/f7Z9lnHQYgLuaEXGA1N8LsesBKrcDQT/mBlWXZMis2RpfDIyK6SMUCSS9veDi2c3d9RaoC9fspTKt1JVIbNLeWUt5SYBXS/ltXg/SR1NQpe5OLVJQ8NyIW6jU9zyJHJkXm/tUcBji9CixeUGVBn7zJLK5oc+Bpg7tvjUKoQgOpTnHDe7GZmCdfxM/9Y4GP2XJPdkdKq2FvYHIIoNLevr4bLT4AMMxY1EYMvLg7FKzLVwEyXaMIs+VYTjS5+YfXs2I0nVzfyGzo7Cjq8Thz36xMguprar5zbmtZ0mydcdtI/ydEqGoguWEumk53NG2CpenW+XwiONG1LPkoNfavJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze+T7rd61l4wFImwiIOFJj+S81c1ksmZ8Mmv20QqWFM=;
 b=2Z7q+9p25GGVciblSkG4qpIKG3g476l3NQ/cEqvYuqn5Kr2/TLjcFGQQ8G2zdWpQ9O7v5N4Nw2PGKEdQv+N4LWltKJEx/wfOfiOFezWtg0sO0dI5mLeBXoUjJwhZNYfMSEBoHZ8CoIeqyZVdu4dov5OfFhuBemF+gRzNK5G8K9I=
Received: from DS7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::16) by
 DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Wed, 24 Sep 2025 15:29:54 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::f8) by DS7P220CA0011.outlook.office365.com
 (2603:10b6:8:1ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 15:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 15:29:54 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 08:29:50 -0700
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Philip.Yang@amd.com>, <Lijo.Lazar@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v4 2/2] amd/amdkfd: enhance kfd process check in switch
 partition
Date: Wed, 24 Sep 2025 23:29:29 +0800
Message-ID: <20250924152929.2234747-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924152929.2234747-1-yifan1.zhang@amd.com>
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 519284fc-ce47-4269-9a2f-08ddfb7f3640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eaeQmmS7eLaghUmk0NiXnzbthqul5e1ljqNBNmy0sgP2iAat8xey4gf6bwhp?=
 =?us-ascii?Q?WMpNfEH9zF9d3T+BAitz/Z6DGObFlHcM5v53nwnobPhbZgWv7o/ToR+NLuUj?=
 =?us-ascii?Q?AomR8otgY0vRWHkZneZwS5sIDuJCZQVviDS4Sv8pJda4EVEGYo7ur7tImECz?=
 =?us-ascii?Q?XDNmpXGxR8qwS0pr/0QQT2n0VXOY+gKeXqyxVjI6YNNUuiaHXKjgw7FUI07N?=
 =?us-ascii?Q?d0Z/lXkGGsI5MlXBuUfyzxNCVy5+VJWTfhzbddp8YHxsaJSS1VB9s1513csf?=
 =?us-ascii?Q?zDkFcy/6AJ0Ux+Aqa7Dx9gPwX59FluQ0xhP+IJzSkQNS0vm2cAi8iC9t2hox?=
 =?us-ascii?Q?hq/cOeulqwYow1f4kWNKQh1Mapu/AaOY8hqvuuzFXNtHo0LTIwRyYUWWfWzC?=
 =?us-ascii?Q?dc3kVHNUg6RIIM1KEBROVE7y8wpyFJp0Z7K4Dn5jlcqCDkX2eAS9U7lo6vvH?=
 =?us-ascii?Q?ZuzrNP2H/axBXg+gyR/tNArB4MqwvQJ3JoCxjU74YewqcFmRjjtNH+oLFi4F?=
 =?us-ascii?Q?XI0ZNE5Yf+I8EhaxDlBJxfhiO1eMAxIEEkWbKi/0jImatouOfZOA5Yvlrxwm?=
 =?us-ascii?Q?jIgrIqajB3WUXCm/bEQEvvQ9Q8LKMOnuFbROJAn53RfUwZgNB87k5wm1OC9o?=
 =?us-ascii?Q?3kKs9Kr/YvzmZVIWvR25GfkKJJcFkoGlHxe2KkQiwAYT2nulisSRQnAlEXQp?=
 =?us-ascii?Q?S8Y5eYd3OpQXPWmxO6dUEWmoKBrQFzQF9nj54WjAX2/w3pwD3YZj6ccs54JR?=
 =?us-ascii?Q?vXWZHYpls1ycp7AS9c/rFAppjydFW2Han3KwO0CxQGySPLDDPAb8+8K/vx1r?=
 =?us-ascii?Q?upZVB9/h4qpJTtRktWDflhzjlj1HTTOtu+R3y6v/KN1jR2Ux6bbRnBA1zQ/B?=
 =?us-ascii?Q?vQEyG46TeO4B2A749tGA8AEJ0JXnPOTx/ndDw3qUvOgbQOit2+aRAKeI14WH?=
 =?us-ascii?Q?LCsdFIVXBcbee5EN1B+nfaW3Gvtruai6nrACuokozmmD9v4wV6uYDKKgo+ck?=
 =?us-ascii?Q?0xygg0Q03HWtRsAVDJUS1c5hh5RDJU6ZRbg0u4tAlIq0E0r0S2hH1viHpXnR?=
 =?us-ascii?Q?lrKF44qhSOpLrbzOBZLyX+NfBODGmQb+Aew5aO8r39AQbkuDpPfLtcJNNZ93?=
 =?us-ascii?Q?7REycytjEFGrNvvAo4Gnnwjh5tZ0K32JReWjMIuTlceqYQ9yDZAvfhhGMR2J?=
 =?us-ascii?Q?jPtnCF8cUV3tOfyBUJDmjZkc5MCtsU9e8+cf2AVkZXmvH8BS2wJBUJolzVor?=
 =?us-ascii?Q?SgLPZcgikiVi7K1qcREqQ0t0t0JETXHSWGh0/ttzF5j/RCndps4SS8gH8qZK?=
 =?us-ascii?Q?LurbfpfptncvdlckkO+HRPUQPxHy9hx3OasZLbOM23cM5bVNMvTF8lf9a2Lw?=
 =?us-ascii?Q?oKd5StRuyxmsaFoLJ6dmDGq7SbNF+jaSdb5mGHrCLwRfALJo105ue1ZY2vgf?=
 =?us-ascii?Q?SbZ6HrzFS24GExWidD7e6Mn9WmQax2VdjNc0WE9YmVbVUZ1XzY3F4DO4cYav?=
 =?us-ascii?Q?Z04Wc0VgWkX9KG92lFLAQRhUgTjptSqxe4uB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 15:29:54.5309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519284fc-ce47-4269-9a2f-08ddfb7f3640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
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
 drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 9 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 051a00152b08..488c8c0e6ccd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1493,6 +1493,15 @@ int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
 
 	mutex_lock(&kfd_processes_mutex);
 
+	/* kfd_processes_count is per kfd_dev, return -EBUSY without
+	 * further check
+	 */
+	if (!!atomic_read(&kfd->kfd_processes_count)) {
+		pr_debug("process_wq_release not finished\n");
+		r = -EBUSY;
+		goto out;
+	}
+
 	if (hash_empty(kfd_processes_table) && !kfd_is_locked(kfd))
 		goto out;
 
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

