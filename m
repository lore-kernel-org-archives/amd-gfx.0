Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTTPS_HTTP_MISMATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A46C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 15:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C70921823
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 15:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C70921823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32446E142;
	Thu,  5 Dec 2019 15:32:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20CCA6E142
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 15:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goekuqf7hzpQYrIJqFWwNCYFEGkFu+x5/v0oMRQfNznNmF/J/mUYBgODdkGmqONAY8TFpGX0P90mN3tEYjQT0cFcX5V5Jw+rgiuku0w81I7EhlQhbVFBk3mw+VM/mkVRmgKQuA/hg3Mtl/4pP0foJQfykWu7zy5Pn2SlJAvzYpTE45XDCf4y5gbOeQt9Gcftuh5CGnulioyuNhKYQZ/3xMLuyqxzgSlBZsXD2TSQKtRFDPMrV/NFTZA8UfRzpZH/ldK8bkuHv7DC0qj62R43Oj+P0ehIrPUAjZ1jtAMH0QJ02qW492pr3+zJf3qsAWWldORtLhcLFeaX4gQKimzgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PnIkYcm6+t7r2SPqzMDZBd38lq3PjfdnaDjyu1nox0=;
 b=DY4WtirtTw3ePgJ8sNK//muHcumR5xIRi3eKslzJqwZpzgmrcQ3AaHH5QnVRHQOsEhoBWu/KRXqyw3Hi7rmUTlctPCc3bxNLuJqXgnL+wGdfHp3yuSzPm9q1D44I/ZLJkAr0DHQXLxgoqSjnSI57BqZSoAy3rwCqE8wJsEqCNuObhjQKSmJyagXonUWK6F591eY33z7kbgJ7SX9kOm3bzIPkm7VPftqDPS/Kpk3nlDbeVd8UYnAtU0g7YS+0TOsKds4R4kAH+tEZVDbU4sSBBwkZSTYGEDlILyNnCzyWYdgDq/iq7FXtrXfdJds0jZ6IYipGqcNISsU3RncBrhe3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1536.namprd12.prod.outlook.com (10.172.51.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 15:32:11 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 15:32:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Matthew Taylor <mat@sharrow.me.uk>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [RFC 0/7] UVD support for SI in amdgpu
Thread-Topic: [RFC 0/7] UVD support for SI in amdgpu
Thread-Index: AQHVq3aejlfAahV260mN2GbYpn3IMKerp8+AgAADQT0=
Date: Thu, 5 Dec 2019 15:32:11 +0000
Message-ID: <MWHPR12MB13584BB86FC975D3A32F3A96F75C0@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <CAJ0uJC1kxmAdwjRGMf8ZHospNz5sO1jV1E0E1_tsBZCrDVK=ag@mail.gmail.com>,
 <5f0ba91c-3234-9d27-cda9-af22ac781436@gmail.com>
