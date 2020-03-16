Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D41EC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 09:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2142E20658
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 09:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Exh2Szcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2142E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432B289DF9;
	Mon, 16 Mar 2020 09:50:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969A089DF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 09:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX68FdhtKK5Nv45KnBf7Z0MrX+Nvag8HdQEnG0CvrpkYet5ZD5fdCMEmYKLUhUk61rnu/KQvjDKxXUeNhUT1vz+UZ4G+YrphOp1KgqWHoyo6492V0OGb8bq+0TLzUGW1jtrN28a3tzjpyzHVuDzYEINY4mWMOHgNP+tnGNTppbmNNR7ItjFmRoe6pxt7Hk0sMyIvFeXclbPAfFJsDboxODRlQ9HAWFGSzuQoKhv4J4ckt3Q0DBLrMRNOSiS3LIaZurrEmPWJuKDyzRmNTwPDydqA/2nAjWK7dtz615UoplP315x99IC1fIt81XCwQlt1YkytDkerdDQ/PjLaHTuBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jUAv/8WyBkF0NixOThhQYO8HbD+oUcGZ8GDSq6oanM=;
 b=Zv87sIIzI0wqUSzUCy1Eh5vuvFgWh31pKCDWz8P+3tXCiUulxIWtIMGUOcd1/oPHaWVMXRY6TkW9n81EtyNWGFQP1HklBrI+HNlq5OgmZIyBDvl6MkaGvrp8qipyrBSgXSKQBQoR0JH4n4zgmg0+lMfcmYgz+lmw8MCOS6LjGrAOmAD6qvk7ypyMLEJhpkOOx6IbsS/51A2e+TqLe4v1QVeOIM/V/Ikcs1b/Gp+/vlX1y+Y+VUvUTzPTBInJ2+Qlq01SkPwsDbHhEjfZVIog5oQl7WsM/8z75K0/MkkAyifQgWy3dTLNuJmqZqnlOF4LsYIQOdGylnDWC6LNXcYLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jUAv/8WyBkF0NixOThhQYO8HbD+oUcGZ8GDSq6oanM=;
 b=Exh2Szcw4oAJQP1stQ311fiGimRLKyDI7rFIRWPGyGCh2TL3V1P4EA3JW9rP2ZCDnYBjGprYJexaZ85VCcXWMfCRnfvLJi2c2VBDA4eKOaqQO5i4HB4Hq92NDANEQAgJu1XD0P8zzqP6TrUqEm2KzKjJSuLlGwLjX4Pzktgm3mA=
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27)
 by MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Mon, 16 Mar
 2020 09:50:09 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::c1c:df2d:4316:d9d8]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::c1c:df2d:4316:d9d8%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 09:50:08 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: miss PRT case when bo update
Thread-Topic: [PATCH] drm/amdgpu: miss PRT case when bo update
Thread-Index: AQHV+2fqTPnuo/x6mE+UDZBiX5GaoqhK9nWAgAADHGA=
Date: Mon, 16 Mar 2020 09:50:08 +0000
Message-ID: <MN2PR12MB303953FAAA23C2C5E3792E67E5F90@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <20200316075252.29897-1-yttao@amd.com>
 <920f9784-1259-bad9-502c-885f7da4748b@amd.com>
In-Reply-To: <920f9784-1259-bad9-502c-885f7da4748b@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e1b7e96-1fcb-4d8e-53af-08d7c98f69de
x-ms-traffictypediagnostic: MN2PR12MB3613:|MN2PR12MB3613:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3613B9DADEE6F912BAE47106E5F90@MN2PR12MB3613.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(199004)(4326008)(71200400001)(55016002)(9686003)(86362001)(2906002)(26005)(15650500001)(8936002)(33656002)(6636002)(66574012)(81166006)(81156014)(7696005)(6506007)(53546011)(76116006)(52536014)(5660300002)(478600001)(8676002)(316002)(110136005)(186003)(64756008)(66476007)(66446008)(66946007)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3613;
 H:MN2PR12MB3039.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B06VpHhosvJRxLUn7GoNNUjl7UpIT3FEBO13Xdw3C9foi0oaD7naiyu8Po0biLDPvBQTTDTG41VmfRFdkLYWENBOH8GowMUgqjG0LiqPDsNhN/Sh8XtPgdCFi9R7kBgHB5EPw5zRQ1mftxKRz3SjUYTLRpvP3wpqkE/udeKr6mTBN5e0pb1x9LaP4Ri5zRrgtHVCcyegxwjQAMeRHnLiq4dsb7c6eXYJVn/8KmZKffMqhBKsYihOckgN2hN0nimBuwOI/jlliUAp0oNU4tgS9lbwptY5dWoIwO2ekqw6f6qekC5r9Q++hQjumIriRJYX5R/xYDpTFO2TeVuUWoGrxh5VFhH4mHiW6i2wg0UPA9jTOSIm42BkXrtwNpHezCs2ykgyquOCKeKYEDzn0xKnuC+Jz0PvtM04ziA+ECa09iv0NU67c/frOb3bSafwBZyP
