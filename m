Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A570C88E41
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 02:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 605C210E389;
	Mon, 26 Jan 2026 02:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mhLdA0BG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011036.outbound.protection.outlook.com
 [40.93.194.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F6710E389
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 02:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i70cjMUkox5w3Cm0cAOmInhAnsvB6wHpQ6BMONaiG9BnbWTXT3rZG+3advRkR6+Dio4g2RZAWbmWFZOJZ6AF7gKL77PPzIiOhjZJLlRNnF/qWFEteHKte0qWnFNCAALZut09vBKocaigik+BEU2U1aIk8a9X1i9WxxmFESDMWNiLe1yjVwPbAFgLapWWfIIhVkCOZJlWEX8cwdCspE1tljSuYzMMaIaNr2nk/Qu/QIQvGlnWKrPLg+llVF7Iy8eIfpF9ndApNjqhApABUaMYSrU7zH7qhNM0qTU+j8H+/1b2+myBxIxPqHojfuzcNuPKSREB0hmFyeQftzaRu5oX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FoA09M/qFgP6YaIivQuxQcvwi/fOighTjQBBojBKOs=;
 b=Tjbhx8BulkvMPP8n3QDnd8/Pr8igxLnijDkRsmBsOTLzPzrpF9cyh0BGweLD7m3xXwIfsdr0hqVIVCcTqx54y7WgmQsiLKYu8slTRmvpz9F9rjKGZnFtk3Z6hSUliUtVPON0JzdHu3uqD3mEFtjDfPayOWrRCA49mMovE54hWIshs+jdpQ4ftrK1muXvLEjrqm8w19VLtlUdT3Ra26cRyeFB63tjHU1ARWBT9M0wV74ETmMStxwkA3XeZvz69lS147sMR4Gq834ZaNsQjUW0+mnKIUBpghoan31ACYysZqyAIDXFctUMYwPh1zW6XdmuJ/H8jHB0qP8hVLI+8Uj/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FoA09M/qFgP6YaIivQuxQcvwi/fOighTjQBBojBKOs=;
 b=mhLdA0BG8aN+lbZOiODMdowcXhCtrmMCbqTMEkwHB77GMUB7kEzahylLG0aZ0x/bULDULvzdAmYIu7MYJl5AAbUyGDkjiUQWx6rH/76PyN4kWsDkRd4LvfLvywsPectap+3sP9WzUUnPuDP/Lu2fykpaM8sdWfQ12uqZpqseNiY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS5PPFDBFC954F7.namprd12.prod.outlook.com (2603:10b6:f:fc00::664)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 02:40:19 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 02:40:19 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Thread-Topic: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Thread-Index: AQHci7NcWqicV1uOgU2xzIOvuGM2iLVfRk2wgAC2JICAA8S+YA==
Date: Mon, 26 Jan 2026 02:40:19 +0000
Message-ID: <PH7PR12MB87960E8669B7A76762E9C920B093A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260122152501.351937-1-kent.russell@amd.com>
 <PH7PR12MB87965382F541A9E18CB67EF9B094A@PH7PR12MB8796.namprd12.prod.outlook.com>
 <BL1PR12MB589834F3ACE3526E2AA118F28594A@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB589834F3ACE3526E2AA118F28594A@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-23T16:58:23.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS5PPFDBFC954F7:EE_
x-ms-office365-filtering-correlation-id: ca214c9b-8fa8-4f1f-5c7d-08de5c843ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tYbFO+4rPUcszDKwcgGu2i6bfiLICaCptnWMTkv55F1s7NSb81bzdpGcpriz?=
 =?us-ascii?Q?qOa8SHRC+DYKd8TNbDjDyUcjGH6U3snoOO5kJmwJeoXAJmPI4y9iyukZeAiI?=
 =?us-ascii?Q?QFIvMXbW8INKwWELYn3/+8tD363+nTnN9YlzOMZJ5opBwTryseeA3Meuksq8?=
 =?us-ascii?Q?VVnUL8F34ZNXyJmerioiigNFfV334vIoxE4R0S6yh6gqQaGJ7DZjiCRXKSuP?=
 =?us-ascii?Q?Dv4tn5VfA5HGsWx7kVlMAP9up+Dl2ula0gcADCb0kAEFfHrW49a0FusX6Rkj?=
 =?us-ascii?Q?j7/d34GnQizoOm94CEBH9dF44Z2S3p0srBw+Ww6529Zt0l5dCAGvryVXM19F?=
 =?us-ascii?Q?CCtcd4krE9aoWGK54VKlCtGq6It2nC1hkbbFxnsSaaZz2XMkjcIrWKkKdaTH?=
 =?us-ascii?Q?niIoXz3nFTnCqo+UKvTSCgCF+OhTcAt3hSuo6VbOsH6foYJ5IBuz9BQX/Qtc?=
 =?us-ascii?Q?Sm18uR22iwMkTqae6elUCzaVthxPzx0yLIHFYyIrKKXOIicHLvpgYDYeVNzJ?=
 =?us-ascii?Q?5jmrQJ/R9NcglaqMWvFBV6c4SHZUmVIC3xgeEZxtgU1P78MnmKQtL63fC4VP?=
 =?us-ascii?Q?HJ+niMvbtSL0uCOG7rNxE1dsCZfeO1HhF7nNTJ7VvUfIyG/F3CFcvj4BsVFj?=
 =?us-ascii?Q?p9XIGyBdcJeWCUIi8oKdah9mAVQ2gQUNWtiTeFnHhcEx2wea1mFvz4LgI+Hr?=
 =?us-ascii?Q?BqUYk6vBCBAuew+u/OWB0OzKy51EdSo2EFbhqoVi03iKwFFkoBksMuobV2/2?=
 =?us-ascii?Q?3rAlI8iq9XJL8Ky7MQBNsJ5RZRyesWJmdOujP1TRC0SWuZ9S0KHh9wMVGlcU?=
 =?us-ascii?Q?G7pfvImcrE1TrtZzbNRVVT0Lc2lipQVRY4t9VoSsY0zwLrcqF0by8WgOMkhZ?=
 =?us-ascii?Q?Z8BWRzpbV4xUbFvCRpiP2mFwr27lzkyBPcdFkTjHK5zBIS9ZP3qBebXWHrWW?=
 =?us-ascii?Q?jarigI81VCWQHchDY6yRDKZoGI1FV5+4MkanezPsMw90MuCskWN2zYQazyVP?=
 =?us-ascii?Q?jclvt/n+z6HeutdGW0vbYYdQQPRyGzhhA9EntchGH9DHv/wCmclu4qmYo+8C?=
 =?us-ascii?Q?fdvJRssk5PsTnAcYY4rNUJ0/BRoCnp7g2kNHsiAtsLHUmnChf1is1yXyNTuV?=
 =?us-ascii?Q?MbADF/QEDfa3fBVIW9UrXE4i39Cqnlcw2S9dsq/koZOUX2Xv4P+W0q0ZgHmR?=
 =?us-ascii?Q?Ocf+kl6jr1PT3co1Y6bCADGZ3LnCtjnHd0UK7/9jYXS/XCr8yiP5f266m1VV?=
 =?us-ascii?Q?nUKdosFTLzAbGrKBFVes8E6k2S1dhmDR7b06SROEZUTHFweKyGs0xzVXJbdB?=
 =?us-ascii?Q?m1n+neEqMHYmNM68TD9VqxRxlx55pCqtgXU2OHor9i8AYzLFjVTARkHFRuuD?=
 =?us-ascii?Q?acy9CE6xDVaiQD40fuQvmev6QhWkwldFlQ9zcfcdR3hp8U67Sx5yB/BwkDjd?=
 =?us-ascii?Q?jq9mMOsEKCAOX6AaQQOL8j9xG40lFR563ph/ChAsmYLcT9M7iZLkfmuaWHcC?=
 =?us-ascii?Q?LWD2t6YTTVi46Lyjc+MGoxYmEaufUmyPLIm8Fj8+mYE/Z8WOD7TjI6MRNGGY?=
 =?us-ascii?Q?sDS0W2ZrANKnH89uu76S72TSUKe+B/HWc0PzOad3fqnK3kzj1ShFgnlcBj7u?=
 =?us-ascii?Q?2TUQLs/cDbmgOZs86zo4xAI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rGiTayhBSoLQkZYaXB9AyJGDOA0hl/XAUoOzb226ru8u9TijTqeoZ+QOAOgv?=
 =?us-ascii?Q?/LJMvWutATbKoCpAQzNzyPJ0EBNmGsu3ppMl/ZgZT4TRQrr00GDKFhywfsKA?=
 =?us-ascii?Q?BLH9UZlDqKLdLRMbNe+L7+3t/WbwUXLgwfZCxbL2Zd/afy+0RbwJmwzn2hU8?=
 =?us-ascii?Q?aqSM7JtHUQgX3pFA/6Rt4vill1n0cL58KZLyn4SnYK/T0gsKQ2mzXMVvDzNj?=
 =?us-ascii?Q?rjPbdN5q77oPF7AlLdjBH/DaxmpNkb237lDZ9akGzqEUocc5ClnXLEKm9lBs?=
 =?us-ascii?Q?K3Z6RonhTT+TXqvdtbYlCW8BJQ0UAJNkkOuAMmditrBgiHqVJcSIeW5/8jnJ?=
 =?us-ascii?Q?juef501Q9AK63c0MvunRGdrSfQoL4Ltt11ZwzUd0Ywo355RNetWJugENGkGW?=
 =?us-ascii?Q?43ydqWvpW4LK2UuUQ61gNW+pBEMi1TNCZ+Ovy01oLPRUszzqzcMSlEyLu2b0?=
 =?us-ascii?Q?qOYsgDev+YuupGd5LANc9SXW45CkTNfTSq4lCHneZdMFcWS1310j1K8Qb6Ro?=
 =?us-ascii?Q?y2HFlUnP/cqRC6mwsP+poe7UxSnGtwxWjgHTkxKDYvCqhUyGG7yMfbs9BUEc?=
 =?us-ascii?Q?hfbL89A2WSq1Uo2SqGR1QL9XC7HTIxMrXogGZCN+7SMDQYmYN2QptNVQt59m?=
 =?us-ascii?Q?kCgObTBwjdAhEg45D4YKd8kTgbI/vM6vXg1HC4+jwz0Vz6PHueXPeiQNKP8M?=
 =?us-ascii?Q?Jocqx5aAq4KyUa+XIYgzvVWZZ1JQ7M+oR9Rhs+gg1IB3MnAkTpUPI08o0fLh?=
 =?us-ascii?Q?aBZrA3xUntFQ4RqmW+h6dHP7zk1GcD+dULuvZRVRDdj0yXUrHzSlTUOesRo5?=
 =?us-ascii?Q?fDMPNDG61fms2YxADHEQubZsCk0OjECOWH3iCQIBJTQ5NchaAHgTA8cnDwKc?=
 =?us-ascii?Q?Emizp5V00T7MLUjzIvoVvjE7jEKoSyvnDtFOTjnj/fCHAzH+o8d8Q4r+qXqR?=
 =?us-ascii?Q?FDYsDZVtvsemXXpyoyrxFKsqN3HkCU5wPX2J1Jt1CqjsuVxsCtuxwnCJIB9B?=
 =?us-ascii?Q?z71nVu05QdXj79bPh4YQchOyxKPYRIHkU7FMqeFH5GgxqT9V28Eo0O/lzwqm?=
 =?us-ascii?Q?bVJgbXEY3kIgT8ggucEcLcHIl1LiO9D+B715NbDvtVTcUc4M0+XOCS9TA5cs?=
 =?us-ascii?Q?DMvlG8QHZO5GZBomXHt8m+BLl1njIbwF0lrvuMj9kWItHNseBh5QkfgBzGlO?=
 =?us-ascii?Q?DUAJzASeRaKsJE3DeB9mjTylHBwWJuPZz69b+SJeFIsa2KpBFsUDjdyUOf+U?=
 =?us-ascii?Q?O06m/II9khguQUFneBxZFhGqdC0Vay+mCUA8ZZ5GTZOUcDPsoQP8CnpQTCLn?=
 =?us-ascii?Q?fR6EKyXwMvfzdqfm+PGDeraliWTizpmZ/jJb41jSOxrI3BLZfb55dvsjNNkK?=
 =?us-ascii?Q?3tq0JNiCQLXeBCyv9TqVpLNnKPa2vd00DtPrfOpcmGvOPAJP5Y9Q8w4+ob3L?=
 =?us-ascii?Q?QSTaIsESKLMqYAd7fHvrP42asFhXWlYqAzmxquGxfLs21r/Ca0MOA8B98tyC?=
 =?us-ascii?Q?xJzFwPXV4Gtjq01HsvyDHILeslBKSZoQgn00zSKTdOwvumBQr8Eh9EpC5ioq?=
 =?us-ascii?Q?i7BFu0o803AHECIbHCJ/DTGPlAaa6GrlyNIOFIsc/m2qFsZJ+pDUQycZKq4R?=
 =?us-ascii?Q?AOqNr5cxBttcqsk6i/nrgs6bu//ks4zgi26wDa/BV+t3CpgT4yb7N97px6Qc?=
 =?us-ascii?Q?MWjBDBjx/4VV9/SY39BOP7OTzTjLnNOrJ0tx0oKmBA5P0teq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca214c9b-8fa8-4f1f-5c7d-08de5c843ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 02:40:19.1550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQPnne5m/BSRSsLPxb3FrocQogBxXQpzsHtunK9IEGwO1iEqbhX6ESJSOZUazTaK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDBFC954F7
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

[Public]

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Saturday, January 24, 2026 1:02 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
>
> [Public]
>
> Thanks Tao. This was really just to get some feedback on how to do this. =
And if there
> were any dependencies. Ideally we want to send out a CPER for the situati=
on in the
> commit message. I can definitely add that as a comment.
>
> For the 2nd part, I am not sure. The big issue is that systems that rely =
on CPERs to
> know when a GPU is bad will not have a CPER for this type of situation un=
til they
> take a new UE. So we want to alert them every time we load more than the
> threshold. Would in-band also benefit from that? Is there a drawback to h=
aving both?
> I figure more alerts is always better when it comes to unhealthy HW.
>
>  Kent
>

[Tao] Hi Kent, can system bootup successfully in this case? If the answer i=
s no, I think in-band CPER is unnecessary, otherwise user may be confused a=
bout the inconsistence of in-band and out-of-band cper.

> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Friday, January 23, 2026 1:14 AM
> > To: Russell, Kent <Kent.Russell@amd.com>;
> > amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent
> > <Kent.Russell@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Kent
> > Russell
> > > Sent: Thursday, January 22, 2026 11:25 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent
> > > <Kent.Russell@amd.com>
> > > Subject: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
> > >
> > > Some older builds weren't sending RMA CPERs when the bad page
> > > threshold was exceeded. Newer builds have resolved this, but there
> > > could be systems out there with bad page numbers higher than the
> > > threshold, that haven't sent out an RMA CPER. To be thorough and
> > > safe, send an RMA CPER when we load the table, if
> > the
> > > threshold is met or exceeded, instead of waiting for the next UE to
> > > trigger the
> > CPER.
> > >
> > > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > index 64dd7a81bff5..469d04a39d7d 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > @@ -1712,6 +1712,10 @@ int amdgpu_ras_eeprom_check(struct
> > > amdgpu_ras_eeprom_control *control)
> > >                       dev_warn(adev->dev, "RAS records:%u exceeds
> > > 90%% of threshold:%d",
> > >                                       control->ras_num_bad_pages,
> > >                                       ras->bad_page_cnt_threshold);
> > > +             if (amdgpu_bad_page_threshold !=3D 0 &&
> > > +                     control->ras_num_bad_pages >=3D ras-
> > > >bad_page_cnt_threshold)
> > > +                     amdgpu_dpm_send_rma_reason(adev);
> > > +
> >
> > [Tao]: 1. Better to add comment to describe this special case;
> >
> > 2. Do we need to trigger in-band cper as well? Like:
> >
> > if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
> >     amdgpu_cper_generate_bp_threshold_record(adev))
> >         dev_warn(adev->dev, "fail to generate bad page threshold cper
> > records\n");
> >
> > >       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
> > >                  amdgpu_bad_page_threshold !=3D 0) {
> > >               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> > > --
> > > 2.43.0
> >
>

