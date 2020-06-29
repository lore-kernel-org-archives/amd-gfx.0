Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A94DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 09:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D7723139
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 09:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hxd5a5f/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D7723139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA3189803;
	Mon, 29 Jun 2020 09:03:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D828E8991E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 09:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJbcW3WQb5nkz1Copb9hAxK4D1fknHmjYrhu75ZX/AGhHS+DqgIu9oBxHi4ul0idd/n5zHnfwRkyJ11Y6/YvnbusZ4CEweAaM0tR4rqxhBdLfHnXXn1ACFmXTS0Ow5ek0ZZxTDEn+JKeDlAOQ98gGhzXbueZ77f9tGF8prLOh4uKHEPdmu4cc4cwMnnp4AwxUGJ8JqI+9p7I/DPcTKTsmmz+yiPS0eadKzwFSSiDExwHHfybYio0awfGmdme2J4wGtLmVFrchgAdKc9kgD16mJ2ff0hlcNewXdIFa4vViepuvumA0j2dxs2jw1DHV5Q7BrAu3jmeJ2FMNllQo712Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QKm6+yJbYVGCWN8MTIfqQDQGBIwotg9wTbmwtRn6pk=;
 b=FrK/eWvotltZgipB31DrVnipqXdhVl8sBUXItuPV7L6WgZ1cU3yn5bGzwU+YZzQKS0dFuo3j0CgFAeM1SpAfOBY9b4mIFjAvBSR/NsyodG6FYOeRPtYvM2OscdNH1tG9gUoPGInGfhMd2RLG2VQXFDAwFIi6BCHKw8DepoSDzoe71Y59VjtT36OX3qyHBD489EIYPeLVkUgXAy6UWE46XYpflvXW/62gF1XrK42y4zkW3Z5127m25smbfsa0RBCBONGk6GJO2BYkS/gCBsPJDWYWewMJNzejfbewdAiUh+xqYhYwbAPsQzIRmY6MYPj1mr3LzZN67suRldA2vn0b5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QKm6+yJbYVGCWN8MTIfqQDQGBIwotg9wTbmwtRn6pk=;
 b=Hxd5a5f/qS5U542k4du1LSnzx7f+/A4OgyVfXaANo8vpsLGLVDwX15JPN0EY60U7cfT1RhAMlfHtq6MvXLpEYkm+F1n/bYSN897u2cZbOgHRdL5EHz+BdSHI667dEnUUJPgDVqNoHXSh8coP3PDBgBgX/x5g7ix/PzXOqzbKXhY=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Mon, 29 Jun
 2020 09:03:10 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570%5]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:03:10 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: make IB test synchronize with init for SRIOV
Thread-Topic: [PATCH] drm/amdgpu: make IB test synchronize with init for SRIOV
Thread-Index: AQHWTeSGtADQcpSZ30m1pXWGaD3UoqjvP+4AgAAJ8oA=
Date: Mon, 29 Jun 2020 09:03:10 +0000
Message-ID: <DM5PR12MB170868B80FD72B9E39CEC5BA846E0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1593414689-17565-1-git-send-email-Monk.Liu@amd.com>
 <87e8a1bc-62b7-5599-4263-dd63546f69f7@gmail.com>
