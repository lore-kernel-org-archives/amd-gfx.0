Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34632C3F2D9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE1620716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FcI+Qv/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE1620716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF936EA79;
	Tue,  3 Mar 2020 23:27:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09A96EA79
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFGwJt14Qocn8ix0+23AoiSQR2V89rBLoaBF6OdbORHWI7Cq1PPqlVzjF6vqHTmZmPNdZAHn8mw9yR6HUoUEwh6fFIs+5ERwS18WBlY/XGGtHNKYc2jcyPe3c1RH0F/W88oBbO3JNOzAKg9puBg1lF474ZXpgk5b0XZZPmaHVQ4HdEQSI6iCo4k+PrQy4Tr5BbjQyes+iqIbjsDsA7abetpqgDWSpowOZvyCKB6yTyq+VzzXDGUeVd9sm4N3uPgKNS91yNlCi/NS5c7UqpDBruoJaki3TGYKSu/1p3v1Y1MYI/n8ZJ5vV+Dcwle9WtFJRjSAz/iuZyuxClg2DTjFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YMu+TWaCQgJun2zI561GfE8zDAcxvN5a74Np54FXkU=;
 b=MXyFMyiZj4AulENgLDBO8ASsT1mSnJz/mV2aLXYUrI/PpYOc740HuYJetd2uLDfaCMU/WO+vX+VrNGwzCFOlqrv2XRf1BBLd51ygh3RBo+nYHI6snPFa5wLG2eHkjrR+PsJwlPPnKOUuLgxvDfpFiwpHTlGr9hJEm6xUmJLyOdGYDRuUbK30XrLmSSJd9/3vXOROI55sfZ3Rv/4Bqv5SvstCaQuW9o/A6lTHCVEQYexFU7HdiSDMHDdQYlutBRAelP0NGaBG+uYdPJ+LLeAjytdwtTD3KcT4CLsdkxlIuzIfqhPItmBI/g3qpdy7FZb3aHYyZvbinI+DSm05r/L1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YMu+TWaCQgJun2zI561GfE8zDAcxvN5a74Np54FXkU=;
 b=FcI+Qv/NzdIYAa9/tekTqk7aG6gAQw6p9DEK99AnfvI3FNUaz42yRtZ8yuDeSNWwFwHEgSbTptI+Vkogk5jtStpwFM1HoTJuycEDG9eROYgxqemR83AFB3O/ZvJbOtzpflzx4YBmihwrBury8xCNbxi4WUqG/LVs+H1LsLCAvrc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 23:27:42 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/12] drm/amd/display: Stop if retimer is not available
Date: Tue,  3 Mar 2020 18:27:15 -0500
Message-Id: <20200303232718.351364-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:41 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b48283cc-0685-4b4d-05a6-08d7bfca7836
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24419EF098EED64D38ACC8A698E40@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(36756003)(6486002)(8936002)(52116002)(7696005)(81166006)(81156014)(316002)(4326008)(6916009)(5660300002)(186003)(66476007)(45080400002)(956004)(66946007)(1076003)(478600001)(30864003)(86362001)(2616005)(8676002)(6666004)(66556008)(26005)(16526019)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2441;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9KrXlwwHbDqhcL0GnWABu6ZYpHXSLuTSrrfGlAgTSQmoCTlQ0N7SG/0q2BvGcFz//2lLjBW7VjmpFJ/EHklUf//Arb8cLhyKcRbrvnHXikfwK/kl3u6OovS0FwN5y7wNGUX5umRZa+YTjtdVd23GENbUCiAhG8wTfWbal/E3fJiLI1x/PKPYqae1kZU/GAEj0EqWjgjeQz7hKXTm411J0/zqg4lV91PJFlXY1q+8hk9z8Gm/GWtIlX3N9xWwQ8qqeXsh2a6TNmaO9JbsVlbrRUeWGavLNc0vO503jHHLeuOvQVXkCGHzdRWglpqLPNpOju5hfORqOfx9nzUEzKvYKItAR64iNcmixekflkiZM28WLYPndJNzi8EXERPDyeHwHdtaH6Ai9hm2TTQgs0k0nhOOgISP+c2RrHnXJ+uXWKNYNI1kgTjrycDpVUUjee9
X-MS-Exchange-AntiSpam-MessageData: PLfieuXGWspMXlV7lzg2hXUT86xuaFSxnZ+EDn29q5hZ5/ANIMB2X6F4ba1sBi3rBEdrP2N8OUvdUYMLlbLr3EaY7RZwVQEiJUbShpok0zs+6d05I/4NEdKIZooQCxHM7oTNRYLEt8vXjq5sX/ptLA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48283cc-0685-4b4d-05a6-08d7bfca7836
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:41.9748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKIDgjhK54mw468vN/faPLKyxbR80W8hwsfA/vBAgMHi3O0p5oXVbU/ts9EvTWMefhlJpu5vr0oHYXF3f2lvzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Hersen Wu <hersenxs.wu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Raven provides retimer feature support that requires i2c interaction in
order to make it work well, all settings required for this configuration
are loaded from the Atom bios which include the i2c address. If the
retimer feature is not available, we should abort the attempt to set
this feature, otherwise, it makes the following line return
I2C_CHANNEL_OPERATION_NO_RESPONSE:

 i2c_success = i2c_write(pipe_ctx, slave_address, buffer, sizeof(buffer));
 ...
 if (!i2c_success)
   ASSERT(i2c_success);

