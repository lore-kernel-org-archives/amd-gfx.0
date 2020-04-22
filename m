Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF5DC2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 02:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DAF206D4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 02:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ALE1MygH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DAF206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0570C6E19B;
	Wed, 22 Apr 2020 02:16:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9506E19B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 02:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxA6zwL6f/0ufYqq/P8rlpxM9VF9fYQeQ3M5RWW7pyOK4hijSfADVBgGUKPTrhaShULxWZc3x9Q9pN6iKfB5tevvQBg847OxYH+LckQ6tDhZnW5nfdpO2DwVVtQLfeRyGgLhXMGqkeNd5cNzQzxoN53DOMRd5Mnix2cR2JmebOgsc25gfpPbSb+DQ624Qt74Kx7u7xntcfKisfcpbPXr2x5eh7vsYvx7h5pNnV6LA5ALXJr19ttHMqneUYqQ/lVs7iUEAP44czacJBEcbTS9FXBNYRA4Y7U91Lrxs0caxlVtjmvsn7dCumefdKWZEPmsGvZuYCk+Y7EFG9JvWuViJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwux6MkxD5AYDKZORmB+dB5+LyJteGCfaqKsgpn+PQo=;
 b=HSRRLxfZfzZjRiC/Y7NPSRcXSC5965oBgkm1IbGQpL44b+MIi/V6fmmSrYltPQ5wWqVhqSba99oEgamFHbGBwfGYEEiD+zy64uRBp5jYms/yDDr6QcBHD74wkxc6PCzt+rsgLsQi8tyMuN7o+gbpOtggQraCFY2PEIzq84l0FkbpXHysayc9FEz4AIoG9a0tfZRwTlyP//PAx2DFGgZpLn5R8fEFv2jhVFjYuSUjNMNrOpjIIsStQeyPqMWr0ok5XMNOaFEg9t+GcDPVmLHXk3cBIZhnBDB7KcWzlPm9GZHQEhOqaen5U4xsVJ/caY1Ir7xnJH7v6JWzH90ly8s6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwux6MkxD5AYDKZORmB+dB5+LyJteGCfaqKsgpn+PQo=;
 b=ALE1MygHs16RALvH75sYzRj07zcXocv0+mfw9UiGntMnhPJUNaW8ohYxO1lakCMkp5oKv9EUWORpout1j7ujdgg17tSWxJ8OTznsEHEP5MUfhj5Rx+C1mjNqojY7/eF0sNcHBN57TW7vpvkob2TY0/eyT11a2imYsY19JRfei9g=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1802.namprd12.prod.outlook.com (2603:10b6:3:109::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 02:16:01 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 02:16:01 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "He, Jacob" <Jacob.He@amd.com>, "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change how we update mmRLC_SPM_MC_CNTL
Thread-Topic: [PATCH] drm/amdgpu: change how we update mmRLC_SPM_MC_CNTL
Thread-Index: AQHWF+hROUmG3x+E/kSnfOaRzLOr+qiEaAfQ
Date: Wed, 22 Apr 2020 02:16:00 +0000
Message-ID: <DM5PR12MB1708A9545E3E94D282BC269584D20@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200421142236.41131-1-christian.koenig@amd.com>
In-Reply-To: <20200421142236.41131-1-christian.koenig@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48efe217-324e-41c9-b174-08d7e6631a20
x-ms-traffictypediagnostic: DM5PR12MB1802:|DM5PR12MB1802:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB180280CAB735668E527B2A6684D20@DM5PR12MB1802.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(76116006)(66556008)(66946007)(64756008)(66446008)(66574012)(66476007)(478600001)(8936002)(81156014)(8676002)(26005)(5660300002)(71200400001)(186003)(52536014)(53546011)(6506007)(7696005)(316002)(110136005)(9686003)(55016002)(33656002)(86362001)(15650500001)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YkbOLPfhm03LTFOATevlOfpj1Z9ga4rosft7tNIsSHbqpfB8/iRg/6IxNep0J0yoxIn9lUsnIcuiat8edE4QkifsTJCaaCTTM053Hw3xCw9QnVGujSFXuu6V7/3SyGNz3LOJtia0xUxmJUPvbZ833st7SY0ItMXpPLRU1kQckpxCqONk+IXzWAwvdt06Zk3gxOuS5Rgf3eI0DzPTyiUqduKjohbu1wB7oYHuCJjLU+r2RbWCKuaaM7VRhK8LT09iFlVmc9eoCa7gYep3DY4YbKiGtw7xJYeNl3hZ7Fx6bL6uOgRm/bFIgMWjAJnqnt4j+tfAU2CrozECnxTiskbLZWXDVSGtrjy7zEv6n3lW66m70vWkD/KRkW9jMJpujV0SMEcvW/L0dOGuYcLhZhP1wiOCSrVx6yQvfrRP1hWiCFYVOxWQ7mKac7+Ml2FOKDD
x-ms-exchange-antispam-messagedata: L3qB0yrW4v7H9ghqweBWPthaOSJQuXZFMSer/2lJ6RIjZ0VzcTI1yvM2c1CO1SQWbLcoSXNqh4yJpZqbK4i8sG6rz09YoDH3zA5GZCJhYImMbZMxHaJVr4Hz38Fg1u3H16TZTxx86rtMiTSn7wnw0Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48efe217-324e-41c9-b174-08d7e6631a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 02:16:00.9626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6u4SwyVQIwZgofMSv6vmO3aKNH/aYOZTQqQ57XcE38u8jcCs/6xDiJy/ImtTItwJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1802
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

UmV2aWV3ZWQtYnk6IE1vbmsgTGl1IDxtb25rLmxpdUBhbWQuY29tPg0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQpNb25rIExpdXxHUFUgVmlydHVhbGl6YXRpb24gVGVh
bSB8QU1EDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBL
w7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6IFR1ZXNkYXks
IEFwcmlsIDIxLCAyMDIwIDEwOjIzIFBNDQpUbzogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29t
PjsgSGUsIEphY29iIDxKYWNvYi5IZUBhbWQuY29tPjsgVGFvLCBZaW50aWFuIDxZaW50aWFuLlRh
b0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFtQQVRD
SF0gZHJtL2FtZGdwdTogY2hhbmdlIGhvdyB3ZSB1cGRhdGUgbW1STENfU1BNX01DX0NOVEwNCg0K
SW4gcHBfb25lX3ZmIG1vZGUgYXZvaWQgdGhlIGV4dHJhIG92ZXJoZWFkIGFuZCByZWFkL3dyaXRl
IHRoZSByZWdpc3RlcnMgd2l0aG91dCB0aGUgS0lRLg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDEzICsrKysrKysrKystLS0gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgIHwgMTAgKysrKysrKystLSAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgfCAxMyArKysrKysrKysrLS0tDQogMyBmaWxlcyBj
aGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KaW5kZXggMGEwM2UyYWQ1ZDk1Li41NjBlYzFjMjk5Nzcg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCkBAIC03MDMwLDE0ICs3
MDMwLDIxIEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3VwZGF0ZV9nZnhfY2xvY2tfZ2F0aW5nKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KIA0KIHN0YXRpYyB2b2lkIGdmeF92MTBfMF91cGRh
dGVfc3BtX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIHZtaWQpICB7
DQotCXUzMiBkYXRhOw0KKwl1MzIgcmVnLCBkYXRhOw0KIA0KLQlkYXRhID0gUlJFRzMyX1NPQzE1
KEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCk7DQorCXJlZyA9IFNPQzE1X1JFR19PRkZTRVQoR0Ms
IDAsIG1tUkxDX1NQTV9NQ19DTlRMKTsNCisJaWYgKGFtZGdwdV9zcmlvdl9pc19wcF9vbmVfdmYo
YWRldikpDQorCQlkYXRhID0gUlJFRzMyX05PX0tJUShyZWcpOw0KKwllbHNlDQorCQlkYXRhID0g
UlJFRzMyKHJlZyk7DQogDQogCWRhdGEgJj0gflJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlE
X01BU0s7DQogCWRhdGEgfD0gKHZtaWQgJiBSTENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9N
QVNLKSA8PCBSTENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9fU0hJRlQ7DQogDQotCVdSRUcz
Ml9TT0MxNShHQywgMCwgbW1STENfU1BNX01DX0NOVEwsIGRhdGEpOw0KKwlpZiAoYW1kZ3B1X3Ny
aW92X2lzX3BwX29uZV92ZihhZGV2KSkNCisJCVdSRUczMl9TT0MxNV9OT19LSVEoR0MsIDAsIG1t
UkxDX1NQTV9NQ19DTlRMLCBkYXRhKTsNCisJZWxzZQ0KKwkJV1JFRzMyX1NPQzE1KEdDLCAwLCBt
bVJMQ19TUE1fTUNfQ05UTCwgZGF0YSk7DQogfQ0KIA0KIHN0YXRpYyBib29sIGdmeF92MTBfMF9j
aGVja19ybGNnX3JhbmdlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OF8wLmMNCmluZGV4IGZjNmMyZjJiYzc2Yy4uYTliY2MwMGY0MzQ4IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KQEAgLTU2MTUsMTIgKzU2MTUs
MTggQEAgc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfdXBkYXRlX3NwbV92bWlkKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCB1bnNpZ25lZCB2bWlkKSAgew0KIAl1MzIgZGF0YTsNCiANCi0JZGF0YSA9
IFJSRUczMihtbVJMQ19TUE1fVk1JRCk7DQorCWlmIChhbWRncHVfc3Jpb3ZfaXNfcHBfb25lX3Zm
KGFkZXYpKQ0KKwkJZGF0YSA9IFJSRUczMl9OT19LSVEobW1STENfU1BNX1ZNSUQpOw0KKwllbHNl
DQorCQlkYXRhID0gUlJFRzMyKG1tUkxDX1NQTV9WTUlEKTsNCiANCiAJZGF0YSAmPSB+UkxDX1NQ
TV9WTUlEX19STENfU1BNX1ZNSURfTUFTSzsNCiAJZGF0YSB8PSAodm1pZCAmIFJMQ19TUE1fVk1J
RF9fUkxDX1NQTV9WTUlEX01BU0spIDw8IFJMQ19TUE1fVk1JRF9fUkxDX1NQTV9WTUlEX19TSElG
VDsNCiANCi0JV1JFRzMyKG1tUkxDX1NQTV9WTUlELCBkYXRhKTsNCisJaWYgKGFtZGdwdV9zcmlv
dl9pc19wcF9vbmVfdmYoYWRldikpDQorCQlXUkVHMzJfTk9fS0lRKG1tUkxDX1NQTV9WTUlELCBk
YXRhKTsNCisJZWxzZQ0KKwkJV1JFRzMyKG1tUkxDX1NQTV9WTUlELCBkYXRhKTsNCiB9DQogDQog
c3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmxjX2Z1bmNzIGljZWxhbmRfcmxjX2Z1bmNzID0g
eyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCmluZGV4IDU0ZWRlZDlhNmFjNS4u
YzdkZTEwODY5YzgxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y5XzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KQEAg
LTQ5NTAsMTQgKzQ5NTAsMjEgQEAgc3RhdGljIGludCBnZnhfdjlfMF91cGRhdGVfZ2Z4X2Nsb2Nr
X2dhdGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiANCiBzdGF0aWMgdm9pZCBnZnhf
djlfMF91cGRhdGVfc3BtX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVk
IHZtaWQpICB7DQotCXUzMiBkYXRhOw0KKwl1MzIgcmVnLCBkYXRhOw0KIA0KLQlkYXRhID0gUlJF
RzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCk7DQorCXJlZyA9IFNPQzE1X1JFR19P
RkZTRVQoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMKTsNCisJaWYgKGFtZGdwdV9zcmlvdl9pc19w
cF9vbmVfdmYoYWRldikpDQorCQlkYXRhID0gUlJFRzMyX05PX0tJUShyZWcpOw0KKwllbHNlDQor
CQlkYXRhID0gUlJFRzMyKHJlZyk7DQogDQogCWRhdGEgJj0gflJMQ19TUE1fTUNfQ05UTF9fUkxD
X1NQTV9WTUlEX01BU0s7DQogCWRhdGEgfD0gKHZtaWQgJiBSTENfU1BNX01DX0NOVExfX1JMQ19T
UE1fVk1JRF9NQVNLKSA8PCBSTENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9fU0hJRlQ7DQog
DQotCVdSRUczMl9TT0MxNShHQywgMCwgbW1STENfU1BNX01DX0NOVEwsIGRhdGEpOw0KKwlpZiAo
YW1kZ3B1X3NyaW92X2lzX3BwX29uZV92ZihhZGV2KSkNCisJCVdSRUczMl9TT0MxNV9OT19LSVEo
R0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMLCBkYXRhKTsNCisJZWxzZQ0KKwkJV1JFRzMyX1NPQzE1
KEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCwgZGF0YSk7DQogfQ0KIA0KIHN0YXRpYyBib29sIGdm
eF92OV8wX2NoZWNrX3JsY2dfcmFuZ2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQotLQ0K
Mi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
