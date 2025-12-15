Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841CBD41D74
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 08:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1650D10E0DA;
	Mon, 15 Dec 2025 08:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WagR4eLK";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5973310E0DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 08:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=to2mr8yffN2e45HM+fuj/okTaF81T38NJHshuZ9hD0Y8zG3wgDpLlpKVBLnHTSAiNXdfRr/aff9wh7/vsVHnNXRjSyJG3wETxABy/+fevjB3rTJoj4W+gtETruBgRTXVOdQ3yHc6qu/RbWOU6wypFLZdqnX9dbYxB23B5exp50kz2puuzwv0dHiFLG07t8Kkjb0LAK4PB6QbDFdK0FpAfUtt3YlL/hfZHhvNxrPuQl3d3CVgwWIKtIbhQDf9mFpA0lvNfkoAzSP5ctCFY7xK6dScKzDXqV55/x4oidBk8RBgMQBeEG7sVDsapP1h/V1h+a61GPnIUmEVP2qu3+NwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF5dKZaYLoUQWlfQvjSY2KaLoRBpcUAjozZNE2Su1RI=;
 b=VjQ2t2r6Mm1+BBxPKPIaQwWIbSrL+dB3qGfjNjJvwew+6HvE0yh4Lp4/f9iqJi/aZ41LvgILLRvxytZw0kYSorOh9JbOvZPWgRyn1CNcaCsO+Zegi38BH4lx4rhZI83weIq5Luz/2aiPdPig2MNcWmQZnYIwnm8FHdsQeDSJz/ecBsW+dVYKH78dAi1JVfRjIB+bOVe09U7Gb5oFSwsZbEfe4hQdDBjKbHE12870J+iBbsN62to47b5U7kgVeyBiuZAjFAmE1F7SITcy+0RCebU02/FE4UjE65AVEkTECuS+rSECi6oisz9xEffQbvGrJZ3as9aaLe4xpj25GUwdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF5dKZaYLoUQWlfQvjSY2KaLoRBpcUAjozZNE2Su1RI=;
 b=WagR4eLKJRH91xXWYZvnpvIPWoEjn/z5QNzu0Dn16eQc3vRXbAghLJpimOGF73L9MUdVBjtfLCzr04/ASC04dlzeONh2XSQ8ufmN5r5v4WhEwZTxtEOzdEwxv1Er6buRJV8l040N3qtaFCesyq1zx18jo8m/MEW5sGw1NbD11fo=
