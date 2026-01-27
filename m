Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB03D25933
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 04:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA0C10E264;
	Tue, 27 Jan 2026 04:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WK69SfHn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B4510E264
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 04:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCRMvwMNRrxxQOJrvZpgX941pnurtuVpYmpp+egafKOYKuQOEEpehJKCtTKAu7XvHtZPLYKkiIIY45ShfOKQq5uVOv9utOQ8m04SNKBqtP6Mv/g9yJ9eOXM1DZPQrhRR8HUtogLHBz6J53tqKbZqIXzvHvrlw1kn6KPDoReKeK1VO+M4Xu5hZxd/i8KaRBV6V8b2GHsf1y3VwmW8G6VK7FdEzaG6XpTZ+op2WQfpxq+ghASFUJzZNDF3HHO8mE6UdSzm2xmlIj+I3Lea0iMMO7XhRkIbLmnCoVGfTh1qKTCcmvZJP3Sh/swOHB8J9Cfgwcm8JVyXxTMUG7nqJf2fdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRhVKsiq/XCDIXxopuvWOvb1sd0x/orLh2ikf79o/Xs=;
 b=bgtBQ7SQ4nJ9GpItvT1adxW7d1WPMgkuhvGgzvKWVWROCuYQz1BsIf+dKU59udHIZPT6YuOAMUk3ZrMkeIUldoka0F23iAxuRlW5pT0l5MroFcBSBppEEEfMKsklvtf7HLDOqmiOuIjnancDRGfctnx4Po874XQM9S+XkEyyt4OnZmHHDx2SXSMdMYUTeOMjY/UQGBbytDNxZYbBb3r3690Bc/9NizvV+z1DtX7upbUe3Wtyu9mSqUZ4rIF/qqmaOaZnh5UbVordmPxRZf4WZD17Sa0jZgGF6FhynZUkl8dp41WEPPEo4JKwIbFZBQzL0/0IHJWI/AEXeo4DTQ5RmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRhVKsiq/XCDIXxopuvWOvb1sd0x/orLh2ikf79o/Xs=;
 b=WK69SfHnhG0cGYWeCaN3FxPvo7WBxWz2/+8sL3qxBAUyvKFsZBFeP9jMpv0H+6AH0zqVxJ7Z3du1SdCKt76+D61hpIOHs9W4ZBwNb5bzb9l8WEiFYg2k+iwqs1BYdUM0zFtSAdO6T1eoFnbV3GLuxC8VCvh2rYZ6k9qBGWw/wKo=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 04:14:05 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 04:14:05 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 04/14] drm/amd/ras: add uniras smu feature flag init func
Thread-Topic: [PATCH 04/14] drm/amd/ras: add uniras smu feature flag init func
Thread-Index: AQHcjneskBSG3gHyT0WASHTScAxGN7VlY+oAgAAF0dA=
Date: Tue, 27 Jan 2026 04:14:05 +0000
Message-ID: <MW5PR12MB5684E842BACA3CAAF32ED8A4E590A@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
 <20260126035527.1108488-4-ganglxie@amd.com>
 <PH7PR12MB8796BE287B5BD76B51F5B433B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796BE287B5BD76B51F5B433B090A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-27T03:52:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|CY5PR12MB6154:EE_
