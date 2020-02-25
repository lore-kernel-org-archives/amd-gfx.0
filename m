Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1118C35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 13:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C9B21744
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 13:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hTvCpdt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C9B21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6C26EAB0;
	Tue, 25 Feb 2020 13:15:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D2D6EAB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 13:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwP1sl5zZdHN2qWkTE3kPZakOIslVFw9CdtLvCFyk21as9XnXotBgxWkMFOmRXrk2jsloA1zIx60t2u8nBWQUbP6iGVtRet7UF/rqHbyKJ3LvBBvQ/RnNCVo4V04PSN/DdkfG5lp7BsQ8DibPtQeu9xOLZicTvo/07le7YQdqoYwCnyhoXTX88+OPNqeEn6pN88AMF8fP1XfD60rn16Up0zoE9C/QNkwkBNqQhjFNrY+l89eu7xNWoj0IKIj/m+aLt0wZ3vpWMJgzWZ/zUIzn35r67yCWmMCtfwt5ri21Axg4hlU746KozIHRRJ+B5KPL/YCQRzlGMFy+QRCabBGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aChNjTM7RPYd9QqK67HUi+Iw73gTWm6ZIGpjA3SMsqI=;
 b=HrepE2z8GHLcxSGKRLfhZFXRgelbshz4JbAP95XpN+HQOJgp8taAOAbPZAk+yeUbGUg8kifYmrtJzTou41tHWNSet5/9f6H/OlVL1dS8HINOC5/HxkYZZbQ+T5qRolG0k94Dl92KC8Rf3hD5UeVbNGdZY18yGXpatcUOG9QNt0SuGV38HmTughi6Obzl4IfjZyriOWCsAGVpCgQEiCJFR7tmbm9EmJJEyef1HU+OWcIT3/+8z8RT7kbAYt5ErC+iAMZW8YdpO0McE/S6BcT3PnD7nxLwtzgIwvxwVPfeatFz443/pZFU76vbx0tZ9ir2llcnML/p2NmdeRNZqhEK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aChNjTM7RPYd9QqK67HUi+Iw73gTWm6ZIGpjA3SMsqI=;
 b=hTvCpdt7Z3XFs84n0rLe12xEl0KF0dTp525iKN58WoEmlzbOHCYqgcCzgrDa1q/ITf2Ket3nThWuTZJSKY/21p9+RCChzswlngA+BdT2q+lmBZg2Y2ck5qmjC8/GoxomrvbbgKwycT766jzeBDlfgkn0SrK7wfskF6hIX22K4VM=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 13:15:52 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 13:15:52 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
Thread-Topic: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
Thread-Index: AQHV5zWrdpP3qSLVrkm/hOrGlV5afqgr5JyAgAAIX4A=
Date: Tue, 25 Feb 2020 13:15:52 +0000
Message-ID: <BDE378DB-C139-4445-8797-AF98A0B8BF46@amd.com>
References: <20200219150251.123917-1-christian.koenig@amd.com>
 <88197ba6-7497-6733-446a-6ea44486d672@gmail.com>