In-Reply-To: <5f0ba91c-3234-9d27-cda9-af22ac781436@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-05T15:32:10.518Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5792328-8f88-4ade-2de2-08d779984c46
x-ms-traffictypediagnostic: MWHPR12MB1536:
x-microsoft-antispam-prvs: <MWHPR12MB1536A5563C40A7A283F139C6F75C0@MWHPR12MB1536.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6506007)(9686003)(54896002)(478600001)(229853002)(74316002)(71200400001)(25786009)(55016002)(53546011)(966005)(81156014)(81166006)(7696005)(8676002)(8936002)(11346002)(2906002)(110136005)(33656002)(71190400001)(66476007)(66556008)(66446008)(66946007)(316002)(5660300002)(102836004)(186003)(26005)(52536014)(76176011)(64756008)(86362001)(14454004)(99286004)(76116006)(19627405001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1536;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IeaKsWxah9iyP5lSLPfyNMc1Y90J1gLdzGUHU2wCp22J6IKIOaHb8D9RL+Ut+La5b9riTWLv6HRBuIQhJKLI575CkRbaxgVSM39Q+5XX7HlLecK5jbiulWr6UcI6wIIXTCkoqcc0ThhpCMRe9Y970oisGddRlc/ABvW+YlEL1UKLYfobHS0OinZ3Q/gVTMimBU1wWALuLqevkDIvdgA0VceafrRKcd3Go+IAX+z/I/Et9KWes54jgowQbRGp0EcQHC67KCLpqMN+Ev4cXCj0W2BiHyB+5M1/A/a2M1Q7IcuEO70sPObIg9rRtpL/Q3ZdulB+eLisVciDGfATm/friY+D60N836hQtIuIRUkAFztnsVrtfDtDIOdo7aJ2Ez1okD3Q9oSRD9xpeIb9dlpvZ4YRthnh+Gq+mkFcpy++svba2w18bnQRvQpwu8VlC/U2PgXyWd1bF+hfxBHby9g0rkKfMuOJsK/XNFjVVLD6oX0=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5792328-8f88-4ade-2de2-08d779984c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 15:32:11.6112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQvwWWjUcxkZFkQmMiEeYvAMOvHLfyZBPvxZqPXIdy44BOM/EhP2EMWNqBbhKAsdiR05R4zyc/cfSUHCDXqNkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1536
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PnIkYcm6+t7r2SPqzMDZBd38lq3PjfdnaDjyu1nox0=;
 b=TsmiUUCOpHr5+Npa5XJhRnGN1X5U4uA/gVf883qIoEn9O02XsLgT6nD6kWdUSO4N+gqvNUubaXaCyz4oVjmQGuT00zap+OFCpniKxFlnxXdtw3VUnCLVPQEkDJdmqAYFG9MC03tm9FdWwcFJ/vXEHnc9Ej4JAqidyhvVbLaOfDQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1818556929=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1818556929==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB13584BB86FC975D3A32F3A96F75C0MWHPR12MB1358namp_"

--_000_MWHPR12MB13584BB86FC975D3A32F3A96F75C0MWHPR12MB1358namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

You could enable UVD support on amdgpu using the original firmware from rad=
eon, but you'd have to adjust the memory map on the GPU for SI to match rad=
eon.  So updated firmware is not a requirement per se, it's just needed to =
keep the memory map the same as other GPUs.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Thursday, December 5, 2019 10:19 AM
To: Matthew Taylor <mat@sharrow.me.uk>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Subject: Re: [RFC 0/7] UVD support for SI in amdgpu

Hi Matthew,

Am 05.12.19 um 15:16 schrieb Matthew Taylor:
Hi,

Back in November 2017, Piotr Redlewski, provided some patches for UVD suppo=
rt in the SI cards, the thread had the same subject as this message.

The outcome of a conversation between himself and other developers on the l=
ist was to wait for something in updated firmware.  As this was over 2 year=
s ago, I was wondering if the firmware has been updated sufficiently for Pi=
otr's patches to be reconsidered or modified to deliver the UVD support for=
 the SI cards?

we discussed that internally quite lengthy and the firmware will probably n=
ever be released.

To be honest we actually considering dropping SI support completely from am=
dgpu.

Regards,
Christian.


Thanks for you help

Kind Regards

Matthew Taylor



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7Calexander.deucher%40amd.com%7C14=
121ef4f0a049ddc3ea08d77996852f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637111559776723411&sdata=3DSpbvepoL17ImHwW7V5spbH46ze%2FNp7ll%2FqV86kE%2BB=
fU%3D&reserved=3D0>


--_000_MWHPR12MB13584BB86FC975D3A32F3A96F75C0MWHPR12MB1358namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You could enable UVD support on amdgpu using the original firmware from rad=
eon, but you'd have to adjust the memory map on the GPU for SI to match rad=
eon.&nbsp; So updated firmware is not a requirement per se, it's just neede=
d to keep the memory map the same as
 other GPUs.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Thursday, December 5, 2019 10:19 AM<br>
<b>To:</b> Matthew Taylor &lt;mat@sharrow.me.uk&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [RFC 0/7] UVD support for SI in amdgpu</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">Hi Matthew,<br>
<br>
Am 05.12.19 um 15:16 schrieb Matthew Taylor:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">Hi,
<div><br>
</div>
<div>Back in November 2017, Piotr Redlewski, provided some patches for UVD =
support in the SI cards, the thread had the same subject as this message.&n=
bsp;&nbsp;<br>
<br>
The outcome of a conversation between himself and other developers on the l=
ist was to wait for something in updated firmware.&nbsp; As this was over 2=
 years ago, I was wondering if the firmware has been updated sufficiently f=
or Piotr's patches to be reconsidered
 or modified to deliver the UVD support for the SI cards?</div>
</div>
</blockquote>
<br>
we discussed that internally quite lengthy and the firmware will probably n=
ever be released.<br>
<br>
To be honest we actually considering dropping SI support completely from am=
dgpu.<br>
<br>
Regards,<br>
Christian. <br>
<br>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div><br>
</div>
<div>Thanks for you help</div>
<div><br>
</div>
<div>Kind Regards</div>
<div><br>
</div>
<div>Matthew Taylor</div>
</div>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset>
<pre class=3D"x_moz-quote-pre">____________________________________________=
___
amd-gfx mailing list
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.freede=
sktop.org">amd-gfx@lists.freedesktop.org</a>
<a class=3D"x_moz-txt-link-freetext" href=3D"https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flis=
tinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexander.deucher%40amd.com%7C14121ef4=
f0a049ddc3ea08d77996852f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63711=
1559776723411&amp;sdata=3DSpbvepoL17ImHwW7V5spbH46ze%2FNp7ll%2FqV86kE%2BBfU=
%3D&amp;reserved=3D0" originalsrc=3D"https://lists.freedesktop.org/mailman/=
listinfo/amd-gfx" shash=3D"ix2l/Ei3jxaUf&#43;VCZrqMzMZo1IeB5gh5yA9VEl3kmHv5=
l4PjNWqRSEOMMYeKS7zIkjea7nAUCerC&#43;6T2EaY6nP/ZGQqHYuCXGHbM2aaaeOPYFcsZS0I=
&#43;GCGncMv5&#43;/eD6fzCAiOMyKmCtyO95P03R98vcWrfnED&#43;HqNZjd3U0As=3D">ht=
tps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_MWHPR12MB13584BB86FC975D3A32F3A96F75C0MWHPR12MB1358namp_--

--===============1818556929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1818556929==--
