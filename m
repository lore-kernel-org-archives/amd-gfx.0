Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C988BCD8CA4
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 09:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668BF10E1D6;
	Tue,  9 Jun 2026 09:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lBf+RjJy";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159AB10E1D6
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 09:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ND/ffmSe72YOuSP1AALN07KM0CfwoesWicDWZ5UHKwnCztqfx3g8zpMKZKT4VVJEwGUv9DuMc6lnECFS37F6kt1Nmrph7Gl9+/UxvkFyPAA118J6I4LNe9XKdJkaUOhQ0cTk6XuYrD4mrdkrmHZDPZbP18aWyl6w1P++nMN05HFaNwaR23OcTunre/Fzltu0N8PYTKf9m37CniODQ5LlIjECW4JyP0LZ2LSbKw510ViTs7ncxLYjnRMMdX8OzlzBt7ZgSAX6tJucoFnVF0oH77tkGydCFw9mRsmkdLffsbbKeL+ehtaAqhH9T5UXMS/Awccj9lBE+FyDjryIbCegsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fwSBAEpbOBmmMxtsSMesLABjgMSNUJrdpTtxqILSQM=;
 b=S0kotWHUR7CsQyDkpFk/51sk3QDeKIjP6uppoCdQfB+FhK9jFw7ksx5oZXI4H6irc+4sKx/qA6++gvH1ul8f+cYelF/OsLe24tAei0/1QdTjl7zSmTUutcvXcTfg0dd0SJTPZRpEyinU5xcSGdMzWjIunwNWVRZYc3VbhFMyLqGr9TZrth6mc2lAPv4p2sGm+KVmNa1kTIiBRT7OfHPrmCv910qRdbcOkS2M+oS3wulfgvt/Fcu+mKwZHe/Xab5ByQRPYfb0bDAApsbQr4EFMZMD4Ax9XsDEeRzlI11MopwLqL0pTlE1uykq+kq08xukPoxaht/Ws4a9dMZv96FMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fwSBAEpbOBmmMxtsSMesLABjgMSNUJrdpTtxqILSQM=;
 b=lBf+RjJyK54Dw5psyNHeHC1/51IL9gS+yen9JYfJslF3cWeZnNV9pRcv5JvtZGmb3I7Zm8Fv+FF74y+o+Z3c/zNeIrXuHoLl5hgqA7U+8+Z7mK/7z7Jq5oWFbbbXej1OtgZDiZt0AzY7etGMB3SUVkvuxsTm8dqR3/QyWICkvL0=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by IA0PPFFEC453979.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::beb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 09:44:05 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 09:44:05 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v9 06/11] drm/amdgpu: Make EVENTFD subscriptions
 queue-aware
Thread-Topic: [PATCH v9 06/11] drm/amdgpu: Make EVENTFD subscriptions
 queue-aware
Thread-Index: AQHc83bXX2J2sEVz4kq8mcLnp4eyDrYv9s+AgAYKapA=
Date: Tue, 9 Jun 2026 09:44:05 +0000
Message-ID: <IA0PR12MB8208B33EF21B6E299522E2B3901D2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
 <20260603163350.2678309-7-srinivasan.shanmugam@amd.com>
 <b3445b69-2f52-4b22-974a-7bfc2be2b9d5@amd.com>
