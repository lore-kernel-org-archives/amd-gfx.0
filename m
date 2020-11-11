Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9FCC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 08:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE55320678
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 08:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aEQTqv9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE55320678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1025A89FEC;
	Wed, 11 Nov 2020 08:53:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305B889FEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 08:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFTyKmJ4tW188Q6///2sTI0VGdDEx47CwT81pZw9QGijHhHGvMfcrYzeb5lQd8kbi3XDglW93EE1J7nMHnvX2hQBVKEAYmZ1Gwzoi8bFu2ZW0hxodkpWuF2EfZk7ov4ZkhZDyuH8B+fI6w6AX+lvcVRt2R1Rco+vQpvMu7mDCM5c3mpTXglJPLUr+0oLO4gLEaGvbRKU6sROtu4ZlKQ2eExcLgoKz73O+GmClPuMJ/0P2CwcUVDNIUDAgO6iyJL0CBo/SHGzQgUsuMhwYQqMttJenW5euUKDZCf+W6E4Apcrli16NIFFbXL7DVARhbzFa84Agjp0VQPH8A6rwZQDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7pt8hOU+cycYTeXQznjO1h3Y7+q+ZN1ONEbrGHJWWU=;
 b=b8JrBmm+B3U4mcDiV+uCJRVZ7CV2vaCh4Jnh08hAMXWnWXfY81665NqOVRWqkh9r3dcGItk6X+AouKgyS5OPN7cDj8H3+3fjJqI41Qn+yBUZ5F0o2jnPacFW2YWQFSBajESMrlEYQM3SC5uwrc7TxuCauXBh4JnvcWgkJo83tFluXEafhwFRDRFCHiu9wAKi1N2oMBlPkYe9FQ7/faALmV0uyGtDcfA2x4eiDXKrSr9AdMSdEIflvE/eT0eb6DMDsxsYJQ15wggMiY1xPBETIh5jyMJ9BKwu68Fq9TkZ0BI0xmVeIq+9mqsGr/svHD3k6LdOYLm6eRyL9NG7vBLM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7pt8hOU+cycYTeXQznjO1h3Y7+q+ZN1ONEbrGHJWWU=;
 b=aEQTqv9oMfXA5tiRvOvPCxGE6tfW2BH6xwgIu41Y1iatlEoGEd8WvR0kgLLZcYU+4i9eng9ymYAdkxDyHHnH7Rs3OTcgwLsx+Emb6Msx+Tt6aXLc+VEAnihG36dCDQVHlLS6tfWDq8hYfhfS3gfFMOizbsXB/tL1iqVMvEqZN7g=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4845.namprd12.prod.outlook.com (2603:10b6:208:183::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 08:53:44 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::c535:c5bd:8c12:6b63]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::c535:c5bd:8c12:6b63%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 08:53:44 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add UMC to ip discovery map
