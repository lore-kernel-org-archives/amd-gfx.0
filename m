Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1288C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E91061131
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E91061131
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33FF56E48D;
	Thu,  9 Sep 2021 08:05:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984406E48E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 08:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLEv9xRtPNdh36fANXYNljxlPvAECGPjzstfOZLtzf4sc73rA7f9OwfSoiZy+G0dvxPejpSJtucddJqxxqrTAxH7xTamMrxcaIvviL44CDSwtcvBPMcFlOv7M42FKTQn+euU6ChhY3jF7US8RbAo6OjS0jTcMnRL6dBWW4KndJOE0pIRy44DMVzUSNmPUKQ0giNVTu3usjwnMHWcCm/mEz6K40GSH+qXG8lGA8paHtuIm/70P3RgFBf+VTjir5+J5PMXmBMU1BJVlzA79ND8U6P9X2OrZTZus1nLoZa1xfzVsu72UsPzCSU/egIyadjjPwlcVUo+7BmPROxiJ3t/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=3CpFpZamMbgoTmO2wOhZWhSaZ4mIURGNZ5K9wnX1Du8=;
 b=DBRo2aKPYGFE2VwcwAObhwS57Y4Sw2FpM8Oa5eZVVudU/W0gK1soVwYa1FrbTnm1Xky/WefClMYKImj7S5xU6dHfuUvFbu1sKrT7nLmbdGZEdhZs2wwO1voYAW2ueJEEfNjVWMqRfsVhGq6RFmSufgtpdWK/UlgKTx0s5JfgAlh9B7uhrEjhLkkTbX8WOjv2XaH39N6t8841MJ+fRyuIUrgF+o7v3KuV81mXTw57qaZncX41URFLV8913rLI90JuV8/VpCsO71xLE5i4goooQAoWfSq4YEWX6ejQBcmAJN1M7QCPI8d7Skk3nrCXUIuTnAmyeWV83GaiB5eipdZCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CpFpZamMbgoTmO2wOhZWhSaZ4mIURGNZ5K9wnX1Du8=;
 b=KyjEsFcFTh85/eoEhKrx8+VtLwc1aLdfEpEhCecmgssnz29bWjrw2hMUxR5yiVL44KTnCu/EUeNity1o2MT0IV382b/Y7uAZTStFp5Z1pp2XHnu0UGXDt+l0ECUoA0j26YGX49N60M9YNfsaEZ1U4D6p1JPYVhXE8a9eyupNwsw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Thu, 9 Sep
 2021 08:05:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%6]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 08:05:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update RAS status print
