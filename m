Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F2AC38A2A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 06:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B00020870
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 06:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KGCgIhrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B00020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068576EA84;
	Fri,  8 May 2020 06:50:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96D86EA84
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2020 06:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM4AJO3rja6XadK6L429x/fUm0N/5fpGW2upPsPyY98RmfYBcfXl9gRzhuQU/73AgqG33ovYuUKiCSGj+IUuPdxpoE8DX4A6JtlHYxUpI7u/+bOQretVTtnacUnzdBiP1I1htSdRmGtti1v3BWZ5PxtxqyF29WSoe7Gpijg3AuHqmV+0Q3lhAZ2W2rk2iuI9MStzz9w+axdEqs0mwT7QReAt1/ulpOP+xRRF62uAGn2CjPIm0GLeAewl4ZDRGbQDGR01V/CDliVax4MS37ymuqJ9PRDdBOrkXL6wmFUzs5WWZKt70vHrXSfhWTXcQGBlayDlyZ1UF6o2uqhGYJglVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrPuDioqJglU0/gDY19bi2oA3l3qnHSyNLLsC0UeBps=;
 b=HFcx3w2q2cgASfeIqWPCr8bis3vvk++Z4MMBdMgtbozWLoGP39XzsD8mjepaj9sZWbj8hmmzPyD/nBIjj94FMkwzVelgB+bs76dP/9SVJj1OMNM7CxpI34mUJwSExGDTia9+P2gjW/ELvkl6bwwTdi1fcHWwm119VXOukXyQBxgHMe8mEEWvcFKqDOJsRAIOYlRKbGN5e+gxyZEocUpRpTtja8rNk907/kmN3/gQViLk7tBI3/zdgPcbJEk3dwyzdQ4P1GGoBx9hCkeuyI6ha0BTyX53ViQ5v5V4OvlN51vys7EVFfI8fybTntUmFi2wNQr98WSrye4obSEn9pTskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrPuDioqJglU0/gDY19bi2oA3l3qnHSyNLLsC0UeBps=;
 b=KGCgIhrYVBdGLhGPiY3ljammz0WadctNqaVA9ehBodenBV9KSUzy7gK0FquTHTIliApPuOotrME4uxc+Z76jRkSjM+4/PAwzBpGA+pPVv0xcM2l7L86CPMV9uAWtKmPR7YhqqHDf9QCmGyZ/WXM94SUvhAZlN9WqtEpc3YhEpX8=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Fri, 8 May
 2020 06:50:51 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8%7]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 06:50:51 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] Series to disallow XGMI link power down during RAS XGMI error
 injection   
Thread-Topic: [PATCH] Series to disallow XGMI link power down during RAS XGMI
 error injection   
