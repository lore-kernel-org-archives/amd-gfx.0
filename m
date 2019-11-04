Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BE4CA9ECF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 04:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (unknown [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15BA2190F
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 04:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15BA2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B836E139;
	Mon,  4 Nov 2019 04:45:33 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790073.outbound.protection.outlook.com [40.107.79.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDA46E139
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 04:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzdXoYpc1D2PNKUy1NvFJIjWOcJ286mGQjjmn8O7cwHA2mCPLcacBkUBZYgWlJx0wfOUHXu6mjsAWU0m/oQKbX3UI9djuBlXAZfAVtjtMGgxr+iNjcr2WNAOk6P+/IApAFW7+eK2rDORKnRmMWSczhrvM++sxH9yOpqwj+s636dGekoZbcXY/Z1Thi1C99nV/bP8jspn82Xugpb8TdpsW4j+/48Noc9MzEkXMVfbvprE7Y141yigwCrtm0mQeScmJia1T8Rqs7wvYuJD/Z7Hqd8lH/fShe3jvGx+9cYNhBkZYkXotyZ0CJsvAOblhnUuN3VN+xcjE2XW9HjGp1f6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F4KJPpnSVSNvmRm2bxpbsp9ln//8fygx9Fiqh6tMDs=;
 b=Ddt1AeOSi/vNCruZJVdgldBwbHgLWZrthgCmnMF91ZaP615zsNv8ujhHwC/U/rcNPsr19uBglFPwcTM4Glq/LBROWWYJcrRdyob5Xj9qe3X77GFUnC3ubYa3DHpIfFhjeS/k1trCcdZWXrlGJF7hKIn7o1LE6927jhUcYotNJblTP0ZmhklKk7cioVfeQTqAc9M1+Dy1FraOEWNkIbKKjVx+RRuqIwXrqa5auwru4qpt0KjQu3emA/BUbn+7zJzzwogi5p6vvDzQ9hbkBbjFjJbio1sWRisleRmt7Vx+OhhKOxuKh2Y6TsHNCZqi/YMm7cpYI/VZXAUG5KZyraRYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3951.namprd12.prod.outlook.com (10.255.238.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 04:45:27 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 04:45:27 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Need to free discovery memory
Thread-Topic: [PATCH v2] drm/amdgpu: Need to free discovery memory
Thread-Index: AQHVkrxsiR6+grzLsEKsG+vFZzIYjad6XfMAgAAR5FA=
Date: Mon, 4 Nov 2019 04:45:27 +0000
Message-ID:
 <MN2PR12MB29751F7D33E9D6398FEF7D508F7F0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1572836597-31265-1-git-send-email-Emily.Deng@amd.com>
 <MN2PR12MB3087E540D23C1A98B8269239897F0@MN2PR12MB3087.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3087E540D23C1A98B8269239897F0@MN2PR12MB3087.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7b3495a-1e91-4846-da70-08d760e1d033
x-ms-traffictypediagnostic: MN2PR12MB3951:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39510E7E311505DC789886C28F7F0@MN2PR12MB3951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:87;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(13464003)(66946007)(66446008)(66556008)(66476007)(76116006)(52536014)(71200400001)(86362001)(71190400001)(64756008)(6246003)(6306002)(9686003)(2906002)(6436002)(256004)(478600001)(66066001)(2501003)(55016002)(110136005)(74316002)(25786009)(186003)(7696005)(76176011)(316002)(81156014)(486006)(14454004)(99286004)(81166006)(8936002)(8676002)(33656002)(476003)(11346002)(446003)(7736002)(5660300002)(229853002)(3846002)(102836004)(6506007)(305945005)(6116002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3951;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8cglD5gcOy0XHwBwA9Hpl+9XhaKKFNg99oQjCvS2WCTzUjXj2fOdYSXH+xkuMG1DwCS1oiUusZzVahupd83XmatJXoHhENrFt+9iieELmLyh2q3Wk1wCjHY/pl1NW80U4d7IHvsJgujpGoKtmM67FbopIu/arKokLaCOswjXvAxNPy6x3FbJ6lv6U3hA22cyBFXdtON3KT/PtUeD8tU5sZ0+AXokcGFlNduiGYKn7waoL1sAkST1TkBpDro7pq+BRWeO8L5ODiDN1cb/jBT84gtHVAho7hq3t5dtdFZrWiN3uDrYHF0Z/zQM0HhSJPXqhwUKi/B/hDGsRsk1UDyebunS+tVU6DBDJeGH8PH9oshWh/TRMc6cR6+Y9ELHst3DWACwXeepHUtBGzVNPEVPySYBKerdaIATT8WqoqlwSfaKQ2wgLecY+c+187eMWPGrpKbHjIyWVyf7ccHeIZoR2mAj7qOMTNVbWA4v1Ah47TY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b3495a-1e91-4846-da70-08d760e1d033
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 04:45:27.1432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlwIlXjH9mrOj3t3aRdOx3W/wOLNKJ70g5tW8C9MgcNjnxB2bybRWnl+kQdfg7ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F4KJPpnSVSNvmRm2bxpbsp9ln//8fygx9Fiqh6tMDs=;
 b=l3/qSiURkDMSGFLC2Hi8tCJGpZE30PhY01jVNmLy2e7lwQXyGngYwuopXKg1ycK2LR4SsoxPnJegUrcp/FYR0kOYOH3P9AQPXPHKs/G/7JeiJBhRbaRLyKOVgQGt2rLMSOs1mDHgXauRIVOmMESmqfLMbJkIhMRNZmZcSToOGy8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104044527.I-Jwwx_erSfAKsPUuH_QzoHE34jnrYryRcg0tPQ-L94@z>

VGhhbmtzLCBkb25lLgoKQmVzdCB3aXNoZXMKRW1pbHkgRGVuZwoKCgo+LS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0KPkZyb206IFl1YW4sIFhpYW9qaWUgPFhpYW9qaWUuWXVhbkBhbWQuY29tPgo+
U2VudDogTW9uZGF5LCBOb3ZlbWJlciA0LCAyMDE5IDExOjQxIEFNCj5UbzogRGVuZywgRW1pbHkg
PEVtaWx5LkRlbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj5TdWJq
ZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBOZWVkIHRvIGZyZWUgZGlzY292ZXJ5IG1l
bW9yeQo+Cj5QbGVhc2UgdXNlICdkcm0vYW1kZ3B1L2Rpc2NvdmVyeTogJyBwcmVmaXggaW4gY29t
bWl0IG1lc3NhZ2UgdG8gbGV0IHVzIGVhc2lseQo+dHJhY2sgYWxsIGRpc2NvdmVyeS1yZWxlYXRl
ZCBjaGFuZ2VzLgo+T3RoZXIgdGhhbiB0aGlzLCBwYXRjaCBpcyBSZXZpZXdlZC1ieTogWGlhb2pp
ZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KPgo+QlIsCj5YaWFvamllCj4KPl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPkZyb206IGFtZC1nZnggPGFtZC1nZngt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IG9uIGJlaGFsZiBvZiBFbWlseQo+RGVuZyA8
RW1pbHkuRGVuZ0BhbWQuY29tPgo+U2VudDogTW9uZGF5LCBOb3ZlbWJlciA0LCAyMDE5IDExOjAz
IEFNCj5UbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPkNjOiBEZW5nLCBFbWlseQo+
U3ViamVjdDogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBOZWVkIHRvIGZyZWUgZGlzY292ZXJ5IG1l
bW9yeQo+Cj5XaGVuIHVubG9hZGluZyBkcml2ZXIsIG5lZWQgdG8gZnJlZSBkaXNjb3ZlcnkgbWVt
b3J5Lgo+Cj5TaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+Cj4t
LS0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCA2ICsrKy0tLQo+
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPmIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj5pbmRleCAyOGIwOWY2Li43Y2JlNmQ5
IDEwMDY0NAo+LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4r
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPkBAIC0yMTA2LDkg
KzIxMDYsNiBAQCB2b2lkIGFtZGdwdV90dG1fbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
Cj4qYWRldikKPiAgICAgICAgdm9pZCAqc3RvbGVuX3ZnYV9idWY7Cj4gICAgICAgIC8qIHJldHVy
biB0aGUgVkdBIHN0b2xlbiBtZW1vcnkgKGlmIGFueSkgYmFjayB0byBWUkFNICovCj4gICAgICAg
IGFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+c3RvbGVuX3ZnYV9tZW1vcnksIE5VTEwsCj4m
c3RvbGVuX3ZnYV9idWYpOwo+LQo+LSAgICAgICAvKiByZXR1cm4gdGhlIElQIERpc2NvdmVyeSBU
TVIgbWVtb3J5IGJhY2sgdG8gVlJBTSAqLwo+LSAgICAgICBhbWRncHVfYm9fZnJlZV9rZXJuZWwo
JmFkZXYtPmRpc2NvdmVyeV9tZW1vcnksIE5VTEwsIE5VTEwpOwo+IH0KPgo+IC8qKgo+QEAgLTIx
MjEsNyArMjExOCwxMCBAQCB2b2lkIGFtZGdwdV90dG1fZmluaShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZQo+KmFkZXYpCj4KPiAgICAgICAgYW1kZ3B1X3R0bV9kZWJ1Z2ZzX2ZpbmkoYWRldik7Cj4gICAg
ICAgIGFtZGdwdV90dG1fdHJhaW5pbmdfcmVzZXJ2ZV92cmFtX2ZpbmkoYWRldik7Cj4rICAgICAg
IC8qIHJldHVybiB0aGUgSVAgRGlzY292ZXJ5IFRNUiBtZW1vcnkgYmFjayB0byBWUkFNICovCj4r
ICAgICAgIGFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+ZGlzY292ZXJ5X21lbW9yeSwgTlVM
TCwgTlVMTCk7Cj4gICAgICAgIGFtZGdwdV90dG1fZndfcmVzZXJ2ZV92cmFtX2ZpbmkoYWRldik7
Cj4rCj4gICAgICAgIGlmIChhZGV2LT5tbWFuLmFwZXJfYmFzZV9rYWRkcikKPiAgICAgICAgICAg
ICAgICBpb3VubWFwKGFkZXYtPm1tYW4uYXBlcl9iYXNlX2thZGRyKTsKPiAgICAgICAgYWRldi0+
bW1hbi5hcGVyX2Jhc2Vfa2FkZHIgPSBOVUxMOwo+LS0KPjIuNy40Cj4KPl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj5hbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
