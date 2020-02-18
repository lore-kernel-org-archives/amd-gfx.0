Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0360CC3403D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAADC208C4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KvFHpasC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAADC208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79CBA6EA1F;
	Tue, 18 Feb 2020 14:43:30 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690058.outbound.protection.outlook.com [40.107.69.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CF166EA1F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 14:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzX03JvGIhUk/IlqbnWtPgK2AUPrLeKmqNZOiEzzPB9NOnossdSAVibU2/tvcSgOZ1eP1Jmnoa2LS/PlfqWnvcqzMYityKtqvaahDBtH6f+RWcwQXpPIKU42cE0oIN1qz+z8j9d2+eaqWgPQpQSO+XyxhuyLpQRwefAsJ8Mkq5YUuoD9Dm76AQjInj7k4jaAbp6GMu6Gq7/54W1ezD6nNHEGPEPNdqpJIg1brxCLeEOWa0g8K68GO3Ixzwpc1rC87ksoU1h0+kilEIR4XND/xhCj4Ie6bjNUYG88eFv3MRgE7+/32olXWswWWbvBPzj3FscndffzEtqO8YvMk/cuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4Cs+fCv6GTXjdjOjEMugYrFg5u67xJ/EUvwgGPeX4U=;
 b=Ec9Y4HLGtm9V/beqJU8hBVXuqkkCNLFhe8oQgPMD9CeY7qchlfwynmSPXxobqweg6b714r8gL7XSWhaVYICFyvr2Zyk/elWP6VrSF4KwUJil1YG8dtCCErK8q03BBn177tjqN1nhEao7f9Oc1s5I5esdm+TiNZaTYF1QOzDAfGVcMZyc1eeA0K/ZvvWrp15vBOdqCxOvKRJISavikLUEsKfQoDWRWVnIeT2Q3pHCPBJ78Wle06icQ8YjTuUEhZFgkqLHv3XSpMrd46ylw8IIxDV6y/ddnHiMgChpeB9wbvTHJKC7T+NlFtZF99oY1Yz+d9MKoMjJ4T7uYNAgz2tO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4Cs+fCv6GTXjdjOjEMugYrFg5u67xJ/EUvwgGPeX4U=;
 b=KvFHpasCPWdAGIHblrXFW13hHeQn7kQ3yXt6j6ncazFndBQ7BISjQjiI52ctcro3xvWRp+cWFyYdadDxOqcyuwV65rPOmBNmPwzfjG01/y9NttANhjYQrbhAj/b97Yq+DBztuUGpoKR4jJ4YMBFFIGwAcP3vLgbMmvkJpE/CKe8=
Received: from DM6PR12MB3097.namprd12.prod.outlook.com (20.178.31.89) by
 DM6PR12MB4202.namprd12.prod.outlook.com (10.141.186.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 14:43:28 +0000
Received: from DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::c90d:ccf4:5717:9b46]) by DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::c90d:ccf4:5717:9b46%5]) with mapi id 15.20.2729.031; Tue, 18 Feb 2020
 14:43:27 +0000
From: "Bridgman, John" <John.Bridgman@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?iso-8859-3?Q?Yusuf_Alt=B9parmak?=
 <yusufalti1997@gmail.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: writing custom driver for VGA emulation ?
Thread-Topic: writing custom driver for VGA emulation ?
Thread-Index: AQHV5jEFFbMOyBOfOEaevdkKK6oZK6gg+GyAgAAC7gOAAAUNgIAABUTW
Date: Tue, 18 Feb 2020 14:43:27 +0000
Message-ID: <DM6PR12MB309715C009FB496F1D3B4B56E8110@DM6PR12MB3097.namprd12.prod.outlook.com>
References: <CAGzVRjzs8rgaLkWcaxdAn-DUf3Kk70TW=NPM+Hk9SLt7Tcjsfg@mail.gmail.com>
 <CADnq5_MutDzY0fdhX3anCQXFAOLkAbcMS3timfFEDFBqVc-jxA@mail.gmail.com>
 <DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110@DM6PR12MB3097.namprd12.prod.outlook.com>,
 <460d7881-2223-12f1-bc47-b48b851d1138@gmail.com>
