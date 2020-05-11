Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546CEC47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 19:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2109F206DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 19:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YJQuufSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2109F206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11616E546;
	Mon, 11 May 2020 19:51:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F3E6E546
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 19:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceWlAxeOrnHkVO9Ncpn3wZ5mJBKfHLQutmlI6dfD+r+d435aPMdnmOmXa7pXHCZjkbmjaCFOyklYfIwr5SCB9faesUsNaHoSA6xs//Hr7yMJE6lbkKDDiFs8IGIqQP2vrZ06WZnIlRMNLu/+ZcWfEVO42lTEUDmhwSdhS6v1as1boFerCuMP4o7ru6u9FgGWuiPPH+Lq4Y395XAc+qv++DUp/NujG6N5DYGibZ4tsqryzpxa3NG87bUEgE7GlFgff8UqYcfM0+q+SpxdGXeyA9R53m1wG5K2MeReklCzXH98v7uaaUXFHwidmQ3BsvhQZIrzD+LDMpvaVDwZzzAJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lcQP7R5YC/h6Pebt77YpSgoKw1KAZiak+NaYBuWkno=;
 b=fgL+LDtZIwxPfiYbKlNlGVnyr187/v8iXvJUQcEy2WYHe/M2S8ng0BTbEYxNPk5xiO4+eOPEb30J7TYwNBdNkOOvMcZxy74ibdDO1PNa6I4hsyI0FNU32MUp/KVBdp3fQYLAyk5cjOu9dmiKDSsOPQdnXYBAm4TSUCqoSC3H0g/ZmSPbwTut3Z597f6tWuBOdFG7wWJolgbohTJ4XixvIkR0GkskwwYCO8P/aGCvUy1c4bWsJThXTW5BXjnAsiszxvppznyJY8GJI0CwfVm1jOUD9aI995dQIUmFo/2fi3ka4M1uh2hJh0qtYe1Gy5DlLEkGhwabQRTsa316D2tH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lcQP7R5YC/h6Pebt77YpSgoKw1KAZiak+NaYBuWkno=;
 b=YJQuufSmYpCWICecN07AWDQD3uWkSZ8q3nfhRFFlPPe2900xo9dKgA5dI2HLyipl+g5WgZOOwL4DliRl2r/B8axuosiJFrUAUY+428FkIzHcynrNEoCRR3CEUTW59rfxOLQgTrWB0XJh8y7oQr1U51/B6arF5SjCxEIUUZjYW+4=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Mon, 11 May
 2020 19:51:28 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::758f:7609:b573:448d]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::758f:7609:b573:448d%6]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 19:51:28 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Ma, Hanghong" <Hanghong.Ma@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Update update_config() logic
Thread-Topic: [PATCH] drm/amd/amdgpu: Update update_config() logic
Thread-Index: AQHWJ8s/GfiXjTPvhUO3pSrXd/MaJKijShQAgAAAnICAAACuyw==
Date: Mon, 11 May 2020 19:51:28 +0000
Message-ID: <MW3PR12MB45540F656CDB3770F88C964DF9A10@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20200511192853.11150-1-hanghong.ma@amd.com>
 <8954f030-f222-60d0-21ad-bb7155c67440@amd.com>,
 <SA0PR12MB43493D1ED5333EFF4170B001F1A10@SA0PR12MB4349.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB43493D1ED5333EFF4170B001F1A10@SA0PR12MB4349.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-11T19:51:28.089Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d235425b-c32b-4998-112b-08d7f5e4b21b
