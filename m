Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC73FC4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 09:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDB760F14
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 09:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BDB760F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8757789CE2;
	Wed,  4 Aug 2021 09:13:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E1C89CE2
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 09:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUlcR2c6OnevZe4YwL0nimWAVT28/JqSWVbpS6GMeTIn2UGp/ELWr4CZ81dbol+pC6nbLb717D2lI8iLzrki+GjkYsXvqLL1H+XIvsrEXNNwT6CWz14ZzKbfU/O3MNC/UdmGNB4glP8llFhvmhkDJqg4iIOwHXOEfbaWlPLGPtIc2symE8PBkZ33PJnVd2lxrVMjtiMYs9WE8BD6IYpcKYHGBKAd/HgpaJ7eo7VzvCNDXk6i6WwnFOmTiqtAo4B4yDfpPolxrsJ2LbIR9apc8EYWq4C1TVai3OVa9apRkMGZPsonoNty++327xobNYALOhPkxw3QtoIfY3VNVI7VDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1Zi6n/hwvpalH2GivcDhAOEAuDiDWzm6eVoQYzvmEU=;
 b=Ds9ei+xmW1vH3Qaft2f54+qSj3DaT9UiMBaVv1+1An+WsjBMq4yEqx2Ecib2LeeHeDvvYO6lB/cWL/uIMo5OKeNZhJz9F0/KaGlgh6tBb1gKuiLvGH0weAR4ZDPEWzOzDxeKP+JjrffMvLFX/MMlsL8ox28FPpJb7iiUJOKcgfF1UJCCQfyL257ZU4t2mShPKXJmGuHmINIRxi3rMbf9E/VfhExWurw6o2xG3tKhLYf4kxdj14S1B6va2ciu4CpYXGMxLiBpfBFRZtZrESD7eKDcZdoXDswZWcB8VxscEByxJWAAl6qHDNc17Dzl5RCcfOlPdN+0spWEf9oXg9IwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1Zi6n/hwvpalH2GivcDhAOEAuDiDWzm6eVoQYzvmEU=;
 b=0Gg4gsdhlJKySSkHutCxSYb6lLMuioXieiEop7Ag/ukHqygbkGNUAh+40XRLtTn6dRmvSIiGfhwK8hALngUmxtxl0TQ0Fk5wNRjCnl9eVo4o7KO8yOwq08ZIKhCv/8k3lmaMqWBmt/NFTuS3IGmXofrMCo4efnRzkKx2GmmygV0=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 4 Aug
 2021 09:13:51 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89%8]) with mapi id 15.20.4394.015; Wed, 4 Aug 2021
 09:13:51 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS
Thread-Topic: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS
Thread-Index: AdeJDVbWTr3gUddJQAKxCNFB1i4ygwAA6j2A
Date: Wed, 4 Aug 2021 09:13:51 +0000
Message-ID: <BN9PR12MB522688A0B5F337FE81B8774AFBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <BN9PR12MB52266E0B3F150CA07FE3BF67FBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52266E0B3F150CA07FE3BF67FBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-04T09:13:48Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d85b9a83-ccf9-422e-8df1-d8188f5d5714;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 172f90e4-d4ea-444d-b87a-08d957282cee
x-ms-traffictypediagnostic: BN9PR12MB5339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB533975D93B222E0D65453F6BFBF19@BN9PR12MB5339.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4fZ9Fs4cf0GrRHRxIpSTIeOAQYL81NVOGchRoyGkLGPTfqM/mGd6uSj1BH5a2Gpxh02e2qySueobRG4p/x+guE3zL+dS1+u/oXUdknpAiJW0tYwUeWIxRZFSBz+eetmMdNP18IXVoc5IQXrbaPScOxm2HcLXEF7UthiPraF25ungg/6pBNEyGGisc116Veg9PQ7ju05NVm0W09JANywiLW5lKJZHexX2wjlB7e/fQEljq2eZj08yTFnewLDEU463mQtIqJz1DO4PwnzMr2ABMZKIqdbommcT1vA0vmxVqRbb+qGuxIk7lmJdfIiM5DV0kOV8B/QklRpwyHhL54tyxQRVzDXI3F5YWFH42RVCNuV83DZkWo0GuhNdSRLy6jpA8i7PD7vZV83i7yVJuD4sAHY0T4//qbinI7OJPb2OPFPsaO2y4WVSOadKd75aF4ELzzb733KDCsKeRdkAHtAQcIdzREovmsG6qrvgXriAjrSDywmk5y1OgwpeJpDgTCwVu3n4as7JStd0rrYYVcb1jTgih7KogaDz5a/FlV+zNDMa4yv5Dpt5lcoFzbEhnY7dHj+HbYEW/TC6q/Z0wWTNx4hY8cTUo361tL8nqmhGm2cwNKPcwlB7kF511gNUPTWuFd4jwB2WDFcwgGz5f5HklSVc0hL65BrB1NUT+adkqJTAWBJm9WxMRwaKnwDNKPAV8svC5cSqmIc91ioiqIoVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(99936003)(66616009)(66946007)(66476007)(66556008)(64756008)(66446008)(8676002)(86362001)(55016002)(5660300002)(52536014)(122000001)(38100700002)(9686003)(76116006)(4744005)(33656002)(38070700005)(83380400001)(2906002)(2940100002)(53546011)(186003)(7696005)(6506007)(26005)(8936002)(478600001)(4326008)(71200400001)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r1KmTAxd2PnhJ1DjWRJ1OK6Tey12YHXeP3Dw/fHv8/OQNcChkSxZSke1VHF5?=
 =?us-ascii?Q?iUFkRs4QYyKbtFF+1fMrJSUTZhmYOnBykL6sNonWRdrD4u2sVa9pQ9jkbGhF?=
 =?us-ascii?Q?tVwmu1rfJMtjiwCVyJxmfqaLDVc2xLfgvsm2yNMJrcSnl4fuNX90BmDIbaps?=
 =?us-ascii?Q?vFkFkl65Q3Sn3YwZd1VpMzQzP1sHkUFEuhZF2iu5B8R22k3NFqnZpMuHwvth?=
 =?us-ascii?Q?7/iMQztNRWhuH8ts1gL5tpEVH6f37KOdhxuY9fQ2h2CuJYki2RbD4y2biBdh?=
 =?us-ascii?Q?BezYuT2d/HvBV0nDL3pFNrDUH1byu3tTH2WwX2ikTPlSENsDRnqoYtLpncwN?=
 =?us-ascii?Q?XsEYVs1vih8GlY+0zzxlhfSpEWVV3UgW4eWkKhxnl2hRScRKKwrWIManop6/?=
 =?us-ascii?Q?7bU4oNzQwkQ9hIt+WmEHPUNK/7bvCFa/rKmLihUVA79kNreWuyewdMn+BFc8?=
 =?us-ascii?Q?/JjTlvGIYjuep7HpS/ukDfSLjA7UHp2N3BGjVCbND4gmi+1wq0gb8y5er3E3?=
 =?us-ascii?Q?dTZx2wNcQM6T69xe3DYNJGm7h6CbLT9THcjZKSyVRb6xCm2ZjrmUPsGncHp5?=
 =?us-ascii?Q?2tfj09b643it2TFydEKjigItUGQQSmh4YLKgz5p5KiLT/WIR3vDhA6h/w/gX?=
 =?us-ascii?Q?JeOU+tZvH1RwWLWx1dyWIFPzsbOvVbjm+XSRi58KYnojCHKfwpwfAfU/YCU4?=
 =?us-ascii?Q?7q7avLJGKt8tN+8P5KKLN3RYFYefzdtIt76Zk59k9OkcqEJz4el2RsXTyUoL?=
 =?us-ascii?Q?ttiSYa6kDoKPmLklNqJ3IQiTLWQBZ1+cyZsGQhoYd9eb6bL8vJQtPxNrxmMo?=
 =?us-ascii?Q?bDF8jFtkLV/wAM162Fge+B6LkUbp5PlJSVS6C3R2sJyuFda/FdRE8kIenYC2?=
 =?us-ascii?Q?yt8FEAVhJCfPpO8ToIe3xfUwekDPqoFd6KEkZhPwsPZbEGJ5oYWAaQ7ItE6t?=
 =?us-ascii?Q?fhx3sV5dBRH6rms31sPtwt/fiYPjSzPaDyGuGcE+rPvPwpEE7r/aawOkQUSA?=
 =?us-ascii?Q?TSI93lsV0W7ETyMi2Q+I/hM8n62x/Es1euIOh+wcbhPegJuta8yO7kLLtsXo?=
 =?us-ascii?Q?QyxFJp83opR02S3p55tIZ0vIn/Ni7yRx44OoX4lYvlm5aNyhNZKwArn6olHX?=
 =?us-ascii?Q?lYn+Sf/kQ1/cfxy6BTG7hCsIJUvJx56QSNFCn2gBSTEbI9pxoj9/IFJDSoFs?=
 =?us-ascii?Q?aJbS6kGk2iG+UwOwbpGQRDuK4SGhfblV9hQXSdN4hH9CV1GxcLnOD+fa9LGl?=
 =?us-ascii?Q?IWhj1sMjss/CWInBxZ/iWU0Ck2Nm2Hfgq2iwPXpFcP2ZzR3Y4duCMepO4s2j?=
 =?us-ascii?Q?6bZiboItYvaS3W2w8xzCUVan?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB522688A0B5F337FE81B8774AFBF19BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172f90e4-d4ea-444d-b87a-08d957282cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 09:13:51.2143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+kcE50SeMfxcFvCr0J0z1ks6M0hwsMhRgogagklCPtDWTKUHpipjPWzDWsQS4b3VlWsFCWX1QqeY7bWnmLdTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_BN9PR12MB522688A0B5F337FE81B8774AFBF19BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB522688A0B5F337FE81B8774AFBF19BN9PR12MB5226namp_"

