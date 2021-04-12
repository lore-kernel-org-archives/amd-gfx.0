Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06973C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 06:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCFD611F2
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 06:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCFD611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EEC16E147;
	Mon, 12 Apr 2021 06:17:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0386B6E048
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 06:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gt/lvsWt4mL2Dtts9KaMXqDdCNuf4jUQeOJWUunYNaqfrjENWkgDZf/OjW4y7YChVF0GNNm2FXHsm7vFeUKnpCUtnbpn2G/cSBPMJDcfT+NB2gjHyM53iCnirbLsSjP4yAnP3e1wxSluXRBsOn7Upe+IrEreYB+PS2lysh8NNLKU1c9a6oxD4BQx4d6M82k8MNbNx6w0mQH7tqTHaVY/mCVFvrwblOFN62QmEf79IFSO4lg+lEjmMY7hXaimJ02ic0CfcP3yXVa/ip/SPzSZdjWcDxcezEOzfvQWk77kWwRv9XJZWzUSA4wmo6eMLVgtR8ihwnoxwAh8dhgdu2AO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxFfbtKxMcUQOm27FdBZQmA9nr6yRQ+j/OpdD2942Ps=;
 b=UGmSUKd36PzZy9m1m6VijFLJDOrUkhwfso20E453pgKEXfRJpHfTYguIZa8AIqwBf6NS20qB+VW5/w6YxfAWqnzHfpTXW51kmQ+W7DQ7XvHycRDJNgmmE/ZbPbAvdCpxq2AGzpdJ1ay/aS4IvoM/wPo/D0C5QMHFcWY/F0fkvIoGm8ET5UVvt5kWrN7kerq9bSB6QIlmy/sk5HqIAa/LnPYsl6ooZhsU984dJbpQwGXBKy2haywP/fzxKMOOoYG5GYZi9NZM8d2rY3O4HVPHBV9xMg94GthiZwL86BkBpdpd/qzRmjFQ/ntwZnxSro703TRO9okyapmMvvx7b7PnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxFfbtKxMcUQOm27FdBZQmA9nr6yRQ+j/OpdD2942Ps=;
 b=Lyj780KC3Ou29NuQATV7bfohffr/jkn9mqIHnwKu5X2kcKp9ZJwTOkf8bVw3HLRfcJZ13NCBE60jhh74B9/7bMW4OIUvQiKR3yaDeQ1wrsM+riJNzGpMv/iDWp9cg2vvrRnZRf17IQuQ2bwgTt9GjM9VYXo+nEUaCssVhcjSZJ0=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com (10.172.77.147) by
 CY4PR12MB1733.namprd12.prod.outlook.com (10.175.60.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.19; Mon, 12 Apr 2021 06:17:31 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe%11]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 06:17:31 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] Update mmhub/gfx error reporting
