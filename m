Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884D1C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 17:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29612207F7
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 17:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i4m21sPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29612207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBDB6E229;
	Thu, 21 May 2020 17:35:13 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700069.outbound.protection.outlook.com [40.107.70.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843AA6E229
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 17:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpcS2scMCDIB3O0CRM9qeTiYSj9AB5KOLaAFlyXJJI55NqNrx0xHzhqDMS4+Zco8b2UdSS182QwB3QBjFE6X6KaVa0VOYyNE5qBoSSWxg3mcOVqpovINTpxnd08ZXyLHcBQbA6EaDdgxm9D+tBy91uyB9Hgw7GK2FeOJ8dmho6IfY8qA8m1hPsE5a6yuCzS3JUN4O89+wFsX6sy9hwb5SKP6CCkMYxytUMj7RsLiNpjNAny8As1uyZZOxVsfN5JaMIMvmwABHgxsdX1lpDcbhU+CWrmJq2Q5URgkQJ1riOQC9Hqpp2VQGMB2dNvkpsyXrWVuJcgR8DnA7FFJCJVjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA/P9RSd8tWJGmWUTDzncDqkO2TUVWNDuqQq31mF3Zg=;
 b=AjldHO94bhzpCrHapa1cH5ukd57NEFWatZC7XX2xdv3dWk+gcM36+ZFxdih8NSBUYMKX6WZ1GGqPMWitpGo51J5vtnIc55K39QE+084oNuFrQsAt2VgsPQVHj5a7RBnYq1riGFVEwRowE43ILULjXaCG0Bsa+t4KNmrNbDRVKSRhYVyqXVvfCtGtcST5gTde9WxikPAoSHrSxgMLT6ue776BIPGlEv6c3C1ySq+TGxAfkOQQEeXVLgonLwjR78De8ZbGwva84ViC9AAET2Zx3dtgHB6Flz5QHMRbYvmIKYCNSIs8aFCEteB5hm+1/mlBh2pMgfsE0FORcjSLf0UmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA/P9RSd8tWJGmWUTDzncDqkO2TUVWNDuqQq31mF3Zg=;
 b=i4m21sPxG67RMGZxQ7WMzJhn64l3mcqVSkVPU/qUx4KH1Xk657e62ysIWO53Kmre5ALOf4acKlMGIjPsEqV2AykR9PVEYi7DDRU2X7IhQT1K5rv48/tPloegINKxWG+MbeUtUvomLWkhuw+G4GuA+jciRHrSAuFfEzwFc9WBW/U=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3098.namprd12.prod.outlook.com (2603:10b6:5:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 17:35:11 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3021.024; Thu, 21 May 2020
 17:35:10 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback
Thread-Topic: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback
Thread-Index: AQHWLiHpQYVqA6s8tEq8AH6qQjIokaiyxCmAgAAJ64CAAAHSsQ==
Date: Thu, 21 May 2020 17:35:10 +0000
Message-ID: <DM6PR12MB37210386812382F7396657FC85B70@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200519211006.80492-1-alexander.deucher@amd.com>
 <20200519211006.80492-2-alexander.deucher@amd.com>,
 <CADnq5_P_oQgSV5tO16ZFE44b4uGq+MMOhLA+fbV8RBPzLorBng@mail.gmail.com>,
 <DM6PR12MB44828392B7F38FE7246B2869F0B70@DM6PR12MB4482.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB44828392B7F38FE7246B2869F0B70@DM6PR12MB4482.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2001:56b:3ff4:3a97:0:4a:4587:cc01]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9f2b1de-bc33-4b79-f29c-08d7fdad4ffb
x-ms-traffictypediagnostic: DM6PR12MB3098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30981CC2B7A373B99E3FBC1785B70@DM6PR12MB3098.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FDN5kKmdXlQ5QlR6Co/xSxpwMEiklOPg/G7IlQJu/6y5jJHW8d5V/dexgQfbdFGB4BwB15Lw836Bgu+eg5wDP0EBniPDb1J5YJayScUqCp9Cem8AkwZQjCN4yl2wh+UyQGPHcblbpg9gH3Khg16FgEkBnTy1HejkuKX6q21iDS0mC1VyMn0GKc1INPCEQnOpkYE6cfm7cmJv81pMFajIJoqVt5Gq2orU2wm/IGgKRpgov9DeXpib0+JCrkF7CQkt2BsBHxlSVZY1jFx56RPpFV762aoxd0qsKRLb+o336wYbmuTxU9s3ECcGSpOwi8YpFQFug0rGgEjGy1//Vsh3c0x4D/d2kEcvkoIeq5nmGvU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(66946007)(33656002)(316002)(52536014)(64756008)(66476007)(76116006)(66556008)(9686003)(186003)(53546011)(55016002)(66446008)(7696005)(6506007)(4326008)(166002)(2906002)(110136005)(71200400001)(5660300002)(45080400002)(19627405001)(966005)(8936002)(8676002)(478600001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: My53xTdxu343L1b0/2gWYHEUpmAfzpJIo2OBKgNDlFJ1qIU5PeMTYDB4AL+7+NVpVPz+Hrp4szMOOJ8NaCvDMkwYdoPdNXxLSK3RNwIo7OZAyUDG3eNOPROUyujsoSLhAEc6vUaSYLptu+8UpoyoQWdMPymOZHQ/WxIbAU0yOJZitm82sOKoBdcS/9A7mW5CJYlaGwPBnOaIV//Eq2+aSF1wHvoDPyD+qNNqn3Y07w3nyOFHvBn9xYGf6KdJ6TQlNfyUglUazepQDloncxvK5UhepGlgTognVDZXWxNcdT48mUks6sRh/luyS+wX8Ro8OlgqQ5sgTN8t82UH2qWBm7FdOIOcELWX6rq9Ho3HWJO0XYjU9wCK2k/1DQoV0t70tdxSe2eVoOBfllF3fjhpFWWJy9htdJCm6+KHlmmSXPd8ZY37GqF1ex9pbSrgt307/ViO1z5s3A5SOX4u2hCqZ3v8hqdaUOgxySzfOD0FF6YyHXOCmOJaiUmf/ZsVAL6pvDF3dH44y9eWuvAb7LA16KGD5DPe8t5b1KZgKJCWtoM=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f2b1de-bc33-4b79-f29c-08d7fdad4ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 17:35:10.7756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eoqnOl8VwAt3OI6sAT1VbX+CnKPRiGycBaN+t/vccArxxRm2m/CEAfNstVhq/htN8h8W7/moU3bvMWALVYo7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3098
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============1682029215=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1682029215==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB37210386812382F7396657FC85B70DM6PR12MB3721namp_"

--_000_DM6PR12MB37210386812382F7396657FC85B70DM6PR12MB3721namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sorry I missed this.
Series is Reviewed-By: Kent Russell <kent.russell@amd.com>

 Kent


KENT RUSSELL
Sr. Software Engineer | Linux Compute Kernel
1 Commerce Valley Drive East
Markham, ON L3T 7X6
O +(1) 289-695-2122 | Ext 72122
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhao, Yo=
ng <Yong.Zhao@amd.com>
Sent: Thursday, May 21, 2020 1:27 PM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-gfx@lists.freed=
esktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

The series are

Reviewed-by: Yong Zhao <Yong.Zhao@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Thursday, May 21, 2020 12:52 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback

Ping on this series?

On Tue, May 19, 2020 at 5:10 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> It's not implemented yet so just drop it so the sysfs
> pcie bw file returns an appropriate error instead of
> garbage.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 9c42316c47c0..6655dd2009b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -548,13 +548,6 @@ static bool nv_need_full_reset(struct amdgpu_device =
*adev)
>         return true;
>  }
>
> -static void nv_get_pcie_usage(struct amdgpu_device *adev,
> -                             uint64_t *count0,
> -                             uint64_t *count1)
> -{
> -       /*TODO*/
> -}
> -
>  static bool nv_need_reset_on_init(struct amdgpu_device *adev)
>  {
>  #if 0
> @@ -629,7 +622,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
=3D
>         .invalidate_hdp =3D &nv_invalidate_hdp,
>         .init_doorbell_index =3D &nv_init_doorbell_index,
>         .need_full_reset =3D &nv_need_full_reset,
> -       .get_pcie_usage =3D &nv_get_pcie_usage,
>         .need_reset_on_init =3D &nv_need_reset_on_init,
>         .get_pcie_replay_count =3D &nv_get_pcie_replay_count,
>         .supports_baco =3D &nv_asic_supports_baco,
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cyong.zha=
o%40amd.com%7C1a6de00e60b447bad54a08d7fda76316%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637256767681371342&amp;sdata=3DEWwfgYQtOR1TGw6%2BL6w8Cw7Y9=
e7ixVI1xDJoWTUsWtk%3D&amp;reserved=3D0<https://nam11.safelinks.protection.o=
utlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%=
2Famd-gfx&data=3D02%7C01%7Ckent.russell%40amd.com%7Cb24bbf754a294cc666ba08d=
7fdac5228%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256789747127637&s=
data=3Dm%2BJ73URIHmwFL3IH%2BC%2BSgryLmztoLuXswA33XTFiy90%3D&reserved=3D0>

--_000_DM6PR12MB37210386812382F7396657FC85B70DM6PR12MB3721namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>Sorry I missed this.&nbsp;</div>
<div>Series is Reviewed-By: Kent Russell &lt;kent.russell@amd.com&gt;</div>
<div><br>
</div>
<div>&nbsp;Kent</div>
<div><br>
</div>
<div><br>
</div>
<div><style type=3D"text/css" style=3D"display:none">=0A=
<!--=0A=
p=0A=
	{margin-top:0;=0A=
	margin-bottom:0}=0A=
-->=0A=
</style>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Helvetica,sans-serif">
<div style=3D"font-family:Tahoma; font-size:13px">
<div style=3D"font-family:Tahoma; font-size:13px">
<div style=3D"font-family:Tahoma; font-size:13px"><font face=3D"Verdana"><f=
ont size=3D"2"><b></b></font>
<p class=3D"MsoNormal"><a name=3D"_MailAutoSig"><b><span style=3D"color:bla=
ck; text-transform:uppercase">KENT RUSSELL</span></b></a><span style=3D""><=
b><span style=3D"font-variant:small-caps; color:black">
</span></b></span><span style=3D""><span style=3D"font-size:10.0pt; color:b=
lack">&nbsp;&nbsp;</span></span></p>
<p class=3D"MsoNormal"><span style=3D""><span style=3D"font-size:10.0pt; co=
lor:black">Sr. Software Engineer | Linux Compute Kernel</span></span></p>
<p class=3D"MsoNormal"><span style=3D""><span style=3D"font-size:10.0pt; co=
lor:black">1 Commerce Valley Drive East</span></span></p>
<p class=3D"MsoNormal"><span style=3D""><span style=3D"font-size:10.0pt; co=
lor:black">Markham, ON L3T 7X6</span></span></p>
<p class=3D"MsoNormal"><span style=3D""><b><span style=3D"font-size:10.0pt;=
 color:black">O</span></b></span><span style=3D""><span style=3D"font-size:=
10.0pt; color:black"> &#43;(1) 289-695-2122<b>
</b><span style=3D"">| Ext 72122</span></span></span></p>
</font></div>
</div>
</div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhao, Yong &lt;Yong.Zhao@amd.=
com&gt;<br>
<b>Sent:</b> Thursday, May 21, 2020 1:27 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx list &lt;amd=
-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback</fon=
t>
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
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
The series are&nbsp;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Reviewed-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Thursday, May 21, 2020 12:52 PM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Ping on this series?<br>
<br>
On Tue, May 19, 2020 at 5:10 PM Alex Deucher &lt;alexdeucher@gmail.com&gt; =
wrote:<br>
&gt;<br>
&gt; It's not implemented yet so just drop it so the sysfs<br>
&gt; pcie bw file returns an appropriate error instead of<br>
&gt; garbage.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c | 8 --------<br>
&gt;&nbsp; 1 file changed, 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amd=
gpu/nv.c<br>
&gt; index 9c42316c47c0..6655dd2009b6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; @@ -548,13 &#43;548,6 @@ static bool nv_need_full_reset(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; -static void nv_get_pcie_usage(struct amdgpu_device *adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *count0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *count1)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*TODO*/<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp; static bool nv_need_reset_on_init(struct amdgpu_device *adev)<br=
>
&gt;&nbsp; {<br>
&gt;&nbsp; #if 0<br>
&gt; @@ -629,7 &#43;622,6 @@ static const struct amdgpu_asic_funcs nv_asic_=
funcs =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .invalidate_hdp =3D &a=
mp;nv_invalidate_hdp,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_doorbell_index =
=3D &amp;nv_init_doorbell_index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .need_full_reset =3D &=
amp;nv_need_full_reset,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pcie_usage =3D &amp;nv_get_=
pcie_usage,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .need_reset_on_init =
=3D &amp;nv_need_reset_on_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pcie_replay_count=
 =3D &amp;nv_get_pcie_replay_count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .supports_baco =3D &am=
p;nv_asic_supports_baco,<br>
&gt; --<br>
&gt; 2.25.4<br>
&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Ckent.russell%40amd.com%7Cb24bbf754a294cc666ba08d7fdac5228%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637256789747127637&amp;sdata=3Dm%2BJ73URIHmw=
FL3IH%2BC%2BSgryLmztoLuXswA33XTFiy90%3D&amp;reserved=3D0" originalsrc=3D"ht=
tps://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash=3D"xjEFtKrMG2dK=
psBHq0Na/4GT4aMW/gmzls6zpQLxYyPTEqnECoZleIW6rDtHnXFWhcgn6MhBD9AAW6NCt2BlQNk=
xyuDkWLR4W1R3z0AzwwD5qcqolizRLQYJoevQMDBc0XHrtW696ZsDnN1aZ28J7YS2AJgnpCVPsp=
aZYAi1GJY=3D">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D=
02%7C01%7Cyong.zhao%40amd.com%7C1a6de00e60b447bad54a08d7fda76316%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637256767681371342&amp;amp;sdata=3DEWwfg=
YQtOR1TGw6%2BL6w8Cw7Y9e7ixVI1xDJoWTUsWtk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB37210386812382F7396657FC85B70DM6PR12MB3721namp_--

--===============1682029215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1682029215==--
