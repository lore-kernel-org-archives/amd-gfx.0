Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455BAC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA15A22275
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l2gwC8+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA15A22275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE6F6EBA1;
	Tue,  3 Nov 2020 08:08:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 820626EBA1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 08:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky+/mJ+9K6WAQPen4c07EkP+ES5CaWIdSOmrpGg0JXYzd09X3K67oEVppIwt1k4pRGqRgEkaC5Nb5Kp94juzHAJIaRi9cMuTAXOmHjL/NdV9yo777PUF2ME2LvAF1o+2+tulqXQhoBsMSKJUBDlJR8bzfDBXdmthWEWJsl5iDRxuwKUsrZeFG3sULaAUrfi9YxbqPumIkqos8CCuyqxNH9umBZFF6rbZ/lTLZDCb2DWACy+NHtf8B8QK4KfZ7lx0EO3G+AhUhD5QX+/xng+F1ZoQYTI0Wcq8fs9/UTs5+u7aiynNLXVNMKn/S0FFovb5OKt/9V35iV5RHr1rhdx/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j14K6coERms/+fQqp4PVszYI6V3TmRV6d4yeAtTbuw=;
 b=eLYg6T4FVOUv786II0uFgKPfUkXcYuduNAH8JBEnKkOPrD0fgPhAmuKcYoQHAO+VuwOypeS+34YRAFNw04j/2RZgYEwv3nrcvnEwJIsnTBPX3CxQNWIKIrkbNG6vs69QtlmkCFtKAg//JeK3Myj31idVMsI3QZ5D5nIzJnH5zKWpaQDd7ja83K3Fp5sv0/8ZpWQGmvj2OaSrv01jBl4ofiPH/ZFh9r8tc9E37hHqgXjO/zLT1Z2nd7gbI0vYR/3BcDb5/en3PtlJqmBFVle+2PGs3wR1BAJfd3sSYsoDiG4X7dEJC1LEw8HSjpzxCtb16K4veUzZ+mEadPLmS7vfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j14K6coERms/+fQqp4PVszYI6V3TmRV6d4yeAtTbuw=;
 b=l2gwC8+J+Y0IuBUUT0qZiWZL4WsQMaPfcjATKyRS6RjkZsmyA4LBRVTd1KHOk5RbsfhdEvW1BJsfhXSj6C02bvPJ70+pf79tPGI3+AR/NDtYaX+YgTh60fCOXIOmA62i5R6H4PmBhyf4rfq1Drlk51iGI1VzqXXOhK1qbdWYhiY=
