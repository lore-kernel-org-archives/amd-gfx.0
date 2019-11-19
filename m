Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEB2C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 03:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BB32070E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 03:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BB32070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B7D899BB;
	Tue, 19 Nov 2019 03:12:53 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720049.outbound.protection.outlook.com [40.107.72.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A61D899BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 03:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUmcIggMps9/o1o3Uut4BgXkPWP4Z0cpjW0k1r2UAh5mJzUuWOzC0tss3nKD1JP/ztdTA8Xv3AnSuUrBFy5NQ93q7I6+X0VNI+Nc887WVBGDWFjIW3ndtsarzJNywt4FLTe5OFpUaURZSpLH9Nxwv+U5El8zHPjdYLSraIPmqPn/z3jj5faGL2jEAx8P4l0jXCXQV+qp4CkDYQnJbuM2221EK/bl4xgrV6Xy+BuALjv4DtqaqQqswxlxi8kYJV8GnxPdfYTNT1MsANRfulhV8dkEETeIMABd1z7yA4Bo2w7/NfCcB2iFenyQaPC8Od+oyHCaBesDZIN+uWd/gzwCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffgYLYwpOk/zicTVymvuKOuTDHMOrj4HYD3RhVQUtI8=;
 b=WonZLV8f5to+DNAWDsUH2zk15EOydP7Sn6lrKjOoGJCuk5pE/AWv1J8BnVgkAe5nFxHa4nrOzqR7gqA3REQMlc1ht4yUno7pohBeNlBCjL3lTX+ur5p/yHoriES8GHyTyJrBldelJSpTA8SAGk4SYm3TPmQ6KArOZ9FXJ8OpoBj4aUKd12FJuPThZDk9iGUGC83+x/wbniWTuhCDnO7CekRqwORfoynHajDo2CFZdSKSZGb3EhSpjIzQuO2jZomM8iiU6d53ivGSbR3NST16/JgaMHbwjVb5xYha5N+UbYe5nsnxZk9Dm5eVl/K5MfJIONQucy8hjZWgChYA4Kaxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3247.namprd12.prod.outlook.com (20.179.81.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Tue, 19 Nov 2019 03:12:49 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 03:12:49 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: disable gfxoff when using register read
 interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: disable gfxoff when using register read
 interface
Thread-Index: AQHVmwpzNZz69msWkUSJxFCPkSAqAaeR15OQ
Date: Tue, 19 Nov 2019 03:12:49 +0000
Message-ID:
 <MN2PR12MB334427DF742433ACCB68AC31E44C0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191114164148.2304223-1-alexander.deucher@amd.com>
 <20191114164148.2304223-2-alexander.deucher@amd.com>
In-Reply-To: <20191114164148.2304223-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [120.243.52.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b97ecd44-0eeb-4850-214e-08d76c9e5bd5
x-ms-traffictypediagnostic: MN2PR12MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB32471447F8D0781A7FA4216EE44C0@MN2PR12MB3247.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(189003)(199004)(13464003)(2906002)(11346002)(3846002)(446003)(14454004)(66476007)(66946007)(486006)(66556008)(66446008)(74316002)(81166006)(2501003)(33656002)(25786009)(6246003)(110136005)(99286004)(76116006)(5660300002)(81156014)(8676002)(186003)(6506007)(53546011)(66066001)(305945005)(102836004)(26005)(7736002)(476003)(6116002)(8936002)(4326008)(966005)(52536014)(316002)(478600001)(64756008)(229853002)(55016002)(6436002)(9686003)(6306002)(14444005)(256004)(71190400001)(71200400001)(76176011)(86362001)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3247;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vqx1sKAk+JzJh4E7LTauPhSrNXVBlI+rTzS/Lt0rn1jNlBvVNxZtJz7/ooBz4YuhBai1X84khSjy6vHK55KzpbYJnFM+l6IZatbzsftlrPJJTm/FYix/8XgwwFjsSEQipGmaBOkESJi/ksqFkApbbXwv+d190mPlgiY7V1xl5WFXdDNzMPajXJttIKT0X1kRz45Kji812uPOHSc5rcBYbayvHqk2NA5x10IacqOyCJt4rV8zRnYjv+Vp/t2UJx3OpY7Fxs6lovwM652Uw8SqGikwq2wW8MvyLFYveH8kJEVo1TN4mP+lxdECuHF3B5AAm9gYtBmPsWoiJNLXIfO3JJkw2GiyKwc00A/Lb1Coca+6js/BDk2989BtKxmcSy1npNC39LoUqQf+DsN5VgNj1W6TXaDBmxrmDODb+ycfuo2/BpjBL9ZIJoAzm6nxri5E
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97ecd44-0eeb-4850-214e-08d76c9e5bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 03:12:49.6292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFfOPNqpJY2U8f4rTtW9yxXM8qWQtyOJDCZfGHmNo7JaUmgBsN7TCgqa4Cr1bEya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3247
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffgYLYwpOk/zicTVymvuKOuTDHMOrj4HYD3RhVQUtI8=;
 b=iYjAL2aFdn+CsalIvGPuXiqqoS/fhOy5Q8ujEqqC23TFKoJ4lv39m5H7yy5kDPiN8MNFvhJUVxdHXL9yBYa5QmQIHMkkFTsyJAL3CKaIW7H8klJr00g3oWeA/DpSobQAR1TK5aaQmiPHIeI3us9Ds8Z1a2Qo582oRgUJIm/flqk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Message-ID: <20191119031249.iSFLKNqJ_QnDp0i0XtdwFTndXpe1DCXqiWfmbSFYKYQ@z>

U2VyaWVzIGlzIHJldmlld2VkLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2Vz
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1Y2hlcg0KU2VudDog
RnJpZGF5LCBOb3ZlbWJlciAxNSwgMjAxOSAxMjo0MiBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPg0KU3ViamVjdDogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogZGlzYWJsZSBnZnhvZmYg
d2hlbiB1c2luZyByZWdpc3RlciByZWFkIGludGVyZmFjZQ0KDQpXaGVuIGdmeG9mZiBpcyBlbmFi
bGVkLCBhY2Nlc3NpbmcgZ2Z4IHJlZ2lzdGVycyB2aWEgTU1JTyBjYW4gbGVhZCB0byBhIGhhbmcu
DQoNCkJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDU0
OTcNClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDYgKysr
KystDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQppbmRleCA2ZGRlYTc2MDdhZDAu
LjVmM2IzYTcwNWIyOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9rbXMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5j
DQpAQCAtNjU5LDE1ICs2NTksMTkgQEAgc3RhdGljIGludCBhbWRncHVfaW5mb19pb2N0bChzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUNCiAJCQlyZXR1
cm4gLUVOT01FTTsNCiAJCWFsbG9jX3NpemUgPSBpbmZvLT5yZWFkX21tcl9yZWcuY291bnQgKiBz
aXplb2YoKnJlZ3MpOw0KIA0KLQkJZm9yIChpID0gMDsgaSA8IGluZm8tPnJlYWRfbW1yX3JlZy5j
b3VudDsgaSsrKQ0KKwkJYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7DQorCQlmb3Ig
KGkgPSAwOyBpIDwgaW5mby0+cmVhZF9tbXJfcmVnLmNvdW50OyBpKyspIHsNCiAJCQlpZiAoYW1k
Z3B1X2FzaWNfcmVhZF9yZWdpc3RlcihhZGV2LCBzZV9udW0sIHNoX251bSwNCiAJCQkJCQkgICAg
ICBpbmZvLT5yZWFkX21tcl9yZWcuZHdvcmRfb2Zmc2V0ICsgaSwNCiAJCQkJCQkgICAgICAmcmVn
c1tpXSkpIHsNCiAJCQkJRFJNX0RFQlVHX0tNUygidW5hbGxvd2VkIG9mZnNldCAlI3hcbiIsDQog
CQkJCQkgICAgICBpbmZvLT5yZWFkX21tcl9yZWcuZHdvcmRfb2Zmc2V0ICsgaSk7DQogCQkJCWtm
cmVlKHJlZ3MpOw0KKwkJCQlhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIHRydWUpOw0KIAkJCQly
ZXR1cm4gLUVGQVVMVDsNCiAJCQl9DQorCQl9DQorCQlhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYs
IHRydWUpOw0KIAkJbiA9IGNvcHlfdG9fdXNlcihvdXQsIHJlZ3MsIG1pbihzaXplLCBhbGxvY19z
aXplKSk7DQogCQlrZnJlZShyZWdzKTsNCiAJCXJldHVybiBuID8gLUVGQVVMVCA6IDA7DQotLQ0K
Mi4yMy4wDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
