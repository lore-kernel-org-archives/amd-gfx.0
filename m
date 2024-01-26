Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C62C47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 21:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E3A10FE9E;
	Fri, 26 Jan 2024 21:28:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F18F10FEA1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 21:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNETfDh7JIpIBaZCiUoEYbaMl0SxikAGKbKQCONoGh+zdIjOC3j5b5XNJiBeOcDP5zMTYLOc7UE6tpTS1judKw2j9ixtK7WJ3oYdv4P4VqtGiNHOCvxadRgRf++XZQSyAoZh1+5Z+xqUv5CejRze3i2NEdSfsKuXmz1dUaBrmjHF0mCm2qMDh+NBejXlFn3hiEZlqcUUPz0WewOyN8xzdp2jZjxg4mybCZzgGprL2QDdRI/ZNyibACFX+V8LPFsaZxvAsjbZeH1/DL0ClMgkW7Y25graXHYsjWT7psyoIVZeM3SqUvqPUN5ls6aG+9FeXu7Faa3k0jpU6umP9VTcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho2TqqIistePZAuoCUyu1ZaWROTOo2qePyA/WKdmekg=;
 b=PBdOyMfnrGemlJKGi9PIAohw4P4/7ftw6sY4Jejg3sWKbIH0lJy/QFHc/9n79p5RNHDk1hnPfCnnkRmpLT81oylnMgN88+m7l1ZUpGRvP+uyb8JDkGLI6lkg/745r2hez3WNrRivdAW2LWq55bP0d6bi4HjPZtLDWQL0ggs3xSWdo66TRMKmqjbPkoXY4rzxldL77IFS90LtedNMk+8mxuynQrNal0ZmCeroLri1Tg9lWayzfsMk3SSZ8HONDvVw5FrlY/26CMlAv7oB213OvTXef+EooPcavMKEBM9zCcZE5XQszkLDPvsnUVERUgPz4G3AmTUA5ijELfxO8Fh9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho2TqqIistePZAuoCUyu1ZaWROTOo2qePyA/WKdmekg=;
 b=JaxOcKB+6d8t1+fU+JZF9ygPLUHWOdp4D+WVMrAicbfZeODLHca6BgMfpRFKI7mI21CorUxRi4uNcgC63QXu402n2sExvN/QZEAEr6eA6cXoyouYwMxQAkEeEbBRafhIj+cfHp7aeo0UhgcBVEwSRhlyogvmzMPqdDCGS9p7M7Q=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 21:28:43 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 21:28:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: William Bulley <web@umich.edu>
