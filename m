Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455C2C54754
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 07:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F6010E9B8;
	Fri, 16 May 2025 07:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b0t/xzSf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357DE10E9BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 07:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvyJuNngZDCJA5QEqrFFVpT5uklaHhineKmo5JAhfUKpVbLCYYbjRe0QLEz4grFav1MKllRr2o6W/vopqj9dgWGT4DrdD/zb030DqWRHtDi8mv5R0f1idjcRgkG03GPAoGJRZKkjh+Sjiv40uQOSYyMuyiI4hYhW7O+C8tWXFwO3hWtCTF57aiXjNILjHtH1ZXe3QsC5kSCANiQTMVRLhz4LmXY1MXukWSLEDaKKZ7GQieVwOQC8s+t1woxyS0bCGyOzYcZ5hxTFaeATBFSeYJXQKEN1lb5v4Fqp9lghRH30Sf+FEDkO2OvyYJ7eAK058ERM8z+2k0elzfVX9Mqzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZGhQZBMOR+nAdXGaNc4Tvw0yrJPWvfFQrcwarMFrOc=;
 b=RHE7GHY3+RWIEy002KTRGnxhAmbTLtlWRdFjafcyB/DP7pC8On6co7lWANwHYnPndt3ARuAOMO4Y+M+lBHuE62GfieVqFomsm7IsbpOgUrb2qBDG4ByqYpqQD6noqJOsM8gs5gOFdEpFC/gFH8LPPrlRE1g0bM2abxoVopdncT5z+UvAhRnMa6wqm9/zNjUgxuSlhIcqN6pOVMWJXWOavUpTnBIaqDLnAYZmREjSpZ4L/1xnrUbkD1hWKMGUOn2YOW3l86nLqSNqTBJ2GhRptqvOic4EL38ZhUT8vgnGc1GG24OE7TY9kiGARM8MVzwKTxwdLAFbs1GJs0noOe2cMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZGhQZBMOR+nAdXGaNc4Tvw0yrJPWvfFQrcwarMFrOc=;
 b=b0t/xzSfsNrqT9Q9ufbbEkEaH9F8+81mqqcgHd9XiPVEnoubsQiSkKriJTODwckwy+32+rSkpbOnO4ZAbduwCM7g4MI6ul2pZwO8+Re5EX6JUTE3LvJDbga1QgFrhwfrJphAXXjspbypD2Gim0dYN85Wqf3RXNvNexkCdrO/riA=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.32; Fri, 16 May 2025 07:03:37 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 07:03:37 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Ma, Qing (Mark)" <Qing.Ma@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH v5 0/4] enable xgmi node migration support for hibernate
 on SRIOV.
Thread-Topic: [PATCH v5 0/4] enable xgmi node migration support for hibernate
 on SRIOV.
Thread-Index: AQHbwwj/r1d0VC5BzEW3glLkkTK9/bPR6fyAgALi770=
Date: Fri, 16 May 2025 07:03:30 +0000
Message-ID: <DM4PR12MB5937CD06BEDDC3AD5D43F442E593A@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250512064141.387079-1-guoqing.zhang@amd.com>
 <IA1PR12MB84051BD5EE2F63AB227C6F01A891A@IA1PR12MB8405.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB84051BD5EE2F63AB227C6F01A891A@IA1PR12MB8405.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-14T10:05:21.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|PH7PR12MB7967:EE_
