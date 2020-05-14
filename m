Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B19CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 03:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20ABD20659
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 03:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b16jwrPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ABD20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8636E05A;
	Thu, 14 May 2020 03:23:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1C66E05A
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 03:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0U42iYJSaM0MHHdM6+BasGvGqv3RPKiyWvIxVnjwlL5rTwxGBc5Xikod6eXrP9zjruUZLmBymYwC3wg6RTY8NCIaBXrNFl37LVOpjKHxjvbpkgUhxma3oy6tbWM+w4hq5YEg1r9sPaI5sdOCuDQgsLzS+44g7RMOhafsC3JQ3vhCF3Vi+R0QQEJYetWPvkLj7JAHkGo7u2Rd163mAjnKk7R9+bvad365OJWhrcATQr+7rLm+nwq3vDj0RLBTzp1QblDnW7V2SkFiaIfzXFKZ69neAq0z0WtzYb31uPrDhxW21G7M2lbJOIw6oY9i+JX3SfzXZiMe9X68ukXf4t6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OBKHcjOBiAIyi5arp0AWwWJWEQPUMdaTF4NOfw1QQE=;
 b=H7RF0ra8buvUIV6xZLYUuV60hPATx4lZ/1RKSbw8fsgItpRDghRzlwfFg+pAaMpoIdO1TWVVG1ZkTvrCzAeGHrPbDVCnVaJQj3UnMx6R3t4MRH0M30PRbb/9R4OGx5/vFapisb1G1ZTXtDNTRVNJMn7IR1u4QFSRCtuFEF19htmx0gaf8vQrtzhpSM321FO/Ofk7CjUHJdFT70K50aaK+9RouhzqYlYCqFOOHZxVSjU7p4F102EdCiHYSPCicPooK1NTB6j+pUSoO8EQ6/wgCFn6DEZcdgcZwUkZgfG47HG8DoEGSvlL1KFHagvUpGARTEeYF1XCm2PfoJreW0xGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OBKHcjOBiAIyi5arp0AWwWJWEQPUMdaTF4NOfw1QQE=;
 b=b16jwrPIZnbCZGUWx4Jc2ftmILxRxzQa97yDnMz+lCm4bSpmC7xcIIInMB0sWalGXzXcs2gfBaKPLfmSIUHNHh1Bn5KiIo8WsfarKjKEjgv66DQVgg6g/uELoAhjUXdJax9RfR1Kx3sT/3nha7Ea8ZZD7dH1n42cNiMEW35jSJw=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 14 May
 2020 03:23:09 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8%7]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 03:23:09 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Updated XGMI power down control support check
