Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458DFC4346E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 05:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A728235FD
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 05:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="isRHm7WH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A728235FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57946EA7D;
	Thu, 24 Sep 2020 05:54:57 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760042.outbound.protection.outlook.com [40.107.76.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B326EA7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 05:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kwh/TgP03MtGAjIf9sXgC2MKWS4MCNTfrwOsH3hpiV7qTcX+S685qa2j3rKQ5dK3ecr2m+8xPFkRz4WxnrqthooxDcS2i8o4QjclyD+l9zN66Y9z/wk2XVGBsQ0wcASvMa0CRVnFIF2YAr2MAVuA6pSkbjZNf4PGEwbIwB2pq4we2dVEKo70SySriv5fvmc6nZfpvP4c3wdyuucViaxrYX4fgIplqB1LmVpfWtVI9cEjxfgVmAfuBxjOUJpJp9jmCpKZ857B0cVic2lg8DhAK/uJFVkepWz7OEhiksbp6VmuSVvj6yP6oYHvZ4vnuA2sggDhojx2rRdYtM0NwFKMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3okXWcoeFFLA+VCMzmNSglKlLLs01AQkZKeVl9k9lnE=;
 b=ZKT9AWhBvt+SAcO1iURftzrro52SpJWInp3UkROZG7L1mN2dztsEnbsVvqDtmMG5wKitd6PK3AnTUgLlIrtYcG3nuApVH9tOaHlXDTWxyM6X9PuwcPNdeDt3hZVh0XC/atrVxXbCGmWwQyF8Vi3t4WyKorIYDlfTPkhrO+wwTyFfGi5iaD+8PAHLmvKlgQcUOKpkD8tx+NhhOd0SWzF8DRX2/hBBQl8nwYXyR1hGkO9tYTRIzIWTcQKzQV9b2nS2mOVh2G8mp+HdlJVIDs+bim5BuPOl9TwvzF6ajYGiKSNBwG/GOAQgCoXW6XJpDnawWnVRAIFTJ69/tOmEUUDXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3okXWcoeFFLA+VCMzmNSglKlLLs01AQkZKeVl9k9lnE=;
 b=isRHm7WHIeWhjIrSPU5mU6DA2w8esDc6cXKlQe+IzldIO/Wmffog07U0xdM2EjcYbYa5QzX340vy+vX6yY6Z5+iFgNM8zeCkGk+HcpnrkQPJiQX4RKKGGPXRIFVGX/aXO4rScvNbTktwRBt4U9e3OuUMUgKGX5PsDI9zNpuMrZ4=
Received: from DM6PR12MB3500.namprd12.prod.outlook.com (2603:10b6:5:11d::16)
 by DM6PR12MB3658.namprd12.prod.outlook.com (2603:10b6:5:1c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 05:54:55 +0000
Received: from DM6PR12MB3500.namprd12.prod.outlook.com
 ([fe80::48f5:6cbb:7e5c:4a28]) by DM6PR12MB3500.namprd12.prod.outlook.com
 ([fe80::48f5:6cbb:7e5c:4a28%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 05:54:55 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBkcm0vYW1kZ3B1OiBSZW1vdmUgc29tZSB1c2VsZXNz?=
 =?gb2312?Q?_code?=
Thread-Topic: [PATCH] drm/amdgpu: Remove some useless code
Thread-Index: AQHWkiigykmCEFuvlUydgcDi/DxuFKl3SZYQ
Date: Thu, 24 Sep 2020 05:54:54 +0000
Message-ID: <DM6PR12MB35003A1B9C4098042AD34B66E9390@DM6PR12MB3500.namprd12.prod.outlook.com>
References: <20200924041010.4036-1-Emily.Deng@amd.com>
In-Reply-To: <20200924041010.4036-1-Emily.Deng@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67f933bb-6bc3-47b5-e417-08d8604e5ca6
x-ms-traffictypediagnostic: DM6PR12MB3658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3658518713F7DEB81CCF3FF4E9390@DM6PR12MB3658.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrXBAyGRmsfjmPuI/Rm4MUGn46UMU5Y3lbyGVfOUCvskIVFM9imoB6gzW8h+7j76N1y8C4PIUdul/W7KekVxyl69zsi7FK6DmLwgl3AVT4wqwj/nmF43g+e0Yu9AtaA3H3pVC29En7B/eWE7ynGVWc/Xy7mWSe6TnFR8P602jiKsMIGNrcyjm140lofcv8K0g/aqjdH9keAkhj0yMA/3Loq5Oyk1HfmYGO4a9wtJpGDbbAWAQR1s+N2ruG6mC//Fh1AG2NrAVyWhREdxi3pZQF465UHlU9374npn3qkNbR7RPkq0emfiSHcgI011/lFvczJneUCSA9QzgHe+LOiAM72vowX0jD+333npTU2UpjucPw1Tvl5ktOBVWo5m9aZJTHpyfgcnjX4aGh9MvveCRfv/xhhgtA8YyEbqki0E0Dg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3500.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(224303003)(2906002)(966005)(55016002)(6506007)(7696005)(316002)(110136005)(4326008)(83380400001)(8936002)(86362001)(9686003)(186003)(5660300002)(66476007)(66556008)(52536014)(71200400001)(478600001)(33656002)(66446008)(64756008)(45080400002)(26005)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WAlreLEvJgkaa60CduYhkI7aXDLfTOrOnMJsMAsOzda6YvuNrb/j7GXewnmLBBb1qXG2m+zC30UFUcbfMqZFhwdRnEUy575v3yqOEgPmpivIhlXuiLK0I52+4DOkn43BcPiNTy/xp1dhmyfqZHUwASzWatRNEfTI8b6hm7tBb6vyNEStCK3G35ctkLbUv0nl1QB9CD1SY04PZ2VBipHVzEwqMo3zo0JjMhgbVl0ReCX40ePZG5PBYuue83ss8aezcYvdNGF3cWlrm7wiKefXwn7hp+71aveHntth6vZE3irPEAYH+ks8Q9Ba5cjTixFXGn+0zEUtxibeAblEJ+uZoCfyh4klrfv59qxJ6DNVirzxw9HwjqthbjLl/OmKyTLIbHG1i066KtYKN82rRWIjZTdVkT+LFo/gqQyqW9/w2y3yLSFieGoguvh82/V6/lLQMw423/SPJgElDe/0bVQfsk2iLir0Gi/EXTTSP6YR9zQpA407q0oFFlC0cj1B6uDqWSXUiJfyo+NjCZ48mEovrDbvFWwm3EXD0baKMMHJlPtYMwPh16HQEqSc4Ei4hV3k4ZUC4PR6CUFMeaMsjctaU6Cn5r9bZy2hmckdKj4MTX+nlPGHl8RnRJ09qwIV4jq32/IVWq0usKGOS036UQG02w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f933bb-6bc3-47b5-e417-08d8604e5ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 05:54:54.9822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /X8uk230zbYI107NwjP/5PAuu2iz6bAz0VbPl5Poe7gDgrvqf4BbHjdDQuIKsmP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3658
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBpcyBSZXZpZXdlZC1ieTogRnJhbmsgTWluIDxGcmFuay5NaW5AYW1kLmNvbT4N
Cg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+ILT6se0gRW1pbHkuRGVuZw0Kt6LLzcqxvOQ6IDIwMjDE6jnU
wjI0yNUgMTI6MTANCsrVvP7IyzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCrOty806
IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+DQrW98ziOiBbUEFUQ0hdIGRybS9hbWRn
cHU6IFJlbW92ZSBzb21lIHVzZWxlc3MgY29kZQ0KDQpTaWduZWQtb2ZmLWJ5OiBFbWlseS5EZW5n
IDxFbWlseS5EZW5nQGFtZC5jb20+DQpDaGFuZ2UtSWQ6IEkxYTE0ZGNjNmYyZDUzOTViMmMzODVm
NGYyOTA0OTRjZTdkZTEwOGI0DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnho
dWJfdjJfMC5jICAgICAgICAgICAgfCAgNSAtLS0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L21taHViX3YyXzAuYyAgICAgICAgICAgICB8ICA1IC0tLS0tDQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvcHNwX2dmeF9pZi5oICAgICAgICAgICAgIHwgMTMgLS0tLS0tLS0tLS0tLQ0K
IC4uLi9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211bWdyL3NtdTlfc211bWdyLmMgICB8ICA3
IC0tLS0tLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDMwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YyXzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92Ml8wLmMNCmluZGV4IGI4ODJhYzU5ODc5YS4uMDkwNWQ2
Mzk3OTcyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3Yy
XzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YyXzAuYw0KQEAg
LTE1MywxMSArMTUzLDYgQEAgc3RhdGljIHZvaWQgZ2Z4aHViX3YyXzBfaW5pdF9zeXN0ZW1fYXBl
cnR1cmVfcmVncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJdWludDY0X3QgdmFsdWU7
DQogDQogCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQotCQkvKg0KLQkJICogdGhlIG5l
dyBMMSBwb2xpY3kgd2lsbCBibG9jayBTUklPViBndWVzdCBmcm9tIHdyaXRpbmcNCi0JCSAqIHRo
ZXNlIHJlZ3MsIGFuZCB0aGV5IHdpbGwgYmUgcHJvZ3JhbWVkIGF0IGhvc3QuDQotCQkgKiBzbyBz
a2lwIHByb2dyYW1pbmcgdGhlc2UgcmVncy4NCi0JCSAqLw0KIAkJLyogRGlzYWJsZSBBR1AuICov
DQogCQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tR0NNQ19WTV9BR1BfQkFTRSwgMCk7DQogCQlXUkVH
MzJfU09DMTUoR0MsIDAsIG1tR0NNQ19WTV9BR1BfVE9QLCAwKTsgZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L21taHViX3YyXzAuYw0KaW5kZXggMmQ4ODI3OGM1MGJmLi41MjQxZmE5OTEyNDggMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92Ml8wLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YyXzAuYw0KQEAgLTIwMSwxMSArMjAx
LDYgQEAgc3RhdGljIHZvaWQgbW1odWJfdjJfMF9pbml0X3N5c3RlbV9hcGVydHVyZV9yZWdzKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KIAlXUkVHMzJfU09DMTUoTU1IVUIsIDAsIG1tTU1N
Q19WTV9BR1BfQk9ULCAweDAwRkZGRkZGKTsNCiANCiAJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRl
dikpIHsNCi0JCS8qDQotCQkgKiB0aGUgbmV3IEwxIHBvbGljeSB3aWxsIGJsb2NrIFNSSU9WIGd1
ZXN0IGZyb20gd3JpdGluZw0KLQkJICogdGhlc2UgcmVncywgYW5kIHRoZXkgd2lsbCBiZSBwcm9n
cmFtZWQgYXQgaG9zdC4NCi0JCSAqIHNvIHNraXAgcHJvZ3JhbWluZyB0aGVzZSByZWdzLg0KLQkJ
ICovDQogCQkvKiBQcm9ncmFtIHRoZSBzeXN0ZW0gYXBlcnR1cmUgbG93IGxvZ2ljYWwgcGFnZSBu
dW1iZXIuICovDQogCQlXUkVHMzJfU09DMTUoTU1IVUIsIDAsIG1tTU1NQ19WTV9TWVNURU1fQVBF
UlRVUkVfTE9XX0FERFIsDQogCQkJICAgICBhZGV2LT5nbWMudnJhbV9zdGFydCA+PiAxOCk7DQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX2dmeF9pZi5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX2dmeF9pZi5oDQppbmRleCBjYmMwNGE1YzBmZTEu
LjFlZjJmNWIxZDgyOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Bz
cF9nZnhfaWYuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX2dmeF9pZi5o
DQpAQCAtODMsMTkgKzgzLDYgQEAgc3RydWN0IHBzcF9nZnhfY3RybA0KICovDQogI2RlZmluZSBH
RlhfRkxBR19SRVNQT05TRSAgICAgICAgICAgICAgIDB4ODAwMDAwMDANCiANCi0vKiBHYnIgSUgg
cmVnaXN0ZXJzIElEICovDQotZW51bSBpaF9yZWdfaWQgew0KLQlJSF9SQgkJPSAwLAkJLy8gSUhf
UkJfQ05UTA0KLQlJSF9SQl9STkcxCT0gMSwJCS8vIElIX1JCX0NOVExfUklORzENCi0JSUhfUkJf
Uk5HMgk9IDIsCQkvLyBJSF9SQl9DTlRMX1JJTkcyDQotfTsNCi0NCi0vKiBDb21tYW5kIHRvIHNl
dHVwIEdpYnJhbHRhciBJSCByZWdpc3RlciAqLyAtc3RydWN0IHBzcF9nZnhfY21kX2dicl9paF9y
ZWcgew0KLQl1aW50MzJfdAkJcmVnX3ZhbHVlOwkvKiBWYWx1ZSB0byBiZSBzZXQgdG8gdGhlIElI
X1JCX0NOVEwuLi4gcmVnaXN0ZXIqLw0KLQllbnVtIGloX3JlZ19pZAkJcmVnX2lkOwkJLyogSUQg
b2YgdGhlIHJlZ2lzdGVyICovDQotfTsNCi0NCiAvKiBURUUgR2Z4IENvbW1hbmQgSURzIGZvciB0
aGUgcmluZyBidWZmZXIgaW50ZXJmYWNlLiAqLyAgZW51bSBwc3BfZ2Z4X2NtZF9pZCAgeyBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211bWdyL3NtdTlfc211
bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3Ivc211OV9zbXVt
Z3IuYw0KaW5kZXggYWRmYmNiZTVkMTEzLi44YTlhZWU4NTA0M2UgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9zbXVtZ3Ivc211OV9zbXVtZ3IuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc211bWdyL3NtdTlfc211bWdyLmMNCkBA
IC02MSw5ICs2MSw2IEBAIHN0YXRpYyB1aW50MzJfdCBzbXU5X3dhaXRfZm9yX3Jlc3BvbnNlKHN0
cnVjdCBwcF9od21nciAqaHdtZ3IpDQogCXVpbnQzMl90IHJlZzsNCiAJdWludDMyX3QgcmV0Ow0K
IA0KLQkvKiBEdWUgdG8gdGhlIEwxIHBvbGljeSBwcm9ibGVtIHVuZGVyIFNSSU9WLCB3ZSBoYXZl
IHRvIHVzZQ0KLQkgKiBtbU1QMV9TTU5fQzJQTVNHXzEwMyBhcyB0aGUgZHJpdmVyIHJlc3BvbnNl
IHJlZ2lzdGVyDQotCSAqLw0KIAlpZiAoaHdtZ3ItPnBwX29uZV92Zikgew0KIAkJcmVnID0gU09D
MTVfUkVHX09GRlNFVChNUDEsIDAsIG1tTVAxX1NNTl9DMlBNU0dfMTAzKTsNCiANCkBAIC0xNDgs
MTAgKzE0NSw2IEBAIGludCBzbXU5X3NlbmRfbXNnX3RvX3NtY193aXRoX3BhcmFtZXRlcihzdHJ1
Y3QgcHBfaHdtZ3IgKmh3bWdyLA0KIA0KIAlzbXU5X3dhaXRfZm9yX3Jlc3BvbnNlKGh3bWdyKTsN
CiANCi0JLyogRHVlIHRvIHRoZSBMMSBwb2xpY3kgcHJvYmxlbSB1bmRlciBTUklPViwgd2UgaGF2
ZSB0byB1c2UNCi0JICogbW1NUDFfU01OX0MyUE1TR18xMDEgYXMgdGhlIGRyaXZlciBtZXNzYWdl
IHJlZ2lzdGVyIGFuZA0KLQkgKiBtbU1QMV9TTU5fQzJQTVNHXzEwMiBhcyB0aGUgZHJpdmVyIHBh
cmFtZXRlciByZWdpc3Rlci4NCi0JICovDQogCWlmIChod21nci0+cHBfb25lX3ZmKSB7DQogCQlX
UkVHMzJfU09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNHXzEwMywgMCk7DQogCQlXUkVHMzJf
U09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNHXzEwMiwgcGFyYW1ldGVyKTsNCi0tDQoyLjI1
LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFt
ZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6
Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZh
bXA7ZGF0YT0wMiU3QzAxJTdDZnJhbmsubWluJTQwYW1kLmNvbSU3QzUwYzgwYjcyNGNjMjQzNWRi
MjQxMDhkODYwM2ZjMDVhJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdD
MCU3QzYzNzM2NTE3NDIzNjk4NTE4MSZhbXA7c2RhdGE9TCUyQm5BNFZ2M1NFWCUyQkYyeDBydFBw
MFNzVXlDWUNBQ2NibVVhd2N1YXVoS2slM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
