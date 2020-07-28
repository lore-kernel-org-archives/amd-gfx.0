Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD7C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 02:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FD42070A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 02:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HixrBGbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FD42070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF69089E5B;
	Tue, 28 Jul 2020 02:41:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B98B89E5B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 02:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhVIvx5YDcZQuwcw0/ztpwjZ99IfPkmO8hJI/BpFdjpmshncRtwKuNRM/Racb2tp0rrAnoriG1jFdgWoGv8LYh8bKGfRrb1zG5hWcWHd6YSJT9GFyxCZjtT2n4nGCms6mDQbY+C7eJvzMpzvswlBT8WL9a2H4Hi/3ggm5Ia8aX4cunIKNGEKjaxFILnaPNg7TlO7vZ7rSNIXAwbGSMv5LzwmqQFGa9ZdM/ZG9vjpAZre1mOqq09flUdEUUPZImzBHYpiunSXTK8a1Y7pq08yG26kwIdt1G2a6jB1uhclVRPp4G/4cy1uVfqJAy85wL42rdagDpFApAt4DOMKVXvNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSUNYFLRAeF36Nv8d0ppHQioYZC/IReS/vglURdTX9o=;
 b=jeSzhbd8MRNYdmluM6LEm+iNg7VSvzdoTBh8W8HQyx35jEgCZcvvEPHSeUUOXMzQAJVQlEJxJgrYgpQrarqVbMFVKRK+SDH7bkfypaewe8J7sdYBq1ailcvvy2bFsWRD6Fy0XNRMd9MJCqNI67NZnJ+ZhGqE7tlC6cxhJ+lcWmgF9NQ1gP6mxki8QUTXLtXMNtSyWhdPgR+Ho0WS0PYtnvXz8rZzmuhFCMJ4hZa38rJrV1xk7ItYUhp79G9XP7sJ7IWAZ/KHe9xQgy8kTfb7nRBXQ/B5/wwJj04Kemouw3i5LtLx0ZOyRYtGan0XzVoEXg9ofOcP42C+cDrrVI+4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSUNYFLRAeF36Nv8d0ppHQioYZC/IReS/vglURdTX9o=;
 b=HixrBGbDR3N5kOhhTi7JrOqevnKpgTWztvohzeREnmILQ1/1rJx3CLwGYuDTZAklgFdrTtTAd7tTGJ+6QS9fg0c8yqE94By+CbwT6IUub4aK/ywDm83JMTFxpB7jToEPiFjLdImJqOb9YrOm1zvGnl3XyXTNj2UAsyoQpZlaQko=