Thread-Topic: [PATCH] Update mmhub/gfx error reporting
Thread-Index: AdcvY3ApyfQ+9gqZTBe8QhOAQ5ZRjA==
Date: Mon, 12 Apr 2021 06:17:31 +0000
Message-ID: <CY4PR1201MB00724C22BA84CA74D938A3CAFB709@CY4PR1201MB0072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-12T06:17:23Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b11bd088-004b-45f7-9f62-643d485d1586;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 201eb806-a496-4381-0723-08d8fd7aa7ea
x-ms-traffictypediagnostic: CY4PR12MB1733:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1733A66CF32AB926EE18942EFB709@CY4PR12MB1733.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LyLQUviP9VnB/hXfPcjebOpUVlwzIkxAWiGovQT1MnkNj6JStSotZKc4oXRe6ZIH7j13mWVDLfShghf/58qLxkSB6zrE02o0GabVxPOxMTdZucDcHkPIn7Q+UL/p7bQ2FAPdc/9vB438qTOZidr5KdcrMLwCTBD4jRSn0zb5KC5UwH4sest1GYY6PtJtPxNVqFTx+NOmGgIo2pibkW5iP/UXyGFuaoG2Yakx/Cyc1E6xOFGnF/3IUaozOoKZHBgo+a73zGoZ7CCd48LL0BS1034AhYhdMgoAuD4wHoka6RB/LdZ1fVt+fZ9OH2np2vnp5YhYHBQdeN4jFqunFBsdldA8nqaXumbO9nB4zArV8n3l0dgsWLQBRBpqazuFr/TVk/eDykorrWYMZ/UEoEVboeY2/A9x+kKGpnM6uq6BcXnIRVElsE+cDHuDQCmgRGnBcgcLF25tAOG1Y1g8Eh+Pw2UZjx7OQDVgdkJW456Cs0agsVOxfzJkW6lM4RFxkdcckG6CarKOj1Cq5cDuWJJGs+QYY/kCm0MLkaDfr+mv2UmrXldWztFiyotMI1Q1KH1fNDdKn1YogjI0JVjJpVRn/dbgVfEROfXqLwAH2ItW+T0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(86362001)(9686003)(478600001)(7696005)(5660300002)(52536014)(558084003)(110136005)(8676002)(66556008)(186003)(76116006)(26005)(6636002)(66576008)(66946007)(6506007)(71200400001)(316002)(8936002)(2906002)(66446008)(64756008)(66476007)(33656002)(55016002)(38100700002)(99936003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?94QJcPEPCxmIwm2U5T38dIdjHFgVPT+c1YRsVPD7Pcd6uaCjAEy9EbIL4gds?=
 =?us-ascii?Q?SH+EMSfsyfyz87XQwGOG4VcaZvciPXWML55R1EIE9sbey+4qLcx1XT+z6QFc?=
 =?us-ascii?Q?5GtISkfLTsLNUpv0WKV9dhjttqufKe2G+pCVAV+l6tNueLImZJYUytNplseb?=
 =?us-ascii?Q?tSNs9xI+O2EgpWvvAKnKi8DzYJDq8pAXsnBVjpQIw+qOfTFnBa3N2MIOY3B0?=
 =?us-ascii?Q?OcQAFRYc3Bej8TXd0mnswwwSZvz3kE9FZjP4mjkjhOp7DT+7FQkOAe562uJy?=
 =?us-ascii?Q?rZMdm4bX1l+hoXPPZFbCJd85Cqjixf1f90PJvv2VnyayBpnUzsk40c4kw37I?=
 =?us-ascii?Q?9mC8ZSh3NwuRLGdR0EuFTmHjvcF6A6FEsTZ5MUodfPLXwufBgNSrv4AOi1yY?=
 =?us-ascii?Q?1ScHJOyAorFHycn6WWOTOyYiqGapJk/HDn7AU6eQdq6RkxMPlibIPmKxV788?=
 =?us-ascii?Q?6qxcqQXiwF0dN1e6UQb/4ntjaBAaAAW5LpF1Dn6A7m56FVdYmxJhSkRN/Nwj?=
 =?us-ascii?Q?ei8u1u8XNHaP9JM8idWxG8Igxu4kxmX5C52rEoTAKft+HNbVtuisDgGUTZ0J?=
 =?us-ascii?Q?WE9r5XUsorX8VNkZS4eC4PEFjf4W8OYdk9RfHhGAFWX4BUc26b/XjqFRndwA?=
 =?us-ascii?Q?kH3GWsXAfsVy/yG+gcjL2CaJLZDtnSZr5VCDdoM9WAAJAyCOOy/aE82toRzG?=
 =?us-ascii?Q?ypiYzYqbuG+KEF+R+9uhep5ejlz+x3YLwZJxGuEoLiKAMsiSv8P/Dv9PlZOV?=
 =?us-ascii?Q?KVVYb8QMfFr6r5TXYs3Nqr65nfm9JouQGSZQKxKnrgO/etl/xNS0AOgkaTZ6?=
 =?us-ascii?Q?v+s/O8zEIuDiV9+R6s2tzT7rukf0ssBvBXPH+3CGeBFCbbl7iZ1NxYYTaJ6z?=
 =?us-ascii?Q?WbUMRnD5c9HIzEq2CAADGhMGt3R7TPy1kQHVNiuE6Pr9/uLnU+U0bNm/jQ/c?=
 =?us-ascii?Q?feDF4xSNdNk7WZS9fNmx/oclyLv4wUgayVJjYR1aVd6QLhGQk6ya3XtQzHZ5?=
 =?us-ascii?Q?6NHijwKEYsIvH6A/TCIJDFTqEv7WUTdLeapmlxMxiNF4EKO0N7aKK+ddpn2W?=
 =?us-ascii?Q?fYkcTJFVqxhUsiE26T5jGLPy59FuV5h5mnnD8xaNxfA6xlPw2daGthJakTn8?=
 =?us-ascii?Q?oOQnu14QvjqylyOdfp2aYkcPrhDZyY0BKRgJLk8cSuy2OrzhtRHoaP+HwlKQ?=
 =?us-ascii?Q?V09KI7seB8VtaBdT1P24XesWQqqWIEhjP0GI67pFzJeKabcH5VZemoveWQuK?=
 =?us-ascii?Q?lwHW2toy8VOZE3bU42oikPK5I8yH18pDBU16lMboQZCJru3LDt5fUI4mB0Kc?=
 =?us-ascii?Q?mURd2TaiKp9BLZebos15Phz2?=
Content-Type: multipart/mixed;
 boundary="_005_CY4PR1201MB00724C22BA84CA74D938A3CAFB709CY4PR1201MB0072_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201eb806-a496-4381-0723-08d8fd7aa7ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 06:17:31.6595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGfJJbLzAe1ruVOeAW4o24WnOTBpbZIhLVEMlGoiPa827kB6jysc8mqv1/vU5H2f7JqNBMamDOoXUt7/ZGxQYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1733
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

--_005_CY4PR1201MB00724C22BA84CA74D938A3CAFB709CY4PR1201MB0072_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB00724C22BA84CA74D938A3CAFB709CY4PR1201MB0072_"

--_000_CY4PR1201MB00724C22BA84CA74D938A3CAFB709CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to report mmhub/gfx error status on Aldebaran only if ther=
e is an error status bit and error counter set.

--_000_CY4PR1201MB00724C22BA84CA74D938A3CAFB709CY4PR1201MB0072_
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
<p class=3D"MsoNormal">Submitting patch to report mmhub/gfx error status on=
 Aldebaran only if there is an error status bit and error counter set.<o:p>=
</o:p></p>
</div>
</body>
</html>

--_000_CY4PR1201MB00724C22BA84CA74D938A3CAFB709CY4PR1201MB0072_--

--_005_CY4PR1201MB00724C22BA84CA74D938A3CAFB709CY4PR1201MB0072_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-update-gfx-9.4.2-ras-error-reporting.patch"
Content-Description:  0001-drm-amdgpu-update-gfx-9.4.2-ras-error-reporting.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-update-gfx-9.4.2-ras-error-reporting.patch";
	size=2309; creation-date="Mon, 12 Apr 2021 06:16:00 GMT";
	modification-date="Mon, 12 Apr 2021 06:16:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNTUwZTNlZmY1NGEzNTg2ODMxODFlZWFkM2ZjMTZkZDQzY2NhNzY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IE1vbiwgMTIgQXByIDIwMjEgMTQ6MTQ6NDIgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogdXBkYXRlIGdmeCA5LjQuMiByYXMgZXJyb3IgcmVwb3J0aW5nCgpvbmx5
IG91dHB1dCByYXMgZXJyb3Igc3RhdHVzIGlmIGFuIGVycm9yIGJpdCBpcyBzZXQgb3IgZXJyb3Ig
Y291bnRlciBpcyBzZXQKClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVu
dHNAYW1kLmNvbT4KQ2hhbmdlLUlkOiBJOTg1NzY0MTMyOTZkNzA4MTljNzI2NDk5MWQ5Yzc1NzI5
ZjI0M2E5OAotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzIuYyB8IDEz
ICsrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRf
Mi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRfMi5jCmluZGV4IDljYTc2
YTNhYzM4Yy4uMDA3MGMwOTFiMmI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfNF8yLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzRfMi5jCkBAIC05OTcsOCArOTk3LDkgQEAgc3RhdGljIGludCBnZnhfdjlfNF8yX3F1ZXJ5X3V0
Y19lZGNfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkgICAgICAgYmxrLT5j
bGVhcik7CiAKIAkJCS8qIHByaW50IHRoZSBlZGMgY291bnQgKi8KLQkJCWdmeF92OV80XzJfbG9n
X3V0Y19lZGNfY291bnQoYWRldiwgYmxrLCBqLCBzZWNfY250LAotCQkJCQkJICAgICBkZWRfY250
KTsKKwkJCWlmIChzZWNfY250IHx8IGRlZF9jb3VudCkKKwkJCQlnZnhfdjlfNF8yX2xvZ191dGNf
ZWRjX2NvdW50KGFkZXYsIGJsaywgaiwgc2VjX2NudCwKKwkJCQkJCQkgICAgIGRlZF9jbnQpOwog
CQl9CiAJfQogCkBAIC0xMDk1LDcgKzEwOTYsNyBAQCBzdGF0aWMgdm9pZCBnZnhfdjlfNF8yX3F1
ZXJ5X2VhX2Vycl9zdGF0dXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQlnZnhfdjlf
NF8yX3NlbGVjdF9zZV9zaChhZGV2LCBpLCAwLCBqKTsKIAkJCXJlZ192YWx1ZSA9IFJSRUczMihT
T0MxNV9SRUdfRU5UUllfT0ZGU0VUKAogCQkJCWdmeF92OV80XzJfcmRyc3Bfc3RhdHVzX3JlZ3Mp
KTsKLQkJCWlmIChyZWdfdmFsdWUpCisJCQlpZiAoKHJlZ192YWx1ZSAmIDB4RkZGKSAhPSBHQ0VB
X0VSUl9TVEFUVVNfX1NEUF9SRFJTUF9EQVRBU1RBVFVTX01BU0spCiAJCQkJZGV2X3dhcm4oYWRl
di0+ZGV2LCAiR0NFQSBlcnIgZGV0ZWN0ZWQgYXQgaW5zdGFuY2U6ICVkLCBzdGF0dXM6IDB4JXgh
XG4iLAogCQkJCQkJaiwgcmVnX3ZhbHVlKTsKIAkJCS8qIGNsZWFyIGFmdGVyIHJlYWQgKi8KQEAg
LTExMTIsMTkgKzExMTMsMTkgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzRfMl9xdWVyeV91dGNfZXJy
X3N0YXR1cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAl1aW50MzJfdCBkYXRhOwogCiAJ
ZGF0YSA9IFJSRUczMl9TT0MxNShHQywgMCwgcmVnVVRDTDJfTUVNX0VDQ19TVEFUVVMpOwotCWlm
ICghZGF0YSkgeworCWlmIChkYXRhKSB7CiAJCWRldl93YXJuKGFkZXYtPmRldiwgIkdGWCBVVENM
MiBNZW0gRWNjIFN0YXR1czogMHgleCFcbiIsIGRhdGEpOwogCQlXUkVHMzJfU09DMTUoR0MsIDAs
IHJlZ1VUQ0wyX01FTV9FQ0NfU1RBVFVTLCAweDMpOwogCX0KIAogCWRhdGEgPSBSUkVHMzJfU09D
MTUoR0MsIDAsIHJlZ1ZNTDJfTUVNX0VDQ19TVEFUVVMpOwotCWlmICghZGF0YSkgeworCWlmIChk
YXRhKSB7CiAJCWRldl93YXJuKGFkZXYtPmRldiwgIkdGWCBWTUwyIE1lbSBFY2MgU3RhdHVzOiAw
eCV4IVxuIiwgZGF0YSk7CiAJCVdSRUczMl9TT0MxNShHQywgMCwgcmVnVk1MMl9NRU1fRUNDX1NU
QVRVUywgMHgzKTsKIAl9CiAKIAlkYXRhID0gUlJFRzMyX1NPQzE1KEdDLCAwLCByZWdWTUwyX1dB
TEtFUl9NRU1fRUNDX1NUQVRVUyk7Ci0JaWYgKCFkYXRhKSB7CisJaWYgKGRhdGEpIHsKIAkJZGV2
X3dhcm4oYWRldi0+ZGV2LCAiR0ZYIFZNTDIgV2Fsa2VyIE1lbSBFY2MgU3RhdHVzOiAweCV4IVxu
IiwgZGF0YSk7CiAJCVdSRUczMl9TT0MxNShHQywgMCwgcmVnVk1MMl9XQUxLRVJfTUVNX0VDQ19T
VEFUVVMsIDB4Myk7CiAJfQotLSAKMi4xNy4xCgo=

--_005_CY4PR1201MB00724C22BA84CA74D938A3CAFB709CY4PR1201MB0072_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-update-mmhub-1.7-ras-error-reporting.patch"
Content-Description:  0001-drm-amdgpu-update-mmhub-1.7-ras-error-reporting.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-update-mmhub-1.7-ras-error-reporting.patch";
	size=1165; creation-date="Mon, 12 Apr 2021 06:16:00 GMT";
	modification-date="Mon, 12 Apr 2021 06:16:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyYzJiNDFkOTgwNWRjODQ4YzRhOTllZTNjZTg1MzMzZTQ3NGEyMjlmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IE1vbiwgMTIgQXByIDIwMjEgMTM6NDE6NTQgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogdXBkYXRlIG1taHViIDEuNyByYXMgZXJyb3IgcmVwb3J0aW5nCgpvbmx5
IG91dHB1dCByYXMgZXJyb3Igc3RhdHVzIGlmIGFuIGVycm9yIGJpdCBpcyBzZXQKClNpZ25lZC1v
ZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KQ2hhbmdlLUlkOiBJ
YTYwOGFjNzE2ZjBlYTM5OTQ1ZjA4ZjUxYWMwOWZlNTZkMTA4OGQwNAotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21taHViX3YxXzcuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L21taHViX3YxXzcuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHVi
X3YxXzcuYwppbmRleCBkMGY0MTM0NmVhMGMuLjhmYjRiNGZmYzNkMiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfNy5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21taHViX3YxXzcuYwpAQCAtMTMwNiw3ICsxMzA2LDcgQEAgc3RhdGljIHZv
aWQgbW1odWJfdjFfN19xdWVyeV9yYXNfZXJyb3Jfc3RhdHVzKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKG1taHViX3YxXzdfZXJyX3N0YXR1
c19yZWdzKTsgaSsrKSB7CiAJCXJlZ192YWx1ZSA9CiAJCQlSUkVHMzIoU09DMTVfUkVHX0VOVFJZ
X09GRlNFVChtbWh1Yl92MV83X2Vycl9zdGF0dXNfcmVnc1tpXSkpOwotCQlpZiAocmVnX3ZhbHVl
KQorCQlpZiAoKHJlZ192YWx1ZSAmIDB4RkZGKSAhPSBNTUVBMF9FUlJfU1RBVFVTX19TRFBfUkRS
U1BfREFUQVNUQVRVU19NQVNLKQogCQkJZGV2X3dhcm4oYWRldi0+ZGV2LCAiTU1IVUIgRUEgZXJy
IGRldGVjdGVkIGF0IGluc3RhbmNlOiAlZCwgc3RhdHVzOiAweCV4IVxuIiwKIAkJCQkJaSwgcmVn
X3ZhbHVlKTsKIAl9Ci0tIAoyLjE3LjEKCg==

--_005_CY4PR1201MB00724C22BA84CA74D938A3CAFB709CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_005_CY4PR1201MB00724C22BA84CA74D938A3CAFB709CY4PR1201MB0072_--
