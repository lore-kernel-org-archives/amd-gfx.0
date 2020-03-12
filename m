Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71D2C1975A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 13:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC72206BE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 13:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1KOuhpX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC72206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DBA6EABB;
	Thu, 12 Mar 2020 13:25:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F606EABB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 13:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+nqbE2GGy5p3ybA2ahuEmVsBqT6Twtuwx9rEHMPbxuo/+oOApO0IkaT97ylsMkaqAU+8csrAwGj/bailuo5ZNrd/Yk5sF5KOzOQE64/Ccgl6vVdzGY2xip2E1hIP7eTGJ7XjMaDHmDX6H3orLUQ0yL/V7dw2clojoO7Mr6dq8aMTN+WjhUJoUu5EnjT82xVM03dvSTzB0JPf9UwK0L97zmERdbjNuJDeKI0Wt84vizyhGvFyId4KBM2iNhCYbJouwRfaJE2vu+Y27MX9ty4+1Mjk77+0BuKqcDQ2/+9YXpYYsa9Jj6lSpQusvRG2QA/kChIn3qcr/1iNlhO5NRXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyRBGIN1j+OncZ8rF8bqM4EvK6VNYUc6Oam5+woB9+4=;
 b=VnS4B8TWjjXMzqoyhMMKiWwidUTUDioBILPbK7WAxP5TcIWjv0jxYjfy10iOhR/98nie2TtXAwlt97mOEDKSjRbIJW45FOj/bTTTiNZF3d3lnArBmmkm6QfH7kQ5aS/66wUzBEuzDEAPS6Jvfsp61wPNMLVEOEEbusLDOTZRd/697dN7N8Sm7hzWuGyJO42cfwFqTgObwjf5zm/wJlW0bYWNXpxZUH4vFD1IFXZfRS4KI/MoDxCANGE2swRRaf+iQU70fTjyVoQZU7d8vSUJuVJCkRN28o4wxsafS9mIhvEz3x7Ifp59ftn8ppUPaMug5oj+bz0VExMFtaQhisOq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyRBGIN1j+OncZ8rF8bqM4EvK6VNYUc6Oam5+woB9+4=;
 b=1KOuhpX2QKXqIKk1J6sWUwd1zwSwmbanU1g85nbaK4omr2xLz4azZVqn+lKAdxjbkOAWT9sz6TBuc0v7hJzQ8mssKRkw55nvb9Y63KdkgNkQsbrE5LdwypuSSScxBPbxlLfUVo6FqJtzUewqO6/kK2mw27qG4zXuZEIipCt2Kbg=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB3680.namprd12.prod.outlook.com (2603:10b6:208:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 13:25:06 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::3147:1ea1:8fcf:2cf4]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::3147:1ea1:8fcf:2cf4%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 13:25:06 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
Thread-Topic: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
Thread-Index: AQHV+F8U5L7Se/dMEkmUhlnvgqMGdahE0m3QgAAWNICAAAk0wA==
Date: Thu, 12 Mar 2020 13:25:06 +0000
Message-ID: <MN2PR12MB39337C7AFE4D925A877FC94184FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20200312111203.81500-1-christian.koenig@amd.com>
 <MN2PR12MB39335E821319112A6D42CD1784FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
 <eb87e9c1-7e76-11a1-2aa9-fc719e28901c@gmail.com>
