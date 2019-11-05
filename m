Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91C8C17496
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 14:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93BF21882
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 14:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93BF21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D7F6EA99;
	Tue,  5 Nov 2019 14:36:46 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820074.outbound.protection.outlook.com [40.107.82.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B7FD6EA99
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 14:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBw70QVj0NSEld43BDo39WcMycA9RsVjNTQpRsZk/UyG/1yYIUmNbB8u5Hbw3IL4kL4VrfaOGAg/ezQPMVWkbLcwut6qHuVt2w/BHmdZ5TbCq9mGFh+ycaR0Bz75G4eTcfeEjDBj3js56hmBAyqH5XVP88s1pdU42dHYMEq5KuykLc56GVICmPjqmJ51Rw7ZoWDy7mobTyK61yl/7zJT+uexKqy5pBmo40tubqLFy8fkBw4IqAusAYZjxKDSHcGYL1XsG2IC+VVxVZEZyWdbLglZYgQoBBqIBF/3L1UzCaUCM3f9k0hhGWGD87b1aztH72C77HqqjdhF2shn9qgCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81TWcZLOgr/ZN1VEobAqyDxKMtbc3n29C+QbqisjMJc=;
 b=lKXq9P/DoZoHXI36jaeoCqQRZy83iuYyG1/rL5IH+Blcr0Lw+rryBG+52l9vOpfNK2Zam5K9DU2yXxdwVSO4kDmOO4zW5rDQYW4rVLP3cjRa3IMDFjPkpzu0vMfFdO0oTy4l+HYWP5Xf5MfL+x3ABzicCBUhdUCg1NoigBJOp4myrNUIi2cxjo1Mp4YdwgbZHnnYbEq3GnpAMjs9vRbCge8MtvfqAl5kjCIaclRszpLzkRTf4WC/dBtVT/J0tGVT3VWDeJ++KFnpuwWShMCfbbdMF7JHfEmoAG63Xx6Dsu4D3izAARFH0CLc7unlsx7yImQ+HztO6zfisYZTgZNqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3886.namprd12.prod.outlook.com (10.255.238.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 14:36:40 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 14:36:40 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
Subject: Re: [PATCH] drm/amd/swSMU: fix smu workload bit map error
Thread-Topic: [PATCH] drm/amd/swSMU: fix smu workload bit map error
Thread-Index: AQHVk8MJd2VpLOnQMUGIiK8RW7QVPqd8pVeA
Date: Tue, 5 Nov 2019 14:36:40 +0000
Message-ID: <ADFBF901-E147-4148-AF0E-B51D217C34A3@amd.com>
References: <20191105102302.21037-1-kevin1.wang@amd.com>
In-Reply-To: <20191105102302.21037-1-kevin1.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [101.88.25.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4899b0e8-9d1a-429c-5df1-08d761fd9259
x-ms-traffictypediagnostic: MN2PR12MB3886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38868A451E89626C0A0984D78E7E0@MN2PR12MB3886.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:160;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(236005)(26005)(66066001)(6246003)(6512007)(478600001)(2906002)(476003)(11346002)(14454004)(37006003)(256004)(316002)(3846002)(76176011)(6506007)(5660300002)(81166006)(7736002)(86362001)(486006)(186003)(36756003)(2616005)(81156014)(6636002)(446003)(71190400001)(8936002)(4326008)(66946007)(66556008)(66476007)(6862004)(99286004)(6116002)(91956017)(76116006)(66446008)(71200400001)(64756008)(25786009)(33656002)(6436002)(54896002)(229853002)(102836004)(6486002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3886;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spLyBmD2afqDLHG6A5pcSy68zYBOJalTyviE6ekXPirfwTrYIVO9IFBrFtm/cIg8AZ4URbYzCNTCgtD5Ij3M/YQuYfWAGib6q614wEJWH9X4K87aVt8avYBysNkaS/j+jLoRMvMxPjVxLGzWSbiXB9I/8R+vzbhMC5wHLWNPAihmY9DxKCHan/Xu6fL6G/5iirlP0ImfdoF7mUGsjacevGC/Q18+4BfirdFHQk8rYwHqn4nxOAVbhyjeRYCrILkIC1X3p9Dvj7tx0wvHJljnlgxzZUO/8QTgMqxfm5dAoBHYUnxuxExyxRN6r9U8nHNeKFRv1hdU3zDgiotOE1zekgAbuyJChGYSVvbDuEA3/eWWoo1dvNiF3HSlqMoE90Ryah9zhXvOpXPDu7XxCU8j/w0Y3SDEN5t8j1F9xpWcnyVWrXWlUA11GMOz8vF5ICgz
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4899b0e8-9d1a-429c-5df1-08d761fd9259
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 14:36:40.4475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1Ej+QC4QcbLIUOZtJMB7tUTkbx4uYY4TGVJk4jRSnzSxDrMcK5W0NjbmnG4M9x+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3886
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81TWcZLOgr/ZN1VEobAqyDxKMtbc3n29C+QbqisjMJc=;
 b=Ok3aEl5mz0gRvM4qMjkYsV3GUhKnbYMQ9VjLH2VTmbgMXAusYsfYvBXtnpFb5Yr0xB5Roayk+7kvGklBVEZ41eqjvE0giqLV5fj5KlnDIJS7zifBDqFjCuXUkbo0evtfEjfouzIRAe5Zf2wY47/FOxvnyKdhDuOfayGw1htmIT4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0526005268=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105143640.uRYwcJwtBtOyg-7J1cI8a2M7KZ9lkR54YhO1baJPWiM@z>

--===============0526005268==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_ADFBF901E1474148AF0EB51D217C34A3amdcom_"

--_000_ADFBF901E1474148AF0EB51D217C34A3amdcom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

UmV2aWV3ZWQtYnk6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5mZW5nQGFtZC5jb208bWFpbHRvOmtl
bm5ldGguZmVuZ0BhbWQuY29tPj4NCg0KDQrU2iAyMDE5xOoxMdTCNcjVo6zPws7nNjoyM6OsV2Fu
ZywgS2V2aW4oWWFuZykgPEtldmluMS5XYW5nQGFtZC5jb208bWFpbHRvOktldmluMS5XYW5nQGFt
ZC5jb20+PiDQtLXAo7oNCg0KZml4IHdvcmtsb2FkIGJpdCAoV09SS0xPQURfUFBMSUJfQ09NUFVU
RV9CSVQpIG1hcCBlcnJvcg0Kb24gdmVnYTIwIGFuZCBuYXZpIGFzaWMuDQoNCmZpeCBjb21taXQ6
DQpkcm0vYW1kL3Bvd2VycGxheTogYWRkIGZ1bmN0aW9uIGdldF93b3JrbG9hZF90eXBlX21hcCBm
b3Igc3dzbXUNCg0KU2lnbmVkLW9mZi1ieTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNv
bTxtYWlsdG86a2V2aW4xLndhbmdAYW1kLmNvbT4+DQotLS0NCmRyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L25hdmkxMF9wcHQuYyB8IDIgKy0NCmRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L3ZlZ2EyMF9wcHQuYyB8IDIgKy0NCjIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvbmF2aTEwX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEw
X3BwdC5jDQppbmRleCA3NjlmOTQ1MWQ5MDQuLjM1NGY3MDk3OGY4MiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jDQpAQCAtMjA3LDcgKzIwNyw3IEBAIHN0
YXRpYyBzdHJ1Y3Qgc211XzExXzBfY21uMmFpc2NfbWFwcGluZyBuYXZpMTBfd29ya2xvYWRfbWFw
W1BQX1NNQ19QT1dFUl9QUk9GSUxFDQpXT1JLTE9BRF9NQVAoUFBfU01DX1BPV0VSX1BST0ZJTEVf
UE9XRVJTQVZJTkcsIFdPUktMT0FEX1BQTElCX1BPV0VSX1NBVklOR19CSVQpLA0KV09SS0xPQURf
TUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX1ZJREVPLCBXT1JLTE9BRF9QUExJQl9WSURFT19CSVQp
LA0KV09SS0xPQURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX1ZSLCBXT1JLTE9BRF9QUExJQl9W
Ul9CSVQpLA0KLSBXT1JLTE9BRF9NQVAoUFBfU01DX1BPV0VSX1BST0ZJTEVfQ09NUFVURSwgV09S
S0xPQURfUFBMSUJfQ1VTVE9NX0JJVCksDQorIFdPUktMT0FEX01BUChQUF9TTUNfUE9XRVJfUFJP
RklMRV9DT01QVVRFLCBXT1JLTE9BRF9QUExJQl9DT01QVVRFX0JJVCksDQpXT1JLTE9BRF9NQVAo
UFBfU01DX1BPV0VSX1BST0ZJTEVfQ1VTVE9NLCBXT1JLTE9BRF9QUExJQl9DVVNUT01fQklUKSwN
Cn07DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBf
cHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBfcHB0LmMNCmluZGV4
IDdjODkzM2Y5ODdkMS4uNWIyMTM4NmY1NThkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvdmVnYTIwX3BwdC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS92ZWdhMjBfcHB0LmMNCkBAIC0yMjEsNyArMjIxLDcgQEAgc3RhdGljIHN0cnVjdCBz
bXVfMTFfMF9jbW4yYWlzY19tYXBwaW5nIHZlZ2EyMF93b3JrbG9hZF9tYXBbUFBfU01DX1BPV0VS
X1BST0ZJTEUNCldPUktMT0FEX01BUChQUF9TTUNfUE9XRVJfUFJPRklMRV9QT1dFUlNBVklORywg
V09SS0xPQURfUFBMSUJfUE9XRVJfU0FWSU5HX0JJVCksDQpXT1JLTE9BRF9NQVAoUFBfU01DX1BP
V0VSX1BST0ZJTEVfVklERU8sIFdPUktMT0FEX1BQTElCX1ZJREVPX0JJVCksDQpXT1JLTE9BRF9N
QVAoUFBfU01DX1BPV0VSX1BST0ZJTEVfVlIsIFdPUktMT0FEX1BQTElCX1ZSX0JJVCksDQotIFdP
UktMT0FEX01BUChQUF9TTUNfUE9XRVJfUFJPRklMRV9DT01QVVRFLCBXT1JLTE9BRF9QUExJQl9D
VVNUT01fQklUKSwNCisgV09SS0xPQURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NPTVBVVEUs
IFdPUktMT0FEX1BQTElCX0NPTVBVVEVfQklUKSwNCldPUktMT0FEX01BUChQUF9TTUNfUE9XRVJf
UFJPRklMRV9DVVNUT00sIFdPUktMT0FEX1BQTElCX0NVU1RPTV9CSVQpLA0KfTsNCg0KLS0NCjIu
MTcuMQ0KDQoNCg==

--_000_ADFBF901E1474148AF0EB51D217C34A3amdcom_
Content-Type: text/html; charset="gb2312"
Content-ID: <04683E1149779340B2E6163BB217E934@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space;" class=3D"">
Reviewed-by: Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng@amd.com" class=
=3D"">kenneth.feng@amd.com</a>&gt;
<div class=3D""><br class=3D"">
</div>
<div class=3D""><br class=3D"">
<div style=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D"">=D4=DA 2019=C4=EA11=D4=C25=C8=D5=A3=AC=CF=C2=CE=E76:23=A3=
=ACWang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang@amd.com" class=3D"">=
Kevin1.Wang@amd.com</a>&gt; =D0=B4=B5=C0=A3=BA</div>
<br class=3D"Apple-interchange-newline">
<div class=3D"">
<div class=3D"">fix workload bit (WORKLOAD_PPLIB_COMPUTE_BIT) map error<br =
class=3D"">
on vega20 and navi asic.<br class=3D"">
<br class=3D"">
fix commit:<br class=3D"">
drm/amd/powerplay: add function get_workload_type_map for swsmu<br class=3D=
"">
<br class=3D"">
Signed-off-by: Kevin Wang &lt;<a href=3D"mailto:kevin1.wang@amd.com" class=
=3D"">kevin1.wang@amd.com</a>&gt;<br class=3D"">
---<br class=3D"">
drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 &#43;-<br class=3D"">
drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 2 &#43;-<br class=3D"">
2 files changed, 2 insertions(&#43;), 2 deletions(-)<br class=3D"">
<br class=3D"">
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br class=3D"">
index 769f9451d904..354f70978f82 100644<br class=3D"">
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br class=3D"">
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br class=3D"">
@@ -207,7 &#43;207,7 @@ static struct smu_11_0_cmn2aisc_mapping navi10_work=
load_map[PP_SMC_POWER_PROFILE<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_POWERSAVING,<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_POWER_SAVING_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_VIDEO,<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_VIDEO_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_VR,<span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_PPLIB_=
VR_BIT),<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span>WORKLOAD_=
MAP(PP_SMC_POWER_PROFILE_COMPUTE,<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_CUSTOM_BIT),<br class=3D"">
&#43;<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span>WORKL=
OAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_COMPUTE_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_CUSTOM,<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_CUSTOM_BIT),<br class=3D"">
};<br class=3D"">
<br class=3D"">
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br class=3D"">
index 7c8933f987d1..5b21386f558d 100644<br class=3D"">
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br class=3D"">
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br class=3D"">
@@ -221,7 &#43;221,7 @@ static struct smu_11_0_cmn2aisc_mapping vega20_work=
load_map[PP_SMC_POWER_PROFILE<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_POWERSAVING,<span class=3D"Apple-tab-span" style=3D"=
white-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_POWER_SAVING_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_VIDEO,<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_VIDEO_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_VR,<span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_PPLIB_=
VR_BIT),<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span>WORKLOAD_=
MAP(PP_SMC_POWER_PROFILE_COMPUTE,<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_CUSTOM_BIT),<br class=3D"">
&#43;<span class=3D"Apple-tab-span" style=3D"white-space:pre"> </span>WORKL=
OAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_COMPUTE_BIT),<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORKLOAD_MA=
P(PP_SMC_POWER_PROFILE_CUSTOM,<span class=3D"Apple-tab-span" style=3D"white=
-space:pre">
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>WORK=
LOAD_PPLIB_CUSTOM_BIT),<br class=3D"">
};<br class=3D"">
<br class=3D"">
-- <br class=3D"">
2.17.1<br class=3D"">
<br class=3D"">
</div>
</div>
</blockquote>
</div>
<br class=3D"">
</div>
</body>
</html>

--_000_ADFBF901E1474148AF0EB51D217C34A3amdcom_--

--===============0526005268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0526005268==--
