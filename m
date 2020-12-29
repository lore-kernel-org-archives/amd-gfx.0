Return-Path: <SRS0=yA2I=GB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2C4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Dec 2020 06:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19D0207AE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Dec 2020 06:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19D0207AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B60F892A7;
	Tue, 29 Dec 2020 06:21:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E028892A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Dec 2020 06:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Glw5ERmHmBjNM5zp6iMJbc+lC8c4RLIEdSi59CwyIZ/XCfjvN6WTQT373l20NpRhaJz3AF5W+2099+sDUStYpoQgUsCgGWD23vHkmd4JJ1+U90HLCOOJ1NA6fyVUif4SmaEDmjldDHoR5g0CzoHpvMgGUIDur3SYsXf0wTNwPiSWvRBHlnz8Vm3rwATtbxzgEU6eskXnbuv0QA/KdZEsXTmckC0pKM4uV+jbt6FtaVjRqXBM7MDRoyLlKeiS9XR0jwaVjGyaiLqOaooAKqGAAEoAOtWhOMCxg/GnskkE/4+eB4gBHBOm/Qu6iG/Z7w0KTfXDhgThet4GfuRRMY6RcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h4RuB19Aj+MW41PkY60tYtuYiLb0bO5QnjDO0hJOl0=;
 b=L97nisDnVTLoNhp+TtOzgmR7Coqv6UeGOMO83i5eY/uiOPNngAAIe+Txfv6/nxi6wpXN6jrVIasK61JcbwIbPoxI81VkAMx+uFyC7b+iWq3YSrH13mIWD3VtSY19bx7eF6bEmD2qGj5UlbCuv9WqCWotv5lHEqGC63PWRutev2XYlO06faDlq2jLXGC7Nj899v2d+pzoexnkvkMB2WtMjWuS0+O7VtyW3RblgDfyc84lf8/DLI0eEBYkmVMi/KvgjvrvbXziXTz1CHnKsnBkshboSmwH1SWLM0CdLNHMng2gmf+TOkq2vWu3GV7OguAK8Ch99Em2bTdaFpkgY+eu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h4RuB19Aj+MW41PkY60tYtuYiLb0bO5QnjDO0hJOl0=;
 b=bQmOIPgUTnL/LkQeC9nSUz/f5NTTLNSN+pmyTCuhL8pKZ7+gNmEOOl8f1Ce0Ar+bWArCO+azZptETulSYEe8lsE3X8kveeQBTaVGzGYUG+147Ia0jdMgdJ0pnxRfXBuQ3zvNSazpFGDyS8deJltmr/A2D7qJmjNb8zL5s7XK+LA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3280.namprd12.prod.outlook.com (2603:10b6:208:ad::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 06:21:18 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 06:21:18 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Harry.Wentland@amd.com
Subject: [PATCH] drm/amd/display: fix sysfs amdgpu_current_backlight_pwm NULL
 pointer issue
Date: Tue, 29 Dec 2020 14:21:01 +0800
Message-Id: <20201229062101.29900-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2P15301CA0022.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::32) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2P15301CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.2 via Frontend Transport; Tue, 29 Dec 2020 06:21:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a340b2cd-205a-4da4-4205-08d8abc1f413
X-MS-TrafficTypeDiagnostic: MN2PR12MB3280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32803D559A80FA01FC12F3B0A2D80@MN2PR12MB3280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dg/9SGxuAJKp7NlHAIhbFkyc7y6f9R50x806wZ7xtxfIKhml4c0qUclr1cfqFCagF+aTcjYtnTLDzctEe+eaO/ezSGOFzXgVci4Q5uPbNM2YqAJMb7ijhuggPwSCOdjVatggmkSyYRPjOHUhehWF3YImD3wZfnVQmKKBRGhFkvZmkS8qtxHeQHug0rFrNsjwZZUTQWa7hno+2+yIbBfc0/Rt6+DYzMSRC41+OwYius6OomMns+x8T1ZzLE4zEcAH4/LP8waUlDMIiD2e6Jvi8FUiC47AsYLHGEJnORLzz8N+6l6ryYiqt2L+nt3/xxiwpzCCHVnvhHHVNMt/2TGvRYkcqHRN6HKtor6AIY9TcSP25KbMZaOI/h6tDXQpCrl51Zv1aosfTFWKkimWoFDAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(66556008)(316002)(186003)(52116002)(5660300002)(2906002)(66946007)(6666004)(478600001)(83380400001)(36756003)(1076003)(6636002)(26005)(45080400002)(2616005)(7696005)(8676002)(86362001)(16526019)(6486002)(4326008)(8936002)(66476007)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kz68qgeoxzMsxsNYBS0Sgllko5nv+5MjF1BzmkcD08EVQ2lLaVdOKj2O7Twh?=
 =?us-ascii?Q?aUILI1Y88hOUsrmjvaNttaas31QZs9On4DubBd1yzPvGO0FJ5NYkrnH6gmyN?=
 =?us-ascii?Q?QYfH8f0B8f7eQNsVm+BaPHPNOb8ON2yxaGuWxSMmWNyTW5/4kRxhw0cQKC4/?=
 =?us-ascii?Q?CIP5+0z2qgJc8YRSDWYRqiyupHZkat8XovMVx0CtDuNIcz6SadPtWz62RGZ3?=
 =?us-ascii?Q?VMmFm4G+zlvwItC3XJ1rxKn01XVIMeCxh/PKSSYomrvA0f7JizUec56mHD6B?=
 =?us-ascii?Q?qnr27X1CTPD2uFQGHOEq/uPXNZk4PUKhAFrUeT4JW3/OBBIwFggW5BQtQGZ6?=
 =?us-ascii?Q?fxoQkwvoCfdaBnINt5lRAy1HMNa45c9JwLLKbqmBbXsO6Xh6pqVlqmWpcmtf?=
 =?us-ascii?Q?QWS+/9PZvyFCysMCuz3JPIbsCRMECmt4YZn0QisjqbUKboLgH9tgbfAwMd9G?=
 =?us-ascii?Q?Gsw0gf3v4RWerdJFWUNfw7m8ODUWV8sP+CshPNcNVy07rsTAIXxLyFLThShL?=
 =?us-ascii?Q?TGwWlkwl0HJ8RllXyUEZgesYTxQim0tJ30RYEhb4qZB5orH1duzLKemzSVja?=
 =?us-ascii?Q?TXvOI7+Z/65l9kfziE/BfaboznAPmPMmvljl5JkOx3ahNWB221qB3W+hFzQH?=
 =?us-ascii?Q?dLNF60Fgkjmj+70F+DbG26uj7QguDlYqgErwTe1/Y+8GRKg3gPBWNiCjxrBI?=
 =?us-ascii?Q?F+ax8by7cKDTV6i7iXkg2wXr1ALKmouIxV7rDYHnpuv1bDvzNLch82CraFGr?=
 =?us-ascii?Q?vYIk0aFDzCWrPv7liF1ZApmvjKT+zlc3Y9B8PhmRobxz+ELun8ROZYQK7mdd?=
 =?us-ascii?Q?ORWAct/mjxVyYwTLKeRPvFf61HyTKH9JsVaAzs8hsa6XII1lWMvar267SF34?=
 =?us-ascii?Q?kHQ2juaruGWdvAc1wzEwyzZHaOa19tamAOUfeXOeUUwf/zZioH3bwHVA4Hey?=
 =?us-ascii?Q?CwzBd8FK/rWjTn+etG8JBVFPbWCud7rAbbZcCHGpiPS08gQxM8giDNfkny7J?=
 =?us-ascii?Q?BaWO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 06:21:18.3696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: a340b2cd-205a-4da4-4205-08d8abc1f413
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jik/dzLslh3275gUczWIOoqKOe95gFR+UVKrwk6q2nrpcKtc29q82gWkiNUET1n6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3280
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
Cc: Alexander.Deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix NULL pointer issue when read sysfs amdgpu_current_backlight_pwm sysfs node.

