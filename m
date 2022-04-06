Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8823BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 15:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E7210E3B4;
	Wed,  6 Apr 2022 15:49:22 +0000 (UTC)
Received: from apac01-obe.outbound.protection.outlook.com
 (mail-bgr052101128019.outbound.protection.outlook.com [52.101.128.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796D110E178
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 15:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHP+OQ0fWx/DeT9SZQyq9hMu+/5F6Z9vBBVxYbTtO1oubV+aPnIUrlW++i6VgYSnVGezqc5wNKkSrWwVDe4H7QdE2WIboV2Mpfo4tC4Rvdqpuu3wXxajUoVXoDHjIdStgVb4bNgqs4vlj1TM4cZ0E3HtjfNLkMhLSyEJM6VfZa1bBZSyXxxT2Hzmayno5oRB0JDpv9P6O2WfFjEZupcT/tZpVpp+XKoXus25GckNt7EOsfMPO9dq3ss1yG+5U7X7/0CpvMpIaMIXFDw0eaR8AGaaXhf+Usiv5gQJDxW4ARQOXKXhP8RTDL831P28jgUcwW6x+NosVBTMS1PI7K4hJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCaALShCCdqN4vCs6+PyW51/wPTvx8FXPabfV25U9NE=;
 b=N/3XnV0C42YG6g0PyV92c/ZMolRYs2GKxvj/LfwN2TrOcNKQQce9heJpjLcN1oMUc6Mmo6GY/xMfxM7ZXHKgMoiExQJZj1PSQ8XX/iQ8kIymiyck4CMs/YgxrDxiccZMwyxvljIfzCSwAi/j/Liao7yRKxtmGyrhOlgDHUcvCRQTi0tZ3Q8VEXEgMm/MD4+owD1W3FfOtLzhgNtKHZ0ib4M4YF1NWZOqO8u8i/d3ldZUDhGKEEEzGKnariPwPvUQlLl6plZfqF4WyRPS3MX2Du/jOd1JEgyzQ4FoW3HPn1njWJge+vcHYT1pKZdtBsXyf5guyh6Crmv6OjKVbymiIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCaALShCCdqN4vCs6+PyW51/wPTvx8FXPabfV25U9NE=;
 b=fQlFtvxeW9JUjSNvAMQYNAWvgsNBkwH2RbtYoFuecaX+j89OIyDzgsh9MxsL1ttYaZQwarUq8G3qYCId5xyX1r/VPz8T9KvbZNS4ZSX+YFcM61Ls+O8GmZqtKhbZUgugL2oh6Jty2RORT9e1L9LFgYeYO0hY+CMza4Acl1gkRyU=
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM (2603:1096:301:67::8) by
 KL1P15301MB0514.APCP153.PROD.OUTLOOK.COM (2603:1096:820:38::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.8; Wed, 6 Apr 2022 15:11:36 +0000
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::c88f:d71a:2b3d:1c32]) by PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::c88f:d71a:2b3d:1c32%9]) with mapi id 15.20.5164.008; Wed, 6 Apr 2022
 15:11:36 +0000
From: Shuotao Xu <shuotaoxu@microsoft.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
Thread-Topic: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
Thread-Index: AQHYSV+lQh0DehaAkU6mUF/D9OJf/qzi7iYAgAABCGOAAAWHAIAAAhPy
Date: Wed, 6 Apr 2022 15:11:36 +0000
Message-ID: <PSAP153MB05176F6C82945DE2C3443248B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
References: <PSAP153MB051776C60FFB06BB3278EEB4B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <2cdfcdee-bf4d-006a-19c1-c806feb4100d@amd.com>
 <PSAP153MB0517571E0AECDB007D90A8F3B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <990573e7-bc0e-0c3a-11b9-c725fdee44df@amd.com>
