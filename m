Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F305CF34D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57D510E9AC;
	Thu,  3 Oct 2024 23:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CDf1yJOl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476CF10E9AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgvBIBUjYbKrNTFT076YMOSOMWHbw/Aqc5sQif+PFdne6qfwJ3m6X2elMU4YOpnl0eayIQJP1BPVgW/FyDoKUk1mtnlNjVSjl3RLcSpRt+on2HMr6NbS+rdxZVxqvXJ348vr1UkfsCy7DnpiwpmIxiK7QRcWh/sIJyGEmeUbchiBsyb7U7tN8ux+NNmLCMZmQmsOQB6yz7j+UgGa1l9XRQMQPF1vGWfs0V/DfDsMqCS1JxwLwOKsbsqKSkeQCH3s2lWZtsbOagVW1VmsIBNaE6gmdVGCUk1Ev5GY1J8759Ich2pc3LPr06C+kI6Y6Au4wud9XJMb9rP3HpOAz7pcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7jGAj/dlOhDJ2E/OVpFXgjcYk9j7xD5fOde2gN9/pM=;
 b=B7bzQk35IWB/hCKZCnSLa3Q3b6Kh70xaASWGx3ZXJIM8ID9JG/R8mORN+k4KVkwWTxqKOYeRFBE11NwJUq737A38+hcjwaVurMPb/uLzHZ3MIPINNcMURlqA4et3GYe2od1RBKn+lyt+0uYqNH+Z2x6YB5TUKjH5ibOoLfa1poSYl5UFwB23iorQ6857ip4sVyyZvGVtagGoJWgperAjXWB8EjG5rgIGR0gfv4XMdFO4XosO1XcuFRcxuiGyP23s50FIFUyTlURBgIdrb87/wa1nRfLKlJFl2uWU5mUVGaVndHXRJLT9XQB9p3UfjgqMbRSsfQ+lkB61oMk6XQjYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7jGAj/dlOhDJ2E/OVpFXgjcYk9j7xD5fOde2gN9/pM=;
 b=CDf1yJOlXHdSpATt5fFs3cFdk24w6lgkVo0SuqD0+KgZe7nNgxufOEES8Pq3hmSzAKq+31UUYdn19MGPlt5KjFd1Pz/gG7B8q6M69kojYxcH7v+pygLLLvAlHM6e4au+5td2nfGzANQHWEzqkNr7+dSucfxR5RggYGXvAGbQAyY=
Received: from PH3PEPF0000409A.namprd05.prod.outlook.com (2603:10b6:518:1::46)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:36:02 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH3PEPF0000409A.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:01 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:58 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 14/26] drm/amd/display: fix a memleak issue when driver is
 removed