Thread-Index: AdYlBM1jbW95+O6gQgCVQiz75SiPwQ==
Date: Fri, 8 May 2020 06:50:51 +0000
Message-ID: <MN2PR12MB4032BA32212F2A8948471950FBA20@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-08T06:50:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=350d25b8-c3a3-4952-bf4d-0000925180f4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-08T06:50:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: fd1cf80d-cb55-4f95-9884-00007eb94218
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2646ad34-50a4-4824-df21-08d7f31c25fa
x-ms-traffictypediagnostic: MN2PR12MB4520:|MN2PR12MB4520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45200791B20589B253171C63FBA20@MN2PR12MB4520.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q3lCTxu7tSUMQ0CQicI8S6uc4v+fbjsga9zkQ6tf3Q0iUiWrnlWp+3s/PZimnMWgxFmEj6DyKkzYag6J5lYdI9mOJwJqAR9gMq49VqMO8ADKq0NuRXIIabmMfs9VUHonwFpBf8Wd3nP53RkiRDvr3tra5cQaMcHIWNq82Skr/YcOCL8RfkAsK7Uw4i0+soP2e8iohD7Lc5WIZlYISM72xe43QeWwiEHAkQXCCVUS5YSk/tNDVAWIYi67y8Im0Bn2YelXrkpsOfMFwV6qAQLDARqNmSnHWxem1URDpsGMKeWq839Hi7IyCiobngYfKp7f1ict2ZZ1RHrwe6fdxgo8I+c3PjFnLSAEDXiaDchzScLQqrNETPeWOX9OorOw/bL5yDqLOvn9ff+jFZsGIJBjth3hpo7hWYuCbuUDx+z+8k/vumxp5k//cSpqdBjv4Ia1Jc0KtvZ/VVeVeJAjfkLntNzBKrRieIHSjm143yaXeKNl9UDczNjyR0eYULP1fv3IfBu9umsWpi9qMNqew2htcQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(33430700001)(316002)(2906002)(52536014)(83310400001)(8936002)(66446008)(64756008)(66556008)(66476007)(66946007)(66576008)(6636002)(99936003)(33656002)(558084003)(76116006)(33440700001)(83320400001)(83280400001)(83290400001)(83300400001)(55016002)(7696005)(9686003)(5660300002)(478600001)(8676002)(110136005)(86362001)(26005)(186003)(71200400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ovxnqAm1h9Wwjd7Fiu6U+YdI7C8ovgfdFh/gJEAOm389Wp8KjmWS61pT/K2GYbs53iegh7EIAI8w4mO3EtW7mf/1Lmgud7yT41ZpD03zdUaNiJ3wg87SEyGMf0CC7JZ+GMhjBjuPvo3MB8/yIfx80qp2yky6Gg+4OpJtQ7/OuNo4m+pqNTSLbQ7FVtcVj4omsFPjPuIhiLW9SDdzLX2EMCnfpkdqNNiEh6XJthUz4QQzKnQV4Ngolv+GqYYW97i0USw2zYGECKC4kLcI/sz9ePAFLqFMwP8PgZjZoVFHagDcYKEE3RUR4ZbdLKh6Mr3VxqmMCqp5wS1pRPipxY8UeWncikPODHsCtPxU/39tU0bNt6nQl6bxuDZSfy4MhYnbi/exHmU+ZN01GDSi9B8m9ZljUZhCXoyxVOIsGlz5KJohKGDG/ca1lUrGYoC8jmVx28VhBzn+0GyoiZJ2oyha+8YB+OxUVEAtAFw9FRn+78RgEcrQk4dbm3GC7x34fvHP
Content-Type: multipart/mixed;
 boundary="_006_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2646ad34-50a4-4824-df21-08d7f31c25fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 06:50:51.6897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gc5BfkfgM5jFkUlYi7jcn2bk15myxoH857mnj9ua1eUcnizqZeURFemjDy5z00KJG9CKHhRv9EKcW3OuiQ6IEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
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

--_006_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_"

--_000_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting 3 patches for review:

  *   Added host to SMU FW cmd to enable/disable XGMI link power down
  *   Added DPM function for XGMI link power down control
  *   Disable XGMI link power down prior to issuing a XGMI RAS error

