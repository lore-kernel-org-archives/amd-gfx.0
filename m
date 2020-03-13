Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F452C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 09:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302C1206FA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 09:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hjV1V02N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302C1206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2D66EBA3;
	Fri, 13 Mar 2020 09:29:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761346EBA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 09:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBQiWIOykQ2hID1mF+w3xQ18e4Jz7wklvHhk86ty+1hacLW/2sbbjIVvAUrNw3PWU4uY6SqYHH2j6H9HvOiKdJ+/gop1Q75kkXRZnQ8npDBuY13kRBuuqBS1Tt5eotNAngqUr8BUTiMII1aufQDDSscAgdSRO1rgDZBLXx1bp9HRbW+khOwfq3vCQ0Ln8dAd0VLrWs668T69KbSx2FN5O7NHcwde9ZAUyeEl9vKlRym4lmClVK+b5ok84uYimhG6RDMNI0auwAUVSfrng5CboaY4Sd15r36ssIt38895Yuwi1u/Xdg7k4P4ejwBOHWfhp/Xg7tcDohRu3eqvRZZrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SW+bIC20XwuH4eOVI//T1R1OR795cD41A/ZgkUoN8g=;
 b=fhfHzJdCCoMp6wTPsImy2FY6EfM6KOS954TPues513umHnR/HJ1ZnPV6j/GiDNrAEy1I5JRQ3TlfeiBeOwS9NHRH6dPOfgFPLA+XZSxFQfXKpSvMVAAuB4+diZ+hjIdh7VYCugZ//nok5FwjthnajHeVLgvfLfTxnf81/FnscRMcXmHA1bJbGD6C4zlcWRrqSoK3Ixl8uIXmawVGjUoG75Ert4Z7Yl3Nl71V1QNaK9Oaqt6IpuAlJUYSGyDoII0MbhC97w2s7S2wZTFjUVyU5fWowF8bZkQo0NkDuszPqkLndNZ7v4m8JDVlKTxTS6X5/0AxebKGdh0zqZMKTgZI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SW+bIC20XwuH4eOVI//T1R1OR795cD41A/ZgkUoN8g=;
 b=hjV1V02N6H0OhPlw9BumJNmtmL2CFm02OJ/BVr5nsdQAUcCGZ5RV4HBgMOcxsGeMbbRS7GApC7Ph+z6m0iKOXAxMxXJxdKC7yhJXUI/CIsyWD66xPbNOAxNVycAiGv//obeo7hvB65so9zPIvOVRPsm3IxWA4ywkIfnXFaW6YaQ=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Fri, 13 Mar
 2020 09:29:00 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 09:29:00 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/2] drm//amdgpu: Always sync fence before unlock
 eviction_lock
Thread-Topic: [PATCH 1/2] drm//amdgpu: Always sync fence before unlock
 eviction_lock
Thread-Index: AQHV+QssFpyaZpcpG0W9yYu71Go6f6hGN1IAgAAKPoA=
Date: Fri, 13 Mar 2020 09:29:00 +0000
Message-ID: <0D32D879-69FB-4D0F-8742-1BB9BF0AB766@amd.com>
References: <20200313074336.19545-1-xinhui.pan@amd.com>
 <20200313074336.19545-2-xinhui.pan@amd.com>
 <91022e2e-67fb-ef65-09d6-2814b10493d8@amd.com>
