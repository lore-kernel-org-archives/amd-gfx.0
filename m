Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A56C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 06:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65CF6120B
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 06:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65CF6120B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 622DF6E151;
	Mon, 12 Apr 2021 06:54:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FEF6E151
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 06:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayjno8HKc9LlibTcOeq9BF4gPMTE6bFWqdfZzxiiNer8tFvvHxk7SwH7OBBg74qGlnjPubBlCw/J+hrM/jYcz0Kq19hK+MAldwoGWDAaOp6UrbJDbxLmqHxdk0Ahl36+3qcwJ90lwRbI08njyziJ5pAb4SG9jKH/QVw2dwVK/wkLtUYKxzegpBtUvlDkLeFe/H6Wj4WKPtRSrp8O3Muqum7bOiPVf66PiI5tVF/qLQSG+Kd/HTwpDcEse1Rc6CiNirrFX+HHwqiK2NPAr6WE2us1luMoESaqtShcY7Rly53WHfv0ZmVvZ6pZbH2bJlZfzwlBjAfiauQMqgf76+r7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGFazR8A4o6dcD84HpfCsK0lfNsXgXYuP2BN3MhRA2Q=;
 b=BSnN/z5yt/R0JnQDpzJ5YMzBsIEBsyF0SzOXgfZ17VbNXDUsMIkbg8/p0AXsRdMQOZhrzQMRzZPUDiyhDYodXlJs9L3lrSEWwiEl+d2nvhrGcA4P+s5bC3kmC6xTBCOs2Jr3VUfreXhaJRifjVlR8ItX4hWN0uhF4leyk/p1IQt1qoOnqx+Gf490+YQmK389Lz6p2nxuvZXkxaYR0FJAKQxCldL1MtRO1TchouXjr0HBScNR8Myb2j4LAS+HLij8o4wggmHIaB06sdzjyABzYJBxQ8/rMQYAUNGzmBbZCngbxueawwXbjOcAsX91ZcCyM2O/Ou4mvMAIqSlMRihyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGFazR8A4o6dcD84HpfCsK0lfNsXgXYuP2BN3MhRA2Q=;
 b=1mjoRfgEo8gX14ZK+JFN4NFrF0Ou3aVzYvOwr/Szv681gyz8+NvD30kE/W+DOh52fkDoiH9DxDd5mFS7yNoZYzg5zFbwi//7EUWMFy9/3oo6AhC9wTilAl93rdatXVyToi9CP0U1H0JacVsQDVFqowy4tcHokz7NE2sO/JRJC8w=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22; Mon, 12 Apr 2021 06:54:14 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 06:54:14 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Update mmhub/gfx error reporting
