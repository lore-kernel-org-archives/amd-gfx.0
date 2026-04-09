Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784E8EA3C4E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 13:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DED10E204;
	Thu,  9 Apr 2026 13:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wO9SjGAn";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0162710E204
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 13:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD+n3qyGPlvj96IYHX2EVhwLtA8Sh1dmU99RSOGF7/y32HNIwr/Ye1VCYeh9IgCOuYdQ4fD0mhbWUTwFxkk15e8oYLi1L9ln/TTwaqGXc4+8bo7cSOZnsv9s3MqOR1nuu4LCmHVXEAkz/GtofaPV0ya2A4k6/EiARWrWWhPf93hD2Dpdi1Xa1pFlcq1peqgFiPdK3X85FXhG/QY2P3h4Nvl41sSgVgPYqnR5++7JCKEQGKr4DtC5/3jgDIPhXc3Gh+JXZTq+rnlkMxCfzD+SfRPVm0R2TipzEuPL+l07iZAU1KatJFLn7HcPQHNXTa3uHsFvBBDf7Tq+6xWWsysBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFcRqB0+OHZBcuvNWOhpLV/1pS6KYNaVFwpKakoQBi0=;
 b=fy+hYYgflQyEDEMD3PbkOkOhDhobzk6A/HzpYNxOHOOGTrLJAHaTce+bX8sbkEiSw1iBWjFbRC/wvRBAv0CYvV6QU1RH18/pDDnTYCTAOiizPlRdWmCOv5pmnP+4TlLmjvj300DAZZfCGf25qWnpNC5p3Rlq00+OkZPEhaNSPKSNDhw3ZV+XXxXayPOmR3AeoLpz+3u3y+qMFY8tj/VZGeSZI8Mk8W9mMLGbnegstIi+x/HQ05p7UBbOKlDo09gIRSJVEZNqlZzL3raBEd1MNcP9PPWCQYZ7qeiwbbmifhybX1SY/bAtoCr2Ne/oHVgl76kFe2tuLzAM0EEpDbeHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFcRqB0+OHZBcuvNWOhpLV/1pS6KYNaVFwpKakoQBi0=;
 b=wO9SjGAn8cFvzxOBmVZbAVCu4rw+HPWJp8LWRvz0gu7qVgmBakxz0uzTXIOwMCRvslZahwj6L555ExCxDiY8TLJ/wtcFwtQzEGdYrike6GPUBab5ueAVU1g7YnsGI3p0xvTfuMlMdhJ+Af8ooAvg9i4GEuJOue+f81rBepWCw1s=
Received: from IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 by SA5PPFD911547FB.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 13:30:10 +0000
Received: from IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2]) by IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 13:30:09 +0000
From: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
CC: "Varone, Dillon" <Dillon.Varone@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.org"
 <linux-next@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
 <linux-rt-devel@lists.linux.dev>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
