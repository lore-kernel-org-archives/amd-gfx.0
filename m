Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1823BC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C761320661
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eCOmBrNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C761320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853776F528;
	Wed, 12 Feb 2020 15:32:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC906F527
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 15:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lqr0LkoPGGTy3MlaG5Jb7lK1vPwO/2NahyI9tz5ENSVY2ByS7VIZgfNsUzmP0eQOh35VPgzNLJpcUojNHczhR7wF/lB7nqSRxJfvnHotBtdZkJYRmU6B0js7akbyvMrYz5wMv4HhK338X7U6VP2gNOD/gy2CyRm4l/Xe52lPGsicBzgxUJpAJeD1qz0hLBlJDotoFyc2WPvqx10sw5MX4WXEyzjAgLG3g9PGj1eBqWorWe6r5gwWuImIritvt9baJqVdynx6V+zkZ6PzQcUpaFSg/5zK3KoW/te53U0xkD2hjFZBQx6AmIxpYaKq8LhZb4IWoDC3Or1Vy4Ilk0gpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKuAHwIPiVGl7wJICoW3VHbqvfbpT5/KtzeQW4tZAD0=;
 b=eOkfUz1D5w8Vc5EbUKPQETAw8vJf/8EbVFi4YopSi2oudPe5mHk/SOHmKOyQDWftMpLw5BZWHsNpiH+OoHRvQNcO+pwS+3W8Z8cCBC7wX+nHpagez8TGBQPRil7zLq0v+OIardhzMbOVzZf4ljgeu7X4h4ZseOcZgqki/NXvlzkoRx3Hzi2uN5ExsVjWuqZF17yh5fTQWfSsD0XYnD30TH9IvZKk/PzvAjCv5jl3aoHbPaKcdq1B0Kz6IBAn7+2GM6SsLCILNI6s4Y/S2GyZI6pyxeUsp+ClccT0DH1plXrdJz7JGAGnyycYvWRUo0jw0umwVQlBZdv55MI/0JrM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKuAHwIPiVGl7wJICoW3VHbqvfbpT5/KtzeQW4tZAD0=;
 b=eCOmBrNkb9oXWLUXVfMbScf7oZaau46SbISWvq/p+ZLe4uXZ7kkqJgsY8U23dvgulVNt1pH2N2aMSW9GNklGLl1/UcZJKTavvDNWxphf9U2GYJ+33pX3kirTxEHUVxVRez8nnLdfovpoMix508qO8A89g87vEvUdvOaHNKwOIck=
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3982.namprd12.prod.outlook.com (10.255.238.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 15:32:23 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 15:32:23 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx10: disable gfxoff when reading rlc
 clock
Thread-Topic: [PATCH 2/2] drm/amdgpu/gfx10: disable gfxoff when reading rlc
 clock
Thread-Index: AQHV4avWCoYY63d6U0mC7bw2PLUupKgXr+ah
Date: Wed, 12 Feb 2020 15:32:23 +0000
Message-ID: <66081F18-7F03-43B6-A054-AB3D9F7449B7@amd.com>
References: <20200212135326.1165548-1-alexander.deucher@amd.com>,
 <20200212135326.1165548-2-alexander.deucher@amd.com>
In-Reply-To: <20200212135326.1165548-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
x-originating-ip: [192.241.193.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4780f129-1464-4868-1920-08d7afd0c1ee
x-ms-traffictypediagnostic: MN2PR12MB3982:|MN2PR12MB3982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39824E53D92F1305F4D3BB8C891B0@MN2PR12MB3982.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(189003)(199004)(66946007)(64756008)(2906002)(66556008)(2616005)(91956017)(6512007)(76116006)(66446008)(66476007)(5660300002)(36756003)(55236004)(86362001)(53546011)(6916009)(316002)(6506007)(8676002)(54906003)(8936002)(81156014)(33656002)(966005)(478600001)(26005)(71200400001)(4326008)(186003)(6486002)(81166006)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3982;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U2xkaR/mWAWH5+2xLhpQdT4FCCpbUyXEPvlYsFQw7KD9MxwQNBQOd+V1r819IIC4ikQiWI0S/DwgU1tOkzDdkgpMnRJcJMcQsP/pnYPKQeEKWUa0U0KTnG4LyCt3hObzYAMlf2TGjH8YKO8xTz4NaPGK00aOoxHW2mbGbF5wS0Uq6U7RqMxzJ38r22/LlforHOf2543i0cLThnx3Vb4i3oliYVyV5pcia3OWZ+/WImRkhUcFbOm0wkRWyTiw54cx6jO3dTdE0KwY4TuSZvv3fh55HANUSMVeyFDKJe7TB5wF/05Y7gZfaMvlVbDts9T/m33GdcZJMJMOuc5J9+Use3s5Sdp9spbhvUlUHt7/th7uJOD+Wk4gQkiDJ7MFfpTVkgFmd2UxVx6/+HnHH489JBuIu5JdkgQk8Hy1wkiKEMPB4VZOJ4NFIn697O+XS7SbJopyxQtqIR97+gcETNZd510qLrpRW2MmtogO/53QyQ+yH/begcXV7kz5o/ZIXE1s
x-ms-exchange-antispam-messagedata: 7fAxpkXf6a31+PfwfeseB+KfpJeHcoAsqsacZLlT0Ciqs5Cnd4xC4Y9iFttbaQnuNDRHg2czjjEdqD5MF67nk4X6X1uiyYWflnWtZgGozmMzC2RmrfsaI84z+IZUA6b++XWzCBMzzx366iNz/XFitg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4780f129-1464-4868-1920-08d7afd0c1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 15:32:23.6590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUJiJETNqqo/KpFGa6wOEuGikwXO8AQwtBiaxX/X/YBN0rj47c58iyWXmMOQfRmb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3982
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VyaWVzIGlzIFJldmlld2VkLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29t
Pg0KDQpCUiwNClhpYW9qaWUNCg0KPiBPbiBGZWIgMTIsIDIwMjAsIGF0IDk6NTMgUE0sIEFsZXgg
RGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IO+7v090aGVyd2lz
ZSB3ZSByZWFkYmFjayBhbGwgb25lcy4gIEZpeGVzIHJsYyBjb3VudGVyDQo+IHJlYWRiYWNrIHdo
aWxlIGdmeG9mZiBpcyBhY3RpdmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjEwXzAuYyB8IDIgKysNCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gaW5kZXgg
NGUyNWIzOWFjMTRmLi4wZWZmMmU3ZDMzZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jDQo+IEBAIC0zOTI0LDExICszOTI0LDEzIEBAIHN0YXRpYyB1aW50NjRf
dCBnZnhfdjEwXzBfZ2V0X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KPiB7DQo+ICAgIHVpbnQ2NF90IGNsb2NrOw0KPiANCj4gKyAgICBhbWRncHVfZ2Z4X29m
Zl9jdHJsKGFkZXYsIGZhbHNlKTsNCj4gICAgbXV0ZXhfbG9jaygmYWRldi0+Z2Z4LmdwdV9jbG9j
a19tdXRleCk7DQo+ICAgIFdSRUczMl9TT0MxNShHQywgMCwgbW1STENfQ0FQVFVSRV9HUFVfQ0xP
Q0tfQ09VTlQsIDEpOw0KPiAgICBjbG9jayA9ICh1aW50NjRfdClSUkVHMzJfU09DMTUoR0MsIDAs
IG1tUkxDX0dQVV9DTE9DS19DT1VOVF9MU0IpIHwNCj4gICAgICAgICgodWludDY0X3QpUlJFRzMy
X1NPQzE1KEdDLCAwLCBtbVJMQ19HUFVfQ0xPQ0tfQ09VTlRfTVNCKSA8PCAzMlVMTCk7DQo+ICAg
IG11dGV4X3VubG9jaygmYWRldi0+Z2Z4LmdwdV9jbG9ja19tdXRleCk7DQo+ICsgICAgYW1kZ3B1
X2dmeF9vZmZfY3RybChhZGV2LCB0cnVlKTsNCj4gICAgcmV0dXJuIGNsb2NrOw0KPiB9DQo+IA0K
PiAtLSANCj4gMi4yNC4xDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFu
JTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NYaWFvamllLll1YW4lNDBh
bWQuY29tJTdDMTRjMTdhYmYyNjQ5NDNlODVmYWYwOGQ3YWZjMmY4MGUlN0MzZGQ4OTYxZmU0ODg0
ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTcxMTI0MjMyNDQxNTA2JmFtcDtzZGF0
YT1YejROJTJGRGM4RXhYTUlWOVBLJTJGTUdHNDh2SHNiNiUyRnJ6dm1yVXpYZXIlMkY1RW8lM0Qm
YW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
