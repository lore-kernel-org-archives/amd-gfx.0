Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E95AC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 22:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0B420709
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 22:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0B420709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870DC6E802;
	Wed, 20 Nov 2019 22:22:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770059.outbound.protection.outlook.com [40.107.77.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D3C86E802
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 22:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLW0NtWAubSlFCp0n8qGVd2FQ6XVXnlmqG2N+xkB0w4o2E2hfDXg+0Gs1NNuLbQUB1RQSp2W9/HdnHf9/6ff7ND3uKk+3iwgT9Lpm6/4W6oo5QmORo8rBpSSsgNlULzDzXG4wVnj3t2E+2l5pbYbNC1Zue+RY2hUHjhlk4rXbPDvckEtmmFDfxIwHcHxMbtvu+CtOk2KTzgbZrcMd4/oUIiebbo/0+9BhPOdRQzuYidzmhEG9ZRZY4b2G5rTvajbk+GvvFAdnFVnNWUutEp9xi142c0EnkOgPGGwx6t5lfFpc1WgDEFT6ZWu57rsacTdZRmJOX3Cu4Pii5pF1DO05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWlHtZtSkb1ivwf8pmrlphYUiKKs2vtGtsUMXRUaS/M=;
 b=kZSOHV0SVdIzlbAWoRJgMb4k0zmoZ5zxk7W/zrIM2tVghxKZnXwH7za0G+3Me7IxYo03hQgkmoZctz0PLwK9cotfOJdy6f17omGf82AdiLWd/rEF5jgQzF1y3mantZfFo0xCq3meWG6ikcLMcgCE5Mz61ncFYz+AtNxpVBYadpc78yOeMBLcsNnJp2yEwJt9GnwrShCq5N7Q01qtxCUUuQ8ZGZHwD41DUj2YuoQsNkI92LtGFBhsnIASBxN2O57dSmEV5z1eNfdCoV3l0aWRT42QLSc7ahyau8zqkWmovUHhak04wyyBe5i0AeydDcR4xk4/zaTdiz2hD3aIaVhDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2354.namprd12.prod.outlook.com (52.132.30.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 22:22:45 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595%2]) with mapi id 15.20.2474.015; Wed, 20 Nov 2019
 22:22:45 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: DIQ should not use HIQ way to allocate memory
Thread-Topic: [PATCH] drm/amdkfd: DIQ should not use HIQ way to allocate memory
Thread-Index: AQHVm880QLor16+fDUSQbdx9rnj2XqeUqhXw
Date: Wed, 20 Nov 2019 22:22:45 +0000
Message-ID:
 <BL0PR12MB25801D7351D491613F7354A3804F0@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20191115160929.2017-1-Yong.Zhao@amd.com>