Thread-Topic: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
Thread-Index: AQHcyCLT+fim4XOC0kmlAbF0I1GUirXWuPGT
Date: Thu, 9 Apr 2026 13:30:09 +0000
Message-ID: <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
In-Reply-To: <20260409131411.10598-1-spasswolf@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-09T13:30:09.449Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6307:EE_|SA5PPFD911547FB:EE_
x-ms-office365-filtering-correlation-id: 09f4aa02-8b5a-45c6-4a46-08de963c1f27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|8096899003|38070700021;
x-microsoft-antispam-message-info: r47f4D8DZocmUQS7cC6vQCIfDy5qyK8vRlbP/0sDwoUuY841X8ONx8Au4yB/6Z2b52dcpdBkMIehijJJM2w1UeWf7cFkkmbUhgKtQhb4a557Hnd7HsUzgw0oqpKGAM2/P/73iN5FN1fXGZmK0FAmOID6axMHUDCROmSRj2VXaPwzSGALesIm6cUoOXkHT8vF16vFnxiZr/PriUoyCebRTiA213iCdwuvAFWEU3Ok/ai8+CzOxsuxy7/zZ5OSulnmi1ugQrgZ7Phb0wJYBSbgKXF3ryd5ZKDjOnylO0GUtp7jLZNbzOO0F9lip+DLZyTnvxL2nPrUi1uU1xqS4DTkVMPDao1vvZSNSbzhsbjSd5Ls2n4b8mMm7garb2tTF27NjXxGXtcIKE8wcXHDCVXJZrrCGaiFheRl8SsS8oHDVhoTh76q1rDz91r7/desng5E98KBNEHu9zSSS5DdI5H4/4kOnxsQo4YStgaYv75QCjigHyGBG9To/nsU0QG7cdnm8hDDX/ajs1757t1TTVOXlYLFPULpMlX6p0jfF+5sc2Ce1k3uGdRz9na1vFj4QV/G+c7ELz5+m81Ax7IsOUYsXnjr24BSWDcSp35i+13v9r6qAJmdHJ1T9XNXcpxi+3xIb+spWjrNQ3DVxAS9uYjIRnLUtOa0wcMOMGD/9MTworBoa36JO+vIWsmqWEQrYHNF/aV07+hpu56+1BxsKbDF83RWU3jPyD0KdzNst05sB2zVeRyKvQUHmS9Ng8RHOknY3v+oDzBHYPwStSVV0DiiQaT7RPoW65Z76XpqgyRLz2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gAXHscBXj2DRxWx7TtXkfAnU853MVGClpDF4KqfbdP7pXF9o828CZkMKLm?=
 =?iso-8859-1?Q?mt6XPJ+ZFGq8w4Ntr0WO3x2++OJFjScCsGyRoqaRDLLM/UnaqY7R6Gu524?=
 =?iso-8859-1?Q?QwGdta1vrNPBb5Wr7Zb7mTbWTXR5+3DojgLBQM1YgNpMu0iqRub438U7OA?=
 =?iso-8859-1?Q?cMjBDWgyY0+Im6Uwe94CZc/fv7c1pIz4gkOBhu06FVOM7KHEUMrT5SWep1?=
 =?iso-8859-1?Q?K4KBtlU+hNKxdSy6PFRoOtSSQBI233Oyxfn2hmQpWo0A11diU4L9inPgTL?=
 =?iso-8859-1?Q?M/RXa1G4i+ap62tF0Hkl3nSHwcLTw/ESWsy4eXBUr9wwP4oaLIdbNM3flz?=
 =?iso-8859-1?Q?VpmoFSHAW9EVtAo1NRFUbaF1EEJ4JO41p43cCelRm56Wj6DaMQEsMqsLyF?=
 =?iso-8859-1?Q?7WFR5HGxN3zfiCsrmzr+LQkFoJOzQosWopt6LkDUTH8x5RqaGgjNplYP7R?=
 =?iso-8859-1?Q?MBtspDJAjyNmuRUGFRSPq0PqsXDp3DRofd79H4l20rb712ekbqF+Dlj2l+?=
 =?iso-8859-1?Q?6z9rcHVnF1yqV2J54GK03ImCWazJCJY5QTHZROxOzrt/dceF7YsasKyNex?=
 =?iso-8859-1?Q?9OqheOp2kwPSi8kod+88lA4cXYapYA941KLvTHe9O+tlOJmUDCVfNLAib2?=
 =?iso-8859-1?Q?NKWmKUsEAZZrshC3XqykSPDuh93kzwdgKYLz1q7UMkUl6JtqvRhukRW4Tq?=
 =?iso-8859-1?Q?XAYsdzI0P4ceqJctf/7wwSZH8EQ8m1kjSrrHS7fHq8JO1gnl7O+akovxu2?=
 =?iso-8859-1?Q?nSyMZg+AQGhuIfiB8OPBRF0JbnopkhruiU0p+tJPZcR3r9EY0C6WmDkWh4?=
 =?iso-8859-1?Q?CZTjBEKFKoisTIVe6i6t/EMGEpFLHU9JMzmMfRf8nwFLXJP1N1On1iC1iJ?=
 =?iso-8859-1?Q?jsIocG5S8adoGmmaTxYDXdFAXyqthUEpuzlp+514h4mwzEWSabzbdTv/MD?=
 =?iso-8859-1?Q?OuCnZecWzm6bqc/NMTdLc8nvlvXbUD2L+Qcst43e7CXg9yrCmN77EeehXb?=
 =?iso-8859-1?Q?4h5zSWnYtIY180FSkuiqYYwqOtGpGsej2VIVvSvdeB6C2IQRqEZtqcE6uh?=
 =?iso-8859-1?Q?4IvKgkYaO/sLZ6ozE65RunBTpQXj5ueeJ1oBkK8bzkPk4b1Rs9vlEsobAx?=
 =?iso-8859-1?Q?8X241ofNBnA68lpkeaekm9lvijivAJ0+Knsf9SZ2fPxL+Dd4ip5PXqNIZJ?=
 =?iso-8859-1?Q?lBFLO4czqW+4lKDyEbyCZz9S8LsQ/b5kpxi1VUI3akWcYeoHMK1sjvMEV4?=
 =?iso-8859-1?Q?oXOlUi47owaYfgwWqXdUMUCD5x3P0MLp6Eig14qbvnFmNBYqxXn3dqAjqs?=
 =?iso-8859-1?Q?iCY28EVntrfZ2hwC9phVebhZ+LGsNlP7zEnHszLyFRLb3DEBqq0SJS7WTi?=
 =?iso-8859-1?Q?mhofhaGhcUX8FzcDMomHyUMyP3gwjz1WLatlPHFi7WvphrMcJxIXNEVrLM?=
 =?iso-8859-1?Q?ojkVNtXRfsWT7LY5QHqT0OaZEfJTPz3eKR2MlVJ7IaJj6qLn424pPrIIRL?=
 =?iso-8859-1?Q?4JQWpdq/a9KOVd5k5maYOclFdqfk2siFIfR2wflEyYT1GL5MqmBWo+AGPY?=
 =?iso-8859-1?Q?yKgZ+OtyPPjjBLDrztqKkb7naaCdF0TPfrhvH/+Qa0PCKMMTnpoykgKuHO?=
 =?iso-8859-1?Q?V5P3HGcVF+PVDBIfWzO2GkWnq4GmvltJTwrhtGSEwZeVUyFVD6khl9VtH6?=
 =?iso-8859-1?Q?3JObNdKogjxZO7iqV57ZDf4baKCELROvfNuRISmqAgKIY6tckiJRmZpNc9?=
 =?iso-8859-1?Q?TsudLOMo2iFvaZ5RYgGSfVUCGNDqxlWA6RoZXib2r+1+I1?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB6307858BAECC7CC3AE8AA958F8582IA1PR12MB6307namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6307.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f4aa02-8b5a-45c6-4a46-08de963c1f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 13:30:09.7991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGOzjBB1ZloxCDln6GpKTMABgadFpJxQCJi8W57rf4T2I1Lms6nADaQqC7ABRC1V95TrsdCsEqJ8eVnyJtUdbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB
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

