Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD450C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 08:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1486105A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 08:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C1486105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DF36E0DE;
	Thu, 23 Sep 2021 08:29:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0BD6E0DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 08:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9JXCfm23loPkRlsrV27D0aQ/PcoOsv5vhN4J6NCz93ItrYDJNpBDrxFDxQmsasjPKZQZR9HM9oVCrSiWBwa7Kk4hbzdH0TL49wxgn2H23TMsWka4nOi0zp0q2V66dgn+vXvVCabRAec61rXFPx2g4Cc6E72qnKiknKidAB4Duk8Vrt16kR1mW3sdgxIkP5rfN3vSzgzcvbePFmNR9+XZeEOzLIdTSe8ZEZ2tQoAj9Uqdfnp86ydz5+9LLEs7jBJIwFmIgW1ebzzPpr81m2MeLHByOOUsbbC/rLc9UtmmpvD+O5qM3+/0RaF9IOIZL2PrijANl4gL5iu5UmpH7ISuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Xj6XkdBnHmlqD9x1cLf4yiBaGzXRvazXgNaWCfOJe7Q=;
 b=VaMAVViLBvIied7JNs3PWt9cmm4RNXGWvIK0wkXyi+KB7IV1bhT0Iqv39w33eLuUo/px57sprK0tWrKxdek8z3rS41mLncGGMFRHmc5xCjVI3UzlAnBOETp/+Adql62CioTkWMoxm7E6iPpNCj4drFG/EMx0WGcksf4dIe2E1wGT0CNbGpxKTjEMgxiFZ53HmYMjGkyyx1vMGqtZdhrNbVupDmDYjXE5zrVOUomfhFdGuGuSrIxItgcPeBekG9yc7drP7MEVmz6TEY+ErUii/jw9CJEMgVLSK03IG/8R507lfFjjQBF17UWcdVG2bp/gVupmeTqqYKlwiWVbVi/kaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj6XkdBnHmlqD9x1cLf4yiBaGzXRvazXgNaWCfOJe7Q=;
 b=2HAVIRJKlhe9onxx6uHUMAmlS159pCFarq26jokUH8WSfAVMqHWHvQd3vk4aUfLh6y7P7MMrzNAIqHBx6W6CzkAYlrZ6X/UqYDKm6h01iWhTbSZjyBYPugGrerhmERgp7slU7oRZyIk2wb4oJZb3bTP+Jd+KWjhagRa03S8v2PI=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 08:29:45 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4544.014; Thu, 23 Sep 2021
 08:29:45 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Consolidate RAS cmd warning messages
