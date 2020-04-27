Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF3EC54FD0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 13:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E166D206BF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 13:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gffJgNQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E166D206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F116E08A;
	Mon, 27 Apr 2020 13:01:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFE26E08A
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 13:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njQxslFpBJrx2AXYw4QfJELNP6pch4jd+0DGWKGTbjt0D+y3EnLMJMQCurPrhWXn/yhbXtmA4iHVyy1xrw3kaNYU90bBtl43mNQ6KIPHacrS+H775o48WNzrWNKbgATs05zIqJIpUsmC/PuGtDJjHeVgxPJ4P+78wqAHlPOBqbXxwhJY9g6RivMZ59y4/0/PmPr9c8iItK+WyTbu/yqlbicp1tsoycfrS2m8mIN2TnDWjOClATmbVD1FcAK+xWTOytzY0djIOIEBu/3GZt80FNytC562g/MEPi7RS1Y/bB/W7l0BsbMWoOmR4jlt44nlXKFtgOX4ThFDI/RR6RVTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3qL+gpY0ThNCxeg/WktV9hk3Efp24SoMvw7DimQBNA=;
 b=K62OlvFGVj+MRhac6ctfX4DbXaUOvNwoZDsXptKeHe7ZAUPJz9W5caNctEMEteYJLyATQ9ROFR77WSKkdNKnPxJ9972sxg76Iq+zgKub+FT4VSqSAtnUX+1kwhqJHRm3slpr9/uh1gQPKPpmmJnrl6kMG1M+fP0mwzbSnXVpFxO2roIvXoEt2xvt87/NqJdIV5EhUK+UJKTRalOsz8LvFEBIqZpar7e40oJ930+KJIHGhUbVCWaSXf2mnAbo1lIM5D1FySh22k74SjRNLhVfjIRe9wPDZ4N9W/nP+EjPGiNpuLbNp1SIKhREVyYMXAeoynwuTeTr75LHMJzlPY9meg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3qL+gpY0ThNCxeg/WktV9hk3Efp24SoMvw7DimQBNA=;
 b=gffJgNQBtbLYe1S4/m+LaNSIbQI/Lg3zFOCJjDqCvSOhTWdxjvvRnHrGvTvdA4t4m6vaHxuf2v/vtuWaPYWBrTey1tVRBscbvBcfwGjfMT8mUlAmU8lkyuDDc4fQcCphsk2eMF+Sryr34EOE8N9X4ZvJ805FQxl8icxnMlCscV8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3486.namprd12.prod.outlook.com (2603:10b6:208:c6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 13:01:03 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941%6]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 13:01:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?Windows-1252?Q?Marek_Ol=9A=E1k?= <maraeo@gmail.com>
Subject: Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
Thread-Topic: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
Thread-Index: AQHWGt77YbaHnzNcfU2ReZDpujzt5aiJ79oAgACdsoCAAIy/AIAB1wqh
Date: Mon, 27 Apr 2020 13:01:03 +0000
Message-ID: <MN2PR12MB4488629455EEFE9590402250F7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com>
 <71c2f3e9-a734-5887-b5ce-7fa8b011d372@gmail.com>
 <CAAxE2A67RM1e0Xs2fTcDPm0eTyd4EvdH2vqPsVXWEODL=Dk4zw@mail.gmail.com>,
 <659c4b65-764e-85a8-6ac6-0a9daaa6437e@amd.com>
