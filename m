Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41262C2BA1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 03:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FA42074F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 03:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w2utY42Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FA42074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29CE6E101;
	Tue,  7 Apr 2020 03:03:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFCF6E101
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 03:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/P9mxqgbDPKkA4No8YSR+40oqZ7bHcavecc93HYSfUvIHBh3CyEmgrNtXwD9A8ONIc87kFZxN0eUE6+qyxJHEbOzr8173LU2AWUKSAj3khQOlZeQRTmaRx/jpIRVV7ehb12BFHNDeoPiCmefI0eLiZgXQSbT1Xzq4JfHjLl0jtCsEg0EFXrxqaaRVmroES4lrUUT0XFVF0NVKvNYGfHsKZfMOLjamJhpcbqKGkTN6UcAzYAE/fxnpJmLTT9lgVYAsk7E0/3Sf0RKMYlRpOjaK6i72iSbt4ZwHLySkfygzquQwVTj9VupYMer8giBfv9XOjEE6VX1NPmzKY7MQEPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p77Dgfz0uRRbm1q70GmXRnWuSXnE6jHS6mO+CKieGE=;
 b=eMDVCzAFCwqtnABmF1f8EWNevQuBWQ2Xbt6WmN89ucZcRv+inlibYNz8xoRCX0XDa3HFet1o9CuxiDDlqtuDqX87YtvoBIHs8220MDjUMsVS5kxdDCQ/mrZL3VHHu7umfny4vL5D+cL5EES9N6Z0lBIGZp/ctbdTEQJ7YoBEsUJ3/qQq0hW6w05dpUA2R0Md88wF2AU+0hTO7dWwokg5vqfflvSWI3UFiNWNPznwIJ3F7R9w++ZcgTwmLrLduYY7q4+v/dST9CHq0bjuxh/ygYnQvADX7WhC3bSnV7SZlHHkQ6jpjzbmmxQPz0JiplPkcUeshQyarZD/E4TU4dkvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p77Dgfz0uRRbm1q70GmXRnWuSXnE6jHS6mO+CKieGE=;
 b=w2utY42YGgQQsjQFlv7MjBL4ZuxjtoiYcApnWBM4v8QAb1GZ3o3TbANSMyTIi51RtBjJbH8lFxBJSLo7aeU4W1yizk27vohTtY/I+Jd+Ns/vfWty5xAao80dlKtyYwNeGZnSV1DwV5YQ4StrDp5Peiz2XTRUwLoGNgJcI9sDa8s=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Tue, 7 Apr
 2020 03:03:08 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265%3]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 03:03:08 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: resolve mGPU RAS query instability
Thread-Topic: [PATCH] drm/amdgpu: resolve mGPU RAS query instability
Thread-Index: AdYMiLrGDMHeNMEaR8iSuEJH/epwxg==
Date: Tue, 7 Apr 2020 03:03:08 +0000
Message-ID: <MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-07T03:03:04Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=45c41767-f67f-4403-9a3d-000022d69304;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-07T03:03:04Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d272d9f7-0b02-4846-a8dc-0000dbcdf218
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84fcb49c-b4bf-4ec8-11af-08d7daa03360
x-ms-traffictypediagnostic: MN2PR12MB4501:|MN2PR12MB4501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4501E40FCA924A71CF75BC3CFBC30@MN2PR12MB4501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(39850400004)(396003)(6506007)(66476007)(76116006)(66946007)(9686003)(52536014)(7696005)(110136005)(99936003)(186003)(66446008)(316002)(66616009)(55016002)(66556008)(64756008)(5660300002)(81156014)(8676002)(558084003)(81166006)(86362001)(2906002)(26005)(71200400001)(6636002)(33656002)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WKrLwQuOSkVTn+6WXnB/KCH/0AuZFLVHkLrNjlkgrO3J/UHJD8H+NGeSKdtQOmvZx5TM80juhBv1YA+/6QRXmI+Mp9Yq9B3uQZ6P4R13cK8uBMx5bjenxGDTpQXArczSBhq1LXIhotep9LMyFp/+AXEqWhL0v3/2Mb8WdYS6N5VOed/ALHKHWvAwGYxK3MyaT00PFR+7hVR34nNaUIpsye5vIoQ3ojZVkxoyiJsdFsgQ+FY1z2qaVmiXl0vSFQGkRHZSAY/KoxJ2MYiYMisfx8NxmSNR/YvCckAOivOH2TfCrCuwLvi4zMYcgw8T2hHHi+kgiZwN8CuOX1sntpBoSR8cTGubTCDFPv59cgEyOeN+L6gRiZ2PnEf6wKPEzHcRxkL4in7q2mvGuNDIIulsPBtCwiYSm7CSdaezyJ5G6M9AZdRScGz7FTeVCM3mcQat
x-ms-exchange-antispam-messagedata: +vu22+/EJo2BJh9cDq233b8qwQzA+oa5JlpLQTbu5fckPE2LZt/+6NdpG0myOTMzeQ9jZuvt1jlOMHfGTvKoBjICBjD0N7epU905OpO4LGfpova3gdrfiMNk6wPKsZaYmOg6w9nITiRQS1ZbmXjwZw==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fcb49c-b4bf-4ec8-11af-08d7daa03360
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 03:03:08.6591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfF9BdRxQ5Tvsth1E1OhFgPBmOkGd7Tob8VMWOWC7NcQL+1Rvzu4DrSyDGmOTAAa1o8tEv/8n58LtRtceUd6bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
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

