Return-Path: <SRS0=Xhap=HJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CEEC433E0
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 13:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC78D64E50
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 13:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC78D64E50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D0C6E194;
	Sun,  7 Feb 2021 13:24:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770042.outbound.protection.outlook.com [40.107.77.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E756E194
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Feb 2021 13:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAi6Iil+I49Zvey3lVODepGCQSP7C0BklJkl85xfLvBCV1TCJenCTMeUkDiEV0F/EMnLTvYXldkjcA2KHImW1hphMEVOW4uQk8zNys5SWFwRsI+yFW+fqZi4lAbsWVI1Go4wWNSG3omoquUMS5diUuisNraY6A69HRL6h4GKEOCBTBD5s2dRTpXr7OfB71Pdq7eim2NmpRUL0lMhsV6K7Sgkl7pmw2H4Y+y9mDX7/vv9SYOwetMm5m60VF38Td7gchqPOk/2LLEJ45NUQC3t8nm7rJyiYkooLezSuw1DwT+XXAKZeSSn9Bo/vZ0UxKzk07rXO48MLj8bfMvOsiepSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J639Drnw6SHwh1hIOz6mqGK0oun+w9R9/RZNSRS1Usw=;
 b=EoeCgTh+RhFoHcgLd3knZJCf9MjknnLCfSelCS89meoQ3iTHpEVxTJ4X5IAcnoOWzZiDJs/5/TWtFG6REyKvnEouFpj/lhnVL3NIgtECS4Qjz23EpNmb11Ivem8szAQj8uyv6fofXHPC+56fuiPS3U2hRm2oG0Q+7khaaTYcP818oHWQ/qICamg6eGH/XHFPCjtVJf5zc06PY/lCX2F2UuVB2GQHwYzKMTCJHPtBrDmtLsDBUF8+zj6zUPG3amt3BID90IcKyx0D2GKBz37YE7qw5D6EQ37Q1BEND5+xkAdjoeaXO5cinR8z01YUgYcc+vUtUv1g3M+AELBAqMfsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J639Drnw6SHwh1hIOz6mqGK0oun+w9R9/RZNSRS1Usw=;
 b=k9r28yLct6h4iXfrVypmyWOpr6mnnEt+8plRT6VXpZFvkm3qdh67fl9TAHZ/ctj8j6cXQN7RpA7sexskZOKMueIS9jp9hNPBF0c75YjCZHCLA28yGkjAWCDeGyF0oMd9rkqFdJmHqD8xmq9sgh01PKb4q/uL62Xr9be1eDNWo7I=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.24; Sun, 7 Feb 2021 13:24:16 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::e008:e79e:33f0:bdf]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::e008:e79e:33f0:bdf%7]) with mapi id 15.20.3825.030; Sun, 7 Feb 2021
 13:24:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: =?iso-8859-2?Q?Marek_Ol=B9=E1k?= <maraeo@gmail.com>, amd-gfx mailing list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix CGTS_TCC_DISABLE register offset on
 gfx10.3
Thread-Topic: [PATCH] drm/amdgpu: fix CGTS_TCC_DISABLE register offset on
 gfx10.3