Received: from SJ0PR13CA0089.namprd13.prod.outlook.com (2603:10b6:a03:2c4::34)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:18:35 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::88) by SJ0PR13CA0089.outlook.office365.com
 (2603:10b6:a03:2c4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 08:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 08:18:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 02:18:34 -0600
Received: from chengjya-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 15 Dec 2025 02:18:27 -0600
From: Chengjun Yao <Chengjun.Yao@amd.com>
To: <Aurabindo.Pillai@amd.com>, <alexander.deucher@amd.com>,
 <tzimmermann@suse.de>, <amd-gfx@lists.freedesktop.org>
CC: Chengjun Yao <Chengjun.Yao@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/fb-helper: Fix vblank timeout during suspend/reset
Date: Mon, 15 Dec 2025 16:18:21 +0800
Message-ID: <20251215081822.432005-1-Chengjun.Yao@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c9a33d-f10d-49e1-6043-08de3bb28b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MmHexJ49EirDhl3/aR0ne44lpc+/SAEPZIWUBc7Y1F/KWuK4zwB2DMHRqLWt?=
 =?us-ascii?Q?zsqKETzOK/Xe4O+pBDc5JJjnGKFHrBf5vvp94suvUIISpkSTqOawnI2RzzUc?=
 =?us-ascii?Q?SCvFN1XASoqDipRI82dvve0ng5pUdYUpsUNUnvanxd0k9UwLbJB7gAyygnDq?=
 =?us-ascii?Q?z8WjWiiD/Se89Ms0RvUBFcg39XA/KA8JSu2F2c0N2ywT+o4xI+Xrr3VRMUmK?=
 =?us-ascii?Q?PEL7mbphZM+6A+RhhiRjjo+o07wsGH+QpKe09IPY421z4PiDWYx4f8ympuZ/?=
 =?us-ascii?Q?9UMR8wPciM4AC0yw2GkOhTFXYsIYQ8Y+EJfgaRu/aVk2TvID+YXINFR25iec?=
 =?us-ascii?Q?mxRS0WpwxgtSja2zdrX/EjRleQeDvaBeQFe54YpWvCQG739RGTrQm4Zc5ep8?=
 =?us-ascii?Q?s+Uz/3QYzAR3lDQjk2kV4PZo0ktaSBLa4/bBu9fvi/0P2lihyi/t/big9fGG?=
 =?us-ascii?Q?DGEhrbn/Y7lftbM3n9efEJnp1p3gYvyAJw/f2FYEWLk+2K10K4Z+TGYz2feF?=
 =?us-ascii?Q?czYUpX/7OI6P+nSE5of5oMmpgfHrI6WAT7vLOZVGK11RxdGJ5rRbB9jaUZnF?=
 =?us-ascii?Q?LijTG1VvMPa7d+r8uwTj560RqfC8z9NwfrVM9VelfPb1MLxQTmtvqLK1x+nQ?=
 =?us-ascii?Q?Bht3ZlHToBiDSvgvgliXedys5BLemDtQXOy9YC0SKQ7VT5tPSlFeWw1pO3rb?=
 =?us-ascii?Q?TruyNPAnEAI1iptlNmWk/1UkxAgtuyO/UNX+ygHbZO02p2dH2wC+fE2LMwNf?=
 =?us-ascii?Q?SLDl7QQlaYo/QzM7VLJQ4ByLaX1HwSa4BCPkslwVAB0eiHwHjaxg0/Ya/NSr?=
 =?us-ascii?Q?7U2FlFT3Oi2SUjmaSRAnSmDy4GbR0x1bMLUOuUk8xBhyGTXlsCDAIclVo1dk?=
 =?us-ascii?Q?c9f4pc1Xp8MfMrG4OtvBQYVeEE8TYylts0TMUsi3hV73uqSSFKkaknLqhXjn?=
 =?us-ascii?Q?EX73905XT0X9AE6v322/48AII2p4BaUidfn63x2V8tRj5U8oeLwCWZAMYPbo?=
 =?us-ascii?Q?O8YX2HEK518idzV+qji92zQuaWKvkxPvD3ej0uMuhxICwotE6xJsK/Ecc/+Y?=
 =?us-ascii?Q?uUz12Xrtgt98zP/3ikFyZ1bIDj0b8dzI3KW2T9svyNLJwtQTr4VzY5/SUEsv?=
 =?us-ascii?Q?9RwC1hHZjhrRZi0U9UF2L9bkS+UjmzoXAIEHaO7bKoVs8G0+q78hNCFju95H?=
 =?us-ascii?Q?wy03D9yLvo4CSBd8YG0wtDUu/rbxcNB+pNNWYsmc7fJ83c3rpZDy+vHKTof+?=
 =?us-ascii?Q?C5tQ1bpWGLUHRs0F/rcThDkogpMBzEcb6VhHhZQ5qfce92MOqf0G8sdJsbAk?=
 =?us-ascii?Q?udZF1/edJ+tJ1kZ0Tw+dXc5HsYD7+HeMySB42vG3A8lYIw88smGg+FyEN6TH?=
 =?us-ascii?Q?Cm58EZ1Rx1e2TQwNcU6ysp5yznc15nLuq7hkuX06VYKk/5/ZJ2jnimvZghtC?=
 =?us-ascii?Q?yrMeHhah4GC02r/TYJ3OE+uNSefH6q6RihfkdMiEAusaVjRvvRo/ZarEgmRA?=
 =?us-ascii?Q?XNQhNk1AWSWIQWfupzQu5W53URd4NYtAwEsays0Ej9sJ3q+mTedwdHlrL4rZ?=
 =?us-ascii?Q?U+WFumFoPfH6sbyhDzk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 08:18:35.5897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c9a33d-f10d-49e1-6043-08de3bb28b1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
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

During GPU reset, VBlank interrupts are disabled which causes
drm_fb_helper_fb_dirty() to wait for VBlank timeout. This will create
call traces like (seen on an RX7900 series dGPU):

[  101.313646] ------------[ cut here ]------------
[  101.313648] amdgpu 0000:03:00.0: [drm] vblank wait timed out on crtc 0
[  101.313657] WARNING: CPU: 0 PID: 461 at drivers/gpu/drm/drm_vblank.c:132=
0 drm_wait_one_vblank+0x176/0x220
[  101.313663] Modules linked in: amdgpu amdxcp drm_panel_backlight_quirks =
gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_dis=
play_helper cec rc_core i2c_algo_bit nf_conntrack_netlink xt_nat xt_tcpudp =
veth xt_conntrack xt_MASQUERADE bridge stp llc xfrm_user xfrm_algo xt_set i=
p_set nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_ad=
drtype nft_compat x_tables nf_tables overlay qrtr sunrpc snd_hda_codec_alc8=
82 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_atihdmi sn=
d_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg =
snd_intel_sdw_acpi snd_hwdep snd_pcm amd_atl intel_rapl_msr snd_seq_midi in=
tel_rapl_common asus_ec_sensors snd_seq_midi_event snd_rawmidi snd_seq eeep=
c_wmi snd_seq_device edac_mce_amd asus_wmi polyval_clmulni ghash_clmulni_in=
tel snd_timer platform_profile aesni_intel wmi_bmof sparse_keymap joydev sn=
d rapl input_leds i2c_piix4 soundcore ccp k10temp i2c_smbus gpio_amdpt mac_=
hid binfmt_misc sch_fq_codel msr parport_pc ppdev lp parport
[  101.313745]  efi_pstore nfnetlink dmi_sysfs autofs4 hid_generic usbhid h=
id r8169 realtek ahci libahci video wmi
[  101.313760] CPU: 0 UID: 0 PID: 461 Comm: kworker/0:2 Not tainted 6.18.0-=
rc6-174403b3b920 #1 PREEMPT(voluntary)
[  101.313763] Hardware name: ASUS System Product Name/TUF GAMING X670E-PLU=
S, BIOS 0821 11/15/2022
[  101.313765] Workqueue: events drm_fb_helper_damage_work
[  101.313769] RIP: 0010:drm_wait_one_vblank+0x176/0x220
[  101.313772] Code: 7c 24 08 4c 8b 77 50 4d 85 f6 0f 84 a1 00 00 00 e8 2f =
11 03 00 44 89 e9 4c 89 f2 48 c7 c7 d0 ad 0d a8 48 89 c6 e8 2a e0 4a ff <0f=
> 0b e9 f2 fe ff ff 48 85 ff 74 04 4c 8b 67 08 4d 8b 6c 24 50 4d
[  101.313774] RSP: 0018:ffffc99c00d47d68 EFLAGS: 00010246
[  101.313777] RAX: 0000000000000000 RBX: 000000000200038a RCX: 00000000000=
00000
[  101.313778] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[  101.313779] RBP: ffffc99c00d47dc0 R08: 0000000000000000 R09: 00000000000=
00000
[  101.313781] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8948c42=
80010
[  101.313782] R13: 0000000000000000 R14: ffff894883263a50 R15: ffff89488c3=
84830
[  101.313784] FS:  0000000000000000(0000) GS:ffff895424692000(0000) knlGS:=
0000000000000000
[  101.313785] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.313787] CR2: 00007773650ee200 CR3: 0000000588e40000 CR4: 0000000000f=
50ef0
[  101.313788] PKRU: 55555554
[  101.313790] Call Trace:
[  101.313791]  <TASK>
[  101.313795]  ? __pfx_autoremove_wake_function+0x10/0x10
[  101.313800]  drm_crtc_wait_one_vblank+0x17/0x30
[  101.313802]  drm_client_modeset_wait_for_vblank+0x61/0x80
[  101.313805]  drm_fb_helper_damage_work+0x46/0x1a0
[  101.313808]  process_one_work+0x1a1/0x3f0
[  101.313812]  worker_thread+0x2ba/0x3d0
[  101.313816]  kthread+0x107/0x220
[  101.313818]  ? __pfx_worker_thread+0x10/0x10
[  101.313821]  ? __pfx_kthread+0x10/0x10
[  101.313823]  ret_from_fork+0x202/0x230
[  101.313826]  ? __pfx_kthread+0x10/0x10
[  101.313828]  ret_from_fork_asm+0x1a/0x30
[  101.313834]  </TASK>
[  101.313835] ---[ end trace 0000000000000000 ]---

