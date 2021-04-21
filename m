Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA1EC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 06:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859906140F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 06:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859906140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E33C6E17B;
	Wed, 21 Apr 2021 06:55:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE956E17B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 06:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXHKTEpqyeaBanLKAjad+YvBoCmcEsUJ1E3OtuHnTMuoV0tGEko4uf7iqFdvVfPRkuxw/ZlaZClD2qQLNx7oEg1h11iu1iMcJ+onXCRNuhWAf7wjfHkuwUFIK28orl9hjSzj7uVz5PZZyGoIRfebw26DTujdf3uU7L0XMfnlkXjIBTB3QtVzC/HUGWq8WtcpA8m2JD5eJmqb83joN4hKArdBRpdvXc6oXaK+sjV0aQh6e0oN2pqQBXL55/VfrVhfu8r3Mf1y1qc4SMGAlbT7FbHNYIyZKJ4EH6E7QbItszrqrb5zPmE0rcHUwSTLc9w8CoxJ2Oo/eiMpCwC9MbNa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1LL/AsxCXwTOjQ7mYopquvPXp07u6MyKZk00jywGLA=;
 b=ZQ93Tz/8jZTcHHIVPGdGmM5KS+9WebIMmL2/GFaaco+kIkgh3PtjUAprgc8UXjN/WCCHUluATe+fExDYq8jtAJaOvTZRcCPaR1pi5qtDSchdLU1l9aQ1NYk8kAxtmYY/JO4Dv5Ne4RJcuV9fmP+k2kH9FxtB/yOVcOEwXABaI21I/Z5S3FaGS/d6E0jQTnId1mYFWqjq4I7Y4Dg4tD5XTPqP3fy0spG0A+EWwQwN/nNuxtLezZbiwjMAqlaKPOpa7Fqq+EWnAwkhD6gPdQgK9DdTGF8pzMx9GkHqrCpPPlB9cKD5IUvmR84T/DWeI///2fMAd8WWFnZ+HfSoQxIbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1LL/AsxCXwTOjQ7mYopquvPXp07u6MyKZk00jywGLA=;
 b=UANHYQQg8h0sWaue/gdrZz/O/B1jJywDPIm3yPR55vTTUsjHzzzXVIxt6PItoY1PRFmErJ127RBqC/yxI1AFA9bXxtr76iP9keaRRv6RQ+t/H+teswhA65lqMjveWgnjv+GniA3GKm5EWu/m0eKlGSJZChL860ez3miDm6Md9/E=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR1201MB0070.namprd12.prod.outlook.com
 (2603:10b6:910:18::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 06:55:54 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe%11]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 06:55:54 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resolve ras print bug
