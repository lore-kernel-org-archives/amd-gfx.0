Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F43C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 04:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84AF32072B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 04:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bx8B3d14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AF32072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0375389E5B;
	Mon, 13 Apr 2020 04:23:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2D289E5B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 04:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLzFWh3k8qPmtbsbHQsTk4LWLQ1MN2jiSzcSLQ+PH5EVAg9XtM8Y07OdpzPPFdvxKezTxeCyilhS0rlf50Qeu6DveeFQ6FqTgclUsA8AkHNM2KIKoKa+MOBrfG9PSOy0NqoCfL1uAGJtfntb1xUPUjnjhQtxpiMGBRWHqO7m4lUU/zEInpwrdjc1M03LaJxVrQbQHKRxZUE7hH0DFTglsW8X+/x7yv0VvVl5z6MrgQnVRP7NOzxQwMznW7NpEbF1LryalvJDXAHXJiM4OD/xyKqt8stbnlUTa2A1D+b5HOcD+CAl3VIxWhbv6cH2ltjm4zte22XWxuxF/3gDtoEH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrzEo+1qqDHdGJRafA2mf/P86A8MA5AjwaBtcfq7GK0=;
 b=CZbjHymJkE98cSHr+dXr6QVVgdRqhkxXRVpzL5a8APaCUgqku5dG0qB2YE4/hw5ObSYMWEGDf9RtwobGpsAds8+MyjvYVufcSJilzeIEnqf8I/IQijRmRUZ5vGQks2iaPA4iniq3Qd/Q3FgT+A4hML2L1QEdMBdQ58YWmqMt2EF7C8lL/K9QTgkvMhljzKkIO9sWqGAJzbb+1r5ilrBEuGI8OOetJBHho1f3O9UcBLcVkKngfCR1ygbWPTSjiRJxuXxl3bxI2tAjs4zvHuDNNJ68rmJ5gr7xf2Q1MVFHsKE2zqpEifWF5FXSR/RLCPHTetek56psaHQQ2QfhQMEE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrzEo+1qqDHdGJRafA2mf/P86A8MA5AjwaBtcfq7GK0=;
 b=bx8B3d14hQ3DDigKQd9q28leZUWcLQKVRnWyUBd3lkBJ5XX5q0iRVf6ZCu+/WC+tH39lzTawfIQcsrhxNUjt6Otv5IP8aRwYqJb9VnxhrKFvysJ1Rs/LpRY+MCt3q3JILtUntGMP8nbPEOf+e1Zf0TSSs4Cy7njiQt065A9Z4nk=
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Mon, 13 Apr
 2020 04:23:47 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca%4]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 04:23:47 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Johannes Hirte
 <johannes.hirte@datenkhaos.de>
Subject: RE: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
 playback (v2)
Thread-Topic: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
 playback (v2)
Thread-Index: AQHWDN52o48DXgwBp0mMZR3JAwJ8m6h0n6QAgABAR8CAADXigIABZlIA
Date: Mon, 13 Apr 2020 04:23:47 +0000
Message-ID: <BY5PR12MB430770EDDB677F95284387E8FBDD0@BY5PR12MB4307.namprd12.prod.outlook.com>
References: <1586265256-8824-1-git-send-email-Prike.Liang@amd.com>
 <20200411235534.GA1930@latitude>,
 <BY5PR12MB4307451314528C7285E49C60FBDC0@BY5PR12MB4307.namprd12.prod.outlook.com>
 <SN1PR12MB255854626047504C0AB71A0987DC0@SN1PR12MB2558.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB255854626047504C0AB71A0987DC0@SN1PR12MB2558.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-12T03:45:38.0000000Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only -
 Unrestricted; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80eb35cb-9738-4c21-4c29-08d7df6275ec
