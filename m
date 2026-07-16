Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E13AC4450A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 12:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DAD010E34D;
	Thu, 16 Jul 2026 12:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ykIjS3Ec";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC7A10E34D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 12:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sU3nuoZXO0hpHnIByiZDPnZ7weTLFrHK/G8AypTXgn1mclE2KSjBCLx2eHwbRysc93b6JUo8+TBi8Ft2k4spFCJkYPAtTMMxme3ILmaAF9qtsbWsPLUfasZ3fbrxc5nsd2WsHnWI2i14ydl6W8ER0BfAqeevinA6Ayvzi0aAOve9uFHxXXjm0lsdZRKoUfrdisatQgHyew3WeaRMec/L8YzzzQVAlnkO/eZuF7KQVB61Odvypefv+GJJAhfa9xTrshPfpbI55aUHNsgiCZA0/K4qS0+yF22vJmDgiiAMni/yTeStjLOcaNwHp6NiJiiTNjKxGICD2tFn6pAQM+3CGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4RXL4V8/7gmc9Z8fpZYGG+Wi3LBv3NKgbYGTofIJ/A=;
 b=wR/4dBoPyDYdzzHkNYqZuc+vcf9GhzEG7J+IWsGy42CpZdOWxEaJ/2/zAy8JVgnFIv4xeUserQFmF6T3FV3tExDzJua5tYwp3GunvOn9QVDzsb0jJR7k+U3vl8t5pDtFUYLTjgONYkyYIwgZkVe3nAoAqAy0W7mY1xJriqC911GBbw1v13UljRSrkXuhMJFsdyb/WLFKVSz5AIeSi3QYjdpPDOY961OEoBIYr/y+0BQW9X6N1q5YYOg74H+S4RS1iyrc4IlThc1Jd9Pvr4PrdCnIqx05S4vXQGngxW31SRNfLqs1vyjkkVUAnbi+F+9znNZmXqASmNJmTUgZNK5jGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4RXL4V8/7gmc9Z8fpZYGG+Wi3LBv3NKgbYGTofIJ/A=;
 b=ykIjS3EcGP08uXBUW8RR8aMfOpGixtdAjcpcpL1KXVv6kFNbuTshyl3vNZd+WnTXitUv8EDoZWz9BQgaKl5q/dCKBdNcltd/TDFMbVQg4BqoC9AqwFqIHIuDOfJ84q4mzn4gSry4x9AjzGVrTVvibH82/UV80WUK23UhgOcV2B8=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Thu, 16 Jul
 2026 12:53:00 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 12:53:00 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v9 5/5] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT
 notifications
Thread-Topic: [PATCH v9 5/5] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT
 notifications
Thread-Index: AQHdE2hGKLmWWW8ZeEmIau/OWo7rHrZs/BeAgAAOouCAAxEzwA==
Date: Thu, 16 Jul 2026 12:53:00 +0000
Message-ID: <IA0PR12MB82082D2D3FDABB394796856B90C72@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
 <20260714081023.3395485-6-srinivasan.shanmugam@amd.com>
 <b40ff22e-2d09-4644-a4d3-a9cffcdaec6d@amd.com>
 <IA0PR12MB8208D744889CEED95FB6DB0E90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB8208D744889CEED95FB6DB0E90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T13:57:55.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|CH3PR12MB8878:EE_
