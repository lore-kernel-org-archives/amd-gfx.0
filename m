Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315E7FED2EB
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 08:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A699210EA06;
	Thu, 12 Mar 2026 08:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qzMSZhzh";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D6B10EA06
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 08:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0OihyHFn47EF2tqL/p7dfy2XdxGOFsm4fw5ZRWTNLljDi5U7g/14lIe+5PgdWZWHvwrvk1kGHEo2WR6QWfYXAMe+4wN7F624+YGq/4g6rozqORrbXx5iT9FkTtRY+ssp3nT6uVvPi5pBiUybWAFT0WR4A5damqAvQFtu8bqU/yI1AOSutvN8NLyQY6MlOWSWFRpKGce3DLgkEGwcbO+puMsdX7gi1W5sg3B+ENWRbEPd8n8ZEHWMEFkhj7FLgCbQLlWeECj+psBJH/h9yqw9lYdy3YJfUswv9eZHETDg+CdDRR+MDBRYyixXT2v9gl2qLDB/pDoI0PS5PjzkumZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPrNH0T5Spim1PoMg7R7+2k4W1xgbmuZgRza4YjjQd8=;
 b=EIu2csdgBR6Pxw+r8gZW8WBpR/bFRYyiDbuQu+eRJ0lgCbAKrDLiWdWBpWAWoThu9HpKcBl+PUF4YDHCm7ePRWPHcbu/CBgYgPt3xGktCQkTFtvuD/VTmhuGTA5KjQcO6Jz1LuWnqxG5B9SHlmL0Ng+v/GNbolfHzQ2z9QO+gOTymVsnIlgnwPRV6R2jbuFKKyVyiOZiFNUfLYBuxbLEmBHDcnQ6ltb/bgmOkuLn+fGZZsyH5KfnSYcKO1fOaZNEH806rTpBH+2wY9IZ3UnoBqTBRXm7qR081u4/ipMW6g0lqXilYyAzXdyoux2byxqoiNnrZmHx0PVgk6PfGlGUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPrNH0T5Spim1PoMg7R7+2k4W1xgbmuZgRza4YjjQd8=;
 b=qzMSZhzhjDNvKKw9AYBJpeRzPdkcN7MCu4XMjiJU4DNJsg5rgCHTKinmunA/6TKLxq+/KWFaZwiuWKC52KNdfi3AdUVo9LZMs6X3i3illmnAkVhdqklFY+lwJ+oeeVcdkiTQxz7Ja7E5I7ZVPRSXLwbCTOxAzHZSf1413EGU714=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 08:33:24 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 08:33:23 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add overflow check for BO list array
 allocation
Thread-Topic: [PATCH] drm/amdgpu: add overflow check for BO list array
 allocation
Thread-Index: AQHcsfjR6VM9S6ppOE6vIukI9J/9krWqjuGAgAABrQA=
Date: Thu, 12 Mar 2026 08:33:23 +0000
Message-ID: <DM4PR12MB5152B6F41902A41DAF0364B0E344A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260312081827.1484742-1-Jesse.Zhang@amd.com>
 <ff117d6b-943a-4555-834c-96b53bd20057@amd.com>