Subject: RE: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Thread-Topic: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Thread-Index: AQHaUJ1OZYcEvwofgkGwj3U/KXoO+bDsm64w
Date: Fri, 26 Jan 2024 21:28:43 +0000
Message-ID: <BL1PR12MB5144E836CDEB055FA3F7AD97F7792@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240126211902.GF660@dell4>
In-Reply-To: <20240126211902.GF660@dell4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=92d03a2d-ae67-47e1-a801-03690125ce9b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-26T21:27:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8903:EE_
x-ms-office365-filtering-correlation-id: ebd94d90-2f41-40fa-044a-08dc1eb5c5f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xQhpN0ut8Rb9eWzmdFZzA9XGKi+QmNc8Mu3+NryP/w3SS7vLGvTHcDJNBkIGBJdgZUS/kAij4km1JoaeXjGqE0rejcRKQVD2N09cCYU0xSmMY/KYGNZmx2BzUvmUGYN87vOMSNDQzAdqGsqZXqRdO1a9got3xrTuJb033e+O9+RnPo8JtyKCBN3pOe9akZvILEaQtVhZ3fFxtWCyJm7QI0kEsjjJtUeWToAmcl/gL2fVDWSujmw1mrj2WUYbtB8AfaKCmjpp4JgBOl7Kmw9o1DdfYeGIou3Knnt9QQdSXkign3CXJxDjqfvMUfdG2DFUU1cz8dhQwC2GSason8uTx+/qkqW0k0T7ho4CLkP/EZq25gAAGYmep2ny5mMpFHMDrWn2QZS1LFyD+uZUOXhfI09zP8LfCRT0ub9utNwWhFwHKA1O4yrlgtiTFU1wXrBwgSPWl1LmrdMvkzm96tadNE3rNOy3sxo4MAP1rMg73hwOMdEgwHgkRpTQ2WR0kqjg9LVxhiFwWPaX3zhV+BVeaTM/pXbrv1rTljQtTEJLeugmNDJlwW3bpZVZ2GGA0LcrxDrRLWEznSssyHt1/T88z8dRUl9TnGmFW1R9Kyvd4nKqeUqcgAzsoFWGJVCeT5PJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(478600001)(41300700001)(83380400001)(4326008)(52536014)(9686003)(66556008)(38100700002)(122000001)(71200400001)(8676002)(26005)(53546011)(5660300002)(64756008)(6916009)(2906002)(66946007)(66476007)(8936002)(76116006)(6506007)(66446008)(316002)(7696005)(38070700009)(33656002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1pT61VnPkcSk21An14jkkAduEmygF13vhodx0t1PK1WxfJTOiuZFzuPneJBM?=
 =?us-ascii?Q?kEl1a/1kfIzvc47nNT1mlilB3OcqQpvfYzUot9Np2DzujE8XbXhxVxLjYgZT?=
 =?us-ascii?Q?vlmLQ1BLOzmvfbiMdr3Qo4dAGyDhia6vbTJrGPkhSS9X0CLJAXz4of+ikT4Y?=
 =?us-ascii?Q?mWvGQAhZgjOHWs0wnHKKNxmt0xHAAyxymNMidMb1GMBVm84aUkwn3LT8UzOz?=
 =?us-ascii?Q?ULt3Tc6MCz/3jWmTUz197EoPLoeHXTiw7gjGvoVBiUnChE0dj2o8uVQvcsGD?=
 =?us-ascii?Q?BQemsPcSDbcDn8VvHwLogCu3w9h+FJi/k2Z5QQ7gTE0y0/aUUowhDukivttQ?=
 =?us-ascii?Q?uxlYxnKSHRVng2iHbIpjVJQFFiBSaPylo7L3kMfMfl2frjIPj/md+XEPjvGs?=
 =?us-ascii?Q?ON6SbzyHDIcFuDSU+FweiAMthyEVmhOsI4F5vprxgHLuoNjVIBBgfiFwwd1C?=
 =?us-ascii?Q?D168amYMyFUhkrr024pTX0Xfsa2PqB4Ib6U/rw9YoNz9N4jm4FRQHqojIFBg?=
 =?us-ascii?Q?Ag8ZDDsP1v+WHjllSD/5/iaY3sTnyMc56T1fBPbJ9cSdv/yX54Jh6jNXPYHa?=
 =?us-ascii?Q?K9F35hYDBB/ruwN+20N4gVC6pxaIbd3fRmuRxpde7k9gfnO0rE4ndWIgeHGa?=
 =?us-ascii?Q?hMmW/oFhP9rowjDGXTTQYwbhUEktG1sOnCzsmJWhaLzMziaOEAQvRbscFKVc?=
 =?us-ascii?Q?E54WRizvCLFFtjexKrX02vlbviSVtMcuxJ0f4GZ5lxBhxrbV6Snlx57qhtY5?=
 =?us-ascii?Q?62bGYR19K7qhQEHtIwF2lgezBuwlymaU1JdQ5eEp24H4TwRpXLj2gQvBhCc2?=
 =?us-ascii?Q?Eo3u2wTkz8J8uOXf0OVznW+FIQtQGsdrWAaUkm23cmBCjazSD1gkpSniKnXD?=
 =?us-ascii?Q?KdL1hXLErxZOgLU5FbjkMb7SoRGWdpUgkXR+xrrA/QORSZiivfADFwMteWbu?=
 =?us-ascii?Q?lEAduzeNazjmxNdDdXaINaWF06aK/7d2UOOm9FsLAKWPtQq5Zs01Ht4mRR2D?=
 =?us-ascii?Q?m8jQGjv10dTFfw6K90Cc80sMpCiZe2KgumUTr/48hP1iBxC5wqvvXnf+oCyb?=
 =?us-ascii?Q?Ml4LosOiiLQkDMcS8k2xisgwAKNLtK3UkLqTikDmkZkhUfJwUnKjz27pUkEl?=
 =?us-ascii?Q?GSdvGI9OtSoW2crN3arouYY8/QuA/moUcY2Q4k5vUiE487izYAUqtBB9xkOX?=
 =?us-ascii?Q?Eqnc00sHNJzMe04YxKSPOttI8U6+fzkRNtJLfufgMFKlZrNkXAiAAYOuo4sq?=
 =?us-ascii?Q?4wp3GgFnZfOlTqXujWcUL5vyn/U4YsPn5EpcSTR24E7f1FasjXWouNsXTB87?=
 =?us-ascii?Q?1gftuzwDbdNvaTJ40g1Er/Y0/XnrNF+WB76ik+k8SY8H650+7Wp9Rb/DA+mq?=
 =?us-ascii?Q?k2jivxvnbkZfc3zQzEBOhdOqg77dVRqKY/YCCBX6I6TV6DgrOSl5pzS2I7S0?=
 =?us-ascii?Q?FIMISIef1rsLwXzmyTzuKDR8pkALfGpUMFO6zfeoxyR+C6t4Cc3N45tK+kln?=
 =?us-ascii?Q?1Qj5dgLfSGSpkTrhfrUnrAE+xrjFHouemfUMK8bF8xgZGQvI8bqmO7HlmY3z?=
 =?us-ascii?Q?NIYeA8lKefgpzUqRokI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd94d90-2f41-40fa-044a-08dc1eb5c5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 21:28:43.8462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYJqQhR+m6h+gt3J+l+R6kg5EWZk72YYRfjhHgMueFWKXHxCDVVBu9km2Z+naF9EsfpdsyaSh8moSEX9fS4QEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: William Bulley <web@umich.edu>
> Sent: Friday, January 26, 2024 4:19 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: Have WX 3200 Radeon graphics card -- cannot get X11 session =
to
> work
>
> According to "Deucher, Alexander" <Alexander.Deucher@amd.com> on Fri,
> 01/26/24 at 15:50:
> >
> > [Public]
> >
> > Kernel driver looks like its loaded properly.
> >
> > I don't really have much experience with freebsd, but it doesn't seem
> > to be able to open the kernel driver.  Perhaps X starts before the
> > kernel driver has finished loading?  Can you try and load the kernel dr=
iver and
> then start X?
>
> After sending this and researching the forums some more, I made a few
> changes and have had some success, but not quite there yet...
>
> Using what I found in the forums I now have this one file in my
> /usr/local/etc/X11/xorg.conf.d directory:
>
> unix% cat /usr/local/etc/X11/xorg.conf.d/10-driver.conf
> Section "Device"
>         Identifier      "Card0"
>         Driver          "amdgpu"
>         BusID           "PCI:41:0:0"
> EndSection
>
> I got to this point today after learning about this the other day:
>
> unix# pciconf -lv | grep -A4 vgapci
> vgapci0@pci0:41:0:0:    class=3D0x030000 rev=3D0x10 hdr=3D0x00 vendor=3D0=
x1002
> device=3D0x6981 subvendor=3D0x1002 subdevice=3D0x0b0d
>     vendor     =3D 'Advanced Micro Devices, Inc. [AMD/ATI]'
>     device     =3D 'Lexa XT [Radeon PRO WX 3200]'
>     class      =3D display
>     subclass   =3D VGA
>
> I am not loading any relevant modules in my /boot/loader.conf file.
>
> This line was added to my /etc/rc.conf file:
>
>    kld_list=3D"amdgpu"
>
> I felt the amdgpu driver would support my WX 3200 (RS780) graphics card,
> and after a reboot, I was proved correct.  Previously I was starting my
> x11 session using the "startx" command from the vt0 virtual terminal.
>
> Just minutes ago I logged into the virtual terminal vt2 on this system as=
 a non-
> root user.  There I entered the "startx" command and I was completly
> surprised by the beautiful x11 session that appeared!!!
>
> Unfortunately, the mouse pointer is frozen at the exact center of the
> 3440 x 1440 monitor, and it will not move.  I don't know how to fix this.=
  Any
> help or ideas or suggestions would be greatly appreciated.

Make sure you have OS mouse and keyboard drivers loaded and configured with=
in your X config?

Alex

