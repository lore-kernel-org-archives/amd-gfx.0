Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58C6C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 08:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6983E61002
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 08:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6983E61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F646E462;
	Fri,  9 Apr 2021 08:18:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F916E4BB
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 08:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZroKRNFd+PP+N/emZR/NB5dzQDFdygHHiBJySz8MUV1hLvgeLmbwli0m/shsXEAUmNNd4WzuvnEdQy9LFVx3CqJfUsM0C6+5CjrQukoQQRmKh2siPpXf7pKNTsLudRTUhq6rkYsv7s/26RSqh6gaBQCUB/WBLtFDHn5zihj7Rf08561dfIRB+ALNlcySNeftMBiYtcyeEikYoJxJMgANddaghw73Bj3wGur4ysJRT++XumXu4bjZ+ijzuaEeRiphVyU99jwXR5F+q6IWCoSV/PuRFO52XgA/kw+getElCkWXpXDgEP4ZeUb9d/ruD4taC2W4zxNJmzgBVx7fkNPhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmXSxXIBktyjKiSvAfpFVHMjtVcP+GHp7KkSsBXMLkc=;
 b=UrCJSV2ModIIFHMJuO9dlM1hVherFeBMPGJ8s5keBWfWHQQyRkqFdaSXiq1B+lZepADo9fWIIH3T6fkxK6OC5TrdUi1CXmtZ6aXyaYBN1RkljQ78oIXN0cHeb9s76u9u/DV7BVDKjkiQlh5y+HAaOK/HpMw+dQbpK59pC5YueJjf/Iq6Ch6k9vzM7/eFfKSaz1/7ZrmC45EM/z3GMW6S04ouSfXi1i2XUjjToVB9gCq61IuMadlnS+FhcsUBcQet10cYJGj+sqo7tz08YQRJ26w+JhU1LkTpYxjZgVZU7sZetLsY/z78nUYfXhEVD7cN8kHM4Ei6eo1COFs1sE26QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmXSxXIBktyjKiSvAfpFVHMjtVcP+GHp7KkSsBXMLkc=;
 b=I35glPxV+uJFFMVubH9ORApMkORM3J/UezYQzHsAQRmE6CHn1eycMjRL09g28rmIP807YJHJz8q/NOJrVP5LekT/GW5gKSPNG7ur+cQ0AyXBsNgo2r2n240bIpw+4lgpLZbYuKAQcZims+dYinMLwmKtu5I1f6jEyRK6EOIRdx4=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR12MB1638.namprd12.prod.outlook.com
 (2603:10b6:910:10::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 08:18:47 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe%11]) with mapi id 15.20.4020.020; Fri, 9 Apr 2021
 08:18:47 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: page retire over sysfs mechanism
