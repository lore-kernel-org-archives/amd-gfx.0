Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286D7C3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62CE10E73A;
	Wed,  7 May 2025 02:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GjYRTC9+";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFC710E73A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDEGV0SclbvrUlaclH9ZIHh9SxtgKXEmZy4aq5G3GeWdtPea/WxB+LXpahK8hRbpK0djMc6gTLeZPXpLzJ2d2Y85tTku9A4PdjB9bYs5hJ7tkoftIq94NqCtHe44vNL5Cq5cYQSFODFCqnjS9roL9AsFWCb9oMY1NRtnJ/n1XB3txOllFLqmitTMqfht+J5umKhkReuJfDwQIpme0k6seDnVFK0ykGpiYBUnLg8n/x/PlbXVM1ip5sAnx4npJMe82cYFOpR5nuaMiatN5BWdsgE7ZxMq4xeVnj6ByykQkm2wNr5qirFlVS4JEeAZCBQtsoGmzyXwCTrEtizulK8KJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBP1Sq2gtyLDMk2Kz7wQMgwtAZ4s2pSjRGnWEMCqLKg=;
 b=CrYlFGCJZWGAihZDgr9AUWSuSv39Sirv4zSDRlUYtP8odJqNwoGOZ18sll1edSV9ZzZ/Flu3pfvpfz8j5Qxt3g83odCtM1jpXj2STma77IA9OEghOrjPGdAJk/Ugt5+JL7oQ9evN6pho0FJQQUkaV5f9CBYZQpcqYyxxWE1LxVOJBY+iVl3gKF2As0GeN+Zi/ex/M0VWJzlreMsFjT54UeYhViAbgl471m21jdM3e3+xFrJHZuR/cLraKNBy+jHK8svBSLWBpN/GgmOSc1bcxrlAQETXPQheTvZ5k1GG5QhSZGoRHMCABjPxxoYHPSpAj5hnLIMnHjG+nGomAhX8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBP1Sq2gtyLDMk2Kz7wQMgwtAZ4s2pSjRGnWEMCqLKg=;
 b=GjYRTC9+ogtCrSSCcy/PdnFbuKPokuj6HuQ4ywYWzX0o0BfFnOSxb8hwaF2Pi3TWYezTYeXHAS79wnatpW3T8TyaXBmM5vH4fY5S5DMyl3cxPfR16/dmVp73ck5AJeXZLjmfarc44jGADMTKxzmZsRtH9TWb8ApIKPi0x4gQbi8=
