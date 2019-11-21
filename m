Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F118C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 16:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289C82063A
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 16:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289C82063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8BD56F3DF;
	Thu, 21 Nov 2019 16:00:07 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750048.outbound.protection.outlook.com [40.107.75.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 633566F3DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 16:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLqvgyLpSBbKl7n+jrULr+VoyuBzE7cd7nKNmJuNvfpcMZQS0SQJ3zr9s0xOnw2KKxHu/ZDPbFlP3dZB64KR/M3DWs6nazeeo1gEo/lZ2iYWRxHdfN01eLI0+lyxR3Rw5LR1QAiIRzl/+LpLE3ShuYaGY/UFyxWg2bqgtaTNWXp+/+l8gYQrHAHwoaJd60Nc8gHmQK4YYewmcKWsF7y0nCqQBqOPqOs/9eK0Ig1j3J4guMBV/VIv7bL1FdtANIUDAEK/+twbMSyKpbmTbMckVQDvfKQFa+K6KfdJ070wo+hQ4zr1HJS7nKKcUjzPo+aZpGYnApY8/8GGv2tfxtfDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYpnK4mf0QNg5uVjnHKR+K0iJg7tt4tpoLnEl61HXSQ=;
 b=DmUzygkY5yEtgrT1v8OiGo4+ZRGekAI1gZO/2hk0S7W3fcmr3VgsNJJ56jcWad3PR8PU8e8GHO1XImUnuam0g2VzYMfw9t3WbRcuFkrIr3KkEwztFU1CFllTYb8jU8MU43Wxi7SEcb27w520ppHIzm/cZ38G0HArfeQxlfARf2ZMtsYlZqyQWomMWgRYcXMQfkeOuuVqvN1OiNKjlAP3ci2aFzkrPYpbdyuNvTRZ6kW3BlDSFmyK+RyMh8IKIWRS7KIYAP1d8IvjuNpigvtYMfY220yRqEYzUKL9gon/6Cvwl3Bn50dOr5FK06QFp5tpYRnGOFwFASA1KWNoCF6aZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1943.namprd12.prod.outlook.com (10.175.59.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Thu, 21 Nov 2019 16:00:04 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 16:00:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus
 VF.
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus
 VF.
Thread-Index: AQHVoDNUz/BtIctbWEGhj1wZPhJAnaeVv1cAgAAAY4CAAAj+AIAAADR+
Date: Thu, 21 Nov 2019 16:00:04 +0000
Message-ID:
 <CY4PR12MB181333EBFDD75B8664F319CAF74E0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191121061707.25958-1-Jack.Zhang1@amd.com>
 <CADnq5_MrfFWAjC__9ccB46CYzdcLWP=DPKD70aXAm862DJLu1g@mail.gmail.com>,
 <CADnq5_OE8xi7TmgxWe2PiWVxM8pVhxAtYF=CTtT7AHOhrUhEyA@mail.gmail.com>,
 <CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0@CH2PR12MB3672.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0@CH2PR12MB3672.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c6a235d-c0c1-4bfb-1bdf-08d76e9bdf7f
x-ms-traffictypediagnostic: CY4PR12MB1943:|CY4PR12MB1943:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB194332564B163620641809EBF74E0@CY4PR12MB1943.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(199004)(189003)(81156014)(81166006)(8676002)(2906002)(99286004)(66476007)(66556008)(66446008)(25786009)(102836004)(76116006)(11346002)(110136005)(74316002)(52536014)(66066001)(316002)(86362001)(8936002)(105004)(7736002)(66946007)(64756008)(6506007)(14454004)(186003)(6116002)(7696005)(76176011)(966005)(26005)(71190400001)(71200400001)(45080400002)(446003)(54896002)(606006)(53546011)(19627405001)(55016002)(4326008)(5660300002)(33656002)(6436002)(256004)(14444005)(236005)(3846002)(6306002)(9686003)(6246003)(229853002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1943;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AXQaM7+G3vSM0YTM+vyRtDvbTwV+N9l3+UQDgDfEH2WSxY7tKCCXAc6dHDtg7CPid1j6hK7qJ8wtYStDWkVKT0rWYfvCTvKRHs2gYivDhI3UzckyJv0hvfB+AWAJe6EhFvgfbuT/4+d4yDochct4rdW/hXxiZ095prWklPUaN1TiJZkRl+B7Aj5JnGlkJmnlkWUWI900a/gF1HLebgTqb1pQ6/Jre5BAkAgjEbM6f+Z/L0qRrk2rZ7BuYh4nfDGIOxlNIa+IIVoNhM1Anz1/VTuc5SUbMuxe5otiBLhM/viU2fZJGRsLaC/4e2+CaNiGcS7xaaFkAUnDaANv+RHW5Cp3SqEl5dgLBYFcc5CsUw5KRVuIOG0SIkk0fW1MGkO+qfSDRwA0AY6OBzH9OnfrJNZVMdBpPhR/FPWDrPitHzVdrI1Z9Ti2njrz8/7PT0uEYwV1sOga4LCSVineAEmqT7vOKlNUvDBwLLyienZEX+0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6a235d-c0c1-4bfb-1bdf-08d76e9bdf7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 16:00:04.3180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VpWpJ3YdUW9Z6gwnq6N0zpqckjoideVOs+cHBmo/HwCHcGzfky8QdsxYJo4a61JcNEoNRqvDX76QXNx9uB3gbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1943
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYpnK4mf0QNg5uVjnHKR+K0iJg7tt4tpoLnEl61HXSQ=;
 b=ypByo9acwMj6uX5eSxX5ul5MrBuX4rYhwYK7gS67RaAKmcpLnsZa7zy6CCcwCjMJIwt0I1KBid2poztV2nc9vz+z076agkKM2TDuoWTYE/UGh4JVy3F+EgrHGX4cJW0KdSNFps4z17WsNPNkgZTwPME/lk6d4KaJdKkXI5CWkcs=
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1118050713=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121160004.dC6uXK3SKFJu_Y5Sy_CW4MTBd11IrFVkwJlweNPUtwk@z>

--===============1118050713==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB181333EBFDD75B8664F319CAF74E0CY4PR12MB1813namp_"

--_000_CY4PR12MB181333EBFDD75B8664F319CAF74E0CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

You can have my RB on the first patch if you fix the compiler warnings.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, J=
ack (Jian) <Jack.Zhang1@amd.com>
Sent: Thursday, November 21, 2019 10:58 AM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arctur=
us VF.

Thanks Alex for this review.

Both of the two patches will not influence bare-metal code path.

B. R.
Jack

 Outlook for Android<https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Faka.ms%2Fghei36&data=3D02%7C01%7Calexander.deucher%40amd.com%=
7Cf350a586b8b840526a2c08d76e9bb538%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C0%7C637099487450051533&sdata=3DghsxwJqO5AO%2B2pBhPoQz70SkyYyeNCnA5FQMAHQVV=
pI%3D&reserved=3D0>
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, November 21, 2019 11:26:37 PM
To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arctur=
us VF.

Nevermind.  I missed the sr-iov check. Patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Nov 21, 2019 at 10:25 AM Alex Deucher <alexdeucher@gmail.com> wrote=
:
>
> Won't this impact bare metal hw that needs this?
>
> Alex
>
> On Thu, Nov 21, 2019 at 1:17 AM Jack Zhang <Jack.Zhang1@amd.com> wrote:
> >
> > After rlcg fw 2.1, kmd driver starts to load extra fw for
> > LIST_CNTL,GPM_MEM,SRM_MEM. We needs to skip the three fw
> > because all rlcg related fw have been loaded by host driver.
> > Guest driver would load the three fw fail without this change.
> >
> > Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_psp.c
> > index c3a42d3..eecde80 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -1470,7 +1470,10 @@ static int psp_np_fw_load(struct psp_context *ps=
p)
> >                     || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA5
> >                     || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA6
> >                     || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA7
> > -                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_G))
> > +                    || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_G
> > +                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTO=
RE_LIST_CNTL
> > +                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTO=
RE_LIST_GPM_MEM
> > +                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTO=
RE_LIST_SRM_MEM))
> >                         /*skip ucode loading in SRIOV VF */
> >                         continue;
> >
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CJack=
.Zhang1%40amd.com%7C62c30b71b3b8490862d808d76e973ae5%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637099468112639673&amp;sdata=3DiC932sWNGrLeexp7wIDdr=
Z7cjVBcFv5giOTC3uHdE%2Fk%3D&amp;reserved=3D0<https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flis=
tinfo%2Famd-gfx&data=3D02%7C01%7Calexander.deucher%40amd.com%7Cf350a586b8b8=
40526a2c08d76e9bb538%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637099487=
450061527&sdata=3DFofOoED2ixVkMukh%2FOXH8mdtu%2B%2BwilXYGxbQVNRflUY%3D&rese=
rved=3D0>

