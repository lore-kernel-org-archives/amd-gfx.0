Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0CCCA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 15:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE1D2087F
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 15:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE1D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D04E6EEE4;
	Thu, 31 Oct 2019 15:51:32 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342D96EEF3
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 15:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DluW40yGEQIdTqTMQiJKajlq7hTtnMS06OBzlfBoOIlCWTK4kb3p4sv+a9xQ+gpaMw8vJ2HJSr2qOoyYbjV7RJIhIKk8h7dRkMHCjCTNuqpl68zNs4oynpkIbQ4ZxM9VcLA9UrMHVzrkUVpLH4YaFUSul7tw4uRl5I7EQfIIxuFkrNa1k+mHrULz0yloc8fycl60QNzl9UFvL/SO7+/az/zySn5vz9snTLhw6xlPLz9n8jkWNq5MSnxDWsl3Eh7C6G3G6m0tPILkie3JrVJYCPCUM07JxUnppnfmCZNf4+gWueuejBIp8kAfh0El6g0+h25CyShQWKV7+b1wJpjYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPgsbpFBBwRHIrA2bWgU/REfkLQQZoBqGUfiJZMh/vg=;
 b=d+XtC/3Rbj9aRduCxlRriGkVRSNX8Zlp3w8S8zekVOImkdtQsEhRmKlxg1fSjP4nI4ZNRRpRdTIhpEYWp2FoX14nrXOXyWti+hnNk+4nH7W5Z61kOUy7UNQANb9JYVNr0fNtGjUGlm4x+fZDMy4LLZCoegfn2IiVzEhngczXjeqyGL8SZFlQRdBJdUKf0+fANaswF8bm1Uy1lk+aInyn3ZFxnhUts8FISpr9P2Q0iQZBEXZkxCEFzJszhPjOXw6dq0kRltEJcNziCXrZMB0sMs5WZ3tH0PATJaDztpfL46NND45DQbF+gFbiSaZB9kjTM1u581Qur2Gt7JGYYLk1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB2485.namprd12.prod.outlook.com (10.172.117.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Thu, 31 Oct 2019 15:51:28 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::5471:f58b:733e:1a61]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::5471:f58b:733e:1a61%7]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 15:51:28 +0000
From: Harry Wentland <hwentlan@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wu, Hersen" <hersenxs.wu@amd.com>
Subject: Re: [PATCH 01/11] drm/amdgpu: Add ucode support for DMCUB
Thread-Topic: [PATCH 01/11] drm/amdgpu: Add ucode support for DMCUB
Thread-Index: AQHVjZk9r59ol9ood0qz49NFfxVvNqd058WAgAADIwA=
Date: Thu, 31 Oct 2019 15:51:28 +0000
Message-ID: <11411112-52e1-6246-8961-21149a0b0a06@amd.com>
References: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
 <20191028140837.7908-2-nicholas.kazlauskas@amd.com>
 <BL0PR12MB28206F7609F85CC61124168689630@BL0PR12MB2820.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB28206F7609F85CC61124168689630@BL0PR12MB2820.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
x-clientproxiedby: YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5106bcc9-a8ad-42db-6750-08d75e1a30f1
x-ms-traffictypediagnostic: CY4PR1201MB2485:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB24850876D4AA99CE6F4EC5178C630@CY4PR1201MB2485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(13464003)(189003)(199004)(52116002)(229853002)(7736002)(6306002)(8676002)(81166006)(26005)(305945005)(8936002)(186003)(66446008)(64756008)(76176011)(81156014)(4326008)(102836004)(6636002)(256004)(14444005)(66556008)(6486002)(31686004)(99286004)(6436002)(66946007)(36756003)(486006)(66476007)(6512007)(53546011)(6506007)(386003)(31696002)(2616005)(966005)(6246003)(14454004)(71200400001)(71190400001)(2906002)(2501003)(25786009)(316002)(5660300002)(110136005)(58126008)(4001150100001)(478600001)(446003)(11346002)(65806001)(65956001)(3846002)(6116002)(66066001)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2485;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8ZuTd1alLEphXgY1NkttsFfjq1IGVgIj/NnSPbMMMGUcwt1ajAYRsX9ksSxmkEkmFTzaFzblKi/W0xevDJ/xVZYDaV95Zh0+kJe63LRnh2xpuBQQjZrkMSpvMP81hH/ZbbjuNhObya8ohNesuP/Ao60ECcNMudDVvQmgPITMJg4jgriRf1419NmDSlaGgv8EYUw12sOLAvdt+lBq3GAojVQKeljAHzD8g4tiDfmaLtu4MAIpLzrC9+7ZvK1sTvU/pM0y4Hyw1h4zaGMptMaZAgwRmyKa2kfNPdOB8M3JZun6AF6rYSAYSCe8gbGF3QZVzpWtI5Os3X7QqqPctCXnSPzqNNq2zEdkqMs0M/zY57yjql/3QktBVMCR8LuiDhpWMMRGNaV8qGwG6CM9IoTXkR4jGD/mELIVOPSmYotrhw9quVoAPb2AOhFzo2kHnJW9IZz9uGk7KZbvQ4elUNvf38ZjIijePWXJ/a3iAokGCY=
Content-ID: <5AB06958CD29744DB9FCF19C7EC9341D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5106bcc9-a8ad-42db-6750-08d75e1a30f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 15:51:28.1861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tw+/IOStwh3Ch2YzHh09G1B+CZh62tiEVWwfi7a2jkQMV9WM+CexILvyV8JttP1n5ESF7JKauMtoelk1Fg1vRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2485
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPgsbpFBBwRHIrA2bWgU/REfkLQQZoBqGUfiJZMh/vg=;
 b=LHJu0lAgTeGWVfMipCWpSzd86drHH3iSLRVKGTmKnqOB6LJflppI4mDFB6OFo3CBaxQprNkQh7MYZeYsS+YXKcmxtvmK3NX6nOue0emeUFz6GlhPW7xvBicOq/8VJXBc42daNO4y5z4I6XAE7XzRt5TNWHOSVQ8lP4gy43kRf5k=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031155128.XWR5tCkVIulYGG5mBx5p8dbEuQzqYpcEN9ypOFlRGx8@z>