Received: from BY5PR12MB4019.namprd12.prod.outlook.com (2603:10b6:a03:1a8::23)
 by BYAPR12MB3639.namprd12.prod.outlook.com (2603:10b6:a03:db::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Tue, 28 Jul
 2020 02:41:50 +0000
Received: from BY5PR12MB4019.namprd12.prod.outlook.com
 ([fe80::c5e4:b405:5508:19d7]) by BY5PR12MB4019.namprd12.prod.outlook.com
 ([fe80::c5e4:b405:5508:19d7%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 02:41:50 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add umv v8.7 source to makefile
Thread-Topic: [PATCH] drm/amdgpu: add umv v8.7 source to makefile
Thread-Index: AdZkiI02shJIQC2IR1iMu8smSKXOUQ==
Date: Tue, 28 Jul 2020 02:41:50 +0000
Message-ID: <BY5PR12MB40198080B5B48F8BA7E97E74FB730@BY5PR12MB4019.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-28T02:41:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fd2a3e49-32fe-46b9-b686-0000b58165df;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-28T02:41:40Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 01332ac9-6bae-45df-8dbb-00005d535836
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-28T02:41:46Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: abf324f9-bae7-46ed-86ac-00006cf5f7aa
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 737d8220-d5fc-4396-c413-08d8329fc792
x-ms-traffictypediagnostic: BYAPR12MB3639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3639574187853F19078AAEFBFB730@BYAPR12MB3639.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:321;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xB+onrd0gbrkDR6afJR/lk7vKWT2wR5nbbFKb8DHmel+5d+xdemwlaEYIo9CI2j/Vc6CKnHjtygOWKEfuf0AZJHl9ugikk08mnPmYzOGWRS1qlwDoFL7eRaANfB95nAsuCQ993sTGOFSuYkw817hlveNeJELYDFhTJF1Qje/+Dajc7Gb53I4A9DURHkkHZlXrIwk9IWpQSlUpPl3pynjj7b/EG1+BjIutvyaTyTBu/CBHocgFyGTVnUxPe183fjZAVZgBfP6FJGvYJeDrjk7RPIZe1kJKrXzuRVCtMn45fNJCs3W9mVlbfklpSixXVlE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4019.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(71200400001)(5660300002)(52536014)(6636002)(66616009)(33656002)(8676002)(558084003)(66946007)(7696005)(478600001)(55016002)(6506007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(26005)(2906002)(316002)(110136005)(9686003)(8936002)(99936003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4w+VLw5tYR9+yMRtVh3ChgZdu4JJVKw5uROAA2BHD2P75bO6AlyA9GOyGtQRrqRtObbwuS+JIx0EKdZJC0ML7bHLig+OKj56dYk+rJlv1dIVoME+47MePU5XdjnJ6STeKc1XfRDoNJ0D1hU4G6BlfACpioKty4qzFXRaxkts4p5AVJMbu29GB8p+3/60m/z0fUIq14QXAXKutNUzm9gvBYZ2okVT3409fRhd7EqGXb1GpZHPK2o2ieKjptx691gIOkXP7f2TH99PJ1D2vbLN5P8g6VAGP1JMd4pHhet5Bip/yJYDMuP+Y7ycq1+Jyrur4ViN1Ril964v/dsjecVCkqOIqXy7QKqV1jk7Z/OLgejgMjAEtWEN16P64GsTJBTLmJh3ev07mxHC4MI8Am26SFPlVzZpopewUVhwiiAPgLW8DB3IOHVaP7DJgzShjUKrZMf+7o32okwLjGpjpSYD2TU3ikwYniwtR712S+/qy2lrBa5M1CI36FH4oVFT3fZH
Content-Type: multipart/mixed;
 boundary="_004_BY5PR12MB40198080B5B48F8BA7E97E74FB730BY5PR12MB4019namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4019.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737d8220-d5fc-4396-c413-08d8329fc792
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 02:41:50.1109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ad/ClvLdUmNmtVo0NhcqK0atiap1kI3FYKjUxgU6pfTRxj87f2V/nDLwaMWB1ELo2K6fYGmVE8BE0Lhgl+Cdng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3639
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

--_004_BY5PR12MB40198080B5B48F8BA7E97E74FB730BY5PR12MB4019namp_
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB40198080B5B48F8BA7E97E74FB730BY5PR12MB4019namp_"

--_000_BY5PR12MB40198080B5B48F8BA7E97E74FB730BY5PR12MB4019namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch to add UMC 8.7 source file to makefile

--_000_BY5PR12MB40198080B5B48F8BA7E97E74FB730BY5PR12MB4019namp_
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
<p class=3D"MsoNormal">Submitting patch to add UMC 8.7 source file to makef=
ile<o:p></o:p></p>
</div>
</body>
</html>

--_000_BY5PR12MB40198080B5B48F8BA7E97E74FB730BY5PR12MB4019namp_--

--_004_BY5PR12MB40198080B5B48F8BA7E97E74FB730BY5PR12MB4019namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-add-umv-v8.7-source-to-makefile.patch"
Content-Description: 0001-drm-amdgpu-add-umv-v8.7-source-to-makefile.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-add-umv-v8.7-source-to-makefile.patch"; size=798;
	creation-date="Tue, 28 Jul 2020 02:41:00 GMT";
	modification-date="Tue, 28 Jul 2020 02:41:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3ZmE3ZGUwZmRjOWM0M2E5ZWIyMWEyNDQ4NDZjY2QxNmZmOTVlNTA5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjggSnVsIDIwMjAgMTA6NDA6MDAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBhZGQgdW12IHY4Ljcgc291cmNlIHRvIG1ha2VmaWxlCgpTaWduZWQtb2ZmLWJ5
OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSWY3YmY3
NWVlOTI0NDhjNTlmZDgzMWQyZmNmY2RhNWE0OWMyYjk5MTUKLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9NYWtlZmlsZSB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L01ha2VmaWxlIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvTWFrZWZpbGUKaW5kZXggNDAz
ZWMzZGIyOWRmLi4wYmEzOTZlOWQ3ZTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L01ha2VmaWxlCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L01ha2VmaWxl
CkBAIC04NSw3ICs4NSw3IEBAIGFtZGdwdS15ICs9IFwKIAogIyBhZGQgVU1DIGJsb2NrCiBhbWRn
cHUteSArPSBcCi0JdW1jX3Y2XzEubyB1bWNfdjZfMC5vCisJdW1jX3Y2XzEubyB1bWNfdjZfMC5v
IHVtY192OF83Lm8KIAogIyBhZGQgSUggYmxvY2sKIGFtZGdwdS15ICs9IFwKLS0gCjIuMTcuMQoK

--_004_BY5PR12MB40198080B5B48F8BA7E97E74FB730BY5PR12MB4019namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_BY5PR12MB40198080B5B48F8BA7E97E74FB730BY5PR12MB4019namp_--