Thread-Index: AQHW/CG078GFYNbQZkuvIhVg4CZUJKpMsLMg
Date: Sun, 7 Feb 2021 13:24:16 +0000
Message-ID: <DM6PR12MB407525DA714DB612BA630886FCB09@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <CAAxE2A4EvpSwAgGucFq-KySskiiE-PKuKVB_KiwEKi3tbqL5MA@mail.gmail.com>
In-Reply-To: <CAAxE2A4EvpSwAgGucFq-KySskiiE-PKuKVB_KiwEKi3tbqL5MA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-07T13:24:14Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=be723ad3-58ab-4c16-b647-47b1578227f5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f4d7e86-5231-4aa0-6e31-08d8cb6bab42
x-ms-traffictypediagnostic: DM6PR12MB2892:
x-microsoft-antispam-prvs: <DM6PR12MB2892D8AFF2F7B30D6D206E83FCB09@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wd4oHk/YZ6/JSieM/NEW9VCdcJUZPgIZojaNjrkbWfUnFUW4oaWYqE8Y084D+906CaVoPTYTIHnjMr++WRGf8nheazJWmqfswQRmHSdJwpU8oFUIXNc/vunDcQsQWB3FADYk3eWcRwP7rOLkGSBx/1bEc/lfrLVCJAFXT3rvMpznwBz87/lhCWUqEGffDJq6hjNb3U81KK3jJoWXxckfKYU+Nqw8MZfcKC9POFL+icO//rKfS4B/IEsrGQKWw5Ttvkhme0OuyDkMM1RWp8whJSCfCe8+gf3of+TqsKuIc2LM49eVu1y0tTFWNzwSadq4txbc3dVZCOFZx/Oi3w0cltoRaefmCkuNGQ1zW1n80kJMspAvYR50qryfIKJy0JuNIsqcm1FJAwUIyIQemmo6sY5tDa5I+TR3ajW7x1eTPTnlUie8shhJXWR8gJzAlr8piZn/qO/nJZb/piYI7HyTlPSyxgt8ifXMd8aGbKegcxwL/RM6XXme/MS+6xPAEqOf7Iu/HdK9KNiFX1sbBVOHpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(316002)(33656002)(8676002)(110136005)(478600001)(9686003)(64756008)(86362001)(7696005)(66946007)(2906002)(66446008)(66556008)(53546011)(71200400001)(186003)(4744005)(66476007)(6506007)(26005)(8936002)(76116006)(55016002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?3IR+gO3XDaJCnK1RzEFJl2cOSlBFZe/FWRPQp3jc6LMfh/Jy2W2hHY51vy?=
 =?iso-8859-2?Q?GrMXaSl6ppQcrNKAlA1aqWT9fZi3JMdytJ99uF9Lsb889WOyfmr8wHkokV?=
 =?iso-8859-2?Q?XpxBNlxzLOSfht04XUkieH/lKUZMIC6LoZnp/zWM6d9J/maJVeMwCQMfXh?=
 =?iso-8859-2?Q?zmFCHm3mMzCH/Xvlc0l6joQjpFjUZJr4sHh/iUKFoVLXDUq7lKyUe6bmCG?=
 =?iso-8859-2?Q?natHSskFgikVuBMJbSo/jjTYWwwnZqPZc6YxwzTMcZNx3D6kC137bVgt6B?=
 =?iso-8859-2?Q?3p6zCc6MYEQCcUuNbtjB2d9dJJ3hafJ3dHO2fls4pi+MXWgVEaHkZh4/aM?=
 =?iso-8859-2?Q?LJApYO5TJoCEqCOPPnr6qGiFNz9gMPL5o/TtkUx6VqpHfoQ7pN8iQNLsVR?=
 =?iso-8859-2?Q?hriBm7h3nOMiKopoJ5lHDb1DwsKpoe290dFqFgBPBDVSlMvAykbcpr8JpH?=
 =?iso-8859-2?Q?ga773czsYEYwpiRrWXrz/a7CZZOv6p6xCEG9pzMjF8GKzSWk7Qb2rfvBNy?=
 =?iso-8859-2?Q?RJdafY5Q/yrlBLXTZOyxMT59OgeDYxIF8BMvO/Xh27o/0YBQJiaVI2sHzh?=
 =?iso-8859-2?Q?FUSdWH+zh7U/awhIkqaW6ADwOgVaEHStPP/llRDamCfhZOg31pPKl3RUBT?=
 =?iso-8859-2?Q?cyYh+Imd0C2cWAmotVZYgHX06QkzJCF4rNz+lojdvqrR7JNI6EYKxK6kAb?=
 =?iso-8859-2?Q?w0PwmnCL9vAj9H9devHSsAbT11KbauV58blUFLHaXDOIYwSCWebxtARKBE?=
 =?iso-8859-2?Q?NazovuMWyuWy4xjDTXg9xN3lKWGXX7W4HlmuTpGCw62bff/6Wh83YcwcGe?=
 =?iso-8859-2?Q?DbGZ1sGIluDwoEXldClZpRO9S7LVCBqnvOuLCrw0MOZFc8JddwWYDPAlak?=
 =?iso-8859-2?Q?76DImNb/24DajS+XychUDpF7IuBfbb3GFGoLMHNqPqKtGIWFBza5SGjRes?=
 =?iso-8859-2?Q?XxNUO2ptO+05drwamOyBCCwIh9xY7X9mzRz6amNEJpCZDeGHYN/GE4i6h+?=
 =?iso-8859-2?Q?GxZfVc+8f1lUwBIOnj5kDCk5g/GEMfTqgg7NY2soyq6ktdTYklO13o7hzY?=
 =?iso-8859-2?Q?M8OMv0B3EcljzWSX/2uDaKasoQ/BC81zO822+wnXEQnQ2kYmOMKClogQf9?=
 =?iso-8859-2?Q?9om059kHrvg/qyX06fiK4SiH08qB8stWpOSMOrw4xU+xwXQcv2OT/bbV5w?=
 =?iso-8859-2?Q?eeCFtCK2Q24cjAFchtWYGvmukZO9PMbsK9Qqo5InXPzW/qRWbFZp07Le5d?=
 =?iso-8859-2?Q?dyN1cM0WDfFNUZ6uuXTYc2b7Q2g6S4X8omDPPUvMyYphtgq+WQu2qv4cSE?=
 =?iso-8859-2?Q?BXnJniEEU3X+kX46KhqqTgEvH0CSbJEmyQBOYWTB5ot028xQUjew5Y9Fdt?=
 =?iso-8859-2?Q?xp3wl3buXm?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4d7e86-5231-4aa0-6e31-08d8cb6bab42
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 13:24:16.5573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwzTr1tKF0KVBmoPqWY2/Y9gZbOZpo1BfORzqPVlbu7HJFSZQFRowzBcIe9Di/Y/Dv4ITMIdtvuVvOyVBUOQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Content-Type: multipart/mixed; boundary="===============0600093136=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0600093136==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB407525DA714DB612BA630886FCB09DM6PR12MB4075namp_"

--_000_DM6PR12MB407525DA714DB612BA630886FCB09DM6PR12MB4075namp_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Marek Ol=
=B9=E1k
Sent: Saturday, February 6, 2021 08:47
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix CGTS_TCC_DISABLE register offset on gfx10.=
3

Please review.

Thanks,
Marek

--_000_DM6PR12MB407525DA714DB612BA630886FCB09DM6PR12MB4075namp_
Content-Type: text/html; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
2">
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Marek Ol=B9=E1k<br>
<b>Sent:</b> Saturday, February 6, 2021 08:47<br>
<b>To:</b> amd-gfx mailing list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix CGTS_TCC_DISABLE register offset on=
 gfx10.3<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">Please review.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Marek<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB407525DA714DB612BA630886FCB09DM6PR12MB4075namp_--

--===============0600093136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0600093136==--
