Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E06BC5DF61
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 09:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431022187F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 09:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431022187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50436F3B9;
	Thu,  7 Nov 2019 09:14:52 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690076.outbound.protection.outlook.com [40.107.69.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E456F3B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 09:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQMIQne2O2gfmtcEZcT0zVxCtl/O5BgPnQ439EsOIxm4o2kaIfqKuonmGoFph0zatAYsSdOVmTlIdChgYdULYK/QmJ6LGEFwJXj4nef3JrqCpTbkDNGyzJnwdkWT+8yFlSQ0byhWi0nikXrBHFExL2dCNCfqPBdahjFi8oH9BKpr7II76dBk+v1+X0CNIfRdkWDyGUe5lN6Cwqe2VEn87acUnHUWU6XA3CaXLezYUXmFl2sOM23+RVbAr068SMp8Yv8qzFsNbN232yNdgL8dzEdBVUS9VuT8DaCTs6+6WMjHinW/mYwzes4Q+aRbeib3ExRmScgLbkIIQjgAlrH6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NrfgbH83OaV7Hdnjsf00TGNElhLdmxcFdvOG3PJ/FA=;
 b=lIlLyyrtUBD+RyEK7Gn8ljkIfBHucvv7Qnub3B7d8iAFYVTlQIY8TuSWI/kRx62cUIEgJJmO014Kg07IaHr1iInrG4miaHNjxIVftVZhcTTX5JAA5L7hv6s5/hMLqiceFftGwYGy8Mt4LgRQY947w2WoJ0rCLknhM2057I3o5gFlGTfZhIXnCDwrg7wqxvWQ1FQKFjyezhP/nSoBYFMy1L8O61+WqLXCQYPBaV5neral4krJVO5g0hmAS4Dx6YMWvSiL8R/OzgYi7mvMKkm4S7OLjBZpalsvWhkgJ7Akp8P8TH6UB1ePvBdWuNX8EDVVwa/cRFJk+Rqy8EItqEuPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2454.namprd12.prod.outlook.com (52.132.208.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 7 Nov 2019 09:14:48 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 09:14:48 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Topic: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Index: AQHVlMaoZiNzkpPO+kWeyC0qA10mc6d+aBAAgAApHgCAANzYAA==
Date: Thu, 7 Nov 2019 09:14:47 +0000
Message-ID: <488fd8f5-7fb6-7a27-52e3-56c0b3d428c4@amd.com>
References: <1573060895-13033-1-git-send-email-Oak.Zeng@amd.com>
 <CADnq5_NAyRJF-26XV-QnVEQ4pD9NobmBvcGcnJTUqcO0OOe62Q@mail.gmail.com>
 <BL0PR12MB25806AAB4587D5E2AD0FCCBA80790@BL0PR12MB2580.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB25806AAB4587D5E2AD0FCCBA80790@BL0PR12MB2580.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR05CA0063.eurprd05.prod.outlook.com
 (2603:10a6:208:be::40) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1908630-68d4-4b22-2c61-08d76362efcf
x-ms-traffictypediagnostic: DM5PR12MB2454:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB245447562CB79919C2982E1783780@DM5PR12MB2454.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(13464003)(189003)(199004)(446003)(486006)(46003)(5660300002)(2616005)(476003)(25786009)(8936002)(11346002)(256004)(8676002)(81156014)(2906002)(81166006)(14444005)(71190400001)(71200400001)(36756003)(31686004)(6436002)(76176011)(229853002)(58126008)(4326008)(54906003)(110136005)(966005)(316002)(6512007)(65806001)(102836004)(52116002)(14454004)(65956001)(53546011)(6506007)(386003)(6486002)(6306002)(99286004)(478600001)(66946007)(6116002)(186003)(64756008)(66476007)(66556008)(66446008)(31696002)(305945005)(7736002)(6246003)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2454;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJezrd/uEG0RPWmvTER4H7rnp0LBhRrm00gAEFViZvSP+ST+ZgyQtKTDSx7iujEB3P+5ggtcFarZyOG/V+tyFMnuSerZ2f4wLrZs3/ruyoLFYbGUHsZaOcb00jfEojG3sUtHrSVyjpp+WOUZGxgWKPDG8Tjsf8nFrKEdFdaSmcRCFyBiQLIkTe1FB+eeg3jQNJ9RUW+v2VzHRMVOBnRJoOiJam2X7+3OoNHmcQyl/wrhKyReLDcPzYVwXpQQGaz9tLkDaKjWD6Uyo1GNc1TYKliRho03m3x3263Q7NlacbjU/yfX2FUcZEcD3ckeTDP36QfDOf4NDUQX3XMn2IjHXgRdUw2snln7fA8rYsjZsVFjBAjy/Qwg1j1j/kwDEI+MjIpCEpbR7S8bhyHrD2lP9+Bo2oD7nMdxJ5QwseS3nj4OnyXJ9DPwkQBnAkrGWnUfvDzQwVNlxkp9JVzQP48rYdueNcg845eqk+R0VmJZims=
Content-ID: <8BF99791B0882E41BA4867E1884AD55A@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1908630-68d4-4b22-2c61-08d76362efcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 09:14:47.9120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0M/UzZgbZ57j+7sYJX+1sRPt7/Amls8pCo/8Nb9mZzy2gbr8Gc4SbF8Vxmuxa9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NrfgbH83OaV7Hdnjsf00TGNElhLdmxcFdvOG3PJ/FA=;
 b=QzyMRae+XV1Kic4oCpixhPJEE6P+YYwoBh2WoiqFwT+fB7miIHKWsZlGdnVC5DL2tQTPDNWzI2ds8QeYtIeYrCXYEM71u7pVDU5XLqYoNcs5tqS+xbv4mCzvxWqz5lR+KkzvnzcCqYg98vYHJm9X8eBMjTWmItHpPiHzVk5+4rA=
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107091447.Eqe_DcKLQLd0mzqmnXQjQe4i0JXhOWLCzbko2fTg1Fk@z>

QW0gMDYuMTEuMTkgdW0gMjE6MDUgc2NocmllYiBaZW5nLCBPYWs6DQo+IFRoYW5rcyBBbGV4Lg0K
Pg0KPj4gQUdQIGlzIGFsc28gdXNlZCBmb3IgcGFnZSB0YWJsZXMgaW4gc3lzdGVtIG1lbW9yeS4N
Cj4gSSBhbSBub3QgYXdhcmUgb2YgdGhpcyB1c2FnZS4gSSB0aG91Z2h0IHBhZ2UgdGFibGUgYXJl
IGFsbCBpbiBmcmFtZSBidWZmZXIgdG9kYXkuIFdhcyB0aGlzIGEgdXNlIGNhc2UgaW4gb2xkIGFz
aWNzPw0KDQpObywgdGhhdCBpcyBwcmV0dHkgbmV3IGFuZCBvbmx5IHdvcmtzIGZvciBSZW5vaXIu
IEJ1dCB3ZSBoYXZlIGRpc2FibGVkIA0KaXQgY3VycmVudGx5IGJlY2F1c2Ugb2YgYmFkIGludGVy
YWN0aW9ucyB3aXRoIElPTU1VLg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gT2FrDQo+DQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJA
Z21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDYsIDIwMTkgMTI6MzcgUE0N
Cj4gVG86IFplbmcsIE9hayA8T2FrLlplbmdAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBBZGQgY29tbWVudHMgdG8gZ21jIHN0cnVjdHVyZQ0K
Pg0KPiBPbiBXZWQsIE5vdiA2LCAyMDE5IGF0IDEyOjIxIFBNIFplbmcsIE9hayA8T2FrLlplbmdA
YW1kLmNvbT4gd3JvdGU6DQo+PiBFeHBsYWluIGZpZWxkcyBsaWtlIGFwZXJfYmFzZSwgYWdwX3N0
YXJ0IGV0Yy4gVGhlIGRlZmluaXRpb24gb2YgdGhvc2UNCj4+IGZpZWxkcyBhcmUgY29uZnVzaW5n
IGFzIHRoZXkgYXJlIGZyb20gZGlmZmVyZW50IHZpZXcgKENQVSBvciBHUFUpLiBBZGQNCj4+IGNv
bW1lbnRzIGZvciBlYXNpZXIgdW5kZXJzdGFuZC4NCj4+DQo+PiBDaGFuZ2UtSWQ6IEkwMmMyYTI3
Y2QwZGJjMjA1NDk4ZWI4NmFhZmE3MjJmMmUwYzI1ZmU2DQo+PiBTaWduZWQtb2ZmLWJ5OiBPYWsg
WmVuZyA8T2FrLlplbmdAYW1kLmNvbT4NCj4gQSBmZXcgY29tbWVudHMgYmVsb3csIG90aGVyd2lz
ZSBsb29rcyBnb29kIHRvIG1lLg0KPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuaCB8IDI1DQo+PiArKysrKysrKysrKysrKysrKysrKysrKysrDQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaA0KPj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgNCj4+IGluZGV4IDU1NWQ4ZTUuLjgwMDMyMDEg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgN
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaA0KPj4gQEAg
LTEyNywxOCArMTI3LDQzIEBAIHN0cnVjdCBhbWRncHVfeGdtaSB7ICB9Ow0KPj4NCj4+ICAgc3Ry
dWN0IGFtZGdwdV9nbWMgew0KPj4gKyAgICAgICAvKiBGQidzIHBoeXNpY2FsIGFkZHJlc3MgaW4g
TU1JTyBzcGFjZSAoZm9yIENQVSB0bw0KPj4gKyAgICAgICAgKiBtYXAgRkIpLiBUaGlzIGlzIGRp
ZmZlcmVudCBjb21wYXJlZCB0byB0aGUgYXBnLw0KPiBhcGcgLT4gYWdwDQo+DQo+PiArICAgICAg
ICAqIGdhcnQvdnJhbV9zdGFydC9lbmQgZmllbGQgYXMgdGhlIGxhdGVyIGlzIGZyb20NCj4+ICsg
ICAgICAgICogR1BVJ3MgdmlldyBhbmQgYXBlcl9iYXNlIGlzIGZyb20gQ1BVJ3Mgdmlldy4NCj4+
ICsgICAgICAgICovDQo+PiAgICAgICAgICByZXNvdXJjZV9zaXplX3QgICAgICAgICBhcGVyX3Np
emU7DQo+PiAgICAgICAgICByZXNvdXJjZV9zaXplX3QgICAgICAgICBhcGVyX2Jhc2U7DQo+PiAg
ICAgICAgICAvKiBmb3Igc29tZSBjaGlwcyB3aXRoIDw9IDMyTUIgd2UgbmVlZCB0byBsaWUNCj4+
ICAgICAgICAgICAqIGFib3V0IHZyYW0gc2l6ZSBuZWFyIG1jIGZiIGxvY2F0aW9uICovDQo+PiAg
ICAgICAgICB1NjQgICAgICAgICAgICAgICAgICAgICBtY192cmFtX3NpemU7DQo+PiAgICAgICAg
ICB1NjQgICAgICAgICAgICAgICAgICAgICB2aXNpYmxlX3ZyYW1fc2l6ZTsNCj4+ICsgICAgICAg
LyogQVBHIGFwZXJ0dXJlIHN0YXJ0IGFuZCBlbmQgaW4gTUMgYWRkcmVzcyBzcGFjZQ0KPiBBUEcg
LT4gQUdQDQo+DQo+PiArICAgICAgICAqIERyaXZlciBmaW5kIGEgaG9sZSBpbiB0aGUgTUMgYWRk
cmVzcyBzcGFjZQ0KPj4gKyAgICAgICAgKiB0byBwbGFjZSBBR1AgYnkgc2V0dGluZyBNQ19WTV9B
R1BfQk9UL1RPUCByZWdpc3RlcnMNCj4+ICsgICAgICAgICogVW5kZXIgVk1JRDAsIGxvZ2ljYWwg
YWRkcmVzcyA9PSBNQyBhZGRyZXNzDQo+PiArICAgICAgICAqIEFHUCBhcGVydHVyZSBpcyB1c2Vk
IHRvIHNpbXVsYXRlIEZCIGluIFpGQiBjYXNlDQo+PiArICAgICAgICAqLw0KPiBZb3UgbWF5IHdh
bnQgdG8gYWRkIGEgY29tbWVudCB0aGF0IHRoZSBBR1AgYXBlcnR1cmUganVzdCBtYXBzIHRvIHBo
eXNpY2FsIGJ1cyBvciBJT1ZBIGFkZHJlc3NlcyBvbiB0aGUgcGxhdGZvcm0uICBJdCdzIGFsc28g
dXNlZCBmb3IgcGFnZSB0YWJsZXMgaW4gc3lzdGVtIG1lbW9yeS4NCj4NCj4+ICAgICAgICAgIHU2
NCAgICAgICAgICAgICAgICAgICAgIGFncF9zaXplOw0KPj4gICAgICAgICAgdTY0ICAgICAgICAg
ICAgICAgICAgICAgYWdwX3N0YXJ0Ow0KPj4gICAgICAgICAgdTY0ICAgICAgICAgICAgICAgICAg
ICAgYWdwX2VuZDsNCj4+ICsgICAgICAgLyogR0FSVCBhcGVydHVyZSBzdGFydCBhbmQgZW5kIGlu
IE1DIGFkZHJlc3Mgc3BhY2UNCj4+ICsgICAgICAgICogRHJpdmVyIGZpbmQgYSBob2xlIGluIHRo
ZSBNQyBhZGRyZXNzIHNwYWNlDQo+PiArICAgICAgICAqIHRvIHBsYWNlIEdBUlQgYnkgc2V0dGlu
ZyBWTV9DT05URVhUMF9QQUdFX1RBQkxFX1NUQVJUL0VORF9BRERSDQo+PiArICAgICAgICAqIHJl
Z2lzdGVycw0KPj4gKyAgICAgICAgKiBVbmRlciBWTUlEMCwgbG9naWNhbCBhZGRyZXNzIGluc2lk
ZSBHQVJUIGFwZXJ0dXJlIHdpbGwNCj4+ICsgICAgICAgICogYmUgdHJhbnNsYXRlZCB0aHJvdWdo
IGdwdXZtIGdhcnQgcGFnZSB0YWJsZSB0byBhY2Nlc3MNCj4+ICsgICAgICAgICogcGFnZWQgc3lz
dGVtIG1lbW9yeQ0KPj4gKyAgICAgICAgKi8NCj4+ICAgICAgICAgIHU2NCAgICAgICAgICAgICAg
ICAgICAgIGdhcnRfc2l6ZTsNCj4+ICAgICAgICAgIHU2NCAgICAgICAgICAgICAgICAgICAgIGdh
cnRfc3RhcnQ7DQo+PiAgICAgICAgICB1NjQgICAgICAgICAgICAgICAgICAgICBnYXJ0X2VuZDsN
Cj4+ICsgICAgICAgLyogRnJhbWUgYnVmZmVyIGFwZXJ0dXJlIG9mIHRoaXMgR1BVIGRldmljZS4g
RGlmZmVyZW50IGZyb20NCj4+ICsgICAgICAgICogZmJfc3RhcnQgKHNlZSBiZWxvdyksIHRoaXMg
b25seSBjb3ZlcnMgdGhlIGxvY2FsIEdQVSBkZXZpY2UuDQo+PiArICAgICAgICAqIERyaXZlciBn
ZXQgZmJfc3RhcnQgZnJvbSBNQ19WTV9GQl9MT0NBVElPTl9CQVNFIChzZXQgYnkgdmJpb3MpDQo+
PiArICAgICAgICAqIGFuZCBjYWxjdWxhdGUgdnJhbV9zdGFydCBvZiB0aGlzIGxvY2FsIGRldmlj
ZSBieSBhZGRpbmcgYW4NCj4+ICsgICAgICAgICogb2Zmc2V0IGluc2lkZSB0aGUgWEdNSSBoaXZl
Lg0KPj4gKyAgICAgICAgKi8NCj4+ICAgICAgICAgIHU2NCAgICAgICAgICAgICAgICAgICAgIHZy
YW1fc3RhcnQ7DQo+PiAgICAgICAgICB1NjQgICAgICAgICAgICAgICAgICAgICB2cmFtX2VuZDsN
Cj4+ICAgICAgICAgIC8qIEZCIHJlZ2lvbiAsIGl0J3Mgc2FtZSBhcyBsb2NhbCB2cmFtIHJlZ2lv
biBpbiBzaW5nbGUgR1BVLA0KPj4gaW4gWEdNSQ0KPj4gLS0NCj4+IDIuNy40DQo+Pg0KPj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGFtZC1nZngg
bWFpbGluZyBsaXN0DQo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
