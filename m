Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28EAC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 06:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7785A6023F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 06:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7785A6023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D21489BB0;
	Tue, 31 Aug 2021 06:27:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16FB889BB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 06:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lcvzl17kYDWg4/N0yKg+tFfuOaFzqZVwuYjlosiMHEZiXbDlJVDpfijG8Fyt2nWTdzpQKZlt5Sdj79s0kYd58J3hrBV8o9bmjgrOm404d4jwRF4+WJHFke0WHHMCkDlKzt46BUnOWcboC9mZsWqV3liXjR1xt5EqNhypdJAGqwWwL0R6z7gv3KJ06RROwa9W4BlcGFuNkPQ3IaVvVvagD1cwwxIuD2yq7tm5oGb4ekcp64LFBt7Vm6v9hnAlk5bQBk7IR1++2Gg/A6UNoH1d4PIZibm1F//fE7X+0YqGezVtz2Ki97MJbACoVJ+IkU04SK3Awzdys74nuaT90ToKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHLSKZ5V/GU48wBaEn0+b4RqPuwCt3lpPNbAIooXQGs=;
 b=eU0ZoRtfyIOYxLqlwXu3lxzhhSzysaiOY+Ayv+ZZlJ/YtfOsVvekIJOrplogoLtQH9/Nux4vHG9pETBL4Eq674WLg2WB7QQ3gUC8kdsM6cwVSwXukb2P8noD7arTaRKcv84/SN+OZNzBGYPFSudgEmWDTk2rvQZsJAhdiW4jQLdn9sYS5yoVFTN1BsQerkaZr+AzisUiCWLUoOTENyew1VfrObByd1DqdpbjIIisTUC28px8+osU8exZWtfHdETvflJCEk9eqTo3nkN1vSY6QX/yJ1wzFmq779HqlAMdwNx9FsCa9LdyW7R20fVel1xNItFMH6kN1D/43VV/EJlaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHLSKZ5V/GU48wBaEn0+b4RqPuwCt3lpPNbAIooXQGs=;
 b=Dug5fZDJqfUqP2f/KyN7VWfsC+gwyywdqIPcUJWKadZm2DO0jP1+RZQrXXVekdAZE/IHPMFB8HfrYggWJhnntXLcuFu3nNiN+67p5JdHNoslxufLfguAW7CsHTyAj9GUxqr+LsgXO8Oel0XIdGpYYnhDkQXJ7/AeWUtsFhru/nU=
