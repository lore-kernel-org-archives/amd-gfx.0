Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4476C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 06:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383FE2080A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 06:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QIjmPFwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383FE2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B55A86EB0D;
	Tue, 27 Oct 2020 06:38:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D196EB0D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 06:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6JR+25TguS7SOdLH7TSAAK+wn0YOFQzdezYqBlrgV847t8nVral3gWSNEb7qCZUiExM6FCQFiew7URBsjnCn5e9Vb1Xx6591aqPdSVyUwmhWCJlMpP8rldzMol0QqnoHOEfxXGp1QPsNqT68bNX7Qj79+wMGW5Ub5dyCkaCSofKsDDqfvqnSCLhLuSgLbIk6lYhytFQ4jFmIUMR0NZD19zPRSLfpNF15TTFEzLSo0WyXaVygtN8i1+u8R+XJJ44LOwSBgsNGRui+35LmnrYmegAJXf8K/yjmPt2gOqfBn+r8w5no5yjnM3Z/ZKZDbtH7HI5trqVC6ewdyf3GNxoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP17N4n0GGslCknaPBT0GywrAes4RlBJYPFEzWsTHQ0=;
 b=jZTp+L+bBdLAxjMtDXKbJH21Z3I++dkjKYCVuNrnUSeq+VKjzdMGnyNFkV2cSz+Mse4B7+m5efkFWo3mMQLvDMFKD+LGUXhg5MSY1nKgoR9qW8X5FjCCLn1CYGSx60zcLIBKjKBJVGXfzQFekRxkf0HxEJVihdUWqejw/xAXDoXbJSjpRAkDV0aGVMDHedQyP/JIM1zICWW5IxcNcdQQZnVMeMraNA4k1ziVROdM2hP/eVApBaqTYtAMTQykrcmrq0sWXk8exIQVtm16VthxMj2wnfLdK0Eh8BYv75bsyv64ONNumSyvpf/njqX+1fbj6rmwEpvejekWOVS81Tm0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP17N4n0GGslCknaPBT0GywrAes4RlBJYPFEzWsTHQ0=;
 b=QIjmPFwBPaa+blTIn9cMzdI/FY+kCLXwF2fymGUggiT0CEZkorE20kP1Sp7Q8MN/nVxqx5C90NF8NDpwQEy4S0xdbuH/JX42LGJa2OqXQfmO+j6tdcO2yljILEp3Sq1AfowUfTJ8/TX+GTa9lCbzEqLAD7LmcJVHa4E6pWVY3qs=
Received: from BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16)
 by BYAPR12MB3175.namprd12.prod.outlook.com (2603:10b6:a03:13a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 06:38:24 +0000
Received: from BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::3013:68d7:e3f5:c204]) by BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::3013:68d7:e3f5:c204%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 06:38:24 +0000
From: "Li, Xin (Justin)" <Xin2.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li, Xin
 (Justin)" <Xin2.Li@amd.com>, "Zhao, Jiange" <Jiange.Zhao@amd.com>
Subject: [PATCH] drm/amd/pm: Activate a more aggressive DPM policy while
 there's heavy load.
Thread-Topic: [PATCH] drm/amd/pm: Activate a more aggressive DPM policy while
 there's heavy load.
Thread-Index: AQHWrCuoq1I7pphlfUmptsmNTWFsPA==
Date: Tue, 27 Oct 2020 06:38:24 +0000
Message-ID: <BYAPR12MB47596DFC2AEA6E96159F990BBB160@BYAPR12MB4759.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-27T06:37:35.8917326Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2907fe47-7d64-48a4-b1af-08d87a42e7d4
x-ms-traffictypediagnostic: BYAPR12MB3175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3175EA641BD9EF55C9E8B06ABB160@BYAPR12MB3175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvd31yEvMAS7lYxypWxnoIn6Ls//LkROD6EhVLWPP4rWB0ko1qFOKm2KOUl1PydKeVoTUqPN7dT3I5ibwGpoOnDyqAXdV7pUfCBqauCOqjp78FkBIjeaImcDiRf3i+HCxUNd6JU2YiKSaVkcMde9eLzwtQ/YFRdnqpTHMweplyeuj1lF7Q3rOOHn7C0s80v/JDdeg0IBa+3jEhtusdMPxmdRCo8MXOIq6YFBMesLDfJ+PVAJZzhaIf+31Dxw1KLeIax09+HRB3d+YffWamHGm0VcEbAxxWV242s3qma2ldO0syG2TsMJznTa16gcqLlbLtXqeesoBgO2aYuU8beoiEyU6a3dQNe6SaeqzwIMBTZM+MmtcX4pXg3AyvmMLAN8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4759.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(186003)(71200400001)(478600001)(8936002)(9686003)(6506007)(52536014)(64756008)(66446008)(66946007)(66476007)(76116006)(66556008)(26005)(110136005)(91956017)(33656002)(7696005)(316002)(5660300002)(6636002)(83380400001)(2906002)(86362001)(8676002)(55016002)(46800400005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: h3NaXmvasNd521uGymdjGVmJpqZZ5kUU+oFaxXPu94J1AbrAvOenWs13UGCehZ6LKb6y4obfUr/QI+DjfZacCoJxki+NA4IqdQGG8BS9nNsYNYhVzQnk7byJEcsX7R9xO9T4PLLyDdaD8Di9vgCAW/CDIKMTn5QGv8ppvwY2OsC0ciH1vifpTC5SGc4Am44ugr0rD3FsgOKyALQxxb8fd5ZT/Et8tD3Pu3IlKOBRNLQJ08I8Gt76E59icuV5Q1le7rG6ccytZwpK3KIKWJ8kZJFokAAuFV1wauWFrnH1RfCTJelSbQireVdyjZKQmPE7gqjjobxJi/ogLtMunQPz8O5e2RpmN+7RfdCRcc0gaDxQaARIKidTeK4xzl7shQYd6hMrs0Y6998hkY9QpYki4w36hJOoOsOuGe3CN2bAu0IJn/4FJvOAflpwe21Rwe6rofCc//GEQoDny7UqsdiiuRTOs28anq1TZwn1LCPhcmB/IxHTYRDX1HN3bawuARM0EZ4Ke7ih7SBrNAsPn7TlVoRP+Awu5f/HXQcTvIhIUeuHLCkMdLKFeI19i03+P4J/c8eG/kciEApBSOIcR95QVc/Wk+v4YTmYAP3DX4GHWGgRmvxD6lpsdTwRP1yXDfJmJAsL1jw4x+L/zJJAfePlzg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2907fe47-7d64-48a4-b1af-08d87a42e7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 06:38:24.7062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KxV9dWhc66pxs6o4YTXBv2KdW28S4JoX3HWzvi+Z/8R0WJ2YIKfemffy3YF0rlh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3175
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
Content-Type: multipart/mixed; boundary="===============1937796915=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1937796915==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB47596DFC2AEA6E96159F990BBB160BYAPR12MB4759namp_"

