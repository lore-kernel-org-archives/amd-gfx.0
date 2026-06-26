Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CD4CDE008
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 04:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE9610F406;
	Fri, 26 Jun 2026 04:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MBVFLzSR";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D49210F406
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 04:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8DpkhKPVfZJ0Fh7gCb6JQTi+eED7CE581yI7od6JRjIIytGY7IcRD/KGGvY+ALd9Z07nWsfNHhqT2KocNiZvzHBu1APYZMRTo1gTD3gxb2CWzDXIJSTQBduqhPRSWUX9J8dZ7SM5QoZRC+4STusoG5itAzgPnPy48eUo3hTewiWxIpJjuInRSeyg5lSLdhs70vBVNWvXfitDeSXy8t+CN/DdjUG2IsMegPKll4H1fhPLJoF7CYwTC6qy3nTc8ZuUY/ZUVxI+oxcjs5Woxa06LPmOAtg0plesmIZ0Q5ju/m3ybSl1n/vDlbqP+5FyEiLkHRK+B8FJtklVWYSnVFaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ4fGdM6hT3QOnEqe3ZRsEiB9P/8MEjLUtEufGgtARo=;
 b=gNzoWIz0TuQJ9M/I6IpQdTQP5d9hWCss1gCjHxH3NpRy+tqZsjyNDzyo1tFVuFeK+detnQmRF3NViAfhGE3LLhELaJg0vPwD4KUIRbY6S1KvyPw4Dohf9fi2kPVfP92+5DCLbgrhgH+F0DcHhSaqXDuExabiJYEW890WB0YOCV7zyW7vtgXPYpmfMgD0OOGqxxvHm/GLRqMj2Jg98/W/RhYkCXZnsKsLA7Z/hzczzfDZynEEPszvYHFKkZy6Pz0VaSKGAbnZIERWo2mxO1UOhhaTflIyJEKeioKVckJ3YWW0iQIsRewPRiCZg8BfykUgcYiCxQhg8jBaw0f8b9OUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ4fGdM6hT3QOnEqe3ZRsEiB9P/8MEjLUtEufGgtARo=;
 b=MBVFLzSRm1m1BMRJYWVTkEbFqUOsV40XuH5BLcEujwmhHqnqYW16ZYreMaWQLv+4ye8bLIpdJdN+kljfRKBb9hn+l5/SBHJhG5CkYqB85Evt3dWa/mUeDwbQ1XqQOorDcty/3/mfXUOw9KGkqKCoDyatypbc0CELH7tcqFZMRR4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 04:03:08 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 04:03:08 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending
 userq
Thread-Topic: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending
 userq
Thread-Index: AQHdBFCQRvUOZooLKk6kWA0Wnm99ALZPFVmAgAAAwgCAASHIcA==
Date: Fri, 26 Jun 2026 04:03:08 +0000
Message-ID: <DS7PR12MB60050A9E6C6A5516ECA5B546FBEB2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260625031252.298647-1-Prike.Liang@amd.com>
 <20260625031252.298647-2-Prike.Liang@amd.com>
 <32c5afa2-f24e-4d8c-8872-72826e7d3d08@amd.com>
 <1d42937a-2b8e-4718-aec8-46a58886b62b@amd.com>
