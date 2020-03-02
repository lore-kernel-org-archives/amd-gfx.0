Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DB2C3F2D7
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A674222C4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rkC3j5wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A674222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9106E5C6;
	Mon,  2 Mar 2020 16:48:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA176E7D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGMT9pgMk9lyAstbLTUaBKTQ0CnIwS3hDkqi9h0fwamcKfCAMiZWcttAOEyuLfHgMS5zB7HQEIi7XiFw/UfYW2HqoO+5eYIC2xwNq64QqZ+2mAL2paRXIcXgk5zWHZ44Aex+V5qUw5gk1BvRiYDWaauSTy8RWBVBZqV8I3oZTYP4iV/E8MNkaTod7xwI1YrmT47wk9GbrXp/v8vwtwMq1jkybDm/FWSIGeWQTNOoAqI5xdYwjn2n8U+kuwpm3Ra2iMA8dmTYgClOSroUT+1rE4if1MVlsH5yERVomTx5nrzD1GSf0rpsLFuJPdkXRVEhrUhoCqttSsHB9Cl0fUmRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yurmui4CZHWSMNEyvGtIdD8SizWgX4CFJFodEX8qUSY=;
 b=e8qj5SzWzcVaPoSO8z9fHJHsov4ebiIFDGZeKfsphPNoCYQI7GLGB0fHhX+xrOLg6CbabWWfS6FSC2UxdKZXiKiMn47+MTQd1/Mr/j6Eqy/8uf+n4AHd1/2rLlxCXV3Za9+5nMLWTaXXvnN9UNsvz0lk9AtpwUnqkLPbCCmlls0o/2ix2k8YV1kdKJmxxyTYk88dyKe9dGZ9hbTTwFUgvyv7SUnWCSd1MeclYTpzHRy8oPfBGefsTe1KbVE9Jnb4EfNUWw8dBpNta6oqP7dFNiXkvnf6h+TOQdMCTJedlbVD2XHkkGoBqL+WE6WZ4e2p8zIV79aKMVnLo0WFeTd0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yurmui4CZHWSMNEyvGtIdD8SizWgX4CFJFodEX8qUSY=;
 b=rkC3j5wufe2w8zz/Sx5KzqyIiunOIye8nmMTaurt8/QoiD5UlOUb+YPck1qofNoCvq1ifv1rekhVa+Ls3JRaGoNzuG5gG8iT/jsON/59Yq6cg9q6DTXl2Wav0QRtQDfvHMLsDTNWrTEf2bXuKAGJhAYKFv281UTB6AZ+G0Sgbg4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:48:10 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:10 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/22] drm/amd/display: Clear link settings on MST disable
 connector
Date: Mon,  2 Mar 2020 11:47:32 -0500
Message-Id: <20200302164736.89429-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:06 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ae0b109-ecbb-416a-a322-08d7bec97bdb
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:|MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2540070329B841304EE559DB98E70@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(316002)(7696005)(52116002)(8936002)(6486002)(86362001)(6666004)(36756003)(81166006)(81156014)(8676002)(1076003)(5660300002)(16526019)(2616005)(4326008)(45080400002)(2906002)(186003)(956004)(478600001)(6916009)(66556008)(66946007)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2540;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vh2OQZVRnVmvLGTU54bSX19m+vzvp4ofhj0qnrmTgbAbFWqam9353OI7zxxoctsaf6Hro8Y862fe78JdfC141j7g5OIzbruf685husY9AMr2WCcQ7yBs+8HVnc4k8Y5uGUKqelTolKza0IO61b9yFXLMFKZ1IBxpTHaL+ABBuHTJYhtc+VkKDYAyjfyDGr1gNFfcnEza3l/C3euFy06mH7VzN/d2t5cOk/D6RtuYdhduzAToBRtNR/ToOQzHxna76I9hw3DBtINA7yIKctCKHiBTnf/Yig+KWm4/d/VXV9evpl1HmCzivs9zfpaH/x9FjyYJOGki1emNOCs4FIFJZC4JSQD/XfUZCRRxlaXPCyVkfLrY+6vyVIq9eBjrppVq+HpyUvnmOT+6L5wiZ5gbhcu7+g/E+noJVvkcXrbMr1u6GfZ7mpA2oAGusehec0cF
X-MS-Exchange-AntiSpam-MessageData: +hYfOsfB9W80HbD5ITeJT/A8I6zAmb27ZC4+odzGODt1BNFEaIGT5qzdtHe31LVIoFliWVARZDKr9WbLw8tGBp4VGmQaacIpAU5p9S8CNDNkazH47io4uZns4ohuEh5uDjZNLTH5cskkBQZjsaiCnQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae0b109-ecbb-416a-a322-08d7bec97bdb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:07.4218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yc/OSAHWtmYR7t0pRRJZD3XsSqgm8+1Ixdh4AiqYqMHhkFXiQ5DWKvhimMvNvDd8Vd7uG+7q/smuB2uwmCy6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
If we have a single MST display and we disconnect it, we dont disable that
link. This causes the old link settings to still exist

