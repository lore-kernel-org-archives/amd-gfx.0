Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C12C61DF0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 04:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1D410E24E;
	Mon, 31 Aug 2026 04:30:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bfbvtPwF";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878D010E24E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 04:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+qehXWSFQmK6E68hFy4kwZ9FQ04LY/ftYTO9Rhyas9WJEZ0std4CHRHqpADmXQ1iQWLnNA0pAK+jaV2nMCkzSsoMolB8ZNd+GwLI/IRhFVk1MI7Zva9B0n/2gh3siYqJhci8S3Qtl0Bdoa6Dbou9+Y4LHL+LVXhR98oFveM16fIrS66dQxsboMVlkia4+GT+DGgSUkX4UUwFFBXx8TSZE2Kl9E5+3KtS7+Cp6hUmHJ/IiTI0vsVmH09fDWaKZx7RHQrqPkJ03cIiUqpd4DBlcoVGx88+M2uw5IFW3QtdlqPCjIFEs8/A1w95XfR1ED1IXuC9KZP9zhYFubQKs4iPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQUkUa348etuouoblPjxWa6bZPDCd6ixJ7O6tXw8rM0=;
 b=h+oaIlXgA4W4EuFdpwdAxCn3VRn37fF9Qi3XQWniF2eennK3y0tWgAAa550dbyPJQg8k4mWZfWySbXLVySxAW4UQtpearlTixW9EX0AklTpbmkJrmMVJC0U1Ozka53CGpJ5tt3wwK0w+PfK632eU//EKSl5L2/c6O34uHzuLIRrF/H9S2ITkEEEqQDtkehblUIcS2rVGQGhB8XJ/y/GTcMxnJmKyzZoHsixW0r+FUCDX6u/RWlZijFWRZDeVhfVVOOLwzYDPsFb8w1oM20EmHUB0uP55bJ182SYjleQ5562W142c0oQuy364EqNPhe4xvDd9ZXihah1tthH1TX0Gdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQUkUa348etuouoblPjxWa6bZPDCd6ixJ7O6tXw8rM0=;
 b=bfbvtPwFegUdVs/PnViyNECIS6TaYkIR8p6NGwL5i5iGEVcujevhgU5CfU4LpmA51dco6fb7xZ3uP7wqFVvpBhnq61FSmunCHUnojVXeunysHs69WwNsF16huVNnnqHWElvZ8kPctFUadQVwdLqENqWkpoGVUFUq8gtB6AN6SEA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 04:30:13 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 04:30:13 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2 03/10] drm/amdgpu/gfx11: implement compute and GFX
 update_mqd
Thread-Topic: [PATCH v2 03/10] drm/amdgpu/gfx11: implement compute and GFX
 update_mqd
Thread-Index: AQHdNqPvbORX8Le6MEaQoSjw3udJ6baz1jiAgAO9TzA=
Date: Mon, 31 Aug 2026 04:30:13 +0000
Message-ID: <DM4PR12MB51526DE90C3F4B936B5CD5D6E3A92@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
 <20260828041537.3464782-3-Jesse.Zhang@amd.com>
 <CADnq5_OrH3pSwu5sAs5KOCtN7JGPdZj33o63wFxR0SsqWjkXXw@mail.gmail.com>
