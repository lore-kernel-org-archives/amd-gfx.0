Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB04AC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 12:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D5A611F2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 12:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A9D5A611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632636EC4F;
	Thu, 21 Oct 2021 12:40:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96FA6EC4F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 12:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HE9a/ZX4hoQt+hoXb4Pft+ulRgkdkEzgYyxl4soM7duCVrwuCpi7cczo6GUR3NWUUqdLgossExOI11A0QJ+iC6MxdD5FCBoPnxh6ODQAGXqGruXOnHpFUvfXfGnOCAnbU1eUAFufUIwMJwN4x8XKNOvSc/lncWq775tvVkG2wDFNl+ArpnZuJQh9JXXSMEI37dt+W9kF3NIXyeAdvTjG4j34vz+ispsSC4NyXMiKySdPuZcBYf+E2INpH+t4a4S0UtoZszrWYzxv1JgkDawcNgg9pRnXpdwtP5aWdQaKV+Ea09/VZyF5UhAlco+Np+vaVBTHunz69VevdisyWzx1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GQRbLqT3r5umwI3lgiKyPZRKToOzonK4KX0/3iDiGA=;
 b=c6WVeeNSHo9qRkEaFq1p5FZPgVIqZHgk1tzvIyLjUZCFhEITgjC8ilKEQmapDKXrH4OPUhCTjUxK0i0OgbaSz+LAqyyVocZUSxgeazvRzmlAEkXm/4Uj8om0W5moIFwZlCmXozIhoMfxOz7QEETE0vR6zAppdjw4Px4Sk/sI9qZZMqH99OSmQjT5sZ/hfZHuH8B8kG1w/4T2mthHEnWFIAq58VsurSzvA+kU6AnReNLsdjxszYx6L9PCXipeKukey5oejKjLfjOG/cJWnsFL9sFu3sP3etNzR7LLXXmyzPAbwbtFLr8NaJLo3fMEyHUGe4cR42Pltc7mCXjgATkYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GQRbLqT3r5umwI3lgiKyPZRKToOzonK4KX0/3iDiGA=;
 b=DplUYrD8IE8YCF30E56ACTD90HzKCzMZP8oMGoP81Z+mugYNoOoJMnXaJvKlsaftm/3Uw6SniwD/NOH0xAvmA/jrTZHt9nmJPincKBi3DP2DyiJ4zMlBI5M9PK+BihJYxDIVqYTEX7qxWrxG/So1LM50kOl5KjjP9hOyqgprp2I=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Thu, 21 Oct 2021 12:40:31 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 12:40:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Thread-Topic: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Thread-Index: AQHXxktx1DjGstD6vkidsjU3klQZCqvdM/GAgAAwFNA=
Date: Thu, 21 Oct 2021 12:40:31 +0000
Message-ID: <DM5PR12MB2469397DED5BA16E5E37BFE9F1BF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211021071512.20034-1-guchun.chen@amd.com>
 <e6651a1c-50d2-af66-c985-4b500dcd12f8@amd.com>
