Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7031DC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 02:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD7E20775
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 02:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FB1mekO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD7E20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B516E12F;
	Tue, 28 Jul 2020 02:49:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B0F6E12F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 02:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTXMDydzNOjmsIqnyiSTn45p+RsBUaDfe+U/Uj18cCjrWp0/7/hQJAuOp9agcy1b9XuPIq5EnYFkV1ythEXoeRU/zVH6lv6JwT2YVI9MHhucok2nGOCqz0H7P4HvWeFKcTV9GmEFYB0Sj06rGu/KwGoPbbuhVY/PFE0QnOep/0mA5f/vgPp0nkvH7VnEGtmLMJDNX1E/BVYV+GW0pLsFEJSxjFvy8+/oxR2KXcS4r8268wU+GFBUme61Ok6+QK4/edlslP7g8FXgoxO92M1BHSlWp0lQX4of9ugiE2noLgAXHs2XyjlpNG3CbrcX21/7Gn/wKpMu4Ghei5TOU/Tuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrYa7jNq64zGv99wcePqKN3SUOX24P89aWehp0JNr1M=;
 b=D9w21PKpaL+i72/0M4+H6ldQ6LAWO/jIlG92TVjlnYJQN/QcSmYjabDdAIdcdkgwGq8KivONQs+dZ7lGswMqZw0aLmXDQZVUj/xyh9/ka9oneQWkCXPUQxJDF5XuzEYomicNaxVmgKrGvIocbI2wo4kVJs8r0zQuFumJCfmlZreQu2XzVQQJXLbTndMTo33DiBAR1bKRnDP0qmTFmwSKx8A2GLPBeXtLp0PLhrHqgedxdLBwNLcVJ33YOaFnaMrmhnCknNx/NullPMNjH61IhYSPg1QG23cT7Qyam14Q4DwxzJra3JwqiUTg1G/kispUgWLDo7xBlBKD1amiBQ5LKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrYa7jNq64zGv99wcePqKN3SUOX24P89aWehp0JNr1M=;
 b=FB1mekO45hRprxGwfoZ7xVWAMPvcmzZ8/1QNJ82+vQKnJm1j0D/671GTXS3QX1lcgGc499yUIMsf90v1ywCODEwQumfbkQHMxS+tHeAajRWCPcWKlMbthqJO7UaNYQaqZsHyHbCCES6lm0+UjZuHGnWKy9tBkuVXcE0SVA24V+8=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Tue, 28 Jul 2020 02:49:32 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%8]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 02:49:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add umv v8.7 source to makefile
Thread-Topic: [PATCH] drm/amdgpu: add umv v8.7 source to makefile
Thread-Index: AdZkiI02shJIQC2IR1iMu8smSKXOUQAAOHtQ
Date: Tue, 28 Jul 2020 02:49:32 +0000
Message-ID: <DM6PR12MB4075A5F7FBBF6B48541F48EBFC730@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <BY5PR12MB40198080B5B48F8BA7E97E74FB730@BY5PR12MB4019.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB40198080B5B48F8BA7E97E74FB730@BY5PR12MB4019.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-28T02:41:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fd2a3e49-32fe-46b9-b686-0000b58165df;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-28T02:49:29Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9b1b619f-1e16-4a5a-9ee4-00008f913334
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 759ca511-d85d-4105-09d3-08d832a0db58
x-ms-traffictypediagnostic: DM5PR12MB1452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1452777DA2275094F79FB932FC730@DM5PR12MB1452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TYBchpcVTyY+BYKeynfMEZvt+gv0xru0JVe9b/C59D4sm76ITlKyvU1NwXB2q9t89/tRyqDLp0vtevaFdU1j3F7hmBP+Wwx8xT6h+HDNFS0Yr5SbzrnWTIt3nz7AlXCQZDPyQvI2iiTgwH0ttxHsmr6vLp6X4V4hjvMxyslzt3zpaC2fMlV1rviMrdxk4FKs6GSgXcv1AmARrosTZrETHcOjmsn4IHMmtF14p1EkW3DnwJTGZ6Q+BzZAmw0/uYCltGvWJoR07kYy31Aj7X7E0aQSN9jfK2Zo6uY3sfmoOQ1oRoYf7sQo2MoW33DlS6bg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(66446008)(64756008)(66556008)(66476007)(66946007)(83380400001)(110136005)(33656002)(71200400001)(86362001)(76116006)(2906002)(9686003)(55016002)(478600001)(4744005)(8676002)(8936002)(5660300002)(26005)(316002)(7696005)(6506007)(53546011)(186003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: uQnEIuebpcZgbir+kYaRFEYMQQrA7uzSv0EEiePbAxGAYRCexbInwl3WsTmY8cs6HTSgT5uKyTWQrse9196Kl6DEqelNFs9vao4hcyl1TNobDjocFG1xocKxLnzbwbXAqhrotZv30J/T5TzTGZjYMbYdsaPz9+0uup32QG1s0ZVDkZoaoBKYnYOgkPGsHkT8d3Oa+wgjUql0ILux9UKEXejk3LSUFEQmGp/K8threIHqwJwLJe59OKQXuv50B682ETCy6kTA2tgYJaJlG3JAOWI0Zpx5UCcRX1aCjAbnq6j2bh2a5wu7O3TBSMUTdUzrgxH9xjo+RkxLlnrx+v7BN2/EO4RBawHmsnBgJsJkMsDFJhRW5S1g6pzzsaywoiEBfN7MLJv7VriGz3uRaIvr8VCtvboqlE26ea8l1Pop1OArCJDP2iEmMPkvpX3s5VFUGZHbJ4fo032Mru/xIjbBtG7wtKlbUNdJIRttSZhSt4thgL2DQsOCQ7msdJ6hz1JX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759ca511-d85d-4105-09d3-08d832a0db58
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 02:49:32.7478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dh7NZ9zFkVQEtrEEHth4yWB25gnBHXDExDNcToZS73sDrH0Z/Zw7J9W4OvT7qq3uxEYYbqYoe0vLWBkOjVowA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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
Content-Type: multipart/mixed; boundary="===============1542099412=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1542099412==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075A5F7FBBF6B48541F48EBFC730DM6PR12MB4075namp_"

--_000_DM6PR12MB4075A5F7FBBF6B48541F48EBFC730DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

I would suggest you combine the patch with your previous series. and send t=
hem out for the review if you haven't completed the review yet.

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, July 28, 2020 10:42
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: [PATCH] drm/amdgpu: add umv v8.7 source to makefile


[AMD Public Use]

Submitting patch to add UMC 8.7 source file to makefile

--_000_DM6PR12MB4075A5F7FBBF6B48541F48EBFC730DM6PR12MB4075namp_
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
<p class=3D"MsoNormal">I would suggest you combine the patch with your prev=
ious series. and send them out for the review if you haven&#8217;t complete=
d the review yet.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, July 28, 2020 10:42<br>
<b>To:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add umv v8.7 source to makefile<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to add UMC 8.7 source file to makef=
ile<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075A5F7FBBF6B48541F48EBFC730DM6PR12MB4075namp_--

--===============1542099412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1542099412==--
