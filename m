Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602DCC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 01:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4A66128A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 01:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4A66128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742956E05C;
	Tue, 13 Apr 2021 01:56:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E02EA6E05C
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 01:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPfQfe2DniplMltYrOK9qt3OAgKIen+ax3K+x8uLGD1zU6Ljkgz5PONCmEzr4pueiZD5aHel1YJU4KGAYak9d6LMmb9gC7k9aWyDF+/Pb/tyrWfqOl7XX3BUv99NLH3ZtR7T+yA5mlCLlx6Rbqu/WXZbrrsirkdkXk+en+o1j/D4W8lnvipHNJXzbCbUFjcyC8qPYZr9ETSyK2uFrTCenlhVgSwJHV1zWUOtTuywuSuqVa2Q7ityweVbWJUMdR1TOInJ8+ilJ5zLzy/ApuoaETTEbOibbp2M8C3mJtmZN5fGuBNdtuKuXLAk4eG3FjFdZvHEjZRUAlp01zNaUQhjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q528229/RS16Y7tnv4wIylev7gBXKNowRTZl2WtXK04=;
 b=VvvKPUGY1UqwMXYwrOw13r18xwSiJKnqAiTeq86qr9vKDX3mw0EtBjaGS7S+vqZ1D64RMKiXJ9DpJ5oTtgc8w+YgeVrcxAZ+tFxxCSnOL2rGB1w+iyENNgZpWraC0VbVocuhuNZshm+MIZdkoKZ0NDfO5YV6q8h8u6Bb1iImn2CXUE5ixGnO/l2KkMB6Afs5CEEt4d3S8GzfnD4p8ijv5xF+A3hWZZjc6FWXuuqFgXW5QuuTcdem9jI1GhsxOgVqrGjfnSZTCjxACvc1SxlZL9LTh1lrWy7KZCVmcapSduPSz61uvOsTjFPvLmS4Of7PCEaotcrUCAMFsiRUz9EXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q528229/RS16Y7tnv4wIylev7gBXKNowRTZl2WtXK04=;
 b=AQDIVtEoU1TrjwryMPYY6wh98jFjA5UX+NyXBKU3fy6gEtmIXRIhZaZHQc0YfX4KjYu7MfkbshD9DDU5yBuPkqnZjGY4fv5L6cadF3c3wQ8dSXLEFkp3VvN9hTmU855bjx3b+twVW9keFr2VpllzFGSV7eutHeSFIf0ojMwAgh4=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3294.namprd12.prod.outlook.com (2603:10b6:208:af::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 01:56:04 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::8da7:cf00:1356:1199]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::8da7:cf00:1356:1199%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 01:56:04 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Ensure dcefclk isn't created on Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Ensure dcefclk isn't created on Aldebaran
