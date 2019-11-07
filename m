Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A594C5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 14:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2402084C
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 14:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2402084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82676EB3B;
	Thu,  7 Nov 2019 14:05:16 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820059.outbound.protection.outlook.com [40.107.82.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C666EB3B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 14:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLO2SJsWOKo9KCDWj5GV18IVy4Fsxgqf5adth6lbtA7Sq0Aj5ic0hqPX2gZeNZEgUgsolamKy6BLI0NoARVogN1tLA9z2NCIDbZkgYC2YOEYzRO1J6vYheUY6x3NCV/tyAAoFzsXxgzbZwb9BsX2IecqnFUSCWIIlWANDWEE4McmboxMUSScV0S1mjWI4gs74v7JGRox0z8F8iSTYyOlOoIiYa5TWI4b9TDdkCkxCtlqEJBkHvG6p8VD1znbtYe6hp4uhNyuKxY+p5/Py9duYj0CL8BIum2B9x1uNHVwVo68bgwvzT196tZHkfivycQnR3dm/YBriEE5Ay3gNuw8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ+Vnzf7La65KqV9gyoi5Ga7GnNfFgCtzQw6jejeWl0=;
 b=WLVYKL3KFoVfVdwApKXgiRc0DlymCTWni1sKF2DQo8ZdEESLblQlOl6NMRbEMSICakeJjg97gVmg3ZpWeQnvYGcAu1Akb+Zkw6eVMUw2HbIdRQw28UCDrNhNWHuwDd/nLaZ6arY8Iiqg8CYTP4nqnVBjFtW8uxl4AFMn4yh2ltWOsohddVpbQV7gsLvsjbg5lzMXdhBs61fGiqC3m9Xcze1Jj70aC/IPIsTkxWCPl8JBtPewv+/ogTGqPopmwj4hcc0QBmj07LSlbkWazPEPamzgxbCmVg4Gu7mI8AARobqU9M4/qPRv3X8tXZK5wlwH7tdNXjKEM9NHjGFe+1Qmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB2533.namprd12.prod.outlook.com (10.172.120.151) by
 CY4PR1201MB2519.namprd12.prod.outlook.com (10.172.119.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Thu, 7 Nov 2019 14:05:14 +0000
Received: from CY4PR1201MB2533.namprd12.prod.outlook.com
 ([fe80::7d54:3475:ff9b:694b]) by CY4PR1201MB2533.namprd12.prod.outlook.com
 ([fe80::7d54:3475:ff9b:694b%10]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 14:05:13 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: correct Arcturus OD support
Thread-Topic: [PATCH] drm/amd/powerplay: correct Arcturus OD support
Thread-Index: AQHVlT5hNY9IZRK/5EmJYYXhGvPRMKd/vCeAgAABQxA=
Date: Thu, 7 Nov 2019 14:05:13 +0000
Message-ID:
 <CY4PR1201MB2533B1569C97729EA15C8B8085780@CY4PR1201MB2533.namprd12.prod.outlook.com>
References: <20191107073817.27624-1-evan.quan@amd.com>
 <CADnq5_PxWYGE1-uL+pey-Rwj6EiP2EuO+Y4N7aYNL85P3QOeUw@mail.gmail.com>
In-Reply-To: <CADnq5_PxWYGE1-uL+pey-Rwj6EiP2EuO+Y4N7aYNL85P3QOeUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2607:fea8:1c80:d46:25:1c12:1491:5915]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9233ee3e-1e4a-4628-a96e-08d7638b82a0
x-ms-traffictypediagnostic: CY4PR1201MB2519:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB25190E56564349DD33027EFD85780@CY4PR1201MB2519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(13464003)(199004)(189003)(6506007)(186003)(53546011)(76176011)(256004)(446003)(46003)(14444005)(2906002)(102836004)(6116002)(316002)(54906003)(11346002)(110136005)(25786009)(14454004)(476003)(966005)(86362001)(6436002)(4326008)(6636002)(8676002)(6246003)(99286004)(66556008)(7696005)(486006)(8936002)(478600001)(76116006)(66446008)(64756008)(55016002)(66946007)(66476007)(81166006)(7736002)(229853002)(74316002)(6306002)(9686003)(305945005)(81156014)(5660300002)(52536014)(33656002)(71190400001)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2519;
 H:CY4PR1201MB2533.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uIlJEszlC5PHsSdOvRM5ho/1Hp/LwgLf5OvFDQz21eAK2nfqEH003Ya7AqgbkiBag/bultMwE6Y/9Gtg+PGHId+UECGnt01qsAOLk5ydz3ZJMVgafGayYEmr+knapnLzJGIeaEC4NTRnPG1wV/3RU46BeZ2qMcIbx0cG9XaezTwWliRnjldgjLTaraBhpFYE/eNQ3t4VFX8Kdcb1PK3dHVjgd1cRmL9+bBycxVr28ekl2+zG1kU911oPOEFRgab+7ZNG0Ms+Wm2fNgSzenkeJ0bMJpfa+4ciS1u0uKew4wXfarngYp9EQT33AcVK46aEsWde8jSMzhbfTDoWo5mvdEL8h244Y4oDEslimNcB14K/IKLyMYqwnglMNSNwcUe/ep7WoEJaClkH2fDw9G1sSPQlu9Q6i5LdP18e1hyGCzSetrVWWcl7+//iG0i5AwjnjwiagmNrI6GXDN77x9mXFga4/6W3fEycP0BcmYCSbo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9233ee3e-1e4a-4628-a96e-08d7638b82a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 14:05:13.7606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHaFRCcgund2zsgu4UdubyaLkwD4MeokvhvzNuF+hxYBErYH/bqfMDes0gG3aoTd9fFbZsgLwpoYTrVKN0xtJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ+Vnzf7La65KqV9gyoi5Ga7GnNfFgCtzQw6jejeWl0=;
 b=MgC6dr5CewS/w6n5yJSAdphcFc90rNWn6DbKZj3uJ2KU7ea7jl/HkneKQCXiE2wwmCzEEy8Za7VjyD0acUrEaG7rkIDAeBKECsPJfid3QFWJ6gv0YP3iPzWhScitFeE+PCH3PH9bRhg2jP1F62IUh1cBbGwYNfN4XElosanLZsw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
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
Cc: "Li, Candice" <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Freehill,
 Chris" <Chris.Freehill@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107140513.r-oyb6fFKt1Q9XgR9T34-SjyKN2K_BnWfW7nggeKn20@z>

V2hpbGUgd2UgZG8gbGlrZSBPdmVyRHJpdmUgYmVpbmcgYXZhaWxhYmxlIChtb3N0bHkgb3VyIG9w
ZW4tc291cmNlIGNvbW11bml0eSB1c2VycyB3aG8gYXJlIHVzaW5nIGNvbnN1bWVyIGNhcmRzIHZz
IHNlcnZlciBjYXJkcyksIGlmIGl0J3Mgbm90IHN1cHBvcnRlZCBvbiB0aGUgSFcgZm9yIHdoYXRl
dmVyIHJlYXNvbiwgd2UnbGwgYWRhcHQuIElmIHdlIGdldCBhIHJlcXVlc3QgbGF0ZXIgZm9yIGl0
cyBlbmFibGVtZW50IChzaW5jZSBPdmVyRHJpdmUgaXMgY29uc3VtZXItY2FyZC1vbmx5IGluIGdl
bmVyYWwsIGFuZCBJIHBlcnNvbmFsbHkgaGF2ZW4ndCBzZWVuIGFueSBBcmN0dXJ1cyBjb25zdW1l
ciBjYXJkcyksIHdlIGNhbiBkaXNjdXNzIHRoZW4uIEl0J3MgZmluZSB3aXRoIENocmlzIGFuZCBJ
IGluIHRoYXQgcmVnYXJkLg0KDQogS2VudA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24g
QmVoYWxmIE9mIEFsZXggRGV1Y2hlcg0KU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDcsIDIwMTkg
ODo1OCBBTQ0KVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KQ2M6IExpLCBDYW5k
aWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsg
RnJlZWhpbGwsIENocmlzIDxDaHJpcy5GcmVlaGlsbEBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZC9wb3dlcnBsYXk6IGNvcnJlY3QgQXJjdHVydXMgT0Qgc3VwcG9ydA0KDQpP
biBUaHUsIE5vdiA3LCAyMDE5IGF0IDI6MzggQU0gUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5j
b20+IHdyb3RlOg0KPg0KPiBPRCBpcyBub3Qgc3VwcG9ydGVkIG9uIEFyY3R1cnVzLiBUaHVzIHRo
ZSBwcF9vZF9jbGtfdm9sdGFnZSBzeXNmcyANCj4gaW50ZXJmYWNlIGlzIGFsc28gbm90IHN1cHBv
cnRlZC4NCj4NCj4gQ2hhbmdlLUlkOiBJYjcwNjMyYTU1YTA5ODBjZjA0YzM0MzJkNDNkYmNmODY5
Y2QxYjRiZg0KPiBTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0K
DQpZb3UgbWlnaHQgd2FudCB0byBjaGVjayB3aXRoIENocmlzIGFuZCBLZW50IGFib3V0IHRoaXMu
ICBJIHRoaW5rIHRoZXJlIGlzIGEgdXNlIGNhc2UgZm9yIE9EIG9uIFJPQ20gaW4gc29tZSBjYXNl
cy4gIEFzc3VtaW5nIHRoZXkgYXJlIG9rIHdpdGggaXQsDQpSZXZpZXdlZC1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQpBbGV4DQoNCj4gLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgfCA4ICsrKysrLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIA0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KPiBpbmRleCBjMjFm
ZTdhYzVkZjguLjc2YTQxNTRiM2JlMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2FtZGdwdV9zbXUuYw0KPiBAQCAtNzE0LDYgKzcxNCw5IEBAIHN0YXRpYyBpbnQgc211
X3NldF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSANCj4gKmFkZXYpICB7DQo+ICAgICAgICAg
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUgPSAmYWRldi0+c211Ow0KPg0KPiArICAgICAgIGlmIChh
ZGV2LT5wbS5wcF9mZWF0dXJlICYgUFBfT1ZFUkRSSVZFX01BU0spDQo+ICsgICAgICAgICAgICAg
ICBzbXUtPm9kX2VuYWJsZWQgPSB0cnVlOw0KPiArDQo+ICAgICAgICAgc3dpdGNoIChhZGV2LT5h
c2ljX3R5cGUpIHsNCj4gICAgICAgICBjYXNlIENISVBfVkVHQTIwOg0KPiAgICAgICAgICAgICAg
ICAgdmVnYTIwX3NldF9wcHRfZnVuY3Moc211KTsgQEAgLTcyNSw2ICs3MjgsOCBAQCBzdGF0aWMg
DQo+IGludCBzbXVfc2V0X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgY2FzZSBDSElQX0FSQ1RVUlVTOg0KPiAgICAg
ICAgICAgICAgICAgYXJjdHVydXNfc2V0X3BwdF9mdW5jcyhzbXUpOw0KPiArICAgICAgICAgICAg
ICAgLyogT0QgaXMgbm90IHN1cHBvcnRlZCBvbiBBcmN0dXJ1cyAqLw0KPiArICAgICAgICAgICAg
ICAgc211LT5vZF9lbmFibGVkID1mYWxzZTsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAg
ICAgICAgIGNhc2UgQ0hJUF9SRU5PSVI6DQo+ICAgICAgICAgICAgICAgICByZW5vaXJfc2V0X3Bw
dF9mdW5jcyhzbXUpOyBAQCAtNzMzLDkgKzczOCw2IEBAIHN0YXRpYyANCj4gaW50IHNtdV9zZXRf
ZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gICAgICAgICB9DQo+DQo+IC0gICAgICAgaWYgKGFkZXYtPnBtLnBwX2Zl
YXR1cmUgJiBQUF9PVkVSRFJJVkVfTUFTSykNCj4gLSAgICAgICAgICAgICAgIHNtdS0+b2RfZW5h
YmxlZCA9IHRydWU7DQo+IC0NCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4NCj4gLS0NCj4g
Mi4yMy4wDQo+DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFt
ZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