In-Reply-To: <88197ba6-7497-6733-446a-6ea44486d672@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [101.88.213.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b50b4450-6b10-42fb-64fe-08d7b9f4d6e2
x-ms-traffictypediagnostic: SN6PR12MB2640:|SN6PR12MB2640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB26400AC81ECBC13FB018FAD587ED0@SN6PR12MB2640.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(6916009)(4326008)(6506007)(5660300002)(81166006)(66574012)(478600001)(36756003)(8676002)(81156014)(66556008)(15650500001)(66476007)(66946007)(54906003)(2616005)(64756008)(86362001)(6512007)(26005)(33656002)(71200400001)(91956017)(186003)(8936002)(6486002)(2906002)(76116006)(316002)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2640;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u8BAapMJoQ1FRZ/VYt8d6459f5bSEgv83ACLh4qAAnP/YH50UBcmXl1TvgWQHr7NkopFJp41uaeAP492q/Llk/iqWA+P080Xs7Xw6k+VfimrmAgYDJmqMxFGKGSAilH//g5nt1ZYEPbzkXY8DDbovKDvIJnds+ou7UMhHJkE1P7pvZYwWw5xCtNQFrtIMldj7ZH1kT9NwSpH5+oz2DdOAee+kPXTZSG20JQILaC60JDbMqEadi6gChl+rh6mUiOCYPEpJbjd2xu/YxZIUt/JTj/j+gvMWwV3wZNp9NRhMUJiKDVdsSpBGAUIJsQVHGsfywlUJ53GHOegRj7EVMEGW2C8KQZ6HzGoKwMHxH74xmZNob3gCLx64p4DUgUjAZUoNWxITK7DDrEAWv4o7PPtidLUaSNaOr7jPRF4CEpLmzxTwHSBoRxyRHHABB/deIk/
x-ms-exchange-antispam-messagedata: XsTObVoRQrK6UizMmIZwaRESYFhfpH7xWwAObp7UEHxOJP2MAEtLevuJz+/HxeotKipdOdiQ0nsibL+c2YfTuGMGnbr/jzR7aA/Ty0xB7DdlC1GK8TmH2KfkjnEIHpjt/KwOPl6KpcIR0QmCL+6YeQ==
Content-ID: <AD523BE7795CE240A667148C98689CBC@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50b4450-6b10-42fb-64fe-08d7b9f4d6e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 13:15:52.2885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNS1Y0rMk4fPXXHWDoK6fdrrYFU8TuUfwuzUT+Jtj6MsKAJxVxD3JdkTa1gFq86R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4NCg0KPiAyMDIw5bm0
MuaciDI15pelIDIwOjQ177yMQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+IOWGmemBk++8mg0KPiANCj4gQW0gMTkuMDIuMjAgdW0gMTY6MDIgc2Nocmll
YiBDaHJpc3RpYW4gS8O2bmlnOg0KPj4gQWRkIHVwZGF0ZSBmZW5jZXMgdG8gdGhlIHJvb3QgUEQg
d2hpbGUgbWFwcGluZyBCT3MuDQo+PiANCj4+IE90aGVyd2lzZSBQRHMgZnJlZWQgZHVyaW5nIHRo
ZSBtYXBwaW5nIHdvbid0IHdhaXQgZm9yDQo+PiB1cGRhdGVzIHRvIGZpbmlzaCBhbmQgY2FuIGNh
dXNlIGNvcnJ1cHRpb25zLg0KPj4gDQo+PiB2MjogcmViYXNlZCBvbiBkcm0tbWlzYy1uZXh0DQo+
PiANCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4NCj4+IEZpeGVzOiA5MGI2OWNkYzVmMTU5IGRybS9hbWRncHU6IHN0b3AgYWRkaW5n
IFZNIHVwZGF0ZXMgZmVuY2VzIHRvIHRoZSByZXN2IG9iag0KPiANCj4gRmVsaXggYW5kIFhpbmh1
aSBjYW4gSSBnZXQgYW4gcmIgb3IgYXQgbGVhc3QgQWNrZWQtYnkgZm9yIHRoaXMgcGF0Y2g/IEl0
IGlzIGEgbWFqb3IgcHJvYmxlbSBmb3IgdGVzdGluZyB3aGljaCBuZWVkcyB0byBnZXQgZml4ZWQu
DQo+IA0KPiBUaGFua3MsDQo+IENocmlzdGlhbi4NCj4gDQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDE0ICsrKysrKysrKysrKy0tDQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+PiBpbmRleCBkMTYyMzFkNmE3OTAu
LmVmNzNmYTk0ZjM1NyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYw0KPj4gQEAgLTU4OCw4ICs1ODgsOCBAQCB2b2lkIGFtZGdwdV92bV9nZXRfcGRfYm8oc3Ry
dWN0IGFtZGdwdV92bSAqdm0sDQo+PiAgew0KPj4gIAllbnRyeS0+cHJpb3JpdHkgPSAwOw0KPj4g
IAllbnRyeS0+dHYuYm8gPSAmdm0tPnJvb3QuYmFzZS5iby0+dGJvOw0KPj4gLQkvKiBPbmUgZm9y
IFRUTSBhbmQgb25lIGZvciB0aGUgQ1Mgam9iICovDQo+PiAtCWVudHJ5LT50di5udW1fc2hhcmVk
ID0gMjsNCj4+ICsJLyogVHdvIGZvciBWTSB1cGRhdGVzLCBvbmUgZm9yIFRUTSBhbmQgb25lIGZv
ciB0aGUgQ1Mgam9iICovDQo+PiArCWVudHJ5LT50di5udW1fc2hhcmVkID0gNDsNCj4+ICAJZW50
cnktPnVzZXJfcGFnZXMgPSBOVUxMOw0KPj4gIAlsaXN0X2FkZCgmZW50cnktPnR2LmhlYWQsIHZh
bGlkYXRlZCk7DQo+PiAgfQ0KPj4gQEAgLTE1OTEsNiArMTU5MSwxNiBAQCBzdGF0aWMgaW50IGFt
ZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+
ICAJCWdvdG8gZXJyb3JfdW5sb2NrOw0KPj4gIAl9DQo+PiAgKwlpZiAoZmxhZ3MgJiBBTURHUFVf
UFRFX1ZBTElEKSB7DQo+PiArCQlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0gdm0tPnJvb3QuYmFz
ZS5ibzsNCj4+ICsNCj4+ICsJCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0X2Rp
cmVjdCkpDQo+PiArCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3QsIHZtLT5sYXN0X2RpcmVjdCwgdHJ1
ZSk7DQo+PiArDQo+PiArCQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9kZWxh
eWVkKSkNCj4+ICsJCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGVsYXllZCwgdHJ1
ZSk7DQo+PiArCX0NCj4+ICsNCj4+ICAJciA9IHZtLT51cGRhdGVfZnVuY3MtPnByZXBhcmUoJnBh
cmFtcywgb3duZXIsIGV4Y2x1c2l2ZSk7DQo+PiAgCWlmIChyKQ0KPj4gIAkJZ290byBlcnJvcl91
bmxvY2s7DQo+IA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