x-ms-office365-filtering-correlation-id: 6ee8a223-a237-422c-0ce1-08dd9447c7b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?RITOLJ2+SAb0PqcER/9OjB2v/tKseSEZRaNN09CdjAo3I6HkDILk2IIE?=
 =?Windows-1252?Q?eWPO1/XC9Cizk4/aDRiBRgEGTokma/FL5lx/+veEPgHqVQW6E7B5zpDG?=
 =?Windows-1252?Q?MxlxIxfa9LFlKpCk2Nte7bySB+nuIY9gf1tWkqRQKEpWudDPmAQYgsTB?=
 =?Windows-1252?Q?Ojcln/KfHNSioxG4nSqEdCFcJ7jEWp7/wpZbNVOur+JWZVfAOXFShf0F?=
 =?Windows-1252?Q?EK7cOATQihGA4bAF3CDkysOd3XrC/OTVl8bAt9QXN7y8LI6pwdJpqwS6?=
 =?Windows-1252?Q?TqLbtHb9D7MJbmlvtp6ux4p19A9QSmbdACfGjNltHTkRJpwVTFFVrFfS?=
 =?Windows-1252?Q?+Je2L2PsGVNz0rjZUEt7f44Fsooi6J322maLUq3mIK95KnoaOd0gdkrj?=
 =?Windows-1252?Q?A8gaNsCfhLj8WPAFAArUvoHskZQYykbGTGXjPdkdYZhb6v5GtJtnUFPS?=
 =?Windows-1252?Q?u/5QAuUikLg45H1PEY62Vt+LITCLbhXpe4BDdID4kxBW7Y55sVd47xZN?=
 =?Windows-1252?Q?plhvgJHBwBAe2PFQ3mVS3NEpa2wsuQUVU74epdRrZqNDuggr+4/dDMyC?=
 =?Windows-1252?Q?NbI5m2VpDOLDQqiIQr0Vk0J0iu1G20PbfegUZ4vKDyXHGcABlM1swxgN?=
 =?Windows-1252?Q?JLo2QtcjQXT43xZQIKWzVIMPbwrhYUaYa4u+Hsa3Jk2Qu0uYxU0WTG9s?=
 =?Windows-1252?Q?3SQIPJOZ5quXn59YEGSTjwiWBOb8YESDkguErq6kSNzVfglrUSRas6c+?=
 =?Windows-1252?Q?/RoVqJxhCK1BpyCxmD58B1o4xeOB6jLqCbZRU6osMI7mfYZH+nIWzZvu?=
 =?Windows-1252?Q?h1UKxxajmQDTs2b7rfdBeARSRhujqVBhfX+vdVu2j1walHk6N6iN/wkI?=
 =?Windows-1252?Q?5s1tDVdIS7MBjCs7EmRnIQCI35cQuVHbcS1Qt6y0v0ZD3O/9JFd5CCip?=
 =?Windows-1252?Q?pSW/J7RkUmobv/q+Y5gdhQZPIRx3+tPDvpj2Pt7/C0VcDYKc69RNynJw?=
 =?Windows-1252?Q?FiTUzxX8Unpt+5sHlo7SC8kAi7KFlBb1+nkRVnfnh7vWeVV6kBTJpDhd?=
 =?Windows-1252?Q?cINfcB7BRdtl9DEThAW+/8X5Rka0EtA0EoKOJGnoLgWVokUe5JtjH+DD?=
 =?Windows-1252?Q?cQuTGPvK3X/7E+DuPThkkzWKKANqUcaBniOqJ9Nr6pq+R8fUUni2+apW?=
 =?Windows-1252?Q?NO4FKu7qYjbiHeErd96xAjEUJV7fpYpDspfmbOBesmt2KRvl8XztSPxF?=
 =?Windows-1252?Q?DBEtptrfJXqk52s4x+HvPqRGv+Anp9Vds4OkfpVi/XBe7Hy0H4l1ADYm?=
 =?Windows-1252?Q?jLNWM8KGkimRvvnQmltaZiH1Fz1Nwk9bS+ycJYsx3qDrR7MI2mTBu9aX?=
 =?Windows-1252?Q?28GiCrOkQDEkRHUvR9+DVXXhFaZVDXOmr07XFZjEOnGo046KDIJsEbev?=
 =?Windows-1252?Q?f5tXNDPY1SkjUdAXHqxV+I/EU/li3qgHR7jfIMgkUF8wdp9Td+2CjmRL?=
 =?Windows-1252?Q?0M6Ze00DOat7IndvphBSiCXXJCOkRYCqRAV/Hy3coomfAQFIgwDjfUeo?=
 =?Windows-1252?Q?xlCh8uGfqytvQ3uA2I+kk4ZmI2mZaMr8p0n4Pw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?9VKpJQUo544BNNXszFXDib08cPcOTwVHkItyHqTQlubI0LidirRQC9v0?=
 =?Windows-1252?Q?CHHa3MdRBAXzM59kc/HrJpIzB4CBXZRcyaSz+Xldxm5ll/hlPCNk7DGq?=
 =?Windows-1252?Q?D65/jtdUZjkk9ld/miqORwP+vBDQDR3bNSRwTkRCOVv9U/LqshKsM9gx?=
 =?Windows-1252?Q?XzP8VNFPqjitkZ7DSGam71Xsraa4BN8g0mp70tRYptDDvPdWVEh+GXWN?=
 =?Windows-1252?Q?sB/JXc+YpUgiNGDoXpFRGu1j44yuB184ipJCmts5jOmuWfqIGw/Rm8GK?=
 =?Windows-1252?Q?FKrCmbNNuXWy3ar4iVkP6rLdAs6QGoOYBLBE9W+VgSLt/s7dpAD4znns?=
 =?Windows-1252?Q?n+MySLJReSZpXK0vlmKOUTtZwXQ2D5tbnqqbNIQK59Z+cc6etekdKb8o?=
 =?Windows-1252?Q?g55Wy5iQV3lPOo0iv69gYuXbS36evxa7JpEkvPW8dxypBI/OKCUm3FkA?=
 =?Windows-1252?Q?ugEjvX7Pw9TGinuZVpPOHRPszErvsLLvyf2ur96/vJNnWIsUL2BFPTFu?=
 =?Windows-1252?Q?nF2XkuM33qdNW6Ve1vHcnwE0z4BVcw+u4biafkCWXY1/di9wYc45t05i?=
 =?Windows-1252?Q?N9fN9MQZNO0XH6kQlM1312kZ6lMYaUHFpT78emwGK9enZZrHftEzMiBj?=
 =?Windows-1252?Q?m/XlnF9M9BySirDJL+IE/bJAo8tG/7jsbEkHXsM+tKCZoDS3bQT5HvMU?=
 =?Windows-1252?Q?viMonG3Ijw5dyjoYle3uweA+kam4TLQ9/1kLzpv/wRYwhoqPLQeNfaJr?=
 =?Windows-1252?Q?yY6eHQrfTRKEt/Jg9LWP0m+GGHPpRdi17oQPYtZopzs0tbQB0k4GPwdh?=
 =?Windows-1252?Q?DLNjGDpJ+dzYzgVCOKm68kO7hxM/yq/96MwqnMj+qnl23oM5q+CCp1pw?=
 =?Windows-1252?Q?ARVGV/XoLREgAtMXHxAENnJ3YaZodPtUDOV8x7spIqY1p+gt8PLrSWVN?=
 =?Windows-1252?Q?EVjI/l928u7UyPAc0nBeLTI5UXFB/gmtJZDrmZaur/mgW7F5td7b2Szf?=
 =?Windows-1252?Q?QNRd49xj+VwBsnWsJPxWh4Piv2ja7CMNNAovR5S+5DFdGWvTt3nakmXW?=
 =?Windows-1252?Q?m0zwnYjXCxHMW1g8Txd7YmPGZbGmlpLZK/TXGZxVreKMm7nWsPicfZ9/?=
 =?Windows-1252?Q?Zz7tcAbcafXccdnI4/eHbYykskTjp5u2+tIR7UwxRQKLw7iZN09JmGDw?=
 =?Windows-1252?Q?yE5EJsuit/LOXcwSCzPInypX9dGELZBAm02yVIznCz2gJ1+TpdxzZAOi?=
 =?Windows-1252?Q?zMMUZmkiLxOdVPi/vxFNF0zTgGjNoVE1x5JFHG0tHXhNHOtTFjDlPZQ2?=
 =?Windows-1252?Q?LXpexU7tjwRpajnq2pZfU0NGbZcrdrz7bMtT8iDwYiW5fwRAu4RGQyA4?=
 =?Windows-1252?Q?IrwgkFh0ZGYkAnxkG09G60bVyhdduRhmabwqC5QugSzu66saFKxhZ6tg?=
 =?Windows-1252?Q?n+hohNjOl8l0rmkb++MWBm4QGeHuJDUE5O/QSz5+PVx70w0DsfFFZaG4?=
 =?Windows-1252?Q?gnaCkpjpX4rCoUEAs2tfYS7D3mKdlC9B23d/ftjONVsASHDBz1PsSsPK?=
 =?Windows-1252?Q?go53UA9CgqSeAxYTIFfmI/jd6r8oCGH8TAgq2am7H/3zI79jJ1chvNKi?=
 =?Windows-1252?Q?VvE7P8ExapVzLV4UAgTQk9M9t5fMeHVPvDhEYylNG7JhnMI2uLZy373K?=
 =?Windows-1252?Q?+2+fNpOOquM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5937CD06BEDDC3AD5D43F442E593ADM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee8a223-a237-422c-0ce1-08dd9447c7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 07:03:37.0609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwkqjIP6tVoGSJDYt0qpVdqXPKIqUb20pEFeUA91NqwyNmqajf8zRqs94COLH10MwbFNlg5X76RtHgbHp5op7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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

