Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC993C2D0CF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 15:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711EB20409
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 15:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bfLZsXNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711EB20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2DD89F2A;
	Tue, 24 Dec 2019 15:32:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417D589F2A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 15:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do55kV4LBYXSp807GBQNVjZUgSe8Z0E4XLgeWvMaX0wrNWPH7Rmn6jxoT/4Ci2Qn3abneI3X5N814at9TVzbAUAYuWbKl4m7hC0WLQdhvGrM1t/t+HMJwTgdsTrXc43vBPvBwUuve6kF9bXokHAErdycmqi1czVQT54+vtKWxT/ymhw+xujJ5WCgmLEn1Da2DqtsCXYlvzYu1uEpp7iRQAYcCXB4qUtfyHIlC2MWqYZ4jrakWSAqC172DfWST2X8QGovcVHBQCiHGIbPMybPzKWV47FNWIPhhEwV3oHA/tN0W62n5Ig16cylVaKDBC3IQRA29HXDoqp3cJXXx8IKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRBZZoOLGI2dqwC2+qxt09DQHmU3TEOoyA9BjJMhHlE=;
 b=g2kUuzlw4R2TBcbAShuFdUxlK2fH0o7oWVrD/G7V+zKuGxFBMvqC/B6njD7gh4baOTPdiA9nJFwIlBVJgMBAmGKkAX8NMu7yHvcp+kuGesC5/ykUuKCiOx5c4KQDDJa2VZ7uBagnUw8tLZDASIDqEuaErIdtPcEpnxiGKz8Qnsqbvvhpav3gr5164DBxgDWdiblC069sAOhSBBMhrP4iH9nX3xNoU2gjIVFZvwbOnnV1dBUw3U4bsYBnH9ZypA0cfHWldeJA703K+6/vqeJr4ykkOOaEQh3WjdtrQgdW/GT96zvU82VFGNNiTxnpipiOdV69oh352xGDRTdfiBfQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRBZZoOLGI2dqwC2+qxt09DQHmU3TEOoyA9BjJMhHlE=;
 b=bfLZsXNwTsf2RshSEQ+NFaVLRmQsi+XJur9idj+8wDl7J3ugPH6/AxXOGfSp3iRKAX15FD5boH9Z2kE4EAY70rxcfGr/KDG6XquOrnFmajmjb7r65D2NkVsCy42UKYaFlt5eQ/oLGEwS3RJEK5O+QkSS2rIAR1CJ2M834t37jCU=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3245.namprd12.prod.outlook.com (20.179.82.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 15:32:34 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::e469:c9bb:44be:c069]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::e469:c9bb:44be:c069%6]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 15:32:34 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] Series to re-organize and amalgamate certain PSP TA functions
Thread-Topic: [PATCH] Series to re-organize and amalgamate certain PSP TA
 functions
Thread-Index: AdW6bmN9VmhE/V8bQ1OUR8tP1RbeiA==
Date: Tue, 24 Dec 2019 15:32:34 +0000
Message-ID: <MN2PR12MB36636CE4E6D055305F35D260FB290@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-24T15:32:28Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=36a485ac-1ed1-420e-849a-0000635bc4d3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-24T15:32:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 283b682c-2e72-4319-9bba-00008a5cae4b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49061bf6-47e1-4df8-7a04-08d788867f99
x-ms-traffictypediagnostic: MN2PR12MB3245:|MN2PR12MB3245:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB32457A28078581EC686E296CFB290@MN2PR12MB3245.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(189003)(199004)(478600001)(4744005)(26005)(71200400001)(6506007)(66446008)(110136005)(64756008)(66576008)(76116006)(52536014)(66476007)(7696005)(33656002)(66556008)(66946007)(6636002)(5660300002)(186003)(86362001)(55016002)(9686003)(81156014)(8936002)(2906002)(8676002)(81166006)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3245;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OkEqDwnhmnRYZRksqNOe5f+YSY8tSeBObU+nWD4R+AdbCXvDsdkgD9QPhmxvnI2YcoKkou25cuSA+c0uxPg2WvWTH3U2M3mojT7evJrzye8PZGzeo47hBpJgoOf4ZXBd96ea7FTHtJBu128i3cYkQlz4twLZ+AkD+p/kuK+mn7UXal193xnAaCH20/fLX90Ma8YvBYn008ajjMm2EQz4DNCixWcI2+Q8yjexuXRDCe0ybokiFoFPhxpjWg1jpmqbmDkkU7q82JOtaLUlewIu4/VRtmdEtvHw6ke1zts2IPHit5yqJZqRyID2EJzF7M1FeFaVE7t+LNXvPQVqYiwUuV0KH6WDIy/KN1YkTefSddLAbd6Jy+cB8EjP2fXG/GsMHxHiNYoi+TFnivnht+JwAiPfZQrMhfj0ZQig84Z22aLpSvcoP0gxQg4XxyrrbzA4
Content-Type: multipart/mixed;
 boundary="_006_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49061bf6-47e1-4df8-7a04-08d788867f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 15:32:34.2165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j84ksIzJbG00P8/juQHh4JL1+Y83V7RLiMUGLRcXykFY8zE4B0S/JfDIpwkW371sbmJgJzoX8eJhRoDnmMzNHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3245
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

--_006_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_"

--_000_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Patch 1:

  *   Update PSP command submission to output failure to dmesg by default
  *   Removed masking of response status (as requested by PSP team)

Patch 2:

  *   Unify TA function to prepare load/unload commands

Patch 3:

  *   Unify TA function to invoke commands

Thank you,
John Clements

--_000_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
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
	{mso-list-id:556208321;
	mso-list-type:hybrid;
	mso-list-template-ids:-1460926714 -1919000054 67698691 67698693 67698689 6=
7698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
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
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
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
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
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
	font-family:Wingdings;}
@list l1
	{mso-list-id:1045255539;
	mso-list-type:hybrid;
	mso-list-template-ids:-732297138 -1919000054 67698691 67698693 67698689 67=
698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:DengXian;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
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
<p class=3D"msipheader4d0fcdd7" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Patch 1:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Update PSP command submission to output failure to dmesg by default<o=
:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-l=
ist:l0 level1 lfo1">Removed masking of response status (as requested by PSP=
 team)<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Patch 2:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo2">Unify TA function to prepare load/unload commands<o:p></o:p></li></ul=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Patch 3:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo2">Unify TA function to invoke commands<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_--