In-Reply-To: <ff117d6b-943a-4555-834c-96b53bd20057@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-12T08:28:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN0PR12MB6318:EE_
x-ms-office365-filtering-correlation-id: 1d803284-4f9e-4f8e-6921-08de80120621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003|7053199007;
x-microsoft-antispam-message-info: HyQht1xHOmr9fUz7M/mM8uW0P3e3Wg/cdQLjZxuUjS1cP1GYAqqpHIsKg0vVfm8+zg5FX+D6by15HRGfrw7Lfn3YZA2z5Jzw+SwWyNOqCtoc6VLxeuf4uv0afb9a/cULauFYKz+9DJxoJ0anOR52i5x09Z8vKJZ8nWrvRX6Cq8rpmt667W0+GmLg17lrwIb2gfY5L7o3wRwYqkrGdGZn9Sn/NsqoXEu/2uKe2MPuClpPXnb9NmgT7QvDdKVpAAhfrdvgMfHXezKMG2l0+vU5YIDkhDaI+z//Xf6Hr8u6dgHWrKH2dEeNLJcsBKzHCZ6WFkobAgXtogalyeQy331h5zqEOgWRTAHddPDKpSQFhq6jgSL/wIJynQ9gQBEU0oPQFE8mn4GJeO/T2h9HvxT30s7HPpJwe0Vv7w9JJ6BsdorJ5C5xRemz5qD0LIIZjOzgONcVjxh5U/V8gslbENU+1U2YD+t1B31jztwK5D13OWNYbKB+h+7zy+VFX/atq2J42co/j3UZaE6ZeXCmYNpdAthMsr1hKyZ/sjKq0he00AmqltIOOH64Dkhgaz46Z0rOpERzEISK8xzCd2FSFL8vNb7OMDNTu1JxpxvYuHJ1etMczQU3ySLO/evQUx90UN2kM7g9ajuHXsJMmvfq/cjgKrxPppJ2y2INjrSdbeF/Y5YeSvhMzZ28MUVrI9HijaBk8653EQXvOWh589lDHkITXxy1u3A38YyUQTXQ8FnanJt9PsGwOCxh98adK6zZNOl/2Q1OwvqQUHndTy5aoA9DnOPVRKK3m78hh8vCQFCdTZA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VStQNmpxUktneDFTSFp3akpLb2JDRDRhVTFkQS81eVRMMVhNMmF2WTI2VmFW?=
 =?utf-8?B?UVNxRmF6QzIvNVROVVhUOXo0VjFKOWsvcUpUSlpCcmNHeVljbG1USHE4bXFO?=
 =?utf-8?B?WXJudS9wZEFLU2loY21DdVlFN2xiUlZTSXpVdm5Wak9DeURBa2o0d0tudVFN?=
 =?utf-8?B?QmpGcFo2d1ZWaFpUMDN4cS9UdGtUTUZiMXcvdzUxSU1PZE1BK1FNNFpoaTJR?=
 =?utf-8?B?bERIdkE5Q0V3SVlVdGJLYjA5UlRsUGViTnpPNTJhbVlhSHVycVdnV25weU1t?=
 =?utf-8?B?Z2U5b2svNVlCdUJrYlZKREc4Z0taNW9YSDhNRm5mZnY5Vmg4b0pRZU52OWJk?=
 =?utf-8?B?M2ZGaDk5WlE5RWhGaE5hd0MwaWlNV25EZU15cEwvQjBnSU9MYWppMlcrS25k?=
 =?utf-8?B?UUpkMFk0OU9UcStiRHUxRmRUS1c5b2NqSHkydFFNQ3lHTTVod2VmdFczZUoz?=
 =?utf-8?B?MFJjZkZQKzBGd2ZwbzBOUzNycmRWQVJVM1BqbzNsVHRiZ1hWanV2T1o4cDA1?=
 =?utf-8?B?WU0zMWxqdGR3VEVGa3ByREZsY0tWaHplYVZqQS93L3grNFI4ek9wVmVGVk56?=
 =?utf-8?B?cCthY0NRS0tuZFROZDFQWk85SHVLQW00amZzNVZBamo3dVlaT0tLSzBTNU11?=
 =?utf-8?B?N3pxSDFzUEhaakluQU9lMzEzVSs4dUQvNDBqY0VVcUFoRHExbjluYjI0N1JB?=
 =?utf-8?B?czBnVnM1SEVJMGppSFRWeThQak5ueDhyUWZPczRaWVhURmY5WThac09RVDhh?=
 =?utf-8?B?Y28rYXlUd0FUM3VYQ0gxNUF2QzMzdDNiWmUyaGVUQStDWFNWZkoxd3NacDk3?=
 =?utf-8?B?MnhGRzFadXdJMVZ5bWVtNlN0dFBVZFhXWk9DRlpjOEptQjEzK1hiZVc0WkQ1?=
 =?utf-8?B?aGFYZUpMMk04OEF1SUJFR0kzUlQzTDIyQk52OVNVRlRlbGJCSG53aXV0eVR1?=
 =?utf-8?B?N3Q2cUtJbWZFUUxiZjBJZi92NkdHWVo5NzBkWHJaM0lWYXlKcGNuUFVUQWty?=
 =?utf-8?B?VnVnR25VbHQrK3crbmJlSjFuajNrdXBQRG51MXNhcEpYVDRuN1NNYXpiUVF3?=
 =?utf-8?B?Q2V2OEJOdG5ZcldoUDJ3MUtyeSs1ZGZKeDhCbWdoOHFpUi9kb3BQQVcrM3pr?=
 =?utf-8?B?RDJzTldTQWdUb21hV1poZ2ZsK2ZnVUE5Qnc1R1cwMEloTFJQQ016azFPdzI1?=
 =?utf-8?B?ZCtxZ1g3RkptUC9OVWl1NXZKdWRmSlNhVDl4YjRidFZPVDB3dVk4K0xTSDlF?=
 =?utf-8?B?S0ZhNGZnUGpLa1pOQmdQMjZjUzg0QS9jVVFJRU9TRGdNNlUySGZxZ2E4aE83?=
 =?utf-8?B?amVuZ0NPT1dsR0dsdHA5N2lJL2FLdU9pWVFLV2VBaUpiK1RkSW5FK1RtcEdD?=
 =?utf-8?B?THlnbkFqSmV2Z2VKQ2dhTHV0bWtTMzd0M1htVXNtemdVeDdXTGlEd2tkbnBB?=
 =?utf-8?B?RGhrdjRGcVlnTzJ3KzlFK0NBMG5UTmZpc3hhMDJmMDY0MEdVQTdSWTFBSGJv?=
 =?utf-8?B?TzhjbTRTd3VUMEsxeVZ6U2d0WEJ2K3J1N3F0c1huL1BDNHRPZG0zMzExWXVZ?=
 =?utf-8?B?M0tIV3JaQVd3T2VobmJQYi85K1poamw5cllWUlIzR1B1eVI1SkhUTlNUMmVk?=
 =?utf-8?B?eWMwanM4VCtPaVFzT3ZGZXgrTWU5Mk9wcXVabTNvWjd3TzdNUlBScjBqUW5w?=
 =?utf-8?B?Z1gyUzVMKzFObFVwOXVXTFZPM1dIV0JsL3pFcHEyTitlL1NxZW1hVkxmSmNQ?=
 =?utf-8?B?R3BuV0ltYk9pUjJSNXJZbW1FWEV0eVBwem0zTE1wNFJkN3J4YlFJSUU4dGlp?=
 =?utf-8?B?QzZUeFRjdVU3dlVnWWdyNGYzaW4zdDVRSUhPTk1pNTVlZjVaT2kveDhBcXMw?=
 =?utf-8?B?a05XT0NBWllNWVg0a1J5MWhGYyt4T1J2QmpEYUlXOGhNT2Q5NS92YjJIRHhW?=
 =?utf-8?B?WEhRZ0NYWGZncmhnMGNUWEE2UnZ0WmpBcWE2a2ZpNGg5cVR5dmxTVjFXd1d2?=
 =?utf-8?B?THJoOHFUTzR2b1plZ1BIS1V4Q1lGSnNRNVp5N1dVY1pZSzk1bEp5c3hqQ2F6?=
 =?utf-8?B?RkF2R080ZkJwM20zVWJhMUNZaFJPYU44OHBTZXA5T1NUMC8zZ01wNnV4c2dn?=
 =?utf-8?B?dGhsVFVpNEVrZzBRNGM3dFgvamFxRlgrUzVOUjFDZ3BpQlFJbDlpWVBITFFr?=
 =?utf-8?B?MFZqRzF3OGgxRUdBZ2NSV21lYndTSnAyZ29BUUJaa3BFamo5b0FvT1ZBS2ZI?=
 =?utf-8?B?aXFYL0tyVHFramdCK3dwaUpWSmw5ckFiTUpYcjlKaUswVEI5UlNsQ2Uzd0ky?=
 =?utf-8?Q?wm3iKqUcdyUMlUc2Wg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d803284-4f9e-4f8e-6921-08de80120621
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 08:33:23.3701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVAC9d3fSaFfBxYo1VDwBROraN1gAOCMQnsuTcSf9EKXe3qoPIEAIQlG8RHL67PZ9ZcI5mPyBfl1Pe0k4A98Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTIs
IDIwMjYgNDoyMyBQTQ0KPiBUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBhZGQgb3ZlcmZsb3cgY2hlY2sgZm9yIEJPIGxpc3QgYXJyYXkgYWxsb2NhdGlv
bg0KPg0KPiBPbiAzLzEyLzI2IDA5OjE4LCBKZXNzZS5aaGFuZyB3cm90ZToNCj4gPiBXaGVuIGFs
bG9jYXRpbmcgbWVtb3J5IGZvciBhIEJPIGxpc3QgYXJyYXksIHRoZSBtdWx0aXBsaWNhdGlvbg0K
PiA+IGJvX251bWJlciAqIGluZm9fc2l6ZSBtYXkgb3ZlcmZsb3cgb24gMzItYml0IHN5c3RlbXMg
aWYgdXNlcnNwYWNlDQo+ID4gc3VwcGxpZXMgbGFyZ2UgdmFsdWVzLiBUaGlzIGNvdWxkIGxlYWQg
dG8gYWxsb2NhdGluZyBhIHNtYWxsZXIgYnVmZmVyDQo+ID4gdGhhbiBleHBlY3RlZCwgZm9sbG93
ZWQgYnkgYSBtZW1zZXQgb3IgY29weV9mcm9tX3VzZXIgdGhhdCB3cml0ZXMNCj4gPiBiZXlvbmQg
dGhlIGFsbG9jYXRlZCBtZW1vcnksIHBvdGVudGlhbGx5IGNhdXNpbmcgbWVtb3J5IGNvcnJ1cHRp
b24gb3INCj4gPiBpbmZvcm1hdGlvbiBkaXNjbG9zdXJlLg0KPiA+DQo+ID4gQWRkIGFuIG92ZXJm
bG93IGNoZWNrIHVzaW5nIGNoZWNrX211bF9vdmVyZmxvdyB0byBkZXRlY3Qgc3VjaCBjYXNlcy4N
Cj4gPiBBbHNvIGVuc3VyZSB0aGUgcmVzdWx0aW5nIGFsbG9jYXRpb24gc2l6ZSBkb2VzIG5vdCBl
eGNlZWQgSU5UX01BWCwgYXMNCj4gPiB0aGUgc3Vic2VxdWVudCB1c2VyIGNvcHkgb3BlcmF0aW9u
cyBtYXkgcmVseSBvbiB0aGlzIGxpbWl0Lg0KPiA+IFJldHVybiAtRUlOVkFMIGlmIGVpdGhlciBj
b25kaXRpb24gZmFpbHMuDQo+DQo+IFRoYXQgaXMgY29tcGxldGVseSB1bm5lY2Vzc2FyeSwgdm1l
bWR1cF9hcnJheV91c2VyKCkgYWxyZWFkeSBkb2VzIHRoYXQgY2hlY2suDQo+DQo+ID4NCj4gPiBB
IGNyYXNoIGxvZyBpbGx1c3RyYXRpbmcgdGhlIGlzc3VlOg0KPiA+DQo+ID4gWyAyOTQzLjA1Mzcw
Nl0gUklQOiAwMDEwOl9fa3ZtYWxsb2Nfbm9kZV9ub3Byb2YrMHg1YmUvMHg4YTANCj4gPiAuLi4N
Cj4gPiBbIDI5NDMuMDUzNzI1XSBDYWxsIFRyYWNlOg0KPiA+IFsgMjk0My4wNTM3MjhdIGFtZGdw
dV9ib19jcmVhdGVfbGlzdF9lbnRyeV9hcnJheSsweDQyLzB4MTMwIFthbWRncHVdIFsNCj4gPiAy
OTQzLjA1Mzk0N10gYW1kZ3B1X2JvX2xpc3RfaW9jdGwrMHg1MS8weDMwMCBbYW1kZ3B1XSBbIDI5
NDMuMDU0Mjc3XQ0KPiA+IGRybV9pb2N0bCsweDJjYi8weDVhMCBbZHJtXSBbIDI5NDMuMDU0Mzc5
XSBfX3g2NF9zeXNfaW9jdGwrMHg5ZS8weGYwDQo+ID4NCj4gPiBUaGUgb3ZlcmZsb3cgb2NjdXJz
IGluIHRoZSBhbGxvY2F0aW9uIGluc2lkZQ0KPiA+IGFtZGdwdV9ib19jcmVhdGVfbGlzdF9lbnRy
eV9hcnJheSwgbGVhZGluZyB0byBhIGNyYXNoIGluIHZtZW1kdXBfdXNlcg0KPiA+ICh2aWEgX19r
dm1hbGxvY19ub2RlX25vcHJvZikuDQo+DQo+IEhvdyBhbmQgb24gd2hpY2gga2VybmVsIGNhbiB5
b3UgcmVwcm9kdWNlIHRoYXQ/DQpXZSBhcmUgZGV2ZWxvcGluZyBzb21lIGZ1enogdGVzdHMgZm9y
IHRoZSB1bmlmaWVkIHByb2plY3QuDQpUaGUgdGVzdHMgaW52b2x2ZSBwYXNzaW5nIGRpZmZlcmVu
dCBsZXZlbHMgb2YgZ2FyYmFnZSBkYXRhIGFuZCBlbnN1cmluZyB0aGUga2VybmVsIGNhbiBoYW5k
bGUgdGhpcyBkYXRhIGNvcnJlY3RseS4NClRoaXMgaXNzdWUgY2FuIGJlIHJlcHJvZHVjZWQgb24g
dGhlIGFtZC1zdGFnaW5nLWRybS1uZXh0IGJyYW5jaC4NCg0KVGhhbmtzDQpKZXNzZQ0KPg0KPiBS
ZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZS5a
aGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYyB8IDggKysrKysrKy0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMNCj4gPiBpbmRleCA4N2Vj
NDZjNTZhNmUuLmVmYWIzOWJhN2Y1MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYm9fbGlzdC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYw0KPiA+IEBAIC0yOSw2ICsyOSw3IEBADQo+ID4gICAq
Lw0KPiA+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zb3J0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9vdmVyZmxvdy5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPg0KPiA+DQo+ID4g
ICNpbmNsdWRlICJhbWRncHUuaCINCj4gPiBAQCAtMTg3LDYgKzE4OCwxMSBAQCBpbnQgYW1kZ3B1
X2JvX2NyZWF0ZV9saXN0X2VudHJ5X2FycmF5KHN0cnVjdA0KPiBkcm1fYW1kZ3B1X2JvX2xpc3Rf
aW4gKmluLA0KPiA+ICAgICBjb25zdCB1aW50MzJfdCBib19pbmZvX3NpemUgPSBpbi0+Ym9faW5m
b19zaXplOw0KPiA+ICAgICBjb25zdCB1aW50MzJfdCBib19udW1iZXIgPSBpbi0+Ym9fbnVtYmVy
Ow0KPiA+ICAgICBzdHJ1Y3QgZHJtX2FtZGdwdV9ib19saXN0X2VudHJ5ICppbmZvOw0KPiA+ICsg
ICBzaXplX3QgYWxsb2Nfc2l6ZTsNCj4gPiArDQo+ID4gKyAgIGlmIChjaGVja19tdWxfb3ZlcmZs
b3coKHNpemVfdClib19udW1iZXIsIChzaXplX3QpaW5mb19zaXplLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICZhbGxvY19zaXplKSB8fCBhbGxvY19zaXplID4gSU5UX01BWCkNCj4g
PiArICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICAgICAvKiBjb3B5IHRoZSBo
YW5kbGUgYXJyYXkgZnJvbSB1c2Vyc3BhY2UgdG8gYSBrZXJuZWwgYnVmZmVyICovDQo+ID4gICAg
IGlmIChsaWtlbHkoaW5mb19zaXplID09IGJvX2luZm9fc2l6ZSkpIHsgQEAgLTIwMSw3ICsyMDcs
NyBAQCBpbnQNCj4gPiBhbWRncHVfYm9fY3JlYXRlX2xpc3RfZW50cnlfYXJyYXkoc3RydWN0IGRy
bV9hbWRncHVfYm9fbGlzdF9pbiAqaW4sDQo+ID4gICAgICAgICAgICAgaWYgKCFpbmZvKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4NCj4gPiAtICAgICAgICAg
ICBtZW1zZXQoaW5mbywgMCwgYm9fbnVtYmVyICogaW5mb19zaXplKTsNCj4gPiArICAgICAgICAg
ICBtZW1zZXQoaW5mbywgMCwgYWxsb2Nfc2l6ZSk7DQo+ID4gICAgICAgICAgICAgZm9yIChpID0g
MDsgaSA8IGJvX251bWJlcjsgKytpLCB1cHRyICs9IGJvX2luZm9fc2l6ZSkgew0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKCZpbmZvW2ldLCB1cHRyLCBieXRlcykp
IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAga3ZmcmVlKGluZm8pOw0KDQo=