This ends up causing problems with hotplugging HDMI displays on Raven,
and causes retimer settings to warn like so:

WARNING: CPU: 1 PID: 429 at
drivers/gpu/drm/amd/amdgpu/../dal/dc/core/dc_link.c:1998
write_i2c_retimer_setting+0xc2/0x3c0 [amdgpu] Modules linked in:
edac_mce_amd ccp kvm irqbypass binfmt_misc crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel snd_hda_codec_realtek snd_hda_codec_generic
ledtrig_audio snd_hda_codec_hdmi snd_hda_intel amdgpu(+) snd_hda_codec
snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event
snd_rawmidi aesni_intel snd_seq amd_iommu_v2 gpu_sched aes_x86_64
crypto_simd cryptd glue_helper snd_seq_device ttm drm_kms_helper
snd_timer eeepc_wmi wmi_bmof asus_wmi sparse_keymap drm mxm_wmi snd
k10temp fb_sys_fops syscopyarea sysfillrect sysimgblt soundcore joydev
input_leds mac_hid sch_fq_codel parport_pc ppdev lp parport ip_tables
x_tables autofs4 igb i2c_algo_bit hid_generic usbhid i2c_piix4 dca ahci
hid libahci video wmi gpio_amdpt gpio_generic CPU: 1 PID: 429 Comm:
systemd-udevd Tainted: G        W         5.2.0-rc1sept162019+ #1
Hardware name: System manufacturer System Product Name/ROG STRIX B450-F
GAMING, BIOS 2605 08/06/2019
RIP: 0010:write_i2c_retimer_setting+0xc2/0x3c0 [amdgpu]
Code: ff 0f b6 4d ce 44 0f b6 45 cf 44 0f b6 c8 45 89 cf 44 89 e2 48 c7
c6 f0 34 bc c0 bf 04 00 00 00 e8 63 b0 90 ff 45 84 ff 75 02 <0f> 0b 42
0f b6 04 73 8d 50 f6 80 fa 02 77 8c 3c 0a 0f 85 c8 00 00 RSP:
0018:ffffa99d02726fd0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffa99d02727035 RCX: 0000000000000006
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff976acc857440
RBP: ffffa99d02727018 R08: 0000000000000002 R09: 000000000002a600
R10: ffffe90610193680 R11: 00000000000005e3 R12: 000000000000005d
R13: ffff976ac4b201b8 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f14f99e1680(0000) GS:ffff976acc840000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdf212843b8 CR3: 0000000408906000 CR4: 00000000003406e0
Call Trace:
 core_link_enable_stream+0x626/0x680 [amdgpu]
 dce110_apply_ctx_to_hw+0x414/0x4e0 [amdgpu]
 dc_commit_state+0x331/0x5e0 [amdgpu]
 ? drm_calc_timestamping_constants+0xf9/0x150 [drm]
 amdgpu_dm_atomic_commit_tail+0x395/0x1e00 [amdgpu]
 ? dm_plane_helper_prepare_fb+0x20c/0x280 [amdgpu]
 commit_tail+0x42/0x70 [drm_kms_helper]
 drm_atomic_helper_commit+0x10c/0x120 [drm_kms_helper]
 amdgpu_dm_atomic_commit+0x95/0xa0 [amdgpu]
 drm_atomic_commit+0x4a/0x50 [drm]
 restore_fbdev_mode_atomic+0x1c0/0x1e0 [drm_kms_helper]
 restore_fbdev_mode+0x4c/0x160 [drm_kms_helper]
 ? _cond_resched+0x19/0x40
 drm_fb_helper_restore_fbdev_mode_unlocked+0x4e/0xa0 [drm_kms_helper]
 drm_fb_helper_set_par+0x2d/0x50 [drm_kms_helper]
 fbcon_init+0x471/0x630
 visual_init+0xd5/0x130
 do_bind_con_driver+0x20a/0x430
 do_take_over_console+0x7d/0x1b0
 do_fbcon_takeover+0x5c/0xb0
 fbcon_event_notify+0x6cd/0x8a0
 notifier_call_chain+0x4c/0x70
 blocking_notifier_call_chain+0x43/0x60
 fb_notifier_call_chain+0x1b/0x20
 register_framebuffer+0x254/0x360
 __drm_fb_helper_initial_config_and_unlock+0x2c5/0x510 [drm_kms_helper]
 drm_fb_helper_initial_config+0x35/0x40 [drm_kms_helper]
 amdgpu_fbdev_init+0xcd/0x100 [amdgpu]
 amdgpu_device_init+0x1156/0x1930 [amdgpu]
 amdgpu_driver_load_kms+0x8d/0x2e0 [amdgpu]
 drm_dev_register+0x12b/0x1c0 [drm]
 amdgpu_pci_probe+0xd3/0x160 [amdgpu]
 local_pci_probe+0x47/0xa0
 pci_device_probe+0x142/0x1b0
 really_probe+0xf5/0x3d0
 driver_probe_device+0x11b/0x130
 device_driver_attach+0x58/0x60
 __driver_attach+0xa3/0x140
 ? device_driver_attach+0x60/0x60
 ? device_driver_attach+0x60/0x60
 bus_for_each_dev+0x74/0xb0
 ? kmem_cache_alloc_trace+0x1a3/0x1c0
 driver_attach+0x1e/0x20
 bus_add_driver+0x147/0x220
 ? 0xffffffffc0cb9000
 driver_register+0x60/0x100
 ? 0xffffffffc0cb9000
 __pci_register_driver+0x5a/0x60
 amdgpu_init+0x74/0x83 [amdgpu]
 do_one_initcall+0x4a/0x1fa
 ? _cond_resched+0x19/0x40
 ? kmem_cache_alloc_trace+0x3f/0x1c0
 ? __vunmap+0x1cc/0x200
 do_init_module+0x5f/0x227
 load_module+0x2330/0x2b40
 __do_sys_finit_module+0xfc/0x120
 ? __do_sys_finit_module+0xfc/0x120
 __x64_sys_finit_module+0x1a/0x20
 do_syscall_64+0x5a/0x130
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f14f9500839
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
RSP: 002b:00007fff9bc4f5a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055afb5abce30 RCX: 00007f14f9500839
RDX: 0000000000000000 RSI: 000055afb5ace0f0 RDI: 0000000000000017
RBP: 000055afb5ace0f0 R08: 0000000000000000 R09: 000000000000000a
R10: 0000000000000017 R11: 0000000000000246 R12: 0000000000000000
R13: 000055afb5aad800 R14: 0000000000020000 R15: 0000000000000000
---[ end trace c286e96563966f08 ]---

