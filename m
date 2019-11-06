Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A0AC5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74F72173E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74F72173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2E06E279;
	Wed,  6 Nov 2019 17:04:12 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4FA6E279
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 17:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0playeT2S015bFR/QmKABu8sbSezrR4aXYZn7byim7n1dNp8u02koprg4KYJ3F/tnw5U38iFRaB3nZRytudrTyPvUZKcUMWhH/hRRQAhdaR124uMKyj64ar83Y8rAfySFiKxCK/JrKXl5bn7miHFtqvFAVTb0xRXCsCbBA21MrpandDcIYOvmyXM3DYXUqOcOAeZQ/fKGRnZ6L0ndoWhg/FoKQOxG/hFXqrq+SmIUa09tsdXxm+CTv3P5cN7Rud2poZ8PQKGXAgBSik0TgCSRD0Woqp5tOTXqIIktqtKT55RZOkYCmu5NpbUnozs9d9atxpL1vm8venhW1PhDEajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsOS7DFmlrG8IUkctuo/kAaD5LR3ZxwPAG/a2scLn9M=;
 b=n3l1whwbIu0luT/AfctUHG3lAP4EAVGnpdPxm0sZyEuwS8d+VDZaGYAHJtm9AOW1YeVmfAKXTDScMEJMTznVT/3GxW92Da+0jKy4cUNeo634RdBfngryF0dUId7MuVOxyxe7/PaQMZwUZsCoYSM6Acvzfh/WBuJTNFIv5JFtKTjQKWuBnSuX3Uo+PMJVSww7dzaZgJVyhkrBkrDntHm6QkyDlDtSTKaTXSWYJslKUJ0tCX5a47/BXSxPXBpfU0cHmLB1wKM7YjI3daoMLFFPBlYRJKECYTGn6GwMy4nQTYU3djk3CnQgwBfQ+cFZWvESJhZ8pRrSOcM6V6WZrj0SxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB2924.namprd12.prod.outlook.com (20.179.104.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 17:04:08 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 17:04:08 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/renoir: move gfxoff handling into gfx9 module
Thread-Topic: [PATCH] drm/amdgpu/renoir: move gfxoff handling into gfx9 module
Thread-Index: AQHVjpT2o1ukvFjVvEmIPtWbcT1iAqd+YuAAgAAIXIA=
Date: Wed, 6 Nov 2019 17:04:08 +0000
Message-ID: <85f88299-860b-99a6-3fcd-d66b563a74eb@amd.com>
References: <20191029201031.1514210-1-alexander.deucher@amd.com>
 <CADnq5_PJ-228f8tzZ3NJwH3q+xFHP4qZaKxPZBb6t8ZdzLz5fA@mail.gmail.com>
In-Reply-To: <CADnq5_PJ-228f8tzZ3NJwH3q+xFHP4qZaKxPZBb6t8ZdzLz5fA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16369e4e-8a10-4e63-e6dd-08d762db5669
x-ms-traffictypediagnostic: DM6PR12MB2924:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2924D2FE04FE727E788DB3D9F0790@DM6PR12MB2924.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(189003)(199004)(25786009)(102836004)(14454004)(36756003)(229853002)(478600001)(31696002)(26005)(99286004)(186003)(4326008)(86362001)(53546011)(3846002)(6116002)(76176011)(81166006)(81156014)(8936002)(7736002)(5660300002)(305945005)(52116002)(966005)(8676002)(11346002)(6306002)(6512007)(6436002)(6506007)(386003)(486006)(2616005)(476003)(71190400001)(71200400001)(66066001)(446003)(316002)(256004)(31686004)(66446008)(64756008)(66556008)(66476007)(2906002)(66946007)(6246003)(110136005)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2924;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9Jd1cEhuNXQl46fOcoJy1zCy3gADeCC7hkhKB8a/Sx8wQM0ngzGyJVclt2KzgE24cO+ErL0zeRTgQl2I2M0yDvb7W78wv8SnKNwzxAXFT3LAYtxUj0E7T2iAEN6TZzfk4+7NLgTg9ZIKZlGyinDw3aRhSK8nv9rAc+a8+Zel/CVPHI7JrI21PwLNtxkQGivLKsXWyKPs5UUiEluRQLW5BY6jNqNSVMBgCMg6vfe3VFLLAmdSwN5HmcO3ETSv7QbpV7NfmLJ7wK2jb0narczy44by6PDzHwahm795f058Q2KPvSd8sSc5lgPcRc5Pa7ZBMtCtH5AaLUzIpp56mOk5yh3VavroqBWjKMo04wEhpCFVZHnVxl9UdhzpgYf3UBNVzY9PjeUfrwYH/IA12m/MTXlI751LEImZitk3ScbyMy1ARHKJeyngtt5UKudgpsjbAf3Lkn3rcxjQZbVvfGYhkDSctDAUaX4FJvOsfE6pYU=
Content-ID: <9AD45CDF2679FD4A8726E0752D5D5DB3@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16369e4e-8a10-4e63-e6dd-08d762db5669
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 17:04:08.6533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nw0B+yHxa1cjxsoADaevn/m1FwH8up9itSXIViUdC2Bbobm9PJJm9L9AseZrqKpP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2924
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsOS7DFmlrG8IUkctuo/kAaD5LR3ZxwPAG/a2scLn9M=;
 b=fos+1F7eZasRn6SXXvvtENGYrFUUPQGFRoSlylAwcwMxTPUcYlfhaHfDjFpeMWl0JhP4MMwpSNHTaKxgtPkgDcuYat/Bkspjxc5RGaBs8fr/IssSROQO8un/zAMTxKGPs9x8XZ7whRJLLxL62Htp/XOx2rEUPCpJqXTiT9tNf7M=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106170408.YWgocNFn-BzYnFDa9gOerNsXmIZPh9R76R3yiMBmXG4@z>

UmV2aWV3ZWQtYnk6IFlvbmcgWmhhbyA8eW9uZy56aGFvQGFtZC5jb20+DQoNCk9uIDIwMTktMTEt
MDYgMTE6MzQgYS5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiBQaW5nPw0KPg0KPiBPbiBUdWUs
IE9jdCAyOSwgMjAxOSBhdCA0OjEwIFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwu
Y29tPiB3cm90ZToNCj4+IFRvIHByb3Blcmx5IGhhbmRsZSB0aGUgb3B0aW9uIHBhcnNpbmcgb3Jk
ZXJpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OV8wLmMgfCA2ICsrKysrKw0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2Mx
NS5jICAgIHwgNSAtLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMN
Cj4+IGluZGV4IDlmZTk1ZTc2OTNkNS4uYjJiM2ViNzVjNDhjIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPj4gQEAgLTEwNTEsNiArMTA1MSwxMiBAQCBzdGF0
aWMgdm9pZCBnZnhfdjlfMF9jaGVja19pZl9uZWVkX2dmeG9mZihzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIWFkZXYtPmdmeC5ybGMu
aXNfcmxjX3YyXzEpKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnBtLnBwX2Zl
YXR1cmUgJj0gflBQX0dGWE9GRl9NQVNLOw0KPj4NCj4+ICsgICAgICAgICAgICAgICBpZiAoYWRl
di0+cG0ucHBfZmVhdHVyZSAmIFBQX0dGWE9GRl9NQVNLKQ0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgYWRldi0+cGdfZmxhZ3MgfD0gQU1EX1BHX1NVUFBPUlRfR0ZYX1BHIHwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1EX1BHX1NVUFBPUlRfQ1AgfA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBBTURfUEdfU1VQUE9SVF9STENfU01VX0hTOw0KPj4g
KyAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgICBjYXNlIENISVBfUkVOT0lSOg0KPj4g
ICAgICAgICAgICAgICAgICBpZiAoYWRldi0+cG0ucHBfZmVhdHVyZSAmIFBQX0dGWE9GRl9NQVNL
KQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnBnX2ZsYWdzIHw9IEFNRF9QR19T
VVBQT1JUX0dGWF9QRyB8DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURf
UEdfU1VQUE9SVF9DUCB8DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4+IGluZGV4
IDE2YzViYjc1ODg5Zi4uMjVlNjllYTc0YTQxIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYw0KPj4gQEAgLTEyNjMsMTEgKzEyNjMsNiBAQCBzdGF0aWMgaW50IHNvYzE1X2Nv
bW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBBTURfUEdfU1VQUE9SVF9WQ04gfA0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEc7DQo+PiAgICAgICAgICAgICAgICAg
IGFkZXYtPmV4dGVybmFsX3Jldl9pZCA9IGFkZXYtPnJldl9pZCArIDB4OTE7DQo+PiAtDQo+PiAt
ICAgICAgICAgICAgICAgaWYgKGFkZXYtPnBtLnBwX2ZlYXR1cmUgJiBQUF9HRlhPRkZfTUFTSykN
Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnBnX2ZsYWdzIHw9IEFNRF9QR19TVVBQ
T1JUX0dGWF9QRyB8DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNRF9QR19T
VVBQT1JUX0NQIHwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1EX1BHX1NV
UFBPUlRfUkxDX1NNVV9IUzsNCj4+ICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+PiAgICAgICAg
ICBkZWZhdWx0Og0KPj4gICAgICAgICAgICAgICAgICAvKiBGSVhNRTogbm90IHN1cHBvcnRlZCB5
ZXQgKi8NCj4+IC0tDQo+PiAyLjIzLjANCj4+DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
