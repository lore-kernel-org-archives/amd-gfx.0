Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC097C5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 09:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9BD2178F
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 09:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9BD2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 605728949C;
	Wed,  6 Nov 2019 09:13:15 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740072.outbound.protection.outlook.com [40.107.74.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E108949C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 09:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+FtoWI5Q6LdIjorgTQsOvTUoWJEt+JOe6CjtnHeP/GkCBtxvcNWGGHS9RhkYly3uotAyIlH77FVtKcH3acgub1g7weLUCcEx2u//6OJTF6ri72KbHi5IacftQ9CeYEWozFbDGWalmcf66s9S4hm8RQogobptmDvLHltWCVl3HplJnigAJI6w3bvkjB1Ofz0ct/rKZLfnGGi2cXQTObLcb3oXXxw/GhE/ugEymV/ws1gbbhYHJTL1ylwECbTKR9NKzobPtcLcMt46a1cRA25F0u/FewqgTCUBqNFaA00DqTGAIKZ0Y5LskRHdI5YgGAlx8blBN7x2sU9fIvw3ENhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkDooiNaGW7FSz+eAD4W4iBltdgrotURrb8TUZNk/RY=;
 b=KYh5Fw6KDcdLl755F/Dtvhf2Cnwt2h2UWDLFEkxLVIE63Hlek7YVs0vOkxnr9yT2uMW9bGYU1nq2I7cJdPJQAYGcetPxMCSTacA3kyhxcpixdtNuoJ7AP1h14AncRYGRCV7Km1zRPsW3V8p/dz2+7YIzVvrcR+gGAVm+CEvHsW9rIMRGlDIJ5dREaZFbOjB3UffNLoibsY3N8fB/+1dleULBmOqvSN7cSEIo/uFGacbMHecByaQWsx+xVMSDLqRJE41FNegNiUjkZIKLXONL5zayVqAgcJKWFNO65mCcjcqg+j/fz4JL7iyCEYshaywVyxZI0ZsDuYPogJAUHGo1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3534.namprd12.prod.outlook.com (20.179.84.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 09:13:12 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:13:12 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Zhexi (Jesse)" <Zhexi.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: Protect backend resource when unload
 driver
Thread-Topic: [PATCH] drm/amd/powerplay: Protect backend resource when unload
 driver
Thread-Index: AQHVlGvKg40a0TmDv0au+Hvk8KGuVqd9212A
Date: Wed, 6 Nov 2019 09:13:12 +0000
Message-ID:
 <MN2PR12MB3344E5BA8192D27C0A9D61B0E4790@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1573021862-10078-1-git-send-email-zhexi.zhang@amd.com>
In-Reply-To: <1573021862-10078-1-git-send-email-zhexi.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbee919d-3bf6-4a87-9dff-08d762998c6d
x-ms-traffictypediagnostic: MN2PR12MB3534:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB353419D1BCA46622E37AE29FE4790@MN2PR12MB3534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(13464003)(14454004)(256004)(316002)(14444005)(3846002)(966005)(33656002)(478600001)(102836004)(25786009)(71200400001)(71190400001)(6436002)(6116002)(110136005)(86362001)(8936002)(305945005)(7736002)(74316002)(2501003)(52536014)(66066001)(9686003)(99286004)(476003)(6306002)(66946007)(26005)(76116006)(66476007)(66556008)(64756008)(66446008)(55016002)(8676002)(5660300002)(81166006)(81156014)(186003)(7696005)(6246003)(2906002)(486006)(446003)(6506007)(53546011)(4326008)(229853002)(76176011)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3534;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZKBYXrrDP5cWKnC6hRP2JEaWkYj0IPix6fVmHVIjVOM3Vljd67ZqeoGjAAo5/mdDadqnOEJlnARZZGChArMJHUtTwcDC2q3VzO2MHTUP4bGQ48kPNFdLFOmcl4T/frhN+tYErct5bOfogn5anlPU7dzLBVFidyoSZv/l6LCj3TObPVXf29vhfaeg6KpaxnUV/aI9ZAeRjBELF06F4swLK5d6m9v5vM4Q7tEMQP/ClJga0bX/d8vsegCcT3Z/ISeZ1ayzO/Kct0i1p3W/fMo1LUSKlwtTvKPdeJcqgo+aZe3+o/DSMnqyxx0GaTQEly8GW9MMSLfGWtM+jrJSnrl806RD1TvU04jLeHoRi84yh5k9yFBAb6i1IoNhNgCJreOZgKPYTUrAmmw0jbA/qruCEl4DnGRksZY7EJz62mgMOE0DpVI2oYEqtdfZxKCnVll7YBOFM7bXrT0XBZgQtTBI8UwEiBalNv8JL9pOc+BUFEM=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbee919d-3bf6-4a87-9dff-08d762998c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:13:12.0607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nctfv0QaeC19qB8r9ny/84x60rxjA//5JIzxqNDBH7nwD7cQHpit/0R86nyY6CQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3534
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkDooiNaGW7FSz+eAD4W4iBltdgrotURrb8TUZNk/RY=;
 b=T4/qGXeTCCp6myoa0VnVnwjrkOGuOydvod2to9SJX0QjQf/P5FsVZMigxHw2przOqlOOhqdqKc5vyL/pTra/zN3rtuII5sOpLJ5YUfLVuaHdsbX5MOGXmj8VXj7fRCZeIIa3RXz4X537CsIdrz8FtXVuaPp0nLE87g9vRKJv2BA=
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
Cc: "Zhang, Zhexi \(Jesse\)" <Zhexi.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106091312.okfyOT7RPKUrzfJxtavC6vDOifHcC5SZEz1fR0Iu0TU@z>

SSBraW5kIG9mIGZlZWxpbmcgdGhlIGNoYW5nZXMgb2YgVkNFIGFuZCBVVkQob2YgdmVnYTEwX2h3
bWdyLmMpIGFyZSBub3QgbmVlZGVkIGFzIHRoZXJlIGlzIGFscmVhZHkgbG9jayBwcm90ZWN0aW9u
IGluIHBwX2RwbV9wb3dlcmdhdGVfdXZkL3ZjZS4NCkNhbiB5b3UgaGVscCB0byBjb25maXJtIHRo
YXQ/DQoNClJlZ2FyZHMsDQpFdmFuDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJl
aGFsZiBPZiBKZXNzZQ0KPiBaaGFuZw0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDYsIDIw
MTkgMjozMSBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFpo
YW5nLCBaaGV4aSAoSmVzc2UpIDxaaGV4aS5aaGFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWQvcG93ZXJwbGF5OiBQcm90ZWN0IGJhY2tlbmQgcmVzb3VyY2Ugd2hlbiB1bmxv
YWQNCj4gZHJpdmVyDQo+IA0KPiBHdWVzdCBkcml2ZXIgY2FuIGJlIHVubG9hZGVkIHdoaWxlIGVu
Z2luZXMgc3RpbGwgdXNpbmcgc29tZSBiYWNrZW5kIHJlc291cmNlcw0KPiB3aGljaCB3aG91bGQg
bGVhZCB0byBndWVzdCBkcml2ZXIgdW5sb2FkIGZhaWx1cmUuDQo+IA0KPiBOZWVkIHRvIGFkZCBt
dXRleCBsb2NrIHRvIHByb3RlY3QgYmFja2VuZCByZXNvdXJjZXMgZnJvbSBjb25jdXJyZW50DQo+
IG9wZXJhdGlvbnMNCj4gDQo+IEJlZm9yZSBlbnRlcmluZyBwb3dlcmdhdGluZyBtb2RlLCBWQ0Ug
YW5kIFVWRCBuZWVkIHRvIGNoZWNrIGlmIGJhY2tlbmQNCj4gcmVzb3VyY2VzIGFyZSBzdGlsbCBh
dmFpbGFibGUuDQo+IA0KPiBDaGFuZ2UtSWQ6IEljYzM0ZjkzODE4NzQzODU2YzRlZmJiYmY5NDgw
ZTRkOWYyZTBkMWUxDQo+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDx6aGV4aS56aGFuZ0Bh
bWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dl
cnBsYXkuYyAgICAgIHwgNCArKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9o
d21nci92ZWdhMTBfaHdtZ3IuYyB8IDYgKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hbWRfcG93ZXJwbGF5LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9h
bWRfcG93ZXJwbGF5LmMNCj4gaW5kZXggMDMxNDQ3Ni4uYzgyNTcwYiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYw0KPiBAQCAtMTM0LDcg
KzEzNCw5IEBAIHN0YXRpYyBpbnQgcHBfaHdfZmluaSh2b2lkICpoYW5kbGUpDQo+ICAJc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBoYW5kbGU7DQo+ICAJc3RydWN0IHBwX2h3bWdyICpod21n
ciA9IGFkZXYtPnBvd2VycGxheS5wcF9oYW5kbGU7DQo+IA0KPiArCW11dGV4X2xvY2soJmh3bWdy
LT5zbXVfbG9jayk7DQo+ICAJaHdtZ3JfaHdfZmluaShod21ncik7DQo+ICsJbXV0ZXhfdW5sb2Nr
KCZod21nci0+c211X2xvY2spOw0KPiANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gQEAgLTY2Miw3
ICs2NjQsOSBAQCBzdGF0aWMgaW50IGFtZF9wb3dlcnBsYXlfcmVzZXQodm9pZCAqaGFuZGxlKQ0K
PiAgCXN0cnVjdCBwcF9od21nciAqaHdtZ3IgPSBoYW5kbGU7DQo+ICAJaW50IHJldDsNCj4gDQo+
ICsJbXV0ZXhfbG9jaygmaHdtZ3ItPnNtdV9sb2NrKTsNCj4gIAlyZXQgPSBod21ncl9od19maW5p
KGh3bWdyKTsNCj4gKwltdXRleF91bmxvY2soJmh3bWdyLT5zbXVfbG9jayk7DQo+ICAJaWYgKHJl
dCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jDQo+IGluZGV4IDQ2NTM4MjMzLi5mNzJi
YTcwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92
ZWdhMTBfaHdtZ3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21n
ci92ZWdhMTBfaHdtZ3IuYw0KPiBAQCAtNDYxNiw2ICs0NjE2LDkgQEAgc3RhdGljIHZvaWQgdmVn
YTEwX3Bvd2VyX2dhdGVfdmNlKHN0cnVjdA0KPiBwcF9od21nciAqaHdtZ3IsIGJvb2wgYmdhdGUp
DQo+ICB7DQo+ICAJc3RydWN0IHZlZ2ExMF9od21nciAqZGF0YSA9IGh3bWdyLT5iYWNrZW5kOw0K
PiANCj4gKwlpZiAoIWRhdGEpDQo+ICsJCXJldHVybjsNCj4gKw0KPiAgCWRhdGEtPnZjZV9wb3dl
cl9nYXRlZCA9IGJnYXRlOw0KPiAgCXZlZ2ExMF9lbmFibGVfZGlzYWJsZV92Y2VfZHBtKGh3bWdy
LCAhYmdhdGUpOw0KPiAgfQ0KPiBAQCAtNDYyNCw2ICs0NjI3LDkgQEAgc3RhdGljIHZvaWQgdmVn
YTEwX3Bvd2VyX2dhdGVfdXZkKHN0cnVjdA0KPiBwcF9od21nciAqaHdtZ3IsIGJvb2wgYmdhdGUp
DQo+ICB7DQo+ICAJc3RydWN0IHZlZ2ExMF9od21nciAqZGF0YSA9IGh3bWdyLT5iYWNrZW5kOw0K
PiANCj4gKwlpZiAoIWRhdGEpDQo+ICsJCXJldHVybjsNCj4gKw0KPiAgCWRhdGEtPnV2ZF9wb3dl
cl9nYXRlZCA9IGJnYXRlOw0KPiAgCXZlZ2ExMF9lbmFibGVfZGlzYWJsZV91dmRfZHBtKGh3bWdy
LCAhYmdhdGUpOw0KPiAgfQ0KPiAtLQ0KPiAyLjcuNA0KPiANCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4g
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
