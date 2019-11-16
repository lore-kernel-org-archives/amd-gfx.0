Return-Path: <SRS0=bOP+=ZI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A77C432C3
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 03:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17400206DB
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 03:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17400206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D5B893D1;
	Sat, 16 Nov 2019 03:27:41 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700087.outbound.protection.outlook.com [40.107.70.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B42A893D1
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2019 03:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTPrltj12cuhv6rEmQg5ZE1DvfJ8X7ByD+EfoCYbgWtnR2fajzqwo/Cqx7ztPpT0r+5DnhF7iwg2QwI0/8WJW5YybRIIdsw9NorYANdOMpPUjcc06HSDjq7oqUCirH2nTbrBMWP3KDZpGYd4G++zSfTU7+lX4EEcduKjiVCSUuKFxLhqx/87Vfze5rxcPkI/8ef4avcUBqReT9FfACe9ffnXyokQpx6Nr6kk5Q/TLbkhMr2vrhHpTLdx857+gGkJxiHn9Up6Qq9wGl182CCMZ+iX1c9NnrPTBBTDwPydcwVVdUDFWH7tBc41AOGxis2UyKPYjhUD1EUkMi1L3V0noA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZZCIYObTT/md1CGFtJvT5Ej+RZ6qoD1z3Vbou3/+vA=;
 b=ILvqW3vc+zmSV7omJCDSEAhCOGIayiTraL55SeQ05nWUf3LnZ//Ewd4SQ6eC8kRaVmj0p7wO5q+EiKdESvRN3iJgW0IYsgMQ1zpiUoru0dB6ssUqELgCvKWb+dkvijKA/A0cDzfTEOe3MQOIEJTzs5u20I/o6RbQsOm04rlUkKnnVLTqupdqET25OC4v1WSTDYAnucd3TfJMNU6suHZaDuQ1D1SuqDGpvYcsan8C8IiIYP1YB5l9wb+84KeQ3s/obaiKzN6kTgjSZOdM//EsZ2zso9qnqt7ylHm/wShauK70OGr80WVqk9IZCYRJGrx4YLGfUpp2IoN89R5WoRP4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3520.namprd12.prod.outlook.com (20.179.82.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Sat, 16 Nov 2019 03:27:36 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2451.023; Sat, 16 Nov 2019
 03:27:36 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove experimental flag for Navi14
Thread-Topic: [PATCH] drm/amdgpu: remove experimental flag for Navi14
Thread-Index: AQHVm8Q775AlOigiek2T55GZp+JSaqeNJAsP
Date: Sat, 16 Nov 2019 03:27:35 +0000
Message-ID: <9EF5D42F-686F-4867-ADBE-29FF357F8EB9@amd.com>
References: <20191115145146.387393-1-alexander.deucher@amd.com>
In-Reply-To: <20191115145146.387393-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [222.93.227.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59512b26-399b-4a6e-ff44-08d76a44ece3
x-ms-traffictypediagnostic: MN2PR12MB3520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35206589C482D41BA23023D789730@MN2PR12MB3520.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-forefront-prvs: 02234DBFF6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(486006)(476003)(3846002)(8936002)(6306002)(76176011)(6512007)(6506007)(53546011)(6486002)(86362001)(71190400001)(6916009)(71200400001)(7736002)(2906002)(256004)(305945005)(76116006)(91956017)(66066001)(6246003)(33656002)(36756003)(26005)(186003)(102836004)(11346002)(6436002)(4326008)(446003)(2616005)(81156014)(316002)(1411001)(81166006)(5660300002)(229853002)(25786009)(66476007)(64756008)(66556008)(66946007)(54906003)(966005)(99286004)(66446008)(8676002)(478600001)(6116002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3520;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mE8fB6JEx3a7cmGB9j1RwwQUVBF/xg8zjmDqAxJu5lImi8+4Mm9qKt9jcTq2VnCH2Srj71R5mSqcYhneR0you8ipHf1Hkd3zKdBymxVWzEz8z5mYHb8LhinWV+OdEIqiOxBYH4ywD7gakHSO9SHYJk/285g8a8I/RsdPyLKz0c/RCyIjRLCipcWS4lFVFX7VcQt8KgWNFxTdhE8ItqwxpiwezieZUhtI9ze68eNTldyXq0NOIHCB3KFdx9zndavDN9QRaFCf4JCCp9z42I22DJyKVwZvknKe7JTy0wMr+D35+FhqFEBj2x8GXFZiMwQ33TVvmy5S4B2dghv8JbfrXk8aTo5czX49/d64LrQpHdhxIpMqUHy3QlnZ8JO6sKu2kYZSmo0XFGzY9OAQLRXBJ0L1aJIbHjAnGSZ9jBr9agCbvE3mOE33t+C4ZHnSU/oV
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59512b26-399b-4a6e-ff44-08d76a44ece3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2019 03:27:35.9270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oy8gX6J72B6qvjbMWgXYu+NzQQ6c+vwWB1zEUe4P7rBTdLjrg1mzjdVmJNIhtrfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3520
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZZCIYObTT/md1CGFtJvT5Ej+RZ6qoD1z3Vbou3/+vA=;
 b=jaUEDs6yJSccyyVtbszwJc8NR5lu0rqFA7jW71Aw7BDMXIg5tnK59b9t11aEK2hLGe05B+dtErvylwn3LMVO2uuZAuqumsTnYDe72KsOoFA0ZkxC0CEzOo8rgZGYXuyunL+6pIYPnJRwaPHIyBGG/QG+gwB3PzPG0FT7MjH9c4c=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191116032735.Jd4_DZmMSBv5JGK8WyLhLSF6ObzGOFvJvStIsrK0tqE@z>

UmV2aWV3ZWQtYnk6IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+CgpCUiwKWGlh
b2ppZQoKPiBPbiBOb3YgMTUsIDIwMTksIGF0IDEwOjUxIFBNLCBBbGV4IERldWNoZXIgPGFsZXhk
ZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4gCj4gNS40IGFuZCBuZXdlciB3b3JrcyBmaW5lIHdp
dGggbmF2aTE0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KPiAtLS0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMgfCA4ICsrKystLS0tCj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4g
aW5kZXggZTFjMTU3MjE2MTFhLi5iMTkxNTdiMTlmYTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4gQEAgLTEwMTMsMTAgKzEwMTMsMTAgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIHBjaWlkbGlzdFtdID0gewo+ICAgIHsweDEwMDIsIDB4
NzMxQiwgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgQ0hJUF9OQVZJMTB9LAo+ICAgIHsw
eDEwMDIsIDB4NzMxRiwgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgQ0hJUF9OQVZJMTB9
LAo+ICAgIC8qIE5hdmkxNCAqLwo+IC0gICAgezB4MTAwMiwgMHg3MzQwLCBQQ0lfQU5ZX0lELCBQ
Q0lfQU5ZX0lELCAwLCAwLCBDSElQX05BVkkxNHxBTURfRVhQX0hXX1NVUFBPUlR9LAo+IC0gICAg
ezB4MTAwMiwgMHg3MzQxLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQX05BVkkx
NHxBTURfRVhQX0hXX1NVUFBPUlR9LAo+IC0gICAgezB4MTAwMiwgMHg3MzQ3LCBQQ0lfQU5ZX0lE
LCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQX05BVkkxNHxBTURfRVhQX0hXX1NVUFBPUlR9LAo+IC0g
ICAgezB4MTAwMiwgMHg3MzRGLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQX05B
VkkxNHxBTURfRVhQX0hXX1NVUFBPUlR9LAo+ICsgICAgezB4MTAwMiwgMHg3MzQwLCBQQ0lfQU5Z
X0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQX05BVkkxNH0sCj4gKyAgICB7MHgxMDAyLCAweDcz
NDEsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIENISVBfTkFWSTE0fSwKPiArICAgIHsw
eDEwMDIsIDB4NzM0NywgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgQ0hJUF9OQVZJMTR9
LAo+ICsgICAgezB4MTAwMiwgMHg3MzRGLCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBD
SElQX05BVkkxNH0sCj4gCj4gICAgLyogUmVub2lyICovCj4gICAgezB4MTAwMiwgMHgxNjM2LCBQ
Q0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBDSElQX1JFTk9JUnxBTURfSVNfQVBVfEFNRF9F
WFBfSFdfU1VQUE9SVH0sCj4gLS0gCj4gMi4yMy4wCj4gCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
