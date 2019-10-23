Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E65CA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 15:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DD92086D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 15:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DD92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638896EB33;
	Wed, 23 Oct 2019 15:55:47 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820054.outbound.protection.outlook.com [40.107.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4CB6EB33
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 15:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhSYKKBvBPiCkax6YjHvPWStb5loZgXJBo08o/6C7Usud1x8LHIt13b1vZpC8pXwvn8S0G6G4ya3ntnEFd7TXMSr6LaqZfR9C5T2giL3QQ9J9o2pCs0jfFNRaoHvuOdArO9uEn+JCvQ5w38hXoAvfeeB+qpT37R1iO4b41aYSFyKvMj4OGU7qUOGKxgeatstUm4aLE+0qW4mvgfV8v0/kKLm9W2kRm7J3Mmk/VtD0DdXn4QKa8yJaB5wyFy2ub1lQSzDZVUffOfzXNZliAgU26Z8Q7IV+bSNgAUcI6pMcqeD7EfU2IwgP5Xb+vDuQHYnqMDqrM9AbXD55hqFbEGkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLEiPh/vPEUSYTQ4rb+u8MFloD7SJ7rbAqrtTaFx05I=;
 b=kkeAp4t9Pts09k2862Z2qHjSMpS6DRLWPG+x2OsIDjk2FzIaObhS/ZuB8ZakMbPWz74XQL1o0u+groMU+uMDMp9gIGM6l8edGBLinp6w79qVXsmiEOk/DucB3r2zAjjGv1K9GvB2dVLJ9o7p7n1TuumhCBbCcph42ZsVh1NXVGLVSN4brnqtOVT6AFIZV8eKO0XeF02xj20qMTR6ofOnU8SeCNWxPk9xM+j8B0Fy420UNWZQLdj48dQmm/j/+7qg0Nx0QWgN0YXHHR3tSeoEECcg8UEoD8k0Zg0N9GzCKubGq2XW3YDsZbNteq0u45buXGLYWVBr5CNsWeJGAnIMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3304.namprd12.prod.outlook.com (20.179.93.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Wed, 23 Oct 2019 15:55:43 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5598:12d2:404c:5373]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5598:12d2:404c:5373%7]) with mapi id 15.20.2347.030; Wed, 23 Oct 2019
 15:55:43 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>
Subject: Re: [PATCH 18/37] drm/amd/display: Allow inverted gamma
Thread-Topic: [PATCH 18/37] drm/amd/display: Allow inverted gamma
Thread-Index: AQHVhR9LbZDF1PeqHkWoeTTcrTCVk6doYWkAgAAF7QCAAAMOAA==
Date: Wed, 23 Oct 2019 15:55:43 +0000
Message-ID: <e035a396-ec2d-dc1f-51c4-b9d9a137f721@amd.com>
References: <20191017191329.11857-1-sunpeng.li@amd.com>
 <20191017191329.11857-19-sunpeng.li@amd.com>
 <82b4b639-d1c7-c26c-cb84-4c41bb16cb41@daenzer.net>
 <8ca6d548-7a6b-a242-ac22-75a43efd0955@amd.com>
