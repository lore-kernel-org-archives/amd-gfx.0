Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54936C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 07:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19B5206D5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 07:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T1UUzTZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19B5206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B38C89791;
	Tue, 14 Apr 2020 07:54:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CBD289791
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 07:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7g5m4qedSJH9cQxe6G4NWGdWeDDIbCN9Imnsu5plAHm4I3wFIiqqXNRymNWSbb9LPsTp94FWQca2uBiVCMo3AUIwj8q8S2ZahkHjvrYYea52wkaFVV7UDgEfLaO3RGd3VVThntSQudHpO4c50BNs5YuF7g0sVl0TThBHn66cmSFoY5PNcBqwuvWs2kPeFCrUyaESF947SPB32MovYL0dr03TsrNbrEg7rBPFkB28Sg+5c8PnsBkGflDX06ZnVmXmTYaWDR1VZ3/tGrucQeeWW1CK7w0ZAWbs1qyZQoSRd/rZfNv+YhKoIllN6mjrJzlCP2V43peMaqixxjVIDWNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTsK1Uq3NSvUnGJYb5gatPOzqp1ctK1o6K1Dn7f2N0E=;
 b=R5jt5ehafEl7iT1keWXbEK2Or+n1TnnoI2oYWYIMyya5J57ZzTFDsmy2hSLLb/XTT3ik7y0/zjwlEt06K8VJBhwkqdOrp6hLTELa9GTZzTtXnG6VnuFJxiF3fJqy1IhCXfDxdWiAMfCabXgY1kJdvMp5lYJ9IRU3QnDTQvaaQ3ZHEuqUbp9/fPu2/7BjIG+wfwoGSiPOPi+q7QpmIiwRvGWm/3w8KFlKZEBBDf/8dRLgu4s5DAyZsmPGR90CHA9sXmELC+OiZf7ORacLy5vUyyvbFF/QoKLBYOhwW6nP//a482jlvwjoisTANw7FccSRKoeKUat7jUWurlOrDKTMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTsK1Uq3NSvUnGJYb5gatPOzqp1ctK1o6K1Dn7f2N0E=;
 b=T1UUzTZ6aBM/DglYkDCLFE8A/EejpGUWf+OrVNMXob2c/G9LKQFulBKXu/2dB3Yxb/H/BRt6ukwnZUHNNCdqgWtbjg2xzFym+csyXSuN+pu0mjSzNnU7WmbCY4PY8H3LsiKI1BJQ8CJ0nFlm4Ong0Dv6ncjwZXYN6AnE0f2Ups4=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB3999.namprd12.prod.outlook.com (2603:10b6:208:158::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 07:54:28 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265%3]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 07:54:28 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: cache smu fw version info
Thread-Topic: [PATCH] drm/amdgpu: cache smu fw version info
Thread-Index: AdYSMcqAXw33BUFrS0SxAhKaAVYnaw==
Date: Tue, 14 Apr 2020 07:54:28 +0000
Message-ID: <MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T07:54:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7fa29d7b-11e3-4e1c-b36a-0000e2a49d4e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T07:54:25Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b3779a80-2496-4166-b232-0000e6c80c67
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 538fa159-07ce-4b41-f425-08d7e0490f0b
x-ms-traffictypediagnostic: MN2PR12MB3999:|MN2PR12MB3999:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3999F0696DCABB8996751890FBDA0@MN2PR12MB3999.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(71200400001)(33656002)(52536014)(8676002)(7696005)(55016002)(99936003)(8936002)(110136005)(9686003)(86362001)(81156014)(478600001)(6506007)(316002)(558084003)(6636002)(76116006)(26005)(66446008)(66616009)(186003)(66946007)(64756008)(66556008)(66476007)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9PtVJUGudJDhp77LK1wKOnOqdYZGggo8jRcM6BMxrdWj8K1g+xk5tGGB1eCaiYipuer6BeINwDuiLxSTKPM9EUAo14lZ67Q1J/NHYvSESt/QtZB3eJP1GTPUbKxBAqgbBcwFXAEWxvPiRXQPpi9vAFiullLkxzI+gNQS3JlDIRjmdE/LglwGUeii6VJq08blxTSwLydAmYPCEd603R8jKh5/sGZZ/gXfzXxo5gZuPzCsb94sUlczLBHqn3T5Ka4Or1eKrVQDKOAE+Onm79RYg0l1a+M3jKLzBuS/sn0MYH0BR0qCZPX6ZkjfIvOGxgxtxzUwB5xO5wM+9BlJMcAiEN+YieSa3LSatDplkhKshrIv+/OKJIFoy5jKLCcLLpaEJ7/5uhA2bqqBs/V/HqVFZ9SlUJtjU+zj0/kq0E2xGMOqtm0WD7M8YMSREMVv8Y2
x-ms-exchange-antispam-messagedata: ivzkPTFI2rxQmGuxXOtEMkw6KN8Nyi4zpGLvCQ5aW3KMFBEKtepH71aKNTR0rj6kNc4pKkNa1UW/6BJnDWNeCokJ9aFC3u14RQtc3bi3eNYTqpkMA7nmlYHux5bpgeIG5nt/PALV+qhqbSI6r0wuwg==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538fa159-07ce-4b41-f425-08d7e0490f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 07:54:28.1243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1CC3ikQ+CHD+5tbSa0sJTzI0fQJ/ISzAa1UP0GdfkJ23RocXVH4C3f4emUmvjae3oInyEOyE31iBD+1WITNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3999
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

