Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E46FCA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 10:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5769220874
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 10:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5769220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124B76E926;
	Wed, 30 Oct 2019 10:22:20 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800080.outbound.protection.outlook.com [40.107.80.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4403E6E926
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 10:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMyc4hXfl04skIFzWBwjIHX86IaiNnvDTKjBOtm9kB7Sb92TPJnofumZmpdJVolJti8rIgd4CDECyu79QTRGfcEOL5YroW2K5d0p5iABcOid8COU9hBNPEK6Mp9Ykv59lU9TMDuOweBjyARTMrv9f3PoMlaZb885lK/SP51vl0NNxGeeFiFuGvqqUfSRlm69BCPdSqJitdcNpJZnx9ovJW0l+nMuz5NyCsyPLHgeodgUqEYTVxaLzJvLowQtF8+Ya+2aqdLQsrpIIYdpDikiVABOTfBefVFUJ1KIubCO28vh+9/IkGpuIGxb2O3q+PDVd2Yo2hZu2Re0GuGXK0MkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brp6L5Od8WmElBzK+8rO7NebEeltdE6Kxd22zPOwzFM=;
 b=BzZRmGkPV7W7jnkwOIOxkfhPXaeKHksF400mfhPidT8pWFD3L5fpreTopQPLpUkVRVpYgC7OWtwKIiQKtcpIzvpGkjDiMJTjv0KWHzUhuk3nqyP1T/Pd/m0WN64PHS8TNLdbEACDfleZ+UU+R16Y081mfkuw7zQFC9JmXGrKPsL5Xlqm8/NVGDvyTelRjlf0B7Apr3eSAnbjMbp7YfOCHGb3aPRNZeMKj5iRrJiTpt/84qhMjl5B/1HVrOvD8x9cxqaPpAwp+ZWvKQQtCsYy5n6SpoM1W1ojD+yAa2j0kaHxuhR6D+PVzy8gN/sdublMRfxffBLYOCaNiTD7q0yO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.80.74) by
 MN2PR12MB3485.namprd12.prod.outlook.com (20.178.242.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Wed, 30 Oct 2019 10:22:15 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::dd77:dfe4:1913:9d7e]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::dd77:dfe4:1913:9d7e%4]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 10:22:15 +0000
From: "S, Shirish" <sshankar@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "S, Shirish"
 <Shirish.S@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH] drm/amdgpu: dont schedule jobs while in reset
Thread-Topic: [PATCH] drm/amdgpu: dont schedule jobs while in reset
Thread-Index: AQHVjwJaqXgdXzZy206qemuwuHylYady+S4AgAAB3wA=
Date: Wed, 30 Oct 2019 10:22:15 +0000
Message-ID: <58085e1d-39f4-1907-4495-71a13c52b825@amd.com>
References: <1572426811-30618-1-git-send-email-shirish.s@amd.com>
 <bfefc5cb-c560-868a-7b03-90f4e5118451@amd.com>
