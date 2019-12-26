Return-Path: <SRS0=shUv=2Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405CDC2D0C8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 02:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B2F2075B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 02:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ripp+brL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B2F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4CB089364;
	Thu, 26 Dec 2019 02:45:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C5689364
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2019 02:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4HfZnQEB3FbMAG4XQEAXIruGCu6Bki2kSgOvzOzidMXv6i9+QrbLzO2UBp5e9OVAlarElAKJ+3ymGAwETNs0CFuNqz4K1c3PTt3Ex8tM5RqMPuAMZH7Js2ejUj+lNTj3m+tacuLzd81C7WVo7pP4RzYnzrYRxHYFtjOUs/0TaxP/GONx25mL+n9P7SSEfR21xI29XDu1e2XpDRewtCFp6bOtVOBn5lIRsMPWpWFJYNiRvB6XHxVlskLb6+/2JYg6jVYgO77VNGe/8mW3C5TpQCwyOTkJgT3G5pkDO5stBVREOpWW02FGA7jGkxDCWtDAyTyHkqd32kLp86Em1Nl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMvgqwd6A4T3FnnXuBIb1CSUrvSmN5QVOqaNNRAI1ac=;
 b=T5QK02XL16njTSijcAuR4uSHlC27fOzZlG3uHOTD1aIGOn2K6DR+pEUJlw7N6h9eLFJCT+CJin/16sVS0daWFnyH6Isqk1BE11qf05rByT0zlKlsZZYkSdjL92dnT8n7zED5zQ08T45UaCIBRIILUqVv9gXuK+L3DrU0dux3HAkfnS1OJ2wWXbPYYMYeRyr3sBuIL1lW3sfdIBHNgPHyukXTcYmsGreyZh2ihk1YAfkFvVEaDUJsO05ulfkFzOKJyj4jO/tzNm3jtRQYVS3LZ6G7Dg+Wf4HuEn3UHTzL4CvjZzrQ/2Y7PY/9GmiwM6K3cBBUL+mOz07xdSzt5+PRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMvgqwd6A4T3FnnXuBIb1CSUrvSmN5QVOqaNNRAI1ac=;
 b=ripp+brL/3FqomqgYiRfL/SnHaRCUreFM7MfPy0f5wxOBtRwMT3n1r9MExVG+Xcmc/58tlj+KX9dO+FnQk5M6QuKUSCgugmdP0xPSlRK/OK9YhNg8JRZWP8AYvVr7gA+Mpn2W36eyPnC9rMGgUnV0dMkeYZzcsuD4bB36e+hCWA=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB4015.namprd12.prod.outlook.com (10.255.239.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 26 Dec 2019 02:45:23 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::e469:c9bb:44be:c069]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::e469:c9bb:44be:c069%6]) with mapi id 15.20.2559.017; Thu, 26 Dec 2019
 02:45:23 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] Series to re-organize and amalgamate certain PSP TA
 functions
Thread-Topic: [PATCH] Series to re-organize and amalgamate certain PSP TA
 functions
Thread-Index: AdW6bmN9VmhE/V8bQ1OUR8tP1RbeiAAUd3QAADVj0RA=
Date: Thu, 26 Dec 2019 02:45:21 +0000
Message-ID: <MN2PR12MB3663872631805EAF879D6E49FB2B0@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <MN2PR12MB36636CE4E6D055305F35D260FB290@MN2PR12MB3663.namprd12.prod.outlook.com>
 <BYAPR12MB28065FBDE10DD8B62B196523F1280@BYAPR12MB2806.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB28065FBDE10DD8B62B196523F1280@BYAPR12MB2806.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-24T15:32:28Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=36a485ac-1ed1-420e-849a-0000635bc4d3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-26T02:45:13Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 69d0ca5f-eb7d-486a-adb3-0000b2162bdf
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.235.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82e2f15e-61d7-4ca1-567f-08d789ada7b1
x-ms-traffictypediagnostic: MN2PR12MB4015:|MN2PR12MB4015:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4015F9ED0F215F8F6217320FFB2B0@MN2PR12MB4015.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(189003)(199004)(6636002)(86362001)(7696005)(2906002)(478600001)(81156014)(110136005)(5660300002)(316002)(81166006)(53546011)(6506007)(8676002)(8936002)(71200400001)(26005)(66446008)(186003)(66476007)(66556008)(66576008)(66946007)(64756008)(76116006)(55016002)(33656002)(52536014)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4015;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7l+33eL792UY3PY5j7GhgtkNfWuxXmQV4ozseDITOPIuv7Ja1CvZVl7W+I6qae3AaHS47YQYXzdC7Eb31yEuLlNhynR/FzVEIyLBkTZkq37ECYG45qbF5MCLMr6n1A0ax1u2g13ziJlOCmTkTThEhg0v8YDEw4wXwubGurBXYNpw6ydQTB7P5HakOge/EnLAVvFmx8sMDFLtStaGUR5nv2+KCxn5w2VrGwx0YcDuOcBgvNTtsLBn0Mt48aYczEgrT8wcfO3aWQjcZ9CHHB3vUdeqfNlScSCLSM1zm++L7AYOaWBkQnYnsXKFUzaeDbeN1lkrhdT5AUUpZbLhM7okfSxvX9JPJswfXL6/9QQEQi4exovYqB8tgtqmRFjKoccTD4ceKSUHfch3cHQoEexZ7snnsN6PSD9niz/bjw8cUOFZQxeUVd3G9IEpTp2bwNOL
Content-Type: multipart/mixed;
 boundary="_006_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e2f15e-61d7-4ca1-567f-08d789ada7b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 02:45:22.0705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzC7qoFafY/m811BagvT8ZvnWaSLAGCOvo7OOe0KH6HvLNL7X+jIrMbDj5IdFgre/ApSsMh+R7a3ppwqLbS28Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4015
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

--_006_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_"

--_000_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hello Guchun,

Thank you for your feedback, I have updated the indentations to make them c=
onsistent.

I am not so sure if the psp_ta_invoke function should be a static function.=
 As the Linux TA count grows, we may want to split up amdgpu_psp.c  to leve=
rage the psp_ta_invoke function from other TA dedicated source file.

Thank you,
John Clements

From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Wednesday, December 25, 2019 9:17 AM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] Series to re-organize and amalgamate certain PSP TA fu=
nctions


[AMD Official Use Only - Internal Distribution Only]

In patch 3,
1. psp_ta_invoke should be one static function?
2. The indentation in each "return" line looks not correct.

With above fixed, series is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com<mailto:guchun.chen@amd.com>>.

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Clements, John
Sent: Tuesday, December 24, 2019 11:33 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH] Series to re-organize and amalgamate certain PSP TA functi=
ons


