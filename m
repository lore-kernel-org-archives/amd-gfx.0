Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5700C48BC4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 06:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6D610E086;
	Tue, 20 Feb 2024 06:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oROmwKus";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F4A10E086
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 06:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqz2ar3CNN9gH0Kk4fQVGE11ECv6nxgkRxbxY2sFHY/3cKkqEim2BkB+j0Dw3HIQshypMh8++qr/mAu9aK0uhv7F7q0JPFRMJTAm0UoERzHyw3QjIoMqv8AzTfK52qsJe3vOfhCg463f30qAWeurcBVdao2+tBhobdeC68TJNEaaBShkGHVNGNUJqaoZeUenZmTuRZQvspKZWzo6qC3wk2znaWNFqNGvGXdkao9DSfqivm16TruSI4Lmof1KxM37HqtNLLk26HL5GAJr+cegl9btVYBApdmPpfP31dOcXyjcfW6Gh2kqiL/Vtt1+hWYYJgsS0iPClrTC8BjaiFRHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQuMBEXXsYvkDYeCg6CuNuzHVHEWtAsubRNYZXfKIAE=;
 b=Cg7kCnCDgH19dIglX0f/0Drdyf4ydJyXpjHObC2q+4jL+JLadx8fbqzFzGzI3ScJBlXLXKYDU+gDDvSV0y+5aZ4ifo8flbtxHc4RXC8c8HPJNJ0OZE14EZiv2ZofozX/xaYndcDr0yzUc4VhIUmMeXOY//zjrIucF57Sjyrb64ulrxzkSQHJG3NGjgaNbx1FSYz5FdChYmFZ5TLG/8eSVOQQwzUw8FGdAjQWYvA6Y7tDLXE71bMNJokmeMeFdeT6Gcsx4cisUMqFmxNXss9PF8m8JVD213N9xr8fSg1VhXBtNDm8wbrcN1m7pi7eGZXgGpMsiOZLzKl+q+abmy+23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQuMBEXXsYvkDYeCg6CuNuzHVHEWtAsubRNYZXfKIAE=;
 b=oROmwKusWWki+nlLuNLuuMtv5Tlj4UHRMNFjSoNyQrw78/8TrRqbvfeOcv2eOn3pyEgMgdoeHG1asq2N+vCPxuyu6McgycB0qm9Shpn7kWM9zG2Yrbx+yg7AQqLYa9BYT5ygADwfKkbLgl69bv8ptzHAttvTo0o6M+otwoZyeTo=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 06:23:07 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 06:23:06 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: skip GFX FED error in page fault handling
Thread-Topic: [PATCH 5/5] drm/amdgpu: skip GFX FED error in page fault handling
Thread-Index: AQHaYwvTVcrFCBmHhECbbE+Uyh+01rERm4MAgAEmRBA=
Date: Tue, 20 Feb 2024 06:23:06 +0000
Message-ID: <PH7PR12MB8796051F4BDA5FB691461D18B0502@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240219081520.316064-1-tao.zhou1@amd.com>
 <20240219081520.316064-5-tao.zhou1@amd.com>
 <fe223d29-27ad-464d-bd4e-70ec89695d2e@amd.com>