--_000_IA1PR12MB6307858BAECC7CC3AE8AA958F8582IA1PR12MB6307namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bert,

Sorry that you experience this issue.

Do you have all these 3 patches?:
"drm/amd/display: Move FPU Guards From DML To DC - Part 1"
"drm/amd/display: Move FPU Guards From DML To DC - Part 2"
"drm/amd/display: Move FPU Guards From DML To DC - Part 3"

These are highly dependent on each other.

Kind Regards,
Rafal


________________________________
From: Bert Karwatzki <spasswolf@web.de>
Sent: Thursday, April 9, 2026 3:14 PM
To: Ostrowski, Rafal <Rafal.Ostrowski@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>; Varone, Dillon <Dillon.Varone@amd.co=
m>; Hung, Alex <Alex.Hung@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>; Thomas Gleixner=
 <tglx@linutronix.de>; linux-kernel@vger.kernel.org <linux-kernel@vger.kern=
el.org>; linux-next@vger.kernel.org <linux-next@vger.kernel.org>; linux-rt-=
devel@lists.linux.dev <linux-rt-devel@lists.linux.dev>; amd-gfx@lists.freed=
esktop.org <amd-gfx@lists.freedesktop.org>
Subject: kernel panic when resuming from hibernate in next-20260406 with PR=
EEMPT_RT

I noticed that my debian stable (trixie) system running linux next-20260406
would sometimes hang when resuming from hibernate (I also had two similar e=
rrors
under different circumstances, one just after booting and one when starting=
 the
game stellaris, but hibernate seems to be the best way to provoke this erro=
r).
There are usually no error messages, but once I got this (incomplete) error=
 (via drm panic "kmsg"):

[ 51.556812][ C0]  gpio_amdpt gpio_generic
[ 51.556817][ C0] ---[ end trace 0000000000000000 ]--- (the start tag is no=
t present in the qr_code)
[ 52.616208][ C0] RIP: 0010:__get_vm_area_node+0x140/0x150
[ 52.616214][ C0] Code: 00 00 ff c5 39 c5 0f 4c e8 b8 1e 00 00 00 39 c5 0f =
4f e8 c4 e2 d1 f7 ea e9 3e ff ff ff 4c 89 e7 e8 35 48 01 00 45 31 e4 eb b0 =
<0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 40 d6 41 50
[ 52.616215][ C0] RSP: 0010:ffffae404dcc3818 EFLAGS: 00010206
[ 52.616217][ C0] RAX: 0000000000ff0000 RBX: 000000000000000c RCX: 00000000=
00000022
[ 52.616217][ C0] RDX: 0000000000ff0000 RSI: 0000000000000001 RDI: 00000000=
0000f720
[ 52.616218][ C0] RBP: 000000000000000c R08: ffffae4040000000 R09: ffffce40=
3fffffff
[ 52.616218][ C0] R10: ffffce403fffffff R11: 0000000000000006 R12: ffff9f28=
9d400000
[ 52.616219][ C0] R13: ffff9f289d6e9fd0 R14: 0000000000000dc0 R15: 00000000=
0000f720
[ 52.616220][ C0] FS:  00007f814cdc9b40(0000) GS:ffff9f383a215000(0000) knl=
GS:0000000000000000
[ 52.616220][ C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000000050033
[ 52.616221][ C0] CR2: 00007f8134000020 CR3: 0000000201867000 CR4: 00000000=
00f50ef0
[ 52.616221][ C0] PKRU: 55555554
[ 52.616222][ C0] Kernel panic - not syncing: Fatal exception in interrupt
[ 52.616302][ C0] Kenrel Offset: 0xc00000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)