In-Reply-To: <8ca6d548-7a6b-a242-ac22-75a43efd0955@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::37) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b9e6f5c-6cd3-4af4-30cc-08d757d175da
x-ms-traffictypediagnostic: BYAPR12MB3304:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3304136AD9E16693A0E2DABEEC6B0@BYAPR12MB3304.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(199004)(189003)(76176011)(305945005)(3846002)(966005)(2906002)(6506007)(86362001)(186003)(102836004)(25786009)(53546011)(476003)(6306002)(66066001)(7736002)(256004)(6246003)(486006)(4001150100001)(316002)(478600001)(31696002)(386003)(11346002)(52116002)(6436002)(6116002)(8936002)(6512007)(66446008)(81156014)(446003)(31686004)(8676002)(5660300002)(110136005)(54906003)(66946007)(66476007)(66556008)(64756008)(81166006)(229853002)(36756003)(71190400001)(4326008)(99286004)(6486002)(14454004)(2616005)(71200400001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3304;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:3; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7xukiToykn/5AvI8TDai50kJPVybTQWU0B+g7h8pFAfKCjv/jebpQQPfvcQQX/yd8elo499F8O6sa6uVyJqg9myfXGOSjPcCXEaG27HWws1JKGm0Ov8B9nWoOirKWLuphd4NaEcxvS/l15B0Va+PNhIN00WC2lbtcXEVd+Tlr8BXhDVtyq6eNuw1koyHS1wdmDUIBoW9/1+6xk8GqIlyvm/iB0vtQtPaOvKvPL8ZYxFXxuHkkiJ97VCh9v8SNFly9cbgPhTBFdJAcrxWkathw+O+bioBTjJfxnkS9kGlXjz2Kv7snSoTjHB0mwS6JXmR2DDzAah89BskGyrKT6PPaQkrg9pvpW9tSSbBIE00SXSa+lBpxAyCutPheU8fBz8hF6gUlaqPuJzK/cS93k6kJbQFGjKR6dX51YtlapLWt3phDqYVWJP1BpvGWANTOusMZ/FLjEjU2Oet1D3+5XFhdDvjALhjqin8qL7vLXnseQ=
Content-ID: <6F868844351A1647B5DB220C8CEB7B47@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9e6f5c-6cd3-4af4-30cc-08d757d175da
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 15:55:43.6467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ez0qPqHaEE3+zXLiiBpAut0CKZzjZy9RY2okmEY5POidvDglG391H2751QtxjTH3LBnxcfOOPgzQiqGf3dnauA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3304
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLEiPh/vPEUSYTQ4rb+u8MFloD7SJ7rbAqrtTaFx05I=;
 b=4G6PGrrPFJ3MNYCuyTT97FWFAFcjsjHSfEzZJxQBzUWnFggLW6l+wJbD8btJ9if4oaX2Q+QRgwLGvUVofhCwgHqJuWXZX+ObZhCeAAuFEyXNFYaq3jq61nfKzDu9NRan/1DvSPKNqsjO5fLAL7Oh/Cdtoa+gSO7lSHs5jB6CVTk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Cc: "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>, "Amini,
 Reza" <Reza.Amini@amd.com>, "Yang, Aidan" <Aidan.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023155543.XMm2hVmt8UgPMYNzhQlFYfz_HD4SWkyJrmY2qdBunQk@z>

T24gMjAxOS0xMC0yMyAxMTo0NCBhLm0uLCBMaSwgU3VuIHBlbmcgKExlbykgd3JvdGU6DQo+IA0K
PiANCj4gT24gMjAxOS0xMC0yMyAxMToyMyBhLm0uLCBNaWNoZWwgRMOkbnplciB3cm90ZToNCj4+
IE9uIDIwMTktMTAtMTcgOToxMyBwLm0uLCBzdW5wZW5nLmxpQGFtZC5jb20gd3JvdGU6DQo+Pj4g
RnJvbTogQWlkYW4gWWFuZyA8QWlkYW4uWWFuZ0BhbWQuY29tPg0KPj4+DQo+Pj4gW3doeV0NCj4+
PiBUaGVyZSdzIGEgdXNlIGNhc2UgZm9yIGludmVydGVkIGdhbW1hDQo+Pj4gYW5kIGl0J3MgYmVl
biBjb25maXJtZWQgdGhhdCBuZWdhdGl2ZSBzbG9wZXMgYXJlIG9rLg0KPj4+DQo+Pj4gW2hvd10N
Cj4+PiBSZW1vdmUgY29kZSBmb3IgYmxvY2tpbmcgbm9uLW1vbm90b25pY2FsbHkgaW5jcmVhc2lu
ZyBnYW1tYQ0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQWlkYW4gWWFuZyA8QWlkYW4uWWFuZ0Bh
bWQuY29tPg0KPj4+IFJldmlld2VkLWJ5OiBLcnVub3NsYXYgS292YWMgPEtydW5vc2xhdi5Lb3Zh
Y0BhbWQuY29tPg0KPj4+IEFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4NCj4+
PiBBY2tlZC1ieTogUmV6YSBBbWluaSA8UmV6YS5BbWluaUBhbWQuY29tPg0KPj4NCj4+IERvZXMg
dGhpcyBmaXggaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy8xMTA2NzcgPyBJZiBzbywgaXQg
c2hvdWxkIGJlDQo+PiByZWZlcmVuY2VkIGluIHRoZSBjb21taXQgbG9nLCBhbmQgdGhlIHJlcG9y
dCByZXNvbHZlZCBvbmNlIHRoaXMgbGFuZHMgaW4NCj4+IGRybS1uZXh0IG9yIExpbnVzJyB0cmVl
Lg0KPiANCj4gSSBkb24ndCB0aGluayBpdCB3b3VsZCwgbm90IG9uIHJlcG9ydGVkIHBsYXRmb3Jt
IGF0IGxlYXN0LiBUaGlzIGNoYW5nZQ0KPiBvbmx5IG1vZGlmaWVzIGZvciBEQ04gZmFtaWxpZXMs
IHNvIFJYNTgwIHdvdWxkbid0IGJlIGFmZmVjdGVkLg0KPiANCj4gTGVvDQoNCkxvb2tzIGxpa2Ug
dGhlIHNhbWUgY2hlY2sgZXhpc3RzIG9uIERDRSB0aG91Z2gsIGl0IGNvdWxkIHByb2JhYmx5IGJl
IA0KZHJvcHBlZCBhcyB3ZWxsIHRvIGZpeCB0aGlzIGJ1Zy4NCg0KU2VlOg0KZGNlMTEwX3RyYW5z
bGF0ZV9yZWdhbW1hX3RvX2h3X2Zvcm1hdCgpDQoNCgl3aGlsZSAoaSAhPSBod19wb2ludHMgKyAx
KSB7DQoJCWlmIChkY19maXhwdF9sdChyZ2JfcGx1c18xLT5yZWQsIHJnYi0+cmVkKSkNCgkJCXJn
Yl9wbHVzXzEtPnJlZCA9IHJnYi0+cmVkOw0KCQlpZiAoZGNfZml4cHRfbHQocmdiX3BsdXNfMS0+
Z3JlZW4sIHJnYi0+Z3JlZW4pKQ0KCQkJcmdiX3BsdXNfMS0+Z3JlZW4gPSByZ2ItPmdyZWVuOw0K
CQlpZiAoZGNfZml4cHRfbHQocmdiX3BsdXNfMS0+Ymx1ZSwgcmdiLT5ibHVlKSkNCgkJCXJnYl9w
bHVzXzEtPmJsdWUgPSByZ2ItPmJsdWU7DQoNCgkJcmdiLT5kZWx0YV9yZWQgPSBkY19maXhwdF9z
dWIocmdiX3BsdXNfMS0+cmVkLCByZ2ItPnJlZCk7DQoJCXJnYi0+ZGVsdGFfZ3JlZW4gPSBkY19m
aXhwdF9zdWIocmdiX3BsdXNfMS0+Z3JlZW4sIHJnYi0+Z3JlZW4pOw0KCQlyZ2ItPmRlbHRhX2Js
dWUgPSBkY19maXhwdF9zdWIocmdiX3BsdXNfMS0+Ymx1ZSwgcmdiLT5ibHVlKTsNCg0KCQkrK3Jn
Yl9wbHVzXzE7DQoJCSsrcmdiOw0KCQkrK2k7DQoJfQ0KDQoNCk5pY2hvbGFzIEthemxhdXNrYXMN
Cg0KPiANCj4+DQo+Pg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngNCj4gDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