In-Reply-To: <fe223d29-27ad-464d-bd4e-70ec89695d2e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d54deb8c-830f-4c67-84d7-c1d445108d1d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-20T06:13:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|LV8PR12MB9230:EE_
x-ms-office365-filtering-correlation-id: 90ee2e02-43dd-4042-81a2-08dc31dc66ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GUq5nzWRIz4XgNnV14vIeiYuGtWxurAm+Srk7M/J2LHXkt9zU7mmZTjFALpxPzTzGTs3TQOJeOba39CoIPOK3HIONROhL+xvHqD9IhVSKrwqoGm7T5Pp+vLmKxdXF7xJHzY8mqy1J2i+xNW5RXGdqNtc9mrL017xTc5nL2p9K4aimiPQxDYj7O4WxHfXEiJsEEABeTw0ysv03ASpP0/v6+RXOFvYjZDbQTW//1jtRR/dtS/6tdG+sd7eh42xTxoij4rIadwkUCc1ys+7gv1iyd1/7hrvaO4/Ke7TqMwIPnnkfUuDIxlNa5cQbJiAhYdtzDmCojOAHvUD1wASS+XRQzH/oeJCkIzqkrUgRAMQGT8p09BAmhCYZeO5XYE5c1EVpHTIkgAJfgd783w9dKcqrxlc3UdN/6rFg4pQPc67oCJ7R+hiMJKzDK6MURTGQtaxAiopc5ww+aZCVbOeCJ4/PCKiuuMliYQFVaAOgphGAfVi5Wofrat+nuy3FDS4oP28MkMA0Te5BXzA4PGbTEKq34mFypdDvVQT/D4csu+RmU6sEyo2qZnKBhgniWqbFSQg/IU5lt8v7mqnVLlDGF+bFFmDRkl1OKAVGagYBeACdlcgmjllZsHz4bCKE0ayQGaK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnZrTGNIOWU3Mmt5VkJsbFpacEhVUTVwR3NFYVd4VXQ1cVNUdTlxcnZrZ3VO?=
 =?utf-8?B?b0V0dEVxSUlBVi9KR1dCQVZHa29KaG1jdkFXMEJ0dTduQnhQeXhwRTJUMkpC?=
 =?utf-8?B?akx0MnA1VUhseXZrMGZrUHd2c1dwUC8wMVYxUk1YQWlmeXhXcHNRazhhczI1?=
 =?utf-8?B?NjdySHZTQ2dmY1JCeGtFYkljL3NwcjRGOGVzQTMwTFQwWHAyMFhONXpTSG5T?=
 =?utf-8?B?UlJqWXhJNzN1eEpqZW9uK2lVUDVlRmxSYTI2RW42elViemU0eFM4ajAwbDVF?=
 =?utf-8?B?SlI5aHZlenlmMHhCUWFHQWtuMnZVOFJNeTF3WUhCSWNPUS9wSVZDR3FIa3Zh?=
 =?utf-8?B?NlYxeG56dTZkZmFqVVBsMjBSMW85bmN4Ykl2NS9qSjdoVlg3d05YQUlaencr?=
 =?utf-8?B?Tk9RUHhIMndSRVJ3MGN2QmFIMHVwOHNoUHpXSkhSdHUvckkwQVIxTEtXT09a?=
 =?utf-8?B?dVIzdTIzSVM1bG12WGE5NDdBTnhFTUx5bHJpdXY1L2xmOTJUR3o3bk1nV3pH?=
 =?utf-8?B?WSs0bE5uZm5DVjNUWWlDRkk1NU5EWFpiR1RuSWtiU0xucmMyVnZnMGNnbW5h?=
 =?utf-8?B?QlRZNDlZU1ZzU3N0L3A5NUNSMmNEUi9sQ0RLa3ozN3Q5KzFSRHliN2RvOWx2?=
 =?utf-8?B?a3RyUUxlTzJiZkh3cDJZNHA4UlJRaCsyVEt1cVdOcUhjSUhyTW10c09UYytz?=
 =?utf-8?B?TXloNGlkWStQN2M4ais3VnF2aWE0cmZxeEZJVVRuTHQxbmVOTXRoVFRNeGN0?=
 =?utf-8?B?K1lVbjh0U1VBQ25YNlhYR3Y4dUJwaE5zNXMySlBvSWhjcm1uS3gvd3F4cDVH?=
 =?utf-8?B?M1VMMXJjQ0ltdkY1U09YbVhzSnFIUndZR1RiMSs1UiszekQ0OFdCS2FzNzUy?=
 =?utf-8?B?Yk11SGdKVWkwTTMwMGl2VXduS0EwMDYxTnhheFNCaHZqcnZ0eElLaDhFY3pa?=
 =?utf-8?B?UG5VV3hSOUpPY2RqcGJJM1VRSXpOTGp0Y21OWTZHaHRhQjVoVnhpbDFEdUln?=
 =?utf-8?B?Ri8rY3ozeE4zUFhMaVV5VmtvWEVMWlBDS0FPc2pwNVVreTRpUVl2VTd0UUl6?=
 =?utf-8?B?WmtQcG1QdjBEVXYyMUtoaG90YWxYVU8ybEI1U282TnN6NThFMFNTZGhJZFlX?=
 =?utf-8?B?ejhhcWY3MElHNm0yamNPVGVZZ0ZicTZaYk5lZGxvMG05RUVtVi9nckpPdnFp?=
 =?utf-8?B?UGtScXFaYTNUM0N1ZXlhT1FLT0ljTGZybWFWTHcrbERlM2VXMDA3UEl6NU13?=
 =?utf-8?B?L2l0dXg0djhqUFdvcytHQzAzOXBoOXFQYVpZdEN3dzRjL24wNzcxWTJWdXN1?=
 =?utf-8?B?L2srV0d4S3Z3ZlB5cnpWaHI0NDV3MGlIeXpFNU85ajZMRkZGYkN0Qyt4Vnk3?=
 =?utf-8?B?eDEyWXh1eDVZNnNvS3NES1VHK1ZSYUMyYnloVFlsdXhOaGpFQ1EyMUFNaGxC?=
 =?utf-8?B?dXRGNmE2S1dWcHBqSlB6ditxdmNONjVNMGdrYW9DY0d3cy9ZdlZmVHhHeGta?=
 =?utf-8?B?MktmYWpwTlBqcmFNTHVXWndMS3k3TnQwVjRaVUxqYUxLbHMyZUhkOWFKSG1u?=
 =?utf-8?B?MXY4ajdHUnNkUVFOU1RKQyswRkdxMmN1SjV1M1ZlUXRhTldYYk1XNVl1SjJz?=
 =?utf-8?B?MWZRaVU4dkhHZWxQL1dmY05PcnpLN29xZFc4VTJnYlRxRmNid1hlc2hDM011?=
 =?utf-8?B?eTBGTlE0UjczMGZ2R3NhOXVqbGJHQlJSdjc0d0YySkVUY2FsUWN2SXlMd0VZ?=
 =?utf-8?B?b0FybS9qakJzRk1seUszM29pYWwrb2lnMkNpUGhST2dML2J3bzBqei9lT3Va?=
 =?utf-8?B?OGNNNnhGSUtKYTJja0F1NU5yU2VOQTUxMS9TSjVqZW1ZREkwdTVtVURXT1l4?=
 =?utf-8?B?bWdVbXNvRlhXTjhwZE9RYXhnSUNLUld5REhUYmJacGwwOW8vRW5vamRhTC8x?=
 =?utf-8?B?YUdFSDhzVnVIR1BOaG1jcTlxMTM4dzNaamJpQ2xGK2g0U1FNMnI5eUFRWjM1?=
 =?utf-8?B?QnBMZDhzRndEOEhnSWN6Rm94VDVFamtnUm5DM3h2L0hoVjBMMzk5d2d6M3gr?=
 =?utf-8?B?bTNSZ0Mwd1dVNXpXbmk4cEtiNjc2c2NPVE5ncHV6c1d4M2k5bEdkcHpNYlls?=
 =?utf-8?Q?CBY8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ee2e02-43dd-4042-81a2-08dc31dc66ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 06:23:06.5253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xwOpwlqJflTVjiUJuV9Pey2f+WZ9i1oRjNF4x0yNvlhm7U6uzyogJ1SMbww1v+9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBGZWJydWFyeSAxOSwgMjAyNCA4OjQwIFBNDQo+IFRvOiBaaG91MSwgVGFvIDxU