--_000_CY4PR12MB181333EBFDD75B8664F319CAF74E0CY4PR12MB1813namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You can have my RB on the first patch if you fix the compiler warnings.</di=
v>
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
ounces@lists.freedesktop.org&gt; on behalf of Zhang, Jack (Jian) &lt;Jack.Z=
hang1@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 21, 2019 10:58 AM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for=
 arcturus VF.</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"auto" style=3D"color:rgb(33,33,33); background-color:rgb(255,25=
5,255); text-align:left">
Thanks Alex for this review.&nbsp;</div>
<div dir=3D"auto" style=3D"color:rgb(33,33,33); background-color:rgb(255,25=
5,255); text-align:left">
<br>
</div>
<div dir=3D"auto" style=3D"color:rgb(33,33,33); background-color:rgb(255,25=
5,255); text-align:left">
Both of the two patches will not influence bare-metal code path.&nbsp;</div=
>
<div dir=3D"auto" style=3D"color:rgb(33,33,33); background-color:rgb(255,25=
5,255); text-align:left">
<br>
</div>
<div dir=3D"auto" style=3D"color:rgb(33,33,33); background-color:rgb(255,25=
5,255); text-align:left">
B. R.&nbsp;</div>
<div dir=3D"auto" style=3D"color:rgb(33,33,33); background-color:rgb(255,25=
5,255); text-align:left">
Jack&nbsp;</div>
<div id=3D"x_ms-outlook-mobile-signature">
<div><br>
</div>
&nbsp;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Faka.ms%2Fghei36&amp;data=3D02%7C01%7Calexander.deucher%40amd.com%=
7Cf350a586b8b840526a2c08d76e9bb538%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C0%7C637099487450051533&amp;sdata=3DghsxwJqO5AO%2B2pBhPoQz70SkyYyeNCnA5FQMA=
HQVVpI%3D&amp;reserved=3D0" originalsrc=3D"https://aka.ms/ghei36" shash=3D"=
bHmwcig1c/ivEqfeQ&#43;XaQVVUj7qxHWBGX0ldZKiB9DSebI34lBdHcxM/Dv4d5JgvZCjm59f=
MeIc1SzAHsirRMN2AZXVyZV&#43;f3SSQTlSvL09Z3BU7VECCkuGcwwRL&#43;6WRjaeE0tZw3&=
#43;IZJB3cgsdVUZswyTbL/cnsG&#43;2zvEJDQk8=3D">Outlook
 for Android</a></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;al=
