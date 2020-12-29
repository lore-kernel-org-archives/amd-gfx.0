Return-Path: <SRS0=yA2I=GB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0187BC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Dec 2020 15:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AFC207BD
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Dec 2020 15:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AFC207BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7AE8915A;
	Tue, 29 Dec 2020 15:24:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CFD8915A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Dec 2020 15:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfM+S5gGixjsecfhG9lYCEjkloddvM8W75U9dn3kDadqwr+SaflAGW+XmSwBCdryMsSRTkI5MHf7MjByXdMMwPmB4QOyO3LH9+tMw+/Tkt0nj4VQvq66Aba0G4cuN3up4ej2ldFnY8zyu+6NC8SkUxZdzzIDT8FZBzhyJSOSbZQPnasVJ8Trx2eF72EAYhuTkaxSm4IULbo6eHyF8te4zGUtnwA6jizIJwcVCSBJorUlodcoRSvpwscQAfhtSGXn0Pbs6SvS8ma9dk46JuJ6+fm0oqUCLaaaR5liLuxFsch7TtWifB3HCRYVT+emDGaEzZ/qqGrGU+/D8OrCEnL6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+s87dAj6CXiDeWaxhFcSX2a1nYqEFPv/ldhPJ8yT/M=;
 b=iF5PRJ2OCwXWMfKWghIUDiXsmA0J6oXiL1aW+rD1OUE/DIQuZMm6J+p7NELEuwnyMuOzVDAa3YYE80gr/FFu+Lm+3QzyNohKNFKDSs74QliDhAXUyFP+ImcI5MG52idGurVDN2kK8ZkYpXMAftkj5wHLpbiRYENQHWDXxQpy7RqPSIHjpQoWIRrVKbGJ3hHQzyHGBETP8onuXCZdVQeJtfAocOFmtdivmz9rQbklk3gLnswjjPFu4GNnERL9ypH5G4nBdDtgLOkqyVQB0S9iye2VNtxnLfm31Pg73O1AJowbz/Nc03Maohs+zuUvoZy5FvywpWB9ONIMrhN6kX9pRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+s87dAj6CXiDeWaxhFcSX2a1nYqEFPv/ldhPJ8yT/M=;
 b=f0qEB1akrzT9713qLy5jG6LL1r3G1rnCqXX+JEGlHNEnn0kAYuiG5eshkfw/sRzZcY4+sDNVa12p6eZsW5F6uMXlmHuCtLRTdNGUm5aLFrqtedAH0j638ScnqG0v9RtlAjqJueeouPQrWCdqzGjCyfe8b0agGh7oa2FXlmCo0D0=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Tue, 29 Dec
 2020 15:23:58 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%4]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 15:23:57 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix sysfs amdgpu_current_backlight_pwm
 NULL pointer issue
Thread-Topic: [PATCH] drm/amd/display: fix sysfs amdgpu_current_backlight_pwm
 NULL pointer issue