Thread-Topic: [PATCH] drm/amdgpu: Updated XGMI power down control support check
Thread-Index: AdYpnuomCOWNN6xTQ3qSrEzRWEr9bQ==
Date: Thu, 14 May 2020 03:23:09 +0000
Message-ID: <MN2PR12MB403246890DD1D28759B02AE4FBBC0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-14T03:23:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=872cd518-927d-4e3b-9445-0000cec78b44;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-14T03:23:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 39817282-9ea9-4fef-8120-00006af07d3a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d9daba4-fa9a-4a20-1e9f-08d7f7b6208e
x-ms-traffictypediagnostic: MN2PR12MB3117:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31171A5F4D5D057C75C8AC19FBBC0@MN2PR12MB3117.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uv4+BuuCmi90RR/XdMfoSDSPYGLQ9NccVAP4xQnfkvr7ASqQt3PdpAMb1XTKofn05ZflLQwmnj2sWNJB7MyHf/zTR5KkE0UjhwZZ0Ht45LFSf/C7nil4MIc2GAds8RU7/qqLk0DWfBUQzET8MSFmA+eVmkB1HCPWYf2PPUQzpLqKvyHBmYDJPTaZ/scLMTpIKIPP96JD254RljS3lmp4cy36GCUdYEh5tCWFi1c2WjSAliUhf+pNWtHKVBNUMJgiO07Vhp/GwpcDjb8Wseb6eehOHG+jtMYQ8LRW5XKff2sMutPohqXimOJUaiS5xxIskhZOopAY8bTuGYXgxhtYpXNkCRdleIPqV7KlG4dBcOSE52Yi3iGe5c65vsFGJihz1Kusta3lQkhvjIx/5oN2+iCfOkK1jNIw7yIHeyopwOGspQ7eY5zrEoLvoPGRqKjb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(2906002)(186003)(8936002)(5660300002)(6636002)(33656002)(71200400001)(26005)(478600001)(52536014)(558084003)(66476007)(7696005)(9686003)(55016002)(316002)(15650500001)(110136005)(66946007)(6506007)(86362001)(66616009)(8676002)(76116006)(99936003)(64756008)(66556008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mLBJR5onN/pYbJGZTOM3e+q9QEpjZUobnqNeJzbbQxGz9LvR1OmxcfXMc5twP6PZz4kSuWtp5rucRJP8QwfRjOgbUbF/sgnFCfqgj4mwG7nyOttXefS19IQ4od/nf57pFypcctVzkEXHnVdbKAO3CBveDZUl8wYk5XxEqCaHQ5kfEVKnXwHnnkjJIRMczoy7geM3UpukDIKIP9RJZ3v8Rme9VQ54kYB1woPscEPJxNGp1eBQHmXR+TbRwrWMo4yuqipV5IxygdQhh07ccFuuPBGKUPD+vdijJ/YI0iS5oE+Jc7OlWwCMKQrikVfUzanuZ/0bMzEppoatsQZcXZiAYswvFUmkB0Ln8P2XkAK2a6VG6xbQSvZzgOhUnZhMU8q5r8LdWxW9mXdTb5evP0wJb/gAGY+h20CH+M2xAicmUp+s4TJjQlAKFuv6BapgzLwwSn+5P6n3yba05mX9q6CpSmVmyN15gAMp2FkmquQPfxLDO6VhPR2a/QKszhofduqv
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB403246890DD1D28759B02AE4FBBC0MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9daba4-fa9a-4a20-1e9f-08d7f7b6208e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 03:23:09.7348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxrli36qI5sGjAW1rE9vTpaclBR3CSvq9oFnsvcLAV5CQz4QNwMFONQK/aYiNabcaBMM8f/Rn7UUfoZXKpGRgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3117
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

--_004_MN2PR12MB403246890DD1D28759B02AE4FBBC0MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB403246890DD1D28759B02AE4FBBC0MN2PR12MB4032namp_"

--_000_MN2PR12MB403246890DD1D28759B02AE4FBBC0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Updated SMC FW version check to determine if XGMI power down control is sup=
ported

--_000_MN2PR12MB403246890DD1D28759B02AE4FBBC0MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Updated SMC FW version check to determine if XGMI po=
wer down control is supported<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB403246890DD1D28759B02AE4FBBC0MN2PR12MB4032namp_--

--_004_MN2PR12MB403246890DD1D28759B02AE4FBBC0MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Updated-XGMI-power-down-control-support-c.patch"
Content-Description:  0001-drm-amdgpu-Updated-XGMI-power-down-control-support-c.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Updated-XGMI-power-down-control-support-c.patch";
	size=1310; creation-date="Thu, 14 May 2020 03:22:00 GMT";
	modification-date="Thu, 14 May 2020 03:22:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2NzhmY2U0YTI2Nzk3NDFhMWVmNTgzY2U3OTEzNmE0M2RkM2NhN2EzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgMTQgTWF5IDIwMjAgMTE6MjE6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBVcGRhdGVkIFhHTUkgcG93ZXIgZG93biBjb250cm9sIHN1cHBvcnQgY2hlY2sK
ClVwZGF0ZWQgU01DIEZXIHZlcnNpb24gY2hlY2sgdG8gZGV0ZXJtaW5lIGlmIFhHTUkgcG93ZXIg
ZG93biBjb250cm9sIGlzIHN1cHBvcnRlZAoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8
am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEkxM2FkODAyZmM5MjgyZjVhNmZlNWEw
M2ExNjU1Nzg5ZWJjZmNhNGZjCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJj
dHVydXNfcHB0LmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9hcmN0dXJ1c19wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVz
X3BwdC5jCmluZGV4IDQ4NzRhMjBjY2RmMS4uY2JmNzAxMjJkZTliIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYwpAQCAtMjI5OCw5ICsyMjk4LDkgQEAg
c3RhdGljIGludCBhcmN0dXJ1c19hbGxvd194Z21pX3Bvd2VyX2Rvd24oc3RydWN0IHNtdV9jb250
ZXh0ICpzbXUsIGJvb2wgZW4pCiAJCXJldHVybiByZXQ7CiAJfQogCi0JLyogUFBTTUNfTVNHX0dt
aVB3ckRuQ29udHJvbCBpcyBzdXBwb3J0ZWQgYnkgNTQuMjAuMCBhbmQgb253YXJkcyAqLwotCWlm
IChzbXVfdmVyc2lvbiA8IDB4MzY1MDAwKSB7Ci0JCXByX2VycigiWEdNSSBwb3dlciBkb3duIGNv
bnRyb2wgaXMgb25seSBzdXBwb3J0ZWQgYnkgUE1GVyA1NC4yMC4wIGFuZCBvbndhcmRzXG4iKTsK
KwkvKiBQUFNNQ19NU0dfR21pUHdyRG5Db250cm9sIGlzIHN1cHBvcnRlZCBieSA1NC4yMy4wIGFu
ZCBvbndhcmRzICovCisJaWYgKHNtdV92ZXJzaW9uIDwgMHgwMDM2MTcwMCkgeworCQlwcl9lcnIo
IlhHTUkgcG93ZXIgZG93biBjb250cm9sIGlzIG9ubHkgc3VwcG9ydGVkIGJ5IFBNRlcgNTQuMjMu
MCBhbmQgb253YXJkc1xuIik7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KIAotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB403246890DD1D28759B02AE4FBBC0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB403246890DD1D28759B02AE4FBBC0MN2PR12MB4032namp_--
