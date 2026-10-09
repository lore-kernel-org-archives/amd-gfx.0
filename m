Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D39CA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 06:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EBD10FE66;
	Fri,  9 Oct 2026 06:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RvVwPLBi";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3816A10FE66
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 06:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn+bf0B/Vo+n9G/2rY05zrqDfOA/mUTz8Py8KB7tk3X+hF1ExjQ1QXrqPjDkzmMx/9MVqgITgKv3CmlFykUDd2T7cmz0vsmVqjKZz1uy5DoKqnrZx7A+iFd6xmRgIChKu8mwvQdZkcPlNeV8Yb7pfs0Cm/TutV1GiH4pyAyijpLphdHgxhiLPsGtlGXLFWTe+sOZZZfvuM4IfH8mDVBJZ79DVVPp/voOfBqOUjfcwMDnBDuxyvcUiN9VVG+zPK8oiIpHbUmf+XrYhZ/DAjV00OwByDGjO5PiCn1nos1osZv982+a9eivCUKoMEsbtWwGo5zSgbBaJcxI1bfvWXrUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtOGwjaL5rg4xFItXv6nsV/vj5IeibWRDZ5Vq8xPpcI=;
 b=XITsqTHO7OWGCN7lXKq8STxT1aLumYd+Buxs9QniiBC1gczeP4OjF0H/zcq+re03xJyj+U1HjLenF/rSpBsiRZi4EzxjmcxmNojbAjpYSZGV6tZP/3B+RNbGnE/vzVLcCJ9kc2NHFU3E4bu7EJLvMO9drGq3zkFkTTPJOPGspmfw/7QU8zLzKJF8/qwIAvTBH4d5RuPa9F+Cu+yjA0wi3J8IJqax18iiIMnG6pMfiZ0ti0eIY2MI6OL1xY0cv/4L8/5IvZSSh6kCaCj0ZaBOR8K1NlPGHCvFM08qf7nI8GeWLrLg8626ENaaaTGP8YXeukp84N87AviBtBwdbSAi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtOGwjaL5rg4xFItXv6nsV/vj5IeibWRDZ5Vq8xPpcI=;
 b=RvVwPLBiof3STw3F7xDHD2R4d3St4DSck8cyjT74cbZlBJrLGq1IbVXRKaWwAeHGGw9V12nM8eUhU0qOiR5WTBD1DI+e2qEFaMeqbeTp5ERbbeaV042aQGi36KNLpwID9TOKkJsFBfJt5k6hE/eD3YZXFqnjHIWTulPwLPq8n0s=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:20:00 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 06:19:59 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
Thread-Topic: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
Thread-Index: AQHdT8U/OFtQTBjuH020GWqQmH3vt7bznoUAgAAEbACAAAA28IAA+tIAgAAVxYCAABTgAA==
Date: Fri, 9 Oct 2026 06:19:59 +0000
Message-ID: <PH7PR12MB60004BE15CAB1279EFDEBEC0FB922@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-9-Prike.Liang@amd.com>
 <0375ebd0-df28-437c-b6b4-47f06d4d1a24@amd.com>
 <5ff3175a-a8fb-49d4-b40a-36ab460f8ca0@amd.com>
 <PH7PR12MB6000ADDBADE18139E2B7401BFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB600066077324CFC6B1BAA16FFB922@PH7PR12MB6000.namprd12.prod.outlook.com>
 <7f51bd62-7a74-4cbc-95d1-5c31d52fde31@amd.com>
