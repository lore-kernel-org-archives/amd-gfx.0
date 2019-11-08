Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86124C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 02:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5603321882
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 02:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5603321882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2481F6F82D;
	Fri,  8 Nov 2019 02:55:48 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E920A6F82D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 02:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXGz62Hy+9FQ80dErc9O9vFJvzQB+MAdNBXF8AE2Zc7o0V4jQrElYzRM+XfIp78GzkRxnjidb3i6zdC12xn5HZ1OVpfUqzNWdb/lfsLCJNGJTOSYXN9P2BWkYmkqS7DhVmHnI+XlWGZ+6TqSm37XJp/CuEDTPwihFuTAigQ2zY6VxVZcI7Tmwngxe/OhrsRJhUcYghWFUOiuF7e5MGx6nKRN1AEIRrY5No4wKV8ZHByQR/foFfpuFeRKfHh9czC+X15wvyCCk1jCChMpzwNcv6xzmbwTq8ghhBxEHKaksHfNC/vtcfjNR3P7PZOB0RbeeOralyoXuz29U8ZQxFAZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nFiuKMYfHq3GYjxzI+onb7BxBgykbj5mjB1DupHMkk=;
 b=iBOAjtZvxRU6bebCGcekEKY+oRo67882+Prf6WERHIhBxM0Uqf7Di935q2x1wI5wxGsf56OuN4MoRQMPte6vqqlB/uvf4yx6s11gM5+LXlQe/L54AHWz4HNQ9p7Abn0UOqhotaAjwp4vzxPeOqvdZ+2oYrPjDggPXxpPiJnu2OCJsQhuMrbLk4Sc0jRJUdZC9vMduIJLFx4DMt2D/6HxKJZOBsQBcJAZrJ6uoxG7ZaIoXzWJkCsRlqj10DjV/9oKqh0HBxqPCQo2TO4piSrVudb1dxEbmQ0yH9X3vHvUEJlgpCeB4XPa0nIjHepqaIpHemHPVTcljAmR+hkAF9hopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Fri, 8 Nov 2019 02:55:42 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7%7]) with mapi id 15.20.2408.028; Fri, 8 Nov 2019
 02:55:42 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Thread-Topic: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Thread-Index: AQHVlVW9lxWirD8xeEyV09j5nQhNc6d/kjUAgAD+17A=
Date: Fri, 8 Nov 2019 02:55:42 +0000
Message-ID:
 <MN2PR12MB2975D4E26CED960B82305F308F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1573122349-22080-1-git-send-email-Emily.Deng@amd.com>
 <9de32e5b-69a2-f43f-629f-fef3c30bf5a1@gmail.com>