Date: Thu, 3 Oct 2024 17:33:32 -0600
Message-ID: <20241003233509.210919-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: c000c3f2-e8cc-4508-19ba-08dce4042415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HBXkOoOoVpWSQnvst79RkK7k+4E487sQ8+J4VJRzhP2bARbitwZUwU2Fcobk?=
 =?us-ascii?Q?vLC897lFQ0uc4MPsCkFOEIuMn9oPxi1B3xynNPSDWX3cDrMe5q/2zPdEujox?=
 =?us-ascii?Q?7ZI+K9nJ88urojzw9MuBWgE/PTnSSkoV+R6qrp8wKRUgKeL376/Cafh46EoN?=
 =?us-ascii?Q?ZIv0rH4I4xDrRO8/j6Z3LqCt4BLGLTaEE9dYKtskJ0HTMjvTZ3dZdq0T5T6i?=
 =?us-ascii?Q?Z6z1K4OEQpl5fCSeLvPoqBPOUe7aEeJ3CnOYFVkQ3ancKE0VXEePvlkwlB1F?=
 =?us-ascii?Q?nwOr493n0WfnlyBue18DYOjuyPJ82SdVnFqZ+zMdUyuqCl9/ZP0HzNX8MyBu?=
 =?us-ascii?Q?+pLB004a5Lgu9pC8iAOK4Ea+TzUlMi/uL5cKVRY1mcj3rwHypfMUivCJDICH?=
 =?us-ascii?Q?qe2tGL9GOJBGg3TWaeG0tb2oXSmf46HqCULs/GDsDrt131YGXAR1MrpE+mga?=
 =?us-ascii?Q?8r4ZMyL0jpH29wDHZ/EH4JLW97E2CPady5npHROEnxAuLzCNLfPPrnwbnf5q?=
 =?us-ascii?Q?70UAve0QVbKHKUNr5fQoGRNLWkx8oMZwdXc+3qNAInga1y9M8jV9fdblzEZ/?=
 =?us-ascii?Q?BpqiiPYu99ReTcJGjEKrERDnMReNcQg7Hl1Fbo86ntveX11/Fa8OKLwm47QW?=
 =?us-ascii?Q?Ei6s3JJMHE3YR774sBMzYXzR3v3s9p7Uuyojs3g7Ms+l/W7acmTDh+WYiNvh?=
 =?us-ascii?Q?u1JMp66Vo1oypfV73P7fd7Et4l2bFu4ZorxvJLnQvCpDfD3wQw1NCoKcsLnv?=
 =?us-ascii?Q?t1n3nCRGEnHShK8eFmD1muvL3GyTLBwKeeZZpW5+ueK2QBL0Wuzrg+BdkiXx?=
 =?us-ascii?Q?aAnr9VTBccFf1oakUDzu9S9HjqudcXSMd1o5wGnfFH3cQUD/82/MUNX/aQOf?=
 =?us-ascii?Q?U3YHGjgEh38Xhc720v71MKuJ86bUKmeaifGICc8AXcwMLCD6zKQ+M791BbcM?=
 =?us-ascii?Q?CznG/5XCC12K1bADsUsjlFhpQ+IMLFrZ4lL2MgtuhF8C6Qa7tcTPtYYgy1Xx?=
 =?us-ascii?Q?nKhxoLFoTJdXhtsqO0SYACUCdRmtM8jFM8nWiYvkagu234/0GbLb2k6Zu85u?=
 =?us-ascii?Q?QqRXNZ6CELsuQ26dhkFmiaTj52pIKDtY4win2QwvWYGvaM4SBKWt436X9d9f?=
 =?us-ascii?Q?HSRcHXq4SeM4aEAJAjUcgBj7V4IyXLlaeUXeECQMZxhcdL8kAcaocjeY1Hoz?=
 =?us-ascii?Q?rgVJKIlJnryaM3z6VMPGKRwKomN4A0YfvltllNFxiMGVfcsHqjQ47iNWn2Pn?=
 =?us-ascii?Q?vFjjKpohY2RchQmQ3CZkcm1xz3j/dor8zphch5ic/NZiNPOWPzckdzF7DWRH?=
 =?us-ascii?Q?eIqmbvPEOz1QhhJeUpUK6j24r8qnCGokdLaWwJ0mnNkgUYSWrMmxnv4rtOzJ?=
 =?us-ascii?Q?QNOCA3I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:01.4257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c000c3f2-e8cc-4508-19ba-08dce4042415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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

Running "modprobe amdgpu" the second time (followed by a modprobe -r
amdgpu) causes a call trace like:

[  845.212163] Memory manager not clean during takedown.
[  845.212170] WARNING: CPU: 4 PID: 2481 at drivers/gpu/drm/drm_mm.c:999 dr=
m_mm_takedown+0x2b/0x40
[  845.212177] Modules linked in: amdgpu(OE-) amddrm_ttm_helper(OE) amddrm_=
buddy(OE) amdxcp(OE) amd_sched(OE) drm_exec drm_suballoc_helper drm_display=
_helper i2c_algo_bit amdttm(OE) amdkcl(OE) cec rc_core sunrpc qrtr intel_ra=
pl_msr intel_rapl_common snd_hda_codec_hdmi edac_mce_amd snd_hda_intel snd_=
intel_dspcfg snd_intel_sdw_acpi snd_usb_audio snd_hda_codec snd_usbmidi_lib=
 kvm_amd snd_hda_core snd_ump mc snd_hwdep kvm snd_pcm snd_seq_midi snd_seq=