YW8uWmhvdTFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggNS81XSBkcm0vYW1kZ3B1OiBza2lwIEdGWCBGRUQgZXJyb3IgaW4gcGFn
ZSBmYXVsdCBoYW5kbGluZw0KPg0KPg0KPg0KPiBPbiAyLzE5LzIwMjQgMTo0NSBQTSwgVGFvIFpo
b3Ugd3JvdGU6DQo+ID4gTGV0IGtmZCBpbnRlcnJ1cHQgaGFuZGxlciBwcm9jZXNzIGl0Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgMTAgKysrKysr
KysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5
XzAuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiA+IGlu
ZGV4IDc3MzcyNWE5MmNmMS4uNzBkZWZjMzk0YjdiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+ID4gQEAgLTU1Miw3ICs1NTIsNyBAQCBzdGF0aWMgaW50
IGdtY192OV8wX3Byb2Nlc3NfaW50ZXJydXB0KHN0cnVjdA0KPiA+IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsICB7DQo+ID4gICAgIGJvb2wgcmV0cnlfZmF1bHQgPSAhIShlbnRyeS0+c3JjX2RhdGFbMV0g
JiAweDgwKTsNCj4gPiAgICAgYm9vbCB3cml0ZV9mYXVsdCA9ICEhKGVudHJ5LT5zcmNfZGF0YVsx
XSAmIDB4MjApOw0KPiA+IC0gICB1aW50MzJfdCBzdGF0dXMgPSAwLCBjaWQgPSAwLCBydyA9IDA7
DQo+ID4gKyAgIHVpbnQzMl90IHN0YXR1cyA9IDAsIGNpZCA9IDAsIHJ3ID0gMCwgZmVkID0gMDsN
Cj4gPiAgICAgc3RydWN0IGFtZGdwdV90YXNrX2luZm8gdGFza19pbmZvOw0KPiA+ICAgICBzdHJ1
Y3QgYW1kZ3B1X3ZtaHViICpodWI7DQo+ID4gICAgIGNvbnN0IGNoYXIgKm1taHViX2NpZDsNCj4g
PiBAQCAtNjYzLDYgKzY2MywxNCBAQCBzdGF0aWMgaW50IGdtY192OV8wX3Byb2Nlc3NfaW50ZXJy
dXB0KHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ICAgICBzdGF0dXMgPSBSUkVH
MzIoaHViLT52bV9sMl9wcm9fZmF1bHRfc3RhdHVzKTsNCj4gPiAgICAgY2lkID0gUkVHX0dFVF9G
SUVMRChzdGF0dXMsIFZNX0wyX1BST1RFQ1RJT05fRkFVTFRfU1RBVFVTLCBDSUQpOw0KPiA+ICAg
ICBydyA9IFJFR19HRVRfRklFTEQoc3RhdHVzLCBWTV9MMl9QUk9URUNUSU9OX0ZBVUxUX1NUQVRV
UywgUlcpOw0KPiA+ICsgICBmZWQgPSBSRUdfR0VUX0ZJRUxEKHN0YXR1cywgVk1fTDJfUFJPVEVD
VElPTl9GQVVMVF9TVEFUVVMsDQo+IEZFRCk7DQo+ID4gKw0KPiA+ICsgICAvKiBmb3IgZ2Z4IGZl
ZCBlcnJvciwga2ZkIHdpbGwgaGFuZGxlIGl0LCByZXR1cm4gZGlyZWN0bHkgKi8NCj4gPiArICAg
aWYgKGZlZCAmJiBhbWRncHVfcmFzX2lzX3BvaXNvbl9tb2RlX3N1cHBvcnRlZChhZGV2KSAmJg0K
PiA+ICsgICAgICAgYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgR0NfSFdJUCwgMCkgPj0gSVBfVkVS
U0lPTig5LCA0LCAyKSAmJg0KPiA+ICsgICAgICAgIXN0cmNtcChodWJfbmFtZSwgImdmeGh1YjAi
KSkNCj4gPiArICAgICAgICAgICByZXR1cm4gMTsNCj4NCj4gYW1kZ3B1X2lycV9kaXNwYXRjaCgp
IGdpdmVzIHRoZSBpbXByZXNzaW9uIHRoYXQgcmV0dXJuIHZhbHVlIG9mIDEgaXMgdHJlYXRlZCBh
cw0KPiBoYW5kbGVkLCBoZW5jZSB3b24ndCBiZSBwYXNzZWQgdG8ga2ZkLiBUaGUgY29tbWl0IGRl
c2NyaXB0aW9uIHNheXMgaXQgaXMgaW50ZW5kZWQNCj4gdG8gcGFzcyB0byBrZmQgZm9yIGhhbmRs
aW5nLg0KDQpbVGFvXSBnb29kIGNhdGNoLCBpdCBzaG91bGQgcmV0dXJuIDAgaGVyZSwgd2lsbCB1
cGRhdGUgaXQgaW4gdjIsIHRoYW5rcy4NCg0KPg0KPiBBbHNvLCBGRUQgc3RhdHVzIGNoZWNrIG1h
eSBiZSBtb3ZlZCB1cCBzbyB0aGF0IGl0J3Mgbm90IG1pc3VuZGVyc3Rvb2QgYXMgYQ0KPiByZWd1
bGFyIHBhZ2UgZmF1bHQgd2l0aCB0aGUgZXh0cmEgcHJpbnRzIGNvbWluZyB0byBkbWVzZyBsb2cu
DQo+IE90aGVyd2lzZSwgcG9pc29uIHN0YXR1cyBhbHNvIG5lZWRzIHRvIGJlIGFkZGVkIHRvIGRt
ZXNnLg0KDQpbVGFvXSB0aGVyZSBpcyBwb2lzb24gY29uc3VtcHRpb24gZG1lc2cgbG9nIGluIGtm
ZCBpbnRlcnJ1cHQgaGFuZGxlciwgbm8gbmVlZWQgdG8gYWRkIGV4dHJhIHByaW50IGhlcmUuDQpN
eSBpbnRlbnRpb24gaXMgdG8gc2tpcCAiIFdSRUczMl9QKGh1Yi0+dm1fbDJfcHJvX2ZhdWx0X2Nu
dGwsIDEsIH4xKSIsIG1vdmluZyB1cCB0aGUgY2hlY2sgd2lsbCBtYWtlIHRoZSBjaGFuZ2UgYSBs
aXR0bGUgYml0IG1vcmUgYW5kIEkgdGhpbmsgdGhlIHBhZ2UgZmF1bHQgbG9nIGlzIGFjY2VwdGFi
bGUuDQoNCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+ID4gKw0KPiA+ICAgICBXUkVHMzJfUCho
dWItPnZtX2wyX3Byb19mYXVsdF9jbnRsLCAxLCB+MSk7ICAjaWZkZWYNCj4gPiBIQVZFX1NUUlVD
VF9YQVJSQVkNCj4gPiAgICAgYW1kZ3B1X3ZtX3VwZGF0ZV9mYXVsdF9jYWNoZShhZGV2LCBlbnRy
eS0+cGFzaWQsIGFkZHIsIHN0YXR1cywNCj4gdm1odWIpOw0K