In-Reply-To: <87e8a1bc-62b7-5599-4263-dd63546f69f7@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ada98bb-0689-49a1-520f-08d81c0b3f41
x-ms-traffictypediagnostic: DM6PR12MB4385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB43851526E6E18BBB7DD9F363846E0@DM6PR12MB4385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMFM6GBxKhWkG0jWGRQSuwKpo34dHWUvFk7ryGZWJIuITfHT679OJMK17zIZpoCcCR0+ufQd78kBN1CCGZtfdA8tmdohQxUaHGQyD7Ve0FuU2ql3YTZem1zVcKM7qF6Kn37raPowrmVfQE24r92oYU9wMjeuXI4Y94W8zFy+8S9dKa+D7S+fP2Qi1ntmvROmALCxnqdJEKK3RlrOTCFc03nlCYgZbDDfYoOjdlX/atnuMGNl4/7cMSxUeNfnQPaILVVp08Cnoz7myG1dNT6HmYkspvjcWZBzmhy+dxfM3J11dtxmbjKB4AweZfqIkr1aqixyJIr3DHVSmK4qqe/Dkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(8676002)(186003)(66946007)(76116006)(64756008)(66476007)(316002)(66446008)(9686003)(71200400001)(66574015)(110136005)(66556008)(55016002)(52536014)(7696005)(33656002)(478600001)(53546011)(6506007)(26005)(8936002)(86362001)(83380400001)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qNEJz26giLP+Mo2EEc2ogQ5yFShDdOcPgGG98SPCkXmzXd2xzM1oro9t+jIW8Yrg/fnLULCxcz8DNlasqNWh94CcfDo+eAPtYSdj84gkpiBtd6X00bWIOp0LXr4aimfWKUSiD/aDpUoIFsiVyOuupVZecmTmPk7xNPCGg9g74+rHml35yjRbsIKr7uP0oCsu1/+64zVCEkKKl1hg0gzmAAstLMfZG4tclKFZNhVNZsxrdRiVAe3PzIWYmQeLsCxfwb0rRi3OQPSkihyhzRyB/XCSOKQnDJOC404N6yKcKnfwIK1ELZ9UJzYQJMCPysmGhLG1ENRaQ4N7DNT77dcd48sDsas5XzuH/N7JZNd/NDEvEECT365u83fIM2bWMRdAnHqQ0rfGpoCywE3DXqyKukWzAY1mstCPu5sb7+uoZ18XaBmr9Z6iDJ56kYe338BlcHh3g4m/mDTx9vUrpm8lOWIBMlYdsmB9pI4V1DZioneexoCVEFpPK6B7DNn0kvuO
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ada98bb-0689-49a1-520f-08d81c0b3f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 09:03:10.2459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0sf+DCgbdft18e811JUTdPNcWv5CqPDm2insKnUsC2xS8rIcP0P9IS/RPsaaUro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pj4+IFdlIGV4cGxpY2l0bHkgYWRkZWQgdGhlIGFzeW5jaHJvbm91c2x5IElCIHRlc3QgZm9yIFNS
SU9WIHRvIG1ha2UgZHJpdmVyIGxvYWQgZmFzdGVyLiBXaHkgaXMgdGhhdCBub3cgYSBwcm9ibGVt
Pw0KV2VsbCBJIGRpZG4ndCBub3RpY2UgdGhpcyBjaGFuZ2UgZXhwbGljaXRseSBmb3IgU1JJT1Ys
IGF0IGxlYXN0IGZyb20gdGhlIGNvZGUgaXQgaXMgcXVpdGUgYSBub3JtYWwgY2hhbmdlIA0KDQoN
Cj4+PiBBbmQgd2h5IHdvdWxkIGl0IGhlbHAgd2hlbiB0aGUgVk0gc2h1dHMgZG93bj8gV2UgY2Fu
Y2VsL2ZsdXNoIHRoZSB0ZXN0IGR1cmluZyBkcml2ZXIgdW5sb2FkL3N1c3BlbmQgYXMgd2VsbC4N
CklmIHlvdSBkbyB0aGUgc2VxdWVuY2UgbGlrZTogbG9hZCBhbWRncHUgYW5kIHNodXRkb3duIFZN
IGltbWVkaWF0ZWx5ICwgeW91IHdpbGwgaGl0IHByb2JsZW1zIC4NCg0KVmlydHVhbCBNYWNoaW5l
J3Mgc2h1dGRvd24gd29uJ3QgYmUgYmxvY2tlZCBpZiB0aGUgSUIgdGVzdCBpcyBvbiB0aGUgZmx5
ICwgZS5nLjogeW91IGNhbiBkbyAiaW5pdCAwIiByaWdodCBhZnRlciAibW9kcHJvYmUgYW1kZ3B1
IiBhbmQgdGhlICJhbWRncHVfZGV2aWNlX2ZpbmkiIHdvbid0IGJlIGNhbGxlZCANClRodXMgdGhl
IGZsdXNoaW5nIG9uIElCIHRlc3Qgd29uJ3QgaGFwcGVuIHNvIHRoZSBJQiB0ZXN0IGlzIHN0aWxs
IHJ1bm5pbmcgd2l0aCB0aGUgVk0gYWxyZWFkeSBzaHV0ZG93biBhbmQgbGVhZCB0byBHUFUgY3Jh
c2ggKHVzdWFsbHkgVkNOL1ZDRSBjcmFzaCBvbiBpbnZhbGlkIG1lbW9yeSBhZGRyZXNzKQ0KDQog
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpNb25rIExpdXxHUFUgVmly
dHVhbGl6YXRpb24gVGVhbSB8QU1EDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiAN
ClNlbnQ6IE1vbmRheSwgSnVuZSAyOSwgMjAyMCA0OjE4IFBNDQpUbzogTGl1LCBNb25rIDxNb25r
LkxpdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9hbWRncHU6IG1ha2UgSUIgdGVzdCBzeW5jaHJvbml6ZSB3aXRoIGluaXQg
Zm9yIFNSSU9WDQoNCkFtIDI5LjA2LjIwIHVtIDA5OjExIHNjaHJpZWIgTW9uayBMaXU6DQo+IEZy
b206IHBlbmd6aG91IDxQZW5nSnUuWmhvdUBhbWQuY29tPg0KPg0KPiBpc3N1ZToNCj4gb3JpZ2lu
YWxseSB3ZSBraWNrb2ZmIElCIHRlc3QgYXN5bmNocm9ub3VzbHkgd2l0aCBkcml2ZXIncyBpbml0
LCB0aHVzIA0KPiB0aGUgSUIgdGVzdCBtYXkgc3RpbGwgcnVubmluZyB3aGVuIHRoZSBkcml2ZXIg
bG9hZGluZyBkb25lIChtb2Rwcm9iZSBhbWRncHUgZG9uZSkuDQo+IGlmIHdlIHNodXRkb3duIFZN
IGltbWVkaWF0ZWx5IGFmdGVyIGFtZGdwdSBkcml2ZXIgbG9hZGVkIHRoZW4gR1BVIG1heSANCj4g
aGFuZyBiZWNhdXNlIHRoZSBJQiB0ZXN0IGlzIHN0aWxsIHJ1bm5pbmcNCj4NCj4gZml4Og0KPiBt
YWtlIElCIHRlc3Qgc3luY2hyb25pemUgd2l0aCBkcml2ZXIgaW5pdCB0aHVzIGl0IHdvbid0IHN0
aWxsIHJ1bm5pbmcgDQo+IHdoZW4gd2Ugc2h1dGRvd24gdGhlIFZNLg0KDQpXZSBleHBsaWNpdGx5
IGFkZGVkIHRoZSBhc3luY2hyb25vdXNseSBJQiB0ZXN0IGZvciBTUklPViB0byBtYWtlIGRyaXZl
ciBsb2FkIGZhc3Rlci4gV2h5IGlzIHRoYXQgbm93IGEgcHJvYmxlbT8NCg0KQW5kIHdoeSB3b3Vs
ZCBpdCBoZWxwIHdoZW4gdGhlIFZNIHNodXRzIGRvd24/IFdlIGNhbmNlbC9mbHVzaCB0aGUgdGVz
dCBkdXJpbmcgZHJpdmVyIHVubG9hZC9zdXNwZW5kIGFzIHdlbGwuDQoNCj4NCj4gU2lnbmVkLW9m
Zi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jDQo+IGluZGV4IDQ1N2Y1ZDIuLjRmNTQ2NjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTMyOTIsOCArMzI5MiwxNiBAQCBpbnQg
YW1kZ3B1X2RldmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgIAkvKiBt
dXN0IHN1Y2NlZWQuICovDQo+ICAgCWFtZGdwdV9yYXNfcmVzdW1lKGFkZXYpOw0KPiAgIA0KPiAt
CXF1ZXVlX2RlbGF5ZWRfd29yayhzeXN0ZW1fd3EsICZhZGV2LT5kZWxheWVkX2luaXRfd29yaywN
Cj4gKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQo+ICsJCXIgPSBhbWRncHVfaWJfcmlu
Z190ZXN0cyhhZGV2KTsNCj4gKwkJaWYgKHIpIHsNCj4gKwkJCURSTV9FUlJPUigiaWIgcmluZyB0
ZXN0IGZhaWxlZCAoJWQpLlxuIiwgcik7DQo+ICsJCQlyZXR1cm4gcjsNCj4gKwkJfQ0KPiArCX0g
ZWxzZSB7DQo+ICsJCXF1ZXVlX2RlbGF5ZWRfd29yayhzeXN0ZW1fd3EsICZhZGV2LT5kZWxheWVk
X2luaXRfd29yaywNCj4gICAJCQkgICBtc2Vjc190b19qaWZmaWVzKEFNREdQVV9SRVNVTUVfTVMp
KTsNCj4gKwl9DQo+ICAgDQo+ICAgCXIgPSBzeXNmc19jcmVhdGVfZmlsZXMoJmFkZXYtPmRldi0+
a29iaiwgYW1kZ3B1X2Rldl9hdHRyaWJ1dGVzKTsNCj4gICAJaWYgKHIpIHsNCj4gQEAgLTMzMjks
NyArMzMzNyw4IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQ0KPiAgIAlpbnQgcjsNCj4gICANCj4gICAJRFJNX0lORk8oImFtZGdwdTogZmluaXNo
aW5nIGRldmljZS5cbiIpOw0KPiAtCWZsdXNoX2RlbGF5ZWRfd29yaygmYWRldi0+ZGVsYXllZF9p
bml0X3dvcmspOw0KPiArCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiArCQlmbHVzaF9k
ZWxheWVkX3dvcmsoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsNCg0KWW91IGNhbiBkcm9wIHRo
aXMgY2hhbmdlLCBmbHVzaGluZyBhIHdvcmsgd2hpY2ggd2FzIG5ldmVyIHNjaGVkdWxlZCBpcyBo
YXJtbGVzcy4NCg0KPiAgIAlhZGV2LT5zaHV0ZG93biA9IHRydWU7DQo+ICAgDQo+ICAgCS8qIG1h
a2Ugc3VyZSBJQiB0ZXN0IGZpbmlzaGVkIGJlZm9yZSBlbnRlcmluZyBleGNsdXNpdmUgbW9kZSBA
QCANCj4gLTM0MjUsNyArMzQzNCw4IEBAIGludCBhbWRncHVfZGV2aWNlX3N1c3BlbmQoc3RydWN0
IGRybV9kZXZpY2UgKmRldiwgYm9vbCBmYmNvbikNCj4gICAJaWYgKGZiY29uKQ0KPiAgIAkJYW1k
Z3B1X2ZiZGV2X3NldF9zdXNwZW5kKGFkZXYsIDEpOw0KPiAgIA0KPiAtCWNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmYWRldi0+ZGVsYXllZF9pbml0X3dvcmspOw0KPiArCWlmICghYW1kZ3B1X3Ny
aW92X3ZmKGFkZXYpKQ0KPiArCQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPmRlbGF5
ZWRfaW5pdF93b3JrKTsNCj4gICANCj4gICAJaWYgKCFhbWRncHVfZGV2aWNlX2hhc19kY19zdXBw
b3J0KGFkZXYpKSB7DQo+ICAgCQkvKiB0dXJuIG9mZiBkaXNwbGF5IGh3ICovDQo+IEBAIC0zNTI4
LDggKzM1MzgsMTYgQEAgaW50IGFtZGdwdV9kZXZpY2VfcmVzdW1lKHN0cnVjdCBkcm1fZGV2aWNl
ICpkZXYsIGJvb2wgZmJjb24pDQo+ICAgCWlmIChyKQ0KPiAgIAkJcmV0dXJuIHI7DQo+ICAgDQo+
IC0JcXVldWVfZGVsYXllZF93b3JrKHN5c3RlbV93cSwgJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3Jr
LA0KPiArCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCj4gKwkJciA9IGFtZGdwdV9pYl9y
aW5nX3Rlc3RzKGFkZXYpOw0KPiArCQlpZiAocikgew0KPiArCQkJRFJNX0VSUk9SKCJpYiByaW5n
IHRlc3QgZmFpbGVkICglZCkuXG4iLCByKTsNCj4gKwkJCXJldHVybiByOw0KPiArCQl9DQo+ICsJ
fSBlbHNlIHsNCj4gKwkJcXVldWVfZGVsYXllZF93b3JrKHN5c3RlbV93cSwgJmFkZXYtPmRlbGF5
ZWRfaW5pdF93b3JrLA0KPiAgIAkJCSAgIG1zZWNzX3RvX2ppZmZpZXMoQU1ER1BVX1JFU1VNRV9N
UykpOw0KPiArCX0NCj4gICANCj4gICAJaWYgKCFhbWRncHVfZGV2aWNlX2hhc19kY19zdXBwb3J0
KGFkZXYpKSB7DQo+ICAgCQkvKiBwaW4gY3Vyc29ycyAqLw0KPiBAQCAtMzU1NCw3ICszNTcyLDgg
QEAgaW50IGFtZGdwdV9kZXZpY2VfcmVzdW1lKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGJvb2wg
ZmJjb24pDQo+ICAgCQlyZXR1cm4gcjsNCj4gICANCj4gICAJLyogTWFrZSBzdXJlIElCIHRlc3Rz
IGZsdXNoZWQgKi8NCj4gLQlmbHVzaF9kZWxheWVkX3dvcmsoJmFkZXYtPmRlbGF5ZWRfaW5pdF93
b3JrKTsNCj4gKwlpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gKwkJZmx1c2hfZGVsYXll
ZF93b3JrKCZhZGV2LT5kZWxheWVkX2luaXRfd29yayk7DQo+ICAgDQo+ICAgCS8qIGJsYXQgdGhl
IG1vZGUgYmFjayBpbiAqLw0KPiAgIAlpZiAoZmJjb24pIHsNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
