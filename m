Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3268DCA0EE8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 03:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83C310E40D;
	Wed, 17 Sep 2025 03:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w1E9I9rr";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2286C10E405
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 03:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLYegg4YJwsvoiltlr4mm0JlSQXK7tZqNbY9aVHJJDNJEaWg3UHz72fK7D6Ei13KlMSaVRVUlKyx0aDwJX/bNR8x/7ZoUInbXBuJ4+T0owc3LPYam+Mwir7jKeAPl8sFdHwcp3zNeSM1o6gntcNPEWnnky3TT1MIh+aw/030TupLSnKUH4vAcd5tHw0kdvdRHvX6NCxO7rEDWCnaWKjbwDQlEDRZIehUXM0CNgqDnN/Q5gtDhGXIdBfCOiAFSLQA0fxadXQj2Lj4vYzkyvQhE33DfHKEouEAIQ9bC9I2tX/nx7XbeUpGlMJs225qlCpBF5aOt0Fx6ayBvnmZp6KCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dS9LtZs4Dx9jSCTFWKEM9jQFmfA5ORsGRtl2LOoUag=;
 b=RbEAUXLmqX9JYAldt0XBEEh9FRVuVStWSFVaR7WNuZLKI3eb/710XZAFLkKsvPGNaeRFa1Gh2ttGqh78VEOxs4xvqV9hzH6yQvufUXHA3LOuWmWhpXgnjYqPFCP5lGSU+c1A5GDxlEdCaLzY9+Wl6M3/CfUJjKi2w/KmPn6k1PW/tcAhA/ePohxrKDmMny/A1j68nwAlryfQt8UUsWX2cDGhBjiZ45n7L9uhq8JZCoKqKAWfIHGGZ21g7GMKPlBsJpYyV+5MjFo0K5Si+cHHssUILW333UxfCQP5AHbOnJOqhnOWIb8SywRyOxzLsZMFozxoFcWVjf4lLRLq8okKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dS9LtZs4Dx9jSCTFWKEM9jQFmfA5ORsGRtl2LOoUag=;
 b=w1E9I9rrKnt55Ig8IBJ578PHxswRTBr+poHFsP9maXOUaK/TEauW4bWl5YkF7x2DolV/cBjMgOmHVfSAe5GKiNF0X0OgfxejqKYWQsHgGVANqh+k9f7U22iiOmSmI23gQRzE2aIxsL2lZq4VYrSrCJBlms7IwSjN46UVyIYOOno=
Received: from BYAPR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:40::38)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 03:39:48 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::f) by BYAPR04CA0025.outlook.office365.com
 (2603:10b6:a03:40::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 03:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 03:39:48 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 20:39:45 -0700
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Philip.Yang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 2/2] amd/amdkfd: drain kfd process workquque before switch
 partition