_midi_event irqbypass crct10dif_pclmul snd_rawmidi polyval_clmulni polyval_=
generic ghash_clmulni_intel sha256_ssse3 sha1_ssse3 snd_seq aesni_intel cry=
pto_simd snd_seq_device cryptd snd_timer mfd_aaeon asus_nb_wmi eeepc_wmi jo=
ydev asus_wmi snd ledtrig_audio sparse_keymap ccp wmi_bmof input_leds k10te=
mp i2c_piix4 platform_profile rapl soundcore gpio_amdpt mac_hid binfmt_misc=
 msr parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysfs ip_tables x=
_tables autofs4 hid_logitech_hidpp hid_logitech_dj hid_generic usbhid hid a=
hci xhci_pci igc crc32_pclmul libahci xhci_pci_renesas video
[  845.212284]  wmi [last unloaded: amddrm_ttm_helper(OE)]
[  845.212290] CPU: 4 PID: 2481 Comm: modprobe Tainted: G        W  OE     =
 6.8.0-31-generic #31-Ubuntu
[  845.212296] RIP: 0010:drm_mm_takedown+0x2b/0x40
[  845.212300] Code: 1f 44 00 00 48 8b 47 38 48 83 c7 38 48 39 f8 75 09 31 =
c0 31 ff e9 90 2e 86 00 55 48 c7 c7 d0 f6 8e 8a 48 89 e5 e8 f5 db 45 ff <0f=
> 0b 5d 31 c0 31 ff e9 74 2e 86 00 66 0f 1f 84 00 00 00 00 00 90
[  845.212302] RSP: 0018:ffffb11302127ae0 EFLAGS: 00010246
[  845.212305] RAX: 0000000000000000 RBX: ffff92aa5020fc08 RCX: 00000000000=
00000
[  845.212307] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[  845.212309] RBP: ffffb11302127ae0 R08: 0000000000000000 R09: 00000000000=
00000
[  845.212310] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00004
[  845.212312] R13: ffff92aa50200000 R14: ffff92aa5020fb10 R15: ffff92aa502=
0faa0
[  845.212313] FS:  0000707dd7c7c080(0000) GS:ffff92b93de00000(0000) knlGS:=
0000000000000000
[  845.212316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  845.212318] CR2: 00007d48b0aee200 CR3: 0000000115a58000 CR4: 0000000000f=
50ef0
[  845.212320] PKRU: 55555554
[  845.212321] Call Trace:
[  845.212323]  <TASK>
[  845.212328]  ? show_regs+0x6d/0x80
[  845.212333]  ? __warn+0x89/0x160
[  845.212339]  ? drm_mm_takedown+0x2b/0x40
[  845.212344]  ? report_bug+0x17e/0x1b0
[  845.212350]  ? handle_bug+0x51/0xa0
[  845.212355]  ? exc_invalid_op+0x18/0x80
[  845.212359]  ? asm_exc_invalid_op+0x1b/0x20
[  845.212366]  ? drm_mm_takedown+0x2b/0x40
[  845.212371]  amdgpu_gtt_mgr_fini+0xa9/0x130 [amdgpu]
[  845.212645]  amdgpu_ttm_fini+0x264/0x340 [amdgpu]
[  845.212770]  amdgpu_bo_fini+0x2e/0xc0 [amdgpu]
[  845.212894]  gmc_v12_0_sw_fini+0x2a/0x40 [amdgpu]
[  845.213036]  amdgpu_device_fini_sw+0x11a/0x590 [amdgpu]
[  845.213159]  amdgpu_driver_release_kms+0x16/0x40 [amdgpu]
[  845.213302]  devm_drm_dev_init_release+0x5e/0x90
[  845.213305]  devm_action_release+0x12/0x30
[  845.213308]  release_nodes+0x42/0xd0
[  845.213311]  devres_release_all+0x97/0xe0
[  845.213314]  device_unbind_cleanup+0x12/0x80
[  845.213317]  device_release_driver_internal+0x230/0x270
[  845.213319]  ? srso_alias_return_thunk+0x5/0xfbef5

