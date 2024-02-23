Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565E1C54798
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 01:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE9D10EACF;
	Fri, 23 Feb 2024 01:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A7/fdVa5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13DF10EACF
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 01:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ4HDlebtB83yHKqpLumXxLDcOzogYH1MoFWeNZmsQVN8ETaYnmjdftpMQrwaENPaeoz2hf57xcHIDVg5nImgehlQegp5bWZ4OYMx6jWB8C5ekkTDR3L/mblBFmtTeZ/xT3Z8oWlV57+Hd9+O9spqbm+T/pbcxafPP6e+YCL5hoac4RihekgfLErnoVuMUF+Rp489dmUhSLbX0vdVvwqguzb9hHlyr8eX6gL3ZEnC1rjXvXofoy5peoVv608N30GNywSa/3mjOwghSza1Arf0sdS3gHJoTzjhN3cfc82xwvbiWyK7DYGSAeo83iHkJRByrXydHXYPMhTunfbbGoLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD/IbtIFT04H6BKT0FdFYxt365W1x53iZ/mH4EmWJNQ=;
 b=IwGBH/60ZjRhCgdM077sx2Fpa4j88w15ODHJL3eJZ07Z9JWfwB6GevDLaQQGkrJ0GLpKy4vcEQ57nqRA6VJz7L+LdYBqmaF027jDnm85NWkl6wHPph3yVjF7gRAE1F+3/nckPML4ixDuif/jztYw4wTNh+KH47lWjpkHCiNmgBl9/Lf+Bp6MwM8+oFsH+eTTZI/2vKaJrg01KbGiMd2l1Qj3teRTLfoAElcZJ0m+XexWYrLfo2dFqX/7aRitRMpu87+WcDfl1n7Exk9QPn4DtjnDzWvXPaNF4M4JFyHneHr/SG5si9Tm2sFfbRq+omLSqRC2vHmNNKmsubqktSDfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD/IbtIFT04H6BKT0FdFYxt365W1x53iZ/mH4EmWJNQ=;
 b=A7/fdVa5lxFf7A1zPj5xLP5mbSU41Hn3p3De2p3SyAh52jplc7RSgHpeqy9kCyM/VUnfKA7Tvvfa64Ccb+mXW8WRza4naPsfx0xdqTmbFDMGqQ87wExKVwTRtxZ/bi0cvcbnkvm1pOdeuwR1HxyqtRNspfP09LI3Lz75Y1Cylr0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Fri, 23 Feb 2024 01:50:27 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::a702:68e0:aa54:fb87]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::a702:68e0:aa54:fb87%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 01:50:27 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable gpu reset for S3 abort cases on Raven
 series
Thread-Topic: [PATCH] drm/amdgpu: Enable gpu reset for S3 abort cases on Raven
 series
Thread-Index: AQHaZZTcK41R/s0mrEeGb70LXzSYxrEWlsuAgACRttA=
Date: Fri, 23 Feb 2024 01:50:27 +0000
Message-ID: <DS7PR12MB6005EBDF6A3B3FB76E671120FB552@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240222134126.1111837-1-Prike.Liang@amd.com>
 <CADnq5_PGjdSAaDB-XYodMMxhCJkRLmCLPvs5iF8KKabresgE8A@mail.gmail.com>