--_004_MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30MN2PR12MB4032namp_"

--_000_MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to resolve issue when upon receiving an uncorrectable ras =
error, RAS ISR gets triggered on all GPU node creating a race condition bet=
ween querying the RAS errors and entering the GPU reset sequence

--_000_MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30MN2PR12MB4032namp_
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p class=3D"msipheadera92e061b" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to resolve issue when upon receivin=
g an uncorrectable ras error, RAS ISR gets triggered on all GPU node creati=
ng a race condition between querying the RAS errors and entering the GPU re=
set sequence<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30MN2PR12MB4032namp_--

--_004_MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolve-mGPU-RAS-query-instability.patch"
Content-Description: 0001-drm-amdgpu-resolve-mGPU-RAS-query-instability.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolve-mGPU-RAS-query-instability.patch";
	size=1789; creation-date="Tue, 07 Apr 2020 03:00:00 GMT";
	modification-date="Tue, 07 Apr 2020 03:00:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNTM2MDg4MmY5NDc4ZTY1OTliN2I5YjVhMDY5M2IzN2U0MjAyNTY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgNyBBcHIgMjAyMCAxMDo1ODoxNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHJlc29sdmUgbUdQVSBSQVMgcXVlcnkgaW5zdGFiaWxpdHkKCnVwb24gcmVjZWl2
aW5nIHVuY29ycmVjdGFibGUgZXJyb3IsIHF1ZXJ5IGV2ZXJ5IEdQVSBub2RlIGZvciByYXMgZXJy
b3JzCgpTaWduZWQtb2ZmLWJ5OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkNoYW5nZS1JZDogSTQ0NWQ5YzIyZGZhMjgwMDBkMzE4NzQxMTIwMGIxY2M1NGFhZjc4YWQKLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCAyMSArKysrKysrKysr
KysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwppbmRleCA4YTc4ZGI2
NDg0NDIuLmE1ZmUyNWY0MmVmNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYwpAQCAtMTQzOCwxMiArMTQzOSwyMiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2RvX3Jl
Y292ZXJ5KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIHsKIAlzdHJ1Y3QgYW1kZ3B1X3JhcyAq
cmFzID0KIAkJY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBhbWRncHVfcmFzLCByZWNvdmVyeV93
b3JrKTsKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqcmVtb3RlX2FkZXYgPSBOVUxMOworCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmFzLT5hZGV2OworCXN0cnVjdCBsaXN0X2hlYWQgZGV2
aWNlX2xpc3QsICpkZXZpY2VfbGlzdF9oYW5kbGUgPSAgTlVMTDsKKwlzdHJ1Y3QgYW1kZ3B1X2hp
dmVfaW5mbyAqaGl2ZSA9IGFtZGdwdV9nZXRfeGdtaV9oaXZlKGFkZXYsIGZhbHNlKTsKKworCS8q
IEJ1aWxkIGxpc3Qgb2YgZGV2aWNlcyB0byBxdWVyeSBSQVMgcmVsYXRlZCBlcnJvcnMgKi8KKwlp
ZiAgKGhpdmUgJiYgYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkgeworCQlk
ZXZpY2VfbGlzdF9oYW5kbGUgPSAmaGl2ZS0+ZGV2aWNlX2xpc3Q7CisJfSBlbHNlIHsKKwkJbGlz
dF9hZGRfdGFpbCgmYWRldi0+Z21jLnhnbWkuaGVhZCwgJmRldmljZV9saXN0KTsKKwkJZGV2aWNl
X2xpc3RfaGFuZGxlID0gJmRldmljZV9saXN0OworCX0KIAotCS8qCi0JICogUXVlcnkgYW5kIHBy
aW50IG5vbiB6ZXJvIGVycm9yIGNvdW50ZXIgcGVyIElQIGJsb2NrIGZvcgotCSAqIGF3YXJlbmVz
cyBiZWZvcmUgcmVjb3ZlcmluZyBHUFUuCi0JICovCi0JYW1kZ3B1X3Jhc19sb2dfb25fZXJyX2Nv
dW50ZXIocmFzLT5hZGV2KTsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KHJlbW90ZV9hZGV2LCBkZXZp
Y2VfbGlzdF9oYW5kbGUsIGdtYy54Z21pLmhlYWQpIHsKKwkJYW1kZ3B1X3Jhc19sb2dfb25fZXJy
X2NvdW50ZXIocmVtb3RlX2FkZXYpOworCX0KIAogCWlmIChhbWRncHVfZGV2aWNlX3Nob3VsZF9y
ZWNvdmVyX2dwdShyYXMtPmFkZXYpKQogCQlhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHJhcy0+
YWRldiwgMCk7Ci0tIAoyLjE3LjEKCg==

--_004_MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB4032D0F37EB0E44196F4FE8AFBC30MN2PR12MB4032namp_--
