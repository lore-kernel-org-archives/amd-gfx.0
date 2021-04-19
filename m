Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7132AC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 02:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D5A61002
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 02:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D5A61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A291E89FF7;
	Mon, 19 Apr 2021 02:46:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9042089FF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 02:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B73lFR+9cJA35WNmCNtrPMEyi8sBmNoNU8TjiBWBQu3kCIMeeBndfQOAVlHgmXMEBi/DxQJAo2W+LObtRRprMit9uYyUvEJW+zTY95wDKDn3ZZ3N3PwAzSbMJn1UXKgG5DtRctS2L+04m2JVQOh5ypFXU9SxUWk7NgotBocG7ZYZFCTLwqbNybWthw2Z4Tv1uKHUzFDD3+E6sBhFvcjjxLnnItozhNAQe9mPIB5HcI58QaiX9c9YMj/AbB2jXTIn1DqV3PfMkoTiGoOimno9A2JC5/k/STRmRTKGs5qbVQSyQo4u06yaOZeC7SPH6HZt7GhiIgWKuXjd78mPkp5sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DomyJxFeogxEmxqL5FeM9OpxaZ0AGlcc0E3xhAr92E=;
 b=CAeeYy9HZ7S9EP2LQmtfkGb8d/LLor59FytucI9M8Km4UwK1Fy3/nL13380BbL0Gl6zz/dNbaJ9uC92XlpVH84IBdd0a6L3LJYDpqs1nJmgQ8LPuz4WgYXV6DDMkKT/NpDhMZwvsqASOZM6bY2lAPGanCcq73juhXqu86eMeApkJlvZhg7egcOoHDs9Ncd3rCpW1zOkMO777wqJ65bco1saATIaoyhc7bX2axpyZSv99ZfnWJXulS7fguIIXO2CWosTxWT4fh4Bp5r9BRURvHUh+skGYGijYJ6u0rArjvJrQhs/fKmuCmLjnRAxSbw/la80PU8MeKFKfzXt4ncLmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DomyJxFeogxEmxqL5FeM9OpxaZ0AGlcc0E3xhAr92E=;
 b=xZoUd34NJ8eqtv3qy5cCdRYVdH9YtQzM2HTfU8zLC7962dX5C2JvLzJRFBtgp/LcSHEV/F4pxcBAkuiqHx3/AFtYYO11DpNFy6d3KpU6bUFGnJbyLYUkg3wF2oIa8jpgZpJCXU5pWHi78TkfjH6QwQ8IEKgSuHkODEAk/idKHCY=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR1201MB0024.namprd12.prod.outlook.com
 (2603:10b6:910:1b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Mon, 19 Apr
 2021 02:46:41 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe%11]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 02:46:41 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resolve erroneous gfx_v9_4_2 ras prints
