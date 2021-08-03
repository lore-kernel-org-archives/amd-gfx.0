Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3185C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 08:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD4460F48
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 08:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABD4460F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E07289CBC;
	Tue,  3 Aug 2021 08:20:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF1E89CBA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 08:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzqQSKqvJKtxJp/MYynkVcY8WIp1UIBKWgs79fKTcDV/2s3ZrVlQKjJmePryFSrkUYDu4flBb+GMwqnRtqNcqR7z7PF07xFG4nC3WXphOhutQGJtdjKQhGns4zJQcY0gECTf594L7X0ZOjoyk+g/hNB/+OxUHw8LWhZ9Sgl+cgtM9gRmZI0/r1pX0o7HzOpZ/yscEe31sgdwK920njr8612hzNF1uaYuNxNw28AsQD92bQDVuDlvfJmC8Hnj84QuGhT8oKlpNcK93Dj+MAQwLdmRXTOsoVh99hzvpy/q004SQiYfnX6DzwmATIKNODjVOpgDTx3W8t3auzKqlr7AJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsoCr+v30vmzIGkCPLuHnisy7qkmLvRaZqizD97FVrs=;
 b=Qkz9l/JibJXbI7agavcEPg3bs9juggRNCO5L/H4QTxlpSl2s+4mILJmfWaly3vQYnu+tI3e//NoCBrLFi2r1rCNbOvqwn2wczcsC/BCgnalT78WjN3sdsALCd0fU0t0XBPNrYtIWCT+jLywh79GWM8RcnbVPG6U/qVuT+h44a+4cWI1sX30R6pFK9lkNZnE53/AJqVNqOSRkPgnctyiyhMWLhOU1bdaqIXs24PN8W4wvdR7p/i/LPOTBy4l1Fo/W/HEG1l8UFIW4gs56+r7Oe+orqvbf7l/uHSPGIiCwwefcUch6+o79rA5M1eoLnOgck1iMZei4W3HPF+IbiaODTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsoCr+v30vmzIGkCPLuHnisy7qkmLvRaZqizD97FVrs=;
 b=FiCGFARQhYLiUORPJechxcwCySE1MON//AQjHq7jZ6+6sISYij7ZRlSeYeD2T2HKZTt00IRSr6lBRqK/GyeCWFOsmaoJORnHFH6DhLIc0YBGDf0R31PHIkWYcTeCc8uFTRjQkTHvtq/XLjKsbQ2xpnuzj4C9r4Y7MAov4OEEPoU=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 3 Aug
 2021 08:20:44 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89%8]) with mapi id 15.20.4394.015; Tue, 3 Aug 2021
 08:20:44 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update PSP BL cmd IDs