--_006_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-by-default-output-PSP-ret-status-in-event-.patch"
Content-Description:  0001-drm-amdgpu-by-default-output-PSP-ret-status-in-event-.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-by-default-output-PSP-ret-status-in-event-.patch";
	size=1243; creation-date="Tue, 24 Dec 2019 15:26:00 GMT";
	modification-date="Tue, 24 Dec 2019 15:26:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyMGU0YjgwNDU5MThlMDUzYzRlMThmOGRlYTRlMzI3NTJhMmI4NTgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjQgRGVjIDIwMTkgMjE6MTk6NDQgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
M10gZHJtL2FtZGdwdTogYnkgZGVmYXVsdCBvdXRwdXQgUFNQIHJldCBzdGF0dXMgaW4gZXZlbnQg
b2YKIHN1Ym1pc3Npb24gZmFpbHVyZQoKdXBkYXRlIGZyb20gRFJNX0RFQlVHX0RSSVZFUiB0byBE
Uk1fV0FSTgoKQ2hhbmdlLUlkOiBJOWQ1YzIyMzUxNDg2NzU3YTM4ZDZiNjJlZjY5NmQ0NTAwNzc2
YzBhOApTaWduZWQtb2ZmLWJ5OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgNCArKy0tCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCAxYjg5YmMzZTJlOGYuLmE5ZjNiYzc4
Njg0OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwpAQCAtMTkxLDkg
KzE5MSw5IEBAIHBzcF9jbWRfc3VibWl0X2J1ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKIAkJ
aWYgKHVjb2RlKQogCQkJRFJNX1dBUk4oImZhaWxlZCB0byBsb2FkIHVjb2RlIGlkICglZCkgIiwK
IAkJCQkgIHVjb2RlLT51Y29kZV9pZCk7Ci0JCURSTV9ERUJVR19EUklWRVIoInBzcCBjb21tYW5k
ICgweCVYKSBmYWlsZWQgYW5kIHJlc3BvbnNlIHN0YXR1cyBpcyAoMHglWClcbiIsCisJCURSTV9X
QVJOKCJwc3AgY29tbWFuZCAoMHglWCkgZmFpbGVkIGFuZCByZXNwb25zZSBzdGF0dXMgaXMgKDB4
JVgpXG4iLAogCQkJIHBzcC0+Y21kX2J1Zl9tZW0tPmNtZF9pZCwKLQkJCSBwc3AtPmNtZF9idWZf
bWVtLT5yZXNwLnN0YXR1cyAmIEdGWF9DTURfU1RBVFVTX01BU0spOworCQkJIHBzcC0+Y21kX2J1
Zl9tZW0tPnJlc3Auc3RhdHVzKTsKIAkJaWYgKCF0aW1lb3V0KSB7CiAJCQltdXRleF91bmxvY2so
JnBzcC0+bXV0ZXgpOwogCQkJcmV0dXJuIC1FSU5WQUw7Ci0tIAoyLjE3LjEKCg==

--_006_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0002-drm-amdgpu-amalgamate-PSP-TA-load-unload-functions.patch"
Content-Description:  0002-drm-amdgpu-amalgamate-PSP-TA-load-unload-functions.patch
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-amalgamate-PSP-TA-load-unload-functions.patch";
	size=9780; creation-date="Tue, 24 Dec 2019 15:26:00 GMT";
	modification-date="Tue, 24 Dec 2019 15:26:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMTY2MmM1OGUxYTJjMWFkMTdiMDcxZjhhNDA1NTk5YmUwNzMyOGQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjQgRGVjIDIwMTkgMjI6NDU6NTEgKzA4MDAKU3ViamVjdDogW1BBVENIIDIv
