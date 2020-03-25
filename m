Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA3CC1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 06:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2EB2074D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 06:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1s2pAWC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2EB2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34B96E111;
	Wed, 25 Mar 2020 06:59:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCE76E111
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 06:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhDxiSxbvAJze0iA/Uk+EWVg/wT1dknKlvNOegJItdpy6xSZ8COZxplk/J2xcJLOjtByzF2zKBuQvqqi5YBKK+jCUZhY3ZHBvCwk7YKteNWh0VvmLZmGoqRWDVus4Liv6ey3o9hR/12CvPwwTgkECQ89BaE6dhdRBylSwJ5KzgCIXEU5jsOKWy55wQaaR0TpCJ0kfkDTwLXAluaWy1dz2P136C5VQL5s/Ody7mtIw5gKTJDqePeCttNcZ9GMnme7Ui9VGweFb/CxQI1cw1a+1Nhy+56C2EX3/2F3mGQi+eibHHcsu89/BxlW/QD9G54bev+xhDf0+7+NYtYyqozIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76YFKCR3Gu9VuclamNrA+yG9r1iw4sFmSlSakKhIO9I=;
 b=QRZEYGL87wQBz8AMUhkCn6+oe3A8WaU3UnG/7f4Tuif9aiUDF64Lf4aw7iVR/QGUi5CDinV3eqCCE4F4anVoQPqUM+5xcRstIf9/XQK3YlsV5WQYbkmi/8iQBXn7CrJa+4J4fjNueGfzutHJD1RNdf31IaZK1a5S0pyXlCbaWwo/6jt+qLh89N5ciJn9UsOkfvy+Pp3b7aYmqKER8psuH8NZc2p7LbxtbnGJFaMUyNdaGelr9rnCfIT+wZ/CgS37DFvGF9GklsDTaAnRSFhz5AyTDAFElqruTc4ssZxFmjspCdIRH0aMRxvg1Hu/F+mwvyEIi4vJWyHx4yuiDnYv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76YFKCR3Gu9VuclamNrA+yG9r1iw4sFmSlSakKhIO9I=;
 b=1s2pAWC77I0c4ocBkinS0VePHCzpuDrNNXiiG0+ADXhAnKF5c6NhSNXDaHZFo/xJP7bSYEsZM4b7LEuUdEp6yuRfDagTqG3OG+7kaMjao0Kex21efu+obj+v/+jaofTkcdZWuD2fXzO2gMtS4XU2WlIqsqHZ632YpLg3vMk+fWs=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15; Wed, 25 Mar 2020 06:59:06 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 06:59:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: added xgmi ras error reset sequence
Thread-Topic: [PATCH] drm/amdgpu: added xgmi ras error reset sequence
Thread-Index: AdYCcZGVr5OtLNxCSJCJvH1jNKE/ugAAS0YA
Date: Wed, 25 Mar 2020 06:59:06 +0000
Message-ID: <DM6PR12MB4075B27C81390723D7324D5DFCCE0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB3663ABDAD735500B548C76F5FBCE0@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3663ABDAD735500B548C76F5FBCE0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-25T06:50:20Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=468a059a-eee5-4623-a6fd-0000bdd9150b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-25T06:59:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4b6d5af1-12bc-4ee3-9eef-000058538808
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c58c210-c58b-4acb-1990-08d7d08a02b6
x-ms-traffictypediagnostic: DM6PR12MB2988:|DM6PR12MB2988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29882018CBFFF8F5CB91D394FCCE0@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(4744005)(2906002)(5660300002)(8676002)(478600001)(76116006)(9686003)(81166006)(81156014)(66446008)(66556008)(8936002)(52536014)(26005)(33656002)(186003)(66946007)(66476007)(6506007)(86362001)(53546011)(64756008)(55016002)(71200400001)(110136005)(316002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2988;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yigj5cXWucG00iA8Bgw1WVREQa26zE/5sAvtUR4w+rvYfvq7C5FTHGaoW/qZjgE9x251zvjQ3wB2fiT1Utwugs+8JWGHiuGHannof+a4PbKXeWZuB2ii+nLOAPD/gu0xwYpJzaL56V/e8/WBwUc/91cmrFwnLNbX1Ibj1Ljftmw2NYFETD4eg0tz3uzo59MZOkk9lAAuKFuxtIWwxC3TfcUaXK4fxgvA3U6ntvl2SVYoSN9+FhWplAS2SfisEjmQqEJfRwHu/kvs189pxuT5ONLmG5qdKOLt+FFWD2+U7AcO2WSIF3MF8Lq31nUsp8TmzBBKr4mb6cN4H8LbvR3wuSmGIPW8wIKFI677rd3h61sOn7kRoWDjuCgf/FG1QY2H4Zp9GM0/LApzcuAza9xFP5c4bu4IaGDuOb25QnnPIjaNiLmtwsdA3gIbPZQ5cYBK
x-ms-exchange-antispam-messagedata: U9rATmLiipeF3Gu0BDamg60cRscywU/D47KzQKQjJTBcUtY8XNMGSNzt49VzrhjBBjn7n50JFR+n7K2AtFhBR09/XS2mZTk6IXK3x9tlew2kzf77VuM16nnHxx9Njm0mlCpwjxzEhILhlWvXdyO+Fg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c58c210-c58b-4acb-1990-08d7d08a02b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 06:59:06.4542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /st2/agqP8R6OeytMu2Ef8ujdpLeFEJLydOoGDFoOmTQjDmiVOPiQqGdO4CNNT5xOnzP2vfNlqV7erjgDhu+lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Content-Type: multipart/mixed; boundary="===============0570983407=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0570983407==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075B27C81390723D7324D5DFCCE0DM6PR12MB4075namp_"

--_000_DM6PR12MB4075B27C81390723D7324D5DFCCE0DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

+             case CHIP_VEGA20:
+             default:

I'd suggest do nothing for default case. Other than that the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, March 25, 2020 14:50
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: added xgmi ras error reset sequence


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to clear xgmi ras error counters inbetween ras error query

--_000_DM6PR12MB4075B27C81390723D7324D5DFCCE0DM6PR12MB4075namp_
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
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;d suggest do nothing for default case. Other=
 than that the patch is<o:p></o:p></p>
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
<b>Sent:</b> Wednesday, March 25, 2020 14:50<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: added xgmi ras error reset sequence<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to clear xgmi ras error counters in=
between ras error query<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075B27C81390723D7324D5DFCCE0DM6PR12MB4075namp_--

--===============0570983407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0570983407==--