Thread-Topic: [PATCH] drm/amdgpu: Update RAS status print
Thread-Index: AdelUJap8DAcxsdeTDeWqt+zSdYfWAAAKkFw
Date: Thu, 9 Sep 2021 08:05:26 +0000
Message-ID: <BN9PR12MB5257D8C99F7D201CC945A7E2FCD59@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <BN9PR12MB5226452C055807353DEA5D3FFBD59@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5226452C055807353DEA5D3FFBD59@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T08:05:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9fec9d80-16c5-40ba-b591-864cf1d49e56;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d14d4279-6f80-4786-2fd1-08d973689552
x-ms-traffictypediagnostic: BN9PR12MB5339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB533948FC2AFE0FC6DBBC5BE5FCD59@BN9PR12MB5339.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYdJ0Cu4lm6oQ0h1PUau3PLtk/ny5WmsjIjsjY7UwlDXRcHekCsh0oxP5sklk4bEPj4Anv/LCHTzj0f5el2W1a3BTDgCLm0w+q7E2+5Kvtcf5CTXRrxIkUPIKEjQ6FaW3vA5UIDvcJSsJyfgS22/QJKdGzJa+pVGbGfTneuEKhW/yfwcf8SE07woRUD7s8mSaXh1G+tkRlu0j0aD/Wf1aJy5a3LBKhY1CAvOf8EsafBBmi+KHk2azBvTnp1rsOJ9FFdu8zqWjSPlnjcZXoaIODWUSjLhjml19dLo6lekP0sINVvgWeqiJGS09MTRsdLr/rnTgMTxnzl+HvZRTJuU2CQeDHmt6yfdQoHya3QISY0LG0ADv4XwJufsunDsomKBEnZw8DQxY23apEgCH1/TKTvbJcObgTWIyMuqe2R3ec8vtE/i+hYl28fcJMBVxncu5IbkOz22w83CgH1Dezs+8wwdubXXWyBvXvfiRaXnCNdZz9QG4lR9WotGBXGO+TJ+YXTzmwfB/WY8o6Mx/G1slSwqLtA6MRkz41L4gWKC8fZGqXVO8pqv0S8/6Y8V24RQqbdGqZrq/INj/d+281wk+YnAbousYAUaJS36z72AFf2WD09hy/OJ3m3nAZ+IYjgyLp76PXMImTo2YI4eXPz7HLm85Yz0fkiU0TrRcs8B6bqzTAF7uojIP2afRYHLZrwPZi4OdEkz+HPA+rt+FP2bTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(38100700002)(66476007)(8936002)(66446008)(66946007)(64756008)(66556008)(76116006)(122000001)(86362001)(83380400001)(8676002)(55016002)(6636002)(316002)(9686003)(38070700005)(110136005)(33656002)(2906002)(71200400001)(26005)(186003)(4744005)(52536014)(7696005)(15650500001)(478600001)(53546011)(5660300002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MOAur1OvXthiaceCnus53mj0skybfzC4aZS6kuksBVe2ZG6cJizhe82JGON4?=
 =?us-ascii?Q?owB9xJ94gGhACkLA8Q052LYfexVh4PGiwoCDL4VYHQnjto3Mu37mO8Yxlluu?=
 =?us-ascii?Q?mJDjZpnoXdSznugXmJVal5HofqTgrgZfC/+1SfFPI3PqN0msV2E+aY6xv/yh?=
 =?us-ascii?Q?ggPbZV4Mz4d7biXoJBsQ1jqkFVmTouwmSNH/coTYHjSkjKUq0wQq1B4OHhLf?=
 =?us-ascii?Q?S+cVyHr5w/4LP0vAn1cfNWYkcaoHHW9dll2cMCz9vCwHtG4CjM2PQUtT0zI2?=
 =?us-ascii?Q?fZFGOBvo/x/2XRGE7Zxb7tm3u4dnu1s+cAbBh2L3/TJMKOv+bvS9NQkyY/NV?=
 =?us-ascii?Q?KOizd+BaOKk1fAQYTj+O3EjfxJfrGUY0y5aaMUa1bLD1S33dU2CTwSXtNMyr?=
 =?us-ascii?Q?maCL/r8kM7gdzlqG2Utm6pIPKl8W2QwRIe5g+nTffOEFcuWj5s1n/l7MzsuS?=
 =?us-ascii?Q?LXsDN0LYXJAcnjk7Xou5PJz7/FzHjReW6xrdrCFBKKXaVEbKfPLXT5joPtKN?=
 =?us-ascii?Q?s0UJ/R6QoKkbHbbodlTppeCN219Qeyg+gdKGKeHoF18Ay9z/wlPY7LqbkvID?=
 =?us-ascii?Q?BMhrvqow1qASNORPEhCSyIoUwD7NmZRqBIiiN/x6eAPdNmDlh+3wDDvvInd7?=
 =?us-ascii?Q?zRbIkAvgldsihctoJV0ajN/jWkBlLtuiSU3a5VDq30//rSQbu61P2dZu/PXF?=
 =?us-ascii?Q?gU/RdcPLxi2SEt9/LxnVfUgOebEcOOVp9TUzbU2LcVYd/hs372gaaK4KSssi?=
 =?us-ascii?Q?I0KLIcW/KK8ScDuTtDp+4XpfGkFRYp6cqzNegnvGKKldfnfkvdPYsCpUGDEE?=
 =?us-ascii?Q?Ce29HjrOrOHi/ZzHSw5mEbMu9Tc1S98JdQsI/5FOQ80cjFcV6Oa68XemNvDw?=
 =?us-ascii?Q?oEMpW0D5VczjCrxcbS1mrbjwTpg2y4+AwlNl9RYSINd++F4rBFtTxkfIojtX?=
 =?us-ascii?Q?zwVrxR8zbuwnWFtWeY2bG61iTfxpi7HmtB80KC8kIDujqiGtSlqk4D3MAJ3V?=
 =?us-ascii?Q?AQNZfc9WiixrOJYWygFpvCtGhV5xmcDLdIMU+16mma0H3Yk1+dISP160/VfP?=
 =?us-ascii?Q?DCdbrzC2Nv0YpIQHrPNBzC0063xJhcuBTYEo58ioCwe98Ed/YTqrkONU6tmU?=
 =?us-ascii?Q?e22W6Zu9PwOztlhNiKzJrMHQELeNc/4zMj5Ma66QYPiAbcJky8AI92mfrWvZ?=
 =?us-ascii?Q?yRH396NmaWJgrGaPkyXqYXFD9SDNFK7/h4XVUxca2Icbw4dE4QSu99zwF8rz?=
 =?us-ascii?Q?J3VbyXkRxHEDDg52pCExvTrl6ROSSOC6DTDuH/WFr52bY8PgWol295ihCGPF?=
 =?us-ascii?Q?ZQhE32RR39dYRZbp+yXSs+E8?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257D8C99F7D201CC945A7E2FCD59BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14d4279-6f80-4786-2fd1-08d973689552
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 08:05:26.6997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoy+ZvW5lRPS7/LGG8Vm5xZi1tMpqU7T8RZXDVZvuh3sgFBjSEPgnnLpkP26pGqAjcDnY4A9KkEgXFFHuA6IRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
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

--_000_BN9PR12MB5257D8C99F7D201CC945A7E2FCD59BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Please change the coding style for the bracket.

+             if (ras_cmd->ras_status)
+             {

Other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, September 9, 2021 16:00
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS status print


[AMD Official Use Only]

Submitting patch to remove parser for RAS status response codes and just pr=
int RAS status value on non-zero value

--_000_BN9PR12MB5257D8C99F7D201CC945A7E2FCD59BN9PR12MB5257namp_
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
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
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
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please change the coding style for the bracket.<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ras_cmd-&gt;ras_status)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Other than that, the patch is<o:p></o:p></p>
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
<b>Sent:</b> Thursday, September 9, 2021 16:00<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update RAS status print<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to remove parser for RAS status res=
ponse codes and just print RAS status value on non-zero value<o:p></o:p></p=
>
</div>
</body>
</html>

--_000_BN9PR12MB5257D8C99F7D201CC945A7E2FCD59BN9PR12MB5257namp_--
