Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63E2C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 08:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B647820719
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 08:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XqsUnr/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B647820719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2F7895E1;
	Mon, 27 Jul 2020 08:50:13 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680061.outbound.protection.outlook.com [40.107.68.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E84895E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 08:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfSZDs3GJVtCw5g0FiO3U4ZI9DDFbLxnRw5B+ErqwG2KyjcL+Hbq4CuEVrL2LXjzuhnwg3mLMFPVf7lIhqHvAR9oaLtnGRoZcWV+Jn7CmfLgyzbxAoW4D2B8HhqKF5XBPeZXAQz0+voB58OJJOOAsE9ujQ5qspiEpCErx43SY9ARr06BKROytfhr9OGSt7noaHvzF/HpmczdRSCdiYvNppyDgpp8lfO+t17OLydCDbaIwGXjrcWNghCylfO9RZYvvtsrJkqCLyLEWf5OTa4NMzq5ZU4bphUdk88Jsu2uocGxV4au7q4DMKAMYdWWMph4DQvPL5pbukMk9rLhlD9cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G31fUAA31ABBuaIOctmO74ZN3Tj2ROwdiwpSVNIXURY=;
 b=CBUA82TGVjrAK4cQ5xeqO/Z7VrF6WA0oW4JaluDYXC90/Xuvfer13b/mBkbWlSqncM4VWP19APdUSzvVIZ/S5xd3Du0PmlnKOhmUDFboSzA9fogiU1OxbtSUFYfadaLRHnt8P/MtXf6csdABi17qMqMwXmux2p7NqtN/ptcj3yuyX63Ocl8TEfXXnCKnJrFwC3Zjc7J4+GoXCq5N2gDjHZaYZg36dWjSr+orp3jHdapsQT9mlduWRqBzPHByr4by0o9fZ/Y5iEJ+5xdEGn6x6qMvtSfq+H8Dyi8q9KYmclqSEM6TRj9sT0QWhqoVaCPEeGyYof5gTUszD0f8f3tLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G31fUAA31ABBuaIOctmO74ZN3Tj2ROwdiwpSVNIXURY=;
 b=XqsUnr/JroFtB8kTYNUWdnQCpbnv0aMaKRSb3Jk84W1XJGWCIZFVaSeEcaGXpybdy0VlNesHo2m6fIILJwR07aIasuSyp+Hv3KusQTZo3rsTQ5OK8DQ9tW8s6J6qUHL7U+4sjLqOweI7KcFbuXUKHQCLTXOV2+1kO6mJm9YYoWQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1270.namprd12.prod.outlook.com (2603:10b6:903:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Mon, 27 Jul
 2020 08:50:10 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Mon, 27 Jul
 2020 08:50:10 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10
Thread-Topic: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10
Thread-Index: AdZj8ChRB8kbyPg9T927y1qmSWUoxwAAomPA
Date: Mon, 27 Jul 2020 08:50:10 +0000
Message-ID: <CY4PR12MB12877CAFF60DAB4B6DE3492CF1720@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <DM6PR12MB40262ED0408E4FD14160D1A1FB720@DM6PR12MB4026.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40262ED0408E4FD14160D1A1FB720@DM6PR12MB4026.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-27T08:32:21Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=af532301-b71d-4340-96dd-0000519c31b9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-27T08:50:07Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ecb354e6-0e43-4fa2-925d-000006479d63
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f721f0ef-d5db-4183-e0c5-08d8320a1238
x-ms-traffictypediagnostic: CY4PR12MB1270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB127076DFE76C7577759E67FFF1720@CY4PR12MB1270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QsTNRav8IESmYK79TVqbkngXzUKt3pjvZKLyXZpM/HxaQ1mRSXzetoRvBWLD/HAGMsYEY4/jTb5a0pNP43MBsyGwrNfUdDk2BshzViDXn3c5Cio9ugL9lwUUqeYyQy3zFDdfxmnal6YLsWWKaP9eQUobzHCjhwPPQgWk8vID43bO8jFpu6UqtDRdi1RTiQobVc1FyiY89V0EvaR6ViLFYnlZzSVaULsm9jvXaNRMrMhsW/4nDi5QOkIHN0QGefT6GaFhCzl7BcWkn3F+loY3hLFI56ZtmL6QY3I/96+ZTjwDw/ei+dbPygkUGk/6FoHm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(52536014)(76116006)(4744005)(478600001)(6636002)(66946007)(110136005)(86362001)(316002)(5660300002)(26005)(186003)(9686003)(2906002)(55016002)(33656002)(8676002)(66476007)(64756008)(71200400001)(53546011)(6506007)(66446008)(66556008)(8936002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gWdooYzgugc93poj8B3CUQm7dLYaZ+PIhWZqDxj96qOOVQD7yThHWCQ+4bMnog5bQ/Ny1DoEGYf9DJW49ZfC/aLJThohyXuW3oJkIipjEqNrVC8FVGNso1xxx17oBcydCuPq1FKeDD+HY6YN3Xd8rtgoec1MCHbO3YmP73iilJzdg2NZhCd/IBFRaFKjbFanjDThTrDUUmgHeTVcFyy/q1nY8c3wExwCAELltEZG+qJPPRS5Pu/xBf/mM77ofohMLDvtzzJ5f3raiTVyJig16aivv3bPl1+fbyYlltKJm/RW+HmGFA9fT54sznpZd+5sYN8gN+2i+4tqhZh7FaNSFnkO1KzDP4+xeUvy8O7+HHnObSrMX70CUwFbqo4jEzel1WAG5T0uaujv/lVfguSp6ZBGfKj6UqPmTFoPsZIdqhxu1CWXhW+e6RWe3pFUKvKeI6cIq13UWILx6UKCrOnNk+YG/32exHqHEexjpPSLytt87f17Aqe3ZsCtGOUfhd7p
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f721f0ef-d5db-4183-e0c5-08d8320a1238
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 08:50:10.7745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LQVlo96gfbnr6Rubp80BdJM8j1qT2/WBxtxkjNhj8asRx/rQgpusFA/Q7FyUns6tjsv/EgwbzNlPm2TcPZXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1270
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
Content-Type: multipart/mixed; boundary="===============0920052112=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0920052112==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB12877CAFF60DAB4B6DE3492CF1720CY4PR12MB1287namp_"

--_000_CY4PR12MB12877CAFF60DAB4B6DE3492CF1720CY4PR12MB1287namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

One typo in commit subject.

add support for umc 8.7 initialzation and RAS interrupt

s/initialzation /initialization

With this fixed, the patch is:
Reviewed-by: Guchun Chen guchun.chen@amd.com<mailto:guchun.chen@amd.com>

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Clements=
, John
Sent: Monday, July 27, 2020 4:32 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10


[AMD Public Use]

Submitting patch to enable UMC 8.7 GECC functions in GMC v10

--_000_CY4PR12MB12877CAFF60DAB4B6DE3492CF1720CY4PR12MB1287namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
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
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
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
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">One typo in commit subject.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">add support for umc 8.7 initialzation and RAS interr=
upt<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">s/initialzation /initialization<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">With this fixed, the patch is:<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen <a href=3D"mailto:guchun.ch=
en@amd.com">
guchun.chen@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Monday, July 27, 2020 4:32 PM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to enable UMC 8.7 GECC functions in=
 GMC v10<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB12877CAFF60DAB4B6DE3492CF1720CY4PR12MB1287namp_--

--===============0920052112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0920052112==--
