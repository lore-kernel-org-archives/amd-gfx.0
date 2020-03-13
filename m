Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA8BC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 12:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D602E20724
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 12:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eVbwBprL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D602E20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A4326E290;
	Fri, 13 Mar 2020 12:20:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C0B6E290
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 12:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ogwj3QMkoqR1TaTwGTFIyKEhskzOXnxHbL9LKYCJOje96ewRvvIerdUYuNZREb8a1fmZLystEig3VH9veG9ok8uPaN9C2G6RwWmDc5fqWUb2I/Etc7CPwZFkilqg4YbPdZ9gd+OX5tbY3l+NdnlfY20fr5TY3CaS26p9vnkxJugDHk1sffmsJCSD+eEjNXeOkoPXMo11aD0zhvDCOPw+Gpa3MjyJl0qTheYg3kL1Phe3Ir/jTNGKcuBoeJsDLb0oCbQJCnyejW28aHVrqzf1HxA+M9mQ6xvri3BZWUSKDLGfYKPkAn2fSFkGqclshabvIJr/IC6oJb6w+z+K7IpBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvthAtj5Ggi2fyJ+tWxGLipMFHL5R2jiNBIM4GI/2Uo=;
 b=KDGtRfhA8JHCZcFIpqLVWaaPYiJvqI8vS6sjUEKMw6ek1imWJl/azO1TkYwBcnqu5EJvXp3VcylJKyPZgXnLOYRv/mjxoan6SAr080WXj608jxXxq7KyxbKXtypfrI2LC8sEg/TaLEtjrgoykXrUuEjuBYWQrp3zmNKMx734f2DixH5IC6iBqjkIxYTC5uWWrWtTqIdWtgoVFmRzqMJmZA3X1lsoIUfSztLqhgTuNAVOBTqbqldKIcZQzilfRXSLEVyPc7j2dcS43iZ+ysz9lcUAkwiNL+RaAvvEWig5/kO6Y0n+XgmTyE/ubzgMbTAaImb+z8p2n++8qkP46zneQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvthAtj5Ggi2fyJ+tWxGLipMFHL5R2jiNBIM4GI/2Uo=;
 b=eVbwBprLnSgt73973jbN5jF3blxXxO2Krp7NQYObPknMjRrxypOxxDlqZHIGtS0ovVwql2Mcbd0Gxs0uBN9d0hH0fwdisb5GBXVeg3Q+3xzcBVME3wlLll6ZnM8A25fiFzwZK23frmst+gRcv8nVu/5sUa/ZmsBr5bNXnVnt8pg=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2704.namprd12.prod.outlook.com (2603:10b6:805:72::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Fri, 13 Mar
 2020 12:20:27 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 12:20:27 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Re: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditionally
Thread-Topic: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditionally
Thread-Index: AQHV+S4ATH3sb2rsUUK6EyNaVWOphKhGcTEA
Date: Fri, 13 Mar 2020 12:20:27 +0000
Message-ID: <400286D3-A1F7-4C14-9499-81A80885663F@amd.com>
References: <20200313115305.32325-1-xinhui.pan@amd.com>
In-Reply-To: <20200313115305.32325-1-xinhui.pan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35133c40-1bf0-4428-2d59-08d7c748ea47
x-ms-traffictypediagnostic: SN6PR12MB2704:|SN6PR12MB2704:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27047B590AD44F2E51A5329487FA0@SN6PR12MB2704.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(66574012)(54906003)(37006003)(186003)(2906002)(6486002)(86362001)(36756003)(6862004)(6506007)(64756008)(91956017)(66446008)(66476007)(66556008)(66946007)(71200400001)(76116006)(4326008)(5660300002)(6200100001)(478600001)(8676002)(81166006)(8936002)(81156014)(26005)(316002)(2616005)(6512007)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2704;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: igN94Z/4J2Md50uNtG0cAN7oYJcz1zXjouGtnUJR7WS1IMaWcHgm+WVaDHz9kbNyO/zecLwmmF9ujlxuA4qfD1ncXk9z0aA3sTPthODGSoTrOK4Wmlw3w37eP0D6n077xQG5IQFmZ6pfpaH/15KvP7FmOp3I1GspYonb9YE+u6u4RwNsVWJkk1fEKBvsbTrenMo9yc95FdCQL3BgfbtRslGETo/Inj7bpxQlRPuSZCgzCzTIWXz32JKKwV///2UHkmMMeZmGb4TIXnNDF4R6OUFlCZmd6JZPpu10/goN/R3nV2YUZK1WKBIk9SgpSmbtbWrL9E4xSb3nza2sKSwkY205jdzP1OtwUUeIGOVzeb6JIGWJRKATbCMhhj+0n+rtG2jqw8InjvETAVLmv+5f/COpQHz2x4WgPpAfNkfyGG/45NT/o07UeIV6h53ixER7
x-ms-exchange-antispam-messagedata: xZhN/hV0RDMDo9K0qSc9UG4j2YZyxpxtN1bdttjZmHT87V75UgEiBoEWWzEA2e6M1W2KXYuFsNgyWbg2kBVpH8y9/QjKSrZMjCORdOe6bnz6HsbhGb4s1/viVXgxi24gZucpZl3KZnoikOleGBZyTQ==
Content-ID: <5C1AD7232327604C89CB2D0FB5B9241A@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35133c40-1bf0-4428-2d59-08d7c748ea47
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 12:20:27.6531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcOhBHVH0tDv3rUg7y7uLylnFCL2ya/wJg52iKYo+9ulRJUE5zwZA7Btkxiiaw/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2704
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

d2FpdCwgdGhpcyBjYXVzZXMgdGVzdCBjYXNlIGluIFNsKyBzdGF0ZS4gbmVlZCB0YWtlIGEgbG9v
ay4NCiANCj4gMjAyMOW5tDPmnIgxM+aXpSAxOTo1M++8jFBhbiwgWGluaHVpIDxYaW5odWkuUGFu
QGFtZC5jb20+IOWGmemBk++8mg0KPiANCj4gSWYgYSBqb2IgbmVlZCBzeW5jIHRoZSBibyByZXN2
LCBpdCBpcyBsaWtlbHkgdGhhdCBibyBuZWVkIHRoZSBqb2IgZmVuY2UNCj4gdG8gc3luYyB3aXRo
IG90aGVycy4NCj4gDQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+
IENjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gU3VnZ2VzdGVk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4NCj4gLS0tDQo+IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oICAgICAgfCA1ICsrKysrDQo+IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMgfCA5ICsrKysrKysrKw0KPiAy
IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5oDQo+IGluZGV4IGI1NzA1ZmNmYzkzNS4uY2E2MDIxYjQyMDBiIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaA0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaA0KPiBAQCAtMjI2LDYg
KzIyNiwxMSBAQCBzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgew0KPiAJICogQG51bV9k
d19sZWZ0OiBudW1iZXIgb2YgZHcgbGVmdCBmb3IgdGhlIElCDQo+IAkgKi8NCj4gCXVuc2lnbmVk
IGludCBudW1fZHdfbGVmdDsNCj4gKw0KPiArCS8qKg0KPiArCSAqIEByZXN2OiBzeW5jIHRoZSBy
ZXN2IGFuZCBhZGQgam9iIGZlbmNlIHRvIGl0IGNvbmRpdGlvbmFsbHkuDQo+ICsJICovDQo+ICsJ
c3RydWN0IGRtYV9yZXN2ICpyZXN2Ow0KPiB9Ow0KPiANCj4gc3RydWN0IGFtZGdwdV92bV91cGRh
dGVfZnVuY3Mgew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtX3NkbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1h
LmMNCj4gaW5kZXggNGNjNzg4MWY0MzhjLi4wY2ZhYzU5YmZmMzYgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYw0KPiBAQCAtNzAsNiArNzAsOCBA
QCBzdGF0aWMgaW50IGFtZGdwdV92bV9zZG1hX3ByZXBhcmUoc3RydWN0IGFtZGdwdV92bV91cGRh
dGVfcGFyYW1zICpwLA0KPiANCj4gCXAtPm51bV9kd19sZWZ0ID0gbmR3Ow0KPiANCj4gKwlwLT5y
ZXN2ID0gcmVzdjsNCj4gKw0KPiAJaWYgKCFyZXN2KQ0KPiAJCXJldHVybiAwOw0KPiANCj4gQEAg
LTExMSw2ICsxMTMsMTMgQEAgc3RhdGljIGludCBhbWRncHVfdm1fc2RtYV9jb21taXQoc3RydWN0
IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwLA0KPiAJCXN3YXAocC0+dm0tPmxhc3RfZGVsYXll
ZCwgdG1wKTsNCj4gCWRtYV9mZW5jZV9wdXQodG1wKTsNCj4gDQo+ICsJLyogYWRkIGpvYiBmZW5j
ZSB0byByZXN2Lg0KPiArCSAqIE1NIG5vdGlmaWVyIHBhdGggaXMgYW4gZXhjZXB0aW9uIGFzIHdl
IGNhbiBub3QgZ3JhYiB0aGUNCj4gKwkgKiByZXN2IGxvY2suDQo+ICsJICovDQo+ICsJaWYgKCFw
LT5kaXJlY3QgJiYgcC0+cmVzdikNCj4gKwkJZG1hX3Jlc3ZfYWRkX3NoYXJlZF9mZW5jZShwLT5y
ZXN2LCBmKTsNCj4gKw0KPiAJaWYgKGZlbmNlICYmICFwLT5kaXJlY3QpDQo+IAkJc3dhcCgqZmVu
Y2UsIGYpOw0KPiAJZG1hX2ZlbmNlX3B1dChmKTsNCj4gLS0gDQo+IDIuMTcuMQ0KPiANCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
