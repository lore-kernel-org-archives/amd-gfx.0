Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D834FC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0E52072C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fsP51gh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0E52072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4951D6EBE4;
	Fri, 13 Mar 2020 14:54:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E586EBE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd6my1SS1KroCMZVcxZRSidabXj61fqzWo45Ci48ObGTFGXyX0Qha0HGNDExyviQixXv2jzMEwJdcJXz9regYIsiEchbqKhdAuwpe+c+jSsxKD73i8Emp2YMiJ8k41U161wcZz6KuNmbsawVqxmcLLOyo+srkrsSMHw2CJq1ZWfOuhAdGoJQPKwhn1AqMizfp3Brg+EAesV66iOMtnwhT5wM0phRKSyW+vp/RxQZy79UgGBq7UElZINHS3AhfgDKwdHv8alUjuPAc19cPR+Jjx9oPR+YRl8La+aKL6yjpwh/apx8vNPUfXryN9bl2zJtVVuxKQ6S9i2kRdZGHTcLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQDltC5cUa9JDlxgWulg2gslV3WMwm/4SkBJX4DdDd4=;
 b=Z4Z9wiatC5IMxRNlcem2HmyG17kyy4U+Dn/7pJDsq0oJ3i9Vi2+uLsNkfuEPbOHM7uU2VPGSok+7ChapNS0FrbiWbBawpb74arfrlJ4zVi2aRPrd5HPUcwsxZLBjb46gNidFfhf0cyBaI4TKhKDWuDg0Tv91We09gKzggX5sJh2Hn/MARd3dUDFuBP1yNKpiqY9bEUMrHEb5jFUk28Z0XigZaUI0e8EHrZ82M68TcXRgL/38myTgD5DGvez9XZlRATpqVOKcRRmipQsT12C3p6jnOXvfd8fHoHbWzsqXLIqZYkUeDDCKFqVdJh94pE6uxKtWPdyCieHpdBXQs4HI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQDltC5cUa9JDlxgWulg2gslV3WMwm/4SkBJX4DdDd4=;
 b=fsP51gh+fnxyPcYuwZGA8IoIPS+r2TfBcw2sfNibVqMW11cL32qg6v24WwUOaCkWqKLbOs/SOeQoJPLl9hmXjvckaBE/1c50IeREt5g4dJirejsSUCVR1zWzeFeem7NiF77sfWhUrX0uYrMpAQLXp0BoyvcusFPwewaJ6gXVLPg=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 14:54:32 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 14:54:32 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: unref the bo after job submit
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: unref the bo after job submit
Thread-Index: AQHV+UDdpQnyjuti9UuZcs5ZCbONbahGkqgAgAAJbwA=
Date: Fri, 13 Mar 2020 14:54:32 +0000
Message-ID: <B4B76788-F1ED-4B88-8622-C55A2A64A252@amd.com>
References: <20200313140758.6607-1-xinhui.pan@amd.com>
 <20200313140758.6607-3-xinhui.pan@amd.com>
 <cb5459d4-2e17-0259-2dd8-1f787a762d6b@amd.com>
In-Reply-To: <cb5459d4-2e17-0259-2dd8-1f787a762d6b@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61f6b682-cf4d-4102-46bb-08d7c75e70ad
x-ms-traffictypediagnostic: SN6PR12MB2637:|SN6PR12MB2637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2637288A3E2A7EE1DA56A79D87FA0@SN6PR12MB2637.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(478600001)(76116006)(37006003)(316002)(66574012)(2906002)(86362001)(6486002)(81156014)(8676002)(8936002)(81166006)(54906003)(6506007)(6636002)(36756003)(33656002)(26005)(6862004)(4326008)(2616005)(186003)(66556008)(66446008)(66946007)(64756008)(5660300002)(6512007)(66476007)(91956017)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2637;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8c0OBRM9ikRAnyGQLaL4I3dQGjQ7MeorxoNtVvewBmC73E1lIAzZIjocBxguePZdo4VurF2D7FDSncFCDEHdauSvoqjFmomXwgiqgV2Z104gnnEfoEp/TRCJ0YVOto/8vv7YcDxIMP0vH5vSH+ZeEGoFVCcypdSbPJ937yhGz18Uwx2MPZfIQVyNW4Aifn/Q/Ln1Bej0pd1/dDxml4pgVqnP01ScHNV4jDVSWqSCTomRbJ405uF3GHDdEJh5ssnDl9tlnvxMNpRxOAmZvVSyEjmeWfDLQFZD/mRK8JEI2PVTbTf3ADw6DM6A87CHLxfcCRDmh7dPp/pDFk2kyeMGWL4CKKBRkuj8/7s0ks0Q5Oq/U2UJJtQHRMiHQE2z5BssVqA/m7wbbyABIvZlfIxtFCGlIEXyguhp7WFeIdhp2tsTwjv1OwOjnGDTJPNpbNym
x-ms-exchange-antispam-messagedata: v0cj6EqtHEE5WehmcKheZ6gNLlNa5tQpJwh0jaJFmJbU/ibSmxBSRpEzLvIEp0b8Rt0JR3ou6lL59UeqY2tERzECScK9jYdr85ZtgplPc+5ENKQrmafit13wW9ILz38NqDVRW25SE6XBTB7c7rQrTA==
Content-ID: <6594714E58450D43A7BD0E96945042C8@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f6b682-cf4d-4102-46bb-08d7c75e70ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 14:54:32.6652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8yfxi4rUxm1uqKqR82lsQbgGLV7nzMJINnncANP3pzLPLBdp3O87GjxuIGHKy1x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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

