Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683E9CD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 02:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9644810E14D;
	Thu, 21 May 2026 02:18:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wK2WSUAF";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0EEE10E14D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 02:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dsg9/16mdbU6G8i23sH+Sj2wwrWB+X2eYPM82FJG9vpQHuYnjdx+erfb/DEEXwD7Hac4KCGqHda9Y3Xzp9TworgSbmIQUffr4vRcVDehDDDBlU7CyqFrxHdYZv6S0k57OA5nBvXuSVuY6/dYfGr12rIzH8M9w/ucWNdky2G55+xpfKeOvWiJpK4uqPMjAeLXVGlf/B63fdYfHrMYs+eGFL6+evzPW/f0OK1PvHPuMgIKRQef23jx8eAC/jb71d/Gr/eFW2MRx2eMtzLI5jQLBUTu+ze2JDsAH7bJukb3iJ+Sh/wFaxHpaGFHvGM76i/E4dpPNiljmVnR8baJ9HHJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29rm2DNvPAgJvHDkYgjOSf9V1T0Tdi1OuhvaLHFLehU=;
 b=CjSeca1nz++QJXS74dJy4G9YiBakUH2d2+oK5Bg1CTo4Y1EJDMOhTn0PVvBkVUm0tcvxo7OJN27dwAaBNWYc+WKBxBYcDRsED5fyVVCQRj5a2FhZe31qSKPVuf6FG+wCog3pC/5VskCj7Ihpf/1tRq06xp8LvcetTNlvIY4x7pCnKc3zAqbaf1kX+QD93E3iLqroC1GmM+f7gHqfBHtuOtZTKI+/qH9ahWwcohdpjUt5SF/IdknA1wiynRW2j7/DOU0jjrTIhZINa5qs/XNTZRs/wc7nwoJ4i4BkdZx5BVy6cdxayx4iOqUuEA0JjCVw0Xrpp469qicptD+Af9m2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29rm2DNvPAgJvHDkYgjOSf9V1T0Tdi1OuhvaLHFLehU=;
 b=wK2WSUAFBmCpY6hCrzDefZSw0VbzjOEg3AMolV++bxjixbEBmFWIDHOdKlq6CM7IbGnm1XZY+YUxBTZgBV/r8eYhNF1P5j41IqcSQmf/GtWGgLA6hLJgPI3ESyKB2Ec03OEia6qFSJ3t4GZyEL4773Aa9dtKbRwJyqp5JCtVI2w=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 02:18:53 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 02:18:53 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Thread-Topic: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
Thread-Index: AQHc4585QHymMJ9kqUu5GNrLN/0ywrYWz4AAgACxfACAAEVoIA==
Date: Thu, 21 May 2026 02:18:52 +0000
Message-ID: <DS7PR12MB600552D3A6C39D1A9CD86AB3FB0E2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260514124250.3833711-1-Prike.Liang@amd.com>
 <20260514124250.3833711-2-Prike.Liang@amd.com>
 <cff0a9b1-5e02-48ee-bd1c-bd0f31d89bae@amd.com>
 <BL1PR12MB5144F90F81E91323361BF09EF7012@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144F90F81E91323361BF09EF7012@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-20T21:58:55.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH0PR12MB5645:EE_