Thread-Topic: [PATCH] drm/amdgpu: resolve ras print bug
Thread-Index: Adc2e04e1YXxg/BBTdGWYHHrcPYEiA==
Date: Wed, 21 Apr 2021 06:55:53 +0000
Message-ID: <CY4PR1201MB0072579CCC7ED34A57536F6FFB479@CY4PR1201MB0072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-21T06:55:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=dc26c395-51ff-4a47-86dc-be472f66b338;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a2c42dd-1883-499d-b100-08d9049281e5
x-ms-traffictypediagnostic: CY4PR1201MB0070:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB007093DB8221F8A82F702065FB479@CY4PR1201MB0070.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fpy08cl1DnDFFCej1KY2TpH8Hce8JWZxgMJKHS6oKevXDzvUT9cy1nGeyJLquQgY0kegabOGLvg+Bv3vcx7+9kSp7ovuo8z6Hb1b1QifVvSkmfp8KQE45P77D5SvcZUSyBy8RVty0CKhTgj7Ldc0VX2+QM1slfHcGpuWyRNFyu7NEMGfXxQWN/o3WZ58hcG49W1/OsDlF/kdlEUiblJtR2/MTaVCqq1aJOQgoZM4xYoJHR0t9OWRu4HJCO3ZU+UXHr290ymoLRXzD+4Y1o4cK3ctZUOUHTtd20TgJE4LZwfGAKAKG/ai+okbs7gxC2P5CV5OmCLYnJKcnZqC2ZWXMoIECkJ+wfxDR/XkpZ6NHC1mDs7wklTtzfVfNcrK5b9w00TKF1UbQsp8krpjOjTJInzxGn8IcLfdK6TZZlyKJ7gXkYnLggJXClZl+TUgKSEeEXCWudhWavGkDMFWwH8sqieJJg0ggJ5w/aUjq+zX++v/ILss5rf+1Yu4TRQQxLsxMtwdLS+dI23CzAO3Y0dvUpF/Frqrv2lgOKn8hTuQpVH9+wS90GsKHgtQo1Oc1XoYvXq+ca+lO4HK1tsVDzI649xp8atzUIibko1b5JwDppg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(2906002)(7696005)(316002)(5660300002)(99936003)(9686003)(52536014)(86362001)(6506007)(8676002)(38100700002)(76116006)(558084003)(478600001)(186003)(66476007)(33656002)(122000001)(55016002)(6636002)(110136005)(66616009)(8936002)(66946007)(64756008)(66556008)(26005)(66446008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kxbxE24phR3oVlmPKcfRFEoDnAtEkiVfa6M+1oK9phgjclrghwDR5Z3An7Ys?=
 =?us-ascii?Q?il+115tHEkjFXjalrlHt9SK6Lbte+fnbVlZsDpKP/wc8CCn5Td2RprGVWZeR?=
 =?us-ascii?Q?xzPyMszT+VBKbYiIqkepbcG8ejbeFpt23EOKPNnPFkkDPnSrgWugkz9pANE8?=
 =?us-ascii?Q?gfgduv204Lioh/QbI0ljn1bm8WTaHvzRC6fEK32Jxtbvn2Q5iay21qFbrmoQ?=
 =?us-ascii?Q?9bwFzoTxyiTvqSP9M1Trp+TQAFnk9Pqh79aQtGthSXP6HrhbBkH6KigndRJ+?=
 =?us-ascii?Q?dwG07uZUB/7jca4pvl5yGmZzwB4tBGLR5I309phRs++qDgb0b/Rs5mnbQAkP?=
 =?us-ascii?Q?lv6OM3PiRt052HmxNuOgfeKY8laL6KUc58ZjI1sAvEl2PDJisLkIEjKiAmFK?=
 =?us-ascii?Q?F3Ue+xvhsVcPWrXTjiuMRXaE8cyhe0IEGvqRJ+xdIJm92lmZkZXZYua4uL7a?=
 =?us-ascii?Q?ujcsQWaeXW6jMMX9/wGQt+XoHfW8ZWPCO3yCy0OzLwJgA3/S/F/Ju/QFYUqL?=
 =?us-ascii?Q?uIBIV1TggBhODkegCjvOU52uU0h1LkKYC0t/Qu3hc/kWYkg4GE4AKcTM5ext?=
 =?us-ascii?Q?BFHcvShR5gGk9Uf6Z4LxpugiZjNNhqYNaCo33osSGLhYfAp0zhwpA5h9xXRb?=
 =?us-ascii?Q?LMDG/cdEcgRdNrW9yv0YuT6NawiCKwTn2voeTKfJtHweliIgA1OlOYMh/fvK?=
 =?us-ascii?Q?Nt3VA6fyVXjErqUTziopDlw3hJ9Z66J+wDSopQcoKCBh32qjZLIQsr3bWbd8?=
 =?us-ascii?Q?fckJHJGUWiVihRWgnrwLNxLN0mVi1OOs8WLig7izlsz6wLHPrKqwG4jP3NPs?=
 =?us-ascii?Q?kh7oqJKFZmQ37FvM4nMo/JR7ZRn3/Sz0iPQ1AczHo9mI7RtIYNmvBIxTL/Kj?=
 =?us-ascii?Q?l28gYfkwU2V3/Yj+0Q6V7FSIbPkcGAgjewPqOR+z8n1x1gzyYvWpdzafD0Cj?=
 =?us-ascii?Q?fnw7gEZCChTy2HK4iGSX6QBEJQ6bJKBwRlwkk7mZp+MOskTsW45qJtJ9apWG?=
 =?us-ascii?Q?iB5qcvWXhnaU1U+Qi1ML1Vv3W/MgGEJzCu3ko8/0pwxbWZfAB8RUvqwKyWxr?=
 =?us-ascii?Q?Mmz1wpZ5l68de89U0QI3y8Aa3g1DYmj49BhtacCz6fNWIkUm9nAdVar0YfJa?=
 =?us-ascii?Q?xa1kkPKm9px/kvh7PIC65HKZeSDFQLr2mSNJaWLAatCW4XBf6DqFuxEX2Ksj?=
 =?us-ascii?Q?up85dbBpCPkLRGoDrIRlTcNW+VgoHsMMMSLCtIjK3hrEGjz/444bd1V+xQJS?=
 =?us-ascii?Q?STC/uy/Nhy7tMwnLpNhW2NNMCTDQWyFKiGmvrAV2NZgnodXASUxNMXa+XUYs?=
 =?us-ascii?Q?dzNqW8GqBxlVMYZKb89Hu6dK?=
Content-Type: multipart/mixed;
 boundary="_004_CY4PR1201MB0072579CCC7ED34A57536F6FFB479CY4PR1201MB0072_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2c42dd-1883-499d-b100-08d9049281e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 06:55:53.8387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxMBPY9PhnG5jYcrhugl1t+Tx+XaONxPrx4JCu2lwaNR5U+MJwvhxcMEZjT9mkQhqBM38iRmgnzdYMv7ni6low==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0070
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

--_004_CY4PR1201MB0072579CCC7ED34A57536F6FFB479CY4PR1201MB0072_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB0072579CCC7ED34A57536F6FFB479CY4PR1201MB0072_"

--_000_CY4PR1201MB0072579CCC7ED34A57536F6FFB479CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to resolve RAS related dmesg print issue

--_000_CY4PR1201MB0072579CCC7ED34A57536F6FFB479CY4PR1201MB0072_
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
<p class=3D"MsoNormal">Submitting patch to resolve RAS related dmesg print =
issue<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR1201MB0072579CCC7ED34A57536F6FFB479CY4PR1201MB0072_--

--_004_CY4PR1201MB0072579CCC7ED34A57536F6FFB479CY4PR1201MB0072_
Content-Type: application/octet-stream;
	name="0002-drm-amdgpu-resolve-ras-print-bug.patch"
Content-Description: 0002-drm-amdgpu-resolve-ras-print-bug.patch
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-resolve-ras-print-bug.patch"; size=1338;
	creation-date="Wed, 21 Apr 2021 06:55:00 GMT";
	modification-date="Wed, 21 Apr 2021 06:55:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2YjA1Yzg3MGMxNzQzNzQ4ZjQxNjgzNmZkNTkyNWVkNzZlNWFhYzcxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgMjEgQXByIDIwMjEgMTQ6NDA6MjIgKzA4MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gZHJtL2FtZGdwdTogcmVzb2x2ZSByYXMgcHJpbnQgYnVnCgpvbmx5IHByaW50IG1tZWEgZXJy
b3Igc3RhdHVzIGluIHRoZSBldmVudCBvZiBlcnJvcgoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVt
ZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEk4MGJiMDg4ODc5ZWM5ODQ5
NzFmMzk1ODcxOWYxNDkxYmRmMDEwYmUxCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bW1odWJfdjFfNy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJf
djFfNy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfNy5jCmluZGV4IGUx
NTAwYmU0YTIwOC4uYzRiYzQ1ZjY0N2VlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9tbWh1Yl92MV83LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1o
dWJfdjFfNy5jCkBAIC0xMzA1LDcgKzEzMDUsNyBAQCBzdGF0aWMgdm9pZCBtbWh1Yl92MV83X3F1
ZXJ5X3Jhc19lcnJvcl9zdGF0dXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJZm9yIChp
ID0gMDsgaSA8IEFSUkFZX1NJWkUobW1odWJfdjFfN19lYV9lcnJfc3RhdHVzX3JlZ3MpOyBpKysp
IHsKIAkJcmVnX3ZhbHVlID0KIAkJCVJSRUczMihTT0MxNV9SRUdfRU5UUllfT0ZGU0VUKG1taHVi
X3YxXzdfZWFfZXJyX3N0YXR1c19yZWdzW2ldKSk7Ci0JCWlmIChSRUdfR0VUX0ZJRUxEKHJlZ192
YWx1ZSwgTU1FQTBfRVJSX1NUQVRVUywgU0RQX1JEUlNQX1NUQVRVUykgfHwKKwkJaWYgKChSRUdf
R0VUX0ZJRUxEKHJlZ192YWx1ZSwgTU1FQTBfRVJSX1NUQVRVUywgU0RQX1JEUlNQX1NUQVRVUykg
IT0gMykgfHwKIAkJICAgIFJFR19HRVRfRklFTEQocmVnX3ZhbHVlLCBNTUVBMF9FUlJfU1RBVFVT
LCBTRFBfV1JSU1BfU1RBVFVTKSB8fAogCQkgICAgUkVHX0dFVF9GSUVMRChyZWdfdmFsdWUsIE1N
RUEwX0VSUl9TVEFUVVMsIFNEUF9SRFJTUF9EQVRBUEFSSVRZX0VSUk9SKSkgewogCQkJZGV2X3dh
cm4oYWRldi0+ZGV2LCAiTU1IVUIgRUEgZXJyIGRldGVjdGVkIGF0IGluc3RhbmNlOiAlZCwgc3Rh
dHVzOiAweCV4IVxuIiwKLS0gCjIuMTcuMQoK

--_004_CY4PR1201MB0072579CCC7ED34A57536F6FFB479CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_CY4PR1201MB0072579CCC7ED34A57536F6FFB479CY4PR1201MB0072_--