DQoNCk9uIDIwMTktMTAtMzEgMTE6NDAgYS5tLiwgTGksIFJvbWFuIHdyb3RlOg0KPiBPbiBCZWhh
bGYgIE9mOiBIZXJzZW4gV3UNCj4gU2VyaWVzIGlzOg0KPiBSZXZpZXdlZC1ieTogSGVyc2VuIFd1
IDxoZXJzZW54cy53dUBhbWQuY29tPg0KDQpJIG9ubHkgbWFuYWdlZCB0byBza2ltIHRoZSBwYXRj
aGVzIGJ1dCBpdCBsb29rcyByZWFzb25hYmxlLg0KU2VyaWVzIGlzDQpBY2tlZC1ieTogSGFycnkg
V2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+DQoNCkhhcnJ5DQoNCj4gDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBOaWNob2xhcyBLYXpsYXVza2FzDQo+
IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyOCwgMjAxOSAxMDowOCBBTQ0KPiBUbzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNob2xh
cy5LYXpsYXVza2FzQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAwMS8xMV0gZHJtL2FtZGdw
dTogQWRkIHVjb2RlIHN1cHBvcnQgZm9yIERNQ1VCDQo+IA0KPiBUaGUgRE1DVUIgaXMgYSBzZWNv
bmRhcnkgRE1DVSAoRGlzcGxheSBNaWNyb0NvbnRyb2xsZXIgVW5pdCkgdGhhdCBoYXMgaXRzIG93
biBzZXBhcmF0ZSBmaXJtd2FyZS4gSXQncyByZXF1aXJlZCBmb3IgRE1DVSBzdXBwb3J0IG9uIFJl
bm9pci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFz
LmthemxhdXNrYXNAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdWNvZGUuYyB8IDExICsrKysrKysrKystICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdWNvZGUuaCB8ICA5ICsrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAx
OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdWNvZGUuYw0KPiBpbmRleCA4MzNmYzRiNjg5NDAuLjllZjMxMjQyODIz
MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2Rl
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMNCj4g
QEAgLTQ0Nyw2ICs0NDcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV91Y29kZV9pbml0X3NpbmdsZV9m
dyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gIAljb25zdCBzdHJ1Y3QgY29tbW9uX2Zp
cm13YXJlX2hlYWRlciAqaGVhZGVyID0gTlVMTDsNCj4gIAljb25zdCBzdHJ1Y3QgZ2Z4X2Zpcm13
YXJlX2hlYWRlcl92MV8wICpjcF9oZHIgPSBOVUxMOw0KPiAgCWNvbnN0IHN0cnVjdCBkbWN1X2Zp
cm13YXJlX2hlYWRlcl92MV8wICpkbWN1X2hkciA9IE5VTEw7DQo+ICsJY29uc3Qgc3RydWN0IGRt
Y3ViX2Zpcm13YXJlX2hlYWRlcl92MV8wICpkbWN1Yl9oZHIgPSBOVUxMOw0KPiAgDQo+ICAJaWYg
KE5VTEwgPT0gdWNvZGUtPmZ3KQ0KPiAgCQlyZXR1cm4gMDsNCj4gQEAgLTQ2MCw2ICs0NjEsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV91Y29kZV9pbml0X3NpbmdsZV9mdyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwNCj4gIAloZWFkZXIgPSAoY29uc3Qgc3RydWN0IGNvbW1vbl9maXJtd2FyZV9o
ZWFkZXIgKil1Y29kZS0+ZnctPmRhdGE7DQo+ICAJY3BfaGRyID0gKGNvbnN0IHN0cnVjdCBnZnhf
ZmlybXdhcmVfaGVhZGVyX3YxXzAgKil1Y29kZS0+ZnctPmRhdGE7DQo+ICAJZG1jdV9oZHIgPSAo
Y29uc3Qgc3RydWN0IGRtY3VfZmlybXdhcmVfaGVhZGVyX3YxXzAgKil1Y29kZS0+ZnctPmRhdGE7
DQo+ICsJZG1jdWJfaGRyID0gKGNvbnN0IHN0cnVjdCBkbWN1Yl9maXJtd2FyZV9oZWFkZXJfdjFf
MCANCj4gKyopdWNvZGUtPmZ3LT5kYXRhOw0KPiAgDQo+ICAJaWYgKGFkZXYtPmZpcm13YXJlLmxv
YWRfdHlwZSAhPSBBTURHUFVfRldfTE9BRF9QU1AgfHwNCj4gIAkgICAgKHVjb2RlLT51Y29kZV9p
ZCAhPSBBTURHUFVfVUNPREVfSURfQ1BfTUVDMSAmJiBAQCAtNDcwLDcgKzQ3Miw4IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X3Vjb2RlX2luaXRfc2luZ2xlX2Z3KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LA0KPiAgCSAgICAgdWNvZGUtPnVjb2RlX2lkICE9IEFNREdQVV9VQ09ERV9JRF9STENfUkVT
VE9SRV9MSVNUX0dQTV9NRU0gJiYNCj4gIAkgICAgIHVjb2RlLT51Y29kZV9pZCAhPSBBTURHUFVf
VUNPREVfSURfUkxDX1JFU1RPUkVfTElTVF9TUk1fTUVNICYmDQo+ICAJCSB1Y29kZS0+dWNvZGVf
aWQgIT0gQU1ER1BVX1VDT0RFX0lEX0RNQ1VfRVJBTSAmJg0KPiAtCQkgdWNvZGUtPnVjb2RlX2lk
ICE9IEFNREdQVV9VQ09ERV9JRF9ETUNVX0lOVFYpKSB7DQo+ICsJCSB1Y29kZS0+dWNvZGVfaWQg
IT0gQU1ER1BVX1VDT0RFX0lEX0RNQ1VfSU5UViAmJg0KPiArCQkgdWNvZGUtPnVjb2RlX2lkICE9
IEFNREdQVV9VQ09ERV9JRF9ETUNVQikpIHsNCj4gIAkJdWNvZGUtPnVjb2RlX3NpemUgPSBsZTMy
X3RvX2NwdShoZWFkZXItPnVjb2RlX3NpemVfYnl0ZXMpOw0KPiAgDQo+ICAJCW1lbWNweSh1Y29k
ZS0+a2FkZHIsICh2b2lkICopKCh1aW50OF90ICopdWNvZGUtPmZ3LT5kYXRhICsgQEAgLTUwNiw2
ICs1MDksMTIgQEAgc3RhdGljIGludCBhbWRncHVfdWNvZGVfaW5pdF9zaW5nbGVfZncoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAJCQkJCSAgICAgIGxlMzJfdG9fY3B1KGhlYWRlci0+
dWNvZGVfYXJyYXlfb2Zmc2V0X2J5dGVzKSArDQo+ICAJCQkJCSAgICAgIGxlMzJfdG9fY3B1KGRt
Y3VfaGRyLT5pbnR2X29mZnNldF9ieXRlcykpLA0KPiAgCQkgICAgICAgdWNvZGUtPnVjb2RlX3Np
emUpOw0KPiArCX0gZWxzZSBpZiAodWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9E
TUNVQikgew0KPiArCQl1Y29kZS0+dWNvZGVfc2l6ZSA9IGxlMzJfdG9fY3B1KGRtY3ViX2hkci0+
aW5zdF9jb25zdF9ieXRlcyk7DQo+ICsJCW1lbWNweSh1Y29kZS0+a2FkZHIsDQo+ICsJCSAgICAg
ICAodm9pZCAqKSgodWludDhfdCAqKXVjb2RlLT5mdy0+ZGF0YSArDQo+ICsJCQkJbGUzMl90b19j
cHUoaGVhZGVyLT51Y29kZV9hcnJheV9vZmZzZXRfYnl0ZXMpKSwNCj4gKwkJICAgICAgIHVjb2Rl
LT51Y29kZV9zaXplKTsNCj4gIAl9IGVsc2UgaWYgKHVjb2RlLT51Y29kZV9pZCA9PSBBTURHUFVf
VUNPREVfSURfUkxDX1JFU1RPUkVfTElTVF9DTlRMKSB7DQo+ICAJCXVjb2RlLT51Y29kZV9zaXpl
ID0gYWRldi0+Z2Z4LnJsYy5zYXZlX3Jlc3RvcmVfbGlzdF9jbnRsX3NpemVfYnl0ZXM7DQo+ICAJ
CW1lbWNweSh1Y29kZS0+a2FkZHIsIGFkZXYtPmdmeC5ybGMuc2F2ZV9yZXN0b3JlX2xpc3RfY250
bCwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29k
ZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmgNCj4gaW5kZXgg
NDEwNTg3Yjk1MGYzLi5lYWYyZDViOWM5MmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91Y29kZS5oDQo+IEBAIC0yNTEsNiArMjUxLDEzIEBAIHN0cnVjdCBkbWN1
X2Zpcm13YXJlX2hlYWRlcl92MV8wIHsNCj4gIAl1aW50MzJfdCBpbnR2X3NpemVfYnl0ZXM7ICAv
KiBzaXplIG9mIGludGVycnVwdCB2ZWN0b3JzLCBpbiBieXRlcyAqLyAgfTsNCj4gIA0KPiArLyog
dmVyc2lvbl9tYWpvcj0xLCB2ZXJzaW9uX21pbm9yPTAgKi8NCj4gK3N0cnVjdCBkbWN1Yl9maXJt
d2FyZV9oZWFkZXJfdjFfMCB7DQo+ICsJc3RydWN0IGNvbW1vbl9maXJtd2FyZV9oZWFkZXIgaGVh
ZGVyOw0KPiArCXVpbnQzMl90IGluc3RfY29uc3RfYnl0ZXM7IC8qIHNpemUgb2YgaW5zdHJ1Y3Rp
b24gcmVnaW9uLCBpbiBieXRlcyAqLw0KPiArCXVpbnQzMl90IGJzc19kYXRhX2J5dGVzOyAvKiBz
aXplIG9mIGJzcy9kYXRhIHJlZ2lvbiwgaW4gYnl0ZXMgKi8gfTsNCj4gKw0KPiAgLyogaGVhZGVy
IGlzIGZpeGVkIHNpemUgKi8NCj4gIHVuaW9uIGFtZGdwdV9maXJtd2FyZV9oZWFkZXIgew0KPiAg
CXN0cnVjdCBjb21tb25fZmlybXdhcmVfaGVhZGVyIGNvbW1vbjsNCj4gQEAgLTI2OCw2ICsyNzUs
NyBAQCB1bmlvbiBhbWRncHVfZmlybXdhcmVfaGVhZGVyIHsNCj4gIAlzdHJ1Y3Qgc2RtYV9maXJt
d2FyZV9oZWFkZXJfdjFfMSBzZG1hX3YxXzE7DQo+ICAJc3RydWN0IGdwdV9pbmZvX2Zpcm13YXJl
X2hlYWRlcl92MV8wIGdwdV9pbmZvOw0KPiAgCXN0cnVjdCBkbWN1X2Zpcm13YXJlX2hlYWRlcl92
MV8wIGRtY3U7DQo+ICsJc3RydWN0IGRtY3ViX2Zpcm13YXJlX2hlYWRlcl92MV8wIGRtY3ViOw0K
PiAgCXVpbnQ4X3QgcmF3WzB4MTAwXTsNCj4gIH07DQo+ICANCj4gQEAgLTMwNyw2ICszMTUsNyBA
QCBlbnVtIEFNREdQVV9VQ09ERV9JRCB7DQo+ICAJQU1ER1BVX1VDT0RFX0lEX0RNQ1VfSU5UViwN
Cj4gIAlBTURHUFVfVUNPREVfSURfVkNOMF9SQU0sDQo+ICAJQU1ER1BVX1VDT0RFX0lEX1ZDTjFf
UkFNLA0KPiArCUFNREdQVV9VQ09ERV9JRF9ETUNVQiwNCj4gIAlBTURHUFVfVUNPREVfSURfTUFY
SU1VTSwNCj4gIH07DQo+ICANCj4gLS0NCj4gMi4yMC4xDQo+IA0KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0K
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCj4gDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
