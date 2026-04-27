Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39878FF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0B810E174;
	Mon, 27 Apr 2026 08:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F2Z20S45";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E5710E174
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE+FxX/LxPyxAWByvsHwDU2gf4WaDXkrWr+PABNUMXgUXUIE+JGZ+O46pxi3vMB/Dp5tlSSeF828GeouhTG+J+fmBEmGkoajoUSf7Aj4LJoEgTlDDAkfkIzRfjBqVgYnNkv2VBITVML6DEZQ/7rtROSwR3OLd4vYWH4dYqK80wbuk71wy1BvA3SL8/S5D2OjtVKxMQi8i6L06l/gjZiryT6h+l7XYJ0KUO6k0zmwLPC/FR+p9ctv3HkNl6lkMvdp9JogsUBSaw8gWLu61w5Revhv+oP253WW/dUzCVRsOCHT84LxWv5YeWdI+QcCXfGkszNTAHplsuAVV0iSNSLyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjOfTJjqkmfhOSNA9SxAIOFciBecf7wsBSvnuOdc+YA=;
 b=ZGmncPbzOQoMClB7ZEJwN5zrT2oCWxqsX0n3R548RjIPYKkmGSDkzDmjUrTabABj1AeT1NREhSn6/azS07j1WZ8sHjuG220QDY6ANKRXahPg56Vc6PByR9RRKEYRoh6t+M/keSGPnwYEVQnmf9IUvy3Wu4BCLXBZwzQPDaZMjYLyrx7nIbvsy45oQh7wQtBLUTMEW3iifK19HenBAyWtj+wAQIFH9paaTyLSkbic6CRrTkcnJCU/uRYaMa9we6Yxc3OZ6rSDF+dulNHfKufzeT+ZrDaTtYMqlXN4xoV7c377w+R6bWZVSUgxlWBdeJIHvpfUKcX7hxXFfzAiAiSWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjOfTJjqkmfhOSNA9SxAIOFciBecf7wsBSvnuOdc+YA=;
 b=F2Z20S45y6YY3q5rTg43Pi+ITIpvTn3GjPRgewUnu1UKV3cjyoa48aHu4E13lT2gOQkEomuTxNDmvQBpuQ/v87qiAoIYIIsKO7ovxANZw1Q3P3YN6kehY5fOFIonNX7w/n4ZIFirEOw3flur6YjGoz0aTkatG61E+AQ+PP3tXNk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 08:33:39 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 08:33:39 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 05/10] drm/amdgpu: add AMDGPU_INFO_SDMA_USERQ_DOORBELL
 ioctl
Thread-Topic: [PATCH 05/10] drm/amdgpu: add AMDGPU_INFO_SDMA_USERQ_DOORBELL
 ioctl
Thread-Index: AQHc08M6KwE4lPUrOEi0HqFlsWR1ObXt4UqAgABTVYCAAAF4AIAEYw2w
Date: Mon, 27 Apr 2026 08:33:38 +0000
Message-ID: <DM4PR12MB51528F0A47875A84FB684E3FE3362@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
 <20260424081955.873090-5-Jesse.Zhang@amd.com>
 <ffd8867b-50b8-4f67-a21c-45dfd24a2ae9@amd.com>
 <CADnq5_OEraKrwjzsdacO0W4UGEJ6eszv5+S+Fk=asVJUgdBxRw@mail.gmail.com>
 <CADnq5_PWxC5RcxfH58g+HTREzwiwFX6_UfTuz-ze2rxFgDi7Rg@mail.gmail.com>