calltrace:
[  248.273833] BUG: kernel NULL pointer dereference, address: 0000000000000130
[  248.273930] #PF: supervisor read access in kernel mode
[  248.273993] #PF: error_code(0x0000) - not-present page
[  248.274054] PGD 0 P4D 0
[  248.274092] Oops: 0000 [#1] SMP PTI
[  248.274138] CPU: 2 PID: 1377 Comm: cat Tainted: G           OE     5.9.0-rc5-drm-next-5.9+ #1
[  248.274233] Hardware name: System manufacturer System Product Name/Z170-A, BIOS 3802 03/15/2018
[  248.274641] RIP: 0010:dc_link_get_backlight_level+0x5/0x70 [amdgpu]
[  248.274718] Code: 67 ff ff ff 41 b9 03 00 00 00 e9 45 ff ff ff d1 ea e9 55 ff ff ff 0f 1f 44 00 00 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <48> 8b 87 30 01 00 00 48 8b 00 48 8b 88 88 03 00 00 48 8d 81 e8 01
[  248.274919] RSP: 0018:ffffb5ad809b3df0 EFLAGS: 00010203
[  248.274982] RAX: ffffa0f77d1c0010 RBX: ffffa0f793ae9168 RCX: 0000000000000001
[  248.275064] RDX: ffffa0f79753db00 RSI: 0000000000000001 RDI: 0000000000000000
[  248.275145] RBP: ffffb5ad809b3e00 R08: ffffb5ad809b3da0 R09: 0000000000000000
[  248.275225] R10: ffffb5ad809b3e68 R11: 0000000000000000 R12: ffffa0f793ae9190
[  248.275306] R13: ffffb5ad809b3ef0 R14: 0000000000000001 R15: ffffa0f793ae9168
[  248.275388] FS:  00007f5f1ec4d540(0000) GS:ffffa0f79ec80000(0000) knlGS:0000000000000000
[  248.275480] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  248.275547] CR2: 0000000000000130 CR3: 000000042a03c005 CR4: 00000000003706e0
[  248.275628] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  248.275708] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  248.275789] Call Trace:
[  248.276124]  ? current_backlight_read+0x24/0x40 [amdgpu]
[  248.276194]  seq_read+0xc3/0x3f0
[  248.276240]  full_proxy_read+0x5c/0x90
[  248.276290]  vfs_read+0xa7/0x190
[  248.276334]  ksys_read+0xa7/0xe0
[  248.276379]  __x64_sys_read+0x1a/0x20
[  248.276429]  do_syscall_64+0x37/0x80
[  248.276477]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  248.276538] RIP: 0033:0x7f5f1e75c191
[  248.276585] Code: fe ff ff 48 8d 3d b7 9d 0a 00 48 83 ec 08 e8 46 4d 02 00 66 0f 1f 44 00 00 48 8d 05 71 07
2e 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 41 54 55 49 89 d4 53Hw
[  248.276784] RSP: 002b:00007ffcb1fc3f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  248.276872] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f5f1e75c191
[  248.276953] RDX: 0000000000020000 RSI: 00007f5f1ec2b000 RDI: 0000000000000003
[  248.277034] RBP: 0000000000020000 R08: 00000000ffffffff R09: 0000000000000000
[  248.277115] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f5f1ec2b000
[  248.277195] R13: 0000000000000003 R14: 00007f5f1ec2b00f R15: 0000000000020000
[  248.277279] Modules linked in: amdgpu(OE) iommu_v2 gpu_sched ttm(OE) drm_kms_helper cec drm
i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs
lockd grace fscache nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
ledtrig_audio intel_rapl_msr intel_rapl_common snd_hda_intel snd_intel_dspcfg x86_pkg_temp_thermal
intel_powerclamp snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event mei_hdcp
coretemp snd_rawmidi snd_seq kvm_intel kvm snd_seq_device snd_timer irqbypass joydev snd input_leds soundcore
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper rapl intel_cstate
mac_hid mei_me serio_raw mei eeepc_wmi wmi_bmof asus_wmi mxm_wmi intel_wmi_thunderbolt acpi_pad sparse_keymap
efi_pstore sch_fq_codel parport_pc ppdev lp parport sunrpc ip_tables x_tables autofs4 hid_logitech_hidpp
hid_logitech_dj hid_generic usbhid hid e1000e psmouse ahci libahci wmi video
[  248.278211] CR2: 0000000000000130
[  248.278221] ---[ end trace 1fbe72fe6f91091d ]---
[  248.357226] RIP: 0010:dc_link_get_backlight_level+0x5/0x70 [amdgpu]
[  248.357272] Code: 67 ff ff ff 41 b9 03 00 00 00 e9 45 ff ff ff d1 ea e9 55 ff ff ff 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <48> 8b 87 30 01 00 00 48 8b 00 48 8b 88 88 03 00 00 48 8d 81 e8 01

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9e1071b2181f..f4a2088ab179 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2487,9 +2487,14 @@ enum dc_status dc_link_validate_mode_timing(
 static struct abm *get_abm_from_stream_res(const struct dc_link *link)
 {
 	int i;
-	struct dc *dc = link->ctx->dc;
+	struct dc *dc = NULL;
 	struct abm *abm = NULL;
 
+	if (!link || !link->ctx)
+		return NULL;
+
+	dc = link->ctx->dc;
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx pipe_ctx = dc->current_state->res_ctx.pipe_ctx[i];
 		struct dc_stream_state *stream = pipe_ctx.stream;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