In-Reply-To: <1d42937a-2b8e-4718-aec8-46a58886b62b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-26T04:00:00.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ1PR12MB6290:EE_
x-ms-office365-filtering-correlation-id: dab4b70d-4bf4-4c6f-d166-08ded337d4f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|56012099006|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: Tz7HFrIR4lZwp5nZumq7gDIr25sJQHGaMLwrBtMmrQguRmzvF+u1SWqCUJSFaeZnXPXsVHtFFF2qtQAZfthsz2oxVB7SFdhxOAvIf86ZXKDR1mob6iu1V4RLfLnpD3KCb9bGX9RNh0eFD12ErvksxXJTUVO3f+A7XbgEgmPKaLDaJQnxeXlv7eNZwlwv553xt5ajEsiebUMpd/MTZXgK/MvyGvASkRxo2pBxm2JU9pV439BjqRp0xCNNhCy80Jf48CMHvRmAiBYfBA6GFoLHpRT69KIhSFnBOjoiMzbNJUI2vFuvQUX0aj7PQcOsYzndsklNDBxO9QFX/m3u465oarOXFAq3hzTaZUEgodwSq7eYhxdpDkIvTZzO4zhm1KDshCfGzWCR28V8T3FEqNBzRRqyygBQhoaNgrWGnPtvstnAI42YYRRGEZRVfSA7GxAnhbGJ/eXZomeggQxI6N2k5ti2RWq6G7qI8YKVfdp1/0Pj2XKhCNPJSHoc+mmo7N5CcAivQfKRuF+Y+53iFbFreG35uf8EJBR4W2/CRtUmv8iAnuGr35+ZSzttThDaSyWKVftWIUc8rhtLMXSq/SaoTt4DHxUtrdTnkHBLAOy8Bdhp+rlT/vaxrhwpSYQe+WoGXPkmDmlm6v8TCFOAW9lQkiM/x5F5IuH/zO9K/vhRDXulTAkR8cZYpAPj8oAA9Ct3Vpe3fQZovzS9tD/B1BWk82tKwR0Ij39h2H19M6UaJZM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(56012099006)(22082099003)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkZMNlhzWXdYT2QrVjY1MCtaSEtTeS9yK3k5S1Y0UUVoMU5BVnliN1RuelFn?=
 =?utf-8?B?L2xHNldaMDlSQzk1UlVSS0xETkFCWExOaDljYnVYNjdHVXVNbWozelI1YVRB?=
 =?utf-8?B?WXpZWGtpYnhVQ1A4di9KV1V0WmhLYWw4dVFrUEVjNEtRV1pNTDZxVDdyaW9X?=
 =?utf-8?B?Vm0zelpHWlV3alJ2VUNHbC95b1hNdWZIVXNJOEhVbVhqZGFia1lLSkZjcmUz?=
 =?utf-8?B?Zm5rQ1BuYngxdFFycGVqNFN6YWtqNmJvUG91SkRqU1prZWNPdGRnRUVSUHFE?=
 =?utf-8?B?ejZTVE9zcVBXR2hRWVRjN0xabWlHNjV3VU9mV2FEcndBb3M2a0U3dVJ5Q3dV?=
 =?utf-8?B?MVdBUy9ZVDh0V1VMd1NYU1ovRVFRVHRTR29SRzNNOEw0enZRTWljWSswN0pD?=
 =?utf-8?B?b0RFY3plaWRIQ2FjS25JUU0zVWRkemVPMXR1czRRQWc4bG5RTVpEbnJqeWNj?=
 =?utf-8?B?K1JGU2ZRb2FqR1liRDR4WlY3Q2hReGd3UzlEWVB2QTdSSHF3eE00cmd5eEZY?=
 =?utf-8?B?T29Fd1Z2QXFHMTdkRnYzeHUzRTAzcThIbUlNNEdOUStaM2hZbmo4WUVnd3lG?=
 =?utf-8?B?S1JYbHh0Vi9OTVEvYkFaTDVXcjh4TklhZUxCZ2JVOEFGeGlEYy9GWkY1OFJQ?=
 =?utf-8?B?YS91bW1DQ1owQnFnT0pXeHQ1Wnd3bVI0clh5aTQrNjllbTI2U1FvSlVBVS9C?=
 =?utf-8?B?UmpmWE1yODhFNzA0Rzl0RW5ENDJTQXVUK0h5QXdSeUFrUXhuZ245VzVCTDgv?=
 =?utf-8?B?VHNuNndmOGxRU2YwdUgwTDIwa3lYY2lZbDJFcVJNSkJrRE5BT09GSGZudUs0?=
 =?utf-8?B?c2dYTCsrc3lIdXlHdGsyMU5YbkRtMmJ5ZGt0bkx6RUttU1c5YVE2VFUreUdD?=
 =?utf-8?B?VnJhMEpGbUFFUHRNeHNmV25vSGoxWGxyUmVBY3FiSVRac0ZNQUVocjhqZE5R?=
 =?utf-8?B?d2xLSW1YQzBiNEJHYjdzeXF3b1BlczczVHh0MUcxL2FoWjJOUHE1amswMnAy?=
 =?utf-8?B?dDkydnJjMC8xMG1PSTlydzJoS2w1Smt1MFlxTEMwcXlrZnprTjhzM0hYaGxq?=
 =?utf-8?B?K2VvMm9CcENuN3c2ZDU3L09KRmNScWNuSEJTWTlSZjRSVWE0TG0yd2g4Nzk2?=
 =?utf-8?B?c3RpZHBrZkpXb0lXVGpab0VZOWpoa3ZadENvdng0bTNONEg3b3R4VlNEZTcz?=
 =?utf-8?B?Q0JtSjZJY3BPUW01M3RGMy9UaEtGMjQ5RjUwNGxiRjNYcHJzMGtLT3VjOHkr?=
 =?utf-8?B?RTd3MmtwSFVHc1k4QVpvQ21DWHlKQjFRcEp5VEkzaFNaUFQrS28rSG52eHlj?=
 =?utf-8?B?V3BiQUhuTTRudFEvMmZGMVpNUHp1UndRSmw2UTlJZWpNL0VJQXllWi9jUFZp?=
 =?utf-8?B?T1Y2UFEyUlJqeldpQjdoWDUxenZMcVJZRnRJS0FFdHRqdUczeFlsMjA2dWJV?=
 =?utf-8?B?TGFXemZnWDJrejJhQm92MkIrTk56V2NxTzRXM2hPaFIrTENIL0NjTmxwMnUv?=
 =?utf-8?B?R3NBbTdmT2poK09BK2V4M25yc3VEZENzWUd0eGhDU1EySFBDczkrRDlvcC9D?=
 =?utf-8?B?ZmQ2L1hoRlRHeHFjR2pxaXdvTFB4MlI1bE1DYWU0akdobHJ0RnpoWXdTc1Ix?=
 =?utf-8?B?SEROWmZ3MUNTRk5ZMkhmNE51UE1oRUYya3FBaGQ1VkhpcTZQaDgxQmRvY0w0?=
 =?utf-8?B?ZmlicmVvbnltUHd4bHdnYW1vQUlmNzBYTmtrY2RVME80Ym5GNlhuY2xEcVR3?=
 =?utf-8?B?RVQrMzNmb1lYbGx0eEc5MHhoaFVESDJHMTBLUEpTU0YyeUEzR3p1cFhOdHZ5?=
 =?utf-8?B?WEIrWGRqaWkxL3lvTlhBMWs5bitXSHNnU0NWSk1QYzJoNVZjbWczcTVCZ25x?=
 =?utf-8?B?S2psdUkwMXd6M0ZENTgxbzN0Ym1uZFZURXNucHZXVFpTQVNhdXBqTmduSjM2?=
 =?utf-8?B?UkljUEZPZDVZN2tzbmxVSWJna2RFR1FzcW5oZUJMTkFtQUJ2UHVXa2N0VFRz?=
 =?utf-8?B?TzlNa1dDUlVaUWhwSmE5aVNDY2xqYlBYV3dXcUQzM0ZxZkorL2Y0Q1Y5M0FW?=
 =?utf-8?B?V0J1NWpWNDNsRjBPakFQTHViWHhMVWRQUXB0NFN2c0FsbmEzRnhwVFFDazhj?=
 =?utf-8?B?MnQ5M2J5WmE5SVR0Qm43cHdpNlpYVnlPanVmTVR2Y1VOV0VaLy9LVGVrNXFI?=
 =?utf-8?B?V0pSdkFHdU9JUFUzWHUwOHI0WlRxdXdTR2lFV2RrTlE5ZHhSTmJpR2VtUHhQ?=
 =?utf-8?B?ODU1ZGlJakNOQS8vYWZSazZqMGM4aDZXUmk4Yml6S0V0aVFubVdkclNBRnhM?=
 =?utf-8?Q?MLgMl89HkAJ9PMHFFT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab4b70d-4bf4-4c6f-d166-08ded337d4f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 04:03:08.2083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmvGrspxlYUuQiyFq4DFXpbgFC0J6xiZMnpmfZGkJgHgRqvDnZm/ZnaAEGby/rOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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
ZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEtoYXRyaSwgU3VuaWwNCj4gU2VudDogVGh1cnNkYXks
IEp1bmUgMjUsIDIwMjYgNjo0MyBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGRybS9hbWRncHUvbWVzMTE6IHNldCBkb29y
YmVsbCBvZmZzZXQgZm9yIHN1c3BlbmRpbmcNCj4gdXNlcnENCj4NCj4NCj4gT24gMjUtMDYtMjAy
NiAwNDoxMCBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gPg0KPiA+IE9uIDYvMjUvMjYg
MDU6MTIsIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+PiBVcGRhdGluZyB0aGUgdW5pb24gTUVTQVBJ
X19TVVNQRU5EIGFuZCB1bmlvbiBNRVNBUElfX1JFU1VNRSB0byBhZGQNCj4gPj4gdGhlIGRvb3Ji
ZWxsIG9mZnNldCBmb3Igc3VzcGVuZGluZyB1c2VycS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1i
eTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jICAgICAgICB8IDIgKysNCj4gPj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMV9hcGlfZGVmLmggfCAyICsrDQo+
ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jDQo+ID4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMV8wLmMNCj4gPj4gaW5kZXggOWUyN2QwMWNi
ZmEzLi5hYjBkZTZkMDRmZjggMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L21lc192MTFfMC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L21lc192MTFfMC5jDQo+ID4+IEBAIC03ODMsNiArNzgzLDcgQEAgc3RhdGljIGludCBtZXNfdjEx
XzBfc3VzcGVuZF9nYW5nKHN0cnVjdA0KPiBhbWRncHVfbWVzICptZXMsDQo+ID4+ICAgIG1lc19z
dXNwZW5kX2dhbmdfcGt0LmdhbmdfY29udGV4dF9hZGRyID0gaW5wdXQtPmdhbmdfY29udGV4dF9h
ZGRyOw0KPiA+PiAgICBtZXNfc3VzcGVuZF9nYW5nX3BrdC5zdXNwZW5kX2ZlbmNlX2FkZHIgPSBp
bnB1dC0NCj4gPnN1c3BlbmRfZmVuY2VfYWRkcjsNCj4gPj4gICAgbWVzX3N1c3BlbmRfZ2FuZ19w
a3Quc3VzcGVuZF9mZW5jZV92YWx1ZSA9DQo+ID4+IGlucHV0LT5zdXNwZW5kX2ZlbmNlX3ZhbHVl
Ow0KPiA+PiArICBtZXNfc3VzcGVuZF9nYW5nX3BrdC5kb29yYmVsbF9vZmZzZXQgPSBpbnB1dC0+
ZG9vcmJlbGxfb2Zmc2V0Ow0KPiA+Pg0KPiA+PiAgICByZXR1cm4gbWVzX3YxMV8wX3N1Ym1pdF9w
a3RfYW5kX3BvbGxfY29tcGxldGlvbihtZXMsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAmbWVz
X3N1c3BlbmRfZ2FuZ19wa3QsIHNpemVvZihtZXNfc3VzcGVuZF9nYW5nX3BrdCksDQo+IEBAIC04
MDIsNg0KPiA+PiArODAzLDcgQEAgc3RhdGljIGludCBtZXNfdjExXzBfcmVzdW1lX2dhbmcoc3Ry
dWN0IGFtZGdwdV9tZXMgKm1lcywNCj4gPj4NCj4gPj4gICAgbWVzX3Jlc3VtZV9nYW5nX3BrdC5y
ZXN1bWVfYWxsX2dhbmdzID0gaW5wdXQtPnJlc3VtZV9hbGxfZ2FuZ3M7DQo+ID4+ICAgIG1lc19y
ZXN1bWVfZ2FuZ19wa3QuZ2FuZ19jb250ZXh0X2FkZHIgPSBpbnB1dC0+Z2FuZ19jb250ZXh0X2Fk
ZHI7DQo+ID4+ICsgIG1lc19yZXN1bWVfZ2FuZ19wa3QuZG9vcmJlbGxfb2Zmc2V0ID0gaW5wdXQt
PmRvb3JiZWxsX29mZnNldDsNCj4gPj4NCj4gPj4gICAgcmV0dXJuIG1lc192MTFfMF9zdWJtaXRf
cGt0X2FuZF9wb2xsX2NvbXBsZXRpb24obWVzLA0KPiA+PiAgICAgICAgICAgICAgICAgICAgJm1l
c19yZXN1bWVfZ2FuZ19wa3QsIHNpemVvZihtZXNfcmVzdW1lX2dhbmdfcGt0KSwgZGlmZg0KPiAt
LWdpdA0KPiA+PiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9tZXNfdjExX2FwaV9kZWYu
aA0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9tZXNfdjExX2FwaV9kZWYuaA0K
PiA+PiBpbmRleCA2NjQ0ZmFiZWIwYjcuLmIwNjQxMmFjODU4MyAxMDA2NDQNCj4gPj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL21lc192MTFfYXBpX2RlZi5oDQo+ID4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9tZXNfdjExX2FwaV9kZWYuaA0KPiA+PiBAQCAt
NDI4LDYgKzQyOCw3IEBAIHVuaW9uIE1FU0FQSV9fU1VTUEVORCB7DQo+ID4+ICAgICAgICAgICAg
dWludDMyX3QgICAgICAgICAgICAgICAgc3VzcGVuZF9mZW5jZV92YWx1ZTsNCj4gPj4NCj4gPj4g
ICAgICAgICAgICBzdHJ1Y3QgTUVTX0FQSV9TVEFUVVMgICBhcGlfc3RhdHVzOw0KPiA+PiArICAg
ICAgICAgIHVpbnQzMl90ICAgICAgICAgICAgICAgIGRvb3JiZWxsX29mZnNldDsNCj4gPj4gICAg
fTsNCj4gPj4NCj4gPj4gICAgdWludDMyX3QgICAgICAgIG1heF9kd29yZHNfaW5fYXBpW0FQSV9G
UkFNRV9TSVpFX0lOX0RXT1JEU107DQo+ID4+IEBAIC00NDUsNiArNDQ2LDcgQEAgdW5pb24gTUVT
QVBJX19SRVNVTUUgew0KPiA+PiAgICAgICAgICAgIHVpbnQ2NF90ICAgICAgICAgICAgICAgIGdh
bmdfY29udGV4dF9hZGRyOw0KPiA+Pg0KPiA+PiAgICAgICAgICAgIHN0cnVjdCBNRVNfQVBJX1NU
QVRVUyAgIGFwaV9zdGF0dXM7DQo+ID4+ICsgICAgICAgICAgdWludDMyX3QgICAgICAgICAgICAg
ICAgZG9vcmJlbGxfb2Zmc2V0Ow0KPiBJZiBteSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3Qgb25s
eSB3aGlsZSBhZGRpbmcgYSBxdWV1ZSBmb3IgdGhlIGZpcnN0IHRpbWUgZG9vcmJlbGwNCj4gb2Zm
c2V0IGlzIG5lZWRlZCwgbm90IGZvciBhbnl0aGluZyBlbHNlIGJ1dCB5b3UgY2FuIGNoZWNrIHdp
dGggZncgcmVxdWlyZW1lbnRzLg0KDQpUaGlzIGNoYW5nZSBrZWVwcyB0aGUgZHJpdmVyIGhlYWRl
ciBhbGlnbmVkIHdpdGggdGhlIE1FUyBmaXJtd2FyZQ0KZGVmaW5pdGlvbi4gVGhpcyBmaWVsZCBp
cyBub3QgY29uc3VtZWQgYnkgTUVTIGZpcm13YXJlIGRpcmVjdGx5IHdoZW4gc3VzcGVuZGluZw0K
dGhlIHVzZXJxLCBzbyBpdCBtYXkgYmUgcmVtb3ZlZCBpbiBhIGZ1dHVyZSByZXZpc2lvbi4NCg0K
PiBSZWdhcmRzDQo+IFN1bmlsIGtoYXRyaQ0KPiA+IElzIHRoaXMgYmFja3dhcmQgY29tcGF0aWJs
ZT8NCj4gPg0KPiA+IEtlZXAgaW4gbWluZCB0aGF0IHdlIGNhbid0IGJyZWFrIHRoZSBGVyBpbnRl
cmZhY2UuDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IENocmlzdGlhbi4NCj4gPg0KPiA+PiAgICB9
Ow0KPiA+Pg0KPiA+PiAgICB1aW50MzJfdCAgICAgICAgbWF4X2R3b3Jkc19pbl9hcGlbQVBJX0ZS
QU1FX1NJWkVfSU5fRFdPUkRTXTsNCg==
