Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D2FC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 06:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C276141C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 06:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C276141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694646E954;
	Wed, 21 Apr 2021 06:56:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D5366E954
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 06:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9tGWkH1mUhjOaJOfaDCvAjEhbauyp9OGjooMMYhDIOlo9Rxw7Xa6SWXC9U9yy4cZZOuvyMDtc91PcPHLJTGOozWhUOJuvl+FaFmrwKN8pRVTAsCE4ck3i9g/U+zftX4pkrWWQAQMfRr08HN4lYq/TKxUndgUdk+kfagKd866OTRKZgrOcQUUfmnHFGvrOOzaKqGBurjyop38Ex4mRkj0sTl7UjUc/4Ca/JLqzSMPhMZ4ie7G72fQkwEztSIwzju6ZA75CLNr5DAZz37cWTEDRS+AKWIfuEuoh1akT4Bro9s5cTKz9ku63R+AqHW8u2QXqY3NXTEqxBETPpYrNu2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9vT2ble/yjBWJyiH3Zqo3R5CSpthFQ6H/0s+8Rz91c=;
 b=fsqILcMXups7JvK6ntkGZRshMJ6P3C6pM/iIwIZAGybmpEhbtJkAzY0TciRtlRf2Zp2zTaPuC/nsDLFU8FtIBIuebqyFYAKL/H012DgiYl12riZSWdyJKyx4l2HoG+8ck0YoKO2BruOgO01G5hJPvheubhB2g5SkzCksEXAHz3R2CzfRs4lvVOHowp26Ry5mvuvKOk3R5FJnoDrB+LIhFokxIAj0mA+UNIuDpkwd6aMXXxba1oEN2UM1fy59dwUoymbm7+Koaf81NHbrOCJdbMoPovcM2x4cVpmC0etusICZvf2OyocL1Wb4fpsCo2K10Fw42mbAM7yhalpMlhTb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9vT2ble/yjBWJyiH3Zqo3R5CSpthFQ6H/0s+8Rz91c=;
 b=TfwLyC/f6t8aUgal6N/GblDDe/rtinJt+93d+hy5peuSs3dqWWPeKivSaHUr1JtkJXGvFhBba0bb4udhQqW9+CiKRPxGeRZCjeDiiRb3uwqKnOMt86TIKZddbYAF7tMHbnVraTsr7HczSKU8La5TEfXRC8kjNoG9DYlKM7sSBGY=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR12MB1943.namprd12.prod.outlook.com
 (2603:10b6:903:11b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Wed, 21 Apr
 2021 06:56:50 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe%11]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 06:56:50 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add support for ras init flags
