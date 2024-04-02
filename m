Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2C2CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 08:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C415A10E6D5;
	Tue,  2 Apr 2024 08:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZC/dYyP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2100.outbound.protection.outlook.com [40.107.243.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3805210E6D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 08:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTNJc78p74A7rOm2p/LiVr+54tfSAHzEhkW4aj49NHPnFx42Xp1U3GFzShD1uLlc+6uAKCoHW7BKIzvpB0FzreJ6On6JLyYLGTSoELk+u5EIxUGX+V9r0NgQtIJkffdbZb9FhzAEGyMlt4OPQ3d9nHQokjpGA6LJgqionOZyutlef3ywLBzyDpekEvoFVz+SxJBp2959qR4GZzWhR2slEOwW96P1poz5tlF7wzwlA8/grHDvJQ+e9PB7mjqgMeNdd61w255w25h1B1AZYBL35u3VMf79/leIWxCGUyAk+ZDImJHA2IswJmMw3LvjSWL13rnpfpMN7PsoFJSgfdusew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sQKRxje2o39UsvQ9BCbi+xWXmNyGpkKO4h9OVl8O3M=;
 b=fTW0EB+V+ggtt1PGl0iUA6X7dwzpO8juD4Sy6luH6oau4CPvghL8S9RWHZwkcszCz/jUCKb0n8pONfv37SF8IUuOHaBIl5WD7Wvpjp3kN01hNvjWSHpLWKVOyEE+4BkKF/F+RNUeEWDP0tBmYjbjU5wFJplsqBWxZugv7L1DEnGGrI75oChNiNVdxBflykzhkejTYkuHiuhd6K7u+IbgeGuDwm9VYvtFNKothj0/MiHXcscOXhUPWERrs69Oh7TIxe2kCD4Ss7nhRSSFmID9GC8b3dQKOACd+oCkLjlcQUJuUJMTg/8Z2VJ9iQbqWxNuuLQbrFYSc0fd2oy6VNsqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sQKRxje2o39UsvQ9BCbi+xWXmNyGpkKO4h9OVl8O3M=;
 b=JZC/dYyP6FHsX+/9HXCPnWM8KPxYOpxorXfd7JiXdwceMWzz+ot8tSTzsGQJljBiJDIR2CHdTrLuqdaHNsXFJW2xeh4V1nI1wY8WFmQacdNWqK8uilv5BHRgIpt6Nzlhdgrpib23ia0eTOkRKtHU2ZWgLovvZ0PXwaQN2qc7Cdc=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 08:47:45 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 08:47:45 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: use CPU to update VM during GPU reset
Thread-Topic: [PATCH 1/2] drm/amdgpu: use CPU to update VM during GPU reset
Thread-Index: AQHafnZaYy9vPlgMtUCqNy+8gjtPO7FOlcwAgAYhECA=
Date: Tue, 2 Apr 2024 08:47:45 +0000
Message-ID: <MW6PR12MB88985692468C5B0EC00BC55FFB3E2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240325053558.3183164-1-Lang.Yu@amd.com>
 <30c0f3a4-6705-4d25-aad6-6c72310b493e@amd.com>
In-Reply-To: <30c0f3a4-6705-4d25-aad6-6c72310b493e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bf8e77bb-2bdf-4a04-9b3e-aa34fe4ff4d3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-02T08:43:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|DM4PR12MB6088:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z0Nw5D/IdIUq4KT1Z+vVULlz0T74BwCX4h9DnGAflcFEza4KtrACizME/8EDLCyD6zDzxzquWtXeCyjLjWoxAxOp8dFaX90v+bVMi/7kEillMBMTGaglk6h3nPX88Cip1L2FIQ+egjtspS9oV4n8d9+wJmZXBSl/zm1njaxUCU7bNeZDaQ/FbsXLQOL2cDtZUFkEc/Hc6EXx67HfBfpf32EeEcW20Ib5PYTJdPWqmXvV0B8o/BFQ/MTSlARFnJsegI3EzAfNNlRxho3+2HBcjx8HGMaYsLHyhYRA/UQ3deq3XsJJCqTtg45rpQkeAcMmp9gIpiGd8jWKkIvtktmniONBawuBoQ35bZlBkPki5t0B9vNiEPqVLKDDdYuq3u9IOoIcuxK+OVV2FKb6KLXonN3rNoVfoJ8Jl10+3Fsi8IR4XYAUTHqAIeWGLofl/qupazgEWYNlU9dJvEXmOmgHLnEX3P2MvBtlrpq0c3aUxSP0cjrCtzZ7g6Gba3IXEDN3zrj2Cw59RpQTBChve5Y2Vshir++AUbPLXj6yD+SRmEsoxI12BlCn+vizm5hMeYishInrp7Pg2+VFF4T5oREEQK6YrDseAyE91PB4SCdhRoD8cRcnjJ1Q3c0goysztrSXcydPvFfqyb87zYVMORjcvTxwhvzxuXRL5ZkXIF+2KsE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clBFMFpuQkdxMnlPU2J1djU3Sm1FN3gzdm1tdzRwb00yU0xWbmlWdGFmRzZ5?=
 =?utf-8?B?NnY4SDlCSlVzRithY2NtNVMyNGRvOXJia2JvZG9JOGRTZ3p5bmVaS0piemVh?=
 =?utf-8?B?QU4zcm9XSE8yeVhrZ2ZkL0RwalZ5V3llcjRYeTBCZmx2TUU5RGRIYW41dnJw?=
 =?utf-8?B?L24yaGdYSlRKUVRJbEExNU4rV0ZsSmFGYUE3b1k2Zk1FYktlaUhqTW9jVCsx?=
 =?utf-8?B?QUt3bGRkSjlubklwTkdjNUcrcGpFSU04RlpKRG1aSnVoWmdjV1d1bnlZemRZ?=
 =?utf-8?B?VFdER3pYMFBlMW9SelR2K004WGpha0ZhVTNGVmhDQUMxdHEvY2dzd0M2Wjcx?=
 =?utf-8?B?RFhFNHZuQTF4K3cyVjRqZVMxckM3M3hGWGlibkIxV3I4Z0c5TWJLM24zN0po?=
 =?utf-8?B?RTFMQzd2RE1RK2RkUFZqSEx5TXZ3NFdBUEF2RElKbFlKZ2VrTWJETUkrV3h2?=
 =?utf-8?B?enhCcTQyUkZ2VDg4dlI1U0dvK3I0eU1rSFhlWktRc1pHZEtPZXZPcHMxTklx?=
 =?utf-8?B?eVFtcU1XT040eG42eGZFSjdTdFp4WUZ5dExwdU1XV2RnSy9rMWVKcXhiLytD?=
 =?utf-8?B?aUtTRFlDVUZCbndlTUN1WUo3VFpCcEhhR2xxTERTS05PVFNRUDJBaVk1ZU54?=
 =?utf-8?B?TVgxUWFTVjEyWUxnM0pLai8zam9uM2RMZHBqNkxXSjFJM0tvR3g0TXBzc0lp?=
 =?utf-8?B?N2k0cmJFTENaRStwYXNYUVZESkJJdWRVTEVGdzQ0QjYzcDZLSHRQVXcySEd3?=
 =?utf-8?B?ZnY2YXlVbzA4L2t0dm5xMDhuL3JaWlA2cTlVZkttVFVYUFgvUVc5NDRQbWJP?=
 =?utf-8?B?RUkzMUNmSkJST3h6czl1WG44d0pXUUJxUW1xVnQ2N1MwaFdYNnozWEU2ME1C?=
 =?utf-8?B?VUtZQmdjZk5kZlF5WGxnRnEyd0kxUE8xTWY4UHBKaUY4SEFqcjZFTXp3cUs2?=
 =?utf-8?B?ZUpROTMwRXJlTU9sZUx0TFlpNFVPSWx2aTd4ZTBreDAxY0NNcGdHcnlDQnkr?=
 =?utf-8?B?ZXBCTmJINldtVy9Tc1l1ZS91QXFhRkNOWW5sNzlTUm9FcWEwaEFLdFFFeHRZ?=
 =?utf-8?B?eFhKZ0dHZHZXYWVFcFRBREFGZ0ExRmNhb05BWE5STi9kaDZ0UTNvNitmaEc2?=
 =?utf-8?B?SENxajRzOGpJYU9Ceko2QjVyVVdsMnFwU29GcTlKc0t0ZTNWNElPUjRhSS83?=
 =?utf-8?B?M2dlQmJwY2R5SnQ2LzhnNlpKT1RKc0hKcjR1L1gyaUJPNDJLUEJCMWZyTW1t?=
 =?utf-8?B?MTZzVTFpRWVVMXFXTDBlOGdNQUpVK21qaUZ0TSt4a3VPMWFOODY5YkxFbGRG?=
 =?utf-8?B?b29BbEp5WXJsTE9XenA4NVFVU1FoUjhycGY2dHFrS3lXbVVHdHp6RmdqR1Ir?=
 =?utf-8?B?Q1ZUQmVmRW5SSjh0V2laM3BEV1NnTDVOSkV1ZTduaEtTeEJtcUNudkRiSUY2?=
 =?utf-8?B?cFVnOWlxNXp5SlRIa1ZIaDV1OWxYcUxob1NLMW96aC9LNVoyWkVSNmVTYVhG?=
 =?utf-8?B?c3pEVUpIVVRPNkZVc2lvVGVGbFl1bnJOdDQxc3R0S25FZ2lxYkF4bHcwSVI4?=
 =?utf-8?B?alBXZEoyekxJWEFSbS9wOEVlZmlNVkNvb3ZFU3hrejArNExjWmlxejZuckxt?=
 =?utf-8?B?cjE4U2UyeFhxKzRwY2YwYzd2dDZSZzBicUgxQzdZZEZ4UXBhZHZ6VjZ6NXdY?=
 =?utf-8?B?SFVUZjBpVlV2U1VxZ25HakRoTkg0cjNWZUFLN0Y0NWFybVRXMU13TWQyR0g0?=
 =?utf-8?B?T1JRREZVTDNFMDRMV05aRHZCV3JicnFvQjc3K0h2NVUveHNWQ08zSVNuY2Yr?=
 =?utf-8?B?TmpleEtsZ3p0UUlyMWxBcnRqRkVVUnZKZTFHdFZBNmhhR3IwLzM5VTFidDBj?=
 =?utf-8?B?a29LOWk2S1pTNnFjS0Z5N0tkbThaZkpvRXVZVEgvcUJzRnorWU9sWlNaVVo1?=
 =?utf-8?B?Wnp3NHZsVExjR1E1ZXVoSkNLTUxiRW9jeWcvdmNzd3V2dXRDS3M2eURVbU5H?=
 =?utf-8?B?aHk3UE1Wa1lrTUxYYU15L2JEU25iMWFQZ2UxV3pyU3lXZjd0MWErT1VEazBn?=
 =?utf-8?B?ZFNBTGtYWE10OUMxWnJiQWRJZTFaSnFWSS92b1FkdWpnRldzaENmemhtTmwy?=
 =?utf-8?Q?3NXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d84ef5e-bbf1-48e9-f632-08dc52f19138
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 08:47:45.6243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNIrz9JqOInigKILE9GyR0B3ZwG3oMvXxBlK/InRJGt9JlzERfOS3PH9m9vxIOfeyw6VWtUSxR1k1qIlThqXmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+DQo+U2VudDogRnJpZGF5LCBNYXJjaCAyOSwgMjAyNCA3OjA4IFBNDQo+VG86IFl1LCBMYW5n
IDxMYW5nLll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPkNjOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+U3ViamVjdDog
UmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IHVzZSBDUFUgdG8gdXBkYXRlIFZNIGR1cmluZyBH
UFUNCj5yZXNldA0KPg0KPkFtIDI1LjAzLjI0IHVtIDA2OjM1IHNjaHJpZWIgTGFuZyBZdToNCj4+
IGRybSBzY2hlZCBpcyBzdG9wcGVkIGFuZCBTRE1BIG1vZGUgaXMgbm90IGF2YWlsYWJsZSwgd2hp
bGUgQ1BVIG1vZGUNCj4+IHdvcmtlZCB3ZWxsIGluIHN1Y2ggYSBjYXNlLg0KPj4NCj4+IFVzZSBj
YXNlLA0KPj4gYW1kZ3B1X2RvX2FzaWNfcmVzZXQNCj4+IGFtZGdwdV9kZXZpY2VfaXBfbGF0ZV9p
bml0DQo+PiB1bXNjaF9tbV9sYXRlX2luaXQNCj4+IHVtc2NoX21tX3Rlc3QNCj4+IGFtZGdwdV92
bV9pbml0DQo+DQo+V2VsbCBiaWcgTkFLIHRvIHRoYXQuDQo+DQo+VGhlIFZNIHVwZGF0ZXMgc2hv
dWxkIGp1c3QgYmUgc2NoZWR1bGVkIGFuZCBhcHBsaWVkIGFzIHNvb24gYXMgdGhlIEdQVQ0KPnJl
c2V0IGlzIGNvbXBsZXRlZC4NCj4NCj5UaGUgcHJvYmxlbSBpcyByYXRoZXIgdGhhdCBhIEdQVSBy
ZXNldCBzaG91bGQgKm5ldmVyKiBjcmVhdGUgYSBWTSB0byBkbyBhDQo+dGVzdC4gRHVyaW5nIEdQ
VSByZXNldCBubyBtZW1vcnkgYWxsb2NhdGlvbiB3aGF0c29ldmVyIGlzIGFsbG93ZWQuDQoNCkJ1
dCB1c2VyIHNwYWNlIGNhbiBzdGlsbCBjcmVhdGUgYSBWTSB2aWEgb3BlbigiL2Rldi9kcmkvY2Fy
ZDAiLCAuLi4pIGR1cmluZyBHUFUgcmVzZXQsDQpkcml2ZXIgZG9lc24ndCBwcmV2ZW50IHVzZXIg
c3BhY2UgZnJvbSBkb2luZyB0aGF0LiBTbyBpcyB0aGlzIHJlYXNvbmFibGU/IFRoYW5rcy4NCg0K
UmVnYXJkcywNCkxhbmcNCg0KPlRoYXQncyB3aHkgd2Ugb25seSBkbyBJQiBhbmQgcmluZyB0ZXN0
cyB3aXRoIGEgcHJlLWFsbG9jYXRlZCBtZW1vcnkgcG9vbA0KPmR1cmluZyBhIEdQVSByZXNldC4N
Cj4NCj5JZiB0aGUgdW1zY2hfbW1fdGVzdCBhYnVzZXMgdGhlIFZNIHRlc3RzIGxpa2UgdGhpcyB0
aGVuIHBsZWFzZSByZW1vdmUgdGhhdA0KPmNvZGUgaW1tZWRpYXRlbHkuDQo+DQo+UmVnYXJkcywN
Cj5DaHJpc3RpYW4uDQo+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8TGFuZy5ZdUBh
bWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIHwgNCArKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
DQo+PiBpbmRleCA4YWYzZjBmZDMwNzMuLmFmNTNmOWNmY2M0MCAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPj4gQEAgLTI0MDQsOCArMjQwNCw4IEBAIGlu
dCBhbWRncHVfdm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiphZGV2LA0KPj4gc3RydWN0
IGFtZGdwdV92bSAqdm0sDQo+Pg0KPj4gICAgICB2bS0+aXNfY29tcHV0ZV9jb250ZXh0ID0gZmFs
c2U7DQo+Pg0KPj4gLSAgICB2bS0+dXNlX2NwdV9mb3JfdXBkYXRlID0gISEoYWRldi0+dm1fbWFu
YWdlci52bV91cGRhdGVfbW9kZQ0KPiYNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEFNREdQVV9WTV9VU0VfQ1BVX0ZPUl9HRlgpOw0KPj4gKyAgICB2bS0+dXNlX2NwdV9mb3Jf
dXBkYXRlID0gISEoYW1kZ3B1X2luX3Jlc2V0KGFkZXYpIHx8DQo+PiArICAgICAgICAgICAgYWRl
di0+dm1fbWFuYWdlci52bV91cGRhdGVfbW9kZSAmDQo+QU1ER1BVX1ZNX1VTRV9DUFVfRk9SX0dG
WCk7DQo+Pg0KPj4gICAgICBEUk1fREVCVUdfRFJJVkVSKCJWTSB1cGRhdGUgbW9kZSBpcyAlc1xu
IiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICB2bS0+dXNlX2NwdV9mb3JfdXBkYXRlID8gIkNQ
VSIgOiAiU0RNQSIpOw0KDQo=
