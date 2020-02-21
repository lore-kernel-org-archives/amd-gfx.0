Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51837C35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C29206EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e2Tod/K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C29206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBB06F477;
	Fri, 21 Feb 2020 15:18:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCFF26F477
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 15:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAHIvpWuyZnxPuWS7WaaYlTpS7wzpjOBOXFP4DUkUtenXDfO5M2giqUCivflAqT7eu1vLIG0l02eN2ei5fi0k43rfd9P9VN6LAGmxQWBXHvjh0TMT424ZFjzBFSSzraFtVYIPREcc1ixdRYSqU7IWn2910Pps9bJNyRgio90RH13sg6oGnQgwjRfvqAvTrzyClf04seqvGUQzG/xq1qrGDE04WX/oHBNBce0iwcM31ecqwYXCKwmwn4+qEI18gyCoc6tzjR+F2XyoTY/LLpXjUeEXxGPFGsG+7uFBr63YmLOgejNdDY2dHvZvCwy4iY2ornj+Fb+6N6PwNhakzqkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4JnIuzf4CL4dXtXFPEPRvKyuXcXSPrg+iQnYDWZGmI=;
 b=Zqo2qDd37vq7u6Bdqct1Z/jj9n3xB5qG4vuO/h/7XOwvErhgzimvE3IWgtJLxBgq9x0cSUDmaE3ACNvtBcwzxRu6wrgxpSPM8CFKqyTF/ELvYB+e3RdO0p0HjxCwANAXKGq4MyeVjl4DNGKkVPNlNzNFwMT09PMZNxb+Yyw1fPAiLIOmXcn4/WUgZNn2gc8hMLnNkVkgV7gY4sewmqNBJ5UaoGLx0f8KLxHKi2Bgxasp213JEY3QbswUTrbIzHXS0SIcR5Ky5NHYEg74oGksWGt1PIIqjrBzHE+/kIhaWX9rH9dRsuWqVcEpK+HUCI/uiOG/hBOoSzr2LdQmfrq+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4JnIuzf4CL4dXtXFPEPRvKyuXcXSPrg+iQnYDWZGmI=;
 b=e2Tod/K7axf3ZegTz/UDnz5ElFJGQRmD1B1uwdDwYIMREGupGJapbQXNR0yh4G+kni3bks9kvs7I7JEvkTY2cgSu+8Ts+RoEfevEovpgYTIdZhDOhCK2elZ2ypoUa2YCbxG+sv2C3PtWAlbt5t9padEItiVx6My+2RYqwqfkAKI=
Received: from DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Fri, 21 Feb
 2020 15:18:08 +0000
Received: from DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3]) by DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 15:18:07 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "StDenis, Tom" <Tom.StDenis@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBkaXNhYmxlIEdGWE9G?=
 =?utf-8?Q?F_around_debugfs_access_to_MMIO?=
Thread-Topic: [PATCH] drm/amd/amdgpu: disable GFXOFF around debugfs access to
 MMIO
Thread-Index: AQHV5zXmRTs/SpgQjE+XyOIGewaz5aginj+AgAAAkwCAAxqrAIAADCjA
Date: Fri, 21 Feb 2020 15:18:07 +0000
Message-ID: <DM6PR12MB393101FB6C3250020720509A84120@DM6PR12MB3931.namprd12.prod.outlook.com>
References: <20200219150417.510884-1-tom.stdenis@amd.com>
 <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
 <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
 <20200221143359.GF28698@jenkins-Celadon-RN>
In-Reply-To: <20200221143359.GF28698@jenkins-Celadon-RN>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd7e3a64-8beb-4ca7-f92f-08d7b6e1418e
x-ms-traffictypediagnostic: DM6PR12MB4298:|DM6PR12MB4298:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4298D6729C2CB8D896F1638F84120@DM6PR12MB4298.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(53546011)(2906002)(6506007)(55016002)(9686003)(54906003)(71200400001)(81166006)(4326008)(110136005)(186003)(316002)(76116006)(8936002)(26005)(66946007)(86362001)(33656002)(224303003)(6636002)(64756008)(66476007)(66556008)(66446008)(45080400002)(5660300002)(81156014)(966005)(52536014)(478600001)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4298;
 H:DM6PR12MB3931.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwBdHiakRIKu5D1ozL86wiCB315fws1Q4+Qgby3FU6Me8MbFC/mqWE+wqSl5jO9HBVxwqu0ffQzrbjdXaLjV8kAjc6VWqS3WbzH9Qt5+mt2qXhR0LI2INNjGHWxJ0hbTbpt2pkQkEWrbPo7+VRDI9Vp/P/niO+o/NicfXiefobuLQHLCcb/AJ9ro97db1vYYe9fzAhe7uwZ7qnz08MwuNkCwT6WQay18BQBQcKQ7cmBOQ4wESA5ar3yIvk8VeGy515j/Td+7jkon+cPhU7pSblrWZDv9qhk45dcTtxVACqXYYKeiUQZA5kdzpV65QB67I2KRoKrbHlstqIYACsiOwfxGd7VVlYPdYKNU18X9GzWO21l4t1WElgIO/YVJ4TBY8uUtVoaWmgEuf3zK38qXq+y+1UTyPkFplKLe99K5LGhdHSHpZiO6hLS9+m0MBGiewxS1gn9Nbaw4XAtz+/b0ojfSqiNVNI+NxnBq2ZlAYWraUz9tBZjw6JSmI2rqLW2LDWxYiHLsQrd67oPMotxu6hUGXJU5MrRfxIaV+KPXsfDz47HdxtQzC7gM4bKYkhw5mb6mtVebJClqlDivxANNAdsgNBQTfT8zFjl4LUgvv3UFbp95psFchY9rPGMGQR0k
