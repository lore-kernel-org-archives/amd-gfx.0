Return-Path: <SRS0=jv7P=54=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56370C2BA2B
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Apr 2020 06:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1ED1206B8
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Apr 2020 06:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rxBJUYla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ED1206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 362036E106;
	Sun, 12 Apr 2020 06:58:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D2D6E106
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Apr 2020 06:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5goJ9XjK2lfuSxqVGZUte/KcPYt9Clp+qg3rZ34ok8xjmU9906QfZc2F5PfJxYxlIk6ifUYP7S0sw4cYuUS6PHjKupxC2fs2IddYZr+lShBBkwArZEl2FYOKIwiQumcUEsuJlOinkwpMfbqOHJlDT13h89AsvMY2d9hkRXN5dit46WAtM9bLs9ZvHPtAiL5y0jcujg9CbPZj2rQbK6M4OO6UchInQOvvx6FaqbMv2jPk8kUzdFqwkP/KQrbju8AZrXx/PuKIZc+ExZeF/L2aPRXUPqDG8RYraFuGpLuFJzug5AcEEr8yfB11WUWRV7LQqm3fumj8eyGg9yTdzACjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9n2LUeprXQZMN0GTG0RLR1mL/0KcrGnufv7szJ1lUA=;
 b=nZ63RI2Vt78UELuEipG9hG2aN8LMsPEsJogM9rCF44Dhqv8HCdcDH1SFD0YEmGKNUPjrs3oMVGb9pB7a2QLBgyyeE9gk692rTLuZDhAzub5QQNdQjg5yHYY58VTc8QgCodFh08bR1pQKEiB6Lt56BPAeH7Rr21zegd/+O3FdvXy0k3hlgHZiDabYpjoaf0TL7PFJJeVfZHhc6Yjlj1anJ96Ipi4ptcDAWJgmHCKSUmFygJCEIo9mucGQtuu00zjnzEwNnUobZq43mQQtHENSk2flfWsBISY/aHBJAfZLAjO1N8EKlWog/ikWVVby0keEsffDNHngtCiXcYw8DCBLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9n2LUeprXQZMN0GTG0RLR1mL/0KcrGnufv7szJ1lUA=;
 b=rxBJUYlaAfdCEupsLP2TYdYek//mVu1AsnOWGFxTXej5W7iX7z+u53G79yXQ2bMUB7fitmGfyYqx4m7JkB6KMvlVDwz0fe4F+H7sZ5AAkHWrDd1aIupYC8UdgjWQVl7X9a1GIE0tki8fX+3035q4UVPP8/UCF5qK2pAyHt10ybE=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN1PR12MB2494.namprd12.prod.outlook.com (2603:10b6:802:29::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Sun, 12 Apr
 2020 06:58:30 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::ec5f:a26:8530:3b9f]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::ec5f:a26:8530:3b9f%6]) with mapi id 15.20.2900.015; Sun, 12 Apr 2020
 06:58:30 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: Johannes Hirte <johannes.hirte@datenkhaos.de>, "Liang, Prike"
 <Prike.Liang@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
 playback (v2)
Thread-Topic: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
 playback (v2)