In-Reply-To: <CADnq5_OrH3pSwu5sAs5KOCtN7JGPdZj33o63wFxR0SsqWjkXXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-31T04:22:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH3PR12MB7617:EE_
x-ms-office365-filtering-correlation-id: c28a98b3-ff64-49c5-ee2d-08df07188ccf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|22082099003|4143699003|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: synPXoL/6RlIKpXPkspU+zDoLZihH/MOt0EBVkh4KCxWZidKkkrVkbj3GuOCTeJGiEtA+a4IMyAB2wDytd1eiVVqT8/osObYDxWEz6KMdLYa6bs52ODO+8Nhwiv25Ky08ts5aibtuQnasFuBA8ImIKxzX6yBHwvdQ08C1Uqxsq0GyFkO+hJCzJUvIXnfjsRgxObRVK2CzcgmrAT/0PxPk1Rb6/1H6owD/yjF5UJMBEhEnhunAhJfVcvcjcI5NxYOvBCJCUdgqWs4GZpmpWTsyONsizyfnil6QZaiG0bNR6d+Roc+ZtdGqza2EkpxmKyyUFGOY54WZLIhl1KfpkE+MlKlTykDUiAyYh0ECtczUXYvQqV/Pq+1XELsSYDwqlUj3pydwRvyPyauSJ/DIBX8gwdRTCniTe0FyXtiFYZx+DoWV9g43/qkBbKHYQ8dRZ8pcsGDEJMHuE8EnLeBwM2Gf13FoWe0TXkBK+PtRE/4rGM8zi+inw30nckcbLmUHLGmwnUGW1d7ZhtHEQN9nJnFcM3UqL+Ot6IU3l69HbpD6oMKx4ataG9VOlIKQ4zIA03gFYXJn7co0zVuU6VRi9LZtvmO8G9zUebFv/gaCPi1Xy8xKbzh5cfLASn0vBK9ojAJF5ivsAUItHzR/Tod24DGEugYXisEkwHZ08NmKWBqe+nNIPSpRVFXV6e9FqzJQrdcd7XdP3JF7yq16MF0ZCp4vl65+HpbZmQypXvDLOdekbs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(4143699003)(56012099006)(11063799006)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnJEOU9WNk8rK2xXWDY4Z0RaeDlneWw3NEIyR205NXozMUErOVhySzdxV21J?=
 =?utf-8?B?ZW9mZVFKZlhqaHkxb0xCSEJsVnZNZkx1c3FQWGtrWGQ3RFBBTEszT2FLTWM0?=
 =?utf-8?B?My9wU2U4TTNXWjByTko0RWk0enVnem5sU0YxQ1FpUytXQy93Kzc0MHBTQ2h6?=
 =?utf-8?B?dFRuWTlNMTRxbWcrOGdqbXgrSmRYOW4vNncrUFl1VVl1QXNNR3JuK0ZQdVhI?=
 =?utf-8?B?OFZSUVN0a05VTUN3d2FIMzNGbHVqbjBIb2d2a1U2RlhmckVXVDF6S0FBOFZY?=
 =?utf-8?B?RHM3WE5UNCtxMFlZOXZzVys0SzZ4MmhLRzlBTDREem9TSFhJZXFHM25aejRH?=
 =?utf-8?B?M2dHaDBCdTN0QzY4R2VCcHBQb2g0bkhoUkhSV2EvQlNKdnhkS3VXU2phTWxu?=
 =?utf-8?B?REpWcGwvVHA2U0lvUHQ4cytIN3g3UGl2T1czU2NTQmZ2dTZRUjhJVTVJcUti?=
 =?utf-8?B?emNDaW9pamFrbnAwcWE3VkNMYTcwQkx2bklQRytVNWhIUnV3TCtrRkVDSWV4?=
 =?utf-8?B?MFBLdVloTmsza1JuZGhNY2hkYW1jVCtQTUpuVHZBdkUwT0tma1BPMkF2VXpo?=
 =?utf-8?B?dVJEcVlhNUZGbE9aTmhxWmljSHpFaDJ5NFJOd1JWODNqTjJEMzZqUDlaNlZn?=
 =?utf-8?B?NU0wOS9BWVdEVDFGZjlZOXJnWncrSUJZang0eFFuZUVydkxTVjVBZlpWTGZz?=
 =?utf-8?B?WXJWYWhyR0lVRlVtVzdOa1drYjdKeFp1VzZMRlZXeFlrWHhyUE5Lai80QlV4?=
 =?utf-8?B?dkZ2RnJIR3ZUZ2lrUHVGdHA4cTkzQ1ducW5FM2ZnenhZR0hQbFBHZjMvSTZY?=
 =?utf-8?B?K2VMNXAzT1U4eVB6VU8xbG1CZVJNcGVoUm5vRHMvTzhiRitTVUdBWEMwUjVs?=
 =?utf-8?B?N2JXYVJPZFBJbUR2MFdNNGF3am84azg1dmpmOWRlditUM3JhNENLQmlMNVBa?=
 =?utf-8?B?WU1PMDNUK2VDZmYwcjdJSG5QLzdqRm9yQzZnOWI3ZVRRcmhuSUM4c3FuZ203?=
 =?utf-8?B?VW1WbHAra2YyejZ6M2oxN2N3MTgwQlhvRnBsdDZLZXFCZkN6QXB0bjBha3cr?=
 =?utf-8?B?Z3VQMEJtRXVDYWQ3ZjBldWtLMU9tSDI4UDNJS1dxMFM5MlgwZVdDdEVxUHBG?=
 =?utf-8?B?UE5Xc0tYWStPbHJIcVpudWQxdVVUcVg3VFBVWXl4UXkzOXF3bE1MakJ3TUFI?=
 =?utf-8?B?YW9xOXJBRGg4TnRjWFRLanJqN1hLQWNGZklsa1h1aXJjSnl0ZU1RS3pQeWxL?=
 =?utf-8?B?bGU0QmJncU84YkF3UGdBaHVNZnJUN1U5aTE0WFUra3BpbWxFZWxiTU41RDNT?=
 =?utf-8?B?aGxFYlh4UUNOalJOS1ZCNjRSUC9hVHVzVnF6R3VXQ1VVemJxK3dNa0hwUXFM?=
 =?utf-8?B?QlZRK1dVWkxCY1RheEpiamNTS1MwSUJSSmhXdlFQcjBoamNQdXZjR3BQMFZ4?=
 =?utf-8?B?NncyTTY2ZDlyOUJTT1Y2RVpxaHNtc1dNaEVuQjJObnZoemhUUXZJYUszWHBs?=
 =?utf-8?B?SzJuNmVnR3ZqUkZOWFRtcUcrS1JwNDAwV2xDRmlVdDNCcVAzMk1aZnFWMCts?=
 =?utf-8?B?ZmxVYWZhMFpDVEJlcmZuRzUyZlRuVU1LaW1reVJsZ2ErVlRudlJMa0J4Q0NX?=
 =?utf-8?B?VHhBOEZha3M4NG4vSlNPNHgzZ216VG94Ync4OUkxcGJYbnlaeVNGQkYrZVV1?=
 =?utf-8?B?am9aTUtKaCsvb1B0N1BMb2ZZMGtEV1krSzZxcWJmanBHWUZwd290YzNTNzd2?=
 =?utf-8?B?ekZHejc2NFRpNGdTU2kzeit1TVRVeVBVelpXcFY1YkxZZTVLRktPMUUza3dm?=
 =?utf-8?B?eGZsM2p0NW1HSExEVWVxa1gxVk5MMU42d0h6ZjZBc0ZJMlhVRXdqTGRFTUl6?=
 =?utf-8?B?b2xmbW9FQjc1d3ZXTUhjN0hyeXF3VzBaMmpGd1Q5Q1NFZG11djZZL0ZnTkpw?=
 =?utf-8?B?QjcyZ0o1bnJ3blJUVUJyQWg3OTVvaVJPRTY2V1c0bnBUY1hLQTlHY083c3A0?=
 =?utf-8?B?S2c2WEJpbEZMa09rczhURld4MW4wR05XeUczckozRTFXR2gwSE0vWE5GellT?=
 =?utf-8?B?RXc3bWVHa1pYWDJpSHBjY1hLbGl3cDdmQmtFeHFSQmE0REdTSG1kSGR1WTZX?=
 =?utf-8?B?ME1hYnVDU0dEMFFqRmE1ZEVwSUY3d2RmTW9adHR3K1ZnWUs0Ykd3QzFzY3RZ?=
 =?utf-8?B?TnVIY1N2cUo5alpBOXlGZndOV0hjaWNlcm9KOVhJMlA3QU1KK0t5bjlScGpM?=
 =?utf-8?B?am93WTZHdTArcmx5MnRHL3ZxZWJoa2hBWnN2enpaQnMxUEw2ck8rUEpJSGhU?=
 =?utf-8?Q?t5aGUdMln661ecb+sF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28a98b3-ff64-49c5-ee2d-08df07188ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 04:30:13.2877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxI7OumFd/RdQx9nRDSjlKJE0YTv55pzQHU8Ky/wz2HDZjhOdeM11CjludoBvMbU24pR45TLBvqdKpPSqchdlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEF1Z3Vz