--_000_BYAPR12MB47596DFC2AEA6E96159F990BBB160BYAPR12MB4759namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Fix performace drop while streaming Doom

Signed-off-by: Li, Xin (Justin) <Xin2.Li@amd.com<mailto:Xin2.Li@amd.com>>
Signed-off-by: Zhao, Jiange <Jiange.Zhao@amd.com<mailto:Jiange.Zhao@amd.com=
>>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c
index eab9768029c1..5287ac4e8364 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -125,6 +125,20 @@ static int pp_hw_init(void *handle)

         ret =3D hwmgr_hw_init(hwmgr);

+       if (adev->pdev->device =3D=3D 0x6860 && adev->pdev->revision =3D=3D=
 0x07) {
+               long param[5];
+
+               param[0] =3D 5;  // busy_set_point
+               param[1] =3D 60; // FPS
+               param[2] =3D 0;  // use_rlc_busy
+               param[3] =3D 3;  // min_active_level
+               param[4] =3D PP_SMC_POWER_PROFILE_CUSTOM;
+
+               mutex_lock(&hwmgr->smu_lock);
+               ret =3D hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, pa=
ram, 4);
+               mutex_unlock(&hwmgr->smu_lock);
+       }
+
         if (ret)
                 pr_err("powerplay hw init failed\n");

--
2.24.3 (Apple Git-128)


--_000_BYAPR12MB47596DFC2AEA6E96159F990BBB160BYAPR12MB4759namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
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
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:-webkit-standard;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.apple-converted-space
	{mso-style-name:apple-converted-space;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;-webkit-standard&qu=
ot;,serif;color:black">Fix performace drop while streaming Doom<br>
<br>
Signed-off-by: Li, Xin (Justin) &lt;</span><a href=3D"mailto:Xin2.Li@amd.co=
m"><span style=3D"font-family:&quot;-webkit-standard&quot;,serif;color:#000=
064">Xin2.Li@amd.com</span></a><span style=3D"font-family:&quot;-webkit-sta=
ndard&quot;,serif;color:black">&gt;<br>
Signed-off-by: Zhao, Jiange &lt;</span><a href=3D"mailto:Jiange.Zhao@amd.co=
m"><span style=3D"font-family:&quot;-webkit-standard&quot;,serif;color:#000=
064">Jiange.Zhao@amd.com</span></a><span style=3D"font-family:&quot;-webkit=
-standard&quot;,serif;color:black">&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 14 ++++++++++++++<=
br>
&nbsp;1 file changed, 14 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c<br>
index eab9768029c1..5287ac4e8364 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c<br>
@@ -125,6 +125,20 @@ static int pp_hw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr_hw_init(hwmg=
r);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pdev-&gt;device =3D=3D 0=
x6860 &amp;&amp; adev-&gt;pdev-&gt;revision =3D=3D 0x07) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; long param[5];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; param[0] =3D 5;&nbsp; // busy_set_point<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; param[1] =3D 60; // FPS<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; param[2] =3D 0;&nbsp; // use_rlc_busy<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; param[3] =3D 3;&nbsp; // min_active_level<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; param[4] =3D PP_SMC_POWER_PROFILE_CUSTOM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D hwmgr-&gt;hwmgr_func-&gt;set_power_profile_mode(hwmgr, p=
aram, 4);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_err(&quot;powerplay hw init failed\n&quot;);<br>
&nbsp;<br>
--<span class=3D"apple-converted-space">&nbsp;</span><br>
2.24.3 (Apple Git-128)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB47596DFC2AEA6E96159F990BBB160BYAPR12MB4759namp_--

--===============1937796915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1937796915==--