This commit reworks the way that we handle i2c write for retimer in the
way that we abort this configuration if the feature is not available in
the device. For debug sake, we kept a simple log message in case the
retimer is not available.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 67 ++++++++-----------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 114f77759ebf..83df17a17271 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1765,8 +1765,7 @@ static void write_i2c_retimer_setting(
 				slave_address, buffer[0], buffer[1], i2c_success?1:0);
 
 			if (!i2c_success)
-				/* Write failure */
-				ASSERT(i2c_success);
+				goto i2c_write_fail;
 
 			/* Based on DP159 specs, APPLY_RX_TX_CHANGE bit in 0x0A
 			 * needs to be set to 1 on every 0xA-0xC write.
@@ -1784,8 +1783,7 @@ static void write_i2c_retimer_setting(
 						pipe_ctx->stream->link->ddc,
 						slave_address, &offset, 1, &value, 1);
 					if (!i2c_success)
-						/* Write failure */
-						ASSERT(i2c_success);
+						goto i2c_write_fail;
 				}
 
 				buffer[0] = offset;
@@ -1797,8 +1795,7 @@ static void write_i2c_retimer_setting(
 					offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 					slave_address, buffer[0], buffer[1], i2c_success?1:0);
 				if (!i2c_success)
-					/* Write failure */
-					ASSERT(i2c_success);
+					goto i2c_write_fail;
 			}
 		}
 	}
