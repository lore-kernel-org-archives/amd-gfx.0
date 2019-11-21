Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF3C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 15:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4582063A
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 15:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4582063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B9B6F3DF;
	Thu, 21 Nov 2019 15:58:52 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680055.outbound.protection.outlook.com [40.107.68.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413256F469
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 15:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8cTOPsNKE9bvXqgmgmKk6YNJDn3k2fVwgxbYWFfocX94x21wn21tfz2zCiHqBOwlnC4pgRWq+YN7/xW6bJAJYchUUql4KPN1qtwWVzqLalHXsn3PwRbWyWRsIu3mQa5wjXF+O64RPRnWMGooU+DVWJ3PmHq9GlGeC04bO/iyNffIjShiFM9PrgbB4Z7x/MWsjw8nXCzcffvuscYF74JuQixqKYxpsMd3xFqQIMRaMlE5mM8egwByl3UzHH9LYDfITrAvzK2m7ziKji6lMTMBy/X0mRdNTXiJY74Mh/TNVloP+85WTiPrhOIHS6WMH1bBqGFYcHNwLlFuGOg6hX4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fq4OhbrX9p7/ygSkX2hsDZBWayUStZT4CkZ32DtRCc=;
 b=X9eOE0XaprRvZMiGczZebHN94pLzZCx4tjRz8hysy0JxhVuwFqvCJ+I+N4eSAxPKaP0oHpwkvfxaDg7K59t/C+s45WBsR+Bl4GdMHYMIJuoOQbBFqU2zesdCimXwDpefMEcDQiANCoB6pvwFI93HtgiHOWOOLMHfCnX+pqgd2rlnBI1vxiPQitjH+qqIGfpmzqtx31C2AuQ8UQOhtp0uOjDLpG7e3CHPZNOXje0+61VsBmb/zyK5LmXvrIaV9jEXgpKvgQOHZnzwwZJHDsF1hZSIt85uzsaue1urFiXPFydyihk02pYc2OZsuWed9hqx0MzElAAXLPmFA0jnofk0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) by
 CH2PR12MB4056.namprd12.prod.outlook.com (20.180.5.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Thu, 21 Nov 2019 15:58:48 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 15:58:48 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus
 VF.
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus
 VF.
Thread-Index: AQHVoDNRPUWxG4MvOEeir6J4XVb8g6eVv1cAgAAAY4CAAAimAQ==
Date: Thu, 21 Nov 2019 15:58:48 +0000
Message-ID:
 <CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <20191121061707.25958-1-Jack.Zhang1@amd.com>
 <CADnq5_MrfFWAjC__9ccB46CYzdcLWP=DPKD70aXAm862DJLu1g@mail.gmail.com>,
 <CADnq5_OE8xi7TmgxWe2PiWVxM8pVhxAtYF=CTtT7AHOhrUhEyA@mail.gmail.com>
In-Reply-To: <CADnq5_OE8xi7TmgxWe2PiWVxM8pVhxAtYF=CTtT7AHOhrUhEyA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [112.65.12.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77136842-8fc8-4262-a457-08d76e9bb233
x-ms-traffictypediagnostic: CH2PR12MB4056:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <CH2PR12MB40561A58594CACAA05A7FAF8BB4E0@CH2PR12MB4056.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(99286004)(33656002)(66446008)(4326008)(9686003)(81156014)(64756008)(1411001)(66556008)(8676002)(81166006)(8936002)(2906002)(76176011)(7696005)(86362001)(66476007)(91956017)(74316002)(76116006)(14444005)(256004)(316002)(6916009)(3846002)(71190400001)(6506007)(5660300002)(52536014)(478600001)(11346002)(6116002)(229853002)(54896002)(6306002)(71200400001)(186003)(446003)(6436002)(53546011)(966005)(6246003)(25786009)(26005)(66946007)(102836004)(66066001)(55016002)(7736002)(236005)(14454004)(606006)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4056;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vXSzG+gIaDDJd2ZnR9Z6IR3VY5f/xGr84pSAqRMCJNCZF1lwfQV1bH8gpDA446+wO1wrf0MPsZV/T8Z97w6ut098vMJmCcPa8gZrzWRpRROZEMYwWK45Abi7Lws0QTUggMuG8MwYwshsz2TnnD+7tQQBqFCielO3wjHqMjleITpCAj4rB/X0va6GiW3vbrqUjg2hjC8kVxu5eiPLKYVNblC0jxgnhBiR29DlMxnW9gQ/3SgBo5AcxKp9pUuSsE3TRyBRRkdhp4R+5060Hu20YVDFwegKP1fzOg1vlSIR+wTdVRLQQz44Kh0AiyijXsf/1xpPJOySv1S56ABMeTsZmeqmMIs0V0QHFy5xLRwMOMpTKuDPL9KtjWdu6Id3FU8DVQS2C8/rSD9iBvbpqTW51wae1eSljkQLu1fndp7Awedsc5AgYynCBzdHos2eg23+7Z+VQZ/HtwA6tWbLCyosV+E7T+IHkRqrHuPbbpGrunc=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77136842-8fc8-4262-a457-08d76e9bb233
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 15:58:48.3510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SA3z+4FPyQTf8oDlNFH9Zjdt3BEzwDt2uonbZZgFWQf5zPuFvuTSwBKH/LIAXDwh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fq4OhbrX9p7/ygSkX2hsDZBWayUStZT4CkZ32DtRCc=;
 b=yoyaBbKsF3fePYYIgnLO/nUgRY1+F4s1ZnFbooPT4fgmYSvjwgyMEw2BCwkr85l56iY3CxyZxs1VeKRMiarAVWKADLcnr71ZKaSBzyTbUEx6Pd0ATeCRgKx81ca6kTWLbSbs5tDnTdDJ9FWQfZ7zSSlIvYIyYa0KqyT/BdWPRcE=
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
Content-Type: multipart/mixed; boundary="===============0734607893=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121155848.1mFPSL92hhS2-uYpPtMeM5HgL92uNegXyyoe3v2dIVc@z>

--===============0734607893==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0CH2PR12MB3672namp_"

--_000_CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0CH2PR12MB3672namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Alex for this review.

Both of the two patches will not influence bare-metal code path.

B. R.
Jack

 Outlook for Android<https://aka.ms/ghei36>
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
Z7cjVBcFv5giOTC3uHdE%2Fk%3D&amp;reserved=3D0

--_000_CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0CH2PR12MB3672namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Thanks Alex for this review.&nbsp;</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Both of the two patches will not influence bare-metal code path.&nbsp;</div=
>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
B. R.&nbsp;</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Jack&nbsp;</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
&nbsp;<a href=3D"https://aka.ms/ghei36">Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Thursday, November 21, 2019 11:26:37 PM<br>
<b>To:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for=
 arcturus VF.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Nevermind.&nbsp; I missed the sr-iov check. Patch =
is:<br>
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
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D02%7C01%7CJack.Zhang1%40amd.com%7C62c30b71b3b8490862d808d76e973ae5%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637099468112639673&amp;amp;sdat=
a=3DiC932sWNGrLeexp7wIDdrZ7cjVBcFv5giOTC3uHdE%2Fk%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CJack=
.Zhang1%40amd.com%7C62c30b71b3b8490862d808d76e973ae5%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637099468112639673&amp;amp;sdata=3DiC932sWNGrLeexp7w=
IDdrZ7cjVBcFv5giOTC3uHdE%2Fk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0CH2PR12MB3672namp_--

--===============0734607893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0734607893==--
