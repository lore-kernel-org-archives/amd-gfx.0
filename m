Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C1DC61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 06:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24872897FB;
	Tue,  1 Sep 2026 06:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECya+j2z";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C5C897FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 06:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNdtdcqT4iz/gygXcxk71WFBOMJ+WgSoAs/SXGyR6e5Vo8+Ru6BJMr6a20es3r8f6Bp0F84MEhhGj+wMz7T1oykTtkwsSKv/K5NjVVqX0jhcBX/hfzPR5vqIHJmwA6EYjXf6UffzUWLMN2d/46vQfX9pwlEQ98SrgZVmbV5LMtCn5Y+1qt7PUkTSbyEc1tLej8w3gHR6udQaRcRCjKc3aH5/z+9dku3UrucVigC75JvTqdWH2GkQxtja0HBsLeaytSUIm0hnFEJJ9W5QGj+s0+kJsZ9U8QBlyTm91ME3VVJSVq20jRw4vhcu1HS4TQxzfnUGhIR/DrVdJtmA01lcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI9W7XW5egrk0sGm0ECi3dUdMj5rIoSWydgypFxqpes=;
 b=ewS4lpyLjkQmRYGiXqbXVbs1y9X+YyjYVe0XHYNPRN1Q3J807eLAWvyOVgJVAE3yVDTYx59JBCiMKCNC4NI8e15DwvMRHMK68lSEbROpXmTN5xrkSkDWtmW/3pZw/e8K3lDb1XN1RXGN4qNK0L7I1V0RC36Q4B/UwKK/JmeqriSFXVBwwxR/37g/XzDvXOvSGeXNwkm6QLyK7c3WlABgXqsNowZd7iUx+RhhhFxjlvj9QlQ0s5LFxa9xR674WlS6huPxPCU7RYEbCBHaWjNj6HhAPetl0BT6w1WbZTjmGLke1EoUjoMs5lYk20U/j3QmBzbAS4brfR75ueJ714VKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI9W7XW5egrk0sGm0ECi3dUdMj5rIoSWydgypFxqpes=;
 b=ECya+j2zzStyzJZEF9NkJQ5+dbi/2u/0AHehSIyC9zdeJoGJAszb+DEmPobxoZqezY9HOYwNGSBRH/puqAkJ/Qvn8L9ZyvMz7oMSW3kFzLeMBAfq6agR52Q/ODvnKQbA5EYcxEZQA2DZ+L9vsoMU9lZZimxelVutC+hyFR3CyVM=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 06:44:07 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 06:44:07 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Thread-Topic: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Thread-Index: AQHdOQIkJ9AjL5zwL0KzN17mKPT+NLa3/IKAgAACwoCAABDxgIAABE8AgAAHTwCAASxF0A==
Date: Tue, 1 Sep 2026 06:44:07 +0000
Message-ID: <MW4PR12MB68033AB90877B1C4D3F51A968EA82@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
 <6041b95a-ac8c-4410-97cb-8eca51d20d50@amd.com>
 <0e34543c-4802-4023-befa-480b5452d92b@amd.com>
 <BN9PR12MB5211F46FDD421E130B99248793A92@BN9PR12MB5211.namprd12.prod.outlook.com>
 <0a3293bd-317c-4bf8-8fca-395f7a1435cb@amd.com>
 <BN9PR12MB52119D373A6AB87F0DD5A1B193A92@BN9PR12MB5211.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52119D373A6AB87F0DD5A1B193A92@BN9PR12MB5211.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-31T12:39:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|CY8PR12MB7244:EE_
