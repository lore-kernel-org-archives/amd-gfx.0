Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE7EC43460
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CB161422
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 07:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CB161422
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660506E957;
	Wed, 21 Apr 2021 07:00:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E92E6E957
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 07:00:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bi3Omy4U7zbn0LDYluk8GRSU9oIJvIiyPfQRgYl/GGV8AwSNh0v0ra0pjb5Jfa1qQBPdr8jukrnVZdZJJm/ipIP4Jg/1SJC23exTEBCRESL0CMY9gMaIHYx3WTQrrsMATeEqT7jLVIXM27YB1sq8Lj081/yyoYd3BtRb+7CyicjoVgZONAh0sJqL3/WfonN82GnlhqVNGShDDE74kSev2J4SjhKtak9tdHl/85s3PXoarIsxj1OPkuHmzJG14PxSqmntxLw5vcOazLmiz07DL6nbpAL4aqXXZd700tafFTu8XB1g+OGv+VeIN4DWCrR5NI1551ZsHzYXV/dMWpB0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T69aua+ksqtELHuBbUEI4PUat0hbNvIifzUrQ/Qqk8=;
 b=Z9oBU72z3HZDEU5maG2sLOKHaLHdNyCfFM4o/Nwq0YT2L6MyARy4JrxszrRHVPRKG2lgc3c2r7GBwwDOvY2f5/HP8TIy6kY2DHcsZmPOoGrv9JIJVkENiyT+2vx2QWWyOsOY2YurXLgEtTAXHPTz1ANuZEKuIMgfI5v4FxYcy5C/xZf5+kReJi8hZyeGHYnJK93whh5ihY1ecrJDnSC3YEboFee6cLK+k6EDVg24T5tom4DsPf1SfLpImhKHvhofVz3WuSIEKYx9NziRO3rrQQdRiAeKHlBi+W0kLegyhgAZm0LPDljU07aGKhpwe/zmzwfo1MPt8O6a0QQ1Nr+0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T69aua+ksqtELHuBbUEI4PUat0hbNvIifzUrQ/Qqk8=;
 b=QYHd2FVsfUYkoI3DtnsO58Zzd1Q2TQe/HBvA9fXoMGelabX554tmpE9AvnlgzsNDzV7431jjHP/gJ1CkWQCBV32YD7jSx0cgKFg1Sx00ZVPwiLra2e+t7f+svrzLH3rOEPyCT4NR5Jjx+HcHhqWzFHaPrEftDzK2LhOb7rClAxg=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR12MB1637.namprd12.prod.outlook.com
 (2603:10b6:910:d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 07:00:14 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe%11]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 07:00:14 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolve ras print bug