In-Reply-To: <b3445b69-2f52-4b22-974a-7bfc2be2b9d5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-09T09:41:47.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|IA0PPFFEC453979:EE_
x-ms-office365-filtering-correlation-id: 4b9cc46f-1bdc-443d-c25a-08dec60ba555
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: CL7i/Ps6GdCF4eF9UfxRV7GAPTO/ldvTXlhNuu2K8+P8E5te2A4ec/J1IwUOcD+HukKtGkWOvsEhHxgd6yNbUAYLzxsyM/WXmr8WqBjO8/dcUPcnfuU3ULrdcdmgIZm202X/huIoTKF8Tyvo/nj1S0it49JvKhsBi+fRk7qmWN/Q6H4X5W2YKY/RyAwmUAjLmAAdzQKjrJmSv+xB5rnSMn8cqqchU7fynLT8P/FYacfAaQCdtGa8rTawWWp6REOKLlQiK9wfYMjZAtRDXl/FpfC4Xc8+nnILw/wkslTmc95kY3vw8BcwhdWApVuS01Q5pjq2SHvqVFrImjGZ6TtX7ieO6lnPRw0F1G8c/rByqFhlKu2HlMtG6UAihwO7M36d+WhJlZNYERiXX/MYwmpYjmoOrT4AGsVtHee5dnlipW7/SzwZsZ/ItzS//FEISxxO/kRhhYVJv4b7/VHfmGWgMXtMbZzXb/Qpe8/mV9rJmzyKA1bJQQYC0UwDMEH0bbVqip4HEFCEaw4oEWbHS5IRb9GsM49hsnpIlL0rzicDY/LyTca9AIXbl1fbGcun7I6sNOOTRETgqlRrh2ekaz45H7BTI9d0L3zTRLmVQDk5z6pRGD1lDle8SocSlvcgaiLbHn9e+9t1h3J3/H+QQycpnw2E7xXH28cxZ4b9np7uo+vjR6w8J1AtJFXL7ElaDb+S8snGczmJJcLMwVUAG5Nmv1uJssYssSJerlaar9AFV6Db5wupd+xrAqEnNsUoU/0Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clB3ZE5UZ2haYmlKTFBKeXBvejdzaG9TTjFrNE9JWncrdGxmRTJUOWVrMUY2?=
 =?utf-8?B?ZnlUbnl3eGNvQ0FkZE14RVBzSGttQ1ZiUkJ4U0dGRENJeUVPTzM3RkhIOE9K?=
 =?utf-8?B?bzBkNGw2SFlrOWJXZ2prNGtiOTZoTmFDZytQaGVBNEpNeFVaTi9KWnRlWmx3?=
 =?utf-8?B?cUR3aXdwdHZOSkRtcU40UERXaVVNMVlvcnNkMld2Yisrb3AzSzZVUW9SaW1F?=
 =?utf-8?B?cldCY2FKelp0amN2T1M0SjcxenBKaFRLMktvK0lBbmVHZE41N3h5cnZ1SVpE?=
 =?utf-8?B?LzJhWWh0M3dqbnZVMG9DN3JiaGZoK05SdnJlNkladnJSTVNXM1B3OTM4WEd1?=
 =?utf-8?B?ZkYzVTh2QzN0ck11T2pVS3kvMDM2U2JCeXQ0aWZlU0w3eG5McmhMcE50SHc3?=
 =?utf-8?B?NHVjY0FtQlh6emVtTlk4SDhqUVdZblV3RjBSUE5CNVFsUUNpb2FheUYvMlJJ?=
 =?utf-8?B?akZ2ak90dDA2NGEzdDZES1REQ0kweW5LSTRXdHkxRWE1bVJDMHlaeHcwYUZO?=
 =?utf-8?B?eDBUQTNYVVJnbjR3dm9kazVmRlVNNlhrYkZhQkVBbVJQT1RrSTVFVTIxeXJ1?=
 =?utf-8?B?a1pRTHozd3plSENVRktwNVlVNmM3bUI2NlhVSEtPMklNMTRiS3NFQnFnSEtO?=
 =?utf-8?B?b2wzWklRQlNlQ0Vla2xwTC9hK09meGxBQWVJVERrKzhjL1V3MGJOc1laZTZo?=
 =?utf-8?B?aUNOZERvNlpjbU1HWTEzdU1kU2crcVNvMGtYc2pGdURNdC9OMjhoOXFoYWpi?=
 =?utf-8?B?RVRCOUc2SG5WdFVHczdsd1NCQzdPUlZ6aXRNYS9YUGhzM094WDV4ckd4Y3d4?=
 =?utf-8?B?dXBhNHNSRlZTNjhSWkVyQU1XMWdrZWpISmd4QzZjcURzMTB5TWUzbEx2RmlO?=
 =?utf-8?B?anZsOUZKWUdWS1VDSUFtNjN6MjM4SGxlZ2ZtWUR6SGt3dmxQRXkzbFRJRGhk?=
 =?utf-8?B?V0JGalRKZ2JSVm1KRGZicEpnWHk0eTlzZG9nNVJxTUlVYitKbGZZTUEzODY2?=
 =?utf-8?B?bm1obDhaVkFMS2tTbWQvdXBhVnFJRk9rd01YZlNBM2t4c0pNcXZza1l5TjBj?=
 =?utf-8?B?VXhGSzBPWms3cERZYjYxME5CYmE0cEZBLy9NbWlEWThiMjJndWtQaFZGWitJ?=
 =?utf-8?B?YUhhS1RmTFcrQW5xMytsbHdXNFVPc3AzTzY3TTYrUWk1WFV6WjZYV1RWWlNV?=
 =?utf-8?B?RWpMY2htcHYrWVFKay9PSWs0VEdjMk0vZDFvTVRFUzV6L0cvbjU4WTlrQUc2?=
 =?utf-8?B?dFhITzZUWTNlNEx0V3h5WU5rTkJKTy9mQ2t4b2JPbFEyN28xd3VPbi9rcGpQ?=
 =?utf-8?B?V1Z5cjZFRGY0TC91QXhHaGlud0NjME4wTnQ4ZXRMVWY4dlJWQTlSZVlQZDJT?=
 =?utf-8?B?ZnhmTW81OUdjZGd4MkRPdnZRcVREclJNTGczLzFWQU1XRTZYdzNsZ0grUHhU?=
 =?utf-8?B?UHNHTm1ycVNIMHNoU25BRklvQlROMDhzSlZBMS9ZTDdrM1c4VDAwT0ZsRUhl?=
 =?utf-8?B?SmZ6czRVUEYwSDJldW9pT01YUXlNMjJpcXhFYmdVQUJCNlkzVndkRzExUUVl?=
 =?utf-8?B?SUl0b1plaUtTY3k4MmhiR24rdTZhcHFnMi9ZQUorcnB3V0NNSXJjNkE5dHpM?=
 =?utf-8?B?WjNKcW9RZ0RtSUY3YUVLcGtsbVFsdGpQWDJ6ZExHdG95RlR6YkVNb3crUWx3?=
 =?utf-8?B?cUprY3laeWIrQlZIb3hYcDhNYmJuSVhhNkJ2M2g4MzJxLzNjTDVMRnQycUxx?=
 =?utf-8?B?Zmw2MU5LZjAzc2VxOUlJSm5SZlNGbkxsU0xvZDdkQ1owL2RtWk9sN3M1NzA0?=
 =?utf-8?B?YzhiRDdGaVFFajg5ZXJCdThsbXVmZXBRWW1xSytuYnpvbGdqaGw3Z1dvZVI0?=
 =?utf-8?B?RmRGUitSamhoaWY2WGN1NnNQSzgrSTlVY0ZFdlo1Zk0zM0Z5N3k2bUVwd1dP?=
 =?utf-8?B?STBVM0dZcnVKRjJvdlp3MmhNKzgzYzFPUU1wT2JDUkFRM2RveU94QXVmY2U4?=
 =?utf-8?B?T3J1YXIvVEI4aktGUERPcUxxd2pCb3Y4MThUdGFoUkhHVVB6aS9taUt1UVdY?=
 =?utf-8?B?WWNZK0o3SWJ2UzFrc0o5SFVuSENLUEpsamJ2OWwxZlRBOTFHSGJhZmlHSHdw?=
 =?utf-8?B?MVVTTFVud2Y3Y0wza0FWNTJuTlRYUWExQnB4anJaaGY2TjBUN3kxKzhvNU5Y?=
 =?utf-8?B?WEJQNGMzdTRiK2p2NzVJWFN6WUtRQVFxQlQ3c3EyOXBoQ0JXekJMREVLbTBy?=
 =?utf-8?B?Wm9kWDJPcnd1a1BHY09pbjNUMDZxcm85bEJFcFJBNnpIeENCcWtiU2lFa2xJ?=
 =?utf-8?Q?jTQ+7i10gznYDRLfeC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9cc46f-1bdc-443d-c25a-08dec60ba555
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 09:44:05.3781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdA5epY6cqDy9DRvSg5BIVhA/SwiWqZNnFayIuUuQPV84psyg1LxZmlv65ub/Aj4/t4uTiEm/4wotyInS7icZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979
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

