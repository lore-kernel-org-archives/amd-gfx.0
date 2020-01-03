Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE7EC3276F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 02:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92FA2085B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 02:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wo/Ywc6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92FA2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CDD6E167;
	Fri,  3 Jan 2020 02:52:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F0406E167
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 02:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7jyO65551khMnV/9mVESKYw8E4NumWniS3I5b8th/H5iwBNLU5A5YtnuQ2N0Ih+jmy+kFNjdygdnirVfxANDuho88GUMJUtpFHi9yJ90Dyybqvty/7EJ5SgnxFTzIqHPpzXRQsZ/JjrG+pGiq3JoLQ7iVIiR5MDoTgAhTgkaAW/AQjpIYXAr+xn8Sy2Pwl+3la1QjgKJxNaxKlNHcWgOPsSTJ9k8oIf20NA+F0VR+3RsZatpg0FrOpiY3nfUCQBaPMQ7Q6Fo+ptTGqPZ9KRF4UppPwtA2AK0ySmepeR03HldC4N1Ba50fiq/J0rXMytSxNPbcNUob1gR5FAeOeQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8vsMjl9EKYgYibN53Z58G0Q6jHXUSwmQySaFugu2IU=;
 b=W8hPUcWiF2X2aijwTHLo0SXuR0ShIsJbA0CObA2Iz+NLt52ldK0bjvUtdUBO1j3/kLS41B1E9h9xQMNxvxFShUronNuh7HzqblX+OHAAhnUOI+/KfxbebqEMTueWiBQHaoWWZ/vl9gPBt7W20hDfejZsrQJyRforFbBnqeuLZIKLMPcHR4WN+oTpE8+/mQRVTCgVlBnN9jWtPXgRBMaXX4cZnMpJgOuYJnFLThQuS4ldVsV2ImAXt+mNxN9XPBzGPAOr3YmApb6fgJBtUwuEXVa/n7WgUiU1iWBnEg+HPH3BfTGIlBII65Z4xVFf02R7sxqZbQTgVSCCzPe4YXIh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8vsMjl9EKYgYibN53Z58G0Q6jHXUSwmQySaFugu2IU=;
 b=wo/Ywc6mQ/3B+vftZmpRRJ4RdXkOpAk+uI8qYGDJ3c3+zvwVxzXjnm1WCOetHytu7y14GXBEpCR8LDx2vVA48/BDqdOF4LLu2vicFrFkIJunucoEI7D1GKJNgzlpXTRkoBzfybCHlB06DzO17srJOsLEodDerI7OKvdzzVyih8I=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (20.178.244.79) by
 MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 02:52:43 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::69d9:af7c:d092:7acf]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::69d9:af7c:d092:7acf%7]) with mapi id 15.20.2581.007; Fri, 3 Jan 2020
 02:52:43 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Topic: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Index: AdXBV3Yg76uTyzhkQhyxmQ2h5s6tpQAh5jMw