Received: from SJ0PR05CA0150.namprd05.prod.outlook.com (2603:10b6:a03:33d::35)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 02:43:40 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::dd) by SJ0PR05CA0150.outlook.office365.com
 (2603:10b6:a03:33d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.17 via Frontend Transport; Wed,
 7 May 2025 02:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:38 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:35 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Austin
 Zheng" <austin.zheng@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 07/14] drm/amd/display: check stream id dml21 wrapper to get
 plane_id
Date: Wed, 7 May 2025 10:34:51 +0800
Message-ID: <20250507024242.1928299-8-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: f2aea103-e817-434f-d0a3-08dd8d10f96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mvQSMdSPLVh9Q3YEmQnMzwksEbarJZl63qpwRsUbmGyOkv8tPdct1w2aSA1/?=
 =?us-ascii?Q?7y7MjQ78oZyx1kPuZCNeG0ID7QB3a8l1BCvgEsp83L2yiotkAXmV6Pn788C3?=
 =?us-ascii?Q?sz7WhhItL3PLF8KnD35QfOim+EYv/SU5juT57OX/qM8C149IgzkMeLjaavam?=
 =?us-ascii?Q?owYcFmL/5R41NplmMngyBjdb3YPC+5bYGt3dfC5l8HcIYYuwZ7MttrfuRjoY?=
 =?us-ascii?Q?FTS9TWGtTv+5lnuLZdrp9PKgFI29d+vZmdUhVZ848BacgPV2aU7SYHIMG/K4?=
 =?us-ascii?Q?i3UWXZo8X0DZTlNfSN4El7ua61aeFtLd9H+F9kTnko6Be0yVZWeUnF2p3KpY?=
 =?us-ascii?Q?wSp7sMaWaHzj0ux6PvoVL5DcZjQA/GoZD8VjLgTujbvol7vU9aebwRa4d1Bd?=
 =?us-ascii?Q?wsJnYwzR+3jzJLpsEaBCbuOue8Yw3SAdzrU+InghpMc3sK8yFx8AEbU4N1Rw?=
 =?us-ascii?Q?uS0EHbmVuLdf9iRUIjkQrrNSdAxDR/egm5gQRoOnJOrcyNuZspU+smCAMjfX?=
 =?us-ascii?Q?/K0rsgjR5e6yfIsM6C/yj6IabBIlGUm2r5cte9cincZL7rEGNzVx7PZwpjRo?=
 =?us-ascii?Q?kTRWRWuGI6KGd+UMso6ikGVQWQjD5//GWCTCWLsBm/46OXg5Vb1NFguwI7UD?=
 =?us-ascii?Q?nrltvo/MWJMmb/bR8xzib4Rfhsn/x5pJgPq0rHik5aUNUEshWH73thGd7ue4?=
 =?us-ascii?Q?Hm4Wby5/dQdb9rqZs+VAmue8CjCyqlFHTNSmLUFr5/jeFom3Ol0176Cj8ygn?=
 =?us-ascii?Q?y2TKpjwboFP/YK4dwH1cXFKthVfYSuJgzpXZzO9KqPW0C7ohd8dh3ibXHXn4?=
 =?us-ascii?Q?9hfe257I+Q8npplT+ArdfxHTNUjc7CK7HMx/f2ev1sQJqAD6PwUkAAhKlorL?=
 =?us-ascii?Q?xS20jVPIfJ2A6bZSKxD/xkkp0xUUcPT6QYSFReqrO2lijyZkOijFoSYM9jtV?=
 =?us-ascii?Q?QtsoFoGonKsN+J5uccKLpI1NO3oVySU9SLDtEGgQtOeEl+lPnIDiwoKbD7w8?=
 =?us-ascii?Q?bsXNNXZjyRWV3PjJeIpLjamOW+scjSFDs9GTuLSpVFQAlOfg3mhC8+lVt52d?=
 =?us-ascii?Q?SZLsZEap2nBaOdkF8yQr1FKGyRxjEIOndI7xrEYp58P7LkcZLnr9X+JpxKoD?=
 =?us-ascii?Q?LSPPXDDhmCeXxw4Jrnf0Gn6hSAl2zDJUKce9pkh4ksCbLoUOVRLvx3tDSbRY?=
 =?us-ascii?Q?Eao/bjPEKbm+r606gUUsSAlgH6tNyiq1gntDA+TTD1SO3ZC3oeMhiaKpVxiM?=
 =?us-ascii?Q?FereIYBta6oJBTkh0SDoxgUJyEDSqWgoL0yKnJt///ThkA3jR3Cx3TZikpC3?=
 =?us-ascii?Q?qJCLq8SSG7Cewa7WAqsSfsB+rF3ShjQluI1Ibwdn2eQnQo6FtTwXrjupgPEP?=
 =?us-ascii?Q?sC9nmv1r1Az3KAwYAfXaO5OF5XCZVLkUsoyPz5kefK4BuBwhL04Flwj5D9n0?=
 =?us-ascii?Q?aJP6NQUhQfGvqZznTBEBX+w3mIZUJtyvZiSyNfmBUAwl6ZIY+NlO+ohvih72?=
 =?us-ascii?Q?Y3vP3BrHeesk945BSmooIWr4oHrH+iKyPJV/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:39.8241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aea103-e817-434f-d0a3-08dd8d10f96b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why & How]
Fix a false positive warning which occurs due to lack of correct checks
when querying plane_id in DML21. This fixes the warning when performing a
mode1 reset (cat /sys/kernel/debug/dri/1/amdgpu_gpu_recover):

[   35.751250] WARNING: CPU: 11 PID: 326 at /tmp/amd.PHpyAl7v/amd/amdgpu/..=
/display/dc/dml2/dml2_dc_resource_mgmt.c:91 dml2_map_dc_pipes+0x243d/0x3f40=
 [amdgpu]
