Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A27C35FF1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 01:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81DA10E252;
	Mon, 17 Mar 2025 01:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZ2pIo8k";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB3A10E252
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 01:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEJXy+oGZRCT31kd6uaBbDm3FD/Op7X6PF5vDSC/yM24Xw+YzkwJLezpwTVVWS9r/UNrPhm9TIXVa0jp74Hbbs9nzgbgPz5yFNYvD8KBvm9vgE3IU+bL4ygg+d6//oWreEatag0gRpdrmw4eR+YrMGKNoSMBM2SCozqTAkYwsphBYoUQJ6Sl2wdrblBeS2xWpLNauxOaRsyMS1C1LpIzyzEA2krJq26hs0ikOMYdsamQn11DuvL7BEsOkhze7dkzs07HhuXMMXM7ISAeHld7aXjOAcLykRzA51xOZ+9DJMjh385vBlcB+K/nku93ot4G/uvDqblgiFvXEaseTnDPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrFKUmQ1OMi0h6cz7CNvTJyiIKUryS6UkB5NX2xECNk=;
 b=G8ahdJjR6ubFOX5XqPlMN7+mA8f4RPV8U7KEDNefiKI+1I1ZxfGCoBvG4ldYLWpdNvYyCWNFho9yvvfPc+jab5Cvh67GYCoEBPf/CJgXLtoK1MEQKCZ7Qq1bzWc1PG4Aq1D6Fz2H9jUK5l+LA3yh22Tmh30vIBu9qOqt8kiLvYrkW186LqQTZm6IRjnX0GbZ9CHRFdVP3eKXFxYtsg9aDpA4cNralCAkJQrI3OsSjgx/8GgVs3rwkJS6dj/eTe917bTD+Y3eoHhWXX7ppyhlxSXQ5HkuYeDddW/Ciphy+bDEY1B93C6QdXKsz8SytTpHad/F2JXxXpCvehj7UvbAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrFKUmQ1OMi0h6cz7CNvTJyiIKUryS6UkB5NX2xECNk=;
 b=YZ2pIo8kdXIfxHrjJWI1URgXaNcXdnNOUjb3o7JAydXctR0SegdUSMzJRkfmmzGaJFRdq+OfsKOuMUUQ294xyJPEm6tINIHfJXoGX3xTR6aZfNUlS70Q71gQ6Fd/OSwPwDkQMCcvP5/gZwALNjMgN2vUZpddIUshBz/jTL45ZXI=
