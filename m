Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69949C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 08:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC2810E734;
	Wed, 12 Apr 2023 08:31:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C68710E734
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 08:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEsci26nhWnZwKMA3skiaKLKnEXAJ/xAJHY+zOGlNDcUdNTVlyJ5fzRhGdWdovfDWOuZ58WWcK4YgVVb7qBx7Q/YNEDmswQ5Rlfsz4xf4z4vKdhL2d1dxhlYghJkI2eL1Ln5HU4LfNEzVn8X592R2vSOw4+ufQvr63dwtIKr5ICKaVGVp7/X6IvPij13xee2KPDsmKjrWIYO5MUqhWowy9IM77XNahW+lhvPXSZujOurC48H4Yj5+ROIzEoF+17+r+txEDUQ20N2HDpew4dNBK6/qzdzh70pFWIKzon/KCu5JOw3nn1mkq96D4CdbVmNi9Thda/vUIeGvxeH3zBJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haK7UuNoeyz0Dh87O2WntFHwONnuJVEAyB3fJcdQJOw=;
 b=PaYmkqJRAKITOL9A+XTob/wPjO/X3IMjgerpBx3FIluhiuXiV0ffdrPtMJLOdjJkGgFNQ4qXKfj/5KfdSy9yTGdN1ASsj2847F/XI6/2SwLvdqczuVPl6Lbqwh4RKiu2NRRhUapn3foG3OQUNKmiwV2LaigBwngfyrNOpjOQuDHWPqWYnag7ZhbcarfKzsEO1Ix1+1D1hffr3flgf4604mPFPA0mJPCJLIJaT1LDMHfvP41bltTPV62s+dC2tOlW2MUja/07YSYKSJdZ/mKjQhfEL/Vi5ErGI1uLX4tgOgnaIn3ACveNFg9r2Kfq6ru1BGodgUA/jBVN1U8WyKZYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haK7UuNoeyz0Dh87O2WntFHwONnuJVEAyB3fJcdQJOw=;
 b=WL7vhPRCMnhQlzNFSeNb5a9mzwxyuXyKWUa4LE72ti/bG2JKFBkjoi8RSPE3l3n8bPotsOHAde7H6K/iBXiDMafLqZAgfvhNxUd2SgkMM6B9wesAtRYbOgXZRLD+2hh+VrSrH56abSVTnYls12fwhyv61HOm+QDVemfLjV1dicA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Wed, 12 Apr 2023 08:31:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::f005:3ff3:4f85:d51c]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::f005:3ff3:4f85:d51c%5]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 08:31:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: drm/amdgpu/gfx9: change the reference clock for raven/raven2