Thread-Topic: [PATCH] drm/amdgpu: add support for ras init flags
Thread-Index: Adc2e2sVzY4y+ytVSquzemrmPH/DYg==
Date: Wed, 21 Apr 2021 06:56:50 +0000
Message-ID: <CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479@CY4PR1201MB0072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-21T06:56:44Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=35481797-6da5-4a76-92d1-e98491688a81;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae7cebb6-aa62-4bf6-8b82-08d90492a3c4
x-ms-traffictypediagnostic: CY4PR12MB1943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB194316577AD1A72C050A3EB2FB479@CY4PR12MB1943.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5COvWFj/T8LY2fcAOREqALqtMKlFf11o1CleC+ioVcg/89O3U8yk4HGTEogtEhLXkm8bhA32e/O1RByzpw1fLPZ/TD54jXtjU1TntPWdorQFce9rquFUsvhLUlXjunmjPk7gZxtn0onVvTe8ZogXoAoZjQvRSgxcyeszBZenuqg1JmLxmfvM2BAKLkXpx3mBKDNZf2fyJf2XYPP7fh6Zsc7dQ/quFTIBkTeRpcKE5PfBzFcSL23wE+X912LJ+AUAzTuzmeNiVBu9QVzhEVEqKaM9MV16fRRzvQE4q0AuOiKoORoPM4RIx7SBvqB6BYJFTG9LPKeE52xvxv5KorSpeH4un1jbTcg2bF/LzshosqqhMWoLz/3peFV8gc1KiUNlOTOcYNaLhp6N79drliY1JYiYa665VmiEhnvekSqn1P38LWAexU9OhhhZVx1E4Y1uC3Fr7/qBwC39m8xbUaeRjb+3I9v9a5+QvozF/xgAaGd7YnBGoSOtByVE3PHkSrv4Mi/kKo3Uw9y/8h4ymuAi+IWp1QKA3uBEbUn4c0SmVjianKp7/50E6VYm313V+gMFbvjx3x6WppcMxrXgHjzUpnXk1MgUJQdrgMP24DvZH0o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(110136005)(7696005)(186003)(55016002)(122000001)(66476007)(9686003)(6506007)(52536014)(66616009)(66556008)(558084003)(64756008)(5660300002)(38100700002)(478600001)(2906002)(86362001)(99936003)(71200400001)(66446008)(66946007)(316002)(76116006)(8936002)(8676002)(33656002)(26005)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?F+0NrvfpB140xabRbx/oQuQPyUvZPvQ9THzrJslj3L5H3GZQVVaWl3D3g7D7?=
 =?us-ascii?Q?NJfeVr+OTSc3T58iIHEpJ16PWfErbVPrmlUQ0UxOTGYeHJY8EeYmrEg8ru9X?=
 =?us-ascii?Q?e/Oj4MM1INA2bjnmsc0FRCqJYk8N+Jjw/2yso4TQS7AaIhhIR6qlPBpVBe5m?=
 =?us-ascii?Q?gsYmXNN89hh8SGaVTSGHm5FNmjj15gU7hPFKB5TK5J/cksG4xLAKjvhkZu31?=
 =?us-ascii?Q?l86teHYHGpemzc8VGKmju8bt79NfXsCnV21t0pSiOrmmncZUnarE7/jhMltD?=
 =?us-ascii?Q?5zlmeWwmcRsImCBh/cj2Xk6YIQVi/igk1J9PLh3l7HnycYFxCNJXnfCuM5lH?=
 =?us-ascii?Q?WD5KalEMBjtsSNhI4GoZrzcHWLEumesLU0VwUQ2ERCaDGUE7nVbJ4ZU9pcS5?=
 =?us-ascii?Q?+MMJQiWrZudGir5A4dUGKz+b+MI4PLomRx41aF9MaqQZlvQMro7cwEVTBIag?=
 =?us-ascii?Q?4ZQcXO6LkWiVeDd0JKYjwTjb/vba3RwAB3lXZ3cvpfvAb7xT1EtUNi/twbvV?=
 =?us-ascii?Q?l25uKQ94d5RAKLTzsC5w5NcbWE4B3Oosby1QmYNz62N+tIyF/e1IjmpbyuSu?=
 =?us-ascii?Q?u4fHqi0VV0DqVT1ThgO8TXtLeiOy7puUVqznAAtmveU7AHg5jl6Vhx4moI1F?=
 =?us-ascii?Q?G2ptiAMimuoGx7iJqGTFvh56YjQlUKWkyWLZ7JCHc0wudHSI/VLv5EUkT3Iz?=
 =?us-ascii?Q?+3WTyzpTLLRlJe0oV8zxWqRO/iz4C4XXucSfYjWi+dGIT8pHN12fRbA+6dLA?=
 =?us-ascii?Q?oyvDlQUSMyG2wMbPTlMkdI05XiHPxTWZz4saWsBf31M83ypuUGCm1MKYsv8N?=
 =?us-ascii?Q?ePVGkq0dwMiRoSaR6ybmpc7KQz/Oi6CRdvg37jpFvbdOFs9O0rHDiqEW1mDu?=
 =?us-ascii?Q?Ykq7Dwkn4N8UfeSsB2Lc0kuG+iiq57Tt/dDKRMOo+zOyQxyMq4c5wlOnYiSv?=
 =?us-ascii?Q?6oX6DwBDGHOstM842lLIEEe+0MBiiBvhv2mmclw2TDPRGU/odUlWMhwQcJWA?=
 =?us-ascii?Q?tl40J4jzbBl+/1hTW5SRga53KiJkBkwfp5/IZpwT6EdzZmEuMp3peSZ2JO1V?=
 =?us-ascii?Q?jtEkvWNUwV0a1yORLiuU/Pb/+5oKHuSZyOgmwr/I5roov/NmOQe4KQ5CGcX5?=
 =?us-ascii?Q?gB5hjgcAXrTkF8pL8HagxYVAzxtnltMVf8QTMPS4Ng2SqY2kBzo3+JTxRp/D?=
 =?us-ascii?Q?o8iWlXXjo1js8s/AOcqcqx71QjVLYbKi0plGrhn9AmzDKp3hrfNYe1GYbiJi?=
 =?us-ascii?Q?jxLlbnnpxloKNbjWZllBoZypCzVmLJs7qSIz957dLpYf2K+RWpplzmjz2cpj?=
 =?us-ascii?Q?pJhy2NJkkD2jsGTqB6YPqoRl?=