I also got a really nice huge qrcode (via drm panic "qr_code") which showed=
 a little more of the message, but not
the beginning of the trace:

[ 125.266334][ C17] RSP: 002b:00007ffc1fcae230 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000010
[ 125.266335][ C17] RAX: ffffffffffffffda RBX: 000055845b640060 RCX: 00007f=
b699e8e91b
[ 125.266335][ C17] RDX: 00007ffc1fcae2d0 RSI: 00000000c05064a7 RDI: 000000=
000000000f
[ 125.266336][ C17] RBP: 00007ffc1fcae2d0 R08: 0000000000000060 R09: 000000=
0000000000
[ 125.266336][ C17] R10: 0000000000000003 R11: 0000000000000246 R12: 000000=
00c05064a7
[ 125.266336][ C17] R13: 000000000000000f R14: 00000000c05064a7 R15: 00007f=
fc1fcae2d0
[ 125.266337][ C17] &lt;/TASK&gt;
[ 125.266337][ C17] Modules linked in: ccm snd_usb_audio joydev snd_usbmidi=
_lib snd_ump snd_rawmidi snd_seq_dummy snd_hrtimer snd_seq snd_seq_device n=
ls_ascii nls_cp437 vfat fat mt7925e mt7925_common mt792x_lib mt76_connac_li=
b mt76 intel_rapl_msr snd_hda_codec_atihdmi mac80211 intel_rapl_common snd_=
hda_codec_hdmi iosf_mbi snd_hda_intel rapl snd_hda_codec wmi_bmof snd_hda_c=
ore spd5118 regmap_i2c snd_intel_dspcfg snd_hwdep snd_pcm libarc4 snd_timer=
 cfg80211 snd soundcore pcspkr rfkill ccp k10temp evdev nct6775 nct6775_cor=
e hwmon_vid configfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 hid_gene=
ric usbhid hid amdgpu drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper =
ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sc=
hed amdxcp drm_display_helper xhci_pci xhci_hcd drm_kms_helper ahci libahci=
 drm libata usbcore nvme scsi_mod igc nvme_core cec i2c_piix4 scsi_common v=
ideo usb_common nvme_keyring crc16 i2c_smbus nvme_auth wmi hkdf gpio_amdpt =
gpio_generic
[ 125.266351][ C17] ---[ end trace 0000000000000000 ]---
[ 126.356624][ C17] RIP: 0010:__get_vm_area_node+0x140/0x150
[ 126.356631][ C17] Code: 00 00 ff c5 39 c5 0f 4c e8 b8 1e 00 00 00 39 c5 0=
f 4f e8 c4 e2 d1 f7 ea e9 3e ff ff ff 4c 89 e7 e8 f5 49 01 00 45 31 e4 eb b=
0 &lt;0f&gt; 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 40 d6 41 50
[ 126.356633][ C17] RSP: 0018:ffffb50f075275f8 EFLAGS: 00010206
[ 126.356635][ C17] RAX: 0000000000ff0000 RBX: 000000000000000c RCX: 000000=
0000000022
[ 126.356636][ C17] RDX: 0000000000ff0000 RSI: 0000000000000001 RDI: 000000=
000000f720
[ 126.356637][ C17] RBP: 000000000000000c R08: ffffb50f00000000 R09: ffffd5=
0effffffff
[ 126.356637][ C17] R10: ffffd50effffffff R11: 0000000000000006 R12: ffff90=
90a6000000
[ 126.356638][ C17] R13: ffff9090a62e9fd0 R14: 000000000000f720 R15: 000000=
0000000dc0
[ 126.356639][ C17] FS: 00007fb699b0eb40(0000) GS:ffff90a00a848000(0000) kn=
lGS:0000000000000000
[ 126.356640][ C17] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 126.356640][ C17] CR2: 00007f617c3fa02f CR3: 00000001a0c4e000 CR4: 000000=
0000f50ef0
[ 126.356641][ C17] PKRU: 55555554
[ 126.356642][ C17] Kernel panic - not syncing: Fatal exception in interrup=
t
[ 126.356811][ C17] Kernel Offset: 0x30a00000 from 0xffffffff81000000 (relo=
cation range: 0xffffffff80000000-0xffffffffbfffffff)

Hardware used:
$ lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge IOM=
MU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e Internal GPP Bridge to Bus [C:A]
00:08.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e Internal GPP Bridge to Bus [C:A]
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 71)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upstr=
eam Port of PCI Express Switch (rev 25)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downs=
tream Port of PCI Express Switch (rev 25)
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] N=
avi 44 [RX 9060 XT] (rev c0)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 48 HDMI/D=
P Audio Controller
04:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD=
 9100 PRO [PM9E1]
05:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Upstream Port (rev 01)
06:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:0c.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
06:0d.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)
08:00.0 Ethernet controller: Intel Corporation Ethernet Controller I226-V (=
rev 06)
09:00.0 Network controller: MEDIATEK Corp. Device 7925
0b:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] 800 Series Chips=
et USB 3.x XHCI Controller (rev 01)
0c:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] 600 Series Chip=
set SATA Controller (rev 01)
0d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. =
[AMD] Raphael/Granite Ridge PCIe Dummy Function (rev c1)
0d:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 19=
h PSP/CCP
0d:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 3.1 xHCI
0d:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 3.1 xHCI
0e:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 2.0 xHCI

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 26
model           : 68
model name      : AMD Ryzen 9 9950X 16-Core Processor
stepping        : 0
microcode       : 0xb404035
cpu MHz         : 624.194
cache size      : 1024 KB
physical id     : 0
siblings        : 32
core id         : 0
cpu cores       : 16
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 16
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe=
1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl xtopology nonstop_tsc c=
puid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_=
1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm exta=
pic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce =
topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpuid_fault cpb ca=
t_l3 cdp_l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmm=
call fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f=
 avx512dq rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni avx512=
bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_to=
tal cqm_mbm_local user_shstk avx_vnni avx512_bf16 clzero irperf xsaveerptr =
rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean f=
lushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif =
x2avic v_spec_ctrl vnmi avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes vp=
clmulqdq avx512_vnni avx512_bitalg avx512_vpopcntdq rdpid bus_lock_detect m=
ovdiri movdir64b overflow_recov succor smca fsrm avx512_vp2intersect flush_=
l1d amd_lbr_pmc_freeze
bugs            : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass s=
rso spectre_v2_user vmscape
bogomips        : 8599.99
TLB size        : 192 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

As the error does not occur in v7.0-rc7 I bisected the issue, declaring a c=
ommit as GOOD
when it passes 18 hibernate/resumes cycles (the issue is not 100% reproduci=
ble)

All these kernel are compiled with PREEMPT_RT:
7.0.0-rc7                            18 hibernate/resume cycles withot cras=
h, GOOD
7.0.0-rc7-next-20260406-master       crash on 1st resume, BAD
7.0.0-rc7-bisect-06060-g00f03539e3d9 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc7-bisect-09155-g9a6b64640388 crash on 1st resume, BAD
7.0.0-rc4-bisect-01504-g8e005ef09ba5 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc7-bisect-08350-gb82dff8ab846 crash on 4th resume, BAD
7.0.0-rc7-bisect-06517-ga03c0f5a4d5f 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc6-bisect-01673-gcdd65e8bb954 crash on 6th resume, BAD
7.0.0-rc4-bisect-00705-g02ade2557eba 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc4-bisect-01453-g353f20082505 crash on 8th resume, BAD
7.0.0-rc4-bisect-01428-g4c3aeb11d504 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc4-bisect-01440-g60c741a13fd1 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc4-bisect-01446-g32c1c35b6d8b crash on 12th resume, BAD
7.0.0-rc4-bisect-01443-g02c3060ee303 18 hibernate/resume cycles without cra=
sh, GOOD
7.0.0-rc4-bisect-01445-g4bb2f0721ed8 crash on 1st resume, BAD
7.0.0-rc4-bisect-01444-g3539437f354b crash on 3rd resume, BAD

The result of the bisection points to
commit 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Par=
t 1")
as the first bad commit.

As the offending commit contains preemption related macros I tried commit
3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
without PREEMPT_RT and got no error in 24 cycles:
7.0.0-rc4-nort-01444-g3539437f354b 24 hibernate/resume cycles without crash

Any Ideas?

Bert Karwatzki



--_000_IA1PR12MB6307858BAECC7CC3AE8AA958F8582IA1PR12MB6307namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Bert,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sorry that you experience this issue.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Do you have all these 3 patches?:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&quot;drm/amd/display: Move FPU Guards From DML To DC - Part 1&quot;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&quot;drm/amd/display: Move FPU Guards From DML To DC - Part 2&quot;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&quot;drm/amd/display: Move FPU Guards From DML To DC - Part 3&quot;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
These are highly dependent on each other.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Kind Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Rafal</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Bert Karwatzki &lt;spasswolf@web.de&gt;<br>
<b>Sent:</b>&nbsp;Thursday, April 9, 2026 3:14 PM<br>
<b>To:</b>&nbsp;Ostrowski, Rafal &lt;Rafal.Ostrowski@amd.com&gt;<br>
<b>Cc:</b>&nbsp;Bert Karwatzki &lt;spasswolf@web.de&gt;; Varone, Dillon &lt=
;Dillon.Varone@amd.com&gt;; Hung, Alex &lt;Alex.Hung@amd.com&gt;; Deucher, =
Alexander &lt;Alexander.Deucher@amd.com&gt;; Sebastian Andrzej Siewior &lt;=
bigeasy@linutronix.de&gt;; Thomas Gleixner &lt;tglx@linutronix.de&gt;; linu=
x-kernel@vger.kernel.org
 &lt;linux-kernel@vger.kernel.org&gt;; linux-next@vger.kernel.org &lt;linux=