x-ms-office365-filtering-correlation-id: eedb2702-5229-42dc-20ef-08deb6df4da6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|38070700021|22082099003|4143699003|6133799003|11063799006;
x-microsoft-antispam-message-info: LOHtCLvXzzaSCsDB9Ia2Pcuss6ZMu9Qte5OdoSUfnN/3eEJaAitxWVPPoljCMOPrN4MyDdofGvP4s5aI3gGF6I74me80eStCIveUmgsTjQlOm+4T8GW8u0KLm7bizFeLKzfn7xxYWDfbeQejhGibsrmVnb3MJnSWOpdbd2EhLp4ERDvvuhcQJvNUXs7h/xsob2AaZ86V3u41X79TCftYxDtF1SdfJWAUu8R7tXGpPY268+bIvfNOCqxPN6ZGxYVoIWfOeV6RYH9FC5FnfA1mYswho1mJy9+OQ6/x477K/UV+y2omNXRC4PsfIhBvwY/rbg7u3BodgpCjqEzr/o+cPHsGMT6OWMhK4Dy709G0B4nYVp0nwrZ12LhKx9lfqTld0UDlDI9Or5sA+pFJ2xxBmovYNVJ2qBX1kk/5E8h4obvz6eRKjeEw9889Gyt8RkXUjPU8CJcppHc2Bijf6uHY51wxZuL8mUNBO8luaqV+eAoMpVw0Wy8MmYhTjr7n3M03eIpJEFHE8agd0IbqClKemFbI+RhaeDrQ8xH/L7J6B1RKhEsL7F9mF+El6GbhygE+Sqy/P3iqodoAZCDx8rS6MEpEeVwYtzcvfHx3sER1UpTI+IxNCXNiE7S0wKc+tIRq/+dQhArnvyGHa+0Xb8WgQdbgiJDZ4Bw4q4uE+zdB4iYOFxkcZu+cMG4X1P5nCIZBCcZiPSb9WUm37d5qcuS2uUmDpDB/Gjq8PA4JI6wF9txOmDXEK9O2C+n8VbnHVoSj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(38070700021)(22082099003)(4143699003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJodlJlM014bVdES25VMGY2NXJ1Q1MyTW9BYkFIYlBmM1FObDdMd3lkU1Jo?=
 =?utf-8?B?UGZhVnRRQ0UvTzlVTlNGcXdoRVZ6eUlwL0YrQVlnRmlMVkRGNXQrb2xwbUc0?=
 =?utf-8?B?RHc2blhPaFo5a2dudGpXUGNZb0gvRmU0cmgzbGJHeDNsTWVpbmM0UE5mMTFO?=
 =?utf-8?B?QXVaRmQ5Lzl0cEFDd2psdXZNVmNGZmtmc3YreE9BT0lPam9zdUl5VjRFdlJD?=
 =?utf-8?B?eG9YSE9hZlVHUEJVTTFYMnRrRi9PN1FzcS9mYWplbjl0YkdWd3NCLzd4czBF?=
 =?utf-8?B?QUZkbnV6QWtLVlc0MGEvd09PclNsRjBNbEV2OWcvZ0t1MnZ0dUNCUFFEMHc0?=
 =?utf-8?B?dGhEOXdwMTl5WDNkdUQ2MllBU2p1VnlidjVOQlIzWHNtbmhFbm5jZXdrZGpR?=
 =?utf-8?B?R1dXcTkvTmd3cEI2ZW4vMW13aHFKZ29FaUljM2QvS3l0bG5XZU5QT0tzZUNu?=
 =?utf-8?B?VnJjdG5GQnl0R0poWjlMNkJTUlphbWdHTnBZdzdHbSsrVy9oL2tFRzlOeUxC?=
 =?utf-8?B?Vm4rdSt5cWd0NnBMa1R3SUV5aktudFp2Z29CNmdPTU5yZHdsNXdPZTRtTXMw?=
 =?utf-8?B?N2FTdm5FK0FKbHBzeWlEYkxJVW9wMDlwNStHWHZ3ZTdNWEwzeWtzaktKZFdK?=
 =?utf-8?B?K0NCRGVvUUNmMkZ5ckRBeGc0T3hIT3lPN0h5bG9yRklzNENOMHFjNUt2ZmRU?=
 =?utf-8?B?STVHTU1PeU1ZVnpIKzF2d1I3VndzZmFYV2tyWTBvbFkzbXUwQ0lNYVFQeWJO?=
 =?utf-8?B?STZXZmhIYi9lc0lPTG1wOTFSRis5TW9QNkhZUy93VTJzSjUxZEZxcS9ycmpw?=
 =?utf-8?B?MGxtUlV6ME9iWENTOWhGUU8vVzQ2dU0zOElTU3VBTGdObnorZkFremdZK0ZK?=
 =?utf-8?B?MVBDUUFnQndKalJYKzc1NHN0bjdlV1VzemlHMnhmNFZIY0QzcmtHQUlYbEs5?=
 =?utf-8?B?Y05vVU5aaGw4MWh4OTMxVzZsTGFZcDhaK05DTWJqbkIxcjdUaTRHNnNRNTRm?=
 =?utf-8?B?SHdaVjNBdGV4WmF2ZG5NV1hqbVM0RlpmQXVBd0FnWkpRWWdUTlZYRzhCT2xW?=
 =?utf-8?B?ckJDR2N1Z0xHcUlMMjNKMnFJNmlXZ2FuWTZYZE1KbzdxU3kzV1BxdXhaVkZJ?=
 =?utf-8?B?WG82K2ZwVGlXNEtYWUIwelZ6RjFKRTRtZVF6blYxUjh3QjVFREJadFg1TFhw?=
 =?utf-8?B?UnZCekZxOFl0eXNWRk9yOWlZWTZTN3F5L1dqVGJvYlAzUHhIWG1yZ1VIcklP?=
 =?utf-8?B?UWtzdlpXOTRpenhiQThqWjZlam43NG1iVUV6K3prSXJsS2RsVk5mYm80d1ND?=
 =?utf-8?B?VVQ0Q1huUFNHVmJDNDNKeXZ3V0pDcXdySklyTXdqQnZFYW5iWTQ1TFloR3pL?=
 =?utf-8?B?MGV2Ny8vdjc5blpCQlplL1gzYlp4TS9GSGlUaXJyTEpVRS9oM0ZYeHJwUnkw?=
 =?utf-8?B?VVpYVHRUTENDbEVJT0VKUVQxQkxlcE9CRDZzTHFSNEw3NHQyL25zR2JVSzlW?=
 =?utf-8?B?VXJaRnp5RHFlYUdLMmZKZTI0WU53M1JNVjBweHpDa0tHd3VUc2cwWHJuME9z?=
 =?utf-8?B?bEtCbERwaFp4WGQzUGpSRFk2UFhJbnNlN3JTaTBWYVlUa2pHVHl6UCtpd1BH?=
 =?utf-8?B?YkR2S3FwcDVLRVNPcFFrZnpMSjJZczF6ajFwVjl3UUw4ZHlpYStISmpzTTNS?=
 =?utf-8?B?UThGcEV0L0dlc2MwWUMra2Jab3ZReEFLUGFnUmkzaGJkd2hyK2FkRkpxeFZS?=
 =?utf-8?B?TUJtajd6Z2w2OUlXK0wyQm9yZ0FpQnQxUFFtR21sZlpSWE5FTi9oQ05ZWjNl?=
 =?utf-8?B?VzkxY0hzajJKRVFDdlZMemJIMGl3YlEzOFpuQkZwVVZQSStmTFRTWTRsQjg1?=
 =?utf-8?B?MCs3MFNUSnhVK1VxOHJmUlZkMU03dndyYVNOL2FmUmdOcTRLYm9iYUhtaUN1?=
 =?utf-8?B?OTlXZHhGOXY0Si94K25IQXZ2TFFhck0wTlN6U3lZVUtuRFVTK2Q3R1hCTFFv?=
 =?utf-8?B?YjBGUGU5YnFPNEpUVXB0S0V3SFdIeUpEUUdrOEsvMTFoOHRKQ1g0MGdNVlhU?=
 =?utf-8?B?RzVMNGRCYzdOeHAvRENHQVhYYXJPajZrTFJCTzh1RGE4dkNtQTNhdWNjQ1JM?=
 =?utf-8?B?Z1pFaGFablN5SmhWTi9ySHVOcEN3RFo5L2ZhV0xuOUtGOTM0SEQ4aGhSdEZJ?=
 =?utf-8?B?bmN3UDVRam9kTUFZTWxQYTJKVm1FZnpqU3lTd0FHUUZTeEJSRUZodVdOYXVV?=
 =?utf-8?B?RXpxOU5ieUFrZGgzcTVJdHJEdlltSWV0cTk4NExNMEJuM0hacWFvZGxsT0U2?=
 =?utf-8?Q?EBsOQatl1igk8xkA49?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedb2702-5229-42dc-20ef-08deb6df4da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 02:18:52.9271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdKFYu9Q1H7cPNRx43dYuGokj1FqJXaSIZ2WXx0rzrrmcl94z8JaZLD07X+U5ozb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
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

UHVibGljDQoNClJlZ2FyZHMsDQogICAgICBQcmlrZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSAyMSwgMjAyNiA2OjAxIEFNDQo+IFRvOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTGlhbmcsIFByaWtlDQo+
IDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
U3ViamVjdDogUkU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IHVubWFwIHVzZXJxIGZvciBldmlj
dGluZyB1c2VyIHF1ZXVlDQo+DQo+IFB1YmxpYw0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIE1heSAyMCwgMjAyNiA3OjI2IEFNDQo+ID4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+ID4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogdW5tYXAg
dXNlcnEgZm9yIGV2aWN0aW5nIHVzZXINCj4gPiBxdWV1ZQ0KPiA+DQo+ID4gT24gNS8xNC8yNiAx
NDo0MiwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4gPiBJZiB0aGUgZHJpdmVyIG9ubHkgcHJlZW1w
dHMgcXVldWVzLCB0aGVyZSBjYW4gc3RpbGwgYmUgaW5mbGlnaHQNCj4gPiA+IHdhdmVzLCBwZW5k
aW5nIGRpc3BhdGNoIHN0YXRlLCBvciByZXN1bWUvcmVkaXNwYXRjaCBwb3NzaWJpbGl0eSB0aWVk
DQo+ID4gPiB0byB0aGUgc2FtZSBxdWV1ZS4gVGhlbiB0aGUgVk0vVFRNIHNpZGUgbWF5IHByb2Nl
ZWQgdG8gbW92ZS91bm1hcA0KPiA+ID4gcXVldWUgcmVsYXRlZCBCT3MgZHVyaW5nIGV2aWN0aW5n
IHRoZSBxdWV1ZSB3aGlsZSBzaGFkZXIgVENQIGNsaWVudHMNCj4gPiA+IHN0aWxsIG5lZWQgdG8g
YWNjZXNzIHRoZW0uDQo+ID4gPg0KPiA+ID4gU28gZm9yIGV2aWN0aW9uLCB1bm1hcCBpcyBzYWZl
ciBiZWNhdXNlIGl0IG1ha2VzIHRoZSBxdWV1ZQ0KPiA+ID4gbm9ucnVubmFibGUgYmVmb3JlIG1l
bW9yeSBiYWNraW5nIGlzIGludmFsaWRhdGVkLiBNZWFud2hpbGUsIGZvciBhDQo+ID4gPiBpZGxl
IHF1ZXVlIGl0J3MgbW9yZSBzdXRpYWJsZSBmb3IgdW5tYXBwaW5nIGl0IHJhdGhlciBwcmVlbXB0
IGFuZA0KPiA+ID4gdW5tYXBwaW5nIGFsc28gc2FmZSBtb3JlIHByb2Nlc3NpbmcgdGltZSB0aGFu
IHByZWVtcHQuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtl
LkxpYW5nQGFtZC5jb20+DQo+ID4NCj4gPiBJIHdhcyBhbHJlYWR5IHdvbmRlcmluZyB3aGVuIHdl
IHN3aXRjaGVkIHRvIHByZWVtcHQgaWYgdGhhdCBpcyBjb3JyZWN0DQo+ID4gb3Igbm90Lg0KPiA+
DQo+ID4gVGhpcyBwYXRjaCBoZXJlIHByZXR0eSBtdWNoIGNvbmZpcm1zIHRoYXQgaXQgd2FzIG5v
dCBjb3JyZWN0LiBJIG5lZWQNCj4gPiB0byBkaXNjdXNzIHdpdGggQWxleCB3aGF0IHRvIGRvIGhl
cmUsIGJ1dCBmb3Igbm93IHRoZSBwYXRjaCBpcyBjbGVhcmx5IGEgYnVnIGZpeDoNCj4gPg0KPiA+
IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
DQo+DQo+IFdoYXQncyB0aGUgcG9pbnQgb2YgaGF2aW5nIGEgcHJlZW1wdCBvcGVyYXRpb24gaWYg
aXQgZG9lc24ndCBhY3R1YWxseSBwcmVlbXB0IHRoZQ0KPiB3b3JrPyAgU2VlbXMgbGlrZSBhIGZp
cm13YXJlIGJ1Zy4NCk1heWJlIHRoZSBNRVMgZXhlY3V0ZXMgdGhlIHByZWVtcHQgb3BlcmF0aW9u
IGNvcnJlY3RseSwgYnV0IHRoZSBkcml2ZXIgbWF5IG5lZWQgdG8gZnVydGhlciBoYW5kbGUgdGhl
IGZvbGxvd2luZyB0aGluZ3MuDQoxKSByZW1vdmUgdGhlIHVuYm91bmQgd2FpdGluZyBmb3IgdGhl
IHF1ZXVlIHByZWVtcHQuDQoyKSBuZWVkIHRvIHZhbGlkYXRlIHRoZSB1c2VyIHF1ZXVlIGludGVy
bmFsIEJPcyBsaWtlIGFzIENTQS9XUFRSL0VPUCBldGMgYXMgd2VsbCBiZWZvcmUgcmVzdG9yaW5n
IHRoZSBwcmVlbXB0ZWQgcXVldWUNCjMpIHVzZSB0aGUgdW5tYXAgdGhlIHF1ZXVlIGF0IHRoZSBm
aXJzdCBwbGFjZSwgYnV0IGZvciB0aGUgbG9uZyBzaGFkZXIgY29udGV4dCBiZXR0ZXIgdG8gZmFs
bGJhY2sgdG8gdGhlIHByZWVtcHQgb3BlcmF0aW9uIGZvciBzaW1wbGlmeWluZyBzYXZlL3Jlc3Rv
cmUgbGF0ZW5jeSBhbmQgYXZvaWRpbmcgdGhlIHVuYm91bmQgd2FpdCB0aW1lb3V0Lg0KDQo+DQo+
IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+
DQo+IEFsZXgNCj4NCj4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBDaHJpc3RpYW4uDQo+ID4NCj4g
PiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5j
IHwgNCArKy0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxLmMNCj4gPiA+IGluZGV4IDJlM2VkYjZkZDUwNi4uYTYzZGZkZmE0MTk1IDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJx
LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5j
DQo+ID4gPiBAQCAtMTA0OCw3ICsxMDQ4LDcgQEAgYW1kZ3B1X3VzZXJxX3Jlc3RvcmVfYWxsKHN0
cnVjdA0KPiA+IGFtZGdwdV91c2VycV9tZ3IgKnVxX21ncikNCj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+ID4gPiAgICAgICAgICAgICB9DQo+ID4gPg0KPiA+ID4gLSAgICAg
ICAgICAgciA9IGFtZGdwdV91c2VycV9yZXN0b3JlX2hlbHBlcihxdWV1ZSk7DQo+ID4gPiArICAg
ICAgICAgICByID0gYW1kZ3B1X3VzZXJxX21hcF9oZWxwZXIocXVldWUpOw0KPiA+ID4gICAgICAg
ICAgICAgaWYgKHIpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgIHJldCA9IHI7DQo+ID4gPg0K
PiA+ID4gQEAgLTEyODUsNyArMTI4NSw3IEBAIGFtZGdwdV91c2VycV9ldmljdF9hbGwoc3RydWN0
DQo+ID4gYW1kZ3B1X3VzZXJxX21ncg0KPiA+ID4gKnVxX21ncikNCj4gPiA+DQo+ID4gPiAgICAg
LyogVHJ5IHRvIHVubWFwIGFsbCB0aGUgcXVldWVzIGluIHRoaXMgcHJvY2VzcyBjdHggKi8NCj4g
PiA+ICAgICB4YV9mb3JfZWFjaCgmdXFfbWdyLT51c2VycV94YSwgcXVldWVfaWQsIHF1ZXVlKSB7
DQo+ID4gPiAtICAgICAgICAgICByID0gYW1kZ3B1X3VzZXJxX3ByZWVtcHRfaGVscGVyKHF1ZXVl
KTsNCj4gPiA+ICsgICAgICAgICAgIHIgPSBhbWRncHVfdXNlcnFfdW5tYXBfaGVscGVyKHF1ZXVl
KTsNCj4gPiA+ICAgICAgICAgICAgIGlmIChyKQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICBy
ZXQgPSByOw0KPiA+ID4gICAgIH0NCj4NCg0K