Thread-Topic: [PATCH] drm/amdgpu: Consolidate RAS cmd warning messages
Thread-Index: AdewVRRPJn7b+HXdSjuE4UMuNi8xqQ==
Date: Thu, 23 Sep 2021 08:29:44 +0000
Message-ID: <BN9PR12MB52261DD3067B1F6747731B9EFBA39@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T08:29:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4c4f64c4-0ac6-424b-af8c-0e39fc797825;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7306433e-2c0d-4c05-9888-08d97e6c4c41
x-ms-traffictypediagnostic: BN9PR12MB5065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB50654DAC2C8EF5AFB704633EFBA39@BN9PR12MB5065.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:95;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yWNvSL3MpBwEyf3AzvXdrwIzzI4d+s/anE4+t1GLM1DrzJcSnPCGBycca2DRsdpBzP9rtzlaWIXF1AEhGlxPO6zq9MO5DkyQn+MNfTts4/zi2tw52PjROewP6y+6qHpb61fGi7tDNSTqFCoi/39VwPzSdcSjpfxvG5RwUXze5nqOqE6Ep+0x5GotNNRuNN0mA7wPfY2idSd2/7qhmbj71YopRpCaNxKH7tdATuM8uaubFoGj8cLd9/KjDmid/SH6rb2dYxgRUZxG5CfOUZuFNsqH8Bv39THzPGj9yu7qNKAZKuYeAfKpA72qbTqOYo7gYcHWnSGAlRl5GYR/UrzOKX/qoeDscovwVKKglfukw0FeVwpbHnL3T9Icvfk2U+wq6rJL1ZWdsN75l2yFtq7ll2Ea95qewfXzw1/drfn24PRkaZ/p6TMQSFgeqDfDitO1Q1SXrLRGwWwmurUDK44X1aCC1oJlv1rvTczBCU/NC4yB5WES5eT4OLX/rAz17l09QIj3Ajh+AjJFFyKPUbb7dLEyTP14XMkNKJvCMMDayRyqPEDCF6KrVYqT+KsR8FvzcMeE7zv5L/RHLMglUrrlB+A6uRMEfUVHRspHoyYxSi/zmmC+qnU/CbNHFn/vcjjmZNOCE7aZNnlUqf331JcNzI9aaHVtzvu3SGu95SOjpIiI2KiEQ7II/jCGnqddTVXU+CPIN/zXNDWvx2KDq/H8VQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(508600001)(66556008)(66946007)(64756008)(66616009)(66476007)(110136005)(66446008)(38070700005)(7696005)(55016002)(558084003)(5660300002)(83380400001)(6506007)(8676002)(76116006)(8936002)(71200400001)(99936003)(86362001)(33656002)(26005)(9686003)(2906002)(38100700002)(186003)(122000001)(52536014)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LETaZj34Bq1Ky8OImtYkcDpeN3X6L7bDO1t2m+fUPT4Bt+Pw+ur5m8Fk1xFq?=
 =?us-ascii?Q?BFgpy91MUUaumBt8b56gajPZXjfBsMT6L/5XDdmMNUaDI1D3Il0D8VtvLknX?=
 =?us-ascii?Q?j4NXIgvGMDUgdhwi/YskQT7pNvHk1bvAcfuoWhFnDl+DmwL+PAA/vqCPpYRE?=
 =?us-ascii?Q?DxzWaR8wjTkr5D5/mdI81YBKXTInOMagaccOTh7xPPKulgAo3SK5sgNJPv9i?=
 =?us-ascii?Q?Ejx+cWD1JA44U8W/d4M8Pp1rxl5OGaM8WuHrk0fgBjPGMpDOvqRzqaJFY3AX?=
 =?us-ascii?Q?kyUvuPfvU1j/f5T8qzVANSD0UqQWAnjk6XOOIuLkcM7aiMF+t0748b7axkro?=
 =?us-ascii?Q?AHslHYKlNWkMBVh4DYYtLXjoqFvgxPW/93pDpKH2FdoSYPpDzZLyGJQarFHg?=
 =?us-ascii?Q?gZyucKF3knhujlcEXalzXv7kifkzDscbuvWKgXCJKa1At62RJykamL/L1Xzu?=
 =?us-ascii?Q?rfS9US5mUWRrNBAQC6IM/f70lVpXmg2DWDrXD8tsDGBfjIFHZaoMjm0VhcDs?=
 =?us-ascii?Q?G/ZuE4BAgo+QfxXc7sTvX22nT7shqNxFlBhU+FHwNVmiJEftMqCfilMnHnbJ?=
 =?us-ascii?Q?zAW66P2XC4sxBIJIdQO/cMvoxtQ11DdjpngiU19GgUddzRnY0kQW+1BkPxPS?=
 =?us-ascii?Q?qvjO2brwofCeffN8famvBYrRLxnpPrsST+m5hXRNnsAbK5QhwUzwOfNQkK//?=
 =?us-ascii?Q?glXXqppQxaEbBpJBdktnETQRZXAxx+gMOoRllYEtGQyyIrIU8chxbKSNsrzy?=
 =?us-ascii?Q?rfxOU11QVkibJPt6BSQt91L2VIDazJNiPA5vsEeZ2dcr9umKSR7JbWyNaDaX?=
 =?us-ascii?Q?vEsptdxW3D4fc4QCP0mNLca+01BPL5a7/VajQ+qRjJ8h5XTF207KSe/8cNa0?=
 =?us-ascii?Q?1zZHAVIzwYRJKUMvU/W2aRqdE1iAhqsDVjPzW3TruzHnuiOUkxn5JykMrX2K?=
 =?us-ascii?Q?Ii3/eKjih89P4KPVpMrz9cUp/Ve2Jyym7DhqepTrb443RZsXymEPJjQk0nLE?=
 =?us-ascii?Q?p1BqJKLhr1Hl1AOhQ4Pk1tOjE7iQyvwMklPZYluq01xB5phI46uF9Qpz0dBt?=
 =?us-ascii?Q?+LTq90UZ8jhv9xAUIbC6u1tbK23FDbbIwj/VnDRmfQD935vX8SbW5xQ9Sbq7?=
 =?us-ascii?Q?GnSwEUVmfUwDFFO0PvmyMSbfg8e8lCUMw2cBM7ri3DPHEZbC96AIsh1BcChX?=
 =?us-ascii?Q?6WsFFUrer7JG7QFNKlqTOQxYKMtTauIQhx367zswYgu+Q8y35VfVvMD9/FmO?=
 =?us-ascii?Q?0hlHljAYF8SEzk/IE8PkRMsXs5qDKpUjkqEEmDZrojKCmz4ajA0osuJqvWc5?=
 =?us-ascii?Q?FlRGIY5BaA8kezwIpzQCPR+x?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB52261DD3067B1F6747731B9EFBA39BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7306433e-2c0d-4c05-9888-08d97e6c4c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 08:29:44.8559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dv1QKxqXjWYpXe6ba8tEO9BpK92/JzdCcIg17xXVECALrAnC2Lhfk/oPhSCLtKAb/eGdWRjqfV8FctRSafEhjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
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

