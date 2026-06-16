Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC5DCD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA7610E54C;
	Tue, 16 Jun 2026 11:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rmirYgyY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF8910E54C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeEAqv1i+W19opVVRG8eaZdiYAoSsadz8OWZwccEo7xGj06jmyDKSbd2AW4fjJIFzESo8XjeNBMh+wI6v7Ty4edJVQJhCuqLM97IGREnMXqdoH9LTlNwBYg+ASZzTLoivVAsOYhdHMFuBY2avt4+vfzntLOsdyBcpL8955CTUuFy9kMmmRfWw6okgyYPrepvZPgdEYUDJ9T/0Yz3yo5/EYDtR+2inXUWxId819QVUS1GlJX9yBJbN3nQ/OwNkbWRXVaaBPrGP0xOM282TdN2ySd+dWsLQr535BV1IpCnf+9ygEOfu+pervWxtdoJKIWPZZ96OxVBtYYVMUKVZx1flg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnXDdvnWX/mTZd7ReMkIil7IVV1t5rO7IBwQLNErOds=;
 b=e0RCH1QLoBhtUh+Zz6zBlT0POkmJgUBZJxXodP36FDCLtcpChMIEh8ZeCIg4wkCO83ET7JfQfyqxhYIEge7Y4GvoGuBicjOIjSJU5blKpih0DN9EsdVhMbXcdYJy4112xO2G/1LdocJe9XxloyyS418VWDmE3ywah7w4rfURCOwaLydVUxz6R2RmH/2zqCehUJ4napP/zz2RQ2ZefNha0Vpdz5Tie/D4LVMLfXxoyedrcFfR8hIeao8dpLjbOAMMe13+agjGkG3O/lumbtwMOVPeCt82PoUbu0wnTDy3myf9YcTzxvyWUIwI242h4HxGDEPgwDK4cmxk53PHC0x+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnXDdvnWX/mTZd7ReMkIil7IVV1t5rO7IBwQLNErOds=;
 b=rmirYgyY/oGU/t7OItjRRuOAunbeJalYNceanuk9lb07zaKHwGSWTVeV5IFjdbdP2LxKPbO54jGDh6JUIbQcM76gYMNiK6lofF+SEXh+gy4HMusgFPQBpfE/1u/PJifYpTsFcSVVxUnzjMm3/OWlVmoX3WONCCPNV7wpxogSOYE=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:37:51 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:37:51 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdgpu: Signal SCRATCH EVENTFD notifications
Thread-Topic: [PATCH 3/5] drm/amdgpu: Signal SCRATCH EVENTFD notifications
Thread-Index: AQHc+i+9at9Qdi6txk6Hn215UbPRPbZA6VIAgAArCrA=
Date: Tue, 16 Jun 2026 11:37:51 +0000
Message-ID: <IA0PR12MB820812B1B96223065F5110FC90E52@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-4-srinivasan.shanmugam@amd.com>
 <5f16dfbb-e9b7-4f66-954b-ac7299743323@amd.com>