Received: from SN7PR04CA0070.namprd04.prod.outlook.com (2603:10b6:806:121::15)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 01:22:23 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::d4) by SN7PR04CA0070.outlook.office365.com
 (2603:10b6:806:121::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 01:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 01:22:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Mar 2025 20:22:21 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Implement WQ_MEM_RECLAIM workqueue for Process
 Isolation
Date: Mon, 17 Mar 2025 06:52:05 +0530
Message-ID: <20250317012205.2304294-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 107b5dec-25ca-47ec-e591-08dd64f22b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZC8zZ2ZjQy9MbFhPTzg3aFZCayt3Ti9uWUpCVzJJRFhyZjJzWHhScGxOSWoz?=
 =?utf-8?B?Zm5ad0g3QjZOYXM0TExRMGNYMklBem5ITm9xQzBGR2lGaEVKTGtWWXBYYUxt?=
 =?utf-8?B?VFBWa3hmcjBmaDVtcUl6QWt3Rk9OT1FKZ2dZOGJSNkRTZWVLMVlEZi9mdVFh?=
 =?utf-8?B?M2FiWXhPajFCcEcwMlZhb2dMa2xoZ2EvclBKV1ZhY2RSV0tXUWFhWUt3Y2dY?=
 =?utf-8?B?WDByVWJBS1lubWtvcTVyVmkyQnJhWEhCcUYxU09vL1A4ZzB6ZEJiNkQ4bmFh?=
 =?utf-8?B?djhTUzdiNEZpZ1VlNFJvcW9RQkZLeDNKMU16VU9Ua1B1M0NKd1BDTDdyOHdn?=
 =?utf-8?B?TXJsNUtsbHBDTXRvb25mL0VsOTNLYW42ZXRrTFZOaDVraXRSNHFDU3RCWTli?=
 =?utf-8?B?Z2QxY243cEZYanRqTExGdnFjd0pub3c2MzVZOXZ3NzQ1c1VYd0dhNmRTWnow?=
 =?utf-8?B?c2NLdm9CY1Rab0NDZkVaODQxSWc5ODBVSmxxVXdDU0JUamw2UDYrcEs3bFFD?=
 =?utf-8?B?Yzh4ZUh1TCtWL1ZWdTkvUzlXVm9XYkdENDhCSUM0VHl0bGN6YlF0TnRBK1N3?=
 =?utf-8?B?Rk1BVS9tY0FRd2tORmh3R2JqbCtoTTlrQUxKK2YvT1BnaGh5cjYwb3V4NE1S?=
 =?utf-8?B?ekYxUVV5VWlqRkN2NWg3ZEFYd0R2SXIyQmI0OGp0bDBvSzgrTHJpRVdxbVh6?=
 =?utf-8?B?WDY5a2hxWGtvRDUvaWc5MU1sckRod25tQmVVY0NuVThUTEVpejd1UndOMGNQ?=
 =?utf-8?B?OWxzdnBkYm1CVXdrTmZHVHE4QWZOL2FQcFAwK1M1TXN3emNWMXUxbVNvUm9w?=
 =?utf-8?B?TmJwNXdqdFE2djNJQ1dPaEN2NTdDbDVxRDd1OXR0VTBGNmR6c3VNZERBdW5S?=
 =?utf-8?B?bUJLKzZENnZia1ladWg2NVJNb3NxWVBZMm0yM2E2S0g3aXEvcCtsQTZCR0U1?=
 =?utf-8?B?ZDgxVWxPS05pWWtVWUozaXJqemhNOWdBNVJhSWR0Y3ZYMW9GUWZjYUhHazcv?=
 =?utf-8?B?UHJOQVZvMmRzMkx3dVlwUEUrTFA1YUNNSWh2T0RWTVBaVGFkYXNqTDZ1eUxK?=
 =?utf-8?B?RVorSzZGYlUxUEU5WDNRTFNrWHh2TnZ1YVJLRm15WTc1emd2bjRydDQ0dzVx?=
 =?utf-8?B?eVdhZ1d2Z3dVeGxjd0krbEdTQk1YZXRXK1JGWU5ZZjR0ejhPRXl1eUdITmpM?=
 =?utf-8?B?bk5KTU5Mbms2cElIZS92UFJjVERRU3V3K1lXTmluWlNaM0MzZi9taWlubkg1?=
 =?utf-8?B?dTFKeWlLZ1JPQzlvMHhGd3ZjRG9DMDVhaURyOHBENWdEMXprcUtVQngvTUxB?=
 =?utf-8?B?OXB6MDk2SXRzZ2dPSUlYRThXNlMvWXphcnhjUUZyNVgwT0Z3OFhKTjBCdGNn?=
 =?utf-8?B?YWl4T2pKeE50dENMU0FxanFFc1JMeUFjVHRQU2hJTForWVVqekNWa0Q5VSt3?=
 =?utf-8?B?Y3JsR3dFZGFaYjRwUE5raEZYNnZmdVhCUk4wa1dmRSszcEV0b2RlTFJ1ZDIv?=
 =?utf-8?B?NW0ycUtscVlrUDhEeGh3K0lHeHZKTTB2dENTc29CcDNaajU0dVprci9rWlBW?=
 =?utf-8?B?dVF4UW5XUFpBcXdrZ09scndEcEVmZlpvNW0wSkMwaTFvYkhodmxuRmVXUVhJ?=
 =?utf-8?B?YnE4TjVpVHZoeDdUSW0xMXJ2WFMyQllZd0hFZC9lZE9MdDNHMmxMcno5bGYz?=
 =?utf-8?B?NWFHbXNZUzgrV05BTVkwY2RPc09QcmJidWVlNFpUSWswc0pjb1Evd3gvUHFF?=
 =?utf-8?B?ZFBMeXd4U0wvT0MwSEwwWnY3RE0yZEN6Ym50Q2JjekpDbkdRUlVTeDVCKzhX?=
 =?utf-8?B?ak83eERDKzZRK25FT1lPZTNzNUZzN3M5ZzkyYWRTVDFIc0grSGttd2J1YmhU?=
 =?utf-8?B?K2hwMUhPQmhLdUdUdWphQUZ0Smh1cmpzUHlXUW5TWnhYa3M2TCtDd2xleVR4?=
 =?utf-8?B?eVNvSFA0REc4ejVEMXRLNjFubmgwdmJGZ0FWTzBuSmhOaVg0T2FRbDNuOWZ3?=
 =?utf-8?Q?QexnHNvplO9KC31j7TGV+aDhCGTGkA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 01:22:23.0100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 107b5dec-25ca-47ec-e591-08dd64f22b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
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

The `amdgpu_enforce_isolation_wq` is allocated with the WQ_MEM_RECLAIM
flag to mitigate workqueue flushing related to memory reclamation & to
ensure proper memory handling during deferred work execution.

Fixes the below:

[ 2333.852549] workqueue: WQ_MEM_RECLAIM gfx_0.0.0:drm_sched_run_job_work [=
gpu_sched] is flushing !WQ_MEM_RECLAIM events:amdgpu_gfx_enforce_isolation_=
handler [amdgpu]
[ 2333.853008] WARNING: CPU: 10 PID: 6250 at kernel/workqueue.c:3704 check_=
flush_dependency+0x124/0x130
[ 2333.853020] Modules linked in: amdgpu(OE) amdxcp drm_exec gpu_sched drm_=
buddy drm_ttm_helper ttm drm_suballoc_helper drm_client_lib drm_display_hel=
per cec rc_core drm_kms_helper rfcomm nf_conntrack_netlink xfrm_user xfrm_a=
lgo xt_addrtype br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJ=
ECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_nat nf_conntrack n=
f_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c nfnetlink bridge stp llc o=
verlay cmac algif_hash algif_skcipher af_alg bnep intel_rapl_msr amd_atl in=
tel_rapl_common snd_hda_codec_realtek binfmt_misc snd_hda_codec_generic snd=
_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd=
_intel_sdw_acpi edac_mce_amd snd_hda_codec snd_hda_core snd_hwdep kvm_amd s=
nd_pcm kvm iwlmvm crct10dif_pclmul snd_seq_midi polyval_clmulni nls_iso8859=
_1 snd_seq_midi_event mac80211 polyval_generic snd_rawmidi ghash_clmulni_in=
tel libarc4 sha512_ssse3 joydev sha256_ssse3 snd_seq btusb sha1_ssse3 snd_s=
eq_device aesni_intel input_leds btrtl crypto_simd cryptd
[ 2333.853178]  btintel snd_timer iwlwifi rapl btbcm btmtk gigabyte_wmi mxm=
_wmi snd wmi_bmof k10temp bluetooth ccp cfg80211 soundcore mac_hid sch_fq_c=
odel msr parport_pc nfsd ppdev lp parport auth_rpcgss nfs_acl drm lockd gra=
ce efi_pstore sunrpc ip_tables x_tables autofs4 hid_generic crc32_pclmul nv=
me i2c_piix4 usbhid i2c_smbus hid nvme_core ahci igb libahci dca i2c_algo_b=
it video wmi
[ 2333.853274] CPU: 10 UID: 0 PID: 6250 Comm: kworker/u48:2 Tainted: G     =
U  W  OE      6.12.0-amdrelease6dot4forleftoverlocals #27
[ 2333.853282] Tainted: [U]=3DUSER, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNS=
IGNED_MODULE
[ 2333.853286] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS PRO =
WIFI/X570 AORUS PRO WIFI, BIOS F36a 02/16/2022
[ 2333.853291] Workqueue: gfx_0.0.0 drm_sched_run_job_work [gpu_sched]
[ 2333.853302] RIP: 0010:check_flush_dependency+0x124/0x130
[ 2333.853307] Code: 55 18 4d 89 e0 48 8d 8b 90 01 00 00 48 c7 c7 10 98 3e =
8e c6 05 9e 30 7b 02 01 48 8b 70 08 48 81 c6 90 01 00 00 e8 9c 21 fd ff <0f=
> 0b e9 ff fe ff ff e9 98 d9 0c 01 90 90 90 90 90 90 90 90 90 90
[ 2333.853313] RSP: 0018:ffff9fdd82c07ac0 EFLAGS: 00010086
[ 2333.853319] RAX: 0000000000000000 RBX: ffff89b840050e00 RCX: 00000000000=
00027
[ 2333.853323] RDX: ffff89bb6dbf1a88 RSI: 0000000000000001 RDI: ffff89bb6db=
f1a80
[ 2333.853327] RBP: ffff9fdd82c07ae8 R08: 0000000000000003 R09: 00000000000=
00001
[ 2333.853331] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc18=
64470
[ 2333.853335] R13: ffff89b856e58d80 R14: 0000000000000000 R15: ffff89bb6d8=
08900
[ 2333.853340] FS:  0000000000000000(0000) GS:ffff89bb6da00000(0000) knlGS:=
0000000000000000
[ 2333.853344] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2333.853348] CR2: 00005613aff86098 CR3: 0000000337e5c000 CR4: 00000000003=
50ef0
[ 2333.853353] Call Trace:
[ 2333.853358]  <TASK>
[ 2333.853365]  ? show_regs+0x69/0x80
[ 2333.853373]  ? __warn+0x93/0x1a0
[ 2333.853382]  ? check_flush_dependency+0x124/0x130
[ 2333.853389]  ? report_bug+0x18f/0x1a0
[ 2333.853399]  ? handle_bug+0x63/0xa0
[ 2333.853407]  ? exc_invalid_op+0x19/0x70
[ 2333.853414]  ? asm_exc_invalid_op+0x1b/0x20
[ 2333.853422]  ? __pfx_amdgpu_gfx_enforce_isolation_handler+0x10/0x10 [amd=
gpu]
[ 2333.853749]  ? check_flush_dependency+0x124/0x130
[ 2333.853759]  __flush_work+0xee/0x600
[ 2333.853766]  ? srso_return_thunk+0x5/0x5f
[ 2333.853778]  ? srso_return_thunk+0x5/0x5f
[ 2333.853783]  ? __mutex_lock+0xc08/0xe20
[ 2333.853792]  ? srso_return_thunk+0x5/0x5f
[ 2333.853798]  ? trace_hardirqs_on+0x1e/0xd0
[ 2333.853804]  ? srso_return_thunk+0x5/0x5f
[ 2333.853815]  cancel_delayed_work_sync+0x71/0x80
[ 2333.853823]  amdgpu_gfx_kfd_sch_ctrl+0x14f/0x290 [amdgpu]
[ 2333.854090]  amdgpu_gfx_enforce_isolation_ring_begin_use+0x1d4/0x3e0 [am=
dgpu]
[ 2333.854347]  ? cancel_delayed_work_sync+0x4f/0x80
[ 2333.854356]  gfx_v12_0_ring_begin_use+0x1b/0x30 [amdgpu]
[ 2333.854618]  amdgpu_ring_alloc+0x48/0x70 [amdgpu]
[ 2333.854854]  amdgpu_ib_schedule+0x16f/0x8a0 [amdgpu]
[ 2333.855098]  ? srso_return_thunk+0x5/0x5f
[ 2333.855105]  amdgpu_job_run+0xad/0x260 [amdgpu]
[ 2333.855405]  drm_sched_run_job_work+0x258/0x440 [gpu_sched]
[ 2333.855415]  process_one_work+0x21e/0x680
[ 2333.855427]  worker_thread+0x190/0x330
[ 2333.855434]  ? __pfx_worker_thread+0x10/0x10
[ 2333.855439]  kthread+0xe7/0x120
[ 2333.855444]  ? __pfx_kthread+0x10/0x10
[ 2333.855450]  ret_from_fork+0x3c/0x60
[ 2333.855455]  ? __pfx_kthread+0x10/0x10
[ 2333.855460]  ret_from_fork_asm+0x1a/0x30
[ 2333.855474]  </TASK>
[ 2333.855477] irq event stamp: 103430
[ 2333.855480] hardirqs last  enabled at (103429): [<ffffffff8da9237a>] irq=
entry_exit+0x3a/0x90
[ 2333.855486] hardirqs last disabled at (103430): [<ffffffff8da99e54>] __s=
chedule+0xf84/0x1b00
[ 2333.855490] softirqs last  enabled at (85926): [<ffffffff8c8fdabd>] __ir=
q_exit_rcu+0x7d/0xa0
[ 2333.855495] softirqs last disabled at (85919): [<ffffffff8c8fdabd>] __ir=
q_exit_rcu+0x7d/0xa0

