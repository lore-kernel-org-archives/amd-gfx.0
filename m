Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB7BC388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 19:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF45620BED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 19:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h5TXIQFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF45620BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC8266E595;
	Fri, 23 Oct 2020 19:10:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4082E6E595
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 19:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwD7wHC/+jmQSvk7Se8ycF63WQSxUFj54uhFiDwu1OJq3S4wFr1+Wfbc/uDNJdgExH8KKMkUb30n/k/9t4wxH5JPjeFM8EsQiw151CWK5vkmTmqolZqoSLmDEObjRjEtdmcmPHIS/jrQPTsTteNwz23s061IlDGXILHj9DnHupsd7fCP5DBFoNYGV+7zYrQBuUNPO4rZ9Jgvk4Jz1BL1lRiYrBJTpASVFU42ROiMV1t9VSvxT4Q25Rt1hzhf0Tugh0IRclzHQKk4yQmp+s8O38m+iPgY04iu0X8Fzqnk8cfrYIhDvfsOje+zpDM4Ct0lgOOVuzztXdIamoA4pj8Eng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfoIw3utbhTMR25GJLFjc7knNmMy/Tb//V5wwpxiWBg=;
 b=isoGvzHHek9eBeT6WYTpq1fguoKxUaIN/UfhcxupjpJ1Xn/efwA/xKzEDoL7acgsSGKKpy+/hiecflJLXGQHeezSbzqZZsw8EDaipKx3WTClrFSTcRwZScp1KZB7KcCpbyRQS8HljJphKW3vGbwZkSu4Q/8gmDmEAdtSH9EIhPiYgMaKoieP1vpVnNo0Oam3uSF1F+8PPZXVkjd/t1ZYKqPFo6PvnT7U9GVq45NKMjcT5XHOwcRo1K8SbxQRW0RqLrZqG4S8IvFv7RmyC7UEI3tv0iLbKrABaxxEWd8IDPvDrOyVjTIKnMYoOJYjqIPjq9MxrNBA8maAXG6sq2A1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfoIw3utbhTMR25GJLFjc7knNmMy/Tb//V5wwpxiWBg=;
 b=h5TXIQFULMyIXefyPi4a8AivDdQ/6NvQyrwT1pflsNgg1lFnwih0hRK1qJ6AnlK765MHWe8lM/Q3JbvNt8hQWpvINMu3KTk+NuvGzrrazO3ZUgkMtcN0Ty4Mf+nWvnj1WxwtRSC6x4pfCsrOSib0jALVFOfCQFuPS83kJ9Azlfc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3381.namprd12.prod.outlook.com (2603:10b6:a03:df::30)
 by BYAPR12MB3335.namprd12.prod.outlook.com (2603:10b6:a03:dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 19:10:36 +0000
Received: from BYAPR12MB3381.namprd12.prod.outlook.com
 ([fe80::84a1:39db:be95:7739]) by BYAPR12MB3381.namprd12.prod.outlook.com
 ([fe80::84a1:39db:be95:7739%7]) with mapi id 15.20.3477.029; Fri, 23 Oct 2020
 19:10:36 +0000
Message-ID: <20b5f608e4f9196526b91e3060c6458e589c54f7.camel@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fixed panic during seamless boot.
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Date: Fri, 23 Oct 2020 15:10:26 -0400
In-Reply-To: <MW3PR12MB4554E2E73641155FDFBC3B24F91A0@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20201023170906.32112-1-aurabindo.pillai@amd.com>
 <MW3PR12MB4554E2E73641155FDFBC3B24F91A0@MW3PR12MB4554.namprd12.prod.outlook.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN1PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:408:e3::8) To BYAPR12MB3381.namprd12.prod.outlook.com
 (2603:10b6:a03:df::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.4.62] (165.204.84.11) by
 BN1PR14CA0003.namprd14.prod.outlook.com (2603:10b6:408:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 19:10:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96bc34c5-1c83-4c1f-1255-08d877875267
X-MS-TrafficTypeDiagnostic: BYAPR12MB3335:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3335054502F644D5467ED2A68B1A0@BYAPR12MB3335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1B75eEwPw7x/IgrClnivirlnXeF/NMITLD6tikSSnan0mQ0suo7RH7QQc4Un2v1iZzBCXtsepw8CqxgcvjNtS2fdMIj1JEGBWQPZH+asqeS3yzJ5THamojlR1M2KOMucKm0ub0yScLf46kZBE1McHwvRHNyOz/cC4nWn5c5Cn41Af4qZDjtwXat+Jo6tWFWDQqGc6M59PIIaxJtvKPx4PKuJvkyFVWFLVBEEwwaLKNC73Z98gZnVaztl2rWp+Av+k35sLOpvbGV1PDxqx+UrvvzHSQLz+5dbigFYRIfQLoxFKZre9fgRHPdb6dDk36zmqLQz57RvdFOQXukKDnzm6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3381.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(44832011)(83380400001)(316002)(6666004)(110136005)(2906002)(36756003)(6486002)(21480400003)(16576012)(19627405001)(52116002)(5660300002)(8676002)(86362001)(66476007)(26005)(956004)(2616005)(478600001)(66946007)(53546011)(33964004)(8936002)(66556008)(16526019)(186003)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4y2aXOSNjch2CRRKk/i/ynbsf0XfFOhBjZhvyXf55n+eObk01bfulE3lKXUGrHmke+6O30HytJAGc9v8DDdTNfgSOM14dbAiD7A9TY0CkZBxZZ0O2vj7iQz9le7YjIsNePNk+6mF5puu8isvP66pBWuF4LwBRr3K06nxaJO2dun8H6/M7mp1xt9AHS3y2FELN4WTp8QmlpsNGlRsvYIM6LopudAMgkUvDuSzI9cF1XGOXhxr6Yp2CMu4Qy5a1dV81wvYnZ1WutbZknc+cLj0w1YkFtiy1tOUwPfVftFPYOMVVXMmadkquMNZx/ebfFm4qJ/Re9MjXUqhe7Hm/9OtQo6ZWGaGyfinjMEe2W35M1bA0aFFN+BlRjS1C7Gdam2cbRnacMhinnGH9q1kA3N6ySqjwpFYTIbEOANQuWaHmmorWoA4DT8NfV5uHiB6IBxr6pCcpIzOm11ko1EorWWxrSevOKdNWwNZCUT1gGp7Omc+VBmXH7+M8Zp43Adc0/wrYFIxamQtCR5dzRwgSxevM/jsQz6RCuHJET431PFEA79ZqyYhsYBUea+VkqA91UA4ZsJEwvQwhpZ2OzuALNcBHx/eSCsaMCKvWrvtq1/Fo2lLMeWHY2VkSqYDgwCPp+jwm00Ura7gdaq+6AvpYSxaKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bc34c5-1c83-4c1f-1255-08d877875267
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 19:10:36.3400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJ6w2xQwJhnaI039wcBgcYALGpKKsmT1NaZ6Pkn3eKwrEHsgw9BxgNgZZULTYv7kXyhgoBSbbdY0oCIplt+fmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3335
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
Content-Type: multipart/mixed; boundary="===============0454199553=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0454199553==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Iu+fBazJtNnU421xicYD"

--=-Iu+fBazJtNnU421xicYD
Content-Type: multipart/alternative; boundary="=-DtmzNXipfzIkVnZ8WcNG"


--=-DtmzNXipfzIkVnZ8WcNG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [AMD Official Use Only - Internal Distribution Only]
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Thanks for the review.
>=20
>=20
>=20
>=20
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
>=20
> Sent: October 23, 2020 1:09 PM
>=20
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>=20
> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Galiffi, David <
> David.Galiffi@amd.com>
>=20
> Subject: [PATCH] drm/amd/display: Fixed panic during seamless boot.
> =20
>=20
>=20
>=20
> From: David Galiffi <David.Galiffi@amd.com>
>=20
>=20
>=20
> [why]
>=20
> get_pixel_clk_frequency_100hz is undefined in clock_source_funcs.
>=20
>=20
>=20
> [how]
>=20
> set function pointer: ".get_pixel_clk_frequency_100hz =3D
> get_pixel_clk_frequency_100hz"
>=20
>=20
>=20
> Signed-off-by: David Galiffi <David.Galiffi@amd.com>
>=20
> ---
>=20
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 3 ++-
>=20
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
>=20
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>=20
> index 512b26b3e3fd..589c7fb71480 100644
>=20
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>=20
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>=20
> @@ -1149,7 +1149,8 @@ static uint32_t dcn3_get_pix_clk_dividers(
>=20
>  static const struct clock_source_funcs dcn3_clk_src_funcs =3D {
>=20
>          .cs_power_down =3D dce110_clock_source_power_down,
>=20
>          .program_pix_clk =3D dcn3_program_pix_clk,
>=20
> -       .get_pix_clk_dividers =3D dcn3_get_pix_clk_dividers
>=20
> +       .get_pix_clk_dividers =3D dcn3_get_pix_clk_dividers,
>=20
> +       .get_pixel_clk_frequency_100hz =3D
> get_pixel_clk_frequency_100hz
>=20
>  };
>=20
>  #endif
>=20
>  /*****************************************/
>=20



--=-DtmzNXipfzIkVnZ8WcNG
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr"><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr" style=3D"text-align:left; direction:ltr;" bgcolor=3D"#fff=
fff" text=3D"#333333" link=3D"#737373" vlink=3D"#2e3436"><div><br></div><bl=
ockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf =
solid;padding-left:1ex">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Bhawanpreet Lakha &lt;<a href=3D"mailto:Bhawanpreet.Lakha@amd.=
com">Bhawanpreet.Lakha@amd.com</a>&gt;<br></div></div></blockquote><div><br=
></div><div>Thanks for the review.</div><blockquote type=3D"cite" style=3D"=
margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div><di=
v style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">
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
set function pointer: ".get_pixel_clk_frequency_100hz =3D get_pixel_clk_fre=
quency_100hz"<br>
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
</div></span></font></div></div></blockquote><div><br></div></body></html>

--=-DtmzNXipfzIkVnZ8WcNG--

--=-Iu+fBazJtNnU421xicYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEjxfKIKECTdteDMVnC/mGJHAirekFAl+TKqIACgkQC/mGJHAi
remIGQv9FwT/GD9DvZ4Tzr8/Jre1uXYAkPtjKnnbfFRvad7O2V/kCaEcnHgiCa7V
iEYMAfGSBArpbJuOJPJz/HLZxqHN1QYhI24wIEAR0MoSLTiiR2BK+EqeqjXHz5W0
ica3DVX/XkJxVVMxLM5JZoeeKfj1MB+nh3uiWvccwZ+r7bnBP55e3FmZfJMbzt9t
WMZznkqPfCix7lG3z/CHoe8TAx2UEgfzmEdIJfmqKk6Gelg88x4cCNKh93rVcL0+
t7PzFQiHPUXRYw5m1qUYlWlgH3jtj06WjZAE5GIQ/hSnMNbnHhfFXg+ZutyCsNZF
5rPWvm0N23Z9Pgbxl8yo32c7Kc3d7QDfuNdD9W0eo2501VZB2vhwcCQTKpprV3RQ
K7+VSoYMLYeJrZ+Gl1L/omFumgEnVYrOUGH68drM/hiwX16rx/NSB4Igq3ytIAhn
oUchNmZk1oPgYXWE8WtgJfwWcqZwYKBH1WkFOg/NOgvQl5+k5hPLiBfZK16AUsaW
AZ9/RK65
=weBI
-----END PGP SIGNATURE-----

--=-Iu+fBazJtNnU421xicYD--

--===============0454199553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0454199553==--
