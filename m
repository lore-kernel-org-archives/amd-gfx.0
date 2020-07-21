Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B5FC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 11:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AE1206F2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 11:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Pozchla4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AE1206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711696E175;
	Tue, 21 Jul 2020 11:11:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447806E4AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 11:11:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F92CXpZbkJ9Me2PRnJ9PzBNUwxC/Z5J1bxIVJE57+l55ySGHRNKA3LcyQxuuJaPebpe6S0Tm+q6UQZxB1js1hTYNrMpuTkm+C2ovkkLcmlevMuzKoD+8xL257dR4ussjj1ZRNyZqWnYazmkeDCzJEHQjaQviCLP7miZwQk6taUBqJqHuWu74OeugWS+RP+/YKMqZX4Bhcakht4Lsr0s8UbNMPZaFGYiOIhRhg6PDre76bUvv/QLjOGPhFo4dmjg570C3jltgh0A9VNaPdOIb7o/tw7OBnntlbl8jCQhyel0O5vNR5oA/ulw8qkBGFszU18oIVSgYiqntb/jkxDkzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbHEKRm/gCq9sa0ddMHy0FGWC8S1DCltXPAWVkA7qfc=;
 b=K4Vszs+nB/+SoPCSEFSJdbHF4AQNX+rIWbeCfjyWoAffbrJjQUmA1Ag++KdYjRkf0mbmhTqfG3lR5FxuK8lFp1ifOTnX/oIxAE5h9tlZXsUKzzBP5Mg8/0CN7Pv2lqTyAO57GdKKoLQLBrDAGN5dwNUPxlGAL/Kji7WeiHeCb7yMdaAihRyPphJHFOeeBfTNOjsctOFeTkH5/mEyZoVlHeo0cQa6OhMK8r5oJZpW28D3GvRip2NqBM3Ov9x+kyCQ4lnBMqCnSTYI+djp/FYNDCrkrYMfqxoKfHJ2ISvoKpfSXL99u7kll5dQazPEm6gd7uw+1PqLuLsz7GYLKkzcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbHEKRm/gCq9sa0ddMHy0FGWC8S1DCltXPAWVkA7qfc=;
 b=Pozchla42GExvRIzr0TP6Q+AedJU/CYUIb9MztNMoJROM2nkom8IirV75kSAHtHSBUMpTJtIITzMPVAI0WCjUcfTRA2825JTNh0ozj7g/a5EJ9vK5UeKzDFT2yuW4JNPFdGVHpUCWtvmEE0FbOW4PxDfbQPeClktAMJgJkbN05A=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18; Tue, 21 Jul 2020 11:11:00 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%8]) with mapi id 15.20.3216.021; Tue, 21 Jul 2020
 11:11:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chichlid