In-Reply-To: <20191115160929.2017-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a39f6351-0b52-4acf-5d2d-08d76e082b14
x-ms-traffictypediagnostic: BL0PR12MB2354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2354640E197C30557C13B085804F0@BL0PR12MB2354.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(13464003)(199004)(189003)(76176011)(66946007)(6246003)(316002)(6506007)(25786009)(446003)(53546011)(76116006)(66556008)(966005)(229853002)(66066001)(6116002)(7696005)(110136005)(256004)(305945005)(74316002)(26005)(7736002)(102836004)(71190400001)(71200400001)(486006)(478600001)(55016002)(186003)(66446008)(8936002)(52536014)(3846002)(64756008)(99286004)(66476007)(476003)(6436002)(33656002)(5660300002)(14454004)(11346002)(2501003)(8676002)(86362001)(2906002)(81166006)(6306002)(9686003)(81156014)(4326008)(43043002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2354;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlZiqvifOoBtB2yVetekKeGOIMRiUoErkh3NcVn25V2HNDtuCRynb6pHAIWkb088AuWCvFgBSmy6oC+XFsJyWa26BQMl3mnLlLEvZztTj1loWtprPqgc9nQeOtfbzTPfmZlZ2uoRAGJugv7xBCFNMTVNut121xvG5rLym8Uwh2WW8GxpCvSJmuzEnpx+XhBw1lQQPQSIVjQ64tiyqUer4druaMIoLFUavLpfg1h3O/Xm+VprEmKrKlPBWGlgeE3HjTm1n1YcvHhLEQ8660xTqNm7QOIKizML4Qb+8g5tXMNN8dL+Tadv2VfmneKxKMbjfx4r6P7HbTxh8x1I+9weMY8Ab4/iD2MWBffN3ojD5Dw5TrAAjpGnKt5CORrRbZJ9oL04nc87TTNLeA32YHvYuQola5leWzQVEigHv9Q884/wMKGB1bUhJjXS8nE8HxGR
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39f6351-0b52-4acf-5d2d-08d76e082b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 22:22:45.6583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMyvIBbQPvZz6jAjmlxI+FmDSsgJswsWso7vfpmawNITm3DO1ZmrvvDS1DhQuOks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2354
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWlHtZtSkb1ivwf8pmrlphYUiKKs2vtGtsUMXRUaS/M=;
 b=wT3EUIcmVjNX9lFCGf9pngF6SsC2ZDfG6XlvK1MKooTmMUMY+Z+FNOAKC3JoTNzQb0O/EMBL+YyRvymh5WR4I5nPiH7mlSufGeN/eaO+ph1zULxugA/pQYieoa0sFFJ9xT/qNhtkiKXOSDpxwQr5ZLapdTrfL7HZ1jzd6kfZ45k=
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120222245.QKxXkCkbbFYM1Gm3XSmSGxwvInnYklzDWlrEV6T2xKo@z>

VGhhbmtzIGZvciBjYXB0dXJlIHRoaXMuIFRoaXMgaXMgc29tZXRoaW5nIEkgZm9yZ2V0IHRvIGRv
IHdoZW4gSSByZS1vcmdlZCB0aGUgbXFkIG1hbmFnZXIgY29kZXMuDQoNClJldmlld2VkLWJ5OiBP
YWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4NCg0KT2FrDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPiBPbiBCZWhhbGYgT2YgWW9uZyBaaGFvDQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDE1LCAy
MDE5IDExOjA5IEFNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFv
LCBZb25nIDxZb25nLlpoYW9AYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGtmZDog
RElRIHNob3VsZCBub3QgdXNlIEhJUSB3YXkgdG8gYWxsb2NhdGUgbWVtb3J5DQoNCkluIHRoZSBt
cWRfZGlxX3NkbWEgYnVmZmVyLCB0aGVyZSBzaG91bGQgYmUgb25seSBvbmUgSElRIG1xZC4gQWxs
IERJUXMgc2hvdWxkIGJlIGFsbG9jYXRlIHVzaW5nIHRoZSByZWd1bGFyIHdheS4NCg0KQ2hhbmdl
LUlkOiBJYmYzZWIzMzYwNGQwZWMzMDUwMWMyNDQyMjhjZGIzYjI0NjE1YjY5OQ0KU2lnbmVkLW9m
Zi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl9jaWsuYyB8IDIgKy0gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyB8IDIgKy0gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jICB8IDIgKy0gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jICB8IDIgKy0NCiA0IGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl9jaWsuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl9jaWsuYw0KaW5kZXggYjA4Njk0ZWM2NWQ3
Li4xOWYwZmU1NDdjNTcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfbXFkX21hbmFnZXJfY2lrLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9tcWRfbWFuYWdlcl9jaWsuYw0KQEAgLTQwMCw3ICs0MDAsNyBAQCBzdHJ1Y3QgbXFkX21hbmFn
ZXIgKm1xZF9tYW5hZ2VyX2luaXRfY2lrKGVudW0gS0ZEX01RRF9UWVBFIHR5cGUsICAjZW5kaWYN
CiAJCWJyZWFrOw0KIAljYXNlIEtGRF9NUURfVFlQRV9ESVE6DQotCQltcWQtPmFsbG9jYXRlX21x
ZCA9IGFsbG9jYXRlX2hpcV9tcWQ7DQorCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX21x
ZDsNCiAJCW1xZC0+aW5pdF9tcWQgPSBpbml0X21xZF9oaXE7DQogCQltcWQtPmZyZWVfbXFkID0g
ZnJlZV9tcWQ7DQogCQltcWQtPmxvYWRfbXFkID0gbG9hZF9tcWQ7DQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jDQppbmRleCA1YTBlMzA0NDFi
ZTguLjhkMjEzMjViNWNiYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9tcWRfbWFuYWdlcl92MTAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX21xZF9tYW5hZ2VyX3YxMC5jDQpAQCAtNDMyLDcgKzQzMiw3IEBAIHN0cnVjdCBtcWRfbWFu
YWdlciAqbXFkX21hbmFnZXJfaW5pdF92MTAoZW51bSBLRkRfTVFEX1RZUEUgdHlwZSwNCiAJCXBy
X2RlYnVnKCIlc0AlaVxuIiwgX19mdW5jX18sIF9fTElORV9fKTsNCiAJCWJyZWFrOw0KIAljYXNl
IEtGRF9NUURfVFlQRV9ESVE6DQotCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX2hpcV9t
cWQ7DQorCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX21xZDsNCiAJCW1xZC0+aW5pdF9t
cWQgPSBpbml0X21xZF9oaXE7DQogCQltcWQtPmZyZWVfbXFkID0gZnJlZV9tcWQ7DQogCQltcWQt
PmxvYWRfbXFkID0gbG9hZF9tcWQ7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfbXFkX21hbmFnZXJfdjkuYw0KaW5kZXggYmRiY2VhMjJhZDEyLi5kZjc3ZDY3ZWM5YWEgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjku
Yw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMN
CkBAIC00NzEsNyArNDcxLDcgQEAgc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFuYWdlcl9pbml0
X3Y5KGVudW0gS0ZEX01RRF9UWVBFIHR5cGUsICAjZW5kaWYNCiAJCWJyZWFrOw0KIAljYXNlIEtG
RF9NUURfVFlQRV9ESVE6DQotCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX2hpcV9tcWQ7
DQorCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX21xZDsNCiAJCW1xZC0+aW5pdF9tcWQg
PSBpbml0X21xZF9oaXE7DQogCQltcWQtPmZyZWVfbXFkID0gZnJlZV9tcWQ7DQogCQltcWQtPmxv
YWRfbXFkID0gbG9hZF9tcWQ7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX21xZF9tYW5hZ2VyX3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
bXFkX21hbmFnZXJfdmkuYw0KaW5kZXggYzllMTE1MWI1YTU3Li4zYjZiNTY3MTk2NGMgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmkuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3ZpLmMNCkBA
IC00NTIsNyArNDUyLDcgQEAgc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFuYWdlcl9pbml0X3Zp
KGVudW0gS0ZEX01RRF9UWVBFIHR5cGUsICAjZW5kaWYNCiAJCWJyZWFrOw0KIAljYXNlIEtGRF9N
UURfVFlQRV9ESVE6DQotCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX2hpcV9tcWQ7DQor
CQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX21xZDsNCiAJCW1xZC0+aW5pdF9tcWQgPSBp
bml0X21xZF9oaXE7DQogCQltcWQtPmZyZWVfbXFkID0gZnJlZV9tcWQ7DQogCQltcWQtPmxvYWRf
bXFkID0gbG9hZF9tcWQ7DQotLQ0KMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
