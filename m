Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED8C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D786101C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8D786101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3BF6E526;
	Thu, 26 Aug 2021 07:05:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 363B76E526
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 07:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWM7QdMblLpIcpapGnlGEW/NneGh7wsVE5Ld2ac+F4SWLQEWhAGSGD06gFGMmTEEpnf0FiUf5cWH0xrKEpf6CCNRtpBZV8wcR+YLiAsr6/6fx9EluW3AaC3082WUf7dT0hkOL8u66uSeSnEQP5oEAOZJlh9DB30NtAwU6Qryw+aUZO04wH12b97yCHzW0wICSFoawM8OZvVPSS8IUH3Plgh56OK1FTtht2flshhl9GgianqhxQFGuCROdOTm6BrzA93Sbhz+eapMR35DV9JbB4B3iT7Cgp55LodRR+Fq313Kxstma7fQQiGt1s+oPzjenkXO3IrXpU+0J+TUSk9ynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLt6QObwphNfAwoNzSuk2bC13xKQHorRhR2XSNRBSrU=;
 b=WGazKqR1nJlcMFJBxfH2HZNmXbVGH+ZkKJVkWtGSkU0561BG+gPHWKnIpOxe+qmHWmOJq56LeobTAwAudGOCZ99/VCBGEZ8Akcw2kaHPV6OvwZn2wVIDOGUG0w0sZYXBsn0p62BhGhVzWpee5hlXhkG86iurquUp8AgB77eaTK7tWvpxvAab1igxpw6DP5HlZVz6OJoDmlrSOW2ZtEeK8hFH+o17iW+KqMVpj//hGrWg/EuJlD66XZNGBjcOl0ABnZjziME3Ys1K0W6jhHRzIEFBomjggaRepGr3JqP+0/DK3FjC5ZlYY7VNphcHUAdiimmj+FZHQi1XP5AqZOap+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLt6QObwphNfAwoNzSuk2bC13xKQHorRhR2XSNRBSrU=;
 b=srNc6fsPS2nMOWHtWi8rsWXhQqZ0P/RbpyD2YmPwCp6UXL3pUPm/CvRud+ToCTxBrkJU+odjuxENbg6ECKQxqauC2fRAflxuP6e9DDTywLooZmBziDZpZpujJG4JxATCvLJ3rS+cQ/hg2qizxxlhLCgrAPLb2K77NtO/cAPcMJ0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 07:04:57 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%8]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 07:04:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran
Thread-Index: AdeaRyK7+vwn47CGSriA5htBiDwSkwAAX/WQ
Date: Thu, 26 Aug 2021 07:04:57 +0000
Message-ID: <BN9PR12MB52577B7EB8959FBB10E026C2FCC79@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <BN9PR12MB52260A8475665CD687D384F4FBC79@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52260A8475665CD687D384F4FBC79@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-26T07:04:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3a689579-4854-4e8d-963e-b4f9ee8c6fd7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 336e061c-230a-434c-bb17-08d9685fd050
x-ms-traffictypediagnostic: BN9PR12MB5275:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5275EA523A9A4E3B4AB6D7F8FCC79@BN9PR12MB5275.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g90G6aiq39y01If2rghRGWdiaeLAfK7cdcktIFCE/7ddKBnr94GzPK0XCJ98RRVF3Sxfz05C4hSkZbw1AJsKuE2heMyHDFmh4pJj8ZVepN1FNMWwiHyhzzKEjdI8383w2fdVJTLCOT/r6UNMq2yJqDwN1l9eQRocla9OI0mX3Bur6vNPxRL03gE+kA85UhvXarK8M2SLD5OkFvulYoEE5M4smrIKZW+DWkXcs29R0FLOhMvsT3qz1Nwtzxi3RszPFzUiMxRgCtbiEl/hv4OXudmuLMYCyxJ4enjJm8OMaTL9CP3ds4+rTmPZgtIA0ha9La+uhPrrV46A/vYB/1GU1bvgLLbAt+RYqXy/GiWfuA+N08GKB13dI4BQRbp4SuuM0YwxG7kxlvWkVZTBQCCNHuDUUlS7rlESJMwTr7QDVBzx3cYf4rVU5/bA8X3NrXmxEvXb7oxY+KAo3B7Wme4y8ENhExKIt7atqifsfU973cZ+ipcInaCLhGispTCqdpmxow+cOunNa8r6u8eil8R6N6F/rcCg/XSiiAp2Xe1UWCsh1/GDrEIaQlNbShfhoZozFwRAEQ19tYLB30L0xf1DkjjKfXeyGo7XISo6dfeSZdv8ZrJ7vT/kC6d8gz1vpM5nFfMAokEKSV+WCVqLn1Hk7JrhsK/r5GxW1bQRO91heukfTDz7meeF9NQ3+o8/NF49ZW3W+AQJRD7Qg/N7hfJfPQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(55016002)(2906002)(9686003)(76116006)(8676002)(52536014)(8936002)(66946007)(66476007)(66556008)(64756008)(66446008)(33656002)(86362001)(5660300002)(4744005)(26005)(38070700005)(478600001)(53546011)(186003)(6506007)(38100700002)(122000001)(316002)(71200400001)(110136005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZHT3qIADKoFSEAYWGmpWJIT4Sy1r0/5lQMZlQS9Rpw4rs0nPpAkwSbrgjHcO?=
 =?us-ascii?Q?sWWitqoR3GbgwozlXEmqVlaU8H2MZ1/Uzl6+JDJVqqp92IjSs7vtbLzGcxF8?=
 =?us-ascii?Q?olTjTZYzr6gKc0KawEtjWQs86hthh6yVXk1DUELdxGfb7ghWyZa4NDTGUV4+?=
 =?us-ascii?Q?aDuQgOK0mNrlz4wuWdkh2YJdzBi8eW5ayYX1G+Q8UUeVKJsa4dzvMvPXk8kT?=
 =?us-ascii?Q?MWrVDbWZQSiBH9WhcOhOoc0iiX5P2a7mPNeI27nBCvBWWUdzV0uvgjvuNue2?=
 =?us-ascii?Q?7qdMDDqZyeDEjQOUMFCoBpB7By6KTomBCWspYlH6MR92PUL2UY/kT/JPhYEp?=
 =?us-ascii?Q?6dSKVsdXjMwhXsGRxFpboeYnyn1oBaeyw+nUF4T2u/DNmWem2/3QDGQhqaQl?=
 =?us-ascii?Q?Vpegeq/f1Qzo7xhfBVjLo/2v4ajTAn8U0BmmPfnKll/6r/xRarjci8k4lW+N?=
 =?us-ascii?Q?0YZjBl/nIIxT/w12zGeQLSead6NgZdn/rQGw3//ku9/rEddOxeGxafIvzmgU?=
 =?us-ascii?Q?ZpiBNwI/hDiozwZ3poGW5zXVGsFyUJ1SWgPTmFvdEsNtoXB53X4FtK/R6WkZ?=
 =?us-ascii?Q?Bzjn8UgzhxUZayjpn0s1k49JoCaaFtzOIzxPoQgr8k6zwAApmDutE8ozdvyo?=
 =?us-ascii?Q?9lyGFcet+OVuswGXtS0nh3UDcxabWpWn4wTMQ+FZP4hly3x7OvPOIMICQkUX?=
 =?us-ascii?Q?BPJM83T18Tj1Tm0E2q9hSYCvnUATqdhIVNlOULKvznmR6Ez/E9kz45JYxu8o?=
 =?us-ascii?Q?293+8FlBf6i3JYDrWoED/aMMblnDBfIpZXgoBIMxx7EBsjbDqJmhNbocVjSA?=
 =?us-ascii?Q?1tsPp7Y4jSSSArfM6x98Jjc2+kniZ8C0LMFVcaqBxzonO6cHYouq+d0RGo1h?=
 =?us-ascii?Q?AfheAet7XXfLteNSaGbtWVPG42Tchb5MVllwzvX/1+OQiHbx64EnN7qA5+6m?=
 =?us-ascii?Q?yD8OUlBBi3oFzJhunBEsNGVyZg8vjErj3ITOF8ZHfp9w42daszhBOUI6L3L5?=
 =?us-ascii?Q?hnyjipw8D+1f9V6vpH1Mbm7oyZIQWyYn2ZUOxmwgb6oFhcXrYZX+aIOtJBdN?=
 =?us-ascii?Q?Eqd2UEacp0ix07cvH1L0Cw+BkE0j9C92PiiNJSyXVNLTBZcq6WOOqfT5/Ybg?=
 =?us-ascii?Q?+Lf5cZXEVK1MahtAjDwCyML6q/FmeAP5bgYuVI58ZLOPfFB/BTKaRuU6PRVk?=
 =?us-ascii?Q?wHOLw9iovuqlqMbn17c696fw3IlA83i2eZaoCVYfl0cWiE6D55Cy/L+gcmh0?=
 =?us-ascii?Q?/esrFOzSo6CjYJl6C4vBn7DgJxktxcT+y1E1rTZrSDPrSFRrcj/ntXiO0efM?=
 =?us-ascii?Q?akBQBwDkdzjq1fMdW0DeFxeV?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52577B7EB8959FBB10E026C2FCC79BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336e061c-230a-434c-bb17-08d9685fd050
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 07:04:57.4186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfj6d5D3e0S0KP3Eb/024vENZiNuDlqwlkj5KlsokgJPcSyyqlr2uo4XeJDZ4tz9pwInpCveeXEYRs4CaeCF/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
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

--_000_BN9PR12MB52577B7EB8959FBB10E026C2FCC79BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, August 26, 2021 14:55
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran


[AMD Official Use Only]

Submittng patch to resolve issue in clearing RAS interrupt on Aldebaran.

Thank you,
John Clements

--_000_BN9PR12MB52577B7EB8959FBB10E026C2FCC79BN9PR12MB5257namp_
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
<b>Sent:</b> Thursday, August 26, 2021 14:55<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Clear RAS interrupt status on aldebaran=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submittng patch to resolve issue in clearing RAS int=
errupt on Aldebaran.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB52577B7EB8959FBB10E026C2FCC79BN9PR12MB5257namp_--