M10gZHJtL2FtZGdwdTogYW1hbGdhbWF0ZSBQU1AgVEEgbG9hZC91bmxvYWQgZnVuY3Rpb25zCgpy
ZWR1Y2UgY29weSBhbmQgcGFzdGVkIGNvZGUKCkNoYW5nZS1JZDogSTEwMGZjMzQ4MDUyOGRmODNh
OGRmYmJiOWFmNDY0NWNiMjc3ZDcyMTEKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9o
bi5jbGVtZW50c0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wc3AuYyB8IDEzOCArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAz
OSBpbnNlcnRpb25zKCspLCA5OSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmMKaW5kZXggYTlmM2JjNzg2ODQ5Li4zZjA1NWE3M2RmZjkgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTM2NSwxMSArMzY1LDExIEBAIHN0
YXRpYyBpbnQgcHNwX2FzZF9sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXJldHVybiBy
ZXQ7CiB9CiAKLXN0YXRpYyB2b2lkIHBzcF9wcmVwX2FzZF91bmxvYWRfY21kX2J1ZihzdHJ1Y3Qg
cHNwX2dmeF9jbWRfcmVzcCAqY21kLAotCQkJCQl1aW50MzJfdCBhc2Rfc2Vzc2lvbl9pZCkKK3N0
YXRpYyB2b2lkIHBzcF9wcmVwX3RhX3VubG9hZF9jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9y
ZXNwICpjbWQsCisJCQkJICAgICAgIHVpbnQzMl90IHNlc3Npb25faWQpCiB7CiAJY21kLT5jbWRf
aWQgPSBHRlhfQ01EX0lEX1VOTE9BRF9UQTsKLQljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Np
b25faWQgPSBhc2Rfc2Vzc2lvbl9pZDsKKwljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Npb25f
aWQgPSBzZXNzaW9uX2lkOwogfQogCiBzdGF0aWMgaW50IHBzcF9hc2RfdW5sb2FkKHN0cnVjdCBw
c3BfY29udGV4dCAqcHNwKQpAQCAtMzg3LDcgKzM4Nyw3IEBAIHN0YXRpYyBpbnQgcHNwX2FzZF91
bmxvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJaWYgKCFjbWQpCiAJCXJldHVybiAtRU5P
TUVNOwogCi0JcHNwX3ByZXBfYXNkX3VubG9hZF9jbWRfYnVmKGNtZCwgcHNwLT5hc2RfY29udGV4
dC5zZXNzaW9uX2lkKTsKKwlwc3BfcHJlcF90YV91bmxvYWRfY21kX2J1ZihjbWQsIHBzcC0+YXNk
X2NvbnRleHQuc2Vzc2lvbl9pZCk7CiAKIAlyZXQgPSBwc3BfY21kX3N1Ym1pdF9idWYocHNwLCBO
VUxMLCBjbWQsCiAJCQkJIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwpAQCAtNDI3LDE4ICs0Mjcs
MjAgQEAgaW50IHBzcF9yZWdfcHJvZ3JhbShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwgZW51bSBw
c3BfcmVnX3Byb2dfaWQgcmVnLAogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyB2b2lkIHBzcF9w
cmVwX3hnbWlfdGFfbG9hZF9jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQsCi0J
CQkJCSAgdWludDY0X3QgeGdtaV90YV9tYywgdWludDY0X3QgeGdtaV9tY19zaGFyZWQsCi0JCQkJ
CSAgdWludDMyX3QgeGdtaV90YV9zaXplLCB1aW50MzJfdCBzaGFyZWRfc2l6ZSkKK3N0YXRpYyB2
b2lkIHBzcF9wcmVwX3RhX2xvYWRfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21k
LAorCQkJCSAgICAgdWludDY0X3QgdGFfYmluX21jLAorCQkJCSAgICAgdWludDMyX3QgdGFfYmlu
X3NpemUsCisJCQkJICAgICB1aW50NjRfdCB0YV9zaGFyZWRfbWMsCisJCQkJICAgICB1aW50MzJf
dCB0YV9zaGFyZWRfc2l6ZSkKIHsKLSAgICAgICAgY21kLT5jbWRfaWQgPSBHRlhfQ01EX0lEX0xP
QURfVEE7Ci0gICAgICAgIGNtZC0+Y21kLmNtZF9sb2FkX3RhLmFwcF9waHlfYWRkcl9sbyA9IGxv
d2VyXzMyX2JpdHMoeGdtaV90YV9tYyk7Ci0gICAgICAgIGNtZC0+Y21kLmNtZF9sb2FkX3RhLmFw
cF9waHlfYWRkcl9oaSA9IHVwcGVyXzMyX2JpdHMoeGdtaV90YV9tYyk7Ci0gICAgICAgIGNtZC0+
Y21kLmNtZF9sb2FkX3RhLmFwcF9sZW4gPSB4Z21pX3RhX3NpemU7CisgICAgICAgIGNtZC0+Y21k
X2lkIAkJCQk9IEdGWF9DTURfSURfTE9BRF9UQTsKKyAgICAgICAgY21kLT5jbWQuY21kX2xvYWRf
dGEuYXBwX3BoeV9hZGRyX2xvIAk9IGxvd2VyXzMyX2JpdHModGFfYmluX21jKTsKKyAgICAgICAg
Y21kLT5jbWQuY21kX2xvYWRfdGEuYXBwX3BoeV9hZGRyX2hpIAk9IHVwcGVyXzMyX2JpdHModGFf
YmluX21jKTsKKyAgICAgICAgY21kLT5jbWQuY21kX2xvYWRfdGEuYXBwX2xlbiAJCT0gdGFfYmlu
X3NpemU7CiAKLSAgICAgICAgY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9waHlfYWRkcl9s
byA9IGxvd2VyXzMyX2JpdHMoeGdtaV9tY19zaGFyZWQpOwotICAgICAgICBjbWQtPmNtZC5jbWRf
bG9hZF90YS5jbWRfYnVmX3BoeV9hZGRyX2hpID0gdXBwZXJfMzJfYml0cyh4Z21pX21jX3NoYXJl
ZCk7Ci0gICAgICAgIGNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfbGVuID0gc2hhcmVkX3Np
emU7CisgICAgICAgIGNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfcGh5X2FkZHJfbG8gPSBs
b3dlcl8zMl9iaXRzKHRhX3NoYXJlZF9tYyk7CisgICAgICAgIGNtZC0+Y21kLmNtZF9sb2FkX3Rh
LmNtZF9idWZfcGh5X2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKHRhX3NoYXJlZF9tYyk7CisgICAg
ICAgIGNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfbGVuIAkgPSB0YV9zaGFyZWRfc2l6ZTsK
IH0KIAogc3RhdGljIGludCBwc3BfeGdtaV9pbml0X3NoYXJlZF9idWYoc3RydWN0IHBzcF9jb250
ZXh0ICpwc3ApCkBAIC00NzQsOSArNDc2LDExIEBAIHN0YXRpYyBpbnQgcHNwX3hnbWlfbG9hZChz
dHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAltZW1zZXQocHNwLT5md19wcmlfYnVmLCAwLCBQU1Bf
MV9NRUcpOwogCW1lbWNweShwc3AtPmZ3X3ByaV9idWYsIHBzcC0+dGFfeGdtaV9zdGFydF9hZGRy
LCBwc3AtPnRhX3hnbWlfdWNvZGVfc2l6ZSk7CiAKLQlwc3BfcHJlcF94Z21pX3RhX2xvYWRfY21k
X2J1ZihjbWQsIHBzcC0+ZndfcHJpX21jX2FkZHIsCi0JCQkJICAgICAgcHNwLT54Z21pX2NvbnRl
eHQueGdtaV9zaGFyZWRfbWNfYWRkciwKLQkJCQkgICAgICBwc3AtPnRhX3hnbWlfdWNvZGVfc2l6
ZSwgUFNQX1hHTUlfU0hBUkVEX01FTV9TSVpFKTsKKwlwc3BfcHJlcF90YV9sb2FkX2NtZF9idWYo
Y21kLAorCQkJCSBwc3AtPmZ3X3ByaV9tY19hZGRyLAorCQkJCSBwc3AtPnRhX3hnbWlfdWNvZGVf
c2l6ZSwKKwkJCQkgcHNwLT54Z21pX2NvbnRleHQueGdtaV9zaGFyZWRfbWNfYWRkciwKKwkJCQkg
UFNQX1hHTUlfU0hBUkVEX01FTV9TSVpFKTsKIAogCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihw
c3AsIE5VTEwsIGNtZCwKIAkJCQkgcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CkBAIC00OTEsMTMg
KzQ5NSw2IEBAIHN0YXRpYyBpbnQgcHNwX3hnbWlfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBz
cCkKIAlyZXR1cm4gcmV0OwogfQogCi1zdGF0aWMgdm9pZCBwc3BfcHJlcF94Z21pX3RhX3VubG9h
ZF9jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQsCi0JCQkJCSAgICB1aW50MzJf
dCB4Z21pX3Nlc3Npb25faWQpCi17Ci0JY21kLT5jbWRfaWQgPSBHRlhfQ01EX0lEX1VOTE9BRF9U
QTsKLQljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Npb25faWQgPSB4Z21pX3Nlc3Npb25faWQ7
Ci19Ci0KIHN0YXRpYyBpbnQgcHNwX3hnbWlfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNw
KQogewogCWludCByZXQ7CkBAIC01MTEsNyArNTA4LDcgQEAgc3RhdGljIGludCBwc3BfeGdtaV91
bmxvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJaWYgKCFjbWQpCiAJCXJldHVybiAtRU5P
TUVNOwogCi0JcHNwX3ByZXBfeGdtaV90YV91bmxvYWRfY21kX2J1ZihjbWQsIHBzcC0+eGdtaV9j
b250ZXh0LnNlc3Npb25faWQpOworCXBzcF9wcmVwX3RhX3VubG9hZF9jbWRfYnVmKGNtZCwgcHNw
LT54Z21pX2NvbnRleHQuc2Vzc2lvbl9pZCk7CiAKIAlyZXQgPSBwc3BfY21kX3N1Ym1pdF9idWYo
cHNwLCBOVUxMLCBjbWQsCiAJCQkJIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwpAQCAtNjA1LDIw
ICs2MDIsNiBAQCBzdGF0aWMgaW50IHBzcF94Z21pX2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250
ZXh0ICpwc3ApCiB9CiAKIC8vIHJhcyBiZWdpbgotc3RhdGljIHZvaWQgcHNwX3ByZXBfcmFzX3Rh
X2xvYWRfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAotCQl1aW50NjRfdCBy
YXNfdGFfbWMsIHVpbnQ2NF90IHJhc19tY19zaGFyZWQsCi0JCXVpbnQzMl90IHJhc190YV9zaXpl
LCB1aW50MzJfdCBzaGFyZWRfc2l6ZSkKLXsKLQljbWQtPmNtZF9pZCA9IEdGWF9DTURfSURfTE9B
RF9UQTsKLQljbWQtPmNtZC5jbWRfbG9hZF90YS5hcHBfcGh5X2FkZHJfbG8gPSBsb3dlcl8zMl9i
aXRzKHJhc190YV9tYyk7Ci0JY21kLT5jbWQuY21kX2xvYWRfdGEuYXBwX3BoeV9hZGRyX2hpID0g
dXBwZXJfMzJfYml0cyhyYXNfdGFfbWMpOwotCWNtZC0+Y21kLmNtZF9sb2FkX3RhLmFwcF9sZW4g
PSByYXNfdGFfc2l6ZTsKLQotCWNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfcGh5X2FkZHJf
bG8gPSBsb3dlcl8zMl9iaXRzKHJhc19tY19zaGFyZWQpOwotCWNtZC0+Y21kLmNtZF9sb2FkX3Rh
LmNtZF9idWZfcGh5X2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKHJhc19tY19zaGFyZWQpOwotCWNt
ZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfbGVuID0gc2hhcmVkX3NpemU7Ci19Ci0KIHN0YXRp
YyBpbnQgcHNwX3Jhc19pbml0X3NoYXJlZF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7
CiAJaW50IHJldDsKQEAgLTY1NCw5ICs2MzcsMTEgQEAgc3RhdGljIGludCBwc3BfcmFzX2xvYWQo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJbWVtc2V0KHBzcC0+ZndfcHJpX2J1ZiwgMCwgUFNQ
XzFfTUVHKTsKIAltZW1jcHkocHNwLT5md19wcmlfYnVmLCBwc3AtPnRhX3Jhc19zdGFydF9hZGRy
LCBwc3AtPnRhX3Jhc191Y29kZV9zaXplKTsKIAotCXBzcF9wcmVwX3Jhc190YV9sb2FkX2NtZF9i
dWYoY21kLCBwc3AtPmZ3X3ByaV9tY19hZGRyLAotCQkJcHNwLT5yYXMucmFzX3NoYXJlZF9tY19h
ZGRyLAotCQkJcHNwLT50YV9yYXNfdWNvZGVfc2l6ZSwgUFNQX1JBU19TSEFSRURfTUVNX1NJWkUp
OworCXBzcF9wcmVwX3RhX2xvYWRfY21kX2J1ZihjbWQsCisJCQkJIHBzcC0+ZndfcHJpX21jX2Fk
ZHIsCisJCQkJIHBzcC0+dGFfcmFzX3Vjb2RlX3NpemUsCisJCQkJIHBzcC0+cmFzLnJhc19zaGFy
ZWRfbWNfYWRkciwKKwkJCQkgUFNQX1JBU19TSEFSRURfTUVNX1NJWkUpOwogCiAJcmV0ID0gcHNw
X2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLAogCQkJcHNwLT5mZW5jZV9idWZfbWNfYWRk
cik7CkBAIC02NzEsMTMgKzY1Niw2IEBAIHN0YXRpYyBpbnQgcHNwX3Jhc19sb2FkKHN0cnVjdCBw
c3BfY29udGV4dCAqcHNwKQogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyB2b2lkIHBzcF9wcmVw
X3Jhc190YV91bmxvYWRfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAotCQkJ
CQkJdWludDMyX3QgcmFzX3Nlc3Npb25faWQpCi17Ci0JY21kLT5jbWRfaWQgPSBHRlhfQ01EX0lE
X1VOTE9BRF9UQTsKLQljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Npb25faWQgPSByYXNfc2Vz
c2lvbl9pZDsKLX0KLQogc3RhdGljIGludCBwc3BfcmFzX3VubG9hZChzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCkKIHsKIAlpbnQgcmV0OwpAQCAtNjkzLDcgKzY3MSw3IEBAIHN0YXRpYyBpbnQgcHNw
X3Jhc191bmxvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJaWYgKCFjbWQpCiAJCXJldHVy
biAtRU5PTUVNOwogCi0JcHNwX3ByZXBfcmFzX3RhX3VubG9hZF9jbWRfYnVmKGNtZCwgcHNwLT5y
YXMuc2Vzc2lvbl9pZCk7CisJcHNwX3ByZXBfdGFfdW5sb2FkX2NtZF9idWYoY21kLCBwc3AtPnJh
cy5zZXNzaW9uX2lkKTsKIAogCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNt
ZCwKIAkJCXBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwpAQCAtODIzLDI0ICs4MDEsNiBAQCBzdGF0
aWMgaW50IHBzcF9yYXNfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIC8vIHJh
cyBlbmQKIAogLy8gSERDUCBzdGFydAotc3RhdGljIHZvaWQgcHNwX3ByZXBfaGRjcF90YV9sb2Fk
X2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwKLQkJCQkJICB1aW50NjRfdCBo
ZGNwX3RhX21jLAotCQkJCQkgIHVpbnQ2NF90IGhkY3BfbWNfc2hhcmVkLAotCQkJCQkgIHVpbnQz
Ml90IGhkY3BfdGFfc2l6ZSwKLQkJCQkJICB1aW50MzJfdCBzaGFyZWRfc2l6ZSkKLXsKLQljbWQt
PmNtZF9pZCA9IEdGWF9DTURfSURfTE9BRF9UQTsKLQljbWQtPmNtZC5jbWRfbG9hZF90YS5hcHBf
cGh5X2FkZHJfbG8gPSBsb3dlcl8zMl9iaXRzKGhkY3BfdGFfbWMpOwotCWNtZC0+Y21kLmNtZF9s
b2FkX3RhLmFwcF9waHlfYWRkcl9oaSA9IHVwcGVyXzMyX2JpdHMoaGRjcF90YV9tYyk7Ci0JY21k
LT5jbWQuY21kX2xvYWRfdGEuYXBwX2xlbiA9IGhkY3BfdGFfc2l6ZTsKLQotCWNtZC0+Y21kLmNt
ZF9sb2FkX3RhLmNtZF9idWZfcGh5X2FkZHJfbG8gPQotCQlsb3dlcl8zMl9iaXRzKGhkY3BfbWNf
c2hhcmVkKTsKLQljbWQtPmNtZC5jbWRfbG9hZF90YS5jbWRfYnVmX3BoeV9hZGRyX2hpID0KLQkJ
dXBwZXJfMzJfYml0cyhoZGNwX21jX3NoYXJlZCk7Ci0JY21kLT5jbWQuY21kX2xvYWRfdGEuY21k
X2J1Zl9sZW4gPSBzaGFyZWRfc2l6ZTsKLX0KLQogc3RhdGljIGludCBwc3BfaGRjcF9pbml0X3No
YXJlZF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7CiAJaW50IHJldDsKQEAgLTg3Nywx
MCArODM3LDExIEBAIHN0YXRpYyBpbnQgcHNwX2hkY3BfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQg
KnBzcCkKIAltZW1jcHkocHNwLT5md19wcmlfYnVmLCBwc3AtPnRhX2hkY3Bfc3RhcnRfYWRkciwK
IAkgICAgICAgcHNwLT50YV9oZGNwX3Vjb2RlX3NpemUpOwogCi0JcHNwX3ByZXBfaGRjcF90YV9s
b2FkX2NtZF9idWYoY21kLCBwc3AtPmZ3X3ByaV9tY19hZGRyLAotCQkJCSAgICAgIHBzcC0+aGRj
cF9jb250ZXh0LmhkY3Bfc2hhcmVkX21jX2FkZHIsCi0JCQkJICAgICAgcHNwLT50YV9oZGNwX3Vj
b2RlX3NpemUsCi0JCQkJICAgICAgUFNQX0hEQ1BfU0hBUkVEX01FTV9TSVpFKTsKKwlwc3BfcHJl
cF90YV9sb2FkX2NtZF9idWYoY21kLAorCQkJCSBwc3AtPmZ3X3ByaV9tY19hZGRyLAorCQkJCSBw
c3AtPnRhX2hkY3BfdWNvZGVfc2l6ZSwKKwkJCQkgcHNwLT5oZGNwX2NvbnRleHQuaGRjcF9zaGFy
ZWRfbWNfYWRkciwKKwkJCQkgUFNQX0hEQ1BfU0hBUkVEX01FTV9TSVpFKTsKIAogCXJldCA9IHBz
cF9jbWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwgcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7
CiAKQEAgLTkyMSwxMiArODgyLDYgQEAgc3RhdGljIGludCBwc3BfaGRjcF9pbml0aWFsaXplKHN0
cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCiAJcmV0dXJuIDA7CiB9Ci1zdGF0aWMgdm9pZCBwc3Bf
cHJlcF9oZGNwX3RhX3VubG9hZF9jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQs
Ci0JCQkJCSAgICB1aW50MzJfdCBoZGNwX3Nlc3Npb25faWQpCi17Ci0JY21kLT5jbWRfaWQgPSBH
RlhfQ01EX0lEX1VOTE9BRF9UQTsKLQljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Npb25faWQg
PSBoZGNwX3Nlc3Npb25faWQ7Ci19CiAKIHN0YXRpYyBpbnQgcHNwX2hkY3BfdW5sb2FkKHN0cnVj
dCBwc3BfY29udGV4dCAqcHNwKQogewpAQCAtOTQzLDcgKzg5OCw3IEBAIHN0YXRpYyBpbnQgcHNw
X2hkY3BfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCWlmICghY21kKQogCQlyZXR1
cm4gLUVOT01FTTsKIAotCXBzcF9wcmVwX2hkY3BfdGFfdW5sb2FkX2NtZF9idWYoY21kLCBwc3At
PmhkY3BfY29udGV4dC5zZXNzaW9uX2lkKTsKKwlwc3BfcHJlcF90YV91bmxvYWRfY21kX2J1Zihj
bWQsIHBzcC0+aGRjcF9jb250ZXh0LnNlc3Npb25faWQpOwogCiAJcmV0ID0gcHNwX2NtZF9zdWJt
aXRfYnVmKHBzcCwgTlVMTCwgY21kLCBwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKIApAQCAtMTAx
NiwyMiArOTcxLDYgQEAgc3RhdGljIGludCBwc3BfaGRjcF90ZXJtaW5hdGUoc3RydWN0IHBzcF9j
b250ZXh0ICpwc3ApCiAvLyBIRENQIGVuZAogCiAvLyBEVE0gc3RhcnQKLXN0YXRpYyB2b2lkIHBz
cF9wcmVwX2R0bV90YV9sb2FkX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwK
LQkJCQkJIHVpbnQ2NF90IGR0bV90YV9tYywKLQkJCQkJIHVpbnQ2NF90IGR0bV9tY19zaGFyZWQs
Ci0JCQkJCSB1aW50MzJfdCBkdG1fdGFfc2l6ZSwKLQkJCQkJIHVpbnQzMl90IHNoYXJlZF9zaXpl
KQotewotCWNtZC0+Y21kX2lkID0gR0ZYX0NNRF9JRF9MT0FEX1RBOwotCWNtZC0+Y21kLmNtZF9s
b2FkX3RhLmFwcF9waHlfYWRkcl9sbyA9IGxvd2VyXzMyX2JpdHMoZHRtX3RhX21jKTsKLQljbWQt
PmNtZC5jbWRfbG9hZF90YS5hcHBfcGh5X2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKGR0bV90YV9t
Yyk7Ci0JY21kLT5jbWQuY21kX2xvYWRfdGEuYXBwX2xlbiA9IGR0bV90YV9zaXplOwotCi0JY21k
LT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9waHlfYWRkcl9sbyA9IGxvd2VyXzMyX2JpdHMoZHRt
X21jX3NoYXJlZCk7Ci0JY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9waHlfYWRkcl9oaSA9
IHVwcGVyXzMyX2JpdHMoZHRtX21jX3NoYXJlZCk7Ci0JY21kLT5jbWQuY21kX2xvYWRfdGEuY21k
X2J1Zl9sZW4gPSBzaGFyZWRfc2l6ZTsKLX0KLQogc3RhdGljIGludCBwc3BfZHRtX2luaXRfc2hh
cmVkX2J1ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0OwpAQCAtMTA2Nywx
MCArMTAwNiwxMSBAQCBzdGF0aWMgaW50IHBzcF9kdG1fbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQg
KnBzcCkKIAltZW1zZXQocHNwLT5md19wcmlfYnVmLCAwLCBQU1BfMV9NRUcpOwogCW1lbWNweShw
c3AtPmZ3X3ByaV9idWYsIHBzcC0+dGFfZHRtX3N0YXJ0X2FkZHIsIHBzcC0+dGFfZHRtX3Vjb2Rl
X3NpemUpOwogCi0JcHNwX3ByZXBfZHRtX3RhX2xvYWRfY21kX2J1ZihjbWQsIHBzcC0+ZndfcHJp
X21jX2FkZHIsCi0JCQkJICAgICBwc3AtPmR0bV9jb250ZXh0LmR0bV9zaGFyZWRfbWNfYWRkciwK
LQkJCQkgICAgIHBzcC0+dGFfZHRtX3Vjb2RlX3NpemUsCi0JCQkJICAgICBQU1BfRFRNX1NIQVJF
RF9NRU1fU0laRSk7CisJcHNwX3ByZXBfdGFfbG9hZF9jbWRfYnVmKGNtZCwKKwkJCQkgcHNwLT5m
d19wcmlfbWNfYWRkciwKKwkJCQkgcHNwLT50YV9kdG1fdWNvZGVfc2l6ZSwKKwkJCQkgcHNwLT5k
dG1fY29udGV4dC5kdG1fc2hhcmVkX21jX2FkZHIsCisJCQkJIFBTUF9EVE1fU0hBUkVEX01FTV9T
SVpFKTsKIAogCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwgcHNwLT5m
ZW5jZV9idWZfbWNfYWRkcik7CiAKLS0gCjIuMTcuMQoK

