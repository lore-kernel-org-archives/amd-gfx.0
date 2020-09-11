Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3EFC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 04:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A812078D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 04:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d2OVx7l1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A812078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D386E287;
	Fri, 11 Sep 2020 04:02:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8836A6E287
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 04:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFWFUMxwkhlyHfXHxJ3KxSIARoudhc5ys2hBbTFatlp9tDBnNLhoS5NaT0nV/ct8KJabam4I20Rv6uo4sPYYptBTLCQEgFTKQcjYmZleMcf4jtHtr5tQMUZZiq2p+4hHohzhtrUJobj6miuRqXaaorT4KX9ZW2tITcjQkb5dpEaDnNwCPF3Hdemi+DxM+9xPlAZmfvKLdbe41eQzT26zi/SKoLRJHHgPC8NqQoyzN0AXAvZhr0hizkVwDPexBAZCVbjEftJDRVNmeXFH/2hzSAbx69JoYvtbFzkn3SrP6EZx9NsLaJMDoRy19+h7KXVWd+8OCqVF3lTUlPneBsdsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1W18Klef+flrayiwc9pFOnkV89qCU39P+aEYcZaKeE=;
 b=DCcHKNYfjv6/3vgcnixY/C8VNtWr/rz4YqOrF5ncs9i3yAYQRtcslVhNxdsxczqVrsUhwj95aSJ2q4OlP5pU34A3ybH6KZzbZLM419h3IUMqrJYMMqxjYeVKts1d5XDhZFgiedcmV9F46jhCQHbTP9Ye8dvUxx6Bdce76dAf69M8aOgB1X5A2N9ndTDUTNRUIKcLiFTzfDMCq8BarSNVfT8sdTRQnHCm/FAIuU4CXcfz4pr6I6deQ8otaXlKZIseN0uK1Qg//ddqmck2XbBZru4qhXBxvS5wC+jVDBrV2J38RaKQjaHWoxTwEeD2sLwXibta451uh+qUy27A+Hud6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1W18Klef+flrayiwc9pFOnkV89qCU39P+aEYcZaKeE=;
 b=d2OVx7l1da+VNlpWA1WyNs5JGiXZDfkVsRfO4X68aTUbib39J5nLVImEtewu89k2WRZqO0RRnip0G3Uva1X/dqrG22VVoiZCwrjP9eSJ0SlWpREnZvuq/ZTUI4Oy5iIFN82sBI6gp3qUFNIJZDCwMk+VdB7RBzENIA5Yo69NQn8=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 04:02:42 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::2886:b3eb:a9b0:5d29]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::2886:b3eb:a9b0:5d29%7]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 04:02:42 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Topic: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Index: AdaH8EEPyluBF0UHTRSypdzG9nCpXw==
Date: Fri, 11 Sep 2020 04:02:41 +0000
Message-ID: <MN2PR12MB40324FF5E5D607A6CE8D4D50FB240@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-11T04:02:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b4e907cb-febc-4660-bd51-00007f99efa4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-11T04:02:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a04ed805-e180-4113-9955-0000a178384c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b25e51a-0d1c-4817-037d-08d85607886a
x-ms-traffictypediagnostic: MN2PR12MB4269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42697F06BF71545CEF90B541FB240@MN2PR12MB4269.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nQY7fHHHXnsYqdFBYpzYnuMPFdVEI134TZ3Sql9+9PJtBI5uQauPRUafS0GhS5De1TqmFnMkzfU5TM6qKqlH8u+0pHJfPa9zwsjzMvWszp+gxae4eld26AgYWuDYqVoKBLbhcel2E1mcgLeajkWcWEzuwvUkP0E5fuHEkHOCNsW0Bs0p1IJaoEiz2VvXqiSbwWIfseftju7ByzSk5nqIZJaC2hlbZ8kXcQvtcxdHJxqntdlgL2oehpsaWroghAD5wN7TIns7qAHe7zUo3uA49a1t2/evtAdOQio0vQV5HQsQRASJlJgVyoeHJrdQokfPSP+QYekFP//1AioO25mIUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(8676002)(6636002)(86362001)(66946007)(71200400001)(2906002)(5660300002)(110136005)(7696005)(66476007)(478600001)(8936002)(558084003)(6506007)(26005)(99936003)(316002)(186003)(66616009)(66556008)(76116006)(64756008)(52536014)(55016002)(9686003)(33656002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: hS2Z7bPbfScOWxHB15pzR3REQXWCouIC+og3LDmg4Zt5Mf1YIvF3c6ty5JhKcGw3p6iJGBytoiTrmvbuv5dqkRqIyX0XzOjq58ideuriA8D+o3dKGUX9qFywR0n1h/XbptTYPM57qjwHNr8nSUyLj0v7AQ72SK8VkMrvOssMaNtAD58eZdaok0egkTIUGNHF21WuuctHQN2Z9UM1xLRzK0mLd241VNad+mbcqCum1W015F3j5sgQYOeunQZExelEpoGdpnyXR0lPlvNT2GbClqp2GapujICV996KEvlXPhzf0vwIfevwm6GSi54XjcIAdinW2bbmUKosHW7d/PFvFvD/QfrX4tX7wzt1Nkw9CMOaXGpLS5PLJY81HM570gDr9i0G8jJn3KuLbjBvrrm+y4rLkV8MrFJw3F/J0wdNBOx0w4S/g5C66SFHs2HXyLAL8RJs7p1kv58FzOEH0wbe69EBrSDCaerFoWmcwZTfBtBqKfd0UuV5XnrwhYEuYfgMJElGUWmGVZDd/bIxBziLdxuuzvZZhhddqSh9FiJnSHiq7RHVzWIE515Z1BvShOOlw9DrR+lLnYUEhL6mKzUjA31l87ZJd0Vi49v332HsGuhvjWZhFt1kcA9dSbpXW83u1DY/STqkvl5puU8go8aOWw==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB40324FF5E5D607A6CE8D4D50FB240MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b25e51a-0d1c-4817-037d-08d85607886a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 04:02:42.0877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YubofVj9wjggj0unG2+XTcx0YiSWMMhnsxsudLegGCvEWN+7lwtVETDLMCj5dM3ZSHmi5cV33HhFs3T2t+2yPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

