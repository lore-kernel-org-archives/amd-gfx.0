Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFDC607552D
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bx6VnEm3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5395010EE78;
	Mon, 19 Oct 2026 15:46:23 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADAC010EE3D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 15:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOjzWUWitbwqwLe4jmvpioWy7nOt8NzVYeYQYB2RaNgY80/0cpJAj6fdiSaPdliOBVd8TEU3EnSTR73v21b5z/onyexizQhYTEtwxAYYir5d+Eub8cuRF2XGxEiOdOywa7kxY09PHe0xaycWKrQCg14fJcNgOq7dJfZ2tYRhnLhUs0ozOsW1Kjfu2BZgmzVDmeB2qGkAY0+2TIeJjQq2P3Wu/jxRe7qvt2sXsq4fyWjD/m/fvC2OBnN7Vhk/cgdKJC56HmLxNH1ewJ+S2FwmBqrp+kAkJgY1UrAy9+1DJM3iVX9qg8rAitz8TdGEtpfQ7JrWtVpjvtI6fSfawVh39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qe/qdaJpLUJLFPKj4gfy+ESPZgThFQfNr5T3zmFy7aE=;
 b=JM9wXtmjcZ5YclsZonClX7wZySkaLRwaBOCu7LkQGLvxRSquWw0/TXAR022dwf74EKURTDoCgtrpfrUMIyANE92xqxvGV6aJq3MIba/EdI8OUxS1lwKkOD52BDxjbcczXe9ch6itt6ZfFAayFLe0Gxd+BcUeyRIhUGURSO4l7D96AD7tMOxiCuf3dyu5Vr0QqY5ST0b6zAL3uNODe3LsfT8o1hswWu0sIZft6q+0HFIhQj2FPoDFzaGJOfAnLMUXqqOXt8CMDJqR/ZVXAIUh57+NkCQO0tLUuUl7E2Mh/0ayj9AMSiKYjzhvkcpQlHmLmnqP2V+EMKNT33KZou1YbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe/qdaJpLUJLFPKj4gfy+ESPZgThFQfNr5T3zmFy7aE=;
 b=Bx6VnEm32IXd1gHjM67mHdIXxciT+WvHAjr5mZWm23A30a+Yzuhoje/bdIGGKJcBrXe+8R3HBz7yal+P5QQnLItEsehdj9wJ7ZX5Hye+rBu3ingdjMb+j8y+XYqH4gd4fTSi+ssQi815VHRB2ir4s0G3dv/JbmrttbFJthXTf+c=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 15:46:11 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 15:46:11 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: drop the gang leader reference when
 freeing gang jobs
Thread-Topic: [PATCH v2] drm/amdgpu: drop the gang leader reference when
 freeing gang jobs
Thread-Index: AQHdX2wjYK5thaasiUiE5cKTvvb1QrcE7SSAgAAViIA=
Date: Mon, 19 Oct 2026 15:46:11 +0000
Message-ID: <DM4PR12MB5152548CCA10D027E2A34DF1E3982@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261019014938.1487609-1-Jesse.Zhang@amd.com>
 <d5890df6-0f94-4388-9673-af94b825a1c7@amd.com>