In-Reply-To: <990573e7-bc0e-0c3a-11b9-c725fdee44df@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-06T14:44:04.9506065Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9c7b02b-d049-4075-ea53-08da17dfbe84
x-ms-traffictypediagnostic: KL1P15301MB0514:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <KL1P15301MB0514C62C4A68305DFE6BF90DB7E79@KL1P15301MB0514.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9dBh4qbzTE/aFFE80DstTvwHpXW9rYx7ITlHqnnqGMqmmf1BRx3YoyrbBOfTe4+HvHnAJc5CcDdjuqGFZs8GVguCVp1ZWCTdHbtEQ/New15AYhwVfaW2E9wpmUaQ7gRiHJodcCOiJYoat6cvDn54IK98OXhl4mC5n2oqiVypTy1GaPgLRSkeaAhEFZ3mb9qo/18aCjKC9wfhOBTAGRn0O/HKJFgAuqr/gGKH+gc5WARbDuVoM39+8tHa2mkc79TSD7mkdTCvSwBwf3Gefo9eCC3h7H4yGAEHBF0riNB+0np08MbtpWgWw9gLfzf0iHM4J1vklbM1NVE2Ni7e9yNURX0bseTBmHZYKCbZwgNCcMeUqQp6YI/faX7eKzpFXp6c0Vt4i2+wNYjcoWDLY2LtAgSfdusKF05jpOrNQmxtmJ04z47NOaZD1LLfa/436pSJLB0nmSMninQvxOJPcSKD13wSwLjfZ2dNd7/XeHiJsV2BgUxf7oRDzlyLYrP1o5BzcP8nriqIbl3n+SVYrIqbMS0i3xF+Ql2XSMyuYSi3mSduYKHTLn7lR64p8SVYCKhi/9SOwv7gMe25lf5JDWLPcWH/NJNuA0BMhZF4I0a9+bciG23j+Ddzh14Pv7kqasn70H+TU1fmXHqzzt/SGtU4UWD8k1XNcnHAHllt+X83TPggQMDtBBuc9ETOvFjICNcqEM45VYD3rcwOeNyFdDUbikJBIFqpfWczpAvPsIpCgapLlBF7nZszCbkT2PA+HsbsGZV24xQPaTy9ZD0rrz2v2cA4uCS10R65LC7i3OrDNe3HP0Sf57TPJydCiOHgJZJ8swYnSf2PJKhwQDUmCE1K+YbIQbomotax0TBfmPcqSeLRqHnf+2yx8ovureM2BvXU+Jpq/dME/V/QPHEgruE3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAP153MB0517.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(10290500003)(966005)(8676002)(4326008)(66556008)(91956017)(66446008)(76116006)(66476007)(64756008)(30864003)(82950400001)(71200400001)(82960400001)(508600001)(122000001)(83380400001)(38100700002)(166002)(53546011)(6506007)(7696005)(52536014)(16799955002)(5660300002)(66946007)(110136005)(316002)(54906003)(8936002)(9326002)(86362001)(9686003)(2906002)(107886003)(38070700005)(186003)(55016003)(8990500004)(33656002)(559001)(579004)(10090945011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wsHpoYe6pZozLexlbT3YCwQOQGunexh4Q2L2xXHoBOIKYEyWK4bTGcOvxPR5?=
 =?us-ascii?Q?//PE6fQJM68dX17Wgr8MpfGsuULRRvxJVR6cWT+pJTDI03AeHI4LE0t44xwo?=
 =?us-ascii?Q?Z7+iodmj2IG3n783KpmO7L20UvLKwZgIKzn/H6dtsaSEzvkta73jIqEBDtSi?=
 =?us-ascii?Q?4f98Mq/SATOMYV0Ndwz3oPCUA3CagoZQko6atsEgr0Lp4qXponulFhQVRmHp?=
 =?us-ascii?Q?RY60l7iQ9o9il4+oe+tEm17YX+srfpQaulO4qk7Cb4SD++GZ0+mq2Lkv439Q?=
 =?us-ascii?Q?c9/TZ4xv0JR9YtnT7YkBXHJ+vAs+ZhbEGlRaq3YrNWTEorgsTUqa0NT7wr78?=
 =?us-ascii?Q?nKCeTPMGU5elzs2RJg7YbXVf15srJc5kmoKkx6WPlGk2QgY6irxo4mJdspNd?=
 =?us-ascii?Q?Amiyo+DNhN+2ixBd+8zBzgZi9L0di9fWmRtfKWFQ0sZEYh18pyoQMDml0Jy2?=
 =?us-ascii?Q?exhsXeagra9FMC9adaNzdqkdIJP9htrOiIzSkCdryABNt4LUzDbVJXzPpAZ8?=
 =?us-ascii?Q?ixwFfApNtJWvhpFYaA+7KyIUw2VsqG13254z1cpQsqg5IfjuOT55eAfP01LJ?=
 =?us-ascii?Q?4l0wORDcl2bzwKq06stx3IkBvcOEKRIjTtWQkEj7lrTlr52YFZr470vSohzc?=
 =?us-ascii?Q?JBMKyWQ3n57wiqukQm2V6y1mZBn12zD6H+wrpBBZakumssvH+s5dqZ27kP7B?=
 =?us-ascii?Q?Y7V+jIR0omZu5VPJrPuLGtK6pkCl1gP26EZvMQBzZjQ55afQuKKSFb5B6UCI?=
 =?us-ascii?Q?X++2Q/AIfV39PkxXuKDiyKV1VtSmOpnuFAqrCPBD9L5Ak4YZ/zYg6wdW0230?=
 =?us-ascii?Q?2QRU4SnRoAjfo/8TQNuJ/Txz7tfus+qL15561bHVNq21/21xKymwEu3zlBK+?=
 =?us-ascii?Q?sowhsRO6FdUKjP1J8zeXMoVD64QHoisThSdStIjx9KB/pNGh3ICgTQq7HqpZ?=
 =?us-ascii?Q?6vf72FUk45LOhs6wfrKF7sM1jBDt4OtsdE0BCfM8Bys9cRVdM5v3TVMquKT/?=
 =?us-ascii?Q?6ajbDNmqDizWDNOgpIrsQKQKG2dLIhMTJ8ERzAGaj9xZhwPdY8Wo+w7AYnTT?=
 =?us-ascii?Q?7HYQHGwWaXEDek4sUV83xZKKpFk3HekoKqxyKOUycTluLLrvqL8+YqeHtOQo?=
 =?us-ascii?Q?W/9zyCoZVv+dl7zmczp8GNo5gxK1RqSJTaOWYzY8sILTHcCf0ne5visdMIkp?=
 =?us-ascii?Q?5b/XF+Q2XEBAB6eWfX6xgKA8MU7J4SBGIUByuVIA+USM33REIJFNLeCnokYa?=
 =?us-ascii?Q?xlOZJyEYGTKY7qrRLVmcX9UFergHoIisDs0aD//si5hmGUOCitj6yruwktCv?=
 =?us-ascii?Q?Y+q+KRRHBfnQ26zeDpqRFkP3ze9JQcxGqaAyHMoAIqc3P1go/58ztNPHJKG6?=
 =?us-ascii?Q?58mKNVpp+OMHpcVyRO+6u06YeCL/DZpfv6YmRg3AnhAFwJ0cGWRtYc8k2LdE?=
 =?us-ascii?Q?uUNLlI3OpgNxtcXXFRbTpyGDYA+zyHrJNh+i1DIs5zKdsz7bvMpC9SfExere?=
 =?us-ascii?Q?rHAg+nvOrU02P2HUfJ6gwWphig/P2wn0IUhD/sZYTwls7rztt0oP1S8fRKpr?=
 =?us-ascii?Q?pj0nlTfOkYNAQ1SGOwE0ntKrmhBck+Qm944VpP+V4/mV/7Tf0Tt/Zf/zzhpt?=
 =?us-ascii?Q?cRwGCHjN1GZ3s9ri2NZ3lwNu+hFTgRX86kuP9z2HbAJdsRMpDBjgQLLv0uXV?=
 =?us-ascii?Q?FLhjkYe/lAFkrt2YjrNSh7N8v4s+/OlcN2pzsX5R0FpDPGSXPsVlfjlhkZFp?=
 =?us-ascii?Q?jNMFjhUdtw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PSAP153MB05176F6C82945DE2C3443248B7E79PSAP153MB0517APCP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c7b02b-d049-4075-ea53-08da17dfbe84
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 15:11:36.4612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6vsk769J59vk9WXg+45H1JY0QvffpMoxJKWagFqRT2dHcjDAVdxzZDqNrGmjse4gYfG5V9YtQbhOTMEhsAl1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0514
X-Mailman-Approved-At: Wed, 06 Apr 2022 15:49:21 +0000
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
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>,
 Peng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PSAP153MB05176F6C82945DE2C3443248B7E79PSAP153MB0517APCP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

Thanks for your kind comment on linux patch submission protocol, please let=
 me know if there is anyway to rectify it.

dmesg is fine except with some warning during pci rescan after pci removal =
of an AMD MI100.

The issue is that after this rocm application will return segfault with the=
 amdgpu driver unless the entire amdgpu kernel module is unloaded and loade=
d, which we did not meet our hotplug requirement. The issues upon investiga=
tion are
1) kfd_lock is locked after hotplug, and kfd_open will return fault right a=
way to libhsakmt .
2) iolink/p2plink has anormalies after hotplug, and libhsakmt will found su=
ch anomalies and return error.

Our patch has been tested with a single-instance AMD MI100 GPU and showed i=
t worked.

I am attaching the dmesg after rescan anyway, which will show the warning a=
nd the segfault.

[  132.054822] pci 0000:43:00.0: [1002:738c] type 00 class 0x038000
[  132.054856] pci 0000:43:00.0: reg 0x10: [mem 0x38b000000000-0x38b7ffffff=
ff 64bit pref]
[  132.054877] pci 0000:43:00.0: reg 0x18: [mem 0x38b800000000-0x38b8001fff=
ff 64bit pref]
[  132.054890] pci 0000:43:00.0: reg 0x20: [io  0xa000-0xa0ff]
[  132.054904] pci 0000:43:00.0: reg 0x24: [mem 0xb8400000-0xb847ffff]
[  132.054918] pci 0000:43:00.0: reg 0x30: [mem 0xb8480000-0xb849ffff pref]
[  132.055134] pci 0000:43:00.0: PME# supported from D1 D2 D3hot D3cold
[  132.055217] pci 0000:43:00.0: 63.008 Gb/s available PCIe bandwidth, limi=
ted by 8.0 GT/s PCIe x8 link at 0000:3c:14.0 (capable of 252.048 Gb/s with =
16.0 GT/s PCIe x16 link)
[  132.056001] pci 0000:43:00.0: Adding to iommu group 73
[  132.057943] pci 0000:43:00.0: BAR 0: assigned [mem 0x38b000000000-0x38b7=
ffffffff 64bit pref]
[  132.057960] pci 0000:43:00.0: BAR 2: assigned [mem 0x38b800000000-0x38b8=
001fffff 64bit pref]
[  132.057974] pci 0000:43:00.0: BAR 5: assigned [mem 0xb8400000-0xb847ffff=
]
[  132.057981] pci 0000:43:00.0: BAR 6: assigned [mem 0xb8480000-0xb849ffff=
 pref]
[  132.057984] pci 0000:43:00.0: BAR 4: assigned [io  0xa000-0xa0ff]

[  132.058429] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  132.058453] WARNING: possible circular locking dependency detected
[  132.058477] 5.16.0-kfd+ #1 Not tainted
[  132.058492] ------------------------------------------------------
[  132.058515] bash/3632 is trying to acquire lock:
[  132.058534] ffffadee20adfb50 ((work_completion)(&wfc.work)){+.+.}-{0:0},=
 at: __flush_work+0x2f5/0x470
[  132.058554] [drm] initializing kernel modesetting (ARCTURUS 0x1002:0x738=
C 0x1002:0x0C34 0x01).
[  132.058577]
               but task is already holding lock:
[  132.058580] ffffffffa3c62308
[  132.058630] amdgpu 0000:43:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re not supported
[  132.058638]  (
[  132.058678] [drm] register mmio base: 0xB8400000
[  132.058683] pci_rescan_remove_lock
[  132.058694] [drm] register mmio size: 524288
[  132.058713] ){+.+.}-{3:3}, at: rescan_store+0x55/0x90
[  132.058773]
               which lock already depends on the new lock.

[  132.058804]
               the existing dependency chain (in reverse order) is:
[  132.058819] [drm] add ip block number 0 <soc15_common>
[  132.058831]
               -> #1 (
[  132.058854] [drm] add ip block number 1 <gmc_v9_0>
[  132.058858] [drm] add ip block number 2 <vega20_ih>
[  132.058874] pci_rescan_remove_lock
[  132.058894] [drm] add ip block number 3 <psp>
[  132.058915] ){+.+.}-{3:3}
[  132.058931] [drm] add ip block number 4 <smu>
[  132.058951] :
[  132.058965] [drm] add ip block number 5 <gfx_v9_0>
[  132.058986]        __mutex_lock+0xa4/0x990
[  132.058996] [drm] add ip block number 6 <sdma_v4_0>
[  132.059016]        i801_add_tco_spt.isra.20+0x2a/0x1a0
[  132.059033] [drm] add ip block number 7 <vcn_v2_5>
[  132.059054]        i801_add_tco+0xf6/0x110
[  132.059075] [drm] add ip block number 8 <jpeg_v2_5>
[  132.059096]        i801_probe+0x402/0x860
[  132.059151]        local_pci_probe+0x40/0x90
[  132.059170]        work_for_cpu_fn+0x10/0x20
[  132.059189]        process_one_work+0x2a4/0x640
[  132.059208]        worker_thread+0x228/0x3f0
[  132.059227]        kthread+0x16d/0x1a0
[  132.059795]        ret_from_fork+0x1f/0x30
[  132.060337]
               -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
[  132.061405]        __lock_acquire+0x1552/0x1ac0
[  132.061950]        lock_acquire+0x26c/0x300
[  132.062484]        __flush_work+0x315/0x470
[  132.063009]        work_on_cpu+0x98/0xc0
[  132.063526]        pci_device_probe+0x1bc/0x1d0
[  132.064036]        really_probe+0x102/0x450
[  132.064532]        __driver_probe_device+0x100/0x170
[  132.065020]        driver_probe_device+0x1f/0xa0
[  132.065497]        __device_attach_driver+0x6b/0xe0
[  132.065975]        bus_for_each_drv+0x6a/0xb0
[  132.066449]        __device_attach+0xe2/0x160
[  132.066912]        pci_bus_add_device+0x4a/0x80
[  132.067365]        pci_bus_add_devices+0x2c/0x70
[  132.067812]        pci_bus_add_devices+0x65/0x70
[  132.068253]        pci_bus_add_devices+0x65/0x70
[  132.068688]        pci_bus_add_devices+0x65/0x70
[  132.068936] amdgpu 0000:43:00.0: amdgpu: Fetched VBIOS from ROM BAR
[  132.069109]        pci_bus_add_devices+0x65/0x70
[  132.069602] amdgpu: ATOM BIOS: 113-D3431401-X00
[  132.070058]        pci_bus_add_devices+0x65/0x70
[  132.070572] [drm] VCN(0) decode is enabled in VM mode
[  132.070997]        pci_rescan_bus+0x23/0x30
[  132.071000]        rescan_store+0x61/0x90
[  132.071003]        kernfs_fop_write_iter+0x132/0x1b0
[  132.071501] [drm] VCN(1) decode is enabled in VM mode
[  132.071964]        new_sync_write+0x11f/0x1b0
[  132.072432] [drm] VCN(0) encode is enabled in VM mode
[  132.072900]        vfs_write+0x35b/0x3b0
[  132.073376] [drm] VCN(1) encode is enabled in VM mode
[  132.073847]        ksys_write+0xa7/0xe0
[  132.074335] [drm] JPEG(0) JPEG decode is enabled in VM mode
[  132.074803]        do_syscall_64+0x34/0x80
[  132.074808]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  132.074811]
               other info that might help us debug this:

[  132.074813]  Possible unsafe locking scenario:

[  132.075302] [drm] JPEG(1) JPEG decode is enabled in VM mode
[  132.075779]        CPU0                    CPU1
[  132.076361] amdgpu 0000:43:00.0: amdgpu: MEM ECC is active.
[  132.076765]        ----                    ----
[  132.077265] amdgpu 0000:43:00.0: amdgpu: SRAM ECC is active.
[  132.078649]   lock(pci_rescan_remove_lock);
[  132.078652]                                lock((work_completion)(&wfc.w=
ork));
[  132.078653]                                lock(pci_rescan_remove_lock);
[  132.078655]   lock((work_completion)(&wfc.work));
[  132.078656]
                *** DEADLOCK ***

[  132.078656] 5 locks held by bash/3632:
[  132.078658]  #0: ffff9c39c7b89438
[  132.079612] amdgpu 0000:43:00.0: amdgpu: RAS INFO: ras initialized succe=
ssfully, hardware ability[7fff] ras_mask[7fff]
[  132.080089]  (
[  132.080602] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[  132.081082] sb_writers
[  132.081601] amdgpu 0000:43:00.0: amdgpu: VRAM: 32752M 0x0000008000000000=
 - 0x00000087FEFFFFFF (32752M used)
[  132.082102] #6
[  132.082630] amdgpu 0000:43:00.0: amdgpu: GART: 512M 0x0000000000000000 -=
 0x000000001FFFFFFF
[  132.083152] ){.+.+}-{0:0}
[  132.083687] amdgpu 0000:43:00.0: amdgpu: AGP: 267878400M 0x0000008800000=
000 - 0x0000FFFFFFFFFFFF
[  132.084210] , at: ksys_write+0xa7/0xe0
[  132.085708] [drm] Detected VRAM RAM=3D32752M, BAR=3D32768M
[  132.086205]  #1:
[  132.086733] [drm] RAM width 4096bits HBM
[  132.087269] ffff9c5959011088
[  132.087890] [drm] amdgpu: 32752M of VRAM memory ready
[  132.088389]  (
[  132.088972] [drm] amdgpu: 32752M of GTT memory ready.
[  132.089572] &of->mutex
[  132.090206] [drm] GART: num cpu pages 131072, num gpu pages 131072
[  132.090804] ){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x103/0x1b0
[  132.090808]  #2: ffff9c39c882a9e0 (kn->active#423){.+.+}-{0:0}, at: kern=
fs_fop_write_iter+0x10c/0x1b0
[  132.091639] [drm] PCIE GART of 512M enabled.
[  132.092117]  #3:
[  132.092801] [drm] PTB located at 0x0000008000000000
[  132.093480] ffffffffa3c62308
[  132.094566] amdgpu 0000:43:00.0: amdgpu: PSP runtime database doesn't ex=
ist
[  132.094822]  (pci_rescan_remove_lock){+.+.}-{3:3}, at: rescan_store+0x55=
/0x90
[  132.094827]  #4: ffff9c597392b248 (&dev->mutex){....}-{3:3}, at: __devic=
e_attach+0x39/0x160
[  132.094835]
               stack backtrace:
[  132.097098] [drm] Found VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revi=
sion: 21
[  132.097467] CPU: 47 PID: 3632 Comm: bash Not tainted 5.16.0-kfd+ #1
[  132.098169] amdgpu 0000:43:00.0: amdgpu: Will use PSP to load VCN firmwa=
re
[  132.098839] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIO=
S 2.1 08/14/2018
[  132.098841] Call Trace:
[  132.098842]  <TASK>
[  132.098843]  dump_stack_lvl+0x44/0x57
[  132.098848]  check_noncircular+0x105/0x120
[  132.098853]  ? unwind_get_return_address+0x1b/0x30
[  132.112924]  ? register_lock_class+0x46/0x780
[  132.113630]  ? __lock_acquire+0x1552/0x1ac0
[  132.114342]  __lock_acquire+0x1552/0x1ac0
[  132.115050]  lock_acquire+0x26c/0x300
[  132.115755]  ? __flush_work+0x2f5/0x470
[  132.116460]  ? lock_is_held_type+0xdf/0x130
[  132.117177]  __flush_work+0x315/0x470
[  132.117890]  ? __flush_work+0x2f5/0x470
[  132.118604]  ? lock_is_held_type+0xdf/0x130
[  132.119305]  ? mark_held_locks+0x49/0x70
[  132.119981]  ? queue_work_on+0x2f/0x70
[  132.120645]  ? lockdep_hardirqs_on+0x79/0x100
[  132.121300]  work_on_cpu+0x98/0xc0
[  132.121702] [drm] reserve 0x400000 from 0x87fec00000 for PSP TMR
[  132.121947]  ? __traceiter_workqueue_execute_end+0x40/0x40
[  132.123270]  ? pci_device_shutdown+0x60/0x60
[  132.123880]  pci_device_probe+0x1bc/0x1d0
[  132.124475]  really_probe+0x102/0x450
[  132.125060]  __driver_probe_device+0x100/0x170
[  132.125641]  driver_probe_device+0x1f/0xa0
[  132.126215]  __device_attach_driver+0x6b/0xe0
[  132.126797]  ? driver_allows_async_probing+0x50/0x50
[  132.127383]  ? driver_allows_async_probing+0x50/0x50
[  132.127960]  bus_for_each_drv+0x6a/0xb0
[  132.128528]  __device_attach+0xe2/0x160
[  132.129095]  pci_bus_add_device+0x4a/0x80
[  132.129659]  pci_bus_add_devices+0x2c/0x70
[  132.130213]  pci_bus_add_devices+0x65/0x70
[  132.130753]  pci_bus_add_devices+0x65/0x70
[  132.131283]  pci_bus_add_devices+0x65/0x70
[  132.131780]  pci_bus_add_devices+0x65/0x70
[  132.132270]  pci_bus_add_devices+0x65/0x70
[  132.132757]  pci_rescan_bus+0x23/0x30
[  132.133233]  rescan_store+0x61/0x90
[  132.133701]  kernfs_fop_write_iter+0x132/0x1b0
[  132.134167]  new_sync_write+0x11f/0x1b0
[  132.134627]  vfs_write+0x35b/0x3b0
[  132.135062]  ksys_write+0xa7/0xe0
[  132.135503]  do_syscall_64+0x34/0x80
[  132.135933]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  132.136358] RIP: 0033:0x7f0058a73224
[  132.136775] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 =
00 00 66 90 48 8d 05 c1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
[  132.137663] RSP: 002b:00007ffc4f4c71a8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  132.138121] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0058a=
73224
[  132.138590] RDX: 0000000000000002 RSI: 000055d466c24450 RDI: 00000000000=
00001
[  132.139064] RBP: 000055d466c24450 R08: 000000000000000a R09: 00000000000=
00001
[  132.139532] R10: 000000000000000a R11: 0000000000000246 R12: 00007f0058d=
4f760
[  132.140003] R13: 0000000000000002 R14: 00007f0058d4b2a0 R15: 00007f0058d=
4a760
[  132.140485]  </TASK>
[  132.183669] amdgpu 0000:43:00.0: amdgpu: HDCP: optional hdcp ta ucode is=
 not available