x-ms-exchange-antispam-messagedata: 75/RqkxDhBMXcbKM8vskCnNc4N63hlYa1p2jumAB8llSQtWkqAqSLAaoYN84etH+rZ9FhrlCFgW34uGb3AVcgMnCtaqdFxjefoR44jNaByXPZ874OYnWKIUvD/vDohwIo56BD4GRbb6DtKvgDJBJzw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1b7e96-1fcb-4d8e-53af-08d7c98f69de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 09:50:08.9089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twVZ25+v3znZJvsCQx65JCQO5SGEo0wt601mVhxhVQpjXnLEOCCCJnxYF5ywyVsx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3613
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuDQoNCk1hbnkgdGhhbmtzIGZvciB5b3VyIHJldmlldw0KDQpCZXN0IFJlZ2Fy
ZHMNCllpbnRpYW4gVGFvDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPiANClNlbnQ6IDIwMjDlubQz
5pyIMTbml6UgMTc6MzgNClRvOiBUYW8sIFlpbnRpYW4gPFlpbnRpYW4uVGFvQGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6
IG1pc3MgUFJUIGNhc2Ugd2hlbiBibyB1cGRhdGUNCg0KQW0gMTYuMDMuMjAgdW0gMDg6NTIgc2No
cmllYiBZaW50aWFuIFRhbzoNCj4gT3JpZ2luYWxseSwgb25seSB0aGUgUFRFIHZhbGlkIGlzIHRh
a2VuIGluIGNvbnNpZGVyLg0KPiBUaGUgUFJUIGNhc2UgaXMgbWlzc2llZCB3aGVuIGJvIHVwZGF0
ZSB3aGljaCByYWlzZSBwcm9ibGVtLg0KPiBXZSBuZWVkIGFkZCBjb25kaXRpb24gZm9yIFBSVCBj
YXNlLg0KDQpHb29kIGNhdGNoLCBqdXN0IG9uZSBzdHlsZSBuaXQgcGljayBiZWxvdy4NCg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBZaW50aWFuIFRhbyA8eXR0YW9AYW1kLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA1ICsrLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIA0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGluZGV4IDczMzk4ODMxMTk2Zi4u
N2EzZTQ1MTRhMDBjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Yw0KPiBAQCAtMTQ0Niw3ICsxNDQ2LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0
ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsDQo+ICAgCQl1aW50NjRf
dCBpbmNyLCBlbnRyeV9lbmQsIHBlX3N0YXJ0Ow0KPiAgIAkJc3RydWN0IGFtZGdwdV9ibyAqcHQ7
DQo+ICAgDQo+IC0JCWlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQpIHsNCj4gKwkJaWYgKGZs
YWdzICYgKEFNREdQVV9QVEVfVkFMSUQgfCBBTURHUFVfUFRFX1BSVCkpIHsNCj4gICAJCQkvKiBt
YWtlIHN1cmUgdGhhdCB0aGUgcGFnZSB0YWJsZXMgY292ZXJpbmcgdGhlDQo+ICAgCQkJICogYWRk
cmVzcyByYW5nZSBhcmUgYWN0dWFsbHkgYWxsb2NhdGVkDQo+ICAgCQkJICovDQo+IEBAIC0xNjA1
LDcgKzE2MDUsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1
Y3QgDQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgDQo+ICAgCWlmIChmbGFncyAmIEFNREdQ
VV9QVEVfVkFMSUQpIHsNCj4gICAJCXN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2bS0+cm9vdC5i
YXNlLmJvOw0KPiAtDQo+ICAgCQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9k
aXJlY3QpKQ0KDQpQbGVhc2Uga2VlcCB0aGlzIGVtcHR5IGxpbmUsIGl0IGlzIHJlcXVpcmVkIGJ5
IHRoZSBjb2Rpbmcgc3R5bGUgZ3VpZGVzLg0KDQpXaXRoIHRoYXQgZml4ZWQgdGhlIHBhdGNoIGlz
IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+ICAgCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3Qs
IHZtLT5sYXN0X2RpcmVjdCwgdHJ1ZSk7DQo+ICAgDQo+IEBAIC0xNzE4LDcgKzE3MTcsNyBAQCBz
dGF0aWMgaW50IGFtZGdwdV92bV9ib19zcGxpdF9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LA0KPiAgIAkJCQkJQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRTsNCj4gICAJCQl9
DQo+ICAgDQo+IC0JCX0gZWxzZSBpZiAoZmxhZ3MgJiBBTURHUFVfUFRFX1ZBTElEKSB7DQo+ICsJ
CX0gZWxzZSBpZiAoZmxhZ3MgJiAoQU1ER1BVX1BURV9WQUxJRCB8IEFNREdQVV9QVEVfUFJUKSkg
ew0KPiAgIAkJCWFkZHIgKz0gYm9fYWRldi0+dm1fbWFuYWdlci52cmFtX2Jhc2Vfb2Zmc2V0Ow0K
PiAgIAkJCWFkZHIgKz0gcGZuIDw8IFBBR0VfU0hJRlQ7DQo+ICAgCQl9DQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
