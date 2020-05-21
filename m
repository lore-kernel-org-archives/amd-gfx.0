Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B9CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 17:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79442072C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 17:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yfroc6FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79442072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660C66E1E5;
	Thu, 21 May 2020 17:28:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D766E182
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 17:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlPeBkZyn6xHMWHvs57hqtq+bqQCDXMaitxaksvcK3RZ5qoEu9A2pfSPJD2AWLI6MAFA2NppZvuRdIsPAY95ivASzn8Po7yTh3VTrciuTBe8UZ4nxHZalFT/X0LFogS2alQBcIV7nBtXErrFkgRAsCJgWAizjtISkKW6dJYo+N/8RAfPRbm4EnLTvPfGRngvkbb0D18A3GwnLzmTJQCL3fgWT5Wy/M6Bz6A5vYXQ02mmCRvDSBWI8frrwhAsRSV45TB86T6aj5eFtnS8RhJ7THUE4uliWbO4HUIupSKW0U7Gmc9M25LUjXxSy3c6ftov8G3FVUsEBztddjBve0Ldsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/6dhm71SpEHAQ1spZ7O+5ZE7WhsqmSMlBBMDy39K9w=;
 b=ggCeecH4nyaWaSiQH6ByLr3jRcm18YtUHVb6aWUSy0Fno8x4Alr3valPoDP1iePFVAErDeSPu8sLp/Wp5xsBjj2ihLmNNj9zSm17ForyXZpnRsJaPrf+43QlThnDj88JzI7AmaPvEnrWXKhjoG1a9b06yVL7AR0VoWz7q81tG+XFiyD8kFEfgAxGeMQ+o51/5SiMhRU1gkT8Zxro8Wa0nO+9+heswL1138mRBYny+o8wF5SAx27grSVAIeq4IBcIINk8ofIRkZvhG5QhDz+xPYiIDlc3yLkALpr9m/qhG1G5I93Fg/moqEfWPmrYhdBWqFRaxcmGIM7WYPb6X+Kg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/6dhm71SpEHAQ1spZ7O+5ZE7WhsqmSMlBBMDy39K9w=;
 b=yfroc6FI8tp0ce4Q9x5kTLvjrozbuuZ2AZXgBYStQUT0wKk9HH1LoZ3wV9owbwZ+6DIwyxEz0PQfbkmqCIwkIh3naUwuEVRpuD/MtQnXsJCtFFDtALAocuG4sFbyqjL/FZ++Et1XZ1nYSGvpYejXNra3TuihHbC1ffcY8nCzFM0=
Received: from DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23)
 by DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Thu, 21 May
 2020 17:27:59 +0000
Received: from DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a]) by DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a%4]) with mapi id 15.20.3021.024; Thu, 21 May 2020
 17:27:59 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback
Thread-Topic: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback
Thread-Index: AQHWLiHo2KD/uXAjO0+AvKBaUtrVfqiyxCmAgAAJudM=
Date: Thu, 21 May 2020 17:27:59 +0000
Message-ID: <DM6PR12MB44828392B7F38FE7246B2869F0B70@DM6PR12MB4482.namprd12.prod.outlook.com>
References: <20200519211006.80492-1-alexander.deucher@amd.com>
 <20200519211006.80492-2-alexander.deucher@amd.com>,
 <CADnq5_P_oQgSV5tO16ZFE44b4uGq+MMOhLA+fbV8RBPzLorBng@mail.gmail.com>
