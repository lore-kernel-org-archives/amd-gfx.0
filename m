Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322C4C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 02:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15162084D
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 02:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15162084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95346E0EC;
	Fri,  8 Nov 2019 02:22:38 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750075.outbound.protection.outlook.com [40.107.75.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C63D6E0EC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 02:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRr+nThJfptjpb8UNW3d3Pk4acxb67+8rtkET1Ij2vs/FkjEB3RJGDzzMSPVVP6NrhUq6p3XUs09p9QDAY7xs000zAxJOhucoUEZKWol/CzAppbq9BMhr7MUR0/d9pP0Uzv2QDtu1EDKtQiQPNcyB+nsYNcYUVJ2S09cfC1HITVi1u9ziaaJN/X5WCGtUI1/igiRiOXOl9LT11L3eQHBKirO9pXC0pTEzpOS7xANhuuFVd8pDrMXL8+oMybF0G6PBzFxCmEJXHg+vMLeQ+3sxG6wg58k/Dgn15enrffC6FNo25Kp1oJl6bqEPMcimqx/PRlZDa3CaEUCa5HZ0bxsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyIbbc44gg6as/O+5DdC9fTU1bTf+w4m6SB4ha1uN7A=;
 b=EnuUZhoI7cuRTPw5XuDhco158aK0duJosG30lWh1myb3PEfbntDH+2I0aqQYIwsw0nI+km7p2eD+J/CmiRtgjYJLggeZYrov4MoMR9+vDLubRMHZbSR+W6b0gPnJcjrWFAWYVc6z6FCZaZtJWXrCwrrgH99seSAe3Kx89VsXPBev9rp4SeMMnPAXq7Fn4dFaV9GieuTbMiYDZLEOFVBxAreF0pIq01GGCJjNhRIMbdL6sspijonBjTc1bIPjiQzUzN/LNmFXWCGWcUVwkNiGiSdyjpua8sOrBSnjltHXTFxd1OFjKuKR4clMK57Qno4zO8ZNqWjFNevoSoz9a8AzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3312.namprd12.prod.outlook.com (20.179.80.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Fri, 8 Nov 2019 02:22:35 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b%5]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 02:22:35 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: allow direct upload save restore list for
 raven2
Thread-Topic: [PATCH] drm/amdgpu: allow direct upload save restore list for
 raven2
Thread-Index: AQHVldeFrE70cIKU1UicTyTAEATq36eAiv5g
Date: Fri, 8 Nov 2019 02:22:35 +0000
Message-ID:
 <MN2PR12MB330952DF0170ACDDACF60D95EC7B0@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <20191108015432.11840-1-changfeng.zhu@amd.com>
In-Reply-To: <20191108015432.11840-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42872552-0525-47f7-6380-08d763f284a2
x-ms-traffictypediagnostic: MN2PR12MB3312:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB331202549AE97E746B5B8986EC7B0@MN2PR12MB3312.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(13464003)(189003)(199004)(66946007)(74316002)(305945005)(99286004)(6636002)(7736002)(2906002)(52536014)(229853002)(2501003)(3846002)(6116002)(33656002)(14454004)(5660300002)(66066001)(7696005)(110136005)(76176011)(6506007)(53546011)(6436002)(102836004)(316002)(9686003)(446003)(25786009)(71200400001)(14444005)(256004)(55016002)(186003)(26005)(71190400001)(478600001)(486006)(81166006)(81156014)(86362001)(66446008)(66556008)(66476007)(8936002)(476003)(11346002)(76116006)(6246003)(8676002)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3312;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SqYbkkS8K3XFASJ5zh23obtjKGZ5Nv2QoUVzZxVQtAD5F5AZo7Y+oge2qu5W3aAC9dT6J8jwZ4l45B8gpUkh/aWqj2tfPfCbVjsgTWnRWJ9hy5r973Rhzl1aavlLUU1nflPE8rDZ+7JzIiOO7/tx4eVkMv82fA/ak+4vHU2pSlTeVxd0KiJ/27TZToi9vO3rxPJTJN8RJz0H2fAjvjl7kt7lv+58LvJN6U2bdhMg+CHtjkcG7QD0mWxsuoRBsih7+jpRfRpNZCSH9vZh/m3tj312GOPeYHW0Du4dxb2cpXGEQRhy1j7AOG4g2TcrxxCnu9KtmdxcPorqPEGjlMnZddEVFH7MJdFj1iKrpDC2+HNgPL+DmiiTNay2S6KMuUx/0JFqu0X60coWYuL4uCP7nQEKImtTgdA23RqoH1KFe0HL2+5YP4gDvDIWaFE9pxPu
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42872552-0525-47f7-6380-08d763f284a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 02:22:35.2825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23RCWNdo8W8NGtGiRlBS4KaKxsqfSRsSUZPZUOskJrRZJs/8j0myYPSNNHgOKY9vcPgrAyHJxeaHc6TmhSAlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3312
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyIbbc44gg6as/O+5DdC9fTU1bTf+w4m6SB4ha1uN7A=;
 b=e+bjJR8fokagXU/xcBEzMzG/59sUykvgFZPgpvjhF3LQTx8wP5wEFU2MBNhuf2Gt3mzqrUdAK0WRkwhFMcw65qO3xaS1XwiwV5uu8nrm9QySHRQeNSEgfKBqBrN+oK8bDvW73Grzw9oZSf3y8ur3rVYzzaXzSK1JC0PAfN7LO48=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
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
Message-ID: <20191108022235.i51-sFmgAFvHp-03o9Y4XFp4ec8cayPy4TIOHTxpT40@z>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IFpodSwgQ2hhbmdmZW5nIDxDaGFu
Z2ZlbmcuWmh1QGFtZC5jb20+Cj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAwOCwgMjAxOSA5OjU1
IEFNCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZwo+
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4K
PiBDYzogWmh1LCBDaGFuZ2ZlbmcgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KPiBTdWJqZWN0OiBb
UEFUQ0hdIGRybS9hbWRncHU6IGFsbG93IGRpcmVjdCB1cGxvYWQgc2F2ZSByZXN0b3JlIGxpc3Qg
Zm9yCj4gcmF2ZW4yCj4gCj4gRnJvbTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4K
PiAKPiBJdCB3aWxsIGNhdXNlIG1vZHByb2JlIGF0b21iaW9zIHN0dWNrIHByb2JsZW0gaW4gcmF2
ZW4yIGlmIGl0IGRvZXNuJ3QgYWxsb3cKPiBkaXJlY3QgdXBsb2FkIHNhdmUgcmVzdG9yZSBsaXN0
IGZyb20gZ2Z4IGRyaXZlci4KPiBTbyBpdCBuZWVkcyB0byBhbGxvdyBkaXJlY3QgdXBsb2FkIHNh
dmUgcmVzdG9yZSBsaXN0IGZvciByYXZlbjIgdGVtcG9yYXJpbHkuCj4gCj4gQ2hhbmdlLUlkOiBJ
MWZlY2UxYjljNjFmN2ExM2VlYzk0OGYzNGViNjBhOTEyMDA0NmJjMgo+IFNpZ25lZC1vZmYtYnk6
IGNoYW5nemh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogSHVhbmcgUnVp
IDxyYXkuaHVhbmdAYW1kLmNvbT4KCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMgfCA0ICsrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4g
aW5kZXggNGVkMzFlOWEzOThjLi5kZGU5NzEzYzFkNjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMKPiBAQCAtMjcyOSw3ICsyNzI5LDkgQEAgc3RhdGljIHZvaWQgZ2Z4
X3Y5XzBfaW5pdF9wZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQo+ICphZGV2KQo+ICAJICogQW5kIGl0
J3MgbmVlZGVkIGJ5IGdmeG9mZiBmZWF0dXJlLgo+ICAJICovCj4gIAlpZiAoYWRldi0+Z2Z4LnJs
Yy5pc19ybGNfdjJfMSkgewo+IC0JCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9WRUdBMTIp
Cj4gKwkJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0ExMiB8fAo+ICsJCSAgICAoYWRl
di0+YXNpY190eXBlID09IENISVBfUkFWRU4gJiYKPiArCQkgICAgIGFkZXYtPnJldl9pZCA+PSA4
KSkKPiAgCQkJZ2Z4X3Y5XzFfaW5pdF9ybGNfc2F2ZV9yZXN0b3JlX2xpc3QoYWRldik7Cj4gIAkJ
Z2Z4X3Y5XzBfZW5hYmxlX3NhdmVfcmVzdG9yZV9tYWNoaW5lKGFkZXYpOwo+ICAJfQo+IC0tCj4g
Mi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
