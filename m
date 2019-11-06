Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B52C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 20:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DF42173E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 20:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DF42173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F46A6E296;
	Wed,  6 Nov 2019 20:06:02 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730065.outbound.protection.outlook.com [40.107.73.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38C66E296
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 20:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AREbB1IFtlJDPxj/CRJ14735Vd4JK7t3b2VlSqpI8VNohr5Z8VdxDkq33iwkIjBfpPRri/wIud53mEV4eX91y+ogfHj2dnn7ROdIzur2ZKhNXJ3yAPvlpZoNVsVeT//De8WDzH2aP2vvgBuZwJkaNTE8/ds7+eaRqXpbJHiM0UoeZGXIbFBSZNv7i2XVMmSCex/WKZnFk40VzUPeQJq1ogqdFI0tt1FDUyjqF/Bvam4JtClfmK+muosZXGSEVB4IOBDVAn8lNA3PFEOjgTUb9/4BCKi7aMjj3kqG7LwUGzFn05X5qqPgRUJ2pgCznsqmexoDD0C4l8GpG5MctlEWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKoBZRTHn3mKHIZXzN9S7/IgASRnnzgfpcW3LBkxOrY=;
 b=iw4wwCtx8FpsrxMX5Eg6drkPQqNmaiRMPTbWhtNCUNPg6brBBH7Lq7QEh4YaqdnoNE5gwxaqQ4ysE8TjWikH/GXpjHFnlFPvuvkXXf96AkQDY+qwfbPHxvZdeLlWEQ7kjG6b87BLoKLx/KIFk2BFHs0Po4wq/laFV18LeyrHE7gGYW8tkM9Whc6xl5geW8ycKbJWCninXHmdN5omTgdnKDJ8ytcCe3DT3y5pDrmK0ZoucEtJtG3hzmPbyHXtqItcWkraTsvo1rWuhY5m6bjfWa5vnSCOIgCI+FotMPHVQYu3Ro+QMMJhQ163zlISaJgxSU7HuGbWU1NV0EHT1D8fyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2481.namprd12.prod.outlook.com (52.132.28.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 20:06:00 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595%2]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 20:06:00 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Topic: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Index: AQHVlMaoZiNzkpPO+kWeyC0qA10mc6d+aBAAgAApHgA=
Date: Wed, 6 Nov 2019 20:05:59 +0000
Message-ID:
 <BL0PR12MB25806AAB4587D5E2AD0FCCBA80790@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <1573060895-13033-1-git-send-email-Oak.Zeng@amd.com>
 <CADnq5_NAyRJF-26XV-QnVEQ4pD9NobmBvcGcnJTUqcO0OOe62Q@mail.gmail.com>
In-Reply-To: <CADnq5_NAyRJF-26XV-QnVEQ4pD9NobmBvcGcnJTUqcO0OOe62Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 894e31b1-e326-4548-c763-08d762f4be52
x-ms-traffictypediagnostic: BL0PR12MB2481:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2481038F08E86740CF772C0C80790@BL0PR12MB2481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(13464003)(199004)(189003)(26005)(8676002)(316002)(76176011)(9686003)(6506007)(7696005)(53546011)(102836004)(25786009)(186003)(33656002)(55016002)(6116002)(14444005)(6306002)(54906003)(256004)(3846002)(66946007)(76116006)(4326008)(66446008)(5660300002)(86362001)(71200400001)(6246003)(99286004)(71190400001)(966005)(478600001)(52536014)(8936002)(74316002)(229853002)(486006)(476003)(305945005)(7736002)(11346002)(2906002)(446003)(1411001)(66476007)(6916009)(6436002)(66556008)(64756008)(81166006)(81156014)(66066001)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2481;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1NWPja1FS7MmlISsEoGiwjFmd18aQuZLgm7Kf0YgmyVMdv6yvvQJMXsw6UPPOxh9LwEvfGQ9g8ciGwVWUcjgq9N+1ilaYBMoodKx5Siu+udJm36vt9/VFG2qJp1DHo5yelRHlqDgxlbsayQO90zMLf1rwo0T0aRZLk/cnFxfnakD68QxAHRLYL9qPkudX1k2S1BNysMcoSF1OqANlOxjMLTYJXyJGVhEk+U30di2ItDN/idkX18NInJcVzjhxowGQHlrrzaN0Fn8J2omcp+16bk5SRAJHFCElQSisId1NFZbbhlJf0P55U8jgJYKFWkWcMrljB02E1OrNGMLBHLOzxk+oyk8uQUwwq1scTRPtyOfN9ztOyEF0H3On6JFxHjc9z/C1t6+9O8ckJV4FwMcxXqbCEBrXC5uq4z6POQe+7/Pb/8CzcgdUfLP77cS21/5pXaLnbm2gPInD3IlBe/5D9uf9GCbnV2OMRfsiY5gUQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894e31b1-e326-4548-c763-08d762f4be52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 20:05:59.6985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfRQQUBEH7E1pJes4cGW3aQ/vKFRkvz7Yf2Z8tzx1ePf4rsePbiZ/DHtCXQ4bqoE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2481
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKoBZRTHn3mKHIZXzN9S7/IgASRnnzgfpcW3LBkxOrY=;
 b=HObil/BapvpDW92/SciQiLChyUHsmYKNbUq/NCT0gXtDI3BqB5upTtoBkbHwZY3ANgUHgiHJ+FvTjlGoRk9VzuWPO2Btd4hEeHz+yRjFuAcRTN/SZBJHfs+c2mOzJiYS6tUTLxVLafyEbJAEBh9eulG8Ypce0aphDcQ6JOFxJOU=
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106200559.qZyy41FM1OrVBSAvYz5GpTTEpcMFMYhwAeulSX97B_o@z>

VGhhbmtzIEFsZXguIA0KDQo+IEFHUCBpcyBhbHNvIHVzZWQgZm9yIHBhZ2UgdGFibGVzIGluIHN5
c3RlbSBtZW1vcnkuDQpJIGFtIG5vdCBhd2FyZSBvZiB0aGlzIHVzYWdlLiBJIHRob3VnaHQgcGFn
ZSB0YWJsZSBhcmUgYWxsIGluIGZyYW1lIGJ1ZmZlciB0b2RheS4gV2FzIHRoaXMgYSB1c2UgY2Fz
ZSBpbiBvbGQgYXNpY3M/DQoNCk9haw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IA0KU2VudDogV2VkbmVzZGF5
LCBOb3ZlbWJlciA2LCAyMDE5IDEyOjM3IFBNDQpUbzogWmVuZywgT2FrIDxPYWsuWmVuZ0BhbWQu
Y29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogQWRkIGNvbW1l
bnRzIHRvIGdtYyBzdHJ1Y3R1cmUNCg0KT24gV2VkLCBOb3YgNiwgMjAxOSBhdCAxMjoyMSBQTSBa
ZW5nLCBPYWsgPE9hay5aZW5nQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBFeHBsYWluIGZpZWxkcyBs
aWtlIGFwZXJfYmFzZSwgYWdwX3N0YXJ0IGV0Yy4gVGhlIGRlZmluaXRpb24gb2YgdGhvc2UgDQo+
IGZpZWxkcyBhcmUgY29uZnVzaW5nIGFzIHRoZXkgYXJlIGZyb20gZGlmZmVyZW50IHZpZXcgKENQ
VSBvciBHUFUpLiBBZGQgDQo+IGNvbW1lbnRzIGZvciBlYXNpZXIgdW5kZXJzdGFuZC4NCj4NCj4g
Q2hhbmdlLUlkOiBJMDJjMmEyN2NkMGRiYzIwNTQ5OGViODZhYWZhNzIyZjJlMGMyNWZlNg0KPiBT
aWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4NCg0KQSBmZXcgY29tbWVu
dHMgYmVsb3csIG90aGVyd2lzZSBsb29rcyBnb29kIHRvIG1lLg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oIHwgMjUgDQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oDQo+IGluZGV4IDU1NWQ4ZTUu
LjgwMDMyMDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nbWMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgN
Cj4gQEAgLTEyNywxOCArMTI3LDQzIEBAIHN0cnVjdCBhbWRncHVfeGdtaSB7ICB9Ow0KPg0KPiAg
c3RydWN0IGFtZGdwdV9nbWMgew0KPiArICAgICAgIC8qIEZCJ3MgcGh5c2ljYWwgYWRkcmVzcyBp
biBNTUlPIHNwYWNlIChmb3IgQ1BVIHRvDQo+ICsgICAgICAgICogbWFwIEZCKS4gVGhpcyBpcyBk
aWZmZXJlbnQgY29tcGFyZWQgdG8gdGhlIGFwZy8NCg0KYXBnIC0+IGFncA0KDQo+ICsgICAgICAg
ICogZ2FydC92cmFtX3N0YXJ0L2VuZCBmaWVsZCBhcyB0aGUgbGF0ZXIgaXMgZnJvbQ0KPiArICAg
ICAgICAqIEdQVSdzIHZpZXcgYW5kIGFwZXJfYmFzZSBpcyBmcm9tIENQVSdzIHZpZXcuDQo+ICsg
ICAgICAgICovDQo+ICAgICAgICAgcmVzb3VyY2Vfc2l6ZV90ICAgICAgICAgYXBlcl9zaXplOw0K
PiAgICAgICAgIHJlc291cmNlX3NpemVfdCAgICAgICAgIGFwZXJfYmFzZTsNCj4gICAgICAgICAv
KiBmb3Igc29tZSBjaGlwcyB3aXRoIDw9IDMyTUIgd2UgbmVlZCB0byBsaWUNCj4gICAgICAgICAg
KiBhYm91dCB2cmFtIHNpemUgbmVhciBtYyBmYiBsb2NhdGlvbiAqLw0KPiAgICAgICAgIHU2NCAg
ICAgICAgICAgICAgICAgICAgIG1jX3ZyYW1fc2l6ZTsNCj4gICAgICAgICB1NjQgICAgICAgICAg
ICAgICAgICAgICB2aXNpYmxlX3ZyYW1fc2l6ZTsNCj4gKyAgICAgICAvKiBBUEcgYXBlcnR1cmUg
c3RhcnQgYW5kIGVuZCBpbiBNQyBhZGRyZXNzIHNwYWNlDQoNCkFQRyAtPiBBR1ANCg0KPiArICAg
ICAgICAqIERyaXZlciBmaW5kIGEgaG9sZSBpbiB0aGUgTUMgYWRkcmVzcyBzcGFjZQ0KPiArICAg
ICAgICAqIHRvIHBsYWNlIEFHUCBieSBzZXR0aW5nIE1DX1ZNX0FHUF9CT1QvVE9QIHJlZ2lzdGVy
cw0KPiArICAgICAgICAqIFVuZGVyIFZNSUQwLCBsb2dpY2FsIGFkZHJlc3MgPT0gTUMgYWRkcmVz
cw0KPiArICAgICAgICAqIEFHUCBhcGVydHVyZSBpcyB1c2VkIHRvIHNpbXVsYXRlIEZCIGluIFpG
QiBjYXNlDQo+ICsgICAgICAgICovDQoNCllvdSBtYXkgd2FudCB0byBhZGQgYSBjb21tZW50IHRo
YXQgdGhlIEFHUCBhcGVydHVyZSBqdXN0IG1hcHMgdG8gcGh5c2ljYWwgYnVzIG9yIElPVkEgYWRk
cmVzc2VzIG9uIHRoZSBwbGF0Zm9ybS4gIEl0J3MgYWxzbyB1c2VkIGZvciBwYWdlIHRhYmxlcyBp
biBzeXN0ZW0gbWVtb3J5Lg0KDQo+ICAgICAgICAgdTY0ICAgICAgICAgICAgICAgICAgICAgYWdw
X3NpemU7DQo+ICAgICAgICAgdTY0ICAgICAgICAgICAgICAgICAgICAgYWdwX3N0YXJ0Ow0KPiAg
ICAgICAgIHU2NCAgICAgICAgICAgICAgICAgICAgIGFncF9lbmQ7DQo+ICsgICAgICAgLyogR0FS
VCBhcGVydHVyZSBzdGFydCBhbmQgZW5kIGluIE1DIGFkZHJlc3Mgc3BhY2UNCj4gKyAgICAgICAg
KiBEcml2ZXIgZmluZCBhIGhvbGUgaW4gdGhlIE1DIGFkZHJlc3Mgc3BhY2UNCj4gKyAgICAgICAg
KiB0byBwbGFjZSBHQVJUIGJ5IHNldHRpbmcgVk1fQ09OVEVYVDBfUEFHRV9UQUJMRV9TVEFSVC9F
TkRfQUREUg0KPiArICAgICAgICAqIHJlZ2lzdGVycw0KPiArICAgICAgICAqIFVuZGVyIFZNSUQw
LCBsb2dpY2FsIGFkZHJlc3MgaW5zaWRlIEdBUlQgYXBlcnR1cmUgd2lsbA0KPiArICAgICAgICAq
IGJlIHRyYW5zbGF0ZWQgdGhyb3VnaCBncHV2bSBnYXJ0IHBhZ2UgdGFibGUgdG8gYWNjZXNzDQo+
ICsgICAgICAgICogcGFnZWQgc3lzdGVtIG1lbW9yeQ0KPiArICAgICAgICAqLw0KPiAgICAgICAg
IHU2NCAgICAgICAgICAgICAgICAgICAgIGdhcnRfc2l6ZTsNCj4gICAgICAgICB1NjQgICAgICAg
ICAgICAgICAgICAgICBnYXJ0X3N0YXJ0Ow0KPiAgICAgICAgIHU2NCAgICAgICAgICAgICAgICAg
ICAgIGdhcnRfZW5kOw0KPiArICAgICAgIC8qIEZyYW1lIGJ1ZmZlciBhcGVydHVyZSBvZiB0aGlz
IEdQVSBkZXZpY2UuIERpZmZlcmVudCBmcm9tDQo+ICsgICAgICAgICogZmJfc3RhcnQgKHNlZSBi
ZWxvdyksIHRoaXMgb25seSBjb3ZlcnMgdGhlIGxvY2FsIEdQVSBkZXZpY2UuDQo+ICsgICAgICAg
ICogRHJpdmVyIGdldCBmYl9zdGFydCBmcm9tIE1DX1ZNX0ZCX0xPQ0FUSU9OX0JBU0UgKHNldCBi
eSB2YmlvcykNCj4gKyAgICAgICAgKiBhbmQgY2FsY3VsYXRlIHZyYW1fc3RhcnQgb2YgdGhpcyBs
b2NhbCBkZXZpY2UgYnkgYWRkaW5nIGFuDQo+ICsgICAgICAgICogb2Zmc2V0IGluc2lkZSB0aGUg
WEdNSSBoaXZlLg0KPiArICAgICAgICAqLw0KPiAgICAgICAgIHU2NCAgICAgICAgICAgICAgICAg
ICAgIHZyYW1fc3RhcnQ7DQo+ICAgICAgICAgdTY0ICAgICAgICAgICAgICAgICAgICAgdnJhbV9l
bmQ7DQo+ICAgICAgICAgLyogRkIgcmVnaW9uICwgaXQncyBzYW1lIGFzIGxvY2FsIHZyYW0gcmVn
aW9uIGluIHNpbmdsZSBHUFUsIA0KPiBpbiBYR01JDQo+IC0tDQo+IDIuNy40DQo+DQo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFp
bGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