[   35.751434] Modules linked in: amdgpu(OE) amddrm_ttm_helper(OE) amdttm(O=
E) amddrm_buddy(OE) amdxcp(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) drm=
_suballoc_helper drm_ttm_helper ttm drm_display_helper cec rc_core i2c_algo=
_bit rfcomm qrtr cmac algif_hash algif_skcipher af_alg bnep amd_atl intel_r=
apl_msr intel_rapl_common snd_hda_codec_hdmi snd_hda_intel edac_mce_amd snd=
_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec kvm_amd snd_hda_core snd_hwd=
ep snd_pcm kvm snd_seq_midi snd_seq_midi_event snd_rawmidi crct10dif_pclmul=
 polyval_clmulni polyval_generic btusb ghash_clmulni_intel sha256_ssse3 btr=
tl sha1_ssse3 snd_seq btintel aesni_intel btbcm btmtk snd_seq_device crypto=
_simd sunrpc cryptd bluetooth snd_timer ccp binfmt_misc rapl snd i2c_piix4 =
wmi_bmof gigabyte_wmi k10temp i2c_smbus soundcore gpio_amdpt mac_hid sch_fq=
_codel msr parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysfs ip_ta=
bles x_tables autofs4 hid_generic usbhid hid crc32_pclmul igc ahci xhci_pci=
 libahci xhci_pci_renesas video wmi
[   35.751501] CPU: 11 UID: 0 PID: 326 Comm: kworker/u64:9 Tainted: G      =
     OE      6.11.0-21-generic #21~24.04.1-Ubuntu
[   35.751504] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[   35.751505] Hardware name: Gigabyte Technology Co., Ltd. X670E AORUS PRO=
 X/X670E AORUS PRO X, BIOS F30 05/22/2024
[   35.751506] Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgp=
u]
[   35.751638] RIP: 0010:dml2_map_dc_pipes+0x243d/0x3f40 [amdgpu]
[   35.751794] Code: 6d 0c 00 00 8b 84 24 88 00 00 00 41 3b 44 9c 20 0f 84 =
fc 07 00 00 48 83 c3 01 48 83 fb 06 75 b3 4c 8b 64 24 68 4c 8b 6c 24 40 <0f=
> 0b b8 06 00 00 00 49 8b 94 24 a0 49 00 00 89 c3 83 f8 07 0f 87
[   35.751796] RSP: 0018:ffffbfa3805d7680 EFLAGS: 00010246
[   35.751798] RAX: 0000000000010000 RBX: 0000000000000006 RCX: 00000000000=
00000
[   35.751799] RDX: 0000000000000000 RSI: 0000000000000005 RDI: 00000000000=
00000
[   35.751800] RBP: ffffbfa3805d78f0 R08: 0000000000000000 R09: 00000000000=
00000
[   35.751801] R10: 0000000000000000 R11: 0000000000000000 R12: ffffbfa3832=
49000
[   35.751802] R13: ffffa0e68f280000 R14: ffffbfa383249658 R15: 00000000000=
00000
[   35.751803] FS:  0000000000000000(0000) GS:ffffa0edbe580000(0000) knlGS:=
0000000000000000
[   35.751804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.751805] CR2: 00005d847ef96c58 CR3: 000000041de3e000 CR4: 0000000000f=
50ef0
[   35.751806] PKRU: 55555554
[   35.751807] Call Trace:
[   35.751810]  <TASK>
[   35.751816]  ? show_regs+0x6c/0x80
[   35.751820]  ? __warn+0x88/0x140
[   35.751822]  ? dml2_map_dc_pipes+0x243d/0x3f40 [amdgpu]
[   35.751964]  ? report_bug+0x182/0x1b0
[   35.751969]  ? handle_bug+0x6e/0xb0
[   35.751972]  ? exc_invalid_op+0x18/0x80
[   35.751974]  ? asm_exc_invalid_op+0x1b/0x20
[   35.751978]  ? dml2_map_dc_pipes+0x243d/0x3f40 [amdgpu]
[   35.752117]  ? math_pow+0x48/0xa0 [amdgpu]
[   35.752256]  ? srso_alias_return_thunk+0x5/0xfbef5
[   35.752260]  ? math_pow+0x48/0xa0 [amdgpu]
[   35.752400]  ? srso_alias_return_thunk+0x5/0xfbef5
[   35.752403]  ? math_pow+0x11/0xa0 [amdgpu]
[   35.752524]  ? srso_alias_return_thunk+0x5/0xfbef5
[   35.752526]  ? core_dcn4_mode_programming+0xe4d/0x20d0 [amdgpu]
[   35.752663]  ? srso_alias_return_thunk+0x5/0xfbef5
[   35.752669]  dml21_validate+0x3d4/0x980 [amdgpu]

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dc/dml2/dml21/dml21_translation_helper.c  | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_he=
lper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper=
.c
index ed75319a07d5..199938311b32 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -916,7 +916,7 @@ static void populate_dml21_plane_config_from_plane_stat=
e(struct dml2_context *dm
 }