Thread-Index: AQHW3arTTKnaudZR+kW1B1kElzBtb6oOMdnx
Date: Tue, 29 Dec 2020 15:23:57 +0000
Message-ID: <MN2PR12MB4488D8062C6A9C9AAD3E2815F7D80@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201229062101.29900-1-kevin1.wang@amd.com>
In-Reply-To: <20201229062101.29900-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-29T15:23:57.397Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3c064be-6ba0-4cd4-e504-08d8ac0dc30c
x-ms-traffictypediagnostic: MN2PR12MB4439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB443963C8F5F58B1BB17B70CFF7D80@MN2PR12MB4439.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:364;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJCywa70ohfcVxILEKYTpbomQ4zLWzOqWnHg0Ca6xFGKg+zUo33PVNuk6yuTT5zbbgVTSAxBu9mIoD1JwLVpM6MyVi6PoeufrU5MrZii3X1x5P+Yb9T8UwtkTF4ucpDyQxnjB8yfY23tP5sw5G7WxU7ut7mhBQDD2KWk730hvXqrx5VnbpKUipHSBk/pGakkzPtyF+MVHSMQLBhVgem8rUsGAnZb0OsGNKKB4D6jN7lO7RMz7z1zv11hLB8tMvmlxfARFJ8JMC430XKmw4XkVYVatOpy0K3vQwCzakjsE3fH85QNyjqVUwj/RCEjOVAtC9KLwo58oaCIDLeYvDyNhQTveOi/CxyXfAahvvfJNMrV3tF3Jl3p4ITAR+ve2x8Spwc6fqHmzVFdJICjjN9HeA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(86362001)(5660300002)(9686003)(83380400001)(8936002)(45080400002)(55016002)(110136005)(19627405001)(316002)(52536014)(186003)(2906002)(71200400001)(26005)(33656002)(6636002)(8676002)(53546011)(6506007)(66556008)(64756008)(478600001)(66476007)(7696005)(66446008)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oPRJD52368tKj09rcuFqVt627TA41jNuStXmSyEoR6VqtzROASeZH8Gl6FB9?=
 =?us-ascii?Q?v+djxBWiuUJw/BRRYIrc9ohXxw3jG4JOEDbyFjJUrAQEOg7mOhJldDU6OxBI?=
 =?us-ascii?Q?R0MxeDjKKE0KRvi6CIMAZXqlIa4TwsZ9cy+MO+knyeJnM0KGbpNGMuP+Ya3Q?=
 =?us-ascii?Q?VH2A5UBSosXgW/xTBugEZNgDrkyH3ld8nCSD6xxj9KLcYWN3Mi7WsXXQwBRT?=
 =?us-ascii?Q?xYlneq7oxqXxcpbpjuIkN8IVXpDiqjcUbLjGMxt+dn0Yem03pYtJG1qgs1dD?=
 =?us-ascii?Q?52ZR03PqK6Z6A39+Zzvvx2AsXWyzxN4PmmJ7yVnghd41WH4uAs5xgFNWD7Kl?=
 =?us-ascii?Q?Le/Mk5MYKFoZKrlCHn0RK1TACby5sF7DIEpx4P6SIqdLsgKPNzbwpL3uIwKF?=
 =?us-ascii?Q?vATdtmCCiCp4/4mfCNUDieR5WCcJsZYbvu3J82jxF5l4aSqvlSilEyIxWQHX?=
 =?us-ascii?Q?qUQjWLNhF9W+BqXPd7CV/iJeXag7rf2cI+XbKmEETlxCKzjd6giAVgHjDRQ3?=
 =?us-ascii?Q?Xn52+pKURSsRXBmu2PVpYMJ1pCAg4ne2cj7UeaZitNXAge3awJcfE+RYprpv?=
 =?us-ascii?Q?/x/viX1GJapqXPJdtTm+jKWGbVCt5uuDK4PmN//RHqS3Lf0awNggabjGJPWL?=
 =?us-ascii?Q?oeekTWHLoTM7/AbSjvtwy+IhGFTVIuVoVKbQUdnpfXt5V193hjkcx4rTcmR+?=
 =?us-ascii?Q?tHCR5JK/+eLPuz4WYkVVYzAUBs1h6tiZUu7NptSDCX0oJ3JUQEc4tqgL1IoA?=
 =?us-ascii?Q?KkR77FQM30SupRqXXy5QsOOGj4gJd/6EXcpvUnS7HC4WVqHuzjtNu+7HWksY?=
 =?us-ascii?Q?HnFgxP4LWCzvtuClgk0uv82o1GkO79t+3lyRWrzR9BBN9nNdkUuEY3k8tCMO?=
 =?us-ascii?Q?V9IgcoBccC529fOwrKphha5EQv1G79HTRANNN94SkM43fMR8Pe3fsLh9IZge?=
 =?us-ascii?Q?ss1iGA4RN5sjECkecGNbMNGnSmRcXRXYgRSQ0RnOnw8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c064be-6ba0-4cd4-e504-08d8ac0dc30c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 15:23:57.9132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUByoZD9MsAoLfPq6lMey72pdsoEA5rhm0H1l5Vflk2F6hkqEZeQRgykD4etH01tWgQGqpnoLu2ZQzK2Qu+CTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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
Content-Type: multipart/mixed; boundary="===============2100251243=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2100251243==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488D8062C6A9C9AAD3E2815F7D80MN2PR12MB4488namp_"

--_000_MN2PR12MB4488D8062C6A9C9AAD3E2815F7D80MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Tuesday, December 29, 2020 1:21 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Wentland=
, Harry <Harry.Wentland@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevi=
n1.Wang@amd.com>
Subject: [PATCH] drm/amd/display: fix sysfs amdgpu_current_backlight_pwm NU=
LL pointer issue

fix NULL pointer issue when read sysfs amdgpu_current_backlight_pwm sysfs n=
ode.

