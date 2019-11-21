Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C0C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 01:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D8620730
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 01:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D8620730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD6F6EAAF;
	Thu, 21 Nov 2019 01:43:27 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690057.outbound.protection.outlook.com [40.107.69.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF526EAAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 01:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6JScuroeIbMhG+7/JTAXoWv5Bc3WjIjH2PUn6Fss88wvZ5WQrtnm9c6pGCDnL5IooSbmklmvLLqOijxxlUvwO7jYeWCyAU+wK2KDjcp6REpHZUuR88rCeWKiem0Km0/n+6xaY8wUzl45yvWrz4vEFM34nK6KgMS7GztqtKEC487D/39OXRw18bFWVgw35iLor3b4E6I/WOc1wFXZRPdQ1rON3moGPMypCNXPmN7hQaQ0LYYuCOeqzEckgWPWWzVgMmklK8/oU25CMe7+NkNDNXrrZ7oduTO0YFTRKgmEflGzx7caF/XFDk/Y9QcKirU2djqDymoXPlQg5UldrR6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGevDaLbQf/Kl2Y8p9vKUaiemKVhWhvJ3pfHY7VSjI4=;
 b=OEP1zfNgY2sA1R6cdPgJKhXl4YGELg8gvsx0zzBNicRgm6S0A+Dx+SdCE6BeVDH7qQIAU2PRG91eDOEITVQmj/sqpdlztZtKbepJkzjeAK8wEuX1WAeSqRoCqfqGnYbRKxRNbOumxRwYyQDTA2EXE72Lp+6wU8soSYR+sCy/s8RWeP9LkbtFCdUSR/nalacCnx0GZu0yDvzM/vild8VjqHajENt1yYGy2SOzEZh9iytU7XoREU3jVFvU+8tfJlLr/+JfHXwGXN0CsuBohueVOGyMkLhXz5DKxznyBHcgZtMvJI+GP9dBJryraVQ/+miaG4TbbcvF5IB+vLGGjFzNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3520.namprd12.prod.outlook.com (20.179.82.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Thu, 21 Nov 2019 01:43:22 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 01:43:22 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify runtime suspend
Thread-Topic: [PATCH] drm/amdgpu: simplify runtime suspend
Thread-Index: AQHVn9fxFcga3nWQAECnrDt1xfeRIaeU2j/Q
Date: Thu, 21 Nov 2019 01:43:22 +0000
Message-ID:
 <MN2PR12MB3344CC2D3F040D7A0212B620E44E0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191120192253.1299713-1-alexander.deucher@amd.com>
In-Reply-To: <20191120192253.1299713-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83fb78c4-8554-432d-4fd4-08d76e243173
x-ms-traffictypediagnostic: MN2PR12MB3520:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35200C4B57C6D937C5729DA8E44E0@MN2PR12MB3520.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(39840400004)(346002)(376002)(13464003)(199004)(189003)(110136005)(81166006)(86362001)(71200400001)(71190400001)(6436002)(26005)(53546011)(6306002)(9686003)(102836004)(76176011)(6506007)(478600001)(99286004)(55016002)(7696005)(966005)(14454004)(14444005)(52536014)(33656002)(305945005)(15650500001)(7736002)(64756008)(66476007)(66446008)(229853002)(66556008)(8676002)(256004)(6116002)(2906002)(3846002)(74316002)(66946007)(8936002)(5660300002)(2501003)(446003)(11346002)(25786009)(4326008)(476003)(486006)(316002)(66066001)(6246003)(186003)(81156014)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3520;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EdPq2AHp06WOMWxnu/UmPqapXvcrpmmp+fSQLvVW3BRhrUqDPfsUPxYcXxFuT2LJ6C5bOMDRQdtLMijKVtVEIFMysx/oZimpTcsJfbLLvCoaZ2z+1xNlGE2vqF7FNYYTQYCC4H9tRrVdb/gFd5J9wgQpc74Iuj/8eNBlQJujE8b14f3ZnG/MJNVxTmeqhTtnwZLPkgq14DUsaj5ZfM8S6BocJF+GP77SXOopv+pwx0ShuP6tnn9vWs+y65jj5hl/Lov9mo/T0YuDyHII2vn8eawvDkCPHOE0xiVhWPdD3QbX6ObA8wlkP92xe0k4eM+Dq5nif6XWUIpz2erGb9wLhcgji7fgZxEKrCdtGrMRVlBzBmxSP6ztmiE+vRNoS0LUQqfl2a0UFmUDW077x3i4mGClRt7LujBYgo1KUso37qvNHaHkaJ1MWswuK6T6xviJD/QBugIsOUeSfqDXtZzMIHaR16S572jt6LlC5G2I7RA=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fb78c4-8554-432d-4fd4-08d76e243173
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 01:43:22.2124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cf3n/aIYghgMWcEAg+Xq37fp7iCx405727ww+1dcByfj33Xo4NMtAPQ548fXRmdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3520
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGevDaLbQf/Kl2Y8p9vKUaiemKVhWhvJ3pfHY7VSjI4=;
 b=S2+vxJSa0HVdxQEyXYZACl0Yp0RuK2bnzX8qiFwVf+PJGSFY7GS5kkSUTO6MiVJcAAV5dAN1X3FqRWxUAs+itqbMY9mlhra3c8KuwoJtK/7c6ipic0gbtevy9SQUEoP5wXThEpB2dJx+g9BMm0X5N/a5gQOp67e7isGCk1WEQcQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121014322.ZfGBAMYIJuRsJTPeCwimr3b4b-Ra7DXGxllMeQFytlI@z>

QWNrZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBUaHVy
c2RheSwgTm92ZW1iZXIgMjEsIDIwMTkgMzoyMyBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBzaW1wbGlmeSBydW50aW1l
IHN1c3BlbmQNCj4gDQo+IEluIHRoZSBzdGFuZGFyZCBfUFIzIGNhc2UsIHRoZSBwY2kgY29yZSBo
YW5kbGVzIHRoZSBwY2kgc3RhdGUuDQo+IFRoZSBkcml2ZXIgb25seSBuZWVkcyB0byBoYW5kbGUg
aXQgaW4gdGhlIGxlZ2FjeSBBVFBYIGNhc2UuDQo+IA0KPiBUaGlzIG1heSBmaXggaXNzdWVzIHdp
dGggcnVudGltZSBzdXNwZW5kL3Jlc3VtZSBvbiBjZXJ0YWluDQo+IGh5YnJpZCBncmFwaGljcyBs
YXB0b3BzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYyB8IDM1ICsrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gaW5kZXggZWE3NjNiYzViMjMzLi5kZjJmNDcy
MGEyZjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
cnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4g
QEAgLTEyMjcsMTMgKzEyMjcsMTcgQEAgc3RhdGljIGludCBhbWRncHVfcG1vcHNfcnVudGltZV9z
dXNwZW5kKHN0cnVjdA0KPiBkZXZpY2UgKmRldikNCj4gDQo+ICAJcmV0ID0gYW1kZ3B1X2Rldmlj
ZV9zdXNwZW5kKGRybV9kZXYsIGZhbHNlLCBmYWxzZSk7DQo+ICAJaWYgKGFtZGdwdV9kZXZpY2Vf
c3VwcG9ydHNfYm9jbyhkcm1fZGV2KSkgew0KPiAtCQlwY2lfc2F2ZV9zdGF0ZShwZGV2KTsNCj4g
LQkJcGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYpOw0KPiAtCQlwY2lfaWdub3JlX2hvdHBsdWcocGRl
dik7DQo+IC0JCWlmIChhbWRncHVfaXNfYXRweF9oeWJyaWQoKSkNCj4gKwkJLyogT25seSBuZWVk
IHRvIGhhbmRsZSBQQ0kgc3RhdGUgaW4gdGhlIGRyaXZlciBmb3IgQVRQWA0KPiArCQkgKiBQQ0kg
Y29yZSBoYW5kbGVzIGl0IGZvciBfUFIzLg0KPiArCQkgKi8NCj4gKwkJaWYgKGFtZGdwdV9pc19h
dHB4X2h5YnJpZCgpKSB7DQo+ICsJCQlwY2lfaWdub3JlX2hvdHBsdWcocGRldik7DQo+ICsJCX0g
ZWxzZSB7DQo+ICsJCQlwY2lfc2F2ZV9zdGF0ZShwZGV2KTsNCj4gKwkJCXBjaV9kaXNhYmxlX2Rl
dmljZShwZGV2KTsNCj4gKwkJCXBjaV9pZ25vcmVfaG90cGx1ZyhwZGV2KTsNCj4gIAkJCXBjaV9z
ZXRfcG93ZXJfc3RhdGUocGRldiwgUENJX0QzY29sZCk7DQo+IC0JCWVsc2UgaWYgKCFhbWRncHVf
aGFzX2F0cHhfZGdwdV9wb3dlcl9jbnRsKCkpDQo+IC0JCQlwY2lfc2V0X3Bvd2VyX3N0YXRlKHBk
ZXYsIFBDSV9EM2hvdCk7DQo+ICsJCX0NCj4gIAkJZHJtX2Rldi0+c3dpdGNoX3Bvd2VyX3N0YXRl
ID0NCj4gRFJNX1NXSVRDSF9QT1dFUl9EWU5BTUlDX09GRjsNCj4gIAl9IGVsc2UgaWYgKGFtZGdw
dV9kZXZpY2Vfc3VwcG9ydHNfYmFjbyhkcm1fZGV2KSkgew0KPiAgCQlhbWRncHVfZGV2aWNlX2Jh
Y29fZW50ZXIoZHJtX2Rldik7DQo+IEBAIC0xMjU1LDE0ICsxMjU5LDE5IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3Btb3BzX3J1bnRpbWVfcmVzdW1lKHN0cnVjdA0KPiBkZXZpY2UgKmRldikNCj4gIAlp
ZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGRybV9kZXYpKSB7DQo+ICAJCWRybV9kZXYt
PnN3aXRjaF9wb3dlcl9zdGF0ZSA9DQo+IERSTV9TV0lUQ0hfUE9XRVJfQ0hBTkdJTkc7DQo+IA0K
PiAtCQlpZiAoYW1kZ3B1X2lzX2F0cHhfaHlicmlkKCkgfHwNCj4gLQkJICAgICFhbWRncHVfaGFz
X2F0cHhfZGdwdV9wb3dlcl9jbnRsKCkpDQo+ICsJCS8qIE9ubHkgbmVlZCB0byBoYW5kbGUgUENJ
IHN0YXRlIGluIHRoZSBkcml2ZXIgZm9yIEFUUFgNCj4gKwkJICogUENJIGNvcmUgaGFuZGxlcyBp
dCBmb3IgX1BSMy4NCj4gKwkJICovDQo+ICsJCWlmIChhbWRncHVfaXNfYXRweF9oeWJyaWQoKSkg
ew0KPiArCQkJcGNpX3NldF9tYXN0ZXIocGRldik7DQo+ICsJCX0gZWxzZSB7DQo+ICAJCQlwY2lf
c2V0X3Bvd2VyX3N0YXRlKHBkZXYsIFBDSV9EMCk7DQo+IC0JCXBjaV9yZXN0b3JlX3N0YXRlKHBk
ZXYpOw0KPiAtCQlyZXQgPSBwY2lfZW5hYmxlX2RldmljZShwZGV2KTsNCj4gLQkJaWYgKHJldCkN
Cj4gLQkJCXJldHVybiByZXQ7DQo+IC0JCXBjaV9zZXRfbWFzdGVyKHBkZXYpOw0KPiArCQkJcGNp
X3Jlc3RvcmVfc3RhdGUocGRldik7DQo+ICsJCQlyZXQgPSBwY2lfZW5hYmxlX2RldmljZShwZGV2
KTsNCj4gKwkJCWlmIChyZXQpDQo+ICsJCQkJcmV0dXJuIHJldDsNCj4gKwkJCXBjaV9zZXRfbWFz
dGVyKHBkZXYpOw0KPiArCQl9DQo+ICAJfSBlbHNlIGlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRz
X2JhY28oZHJtX2RldikpIHsNCj4gIAkJYW1kZ3B1X2RldmljZV9iYWNvX2V4aXQoZHJtX2Rldik7
DQo+ICAJfQ0KPiAtLQ0KPiAyLjIzLjANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