exdeucher@gmail.com&gt;<br>
<b>Sent:</b> Thursday, November 21, 2019 11:26:37 PM<br>
<b>To:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for=
 arcturus VF.</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Nevermind.&nbsp; I missed the sr-iov check. Patc=
h is:<br>
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
On Thu, Nov 21, 2019 at 10:25 AM Alex Deucher &lt;alexdeucher@gmail.com&gt;=
 wrote:<br>
&gt;<br>
&gt; Won't this impact bare metal hw that needs this?<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; On Thu, Nov 21, 2019 at 1:17 AM Jack Zhang &lt;Jack.Zhang1@amd.com&gt;=
 wrote:<br>
&gt; &gt;<br>
&gt; &gt; After rlcg fw 2.1, kmd driver starts to load extra fw for<br>
&gt; &gt; LIST_CNTL,GPM_MEM,SRM_MEM. We needs to skip the three fw<br>
&gt; &gt; because all rlcg related fw have been loaded by host driver.<br>
&gt; &gt; Guest driver would load the three fw fail without this change.<br=
>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Jack Zhang &lt;Jack.Zhang1@amd.com&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 &#43;&#43;&#43;=
&#43;-<br>
&gt; &gt;&nbsp; 1 file changed, 4 insertions(&#43;), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; &gt; index c3a42d3..eecde80 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; &gt; @@ -1470,7 &#43;1470,10 @@ static int psp_np_fw_load(struct psp_c=
ontext *psp)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_i=
d =3D=3D AMDGPU_UCODE_ID_SDMA5<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_i=
d =3D=3D AMDGPU_UCODE_ID_SDMA6<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_i=
d =3D=3D AMDGPU_UCODE_ID_SDMA7<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=3D A=
MDGPU_UCODE_ID_RLC_G))<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_i=
d =3D=3D AMDGPU_UCODE_ID_RLC_G<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=
=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=
=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=
=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM))<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /*skip ucode loading in SRIOV VF */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; continue;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.7.4<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; amd-gfx@lists.freedesktop.org<br>
&gt; &gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=
=3D02%7C01%7Calexander.deucher%40amd.com%7Cf350a586b8b840526a2c08d76e9bb538=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637099487450061527&amp;sdata=
=3DFofOoED2ixVkMukh%2FOXH8mdtu%2B%2BwilXYGxbQVNRflUY%3D&amp;reserved=3D0" o=
riginalsrc=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash=
=3D"v1wCxGgg8h9LTcYJBtTSE1i9EQ0P8bypOgG8IUjTyL5b8gnqWtckORm0cOCP4ZsSuMlCGFP=
0/KAzPSTzYHfZYt/EpzzHHQZAyKTUtPOQB1UIBUKYSv9OT7ETsISxGQV8lQDDptOXqvWD8VKJaA=
WTW8Bn2p45WHhlCyoRPwKEISc=3D">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CJack=
.Zhang1%40amd.com%7C62c30b71b3b8490862d808d76e973ae5%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637099468112639673&amp;amp;sdata=3DiC932sWNGrLeexp7w=
IDdrZ7cjVBcFv5giOTC3uHdE%2Fk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB181333EBFDD75B8664F319CAF74E0CY4PR12MB1813namp_--

--===============1118050713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1118050713==--