DQoNCj4gMjAyMOW5tDPmnIgxM+aXpSAyMjoyMO+8jEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IOWGmemBk++8mg0KPiANCj4gQW0gMTMuMDMuMjAgdW0gMTU6MDcg
c2NocmllYiB4aW5odWkgcGFuOg0KPj4gT3RoZXJ3aXNlIHdlIG1pZ2h0IGZyZWUgQk9zIGJlZm9y
ZSBqb2IgaGFzIGNvbXBsZXRlZC4NCj4+IFdlIGFkZCB0aGUgZmVuY2UgdG8gQk8gYWZ0ZXIgY29t
bWl0LCBzbyBmcmVlIEJPcyBhZnRlciB0aGF0Lg0KPiANCj4gSSdtIG5vdCBzdXJlIGlmIHRoaXMg
aXMgbmVjZXNzYXJ5LCBidXQgcHJvYmFibHkgYmV0dGVyIHNhdmUgdGhhbiBzb3JyeS4gICANCg0K
d2l0aG91dCB0aGlzIHBhdGNoLCB3ZSBoaXQgZ21jIHBhZ2UgZmF1bHQuIA0KDQp3ZSBoYXZlIGlu
ZGl2aWR1YWxpemVkIGJvIHJlc3YgZHVyaW5nIGJvIHJlbGVhc2luZy4NCnNvIGFueSBmZW5jZXMg
YWRkZWQgdG8gcm9vdCBQVCBibyByZXN2IGFmdGVyIHRoYXQgaXMgYWN0dWFsbHkgdW50ZXN0ZWQu
DQoNCj4gU29tZSBjb21tZW50cyBiZWxvdy4NCj4gDQo+PiANCj4+IENjOiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPj4gQ2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBh
bWQuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMgfCAzOCArKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAy
OCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+IGluZGV4IDgwOWNhNmU4ZjQwZi4uNjA1YTFiYjQwMjgw
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+PiBAQCAt
OTQyLDEzICs5NDIsMTcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LA0KPj4gICAqDQo+PiAgICogQGVudHJ5OiBQREUgdG8gZnJlZQ0K
Pj4gICAqLw0KPj4gLXN0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3RhYmxlKHN0cnVjdCBhbWRn
cHVfdm1fcHQgKmVudHJ5KQ0KPj4gK3N0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3RhYmxlKHN0
cnVjdCBhbWRncHVfdm1fcHQgKmVudHJ5LA0KPj4gKwkJCQkJc3RydWN0IGxpc3RfaGVhZCAqaGVh
ZCkNCj4+ICB7DQo+PiAgCWlmIChlbnRyeS0+YmFzZS5ibykgew0KPj4gIAkJZW50cnktPmJhc2Uu
Ym8tPnZtX2JvID0gTlVMTDsNCj4+ICAJCWxpc3RfZGVsKCZlbnRyeS0+YmFzZS52bV9zdGF0dXMp
Ow0KPj4gLQkJYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5iby0+c2hhZG93KTsNCj4+IC0J
CWFtZGdwdV9ib191bnJlZigmZW50cnktPmJhc2UuYm8pOw0KPj4gKwkJaWYgKCFoZWFkKSB7DQo+
PiArCQkJYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5iby0+c2hhZG93KTsNCj4+ICsJCQlh
bWRncHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNlLmJvKTsNCj4+ICsJCX0gZWxzZQ0KPj4gKwkJCWxp
c3RfYWRkKCZlbnRyeS0+YmFzZS52bV9zdGF0dXMsIGhlYWQpOw0KPiANCj4gSW5zdGVhZCBvZiBh
ZGRpbmcgYSBwYXJhbWV0ZXIgbWFrZSB0aGlzIGEgbmV3IHN0YXRlIGluIHRoZSBWTS4gU29tZXRo
aW5nIGxpa2Ugdm0tPnpvbWJpZXMgb3Igc29tZXRoaW5nIHNpbWlsYXIuDQo+IA0KPj4gIAl9DQo+
PiAgCWt2ZnJlZShlbnRyeS0+ZW50cmllcyk7DQo+PiAgCWVudHJ5LT5lbnRyaWVzID0gTlVMTDsN
Cj4+IEBAIC05NjUsNyArOTY5LDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyZWVfdGFibGUo
c3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnkpDQo+PiAgICovDQo+PiAgc3RhdGljIHZvaWQgYW1k
Z3B1X3ZtX2ZyZWVfcHRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4gIAkJCSAgICAg
ICBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwNCj4+IC0JCQkgICAgICAgc3RydWN0IGFtZGdwdV92bV9w
dF9jdXJzb3IgKnN0YXJ0KQ0KPj4gKwkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1X3ZtX3B0X2N1cnNv
ciAqc3RhcnQsDQo+PiArCQkJCSAgIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpDQo+PiAgew0KPj4g
IAlzdHJ1Y3QgYW1kZ3B1X3ZtX3B0X2N1cnNvciBjdXJzb3I7DQo+PiAgCXN0cnVjdCBhbWRncHVf
dm1fcHQgKmVudHJ5Ow0KPj4gQEAgLTk3MywxMCArOTc4LDEwIEBAIHN0YXRpYyB2b2lkIGFtZGdw
dV92bV9mcmVlX3B0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+ICAJdm0tPmJ1bGtf
bW92ZWFibGUgPSBmYWxzZTsNCj4+ICAgIAlmb3JfZWFjaF9hbWRncHVfdm1fcHRfZGZzX3NhZmUo
YWRldiwgdm0sIHN0YXJ0LCBjdXJzb3IsIGVudHJ5KQ0KPj4gLQkJYW1kZ3B1X3ZtX2ZyZWVfdGFi
bGUoZW50cnkpOw0KPj4gKwkJYW1kZ3B1X3ZtX2ZyZWVfdGFibGUoZW50cnksIGhlYWQpOw0KPj4g
ICAgCWlmIChzdGFydCkNCj4+IC0JCWFtZGdwdV92bV9mcmVlX3RhYmxlKHN0YXJ0LT5lbnRyeSk7
DQo+PiArCQlhbWRncHVfdm1fZnJlZV90YWJsZShzdGFydC0+ZW50cnksIGhlYWQpOw0KPj4gIH0N
Cj4+ICAgIC8qKg0KPj4gQEAgLTE0MjgsNyArMTQzMyw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92
bV9mcmFnbWVudChzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywNCj4+ICAg
Ki8NCj4+ICBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3Zt
X3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywNCj4+ICAJCQkJIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRf
dCBlbmQsDQo+PiAtCQkJCSB1aW50NjRfdCBkc3QsIHVpbnQ2NF90IGZsYWdzKQ0KPj4gKwkJCQkg
dWludDY0X3QgZHN0LCB1aW50NjRfdCBmbGFncywNCj4+ICsJCQkJIHN0cnVjdCBsaXN0X2hlYWQg
KmhlYWQpDQo+PiAgew0KPj4gIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHBhcmFtcy0+
YWRldjsNCj4+ICAJc3RydWN0IGFtZGdwdV92bV9wdF9jdXJzb3IgY3Vyc29yOw0KPj4gQEAgLTE1
MzksNyArMTU0NSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBh
bWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLA0KPj4gIAkJCSAqIGNvbXBsZXRlbHkgY292
ZXJlZCBieSB0aGUgcmFuZ2UgYW5kIHNvIHBvdGVudGlhbGx5IHN0aWxsIGluIHVzZS4NCj4+ICAJ
CQkgKi8NCj4+ICAJCQl3aGlsZSAoY3Vyc29yLnBmbiA8IGZyYWdfc3RhcnQpIHsNCj4+IC0JCQkJ
YW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHBhcmFtcy0+dm0sICZjdXJzb3IpOw0KPj4gKwkJCQlh
bWRncHVfdm1fZnJlZV9wdHMoYWRldiwgcGFyYW1zLT52bSwgJmN1cnNvciwgaGVhZCk7DQo+PiAg
CQkJCWFtZGdwdV92bV9wdF9uZXh0KGFkZXYsICZjdXJzb3IpOw0KPj4gIAkJCX0NCj4+ICBAQCAt
MTU4Myw2ICsxNTg5LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmco
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiAgCXN0cnVjdCBhbWRncHVfdm1fdXBkYXRl
X3BhcmFtcyBwYXJhbXM7DQo+PiAgCWVudW0gYW1kZ3B1X3N5bmNfbW9kZSBzeW5jX21vZGU7DQo+
PiAgCWludCByOw0KPj4gKwlzdHJ1Y3QgbGlzdF9oZWFkIGhlYWQ7DQo+PiAgICAJbWVtc2V0KCZw
YXJhbXMsIDAsIHNpemVvZihwYXJhbXMpKTsNCj4+ICAJcGFyYW1zLmFkZXYgPSBhZGV2Ow0KPj4g
QEAgLTE1OTAsNiArMTU5Nyw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBw
aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4gIAlwYXJhbXMuZGlyZWN0ID0gZGly
ZWN0Ow0KPj4gIAlwYXJhbXMucGFnZXNfYWRkciA9IHBhZ2VzX2FkZHI7DQo+PiAgKwlJTklUX0xJ
U1RfSEVBRCgmaGVhZCk7DQo+PiArDQo+PiAgCS8qIEltcGxpY2l0bHkgc3luYyB0byBjb21tYW5k
IHN1Ym1pc3Npb25zIGluIHRoZSBzYW1lIFZNIGJlZm9yZQ0KPj4gIAkgKiB1bm1hcHBpbmcuIFN5
bmMgdG8gbW92aW5nIGZlbmNlcyBiZWZvcmUgbWFwcGluZy4NCj4+ICAJICovDQo+PiBAQCAtMTYx
NywxMyArMTYyNiwyMiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+ICAJaWYgKHIpDQo+PiAgCQlnb3RvIGVycm9y
X3VubG9jazsNCj4+ICAtCXIgPSBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoJnBhcmFtcywgc3RhcnQs
IGxhc3QgKyAxLCBhZGRyLCBmbGFncyk7DQo+PiArCXIgPSBhbWRncHVfdm1fdXBkYXRlX3B0ZXMo
JnBhcmFtcywgc3RhcnQsIGxhc3QgKyAxLCBhZGRyLCBmbGFncywgJmhlYWQpOw0KPj4gIAlpZiAo
cikNCj4+ICAJCWdvdG8gZXJyb3JfdW5sb2NrOw0KPj4gICAgCXIgPSB2bS0+dXBkYXRlX2Z1bmNz
LT5jb21taXQoJnBhcmFtcywgZmVuY2UpOw0KPj4gICAgZXJyb3JfdW5sb2NrOg0KPj4gKwl3aGls
ZSAoIWxpc3RfZW1wdHkoJmhlYWQpKSB7DQo+PiArCQlzdHJ1Y3QgYW1kZ3B1X3ZtX3B0ICplbnRy
eSA9IGxpc3RfZmlyc3RfZW50cnkoJmhlYWQsDQo+PiArCQkJCXN0cnVjdCBhbWRncHVfdm1fcHQs
IGJhc2Uudm1fc3RhdHVzKTsNCj4+ICsJCWxpc3RfZGVsKCZlbnRyeS0+YmFzZS52bV9zdGF0dXMp
Ow0KPj4gKw0KPj4gKwkJYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5iby0+c2hhZG93KTsN
Cj4+ICsJCWFtZGdwdV9ib191bnJlZigmZW50cnktPmJhc2UuYm8pOw0KPj4gKwl9DQo+IA0KPiBN
YXliZSBwdXQgdGhhdCBpbnRvIGEgc2VwYXJhdGUgZnVuY3Rpb24uDQo+IA0KPj4gKw0KPj4gIAlh
bWRncHVfdm1fZXZpY3Rpb25fdW5sb2NrKHZtKTsNCj4+ICAJcmV0dXJuIHI7DQo+PiAgfQ0KPj4g
QEAgLTMxMTgsNyArMzEzNiw3IEBAIHZvaWQgYW1kZ3B1X3ZtX2Zpbmkoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQ0KPj4gIAkJYW1kZ3B1X3ZtX2ZyZWVf
bWFwcGluZyhhZGV2LCB2bSwgbWFwcGluZywgTlVMTCk7DQo+PiAgCX0NCj4+ICAtCWFtZGdwdV92
bV9mcmVlX3B0cyhhZGV2LCB2bSwgTlVMTCk7DQo+PiArCWFtZGdwdV92bV9mcmVlX3B0cyhhZGV2
LCB2bSwgTlVMTCwgTlVMTCk7DQo+IA0KPiBBbmQgdGhlbiBhbHNvIGNhbGwgaXQgaGVyZS4NCj4g
DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4gDQo+PiAgCWFtZGdwdV9ib191bnJlc2VydmUo
cm9vdCk7DQo+PiAgCWFtZGdwdV9ib191bnJlZigmcm9vdCk7DQo+PiAgCVdBUk5fT04odm0tPnJv
b3QuYmFzZS5ibyk7DQo+IA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
