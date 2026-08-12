Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E4BC5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 15:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CBD310F06B;
	Wed, 12 Aug 2026 15:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kQOaITCq";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7C710F06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 15:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVL5aH4z0/07XfEib/0iv/S7kauU0/+qbPd/ArwKffGJCWZoHM8qhvD6sVURREbyicOL6lcl5AcLCggtoyBQgPq6KmxOY8e/vVuvS1pjV5CUGfQhnSvfY704dyAqq9nudox150Nj07zhggJrlVm98LKXHjdvjf4x8BGP1Vd1EhRgOhzTsvYwCOrr6vIfse+UGc785oS2t7avbJZEwfypmuhjyyy+DybyRnIfiEOE67L5VPvAeakkDgOCoy3EpT4Pzlucct5h4WhZERlUM4gNm81ELdk7XWGJAh3XFmGT7x66TK9QQ5ANFB5LIqaq/aWIWGCPhtDy3Y9e8L7nplHWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3atLOZ6gU8XTE0mJQ+Fz8iZXvPZsd7JOA1qE8eky4E=;
 b=XD570pvcw1yXGdAs6aDHW1iLFjIfzFs+VluHySqhNIsNzOKJwmFbe4BHBvYAxiwTc+NTIUQQnMNZMf9LbDDo5bzbH62rI04DXIiPLvMxbDUV8SljbtcFXDJsnWK5/PSsgMp1sZGiaUM/zTTMBW5PjUReWqI3vFcjgjTGMrN6DMIimxewCDCR6BsEoKDWnbttuOzHKrxwAaBhOqZxE2/2ZslstP4L7s2xls/lJKZMuzDiYwwEQgDFcpI83OlVyxzPQxvC3yflcEwxcyewldVxjv4UG0tP/0QXVgxjm+Ys43Sy2WP34mImXiu5ZRWIpvMRPooSRLOK7B1zN8HSZ9BkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3atLOZ6gU8XTE0mJQ+Fz8iZXvPZsd7JOA1qE8eky4E=;
 b=kQOaITCqlez5lUCsgXMs8Wwyt3z+WNHVv7b6b0tewFi0TPDFkPE5N25aEhqg7yY4btfQDZoatRw+2xxc4DjhvnpqoAgyP02hcI8cJR3/ngEiEJPJ16gbewVpqqibDdOjZMPIKgW1nsQnMPJ2kx3GOeBjt17xoeyRpoBI11Xx3pc=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 15:23:38 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 15:23:37 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable runtime PM for externally attached
 dGPUs
Thread-Topic: [PATCH] drm/amdgpu: Disable runtime PM for externally attached
 dGPUs
Thread-Index: AQHdKjHciOZ9yMnogUy8ilXnQF759LaaedSAgAALCHA=
Date: Wed, 12 Aug 2026 15:23:37 +0000
Message-ID: <BN9PR12MB5211F6BCD471FEB271B1726382DC2@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260812080841.2936007-1-kevinyang.wang@amd.com>
 <CADnq5_NDBUquX6CgaLEZ3YZMpkUHn757J=FQYTJO-Ld8KW-pqw@mail.gmail.com>