x-ms-office365-filtering-correlation-id: 09bb1e02-bbae-472f-a7bb-08de5d5a827a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/DagtB+P0eH2HcbeGP4PClAO9YtwnY0HQS3Io0JBEdCaPYhobUjU1UXN9PiY?=
 =?us-ascii?Q?1C0vHZ+Mm8c3vd1Q3ky9JOQWtryXSdQ0R7TBy0fjpIhRSTmMqHnZGViU3/5Z?=
 =?us-ascii?Q?Df+cUYHzu2OmlgALrBk85el/aH/U05l8Ehgb3p1OnfrqEUYQFmWnXfPuBtI8?=
 =?us-ascii?Q?A7y/dVq1X4IPAgNOjLp1avrvYaob0CSvbO5umQbP/F9xGWSXz6+w1bnMce3T?=
 =?us-ascii?Q?doRLo3On7TsJZqVHZOknCwPJtL1621ZLYz4eCyVFL1QLbN1REGWjtbdKsdo0?=
 =?us-ascii?Q?17+tAuYVSlYjgxNQscXRqU/b20dOSmX7lbFciLNK0buxzEGqSFv8RFvr2mFK?=
 =?us-ascii?Q?pF2E14FrGH0CT7vzHbqXgpiQEb39iiABjw1Feg4Y7NeCp8cZqBt0vXumSjTM?=
 =?us-ascii?Q?I8QNjCgvabd4Hfx00h/MMfFBUfJMD1SQMOiZiwPECPR6N7buoQr3FpvdsQiL?=
 =?us-ascii?Q?WnyptdnibCN7pL6DyK+nIhZd2sOu++2qLJYtdlfREnHewYlnO8/SiS9nYRNn?=
 =?us-ascii?Q?moGpaIkKzcsHyjx4lBMkTUy1s3N7V0Ie4V0RxzVrJK/kt9HMMAyx2sn1ny1Z?=
 =?us-ascii?Q?pzWWd5G/E3VJ37vAuwi4JMD4iotzs4R8DGyGVfJUiMCbpLoyEl1DyCSWv9zi?=
 =?us-ascii?Q?SO7tvvevyLnvIOR7ooxIeyRCfYY102YGVwON/XGETuZA4effN9Usbyq4xCUy?=
 =?us-ascii?Q?zCpAk5zwVa0P4TymBhrOIV8BcZBOkGgwecMloJ87x/EilBQvcyv5xWbCsFCm?=
 =?us-ascii?Q?y1sAgp3PAluZzknvA2sT1huIm6uXIwBr8NWXG9FDC5oz4PKoGkGGHgQ6452+?=
 =?us-ascii?Q?JWtLbYP9wn899xewsi78OK3wke7dCjzyQ1UxR50IOEXWBOpK+6yQ2t1+vcAj?=
 =?us-ascii?Q?HjyLJ5gezQF9DfGblOpWqlNLI+w4DXGOvp4YdH0/P29L4tx+F5Tj9FetVvWD?=
 =?us-ascii?Q?4RfDFc/CgZk5jFqq+kcmj21Eg0ViBXMwCffmESK8npRcgrNwCZmr+YX7oNEy?=
 =?us-ascii?Q?c/aTEsnGWeXtrjWVfrTK3PVXA6qHdQhueO6PzM5ezNtH9fHiOo52Q7Dvc+Po?=
 =?us-ascii?Q?3Jm64YPNtpEeOjhfTa4ctsqRz6DNssTpfCjNDSWwKIIPUV8vx762a9wV2iFp?=
 =?us-ascii?Q?K4XZkIYUnimEYVGIslbLSq7U+BpEJ5T+vdqcIeVoE0h9+ARa1q8fVXlDu2Oo?=
 =?us-ascii?Q?/H+Hm1HKEMm/fgamcgmRdCqEWUj1Snmf4DduJANzVWHXIGYUtbXjyWs06qqZ?=
 =?us-ascii?Q?C58zqhOOZnKTPB9kECHgb3GL5e8dLZCmA0ze5qSUejovSVoDinps65QqhqAn?=
 =?us-ascii?Q?O/q4tf0idothils7N9mREEvmRxD/sstV042CwF9BLajUhOXMmRTZGT3FGFfI?=
 =?us-ascii?Q?ZImF/Js57c1pNvsI+Lpb1/Wo+SSmMUfHDTPorH9C1C+Clzzsi99hvgTuVRL2?=
 =?us-ascii?Q?doF98OKL5dIHXDxlX8pIfhfOCb6M01ZPopmqwUF0rkkZyO5Y5krHKP+Hvce6?=
 =?us-ascii?Q?zTCQhmS5sRZV5J7t2gt+j62l1nQzHoSZotUYVpmGuhzFUhNnjjVF3r+hhMZl?=
 =?us-ascii?Q?zI6u9N5fSn7oVvw157fpf9ch29lWrQQaZI0mF8ZyUqnZxP67YM2NCuw7Y4vI?=
 =?us-ascii?Q?x/mkcVD2/Hjsn1JM4i9/bHs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hVsW4lF8gNc335uMQ8+HJzlMR9abCOI5nlYL9M9Clj6N35wwJ+3iNahdeJ56?=
 =?us-ascii?Q?PNFgwUxiPf9zlDtVCngVMTZ0lU0CZHYbjcRMBYh/a2+CYp80sLaoNwYnYnfK?=
 =?us-ascii?Q?R4N3kqeRKAAocKVJtS2Byg3ZrXPbqqRT8w1FL8VGYHmAxHUWRDb3UuNEaa+0?=
 =?us-ascii?Q?puffV3I4jPRZRKR7AuB3iJSfn7UnFntLnmLBx4fctrcchbecwxtgjOIOxD+6?=
 =?us-ascii?Q?yb4bfuCuY3EQpxNNZXoAuBPxjNGiJFEa2eyGekbKpZxSg5TdxEDidr3aa/fG?=
 =?us-ascii?Q?gxAWURx2KFqMb1RkDUp7mJmrxIoXqEpim99YZX/vkNQozDIufoLcLAa6ggdk?=
 =?us-ascii?Q?hswQISOD0IgehW4Xl+8/+3spJuTNAtt63Zgu3AtkIwHVymma/XepYuz54mqN?=
 =?us-ascii?Q?/RFKFXDnMWSgbkEJCelJp0DZMRCjJpy7vTzMVPjgCC7KF59lQotcaLKhvdWm?=
 =?us-ascii?Q?DSMnEl92fSLcVvz6gJ1fyWmDaos5+0nXANjpFjQg9jHzEEug8qq9BHHv/YNM?=
 =?us-ascii?Q?Eh5H+P+/epZDYuQqpv/Rv9657SX6dvZBCnqUucZA46clAgWBwZz//LDmuHba?=
 =?us-ascii?Q?aYqUEewGEDGR0kiDec4ka8fpI/Kg4ZvVh9GQd63HGDyaN5fy4SR6Gv/B6h1e?=
 =?us-ascii?Q?ouW8yzRpOSlNtWMXAaOI3/k+ROU2RYS95rww3Bw2Ii7HRs+V8Ah/K+oiJRup?=
 =?us-ascii?Q?hbIFeWnqzQncCTjDAiCfGZyGeMwy4RLSCgUiUUIxPCEaV/nCtdQD4EOvA0Ib?=
 =?us-ascii?Q?bxgQzO+CwVahhLrHi8U5KO9DbYS9FB0iP8/NUIWCc2X+vUSzhezN+UorOQmv?=
 =?us-ascii?Q?FQQE3a1Zyfh2P/CCN0vwH/eOovkP6jTM66+RP1b0mp2mrW5evUaxf2hk8R/6?=
 =?us-ascii?Q?NpoQ+I65ONKdklcW3+9Wuox4ycf9Vz7K+Uv1Ipty0yEYZt/U31ruLvpaJd7C?=
 =?us-ascii?Q?vcirsaWGNL2ZRTT7+iqzf5UjqfGywGhKf37Xv7J89s/sQfmb3dJ3F0lIENeV?=
 =?us-ascii?Q?lZnQyL9j45JN2+uM6Ivn2Vu8ZOwbjAliJH74ybwodcw2xV/DJ6sJ1LFGWdEc?=
 =?us-ascii?Q?XoXAPvxHyeVBMkmFB29lAu3aZwYiUUaP8ulrTwDIsDCBxXrIfqFpY0l7SjkB?=
 =?us-ascii?Q?lUBBUdC/WKjkrMNdEQxN5PH+KSsLwHlfL/fldv4dYHmeBb6NTw5l/YH/+AaF?=
 =?us-ascii?Q?jeq+qWRrIhENFPdgGSNzsIf3sjc1xAPn07ImlOYvBOE7Hf+6hEY/uYeURWpV?=
 =?us-ascii?Q?/2X9wwuT2q3+5rldCU3dtTetXu2bY1fYqfwUplEpLqsoAXjB9vakDioLyuMJ?=
 =?us-ascii?Q?vnYQ7vxkUPhVdwHvV1wvP7+4QRZRVsrwevYg9dBYJuu6WtDeAm416wHQzwe1?=
 =?us-ascii?Q?3Q6u4Dif1rqV1zv7G/leOGjOuPJtzPogD44gBFZXGaxCZ3/+F/XI6UD2y5xu?=
 =?us-ascii?Q?y0YpYcEswkLep/NenS25Pa23s/oLqqX7crtWSiEnUu4loUS+dS8POmw2b6go?=
 =?us-ascii?Q?BQl3Y2IHn4q8BW5MjP/r0NseLkw2ien6eV6nKjxJHMQy5qM+8w7migTVGRO4?=
 =?us-ascii?Q?WrQ0mXM5RpmDNXtFdcGoL7nF3FkO069rNStuMrjORIT1YoQHWyyogKS8k2Hh?=
 =?us-ascii?Q?CLQu2BYCcruQ791S/f9sBlY6XF85MO/UkVsIeq7HImQRvaNtIgOzOoItAyZC?=
 =?us-ascii?Q?j9kqoJWn+gdX6zWX3LDuzCwkIqk98IxRg5iHLetcw+MbGJJT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bb1e02-bbae-472f-a7bb-08de5d5a827a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 04:14:05.0483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uREHTsnzMPW1tTiDcsdb8UiSYzhRqhA+A7hpMkEsqXBIH9ZwxmL0SSDpT8sL98fVb4BcOUeIYdLbeL8ZXkie8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks, will change to '2026'

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, January 27, 2026 11:53 AM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 04/14] drm/amd/ras: add uniras smu feature flag init fu=
nc

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Monday, January 26, 2026 11:55 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 04/14] drm/amd/ras: add uniras smu feature flag init
> func
>
> add flag to indicate if pmfw eeprom is supported or not, and
> initialize it
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/Makefile      |  3 +-
>  drivers/gpu/drm/amd/ras/rascore/ras.h         |  3 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  2 +
>  .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 38 +++++++++++++++++++
>  .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   | 29 ++++++++++++++
>  5 files changed, 74 insertions(+), 1 deletion(-)  create mode 100644
> drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
>  create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile
> b/drivers/gpu/drm/amd/ras/rascore/Makefile
> index e826a1f86424..06b265ec1cde 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/Makefile
> +++ b/drivers/gpu/drm/amd/ras/rascore/Makefile
> @@ -36,7 +36,8 @@ RAS_CORE_FILES =3D ras_core.o \
>                       ras_log_ring.o \
>                       ras_cper.o \
>                       ras_psp.o \
> -                     ras_psp_v13_0.o
> +                     ras_psp_v13_0.o \
> +                     ras_eeprom_fw.o
>
>
>  RAS_CORE =3D $(addprefix
> $(AMD_GPU_RAS_PATH)/rascore/,$(RAS_CORE_FILES))
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h
> b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index 2db838c444f1..6e223eff522c 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -36,6 +36,7 @@
>  #include "ras_mp1.h"
>  #include "ras_psp.h"
>  #include "ras_log_ring.h"
> +#include "ras_eeprom_fw.h"
>
>  #define RAS_HW_ERR           "[Hardware Error]: "
>
> @@ -335,6 +336,8 @@ struct ras_core_context {
>       spinlock_t seqno_lock;
>
>       bool ras_core_enabled;
> +
> +     u64 ras_fw_features;
>  };
>
>  struct ras_core_context *ras_core_create(struct ras_core_config
> *init_config); diff -- git
> a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 01122b55c98a..91c883f16ae5 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -382,6 +382,8 @@ int ras_core_hw_init(struct ras_core_context *ras_cor=
e)
>       if (ret)
>               goto init_err5;
>
> +     ras_fw_init_feature_flags(ras_core);
> +
>       ret =3D ras_eeprom_hw_init(ras_core);
>       if (ret)
>               goto init_err6;
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> new file mode 100644
> index 000000000000..4a65351569e8
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.

[Tao] 2026

> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "ras.h"
> +
> +void ras_fw_init_feature_flags(struct ras_core_context *ras_core) {
> +     struct ras_mp1 *mp1 =3D &ras_core->ras_mp1;
> +     const struct ras_mp1_sys_func *sys_func =3D mp1->sys_func;
> +     uint64_t flags =3D 0ULL;
> +
> +     if (!sys_func || !sys_func->mp1_get_ras_enabled_mask)
> +             return;
> +
> +     if (!sys_func->mp1_get_ras_enabled_mask(ras_core, &flags))
> +             ras_core->ras_fw_features =3D flags; }
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> new file mode 100644
> index 000000000000..58472e459470
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.

[Tao] 2026

> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __RAS_EEPROM_FW_H__
> +#define __RAS_EEPROM_FW_H__
> +
> +void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
> +
> +#endif
> --
> 2.34.1


