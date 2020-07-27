Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927D6C433EB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 03:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C33720658
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 03:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ANkQTOW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C33720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B2F89FD4;
	Mon, 27 Jul 2020 03:26:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6078B89FD4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 03:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKeAbdvQB/uQdAeKJ9sop/mWbIPQEvk8aA9Huu+waNWZAkCDk1pZqHdBFeShjvfjip9whELhdQo3hDkeIvVsqKeLSc+7jUqFaCK+0L6wgBJa91uR/Gb+ubnJpNWwrciNQikXHLCDdDp/Mp/gaUOzXvAOdvN6BA+yBJKgOpIvMn3rtHKFliauRu+yAmJiGPYevJU+ATKDT4ECVA4q3NihM0qCm+DcGcezknJ9ba/E2Jd1GyQ8NN5dcEWJGUNjQ4w4DwVREVC1SiKL+2nc2EwgWShTcwH1M746mDXKcvfOtgCS8bHoFCRTJgRnFatfAPE1OnG5KyAsqODGugoyeTNN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyD4iZ2V13FLvvZNgvekDg+F4mm6d93L/Y1Fpakd4ZM=;
 b=AqX7iFz/IoT9gNw65Xqsg1LcpPCZ/kaZWMzBECS0LkTEgpH50iAbWfYwXUr+IAaxe9xOZsMHD3k2CahEu4X0tfWFgIgKS6ZLFgRLLWNAmZmS83VDg3/6huN64jbtdrqj8pVty42DV2VL6K+oiNr019W3ZvTMa3Zx4EhItmIDGBNu91g+3B6yAHDo8C37urcY1HuzBix1huc/mVMyUngPQPkcoLbCC2/mMB2x7CIDKVCChUn5FY1Az1Lt7E63CjPplTO81UpMm82JZwkM9cH4F7EwQxxM1z/JcM7rzMXtJsc0mUipi684tvhCtPvmjVe4v1XxJ2XEaX8JmMrKHQ1U3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyD4iZ2V13FLvvZNgvekDg+F4mm6d93L/Y1Fpakd4ZM=;
 b=ANkQTOW3kOy6zE6r1yUiuIHNTsQ7W8aVTV9QcCZmCJisJcLqR5NR78XsDMjQ931S51Wq7lqnczKj1zxHdOCtssWxWwYqjJvutBibzWG3N/6HfT5LkuW0+95PUKMcTJZGNzD2RT8KuKtxgulzO4YWNIWiT5FBqYIUVQbuLKikDag=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Mon, 27 Jul 2020 03:26:06 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%8]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 03:26:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support for umc 8.7 ras functions
Thread-Topic: [PATCH] drm/amdgpu: add support for umc 8.7 ras functions
Thread-Index: AdZjxAL35jTAY5f1S1G1rtf0v4ojfQAAZy2A
Date: Mon, 27 Jul 2020 03:26:06 +0000
Message-ID: <DM6PR12MB40750502FBB00753D886A306FC720@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <DM6PR12MB402638932EA8C7DADD5AA159FB720@DM6PR12MB4026.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB402638932EA8C7DADD5AA159FB720@DM6PR12MB4026.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-27T03:15:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=47885b3b-64f1-4403-a8eb-0000ef681c03;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-27T03:26:04Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 912e2f75-6685-4fa9-899f-00002ede3df9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14c45d11-65eb-483e-a90f-08d831dccca6
x-ms-traffictypediagnostic: DM6PR12MB3868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3868C696E405AEC91923292AFC720@DM6PR12MB3868.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vtlzo2+i1MpwfQaWyUvU44G9DdLJSlkjWOAJHHQxyHYjiQbiW6AR2KIHH1npaKVl2AeqzGNPfRM0vgyIe9NARxRkzPysksCL4+pJbQFBK++bm3dR4uTPYesSUnX5NJNYggg0xbu0IM9h2TiGftQjkL8j4EGSXK+K9PxMgnDENojb+WuYpeUZ1QtOSQGfrCctK97lGe8KsGYZgybodSCO2RkXNdiRtSH+d6BPxBWpcjfoy+xQN8hNtwV+JGtp6cwM9nv9w5RSlMQGVrkiF/0Ch41J7Jb29nMNuB/vtX0I+AaFATag1XeusAYa1xn0Bjpu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(5660300002)(8676002)(33656002)(71200400001)(86362001)(8936002)(52536014)(66556008)(7696005)(66946007)(186003)(4744005)(9686003)(26005)(55016002)(6506007)(53546011)(66446008)(110136005)(2906002)(316002)(76116006)(478600001)(64756008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: u/+X0U3yNeIEX5PYHBNaDHx0kEvW51ktvqBWHCRQ/wUwS5SOF2HJMX8z//E3OC4HcBu9Nmr3Oug7Om/mQrRpw4r0m0h9aiCnzs3HKYbxb/4GJ2gbXdqAAhybG16NLxOy1F4EYKhHrsVLYiDDJi+yiPPf3PKpmO3AEXDnITJ0ET1yQ5UI0l6cQCu4/NVzTAQIu3qyga8pD25dYVYhzWKg52NcKDik/pNffPYHEwjaEhnGs5qLB2kz/9Oumkm+nbznHAetNiCN0K83K3m3cvJ3R6ri3hbSskBzE+i+zXeUOYzOH/FkNXlegdTS2Rf9IEIFVL11he3hVgb5LV4ioCi6mG0mEglkIIw84BL/Szg/80qMWDrtu/tJvnzHxIDcADyteQKL8n11HZvqGnG3hG+8Umrl218KQ1oWOc9FwvRf0elsXqrrnag9rhMHAlugZWsXecIzwXavEQ1Cm8cPoOhbzB/Gyxib7ao6kuL+S1S0l3/VlvgWoiBNoVSwJ2m8iWNI
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c45d11-65eb-483e-a90f-08d831dccca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 03:26:06.7392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+TvpQP4NiznADtefwr6CbzJxEWfJ76SsXQBE85NQbqsWSGZBhYzEnBgyUCJaQXYsfd63sWUeS5XumOFyJbJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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
Content-Type: multipart/mixed; boundary="===============1574953722=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1574953722==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40750502FBB00753D886A306FC720DM6PR12MB4075namp_"

--_000_DM6PR12MB40750502FBB00753D886A306FC720DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Monday, July 27, 2020 11:15
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amdgpu: add support for umc 8.7 ras functions


[AMD Public Use]

Submitting patch to add support for RAS GECC umc 8.7 error reporting and qu=
ery

Thank you,
John Clements

--_000_DM6PR12MB40750502FBB00753D886A306FC720DM6PR12MB4075namp_
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
<b>Sent:</b> Monday, July 27, 2020 11:15<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add support for umc 8.7 ras functions<o=
:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to add support for RAS GECC umc 8.7=
 error reporting and query<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40750502FBB00753D886A306FC720DM6PR12MB4075namp_--

--===============1574953722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1574953722==--
