Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE92C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 16:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0239E20637
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 16:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0239E20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99DF46F469;
	Thu, 21 Nov 2019 16:05:04 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820077.outbound.protection.outlook.com [40.107.82.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696626F3DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 16:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrCBmqaY6CX1+D8h+LPApnR7nZfAOjd7eMx0EoL4OnX2IfnjEiuaXXd1ud0aHDV68uKSGgVwki9azvg00s/i7B/t2TkWDP+/RejGJzSSyvqnD0BLDgthTFBuq3LAaxQcE+yMhX4iK5RZAxmsj82VV2mlSBVzM9ETUwWjwRSKuIp0npgRtYopy+41GqAUJLYp3hNmgHX8amfciMTcTP4StT8kpX+7j5PUxXvEgOtt8DQKvsdHLblEW+RQx6l/xf/PXK1UxP8PKN7/uLEZFwaYt3V66P5aGnGlH9lGgi+dZngDWRwnoAPT/v3PCs3Dxrb0r1qKEDDMVMp7K0ozZK1g0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFdWCuHcSU90n59hCa1voy+awF84qB/dHfA51VOk1q0=;
 b=FZuAG9ZokT8bqBR4JOb+NuQZ5dxG9540tmdpq5Tv3F5PZweKDgd+1cmZicrCZdlLoFYwnUmSjdFeo/r13GgblEW3hXReDheoWqcLc310N2crQOEk/wy/SU0IrCLcGQbLNP81Ywbe5v/hd/HmyysbNj53Ht4XfAcNpc1KKPORYQ2j+B754VHwU9EJ2bZ6ctM4Wq0gAQ5Mdj+dzTQ9pC3DSxZhZrtxFDIr2/6si/f423cJvSfqWib1E0J0veuwhw0M0H9wgXSs2yv4XvAW0ppbW/kYIHX6TOwaUqZgYPOp5GgKg3AELmrwD/+k8ajE0Ky7VySPZpSZdgqPfQ8Kn2zcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) by
 CH2PR12MB3749.namprd12.prod.outlook.com (52.132.245.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 21 Nov 2019 16:04:56 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 16:04:56 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus
 VF.
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus
 VF.
Thread-Index: AQHVoDNRPUWxG4MvOEeir6J4XVb8g6eVv1cAgAAAY4CAAAimAYAAALIAgAABOlo=
Date: Thu, 21 Nov 2019 16:04:56 +0000
Message-ID:
 <CH2PR12MB3672D4DEA34F52AB2A5AF444BB4E0@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <20191121061707.25958-1-Jack.Zhang1@amd.com>
 <CADnq5_MrfFWAjC__9ccB46CYzdcLWP=DPKD70aXAm862DJLu1g@mail.gmail.com>,
 <CADnq5_OE8xi7TmgxWe2PiWVxM8pVhxAtYF=CTtT7AHOhrUhEyA@mail.gmail.com>,
 <CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0@CH2PR12MB3672.namprd12.prod.outlook.com>,
 <CY4PR12MB181333EBFDD75B8664F319CAF74E0@CY4PR12MB1813.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB181333EBFDD75B8664F319CAF74E0@CY4PR12MB1813.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [112.65.12.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c710c29-6ec9-4f66-972e-08d76e9c8d8b
x-ms-traffictypediagnostic: CH2PR12MB3749:|CH2PR12MB3749:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB374945DB968946E71A71F9B9BB4E0@CH2PR12MB3749.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(66066001)(54896002)(6306002)(7736002)(4326008)(66446008)(606006)(19627405001)(99286004)(64756008)(9686003)(5660300002)(66556008)(236005)(66476007)(52536014)(66946007)(6246003)(45080400002)(74316002)(966005)(478600001)(186003)(6436002)(102836004)(256004)(14444005)(33656002)(81166006)(81156014)(8936002)(7696005)(8676002)(446003)(25786009)(11346002)(14454004)(76176011)(6506007)(229853002)(53546011)(316002)(2906002)(6116002)(3846002)(55016002)(86362001)(91956017)(76116006)(110136005)(71200400001)(26005)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3749;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ibiWnce358vgOJkDvRs9xSnfLjIgXcyCOcuKbjCXm0xzpps73ACDVM7ZtqOlZGPrUmkmU6ayn2EedtqwfMfHPrO0F9S3tJKrwk6MLodXy8GQFSmXyAahg8UUokGYSMQXczpcvGN1BeQGe6fpiofNOxmBf52CMBKGEzf5jOo1d2smirEQ5vmGgsYyWRnCCrAp3qNLH12zTeu/+pqW63nKZAIGAMMg+3n3ssg0leJoYs4XW6vhXP4IRCvkEN91K9KmxNKAfsifu22jmks3NgBOJY4Jjquy98aoSQj77wh1a04dUCUGPYTn7a4/Bw4hR2+P0E8yECjh5gAxodosSxMneP8UcnUjsIrRPPDSVDXZndHzam/bI40Xkx3djvfYi1q/tIFxreRgm2n1EbLDc3JN3p257rLpP70rNqJ90qmKraBzKef6omhB811mBIQc2mU2Ag/CJ6DM6dxSZYAfiMqOAxItW/0A/1iPwgki2qoNDLE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c710c29-6ec9-4f66-972e-08d76e9c8d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 16:04:56.3394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xAoK0OOId+40bV9SnVxIooc43LQwLJQGkyxytJ2vb5bR2fwQTPvVil9k6JTRSpr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3749
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFdWCuHcSU90n59hCa1voy+awF84qB/dHfA51VOk1q0=;
 b=gU1KDEu3rIBVRkmhh4RYgtRX2lszjJ3pPRguscuycJMEkKllWIcL2weRGvAQf474fmnwOOpxP9ig+3ru0p9nx6vvcetQ9we9Sg0nwzYmTCe3VU334ggjU4BgZdZrD3yrtCVRCVE0siMeLLGblRFw908FlA34YJ2P08p0Q9N2ZRs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
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
Content-Type: multipart/mixed; boundary="===============1355808043=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121160456.ERjlLPuxuY0_g12BkwIjpobSMzuHowjOlYsBUbxy2Oc@z>

--===============1355808043==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3672D4DEA34F52AB2A5AF444BB4E0CH2PR12MB3672namp_"

--_000_CH2PR12MB3672D4DEA34F52AB2A5AF444BB4E0CH2PR12MB3672namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Sure=1B$B!$=1B(Bwill do that=1B$B!*=1B(B

Thanks=1B$B!$=1B(B
Jack

 Outlook for Android<https://aka.ms/ghei36>
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, November 22, 2019 12:00:04 AM
To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Alex Deucher <alexdeucher@gma=
il.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arctur=
us VF.

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

--_000_CH2PR12MB3672D4DEA34F52AB2A5AF444BB4E0CH2PR12MB3672namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
</head>
<body>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Sure=1B$B!$=1B(Bwill do that=1B$B!*=1B(B</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Thanks=1B$B!$=1B(B</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Jack</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
&nbsp;<a href=3D"https://aka.ms/ghei36">Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Friday, November 22, 2019 12:00:04 AM<br>
<b>To:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;; Alex Deucher &lt=
;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for=
 arcturus VF.</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
You can have my RB on the first patch if you fix the compiler warnings.</di=
v>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Zhang, Jack (Jian) &lt;Jack=
.Zhang1@amd.com&gt;<br>
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
<div id=3D"x_x_ms-outlook-mobile-signature">
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
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;=
alexdeucher@gmail.com&gt;<br>
<b>Sent:</b> Thursday, November 21, 2019 11:26:37 PM<br>
<b>To:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for=
 arcturus VF.</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">Nevermind.&nbsp; I missed the sr-iov check. Pa=
tch is:<br>
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
</div>
</body>
</html>

--_000_CH2PR12MB3672D4DEA34F52AB2A5AF444BB4E0CH2PR12MB3672namp_--

--===============1355808043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1355808043==--