--_000_BN9PR12MB522688A0B5F337FE81B8774AFBF19BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Updated patch with reviewed changes

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Clements=
, John
Sent: Wednesday, August 4, 2021 4:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS


[AMD Official Use Only]

Submitting patch to get RAS EEPROM I2C address from VBIOS FW info table.

Thank you,
John Clements

--_000_BN9PR12MB522688A0B5F337FE81B8774AFBF19BN9PR12MB5226namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Updated patch with reviewed changes<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Wednesday, August 4, 2021 4:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: set RAS EEPROM address from VBIOS<o:p><=
/o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to get RAS EEPROM I2C address from =
VBIOS FW info table.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB522688A0B5F337FE81B8774AFBF19BN9PR12MB5226namp_--

--_004_BN9PR12MB522688A0B5F337FE81B8774AFBF19BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-set-RAS-EEPROM-address-from-VBIOS.patch"
Content-Description: 0001-drm-amdgpu-set-RAS-EEPROM-address-from-VBIOS.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-set-RAS-EEPROM-address-from-VBIOS.patch";
	size=4757; creation-date="Wed, 04 Aug 2021 09:13:00 GMT";
	modification-date="Wed, 04 Aug 2021 09:13:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NWZhNGE2NTVkMDE1YzEwZTFmOWY4NzFhNTYyNDdkYWI3Mjk5MWUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgNCBBdWcgMjAyMSAxNzoxMTo0MCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8x
