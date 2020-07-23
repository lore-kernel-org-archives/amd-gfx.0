Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59175C433EC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F9A22B43
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1FGifAog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F9A22B43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 994376E882;
	Thu, 23 Jul 2020 08:45:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB886E86B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvZYZg0+e107E1aCEl36/xkedWnrL6BskJbVL2kqZ1TaScu4CYajfG8pPWtaXS+eRpDpOoJjkBXHmrH0neVM0jc7iiGFvYf4bwnhvVk2MQdMpVmJw9y+UKKgmxInrmkksTc4en+7jzPKPbDBqoQGVRNDdYphfJMO4YtnKcSlVNjrozElqT+7nzsHvzv/T8cP/4xthD5/wu4ALwjoAUObyS8tNRFov+KOHuWjxLbpvSSqvJMA8VxzqUV6wKMaktO5z7ltOAhr1hzFZ0/iUxvtBVdynFNO3JpIU1LBJZMxjENKFTY8LL1Fhb7OIHfh3SUtSnchi+oI/rG2eog8JIyTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fsIgN01C3ciBAYxxbMSkaXT/BmGiuyHHLgKoLvfAqk=;
 b=eR+4d3Uyje525Ob8Q1XsDe88D+S3SRJ7oNNIAUIJ2+WaqZIo4rjPp3sJYGcv7ywcRLWfq55ZqNaQzTYxgi6XPm/c9yQyYjrp/dhxwv+DIz6FVurjJtSAFBtMsjwGAz9HrhfPFJX09xJtXCmYij3g9Bw4MsV4d84U7pidFY70JF0boKgvaKrKbEVlRX9oKEGhc5jRznGChenZUL7pHcK0CWHIOt94pPaijSFww9mGS/6xVQT72kyeSzgBMoVAQsygy9LHYV3oyG7M5+3/S1zDv+FkU3gcUmShIBDrydyLzy/VXQAanZf69kC/ddYUH2ibaOi7lDa7Y66GG77XO8KnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fsIgN01C3ciBAYxxbMSkaXT/BmGiuyHHLgKoLvfAqk=;
 b=1FGifAogFnRzWpbeYjkT2M325FsRWw0vc5P8CMqFLUOXd5FCRAseC8jDE+yRoYRAENpGasVdyEBFGzxCVOFq85rdMIBDHdF/Ffp/opN3zYzMUzdwO+6/V0RI0btysN6R1UxpKF2G1JkpKVG21Llq5Hrcx2UHaMlh/BC1+yAxTnI=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21; Thu, 23 Jul 2020 08:45:47 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%8]) with mapi id 15.20.3216.021; Thu, 23 Jul 2020
 08:45:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move umc specific macros to header
Thread-Topic: [PATCH] drm/amdgpu: move umc specific macros to header
Thread-Index: AdZgy1PjQhVeadPiSFCvsvxsTf9JPAAAkeAA
Date: Thu, 23 Jul 2020 08:45:47 +0000
Message-ID: <DM6PR12MB4075A835F65CB870FF1FF6B0FC760@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB40329A1571EB417279DB98D4FB760@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB40329A1571EB417279DB98D4FB760@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-23T08:30:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=17bae4e3-f9c9-4258-8cc4-0000519394f4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-23T08:45:45Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d06138d7-39d7-4ba5-86b8-0000db2b855a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 365a6c4a-e1dc-46fc-81dc-08d82ee4cbb8
x-ms-traffictypediagnostic: DM5PR12MB2360:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23604A7FB9818B281D4ED576FC760@DM5PR12MB2360.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JnaUkYwL7TgXb3R92++XQax0/bUmF+H119ToDhDZEshVRizFOycegevgnu0yEEzslx1r13Pe/F6V9LlS0/gqiBdles3w3pBWtZmuYb2316SoW/ajdF6nQB57OvJ/12OyAYaL6Rv5VYWtdaJC7+WRtgGfv9ae2wPx+FDw2Q/UfTscvTzZGLX2DEXUDAyh7erNIU7Bps7fcG2VKzseU/4yLWLAzTLcf9tZgIwr+GfkpMARKjFPRCOwRmvGqqukelwNsTFWX+jQrg3q8fjywAwbxLg4xzn94NFXuhSboZgxMHP0arv2AR2GENt3IP25RMteP2QEf5ENsgz3L0hn+Zzywg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(53546011)(478600001)(6506007)(8676002)(316002)(55016002)(2906002)(5660300002)(33656002)(8936002)(4744005)(26005)(52536014)(9686003)(66446008)(64756008)(66476007)(76116006)(7696005)(66946007)(71200400001)(86362001)(66556008)(186003)(6636002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: CPihOJmM6bRS15n/NrY2F8mTr0OptDwdHrKUBUN/t56qZVu3gqjp97/iAaX1UPifbBgedbTCLjGZMH/hdxnW83X0iKGqOeistBpPmrCkV0byg+xxbhhMJUxazXZkeXsIJdYdKS7RamVeUbqpOC0O/dYgteqPRtu6JeLS+zJirdbDTVdMGgRZOvbZkNOky+50dxtk1K8AkjspngTDpaMf8mA2pbI1bo7jOI8TP+1QI3YyKWY+tsf/SYOLTQ/BngD8b9uc016HyUTgwENHSZkHb9Lu8EG3z93j4c8Zo5DF5Niy0lNfZhQG4DeZU4AFCMmbMjGRC5xK36ihwMwj4b71iJuE0wsftWERKVrc3+9bd5Jwxg6+PcXXB4006JNOMFqn+lJDV8k316atd6Z7BLKxRYZcmsEhTaaaF3W8P5QMmzw0nGHjZeKh/Cigj3a5vjX+8ex6cr5MUodTQ++qE7X+4VdqVWj9P7YvAUdBPWzG+JsrySb3Mk113dS3VpR5tCfA
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365a6c4a-e1dc-46fc-81dc-08d82ee4cbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 08:45:47.6888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVaKOwWVZerDqb4mNF9AE3rlTJNAlyCAVS8+ZrGTECvz88Zv9ZO1L8YTgQh21ItWzEk8SmVvpbVz0PBYFObDMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Content-Type: multipart/mixed; boundary="===============0300097074=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0300097074==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075A835F65CB870FF1FF6B0FC760DM6PR12MB4075namp_"

--_000_DM6PR12MB4075A835F65CB870FF1FF6B0FC760DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, July 23, 2020 16:30
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: move umc specific macros to header


[AMD Public Use]

Submitting patch to move umc channel/instance loop macros to header file to=
 be used as common macros for all umc versions

Thank you,
John Clements

--_000_DM6PR12MB4075A835F65CB870FF1FF6B0FC760DM6PR12MB4075namp_
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
<b>Sent:</b> Thursday, July 23, 2020 16:30<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH] drm/amdgpu: move umc specific macros to header<o:p>=
</o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to move umc channel/instance loop m=
acros to header file to be used as common macros for all umc versions<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075A835F65CB870FF1FF6B0FC760DM6PR12MB4075namp_--

--===============0300097074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0300097074==--