--_004_MN2PR12MB40324FF5E5D607A6CE8D4D50FB240MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB40324FF5E5D607A6CE8D4D50FB240MN2PR12MB4032namp_"

--_000_MN2PR12MB40324FF5E5D607A6CE8D4D50FB240MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Added RAS status check and tear down RAS context if RAS init fails

--_000_MN2PR12MB40324FF5E5D607A6CE8D4D50FB240MN2PR12MB4032namp_
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p class=3D"msipheadera92e061b" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Added RAS status check and tear down RAS context if =
RAS init fails<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB40324FF5E5D607A6CE8D4D50FB240MN2PR12MB4032namp_--

--_004_MN2PR12MB40324FF5E5D607A6CE8D4D50FB240MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Update-RAS-init-handling.patch"
Content-Description: 0001-drm-amdgpu-Update-RAS-init-handling.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Update-RAS-init-handling.patch"; size=1520;
	creation-date="Fri, 11 Sep 2020 04:01:00 GMT";
	modification-date="Fri, 11 Sep 2020 04:01:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMTdiYWJjOGJjYTY1NzI4OTc1ZGRiYzk4YmYwZWU3MzM4ZWFjNGYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgMTEgU2VwIDIwMjAgMTE6NTc6NTYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBVcGRhdGUgUkFTIGluaXQgaGFuZGxpbmcKCk91dHB1dCBSQVMgaW5pdCBzdGF0
dXMKCklmIFJBUyBpbml0IGZhaWxzLCB0ZWFyZG93biBSQVMgY29udGV4dAoKU2lnbmVkLW9mZi1i
eTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEljNzY2
MGE3MDljNjBmMTJiNDgxZmRlZTBhOGIzMjY5NDIxMDEzOGMwCi0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgMTQgKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4IGQ2YzM4ZTI0ZjEzMC4uN2RkNTE1YmFiMjJlIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC05MjksNiArOTI5LDcgQEAg
c3RhdGljIGludCBwc3BfcmFzX2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7CiAJaW50
IHJldDsKIAlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kOworCXN0cnVjdCB0YV9yYXNfc2hh
cmVkX21lbW9yeSAqcmFzX2NtZDsKIAogCS8qCiAJICogVE9ETzogYnlwYXNzIHRoZSBsb2FkaW5n
IGluIHNyaW92IGZvciBub3cKQEAgLTk1MiwxMSArOTUzLDIyIEBAIHN0YXRpYyBpbnQgcHNwX3Jh
c19sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCXJldCA9IHBzcF9jbWRfc3VibWl0X2J1
Zihwc3AsIE5VTEwsIGNtZCwKIAkJCXBzcC0+ZmVuY2VfYnVmX21jX2FkZHIpOwogCisJcmFzX2Nt
ZCA9IChzdHJ1Y3QgdGFfcmFzX3NoYXJlZF9tZW1vcnkqKXBzcC0+cmFzLnJhc19zaGFyZWRfYnVm
OworCiAJaWYgKCFyZXQpIHsKLQkJcHNwLT5yYXMucmFzX2luaXRpYWxpemVkID0gdHJ1ZTsKIAkJ
cHNwLT5yYXMuc2Vzc2lvbl9pZCA9IGNtZC0+cmVzcC5zZXNzaW9uX2lkOworCisJCWlmICghcmFz
X2NtZC0+cmFzX3N0YXR1cykKKwkJCXBzcC0+cmFzLnJhc19pbml0aWFsaXplZCA9IHRydWU7CisJ
CWVsc2UKKwkJeworCQkJZGV2X3dhcm4ocHNwLT5hZGV2LT5kZXYsICJSQVMgSW5pdCBTdGF0dXM6
IDB4JVhcbiIsIHJhc19jbWQtPnJhc19zdGF0dXMpOworCQl9CiAJfQogCisJaWYgKHJldCB8fCBy
YXNfY21kLT5yYXNfc3RhdHVzKQorCQlhbWRncHVfcmFzX2ZpbmkocHNwLT5hZGV2KTsKKwogCWtm
cmVlKGNtZCk7CiAKIAlyZXR1cm4gcmV0OwotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB40324FF5E5D607A6CE8D4D50FB240MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB40324FF5E5D607A6CE8D4D50FB240MN2PR12MB4032namp_--