In-Reply-To: <460d7881-2223-12f1-bc47-b48b851d1138@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-18T14:43:26.957Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Bridgman@amd.com; 
x-originating-ip: [72.139.204.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1739753-9734-4620-45bd-08d7b480ea83
x-ms-traffictypediagnostic: DM6PR12MB4202:|DM6PR12MB4202:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42022DD1657EFE5555357575E8110@DM6PR12MB4202.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(9686003)(5660300002)(55016002)(4326008)(52536014)(66574012)(86362001)(7696005)(6636002)(110136005)(53546011)(6506007)(33656002)(186003)(26005)(66476007)(64756008)(76116006)(81166006)(81156014)(8676002)(8936002)(45080400002)(966005)(66946007)(19627405001)(2906002)(498600001)(66446008)(71200400001)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4202;
 H:DM6PR12MB3097.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ND/1J9RQ2UhF0QRiysaz9RomIj2EhLTHQMYZLsI1WKbfSfjv9YLPkcvJlKtXX3kh9VK7S2L62gS51MCWnXBKU5gNm8/xRuhnry5Ll6HF5BzNdFNbMq2nT4w6uOc1USmhfGQ9AjkpCgXx8JLLfdmXGFp8QfA90co4ppYQRqCcp0yWazpKeZlwPVRx72J3O1egoYU+YLxWgXmhIjQohhMVpd34+cLyv7f/GIlZRvXQE8jqkfIt7gMnFLOgA1YMji6hC7bLNHU5+08UCY9xxbKwVhM+t35Ug+3avvHhQROivBxnQgIV5BFwjIdgPvUqrNHY5eyVsA6QhhARADWI4YwL79CHaC9dT318X1Ia0rWmFGhAIqFPYuT5p1mg3qiQrdMi5JHHVVHUmOFFqwOxZVOa1cJv7n2Kpm59aBSXOLg8tCXIeomSOTJ4cXJj1NfcZn2Cd0EXbP9i6rLUKZp9FfqzUx6sGN1w6sxc8Q48j7NiemRd6F9H/9A1AqwFZQCCTcqxwKL3jHJ00iykizZX7TTgnQ==
x-ms-exchange-antispam-messagedata: 5oV5xhID5OmgM5Dfj0Uy9WxJiFgn4Jz2cM89SBrEONPVDTAIH4BS2/iu61vo8fPIUpsmA4WGppmp5LTgS8qpE42lNJNpeqgY/s3QlacRB9v4cRY11dvJXpJAXi+vrEzUE8lBgA8obHO+GjABM82A5g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1739753-9734-4620-45bd-08d7b480ea83
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 14:43:27.7760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lS/2Ez85zIpJe3cGWAB+845zx9Y/eIGCIhXsMe2RK9z97fX5n2BkgBLlF9+wQfU1/2hzGd9bpCgk++sXdBhu1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1952406959=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1952406959==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB309715C009FB496F1D3B4B56E8110DM6PR12MB3097namp_"

--_000_DM6PR12MB309715C009FB496F1D3B4B56E8110DM6PR12MB3097namp_
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

>And we already checked, 256MB is unfortunately the minimum you can resize =
the VRAM BAR on the E9171 to.

Ahh, OK... I didn't realize we had already looked into that. I guess that a=
pproach isn't going to work.

Yusef, guessing you are using a 32-bit CPU ? Is it possible to talk to whoe=
ver does SBIOS for your platform to see if you could maybe reduce address s=
pace allocated to RAM and bump up the MMIO space ?

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: February 18, 2020 9:19 AM
To: Bridgman, John <John.Bridgman@amd.com>; Alex Deucher <alexdeucher@gmail=
.com>; Yusuf Alt=B9parmak <yusufalti1997@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: writing custom driver for VGA emulation ?

The problem Yusuf runs into is that his platform has multiple PCIe root hub=
s, but only 512MB of MMIO address space. That is not enough to fit all the =
BARs of an E9171 into.

But without the BARs neither the VGA emulation nor amdgpu not anything else=
 will work correctly.

And we already checked, 256MB is unfortunately the minimum you can resize t=
he VRAM BAR on the E9171 to.

What could maybe work is to trick the upstream bridge of the VGA device int=
o not routing all the addresses to the BARs and actually use only a smaller=
 portion of visible VRAM. But that would be highly experimental and require=
s a rather big hack into the PCI(e) subsystem in the Linux kernel.

Regards,
Christian.

Am 18.02.20 um 15:08 schrieb Bridgman, John:

[AMD Official Use Only - Internal Distribution Only]

Does the VBIOS come up with something like a splash screen, ie is VBIOS abl=
e to initialize and drive the card ?

If so then another option might be to use a VESA driver rather than VGA.


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Alex Deucher <alexdeucher@gmail.com><=
mailto:alexdeucher@gmail.com>
Sent: February 18, 2020 8:50 AM
To: Yusuf Alt=B9parmak <yusufalti1997@gmail.com><mailto:yusufalti1997@gmail=
.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freed=
esktop.org>
Subject: Re: writing custom driver for VGA emulation ?

On Tue, Feb 18, 2020 at 2:56 AM Yusuf Alt=B9parmak
<yusufalti1997@gmail.com><mailto:yusufalti1997@gmail.com> wrote:
>
> Hello AMD team;
>
> I have E 9171 GPU and want to use it on a embedded system which has limit=
ed MMIO space on PCIe bus (MAX 512 MB).
>
> I received feedbacks that I can only use VGA emulation with this memory s=
pace. I was unable to get 'amdgpu' driver working with Xorg due to I had ma=
ny errors(firmwares are not loading) in each step and tired of solving them=
 one by one.
>
> I want to write a simple custom driver for this GPU with kernel version 4=
.19.
> Is it possible to print some colors on screen with a custom driver over P=
CIe communication ? or writing some words on screen as VGA ?
>
> If answer is yes, then which code pieces (on amdgpu driver folder) or ref=
erence documentation should I use? I have Register Reference Guide.pdf.
>
> I will be appreciated for your guidance.

That is not going to do what you want on your platform.  The VGA
emulation requires that you set up the card first to enable it, which
in turn requires MMIO access and thus you are back to square one.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cjohn.bri=
dgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637176306561328560&amp;sdata=3DQbfaIN%2F6LvgUihz5O0x41=
TwvdGYy7QTS5IVJq3RXYlA%3D&amp;reserved=3D0<https://nam11.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flisti=
nfo%2Famd-gfx&data=3D02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e=
6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003=
958&sdata=3D6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&reserved=
=3D0>



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7CJohn.Bridgman%40amd.com%7Ccda546=
9b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637=
176323587003958&sdata=3D6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3=
D&reserved=3D0>



--_000_DM6PR12MB309715C009FB496F1D3B4B56E8110DM6PR12MB3097namp_
Content-Type: text/html; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
3">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&gt;And we already checked, 256MB is unfortunately the minimum you can resi=
ze the VRAM BAR on the E9171 to.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Ahh, OK... I didn't realize we had already looked into that. I guess that a=
pproach isn't going to work.
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yusef, guessing you are using a 32-bit CPU ? Is it possible to talk to whoe=
ver does SBIOS for your platform to see if you could maybe reduce address s=
pace allocated to RAM and bump up the MMIO space ?<br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Christian K=F6nig &=
lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> February 18, 2020 9:19 AM<br>
<b>To:</b> Bridgman, John &lt;John.Bridgman@amd.com&gt;; Alex Deucher &lt;a=
lexdeucher@gmail.com&gt;; Yusuf Alt=B9parmak &lt;yusufalti1997@gmail.com&gt=
;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: writing custom driver for VGA emulation ?</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">The problem Yusuf runs into is that his pl=
atform has multiple PCIe root hubs, but only 512MB of MMIO address space. T=
hat is not enough to fit all the BARs of an E9171 into.<br>
<br>
But without the BARs neither the VGA emulation nor amdgpu not anything else=
 will work correctly.<br>
<br>
And we already checked, 256MB is unfortunately the minimum you can resize t=
he VRAM BAR on the E9171 to.<br>
<br>
What could maybe work is to trick the upstream bridge of the VGA device int=
o not routing all the addresses to the BARs and actually use only a smaller=
 portion of visible VRAM. But that would be highly experimental and require=
s a rather big hack into the PCI(e)
 subsystem in the Linux kernel.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 18.02.20 um 15:08 schrieb Bridgman, John:<br>
</div>
<blockquote type=3D"cite">
<p style=3D"margin-top: 0px; margin-bottom: 0px;font-family:Arial; font-siz=
e:10pt; color:#0078D7; margin:15pt" align=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div>Does the VBIOS come up with something like a splash screen, ie is VBIO=
S able to initialize and drive the card ?<br>
</div>
<div><br>
</div>
<div>If so then another option might be to use a VESA driver rather than VG=
A. <br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on behalf of Alex Deucher=
 <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:alexdeucher@gmail.com"=
>
&lt;alexdeucher@gmail.com&gt;</a><br>
<b>Sent:</b> February 18, 2020 8:50 AM<br>
<b>To:</b> Yusuf Alt=B9parmak <a class=3D"x_moz-txt-link-rfc2396E" href=3D"=
mailto:yusufalti1997@gmail.com">
&lt;yusufalti1997@gmail.com&gt;</a><br>
<b>Cc:</b> amd-gfx list <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto=
:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject:</b> Re: writing custom driver for VGA emulation ?</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On Tue, Feb 18, 2020 at 2:56 AM Yusuf Alt=B9parm=
ak<br>
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:yusufalti1997@gmail.com=
">&lt;yusufalti1997@gmail.com&gt;</a> wrote:<br>
&gt;<br>
&gt; Hello AMD team;<br>
&gt;<br>
&gt; I have E 9171 GPU and want to use it on a embedded system which has li=
mited MMIO space on PCIe bus (MAX 512 MB).<br>
&gt;<br>
&gt; I received feedbacks that I can only use VGA emulation with this memor=
y space. I was unable to get 'amdgpu' driver working with Xorg due to I had=
 many errors(firmwares are not loading) in each step and tired of solving t=
hem one by one.<br>
&gt;<br>
&gt; I want to write a simple custom driver for this GPU with kernel versio=
n 4.19.<br>
&gt; Is it possible to print some colors on screen with a custom driver ove=
r PCIe communication ? or writing some words on screen as VGA ?<br>
&gt;<br>
&gt; If answer is yes, then which code pieces (on amdgpu driver folder) or =
reference documentation should I use? I have Register Reference Guide.pdf.<=
br>
&gt;<br>
&gt; I will be appreciated for your guidance.<br>
<br>
That is not going to do what you want on your platform.&nbsp; The VGA<br>
emulation requires that you set up the card first to enable it, which<br>
in turn requires MMIO access and thus you are back to square one.<br>
<br>
Alex<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.freede=
sktop.org">amd-gfx@lists.freedesktop.org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637176323587003958&amp;sdata=3D6eKo51jnHbE1=
QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&amp;reserved=3D0" originalsrc=3D"h=
ttps://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash=3D"U6meQaXVtmM=
vUg9YEUEclm83S&#43;Z07KrR9tCRISlpsrQ2MhZ3nHWjky8Y5XYAe9N&#43;vGF9XTpXLPgG33=
LoV6btCVtFURjkdXC6O1izBKd19S&#43;02Npep/Uw50puidKypM969urqdIFuT0ZCb9NZI4a8/=
iRekjRKHFXPNbeIJs51WNo=3D">https://nam11.safelinks.protection.outlook.com/?=
url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&am=
p;amp;data=3D02%7C01%7Cjohn.bridgman%40amd.com%7Ce7bf224775ad487d240708d7b4=
7992f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176306561328560&amp;=
amp;sdata=3DQbfaIN%2F6LvgUihz5O0x41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;amp;reserv=
ed=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset>
<pre class=3D"x_moz-quote-pre">____________________________________________=
___=0A=
amd-gfx mailing list=0A=
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.freede=
sktop.org">amd-gfx@lists.freedesktop.org</a>=0A=
<a class=3D"x_moz-txt-link-freetext" href=3D"https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flis=
tinfo%2Famd-gfx&amp;data=3D02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f=
4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323=
587003958&amp;sdata=3D6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&=
amp;reserved=3D0" originalsrc=3D"https://lists.freedesktop.org/mailman/list=
info/amd-gfx" shash=3D"U6meQaXVtmMvUg9YEUEclm83S&#43;Z07KrR9tCRISlpsrQ2MhZ3=
nHWjky8Y5XYAe9N&#43;vGF9XTpXLPgG33LoV6btCVtFURjkdXC6O1izBKd19S&#43;02Npep/U=
w50puidKypM969urqdIFuT0ZCb9NZI4a8/iRekjRKHFXPNbeIJs51WNo=3D">https://lists.=
freedesktop.org/mailman/listinfo/amd-gfx</a>=0A=
</pre>
</blockquote>
<br>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB309715C009FB496F1D3B4B56E8110DM6PR12MB3097namp_--

--===============1952406959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1952406959==--
