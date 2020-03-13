Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D6C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F0A206B7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2Aa/WRtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F0A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998BD6EBDB;
	Fri, 13 Mar 2020 14:31:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B114A6EBDB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSL1Ma0Kidt0th1/SkhGLnXKcg8fH8GrEN0c/IitQUnzpktoA/GwUpI4jiEErnBVCLFIUH3waxXN+eoalzdPe/STIJy7JSnnEBLoGD9tcIqzhYPuhzNcdCEWreQeRxFsdmUFlXjnVnTGDxFdbhi3kSvzVOOVh6N/I3I1iq0HhQCZ7/3NpZrkIaF0S0OBCLt4JURQKwW6jbiFryesBTeJFsDs6GgyrXTdWdiyM91wTbjjcCsgBi5UTrlX8R4MgdWetTwyJEbGJckbMtIa8uJLMWKfHIk6iRLimqgzmrMvYm9Jm+iV4t5wl9aE4+4AUT/rB9H2nlQxOnRdoUHEa022Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLZcLwTiK0pYRzqZTstE1OvFTMsv+D+uq/g+Z9huZno=;
 b=U/6LbtP8IEISljb7vuEPrgSgdpWYvF09BD3cC4YDA/If6s12X37tgBIEOSNRIGhgG1RCoEgsJl7e7sXbg/ANnLJcDjz2RkYn2D3qwuKtIALeO21nJBJsL0UEvNW8KW+14P5rw5Xz4wtbMn1HobPiIt/2X6To1Q7amA9k0PoUUAtB0oZ8VQ9Zg6kfIUhNurq728+kI30bFXL//ukvsZD4gutrRRMMoBx39DStiLay5OobymY0AurqeFDj2BFgWV+iSGUe4wySJZ6Z+lEMbnZSMbNAUdh1+SkG1s25f4jR6vPXIRqYryMbJ1fkiEUJ7wre3cK0351LsV73zB74Sp7SfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLZcLwTiK0pYRzqZTstE1OvFTMsv+D+uq/g+Z9huZno=;
 b=2Aa/WRtPGOQGRAZBoZFsdhqNEl3bsfgOZWfq8H/oG3SnkGtbgxcBeF6MJ86/Z8FSigDZdYVkyFpOMbw5sTEb0AdFsHaidr9410AT8U68Xug2j9RtjKGVSwdH0ho/f85aQIDGgwmN2lqfo/5AUCjKpkXXAf7uN4DbCvtQdel3F5s=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 14:30:59 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 14:30:59 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Add job fence to resv conditionally
Thread-Topic: [PATCH v3 1/2] drm/amdgpu: Add job fence to resv conditionally
Thread-Index: AQHV+UDcdIYIWHpzx0WUgiAUBqhdF6hGkL0AgAAExoA=
Date: Fri, 13 Mar 2020 14:30:59 +0000
Message-ID: <22D45E8C-B495-4846-A90F-D2AA7A304131@amd.com>
References: <20200313140758.6607-1-xinhui.pan@amd.com>
 <20200313140758.6607-2-xinhui.pan@amd.com>
 <3d604156-be87-9f74-69f0-d78f7a2c2879@amd.com>