Thread-Topic: [PATCH] drm/amdgpu: resolve ras print bug
Thread-Index: Adc2e04e1YXxg/BBTdGWYHHrcPYEiAAAKGLw
Date: Wed, 21 Apr 2021 07:00:14 +0000
Message-ID: <CY4PR1201MB007296108AC74F9A2D52B2C5FB479@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <CY4PR1201MB0072579CCC7ED34A57536F6FFB479@CY4PR1201MB0072.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB0072579CCC7ED34A57536F6FFB479@CY4PR1201MB0072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-21T07:00:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=dc26c395-51ff-4a47-86dc-be472f66b338;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b93784b5-f36c-4bbd-38a2-08d904931d5b
x-ms-traffictypediagnostic: CY4PR12MB1637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB16374853339DB35432BAE168FB479@CY4PR12MB1637.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o1twklMBRxCspRIw6SGXr6OEvF6Qjz5wU9a54zrxBCEf8IWoNL3cjbpluybsBFls4FRFRaprdqnKdir1UO/WPmNVMFZ8+jgBw+jijdm3URtSSBOKotOIoMKR/R9XMhs2naK1xhPqios/6WRFTCU8bo117mAPiY3G+BDFziE/wXcG/lNteplqhTRUuYrx7Ns7fIXRusaljsrij2uujIq0ZWflyC78fecERrlEwrKPKSCQ/pd9b2CgLOCmXKWOpW17SuHE55SWlPgWvFsOvduxCraIJXEb0nl/ttZlUbBh+fuzBgBKXQq5SklH8Hx9JnuN71QSKWVVCqi60AtBTcXOce1fPOw4utIqGjY7smBTR3uYqP/OcnHr9lShAZOYwQyeTnvzXimqHdiRIr9iKYNHGXxuSby4TNwHnsrpDSPiBBc7SFOiyPLWAcqPF+STeSCX2x1V079KNN0O3ykLMRCrTYVRTUlOsVk1Ap7kjK4TeEjdLYu/szWGGKN0GAI5oDqzZcWVlkezzsna06e8864gWm+3fmoa9npjA9Gv3NSepJRojZubwJKrfrjVltWU2EDnubgM3p+m4MgXiNCt3VUK7uWweeQbhuvw25wuFTvwzjs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(6636002)(26005)(86362001)(316002)(5660300002)(9686003)(8676002)(8936002)(6506007)(7696005)(478600001)(2940100002)(55016002)(52536014)(71200400001)(110136005)(122000001)(53546011)(4744005)(66476007)(66556008)(64756008)(66946007)(76116006)(66446008)(33656002)(186003)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CvWss8m7td0JBQZa/Q++2rgPvtm5rDh0YExswkZKsDkxnyohOpUGxR0XyK0A?=
 =?us-ascii?Q?tMYwTGvRs6NFdM7tGbvNIrCXqaVLfAj0c1fPrepyxbuM9zyqcIYECOF1gkkn?=
 =?us-ascii?Q?tKn7/j/9PSPn1Fc6PW5FWbKOKTAUjxV4UeF6ekFPyfSXAcbnCtZqeI9b3H6l?=
 =?us-ascii?Q?xH3jt+A1SVtR0LHPjpkV6YKT8L/NXl+QK+ZAOhy5MiK+ykyq1nbGn4J5IuX6?=
 =?us-ascii?Q?OgPfvCiDMrnxNV+bjP5OfRmX+mTRTabjIpGTDFsft4TogQ8Zh99govj/wYwe?=
 =?us-ascii?Q?5EUUd3h5n4oYC/cqka7m90FdA8qOXuZf9QSbWoYwBLPdL6/Rt6BlZW0jbi6S?=
 =?us-ascii?Q?SekjCXHS9+/ILMihsA4Ob1ScciyzIne7OkhMA4XnUTXL32lk+m5CjfFqr4D3?=
 =?us-ascii?Q?fPoU2ROlimttyTifhCV8dOZQeiZMGLFOyDasreOZMINX9ssr4oJjI/5zbIc1?=
 =?us-ascii?Q?72B1Kc6qOE61y0DKxc5eHSHKtK9e0ubznR3PJ0JKeMPwjgvd6W19okI/mohz?=
 =?us-ascii?Q?zwThPgD0aVCdBWU06eLzSosiYOiq4IENep7QFkolVe8qYNlwGZgNXjF2ow66?=
 =?us-ascii?Q?WcHnXMum42oPSDIy16Q3lWEEII46uLqXV+kA3WgSBaBLHF5oNvtIoBQBses0?=
 =?us-ascii?Q?M8J4XsCQi2jUSo+vwttQZjZiCy7q1U8I6pE+6yMuL09XrzRfC8piWn/ZnQHJ?=
 =?us-ascii?Q?M40yLodeCY/4b7vh6bgkdcoac647mDIAHJqC8KLMOQmv3M3nBdn8qqG18Rf6?=
 =?us-ascii?Q?bAtRpW3SNolrvgt9dlFk6qXX/z1y2Y67NMvTpOgbZZJgtm9e8MG9aZNS+JSP?=
 =?us-ascii?Q?+FgPrS6ouZiJE+4hcsXoVOZZqFAT4r9OHxEIaUbVWnm4XbsCYcoAXgui98LZ?=
 =?us-ascii?Q?KRRjQaSJ4K8CEqapmocKfT7yq6ttKsTmXhyFR3eSFunIcjcrqq8cSHUa50gX?=
 =?us-ascii?Q?zcXq74Usj3qlP8469c5JJKKXHyiSIIfAzdd5vXM8Bx07AXH6+KM9Nm84Bh+f?=
 =?us-ascii?Q?vh7yGl6JcolBWR8LGo1kERROBidi5bhJoxKuxj9AiTpxRbC8gjNIkmA5E8XD?=
 =?us-ascii?Q?vMb64nfvg9Iw40pBLs+SQ/lPGHc+LEvxOQgC7Y5KM8vlhFs0XFoKZ/4xMD97?=
 =?us-ascii?Q?8EIVwmrQAOMSLvr3AP3zk7SwZde5JDqj1svCCrpeHjT7RFKwnoultzn4Mmkn?=
 =?us-ascii?Q?+4KhBMknwPRc/ESWfStt4QW61ikgl0NSzS7Vtnv8fUSppAgVXESMUkgxvSpv?=
 =?us-ascii?Q?0O6b6V0K3iGpgPiGiw/M7oSeyQGcLiIdJ0/JKA/rDki/4Ak5u84vn3uMqlb/?=
 =?us-ascii?Q?UCH5Lw42SU90u91y0ZPadday?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93784b5-f36c-4bbd-38a2-08d904931d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 07:00:14.7167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sb6ham1pkxIPd0kerNX2o92ooq8Me4OHhPcMdZULwbDb/oxlTbvu8wKSV06sdob2qItKHdf4unOvdbmTWEcF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1637
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
Content-Type: multipart/mixed; boundary="===============1866465387=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1866465387==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB007296108AC74F9A2D52B2C5FB479CY4PR1201MB0072_"

--_000_CY4PR1201MB007296108AC74F9A2D52B2C5FB479CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Please ignore this patch , it has a problem

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Clements=
, John
Sent: Wednesday, April 21, 2021 2:56 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resolve ras print bug


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to resolve RAS related dmesg print issue

--_000_CY4PR1201MB007296108AC74F9A2D52B2C5FB479CY4PR1201MB0072_
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
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please ignore this patch , it has a problem<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Wednesday, April 21, 2021 2:56 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve ras print bug<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to resolve RAS related dmesg print =
issue<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR1201MB007296108AC74F9A2D52B2C5FB479CY4PR1201MB0072_--

--===============1866465387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1866465387==--
