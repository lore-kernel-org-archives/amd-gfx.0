Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B0EC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 06:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182A560F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 06:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 182A560F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A710189760;
	Tue, 31 Aug 2021 06:42:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB25489760
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 06:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIPu+ovs6bcwMtAlbbcvftakpieB3uUuQVevdqiqgAEk7jMNU3xiPrv0ibQdaCiAW0VdokKVwrGVN81aAV1m1uXphSFzRKSld4E8m4Au3gbwsK/LJF7bgItjvfa0zeP1L4OrDLexbBQ0QL/QjxsOUPZJzXBu+FUWrcSVqv6cFyf64GSjP9axO6KWzBtGIZPfZW11j3E4hHwrV5qfRpqUpiAXTKS//lMvg/w1NB5+n+qQlUoagQkhOOttmpBg403E5BSTYaQMVoyh1LObCGQ9ymqk4a4wDBAk/mB9HvALV1Hq4ZGNI+JPPgG5OkKjMMBTxBlH/o8RZfrzrQIPmRh8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=9KbSO+jFPKLuKhHP3+2pejQZdh1oZv++dV9JNvtRSsc=;
 b=iY6qWsMyexIsc8e/P7pUa/WGGzoDNpFal8+OhcQmkIv8Pjz6Otbd+4rFwLgZ+Qj+WtHB13eJOw9TTBZQmed000wx2Y3lR+ZxtMcR2OYVBnXloGKHifi48E++8E6wvsMB4wWYDUvNb0rr2MB8I1j/fWTPAuYhSTtGFO6V2rwgNqdzDlmlOT7DohUWIFD/21q+j4NaFeVM60A9Cx4Imtf2h9C3JQJhmfXnqYDGbyKYxlfI55XmR4X0pgRmcGsqO1PhlOiU2VGJiXUYAnVeJm6W2LCPF5hJBabS/x8i2fnrOZh/CPwsxH0E+0dIDxblKxxA317hKwufUfFamSO6yvvjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KbSO+jFPKLuKhHP3+2pejQZdh1oZv++dV9JNvtRSsc=;
 b=IpD2oJL6EpHKVdWWxeFz49rn2l7b+KSrXQyr4IKAnPlgUvbx3vU57hZ75kN+0PcNTY2FKTv4kOXlB1r9TO1GJ2LrKg7L0nc7jxoPJdGzNhRoCJyfNo5uQzw+NNGyhUsiBUtakkwoZIyMvvvXn9AT1ZK/xfuzAJjSF0+rYs6z3f4=