Thread-Topic: [PATCH] Update mmhub/gfx error reporting
Thread-Index: AdcvY3ApyfQ+9gqZTBe8QhOAQ5ZRjAABScmg
Date: Mon, 12 Apr 2021 06:54:14 +0000
Message-ID: <DM6PR12MB407515810B7D752A93BB2DFFFC709@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <CY4PR1201MB00724C22BA84CA74D938A3CAFB709@CY4PR1201MB0072.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB00724C22BA84CA74D938A3CAFB709@CY4PR1201MB0072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-12T06:54:07Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b11bd088-004b-45f7-9f62-643d485d1586;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b34f410-6a52-4975-35a0-08d8fd7fc8b9
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB317955465B86DF06BADBF655FC709@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hZYTDxPrRFNnKGwCDtjJEtAw3268AvsvsWi0BFojRueFuZVXx1yBWef6ezXtf1KTM3rgQDMgD1ORu1bpbreFOfSx797m6R2T3UZWpHViXSJ3dC8u1ihgOitIi2vO6J19WFhPofnx9CCtl/rrnFgR81o+lbpHRF85KF3S19m5722TZh7BQ3iFqFThUQDE0IO0Ymh4gSh4oXEg9jRyPQ81AoxbW+1JjxzNn6XP9MvMBqPLz1ySpPj8JdOxf1xHASRjlGTs5d/pWVw7ErHC3l6YwlrqBuk5tqIImxQ2cJSTsEAcDMe0PPAOw/cLsLGoMBFgc4Tw9hp+RTxvpkV1OszXlIIal2IR5pTwyLSa2FM0ElltEth0k4neINKiqGSuyHGq0Qs10AjMbGUVaFp/XsQgaXsrzcMXUwxLzumPkjzs+9f3+Im5cW4v780Frz+4XI712KQlC6VldpxDnddodxjUp2oEMfjOTnDop7sx46FIOybP9ycwvdzymWot5qYsWXndnyqRnLGMSijc1c6nKUyjeQoBQUKVinNk/ZYYDJlie/B1HXo3yfPYC4twjnqjzvjHx5USKPorhT/leVNvR7JNfvjDKxn5xlTyQqLGBL6QRI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(5660300002)(71200400001)(4744005)(66556008)(186003)(66476007)(66946007)(26005)(83380400001)(64756008)(110136005)(7696005)(66446008)(53546011)(38100700002)(9686003)(55016002)(2906002)(86362001)(8936002)(8676002)(52536014)(33656002)(478600001)(6506007)(15650500001)(316002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+xxdCtZ3x0vc4TCQUbrHuamXV99gqUxYgQi2mZdYspe6N9uHohAGxvYh+yoH?=
 =?us-ascii?Q?WIrj4TVL+wiJ0pZQPGjO4pil0aIUWbaK11WiSKvML5uwuilRY1AWiBQKVMmU?=
 =?us-ascii?Q?8r1g+EH49PFJ5pfJPVcIwmuA8l76NIBYJ/jcLaDsZj12VApdpIYDSmEX3Cgm?=
 =?us-ascii?Q?ZGENzX+peDdjNrj/Vr9IN7UMoT64IBuUiUhwnWdbGulNh9IAuS2ohva5LKMS?=
 =?us-ascii?Q?LVYOFJGZahAYdB6AMqD8ORJ3rBs6ShO5Ajer8kRSAz5Z4CFKnHam2TE0faz4?=
 =?us-ascii?Q?D5Gvd7sBoH4SwRJ0pM9Uu4Xh+5iiT7nvyj68tVAHfbBOzSYeAKPIMNB5QRak?=
 =?us-ascii?Q?s3hlLuRY4t07vMcUG6CVu+LAdsbOZ8PC2Kd4+zVT7FWnOl/zlJXBqzn/jNHC?=
 =?us-ascii?Q?pfWrJ4p04QR3m2fJdVyjrallmjCLbJmmVudyG7COpvOBa/MyfLn9GdgFYlQv?=
 =?us-ascii?Q?aPcxE5MuUN85e07urdyy0qT1nUTFiO+a4jH1jPFzW7bIh99NuJAg8xNPn4rY?=
 =?us-ascii?Q?/ZaED//VD/8PEz2nQCKBJ4HKrjuziGvKhAeR5LOqj4Bo+t4MQn/YOj+qiyYF?=
 =?us-ascii?Q?Z0v057PIZf4mIh9+V2WjLlTsX63Pd7xwbbbdX1jjTNCpdqlBXs1g7q0nTv45?=
 =?us-ascii?Q?h2AO941dS4oJH7AD5qnXs32c3xZQzr2gK884QjGZ9uEd9+58zlAIb2FaL1Np?=
 =?us-ascii?Q?fKNkuxkdUX03+eUSQ6ESfszTskVkI8hXuhgxJP4KojL6yAIgWaVDjIIa+59A?=
 =?us-ascii?Q?5ppJ9E7ynPYym3+IxRSDEvMS7Ct+I8X8YEHbgYtd8dUafIZ5mXupJZZz7QGr?=
 =?us-ascii?Q?MV08rzxaozjY89mh/TOuBkPnM+8e8nX78zK8BNON5qIWCmgqXMOmVWI/MvM8?=
 =?us-ascii?Q?23MVqFhfc49NevSSkQ4GwRRX0TvrfnBgykI7xkdMP3+t3bybYEu01mdvqtn+?=
 =?us-ascii?Q?lqTUDkzMur7CLHZAdqHj/sQhDqjLYWQ0kt0rUfDd31X1qPtr4FXmyzg8DW0w?=
 =?us-ascii?Q?gmGOXAfRmRvjfw4Vj++UBPZ7dzYp4wKL0PSshAr/5nvS5STv+5urYMCbWmsr?=
 =?us-ascii?Q?QKZEld3Q5jzig37rWXRPBL4aUyDZtVbmbq4c/HRy+aw9AGwbzjUREgqXuUXF?=
 =?us-ascii?Q?acHq4gdmPizID6ITkhknA/9223GfelTd9zLC3aj+81Zi68ge5WN5rte/GPFX?=
 =?us-ascii?Q?Dc09oci+PL4JGaLEd2mn5qB8pCzkx090qSvITix8qhummJI5ECi95JssZ+3U?=
 =?us-ascii?Q?f0g2lpxD1AOKxdcd29/gMRS+1l5tBryN3LzbEs1e1FsPgh7gBAnAXih+aQCV?=
 =?us-ascii?Q?UGYSnyEEKW1lWS8SfU7LiPMV?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b34f410-6a52-4975-35a0-08d8fd7fc8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 06:54:14.2463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IV895KY6zQj7Ig5HrMPJjeLJOP+JXju45L/qqLaafXzeprv+kfHQrH07a7MiGhhOZ4KqLK+raO8t/49CSyPFEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Content-Type: multipart/mixed; boundary="===============0114867361=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0114867361==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB407515810B7D752A93BB2DFFFC709DM6PR12MB4075namp_"

--_000_DM6PR12MB407515810B7D752A93BB2DFFFC709DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Monday, April 12, 2021 14:18
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] Update mmhub/gfx error reporting


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to report mmhub/gfx error status on Aldebaran only if ther=
e is an error status bit and error counter set.

--_000_DM6PR12MB407515810B7D752A93BB2DFFFC709DM6PR12MB4075namp_
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
<p class=3D"MsoNormal">Series is <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Monday, April 12, 2021 14:18<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] Update mmhub/gfx error reporting<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to report mmhub/gfx error status on=
 Aldebaran only if there is an error status bit and error counter set.<o:p>=
</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB407515810B7D752A93BB2DFFFC709DM6PR12MB4075namp_--

--===============0114867361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0114867361==--
