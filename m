Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081A1C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 03:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B398520748
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 03:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YY3+g6FF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B398520748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A6296E106;
	Tue,  7 Apr 2020 03:55:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302E26E106
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 03:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt0Rl+9gpwLu1B4+ZuLeykoFAlxzNdmIVZPdGHi5i2ZIqVk8yGEQDPkzt0XBNo9bGx36udpulGqBm9aPDNTZhJYwH1kv8Gj/MkyhHY7UmOUqfGf9WZkLHjjKJUhpXxWR3orW7M/yrS6u1WxM1X+wXt5z70Ysag7b/lXeOtFgTqv+fYEgCvfbLVVUUPlUbLIgDdsv0bTT53p9tQptcCNY5WxrfZRV04uBwTT1dkMO9KQVnRvsBv34tRJxS0O2MH8MGvUR7fX1K4kDrjYopNadA146p1VB/imFS9TaRJ8q0O2vYOd0sNNPl5wwJ+aiqpZHPYpcWtp281nGhPQLLmPIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcXrV/15vs0FTrGXBsjbjd6KKFSKsfw7NihbcmUuWHo=;
 b=A94CJasrR4RD3GKDEfl1oQjtCpNGHNU9HcCZEIhM+QUgVV8c2/nllbZZjt8F4mOgBkKlVN7p0kSxk9YWfEekG3QaCMq4kA5U15Y4FFrl0Wn99lR7qGbleekk9QYIwwAbEL4nFCdwvg/uFU/b1Fjj54Qqh+LxTTEGy64lYrUU9ragykUErg5AHWAJbwYLnYztGn7EKcwoonBQkR3C2z+NTb9HGAGuAgdz9sibC5waZxjeoshGmEjGunQfXXlz7KWGz10XrRupfsB9RqBmQWgCmgJSgPCH1zam/AlNAqh1UIyizwAbTLwcAQnQqLI6OEtKI8TjNO5ng9HhxvaYPcWPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcXrV/15vs0FTrGXBsjbjd6KKFSKsfw7NihbcmUuWHo=;
 b=YY3+g6FFnHst66LYSC7qBmop89vQwBLhGYQ9M7MSMO2K6HGCl6pLDASh/5JV+XL1+Taj/rspoLqJ81/u/JGi/Y7w3tNnOBR2BVTA1WJ9YIIcqIdv+Qod8Qs4EsQdKL2nl3Y3sEzLzu20KogcMjfJFXcgc4kM5PVeowREbbm8rYg=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2732.namprd12.prod.outlook.com (2603:10b6:5:4a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Tue, 7 Apr 2020 03:55:03 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 03:55:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolve mGPU RAS query instability
Thread-Topic: [PATCH] drm/amdgpu: resolve mGPU RAS query instability
Thread-Index: AdYMiLrGDMHeNMEaR8iSuEJH/epwxgAB1CtQ
Date: Tue, 7 Apr 2020 03:55:03 +0000
Message-ID: <DM6PR12MB407537382D401793CFAE25D0FCC30@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-07T03:03:04Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=45c41767-f67f-4403-9a3d-000022d69304;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-07T03:55:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d3395cb2-ac4a-40e3-b45c-0000b32b0a1a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4406401-229b-46f3-1915-08d7daa77415
x-ms-traffictypediagnostic: DM6PR12MB2732:|DM6PR12MB2732:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2732A1178611B045967EAAA9FCC30@DM6PR12MB2732.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(186003)(8936002)(66446008)(64756008)(66556008)(71200400001)(66476007)(33656002)(86362001)(478600001)(52536014)(2906002)(316002)(6636002)(5660300002)(8676002)(81156014)(4744005)(55016002)(110136005)(81166006)(26005)(53546011)(7696005)(66946007)(76116006)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +HrYtUiJtOl99pxd7yG70jB/uLpQiYiYpUWRU907nqgj8HkVA5qo5HLT3I8Gfcvd2g/6Tc9JUJMGEA/UkSGN7zg3EQu41NjFLDckIg3XrMYWKNVVyXhGGpcmfr6zCktqOdrV4jO9PwonBFzV7hi1+ZkiN4PtQZ4bANk1ylgXx1S2cLH4qMvzbGR5/BvNrwO5JREEANx8NkHpS0qUa3hzLSuH06rbnzMpq/yeZR+tiPfRveRAflC+4M0VIeeyOAtc0YV65DEO+KKB2j7bcV6fT/Z2+IJQmlaKXUGh+adQed2cT1XmcjH3bpPHUYZXNU1W7kJmMRWgN7qe1mgwZQeOnMUifPP5eI2tITbC0qXxhZT+Ei9K44Ciz867/FzRkbSgxev5t5Bu/500+iHGYBMnYEaM35ysBEW+i3XHo837GNFLrBbeQGHM+j4qrPrYc2jH
x-ms-exchange-antispam-messagedata: zn2iZw+gsbweB11c7BngVcYkF7bRVylnIBwFUpulCSi04o1UD+teX5yddVNa2Bmm0y2PB0TmIKjubGnXMkP3m49bbwu1s8u9OLppT4mD6IArr8MS+zYK41WNgwihtGVOT7riUTOOI/LWnBzj2Xkeag==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4406401-229b-46f3-1915-08d7daa77415
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 03:55:03.7321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BX1iQ3je4iQwS6LdMGSoe7nfQKCkWfwWM1/rz36ctAFF2owXXtzh7chSb8V+4JbJiV9IA2p6CEwQuiKx5CFO3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
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
Content-Type: multipart/mixed; boundary="===============0198069987=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0198069987==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB407537382D401793CFAE25D0FCC30DM6PR12MB4075namp_"

--_000_DM6PR12MB407537382D401793CFAE25D0FCC30DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Per discussion, please have a separated patch to replace all the "DRM_INFO"=
 with "dev_info" in per IP query_ras_error_count callback function so that =
we will have clear picture on which errors are from which nodes when harves=
t all the RAS errors in one gpu recovery worker.

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, April 7, 2020 11:03
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Chen, Guchun <Guchun.Chen@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, =
Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: resolve mGPU RAS query instability


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to resolve issue when upon receiving an uncorrectable ras =
error, RAS ISR gets triggered on all GPU node creating a race condition bet=
ween querying the RAS errors and entering the GPU reset sequence

--_000_DM6PR12MB407537382D401793CFAE25D0FCC30DM6PR12MB4075namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Per discussion, please have a separated patch to rep=
lace all the &#8220;DRM_INFO&#8221; with &#8220;dev_info&#8221; in per IP q=
uery_ras_error_count callback function so that we will have clear picture o=
n which errors are from which nodes when harvest all the RAS
 errors in one gpu recovery worker.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, April 7, 2020 11:03<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Li, Dennis &lt;Denni=
s.Li@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve mGPU RAS query instability<o:p>=
</o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to resolve issue when upon receivin=
g an uncorrectable ras error, RAS ISR gets triggered on all GPU node creati=
ng a race condition between querying the RAS errors and entering the GPU re=
set sequence<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB407537382D401793CFAE25D0FCC30DM6PR12MB4075namp_--

--===============0198069987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0198069987==--
