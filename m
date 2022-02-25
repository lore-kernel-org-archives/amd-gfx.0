Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCA9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 02:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB5D10E758;
	Fri, 25 Feb 2022 02:26:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2003010E75E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 02:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjAFFeE1FjyXXyc2eyPJ3JAZbgz2KrmIDPIWXH6MM7c3i6dCn7DpAyydUjPbQ4zcYcq2beHGYz1id6cnsM2/B+AHTGjstHtwIo88NJTaB19fnPCON+hWo87Plc1PDcOa0WeOtguVxiHtNKH/5mYBXPS7vUSNrzRNJAEBvQSJo6yOb59lxasKLNhC5on3FjtUPYe/631SGy0lai3wchHNziUcjmWSzQRFlmfENoLK9KXOV5R1JK468DIfPI4xv8+QRveINKDc+MJYlHZHkoVFkLOjB1QrYBaykWe1LAFTEnDc+IMHxb8njMvxpEXf52m40d5e+YPzh6hg1/jJjiS+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeqnOoDa9Rz12THvGFRQpGPcjeZ5WNmOIX4MdQhfy1w=;
 b=S7s5Xzq2HZDL662fSdm3JZGz7CvSincOwsKt5DdGSeswEgBISDGgnfb2vxfSgJO1FvLki13K/mYPln8/kTTVyEOTFfk3jfg9v2ZJ4FV+WgvWN861/VsxpxuEBXTaGFryuZdn2d5S8YzCO/GUGYRNNmxTpQkxC/Aklxc0aBEcJ6Q7VLGC0B6xd5WELXovuG+NOrxuMTpNK1U3L2c5rBrf/YpHbsv3ekb4YqbmnrbQAR9XAekTGuvqjup7+mloA/GN4n18JfbmnrULiOKCd8faL9GnER+s+W+cd8Bbh7zyMqlu6G/usFI9S5T6/K/0aGTPdJbqo7AhN+Hq6uDuOsQXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeqnOoDa9Rz12THvGFRQpGPcjeZ5WNmOIX4MdQhfy1w=;
 b=pIVX2d1MI0qxXN4P6GUmc5FBtARybVkVHlpDY5Ch1Qa+wn/idCNnoObJ4IO0PEECF8lOBC8HS62Dv5kNyJChJg4t0YKyoBhRkNq1ubjz/wmX0h+hVIaEbh6nNHBnflcsOhE5FLp+nVhwRHhXybNaKUfdfEky3FfzubsEhGEolBs=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SJ0PR12MB5487.namprd12.prod.outlook.com (2603:10b6:a03:301::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 02:26:21 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.5017.022; Fri, 25 Feb 2022
 02:26:21 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
Thread-Topic: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
Thread-Index: AQHYJ/32a7kG4n5k10KbmxqPExm2rayi3qwAgACu/5A=
Date: Fri, 25 Feb 2022 02:26:21 +0000
Message-ID: <DM5PR12MB246960DF4323A6DDA78F56F8F13E9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220222150731.16954-1-guchun.chen@amd.com>
 <CADnq5_MHoxvwf0Zg+3Wu1w_yq+RTHtBG=f4FRv4H+Pp+kHDiqA@mail.gmail.com>
In-Reply-To: <CADnq5_MHoxvwf0Zg+3Wu1w_yq+RTHtBG=f4FRv4H+Pp+kHDiqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c239a8e4-8a6d-4aa8-e973-08d9f806367a
x-ms-traffictypediagnostic: SJ0PR12MB5487:EE_
x-microsoft-antispam-prvs: <SJ0PR12MB548745605FDB503B40909B3AF13E9@SJ0PR12MB5487.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NxPfZIty5B6A4gEJlNA9ZzqVPr26d5bCo7IQJ+FJOQTdWmBTX76HFHLNyLdSsdWDITJSpA3RhZ2Vq2tNmxZLeeOBpAGpMQYcOFE+DqNzJE5RlWjz/CfEQOxrSBTxElqqeJdQfUccTyJyiVA1Olf/D6MH1qAWwAlWZKgijs+2n/hUIEaeOX6LHD7H3s33g228NTpxh6dRgEQzfzcwI/ghWeuTq+hrFR4YZeNacxIlVQmgrL94wiBr6UefAUHucruvJe/mEXc8bM/kIXOmvzbVsqaXW148NgQBomDLecP2igTBX8PMQw+l6Osu4Zg6OjF1iemIuqZ168bxa/r3CrLe1Cw7pJLZXjkNlsSb7tHONL1C3J8EHX19ovsT2GYEgZkNBtRXlXULwJZYYnY8g0TKiuZ0DGZPYcckQR8NAI/L/znViOXmQ1Ryc+UxFSfTA8+P0AaoK/eIYYreHu2rTztHxIvybfe5ZzxBQgj/LB2QJSICaANO9yPYpBmW5Huvhn3fec0fPVF3kNkNu7hBe6342C8OV8eSOnG1GQIw1tVCBMVtqu7thJIpQviir0Y3AXaQjq/p67J3QHvlwrFCv89Y3BLwhbebYiFkkEYdnCkoQHZUnRyKyP21/B1fgUbOsyx1/mbmWLCGeaZaBmOGgRLpfta72FIkxAiBE6gC05BviRwjOvwaDkdLLltj3LCC0+tp/VFovNy2gMzjCK5LbhX7VQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(4326008)(76116006)(66946007)(83380400001)(186003)(5660300002)(52536014)(54906003)(6916009)(8936002)(66556008)(66476007)(66446008)(64756008)(55016003)(8676002)(33656002)(38100700002)(6506007)(7696005)(508600001)(122000001)(2906002)(71200400001)(316002)(86362001)(9686003)(53546011)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzNNTENkNlFraEQ1OEMxbllOcVg2a2VNWTQyOXk1aDJIVmlNNVZ1WW1YQ3o2?=
 =?utf-8?B?d3hZSjIyRGpETHNVUXIvM1pOaDV4N3haWGt4c1VqRTJRR000NG0ydmF6UFg5?=
 =?utf-8?B?VUxyc0UrQW5zRjhJMFFud2RDNFFsR2lVeGlidisrelcvS2EwREwzS2lrdVVp?=
 =?utf-8?B?YWF3ZjNzSVFXZjdTd3ZPakp6azE4R05hK1RrelJuSkhaQWtCUEExM1d5SnNi?=
 =?utf-8?B?RGhqWXZSOTE4SjdBVlFNbDIrVW9jU1A1ZDFtUGlheGpnQ2V2dlhTWXQrRElm?=
 =?utf-8?B?YW04d3hrZ2ZoZWZueDRlQzVvUUV3R1MxZVV1eDcxemNvRDBDY1R5WE13Y3VI?=
 =?utf-8?B?Zzc2WkV1VVpHaElXaHIxL29QeFlDZ1g2YStzQURESzlLMDdreWlHUGMrY1p1?=
 =?utf-8?B?TFNGQjFQdGN2K0IvaXhpRXR3bFpaQXJ5Z1BPdnViTG1yMC9ZRGhnN3dsV0lL?=
 =?utf-8?B?K3NxMERUUE04ZjNEVVZ6M09Id21KRHdPek83WmVPL1lDaklQdDliNHUzZGI5?=
 =?utf-8?B?NUhHbjRzbEFBTTJ2NGhZRWNtSlVnS3lFeElHRFpSNnZnWDU2cGgzYytwNUhq?=
 =?utf-8?B?SEM4OGM4dG1vaGlVWVd2MlZRZWhIWTNralVrQk4zWThkb3g3TTVMTUtDa3Vv?=
 =?utf-8?B?UlVGemcrVTJYMXFMeEdhbGI2SmVzRHFqWUFHaWc1MjVVb3dSYkIyS1ZaZUx0?=
 =?utf-8?B?Q2xFelZqT1FJeGdmNzZaOGs0TWtGcEw5aGhLSldNK3M2UDNQM2JiVWFHN0E0?=
 =?utf-8?B?OFppcHFabml1SU1LYTlHUXlSblE5YU9UNjljOEl4NkNNRUtGYVJIV2NFTzBY?=
 =?utf-8?B?RmNlKzBLMUdZVktkMEZvY3A3RXFVTG5EZG9hdjZReHNueGVLeVB5aG5vQWhO?=
 =?utf-8?B?TkxCYW12a3RIUFJYM2FoNFV0aHhZYmgrRXJFd0tHVmRBUTExdk13MGxCbkh5?=
 =?utf-8?B?Rkl5eVFnL0k4YW54eU5yQnNGY203Ui9yaEd2eFY0WWsxdDBtYmpPdXVtdk1E?=
 =?utf-8?B?U3F5UWxUdStQQ0hTZ0h1L3UzMXVIckVQVTlUUHlKTVlYMFMwNE5aTGE1Q2Ex?=
 =?utf-8?B?Y0RQVnNyL0ZIWW9VRklwZUttOHVPRSthcDg5c2hqM084T1laWWZ4SGkwM2hR?=
 =?utf-8?B?NnlBQ2h3eGNJMkZkcjJieGZRRDA5N05sVnI0djlBQVlldW96Y2VleGcxeUlw?=
 =?utf-8?B?cjBCN1g4VkFrYWtIcWp2Rm1DS3VaVXpGYzFwa0Jhbm0vOUJOekhudkZhYVhC?=
 =?utf-8?B?NkwxTnNZQXRLWmNyK0YvMmpaeVVJZW1ydUV1NGJHOE83QzE3RXRBNEFvRTRi?=
 =?utf-8?B?dlJDS3lLbjV6Z1FEZ2lPdWxvUFY3eUN1WFpMSzlkYnpBZmJkT21OZ2pBQTZZ?=
 =?utf-8?B?QlAwWXF0cmJLbmFaUjZKSzk3SnliUDNhM3Z6a25valduTEovUGYrMk9seEh0?=
 =?utf-8?B?THovWjVDTHBqZ0ozNjBnZk1UT2RGeEwvd3NnNjhrZ3VVcWJCMkZRMkFBcHNh?=
 =?utf-8?B?YTRYOVY3R1JVNGptU1hPenc1bk5obEFzY3pWbHdaU3h5SnExMFJTSmQwdzRh?=
 =?utf-8?B?TnZDQWZTdURhMFBzUUhGay8wNTlRcHh6QjJIanpQMzg0S0lTODV2cElpTm41?=
 =?utf-8?B?bWkzWTF5Y0E1WmFGd1doUlFwdEQ5WWJGWnc1Szk2aVBDK1IyeGtFbSs2bkl3?=
 =?utf-8?B?d2RQRENMbmFrVEJJaWxHZS8zMkVZQzNIWGtIcXZ4bk1NTk43RElBZnNTUHM0?=
 =?utf-8?B?cnNKWkFVMVBnNjUvaE8xaXY0aExqMGdFYXZyVHdxSFdMQXpIVDFSRnd6UmYx?=
 =?utf-8?B?THFBTE9ERVhRemtXbEs5eXNOaUZORml6RlBqcWVYR2NjUjVqUXlScTUwSHAy?=
 =?utf-8?B?L3JwclE1Z3Z5S0xENWRXd2tHdVczSlFUTmxoUzRJbUEvSXVFQW1jNFBRbGti?=
 =?utf-8?B?QVBCZzJZLzYzaGJDQml1SVR2MXh0Q1pFK3FZdlpHQkZyQWNOYlZLd2ZUNWdk?=
 =?utf-8?B?ZFU5TDVXMktHdHFEck9yY21zVlk0dm1WclVxbkZ2V1ZVREZrNmNIVmxZU0Jt?=
 =?utf-8?B?bEtDdHphS0l4YTIrSTQzOWI1Mkg3NEZHSkNndXNUUzZYK1RRV1pPWUppb0lZ?=
 =?utf-8?B?bHJ6YmNVbkFNT3pLdk5Gb1ZJNkZZR0VXdmNVNG1LbWcxcWxSM2kzNzErQkdG?=
 =?utf-8?Q?+gNY48NFNEX1Zp2Nv2vrE9s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c239a8e4-8a6d-4aa8-e973-08d9f806367a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 02:26:21.6371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bx8QwJKDRMDO44vYyHPSbkPm0bml8FkhKPiouVvTIBbN0yrkbr3bifGIUgpEjqwt3pKPVouYeJwS4IrLWLxXlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5487
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQWxleCwNCg0KRXhhY3RseSwgSSBoYXZlIHRoZSBzYW1lIGlkZWEsIGJ1dCBJIG5lZWQgdG8g
ZG91YmxlIGNvbmZpcm0gdGhlIGhhcnZlc3QgYml0IHNldHRpbmdzIGFyZSBjb3JyZWN0IG9uIGFs
bCB0aGVzZSBsaXN0ZWQgQVNJQ3MuIE9uY2UgY29uZmlybWVkLCBJIHdpbGwgZHJvcCB0aGUgcmVk
dW5kYW50IGNoZWNrLg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gDQpTZW50
OiBUaHVyc2RheSwgRmVicnVhcnkgMjQsIDIwMjIgMTE6NTggUE0NClRvOiBDaGVuLCBHdWNodW4g
PEd1Y2h1bi5DaGVuQGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBLb2VuaWcsIENo
cmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5Q
YW5AYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGxpbWl0IGhhcnZl
c3QgYml0IHJlYWQgb24gc2V2ZXJhbCBBU0lDcw0KDQpPbiBUdWUsIEZlYiAyMiwgMjAyMiBhdCAx
MDowNyBBTSBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4gd3JvdGU6DQo+DQo+IER1
ZSB0byBmYXVsdHkgVkJJT1Mgb3V0IHRoZXJlLCBoYXJ2ZXN0IGJpdCBzZXR0aW5nIGlzIG5vdCBj
b25zaXN0ZW50bHkgDQo+IGNvcnJlY3QgZXNwZWNpYWxseSBmb3IgZGlzcGxheSBJUC4gU28gZmFy
LCBpdCdzIGhhcmQgdG8gd29yayBvdXQgYSANCj4gc29sdXRpb24gb24gYWxsIHRoZSBsZWdhY3kg
TmF2aTF4IEFTSUNzIGluIGEgc2hvcnQgdGltZSwgc28gdG8gYXZvaWQgDQo+IHJlZ3Jlc3Npb24s
IGxpbWl0IGhhcnZlc3QgYml0IHJlYWQgb24gc2V2ZXJhbCBBU0lDcy4gV2lsbCByZXZpc2l0IA0K
PiBsYXRlciBvbmNlIFZCSU9TIGhhcyBjb3JyZWN0ZWQgaXQgaW4gbG9uZyB0ZXJtLg0KPg0KPiBG
aXhlczogYjNmNGVhODg3ZDVmKCJkcm0vYW1kZ3B1OiByZWFkIGhhcnZlc3QgYml0IHBlciBJUCBk
YXRhIG9uIA0KPiBsZWdhY3kgR1BVcyIpDQo+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxn
dWNodW4uY2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kaXNjb3ZlcnkuYyB8IDE4ICsrKysrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IGluZGV4IDExMjU1
MjkwZjExNy4uMmUwZmYxYWNlNmZjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IEBAIC0xMTI5LDEyICsxMTI5LDIwIEBAIHZvaWQg
YW1kZ3B1X2Rpc2NvdmVyeV9oYXJ2ZXN0X2lwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
PiAgICAgICAgICAqIHNvIHJlYWQgaGFydmVzdCBiaXQgcGVyIElQIGRhdGEgc3RydWN0dXJlIHRv
IHNldA0KPiAgICAgICAgICAqIGhhcnZlc3QgY29uZmlndXJhdGlvbi4NCj4gICAgICAgICAgKi8N
Cj4gLSAgICAgICBpZiAoYWRldi0+aXBfdmVyc2lvbnNbR0NfSFdJUF1bMF0gPCBJUF9WRVJTSU9O
KDEwLCAyLCAwKSkNCj4gLSAgICAgICAgICAgICAgIGFtZGdwdV9kaXNjb3ZlcnlfcmVhZF9oYXJ2
ZXN0X2JpdF9wZXJfaXAoYWRldiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmdmNuX2hhcnZlc3RfY291bnQpOw0KPiAtICAgICAgIGVs
c2UNCj4gKyAgICAgICBpZiAoYWRldi0+aXBfdmVyc2lvbnNbR0NfSFdJUF1bMF0gPCBJUF9WRVJT
SU9OKDEwLCAyLCAwKSkgew0KPiArICAgICAgICAgICAgICAgaWYgKChhZGV2LT5wZGV2LT5kZXZp
Y2UgPT0gMHg3MzFFICYmDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIChhZGV2LT5wZGV2LT5y
ZXZpc2lvbiA9PSAweEM2IHx8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5wZGV2
LT5yZXZpc2lvbiA9PSAweEM3KSkgfHwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgKGFkZXYt
PnBkZXYtPmRldmljZSA9PSAweDczNDAgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIGFk
ZXYtPnBkZXYtPnJldmlzaW9uID09IDB4QzkpIHx8DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IChhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHg3MzYwICYmDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICBhZGV2LT5wZGV2LT5yZXZpc2lvbiA9PSAweEM3KSkNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgYW1kZ3B1X2Rpc2NvdmVyeV9yZWFkX2hhcnZlc3RfYml0X3Blcl9pcChhZGV2LA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2Y25faGFydmVzdF9jb3VudCk7DQoNCk5v
dyB0aGF0IHdlIGhhdmUgdGhpcyBjb2RlIGluIHBsYWNlLCBjYW4gd2UgZHJvcCB0aGUgaGFyZGNv
ZGVkIGhhcnZlc3Qgc2V0dGluZ3MgYmVsb3c/ICBFLmcuLA0KDQogICAgICAgIGlmICgoYWRldi0+
cGRldi0+ZGV2aWNlID09IDB4NzMxRSAmJg0KICAgICAgICAgICAgIChhZGV2LT5wZGV2LT5yZXZp
c2lvbiA9PSAweEM2IHx8IGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4QzcpKSB8fA0KICAgICAg
ICAgICAgKGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDczNDAgJiYgYWRldi0+cGRldi0+cmV2aXNp
b24gPT0gMHhDOSkgIHx8DQogICAgICAgICAgICAoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4NzM2
MCAmJiBhZGV2LT5wZGV2LT5yZXZpc2lvbiA9PSAweEM3KSkgew0KICAgICAgICAgICAgICAgIGFk
ZXYtPmhhcnZlc3RfaXBfbWFzayB8PSBBTURfSEFSVkVTVF9JUF9WQ05fTUFTSzsNCiAgICAgICAg
ICAgICAgICBhZGV2LT5oYXJ2ZXN0X2lwX21hc2sgfD0gQU1EX0hBUlZFU1RfSVBfSlBFR19NQVNL
Ow0KICAgICAgICB9DQoNCkxvb2tzIGxpa2UgdGhlIHNhbWUgYm9hcmQgdmFyaWFudHMgaW4gYm90
aCBwbGFjZXMuDQoNCkFsZXgNCg0KPiArICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAg
ICBhbWRncHVfZGlzb2N2ZXJ5X3JlYWRfZnJvbV9oYXJ2ZXN0X3RhYmxlKGFkZXYsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnZjbl9o
YXJ2ZXN0X2NvdW50KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgJnZjbl9oYXJ2ZXN0X2Nv
dW50KTsNCj4gKyAgICAgICB9DQo+DQo+ICAgICAgICAgYW1kZ3B1X2Rpc2NvdmVyeV9oYXJ2ZXN0
X2NvbmZpZ19xdWlyayhhZGV2KTsNCj4NCj4gLS0NCj4gMi4xNy4xDQo+DQo=
