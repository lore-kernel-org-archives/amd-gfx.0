Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D37BC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F39C20738
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bxAdU7nR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F39C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B766E20F;
	Mon,  3 Aug 2020 06:48:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192A06E20D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 06:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQf4qeidgxg0+A1zTcDtWNWmK3+9JpkuCA8tGUZa8pSdOhOwD7LNnbb1Tv72NqoGRNrKTDgEuc/EL6FX3JX5dK4nYWx7fdcMQGaKeP6NK3i8f6CY1CyMB6bBJFUYiwTkG46n4JqjXdF+6XwnTywdeKU63iJF05jN5RoOowtfuM5brDD7C/PxRBeQt9nVN2p4mCfCZylFGXJqORHX7hR3R8TkNwpOdNZSXTjwZI+G0RggrwvizGSJwXtzbU3XDassmyRVSpLZz945dI5+fEP0I0LFNyA7GaUjELlH1mXTBi5W3fPi1O7BdPBiCg3uNfQ0RqCnvV8PizU/mOJMKOmqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zf84kkabjsDwymZtWXq14SEBC4v+VjEsxNI+LqP+Rc=;
 b=ciRcxLDmahSSUZ9WLRqA4VK71GsPZnG4QpIpPWrf0Bc9XQzMXw3nOWzxfcCtMiF9GZE9oReQif7rgVapkafQtkhQ7uPD8MBTB8jk19dcEjnibJme+wLWeXwDZkd/o1B1ubVXNmruDyVX+qxg1RjS05cEXo/7DHa4UPyWXLTWf2U7WbXMwD7s5DnNGsf1hc+3wJaOeCKlWONIQGR5uf2rZbIYbrub5kWTmuK+gb9gwk3TbOukE894bV5OUqUJb/PEgJw9ASl2H/o2Zgj+GG2XZOB/YuJHQmi9J//yrL0xTQm+ysY82vVpKYEisELMiWo5b0yVPKSrygEEMLP2zw0BLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zf84kkabjsDwymZtWXq14SEBC4v+VjEsxNI+LqP+Rc=;
 b=bxAdU7nRB3nSpqjIpigRqDatDaMTYDCggJN4ySIMLn19mzO0kp2GJ6dx1WdE/FHa/byHcr5wsSkUg8MuInmJ6gvCFFndaSI1LDzzPniRBKxxaESld8eDVGAFmPjdfFZFjIVxEbveZ/FuKcgJRnxsvbvVzIsLlbu1UG8Jc7TW4os=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Mon, 3 Aug
 2020 06:48:26 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3239.016; Mon, 3 Aug 2020
 06:48:26 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: added RAS EEPROM device support check