In-Reply-To: <7f51bd62-7a74-4cbc-95d1-5c31d52fde31@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-09T06:04:44.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|MN2PR12MB4189:EE_
x-ms-office365-filtering-correlation-id: f7f96c8b-8c6c-4616-4268-08df25cd5874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: nDSg8r2e9Ymv86IIKqetGMmQyUvmhwdzAO7i1R+1IUmOwnw5Klgu+nIq9c/lap4sfKQuiv7I+PwaPCXFxMPGL4rhDhAa42G66b7QTU5w3OfiYrVtUWk6b/Xs4Lv+c9nvP6ZlGdQEwtXKv0TqAj4eBkVd9Bg7Sk5ATIpa94IeJ7bQelhUn99itQSGQJSWKm1QUIUR6OeNKpobnKcB1pZUUAh5ikO1rLqKUsQfuBZbUhC3mJ9gNYz3m+/FKjHr+nkvpBIvvgNPrPKunvTO9MYL0H43B+0WfItVNwrGy3Eokh2947zAttlt6HZot424frsjHFwt4/LBIcCvkyF6mGx7YP2C4zVxYpn5fkg1qNd/VJSCa4MU8wlVcYfL6i5DmAE05v8GpPwC98Mdzjg/BwO/gZwb5TkTK0ACvmETyGvMMm/do0DeUD4XanZgA2mX9c+pmr/YNYVDQwLEG+tZjOLWzy775HfGnKCOiJJ0WTK5aDjygzblN0mrPR4mz7IJsDzJ9UwGzHLsxI6irUuOfRoq7VxBcE6Rq7Ehzf+WibTY8Wnmss6PtS2uE91n1TvQceOH4yeH931BV7VaIqB8pSjEhDE8xUBu8EPU2/ON1GITfZ3zThLI6/4bmWzCzcKz2oEbe5yzswuiXG5HlA7HrTZ4gssrS2uHrramGMqgYOxkaH5ez0nolIWGyZN5F+fjkNQ0RKl1DVQlne46H2Mnnwup311Q3EAmHnp+4djzruouUbc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3hpUWF6bXRud3pJODR0UVU4RVppbkZ6TG9HRWs0REQxZHJJelNMOWgzaFNM?=
 =?utf-8?B?S2JVTjFRaGM2L1lQNlNVVWxYR2d2Z0tlOXZsUmVDVkl0QlVNMUtxVklsKzYx?=
 =?utf-8?B?d1dQaXBPWjc1QzB4ZGVDVG5PZkR5cE5OV0FwdDlNYnFsejlRMGJMZnliRm1J?=
 =?utf-8?B?WjVteHArRmR0eXJlMGdiMWtLdG9NSVIydGpyOFhGcEt4YjRWSzYrMkRXa3dB?=
 =?utf-8?B?SGlqWDVPckZ0Z2hDbFFienpON2ZNRnBzRzRIMnVJcHk1YURGaEl2cVBwOTd1?=
 =?utf-8?B?RWhJRndNN2Zkc2NqQnQxa0Q3dU4zM044NWJCQ3RXODVWMzRhQ2hCd3h3RitN?=
 =?utf-8?B?anpqMnV6TUlGM3o1a203czBybU1VSVR3cnVBSXo2eVhueTFQbkVyL1RsSWM4?=
 =?utf-8?B?RXlHdUYwK1hrbDJxMytKOFZDVWlSUUpSRnlTQkQxcHRoZ0tPRUxrVmE2OUFE?=
 =?utf-8?B?RDM3VkZqM2h2bitVYXNiVnJQZElTckU0aGthYkVpVE83TzFBSkQ3OHNGTDZr?=
 =?utf-8?B?OVJ6ejdxeGYyN2xrTWhLZ1J5endzSEhDUXVZT2cwdnI4SjJ3MEluSkJPbGRu?=
 =?utf-8?B?NkgyMVBEdWRBZnhWc0ZhdjNxQnEycjVwb1NJK0t3WVRqVktDb2pBMHJmaHp3?=
 =?utf-8?B?clJLbFNFdmEwcHhQelZrMmxlUWF5ZmYrcm1nMm5FeG9LRkIwVEVqbVNFZlhW?=
 =?utf-8?B?KzhPVjdEeGp1VU1vWmNWejQwcWowWUo4WEozRWFvM0xEK1ZnYVdQVHlYSXor?=
 =?utf-8?B?QS9uK2tTekdQdkFPMk51YkVTWk9YS3pRR1NzakRyQlVIQWwxdUdvZytGcmZt?=
 =?utf-8?B?aVk3NDlpMnJseFFoRXk5SFRuZTQ0REdmZ1cyWWhYZkFVMTFFQzV3T2ZuVjVu?=
 =?utf-8?B?ZTR3eks4TlBqekZMQmdETGNTeG9CVzN4dEFPdkZ3RTl5S2lqVWpvTGxQT1dI?=
 =?utf-8?B?SW9JdFRxa21ielByVmd1NVMySlV6eVpOcEZiQXAzdHoxdTJrN0kxcXk2cjd3?=
 =?utf-8?B?V1dNbjZyWnRQS2xyVUZvaHF0T0xiQmJhOVBFbjlyTm1zN1oxZzh3TnFiWGdu?=
 =?utf-8?B?cjR5TjFuQ1ZpYWxZVXdFQU5lTTJCT2tmRU9EanhQcmFORVFrN2h1cWpnVTZD?=
 =?utf-8?B?T2JFY3h4cHJVdDA4bmxLSTNsQmdLQmdka0hzY1duYWVTdnpGQmF5YTh6TXJV?=
 =?utf-8?B?TU52SERIWjZzTWMwTzJDN3N6WDJlVVpuMDRSMUZXMmxlZlpzdGl6Q3QrMG5J?=
 =?utf-8?B?U09uQXdlL0xQTklRaFNRYStRQUJLUm54T0ZoaFpmM0lSRStQeURhUjFPLzlO?=
 =?utf-8?B?R09MU1hGejVmYmhNZGFUV3JaR3NtaFdXUk9NM0xKM1lNVlhzZVJxemZZNklt?=
 =?utf-8?B?YTJMd0RwSzk1NkYvUXBrYnlKbGgrVFdjd290aVRUcDdPczAySm1sd0g3aHJN?=
 =?utf-8?B?Q0c1U3AySlFuQjRoaExNRld1VFpodVNHVGJ2YmdIaDdCaWJ6aFpSK0NTUHdx?=
 =?utf-8?B?bDdHZDE4bmNLVWxtWDh0THRYRU9TMWQ3M3pMaEY4cFRzRWswYVo4MG9UdzJp?=
 =?utf-8?B?THF0ZEl4cUJVOThoVG1hTmVXQW1oSUNhVloza3I1YWVEMFVZbUNaQUdvUmt3?=
 =?utf-8?B?Z0w1STd2MGJWS2craUJJSTRKSXk5TW5XSlB4V3BkRml5eWhNWkwzUEVzbUFC?=
 =?utf-8?B?ZWRjVHplSGJORWl1VHh4VkhVUEtUK1V3dlVNUHpTeGxWZDRtRVovTXRib0F1?=
 =?utf-8?B?L29UTkx5Y3B5eXJuUXEydVBnMzd2MUxZQk5FcmMvcHZZN0tzd1JuS2pzU21a?=
 =?utf-8?B?UGlpMng3RkdYaUUwdzlwVVZvMEU5RG5HRTgrc1l5d0hwQTRqakVMME43MURC?=
 =?utf-8?B?eEt1YUhEYmlPcXd3S2FValowUVpGc0tPYUlXMWpxcGNsTWFlTVEweGVQTHR5?=
 =?utf-8?B?THhjN0ttUXlFTzRNa0FaMjNCS2dqYWJ1dW5GblIwMmEvQWxEejJWcnZnb1NU?=
 =?utf-8?B?Q292ZUVnOWUvMDR3c1NqUW5KNE94OUp6Y1lFRjcrWlhkY0hXalZoU2VaeFFN?=
 =?utf-8?B?TlVGRElCeXg1WkphNzdqVzZ1T240ZHVMMlJOWUFCZ1lkWVFISkNISVRhWlh4?=
 =?utf-8?B?bm1MY2s1UDhoblZkTllKTXlLMFBKZWZoSVgyWkt2YzZIb1gwcHladEt0U2I2?=
 =?utf-8?B?dGhMSXR0Y1F0VldRbGFjZnRGNFI0RDFWMnpad1BnZ0ZVUXQ1V1kwblJIMGhr?=
 =?utf-8?B?dXBCQ0pLeWdRdjV4R3RtSm9GZnhUemN3MElUNkp4R1U2Mmh2Vk1aWVVWMndW?=
 =?utf-8?Q?JYtxtHEx1/8DxKI0+h?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f96c8b-8c6c-4616-4268-08df25cd5874
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:19:59.1840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emUMNNrd1xQvvMpCK2Z0FRtJxQB9Nci9oWllsyFXmeEop7muiEYTRvWQFTamlgc8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4g
U2VudDogRnJpZGF5LCBPY3RvYmVyIDksIDIwMjYgMTI6NTAgUE0NCj4gVG86IExpYW5nLCBQcmlr
ZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUHJvc3lhaywgVml0
YWx5DQo+IDxWaXRhbHkuUHJvc3lha0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDA5LzE0XSBkcm0vYW1kZ3B1OiBkZWZlciBKUEVHIGFuZCBWQ04gaWRsZSB3b3JrIGFjcm9zcw0K
PiBHUFUgcmVzZXQNCj4NCj4NCj4NCj4gT24gMDktT2N0LTI2IDk6MTMgQU0sIExpYW5nLCBQcmlr
ZSB3cm90ZToNCj4gPiBBTUQgR2VuZXJhbA0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiAgICAgICAg
UHJpa2UNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBM
aWFuZywgUHJpa2UNCj4gPj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgOCwgMjAyNiA4OjQyIFBN
DQo+ID4+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsg
TGF6YXIsIExpam8NCj4gPj4gPExpam8uTGF6YXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBQcm9zeWFrLCBWaXRhbHkNCj4gPj4gPFZpdGFseS5Qcm9zeWFrQGFtZC5j
b20+DQo+ID4+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIgMDkvMTRdIGRybS9hbWRncHU6IGRlZmVy
IEpQRUcgYW5kIFZDTiBpZGxlDQo+ID4+IHdvcmsgYWNyb3NzIEdQVSByZXNldA0KPiA+Pg0KPiA+
Pg0KPiA+Pg0KPiA+PiBSZWdhcmRzLA0KPiA+PiAgICAgICAgUHJpa2UNCj4gPj4NCj4gPj4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiA+Pj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
OCwgMjAyNiA4OjM0IFBNDQo+ID4+PiBUbzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT47IExpYW5nLCBQcmlrZQ0KPiA+Pj4gPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtIGdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBQcm9zeWFrLCBWaXRhbHkNCj4gPj4+IDxWaXRhbHkuUHJv
c3lha0BhbWQuY29tPg0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOS8xNF0gZHJtL2Ft
ZGdwdTogZGVmZXIgSlBFRyBhbmQgVkNOIGlkbGUNCj4gPj4+IHdvcmsgYWNyb3NzIEdQVSByZXNl
dA0KPiA+Pj4NCj4gPj4+IE9uIDEwLzgvMjYgMTQ6MTcsIExhemFyLCBMaWpvIHdyb3RlOg0KPiA+
Pj4+DQo+ID4+Pj4NCj4gPj4+PiBPbiAyOS1TZXAtMjYgOToxNiBBTSwgUHJpa2UgTGlhbmcgd3Jv
dGU6DQo+ID4+Pj4+IFByb3RlY3QgbWVkaWEgaWRsZSB3b3JrZXJzIHdpdGggYSByZXNldC1kb21h
aW4gcmVhZCB0cnlsb2NrLiBPbg0KPiA+Pj4+PiBjb250ZW50aW9uLCByZXF1ZXVlIHRoZSBpZGxl
IHRpbWVvdXQgYW5kIHJldHVybiB3aXRob3V0IGhhcmR3YXJlDQo+ID4+Pj4+IGFjY2Vzcy4gS2Vl
cCB0aGUgb3JkaW5hcnkgZW5kLXVzZSBzY2hlZHVsaW5nIGV2ZW50LCBpbmNsdWRpbmcgZnJvbQ0K
PiA+Pj4+PiByZXNldC10aW1lIHJpbmcgdGVzdHMsIHNvIG90aGVyd2lzZSBpZGxlIGVuZ2luZXMg
ZXZlbnR1YWxseSBwb3dlcg0KPiA+Pj4+PiBkb3duIGFuZCBWQ04NCj4gPj4+IGRyb3BzIGl0cyBw
cm9maWxlLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBBIGJsb2NraW5nIHJlYWQgYWNxdWlzaXRpb24gd291
bGQgZGVhZGxvY2sgd2l0aCByZXNldC10aW1lDQo+ID4+Pj4+IHN5bmNocm9ub3VzIGNhbmNlbGxh
dGlvbiBvZiB0aGVzZSB3b3JrZXJzLCBzbyB0aGUgd29ya2VycyBtdXN0DQo+ID4+Pj4+IG9ubHkg
dHJ5IHRoZQ0KPiA+PiBsb2NrLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQcmlr
ZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+ICAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMgfCA3ICsrKysrKysNCj4gPj4+
Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jICB8IDcgKysrKysr
Kw0KPiA+Pj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gPj4+Pj4N
Cj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9q
cGVnLmMNCj4gPj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5j
DQo+ID4+Pj4+IGluZGV4IDk4ODdhNGY5OWFlZC4uN2IxMDI2MGFkMGQ0IDEwMDY0NA0KPiA+Pj4+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5jDQo+ID4+Pj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMNCj4gPj4+Pj4g
QEAgLTExNCw2ICsxMTQsMTIgQEAgc3RhdGljIHZvaWQNCj4gPj4+Pj4gYW1kZ3B1X2pwZWdfaWRs
ZV93b3JrX2hhbmRsZXIoc3RydWN0DQo+ID4+Pj4+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+Pj4+
PiAgICAgICAgdW5zaWduZWQgaW50IGZlbmNlcyA9IDA7DQo+ID4+Pj4+ICAgICAgICB1bnNpZ25l
ZCBpbnQgaSwgajsNCj4gPj4+Pj4gICAgKyAgICAvKiBSZXNldCBtYXkgY2FuY2VsIHRoaXMgd29y
a2VyIHN5bmNocm9ub3VzbHkgd2hpbGUgaG9sZGluZw0KPiA+Pj4+PiB0aGUgd3JpdGVyLiAqLw0K
PiA+Pj4+PiArICAgIGlmICghZG93bl9yZWFkX3RyeWxvY2soJmFkZXYtPnJlc2V0X2RvbWFpbi0+
c2VtKSkgew0KPiA+Pj4+PiArICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmFkZXYtPmpw
ZWcuaWRsZV93b3JrLA0KPiA+Pj4+PiArSlBFR19JRExFX1RJTUVPVVQpOw0KPiA+Pj4+DQo+ID4+
Pj4gSXMgdGhlcmUgYW55IG5lZWQgdG8gc2NoZWR1bGUgdGhpcyB3b3JrIGhlcmU/IEJlaW5nIG5v
dCBhYmxlIHRvIGdldA0KPiA+Pj4+IHRoZSBsb2NrDQo+ID4+PiBpbmRpY2F0ZXMgdGhhdCBhIHJl
c2V0IGlzIGluIHByb2dyZXNzIGFscmVhZHkuDQo+ID4+Pg0KPiA+Pj4gWWVhaCBhZ3JlZS4gV2Ug
c2hvdWxkIGp1c3QgYmxvY2sgZm9yIHRoZSBHUFUgcmVzZXQgdG8gZmluaXNoLg0KPiA+Pj4NCj4g
Pj4+IFNvIGEgc2ltcGxlIGRvd25fcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pIHNob3Vs
ZCBkbyBpdC4NCj4gPj4NCj4gPj4gVGhpcyBwYXRjaCB3YW50cyB0byBzY2hlZHVsZSBhIGRlbGF5
IGlkbGUgd29yayBkdXJpbmcgcHJvY2Vzc2luZyBhDQo+ID4+IGdwdSByZXNldCBwcm9jZXNzLCBh
bmQgdGhlbiByZXRyeSB0byBydW4gdGhlIFZDTiBpZGxlIGF0IHRoZSBuZXh0IHNjaGVkdWxlZCBs
b29wLg0KPiA+DQo+ID4gQSBwb3RlbnRpYWwgZGVhZGxvY2sgY2FuIG9jY3VyIGlmIHRoZSBWQ04v
SlBFRyBpZGxlIHdvcmtlciBydW5zIGR1cmluZyBhIEdQVQ0KPiByZXNldCB3aGlsZSBwZXJmb3Jt
aW5nIGEgYmxvY2tpbmcgd2FpdCBmb3IgdGhlIHJlc2V0IHRvIGNvbXBsZXRlLiBUaGlzIHBhdGNo
IHJlc29sdmVzDQo+IHRoZSBpc3N1ZSBieSB1c2luZyBhIHJldHJ5LWJhc2VkIHdhaXQgb24gdGhl
IEdQVSByZXNldCBzZW1hcGhvcmUgd2l0aGluIHRoZSBpZGxlDQo+IHdvcmtlciBjYWxsYmFjay4N
Cj4gPg0KPg0KPiBWQ04gaXMgZ29pbmcgdG8gYmUgaWRsZSBhZnRlciBhIHJlc2V0LiBUaGUgbmV4
dCBpZGxlIHdvcmtlciB3aWxsIGJlIHNjaGVkdWxlZCBhZnRlciBhDQo+IGZyZXNoIGpvYiBzdWJt
aXNzaW9uIGlzIGNvbXBsZXRlLiBXaHkgd2UgbmVlZCB0byByZXNjaGVkdWxlIGlkbGUgd29yayBo
ZXJlPw0KDQpJZiB0aGUgVkNOIGlkbGUgd29ya2VyIHJ1bnMgd2hpbGUgR1BVIHJlc2V0IGhvbGRz
IHRoZSBzZW1hcGhvcmUsIHJldHVybmluZyB3aXRob3V0IHJlc2NoZWR1bGluZyBjb3VsZCBsZWF2
ZSBWQ04gdW5nYXRlZCBpZiBubyBuZXcgam9icyBhcnJpdmUuIEhvd2V2ZXIsIGJsb2NraW5nIG9u
IHRoZSBzZW1hcGhvcmUgaW4gVkNOIGlkbGUgd29ya2VyIGNvdWxkIGRlYWRsb2NrIGJlY2F1c2Ug
dGhlIHJlc2V0IHBhdGggbWF5IHN5bmNocm9ub3VzbHkgY2FuY2VsIHRoZSB3b3JrZXIgd2hpbGUg
aG9sZGluZyB0aGUgc2VtYXBob3JlLiBVc2luZyBhIHRyeWxvY2sgYW5kIHJlc2NoZWR1bGluZyBv
biBjb250ZW50aW9uIGF2b2lkcyB0aGlzIGRlYWRsb2NrIHdoaWxlIGVuc3VyaW5nIFZDTiBjYW4g
YmUgcG93ZXIgZ2F0ZWQgb25jZSByZXNldCBjb21wbGV0ZXMuDQoNClRoYW5rcywNClByaWtlDQoN
Cj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+ID4gVGhhbmtzLA0KPiA+ICAgUHJpa2UNCj4gPj4NCj4g
Pj4+IFJlZ2FyZHMsDQo+ID4+PiBDaHJpc3RpYW4uDQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4gVGhh
bmtzLA0KPiA+Pj4+IExpam8NCj4gPj4+Pg0KPiA+Pj4+PiArICAgICAgICByZXR1cm47DQo+ID4+
Pj4+ICsgICAgfQ0KPiA+Pj4+PiArDQo+ID4+Pj4+ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgYWRl
di0+anBlZy5udW1fanBlZ19pbnN0OyArK2kpIHsNCj4gPj4+Pj4gICAgICAgICAgICBpZiAoYWRl
di0+anBlZy5oYXJ2ZXN0X2NvbmZpZyAmICgxVSA8PCBpKSkNCj4gPj4+Pj4gICAgICAgICAgICAg
ICAgY29udGludWU7DQo+ID4+Pj4+IEBAIC0xMjksNiArMTM1LDcgQEAgc3RhdGljIHZvaWQNCj4g
Pj4+Pj4gYW1kZ3B1X2pwZWdfaWRsZV93b3JrX2hhbmRsZXIoc3RydWN0DQo+ID4+Pj4+IHdvcmtf
c3RydWN0ICp3b3JrKQ0KPiA+Pj4+PiAgICAgICAgICAgIG11dGV4X3VubG9jaygmYWRldi0+anBl
Zy5qcGVnX3BnX2xvY2spOw0KPiA+Pj4+PiAgICAgICAgfSBlbHNlDQo+ID4+Pj4+ICAgICAgICAg
ICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZhZGV2LT5qcGVnLmlkbGVfd29yaywNCj4gPj4+Pj4g
SlBFR19JRExFX1RJTUVPVVQpOw0KPiA+Pj4+PiArICAgIHVwX3JlYWQoJmFkZXYtPnJlc2V0X2Rv
bWFpbi0+c2VtKTsNCj4gPj4+Pj4gICAgfQ0KPiA+Pj4+PiAgICAgIHZvaWQgYW1kZ3B1X2pwZWdf
cmluZ19iZWdpbl91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQ0KPiA+Pj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQo+ID4+Pj4+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQo+ID4+Pj4+IGluZGV4IDE3
ZGI3MjY0MjY5ZS4uZjg1MWE2ZWNlYTFiIDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMNCj4gPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQo+ID4+Pj4+IEBAIC00NzAsNiArNDcwLDEyIEBA
IHN0YXRpYyB2b2lkDQo+ID4+Pj4+IGFtZGdwdV92Y25faWRsZV93b3JrX2hhbmRsZXIoc3RydWN0
DQo+ID4+Pj4+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+Pj4+PiAgICAgICAgaWYgKGFkZXYtPnZj
bi5oYXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQ0KPiA+Pj4+PiAgICAgICAgICAgIHJldHVybjsN
Cj4gPj4+Pj4gICAgKyAgICAvKiBSZXNldCBtYXkgY2FuY2VsIHRoaXMgd29ya2VyIHN5bmNocm9u
b3VzbHkgd2hpbGUgaG9sZGluZw0KPiA+Pj4+PiB0aGUgd3JpdGVyLiAqLw0KPiA+Pj4+PiArICAg
IGlmICghZG93bl9yZWFkX3RyeWxvY2soJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKSkgew0KPiA+
Pj4+PiArICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnZjbl9pbnN0LT5pZGxlX3dvcmss
DQo+ID4+Pj4+ICtWQ05fSURMRV9USU1FT1VUKTsNCj4gPj4+Pj4gKyAgICAgICAgcmV0dXJuOw0K
PiA+Pj4+PiArICAgIH0NCj4gPj4+Pj4gKw0KPiA+Pj4+PiAgICAgICAgZm9yIChqID0gMDsgaiA8
IGFkZXYtPnZjbi5pbnN0W2ldLm51bV9lbmNfcmluZ3M7ICsraikNCj4gPj4+Pj4gICAgICAgICAg
ICBmZW5jZVtpXSArPQ0KPiA+Pj4+PiBhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmdmNuX2lu
c3QtPnJpbmdfZW5jW2pdKTsNCj4gPj4+Pj4gICAgQEAgLTQ5OSw2ICs1MDUsNyBAQCBzdGF0aWMg
dm9pZA0KPiA+Pj4+PiBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdA0KPiA+Pj4+
PiB3b3JrX3N0cnVjdCAqd29yaykNCj4gPj4+Pj4gICAgICAgIH0gZWxzZSB7DQo+ID4+Pj4+ICAg
ICAgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2Y25faW5zdC0+aWRsZV93b3JrLA0KPiA+
Pj4+PiBWQ05fSURMRV9USU1FT1VUKTsNCj4gPj4+Pj4gICAgICAgIH0NCj4gPj4+Pj4gKyAgICB1
cF9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7DQo+ID4+Pj4+ICAgIH0NCj4gPj4+Pj4g
ICAgICB2b2lkIGFtZGdwdV92Y25fcmluZ19iZWdpbl91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpy
aW5nKQ0KPiA+Pj4+DQo+ID4NCg0K