x-ms-office365-filtering-correlation-id: 7ba95cc7-9e60-40e1-d531-08df07f46bd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|56012099006|11063799006|4143699003|10067099003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: Dk/D1NDjA1l5pnd4sfaFWk0BGbsI/ZVEEWDVNg51XvfrzAY5noRMnufGUIxqtEgcdVCNeIKfCs6fURxGttxC7TfJ4YRjU99loIhepAgiD/YWIcmGREYggV12ipVwAYpGiln/9Ho+l3VFqd7hW7IjcxaYyAkbL6Qd6XWesWDQ/vr9iwsYMIDH2VT72navR+N+vcxRR/aPAaKlGIXp3Wtqk3+sAK8igGRFY4+D7s4+yzI+H3mCBVYj2/yih+0GX12zLT3K+Svvp4AhAwwq/4QRuz+86e2mz0iJ0A46u8O2LOZblyT/OWmj5dpFmaFCXaZ41DJCLBUUpW9VKujAZCbMFPL8Jk6YA26R36dk4yRHkAhhZUFqZwNbFnVvAYH5hnD6tdS0tmJFZCBuQp9ELKwH6zRlifYS3QeXx1+x5kA5I04VV3++STern+DEtY4aUeiGTJmEpbw1NRiOPo0Rsdo51wzMQqc4bXDSvc818lnSQLpmmpivCxUQU6zVgXyrHy0O1OS1FeqgUN+0GutxjmIQGA37mnOtodlmvIEwqeY+Nn6Hz/0wEUMbcMPNzr0XZvL01QlCXoP4A+BE96IegOedMbHxdU13dgvcuZmVn4J5Cr2of5fY04idz/05Qi1MsaIL83AvfbnBfR1uxMeAQhYdV3bXpRTKytjKE7W+ZP7OPEA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGRRcFpVNHVsZWlwRUwveGM2cnBEdW1oeVg2TDR6WHdwU251RForbVptVHVH?=
 =?utf-8?B?Q244U0JuTmZCY0t4TzhDeWFvS2NaemdUbjU5QnFId2gyZnJjeWpGdklOZEs3?=
 =?utf-8?B?QjhLQ2Y0Q1BjS3FRazh2UHNyOEV2SUJiT1pFNTN2TkRTdGsyNkxpdzIzYmtK?=
 =?utf-8?B?ak5makI2cklJR3U1eGxXb2UzVDA1RndFMVRQem5LY0N3Z3hNak9XUTlGdEJn?=
 =?utf-8?B?SDQ5RnE0ZnMyUkF1NFZiYy9TeDVhRFpQZ1NkQ1BBM3oydFVvUTVlVE5vVEo2?=
 =?utf-8?B?eU9VcDFqMk43RXhZN1U5V1dtUGE5OFpDWFl0a1ZjWkhZNjlvSUwvWnZ2SjVj?=
 =?utf-8?B?NE94K3dYeVlBN0ZMYjJNeCtOakNSZVMzYjBacFFqQTlCMm5tMzJWVkVqbVlr?=
 =?utf-8?B?aXFvcmNudWszSXZTaXZSYlVXdm91WTNOa08weXZYM0xjSk1qNS82N1NFRm0w?=
 =?utf-8?B?UnFRNEdBUE43UVd6QWJlWlVMaU5MdThqcmFoVlgyWEYvZWxjcVY5OU1nWThL?=
 =?utf-8?B?WEV1UWhBRzc1UlYzaEt2YUJUbTc5bTNYRlJmSldSSko4WmlCa1VOSEJ5OE5M?=
 =?utf-8?B?aE4ra0Q3bWhLRzFMTUZCWjJrWGh0bkc0TGh2WTVzN1pLV1ZyWldIUk81MDFP?=
 =?utf-8?B?TlRvRUZIK1FJQ0ZiVGNHK3N4UHdjTHFxUThNWmVmQzN6MU51VnNLeUtNU2VC?=
 =?utf-8?B?cThtUmEzQTM1b056NzdhSmh5d1lMY0d0RUVTTmtzM29OdVdQekpGN096V3RU?=
 =?utf-8?B?MDU2eXAyVG85dWp1N01YRkxGVlZBUDg0VFdoTTdEVXZ0NVVTNkVVSnJTaGxE?=
 =?utf-8?B?bDRQQ0JMcmVlcEQ3bjJYMGhsRkhGdml2TWFvYUR3QzVBc1pxNkNmZWZ2WkZF?=
 =?utf-8?B?Zmh0SVo1VVlZbGRXWjZlVlNYL0p0bGFxa3hQT1YrWXFQZ1AyNWc1R0pEZWFV?=
 =?utf-8?B?QlNSRlNXenhlRDQ0OG45TWtteE1ZUVdaVWF6UnF5b3JITldHWnJNMUV1TXl3?=
 =?utf-8?B?NVRyY2I4S3N6YTl2dnRlRVB4K1VsY2ZKeWQyTko4S1FweGVPd2hPVmtVMHFP?=
 =?utf-8?B?WjJxNWQzWFdjdFE1N3pYRUhMaVJkTWR3QmJtQWRua2hBcUhqTlltNlMwQUNI?=
 =?utf-8?B?QUVEbm1Uc2pPYXVMait6Um9PblZ5dkluckcva21vOUFqTHByT0swWERoRk9u?=
 =?utf-8?B?OE8vTVRQL29CVGI2VUJPL3RwNkhGejRGU0xYdFU5bmxVVUltUlZqQ1JQODcv?=
 =?utf-8?B?TlpDeURyVzVES2N5OHY1YmxHYktycmphRU91YXdaZndvczRPWnhjdzUzUk5V?=
 =?utf-8?B?R2NrSnd4MUEwSHlBWm02dWc3TExnYWFKUDdBOUtaR0Q1MFpJUXZuTCttaUJm?=
 =?utf-8?B?Qi9RalU0bWZzUGpYWUEweXBzV1hsald0akJiT2dKTHNCNDk0bitBOXlvSFp1?=
 =?utf-8?B?YkUxaThlNCs1RUVzQkMzS2xHYlM3SkFSZHQ3bnRWTk8wejNwemU0aWUwalNB?=
 =?utf-8?B?eXFsVU1OaThVR1U4UGMzamljRit0aGFxWXBqNzFjVG4yQjBOYm9XTCtmc2Vx?=
 =?utf-8?B?bFA3L3NvSmR5dnRFSUtuSFlRcFJOdzlFdnNKSlcvcUU1dFpYT3g1VThPbUxG?=
 =?utf-8?B?WDc4NUQvN1pBTmlFUVcxWWtvSlBCWUdyS0RlZ01va1QxMS9GZ1YzOTFhWVB6?=
 =?utf-8?B?emc3V1RzU1QyQkIwNXM0SkdncldLdXAwS0FlRUtTWTN0akhLVXNNUHNSQVBu?=
 =?utf-8?B?WVhxQXBvbzgvYllYaVdIS25adm54RG9hU3hUY1I1OW56Q25vTmYvWWRZOWtF?=
 =?utf-8?B?bEhMZmFnN1ArSm1mNFlCSHUwcVd6a1Z1Z3lXVkl2VVVTZE11bjF0U054Z3Ja?=
 =?utf-8?B?V0J4ZlJUN1JtcS92SkhVT3BIV0VQRCttaEpGdlNvWHJWYW9URStrdHNYbnZB?=
 =?utf-8?B?MkVqNEJlSkY3TnlQRkphSHFTNGt6OEZTRzVCTlJJUWRneUp3WnpJeG81VStJ?=
 =?utf-8?B?Rm9hZGEvWkxueTBwWW5ZUU95VFVSQnpIVHFTdHJYUzZNcG1tWXVhNmUxWTNa?=
 =?utf-8?B?bElWbm55VWhpdUtDYVkxVjFXcmFLL2U5dk9OTnltOW1uVGN5Y2QzUEVkb244?=
 =?utf-8?B?ZTdla1E4czllNWpSVnZtMWhNVlBRcVp6c3ZNK3ZSRW9wS05STEF5ZC9WKzBr?=
 =?utf-8?B?Y2dkOU9yYW5OTmFNVE5XL2pDTmJIeUxHWlZyZ1crcGF3SlRYZGNwUUZCZlQw?=
 =?utf-8?B?eTBJeldWakFrSmI3elhWQUk5SlE2cjdmcWtHZHdQdit5TVpSbDUvYVAybUR0?=
 =?utf-8?Q?hlODregxot66G550Wa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba95cc7-9e60-40e1-d531-08df07f46bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 06:44:07.2400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ReqduUWg9nHBdgIZEW2JEGDABsB4hOPKEItGghglRgPnoKKh68rdk6kgToEW9U2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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

