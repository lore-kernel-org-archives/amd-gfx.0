Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E859C433F1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 03:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6382076A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 03:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RO0sgFmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6382076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE386EC0C;
	Fri, 17 Jul 2020 03:05:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1846EC0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 03:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A215gvKEUndMHvaLk+UEI54/r5Q8/1t2cy85e6WMNinwoFBy/ZOx6KXFMt7J2cMu4uvMrx7qX1AZe8gyXMp0VYMknk3MdMsH4fpNN+2R07UnqDE75zjmcYzRrp27jvhYkP4pomkGrjmB5J5V4AbzVXcIDLhSP1c5qcizRqsI85TIcv8JRLYqmffkZcFNU+wd/64afxmO1Pf7gNJgf73yb4c6HNqHq0QYr6voJe4R4v3mahJ8nfBvDueo0lpidshLU3avFeT0EZJ1L3fM6FUem8nFDn9FjCrhyb1bjTl82cSEzahVJbvYw7vGmD/8YQS6LGiOQiUnf0NiOupsu53j0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Oj7fC819HIizZFfAduMqlkWcJVO+CGA+2IUVsh/NI=;
 b=KDrBWH+HoflOS4v8N+Kd7Viaw7bvkuOxIqQ825P14EXqZI5C8tM1JwWNMRye5/ESDwKVMwyWlvTfDP882OVcKUFGps99fTTtOeCCo4Q+EDgU9YOIYzSYP9T7hA97JjasPVXzJ2MWwzAEAF/uZn6is7s3OgxGtofKZjKv/lCxz6HOjY8iUvq3IHzayCsOKLfn8jjmfH5TrfbREnw51FWflfgkXGnGXqLlyxCkgBrbjXPBcMLPRVAwgO0fWFXG3P+fURfKCGLvMnGiz61yz7pE6WnvXfsAgX9K0z5eX4Iblf+L3EGk27Gk2S0/Lt9noLnwIW3LHq2UF5MZN3AXBH0PWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Oj7fC819HIizZFfAduMqlkWcJVO+CGA+2IUVsh/NI=;
 b=RO0sgFmSfAfPcSGqWEX+i4OCkbaq9vzgs78oy1i/HE/3sLi+Y7ZNhPg1M6gCaTZ1WpG8937d6kAED/ARFv1g7l6608cu6M1HGM+Neq0RohO+wT9WTYpKmXjtQdBuZ7afVUl9ow4nnmocQ/ndvdvH4P+sa8p7Sfmt+czHNC6zHjY=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 17 Jul
 2020 03:05:03 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 03:05:03 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: enable xgmi support for sienna cichlid
