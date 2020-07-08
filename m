Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C652C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 20:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A7A2065D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 20:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S1O5TXD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A7A2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B940D6E10F;
	Wed,  8 Jul 2020 20:42:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E5F6E10F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 20:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTtkoyCbu9l8yYJ1iC8KcqB0aY0pDRxPbdwPUPknV1ujlFjl2+Ea7eu7sfHE8ji3SZKhkoddU+OUiKy5xa7UHO6sRddQIDIEFv6U3F73VS18b4TMKhKpxUC/hZPJo3vBNpTmUA/RV24O8zBad0ybGtgs9FO07xr4YC9/0RQ/VzpmE27WtS8VWGwLKuo3LMIawFpI34a/Ng0uGdXD3Bz5LHwCm/la7SUiGsnrKO+xNTYVg9Vn/ycqoSgeTTKqt4vNukbQi7iuPfi0QXGAiab673ECf1MxdvnLmHcxauRO1cezloz62rEEAyU/NUiOZl3JO+ZSsTwR+XwAHGt4YkKLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCC0oZ/0cSuQg9Bqt9MhYfYqZqSdsHj8Dfc2MglSkmA=;
 b=C+PdFuzqabi110eY9dioBxj1XUn0SNOIdpMDUfXj7ws2T+1qzB6CqrFwDCmWbTpJWMQOCAcyYLx2RdTEvZXlR3IRd5+xkL9Lt2sBZnv/CMPgFhJ791JK2Kc5yCzlaa1u39qUjIuFIZ/8T8RXzKy0DS2E5MQEdjC1gWQq5MjH0ej64/4qM5y9wDcpyx/PyrHEG7qu/SWonUrwK4EaH3mfouUXwERcy95pWAMcVvzzW3UikeaQt8zbf2NyvKicCRu/4NjgihRIRV9EHTLZ+6pXLfLk3GTqolCWDHmtaU8y88c3jf9Io9Yacwyf/C213O5IIkvRXjJ8SFdUHTxoE3OXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCC0oZ/0cSuQg9Bqt9MhYfYqZqSdsHj8Dfc2MglSkmA=;
 b=S1O5TXD4XAI0QMMbpBaCmZn1IwpkKYaRIckyRvc/10duDd8iA2GxoUf7Jf01QKJz7GJczdFqYCEdg+AaQDb1TuoqFgpXI3Y20Ak+wZrVJQvAyd0zzICVZj951ydMrNS4VoXLnmdt3nW4C9y3sTHFLRUY/ZeFvanGAex3le09atc=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR12MB1871.namprd12.prod.outlook.com (2603:10b6:300:10b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 20:41:57 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742%3]) with mapi id 15.20.3174.022; Wed, 8 Jul 2020
 20:41:57 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix CSC remap matrix not being applied
 on dcn30
Thread-Topic: [PATCH] drm/amd/display: Fix CSC remap matrix not being applied
 on dcn30