In-Reply-To: <5f16dfbb-e9b7-4f66-954b-ac7299743323@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-16T11:36:26.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|IA1PR12MB6482:EE_
x-ms-office365-filtering-correlation-id: 25b7e32f-5274-4302-4982-08decb9bb2c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: tSlGsmH5y82w+F2xzA5asYca8E4PWq4+vKOSXoU1+MipsdJ+qx5Lf3PMN0XcAs0cxCkzpTWJZ190ESLaaM6wRaY0pDLjx2Q/m5z0lresWKP139DZDeynfjgWhBeOvVvtK/KWC5u9keycUK/EOsmYNoUkrYnjEh0Je/j9aP7ZBUeHHktQSVaynEHH4/8vJPyOZ38eE47wk98UIBrxwsaFHjPm0/KCuvYzOyD9fAEawPox4UBnd4uKJgWXehhQgo7OhhLCKtcqi6juni+YbAk9rHDknYUClyqQhcpIgO7JbJ34p7nqck8w4f0a+AP250XbdH911YoHLSoiJ9UX8MN5zpTsGqEWYcpMdDUD5tP6LZFZEoKsEbaSl+qBwL/w2+ZrWqW0TWQKaGm2GjvBcoISE60i7he7bZZSaP3gMSXdZBAPJZK73u1zFloi6wdsUR2JEsTga9XP079EQDdhezwIvwRjQpkaxgxjAkj5x3jybvw8v2kaiJG17Q0mhuvZ7N7I8+8SESyvf/9fcOuiVRWQIvmM4bx8dEZ75jYM+TC89Aq8meioFhaQSbnVIF9I8Rmr6IzVwQEAieUDReJz9QsxGdMCVjDHjKd2ktfxA6j2H+kIFe34IzF4w/uGOWDDVR2QH27+49GNsYTvtMIOHHB6YGiJ4Kkn0w60cO/GmXVOwhjXF7bZdJGy/XdGwJd0g+FZsl0U4FrA6V/9c7+z2RyzYbO9JIDXzKM9bNfWkxEXZg039cSk6+/Tzi3Q2BaRDR5j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUszTFNLVW4xWmc5bEVLVExDS09WMkczOUR2YXdKQVdOOVd6eUFkR0tKUllw?=
 =?utf-8?B?czFnSW1XRnNqM0FUdkdQUGN5a3hJdWRKbzNjNHk2dW9lemhKSU01V3g3c1pN?=
 =?utf-8?B?MVZERHdGZENLdTIrN094R2pWT2p3NWw1SGswK0JuMmtCNFdoczlVWDI2RndT?=
 =?utf-8?B?aWZqQmdZVVBLNEJ0UkRDRkhVODhMTXdseHBzQ3hqZXdHRklkUFhVTzh5ZWZ0?=
 =?utf-8?B?bU5KblNicDl4Kys1NS9kVURrNjdySFFmQ1RaVFE0WGtab09FTEI1eUIvc0ZR?=
 =?utf-8?B?dUh4S29ScitaOUVkU2NnWDA1bFlJUW5xVm5FZVFtZXFEcTZiQXZNSEFJaVg4?=
 =?utf-8?B?UG5lVWl0RHlOd2oxeE4weFA0bTJ3T3dSN3VXV2M1MWRIMlpCQUo4V1IzMUtM?=
 =?utf-8?B?YmJMejVpUm8vK09wVjRCNzVUVFVnbXhoYTFsSkovc295UUxvV0ttT0Z2MFcr?=
 =?utf-8?B?ejF5OTdKYWh2L3ZsQWhpbFVXMlExTkt2VDNnSE0wYUY3cVlmcVZlcEhyY01t?=
 =?utf-8?B?Z1Y0c0RpRmpwaGlZUmtxQ3NycGVMZzNGSkh0MTEyYzR4SWt1L0lWV0pxV2R4?=
 =?utf-8?B?MUpWNEo2QnkrTGJGbjJLTHlSb29XcHhOdXhiQ1pKeHlrQXV0eE1zZUs5OGlB?=
 =?utf-8?B?UFNkK29JVk9EbUZ5UGdVU3VRY09hYTIvb0hyRHVlSkVOZDZBbndjK2oxdlBj?=
 =?utf-8?B?aTczQk0zR3NsR245VjhqOTJ0by9MRjVueHU0VG80Uit3OXhoakdIRTV6S2Rp?=
 =?utf-8?B?Q2dZOTVZWDUyM0dCblFFdzBrNFp2SXFhV3puMjB5MnJyS2czQUJ1Y25yMDJS?=
 =?utf-8?B?dlRTWDZpMzhDVWFsNEVpVFFCY2V3L0F6bW1QL1hJQlFyRFRzVmR2OEk1VVRk?=
 =?utf-8?B?MmpWMjM3MHlQc3JCQXhWS2c0L3o3NSs0Nnh5T1FtSjV5ZytPaDF2SVVnTFVX?=
 =?utf-8?B?NHprYkViU0hMUzYwS1ZtMm1TQ1locFFrT2xCUEZ3WXRqTVlhTEtCV0E5TWxV?=
 =?utf-8?B?L1Z3MVFsNnp0NTcrQkdRY2Ivb1VIRVBrcGdtUmovcTlYZjlxL1hEMVQ1UGpC?=
 =?utf-8?B?Qkp3eFNqM1IwTDZiZDVPNDBSL1NJc0tIYmJGaktuN3NlV3J1MDZNTDRYRXdK?=
 =?utf-8?B?UzFTWkhzZUNEUzBLQjZuLzAvZjZFZUtUVTJpNkxGMmdxY3lxYmxML1NGRGN1?=
 =?utf-8?B?ekY4cTI2ZEl3MUVOYzE5RmF1ay9GQTRhbkVzdEN4S2ZKNks2UnBRYzc2alNv?=
 =?utf-8?B?WVpDWVRYL3lvKzA5eDAzUlo4Rm5XVHd6Y1YvY1NmS0pNbjhpeXA1T2NVNTFZ?=
 =?utf-8?B?MndZUWFGdk1DeFBBL3l5Q1R6VkM4NmN2RDBxMGxUL2FxV1VsT0dTdnhGdVlk?=
 =?utf-8?B?YlhNSjhIME1rMUJKaEh0STlINHIzKzdoZWMrSmJyN25rOUVZLzd6ZGF1RGhE?=
 =?utf-8?B?UjBVNkZNKzVjdlZiLzNNc1p6Z2dpVTYyeFJqQWZ0UlNSREFsSnFra2hRbUk1?=
 =?utf-8?B?MGtURHlrb01FZ3BhY3NUdDZCSTVtazhrQXZKMlg1dGh3S1p6RENBc0NpNFZm?=
 =?utf-8?B?elZLMzJzTXhVVG1iTk1sMXFJSUJMbUhJS0xMejIzWnA4cHp3aVFqNThHWTds?=
 =?utf-8?B?bC9OMmZKdDhuUzVhYU5Kd1JrUEZVU1hXaXJxQjNpa3A0V0ZORWphM1pIelM4?=
 =?utf-8?B?OUxxNy9kZmpHazE2ZEFQbDA2cWFsU05Id0g1TWd6dVh6VTB5MlV2QVNmZCtX?=
 =?utf-8?B?eGNWRnZERnZyRHFueHdrVm8rMGdSWkw5RDRSeGtDdmtDM1IzcDRXbm1hOFU2?=
 =?utf-8?B?bDlxRjNOWTZaV21TNWZPZUtReUtkQ2ZrUlY1cVVRRmVEWVh2b1lhZGd0RUFD?=
 =?utf-8?B?S25xbCtjZWYvbDFoTkoxSndzWm5YL2V5WThJNjRFZ0pnRWJzdXpFWGdiVzRT?=
 =?utf-8?B?Zk1PeVM3aFZ5OHI4bThIMTIxMHFNZkhhOG9wRExDRFdaekVHMXBOVXRuV2VB?=
 =?utf-8?B?R0JJYTdyNU0xWUdQbHM5Zms4emMrdEFlb1N2blRzUE5PMUtiMGcxTzkraDZ6?=
 =?utf-8?B?bzk0YUlkYjdtaElLM0ZRNlErV2tqNHRoN1VUcDdEdDdMb0VzNktmaTdLazJ0?=
 =?utf-8?B?WHArZisrMUh6UDJvY1VRODh3R2VxNllEU09aTVNrRjZHdjgweHRWY3F3YWNI?=
 =?utf-8?B?TTBBRkFtNFhVb1NxYWJLV0ZENmp6RW1aVHFBYnN3UFZVcUQzanVDTWd4WklS?=
 =?utf-8?B?UTFML1E3VWVad1pwMTJxUGFoaXN0ZFpjNG1STWRHOVJyTncvb0JrcDBTMHFI?=
 =?utf-8?Q?dTXzkolTLPCYx54akT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b7e32f-5274-4302-4982-08decb9bb2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 11:37:51.2211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUaQx58hj2ceMIQPQykbqzpcSI7WimkhfC8jWOQpIFN6x6TiG730/LBChqSU/FGVkbWG0fKkexUPnIkMh0VSGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
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

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTYsIDIwMjYgMjozMiBQTQ0KPiBUbzogU0hBTk1VR0FN
LCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPjsNCj4gRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzVdIGRybS9hbWRncHU6
IFNpZ25hbCBTQ1JBVENIIEVWRU5URkQgbm90aWZpY2F0aW9ucw0KPg0KPiBPbiA2LzEyLzI2IDA3
OjUyLCBTcmluaXZhc2FuIFNoYW5tdWdhbSB3cm90ZToNCj4gPiBTaWduYWwgU0NSQVRDSCBFVkVO
VEZEIHN1YnNjcmlwdGlvbnMgd2hlbiB1c2VyIHF1ZXVlIHJlc3RvcmUgZGV0ZWN0cw0KPiA+IG1p
c3NpbmcgVkEgbWFwcGluZ3MuDQo+DQo+IEkgdGhpbmsgdGhlIHNjcmF0Y2ggZXZlbnQgaXMgbWVh
bnQgZm9yIHNvbWV0aGluZyBlbHNlLg0KPg0KPiBXaGVuIGEgY29yZSBWQSB0byBydW4gdGhlIHF1
ZXVlcyBpcyBtaXNzaW5nIChXUFRSLCBSUFRSLCByaW5nIGJ1ZmZlciBldGMuLi4pIHdlDQo+IGhh
dmUgYSBoYXJkIGFuZCB1bnJlY292ZXJhYmxlIGVycm9yIGZvciB0aGlzIHF1ZXVlLg0KPg0KPiBC
dXQgc2NyYXRjaCBoYW5kbGluZyBpcyBhIGRpZmZlcmVudCBpbnRlcmZhY2UgYXMgZmFyIGFzIEkg
a25vdy4NCg0KSWYgYSBxdWV1ZSBjYW5ub3QgYmUgcmVzdG9yZWQgYmVjYXVzZSBpdHMgVkEgbWFw
cGluZ3MgYXJlIG1pc3NpbmcsIHdoYXQgbm90aWZpY2F0aW9uIHdvdWxkIHlvdSBleHBlY3QgdXNl
cnNwYWNlIHRvIHJlY2VpdmU/IElzIFNDUkFUQ0ggYXBwcm9wcmlhdGUgaGVyZSwgb3Igc2hvdWxk
IHdlIGhhbmRsZSBpdCBkaWZmZXJlbnRseT8NCg0KVGhhbmtzLA0KU3JpbmkNCg0KPg0KPiBSZWdh
cmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo=
