Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B75CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 15:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84F720874
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 15:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84F720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762006ECE2;
	Wed, 30 Oct 2019 15:05:33 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AF06EA66
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 15:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAZ7nQFfyBr/feVPFzqnKkUqxPsHvdhOgdYh0e6q+OfbYJRItsYMZkmmAlUraLxzY7bwgruu233mu/+LKB53biZiiypgvph6ESH3YpT8eugax60d3glT0kovFmLJlfA9QzRv/5RQHJbIMCWyfdTuaSSkIGmiWHvbPk9WxYT5/JNOPd08jeSnadkeduJxHxjcaWFkyLjp4P6FXCL6WI2QLjF1EQQHuO1fWEmL91ip0TGqu19Apl2JAcfoy8k/ugpnuY9Sff1pKyk0ZiP10jGNdAsbdfHYGg6DOKnerLXuF+YRIUckz7lrvMZUlnFj1b10bKaZ7bE2bZkEiKJyn1bJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTAVMRHE6Q44hASojj+rp5ZM17rgnytpsnmh35Q0LBw=;
 b=SK9QIGC8uMN8KUylX7DUKjvTroJZENCrtm1eZ6StnkpRI66bIECbZDZTTVWjwX3VWJcNb6/bQZA9e4Xv0gJahdaIFEYBARG9i7+CF0Jtsfwp8wROjHQ+2q/+LcHBsidgv34BZh3M8G/qoKNdCMqEsm37iGbc6VZWW4a+eLgizgtqm/aycFBpsXF+9hEFIXeYQ4E3lPxc8DkXJZKraUXZ9u3ciOtfpu4JYMXjt3PxAAuphFh2TT1p9D4NSQSL7Zpt3AqivR47NLp17vASOvFB8RaPU5hGpQYxNLv7f+dD/e8+4Dy2Us4NxsuquGhMnPDCZbTz+Cf69Nd0ywvV0AO1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1837.namprd12.prod.outlook.com (10.175.55.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Wed, 30 Oct 2019 15:05:27 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d%4]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 15:05:27 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "S, Shirish"
 <Shirish.S@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Thread-Topic: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Thread-Index: AQHVilnzZQjKfUg1H0yk/qIOzcWqzadpoAIAgAABf4CAAFpggIABEdoAgAAA2QCAAAgngIAAAQcAgAAkQ4CAAEkwAIAAAV0AgAdhNwCAACFhAIAARPGAgAABrgCAAAEcAIAAAVGA
Date: Wed, 30 Oct 2019 15:05:27 +0000
Message-ID: <4664369b-65bb-fb43-3d52-bdb03fc47478@amd.com>
References: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
 <23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com>
 <f3be329d-d350-c821-00b7-d94858335796@amd.com>
 <d573688c-0997-1928-0c56-b60a29ff7fde@gmail.com>
 <b5e99dc3-5658-7e48-63f7-bf9533f582f8@amd.com>
 <2505c476-9e10-f70e-355c-33765a37d607@amd.com>
 <a1c31f37-128f-51b1-f747-fe75d78d4214@amd.com>
 <a9789f76-3ba5-ad71-1507-5eac6f589b82@amd.com>
 <971115b1-6208-1dd5-d99f-c9377663a80b@amd.com>
 <2e2ebf73-9a25-5ad2-78e7-07c8b1db1b37@amd.com>
 <08e3c44f-5d08-d5f5-bc76-ea9b77032e5a@amd.com>
 <1e1d0b06-75ab-160c-a6c7-baede02f1e7d@amd.com>
 <f5b7aeff-c4ce-fa2f-1390-e8892fa7a964@amd.com>
 <d73c46e2-ed85-f56e-3a2a-cbf2919d0a3f@gmail.com>
 <d881fbbe-5fb1-ea68-6490-d08d81c865dd@amd.com>
 <90eb8377-82c4-968a-82f0-1409f69c17e5@amd.com>
