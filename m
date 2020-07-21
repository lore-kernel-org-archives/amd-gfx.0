Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F7DC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 11:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952F220709
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 11:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="24KKINPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952F220709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 605A36E122;
	Tue, 21 Jul 2020 11:04:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9996E122
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 11:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nal9Npu+ZZE7I1H28gkGE6jk+6jpK/n4NwD3pIQ171Z5DQ40Tb4GIkBsYme3DZxIUx+cgVfvk/TBFtFIf3wn8DgI+w5+TNBFU40S2N5J3KxNyhb+HmXgp/ylIoUwiJ09urIhMgwNzpiTNvIaJ8GhL6P6MNp4Qp1sDFSoD7IPa9kkdFu9NA0FRASPsQFg1WZvzBjEDUFaq3THmVSqkRy3FBXIRUcJ94KUeRb5ku6PbNu6ONsN3HFnaNK3hJ/tNOd1RScSEBexdV3rstWDa+skVbeLVu86bPCRMFTRJemTsaZTGixLdu6E6Z9idK5/5yTKhp/iN1nb/ky6WEYkIHpgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCH+8d1gOLeJ49PM/JImax0JNhYQIULEDjfLIZh39qA=;
 b=VOWoELxFvxdutIE3SKO/zsdZ9VfMkKZXcnhLPcheZ7wXVy/u4GtwRPC8hGnOx7eHpJccvdjMZa7GsfYRECstBA5+Bp/C6rr8ihDjhADoTCXjLeZisOvOJCKqH0bJsIDUF3eMyUEQn8tsw5mRGD/lt6pHLQcLzXE4v1T3hPVaUaL3siK3bUQjA/tiFiwIUX4BhbmCeDVjTmqcX4eKrzfoZAbBwI5n2ua40PyT4IER0u398V7k6AdRw3RwIwy41wENWXyM9xxe+LkEDKKibPD69Yv2xNh2jIA/lyrFnWBUtSSTzqnb4vPx87jB8z+TXQIZtrH6vwPFWBzEpjtJkjRmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCH+8d1gOLeJ49PM/JImax0JNhYQIULEDjfLIZh39qA=;
 b=24KKINPiofS4ABt1GY5DhgSVx32ouY507S2nd97pZW2n8AGAabMXooDgyO5KlzALGLx/Np1uQcua9PjvTI1smlGFpAIAbYbhQuFcP87rB3i5B+iFY1GE2XnZachUrkmWqnHZoiqkB/0Kt8tT/mc8dWyh1R6pNx/TM+DY6xrsE7w=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Tue, 21 Jul 2020 11:04:46 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%8]) with mapi id 15.20.3216.021; Tue, 21 Jul 2020
 11:04:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: expand sienna chichlid reg access support
Thread-Topic: [PATCH] drm/amdgpu: expand sienna chichlid reg access support
Thread-Index: AdZfRMbeLVrLWZiUScy7xMGsaeMiBQACeveA
Date: Tue, 21 Jul 2020 11:04:46 +0000
Message-ID: <DM6PR12MB407531859D722D1A7FAAE9E0FC780@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB403248E1E8B8387413126F4AFB780@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB403248E1E8B8387413126F4AFB780@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-21T09:54:14Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=896ab18a-c36a-45e2-b47a-0000373cc5b9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-21T11:04:44Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4b115067-276b-4993-aa4f-000015443cf2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9789dbb5-0d26-4000-f34c-08d82d65e14e
x-ms-traffictypediagnostic: DM6PR12MB2780:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB278095EB37803A6602166EF8FC780@DM6PR12MB2780.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yje3txXdsInzTq/dUuHT/+Amx+2tCllFcerBbv+f+6aBZnXZte5q6qKy0UYW+wYv65O43nu2e3xzKFfXBRBpJ86DfoRySnSK3Kln0Uy50Z+CMg5Z2EHkHhwI4Kgyb98RRg3VYgdiZeAfscIShb+9xdjxxXa/793gLZSrJvSBjMm3RqvScAW2FJ1TnNTMs0GSdIqmCszTDXdOVnw0L6eC1WN0OsIZGzAhlCe0XrRvSsgAK7lgfDlaGnyVVs/izchBkidqeorqb5qtGsR8VddoiCOezffDkzsrh9DDMRKsfFGsyqBCZ7IagUVrv5BoGaIapSJCc5UsMTFliuX0okeMfA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(5660300002)(7696005)(2906002)(71200400001)(186003)(83380400001)(478600001)(52536014)(76116006)(86362001)(33656002)(66946007)(66476007)(66556008)(64756008)(66446008)(8936002)(8676002)(4744005)(26005)(316002)(53546011)(6506007)(55016002)(9686003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9hFwRSCOoW3oNceEQu5SqyRCZjSy0a4SavaB3zQ1Jd+o6wmsUWpEr16sJo6HxcdAK3CrBlGZsCoXTr/QeYHFgY2EUxrY2ltpnCYfvjJEj2sBYElVh/SLpu3xw08cM8/UUvy87k78nc55YrVsVNe6s8QKCky6kj0/TD94G+TJ9C770IGvmF8+be8WwdxPF0LvENm+wYWhCHOz/zXOa2n/w9apVdm+eyRhZKnThlqybzuIQn79v1HegwMMwuBFLECGsB4VzymA1yfoamM457XGgjKPiu/+L/yd9jxkP31SQg8TYE0UGk0vcFx3Z2Y7+OD4WqnNtXYR9eb9aRTnqCS9QbVOzSbOCDDuYUTs3OHi5cu80MZQTmp5h7F3ytb3kDwWIPRNKujKvL+Iirc+g4yuvayShGFdij4+ZeoqQ6Qb0CPqJPV2zESs3y8Fsn4HfSYd2EsAiHzY9kWbAqlCo1sonLvpqcht93ZcUJg4J8kutuNRZNAOJRFsdljCwi28gJYu
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9789dbb5-0d26-4000-f34c-08d82d65e14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 11:04:46.6515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GboLcnQhlruFlxWXep3dgWLB7OSTLnqdsB4QNvufGxn6voaJRAGxGbdd8+fJA9feMUL+uw17v+UZOfAJxXn4wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
Content-Type: multipart/mixed; boundary="===============0280410165=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0280410165==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB407531859D722D1A7FAAE9E0FC780DM6PR12MB4075namp_"

--_000_DM6PR12MB407531859D722D1A7FAAE9E0FC780DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, July 21, 2020 17:54
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amdgpu: expand sienna chichlid reg access support


[AMD Public Use]

Added support for dedicated 64bit read/write reg support for sienna chichli=
d

--_000_DM6PR12MB407531859D722D1A7FAAE9E0FC780DM6PR12MB4075namp_
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
<b>Sent:</b> Tuesday, July 21, 2020 17:54<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: expand sienna chichlid reg access suppo=
rt<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Added support for dedicated 64bit read/write reg sup=
port for sienna chichlid<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB407531859D722D1A7FAAE9E0FC780DM6PR12MB4075namp_--

--===============0280410165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0280410165==--