-next@vger.kernel.org&gt;; linux-rt-devel@lists.linux.dev &lt;linux-rt-deve=
l@lists.linux.dev&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.free=
desktop.org&gt;<br>
<b>Subject:</b>&nbsp;kernel panic when resuming from hibernate in next-2026=
0406 with PREEMPT_RT
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">I noticed that my debian stable (trixie) sy=
stem running linux next-20260406<br>
would sometimes hang when resuming from hibernate (I also had two similar e=
rrors<br>
under different circumstances, one just after booting and one when starting=
 the<br>
game stellaris, but hibernate seems to be the best way to provoke this erro=
r).<br>
There are usually no error messages, but once I got this (incomplete) error=
 (via drm panic &quot;kmsg&quot;):<br>
<br>
[ 51.556812][ C0]&nbsp; gpio_amdpt gpio_generic<br>
[ 51.556817][ C0] ---[ end trace 0000000000000000 ]--- (the start tag is no=
t present in the qr_code)<br>
[ 52.616208][ C0] RIP: 0010:__get_vm_area_node+0x140/0x150<br>
[ 52.616214][ C0] Code: 00 00 ff c5 39 c5 0f 4c e8 b8 1e 00 00 00 39 c5 0f =
4f e8 c4 e2 d1 f7 ea e9 3e ff ff ff 4c 89 e7 e8 35 48 01 00 45 31 e4 eb b0 =
&lt;0f&gt; 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 40 d6 41 50<b=
r>
[ 52.616215][ C0] RSP: 0010:ffffae404dcc3818 EFLAGS: 00010206<br>
[ 52.616217][ C0] RAX: 0000000000ff0000 RBX: 000000000000000c RCX: 00000000=
00000022<br>
[ 52.616217][ C0] RDX: 0000000000ff0000 RSI: 0000000000000001 RDI: 00000000=
0000f720<br>
[ 52.616218][ C0] RBP: 000000000000000c R08: ffffae4040000000 R09: ffffce40=
3fffffff<br>
[ 52.616218][ C0] R10: ffffce403fffffff R11: 0000000000000006 R12: ffff9f28=
9d400000<br>
[ 52.616219][ C0] R13: ffff9f289d6e9fd0 R14: 0000000000000dc0 R15: 00000000=
0000f720<br>
[ 52.616220][ C0] FS:&nbsp; 00007f814cdc9b40(0000) GS:ffff9f383a215000(0000=
) knlGS:0000000000000000<br>
[ 52.616220][ C0] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000000050033<br=
>
[ 52.616221][ C0] CR2: 00007f8134000020 CR3: 0000000201867000 CR4: 00000000=
00f50ef0<br>
[ 52.616221][ C0] PKRU: 55555554<br>
[ 52.616222][ C0] Kernel panic - not syncing: Fatal exception in interrupt<=
br>
[ 52.616302][ C0] Kenrel Offset: 0xc00000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)<br>
<br>
I also got a really nice huge qrcode (via drm panic &quot;qr_code&quot;) wh=
ich showed a little more of the message, but not<br>
the beginning of the trace:<br>
<br>
[ 125.266334][ C17] RSP: 002b:00007ffc1fcae230 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000010<br>
[ 125.266335][ C17] RAX: ffffffffffffffda RBX: 000055845b640060 RCX: 00007f=
b699e8e91b<br>
[ 125.266335][ C17] RDX: 00007ffc1fcae2d0 RSI: 00000000c05064a7 RDI: 000000=
000000000f<br>
[ 125.266336][ C17] RBP: 00007ffc1fcae2d0 R08: 0000000000000060 R09: 000000=
0000000000<br>
[ 125.266336][ C17] R10: 0000000000000003 R11: 0000000000000246 R12: 000000=
00c05064a7<br>
[ 125.266336][ C17] R13: 000000000000000f R14: 00000000c05064a7 R15: 00007f=
fc1fcae2d0<br>
[ 125.266337][ C17] &amp;lt;/TASK&amp;gt;<br>
[ 125.266337][ C17] Modules linked in: ccm snd_usb_audio joydev snd_usbmidi=
_lib snd_ump snd_rawmidi snd_seq_dummy snd_hrtimer snd_seq snd_seq_device n=
ls_ascii nls_cp437 vfat fat mt7925e mt7925_common mt792x_lib mt76_connac_li=
b mt76 intel_rapl_msr snd_hda_codec_atihdmi
 mac80211 intel_rapl_common snd_hda_codec_hdmi iosf_mbi snd_hda_intel rapl =
snd_hda_codec wmi_bmof snd_hda_core spd5118 regmap_i2c snd_intel_dspcfg snd=
_hwdep snd_pcm libarc4 snd_timer cfg80211 snd soundcore pcspkr rfkill ccp k=
10temp evdev nct6775 nct6775_core
 hwmon_vid configfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 hid_gener=