=20
 //TODO : Could be possibly moved to a common helper layer.
-static bool dml21_wrapper_get_plane_id(const struct dc_state *context, con=
st struct dc_plane_state *plane, unsigned int *plane_id)
+static bool dml21_wrapper_get_plane_id(const struct dc_state *context, uns=
igned int stream_id, const struct dc_plane_state *plane, unsigned int *plan=
e_id)
 {
 	int i, j;
=20
@@ -924,10 +924,12 @@ static bool dml21_wrapper_get_plane_id(const struct d=
c_state *context, const str
 		return false;
=20
 	for (i =3D 0; i < context->stream_count; i++) {
-		for (j =3D 0; j < context->stream_status[i].plane_count; j++) {
-			if (context->stream_status[i].plane_states[j] =3D=3D plane) {
-				*plane_id =3D (i << 16) | j;
-				return true;
+		if (context->streams[i]->stream_id =3D=3D stream_id) {
+			for (j =3D 0; j < context->stream_status[i].plane_count; j++) {
+				if (context->stream_status[i].plane_states[j] =3D=3D plane) {
+					*plane_id =3D (i << 16) | j;
+					return true;
+				}
 			}
 		}
 	}
@@ -950,14 +952,14 @@ static unsigned int map_stream_to_dml21_display_cfg(c=
onst struct dml2_context *d
 	return location;
 }
=20
-static unsigned int map_plane_to_dml21_display_cfg(const struct dml2_conte=
xt *dml_ctx,
+static unsigned int map_plane_to_dml21_display_cfg(const struct dml2_conte=
xt *dml_ctx, unsigned int stream_id,
 		const struct dc_plane_state *plane, const struct dc_state *context)
 {
 	unsigned int plane_id;
 	int i =3D 0;
 	int location =3D -1;
=20
-	if (!dml21_wrapper_get_plane_id(context, plane, &plane_id)) {
+	if (!dml21_wrapper_get_plane_id(context, stream_id, plane, &plane_id)) {
 		ASSERT(false);
 		return -1;
 	}
@@ -1043,7 +1045,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const st=
ruct dc *in_dc, struct dc_s
 			dml_dispcfg->plane_descriptors[disp_cfg_plane_location].stream_index =
=3D disp_cfg_stream_location;
 		} else {
 			for (plane_index =3D 0; plane_index < context->stream_status[stream_ind=
ex].plane_count; plane_index++) {
-				disp_cfg_plane_location =3D map_plane_to_dml21_display_cfg(dml_ctx, co=
ntext->stream_status[stream_index].plane_states[plane_index], context);
+				disp_cfg_plane_location =3D map_plane_to_dml21_display_cfg(dml_ctx, co=
ntext->streams[stream_index]->stream_id, context->stream_status[stream_inde=
x].plane_states[plane_index], context);
=20
 				if (disp_cfg_plane_location < 0)
 					disp_cfg_plane_location =3D dml_dispcfg->num_planes++;
@@ -1054,7 +1056,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const st=
ruct dc *in_dc, struct dc_s
 				populate_dml21_plane_config_from_plane_state(dml_ctx, &dml_dispcfg->pl=
ane_descriptors[disp_cfg_plane_location], context->stream_status[stream_ind=
ex].plane_states[plane_index], context, stream_index);
 				dml_dispcfg->plane_descriptors[disp_cfg_plane_location].stream_index =
=3D disp_cfg_stream_location;
=20
-				if (dml21_wrapper_get_plane_id(context, context->stream_status[stream_=
index].plane_states[plane_index], &dml_ctx->v21.dml_to_dc_pipe_mapping.disp=
_cfg_to_plane_id[disp_cfg_plane_location]))
+				if (dml21_wrapper_get_plane_id(context, context->streams[stream_index]=
->stream_id, context->stream_status[stream_index].plane_states[plane_index]=
, &dml_ctx->v21.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[disp_cfg_plane_=
location]))
 					dml_ctx->v21.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id_valid[disp_c=
fg_plane_location] =3D true;
=20
 				/* apply forced pstate policy */
--=20
2.43.0

