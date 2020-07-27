Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFA9C433E4
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 08:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AFB20714
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 08:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KmHnxH1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AFB20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2127289C21;
	Mon, 27 Jul 2020 08:32:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBC089C21
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 08:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLZGTqY4J7BtOUw6rp0lN/h+VjrsSYpJObyIWrq4Ay+/c3au8M3i0uTSup5XAzU/9ZE6nI1svDsQrTKe/XPsizXa4+hauYYxK8C4dTOLqwPkfJv0xWsu/mHaTeN12W0/dVcpGUbF1HlKsbLMDX+DxCq/3TDIm87XnHlAsq1lKTGmEag1Yq4fc6ihv+/XEgey8wPvcK6RA5MaKvClfJxn6u4o50Sj6HfPTwNwFXW0Erl/GsZgXsgbhDxNgka3576Zztlmc3th9ChgD5aOCwbl71X+B6S+ufdGOOvDdQBiOEhFywJtouhcl8Ic0B4zPcdVZpwBN2hZZ5fxwjgjn0ze3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoacCcSAiMgBsHPxxMcxr1hGEg1Vv16tTgYjuI1KpSI=;
 b=NBm0uIf08MWvmEhJwQMAi9h7fdEhBt8+OaDwboYZSzszUOOSWK5Kzy6PRkdcv5AYGl7x2Pnq74w/mf+vwHyzzCEoVD7zp+lWPVmANh4KWU4Zenc4W92oXHIStEAxrB5cCVfHYdJ7Qye5Sa5G0dIeqDre0P/IIx2zdKsVkYokERFw4UIzRYky9TIgbGOBct5f9d2k1eBegkyCnaITtv8F7ojQtoUhNvKQhTZqHBfVFgMZ9oxB+moZ9bzAP8/LLv9amec+11Hudv7Cq5HowvXMRiK8Tuwwy/Ouwd3M+QqsqYzsrKbhBl998i26l2ngqoMGHPWrWsNL6eCFY6T9qnAcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoacCcSAiMgBsHPxxMcxr1hGEg1Vv16tTgYjuI1KpSI=;
 b=KmHnxH1SuB8XCXoIZmFZobZ2LmHkkkN3RhiASNrUlhXGiAz4w9e/Ut9s7rdIPYlifd93mQSofpXre7Wc1DN11GpvhXGLiD3WKa/UABj2GPKCFOvMV/0OGd3InOiNUN5mmhFb/3ZLAPZSeqBkhHGlJNnffBQfTCVPtsRZ+Lhur88=