[  132.184214] amdgpu 0000:43:00.0: amdgpu: DTM: optional dtm ta ucode is n=
ot available
[  132.184735] amdgpu 0000:43:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[  132.185234] amdgpu 0000:43:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[  132.185823] amdgpu 0000:43:00.0: amdgpu: use vbios provided pptable
[  132.186327] amdgpu 0000:43:00.0: amdgpu: smc_dpm_info table revision(for=
mat.content): 4.6
[  132.188783] amdgpu 0000:43:00.0: amdgpu: SMU is initialized successfully=
!
[  132.190039] [drm] kiq ring mec 2 pipe 1 q 0
[  132.203608] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).
[  132.204178] [drm] JPEG decode initialized successfully.
[  132.246079] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[  132.327589] memmap_init_zone_device initialised 8388608 pages in 64ms
[  132.328139] amdgpu: HMM registered 32752MB device memory
[  132.328784] amdgpu: Virtual CRAT table created for GPU
[  132.329844] amdgpu: Topology: Add dGPU node [0x738c:0x1002]
[  132.330387] kfd kfd: amdgpu: added device 1002:738c
[  132.330965] amdgpu 0000:43:00.0: amdgpu: SE 8, SH per SE 1, CU per SH 16=
, active_cu_number 72
[  132.331725] amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 0 on hub 0
[  132.332296] amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 1 on hub 0
[  132.332856] amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 4 on hub 0
[  132.333414] amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 5 on hub 0
[  132.333965] amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 6 on hub 0
[  132.334507] amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 7 on hub 0
[  132.335057] amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 8 on hub 0
[  132.335594] amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 9 on hub 0
[  132.336137] amdgpu 0000:43:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng =
10 on hub 0
[  132.336679] amdgpu 0000:43:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 1
[  132.337234] amdgpu 0000:43:00.0: amdgpu: ring sdma1 uses VM inv eng 1 on=
 hub 1
[  132.337790] amdgpu 0000:43:00.0: amdgpu: ring sdma2 uses VM inv eng 4 on=
 hub 1
[  132.338343] amdgpu 0000:43:00.0: amdgpu: ring sdma3 uses VM inv eng 5 on=
 hub 1
[  132.338906] amdgpu 0000:43:00.0: amdgpu: ring sdma4 uses VM inv eng 6 on=
 hub 1
[  132.339448] amdgpu 0000:43:00.0: amdgpu: ring sdma5 uses VM inv eng 0 on=
 hub 2
[  132.339987] amdgpu 0000:43:00.0: amdgpu: ring sdma6 uses VM inv eng 1 on=
 hub 2
[  132.340519] amdgpu 0000:43:00.0: amdgpu: ring sdma7 uses VM inv eng 4 on=
 hub 2
[  132.341041] amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
5 on hub 2
[  132.341570] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 6 on hub 2
[  132.342101] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 7 on hub 2
[  132.342630] amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_1 uses VM inv eng =
8 on hub 2
[  132.343152] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.0 uses VM inv en=
g 9 on hub 2
[  132.343657] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.1 uses VM inv en=
g 10 on hub 2
[  132.344136] amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_0 uses VM inv eng=
 11 on hub 2
[  132.344610] amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_1 uses VM inv eng=
 12 on hub 2
[  132.378213] amdgpu: Detected AMDGPU 6 Perf Events.
[  132.387349] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:43:00.0 on=
 minor 1
[  132.388530] pcieport 0000:d7:00.0: bridge window [io  0x1000-0x0fff] to =
[bus d8] add_size 1000
[  132.389078] pcieport 0000:d7:00.0: BAR 13: no space for [io  size 0x1000=
]
[  132.389600] pcieport 0000:d7:00.0: BAR 13: failed to assign [io  size 0x=
1000]
[  132.390091] pcieport 0000:d7:00.0: BAR 13: no space for [io  size 0x1000=
]
[  132.390568] pcieport 0000:d7:00.0: BAR 13: failed to assign [io  size 0x=
1000]
[  155.359200] HelloWorld[3824]: segfault at 68 ip 00007f4c979f764e sp 0000=
7ffc9b3bb610 error 4 in libamdhip64.so.4.4.21432-f9dccde4[7f4c979b3000+2eb0=
00]
[  155.360268] Code: 48 8b 45 e8 64 48 33 04 25 28 00 00 00 74 05 e8 b8 c7 =
fb ff 48 8b 5d f8 c9 c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 f8 <48=
> 8b 40 68 5d c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 f8

