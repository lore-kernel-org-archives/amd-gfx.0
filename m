Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B944AC43215
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 14:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963E320722
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 14:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963E320722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E01899D4;
	Mon, 18 Nov 2019 14:12:45 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820053.outbound.protection.outlook.com [40.107.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D86899D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 14:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJb15s+WhOvvPa5N+cxEJF1m8ntvjuYgQJDXuO+8TjmQyZVtP2pJcjjutVCw1cjB8N8iI+w2WQmPT6ykD8UkSxBYvLFzdCqqj3bZRyM0mm290eRgdCBXf0uasCZKg/Vn/u9RFGHkswkR3evhtoKsczcTgJSnKK4Wvklus2hlfIN9V1T/zyAtnR7B/LQ0/Gc9WuO5bS6rGZZmvVdEV1SOeGDh2H0t5otLIS2LFmBuHh8yFDWfJuEtYsKrZDMI32brzNC9TI5jChTZMewyHrSE6kwyHjO5qwmeFV6dw+gcSZbLHjgl5P3PG+DvmzqXJburNo3d3ZUuMLWcfZjK2Qi7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOQun8Re+DdWSnFYf28nRfMeh+e8pkz15ZX3YHDXwjg=;
 b=EJuyw1TxolaLE3WjOIc0Ki0JYiDyJ3LK/9jwUiQeOY7slmw74t2hxYPvawLyaD5N1hU9ca239Vef1DTZvQOn1EBXMkTP5+z2t8DRiBR2fUKcGt6aP3ijQQ6qoN9r0Cwlis+S5G4KLb1/GAzodgLzyYUDFndjHwCQdu2zXWX0RfKzgFFDnUIis+koddCbNfvIpcx/y3tXUs553k7xhfcewYCldKps9Vhy0lD95eGKJuxLB/6D1c6oNSVmSqHfsf54LcEMllHc5kGc5rwjGtH7EGSs/Wd5Ie/wKf1BjNptqHp/d6dfEuLsNx6NFQkPpQDBzCCh35s48p+ZlnWQTWz+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2450.namprd12.prod.outlook.com (52.132.11.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 14:12:39 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595%2]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 14:12:39 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, "Sierra Guiza, Alejandro (Alex)"
 <Alex.Sierra@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
Thread-Topic: [PATCH] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
Thread-Index: AQHVm9xPRg7efMyLSkGed5lU8ulRQqeMhkAAgAO84jCAALJngIAABROQ
Date: Mon, 18 Nov 2019 14:12:39 +0000
Message-ID:
 <BL0PR12MB2580DCD62FE37E93EEFA005C804D0@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20191115174314.73446-1-alex.sierra@amd.com>
 <bd9f76ca-9dc7-6c29-9c41-fc3e0d3c0bf1@amd.com>
 <BL0PR12MB258076EDAE60740E94C92972804D0@BL0PR12MB2580.namprd12.prod.outlook.com>
 <b391a2bb-a078-d397-50f9-9f4cd2824cb3@gmail.com>
In-Reply-To: <b391a2bb-a078-d397-50f9-9f4cd2824cb3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ddfe30cc-23a4-457d-c5ae-08d76c315ea2
x-ms-traffictypediagnostic: BL0PR12MB2450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB245043F3BCB1A1648B55A4FB804D0@BL0PR12MB2450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(13464003)(189003)(199004)(102836004)(71200400001)(71190400001)(229853002)(6116002)(256004)(26005)(3846002)(86362001)(446003)(6506007)(11346002)(53546011)(8936002)(64756008)(66476007)(66946007)(66556008)(7736002)(66446008)(5660300002)(305945005)(186003)(7696005)(66066001)(4001150100001)(2501003)(81166006)(81156014)(8676002)(52536014)(99286004)(478600001)(76176011)(14454004)(74316002)(2906002)(66574012)(33656002)(6436002)(55016002)(9686003)(6306002)(6246003)(476003)(110136005)(14444005)(966005)(76116006)(486006)(316002)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2450;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsJrb2GTJ8gms9eU6qYfN9XJ6H42RVwtLO4BXlFXB/Cjp2FtU7tXAUh+M3pehoTFh7CJn0W0p3TMVTgZ4vdRL2UiqrCqEsoCCS2f1jK0uCFKQUAe3kNhjg+38uH5lV28tkCnsvuAP2E7mLjeLcHJodFcS6HoW+p4U78nGZDhnpITyHmW7GlEet8/dOOFlmnscc3pIYkP4fU08/9/RsJ7y5PNuZKEWZLxfF+Mi5PoMeszNDLTDkdF+tTIq/2qRXA3uuqJ0jG2VhdrJpfq1FkXFi/6823lXEKilhvFU2hI/achLBSkAzAUkR8VIq7YEmKJAR3uLNOhH6MDE1aMxi6egWO0e7UJwYPOs7MKdL3jcisvjs0/LTT0eKsSUBZ6cUBIFKQ/TrRjanGwXafmZ13U5ne1G/UmCCgOZZA6U09S0kptLHMbyQfCQINSlRkTnGSJ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfe30cc-23a4-457d-c5ae-08d76c315ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 14:12:39.1338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjkDkQT0ZA8RdOsb7jR2EsdKo5I3m3nZrnI++kZPb2a9In3UaZklFe3mUNihZ8iR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2450
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOQun8Re+DdWSnFYf28nRfMeh+e8pkz15ZX3YHDXwjg=;
 b=Aw+FVtSuNY9lyytolKpVj5EEwe6Ie2crT1aKwBtBXi6FEjn5vfnayx7lZ2OC1FQRl5bN0zNVc6QDi1ygfd4xLjwPj9L1WYNj143V6ujDihgFlbWa3//bpWfvnMbV9ATxqX6VPy7e0lSdAwc3sABaVCzH9kuzgWjvfl7RfKeEz3M=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
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
Message-ID: <20191118141239.EKi16chO3i3TFZQYcwFd2i3fgixP9q_rsOnJc_jeEhU@z>

VGhhbmsgeW91IENocmlzdGlhbi4gQW4gaW50ZW50aW9uYWwgdXNlIG9mIGludmFsaWQgUFRFIHNl
dHRpbmcgc291bmRzIHJlYXNvbmFibGUgZm9yIGRlYnVnZ2VyIGNhc2UuIEkgd2Fzbid0IGFibGUg
dG8gdW5kZXJzdGFuZCBiZWNhdXNlIEkgdGhvdWdoIHRoaXMgaXMgcHJlcGFyYXRpb24gd29yayBm
b3IgcGFnZSBtaWdyYXRpb24uDQoNCkhpIEFsZXgsDQoNClBsZWFzZSBhZGQgc29tZSBjb21tZW50
cyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gc2F5IHRoYXQgdGhpcyBpcyBpbnRlbnRpb25hbGx5
IGludmFsaWQgUFRFIHNldHRpbmdzIHRvIGdlbmVyYXRlIG5vLXJldHJ5IGludGVycnVwdCBhbmQg
dGhpcyBpcyBmb3IgZGVidWdnZXIgdXNlIGNhc2Ugd2hlcmUgd2UgZG9uJ3Qgd2FudCBlbmRsZXNz
IHRyYW5zbGF0aW9uIHJldHJ5LiBFbmRsZXNzIHRyYW5zbGF0aW9uIHJldHJ5IGlzIGRlc2lnbmVk
IGZvciBwYWdlIG1pZ3JhdGlvbi4gQSBzX3RyYXAgaW5zdHJ1Y3Rpb24gd2lsbCBiZSBpbnNlcnRl
ZCBpbiB0aGUgZGVidWdnZXIgY2FzZSB0byBsZXQgdGhlIHdhdmUgdG8gZW50ZXIgdHJhcCBoYW5k
bGVyIHRvIHNhdmUgY29udGV4dC4NCg0KUmVnYXJkcywNCk9haw0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+IA0KU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxOCwgMjAxOSA4OjQ3IEFNDQpU
bzogWmVuZywgT2FrIDxPYWsuWmVuZ0BhbWQuY29tPjsgWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFu
Z0BhbWQuY29tPjsgU2llcnJhIEd1aXphLCBBbGVqYW5kcm8gKEFsZXgpIDxBbGV4LlNpZXJyYUBh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGFtZC9hbWRncHU6IGZvcmNlIHRvIHRyaWdnZXIgYSBuby1yZXRyeS1mYXVsdCBhZnRlciBh
IHJldHJ5LWZhdWx0DQoNCkhpIE9haywNCg0Kd2VsbCB5b3VyIHF1ZXN0aW9ucyBhcmUgcmVhbGx5
IHZhbGlkLiBUaGlzIGlzIGEgZm9sbG93IHVwIGZyb20gYW4gaW50ZXJuYWwgZGlzY3Vzc2lvbiBv
biBob3cgdG8gaGFuZGxlIHRoZSBkZWJ1ZyB0cmFwIGhhbmRsZXIgb24gVmVnYSBhbmQgbmV3ZXIu
DQoNClRoZSBrZXkgbWlzc2luZyBpbmZvcm1hdGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgaXMg
dGhhdCB3ZSBhcmUgaW50ZW50aW9uYWxseSB1c2luZyBhbiBpbnZhbGlkIGNvbWJpbmF0aW9uIG9m
IGZsYWdzIChGIGFuZCBQIHNldCBhdCB0aGUgc2FtZSB0aW1lKSB0byB0cmlnZ2VyIGEgbm8tcmV0
cnkgZmF1bHQuDQoNClRoaXMgaXMgdXNlZCB3aXRoIHRoZSBkZWJ1ZyB0cmFwIGhhbmRsZXIgdG8g
ZW50ZXIgZGVidWdnaW5nIHdoZW4gYW4gYXBwbGljYXRpb24gYWNjZXNzZXMgYW4gaW52YWxpZCBh
ZGRyZXNzIG9uIHRoZSBHUFUuDQoNCk90aGVyd2lzZSB3ZSB3b3VsZCBqdXN0IHJlLXRyeSB0aGUg
YWNjZXNzIG92ZXIgYW5kIG92ZXIgYWdhaW4gYmVjYXVzZSB0aGUgaGFyZHdhcmUgdGhpbmtzIHRo
YXQgdGhpcyBpcyBmb3IgcGFnZSBtaWdyYXRpb24uDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoN
CkFtIDE4LjExLjE5IHVtIDA0OjQyIHNjaHJpZWIgWmVuZywgT2FrOg0KPiBIaSBQaGlsaXAvQWxl
eCwNCj4NCj4gSSBmb3VuZCBJIGNhbid0IHVuZGVyc3RhbmQgdGhpcyBwYXRjaCB3aXRob3V0IG1v
cmUgZGV0YWlscyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuIElzIHRoaXMgcHJlcGFyYXRpb24gd29y
ayBmb3IgdGhlIHBhZ2UgbWlncmF0aW9uPyBXaHkgc2V0dGluZyB0aGUgdHJhbnNsYXRpb24gZnVy
dGhlciBiaXQgY2FuIGZvcmNlIGEgbm8tcmV0cnktZmF1bHQ/IFdvbid0IHNldHRpbmcgdGhpcyBi
aXQgY2F1c2UgVVRDTDIgdHJlYXQgdGhlIFBURSBhcyBhIFBERSBhbmQgY29udGludWUgdG8gd2Fs
ayB0byB0aGUgUFRFIHRoYXQgdGhpcyBQVEUgcG9pbnRpbmcgdG8/IEJ1dCBmcm9tIHRoZSBwYXRj
aCBiZWxvdywgdGhlIG5leHQgbGV2ZWwgb2YgUFRFIChwc2V1ZG9seSB0aGUgNXRoIGxldmVsIHBh
Z2UgdGFibGUpIGlzIG5vdCBzZXQuDQo+DQo+IFdoeSB0aGlzIHNldHRpbmcgd2lsbCBjYXVzZSB0
aGUgd2F2ZSB0byBlbnRlciB0cmFwIGhhbmRsZXI/IEFzIEkgdW5kZXJzdGFuZCBpdCwgd2F2ZSBl
bnRlcnMgdHJhcCBoYW5kbGVyIChzYXZpbmcgY29udGV4dCkgZWl0aGVyIGl0IGVuY291bnRlciBh
IHNfdHJhcCBpbnN0cnVjdGlvbiwgb3IgQ1AgY2FuIGluaXRpYWxpemUgc3VzcGVuc2lvbiB0byBw
cmVlbXB0IHRoZSBydW5uaW5nIHdhdmVzLCBvciBjb250ZXh0IHN3aXRjaCBjYW4gYmUgdHJpZ2dl
cmVkIGJ5IGNlcnRhaW4gY291bnRlciAobW9uaXRvcmVkIGJ5IFNQSSkuDQo+DQo+IEZ1cnRoZXIg
cXVlc3Rpb24gd2lsbCBiZSwgd2hhdCBpcyB0aGUgcGxhbm5lZCBwYWdlIG1pZ3JhdGlvbiBwcm9j
ZXNzPyBIYWx0IHdhdmUvc2F2ZSBjb250ZXh0IC0+IG1pZ3JhdGUgcGFnZS91cGRhdGUgcGFnZSB0
YWJsZS0+IHJlc3RvcmUgd2F2ZT8NCj4NCj4gQWxzbyB3aGVuIEkgY2hlY2sgbmF2aTEwIEdQVVZN
IHByb2dyYW1taW5nIGd1aWRlLCBpdCBjbGVhcmx5IHNheXMgdGhhdCBjdXJyZW50bHkgdGhlIFRy
YW5zbGF0ZSBGdXJ0aGVyIChGKSBvcHRpb24gY2Fubm90IGJlIHVzZWQgaW4gY29uY2VydCB3aXRo
IHRoZSBQREUgYXMgUFRFIChQKSBvcHRpb24uIEJ1dCB0aGlzIHBhdGNoIHNldCBGIGFuZCBQLg0K
Pg0KPiBTb3JyeSBmb3IgdG9vIG1hbnkgcXVlc3Rpb25zLg0KPg0KPiBSZWdhcmRzLA0KPiBPYWsN
Cj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIA0KPiBQaGlsaXAg
WWFuZw0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDE1LCAyMDE5IDE6MDQgUE0NCj4gVG86IFNp
ZXJyYSBHdWl6YSwgQWxlamFuZHJvIChBbGV4KSA8QWxleC5TaWVycmFAYW1kLmNvbT47IA0KPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBhbWQv
YW1kZ3B1OiBmb3JjZSB0byB0cmlnZ2VyIGEgbm8tcmV0cnktZmF1bHQgDQo+IGFmdGVyIGEgcmV0
cnktZmF1bHQNCj4NCj4gT25lIHN1Z2dlc3Rpb24gYmVsb3csIG1vdmUgdGhlIGZsYWdzIHNldHRp
bmcgZm9yIGVsc2UgcGF0aCBpbnRvIGVsc2UgcGF0aCBsb29rcyBiZXR0ZXIuDQo+DQo+IFBoaWxp
cA0KPg0KPiBPbiAyMDE5LTExLTE1IDEyOjQzIHAubS4sIEFsZXggU2llcnJhIHdyb3RlOg0KPj4g
QWZ0ZXIgYSByZXRyeS1mYXVsdCBoYXBwZW5zLCB0aGUgZmF1bHQgaGFuZGxlciB3aWxsIG1vZGlm
eSB0aGUgVVRDTDIgDQo+PiB0byBzZXQgUFRFIGJpdHMgdG8gZm9yY2UgYSBuby1yZXRyeS1mYXVs
dC4gVGhpcyB3aWxsIGNhdXNlIHRoZSB3YXZlIA0KPj4gdG8gZW50ZXIgdGhlIHRyYXAgaGFuZGxl
ci4NCj4+DQo+PiBDaGFuZ2UtSWQ6IEkxNzcxMDI4OTFmNzE1MDY4ZjE1NjA1OTU3ZmYyM2IwY2Fi
ODYyNjAzDQo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNv
bT4NCj4+IC0tLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMg
fCAxMyArKysrKy0tLS0tLS0tDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYw0KPj4gaW5kZXggM2MwYmQ2NDcyYTQ2Li5lNGQxYThmYzk3ZDUgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+IEBAIC0zMTY3LDcgKzMxNjcs
OCBAQCBib29sIGFtZGdwdV92bV9oYW5kbGVfZmF1bHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHVuc2lnbmVkIGludCBwYXNpZCwNCj4+ICAgIAkJCSAgICB1aW50NjRfdCBhZGRyKQ0KPj4g
ICAgew0KPj4gICAgCXN0cnVjdCBhbWRncHVfYm8gKnJvb3Q7DQo+PiAtCXVpbnQ2NF90IHZhbHVl
LCBmbGFnczsNCj4+ICsJdWludDY0X3QgdmFsdWUgPSAwOw0KPj4gKwl1aW50NjRfdCBmbGFnczsN
Cj4+ICAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtICp2bTsNCj4+ICAgIAlsb25nIHI7DQo+PiAgICANCj4+
IEBAIC0zMjAwLDEzICszMjAxLDkgQEAgYm9vbCBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBpbnQgcGFzaWQsDQo+PiAgICAJCUFNREdQ
VV9QVEVfU1lTVEVNOw0KPj4gICAgDQo+ICAgPi0JZmxhZ3MgPSBBTURHUFVfUFRFX1ZBTElEIHwg
QU1ER1BVX1BURV9TTk9PUEVEIHwNCj4gICA+LQkJQU1ER1BVX1BURV9TWVNURU07DQo+ICAgPg0K
Pj4gICAgCWlmIChhbWRncHVfdm1fZmF1bHRfc3RvcCA9PSBBTURHUFVfVk1fRkFVTFRfU1RPUF9O
RVZFUikgew0KPj4gLQkJLyogUmVkaXJlY3QgdGhlIGFjY2VzcyB0byB0aGUgZHVtbXkgcGFnZSAq
Lw0KPj4gLQkJdmFsdWUgPSBhZGV2LT5kdW1teV9wYWdlX2FkZHI7DQo+PiAtCQlmbGFncyB8PSBB
TURHUFVfUFRFX0VYRUNVVEFCTEUgfCBBTURHUFVfUFRFX1JFQURBQkxFIHwNCj4+IC0JCQlBTURH
UFVfUFRFX1dSSVRFQUJMRTsNCj4gICA+ICsJCS8qIFNldHRpbmcgUFRFIGZsYWdzIHRvIHRyaWdn
ZXIgYSBuby1yZXRyeS1mYXVsdCAgKi8NCj4gICA+ICsJCWZsYWdzID0gQU1ER1BVX1BURV9FWEVD
VVRBQkxFIHwgQU1ER1BVX1BERV9QVEUgfA0KPiAgID4gKwkJCUFNREdQVV9QVEVfVEY7DQo+IAl9
IGVsc2Ugew0KPj4gLQkJdmFsdWUgPSAwOw0KPiAgID4rCQlmbGFncyA9IEFNREdQVV9QVEVfVkFM
SUQgfCBBTURHUFVfUFRFX1NOT09QRUQgfA0KPiAgID4rCQkJQU1ER1BVX1BURV9TWVNURU07DQo+
ICAgPiAgIAl9DQo+DQo+PiAgICANCj4+ICAgIAlyID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBw
aW5nKGFkZXYsIHZtLCB0cnVlLCBOVUxMLCBhZGRyLCBhZGRyIA0KPj4gKyAxLA0KPj4NCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBt
YWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGlu
ZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
