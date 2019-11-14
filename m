Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEF9C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 21:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF7420718
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 21:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF7420718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32E96E41A;
	Thu, 14 Nov 2019 21:20:14 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13F06E41A
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 21:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3aG0KNQ+jngVOajUougBvn25VfDatu1HdJJ9e5fMyN9qAkQueyi/NeZsnMedIhlCzk1YCap5M1Zy3E1/z8U6f0MFU7K40w1iMA9KE8OakDHPzf15PN0vw8fibzeIB07QyoJo3g1mfHGlPbvghecQ/90VZeIhAcF/VCPQAyDascYTFMkxiLB3tEfZ2d8ruR/hRocTWvdzspVcrfTRNirNpWOFsFeAZZFmvSRP/oPCWbQdWH7BGAaeHbqYivf8bYzb5mWpecGHq6ttqzcfFj1ix1IW+YW5QPfr8iQrj3VX8nJ4+ytrZTedh0LG2FrH5sytgalPRqg6dmsNyGICVBAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD/SMcBdfKUZYAj2ufLUBpdmNdz8cm0z92ySdtaDcJY=;
 b=AbMBQI76cUUwvWX3tfEdagdgjWMK4K68Tb3yeobsj98q75BgUmo0Vm44kAC3/6RJI3aUHBarsQ1ToGy28taAlCLcT4N4K+HIPfqPU33nzI1d4/NoIS34Ol6XehQti0/3FtAGKYMnlJaWIWho1lg2U58WfEETlyfFpHOtgGTjwNzc+Zd2dkc/ks4Epepc9H4ZGvBYSu1Qx1B/Q1UA/oOgVxu64n8Jrgcjovvo8qgzeXeT215VOrz+nhDZpSqh6wFFbt6EtoroI8y8ISxp0GovB/GgAx6Y4v/1mBICloXCAFzyQ+YDwsU5IXNxFPX+m25apopJSecasvboRhTP1YjSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2405.namprd12.prod.outlook.com (52.132.140.20) by
 DM5PR12MB1227.namprd12.prod.outlook.com (10.168.238.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 21:20:11 +0000
Received: from DM5PR12MB2405.namprd12.prod.outlook.com
 ([fe80::30bf:4864:7a7e:cfc1]) by DM5PR12MB2405.namprd12.prod.outlook.com
 ([fe80::30bf:4864:7a7e:cfc1%7]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 21:20:11 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: "Lipski, Mikita" <Mikita.Lipski@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/dsc: Update drm_dsc to reflect native 4.2.0 DSC
 spec
Thread-Topic: [PATCH 1/2] drm/dsc: Update drm_dsc to reflect native 4.2.0 DSC
 spec
Thread-Index: AQHVmlWcu0IaQ6q+UEO0JeMrg9hUHKeLLd4Q
Date: Thu, 14 Nov 2019 21:20:10 +0000
Message-ID:
 <DM5PR12MB24056BFBB3155C7E2AECF7BEEE710@DM5PR12MB2405.namprd12.prod.outlook.com>
References: <20191113190728.26645-1-mikita.lipski@amd.com>
In-Reply-To: <20191113190728.26645-1-mikita.lipski@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a81cf56e-353f-4230-2e49-08d769486e97
x-ms-traffictypediagnostic: DM5PR12MB1227:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB12278AD30D4669536B8BF20EEE710@DM5PR12MB1227.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(13464003)(199004)(189003)(99286004)(110136005)(316002)(53546011)(6246003)(52536014)(6506007)(6436002)(54906003)(25786009)(33656002)(229853002)(2501003)(66446008)(64756008)(6116002)(4326008)(3846002)(102836004)(71190400001)(66556008)(66476007)(256004)(186003)(14444005)(55016002)(26005)(7696005)(71200400001)(76116006)(15650500001)(76176011)(11346002)(446003)(8936002)(476003)(486006)(9686003)(478600001)(5660300002)(81156014)(8676002)(81166006)(14454004)(66066001)(66946007)(86362001)(2906002)(305945005)(7736002)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1227;
 H:DM5PR12MB2405.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xpOuiQXMJuNIfioudPWLOM3+A3+uN3oJWpqnyBLBKah4XAEwR1dzAWZawk6HcBachCX+5EusVL0QpVuXmQZdVfngYgeaM/sAM8EHPF3w8CPyD3cidbioRglv7cAXmL6LvC5qddPnb4DSXwAcD3RvwKK9KMAyGw7rZ31uMo/zBa/XT7dvLMuUwQBs7j6dY/EvVhpoOFDq7/8tkUgqkGxflURKrq2Ir1BDiFuZ4XnG3E5dH4eMWrfnFWHXS9eLKYYK6sIC9m7/8y0wPuZ6VOZ/SUh7sLw5ncSoxiCF0m04zyJYyyPkpjXc97G5p61E/QX1/9cGROBbDeB/W4FfrDMFTnTSjdzXs0ueu+KP8CQJRozDSORRQFfBwiFbRbhhsjX+7+5dsjudcmMVX4oNNMXmx+WOW3g1uvZQ4AQQ9K5p9I2rc1WC8ZvGLPLgIh150LO
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81cf56e-353f-4230-2e49-08d769486e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 21:20:10.9088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+wuUhEfVl6MJIAyHHNsOwErmLaO73UazXiDBKHcvRT3Diio2IOQ2CWBNSNTXgjw7Ic3eO4pOXO9xKlzcgWpPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1227
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD/SMcBdfKUZYAj2ufLUBpdmNdz8cm0z92ySdtaDcJY=;
 b=tZaH0fLDpQLKDWc3o1kk8A9Db++V7BF+hDlwNdKaIJr4rj21NcLJnQP+Py2OucJ8v/Ndy6WLJ48y4iCnf+SEOq0hqfxpydW4kryJs+51O3ZfpB9NwetRMp9bBKC7oSo3yhnpQCVi+nNO8NvNhCv8geuYkdiDG4p40/CsIyyV/kI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nikola.Cornij@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "manasi.d.navare@intel.com" <manasi.d.navare@intel.com>,
 David Francis <David.Francis@amd.com>, "Lipski,
 Mikita" <Mikita.Lipski@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114212010.5ohRIOjQ8GIkzCfUZCZNb9vvkjiS-ggzOZEV4G-mYVk@z>

VGhpcyBsb29rcyBnb29kLCB0b28uCgotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQpGcm9tOiBt
aWtpdGEubGlwc2tpQGFtZC5jb20gPG1pa2l0YS5saXBza2lAYW1kLmNvbT4gClNlbnQ6IE5vdmVt
YmVyIDEzLCAyMDE5IDI6MDcgUE0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNj
OiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBDb3JuaWosIE5pa29sYSA8Tmlrb2xh
LkNvcm5pakBhbWQuY29tPjsgbWFuYXNpLmQubmF2YXJlQGludGVsLmNvbTsgTGlwc2tpLCBNaWtp
dGEgPE1pa2l0YS5MaXBza2lAYW1kLmNvbT47IERhdmlkIEZyYW5jaXMgPERhdmlkLkZyYW5jaXNA
YW1kLmNvbT4KU3ViamVjdDogW1BBVENIIDEvMl0gZHJtL2RzYzogVXBkYXRlIGRybV9kc2MgdG8g
cmVmbGVjdCBuYXRpdmUgNC4yLjAgRFNDIHNwZWMKCkZyb206IE1pa2l0YSBMaXBza2kgPG1pa2l0
YS5saXBza2lAYW1kLmNvbT4KCltXaHldClNvbWUgcGFydHMgb2YgdGhlIERTQyBzcGVjIHJlbGF0
aW5nIHRvIDQuMi4wIHdlcmUgbm90IHJlZmxlY3RlZCBpbiBkcm1fZHNjX2NvbXB1dGVfcmNfcGFy
YW1ldGVycywgY2F1c2luZyB1bmV4cGVjdGVkIGNvbmZpZyBmYWlsdXJlcwoKW0hvd10KQWRkIG5z
bF9icGdfb2Zmc2V0IGFuZCByYnNfbWluIGNvbXB1dGF0aW9uCgpTaWduZWQtb2ZmLWJ5OiBEYXZp
ZCBGcmFuY2lzIDxEYXZpZC5GcmFuY2lzQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IE1pa2l0YSBM
aXBza2kgPG1pa2l0YS5saXBza2lAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vZHJtX2Rz
Yy5jIHwgNzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vZHJtX2RzYy5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9kc2MuYyBpbmRl
eCA3N2Y0ZTVhZTQxOTcuLjc5YzcxZTNmYzk3MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2RybV9kc2MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RzYy5jCkBAIC0yNDUsNiArMjQ1
LDM4IEBAIHZvaWQgZHJtX2RzY19wcHNfcGF5bG9hZF9wYWNrKHN0cnVjdCBkcm1fZHNjX3BpY3R1
cmVfcGFyYW1ldGVyX3NldCAqcHBzX3BheWxvYWQsICB9ICBFWFBPUlRfU1lNQk9MKGRybV9kc2Nf
cHBzX3BheWxvYWRfcGFjayk7CiAKK3N0YXRpYyBpbnQgY29tcHV0ZV9vZmZzZXQoc3RydWN0IGRy
bV9kc2NfY29uZmlnICp2ZHNjX2NmZywgaW50IHBpeGVsc19wZXJfZ3JvdXAsCisJCQkJaW50IGdy
b3Vwc19wZXJfbGluZSwgaW50IGdycGNudCkKK3sKKwlpbnQgb2Zmc2V0ID0gMDsKKwlpbnQgZ3Jw
Y250X2lkID0gRElWX1JPVU5EX1VQKHZkc2NfY2ZnLT5pbml0aWFsX3htaXRfZGVsYXksIAorcGl4
ZWxzX3Blcl9ncm91cCk7CisKKwlpZiAoZ3JwY250IDw9IGdycGNudF9pZCkKKwkJb2Zmc2V0ID0g
RElWX1JPVU5EX1VQKGdycGNudCAqIHBpeGVsc19wZXJfZ3JvdXAgKiB2ZHNjX2NmZy0+Yml0c19w
ZXJfcGl4ZWwsIDE2KTsKKwllbHNlCisJCW9mZnNldCA9IERJVl9ST1VORF9VUChncnBjbnRfaWQg
KiBwaXhlbHNfcGVyX2dyb3VwICogdmRzY19jZmctPmJpdHNfcGVyX3BpeGVsLCAxNikKKwkJCS0g
KCgoZ3JwY250IC0gZ3JwY250X2lkKSAqIHZkc2NfY2ZnLT5zbGljZV9icGdfb2Zmc2V0KSA+PiAx
MSk7CisKKwlpZiAoZ3JwY250IDw9IGdyb3Vwc19wZXJfbGluZSkKKwkJb2Zmc2V0ICs9IGdycGNu
dCAqIHZkc2NfY2ZnLT5maXJzdF9saW5lX2JwZ19vZmZzZXQ7CisJZWxzZQorCQlvZmZzZXQgKz0g
Z3JvdXBzX3Blcl9saW5lICogdmRzY19jZmctPmZpcnN0X2xpbmVfYnBnX29mZnNldAorCQkJLSAo
KChncnBjbnQgLSBncm91cHNfcGVyX2xpbmUpICogdmRzY19jZmctPm5mbF9icGdfb2Zmc2V0KSA+
PiAxMSk7CisKKwlpZiAodmRzY19jZmctPm5hdGl2ZV80MjApIHsKKwkJaWYgKGdycGNudCA8PSBn
cm91cHNfcGVyX2xpbmUpCisJCQlvZmZzZXQgLT0gKGdycGNudCAqIHZkc2NfY2ZnLT5uc2xfYnBn
X29mZnNldCkgPj4gMTE7CisJCWVsc2UgaWYgKGdycGNudCA8PSAyICogZ3JvdXBzX3Blcl9saW5l
KQorCQkJb2Zmc2V0ICs9IChncnBjbnQgLSBncm91cHNfcGVyX2xpbmUpICogdmRzY19jZmctPnNl
Y29uZF9saW5lX2JwZ19vZmZzZXQKKwkJCQktICgoZ3JvdXBzX3Blcl9saW5lICogdmRzY19jZmct
Pm5zbF9icGdfb2Zmc2V0KSA+PiAxMSk7CisJCWVsc2UKKwkJCW9mZnNldCArPSAoZ3JwY250IC0g
Z3JvdXBzX3Blcl9saW5lKSAqIHZkc2NfY2ZnLT5zZWNvbmRfbGluZV9icGdfb2Zmc2V0CisJCQkJ
LSAoKChncnBjbnQgLSBncm91cHNfcGVyX2xpbmUpICogdmRzY19jZmctPm5zbF9icGdfb2Zmc2V0
KSA+PiAxMSk7CisJfQorCisJcmV0dXJuIG9mZnNldDsKK30KKwogLyoqCiAgKiBkcm1fZHNjX2Nv
bXB1dGVfcmNfcGFyYW1ldGVycygpIC0gV3JpdGUgcmF0ZSBjb250cm9sCiAgKiBwYXJhbWV0ZXJz
IHRvIHRoZSBkc2MgY29uZmlndXJhdGlvbiBkZWZpbmVkIGluIEBAIC0yNjQsNiArMjk2LDcgQEAg
aW50IGRybV9kc2NfY29tcHV0ZV9yY19wYXJhbWV0ZXJzKHN0cnVjdCBkcm1fZHNjX2NvbmZpZyAq
dmRzY19jZmcpCiAJdW5zaWduZWQgbG9uZyBocmRfZGVsYXkgPSAwOwogCXVuc2lnbmVkIGxvbmcg
ZmluYWxfc2NhbGUgPSAwOwogCXVuc2lnbmVkIGxvbmcgcmJzX21pbiA9IDA7CisJdW5zaWduZWQg
bG9uZyBtYXhfb2Zmc2V0ID0gMDsKIAogCWlmICh2ZHNjX2NmZy0+bmF0aXZlXzQyMCB8fCB2ZHNj
X2NmZy0+bmF0aXZlXzQyMikgewogCQkvKiBOdW1iZXIgb2YgZ3JvdXBzIHVzZWQgdG8gY29kZSBl
YWNoIGxpbmUgb2YgYSBzbGljZSAqLyBAQCAtMzQyLDYgKzM3NSwxNyBAQCBpbnQgZHJtX2RzY19j
b21wdXRlX3JjX3BhcmFtZXRlcnMoc3RydWN0IGRybV9kc2NfY29uZmlnICp2ZHNjX2NmZykKIAkJ
cmV0dXJuIC1FUkFOR0U7CiAJfQogCisJaWYgKHZkc2NfY2ZnLT5zbGljZV9oZWlnaHQgPiAyKQor
CQl2ZHNjX2NmZy0+bnNsX2JwZ19vZmZzZXQgPSBESVZfUk9VTkRfVVAoKHZkc2NfY2ZnLT5zZWNv
bmRfbGluZV9icGdfb2Zmc2V0IDw8IDExKSwKKwkJCQkJCQkodmRzY19jZmctPnNsaWNlX2hlaWdo
dCAtIDEpKTsKKwllbHNlCisJCXZkc2NfY2ZnLT5uc2xfYnBnX29mZnNldCA9IDA7CisKKwlpZiAo
dmRzY19jZmctPm5zbF9icGdfb2Zmc2V0ID4gNjU1MzUpIHsKKwkJRFJNX0RFQlVHX0tNUygiTnNs
QnBnT2Zmc2V0IGlzIHRvbyBsYXJnZSBmb3IgdGhpcyBzbGljZSBoZWlnaHRcbiIpOworCQlyZXR1
cm4gLUVSQU5HRTsKKwl9CisKIAkvKiBOdW1iZXIgb2YgZ3JvdXBzIHVzZWQgdG8gY29kZSB0aGUg
ZW50aXJlIHNsaWNlICovCiAJZ3JvdXBzX3RvdGFsID0gZ3JvdXBzX3Blcl9saW5lICogdmRzY19j
ZmctPnNsaWNlX2hlaWdodDsKIApAQCAtMzYxLDYgKzQwNSw3IEBAIGludCBkcm1fZHNjX2NvbXB1
dGVfcmNfcGFyYW1ldGVycyhzdHJ1Y3QgZHJtX2RzY19jb25maWcgKnZkc2NfY2ZnKQogCQl2ZHNj
X2NmZy0+c2NhbGVfaW5jcmVtZW50X2ludGVydmFsID0KIAkJCQkodmRzY19jZmctPmZpbmFsX29m
ZnNldCAqICgxIDw8IDExKSkgLwogCQkJCSgodmRzY19jZmctPm5mbF9icGdfb2Zmc2V0ICsKKwkJ
CQl2ZHNjX2NmZy0+bnNsX2JwZ19vZmZzZXQgKwogCQkJCXZkc2NfY2ZnLT5zbGljZV9icGdfb2Zm
c2V0KSAqCiAJCQkJKGZpbmFsX3NjYWxlIC0gOSkpOwogCX0gZWxzZSB7CkBAIC0zODEsMTAgKzQy
NiwyOSBAQCBpbnQgZHJtX2RzY19jb21wdXRlX3JjX3BhcmFtZXRlcnMoc3RydWN0IGRybV9kc2Nf
Y29uZmlnICp2ZHNjX2NmZykKIAkgKiBiaXRzL3BpeGVsIChicHApIHJhdGUgdGhhdCBpcyB1c2Vk
IGJ5IHRoZSBlbmNvZGVyLAogCSAqIGluIHN0ZXBzIG9mIDEvMTYgb2YgYSBiaXQgcGVyIHBpeGVs
CiAJICovCi0JcmJzX21pbiA9IHZkc2NfY2ZnLT5yY19tb2RlbF9zaXplIC0gdmRzY19jZmctPmlu
aXRpYWxfb2Zmc2V0ICsKLQkJRElWX1JPVU5EX1VQKHZkc2NfY2ZnLT5pbml0aWFsX3htaXRfZGVs
YXkgKgotCQkJICAgICB2ZHNjX2NmZy0+Yml0c19wZXJfcGl4ZWwsIDE2KSArCi0JCWdyb3Vwc19w
ZXJfbGluZSAqIHZkc2NfY2ZnLT5maXJzdF9saW5lX2JwZ19vZmZzZXQ7CisJaWYgKHZkc2NfY2Zn
LT5kc2NfdmVyc2lvbl9taW5vciA9PSAyICYmICh2ZHNjX2NmZy0+bmF0aXZlXzQyMCB8fCAKK3Zk
c2NfY2ZnLT5uYXRpdmVfNDIyKSkgeworCisJCW1heF9vZmZzZXQgPSBjb21wdXRlX29mZnNldCh2
ZHNjX2NmZywgRFNDX1JDX1BJWEVMU19QRVJfR1JPVVAsIGdyb3Vwc19wZXJfbGluZSwKKwkJCQkJ
RElWX1JPVU5EX1VQKHZkc2NfY2ZnLT5pbml0aWFsX3htaXRfZGVsYXksCisJCQkJCQlEU0NfUkNf
UElYRUxTX1BFUl9HUk9VUCkpOworCisJCW1heF9vZmZzZXQgPSBtYXgobWF4X29mZnNldCwKKwkJ
CQljb21wdXRlX29mZnNldCh2ZHNjX2NmZywgRFNDX1JDX1BJWEVMU19QRVJfR1JPVVAsIGdyb3Vw
c19wZXJfbGluZSwKKwkJCQkJRElWX1JPVU5EX1VQKHZkc2NfY2ZnLT5pbml0aWFsX3htaXRfZGVs
YXksCisJCQkJCQlncm91cHNfcGVyX2xpbmUpKSk7CisKKwkJbWF4X29mZnNldCA9IG1heChtYXhf
b2Zmc2V0LAorCQkJCWNvbXB1dGVfb2Zmc2V0KHZkc2NfY2ZnLCBEU0NfUkNfUElYRUxTX1BFUl9H
Uk9VUCwgZ3JvdXBzX3Blcl9saW5lLAorCQkJCQlESVZfUk9VTkRfVVAodmRzY19jZmctPmluaXRp
YWxfeG1pdF9kZWxheSwKKwkJCQkJCWdyb3Vwc19wZXJfbGluZSAqIDIpKSk7CisKKwkJcmJzX21p
biA9IHZkc2NfY2ZnLT5yY19tb2RlbF9zaXplIC0gdmRzY19jZmctPmluaXRpYWxfb2Zmc2V0ICsg
bWF4X29mZnNldDsKKwl9IGVsc2UgeworCQlyYnNfbWluID0gdmRzY19jZmctPnJjX21vZGVsX3Np
emUgLSB2ZHNjX2NmZy0+aW5pdGlhbF9vZmZzZXQgKworCQkJRElWX1JPVU5EX1VQKHZkc2NfY2Zn
LT5pbml0aWFsX3htaXRfZGVsYXkgKgorCQkJCSAgICAgdmRzY19jZmctPmJpdHNfcGVyX3BpeGVs
LCAxNikgKworCQkJZ3JvdXBzX3Blcl9saW5lICogdmRzY19jZmctPmZpcnN0X2xpbmVfYnBnX29m
ZnNldDsKKwl9CiAKIAlocmRfZGVsYXkgPSBESVZfUk9VTkRfVVAoKHJic19taW4gKiAxNiksIHZk
c2NfY2ZnLT5iaXRzX3Blcl9waXhlbCk7CiAJdmRzY19jZmctPnJjX2JpdHMgPSAoaHJkX2RlbGF5
ICogdmRzY19jZmctPmJpdHNfcGVyX3BpeGVsKSAvIDE2OwotLQoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
