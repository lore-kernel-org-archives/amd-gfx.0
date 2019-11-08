Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B6C5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 08:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA49214DA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 08:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA49214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E218D6F8B1;
	Fri,  8 Nov 2019 08:52:50 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720054.outbound.protection.outlook.com [40.107.72.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5A16F8B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 08:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF6UuAOySIqlYmV+gEhWSeJ+O7Zkk7OotQkEVpxRnDOVmE/e4emxuyFuMnMoJzqYflvupXe698/tlb/hzYOz4RKpG+X0XgiaN51wDSmSINDNNXwO29JmDhQ55WMe0tDQWNvkttnMCgsd91dKD+4Z6MTLsfdg4Kc/42yWETipAbtBYPUiklGU5wv3V/sg+87I+fABUkRWVCm4Vqx9xpXqnyIwHMBN36wCXSA4PXfljor4CISC7iPZZm8jrinhxUkYKQuEi+wSZgW/8yimbfzp9Uyr5caCJmncPCXvM9JaBt+g7AJzLqXgv9aP2CVANG9dD5SMLAn5pYGc598cp5R5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PnthkPdQtEgltdPooaur0XrAsMecQTtOaxgGcnC1wc=;
 b=JoHXE9nJDzvCbVSHSdsp/dM+5y+sOdcRiWACurjdODVHGVeAsfWTpAzvN3hxnceb+J8uwZBODqeaTYoeLYoOIk2n7zc5nAf4NN0oN6LG1NlSuIMfxf3SOw1dm5Crs8IzcIg8qPxPu0IWYdukKA71CZ+xbocOx9hcVWWutbngCtGiNDsEnJxJe3jLeDXOzZ5I7rRfqjgg2CRUlyr+Oek4XCwcl5zHWc1uwWhmC/wewYGahSZePtc3Id7fKDy3nxv6Qyc66ckRinPQrYoDs+dR2pritVu0oaC97Av3oo4sslZMWr6j0+Fk0PzCpK0ecfptVvyzBXKEpzOZUntRMSKC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3840.namprd12.prod.outlook.com (10.255.239.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 08:52:48 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7%7]) with mapi id 15.20.2408.028; Fri, 8 Nov 2019
 08:52:48 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Thread-Topic: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Thread-Index: AQHVlVW9lxWirD8xeEyV09j5nQhNc6d/kjUAgAD+17CAAGgEQA==
Date: Fri, 8 Nov 2019 08:52:48 +0000
Message-ID:
 <MN2PR12MB2975E26D8A8352863BA01FCA8F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1573122349-22080-1-git-send-email-Emily.Deng@amd.com>
 <9de32e5b-69a2-f43f-629f-fef3c30bf5a1@gmail.com>
 <MN2PR12MB2975D4E26CED960B82305F308F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB2975D4E26CED960B82305F308F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e595b937-251c-4ec8-7351-08d7642907e2