Thread-Topic: [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chichlid
Thread-Index: AdZfReQyfeCz96ROS/qexdQQqwQahwACUXwA
Date: Tue, 21 Jul 2020 11:11:00 +0000
Message-ID: <DM6PR12MB407565C7AF933B6B90687F93FC780@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4032998A82134DFD3D09739EFB780@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032998A82134DFD3D09739EFB780@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-21T10:01:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0ead8133-92be-4bec-a672-0000b76dc115;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-21T11:10:58Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 3d0b58e3-264d-4fac-a63b-0000f67cd7ae
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9b92a42-35e0-4d94-4323-08d82d66c021
x-ms-traffictypediagnostic: DM6PR12MB4385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4385AE3AFAC9DC23E41EC696FC780@DM6PR12MB4385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESx+Gpc0EuBJulVF/pm8vBAlXGkh6d3v4FnFBvlJZZ0X5xTYGrGahztDE4m7EbD3oG38CNmMBFaL0No09XZsms18LDCxNGNPa2U61aGO/NxwHJikV1i6PbUaHcH8TLoezBKxjGQtPxoE8bg2l7XS2UJ57D1yet4x4Zh6uTRAmHLU6il0TM9s5LDwb7mpYA262uaaMKeaCY668Dnx4vKpC1CGEQ6FVjAmocoOsbg+B3StXWvdMjZYbGoCHGJRF95oFRbD3XFqpKEVJ1s/Kcxata3nOkPGlhQzQ79cR2lDLLjTaO5/0an7ODMG6GQ7fdCt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(110136005)(71200400001)(8676002)(186003)(26005)(478600001)(6506007)(7696005)(66476007)(66556008)(64756008)(66446008)(76116006)(53546011)(66946007)(6636002)(2906002)(52536014)(316002)(55016002)(8936002)(4744005)(86362001)(9686003)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LYgncUbFJHROzZjxUGpZ4IzPjtZw55hPp2y1ZChX+W1iNkCR4ycrtyHx45X4b4QeUjjOcVy9mYOYnx1KLa7CPN2RFUR/4brzlkdWTkPSVG7jmuYbyoJgRVsHnAmgzaNaI6VP1gmiaeIft7mxHcZDWqCISiP7YgXFf96s/1cMJ9/Wz8JSWs0jh04r44yLGebmDjLqDlSdY/+E3aCNpzyyChQJwGxLSpEDm/0QB34rof/vKtjnnzSYEiiEwMQx8b8LUpPhqE7rLvEgI43gb8Q3FG6ZV7qNxwEKpzfJx+z7WIY3c8jgFJ6C4a+4xYBaMfnjJ8rlQiGLXiDYr+VPOZ/kfY90Us/2Engs0v8OR+/GU1B+fC+uY/5V/Hx5fVmWhuWefIIJRV7PNDL7368ofjonPjkHCHxGiSGB4pytqygxSXz+rmnoU/kjIUmr7eKAp6h1Prq4l1UJG7Va7lFtnneu+lwVgaxc2Vf6Ytd3hx0rQyG789/8ei6LY0DE0g2oaMVs
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b92a42-35e0-4d94-4323-08d82d66c021
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 11:11:00.4860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txj0OO2ZU5KnswG30mDf+aVU3BrQhgImFvnJ4qmLB0kvcU8Cckn//bAp0z6JGSCeZYglGurPm1h0Yt/YNfmB9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
Content-Type: multipart/mixed; boundary="===============1228570388=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1228570388==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB407565C7AF933B6B90687F93FC780DM6PR12MB4075namp_"

--_000_DM6PR12MB407565C7AF933B6B90687F93FC780DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

-              if (adev->asic_type !=3D CHIP_VEGA20 && adev->asic_type !=3D=
 CHIP_ARCTURUS)
+             if (adev->asic_type !=3D CHIP_VEGA20           &&
+                 adev->asic_type !=3D CHIP_ARCTURUS         &&
+                 adev->asic_type !=3D CHIP_SIENNA_CICHLID)
                               return 0;

Does it make sense to check UMC RAS availability through amdgpu_ras_is_supp=
orted, instead of check specific ASIC type one by one?

Also, it would be good to merge the upcoming logic from Guchun where we hav=
e a gloal flag to mark the availability of bad page retirement.

Thoughts?

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, July 21, 2020 18:02
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chichlid


[AMD Public Use]

Submitting patch to enable RAS EEPROM support for sienna chichlid

--_000_DM6PR12MB407565C7AF933B6B90687F93FC780DM6PR12MB4075namp_
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
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
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
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_VEGA20 &amp;&a=
mp; adev-&gt;asic_type !=3D CHIP_ARCTURUS)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_VEGA20&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp;<o:p></o:p></p=
>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; adev-&gt;asic_type !=3D CHIP_A=
RCTURUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp;<o:p></o:=
p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; adev-&gt;asic_type !=3D CHIP_S=
IENNA_CICHLID)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Does it make sense to check UMC RAS availability thr=
ough amdgpu_ras_is_supported, instead of check specific ASIC type one by on=
e?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Also, it would be good to merge the upcoming logic f=
rom Guchun where we have a gloal flag to mark the availability of bad page =
retirement.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thoughts?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, July 21, 2020 18:02<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chich=
lid<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to enable RAS EEPROM support for si=
enna chichlid<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB407565C7AF933B6B90687F93FC780DM6PR12MB4075namp_--

--===============1228570388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1228570388==--