Date: Fri, 3 Jan 2020 02:52:43 +0000
Message-ID: <MN2PR12MB3054E9B6217E994F836913B3B0230@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <MN2PR12MB3663CB891846CB098EED1354FB200@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3663CB891846CB098EED1354FB200@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-03T02:40:05Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=25f9a9b6-91d3-4a0a-91a7-0000b056759d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-03T02:52:40Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1850142e-5831-4d30-9377-0000963e9647
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 230bcb63-2ff0-4e91-f1f8-08d78ff801af
x-ms-traffictypediagnostic: MN2PR12MB4285:|MN2PR12MB4285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4285E0D725106EA94540C235B0230@MN2PR12MB4285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(9686003)(110136005)(8936002)(55016002)(33656002)(316002)(6636002)(5660300002)(478600001)(52536014)(64756008)(76116006)(81156014)(86362001)(66446008)(2906002)(66556008)(186003)(66946007)(71200400001)(6506007)(26005)(7696005)(81166006)(66476007)(8676002)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4285;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8SG0nWIjIhSSOWBSKVeNMSmfq76yhwVrv/Dx6Wlo1YR0G1IbhgNtNbwSi9hqOGBnp0TboeJI1whiWgElISipRBzFg6VaqTmUtQKqfHgL5ZMZPNjDLQ0DVTW0U/tQ9TefKG0D+eXXHkQiVu/nMoFSFIFwjlQ+9ca5NqJZJdQxQb9GYg+Yid96BmNZib+EXi2kYsjeOYQHQd8pIjn7lLoqCOZpWhVzsWvd/mGSTf/dWPHBJTnzVFam4j5C5QFubdDl6+Bk5yJrbtNR+CvcxqOQVSjSbiSB+XrFD8YOb/8afDETkSNFvb8AAk9cmKkHDT4IWGNDVOZvL0FtxpHeCD36C1zTs/mPOnHYbG1vzsjaIHLKYDR8wosWlNYO/AhErzISbmXDLbtIvzDl6EbNxISkKFeUwzSmZczo40GdFDyPlIM0J27aPDZCfMAGisnYf4F
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230bcb63-2ff0-4e91-f1f8-08d78ff801af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 02:52:43.6035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwXX7JCKKjO9vyEqZYvxqPQLIHvQVLGTOAiY9N6EoSWierd+UbNCwb9GBwvSB9ZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
Content-Type: multipart/mixed; boundary="===============2123422302=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2123422302==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3054E9B6217E994F836913B3B0230MN2PR12MB3054namp_"

--_000_MN2PR12MB3054E9B6217E994F836913B3B0230MN2PR12MB3054namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBQdWJsaWMgVXNlXQ0KDQpJIHRoaW5rIHdlIGNhbiBpbXBsZW1lbnQgaXQgYnkgb25seSB1
cGRhdGluZyBhbWRncHVfdW1jX2Zvcl9lYWNoX2NoYW5uZWwgbWFjcm8sIGhlcmUgaXMgYW4gZXhh
bXBsZToNCg0KI2RlZmluZSBhbWRncHVfdW1jX2Zvcl9lYWNoX2NoYW5uZWwoZnVuYykgICAgICAg
IFwNCiAgICAgICAgc3RydWN0IHJhc19lcnJfZGF0YSAqZXJyX2RhdGEgPSBcDQogICAgICAgICAg
ICAgICAgICAgICAgICAoc3RydWN0IHJhc19lcnJfZGF0YSAqKXJhc19lcnJvcl9zdGF0dXM7ICAg
ICAgICBcDQogICAgICAgIHVpbnQzMl90IHVtY19pbnN0LCBjaGFubmVsX2luc3QsIHVtY19yZWdf
b2Zmc2V0LCBjaGFubmVsX2luZGV4OyBcDQogICAgICAgIGZvciAodW1jX2luc3QgPSAwOyB1bWNf
aW5zdCA8IGFkZXYtPnVtYy51bWNfaW5zdF9udW07ICBcDQogICAgICAgICAgICAgICAgICAgICAg
ICB1bWNfaW5zdCsrKSB7ICAgXA0KICAgICAgICAgICAgICAgIHVtY19yZWdfb2Zmc2V0ID0gYWRl
di0+dW1jLmluc3Rfb2ZmcyAqIHVtY19pbnN0OyAgICAgICBcDQogICAgICAgICAgICAgICAgZm9y
IChjaGFubmVsX2luc3QgPSAwOyAgXA0KICAgICAgICAgICAgICAgICAgICAgICAgY2hhbm5lbF9p
bnN0IDwgYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW07ICAgICBcDQogICAgICAgICAgICAgICAg
ICAgICAgICBjaGFubmVsX2luc3QrKykgeyAgICAgICBcDQogICAgICAgICAgICAgICAgICAgICAg
ICAvKiBnZXQgY2hhbm5lbCBpbmRleCBvZiBpbnRlcmxlYXZlZCBtZW1vcnkgKi8gICBcDQogICAg
ICAgICAgICAgICAgICAgICAgICBjaGFubmVsX2luZGV4ID0gYWRldi0+dW1jLmNoYW5uZWxfaWR4
X3RibFtcDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVtY19pbnN0ICogYWRldi0+
dW1jLmNoYW5uZWxfaW5zdF9udW0gKyBjaGFubmVsX2luc3RdOyBcDQogICAgICAgICAgICAgICAg
ICAgICAgICAoZnVuYykoYWRldiwgZXJyX2RhdGEsIHVtY19yZWdfb2Zmc2V0LCBjaGFubmVsX2lu
ZGV4KTsgXA0KICAgICAgICAgICAgICAgICAgICAgICAgLyogaW5jcmVhc2UgcmVnaXN0ZXIgb2Zm
c2V0IGZvciBuZXh0IGNoYW5uZWwgKi8gXA0KICAgICAgICAgICAgICAgICAgICAgICAgdW1jX3Jl
Z19vZmZzZXQgKz0gYWRldi0+dW1jLmNoYW5uZWxfb2ZmczsgICAgICBcDQogICAgICAgICAgICAg
ICAgfSAgICAgICBcDQogICAgICAgIH0NCg0KUmVnYXJkcywNClRhbw0KRnJvbTogQ2xlbWVudHMs
IEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT4NClNlbnQ6IDIwMjDE6jHUwjLI1SAxODozMQ0K
VG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+DQpTdWJqZWN0
OiBbUEFUQ0hdIGRybS9hbWRncHU6IHJlc29sdmVkIGJ1ZyBpbiBVTUMgNiBlcnJvciBjb3VudGVy
IHF1ZXJ5DQoNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlv
biBPbmx5XQ0KDQpBZGRlZCBwYXRjaCB0byByZXNvbHZlIGZvbGxvd2luZyBpc3N1ZSB3aGVyZSBl
cnJvciBjb3VudGVyIGRldGVjdGlvbiB3YXMgbm90IGl0ZXJhdGluZyBvdmVyIGFsbCBVTUMgaW5z
dGFuY2VzL2NoYW5uZWxzLg0KUmVtb3ZlZCBzdXBwb3J0IGZvciBhY2Nlc3NpbmcgVU1DIGVycm9y
IGNvdW50ZXJzIHZpYSBNTUlPLg0KDQpUaGFuayB5b3UsDQpKb2huIENsZW1lbnRzDQo=