Date: Wed, 17 Sep 2025 11:39:18 +0800
Message-ID: <20250917033918.904142-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917033918.904142-1-yifan1.zhang@amd.com>
References: <20250917033918.904142-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: e77d1e13-26e0-4727-61fc-08ddf59bda11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pX1bYOCqZVEca/1gvqB0HivR3vN3M438+XT4jvETZOnTU6EuI6OLtMZDOWBo?=
 =?us-ascii?Q?+lKYOObzkr8oTErkQoDOBiF6JNY6P9+X5HSX5sHtwzY924lKRnNVIM/e+hZ0?=
 =?us-ascii?Q?thxsykjDZusyG1RkZaoo23Q34fVZ40h/gYWKbJzQVusrHUtGxIBUYxgHoX7L?=
 =?us-ascii?Q?YajA7Izw4btLwyHY9RovY+BuGYOLIut2Z4rwDzYYXU27USSHe4O3etRd3xDh?=
 =?us-ascii?Q?7iLFLz3B6AOQVtvhwxPXZmn7L8Zt66ype7F67d7mGKMMV2B9BijmsCM5d/mT?=
 =?us-ascii?Q?gvgCyVK3s/4UzhwDSIT4yvnfieiGkPN6CjRe33+l02EcxKqzsPqxgRdR5e1Q?=
 =?us-ascii?Q?JErMuUkAkc06XJ4uNDL8F5Yarywn0lApufggD4boXOCiPomT7JihpDpN5hYG?=
 =?us-ascii?Q?06QdQDATcCcwrkzOz61tTaLC6fYixPMqgOA6BoWaaGSqYh0V7omMQzg1SnB/?=
 =?us-ascii?Q?i6glJQwhNuVpK1011GX/kKZ2lya6yn3xYrYqLbD21D6aPIF+g4rpEiZTriD4?=
 =?us-ascii?Q?ayFj/iD8oK20F89UV+twEg4KHWbHWHUV/Y4EqCNjHdlNPkZdTs+NTe8ZXn9s?=
 =?us-ascii?Q?c9lRl3zLPQ9PMDmU/nIq2bx6ClC+u5rKtX9jqst94N77h/q4UEuHa3E1EXBF?=
 =?us-ascii?Q?vvLglYyhCfWtp20Y/vWJwV0a/0YBY7qg1B5hHPNQn9RAI37Jo74C7ltSrHJc?=
 =?us-ascii?Q?fAtEkjY85hYqhA6fSnMzCrDolf+yX4XX7T5MsBfjABT7cGycnyKvUiorNGwq?=
 =?us-ascii?Q?084SkAQjjsr6/5HcAl42Dqj4BoWU+Z3zqvd014TG0UtEtqbScdn0AFOnkCyf?=
 =?us-ascii?Q?8ZKXOoM0ltPWd+tTx7JzlTKLQWaLcdtDx+xlVGn7GBoqdC2ZSifzfew28gni?=
 =?us-ascii?Q?SWNtweezlBdUa1g0SQ0WecNwGlAZ+ZWU+F5Jm2Jv1/g+qs5R1sc7GCMgbMT0?=
 =?us-ascii?Q?eBmtxPdsWBqm/tghgbqSTsrfUGaEhL+18QXy/D+FV6P/zFnopOJG2AhcCny2?=
 =?us-ascii?Q?etCqG5obAHS6K0HaretJfSW/qwh5XwbrqJzUgKGZYNpgWeJUdoOOTvtVcDfe?=
 =?us-ascii?Q?8rCbXIV86iq1cFqVsmkVoEEwymn8O8ZhQKKDF4feKyE4xP4wn4yTOrkmaJsp?=
 =?us-ascii?Q?CYXkdc/9T95SfEMbuHrQuO72Zo6KHl8fdEL/IzbIP1HbVVuXDfSGpi3t3VbQ?=
 =?us-ascii?Q?Tv8x5HTtdfJEsMlmXiUsiw09ThwhI6ihOh1clGWFSiPMhhlYEwZ982TgvvMH?=
 =?us-ascii?Q?FoQ9JZyVY8LSkg7VqNTevsC5TrHA22OeYNDAIY3f/PGgm1jCQmRcNSBa8af9?=
 =?us-ascii?Q?IV0Z+jeo/lwVFV9hnLZKpv1WQ5jxL2tBB8bE5VJ6BdU00fGvSS8hJp3Luznd?=
 =?us-ascii?Q?H7J6q74P7wk2ZGW8nyNDpy7nhM8Gnumtcd1+xuzFddHSBExex5NsWs5vd+7d?=
 =?us-ascii?Q?UX6nLavq6wtS/DVOVX92KKFXZYx73IlkBYmD4mviryJD56bCljP0dZsjc6PQ?=
 =?us-ascii?Q?DfLO8iAuDkI2ym4pRPSu2vh/hbJw7jNLamfV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 03:39:48.2910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77d1e13-26e0-4727-61fc-08ddf59bda11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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

to resolve the race

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 27 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  6 +++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 127927b16ee2..cefb82ea1981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -194,6 +194,7 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev);
 #if defined(CONFIG_DEBUG_FS)
 int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
 #endif
+void kfd_process_wq_flush(void);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
 struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 1083db8cea2e..e12a28074b07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -23,6 +23,8 @@
 #include "amdgpu.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_drv.h"
+#include "kfd_priv.h"
+#include "kfd_device_queue_manager.h"
 
 #include <drm/drm_drv.h>
 #include "../amdxcp/amdgpu_xcp_drv.h"
@@ -673,8 +675,31 @@ int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 	 * Stop user queues and threads, and make sure GPU is empty of work.
 	 */
 
-	if (flags & AMDGPU_XCP_OPS_KFD)
+	if (flags & AMDGPU_XCP_OPS_KFD) {
+		int i;
+		struct kfd_node *knode;
+		struct amdgpu_device *adev = xcp_mgr->adev;
+
+		if (!amdgpu_in_reset(adev)) {
+			/* If there still active proccesses or queues, return busy */
+			for (i = 0; i < adev->kfd.dev->num_nodes; i++) {
+				knode = adev->kfd.dev->nodes[i];
+				if (knode->dqm->active_queue_count > 0 ||
+						knode->dqm->processes_count > 0) {
+					pr_info("kfd process or queues still active: active_queue_count %d,"
+						"processes_count %d, partition switch abort\n",
+						knode->dqm->active_queue_count,
+						knode->dqm->processes_count);
+					return -EBUSY;
+				}
+			}
+
+			/* Flush process wq. Make sure all user queues and threads finished */
+			kfd_process_wq_flush();
+		}
+
 		amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d01ef5ac0766..21fe588ea559 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1547,6 +1547,7 @@ int kfd_send_exception_to_runtime(struct kfd_process *p,
 				unsigned int queue_id,
 				uint64_t error_reason);
 bool kfd_is_locked(struct kfd_dev *kfd);
+void kfd_process_wq_flush(void);
 
 /* Compute profile */
 void kfd_inc_compute_active(struct kfd_node *dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5be28c6c4f6a..d15583dfa0f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1196,6 +1196,12 @@ static void kfd_process_wq_release(struct work_struct *work)
 	kfree(p);
 }
 
+void kfd_process_wq_flush(void)
+{
+    /* expose flush work interface for partition switch */
+	flush_workqueue(kfd_process_wq);
+}
+
 static void kfd_process_ref_release(struct kref *ref)
 {
 	struct kfd_process *p = container_of(ref, struct kfd_process, ref);
-- 
2.43.0