Thread-Topic: [PATCH] drm/amdgpu: resolve erroneous gfx_v9_4_2 ras prints
Thread-Index: Adc0xjP0y4AQVY4vRsaWPqugsOvC1w==
Date: Mon, 19 Apr 2021 02:46:41 +0000
Message-ID: <CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499@CY4PR1201MB0072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-19T02:46:34Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fc95b733-e582-4577-928d-6b9634704b15;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3cb9f95-3697-41cb-93ce-08d902dd5ce6
x-ms-traffictypediagnostic: CY4PR1201MB0024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0024B9286D7BEC84581A11B8FB499@CY4PR1201MB0024.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7U7GEHy6xpTfmAA0DG+u6vrvZC3MwuANnG3pAaOAxG0lv1fOVNsaG5G/FWHN1xsRYpN8MYLvFvnUms8VGxlYpxpAs4ZfzYK0AmtR6x5vEcThI5CDJM0DkLIBzJGcZgyI1wubYqj98Y/1nmDp9oZPoHzcozd16oSiEzDHI5HWZXtDTibJYv4xmPD8I9fZzUyMGYWVOWAzTapieBeCanCdnHHoKOEnVFB7sBNyz5R5qTwwM5tvL7f1YM6O8vgcWDIPtfGykZkp2IMq01T2AsRYEFsghyB1P5BAkXjbKFSmZxEACZIbcmkYxLHN6mYRBxo3giqJ5tHvwnPuB0JOX2X+IlTNfG1qoGV2QOmpD00HGowqwA14rX8H7pzpC9rUWYBWEDuyJiGfZFx72kH+FvTn+QbZz8ccJ9UquXTzzQHdDNC6k0NvUsAE7I51UAC+eQJDAGm0jBhJdJO9ZQfyfKqnvHrg1Rqny/BKlXaPfsaZBkdb91HMuTMU5QTpldbKvBX4t+NTxHoLrGdRe7qFNXPrIaAzjXgszXoIB85oVmoZscvQW2J9+xmT8MAhVfCtvYCmO+0xApa4u7UKetM83DNrWAL1sdPPgg58nF9J1rny1IQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(66616009)(66476007)(66556008)(76116006)(66446008)(64756008)(66946007)(33656002)(99936003)(6506007)(8936002)(8676002)(26005)(186003)(6636002)(110136005)(55016002)(9686003)(316002)(7696005)(478600001)(86362001)(5660300002)(122000001)(38100700002)(71200400001)(2906002)(558084003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HQz9jAATjmfz0LqnlngaBF0flrwF47t/erRHEfl0Q0exCIQfkMCd/nSV8OuG?=
 =?us-ascii?Q?TsfNhgV6rf+WkTTnPeoJ02z45uXoV2hXUbl3kRq07HJMkt55YxwXfMmCfe8Y?=
 =?us-ascii?Q?jIwdKjwsLPnKH+JSTF0P6T2VIKTpLN/VlP7+1y1RkfLFpX1O5Hb8jjb8LwE4?=
 =?us-ascii?Q?Ewoni6UPhGzUX0wUMiZciy3i/V/JfNsWZmQ03m6DFvBXCjppA4VyDVzQpCLh?=
 =?us-ascii?Q?niV+zNqoMd49rSxsbtIYS5w5qmWLBI2X6+AkM9BUEKNQUBBR722w9H4WzPnb?=
 =?us-ascii?Q?8BclsJtLor1+02M3By8DLNa12nfzttTt+9K2XaKqQ5sqS4yOq92Pp+Pju4S8?=
 =?us-ascii?Q?vRshATtRe0QwOG3rsPIZJ5R78v9pBZmcJ3hf/onuZXZN4u6knAXXrqxDiJlp?=
 =?us-ascii?Q?Io17jqB5hvL2P31K4BoAjbTVVxJ0KV0nE9ks6Fo6rVmYPhP/bfCieZYIDMa+?=
 =?us-ascii?Q?FBjTwjVmoEPEynBwmVV5KaIOcLV+F0JJ1rcT+CVrMp+gR/Q5p/bfqEdnYLYF?=
 =?us-ascii?Q?BatRyQoQ6tmXOCO5THENM8IawZ92nAwF7TgqRSqm8mBNS0TNvblQzzmn1nie?=
 =?us-ascii?Q?ne9R2WV/aOatrhY8sa1HYGMhmwYOy3zR7IJDXkGg1uLdI9rmt0Ab2+qWuvrH?=
 =?us-ascii?Q?7eyXFGdcuPLfVpW4cqR+H/1OxEZF6zeBEr/scWlb+eFjJe8N0xr+51jwzV3F?=
 =?us-ascii?Q?8wPHjeO/KL9crUaHIzlM3K0Y4DRn+PPpVWO73ueHpNCMdVKVCho7tKUw54oS?=
 =?us-ascii?Q?+J8ChkycB0bwHpdWa8nFxciqAYB/fFEd8iXcZN+lYaLuVJj3nMc7JwSc/Csy?=
 =?us-ascii?Q?XYlJrq1JseQGJhkKua4l/Q8LjYLmswNrow9MyrmxRhva/Az6dSKJvFNYOJsW?=
 =?us-ascii?Q?lSOX9s+nR5JafkrNA+vfkVvuD0QkrDGx7A+stfqFR0/8OeNHrZkSqWTrc9Uk?=
 =?us-ascii?Q?VuGs9CT4Alzg9ioeubnwVjsxhnUEdHg4fy+YNtPCXOMcQPogb0n+/X80bSBq?=
 =?us-ascii?Q?RqqIEpFyVtegNChRXhu7ZsGRzJzA8xPZVU+kGG+2dOBkt92UtHWiwqCyoEeE?=
 =?us-ascii?Q?RoqY1d4l3X4zuCz2AtS3jOD3oJWwZUFztd51VFQL4egEcqrEKRLqwR4rcpf1?=
 =?us-ascii?Q?Y8KeqI+ntGQ4jb3NF/hKyC9H9CHozqvByeSPlFd3NMX4kma5xVr09Q+DZM0u?=
 =?us-ascii?Q?NTe7IBxazSCjf81hn/lNhdievPD5lOqPAWnEFZrWWc89zBizMqSqURDJbGBR?=
 =?us-ascii?Q?tavAAahbI92XrWELGEVVfJdh6pDx+AR5WtlSj1iO2NxN93pkMfmZIuuybkEt?=
 =?us-ascii?Q?JHDLszFeSiHRRmOH7Sb8swZH?=
Content-Type: multipart/mixed;
 boundary="_004_CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499CY4PR1201MB0072_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cb9f95-3697-41cb-93ce-08d902dd5ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 02:46:41.8039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWa0+FZbdHsrHFSLV3xZ+Lh0HJy5/SDn7+eD0b3jjgIHm5Fh0rHgHI3hgOZ/X9eIOa85O7Tl10LU1qk2F0grag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0024
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

--_004_CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499CY4PR1201MB0072_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499CY4PR1201MB0072_"

--_000_CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to resolve bug where gfx_v9_4_2 ras related prints would a=
ppear on driver loading when there are no ras errors.

Thank you,
John Clements

--_000_CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499CY4PR1201MB0072_
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
<p class=3D"msipheadera92f4c5c" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:11.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to resolve bug where gfx_v9_4_2 ras=
 related prints would appear on driver loading when there are no ras errors=
.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499CY4PR1201MB0072_--

--_004_CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499CY4PR1201MB0072_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolve-erroneous-gfx_v9_4_2-prints.patch"
Content-Description: 0001-drm-amdgpu-resolve-erroneous-gfx_v9_4_2-prints.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolve-erroneous-gfx_v9_4_2-prints.patch";
	size=1065; creation-date="Mon, 19 Apr 2021 02:45:00 GMT";
	modification-date="Mon, 19 Apr 2021 02:45:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4YmExZGY0NDdkYWIzMmNmYWQzZWQ0OWM3YmFjZWJhODlhODU1M2M4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IE1vbiwgMTkgQXByIDIwMjEgMTA6NDI6NTEgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogcmVzb2x2ZSBlcnJvbmVvdXMgZ2Z4X3Y5XzRfMiBwcmludHMKCnJlc29s
dmUgYnVnIG9uIGFsZGViYXJhbiB3aGVyZSBnZnggZXJyb3IgY291bnRzIHdpbGwgcHJpbnQgb24g
ZHJpdmVyIGxvYWQgd2hlbiB0aGVyZSBhcmUgbm8gZXJyb3JzIHByZXNlbnQKClNpZ25lZC1vZmYt
Ynk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KQ2hhbmdlLUlkOiBJNzRi
NTE0MjQ1MTQ0YzVhNDQ2ZjRmNmRjYWQ0ZTA3ZTdiMTljOGJlMAotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV80XzIuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV80XzIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80
XzIuYwppbmRleCAwMDcwYzA5MWIyYjcuLjYzZWM3MWFiZWQ1MyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRfMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV80XzIuYwpAQCAtOTk3LDcgKzk5Nyw3IEBAIHN0YXRpYyBpbnQgZ2Z4
X3Y5XzRfMl9xdWVyeV91dGNfZWRjX2NvdW50KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
CQkJICAgICAgIGJsay0+Y2xlYXIpOwogCiAJCQkvKiBwcmludCB0aGUgZWRjIGNvdW50ICovCi0J
CQlpZiAoc2VjX2NudCB8fCBkZWRfY291bnQpCisJCQlpZiAoc2VjX2NudCB8fCBkZWRfY250KQog
CQkJCWdmeF92OV80XzJfbG9nX3V0Y19lZGNfY291bnQoYWRldiwgYmxrLCBqLCBzZWNfY250LAog
CQkJCQkJCSAgICAgZGVkX2NudCk7CiAJCX0KLS0gCjIuMTcuMQoK

--_004_CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_CY4PR1201MB0072EA9CE113F9CAEC0348F9FB499CY4PR1201MB0072_--