Received: from DM6PR12MB4649.namprd12.prod.outlook.com (2603:10b6:5:1d1::32)
 by DM5PR1201MB0249.namprd12.prod.outlook.com (2603:10b6:4:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 06:42:05 +0000
Received: from DM6PR12MB4649.namprd12.prod.outlook.com
 ([fe80::8851:2bd:769a:14b9]) by DM6PR12MB4649.namprd12.prod.outlook.com
 ([fe80::8851:2bd:769a:14b9%6]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 06:42:05 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran
Thread-Index: AdeeMSvYbTiFkB0wS66shGZyPNuJmQAAYvbg
Date: Tue, 31 Aug 2021 06:42:04 +0000
Message-ID: <DM6PR12MB4649C155AF79162498A189F991CC9@DM6PR12MB4649.namprd12.prod.outlook.com>
References: <BL1PR12MB5224B6190A449999EDE4BD35FBCC9@BL1PR12MB5224.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5224B6190A449999EDE4BD35FBCC9@BL1PR12MB5224.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-31T06:42:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7e15b15f-893f-42b1-be89-5fa2da7c3f1f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a2211c9-79ad-4173-30e1-08d96c4a7248
x-ms-traffictypediagnostic: DM5PR1201MB0249:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB02497AF870AE110967AA39AC91CC9@DM5PR1201MB0249.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LTlTZSnijcVXATdfuedT8YzLj+qK99/rieOU4z+za8Iw/GvBHM/Oe1on429tU+gIH6LRwZqSfMtweFlOxipM4y8L2nxrp9FGxiH+5sFqODjB0ylMZqKvItAmWvPTTCn19BVQr6xrP+z6VJAyR1LoIV8JiTcN38XL/1K/0ikpCIvG1zhK53UlmuaKIv3vOw+o0ojNULsktX1MMe4t1J63R3cGgli+gG4jnYtO57CBQ7I1Em7mb/jFWseJhTC5bBr8VKxzTX8LFDNSs4Frayrg+upj8t3EqlnZb4k3Co743Ci/bpqa6VfozZcmA5MHvsZ0SAkNCSaZfjVi2N+K48VSJDxRAwYMvtDJ1QHfbXnD6bXIbyLeUvGG8uvLP3nEeoxoaOVD9a0KyHTm8HBaTtpNB/vqNdjj8yKkMEHQCdFVzkdWSNWtZjqIgJu630wW6D2EeAPTyMIzOAEQ38q7aHVQI7xj39TOTyoF4LV9QClo3o38pIXpklj/Y/zRVXghwSxxicEnhLNtYBVDEF3aCufUwoDCqE4ezb/EkhPVWOBkcawvXAb/S4kBFNRkw5C/tCFDXfIVHf2+APRZi2GT5rzUC0Q/vEj8CD7PZo9t4UMbxMXH031YUZjl+MHln3nBszwGn7vFLhkFiR2lCBJgZgOWzosmMl7i4QOJXjYTnIWKIDn9+diFYVehQ71G7E5EtO+9zFGxkYjZnJNLSEkXW2bxgg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4649.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(55016002)(9686003)(110136005)(38100700002)(33656002)(316002)(86362001)(8676002)(38070700005)(2906002)(5660300002)(53546011)(8936002)(122000001)(478600001)(6506007)(66946007)(26005)(71200400001)(186003)(76116006)(4744005)(66476007)(64756008)(4326008)(66556008)(7696005)(66446008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pqvir4ugeud4G5LXP7APrAJ7uxULyNcv4ttbh5EyXuiJ5kY/KM+wG05Gjoep?=
 =?us-ascii?Q?EDQYTbScr+fDg2UaAHKKD6rKuCxSeaw5Ju330/e1bTOlAl7ybT1pvP4bzbxx?=
 =?us-ascii?Q?WMlbiDLEanvz2+sGBZN4fNeCtIeUcfmYmeaC9z/owkBIK+tYzhaeAOGe5+8N?=
 =?us-ascii?Q?N7/qCbahTGQ802mFFDnZtU9Y7v3ZXO/hGXP4gLjqEVPkOW9IUkoHy6Da2DsY?=
 =?us-ascii?Q?T8KTtJDhgROCe744qFaKLBMaL3CSzyhUEJFe55onbokpc0cWKXMUcsTAZ6v9?=
 =?us-ascii?Q?Oo4C9MvUH3uxSyvPhH0p/EDEcVnorBztxsOtdpr8UomMPiCZlwP18cCUE7n0?=
 =?us-ascii?Q?QnOVg8Z9gvX9InCktl8Ctbpq8JmmXA/sCSspty+MOENOyjV9guiY74uImFPp?=
 =?us-ascii?Q?8DKsWsYWLTyRU0QUCR+WN5gLLtle6c2AihYWvuwg+qgElmgKBCsNWo1d8q64?=
 =?us-ascii?Q?emLOcpPkYTxzjs3cBJ+Qv9YTKm7FIBsXyA3+m4ThuCALhuxbjfXCdYZsUftl?=
 =?us-ascii?Q?9OpggGanz4hn0c+BsOd+qcReba3XPPSbV5oM4I6+31J3y/GGMQU6vBedgWtA?=
 =?us-ascii?Q?mfckeuTpAauql1HHwYV9fahSusBbLT2Br1MRBBq5oIcQSWU73H6/2mfMQ/Re?=
 =?us-ascii?Q?C+N0UiOhEVcxTr3xkfhFAv8inIOG4QDHZwQ0ZaBH46ayqkavHKeqHOIHGpp4?=
 =?us-ascii?Q?6jcp4R49EiEJSEb8GCXkDM1AFzIegeUaLa8RmEJn+Yqyj2EC9XP7Oamz3MUt?=
 =?us-ascii?Q?18lCgg8jQ02m+gYtGvAsVTp1hpu/Prm3xh+0DzeOiHE1/ml6e/e60vQHva9y?=
 =?us-ascii?Q?mpo3d2km9+6Z0+eZk2ZjiWWprJCrQDzr4n+R2RL4iazJs2P/GpIjUUCWzWlI?=
 =?us-ascii?Q?ozb2xXgU6/r85n31BpZ4Rc7xbOqQ3P2OQatUohzvq4q5+NIMIehSP+STgLh1?=
 =?us-ascii?Q?UOZ1fAJhe+K1x/kypTVyXndCKEETiMcufLOn9Jf2S9Ius+QQAh/WlB0ieEtB?=
 =?us-ascii?Q?akF6nHHy+/7Lpwn956BBAR7X8HslxKCyyF73mzxPn7WLUFFqS8VT+QqyZK7i?=
 =?us-ascii?Q?u4ZvrePHASqmuIXrYeikdxVUNN8kRXCI3gQi8nX2DGwCKjHJIbjHUy4f5mV3?=
 =?us-ascii?Q?5gQoasX3Ayty7czj6Zwe2ckQPT/LwxW3l38OxtSdbuY87nhi5KTp/ycQ13iZ?=
 =?us-ascii?Q?HpXz8l31n5+PL1kKikNLZ8c3fwwaMT3rzM5qaTKXbnvP4ns4/N2rsVqToepF?=
 =?us-ascii?Q?CQwnP8OjgWVrS9DYtqqm8FaVIfpeiNz+7w9OE4Q391SjUGzc7czAnCY1SHvS?=
 =?us-ascii?Q?qKD8gN9rilV+0t2i4QzdFdF4?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4649C155AF79162498A189F991CC9DM6PR12MB4649namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4649.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2211c9-79ad-4173-30e1-08d96c4a7248
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 06:42:04.8760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OEUH3AFIHRGxDOSBZjtIqNQUEsauPdNkJtfoHlnyRO1C20xplS8evRJcwx0yhRn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0249
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

--_000_DM6PR12MB4649C155AF79162498A189F991CC9DM6PR12MB4649namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Candice Li <candice.li@amd.com<mailto:Candice.Li@amd.com>>



Thanks,
Candice

From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, August 31, 2021 2:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran


[AMD Official Use Only]

Submitting patch to resolve incorrect register address' on Aldebaran affect=
ing RAS interrupt handling

--_000_DM6PR12MB4649C155AF79162498A189F991CC9DM6PR12MB4649namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
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
<p class=3D"MsoNormal">Reviewed-by: Candice Li &lt;<a href=3D"mailto:Candic=
e.Li@amd.com">candice.li@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Thanks,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Candice<o:p></o:p></sp=
an></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, August 31, 2021 2:27 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to resolve incorrect register addre=
ss&#8217; on Aldebaran affecting RAS interrupt handling<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4649C155AF79162498A189F991CC9DM6PR12MB4649namp_--