In-Reply-To: <91022e2e-67fb-ef65-09d6-2814b10493d8@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f6bf794-e985-4fa4-4242-08d7c730f691
x-ms-traffictypediagnostic: SN6PR12MB2638:|SN6PR12MB2638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2638E1A6329731B0B743A08287FA0@SN6PR12MB2638.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(86362001)(8936002)(64756008)(36756003)(26005)(2616005)(66946007)(91956017)(6506007)(66556008)(5660300002)(66446008)(478600001)(66476007)(8676002)(186003)(81156014)(76116006)(37006003)(6862004)(6512007)(33656002)(2906002)(81166006)(66574012)(316002)(54906003)(71200400001)(6636002)(4326008)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2638;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HNDyIjC1gfiE1HT9oma3bPOC410Vk4kdFCmsc7v3UqmFEqg7m83ttH9QPXhZwtT5wH5e1S4BjjPrsk1TWzlp1gHaG9+5D7DlxjB6wOd+YLtkK0i71gKxt48DexNCwCDauZ+yZE34ojByuZoSfubcq3V4wXNVT9nZvA/pCP/ukUsUzT+VoeVa1DsDpD9A2j/GSfDGvEVJGbkLKswbpiRcA4G97lSznJWx9nRQlyN+dNg7j/TCiGhjseqoI3uqEuYbxu1bAQaksnRJ9EHUk0NWKyAqhdUZK4hqzsnzvEODVTbU46OcCq907PEM9FII/a4vd4lyGzSonPEVBRvu3jM6ADUgJlpgoueT3Mgqh4pQU1pndUavduHlBKxjP6tdrLvfK4y4shb3sUR+zM6+41+QUdeRsI2ZQcxbAmWncpODRPtU+hpoymqyZ1ymcHR6D+Np
x-ms-exchange-antispam-messagedata: vg/em9SHgHU4AkMmI23lIfi3CO35j2h7las35n55XX9DHRgFOynLqeem/A376GQ6z6uwOgp2fBJRVbfTalKtdvfEbNVZH6tx4o2vXBIVPHCdEr2nRE2ksrn0I0n59Lmobj8acarA4CtmdA+N/rnwtA==
Content-ID: <AA0F809083B4124996FF022D9FD2F58F@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6bf794-e985-4fa4-4242-08d7c730f691
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 09:29:00.4217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3CmHBeEiY+UH+UdOz2SOtTex9ql4d0KPOc4+5Jd4yr4IthdnNR29nvaK7ErYdqf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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