Received: from DM6PR12MB4026.namprd12.prod.outlook.com (2603:10b6:5:1cc::33)
 by DM5PR12MB1195.namprd12.prod.outlook.com (2603:10b6:3:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 08:32:24 +0000
Received: from DM6PR12MB4026.namprd12.prod.outlook.com
 ([fe80::ac41:b4e1:18b2:67cb]) by DM6PR12MB4026.namprd12.prod.outlook.com
 ([fe80::ac41:b4e1:18b2:67cb%7]) with mapi id 15.20.3216.026; Mon, 27 Jul 2020
 08:32:24 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10
Thread-Topic: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10
Thread-Index: AdZj8ChRB8kbyPg9T927y1qmSWUoxw==
Date: Mon, 27 Jul 2020 08:32:24 +0000
Message-ID: <DM6PR12MB40262ED0408E4FD14160D1A1FB720@DM6PR12MB4026.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-27T08:32:21Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=af532301-b71d-4340-96dd-0000519c31b9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-27T08:32:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: beea6aad-5ace-4de6-bf94-0000506e4910
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-27T08:32:22Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c5698eab-fdcb-418d-aea9-0000e75fd9d2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84c7c22a-ab12-49b1-d748-08d8320796c4
x-ms-traffictypediagnostic: DM5PR12MB1195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1195A78C688E59B119BC73EEFB720@DM5PR12MB1195.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xKbbPzJqLPK59bmGM/OM7AdjCQocIKVcO5sfsy6saIBC0bOw0+UjkfY2ODysPOlUevaJjru1Xf8EZ47LJyGFYItCYIkWRG4nfJUUZbd5gA//Z4eDz3ZspKPrhCY0UFTQuaaowhM9R9bHq2muBKhPHNkooBYg0UQEM63VGcoK9ILYfTo/NILtTtSxQ5XssmV00jBT83Xi1rWkQ4tvEJIbcl7GEApVmptgfy0VeR+D8PNTg4L5+XvC8u+3qzl2UXtQvJiXHM5iPsK/+Q8m2byzFDMCjpuinZK4ZLVQrNkYTSox33M3rcutnbeNN/UL9xwzOJGLJIR8hmPvBjDN5s/AQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4026.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(316002)(2906002)(5660300002)(8936002)(86362001)(71200400001)(8676002)(52536014)(33656002)(186003)(110136005)(55016002)(478600001)(558084003)(7696005)(26005)(76116006)(66556008)(66616009)(66476007)(66946007)(66446008)(64756008)(6506007)(6636002)(9686003)(99936003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: IDN6UwJxT5pen1rY8jCdmR6lxG5VlmKzjKT9CPKAbsXg9nUjwRAreFcpXZbLq39SNDuhhyVxISVnKJeFU6VBb7TydO193L7gC5YiWL+pTwKHea4ECGdJi77ds4lOb5es/rIJsST9cHFi2v1CtzmY6dVHGufTdakclh7kYvPIH/iXAM1MD6NKO4NgsznskHRs6gZrqnQrQX9NpimmSiUJSE79wttEKFZdZKWBc+aCJA+YCPMJSi4KCpbcY01hJBPkRSLmvZtrdBhKHAeBOBKPdo8qCsIE3GoICSSgpWsZrVHiMvu6H6yfvF4V7sXU0RXG4iUVlVMp0MbHxi9KfVO28HA0ef/ixEayWPSGPxhwjCCCkM0RbhKXdh6LCN62nen36KZo+VXG2RCwYgydRDGEd7PHmgTK8spH1WwhuXmNwS0FA1ZnADonCROZcRJmlKhlSFfS9DgoEMfU0P5ZWZLylzsE67L/l/jcIDx5SzaDjLwPaUdgGf8l7EwvjF+ywo6r
Content-Type: multipart/mixed;
 boundary="_004_DM6PR12MB40262ED0408E4FD14160D1A1FB720DM6PR12MB4026namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4026.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c7c22a-ab12-49b1-d748-08d8320796c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 08:32:24.7808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cWA6CDuK0RbdAPZnOtRPIvKWIejH4GPdPAhYk6zF/zs4HG6urYZ9K77XX4kUfyhJG/3zUws4O0uEbCQA9kBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1195
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

--_004_DM6PR12MB40262ED0408E4FD14160D1A1FB720DM6PR12MB4026namp_
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40262ED0408E4FD14160D1A1FB720DM6PR12MB4026namp_"

--_000_DM6PR12MB40262ED0408E4FD14160D1A1FB720DM6PR12MB4026namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch to enable UMC 8.7 GECC functions in GMC v10

--_000_DM6PR12MB40262ED0408E4FD14160D1A1FB720DM6PR12MB4026namp_
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
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to enable UMC 8.7 GECC functions in=
 GMC v10<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB40262ED0408E4FD14160D1A1FB720DM6PR12MB4026namp_--

--_004_DM6PR12MB40262ED0408E4FD14160D1A1FB720DM6PR12MB4026namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-enable-umc-8.7-functions-in-gmc-v10.patch"
Content-Description: 0001-drm-amdgpu-enable-umc-8.7-functions-in-gmc-v10.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-enable-umc-8.7-functions-in-gmc-v10.patch";
	size=3758; creation-date="Mon, 27 Jul 2020 08:32:00 GMT";
	modification-date="Mon, 27 Jul 2020 08:32:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhZmVkZjdhNTg1Y2QyZGIyYmQ1NGMxZDZlM2I2MDgyZDllMjJkMmM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IE1vbiwgMjcgSnVsIDIwMjAgMTY6Mjc6NTQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBlbmFibGUgdW1jIDguNyBmdW5jdGlvbnMgaW4gZ21jIHYxMAoKYWRkIHN1cHBv
cnQgZm9yIHVtYyA4LjcgaW5pdGlhbHphdGlvbiBhbmQgUkFTIGludGVycnVwdAoKU2lnbmVkLW9m
Zi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEk5
Njc5NTcxODkzYTNkZWRmMzM5MThjMTUxOTkxZjA1NzJhNGU4ZmVkCi0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysr
LQogMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCmluZGV4IDFhNzgwNzNjMmYwNS4uMzVkMjFm
MzMwYjBhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwpAQCAtMjUsNiAr
MjUsNyBAQAogI2luY2x1ZGUgImFtZGdwdS5oIgogI2luY2x1ZGUgImFtZGdwdV9hdG9tZmlybXdh
cmUuaCIKICNpbmNsdWRlICJnbWNfdjEwXzAuaCIKKyNpbmNsdWRlICJ1bWNfdjhfNy5oIgogCiAj
aW5jbHVkZSAiaGRwL2hkcF81XzBfMF9vZmZzZXQuaCIKICNpbmNsdWRlICJoZHAvaGRwXzVfMF8w
X3NoX21hc2suaCIKQEAgLTU1LDYgKzU2LDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jMTVf
cmVnX2dvbGRlbiBnb2xkZW5fc2V0dGluZ3NfbmF2aTEwX2hkcFtdID0KIH07CiAjZW5kaWYKIAor
c3RhdGljIGludCBnbWNfdjEwXzBfZWNjX2ludGVycnVwdF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKKwkJCQkJIHN0cnVjdCBhbWRncHVfaXJxX3NyYyAqc3JjLAorCQkJCQkgdW5z
aWduZWQgdHlwZSwKKwkJCQkJIGVudW0gYW1kZ3B1X2ludGVycnVwdF9zdGF0ZSBzdGF0ZSkKK3sK
KwlyZXR1cm4gMDsKK30KKwogc3RhdGljIGludAogZ21jX3YxMF8wX3ZtX2ZhdWx0X2ludGVycnVw
dF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkgICBzdHJ1Y3QgYW1kZ3B1
X2lycV9zcmMgKnNyYywgdW5zaWduZWQgdHlwZSwKQEAgLTEzMSwxMCArMTQwLDIwIEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmNfZnVuY3MgZ21jX3YxMF8wX2lycV9mdW5jcyA9
IHsKIAkucHJvY2VzcyA9IGdtY192MTBfMF9wcm9jZXNzX2ludGVycnVwdCwKIH07CiAKLXN0YXRp
YyB2b2lkIGdtY192MTBfMF9zZXRfaXJxX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQorc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfaXJxX3NyY19mdW5jcyBnbWNfdjEwXzBfZWNj
X2Z1bmNzID0geworCS5zZXQgPSBnbWNfdjEwXzBfZWNjX2ludGVycnVwdF9zdGF0ZSwKKwkucHJv
Y2VzcyA9IGFtZGdwdV91bWNfcHJvY2Vzc19lY2NfaXJxLAorfTsKKworIHN0YXRpYyB2b2lkIGdt
Y192MTBfMF9zZXRfaXJxX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCWFk
ZXYtPmdtYy52bV9mYXVsdC5udW1fdHlwZXMgPSAxOwogCWFkZXYtPmdtYy52bV9mYXVsdC5mdW5j
cyA9ICZnbWNfdjEwXzBfaXJxX2Z1bmNzOworCisJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikp
IHsKKwkJYWRldi0+Z21jLmVjY19pcnEubnVtX3R5cGVzID0gMTsKKwkJYWRldi0+Z21jLmVjY19p
cnEuZnVuY3MgPSAmZ21jX3YxMF8wX2VjY19mdW5jczsKKwl9CiB9CiAKIC8qKgpAQCAtNTY5LDEy
ICs1ODgsMjkgQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX3NldF9nbWNfZnVuY3Moc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiAJCWFkZXYtPmdtYy5nbWNfZnVuY3MgPSAmZ21jX3YxMF8wX2dt
Y19mdW5jczsKIH0KIAorc3RhdGljIHZvaWQgZ21jX3YxMF8wX3NldF91bWNfZnVuY3Moc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCit7CisJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKKwlj
YXNlIENISVBfU0lFTk5BX0NJQ0hMSUQ6CisJCWFkZXYtPnVtYy5tYXhfcmFzX2Vycl9jbnRfcGVy
X3F1ZXJ5ID0gVU1DX1Y4XzdfVE9UQUxfQ0hBTk5FTF9OVU07CisJCWFkZXYtPnVtYy5jaGFubmVs
X2luc3RfbnVtID0gVU1DX1Y4XzdfQ0hBTk5FTF9JTlNUQU5DRV9OVU07CisJCWFkZXYtPnVtYy51
bWNfaW5zdF9udW0gPSBVTUNfVjhfN19VTUNfSU5TVEFOQ0VfTlVNOworCQlhZGV2LT51bWMuY2hh
bm5lbF9vZmZzID0gVU1DX1Y4XzdfUEVSX0NIQU5ORUxfT0ZGU0VUX1NJRU5OQTsKKwkJYWRldi0+
dW1jLmNoYW5uZWxfaWR4X3RibCA9ICZ1bWNfdjhfN19jaGFubmVsX2lkeF90YmxbMF1bMF07CisJ
CWFkZXYtPnVtYy5mdW5jcyA9ICZ1bWNfdjhfN19mdW5jczsKKwkJYnJlYWs7CisJZGVmYXVsdDoK
KwkJYnJlYWs7CisJfQorfQorCiBzdGF0aWMgaW50IGdtY192MTBfMF9lYXJseV9pbml0KHZvaWQg
KmhhbmRsZSkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqKWhhbmRsZTsKIAogCWdtY192MTBfMF9zZXRfZ21jX2Z1bmNzKGFkZXYpOwogCWdt
Y192MTBfMF9zZXRfaXJxX2Z1bmNzKGFkZXYpOworCWdtY192MTBfMF9zZXRfdW1jX2Z1bmNzKGFk
ZXYpOwogCiAJYWRldi0+Z21jLnNoYXJlZF9hcGVydHVyZV9zdGFydCA9IDB4MjAwMDAwMDAwMDAw
MDAwMFVMTDsKIAlhZGV2LT5nbWMuc2hhcmVkX2FwZXJ0dXJlX2VuZCA9CkBAIC03OTAsNiArODI2
LDE0IEBAIHN0YXRpYyBpbnQgZ21jX3YxMF8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQogCWlmIChy
KQogCQlyZXR1cm4gcjsKIAorCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CisJCS8qIGlu
dGVycnVwdCBzZW50IHRvIERGLiAqLworCQlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09D
MTVfSUhfQ0xJRU5USURfREYsIDAsCisJCQkJICAgICAgJmFkZXYtPmdtYy5lY2NfaXJxKTsKKwkJ
aWYgKHIpCisJCQlyZXR1cm4gcjsKKwl9CisKIAkvKgogCSAqIFNldCB0aGUgaW50ZXJuYWwgTUMg
YWRkcmVzcyBtYXNrIFRoaXMgaXMgdGhlIG1heCBhZGRyZXNzIG9mIHRoZSBHUFUncwogCSAqIGlu
dGVybmFsIGFkZHJlc3Mgc3BhY2UuCkBAIC05NTAsNiArOTk0LDkgQEAgc3RhdGljIGludCBnbWNf
djEwXzBfaHdfaW5pdCh2b2lkICpoYW5kbGUpCiAJaWYgKHIpCiAJCXJldHVybiByOwogCisJaWYg
KGFkZXYtPnVtYy5mdW5jcyAmJiBhZGV2LT51bWMuZnVuY3MtPmluaXRfcmVnaXN0ZXJzKQorCQlh
ZGV2LT51bWMuZnVuY3MtPmluaXRfcmVnaXN0ZXJzKGFkZXYpOworCiAJcmV0dXJuIDA7CiB9CiAK
QEAgLTk4MSw2ICsxMDI4LDcgQEAgc3RhdGljIGludCBnbWNfdjEwXzBfaHdfZmluaSh2b2lkICpo
YW5kbGUpCiAJCXJldHVybiAwOwogCX0KIAorCWFtZGdwdV9pcnFfcHV0KGFkZXYsICZhZGV2LT5n
bWMuZWNjX2lycSwgMCk7CiAJYW1kZ3B1X2lycV9wdXQoYWRldiwgJmFkZXYtPmdtYy52bV9mYXVs
dCwgMCk7CiAJZ21jX3YxMF8wX2dhcnRfZGlzYWJsZShhZGV2KTsKIAotLSAKMi4xNy4xCgo=

--_004_DM6PR12MB40262ED0408E4FD14160D1A1FB720DM6PR12MB4026namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_DM6PR12MB40262ED0408E4FD14160D1A1FB720DM6PR12MB4026namp_--