In-Reply-To: <eb87e9c1-7e76-11a1-2aa9-fc719e28901c@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc8b1f66-de5b-42d1-3fef-08d7c688c7df
x-ms-traffictypediagnostic: MN2PR12MB3680:|MN2PR12MB3680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3680D8EB9D08C09DA7C6EBBD84FD0@MN2PR12MB3680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(199004)(2906002)(86362001)(966005)(33656002)(45080400002)(478600001)(81166006)(81156014)(66946007)(66574012)(26005)(71200400001)(186003)(64756008)(76116006)(53546011)(6506007)(52536014)(66446008)(66556008)(66476007)(8676002)(9686003)(55016002)(110136005)(7696005)(8936002)(316002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3680;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OiNKMJbUne2LGTisDWi/OYwMIXfpDXS4E2LzFzNNBqv6+r4jgMfLl0dtxyblLwjbOwKQcH1s1DHi94wtqwsNoS0ZdQGmeY5k7y2+6B4ecDmX//RkQhIut6VbchYDqaglpGpl11GcSOVlCFkoiZ7XN+InHRCb7uzZ9sy4EbqNoHjNfKQNTbG/OSD2EVzpkH7YAx3FgyCNkGQuyjSomKynPnUajz/uNyGR8oqQQNmNeqw98QK+OZGb0cy5y6fvVo+dqf8+cn7ZIWB+HykN45jlgRo1H2eG1fwX+4MyeFoEPqB1FSmyBLsj7EcQL/6+9Su3UsbSbXSlguTt9a79Q9coyADRTWJ0R02lX8IyBUT/dLVvqVI7TLRsMXtnprCV2EW7x46OiLfHFcA5UCMPnlqB7iWEn8YuQuBgtQg5Yjx8JgB9CgDkbSFvJt+shoEo8fhznGKzwhUL3513LQLy93696yngTRyN35Xxf6pJ7iIwcVP6T4AxW3K+Lq4VkmCV0SJAQD6P3sSrkctPXJXVsTwoCZ5tSE+PdUL17qc/+lvo+HK9A+nXB1QwfSlCjCmvt/m+eXlL+GmMqMtV4WXbSTv9iA2z5ZVMLBtE2SJh5O+DL/Qq2vUW4g+tbkaQJ+IAzHLN
x-ms-exchange-antispam-messagedata: Ir1H5WaN8OLGGGc15yf7KpD9y4Z8Ql58b4rL5DnFxjDMzrtgV2TYXszADqyJa2mBL1WRwU9czZz8X3ejFSzBkjfRFflyWMj848XabnSFgwWfkXcAybfClVCLX7dh64I48ftbbUF4lrdsyH+y4s6G9Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8b1f66-de5b-42d1-3fef-08d7c688c7df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 13:25:06.6383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qztSoGTLKjsS27AauC2bb+WCWqn9suOJhpEqFYwf0UZ6gsUUu1vtr/r/EnfiEgL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

d2l0aG91dCB5b3VyIHBhdGNoLCB0aGUgY2xlYXIgZmVuY2UgaXMgYWxzbyBob29rZWQgaW4gdGhl
IHNoYXJlZCBsaXN0IG9mIGJvJ3MgcmVzZXJ2YXRpb24gb2JqLCAgbm8gbWF0dGVyIHRoZSBleGNs
dXNpdmUgZmVuY2Ugb2YgdGhhdCBCTyBzaWduYWxlZCBiZWZvcmUgY2xlYXIgZmVuY2Ugb3Igbm90
IA0KDQpzaW5jZSB0aGUgY2xlYXIgZmVuY2UgaXMgYWx3YXlzIGtlcHQgaW4gdGhlIGJvJ3MgcmVz
diBvYmplY3QsIGNhbiB5b3UgdGVsbCBtZSB3aGF0J3MgdGhlIHByb2JsZW0gdGhhbiA/IGFyZSB3
ZSBnb2luZyB0byBsb29zZSB0aGlzIGNsZWFyIGZlbmNlIGFuZCBzdGlsbCB1c2UgaXQgZHVyaW5n
IHRoZSAgVk0gcHQvcGQgY2xlYXJpbmcgPw0KDQp0aGFua3MgDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQpNb25rIExpdXxHUFUgVmlydHVhbGl6YXRpb24gVGVhbSB8QU1E
DQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBLw7ZuaWcg
PGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6IFRodXJzZGF5LCBNYXJj
aCAxMiwgMjAyMCA4OjUwIFBNDQpUbzogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgUGFu
LCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYW5kIGNsZWFudXAgYW1k
Z3B1X2dlbV9vYmplY3RfY2xvc2UNCg0KIEZyb20gdGhlIHNlbWFudGljIHRoZSBkbWFfcmVzdiBv
YmplY3QgY29udGFpbnMgYSBzaW5nbGUgZXhjbHVzaXZlIGFuZCBtdWx0aXBsZSBzaGFyZWQgZmVu
Y2VzIGFuZCBpdCBpcyBtYW5kYXRvcnkgdGhhdCB0aGUgc2hhcmVkIGZlbmNlcyBjb21wbGV0ZSBh
ZnRlciB0aGUgZXhjbHVzaXZlIG9uZS4NCg0KTm93IHdoYXQgaGFwcGVucyBpcyB0aGF0IGNsZWFy
aW5nIHRoZSBWTSBwYWdlIHRhYmxlcyBydW5zIGFzeW5jaHJvbm91c2x5IHRvIHRoZSBleGNsdXNp
dmUgZmVuY2Ugd2hpY2ggbW92ZXMgdGhlIGJ1ZmZlciBhcm91bmQuDQoNCkFuZCBiZWNhdXNlIG9m
IHRoaXMgWGluaHVpIHJhbiBpbnRvIGEgcmFyZSBwcm9ibGVtIHRoYXQgVFRNIHRob3VnaHQgaXQg
Y291bGQgcmV1c2UgdGhlIG1lbW9yeSB3aGlsZSBpbiByZWFsaXR5IGl0IHdhcyBzdGlsbCBpbiB1
c2UuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCkFtIDEyLjAzLjIwIHVtIDEyOjMwIHNjaHJp
ZWIgTGl1LCBNb25rOg0KPiBDYW4geW91IGdpdmUgbW9yZSBkZXRhaWxzIGFib3V0ICIgd2UgY2Fu
J3QgZ3VhcmFudGVlIHRoZSB0aGUgY2xlYXIgZmVuY2Ugd2lsbCBjb21wbGV0ZSBhZnRlciB0aGUg
ZXhjbHVzaXZlIG9uZS4iID8NCj4NCj4gVGhhbmtzDQo+DQo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4gTW9uayBMaXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFN
RA0KPg0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgDQo+IENo
cmlzdGlhbiBLP25pZw0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTIsIDIwMjAgNzoxMiBQTQ0K
PiBUbzogUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGFuZCBjbGVh
bnVwIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlDQo+DQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgd2Ug
Y2FuJ3QgYWRkIHRoZSBjbGVhciBmZW5jZSB0byB0aGUgQk8gd2hlbiB0aGVyZSBpcyBhbiBleGNs
dXNpdmUgZmVuY2Ugb24gaXQgc2luY2Ugd2UgY2FuJ3QgZ3VhcmFudGVlIHRoZSB0aGUgY2xlYXIg
ZmVuY2Ugd2lsbCBjb21wbGV0ZSBhZnRlciB0aGUgZXhjbHVzaXZlIG9uZS4NCj4NCj4gVG8gZml4
IHRoaXMgcmVmYWN0b3IgdGhlIGZ1bmN0aW9uIGFuZCB3YWl0IGZvciBhbnkgcG90ZW50aWFsIGV4
Y2x1c2l2ZSBmZW5jZSB3aXRoIGEgc21hbGwgdGltZW91dCBiZWZvcmUgYWRkaW5nIHRoZSBzaGFy
ZWQgY2xlYXIgZmVuY2UuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dlbS5jIHwgNDEgKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyANCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gaW5kZXggNDI3NzEyNWE3
OWVlLi4wNzgyMTYyZmI1ZjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nZW0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2VtLmMNCj4gQEAgLTE2MSwxMCArMTYxLDExIEBAIHZvaWQgYW1kZ3B1X2dlbV9vYmplY3Rf
Y2xvc2Uoc3RydWN0IA0KPiBkcm1fZ2VtX29iamVjdCAqb2JqLA0KPiAgIA0KPiAgIAlzdHJ1Y3Qg
YW1kZ3B1X2JvX2xpc3RfZW50cnkgdm1fcGQ7DQo+ICAgCXN0cnVjdCBsaXN0X2hlYWQgbGlzdCwg
ZHVwbGljYXRlczsNCj4gKwlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7DQo+ICAgCXN0
cnVjdCB0dG1fdmFsaWRhdGVfYnVmZmVyIHR2Ow0KPiAgIAlzdHJ1Y3Qgd3dfYWNxdWlyZV9jdHgg
dGlja2V0Ow0KPiAgIAlzdHJ1Y3QgYW1kZ3B1X2JvX3ZhICpib192YTsNCj4gLQlpbnQgcjsNCj4g
Kwlsb25nIHI7DQo+ICAgDQo+ICAgCUlOSVRfTElTVF9IRUFEKCZsaXN0KTsNCj4gICAJSU5JVF9M
SVNUX0hFQUQoJmR1cGxpY2F0ZXMpOw0KPiBAQCAtMTgyLDI0ICsxODMsMzIgQEAgdm9pZCBhbWRn
cHVfZ2VtX29iamVjdF9jbG9zZShzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwNCj4gICAJCXJl
dHVybjsNCj4gICAJfQ0KPiAgIAlib192YSA9IGFtZGdwdV92bV9ib19maW5kKHZtLCBibyk7DQo+
IC0JaWYgKGJvX3ZhICYmIC0tYm9fdmEtPnJlZl9jb3VudCA9PSAwKSB7DQo+IC0JCWFtZGdwdV92
bV9ib19ybXYoYWRldiwgYm9fdmEpOw0KPiArCWlmICghYm9fdmEgfHwgLS1ib192YS0+cmVmX2Nv
dW50KQ0KPiArCQlnb3RvIG91dF91bmxvY2s7DQo+ICAgDQo+IC0JCWlmIChhbWRncHVfdm1fcmVh
ZHkodm0pKSB7DQo+IC0JCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7DQo+ICsJYW1k
Z3B1X3ZtX2JvX3JtdihhZGV2LCBib192YSk7DQo+ICsJaWYgKCFhbWRncHVfdm1fcmVhZHkodm0p
KQ0KPiArCQlnb3RvIG91dF91bmxvY2s7DQo+ICAgDQo+IC0JCQlyID0gYW1kZ3B1X3ZtX2NsZWFy
X2ZyZWVkKGFkZXYsIHZtLCAmZmVuY2UpOw0KPiAtCQkJaWYgKHVubGlrZWx5KHIpKSB7DQo+IC0J
CQkJZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY2xlYXIgcGFnZSAiDQo+IC0JCQkJCSJ0
YWJsZXMgb24gR0VNIG9iamVjdCBjbG9zZSAoJWQpXG4iLCByKTsNCj4gLQkJCX0NCj4gICANCj4g
LQkJCWlmIChmZW5jZSkgew0KPiAtCQkJCWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUp
Ow0KPiAtCQkJCWRtYV9mZW5jZV9wdXQoZmVuY2UpOw0KPiAtCQkJfQ0KPiAtCQl9DQo+IC0JfQ0K
PiArCXIgPSBhbWRncHVfdm1fY2xlYXJfZnJlZWQoYWRldiwgdm0sICZmZW5jZSk7DQo+ICsJaWYg
KHIgfHwgIWZlbmNlKQ0KPiArCQlnb3RvIG91dF91bmxvY2s7DQo+ICsNCj4gKwlyID0gZG1hX3Jl
c3Zfd2FpdF90aW1lb3V0X3JjdShiby0+dGJvLmJhc2UucmVzdiwgZmFsc2UsIGZhbHNlLA0KPiAr
CQkJCSAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTApKTsNCj4gKwlpZiAociA9PSAwKQ0KPiArCQly
ID0gLUVUSU1FRE9VVDsNCj4gKwlpZiAocikNCj4gKwkJZ290byBvdXRfdW5sb2NrOw0KPiArDQo+
ICsJYW1kZ3B1X2JvX2ZlbmNlKGJvLCBmZW5jZSwgdHJ1ZSk7DQo+ICsJZG1hX2ZlbmNlX3B1dChm
ZW5jZSk7DQo+ICsNCj4gK291dF91bmxvY2s6DQo+ICsJaWYgKHVubGlrZWx5KHIpKQ0KPiArCQlk
ZXZfZXJyKGFkZXYtPmRldiwgImZhaWxlZCB0byBjbGVhciBwYWdlICINCj4gKwkJCSJ0YWJsZXMg
b24gR0VNIG9iamVjdCBjbG9zZSAoJWQpXG4iLCByKTsNCj4gICAJdHRtX2V1X2JhY2tvZmZfcmVz
ZXJ2YXRpb24oJnRpY2tldCwgJmxpc3QpOyAgfQ0KPiAgIA0KPiAtLQ0KPiAyLjE3LjENCj4NCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6
Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGbGlzdA0KPiBzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1n
ZngmYW1wO2RhdGE9MDIlN0MwMSU3Q01vDQo+IG5rLkxpdSU0MGFtZC5jb20lN0MyNjczMGU1NmM1
Yjk0NGY4Y2JiNDA4ZDdjNjgzZDRhMSU3QzNkZDg5NjFmZTQ4ODRlNjANCj4gOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3MTk2MTQxODE1OTI5OTE1JmFtcDtzZGF0YT15UDVZYzFCV1lXUzkz
Zg0KPiAwaEhFUlVmRUNtU2h3eVE1ZmJNa2hDZUc4Mm42TSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