DQoNCj4gMjAyMOW5tDPmnIgxM+aXpSAxNjo1Mu+8jEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IOWGmemBk++8mg0KPiANCj4gQW0gMTMuMDMuMjAgdW0gMDg6NDMg
c2NocmllYiB4aW5odWkgcGFuOg0KPj4gVGhlIGZlbmNlIGdlbmVyYXRlZCBpbiAtPmNvbW1pdCBp
cyBhIHNoYXJlZCBvbmUsIHNvIGFkZCBpdCB0byByZXN2Lg0KPj4gQW5kIHdlIG5lZWQgZG8gdGhh
dCB3aXRoIGV2aWN0aW9uIGxvY2sgaG9sZC4NCj4+IA0KPj4gQ3VycmVudGx5IHdlIG9ubHkgc3lu
YyBsYXN0X2RpcmVjdC9sYXN0X2RlbGF5ZWQgYmVmb3JlIC0+cHJlcGFyZS4gQnV0IHdlDQo+PiBm
YWlsIHRvIHN5bmMgdGhlIGxhc3QgZmVuY2UgZ2VuZXJhdGVkIGJ5IC0+Y29tbWl0LiBUaGF0IGN1
YXNlcyBwcm9ibGVtcw0KPj4gaWYgZXZpY3Rpb24gaGFwcGVuZXMgbGF0ZXIsIGJ1dCBpdCBkb2Vz
IG5vdCBzeW5jIHRoZSBsYXN0IGZlbmNlLg0KPiANCj4gTkFLLCB0aGF0IHdvbid0IHdvcmsuDQo+
IA0KPiBXZSBjYW4gb25seSBhZGQgZmVuY2VzIHdoZW4gdGhlIGRtYV9yZXN2IG9iamVjdCBpcyBs
b2NrZWQgYW5kIHRoYXQgaXMgb25seSB0aGUgY2FzZSB3aGVuIHZhbGlkYXRpbmcuDQo+IA0Kd2Vs
bCwgdGhhIHRpcyB0cnVlLg0KYnV0IGNvbnNpZGVyaW5nIHRoaXMgaXMgYSBQVCBCTywgYW5kIG9u
bHkgZXZpY3Rpb24gaGFzIHJhY2Ugb24gaXQgQUZBSUsuDQphcyBmb3IgdGhlIGluZGl2aWR1YWxp
emVkIHJlc3YgaW4gYm8gcmVsZWFzZSwgd2UgdW5yZWYgUFQgQk8ganVzdCBhZnRlciB0aGF0Lg0K
SSBhbSBzdGlsbCB0aGlua2luZyBvZiBvdGhlciByYWNlcyBpbiB0aGUgcmVhbCB3b3JsZC4NCg0K
dGhhbmtzDQp4aW5odWkNCg0KPiBJJ20gY29uc2lkZXJpbmcgdG8ganVzdCBwYXJ0aWFsbHkgcmV2
ZXJ0IHRoZSBwYXRjaCBvcmlnaW5hbGx5IHN0b3BwaW5nIHRvIGFkZCBmZW5jZXMgYW5kIGluc3Rl
YWQgb25seSBub3QgYWRkIHRoZW0gd2hlbiBpbnZhbGlkYXRpbmcgaW4gYSBkaXJlY3Qgc3VibWl0
Lg0KPiANCj4gQ2hyaXN0aWFuLg0KPiANCj4+IA0KPj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+DQo+PiBDYzogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFt
ZC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+
DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDkg
KysrKysrKy0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+IGlu
ZGV4IDczMzk4ODMxMTk2Zi4uZjQyNGI1OTY5OTMwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+PiBAQCAtMTU4Miw2ICsxNTgyLDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
DQo+PiAgCXN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyBwYXJhbXM7DQo+PiAgCWVudW0g
YW1kZ3B1X3N5bmNfbW9kZSBzeW5jX21vZGU7DQo+PiAgCWludCByOw0KPj4gKwlzdHJ1Y3QgYW1k
Z3B1X2JvICpyb290ID0gdm0tPnJvb3QuYmFzZS5ibzsNCj4+ICAgIAltZW1zZXQoJnBhcmFtcywg
MCwgc2l6ZW9mKHBhcmFtcykpOw0KPj4gIAlwYXJhbXMuYWRldiA9IGFkZXY7DQo+PiBAQCAtMTYw
NCw4ICsxNjA1LDYgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiAgCX0NCj4+ICAgIAlpZiAoZmxhZ3MgJiBBTURH
UFVfUFRFX1ZBTElEKSB7DQo+PiAtCQlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0gdm0tPnJvb3Qu
YmFzZS5ibzsNCj4+IC0NCj4+ICAJCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0
X2RpcmVjdCkpDQo+PiAgCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3QsIHZtLT5sYXN0X2RpcmVjdCwg
dHJ1ZSk7DQo+PiAgQEAgLTE2MjMsNiArMTYyMiwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9i
b191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+ICAgIAlyID0g
dm0tPnVwZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsNCj4+ICArCWlmICghZG1h
X2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0X2RpcmVjdCkpDQo+PiArCQlhbWRncHVfYm9fZmVu
Y2Uocm9vdCwgdm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsNCj4+ICsNCj4+ICsJaWYgKCFkbWFfZmVu
Y2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGVsYXllZCkpDQo+PiArCQlhbWRncHVfYm9fZmVuY2Uo
cm9vdCwgdm0tPmxhc3RfZGVsYXllZCwgdHJ1ZSk7DQo+PiArDQo+PiAgZXJyb3JfdW5sb2NrOg0K
Pj4gIAlhbWRncHVfdm1fZXZpY3Rpb25fdW5sb2NrKHZtKTsNCj4+ICAJcmV0dXJuIHI7DQo+IA0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