Fixes: afefd6f24502 ("drm/amdgpu: Implement Enforce Isolation Handler for K=
GD/KFD serialization")
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 10 ++++++----
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 87062c1adcdf..cbd31c164f9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -123,6 +123,8 @@
=20
 #define GFX_SLICE_PERIOD_MS		250
=20
+extern struct workqueue_struct *amdgpu_enforce_isolation_wq;
+
 struct amdgpu_gpu_instance {
 	struct amdgpu_device		*adev;
 	int				mgpu_fan_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7ca2ebdd3c95..562304d703a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -105,6 +105,8 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_VBIOS_SKIP (1U << 0)
 #define AMDGPU_VBIOS_OPTIONAL (1U << 1)
=20
+struct workqueue_struct *amdgpu_enforce_isolation_wq;
+
 static const struct drm_driver amdgpu_kms_driver;
=20
 const char *amdgpu_asic_name[] =3D {
@@ -4323,6 +4325,14 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->gfx.enforce_isolation[i].xcp_id =3D i;
 	}
=20
+	/* Allocate the enforce isolation workqueue with WQ_MEM_RECLAIM */
+	amdgpu_enforce_isolation_wq =3D alloc_workqueue("amdgpu_enforce_isolation=
_wq",
+						      WQ_MEM_RECLAIM, 0);
+	if (!amdgpu_enforce_isolation_wq) {
+		dev_err(adev->dev, "Failed to allocate enforcement isolation workqueue\n=
");
+		return -ENOMEM;
+	}
+
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
=20
 	adev->gfx.gfx_off_req_count =3D 1;
@@ -4821,6 +4831,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *ade=
v)
 	if (adev->mman.discovery_bin)
 		amdgpu_discovery_fini(adev);
=20
+	/* Clean up the enforcement isolation workqueue */
+	if (amdgpu_enforce_isolation_wq) {
+		flush_workqueue(amdgpu_enforce_isolation_wq);
+		destroy_workqueue(amdgpu_enforce_isolation_wq);
+		amdgpu_enforce_isolation_wq =3D NULL;
+	}
+
 	amdgpu_reset_put_reset_domain(adev->reset_domain);
 	adev->reset_domain =3D NULL;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 984e6ff6e463..0dabffe395bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1938,8 +1938,9 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_dev=
ice *adev, u32 idx,
=20
 		if (adev->gfx.kfd_sch_req_count[idx] =3D=3D 0 &&
 		    adev->gfx.kfd_sch_inactive[idx]) {
-			schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
-					      msecs_to_jiffies(adev->gfx.enforce_isolation_time[idx]));
+			queue_delayed_work(amdgpu_enforce_isolation_wq,
+					   &adev->gfx.enforce_isolation[idx].work,
+					   msecs_to_jiffies(adev->gfx.enforce_isolation_time[idx]));
 		}
 	} else {
 		if (adev->gfx.kfd_sch_req_count[idx] =3D=3D 0) {
@@ -1995,8 +1996,9 @@ void amdgpu_gfx_enforce_isolation_handler(struct work=
_struct *work)
 	}
 	if (fences) {
 		/* we've already had our timeslice, so let's wrap this up */
-		schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
-				      msecs_to_jiffies(1));
+		queue_delayed_work(amdgpu_enforce_isolation_wq,
+				   &adev->gfx.enforce_isolation[idx].work,
+				   msecs_to_jiffies(1));
 	} else {
 		/* Tell KFD to resume the runqueue */
 		if (adev->kfd.init_complete) {
--=20
2.34.1