In-Reply-To: <e6651a1c-50d2-af66-c985-4b500dcd12f8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1354fbda-f80f-476f-0212-08d9948ff863
x-ms-traffictypediagnostic: DM5PR1201MB0219:
x-microsoft-antispam-prvs: <DM5PR1201MB02191FFEBF3F16619F9AFC2EF1BF9@DM5PR1201MB0219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EVnScriqvHe9UT1Rm0jBSXIbvVLjryDi76BI0h7jwjnSBZ3XPU1qY67Po6CWnv285Zqh+sZzCFQxzWRFt7uemRWoaYuef2lgfCg5gvlUYtudslkZf11L9U0G5BP211I/+bwQev3w+XaJhsksve9NxthkQYSQO23L7msRWNBw14Hc84vKz1MmixgUWItwBMyqUdl9+6oPTnZd6d+PVJe9V2YUXQAa5ybEGtZHLZ4k5lbssF/FQJ6/zlhaQ++Lvu7LTDo/WnYdAoQnkq6S54rp54G45qi7DWALA7LKEun1iJtPoAQVdsKfynN/vU8y1XmVgE1DK6VApSwk1fHNZ4Y7YLEq6c68WixPsXgHZmNRRmfxkXo00Z4FUX9DD55SURu5VtU5Oggr+M+G8Ds3+TgbwbpglP6KbKSSyy3w17FcQ6tWOYbG/dqR1xrSsHs3nBekqLhNbhx4DSuqOAv8N0XiGY/CWx65abjAJEGTy+fXDEVUm6HLklcMZ4Vm6bSEPOaoS5rlkq1uQw0TAYh+kDlFKp4hwGZuZQLIjz5ZQZca6sspA45Y+jLsaL5qeSR6f29Nk63VaqX5zsq2OgulnPLJclm8SuuAuGQm3Xgu885RWJYU3MYb8aJvaBvtwz/ZbR3FexMKVbdGUrUEmzdollSFaKJsJTAxmVY2Dn1ybpe7Vn9OJDrb7g4hSXBser/Ih5QueHgbtxBvUF8BAQWz3QOSFkBAo+uaNZkpfomBeF0d0sc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(66446008)(64756008)(76116006)(316002)(66946007)(186003)(966005)(5660300002)(8676002)(52536014)(9686003)(7696005)(71200400001)(26005)(2906002)(33656002)(8936002)(110136005)(38070700005)(508600001)(83380400001)(921005)(86362001)(38100700002)(122000001)(53546011)(6506007)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnhLTzY1SmRaRmRTQ1NzY00xZGxtbno3N0ZoV0ZJa1Q5cTdKNC8zNVRvZ0ta?=
 =?utf-8?B?UTUwV3dVYWJxNjdxUDhIKzJSYjBZYThTRDdvRkl0NHloZWVMdmNmeTNvRjho?=
 =?utf-8?B?czAzQzBHN0h3b1ZkNGtaWUhHeGZoTHJySHFvczNweUdtVjhrbEUxOUlVdjE0?=
 =?utf-8?B?NlZnSkJralQ3aGw5TmtmbGJwOTVxb252aFhUd2lyWTVoVWZraEMrWnpkRU1E?=
 =?utf-8?B?WTNNTGg0UE92bi9VRGJZb2pHcWpyOGkxRnIzMmJoRTBQRVZiWXdQTWEyL0Vu?=
 =?utf-8?B?ZWNEZEVvR1ZraE5KUStyTlFkb1NyemNDSDdJQWQ1NnY5RkNtZWFVaUxLNnlH?=
 =?utf-8?B?aWRHZnFCUjZKU2FkekJ2WGEvUzJjb1d0V3l2eXp3MWhqNHgwNUFwczBUa2la?=
 =?utf-8?B?bklhcG9rNUdpMFcrOWw0bGRyTlRUcklralRkOGdRenJ6MGNXQnozZXdwUGVB?=
 =?utf-8?B?YWtva0crVlpWSkx0VmFnVWh6bUtOc3FWaEhoNDVlSzhOejllTzNpV0hvTG1R?=
 =?utf-8?B?V1IwRUVUc3FrM2R4V1FXY1dCaHh0MlE2a1ljN2phdDRVRHJIeTJYMmg4RHJQ?=
 =?utf-8?B?WDFDQ1krOURkU05aeXFaT0pTR081THd1ODkrNzk4Z2tDazJUVFhOc25pVjhy?=
 =?utf-8?B?VVNPLzZUa2hWV3VVWlcvYW1MUU9FSDhaNzdTaFdhY3BrZC9lVmNHdUIrUWtj?=
 =?utf-8?B?NHk1MUtDZ25xV3ROMFhWZmNOVjZMcElOQ1JXdC94Sk1Pd2FwaUFTdHZQSjhh?=
 =?utf-8?B?WFhac2ZzR1FBaGd6QjMxaGZjdjhIN3pBOWgwcUFPOGM2TzBYVlNGT2dadVdV?=
 =?utf-8?B?anhGU2h5SXh5dzZkbjlCRFdvTzREcjRsQzVxZ0ZKbURoU2NsU2lYTW1Nbk10?=
 =?utf-8?B?bGlVRFFCc3lVV3N5UHEySTFmM3pZaU4weGloV2JhN0JsNW5lU2dtbDU5V1NW?=
 =?utf-8?B?ZjhqNElWUU51aGN0Y09DL2VGQVR5ZTZwdUd1SlNXWm1YZHVYVyszY3NyWU43?=
 =?utf-8?B?VVNWY1VsN2tCTnVrM3Y5TUJTMHhybUZkQTVoYkhOSlVUc3BoR2I2aVU0YjJQ?=
 =?utf-8?B?L1dKZlZsbU5Za2RBcFJVQlNWNTlWTFhyZzRyZE90eDBvTGhQNU1oVHhZRjVE?=
 =?utf-8?B?aDhtYk50eTdPS1FXT1dVUkE4TDF1enlPTElUNEgrdG04YnlxNVBVd3ltOVVC?=
 =?utf-8?B?THVzMmhzKzJhb2RJN0N1dkN6MjB0SUYxN2VhZGJQRlVrWnlSQzI5eWduUnJj?=
 =?utf-8?B?KzVoRE9QRGgxQ1M1M3JrYzR5bGNhY3BKMDhwbUxWRHN6Q0h4UGZkL1E5aW03?=
 =?utf-8?B?M3pLWkpIQ3hBRk8ralNoZld6cDJiWm5NdlFtVndSZUU2NllZVEVXRGRuRnQ0?=
 =?utf-8?B?T2dNWmoxbUExZmVkTEZrZVl6NjZVcFJ5Y3RsNEZNdFpUdk1kNzVNaUx3czRY?=
 =?utf-8?B?WjlpN0M2WVc5aUJTQ0VMVUJWUjRVWlNDTmpqbnFPQnRFRHk2Q05pOU9USEJL?=
 =?utf-8?B?L1lxcFMvaHdWeTMvd3N1eVdvTFZQRVpwYnNmdUE5dENmR0RGRUVoZ1QvSXhI?=
 =?utf-8?B?NXVBY0NxdDVxdGpVVTEwSVlqUEpaSTYxdHJOYmVXTDRJVm1WQzI4QjdnZHJL?=
 =?utf-8?B?U09XNVg1WXpUdkhuK3Z1bnFISnhSV08wcjREc0hjZ0QrNkJYWHhGOG5CVjhH?=
 =?utf-8?B?ZXZpWUVPY1AxaW9vbXNldGg1cHJnQmtZMkc5SlI1VVpVUXhvZ2VxdElzd1RI?=
 =?utf-8?Q?0cOE/gOodgeqYyF/cWuQeZcbUjblN+6RcS0ATIg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1354fbda-f80f-476f-0212-08d9948ff863
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 12:40:31.7458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guchchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgTGlqbywNCg0KQWxleCBoYXMgYSBmb2xsb3dpbmcgZml4ICI4NWRiN2ZjYjJlNTMgZHJtL2Ft
ZGdwdTogZ2V0IFZDTiBoYXJ2ZXN0IGluZm9ybWF0aW9uIGZyb20gSVAgZGlzY292ZXJ5IHRhYmxl
IiB0byBmaXggdGhhdCBsb2dpYy4NCg0KRm9yIG90aGVyIEFTQ0lzIGxpa2UgRElNR1JFWV9DQVZF
RklTSCBhbmQgQkVJR0VfR09CWSwgaXRzIGluc3RhbmNlIG51bSBpcyAxLCBtYXRjaCB3aXRoIFZC
SU9TIGRpc2NvdmVyeSB0YWJsZS4gU28gdGhlcmUgaXMgbm8gbmVlZCB0byBoYW5kbGUgaXQuDQoN
ClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExh
emFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+IA0KU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
MjEsIDIwMjEgNTo0NSBQTQ0KVG86IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpdSwgTGVvIDxM
ZW8uTGl1QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBsaW1pdCBW
Q04gaW5zdGFuY2UgbnVtYmVyIHRvIDEgZm9yIE5BVllfRkxPVU5ERVINCg0KDQoNCk9uIDEwLzIx
LzIwMjEgMTI6NDUgUE0sIEd1Y2h1biBDaGVuIHdyb3RlOg0KPiBWQ04gaW5zdGFuY2UgMSBpcyBw
b3dlciBnYXRlZCBwZXJtYW5lbnRseSBieSBTTVUuDQo+IA0KPiBCdWc6IGh0dHBzOi8vZ2l0bGFi
LmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzE3NDMNCj4gDQo+IEZpeGVzOiBmNmI2
ZDdkNmJjMmQoImRybS9hbWRncHUvdmNuOiByZW1vdmUgbWFudWFsIGluc3RhbmNlIHNldHRpbmci
KQ0KDQpOaWNlIGZpbmQuIExvb2tpbmcgYXQgdGhlIGZpeCwgdGhlIGxvZ2ljIGlzIGFscmVhZHkg
YnJva2VuIGJ5DQo1ZTI2ZTUyYWRiNDYoImRybS9hbWRncHUvdmNuMy4wOiBjb252ZXJ0IHRvIElQ
IHZlcnNpb24gY2hlY2tpbmciKQ0KDQpBbnkgQVNJQyBvdGhlciB0aGFuIFNpZW5uYSB3aGljaCBo
YXMgc2FtZSBWQ04gSVAgdmVyc2lvbiAoMy4wLjApIG1heSBiZSBicm9rZW4uIEFueSBtb3JlIGV4
dHJhIGNoZWNrcz8NCg0KVGhhbmtzLA0KTGlqbw0KDQo+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBD
aGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y25fdjNfMC5jIHwgOSArKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YzXzAuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5j
DQo+IGluZGV4IGRiZmQ5Mjk4NDY1NS4uNDg0ODkyMjY2N2YyIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMNCj4gQEAgLTEwMyw2ICsxMDMsMTUgQEAgc3RhdGljIGlu
dCB2Y25fdjNfMF9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkNCj4gICAJCQlhZGV2LT52Y24ubnVt
X2VuY19yaW5ncyA9IDA7DQo+ICAgCQllbHNlDQo+ICAgCQkJYWRldi0+dmNuLm51bV9lbmNfcmlu
Z3MgPSAyOw0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIEZpeCBNRS4NCj4gKwkJICogVkNOIGluc3Rh
bmNlIG51bWJlciBpcyBsaW1pdGVkIHRvIDEgZm9yIGJlbG93IEFTSUMgZHVlIHRvDQo+ICsJCSAq
IFZDTiBpbnN0bmFjZSAxIGlzIHBlcm1hbmVudGx5IHBvd2VyIGdhdGVkLg0KPiArCQkgKi8NCj4g
KwkJaWYgKChhZGV2LT5pcF92ZXJzaW9uc1tVVkRfSFdJUF1bMF0gPT0gSVBfVkVSU0lPTigzLCAw
LCAwKSkgJiYNCj4gKwkJCShhZGV2LT5pcF92ZXJzaW9uc1tHQ19IV0lQXVswXSA9PSBJUF9WRVJT
SU9OKDEwLCAzLCAyKSkpDQo+ICsJCQlhZGV2LT52Y24ubnVtX3Zjbl9pbnN0ID0gMTsNCj4gICAJ
fQ0KPiAgIA0KPiAgIAl2Y25fdjNfMF9zZXRfZGVjX3JpbmdfZnVuY3MoYWRldik7DQo+IA0K