Content-Type: multipart/mixed;
 boundary="_004_CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479CY4PR1201MB0072_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7cebb6-aa62-4bf6-8b82-08d90492a3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 06:56:50.7419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtEp2Y62FIdWFAWzQZyJYqVL2OuLIFcuvNSHFKTQuFXEwkiNH7ng95FEpDROWdVr9uMKGL8VCc/v89UeXW4KzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1943
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

--_004_CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479CY4PR1201MB0072_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479CY4PR1201MB0072_"

--_000_CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to select RAS dGPU mode/poison propagation mode

--_000_CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479CY4PR1201MB0072_
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
<p class=3D"msipheadera92f4c5c" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:11.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to select RAS dGPU mode/poison prop=
agation mode<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479CY4PR1201MB0072_--

--_004_CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479CY4PR1201MB0072_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-add-support-for-ras-init-flags.patch"
Content-Description: 0001-drm-amdgpu-add-support-for-ras-init-flags.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-add-support-for-ras-init-flags.patch"; size=2504;
	creation-date="Wed, 21 Apr 2021 06:56:00 GMT";
	modification-date="Wed, 21 Apr 2021 06:56:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxY2JkN2RlZjI5YTMzYzRkMDBjMDVmMmJjZThmYjZkNzEyOTJiZTE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgMjEgQXByIDIwMjEgMTQ6Mzk6MjcgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gZHJtL2FtZGdwdTogYWRkIHN1cHBvcnQgZm9yIHJhcyBpbml0IGZsYWdzCgpjb25kaXRpb25h