Thread-Index: AQHWDN6T5UHYlsDC3UiXGUPd3pPdsqh0n6QAgABBZ4CAADRpCw==
Date: Sun, 12 Apr 2020 06:58:29 +0000
Message-ID: <SN1PR12MB255854626047504C0AB71A0987DC0@SN1PR12MB2558.namprd12.prod.outlook.com>
References: <1586265256-8824-1-git-send-email-Prike.Liang@amd.com>
 <20200411235534.GA1930@latitude>,
 <BY5PR12MB4307451314528C7285E49C60FBDC0@BY5PR12MB4307.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4307451314528C7285E49C60FBDC0@BY5PR12MB4307.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [101.88.212.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 074e9596-aa17-4596-9b68-08d7deaee872
x-ms-traffictypediagnostic: SN1PR12MB2494:|SN1PR12MB2494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2494FE3C086C9627F9DF7E2A87DC0@SN1PR12MB2494.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0371762FE7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(52536014)(33656002)(66946007)(45080400002)(66556008)(64756008)(66446008)(66476007)(91956017)(15650500001)(54906003)(478600001)(4326008)(86362001)(76116006)(110136005)(966005)(316002)(6636002)(7696005)(5660300002)(26005)(53546011)(81156014)(2906002)(55016002)(71200400001)(8936002)(9686003)(6506007)(186003)(8676002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CxifhRVSUvCd/z7fhzE6xRpWxWDfXHnOkXYOOHVlaCNBdp2DN3nffcBbOk5N9NXgpMkLjzhnoF/0VLWiXMwa9TauhJ/kLlHn9jcGTayOitvHPSJ8SIyy/mh9dJnvgiOoF4OV6SN3BX4udnBiNn444l6c3O3fD+shND2Y3MEMiNi3vVCCNobg3fOHlbQRnxEVeeCu4VMs3oAHLuSvHHsn39cPDw9edTjZawMpd1UajH4Y3pPCvUY55ZoZx+/HLtMzCZ4f9MCU4ixE8j0g+wWQ6/4X4d5HnCqEYyhovE4ZhWrckAbPuKVv62VaE36arRQqO5cffeN7gVPLizWkaWA5a711SYU2SvXDGPA80ixGbmQ5fh84/hYRTN42P5QU52Jla+MaKuDYbA2/4ECLzvb8gnDeLFRPKzXhky7gRr2pBuNsGQPfXvdBublqVSgH9RnAjAmsqTez4q6/MQU+K8sbc98HLscO9N45raPtqt7nnXc=
x-ms-exchange-antispam-messagedata: TDpEyLtwfiF0Rv1svAINhwqZIv8h+GyvrZoxMCp0f3obtVNCYE+hX97QAzDoI94JVkoQipof+EHLLCs/rAutU0P616j1ZyCx/TCBQ839Ct+Og1tIeTx7CXFztsQcmV1sluzY1/V4hKM+PXGmiOigXg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074e9596-aa17-4596-9b68-08d7deaee872
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2020 06:58:29.9976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovKi/Wzz8VUe1eRhFH+A3Xyea8B+tLGmzmHJeDSNS/QjNa3HSoUIU7x8vf1dpGtZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2494
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
Content-Type: multipart/mixed; boundary="===============0020594181=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0020594181==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB255854626047504C0AB71A0987DC0SN1PR12MB2558namp_"

--_000_SN1PR12MB255854626047504C0AB71A0987DC0SN1PR12MB2558namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Prike
I hit this issue too. reboot hung with my vega10.  it is ok with navi10.
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Liang, P=
rike <Prike.Liang@amd.com>
Sent: Sunday, April 12, 2020 11:49:39 AM
To: Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org <amd=
-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video =
playback (v2)

Thanks update and verify. Could you give more detail information and error =
log message
about you observed issue?

Thanks,
Prike
> -----Original Message-----
> From: Johannes Hirte <johannes.hirte@datenkhaos.de>
> Sent: Sunday, April 12, 2020 7:56 AM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>;
> Quan, Evan <Evan.Quan@amd.com>
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
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
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
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cxinhui.p=
an%40amd.com%7Cde6e0578174940b5f29808d7de948b88%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637222601969843248&amp;sdata=3DquWGElw%2Fo70VJibuZ7%2BzS%=
2FcHH2OHSDB%2B5uaFPQUf2Os%3D&amp;reserved=3D0

--_000_SN1PR12MB255854626047504C0AB71A0987DC0SN1PR12MB2558namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Prike<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
I hit this issue too. reboot hung with my vega10.&nbsp; it is ok with navi1=
0.<br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Liang, Prike &lt;Prike.Liang@=
amd.com&gt;<br>
<b>Sent:</b> Sunday, April 12, 2020 11:49:39 AM<br>
<b>To:</b> Johannes Hirte &lt;johannes.hirte@datenkhaos.de&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-gfx@l=
ists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with=
 video playback (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Thanks update and verify. Could you give more deta=
il information and error log message&nbsp;&nbsp;
<br>
about you observed issue? <br>
<br>
Thanks,<br>
Prike<br>
&gt; -----Original Message-----<br>
&gt; From: Johannes Hirte &lt;johannes.hirte@datenkhaos.de&gt;<br>
&gt; Sent: Sunday, April 12, 2020 7:56 AM<br>
&gt; To: Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
&gt; Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander<br>
&gt; &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt=
;;<br>
&gt; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
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
&gt; &gt; Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
&gt; &gt; Tested-by: Mengbing Wang &lt;Mengbing.Wang@amd.com&gt;<br>
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
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cxinhui.pan%40amd.com%7Cde6e0578174940b5f29808d7de948b88%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637222601969843248&amp;amp;sdata=3DquWGElw=
%2Fo70VJibuZ7%2BzS%2FcHH2OHSDB%2B5uaFPQUf2Os%3D&amp;amp;reserved=3D0">https=
://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freede=
sktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cxinhui.pa=
n%40amd.com%7Cde6e0578174940b5f29808d7de948b88%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637222601969843248&amp;amp;sdata=3DquWGElw%2Fo70VJibuZ7%2B=
zS%2FcHH2OHSDB%2B5uaFPQUf2Os%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_SN1PR12MB255854626047504C0AB71A0987DC0SN1PR12MB2558namp_--

--===============0020594181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0020594181==--