In-Reply-To: <CADnq5_P_oQgSV5tO16ZFE44b4uGq+MMOhLA+fbV8RBPzLorBng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-21T17:27:57.703Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f44944dd-316d-46c0-0087-08d7fdac4eac
x-ms-traffictypediagnostic: DM6PR12MB2636:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2636B339EA4A7B6C7D7F4DD4F0B70@DM6PR12MB2636.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WxfjjJke+0GTSxMryFAwjhgPvtXpkns1e8DkAqm73/GQTC1qhHmi2N37qLWDXSnYegvgKM9ZoPKnZ4UiC0F/Hmh5VYyIOFqH4a8taxQoLIb8TgT/9Qc5kidmnDgy22XlOtnSxwyRIg6XC8u8PuabwHBSM+huVEaVYZYOEiFIXijAr//EtM4YzYpL8Gnnsxko3KmIQrcS2OCTsnQNGZ4BwP6P21zVRRFU572QERTci7WirUNGIpQCqHp/or4LvmeXi0rnQ43/9Amp78xYFDWslclkYormaYJYP/WLDN4i+fHWjXMGFMnLqXgNG5fiwfgPJ8cJbKt8cfkEPWTxjWPtBnNe0e0ICCw24T9eJC+U8MvfoBlVwjSX2qQHn38rQsBybf7ax4cCfmzAFuYLc4fbItXBALacUKcXvwImfTmyX3iwnTjtwn4iQv9W2HyxUhAK43ty3/HHGdcKqTuD5qGrORgmYS6JBCkrPjXuMqtgVXw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4482.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(55016002)(33656002)(71200400001)(91956017)(76116006)(64756008)(66446008)(66946007)(66476007)(66556008)(5660300002)(45080400002)(8676002)(166002)(86362001)(26005)(53546011)(7696005)(478600001)(6506007)(8936002)(316002)(186003)(52536014)(9686003)(110136005)(19627405001)(2906002)(966005)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: iSK9EbxXIpmyOw1ZAevwKi0867Yp/d1KGuiZ3GDQGBPxzEgzFHhohZXSf2Rw5vRK7JuWO2wCFlHyHBnXAizPj6dsTYxlKsHlpJJzSMn04N31bLeTZXaBeeKBDStB3DN+YtBl2wGhagNFCngxNDOdssatZoWOynALsC8aHex/70lX4kpbLRczQOJkjcA6EgmiiqTyTesZpCcMwXNO27iU7/1pZIK9iRNi8qWDfguiPNOqW8bWeyCxQKRqRfX39Xribm6wIbcfJ82ze/FzDE+/zJTa+i3VRrmXY+lFwBaqs3vhNXWRQ1iOloRXYY2kqxudntSCUvvarqM5vufI9YepO0pfkg3/hxQ3QCzIR9O79RG/4fYZJ8KKFHYW+jDeA/KkDxmRRPZxIO8JhIUqYh2wH32U6NCEkAQuxsc3/Jr7/wUOgRdbsQGZJfpc/OJDUCYj4ZPLRdxyh2blgat91lKFGT9dsPZsbefreCLTnUSOMmlu7z4WCrKHJ9+E/ZZbbsy7
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44944dd-316d-46c0-0087-08d7fdac4eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 17:27:59.1216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xr9qjeC9JXGmeXosvzgxXoOcYJinftFs7fekevlkd5WJ8mg5OAvmka2hIp8yq/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
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
Content-Type: multipart/mixed; boundary="===============0393318199=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0393318199==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB44828392B7F38FE7246B2869F0B70DM6PR12MB4482namp_"

--_000_DM6PR12MB44828392B7F38FE7246B2869F0B70DM6PR12MB4482namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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
e7ixVI1xDJoWTUsWtk%3D&amp;reserved=3D0

--_000_DM6PR12MB44828392B7F38FE7246B2869F0B70DM6PR12MB4482namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The series are&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Thursday, May 21, 2020 12:52 PM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping on this series?<br>
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
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cyong.zhao%40amd.com%7C1a6de00e60b447bad54a08d7fda76316%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637256767681371342&amp;amp;sdata=3DEWwfgYQt=
OR1TGw6%2BL6w8Cw7Y9e7ixVI1xDJoWTUsWtk%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cyong.zhao%40amd.=
com%7C1a6de00e60b447bad54a08d7fda76316%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637256767681371342&amp;amp;sdata=3DEWwfgYQtOR1TGw6%2BL6w8Cw7Y9e7ix=
VI1xDJoWTUsWtk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB44828392B7F38FE7246B2869F0B70DM6PR12MB4482namp_--

--===============0393318199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0393318199==--
