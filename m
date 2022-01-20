Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1EFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 01:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC55A10F4B5;
	Thu, 20 Jan 2022 01:52:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627CC10F4B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 01:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGhwTvXsPH9i2yj6eAeXSfvWbxrVKG0KxZQqMA47d6lx3eJiTgOuynL7GSvbLsYk0gxJh5hg0K4+FoMTJMe+fpXmnVCRQ4ABrNkAb6GWoIrUNOSuqu+qyBOOBbdMHXsiFLUU2TWppT7B2yWok+OUk1+v6aoTi2MxexhA1adf5VGNurhAOM0pgcq082DFc2+9Qm3nPW5DxDB+h5acaa6eEBf4AwZ1eYPr/y7pT047uiRuSIi8uyZI4bIgeZh6E3wx3hhJS/DIGjIKlvPIwdMxV8IBJS6Q78j7NyxpmUvJMsJmqW2TQRiGzJodKs6rGpMa902IQh3ZXq4WfGkOsRliFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDGaccoSmSyEGzkf0EMRhdEYFnwlV3FglXbEkKj8CvU=;
 b=P12lBWM37oqp/M9l3GOVKR7Df0yQ1foMeVQlxdHPp/I0K7vhY1B32IKI63Y1Es/2YMPBg3U6XyqrAWuGQmADhrW+thrnGh4YU3+N54KpHZcDBszMs0g53GiwKsWZepLhCGTZUuH9avedlmBTovGtk9mOEIB15//+bi1HXCYuVqdt5KQndDBvERjS0vTYaEwWh/BIGyUSZ6AeX+bxZgg3OQVoXsm5VZCpY0P56w/1/QkCP4Jdyz/z3VjzEa5DWrCH62ygqNUf24EJS2dOEJ0GHBRhsXURQBOS5pR/VCph4S3ik1PhWnRw7biePGjznj5K0CyyLKx8GsY8WMN0b7tG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDGaccoSmSyEGzkf0EMRhdEYFnwlV3FglXbEkKj8CvU=;
 b=5NsdehX2IuJwZ8MLXer8x3+/IkAmqJRNc5sY3nJroO/CKq+jsrzS/Zb0X+0EOFcDGlwFXtXx0NE9dbV+9sF1lb//iX2COBx+9P854tKaQEEMf0dweKbrq30SnpjKiLHAMh5ZHZmg6W3CvNvpYKGWzUE1AzuoNpl2DOdUKWkGOUM=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by BYAPR12MB3013.namprd12.prod.outlook.com (2603:10b6:a03:a9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 01:52:21 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb%4]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 01:52:21 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: amd-staging-drm-next breaks suspend
Thread-Topic: amd-staging-drm-next breaks suspend
Thread-Index: AQHYDX7T/RgnTaV8KEmdrTtIHY6zZKxq45gwgAAMlQCAAAuUAIAAGA4AgAAB3ICAAASnAIAACfuA
Date: Thu, 20 Jan 2022 01:52:21 +0000
Message-ID: <DM6PR12MB31637A906C7E520B358C8242855A9@DM6PR12MB3163.namprd12.prod.outlook.com>
References: <2d7fe1c0ddde50a1836b49dff8a02decdfcbe00d.camel@web.de>
 <BL1PR12MB515792BB2C4609F91269E3AFE2599@BL1PR12MB5157.namprd12.prod.outlook.com>
 <904d0552-20b0-2e11-c061-4d9d20bca374@amd.com>
 <75d1eefa7cf24d1751532b19841625be010cc015.camel@web.de>
 <314494939bcf185110d6a468637b08891138fba5.camel@web.de>
 <CADnq5_Nv9aChRhSBk3snMZ2ueU0fAAfYa_a_tc5gAy49dRRR_w@mail.gmail.com>
 <9da08e91cf313da76d4c4d8e9221b929e9e5247d.camel@web.de>