In-Reply-To: <bfefc5cb-c560-868a-7b03-90f4e5118451@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::19) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:a9::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58df0bb4-26d4-4ab5-414e-08d75d230911
x-ms-traffictypediagnostic: MN2PR12MB3485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB34858E941A0F625419F9D882F2600@MN2PR12MB3485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(6636002)(6246003)(36756003)(4326008)(99286004)(6512007)(14454004)(6486002)(305945005)(7736002)(31686004)(6436002)(478600001)(229853002)(6116002)(53546011)(6506007)(386003)(476003)(2616005)(102836004)(3846002)(76176011)(52116002)(446003)(25786009)(11346002)(186003)(26005)(486006)(8936002)(81156014)(14444005)(256004)(8676002)(31696002)(66066001)(66574012)(110136005)(81166006)(71190400001)(71200400001)(2906002)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(5660300002)(192303002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3485;
 H:MN2PR12MB3248.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CKu/4LlZuJyENOSw+/keJTI4zPCsxRBr1pTFDbUeAoey3JjaSn5qN8mvFYaHjTUV6d+yqOeJGns9XwocffLHaCK2/L10HQs90taXOpA0tm5vm745Gbs/zZefxm4MYCcT5xzvbYZZNvR2VtP2nIKk590Jx6Q+v/eVQrkLXWuND3He4Lq7yyE0a4XA6o6+2siUdtIOvgoWsW/jTZl+IoFyadN+T9x9M+Z8aGV7CTgqMktss7ECzJi6kuGJJaWwGg36FdsEkDn/g/IYp9/EuHYnYZNxqXh++DpIOQvVcY2mF6ZRiXh6JR+aGeFu5wDFpyErHrvwAyxXyWDtXcwoZ/8mMbO7N0KwzwvI4LxrZXArZe4ejiUs8nJJvfOiRpIB/MgVHt7VSWtN8p3N+2wquIGbcKkom3eNvjlTQKF0mGM5w35Q6puMDLLllGYY/sfrstm
Content-ID: <90CFA3EB77F60B478AB5EE5192EB49BE@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58df0bb4-26d4-4ab5-414e-08d75d230911
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 10:22:15.5697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0bJPZLCc9kp0CTHG+1dCxlw47BBx90Hsy/HWv3+78GBbXezmQmymrUqQhjQ1Z5Vad8TZJ6r+jmObiZBozak1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3485
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brp6L5Od8WmElBzK+8rO7NebEeltdE6Kxd22zPOwzFM=;
 b=W5vqEccvdKY4UUwCoTodFTbEUhMmDObQvBcdKFjEtX5I2KCKfzayYCD6BW3w0hUiJBfNGY0S6YUBvWSy49GTMiDh+FuT2IIa0VOr8GgGJ1h9T3asrfSdnpb8MPbPl26auyLgFJJ7DufyMyhCiMAooCHmDJ4IiZjQ5u8YzhbAPOw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030102215.Y4bHHKgyiEA2f2ZCb5l2Ep5bStWHNjRN3BjQJjElwMs@z>

DQpPbiAxMC8zMC8yMDE5IDM6NTAgUE0sIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOg0KPiBBbSAz
MC4xMC4xOSB1bSAxMDoxMyBzY2hyaWViIFMsIFNoaXJpc2g6DQo+PiBbV2h5XQ0KPj4NCj4+IGRv
aW5nIGt0aHJlYWRfcGFyaygpL3VucGFyaygpIGZyb20gZHJtX3NjaGVkX2VudGl0eV9maW5pDQo+
PiB3aGlsZSBHUFUgcmVzZXQgaXMgaW4gcHJvZ3Jlc3MgZGVmZWF0cyBhbGwgdGhlIHB1cnBvc2Ug
b2YNCj4+IGRybV9zY2hlZF9zdG9wLT5rdGhyZWFkX3BhcmsuDQo+PiBJZiBkcm1fc2NoZWRfZW50
aXR5X2ZpbmktPmt0aHJlYWRfdW5wYXJrKCkgaGFwcGVucyBBRlRFUg0KPj4gZHJtX3NjaGVkX3N0
b3AtPmt0aHJlYWRfcGFyayBub3RoaW5nIHByZXZlbnRzIGZyb20gYW5vdGhlcg0KPj4gKHRoaXJk
KSB0aHJlYWQgdG8ga2VlcCBzdWJtaXR0aW5nIGpvYiB0byBIVyB3aGljaCB3aWxsIGJlDQo+PiBw
aWNrZWQgdXAgYnkgdGhlIHVucGFya2VkIHNjaGVkdWxlciB0aHJlYWQgYW5kIHRyeSB0byBzdWJt
aXQNCj4+IHRvIEhXIGJ1dCBmYWlsIGJlY2F1c2UgdGhlIEhXIHJpbmcgaXMgZGVhY3RpdmF0ZWQu
DQo+Pg0KPj4gW0hvd10NCj4+IGdyYWIgdGhlIHJlc2V0IGxvY2sgYmVmb3JlIGNhbGxpbmcgZHJt
X3NjaGVkX2VudGl0eV9maW5pKCkNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGlyaXNoIFMgPHNo
aXJpc2guc0BhbWQuY29tPg0KPj4gU3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IFBhdGNoIGl0c2VsZiBpcyBSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPg0KPiBEb2VzIHRoYXQg
YWxzbyBmaXggdGhlIHByb2JsZW1zIHlvdSBoYXZlIGJlZW4gc2VlaW5nPw0KDQpZZXMgQ2hyaXN0
aWFuLg0KDQpSZWdhcmRzLA0KDQpTaGlyaXNoIFMNCg0KPg0KPiBUaGFua3MsDQo+IENocmlzdGlh
bi4NCj4NCj4+IC0tLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0
eC5jIHwgNSArKysrLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfY3R4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMN
Cj4+IGluZGV4IDY2MTRkOGEuLjJjZGFmM2IgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9jdHguYw0KPj4gQEAgLTYwNCw4ICs2MDQsMTEgQEAgdm9pZCBhbWRncHVf
Y3R4X21ncl9lbnRpdHlfZmluaShzdHJ1Y3QgYW1kZ3B1X2N0eF9tZ3IgKm1ncikNCj4+ICAgIAkJ
CWNvbnRpbnVlOw0KPj4gICAgCQl9DQo+PiAgICANCj4+IC0JCWZvciAoaSA9IDA7IGkgPCBudW1f
ZW50aXRpZXM7IGkrKykNCj4+ICsJCWZvciAoaSA9IDA7IGkgPCBudW1fZW50aXRpZXM7IGkrKykg
ew0KPj4gKwkJCW11dGV4X2xvY2soJmN0eC0+YWRldi0+bG9ja19yZXNldCk7DQo+PiAgICAJCQlk
cm1fc2NoZWRfZW50aXR5X2ZpbmkoJmN0eC0+ZW50aXRpZXNbMF1baV0uZW50aXR5KTsNCj4+ICsJ
CQltdXRleF91bmxvY2soJmN0eC0+YWRldi0+bG9ja19yZXNldCk7DQo+PiArCQl9DQo+PiAgICAJ
fQ0KPj4gICAgfQ0KPj4gICAgDQoNCi0tIA0KUmVnYXJkcywNClNoaXJpc2ggUw0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