--_004_BN9PR12MB52261DD3067B1F6747731B9EFBA39BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB52261DD3067B1F6747731B9EFBA39BN9PR12MB5226namp_"

--_000_BN9PR12MB52261DD3067B1F6747731B9EFBA39BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Submitting patch to explicity post warning if RAS cmd is issued against uns=
upported IP

--_000_BN9PR12MB52261DD3067B1F6747731B9EFBA39BN9PR12MB5226namp_
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
<p class=3D"msipheadera4477989" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to explicity post warning if RAS cm=
d is issued against unsupported IP<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB52261DD3067B1F6747731B9EFBA39BN9PR12MB5226namp_--

--_004_BN9PR12MB52261DD3067B1F6747731B9EFBA39BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Consolidate-RAS-cmd-warning-messages.patch"
Content-Description:  0001-drm-amdgpu-Consolidate-RAS-cmd-warning-messages.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Consolidate-RAS-cmd-warning-messages.patch";
	size=4569; creation-date="Thu, 23 Sep 2021 08:29:00 GMT";
	modification-date="Thu, 23 Sep 2021 08:29:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjODU0ZDNkM2Q5ZTcwYWU0NzMwMTc5MWNhMGM0NGM2NWM1YzY2MzkyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgMjMgU2VwIDIwMjEgMTY6MjY6MDggKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogQ29uc29saWRhdGUgUkFTIGNtZCB3YXJuaW5nIG1lc3NhZ2VzCgpFeHBs