In-Reply-To: <659c4b65-764e-85a8-6ac6-0a9daaa6437e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-27T13:01:02.659Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.72.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9dd4049-f1c9-49c1-582e-08d7eaab0a9b
x-ms-traffictypediagnostic: MN2PR12MB3486:|MN2PR12MB3486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3486743EF42B870D4F9AB969F7AF0@MN2PR12MB3486.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(4326008)(55016002)(33656002)(5660300002)(110136005)(81156014)(71200400001)(9686003)(8676002)(2906002)(966005)(316002)(86362001)(478600001)(186003)(7696005)(19627405001)(52536014)(66574012)(6506007)(26005)(66946007)(66446008)(76116006)(8936002)(66556008)(64756008)(53546011)(66476007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yivuQ+yMcM26p/XM9vtv1VvcsXb6IUq50ooXuqIID894VXDIDxBIEVN2jluxtBSiVEfAF48JrO8hEX/ois7b6FBh1b/kag+rhiNzzyWTZOcOL7TwKFMY1gZBVTnpj4IiKCc2fAyp7qfSdGkKUCDW3DRG4ADSorqATXhmLxp5vge+kekjYJPKfTWjqgUgJRXyFBRT7IskwgDXl8RsiT+WpEVqrhJ5lENGTFSxs7nkcCrsDofPDxPlvPxMy/lxCKh0lIauxwoCtu81s71UwVw+LNDdlCdzo0DKxpS/gjxuVPNNGE9rmUkdh0LCBJxnlzRuwvkFy4zkqaeEfq9e0dLmzFMPntsmJ1b7BuOaWMnra4QbMRntg0V3dInRp6P4eDs1oUSl21EZ50KvGqFfFeHS2vNYdbXXvtghFadQm0v+xo3FzC2HF+7C8hTxWdZNQxLWEKavYVRuv8RaOTYi7k1ELMEd5X5woqRDI6EmttZ2o9s=
x-ms-exchange-antispam-messagedata: RdKOazIHhMsiRTH/BkIe1uDoN+g94/Z2TYQ1i4jYB+eaiy94x+Anb11LXkAylOjnaUYBdO+sVsAKCXevOEysQ9YN2xZwnrruERHe3nJy/YXHI4j9E8p5q+V5xv5Bnnr51EOQKC4rPU+TWo/+4uDfAfRMtHLz1Zbxgn6zIXgDh7GjFptoZu8kidjEGXEcaHNUYLhbYSeLB3EQRKpxXQaU/f2Fm0soxHWws9HSVazFt1njY0YuGqvvNQpjPEhKuurbzYmXR1YV6HOjPXsT9ML5Fl2XIMzFtT5GIQvtWB0KsR3eJDzPRCNUdD7wpLhCeWpzdltGTWLDpZiwt74JrPhuvOkjaOpgdUBozFNJTtR15qe8ujnoPO+7S+DQaZPTjjuSBLvrbfjmhJxUiIG5TPH/zx1zYJwbZseIksQtjYbzll+xj61zNHJFKjCkIkQmVNvWqlzPBy+A/eyYy6lZiMW+1fAeJRRc1Ud4VTBDdz8ZGS0J++oHURofchnehUHkO7gYDKUAC9uucyfaVYknESK0XU1nIsA1M9wn+TVZOKSXIr0o/pUNzf5vA0BWr0xe8BZyOWqcxn2zRS5QZ5U6ASJk/m+2nuEqcS4A4oseAvn4heIYw8EhKNdxuYWYAXzKz6jygBYp4d6082pCAEb5ahVDVLW2NlatL680slTzFAt3OOHJ8iE8DJT0cZkm9nChZm7/QFuvbN5eu6Bilwz4231+vc07dGpgWG/q1LRwNA+JQDryaiskjNCDFpEXptLUVRBgZvmltyuGlkCADIeBxxTfkdBmzR68vTAO3y3GVLB8/Vk=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dd4049-f1c9-49c1-582e-08d7eaab0a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 13:01:03.3170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2Cq3VWLXFQInw/U7Flq5IgxnfC4sGpGTVpLoXo+5ERg3fmS/NzgJCrywlm6GmhHx7YA+0PB/E9rOvDnnr8PGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3486
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0242733608=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0242733608==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488629455EEFE9590402250F7AF0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488629455EEFE9590402250F7AF0MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Please split the patch into two, one to update the emit IB sequence, and on=
e to bump the minor version.  That way we can make sure older kernels get t=
he new sequence.  Also do we need an sdma fw version check for the new pack=
et in the emi IB function?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <christian.koenig@amd.com>
Sent: Sunday, April 26, 2020 4:52 AM
To: Marek Ol=9A=E1k <maraeo@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Subject: Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)

Thought so, we should try to get this get it committed ASAP. And maybe add =
a CC: stable tag as well.

Patch is Reviewed-by: Christian K=F6nig <christian.koenig@amd.com><mailto:c=
hristian.koenig@amd.com>.