--_000_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
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
/* List Definitions */
@list l0
	{mso-list-id:381831772;
	mso-list-type:hybrid;
	mso-list-template-ids:-1337145758 -291890196 67698691 67698693 67698689 67=
698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:DengXian;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-bidi-font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;
	mso-bidi-font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-bidi-font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;
	mso-bidi-font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-bidi-font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p class=3D"msipheadera92e061b" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting 3 patches for review:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Added host to SMU FW cmd to enable/disable XGMI link power down<o:p><=
/o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:=
l0 level1 lfo1">Added DPM function for XGMI link power down control<o:p></o=
:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0=
 level1 lfo1">Disable XGMI link power down prior to issuing a XGMI RAS erro=
r<o:p></o:p></li></ul>
</div>
</body>
</html>

--_000_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_--

--_006_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Add-cmd-to-control-XGMI-link-sleep.patch"
Content-Description: 0001-drm-amdgpu-Add-cmd-to-control-XGMI-link-sleep.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Add-cmd-to-control-XGMI-link-sleep.patch";
	size=6041; creation-date="Fri, 08 May 2020 06:48:00 GMT";
	modification-date="Fri, 08 May 2020 06:48:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwZDhhOTYzNDc1NzIwZGMwMGVmNjRiYTRlYTZlM2RkMmZkZjRhMTFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgOCBNYXkgMjAyMCAxNDo0MDoyMCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8z
XSBkcm0vYW1kZ3B1OiBBZGQgY21kIHRvIGNvbnRyb2wgWEdNSSBsaW5rIHNsZWVwCgpBZGRlZCBo
b3N0IHRvIFNNVSBGVyBjbWQgdG8gZW5hYmxlL2Rpc2FibGUgWEdNSSBsaW5rIHBvd2VyIGRvd24K
ClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KQ2hh
bmdlLUlkOiBJODA1NmIxMTgyYTkzZDY2OGVkNGY2M2QyNzEzZDNiZThkZGRmOGM1YgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyAgICB8IDIyICsrKysrKysr
KysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jICB8IDMx
ICsrKysrKysrKysrKysrKysrKysKIC4uLi9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdw
dV9zbXUuaCAgICB8ICAyICsrCiAuLi4vZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FyY3R1cnVzX3Bw
c21jLmggICAgfCAgMyArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdV90
eXBlcy5oIHwgIDEgKwogNSBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1
X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCmluZGV4
IDYwN2ZmMDI3MGFlZS4uYzVlNzk2OGE5MWQzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvYW1kZ3B1X3NtdS5jCkBAIC0yMTAwLDYgKzIxMDAsMjggQEAgaW50IHNtdV9zZXRfZGZf
Y3N0YXRlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCXJldHVybiByZXQ7CiB9CiAKK2ludCBz
bXVfYWxsb3dfeGdtaV9wb3dlcl9kb3duKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sIGVu
KQoreworCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2OworCWludCByZXQg
PSAwOworCisJaWYgKCFhZGV2LT5wbS5kcG1fZW5hYmxlZCkKKwkJcmV0dXJuIC1FSU5WQUw7CisK
KwlpZiAoIXNtdS0+cHB0X2Z1bmNzIHx8ICFzbXUtPnBwdF9mdW5jcy0+YWxsb3dfeGdtaV9wb3dl
cl9kb3duKQorCQlyZXR1cm4gMDsKKworCW11dGV4X2xvY2soJnNtdS0+bXV0ZXgpOworCisJcmV0
ID0gc211LT5wcHRfZnVuY3MtPmFsbG93X3hnbWlfcG93ZXJfZG93bihzbXUsIGVuKTsKKwlpZiAo
cmV0KQorCQlwcl9lcnIoIltBbGxvd1hnbWlQb3dlckRvd25dIGZhaWxlZCFcbiIpOworCisJbXV0
ZXhfdW5sb2NrKCZzbXUtPm11dGV4KTsKKworCXJldHVybiByZXQ7Cit9CisKIGludCBzbXVfd3Jp
dGVfd2F0ZXJtYXJrc190YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIHsKIAl2b2lkICp3
YXRlcm1hcmtzX3RhYmxlID0gc211LT5zbXVfdGFibGUud2F0ZXJtYXJrc190YWJsZTsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKaW5kZXggMWM2NmI3ZDcx
MzljLi40M2MyMGNiYTU2NzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2FyY3R1cnVzX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Fy
Y3R1cnVzX3BwdC5jCkBAIC0xMjgsNiArMTI4LDcgQEAgc3RhdGljIHN0cnVjdCBzbXVfMTFfMF9j
bW4yYWlzY19tYXBwaW5nIGFyY3R1cnVzX21lc3NhZ2VfbWFwW1NNVV9NU0dfTUFYX0NPVU5UXQog
CU1TR19NQVAoU2V0WGdtaU1vZGUsCQkJICAgICBQUFNNQ19NU0dfU2V0WGdtaU1vZGUpLAogCU1T
R19NQVAoU2V0TWVtb3J5Q2hhbm5lbEVuYWJsZSwJCSAgICAgUFBTTUNfTVNHX1NldE1lbW9yeUNo
YW5uZWxFbmFibGUpLAogCU1TR19NQVAoREZDc3RhdGVDb250cm9sLAkJICAgICBQUFNNQ19NU0df
REZDc3RhdGVDb250cm9sKSwKKwlNU0dfTUFQKEdtaVB3ckRuQ29udHJvbCwJCSAgICAgUFBTTUNf
TVNHX0dtaVB3ckRuQ29udHJvbCksCiB9OwogCiBzdGF0aWMgc3RydWN0IHNtdV8xMV8wX2NtbjJh
aXNjX21hcHBpbmcgYXJjdHVydXNfY2xrX21hcFtTTVVfQ0xLX0NPVU5UXSA9IHsKQEAgLTIyODYs
NiArMjI4NywzNSBAQCBzdGF0aWMgaW50IGFyY3R1cnVzX3NldF9kZl9jc3RhdGUoc3RydWN0IHNt
dV9jb250ZXh0ICpzbXUsCiAJcmV0dXJuIHNtdV9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUs
IFNNVV9NU0dfREZDc3RhdGVDb250cm9sLCBzdGF0ZSwgTlVMTCk7CiB9CiAKK3N0YXRpYyBpbnQg
YXJjdHVydXNfYWxsb3dfeGdtaV9wb3dlcl9kb3duKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBi
b29sIGVuKQoreworCXVpbnQzMl90IHNtdV92ZXJzaW9uOworCWludCByZXQ7CisKKwlyZXQgPSBz
bXVfZ2V0X3NtY192ZXJzaW9uKHNtdSwgTlVMTCwgJnNtdV92ZXJzaW9uKTsKKwlpZiAocmV0KSB7
CisJCXByX2VycigiRmFpbGVkIHRvIGdldCBzbXUgdmVyc2lvbiFcbiIpOworCQlyZXR1cm4gcmV0
OworCX0KKworCS8qIFBQU01DX01TR19HbWlQd3JEbkNvbnRyb2wgaXMgc3VwcG9ydGVkIGJ5IDU0
LjIwLjAgYW5kIG9ud2FyZHMgKi8KKwlpZiAoc211X3ZlcnNpb24gPCAweDM2NTAwMCkgeworCQlw
cl9lcnIoIlhHTUkgcG93ZXIgZG93biBjb250cm9sIGlzIG9ubHkgc3VwcG9ydGVkIGJ5IFBNRlcg
NTQuMjAuMCBhbmQgb253YXJkc1xuIik7CisJCXJldHVybiAtRUlOVkFMOworCX0KKworCWlmIChl
bikKKwkJcmV0dXJuIHNtdV9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsCisJCQkJCQkgICBT
TVVfTVNHX0dtaVB3ckRuQ29udHJvbCwKKwkJCQkJCSAgIDEsCisJCQkJCQkgICBOVUxMKTsKKwor
CXJldHVybiBzbXVfc2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0oc211LAorCQkJCQkgICBTTVVfTVNH
X0dtaVB3ckRuQ29udHJvbCwKKwkJCQkJICAgMCwKKwkJCQkJICAgTlVMTCk7Cit9CisKIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcHB0YWJsZV9mdW5jcyBhcmN0dXJ1c19wcHRfZnVuY3MgPSB7CiAJLyog
dHJhbnNsYXRlIHNtdSBpbmRleCBpbnRvIGFyY3R1cnVzIHNwZWNpZmljIGluZGV4ICovCiAJLmdl
dF9zbXVfbXNnX2luZGV4ID0gYXJjdHVydXNfZ2V0X3NtdV9tc2dfaW5kZXgsCkBAIC0yMzc5LDYg
KzI0MDksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFibGVfZnVuY3MgYXJjdHVydXNfcHB0
X2Z1bmNzID0gewogCS5vdmVycmlkZV9wY2llX3BhcmFtZXRlcnMgPSBzbXVfdjExXzBfb3ZlcnJp
ZGVfcGNpZV9wYXJhbWV0ZXJzLAogCS5nZXRfcHB0YWJsZV9wb3dlcl9saW1pdCA9IGFyY3R1cnVz
X2dldF9wcHRhYmxlX3Bvd2VyX2xpbWl0LAogCS5zZXRfZGZfY3N0YXRlID0gYXJjdHVydXNfc2V0
X2RmX2NzdGF0ZSwKKwkuYWxsb3dfeGdtaV9wb3dlcl9kb3duID0gYXJjdHVydXNfYWxsb3dfeGdt
aV9wb3dlcl9kb3duLAogfTsKIAogdm9pZCBhcmN0dXJ1c19zZXRfcHB0X2Z1bmNzKHN0cnVjdCBz
bXVfY29udGV4dCAqc211KQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvaW5jL2FtZGdwdV9zbXUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9h
bWRncHVfc211LmgKaW5kZXggOTI4ZWVkMjIwZjkzLi40ZDFjMmE0NGE4YjYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmgKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaApAQCAtNDkxLDYgKzQ5
MSw3IEBAIHN0cnVjdCBwcHRhYmxlX2Z1bmNzIHsKIAlpbnQgKCpnZXRfZHBtX2Nsa19saW1pdGVk
KShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgZW51bSBzbXVfY2xrX3R5cGUgY2xrX3R5cGUsCiAJ
CQkJICAgdWludDMyX3QgZHBtX2xldmVsLCB1aW50MzJfdCAqZnJlcSk7CiAJaW50ICgqc2V0X2Rm
X2NzdGF0ZSkoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGVudW0gcHBfZGZfY3N0YXRlIHN0YXRl
KTsKKwlpbnQgKCphbGxvd194Z21pX3Bvd2VyX2Rvd24pKHN0cnVjdCBzbXVfY29udGV4dCAqc211
LCBib29sIGVuKTsKIAlpbnQgKCp1cGRhdGVfcGNpZV9wYXJhbWV0ZXJzKShzdHJ1Y3Qgc211X2Nv
bnRleHQgKnNtdSwgdWludDMyX3QgcGNpZV9nZW5fY2FwLCB1aW50MzJfdCBwY2llX3dpZHRoX2Nh
cCk7CiAJaW50ICgqaTJjX2VlcHJvbV9pbml0KShzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmNvbnRyb2wp
OwogCXZvaWQgKCppMmNfZWVwcm9tX2ZpbmkpKHN0cnVjdCBpMmNfYWRhcHRlciAqY29udHJvbCk7
CkBAIC03MzEsNiArNzMyLDcgQEAgaW50IHNtdV9zZXRfbXAxX3N0YXRlKHN0cnVjdCBzbXVfY29u
dGV4dCAqc211LAogCQkgICAgICBlbnVtIHBwX21wMV9zdGF0ZSBtcDFfc3RhdGUpOwogaW50IHNt
dV9zZXRfZGZfY3N0YXRlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCQkgICAgICBlbnVtIHBw
X2RmX2NzdGF0ZSBzdGF0ZSk7CitpbnQgc211X2FsbG93X3hnbWlfcG93ZXJfZG93bihzdHJ1Y3Qg
c211X2NvbnRleHQgKnNtdSwgYm9vbCBlbik7CiAKIGludCBzbXVfZ2V0X21heF9zdXN0YWluYWJs
ZV9jbG9ja3NfYnlfZGMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJCQkJCSBzdHJ1Y3QgcHBf
c211X252X2Nsb2NrX3RhYmxlICptYXhfY2xvY2tzKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hcmN0dXJ1c19wcHNtYy5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaW5jL2FyY3R1cnVzX3Bwc21jLmgKaW5kZXggZjczNmQ3NzNmOWQ2Li5l
MDc0NzhiNmFjMDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2lu
Yy9hcmN0dXJ1c19wcHNtYy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2lu
Yy9hcmN0dXJ1c19wcHNtYy5oCkBAIC0xMTQsNyArMTE0LDggQEAKICNkZWZpbmUgUFBTTUNfTVNH
X1NldE51bUJhZEhibVBhZ2VzUmV0aXJlZAkgMHgzQQogCiAjZGVmaW5lIFBQU01DX01TR19ERkNz
dGF0ZUNvbnRyb2wJCSAweDNCCi0jZGVmaW5lIFBQU01DX01lc3NhZ2VfQ291bnQJCQkgMHgzQwor
I2RlZmluZSBQUFNNQ19NU0dfR21pUHdyRG5Db250cm9sICAgICAgICAgICAgICAgIDB4M0QKKyNk
ZWZpbmUgUFBTTUNfTWVzc2FnZV9Db3VudCAgICAgICAgICAgICAgICAgICAgICAweDNFCiAKIHR5
cGVkZWYgdWludDMyX3QgUFBTTUNfUmVzdWx0OwogdHlwZWRlZiB1aW50MzJfdCBQUFNNQ19Nc2c7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3R5cGVz
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3R5cGVzLmgKaW5kZXgg
YTViNGRmMTQ2NzEzLi5lZTdkYWM0NjkzZDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2luYy9zbXVfdHlwZXMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9pbmMvc211X3R5cGVzLmgKQEAgLTE3MCw2ICsxNzAsNyBAQAogCV9fU01VX0RVTU1Z
X01BUChTZXRTb2Z0TWluSnBlZyksICAgICAgICAgICAgICBcCiAJX19TTVVfRFVNTVlfTUFQKFNl
dEhhcmRNaW5GY2xrQnlGcmVxKSwgICAgICAgIFwKIAlfX1NNVV9EVU1NWV9NQVAoREZDc3RhdGVD
b250cm9sKSwgXAorCV9fU01VX0RVTU1ZX01BUChHbWlQd3JEbkNvbnRyb2wpLCBcCiAJX19TTVVf
RFVNTVlfTUFQKERBTF9ESVNBQkxFX0RVTU1ZX1BTVEFURV9DSEFOR0UpLCBcCiAJX19TTVVfRFVN
TVlfTUFQKERBTF9FTkFCTEVfRFVNTVlfUFNUQVRFX0NIQU5HRSksIFwKIAotLSAKMi4xNy4xCgo=

--_006_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0002-drm-amdgpu-Add-DPM-function-for-XGMI-link-power-down.patch"
Content-Description:  0002-drm-amdgpu-Add-DPM-function-for-XGMI-link-power-down.patch
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-Add-DPM-function-for-XGMI-link-power-down.patch";
	size=1546; creation-date="Fri, 08 May 2020 06:48:00 GMT";
	modification-date="Fri, 08 May 2020 06:48:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyYjY2NzJiNjYyYTRmOWUxZGFhYzQxMjVkYjRmZjBmZmNkYmMyNTM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgOCBNYXkgMjAyMCAxNDo0MzoyNyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi8z
XSBkcm0vYW1kZ3B1OiBBZGQgRFBNIGZ1bmN0aW9uIGZvciBYR01JIGxpbmsgcG93ZXIgZG93bgog
Y29udHJvbAoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQu
Y29tPgpDaGFuZ2UtSWQ6IEllY2I5YTdlNDI1Y2ZhNjRjY2MxNGIyNzk5MmQ1N2VkYTI2NTBiOTU5
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RwbS5jIHwgMTAgKysrKysr
KysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RwbS5oIHwgIDIgKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcG0uYwppbmRleCBiYTFiYjk1YTNjZjkuLmYzNmI1OGE3ZjQ4NSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RwbS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcG0uYwpAQCAtMTE4OCwzICsxMTg4LDEzIEBAIGlu
dCBhbWRncHVfZHBtX3NldF9kZl9jc3RhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAK
IAlyZXR1cm4gcmV0OwogfQorCitpbnQgYW1kZ3B1X2RwbV9hbGxvd194Z21pX3Bvd2VyX2Rvd24o
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgZW4pCit7CisJc3RydWN0IHNtdV9jb250
ZXh0ICpzbXUgPSAmYWRldi0+c211OworCisJaWYgKGlzX3N1cHBvcnRfc3dfc211KGFkZXYpKQor
CQlyZXR1cm4gc211X2FsbG93X3hnbWlfcG93ZXJfZG93bihzbXUsIGVuKTsKKworCXJldHVybiAw
OworfQpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcG0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kcG0uaAppbmRleCA5MzZkODVhYTBmYmMuLjk1NmY2YzcxMDY3MCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RwbS5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcG0uaApAQCAtNTM4LDQgKzUzOCw2IEBAIGludCBh
bWRncHVfZHBtX2JhY29fZW50ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogaW50IGFt
ZGdwdV9kcG1fc2V0X2RmX2NzdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAg
ICAgdWludDMyX3QgY3N0YXRlKTsKIAoraW50IGFtZGdwdV9kcG1fYWxsb3dfeGdtaV9wb3dlcl9k
b3duKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIGVuKTsKKwogI2VuZGlmCi0tIAoy
LjE3LjEKCg==

--_006_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0003-drm-amdgpu-Update-RAS-XGMI-error-inject-sequence.patch"
Content-Description:  0003-drm-amdgpu-Update-RAS-XGMI-error-inject-sequence.patch
Content-Disposition: attachment;
	filename="0003-drm-amdgpu-Update-RAS-XGMI-error-inject-sequence.patch";
	size=2009; creation-date="Fri, 08 May 2020 06:48:00 GMT";
	modification-date="Fri, 08 May 2020 06:48:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MjQwMTE0NzhiMmY4MjVmMTYyMTkxNjJmYzA1Yzc3NjU5ZWY0MjYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgOCBNYXkgMjAyMCAxNDo0NToyOCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMy8z
XSBkcm0vYW1kZ3B1OiBVcGRhdGUgUkFTIFhHTUkgZXJyb3IgaW5qZWN0IHNlcXVlbmNlCgpEaXNh
YmxlIFhHTUkgbGluayBwb3dlciBkb3duIHByaW9yIHRvIGlzc3VpbmcgYSBYR01JIFJBUyBlcnJv
cgoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpD
aGFuZ2UtSWQ6IEliZWFjMTYxNTA5ODQzYmE5MGUzN2Q4YWMyOTVlZjE5NWVjMWVlNWJjCi0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgMjQgKysrKysrKysrKysr
KysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwppbmRleCA3MzQ4NjE5
MjUzYzcuLjNiMmJjMjUyZWViYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYwpAQCAtODExLDYgKzgxMSwyNiBAQCBpbnQgYW1kZ3B1X3Jhc19lcnJvcl9xdWVyeShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlyZXR1cm4gMDsKIH0KIAorLyogVHJpZ2dlciBYR01J
L1dBRkwgZXJyb3IgKi8KK2ludCBhbWRncHVfcmFzX2Vycm9yX2luamVjdF94Z21pKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAorCQkJCSBzdHJ1Y3QgdGFfcmFzX3RyaWdnZXJfZXJyb3JfaW5w
dXQgKmJsb2NrX2luZm8pCit7CisJaW50IHJldDsKKworCWlmIChhbWRncHVfZHBtX2FsbG93X3hn
bWlfcG93ZXJfZG93bihhZGV2LCBmYWxzZSkpCisJCWRldl93YXJuKGFkZXYtPmRldiwgIkZhaWxl
ZCB0byBkaXNhbGxvdyBYR01JIHBvd2VyIGRvd24iKTsKKworCXJldCA9IHBzcF9yYXNfdHJpZ2dl
cl9lcnJvcigmYWRldi0+cHNwLCBibG9ja19pbmZvKTsKKworCWlmIChhbWRncHVfcmFzX2ludHJf
dHJpZ2dlcmVkKCkpCisJCXJldHVybiByZXQ7CisKKwlpZiAoYW1kZ3B1X2RwbV9hbGxvd194Z21p
X3Bvd2VyX2Rvd24oYWRldiwgdHJ1ZSkpCisJCWRldl93YXJuKGFkZXYtPmRldiwgIkZhaWxlZCB0
byBhbGxvdyBYR01JIHBvd2VyIGRvd24iKTsKKworCXJldHVybiByZXQ7Cit9CisKIC8qIHdyYXBw
ZXIgb2YgcHNwX3Jhc190cmlnZ2VyX2Vycm9yICovCiBpbnQgYW1kZ3B1X3Jhc19lcnJvcl9pbmpl
Y3Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCXN0cnVjdCByYXNfaW5qZWN0X2lmICpp
bmZvKQpAQCAtODQ0LDEwICs4NjQsMTIgQEAgaW50IGFtZGdwdV9yYXNfZXJyb3JfaW5qZWN0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlicmVhazsKIAljYXNlIEFNREdQVV9SQVNfQkxP
Q0tfX1VNQzoKIAljYXNlIEFNREdQVV9SQVNfQkxPQ0tfX01NSFVCOgotCWNhc2UgQU1ER1BVX1JB
U19CTE9DS19fWEdNSV9XQUZMOgogCWNhc2UgQU1ER1BVX1JBU19CTE9DS19fUENJRV9CSUY6CiAJ
CXJldCA9IHBzcF9yYXNfdHJpZ2dlcl9lcnJvcigmYWRldi0+cHNwLCAmYmxvY2tfaW5mbyk7CiAJ
CWJyZWFrOworCWNhc2UgQU1ER1BVX1JBU19CTE9DS19fWEdNSV9XQUZMOgorCQlyZXQgPSBhbWRn
cHVfcmFzX2Vycm9yX2luamVjdF94Z21pKGFkZXYsICZibG9ja19pbmZvKTsKKwkJYnJlYWs7CiAJ
ZGVmYXVsdDoKIAkJZGV2X2luZm8oYWRldi0+ZGV2LCAiJXMgZXJyb3IgaW5qZWN0aW9uIGlzIG5v
dCBzdXBwb3J0ZWQgeWV0XG4iLAogCQkJIHJhc19ibG9ja19zdHIoaW5mby0+aGVhZC5ibG9jaykp
OwotLSAKMi4xNy4xCgo=

--_006_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_006_MN2PR12MB4032BA32212F2A8948471950FBA20MN2PR12MB4032namp_--