Thread-Topic: drm/amdgpu/gfx9: change the reference clock for raven/raven2
Thread-Index: Adls3Y+sz5H9A9DYT5SiI0Mz/SeAiAAOzOZA
Date: Wed, 12 Apr 2023 08:31:21 +0000
Message-ID: <DM6PR12MB2619F7BDC5706E527A096AF9E49B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <DM4PR12MB51527E447D080F457A43B415E39B9@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51527E447D080F457A43B415E39B9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-12T08:31:18Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5cc8049a-6845-4f25-8bc4-f1982198c770;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DS7PR12MB8249:EE_
x-ms-office365-filtering-correlation-id: e415e119-13a1-4f66-4cac-08db3b304b8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gv4fLyh7rQUxWnq8gDWah9VoigJEx4j1Xk0HR4hiIVrAQ+pov1XNpHHB/hbUFolCb/36S3xCfalcAUGwv9Z4YxRm1APubxsHz0SzVfhWWBs91CL53UR6HPLa1ECNEwMyxS3Yi/aDMDFM+7pzo7rJ36ijf1pKSrN22qiErDc7eSG72BXY9+JKRCDS5Rfv0K9709WAqe1QMjj+t4PtNwEBB4HdQ+R/oBKW9SsEviVkp2rz3rbp/JvRyucT9S6ODFfIFcHLI/wEtxzCnGd7jr2Cy0Aumhixeqite/uiZX/PEapexe99iZIz9aBff91cDawEVrumX03llhK8+YsnFvBrAsSrMQ5aZbV+mePi1rkaYxT2KV2Y6M4gszpUO5yTfY560+CWGES8UlcTi6k6HT8RHuhPdW0Udt/jToTG+6fK6raiNEr1eRIME6+tsnnxlkTeofc9D20K4t27TWxo4t9BMo0XmkmGa0lC2+UiVfPYakBOchrA5XkOZWSMYVShxfXFBCT7ApXoW6+VOtPXvSWjnhhjyDfthb/c2wM/nyB+p918FBgjtT+XIC1SsNGKGAY+4uONkyiniLW8ZPg0xBFDcTXYCp1JAxrWUbrArYp2JfAGKKpQlgUfPCPFZmDvArqa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(55016003)(52536014)(8936002)(7696005)(5660300002)(86362001)(66446008)(66476007)(64756008)(66946007)(76116006)(8676002)(66556008)(33656002)(478600001)(38100700002)(110136005)(38070700005)(122000001)(6636002)(71200400001)(53546011)(2906002)(83380400001)(6506007)(9686003)(186003)(41300700001)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t9OzBa3AnyMtzfHEU8qqBg+m4cUfcUiXHu1J8RMV6xFrRat0o8lmLpeFwxVm?=
 =?us-ascii?Q?6h3rXkYyw/xKjsmeTqxjziDocXG3dQqRgJhoIWDDDnsbZzhYxb6A+nM+XUb2?=
 =?us-ascii?Q?h1gI9ygrbWpEdRm1YbFXIWZk/dkd8MMivMnFoFWOR0r2kvMKWb2Snf3h7M/X?=
 =?us-ascii?Q?yE5/MispBlEZQEorK3Vx9/gkxf7+e6TUmwrvnwGakuaMRTcbZI+ZHcE5yV6K?=
 =?us-ascii?Q?6fee78ChNRuXGNTcrXng3jAv7ohv11gA4XP4GdZ7Az9RoDw2pblY4SvdFn0O?=
 =?us-ascii?Q?f1OrP7NAI5zkqa7Neo7aFRIkF2WPwYIHZRpO7aLl9i1cUAV/CLLujZJWVJc4?=
 =?us-ascii?Q?BIv0xxnsKygHVxMTrequIs5AV3KFGxbV9XCcN3ASOVVvOPvhYiu0+A1ovFBk?=
 =?us-ascii?Q?yJDtO5PUH/cFBCw0jn/xn9lyEGRKqwDZSU5wxoTEBh7317gOhdTfbHBZwtWM?=
 =?us-ascii?Q?rlsfTZy/sddkF/vFU8Z8LCYlbhxkWkk/hTyoy0I7bHQUb+/YCapxyBK6515v?=
 =?us-ascii?Q?JYH+CizoYkQE3GpgsbjmDtFlmC8cZeb+21fuvJgHOlDCpmsguYMQBJgtHgfr?=
 =?us-ascii?Q?kA4ti+UkL6nmfOWAxn5Y+BY25jutX/Tx5HchcIVOkykC/4axSS/uIIxxWlDo?=
 =?us-ascii?Q?UkTIShArvCNEIz3a65Hj5e0ATUgRHy1QGw3TFXfYPlBKLicUCkzj36qL3kqH?=
 =?us-ascii?Q?IUTG/d6CucP5BUapox58+Q4Sk+lilCsEReT4Nww8MOvhjU6o+QGj7UdAROof?=
 =?us-ascii?Q?LclmThXe+sRY5P8kC7GQCIl/vf7eWByqHhVfTfh6HXszONQOWlUCPxVSZack?=
 =?us-ascii?Q?HJxZ47o144dgy7u2S8llJGbVqkjAgiyjKTth0k/zVDw8rngLPBqXoP+oPiv7?=
 =?us-ascii?Q?YtVC6RP+cOkJiMdyBhD+uJuC62CxAQXXnzz1YgW544VRU47ZcqyqjqoN3CPD?=
 =?us-ascii?Q?vepB9MNVXBkhZrXVDQgUbFZ7WmE+MIDN30+QsHI/C97dVkJRbm7+HSZ+DaPJ?=
 =?us-ascii?Q?yb9T4bsANuM3I09sGAYAXXy/riBR2HzT2zy83j8mQAoCea0+U1obtNy0ZSCC?=
 =?us-ascii?Q?liZhoIdWzvgi9LzuIbYjKuD78lbuPkOdIwOYp6lZBfxW31rKHp83MjZ8DSxU?=
 =?us-ascii?Q?o7XrmxuC1EKib87tsqHeO7GSY9YInQOsnj6y4bTZ2HfzcEbOBS+XQbV/6ZiN?=
 =?us-ascii?Q?LFyZaZ0MQcA1pM9cWipJFGSZF7Hg0TYSDtdyWWV+wRFxxB4x2M5U2qNllPTg?=
 =?us-ascii?Q?oNiO3cFcsiu/bv+OCr0x5X0AdNYmngKc7uMMWSmTfDUS2zYkwgAH81cHWUpS?=
 =?us-ascii?Q?UtLbPSpfORKp54PeNruAW/OeaTbDiWoInajF+o2w6FSNkbgtMOgOlI1bJus9?=
 =?us-ascii?Q?ASXEiyuodibhO+fX+LSSjTRQcR3xO2EiFQOa3SI1S+eQA85XlmtCNUh7dMEF?=
 =?us-ascii?Q?Ixg5piBH0WXoZKnM4gD+QnGlnA19E6w+USwFCikVb4JeVHgdB9fCIog6CLNO?=
 =?us-ascii?Q?PPC3P1AcFlThxGGMlXPneJGUd2KhuIuo2BQ8zxKBZ+Re3Xuq3Eh6owLlVQR8?=
 =?us-ascii?Q?RKdartFX3mhZsNtT0Fo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2619F7BDC5706E527A096AF9E49B9DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e415e119-13a1-4f66-4cac-08db3b304b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 08:31:21.4915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CiBuzIGlpmiGwhERewK5PlJJMkLXzOoJxHdgb1YBas6l7O6EnCaOtdlLs8AoTfv/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
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