Cancel pending damage work synchronously before console_lock() to ensure
any in-flight framebuffer damage operations complete before suspension.

Also check for FBINFO_STATE_RUNNING in drm_fb_helper_damage_work() to
avoid executing damage work if it is rescheduled while the device is suspen=
ded.

Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helpe=
r.c
index c0343ec16a57..199cca1b5bdd 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -402,6 +402,9 @@ static void drm_fb_helper_damage_work(struct work_struc=
t *work)
 {
 	struct drm_fb_helper *helper =3D container_of(work, struct drm_fb_helper,=
 damage_work);
=20
+	if (helper->info->state !=3D FBINFO_STATE_RUNNING)
+		return;
+
 	drm_fb_helper_fb_dirty(helper);
 }
=20
@@ -794,6 +797,13 @@ void drm_fb_helper_set_suspend_unlocked(struct drm_fb_=
helper *fb_helper,
 		if (fb_helper->info->state !=3D FBINFO_STATE_RUNNING)
 			return;
=20
+		/*
+		 * Cancel pending damage work. During GPU reset, VBlank
+		 * interrupts are disabled and drm_fb_helper_fb_dirty()
+		 * would wait for VBlank timeout otherwise.
+		 */
+		cancel_work_sync(&fb_helper->damage_work);
+
 		console_lock();
=20
 	} else {
--=20
2.43.0