QU1EIEdlbmVyYWwNCg0KSSBqdXN0IHRoaW5rIGVpdGhlciB3YXkgaXMgb2suIEl0IGlzIGEgdXNl
ciBjb252ZW50aW9uIGRlZmluaXRpb24uDQpUaGFua3MuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IFdhbmcsIEtldmluIDxLZXZpbi5XYW5nQGFtZC5jb20+DQpTZW50OiBN
b25kYXksIEF1Z3VzdCAzMSwgMjAyNiA4OjQ4IFBNDQpUbzogTGF6YXIsIExpam8gPExpam8uTGF6
YXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRo
LkZlbmdAYW1kLmNvbT4NCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
Pg0KU3ViamVjdDogUkU6IFtQQVRDSCAwLzddIGRybS9hbWQvcG06IHN0YWdlIE9EIHJlc2V0IHVu
dGlsIGNvbW1pdA0KDQpBTUQgR2VuZXJhbA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgQXVndXN0IDMxLCAyMDI2IDg6MjIgUE0NCj4gVG86IFdhbmcsIEtldmluIDxLZXZpbi5XYW5n
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4g
PEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvN10gZHJtL2FtZC9wbTogc3RhZ2UgT0QgcmVz
ZXQgdW50aWwgY29tbWl0DQo+DQo+DQo+DQo+IE9uIDMxLUF1Zy0yNiA1OjM2IFBNLCBXYW5nLCBL
ZXZpbiB3cm90ZToNCj4gPiBBTUQgR2VuZXJhbA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+
ID4+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDMxLCAyMDI2IDc6MDYgUE0NCj4gPj4gVG86IFdhbmcs
IEtldmluIDxLZXZpbi5XYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiA+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgWmhhbmcsIEhhd2tpbmcNCj4gPj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IEZlbmcsIEtl
bm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAv
N10gZHJtL2FtZC9wbTogc3RhZ2UgT0QgcmVzZXQgdW50aWwgY29tbWl0DQo+ID4+DQo+ID4+DQo+
ID4+DQo+ID4+IE9uIDMxLUF1Zy0yNiA0OjI1IFBNLCBMYXphciwgTGlqbyB3cm90ZToNCj4gPj4+
DQo+ID4+Pg0KPiA+Pj4gT24gMzEtQXVnLTI2IDEwOjA1IEFNLCBLZXZpbiBXYW5nIHdyb3RlOg0K
PiA+Pj4+IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVu
IGdldCBlbWFpbCBmcm9tDQo+ID4+Pj4ga2V2aW4ud2FuZ0BhbWQuY29tLiBMZWFybiB3aHkgdGhp
cyBpcyBpbXBvcnRhbnQgYXQNCj4gPj4+PiBodHRwczovL2FrYS5tcy8gTGVhcm5BYm91dFNlbmRl
cklkZW50aWZpY2F0aW9uIF0NCj4gPj4+Pg0KPiA+Pj4+IFRoZSBwcF9vZF9jbGtfdm9sdGFnZSBp
bnRlcmZhY2UgZXhwb3NlcyBhIHN0YWdlZCBPdmVyRHJpdmUgd29ya2Zsb3c6DQo+ID4+Pj4gdXNl
cnMgZWRpdCBjbG9jaywgdm9sdGFnZSwgYW5kIHBvd2VyIHNldHRpbmdzLCB0aGVuIHdyaXRlICJj
IiB0bw0KPiA+Pj4+IGNvbW1pdCB0aGVtIHRvIHRoZSBTTVUuDQo+ID4+Pj4NCj4gPj4+PiBIb3dl
dmVyLCBQUF9PRF9SRVNUT1JFX0RFRkFVTFRfVEFCTEUgZG9lcyBub3QgZm9sbG93IHRoaXMNCj4g
d29ya2Zsb3cNCj4gPj4gb24NCj4gPj4+PiBldmVyeSBTTVUgdmVyc2lvbi4gU29tZSBiYWNrZW5k
cyByZXN0b3JlIHRoZWlyIGNhY2hlZCBzZXR0aW5ncw0KPiA+Pj4+IGFuZCB3YWl0IGZvciAiYyIs
IHdoaWxlIG90aGVycyB1cGxvYWQgdGhlIHJlc2V0IHRhYmxlIG9yIHNlbmQNCj4gPj4+PiBmcmVx
dWVuY3ktbGltaXQgY29tbWFuZHMgZGlyZWN0bHkgZnJvbSAiciIuIEFzIGEgcmVzdWx0LCB0aGUg
c2FtZQ0KPiA+Pj4+IHVzZXJzcGFjZSBzZXF1ZW5jZSBoYXMgZGlmZmVyZW50IGhhcmR3YXJlIGVm
ZmVjdHMgYWNyb3NzIEFTSUNzLg0KPiA+Pj4+DQo+ID4+Pj4gRm9yIGV4YW1wbGU6DQo+ID4+Pj4N
Cj4gPj4+PiAtIFNNVSAxNC4wLjAgYW5kIFNNVSAxMy4wLjUgc3RhZ2UgcmVzZXQgbGltaXRzIHVu
dGlsICJjIi4NCj4gPj4+PiAtIFNNVSAxNC4wLjIgYW5kIFNNVSAxMy4wLjYgYXBwbHkgcmVzZXQg
dmFsdWVzIGltbWVkaWF0ZWx5Lg0KPiA+Pj4+IC0gTmF2aTEwIHN0YWdlcyB0aGUgYm9vdCBPRCB0
YWJsZSwgd2hpbGUgVmVnYTIwIHJlYWRzIHRoZSBjdXJyZW50IFNNVQ0KPiA+Pj4+ICAgICB0YWJs
ZSBpbnN0ZWFkIG9mIHJlc3RvcmluZyB0aGUgc2F2ZWQgZGVmYXVsdHMuDQo+ID4+Pj4NCj4gPj4+
PiBUaGlzIHNlcmllcyBtYWtlcyAiciIgcmVzdG9yZSBkZWZhdWx0IHZhbHVlcyBvbmx5IGluIGRy
aXZlci1zaWRlDQo+ID4+Pj4gc3RhZ2luZyBzdGF0ZS4gImMiIHJlbWFpbnMgdGhlIHNvbGUgb3Bl
cmF0aW9uIHRoYXQgdXBsb2FkcyBhbiBPRA0KPiA+Pj4+IHRhYmxlIG9yIHNlbmRzIGZyZXF1ZW5j
eS1saW1pdCBjb21tYW5kcyB0byBQTUZXLg0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBnaXZlcyBwcF9v
ZF9jbGtfdm9sdGFnZSBvbmUgY29uc2lzdGVudCB0cmFuc2FjdGlvbiBtb2RlbDoNCj4gPj4+Pg0K
PiA+Pj4+ICAgICBlZGl0L3Jlc2V0IC0+IHN0YWdlZCBkcml2ZXIgc3RhdGUgLT4gY29tbWl0DQo+
ID4+Pg0KPiA+Pj4gUmVzZXQgc2hvdWxkIGJlIHJlc2V0IHRvIGRlZmF1bHRzIGFuZCBzaG91bGRu
J3QgcmVxdWlyZSBleHRyYSBjb21taXQuDQo+ID4+PiBUaGlzIGJyZWFrcyBleGlzdGluZyB1c2Vy
c3BhY2UgZm9yIFNNVSAxMy4wLjYuDQo+ID4+Pg0KPiA+Pg0KPiA+PiBJIHNlZSB0aGF0IHRoaXMg
YnJlYWtzIGV4aXN0aW5nIHVzZXJzcGFjZSBmb3IgYWxtb3N0IGFsbCBvZiBpdC4gU01VDQo+ID4+
IDEzLjAuMiBhbHNvIHJlc2V0cyB0byB0aGUgZGVmYXVsdCBjbG9ja3MgaW1tZWRpYXRlbHksIHdo
aWxlIG90aGVycw0KPiA+PiB1c2UgYSBmYWxsdGhyb3VnaCBsb2dpYyB0byBjb21taXQgdGhlIGNo
YW5nZXMgaW1tZWRpYXRlbHkuYXBwbGllZC4NCj4gPj4NCj4gPj4gVGhpcyBiZWhhdmlvciBuZWVk
cyB0byBiZSBrZXB0IGFzIGl0IGlzLg0KPiA+DQo+ID4gVGhpcyBiZWhhdmlvciBjaGFuZ2UgaXMg
aW50ZW50aW9uYWwsIGFuZCB0aGVzZSBwYXRjaOKAkXNlcmllcw0KPiA+IGludHJvZHVjZXMgYQ0K
PiB1bmlmaWVkIHRyYW5zYWN0aW9uYWwgbW9kZWwgZm9yIHBwX29kX2Nsa192b2x0YWdlOg0KPiA+
IC0gYHJgIHJlc3RvcmVzIGRlZmF1bHRzIHdpdGhpbiBkcml2ZXIgY2FjaGUuDQo+ID4gLSBvbmx5
IGBjYCBjb21taXRzIHNldHRpbmdzIHRvIFBNRlcuDQo+ID4gVGhlIGV4aXN0aW5nIGltbWVkaWF0
ZeKAkXJlc2V0IHBhdGhzIGFyZSBBU0lD4oCRc3BlY2lmaWMgaW5jb25zaXN0ZW5jaWVzLg0KPiA+
IFNNVSAxMy4wLjIgcHVzaGVzIGRlZmF1bHQgY2xvY2sgbGltaXRzIGRpcmVjdGx5LCB3aGVyZWFz
IG90aGVyDQo+ID4gYmFja2VuZHMNCj4gYWNoaWV2ZSBlcXVpdmFsZW50IHJlc3VsdHMgdmlhIHRo
ZSBjb21taXQgcGF0aC4NCj4gPiBUaGlzIHNlcmllcyB1bmlmaWVzIGJvdGggdW5kZXIgUG93ZXJQ
bGF54oCZcyBzdGFnZWTigJFyZXNldCBtb2RlbC4NCj4gPiBCdHcsIHVzZXIgc3BhY2UgZGVzaXJp
bmcgaW1tZWRpYXRlIHJlc2V0IHNoYWxsIGlzc3VlIGAiciJgIGZvbGxvd2VkIGJ5IGAiYyJgLg0K
PiA+DQo+DQo+IFRoaXMgaXMgd2hhdCBicmVha3MgZXhpc3RpbmcgdXNlcnNwYWNlLg0KDQpBcyBz
dGF0ZWQgZWFybGllciwgdGhpcyBzZXJpZXMgZml4ZXMgaW5jb25zaXN0ZW50IGRyaXZlciBiZWhh
dmlvci4gTm90ZSB0aGF0IGRpdmVyZ2VudCBzZW1hbnRpY3MgYWxyZWFkeSBleGlzdCBhY3Jvc3Mg
QVNJQ3MgdG9kYXk7IHdpdGhvdXQgdGhpcyBmaXgsIG1lcmVseSBhIGRpZmZlcmVudCBzdWJzZXQg
b2YgQVNJQ3Mgd291bGQgYmUgYWZmZWN0ZWQuIFRoZSBzZXJpZXMgYnJpbmdzIHRoZW0gdW5kZXIg
YSB1bmlmaWVkIHRyYW5zYWN0aW9uYWwgbW9kZWwuDQoNCkhpIEBEZXVjaGVyLCBBbGV4YW5kZXIg
QEZlbmcsIEtlbm5ldGgsDQpGb3IgZHJpdmVy4oCRYmVoYXZpb3LigJFjaGFuZ2UgY29uY2VybnM6
IEnigJltIHVuc3VyZSB3aGljaCBmaXggZGlyZWN0aW9uIGlzIGJldHRlci4gU3RpbGwsIGNvbnZl
cmdpbmcgYWxsIGhhcmR3YXJlIHVwZGF0ZXMgaW50byB0aGUgJ2MnIGNvbW1pdCBhaWRzIGRyaXZl
ciBzdGF0ZSBtYWludGVuYW5jZS4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCg0KPg0KPiBPbmx5
IFNNVSAxNC4wLjAvMTMuMC41L05hdmkxMCBhcmUgbm90IHJlc2V0dGluZyB0byBkZWZhdWx0IGNs
b2NrcyB3aXRoICdyJw0KPiBvcGVyYXRpb24uIFRoZSBkb2N1bWVudGF0aW9uIGFsc28gZ2l2ZXMg
dGhlIGltcHJlc3Npb24gdGhhdCAncicNCj4gZG9lc24ndCByZXF1aXJlIGEgY29tbWl0Lg0KPg0K
PiAiSWYgeW91IHdhbnQgdG8gcmVzZXQgdG8gdGhlIGRlZmF1bHQgcG93ZXIgbGV2ZWxzLCB3cml0
ZSDigJxy4oCdIChyZXNldCkNCj4gdG8gdGhlIGZpbGUgdG8gcmVzZXQgdGhlbSINCj4NCj4gVGhl
IHBhdGNoIHNob3VsZCBiZSB0byBjb3JyZWN0IHRoZSBub24tY29uZm9ybWluZyBvbmVzIHJhdGhl
ciB0aGFuDQo+IGVuZm9yY2luZyBhICdjJyBvcGVyYXRpb24gdG8gcmVzZXQuDQo+DQo+IFRoYW5r
cywNCj4gTGlqbw0KPiA+IEJlc3QgUmVnYXJkcywNCj4gPiBLZXZpbg0KPiA+DQo+ID4+DQo+ID4+
IFRoYW5rcywNCj4gPj4gTGlqbw0KPiA+Pg0KPiA+Pg0KPiA+Pj4gVGhhbmtzLA0KPiA+Pj4gTGlq
bw0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pg0KPiA+Pj4+IEl0IGFsc28gcGVybWl0cyB1c2Vyc3BhY2Ug
dG8gcmVzZXQgYSBzdGFnZWQgY29uZmlndXJhdGlvbiwgYWRqdXN0DQo+ID4+Pj4gb25lIG9yIG1v
cmUgc2V0dGluZ3MsIGFuZCBzdWJtaXQgdGhlIGZpbmFsIGNvbmZpZ3VyYXRpb24gd2l0aCBvbmUN
Cj4gPj4+PiBjb21taXQsDQo+ID4+IHdpdGhvdXQgdGVtcG9yYXJpbHkgYXBwbHlpbmcgYW4gaW50
ZXJtZWRpYXRlIGRlZmF1bHQgY29uZmlndXJhdGlvbi4NCj4gPj4+Pg0KPiA+Pj4+IExpbms6IGh0
dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vd29ya19pdGVtcy81NjkwDQo+
ID4+Pj4NCj4gPj4+PiBLZXZpbiBXYW5nICg3KToNCj4gPj4+PiAgICAgZHJtL2FtZC9wbTogc3Rh
Z2Ugb2QgcmVzZXQgZm9yIHNtdSAxMS4wLjcNCj4gPj4+PiAgICAgZHJtL2FtZC9wbTogc3RhZ2Ug
b2QgcmVzZXQgZm9yIHNtdSAxMy4wLjINCj4gPj4+PiAgICAgZHJtL2FtZC9wbTogc3RhZ2Ugb2Qg
cmVzZXQgZm9yIHNtdSAxMy4wLjAvMTMuMC43DQo+ID4+Pj4gICAgIGRybS9hbWQvcG06IHN0YWdl
IG9kIHJlc2V0IGZvciBzbXUgMTMuMC42DQo+ID4+Pj4gICAgIGRybS9hbWQvcG06IHN0YWdlIG9k
IHJlc2V0IGZvciBzbXUgMTQuMC4yDQo+ID4+Pj4gICAgIGRybS9hbWQvcG06IHN0YWdlIG9kIHJl
c2V0IGZvciBzbXUgMTUuMC44DQo+ID4+Pj4gICAgIGRybS9hbWQvcG06IHN0YWdlIG9kIHJlc2V0
IGZvciBzbXUgdmVnYTIwDQo+ID4+Pj4NCj4gPj4+PiAgICAuLi4vZHJtL2FtZC9wbS9wb3dlcnBs
YXkvaHdtZ3IvdmVnYTIwX2h3bWdyLmMgfCA3NQ0KPiA+PiArKysrKysrKysrKysrKy0tDQo+ID4+
Pj4gICAgLi4uL2FtZC9wbS9zd3NtdS9zbXUxMS9zaWVubmFfY2ljaGxpZF9wcHQuYyAgIHwgIDIg
Ky0NCj4gPj4+PiAgICAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMg
ICAgfCAxNSArLS0tDQo+ID4+Pj4gICAgLi4uL2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3Yx
M18wXzBfcHB0LmMgIHwgIDIgKy0NCj4gPj4+PiAgICAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUx
My9zbXVfdjEzXzBfNl9wcHQuYyAgfCA4NQ0KPiA+Pj4+ICsrKysrKysrKystLS0tLS0tLS0NCj4g
Pj4+PiAgICAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYyAgfCAg
MiArLQ0KPiA+Pj4+ICAgIC4uLi9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8yX3Bw
dC5jICB8ICAyICstDQo+ID4+Pj4gICAgLi4uL2RybS9hbWQvcG0vc3dzbXUvc211MTUvc211X3Yx
NV8wXzhfcHB0LmMgIHwgNTAgKysrKysrLS0tLS0NCj4gPj4+PiAgICA4IGZpbGVzIGNoYW5nZWQs
IDE0NSBpbnNlcnRpb25zKCspLCA4OCBkZWxldGlvbnMoLSkNCj4gPj4+Pg0KPiA+Pj4+IC0tDQo+
ID4+Pj4gMi41NS4wDQo+ID4+Pj4NCj4gPj4+DQo+ID4NCg0KDQo=