x-ms-traffictypediagnostic: BY5PR12MB4259:|BY5PR12MB4259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4259A2818162364BA5E183D7FBDD0@BY5PR12MB4259.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(55016002)(71200400001)(52536014)(316002)(4326008)(66946007)(2906002)(76116006)(66556008)(33656002)(9686003)(64756008)(66476007)(110136005)(54906003)(66446008)(7696005)(186003)(15650500001)(45080400002)(5660300002)(966005)(478600001)(86362001)(53546011)(6506007)(8936002)(26005)(81156014)(8676002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fFhmHTyEsJZb7M/VA+r/fRS7v4iedQsZv9vP5LQ4KG+I+RR7AGIVOntle/uUoru1+wD99dSi/osZWaNG1+EWeo68rDW17Ed1szf2ai8GU1/q5GatglNROMhrmsQEq8AdtW1vVwoFflLivBhT2Pzz+FZ9OJXyOboxw7SAxSuBFKzrduPKLRc5J2eymxl9z9pew/IdKvHEcJiUgd15fcthe8O8ZHu3PW+ZIwf4kOh8Bg8KlMxs2fl0igVCZVy+g+r0gmflp5euL7OlFCsP2LkJ3eFRn2Uw8Ye1Dy87OEfOceuulcK505A1283Q5mvEeQyV/nyFUvTEcdpV9/RpVCU/XgM91prbAIjVmki6+5BOfWqI8DxAoQhfRW+2fK0+PgMUWyYAZcbEmetmSxI0CQbRQWjOq5VU8zHJBbU07YT7FuJX03ZFWkYJv4ymvCZQefld1VtfbWInQVhM/yD81m9Grc74FCyu9QqOS6x+eeb7scA=
x-ms-exchange-antispam-messagedata: O9QcWZ6uOlFVZVF+PdRkVl35de5cZOol8gcOsi2kddL5h6hqv+m/kwPn+hRfAZ+eWL2/iY4MIG24YEOcbtF3yvpsc2TgRJxDobiUsgbBe0n9Xs3bofg42ZlWwFZMOdZJZcf3cw+4nMZgaq2SZd0EJQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80eb35cb-9738-4c21-4c29-08d7df6275ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 04:23:47.2631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGng+RND/cAZxrUsT5Eme5bXGkoYeT47kKbQuywsE/NClYkSAJlNROPWxa3P58yp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============0888331398=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0888331398==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB430770EDDB677F95284387E8FBDD0BY5PR12MB4307namp_"

--_000_BY5PR12MB430770EDDB677F95284387E8FBDD0BY5PR12MB4307namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Could you share the PCI sub revision and I try check the issue on the Vega1=
0(1002:687f) but can't find the
reboot hang up.

Thanks,
Prike
From: Pan, Xinhui <Xinhui.Pan@amd.com>
Sent: Sunday, April 12, 2020 2:58 PM
To: Johannes Hirte <johannes.hirte@datenkhaos.de>; Liang, Prike <Prike.Lian=
g@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video =
playback (v2)

Prike
I hit this issue too. reboot hung with my vega10.  it is ok with navi10.
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Liang, Prike <Prike.Liang@amd.com<mai=
lto:Prike.Liang@amd.com>>
Sent: Sunday, April 12, 2020 11:49:39 AM
To: Johannes Hirte <johannes.hirte@datenkhaos.de<mailto:johannes.hirte@date=
nkhaos.de>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Quan, =
Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; amd-gfx@lists.freedeskt=
op.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org=
<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video =
playback (v2)

Thanks update and verify. Could you give more detail information and error =
log message
about you observed issue?

Thanks,
Prike
> -----Original Message-----
> From: Johannes Hirte <johannes.hirte@datenkhaos.de<mailto:johannes.hirte@=
datenkhaos.de>>
> Sent: Sunday, April 12, 2020 7:56 AM
> To: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>
> Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; =
Deucher, Alexander
> <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Huang, Ray=
 <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>;
> Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>
> Subject: Re: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with vide=
o
> playback (v2)
>
> On 2020 Apr 07, Prike Liang wrote:
> > The system will be hang up during S3 suspend because of SMU is pending
> > for GC not respose the register CP_HQD_ACTIVE access request.This
> > issue root cause of accessing the GC register under enter GFX CGGPG
> > and can be fixed by disable GFX CGPG before perform suspend.
> >
> > v2: Use disable the GFX CGPG instead of RLC safe mode guard.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com<mailto:Prike.Liang@amd.=
com>>
> > Tested-by: Mengbing Wang <Mengbing.Wang@amd.com<mailto:Mengbing.Wang@am=
d.com>>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 2e1f955..bf8735b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2440,8 +2440,6 @@ static int
> > amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)  {
> >      int i, r;
> >
> > -   amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> > -   amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> >
> >      for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
> >              if (!adev->ip_blocks[i].status.valid)
> > @@ -3470,6 +3468,9 @@ int amdgpu_device_suspend(struct drm_device
> *dev, bool fbcon)
> >              }
> >      }
> >
> > +   amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> > +   amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> > +
> >      amdgpu_amdkfd_suspend(adev, !fbcon);
> >
> >      amdgpu_ras_suspend(adev);
>
>
> This breaks shutdown/reboot on my system (Dell latitude 5495).
>
> --
> Regards,
>   Johannes Hirte

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cxinhui.p=
an%40amd.com%7Cde6e0578174940b5f29808d7de948b88%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637222601969843248&amp;sdata=3DquWGElw%2Fo70VJibuZ7%2BzS%=
2FcHH2OHSDB%2B5uaFPQUf2Os%3D&amp;reserved=3D0

--_000_BY5PR12MB430770EDDB677F95284387E8FBDD0BY5PR12MB4307namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Could you share the PCI sub revision and I try check=
 the issue on the Vega10(1002:687f) but can&#8217;t find the
<o:p></o:p></p>
<p class=3D"MsoNormal">reboot hang up.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Prike<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt; =
<br>
<b>Sent:</b> Sunday, April 12, 2020 2:58 PM<br>
<b>To:</b> Johannes Hirte &lt;johannes.hirte@datenkhaos.de&gt;; Liang, Prik=
e &lt;Prike.Liang@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-gfx@l=
ists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with=
 video playback (v2)<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:black">Prike<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif;color:black">I hit this issue too. reboot hung with my vega10.&nbsp; it=
 is ok with navi10.<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;</span><a href=3D"mailto:amd-gfx-bounce=
