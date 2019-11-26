Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED76C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 14:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF6B2071A
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 14:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF6B2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7179E6E416;
	Tue, 26 Nov 2019 14:52:25 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720083.outbound.protection.outlook.com [40.107.72.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEAD26E419
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 14:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X48DH0qVhp6Y8DJWN9oKYqaL4BhuPt3alc4XuLCe+kSdk7Hlx/C7WkqNTgRhvmaMjNtpBNy1KoVbi3AY+pAdEiS3ZphRivPYZVM0OLKns4JmI/LpYgoAT30wOi4jq4VwvIzZdivIGJ2ycK//vlsRs5qXSBYRj5OOYQZteeGByAMcl1sVvN07XpBcE4YW8aaeUCqz/Vm9Cxr0CThB9wwqBXCBaNxhW/SvP5pSOzShnznzicQYwUirQTnFA7m/MVSg2ZK2qrBSWvAN20t1IdV7bnAIxRO6bczgeo27OnzZ6Qva9MaBQiLZBoXCkh6P1+YCpgZTr370iDPhw0q49IwlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Wh6EObk1V6VeLjZs72upHK/xpS4tch1u5KomNZUOoY=;
 b=cvwa9z8bMsSRo5AEQWu3n0/Bva4nv2trZ6o4AWnL4dg/vtw/2ScSdgb9ivRGx9UJIItU/SOWtiP4lbpRlTsPWnVcL0LrCxADzNpmQZisN0wtfZSQGmuDzBrvJk0TZHvx/j7ZvnouDjjwYzpwZtPsS8vIMhZHEhZbaZej2YUAeu4LRQ9M6rMdbJNJqeAqXMqLrua0kCc9QNXoY3BRDYNDUUhcufUOw0H23r04uVsiYbUw46DShmfLplS4iiAk1lihvmoheOzqA1flDgJfJG6PjviY+fchduXqdY7pOQ/AbAD1aASmR6czt3HdkRGyZfYxHdSEXmOdi9Mx2jNq+M4kqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3145.namprd12.prod.outlook.com (20.178.198.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Tue, 26 Nov 2019 14:52:21 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 14:52:21 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx10: remove outdated comments
Thread-Topic: [PATCH] drm/amdgpu/gfx10: remove outdated comments
Thread-Index: AQHVpD4K0d8qtqgfj0S2CcGCNV4GcqediYYw
Date: Tue, 26 Nov 2019 14:52:21 +0000
Message-ID:
 <DM6PR12MB34663AE02FDBA948EA3583189E450@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <20191126094338.32695-1-xiaojie.yuan@amd.com>
In-Reply-To: <20191126094338.32695-1-xiaojie.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 479524cf-70ac-4aa3-8db4-08d772803dfb
x-ms-traffictypediagnostic: DM6PR12MB3145:|DM6PR12MB3145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB31459B34F99FAFD12BEA7ABC9E450@DM6PR12MB3145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:409;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(189003)(199004)(13464003)(99286004)(110136005)(25786009)(256004)(54906003)(229853002)(11346002)(305945005)(6436002)(33656002)(7736002)(7696005)(71200400001)(71190400001)(76176011)(446003)(74316002)(9686003)(53546011)(5660300002)(8676002)(186003)(81156014)(81166006)(4326008)(316002)(6506007)(26005)(66946007)(66476007)(66556008)(64756008)(66446008)(14454004)(76116006)(55016002)(66066001)(52536014)(3846002)(2501003)(6116002)(102836004)(6246003)(478600001)(8936002)(86362001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3145;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/qRndQ4woBWYjUIQhVgddz63vQTL9bDCm4jq3gKYJjG0x+HYg9hvr/nBgHDTe6mSx4mJUiRFSc7DAaHR+oDcGY8swDImAbR8nFS+EFTtA18K+JBWsuKJuLPnqib3/7aNqSeZzS0Gs42sy76WmUvyBLKOrBIBZ8lh6ozeQPLDnaYMAfazkzmxcs1+XHaoGuNilTNJ7jVWGRhubx94n1q9pfOVhcDPOBGC3VWXNPaIhe/q+GP3IKQxHv9EAzwkSRLPtD8rhKzf3yk5XaKt4Io65GnWZX5WfyyG+1QcGm26ZmkkYoeFeflvmsz5Mal5kXPNKFErxT9aNWoQBfDdDt5rEQEpd6VEN0JVDn1uEO2759f1zrMTh3F8doSR+Ul+Sl4aVESDg/xJYI09HJyf3wtlYxFsMUlndUzbiRYDyNBWpNnszNxjjJ6+05DAjzG3hRS
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479524cf-70ac-4aa3-8db4-08d772803dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 14:52:21.5661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lis24lU2XT+2ES6dc/2/YEGyXnBU1CHkKCe757PX1KMhI/jwf+h9qKSZs7H/HfLD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3145
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Wh6EObk1V6VeLjZs72upHK/xpS4tch1u5KomNZUOoY=;
 b=wwuVgp+n3IEiV1XJ6DHVpLtf7OFI6YJ+pP5HzevXaxGg++J5OHIfYnMhnNErZoHgtpUXjvhGQi7a5yIb+6gMCn1ahvxgqGQjPxXS3VWiEgmF/bn2m42AdVtpUHBlDjrUPu+au+1ICxqe6SiFWV6ELXE8b2d+8YskRFtxyM3faSE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126145221.Iay51YFT1yDMCLKYk081G8fcPZ2tDyzlxE5_xHsIx0s@z>

UmV2aWV3ZWQtYnk6IFpoYW4gTGl1IDx6aGFuLmxpdUBhbWQuY29tPg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5m
cmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBYaWFvamllIFl1YW4NCj4gU2VudDogMjAx
OS9Ob3ZlbWJlci8yNiwgVHVlc2RheSA0OjQ0IEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBDYzogWGlhbywgSmFjayA8SmFjay5YaWFvQGFtZC5jb20+OyBZdWFuLCBY
aWFvamllDQo+IDxYaWFvamllLll1YW5AYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5n
LlpoYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdS9nZngxMDogcmVt
b3ZlIG91dGRhdGVkIGNvbW1lbnRzDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFvamllIFl1YW4g
PHhpYW9qaWUueXVhbkBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jIHwgMyAtLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBf
MC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gaW5kZXgg
MmM1ZGM5YjU4ZTIzLi42YmQ4ZDA2ZGJkZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jDQo+IEBAIC00Niw5ICs0Niw2IEBADQo+ICAgKiBOYXZpMTAgaGFzIHR3
byBncmFwaGljIHJpbmdzIHRvIHNoYXJlIGVhY2ggZ3JhcGhpYyBwaXBlLg0KPiAgICogMS4gUHJp
bWFyeSByaW5nDQo+ICAgKiAyLiBBc3luYyByaW5nDQo+IC0gKg0KPiAtICogSW4gYnJpbmctdXAg
cGhhc2UsIGl0IGp1c3QgdXNlZCBwcmltYXJ5IHJpbmcgc28gc2V0IGdmeCByaW5nIG51bWJlciBh
cyAxIGF0DQo+IC0gKiBmaXJzdC4NCj4gICAqLw0KPiAgI2RlZmluZSBHRlgxMF9OVU1fR0ZYX1JJ
TkdTCTINCj4gICNkZWZpbmUgR0ZYMTBfTUVDX0hQRF9TSVpFCTIwNDgNCj4gLS0NCj4gMi4yMC4x
DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
