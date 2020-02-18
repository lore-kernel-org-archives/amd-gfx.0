Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64360C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0242320722
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T+sNXUOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0242320722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1E06EA11;
	Tue, 18 Feb 2020 14:08:19 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA966EA11
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 14:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKnnoSN+gauZFLdEjaHpKIezIsVaQsVTUaqlAWS2ZYArJtGpX0F16BFHTofjXssppo5polbTkqVJ/z7qOEsWmV5gTRh5LC2wfYD01uU8KeNv8uFb55MV1k5nCM+mJag7f9KfRfj1OR2DS3rbfUpvMQFs6Yl3K79/A7z7/Xx0dguhSXjUGc0YTnnBmIfp+NELoQHl4ISZ1a9x8G4cqjFnjtyzwHq7dENcl7wuuCiZCKRe9GVQOigoIOthRctlv9KTXpkjL1JN9mWQfD1SAXGG6+O4K5zBJJmS96WDO8VjPCuAkvIcVe2tEeO05G8CJudSoNp8tfsOJreQpE2SnHpgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEtO90bVJGTYlCuY4L4oaTyor7ik882WlBXRs5mXQQU=;
 b=RfM9v3+sJb1iK/QiUaAwEBmHVxrKujr9MVAGrv0CFFEbU5Ct7DELIQQpj7sRepNSHaz9tITHpjBX6JhjOpqSSe8xoUSXgwrEjEctCXNvgeo1M3sndsiwIcks0U4qrCcYczHWBPi5NBY6FvYcgjj9XLDH/w+qTeHggTJKgG7/Fhu19Gk6GkWWJKYELD3AmEbdDPkg4u85kl3sMoRPM5sxPnWLG7COo/MXGEDz78MXO/AONNG6g+pQdzZSw9gFva73AHTIWfIdcgDzXzIpJM7G3JK4cSiB9pNr5kHf5F+SBesAeYiWwNV3iqsRJ5o+SO0fzS2KW7bm22Jzo8LxBx0e2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEtO90bVJGTYlCuY4L4oaTyor7ik882WlBXRs5mXQQU=;
 b=T+sNXUOxPMADaaZm64tADbq/gcc0rt+NwO+ZykSKyrgZK6JBY+XVXq73feSV8Sx3EgIwxusiD/mjRYhLKXv/ygIuEi0RzPvubdz3M9rJ3oQagJJWRqW4o/70UrZBTLBImUpOXY3Va0RZWoAr6rL8XKmGuoVvM8bOsB3tYL3UGPc=
Received: from DM6PR12MB3097.namprd12.prod.outlook.com (20.178.31.89) by
 DM6PR12MB2668.namprd12.prod.outlook.com (20.176.116.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Tue, 18 Feb 2020 14:08:17 +0000
Received: from DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::c90d:ccf4:5717:9b46]) by DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::c90d:ccf4:5717:9b46%5]) with mapi id 15.20.2729.031; Tue, 18 Feb 2020
 14:08:17 +0000
From: "Bridgman, John" <John.Bridgman@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?iso-8859-3?Q?Yusuf_Alt=B9parmak?=
 <yusufalti1997@gmail.com>
Subject: Re: writing custom driver for VGA emulation ?
Thread-Topic: writing custom driver for VGA emulation ?
Thread-Index: AQHV5jEFFbMOyBOfOEaevdkKK6oZK6gg+GyAgAAC7gM=
Date: Tue, 18 Feb 2020 14:08:17 +0000
Message-ID: <DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110@DM6PR12MB3097.namprd12.prod.outlook.com>
References: <CAGzVRjzs8rgaLkWcaxdAn-DUf3Kk70TW=NPM+Hk9SLt7Tcjsfg@mail.gmail.com>,
 <CADnq5_MutDzY0fdhX3anCQXFAOLkAbcMS3timfFEDFBqVc-jxA@mail.gmail.com>