In-Reply-To: <CADnq5_PGjdSAaDB-XYodMMxhCJkRLmCLPvs5iF8KKabresgE8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=74a3ae9a-8dab-4df1-a26e-ff2847d86252;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-23T01:44:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY5PR12MB6384:EE_
x-ms-office365-filtering-correlation-id: f6359334-0ffb-462b-f6eb-08dc3411cf10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EfUKhiahv6Fe0rCTSlYYaLd3Z2yPxo1ZE+ZF4xulrYlUdib7DT1Fs5srfuxMKYd+KZpLKYHIV1GQQ6SYPm+UktCVq8FCXEzIOKiWLEFT/NiclI0vRE+OZa0hFB5n9PJW7Ki7AXAn7STOby1LaNKgUHJopKcw9sgd0K9U4GhyBHfY7dBGuxmVSulHiUuePpWShC6PF7v5M1eySFumSh7E3sVWNaaa21w8L55oOrdgxPRnRQkRDx1P7kevJHg0Ph+7qm4bv8xD4DcjX7FtNLkIiPFxbyedki8TfCyUdX6pdqT5g8uvDmqOgTxIfxdp1utEVjACA7dQY2qkhkK+BUWkAYw5IzfkFBlQl1kBaAF6bbla2SD37nHfRtHognTMHaKedaEeZwxJ/nN1YW53SPJGZjDyv17amscar/Ret5Dn2QelpqBQW9ILavvqivX35XIkUrla2xKtLhKK7qRv3V6QXbLI++tFDXc9E4DSRnKqQWNtzbzvcGYyGOs60xtJ9URZgg0OmwVY8ZepHwX8gdjt8qduZc0VuN+g4SeATWim5gn8ganFDmX/b9qlRyR+QJBpZ869AL8btkxl6CiYjyDEjKjTpCCvpiRmz22kVfmk2ECsnT9dRUpiEskx6LhKa13z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFZsOGsvajdNZm9haFprQ1YwNTNVajlOWnZueHZwQWxSRnhjK0hiRWVVWjBm?=
 =?utf-8?B?TlY3ZnprRE1SS2pwa1ZrUEdLV2RMdUsvTTBKTmFrd2oxZEEwc2duYXVuekVO?=
 =?utf-8?B?US9jYlB3eUNScmw3aDBydk1kb2MrUHFaTXlML0N2MkJaWWVtRWNoTmNPM1JP?=
 =?utf-8?B?UlJVZjlZQ1ZQc3BTS0lVSGhCdXk0K0hGT3RjbVdxNktEVDRLL2p6N3U4cG5W?=
 =?utf-8?B?SDRJQWJ5aThNVFArSm01VUgvQXVhRTMvcEVzdjZyak9tZjZtOUtJajU1SVRP?=
 =?utf-8?B?UjZJYkRhUzBkeXBBeVAySWZWcGpGbTR1SHhRZTNSeDNqNTFrcENyS0dldExq?=
 =?utf-8?B?NkFmb05IUmxDaXh2SXBXKzBkOHMyVzUvNVJCUGNUeGE0M0hCeFNNalJMVE9w?=
 =?utf-8?B?UFcwOWIvWkpPK1h2ZHIzZEVaWGxjaVZMd3RFWTltb1ZwQWl3L2RvNkdzWXM3?=
 =?utf-8?B?YnpFNTJnRWJueGl4MHNmc1ZSU2wybXhZSUh4c3o5QWRyZlgwUStNeWgzd3J6?=
 =?utf-8?B?RlpXZzBweVhhQThhK09MMVRFVHpXeGZxSkJzQ2Y4aGpBNkdvRzRycTc0VWtE?=
 =?utf-8?B?VEdMNGNyNDlsbzhkbGQ2Z0ZYK1RwbmZ1S0tsMUhxaFpEZkhTOHV2TWxTRUI1?=
 =?utf-8?B?aHBWM0tXSXY5Y3A0MHpSNEpCcWwvVmFOaHl1TTBvdFI4MVBBM0xJR2hnZ3ZI?=
 =?utf-8?B?VVIvaHUzT2Q5b3VWSmc3OVJ2RGpFTm9wK3IxOUdibUNJZWMzbG5hdVhBZFll?=
 =?utf-8?B?MkZUR3JZN2tITjNaZEJYcnpaN0E5NWY3RFgvcEh5N0NQdHIzOExQOTh2N2Vz?=
 =?utf-8?B?UWdxV0podk16Sy9TajlRUnJKUWJZckJSN21VQlNnZ2F4TDd6bmNSYmhvZ3dj?=
 =?utf-8?B?ZUFwN3JURDV3TlNTNVZRTzFRMWZ4YmlOK3ppSjJNQVNjMGNPc2wvNk1kd29N?=
 =?utf-8?B?bk4yOGU0S3NtZDFqME5NVmZBYzFQQm1ROU5RODdZcVVvSjlVd3FyNWd0b1p0?=
 =?utf-8?B?d0JKakk2UmVOSk5LenlUamppdGVKdDUyK2h0U2dpVm41aUNUOHF5bE5UUU1t?=
 =?utf-8?B?ekZXV2VBdEs5THd5SkR1emp3Z2JmZnBJWTdEZ0JKUmVPUFczbUR3NXBJN1BX?=
 =?utf-8?B?UlNLOVNUTnN3SFd0TS9iaG8raHNlZmh2VUN6WHVRUi85RkpqSnR5a3JURXlv?=
 =?utf-8?B?L0tvclEvL3ljMnI4SEp4MFFqSUNIaUNQd0x5ZzVwb3ZhQlA2cGZ6M1dXdi9m?=
 =?utf-8?B?ZnhCQXJZUDRwaVlYbWJwNHY5MFlkODZnYm8yak9qbjZvWmljUzNTNUdpRGUr?=
 =?utf-8?B?RisybmZlMERuampCaWF1cWdTMWk3MkxwMjlTWENQUlBURGt5ZFJKRzl6bmhY?=
 =?utf-8?B?QUpERXA2RGJhd2loVmIzV1RWNzg2ZDBaVXdTZi9kL0tKN01ZNTVHRmMrbjBt?=
 =?utf-8?B?ZUtJa0ExSDBQUmo0TTVQNXprQXJxaDhFczAvbzJCWVZ6R1hnM1hGQXhpeDRV?=
 =?utf-8?B?Z1lySDRXWFl2ZUI3enVwRk81alFuQ1J0bEorTGcrRlkwbG1uN0xnOXFSVnI1?=
 =?utf-8?B?Tys3ajVGTENtRFhTbzBtdVQ1aWd6Uzd1QWR5MTZzK0NYK2VYR0VhSklhUjBz?=
 =?utf-8?B?OWdjbVpLUFhjdjB3YWhJUkRpZ0gyd2k0VXNtSzJLMFNyZnl6bUZrSUhCWUZY?=
 =?utf-8?B?bWRVQUVXTERXVnZXMzlMZURNT2xwNHduL1R0UEVMb3BFZ1lWajRza3l1TmI2?=
 =?utf-8?B?bnAyZW9FZy9OaHczNytzYUpJS29tWnRCdzM1Ny9GcWRVeHR6MUpMNVBVaUJm?=
 =?utf-8?B?MU5WeTRHbjNXMk9TV3dORVZpV05RWmx0WnVzRkRxZk1sbThMbk5yRnRIVVlS?=
 =?utf-8?B?em5jdXl3cEwyenB1SFpiekhSR2UrZjJWa25hYy9MR253ZVlWakhEamM0R1B5?=
 =?utf-8?B?TmZ0RHhZQXlOam41RHgyTVNDS004RWwxN3BvekhhWmprNTNTWVpPVUZYSlBN?=
 =?utf-8?B?Q0VsNDB5UG1uQy9LTFdYUU9aMW9LQS9oMWwxdDRYeDBEQk9hQjd3WWsyVGRo?=
 =?utf-8?B?bGE2NFcvYkZBbEhGWDVLdlpjOGVIU2t0NUtNSlIxN25IZjBINTBaMlkyZTNy?=
 =?utf-8?Q?4+R0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6359334-0ffb-462b-f6eb-08dc3411cf10
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 01:50:27.2460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAM6bEp/Ui3A2ugxL93CT4FH5ay9cSOMC+PJKHjkGxyu8rRn8N/sN7bYJf5I1cJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gRnJvbTogQWxleCBEZXVjaGVy
IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjMsIDIw
MjQgMTowMyBBTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Ft
ZGdwdTogRW5hYmxlIGdwdSByZXNldCBmb3IgUzMgYWJvcnQgY2FzZXMgb24NCj4gUmF2ZW4gc2Vy
aWVzDQo+DQo+IE9uIFRodSwgRmViIDIyLCAyMDI0IGF0IDg6NDHigK9BTSBQcmlrZSBMaWFuZyA8
UHJpa2UuTGlhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBDdXJyZW50bHksIEdQVSByZXNl
dHMgY2FuIG5vdyBiZSBwZXJmb3JtZWQgc3VjY2Vzc2Z1bGx5IG9uIHRoZSBSYXZlbg0KPiA+IHNl
cmllcy4gV2hpbGUgR1BVIHJlc2V0IGlzIHJlcXVpcmVkIGZvciB0aGUgUzMgc3VzcGVuZCBhYm9y
dCBjYXNlLg0KPiA+IFNvIG5vdyBjYW4gZW5hYmxlIGdwdSByZXNldCBmb3IgUzMgYWJvcnQgY2Fz
ZXMgb24gdGhlIFJhdmVuIHNlcmllcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExp
YW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jIHwgNDUNCj4gPiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1
LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPiBpbmRleCBl
NDAxMmY1MzYzMmIuLmY2OGVmMDg2M2NiMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYw0KPiA+IEBAIC01NzQsMTEgKzU3NCwzNCBAQCBzb2MxNV9hc2ljX3Jlc2V0X21l
dGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldikNCj4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuIEFNRF9SRVNFVF9NRVRIT0RfTU9ERTE7ICB9DQo+ID4NCj4gPiArc3RhdGljIGJvb2wg
c29jMTVfbmVlZF9yZXNldF9vbl9yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIHsN
Cj4gPiArICAgICAgIHUzMiBzb2xfcmVnOw0KPiA+ICsNCj4gPiArICAgICAgIHNvbF9yZWcgPSBS
UkVHMzJfU09DMTUoTVAwLCAwLCBtbU1QMF9TTU5fQzJQTVNHXzgxKTsNCj4gPiArDQo+ID4gKyAg
ICAgICAvKiBXaWxsIHJlc2V0IGZvciB0aGUgZm9sbG93aW5nIHN1c3BlbmQgYWJvcnQgY2FzZXMu
DQo+ID4gKyAgICAgICAgKiAxKSBPbmx5IHJlc2V0IGxpbWl0IG9uIEFQVSBzaWRlLCBkR1BVIGhh
c24ndCBjaGVja2VkIHlldC4NCj4gPiArICAgICAgICAqIDIpIFMzIHN1c3BlbmQgYWJvcnQgYW5k
IFRPUyBhbHJlYWR5IGxhdW5jaGVkLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBpZiAo
YWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVICYmIGFkZXYtPmluX3MzICYmDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgIWFkZXYtPnN1c3BlbmRfY29tcGxldGUgJiYNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBzb2xfcmVnKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsN
Cj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0
YXRpYyBpbnQgc29jMTVfYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgIHsN
Cj4gPiAgICAgICAgIC8qIG9yaWdpbmFsIHJhdmVuIGRvZXNuJ3QgaGF2ZSBmdWxsIGFzaWMgcmVz
ZXQgKi8NCj4gPiAtICAgICAgIGlmICgoYWRldi0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19SQVZF
TikgfHwNCj4gPiAtICAgICAgICAgICAoYWRldi0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19SQVZF
TjIpKQ0KPiA+ICsgICAgICAgLyogT24gdGhlIGxhdGVzdCBSYXZlbiwgdGhlIEdQVSByZXNldCBj
YW4gYmUgcGVyZm9ybWVkDQo+ID4gKyAgICAgICAgKiBzdWNjZXNzZnVsbHkuIFNvIG5vdywgdGVt
cG9yYXJpbHkgZW5hYmxlIGl0IGZvciB0aGUNCj4gPiArICAgICAgICAqIFMzIHN1c3BlbmQgYWJv
cnQgY2FzZS4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAgaWYgKCFzb2MxNV9uZWVkX3Jl
c2V0X29uX3Jlc3VtZShhZGV2KSAmJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICgoYWRl
di0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19SQVZFTikgfHwNCj4gPiArICAgICAgICAgICAoYWRl
di0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19SQVZFTjIpKSkNCj4NCj4gTWF5YmUgY2hlY2sgdGhl
IGFwdSBmbGFncyBmaXJzdCB0byBhdm9pZCB0aGUgTU1JTyByZWFkIG9uIGNoaXBzIHdoZXJlIHdl
DQo+IGRvbid0IG5lZWQgaXQuDQo+DQo+IEFsZXgNCj4NClllcywgaXQncyBhIGdvb2QgaWRlYSBh
bmQgd2lsbCBhZGRyZXNzIGl0IGF0IG5leHQgcGF0Y2ggdmVyc2lvbi4NCg0KPiA+ICAgICAgICAg
ICAgICAgICByZXR1cm4gMDsNCj4gPg0KPiA+ICAgICAgICAgc3dpdGNoIChzb2MxNV9hc2ljX3Jl
c2V0X21ldGhvZChhZGV2KSkgeyBAQCAtMTI5OCwyNCArMTMyMSw2DQo+ID4gQEAgc3RhdGljIGlu
dCBzb2MxNV9jb21tb25fc3VzcGVuZCh2b2lkICpoYW5kbGUpDQo+ID4gICAgICAgICByZXR1cm4g
c29jMTVfY29tbW9uX2h3X2ZpbmkoYWRldik7ICB9DQo+ID4NCj4gPiAtc3RhdGljIGJvb2wgc29j
MTVfbmVlZF9yZXNldF9vbl9yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIC17DQo+
ID4gLSAgICAgICB1MzIgc29sX3JlZzsNCj4gPiAtDQo+ID4gLSAgICAgICBzb2xfcmVnID0gUlJF
RzMyX1NPQzE1KE1QMCwgMCwgbW1NUDBfU01OX0MyUE1TR184MSk7DQo+ID4gLQ0KPiA+IC0gICAg
ICAgLyogV2lsbCByZXNldCBmb3IgdGhlIGZvbGxvd2luZyBzdXNwZW5kIGFib3J0IGNhc2VzLg0K
PiA+IC0gICAgICAgICogMSkgT25seSByZXNldCBsaW1pdCBvbiBBUFUgc2lkZSwgZEdQVSBoYXNu
J3QgY2hlY2tlZCB5ZXQuDQo+ID4gLSAgICAgICAgKiAyKSBTMyBzdXNwZW5kIGFib3J0IGFuZCBU
T1MgYWxyZWFkeSBsYXVuY2hlZC4NCj4gPiAtICAgICAgICAqLw0KPiA+IC0gICAgICAgaWYgKGFk
ZXYtPmZsYWdzICYgQU1EX0lTX0FQVSAmJiBhZGV2LT5pbl9zMyAmJg0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgICFhZGV2LT5zdXNwZW5kX2NvbXBsZXRlICYmDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgc29sX3JlZykNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+
ID4gLQ0KPiA+IC0gICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+IC19DQo+ID4gLQ0KPiA+ICBzdGF0
aWMgaW50IHNvYzE1X2NvbW1vbl9yZXN1bWUodm9pZCAqaGFuZGxlKSAgew0KPiA+ICAgICAgICAg
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5k
bGU7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