x-ms-office365-filtering-correlation-id: 6d41267b-2cda-45a9-5f7a-08dee3392af0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: B5Ds2+sgIsq/PR5XFuS3DggfGSmlZdpJrweEJkGRXtlk+1m8o357LRQqregfEhRzfoNfAclCU0bzKYfPosdxY0HoTeqDjnGuwmGyyeMLevOI59syyBq+6jmo3Vyss6cIIfewrWX6x3eJ64v7LQNPUupBf89lK7DqQXeljH9IQKlC2xpNVkaZ0JGoyCGF3d00y/I4FSREKTqRnPeTQXLaPNsX2vb3THooZ8PKVTEdUNkqr0p7b+j4xePsbJeRQngfayBzGw1ur8OHzFKJIYJoDV+Wawrf3BvjbAx5aC7z3p24NrFw2dIXw7AFHBrLRePlpn6YKphQkr7SPNv0orysWH8slTUVYM+IcOcJmb1OgrtOWEhff4WYOfjtTXk3yoenLZsBWDHdDALdWytqnrKtKzUhS5Y1vZH5mcGlWedUKBjXXpuINIPxutjIzeNb2/3JVaNaR/wS1EuuGJObo7FxzOqrlGjjSkcT+RjfjYrV5MAgzVFRkog7Ww8rVZUvz8xpRqQUez6ZBDWRJbg5SAAOd530cCZ1t+pD6bJnBTbpt7OVlYhZ+QKEHTtKK7+Ty9yAcqrzQLIHw3YHEcFU2DnQ3OuTI1wvlH+LZTrvrWFCUzRGTVP+uEcSO6+59QfWY7EQlRYrhhpWMHY4gdDR/f7WzvvLf3/C0D6snyYviXlWnvU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R05Gc2tpNXBsQStNQlh4azgybDRJWVF5Zy9EUElaSytqZG1SM2gwRFdmOGxN?=
 =?utf-8?B?QVRQRDNlVkdqY0FlMnNBNnF5clQweVM3OURvWW8vWFU4YmlhbFVEQlk1NEV3?=
 =?utf-8?B?c1gvMExWS3JtSmtURGdqZisyRVREUjBaNWtjTk1sNEJZY0Z2TFJPU0h2djdY?=
 =?utf-8?B?dnQxNzNndnJ4K0FUdnBRVDNheGNwRjJ3TDlRWCtZOVl1ajFTbnYrTDYwRTdR?=
 =?utf-8?B?NExtcVNZb3RiS3VpcW14c1lFUDFVYkp0ZVRvNEdLY29IcEZRK01Pa2xBUmZZ?=
 =?utf-8?B?ZDBicEJxVXNCVmJNNWZkM283aGJHVVhDK0FvU0F6TElsWFpVd2hQdzFYejYy?=
 =?utf-8?B?Z3JzSW5XRUFCWTYvYlhuKzg2UkFlSW9zdW9zMUZzbjl5dDlmZytRR1o0a2hz?=
 =?utf-8?B?Q3AxeW9FTEZ3enZ5QmtiWXoyMTdRUWxlZWRjbnBPSG1ab3hXRnZUa1cwYWVN?=
 =?utf-8?B?d1puTXlKU3N2NzIzaFZ5T2JoYXhJT21kUll3bXBhRGg5WVFQMy9rckI5UUNM?=
 =?utf-8?B?RU02a1V6ZkQyNGVJRmRVUkhMOTBGV01ZNVY1S1pJNVV1UVZWRWJ3Nit2NldR?=
 =?utf-8?B?b1ZPMXlnbmpYVHcwSzhjL0M4Zm1EK1NjVTdmNWZyK2xRSlVDYkdka1QvNUFk?=
 =?utf-8?B?L1plb2Q3cS94MHhOM3N2NkdGSDc1SjFaRUh3ZXpUUCtQRFY2NlVHeGprdnlR?=
 =?utf-8?B?bW5yaE0rby9TVTU2Z0xJMGRUb29SMExYQ0I5cExEMFRGSWxCSHpVRks4Z3dI?=
 =?utf-8?B?T3I1d2xWbGRGbmV5RjVVR2xWOWdhNS9abnV6eVlwa0Fpclpaak11b2o4ZzY1?=
 =?utf-8?B?ZEt3ODh4bUJnZkkxM1U1N0hxcmtiRHpSZTY3Q294ZThlMjRBUzVLRDU0YzhD?=
 =?utf-8?B?QlpDU3cxd2hIOEpacDRmemlDZ2pCSW9wdzVmcFNhTHhMQjRkc21SY3Y3MHlH?=
 =?utf-8?B?eVJWbDFxR0h1OHd6dWtJWEdGbEpxNkhseXg0Z2c0cDh6VmNuTmJFZFp1QUgz?=
 =?utf-8?B?MVdlU0wyWGZRUVQ5SDExTGs5V01KNVl3YXdaTFp4R3ZrcnljTGFQQlZ2QTRW?=
 =?utf-8?B?eFpDUDcxZDZoaEJoUjJFbC8rdlg2OXdFL2w5OTNQNXRvQnFaSktRZGVlSmVK?=
 =?utf-8?B?aFAwZFdMUVQrN05TUWVrbElPNW01SEltN2NCb3YwZmdneGFzcmw1N2xXRWw0?=
 =?utf-8?B?TFJ6S0UwR2tzcGJlOXdLOWhoQzFkazVRRHNvYU9PTHJ0TUtoUXQ5Z3Z0Z0Nt?=
 =?utf-8?B?MWxRSi9Rc3VOYnZWNXlHMytkU0MzQmZtWkcwQ09TU2k5RnVic00zZ0JjOVFL?=
 =?utf-8?B?cU5xcDNNNGV2bi9kNTlFNVBWWnNpdzcyRlFwTVBFRmt6alBHdCtIcEtkeHpm?=
 =?utf-8?B?NmFYSVcveWRZU3JuTFEyUDYrNENPRUNJQmNiN1lQYXd0OUxsaEhkbHBrcTVk?=
 =?utf-8?B?alg1UDdqc1dCV2pmVnIvdTIxLzcvVUlEMkl4WjF0ZWs3Yk1acEcxZWNRQlAw?=
 =?utf-8?B?RUxaUDI5ZVVoMzltdHNnZ3hlNlNDcS9NOEJaT3ZIUWRLdE5BODVsOE0xL21p?=
 =?utf-8?B?bHQyVXc5NWMxdUxFVEhxamFoanQ4YzVRMXFkSXduZEl2bkhqMExyeCtUZzha?=
 =?utf-8?B?ZkxpenRRTUJiZXZQM05KV3VHY0R2bjAySHcyVy9qS3AwOFg4Ny9uM3JZbisr?=
 =?utf-8?B?TW85Tkl6OHZqV1NCVHhFZUZnczRLN0dvaE1Qb1JGWEhYS0c5SGJhL1hyRVV4?=
 =?utf-8?B?RFYyLytBZE9hN1BjKyt4UnE3N0tKQ1duQUNiOXFnU3pPT0NaWE1nVEEwclBD?=
 =?utf-8?B?U1lXWGlGcTNwbnVXSzVVOVhWektja2dDSEpaOWg1OEsxankwOU9FL0FiTkpK?=
 =?utf-8?B?NkE2cFJ2YW1FZkV0aW1NNnVEVVBNLzVBeXpaY042Zm92SGtvMzJPS1lEL0dx?=
 =?utf-8?B?dnZFUHdUMjVYVFVpY3IyZlRJZDAxMDVIVUJEdk94M000RHpMWWdaSnhaT1Nh?=
 =?utf-8?B?OVp0N2hET1NqU2tYYXBBeFF5OUFHbHAzcEM2YUxRY083Zkh4N2t5dGoyL1pw?=
 =?utf-8?B?dnBsZHpNWUZRZFZXSy9GdFhBYW1YcTd6TVUwWE9IL2RWZUxweVQxNjk1V3RK?=
 =?utf-8?B?QWpXdzBBOGFXYVQ0K0VDL3JkNWxJRWNvR2w2Mzg4RDYwZ3IwQkM3c00yT2pN?=
 =?utf-8?B?UmxpTlkwSHVJaWtZMGhKcys5U01oYnVFU1J5cFVCalE5V1lnN3pNNm5qNmxx?=
 =?utf-8?B?MTFiNHdLaHFrdlliVFV2bEdENjNLVDdMZlpCR2ZPOFEyM3l4dERkUGJWSHB5?=
 =?utf-8?Q?jrN+olRn03a6enOHtO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d41267b-2cda-45a9-5f7a-08dee3392af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 12:53:00.5949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6O+Zlwp5Tx9j7QJaoOtvb7fdY5A8FAqyr9PHKe+bQPttsZAEHRPDCQKHv99jo81gOXb5cZ2WMYpf7fzhZF+Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFO
TVVHQU0sIFNSSU5JVkFTQU4NCj4gU2VudDogVHVlc2RheSwgSnVseSAxNCwgMjAyNiA3OjQzIFBN
DQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1
Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2OSA1LzVd
IGRybS9hbWRncHU6IFJlY29yZCBRVUVVRV9SRVNFVCBXQUlUX0VWRU5UDQo+IG5vdGlmaWNhdGlv
bnMNCj4NCj4NCj4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEtv
ZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+ID4gU2VudDogVHVl
c2RheSwgSnVseSAxNCwgMjAyNiA2OjM2IFBNDQo+ID4gVG86IFNIQU5NVUdBTSwgU1JJTklWQVNB
TiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IERldWNoZXIsDQo+ID4gQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgNS81XSBkcm0vYW1kZ3B1
OiBSZWNvcmQgUVVFVUVfUkVTRVQNCj4gV0FJVF9FVkVOVA0KPiA+IG5vdGlmaWNhdGlvbnMNCj4g
Pg0KPiA+IE9uIDcvMTQvMjYgMTA6MTAsIFNyaW5pdmFzYW4gU2hhbm11Z2FtIHdyb3RlOg0KPiA+
ID4gVGhlIHF1ZXVlIHJlc2V0IHBhdGggYWxyZWFkeSByZXNvbHZlcyB0aGUgYWZmZWN0ZWQgcXVl
dWUgZGlyZWN0bHkNCj4gPiA+IGZyb20gdGhlIGRvb3JiZWxsIGFuZCBmdW5uZWxzIHN1Y2Nlc3Nm
dWwgcmVzZXQgaGFuZGxpbmcgdGhyb3VnaA0KPiA+ID4gYW1kZ3B1X3VzZXJxX2hhbmRsZV9odW5n
X3F1ZXVlKCkuIFJldXNlIHRoYXQgY29tbW9uIGhhbmRsaW5nIHBvaW50DQo+ID4gPiB0byBjcmVh
dGUgdGhlIGNvcnJlc3BvbmRpbmcgV0FJVF9FVkVOVCByZWNvcmQuDQo+ID4gPg0KPiA+ID4gS2Vl
cGluZyB0aGUgbm90aWZpY2F0aW9uIGluIHRoZSBjb21tb24gaGVscGVyIGVuc3VyZXMgdGhhdCBx
dWV1ZQ0KPiA+ID4gc3RhdGUgaXMgdXBkYXRlZCBiZWZvcmUgdXNlcnNwYWNlIGlzIG5vdGlmaWVk
IGFuZCB0aGF0IGJvdGggRVZFTlRGRA0KPiA+ID4gYW5kIFdBSVRfRVZFTlQgb2JzZXJ2ZSB0aGUg
c2FtZSByZXNldC4gSXQgYWxzbyBhdm9pZHMgZHVwbGljYXRpbmcNCj4gPiA+IHRoZSBkb29yYmVs
bCBsb29rdXAgb3IgYWRkaW5nIGEgcXVldWUgc2NhbiBpbiB0aGUgTUVTIHJlc2V0IHBhdGguDQo+
ID4gPg0KPiA+ID4gTm8gTUVTIG9yIEdGWCBpbnRlcnJ1cHQgY2hhbmdlcyBhcmUgbmVlZGVkLg0K
PiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZh
c2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jIHwgNiArKysrKysNCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gPiBpbmRleCAyOGY5ZDNmZTBlODAu
LjllMWQwM2ViMzFkNyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91c2VycS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnEuYw0KPiA+ID4gQEAgLTE2Niw2ICsxNjYsNyBAQCB2b2lkIGFtZGdwdV91
c2VycV9oYW5kbGVfaHVuZ19xdWV1ZShzdHJ1Y3QNCj4gPiBhbWRncHVfZGV2aWNlICphZGV2LA0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV91c2VybW9k
ZV9xdWV1ZSAqcXVldWUpICB7DQo+ID4gPiAgIHN0cnVjdCBhbWRncHVfZXZlbnRmZF9tZ3IgKmV2
ZW50ZmRfbWdyOw0KPiA+ID4gKyBzdHJ1Y3QgYW1kZ3B1X3dhaXRfZXZlbnRfbWdyICp3YWl0X2V2
ZW50X21ncjsNCj4gPiA+DQo+ID4gPiAgIHF1ZXVlLT5zdGF0ZSA9IEFNREdQVV9VU0VSUV9TVEFU
RV9IVU5HOw0KPiA+ID4gICBhdG9taWNfaW5jKCZhZGV2LT5ncHVfcmVzZXRfY291bnRlcik7DQo+
ID4gPiBAQCAtMTc2LDYgKzE3NywxMSBAQCB2b2lkIGFtZGdwdV91c2VycV9oYW5kbGVfaHVuZ19x
dWV1ZShzdHJ1Y3QNCj4gPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ID4gICBhbWRncHVfZXZl
bnRmZF9zaWduYWwoZXZlbnRmZF9tZ3IsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBE
Uk1fQU1ER1BVX0VWRU5UX1RZUEVfUVVFVUVfUkVTRVQsDQo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBxdWV1ZSk7DQo+ID4gPiArDQo+ID4gPiArIHdhaXRfZXZlbnRfbWdyID0gYW1kZ3B1
X3VzZXJxX3dhaXRfZXZlbnRfbWdyKHF1ZXVlLT51c2VycV9tZ3IpOw0KPiA+ID4gKyBhbWRncHVf
d2FpdF9ldmVudF9hZGQod2FpdF9ldmVudF9tZ3IsDQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBEUk1fQU1ER1BVX0VWRU5UX1RZUEVfUVVFVUVfUkVTRVQsDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBxdWV1ZSk7DQo+ID4NCj4gPiBIb3cgYXJlIHdlIG1ha2luZyBzdXJlIGhl
cmUgdGhhdCB0aGlzIHdhaXRfZXZlbnRfbWdyIGRvZXNuJ3QgZ28gb3V0IG9mIHNjb3BlPw0KPg0K
PiBHb29kIHBvaW50LiB3YWl0X2V2ZW50X21nciBpcyBwYXJ0IG9mIHRoZSBvd25pbmcgYW1kZ3B1
X2Zwcml2LCBub3QgdGhlIHF1ZXVlIGl0c2VsZi4NCj4gSW4gdGhlIHJlc2V0IHBhdGgsIHdlIGN1
cnJlbnRseSB0YWtlIGEgcmVmZXJlbmNlIHRvIHRoZSBxdWV1ZSwgd2hpY2ggZ3VhcmFudGVlcyB0
aGF0DQo+IHRoZSBxdWV1ZSByZW1haW5zIHZhbGlkIHdoaWxlIHdlIGhhbmRsZSB0aGUgcmVzZXQu
DQo+IEhvd2V2ZXIsIHRoYXQgcmVmZXJlbmNlIGRvZXMgbm90IGV4cGxpY2l0bHkgZ3VhcmFudGVl
IHRoYXQgdGhlIG93bmluZyBhbWRncHVfZnByaXYNCj4gKGFuZCB0aGVyZWZvcmUgd2FpdF9ldmVu
dF9tZ3IpIGlzIHN0aWxsIGFsaXZlLg0KPiBJJ2xsIHJldmlldyB0aGUgbGlmZXRpbWUgcnVsZXMg
YW5kIHRlYXJkb3duIHNlcXVlbmNlIHRvIG1ha2Ugc3VyZSB0aGUgbWFuYWdlcg0KPiBjYW5ub3Qg
YmUgZnJlZWQgd2hpbGUgYSByZXNldCBub3RpZmljYXRpb24gaXMgc3RpbGwgaW4gcHJvZ3Jlc3Mu
DQo+IElmIGFkZGl0aW9uYWwgc3luY2hyb25pemF0aW9uIG9yIGEgcmVmZXJlbmNlIGlzIG5lZWRl
ZCwgSSdsbCBpbmNsdWRlIHRoYXQgaW4gdGhlIG5leHQNCj4gcmV2aXNpb24uDQoNCkhpIENocmlz
dGlhbiwNCg0KVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dC4NCg0KSSByZXZpZXdlZCB0aGUg
bGlmZXRpbWUgYW5kIHRlYXJkb3duIHNlcXVlbmNlIGluIG1vcmUgZGV0YWlsLiB3YWl0X2V2ZW50
X21nciBpcyBwYXJ0IG9mIHRoZSBvd25pbmcgYW1kZ3B1X2Zwcml2LCBzbyBpdCBpcyBub3QgYWxs
b2NhdGVkIG9yIGZyZWVkIGluZGVwZW5kZW50bHkuIEl0cyBsaWZldGltZSBpcyB0aWVkIHRvIHRo
ZSBjb3JyZXNwb25kaW5nIGRybV9maWxlLg0KDQpEdXJpbmcgZmlsZSB0ZWFyZG93biwgdGhlIFVT
RVJRIG1hbmFnZXIgYW5kIHF1ZXVlcyBhcmUgdG9ybiBkb3duIGJlZm9yZSBhbWRncHVfd2FpdF9l
dmVudF9tZ3JfZmluaSgpIGlzIGNhbGxlZC4gUXVldWUgdGVhcmRvd24gcmVtb3ZlcyB0aGUgcHJv
ZHVjZXIgbG9va3VwIHBhdGhzLCBhbmQgYW1kZ3B1X3dhaXRfZXZlbnRfbWdyX2ZpbmkoKSBtYXJr
cyB0aGUgbWFuYWdlciBkZWFkLCByZW1vdmVzIHBlbmRpbmcgcmVjb3JkcywgcmVsZWFzZXMgdGhl
aXIgcXVldWUgcmVmZXJlbmNlcywgYW5kIHdha2VzIGJsb2NrZWQgd2FpdGVycyBiZWZvcmUgYW1k
Z3B1X2Zwcml2IGlzIGZyZWVkLg0KDQpCYXNlZCBvbiB0aGlzIHRlYXJkb3duIG9yZGVyaW5nLCB0
aGUgcHJvZHVjZXIgc2hvdWxkIG5vIGxvbmdlciBiZSBhYmxlIHRvIGFjY2VzcyB3YWl0X2V2ZW50
X21nciBhZnRlciBpdCBpcyBmaW5hbGl6ZWQsIHNvIGFuIGFkZGl0aW9uYWwgbWFuYWdlciByZWZl
cmVuY2UgZG9lcyBub3QgYXBwZWFyIHRvIGJlIG5lY2Vzc2FyeS4NCg0KSSd2ZSBhbHNvIGRvY3Vt
ZW50ZWQgdGhpcyBvd25lcnNoaXAgYW5kIHRlYXJkb3duIG9yZGVyaW5nIGluIFBhdGNoIDIgKCJB
ZGQgd2FpdC1ldmVudCBtYW5hZ2VyIGFuZCBwZXItZmlsZSBsaWZldGltZSBwbHVtYmluZyIpIGlu
IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC83NDA0NjUvP3Nlcmllcz0x
NjQ4MTMmcmV2PTExDQoNClRoYW5rcywNClNyaW5pDQo+DQo+IFRoYW5rcywNCj4gU3JpbmkNCj4N
Cj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gQ2hyaXN0aWFuLg0K