x-ms-traffictypediagnostic: MN2PR12MB3840:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38404B2D31FC1B4C170975788F7B0@MN2PR12MB3840.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(13464003)(86362001)(99286004)(81156014)(81166006)(476003)(66946007)(66446008)(76116006)(64756008)(66556008)(66476007)(110136005)(25786009)(8936002)(2501003)(11346002)(76176011)(52536014)(74316002)(316002)(305945005)(8676002)(2940100002)(486006)(7736002)(7696005)(66066001)(229853002)(6436002)(5660300002)(6306002)(55016002)(33656002)(9686003)(446003)(478600001)(6246003)(26005)(256004)(2906002)(6116002)(3846002)(71190400001)(71200400001)(6506007)(14444005)(102836004)(14454004)(186003)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3840;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FlNBMYGCbUL6nZDDNAD3gdcl3JZQYv3tfHhdKIDrTUsPzwdleuKIL7r5d2VOvC6L4Skmlor3dF9JNazPiJ1zq9t/6xsGwJIM5Xvg9frqzD9cj4RSivrsM8DDw/KMBrCR18rJHhVWE9SSi3B6/ssJU03dUG9o7YCX4MMcRi5o2OWuQp1bfp3ZXRlAmvDxJcX8FwxzxmPXXLaz5cSmg0mXeOatItTEqTn/vQJbk/eh1rYXq0emioORHcYYBXPulYgSpNHVk8qSmJRU7vY4GZ1Rt/R8qt2dbk0Q2eAUYzD9Pc2tf1iBFh6BFqiFdZEe8mftkn4iRd1zbyXH2A072l/HqvZ845tekMNm+PVEuS50Ip/XcRvX3l/RPeGQawClXOV2dqLVdQpK1dXM6UcoRZ7rky8eS/WX3mQoBAPnl4sdd6qUC+R6pnxZe9frl79nh9eEc51e8R7ov/4/72UovselEthBBhQfpcsqt325F1VT0qw=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e595b937-251c-4ec8-7351-08d7642907e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 08:52:48.4312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpUzTcdv6rjl47nMV6N0yfKT7rDtposnXmw8165nNK/bDTVY2A2cpRJLckNGAkqa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3840
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PnthkPdQtEgltdPooaur0XrAsMecQTtOaxgGcnC1wc=;
 b=s6RCZJAgPk97jZcJ2bDRlUh54aE7nuv372xUGoAwnM58DmZjVTIkY/dW9SIxSNAIwFlun79SChp32yFel+xJ/XIWXeHWnzIu91uuBFu0O8ItocJMquzl8S9EqG+pm09mPNR5umJ5PRQy1mjA5K7XPwl8FVUvELv43HCADuQuvIg=
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
Message-ID: <20191108085248.p89GjQb6lZVu1jErB8FsEas_0WmokMRh_86LHs_huew@z>