s@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a><span sty=
le=3D"color:black">&gt; on behalf of Liang, Prike
 &lt;</span><a href=3D"mailto:Prike.Liang@amd.com">Prike.Liang@amd.com</a><=
span style=3D"color:black">&gt;<br>
<b>Sent:</b> Sunday, April 12, 2020 11:49:39 AM<br>
<b>To:</b> Johannes Hirte &lt;</span><a href=3D"mailto:johannes.hirte@daten=
khaos.de">johannes.hirte@datenkhaos.de</a><span style=3D"color:black">&gt;<=
br>
<b>Cc:</b> Deucher, Alexander &lt;</span><a href=3D"mailto:Alexander.Deuche=
r@amd.com">Alexander.Deucher@amd.com</a><span style=3D"color:black">&gt;; H=
uang, Ray &lt;</span><a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@amd.com=
</a><span style=3D"color:black">&gt;; Quan, Evan &lt;</span><a href=3D"mail=
to:Evan.Quan@amd.com">Evan.Quan@amd.com</a><span style=3D"color:black">&gt;=
;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><span style=3D=
"color:black">&gt;<br>
<b>Subject:</b> RE: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with=
 video playback (v2)</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Thanks update and verify. Could you give more detail=
 information and error log message&nbsp;&nbsp;
<br>
about you observed issue? <br>
<br>
Thanks,<br>
Prike<br>
&gt; -----Original Message-----<br>
&gt; From: Johannes Hirte &lt;<a href=3D"mailto:johannes.hirte@datenkhaos.d=
e">johannes.hirte@datenkhaos.de</a>&gt;<br>
&gt; Sent: Sunday, April 12, 2020 7:56 AM<br>
&gt; To: Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Lian=
g@amd.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a>; Deucher, Alexander<br>
&gt; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd=
.com</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang=
@amd.com</a>&gt;;<br>
&gt; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@amd.com<=
/a>&gt;<br>
&gt; Subject: Re: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with v=
ideo<br>
&gt; playback (v2)<br>
&gt; <br>
&gt; On 2020 Apr 07, Prike Liang wrote:<br>
&gt; &gt; The system will be hang up during S3 suspend because of SMU is pe=
nding<br>
&gt; &gt; for GC not respose the register CP_HQD_ACTIVE access request.This=
<br>
&gt; &gt; issue root cause of accessing the GC register under enter GFX CGG=
PG<br>
&gt; &gt; and can be fixed by disable GFX CGPG before perform suspend.<br>
&gt; &gt;<br>
&gt; &gt; v2: Use disable the GFX CGPG instead of RLC safe mode guard.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Prike Liang &lt;<a href=3D"mailto:Prike.Liang@amd.=
com">Prike.Liang@amd.com</a>&gt;<br>
&gt; &gt; Tested-by: Mengbing Wang &lt;<a href=3D"mailto:Mengbing.Wang@amd.=
com">Mengbing.Wang@amd.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 &#43;&#43;&#=
43;--<br>
&gt; &gt;&nbsp; 1 file changed, 3 insertions(&#43;), 2 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index 2e1f955..bf8735b 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -2440,8 &#43;2440,6 @@ static int<br>
&gt; &gt; amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)&nbsp;=
 {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp; amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGAT=
E);<br>
&gt; &gt; -&nbsp;&nbsp; amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGAT=
E);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip_blocks -=
 1; i &gt;=3D 0; i--) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.valid)<br>
&gt; &gt; @@ -3470,6 &#43;3468,9 @@ int amdgpu_device_suspend(struct drm_de=
vice<br>
&gt; *dev, bool fbcon)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;&nbsp;&nbsp; amdgpu_device_set_pg_state(adev, AMD_PG_STATE_U=
NGATE);<br>
&gt; &gt; &#43;&nbsp;&nbsp; amdgpu_device_set_cg_state(adev, AMD_CG_STATE_U=
NGATE);<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev, !fbcon)=
;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_suspend(adev);<br>
&gt; <br>
&gt; <br>
&gt; This breaks shutdown/reboot on my system (Dell latitude 5495).<br>
&gt; <br>
&gt; --<br>
&gt; Regards,<br>
&gt;&nbsp;&nbsp; Johannes Hirte<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cxinhui.pan%40amd.com%7Cde6e0578174940b5f29808d7de948b88%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637222601969843248&amp;amp;sdata=3DquWGElw=
%2Fo70VJibuZ7%2BzS%2FcHH2OHSDB%2B5uaFPQUf2Os%3D&amp;amp;reserved=3D0">https=
://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freede=
sktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cxinhui.pa=
n%40amd.com%7Cde6e0578174940b5f29808d7de948b88%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637222601969843248&amp;amp;sdata=3DquWGElw%2Fo70VJibuZ7%2B=
zS%2FcHH2OHSDB%2B5uaFPQUf2Os%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB430770EDDB677F95284387E8FBDD0BY5PR12MB4307namp_--

--===============0888331398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0888331398==--