--_006_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0003-drm-amdgpu-amalgamated-PSP-TA-invoke-functions.patch"
Content-Description: 0003-drm-amdgpu-amalgamated-PSP-TA-invoke-functions.patch
Content-Disposition: attachment;
	filename="0003-drm-amdgpu-amalgamated-PSP-TA-invoke-functions.patch";
	size=5856; creation-date="Tue, 24 Dec 2019 15:26:00 GMT";
	modification-date="Tue, 24 Dec 2019 15:26:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxYzQwM2FjNWU2YzdlNTBlMDRjZDgxODA2ZGQ0MjVkNmFmNjhkY2MzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjQgRGVjIDIwMTkgMjM6MTQ6MzggKzA4MDAKU3ViamVjdDogW1BBVENIIDMv
M10gZHJtL2FtZGdwdTogYW1hbGdhbWF0ZSBQU1AgVEEgaW52b2tlIGZ1bmN0aW9ucwoKcmVkdWNl
IGNvcHkgYW5kIHBhc3RlZCBjb2RlCgpDaGFuZ2UtSWQ6IEliOWUxNWM1Zjc0YWQ1NTBmNTdlYjkw
MTA4MjU0NjBjNDk3MjdiMTM2ClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xl
bWVudHNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMgfCAxMzcgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzQgaW5z
ZXJ0aW9ucygrKSwgMTAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYwppbmRleCAzZjA1NWE3M2RmZjkuLmZlNTZlYjM4ODBiZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwpAQCAtNDQzLDYgKzQ0MywzNiBAQCBzdGF0aWMg
dm9pZCBwc3BfcHJlcF90YV9sb2FkX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNt
ZCwKICAgICAgICAgY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9sZW4gCSA9IHRhX3NoYXJl
ZF9zaXplOwogfQogCitzdGF0aWMgdm9pZCBwc3BfcHJlcF90YV9pbnZva2VfY21kX2J1ZihzdHJ1
Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAorCQkJCSAgICAgICB1aW50MzJfdCB0YV9jbWRfaWQs
CisJCQkJICAgICAgIHVpbnQzMl90IHNlc3Npb25faWQpCit7CisJY21kLT5jbWRfaWQgCQkJCT0g
R0ZYX0NNRF9JRF9JTlZPS0VfQ01EOworCWNtZC0+Y21kLmNtZF9pbnZva2VfY21kLnNlc3Npb25f
aWQgCT0gc2Vzc2lvbl9pZDsKKwljbWQtPmNtZC5jbWRfaW52b2tlX2NtZC50YV9jbWRfaWQgCT0g
dGFfY21kX2lkOworfQorCitpbnQgcHNwX3RhX2ludm9rZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBz
cCwKKwkJICB1aW50MzJfdCB0YV9jbWRfaWQsCisJCSAgdWludDMyX3Qgc2Vzc2lvbl9pZCkKK3sK
KwlpbnQgcmV0OworCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQ7CisKKwljbWQgPSBremFs
bG9jKHNpemVvZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCksIEdGUF9LRVJORUwpOworCWlmICgh
Y21kKQorCQlyZXR1cm4gLUVOT01FTTsKKworCXBzcF9wcmVwX3RhX2ludm9rZV9jbWRfYnVmKGNt
ZCwgdGFfY21kX2lkLCBzZXNzaW9uX2lkKTsKKworCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihw
c3AsIE5VTEwsIGNtZCwKKwkJCQkgcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CisKKwlrZnJlZShj
bWQpOworCisgICAgICAgIHJldHVybiByZXQ7Cit9CisKIHN0YXRpYyBpbnQgcHNwX3hnbWlfaW5p
dF9zaGFyZWRfYnVmKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewogCWludCByZXQ7CkBAIC01
MTgsMzUgKzU0OCw5IEBAIHN0YXRpYyBpbnQgcHNwX3hnbWlfdW5sb2FkKHN0cnVjdCBwc3BfY29u
dGV4dCAqcHNwKQogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyB2b2lkIHBzcF9wcmVwX3hnbWlf
dGFfaW52b2tlX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwKLQkJCQkJICAg
IHVpbnQzMl90IHRhX2NtZF9pZCwKLQkJCQkJICAgIHVpbnQzMl90IHhnbWlfc2Vzc2lvbl9pZCkK
LXsKLQljbWQtPmNtZF9pZCA9IEdGWF9DTURfSURfSU5WT0tFX0NNRDsKLQljbWQtPmNtZC5jbWRf
aW52b2tlX2NtZC5zZXNzaW9uX2lkID0geGdtaV9zZXNzaW9uX2lkOwotCWNtZC0+Y21kLmNtZF9p
bnZva2VfY21kLnRhX2NtZF9pZCA9IHRhX2NtZF9pZDsKLQkvKiBOb3RlOiBjbWRfaW52b2tlX2Nt
ZC5idWYgaXMgbm90IHVzZWQgZm9yIG5vdyAqLwotfQotCiBpbnQgcHNwX3hnbWlfaW52b2tlKHN0
cnVjdCBwc3BfY29udGV4dCAqcHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpCiB7Ci0JaW50IHJldDsK
LQlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kOwotCi0KLQljbWQgPSBremFsbG9jKHNpemVv
ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCksIEdGUF9LRVJORUwpOwotCWlmICghY21kKQotCQly
ZXR1cm4gLUVOT01FTTsKLQotCXBzcF9wcmVwX3hnbWlfdGFfaW52b2tlX2NtZF9idWYoY21kLCB0
YV9jbWRfaWQsCi0JCQkJCXBzcC0+eGdtaV9jb250ZXh0LnNlc3Npb25faWQpOwotCi0JcmV0ID0g
cHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLAotCQkJCSBwc3AtPmZlbmNlX2J1Zl9t
Y19hZGRyKTsKLQotCWtmcmVlKGNtZCk7Ci0KLSAgICAgICAgcmV0dXJuIHJldDsKKyAgICAgICAg
cmV0dXJuIHBzcF90YV9pbnZva2UocHNwLCB0YV9jbWRfaWQsIHBzcC0+eGdtaV9jb250ZXh0LnNl
c3Npb25faWQpOwogfQogCiBzdGF0aWMgaW50IHBzcF94Z21pX3Rlcm1pbmF0ZShzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCkKQEAgLTY4MSw0MCArNjg1LDE1IEBAIHN0YXRpYyBpbnQgcHNwX3Jhc191
bmxvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJcmV0dXJuIHJldDsKIH0KIAotc3RhdGlj
IHZvaWQgcHNwX3ByZXBfcmFzX3RhX2ludm9rZV9jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9y
ZXNwICpjbWQsCi0JCXVpbnQzMl90IHRhX2NtZF9pZCwKLQkJdWludDMyX3QgcmFzX3Nlc3Npb25f
aWQpCi17Ci0JY21kLT5jbWRfaWQgPSBHRlhfQ01EX0lEX0lOVk9LRV9DTUQ7Ci0JY21kLT5jbWQu
Y21kX2ludm9rZV9jbWQuc2Vzc2lvbl9pZCA9IHJhc19zZXNzaW9uX2lkOwotCWNtZC0+Y21kLmNt
ZF9pbnZva2VfY21kLnRhX2NtZF9pZCA9IHRhX2NtZF9pZDsKLQkvKiBOb3RlOiBjbWRfaW52b2tl
X2NtZC5idWYgaXMgbm90IHVzZWQgZm9yIG5vdyAqLwotfQotCiBpbnQgcHNwX3Jhc19pbnZva2Uo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIHVpbnQzMl90IHRhX2NtZF9pZCkKIHsKLQlpbnQgcmV0
OwotCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQ7Ci0KIAkvKgogCSAqIFRPRE86IGJ5cGFz
cyB0aGUgbG9hZGluZyBpbiBzcmlvdiBmb3Igbm93CiAJICovCiAJaWYgKGFtZGdwdV9zcmlvdl92
Zihwc3AtPmFkZXYpKQogCQlyZXR1cm4gMDsKIAotCWNtZCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVj
dCBwc3BfZ2Z4X2NtZF9yZXNwKSwgR0ZQX0tFUk5FTCk7Ci0JaWYgKCFjbWQpCi0JCXJldHVybiAt
RU5PTUVNOwotCi0JcHNwX3ByZXBfcmFzX3RhX2ludm9rZV9jbWRfYnVmKGNtZCwgdGFfY21kX2lk
LAotCQkJcHNwLT5yYXMuc2Vzc2lvbl9pZCk7Ci0KLQlyZXQgPSBwc3BfY21kX3N1Ym1pdF9idWYo
cHNwLCBOVUxMLCBjbWQsCi0JCQlwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKLQotCWtmcmVlKGNt
ZCk7Ci0KLQlyZXR1cm4gcmV0OworICAgICAgICByZXR1cm4gcHNwX3RhX2ludm9rZShwc3AsIHRh
X2NtZF9pZCwgcHNwLT5yYXMuc2Vzc2lvbl9pZCk7CiB9CiAKIGludCBwc3BfcmFzX2VuYWJsZV9m
ZWF0dXJlcyhzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKQEAgLTkwNywzOSArODg2LDE1IEBAIHN0
YXRpYyBpbnQgcHNwX2hkY3BfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXJldHVy
biByZXQ7CiB9CiAKLXN0YXRpYyB2b2lkIHBzcF9wcmVwX2hkY3BfdGFfaW52b2tlX2NtZF9idWYo
c3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwKLQkJCQkJICAgIHVpbnQzMl90IHRhX2NtZF9p
ZCwKLQkJCQkJICAgIHVpbnQzMl90IGhkY3Bfc2Vzc2lvbl9pZCkKLXsKLQljbWQtPmNtZF9pZCA9
IEdGWF9DTURfSURfSU5WT0tFX0NNRDsKLQljbWQtPmNtZC5jbWRfaW52b2tlX2NtZC5zZXNzaW9u
X2lkID0gaGRjcF9zZXNzaW9uX2lkOwotCWNtZC0+Y21kLmNtZF9pbnZva2VfY21kLnRhX2NtZF9p
ZCA9IHRhX2NtZF9pZDsKLQkvKiBOb3RlOiBjbWRfaW52b2tlX2NtZC5idWYgaXMgbm90IHVzZWQg
Zm9yIG5vdyAqLwotfQotCiBpbnQgcHNwX2hkY3BfaW52b2tlKHN0cnVjdCBwc3BfY29udGV4dCAq
cHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpCiB7Ci0JaW50IHJldDsKLQlzdHJ1Y3QgcHNwX2dmeF9j
bWRfcmVzcCAqY21kOwotCiAJLyoKIAkgKiBUT0RPOiBieXBhc3MgdGhlIGxvYWRpbmcgaW4gc3Jp
b3YgZm9yIG5vdwogCSAqLwogCWlmIChhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkKIAkJcmV0
dXJuIDA7CiAKLQljbWQgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCks
IEdGUF9LRVJORUwpOwotCWlmICghY21kKQotCQlyZXR1cm4gLUVOT01FTTsKLQotCXBzcF9wcmVw
X2hkY3BfdGFfaW52b2tlX2NtZF9idWYoY21kLCB0YV9jbWRfaWQsCi0JCQkJCXBzcC0+aGRjcF9j
b250ZXh0LnNlc3Npb25faWQpOwotCi0JcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVM
TCwgY21kLCBwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKLQotCWtmcmVlKGNtZCk7Ci0KLQlyZXR1
cm4gcmV0OworICAgICAgICByZXR1cm4gcHNwX3RhX2ludm9rZShwc3AsIHRhX2NtZF9pZCwgcHNw
LT5oZGNwX2NvbnRleHQuc2Vzc2lvbl9pZCk7CiB9CiAKIHN0YXRpYyBpbnQgcHNwX2hkY3BfdGVy
bWluYXRlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQpAQCAtMTA1MywzOSArMTAwOCwxNSBAQCBz
dGF0aWMgaW50IHBzcF9kdG1faW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAly
ZXR1cm4gMDsKIH0KIAotc3RhdGljIHZvaWQgcHNwX3ByZXBfZHRtX3RhX2ludm9rZV9jbWRfYnVm
KHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQsCi0JCQkJCSAgIHVpbnQzMl90IHRhX2NtZF9p
ZCwKLQkJCQkJICAgdWludDMyX3QgZHRtX3Nlc3Npb25faWQpCi17Ci0JY21kLT5jbWRfaWQgPSBH
RlhfQ01EX0lEX0lOVk9LRV9DTUQ7Ci0JY21kLT5jbWQuY21kX2ludm9rZV9jbWQuc2Vzc2lvbl9p
ZCA9IGR0bV9zZXNzaW9uX2lkOwotCWNtZC0+Y21kLmNtZF9pbnZva2VfY21kLnRhX2NtZF9pZCA9
IHRhX2NtZF9pZDsKLQkvKiBOb3RlOiBjbWRfaW52b2tlX2NtZC5idWYgaXMgbm90IHVzZWQgZm9y
IG5vdyAqLwotfQotCiBpbnQgcHNwX2R0bV9pbnZva2Uoc3RydWN0IHBzcF9jb250ZXh0ICpwc3As
IHVpbnQzMl90IHRhX2NtZF9pZCkKIHsKLQlpbnQgcmV0OwotCXN0cnVjdCBwc3BfZ2Z4X2NtZF9y
ZXNwICpjbWQ7Ci0KIAkvKgogCSAqIFRPRE86IGJ5cGFzcyB0aGUgbG9hZGluZyBpbiBzcmlvdiBm
b3Igbm93CiAJICovCiAJaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQogCQlyZXR1cm4g
MDsKIAotCWNtZCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwKSwgR0ZQ
X0tFUk5FTCk7Ci0JaWYgKCFjbWQpCi0JCXJldHVybiAtRU5PTUVNOwotCi0JcHNwX3ByZXBfZHRt
X3RhX2ludm9rZV9jbWRfYnVmKGNtZCwgdGFfY21kX2lkLAotCQkJCSAgICAgICBwc3AtPmR0bV9j
b250ZXh0LnNlc3Npb25faWQpOwotCi0JcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVM
TCwgY21kLCBwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKLQotCWtmcmVlKGNtZCk7Ci0KLQlyZXR1
cm4gcmV0OworICAgICAgICByZXR1cm4gcHNwX3RhX2ludm9rZShwc3AsIHRhX2NtZF9pZCwgcHNw
LT5kdG1fY29udGV4dC5zZXNzaW9uX2lkKTsKIH0KIAogc3RhdGljIGludCBwc3BfZHRtX3Rlcm1p
bmF0ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKLS0gCjIuMTcuMQoK

--_006_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_006_MN2PR12MB36636CE4E6D055305F35D260FB290MN2PR12MB3663namp_--