--_004_MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0MN2PR12MB4032namp_"

--_000_MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to save smu fw version in local smu context to avoid multi=
ple erroneous submissions to smu when requesting smu version info

Thank you,
John Clements

--_000_MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Submitting patch to save smu fw version in local smu=
 context to avoid multiple erroneous submissions to smu when requesting smu=
 version info<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0MN2PR12MB4032namp_--

--_004_MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-cache-smu-fw-version-info.patch"
Content-Description: 0001-drm-amdgpu-cache-smu-fw-version-info.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-cache-smu-fw-version-info.patch"; size=5436;
	creation-date="Tue, 14 Apr 2020 07:54:00 GMT";
	modification-date="Tue, 14 Apr 2020 07:54:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyOGNiMDgxYWVjMTljZTYyN2E5NjhhZjI2NDI5OGY3NGQ2Njg2NTk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMTQgQXByIDIwMjAgMTU6NTI6MjEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBjYWNoZSBzbXUgZncgdmVyc2lvbiBpbmZvCgpyZWR1Y2UgY21kIHN1Ym1pc3Np
b24gdG8gc211IGJ5IGNhY2hpbmcgdmVyc2lvbiBpbmZvCgpTaWduZWQtb2ZmLWJ5OiBKb2huIENs
ZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSTQxMDVhNGFmNDkzZDdi
NTI2N2IzZTBlMDM4MTRjNzQxYjNhNzdjMDUKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hbWRncHVfc211LmMgICAgIHwgMTUgKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oIHwgIDQgKysrLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jICAgICB8ICAyICstCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyAgICAgIHwgMTYgKysrKysrKystLS0tLS0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMgICAgICB8ICA0ICsrLS0K
IDUgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCmluZGV4IGFjYmJjNTA0ODJj
NC4uZDQ1OTlmYTZkYzBiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9hbWRncHVfc211LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1
X3NtdS5jCkBAIC0xOTYsMTYgKzE5NiwzMSBAQCBpbnQgc211X2dldF9zbWNfdmVyc2lvbihzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSwgdWludDMyX3QgKmlmX3ZlcnNpb24sIHVpbnQzMl90CiAJaWYg
KCFpZl92ZXJzaW9uICYmICFzbXVfdmVyc2lvbikKIAkJcmV0dXJuIC1FSU5WQUw7CiAKKwlpZiAo
c211LT5zbWNfZndfaWZfdmVyc2lvbiAmJiBzbXUtPnNtY19md192ZXJzaW9uKQorCXsKKwkJaWYg
KGlmX3ZlcnNpb24pCisJCQkqaWZfdmVyc2lvbiA9IHNtdS0+c21jX2Z3X2lmX3ZlcnNpb247CisK
KwkJaWYgKHNtdV92ZXJzaW9uKQorCQkJKnNtdV92ZXJzaW9uID0gc211LT5zbWNfZndfdmVyc2lv
bjsKKworCQlyZXR1cm4gMDsKKwl9CisKIAlpZiAoaWZfdmVyc2lvbikgewogCQlyZXQgPSBzbXVf
c2VuZF9zbWNfbXNnKHNtdSwgU01VX01TR19HZXREcml2ZXJJZlZlcnNpb24sIGlmX3ZlcnNpb24p
OwogCQlpZiAocmV0KQogCQkJcmV0dXJuIHJldDsKKworCQlzbXUtPnNtY19md19pZl92ZXJzaW9u
ID0gKmlmX3ZlcnNpb247CiAJfQogCiAJaWYgKHNtdV92ZXJzaW9uKSB7CiAJCXJldCA9IHNtdV9z
ZW5kX3NtY19tc2coc211LCBTTVVfTVNHX0dldFNtdVZlcnNpb24sIHNtdV92ZXJzaW9uKTsKIAkJ
aWYgKHJldCkKIAkJCXJldHVybiByZXQ7CisKKwkJc211LT5zbWNfZndfdmVyc2lvbiA9ICpzbXVf
dmVyc2lvbjsKIAl9CiAKIAlyZXR1cm4gcmV0OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2luYy9hbWRncHVfc211LmgKaW5kZXggMzA2NDNiOWI1YjNiLi45MjhlZWQyMjBmOTMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaApA
QCAtNDA1LDcgKzQwNSw5IEBAIHN0cnVjdCBzbXVfY29udGV4dAogCWJvb2wgcG1fZW5hYmxlZDsK
IAlib29sIGlzX2FwdTsKIAotCXVpbnQzMl90IHNtY19pZl92ZXJzaW9uOworCXVpbnQzMl90IHNt
Y19kcml2ZXJfaWZfdmVyc2lvbjsKKwl1aW50MzJfdCBzbWNfZndfaWZfdmVyc2lvbjsKKwl1aW50
MzJfdCBzbWNfZndfdmVyc2lvbjsKIAogCWJvb2wgdXBsb2FkaW5nX2N1c3RvbV9wcF90YWJsZTsK
IAlib29sIGRjX2NvbnRyb2xsZWRfYnlfZ3BpbzsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L3Jlbm9pcl9wcHQuYwppbmRleCBkOWUxMzY1ZWVhZmUuLjI4MWI3YjZjZjFhNCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYwpAQCAtOTUwLDYgKzk1MCw2
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHB0YWJsZV9mdW5jcyByZW5vaXJfcHB0X2Z1bmNzID0g
ewogdm9pZCByZW5vaXJfc2V0X3BwdF9mdW5jcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIHsK
IAlzbXUtPnBwdF9mdW5jcyA9ICZyZW5vaXJfcHB0X2Z1bmNzOwotCXNtdS0+c21jX2lmX3ZlcnNp
b24gPSBTTVUxMl9EUklWRVJfSUZfVkVSU0lPTjsKKwlzbXUtPnNtY19kcml2ZXJfaWZfdmVyc2lv
biA9IFNNVTEyX0RSSVZFUl9JRl9WRVJTSU9OOwogCXNtdS0+aXNfYXB1ID0gdHJ1ZTsKIH0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKaW5kZXggYTk2ZWEzZTE0MWRj
Li5hOTdiMjk2NGNhN2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3NtdV92MTFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFf
MC5jCkBAIC0yNjYsMjMgKzI2NiwyMyBAQCBpbnQgc211X3YxMV8wX2NoZWNrX2Z3X3ZlcnNpb24o
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUpCiAKIAlzd2l0Y2ggKHNtdS0+YWRldi0+YXNpY190eXBl
KSB7CiAJY2FzZSBDSElQX1ZFR0EyMDoKLQkJc211LT5zbWNfaWZfdmVyc2lvbiA9IFNNVTExX0RS
SVZFUl9JRl9WRVJTSU9OX1ZHMjA7CisJCXNtdS0+c21jX2RyaXZlcl9pZl92ZXJzaW9uID0gU01V
MTFfRFJJVkVSX0lGX1ZFUlNJT05fVkcyMDsKIAkJYnJlYWs7CiAJY2FzZSBDSElQX0FSQ1RVUlVT
OgotCQlzbXUtPnNtY19pZl92ZXJzaW9uID0gU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fQVJDVDsK
KwkJc211LT5zbWNfZHJpdmVyX2lmX3ZlcnNpb24gPSBTTVUxMV9EUklWRVJfSUZfVkVSU0lPTl9B
UkNUOwogCQlicmVhazsKIAljYXNlIENISVBfTkFWSTEwOgotCQlzbXUtPnNtY19pZl92ZXJzaW9u
ID0gU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fTlYxMDsKKwkJc211LT5zbWNfZHJpdmVyX2lmX3Zl
cnNpb24gPSBTTVUxMV9EUklWRVJfSUZfVkVSU0lPTl9OVjEwOwogCQlicmVhazsKIAljYXNlIENI
SVBfTkFWSTEyOgotCQlzbXUtPnNtY19pZl92ZXJzaW9uID0gU01VMTFfRFJJVkVSX0lGX1ZFUlNJ
T05fTlYxMjsKKwkJc211LT5zbWNfZHJpdmVyX2lmX3ZlcnNpb24gPSBTTVUxMV9EUklWRVJfSUZf
VkVSU0lPTl9OVjEyOwogCQlicmVhazsKIAljYXNlIENISVBfTkFWSTE0OgotCQlzbXUtPnNtY19p
Zl92ZXJzaW9uID0gU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fTlYxNDsKKwkJc211LT5zbWNfZHJp
dmVyX2lmX3ZlcnNpb24gPSBTTVUxMV9EUklWRVJfSUZfVkVSU0lPTl9OVjE0OwogCQlicmVhazsK
IAlkZWZhdWx0OgogCQlwcl9lcnIoInNtdSB1bnN1cHBvcnRlZCBhc2ljIHR5cGU6JWQuXG4iLCBz
bXUtPmFkZXYtPmFzaWNfdHlwZSk7Ci0JCXNtdS0+c21jX2lmX3ZlcnNpb24gPSBTTVUxMV9EUklW
RVJfSUZfVkVSU0lPTl9JTlY7CisJCXNtdS0+c21jX2RyaXZlcl9pZl92ZXJzaW9uID0gU01VMTFf
RFJJVkVSX0lGX1ZFUlNJT05fSU5WOwogCQlicmVhazsKIAl9CiAKQEAgLTI5NCwxMCArMjk0LDEw
IEBAIGludCBzbXVfdjExXzBfY2hlY2tfZndfdmVyc2lvbihzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSkKIAkgKiBDb25zaWRlcmluZyBhYm92ZSwgd2UganVzdCBsZWF2ZSB1c2VyIGEgd2FybmluZyBt
ZXNzYWdlIGluc3RlYWQKIAkgKiBvZiBoYWx0IGRyaXZlciBsb2FkaW5nLgogCSAqLwotCWlmIChp
Zl92ZXJzaW9uICE9IHNtdS0+c21jX2lmX3ZlcnNpb24pIHsKKwlpZiAoaWZfdmVyc2lvbiAhPSBz
bXUtPnNtY19kcml2ZXJfaWZfdmVyc2lvbikgewogCQlwcl9pbmZvKCJzbXUgZHJpdmVyIGlmIHZl
cnNpb24gPSAweCUwOHgsIHNtdSBmdyBpZiB2ZXJzaW9uID0gMHglMDh4LCAiCiAJCQkic211IGZ3
IHZlcnNpb24gPSAweCUwOHggKCVkLiVkLiVkKVxuIiwKLQkJCXNtdS0+c21jX2lmX3ZlcnNpb24s
IGlmX3ZlcnNpb24sCisJCQlzbXUtPnNtY19kcml2ZXJfaWZfdmVyc2lvbiwgaWZfdmVyc2lvbiwK
IAkJCXNtdV92ZXJzaW9uLCBzbXVfbWFqb3IsIHNtdV9taW5vciwgc211X2RlYnVnKTsKIAkJcHJf
d2FybigiU01VIGRyaXZlciBpZiB2ZXJzaW9uIG5vdCBtYXRjaGVkXG4iKTsKIAl9CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTJfMC5jCmluZGV4IDRmYzY4ZDQ2MDBlMC4uNDAy
M2QxMGZiNDliIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVf
djEyXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYwpA
QCAtMTYwLDEwICsxNjAsMTAgQEAgaW50IHNtdV92MTJfMF9jaGVja19md192ZXJzaW9uKHN0cnVj
dCBzbXVfY29udGV4dCAqc211KQogCSAqIENvbnNpZGVyaW5nIGFib3ZlLCB3ZSBqdXN0IGxlYXZl
IHVzZXIgYSB3YXJuaW5nIG1lc3NhZ2UgaW5zdGVhZAogCSAqIG9mIGhhbHQgZHJpdmVyIGxvYWRp
bmcuCiAJICovCi0JaWYgKGlmX3ZlcnNpb24gIT0gc211LT5zbWNfaWZfdmVyc2lvbikgeworCWlm
IChpZl92ZXJzaW9uICE9IHNtdS0+c21jX2RyaXZlcl9pZl92ZXJzaW9uKSB7CiAJCXByX2luZm8o
InNtdSBkcml2ZXIgaWYgdmVyc2lvbiA9IDB4JTA4eCwgc211IGZ3IGlmIHZlcnNpb24gPSAweCUw
OHgsICIKIAkJCSJzbXUgZncgdmVyc2lvbiA9IDB4JTA4eCAoJWQuJWQuJWQpXG4iLAotCQkJc211
LT5zbWNfaWZfdmVyc2lvbiwgaWZfdmVyc2lvbiwKKwkJCXNtdS0+c21jX2RyaXZlcl9pZl92ZXJz
aW9uLCBpZl92ZXJzaW9uLAogCQkJc211X3ZlcnNpb24sIHNtdV9tYWpvciwgc211X21pbm9yLCBz
bXVfZGVidWcpOwogCQlwcl93YXJuKCJTTVUgZHJpdmVyIGlmIHZlcnNpb24gbm90IG1hdGNoZWRc
biIpOwogCX0KLS0gCjIuMTcuMQoK

--_004_MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB4032D32E4A4E55CF7DA771F7FBDA0MN2PR12MB4032namp_--