--_000_DM4PR12MB5937CD06BEDDC3AD5D43F442E593ADM4PR12MB5937namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Koenig, Christian<mailto:Christian.Koenig@amd.com> and @Lazar, Lijo<mai=
lto:Lijo.Lazar@amd.com>,

Ping=85

Thanks
Sam

From: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
Date: Wednesday, May 14, 2025 at 18:07
To: Koenig, Christian <Christian.Koenig@amd.com>, Zhang, GuoQing (Sam) <Guo=
Qing.Zhang@amd.com>, amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedeskt=
op.org>, Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, Deucher, Alexander <Alexan=
der.Deucher@amd.com>, Ma, Qing (Mark) <Qing.Ma@amd.com>
Subject: RE: [PATCH v5 0/4] enable xgmi node migration support for hibernat=
e on SRIOV.
[AMD Official Use Only - AMD Internal Distribution Only]

Hi, @Koenig, Christian @Lazar, Lijo kindly pls provide your expertise for t=
he Sam's update below. Thanks for your support.


Rgds/Owen

-----Original Message-----
From: Samuel Zhang <guoqing.zhang@amd.com>
Sent: Monday, May 12, 2025 2:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>; Koenig, Christian <Christi=
an.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, =
Owen(SRDC) <Owen.Zhang2@amd.com>; Ma, Qing (Mark) <Qing.Ma@amd.com>
Subject: [PATCH v5 0/4] enable xgmi node migration support for hibernate on=
 SRIOV.