@@ -1818,8 +1815,7 @@ static void write_i2c_retimer_setting(
 					slave_address, buffer[0], buffer[1], i2c_success?1:0);
 
 				if (!i2c_success)
-					/* Write failure */
-					ASSERT(i2c_success);
+					goto i2c_write_fail;
 
 				/* Based on DP159 specs, APPLY_RX_TX_CHANGE bit in 0x0A
 				 * needs to be set to 1 on every 0xA-0xC write.
@@ -1837,8 +1833,7 @@ static void write_i2c_retimer_setting(
 								pipe_ctx->stream->link->ddc,
 								slave_address, &offset, 1, &value, 1);
 						if (!i2c_success)
-							/* Write failure */
-							ASSERT(i2c_success);
+							goto i2c_write_fail;
 					}
 
 					buffer[0] = offset;
@@ -1850,8 +1845,7 @@ static void write_i2c_retimer_setting(
 						offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 						slave_address, buffer[0], buffer[1], i2c_success?1:0);
 					if (!i2c_success)
-						/* Write failure */
-						ASSERT(i2c_success);
+						goto i2c_write_fail;
 				}
 			}
 		}
@@ -1869,8 +1863,7 @@ static void write_i2c_retimer_setting(
 				offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 				slave_address, buffer[0], buffer[1], i2c_success?1:0);
 		if (!i2c_success)
-			/* Write failure */
-			ASSERT(i2c_success);
+			goto i2c_write_fail;
 
 		/* Write offset 0x00 to 0x23 */
 		buffer[0] = 0x00;
@@ -1881,8 +1874,7 @@ static void write_i2c_retimer_setting(
 			offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 			slave_address, buffer[0], buffer[1], i2c_success?1:0);
 		if (!i2c_success)
-			/* Write failure */
-			ASSERT(i2c_success);
+			goto i2c_write_fail;
 
 		/* Write offset 0xff to 0x00 */
 		buffer[0] = 0xff;
@@ -1893,10 +1885,14 @@ static void write_i2c_retimer_setting(
 			offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 			slave_address, buffer[0], buffer[1], i2c_success?1:0);
 		if (!i2c_success)
-			/* Write failure */
-			ASSERT(i2c_success);
+			goto i2c_write_fail;
 
 	}