In-Reply-To: <CADnq5_NDBUquX6CgaLEZ3YZMpkUHn757J=FQYTJO-Ld8KW-pqw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-12T15:09:52.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|IA1PR12MB6068:EE_
x-ms-office365-filtering-correlation-id: cff25426-ba96-4f5a-c0a6-08def885aeb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: JUt6Kn1nxNQUdRMfowEOrxwGhxGSgTXEHf0Q8ND/vjsf06/Y4Uxk+1oQN7C03rMIMbfRudoHiC//hJjBDP1EBexbp5/QtvAMSvQ5MYvSIOWeNDfCZLid382HcKQ1b2uDSkE2nja4ZYSdih92bg/FaKkeTcfDk+hcofw7RPGtQZHZ+ECDJslVLrX0P/lNqq5t0KvyQyvtGolA+VP20CXJ8EjJGmrq17m/29pqEKWQuSwalD0HJPgALlXHf3PR3rlxpgoBqWOgUxVmJBusXLnp3IhvxMT/2MDd858gZXz8sJwQuQTHhqkGrUFs6AHp3BxpeEJdc5yZ04DrAR/1fkv3wo98trZLfdxVQnsGm3euoyhaU1pvtZLf7Ya63JMwcGbP8epAc0mveF3/kvhoumbimE8N6ZTuyOXzhjlRV2d1o94h03MzAyQAUhNJwpyq+ImEOlRIW3U1LqGXiDCgH98vBFYiTNV/jqAx11xmULZwgoLdVGCUqGQbXZgGNbZt+RReM1UCZay9Xf/fX4tKEfozSF6fFmejq7idjZxxM7v3xTPmKiSWavzQE25cggNCB/zaET5CdAXp6WLABYu5WIQeZmu2lytbGgleaOMKLvAo20i6xpZ8W8Gs6SMkaGMcU9bdXDzuF7jIFU+d8urJdaVzmMfcVd9MZIjzcasYr0cpuh4pWW1rpVyCZ0grWLG4o0jqy/CdW2+s6FfAeDPk0RbifCqq30BnEJyHKlLrJt2GWvk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFByenV5dENZT0NYWUxWdWZ5eE5BVDhkb1U2UEp5cEJ3WGJZWEp0YitGdERX?=
 =?utf-8?B?L29wWHYzZkdodVVqRGprL1haclpmeHZld1ZJQk15WUVkK1JMQ2VOMHlZMDhq?=
 =?utf-8?B?YTNuay9QbXpwaGdLZGNXL2hNV0dDejE4bUlCTEtxaklaZXdBYU9RdC8zZEtv?=
 =?utf-8?B?b0IxbnRVRkY5NkppWjRmL0VFcnZmeFpxdk9tRWtaVEdKb0F2UVp3ZjBXY3k0?=
 =?utf-8?B?aTFIVFY0VjhpdzllTDR0Rmp4OTZBeDZrV05KN3o2WUYyRkx3dkRQbzFicUNM?=
 =?utf-8?B?SFdmVmlKL2ErRjd3MEJLY0dMSFRnTiszcng3UlI5ZlZuRCtKMFcyZXZRZHp3?=
 =?utf-8?B?VDVjOXVwRkJTKzd5bmFvYjhOZEkwNnhFczV3QVVoWDZtcE1oblplNU5qcUQw?=
 =?utf-8?B?cnpuRy81ODRoa0VoYThhbWJLQ1hXQTNicnJaaEZ4RVpmVWx1NlNUSUN6MXdW?=
 =?utf-8?B?MGYvRzYxcDJNSUhyWS9rZW5aY2ZzdWJlRzJIbzNLV3UrTnFZZDdnc0pjQys3?=
 =?utf-8?B?aFNHVW9uSHNxU21LcVdienppYU10Y2hGYlNOL2x1YVZsUUJydWU5VDM1OERw?=
 =?utf-8?B?VWtHWmdhT1JwK0R0ZTR5NHJWalR3WUpudTl5MjRhVDJ5bW1qT2M4Z1RBM1BB?=
 =?utf-8?B?UWJyZjJIdFcrZlhoZm84dkl6bGhkdndWZkR4ZldncU9XYVNTbXdQRTdIRWxE?=
 =?utf-8?B?bVZ4SUprTjNjQXFNK0ZZWTZMcDdzTU5jUk81QWdaTUhZd1IwNGdVT0tEUmlQ?=
 =?utf-8?B?TE85VmxFV3plbGQxUFF3UGVoSjZqMHkrNFRwWWNKREREUFpCK0VFTGJjYkEr?=
 =?utf-8?B?SDRGMXVya1grUEdUdlpmSGVGSlJTUVc4RHFYTFlFaGZyMjNrV3dIV0JXR25o?=
 =?utf-8?B?RXV2cGlVa0IyZER5aE40b2NLcVVQUkdWT0lLT0NUZk1WdEsrWElieDJTdkhu?=
 =?utf-8?B?K2l5QXVKbUNOZ0wybDJnZjhQeU91SXhqYm1NNlVmZ0VJWFlDODFIUVFqanBp?=
 =?utf-8?B?bjJqV29ITXRJUmFZVW9QU1RvejZqbDZ4ZDhVUkoxTC9DalF1UWFBSDZRelFS?=
 =?utf-8?B?SFNQUkR2ZlJ3TWpKd1pWVk91dFZ3L2xqdHVUeE1zNXdjb1k4VGZ1UTF1aUF4?=
 =?utf-8?B?QUhGZklIU3FRam8vc2JJZnNFVUkyOHdXL29oQ1JjMFF0SE9iZy9RRGF3dEhz?=
 =?utf-8?B?eXhKV0VqeG9IL1AyUzY2RS9SR3ExU095enNra084RFhiTXNwU2kzbTdCVTR0?=
 =?utf-8?B?bmpGc0ZhRUFGN0dqbG9uakxPRDVFVTJvUENLZVBwYnpFN09ZZjh2U2w3b0lD?=
 =?utf-8?B?VWllNG9pbUNMaFJSVFYzQU9MVzJzZDJ3L2NQcklSYnBJOHZ0dHhNbGExVUd1?=
 =?utf-8?B?LzI5Rjl0anYwMkZ3dG50NVdnSlEwQlNzOXJzTFN3c2YyNFZYY2Q0UGMzVFFu?=
 =?utf-8?B?Qkg0MlJhSC9rOG1uYkVNSmxpRTdNaktWbm53WW00dm9TcWl1NTllSVUyZDY2?=
 =?utf-8?B?SHE1NVdLVmQxM3MrWm5VV1lLVWhrRGNQeVE2SFFQWnFzdzBNMGtCL1Z1TFJY?=
 =?utf-8?B?T3R5Z0k4Z1VlK011T0t5K3dYeGN1R1dLalpTUTBDdXY5eDZqejZFV1JLL0R1?=
 =?utf-8?B?ZDhEMlFIeFhaUUxVQnpnNVpOUXlrbzdOeFA3TUJYWmJHZXpoRXR3b3RNeDI3?=
 =?utf-8?B?WXJXRDl6OVNONitXMGllSlNtODBoMy85SnVqTDlORk83UEdOQytoSGljQVJC?=
 =?utf-8?B?S1JYZFl5V290U1VnL0ZXRHp5a2xUWTMzMGpZaWsvUjJFeFVzSThNUmlOeTRM?=
 =?utf-8?B?STAxcWFIemNkLzQyZjYxc3k3amVVR0NBRnB5R1MxSVpSRU1nUSswWTRlQnM4?=
 =?utf-8?B?bWNxNzZBVXhkbDk4YTFjNVROM0FpbExKcWZsNEc0M2ZCVUVUTDVZNXZKYjU1?=
 =?utf-8?B?aUUrS3BCbEhRZG12R3cvQjZPVG03U3NqWDNZY1hGbWdBenB1bi9OTjhiTE1k?=
 =?utf-8?B?UWM4V0x3TVZSUjFXYWNaZ1hFbXM4WURYYlA2YlFPTXYzRHJRSmpYbnNGTDRB?=
 =?utf-8?B?WnRlNTlFQjcrVWtjTnBVSnc1VStTTE5kcjZ5NVRsalIwTEN3R1hJWHgwSFNM?=
 =?utf-8?B?dzJIZ1ZUS1lNaGdLMlVCWkNubmhXR0lhWnl1K0k2cFA5WFFWYmtqMHNGR1hJ?=
 =?utf-8?B?VU9zbVZDTWkwd2lBMWdETnJEQ0pSOEhYV3hQZEg1dXNObS9OK3p6UHJNQUdS?=
 =?utf-8?B?KzFMTlF2UWRsQkpHdU1nYkpTK0pJSFhrVjNPaFM2dXQwYkJGc3h0aDdzVU1n?=
 =?utf-8?Q?XawzRZicig1aQ6QAT6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff25426-ba96-4f5a-c0a6-08def885aeb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 15:23:37.8221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FH4ptddKLCKwX9gdvIt0rsXmDBRQuybr2LmfvXR42ruj5yzUXtlCC77H+fA5rSF/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068
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
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1
c3QgMTIsIDIwMjYgMTA6MzAgUE0NCj4gVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcu
V2FuZ0BhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNo
ZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdr
aW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZl
bmdAYW1kLmNvbT47IExpLA0KPiBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IERpc2FibGUgcnVudGltZSBQTSBmb3IgZXh0ZXJu
YWxseQ0KPiBhdHRhY2hlZCBkR1BVcw0KPg0KPiBPbiBXZWQsIEF1ZyAxMiwgMjAyNiBhdCA0OjQ1
4oCvQU0gWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IHBjaV9pc190aHVuZGVyYm9sdF9hdHRhY2hlZCgpIHJlcXVpcmVzIGFuIHVwc3RyZWFtIFBD
SSBicmlkZ2Ugd2l0aA0KPiA+IGlzX3RodW5kZXJib2x0IHNldCBmcm9tIGFuIEludGVsIFRodW5k
ZXJib2x0IFZTRUMuIFRoaXMgZG9lcyBub3QgY292ZXINCj4gPiB0aGUgYWZmZWN0ZWQgQVNNNDI0
MiBVU0I0IFBDSSBoaWVyYXJjaHk6DQo+ID4NCj4gPiAgIDAwOjAyLjINCj4gPiAgICAgXC0gMGY6
MDAuMCBbMWIyMToyNDIxXQ0KPiA+ICAgICAgICArLSAxMDowMS4wIFsxYjIxOjI0MjNdIC0+IDQ1
OjAwLjAgLT4gNDY6MDAuMA0KPiA+ICAgICAgICB8ICAtPiA0NzowMC4wIC0+IDQ4OjAwLjAgLT4g
NDk6MDAuMCBbMTAwMjo3NTkwXQ0KPiA+ICAgICAgICBcLSAxMDowMy4wIC0+IDc2OjAwLjAgWzFi
MjE6MjQyNV0gVVNCNCBIb3N0IFJvdXRlcg0KPiA+DQo+ID4gVGhlIGhvc3Qgcm91dGVyIGlzIG91
dHNpZGUgdGhlIEdQVSB1cHN0cmVhbSBicmlkZ2UgY2hhaW4sIGxlYXZpbmcgbm8NCj4gPiBhbmNl
c3RvciB3aXRoIGlzX3RodW5kZXJib2x0IHNldC4gUENJIGNvcmUgcHJvcGFnYXRlcyBERVZJQ0Vf
UkVNT1ZBQkxFDQo+ID4gYmVsb3cgdGhlIGV4dGVybmFsLWZhY2luZyBQQ0llIHR1bm5lbC4gRGlz
YWJsZSBSdW50aW1lIFBNIHdoZW4gZWl0aGVyDQo+ID4gcGNpX2lzX3RodW5kZXJib2x0X2F0dGFj
aGVkKCkgb3IgZGV2X2lzX3JlbW92YWJsZSgpIGlzIHRydWUuDQo+ID4NCj4NCj4gSSBjb3VsZCBz
ZWUgQk9DTyBiZWluZyBhbiBpc3N1ZSwgYnV0IHNob3VsZG4ndCBCQUNPIHdvcms/ICBUaGF0IHNo
b3VsZCBiZQ0KPiBzZWxmIGNvbnRhaW5lZCB0byB0aGUgZHJpdmVyLg0KDQpXZSByZXByb2R1Y2Vk
IHRoZSBmYWlsdXJlIG9uIHRoZSBhZmZlY3RlZCBBU000MjQyIFVTQjQgZUdQVSB0b3BvbG9neS4N
CkJlZm9yZSBhcHBseWluZyB0aGUgd29ya2Fyb3VuZCwgdGhlIGRyaXZlciBzZWxlY3RlZCBCQUNP
Og0KDQphbWRncHUgMDAwMDo0OTowMC4wOiBVc2luZyBCQUNPIGZvciBydW50aW1lIHBtDQphbWRn
cHUgMDAwMDo0OTowMC4wOiBGYWlsZWQgdG8gZXhpdCBCQUNPIHN0YXRlIQ0KDQpUaGUgZmFpbHVy
ZSB0aGVyZWZvcmUgb2NjdXJzIGluIHRoZSBCQUNPIHJ1bnRpbWXigJFyZXN1bWUgcGF0aCwgbm90
IGluIGEgdmFsaWRhdGVkIEJPQ08gb3IgX1BSMyBwYXRoLg0KDQpXZSBkbyBub3QgaGF2ZSBhbiBh
Y3R1YWwgdGVzdCBjYXNlIHRvIHZlcmlmeSB0aGUgQk9DTyBjYXNlLCBidXQgaXQgc2hvdWxkIGJl
IGRpc2FibGVkIHRvZ2V0aGVyIGZvciBzYWZldHkuDQpOb3RlIHRoYXQgdGhlIGZpbmFsIHRhcmdl
dCBzdGF0ZSBmb3IgQk9DTyBpcyBEM2NvbGQsIHdoaWxlIEQzaG90IGlzIGFuIGludGVybWVkaWF0
ZSBzdGF0ZS4NCkl0IGNvdWxkIGFsc28gYmUgcHJvYmxlbWF0aWMgaWYgdGhlIGRldmljZSBjYW5u
b3QgZnVsbHkgdHJhbnNpdGlvbiBpbnRvIEQzY29sZCwgKHRob3VnaCB0aGlzIGlzIG9ubHkgbXkg
Z3Vlc3MgYW5kIG5vdCB5ZXQgY29uZmlybWVkKQ0KDQpTbywgc2hvdWxkIHdlIGtlZXAgcHVyc3Vp
bmcgdGhpcyBpc3N1ZSwgb3IgbGltaXQgb3VyIHdvcmthcm91bmQgc2NvcGUgdG8gQkFNWENPIG9u
bHk/DQoNCkJlc3QgUmVnYXJkcywNCktldmluDQoNCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCj4N
Cj4gQWxleA0KPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdA
YW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIHwgNyArKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPiA+IGluZGV4IDhlYmUyNGQ1OWFiNi4uYTRiNGY5NjQ1Yzg0IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IEBAIC02MDks
NiArNjA5LDEzIEBAIHZvaWQNCj4gYW1kZ3B1X2RldmljZV9kZXRlY3RfcnVudGltZV9wbV9tb2Rl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgICAgICAgaW50IGJhbWFjb19zdXBw
b3J0Ow0KPiA+DQo+ID4gICAgICAgICBhZGV2LT5wbS5ycG1fbW9kZSA9IEFNREdQVV9SVU5QTV9O
T05FOw0KPiA+ICsgICAgICAgaWYgKHBjaV9pc190aHVuZGVyYm9sdF9hdHRhY2hlZChhZGV2LT5w
ZGV2KSB8fA0KPiA+ICsgICAgICAgICAgIGRldl9pc19yZW1vdmFibGUoJmFkZXYtPnBkZXYtPmRl
dikpIHsNCj4gPiArICAgICAgICAgICAgICAgZGV2X2luZm8oYWRldi0+ZGV2LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAiUnVudGltZSBQTSBkaXNhYmxlZCBmb3IgZXh0ZXJuYWxseSBh
dHRhY2hlZCBkZXZpY2VcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gKyAg
ICAgICB9DQo+ID4gKw0KPiA+ICAgICAgICAgYmFtYWNvX3N1cHBvcnQgPSBhbWRncHVfZGV2aWNl
X3N1cHBvcnRzX2JhY28oYWRldik7DQo+ID4NCj4gPiAgICAgICAgIHN3aXRjaCAoYW1kZ3B1X3J1
bnRpbWVfcG0pIHsNCj4gPiAtLQ0KPiA+IDIuNTQuMA0KPiA+DQo=