[AMD Official Use Only - Internal Distribution Only]

Patch 1:

  *   Update PSP command submission to output failure to dmesg by default
  *   Removed masking of response status (as requested by PSP team)

Patch 2:

  *   Unify TA function to prepare load/unload commands

Patch 3:

  *   Unify TA function to invoke commands

Thank you,
John Clements

--_000_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:27219757;
	mso-list-template-ids:1264353216;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1
	{mso-list-id:116608108;
	mso-list-template-ids:623823652;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2
	{mso-list-id:556208321;
	mso-list-type:hybrid;
	mso-list-template-ids:-1460926714 -1919000054 67698691 67698693 67698689 6=
7698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:DengXian;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3
	{mso-list-id:1045255539;
	mso-list-type:hybrid;
	mso-list-template-ids:-732297138 -1919000054 67698691 67698693 67698689 67=
698691 67698693 67698689 67698691 67698693;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:DengXian;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l4
	{mso-list-id:2141803782;
	mso-list-template-ids:601394840;}
@list l4:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello Guchun,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for your feedback, I have updated the inde=
ntations to make them consistent.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am not so sure if the psp_ta_invoke function shoul=
d be a static function. As the Linux TA count grows, we may want to split u=
p amdgpu_psp.c &nbsp;to leverage the psp_ta_invoke function from other TA d=
edicated source file.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt=
; <br>
<b>Sent:</b> Wednesday, December 25, 2019 9:17 AM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] Series to re-organize and amalgamate certain PS=
P TA functions<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In patch 3, <o:p></o:p></p>
<p class=3D"MsoNormal">1. psp_ta_invoke should be one static function?<o:p>=
</o:p></p>
<p class=3D"MsoNormal">2. The indentation in each &#8220;return&#8221; line=
 looks not correct.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">With above fixed, series is:<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen &lt;<a href=3D"mailto:guchu=
n.chen@amd.com">guchun.chen@amd.com</a>&gt;.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Tuesday, December 24, 2019 11:33 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] Series to re-organize and amalgamate certain PSP TA=
 functions<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Patch 1:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l2 level1 =
lfo3">Update PSP command submission to output failure to dmesg by default<o=
:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-l=
ist:l2 level1 lfo3">Removed masking of response status (as requested by PSP=
 team)<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Patch 2:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l3 level1 =
lfo6">Unify TA function to prepare load/unload commands<o:p></o:p></li></ul=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Patch 3:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l3 level1 =
lfo6">Unify TA function to invoke commands<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_--

--_006_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0003-drm-amdgpu-amalgamated-PSP-TA-invoke-functions.patch"
Content-Description: 0003-drm-amdgpu-amalgamated-PSP-TA-invoke-functions.patch
Content-Disposition: attachment;
	filename="0003-drm-amdgpu-amalgamated-PSP-TA-invoke-functions.patch";
	size=5815; creation-date="Thu, 26 Dec 2019 02:42:00 GMT";
	modification-date="Thu, 26 Dec 2019 02:42:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxYzQwM2FjNWU2YzdlNTBlMDRjZDgxODA2ZGQ0MjVkNmFmNjhkY2MzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjQgRGVjIDIwMTkgMjM6MTQ6MzggKzA4MDAKU3ViamVjdDogW1BBVENIIDMv
M10gZHJtL2FtZGdwdTogYW1hbGdhbWF0ZSBQU1AgVEEgaW52b2tlIGZ1bmN0aW9ucwoKcmVkdWNl
IGR1cGxpY2F0ZSBjb2RlCgpDaGFuZ2UtSWQ6IEliOWUxNWM1Zjc0YWQ1NTBmNTdlYjkwMTA4MjU0
NjBjNDk3MjdiMTM2ClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAx
MzcgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9u
cygrKSwgMTAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYwppbmRleCAzZjA1NWE3M2RmZjkuLmZlNTZlYjM4ODBiZSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwpAQCAtNDQzLDYgKzQ0MywzNiBAQCBzdGF0aWMgdm9pZCBw
c3BfcHJlcF90YV9sb2FkX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwKICAg
ICAgICAgY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9sZW4gCSA9IHRhX3NoYXJlZF9zaXpl
OwogfQogCitzdGF0aWMgdm9pZCBwc3BfcHJlcF90YV9pbnZva2VfY21kX2J1ZihzdHJ1Y3QgcHNw
X2dmeF9jbWRfcmVzcCAqY21kLAorCQkJCSAgICAgICB1aW50MzJfdCB0YV9jbWRfaWQsCisJCQkJ
ICAgICAgIHVpbnQzMl90IHNlc3Npb25faWQpCit7CisJY21kLT5jbWRfaWQgCQkJCT0gR0ZYX0NN
RF9JRF9JTlZPS0VfQ01EOworCWNtZC0+Y21kLmNtZF9pbnZva2VfY21kLnNlc3Npb25faWQgCT0g
c2Vzc2lvbl9pZDsKKwljbWQtPmNtZC5jbWRfaW52b2tlX2NtZC50YV9jbWRfaWQgCT0gdGFfY21k
X2lkOworfQorCitpbnQgcHNwX3RhX2ludm9rZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKKwkJ
ICB1aW50MzJfdCB0YV9jbWRfaWQsCisJCSAgdWludDMyX3Qgc2Vzc2lvbl9pZCkKK3sKKwlpbnQg
cmV0OworCXN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQ7CisKKwljbWQgPSBremFsbG9jKHNp
emVvZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCksIEdGUF9LRVJORUwpOworCWlmICghY21kKQor
CQlyZXR1cm4gLUVOT01FTTsKKworCXBzcF9wcmVwX3RhX2ludm9rZV9jbWRfYnVmKGNtZCwgdGFf
Y21kX2lkLCBzZXNzaW9uX2lkKTsKKworCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihwc3AsIE5V
TEwsIGNtZCwKKwkJCQkgcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CisKKwlrZnJlZShjbWQpOwor
CisJcmV0dXJuIHJldDsKK30KKwogc3RhdGljIGludCBwc3BfeGdtaV9pbml0X3NoYXJlZF9idWYo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7CiAJaW50IHJldDsKQEAgLTUxOCwzNSArNTQ4LDkg
QEAgc3RhdGljIGludCBwc3BfeGdtaV91bmxvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJ
cmV0dXJuIHJldDsKIH0KIAotc3RhdGljIHZvaWQgcHNwX3ByZXBfeGdtaV90YV9pbnZva2VfY21k
X2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAotCQkJCQkgICAgdWludDMyX3QgdGFf
Y21kX2lkLAotCQkJCQkgICAgdWludDMyX3QgeGdtaV9zZXNzaW9uX2lkKQotewotCWNtZC0+Y21k
X2lkID0gR0ZYX0NNRF9JRF9JTlZPS0VfQ01EOwotCWNtZC0+Y21kLmNtZF9pbnZva2VfY21kLnNl
c3Npb25faWQgPSB4Z21pX3Nlc3Npb25faWQ7Ci0JY21kLT5jbWQuY21kX2ludm9rZV9jbWQudGFf
Y21kX2lkID0gdGFfY21kX2lkOwotCS8qIE5vdGU6IGNtZF9pbnZva2VfY21kLmJ1ZiBpcyBub3Qg
dXNlZCBmb3Igbm93ICovCi19Ci0KIGludCBwc3BfeGdtaV9pbnZva2Uoc3RydWN0IHBzcF9jb250
ZXh0ICpwc3AsIHVpbnQzMl90IHRhX2NtZF9pZCkKIHsKLQlpbnQgcmV0OwotCXN0cnVjdCBwc3Bf
Z2Z4X2NtZF9yZXNwICpjbWQ7Ci0KLQotCWNtZCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBwc3Bf
Z2Z4X2NtZF9yZXNwKSwgR0ZQX0tFUk5FTCk7Ci0JaWYgKCFjbWQpCi0JCXJldHVybiAtRU5PTUVN
OwotCi0JcHNwX3ByZXBfeGdtaV90YV9pbnZva2VfY21kX2J1ZihjbWQsIHRhX2NtZF9pZCwKLQkJ
CQkJcHNwLT54Z21pX2NvbnRleHQuc2Vzc2lvbl9pZCk7Ci0KLQlyZXQgPSBwc3BfY21kX3N1Ym1p
dF9idWYocHNwLCBOVUxMLCBjbWQsCi0JCQkJIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwotCi0J
a2ZyZWUoY21kKTsKLQotICAgICAgICByZXR1cm4gcmV0OworCXJldHVybiBwc3BfdGFfaW52b2tl
KHBzcCwgdGFfY21kX2lkLCBwc3AtPnhnbWlfY29udGV4dC5zZXNzaW9uX2lkKTsKIH0KIAogc3Rh
dGljIGludCBwc3BfeGdtaV90ZXJtaW5hdGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCkBAIC02
ODEsNDAgKzY4NSwxNSBAQCBzdGF0aWMgaW50IHBzcF9yYXNfdW5sb2FkKHN0cnVjdCBwc3BfY29u
dGV4dCAqcHNwKQogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyB2b2lkIHBzcF9wcmVwX3Jhc190
YV9pbnZva2VfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAotCQl1aW50MzJf
dCB0YV9jbWRfaWQsCi0JCXVpbnQzMl90IHJhc19zZXNzaW9uX2lkKQotewotCWNtZC0+Y21kX2lk
ID0gR0ZYX0NNRF9JRF9JTlZPS0VfQ01EOwotCWNtZC0+Y21kLmNtZF9pbnZva2VfY21kLnNlc3Np
b25faWQgPSByYXNfc2Vzc2lvbl9pZDsKLQljbWQtPmNtZC5jbWRfaW52b2tlX2NtZC50YV9jbWRf
aWQgPSB0YV9jbWRfaWQ7Ci0JLyogTm90ZTogY21kX2ludm9rZV9jbWQuYnVmIGlzIG5vdCB1c2Vk
IGZvciBub3cgKi8KLX0KLQogaW50IHBzcF9yYXNfaW52b2tlKHN0cnVjdCBwc3BfY29udGV4dCAq
cHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpCiB7Ci0JaW50IHJldDsKLQlzdHJ1Y3QgcHNwX2dmeF9j
bWRfcmVzcCAqY21kOwotCiAJLyoKIAkgKiBUT0RPOiBieXBhc3MgdGhlIGxvYWRpbmcgaW4gc3Jp
b3YgZm9yIG5vdwogCSAqLwogCWlmIChhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkKIAkJcmV0
dXJuIDA7CiAKLQljbWQgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCks
IEdGUF9LRVJORUwpOwotCWlmICghY21kKQotCQlyZXR1cm4gLUVOT01FTTsKLQotCXBzcF9wcmVw
X3Jhc190YV9pbnZva2VfY21kX2J1ZihjbWQsIHRhX2NtZF9pZCwKLQkJCXBzcC0+cmFzLnNlc3Np
b25faWQpOwotCi0JcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLAotCQkJ
cHNwLT5mZW5jZV9idWZfbWNfYWRkcik7Ci0KLQlrZnJlZShjbWQpOwotCi0JcmV0dXJuIHJldDsK
KwlyZXR1cm4gcHNwX3RhX2ludm9rZShwc3AsIHRhX2NtZF9pZCwgcHNwLT5yYXMuc2Vzc2lvbl9p
ZCk7CiB9CiAKIGludCBwc3BfcmFzX2VuYWJsZV9mZWF0dXJlcyhzdHJ1Y3QgcHNwX2NvbnRleHQg
KnBzcCwKQEAgLTkwNywzOSArODg2LDE1IEBAIHN0YXRpYyBpbnQgcHNwX2hkY3BfdW5sb2FkKHN0
cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyB2b2lkIHBz
cF9wcmVwX2hkY3BfdGFfaW52b2tlX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNt
ZCwKLQkJCQkJICAgIHVpbnQzMl90IHRhX2NtZF9pZCwKLQkJCQkJICAgIHVpbnQzMl90IGhkY3Bf
c2Vzc2lvbl9pZCkKLXsKLQljbWQtPmNtZF9pZCA9IEdGWF9DTURfSURfSU5WT0tFX0NNRDsKLQlj
bWQtPmNtZC5jbWRfaW52b2tlX2NtZC5zZXNzaW9uX2lkID0gaGRjcF9zZXNzaW9uX2lkOwotCWNt
ZC0+Y21kLmNtZF9pbnZva2VfY21kLnRhX2NtZF9pZCA9IHRhX2NtZF9pZDsKLQkvKiBOb3RlOiBj
bWRfaW52b2tlX2NtZC5idWYgaXMgbm90IHVzZWQgZm9yIG5vdyAqLwotfQotCiBpbnQgcHNwX2hk
Y3BfaW52b2tlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpCiB7
Ci0JaW50IHJldDsKLQlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kOwotCiAJLyoKIAkgKiBU
T0RPOiBieXBhc3MgdGhlIGxvYWRpbmcgaW4gc3Jpb3YgZm9yIG5vdwogCSAqLwogCWlmIChhbWRn
cHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkKIAkJcmV0dXJuIDA7CiAKLQljbWQgPSBremFsbG9jKHNp
emVvZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCksIEdGUF9LRVJORUwpOwotCWlmICghY21kKQot
CQlyZXR1cm4gLUVOT01FTTsKLQotCXBzcF9wcmVwX2hkY3BfdGFfaW52b2tlX2NtZF9idWYoY21k
LCB0YV9jbWRfaWQsCi0JCQkJCXBzcC0+aGRjcF9jb250ZXh0LnNlc3Npb25faWQpOwotCi0JcmV0
ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLCBwc3AtPmZlbmNlX2J1Zl9tY19h
ZGRyKTsKLQotCWtmcmVlKGNtZCk7Ci0KLQlyZXR1cm4gcmV0OworCXJldHVybiBwc3BfdGFfaW52
b2tlKHBzcCwgdGFfY21kX2lkLCBwc3AtPmhkY3BfY29udGV4dC5zZXNzaW9uX2lkKTsKIH0KIAog
c3RhdGljIGludCBwc3BfaGRjcF90ZXJtaW5hdGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCkBA
IC0xMDUzLDM5ICsxMDA4LDE1IEBAIHN0YXRpYyBpbnQgcHNwX2R0bV9pbml0aWFsaXplKHN0cnVj
dCBwc3BfY29udGV4dCAqcHNwKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgdm9pZCBwc3BfcHJl
cF9kdG1fdGFfaW52b2tlX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwKLQkJ
CQkJICAgdWludDMyX3QgdGFfY21kX2lkLAotCQkJCQkgICB1aW50MzJfdCBkdG1fc2Vzc2lvbl9p
ZCkKLXsKLQljbWQtPmNtZF9pZCA9IEdGWF9DTURfSURfSU5WT0tFX0NNRDsKLQljbWQtPmNtZC5j
bWRfaW52b2tlX2NtZC5zZXNzaW9uX2lkID0gZHRtX3Nlc3Npb25faWQ7Ci0JY21kLT5jbWQuY21k
X2ludm9rZV9jbWQudGFfY21kX2lkID0gdGFfY21kX2lkOwotCS8qIE5vdGU6IGNtZF9pbnZva2Vf
Y21kLmJ1ZiBpcyBub3QgdXNlZCBmb3Igbm93ICovCi19Ci0KIGludCBwc3BfZHRtX2ludm9rZShz
dHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwgdWludDMyX3QgdGFfY21kX2lkKQogewotCWludCByZXQ7
Ci0Jc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZDsKLQogCS8qCiAJICogVE9ETzogYnlwYXNz
IHRoZSBsb2FkaW5nIGluIHNyaW92IGZvciBub3cKIAkgKi8KIAlpZiAoYW1kZ3B1X3NyaW92X3Zm
KHBzcC0+YWRldikpCiAJCXJldHVybiAwOwogCi0JY21kID0ga3phbGxvYyhzaXplb2Yoc3RydWN0
IHBzcF9nZnhfY21kX3Jlc3ApLCBHRlBfS0VSTkVMKTsKLQlpZiAoIWNtZCkKLQkJcmV0dXJuIC1F
Tk9NRU07Ci0KLQlwc3BfcHJlcF9kdG1fdGFfaW52b2tlX2NtZF9idWYoY21kLCB0YV9jbWRfaWQs
Ci0JCQkJICAgICAgIHBzcC0+ZHRtX2NvbnRleHQuc2Vzc2lvbl9pZCk7Ci0KLQlyZXQgPSBwc3Bf
Y21kX3N1Ym1pdF9idWYocHNwLCBOVUxMLCBjbWQsIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwot
Ci0Ja2ZyZWUoY21kKTsKLQotCXJldHVybiByZXQ7CisJcmV0dXJuIHBzcF90YV9pbnZva2UocHNw
LCB0YV9jbWRfaWQsIHBzcC0+ZHRtX2NvbnRleHQuc2Vzc2lvbl9pZCk7CiB9CiAKIHN0YXRpYyBp
bnQgcHNwX2R0bV90ZXJtaW5hdGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCi0tIAoyLjE3LjEK
Cg==

--_006_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-by-default-output-PSP-ret-status-in-event-.patch"
Content-Description:  0001-drm-amdgpu-by-default-output-PSP-ret-status-in-event-.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-by-default-output-PSP-ret-status-in-event-.patch";
	size=1243; creation-date="Thu, 26 Dec 2019 02:42:00 GMT";
	modification-date="Thu, 26 Dec 2019 02:42:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyMGU0YjgwNDU5MThlMDUzYzRlMThmOGRlYTRlMzI3NTJhMmI4NTgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjQgRGVjIDIwMTkgMjE6MTk6NDQgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
M10gZHJtL2FtZGdwdTogYnkgZGVmYXVsdCBvdXRwdXQgUFNQIHJldCBzdGF0dXMgaW4gZXZlbnQg
b2YKIHN1Ym1pc3Npb24gZmFpbHVyZQoKdXBkYXRlIGZyb20gRFJNX0RFQlVHX0RSSVZFUiB0byBE
Uk1fV0FSTgoKQ2hhbmdlLUlkOiBJOWQ1YzIyMzUxNDg2NzU3YTM4ZDZiNjJlZjY5NmQ0NTAwNzc2
YzBhOApTaWduZWQtb2ZmLWJ5OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgNCArKy0tCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCAxYjg5YmMzZTJlOGYuLmE5ZjNiYzc4
Njg0OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwpAQCAtMTkxLDkg
KzE5MSw5IEBAIHBzcF9jbWRfc3VibWl0X2J1ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKIAkJ
aWYgKHVjb2RlKQogCQkJRFJNX1dBUk4oImZhaWxlZCB0byBsb2FkIHVjb2RlIGlkICglZCkgIiwK
IAkJCQkgIHVjb2RlLT51Y29kZV9pZCk7Ci0JCURSTV9ERUJVR19EUklWRVIoInBzcCBjb21tYW5k
ICgweCVYKSBmYWlsZWQgYW5kIHJlc3BvbnNlIHN0YXR1cyBpcyAoMHglWClcbiIsCisJCURSTV9X
QVJOKCJwc3AgY29tbWFuZCAoMHglWCkgZmFpbGVkIGFuZCByZXNwb25zZSBzdGF0dXMgaXMgKDB4
JVgpXG4iLAogCQkJIHBzcC0+Y21kX2J1Zl9tZW0tPmNtZF9pZCwKLQkJCSBwc3AtPmNtZF9idWZf
bWVtLT5yZXNwLnN0YXR1cyAmIEdGWF9DTURfU1RBVFVTX01BU0spOworCQkJIHBzcC0+Y21kX2J1
Zl9tZW0tPnJlc3Auc3RhdHVzKTsKIAkJaWYgKCF0aW1lb3V0KSB7CiAJCQltdXRleF91bmxvY2so
JnBzcC0+bXV0ZXgpOwogCQkJcmV0dXJuIC1FSU5WQUw7Ci0tIAoyLjE3LjEKCg==

--_006_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0002-drm-amdgpu-amalgamate-PSP-TA-load-unload-functions.patch"
Content-Description:  0002-drm-amdgpu-amalgamate-PSP-TA-load-unload-functions.patch
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-amalgamate-PSP-TA-load-unload-functions.patch";
	size=9774; creation-date="Thu, 26 Dec 2019 02:42:00 GMT";
	modification-date="Thu, 26 Dec 2019 02:42:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMTY2MmM1OGUxYTJjMWFkMTdiMDcxZjhhNDA1NTk5YmUwNzMyOGQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjQgRGVjIDIwMTkgMjI6NDU6NTEgKzA4MDAKU3ViamVjdDogW1BBVENIIDIv
M10gZHJtL2FtZGdwdTogYW1hbGdhbWF0ZSBQU1AgVEEgbG9hZC91bmxvYWQgZnVuY3Rpb25zCgpy
ZWR1Y2UgZHVwbGljYXRlIGNvZGUKCkNoYW5nZS1JZDogSTEwMGZjMzQ4MDUyOGRmODNhOGRmYmJi
OWFmNDY0NWNiMjc3ZDcyMTEKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVt
ZW50c0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
YyB8IDEzOCArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNl
cnRpb25zKCspLCA5OSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMKaW5kZXggYTlmM2JjNzg2ODQ5Li4zZjA1NWE3M2RmZjkgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTM2NSwxMSArMzY1LDExIEBAIHN0YXRpYyBp
bnQgcHNwX2FzZF9sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXJldHVybiByZXQ7CiB9
CiAKLXN0YXRpYyB2b2lkIHBzcF9wcmVwX2FzZF91bmxvYWRfY21kX2J1ZihzdHJ1Y3QgcHNwX2dm
eF9jbWRfcmVzcCAqY21kLAotCQkJCQl1aW50MzJfdCBhc2Rfc2Vzc2lvbl9pZCkKK3N0YXRpYyB2
b2lkIHBzcF9wcmVwX3RhX3VubG9hZF9jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpj
bWQsCisJCQkJICAgICAgIHVpbnQzMl90IHNlc3Npb25faWQpCiB7CiAJY21kLT5jbWRfaWQgPSBH
RlhfQ01EX0lEX1VOTE9BRF9UQTsKLQljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Npb25faWQg
PSBhc2Rfc2Vzc2lvbl9pZDsKKwljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Npb25faWQgPSBz
ZXNzaW9uX2lkOwogfQogCiBzdGF0aWMgaW50IHBzcF9hc2RfdW5sb2FkKHN0cnVjdCBwc3BfY29u
dGV4dCAqcHNwKQpAQCAtMzg3LDcgKzM4Nyw3IEBAIHN0YXRpYyBpbnQgcHNwX2FzZF91bmxvYWQo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJaWYgKCFjbWQpCiAJCXJldHVybiAtRU5PTUVNOwog
Ci0JcHNwX3ByZXBfYXNkX3VubG9hZF9jbWRfYnVmKGNtZCwgcHNwLT5hc2RfY29udGV4dC5zZXNz
aW9uX2lkKTsKKwlwc3BfcHJlcF90YV91bmxvYWRfY21kX2J1ZihjbWQsIHBzcC0+YXNkX2NvbnRl
eHQuc2Vzc2lvbl9pZCk7CiAKIAlyZXQgPSBwc3BfY21kX3N1Ym1pdF9idWYocHNwLCBOVUxMLCBj
bWQsCiAJCQkJIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwpAQCAtNDI3LDE4ICs0MjcsMjAgQEAg
aW50IHBzcF9yZWdfcHJvZ3JhbShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwgZW51bSBwc3BfcmVn
X3Byb2dfaWQgcmVnLAogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyB2b2lkIHBzcF9wcmVwX3hn
bWlfdGFfbG9hZF9jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQsCi0JCQkJCSAg
dWludDY0X3QgeGdtaV90YV9tYywgdWludDY0X3QgeGdtaV9tY19zaGFyZWQsCi0JCQkJCSAgdWlu
dDMyX3QgeGdtaV90YV9zaXplLCB1aW50MzJfdCBzaGFyZWRfc2l6ZSkKK3N0YXRpYyB2b2lkIHBz
cF9wcmVwX3RhX2xvYWRfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAorCQkJ
CSAgICAgdWludDY0X3QgdGFfYmluX21jLAorCQkJCSAgICAgdWludDMyX3QgdGFfYmluX3NpemUs
CisJCQkJICAgICB1aW50NjRfdCB0YV9zaGFyZWRfbWMsCisJCQkJICAgICB1aW50MzJfdCB0YV9z
aGFyZWRfc2l6ZSkKIHsKLSAgICAgICAgY21kLT5jbWRfaWQgPSBHRlhfQ01EX0lEX0xPQURfVEE7
Ci0gICAgICAgIGNtZC0+Y21kLmNtZF9sb2FkX3RhLmFwcF9waHlfYWRkcl9sbyA9IGxvd2VyXzMy
X2JpdHMoeGdtaV90YV9tYyk7Ci0gICAgICAgIGNtZC0+Y21kLmNtZF9sb2FkX3RhLmFwcF9waHlf
YWRkcl9oaSA9IHVwcGVyXzMyX2JpdHMoeGdtaV90YV9tYyk7Ci0gICAgICAgIGNtZC0+Y21kLmNt
ZF9sb2FkX3RhLmFwcF9sZW4gPSB4Z21pX3RhX3NpemU7CisgICAgICAgIGNtZC0+Y21kX2lkIAkJ
CQk9IEdGWF9DTURfSURfTE9BRF9UQTsKKyAgICAgICAgY21kLT5jbWQuY21kX2xvYWRfdGEuYXBw
X3BoeV9hZGRyX2xvIAk9IGxvd2VyXzMyX2JpdHModGFfYmluX21jKTsKKyAgICAgICAgY21kLT5j
bWQuY21kX2xvYWRfdGEuYXBwX3BoeV9hZGRyX2hpIAk9IHVwcGVyXzMyX2JpdHModGFfYmluX21j
KTsKKyAgICAgICAgY21kLT5jbWQuY21kX2xvYWRfdGEuYXBwX2xlbiAJCT0gdGFfYmluX3NpemU7
CiAKLSAgICAgICAgY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9waHlfYWRkcl9sbyA9IGxv
d2VyXzMyX2JpdHMoeGdtaV9tY19zaGFyZWQpOwotICAgICAgICBjbWQtPmNtZC5jbWRfbG9hZF90
YS5jbWRfYnVmX3BoeV9hZGRyX2hpID0gdXBwZXJfMzJfYml0cyh4Z21pX21jX3NoYXJlZCk7Ci0g
ICAgICAgIGNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfbGVuID0gc2hhcmVkX3NpemU7Cisg
ICAgICAgIGNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfcGh5X2FkZHJfbG8gPSBsb3dlcl8z
Ml9iaXRzKHRhX3NoYXJlZF9tYyk7CisgICAgICAgIGNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9i
dWZfcGh5X2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKHRhX3NoYXJlZF9tYyk7CisgICAgICAgIGNt
ZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfbGVuIAkgPSB0YV9zaGFyZWRfc2l6ZTsKIH0KIAog
c3RhdGljIGludCBwc3BfeGdtaV9pbml0X3NoYXJlZF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3ApCkBAIC00NzQsOSArNDc2LDExIEBAIHN0YXRpYyBpbnQgcHNwX3hnbWlfbG9hZChzdHJ1Y3Qg
cHNwX2NvbnRleHQgKnBzcCkKIAltZW1zZXQocHNwLT5md19wcmlfYnVmLCAwLCBQU1BfMV9NRUcp
OwogCW1lbWNweShwc3AtPmZ3X3ByaV9idWYsIHBzcC0+dGFfeGdtaV9zdGFydF9hZGRyLCBwc3At
PnRhX3hnbWlfdWNvZGVfc2l6ZSk7CiAKLQlwc3BfcHJlcF94Z21pX3RhX2xvYWRfY21kX2J1Zihj
bWQsIHBzcC0+ZndfcHJpX21jX2FkZHIsCi0JCQkJICAgICAgcHNwLT54Z21pX2NvbnRleHQueGdt
aV9zaGFyZWRfbWNfYWRkciwKLQkJCQkgICAgICBwc3AtPnRhX3hnbWlfdWNvZGVfc2l6ZSwgUFNQ
X1hHTUlfU0hBUkVEX01FTV9TSVpFKTsKKwlwc3BfcHJlcF90YV9sb2FkX2NtZF9idWYoY21kLAor
CQkJCSBwc3AtPmZ3X3ByaV9tY19hZGRyLAorCQkJCSBwc3AtPnRhX3hnbWlfdWNvZGVfc2l6ZSwK
KwkJCQkgcHNwLT54Z21pX2NvbnRleHQueGdtaV9zaGFyZWRfbWNfYWRkciwKKwkJCQkgUFNQX1hH
TUlfU0hBUkVEX01FTV9TSVpFKTsKIAogCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihwc3AsIE5V
TEwsIGNtZCwKIAkJCQkgcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CkBAIC00OTEsMTMgKzQ5NSw2
IEBAIHN0YXRpYyBpbnQgcHNwX3hnbWlfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAly
ZXR1cm4gcmV0OwogfQogCi1zdGF0aWMgdm9pZCBwc3BfcHJlcF94Z21pX3RhX3VubG9hZF9jbWRf
YnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQsCi0JCQkJCSAgICB1aW50MzJfdCB4Z21p
X3Nlc3Npb25faWQpCi17Ci0JY21kLT5jbWRfaWQgPSBHRlhfQ01EX0lEX1VOTE9BRF9UQTsKLQlj
bWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Npb25faWQgPSB4Z21pX3Nlc3Npb25faWQ7Ci19Ci0K
IHN0YXRpYyBpbnQgcHNwX3hnbWlfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewog
CWludCByZXQ7CkBAIC01MTEsNyArNTA4LDcgQEAgc3RhdGljIGludCBwc3BfeGdtaV91bmxvYWQo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJaWYgKCFjbWQpCiAJCXJldHVybiAtRU5PTUVNOwog
Ci0JcHNwX3ByZXBfeGdtaV90YV91bmxvYWRfY21kX2J1ZihjbWQsIHBzcC0+eGdtaV9jb250ZXh0
LnNlc3Npb25faWQpOworCXBzcF9wcmVwX3RhX3VubG9hZF9jbWRfYnVmKGNtZCwgcHNwLT54Z21p
X2NvbnRleHQuc2Vzc2lvbl9pZCk7CiAKIAlyZXQgPSBwc3BfY21kX3N1Ym1pdF9idWYocHNwLCBO
VUxMLCBjbWQsCiAJCQkJIHBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwpAQCAtNjA1LDIwICs2MDIs
NiBAQCBzdGF0aWMgaW50IHBzcF94Z21pX2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3ApCiB9CiAKIC8vIHJhcyBiZWdpbgotc3RhdGljIHZvaWQgcHNwX3ByZXBfcmFzX3RhX2xvYWRf
Y21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAotCQl1aW50NjRfdCByYXNfdGFf
bWMsIHVpbnQ2NF90IHJhc19tY19zaGFyZWQsCi0JCXVpbnQzMl90IHJhc190YV9zaXplLCB1aW50
MzJfdCBzaGFyZWRfc2l6ZSkKLXsKLQljbWQtPmNtZF9pZCA9IEdGWF9DTURfSURfTE9BRF9UQTsK
LQljbWQtPmNtZC5jbWRfbG9hZF90YS5hcHBfcGh5X2FkZHJfbG8gPSBsb3dlcl8zMl9iaXRzKHJh
c190YV9tYyk7Ci0JY21kLT5jbWQuY21kX2xvYWRfdGEuYXBwX3BoeV9hZGRyX2hpID0gdXBwZXJf
MzJfYml0cyhyYXNfdGFfbWMpOwotCWNtZC0+Y21kLmNtZF9sb2FkX3RhLmFwcF9sZW4gPSByYXNf
dGFfc2l6ZTsKLQotCWNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9idWZfcGh5X2FkZHJfbG8gPSBs
b3dlcl8zMl9iaXRzKHJhc19tY19zaGFyZWQpOwotCWNtZC0+Y21kLmNtZF9sb2FkX3RhLmNtZF9i
dWZfcGh5X2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKHJhc19tY19zaGFyZWQpOwotCWNtZC0+Y21k
LmNtZF9sb2FkX3RhLmNtZF9idWZfbGVuID0gc2hhcmVkX3NpemU7Ci19Ci0KIHN0YXRpYyBpbnQg
cHNwX3Jhc19pbml0X3NoYXJlZF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7CiAJaW50
IHJldDsKQEAgLTY1NCw5ICs2MzcsMTEgQEAgc3RhdGljIGludCBwc3BfcmFzX2xvYWQoc3RydWN0
IHBzcF9jb250ZXh0ICpwc3ApCiAJbWVtc2V0KHBzcC0+ZndfcHJpX2J1ZiwgMCwgUFNQXzFfTUVH
KTsKIAltZW1jcHkocHNwLT5md19wcmlfYnVmLCBwc3AtPnRhX3Jhc19zdGFydF9hZGRyLCBwc3At
PnRhX3Jhc191Y29kZV9zaXplKTsKIAotCXBzcF9wcmVwX3Jhc190YV9sb2FkX2NtZF9idWYoY21k
LCBwc3AtPmZ3X3ByaV9tY19hZGRyLAotCQkJcHNwLT5yYXMucmFzX3NoYXJlZF9tY19hZGRyLAot
CQkJcHNwLT50YV9yYXNfdWNvZGVfc2l6ZSwgUFNQX1JBU19TSEFSRURfTUVNX1NJWkUpOworCXBz
cF9wcmVwX3RhX2xvYWRfY21kX2J1ZihjbWQsCisJCQkJIHBzcC0+ZndfcHJpX21jX2FkZHIsCisJ
CQkJIHBzcC0+dGFfcmFzX3Vjb2RlX3NpemUsCisJCQkJIHBzcC0+cmFzLnJhc19zaGFyZWRfbWNf
YWRkciwKKwkJCQkgUFNQX1JBU19TSEFSRURfTUVNX1NJWkUpOwogCiAJcmV0ID0gcHNwX2NtZF9z
dWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLAogCQkJcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CkBA
IC02NzEsMTMgKzY1Niw2IEBAIHN0YXRpYyBpbnQgcHNwX3Jhc19sb2FkKHN0cnVjdCBwc3BfY29u
dGV4dCAqcHNwKQogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyB2b2lkIHBzcF9wcmVwX3Jhc190
YV91bmxvYWRfY21kX2J1ZihzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLAotCQkJCQkJdWlu
dDMyX3QgcmFzX3Nlc3Npb25faWQpCi17Ci0JY21kLT5jbWRfaWQgPSBHRlhfQ01EX0lEX1VOTE9B
RF9UQTsKLQljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Npb25faWQgPSByYXNfc2Vzc2lvbl9p
ZDsKLX0KLQogc3RhdGljIGludCBwc3BfcmFzX3VubG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBz
cCkKIHsKIAlpbnQgcmV0OwpAQCAtNjkzLDcgKzY3MSw3IEBAIHN0YXRpYyBpbnQgcHNwX3Jhc191
bmxvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJaWYgKCFjbWQpCiAJCXJldHVybiAtRU5P
TUVNOwogCi0JcHNwX3ByZXBfcmFzX3RhX3VubG9hZF9jbWRfYnVmKGNtZCwgcHNwLT5yYXMuc2Vz
c2lvbl9pZCk7CisJcHNwX3ByZXBfdGFfdW5sb2FkX2NtZF9idWYoY21kLCBwc3AtPnJhcy5zZXNz
aW9uX2lkKTsKIAogCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwKIAkJ
CXBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwpAQCAtODIzLDI0ICs4MDEsNiBAQCBzdGF0aWMgaW50
IHBzcF9yYXNfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIC8vIHJhcyBlbmQK
IAogLy8gSERDUCBzdGFydAotc3RhdGljIHZvaWQgcHNwX3ByZXBfaGRjcF90YV9sb2FkX2NtZF9i
dWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwKLQkJCQkJICB1aW50NjRfdCBoZGNwX3Rh
X21jLAotCQkJCQkgIHVpbnQ2NF90IGhkY3BfbWNfc2hhcmVkLAotCQkJCQkgIHVpbnQzMl90IGhk
Y3BfdGFfc2l6ZSwKLQkJCQkJICB1aW50MzJfdCBzaGFyZWRfc2l6ZSkKLXsKLQljbWQtPmNtZF9p
ZCA9IEdGWF9DTURfSURfTE9BRF9UQTsKLQljbWQtPmNtZC5jbWRfbG9hZF90YS5hcHBfcGh5X2Fk
ZHJfbG8gPSBsb3dlcl8zMl9iaXRzKGhkY3BfdGFfbWMpOwotCWNtZC0+Y21kLmNtZF9sb2FkX3Rh
LmFwcF9waHlfYWRkcl9oaSA9IHVwcGVyXzMyX2JpdHMoaGRjcF90YV9tYyk7Ci0JY21kLT5jbWQu
Y21kX2xvYWRfdGEuYXBwX2xlbiA9IGhkY3BfdGFfc2l6ZTsKLQotCWNtZC0+Y21kLmNtZF9sb2Fk
X3RhLmNtZF9idWZfcGh5X2FkZHJfbG8gPQotCQlsb3dlcl8zMl9iaXRzKGhkY3BfbWNfc2hhcmVk
KTsKLQljbWQtPmNtZC5jbWRfbG9hZF90YS5jbWRfYnVmX3BoeV9hZGRyX2hpID0KLQkJdXBwZXJf
MzJfYml0cyhoZGNwX21jX3NoYXJlZCk7Ci0JY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9s
ZW4gPSBzaGFyZWRfc2l6ZTsKLX0KLQogc3RhdGljIGludCBwc3BfaGRjcF9pbml0X3NoYXJlZF9i
dWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7CiAJaW50IHJldDsKQEAgLTg3NywxMCArODM3
LDExIEBAIHN0YXRpYyBpbnQgcHNwX2hkY3BfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkK
IAltZW1jcHkocHNwLT5md19wcmlfYnVmLCBwc3AtPnRhX2hkY3Bfc3RhcnRfYWRkciwKIAkgICAg
ICAgcHNwLT50YV9oZGNwX3Vjb2RlX3NpemUpOwogCi0JcHNwX3ByZXBfaGRjcF90YV9sb2FkX2Nt
ZF9idWYoY21kLCBwc3AtPmZ3X3ByaV9tY19hZGRyLAotCQkJCSAgICAgIHBzcC0+aGRjcF9jb250
ZXh0LmhkY3Bfc2hhcmVkX21jX2FkZHIsCi0JCQkJICAgICAgcHNwLT50YV9oZGNwX3Vjb2RlX3Np
emUsCi0JCQkJICAgICAgUFNQX0hEQ1BfU0hBUkVEX01FTV9TSVpFKTsKKwlwc3BfcHJlcF90YV9s
b2FkX2NtZF9idWYoY21kLAorCQkJCSBwc3AtPmZ3X3ByaV9tY19hZGRyLAorCQkJCSBwc3AtPnRh
X2hkY3BfdWNvZGVfc2l6ZSwKKwkJCQkgcHNwLT5oZGNwX2NvbnRleHQuaGRjcF9zaGFyZWRfbWNf
YWRkciwKKwkJCQkgUFNQX0hEQ1BfU0hBUkVEX01FTV9TSVpFKTsKIAogCXJldCA9IHBzcF9jbWRf
c3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwgcHNwLT5mZW5jZV9idWZfbWNfYWRkcik7CiAKQEAg
LTkyMSwxMiArODgyLDYgQEAgc3RhdGljIGludCBwc3BfaGRjcF9pbml0aWFsaXplKHN0cnVjdCBw
c3BfY29udGV4dCAqcHNwKQogCiAJcmV0dXJuIDA7CiB9Ci1zdGF0aWMgdm9pZCBwc3BfcHJlcF9o
ZGNwX3RhX3VubG9hZF9jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQsCi0JCQkJ
CSAgICB1aW50MzJfdCBoZGNwX3Nlc3Npb25faWQpCi17Ci0JY21kLT5jbWRfaWQgPSBHRlhfQ01E
X0lEX1VOTE9BRF9UQTsKLQljbWQtPmNtZC5jbWRfdW5sb2FkX3RhLnNlc3Npb25faWQgPSBoZGNw
X3Nlc3Npb25faWQ7Ci19CiAKIHN0YXRpYyBpbnQgcHNwX2hkY3BfdW5sb2FkKHN0cnVjdCBwc3Bf
Y29udGV4dCAqcHNwKQogewpAQCAtOTQzLDcgKzg5OCw3IEBAIHN0YXRpYyBpbnQgcHNwX2hkY3Bf
dW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCWlmICghY21kKQogCQlyZXR1cm4gLUVO
T01FTTsKIAotCXBzcF9wcmVwX2hkY3BfdGFfdW5sb2FkX2NtZF9idWYoY21kLCBwc3AtPmhkY3Bf
Y29udGV4dC5zZXNzaW9uX2lkKTsKKwlwc3BfcHJlcF90YV91bmxvYWRfY21kX2J1ZihjbWQsIHBz
cC0+aGRjcF9jb250ZXh0LnNlc3Npb25faWQpOwogCiAJcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVm
KHBzcCwgTlVMTCwgY21kLCBwc3AtPmZlbmNlX2J1Zl9tY19hZGRyKTsKIApAQCAtMTAxNiwyMiAr
OTcxLDYgQEAgc3RhdGljIGludCBwc3BfaGRjcF90ZXJtaW5hdGUoc3RydWN0IHBzcF9jb250ZXh0
ICpwc3ApCiAvLyBIRENQIGVuZAogCiAvLyBEVE0gc3RhcnQKLXN0YXRpYyB2b2lkIHBzcF9wcmVw
X2R0bV90YV9sb2FkX2NtZF9idWYoc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZCwKLQkJCQkJ
IHVpbnQ2NF90IGR0bV90YV9tYywKLQkJCQkJIHVpbnQ2NF90IGR0bV9tY19zaGFyZWQsCi0JCQkJ
CSB1aW50MzJfdCBkdG1fdGFfc2l6ZSwKLQkJCQkJIHVpbnQzMl90IHNoYXJlZF9zaXplKQotewot
CWNtZC0+Y21kX2lkID0gR0ZYX0NNRF9JRF9MT0FEX1RBOwotCWNtZC0+Y21kLmNtZF9sb2FkX3Rh
LmFwcF9waHlfYWRkcl9sbyA9IGxvd2VyXzMyX2JpdHMoZHRtX3RhX21jKTsKLQljbWQtPmNtZC5j
bWRfbG9hZF90YS5hcHBfcGh5X2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKGR0bV90YV9tYyk7Ci0J
Y21kLT5jbWQuY21kX2xvYWRfdGEuYXBwX2xlbiA9IGR0bV90YV9zaXplOwotCi0JY21kLT5jbWQu
Y21kX2xvYWRfdGEuY21kX2J1Zl9waHlfYWRkcl9sbyA9IGxvd2VyXzMyX2JpdHMoZHRtX21jX3No
YXJlZCk7Ci0JY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9waHlfYWRkcl9oaSA9IHVwcGVy
XzMyX2JpdHMoZHRtX21jX3NoYXJlZCk7Ci0JY21kLT5jbWQuY21kX2xvYWRfdGEuY21kX2J1Zl9s
ZW4gPSBzaGFyZWRfc2l6ZTsKLX0KLQogc3RhdGljIGludCBwc3BfZHRtX2luaXRfc2hhcmVkX2J1
ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0OwpAQCAtMTA2NywxMCArMTAw
NiwxMSBAQCBzdGF0aWMgaW50IHBzcF9kdG1fbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkK
IAltZW1zZXQocHNwLT5md19wcmlfYnVmLCAwLCBQU1BfMV9NRUcpOwogCW1lbWNweShwc3AtPmZ3
X3ByaV9idWYsIHBzcC0+dGFfZHRtX3N0YXJ0X2FkZHIsIHBzcC0+dGFfZHRtX3Vjb2RlX3NpemUp
OwogCi0JcHNwX3ByZXBfZHRtX3RhX2xvYWRfY21kX2J1ZihjbWQsIHBzcC0+ZndfcHJpX21jX2Fk
ZHIsCi0JCQkJICAgICBwc3AtPmR0bV9jb250ZXh0LmR0bV9zaGFyZWRfbWNfYWRkciwKLQkJCQkg
ICAgIHBzcC0+dGFfZHRtX3Vjb2RlX3NpemUsCi0JCQkJICAgICBQU1BfRFRNX1NIQVJFRF9NRU1f
U0laRSk7CisJcHNwX3ByZXBfdGFfbG9hZF9jbWRfYnVmKGNtZCwKKwkJCQkgcHNwLT5md19wcmlf
bWNfYWRkciwKKwkJCQkgcHNwLT50YV9kdG1fdWNvZGVfc2l6ZSwKKwkJCQkgcHNwLT5kdG1fY29u
dGV4dC5kdG1fc2hhcmVkX21jX2FkZHIsCisJCQkJIFBTUF9EVE1fU0hBUkVEX01FTV9TSVpFKTsK
IAogCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1Zihwc3AsIE5VTEwsIGNtZCwgcHNwLT5mZW5jZV9i
dWZfbWNfYWRkcik7CiAKLS0gCjIuMTcuMQoK

--_006_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_006_MN2PR12MB3663872631805EAF879D6E49FB2B0MN2PR12MB3663namp_--