In-Reply-To: <CADnq5_PWxC5RcxfH58g+HTREzwiwFX6_UfTuz-ze2rxFgDi7Rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-27T08:32:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB8201:EE_
x-ms-office365-filtering-correlation-id: e574ea51-91cc-4560-8d41-08dea437ae8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: iO669R0ajUaLAhZv7bbHSCD5TcFjwJQPzHzok9MHhz11dQ4tSlzRItpHCUCUZhbAFBsrxjBqzjENZS7f2DFyX61TehGO1gAmkcLy/AA6FE1ySEoOEUrPkBqgF41TyrywxiA6O1QqMJyZZzhuVLPJpjglwUxJlVEIUeOzt08rNsKXHFcFZA+mKk3vsQDQq6N91ikD70A6ktZoTP/nVMg9+r67wvFf5ZbHkKRtmB/vHT300MN2YgRBTKEoErITQZqSP1LmRN1nzkeR1A4zj/BJKBSgUSTO7L15mR2F4Ks9dZYC9B/dFnqlffKFHJpC9bxbiC7tM/92vOzJgOFFawUDfj/Hvy31FJ3PVW4fR7Fj2OJkIM7FPuraD9mwHGhZMLliIVlakWyizixea+dj5M1CkG9J7v7RPpdKv7p8ah+BeTlwP/d0mInWgXMYMzmxwBeRpIKEk1QRlWeGKeWvpb5Aw+v3qVQbclHUoeyUsU8aCDhOkul/SSaimxnvoEKgx5+inFegdHqGKKXvL2sv8uOjlBS2SO56gYlEATliODmzqjRhBs28m695xP9zif0o9YeHvX4qjjiYRrx5xN7KY5iynMCF6rUjhS3QJpTchFSS/HSd27iWkHgE7BPdtbsKAfMRfHMTZdclFvobe/DTaLIfQPbCaz2IvFVkHyeNYebjUL7kyM0yuHX8OuTvzSNU+GX/2oc4JoODW6DRzpm9CH8NtYNnIdEl3GAL/k/VQCJZ1jkz4NO+Csm9NPGYtl4HEBLY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU1GSjh6SjVPNEJnb2lmOENDSU1ZOEpHaHFsSTE1akZTd0paUXFmNTlHajhl?=
 =?utf-8?B?Q045OUNxOG1ra2MxYW1JOG83aGYrL3NrK0o5QTJBb0VrNGY4SUpyU3VOZElq?=
 =?utf-8?B?VEJYVml4TFRUaXQ3ckp4NTd1d1FZOHVSTHk3cjZVUkkwYzkvWXpqNG5jT2I1?=
 =?utf-8?B?TmNiNU9oNGhhbmQyQlljdUdobG5BL3BYQXRZLzRXWmVOL042bTRoOWtvQlpx?=
 =?utf-8?B?VmRDL2hOV1BjWE9wYW80UjU1Wjc4VGZxOWlHMGV5THpuUkpDbHRFZTUraGJr?=
 =?utf-8?B?MjR1UGFoQmRtRGpzaEdhMTEyOHI5VnB3Mk5IVDl0LytYYTMyRjJyYU1zUnZC?=
 =?utf-8?B?bitBYmJzanQyT1Q5b2Z0NVN6YjlxQnpxME5mT1phVGRXL2dPZkl5RGFWZTBE?=
 =?utf-8?B?RVlWLzNCb2JqczQ5MG1JQjhvY2RsaEZrK1ZjaTU1NXBLb0xxSEkxcDJVT3BD?=
 =?utf-8?B?dDRRNmVQdnJiVWtvc2g5YXMzdW10QWo5TkMvSUxFdWE1YjJoREJIdHJyUElV?=
 =?utf-8?B?S2Yyc3RxNnVHNXQzNENVNGRMWGJCZDYwRmZnTW9jR2tObG5HcXZaR3liY3JM?=
 =?utf-8?B?cllvbjNpMHR4MmNNSFI3NlBjQ29JcHY0K3N6Y1djWEk3aU51VzBqOUtZaW1C?=
 =?utf-8?B?MlNRTWVVN0FPMjZXbkRHS0g0ZFIrN2dDQjlmcTZSVlNoWmUwMUhPNERUcEk5?=
 =?utf-8?B?b2M5bUZ4RnpveHltM1pjWURTT3FvZWdMdU9IL01keFEvV3pIbk5MNkl0dGFF?=
 =?utf-8?B?ck5NWnFLTDdGQnpUMEY4UUtrOU9mc25KNTgrMitveUpwTWY0a04wdGVBOHBX?=
 =?utf-8?B?T2xwQUVPdzcxUXhpSmNiOTQzQ3pmWjcrcXBoV0hFRzdXUHljTUQ1WU96Y1Ro?=
 =?utf-8?B?TnF6ME11U0NRT3RtaVlia3hnQ3NheVJZVHpWTE9iN0JoQVl4WUI2bEp0OGRK?=
 =?utf-8?B?RS9ObHZ3VDlvK1FFZVFPdmtWbC9oZlNIRWg0Tng2VjBjVXpseFBQaGZrNEEy?=
 =?utf-8?B?SzZkVUNsWDBnNWRJZ1kzTHpRc0lkWUVXWUk4L3Q1NHdub0NUMEd2cVFjNStM?=
 =?utf-8?B?Yk5EY2RhY1JLcTA3VkFZSzBDdVdaOVV0NXBkOW9QUGx3YUVhNngrRGlkSnpx?=
 =?utf-8?B?cWVXakpOQjZaNzRCYzVFNW5VZUNRV3BtR2IvRDVYTVFQMmxKVmpVUEplcUNM?=
 =?utf-8?B?YUljdkdrOS9JM2wzUlM1bUplNnFyUUF0WHkvOWd4K3FFZlR3VkxnSE9KcGVP?=
 =?utf-8?B?MEI2emVtN1l2ZlU0aTR5UDdZU0VhTW4rS3VZUjc3bE1Mb0RQMGZiU0FKVnRp?=
 =?utf-8?B?d2t6bTdZSlhPN09oMGdsWDluYzY0a05zQ09DQVI1U2ZIYndONjNaWVgremJ1?=
 =?utf-8?B?dGEyRFVVVjRwOGlFSnZIS3dLTGs1MDdKaWdQMzI4ZWc1VnEvVXdaKytJcjUv?=
 =?utf-8?B?ZHRSV3ZXNHVIbzdvQWZFdnNsM0hWWk5XUzRHUEVnV2VBa2NGbVhlRm1DN0dO?=
 =?utf-8?B?TFlmb3RMRlE1ZmVFaEZWcEZvcm9DWlhITk9CeDJlRTk2S3lBY1VaK2ovSzZj?=
 =?utf-8?B?SW1QTFpSaEZXNFZxRkxzb29rVjEvSkQwYWVPb1dzNDNOQ2htL1l6L2xybjR4?=
 =?utf-8?B?VkNBN1kzTEh6bS93NWF5MG1WVFN0aHZINGlzZXRpcjE1SFY4enBaNUUvNXJ6?=
 =?utf-8?B?VERiMWJ0L2lQL0x5Y3ZBUmxKblVxYWdDV3c5NHRFdTE3MnRNekUxcnBiV0VD?=
 =?utf-8?B?NU51TzdwUkIrODY3WkZUY2lRdUhXcWdEeFhCemRvM1J5bGVNc0tieDBuYktm?=
 =?utf-8?B?SnNCdVBKMGhWM0VzQ2JnNXlXakxFa1J2dU91WWI3WVJTd0xtTFJaRjJLOEp0?=
 =?utf-8?B?OEx6Zjg3MllIMmlid0Q4OGZpQWQxTDRkanQyak45OUlBS2MxOVRCWkxlTytw?=
 =?utf-8?B?b1l3OTcrUC9MQ0NpcmdoOEJMTnQ2eHQzVnF4VWNBd3E0WHBnSG5ic2pLYVRZ?=
 =?utf-8?B?bXRHNnhMK0NxNVByZmVXQnFjMGQ3MkJsUUxodTJhYWJ3RGZuSTc0d0FGOEpp?=
 =?utf-8?B?ayt5SkFkajRjLy9PUTB6eXFWRmJIVmZFdE9PTkJwL0k2M3dDaE90QU4zZGwx?=
 =?utf-8?B?cVNTNmNrQnRDdVpBa1poWklrZTBVZFRyeEVwOFdoaTdjc2lXNGVNZVZVQUx1?=
 =?utf-8?B?aFF4dXNuTFh0UDBDN3lrMVo0MVhidzlDNzI5TjNqLzRpblR1TVc1QjRmbmFw?=
 =?utf-8?B?LzRpamxhNlhHZG5MOWhDbE1EZitDQXpZTE9qdWh4Si9DT1NwVUY4WFhtZW5Q?=
 =?utf-8?Q?ltg5vjbZqy4Z6/zxn2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e574ea51-91cc-4560-8d41-08dea437ae8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 08:33:39.1527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8F5hNTjVu7GE8HzheccZlDnhWGuBQD257YHjAXnTXAIrDtVV7ZiK+1cHEX8U6GtyFlAgbsZ/fzp7tlYOCuvR+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAy
NCwgMjAyNiA5OjMzIFBNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5p
Z0BhbWQuY29tPg0KPiBDYzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+
OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsNCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDA1LzEwXSBk
cm0vYW1kZ3B1OiBhZGQNCj4gQU1ER1BVX0lORk9fU0RNQV9VU0VSUV9ET09SQkVMTCBpb2N0bA0K
Pg0KPiBPbiBGcmksIEFwciAyNCwgMjAyNiBhdCA5OjI34oCvQU0gQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gRnJpLCBBcHIgMjQsIDIwMjYg
YXQgNDozOeKAr0FNIENocmlzdGlhbiBLw7ZuaWcNCj4gPiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiA0LzI0LzI2IDEwOjE4LCBKZXNzZSBaaGFuZyB3
cm90ZToNCj4gPiA+ID4gRnJvbTogIkplc3NlLnpoYW5nIiA8SmVzc2UuemhhbmdAYW1kLmNvbT4N
Cj4gPiA+ID4NCj4gPiA+ID4gTmV3IEFNREdQVV9JTkZPIHF1ZXJ5IHRoYXQgcmV0dXJucyBhIHBl
ci1mcHJpdiBHRU0gaGFuZGxlIGZvciB0aGUNCj4gPiA+ID4ga2VybmVsLW93bmVkIEJPIGJhY2tp
bmcgdGhlIFNETUEgVU1RIGRvb3JiZWxsIHdpbmRvdywgcGx1cyBpdHMgc2l6ZS4NCj4gPiA+ID4g
VXNlcnNwYWNlIG1tYXAoKXMgdGhhdCBoYW5kbGUgdGhyb3VnaCB0aGUgc3RhbmRhcmQNCj4gPiA+
ID4gQU1ER1BVX0dFTV9PUF9NTUFQIC8gbW1hcCgpIGZsb3cgdG8gb2J0YWluIGEgQ1BVIHBvaW50
ZXIgdG8gdGhlDQo+ID4gPiA+IHJvdXRhYmxlIGRvb3JiZWxsIEJBUiB3aW5kb3c7IGVhY2ggY3Jl
YXRlZCBTRE1BIHVzZXJtb2RlIHF1ZXVlJ3MNCj4gPiA+ID4gcXdvcmQtc2xvdCBvZmZzZXQgaW5z
aWRlIHRoYXQgbWFwcGluZyBpcyByZXBvcnRlZCBpbg0KPiA+ID4gPiBkcm1fYW1kZ3B1X3VzZXJx
X291dC5zZG1hX2Rvb3JiZWxsX29mZnNldF9ieXRlcy4NCj4gPiA+DQo+ID4gPiBXZSBhZGRlZCB0
aGUgc2VwYXJhdGUgSU9DVEwgZm9yIHRoaXMgcHVycG9zZSBvbiB0aGUgS0ZEL0tHRCB1bmlmaWNh
dGlvbg0KPiBicmFuY2guIEkgdGhpbmsgd2Ugc2hvdWxkIGp1c3QgY2hlcnJ5IHBpY2sgdGhhdCBv
dmVyIHRvIGFtZC1zdGFnaW5nLWRybS1uZXh0Lg0KPiA+ID4NCj4gPiA+IEBBbGV4IHdoYXQgZG8g
eW91IHRoaW5rPw0KPiA+DQo+ID4gWWVzLCB3ZSBhbHJlYWR5IGhhdmUgYSBwYXRjaCBmb3IgdGhp
cyBhbmQgYW5vdGhlciBmaXggZm9yIGNvbXB1dGUNCj4gPiBxdWV1ZXMgaW4gdGhlIHVuaWZpY2F0
aW9uIGJyYW5jaC4gIFdlIHdlcmUganVzdCB3YWl0aW5nIG9uIG1lc2EgdG8NCj4gPiBtYWtlIHVz
ZSBvZiBpdC4NCj4NCj4gSXQgbWFrZXMgc2Vuc2UgdG8gbGFuZCB0aG9zZSBwYXRjaGVzLCBidXQg
dGhlIGRvb3JiZWxsIG9mZnNldCBzdHVmZiBpcyBwYXJ0IG9mIERhdmlkJ3MNCj4gVkNOIHVzZXIg
cXVldWUgcGF0Y2ggc2V0LiAgU2VlOg0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9h
cmNoaXZlcy9hbWQtZ2Z4LzIwMjYtRmVicnVhcnkvMTM4NjE5Lmh0bWwNCg0KVGhhbmtzIGZvciB0
aGUgcmVtaW5kZXIsIEFsZXguIEkgd2lsbCB1cGRhdGUgdGhlIHBhdGNoLg0KDQpUaGFua3MNCkpl
c3NlLg0KPg0KPiBBbGV4DQo+DQo+ID4NCj4gPiBBbGV4DQo+ID4NCj4gPiA+DQo+ID4gPiBSZWdh
cmRzLA0KPiA+ID4gQ2hyaXN0aWFuLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgMTMgKysrKysr
KysrKysrKw0KPiA+ID4gPiAgaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggICAgICAgICAg
IHwgMTYgKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNl
cnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4gPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfa21zLmMNCj4gPiA+ID4gaW5kZXggZDg4ZTQ5OTRjOGMxLi5kYmNmYmU0MThl
NDIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
a21zLmMNCj4gPiA+ID4gQEAgLTE0MjUsNiArMTQyNSwxOSBAQCBpbnQgYW1kZ3B1X2luZm9faW9j
dGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwNCj4gdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxl
ICpmaWxwKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+
ID4gPiA+ICAgICAgICAgICAgICAgfQ0KPiA+ID4gPiAgICAgICB9DQo+ID4gPiA+ICsgICAgIGNh
c2UgQU1ER1BVX0lORk9fU0RNQV9VU0VSUV9ET09SQkVMTDogew0KPiA+ID4gPiArICAgICAgICAg
ICAgIHN0cnVjdCBkcm1fYW1kZ3B1X2luZm9fc2RtYV91c2VycV9kb29yYmVsbCBkYl9pbmZvID0g
e307DQo+ID4gPiA+ICsgICAgICAgICAgICAgaW50IHI7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICByID0gYW1kZ3B1X3NkbWFfdXNlcnFfZG9vcmJlbGxfY3JlYXRlX2hhbmRsZShh
ZGV2LCBmaWxwLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZkYl9pbmZvLmhhbmRsZSwNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZGJfaW5m
by5zaXplX2J5dGVzKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICBpZiAocikNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiByOw0KPiA+ID4gPiArICAgICAgICAgICAgIHJldHVy
biBjb3B5X3RvX3VzZXIob3V0LCAmZGJfaW5mbywNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG1pbigoc2l6ZV90KXNpemUsIHNpemVvZihkYl9pbmZvKSkpDQo+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICA/IC1FRkFVTFQgOiAwOw0KPiA+ID4gPiArICAgICB9
DQo+ID4gPiA+ICAgICAgIGRlZmF1bHQ6DQo+ID4gPiA+ICAgICAgICAgICAgICAgRFJNX0RFQlVH
X0tNUygiSW52YWxpZCByZXF1ZXN0ICVkXG4iLCBpbmZvLT5xdWVyeSk7DQo+ID4gPiA+ICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Vh
cGkvZHJtL2FtZGdwdV9kcm0uaA0KPiA+ID4gPiBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2Ry
bS5oIGluZGV4IDc5ZThiYmRhMDQ2Yi4uNTMzYmU4YWQ4YTdlDQo+ID4gPiA+IDEwMDY0NA0KPiA+
ID4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaA0KPiA+ID4gPiArKysgYi9p
bmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaA0KPiA+ID4gPiBAQCAtMTI4MCw2ICsxMjgwLDIy
IEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2NzX2NodW5rX2NwX2dmeF9zaGFkb3cgew0KPiA+ID4gPiAg
I2RlZmluZSBBTURHUFVfSU5GT19HUFVWTV9GQVVMVCAgICAgICAgICAgICAgICAgICAgICAweDIz
DQo+ID4gPiA+ICAvKiBxdWVyeSBGVyBvYmplY3Qgc2l6ZSBhbmQgYWxpZ25tZW50ICovDQo+ID4g
PiA+ICAjZGVmaW5lIEFNREdQVV9JTkZPX1VRX0ZXX0FSRUFTICAgICAgICAgICAgICAgICAgICAg
IDB4MjQNCj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBTRE1BIHVzZXJtb2RlLXF1ZXVlIGRvb3Ji
ZWxsIHdpbmRvdyBxdWVyeS4gIFJldHVybnMgYQ0KPiA+ID4gPiArcGVyLWZwcml2IEdFTQ0KPiA+
ID4gPiArICogaGFuZGxlIGZvciBhIGtlcm5lbC1vd25lZCBCTyB0aGF0IGJhY2tzIHRoZSByb3V0
YWJsZSBTRE1BDQo+ID4gPiA+ICtkb29yYmVsbA0KPiA+ID4gPiArICogd2luZG93LCBwbHVzIGl0
cyBieXRlIHNpemUuICBVc2Vyc3BhY2UgbW1hcCgpcyB0aGUgQk8gdmlhIHRoZQ0KPiA+ID4gPiAr
c3RhbmRhcmQNCj4gPiA+ID4gKyAqIEFNREdQVV9HRU1fT1BfTU1BUCAvIG1tYXAoKSBmbG93IHRv
IGdldCBhIENQVSBwb2ludGVyOyBlYWNoDQo+ID4gPiA+ICtjcmVhdGVkDQo+ID4gPiA+ICsgKiBT
RE1BIHVzZXJtb2RlIHF1ZXVlJ3Mgc2xvdCBvZmZzZXQgaW5zaWRlIHRoYXQgbWFwcGluZyBpcw0K
PiA+ID4gPiArcmV0dXJuZWQgaW4NCj4gPiA+ID4gKyAqIGRybV9hbWRncHVfdXNlcnFfb3V0LnNk
bWFfZG9vcmJlbGxfb2Zmc2V0X2J5dGVzLg0KPiA+ID4gPiArICovDQo+ID4gPiA+ICsjZGVmaW5l
IEFNREdQVV9JTkZPX1NETUFfVVNFUlFfRE9PUkJFTEwgICAgICAgICAgICAgIDB4MjUNCj4gPiA+
ID4gKw0KPiA+ID4gPiArc3RydWN0IGRybV9hbWRncHVfaW5mb19zZG1hX3VzZXJxX2Rvb3JiZWxs
IHsNCj4gPiA+ID4gKyAgICAgLyogUGVyLWZwcml2IEdFTSBoYW5kbGUgZm9yIHRoZSBTRE1BIFVN
USBkb29yYmVsbCBCTy4gKi8NCj4gPiA+ID4gKyAgICAgX191MzIgaGFuZGxlOw0KPiA+ID4gPiAr
ICAgICAvKiBCeXRlIHNpemUgb2YgdGhlIEJPICg9PSBtbWFwcGFibGUgd2luZG93IHNpemUpLiAq
Lw0KPiA+ID4gPiArICAgICBfX3UzMiBzaXplX2J5dGVzOw0KPiA+ID4gPiArfTsNCj4gPiA+ID4N
Cj4gPiA+ID4gICNkZWZpbmUgQU1ER1BVX0lORk9fTU1SX1NFX0lOREVYX1NISUZUICAgICAgIDAN
Cj4gPiA+ID4gICNkZWZpbmUgQU1ER1BVX0lORk9fTU1SX1NFX0lOREVYX01BU0sgICAgICAgIDB4
ZmYNCj4gPiA+DQo=