UHVibGljDQoNCkhpIENocmlzdGlhbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBT
ZW50OiBGcmlkYXksIEp1bmUgNSwgMjAyNiA2OjU2IFBNDQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5J
VkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+Ow0KPiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDA2LzExXSBkcm0vYW1kZ3B1OiBN
YWtlIEVWRU5URkQgc3Vic2NyaXB0aW9ucyBxdWV1ZS0NCj4gYXdhcmUNCj4NCj4gT24gNi8zLzI2
IDE4OjMzLCBTcmluaXZhc2FuIFNoYW5tdWdhbSB3cm90ZToNCj4gPiBUaGUgY3VycmVudCBFVkVO
VEZEIG1hbmFnZXIgbWF0Y2hlcyBzdWJzY3JpcHRpb25zIG9ubHkgYnkgZXZlbnQNCj4gPiBpZGVu
dGlmaWVyLiAgVGhhdCBpcyBlbm91Z2ggZm9yIGNvYXJzZSBub3RpZmljYXRpb24sIGJ1dCBpdCBk
b2VzIG5vdA0KPiA+IHN1cHBvcnQgdGhlIHF1ZXVlLXNjb3BlZCByb3V0aW5nIG5lZWRlZCBieSBx
dWV1ZSBjb21wbGV0aW9uIHN0eWxlDQo+ID4gZXZlbnRzLg0KPiA+DQo+ID4gRXh0ZW5kIHRoZSBz
dWJzY3JpcHRpb24ga2V5IGZyb20gYSBzaW5nbGUgZXZlbnQgaWRlbnRpZmllciB0byB0aGUgcGFp
cg0KPiA+IChldmVudF90eXBlLCBxdWV1ZV9pZCkuDQo+ID4NCj4gPiBGb3IgZGV2aWNlL0dQVS1z
Y29wZWQgZXZlbnRzLCBxdWV1ZV9pZCBpcyAwLiAgRm9yIHF1ZXVlLXNjb3BlZCBldmVudHMsDQo+
ID4gcXVldWVfaWQgc2VsZWN0cyB0aGUgcXVldWUtc3BlY2lmaWMgc3Vic2NyaXB0aW9uLg0KPiA+
DQo+ID4gRVZFTlRGRCByZW1haW5zIG5vdGlmaWNhdGlvbi1vbmx5Lg0KPiA+DQo+ID4gQWxzbyBm
aXggdGhlIHF1ZXVlLWF3YXJlIGJpbmQgcGF0aCB0byBjb21wdXRlIHRoZSBwYWNrZWQgc3Vic2Ny
aXB0aW9uDQo+ID4ga2V5IGJlZm9yZSBsb29rdXAvaW5zZXJ0LCBhbmQgYWxsb3cgZmQgMCBieSBy
ZWplY3Rpbmcgb25seSBuZWdhdGl2ZQ0KPiA+IGZpbGUgZGVzY3JpcHRvcnMuDQo+ID4NCj4gPiBU
aGlzIGNoYW5nZSBrZWVwcyB0aGUgZXhpc3RpbmcgbWFuYWdlciBkZXNpZ24gYW5kIGJpbmRpbmcg
bW9kZWwNCj4gPiBpbnRhY3QsIHdoaWxlIG1ha2luZyBxdWV1ZV9pZCBtZWFuaW5nZnVsIGZvciBx
dWV1ZS1zY29wZWQgd2FrZXVwcy4NCj4NCj4gWWVhaCB0aGF0IGRvZXNuJ3Qgd29yayBsaWtlIHRo
aXMuDQo+DQo+IFRoZSBxdWV1ZV9pZCBpcyBqdXN0IGFuIGlkZW50aWZpZXIgZm9yIHRoZSBVQVBJ
IGFuZCBjYW4gYmUgcmUtdXNlZC4NCj4NCj4gU28geW91IGNhbid0IHB1dCB0aGF0IGFzIGtleSBp
biB0aGUgYW1kZ3B1X2V2ZW50ZmRfaWQgc3RydWN0dXJlLg0KPg0KPiBJIHN1Z2dlc3QgdG8gY29u
dmVydCB0aGUgcXVldWVfaWQgaW50byB0aGUgZ2xvYmFsIGRvb3JiZWxsIGlkIG9yIHB1dCB0aGUg
ZXZlbnRmZA0KPiBtYW5hZ2VyIG9uIHRoZSBxdWV1ZSBpdHNlbGYgaW5zdGVhZCBvZiB0aGUgZnBy
aXYuDQoNCkkgdW5kZXJzdGFuZCB0aGUgaXNzdWUgbm93LiBTaW5jZSBxdWV1ZV9pZCBpcyBqdXN0
IGEgVUFQSSBoYW5kbGUgYW5kIGNhbiBiZSByZXVzZWQgYWZ0ZXIgYSBxdWV1ZSBpcyBkZXN0cm95
ZWQsIEkgdW5kZXJzdGFuZCB0aGF0IHdlIHNob3VsZCB1c2UgdGhlIHJlZmNvdW50ZWQgcXVldWUg
b2JqZWN0IGluc3RlYWQgb2Ygc3RvcmluZyBxdWV1ZV9pZCBpbiB0aGUgRVZFTlRGRCBzdWJzY3Jp
cHRpb24uDQoNCk9uZSBjbGFyaWZpY2F0aW9uIHBsczogd291bGQgeW91IHByZWZlciB0aGUgRVZF
TlRGRCBzdWJzY3JpcHRpb24gaXRzZWxmIHRvIGhvbGQgdGhlIHF1ZXVlIHJlZmVyZW5jZSBhbmQg
cmVsZWFzZSBpdCBkdXJpbmcgdW5iaW5kL3RlYXJkb3duLCBvciBzaG91bGQgVVNFUlEgcmVzb2x2
ZSBxdWV1ZV9pZCB0byB0aGUgcXVldWUgb2JqZWN0IGFuZCBrZWVwIEVWRU5URkQgYXMgYSBnZW5l
cmljIG5vdGlmaWNhdGlvbiBsYXllcj8NCg0KSSBjYW4gaW1wbGVtZW50IGVpdGhlciBhcHByb2Fj
aC4gSSBqdXN0IHdhbnRlZCB0byBjb25maXJtIHdoaWNoIGRpcmVjdGlvbiB5b3UgaGFkIGluIG1p
bmQuDQoNCkJlc3QgcmVnYXJkcywNClNyaW5pDQoNCg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3Rp
YW4uDQo=