This is caused by lost memory during early init phase. First time driver
is removed, memory is freed but when second time the driver is inserted,
VBIOS dmub is not active, since the PSP policy is to retain the driver
loaded version on subsequent warm boots. Hence, communication with VBIOS
DMUB fails.

Fix this by aborting further communication with vbios dmub and release
the memory immediately.

Fixes: 3284f08a2324 ("drm/amd/display: free bo used for dmub bounding box")
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 13 ++------
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7616d7a509b9..73c393d6c457 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1696,6 +1696,26 @@ dm_allocate_gpu_mem(
 	return da->cpu_ptr;
 }
=20
+void
+dm_free_gpu_mem(
+		struct amdgpu_device *adev,
+		enum dc_gpu_mem_alloc_type type,
+		void *pvMem)
+{
+	struct dal_allocation *da;
+
+	/* walk the da list in DM */
+	list_for_each_entry(da, &adev->dm.da_list, list) {
+		if (pvMem =3D=3D da->cpu_ptr) {
+			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
+			list_del(&da->list);
+			kfree(da);
+			break;
+		}
+	}
+
+}
+
 static enum dmub_status
 dm_dmub_send_vbios_gpint_command(struct amdgpu_device *adev,
 				 enum dmub_gpint_command command_code,
@@ -1762,16 +1782,20 @@ static struct dml2_soc_bb *dm_dmub_get_vbios_boundi=
ng_box(struct amdgpu_device *
 		/* Send the chunk */
 		ret =3D dm_dmub_send_vbios_gpint_command(adev, send_addrs[i], chunk, 300=
00);
 		if (ret !=3D DMUB_STATUS_OK)
-			/* No need to free bb here since it shall be done in dm_sw_fini() */
-			return NULL;
+			goto free_bb;
 	}
=20
 	/* Now ask DMUB to copy the bb */
 	ret =3D dm_dmub_send_vbios_gpint_command(adev, DMUB_GPINT__BB_COPY, 1, 20=
0000);
 	if (ret !=3D DMUB_STATUS_OK)
-		return NULL;
+		goto free_bb;
=20
 	return bb;
+
+free_bb:
+	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, (void *) bb);
+	return NULL;
+
 }
=20
 static enum dmub_ips_disable_type dm_get_default_ips_mode(
@@ -2541,11 +2565,11 @@ static int dm_sw_fini(struct amdgpu_ip_block *ip_bl=
ock)
 			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
 			list_del(&da->list);
 			kfree(da);
+			adev->dm.bb_from_dmub =3D NULL;
 			break;
 		}
 	}
=20
-	adev->dm.bb_from_dmub =3D NULL;
=20
 	kfree(adev->dm.dmub_fb_info);
 	adev->dm.dmub_fb_info =3D NULL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 15d4690c74d6..f5189b54a5cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1004,6 +1004,9 @@ void *dm_allocate_gpu_mem(struct amdgpu_device *adev,
 						  enum dc_gpu_mem_alloc_type type,
 						  size_t size,
 						  long long *addr);
+void dm_free_gpu_mem(struct amdgpu_device *adev,
+						  enum dc_gpu_mem_alloc_type type,
+						  void *addr);
=20
 bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
=20
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 069e0195e50a..3f4b6f140374 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1054,17 +1054,8 @@ void dm_helpers_free_gpu_mem(
 		void *pvMem)
 {
 	struct amdgpu_device *adev =3D ctx->driver_context;
-	struct dal_allocation *da;
-
-	/* walk the da list in DM */
-	list_for_each_entry(da, &adev->dm.da_list, list) {
-		if (pvMem =3D=3D da->cpu_ptr) {
-			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
-			list_del(&da->list);
-			kfree(da);
-			break;
-		}
-	}
+
+	dm_free_gpu_mem(adev, type, pvMem);
 }
=20
 bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool=
 enable)
--=20
2.45.2