Received: from BY5PR12MB4019.namprd12.prod.outlook.com (2603:10b6:a03:1a8::23)
 by BY5PR12MB3921.namprd12.prod.outlook.com (2603:10b6:a03:1a2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Tue, 3 Nov
 2020 08:08:36 +0000
Received: from BY5PR12MB4019.namprd12.prod.outlook.com
 ([fe80::9099:1880:e3f0:c53d]) by BY5PR12MB4019.namprd12.prod.outlook.com
 ([fe80::9099:1880:e3f0:c53d%3]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 08:08:36 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resolved ASD loading issue on sienna
Thread-Topic: [PATCH] drm/amdgpu: resolved ASD loading issue on sienna
Thread-Index: AdaxuFqoLbD+1kPMTHiv7p+c33suFg==
Date: Tue, 3 Nov 2020 08:08:36 +0000
Message-ID: <BY5PR12MB4019A6EA70A151DE464B45B0FB110@BY5PR12MB4019.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-03T08:08:31Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e977ac78-95e9-434f-a8bc-0000b4035723;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-03T08:08:24Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 66a829e7-e04c-43a4-b85c-000051fe85f8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-03T08:08:33Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 22c1a63b-c6e7-4cd5-a6f8-000054d78449
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8370ab97-e8fc-48f4-ba62-08d87fcfaa64
x-ms-traffictypediagnostic: BY5PR12MB3921:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB39214248AA3B68915701B807FB110@BY5PR12MB3921.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYFq8mGf1B/JGvHzU96Wgj3PtSGrKsgOO1/KkBtm5p8j14Zt3IIu762gsmS22LXpLw2+QNzGbyQMZ1712gXCyyPA4eQ2dsutXjcNgXP78Q9luHqyR0gYzXIR6k4OM09jMB6DEcds9y2N41T30+FEMw+xLUS06pEmPNNnopB83XZKmmUcvYst63y5f0GjV70dFuP/EZlGxhBIuajwzq67qpXncYj0VIm9cStBsB16Y3k6Wky+du9vNkPNTgZK39nCYFCoq7JNovnHrHj+sqTId5a2vT0gJ9Y4C7gpLZAbAqOPWjUb668qpwLmm24XzwrCugxX9jzUjGXJTO9ROAQtlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4019.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(52536014)(186003)(26005)(8676002)(478600001)(5660300002)(558084003)(8936002)(99936003)(64756008)(2906002)(6636002)(55016002)(6506007)(66446008)(71200400001)(76116006)(9686003)(66616009)(110136005)(66556008)(7696005)(66476007)(33656002)(66946007)(316002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wYtF0ejXHKLxJS1O9xy1qQlUsj8TQRwkU0ZfzYEXUWnbBK843PxIKtkalvipNZ787/ThH0YTi1flyZv6Wu0NskcTmhdJrnWNCyzrk3iCPIZ072YGRXeYLetQ8WXLE1N6I6UkxrqVJ/Ea/jAseYrBM7tRMsK87AG+CkGP6Tz0Iz+5MPzwNqef8PktU/aAtArgtuB8nOEse7hSUfGp92VfFNc9Htuhms5E81VcZHUvbV+Xholts8czwIWOU3yOAhxda1E53SegikwvWz518RIHdwPutFPA4qDkAUK4nrOOfyfCFTtFaUJnfXtCTcCVSTlZ7rFimEBQLV8oAlLisZ+PClWLruUt+Wo3+Dkt4NI2MiqJ5wUbIhfpAWc2BHtoZbr7baaem5AlAzS7Sg28MyexOGBP5yUucMYXFG/EKRgVSwYGQUyNAD7bxKf1d4C9ijrzEzgwhUcbyVF+rdcyjEuiB9aAlUixHoVrz5bSFYzaUjh4AK6fDqM33Ym+E5X0fe0WjyBZDH4E6AnAngWzJeUMnI0GMqK3S1u7y5uf2/RkhGv1zsW8mZpOu3gdWhZ9sY7jnFKFlEa3sxeuf8aDvx4IjwK1VqLmr/aJuSDhmFWG5JHpI46vry+g1iYgZs2Qn4LHc/JtyLefKL/5zve7ClIx1w==
Content-Type: multipart/mixed;
 boundary="_004_BY5PR12MB4019A6EA70A151DE464B45B0FB110BY5PR12MB4019namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4019.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8370ab97-e8fc-48f4-ba62-08d87fcfaa64
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 08:08:36.4732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ex92V7bORO88p/GvscmsW7ym1uSoylFwT6vaDCXikb59NpEZ53Z80d2OB0I/qT3+swUKF3iAZU3KBFDwM0EiiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3921
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

--_004_BY5PR12MB4019A6EA70A151DE464B45B0FB110BY5PR12MB4019namp_
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB4019A6EA70A151DE464B45B0FB110BY5PR12MB4019namp_"

--_000_BY5PR12MB4019A6EA70A151DE464B45B0FB110BY5PR12MB4019namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch to resolve ASD fw loading issue on ASIC with ta header v2

Thank you,
John Clements

--_000_BY5PR12MB4019A6EA70A151DE464B45B0FB110BY5PR12MB4019namp_
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
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to resolve ASD fw loading issue on =
ASIC with ta header v2<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BY5PR12MB4019A6EA70A151DE464B45B0FB110BY5PR12MB4019namp_--

--_004_BY5PR12MB4019A6EA70A151DE464B45B0FB110BY5PR12MB4019namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolved-ASD-loading-issue-on-sienna.patch"
Content-Description:  0001-drm-amdgpu-resolved-ASD-loading-issue-on-sienna.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolved-ASD-loading-issue-on-sienna.patch";
	size=1087; creation-date="Tue, 03 Nov 2020 08:07:00 GMT";
	modification-date="Tue, 03 Nov 2020 08:07:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjZWNmOThmODYwMzQxYWY3YWYzNmZiNjI2NzVmMmJhNThmZjRmNmIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMyBOb3YgMjAyMCAxNTo0NDoxOCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHJlc29sdmVkIEFTRCBsb2FkaW5nIGlzc3VlIG9uIHNpZW5uYQoKdXBkYXRlZCBm
dyBoZWFkZXIgdjIgcGFyc2VyIHRvIHNldCBhc2QgZncgbWVtb3J5CgpTaWduZWQtb2ZmLWJ5OiBK
b2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSWI4NmQxYmQ2
MTE1MmJjMGU0NWZhMDZmZjFlMjRmNDRkYjhiNjYwZTEKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCBjMzQ1N2Q2NzVl
ZGIuLjJiMGEyYjkzOTk0YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
YwpAQCAtMjU5Miw2ICsyNTkyLDcgQEAgaW50IHBhcnNlX3RhX2Jpbl9kZXNjcmlwdG9yKHN0cnVj
dCBwc3BfY29udGV4dCAqcHNwLAogCQlwc3AtPmFzZF9mZWF0dXJlX3ZlcnNpb24gICA9IGxlMzJf
dG9fY3B1KGRlc2MtPmZ3X3ZlcnNpb24pOwogCQlwc3AtPmFzZF91Y29kZV9zaXplCSAgID0gbGUz
Ml90b19jcHUoZGVzYy0+c2l6ZV9ieXRlcyk7CiAJCXBzcC0+YXNkX3N0YXJ0X2FkZHIgCSAgID0g
dWNvZGVfc3RhcnRfYWRkcjsKKwkJcHNwLT5hc2RfZncgICAgICAgICAgICAgICAgPSBwc3AtPnRh
X2Z3OwogCQlicmVhazsKIAljYXNlIFRBX0ZXX1RZUEVfUFNQX1hHTUk6CiAJCXBzcC0+dGFfeGdt
aV91Y29kZV92ZXJzaW9uID0gbGUzMl90b19jcHUoZGVzYy0+ZndfdmVyc2lvbik7Ci0tIAoyLjE3
LjEKCg==

--_004_BY5PR12MB4019A6EA70A151DE464B45B0FB110BY5PR12MB4019namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_BY5PR12MB4019A6EA70A151DE464B45B0FB110BY5PR12MB4019namp_--