Thread-Index: AQHWVWcxHvfRptgFgU6XWISlFUV0B6j+JXq5
Date: Wed, 8 Jul 2020 20:41:56 +0000
Message-ID: <MW3PR12MB4554FC4DC6ED219904F561FCF9670@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20200708203404.23838-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200708203404.23838-1-nicholas.kazlauskas@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-08T20:41:56.066Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7ced17a-f703-4c43-6459-08d8237f5b60
x-ms-traffictypediagnostic: MWHPR12MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1871F3CB7B6DDAFC0FA90B6BF9670@MWHPR12MB1871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TEWlHYo0RrGJlrVDe1x51+1yBBSEeRcITjDdhWkwiCL3aUv+8b7NAdJpXI3aFqwAMsnIaoqqaa9KEaWtWR0HNSj9nbICkeu0TaZSR4QAtjP/tAUnQki9g/RvGHnR0Oi8cgOSuawtEf+8xIxW0/A5CmQz2b+dlaHY7FuTdk3frG/oP5jWo3C6c84k02mO+JKysli4satacqXRmlepTj6cSjgXFAJ9h79FJnoQ/fhpfbFgRJihuX8lKQi08TD4S2ZNEb3kDu1XBuU8QaktPPNikvdGAbwWK/83Z34PBXnAtqfu5YVspVXF1uXegPVlYmQDUCtUqYB81YMlH5w/Dc1dTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(83380400001)(2906002)(9686003)(8676002)(19627405001)(8936002)(7696005)(33656002)(55016002)(6506007)(26005)(66446008)(86362001)(186003)(53546011)(66476007)(4326008)(52536014)(91956017)(71200400001)(64756008)(66556008)(5660300002)(76116006)(66946007)(498600001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: YTuGfgrLgtNcjdLUMrpMzvvVSJwRC051Hec+SImpQIlax771F2zjyEbvPngdq+fGYPdrsrlM6tdV/m6mcS+m1TVDdpMLLI+IUV5DJw3ZkDuKktXVaWPYbjJZPw6jatlBS6s4axAWOZNf3t1ychN6zB/nnT/ElYEuY+a7Uo7lL1ltdcju/MMwd+4pULP+sLZl5M1+fonL8KxgGK4ENBIxzuZAUoipVWh/nzFaIQvAoOXk77yN725nO4E9mvjHDb26dOWmhP9ortNO7vlwDujblQL3+tWKGnS16JYtnNaEHVLyeyry0jJTi2MsZvGFiZRAr1xKAXbwepOgc7OUtCM6gqM84anHC9o3Obiu6ll1W5wUvMDAP9vwDS5zGwCwgklYcFC4CfSHZNtltdPucbfx6ZnG6ubJboW+hlIX7hYJadp4DMGndboEzhIa09UIVhgAvFd8Qk7wk8TUbG/J6V6EeRGLLBBiJcA9VuWGqy63bkzrPjE+ExeT9bE5kPP7IZfl
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ced17a-f703-4c43-6459-08d8237f5b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 20:41:57.1358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P02HWySjzyZDEAQtoiorQbCmAUrC0MBdfJPNwefCDZubD+NeFwlbIWBLuZ3Q7KpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1871
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
Cc: "Cyr, Aric" <Aric.Cyr@amd.com>
Content-Type: multipart/mixed; boundary="===============0519361707=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0519361707==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4554FC4DC6ED219904F561FCF9670MW3PR12MB4554namp_"

--_000_MW3PR12MB4554FC4DC6ED219904F561FCF9670MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
________________________________
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Sent: July 8, 2020 4:34 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Lakha, Bhawanpreet =
<Bhawanpreet.Lakha@amd.com>; Cyr, Aric <Aric.Cyr@amd.com>
Subject: [PATCH] drm/amd/display: Fix CSC remap matrix not being applied on=
 dcn30

[Why]
DCN3 has two gamut remap matrices. When using CSC adjustment the CM
remap is set to bypass and MPCC remap is used. However to bypass CM
some state in the context is modified and not restored correctly
resulting in subsequent calls to disable MPCC remap as well.

[How]
Fix logic for save/restore of remap enable flag when programming MPCC
remap matrix.

Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/g=
pu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 5621c95177d2..7725a406c16e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1482,22 +1482,23 @@ static void dcn20_update_dchubp_dpp(

                         memset(&adjust, 0, sizeof(adjust));
                         adjust.gamut_adjust_type =3D GRAPHICS_GAMUT_ADJUST=
_TYPE_BYPASS;
-                       /* save the enablement of gamut remap for dpp*/
+
+                       /* save the enablement of gamut remap for dpp */
                         enable_remap_dpp =3D pipe_ctx->stream->gamut_remap=
_matrix.enable_remap;
-                       /*force bypass gamut remap for dpp/cm*/
+
+                       /* force bypass gamut remap for dpp/cm */
                         pipe_ctx->stream->gamut_remap_matrix.enable_remap =
=3D false;
                         dc->hwss.program_gamut_remap(pipe_ctx);
-                       /*restore gamut remap flag for the top plane and us=
e this remap into mpc*/
-                       if (pipe_ctx->top_pipe =3D=3D NULL)
-                               pipe_ctx->stream->gamut_remap_matrix.enable=
_remap =3D enable_remap_dpp;
-                       else
-                               pipe_ctx->stream->gamut_remap_matrix.enable=
_remap =3D false;
-
-                       if (pipe_ctx->stream->gamut_remap_matrix.enable_rem=
ap =3D=3D true) {
-                               adjust.gamut_adjust_type =3D GRAPHICS_GAMUT=
_ADJUST_TYPE_SW;
-                               for (i =3D 0; i < CSC_TEMPERATURE_MATRIX_SI=
ZE; i++)
-                                       adjust.temperature_matrix[i] =3D
-                                               pipe_ctx->stream->gamut_rem=
ap_matrix.matrix[i];
+
+                       /* restore gamut remap flag and use this remap into=
 mpc */
+                       pipe_ctx->stream->gamut_remap_matrix.enable_remap =
=3D enable_remap_dpp;
+
+                       /* build remap matrix for top plane if enabled */
+                       if (enable_remap_dpp && pipe_ctx->top_pipe =3D=3D N=
ULL) {
+                                       adjust.gamut_adjust_type =3D GRAPHI=
CS_GAMUT_ADJUST_TYPE_SW;
+                                       for (i =3D 0; i < CSC_TEMPERATURE_M=
ATRIX_SIZE; i++)
+                                               adjust.temperature_matrix[i=
] =3D
+                                                               pipe_ctx->s=
tream->gamut_remap_matrix.matrix[i];
                         }
                         mpc->funcs->set_gamut_remap(mpc, mpcc_id, &adjust)=
;
                 } else
--
2.25.1


--_000_MW3PR12MB4554FC4DC6ED219904F561FCF9670MW3PR12MB4554namp_
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
Reviewed-by: <font size=3D"2"><span style=3D"font-size:11pt">Bhawanpreet La=
kha &lt;Bhawanpreet.Lakha@amd.com&gt;</span></font>
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicholas Kazlauskas &=
lt;nicholas.kazlauskas@amd.com&gt;<br>
<b>Sent:</b> July 8, 2020 4:34 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Lakha,=
 Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Cyr, Aric &lt;Aric.Cyr@amd.=
com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix CSC remap matrix not being app=
lied on dcn30</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
DCN3 has two gamut remap matrices. When using CSC adjustment the CM<br>
remap is set to bypass and MPCC remap is used. However to bypass CM<br>
some state in the context is modified and not restored correctly<br>
resulting in subsequent calls to disable MPCC remap as well.<br>
<br>
[How]<br>
Fix logic for save/restore of remap enable flag when programming MPCC<br>
remap matrix.<br>
<br>
Cc: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Signed-off-by: Aric Cyr &lt;aric.cyr@amd.com&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/display/dc/dcn20/dcn20_hwseq.c&nbsp;&nbsp;&nbsp; | 27 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;1 file changed, 14 insertions(&#43;), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/g=
pu/drm/amd/display/dc/dcn20/dcn20_hwseq.c<br>
index 5621c95177d2..7725a406c16e 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c<br>
@@ -1482,22 &#43;1482,23 @@ static void dcn20_update_dchubp_dpp(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memse=
t(&amp;adjust, 0, sizeof(adjust));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adjus=
t.gamut_adjust_type =3D GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save the enab=
lement of gamut remap for dpp*/<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save the =
enablement of gamut remap for dpp */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enabl=
e_remap_dpp =3D pipe_ctx-&gt;stream-&gt;gamut_remap_matrix.enable_remap;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*force bypass g=
amut remap for dpp/cm*/<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* force byp=
ass gamut remap for dpp/cm */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_=
ctx-&gt;stream-&gt;gamut_remap_matrix.enable_remap =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&g=
t;hwss.program_gamut_remap(pipe_ctx);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*restore gamut =
remap flag for the top plane and use this remap into mpc*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt=
;top_pipe =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&gt;gamut_remap_matrix.=
enable_remap =3D enable_remap_dpp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&gt;gamut_remap_matrix.=
enable_remap =3D false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt=
;stream-&gt;gamut_remap_matrix.enable_remap =3D=3D true) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adjust.gamut_adjust_type =3D GRAPHICS_GAMUT=
_ADJUST_TYPE_SW;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; CSC_TEMPERATURE_MATRIX=
_SIZE; i&#43;&#43;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adjust.temperature_matrix[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&g=
t;gamut_remap_matrix.matrix[i];<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* restore g=
amut remap flag and use this remap into mpc */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt=
;stream-&gt;gamut_remap_matrix.enable_remap =3D enable_remap_dpp;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* build rem=
ap matrix for top plane if enabled */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable_r=
emap_dpp &amp;&amp; pipe_ctx-&gt;top_pipe =3D=3D NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; adjust.gamut_adjust_type =3D GRAPHICS_GAMUT_ADJUST_TYPE_SW;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; for (i =3D 0; i &lt; CSC_TEMPERATURE_MATRIX_SIZE; i&#43;&#43;)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adjust.temperature=
_matrix[i] =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; pipe_ctx-&gt;stream-&gt;gamut_remap_matrix.matrix[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpc-&=
gt;funcs-&gt;set_gamut_remap(mpc, mpcc_id, &amp;adjust);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4554FC4DC6ED219904F561FCF9670MW3PR12MB4554namp_--

--===============0519361707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0519361707==--