Best regards,
Shuotao

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date: Wednesday, April 6, 2022 at 10:36 PM
To: Shuotao Xu <shuotaoxu@microsoft.com>, amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>, P=
eng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
[You don't often get email from andrey.grodzovsky@amd.com. Learn why this i=
s important at http://aka.ms/LearnAboutSenderIdentification.]<http://aka.ms=
/LearnAboutSenderIdentification.%5d>

Can you attach dmesg for the failure without your patch against
amd-staging-drm-next ?

Also, in general, patches for amdgpu upstream branches should be
submitted to amd-gfx mailing list inline using git-send which makes it
easy to comment and review them inline.

Andrey

On 2022-04-06 10:25, Shuotao Xu wrote:
> Hi Andrey,
>
> We just tried kernel 5.16 based on
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D05%7C01%7Cshuotaoxu%40micr=
osoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011=
db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM=
DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;reserved=3D0
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl=
ab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D05%7C01%7Cshuotaoxu%40mic=
rosoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd01=
1db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat=
a=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;reserved=3D0>
> amd-staging-drm-next branch, and found out that hotplug did not work out
> of box for Rocm compute stack.
>
> We did not try the rendering stack since we currently are more focused
> on AI workloads.
>
> We have also created a patch against the amd-staging-drm-next branch to
> enable hotplug for ROCM stack, which were sent in another later email
> with same subject. I am attaching the patch in this email, in case that
> you would want to delete that later email.
>
> Best regards,
>
> Shuotao
>
> *From: *Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> *Date: *Wednesday, April 6, 2022 at 10:13 PM
> *To: *Shuotao Xu <shuotaoxu@microsoft.com>,
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc: *Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu
> <Lei.Qu@microsoft.com>, Peng Cheng <pengc@microsoft.com>, Ran Shu
> <Ran.Shu@microsoft.com>
> *Subject: *[EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
>
> [You don't often get email from andrey.grodzovsky@amd.com. Learn why
> this is important at http://aka.ms/LearnAboutSenderIdentification.]<http:=
//aka.ms/LearnAboutSenderIdentification.%5d>
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Faka.m=
s%2FLearnAboutSenderIdentification.%255d&amp;data=3D05%7C01%7Cshuotaoxu%40m=
icrosoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd=
011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sd=
ata=3DHfSwu6SWfoCYyscJqGFdKHBPtaj%2BKB4lyo13zkm6hi4%3D&amp;reserved=3D0>
>
> Looks like you are using 5.13 kernel for this work, FYI we added
> hot plug support for the graphic stack in 5.14 kernel (see
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.p=
horonix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unpl=
ug&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308d=
a17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7=
CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi=
LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf16IGN8=
xmO2T6jnpipzo%3D&amp;reserved=3D0)
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.=
phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unp=
lug&amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308=
da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%=
7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf16IGN=
8xmO2T6jnpipzo%3D&amp;reserved=3D0>
>
>
> I am not sure about the code part since it all touches KFD driver (KFD
> team can comment on that) - but I was just wondering if you try 5.14
> kernel would things just work for you out of the box ?
>
> Andrey
>
> On 2022-04-05 22:45, Shuotao Xu wrote:
>> Dear AMD Colleagues,
>>
>> We are from Microsoft Research, and are working on GPU disaggregation
>> technology.
>>
>> We have created a new pull requestAdd PCIe hotplug support for amdgpu by
>> xushuotao * Pull Request #131 * RadeonOpenCompute/ROCK-Kernel-Driver
>> (github.com)
>> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
hub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=3D05=
%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f9=
88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C3000%7C%7C%7C&amp;sdata=3DqEeZR6R95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g%3D&a=
mp;reserved=3D0
> <https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith=
ub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=3D05%=
7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f98=
8bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
3000%7C%7C%7C&amp;sdata=3DqEeZR6R95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g%3D&am=
p;reserved=3D0>>in
>> ROCK-Kernel-Driver, which will enable PCIe hot-plug support for amdgpu.
>>
>> We believe the support of hot-plug of GPU devices can open doors for
>> many advanced applications in data center in the next few years, and we
>> would like to have some reviewers on this PR so we can continue further
>> technical discussions around this feature.
>>
>> Would you please help review this PR?
>>
>> Thank you very much!
>>
>> Best regards,
>>
>> Shuotao Xu
>>
>

--_000_PSAP153MB05176F6C82945DE2C3443248B7E79PSAP153MB0517APCP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Andrey,<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks for your kin=
d comment on linux patch submission protocol, please let me know if there i=
s anyway to rectify it.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">dmesg is fine excep=
t with some warning during pci rescan after pci removal of an AMD MI100.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The issue is that a=
fter this rocm application will return segfault with the amdgpu driver unle=
ss the entire amdgpu kernel module is unloaded and loaded, which we did not=
 meet our hotplug requirement. The issues
 upon investigation are<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">1) kfd_lock is lock=
ed after hotplug, and kfd_open will return fault right away to libhsakmt .
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">2) iolink/p2plink h=
as anormalies after hotplug, and libhsakmt will found such anomalies and re=
turn error.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Our patch has been =
tested with a single-instance AMD MI100 GPU and showed it worked.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I am attaching the =
dmesg after rescan anyway, which will show the warning and the segfault.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054822]=
 pci 0000:43:00.0: [1002:738c] type 00 class 0x038000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054856]=
 pci 0000:43:00.0: reg 0x10: [mem 0x38b000000000-0x38b7ffffffff 64bit pref]=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054877]=
 pci 0000:43:00.0: reg 0x18: [mem 0x38b800000000-0x38b8001fffff 64bit pref]=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054890]=
 pci 0000:43:00.0: reg 0x20: [io&nbsp; 0xa000-0xa0ff]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054904]=
 pci 0000:43:00.0: reg 0x24: [mem 0xb8400000-0xb847ffff]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.054918]=
 pci 0000:43:00.0: reg 0x30: [mem 0xb8480000-0xb849ffff pref]<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.055134]=
 pci 0000:43:00.0: PME# supported from D1 D2 D3hot D3cold<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.055217]=
 pci 0000:43:00.0: 63.008 Gb/s available PCIe bandwidth, limited by 8.0 GT/=
s PCIe x8 link at 0000:3c:14.0 (capable of 252.048 Gb/s with 16.0 GT/s PCIe=
 x16 link)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.056001]=
 pci 0000:43:00.0: Adding to iommu group 73<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057943]=
 pci 0000:43:00.0: BAR 0: assigned [mem 0x38b000000000-0x38b7ffffffff 64bit=
 pref]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057960]=
 pci 0000:43:00.0: BAR 2: assigned [mem 0x38b800000000-0x38b8001fffff 64bit=
 pref]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057974]=
 pci 0000:43:00.0: BAR 5: assigned [mem 0xb8400000-0xb847ffff]<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057981]=
 pci 0000:43:00.0: BAR 6: assigned [mem 0xb8480000-0xb849ffff pref]<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.057984]=
 pci 0000:43:00.0: BAR 4: assigned [io&nbsp; 0xa000-0xa0ff]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058429]=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058453]=
 WARNING: possible circular locking dependency detected<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058477]=
 5.16.0-kfd+ #1 Not tainted<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058492]=
 ------------------------------------------------------<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058515]=
 bash/3632 is trying to acquire lock:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058534]=
 ffffadee20adfb50 ((work_completion)(&amp;wfc.work)){+.+.}-{0:0}, at: __flu=
sh_work+0x2f5/0x470<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058554]=
 [drm] initializing kernel modesetting (ARCTURUS 0x1002:0x738C 0x1002:0x0C3=
4 0x01).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058577]=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but task =
is already holding lock:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058580]=
 ffffffffa3c62308<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058630]=
 amdgpu 0000:43:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not support=
ed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058638]=
&nbsp; (<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058678]=
 [drm] register mmio base: 0xB8400000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058683]=
 pci_rescan_remove_lock<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058694]=
 [drm] register mmio size: 524288<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058713]=
 ){+.+.}-{3:3}, at: rescan_store+0x55/0x90<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058773]=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; which loc=
k already depends on the new lock.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058804]=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the exist=
ing dependency chain (in reverse order) is:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058819]=
 [drm] add ip block number 0 &lt;soc15_common&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058831]=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt; #1 =