Received: from BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 06:27:23 +0000
Received: from BL1PR12MB5224.namprd12.prod.outlook.com
 ([fe80::7c65:1730:c7a2:2827]) by BL1PR12MB5224.namprd12.prod.outlook.com
 ([fe80::7c65:1730:c7a2:2827%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 06:27:23 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran
Thread-Index: AdeeMSvYbTiFkB0wS66shGZyPNuJmQ==
Date: Tue, 31 Aug 2021 06:27:23 +0000
Message-ID: <BL1PR12MB5224B6190A449999EDE4BD35FBCC9@BL1PR12MB5224.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-31T06:27:20Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7e15b15f-893f-42b1-be89-5fa2da7c3f1f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42f97e3c-ac5c-441d-b5f7-08d96c4864f0
x-ms-traffictypediagnostic: BL1PR12MB5110:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5110B645D4D906EF13912D4CFBCC9@BL1PR12MB5110.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WowtFdcRiZEgrPv6XfPdYU4ON+v2Ur0VsGF1F1/cMfU9XQFRFKPcD2xJYsGUbN1GYrW6cmC++x1TnrzuB5I2YRkpXBbb6YTSAgh6aoQMKqaerrq+SwmzgdYzDAYumgb9nCNk4OH9jvaHaCdJfgUNJ1vopHFqKqqfF9MR2RISg0tx9+SuBWuAFKUEFmQOVke0VBv8ujX408HRK6cXe8lh6604AbIF3h2uQbwrHZL5fLhrDAUc+nJ5AHamrxhmKAYdTIg0TlSChXxFYUIOQNkDbopyoy5CMVq65SybAWc44S/LjV/rNrUp7KamqoD8hD81PywUFDFrPsdi781FSct1LbqqDPmny4A+YKnr6tL78dOs3Efl8uTBsAL85C3+OBVFTplo2x941Sx09HiYaHntC8zN9Qn2lDwupkJc0356p/qsYQshe2cTGzThE3wJPNkBq224+CYVXg5i9XDSVmEGd6QX6I+yEnuWKCi7e1rXdkgz8fef8ZNeDA/67Igxa3TSAj/9lch1T/g/y/VftHUDH931+bg+Ob06fgnE+sQVM58rF43U9Q7vLBBPS0SZ4LZ7QRhsWjS5LDRbQp4D5VXS7V+3qUMwa91najt7eFxRwRc55Hq7Xk/rfBFtRDmunFCMyhPixCnv/pX+E4jteNTseeeHs9iEQ1oAYfiorjXQNxY7jgU57ZOOftxN9ZTTnx+kgbUagiYXTZvQ4ZyaXXQZcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5224.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(8936002)(66946007)(9686003)(38100700002)(66556008)(64756008)(66616009)(66476007)(86362001)(33656002)(5660300002)(558084003)(99936003)(316002)(4326008)(478600001)(71200400001)(66446008)(8676002)(26005)(122000001)(7696005)(55016002)(38070700005)(6916009)(6506007)(76116006)(2906002)(186003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t0Uij4TOoozNMojFTFb4dSROpxJAoreba9T/69iWanZDdWo300WHW4ZO/Unt?=
 =?us-ascii?Q?fqBeC0Mq5uEW6W/lXDxDS1eXz3NDdEux3PJBNQtGav5KFzJgpG5BssvPM3Qc?=
 =?us-ascii?Q?fEqKhOm+yQxO53qLOIeQQqTOzamEBzphJw7BCeQILb4l90GILGqFPWrXR0nj?=
 =?us-ascii?Q?eC0bAyl00v/uG/jp75y5J4a+7IQ6V8uo6rd8Od8khXWB7QU1nRI0LwRXFErr?=
 =?us-ascii?Q?I12CNUOvWWeAJjrJrJ8v8Ti/DS96EVTyq/dqkcCJkGqAla/p9DHunCZ7d+7K?=
 =?us-ascii?Q?SYrxUNb9o03tzsEFwshLtBUJpwZ09UgFoZfnX5sKvmjE0mX/7rQDn81vAR0Z?=
 =?us-ascii?Q?wxOaM/5dLJs3SBzT2PQCtjxW4KLmqL3ynzaSG8zHk/XccfrQ1ICqCQEQh0O0?=
 =?us-ascii?Q?kfhugRbDgqZiIokzYAG20U80HZYVou+qwA+Wsw/+AftHPYxNUMYK2jbGH+LK?=
 =?us-ascii?Q?6i+UOYncy+OzoT8vk4zWSjLmp4w1MqL9HANR4MVF0BSUwZGoAQhqr5zQpkEj?=
 =?us-ascii?Q?7rxZDjpo4EYBVW6nk4aakn7UtK4wKRF+HBqZa9aazLZA+0YMU/LBO7yv0XJ/?=
 =?us-ascii?Q?tvQL8NQhJYczgfoAzt1WbvwtaANT4McvePsCGLQXmpF7R+vAMlTPvBXMKXBM?=
 =?us-ascii?Q?Z+CnusNk/ZndAKUtfOjRsayOOzFOKeaPj2bMSrsRjF3tsbKw3P9FH0WXzAu4?=
 =?us-ascii?Q?RJJhcNYSksPC2AWmCx7KemYG+XLQVsyly4S1/sgFbkNSr2eu2wDT7cyBt4bm?=
 =?us-ascii?Q?6KzS0zdx7yxO7ZX+rXtc+XL265ElD51Sr+WOB/nsK1f0i2Ssb8rj8zrKALM6?=
 =?us-ascii?Q?as1QEFDK6dZe7+jN/7l44B72vLwyJkknHx+3qrJmThP+VODJiD5RBvPMudH6?=
 =?us-ascii?Q?rcORWRN6GO3LhXuUCEDYvv1KUWyi5IHpbLD6j8puS5QCER5NFd8epM+qdlaA?=
 =?us-ascii?Q?x5x9woaWwlBHJeQnljNp2fKaKkNQO1iWfvwC9mRMMwDsLHKuGNTN8SnzkJB6?=
 =?us-ascii?Q?dOIf+oyUeylpkGIbpH+SqYHlvjsJ3Pli2RBjqcg6ZZBLIp/ah/NSozmK7Obr?=
 =?us-ascii?Q?qtq1jr+1ysiJUvHbuEgup5SDCMXUPHVE4g8l/aZ/gX8UJdz8DRX8u3nEvDTu?=
 =?us-ascii?Q?Z2ZfnwauuFKwOmG+1N7b9V7pouC7QW0f0zARL8R6POfa9AHvWRYa2ZCg5GLg?=
 =?us-ascii?Q?SHEgJWHL0aeMgGLMAbTzrFNVTOYk0AzQwmfpx7HDCiJRmgnlrOo3QsLj71El?=
 =?us-ascii?Q?du4KXFwndar0UT4rqVujnxVEHAOEvKGz0U0WmmG60p0fExnaq5tfNFs7hPFg?=
 =?us-ascii?Q?B7tNUmjLlXlri5TkX/uwPKye?=
Content-Type: multipart/mixed;
 boundary="_004_BL1PR12MB5224B6190A449999EDE4BD35FBCC9BL1PR12MB5224namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5224.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f97e3c-ac5c-441d-b5f7-08d96c4864f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 06:27:23.4477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztMo9Jpwsxklv94vRaPLj13mxwVkBnVRqB38/xQTIb5qZPpTw26SoVY/8kTdC4p34JBG2Hu9cK4IY5fAttC+gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
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

--_004_BL1PR12MB5224B6190A449999EDE4BD35FBCC9BL1PR12MB5224namp_
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB5224B6190A449999EDE4BD35FBCC9BL1PR12MB5224namp_"

--_000_BL1PR12MB5224B6190A449999EDE4BD35FBCC9BL1PR12MB5224namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Submitting patch to resolve incorrect register address' on Aldebaran affect=
ing RAS interrupt handling

--_000_BL1PR12MB5224B6190A449999EDE4BD35FBCC9BL1PR12MB5224namp_
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheadera4477989" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to resolve incorrect register addre=
ss&#8217; on Aldebaran affecting RAS interrupt handling<o:p></o:p></p>
</div>
</body>
</html>

--_000_BL1PR12MB5224B6190A449999EDE4BD35FBCC9BL1PR12MB5224namp_--

--_004_BL1PR12MB5224B6190A449999EDE4BD35FBCC9BL1PR12MB5224namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Clear-RAS-interrupt-status-on-aldebaran.patch"
Content-Description:  0001-drm-amdgpu-Clear-RAS-interrupt-status-on-aldebaran.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Clear-RAS-interrupt-status-on-aldebaran.patch";
	size=3068; creation-date="Tue, 31 Aug 2021 06:26:00 GMT";
	modification-date="Tue, 31 Aug 2021 06:26:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyMzYxYzZlYzY2ZjQyOGNjZGY3NTIwMGViN2Q2ZjE2NGM4ZmVkMDczIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMzEgQXVnIDIwMjEgMTQ6MjM6NTQgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogQ2xlYXIgUkFTIGludGVycnVwdCBzdGF0dXMgb24gYWxkZWJhcmFuCgpS
ZXNvbHZlIGluY29ycmVjdCByZWdpc3RlciBhZGRyZXNzCgpTaWduZWQtb2ZmLWJ5OiBKb2huIENs
ZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSWM3OGYxZWRiZDEyMzBi
YjhhZWIwMDE0Y2ZiYjE3ZjhkZWQ5ZjRlMTcKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9uYmlvX3Y3XzQuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L25iaW9fdjdfNC5jCmluZGV4IGJhMWQzYWI4NjljMS4uZjUwMDQ1Y2ViZDQ0IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYwpAQCAtODUsMTEgKzg1LDE0IEBACiAj
ZGVmaW5lIG1tUkNDX0RFVjBfRVBGMF9TVFJBUDBfQUxERQkJCTB4MDAxNQogI2RlZmluZSBtbVJD
Q19ERVYwX0VQRjBfU1RSQVAwX0FMREVfQkFTRV9JRFgJCTIKIAotI2RlZmluZSBtbUJJRl9ET09S
QkVMTF9JTlRfQ05UTF9BTERFIAkJCTB4Mzg3OAorI2RlZmluZSBtbUJJRl9ET09SQkVMTF9JTlRf
Q05UTF9BTERFIAkJCTB4MDBmZQogI2RlZmluZSBtbUJJRl9ET09SQkVMTF9JTlRfQ05UTF9BTERF
X0JBU0VfSURYIAkJMgogI2RlZmluZSBCSUZfRE9PUkJFTExfSU5UX0NOVExfQUxERV9fRE9PUkJF
TExfSU5URVJSVVBUX0RJU0FCTEVfX1NISUZUCTB4MTgKICNkZWZpbmUgQklGX0RPT1JCRUxMX0lO
VF9DTlRMX0FMREVfX0RPT1JCRUxMX0lOVEVSUlVQVF9ESVNBQkxFX01BU0sJMHgwMTAwMDAwMEwK
IAorI2RlZmluZSBtbUJJRl9JTlRSX0NOVExfQUxERSAJCQkJMHgwMTAxCisjZGVmaW5lIG1tQklG
X0lOVFJfQ05UTF9BTERFX0JBU0VfSURYIAkJCTIKKwogc3RhdGljIHZvaWQgbmJpb192N180X3F1
ZXJ5X3Jhc19lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkJdm9p
ZCAqcmFzX2Vycm9yX3N0YXR1cyk7CiAKQEAgLTQ0MCwxNCArNDQzLDIzIEBAIHN0YXRpYyBpbnQg
bmJpb192N180X3NldF9yYXNfY29udHJvbGxlcl9pcnFfc3RhdGUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCiAJICovCiAJdWludDMyX3QgYmlmX2ludHJfY250bDsKIAotCWJpZl9pbnRyX2Nu
dGwgPSBSUkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSUZfSU5UUl9DTlRMKTsKKwlpZiAoYWRldi0+
YXNpY190eXBlID09IENISVBfQUxERUJBUkFOKQorCQliaWZfaW50cl9jbnRsID0gUlJFRzMyX1NP
QzE1KE5CSU8sIDAsIG1tQklGX0lOVFJfQ05UTF9BTERFKTsKKwllbHNlCisJCWJpZl9pbnRyX2Nu
dGwgPSBSUkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSUZfSU5UUl9DTlRMKTsKKwogCWlmIChzdGF0
ZSA9PSBBTURHUFVfSVJRX1NUQVRFX0VOQUJMRSkgewogCQkvKiBzZXQgaW50ZXJydXB0IHZlY3Rv
ciBzZWxlY3QgYml0IHRvIDAgdG8gc2VsZWN0CiAJCSAqIHZldGNvciAxIGZvciBiYXJlIG1ldGFs
IGNhc2UgKi8KIAkJYmlmX2ludHJfY250bCA9IFJFR19TRVRfRklFTEQoYmlmX2ludHJfY250bCwK
IAkJCQkJICAgICAgQklGX0lOVFJfQ05UTCwKIAkJCQkJICAgICAgUkFTX0lOVFJfVkVDX1NFTCwg
MCk7Ci0JCVdSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJRl9JTlRSX0NOVEwsIGJpZl9pbnRyX2Nu
dGwpOworCisJCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9BTERFQkFSQU4pCisJCQlXUkVH
MzJfU09DMTUoTkJJTywgMCwgbW1CSUZfSU5UUl9DTlRMX0FMREUsIGJpZl9pbnRyX2NudGwpOwor
CQllbHNlCisJCQlXUkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSUZfSU5UUl9DTlRMLCBiaWZfaW50
cl9jbnRsKTsKKwogCX0KIAogCXJldHVybiAwOwpAQCAtNDc2LDE0ICs0ODgsMjIgQEAgc3RhdGlj
IGludCBuYmlvX3Y3XzRfc2V0X3Jhc19lcnJfZXZlbnRfYXRodWJfaXJxX3N0YXRlKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGUKIAkgKi8KIAl1aW50MzJfdCBiaWZfaW50cl9jbnRsOwogCi0JYmlm
X2ludHJfY250bCA9IFJSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJRl9JTlRSX0NOVEwpOworCWlm
IChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9BTERFQkFSQU4pCisJCWJpZl9pbnRyX2NudGwgPSBS
UkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSUZfSU5UUl9DTlRMX0FMREUpOworCWVsc2UKKwkJYmlm
X2ludHJfY250bCA9IFJSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJRl9JTlRSX0NOVEwpOworCiAJ
aWYgKHN0YXRlID09IEFNREdQVV9JUlFfU1RBVEVfRU5BQkxFKSB7CiAJCS8qIHNldCBpbnRlcnJ1
cHQgdmVjdG9yIHNlbGVjdCBiaXQgdG8gMCB0byBzZWxlY3QKIAkJICogdmV0Y29yIDEgZm9yIGJh
cmUgbWV0YWwgY2FzZSAqLwogCQliaWZfaW50cl9jbnRsID0gUkVHX1NFVF9GSUVMRChiaWZfaW50
cl9jbnRsLAogCQkJCQkgICAgICBCSUZfSU5UUl9DTlRMLAogCQkJCQkgICAgICBSQVNfSU5UUl9W
RUNfU0VMLCAwKTsKLQkJV1JFRzMyX1NPQzE1KE5CSU8sIDAsIG1tQklGX0lOVFJfQ05UTCwgYmlm
X2ludHJfY250bCk7CisKKwkJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FMREVCQVJBTikK
KwkJCVdSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJRl9JTlRSX0NOVExfQUxERSwgYmlmX2ludHJf
Y250bCk7CisJCWVsc2UKKwkJCVdSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJRl9JTlRSX0NOVEws
IGJpZl9pbnRyX2NudGwpOwogCX0KIAogCXJldHVybiAwOwotLSAKMi4xNy4xCgo=

--_004_BL1PR12MB5224B6190A449999EDE4BD35FBCC9BL1PR12MB5224namp_--
