Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D0BC388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 19:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D01820BED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 19:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cSrYBLzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D01820BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAD06E593;
	Fri, 23 Oct 2020 19:04:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EAD06E593
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 19:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcVxeDr6ZhsbVCmfOiD6Jua1WGkL74Wn675TBxDPwSO929PNkHmV/tfiCI6sBvmcCicY6H3EUD6tz4nhFPbZZjLK9ycqQWHmN2Bf1GuZgtZlFAdJfpPUKrBInykn2yk6GnIHgWg2QpNfoWxC45K+nc/ulRLj3iS50Ol3V/2AmF7T70Wb5VSnWkUdvlTSR8bNmMgEdiysGhqSJqYSKbDQjqctw4sYDpEsvg0rjkEdJnB+/58F0fQnqpjdd4uXEi+opgQn6rrYBSJKymJW6/ZohT1Z/imYGxQTpfI8lJNu1KnjnL2RYGv89RCZhvjbf9vlDmW1PusKB5CultnuP9Z9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9/KNdziQ/UtQu3at/rKTmX04FyjdYhrg03WSOS3PdQ=;
 b=PH5LSpJzfjRHDqJz3LGvfc1YcjtHftOZivNVUozGJfvx8vKNODRcpDk+I5gXmhwSHPIRQoJRpr5LgTCdy4bvwqA8G+1P10ZcpdgrqLzAaqGUT1KD2/3VhL8mHjvXj+yuyE1lg3PwX/5NBuSTG3he4SXLVensRnCJI3oA1uHJzfM0o5LTZJ+lNGyfBklPvNmBL9uKibIyuoDs/dj8iDPGeEl2+iGgup/bRlSFy8qNLR/gcyldDs/NuMGkfYSOCzHhe+e+t68t84BjiLPxehBxy0ojzxURb3TqWdveGCfUVuu0EIE7MYE4G4JsFeZdeC2TPyP650w+3xlZvvJBysxL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9/KNdziQ/UtQu3at/rKTmX04FyjdYhrg03WSOS3PdQ=;
 b=cSrYBLzuLSMe8M8om/9ruPjB3LGFvBQrGdD/unXbHjo+5aAsJblGEkaEesmAsWdyW6R2fqbSOk2uJ54wkZZ3zX9RRHLOJZ4JjmGKGQlpf6K28aJ7Gp6biQvYNy4jHyEEOyzIlQVvZi7qLgtWefnpCZcYED5li3EUDC6sVuO8zkU=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 19:04:30 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::e4c8:2ab4:50ae:be6b]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::e4c8:2ab4:50ae:be6b%8]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 19:04:30 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fixed panic during seamless boot.