x-ms-traffictypediagnostic: MW3PR12MB4474:|MW3PR12MB4474:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB4474F050086D2BDD2C0EFD98F9A10@MW3PR12MB4474.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YCGTyxXWblTdb1h0HNRh1SF/KVH3nGFZE+MNYW7+HHhxw3FSWynZ4KkmWCYIrWR1+aD0bxgiDgW5Hr/iDyZBqJB0jfC5xeDGbdOkh0jHFT/VBI1MYtMfv3OXvymiml5dVx4zDsilkmTxr+rMdRV7He5Xm7C6loPOuJm4BhxTf5vZ2T8Uzfiaejw9tAJaeTYMD6gtQcqj48ziGSTC+Nxb2TPG8hAZgFEOBz3fynmcya5dCnn7V8NWzNsuwstZuKAtFZYJM0tNNQRUzUaTv7iUcBIFkoHhlfThEB/KjM2JRK34pbrcZ4aCrCf+LZ25hNmkH9vfJZ+kpuDh/JwC0Q73pv8DGEeJQdg3vXwf2+n9uB/uRQO5tyULu5yxxJ3FcJh4GKVH3VznaQhCkT3M7ziDAefa+CeTck7Myy1UTjxa9WIBaH0D/n+OFarcibZ+LHOII8WiuvP5LHke9sORmX/AMw7N2pXUdeqZV72tX+kc6WwCYl1Fp433RDpQwBHXBPwkJXKsRr+6DlVvSVWeO8Pbvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(33430700001)(6636002)(186003)(86362001)(2906002)(33656002)(91956017)(26005)(76116006)(316002)(52536014)(7696005)(71200400001)(66946007)(8676002)(19627405001)(9686003)(110136005)(5660300002)(33440700001)(66556008)(64756008)(66476007)(66446008)(478600001)(55016002)(4326008)(6506007)(8936002)(53546011)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: a6vSxm9nAoaRxxFxjxuncNMwUeMKm0Sf2C3WDbVz5wAe2GJPbUlHmYIipKNuCmigkgnVW50VDphQBOjQFYhOu4K+UykswkM8T4jRm+ItWhrgwCX+M4B9fE56kg20BKR4eWAFGFp5WzlisF8/e938q011kcgnQl78df+NQxPphWSkFFH54wZ6wreaUBURDp3LYNDYXLckmic64S+uZoBuwcRuyrV5aGaEbmqpTFmMyypch3dtPz3FE9smbA8UymxHgzmaj4oQ/jkzyMD/agwNFVl3Ro89xPskG8/9Cohva78QgaN04FsIp+haCe0yovx0KXl5iNQDLWrdKTBQFrEyM46Xf0uBXHxHpT+aUAsZsBmNJtoBw2jlu7w5rU2nDFACDv+/IbJOK3cdc8IgmAGCOfYUAXHv2JcIf0Md+pA7kRWneiBzrPu9MXhXNdjTkbeu5Cavb6JWWAClPSZ5yd+LGo70h2O6ylKirALxcNi3sipMT3FP5KwbaX5vEInnf7Op
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d235425b-c32b-4998-112b-08d7f5e4b21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 19:51:28.3759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvNdfkOOfXbDRbGDBakX8kpVrHfEXMHTD0OfFpyYuG7oR3RCi3EdmpudgzUcvSwg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0826589850=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0826589850==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB45540F656CDB3770F88C964DF9A10MW3PR12MB4554namp_"

--_000_MW3PR12MB45540F656CDB3770F88C964DF9A10MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
________________________________
From: Ma, Hanghong <Hanghong.Ma@amd.com>
Sent: May 11, 2020 3:48 PM
To: Wentland, Harry <Harry.Wentland@amd.com>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Update update_config() logic

[AMD Official Use Only - Internal Distribution Only]

Thanks Harry.
I will drop the Change-Id before merging.

-Leo

-----Original Message-----
From: Wentland, Harry <Harry.Wentland@amd.com>
Sent: Monday, May 11, 2020 3:46 PM
To: Ma, Hanghong <Hanghong.Ma@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lak=
ha@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Update update_config() logic

On 2020-05-11 3:28 p.m., Leo (Hanghong) Ma wrote:
> [Why]
> For MST case: when update_config is called to disable a stream, this
> clears the settings for all the streams on that link.
> We should only clear the settings for the stream that was disabled.
>
> [How]
> Clear the settings after the call to remove display is called.
>
> Change-Id: I8235998b8fac3d58d24edf86bb5d7cc030f1e375