Now on a replug for MST we think its a link loss and will try to reallocate
mst payload which will fail, throwing warning below.

[  129.374192] [drm] Failed to updateMST allocation table forpipe idx:0
[  129.374206] ------------[ cut here ]------------
[  129.374284] WARNING: CPU: 14 PID: 1710 at
drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/core/dc_link.c:3153
dc_link_allocate_mst_payload+0x1f7/0x220 [amdgpu]

[  129.374285] Modules linked in: amdgpu(OE) amd_iommu_v2 gpu_sched ttm
drm_kms_helper drm fb_sys_fops syscopyarea sysfillrect sysimgblt
binfmt_misc nls_iso8859_1 edac_mce_amd snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio kvm snd_hda_codec_hdmi snd_hda_intel
snd_intel_nhlt snd_hda_codec irqbypass snd_hda_core snd_hwdep snd_pcm
snd_seq_midi snd_seq_midi_event snd_rawmidi crct10dif_pclmul snd_seq
crc32_pclmul ghash_clmulni_intel snd_seq_device snd_timer snd aesni_intel
eeepc_wmi crypto_simd asus_wmi joydev cryptd sparse_keymap input_leds
soundcore video glue_helper wmi_bmof mxm_wmi k10temp ccp mac_hid
sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4
hid_generic usbhid hid igb i2c_algo_bit ahci dca i2c_piix4 libahci
gpio_amdpt wmi gpio_generic

[  129.374318] CPU: 14 PID: 1710 Comm: kworker/14:2 Tainted: G        W  OE     5.4.0-rc7bhawan+ #480
[  129.374318] Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 0515 03/30/2017
[  129.374397] Workqueue: events dm_irq_work_func [amdgpu]
[  129.374468] RIP: 0010:dc_link_allocate_mst_payload+0x1f7/0x220 [amdgpu]
[  129.374470] Code: 52 20 e8 1c 63 ad f4 48 8b 5d d0 65 48 33 1c 25 28 00
00 00 b8 01 00 00 00 75 16 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3
<0f> 0b e9 fa fe ff ff e8 ed 5b d6 f3 41 0f b6 b6 c4 02 00 00 48 c7
[  129.374471] RSP: 0018:ffff9f9141e7fcc0 EFLAGS: 00010246
[  129.374472] RAX: 0000000000000000 RBX: ffff91ef0762f800 RCX: 0000000000000000
[  129.374473] RDX: 0000000000000005 RSI: ffffffffc0c4a988 RDI: 0000000000000004
[  129.374474] RBP: ffff9f9141e7fd10 R08: 0000000000000005 R09: 0000000000000000
[  129.374475] R10: 0000000000000002 R11: 0000000000000001 R12: ffff91eebd510c00
[  129.374475] R13: ffff91eebd510e58 R14: ffff91ef052c01b8 R15: 0000000000000006
[  129.374476] FS:  0000000000000000(0000) GS:ffff91ef0ef80000(0000) knlGS:0000000000000000
[  129.374477] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  129.374478] CR2: 000055623ea01d50 CR3: 0000000408a8c000 CR4: 00000000003406e0
[  129.374479] Call Trace:
[  129.374550]  dc_link_reallocate_mst_payload+0x12e/0x150 [amdgpu]
[  129.374617]  dc_link_handle_hpd_rx_irq+0x6d4/0x6e0 [amdgpu]
[  129.374693]  handle_hpd_rx_irq+0x77/0x310 [amdgpu]
[  129.374768]  dm_irq_work_func+0x53/0x70 [amdgpu]
[  129.374774]  process_one_work+0x1fd/0x3f0
[  129.374776]  worker_thread+0x255/0x410
[  129.374778]  kthread+0x121/0x140
[  129.374780]  ? process_one_work+0x3f0/0x3f0
[  129.374781]  ? kthread_park+0x90/0x90
[  129.374785]  ret_from_fork+0x22/0x40

[How]
when we disable MST we should clear the cur link settings (lane_count=0 is
good enough). This will cause us to not reallocate payloads earlier than
expected and not throw the warning

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0ef0eeb16778..4837640530ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -454,6 +454,7 @@ static void dm_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 					   aconnector->dc_sink);
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
+		aconnector->dc_link->cur_link_settings.lane_count = 0;
 	}
 
 	drm_connector_unregister(connector);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