bGx5IGNvbmZpZ3VyZSByYXMgZm9yIGRncHUgbW9kZSBvciBwb2lzb24gcHJvcG9nYXRpb24gbW9k
ZQoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpD
aGFuZ2UtSWQ6IElkOWUzZmMzODZmNmY2ZDdiZGFjYWUyZGUyY2Q1MzYwYjAxN2U5OTk2Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgOSArKysrKysrLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3RhX3Jhc19pZi5oICB8IDcgKysrKysrKwogMiBmaWxl
cyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCBhMDk0ODNiZWI5NjguLjkzMTFkY2M5NGNi
NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwpAQCAtMTAzNyw2ICsx
MDM3LDEzIEBAIHN0YXRpYyBpbnQgcHNwX3Jhc19sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNw
KQogCW1lbXNldChwc3AtPmZ3X3ByaV9idWYsIDAsIFBTUF8xX01FRyk7CiAJbWVtY3B5KHBzcC0+
ZndfcHJpX2J1ZiwgcHNwLT50YV9yYXNfc3RhcnRfYWRkciwgcHNwLT50YV9yYXNfdWNvZGVfc2l6
ZSk7CiAKKwlyYXNfY21kID0gKHN0cnVjdCB0YV9yYXNfc2hhcmVkX21lbW9yeSAqKXBzcC0+cmFz
LnJhc19zaGFyZWRfYnVmOworCisJaWYgKHBzcC0+YWRldi0+Z21jLnhnbWkuY29ubmVjdGVkX3Rv
X2NwdSkKKwkJcmFzX2NtZC0+cmFzX2luX21lc3NhZ2UuaW5pdF9mbGFncy5wb2lzb25fbW9kZV9l
biA9IDE7CisJZWxzZQorCQlyYXNfY21kLT5yYXNfaW5fbWVzc2FnZS5pbml0X2ZsYWdzLmRncHVf
bW9kZSA9IDE7CisKIAlwc3BfcHJlcF90YV9sb2FkX2NtZF9idWYoY21kLAogCQkJCSBwc3AtPmZ3
X3ByaV9tY19hZGRyLAogCQkJCSBwc3AtPnRhX3Jhc191Y29kZV9zaXplLApAQCAtMTA0Niw4ICsx
MDUzLDYgQEAgc3RhdGljIGludCBwc3BfcmFzX2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3Ap
CiAJcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLAogCQkJcHNwLT5mZW5j
ZV9idWZfbWNfYWRkcik7CiAKLQlyYXNfY21kID0gKHN0cnVjdCB0YV9yYXNfc2hhcmVkX21lbW9y
eSAqKXBzcC0+cmFzLnJhc19zaGFyZWRfYnVmOwotCiAJaWYgKCFyZXQpIHsKIAkJcHNwLT5yYXMu
c2Vzc2lvbl9pZCA9IGNtZC0+cmVzcC5zZXNzaW9uX2lkOwogCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS90YV9yYXNfaWYuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3RhX3Jhc19pZi5oCmluZGV4IDc0NWVkMGZiYTFlZC4uMGYyMTRhMzk4ZGQ4IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS90YV9yYXNfaWYuaAorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS90YV9yYXNfaWYuaApAQCAtMTA1LDYgKzEwNSwxMiBAQCBzdHJ1
Y3QgdGFfcmFzX3RyaWdnZXJfZXJyb3JfaW5wdXQgewogCXVpbnQ2NF90CQl2YWx1ZTsJCQkvLyBt
ZXRob2QgaWYgZXJyb3IgaW5qZWN0aW9uLiBpLmUgcGVyc2lzdGVudCwgY29oZXJlbnQgZXRjLgog
fTsKIAorc3RydWN0IHRhX3Jhc19pbml0X2ZsYWdzCit7CisgICAgdWludDhfdCAgICAgcG9pc29u
X21vZGVfZW47CisgICAgdWludDhfdCAgICAgZGdwdV9tb2RlOworfTsKKwogc3RydWN0IHRhX3Jh
c19vdXRwdXRfZmxhZ3MKIHsKIAl1aW50OF90ICAgIHJhc19pbml0X3N1Y2Nlc3NfZmxhZzsKQEAg
LTExNSw2ICsxMjEsNyBAQCBzdHJ1Y3QgdGFfcmFzX291dHB1dF9mbGFncwogLyogQ29tbW9uIGlu
cHV0IHN0cnVjdHVyZSBmb3IgUkFTIGNhbGxiYWNrcyAqLwogLyoqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiB1bmlvbiB0YV9yYXNfY21k
X2lucHV0IHsKKwlzdHJ1Y3QgdGFfcmFzX2luaXRfZmxhZ3MJCWluaXRfZmxhZ3M7CiAJc3RydWN0
IHRhX3Jhc19lbmFibGVfZmVhdHVyZXNfaW5wdXQJZW5hYmxlX2ZlYXR1cmVzOwogCXN0cnVjdCB0
YV9yYXNfZGlzYWJsZV9mZWF0dXJlc19pbnB1dAlkaXNhYmxlX2ZlYXR1cmVzOwogCXN0cnVjdCB0
YV9yYXNfdHJpZ2dlcl9lcnJvcl9pbnB1dAl0cmlnZ2VyX2Vycm9yOwotLSAKMi4xNy4xCgo=

--_004_CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479CY4PR1201MB0072_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_CY4PR1201MB0072C488E2F3326FDE1A1DF3FB479CY4PR1201MB0072_--