--_000_MN2PR12MB3054E9B6217E994F836913B3B0230MN2PR12MB3054namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
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
<p class=3D"msipheader87abd423" style=3D"margin:0cm;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:=CB=CE=
=CC=E5"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">I think we can implement it by only updating amdgpu_=
umc_for_each_channel macro, here is an example:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#define amdgpu_umc_for_each_channel(func)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ra=
s_err_data *err_data =3D \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (struct ras_err_data *)ras_error_status; &nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;\<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t =
umc_inst, channel_inst, umc_reg_offset, channel_index; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (umc_=
inst =3D 0; umc_inst &lt; adev-&gt;umc.umc_inst_num;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; umc_inst&#43;&#43;) {&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_offset =3D adev-&gt;umc.inst=
_offs * umc_inst;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (channel_inst =3D 0;&nbsp; \<o:p=
></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; channel_inst &lt; adev-&gt;umc.channel_inst_num;&nbsp;&nbsp;&nb=
sp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; channel_inst&#43;&#43;) {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \=
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* get channel index of interleaved memory */&nbsp;&nbsp; \<o:p=
></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; channel_index =3D adev-&gt;umc.channel_idx_tbl[\<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_inst * adev=
-&gt;umc.channel_inst_num &#43; channel_inst]; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &nbsp;(func)(adev, err_data, umc_reg_offset, channel_index); \<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* increase register offset for next channel */ \<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; umc_reg_offset &#43;=3D adev-&gt;umc.channel_offs;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Tao<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> 2020<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=
=C4=EA</span>1<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=D4=
=C2</span>2<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=C8=D5</=
span> 18:31<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter que=
ry<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0cm;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Added patch to resolve following issue where error c=
ounter detection was not iterating over all UMC instances/channels.<o:p></o=
:p></p>
<p class=3D"MsoNormal">Removed support for accessing UMC error counters via=
 MMIO.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3054E9B6217E994F836913B3B0230MN2PR12MB3054namp_--

--===============2123422302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2123422302==--