In-Reply-To: <3d604156-be87-9f74-69f0-d78f7a2c2879@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b00e456a-c4dd-49ed-4fa3-08d7c75b265d
x-ms-traffictypediagnostic: SN6PR12MB2685:|SN6PR12MB2685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB26851DC2CA333DE281D58C1E87FA0@SN6PR12MB2685.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(66446008)(76116006)(66556008)(64756008)(2616005)(66476007)(8676002)(91956017)(6486002)(66946007)(86362001)(33656002)(4326008)(37006003)(36756003)(6636002)(66574012)(6512007)(8936002)(54906003)(186003)(6862004)(5660300002)(498600001)(26005)(71200400001)(2906002)(81156014)(81166006)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2685;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EU/rPtuUIFWnOYwZSMKfW34p/mPSm1c+shx4f0R1IYB+AJxUhleBGN2xXjeUzYHpDQJIgHgnwOr/u4IgguHZ1njsxAwJ+7BrXjhm3zBAy4S3bcSdU5IXTSmnOKFP3JI7ID6l4kQ1SPta+Hlp2rkmQUojZ5RjENV99pCIlOMkprsgqkelifs0mJRaIMJGhpDI9kcqfdwT1jK7dAj35e8w2LScaI78c0KPwsoos6f4CnY0vhbZrkwsB5fuJiX6xezBBUEQIV80CIJfsPdizDVvChSU8mdnury4eP9pnTnsFuHtVH1n821rRdI7MKUidxG6Gs4pNuopRONzxjZDz5kVVskQeVYBfJdFoZNgH/ygBCWhlSJOSYZhqoo7w53Mz8J0A1nr8MTtXhqetZkFPiUwigjfnKaXRHXBEQtVLDBSqPejQWeaGyMY9UF9qa0y7BwG
x-ms-exchange-antispam-messagedata: 3CldMxktgTziF57hp/MYssKqxNFh1kZxEiSv7+I6Ikx2NSkJiBTzdL3gt8Wj0SXmQKS0OZzGDujzChSo4bOtoYn/JjXR4veR/Gmo1KB8lsoPu/e0OCUUyp9EN4fMwufHumIN2RJizTayX+p04hkSBQ==
Content-ID: <7B51C5E501384E4981556B02EC612078@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00e456a-c4dd-49ed-4fa3-08d7c75b265d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 14:30:59.4865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZqWIIFkcDkZiQeAzAu6CuEaIgfatS2wYCFsj8nBv60DHeXh/WoADiDd5FN9pqAj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
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
 Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gMjAyMOW5tDPmnIgxM+aXpSAyMjoxM++8jEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IOWGmemBk++8mg0KPiANCj4gQW0gMTMuMDMuMjAgdW0gMTU6MDcg