(<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058854]=
 [drm] add ip block number 1 &lt;gmc_v9_0&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058858]=
 [drm] add ip block number 2 &lt;vega20_ih&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058874]=
 pci_rescan_remove_lock<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058894]=
 [drm] add ip block number 3 &lt;psp&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058915]=
 ){+.+.}-{3:3}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058931]=
 [drm] add ip block number 4 &lt;smu&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058951]=
 :<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058965]=
 [drm] add ip block number 5 &lt;gfx_v9_0&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058986]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __mutex_lock+0xa4/0x990<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.058996]=
 [drm] add ip block number 6 &lt;sdma_v4_0&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059016]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i801_add_tco_spt.isra.20+0x2a/0x=
1a0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059033]=
 [drm] add ip block number 7 &lt;vcn_v2_5&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059054]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i801_add_tco+0xf6/0x110<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059075]=
 [drm] add ip block number 8 &lt;jpeg_v2_5&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059096]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i801_probe+0x402/0x860<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059151]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local_pci_probe+0x40/0x90<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059170]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; work_for_cpu_fn+0x10/0x20<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059189]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process_one_work+0x2a4/0x640<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059208]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; worker_thread+0x228/0x3f0<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059227]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kthread+0x16d/0x1a0<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.059795]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_from_fork+0x1f/0x30<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.060337]=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt; #0 =
((work_completion)(&amp;wfc.work)){+.+.}-{0:0}:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.061405]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __lock_acquire+0x1552/0x1ac0<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.061950]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock_acquire+0x26c/0x300<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.062484]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __flush_work+0x315/0x470<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.063009]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; work_on_cpu+0x98/0xc0<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.063526]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_device_probe+0x1bc/0x1d0<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.064036]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; really_probe+0x102/0x450<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.064532]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __driver_probe_device+0x100/0x17=
0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.065020]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driver_probe_device+0x1f/0xa0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.065497]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __device_attach_driver+0x6b/0xe0=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.065975]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bus_for_each_drv+0x6a/0xb0<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.066449]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __device_attach+0xe2/0x160<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.066912]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_device+0x4a/0x80<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.067365]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x2c/0x70<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.067812]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.068253]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.068688]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.068936]=
 amdgpu 0000:43:00.0: amdgpu: Fetched VBIOS from ROM BAR<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.069109]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;pci_bus_add_devices+0x65/0x70<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.069602]=
 amdgpu: ATOM BIOS: 113-D3431401-X00<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.070058]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_bus_add_devices+0x65/0x70<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.070572]=
 [drm] VCN(0) decode is enabled in VM mode<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.070997]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_rescan_bus+0x23/0x30<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071000]=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rescan_store+0x61/0x90<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071003]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernfs_fop_write_iter+0x132/0x1b=
0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071501]=
 [drm] VCN(1) decode is enabled in VM mode<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.071964]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_sync_write+0x11f/0x1b0<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.072432]=
 [drm] VCN(0) encode is enabled in VM mode<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.072900]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vfs_write+0x35b/0x3b0<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.073376]=
 [drm] VCN(1) encode is enabled in VM mode<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.073847]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ksys_write+0xa7/0xe0<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074335]=
 [drm] JPEG(0) JPEG decode is enabled in VM mode<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074803]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_syscall_64+0x34/0x80<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074808]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_SYSCALL_64_after_hwframe+0=
x44/0xae<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074811]=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; other inf=
o that might help us debug this:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.074813]=
&nbsp; Possible unsafe locking scenario:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.075302]=
 [drm] JPEG(1) JPEG decode is enabled in VM mode<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.075779]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; CPU1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.076361]=
 amdgpu 0000:43:00.0: amdgpu: MEM ECC is active.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.076765]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ----<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.077265]=
 amdgpu 0000:43:00.0: amdgpu: SRAM ECC is active.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078649]=
&nbsp;&nbsp; lock(pci_rescan_remove_lock);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078652]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock((work_completion)(&amp;wfc.work))=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078653]=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock(pci_rescan_remove_lock);<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078655]=
&nbsp;&nbsp; lock((work_completion)(&amp;wfc.work));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078656]=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ***=
 DEADLOCK ***<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078656]=
 5 locks held by bash/3632:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.078658]=
&nbsp; #0: ffff9c39c7b89438<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.079612]=
 amdgpu 0000:43:00.0: amdgpu: RAS INFO: ras initialized successfully, hardw=
are ability[7fff] ras_mask[7fff]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.080089]=
&nbsp; (<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.080602]=
 [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size i=
s 9-bit<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.081082]=
 sb_writers<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.081601]=
 amdgpu 0000:43:00.0: amdgpu: VRAM: 32752M 0x0000008000000000 - 0x00000087F=
EFFFFFF (32752M used)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.082102]=
 #6<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.082630]=
 amdgpu 0000:43:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FF=
FFFFF<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.083152]=
 ){.+.+}-{0:0}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.083687]=
 amdgpu 0000:43:00.0: amdgpu: AGP: 267878400M 0x0000008800000000 - 0x0000FF=
FFFFFFFFFF<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.084210]=
 , at: ksys_write+0xa7/0xe0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.085708]=
 [drm] Detected VRAM RAM=3D32752M, BAR=3D32768M<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.086205]=
&nbsp; #1:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.086733]=
 [drm] RAM width 4096bits HBM<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.087269]=
 ffff9c5959011088<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.087890]=
 [drm] amdgpu: 32752M of VRAM memory ready<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.088389]=
&nbsp; (<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.088972]=
 [drm] amdgpu: 32752M of GTT memory ready.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.089572]=
 &amp;of-&gt;mutex<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.090206]=
 [drm] GART: num cpu pages 131072, num gpu pages 131072<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.090804]=
 ){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x103/0x1b0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.090808]=
&nbsp; #2: ffff9c39c882a9e0 (kn-&gt;active#423){.+.+}-{0:0}, at: kernfs_fop=
_write_iter+0x10c/0x1b0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.091639]=
 [drm] PCIE GART of 512M enabled.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.092117]=
&nbsp; #3:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.092801]=
 [drm] PTB located at 0x0000008000000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.093480]=
 ffffffffa3c62308<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094566]=
 amdgpu 0000:43:00.0: amdgpu: PSP runtime database doesn't exist<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094822]=
&nbsp; (pci_rescan_remove_lock){+.+.}-{3:3}, at: rescan_store+0x55/0x90<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094827]=
 &nbsp;#4: ffff9c597392b248 (&amp;dev-&gt;mutex){....}-{3:3}, at: __device_=
attach+0x39/0x160<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.094835]=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stack bac=
ktrace:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.097098]=
 [drm] Found VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revision: 21<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.097467]=
 CPU: 47 PID: 3632 Comm: bash Not tainted 5.16.0-kfd+ #1<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098169]=
 amdgpu 0000:43:00.0: amdgpu: Will use PSP to load VCN firmware<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098839]=
 Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1 08/14/20=
18<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098841]=
 Call Trace:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098842]=
&nbsp; &lt;TASK&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098843]=
&nbsp; dump_stack_lvl+0x44/0x57<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098848]=
&nbsp; check_noncircular+0x105/0x120<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.098853]=
&nbsp; ? unwind_get_return_address+0x1b/0x30<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.112924]=
&nbsp; ? register_lock_class+0x46/0x780<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.113630]=
&nbsp; ? __lock_acquire+0x1552/0x1ac0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.114342]=
&nbsp; __lock_acquire+0x1552/0x1ac0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.115050]=
&nbsp; lock_acquire+0x26c/0x300<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.115755]=
&nbsp; ? __flush_work+0x2f5/0x470<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.116460]=
&nbsp; ? lock_is_held_type+0xdf/0x130<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.117177]=
&nbsp; __flush_work+0x315/0x470<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.117890]=
&nbsp; ? __flush_work+0x2f5/0x470<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.118604]=
&nbsp; ? lock_is_held_type+0xdf/0x130<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.119305]=
&nbsp; ? mark_held_locks+0x49/0x70<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.119981]=
&nbsp; ? queue_work_on+0x2f/0x70<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.120645]=
&nbsp; ? lockdep_hardirqs_on+0x79/0x100<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.121300]=
&nbsp; work_on_cpu+0x98/0xc0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.121702]=
 [drm] reserve 0x400000 from 0x87fec00000 for PSP TMR<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.121947]=
