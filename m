Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D3FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 06:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6384D613CD
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 06:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6384D613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831AE6E176;
	Wed, 29 Sep 2021 06:06:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE61B6E174
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 06:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3i2YJufazgST7DpThvLVXrNJER41yxhgX9y9flkoZwG9bY96V/ZPNend0JvOmauwJYPZ/BeqOFJ22oUgzUAIMBFqOpUSj9wYHhd5HgXSjWIWhQSP6kNDpoXpKjCwJQb36H8sKEFsiOCfeNk7X0aS7AgChKGEPm0Aox10aNIZ3FgU89rXjc8WES+k418TAszBatGb2z/5MvHOya3lPvJa/k9OvkP0LHyh+thsgkGUFlUjOuczm8q0z1cxs0yWiqwhxats/92eG5XIltQ2P9ilpGMlpHozG73fVZArQsPp4QnlCe+OxpBLMBj/VIZMqaifH6eP9gGSdHnVfBQsLjQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=L8iph1YLlYBCXzR26526NWwETmg6YAY6mvwzPAlijoQ=;
 b=Ql37dHDKkuJKG3hitNnpmWbToD5nYtJnTKJAwOPrxefpamWtU5fOPH5+S+ePRpzVmdhwKRBnBRiJJZz2G/FQw/4Omjw5qyHjKZ37nGTCc8cRXkkXUl/hlpji6/tpsxCTw+NEYoezN3N1IUheC2IqsG/+UmDFVQ84Us9ob/ArXxNWzNaFD60p8I+L5Ii7FGuAG7MTXeCzLqZ0Y0G39+4ekU6rF4n2zAo402B0Fzp17AzIywbZXsn7m3u114ABYRzFe0OojNeW1J8a+B4yLOKU/lqfsQXWqP7zDZcTr5yDZ+KZXjyTKHu/wheHAfUsKefJn5bCDUMZLR5OGJR9fm+uZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8iph1YLlYBCXzR26526NWwETmg6YAY6mvwzPAlijoQ=;
 b=mqti024my0ey4HWO7By3Ua5tajOqid9QiOc3LeeHk0Jlf8pvnzjf59ftyQUDIyGeuzRmGGi6GnkoaHrQFBeyWFWs7LHuYRa871PVT49UEw6NlvEb+Jn7S9pem2zrFSNxvJ9JiIYXwRQFNIRnSOIxZ8pal9M9zSe8bdfvkl4K+JY=