Thread-Topic: [PATCH] drm/amd/display: Fixed panic during seamless boot.
Thread-Index: AQHWqV87rFRclVb/ukisw4XFjBiNZKmli+h4
Date: Fri, 23 Oct 2020 19:04:30 +0000
Message-ID: <MW3PR12MB4554E2E73641155FDFBC3B24F91A0@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20201023170906.32112-1-aurabindo.pillai@amd.com>
In-Reply-To: <20201023170906.32112-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-23T19:04:29.658Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ca43405-4cc7-47a5-ca5f-08d877867880
x-ms-traffictypediagnostic: MW3PR12MB4556:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB45568D303DB6ECCFBEB5A6E6F91A0@MW3PR12MB4556.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EaA5XLjsQPzWfPSgr7cdQybfAefwB1hYp1Xxo1eZjx6DJbDH3VjTYg+epSAQdLQVT75g+kd7ERxvZ3ZKjVya136luees6nA+lr9cTl7chIR5B3nZRlaTcWeD79B+t5UWiT9KgaJT1yMeZDx02lwgOk4qaEEV0w7IczozVkpK8jvA/oqYgtQvO673WP8yxOf0YbwU/GIRou/blmhV4Ox6pfM5evABuLZkbnPF3fFGoMx8RrkJKA5Bf6FFR0TpRhUw+YIByOpLtpWhfziVfdTFwSuErUISFyyTa/2LXHsccaFPWbvqMccfkWYzorNcNEcVa4ydDvuEFcUUBdYQ/CNZkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(7696005)(316002)(110136005)(2906002)(71200400001)(83380400001)(86362001)(33656002)(4326008)(8676002)(26005)(53546011)(186003)(9686003)(55016002)(478600001)(8936002)(6506007)(76116006)(64756008)(52536014)(5660300002)(66476007)(66556008)(66946007)(19627405001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: jUd2HF526t1rVCM01Clbg7CPbINhUfp5pKNdIkCzMC4jCwyc2h71/Vei83El7gf+bZjxuIJ/rtQhiKRamZhmsco8nw6ma8fJgQRjxrr5/I7xqekK6CaX3NysxhuUEqkwCX1gnDaauTtXQ28u/toOGiCkhCj371qXWgTw6Cdx8j85AdTEMH2bZyN2HpJUaDlZ57UCGJE+sUz1DzTWI8wb8O0gShPJLCx8TUtRU59pk3MvP3GOi0Io4zzRIrCfWKKj/AO/bNLNggGsa05KzOTBizMjh28YDzrJsDEDWVPL05/zQHqkPk+Ui1N8uoWwrp66FQ/RUc+ikmE70jDdlxsKaWt2J73qg74zq15vu2ISzhDwS9WGVfWZeGu+ZV4j6mdx4e0TxOYyTed4ThLrUSo5attKF+tXf6y0Lnny23Nbne3bN6Ryrds8Pg0aGoWjv7QhAc65GgmRmgkzmpGOJxC3PusYqzFUv/AvWOOnQk9eiLn7Ydqjykz3sZlTGOcgEAQY2/dz7Nr15QrHBTAwxQT9faIK4tO49vO5oeA+ij392cqAlmUyrD3lBwXZ7nFeJK8zSmt7NOAmHtXFL8yhdkXBZg5JtdI9+fBa4sSLJRaWb4gwomNSy/Bn9QWsP9dOCFhKpKrSXXsX2xYan5HtJ62Jtg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca43405-4cc7-47a5-ca5f-08d877867880
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 19:04:30.2719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ez9uD/L58cErG7Z5p331SKGf9wTTOj5CUFCmlux/7f8TcKui0W20alJHKtgHxNEe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
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
Cc: "Galiffi, David" <David.Galiffi@amd.com>
Content-Type: multipart/mixed; boundary="===============1899260407=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1899260407==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4554E2E73641155FDFBC3B24F91A0MW3PR12MB4554namp_"

--_000_MW3PR12MB4554E2E73641155FDFBC3B24F91A0MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
________________________________
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: October 23, 2020 1:09 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Galiffi, David <David.G=
aliffi@amd.com>
Subject: [PATCH] drm/amd/display: Fixed panic during seamless boot.

From: David Galiffi <David.Galiffi@amd.com>

[why]
get_pixel_clk_frequency_100hz is undefined in clock_source_funcs.

[how]
set function pointer: ".get_pixel_clk_frequency_100hz =3D get_pixel_clk_fre=
quency_100hz"

Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 512b26b3e3fd..589c7fb71480 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1149,7 +1149,8 @@ static uint32_t dcn3_get_pix_clk_dividers(
 static const struct clock_source_funcs dcn3_clk_src_funcs =3D {
         .cs_power_down =3D dce110_clock_source_power_down,
         .program_pix_clk =3D dcn3_program_pix_clk,
-       .get_pix_clk_dividers =3D dcn3_get_pix_clk_dividers
+       .get_pix_clk_dividers =3D dcn3_get_pix_clk_dividers,
+       .get_pixel_clk_frequency_100hz =3D get_pixel_clk_frequency_100hz
 };
 #endif
 /*****************************************/
--
2.25.1


--_000_MW3PR12MB4554E2E73641155FDFBC3B24F91A0MW3PR12MB4554namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Aurabindo Pillai &lt;=
aurabindo.pillai@amd.com&gt;<br>
<b>Sent:</b> October 23, 2020 1:09 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Galiffi, D=
avid &lt;David.Galiffi@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fixed panic during seamless boot.<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: David Galiffi &lt;David.Galiffi@amd.com&gt;<=
br>
<br>
[why]<br>
get_pixel_clk_frequency_100hz is undefined in clock_source_funcs.<br>
<br>
[how]<br>
set function pointer: &quot;.get_pixel_clk_frequency_100hz =3D get_pixel_cl=
k_frequency_100hz&quot;<br>
<br>
Signed-off-by: David Galiffi &lt;David.Galiffi@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driver=
s/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
index 512b26b3e3fd..589c7fb71480 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c<br>
@@ -1149,7 +1149,8 @@ static uint32_t dcn3_get_pix_clk_dividers(<br>
&nbsp;static const struct clock_source_funcs dcn3_clk_src_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cs_power_down =3D dce110_=
clock_source_power_down,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_pix_clk =3D dcn3_=
program_pix_clk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pix_clk_dividers =3D dcn3_get_pi=
x_clk_dividers<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pix_clk_dividers =3D dcn3_get_pi=
x_clk_dividers,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pixel_clk_frequency_100hz =3D ge=
t_pixel_clk_frequency_100hz<br>
&nbsp;};<br>
&nbsp;#endif<br>
&nbsp;/*****************************************/<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4554E2E73641155FDFBC3B24F91A0MW3PR12MB4554namp_--

--===============1899260407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1899260407==--