+
+	return;
+
+i2c_write_fail:
+	DC_LOG_DEBUG("Set retimer failed");
 }
 
 static void write_i2c_default_retimer_setting(
@@ -1921,8 +1917,7 @@ static void write_i2c_default_retimer_setting(
 		offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 		slave_address, buffer[0], buffer[1], i2c_success?1:0);
 	if (!i2c_success)
-		/* Write failure */
-		ASSERT(i2c_success);
+		goto i2c_write_fail;
 
 	/* Write offset 0x0A to 0x17 */
 	buffer[0] = 0x0A;
@@ -1933,8 +1928,7 @@ static void write_i2c_default_retimer_setting(
 		offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 		slave_address, buffer[0], buffer[1], i2c_success?1:0);
 	if (!i2c_success)
-		/* Write failure */
-		ASSERT(i2c_success);
+		goto i2c_write_fail;
 
 	/* Write offset 0x0B to 0xDA or 0xD8 */
 	buffer[0] = 0x0B;
@@ -1945,8 +1939,7 @@ static void write_i2c_default_retimer_setting(
 		offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 		slave_address, buffer[0], buffer[1], i2c_success?1:0);
 	if (!i2c_success)
-		/* Write failure */
-		ASSERT(i2c_success);
+		goto i2c_write_fail;
 
 	/* Write offset 0x0A to 0x17 */
 	buffer[0] = 0x0A;
@@ -1957,8 +1950,7 @@ static void write_i2c_default_retimer_setting(
 		offset = 0x%x, reg_val= 0x%x, i2c_success = %d\n",
 		slave_address, buffer[0], buffer[1], i2c_success?1:0);
 	if (!i2c_success)
-		/* Write failure */
-		ASSERT(i2c_success);
+		goto i2c_write_fail;
 
 	/* Write offset 0x0C to 0x1D or 0x91 */
 	buffer[0] = 0x0C;
@@ -1969,8 +1961,7 @@ static void write_i2c_default_retimer_setting(
 		offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 		slave_address, buffer[0], buffer[1], i2c_success?1:0);
 	if (!i2c_success)
-		/* Write failure */
-		ASSERT(i2c_success);
+		goto i2c_write_fail;
 
 	/* Write offset 0x0A to 0x17 */
 	buffer[0] = 0x0A;
@@ -1981,8 +1972,7 @@ static void write_i2c_default_retimer_setting(
 		offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 		slave_address, buffer[0], buffer[1], i2c_success?1:0);
 	if (!i2c_success)
-		/* Write failure */
-		ASSERT(i2c_success);
+		goto i2c_write_fail;
 
 
 	if (is_vga_mode) {
@@ -1997,8 +1987,7 @@ static void write_i2c_default_retimer_setting(
 			offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
 			slave_address, buffer[0], buffer[1], i2c_success?1:0);
 		if (!i2c_success)
-			/* Write failure */
-			ASSERT(i2c_success);
+			goto i2c_write_fail;
 
 		/* Write offset 0x00 to 0x23 */
 		buffer[0] = 0x00;
@@ -2009,8 +1998,7 @@ static void write_i2c_default_retimer_setting(
 			offset = 0x%x, reg_val= 0x%x, i2c_success = %d\n",
 			slave_address, buffer[0], buffer[1], i2c_success?1:0);
 		if (!i2c_success)
-			/* Write failure */
-			ASSERT(i2c_success);
+			goto i2c_write_fail;
 
 		/* Write offset 0xff to 0x00 */
 		buffer[0] = 0xff;
@@ -2021,9 +2009,13 @@ static void write_i2c_default_retimer_setting(
 			offset = 0x%x, reg_val= 0x%x, i2c_success = %d end here\n",
 			slave_address, buffer[0], buffer[1], i2c_success?1:0);
 		if (!i2c_success)
-			/* Write failure */
-			ASSERT(i2c_success);
+			goto i2c_write_fail;
 	}
+
+	return;
+
+i2c_write_fail:
+	DC_LOG_DEBUG("Set default retimer failed");
 }
 
 static void write_i2c_redriver_setting(
@@ -2052,8 +2044,7 @@ static void write_i2c_redriver_setting(
 		slave_address, buffer[3], buffer[4], buffer[5], buffer[6], i2c_success?1:0);
 
 	if (!i2c_success)
-		/* Write failure */
-		ASSERT(i2c_success);
+		DC_LOG_DEBUG("Set redriver failed");
 }
 
 static void disable_link(struct dc_link *link, enum signal_type signal)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