UGluZy4uLi4uDQoNCg0KQmVzdCB3aXNoZXMNCkVtaWx5IERlbmcNCg0KDQoNCj4tLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5m
cmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBEZW5nLA0KPkVtaWx5DQo+U2VudDogRnJpZGF5
LCBOb3ZlbWJlciA4LCAyMDE5IDEwOjU2IEFNDQo+VG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+OyBhbWQtDQo+Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PlN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCB0aGUgbnVsbCBwb2ludGVyIGlz
c3VlIGZvciB0ZHINCj4NCj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+RnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+PlNlbnQ6
IFRodXJzZGF5LCBOb3ZlbWJlciA3LCAyMDE5IDc6MjggUE0NCj4+VG86IERlbmcsIEVtaWx5IDxF
bWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj5TdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggdGhlIG51bGwgcG9pbnRlciBpc3N1ZSBm
b3IgdGRyDQo+Pg0KPj5BbSAwNy4xMS4xOSB1bSAxMToyNSBzY2hyaWViIEVtaWx5IERlbmc6DQo+
Pj4gV2hlbiB0aGUgam9iIGlzIGFscmVhZHkgc2lnbmFsZWQsIHRoZSBzX2ZlbmNlIGlzIGZyZWVk
LiBUaGVuIGl0IHdpbGwNCj4+PiBoYXMgbnVsbCBwb2ludGVyIGluIGFtZGdwdV9kZXZpY2VfZ3B1
X3JlY292ZXIuDQo+Pg0KPj5OQUssIHRoZSBzX2ZlbmNlIGlzIG9ubHkgc2V0IHRvIE5VTEwgd2hl
biB0aGUgam9iIGlzIGRlc3Ryb3llZC4gU2VlDQo+PmRybV9zY2hlZF9qb2JfY2xlYW51cCgpLg0K
Pkkga25vdyBpdCBpcyBzZXQgdG8gTlVMTCBpbiBkcm1fc2NoZWRfam9iX2NsZWFudXAuIEJ1dCBp
biBvbmUgY2FzZSwgd2hlbiBpdA0KPmVudGVyIGludG8gdGhlIGFtZGdwdV9kZXZpY2VfZ3B1X3Jl
Y292ZXIsIGl0IGFscmVhZHkgaW4NCj5kcm1fc2NoZWRfam9iX2NsZWFudXAsIGFuZCBhdCB0aGlz
IHRpbWUsIGl0IHdpbGwgZ28gdG8gZnJlZSBqb2IuIEJ1dCB0aGUNCj5hbWRncHVfZGV2aWNlX2dw
dV9yZWNvdmVyIHNvbWV0aW1lcyBpcyBmYXN0ZXIuIEF0IHRoYXQgdGltZSwgam9iIGlzIG5vdA0K
PmZyZWVkLCBidXQgc19mZW5jZSBpcyBhbHJlYWR5IE5VTEwuDQo+Pg0KPj5XaGVuIHlvdSBzZWUg
YSBqb2Igd2l0aG91dCBhbiBzX2ZlbmNlIHRoZW4gdGhhdCBtZWFucyB0aGUgcHJvYmxlbSBpcw0K
Pj5zb21ld2hlcmUgZWxzZS4NCj4+DQo+PlJlZ2FyZHMsDQo+PkNocmlzdGlhbi4NCj4+DQo+Pj4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+DQo+Pj4g
LS0tDQo+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAg
MiArLQ0KPj4+ICAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgICAgIHwg
MTEgKysrKysrLS0tLS0NCj4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+Pj4gaW5kZXggZTZjZTk0OS4uNWE4ZjA4ZSAxMDA2NDQNCj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+PiBAQCAtNDA3
NSw3ICs0MDc1LDcgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0DQo+PmFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+Pj4gICAJICoNCj4+PiAgIAkgKiBqb2ItPmJhc2UgaG9sZHMg
YSByZWZlcmVuY2UgdG8gcGFyZW50IGZlbmNlDQo+Pj4gICAJICovDQo+Pj4gLQlpZiAoam9iICYm
IGpvYi0+YmFzZS5zX2ZlbmNlLT5wYXJlbnQgJiYNCj4+PiArCWlmIChqb2IgJiYgam9iLT5iYXNl
LnNfZmVuY2UgJiYgam9iLT5iYXNlLnNfZmVuY2UtPnBhcmVudCAmJg0KPj4+ICAgCSAgICBkbWFf
ZmVuY2VfaXNfc2lnbmFsZWQoam9iLT5iYXNlLnNfZmVuY2UtPnBhcmVudCkpDQo+Pj4gICAJCWpv
Yl9zaWduYWxlZCA9IHRydWU7DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9tYWluLmMNCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIv
c2NoZWRfbWFpbi5jDQo+Pj4gaW5kZXggMzE4MDljYS4uNTZjYzEwZSAxMDA2NDQNCj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYw0KPj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jDQo+Pj4gQEAgLTMzNCw4ICszMzQsOCBA
QCB2b2lkIGRybV9zY2hlZF9pbmNyZWFzZV9rYXJtYShzdHJ1Y3QNCj4+ZHJtX3NjaGVkX2pvYg0K
Pj4+ICpiYWQpDQo+Pj4NCj4+PiAgIAkJCXNwaW5fbG9jaygmcnEtPmxvY2spOw0KPj4+ICAgCQkJ
bGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGVudGl0eSwgdG1wLCAmcnEtPmVudGl0aWVzLA0KPj5s
aXN0KSB7DQo+Pj4gLQkJCQlpZiAoYmFkLT5zX2ZlbmNlLT5zY2hlZHVsZWQuY29udGV4dCA9PQ0K
Pj4+IC0JCQkJICAgIGVudGl0eS0+ZmVuY2VfY29udGV4dCkgew0KPj4+ICsJCQkJaWYgKGJhZC0+
c19mZW5jZSAmJiAoYmFkLT5zX2ZlbmNlLQ0KPj4+c2NoZWR1bGVkLmNvbnRleHQgPT0NCj4+PiAr
CQkJCSAgICBlbnRpdHktPmZlbmNlX2NvbnRleHQpKSB7DQo+Pj4gICAJCQkJCWlmIChhdG9taWNf
cmVhZCgmYmFkLT5rYXJtYSkgPg0KPj4+ICAgCQkJCQkgICAgYmFkLT5zY2hlZC0+aGFuZ19saW1p
dCkNCj4+PiAgIAkJCQkJCWlmIChlbnRpdHktPmd1aWx0eSkNCj4+PiBAQCAtMzc2LDcgKzM3Niw3
IEBAIHZvaWQgZHJtX3NjaGVkX3N0b3Aoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyDQo+PipzY2hl
ZCwgc3RydWN0IGRybV9zY2hlZF9qb2IgKmJhZCkNCj4+PiAgIAkgKiBUaGlzIGl0ZXJhdGlvbiBp
cyB0aHJlYWQgc2FmZSBhcyBzY2hlZCB0aHJlYWQgaXMgc3RvcHBlZC4NCj4+PiAgIAkgKi8NCj4+
PiAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmVfcmV2ZXJzZShzX2pvYiwgdG1wLCAmc2NoZWQt
DQo+Pj5yaW5nX21pcnJvcl9saXN0LCBub2RlKSB7DQo+Pj4gLQkJaWYgKHNfam9iLT5zX2ZlbmNl
LT5wYXJlbnQgJiYNCj4+PiArCQlpZiAoc19qb2ItPnNfZmVuY2UgJiYgc19qb2ItPnNfZmVuY2Ut
PnBhcmVudCAmJg0KPj4+ICAgCQkgICAgZG1hX2ZlbmNlX3JlbW92ZV9jYWxsYmFjayhzX2pvYi0+
c19mZW5jZS0+cGFyZW50LA0KPj4+ICAgCQkJCQkgICAgICAmc19qb2ItPmNiKSkgew0KPj4+ICAg
CQkJYXRvbWljX2RlYygmc2NoZWQtPmh3X3JxX2NvdW50KTsgQEAgLTM5NSw3DQo+KzM5NSw4IEBA
IHZvaWQNCj4+PiBkcm1fc2NoZWRfc3RvcChzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXINCj4+KnNj
aGVkLCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFkKQ0KPj4+ICAgCQkJICoNCj4+PiAgIAkJCSAq
IEpvYiBpcyBzdGlsbCBhbGl2ZSBzbyBmZW5jZSByZWZjb3VudCBhdCBsZWFzdCAxDQo+Pj4gICAJ
CQkgKi8NCj4+PiAtCQkJZG1hX2ZlbmNlX3dhaXQoJnNfam9iLT5zX2ZlbmNlLT5maW5pc2hlZCwg
ZmFsc2UpOw0KPj4+ICsJCQlpZiAoc19qb2ItPnNfZmVuY2UpDQo+Pj4gKwkJCQlkbWFfZmVuY2Vf
d2FpdCgmc19qb2ItPnNfZmVuY2UtPmZpbmlzaGVkLA0KPj5mYWxzZSk7DQo+Pj4NCj4+PiAgIAkJ
CS8qDQo+Pj4gICAJCQkgKiBXZSBtdXN0IGtlZXAgYmFkIGpvYiBhbGl2ZSBmb3IgbGF0ZXIgdXNl
IGR1cmluZyBAQA0KPj4tNDM4LDcNCj4+PiArNDM5LDcgQEAgdm9pZCBkcm1fc2NoZWRfc3RhcnQo
c3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCwgYm9vbA0KPj5mdWxsX3JlY292ZXJ5KQ0K
Pj4+ICAgCSAqIEdQVSByZWNvdmVycyBjYW4ndCBydW4gaW4gcGFyYWxsZWwuDQo+Pj4gICAJICov
DQo+Pj4gICAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHNfam9iLCB0bXAsICZzY2hlZC0+cmlu
Z19taXJyb3JfbGlzdCwNCj4+PiBub2RlKQ0KPj57DQo+Pj4gLQkJc3RydWN0IGRtYV9mZW5jZSAq
ZmVuY2UgPSBzX2pvYi0+c19mZW5jZS0+cGFyZW50Ow0KPj4+ICsJCXN0cnVjdCBkbWFfZmVuY2Ug
KmZlbmNlID0gc19qb2ItPnNfZmVuY2UgPyBzX2pvYi0+c19mZW5jZS0NCj4+PnBhcmVudCA6DQo+
Pj4gK05VTEw7DQo+Pj4NCj4+PiAgIAkJYXRvbWljX2luYygmc2NoZWQtPmh3X3JxX2NvdW50KTsN
Cj4+Pg0KPg0KPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+YW1kLWdmeCBtYWlsaW5nIGxpc3QNCj5hbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
Pmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