Thread-Topic: [PATCH] drm/amdgpu: page retire over sysfs mechanism
Thread-Index: AdctGNh9xzYbt45bQVGtgDOImVY55Q==
Date: Fri, 9 Apr 2021 08:18:47 +0000
Message-ID: <CY4PR1201MB0072B485CD6BE311CBBD72BEFB739@CY4PR1201MB0072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-09T08:18:36Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=21c9c8ab-b189-4588-b8c3-8a5e7c0f4070;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a61e75f2-44c7-4b95-5fb7-08d8fb301988
x-ms-traffictypediagnostic: CY4PR12MB1638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1638A2D502346F7A6F7C06E1FB739@CY4PR12MB1638.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FOf7MFP31XY62GGx+nJJ0xz8dyMESApwQhU5mQQrQ4ferEeaUYTTjAwWBx6Q2IAaev35wh7V/dxC+/CNCaX76idoR4lVY03twbNABRmPTQSNiLPDSQ+3uOoSRnfpe7CjfIrqh87YG4BmGI+DNtGbpMOyfYRNG+gNnsOPMi/dFRSZBVpJyQJcLsGIuv/j/B9cT3AX43doZ/aIDZwxpOi1X9aZ3NG5CullUOSZB14Dp2fc8hbOAi7qNZQDmtJGe3NmVyj7XRuRNSNaCHy068PZm/MYGeP8gZu7urBWFXmVw/50eltmDMnh5lC7sGqD2X+59Tfeyz7phqL1tK0EZq/7OoNMEFvU6yo3xTsP+X+hsv4YoFNolpBUC6XurcU2NpmdpfgBhLVL6eZuPY5T5pNACHpICIw2/ctqX4sLv0lAEHHaJ6fwWgh0sU8lafX7OqauqP6CRHiWN/7pfELoRlIYlteGosSlTLc9bwIkaXyQc8BBlw570ZQlgOKFqe0TXGCAzDkX3HPqmJqeOqtmSKXpaUBFQSPjbUSXyeBtFqlXec3kzu12lDoeSwTmYwuQbTv7PoW+cHeKBd/Rd85bD9PQ3jmrdctm4xYbRq6L+1dnFHrHo7IkSbSFBIjGonAkvzAucZ/ruuvAktyl3HpHJ4lHRetfMNDVwTNjczrRNXPnR5Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(110136005)(66556008)(478600001)(5660300002)(52536014)(76116006)(66616009)(7696005)(558084003)(26005)(8936002)(71200400001)(86362001)(64756008)(6636002)(33656002)(99936003)(66476007)(66446008)(8676002)(6506007)(38100700001)(186003)(9686003)(66946007)(55016002)(2906002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xTsmLXz5JEm0tNKmEJ6FdDTngsIx4/vewzKlfi4HqJ6FpLzU6OA2qsBC9XDg?=
 =?us-ascii?Q?L52+WNIEi7V+L7z82My8nF41G/FTku44OFnVR9A8wXxyHuYgx12WRaeJhEVL?=
 =?us-ascii?Q?d2s2QEf5nbaklsHROzCyhPbkAB9awzZQ8LM8VGO6dKxt45QmxwFkmb+zuEqE?=
 =?us-ascii?Q?+BVM7IOkIkSmTfYmSdi44+edlraiLIJpdIQgdF74puhALz+AtvMT0glz8VtV?=
 =?us-ascii?Q?XySwoeGewi/IAcnfWi/0xjQE7R3k5i8iXrkoa9R9/IrTeu/pFnt5FjFW3FZW?=
 =?us-ascii?Q?oh/dmhmaBGFshBvMJG2+RuutZK2epHpRVATo/mBAt1WovQD4gO85c8pmb3Rt?=
 =?us-ascii?Q?3X6L6s87UBJs99B6B/FDAV/jCOU7o33IHxhlzLGJhkqzmeAkdgJmrqUUw15h?=
 =?us-ascii?Q?G18XZu21tFrmYWjsq/wIwDDRjHF5YBcNKj5eewOMOP0RHzfdn04msi7jak/T?=
 =?us-ascii?Q?xa/NvFBGJkqZOAB1c2jhl9K2sTTsi2LN3JORq8csesnanA7f/5G0Jvp0AdEL?=
 =?us-ascii?Q?Y/pwszaO8Jjsci0nm7u8fXTNB0x0trxyZgQ4HeyNFdEwj4HjKkrhAzPnde1r?=
 =?us-ascii?Q?h6B0s5HOlGpRPQrF6j9CBrEbQedBq4hvurR+K+VL6XBaDRuZUIgyIYSZb349?=
 =?us-ascii?Q?bNaTGKTwXI1+U2ITKopul5RyxGPlK+6QLiPPPIjFOtUO4Lup4vDrnL6r8aAG?=
 =?us-ascii?Q?gQD6v8LrvC4npoysFHTdliWzAbUtHXuruW11WNKMdg13V+xzyLZvcJGl3BU3?=
 =?us-ascii?Q?N3deVq3eyk+ysn4b6AhxTfvz6PpeeS2cklG1c2TEUBM0ByWJjlcsXtgMpNv1?=
 =?us-ascii?Q?Shyrb9AisCASKJuWDezy0JXfVUoz3rWw1NKNSPVOOE5FFidjylvdK76MSi25?=
 =?us-ascii?Q?h7vK9yw49yZ1w2+LRq2woQ+1+vXGAZcYwPp90Ced6mNdE5Mv9kPE5gvkRJw0?=
 =?us-ascii?Q?m0FcAlT0njwLhMJC0tCCEyBBKn7/QzPDHOdwLZvyO/Rsitg6DeGZTpgyxjBG?=
 =?us-ascii?Q?yAXYkM2iP0WGZuwn0w+fKBtPoF6t/M2inAvyg7a++HdSEVOuaoJ41LHEAm6+?=
 =?us-ascii?Q?4IrHstKh3JxMtZlGS2UQqBtIMCDJBFmN3r/LFuA76wBy/+w5Q9a9KWJ41ikm?=
 =?us-ascii?Q?nwrUAGcmsY09sSrcEQfuiXSoq1ZGS1jzr/wvORddmzlirxZ8Fd2CDE+VNlka?=
 =?us-ascii?Q?FZRGLmENnTPM/b212ajgzdAQBt26LhPpZna1saWGdgzV45EDiJMOjuePX8or?=
 =?us-ascii?Q?GCPhSkvGptjLij8dJhAo7qpB3cGjUGiabdmPDLxwagXRzqbwIsJ+R+LF+/gn?=
 =?us-ascii?Q?bWftbEsKP1hS2XEuPo44F40X?=
Content-Type: multipart/mixed;
 boundary="_004_CY4PR1201MB0072B485CD6BE311CBBD72BEFB739CY4PR1201MB0072_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61e75f2-44c7-4b95-5fb7-08d8fb301988
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 08:18:47.6435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPXow0gSC7g3itG9oi8bsaRT8hsb9gjbpeS2gzRmUD3LWaiW994hyeKpx6o2WE+hWjoI+mqJP0V2dc8maBTVxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1638
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

--_004_CY4PR1201MB0072B485CD6BE311CBBD72BEFB739CY4PR1201MB0072_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB0072B485CD6BE311CBBD72BEFB739CY4PR1201MB0072_"

--_000_CY4PR1201MB0072B485CD6BE311CBBD72BEFB739CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to unit test page retirement feature via ras sysfs interfa=
ce

--_000_CY4PR1201MB0072B485CD6BE311CBBD72BEFB739CY4PR1201MB0072_
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
<p class=3D"MsoNormal">Submitting patch to unit test page retirement featur=
e via ras sysfs interface<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR1201MB0072B485CD6BE311CBBD72BEFB739CY4PR1201MB0072_--

--_004_CY4PR1201MB0072B485CD6BE311CBBD72BEFB739CY4PR1201MB0072_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-page-retire-over-sysfs-mechanism.patch"
Content-Description: 0001-drm-amdgpu-page-retire-over-sysfs-mechanism.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-page-retire-over-sysfs-mechanism.patch"; size=2987;
	creation-date="Fri, 09 Apr 2021 08:17:00 GMT";
	modification-date="Fri, 09 Apr 2021 08:17:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MzIzYjc4Y2FiYzM0YTM4NmI5ZDM4ZGZhZjg3MjlhYzM2YTg0MmM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgOSBBcHIgMjAyMSAxNjoxNTo1NyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8x
XSBkcm0vYW1kZ3B1OiBwYWdlIHJldGlyZSBvdmVyIHN5c2ZzIG1lY2hhbmlzbQoKYWRkZWQgc3Vw
cG9ydCBpbiBSQVMgc3lzZnMgdG8gYWRkIGJhZCBwYWdlIGZvciBpc29sYXRlZCBwYWdlIHJldGly
ZW1lbnQgdGVzdGluZwoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50
c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEkxMTQ2ZjViMjJiNGFmZjVmYjM1YjczNWRiMTliNTRmODhk
NWUwNDJiCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNTMg
KysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKaW5kZXggYjBmZTU4ODVl
NGM2Li4yY2M5OWM4OGJhZTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFz
LmMKQEAgLTk5LDYgKzk5LDQ1IEBAIHN0YXRpYyBib29sIGFtZGdwdV9yYXNfZ2V0X2Vycm9yX3F1
ZXJ5X3JlYWR5KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXJldHVybiBmYWxzZTsKIH0K
IAorc3RhdGljIGludCBhbWRncHVfcmVzZXJ2ZV9wYWdlX2RpcmVjdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgdWludDY0X3QgYWRkcmVzcykKK3sKKwlzdHJ1Y3QgcmFzX2Vycl9kYXRhIGVy
cl9kYXRhID0gezAsIDAsIDAsIE5VTEx9OworCXN0cnVjdCBlZXByb21fdGFibGVfcmVjb3JkIGVy
cl9yZWM7CisKKwlpZiAoKGFkZHJlc3MgPj0gYWRldi0+Z21jLm1jX3ZyYW1fc2l6ZSkgfHwKKwkg
ICAgKGFkZHJlc3MgPj0gUkFTX1VNQ19JTkpFQ1RfQUREUl9MSU1JVCkpIHsKKwkJZGV2X3dhcm4o
YWRldi0+ZGV2LAorCQkgICAgICAgICAiUkFTIFdBUk46IGlucHV0IGFkZHJlc3MgMHglbGx4IGlz
IGludmFsaWQuXG4iLAorCQkgICAgICAgICBhZGRyZXNzKTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJ
fQorCisJaWYgKGFtZGdwdV9yYXNfY2hlY2tfYmFkX3BhZ2UoYWRldiwgYWRkcmVzcykpIHsKKwkJ
ZGV2X3dhcm4oYWRldi0+ZGV2LAorCQkJICJSQVMgV0FSTjogMHglbGx4IGhhcyBiZWVuIG1hcmtl
ZCBhcyBiYWQgcGFnZSFcbiIsCisJCQkgYWRkcmVzcyk7CisJCXJldHVybiAwOworCX0KKworCW1l
bXNldCgmZXJyX3JlYywgMHgwLCBzaXplb2Yoc3RydWN0IGVlcHJvbV90YWJsZV9yZWNvcmQpKTsK
KworCWVycl9yZWMuYWRkcmVzcyA9IGFkZHJlc3M7CisJZXJyX3JlYy5yZXRpcmVkX3BhZ2UgPSBh
ZGRyZXNzID4+IEFNREdQVV9HUFVfUEFHRV9TSElGVDsKKwllcnJfcmVjLnRzID0gKHVpbnQ2NF90
KWt0aW1lX2dldF9yZWFsX3NlY29uZHMoKTsKKwllcnJfcmVjLmVycl90eXBlID0gQU1ER1BVX1JB
U19FRVBST01fRVJSX05PTl9SRUNPVkVSQUJMRTsKKworCWVycl9kYXRhLmVycl9hZGRyID0gJmVy
cl9yZWM7CisJZXJyX2RhdGEuZXJyX2FkZHJfY250ID0gMTsKKworCWlmIChhbWRncHVfYmFkX3Bh
Z2VfdGhyZXNob2xkICE9IDApIHsKKwkJYW1kZ3B1X3Jhc19hZGRfYmFkX3BhZ2VzKGFkZXYsIGVy
cl9kYXRhLmVycl9hZGRyLAorCQkJCQkgZXJyX2RhdGEuZXJyX2FkZHJfY250KTsKKwkJYW1kZ3B1
X3Jhc19zYXZlX2JhZF9wYWdlcyhhZGV2KTsKKwl9CisKKwlyZXR1cm4gMDsKK30KKwogc3RhdGlj
IHNzaXplX3QgYW1kZ3B1X3Jhc19kZWJ1Z2ZzX3JlYWQoc3RydWN0IGZpbGUgKmYsIGNoYXIgX191
c2VyICpidWYsCiAJCQkJCXNpemVfdCBzaXplLCBsb2ZmX3QgKnBvcykKIHsKQEAgLTE3OCwxMSAr
MjE3LDIyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19kZWJ1Z2ZzX2N0cmxfcGFyc2VfZGF0YShz
dHJ1Y3QgZmlsZSAqZiwKIAkJb3AgPSAxOwogCWVsc2UgaWYgKHNzY2FuZihzdHIsICJpbmplY3Qg
JTMycyAlOHMiLCBibG9ja19uYW1lLCBlcnIpID09IDIpCiAJCW9wID0gMjsKKwllbHNlIGlmIChz
c2NhbmYoc3RyLCAicmV0aXJlX3BhZ2UiKSA9PSAwKQorCQlvcCA9IDM7CiAJZWxzZSBpZiAoc3Ry
WzBdICYmIHN0clsxXSAmJiBzdHJbMl0gJiYgc3RyWzNdKQogCQkvKiBhc2NpaSBzdHJpbmcsIGJ1
dCBjb21tYW5kcyBhcmUgbm90IG1hdGNoZWQuICovCiAJCXJldHVybiAtRUlOVkFMOwogCiAJaWYg
KG9wICE9IC0xKSB7CisKKwkJaWYgKG9wID09IDMpIHsKKwkJCWlmIChzc2NhbmYoc3RyLCAiJSpz
ICVsbHUiLCAmYWRkcmVzcykgIT0gMSkKKwkJCQlpZiAoc3NjYW5mKHN0ciwgIiUqcyAweCVsbHgi
LCAmYWRkcmVzcykgIT0gMSkKKwkJCQkJcmV0dXJuIC1FSU5WQUw7CisKKwkJCWRhdGEtPmluamVj
dC5hZGRyZXNzID0gYWRkcmVzczsKKwkJfQorCiAJCWlmIChhbWRncHVfcmFzX2ZpbmRfYmxvY2tf
aWRfYnlfbmFtZShibG9ja19uYW1lLCAmYmxvY2tfaWQpKQogCQkJcmV0dXJuIC1FSU5WQUw7CiAK
QEAgLTMxMCw2ICszNjAsOSBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfcmFzX2RlYnVnZnNfY3Ry
bF93cml0ZShzdHJ1Y3QgZmlsZSAqZiwgY29uc3QgY2hhciBfX3VzZXIgKgogCWlmIChyZXQpCiAJ
CXJldHVybiAtRUlOVkFMOwogCisJaWYgKGRhdGEub3AgPT0gMykKKwkJcmV0dXJuIGFtZGdwdV9y
ZXNlcnZlX3BhZ2VfZGlyZWN0KGFkZXYsIGRhdGEuaW5qZWN0LmFkZHJlc3MpOworCiAJaWYgKCFh
bWRncHVfcmFzX2lzX3N1cHBvcnRlZChhZGV2LCBkYXRhLmhlYWQuYmxvY2spKQogCQlyZXR1cm4g
LUVJTlZBTDsKIAotLSAKMi4xNy4xCgo=

--_004_CY4PR1201MB0072B485CD6BE311CBBD72BEFB739CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_CY4PR1201MB0072B485CD6BE311CBBD72BEFB739CY4PR1201MB0072_--