x-ms-exchange-antispam-messagedata: tbSHbnRPuSlzYVonMMt6X3hilYYSGerLVLMdBgBdJmyVKfkGKFg9P5WRxbPO1o0hyjYTPtvo25yAFZfWLaj6FcdWa3GPtBKHn9ENVbhH5/MTzBm+vOkPKRDK9Yf2/e7f+eO99zCalPA5Q5ilBXrUQw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7e3a64-8beb-4ca7-f92f-08d7b6e1418e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 15:18:07.8431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4WQkzQxehj7MqJK+xtOavoA/0y1e1HmIvPS5rKbhDrBFZgsRRnE02y3SGuvFj/L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QmV0dGVyIG5vdCB1c2UgS0lRLCBiZWNhdXNlIHdoZW4geW91IHVzZSBkZWJ1Z2ZzIHRvIHJlYWQg
cmVnaXN0ZXIgeW91IHVzdWFsbHkgaGl0IGEgaGFuZywgYW5kIGJ5IHRoYXQgY2FzZSBLSVEgcHJv
YmFibHkgYWxyZWFkeSBkaWUgDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujog
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4g5Luj6KGoIEh1
YW5nIFJ1aQ0K5Y+R6YCB5pe26Ze0OiAyMDIw5bm0MuaciDIx5pelIDIyOjM0DQrmlLbku7bkuro6
IFN0RGVuaXMsIFRvbSA8VG9tLlN0RGVuaXNAYW1kLmNvbT4NCuaKhOmAgTogQWxleCBEZXVjaGVy
IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+OyBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPg0K5Li76aKYOiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogZGlzYWJs
ZSBHRlhPRkYgYXJvdW5kIGRlYnVnZnMgYWNjZXNzIHRvIE1NSU8NCg0KT24gV2VkLCBGZWIgMTks
IDIwMjAgYXQgMTA6MDk6NDZBTSAtMDUwMCwgVG9tIFN0IERlbmlzIHdyb3RlOg0KPiBJIGdvdCBz
b21lIG1lc3NhZ2VzIGFmdGVyIGEgd2hpbGU6DQo+IA0KPiBbwqAgNzQxLjc4ODU2NF0gRmFpbGVk
IHRvIHNlbmQgTWVzc2FnZSA4Lg0KPiBbwqAgNzQ2LjY3MTUwOV0gRmFpbGVkIHRvIHNlbmQgTWVz
c2FnZSA4Lg0KPiBbwqAgNzQ4Ljc0OTY3M10gRmFpbGVkIHRvIHNlbmQgTWVzc2FnZSAyYi4NCj4g
W8KgIDc1OS4yNDU0MTRdIEZhaWxlZCB0byBzZW5kIE1lc3NhZ2UgNy4NCj4gW8KgIDc2My4yMTY5
MDJdIEZhaWxlZCB0byBzZW5kIE1lc3NhZ2UgMmEuDQo+IA0KPiBBcmUgdGhlcmUgYW55IGFkZGl0
aW9uYWwgbG9ja3MgdGhhdCBzaG91bGQgYmUgaGVsZD/CoCBCZWNhdXNlIHNvbWUgDQo+IGNvbW1h
bmRzIGxpa2UgLS10b3Agb3IgLS13YXZlcyBjYW4gZG8gYSBsb3Qgb2YgZGlzdGluY3QgcmVhZCAN
Cj4gb3BlcmF0aW9ucyAoY2F1c2luZyBhIGxvdCBvZiBlbmFibGUvZGlzYWJsZSBjYWxscykuDQo+
IA0KPiBJJ20gZ29pbmcgdG8gc2l0IG9uIHRoaXMgYSBiaXQgc2luY2UgSSBkb24ndCB0aGluayB0
aGUgcGF0Y2ggaXMgcmVhZHkgDQo+IGZvciBwdXNoaW5nIG91dC4NCj4gDQoNCkhvdyBhYm91dCB1
c2UgUlJFRzMyX0tJUSBhbmQgV1JFRzMyX0tJUT8NCg0KVGhhbmtzLA0KUmF5DQoNCj4gDQo+IFRv
bQ0KPiANCj4gT24gMjAyMC0wMi0xOSAxMDowNyBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+
ID4gT24gV2VkLCBGZWIgMTksIDIwMjAgYXQgMTA6MDQgQU0gVG9tIFN0IERlbmlzIDx0b20uc3Rk
ZW5pc0BhbWQuY29tPiB3cm90ZToNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5pcyA8
dG9tLnN0ZGVuaXNAYW1kLmNvbT4NCj4gPiBQbGVhc2UgYWRkIGEgcGF0Y2ggZGVzY3JpcHRpb24u
ICBXaXRoIHRoYXQgZml4ZWQ6DQo+ID4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiANCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jIHwgMyArKysNCj4gPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyANCj4gPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPiA+ID4gaW5kZXggNzM3OTkx
MDc5MGM5Li42NmY3NjMzMDBjOTYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+ID4gPiBAQCAtMTY5LDYgKzE2OSw3IEBAIHN0
YXRpYyBpbnQgIGFtZGdwdV9kZWJ1Z2ZzX3Byb2Nlc3NfcmVnX29wKGJvb2wgcmVhZCwgc3RydWN0
IGZpbGUgKmYsDQo+ID4gPiAgICAgICAgICBpZiAocG1fcGdfbG9jaykNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgbXV0ZXhfbG9jaygmYWRldi0+cG0ubXV0ZXgpOw0KPiA+ID4gDQo+ID4gPiArICAg
ICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZmFsc2UpOw0KPiA+ID4gICAgICAgICAgd2hp
bGUgKHNpemUpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgdWludDMyX3QgdmFsdWU7DQo+ID4g
PiANCj4gPiA+IEBAIC0xOTIsNiArMTkzLDggQEAgc3RhdGljIGludCAgYW1kZ3B1X2RlYnVnZnNf
cHJvY2Vzc19yZWdfb3AoYm9vbCByZWFkLCBzdHJ1Y3QgZmlsZSAqZiwNCj4gPiA+ICAgICAgICAg
IH0NCj4gPiA+IA0KPiA+ID4gICBlbmQ6DQo+ID4gPiArICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0
cmwoYWRldiwgdHJ1ZSk7DQo+ID4gPiArDQo+ID4gPiAgICAgICAgICBpZiAodXNlX2JhbmspIHsN
Cj4gPiA+ICAgICAgICAgICAgICAgICAgYW1kZ3B1X2dmeF9zZWxlY3Rfc2Vfc2goYWRldiwgMHhm
ZmZmZmZmZiwgMHhmZmZmZmZmZiwgMHhmZmZmZmZmZik7DQo+ID4gPiAgICAgICAgICAgICAgICAg
IG11dGV4X3VubG9jaygmYWRldi0+Z3JibV9pZHhfbXV0ZXgpOw0KPiA+ID4gLS0NCj4gPiA+IDIu
MjQuMQ0KPiA+ID4gDQo+ID4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiA+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gPiA+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkYNCj4gPiA+IGxpc3RzLmZyZWVkZXNr
dG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlNw0KPiA+
ID4gQzAxJTdDbW9uay5saXUlNDBhbWQuY29tJTdDYmE0NWVmYjI2YzAyNDBlZDAzNmYwOGQ3YjZk
YjIwYWElN0MzZGQ4DQo+ID4gPiA5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAl
N0M2MzcxNzg5MjQ2MDU1MjQzNzgmYW1wO3NkYXQNCj4gPiA+IGE9JTJGeUhrdllVNVQlMkY0aUZ4
UmV4c2clMkJJZG03c0R6eVhianpOcEhVR0NPN2g0ayUzRCZhbXA7cmVzZXJ2ZQ0KPiA+ID4gZD0w
DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFt
ZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0
dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmxpc3QNCj4gcy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZh
bWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0Ntbw0KPiBuay5saXUlNDBhbWQuY29tJTdDYmE0NWVm
YjI2YzAyNDBlZDAzNmYwOGQ3YjZkYjIwYWElN0MzZGQ4OTYxZmU0ODg0ZTYwDQo+IDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3ODkyNDYwNTUyNDM3OCZhbXA7c2RhdGE9JTJGeUhrdllV
NVQlMkYNCj4gNGlGeFJleHNnJTJCSWRtN3NEenlYYmp6TnBIVUdDTzdoNGslM0QmYW1wO3Jlc2Vy
dmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQph
bWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBz
Oi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngm
YW1wO2RhdGE9MDIlN0MwMSU3Q21vbmsubGl1JTQwYW1kLmNvbSU3Q2JhNDVlZmIyNmMwMjQwZWQw
MzZmMDhkN2I2ZGIyMGFhJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdD
MCU3QzYzNzE3ODkyNDYwNTUyNDM3OCZhbXA7c2RhdGE9JTJGeUhrdllVNVQlMkY0aUZ4UmV4c2cl
MkJJZG03c0R6eVhianpOcEhVR0NPN2g0ayUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