In-Reply-To: <CADnq5_MutDzY0fdhX3anCQXFAOLkAbcMS3timfFEDFBqVc-jxA@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-18T14:08:16.460Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Bridgman@amd.com; 
x-originating-ip: [72.139.204.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2473f22b-fbb5-43da-8332-08d7b47c0064
x-ms-traffictypediagnostic: DM6PR12MB2668:
x-microsoft-antispam-prvs: <DM6PR12MB2668B08F34C0F11C7D806195E8110@DM6PR12MB2668.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(66574012)(19627405001)(9686003)(5660300002)(478600001)(45080400002)(55016002)(52536014)(71200400001)(110136005)(966005)(316002)(186003)(8676002)(66946007)(86362001)(66556008)(66446008)(64756008)(66476007)(4326008)(7696005)(33656002)(8936002)(2906002)(6506007)(53546011)(76116006)(26005)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2668;
 H:DM6PR12MB3097.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FD2LOzw4PIBHGa80lQsvVAhE4Fb1Cpikw9TjLtGkuOD07kJJ/zIzWJ+HDQz7Xie1KN0EYYg4c9rT21P9I6OjUvQ5xmYGnJnoQEWp7LFW/oWkGjuBV54BguCRDaubRgRODFkw0GYAoWqjkwNnOUE5kbLgDi+5JVIA45emOopAzrfzs7FdtBkccPUeS/thQjiqxWWKTQU3pC34wCWcCniIO7k7/+XqAvPq9ppgCra/2AZBZRzZnR8m/h5Hz9nZlRbrVs6tdULpsGgCr1aCvO8cBYG4YspluGdjxMCQZpNewFrHytVfPij++/IC3rBG/L/jQ22ePNeyf0OzHCJ6zycL2O7m/bWj+PO3YMxLU5niOO0ULPO8NOX86OwcSXIk8PyFfHwc6343jkRg6uaxTGf0wAr+UXYWRJlFOxTGCGLiiMKg3MjGtDEsXOSHtSHnk4q/i4Fp/YlZ7un/1Bu+cz/aWyFY9j+JuxQ79l0MmX4KaTrD3x+eI2feJ2pj62FEmiK6GKey1DQWrAMKNE3zArgPpQ==
x-ms-exchange-antispam-messagedata: VDlWGUXXilIBH3U3HaJhqmRi096Jd1vvEgaX9ik9P1S0aTTwm2s6MQTKddQeAjapRFIjCl1emjDwCZSNGKXXI3dQxJR1yxXdYFWy+Kn5Imsl8PZviEF9pLesch5uqEPB710SDR/J9nTs4llFM95EQg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2473f22b-fbb5-43da-8332-08d7b47c0064
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 14:08:17.1036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WP/CDAJ6U1p0jFDQSY5CLeaJJTIH8k6WJFU5aGU4U7J7QYhNOeCpCfRYLKizaYW30F7JDDf6EPBktjcCXTvf+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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
Content-Type: multipart/mixed; boundary="===============0747175630=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0747175630==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110DM6PR12MB3097namp_"

--_000_DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110DM6PR12MB3097namp_
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Does the VBIOS come up with something like a splash screen, ie is VBIOS abl=
e to initialize and drive the card ?

If so then another option might be to use a VESA driver rather than VGA.


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: February 18, 2020 8:50 AM
To: Yusuf Alt=B9parmak <yusufalti1997@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: writing custom driver for VGA emulation ?

On Tue, Feb 18, 2020 at 2:56 AM Yusuf Alt=B9parmak
<yusufalti1997@gmail.com> wrote:
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
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cjohn.bri=
dgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637176306561328560&amp;sdata=3DQbfaIN%2F6LvgUihz5O0x41=
TwvdGYy7QTS5IVJq3RXYlA%3D&amp;reserved=3D0

--_000_DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110DM6PR12MB3097namp_
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
<div>Does the VBIOS come up with something like a splash screen, ie is VBIO=
S able to initialize and drive the card ?<br>
</div>
<div><br>
</div>
<div>If so then another option might be to use a VESA driver rather than VG=
A. <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> February 18, 2020 8:50 AM<br>
<b>To:</b> Yusuf Alt=B9parmak &lt;yusufalti1997@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: writing custom driver for VGA emulation ?</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Tue, Feb 18, 2020 at 2:56 AM Yusuf Alt=B9parmak=
<br>
&lt;yusufalti1997@gmail.com&gt; wrote:<br>
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
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cjohn.bridgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637176306561328560&amp;amp;sdata=3DQbfa=
IN%2F6LvgUihz5O0x41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;amp;reserved=3D0">https://=
nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskt=
op.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cjohn.bridgma=
n%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637176306561328560&amp;amp;sdata=3DQbfaIN%2F6LvgUihz5O0x41=
TwvdGYy7QTS5IVJq3RXYlA%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110DM6PR12MB3097namp_--

--===============0747175630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0747175630==--
