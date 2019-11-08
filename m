Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD2FA372C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 09:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBAD21848
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 09:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBAD21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A3B6E041;
	Fri,  8 Nov 2019 09:07:34 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820050.outbound.protection.outlook.com [40.107.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2F76E041
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 09:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klxfG/x9rxI239oa3BtEEH17QUMorBLiuFdE+zaTuHxBTalzOo8j3UwNTi4v5JlSiF1PVAeNl2c+/GEtKmfKbtDPOeyxw1SL/6iWbaRMXotFJKTKErnDE10XWzsFZF2SEYm5yZzfkikKkjLdM0JpfM696jjn1E+ymTMt8L8Uj96txn3Nj2p8YUcpCuKOTweDWeZtLmxWNWiQ1CECXHqCiv63pWYGGNL9HAstaqqWXx5pN+RNHxxQOvyeWN1PEdnkoJ1PhN31tC2MUle6enJmU1NzrnQamZXJc9sYeF7Spb8ZLXI5XzUCrQ7EeZRuyK6X3WTPEcdStQugY3mg7paIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMA0J6vHwZEzrqd1zXH3HD7UkhZzZDxrsGgpfKvUl8Y=;
 b=h9LbCE26cSi6+GC3QTKHP18qiZOJNM14KhoignCbI3o94XDvzdaNuaIziSvZN3dUF7ul3/93ibk6znogRxDWLPPkIGwEkJCAMJZflVQsNVKB0qaf2Z68gR/bVcPyb13cC5vi5r2xih0yC0Qg8vGnM2VvIbIzHVtBXdyO/hE5Te9IB5THZOQSwxUaoVJjXp2DKWyrnmpS30Bn6KhsGdCeLk4cbuTmecKYo79WRKqJ/iyn38ce8Redj19rv2m48PVC1ldxvAGhybH/px9NrFb/cJnGYK+oVnlxG39Sqd8PWxC2ntTnenbEHxxQTySm+MKcN8FthvP5CA+HBJeu2HC5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1257.namprd12.prod.outlook.com (10.168.237.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 09:07:30 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2408.028; Fri, 8 Nov 2019
 09:07:30 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Thread-Topic: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Thread-Index: AQHVlVW9lxWirD8xeEyV09j5nQhNc6d/kjUAgAD+17CAAGgEQIAABCMA
Date: Fri, 8 Nov 2019 09:07:30 +0000
Message-ID: <c01acb29-72ce-a109-3ca5-166706327d61@amd.com>
References: <1573122349-22080-1-git-send-email-Emily.Deng@amd.com>
 <9de32e5b-69a2-f43f-629f-fef3c30bf5a1@gmail.com>
 <MN2PR12MB2975D4E26CED960B82305F308F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <MN2PR12MB2975E26D8A8352863BA01FCA8F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB2975E26D8A8352863BA01FCA8F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR02CA0061.eurprd02.prod.outlook.com
 (2603:10a6:208:d2::38) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 549fffce-7716-49c3-8c9d-08d7642b159a
x-ms-traffictypediagnostic: DM5PR12MB1257:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB125736D45A8C01E9D7117FA5837B0@DM5PR12MB1257.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(13464003)(189003)(199004)(81156014)(81166006)(99286004)(71200400001)(256004)(7736002)(186003)(65806001)(2906002)(25786009)(36756003)(476003)(2501003)(966005)(8676002)(14454004)(65956001)(86362001)(31696002)(8936002)(110136005)(46003)(486006)(386003)(6506007)(6116002)(53546011)(102836004)(11346002)(58126008)(478600001)(316002)(71190400001)(6246003)(6436002)(14444005)(66946007)(66556008)(52116002)(305945005)(66446008)(64756008)(2616005)(446003)(66476007)(76176011)(66574012)(229853002)(31686004)(6512007)(5660300002)(6306002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1257;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f6wErsvr1em9jZ4cLriSALoXZ+mbYQ4TMSdHitCU8ivALkLjlbs5gYCHQ/hA4TcS+oK/ctEksq5bFpogoApZ4CWkQW9c1lK6LfzJkXuEyrBn9U/rf3GSsaveAZGEgOoV0RNErWDyhpavqDHZy8ZuRFqeEcGPwUZmfQeDl2WMqqhah90UFkrZctyCso6c/2WwHN8715ZoX1bNCcgFvsPGULfo2TR4zqsYn8Et4shokQbvtaj+rhOWVJ8exi22LTFAL2GvuOgVD4/QSK5isS62Kw9g3kpp2gHIftxhnKfRILw43Uj9EWoXrTvgahy3surhZgMlXlSs+2LzEaJr/F/mqQCOmRMam++0MB698ie/X6k7K2kRanNG0n+hHkb6MNf20QMS5+6fazLwECcrBzTs2zmmt15cbPfKFNjGMVdezD/aNBqqTZYpmuI77eLAjeP4pEzCU7p+tHko9hIR5Cy7rov6vICSyzqG3djYDJI0CCw=
Content-ID: <4C999FE3AADE6D42858DD1DFFEE10C8B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549fffce-7716-49c3-8c9d-08d7642b159a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 09:07:30.6495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bow38YzbbhIxZmLLk6I9CoTKdNvEY99hNWbHvYfHAJoet2EOw4eN7PbelPhaU59f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1257
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMA0J6vHwZEzrqd1zXH3HD7UkhZzZDxrsGgpfKvUl8Y=;
 b=cdoalIoSqUjm6Lgj4rC0wThVbzjko9LD3xCAif8047U/YvXB0wgyXkwEUSxfB8MChm+xI6gripQOYkYB3xAnOr33Ch7j6ReD04Pq1bzjAWVyYn5Q+ua3OQ90LczN61RpLkFdES+2ZvfFWWamm07uK201G9dWYQktObxlvXI/+YE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Message-ID: <20191108090730.67YOrQZMyZrCW-5pc2xl2jHkIZw80eoDxQ5FCKCKy44@z>

QW0gMDguMTEuMTkgdW0gMDk6NTIgc2NocmllYiBEZW5nLCBFbWlseToNCj4gUGluZy4uLi4uDQoN
CllvdSBuZWVkIHRvIGdpdmUgbWUgYXQgbGVhc3QgZW5vdWdoIHRpbWUgdG8gd2FrZSB1cCA6KQ0K
DQo+DQo+DQo+IEJlc3Qgd2lzaGVzDQo+IEVtaWx5IERlbmcNCj4NCj4NCj4NCj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgRGVuZywNCj4+IEVtaWx5DQo+PiBTZW50
OiBGcmlkYXksIE5vdmVtYmVyIDgsIDIwMTkgMTA6NTYgQU0NCj4+IFRvOiBLb2VuaWcsIENocmlz
dGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgYW1kLQ0KPj4gZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IHRoZSBu
dWxsIHBvaW50ZXIgaXNzdWUgZm9yIHRkcg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5A
Z21haWwuY29tPg0KPj4+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA3LCAyMDE5IDc6MjggUE0N
Cj4+PiBUbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4
IHRoZSBudWxsIHBvaW50ZXIgaXNzdWUgZm9yIHRkcg0KPj4+DQo+Pj4gQW0gMDcuMTEuMTkgdW0g
MTE6MjUgc2NocmllYiBFbWlseSBEZW5nOg0KPj4+PiBXaGVuIHRoZSBqb2IgaXMgYWxyZWFkeSBz
aWduYWxlZCwgdGhlIHNfZmVuY2UgaXMgZnJlZWQuIFRoZW4gaXQgd2lsbA0KPj4+PiBoYXMgbnVs
bCBwb2ludGVyIGluIGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIuDQo+Pj4gTkFLLCB0aGUgc19m
ZW5jZSBpcyBvbmx5IHNldCB0byBOVUxMIHdoZW4gdGhlIGpvYiBpcyBkZXN0cm95ZWQuIFNlZQ0K
Pj4+IGRybV9zY2hlZF9qb2JfY2xlYW51cCgpLg0KPj4gSSBrbm93IGl0IGlzIHNldCB0byBOVUxM
IGluIGRybV9zY2hlZF9qb2JfY2xlYW51cC4gQnV0IGluIG9uZSBjYXNlLCB3aGVuIGl0DQo+PiBl
bnRlciBpbnRvIHRoZSBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyLCBpdCBhbHJlYWR5IGluDQo+
PiBkcm1fc2NoZWRfam9iX2NsZWFudXAsIGFuZCBhdCB0aGlzIHRpbWUsIGl0IHdpbGwgZ28gdG8g
ZnJlZSBqb2IuIEJ1dCB0aGUNCj4+IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIgc29tZXRpbWVz
IGlzIGZhc3Rlci4gQXQgdGhhdCB0aW1lLCBqb2IgaXMgbm90DQo+PiBmcmVlZCwgYnV0IHNfZmVu
Y2UgaXMgYWxyZWFkeSBOVUxMLg0KDQpObywgdGhhdCBjYXNlIGNhbid0IGhhcHBlbi4gU2VlIGhl
cmU6DQoNCj4gwqDCoMKgwqDCoMKgwqAgZHJtX3NjaGVkX2pvYl9jbGVhbnVwKHNfam9iKTsNCj4N
Cj4gwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3JpbmdfcHJpb3JpdHlfcHV0KHJpbmcsIHNfam9iLT5z
X3ByaW9yaXR5KTsNCj4gwqDCoMKgwqDCoMKgwqAgZG1hX2ZlbmNlX3B1dChqb2ItPmZlbmNlKTsN
Cj4gwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3N5bmNfZnJlZSgmam9iLT5zeW5jKTsNCj4gwqDCoMKg
wqDCoMKgwqAgYW1kZ3B1X3N5bmNfZnJlZSgmam9iLT5zY2hlZF9zeW5jKTsNCj4gwqDCoMKgwqDC
oMKgwqAga2ZyZWUoam9iKTsNCg0KVGhlIGpvYiBpdHNlbGYgaXMgZnJlZWQgdXAgZGlyZWN0bHkg
YWZ0ZXIgZnJlZWluZyB0aGUgcmVmZXJlbmNlIHRvIHRoZSANCnNfZmVuY2UuDQoNClNvIHlvdSBh
cmUganVzdCBwYXBlcmluZyBvdmVyIGEgbXVjaCBiaWdnZXIgcHJvYmxlbSBoZXJlLiBUaGlzIHBh
dGNoIGlzIA0KYSBjbGVhciBOQUsuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4+PiBXaGVu
IHlvdSBzZWUgYSBqb2Igd2l0aG91dCBhbiBzX2ZlbmNlIHRoZW4gdGhhdCBtZWFucyB0aGUgcHJv
YmxlbSBpcw0KPj4+IHNvbWV3aGVyZSBlbHNlLg0KPj4+DQo+Pj4gUmVnYXJkcywNCj4+PiBDaHJp
c3RpYW4uDQo+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0Bh
bWQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgIDIgKy0NCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9z
Y2hlZF9tYWluLmMgICAgIHwgMTEgKysrKysrLS0tLS0NCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4gaW5kZXggZTZjZTk0
OS4uNWE4ZjA4ZSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYw0KPj4+PiBAQCAtNDA3NSw3ICs0MDc1LDcgQEAgaW50IGFtZGdwdV9kZXZp
Y2VfZ3B1X3JlY292ZXIoc3RydWN0DQo+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+Pj4gICAg
CSAqDQo+Pj4+ICAgIAkgKiBqb2ItPmJhc2UgaG9sZHMgYSByZWZlcmVuY2UgdG8gcGFyZW50IGZl
bmNlDQo+Pj4+ICAgIAkgKi8NCj4+Pj4gLQlpZiAoam9iICYmIGpvYi0+YmFzZS5zX2ZlbmNlLT5w
YXJlbnQgJiYNCj4+Pj4gKwlpZiAoam9iICYmIGpvYi0+YmFzZS5zX2ZlbmNlICYmIGpvYi0+YmFz
ZS5zX2ZlbmNlLT5wYXJlbnQgJiYNCj4+Pj4gICAgCSAgICBkbWFfZmVuY2VfaXNfc2lnbmFsZWQo
am9iLT5iYXNlLnNfZmVuY2UtPnBhcmVudCkpDQo+Pj4+ICAgIAkJam9iX3NpZ25hbGVkID0gdHJ1
ZTsNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfbWFpbi5jDQo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMN
Cj4+Pj4gaW5kZXggMzE4MDljYS4uNTZjYzEwZSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9tYWluLmMNCj4+Pj4gQEAgLTMzNCw4ICszMzQsOCBAQCB2b2lkIGRy
bV9zY2hlZF9pbmNyZWFzZV9rYXJtYShzdHJ1Y3QNCj4+PiBkcm1fc2NoZWRfam9iDQo+Pj4+ICpi
YWQpDQo+Pj4+DQo+Pj4+ICAgIAkJCXNwaW5fbG9jaygmcnEtPmxvY2spOw0KPj4+PiAgICAJCQls
aXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZW50aXR5LCB0bXAsICZycS0+ZW50aXRpZXMsDQo+Pj4g
bGlzdCkgew0KPj4+PiAtCQkJCWlmIChiYWQtPnNfZmVuY2UtPnNjaGVkdWxlZC5jb250ZXh0ID09
DQo+Pj4+IC0JCQkJICAgIGVudGl0eS0+ZmVuY2VfY29udGV4dCkgew0KPj4+PiArCQkJCWlmIChi
YWQtPnNfZmVuY2UgJiYgKGJhZC0+c19mZW5jZS0NCj4+Pj4gc2NoZWR1bGVkLmNvbnRleHQgPT0N
Cj4+Pj4gKwkJCQkgICAgZW50aXR5LT5mZW5jZV9jb250ZXh0KSkgew0KPj4+PiAgICAJCQkJCWlm
IChhdG9taWNfcmVhZCgmYmFkLT5rYXJtYSkgPg0KPj4+PiAgICAJCQkJCSAgICBiYWQtPnNjaGVk
LT5oYW5nX2xpbWl0KQ0KPj4+PiAgICAJCQkJCQlpZiAoZW50aXR5LT5ndWlsdHkpDQo+Pj4+IEBA
IC0zNzYsNyArMzc2LDcgQEAgdm9pZCBkcm1fc2NoZWRfc3RvcChzdHJ1Y3QgZHJtX2dwdV9zY2hl
ZHVsZXINCj4+PiAqc2NoZWQsIHN0cnVjdCBkcm1fc2NoZWRfam9iICpiYWQpDQo+Pj4+ICAgIAkg
KiBUaGlzIGl0ZXJhdGlvbiBpcyB0aHJlYWQgc2FmZSBhcyBzY2hlZCB0aHJlYWQgaXMgc3RvcHBl
ZC4NCj4+Pj4gICAgCSAqLw0KPj4+PiAgICAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlX3JldmVy
c2Uoc19qb2IsIHRtcCwgJnNjaGVkLQ0KPj4+PiByaW5nX21pcnJvcl9saXN0LCBub2RlKSB7DQo+
Pj4+IC0JCWlmIChzX2pvYi0+c19mZW5jZS0+cGFyZW50ICYmDQo+Pj4+ICsJCWlmIChzX2pvYi0+
c19mZW5jZSAmJiBzX2pvYi0+c19mZW5jZS0+cGFyZW50ICYmDQo+Pj4+ICAgIAkJICAgIGRtYV9m
ZW5jZV9yZW1vdmVfY2FsbGJhY2soc19qb2ItPnNfZmVuY2UtPnBhcmVudCwNCj4+Pj4gICAgCQkJ
CQkgICAgICAmc19qb2ItPmNiKSkgew0KPj4+PiAgICAJCQlhdG9taWNfZGVjKCZzY2hlZC0+aHdf
cnFfY291bnQpOyBAQCAtMzk1LDcNCj4+ICszOTUsOCBAQCB2b2lkDQo+Pj4+IGRybV9zY2hlZF9z
dG9wKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlcg0KPj4+ICpzY2hlZCwgc3RydWN0IGRybV9zY2hl
ZF9qb2IgKmJhZCkNCj4+Pj4gICAgCQkJICoNCj4+Pj4gICAgCQkJICogSm9iIGlzIHN0aWxsIGFs
aXZlIHNvIGZlbmNlIHJlZmNvdW50IGF0IGxlYXN0IDENCj4+Pj4gICAgCQkJICovDQo+Pj4+IC0J
CQlkbWFfZmVuY2Vfd2FpdCgmc19qb2ItPnNfZmVuY2UtPmZpbmlzaGVkLCBmYWxzZSk7DQo+Pj4+
ICsJCQlpZiAoc19qb2ItPnNfZmVuY2UpDQo+Pj4+ICsJCQkJZG1hX2ZlbmNlX3dhaXQoJnNfam9i
LT5zX2ZlbmNlLT5maW5pc2hlZCwNCj4+PiBmYWxzZSk7DQo+Pj4+ICAgIAkJCS8qDQo+Pj4+ICAg
IAkJCSAqIFdlIG11c3Qga2VlcCBiYWQgam9iIGFsaXZlIGZvciBsYXRlciB1c2UgZHVyaW5nIEBA
DQo+Pj4gLTQzOCw3DQo+Pj4+ICs0MzksNyBAQCB2b2lkIGRybV9zY2hlZF9zdGFydChzdHJ1Y3Qg
ZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkLCBib29sDQo+Pj4gZnVsbF9yZWNvdmVyeSkNCj4+Pj4g
ICAgCSAqIEdQVSByZWNvdmVycyBjYW4ndCBydW4gaW4gcGFyYWxsZWwuDQo+Pj4+ICAgIAkgKi8N
Cj4+Pj4gICAgCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShzX2pvYiwgdG1wLCAmc2NoZWQtPnJp
bmdfbWlycm9yX2xpc3QsDQo+Pj4+IG5vZGUpDQo+Pj4gew0KPj4+PiAtCQlzdHJ1Y3QgZG1hX2Zl
bmNlICpmZW5jZSA9IHNfam9iLT5zX2ZlbmNlLT5wYXJlbnQ7DQo+Pj4+ICsJCXN0cnVjdCBkbWFf
ZmVuY2UgKmZlbmNlID0gc19qb2ItPnNfZmVuY2UgPyBzX2pvYi0+c19mZW5jZS0NCj4+Pj4gcGFy
ZW50IDoNCj4+Pj4gK05VTEw7DQo+Pj4+DQo+Pj4+ICAgIAkJYXRvbWljX2luYygmc2NoZWQtPmh3
X3JxX2NvdW50KTsNCj4+Pj4NCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