Thread-Index: AQHXL7Uf90KVpPpHkkS8mCNpepHoIKqxsNIC
Date: Tue, 13 Apr 2021 01:56:04 +0000
Message-ID: <MN2PR12MB302292961799AF99B9974170A24F9@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210412160121.27434-1-kent.russell@amd.com>
In-Reply-To: <20210412160121.27434-1-kent.russell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-13T01:56:03.914Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a891e18e-4fd4-44e9-3417-08d8fe1f4c0b
x-ms-traffictypediagnostic: MN2PR12MB3294:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3294C73F966F227B5B1B7AB4A24F9@MN2PR12MB3294.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:305;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3LS9eqzlrhlwCOc+c1/7HrYBoYMCK6O4MppNTsCQOTcGO7zU341oExs7GeFHL6kbGivHUMlGCa5C9urPzmGO3n0GB9Sas69/u+xvVIqE2pvMXae+V+eYUlGsWZEOF27RuEfb8Cpt5Pr/PR5o2bWn/0Ko72gbYPvaJY5yjQYCk4cWcw+fcMWLQo1XDEtl2zYT6Q/Ferhi7d3sxKIArYZUFK+l1X680fd1FZdtDt8QFbcxGwiytYp7eK/HCMWIcqDtkl3obBZxT8/ezcaqDrl33uVRnTUGsiT5tcQG2rSijjRryW1YZvYkGHA8eOrSVdq4sYWGq/rGSip0XD0uFyPX2CAYZpRlTSDPrs+elulgo/buAwX4bx7KnhlHtozktnf7BlZKGBCN6LRqE01keFtXQZYht0l02CjSEbVPECxW/sGaMOevN7NF/Jan3qlscwSc+EM7sWqoIRPXE0WwCNVSv1XFG44Ua8I5o32LkzIuQEiiDk6R10EnhNfDHfKXgN+fSEl9Hb6uHezgnUzSL2NErGwesDCWZ7eATWvtKyxPC2Z0oXZit5kWhT+YCZkzDHxzcXUu5fyttxC3awYR1gFULei56N9ATkwvnBrcvOuyT8tmEe7W/s1lfLxJT/gJ039
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(83380400001)(66476007)(66446008)(64756008)(966005)(66556008)(166002)(8936002)(38100700002)(66946007)(9686003)(7696005)(52536014)(122000001)(55016002)(76116006)(86362001)(19627405001)(71200400001)(91956017)(478600001)(45080400002)(26005)(110136005)(2906002)(186003)(316002)(53546011)(6506007)(5660300002)(8676002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?o5Z+2FwZapo7fdyner53FuSiv20X21K4IgJq3NW1t0TXH/hv86qhWgrhuj?=
 =?iso-8859-1?Q?KlsjtC5WM/NO58idytOVot5w6V9ykp777/pXEaP5wijAG/NCdrX9zJ83aC?=
 =?iso-8859-1?Q?qv/3jCS42+ZtgHj/p9pQ5PixEAo/uEDMlX3YBaEez8/6IApg2WsH9g5vdq?=
 =?iso-8859-1?Q?34YCVRROh+2xOrcS77D/kdAXIoB/vTgdvEfDtkAgGbIGMtnN2IuLWJ6Spr?=
 =?iso-8859-1?Q?t1mlguXX4IKVkn5FiCq6KLSy/NfxgpPiY0vsqCZDGU0y+x6HYq9XrVoTnp?=
 =?iso-8859-1?Q?FQdnBl3HVyyunmMP4wBxp+OjcoEWfqh2DSHQr7SQw11H+xtWJnYfylc1ms?=
 =?iso-8859-1?Q?DrK6vP9JofvImmEBk+mIh+dhBuryjKwkc6v2M9wlQFAxdtifouP1yEGaRZ?=
 =?iso-8859-1?Q?6DeEmqypBid4zhi6k85U+oDAo22N/OEXfZ1Q40ExBK8Bs0+TCpNqvllwk0?=
 =?iso-8859-1?Q?TLH8f5om27F9ta7BX2CyvCumo6/4wxrEUsnqzNs9rXX6W7lzgS5jZ6jyhy?=
 =?iso-8859-1?Q?ZEzCYA7giUtjrN+IAeiHdRKMzLzB1bVquCQ5ZMupHhrLIlkRnVn1rOysRu?=
 =?iso-8859-1?Q?MU8nemwzRn0MpZ9jsFXY5Lb0at2msglI/0+aIp3Om3mTJLGMY3Gq6CaCUa?=
 =?iso-8859-1?Q?qf978Fi1d2TiXfWo90d9MvvnBdv47oYHTtR1wUjj7P1KEQjHUBIbSxgExv?=
 =?iso-8859-1?Q?GQDHW0TTCpjxoZtK5bY1OS55N4RG/firZHCOFTZnugdA7dgjCfPFD0RuPg?=
 =?iso-8859-1?Q?O6QaZL0bSQ/OHDsa29C6ucG4LXnAv5vASPEPhi8qXiL/5gE3CKoausFwY3?=
 =?iso-8859-1?Q?ymCjr8sOxm2p1NG92ATK7c6hBdjVCgNY0bf6y63aub0D15gWabpvQnWJ3B?=
 =?iso-8859-1?Q?T/TN35hfFnEMRLw9pnikl+g+R02xnMI+JxNGkwEdv8vaOlMCWfHU5KAnXs?=
 =?iso-8859-1?Q?clkwko5Hez3FfNnQviGshSZaHQK8Dz1daPvzq5QR/jNau+72Myke8wQoeW?=
 =?iso-8859-1?Q?YzFHzcGaKO8xuv8abGE5tQGUllAaYY5Opszj3to3v7uOOxErKkL//fgIqE?=
 =?iso-8859-1?Q?jQ4f/tM2a8ozTjdT049Szn41Slv9aYOWaPLkKVyimB5ukgLy+Nr4eCcOXx?=
 =?iso-8859-1?Q?Vq3WNpUZBhSb1ONUNoiS5aWV7z9WnVF3h7u0NCDpJ4dWn0SIWBN/rrDyQV?=
 =?iso-8859-1?Q?t4AU1EYrip52691Erh+V8sYnwOGyXE6DFyTxmAePldlZZu8m+NEPyAcCrm?=
 =?iso-8859-1?Q?zSMtRizoeWQKVkD2Qva6yn63ZqQT3MGYDfKD5Rx9hHacnWw1VXPu7hdaJ7?=
 =?iso-8859-1?Q?1dV9gAGqws2iHvUbIW1kB5mxX2IpUSySOzUPsxDdiplETktzlVnPv3+ki/?=
 =?iso-8859-1?Q?tZ+su8v6qI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a891e18e-4fd4-44e9-3417-08d8fe1f4c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 01:56:04.4350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CA6f1zHC2d4nxdaak9zUd1xMcqgllKftRO9E+qzE9gZpL35EKJgpoDEUb+sDtE14
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
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
Content-Type: multipart/mixed; boundary="===============0984274998=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0984274998==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB302292961799AF99B9974170A24F9MN2PR12MB3022namp_"

--_000_MN2PR12MB302292961799AF99B9974170A24F9MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Tuesday, April 13, 2021 12:01 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdgpu: Ensure dcefclk isn't created on Aldebaran

Like Arcturus, this isn't available on Aldebaran, so remove it
accordingly

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 204e34549013..8128603ef495 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1844,7 +1844,9 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
                 if (asic_type < CHIP_VEGA10)
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-               if (asic_type < CHIP_VEGA10 || asic_type =3D=3D CHIP_ARCTUR=
US)
+               if (asic_type < CHIP_VEGA10 ||
+                   asic_type =3D=3D CHIP_ARCTURUS ||
+                   asic_type =3D=3D CHIP_ALDEBARAN)
                         *states =3D ATTR_STATE_UNSUPPORTED;
         } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
                 if (asic_type < CHIP_VEGA20)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7Cfd941c0d1ed74008200808d8fdcc410f%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637538401004011497%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DQC=
