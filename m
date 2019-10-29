Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DDBCA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C002086A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C002086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9A66E2E1;
	Tue, 29 Oct 2019 12:44:51 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam05on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe51::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBC46E2E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 12:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0iP73hLeUwnP0hbTaf/6M8qPzaekI0ZtPM4Q/BeQMx1InTyE2DEhkhhzK/nVkRzDLSeyPz89TYwNyEm+h/9lqFXnLmimOiFmn/r+AXldCX6I0C7Y6dOlZ45qdp+gmnPhIpl5BF8G6Inio2seAOfjX1vPUJxf/IWc7rJwcEr7VWVaufUtFcW15iTN+BFMrx2SOT6+cqwUOqt78a7kKz3BQr8EquAlnigZortanasUEQBNL3Enr7B6AOy9nAC83RJ+2cqyutzWAMNlz6hE7YXkQj9ireMFr/aOrMrButmce10bZ6+hzdcJIRQZ8JW2xPH8sHoWtmN3s/73uR3OUV8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LTyQU5wvY2B92vmm8TE3z85DEPQeii6i9m+Sw3H3KU=;
 b=nK72JHGovGrJpYZVPQ+ejujFReYqCgyKLDg3OTmyBgmgXMECF3r+w8s4qHKsZ1LkpFoRv2BS3fhvaL7ydq2fHaUovvh6hbsRavia0DY830bHbb+Fqg5N1RBMFW5wymvGCKvERz5976zRn/Z2hjixMvfOjL9EEa0hfGjslw//zV2RJVhpGGtzjOWGZ7K+le5XDC0xOuHjgCLkX14EI/3pOIKiQ66kYmTh5BcJ1I/bBUSp977N9k/gXBDGT6YvaKtyfH8z8uehpXoFgUzzPyEvLy0U6qlP6FcylM5a49nxtoLaHwRdFL9WAbKgLbHV9PKQRwxAgryuCg5yx9IBkMYyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB3814.namprd12.prod.outlook.com (52.132.245.84) by
 CH2PR12MB4165.namprd12.prod.outlook.com (20.180.5.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Tue, 29 Oct 2019 12:44:44 +0000
Received: from CH2PR12MB3814.namprd12.prod.outlook.com
 ([fe80::e848:be51:4d4c:cf50]) by CH2PR12MB3814.namprd12.prod.outlook.com
 ([fe80::e848:be51:4d4c:cf50%5]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 12:44:44 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le"
 <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: add missing amdgpu_ras.h header include
Thread-Topic: [PATCH 1/1] drm/amdgpu: add missing amdgpu_ras.h header include
Thread-Index: AQHVjlZqnpiSzTrBQkyEG75pvKr7xadxkFOAgAAARAA=
Date: Tue, 29 Oct 2019 12:44:44 +0000
Message-ID: <765b83f2-bd0a-9cbb-7022-5afa0dc902fc@amd.com>
References: <1572352976-22963-1-git-send-email-le.ma@amd.com>
 <DM5PR12MB18200145818DFEB546A06701F7610@DM5PR12MB1820.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB18200145818DFEB546A06701F7610@DM5PR12MB1820.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:400:4::32) To CH2PR12MB3814.namprd12.prod.outlook.com
 (2603:10b6:610:28::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fb6ba13-035a-4185-3171-08d75c6dc66c
x-ms-traffictypediagnostic: CH2PR12MB4165:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4165A1BD74950B9600EEC179F7610@CH2PR12MB4165.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:169;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(229853002)(6486002)(4001150100001)(36756003)(8676002)(7736002)(6246003)(2501003)(476003)(478600001)(5660300002)(486006)(71190400001)(31686004)(256004)(81156014)(8936002)(2906002)(305945005)(71200400001)(81166006)(3846002)(6116002)(31696002)(53546011)(102836004)(386003)(6506007)(66066001)(86362001)(64756008)(66446008)(66556008)(66476007)(25786009)(26005)(66946007)(76176011)(99286004)(52116002)(14454004)(186003)(6306002)(966005)(6512007)(2616005)(11346002)(446003)(316002)(110136005)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4165;
 H:CH2PR12MB3814.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNoz7K8Chc3YNatFD22vOFqQ3ddtFoKx3tZr6VHg8IloxTefCjLXbo/neCBOwuBuDWzM18Ha7eWwmQs8M44mWmXI0+7ZLjDtGNow/WxSrYSgY6+GACrRRjvAp8QYL8iXY47sL7kvpPEce9GsHx5Cc+kJdy/GKCKPsCpQob5d+UfqWfa/xImaA1WnO3wMyJ/5F8Ny0KAd6bIRirbPSOrgsFA6TrTKLBMC+K/Mj6CJt3JUOBPsrYOFUjAjLxqAiIIzb0hF3h2VQfpJwskDB1XthefDY5txtgP7dQ/Hw3Zf07ieddlwH3TsTro1RKyhhxB6XcmoWLe64IvcAs3d1GHnlQcT5SZ+MWXzB7u80xolCO5o3rIvRRyhfWIyPwjFY5oCEMiLe3UYaLzXuOxNqVW3Bgkr1HcUtNXaBK9SWuMw7RRvnrsEJsmlPZdGauz2MGdObDJRI7MmHxORpql8YdvzuErtLTfBAYg4WEfrnorIRjc=
Content-ID: <A6705A695DA19D40930491D73ED468D2@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb6ba13-035a-4185-3171-08d75c6dc66c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 12:44:44.8733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOt8tCwMBcqRqoPu+6i+3lfEXHXvmKhHZH2NSLSZHgAdGBHT6/HyZP+67oXpMi48pNxeVcPi6DUu5c7FYw8mFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LTyQU5wvY2B92vmm8TE3z85DEPQeii6i9m+Sw3H3KU=;
 b=Xb7Eg4aaa6mGqUaSeHWVnF4+In84ho3754FX06dPDJUUOIVQ3T6cu2h3TVqmhPrWtX2o2JJefPy9IsiA9zqWAvsD1K6/RKaPews7/K4OpM2tV4HIM8X5tU7QLfIqJFCF5K2ryAuzr72q0u2mjXsBNkIyQvrrUk9ZpoDT/KOkvmc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
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
Message-ID: <20191029124444.1H2ek45-UTG6dgEnz6HnWgwsGvPIaTeMCqSWThbnoBM@z>

Q29tcGlsZXMgZmluZS4NCg0KDQpUZXN0ZWQtYnk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNA
YW1kLmNvbT4NCg0KDQpPbiAyMDE5LTEwLTI5IDg6NDMgYS5tLiwgRGV1Y2hlciwgQWxleGFuZGVy
IHdyb3RlOg0KPiBBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKkZyb206KiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5j
ZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBvbiBiZWhhbGYgb2YgDQo+IExlIE1hIDxsZS5tYUBh
bWQuY29tPg0KPiAqU2VudDoqIFR1ZXNkYXksIE9jdG9iZXIgMjksIDIwMTkgODo0MiBBTQ0KPiAq
VG86KiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+DQo+ICpDYzoqIFN0RGVuaXMsIFRvbSA8VG9tLlN0RGVuaXNAYW1kLmNvbT47IE1h
LCBMZSA8TGUuTWFAYW1kLmNvbT4NCj4gKlN1YmplY3Q6KiBbUEFUQ0ggMS8xXSBkcm0vYW1kZ3B1
OiBhZGQgbWlzc2luZyBhbWRncHVfcmFzLmggaGVhZGVyIA0KPiBpbmNsdWRlDQo+IEZpeCBjb21w
aWxhdGlvbiBlcnJvci4NCj4NCj4gQ2hhbmdlLUlkOiBJNDYxYzU1ODc3OGY5YTUyMzc4MjY5MzI0
ZGM0MWI4ZDYzOWYzY2NiZQ0KPiBTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4N
Cj4gLS0tDQo+IMKgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgMiAr
Kw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyANCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gaW5kZXggZmNlMjA2Zi4uYmJlOWFjNyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiBAQCAtMzQs
NiArMzQsOCBAQA0KPiDCoCNpbmNsdWRlICJwc3BfdjExXzAuaCINCj4gwqAjaW5jbHVkZSAicHNw
X3YxMl8wLmgiDQo+DQo+ICsjaW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIg0KPiArDQo+IMKgc3RhdGlj
IHZvaWQgcHNwX3NldF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+DQo+IMKg
c3RhdGljIGludCBwc3BfZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpDQo+IC0tIA0KPiAyLjcuNA0K
Pg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
