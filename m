Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21F8C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 06:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD6E610CD
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 06:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FD6E610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ECFA6E513;
	Thu, 26 Aug 2021 06:54:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22C36E513
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 06:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0IJ1Rq+Ru8zSnmF17Ns+9a+8I6Mkr4F3cBR0uyNBlKJ+PllM0QwAuv/29fBX6soo7YzIlbL08DtrinQKetO0Gn9aHePbZJssFSrqeHyP6kDdi6Q/TZsccs1Q+dY0/eSjVIEvT4Hsij6U3UbHNDloq0G0WA937vIhlWNeWKyHFAemwHME9nOE11/aHByoHcidaOnEJtH/u8qDqNVZeKJVuMTFqFiv3IVNVjZBcLCWWYO0OVssi23yInlr4aPJcfMo/f5A2LlRStvYVz9oX+FVfv1dIx5aMLg4RdUIG9h0lX7GGCCLfw+7nRD9pdJgNPUr8wnKCxgc+Qj8AsPs9tJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyx20L2Vy3lbcTMUiChcFoP8/tRFmC8yVS04ZecRpoA=;
 b=UyTEYLpzHWk/mwaiOtSv7pP4CLWdqjZ9H2WolwWgFTA0zZtCtMtTEhos9WCcqwI6M6LP1uYS1auUoBLME1+PAtGrouBn0rKZk/kzrbF6bffrN+9P5YBcHtiJCJVvaHr5Xxn7o6mW5DPf3fAKRuCruChBqIUQQsHrt0P6lcTDfwLMETymuJrXM/wGif03q3noX/E5a3c9a3McYiQSPXZ2Ye+hVQo36Dy0KPXEVmErpQkwtOtYtdb8dR8PwLMynXB0pK4vRC0h+3LXTOpEY29PWefyT+9xPcXJAKiqyR6t0w7P4jMOLqOA3wUQ7GTPG3ocQeb5QeYb6o/UhqJGdechgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyx20L2Vy3lbcTMUiChcFoP8/tRFmC8yVS04ZecRpoA=;
 b=x5N4RzRavBnCMIdhZVlZgGvpP+sigGdE/HM7VRswwTRoUDJLXeRbBxIkeYacEhVsZSvS6YMxla6if4dMCTqllNrJaxIfDdgj7oJoUdr5x9H4+hSujwd1aLYoFWhJoSShI2sgDtH8wuEM0cyRPo7YtHTnDKlouCnOj9t/UX0pMGw=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Thu, 26 Aug
 2021 06:54:32 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4457.017; Thu, 26 Aug 2021
 06:54:32 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran
Thread-Index: AdeaRyK7+vwn47CGSriA5htBiDwSkw==
Date: Thu, 26 Aug 2021 06:54:32 +0000
Message-ID: <BN9PR12MB52260A8475665CD687D384F4FBC79@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-26T06:54:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3a689579-4854-4e8d-963e-b4f9ee8c6fd7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e9e7d71-afd2-4cbe-464e-08d9685e5bcc
x-ms-traffictypediagnostic: BN9PR12MB5161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5161F6ECD174800FFE92E5D5FBC79@BN9PR12MB5161.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NkaNHH8JwlwCb6zooP3HtMfzH6rZq8VQlMzAcbIFsWRH57zAwcRqTSamIEKFZKsHrIyS4LD6DtATvYG+3ahrwrnGnAQcjNU8ljKp73qU0iz/LTVShGFlAmj4tEoeBDEF9Q4o0PN8cQitrN8nD1R0RzCpkJDT5cDX3aHCzHCPlfGcMaFFJPjpbNBWxBGGNHMJ7lCWLVkMrom/lrYA3kaaFEUsfbkgDf00nJc4AL6VCA7C9zVvUpQgYYXdP3i7Ack6q26jbkYmZ+r5bne3PsaO6DuNBgghxfNoiq7dzLrFUaB1/yFcEq5H930NQ6UfkMFFRGhwnceJDdIW24jBGuvDDhzYOA/+K/SVp5zm74CR5ZY3Ru0kZQWICl1ZMAgZLC0izHK1CBiluTUOuS9LVGImJWuAv+RA8wkTcrdYHTf68Ib81V5+l7fD0FeSRXn0L0EDG7T8DXHdmjAbHW6bH7KXhzNNlh0SuVe2iJYZCR2EWP7gn3By+qRvkQ/6Slo1ko0U6+9j7KP3x0W2V+/Haa5sjnuAMj0CciX6IZCrTNmGmCQrDAH797iHlPdiXdUECE9+NJHVdEibwaa4ux+FFaJB3FDQ2o+ZmT9RSix2HSvTR/4OtxXkuUMU9qe76caK3hcDnFplDDBDGOEhsxuScdNRlSgo68blhvBFcTTpcnq6t0urttfU2InCNxKO+A2W0t1sG1QPwJ/Si+bh/wKzKCjJw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(2906002)(5660300002)(55016002)(99936003)(478600001)(316002)(6636002)(38070700005)(110136005)(66476007)(8936002)(66616009)(66556008)(558084003)(64756008)(66946007)(6506007)(122000001)(7696005)(26005)(186003)(8676002)(52536014)(9686003)(76116006)(71200400001)(86362001)(38100700002)(33656002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EiOhKgK8p+6nUlW0Iyrvozdetuy69YwNmFU8wzkZoS8Z5gHixd0P2zvHIi7N?=
 =?us-ascii?Q?kxqo6uGI9veOjnMONgOf/LVglJKFHMJTiUu2t/QQVjDx4dr8rfsK35x+eYm9?=
 =?us-ascii?Q?fIANUkZCw/HKqXL/1wNqT/547u5iYEAlQCNkNT/+4o+CB6xcuAf04yUPhoXt?=
 =?us-ascii?Q?4Ane+Tyeb6fn7ojCLdMsmTzHtY+qAn6vjwOS486Q3fGPTsiw+j3EHky3R85J?=
 =?us-ascii?Q?Jj5hOgiNY65sUtbeHLgF1vaGn47HsFPIkBtIVfAGAxEbZvZDV9tXM0+aBmsv?=
 =?us-ascii?Q?cKrKB+8GZbV/fS/1WBoWwOjYaue2cNR5+DJzDxNm7zKwLpPFLRmQ3YA1xfWD?=
 =?us-ascii?Q?ZO5OH/nEeJNa5m3CJ7vOTBS7WdYRzpcWHUO8AJ1oqeXTM8Hevb+SvYsn7XMV?=
 =?us-ascii?Q?gZGeDiLW5Guq3hOCvd3I7w7gN18+l4W9zALsLTlA+vFElg3ZCCqlT9p49iph?=
 =?us-ascii?Q?bHEHkaB7oh1609Tzy/vzNyDTVCGnm+oP476IIa7HYxvMuPM34NvhfGUJW5JZ?=
 =?us-ascii?Q?RkpuSFj7DhQyd2utHubU1geCV2hBsUDzQDi4Uw7FxWdqiYibPVg2OtGTpzT+?=
 =?us-ascii?Q?8UhIz+yBwXQyVFxNAYORFEOgF5Fk8tWFvc5nIFicqnxNhd8mzwqoDQzX9Y2f?=
 =?us-ascii?Q?ghugwqN4IopzM/QbWzxlj+mf0BpflyCTBQC+j5QQj7KFXt9bnudWeMsVXSpw?=
 =?us-ascii?Q?22Bc3+faeHf0s0KVQuSSaM/7R0bOjREeOi3xXbNw6EyNr7WWE4Hx4/De5oLa?=
 =?us-ascii?Q?JBS4AM7mkdTZqBF2OqGo1HUhFYfqSzY82DMaJjaNHUS/X4Cej/FzRMT8/fRG?=
 =?us-ascii?Q?KLgW29qSlHGpZ1eJHI3iljYRl+XsZgeXBpnIpNZxM3LqRSNjDmMVeB2+epOW?=
 =?us-ascii?Q?IJIfwWuP+stxYZ+jnneNyir/wLo2fq1GV5Ppn93/aY1GBYlRt7KExVOJMtWz?=
 =?us-ascii?Q?IOzfNGk6MuurmQr3Dev4jcLog9M08ZDJsYLC3AMTiZ7zLnWW7iFj89AfwYM0?=
 =?us-ascii?Q?qIARI+EOysLyDY9dO5qeXo51GnyOwpHDJw7wxhytcARajw3Cdw8V1myP5owX?=
 =?us-ascii?Q?htiIM9D5oVDm2JPwh+nUboo/o1gqQdYeIKSP0C+XRbQxcInU8EWsR3QNjr58?=
 =?us-ascii?Q?wMoZi7kgepqoSmgst0WGfumdX7IEV39LR82iC6qVAb2WGjPNUiC3RdW8I1Qf?=
 =?us-ascii?Q?/5CtomUs3iXrQCOnUf5gzkfdbZPn5hRbD0/iyCg9lIkj7wGhhDqmxagX+Th8?=
 =?us-ascii?Q?4w/Z0iYJ+ubQ6d5/qf0cyPwRnihDV0qAJVBGAhBchv8ckA8rZC6q4yhxF/Au?=
 =?us-ascii?Q?jvbNm7mxjkZCsnx0JQqZjALs?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB52260A8475665CD687D384F4FBC79BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9e7d71-afd2-4cbe-464e-08d9685e5bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 06:54:32.5167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0NOqR7J1h7h9PQSbytcBr5bSyrby5nyU4+CMO5qc4vau7q6pV7MXpTDqjKiOzxLqGjZMvj9xYABHdo3CIVZsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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

--_004_BN9PR12MB52260A8475665CD687D384F4FBC79BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB52260A8475665CD687D384F4FBC79BN9PR12MB5226namp_"

--_000_BN9PR12MB52260A8475665CD687D384F4FBC79BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Submittng patch to resolve issue in clearing RAS interrupt on Aldebaran.

Thank you,
John Clements

--_000_BN9PR12MB52260A8475665CD687D384F4FBC79BN9PR12MB5226namp_
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
<p class=3D"MsoNormal">Submittng patch to resolve issue in clearing RAS int=
errupt on Aldebaran.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB52260A8475665CD687D384F4FBC79BN9PR12MB5226namp_--

--_004_BN9PR12MB52260A8475665CD687D384F4FBC79BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Clear-RAS-interrupt-status-on-aldebaran.patch"
Content-Description:  0001-drm-amdgpu-Clear-RAS-interrupt-status-on-aldebaran.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Clear-RAS-interrupt-status-on-aldebaran.patch";
	size=3976; creation-date="Thu, 26 Aug 2021 06:53:00 GMT";
	modification-date="Thu, 26 Aug 2021 06:53:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkMDU4ZjhlNjdlN2Q1NGExNTA1NTk5ZTU5NDk1Mzg2N2NhZDQ1MWExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgMjYgQXVnIDIwMjEgMTQ6NTI6MjAgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogQ2xlYXIgUkFTIGludGVycnVwdCBzdGF0dXMgb24gYWxkZWJhcmFuCgpy
ZXNvbHZlIHJlZ2lzdGVyIGFkZHJlc3MgaXNzdWUgZm9yIGRldGVjdGluZy9jbGVhcmluZyBSQVMg
aW50ZXJydXB0CgpTaWduZWQtb2ZmLWJ5OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFt
ZC5jb20+CkNoYW5nZS1JZDogSWJlMDg3ZTdjZTdlYWQwMmQ4ZTU5YTA0MTBkNTJlNjdiYTk3Nzgw
MTEKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYyB8IDM0ICsrKysr
KysrKysrKysrKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9u
YmlvX3Y3XzQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCmluZGV4
IDFjOTRhMTRmYzE4ZC4uYmExZDNhYjg2OWMxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9uYmlvX3Y3XzQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9u
YmlvX3Y3XzQuYwpAQCAtODUsNiArODUsMTEgQEAKICNkZWZpbmUgbW1SQ0NfREVWMF9FUEYwX1NU
UkFQMF9BTERFCQkJMHgwMDE1CiAjZGVmaW5lIG1tUkNDX0RFVjBfRVBGMF9TVFJBUDBfQUxERV9C
QVNFX0lEWAkJMgogCisjZGVmaW5lIG1tQklGX0RPT1JCRUxMX0lOVF9DTlRMX0FMREUgCQkJMHgz
ODc4CisjZGVmaW5lIG1tQklGX0RPT1JCRUxMX0lOVF9DTlRMX0FMREVfQkFTRV9JRFggCQkyCisj
ZGVmaW5lIEJJRl9ET09SQkVMTF9JTlRfQ05UTF9BTERFX19ET09SQkVMTF9JTlRFUlJVUFRfRElT
QUJMRV9fU0hJRlQJMHgxOAorI2RlZmluZSBCSUZfRE9PUkJFTExfSU5UX0NOVExfQUxERV9fRE9P
UkJFTExfSU5URVJSVVBUX0RJU0FCTEVfTUFTSwkweDAxMDAwMDAwTAorCiBzdGF0aWMgdm9pZCBu
YmlvX3Y3XzRfcXVlcnlfcmFzX2Vycm9yX2NvdW50KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogCQkJCQl2b2lkICpyYXNfZXJyb3Jfc3RhdHVzKTsKIApAQCAtMzQ2LDE0ICszNTEsMjEgQEAg
c3RhdGljIHZvaWQgbmJpb192N180X2hhbmRsZV9yYXNfY29udHJvbGxlcl9pbnRyX25vX2JpZnJp
bmcoc3RydWN0IGFtZGdwdV9kZXZpY2UKIAlzdHJ1Y3QgcmFzX2Vycl9kYXRhIGVycl9kYXRhID0g
ezAsIDAsIDAsIE5VTEx9OwogCXN0cnVjdCBhbWRncHVfcmFzICpyYXMgPSBhbWRncHVfcmFzX2dl
dF9jb250ZXh0KGFkZXYpOwogCi0JYmlmX2Rvb3JiZWxsX2ludHJfY250bCA9IFJSRUczMl9TT0Mx
NShOQklPLCAwLCBtbUJJRl9ET09SQkVMTF9JTlRfQ05UTCk7CisJaWYgKGFkZXYtPmFzaWNfdHlw
ZSA9PSBDSElQX0FMREVCQVJBTikKKwkJYmlmX2Rvb3JiZWxsX2ludHJfY250bCA9IFJSRUczMl9T
T0MxNShOQklPLCAwLCBtbUJJRl9ET09SQkVMTF9JTlRfQ05UTF9BTERFKTsKKwllbHNlCisJCWJp
Zl9kb29yYmVsbF9pbnRyX2NudGwgPSBSUkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSUZfRE9PUkJF
TExfSU5UX0NOVEwpOworCiAJaWYgKFJFR19HRVRfRklFTEQoYmlmX2Rvb3JiZWxsX2ludHJfY250
bCwKIAkJQklGX0RPT1JCRUxMX0lOVF9DTlRMLCBSQVNfQ05UTFJfSU5URVJSVVBUX1NUQVRVUykp
IHsKIAkJLyogZHJpdmVyIGhhcyB0byBjbGVhciB0aGUgaW50ZXJydXB0IHN0YXR1cyB3aGVuIGJp
ZiByaW5nIGlzIGRpc2FibGVkICovCiAJCWJpZl9kb29yYmVsbF9pbnRyX2NudGwgPSBSRUdfU0VU
X0ZJRUxEKGJpZl9kb29yYmVsbF9pbnRyX2NudGwsCiAJCQkJCQlCSUZfRE9PUkJFTExfSU5UX0NO
VEwsCiAJCQkJCQlSQVNfQ05UTFJfSU5URVJSVVBUX0NMRUFSLCAxKTsKLQkJV1JFRzMyX1NPQzE1
KE5CSU8sIDAsIG1tQklGX0RPT1JCRUxMX0lOVF9DTlRMLCBiaWZfZG9vcmJlbGxfaW50cl9jbnRs
KTsKKwkJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FMREVCQVJBTikKKwkJCVdSRUczMl9T
T0MxNShOQklPLCAwLCBtbUJJRl9ET09SQkVMTF9JTlRfQ05UTF9BTERFLCBiaWZfZG9vcmJlbGxf
aW50cl9jbnRsKTsKKwkJZWxzZQorCQkJV1JFRzMyX1NPQzE1KE5CSU8sIDAsIG1tQklGX0RPT1JC
RUxMX0lOVF9DTlRMLCBiaWZfZG9vcmJlbGxfaW50cl9jbnRsKTsKIAogCQlpZiAoIXJhcy0+ZGlz
YWJsZV9yYXNfZXJyX2NudF9oYXJ2ZXN0KSB7CiAJCQkvKgpAQCAtMzk1LDE0ICs0MDcsMjIgQEAg
c3RhdGljIHZvaWQgbmJpb192N180X2hhbmRsZV9yYXNfZXJyX2V2ZW50X2F0aHViX2ludHJfbm9f
YmlmcmluZyhzdHJ1Y3QgYW1kZ3B1X2QKIHsKIAl1aW50MzJfdCBiaWZfZG9vcmJlbGxfaW50cl9j
bnRsOwogCi0JYmlmX2Rvb3JiZWxsX2ludHJfY250bCA9IFJSRUczMl9TT0MxNShOQklPLCAwLCBt
bUJJRl9ET09SQkVMTF9JTlRfQ05UTCk7CisJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FM
REVCQVJBTikKKwkJYmlmX2Rvb3JiZWxsX2ludHJfY250bCA9IFJSRUczMl9TT0MxNShOQklPLCAw
LCBtbUJJRl9ET09SQkVMTF9JTlRfQ05UTF9BTERFKTsKKwllbHNlCisJCWJpZl9kb29yYmVsbF9p
bnRyX2NudGwgPSBSUkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSUZfRE9PUkJFTExfSU5UX0NOVEwp
OworCiAJaWYgKFJFR19HRVRfRklFTEQoYmlmX2Rvb3JiZWxsX2ludHJfY250bCwKIAkJQklGX0RP
T1JCRUxMX0lOVF9DTlRMLCBSQVNfQVRIVUJfRVJSX0VWRU5UX0lOVEVSUlVQVF9TVEFUVVMpKSB7
CiAJCS8qIGRyaXZlciBoYXMgdG8gY2xlYXIgdGhlIGludGVycnVwdCBzdGF0dXMgd2hlbiBiaWYg
cmluZyBpcyBkaXNhYmxlZCAqLwogCQliaWZfZG9vcmJlbGxfaW50cl9jbnRsID0gUkVHX1NFVF9G
SUVMRChiaWZfZG9vcmJlbGxfaW50cl9jbnRsLAogCQkJCQkJQklGX0RPT1JCRUxMX0lOVF9DTlRM
LAogCQkJCQkJUkFTX0FUSFVCX0VSUl9FVkVOVF9JTlRFUlJVUFRfQ0xFQVIsIDEpOwotCQlXUkVH
MzJfU09DMTUoTkJJTywgMCwgbW1CSUZfRE9PUkJFTExfSU5UX0NOVEwsIGJpZl9kb29yYmVsbF9p
bnRyX2NudGwpOworCisJCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9BTERFQkFSQU4pCisJ
CQlXUkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSUZfRE9PUkJFTExfSU5UX0NOVExfQUxERSwgYmlm
X2Rvb3JiZWxsX2ludHJfY250bCk7CisJCWVsc2UKKwkJCVdSRUczMl9TT0MxNShOQklPLCAwLCBt
bUJJRl9ET09SQkVMTF9JTlRfQ05UTCwgYmlmX2Rvb3JiZWxsX2ludHJfY250bCk7CiAKIAkJYW1k
Z3B1X3Jhc19nbG9iYWxfcmFzX2lzcihhZGV2KTsKIAl9CkBAIC01NzIsNyArNTkyLDExIEBAIHN0
YXRpYyB2b2lkIG5iaW9fdjdfNF9xdWVyeV9yYXNfZXJyb3JfY291bnQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCiBzdGF0aWMgdm9pZCBuYmlvX3Y3XzRfZW5hYmxlX2Rvb3JiZWxsX2ludGVy
cnVwdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkJCWJvb2wgZW5hYmxlKQogewot
CVdSRUczMl9GSUVMRDE1KE5CSU8sIDAsIEJJRl9ET09SQkVMTF9JTlRfQ05UTCwKKwlpZiAoYWRl
di0+YXNpY190eXBlID09IENISVBfQUxERUJBUkFOKQorCQlXUkVHMzJfRklFTEQxNShOQklPLCAw
LCBCSUZfRE9PUkJFTExfSU5UX0NOVExfQUxERSwKKwkJICAgICAgIERPT1JCRUxMX0lOVEVSUlVQ
VF9ESVNBQkxFLCBlbmFibGUgPyAwIDogMSk7CisJZWxzZQorCQlXUkVHMzJfRklFTEQxNShOQklP
LCAwLCBCSUZfRE9PUkJFTExfSU5UX0NOVEwsCiAJCSAgICAgICBET09SQkVMTF9JTlRFUlJVUFRf
RElTQUJMRSwgZW5hYmxlID8gMCA6IDEpOwogfQogCi0tIAoyLjE3LjEKCg==

--_004_BN9PR12MB52260A8475665CD687D384F4FBC79BN9PR12MB5226namp_--