Received: from MWHPR1201MB2542.namprd12.prod.outlook.com
 (2603:10b6:300:e8::20) by MWHPR1201MB0125.namprd12.prod.outlook.com
 (2603:10b6:301:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 06:06:33 +0000
Received: from MWHPR1201MB2542.namprd12.prod.outlook.com
 ([fe80::890f:f5c3:5f15:455c]) by MWHPR1201MB2542.namprd12.prod.outlook.com
 ([fe80::890f:f5c3:5f15:455c%6]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 06:06:33 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resolve RAS query bug
Thread-Topic: [PATCH] drm/amdgpu: resolve RAS query bug
Thread-Index: Ade0+AOhxyucOhgJSNqptAodmsakig==
Date: Wed, 29 Sep 2021 06:06:32 +0000
Message-ID: <MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99@MWHPR1201MB2542.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-29T06:06:30Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=87f4871e-644d-4853-897a-0c7e793a7ed9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f521cf8-f195-4a9d-1c8c-08d9830f49ae
x-ms-traffictypediagnostic: MWHPR1201MB0125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB0125DC881114C88E8F3B9288FBA99@MWHPR1201MB0125.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/DC9BAveorCCpULo0nluMtBuJiTLaEkjyxL/92EhNMKSoH33idhFbV59trWkDKV7o9na7vbfVsE0Tez1vFINeDY6MjIerO2ls3kqiz/9SsvrByTTGLxvmJTU2W5U6Lcmz/iQLApwgX0lLWL1lpBs5vrS7JPEm8RVgSYWxID5ivCG9E6B0Jy71x7fEWVrkPPFj7ZOnv5B1Ux171GjnEoU+i9hEmRmcyPAaz1oK8tDS6KgGOoFMyTPf1hSUWqtp3ea26jEa1PyK+gitwiTia6RObYTuf8I+GoB+IxZnK7GavmzD3yMqbhmTJIgITlIUN1YpFtJiI3btMC5jpxKHgBMH1Wb57UTMLYCk1MIYXgXLbBg2XJqiOs7tG782alochOKeTwSgGnRgqpnl2wZqGxRgrv+TKyqp12rj1dbwVmpoQqUOiEMcPKZ32Sr2Xwnl5SDrJ9lQ2m3Zv5OnUHF0HcGA0G+se3ZG1qiFJ0b55MqXDS8vNNnuJou09n0TuSM0sU9jH+8ysq3B6kzKYuhFPemW3SfCHYgaxV2o9UbP/6SW1RUnSanVgsNhq1NJEDcLlEmJG8HhzczS9Mi51BjjRl/gDJf5QK2g/x0BEDU1RBkmFZBgfURX6sxmnDJ274dubGn2LQvv6NkzfNuaaz2JX1IVaXCzkOJoSQTibqylgf5+/B/AnwDTZ32DC8/vtuCav7OjjgVJfExF4CcIcDhPhBbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB2542.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(186003)(110136005)(55016002)(66616009)(66476007)(64756008)(66556008)(66446008)(86362001)(38070700005)(9686003)(6636002)(33656002)(2906002)(66946007)(76116006)(5660300002)(38100700002)(71200400001)(52536014)(558084003)(8676002)(8936002)(7696005)(99936003)(6506007)(122000001)(508600001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qjmm0oKFtoyGlg9nNEGIaaw7R6g96VjnRbRLQNy+pmOnmJRLRD8li/VhtwqG?=
 =?us-ascii?Q?0aINTX5AOGNMUNnonlioP2FY3lEmN5NOip1rWEG++SaX5O0hCnBksez0CHsP?=
 =?us-ascii?Q?8OuoBugkHM0241JKCJbriaiSQcuWnpye8TkUTDgxXe9GhGnAHUPdswDXHZtr?=
 =?us-ascii?Q?GarJ5Dq6zGIO6XR2ByPnv1qz/bPDJhjMETZrg67PIKILqB7sJLnAwlUNmPx4?=
 =?us-ascii?Q?FG4kqDwWL8yH8Povxd2RkF9Yk1Ezn5YfaykoE783bW7FtzOhnuODAiISjWBO?=
 =?us-ascii?Q?gf6zGQ+bwQfbXawQY3Q75ahTbK5Si2GYwP7aV4Mtk7psOCSEATFgJSG1oMWm?=
 =?us-ascii?Q?gUXX8A9DnmoO+A+kBpjKcYF3OXaONbcrF3Mp9P8UwswZ0pE6OYpfHj6t012g?=
 =?us-ascii?Q?CB/K+sxrvr8SvlzR/HayEyczY/ZaplM4QPMFU5gfoWBCyQ141Ywu1RLL+TvR?=
 =?us-ascii?Q?QDRkwyEJqVZFeHucvtm1K1Zcm3K3N7Vte3hP2tLEUluIt1eSwXeJWAQpPsge?=
 =?us-ascii?Q?e7hHRTYFSB9I9hRSP/Gfty2hkBqfemgsKG2jUGmQVg3jRlnh4nyCygU5sWup?=
 =?us-ascii?Q?KJj4HL9eafsI1mtkJlGaIGz0uEBpTmaIAKNboLf1dA6WjdSB6rzOmIoy01kY?=
 =?us-ascii?Q?So73AFY14IgaEsv4EkVaH2bfgx6cquyHv6t8PWHVSNhWxDBE2kJngxbOsUTO?=
 =?us-ascii?Q?guu46pJlY5hyEoKuEQ+yUj7kGGdf/GCtALpk9z8AYrQ6g8Ukv7qJI+l1gndo?=
 =?us-ascii?Q?L45qyMZslVmKz7+pfokb7+56vNfknudlralqQSnMJq+i49nyNqwbKhisMrg8?=
 =?us-ascii?Q?bUTEpGCrls1WjF/1bIh1bN5h8t1ULZtxVfQD9e7lLWTdy6Q5AdJDnMN5VAap?=
 =?us-ascii?Q?ek0uI/AYiRVnLBXw3ZwUfL1zfVOP0K35xBhiUcTXHvuKtU8Mwj+Lt+SwKlmg?=
 =?us-ascii?Q?6rni4KZi6Y91GHr6eTbv2F7V5iRFpKSJ/rBs/PHsaMfOZFTLqHIUTafFbaCJ?=
 =?us-ascii?Q?KwkCbFPTHPuAxqu0RoWQiSIop1JupQAFQsYI4n5byQzc7GGmfrGcsSFf1kCn?=
 =?us-ascii?Q?BtjVqL81lMsFklWCGJ4yllmYqqDsiAmyNq0++UE9qtNIv/hRaJfecGFD2CDd?=
 =?us-ascii?Q?pebyAHj1QU+1+O7ZeunJ2TPeqsHxYVfQdEQveHb4ApOJGIaSABHQmF7wJI44?=
 =?us-ascii?Q?a6c/EfB3M3FjbBAE8o6mgAW+ifjy/v3PjXSFg8ENRv922DPrTymgGhUSQiCr?=
 =?us-ascii?Q?fKKeoHiJUvIJCSIMB+NORkVoIYlbhIqGVYnxMn2XoQHJxKkWJJYfL8s6kRyQ?=
 =?us-ascii?Q?CvuiWNHhSaIt1lin27HV3v5+?=
Content-Type: multipart/mixed;
 boundary="_004_MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99MWHPR1201MB2542_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2542.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f521cf8-f195-4a9d-1c8c-08d9830f49ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 06:06:33.1202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mnGx4p2wXL56P9WbRZGCYGBvm92zAAp3mhXYc6rRrLfKxMboIyv22hnlmpGjWvbYxPY+LOPhxcHuawrjDD8IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0125
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

--_004_MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99MWHPR1201MB2542_
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99MWHPR1201MB2542_"

--_000_MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99MWHPR1201MB2542_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Submitting patch to clear RAS error encounters during error query if persis=
tent harvesting is not enabled

Thank you,
John Clements

--_000_MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99MWHPR1201MB2542_
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
<p class=3D"MsoNormal">Submitting patch to clear RAS error encounters durin=
g error query if persistent harvesting is not enabled<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99MWHPR1201MB2542_--

--_004_MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99MWHPR1201MB2542_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolve-RAS-query-bug.patch"
Content-Description: 0001-drm-amdgpu-resolve-RAS-query-bug.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolve-RAS-query-bug.patch"; size=2179;
	creation-date="Wed, 29 Sep 2021 06:05:00 GMT";
	modification-date="Wed, 29 Sep 2021 06:05:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMjBiOTg0MDVjYmNhZDUyMjY1MGVmMjFkYmI3N2MyMDdiN2Y0NjRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgMjkgU2VwIDIwMjEgMTQ6MDQ6MDIgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogcmVzb2x2ZSBSQVMgcXVlcnkgYnVnCgpjbGVhciBlcnJvciBjb3VudCB3
aGVuIHBlcnNpc3RhbnQgaGFydmVzdGluZyBpcyBub3QgZW5hYmxlZAoKU2lnbmVkLW9mZi1ieTog
Sm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEkyMThlZjY3
OTk3M2RiNDg5NmRjMmE3ZjEwMWEzZTcwZTFkZmFmYjYzCi0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgMjEgKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXMuYwppbmRleCA4MjQzZjc5YTdjNGUuLjc2NzIxOWI3NmRmZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwpAQCAtOTA5LDYgKzkwOSwxMyBAQCBpbnQgYW1kZ3B1
X3Jhc19xdWVyeV9lcnJvcl9zdGF0dXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJ
YWRldi0+c2RtYS5mdW5jcy0+cXVlcnlfcmFzX2Vycm9yX2NvdW50KGFkZXYsIGksCiAJCQkJCQkJ
CQkmZXJyX2RhdGEpOwogCQl9CisKKwkJaWYgKCFhbWRncHVfcGVyc2lzdGVudF9lZGNfaGFydmVz
dGluZ19zdXBwb3J0ZWQoYWRldikpIHsKKwkJCWlmIChhZGV2LT5zZG1hLmZ1bmNzICYmCisJCQkg
ICAgYWRldi0+c2RtYS5mdW5jcy0+cmVzZXRfcmFzX2Vycm9yX2NvdW50KQorCQkJICAgIGFkZXYt
PnNkbWEuZnVuY3MtPnJlc2V0X3Jhc19lcnJvcl9jb3VudChhZGV2KTsKKwkJfQorCiAJCWJyZWFr
OwogCWNhc2UgQU1ER1BVX1JBU19CTE9DS19fR0ZYOgogCQlpZiAoYWRldi0+Z2Z4LnJhc19mdW5j
cyAmJgpAQCAtOTE4LDYgKzkyNSwxMyBAQCBpbnQgYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9zdGF0
dXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCWlmIChhZGV2LT5nZngucmFzX2Z1bmNz
ICYmCiAJCSAgICBhZGV2LT5nZngucmFzX2Z1bmNzLT5xdWVyeV9yYXNfZXJyb3Jfc3RhdHVzKQog
CQkJYWRldi0+Z2Z4LnJhc19mdW5jcy0+cXVlcnlfcmFzX2Vycm9yX3N0YXR1cyhhZGV2KTsKKwor
CQlpZiAoIWFtZGdwdV9wZXJzaXN0ZW50X2VkY19oYXJ2ZXN0aW5nX3N1cHBvcnRlZChhZGV2KSkg
eworCQkJaWYgKGFkZXYtPmdmeC5yYXNfZnVuY3MgJiYKKwkJCSAgICBhZGV2LT5nZngucmFzX2Z1
bmNzLT5yZXNldF9yYXNfZXJyb3JfY291bnQpCisJCQkgICAgYWRldi0+Z2Z4LnJhc19mdW5jcy0+
cmVzZXRfcmFzX2Vycm9yX2NvdW50KGFkZXYpOworCQl9CisKIAkJYnJlYWs7CiAJY2FzZSBBTURH
UFVfUkFTX0JMT0NLX19NTUhVQjoKIAkJaWYgKGFkZXYtPm1taHViLnJhc19mdW5jcyAmJgpAQCAt
OTI3LDYgKzk0MSwxMyBAQCBpbnQgYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9zdGF0dXMoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCWlmIChhZGV2LT5tbWh1Yi5yYXNfZnVuY3MgJiYKIAkJ
ICAgIGFkZXYtPm1taHViLnJhc19mdW5jcy0+cXVlcnlfcmFzX2Vycm9yX3N0YXR1cykKIAkJCWFk
ZXYtPm1taHViLnJhc19mdW5jcy0+cXVlcnlfcmFzX2Vycm9yX3N0YXR1cyhhZGV2KTsKKworCQlp
ZiAoIWFtZGdwdV9wZXJzaXN0ZW50X2VkY19oYXJ2ZXN0aW5nX3N1cHBvcnRlZChhZGV2KSkgewor
CQkJaWYgKGFkZXYtPm1taHViLnJhc19mdW5jcyAmJgorCQkJICAgIGFkZXYtPm1taHViLnJhc19m
dW5jcy0+cmVzZXRfcmFzX2Vycm9yX2NvdW50KQorCQkJICAgIGFkZXYtPm1taHViLnJhc19mdW5j
cy0+cmVzZXRfcmFzX2Vycm9yX2NvdW50KGFkZXYpOworCQl9CisKIAkJYnJlYWs7CiAJY2FzZSBB
TURHUFVfUkFTX0JMT0NLX19QQ0lFX0JJRjoKIAkJaWYgKGFkZXYtPm5iaW8ucmFzX2Z1bmNzICYm
Ci0tIAoyLjE3LjEKCg==

--_004_MWHPR1201MB254260B8D14ABCC6E8A796A0FBA99MWHPR1201MB2542_--