On SRIOV and VM environment, customer may need to switch to new vGPU indexe=
s after hibernate and then resume the VM. For GPUs with XGMI, `vram_start` =
will change in this case, the FB aperture gpu address of VRAM BOs will also=
 change.
These gpu addresses need to be updated when resume. But these addresses are=
 all over the KMD codebase, updating each of them is error-prone and not ac=
ceptable.

The solution is to use pdb0 page table to cover both vram and gart memory a=
nd use pdb0 virtual gpu address instead. When gpu indexes change, the virtu=
al gpu address won't change.

For psp and smu, pdb0's gpu address does not work, so the original FB apert=
ure gpu address is used instead. They need to be updated when resume with c=
hanged vGPUs.

v2:
- remove physical_node_id_changed
- set vram_start to 0 to switch cached gpu addr to gart aperture
- cleanup pdb0 patch
v3:
- remove gmc_v9_0_init_sw_mem_ranges() call
- remove vram_offset memeber
- add 4 refactoring patch to remove cached gpu addr
- cleanup pdb0 patch
v4:
- remove gmc_v9_0_mc_init() call and `refresh` update.
- do not set `fb_start` in mmhub_v1_8_get_fb_location() when pdb0 enabled.
v5:
- add amdgpu_virt_xgmi_migrate_enabled() check
- move vram_base_offset update to pdb0 patch
- remove 4 refactoring patches to remove cached gpu addr
- add patch to fix IH not working issue when resume with new VF

Samuel Zhang (4):
  drm/amdgpu: update xgmi info on resume
  drm/amdgpu: update GPU addresses for SMU and PSP
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: fix fence fallback timer expired error

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 32 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++++  drivers/gp=
u/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 27 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 16 ++++++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c     |  4 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 ++++++++++++
 15 files changed, 152 insertions(+), 15 deletions(-)

--
2.43.5

