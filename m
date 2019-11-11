Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E11C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 03:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E0220656
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 03:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E0220656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A1A6E82D;
	Mon, 11 Nov 2019 03:06:48 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820048.outbound.protection.outlook.com [40.107.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D49E6E82D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 03:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwXAsiIIDp5Fe5FHmtpSkFbpdcTWeflmdltHpuZvFsQl0w3nD7iDhU2EReELcMTiKQbFTkv7QquDDT5G8Zy2OqSGC2CtMAdbvoKlLBBbZskXxzJECg5u3LQ4rrOBKLiHbt0QxyKfP8klvpiG4Bwbkh17uMAIBxtbCwp4beJoZWd3r7PNgEvTSffmMVSyS63Et5AKMtRGNjND5AR8xUCGclwK1jvITMJyyefkI9vP1rwtwytLM5rPO+AccUGMNtRmxrhqCKB0YFqR7YQllZoiYcvhWgVfvTuI61l/kLEbmqLAOBlDX27CKA5Fdcr/pOtrmdHsz6T+rBCr7KNSwJG8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGmVDt2/mkDY/9qduo5TylgalGMeCXcdVwVb0Np+QSM=;
 b=JwYfEm6mD7E5Sep8iz20Wog0pXwO8Wv0oiT3HbShdZIhmkiUlJeT/0ncDkmPeCrVFbrGP8PduYnu7FBgofANKGoQJqQw7JojfD0YWuO6tTINLF4/EPlA5y/B1mSpyhCtwuNZ1/R4sLqeFltOYQwVQeXfRCJ8DikbwzA2CPiAitgt4gu/hpvd587t7Ifnh7m+ab2fwT01K07RmOx6nR3AwHR31kgUizimtx80nFrKU/SMAwal2LzDza+60RvukvU4hIlI8rpGkU+Df/BZCGy9LhkZoe/2ep8OD7ClsabK249FkQVTSsKz/kmpJKCdxkptpn3RxV6aTPDVcQaWckjm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3069.namprd12.prod.outlook.com (20.178.241.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 03:06:43 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 03:06:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay/smu7: fix AVFS handling with custom
 powerplay table
Thread-Topic: [PATCH] drm/amdgpu/powerplay/smu7: fix AVFS handling with custom
 powerplay table
Thread-Index: AQHVllAgAXn4oPHiAEi2u6OxrBx/kaeFTV3Q
Date: Mon, 11 Nov 2019 03:06:43 +0000
Message-ID:
 <MN2PR12MB3344F8D02275470C896F288CE4740@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191108161759.2130602-1-alexander.deucher@amd.com>
In-Reply-To: <20191108161759.2130602-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87397075-656c-4cd3-5ed2-08d766542e40
x-ms-traffictypediagnostic: MN2PR12MB3069:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3069F085E7DB3C90BE11974EE4740@MN2PR12MB3069.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(13464003)(7736002)(76176011)(14454004)(305945005)(966005)(2906002)(74316002)(25786009)(81166006)(81156014)(8676002)(86362001)(229853002)(7696005)(476003)(486006)(11346002)(446003)(33656002)(8936002)(9686003)(6506007)(6246003)(316002)(6306002)(53546011)(110136005)(26005)(99286004)(66556008)(66476007)(66946007)(66446008)(64756008)(4326008)(55016002)(71190400001)(71200400001)(66066001)(6436002)(2501003)(6116002)(3846002)(478600001)(14444005)(186003)(256004)(52536014)(5660300002)(76116006)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3069;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQY8X+Qvu/jb49zJjSv446hut9G3d3YeRuFhASNMF1mxcKwiEY+Bi84/yL0P0NPIrtYdkG+XjGFoLfMRwSmtJi6cIGJpEdax6xiOgnqTq7QnIgbYzjRQAbq/gmqbCzrzU/MPCkbbSW/ja+xJ39Pwl1XLi7lE1baD91+yQlNZR7QKdlIfn5EymJOXCDchTDknXe+H9b0GTXZCIqUrKrdaIsaq8lWqJ/zLuHp7wHxU/8KZAHbp2oFHLUp0T7qukxMrD8Kyir3P9uL2/VPYDArBVXZw/xAUd3vBga/a6JJEhtYH+DNR4cdhTU9WqD7xN+6ymZhPodl6fgflaPxlAmgLGODlgnkqQF0YyZhzX0gghMy2gKv8PGeTGxe+Eap3so2TYeu3SfgWm4QHDDEZQnBjxOKUEFn4n+0UY9qvAcQnECzClnQeTdYU2aZB7jeBvQn5c1dXvyxwlg0n5KjsD7MBK57wU1q+abRtUXwR9Y+J98U=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87397075-656c-4cd3-5ed2-08d766542e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 03:06:43.3102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9JUv/z7oOgJCT+o3JHSc8M9eBxu4USJxqogsDgrwyy7YAnNzY5WCupJXaODzJht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGmVDt2/mkDY/9qduo5TylgalGMeCXcdVwVb0Np+QSM=;
 b=PqshGW6aQX0iJOsS66si6v1zYpR5jPx7vvBNvhhmk/+qwiQNxqKwbmes371PPtwLq75sn5tOrupAnRYRqz86AfSn7KaVUWtf05eXaqwzgeD4KgXH1FH/8CLsdJ3FydDM7QrBYIFLGHhRZcAD+26YhUeaa8hSFFcp43DJDgiCX78=
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
Message-ID: <20191111030643.8RdXrtZIruiZqeN_8wO-eEMX47ZiDa5eBvVgpaA10Ds@z>

UmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBT
YXR1cmRheSwgTm92ZW1iZXIgOSwgMjAxOSAxMjoxOCBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1L3Bvd2VycGxheS9zbXU3
OiBmaXggQVZGUyBoYW5kbGluZyB3aXRoIGN1c3RvbQ0KPiBwb3dlcnBsYXkgdGFibGUNCj4gDQo+
IFdoZW4gYSBjdXN0b20gcG93ZXJwbGF5IHRhYmxlIGlzIHByb3ZpZGVkLCB3ZSBuZWVkIHRvIHVw
ZGF0ZSB0aGUgT0QgVkREQw0KPiBmbGFnIHRvIGF2b2lkIEFWRlMgYmVpbmcgZW5hYmxlZCB3aGVu
IGl0IHNob3VsZG4ndCBiZS4NCj4gDQo+IEJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3Jn
L3Nob3dfYnVnLmNnaT9pZD0yMDUzOTMNCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYyB8IDcgKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYw0KPiBpbmRleCBjODA1YzZmY2RiYTIuLjM5MGU3
NTI0YmVmNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdt
Z3Ivc211N19od21nci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3
bWdyL3NtdTdfaHdtZ3IuYw0KPiBAQCAtMzk2OSw2ICszOTY5LDEzIEBAIHN0YXRpYyBpbnQgc211
N19zZXRfcG93ZXJfc3RhdGVfdGFza3Moc3RydWN0DQo+IHBwX2h3bWdyICpod21nciwgY29uc3Qg
dm9pZCAqaW5wdXQpDQo+ICAJCQkiRmFpbGVkIHRvIHBvcHVsYXRlIGFuZCB1cGxvYWQgU0NMSyBN
Q0xLIERQTQ0KPiBsZXZlbHMhIiwNCj4gIAkJCXJlc3VsdCA9IHRtcF9yZXN1bHQpOw0KPiANCj4g
KwkvKg0KPiArCSAqIElmIGEgY3VzdG9tIHBwIHRhYmxlIGlzIGxvYWRlZCwgc2V0IERQTVRBQkxF
X09EX1VQREFURV9WRERDDQo+IGZsYWcuDQo+ICsJICogVGhhdCBlZmZlY3RpdmVseSBkaXNhYmxl
cyBBVkZTIGZlYXR1cmUuDQo+ICsJICovDQo+ICsJaWYgKGh3bWdyLT5oYXJkY29kZV9wcF90YWJs
ZSAhPSBOVUxMKQ0KPiArCQlkYXRhLT5uZWVkX3VwZGF0ZV9zbXU3X2RwbV90YWJsZSB8PQ0KPiBE
UE1UQUJMRV9PRF9VUERBVEVfVkREQzsNCj4gKw0KPiAgCXRtcF9yZXN1bHQgPSBzbXU3X3VwZGF0
ZV9hdmZzKGh3bWdyKTsNCj4gIAlQUF9BU1NFUlRfV0lUSF9DT0RFKCgwID09IHRtcF9yZXN1bHQp
LA0KPiAgCQkJIkZhaWxlZCB0byB1cGRhdGUgYXZmcyB2b2x0YWdlcyEiLA0KPiAtLQ0KPiAyLjIz
LjANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
