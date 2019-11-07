Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC4FC5DF61
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D2D2178F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D2D2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FEB6F6AA;
	Thu,  7 Nov 2019 14:14:16 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820044.outbound.protection.outlook.com [40.107.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DCD6F6AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 14:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVsUa2eEaVPCfN1ApXhC6CUG7mUShmmK1SQQD6FJhzRhxgg0r9S9cqwKJHQj0uTaTq5yvYi3d0B4zVkhH79ktUiFdlAUyIIcLRl1B1ngUNz0kWxy6rIwQL2AA6d9S/lnETIKpitp2r0Gfia/0epYcEyr8DOedD3oaJHmxixp3WODl9iCK/EvViJw5quzESYEdmZo88spPKo0fHJ9tG1yvhTd6k4DAZ9EVkpUa9rCklOivW2VY3CPk3fsfgszU/cNnBW97kV3lkRoQOH120AoMpdghBkW7mRBHG0eWO6QzJ6WO2bZZNtNAVwiItTf4Dw6kyjkuONVwnPU2NR4ObErOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXd8ChOtjZGYlVvUcgB2pArk/jfhwOFSveywP5cmMKA=;
 b=NvnKB3vFIYTUsVHrXvky8LA4SbBVpRsnU0thcq2g+R8qQFn2T5mh9pEYXfajYo9roukfhd/u8kd7NSFWKBr26COuEANMOY/S9KkFFxo7wU33bESBN6P6GVAOW/3+E08AsyxdEV/lPPGEIINkpediP02qnWGoIsp9H90TIPR6aMwL2MiBSWf4OEHukeh5M/Z46AwF87ceKY9KZpguE53ocfNynI8K2sAIN56Sf+Td5ecF3C0sbgRhhAryZ5Q9m9ZI80HBae70t1NSluHPwe8e/9YJlCDAEHUdZmS5xo9bRWK4V+amO0LbTitb7/+MJVfMj8lo8TvdlVg++9D8HVEMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2521.namprd12.prod.outlook.com (52.132.180.152) by
 MW2PR12MB2489.namprd12.prod.outlook.com (52.132.180.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 14:14:13 +0000
Received: from MW2PR12MB2521.namprd12.prod.outlook.com
 ([fe80::86d:3a39:16b3:95a0]) by MW2PR12MB2521.namprd12.prod.outlook.com
 ([fe80::86d:3a39:16b3:95a0%5]) with mapi id 15.20.2408.024; Thu, 7 Nov 2019
 14:14:13 +0000
From: "Freehill, Chris" <Chris.Freehill@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: correct Arcturus OD support
Thread-Topic: [PATCH] drm/amd/powerplay: correct Arcturus OD support
Thread-Index: AQHVlT5hNY9IZRK/5EmJYYXhGvPRMKd/vCeAgAABQxCAAAH+wA==
Date: Thu, 7 Nov 2019 14:14:13 +0000
Message-ID:
 <MW2PR12MB2521D94EEBD7BCD91FFB530885780@MW2PR12MB2521.namprd12.prod.outlook.com>
References: <20191107073817.27624-1-evan.quan@amd.com>
 <CADnq5_PxWYGE1-uL+pey-Rwj6EiP2EuO+Y4N7aYNL85P3QOeUw@mail.gmail.com>
 <CY4PR1201MB2533B1569C97729EA15C8B8085780@CY4PR1201MB2533.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB2533B1569C97729EA15C8B8085780@CY4PR1201MB2533.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [24.206.71.44]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91a86e71-ded3-466b-b3e3-08d7638cc43c
x-ms-traffictypediagnostic: MW2PR12MB2489:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR12MB2489F93318CF054E9CC1D36185780@MW2PR12MB2489.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(189003)(13464003)(199004)(186003)(86362001)(55016002)(5660300002)(7696005)(305945005)(64756008)(76116006)(66556008)(66476007)(99286004)(81166006)(14454004)(6116002)(966005)(3846002)(74316002)(66446008)(316002)(76176011)(53546011)(7736002)(478600001)(110136005)(66946007)(52536014)(81156014)(6506007)(229853002)(256004)(6636002)(476003)(6246003)(54906003)(71190400001)(2906002)(486006)(71200400001)(8676002)(8936002)(66066001)(6436002)(26005)(14444005)(102836004)(25786009)(11346002)(9686003)(446003)(4326008)(6306002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2489;
 H:MW2PR12MB2521.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AHsx0l/fq/yerlXGYHdv+CtSuRraH3fEqfDQhYDCSylLtLp/wsaA3AMrBpKnfl42UKTZOBvMjlf+wZGH9Apjcb4O1vOJFI6ixvPi7Xm6hyCtlCvlN3ybEyQpR7vWMUYUkPN6g5jX1HzxpxBu2zZ8vON6Uuel1dz8XgvKonqn0WyfC9LC3BLS8vxCLHN+7VTHbUdi8Uzbi8VGf+rEbObR8z+e/T38bUdlehquYm89TfkrCOsH3Q8+FsUlSChgMwznOtVayO+AMbRBlSTXH44Uc1SNz1Zs9dVXXo2i8+ghkMhKngXGoLPmNxasGKBC4IO3/AtSOBiygJfK6asCsleN0b2XKgjK8YQbXj5b9xD7B7I2UUJbg0dNnoeBWA11HWfgM58GAwTvhVuQJKbtmB8EzNXlnezZSE5rdgWG2HEM6/0EftxSlPLALxEFEzIFUmiwrV9g8vWR917c8fYfP3bld7aLMFK6DtVRZ4OSoEgJ/eQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a86e71-ded3-466b-b3e3-08d7638cc43c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 14:14:13.2699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfQ/zUCmP/uxAFNu9nX16RaosT0l6l1M1TE0N3jh1K54KPnGTn8ER4V2EWusWHUwOeV3mMALbatB1i4mSzMCSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2489
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXd8ChOtjZGYlVvUcgB2pArk/jfhwOFSveywP5cmMKA=;
 b=2K2uOQEWjoiq7KBQEkmDXsEyrbLEukJYbQch1sTCJSP3qoYtGsWUHpNVS0hmuDb8NZyuX9spmumgI2ctiqXS86I8Jak0b6TKut4yr8rrzCQ1k9lZE1RBwluSQWxuoo8qHcqWBZ1Eqmeivbz+1S68Xo2wKJK/A4EtpESlPEPsuqw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Freehill@amd.com; 
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
Cc: "Li, Candice" <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107141413.cUChwmkvZNIm1ru_Y1xYUl1yHGhkFKtLB39YV37l6h0@z>

SSB0aGluayBLZW50IGhhcyBtb3JlIGluc2lnaHQgd2l0aCBkZW1hbmQgZm9yIHRoaXMgZmVhdHVy
ZSB0aGFuIEkgZG8sIHNvIEkgZGVmZXIgdG8gaGlzIG9waW5pb24uIEkgaGF2ZW4ndCByZWNlaXZl
ZCBhbnkgZmVlZGJhY2sgb24gdGhhdCBBUEkuDQoNCk1haW4gdGhpbmcgaXMgdGhhdCBpZiBpdCdz
IG5vdCBzdXBwb3J0ZWQsIGRvbid0IGhhdmUgdGhlIGZpbGUgdmlzaWJsZS4gDQoNClRoYW5rcywN
CkNocmlzDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUnVzc2VsbCwgS2VudCA8
S2VudC5SdXNzZWxsQGFtZC5jb20+IA0KU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDcsIDIwMTkg
ODowNSBBTQ0KVG86IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjsgUXVhbiwg
RXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQpDYzogTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBGcmVlaGlsbCwgQ2hyaXMgPENo
cmlzLkZyZWVoaWxsQGFtZC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kL3Bvd2Vy
cGxheTogY29ycmVjdCBBcmN0dXJ1cyBPRCBzdXBwb3J0DQoNCldoaWxlIHdlIGRvIGxpa2UgT3Zl
ckRyaXZlIGJlaW5nIGF2YWlsYWJsZSAobW9zdGx5IG91ciBvcGVuLXNvdXJjZSBjb21tdW5pdHkg
dXNlcnMgd2hvIGFyZSB1c2luZyBjb25zdW1lciBjYXJkcyB2cyBzZXJ2ZXIgY2FyZHMpLCBpZiBp
dCdzIG5vdCBzdXBwb3J0ZWQgb24gdGhlIEhXIGZvciB3aGF0ZXZlciByZWFzb24sIHdlJ2xsIGFk
YXB0LiBJZiB3ZSBnZXQgYSByZXF1ZXN0IGxhdGVyIGZvciBpdHMgZW5hYmxlbWVudCAoc2luY2Ug
T3ZlckRyaXZlIGlzIGNvbnN1bWVyLWNhcmQtb25seSBpbiBnZW5lcmFsLCBhbmQgSSBwZXJzb25h
bGx5IGhhdmVuJ3Qgc2VlbiBhbnkgQXJjdHVydXMgY29uc3VtZXIgY2FyZHMpLCB3ZSBjYW4gZGlz
Y3VzcyB0aGVuLiBJdCdzIGZpbmUgd2l0aCBDaHJpcyBhbmQgSSBpbiB0aGF0IHJlZ2FyZC4NCg0K
IEtlbnQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1n
ZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNo
ZXINClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA3LCAyMDE5IDg6NTggQU0NClRvOiBRdWFuLCBF
dmFuIDxFdmFuLlF1YW5AYW1kLmNvbT4NCkNjOiBMaSwgQ2FuZGljZSA8Q2FuZGljZS5MaUBhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEZyZWVoaWxsLCBDaHJpcyA8Q2hy
aXMuRnJlZWhpbGxAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJw
bGF5OiBjb3JyZWN0IEFyY3R1cnVzIE9EIHN1cHBvcnQNCg0KT24gVGh1LCBOb3YgNywgMjAxOSBh
dCAyOjM4IEFNIFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPiB3cm90ZToNCj4NCj4gT0Qg
aXMgbm90IHN1cHBvcnRlZCBvbiBBcmN0dXJ1cy4gVGh1cyB0aGUgcHBfb2RfY2xrX3ZvbHRhZ2Ug
c3lzZnMgDQo+IGludGVyZmFjZSBpcyBhbHNvIG5vdCBzdXBwb3J0ZWQuDQo+DQo+IENoYW5nZS1J
ZDogSWI3MDYzMmE1NWEwOTgwY2YwNGMzNDMyZDQzZGJjZjg2OWNkMWI0YmYNCj4gU2lnbmVkLW9m
Zi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCg0KWW91IG1pZ2h0IHdhbnQgdG8g
Y2hlY2sgd2l0aCBDaHJpcyBhbmQgS2VudCBhYm91dCB0aGlzLiAgSSB0aGluayB0aGVyZSBpcyBh
IHVzZSBjYXNlIGZvciBPRCBvbiBST0NtIGluIHNvbWUgY2FzZXMuICBBc3N1bWluZyB0aGV5IGFy
ZSBvayB3aXRoIGl0LA0KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NCg0KQWxleA0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvYW1kZ3B1X3NtdS5jIHwgOCArKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KPiBpbmRleCBjMjFmZTdhYzVkZjguLjc2YTQxNTRiM2Jl
MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3Nt
dS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0K
PiBAQCAtNzE0LDYgKzcxNCw5IEBAIHN0YXRpYyBpbnQgc211X3NldF9mdW5jcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZQ0KPiAqYWRldikgIHsNCj4gICAgICAgICBzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSA9ICZhZGV2LT5zbXU7DQo+DQo+ICsgICAgICAgaWYgKGFkZXYtPnBtLnBwX2ZlYXR1cmUgJiBQ
UF9PVkVSRFJJVkVfTUFTSykNCj4gKyAgICAgICAgICAgICAgIHNtdS0+b2RfZW5hYmxlZCA9IHRy
dWU7DQo+ICsNCj4gICAgICAgICBzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgew0KPiAgICAgICAg
IGNhc2UgQ0hJUF9WRUdBMjA6DQo+ICAgICAgICAgICAgICAgICB2ZWdhMjBfc2V0X3BwdF9mdW5j
cyhzbXUpOyBAQCAtNzI1LDYgKzcyOCw4IEBAIHN0YXRpYyANCj4gaW50IHNtdV9zZXRfZnVuY3Mo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4g
ICAgICAgICBjYXNlIENISVBfQVJDVFVSVVM6DQo+ICAgICAgICAgICAgICAgICBhcmN0dXJ1c19z
ZXRfcHB0X2Z1bmNzKHNtdSk7DQo+ICsgICAgICAgICAgICAgICAvKiBPRCBpcyBub3Qgc3VwcG9y
dGVkIG9uIEFyY3R1cnVzICovDQo+ICsgICAgICAgICAgICAgICBzbXUtPm9kX2VuYWJsZWQgPWZh
bHNlOw0KPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgY2FzZSBDSElQX1JFTk9J
UjoNCj4gICAgICAgICAgICAgICAgIHJlbm9pcl9zZXRfcHB0X2Z1bmNzKHNtdSk7IEBAIC03MzMs
OSArNzM4LDYgQEAgc3RhdGljIA0KPiBpbnQgc211X3NldF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAgICAgICAg
IH0NCj4NCj4gLSAgICAgICBpZiAoYWRldi0+cG0ucHBfZmVhdHVyZSAmIFBQX09WRVJEUklWRV9N
QVNLKQ0KPiAtICAgICAgICAgICAgICAgc211LT5vZF9lbmFibGVkID0gdHJ1ZTsNCj4gLQ0KPiAg
ICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPg0KPiAtLQ0KPiAyLjIzLjANCj4NCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
