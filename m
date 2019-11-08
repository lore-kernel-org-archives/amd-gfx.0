Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485E5C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 02:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131032087E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 02:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131032087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA3C86E566;
	Fri,  8 Nov 2019 02:45:01 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740041.outbound.protection.outlook.com [40.107.74.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FB16E566
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 02:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx278bsBQjTVgRdKueFAZyO4PspUnl61pKnalQBZHPsajrktbbl9CkT9SPDyVMhgD3mW93MAQGiYl2rIouFUt9TEMlXsMQuyAF/li/j/4KQC/+jLxCW9jvrhLTarNHeiYsNA4J5psrR4ITV1gqXciPX6E6hUsLr/ZlelukocBmUwZF7TCh/eau/OzFVUj48Ic4VAy+lsQxt79W55oHZTVkTBG9u1wyceWgiBby72M2DCzARzW3jiQYX5sfMRPRK97EW6CWfOFtb8t38gszL2Z5sOlxKZdCty/fxGDXyErbGv8ALlQ46psKcUTvRNAYRqk5ruPhkUKn/S+rRJsU1PeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ/bYbrV9icQGk7XtgUpxM486v8i3/2it2rLPYSuCvY=;
 b=cYz3hG0lhGxuHSXjcmWTxPJAWw/OFFaEnQmuwQwbmJxNH0qNlkOPjzrvtS9LDiBkIqI6/EB0AslS42Xwf4vVRRFtzHL5wWAHkiVrHkCX7hVvg9rHpYQ04KBEU7ZRf9XVtrWlPt3xZ4Ik+T6gNMHoggMGr//89feaB97J9pfjigiz6WsMK0gH7C0AB7hLDcpy9iEIJjQU1pMBnj9C2dT3GPbCPTt7FcOmX3HGw9LAZUtdaDnY4MjccIfEGmOqi9wWmpNG11cqA0twGhK5rkn2QiaAwkIFT5iox4UXBNxWdoPdX6PDcTJ+hP08emOf6RvAU7qR+EQmEkS3VuTon64+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 02:44:57 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846%7]) with mapi id 15.20.2408.024; Fri, 8 Nov 2019
 02:44:57 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: correct Arcturus OD support
Thread-Topic: [PATCH] drm/amd/powerplay: correct Arcturus OD support
Thread-Index: AQHVlT5hNY9IZRK/5EmJYYXhGvPRMKeAkn6A
Date: Fri, 8 Nov 2019 02:44:57 +0000
Message-ID:
 <MN2PR12MB3598A9236B182D2E1FCD6B2F8E7B0@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20191107073817.27624-1-evan.quan@amd.com>
In-Reply-To: <20191107073817.27624-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1f2872e-eda9-49ed-adb8-08d763f5a4b0
x-ms-traffictypediagnostic: MN2PR12MB4030:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4030317023DDAA0511F803328E7B0@MN2PR12MB4030.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(13464003)(189003)(199004)(66066001)(7736002)(6246003)(486006)(81156014)(6306002)(8936002)(102836004)(99286004)(6436002)(76176011)(33656002)(14454004)(53546011)(74316002)(186003)(305945005)(966005)(2501003)(81166006)(3846002)(71200400001)(6116002)(7696005)(2906002)(8676002)(478600001)(11346002)(55016002)(4326008)(256004)(5660300002)(476003)(9686003)(52536014)(25786009)(71190400001)(6506007)(446003)(76116006)(86362001)(66476007)(110136005)(316002)(64756008)(66446008)(229853002)(66946007)(54906003)(26005)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4030;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VMCitvWyKTzbGKeUCQXogC1R9tWlvMifKhJ5xN/5rzeWKTIaBbIO6XxO/DOD2f2TrhbgVYQ+N0JiZrPG7dAcdDAOMVPgxoQkc1Hx6xtxcq/tfGPFbeVGAENG3S9DIiw2iSZ7mhVkM8JKyw6be7dpPwDIhlhjLdMQr2fgmwAJtzZaXNwVgV10MQLOoG9HsdSdHvnbQbetnux41QVMFuVnqXGzY96YU6UmJnY+Uxkzn30MZJhdtdYl3S9x1RvzDYVzaCyzE/FcJlASi+7Nr7G+Frr7cMNAFBxX9lbG1NuFQupUF4KTu/oL9gJdiM4Mk7QewhtM6aXRsO/a10UlQVLU5+nH217mKzCRoh+Ser1XUX7MQbwTRZg91mdv/WO+XAB+H6o00zA2lecrl7WHw8TGajluhdl8L6CEGGDoFmoj3Fo4W7jo4Rd92xp49x6/GIdkMjektK+E/B/6z5Yl6LI/vUJi3YG+2nA9qUyCVE8vJck=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f2872e-eda9-49ed-adb8-08d763f5a4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 02:44:57.6294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZqZFtcQ8svN1NKd5LGK+vp2evDBfvo9yGDnBBUQNXO2CoXgc8jS+mO/+5chaXjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4030
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ/bYbrV9icQGk7XtgUpxM486v8i3/2it2rLPYSuCvY=;
 b=AVeNAyWlsEZARK4VI2ItIWPKiFD3uuVT86hHO+PEsHKQ15/thpNaCaRZrNsj1tH755DA5wkMNFkkrHY/q+64tLiJRyFpQm3xtJ7Vwnzc6+KuphI1aw7f3djcpd1QGOr8M+jXs3hIhAwDL3ratcT3X22lfV9SKsjSHQ89TDqh3Vk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Freehill, Chris" <Chris.Freehill@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108024457.TstAD9653SI3XalJw03bzzamo1p0KAlRzel7UrDzLeY@z>

UmV2aWV3ZWQtYnk6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5mZW5nQGFtZC5jb20+DQoNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBRdWFuLCBFdmFuDQpTZW50OiBUaHVy
c2RheSwgTm92ZW1iZXIgNywgMjAxOSAzOjM5IFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCkNjOiBMaSwgQ2FuZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsgUXVhbiwgRXZh
biA8RXZhbi5RdWFuQGFtZC5jb20+OyBGcmVlaGlsbCwgQ2hyaXMgPENocmlzLkZyZWVoaWxsQGFt
ZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJwbGF5OiBjb3JyZWN0IEFyY3R1
cnVzIE9EIHN1cHBvcnQNCg0KW0NBVVRJT046IEV4dGVybmFsIEVtYWlsXQ0KDQpPRCBpcyBub3Qg
c3VwcG9ydGVkIG9uIEFyY3R1cnVzLiBUaHVzIHRoZSBwcF9vZF9jbGtfdm9sdGFnZSBzeXNmcyBp
bnRlcmZhY2UgaXMgYWxzbyBub3Qgc3VwcG9ydGVkLg0KDQpDaGFuZ2UtSWQ6IEliNzA2MzJhNTVh
MDk4MGNmMDRjMzQzMmQ0M2RiY2Y4NjljZDFiNGJmDQpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4g
PGV2YW4ucXVhbkBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
YW1kZ3B1X3NtdS5jIHwgOCArKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hbWRncHVfc211LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRn
cHVfc211LmMNCmluZGV4IGMyMWZlN2FjNWRmOC4uNzZhNDE1NGIzYmUyIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCkBAIC03MTQsNiArNzE0LDkgQEAg
c3RhdGljIGludCBzbXVfc2V0X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgew0K
ICAgICAgICBzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSA9ICZhZGV2LT5zbXU7DQoNCisgICAgICAg
aWYgKGFkZXYtPnBtLnBwX2ZlYXR1cmUgJiBQUF9PVkVSRFJJVkVfTUFTSykNCisgICAgICAgICAg
ICAgICBzbXUtPm9kX2VuYWJsZWQgPSB0cnVlOw0KKw0KICAgICAgICBzd2l0Y2ggKGFkZXYtPmFz
aWNfdHlwZSkgew0KICAgICAgICBjYXNlIENISVBfVkVHQTIwOg0KICAgICAgICAgICAgICAgIHZl
Z2EyMF9zZXRfcHB0X2Z1bmNzKHNtdSk7IEBAIC03MjUsNiArNzI4LDggQEAgc3RhdGljIGludCBz
bXVfc2V0X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KICAgICAgICAgICAgICAg
IGJyZWFrOw0KICAgICAgICBjYXNlIENISVBfQVJDVFVSVVM6DQogICAgICAgICAgICAgICAgYXJj
dHVydXNfc2V0X3BwdF9mdW5jcyhzbXUpOw0KKyAgICAgICAgICAgICAgIC8qIE9EIGlzIG5vdCBz
dXBwb3J0ZWQgb24gQXJjdHVydXMgKi8NCisgICAgICAgICAgICAgICBzbXUtPm9kX2VuYWJsZWQg
PWZhbHNlOw0KICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAgICBjYXNlIENISVBfUkVOT0lS
Og0KICAgICAgICAgICAgICAgIHJlbm9pcl9zZXRfcHB0X2Z1bmNzKHNtdSk7IEBAIC03MzMsOSAr
NzM4LDYgQEAgc3RhdGljIGludCBzbXVfc2V0X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KICAgICAgICB9DQoNCi0gICAg
ICAgaWYgKGFkZXYtPnBtLnBwX2ZlYXR1cmUgJiBQUF9PVkVSRFJJVkVfTUFTSykNCi0gICAgICAg
ICAgICAgICBzbXUtPm9kX2VuYWJsZWQgPSB0cnVlOw0KLQ0KICAgICAgICByZXR1cm4gMDsNCiB9
DQoNCi0tDQoyLjIzLjANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
