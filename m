Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD077C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 09:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12F921582
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 09:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="czksSVBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12F921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835FF6E0CE;
	Thu,  7 May 2020 09:59:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA736E0CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 09:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwnMqWUKjjSwVBaCse92+xg4VIJGUlsv7z4qg82M61FAYX1PPscAfh4ONEF5CuhkWnxp4Q37/VD1EKFsCbk+T72MmSWIzyWu49yEqc1SMYATYI5Tl8VagNUUZmAeA4tWA8uz/635rC+nhQIGsvIzck6Bwh2ivHBps3upOWct7ndhZl0RyE6rRS0yaxA5mRc+kTIVcpBAC+4RF71Uc/5OtZWjdxyZlOxcyuBjgwS/0ZMfKB/JURNHbntKjN6gPUPSdob4jdyw7uwdZdXViUJs+LxX/L252fbQdzR03gq+x0QC+fUQjZZ+n7UL11jHwwZLUad/k20o/qkQNH1Le5KNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XNEMTB3/wyAv8vu2bv7fAOvCXecfKZmBGiiqnB4loY=;
 b=HbKijouy0GMrL4Nide1sKTp0BZvm6hdavJA8pyxdGcnisiuwDq4coqZNvcLzTDfF4HVOfuW+nQbUHzGtPHQ3G7MjK57/eo1pvQfG1i4xFMfguvuMxC8Sonsy7yw3FYvh7Nb9Ve1YZU+Y5s6SfGCVobg7g7GM9DKSmAGctJsVQ7nPNZrU0KTkiw+DcSl5bOKhnB9SVEd4o2uis5O584LPt/IahCGmh63G/kr0/12nPlyKInFdfUGdq7Uv2vIJfLyn+W8vOTFMKW75Cknhd6DOzUw86LHnZVWzURgBh0Lc+Kyk+zp1kQnPPGmApMiz5DbaRAIlHz1+2cQ0hOAIrgvDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XNEMTB3/wyAv8vu2bv7fAOvCXecfKZmBGiiqnB4loY=;
 b=czksSVBfwA1N6r1lMVbZqoM3NsFIDfKWmfIAnRqzY1k3VEcucGXW/pUOT52RiN2rRaMQRYwo2P9Qa9dl+W5ZQKfMV4NZch7a70CvnLEpNq5aJa/gpEOGf56r60xMkKik9AODOcNzA21Pnf5XmGPHPdZgBr62cbqD4yC9Oev8p7M=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.21; Thu, 7 May 2020 09:59:49 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 09:59:49 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix bug in RAS invoke
