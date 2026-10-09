Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40AECA6015
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 03:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6501210FE4D;
	Fri,  9 Oct 2026 03:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QuQbNnfj";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABC910FE4B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 03:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQalUv35Z3Nmy5iRyPe4DtLww7QSrgaDGQSimVbzvt8ze2Xf/JSDKwEYxhxFI0jeRM++Tv1KiUugtUSNGohpyzsfzDuHwBonbJyrIArxhwmA/R/9t5NnTcRR4gmvp/yZb1dyb6aQw0ctotbO4Xg+NYIxE6UqVFDAdszrAQNdFjNfFER2WNNif3azQQ4JQTh6KtCVnCMiLoKZAwRTtHUpoyqhVEhnEh/Mj2b0Z1GKvMhGwDK8bR02lJsOnwlPjqgV2OidErrk3NOHIVhSLwB5b34nXnsfJyd/uYe51r0E6VpDY3GLs7xc0Jx7eAdO18qR6fvRzH+RX8yUJZA0N/o0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=712m7jGNKREXaFfAmgJxxRQftj+9lH8jSS73rLn85E4=;
 b=DNBlzFWx3xAmyiCgPDIsx6XYobkxhROUUBM/v0DrxFHtf3XdYEkPMNtGS9OKK5R+bb4I4v5q9co5Yd60QxXF5soURw18UsWBNUDK4ntcx4Mx+jgAWMMymRSRKzQJULMZmrvVMRdAfbRYr/FWQrTmRxb59R/UPCf+Zs6vDlABJU0pkAGSzzVQMrGewLMJbN9wDUnfmQdK1EpFx3Ig2iYF8XpIkyvWxZ1WyWj1jIMigXBya9Of9x9mtt6XJcTTpABtRC+NmwtXvgbEolfU0FybIybRl01QMkB8j3JtkelUlHeTlo8c9Jrb4i0s7LB3tAU8KzbCm6vkm8OL2zc1U3fIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=712m7jGNKREXaFfAmgJxxRQftj+9lH8jSS73rLn85E4=;
 b=QuQbNnfjLc/mfz+pnlokGGOEmmbc4UeIDDcvhARoO6TWTvI4pnlgQd2tbSkhrA99zE11eraIce0QtJN+Cv/wveIH+xJwX5pYV4oa1gLoGXJPv62rXbetXYeeI1PXeXTCL4E+fuQ6uaIzpW7YBNqK22imPAZTazmbt9hikwt2FTw=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by LY0PR12MB390394.namprd12.prod.outlook.com (2603:10b6:408:3b9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 03:43:32 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 03:43:16 +0000
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
Thread-Index: AQHdT8U/OFtQTBjuH020GWqQmH3vt7bznoUAgAAEbACAAAA28IAA+tIA
Date: Fri, 9 Oct 2026 03:43:16 +0000
Message-ID: <PH7PR12MB600066077324CFC6B1BAA16FFB922@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-9-Prike.Liang@amd.com>
 <0375ebd0-df28-437c-b6b4-47f06d4d1a24@amd.com>
 <5ff3175a-a8fb-49d4-b40a-36ab460f8ca0@amd.com>
 <PH7PR12MB6000ADDBADE18139E2B7401BFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB6000ADDBADE18139E2B7401BFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-08T12:34:22.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|LY0PR12MB390394:EE_
x-ms-office365-filtering-correlation-id: 683114fd-fae9-4582-e077-08df25b773db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: +5bE5hz49aEXv+7M0X5VAkU524RWt3ip2x/D3y6GW8eXcQxarDBZyZfGJR8gS99FNZHW3gAPJ8njO7TTAcCC2bEdmTd915VAgn+Ci3NZr3RWUvqEsh94TiNnrcLBqZLQpReP/C6WITh/XsX/6TFj9p8iq2P8PjfZ0cHvhUzVKFaJQ5yKwFdSrEF4wuWA+4T4SVLWsEKjOzBF58BuPwQxg0yHTV89mcWPNINHYaao8+p09GrRXTyX5M08ycL3QXsWous1aw1xv19/gn9fiRFJOLAKfWfvZStOkKJgTESMVm07Scrk8RPLr2jHqMQd6TebgoKlDQvgql5UlF5YPKTm4G6HJrMKaoaAjGdiUz1UJxNju+eXJKy4+vtyyhGv/OHo7S1bHLzkN+xzKKHuG7bzgRqTkKn6VKvUvgpq1FLfJEClEOe3IuZV4e8L/jgWaZTwrIsl75cvOOaMEmCB6c6w9XeC1d9UdWi0v5WeDBeYOYb2iYHHdfpmYV8DmpsQiA/C/3rC+PzsIZNpfV+9f36Uygd3PLkW6j74RrNrf27+OEeJ5kUO+mlKek548mMqlk+Du8SXhBrmSkt1XAxUNrshPgBYKgXFPHw2TTIK0CKB31+orESEG4mI0YHlvw6SwGOVH8/Kv/NchFcV3oNXiLkcuvQLKn/dixyIdb1oNWpO0i9wdibNAPkqtMTV0GYJ/RFmdVSCsvYWUFfCV2qVcnmASLxVi4gJF6M81UWdApWH17A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q21BTEtyaXA4bjZJaDBDVk9ucExlWkJRLzAwTWFXbnd0TzNkTzFoM0g0MVcy?=
 =?utf-8?B?QnVkSFlFOXNYemVDS2VpU2hnNVZkamlianMwR004bFBSanBuWWlzdWxrc1ND?=
 =?utf-8?B?NHhUNkp4Z3FnNlZ2OGVrei9aTnVJNGU5RGE5dGY4WnpVaC9IRHRUc21ZcGR3?=
 =?utf-8?B?MDFySGpVbkxlZXg0QnJOWU4za095ZDlxSXBheXRtK3dBSGFkY20vQlAyYVkx?=
 =?utf-8?B?eUhqNFdLMllqK1ZTRUp0SVhqV3IvN2VRdk14NCttNGpuOWpGemlmYTNKVHMw?=
 =?utf-8?B?ZGJKWVVlYjgwYjluTEpGd3g3M2lKREFVNWgreTJLY2I3ZG1vbkFsVUd2OGdh?=
 =?utf-8?B?WHFybFNkZENXVFJDL1dib1RCeThxSUVNTjFReFo4WG9wUHVTNzZDMitVeTJ3?=
 =?utf-8?B?M1Z2SWo2bmZaZDUrMXdjSUJyakJyTUVwTGpVZU9Gd1lEVDZhcmlNRzNpWk5J?=
 =?utf-8?B?Ri9hUVNpalNKcmVwT3pGMHVzQ1hlNksrd0VaTzk2WUlud1BRelpEVGNYODYz?=
 =?utf-8?B?M0k2MXNhVThWOTJMSFNlVStDdG5lZE93TGVmU045OVZ3UEZ4Ykg2SnVXZUlZ?=
 =?utf-8?B?cFVtSzU4SndDa05MbXR1VXovS2YyUGw2d0UwakFFZGlWZE8vME1VMGxpTkty?=
 =?utf-8?B?UVJOOEI0Y2V5MlI5RWp3eDFMV0ZFbURlcUV5VFZYNlQreWp5N1NpYVZwT3Zk?=
 =?utf-8?B?djZ6NWVMNmxaVW82Z0V0RVFEZEtsbjgxWnVHWkZTNXhlc2FpTnMvNkVtUHA1?=
 =?utf-8?B?VCtxVERiVkhDc1hCcFVJYXlIWURUL1hPcGJXT2U5aHQ3YXpiUnN6SUY5QWtI?=
 =?utf-8?B?MWRJV1VRd2tsQXlpS3ZrbWlrK3NmQjk0dTEzU1FTWnpybGNJb1phZTZoUzRy?=
 =?utf-8?B?WSs4WW84bEFENEk1OTdBbHVZWXBLNFVtVWxydklpbVJ1MnJ5UTBGZnRJZ1dX?=
 =?utf-8?B?VjA1UmV6Q1B5Y0U4RjlyUkNCTllPOXZtZCt1cUQ2VHd3enhib0NRQnI0TE9i?=
 =?utf-8?B?cFBEQlVHaVlhSngxS0xSYXY0akJuVXlydDBXS2NRbWVZVGJySkRTQnRaS3gy?=
 =?utf-8?B?cDFKYjVYY0NtdUZpV3BLYTN4VkpjclpuVWxFWEdWMEFEb3NKM01OS25kQmYy?=
 =?utf-8?B?RGovYnZWakpuWmhOTnJlNDRGZUFDb2liRjhzZEp5cy9MRHFsN0QvWXNoVGh1?=
 =?utf-8?B?WU9iTk5TOWp2Y0lnZVhuazlrVlVJRGg1cDg4dzhmN1JVNGtOM0hNS2U4Q3Er?=
 =?utf-8?B?aDFtNUpZbGNjNWx6dDl6MVh6L0xJcW90eVFJVVRFOUR5cnJTWXZzT1d5Szhp?=
 =?utf-8?B?N1VuYWkwbkIvVGFHN3IxTnlvQjBxaS9KaWNQNGZrSHZqOU94NUowN25lVVY4?=
 =?utf-8?B?akFpLzdLMm9RbkZ6MDdVL1BtNlh5OUxrYVlsemxhKzFONHlMV0VkVjlsYkla?=
 =?utf-8?B?cHl0eGRQODhPYkNHTXdQRXM5V29EVE9UdkRGR2xoOVM5RHRjaUtBK09yTWNn?=
 =?utf-8?B?TndtMTlPZHF5ODFYRWlCQ3ZnZVRuWHJIWUFtcElKSkZmblZ5QnVMR2lLRDNI?=
 =?utf-8?B?U3ZKdnQySGNzbFBRU0lMOTZRSW5relU4bUFQRHEwODVVV3JpV0dUWWZTRXEr?=
 =?utf-8?B?Y2VpYThmRGVmNlVPdTQySThnSmtvTVE3aW5ZV0ZJYmZ5SjNCZmZzODVuNFhP?=
 =?utf-8?B?ejJEQW9mTE5wOURyVGIyd011N3RBcnpsZjRnNkFzM3VoaS92VGZQT1IrKzJm?=
 =?utf-8?B?MENjYjJ6OWJLRU5Lb1V2eVFPVWM4bHBHd1J6QXpOYXlZL0VZaXRWMzREbWNJ?=
 =?utf-8?B?c1RacktsVUFmQlpIZjVFSllBaWowZ3ViWitFQmhHN2tMTzhZeXlZblR4UmRT?=
 =?utf-8?B?c09vWlZTZkNhNUw5WXZvVnVuNmdOdkNCdGNBR1pFcUIybWFDUlp5bXJGSGlU?=
 =?utf-8?B?Nng3SXFmZDFvKzdlWHVXVHhGeVN1SnJFWVRKZGFSRXpBWHpSR1NlRU1vd3VU?=
 =?utf-8?B?NEx2MUkwdTlCMTFYbkpFY3VqeWpkRlpJbGNMUzZQd0N6eTBaQ2xTUTI3WTdh?=
 =?utf-8?B?WW1ENHBCWjNpYWt4TC95K3NRUmEweG1jTUZoZDNmOWVGZUovWWVWMVFjODFy?=
 =?utf-8?B?N08vYmZIdVl1ekhmNmpiN29xY1Nsd09xVVhLcVU4Uk5pclpiWmZJRzJJMW91?=
 =?utf-8?B?TEJLc05KNE5iV1FKT213emw5R2o3UzJWUk1uL2U1WWhweFphR2t1UDJGaW5H?=
 =?utf-8?B?TnNkcUFFQ3FZZmlNMDZkc1UvT0NVUTdQVCtrYlRCdTB6ZlJWUGxUTS9VQ3dT?=
 =?utf-8?Q?jgaVffQygTbR61s2vj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683114fd-fae9-4582-e077-08df25b773db
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 03:43:16.2834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RujiZUxPopz1govWVUNq7E3MkSBImorbMhXK4zsrnfQzcllDJczCgpprFTDcCpy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB390394
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTGlhbmcsIFByaWtlDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3Rv
YmVyIDgsIDIwMjYgODo0MiBQTQ0KPiBUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT47IExhemFyLCBMaWpvDQo+IDxMaWpvLkxhemFyQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUHJvc3lhaywgVml0YWx5DQo+IDxWaXRhbHkuUHJvc3lh
a0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDA5LzE0XSBkcm0vYW1kZ3B1OiBk
ZWZlciBKUEVHIGFuZCBWQ04gaWRsZSB3b3JrIGFjcm9zcw0KPiBHUFUgcmVzZXQNCj4NCj4NCj4N
Cj4gUmVnYXJkcywNCj4gICAgICAgUHJpa2UNCj4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+DQo+ID4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgOCwgMjAyNiA4OjM0IFBNDQo+ID4gVG86
IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBMaWFuZywgUHJpa2UNCj4gPiA8UHJp
a2UuTGlhbmdAYW1kLmNvbT47IGFtZC0gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+IENj
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBQcm9zeWFr
LCBWaXRhbHkNCj4gPiA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDA5LzE0XSBkcm0vYW1kZ3B1OiBkZWZlciBKUEVHIGFuZCBWQ04gaWRsZSB3b3Jr
DQo+ID4gYWNyb3NzIEdQVSByZXNldA0KPiA+DQo+ID4gT24gMTAvOC8yNiAxNDoxNywgTGF6YXIs
IExpam8gd3JvdGU6DQo+ID4gPg0KPiA+ID4NCj4gPiA+IE9uIDI5LVNlcC0yNiA5OjE2IEFNLCBQ
cmlrZSBMaWFuZyB3cm90ZToNCj4gPiA+PiBQcm90ZWN0IG1lZGlhIGlkbGUgd29ya2VycyB3aXRo
IGEgcmVzZXQtZG9tYWluIHJlYWQgdHJ5bG9jay4gT24NCj4gPiA+PiBjb250ZW50aW9uLCByZXF1
ZXVlIHRoZSBpZGxlIHRpbWVvdXQgYW5kIHJldHVybiB3aXRob3V0IGhhcmR3YXJlDQo+ID4gPj4g
YWNjZXNzLiBLZWVwIHRoZSBvcmRpbmFyeSBlbmQtdXNlIHNjaGVkdWxpbmcgZXZlbnQsIGluY2x1
ZGluZyBmcm9tDQo+ID4gPj4gcmVzZXQtdGltZSByaW5nIHRlc3RzLCBzbyBvdGhlcndpc2UgaWRs
ZSBlbmdpbmVzIGV2ZW50dWFsbHkgcG93ZXINCj4gPiA+PiBkb3duIGFuZCBWQ04NCj4gPiBkcm9w
cyBpdHMgcHJvZmlsZS4NCj4gPiA+Pg0KPiA+ID4+IEEgYmxvY2tpbmcgcmVhZCBhY3F1aXNpdGlv
biB3b3VsZCBkZWFkbG9jayB3aXRoIHJlc2V0LXRpbWUNCj4gPiA+PiBzeW5jaHJvbm91cyBjYW5j
ZWxsYXRpb24gb2YgdGhlc2Ugd29ya2Vycywgc28gdGhlIHdvcmtlcnMgbXVzdCBvbmx5IHRyeSB0
aGUNCj4gbG9jay4NCj4gPiA+Pg0KPiA+ID4+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQ
cmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+ID4+IC0tLQ0KPiA+ID4+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuYyB8IDcgKysrKysrKw0KPiA+ID4+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jICB8IDcgKysrKysrKw0KPiA+ID4+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+ID4gPj4NCj4gPiA+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuYw0KPiA+ID4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuYw0KPiA+ID4+IGluZGV4IDk4ODdh
NGY5OWFlZC4uN2IxMDI2MGFkMGQ0IDEwMDY0NA0KPiA+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMNCj4gPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfanBlZy5jDQo+ID4gPj4gQEAgLTExNCw2ICsxMTQsMTIgQEAgc3Rh
dGljIHZvaWQNCj4gPiA+PiBhbWRncHVfanBlZ19pZGxlX3dvcmtfaGFuZGxlcihzdHJ1Y3QNCj4g
PiA+PiB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiA+PiAgICAgICB1bnNpZ25lZCBpbnQgZmVuY2Vz
ID0gMDsNCj4gPiA+PiAgICAgICB1bnNpZ25lZCBpbnQgaSwgajsNCj4gPiA+PiAgICsgICAgLyog
UmVzZXQgbWF5IGNhbmNlbCB0aGlzIHdvcmtlciBzeW5jaHJvbm91c2x5IHdoaWxlIGhvbGRpbmcN
Cj4gPiA+PiB0aGUgd3JpdGVyLiAqLw0KPiA+ID4+ICsgICAgaWYgKCFkb3duX3JlYWRfdHJ5bG9j
aygmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pKSB7DQo+ID4gPj4gKyAgICAgICAgc2NoZWR1bGVf
ZGVsYXllZF93b3JrKCZhZGV2LT5qcGVnLmlkbGVfd29yaywNCj4gPiA+PiArSlBFR19JRExFX1RJ
TUVPVVQpOw0KPiA+ID4NCj4gPiA+IElzIHRoZXJlIGFueSBuZWVkIHRvIHNjaGVkdWxlIHRoaXMg
d29yayBoZXJlPyBCZWluZyBub3QgYWJsZSB0byBnZXQNCj4gPiA+IHRoZSBsb2NrDQo+ID4gaW5k
aWNhdGVzIHRoYXQgYSByZXNldCBpcyBpbiBwcm9ncmVzcyBhbHJlYWR5Lg0KPiA+DQo+ID4gWWVh
aCBhZ3JlZS4gV2Ugc2hvdWxkIGp1c3QgYmxvY2sgZm9yIHRoZSBHUFUgcmVzZXQgdG8gZmluaXNo
Lg0KPiA+DQo+ID4gU28gYSBzaW1wbGUgZG93bl9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNl
bSkgc2hvdWxkIGRvIGl0Lg0KPg0KPiBUaGlzIHBhdGNoIHdhbnRzIHRvIHNjaGVkdWxlIGEgZGVs
YXkgaWRsZSB3b3JrIGR1cmluZyBwcm9jZXNzaW5nIGEgZ3B1IHJlc2V0DQo+IHByb2Nlc3MsIGFu
ZCB0aGVuIHJldHJ5IHRvIHJ1biB0aGUgVkNOIGlkbGUgYXQgdGhlIG5leHQgc2NoZWR1bGVkIGxv
b3AuDQoNCkEgcG90ZW50aWFsIGRlYWRsb2NrIGNhbiBvY2N1ciBpZiB0aGUgVkNOL0pQRUcgaWRs
ZSB3b3JrZXIgcnVucyBkdXJpbmcgYSBHUFUgcmVzZXQgd2hpbGUgcGVyZm9ybWluZyBhIGJsb2Nr
aW5nIHdhaXQgZm9yIHRoZSByZXNldCB0byBjb21wbGV0ZS4gVGhpcyBwYXRjaCByZXNvbHZlcyB0
aGUgaXNzdWUgYnkgdXNpbmcgYSByZXRyeS1iYXNlZCB3YWl0IG9uIHRoZSBHUFUgcmVzZXQgc2Vt
YXBob3JlIHdpdGhpbiB0aGUgaWRsZSB3b3JrZXIgY2FsbGJhY2suDQoNClRoYW5rcywNCiBQcmlr
ZQ0KPg0KPiA+IFJlZ2FyZHMsDQo+ID4gQ2hyaXN0aWFuLg0KPiA+DQo+ID4gPg0KPiA+ID4gVGhh
bmtzLA0KPiA+ID4gTGlqbw0KPiA+ID4NCj4gPiA+PiArICAgICAgICByZXR1cm47DQo+ID4gPj4g
KyAgICB9DQo+ID4gPj4gKw0KPiA+ID4+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT5qcGVn
Lm51bV9qcGVnX2luc3Q7ICsraSkgew0KPiA+ID4+ICAgICAgICAgICBpZiAoYWRldi0+anBlZy5o
YXJ2ZXN0X2NvbmZpZyAmICgxVSA8PCBpKSkNCj4gPiA+PiAgICAgICAgICAgICAgIGNvbnRpbnVl
Ow0KPiA+ID4+IEBAIC0xMjksNiArMTM1LDcgQEAgc3RhdGljIHZvaWQNCj4gPiA+PiBhbWRncHVf
anBlZ19pZGxlX3dvcmtfaGFuZGxlcihzdHJ1Y3QNCj4gPiA+PiB3b3JrX3N0cnVjdCAqd29yaykN
Cj4gPiA+PiAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5qcGVnLmpwZWdfcGdfbG9jayk7
DQo+ID4gPj4gICAgICAgfSBlbHNlDQo+ID4gPj4gICAgICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRf
d29yaygmYWRldi0+anBlZy5pZGxlX3dvcmssDQo+ID4gPj4gSlBFR19JRExFX1RJTUVPVVQpOw0K
PiA+ID4+ICsgICAgdXBfcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOw0KPiA+ID4+ICAg
fQ0KPiA+ID4+ICAgICB2b2lkIGFtZGdwdV9qcGVnX3JpbmdfYmVnaW5fdXNlKHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZykgZGlmZg0KPiA+ID4+IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5jDQo+ID4gPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmNuLmMNCj4gPiA+PiBpbmRleCAxN2RiNzI2NDI2OWUuLmY4NTFhNmVjZWExYiAxMDA2
NDQNCj4gPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMN
Cj4gPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMNCj4g
PiA+PiBAQCAtNDcwLDYgKzQ3MCwxMiBAQCBzdGF0aWMgdm9pZA0KPiA+ID4+IGFtZGdwdV92Y25f
aWRsZV93b3JrX2hhbmRsZXIoc3RydWN0DQo+ID4gPj4gd29ya19zdHJ1Y3QgKndvcmspDQo+ID4g
Pj4gICAgICAgaWYgKGFkZXYtPnZjbi5oYXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQ0KPiA+ID4+
ICAgICAgICAgICByZXR1cm47DQo+ID4gPj4gICArICAgIC8qIFJlc2V0IG1heSBjYW5jZWwgdGhp
cyB3b3JrZXIgc3luY2hyb25vdXNseSB3aGlsZSBob2xkaW5nDQo+ID4gPj4gdGhlIHdyaXRlci4g
Ki8NCj4gPiA+PiArICAgIGlmICghZG93bl9yZWFkX3RyeWxvY2soJmFkZXYtPnJlc2V0X2RvbWFp
bi0+c2VtKSkgew0KPiA+ID4+ICsgICAgICAgIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygmdmNuX2lu
c3QtPmlkbGVfd29yaywNCj4gPiA+PiArVkNOX0lETEVfVElNRU9VVCk7DQo+ID4gPj4gKyAgICAg
ICAgcmV0dXJuOw0KPiA+ID4+ICsgICAgfQ0KPiA+ID4+ICsNCj4gPiA+PiAgICAgICBmb3IgKGog
PSAwOyBqIDwgYWRldi0+dmNuLmluc3RbaV0ubnVtX2VuY19yaW5nczsgKytqKQ0KPiA+ID4+ICAg
ICAgICAgICBmZW5jZVtpXSArPQ0KPiA+ID4+IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZ2
Y25faW5zdC0+cmluZ19lbmNbal0pOw0KPiA+ID4+ICAgQEAgLTQ5OSw2ICs1MDUsNyBAQCBzdGF0
aWMgdm9pZA0KPiA+ID4+IGFtZGdwdV92Y25faWRsZV93b3JrX2hhbmRsZXIoc3RydWN0DQo+ID4g
Pj4gd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gPj4gICAgICAgfSBlbHNlIHsNCj4gPiA+PiAgICAg
ICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2Y25faW5zdC0+aWRsZV93b3JrLA0KPiA+ID4+
IFZDTl9JRExFX1RJTUVPVVQpOw0KPiA+ID4+ICAgICAgIH0NCj4gPiA+PiArICAgIHVwX3JlYWQo
JmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsNCj4gPiA+PiAgIH0NCj4gPiA+PiAgICAgdm9pZCBh
bWRncHVfdmNuX3JpbmdfYmVnaW5fdXNlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykNCj4gPiA+
DQoNCg==