Thread-Topic: [PATCH] drm/amdgpu: update PSP BL cmd IDs
Thread-Index: AdeIQFfkuoNhZf2nTNObQvoGaKA3DA==
Date: Tue, 3 Aug 2021 08:20:43 +0000
Message-ID: <BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-03T08:20:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=76ee5ac2-7d7e-4b6a-b087-14fedbe772e0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba14910d-7647-458b-59c2-08d9565796b2
x-ms-traffictypediagnostic: BN9PR12MB5226:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB522679D5798E4D4EE8724566FBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /bVtl6nOyvR5R/v/1S0A2swdoxh3QwbX9q6PMdwhKgmbgt1oedc1UwtqrzSQJRFxNAHH9GOAptI9a5Lt6gYiRNPVxC3M94wYeWDjePm4tSblkBrPnbYW2NakyH6L6kwufOMJLRuJRIXpOgLxr+S1ktBuvlBnF1rxot4ghZ/uuX0a+ByDfjqjZBz23H/p2je+0PGcSxH6QEwt/uScmNeMN8XbyztCFe4NAgtK73VW058yMfLYhMcpSZXtC/l8vTk5EpCr/TOmSmV8wAc2yUphmSV9JTA9uWzAjz9T5kLotPa88BvCrNMlWBBUQ5FIlHioMJlXXt4o1rtu/6mLG7zYRaGMkuN/wrIvPjsmf0j2AWgaJNBHSyqypDgM+OOMAfbNo4oGNGXcxZYMd3E5DrDqGY+/1BegvVnn6qY8bbSK/1RQQPSh2HOhQ7JlR6G0dDvUxz5sHgo3JoxVQT1ABElqVdX/+7P+w28Z7LlxYKQIlCUrOn6BJwLvPngTCjcfAu5Oh77HP7mtJl6ASrGvdrgRaX1uuDoOKoHuMf8/qfJp873wNlixVttnoWMCR8qK3B/elP7HEnlgDw+UWTh1SCsS18N5Forp8KPBafpitPyi+dUtXmPe5MUZI5vLoVXnVqNM9V6MtXUm6rTkOgovilE8WcDpkCxKVvnylrkj+dYEGJP6zxfZdD636rg62yTW/J+L9OgXbHJkV9j51LxVOhobYw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(86362001)(8676002)(4326008)(71200400001)(8936002)(99936003)(55016002)(478600001)(9686003)(33656002)(52536014)(5660300002)(38100700002)(122000001)(2906002)(316002)(38070700005)(6916009)(26005)(6506007)(186003)(76116006)(66616009)(66556008)(64756008)(66476007)(66446008)(558084003)(66946007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y/O9d3c1LzUX+SRYcSALGmtJAKmFmczfswtBJWLmvYlfB4RahX2IfsMsc293?=
 =?us-ascii?Q?gqzTwzxLI8aaOMWKRBIghuzoSTwbGjE2XWAz1GggS6U2VIjbJL+8tEj2jV8E?=
 =?us-ascii?Q?QFUsbPWmeda7syKT2Gr81YIgHpzGbTfYhi6cHDlBBHtO544JcPhqtH6hSlxt?=
 =?us-ascii?Q?qXdZMfrbqDBHH7Wc7U1a9O+FXr77Wl3MXbWNRVRj427dkYG3Bane9o/mkxco?=
 =?us-ascii?Q?w1eaalHNE3zVp26whZVYSDEiRaI7t4SOIIOoP+bpU/jVcZjpyDiKyJl3wsNn?=
 =?us-ascii?Q?lXoMFAdFcvL9wAaMoyDNytrCK/LwpN56JfZ+4OqZls5ushPwuGbjqARij4Qm?=
 =?us-ascii?Q?0zvZ5mlAQiyuP6d9/S9fxQ7NUQ5HNVlE31OGI//QEBByAx9+aWvBoNZszhMU?=
 =?us-ascii?Q?pGCp4SGIkFkBS2kMEofL/RG8hVg+QEtNWFB+rzdnYbJSLeoi9CWtLOb/CNEj?=
 =?us-ascii?Q?HDZoVSdhPmyiquZuL8SuK1eDJ4FVpjtCA/tRot1d+ffIG+1Bjtxc37PCKrpQ?=
 =?us-ascii?Q?ZiG9KZio2HNDPCyyxxsT+vcczdsXeOgaRV6GHgx1TLDH/KXqnbVhc/nXTcCI?=
 =?us-ascii?Q?0OmdW1lFbW41JDgwxwdHXvVZzaY33DHRdvvVBmccIsgIOyWo23GwMLDS7ORs?=
 =?us-ascii?Q?0fAQcBttW3rXmJuVNNdOV7rO/3kVUGLnPeUnrwxbi3Sngqa5pMFREzkfUWQf?=
 =?us-ascii?Q?BprNNFC5gOWn7dvA5KBVF0byM2zJuvmdHfdHvXIxoN+maC+T+MfuurjbJFSU?=
 =?us-ascii?Q?QMKHtzrdU3tNXyaWcg/gnSSGm7u02TK6gbzsnx7aKYquvVrcQk88U0kB6sb7?=
 =?us-ascii?Q?BqdzKq6vksp1CAXiJ9r3+iduWczobG1/MuNgwSBHo8F9w6epvvwKdRcJ4Evi?=
 =?us-ascii?Q?B1cO6qPlJVW1M971BM4MQfObWMUDtg+TFzU988t2jWn0qvBLScmyCxZv4Qrz?=
 =?us-ascii?Q?kg2537w46RkFfp83xdsSbQtF5S8SIfPlmXAlAswCFHFYkjcivFiOazVIIs+9?=
 =?us-ascii?Q?VH1xK+0dccTqtUNpk1ugwLyAMclq4ZeZpY8km43WEi2dHAnwzq1oLiDmzQjJ?=
 =?us-ascii?Q?FO3sAYldKObQtwh1K3wQ62/BXgFw1SlxNHWbe5coNS7Kp2+XlKUS1GwnAzQ0?=
 =?us-ascii?Q?FFfhHFP3VKcxG2Jtp54DhD+Xn1yirWBK199ZtxhM/iaIpGNRsz5+UuLAuZgq?=
 =?us-ascii?Q?iQyF5MARpacIr4/ALb2Jc1Iy8ahsigugKZG/H0HcxARhYoq4XGVNfFIZTidu?=
 =?us-ascii?Q?juF8PHSdADelZQVeUyIITHmxySmliLT4KtXimVFAhSFs4vvoFdLjQpCEINnj?=
 =?us-ascii?Q?c9+akBar4PHZMsX1kuhcmC+5?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba14910d-7647-458b-59c2-08d9565796b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 08:20:43.8765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X56JL4SMyJUnIjSXhyqIrQkcpt1x4baucl2D1CF6oUoH6Ns/IkMmEW9to2uhZOUELM0j0Q1fd1n+L87KnIFfTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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

--_004_BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09BN9PR12MB5226namp_"

--_000_BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Submitting patch to resolve issue with incorrect PSP BL cmd IDs

--_000_BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09BN9PR12MB5226namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
<p class=3D"MsoNormal">Submitting patch to resolve issue with incorrect PSP=
 BL cmd IDs<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09BN9PR12MB5226namp_--

--_004_BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-update-PSP-BL-cmd-IDs.patch"
Content-Description: 0001-drm-amdgpu-update-PSP-BL-cmd-IDs.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-update-PSP-BL-cmd-IDs.patch"; size=1245;
	creation-date="Tue, 03 Aug 2021 08:20:00 GMT";
	modification-date="Tue, 03 Aug 2021 08:20:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1YzM2OGZmOWU5ZWRhOTg5YzQyODkwMGIxNzkwM2ExNjZmZmI1MTllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMyBBdWcgMjAyMSAxNjoxODoxNCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8x
XSBkcm0vYW1kZ3B1OiB1cGRhdGUgUFNQIEJMIGNtZCBJRHMKCnJlc29sdmVkIGJ1ZyB3aXRoIGlu
Y29ycmVjdCBQU1AgQkwgY21kIElEcwoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9o
bi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEljOTBiYWM2Y2Y0MjA5ZjJkNzY0ZTViM2I3
YzAwYjUzZDZkOGYwY2JiCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bz
cC5oIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bz
cC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oCmluZGV4IDQ0MzVi
MTgwYWNlMC4uNmIxNjQ1NTk4ZmEzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3BzcC5oCkBAIC01NCw5ICs1NCw5IEBAIGVudW0gcHNwX2Jvb3Rsb2FkZXJfY21kIHsKIAlQU1Bf
QkxfX0xPQURfU1lTRFJWCQk9IDB4MTAwMDAsCiAJUFNQX0JMX19MT0FEX1NPU0RSVgkJPSAweDIw
MDAwLAogCVBTUF9CTF9fTE9BRF9LRVlfREFUQUJBU0UJPSAweDgwMDAwLAotCVBTUF9CTF9fTE9B
RF9TT0NEUlYgICAgICAgICAgICAgPSAweDkwMDAwLAotCVBTUF9CTF9fTE9BRF9JTlRGRFJWICAg
ICAgICAgICAgPSAweEEwMDAwLAotCVBTUF9CTF9fTE9BRF9EQkdEUlYgICAgICAgICAgICAgPSAw
eEIwMDAwLAorCVBTUF9CTF9fTE9BRF9TT0NEUlYgICAgICAgICAgICAgPSAweEIwMDAwLAorCVBT
UF9CTF9fTE9BRF9JTlRGRFJWICAgICAgICAgICAgPSAweEMwMDAwLAorCVBTUF9CTF9fTE9BRF9E
QkdEUlYgICAgICAgICAgICAgPSAweEQwMDAwLAogCVBTUF9CTF9fRFJBTV9MT05HX1RSQUlOCQk9
IDB4MTAwMDAwLAogCVBTUF9CTF9fRFJBTV9TSE9SVF9UUkFJTgk9IDB4MjAwMDAwLAogCVBTUF9C
TF9fTE9BRF9UT1NfU1BMX1RBQkxFCT0gMHgxMDAwMDAwMCwKLS0gCjIuMTcuMQoK

--_004_BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09BN9PR12MB5226namp_--
