Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB2C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07323223D1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 08:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07323223D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD49E6E0EF;
	Wed, 20 Nov 2019 08:56:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770055.outbound.protection.outlook.com [40.107.77.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677596E0EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 08:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQuO+x2q/i1fOsr23giEVj6s19BMkf8BBzSQ1e1JPa8R8T04leyOsYOFL4IKl0sSnBq9mpV3xysjDYuMp/v1+ddTMns/3K6/6fx4VkPM/Vo/joJkGIxfJMi3GSzLMnHowmKOQaT1ghTc4RwNyfOGQlv7+BHBrLGY9KYDLu6gMll7OFflXSAFLfCdZwdQSSQ0rPBRgBnsqCUIk55MvOgJ+AxwDuqmj+3LIK2Jiq9edNJcYSE73yosSaslBIVPo4vrFduyggoocnTED8gQpdbaGty26Bd3nWVWH9s6qnHJXA9zMM915Pk8bfe9VC3/8jlLiDgVr9hzkgdo3rZjHAv1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+koQs6b9vKc5xWIOH5PdH2ZR7c1JGXzvB1m8DSdUavo=;
 b=ULSjsaoshq68wO/pZpsgW0tHrZKg5ebKCLlLZ4Pzjnz+n5SLxzqUeAHnGIloVd+LOUh6vjkL3O8MTrW34PQBIFqHX8G3hJVDpCLiWIWarpuoDW/Ke2ILxQLHXQyOdctsxyn40ZWfDH+7xVzO3US7PzQ9JEyKzVVquUVV3AIFU669+mfVEAU8bXgtC7ZbHOTdzeZkhw6QQuGWBNQUAXZVXqJkCc13P5NB8LP5OsLpzZ8HiI9eNK/64wtBOR5z5/j4wPvMUur7P0a1CbsgPsDXjvP8mBvRelvov2ufJKPoeu9V7UeOkpTsJRPaYmmkYDi8OR5Ql18UUW5bGFdk0gFsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3168.namprd12.prod.outlook.com (20.179.81.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 08:56:14 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 08:56:14 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
Thread-Topic: [PATCH] drm/amdgpu/gfx10: re-init clear state buffer after gpu
 reset
Thread-Index: AQHVn25fE9TEqOaSwUiGv9difRZnwqeTvliAgAAAFAw=
Date: Wed, 20 Nov 2019 08:56:14 +0000
Message-ID:
 <MN2PR12MB308747C45983374E17E1BD17894F0@MN2PR12MB3087.namprd12.prod.outlook.com>
References: <20191120064701.2765-1-xiaojie.yuan@amd.com>,
 <DM5PR12MB1418A32EB8199ABFFCCAEC04FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418A32EB8199ABFFCCAEC04FC4F0@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74786bcf-3127-49bf-0e3a-08d76d977f96
x-ms-traffictypediagnostic: MN2PR12MB3168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB316803AB06EA46619FE89A24894F0@MN2PR12MB3168.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(13464003)(199004)(189003)(71200400001)(76176011)(71190400001)(14444005)(7696005)(6506007)(52536014)(256004)(5660300002)(6436002)(6246003)(186003)(446003)(4326008)(26005)(9686003)(55016002)(91956017)(76116006)(305945005)(7736002)(53546011)(66946007)(74316002)(66476007)(66556008)(64756008)(66446008)(476003)(102836004)(11346002)(229853002)(486006)(33656002)(25786009)(478600001)(14454004)(86362001)(2906002)(2501003)(3846002)(6116002)(66066001)(99286004)(8676002)(81156014)(81166006)(316002)(8936002)(110136005)(54906003)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3168;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uNAVpKrXLjbmluhuMT6N3ET62/OC1Cx/qwlRFIyq/n4C/M/K3nq/0KHK6F+A7or9zLH/ATzUF8U2ioAQh3aDbR1dpg0os/1wx+Xuvp2NSXCNhEpiSnTvXu+GG4YvddZFwUbokFB1guyi3B1lbFOwz76IzIrlGQp+fKdQg0UgSunUGN3NPeuoUwnLER2mxI4zcJHD6VCdM0ToktYy3GNFZx8rdB/1D1DWkmsO+u89Hs/IQR8Yx8yKSM/7cDxyAdsDthseSL1sH2x9h9JB4kemSi54MTvLCKVuLYtbqEJOdXrXdjn2OqnqmFnAgccO+9bLvaZOpDBqSkUtT47N4HpZ7DDxUV/qBINXydLmMYvlr7QV8ftGGEesKKxLfojnuuBXNE9yL3ZBEvIP9m2gIIFh9VSLDCylaEKoD3rC4/233uX/IUSm1KavHal707UsEZau
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74786bcf-3127-49bf-0e3a-08d76d977f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 08:56:14.2365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtjelFMRvQ/2u5mV2Xqt5z+q0ghycWiKwi+r6R2BtHoRNqvlFRfcfgnVzEXHCrfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3168
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+koQs6b9vKc5xWIOH5PdH2ZR7c1JGXzvB1m8DSdUavo=;
 b=rrmHizKgMTKRixBlDX4XG2ls+Zlo0pM2ZAtjhrZD/t25NYvNZSbWkAk5mP6mnCQUTws9vlSE5pPi/2PFNu9qKAwFA2w+79BwsNS+IsWkyJsBLu4PXlzB+D6QYduBDGePcfAZH6YZOz0C46GeAyPC0ttoBxlCnSMQSuZ8F+QZsnA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120085614.icATNdgTkF3Rk5EfGaKdXrW3JshoVaawkGiXMzURQk4@z>

SGkgSGF3a2luZywKClRoaXMgaXMgYSBmb3JtYWwgZml4IEkgdGhpbmsuCkFzIHlvdSBzdWdnZXN0
ZWQsIEkgdHJpZWQgdG8gZHVtcCBjc2IgaW4gdmFyaW91cyBsb2NhdGlvbnMgaW4gZ3B1IHJlc2V0
IHNlcXVlbmNlOgoxLiBhZnRlciBnZnhfdjEwXzBfaHdfZmluaSgpIGNvbXBsZXRlcyAtIGNzYiBz
dGlsbCBjb250YWlucyBjb3JyZWN0IGRhdGEKICAgIHwKICAgIHYKICAgYmFjbyByZXNldAogICAg
fAogICAgdgoyLiByaWdodCBhZnRlciBnbWMgcmVzdW1lIC0gY3NiIGNvbnRhaW5zIGNvcnJ1cHRl
ZCBkYXRhCgpJbiB0aGlzIHNtYWxsIHRpbWUgd2luZG93LCBubyBmaXJtd2FyZSB0b3VjaGVzIGNz
YiBhbmQgaXQgc2hvdWxkIHByb3ZlIHRoYXQgdnJhbSBsb3N0IGNhdXNlcyBjc2IgY29ycnVwdC4K
CkJSLApYaWFvamllCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZy
b206IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClNlbnQ6IFdlZG5lc2Rh
eSwgTm92ZW1iZXIgMjAsIDIwMTkgNDo0MyBQTQpUbzogWXVhbiwgWGlhb2ppZTsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IFhpYW8sIEphY2s7IExvbmcsIEdhbmcKU3ViamVjdDog
UkU6IFtQQVRDSF0gZHJtL2FtZGdwdS9nZngxMDogcmUtaW5pdCBjbGVhciBzdGF0ZSBidWZmZXIg
YWZ0ZXIgZ3B1IHJlc2V0CgpKdXN0IG1ha2Ugc3VyZSBJIHVuZGVyc3RhbmQgeW91IGNvcnJlY3Rs
eS4gU28gdW50aWwgZncgdGVhbSByb290IGNhdXNlIHRoZSByZWFzb24gb2YgY3NiIGNvcnJ1cHRp
b24sIHdlIGtlZXAgdGhlIHdvcmthcm91bmQgaW4gZHJpdmVyLCBjb3JyZWN0PwoKUmVnYXJkcywK
SGF3a2luZwotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQpGcm9tOiBZdWFuLCBYaWFvamllIDxY
aWFvamllLll1YW5AYW1kLmNvbT4KU2VudDogMjAxOeW5tDEx5pyIMjDml6UgMTQ6NDcKVG86IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPjsgWGlhbywgSmFjayA8SmFjay5YaWFvQGFtZC5jb20+OyBMb25nLCBHYW5n
IDxHYW5nLkxvbmdAYW1kLmNvbT47IFl1YW4sIFhpYW9qaWUgPFhpYW9qaWUuWXVhbkBhbWQuY29t
PgpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHUvZ2Z4MTA6IHJlLWluaXQgY2xlYXIgc3RhdGUg
YnVmZmVyIGFmdGVyIGdwdSByZXNldAoKVGhpcyBwYXRjaCBmaXhlcyAybmQgYmFjbyByZXNldCBm
YWlsdXJlIHdpdGggZ2Z4b2ZmIGVuYWJsZWQgb24gbmF2aTF4LgoKY2xlYXIgc3RhdGUgYnVmZmVy
IChyZXNpZGVzIGluIHZyYW0pIGlzIGNvcnJ1cHRlZCBhZnRlciAxc3QgYmFjbyByZXNldCwgdXBv
biBnZnhvZmYgZXhpdCwgQ1BGIGdldHMgZ2FyYmFnZSBoZWFkZXIgaW4gQ1NJQiBhbmQgaGFuZ3Mu
CgpTaWduZWQtb2ZmLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgNDMgKysrKysrKysrKysr
KysrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggOTI3NGJk
NGI2YzY4Li44ZTI0ZWEwOGNhMzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBf
MC5jCkBAIC0xNzg5LDI3ICsxNzg5LDUyIEBAIHN0YXRpYyB2b2lkIGdmeF92MTBfMF9lbmFibGVf
Z3VpX2lkbGVfaW50ZXJydXB0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogICAgICAgIFdS
RUczMl9TT0MxNShHQywgMCwgbW1DUF9JTlRfQ05UTF9SSU5HMCwgdG1wKTsgIH0KCi1zdGF0aWMg
dm9pZCBnZnhfdjEwXzBfaW5pdF9jc2Ioc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCitzdGF0
aWMgaW50IGdmeF92MTBfMF9pbml0X2NzYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsK
KyAgICAgICBpbnQgcjsKKworICAgICAgIGlmIChhZGV2LT5pbl9ncHVfcmVzZXQpIHsKKyAgICAg
ICAgICAgICAgIHIgPSBhbWRncHVfYm9fcmVzZXJ2ZShhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRl
X29iaiwgZmFsc2UpOworICAgICAgICAgICAgICAgaWYgKHIpCisgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiByOworCisgICAgICAgICAgICAgICByID0gYW1kZ3B1X2JvX2ttYXAoYWRldi0+
Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmosCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKHZvaWQgKiopJmFkZXYtPmdmeC5ybGMuY3NfcHRyKTsKKyAgICAgICAgICAgICAgIGlmICgh
cikgeworICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5nZngucmxjLmZ1bmNzLT5nZXRfY3Ni
X2J1ZmZlcihhZGV2LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRl
di0+Z2Z4LnJsYy5jc19wdHIpOworICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfYm9fa3Vu
bWFwKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsKKyAgICAgICAgICAgICAgIH0KKwor
ICAgICAgICAgICAgICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShhZGV2LT5nZngucmxjLmNsZWFyX3N0
YXRlX29iaik7CisgICAgICAgICAgICAgICBpZiAocikKKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIHI7CisgICAgICAgfQorCiAgICAgICAgLyogY3NpYiAqLwogICAgICAgIFdSRUczMl9T
T0MxNShHQywgMCwgbW1STENfQ1NJQl9BRERSX0hJLAogICAgICAgICAgICAgICAgICAgICBhZGV2
LT5nZngucmxjLmNsZWFyX3N0YXRlX2dwdV9hZGRyID4+IDMyKTsKICAgICAgICBXUkVHMzJfU09D
MTUoR0MsIDAsIG1tUkxDX0NTSUJfQUREUl9MTywKICAgICAgICAgICAgICAgICAgICAgYWRldi0+
Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9ncHVfYWRkciAmIDB4ZmZmZmZmZmMpOwogICAgICAgIFdSRUcz
Ml9TT0MxNShHQywgMCwgbW1STENfQ1NJQl9MRU5HVEgsIGFkZXYtPmdmeC5ybGMuY2xlYXJfc3Rh
dGVfc2l6ZSk7CisKKyAgICAgICByZXR1cm4gMDsKIH0KCi1zdGF0aWMgdm9pZCBnZnhfdjEwXzBf
aW5pdF9wZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK3N0YXRpYyBpbnQgZ2Z4X3YxMF8w
X2luaXRfcGcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAgICAgICAgaW50IGk7Cisg
ICAgICAgaW50IHI7CgotICAgICAgIGdmeF92MTBfMF9pbml0X2NzYihhZGV2KTsKKyAgICAgICBy
ID0gZ2Z4X3YxMF8wX2luaXRfY3NiKGFkZXYpOworICAgICAgIGlmIChyKQorICAgICAgICAgICAg
ICAgcmV0dXJuIHI7CgogICAgICAgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1fdm1odWJzOyBp
KyspCiAgICAgICAgICAgICAgICBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGIoYWRldiwgMCwgaSwg
MCk7CgogICAgICAgIC8qIFRPRE86IGluaXQgcG93ZXIgZ2F0aW5nICovCi0gICAgICAgcmV0dXJu
OworICAgICAgIHJldHVybiAwOwogfQoKIHZvaWQgZ2Z4X3YxMF8wX3JsY19zdG9wKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KSBAQCAtMTkxMSw3ICsxOTM2LDEwIEBAIHN0YXRpYyBpbnQgZ2Z4
X3YxMF8wX3JsY19yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAgICAgICAgICAg
ICAgICByID0gZ2Z4X3YxMF8wX3dhaXRfZm9yX3JsY19hdXRvbG9hZF9jb21wbGV0ZShhZGV2KTsK
ICAgICAgICAgICAgICAgIGlmIChyKQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcjsK
LSAgICAgICAgICAgICAgIGdmeF92MTBfMF9pbml0X3BnKGFkZXYpOworCisgICAgICAgICAgICAg
ICByID0gZ2Z4X3YxMF8wX2luaXRfcGcoYWRldik7CisgICAgICAgICAgICAgICBpZiAocikKKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7CgogICAgICAgICAgICAgICAgLyogZW5hYmxl
IFJMQyBTUk0gKi8KICAgICAgICAgICAgICAgIGdmeF92MTBfMF9ybGNfZW5hYmxlX3NybShhZGV2
KTsKQEAgLTE5MzcsNyArMTk2NSwxMCBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9ybGNfcmVzdW1l
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiByOwogICAgICAgICAgICAgICAgfQoKLSAgICAgICAgICAgICAgIGdmeF92MTBf
MF9pbml0X3BnKGFkZXYpOworICAgICAgICAgICAgICAgciA9IGdmeF92MTBfMF9pbml0X3BnKGFk
ZXYpOworICAgICAgICAgICAgICAgaWYgKHIpCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biByOworCiAgICAgICAgICAgICAgICBhZGV2LT5nZngucmxjLmZ1bmNzLT5zdGFydChhZGV2KTsK
CiAgICAgICAgICAgICAgICBpZiAoYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID09IEFNREdQVV9G
V19MT0FEX1JMQ19CQUNLRE9PUl9BVVRPKSB7Ci0tCjIuMjAuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