--_000_DM4PR12MB5937CD06BEDDC3AD5D43F442E593ADM4PR12MB5937namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
<a id=3D"OWAAM9777098A1C45D44DAAA7EEFF1F8C6305" href=3D"mailto:Christian.Ko=
enig@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a> and
<a id=3D"OWAAMF184118DAD54A4429B35D20D9CFA1F2D" href=3D"mailto:Lijo.Lazar@a=
md.com"><span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decora=
tion:none">@Lazar, Lijo</span></a>,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Ping=85<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Zhang, Owen(SRDC) &lt;Owen.Zhang2@amd.com&gt;<br>
<b>Date: </b>Wednesday, May 14, 2025 at 18:07<br>
<b>To: </b>Koenig, Christian &lt;Christian.Koenig@amd.com&gt;, Zhang, GuoQi=
ng (Sam) &lt;GuoQing.Zhang@amd.com&gt;, amd-gfx@lists.freedesktop.org &lt;a=
md-gfx@lists.freedesktop.org&gt;, Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br=
>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, D=
eucher, Alexander &lt;Alexander.Deucher@amd.com&gt;, Ma, Qing (Mark) &lt;Qi=
ng.Ma@amd.com&gt;<br>
<b>Subject: </b>RE: [PATCH v5 0/4] enable xgmi node migration support for h=
ibernate on SRIOV.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-family:&quot;Times New Roman&quot;,serif">[AMD Offi=
cial Use Only - AMD Internal Distribution Only]<br>
<br>
Hi, @Koenig, Christian @Lazar, Lijo kindly pls provide your expertise for t=
he Sam's update below. Thanks for your support.<br>
<br>
<br>
Rgds/Owen<br>
<br>
-----Original Message-----<br>
From: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
Sent: Monday, May 12, 2025 2:42 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhao, Victor &lt;Victor.Zhao@amd.com&gt;; Chang, HaiJun &lt;HaiJun.Chan=
g@amd.com&gt;; Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;; Koenig, =
Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexande=
r.Deucher@amd.com&gt;; Zhang, Owen(SRDC) &lt;Owen.Zhang2@amd.com&gt;;
 Ma, Qing (Mark) &lt;Qing.Ma@amd.com&gt;<br>
Subject: [PATCH v5 0/4] enable xgmi node migration support for hibernate on=
 SRIOV.<br>
<br>
On SRIOV and VM environment, customer may need to switch to new vGPU indexe=
s after hibernate and then resume the VM. For GPUs with XGMI, `vram_start` =
will change in this case, the FB aperture gpu address of VRAM BOs will also=
 change.<br>
These gpu addresses need to be updated when resume. But these addresses are=
 all over the KMD codebase, updating each of them is error-prone and not ac=
ceptable.<br>
<br>
The solution is to use pdb0 page table to cover both vram and gart memory a=
nd use pdb0 virtual gpu address instead. When gpu indexes change, the virtu=
al gpu address won't change.<br>
<br>
For psp and smu, pdb0's gpu address does not work, so the original FB apert=
ure gpu address is used instead. They need to be updated when resume with c=
hanged vGPUs.<br>
<br>
v2:<br>
- remove physical_node_id_changed<br>
- set vram_start to 0 to switch cached gpu addr to gart aperture<br>
- cleanup pdb0 patch<br>
v3:<br>
- remove gmc_v9_0_init_sw_mem_ranges() call<br>
- remove vram_offset memeber<br>
- add 4 refactoring patch to remove cached gpu addr<br>
- cleanup pdb0 patch<br>
v4:<br>
- remove gmc_v9_0_mc_init() call and `refresh` update.<br>
- do not set `fb_start` in mmhub_v1_8_get_fb_location() when pdb0 enabled.<=
br>
v5:<br>
- add amdgpu_virt_xgmi_migrate_enabled() check<br>
- move vram_base_offset update to pdb0 patch<br>
- remove 4 refactoring patches to remove cached gpu addr<br>
- add patch to fix IH not working issue when resume with new VF<br>
<br>
Samuel Zhang (4):<br>
&nbsp; drm/amdgpu: update xgmi info on resume<br>
&nbsp; drm/amdgpu: update GPU addresses for SMU and PSP<br>
&nbsp; drm/amdgpu: enable pdb0 for hibernation on SRIOV<br>
&nbsp; drm/amdgpu: fix fence fallback timer expired error<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++<br=
>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; | 32 ++++++=
+++++++++++-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 +=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++++&nbsp; =
drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp; | 27 ++++++=
++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c&nbsp; |&nbsp; 3 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h&nbsp;&nbsp; |&nbsp; 7 +++++<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 16 ++++++++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c&nbsp;&nbsp;&nbsp; |&nbsp; 6 +=
+--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega20_ih.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp=
; 4 +++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp; | 18 ++++++++++++<br>
&nbsp;15 files changed, 152 insertions(+), 15 deletions(-)<br>
<br>
--<br>
2.43.5</span><span style=3D"font-size:12.0pt;font-family:&quot;Times New Ro=
man&quot;,serif"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5937CD06BEDDC3AD5D43F442E593ADM4PR12MB5937namp_--