Thread-Topic: [PATCH] drm/amdgpu: add UMC to ip discovery map
Thread-Index: Ada4CAgug+1uArCgTMS+gFznKiJcWg==
Date: Wed, 11 Nov 2020 08:53:43 +0000
Message-ID: <MN2PR12MB403229B5319EAC6A7B8594F0FBE80@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-11T08:53:36Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=557a3daf-e205-4e9c-885d-000084465f45;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-11T08:53:36Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d8f70787-9795-4b05-a808-0000157a9cdb
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ae8bfc7-4b1c-46bd-b5b2-08d8861f4b6a
x-ms-traffictypediagnostic: MN2PR12MB4845:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB484538CF3788D11F68B46171FBE80@MN2PR12MB4845.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 15nkTSNhs+W6LmthREBjtfhLPUl+6QEvXmb3nj2nl15v1HM6SIeAGCXAOqEp/hVQ2TmxXFn0pUhnop4eY3+UY+NTRW/1kNSZaWq5EstozfRjH8Qp7I00zM8Cp1bNZUb9sPawtjyTn7i2sTKqFuaimuss0pFZnMkGsD9LCA6x5aqshHqxwystc2z4Q/Kv2ARbmQou6hka27JjmyMJI3EUsuNVNRQfZfvIhejIN+hHoCC5LwzvcTT7kX82Gm6gE4sRIQ/UMvpN77jmlgoZFCxeBvD91P+I5HiVE9uoU5gDQYTYuu65DcbmYWi9S3WT/aha
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(558084003)(7696005)(2906002)(33656002)(6506007)(55016002)(26005)(86362001)(99936003)(9686003)(316002)(6636002)(186003)(478600001)(110136005)(71200400001)(8936002)(66616009)(64756008)(52536014)(66946007)(66556008)(76116006)(66446008)(66476007)(5660300002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: QvuGbpB3G1EquXzcBUexM2D5099tItdM/ZYOsZsqwnXCJO9rDdbIVomg5C7R62JbVZXqG9/SjRQq99d98+d+XDdKBVRfbLExzGZjHzVFwrkRZbjTzro4bhSuB68Evytjg2qcIKvfeQFYNqMusb5YyHaaobyZBKjZ8yTZL9RcUCLEd3fVs9yKejMZOf1nTF76tmsohc7obZ4AEdiKgXI+4PXj9Ky0Yv8YY/vbRlT1lJzAlUbajFo7Oun++C5zQWASIPxDf00qcKIc78gwXVv/NKIuYe2SGq5OKAvzo87zCsUHdme9A91mWBV3OJFBC2c8+Tb3kACYXDGi+BkUQv7XAfpjhgQQ0J7m4Jo6NTzzRZPyEqge9iqFNgcs2wEtGvwWa9XA2J23kwWB1aUdKpo4Uv7+O8phXUZAgJLb+1YgpwnZn8TseXA9w+Nou/Q4ThjkxnDu8FlX+APdyGoSBxe6qWwIcbolwXryVw2farH766spOfKenoyUCo15wPx3tnY/8FowpoW1S2g220tvQo0yBruLh0/XgAeYBavTbe8lqhBpjiMgaMI3KReShzV+YNc57VNMRRD3yHUbxbf62hPQZbOZTzlBwSG0ngrMRBD4uIRdMfbl0uz0Me+Zj5sxNTXrPp433WEnrMBmAee4NXE6Fw==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB403229B5319EAC6A7B8594F0FBE80MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae8bfc7-4b1c-46bd-b5b2-08d8861f4b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:53:43.8618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ih52IIUM0NUCJHXO223sNDon5eiowSawt0nrxl4HBlw+04Xog+LMCwVKAgFVszU74qjH35bsNdHWV1fuFTKQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4845
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

--_004_MN2PR12MB403229B5319EAC6A7B8594F0FBE80MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB403229B5319EAC6A7B8594F0FBE80MN2PR12MB4032namp_"

--_000_MN2PR12MB403229B5319EAC6A7B8594F0FBE80MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to add UMC into IP discovery mapping.

Thank you,
John Clements

--_000_MN2PR12MB403229B5319EAC6A7B8594F0FBE80MN2PR12MB4032namp_
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
<p class=3D"msipheadera92f4c5c" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:11.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to add UMC into IP discovery mappin=
g.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB403229B5319EAC6A7B8594F0FBE80MN2PR12MB4032namp_--

--_004_MN2PR12MB403229B5319EAC6A7B8594F0FBE80MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-add-UMC-to-ip-discovery-map.patch"
Content-Description: 0001-drm-amdgpu-add-UMC-to-ip-discovery-map.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-add-UMC-to-ip-discovery-map.patch"; size=956;
	creation-date="Wed, 11 Nov 2020 08:52:00 GMT";
	modification-date="Wed, 11 Nov 2020 08:52:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2NzhjNWUwZDJmYTJkY2IyNDQ2ZGU4MDljYTI4NTBkOWIyZTYyNTg4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgMTEgTm92IDIwMjAgMTY6NTE6MTkgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogYWRkIFVNQyB0byBpcCBkaXNjb3ZlcnkgbWFwCgpyZXNvbHZlIGlzc3Vl
IHdpdGggVU1DIGJhc2Ugb2Zmc2V0IG5vdCBiZWluZyBzZXQgY29ycmVjdGx5IGluIGlwIGRpc2Nv
dmVyeSBzZXF1ZW5jZQoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50
c0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3Zl
cnkuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jCmluZGV4IGJmYjk1MTQzYmE1ZS4u
YjJkYmNiNGRmMDIwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGlzY292ZXJ5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c2NvdmVyeS5jCkBAIC0xMjgsNiArMTI4LDcgQEAgc3RhdGljIGludCBod19pZF9tYXBbTUFYX0hX
SVBdID0gewogCVtOQklGX0hXSVBdCT0gTkJJRl9IV0lELAogCVtUSE1fSFdJUF0JPSBUSE1fSFdJ
RCwKIAlbQ0xLX0hXSVBdCT0gQ0xLQV9IV0lELAorCVtVTUNfSFdJUF0JPSBVTUNfSFdJRCwKIH07
CiAKIHN0YXRpYyBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9yZWFkX2JpbmFyeShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwgdWludDhfdCAqYmluYXJ5KQotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB403229B5319EAC6A7B8594F0FBE80MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB403229B5319EAC6A7B8594F0FBE80MN2PR12MB4032namp_--
