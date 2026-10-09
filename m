Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8967CA6019
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 08:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8598710EA6C;
	Fri,  9 Oct 2026 08:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHBYOP8u";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AAA510EA6C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 08:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5I5nTnt+X8nxZOichvmSA06VFAJF3AcF4+whJgwxoIXGxGmQsmGoVf4cOpOlzxalJOHlcz7sD+bW6QxnniKJMv7g2f5/+OgLfYOQjbXSGI6Iu1nDM55sWnP5rd2zSKsTdVb7kr9aoWJoKV0+EUfAgeVVogoC4yXzeomMAfJtI8aiQzimEo8BgoosM40A0w0HZTe/FydCi3Xkq0Hf8mox+Dx22UJJwwrRpvKZn252SCPfC54iVT9Bs2bbSuulrabC7OZ7xi7QuplqL8lGpUKe/3HNm2wMs9YN9SJ9/YF1u1i2+oE09tNNaZ/r1zFLjpP5dtmIaZ9+HeK+j2bGtUngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ca6tPPlwixUxXH0yf6KIZ65HF6qIoNG7X1EM8jo+2o=;
 b=pn5HEwmjMP+mCeDtE2JbhSauufkZnbR1pJ15WnMgfdXsl03OM7HK0HfLyEfg4RKIx9qnYcyA+nDRoeZLB2eaNJVlCcShPG8T4BaQ1oSx5wOua07PuqX1mwyML4TMe2a25SR745ermIcgs+n79RWObousvO43UmUHB0Q2BpkteBbTaMbAX9Ib8ruHvcQL5dcO86rRl9UCKIxP37xJjatJSfisjwXIIq4D7ybZ2OKD2n3p3JCleoNXMSNEcmnEVANFCB6DACYc/u+gHJnieuT71P8GqIR16RZQZrV1Fo1vctqRZ4PKlZTAn4DVjPKmIELQ5cmhi1QS2wO8ux3hXCprmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ca6tPPlwixUxXH0yf6KIZ65HF6qIoNG7X1EM8jo+2o=;
 b=CHBYOP8ulyChk9yFMvYF7iDR8A7IaSl7Op5H3L01JXDFmZceUs3Pv+k8/dzczY+9Z3sG7BuMPxLSmo0wCXA/ysD6BNPpR2NlfuTtu6WHW1vQILplioqwslGLPQIA0Ddv5/Lzq10ErQGWsxKARUJVwhixh+9GoCzVr+wk7paBcvU=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by CH8PR12MB999206.namprd12.prod.outlook.com (2603:10b6:610:35a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 08:15:42 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 08:15:42 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
Thread-Topic: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
Thread-Index: AQHdT8U/OFtQTBjuH020GWqQmH3vt7bznoUAgAAEbACAAAA28IAA+tIAgAAVxYCAABTgAIAAGyKAgAAIZhA=
Date: Fri, 9 Oct 2026 08:15:42 +0000
Message-ID: <PH7PR12MB6000C7896A542FB05D41C194FB922@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-9-Prike.Liang@amd.com>
 <0375ebd0-df28-437c-b6b4-47f06d4d1a24@amd.com>
 <5ff3175a-a8fb-49d4-b40a-36ab460f8ca0@amd.com>
 <PH7PR12MB6000ADDBADE18139E2B7401BFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB600066077324CFC6B1BAA16FFB922@PH7PR12MB6000.namprd12.prod.outlook.com>
 <7f51bd62-7a74-4cbc-95d1-5c31d52fde31@amd.com>
 <PH7PR12MB60004BE15CAB1279EFDEBEC0FB922@PH7PR12MB6000.namprd12.prod.outlook.com>
 <1db03d2d-8f11-4b9b-875a-9b6d2c0fc4aa@amd.com>
In-Reply-To: <1db03d2d-8f11-4b9b-875a-9b6d2c0fc4aa@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-09T08:11:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|CH8PR12MB999206:EE_
x-ms-office365-filtering-correlation-id: 5dd42af6-d3ee-42c6-c1c5-08df25dd82c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: XM+yTRU8cSB9VFwDJ7n2YujdUqMS56Wj7BweZ85eZg8yKvG+juKzbCcQDjtrsELznojydqBirhGa56HXFpr+yjRNHEMYEViAN67BYdzcKJq4fMmea8CA0HOeJPeSo3X9DsoYNMI6NUzqJC4xMsibjY7DGDGEBvrwVYvmrHTKamPncm/82Bn9sjMwZllvQgYECjyPrkvOfmdUpN09nofD5HIaV7WJwm3mxlzMT1oholmj98FxTeMuaBeNk/pNIw4VBMrkaXITOvewtZ43lJp+GmuhSR6f5LXqhIWGZxqqLVoay+L+tBzJMQ+4eMS+vbALe3hFL+A/+A/9KtPHIH5kALWmybwRRtNZ+VSo2t/UxMF57h8U2vP17f3USO9n9IKXYFnQTfvbBQipeYYBzMfowhprea7GfEEfxLq2AQ48yJEfop5qCNVO8q+OXUoa1T9m3mBdqHf+pVbhtDm2PcY1pej74aaxdXKavukTJ4V8l7m6P6cjNNmJ0DOqGlqYs4czpPvxv1ffC9FWMOSdnRfRxt4oGSOiou2DOkavJRO3PYUvw6IkkOQnkOC7U8EEDsJhGrUPI+rEVjQZpW29U1hdUMXWRd2kY0ufIIXbm9lcAagBEBCe6x8bvRHu48oPCN4ua8F+hdlNcoD2s5nD5flU1KM8Fcm4L1ltfXjYQJM1MikXRMcmQ20EoahPAOmD7wZuZC10/yQpjE75SRIPSf/VBu5iRHGdG/M5rmEa/F89bPU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVlMbzBHSjE4ZG5pcWFVYW1WbGZsbDZsZTBvd1BhbHNZVDlBOEJZNWFJYUtL?=
 =?utf-8?B?ZEJUbXNGM0swKzVYSkdzQ0J5WUhxYmE4WXBUazUxMm5JdTl6SENqNTJrbjg3?=
 =?utf-8?B?Znc5SnAwOXZYOUJKblU5bU9wdVR6cHluNXVmR1IzSVF2bS9SczFkRk1rSG9n?=
 =?utf-8?B?V0Q4RStGaTZrekF4aUd6eTdXVk1BRFl0eWRTUDlkYlY5azk3RmJQU1pFb2to?=
 =?utf-8?B?SzRaU3FBZG1DMjgzWWxxTXJLS04xQ0ljbS9wYzNJWnNRalBKZndKK2ZUQnl6?=
 =?utf-8?B?RVY3LzQvRG14ZUdHdEllc2tuMDBROE5ZaEMwRGRNTnJqd1lZT2Nlc0VYY3dv?=
 =?utf-8?B?dHNHT3phcC9QaHRYSWVMZmJyYXhkN2Q0dERQNzlnZ3ZEOTdsd1ZWdEVhT044?=
 =?utf-8?B?Y0o1Mkw0QVNVSVFvM0RTR2U3Z2c3eW1SRGtTZFY4anZncHhtcGR1RWt2OVNl?=
 =?utf-8?B?aUFMUFpycG4xOUZTK0I0ajFTbytxdnI4bGg5dUtuR0dYNjk0ajlRZnNSNGk2?=
 =?utf-8?B?c2FkUlZ1TXNEYWxHUDdGeGJSallyVFNXeW9tMFFzNW9jN1pnZVZVT0J6aytt?=
 =?utf-8?B?TTVpazdJMjdJMkNHU09VM0hiL09WMkpNSmNDQVl0Z3VGOEUrVGp4MVBBalFG?=
 =?utf-8?B?MmU1eHpCcVFFYVYwWlk3allIaGJUSkFHbEJUQTlIUGJLRGNycFA2ci9wNDhF?=
 =?utf-8?B?TnhyNTNidnB0cHp3SG9FakFtd0t5Qi8weXdOVUFWWE9lckZnMWdLN0pnVml6?=
 =?utf-8?B?ZVZUOE9tQitYQ1lDMVZaVnFNanlwbjFTWVUrcFBSWk9iYmY5Vjc2MGxwNUpN?=
 =?utf-8?B?RkNlazVsOUI1U3IwQThwUTBVNlIyekhYQVRiOC92Y3ZBZ2ZLL3pkNnVWOVds?=
 =?utf-8?B?UmxWQ0IyOStaci9wRWdTcXY1RmM3MlJrUFlRdnB4QlNrVWdMdEhVVFU3UVNH?=
 =?utf-8?B?Z1hROERTV2YvVEMyWjRleDBsaEpMai9oNDV1OUNUUjRiaE1QOVhVQUl4S055?=
 =?utf-8?B?Z3ZXdHBUYlVDd1ZkUkJyL0FSeGZQZGVsZGh2TnJmbDJpN0lYMlJyTFZ0TzIw?=
 =?utf-8?B?Si9yUEdTYXhxa1pNQUJHM0pIQ0tKUjFRbHJaV3NPNlBZYUxsUFNweFVTNUlW?=
 =?utf-8?B?SG9veGkxcHdUc3dXclF0U3R5Y2pITzdQMUczVlFZbkZzVjFkL0FHSkN6SGRH?=
 =?utf-8?B?K2d1YzVKeVFOSjcyMTd2OXNyK0k3Y2h0OStqM2EvRjZ2Qm15NjRCRHEzcEIw?=
 =?utf-8?B?SFpMcVhoMC9OV1k5akhZaWgrZ0VyY1ZzMCs1aU1YaEhnM1NDKzhhZmwyQXdZ?=
 =?utf-8?B?Q1pXZW01UGpMTk50WWFpV2JzOVo2a052ZUh2K0tFYXBEZENrQmtRRkdkaHBp?=
 =?utf-8?B?RkNVTUJITWs4TkNvdzU2aFpDUkVBQzdlNEkxUW1ESEFIdzd1citoSDFDTEtp?=
 =?utf-8?B?RUJBS3l2TG1wbmlsOUh2WFFMaXRNbHRRV05ORk0va21LTjNVL2JWWHpDM3Zq?=
 =?utf-8?B?dDZSZjlSKyszc0w3WGd6dU5TbXlORCt6TnZLcDlTNFUrdExXVStUaFpMM0h3?=
 =?utf-8?B?UzhMZzQzN2dtT2xwR1ZTckI1UGNqVStycFVTTFV3Zm9zeWNMb3Rha1pHQitk?=
 =?utf-8?B?cG44MVJTeDJxd2tONExMYUFKNGsyTUtZM0VKdHp1aWtjV2s4V0Mrb0F0ZEI2?=
 =?utf-8?B?aWNsVXZzY0tuMDdsbFZIeS8xYjRBNC8wU0VXOC9HQjU2NnA1Ykg2NVcwbFBS?=
 =?utf-8?B?Q0prenZxUm04alNpL29CL0ZpaHZqbGVKdy9HOXFtK2twd295ZTlybXVxYVBj?=
 =?utf-8?B?Q04vSUV5UTE0QzFlWFdMUWI2TEJMMm1nbHgyRCtBRWM1cWtzNk1tQlBNOW5U?=
 =?utf-8?B?N3ZrajRMK3hiQkR1dlFHRGFlRzBxVUlYdjlHVjNueDZHVm1jbS82S2pDN2px?=
 =?utf-8?B?UDBDQ1RmNEliL0orMFB3M1Z4UkdScC93ZFlubTA1TTY3ejRmak8yeUp0bVdW?=
 =?utf-8?B?MEJNU2hHWU8vVE14MytUdUVEa1Q1RXphejlxTDBzOGhZSlYyeFZLTkdmRHdY?=
 =?utf-8?B?c1BaVHJrRGl5ZWdmNXVtN25ySGdiU2pWMG4vQ2dTQmlTcmxsTmxFSldTcVNE?=
 =?utf-8?B?YTNTeHVTYU90QTgxei9UcFZyT0o4emdFTDJPcmpTNkJPdXd4NFd2Qmw4WEEz?=
 =?utf-8?B?cGdSeDl1dGtXTk16Mm1Od1hISkdkMGthVWdldXJoMFhWMWF2UUhHajFtSUFp?=
 =?utf-8?B?ZXFUV2g2djA1Mm1UZlJNMWF4a0lJODZvSkF4cTRQaVZBZnRaZFUrRHpiSjFN?=
 =?utf-8?Q?iK+4Gy4iQQj11N8iyY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd42af6-d3ee-42c6-c1c5-08df25dd82c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 08:15:42.1173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXCdSjWMBxF1wZ5mtscqRyvkJSbW+v5f6/R2c/0tF5tmYKsPcKtzQkBp0uQOwHD2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999206
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDksIDIwMjYgMzo0MiBQTQ0KPiBUbzog
TGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8uTGF6
YXJAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUHJvc3lhaywgVml0
YWx5DQo+IDxWaXRhbHkuUHJvc3lha0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDA5LzE0XSBkcm0vYW1kZ3B1OiBkZWZlciBKUEVHIGFuZCBWQ04gaWRsZSB3b3JrIGFjcm9zcw0K
PiBHUFUgcmVzZXQNCj4NCj4gT24gMTAvOS8yNiAwODoxOSwgTGlhbmcsIFByaWtlIHdyb3RlOg0K
PiA+IEFNRCBHZW5lcmFsDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+ICAgICAgIFByaWtlDQo+ID4N
Cj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTGF6YXIsIExpam8g
PExpam8uTGF6YXJAYW1kLmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDksIDIwMjYg
MTI6NTAgUE0NCj4gPj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IEtv
ZW5pZywgQ2hyaXN0aWFuDQo+ID4+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUHJvc3lhaywgVml0YWx5DQo+ID4+IDxWaXRhbHkuUHJv
c3lha0BhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA5LzE0XSBkcm0vYW1k
Z3B1OiBkZWZlciBKUEVHIGFuZCBWQ04gaWRsZQ0KPiA+PiB3b3JrIGFjcm9zcyBHUFUgcmVzZXQN
Cj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gT24gMDktT2N0LTI2IDk6MTMgQU0sIExpYW5nLCBQcmlr
ZSB3cm90ZToNCj4gPj4+IEFNRCBHZW5lcmFsDQo+ID4+Pg0KPiA+Pj4gUmVnYXJkcywNCj4gPj4+
ICAgICAgICBQcmlrZQ0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+Pj4+IEZyb206IExpYW5nLCBQcmlrZQ0KPiA+Pj4+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVy
IDgsIDIwMjYgODo0MiBQTQ0KPiA+Pj4+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsgTGF6YXIsIExpam8NCj4gPj4+PiA8TGlqby5MYXphckBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4+PiBDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUHJvc3lhaywgVml0YWx5DQo+ID4+
Pj4gPFZpdGFseS5Qcm9zeWFrQGFtZC5jb20+DQo+ID4+Pj4gU3ViamVjdDogUkU6IFtQQVRDSCB2
MiAwOS8xNF0gZHJtL2FtZGdwdTogZGVmZXIgSlBFRyBhbmQgVkNOIGlkbGUNCj4gPj4+PiB3b3Jr
IGFjcm9zcyBHUFUgcmVzZXQNCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBSZWdhcmRz
LA0KPiA+Pj4+ICAgICAgICBQcmlrZQ0KPiA+Pj4+DQo+ID4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+Pj4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+DQo+ID4+Pj4+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDgsIDIwMjYgODoz
NCBQTQ0KPiA+Pj4+PiBUbzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IExpYW5n
LCBQcmlrZQ0KPiA+Pj4+PiA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC0gZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiA+Pj4+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgUHJvc3lhaywNCj4gPj4+Pj4gVml0YWx5IDxWaXRhbHkuUHJvc3lh
a0BhbWQuY29tPg0KPiA+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA5LzE0XSBkcm0vYW1k
Z3B1OiBkZWZlciBKUEVHIGFuZCBWQ04gaWRsZQ0KPiA+Pj4+PiB3b3JrIGFjcm9zcyBHUFUgcmVz
ZXQNCj4gPj4+Pj4NCj4gPj4+Pj4gT24gMTAvOC8yNiAxNDoxNywgTGF6YXIsIExpam8gd3JvdGU6
DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE9uIDI5LVNlcC0yNiA5OjE2IEFNLCBQcmlr
ZSBMaWFuZyB3cm90ZToNCj4gPj4+Pj4+PiBQcm90ZWN0IG1lZGlhIGlkbGUgd29ya2VycyB3aXRo
IGEgcmVzZXQtZG9tYWluIHJlYWQgdHJ5bG9jay4gT24NCj4gPj4+Pj4+PiBjb250ZW50aW9uLCBy
ZXF1ZXVlIHRoZSBpZGxlIHRpbWVvdXQgYW5kIHJldHVybiB3aXRob3V0IGhhcmR3YXJlDQo+ID4+
Pj4+Pj4gYWNjZXNzLiBLZWVwIHRoZSBvcmRpbmFyeSBlbmQtdXNlIHNjaGVkdWxpbmcgZXZlbnQs
IGluY2x1ZGluZw0KPiA+Pj4+Pj4+IGZyb20gcmVzZXQtdGltZSByaW5nIHRlc3RzLCBzbyBvdGhl
cndpc2UgaWRsZSBlbmdpbmVzIGV2ZW50dWFsbHkNCj4gPj4+Pj4+PiBwb3dlciBkb3duIGFuZCBW
Q04NCj4gPj4+Pj4gZHJvcHMgaXRzIHByb2ZpbGUuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBBIGJs
b2NraW5nIHJlYWQgYWNxdWlzaXRpb24gd291bGQgZGVhZGxvY2sgd2l0aCByZXNldC10aW1lDQo+
ID4+Pj4+Pj4gc3luY2hyb25vdXMgY2FuY2VsbGF0aW9uIG9mIHRoZXNlIHdvcmtlcnMsIHNvIHRo
ZSB3b3JrZXJzIG11c3QNCj4gPj4+Pj4+PiBvbmx5IHRyeSB0aGUNCj4gPj4+PiBsb2NrLg0KPiA+
Pj4+Pj4+DQo+ID4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5n
QGFtZC5jb20+DQo+ID4+Pj4+Pj4gLS0tDQo+ID4+Pj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2pwZWcuYyB8IDcgKysrKysrKw0KPiA+Pj4+Pj4+ICAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyAgfCA3ICsrKysrKysNCj4gPj4+Pj4+PiAg
ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5jDQo+
ID4+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5jDQo+ID4+
Pj4+Pj4gaW5kZXggOTg4N2E0Zjk5YWVkLi43YjEwMjYwYWQwZDQgMTAwNjQ0DQo+ID4+Pj4+Pj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuYw0KPiA+Pj4+Pj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMNCj4gPj4+Pj4+
PiBAQCAtMTE0LDYgKzExNCwxMiBAQCBzdGF0aWMgdm9pZA0KPiA+Pj4+Pj4+IGFtZGdwdV9qcGVn
X2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdA0KPiA+Pj4+Pj4+IHdvcmtfc3RydWN0ICp3b3JrKQ0K
PiA+Pj4+Pj4+ICAgICAgICB1bnNpZ25lZCBpbnQgZmVuY2VzID0gMDsNCj4gPj4+Pj4+PiAgICAg
ICAgdW5zaWduZWQgaW50IGksIGo7DQo+ID4+Pj4+Pj4gICAgKyAgICAvKiBSZXNldCBtYXkgY2Fu
Y2VsIHRoaXMgd29ya2VyIHN5bmNocm9ub3VzbHkgd2hpbGUgaG9sZGluZw0KPiA+Pj4+Pj4+IHRo
ZSB3cml0ZXIuICovDQo+ID4+Pj4+Pj4gKyAgICBpZiAoIWRvd25fcmVhZF90cnlsb2NrKCZhZGV2
LT5yZXNldF9kb21haW4tPnNlbSkpIHsNCj4gPj4+Pj4+PiArICAgICAgICBzY2hlZHVsZV9kZWxh
eWVkX3dvcmsoJmFkZXYtPmpwZWcuaWRsZV93b3JrLA0KPiA+Pj4+Pj4+ICtKUEVHX0lETEVfVElN
RU9VVCk7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSXMgdGhlcmUgYW55IG5lZWQgdG8gc2NoZWR1bGUg
dGhpcyB3b3JrIGhlcmU/IEJlaW5nIG5vdCBhYmxlIHRvDQo+ID4+Pj4+PiBnZXQgdGhlIGxvY2sN
Cj4gPj4+Pj4gaW5kaWNhdGVzIHRoYXQgYSByZXNldCBpcyBpbiBwcm9ncmVzcyBhbHJlYWR5Lg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBZZWFoIGFncmVlLiBXZSBzaG91bGQganVzdCBibG9jayBmb3IgdGhl
IEdQVSByZXNldCB0byBmaW5pc2guDQo+ID4+Pj4+DQo+ID4+Pj4+IFNvIGEgc2ltcGxlIGRvd25f
cmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pIHNob3VsZCBkbyBpdC4NCj4gPj4+Pg0KPiA+
Pj4+IFRoaXMgcGF0Y2ggd2FudHMgdG8gc2NoZWR1bGUgYSBkZWxheSBpZGxlIHdvcmsgZHVyaW5n
IHByb2Nlc3NpbmcgYQ0KPiA+Pj4+IGdwdSByZXNldCBwcm9jZXNzLCBhbmQgdGhlbiByZXRyeSB0
byBydW4gdGhlIFZDTiBpZGxlIGF0IHRoZSBuZXh0IHNjaGVkdWxlZA0KPiBsb29wLg0KPiA+Pj4N
Cj4gPj4+IEEgcG90ZW50aWFsIGRlYWRsb2NrIGNhbiBvY2N1ciBpZiB0aGUgVkNOL0pQRUcgaWRs
ZSB3b3JrZXIgcnVucw0KPiA+Pj4gZHVyaW5nIGEgR1BVDQo+ID4+IHJlc2V0IHdoaWxlIHBlcmZv
cm1pbmcgYSBibG9ja2luZyB3YWl0IGZvciB0aGUgcmVzZXQgdG8gY29tcGxldGUuDQo+ID4+IFRo
aXMgcGF0Y2ggcmVzb2x2ZXMgdGhlIGlzc3VlIGJ5IHVzaW5nIGEgcmV0cnktYmFzZWQgd2FpdCBv
biB0aGUgR1BVDQo+ID4+IHJlc2V0IHNlbWFwaG9yZSB3aXRoaW4gdGhlIGlkbGUgd29ya2VyIGNh
bGxiYWNrLg0KPiA+Pj4NCj4gPj4NCj4gPj4gVkNOIGlzIGdvaW5nIHRvIGJlIGlkbGUgYWZ0ZXIg
YSByZXNldC4gVGhlIG5leHQgaWRsZSB3b3JrZXIgd2lsbCBiZQ0KPiA+PiBzY2hlZHVsZWQgYWZ0
ZXIgYSBmcmVzaCBqb2Igc3VibWlzc2lvbiBpcyBjb21wbGV0ZS4gV2h5IHdlIG5lZWQgdG8gcmVz
Y2hlZHVsZQ0KPiBpZGxlIHdvcmsgaGVyZT8NCj4gPg0KPiA+IElmIHRoZSBWQ04gaWRsZSB3b3Jr
ZXIgcnVucyB3aGlsZSBHUFUgcmVzZXQgaG9sZHMgdGhlIHNlbWFwaG9yZSwgcmV0dXJuaW5nDQo+
IHdpdGhvdXQgcmVzY2hlZHVsaW5nIGNvdWxkIGxlYXZlIFZDTiB1bmdhdGVkIGlmIG5vIG5ldyBq
b2JzIGFycml2ZS4gSG93ZXZlciwNCj4gYmxvY2tpbmcgb24gdGhlIHNlbWFwaG9yZSBpbiBWQ04g
aWRsZSB3b3JrZXIgY291bGQgZGVhZGxvY2sgYmVjYXVzZSB0aGUgcmVzZXQNCj4gcGF0aCBtYXkg
c3luY2hyb25vdXNseSBjYW5jZWwgdGhlIHdvcmtlciB3aGlsZSBob2xkaW5nIHRoZSBzZW1hcGhv
cmUuIFVzaW5nIGENCj4gdHJ5bG9jayBhbmQgcmVzY2hlZHVsaW5nIG9uIGNvbnRlbnRpb24gYXZv
aWRzIHRoaXMgZGVhZGxvY2sgd2hpbGUgZW5zdXJpbmcgVkNOIGNhbg0KPiBiZSBwb3dlciBnYXRl
ZCBvbmNlIHJlc2V0IGNvbXBsZXRlcy4NCj4NCj4gSW4gdGhpcyBjYXNlIGFic29sdXRlbHkgY2xl
YXIgTkFLIHRvIHRoYXQhIEFwcHJvYWNoZXMgbGlrZSB0aGF0IGFyZSBjb21wbGV0ZWx5IGlsbGVn
YWwNCj4gdXBzdHJlYW0uDQo+DQo+IFRoZSByZXNldCB3b3JrIGhhbmRsZXIgKkNBTidUKiBkZXBl
bmQgb24gdGhlIGlkbGUgd29yayBhbmQgc28gYWxzbyBjYW4ndA0KPiBzeW5jaHJvbm91c2x5IGNh
bmNlbCBpdC4gVGhhdCBpcyBhbiBhYnNvbHV0ZWx5IGNsZWFyIE5PLUdPLg0KPg0KPiBKdXN0IHVz
ZSBkb3duX3JlYWQoKSB0byBtYWtlIHN1cmUgdGhhdCBsb2NrZGVwIHN0YXJ0cyBjb21wbGFpbmlu
ZyB3aGVuIHRoZSByZXNldA0KPiBoYW5kbGVyIGRvZXMgc3VjaCBuYXN0eSB0aGluZ3MuDQoNClRo
YW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24sIHdpbGwgdXNlIGEgYmxvY2tpbmcgcmVzZXQgcmVhZCBs
b2NrIGluIHRoZSBpZGxlIHdvcmtlciwgYW5kIHJlbW92ZSBzeW5jaHJvbm91cyBkZXBlbmRlbmNp
ZXMgb24gdGhhdCB3b3JrZXIgZnJvbSBwYXRocyBob2xkaW5nIHRoZSByZXNldCB3cml0ZSBsb2Nr
Lg0KDQpUaGFua3MsDQpQcmlrZQ0KDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gPg0K
PiA+IFRoYW5rcywNCj4gPiBQcmlrZQ0KPiA+DQo+ID4+IFRoYW5rcywNCj4gPj4gTGlqbw0KPiA+
Pg0KPiA+Pj4gVGhhbmtzLA0KPiA+Pj4gICBQcmlrZQ0KPiA+Pj4+DQo+ID4+Pj4+IFJlZ2FyZHMs
DQo+ID4+Pj4+IENocmlzdGlhbi4NCj4gPj4+Pj4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBUaGFua3Ms
DQo+ID4+Pj4+PiBMaWpvDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4+ICsgICAgICAgIHJldHVybjsNCj4g
Pj4+Pj4+PiArICAgIH0NCj4gPj4+Pj4+PiArDQo+ID4+Pj4+Pj4gICAgICAgIGZvciAoaSA9IDA7
IGkgPCBhZGV2LT5qcGVnLm51bV9qcGVnX2luc3Q7ICsraSkgew0KPiA+Pj4+Pj4+ICAgICAgICAg
ICAgaWYgKGFkZXYtPmpwZWcuaGFydmVzdF9jb25maWcgJiAoMVUgPDwgaSkpDQo+ID4+Pj4+Pj4g
ICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4+Pj4+Pj4gQEAgLTEyOSw2ICsxMzUsNyBAQCBz
dGF0aWMgdm9pZA0KPiA+Pj4+Pj4+IGFtZGdwdV9qcGVnX2lkbGVfd29ya19oYW5kbGVyKHN0cnVj
dA0KPiA+Pj4+Pj4+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+Pj4+Pj4+ICAgICAgICAgICAgbXV0
ZXhfdW5sb2NrKCZhZGV2LT5qcGVnLmpwZWdfcGdfbG9jayk7DQo+ID4+Pj4+Pj4gICAgICAgIH0g
ZWxzZQ0KPiA+Pj4+Pj4+ICAgICAgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZhZGV2LT5q
cGVnLmlkbGVfd29yaywNCj4gPj4+Pj4+PiBKUEVHX0lETEVfVElNRU9VVCk7DQo+ID4+Pj4+Pj4g
KyAgICB1cF9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7DQo+ID4+Pj4+Pj4gICAgfQ0K
PiA+Pj4+Pj4+ICAgICAgdm9pZCBhbWRncHVfanBlZ19yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcpDQo+ID4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPiA+Pj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5jDQo+ID4+Pj4+Pj4gaW5kZXggMTdkYjcyNjQyNjllLi5mODUxYTZl
Y2VhMWIgMTAwNjQ0DQo+ID4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Zjbi5jDQo+ID4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Zjbi5jDQo+ID4+Pj4+Pj4gQEAgLTQ3MCw2ICs0NzAsMTIgQEAgc3RhdGljIHZvaWQN
Cj4gPj4+Pj4+PiBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdA0KPiA+Pj4+Pj4+
IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+Pj4+Pj4+ICAgICAgICBpZiAoYWRldi0+dmNuLmhhcnZl
c3RfY29uZmlnICYgKDEgPDwgaSkpDQo+ID4+Pj4+Pj4gICAgICAgICAgICByZXR1cm47DQo+ID4+
Pj4+Pj4gICAgKyAgICAvKiBSZXNldCBtYXkgY2FuY2VsIHRoaXMgd29ya2VyIHN5bmNocm9ub3Vz
bHkgd2hpbGUgaG9sZGluZw0KPiA+Pj4+Pj4+IHRoZSB3cml0ZXIuICovDQo+ID4+Pj4+Pj4gKyAg
ICBpZiAoIWRvd25fcmVhZF90cnlsb2NrKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSkpIHsNCj4g
Pj4+Pj4+PiArICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnZjbl9pbnN0LT5pZGxlX3dv
cmssDQo+ID4+Pj4+Pj4gK1ZDTl9JRExFX1RJTUVPVVQpOw0KPiA+Pj4+Pj4+ICsgICAgICAgIHJl
dHVybjsNCj4gPj4+Pj4+PiArICAgIH0NCj4gPj4+Pj4+PiArDQo+ID4+Pj4+Pj4gICAgICAgIGZv
ciAoaiA9IDA7IGogPCBhZGV2LT52Y24uaW5zdFtpXS5udW1fZW5jX3JpbmdzOyArK2opDQo+ID4+
Pj4+Pj4gICAgICAgICAgICBmZW5jZVtpXSArPQ0KPiA+Pj4+Pj4+IGFtZGdwdV9mZW5jZV9jb3Vu
dF9lbWl0dGVkKCZ2Y25faW5zdC0+cmluZ19lbmNbal0pOw0KPiA+Pj4+Pj4+ICAgIEBAIC00OTks
NiArNTA1LDcgQEAgc3RhdGljIHZvaWQNCj4gPj4+Pj4+PiBhbWRncHVfdmNuX2lkbGVfd29ya19o
YW5kbGVyKHN0cnVjdA0KPiA+Pj4+Pj4+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+Pj4+Pj4+ICAg
ICAgICB9IGVsc2Ugew0KPiA+Pj4+Pj4+ICAgICAgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3Jr
KCZ2Y25faW5zdC0+aWRsZV93b3JrLA0KPiA+Pj4+Pj4+IFZDTl9JRExFX1RJTUVPVVQpOw0KPiA+
Pj4+Pj4+ICAgICAgICB9DQo+ID4+Pj4+Pj4gKyAgICB1cF9yZWFkKCZhZGV2LT5yZXNldF9kb21h
aW4tPnNlbSk7DQo+ID4+Pj4+Pj4gICAgfQ0KPiA+Pj4+Pj4+ICAgICAgdm9pZCBhbWRncHVfdmNu
X3JpbmdfYmVnaW5fdXNlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykNCj4gPj4+Pj4+DQo+ID4+
Pg0KPiA+DQoNCg==