XSBkcm0vYW1kZ3B1OiBzZXQgUkFTIEVFUFJPTSBhZGRyZXNzIGZyb20gVkJJT1MKCnVwZGF0ZSB0
byBsYXRlc3QgYXRvbWJpb3MgZncgdGFibGUKClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMg
PGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KQ2hhbmdlLUlkOiBJZGM0ZjU5ZTAyZmNmZWQyYjdlY2U5
OGExMzJlZDFiZDNiMzc2YmJlMQotLS0KIC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0
b21maXJtd2FyZS5jICB8IDQwICsrKysrKysrKysrKysrKysrKysKIC4uLi9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2F0b21maXJtd2FyZS5oICB8ICAxICsKIC4uLi9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhc19lZXByb20uYyAgICB8IDE3ICsrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2luY2x1ZGUvYXRvbWZpcm13YXJlLmggICAgfCAgMiArLQogNCBmaWxlcyBjaGFuZ2VkLCA1
OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0b21maXJtd2FyZS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2F0b21maXJtd2FyZS5jCmluZGV4IDNiNWQxMzE4OTA3My4uOGY1Mzgz
N2Q0ZDNlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYXRv
bWZpcm13YXJlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0b21m
aXJtd2FyZS5jCkBAIC00NjgsNiArNDY4LDQ2IEBAIGJvb2wgYW1kZ3B1X2F0b21maXJtd2FyZV9k
eW5hbWljX2Jvb3RfY29uZmlnX3N1cHBvcnRlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRlCiAJ
cmV0dXJuIChmd19jYXAgJiBBVE9NX0ZJUk1XQVJFX0NBUF9EWU5BTUlDX0JPT1RfQ0ZHX0VOQUJM
RSkgPyB0cnVlIDogZmFsc2U7CiB9CiAKKy8qCisgKiBIZWxwZXIgZnVuY3Rpb24gdG8gcXVlcnkg
UkFTIEVFUFJPTSBhZGRyZXNzCisgKgorICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgor
ICoKKyAqIFJldHVybiB0cnVlIGlmIHZiaW9zIHN1cHBvcnRzIHJhcyByb20gYWRkcmVzcyByZXBv
cnRpbmcKKyAqLworYm9vbCBhbWRncHVfYXRvbWZpcm13YXJlX3Jhc19yb21fYWRkcihzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgdWludDhfdCogaTJjX2FkZHJlc3MpCit7CisJc3RydWN0IGFt
ZGdwdV9tb2RlX2luZm8gKm1vZGVfaW5mbyA9ICZhZGV2LT5tb2RlX2luZm87CisJaW50IGluZGV4
OworCXUxNiBkYXRhX29mZnNldCwgc2l6ZTsKKwl1bmlvbiBmaXJtd2FyZV9pbmZvICpmaXJtd2Fy
ZV9pbmZvOworCXU4IGZyZXYsIGNyZXY7CisKKwlpZiAoaTJjX2FkZHJlc3MgPT0gTlVMTCkKKwkJ
cmV0dXJuIGZhbHNlOworCisJKmkyY19hZGRyZXNzID0gMDsKKworCWluZGV4ID0gZ2V0X2luZGV4
X2ludG9fbWFzdGVyX3RhYmxlKGF0b21fbWFzdGVyX2xpc3Rfb2ZfZGF0YV90YWJsZXNfdjJfMSwK
KwkJCWZpcm13YXJlaW5mbyk7CisKKwlpZiAoYW1kZ3B1X2F0b21fcGFyc2VfZGF0YV9oZWFkZXIo
YWRldi0+bW9kZV9pbmZvLmF0b21fY29udGV4dCwKKwkJCQlpbmRleCwgJnNpemUsICZmcmV2LCAm
Y3JldiwgJmRhdGFfb2Zmc2V0KSkgeworCQkvKiBzdXBwb3J0IGZpcm13YXJlX2luZm8gMy40ICsg
Ki8KKwkJaWYgKChmcmV2ID09IDMgJiYgY3JldiA+PTQpIHx8IChmcmV2ID4gMykpIHsKKwkJCWZp
cm13YXJlX2luZm8gPSAodW5pb24gZmlybXdhcmVfaW5mbyAqKQorCQkJCShtb2RlX2luZm8tPmF0
b21fY29udGV4dC0+YmlvcyArIGRhdGFfb2Zmc2V0KTsKKwkJCSppMmNfYWRkcmVzcyA9IGZpcm13
YXJlX2luZm8tPnYzNC5yYXNfcm9tX2kyY19zbGF2ZV9hZGRyOworCQl9CisJfQorCisJaWYgKCpp
MmNfYWRkcmVzcyAhPSAwKQorCQlyZXR1cm4gdHJ1ZTsKKworCXJldHVybiBmYWxzZTsKK30KKwor
CiB1bmlvbiBzbXVfaW5mbyB7CiAJc3RydWN0IGF0b21fc211X2luZm9fdjNfMSB2MzE7CiB9Owpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0b21maXJtd2Fy
ZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0b21maXJtd2FyZS5oCmlu
ZGV4IDFiYmJiMTk1MDE1ZC4uNzUxMjQ4YjI1M2RlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYXRvbWZpcm13YXJlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2F0b21maXJtd2FyZS5oCkBAIC0zNiw2ICszNiw3IEBAIGludCBh
bWRncHVfYXRvbWZpcm13YXJlX2dldF9jbG9ja19pbmZvKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KTsKIGludCBhbWRncHVfYXRvbWZpcm13YXJlX2dldF9nZnhfaW5mbyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldik7CiBib29sIGFtZGdwdV9hdG9tZmlybXdhcmVfbWVtX2VjY19zdXBwb3J0
ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogYm9vbCBhbWRncHVfYXRvbWZpcm13YXJl
X3NyYW1fZWNjX3N1cHBvcnRlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Citib29sIGFt
ZGdwdV9hdG9tZmlybXdhcmVfcmFzX3JvbV9hZGRyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCB1aW50OF90KiBpMmNfYWRkcmVzcyk7CiBib29sIGFtZGdwdV9hdG9tZmlybXdhcmVfbWVtX3Ry
YWluaW5nX3N1cHBvcnRlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiBib29sIGFtZGdw
dV9hdG9tZmlybXdhcmVfZHluYW1pY19ib290X2NvbmZpZ19zdXBwb3J0ZWQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpOwogaW50IGFtZGdwdV9hdG9tZmlybXdhcmVfZ2V0X2Z3X3Jlc2VydmVk
X2ZiX3NpemUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMKaW5kZXggZDJlNWIyNTY3YmMxLi4xOTQ1
OTAyNTJiYjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXNfZWVwcm9tLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19l
ZXByb20uYwpAQCAtMjcsNiArMjcsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2JpdHMuaD4KICNpbmNs
dWRlICJhdG9tLmgiCiAjaW5jbHVkZSAiYW1kZ3B1X2VlcHJvbS5oIgorI2luY2x1ZGUgImFtZGdw
dV9hdG9tZmlybXdhcmUuaCIKICNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+CiAjaW5jbHVkZSA8
bGludXgvdWFjY2Vzcy5oPgogCkBAIC0xMTYsNiArMTE3LDIyIEBAIHN0YXRpYyBib29sIF9fZ2V0
X2VlcHJvbV9pMmNfYWRkcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlpZiAoIWNvbnRy
b2wpCiAJCXJldHVybiBmYWxzZTsKIAorCWNvbnRyb2wtPmkyY19hZGRyZXNzID0gMDsKKworCWlm
IChhbWRncHVfYXRvbWZpcm13YXJlX3Jhc19yb21fYWRkcihhZGV2LCAodWludDhfdCopJmNvbnRy
b2wtPmkyY19hZGRyZXNzKSkKKwl7CisJCWlmIChjb250cm9sLT5pMmNfYWRkcmVzcyA9PSAweEEw
KQorCQkJY29udHJvbC0+aTJjX2FkZHJlc3MgPSAwOworCQllbHNlIGlmIChjb250cm9sLT5pMmNf
YWRkcmVzcyA9PSAweEE4KQorCQkJY29udHJvbC0+aTJjX2FkZHJlc3MgPSAweDQwMDAwOworCQll
bHNlIHsKKwkJCWRldl93YXJuKGFkZXYtPmRldiwgIlJBUyBFRVBST00gSTJDIGFkZHJlc3Mgbm90
IHN1cHBvcnRlZCIpOworCQkJcmV0dXJuIGZhbHNlOworCQl9CisKKwkJcmV0dXJuIHRydWU7CisJ
fQorCiAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKIAljYXNlIENISVBfVkVHQTIwOgogCQlj
b250cm9sLT5pMmNfYWRkcmVzcyA9IEVFUFJPTV9JMkNfTUFERFJfVkVHQTIwOwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2F0b21maXJtd2FyZS5oIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9pbmNsdWRlL2F0b21maXJtd2FyZS5oCmluZGV4IDM4MTFlNThkZDg1Ny4uNDQ5
NTU0NThmZTM4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXRvbWZp
cm13YXJlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2F0b21maXJtd2FyZS5o
CkBAIC01OTAsNyArNTkwLDcgQEAgc3RydWN0IGF0b21fZmlybXdhcmVfaW5mb192M180IHsKIAl1
aW50OF90ICBib2FyZF9pMmNfZmVhdHVyZV9pZDsgICAgICAgICAgICAvLyBlbnVtIG9mIGF0b21f
Ym9hcmRfaTJjX2ZlYXR1cmVfaWRfZGVmCiAJdWludDhfdCAgYm9hcmRfaTJjX2ZlYXR1cmVfZ3Bp
b19pZDsgICAgICAgLy8gaTJjIGlkIGZpbmQgaW4gZ3Bpb19sdXQgZGF0YSB0YWJsZSBncGlvX2lk
CiAJdWludDhfdCAgYm9hcmRfaTJjX2ZlYXR1cmVfc2xhdmVfYWRkcjsKLQl1aW50OF90ICByZXNl
cnZlZDM7CisJdWludDhfdCAgcmFzX3JvbV9pMmNfc2xhdmVfYWRkcjsKIAl1aW50MTZfdCBib290
dXBfbXZkZHFfbXY7CiAJdWludDE2X3QgYm9vdHVwX212cHBfbXY7CiAJdWludDMyX3QgemZic3Rh
cnRhZGRyaW4xNm1iOwotLSAKMi4xNy4xCgo=

--_004_BN9PR12MB522688A0B5F337FE81B8774AFBF19BN9PR12MB5226namp_--