In-Reply-To: <9de32e5b-69a2-f43f-629f-fef3c30bf5a1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a4cb4e3-07da-400d-8fb1-08d763f724f3
x-ms-traffictypediagnostic: MN2PR12MB3775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3775D8C0741EF31BF1662FAA8F7B0@MN2PR12MB3775.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(13464003)(189003)(199004)(55016002)(99286004)(33656002)(5660300002)(102836004)(316002)(52536014)(76116006)(66946007)(66476007)(6116002)(3846002)(64756008)(66556008)(66446008)(71190400001)(110136005)(66574012)(6506007)(186003)(26005)(76176011)(14444005)(256004)(66066001)(71200400001)(486006)(7696005)(476003)(11346002)(74316002)(7736002)(478600001)(446003)(14454004)(305945005)(25786009)(2501003)(81156014)(6246003)(8676002)(8936002)(6436002)(81166006)(9686003)(229853002)(2906002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3775;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0s0ndLLI5PrtlxnpJSOR20uE3ScaNQpyE1+9wynSYMVmJNWwIMz1meluJLc24nOYU48a9yXq1DYuFq1famn/jtrf/G3REJk06Xveo9LRRafKZkjS3GX0CRGFF20IVf2u2qMiiWEupUDfeb5TbYzKK+AhMBeUNL3q5KdhzRPzbTbmU3AjIHWk5nskQb7NV2W4EHgJ6OzhfKBgYL9i+5FF9LZHbSVwOKLtaQK+SgWRHxvZ9spRp23rXVT6VqmXqgTJufRC/THF6LilmN33dLLeKmHyNWvEd5Ob4fDXWDqx7waM9BJvbI7DAfj/heB9KJ9PMOsnLyQdhRCDRK/XHesGjGPbC9emhgqIgbO3hZK4FPNn7C+9vskglJI1ezyBE2JhTN9jRlyiyLHpFb1PqvosBGfzUOM6xXwDLQUWOJu7gfnHP/2EsuOP1615rx4NsIBv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4cb4e3-07da-400d-8fb1-08d763f724f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 02:55:42.1689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMy49gJ0FGzPb1/nth4iZym292f/jDXOYN7ov1TM4wAjhS9AWCCx8ys9WxP+8vuO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nFiuKMYfHq3GYjxzI+onb7BxBgykbj5mjB1DupHMkk=;
 b=zC2uJSu3AB3W2WRNzfJr0TYRYmw9nzfnRXy49EkDV0ck2LhBLnNzrmYIuVRm7akkrsxb6W6XZ2Z7anj+nmxUWB2VFiPIfunWYwEb/wbm8G8W7q8phMdnXa4XfeGYGt9JBq5I6+V5Z0sBtdovQ1nY6+uHxbU9c5Xe5B8/WOodEqU=
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
Message-ID: <20191108025542.9S_zqsQoI2Uu1sHwp0RQx2fXh3gqOpKlogdgeyzylAs@z>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tv
ZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+U2VudDogVGh1cnNkYXksIE5vdmVtYmVy
IDcsIDIwMTkgNzoyOCBQTQ0KPlRvOiBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0v
YW1kZ3B1OiBGaXggdGhlIG51bGwgcG9pbnRlciBpc3N1ZSBmb3IgdGRyDQo+DQo+QW0gMDcuMTEu
MTkgdW0gMTE6MjUgc2NocmllYiBFbWlseSBEZW5nOg0KPj4gV2hlbiB0aGUgam9iIGlzIGFscmVh
ZHkgc2lnbmFsZWQsIHRoZSBzX2ZlbmNlIGlzIGZyZWVkLiBUaGVuIGl0IHdpbGwNCj4+IGhhcyBu
dWxsIHBvaW50ZXIgaW4gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3Zlci4NCj4NCj5OQUssIHRoZSBz
X2ZlbmNlIGlzIG9ubHkgc2V0IHRvIE5VTEwgd2hlbiB0aGUgam9iIGlzIGRlc3Ryb3llZC4gU2Vl
DQo+ZHJtX3NjaGVkX2pvYl9jbGVhbnVwKCkuDQpJIGtub3cgaXQgaXMgc2V0IHRvIE5VTEwgaW4g
ZHJtX3NjaGVkX2pvYl9jbGVhbnVwLiBCdXQgaW4gb25lIGNhc2UsIHdoZW4gaXQgZW50ZXIgaW50
byB0aGUgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlciwgaXQgYWxyZWFkeSBpbiBkcm1fc2NoZWRf
am9iX2NsZWFudXAsIGFuZCBhdCB0aGlzIHRpbWUsIGl0IHdpbGwgZ28gdG8gZnJlZSBqb2IuIEJ1
dCB0aGUgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlciBzb21ldGltZXMgaXMgZmFzdGVyLiBBdA0K
dGhhdCB0aW1lLCBqb2IgaXMgbm90IGZyZWVkLCBidXQgc19mZW5jZSBpcyBhbHJlYWR5IE5VTEwu
DQo+DQo+V2hlbiB5b3Ugc2VlIGEgam9iIHdpdGhvdXQgYW4gc19mZW5jZSB0aGVuIHRoYXQgbWVh
bnMgdGhlIHByb2JsZW0gaXMNCj5zb21ld2hlcmUgZWxzZS4NCj4NCj5SZWdhcmRzLA0KPkNocmlz
dGlhbi4NCj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFt
ZC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jIHwgIDIgKy0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWlu
LmMgICAgIHwgMTEgKysrKysrLS0tLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IGluZGV4IGU2Y2U5NDkuLjVhOGYwOGUgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4gQEAgLTQw
NzUsNyArNDA3NSw3IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdA0KPmFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiAgIAkgKg0KPj4gICAJICogam9iLT5iYXNlIGhvbGRzIGEg
cmVmZXJlbmNlIHRvIHBhcmVudCBmZW5jZQ0KPj4gICAJICovDQo+PiAtCWlmIChqb2IgJiYgam9i
LT5iYXNlLnNfZmVuY2UtPnBhcmVudCAmJg0KPj4gKwlpZiAoam9iICYmIGpvYi0+YmFzZS5zX2Zl
bmNlICYmIGpvYi0+YmFzZS5zX2ZlbmNlLT5wYXJlbnQgJiYNCj4+ICAgCSAgICBkbWFfZmVuY2Vf
aXNfc2lnbmFsZWQoam9iLT5iYXNlLnNfZmVuY2UtPnBhcmVudCkpDQo+PiAgIAkJam9iX3NpZ25h
bGVkID0gdHJ1ZTsNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxl
ci9zY2hlZF9tYWluLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWlu
LmMNCj4+IGluZGV4IDMxODA5Y2EuLjU2Y2MxMGUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9tYWluLmMNCj4+IEBAIC0zMzQsOCArMzM0LDggQEAgdm9pZCBkcm1fc2No
ZWRfaW5jcmVhc2Vfa2FybWEoc3RydWN0DQo+ZHJtX3NjaGVkX2pvYg0KPj4gKmJhZCkNCj4+DQo+
PiAgIAkJCXNwaW5fbG9jaygmcnEtPmxvY2spOw0KPj4gICAJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5
X3NhZmUoZW50aXR5LCB0bXAsICZycS0+ZW50aXRpZXMsDQo+bGlzdCkgew0KPj4gLQkJCQlpZiAo
YmFkLT5zX2ZlbmNlLT5zY2hlZHVsZWQuY29udGV4dCA9PQ0KPj4gLQkJCQkgICAgZW50aXR5LT5m
ZW5jZV9jb250ZXh0KSB7DQo+PiArCQkJCWlmIChiYWQtPnNfZmVuY2UgJiYgKGJhZC0+c19mZW5j
ZS0NCj4+c2NoZWR1bGVkLmNvbnRleHQgPT0NCj4+ICsJCQkJICAgIGVudGl0eS0+ZmVuY2VfY29u
dGV4dCkpIHsNCj4+ICAgCQkJCQlpZiAoYXRvbWljX3JlYWQoJmJhZC0+a2FybWEpID4NCj4+ICAg
CQkJCQkgICAgYmFkLT5zY2hlZC0+aGFuZ19saW1pdCkNCj4+ICAgCQkJCQkJaWYgKGVudGl0eS0+
Z3VpbHR5KQ0KPj4gQEAgLTM3Niw3ICszNzYsNyBAQCB2b2lkIGRybV9zY2hlZF9zdG9wKHN0cnVj
dCBkcm1fZ3B1X3NjaGVkdWxlcg0KPipzY2hlZCwgc3RydWN0IGRybV9zY2hlZF9qb2IgKmJhZCkN
Cj4+ICAgCSAqIFRoaXMgaXRlcmF0aW9uIGlzIHRocmVhZCBzYWZlIGFzIHNjaGVkIHRocmVhZCBp
cyBzdG9wcGVkLg0KPj4gICAJICovDQo+PiAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmVfcmV2
ZXJzZShzX2pvYiwgdG1wLCAmc2NoZWQtDQo+PnJpbmdfbWlycm9yX2xpc3QsIG5vZGUpIHsNCj4+
IC0JCWlmIChzX2pvYi0+c19mZW5jZS0+cGFyZW50ICYmDQo+PiArCQlpZiAoc19qb2ItPnNfZmVu
Y2UgJiYgc19qb2ItPnNfZmVuY2UtPnBhcmVudCAmJg0KPj4gICAJCSAgICBkbWFfZmVuY2VfcmVt
b3ZlX2NhbGxiYWNrKHNfam9iLT5zX2ZlbmNlLT5wYXJlbnQsDQo+PiAgIAkJCQkJICAgICAgJnNf
am9iLT5jYikpIHsNCj4+ICAgCQkJYXRvbWljX2RlYygmc2NoZWQtPmh3X3JxX2NvdW50KTsNCj4+
IEBAIC0zOTUsNyArMzk1LDggQEAgdm9pZCBkcm1fc2NoZWRfc3RvcChzdHJ1Y3QgZHJtX2dwdV9z
Y2hlZHVsZXINCj4qc2NoZWQsIHN0cnVjdCBkcm1fc2NoZWRfam9iICpiYWQpDQo+PiAgIAkJCSAq
DQo+PiAgIAkJCSAqIEpvYiBpcyBzdGlsbCBhbGl2ZSBzbyBmZW5jZSByZWZjb3VudCBhdCBsZWFz
dCAxDQo+PiAgIAkJCSAqLw0KPj4gLQkJCWRtYV9mZW5jZV93YWl0KCZzX2pvYi0+c19mZW5jZS0+
ZmluaXNoZWQsIGZhbHNlKTsNCj4+ICsJCQlpZiAoc19qb2ItPnNfZmVuY2UpDQo+PiArCQkJCWRt
YV9mZW5jZV93YWl0KCZzX2pvYi0+c19mZW5jZS0+ZmluaXNoZWQsDQo+ZmFsc2UpOw0KPj4NCj4+
ICAgCQkJLyoNCj4+ICAgCQkJICogV2UgbXVzdCBrZWVwIGJhZCBqb2IgYWxpdmUgZm9yIGxhdGVy
IHVzZSBkdXJpbmcgQEANCj4tNDM4LDcNCj4+ICs0MzksNyBAQCB2b2lkIGRybV9zY2hlZF9zdGFy
dChzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkLCBib29sDQo+ZnVsbF9yZWNvdmVyeSkN
Cj4+ICAgCSAqIEdQVSByZWNvdmVycyBjYW4ndCBydW4gaW4gcGFyYWxsZWwuDQo+PiAgIAkgKi8N
Cj4+ICAgCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShzX2pvYiwgdG1wLCAmc2NoZWQtPnJpbmdf
bWlycm9yX2xpc3QsIG5vZGUpDQo+ew0KPj4gLQkJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBz
X2pvYi0+c19mZW5jZS0+cGFyZW50Ow0KPj4gKwkJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBz
X2pvYi0+c19mZW5jZSA/IHNfam9iLT5zX2ZlbmNlLQ0KPj5wYXJlbnQgOg0KPj4gK05VTEw7DQo+
Pg0KPj4gICAJCWF0b21pY19pbmMoJnNjaGVkLT5od19ycV9jb3VudCk7DQo+Pg0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