--_000_DM6PR12MB2619F7BDC5706E527A096AF9E49B9DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Better to update the patch title with prefix as "drm/amdgpu:" instead of "d=
rm/amdgpu/gfx9:".
Either way, the patch is Reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Wednesday, April 12, 2023 9:25 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Quan, Evan <Evan.Quan@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: drm/amdgpu/gfx9: change the reference clock for raven/raven2


[AMD Official Use Only - General]

    Due to switch to golden tsc register to get clock counter for raven/ ra=
ven2.
    Chang the reference clock from 25MHZ to 100MHZ.

    Signed-off-by: Jesse Zhang  Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.=
com>

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 7d04c39332ad..0367a97c606b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -301,11 +301,10 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
        u32 reference_clock =3D adev->clock.spll.reference_freq;

        if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 0) ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1))
-               return 10000;
-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||
+           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1) ||
+           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||
            adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 1))
-               return reference_clock / 4;
+               return 10000;

        return reference_clock;
}

--_000_DM6PR12MB2619F7BDC5706E527A096AF9E49B9DM6PR12MB2619namp_
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
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
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Better to update the patch title with prefix as &#82=
20;drm/amdgpu:&#8221; instead of &#8220;drm/amdgpu/gfx9:&#8221;.<o:p></o:p>=
</p>
<p class=3D"MsoNormal">Either way, the patch is Reviewed-by: Evan Quan &lt;=
evan.quan@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.c=
om&gt; <br>
<b>Sent:</b> Wednesday, April 12, 2023 9:25 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Deucher, Alexander &lt;Alexander.=
Deucher@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Zhang, Yifan &lt=
;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> drm/amdgpu/gfx9: change the reference clock for raven/raven=
2<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Due to switch to golden tsc regis=
ter to get clock counter for raven/ raven2.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Chang the reference clock from 25=
MHZ to 100MHZ.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;Signed-off-by: Jesse Zhang&n=
bsp; <a href=3D"mailto:Jesse.Zhang@amd.com">
Jesse.Zhang@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/dr=
ivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 7d04c39332ad..0367a97c606b 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p><=
/p>
<p class=3D"MsoNormal">@@ -301,11 +301,10 @@ static u32 soc15_get_xclk(stru=
ct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 refer=
ence_clock =3D adev-&gt;clock.spll.reference_freq;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (=
adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 0) ||<o:p></o:p>=
</p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1))<o:=
p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 10000;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;i=
p_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1) ||<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 1=
))<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return reference_clock / 4;<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 10000;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;retu=
rn reference_clock;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2619F7BDC5706E527A096AF9E49B9DM6PR12MB2619namp_--