2OVTdnome3ImpIFdKGJ6FGrex6AtYFDkRzFyv8vzE%3D&amp;reserved=3D0

--_000_MN2PR12MB302292961799AF99B9974170A24F9MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 13, 2021 12:01 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Ensure dcefclk isn't created on Aldebar=
an</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Like Arcturus, this isn't available on Aldebaran, =
so remove it<br>
accordingly<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-<br>
&nbsp;1 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 204e34549013..8128603ef495 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -1844,7 +1844,9 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (asic_type &lt; CHIP_VEGA10)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_dpm_dcefclk)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (asic_type &lt; CHIP_VEGA10 || asic_type =3D=3D CHIP_ARCTURUS=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (asic_type &lt; CHIP_VEGA10 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_type =3D=3D CHIP_ARCTURUS ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_type =3D=3D CHIP_ALDEBARAN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stat=
es =3D ATTR_STATE_UNSUPPORTED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (DEVICE_ATTR_IS(=
pp_dpm_fclk)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (asic_type &lt; CHIP_VEGA20)<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Cfd941c0d1ed74008200808d8fdcc410f%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637538401004011497%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DQC2OVTdnome3ImpIFdKGJ6FGrex6AtYFDkRzFyv8vzE%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7Cfd941c0d1ed74008200808d8fdcc410f%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637538401004011497%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DQC2OVTdnome3ImpIFdKGJ6FGrex6AtYFDkRzFyv8vzE%3D&amp;amp;res=
erved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB302292961799AF99B9974170A24F9MN2PR12MB3022namp_--

--===============0984274998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0984274998==--