dCAyOSwgMjAyNiAzOjE3IEFNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdA
YW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBB
bGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAz
LzEwXSBkcm0vYW1kZ3B1L2dmeDExOiBpbXBsZW1lbnQgY29tcHV0ZSBhbmQgR0ZYDQo+IHVwZGF0
ZV9tcWQNCj4NCj4gT24gRnJpLCBBdWcgMjgsIDIwMjYgYXQgMTI6MjXigK9BTSBKZXNzZSBaaGFu
ZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbXBsZW1lbnQgdGhlIHVw
ZGF0ZV9tcWQgY2FsbGJhY2sgZm9yIGdmeDExIGNvbXB1dGUgYW5kIEdGWCB1c2VyIHF1ZXVlcy4N
Cj4gPiBTYXZlIHRoZSByZWFkIHBvaW50ZXIsIHJlLXJ1biBpbml0X21xZCB0byByZWJ1aWxkIHRo
ZSBIUUQsIHRoZW4NCj4gPiByZXN0b3JlIHRoZSBzYXZlZCByZWFkIHBvaW50ZXIgYW5kIGZvcndh
cmQgdGhlIHdyaXRlIHBvaW50ZXIgdG8gdGhlDQo+ID4gdXNlciB3cHRyLCBzbyBhIHJlLWVuYWJs
ZWQgcXVldWUgcmVzdW1lcyBhdCB0aGUgZmlyc3QgdW4tY29uc3VtZWQNCj4gPiBwYWNrZXQgcmF0
aGVyIHRoYW4gcmVwbGF5aW5nIHRoZSByaW5nIGZyb20gMC4NCj4gPg0KPiA+IHYyOiByZWJ1aWxk
IHRoZSBIUUQgdmlhIGluaXRfbXFkIGFuZCBzYXZlL3Jlc3RvcmUgdGhlIHJwdHIsIG1hdGNoaW5n
IHRoZQ0KPiA+ICAgICBTRE1BIHVwZGF0ZV9tcWQgc3R5bGUsIGluc3RlYWQgb2YgcGF0Y2hpbmcg
aW5kaXZpZHVhbCBNUUQgZmllbGRzIGluDQo+ID4gICAgIHBsYWNlLiBLZWVwcyBhbGwgdXBkYXRl
X21xZCBjYWxsYmFja3MgY29uc2lzdGVudC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEplc3Nl
IFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiA+IFN1Z2dlc3RlZC1ieTogQWxleGFuZGVy
IERldWNoZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jIHwgNDQNCj4gPiArKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5j
DQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYw0KPiA+IGluZGV4
IGE0NDc1NjI5NzdhYi4uMWZlYjdjOWVlNWM2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4gPiBAQCAtNDI1Niw2ICs0MjU2LDI2IEBAIHN0YXRpYyBp
bnQgZ2Z4X3YxMV8wX2dmeF9tcWRfaW5pdChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwg
dm9pZCAqbSwNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiArLyoNCj4g
PiArICogR0ZYIHVwZGF0ZV9tcWQ6IGluaXRfbXFkIHJlc2V0cyB0aGUgcmluZyBycHRyL3dwdHIs
IHNvIHJlLXJ1biBpdA0KPiA+ICt0byByZWJ1aWxkDQo+ID4gKyAqIHRoZSBIUUQsIHRoZW4gcmVz
dG9yZSB0aGUgc2F2ZWQgcnB0ciBhbmQgZm9yd2FyZCB0aGUgdXNlciB3cHRyLg0KPiA+ICsgKi8N
Cj4gPiArc3RhdGljIGludCBnZnhfdjExXzBfZ2Z4X21xZF91cGRhdGUoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHZvaWQgKm0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGFtZGdwdV9tcWRfcHJvcCAqcHJvcCwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1NjQgdXNlcl93cHRyKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3Qg
djExX2dmeF9tcWQgKm1xZCA9IG07DQo+ID4gKyAgICAgICB1MzIgc2F2ZWRfcnB0ciA9IG1xZC0+
Y3BfZ2Z4X2hxZF9ycHRyOw0KPiA+ICsNCj4gPiArICAgICAgIGdmeF92MTFfMF9nZnhfbXFkX2lu
aXQoYWRldiwgbXFkLCBwcm9wKTsNCj4gPiArDQo+ID4gKyAgICAgICBtcWQtPmNwX2dmeF9ocWRf
cnB0ciA9IHNhdmVkX3JwdHI7DQo+ID4gKyAgICAgICBtcWQtPmNwX2dmeF9ocWRfd3B0ciA9IGxv
d2VyXzMyX2JpdHModXNlcl93cHRyKTsNCj4gPiArICAgICAgIG1xZC0+Y3BfZ2Z4X2hxZF93cHRy
X2hpID0gdXBwZXJfMzJfYml0cyh1c2VyX3dwdHIpOw0KPg0KPiBUaGlzIHNlZW1zIGZyYWdpbGUu
ICBSYXRoZXIgdGhhbiBkb2luZyBpdCB0aGlzIHdheSwgY2FuIHdlIGp1c3QgdXNlDQo+IG1xZF9p
bml0KCkgYXMgaXMgYW5kIGFkZCBhIG5ldw0KPiBwcm9wLT5tb2RpZnkgZmxhZz8gIFRoZW4gd2Ug
Y2FuIHVzZSB0aGF0IGluIGluaXRfbXFkIHRvIHNraXAgc3RhdGUNCj4gdGhhdCBzaG91bGQgYmUg
cmV0YWluZWQgZnJvbSB0aGUgTVFELg0KDQpNYWtlcyBzZW5zZSwgdGhhbmtzIEFsZXguIEluIHYz
LCAgSSB3aWxsIGRyb3AgdGhlIHBlci1JUCB1cGRhdGVfbXFkDQpjYWxsYmFja3MgYW5kIGFkZCBh
IHByb3AtPm1vZGlmeSBmbGFnIChwbHVzIHByb3AtPnVzZXJfd3B0cikuIGluaXRfbXFkDQpub3cg
a2VlcHMgdGhlIGNvbnRleHQtc2F2ZWQgcnB0ciBhbmQgdXNlcyB1c2VyX3dwdHIgYXMgdGhlIHdw
dHIgLg0KDQpKZXNzZQ0KPg0KPiBBbGV4DQo+DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIDA7
DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgZ2Z4X3YxMV8wX2tncV9pbml0X3F1ZXVl
KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykgIHsNCj4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsgQEAgLTQ0NzcsNiArNDQ5NywyNg0KPiA+IEBAIHN0
YXRpYyBpbnQgZ2Z4X3YxMV8wX2NvbXB1dGVfbXFkX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHZvaWQNCj4gKm0sDQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+
ID4gKy8qDQo+ID4gKyAqIENvbXB1dGUgdXBkYXRlX21xZDogaW5pdF9tcWQgcmVzZXRzIHRoZSBy
aW5nIHJwdHIvd3B0ciwgc28gcmUtcnVuDQo+ID4gK2l0IHRvDQo+ID4gKyAqIHJlYnVpbGQgdGhl
IEhRRCwgdGhlbiByZXN0b3JlIHRoZSBzYXZlZCBycHRyIGFuZCBmb3J3YXJkIHRoZSB1c2VyIHdw
dHIuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgaW50IGdmeF92MTFfMF9jb21wdXRlX21xZF91cGRh
dGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHZvaWQNCj4gKm0sDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfbXFkX3Byb3AgKnBy
b3AsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCB1c2Vy
X3dwdHIpIHsNCj4gPiArICAgICAgIHN0cnVjdCB2MTFfY29tcHV0ZV9tcWQgKm1xZCA9IG07DQo+
ID4gKyAgICAgICB1MzIgc2F2ZWRfcnB0ciA9IG1xZC0+Y3BfaHFkX3BxX3JwdHI7DQo+ID4gKw0K
PiA+ICsgICAgICAgZ2Z4X3YxMV8wX2NvbXB1dGVfbXFkX2luaXQoYWRldiwgbXFkLCBwcm9wKTsN
Cj4gPiArDQo+ID4gKyAgICAgICBtcWQtPmNwX2hxZF9wcV9ycHRyID0gc2F2ZWRfcnB0cjsNCj4g
PiArICAgICAgIG1xZC0+Y3BfaHFkX3BxX3dwdHJfbG8gPSBsb3dlcl8zMl9iaXRzKHVzZXJfd3B0
cik7DQo+ID4gKyAgICAgICBtcWQtPmNwX2hxZF9wcV93cHRyX2hpID0gdXBwZXJfMzJfYml0cyh1
c2VyX3dwdHIpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0K
PiA+ICBzdGF0aWMgaW50IGdmeF92MTFfMF9raXFfaW5pdF9yZWdpc3RlcihzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmcpICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9
IHJpbmctPmFkZXY7IEBAIC03MjcxLDExICs3MzExLDE1DQo+ID4gQEAgc3RhdGljIHZvaWQgZ2Z4
X3YxMV8wX3NldF9tcWRfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAg
ICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QgdjExX2dmeF9tcWQpOw0KPiA+ICAgICAgICAgYWRl
di0+bXFkc1tBTURHUFVfSFdfSVBfR0ZYXS5pbml0X21xZCA9DQo+ID4gICAgICAgICAgICAgICAg
IGdmeF92MTFfMF9nZnhfbXFkX2luaXQ7DQo+ID4gKyAgICAgICBhZGV2LT5tcWRzW0FNREdQVV9I
V19JUF9HRlhdLnVwZGF0ZV9tcWQgPQ0KPiA+ICsgICAgICAgICAgICAgICBnZnhfdjExXzBfZ2Z4
X21xZF91cGRhdGU7DQo+ID4gICAgICAgICAvKiBzZXQgY29tcHV0ZSBlbmcgbXFkICovDQo+ID4g
ICAgICAgICBhZGV2LT5tcWRzW0FNREdQVV9IV19JUF9DT01QVVRFXS5tcWRfc2l6ZSA9DQo+ID4g
ICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QgdjExX2NvbXB1dGVfbXFkKTsNCj4gPiAgICAg
ICAgIGFkZXYtPm1xZHNbQU1ER1BVX0hXX0lQX0NPTVBVVEVdLmluaXRfbXFkID0NCj4gPiAgICAg
ICAgICAgICAgICAgZ2Z4X3YxMV8wX2NvbXB1dGVfbXFkX2luaXQ7DQo+ID4gKyAgICAgICBhZGV2
LT5tcWRzW0FNREdQVV9IV19JUF9DT01QVVRFXS51cGRhdGVfbXFkID0NCj4gPiArICAgICAgICAg
ICAgICAgZ2Z4X3YxMV8wX2NvbXB1dGVfbXFkX3VwZGF0ZTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0
YXRpYyB2b2lkIGdmeF92MTFfMF9zZXRfdXNlcl93Z3BfaW5hY3RpdmVfYml0bWFwX3Blcl9zaChz
dHJ1Y3QNCj4gPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+IC0tDQo+ID4gMi40OS4wDQo+ID4N
Cg==