aWNpdHkgcG9zdCB3YXJuaW5nIGlmIGNtZCBpcyBpc3N1ZWQgYWdhaW5zdCB1bnN1cHBvcnRlZCBJ
UAoKVXBkYXRlIHRvIGxhdGVzdCBSQVMgVEEgaW50ZXJmYWNlCgpTaWduZWQtb2ZmLWJ5OiBKb2hu
IENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSTk4ZTc1ZjBmODlk
ODliYzYzYjQ2OGQ4OGJiMDJjY2FlYjNhMTY3NWEKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMgfCAxMiArKysrLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdGFfcmFzX2lmLmggIHwgNDAgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQogMiBmaWxlcyBj
aGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKaW5kZXggN2QwOWIyODg4OWFmLi5iNzEyMWJmZGE4YTQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTEzMTEsNiArMTMx
MSwxMSBAQCBpbnQgcHNwX3Jhc19pbnZva2Uoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIHVpbnQz
Ml90IHRhX2NtZF9pZCkKIAkJZWxzZSBpZiAocmFzX2NtZC0+cmFzX291dF9tZXNzYWdlLmZsYWdz
LnJlZ19hY2Nlc3NfZmFpbHVyZV9mbGFnKQogCQkJZGV2X3dhcm4ocHNwLT5hZGV2LT5kZXYsCiAJ
CQkJICJSQVMgaW50ZXJuYWwgcmVnaXN0ZXIgYWNjZXNzIGJsb2NrZWRcbiIpOworCisgICAgICAg
IGlmIChyYXNfY21kLT5yYXNfc3RhdHVzID09IFRBX1JBU19TVEFUVVNfX0VSUk9SX1VOU1VQUE9S
VEVEX0lQKQorICAgICAgICAgICAgZGV2X3dhcm4ocHNwLT5hZGV2LT5kZXYsICJSQVMgV0FSTklO
RzogY21kIGZhaWxlZCBkdWUgdG8gdW5zdXBwb3J0ZWQgaXBcbiIpOworICAgICAgICBlbHNlIGlm
IChyYXNfY21kLT5yYXNfc3RhdHVzKQorICAgICAgICAgICAgZGV2X3dhcm4ocHNwLT5hZGV2LT5k
ZXYsICJSQVMgV0FSTklORzogcmFzIHN0YXR1cyA9IDB4JVhcbiIsIHJhc19jbWQtPnJhc19zdGF0
dXMpOwogCX0KIAogCXJldHVybiByZXQ7CkBAIC0xMzM5LDkgKzEzNDQsNiBAQCBpbnQgcHNwX3Jh
c19lbmFibGVfZmVhdHVyZXMoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsCiAJaWYgKHJldCkKIAkJ
cmV0dXJuIC1FSU5WQUw7CiAKLQlpZiAocmFzX2NtZC0+cmFzX3N0YXR1cykKLQkJZGV2X3dhcm4o
cHNwLT5hZGV2LT5kZXYsICJSQVMgV0FSTklORzogcmFzIHN0YXR1cyA9IDB4JVhcbiIsIHJhc19j
bWQtPnJhc19zdGF0dXMpOwotCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTE0ODQsMTAgKzE0ODYsOCBA
QCBpbnQgcHNwX3Jhc190cmlnZ2VyX2Vycm9yKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLAogCWlm
IChhbWRncHVfcmFzX2ludHJfdHJpZ2dlcmVkKCkpCiAJCXJldHVybiAwOwogCi0JaWYgKHJhc19j
bWQtPnJhc19zdGF0dXMpIHsKLQkJZGV2X3dhcm4ocHNwLT5hZGV2LT5kZXYsICJSQVMgV0FSTklO
RzogcmFzIHN0YXR1cyA9IDB4JVhcbiIsIHJhc19jbWQtPnJhc19zdGF0dXMpOworCWlmIChyYXNf
Y21kLT5yYXNfc3RhdHVzKQogCQlyZXR1cm4gLUVJTlZBTDsKLQl9CiAKIAlyZXR1cm4gMDsKIH0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3RhX3Jhc19pZi5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdGFfcmFzX2lmLmgKaW5kZXggODJkOTU2ZDE1YjU0Li5k
ZTI0YTBhOTdkNWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3RhX3Jh
c19pZi5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3RhX3Jhc19pZi5oCkBAIC0z
OCw5ICszOCw4IEBAIGVudW0gcmFzX2NvbW1hbmQgewogCVRBX1JBU19DT01NQU5EX19UUklHR0VS
X0VSUk9SLAogfTsKIAotZW51bSB0YV9yYXNfc3RhdHVzCi17Ci0JVEFfUkFTX1NUQVRVU19fU1VD
Q0VTUyAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDAwLAorZW51bSB0YV9yYXNfc3RhdHVz
IHsKKwlUQV9SQVNfU1RBVFVTX19TVUNDRVNTICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4
MDAwMCwKIAlUQV9SQVNfU1RBVFVTX19SRVNFVF9ORUVERUQgICAgICAgICAgICAgICAgICAgICA9
IDB4QTAwMSwKIAlUQV9SQVNfU1RBVFVTX19FUlJPUl9JTlZBTElEX1BBUkFNRVRFUiAgICAgICAg
ICA9IDB4QTAwMiwKIAlUQV9SQVNfU1RBVFVTX19FUlJPUl9SQVNfTk9UX0FWQUlMQUJMRSAgICAg
ICAgICA9IDB4QTAwMywKQEAgLTU1LDcgKzU0LDEyIEBAIGVudW0gdGFfcmFzX3N0YXR1cwogCVRB
X1JBU19TVEFUVVNfX0VSUk9SX0dFVF9ERVZfSU5GTyAgICAgICAgICAgICAgID0gMHhBMDBDLAog
CVRBX1JBU19TVEFUVVNfX0VSUk9SX1VOU1VQUE9SVEVEX0RFViAgICAgICAgICAgID0gMHhBMDBE
LAogCVRBX1JBU19TVEFUVVNfX0VSUk9SX05PVF9JTklUSUFMSVpFRCAgICAgICAgICAgID0gMHhB
MDBFLAotCVRBX1JBU19TVEFUVVNfX0VSUk9SX1RFRV9JTlRFUk5BTCAgICAgICAgICAgICAgID0g
MHhBMDBGCisJVEFfUkFTX1NUQVRVU19fRVJST1JfVEVFX0lOVEVSTkFMICAgICAgICAgICAgICAg
PSAweEEwMEYsCisJVEFfUkFTX1NUQVRVU19fRVJST1JfVU5TVVBQT1JURURfRlVOQ1RJT04gICAg
ICAgPSAweEEwMTAsCisJVEFfUkFTX1NUQVRVU19fRVJST1JfU1lTX0RSVl9SRUdfQUNDRVNTICAg
ICAgICAgPSAweEEwMTEsCisJVEFfUkFTX1NUQVRVU19fRVJST1JfUkFTX1JFQURfV1JJVEUgICAg
ICAgICAgICAgPSAweEEwMTIsCisJVEFfUkFTX1NUQVRVU19fRVJST1JfTlVMTF9QVFIgICAgICAg
ICAgICAgICAgICAgPSAweEEwMTMsCisJVEFfUkFTX1NUQVRVU19fRVJST1JfVU5TVVBQT1JURURf
SVAgICAgICAgICAgICAgPSAweEEwMTQKIH07CiAKIGVudW0gdGFfcmFzX2Jsb2NrIHsKQEAgLTc3
LDggKzgxLDcgQEAgZW51bSB0YV9yYXNfYmxvY2sgewogCVRBX05VTV9CTE9DS19NQVgKIH07CiAK
LWVudW0gdGFfcmFzX21jYV9ibG9jawoteworZW51bSB0YV9yYXNfbWNhX2Jsb2NrIHsKIAlUQV9S
QVNfTUNBX0JMT0NLX19NUDAgICA9IDAsCiAJVEFfUkFTX01DQV9CTE9DS19fTVAxICAgPSAxLAog
CVRBX1JBU19NQ0FfQkxPQ0tfX01QSU8gID0gMiwKQEAgLTExNSwxNyArMTE4LDE1IEBAIHN0cnVj
dCB0YV9yYXNfdHJpZ2dlcl9lcnJvcl9pbnB1dCB7CiAJdWludDY0X3QJCXZhbHVlOwkJCS8vIG1l
dGhvZCBpZiBlcnJvciBpbmplY3Rpb24uIGkuZSBwZXJzaXN0ZW50LCBjb2hlcmVudCBldGMuCiB9
OwogCi1zdHJ1Y3QgdGFfcmFzX2luaXRfZmxhZ3MKLXsKLSAgICB1aW50OF90ICAgICBwb2lzb25f
bW9kZV9lbjsKLSAgICB1aW50OF90ICAgICBkZ3B1X21vZGU7CitzdHJ1Y3QgdGFfcmFzX2luaXRf
ZmxhZ3MgeworCXVpbnQ4X3QgcG9pc29uX21vZGVfZW47CisJdWludDhfdCBkZ3B1X21vZGU7CiB9
OwogCi1zdHJ1Y3QgdGFfcmFzX291dHB1dF9mbGFncwotewotCXVpbnQ4X3QgICAgcmFzX2luaXRf
c3VjY2Vzc19mbGFnOwotCXVpbnQ4X3QgICAgZXJyX2luamVjdF9zd2l0Y2hfZGlzYWJsZV9mbGFn
OwotCXVpbnQ4X3QgICAgcmVnX2FjY2Vzc19mYWlsdXJlX2ZsYWc7CitzdHJ1Y3QgdGFfcmFzX291
dHB1dF9mbGFncyB7CisJdWludDhfdCByYXNfaW5pdF9zdWNjZXNzX2ZsYWc7CisJdWludDhfdCBl
cnJfaW5qZWN0X3N3aXRjaF9kaXNhYmxlX2ZsYWc7CisJdWludDhfdCByZWdfYWNjZXNzX2ZhaWx1
cmVfZmxhZzsKIH07CiAKIC8qIENvbW1vbiBpbnB1dCBzdHJ1Y3R1cmUgZm9yIFJBUyBjYWxsYmFj
a3MgKi8KQEAgLTEzNiwxNCArMTM3LDEzIEBAIHVuaW9uIHRhX3Jhc19jbWRfaW5wdXQgewogCXN0
cnVjdCB0YV9yYXNfZGlzYWJsZV9mZWF0dXJlc19pbnB1dAlkaXNhYmxlX2ZlYXR1cmVzOwogCXN0
cnVjdCB0YV9yYXNfdHJpZ2dlcl9lcnJvcl9pbnB1dAl0cmlnZ2VyX2Vycm9yOwogCi0JdWludDMy
X3QJcmVzZXJ2ZV9wYWRbMjU2XTsKKwl1aW50MzJfdCByZXNlcnZlX3BhZFsyNTZdOwogfTsKIAot
dW5pb24gdGFfcmFzX2NtZF9vdXRwdXQKLXsKLQlzdHJ1Y3QgdGFfcmFzX291dHB1dF9mbGFncyAg
ZmxhZ3M7Cit1bmlvbiB0YV9yYXNfY21kX291dHB1dCB7CisJc3RydWN0IHRhX3Jhc19vdXRwdXRf
ZmxhZ3MgZmxhZ3M7CiAKLQl1aW50MzJfdAlyZXNlcnZlX3BhZFsyNTZdOworCXVpbnQzMl90IHJl
c2VydmVfcGFkWzI1Nl07CiB9OwogCiAvKiBTaGFyZWQgTWVtb3J5IHN0cnVjdHVyZXMgKi8KLS0g
CjIuMTcuMQoK

--_004_BN9PR12MB52261DD3067B1F6747731B9EFBA39BN9PR12MB5226namp_--