Please drop the Change-Id before merging.

> Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 10
> +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 78e1c11d4ae5..dcf84a61de37 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -398,15 +398,15 @@ static void update_config(void *handle, struct cp_p=
sp_stream_config *config)
>        struct mod_hdcp_display *display =3D &hdcp_work[link_index].displa=
y;
>        struct mod_hdcp_link *link =3D &hdcp_work[link_index].link;
>
> -     memset(display, 0, sizeof(*display));
> -     memset(link, 0, sizeof(*link));
> -
> -     display->index =3D aconnector->base.index;
> -
>        if (config->dpms_off) {
>                hdcp_remove_display(hdcp_work, link_index, aconnector);
>                return;
>        }
> +
> +     memset(display, 0, sizeof(*display));
> +     memset(link, 0, sizeof(*link));
> +
> +     display->index =3D aconnector->base.index;
>        display->state =3D MOD_HDCP_DISPLAY_ACTIVE;
>
>        if (aconnector->dc_sink !=3D NULL)
>

--_000_MW3PR12MB45540F656CDB3770F88C964DF9A10MW3PR12MB4554namp_
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
Reviewed-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ma, Hanghong &lt;Hang=
hong.Ma@amd.com&gt;<br>
<b>Sent:</b> May 11, 2020 3:48 PM<br>
<b>To:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Cc:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/amdgpu: Update update_config() logic</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
Thanks Harry.<br>
I will drop the Change-Id before merging.<br>
<br>
-Leo<br>
<br>
-----Original Message-----<br>
From: Wentland, Harry &lt;Harry.Wentland@amd.com&gt; <br>
Sent: Monday, May 11, 2020 3:46 PM<br>
To: Ma, Hanghong &lt;Hanghong.Ma@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawan=
preet.Lakha@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Cc: Wentland, Harry &lt;Harry.Wentland@amd.com&gt;<br>
Subject: Re: [PATCH] drm/amd/amdgpu: Update update_config() logic<br>
<br>
On 2020-05-11 3:28 p.m., Leo (Hanghong) Ma wrote:<br>
&gt; [Why]<br>
&gt; For MST case: when update_config is called to disable a stream, this <=
br>
&gt; clears the settings for all the streams on that link.<br>
&gt; We should only clear the settings for the stream that was disabled.<br=
>
&gt; <br>
&gt; [How]<br>
&gt; Clear the settings after the call to remove display is called.<br>
&gt; <br>
&gt; Change-Id: I8235998b8fac3d58d24edf86bb5d7cc030f1e375<br>
<br>
Please drop the Change-Id before merging.<br>
<br>
&gt; Signed-off-by: Leo (Hanghong) Ma &lt;hanghong.ma@amd.com&gt;<br>
<br>
Reviewed-by: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
<br>
Harry<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 10 <br>
&gt; &#43;&#43;&#43;&#43;&#43;-----<br>
&gt;&nbsp; 1 file changed, 5 insertions(&#43;), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c <b=
r>
&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
&gt; index 78e1c11d4ae5..dcf84a61de37 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp=
.c<br>
&gt; @@ -398,15 &#43;398,15 @@ static void update_config(void *handle, stru=
ct cp_psp_stream_config *config)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_display *dis=
play =3D &amp;hdcp_work[link_index].display;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_link *link =
=3D &amp;hdcp_work[link_index].link;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(display, 0, sizeof(*display));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(link, 0, sizeof(*link));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;index =3D aconnector-&gt;base.in=
dex;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (config-&gt;dpms_off) {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hdcp_remove_display(hdcp_work, link_index, aconnector);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; memset(display, 0, sizeof(*display));<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; memset(link, 0, sizeof(*link));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;index =3D aconnector-&gt;bas=
e.index;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display-&gt;state =3D MOD_HD=
CP_DISPLAY_ACTIVE;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aconnector-&gt;dc_sink !=
=3D NULL)<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB45540F656CDB3770F88C964DF9A10MW3PR12MB4554namp_--

--===============0826589850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0826589850==--