In-Reply-To: <9da08e91cf313da76d4c4d8e9221b929e9e5247d.camel@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cfc819eb-5766-47b0-8343-50b5d995cdf3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-20T01:48:31Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: e13809a5-6734-4dde-a8a1-6f3cb5946bb0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d97cd08-1354-46ea-6490-08d9dbb77fcd
x-ms-traffictypediagnostic: BYAPR12MB3013:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3013EC0953DE25C7EA8BE466855A9@BYAPR12MB3013.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zlLux4utb7dHvy0aqZOwpD/DWVQnjiuvM4gWzAQsnWdFxVPrzEcOmVYlsGEw0eXBgufDuEbg88DBvVd0lcIv0aGhByRY6smMISo/YERs0nVLUJRqXABmJrHlREAonrRYnmaSoA57Vyz5H0+w6txAW2+y9I5t9R7DrADm55EXwCWKGY6X/YjvGSGAM/CAN5H4eDCkxMEXea4jexyDwOcikwHFIgCOSXn/HSWcZosqJwwBSMiXc9VnDNX4Q9JWsu2ilhq5H7AnmWnQnr4N84nZtywwBXwMmxv/mjNicx+P3uP4J06LI0BD7LRCnjc/bfo8okquJDoBjccMGSiSoi9vDSfp7BfS+KYBBFX1RtIlLG9dzptWF5elaC2gMsToFy9KFSgii6I5hbULPa1xPcRQLfCOqIXUF4zD+NS19u8y252cJ2NG6xmX7HJcxIOYA2nR8U9bkdzDAlvB5X4vpYxrrTzIWffDOJvMJeo/3NpvEk+blXEvDDdEtqL9ePRe7O/u/WfFi+VuasafIJwxboqg5ItbhAnb8IgmivMGXWH0s82faHBVPQXZWPnMEO258fRDfaFIWrAf09SiX2f/o7Oo0PjVVyRWBLOoWOWOWOHRrRXqxpRI+tOjogmhqRLlmcKiBavT0ijttmL6VC4P0fK9GGiFLPU0quSEvZSOGkALzO6mE3fa0vXTU6eSoW5hhf/DzXbEar7W58L6Wvl3JILTPYrHE9JB+AumMFaApGJTZDr5D2Mo6ZctjQ4+rf8OA9hzJPDDcmeimHQ/OX4+0tWPPw4KxAdP/ncNZ58XFZIN9skLsxtiK1vWSsvGaq/GKsTfk21ZQffvX1U1jnuuJAceoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(15650500001)(55016003)(45080400002)(52536014)(9686003)(8676002)(5660300002)(76116006)(71200400001)(186003)(6506007)(966005)(53546011)(122000001)(30864003)(38100700002)(66556008)(83380400001)(110136005)(8936002)(66446008)(38070700005)(54906003)(4326008)(7696005)(508600001)(66476007)(2906002)(64756008)(66946007)(316002)(86362001)(33656002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DEDbpXXg0hdg/CqH4UxYsGdQBYsnlZpyyfEE4IanrF9gqw/6qEzUL3xgqx?=
 =?iso-8859-1?Q?rb723YBe7VgIsBB+HfgHnBlYe2nd7YtRlZY8ileTwdu5GBHJyrSe/ZeDd3?=
 =?iso-8859-1?Q?9JlrDmC0pvHEGwanNL2nrQBjyqB6e14IB7NNV+ZJ57A1lJVsDx6/otgL1j?=
 =?iso-8859-1?Q?T9nQs1BY7W8pTn0JfXrB8yGzsdRAF2uJhuCAqIuR5/RtGYoITMGm252LcA?=
 =?iso-8859-1?Q?AAClvmG/q2qnREzV29TLGVFIGDOkj/7XlewZNOQPne6vMIoT+8uu1MsS96?=
 =?iso-8859-1?Q?h7wgMexfWdxo1KgwJ3Mgy79IS/0hh2Ylnc5DGFBJS1XtJZJkC9uCjL3GaD?=
 =?iso-8859-1?Q?WIHG++LbUaHpp2ao1DSVzbK57CTPPHNKOC2uwUyC7QPwqerGks3rumsgHj?=
 =?iso-8859-1?Q?323rysbddGV7x28ml3Ik467J1JJpVPIVYRxqQm5zyfDxhqI0U+tt0S3Q+w?=
 =?iso-8859-1?Q?Nm786OlLKnOeSYfm9I+AQ4HIy52o1HiSkm5MHCGTxWAqrIr/9ygY+nGCDJ?=
 =?iso-8859-1?Q?QaA0zYHtui7KXbtBGuylOi/mM6ewfHYJKXnFrurZnKb1ATSfZU5fpJz5ro?=
 =?iso-8859-1?Q?5RsiXA9nmCavOaEU/3fo+BN9HF90dhmuSW1+8Ijy1BtttpCVfg9VwHQiUw?=
 =?iso-8859-1?Q?3cPgaXLoU9TceUF6w79szzg+Lf4x769YMmPCLVt00zOEIjAuaF/z1XEvv6?=
 =?iso-8859-1?Q?FjRgwY92OT6cMhoPfOCsxGusZfMJgr25EbtZqi4gaVmyX8aU7PtFTKrUsY?=
 =?iso-8859-1?Q?L2cUE1vTXgICFDVjrRv3AM5LQtEGn1+pLBi/5nRl8vBSjGi4t13vcZgtrT?=
 =?iso-8859-1?Q?WTXZfsLM+CzrQrLATGwmCnR27A61eDIojNs0vLiXzVwRVnyX4WaBf6fgZJ?=
 =?iso-8859-1?Q?2j5tw3shLBLPzxCW2Mq0coGUgRDqFGdoT2jHycEmY6xeCxwll/xySmq+RS?=
 =?iso-8859-1?Q?eiBtv6DQtgQqMdBRV7jAYDV/oQC+zISRNypXntOpmNEPO9e/Beq3AJ+rvz?=
 =?iso-8859-1?Q?yFmXI5UnzVHNiIBZweHHgCYWkuS4Ar+8It0QFwpdL9FmMv5tl2N7N+4VY0?=
 =?iso-8859-1?Q?Uvsyu+Lh6u1StSxM+s1mrhGaH+WDQwROnyQFZo0Qq5aftkaJxWwIQ/TFFb?=
 =?iso-8859-1?Q?bizbNHnEhITnpUFVWX9Dvvb+KKG+eCfzntQXAYwNi/nK4M89/eM1hXOnzB?=
 =?iso-8859-1?Q?67+BbWSdch5VsPuPt61i7WB9zRYUJiHQZFbbe6mMclFXhSsAbGvUslAXLc?=
 =?iso-8859-1?Q?gkb24P4FgZNsnsKC+ve5u5cjL5cfuVOeQNzZq3jNbjvKVZ2tLsFlQrUoPz?=
 =?iso-8859-1?Q?gNtnDHakjg0LGRoLqiX/uIm1KrMSJdQOeDoHT5vTn3AqnBdb/DyJVQ/fiL?=
 =?iso-8859-1?Q?uVMh9klurlmuIqpMO09SYi8Aw5wPvQwe5WREy5mDF726pRf76INzi702qh?=
 =?iso-8859-1?Q?53W259NFyRYdmc3oMg9wzurEga3552wSS+xKbXQ7L6KnSfFPRbhFUJMGBF?=
 =?iso-8859-1?Q?l+Hu1/vjzkQFM1z2/eoyT6SRW9lQPz42c0edzJxETzxFCmQMRx6Uddt6io?=
 =?iso-8859-1?Q?WgWZBRbsMWWf3zhTPyIziA/zjN/if4ZrmGbiDB/Enxzb37/FIxDtwHay0S?=
 =?iso-8859-1?Q?Uvs61rLQmuCLsaw6O5DFdYrIMsRlQBSEYsRc850+q4wVZ0RMAJCNcGLeOR?=
 =?iso-8859-1?Q?5CVH5w4ymQfyWojt8Q8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d97cd08-1354-46ea-6490-08d9dbb77fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 01:52:21.8051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LqUR7DMsygo17cHfn9tv1Sf1L4TeMK9uIOtnpUlwSGyDuxjlGKPjofX8KGf4zywy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3013
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
Cc: Chris Hixon <linux-kernel-bugs@hixontech.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Scott Bruce <smbruce@gmail.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This should fix the issue by getting rid of the unneeded flag check during =
gart bind:
https://patchwork.freedesktop.org/patch/469907/

Thanks,

Jon

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bert
> Karwatzki
> Sent: January 19, 2022 8:12 PM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: Chris Hixon <linux-kernel-bugs@hixontech.com>; Zhuo, Qingqing
> (Lillian) <Qingqing.Zhuo@amd.com>; Das, Nirmoy
> <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org; Scott Bruce
> <smbruce@gmail.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Kazlauskas, Nicholas
> <Nicholas.Kazlauskas@amd.com>
> Subject: Re: amd-staging-drm-next breaks suspend
>
> [CAUTION: External Email]
>
> Unfortunately this does not work either:
>
> [    0.859998] ------------[ cut here ]------------
> [    0.859998] trying to bind memory to uninitialized GART !
> [    0.860003] WARNING: CPU: 13 PID: 235 at
> drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:254
> amdgpu_gart_bind+0x29/0x40 [amdgpu]
> [    0.860099] Modules linked in: amdgpu(+) drm_ttm_helper ttm
> gpu_sched i2c_algo_bit drm_kms_helper syscopyarea hid_sensor_hub
> sysfillrect mfd_core sysimgblt hid_generic fb_sys_fops cec xhci_pci
> xhci_hcd nvme drm r8169 nvme_core psmouse crc32c_intel realtek
> amd_sfh usbcore i2c_hid_acpi mdio_devres t10_pi crc_t10dif i2c_hid
> i2c_piix4 crct10dif_generic libphy crct10dif_common hid backlight
> i2c_designware_platform i2c_designware_core
> [    0.860113] CPU: 13 PID: 235 Comm: systemd-udevd Not tainted 5.13.0+
> #15
> [    0.860115] Hardware name: Micro-Star International Co., Ltd. Alpha
> 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
> [    0.860116] RIP: 0010:amdgpu_gart_bind+0x29/0x40 [amdgpu]
> [    0.860210] Code: 00 80 bf 34 25 00 00 00 74 14 4c 8b 8f 20 25 00 00
> 4d 85 c9 74 05 e9 16 ff ff ff 31 c0 c3 48 c7 c7 08 06 7d c0 e8 8e cc 31
> e2 <0f> 0b b8 ea ff ff ff c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> [    0.860212] RSP: 0018:ffffbb9e80b6f968 EFLAGS: 00010286
> [    0.860213] RAX: 0000000000000000 RBX: 0000000000000067 RCX:
> ffffffffa3080968
> [    0.860214] RDX: 0000000000000000 RSI: 00000000ffffefff RDI:
> ffffffffa3028960
> [    0.860215] RBP: ffff947c91e49a80 R08: 0000000000000000 R09:
> ffffbb9e80b6f798
> [    0.860215] R10: ffffbb9e80b6f790 R11: ffffffffa30989a8 R12:
> 0000000000000000
> [    0.860216] R13: ffff947c8a740000 R14: ffff947c8a740000 R15:
> 0000000000000000
> [    0.860216] FS:  00007f60a3c918c0(0000) GS:ffff947f5e940000(0000)
> knlGS:0000000000000000
> [    0.860217] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.860218] CR2: 00007f60a4213480 CR3: 0000000135ee2000 CR4:
> 0000000000550ee0
> [    0.860218] PKRU: 55555554
> [    0.860219] Call Trace:
> [    0.860221]  amdgpu_ttm_gart_bind+0x74/0xc0 [amdgpu]
> [    0.860305]  amdgpu_ttm_alloc_gart+0x13e/0x190 [amdgpu]
> [    0.860385]  amdgpu_bo_create_reserved.part.0+0xf3/0x1b0 [amdgpu]
> [    0.860465]  ? amdgpu_ttm_debugfs_init+0x110/0x110 [amdgpu]
> [    0.860554]  amdgpu_bo_create_kernel+0x36/0xa0 [amdgpu]
> [    0.860641]  amdgpu_ttm_init.cold+0x167/0x181 [amdgpu]
> [    0.860784]  gmc_v10_0_sw_init+0x2d7/0x430 [amdgpu]
> [    0.860889]  amdgpu_device_init.cold+0x147f/0x1ad7 [amdgpu]
> [    0.861007]  ? acpi_ns_get_node+0x4a/0x55
> [    0.861011]  ? acpi_get_handle+0x89/0xb2
> [    0.861012]  amdgpu_driver_load_kms+0x55/0x290 [amdgpu]
> [    0.861098]  amdgpu_pci_probe+0x181/0x250 [amdgpu]
> [    0.861188]  pci_device_probe+0xcd/0x140
> [    0.861191]  really_probe+0xed/0x460
> [    0.861193]  driver_probe_device+0xe3/0x150
> [    0.861195]  device_driver_attach+0x9c/0xb0
> [    0.861196]  __driver_attach+0x8a/0x150
> [    0.861197]  ? device_driver_attach+0xb0/0xb0
> [    0.861198]  ? device_driver_attach+0xb0/0xb0
> [    0.861198]  bus_for_each_dev+0x73/0xb0
> [    0.861200]  bus_add_driver+0x121/0x1e0
> [    0.861201]  driver_register+0x8a/0xe0
> [    0.861202]  ? 0xffffffffc1117000
> [    0.861203]  do_one_initcall+0x47/0x180
> [    0.861205]  ? do_init_module+0x19/0x230
> [    0.861208]  ? kmem_cache_alloc+0x182/0x260
> [    0.861210]  do_init_module+0x51/0x230
> [    0.861211]  __do_sys_finit_module+0xb1/0x110
> [    0.861213]  do_syscall_64+0x40/0xb0
> [    0.861216]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    0.861218] RIP: 0033:0x7f60a4149679
> [    0.861220] Code: 48 8d 3d 9a a1 0c 00 0f 05 eb a5 66 0f 1f 44 00 00
> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89 01 48
> [    0.861221] RSP: 002b:00007ffe25f17ea8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [    0.861223] RAX: ffffffffffffffda RBX: 000056004a10a660 RCX:
> 00007f60a4149679
> [    0.861224] RDX: 0000000000000000 RSI: 00007f60a42e9eed RDI:
> 0000000000000016
> [    0.861224] RBP: 0000000000020000 R08: 0000000000000000 R09:
> 000056004a105980
> [    0.861225] R10: 0000000000000016 R11: 0000000000000246 R12:
> 00007f60a42e9eed
> [    0.861225] R13: 0000000000000000 R14: 000056004a0efdd0 R15:
> 000056004a10a660
> [    0.861226] ---[ end trace 0319f26df48f8ef0 ]---
> [    0.861228] [drm:amdgpu_ttm_gart_bind [amdgpu]] *ERROR* failed to
> bind 1 pages at 0x00400000
> [    0.861540] amdgpu 0000:03:00.0: amdgpu: 00000000a9dfe17c bind
> failed
>
>
> Am Mittwoch, dem 19.01.2022 um 19:54 -0500 schrieb Alex Deucher:
> > On Wed, Jan 19, 2022 at 7:48 PM Bert Karwatzki <spasswolf@web.de>
> > wrote:
> > >
> > > Bisected the error and found the first bad commit to be
> > > d015e9861e55928a78137a2c95897bc50637fc47 is the first bad
> commit
> > > commit d015e9861e55928a78137a2c95897bc50637fc47
> > > Author: Jonathan Kim <jonathan.kim@amd.com>
> > > Date:   Thu Dec 9 16:48:56 2021 -0500
> > >
> > >     drm/amdgpu: improve debug VRAM access performance using sdma
> > >
> > >     For better performance during VRAM access for debugged
> > > processes, do
> > >     read/write copies over SDMA.
> > >
> > >     In order to fulfill post mortem debugging on a broken device,
> > > fallback to
> > >     stable MMIO access when gpu recovery is disabled or when job
> > > submission
> > >     time outs are set to max.  Failed SDMA access should
> > > automatically fall
> > >     back to MMIO access.
> > >
> > >     Use a pre-allocated GTT bounce buffer pre-mapped into GART to
> > > avoid
> > >     page-table updates and TLB flushes on access.
> > >
> > >     Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > >     Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> > >
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78
> > > +++++++++++++++++++++++++++++++++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  4 ++
> > >  2 files changed, 82 insertions(+)
> >
> > Should be fixed with:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tc
> >
> hwork.freedesktop.org%2Fpatch%2F470069%2F&amp;data=3D04%7C01%7Cj
> onathan.
> >
> kim%40amd.com%7C666cc32439ea492a788f08d9dbb25da2%7C3dd8961f
> e4884e608e1
> >
> 1a82d994e183d%7C0%7C0%7C637782381705599409%7CUnknown%7CT
> WFpbGZsb3d8eyJ
> >
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C2000
> >
> &amp;sdata=3Dun0a2cd1Nxcd2IIPw%2B35k01JGoLxxGsAaDteKTeQElo%3D&a
> mp;reserv
> > ed=3D0
> >
> > Alex
> >
> > >
> > >
> > > Am Donnerstag, dem 20.01.2022 um 00:22 +0100 schrieb Bert
> > > Karwatzki:
> > > > Reverting commit 72f686438de13f121c52f58d7445570a33dfdc61
> does not
> > > > change the errors:
> > > > [    1.310550] ------------[ cut here ]------------ [    1.310551]
> > > > trying to bind memory to uninitialized GART !
> > > > [    1.310556] WARNING: CPU: 9 PID: 252 at
> > > > drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:254
> > > > amdgpu_gart_bind+0x2e/0x40
> > > > [amdgpu]
> > > > [    1.310659] Modules linked in: amdgpu(+) gpu_sched i2c_algo_bit
> > > > drm_ttm_helper hid_sensor_hub ttm hid_generic nvme
> drm_kms_helper
> > > > nvme_core cec xhci_pci t10_pi r8169 rc_core crc32_pclmul
> > > > crc_t10dif i2c_hid_acpi realtek xhci_hcd psmouse crc32c_intel
> > > > crct10dif_generic i2c_hid amd_sfh mdio_devres crct10dif_pclmul
> drm
> > > > i2c_piix4 usbcore libphy crct10dif_common wmi button battery video
> > > > fjes(-) hid [    1.310672] CPU: 9 PID: 252 Comm: systemd-udevd Not
> > > > tainted 5.13.0+
> > > > #4
> > > > [    1.310673] Hardware name: Micro-Star International Co., Ltd.
> > > > Alpha
> > > > 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021 [    1.310674]
> RIP:
> > > > 0010:amdgpu_gart_bind+0x2e/0x40 [amdgpu] [    1.310762] Code:
> 00
> > > > 80 bf 34 25 00 00 00 74 14 4c 8b 8f 20 25
> > > > 00
> > > > 00
> > > > 4d 85 c9 74 05 e9 01 ff ff ff 31 c0 c3 48 c7 c7 68 36 dd c0 e8 86
> > > > db
> > > > 19
> > > > e8 <0f> 0b b8 ea ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> > > > 44
> > > > 00
> > > > [    1.310763] RSP: 0018:ffffb19d00c33920 EFLAGS: 00010282 [
> > > > 1.310764] RAX: 0000000000000000 RBX: 0000000000000067 RCX:
> > > > ffffffffa9abb208
> > > > [    1.310765] RDX: 0000000000000000 RSI: 00000000ffffefff RDI:
> > > > ffffffffa9a63200
> > > > [    1.310766] RBP: ffff985ce2a796c0 R08: 0000000000000000 R09:
> > > > ffffb19d00c33748
> > > > [    1.310766] R10: ffffb19d00c33740 R11: ffffffffa9ad3248 R12:
> > > > 0000000000000000
> > > > [    1.310766] R13: ffff985cd45a0000 R14: ffff985cd45a0000 R15:
> > > > 0000000000000000
> > > > [    1.310767] FS:  00007f69fabdc8c0(0000)
> > > > GS:ffff985f9e640000(0000)
> > > > knlGS:0000000000000000
> > > > [    1.310768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [
> > > > 1.310768] CR2: 00007f69fabc5dca CR3: 00000001139ec000 CR4:
> > > > 0000000000750ee0
> > > > [    1.310769] PKRU: 55555554
> > > > [    1.310770] Call Trace:
> > > > [    1.310772]  amdgpu_ttm_gart_bind+0x79/0xc0 [amdgpu] [
> > > > 1.310858]  amdgpu_ttm_alloc_gart+0x146/0x1a0 [amdgpu] [
> > > > 1.310942]  amdgpu_bo_create_reserved.part.0+0xf8/0x1b0
> > > > [amdgpu]
> > > > [    1.311025]  ? amdgpu_ttm_debugfs_init+0x110/0x110 [amdgpu]
> [
> > > > 1.311145]  amdgpu_bo_create_kernel+0x3b/0xa0 [amdgpu] [
> > > > 1.311229]  amdgpu_ttm_init.cold+0x165/0x17f [amdgpu] [
> > > > 1.311349]  gmc_v10_0_sw_init+0x2dc/0x430 [amdgpu]
> [    1.311455]
> > > > amdgpu_device_init.cold+0x1544/0x1b54 [amdgpu] [    1.311570]  ?
> > > > acpi_ns_get_node+0x4f/0x5a [    1.311574]  ?
> > > > acpi_get_handle+0x8e/0xb7 [    1.311576]
> > > > amdgpu_driver_load_kms+0x67/0x320 [amdgpu] [    1.311664]
> > > > amdgpu_pci_probe+0x1bc/0x290 [amdgpu] [    1.311750]
> > > > local_pci_probe+0x42/0x80 [    1.311753]  ?
> > > > __cond_resched+0x16/0x40 [    1.311755]
> > > > pci_device_probe+0xfd/0x1b0 [    1.311756]
> > > > really_probe+0xf2/0x460 [    1.311759]
> > > > driver_probe_device+0xe8/0x160 [    1.311760]
> > > > device_driver_attach+0xa1/0xb0 [    1.311761]
> > > > __driver_attach+0x8f/0x150 [    1.311763]  ?
> > > > device_driver_attach+0xb0/0xb0 [    1.311764]  ?
> > > > device_driver_attach+0xb0/0xb0 [    1.311765]
> > > > bus_for_each_dev+0x78/0xc0 [    1.311766]
> > > > bus_add_driver+0x12b/0x1e0 [    1.311768]
> > > > driver_register+0x8f/0xe0 [    1.311769]  ? 0xffffffffc1828000 [
> > > > 1.311770]  do_one_initcall+0x44/0x1d0 [    1.311772]  ?
> > > > kmem_cache_alloc_trace+0x103/0x240
> > > > [    1.311775]  do_init_module+0x5c/0x270 [    1.311777]
> > > > __do_sys_finit_module+0xb1/0x110 [    1.311779]
> > > > do_syscall_64+0x40/0xb0 [    1.311781]
> > > > entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > [    1.311783] RIP: 0033:0x7f69fb094679 [    1.311785] Code: 48 8d
> > > > 3d 9a a1 0c 00 0f 05 eb a5 66 0f 1f 44
> > > > 00
> > > > 00
> > > > 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> > > > 08
> > > > 0f
> > > > 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89
> > > > 01
> > > > 48
> > > > [    1.311786] RSP: 002b:00007ffce4131708 EFLAGS: 00000246
> > > > ORIG_RAX:
> > > > 0000000000000139
> > > > [    1.311788] RAX: ffffffffffffffda RBX: 000055d71350a3a0 RCX:
> > > > 00007f69fb094679
> > > > [    1.311788] RDX: 0000000000000000 RSI: 00007f69fb234eed RDI:
> > > > 0000000000000013
> > > > [    1.311789] RBP: 0000000000020000 R08: 0000000000000000
> R09:
> > > > 000055d7134f3930
> > > > [    1.311789] R10: 0000000000000013 R11: 0000000000000246
> R12:
> > > > 00007f69fb234eed
> > > > [    1.311790] R13: 0000000000000000 R14: 000055d7134da0f0
> R15:
> > > > 000055d71350a3a0
> > > > [    1.311791] ---[ end trace ff47998e3140e95d ]--- [    1.311793]
> > > > [drm:amdgpu_ttm_gart_bind [amdgpu]] *ERROR* failed to bind 1
> pages
> > > > at 0x00400000 [    1.312100] amdgpu 0000:03:00.0: amdgpu:
> > > > 00000000989bdfac bind failed
> > > >
> > > > and using
> > > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > >
> patchwork.freedesktop.org%2Fpatch%2F469907%2F&amp;data=3D04%7C01
> %7Cj
> > > >
> onathan.kim%40amd.com%7C666cc32439ea492a788f08d9dbb25da2%7C3
> dd8961
> > > >
> fe4884e608e11a82d994e183d%7C0%7C0%7C637782381705599409%7CU
> nknown%7
> > > >
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
> iL
> > > >
> CJXVCI6Mn0%3D%7C2000&amp;sdata=3DCA5Vz90Asz5lJsionuxAZ8iDlUIJrdW
> FqiB
> > > > UuJYbfNE%3D&amp;reserved=3D0
> > > > gives a this message:
> > > >
> > > > [    1.311502] ------------[ cut here ]------------ [    1.311502]
> > > > WARNING: CPU: 9 PID: 221 at
> > > > drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:244
> > > > amdgpu_gart_bind+0x16/0x20
> > > > [amdgpu]
> > > > [    1.311602] Modules linked in: amdgpu(+) gpu_sched i2c_algo_bit
> > > > drm_ttm_helper hid_sensor_hub ttm hid_generic nvme xhci_pci
> > > > drm_kms_helper nvme_core t10_pi xhci_hcd crc_t10dif r8169 cec
> > > > crct10dif_generic i2c_hid_acpi amd_sfh rc_core crct10dif_pclmul
> > > > realtek i2c_hid crc32_pclmul mdio_devres psmouse usbcore
> > > > crc32c_intel drm libphy i2c_piix4 crct10dif_common button wmi
> > > > battery video fjes(-
> > > > )
> > > > hid
> > > > [    1.311614] CPU: 9 PID: 221 Comm: systemd-udevd Not tainted
> > > > 5.13.0+
> > > > #6
> > > > [    1.311616] Hardware name: Micro-Star International Co., Ltd.
> > > > Alpha
> > > > 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021 [    1.311617]
> RIP:
> > > > 0010:amdgpu_gart_bind+0x16/0x20 [amdgpu] [    1.311701] Code:
> 39
> > > > df 74 aa eb dc e8 19 a2 f6 f0 66 0f 1f 84
> > > > 00
> > > > 00
> > > > 00 00 00 0f 1f 44 00 00 4c 8b 8f 20 25 00 00 4d 85 c9 74 05 e9 3a
> > > > ff ff ff <0f> 0b c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89
> > > > fd 53 0f ae [    1.311702] RSP: 0018:ffffb5be80b17948 EFLAGS:
> > > > 00010246 [    1.311703] RAX: 0000000000000022 RBX:
> > > > ffff98670583e858 RCX:
> > > > ffff98677c8a8738
> > > > [    1.311704] RDX: 0000000000000001 RSI: 0000000000400000 RDI:
> > > > ffff986720ce0000
> > > > [    1.311704] RBP: ffff986705841a08 R08: 0000000000000067 R09:
> > > > 0000000000000000
> > > > [    1.311705] R10: ffff986705841a08 R11: 0000000000000400 R12:
> > > > 0000000000000000
> > > > [    1.311705] R13: ffff98670dc50e40 R14: ffff986720ce0000 R15:
> > > > 0000000000000000
> > > > [    1.311706] FS:  00007ff4ee0968c0(0000)
> > > > GS:ffff9869de840000(0000)
> > > > knlGS:0000000000000000
> > > > [    1.311707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [
> > > > 1.311707] CR2: 00007ff4ee07fdca CR3: 000000017b436000 CR4:
> > > > 0000000000750ee0
> > > > [    1.311708] PKRU: 55555554
> > > > [    1.311708] Call Trace:
> > > > [    1.311710]  amdgpu_ttm_alloc_gart+0x147/0x190 [amdgpu] [
> > > > 1.311793]  amdgpu_bo_create_reserved.part.0+0xf8/0x1b0
> > > > [amdgpu]
> > > > [    1.311873]  ? amdgpu_ttm_debugfs_init+0x110/0x110 [amdgpu]
> [
> > > > 1.311952]  amdgpu_bo_create_kernel+0x3b/0xa0 [amdgpu] [
> > > > 1.312031]  amdgpu_ttm_init.cold+0x165/0x17f [amdgpu] [
> > > > 1.312181]  gmc_v10_0_sw_init+0x2dc/0x430 [amdgpu]
> [    1.312275]
> > > > amdgpu_device_init.cold+0x1544/0x1b54 [amdgpu] [    1.312385]  ?
> > > > acpi_ns_get_node+0x4f/0x5a [    1.312388]  ?
> > > > acpi_get_handle+0x8e/0xb7 [    1.312390]
> > > > amdgpu_driver_load_kms+0x67/0x320 [amdgpu] [    1.312479]
> > > > amdgpu_pci_probe+0x1bc/0x290 [amdgpu] [    1.312573]
> > > > local_pci_probe+0x42/0x80 [    1.312578]  ?
> > > > __cond_resched+0x16/0x40 [    1.312581]
> > > > pci_device_probe+0xfd/0x1b0 [    1.312583]
> > > > really_probe+0xf2/0x460 [    1.312587]
> > > > driver_probe_device+0xe8/0x160 [    1.312589]
> > > > device_driver_attach+0xa1/0xb0 [    1.312591]
> > > > __driver_attach+0x8f/0x150 [    1.312592]  ?
> > > > device_driver_attach+0xb0/0xb0 [    1.312593]  ?
> > > > device_driver_attach+0xb0/0xb0 [    1.312594]
> > > > bus_for_each_dev+0x78/0xc0 [    1.312595]
> > > > bus_add_driver+0x12b/0x1e0 [    1.312597]
> > > > driver_register+0x8f/0xe0 [    1.312598]  ? 0xffffffffc1696000 [
> > > > 1.312599]  do_one_initcall+0x44/0x1d0 [    1.312602]  ?
> > > > kmem_cache_alloc_trace+0x103/0x240
> > > > [    1.312604]  do_init_module+0x5c/0x270 [    1.312606]
> > > > __do_sys_finit_module+0xb1/0x110 [    1.312608]
> > > > do_syscall_64+0x40/0xb0 [    1.312610]
> > > > entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > [    1.312614] RIP: 0033:0x7ff4ee54e679 [    1.312616] Code: 48 8d
> > > > 3d 9a a1 0c 00 0f 05 eb a5 66 0f 1f 44
> > > > 00
> > > > 00
> > > > 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> > > > 08
> > > > 0f
> > > > 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 57 0c 00 f7 d8 64 89
> > > > 01
> > > > 48
> > > > [    1.312617] RSP: 002b:00007fff9c9d5bc8 EFLAGS: 00000246
> > > > ORIG_RAX:
> > > > 0000000000000139
> > > > [    1.312618] RAX: ffffffffffffffda RBX: 000055aca9cf9230 RCX:
> > > > 00007ff4ee54e679
> > > > [    1.312619] RDX: 0000000000000000 RSI: 00007ff4ee6eeeed RDI:
> > > > 0000000000000013
> > > > [    1.312619] RBP: 0000000000020000 R08: 0000000000000000
> R09:
> > > > 000055aca9cdf480
> > > > [    1.312620] R10: 0000000000000013 R11: 0000000000000246
> R12:
> > > > 00007ff4ee6eeeed
> > > > [    1.312620] R13: 0000000000000000 R14: 000055aca9cf9ab0 R15:
> > > > 000055aca9cf9230
> > > > [    1.312622] ---[ end trace c4fc99f16e2a1eb7 ]---
> > > >
> > > > In both cases there's a similar error message for the oth GPU in
> > > > the system (the integrated one at 08:00.0)
> > > >
> > > > Am Mittwoch, dem 19.01.2022 um 23:40 +0100 schrieb Das, Nirmoy:
> > > > >
> > > > > On 1/19/2022 10:59 PM, Limonciello, Mario wrote:
> > > > > > [Public]
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Bert Karwatzki <spasswolf@web.de>
> > > > > > > Sent: Wednesday, January 19, 2022 15:52
> > > > > > > To: amd-gfx@lists.freedesktop.org
> > > > > > > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>;
> > > > > > > Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Zhuo,
> > > > > > > Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Scott Bruce
> > > > > > > <smbruce@gmail.com>; Alex Deucher
> <alexdeucher@gmail.com>;
> > > > > > > Chris Hixon <linux-kernel-bugs@hixontech.com>
> > > > > > > Subject: amd-staging-drm-next breaks suspend
> > > > > > >
> > > > > > > I just tested drm-staging-drm-next with HEAD
> > > > > > > f1b2924ee6929cb431440e6f961f06eb65d52beb:
> > > > > > > Going into suspend leads to a hang again:
> > > > > > > This is probably caused by
> > > > > > > [ 1.310551] trying to bind memory to uninitialized GART !
> > > > > > > and/or
> > > > > > > [ 3.976438] trying to bind memory to uninitialized GART !
> > > > >
> > > > >
> > > > > Could you please also try
> > > > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tchwork.freedesktop.org%2Fpatch%2F469907%2F&amp;data=3D04%7C01%7
> Cjonathan.kim%40amd.com%7C666cc32439ea492a788f08d9dbb25da2%7
> C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63778238170559
> 9409%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3DCA5Vz90A
> sz5lJsionuxAZ8iDlUIJrdWFqiBUuJYbfNE%3D&amp;reserved=3D0 ?
> > > > >
> > > > >
> > > > > Regards,
> > > > >
> > > > > Nirmoy
> > > > >
> > > > > > >
> > >