ic usbhid hid amdgpu drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper t=
tm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sch=
ed amdxcp drm_display_helper xhci_pci
 xhci_hcd drm_kms_helper ahci libahci drm libata usbcore nvme scsi_mod igc =
nvme_core cec i2c_piix4 scsi_common video usb_common nvme_keyring crc16 i2c=
_smbus nvme_auth wmi hkdf gpio_amdpt gpio_generic<br>
[ 125.266351][ C17] ---[ end trace 0000000000000000 ]---<br>
[ 126.356624][ C17] RIP: 0010:__get_vm_area_node+0x140/0x150<br>
[ 126.356631][ C17] Code: 00 00 ff c5 39 c5 0f 4c e8 b8 1e 00 00 00 39 c5 0=
f 4f e8 c4 e2 d1 f7 ea e9 3e ff ff ff 4c 89 e7 e8 f5 49 01 00 45 31 e4 eb b=
0 &amp;lt;0f&amp;gt; 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 40 =
d6 41 50<br>
[ 126.356633][ C17] RSP: 0018:ffffb50f075275f8 EFLAGS: 00010206<br>
[ 126.356635][ C17] RAX: 0000000000ff0000 RBX: 000000000000000c RCX: 000000=
0000000022<br>
[ 126.356636][ C17] RDX: 0000000000ff0000 RSI: 0000000000000001 RDI: 000000=
000000f720<br>
[ 126.356637][ C17] RBP: 000000000000000c R08: ffffb50f00000000 R09: ffffd5=
0effffffff<br>
[ 126.356637][ C17] R10: ffffd50effffffff R11: 0000000000000006 R12: ffff90=
90a6000000<br>
[ 126.356638][ C17] R13: ffff9090a62e9fd0 R14: 000000000000f720 R15: 000000=
0000000dc0<br>
[ 126.356639][ C17] FS: 00007fb699b0eb40(0000) GS:ffff90a00a848000(0000) kn=
lGS:0000000000000000<br>
[ 126.356640][ C17] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
[ 126.356640][ C17] CR2: 00007f617c3fa02f CR3: 00000001a0c4e000 CR4: 000000=
0000f50ef0<br>
[ 126.356641][ C17] PKRU: 55555554<br>
[ 126.356642][ C17] Kernel panic - not syncing: Fatal exception in interrup=
t<br>
[ 126.356811][ C17] Kernel Offset: 0x30a00000 from 0xffffffff81000000 (relo=
cation range: 0xffffffff80000000-0xffffffffbfffffff)<br>
<br>
Hardware used:<br>
$ lspci<br>
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Root Complex<br>
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge IOM=
MU<br>
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge<br>
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge<br>
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge<br>
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge<br>
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e GPP Bridge<br>
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge<br>
00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge<br>
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Dummy Host Bridge<br>
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e Internal GPP Bridge to Bus [C:A]<br>
00:08.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e Internal GPP Bridge to Bus [C:A]<br>
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 71)<br>
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
51)<br>
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 0<br>
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 1<br>
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 2<br>
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 3<br>
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 4<br>
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 5<br>
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 6<br>
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Rid=
ge Data Fabric; Function 7<br>
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upstr=
eam Port of PCI Express Switch (rev 25)<br>
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downs=
tream Port of PCI Express Switch (rev 25)<br>
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] N=
avi 44 [RX 9060 XT] (rev c0)<br>
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 48 HDMI/D=
P Audio Controller<br>
04:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD=
 9100 PRO [PM9E1]<br>
05:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Upstream Port (rev 01)<br>
06:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)<br>
06:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)<br>
06:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)<br>
06:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)<br>
06:0c.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)<br>
06:0d.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset P=
CIe Switch Downstream Port (rev 01)<br>
08:00.0 Ethernet controller: Intel Corporation Ethernet Controller I226-V (=
rev 06)<br>
09:00.0 Network controller: MEDIATEK Corp. Device 7925<br>
0b:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] 800 Series Chips=
et USB 3.x XHCI Controller (rev 01)<br>
0c:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] 600 Series Chip=
set SATA Controller (rev 01)<br>
0d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. =
[AMD] Raphael/Granite Ridge PCIe Dummy Function (rev c1)<br>
0d:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 19=
h PSP/CCP<br>
0d:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 3.1 xHCI<br>
0d:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 3.1 xHCI<br>
0e:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite =
Ridge USB 2.0 xHCI<br>
<br>
$ cat /proc/cpuinfo<br>
processor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<br>
vendor_id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : AuthenticAMD<br>
cpu family&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 26<br>
model&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 68<br>
model name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : AMD Ryzen 9 9950X 16-Core Proces=
sor<br>
stepping&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<br>
microcode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xb404035<br>
cpu MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 624.194<br>
cache size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 1024 KB<br>
physical id&nbsp;&nbsp;&nbsp;&nbsp; : 0<br>
siblings&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 32<br>
core id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<br>
cpu cores&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 16<br>
apicid&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<br>
initial apicid&nbsp; : 0<br>
fpu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 : yes<br>
fpu_exception&nbsp;&nbsp; : yes<br>
cpuid level&nbsp;&nbsp;&nbsp;&nbsp; : 16<br>
wp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; : yes<br>
flags&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : fpu vme=
 de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mm=
x fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_ts=
c rep_good amd_lbr_v2 nopl xtopology nonstop_tsc cpuid extd_apicid aperfmpe=
rf rapl
 pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave =
avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalig=
nsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb =
bpext perfctr_llc mwaitx cpuid_fault
 cpb cat_l3 cdp_l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhan=
ced vmmcall fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a =
avx512f avx512dq rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni=
 avx512bw avx512vl xsaveopt xsavec
 xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local user_shst=
k avx_vnni avx512_bf16 clzero irperf xsaveerptr rdpru wbnoinvd cppc arat np=
t lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pa=
usefilter pfthreshold avic v_vmsave_vmload
 vgif x2avic v_spec_ctrl vnmi avx512vbmi umip pku ospke avx512_vbmi2 gfni v=
aes vpclmulqdq avx512_vnni avx512_bitalg avx512_vpopcntdq rdpid bus_lock_de=
tect movdiri movdir64b overflow_recov succor smca fsrm avx512_vp2intersect =
flush_l1d amd_lbr_pmc_freeze<br>
bugs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : sy=
sret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso spectre_v2_user =
vmscape<br>
bogomips&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 8599.99<br>
TLB size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 192 4K pages<br>
clflush size&nbsp;&nbsp;&nbsp; : 64<br>
cache_alignment : 64<br>
address sizes&nbsp;&nbsp; : 48 bits physical, 48 bits virtual<br>
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]<br>
<br>
As the error does not occur in v7.0-rc7 I bisected the issue, declaring a c=
ommit as GOOD<br>
when it passes 18 hibernate/resumes cycles (the issue is not 100% reproduci=
ble)<br>
<br>
All these kernel are compiled with PREEMPT_RT:<br>
7.0.0-rc7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 18 hibernate/resume cycles withot crash, GOOD<br>
7.0.0-rc7-next-20260406-master&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crash on=
 1st resume, BAD<br>
7.0.0-rc7-bisect-06060-g00f03539e3d9 18 hibernate/resume cycles without cra=
sh, GOOD<br>
7.0.0-rc7-bisect-09155-g9a6b64640388 crash on 1st resume, BAD<br>
7.0.0-rc4-bisect-01504-g8e005ef09ba5 18 hibernate/resume cycles without cra=
sh, GOOD<br>
7.0.0-rc7-bisect-08350-gb82dff8ab846 crash on 4th resume, BAD<br>
7.0.0-rc7-bisect-06517-ga03c0f5a4d5f 18 hibernate/resume cycles without cra=
sh, GOOD<br>
7.0.0-rc6-bisect-01673-gcdd65e8bb954 crash on 6th resume, BAD<br>
7.0.0-rc4-bisect-00705-g02ade2557eba 18 hibernate/resume cycles without cra=
sh, GOOD<br>
7.0.0-rc4-bisect-01453-g353f20082505 crash on 8th resume, BAD<br>
7.0.0-rc4-bisect-01428-g4c3aeb11d504 18 hibernate/resume cycles without cra=
sh, GOOD<br>
7.0.0-rc4-bisect-01440-g60c741a13fd1 18 hibernate/resume cycles without cra=
sh, GOOD<br>
7.0.0-rc4-bisect-01446-g32c1c35b6d8b crash on 12th resume, BAD<br>
7.0.0-rc4-bisect-01443-g02c3060ee303 18 hibernate/resume cycles without cra=
sh, GOOD<br>
7.0.0-rc4-bisect-01445-g4bb2f0721ed8 crash on 1st resume, BAD<br>
7.0.0-rc4-bisect-01444-g3539437f354b crash on 3rd resume, BAD<br>
<br>
The result of the bisection points to<br>
commit 3539437f354b (&quot;drm/amd/display: Move FPU Guards From DML To DC =
- Part 1&quot;)<br>
as the first bad commit.<br>
<br>
As the offending commit contains preemption related macros I tried commit<b=
r>
3539437f354b&nbsp;(&quot;drm/amd/display: Move FPU Guards From DML To DC - =
Part 1&quot;)<br>
without PREEMPT_RT and got no error in 24 cycles:<br>
7.0.0-rc4-nort-01444-g3539437f354b 24 hibernate/resume cycles without crash=
<br>
<br>
Any Ideas?<br>
<br>
Bert Karwatzki<br>
<br>
<br>
</div>
</body>
</html>

--_000_IA1PR12MB6307858BAECC7CC3AE8AA958F8582IA1PR12MB6307namp_--