calltrace:
[  248.273833] BUG: kernel NULL pointer dereference, address: 0000000000000=
130
[  248.273930] #PF: supervisor read access in kernel mode
[  248.273993] #PF: error_code(0x0000) - not-present page
[  248.274054] PGD 0 P4D 0
[  248.274092] Oops: 0000 [#1] SMP PTI
[  248.274138] CPU: 2 PID: 1377 Comm: cat Tainted: G           OE     5.9.0=
-rc5-drm-next-5.9+ #1
[  248.274233] Hardware name: System manufacturer System Product Name/Z170-=
A, BIOS 3802 03/15/2018
[  248.274641] RIP: 0010:dc_link_get_backlight_level+0x5/0x70 [amdgpu]
[  248.274718] Code: 67 ff ff ff 41 b9 03 00 00 00 e9 45 ff ff ff d1 ea e9 =
55 ff ff ff 0f 1f 44 00 00 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <48> 8b 87 30 01 00 00 48 8b 00 48 8=
b 88 88 03 00 00 48 8d 81 e8 01
[  248.274919] RSP: 0018:ffffb5ad809b3df0 EFLAGS: 00010203
[  248.274982] RAX: ffffa0f77d1c0010 RBX: ffffa0f793ae9168 RCX: 00000000000=
00001
[  248.275064] RDX: ffffa0f79753db00 RSI: 0000000000000001 RDI: 00000000000=
00000
[  248.275145] RBP: ffffb5ad809b3e00 R08: ffffb5ad809b3da0 R09: 00000000000=
00000
[  248.275225] R10: ffffb5ad809b3e68 R11: 0000000000000000 R12: ffffa0f793a=
e9190
[  248.275306] R13: ffffb5ad809b3ef0 R14: 0000000000000001 R15: ffffa0f793a=
e9168
[  248.275388] FS:  00007f5f1ec4d540(0000) GS:ffffa0f79ec80000(0000) knlGS:=
0000000000000000
[  248.275480] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  248.275547] CR2: 0000000000000130 CR3: 000000042a03c005 CR4: 00000000003=
706e0
[  248.275628] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  248.275708] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
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
[  248.276585] Code: fe ff ff 48 8d 3d b7 9d 0a 00 48 83 ec 08 e8 46 4d 02 =
00 66 0f 1f 44 00 00 48 8d 05 71 07
2e 00 8b 00 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 4=
4 00 00 41 54 55 49 89 d4 53Hw
[  248.276784] RSP: 002b:00007ffcb1fc3f38 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[  248.276872] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f5f1e7=
5c191
[  248.276953] RDX: 0000000000020000 RSI: 00007f5f1ec2b000 RDI: 00000000000=
00003
[  248.277034] RBP: 0000000000020000 R08: 00000000ffffffff R09: 00000000000=
00000
[  248.277115] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f5f1ec=
2b000
[  248.277195] R13: 0000000000000003 R14: 00007f5f1ec2b00f R15: 00000000000=
20000
[  248.277279] Modules linked in: amdgpu(OE) iommu_v2 gpu_sched ttm(OE) drm=
_kms_helper cec drm
i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt rpcsec_gss_krb5 =
auth_rpcgss nfsv4 nfs
lockd grace fscache nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_hdmi =
snd_hda_codec_generic
ledtrig_audio intel_rapl_msr intel_rapl_common snd_hda_intel snd_intel_dspc=
fg x86_pkg_temp_thermal
intel_powerclamp snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi =
snd_seq_midi_event mei_hdcp
coretemp snd_rawmidi snd_seq kvm_intel kvm snd_seq_device snd_timer irqbypa=
ss joydev snd input_leds soundcore
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd c=
ryptd glue_helper rapl intel_cstate
mac_hid mei_me serio_raw mei eeepc_wmi wmi_bmof asus_wmi mxm_wmi intel_wmi_=
thunderbolt acpi_pad sparse_keymap
efi_pstore sch_fq_codel parport_pc ppdev lp parport sunrpc ip_tables x_tabl=
es autofs4 hid_logitech_hidpp
hid_logitech_dj hid_generic usbhid hid e1000e psmouse ahci libahci wmi vide=
o
[  248.278211] CR2: 0000000000000130
[  248.278221] ---[ end trace 1fbe72fe6f91091d ]---
[  248.357226] RIP: 0010:dc_link_get_backlight_level+0x5/0x70 [amdgpu]
[  248.357272] Code: 67 ff ff ff 41 b9 03 00 00 00 e9 45 ff ff ff d1 ea e9 =
55 ff ff ff 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <48=
> 8b 87 30 01 00 00 48 8b 00 48 8b 88 88 03 00 00 48 8d 81 e8 01

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c
index 9e1071b2181f..f4a2088ab179 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2487,9 +2487,14 @@ enum dc_status dc_link_validate_mode_timing(
 static struct abm *get_abm_from_stream_res(const struct dc_link *link)
 {
         int i;
-       struct dc *dc =3D link->ctx->dc;
+       struct dc *dc =3D NULL;
         struct abm *abm =3D NULL;

+       if (!link || !link->ctx)
+               return NULL;
+
+       dc =3D link->ctx->dc;
+
         for (i =3D 0; i < MAX_PIPES; i++) {
                 struct pipe_ctx pipe_ctx =3D dc->current_state->res_ctx.pi=
pe_ctx[i];
                 struct dc_stream_state *stream =3D pipe_ctx.stream;
--
2.17.1


--_000_MN2PR12MB4488D8062C6A9C9AAD3E2815F7D80MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 29, 2020 1:21 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Wang, Kevi=
n(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: fix sysfs amdgpu_current_backlight=
_pwm NULL pointer issue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">fix NULL pointer issue when read sysfs amdgpu_curr=
ent_backlight_pwm sysfs node.<br>
<br>
calltrace:<br>
[&nbsp; 248.273833] BUG: kernel NULL pointer dereference, address: 00000000=
00000130<br>
[&nbsp; 248.273930] #PF: supervisor read access in kernel mode<br>
[&nbsp; 248.273993] #PF: error_code(0x0000) - not-present page<br>
[&nbsp; 248.274054] PGD 0 P4D 0<br>
[&nbsp; 248.274092] Oops: 0000 [#1] SMP PTI<br>
[&nbsp; 248.274138] CPU: 2 PID: 1377 Comm: cat Tainted: G&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.9.0=
-rc5-drm-next-5.9+ #1<br>
[&nbsp; 248.274233] Hardware name: System manufacturer System Product Name/=
Z170-A, BIOS 3802 03/15/2018<br>
[&nbsp; 248.274641] RIP: 0010:dc_link_get_backlight_level+0x5/0x70 [amdgpu]=
<br>
[&nbsp; 248.274718] Code: 67 ff ff ff 41 b9 03 00 00 00 e9 45 ff ff ff d1 e=
a e9 55 ff ff ff 0f 1f 44 00 00 66 2e<br>
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 &lt;48&gt; 8b 87 30 01 00 00 48 8b 0=
0 48 8b 88 88 03 00 00 48 8d 81 e8 01<br>
[&nbsp; 248.274919] RSP: 0018:ffffb5ad809b3df0 EFLAGS: 00010203<br>
[&nbsp; 248.274982] RAX: ffffa0f77d1c0010 RBX: ffffa0f793ae9168 RCX: 000000=
0000000001<br>
[&nbsp; 248.275064] RDX: ffffa0f79753db00 RSI: 0000000000000001 RDI: 000000=
0000000000<br>
[&nbsp; 248.275145] RBP: ffffb5ad809b3e00 R08: ffffb5ad809b3da0 R09: 000000=
0000000000<br>
[&nbsp; 248.275225] R10: ffffb5ad809b3e68 R11: 0000000000000000 R12: ffffa0=
f793ae9190<br>
[&nbsp; 248.275306] R13: ffffb5ad809b3ef0 R14: 0000000000000001 R15: ffffa0=
f793ae9168<br>
[&nbsp; 248.275388] FS:&nbsp; 00007f5f1ec4d540(0000) GS:ffffa0f79ec80000(00=
00) knlGS:0000000000000000<br>
[&nbsp; 248.275480] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<=
br>
[&nbsp; 248.275547] CR2: 0000000000000130 CR3: 000000042a03c005 CR4: 000000=
00003706e0<br>
[&nbsp; 248.275628] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000<br>
[&nbsp; 248.275708] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400<br>
[&nbsp; 248.275789] Call Trace:<br>
[&nbsp; 248.276124]&nbsp; ? current_backlight_read+0x24/0x40 [amdgpu]<br>
[&nbsp; 248.276194]&nbsp; seq_read+0xc3/0x3f0<br>
[&nbsp; 248.276240]&nbsp; full_proxy_read+0x5c/0x90<br>
[&nbsp; 248.276290]&nbsp; vfs_read+0xa7/0x190<br>
[&nbsp; 248.276334]&nbsp; ksys_read+0xa7/0xe0<br>
[&nbsp; 248.276379]&nbsp; __x64_sys_read+0x1a/0x20<br>
[&nbsp; 248.276429]&nbsp; do_syscall_64+0x37/0x80<br>
[&nbsp; 248.276477]&nbsp; entry_SYSCALL_64_after_hwframe+0x44/0xa9<br>
[&nbsp; 248.276538] RIP: 0033:0x7f5f1e75c191<br>
[&nbsp; 248.276585] Code: fe ff ff 48 8d 3d b7 9d 0a 00 48 83 ec 08 e8 46 4=
d 02 00 66 0f 1f 44 00 00 48 8d 05 71 07<br>
2e 00 8b 00 85 c0 75 13 31 c0 0f 05 &lt;48&gt; 3d 00 f0 ff ff 77 57 f3 c3 0=
f 1f 44 00 00 41 54 55 49 89 d4 53Hw<br>
[&nbsp; 248.276784] RSP: 002b:00007ffcb1fc3f38 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000000<br>
[&nbsp; 248.276872] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f=
5f1e75c191<br>
[&nbsp; 248.276953] RDX: 0000000000020000 RSI: 00007f5f1ec2b000 RDI: 000000=
0000000003<br>
[&nbsp; 248.277034] RBP: 0000000000020000 R08: 00000000ffffffff R09: 000000=
0000000000<br>
[&nbsp; 248.277115] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f=
5f1ec2b000<br>
[&nbsp; 248.277195] R13: 0000000000000003 R14: 00007f5f1ec2b00f R15: 000000=
0000020000<br>
[&nbsp; 248.277279] Modules linked in: amdgpu(OE) iommu_v2 gpu_sched ttm(OE=
) drm_kms_helper cec drm<br>
i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt rpcsec_gss_krb5 =
auth_rpcgss nfsv4 nfs<br>
lockd grace fscache nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_hdmi =
snd_hda_codec_generic<br>
ledtrig_audio intel_rapl_msr intel_rapl_common snd_hda_intel snd_intel_dspc=
fg x86_pkg_temp_thermal<br>
intel_powerclamp snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi =
snd_seq_midi_event mei_hdcp<br>
coretemp snd_rawmidi snd_seq kvm_intel kvm snd_seq_device snd_timer irqbypa=
ss joydev snd input_leds soundcore<br>
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd c=
ryptd glue_helper rapl intel_cstate<br>
mac_hid mei_me serio_raw mei eeepc_wmi wmi_bmof asus_wmi mxm_wmi intel_wmi_=
thunderbolt acpi_pad sparse_keymap<br>
efi_pstore sch_fq_codel parport_pc ppdev lp parport sunrpc ip_tables x_tabl=
es autofs4 hid_logitech_hidpp<br>
hid_logitech_dj hid_generic usbhid hid e1000e psmouse ahci libahci wmi vide=
o<br>
[&nbsp; 248.278211] CR2: 0000000000000130<br>
[&nbsp; 248.278221] ---[ end trace 1fbe72fe6f91091d ]---<br>
[&nbsp; 248.357226] RIP: 0010:dc_link_get_backlight_level+0x5/0x70 [amdgpu]=
<br>
[&nbsp; 248.357272] Code: 67 ff ff ff 41 b9 03 00 00 00 e9 45 ff ff ff d1 e=
a e9 55 ff ff ff 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 0=
0 &lt;48&gt; 8b 87 30 01 00 00 48 8b 00 48 8b 88 88 03 00 00 48 8d 81 e8 01=
<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link.c | 7 ++++++-<br>
&nbsp;1 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c<br>
index 9e1071b2181f..f4a2088ab179 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
@@ -2487,9 +2487,14 @@ enum dc_status dc_link_validate_mode_timing(<br>
&nbsp;static struct abm *get_abm_from_stream_res(const struct dc_link *link=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc *dc =3D link-&gt;ctx-&gt;dc=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc *dc =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct abm *abm =3D NULL;<=
br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!link || !link-&gt;ctx)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc =3D link-&gt;ctx-&gt;dc;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MAX_P=
IPES; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pipe_ctx pipe_ctx =3D dc-&gt;current_state-&gt=
;res_ctx.pipe_ctx[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_stream_state *stream =3D pipe_ctx.stream;<b=
r>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488D8062C6A9C9AAD3E2815F7D80MN2PR12MB4488namp_--

--===============2100251243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2100251243==--