Thread-Topic: [PATCH] drm/amdgpu: added RAS EEPROM device support check
Thread-Index: AdZpYeqQlMOCJDtATiOcCxe+S+7zUA==
Date: Mon, 3 Aug 2020 06:48:26 +0000
Message-ID: <MN2PR12MB403277D8F0483FBC2AC9540EFB4D0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-03T06:48:18Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ce3385a2-1571-436d-89c9-0000efcba210;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-03T06:48:14Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8bb0e061-4bfe-4f67-b5b4-0000b1cd10bc
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-03T06:48:20Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f44c4255-b8e6-401d-bbec-00002da3950b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f8d378e-2602-4e72-006c-08d837793988
x-ms-traffictypediagnostic: MN2PR12MB4287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42879F5F7405DC22BDC759D5FB4D0@MN2PR12MB4287.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yF5pUDrHXumGMQsLZE2NpFLd5tAIgiXFKr9Cnx/hGV4JB3LJ9RUdxbbKdzm12HC5owoVG/N1JLPrnfBCS+X889TUFGNUEtKRSqJ3LIQtFVbQq5F6Q0L8J5uN1VVG/pBd31k9xtTT3J+EMfgX3j3uBFPkDxzkdy6fhkl2lxFZMRzdnGKIrDR9RK/BNVLDzzmDqTcLPVbDq/BQLp+N9CMyM6okSEgCAH8UTGDCQl9AmjQ+EP9djWlC4oKKmpRapXx3OaJMdS3DDKLIJkPwsKTCOYabc5q5j60YIJgBA02NYax939W6ou5vGVENnlNffpwGEJWLXKNDXqOCch7RTfKKJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(6636002)(7696005)(64756008)(66446008)(66556008)(66616009)(8676002)(478600001)(9686003)(71200400001)(2906002)(55016002)(66946007)(76116006)(558084003)(33656002)(66476007)(52536014)(26005)(86362001)(83380400001)(316002)(186003)(6506007)(110136005)(99936003)(5660300002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: NyX4XjGc4JTqRkZg/5qt3UU8LwwQHj+UsClb6FC+ZpBUT9K8+MZd8lIHvpHKUCWmXkE/vFD8f82+PXDxfvDlhdR0Wn7oBbj4BXq/FuTLN1ZuxdtSxPquN+mqTq7nZPdAGOAlFsWp5QQx1349gaw3GVh3SbVym/PKBXVWd4aLxbkRGsLuqZajADUZ9yby+2HWlwxfMG33lWOQGjcBxRe+TKlI7YEy6FwCIyZBJm/4ZjuEto4YHD1U9FjHmIQJL1X4Lh4QJKmhVncG9bPGyBhnqpc5vO0jN6yZ+rwLl9mPCE238+0fGAJIcv4AutRdYzRfqGbydrdUPRv4J1z2xr6FUEtF2jBYszGM6YkiV1m2xkAJItXZnI9nz0Icn8NI70Kqvdbdm9w5sXXcfdC9887G11GcWWAjVkGX86/cvEWG5/R/8j9a5NsNeI60CL6BgT+o0ivoRdyMTM6EUFqpVLF7ur2lP0XgppEinAig0e1UdH37aGJRjhtbbvvSCHR5yKO6RTZoWLFrX/419opJdTsOJPi/a9ReHUS7yYCiIMNcyrH1EZUaQMx0skYrdX70MZVQD1fRmpOOFWF4optXmb1qCsXeBT93gT47kLHHJMB1j4rFLmDoITskWA1U8B+L3EDFEmoP9DEcDcfgow6O8twVng==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB403277D8F0483FBC2AC9540EFB4D0MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8d378e-2602-4e72-006c-08d837793988
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 06:48:26.7840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCQYsFksZEsgCFmxpQLb1FSaC3+4aRP2KjsDt5MPcPMhWsQQAOSdglN5myRd50BjcHN+QAn2qwaJhy/NVRzxCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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

--_004_MN2PR12MB403277D8F0483FBC2AC9540EFB4D0MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB403277D8F0483FBC2AC9540EFB4D0MN2PR12MB4032namp_"

--_000_MN2PR12MB403277D8F0483FBC2AC9540EFB4D0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch to with added device support check before trying to access=
 RAS EEPROM.

Thank you,
John Clements

--_000_MN2PR12MB403277D8F0483FBC2AC9540EFB4D0MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Submitting patch to with added device support check =
before trying to access RAS EEPROM.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB403277D8F0483FBC2AC9540EFB4D0MN2PR12MB4032namp_--

--_004_MN2PR12MB403277D8F0483FBC2AC9540EFB4D0MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-added-RAS-EEPROM-device-support-check.patch"
Content-Description:  0001-drm-amdgpu-added-RAS-EEPROM-device-support-check.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-added-RAS-EEPROM-device-support-check.patch";
	size=2057; creation-date="Mon, 03 Aug 2020 06:47:00 GMT";
	modification-date="Mon, 03 Aug 2020 06:47:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwNjZkMjdiM2RmY2M3NWIzOGRlMzVhYWY1ZDg5OTkyNDc2NzY1NWEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IE1vbiwgMyBBdWcgMjAyMCAxNDo0NTo1OCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGFkZGVkIFJBUyBFRVBST00gZGV2aWNlIHN1cHBvcnQgY2hlY2sKCnVwZGF0ZWQg
UkFTIEVFUFJPTSBpbml0L3RocmVzaG9sZCBzZXF1ZW5jZXMgdG8gY2hlY2sgZm9yIGRldmljZSBz
dXBwb3J0CgpTaWduZWQtb2ZmLWJ5OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5j
b20+CkNoYW5nZS1JZDogSWI4OGYyYmE3ZjcxNmEwMDcxMjNmN2ZiNDc0Yjk4Y2FkNDE2NmY2ZTIK
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jIHwgMTcg
KysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhc19lZXByb20uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVw
cm9tLmMKaW5kZXggZTVlM2VkMTEzZDYzLi45NjFjOGNkYzc1YmYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYwpAQCAtNTksNiArNTksMTUgQEAK
IAogI2RlZmluZSB0b19hbWRncHVfZGV2aWNlKHgpIChjb250YWluZXJfb2YoeCwgc3RydWN0IGFt
ZGdwdV9yYXMsIGVlcHJvbV9jb250cm9sKSktPmFkZXYKIAorc3RhdGljIGJvb2wgX19pc19yYXNf
ZWVwcm9tX3N1cHBvcnRlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK3sKKwlpZiAoKGFk
ZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMCkgfHwKKwkgICAgKGFkZXYtPmFzaWNfdHlwZSA9
PSBDSElQX0FSQ1RVUlVTKSkKKwkJcmV0dXJuIHRydWU7CisKKwlyZXR1cm4gZmFsc2U7Cit9CisK
IHN0YXRpYyBib29sIF9fZ2V0X2VlcHJvbV9pMmNfYWRkcl9hcmN0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCQkJCSAgICAgICB1aW50MTZfdCAqaTJjX2FkZHIpCiB7CkBAIC0yNzQsNiAr
MjgzLDkgQEAgaW50IGFtZGdwdV9yYXNfZWVwcm9tX2luaXQoc3RydWN0IGFtZGdwdV9yYXNfZWVw
cm9tX2NvbnRyb2wgKmNvbnRyb2wsCiAJCQkuYnVmCT0gYnVmZiwKIAl9OwogCisJaWYgKCFfX2lz
X3Jhc19lZXByb21fc3VwcG9ydGVkKGFkZXYpKQorCQlyZXR1cm4gMDsKKwogCSpleGNlZWRfZXJy
X2xpbWl0ID0gZmFsc2U7CiAKIAkvKiBWZXJpZnkgaTJjIGFkYXB0ZXIgaXMgaW5pdGlhbGl6ZWQg
Ki8KQEAgLTQyOCw2ICs0NDAsOSBAQCBpbnQgYW1kZ3B1X3Jhc19lZXByb21fY2hlY2tfZXJyX3Ro
cmVzaG9sZCgKIAl9OwogCWludCByZXQ7CiAKKwlpZiAoIV9faXNfcmFzX2VlcHJvbV9zdXBwb3J0
ZWQoYWRldikpCisJCXJldHVybiAwOworCiAJKmV4Y2VlZF9lcnJfbGltaXQgPSBmYWxzZTsKIAog
CS8qIHJlYWQgRUVQUk9NIHRhYmxlIGhlYWRlciAqLwpAQCAtNDY1LDcgKzQ4MCw3IEBAIGludCBh
bWRncHVfcmFzX2VlcHJvbV9wcm9jZXNzX3JlY29kcyhzdHJ1Y3QgYW1kZ3B1X3Jhc19lZXByb21f
Y29udHJvbCAqY29udHJvbCwKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHRvX2FtZGdw
dV9kZXZpY2UoY29udHJvbCk7CiAJc3RydWN0IGFtZGdwdV9yYXMgKnJhcyA9IGFtZGdwdV9yYXNf
Z2V0X2NvbnRleHQoYWRldik7CiAKLQlpZiAoYWRldi0+YXNpY190eXBlICE9IENISVBfVkVHQTIw
ICYmIGFkZXYtPmFzaWNfdHlwZSAhPSBDSElQX0FSQ1RVUlVTKQorCWlmICghX19pc19yYXNfZWVw
cm9tX3N1cHBvcnRlZChhZGV2KSkKIAkJcmV0dXJuIDA7CiAKIAlidWZmcyA9IGtjYWxsb2MobnVt
LCBFRVBST01fQUREUkVTU19TSVpFICsgRUVQUk9NX1RBQkxFX1JFQ09SRF9TSVpFLAotLSAKMi4x
Ny4xCgo=

--_004_MN2PR12MB403277D8F0483FBC2AC9540EFB4D0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB403277D8F0483FBC2AC9540EFB4D0MN2PR12MB4032namp_--