In-Reply-To: <d5890df6-0f94-4388-9673-af94b825a1c7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-19T15:44:42.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH8PR12MB7448:EE_
x-ms-office365-filtering-correlation-id: 8b009294-e289-49c7-87fe-08df2df81980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|4143699003|11063799006|261009221227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: 2CIugmqMaqvFw2UdlWlCP3iBX8t6p9/K2A0vC99sO1hV0vczB1jfC0aHrfqtR9MAtGHgepNJ7+DqX8LihR1j+rk3tgU3g2JzBfwdQ2UTOymXghflcmmQrGdtdtE6/XeB3OxRleNaurP9Y0W1eQOYSUna7jiBLO2IRlbkqaARzTzdy1TqpjRl2Cvtl7qvBN0XMJwuU6VbkebPrg7jPe+/ctFYPSoN0GCcObhFh5kBUK2zXUfLogShSJM55xxUKjoFw+D2twiUcn7uosW09lQqotecmsfbRj4yfeST/hGFzUHftitl71og80yf6K8p2491ejGiXDY4zd8RzQseU/oJyq4Elc+o9buuC8THouMOKFGA46HPa2AfI8UfBgzJQhcamMgAbfQtzO7mmZ+D2DqRgDnZ9jsh8oRX2gVfjGO/dL9/GbB4ErE8jD4jRi68ml3XRSJpM7x7LRcsjMg/jUJfLfflUW00d7cRIw7zoXOu7O6QftWU9Shv3Yle3BeOzAGDN6AKmbo57sfl/ReGhP9H964QvBtMMy90pkdsAgtQEHSa6emg4SFO6qgXAx/NA0jk/nuRJsvVizwY4TTsVIXVCve+SnJfp++Vs5OYD/bo7esSuTfxK7sz16tu3HKzR8Frnv7QNCDjBsbqBM+x/H4NRIu4GlBOmbHdxj0ggZrS6Y0UH5yJcVHfvnOEI9XkrxA/O99Jpj/OcwnEIDe+bUPx5/RZDVKedJbv2Vv4RQjGU2w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3BrOHFvRGwwbGhCdnpqbHZYUlBVZklaSTYwbG8xbWp5UUtXUlNFdjRuUHVu?=
 =?utf-8?B?azRHM3dTeXFJbk1zVlFRZ0M4OFh5Y1IxaXFsaTZyZzhIVjZsUXR3OGFQWXZm?=
 =?utf-8?B?NlQyd0xXaE4yUlFWeC95ZURRTUYyT3NoNnVUb2V4K1hLcUFTMEhqL0tlV3Uv?=
 =?utf-8?B?dDlEUFFJaStvTSs1OGNibmFabzZ4Y0U4czJpRUs0eURzaVgvbUFyOGRYZ0E1?=
 =?utf-8?B?czZsTkNvZm9UNXJuandKb3ZwVU9RQVdnUE4rdDdQQzRtRG5yUEREQnp0Y3g4?=
 =?utf-8?B?VTZQTjIzMU5ocDNJYVFUakx6VElzdXd2d05zY0xpQmhWRGJ4bFpIaHpOeGVI?=
 =?utf-8?B?eG8za1hWUm5OL1gyR1U2SlV3bEsySStHbndRMThIUi9hSTRKc3lKOFRaTkUz?=
 =?utf-8?B?a0IxVkJ5U05ucW1vZmh0Y05SUjZhNEZ4dW43QitQYS9Fakkydnd6eUpjRFd2?=
 =?utf-8?B?UlF4MkNHMm8xSFNJNGNWT1pJaEN0VEc1UTJ3YVpKbFd6Nm9IbFBZM0Z0bEFz?=
 =?utf-8?B?a2ZlU0xDWEN2Q00xZFJNRWg2RmhRM09sTW8rQ3BnZWdzQThkV0NxTEVndVNv?=
 =?utf-8?B?Yk50QVJiRWJtYVFXb243UlBRSTdBQVdpV01jblRrVFB5Ylh2UXRBZUpZWCtk?=
 =?utf-8?B?TUhQeWlMVFBhSkVpT0hSM2h6WDcrNnFoUmRMWWtXUG1RODIyZWJib1RBcGJP?=
 =?utf-8?B?cWNObHYyOU1CZE56RlptaCsvUDZUTS9aYmlyVHJzYTBaSjZiczMralo3L2FX?=
 =?utf-8?B?NUxVeWNtVHNsZmtpelFPV0YwMW5kN3FtdkpMRU8weTZ1bnN6NlQ5TDZ1KzBy?=
 =?utf-8?B?cXNVejV2eWVxK3hCbVEwMG9HSW1RaEZEM0pQMEwvOXJhOE95YWQ0bm5pZDJ5?=
 =?utf-8?B?bkxmdm5KdVVFT1A3L0V2WHM5ZFk0UjBFZWpuTVF5RXlqNm1kMitPOGZJZjVw?=
 =?utf-8?B?d1lwRUFwMnVveld4N2JtVkQ2YjVFQXJHSmd1MnBzajcrWkN2U1V5K1pqUEk5?=
 =?utf-8?B?cFFSbW0wMUc5YUU5aWdWM1VnZk1LZ3o2cEFBNnVQR2RIOHk0NWNvYWJ2VENa?=
 =?utf-8?B?Y1ZpbGJDNVk0T3djWlJBYngvMTljcWpEZElnKzVBNURMR2QrUUpRYUtWQmtF?=
 =?utf-8?B?VSsvY3dFNTZuMmdqM3R5dmMwcnZrSDRnUkRMMjBIWGR3NnpsTDVOdzBtN2Fa?=
 =?utf-8?B?eWo2dmZWQVVxdm02SWVTQWk4S29GblI2UXRMdzhPb0VFNkFta1Z6Z05zQ0Fx?=
 =?utf-8?B?WnkvUkF0MWZHSy9CUGJUMWZwQjZZUmtsc1lFN3JVSFY1U0FlZ0NuQ2pXcjNw?=
 =?utf-8?B?NGZyaUpLZFhLM3BESmxaUnE0OHdFamdMcHh1RGMxNHhIUGZGWlVQMmZXaVRF?=
 =?utf-8?B?Slk1bXRiTFBFVnlabDFlK2dURG5YVm9pVHNWNC81cG03ODYzUERoK1Fjejdt?=
 =?utf-8?B?QVNNUjd6Q1M4SlJidWlNcENkSFYrbUdYRW9zU3NJdEVUOXQxUm9CRU1JM2w3?=
 =?utf-8?B?ZXhpcGFLOVhHUjFCbTArN0EvVk5QNlF0bEtyOWtNandMZU5ZcldzYnNjUjFE?=
 =?utf-8?B?T2g4SDNFZVVMLzFraXlJVDNYdCtmTWtpaGlnWXdPOFdtaXUrK1JaeWVNa3p1?=
 =?utf-8?B?QTNiTit1S2hrQTFSN0tXTHpGTEUrZVdGcHNxakp6T1hiVEREQ1VTNlkvWGtw?=
 =?utf-8?B?cjFNZjEzR3JhcHhmY282K25CTkxkdFVudUsxaHlLMG9YdEhudmRNQ3RyeHNM?=
 =?utf-8?B?ZWxWQk5lb3RmN1NGbmtySllYQ2x5Q253c1Q5bzRnblAvdmxTOWI5NDVxcEh6?=
 =?utf-8?B?Z3NUazNWNjRKL0ZDTUJHK0YxSmQ3Z1d0Tm1abWdOUkxnZ01wOXZrZUNPT0RT?=
 =?utf-8?B?c2RUemp6RXdEMjROMWNYSUNYbmRKOXhjLy9nRHZtR2V5QXlGVlNLak8vbFRQ?=
 =?utf-8?B?cVByVnVuaFBCSDZ6WEplSTRnWnd2cTlTa0w2SHZqdVlSMHZwSDFxdTN4Q1gr?=
 =?utf-8?B?Z2M4U1RHUVhrczc2VHBoMVJqaGY1V3c4endpS0UvdUVSOUtQZis5YXBYQTBU?=
 =?utf-8?B?U29NME1CMVpVOUsvZU9USnNNeGVyTUR2eE5FMWdvSlByZ0xoTm9xb3FuRjIz?=
 =?utf-8?B?SmpzYkdhaFY3STcxbHFhRGNoTjJ6bTByZ2U4N1IyRkhxbi8xVGxHQVcxOFBw?=
 =?utf-8?B?bC8wUlhmUXQ5Q05rME5JaGE4WEpqaW9iSjdxK0JwSVJsUmZVMXprM3lBUmNx?=
 =?utf-8?B?QVp0UUZHTittZG1udlBrR292OFJlUVVDbTh3cUhzbms3Y1N0MmZVdjB2Qmhl?=
 =?utf-8?Q?oZP2euNn492tDBZZDI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b009294-e289-49c7-87fe-08df2df81980
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 15:46:11.2007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtdRC9hsiFW/5vjWqow3daRn6U9qDAGGTR/VgDrEtSYiMYY0dtosnIetXxHS7y6Dd4mx/yndXU239wyu3dk5tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXks
IE9jdG9iZXIgMTksIDIwMjYgMTA6MjggUE0NCj4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNz
ZS5aaGFuZ0BhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IGRyb3AgdGhlIGdhbmcgbGVhZGVyIHJlZmVy
ZW5jZSB3aGVuDQo+IGZyZWVpbmcgZ2FuZyBqb2JzDQo+DQo+IE9uIDEwLzE5LzI2IDAzOjQ4LCBK
ZXNzZSBaaGFuZyB3cm90ZToNCj4gPiBFdmVyeSBqb2Igb2YgYSBnYW5nIGV4Y2VwdCB0aGUgbGVh
ZGVyIGhvbGRzIGEgcmVmZXJlbmNlIHRvIHRoZQ0KPiA+IHNjaGVkdWxlZCBmZW5jZSBvZiB0aGUg
bGVhZGVyIGluIGpvYi0+Z2FuZ19zdWJtaXQuIE9ubHkNCj4gPiBhbWRncHVfam9iX2ZyZWUoKSwg
dXNlZCBmb3Igam9icyB3aGljaCBuZXZlciByYW4sIGRyb3BzIGl0LCBzbyBmb3INCj4gPiBldmVy
eSBnYW5nIHN1Ym1pc3Npb24gd2hpY2ggY29tcGxldGVzIHRoZSBzY2hlZHVsZXIgZmVuY2Ugb2Yg
dGhlDQo+ID4gbGVhZGVyLCBhbmQgd2l0aCBpdCBpdHMgaGFyZHdhcmUgZmVuY2UsIGlzIGxlYWtl
ZC4gYW1kZ3B1X2pvYl9mcmVlKCkNCj4gPiBpbiB0dXJuIGNoZWNrcyBmb3IgdGhlIGxlYWRlciBv
bmx5IGFmdGVyIGRybV9zY2hlZF9qb2JfY2xlYW51cCgpDQo+ID4gY2xlYXJlZCB0aGUgc2NoZWR1
bGVyIGZlbmNlLCBzbyBhIGxlYWRlciBmcmVlZCB0aGVyZSBkcm9wcyBhIHJlZmVyZW5jZSBpdCBu
ZXZlcg0KPiB0b29rLg0KPiA+DQo+ID4gT24gbmF2aTMxLCAxMDAgc3VibWlzc2lvbnMgb2YgYSBH
RlggKyBDT01QVVRFIGdhbmcgZ3JvdyB0aGUgc2xhYiBjYWNoZQ0KPiA+IGRybV9zY2hlZF9mZW5j
ZSBpcyBtZXJnZWQgaW50byBieSA2MCB0byAxODAgb2JqZWN0cyBlYWNoIHRpbWUsIHdoaWxlDQo+
ID4gMTAwIEdGWCBvbmx5IHN1Ym1pc3Npb25zIGRvbid0Lg0KPiA+DQo+ID4gVXNlIGFtZGdwdV9q
b2JfZnJlZSgpIGZvciB0aGUgam9icyB0aGUgc2NoZWR1bGVyIGZyZWVzIHRvbywgYW5kIGNoZWNr
DQo+ID4gZm9yIHRoZSBnYW5nIGxlYWRlciB0aGVyZSBiZWZvcmUgZHJtX3NjaGVkX2pvYl9jbGVh
bnVwKCkgY2xlYXJzIHRoZQ0KPiA+IHNjaGVkdWxlciBmZW5jZS4gQXMgdGhlIHNjaGVkdWxlciBj
bGVhcnMgdGhlIGVudGl0eSBvZiB0aGUgam9icyBpdA0KPiA+IHBpY2tlZCB1cCwgY2hlY2sgZm9y
IHRoZSBzY2hlZHVsZXIgZmVuY2UgaW5zdGVhZCB0byB0ZWxsIHdoZXRoZXIgdGhlDQo+ID4gam9i
IG5lZWRzIGNsZWFuaW5nIHVwLg0KPiA+DQo+ID4gVGhlIElCcyBvZiBqb2JzIHB1c2hlZCB0byB0
aGUgc2NoZWR1bGVyIGFyZSBmcmVlZCBiZWZvcmUgdGhhdCwgc28gdGhlDQo+ID4gSUJzIGxlZnQg
dG8gYW1kZ3B1X2pvYl9mcmVlKCkgb25seSBldmVyIHJhbiB3aGVuIHRoZSBqb2Igd2FzIHN1Ym1p
dHRlZA0KPiA+IGRpcmVjdGx5LiBGcmVlIHRoZW0gd2l0aCB0aGUgaGFyZHdhcmUgZmVuY2Ugb3Ig
cmlnaHQgYXdheSwgbmV2ZXIgd2l0aA0KPiA+IHRoZSBzY2hlZHVsZXIgZmVuY2UsIHdoaWNoIG5v
Ym9keSBzaWduYWxzIGZvciBqb2JzIGFib3J0ZWQgYWZ0ZXINCj4gPiBkcm1fc2NoZWRfam9iX2Fy
bSgpLCBsaWtlIGEgQ1MgcmV0dXJuaW5nIC1FQUdBSU4uDQo+ID4NCj4gPiB2MjogdW5pZnkgYW1k
Z3B1X2pvYl9mcmVlKCkgYW5kIGFtZGdwdV9qb2JfZnJlZV9jYigpIChDaHJpc3RpYW4pDQo+ID4N
Cj4gPiBGaXhlczogNjhjZThiMjQyMjQyICgiZHJtL2FtZGdwdTogYWRkIGdhbmcgc3VibWl0IGJh
Y2tlbmQgdjIiKQ0KPiA+IEZpeGVzOiBmN2Q2NmZiMmVhNDMgKCJkcm0vYW1kZ3B1OiBjbGVhbnVw
IHNjaGVkdWxlciBqb2IgaW5pdGlhbGl6YXRpb24NCj4gPiB2MiIpDQo+ID4gU2lnbmVkLW9mZi1i
eTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYyB8IDQ3DQo+ID4gKysrKysrKysrKysr
KystLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMjAg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2pvYi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfam9iLmMNCj4gPiBpbmRleCAwMDU2YTkzYzQwMGEuLmM1YzhjYjdkNjY2OSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMNCj4gPiBAQCAtMzEzLDIy
ICszMTMsNyBAQCB2b2lkIGFtZGdwdV9qb2JfZnJlZV9yZXNvdXJjZXMoc3RydWN0DQo+IGFtZGdw
dV9qb2INCj4gPiAqam9iKQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIGFtZGdwdV9qb2JfZnJlZV9j
YihzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqc19qb2IpICB7DQo+ID4gLSAgIHN0cnVjdCBhbWRncHVf
am9iICpqb2IgPSB0b19hbWRncHVfam9iKHNfam9iKTsNCj4gPiAtDQo+ID4gLSAgIGRybV9zY2hl
ZF9qb2JfY2xlYW51cChzX2pvYik7DQo+ID4gLQ0KPiA+IC0gICBhbWRncHVfc3luY19mcmVlKCZq
b2ItPmV4cGxpY2l0X3N5bmMpOw0KPiA+IC0NCj4gPiAtICAgaWYgKGRtYV9mZW5jZV93YXNfaW5p
dGlhbGl6ZWQoJmpvYi0+aHdfZmVuY2UtPmJhc2UpKQ0KPiA+IC0gICAgICAgICAgIGRtYV9mZW5j
ZV9wdXQoJmpvYi0+aHdfZmVuY2UtPmJhc2UpOw0KPiA+IC0gICBlbHNlDQo+ID4gLSAgICAgICAg
ICAga2ZyZWUoam9iLT5od19mZW5jZSk7DQo+ID4gLSAgIGlmIChkbWFfZmVuY2Vfd2FzX2luaXRp
YWxpemVkKCZqb2ItPmh3X3ZtX2ZlbmNlLT5iYXNlKSkNCj4gPiAtICAgICAgICAgICBkbWFfZmVu
Y2VfcHV0KCZqb2ItPmh3X3ZtX2ZlbmNlLT5iYXNlKTsNCj4gPiAtICAgZWxzZQ0KPiA+IC0gICAg
ICAgICAgIGtmcmVlKGpvYi0+aHdfdm1fZmVuY2UpOw0KPiA+IC0NCj4gPiAtICAga2ZyZWUoam9i
KTsNCj4gPiArICAgYW1kZ3B1X2pvYl9mcmVlKHRvX2FtZGdwdV9qb2Ioc19qb2IpKTsNCj4gPiAg
fQ0KPiA+DQo+ID4gIHZvaWQgYW1kZ3B1X2pvYl9zZXRfZ2FuZ19sZWFkZXIoc3RydWN0IGFtZGdw
dV9qb2IgKmpvYiwgQEAgLTM0OSwxNA0KPiA+ICszMzQsMzYgQEAgdm9pZCBhbWRncHVfam9iX3Nl
dF9nYW5nX2xlYWRlcihzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iLA0KPiA+DQo+ID4gIHZvaWQgYW1k
Z3B1X2pvYl9mcmVlKHN0cnVjdCBhbWRncHVfam9iICpqb2IpICB7DQo+ID4gLSAgIGlmIChqb2It
PmJhc2UuZW50aXR5KQ0KPiA+IC0gICAgICAgICAgIGRybV9zY2hlZF9qb2JfY2xlYW51cCgmam9i
LT5iYXNlKTsNCj4gPiArICAgc3RydWN0IGRtYV9mZW5jZSAqZiA9IE5VTEw7DQo+ID4gKyAgIHVu
c2lnbmVkIGludCBpOw0KPiA+DQo+ID4gLSAgIGFtZGdwdV9qb2JfZnJlZV9yZXNvdXJjZXMoam9i
KTsNCj4gPiAtICAgYW1kZ3B1X3N5bmNfZnJlZSgmam9iLT5leHBsaWNpdF9zeW5jKTsNCj4gPiAr
ICAgLyoNCj4gPiArICAgICogVGhlIElCcyBvZiBqb2JzIHB1c2hlZCB0byB0aGUgc2NoZWR1bGVy
IHdlcmUgYWxyZWFkeSBmcmVlZCB3aXRoIHRoZQ0KPiA+ICsgICAgKiBzY2hlZHVsZXIgZmVuY2Ug
YmVmb3JlIHRoYXQuIFRoZSByZW1haW5pbmcgb25lcyBvbmx5IGdvdCB0byB0aGUNCj4gPiArICAg
ICogaGFyZHdhcmUgd2hlbiBzdWJtaXR0ZWQgZGlyZWN0bHkuIERvbid0IHVzZSB0aGUgc2NoZWR1
bGVyIGZlbmNlDQo+ID4gKyAgICAqIGhlcmUsIGl0IG5ldmVyIHNpZ25hbHMgZm9yIGpvYnMgYWJv
cnRlZCBhZnRlciBkcm1fc2NoZWRfam9iX2FybSgpLg0KPiA+ICsgICAgKi8NCj4NCj4gRHJvcCB0
aGF0IGNvbW1lbnQsIGl0IGlzIG1vcmUgbWlzbGVhZGluZyB0aGFuIGFueXRoaW5nIGVsc2UuDQo+
DQo+ID4gKyAgIGlmIChkbWFfZmVuY2Vfd2FzX2luaXRpYWxpemVkKCZqb2ItPmh3X2ZlbmNlLT5i
YXNlKSkNCj4gPiArICAgICAgICAgICBmID0gJmpvYi0+aHdfZmVuY2UtPmJhc2U7DQo+ID4gKyAg
IGZvciAoaSA9IDA7IGkgPCBqb2ItPm51bV9pYnM7ICsraSkNCj4gPiArICAgICAgICAgICBhbWRn
cHVfaWJfZnJlZSgmam9iLT5pYnNbaV0sIGYpOw0KPiA+ICsNCj4gPiArICAgLyoNCj4gPiArICAg
ICogVGhlIGdhbmcgbGVhZGVyIGRvZXNuJ3QgaG9sZCBhIHJlZmVyZW5jZSB0byBpdHNlbGYuIENo
ZWNrIGJlZm9yZQ0KPiA+ICsgICAgKiBkcm1fc2NoZWRfam9iX2NsZWFudXAoKSBjbGVhcnMgdGhl
IHNjaGVkdWxlciBmZW5jZS4NCj4gPiArICAgICovDQo+DQo+IFNhbWUgaGVyZS4gVGhhdCBzaG91
bGQgYmUgZG9jdW1lbnRlZCBvbiBqb2ItPmdhbmdfc3VibWl0IGlmIG5lY2Vzc2FyeS4NCj4NCj4g
PiAgICAgaWYgKGpvYi0+Z2FuZ19zdWJtaXQgIT0gJmpvYi0+YmFzZS5zX2ZlbmNlLT5zY2hlZHVs
ZWQpDQo+ID4gICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dChqb2ItPmdhbmdfc3VibWl0KTsNCj4g
Pg0KPiA+ICsgICAvKg0KPiA+ICsgICAgKiBOb3Qgam9iLT5iYXNlLmVudGl0eSwgdGhlIHNjaGVk
dWxlciBjbGVhcnMgdGhhdCBmb3IgdGhlIGpvYnMgaXQNCj4gPiArICAgICogcGlja2VkIHVwLg0K
PiA+ICsgICAgKi8NCj4NCj4gSHVpPyBXaGF0IGRvIHlvdSBtZWFuIGhlcmU/DQpkcm1fc2NoZWRf
ZW50aXR5X3BvcF9qb2IoKSBzZXRzIHNjaGVkX2pvYi0+ZW50aXR5IHRvIE5VTEwgd2hlbiB0aGUg
c2NoZWR1bGVyIHRha2VzIHRoZSBqb2Igb2ZmIHRoZSBlbnRpdHkncyBxdWV1ZS4NCiBTbyBmb3Ig
dGhlIGpvYnMgZnJlZWQgdGhyb3VnaCBhbWRncHVfam9iX2ZyZWVfY2IoKSwgd2hpY2ggbm93IGVu
ZHMgdXAgaW4gYW1kZ3B1X2pvYl9mcmVlKCksIGpvYi0+YmFzZS5lbnRpdHkgaXMgYWx3YXlzIE5V
TEwsDQogYW5kIHRoZSBvbGQgaWYgKGpvYi0+YmFzZS5lbnRpdHkpIGNoZWNrIHdvdWxkIHNraXAg
ZHJtX3NjaGVkX2pvYl9jbGVhbnVwKCkgZm9yIHRoZW0gYW5kIGxlYWsgdGhlIHNjaGVkdWxlciBm
ZW5jZSBhbmQgdGhlIGRlcGVuZGVuY2llcy4NCiBqb2ItPmJhc2Uuc19mZW5jZSBpcyBzZXQgYnkg
ZHJtX3NjaGVkX2pvYl9pbml0KCkgYW5kIG9ubHkgY2xlYXJlZCBieSBkcm1fc2NoZWRfam9iX2Ns
ZWFudXAoKSwNCiBzbyBpdCB0ZWxscyB3aGV0aGVyIHRoZSBqb2Igc3RpbGwgbmVlZHMgY2xlYW5p
bmcgdXAgZm9yIGJvdGggdGhlIGFib3J0ZWQgam9icyBhbmQgdGhlIG9uZXMgdGhlIHNjaGVkdWxl
ciByYW4uDQogSSB3aWxsIGRyb3AgdGhlIGNvbW1lbnRzIGluIHYzLg0KDQpUaGFua3MNCkplc3Nl
DQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gPiArICAgaWYgKGpvYi0+YmFzZS5z
X2ZlbmNlKQ0KPiA+ICsgICAgICAgICAgIGRybV9zY2hlZF9qb2JfY2xlYW51cCgmam9iLT5iYXNl
KTsNCj4gPiArDQo+ID4gKyAgIGFtZGdwdV9zeW5jX2ZyZWUoJmpvYi0+ZXhwbGljaXRfc3luYyk7
DQo+ID4gKw0KPiA+ICAgICBpZiAoZG1hX2ZlbmNlX3dhc19pbml0aWFsaXplZCgmam9iLT5od19m
ZW5jZS0+YmFzZSkpDQo+ID4gICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dCgmam9iLT5od19mZW5j
ZS0+YmFzZSk7DQo+ID4gICAgIGVsc2UNCg0K