Thread-Topic: [PATCH] drm/amdgpu: Fix bug in RAS invoke
Thread-Index: AdYkT3c9ULTdSUr+R9ugbEN9uWnO4wABrtsQ
Date: Thu, 7 May 2020 09:59:48 +0000
Message-ID: <DM6PR12MB407506F170C8BDB7B0B4302CFCA50@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4032323C959F35257B0BCF03FBA50@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032323C959F35257B0BCF03FBA50@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-07T09:11:37Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1260091a-cd2a-46d7-bedd-0000fcc3ba48;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-07T09:59:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d51b9c8b-9df3-480c-a550-0000c496aeca
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 801baa7b-b4a1-40ad-91f4-08d7f26d6118
x-ms-traffictypediagnostic: DM6PR12MB4155:|DM6PR12MB4155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41555F91EE836D627991D299FCA50@DM6PR12MB4155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dDvY6gbDrqJ2i+MNKhfgk5CjHFMQ99rtyJUjZhM5cjzxcn5dxYL0WyyMkZr2Ml+Xj5XMmpP9Fy86cnz2Ul7/bCixxHK1IHeXM6pfOT945rOaQqpqjQWx1o0AXYJuv5zWJPeAUMeUB5eOzCpFa5A6byiyvMv6MzzxfnATsgIrcjBilenbLd1pKy4zCjkmP8Br1qaJPw6bCKuCtGyiFpid04jmrKPmzaAnWILW09vHvLVOU43+172kMJP5qDKKjinRvk+NsTURxe+nlpyXLHVTOObuB2ydTWXk0HEjIqC5MzJIFUg2twRGcbLC6y4oLPjS/6Pg6x8o7SjCaQPdgXOd5TlghB3uWTjWSJ516iuPC9SQU1lPzL2FehzidZ2zMo1ayKmzeHizfUgyJ2YnE/vkEFmb8LKlH3VJrrXmFyItHYw/nixhBbunvwbL+76VK2JbTEa7L8HIA+lHNzEzI82wXJAZMvxZ9iMMgEbUYKj6MGU1cIpucieem3lw6AV/oNhFUhef43cQwVheiTsdAjVpQw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(33430700001)(110136005)(64756008)(66476007)(76116006)(4744005)(55016002)(9686003)(86362001)(66946007)(66556008)(316002)(33440700001)(5660300002)(83310400001)(83300400001)(83280400001)(83320400001)(83290400001)(66446008)(7696005)(2906002)(52536014)(71200400001)(26005)(478600001)(33656002)(8936002)(53546011)(6506007)(186003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: V2c4ZCT+WTCdmwxFy55DzoS1KVtdNq20CfTToL/uXaSlv/PRDsA7Euz3ngNBusmuGbNfe2F/birrXece2JmHpwr0b0+rIE5M+i0Zn6v42+1BehgyetxAgefUS1dOme8zVfnYQb1OMexHLAgLpfCy8LmMSMmN9uA/1ID/llThm35sNk+cIuxuDe1t8i5czt84OV19FxW5t9TlQw+phPOcaZSPfTEgRkbNijyHwvAx2AhpKsOPAysGk8dM46QHLrrdz3Se89OBjbYQ+FVO2fq0auMCRKEh7qPbtKqiBsMUDTWBPEzCiBRvwIVAHFn9C7QbhZx87BESEPafn6hZkTQBEEt7xOZDAuszfpSz+GdkCqX+/sniiujUy+3wnXgU9uyCDGwH3Sg/jCBc+vYhW5RWlpXj9Ru4yhOd5lWnMgvFZ/84cQ5IFow+mPgZn7ulsonUOsadBpwyKiFLKs7yzQ9V1iIwRNEdnUCJkUYCAaq5xYitwulRxzBOBKJrcwNjKp615f//8F7uxdChviKYDhpWWAIsoJ1KJwOg1ygYqbcEZo85QJkpEr46pS3lYi/xI0SzjOJQnpKvAnxxoK8pwCrEWClutfELxT3uHgGiXFJ2ziHsFsDx8YnFr4DgfDK9/6kCoAVVdAfn6eGtRpK1CiqG//PqczZGsrsyGZ1VUFdIuC6gh46Na6kSJOVRbMTQ5CweOJIm56DWHpeRtrH0APLbF6Uj3x8l8kOpv8EIpFiiAcDMweRHld8BRb5DhHfUM/Czweohyfj1r6r8iZ4W7iXu8LrNJElVOQEYY0LtBADBMUU=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801baa7b-b4a1-40ad-91f4-08d7f26d6118
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 09:59:48.9327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ypA3Nx0QhIT4LLSIhxcnw+ToOMPcNjr0udbi9LIP+g+HIAZjkPc+AaQAfyAc1vPoolvvwguayYI4Dd1Zm8nSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Content-Type: multipart/mixed; boundary="===============2114287909=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2114287909==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB407506F170C8BDB7B0B4302CFCA50DM6PR12MB4075namp_"

--_000_DM6PR12MB407506F170C8BDB7B0B4302CFCA50DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Good catch.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, May 7, 2020 17:12
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix bug in RAS invoke


[AMD Official Use Only - Internal Distribution Only]

Invoke sequence should abort when RAS interrupt is detected before reading =
TA host shared memory

--_000_DM6PR12MB407506F170C8BDB7B0B4302CFCA50DM6PR12MB4075namp_
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
<p class=3D"MsoNormal">Good catch.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Thursday, May 7, 2020 17:12<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix bug in RAS invoke<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Invoke sequence should abort when RAS interrupt is d=
etected before reading TA host shared memory<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB407506F170C8BDB7B0B4302CFCA50DM6PR12MB4075namp_--

--===============2114287909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2114287909==--