In-Reply-To: <90eb8377-82c4-968a-82f0-1409f69c17e5@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6f730d9-3643-4243-a393-08d75d4a9901
x-ms-traffictypediagnostic: MWHPR12MB1837:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1837BAC36178609AF750B341EA600@MWHPR12MB1837.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(6506007)(5660300002)(6246003)(86362001)(31696002)(3846002)(186003)(6116002)(14454004)(71200400001)(71190400001)(386003)(4326008)(102836004)(53546011)(66066001)(26005)(6636002)(478600001)(966005)(6512007)(52116002)(66446008)(64756008)(66556008)(6436002)(66946007)(36756003)(76176011)(316002)(81156014)(229853002)(81166006)(6306002)(476003)(256004)(110136005)(305945005)(66574012)(2906002)(8676002)(7736002)(486006)(11346002)(446003)(31686004)(99286004)(25786009)(8936002)(2616005)(14444005)(6486002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1837;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjwMQO7Kuly77YvhFzDr5BwkRMcJQAEDhVwwsEE0d/5mTYZ8aC+MDmJWrV/t+DN/Tc5E6pllwk6eyUPR03wyOYI1DY3Hr7MxGtoHVH7GYDNBMSRXTgiemBAMI6kpzaHZFVa/TSyfDs29jlYE+42LSLvqh6hDveBMmuwU2ik8KnnvRekAG2Ae6IubRLqr7xpwuBdapcJLgovMLn95uX4IdcF6ABjSOR5E/1zgtwFmkCEw/9zFtk4HeyS2OAsIh4fCoa9K4XGLBP88LnBoaRcuz/1VsN67MpZnwoCOW3XEVJUM1QffxCVocqWA77jdQ9trlBXAowhVJ+ijsRnhndIV3imipAy6ED1I/VgtIEDxcTcKK//p8EWOpFZYmcosrqeT50pbhBw2gvQRewfxZF8oCUBa/RGhda7KeIIvITBiG6qAs+BBUwT8Mks1qsaJYRxsno0DuhKlJNBXu0myhjBKyuW4q9PYQ+kzm3Rpv5TaNxQ=
Content-ID: <F23CEA585ADD2542B2EC43B0E467EF7E@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f730d9-3643-4243-a393-08d75d4a9901
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 15:05:27.4857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ey9wieYOyBT9FPtcvs90BMNyGLtiE5JJR3QbTPbLLFpfF7j1V9KSciHok2AxaFJV/+RERSgglbEA/hx7ULoEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1837
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTAVMRHE6Q44hASojj+rp5ZM17rgnytpsnmh35Q0LBw=;
 b=05M1MNFILR8nl+xjjK79ozVdGBDRlA85u5L14/apoUEm+kOdpVqzgzgIPyBWrReY/MpeTO6K4Nm4Ho639J8ZgFEa9l/THDRuFtocmirj8uRbxAb3j0oMq01Icau/lIATXrBIm6uaRbE2kHo6/dIkTISw3Rr910YNeFTlhxoaF2M=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030150527.h3ElC-drzAA914tGRiOHVZZZVYaTriXs_P0U3iSXHa0@z>

SSBzZWUuDQoNCk9LLCBJIHdpbGwgYWRkIHRvIG15c2VsZiBhIFRPRE8gYWJvdXQgc3RydWN0IGNv
bXBsZXRpb24gYXBwcm9hY2guDQoNCkFuZHJleQ0KDQpPbiAxMC8zMC8xOSAxMTowMCBBTSwgS29l
bmlnLCBDaHJpc3RpYW4gd3JvdGU6DQo+IFllYWgsIGFuZCBleGFjdGx5IHRoYXQncyB0aGUgcHJv
YmxlbSA6KSBZb3UgbmVlZCBhIGdsb2JhbCBsb2NrIGNvdmVyaW5nDQo+IGFsbCBzY2hlZHVsZXJz
Lg0KPg0KPiBPdGhlcndpc2UgeW91IGVuZCB1cCBpbiBoZWxsJ3Mga2l0Y2hlbiBhZ2FpbiB3aXRo
IHRha2luZyBhbGwgdGhvc2UgbG9ja3MNCj4gaW4gdGhlIHJpZ2h0IG9yZGVyLg0KPg0KPiBDaHJp
c3RpYW4uDQo+DQo+IEFtIDMwLjEwLjE5IHVtIDE1OjU2IHNjaHJpZWIgR3JvZHpvdnNreSwgQW5k
cmV5Og0KPj4gQ2FuIHlvdSBlbGFib3JhdGUgb24gd2hhdCBpcyB0aGUgdHJpY2t5IHBhcnQgd2l0
aCB0aGUgbG9jayA/IEkgYXNzdW1lZA0KPj4gd2UganVzdCB1c2UgcGVyIHNjaGVkdWxlciBsb2Nr
Lg0KPj4NCj4+IEFuZHJleQ0KPj4NCj4+IE9uIDEwLzMwLzE5IDEwOjUwIEFNLCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOg0KPj4+IEEgbG9jayBpbnNpZGUgdGhlIHNjaGVkdWxlciBpcyByYXRoZXIg
dHJpY2t5IHRvIGltcGxlbWVudC4NCj4+Pg0KPj4+IFdoYXQgeW91IG5lZWQgdG8gZG8gaXMgdG8g
Z2V0IHJpZCBvZiB0aGUgcGFyaygpL3VucGFyaygpIGhhY2sgaW4NCj4+PiBkcm1fc2NoZWRfZW50
aXR5X2ZpbmkoKS4NCj4+Pg0KPj4+IFdlIGNvdWxkIGRvIHRoaXMgd2l0aCBhIHN0cnVjdCBjb21w
bGV0aW9uIG9yIGNvbnZlcnQgdGhlIHNjaGVkdWxlcg0KPj4+IGZyb20gYSB0aHJlYWQgdG8gYSB3
b3JrIGl0ZW0uDQo+Pj4NCj4+PiBSZWdhcmRzLA0KPj4+IENocmlzdGlhbi4NCj4+Pg0KPj4+IEFt
IDMwLjEwLjE5IHVtIDE1OjQ0IHNjaHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Og0KPj4+PiBUaGF0
IGdvb2TCoCBhcyBwcm9vZiBvZiBSQ0EgYnV0IEkgc3RpbGwgdGhpbmsgd2Ugc2hvdWxkIGdyYWIg
YSBkZWRpY2F0ZWQNCj4+Pj4gbG9jayBpbnNpZGUgc2NoZWR1bGVyIHNpbmNlIHRoZSByYWNlIGlz
IGludGVybmFsIHRvIHNjaGVkdWxlciBjb2RlIHNvDQo+Pj4+IHRoaXMgYmV0dGVyIHRvIGhhbmRs
ZSBpdCBpbnNpZGUgdGhlIHNjaGVkdWxlciBjb2RlIHRvIG1ha2UgdGhlIGZpeCBhcHBseQ0KPj4+
PiBmb3IgYWxsIGRyaXZlcnMgdXNpbmcgaXQuDQo+Pj4+DQo+Pj4+IEFuZHJleQ0KPj4+Pg0KPj4+
PiBPbiAxMC8zMC8xOSA0OjQ0IEFNLCBTLCBTaGlyaXNoIHdyb3RlOg0KPj4+Pj4+Pj4gV2Ugc3Rp
bGwgaGF2ZSBpdCBhbmQgaXNuJ3QgZG9pbmcga3RocmVhZF9wYXJrKCkvdW5wYXJrKCkgZnJvbQ0K
Pj4+Pj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9maW5pIHdoaWxlIEdQVSByZXNldCBpbiBwcm9ncmVz
cyBkZWZlYXRzIGFsbCB0aGUNCj4+Pj4+Pj4+IHB1cnBvc2Ugb2YgZHJtX3NjaGVkX3N0b3AtPmt0
aHJlYWRfcGFyayA/IElmDQo+Pj4+Pj4+PiBkcm1fc2NoZWRfZW50aXR5X2ZpbmktPiBrdGhyZWFk
X3VucGFyayBoYXBwZW5zIEFGVEVSDQo+Pj4+Pj4+PiBkcm1fc2NoZWRfc3RvcC0+a3RocmVhZF9w
YXJrIG5vdGhpbmcgcHJldmVudHMgZnJvbSBhbm90aGVyICh0aGlyZCkNCj4+Pj4+Pj4+IHRocmVh
ZCBrZWVwIHN1Ym1pdHRpbmcgam9iIHRvIEhXIHdoaWNoIHdpbGwgYmUgcGlja2VkIHVwIGJ5IHRo
ZQ0KPj4+Pj4+Pj4gdW5wYXJrZWQgc2NoZWR1bGVyIHRocmVhZCB0cnkgdG8gc3VibWl0IHRvIEhX
IGJ1dCBmYWlsIGJlY2F1c2UgdGhlDQo+Pj4+Pj4+PiBIVyByaW5nIGlzIGRlYWN0aXZhdGVkLg0K
Pj4+Pj4+Pj4NCj4+Pj4+Pj4+IElmIHNvIG1heWJlIHdlIHNob3VsZCBzZXJpYWxpemUgY2FsbHMg
dG8NCj4+Pj4+Pj4+IGt0aHJlYWRfcGFyay91bnBhcmsoc2NoZWQtPnRocmVhZCkgPw0KPj4+Pj4+
Pj4NCj4+Pj4+Pj4gWWVhaCwgdGhhdCB3YXMgbXkgdGhpbmtpbmcgYXMgd2VsbC4gUHJvYmFibHkg
YmVzdCB0byBqdXN0IGdyYWIgdGhlDQo+Pj4+Pj4+IHJlc2V0IGxvY2sgYmVmb3JlIGNhbGxpbmcg
ZHJtX3NjaGVkX2VudGl0eV9maW5pKCkuDQo+Pj4+Pj4gU2hpcmlzaCAtIHBsZWFzZSB0cnkgbG9j
a2luZyAmYWRldi0+bG9ja19yZXNldCBhcm91bmQgY2FsbHMgdG8NCj4+Pj4+PiBkcm1fc2NoZWRf
ZW50aXR5X2ZpbmkgYXMgQ2hyaXN0aWFuIHN1Z2dlc3RzIGFuZCBzZWUgaWYgdGhpcyBhY3R1YWxs
eQ0KPj4+Pj4+IGhlbHBzIHRoZSBpc3N1ZS4NCj4+Pj4+Pg0KPj4+Pj4gWWVzIHRoYXQgYWxzbyB3
b3Jrcy4NCj4+Pj4+DQo+Pj4+PiBSZWdhcmRzLA0KPj4+Pj4NCj4+Pj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+Pj4gYW1kLWdmeCBtYWlsaW5nIGxp
c3QNCj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+Pj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