Thanks,
Christian.

Am 26.04.20 um 02:28 schrieb Marek Ol=9A=E1k:
Not without a mandatory firmware update. The gcr packet support for IBs was=
 added into the sdma firmware just two weeks ago.

Marek

On Sat., Apr. 25, 2020, 11:04 Christian K=F6nig, <ckoenig.leichtzumerken@gm=
ail.com<mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
Could we do this in userspace as well?

Am 25.04.20 um 10:52 schrieb Marek Ol=9A=E1k:
This should fix SDMA hangs on gfx10.

Marek



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D02%7C01%7Calexander.deucher%40amd.com%7Cc8=
8f73e068bb483bb21f08d7e9bf2cd4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637234879980330283&sdata=3DLZ2GMq0a0n6cm74ulhIkMq%2Fyj6XlG1lj9AH0InU1%2BdQ=
%3D&reserved=3D0>




--_000_MN2PR12MB4488629455EEFE9590402250F7AF0MN2PR12MB4488namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
Please split the patch into two, one to update the emit IB sequence, and on=
e to bump the minor version.&nbsp; That way we can make sure older kernels =
get the new sequence.&nbsp; Also do we need an sdma fw version check for th=
e new packet in the emi IB function?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;christi=
an.koenig@amd.com&gt;<br>
<b>Sent:</b> Sunday, April 26, 2020 4:52 AM<br>
<b>To:</b> Marek Ol=9A=E1k &lt;maraeo@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx mailing list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)</f=
ont>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">Thought so, we should try to get this get =
it committed ASAP. And maybe add a CC: stable tag as well.<br>
<br>
Patch is Reviewed-by: Christian K=F6nig <a class=3D"x_moz-txt-link-rfc2396E=
" href=3D"mailto:christian.koenig@amd.com">
&lt;christian.koenig@amd.com&gt;</a>.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 26.04.20 um 02:28 schrieb Marek Ol=9A=E1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"auto">Not without a mandatory firmware update. The gcr packet s=
upport for IBs was added into the sdma firmware just two weeks ago.
<div dir=3D"auto">
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Marek</div>
</div>
</div>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Sat., Apr. 25, 2020, 11:04 Chris=
tian K=F6nig, &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoen=
ig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0
          .8ex; border-left:1px #ccc solid; padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div>Could we do this in userspace as well?<br>
<br>
Am 25.04.20 um 10:52 schrieb Marek Ol=9A=E1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div>This should fix SDMA hangs on gfx10.<br>
</div>
<div><br>
</div>
<div>Marek<br>
</div>
</div>
<br>
<fieldset></fieldset>
<pre>_______________________________________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx@lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Calexander.deucher%40amd.com%7Cc88f73e068bb483bb21f08d7e9bf2cd4%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637234879980330283&amp;sdata=3DLZ2GMq0a=
0n6cm74ulhIkMq%2Fyj6XlG1lj9AH0InU1%2BdQ%3D&amp;reserved=3D0" originalsrc=3D=
"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash=3D"nqCrx/qKx=
BIfNFFGrHzmgFg/0Fe7cU4M5R/vrlqAe2aVKtsXB37xTBHzS7d3AFtSsRKm4jN4srcyYTWJlslI=
KeogeQYmAZCT0GklVT6fjTNFrOD/CbT2W55XcPNaD8whb0qGmqqW&#43;Wi3S8VbCsPwogcMhyi=
Kf9IX/eKnF/HLWt8=3D" originalsrc=3D"https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx" shash=3D"dlX4LGfyAh14NCCsa6dwqTrxPXuCCgJDe8w9kJd7hGXodluuR=
AGDJNyjEbd1JYV8vjgYlIqJoFXUrpI/7raQZC8kRAlk4SaUHimLdFOLIIu&#43;SQbYterDOjKJ=
hztukpaReEroKRvjNIKvQP4R7uAGPCHEosh9OZbFveSp273tYQk=3D" target=3D"_blank" r=
el=3D"noreferrer">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a=
>
</pre>
</blockquote>
<br>
</div>
</blockquote>
</div>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4488629455EEFE9590402250F7AF0MN2PR12MB4488namp_--

--===============0242733608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0242733608==--