&nbsp; ? __traceiter_workqueue_execute_end+0x40/0x40<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.123270]=
&nbsp; ? pci_device_shutdown+0x60/0x60<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.123880]=
&nbsp; pci_device_probe+0x1bc/0x1d0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.124475]=
&nbsp; really_probe+0x102/0x450<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.125060]=
&nbsp; __driver_probe_device+0x100/0x170<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.125641]=
&nbsp; driver_probe_device+0x1f/0xa0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.126215]=
&nbsp; __device_attach_driver+0x6b/0xe0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.126797]=
&nbsp; ? driver_allows_async_probing+0x50/0x50<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.127383]=
&nbsp; ? driver_allows_async_probing+0x50/0x50<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.127960]=
&nbsp; bus_for_each_drv+0x6a/0xb0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.128528]=
&nbsp; __device_attach+0xe2/0x160<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.129095]=
&nbsp; pci_bus_add_device+0x4a/0x80<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.129659]=
&nbsp; pci_bus_add_devices+0x2c/0x70<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.130213]=
&nbsp; pci_bus_add_devices+0x65/0x70<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.130753]=
&nbsp; pci_bus_add_devices+0x65/0x70<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.131283]=
&nbsp; pci_bus_add_devices+0x65/0x70<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.131780]=
&nbsp; pci_bus_add_devices+0x65/0x70<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.132270]=
&nbsp; pci_bus_add_devices+0x65/0x70<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.132757]=
&nbsp; pci_rescan_bus+0x23/0x30<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.133233]=
&nbsp; rescan_store+0x61/0x90<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.133701]=
&nbsp; kernfs_fop_write_iter+0x132/0x1b0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.134167]=
&nbsp; new_sync_write+0x11f/0x1b0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.134627]=
&nbsp; vfs_write+0x35b/0x3b0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.135062]=
&nbsp; ksys_write+0xa7/0xe0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.135503]=
&nbsp; do_syscall_64+0x34/0x80<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.135933]=
&nbsp; entry_SYSCALL_64_after_hwframe+0x44/0xae<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.136358]=
 RIP: 0033:0x7f0058a73224<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.136775]=
 Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48=
 8d 05 c1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 &lt;48&gt; 3d 00 =
f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53
 48 89 f5<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.137663]=
 RSP: 002b:00007ffc4f4c71a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.138121]=
 RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0058a73224<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.138590]=
 RDX: 0000000000000002 RSI: 000055d466c24450 RDI: 0000000000000001<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.139064]=
 RBP: 000055d466c24450 R08: 000000000000000a R09: 0000000000000001<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.139532]=
 R10: 000000000000000a R11: 0000000000000246 R12: 00007f0058d4f760<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.140003]=
 R13: 0000000000000002 R14: 00007f0058d4b2a0 R15: 00007f0058d4a760<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.140485]=
&nbsp; &lt;/TASK&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.183669]=
 amdgpu 0000:43:00.0: amdgpu: HDCP: optional hdcp ta ucode is not available=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.184214]=
 amdgpu 0000:43:00.0: amdgpu: DTM: optional dtm ta ucode is not available<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.184735]=
 amdgpu 0000:43:00.0: amdgpu: RAP: optional rap ta ucode is not available<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.185234]=
 amdgpu 0000:43:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not =
available<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.185823]=
 amdgpu 0000:43:00.0: amdgpu: use vbios provided pptable<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.186327]=
 amdgpu 0000:43:00.0: amdgpu: smc_dpm_info table revision(format.content): =
4.6<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.188783]=
 amdgpu 0000:43:00.0: amdgpu: SMU is initialized successfully!<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.190039]=
 [drm] kiq ring mec 2 pipe 1 q 0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.203608]=
 [drm] VCN decode and encode initialized successfully(under DPG Mode).<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.204178]=
 [drm] JPEG decode initialized successfully.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.246079]=
 kfd kfd: amdgpu: Allocated 3969056 bytes on gart<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.327589]=
 memmap_init_zone_device initialised 8388608 pages in 64ms<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.328139]=
 amdgpu: HMM registered 32752MB device memory<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.328784]=
 amdgpu: Virtual CRAT table created for GPU<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.329844]=
 amdgpu: Topology: Add dGPU node [0x738c:0x1002]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.330387]=
 kfd kfd: amdgpu: added device 1002:738c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.330965]=
 amdgpu 0000:43:00.0: amdgpu: SE 8, SH per SE 1, CU per SH 16, active_cu_nu=
mber 72<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.331725]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 0 on hub 0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.332296]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 1 on hub 0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.332856]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 4 on hub 0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.333414]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 5 on hub 0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.333965]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 6 on hub 0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.334507]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 7 on hub 0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.335057]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 8 on hub 0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.335594]=
 amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 9 on hub 0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.336137]=
 amdgpu 0000:43:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 10 on hub 0<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.336679]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.337234]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma1 uses VM inv eng 1 on hub 1<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.337790]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma2 uses VM inv eng 4 on hub 1<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.338343]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma3 uses VM inv eng 5 on hub 1<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.338906]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma4 uses VM inv eng 6 on hub 1<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.339448]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma5 uses VM inv eng 0 on hub 2<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.339987]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma6 uses VM inv eng 1 on hub 2<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.340519]=
 amdgpu 0000:43:00.0: amdgpu: ring sdma7 uses VM inv eng 4 on hub 2<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.341041]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 5 on hub 2<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.341570]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 6 on hub 2<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.342101]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 7 on hub 2<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.342630]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_1 uses VM inv eng 8 on hub 2<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.343152]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.0 uses VM inv eng 9 on hub 2<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.343657]=
 amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.1 uses VM inv eng 10 on hub 2<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.344136]=
 amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_0 uses VM inv eng 11 on hub 2<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.344610]=
 amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_1 uses VM inv eng 12 on hub 2<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.378213]=
 amdgpu: Detected AMDGPU 6 Perf Events.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.387349]=
 [drm] Initialized amdgpu 3.46.0 20150101 for 0000:43:00.0 on minor 1<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.388530]=
 pcieport 0000:d7:00.0: bridge window [io&nbsp; 0x1000-0x0fff] to [bus d8] =
add_size 1000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.389078]=
 pcieport 0000:d7:00.0: BAR 13: no space for [io&nbsp; size 0x1000]<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.389600]=
 pcieport 0000:d7:00.0: BAR 13: failed to assign [io&nbsp; size 0x1000]<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.390091]=
 pcieport 0000:d7:00.0: BAR 13: no space for [io&nbsp; size 0x1000]<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 132.390568]=
 pcieport 0000:d7:00.0: BAR 13: failed to assign [io&nbsp; size 0x1000]<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 155.359200]=
 HelloWorld[3824]: segfault at 68 ip 00007f4c979f764e sp 00007ffc9b3bb610 e=
rror 4 in libamdhip64.so.4.4.21432-f9dccde4[7f4c979b3000+2eb000]<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[&nbsp; 155.360268]=
 Code: 48 8b 45 e8 64 48 33 04 25 28 00 00 00 74 05 e8 b8 c7 fb ff 48 8b 5d=
 f8 c9 c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 f8 &lt;48&gt; 8b 40 =
68 5d c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48
 8b 45 f8<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Best regards,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Shuotao<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Andrey Grodzovsky &=