c2NocmllYiB4aW5odWkgcGFuOg0KPj4gUHJvdmlkZSByZXN2IGFzIGEgcGFyYW1ldGVyIGZvciB2
bSBzZG1hIGNvbW1pdC4NCj4+IEpvYiBmZW5jZSBvbiBwYWdlIHRhYmxlIHNob3VsZCBiZSBhIHNo
YXJlZCBvbmUsIHNvIGFkZCBpdCB0byB0aGUgcmVzdi4NCj4+IA0KPj4gQ2M6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4+IENjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+PiBDYzogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1
aS5wYW5AYW1kLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jICAgICAgfCA0ICsrLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uaCAgICAgIHwgNSArKysrKw0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bV9zZG1hLmMgfCA3ICsrKysrKysNCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jDQo+PiBpbmRleCA3MzM5ODgzMTE5NmYuLjgwOWNhNmU4ZjQwZiAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPj4gQEAgLTE1Nzks
NiArMTU3OSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4gIAkJCQkgICAgICAgZG1hX2FkZHJfdCAqcGFnZXNf
YWRkciwNCj4+ICAJCQkJICAgICAgIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSkNCj4+ICB7DQo+
PiArCXN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2bS0+cm9vdC5iYXNlLmJvOw0KPj4gIAlzdHJ1
Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgcGFyYW1zOw0KPj4gIAllbnVtIGFtZGdwdV9zeW5j
X21vZGUgc3luY19tb2RlOw0KPj4gIAlpbnQgcjsNCj4+IEBAIC0xNjA0LDggKzE2MDUsNiBAQCBz
dGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwNCj4+ICAJfQ0KPj4gICAgCWlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQpIHsN
Cj4+IC0JCXN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2bS0+cm9vdC5iYXNlLmJvOw0KPj4gLQ0K
Pj4gIAkJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGlyZWN0KSkNCj4+ICAJ
CQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsNCj4+ICBAQCAt
MTYxMyw2ICsxNjEyLDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmco
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiAgCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3Qs
IHZtLT5sYXN0X2RlbGF5ZWQsIHRydWUpOw0KPj4gIAl9DQo+PiAgKwlwYXJhbXMucmVzdiA9IHJv
b3QtPnRiby5iYXNlLnJlc3Y7DQo+PiAgCXIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5wcmVwYXJlKCZw
YXJhbXMsIHJlc3YsIHN5bmNfbW9kZSk7DQo+PiAgCWlmIChyKQ0KPj4gIAkJZ290byBlcnJvcl91
bmxvY2s7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaA0KPj4gaW5kZXgg
YjU3MDVmY2ZjOTM1Li5jYTYwMjFiNDIwMGIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaA0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmgNCj4+IEBAIC0yMjYsNiArMjI2LDExIEBAIHN0cnVjdCBhbWRncHVf
dm1fdXBkYXRlX3BhcmFtcyB7DQo+PiAgCSAqIEBudW1fZHdfbGVmdDogbnVtYmVyIG9mIGR3IGxl
ZnQgZm9yIHRoZSBJQg0KPj4gIAkgKi8NCj4+ICAJdW5zaWduZWQgaW50IG51bV9kd19sZWZ0Ow0K
Pj4gKw0KPj4gKwkvKioNCj4+ICsJICogQHJlc3Y6IHN5bmMgdGhlIHJlc3YgYW5kIGFkZCBqb2Ig
ZmVuY2UgdG8gaXQgY29uZGl0aW9uYWxseS4NCj4+ICsJICovDQo+PiArCXN0cnVjdCBkbWFfcmVz
diAqcmVzdjsNCj4+ICB9Ow0KPj4gICAgc3RydWN0IGFtZGdwdV92bV91cGRhdGVfZnVuY3Mgew0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1h
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jDQo+PiBpbmRl
eCA0Y2M3ODgxZjQzOGMuLmExYjI3MGE0ZGE4ZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMNCj4+IEBAIC0xMTEsNiArMTExLDEzIEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X3ZtX3NkbWFfY29tbWl0KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3Bh
cmFtcyAqcCwNCj4+ICAJCXN3YXAocC0+dm0tPmxhc3RfZGVsYXllZCwgdG1wKTsNCj4+ICAJZG1h
X2ZlbmNlX3B1dCh0bXApOw0KPj4gICsJLyogYWRkIGpvYiBmZW5jZSB0byByZXN2Lg0KPj4gKwkg
KiBNTSBub3RpZmllciBwYXRoIGlzIGFuIGV4Y2VwdGlvbiBhcyB3ZSBjYW4gbm90IGdyYWIgdGhl
DQo+PiArCSAqIHJlc3YgbG9jay4NCj4+ICsJICovDQo+PiArCWlmICghcC0+ZGlyZWN0ICYmIHAt
PnJlc3YpDQo+IA0KPiBZb3UgY2FuIGp1c3QgdXNlIHAtPnZtLT5yb290LmJhc2UuYm8tPnRiby5i
YXNlLnJlc3YgaGVyZSwgbm8gbmVlZCBmb3IgYSBuZXcgZmllbGQgaW4gdGhlIHBhcmFtYXRlciBz
dHJ1Y3R1cmUuDQo+IA0KDQp5ZXAsIG1ha2Ugc2Vuc2UuDQoNCj4gQW5kIGl0IHdvdWxkIHByb2Jh
Ymx5IGJlIGJlc3QgdG8gYWxzbyByZW1vdmUgdGhlIHZtLT5sYXN0X2RlbGF5ZWQgZmllbGQgZW50
aXJlbHkuDQo+IA0KPiBJbiBvdGhlciB3b3JkcyB1c2Ugc29tZXRoaW5nIGxpa2UgdGhpcyBoZXJl
DQo+IA0KPiBpZiAocC0+ZGlyZWN0KSB7DQo+ICAgICB0bXAgPSBkbWFfZmVuY2VfZ2V0KGYpOw0K
PiAgICAgc3dhcChwLT52bS0+bGFzdF9kaXJlY3QsIHRtcCk7DQo+ICAgICBkbWFfZmVuY2VfcHV0
KHRtcCk7DQo+IH0gZWxzZSB7DQo+IGRtYV9yZXN2X2FkZF9zaGFyZWRfZmVuY2UocC0+dm0tPnJv
b3QuYmFzZS5iby0+dGJvLmJhc2UucmVzdiwgZik7DQo+IH0NCj4gDQoNCkkgdGhpbmsgd2Ugc3Rp
bGwgbmVlZCB1ZHBhdGUgdGhlIGxhc3RfZGVsYXllZC4gbG9va3MgbGlrZSBldmljdGlvbiBhbmQg
c29tZSBvdGhlciBpb2N0bHMgdGVzdCB0aGlzIGZpZWxkIHRvIGRldGVybWluZSAgdGhlIHZtIHN0
YXRlLg0KdGhpcyBzaG91bGQgYmUgZG9uZSBieSBhIG5ldyBwYXRjaCBpZiBwb3NzaWJsZS4NCg0K
PiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+IA0KPj4gKwkJZG1hX3Jlc3ZfYWRkX3NoYXJlZF9m
ZW5jZShwLT5yZXN2LCBmKTsNCj4+ICsNCj4+ICAJaWYgKGZlbmNlICYmICFwLT5kaXJlY3QpDQo+
PiAgCQlzd2FwKCpmZW5jZSwgZik7DQo+PiAgCWRtYV9mZW5jZV9wdXQoZik7DQo+IA0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