Thread-Topic: [PATCH] drm/amdgpu: enable xgmi support for sienna cichlid
Thread-Index: AdZb5voK0BBGnflxRYC2uCZxkRhgFw==
Date: Fri, 17 Jul 2020 03:05:03 +0000
Message-ID: <MN2PR12MB403253A79DD30D2BCF42B744FB7C0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-17T03:04:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b1369a1f-c963-4ee5-961e-00001fb09a05;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-17T03:04:54Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0afe38cd-703b-4a72-ba81-0000b81be432
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-17T03:05:00Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: facfbe7c-9f33-45c3-88c8-0000c4f2bfcc
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56abf8ad-e77d-44e0-77e7-08d829fe333d
x-ms-traffictypediagnostic: MN2PR12MB4423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4423C894B5DE73CEA4F940AAFB7C0@MN2PR12MB4423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUnL2+QNN954P38FwTmeLOXuLTplDgaUN87V0QLZ0EOxWE4jJrcX7KqnA5D0DGbJYsej3gSgBAlsqD14r2lnxAZfVwMxIX1+fMfKA7vlK/L/jnveC4xnYmhcu67lHumJC1qPHL0KYBnRrvPH+aAGFUPHQLBAlwMlOnGNntoLbnEEvAbLcDUpxH5RaP15K1PTdcdkuAS57er+ELYnN0f6C5LovK7KFhPsVC8f/DKrHbwhEeB0Q7C6Cptojh1Cu8e4IhJ02rXM9xKo21kS7shh8Xjf8yPi4bvShGvW+rli0kVDxbJm/w526ksmg7WOdyZZGOlvLZxyF4V9KKED9yQ/pA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(316002)(55016002)(66946007)(99936003)(558084003)(8936002)(66556008)(76116006)(66616009)(5660300002)(66476007)(86362001)(52536014)(2906002)(110136005)(66446008)(478600001)(64756008)(6636002)(33656002)(7696005)(8676002)(71200400001)(6506007)(26005)(9686003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: /HmW0C3N1B9Fku12FYqeAHhkCzobIOIJOPPDeuvAE7jhjZxysGvC35fB8RFnBk0TM9t2JWH6wsCPMswmMH/XlxwMLYlDKSxic29Eky9IhV+whJINMzljaUDK5yNwllEq6zrXPabRtF3w7GLGRNciVnHal9aj06op7KJqgzWqHeZdlhkF/OCioaeMbNmJmYcFzPv/kdOjNyUn+MZAiK4fVzl/IiMguCrXohP4TMqAbsiok9+iCWjwu81JTXQDNElbGAAMOhLJlwYzLp9KdrbhRagqnhftLkml28M9z9YCHyBo5910EbTdoF7Sy51bbwKNtuYBaJ7wcLwE5zZFlt4sHwM6iHjvzGTehgjqIQPYOGXsoqNvOkIf/0oaLceoJDdqH7oBRoAsJsDdjtxpypW5a07hbORYkqmASeXlBRa8CkB2SE5Bx//0obc09FJ40vvPebJDdAsZHqXkfBr0+9PI7HUQTuT3PVGFkAckZHVi9mdpOeNQjsKbL+v1TdrlCcGz
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB403253A79DD30D2BCF42B744FB7C0MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56abf8ad-e77d-44e0-77e7-08d829fe333d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 03:05:03.0553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6EfVuZSv7Xv0xMoWeuwnH/bFZ3w59OJ1sCprcPIGhfQECpC1yF632opB9sYMqFx9uzW24gBD19h3cCSZvAUhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

--_004_MN2PR12MB403253A79DD30D2BCF42B744FB7C0MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB403253A79DD30D2BCF42B744FB7C0MN2PR12MB4032namp_"

--_000_MN2PR12MB403253A79DD30D2BCF42B744FB7C0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch to enable XGMI support for Sienna Cichlid

--_000_MN2PR12MB403253A79DD30D2BCF42B744FB7C0MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Submitting patch to enable XGMI support for Sienna C=
ichlid<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB403253A79DD30D2BCF42B744FB7C0MN2PR12MB4032namp_--

--_004_MN2PR12MB403253A79DD30D2BCF42B744FB7C0MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0002-drm-amdgpu-enable-xgmi-support-for-sienna-cichlid.patch"
Content-Description:  0002-drm-amdgpu-enable-xgmi-support-for-sienna-cichlid.patch
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-enable-xgmi-support-for-sienna-cichlid.patch";
	size=1011; creation-date="Fri, 17 Jul 2020 03:04:00 GMT";
	modification-date="Fri, 17 Jul 2020 03:04:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0YTMwYzk3NTg1MWFiMjJmMzRiMmMxMzUzOTRmOGYxMjQ3NzUzNWQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgMTcgSnVsIDIwMjAgMTA6NTg6MTQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBlbmFibGUgeGdtaSBzdXBwb3J0IGZvciBzaWVubmEgY2ljaGxpZAoKc2V0IHhn
bWkgc3VwcG9ydCBmbGFnIHN1cmluZyBudiBpcCBpbml0IHNlcXVlbmNlCgpTaWduZWQtb2ZmLWJ5
OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSTQ5MzVh
MDc4MDdlZmU3Njk3OWZmMGM5NGE5N2U1MDY1YTgwMTQ5MmYKLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9udi5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbnYuYwppbmRleCA0Nzk5OTFiNzEyOTUuLmVhNjlhZTc2NzczZSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jCkBAIC00NDYsNiArNDQ2LDkgQEAgaW50IG52X3NldF9p
cF9ibG9ja3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJYWRldi0+bmJpby5mdW5jcyA9
ICZuYmlvX3YyXzNfZnVuY3M7CiAJYWRldi0+bmJpby5oZHBfZmx1c2hfcmVnID0gJm5iaW9fdjJf
M19oZHBfZmx1c2hfcmVnOwogCisJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1NJRU5OQV9D
SUNITElEKQorCQlhZGV2LT5nbWMueGdtaS5zdXBwb3J0ZWQgPSB0cnVlOworCiAJLyogU2V0IElQ
IHJlZ2lzdGVyIGJhc2UgYmVmb3JlIGFueSBIVyByZWdpc3RlciBhY2Nlc3MgKi8KIAlyID0gbnZf
cmVnX2Jhc2VfaW5pdChhZGV2KTsKIAlpZiAocikKLS0gCjIuMTcuMQoK

--_004_MN2PR12MB403253A79DD30D2BCF42B744FB7C0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB403253A79DD30D2BCF42B744FB7C0MN2PR12MB4032namp_--