lt;andrey.grodzovsky@amd.com&gt;<br>
<b>Date: </b>Wednesday, April 6, 2022 at 10:36 PM<br>
<b>To: </b>Shuotao Xu &lt;shuotaoxu@microsoft.com&gt;, amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Ziyue Yang &lt;Ziyue.Yang@microsoft.com&gt;, Lei Qu &lt;Lei.Qu@m=
icrosoft.com&gt;, Peng Cheng &lt;pengc@microsoft.com&gt;, Ran Shu &lt;Ran.S=
hu@microsoft.com&gt;<br>
<b>Subject: </b>Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug S=
upport<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[You don't often ge=
t email from andrey.grodzovsky@amd.com. Learn why this is important at
<a href=3D"http://aka.ms/LearnAboutSenderIdentification.%5d">http://aka.ms/=
LearnAboutSenderIdentification.]</a><br>
<br>
Can you attach dmesg for the failure without your patch against<br>
amd-staging-drm-next ?<br>
<br>
Also, in general, patches for amdgpu upstream branches should be<br>
submitted to amd-gfx mailing list inline using git-send which makes it<br>
easy to comment and review them inline.<br>
<br>
Andrey<br>
<br>
On 2022-04-06 10:25, Shuotao Xu wrote:<br>
&gt; Hi Andrey,<br>
&gt;<br>
&gt; We just tried kernel 5.16 based on<br>
&gt; <a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;amp;data=3D05%7C01%=
7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86=
f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%=
7C%7C%7C&amp;amp;sdata=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&a=
mp;amp;reserved=3D0">
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fagd5f%2Flinux.git&amp;amp;data=3D05%7C01%7Cshuotaoxu%40mi=
crosoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd0=
11db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp=
;sdata=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;amp;reserved=
=3D0</a><br>
&gt; &lt;<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;amp;data=3D05%7=
C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988=
bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3=
000%7C%7C%7C&amp;amp;sdata=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%=
3D&amp;amp;reserved=3D0">https://nam06.safelinks.protection.outlook.com/?ur=
l=3Dhttps%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;amp;data=
=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7=
C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C3000%7C%7C%7C&amp;amp;sdata=3Djz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6B=
ZlmsmU%3D&amp;amp;reserved=3D0</a>&gt;<br>
&gt; amd-staging-drm-next branch, and found out that hotplug did not work o=
ut<br>
&gt; of box for Rocm compute stack.<br>
&gt;<br>
&gt; We did not try the rendering stack since we currently are more focused=
<br>
&gt; on AI workloads.<br>
&gt;<br>
&gt; We have also created a patch against the amd-staging-drm-next branch t=
o<br>
&gt; enable hotplug for ROCM stack, which were sent in another later email<=
br>
&gt; with same subject. I am attaching the patch in this email, in case tha=
t<br>
&gt; you would want to delete that later email.<br>
&gt;<br>
&gt; Best regards,<br>
&gt;<br>
&gt; Shuotao<br>
&gt;<br>
&gt; *From: *Andrey Grodzovsky &lt;andrey.grodzovsky@amd.com&gt;<br>
&gt; *Date: *Wednesday, April 6, 2022 at 10:13 PM<br>
&gt; *To: *Shuotao Xu &lt;shuotaoxu@microsoft.com&gt;,<br>
&gt; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br=
>
&gt; *Cc: *Ziyue Yang &lt;Ziyue.Yang@microsoft.com&gt;, Lei Qu<br>
&gt; &lt;Lei.Qu@microsoft.com&gt;, Peng Cheng &lt;pengc@microsoft.com&gt;, =
Ran Shu<br>
&gt; &lt;Ran.Shu@microsoft.com&gt;<br>
&gt; *Subject: *[EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Suppo=
rt<br>
&gt;<br>
&gt; [You don't often get email from andrey.grodzovsky@amd.com. Learn why<b=
r>
&gt; this is important at <a href=3D"http://aka.ms/LearnAboutSenderIdentifi=
cation.%5d">
http://aka.ms/LearnAboutSenderIdentification.]</a><br>
&gt; &lt;<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dh=
ttp%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&amp;amp;data=3D05=
%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f9=
88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C3000%7C%7C%7C&amp;amp;sdata=3DHfSwu6SWfoCYyscJqGFdKHBPtaj%2BKB4lyo13zkm6hi=
4%3D&amp;amp;reserved=3D0">https://nam06.safelinks.protection.outlook.com/?=
url=3Dhttp%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&amp;amp;da=
ta=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167=
%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DHfSwu6SWfoCYyscJqGFdKHBPtaj%2BKB4lyo1=
3zkm6hi4%3D&amp;amp;reserved=3D0</a>&gt;<br>
&gt;<br>
&gt; Looks like you are using 5.13 kernel for this work, FYI we added<br>
&gt; hot plug support for the graphic stack in 5.14 kernel (see<br>
&gt; <a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-A=
MDGPU-Hot-Unplug&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1f=
cb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63=
7848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3D4l9mT8zNR%=
2FvqsEFr7noIDqKf16IGN8xmO2T6jnpipzo%3D&amp;amp;reserved=3D0)">
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.pho=
ronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug=
&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b8730=
8da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564=
%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW=
wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf=
16IGN8xmO2T6jnpipzo%3D&amp;amp;reserved=3D0)</a><br>
&gt; &lt;<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.=
14-AMDGPU-Hot-Unplug&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C9=
3f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%=
7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2=
luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3D4l9mT8=
zNR%2FvqsEFr7noIDqKf16IGN8xmO2T6jnpipzo%3D&amp;amp;reserved=3D0">https://na=
m06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.phoronix.com%=
2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug&amp;amp;d=
ata=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae16=
7%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown=
%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6=
Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3D4l9mT8zNR%2FvqsEFr7noIDqKf16IGN8xmO2=
T6jnpipzo%3D&amp;amp;reserved=3D0</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; I am not sure about the code part since it all touches KFD driver (KFD=
<br>
&gt; team can comment on that) - but I was just wondering if you try 5.14<b=
r>
&gt; kernel would things just work for you out of the box ?<br>
&gt;<br>
&gt; Andrey<br>
&gt;<br>
&gt; On 2022-04-05 22:45, Shuotao Xu wrote:<br>
&gt;&gt; Dear AMD Colleagues,<br>
&gt;&gt;<br>
&gt;&gt; We are from Microsoft Research, and are working on GPU disaggregat=
ion<br>
&gt;&gt; technology.<br>
&gt;&gt;<br>
&gt;&gt; We have created a new pull requestAdd PCIe hotplug support for amd=
gpu by<br>
&gt;&gt; xushuotao &middot; Pull Request #131 &middot; RadeonOpenCompute/RO=
CK-Kernel-Driver<br>
&gt;&gt; (github.com)<br>
&gt;&gt; &lt;https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;=
amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17=
dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DqEeZR6R95jrjAaltd1MnpyFedOiVZaN=
QuCxcoNog90g%3D&amp;amp;reserved=3D0<br>
&gt; &lt;<a href=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F1=
31&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87=
308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6378485261848585=
64%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DqEeZR6R95jrjAaltd1MnpyFe=
dOiVZaNQuCxcoNog90g%3D&amp;amp;reserved=3D0">https://nam06.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK=
-Kernel-Driver%2Fpull%2F131&amp;amp;data=3D05%7C01%7Cshuotaoxu%40microsoft.=
com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7=
C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;amp;sdata=
=3DqEeZR6R95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g%3D&amp;amp;reserved=3D0</a>&=
gt;&gt;in<br>
&gt;&gt; ROCK-Kernel-Driver, which will enable PCIe hot-plug support for am=
dgpu.<br>
&gt;&gt;<br>
&gt;&gt; We believe the support of hot-plug of GPU devices can open doors f=
or<br>
&gt;&gt; many advanced applications in data center in the next few years, a=
nd we<br>
&gt;&gt; would like to have some reviewers on this PR so we can continue fu=
rther<br>
&gt;&gt; technical discussions around this feature.<br>
&gt;&gt;<br>
&gt;&gt; Would you please help review this PR?<br>
&gt;&gt;<br>
&gt;&gt; Thank you very much!<br>
&gt;&gt;<br>
&gt;&gt; Best regards,<br>
&gt;&gt;<br>
&gt;&gt; Shuotao Xu<br>
&gt;&gt;<br>
&gt;<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_PSAP153MB05176F6C82945DE2C3443248B7E79PSAP153MB0517APCP_--
