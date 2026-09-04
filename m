Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C9BC624DB
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 03:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB83C10F83B;
	Fri,  4 Sep 2026 03:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YwYVCxpT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E50410E07F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 03:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwDJTqMF4wRkUb6JFd5IgMsiDM7YW17uFydNlCowQn8FZukwDp2nqH/fbWONi67UFCt/9dSVuXz3AEvBFRVDDGRoaasZIlsG3WIq+GHNO1tNFgsT2CSWL4DKJDRNJJiXXCXdEa73XWebHcvWab2SP0ZZKzo76tNiCzz99uPkPt/05orQak3RizjO/0hF7K/7k1sblXAmRvvLupAQ0O0J/zbhiPjlw8Wkj+8deZpcRpE4TI2Gmfd7qdpdmBf21hm1iFUN00q+lx0/wiSnRGD3UaUYXGKUUxycGa1eqcDrlTbqWoQqIkElPlwa+yXT0oSBWQQnel/s2J9rocHvgO4SCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHUKYtgpzpy4Q7lalMtGiRqob8gDWX2DtMnVqaGvSWE=;
 b=C6ZFGTDvoR63ubnkCDoxPOu9lLh8YB9Ehljr8RVWQTdKiKM8hLfn3qpCzzpParONvGJTd5N1q3t5gYjySSGtSbV6aRmzPX3dVVZKVtiKHQiZ6p3SdCRr3UGf+ZPT96glI0UL8ir2OA9wZeznAKGhoi6BmqUr8kzYGh5XMa8Q0jlBgH8oOJOp4AG9fiRFdqDYVuzAYOaD5p+GwZa5AIZm8oPrPcyiZ1XveuVur3wI6FbCSMn85fXJ7kB4JRhe93hXMUhYwbuKOHstxnPRxUJ1Hel+cvqqzdKyN27OS86SdACIOBDioOvzbBzNylxj8BV7wztp0+sEdVqEchbnpesabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHUKYtgpzpy4Q7lalMtGiRqob8gDWX2DtMnVqaGvSWE=;
 b=YwYVCxpTvLW3v3C8UiEd+0HFp96zs6OGy4gkQTVnIR4BR413/dDtuCyKFzbufzf9b40R51gfEAN7BQjRLTKsdM7hnJ+K/3mjoJRLLRu5TWomYoX+p7BcZdBzByHGn8rh4P23YkQOaIHvEUeMf+rbSWo6iz6Kq6s6l1xNsMT14lA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Fri, 4 Sep
 2026 03:16:00 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 03:15:58 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH V3 08/10] drm/amdgpu/mes_userqueue: route compute MODIFY
 through init_mqd
Thread-Topic: [PATCH V3 08/10] drm/amdgpu/mes_userqueue: route compute MODIFY
 through init_mqd
Thread-Index: AQHdOQklFA1+oWkKb0GKs8JZggTyKLa9KmOAgACZCjA=
Date: Fri, 4 Sep 2026 03:15:58 +0000
Message-ID: <DM4PR12MB5152CA9CDD2D00CAF6BBF77AE3B52@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
 <20260831052513.1518180-8-Jesse.Zhang@amd.com>
 <CADnq5_PC9fRaLvF8ydvM-2HsHo1ue3LimCXK7bQBynLvDZk5TA@mail.gmail.com>
In-Reply-To: <CADnq5_PC9fRaLvF8ydvM-2HsHo1ue3LimCXK7bQBynLvDZk5TA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-04T03:09:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA1PR12MB8120:EE_
x-ms-office365-filtering-correlation-id: d75820fd-8237-4041-5031-08df0a32d73a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: /a2m9N/1vw9ebsULJ5DNfWlt8hNGtOACQlO3QYmcoNDL+oB8tG56ANu1ySTyHrLSYvn9NkqfPbGAV/b/ch7yKJstJNCWllPOAHSq33Yb+uBLoPsfEGylsgbYcGAYBL9J7+rlQELUtOwYxo/U0Yt0ztyYg2pD3MQxPe6OqTb84tBqmpoOrSCNABBCTGbGrTAqP+XJKoU0FDQokS3v0z5MCShZ82l9CfWO25ZBnxvmURn3Z4T2F9qy/IILd+JEVnW+D4QHHW+dvPs0a+Yg+wJnvYzvvT0X/Pu/KE8n0AXcZuC9dqIL9kz9wQaN7jJb/Zf8mxAL3mlAKsKykklJ9dj+kiBo2hf5G8JZsTvpBxdE9FSj+TBV4eCBybGZzle0udwd3GAEigPae1O9ldzDfqS+wNHpzbIlPdIWRO50wd25SBG+Vkga2RUan5udvmu+7gQ5hUPgxNc37Z92OX4RDVuvhvnbpEt9PZvEu05+sIkP5vGVQHD92XsSCnhvITedrKM0bynCJFsqzKykSRkiP6ZfqfrFyoQec0ZK4+fWD/BdZ/7NO9CVxi2E1APxJ3sr0v07w3U0wPWkGTOUg2my3WoaADctinah08yjgin3yuOc0Gm40FhFD8qSa7JO7jSZ5wG1SHG61Wtk6lD4EpHlD0DC20q/I46tkjqn6v4od3GNyJBur5/LnjumsnLJz3rmwLBYefMX3yFStEdnNzDydOmiCoO86Y8i/6b1tTdpLTCUJdQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2RLaFJEZXdqTytCaldGdFNaclhsWDhadGJuclFGZ3hWeXFjWDJXZGVwT096?=
 =?utf-8?B?QWx2dG9sV1Nscm9ZcjdtNVJPL1FGYzc1dlduc3YxZUY5TlprNGwzOEIvN0lj?=
 =?utf-8?B?TXV2WW5LQlU1WmM2ano5QmdwVFczUkpubThaY0E2WEFVRi9lbG5iTkdrb1B6?=
 =?utf-8?B?MEtPdjYzUWJ0U25iTVZhcWVDaFFlb2pDZW0velduTnJLS3IyaG9iVlJURkt5?=
 =?utf-8?B?d3RMejBsYkhxUzZDcGcrQ3E5bE1qRW5ZRHY2R2RSME5ERHl3Uys2Mk80Sk9y?=
 =?utf-8?B?UWozU0w1U21WZi81TEFIeXFKZjRkVnZIQW9LbXhrMmJmUlhoU2dpRkR5b2ta?=
 =?utf-8?B?VzVkVytpOHk0M2ZYeWFzODQzaXJlVCtYbnhWVndqbW0rSGM2WmVNQzQ0U1lu?=
 =?utf-8?B?Umppa1JxSXI0emg5cUlvNUUwSnErblZEN3ZNU0p6amkvNDFJSlIvbkh5dmQx?=
 =?utf-8?B?U3RoWDkwaXoyQU5jdllPTXlZQjM5eWM2S05PZEpTMjBXclh0cnozVm1FcUhE?=
 =?utf-8?B?ZFJmT1RGbGREanRoTkREd3RBTTNndEJrRmpqeWluSzVJdXFMSVJCZ3U1dnRt?=
 =?utf-8?B?bjBtdTBKdDZIaHEwQTkrOVZEZEtHa0MxNE9ldTc2WWxLczl2MnVPL2hsSmlQ?=
 =?utf-8?B?MGNtVkhQMTJYb2oreTZDQ056Q3Z2bjVEN1FWNkdpU0lUc3V3emdjRmMzSnU1?=
 =?utf-8?B?c1g1ckg4M2poMk9PODZRZ1dHQloyTE5YTHNUOEZKQWdPeVdSNElGaVo2bnRL?=
 =?utf-8?B?RGZRdUZOTTdLdk9ZWjE5bGJqZDhvNWlvZGRmTVZ0MUlFOHNrcEllbjNmc2My?=
 =?utf-8?B?TWFiUFk3NWxDeW5ucStoT3JTOEdwYVZQYWxMV1MvdjVxVFVxVHVlN1FaZFBj?=
 =?utf-8?B?TUFPaVRWRnVpblZLRWM5TkpCZWlacEkySSsxMUltc2t2dmdHR1NFVGtobW1W?=
 =?utf-8?B?Kzh6Vjd6Lzl4K20wbXRRZUdkc2dzaXdkMzVoQitpbDJ5NmRhUzNoRlBjOEF5?=
 =?utf-8?B?TlRDT0xud2tWUlF2L25Qa0pIRUp1QUhRaXlhcmRndjUvVnVnL2xCM1o2UzJl?=
 =?utf-8?B?Z2k3VFJmNmM2cmRTRDVZQ2hkcldjSTJORVJCMFlwM29LemZRN1I2TDFTSXlv?=
 =?utf-8?B?WkJRbmxZVmViU21Xb1k0L084WURlRWc4cUVBYXI4bnRMVG5YeWtKa25LUE5j?=
 =?utf-8?B?Umx4d1FYM21lUEh0VTJ1STJaOWRIRmo2ODFXa3NMRll3U1Y1U29NSUdxajhW?=
 =?utf-8?B?cTl6bDN5bFVsc1k5Mnc4UkNoalFlWFNDRlF2NVMyMXo0VUJtbjhzcHpaMnIv?=
 =?utf-8?B?N25sQysrQzk1RForMGFQcmx6UDZ3UEZnZDR2cDEvNkVZRW11U21RZDY1Q05W?=
 =?utf-8?B?aCtyVjlCd3pEWUhXNmdMWmVteXU2NHJ4eDNORXIxRDRlNENZNHNISnZkcVlh?=
 =?utf-8?B?dXV1S1h1OStWYUFjR1E4OEFTWFpubmZNTjZCTWRrVHNGWEhGbWJ6TnZaNXBq?=
 =?utf-8?B?RTZNOUhQV0NqMzdIbFRuZENKcTFKOEh6TlpZcWRrczVLT1JzY2FITlRodjJQ?=
 =?utf-8?B?NVVlUkJnTExiZkpMdHNDbDNYM1dLdGsyUnVzd3k1MzI3aDAyQ3pxNjlRY0Zh?=
 =?utf-8?B?NHFMVmFuSjY5M0ludndnYkwyajAreFlVeUtXNmxUaFk0UEhXWXZZb3hWTlJW?=
 =?utf-8?B?NmhWQ0ttQTd3SXJjbXRNZnpHRFlEc1J1QVZCc1E3bHJuMUhUTEJteTdOV2Uv?=
 =?utf-8?B?Z3ROYnJTSUdkcW5ucXhpZDlYRlhmRkZORS90QW0rWnZOZnMvcVgrU3dhL3hD?=
 =?utf-8?B?d3E1NzQ3RnpYbEc0Z2VlOGJLQnNkL2c1L3U4ZEhyT1JDTVAxUUE3RC9FN1Vn?=
 =?utf-8?B?eXMvTVJPdDRMYlFBalA2Z2ZTNkJYdWY2N3RDYjBXKzlnRFZrRVBqRXU4aVBN?=
 =?utf-8?B?bHR4em9Cdkdlay9LMGF2akJMNFlqbE95eEVJSHJpSUNBYkhYWnhKb2dadXVw?=
 =?utf-8?B?RXRMMkphaGFTUHgxeXFIczg4T3JYU2FWZDBweEoxUmZ1RzRMME5IYjVVemsr?=
 =?utf-8?B?R21POFFqazg1Y3JJSU1UMXV4bjh0c2s5YXB3a29pdEdtS0FrcmZkbnBYME8z?=
 =?utf-8?B?VmdzbFdLK3c5OHY3c3VZTXJSQk9vbkc2aDcyNndUdVJ6cjB6N2hVKzdaV2pK?=
 =?utf-8?B?akZUcW4za241ZzlwZnhvSzdjSngvYnJrSGwxZ3BmRzNlcnVlNmhOZkpxdzdl?=
 =?utf-8?B?TUVRRU8zdFZDWE9kTzZBYWUvd09LbnZyZnM3MThmbDdBd29vTE5URkU2NDRY?=
 =?utf-8?Q?tUvX/RLX2RjzC4f/5y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75820fd-8237-4041-5031-08df0a32d73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 03:15:58.5048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1LEf5lJq/00j264JGoZxWXkFSZ4/oR77pRL2slydI6c3n+wqnIapU5yj/LSF+ltVJPJwgn07xAX7Dl4yR8H2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120
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
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1i
ZXIgNCwgMjAyNiAyOjAxIEFNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdA
YW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBB
bGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDA4
LzEwXSBkcm0vYW1kZ3B1L21lc191c2VycXVldWU6IHJvdXRlIGNvbXB1dGUNCj4gTU9ESUZZIHRo
cm91Z2ggaW5pdF9tcWQNCj4NCj4gT24gTW9uLCBBdWcgMzEsIDIwMjYgYXQgMTo1MOKAr0FNIEpl
c3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFNldCBwcm9w
LT5tb2RpZnkgYW5kIHByb3AtPnVzZXJfd3B0ciAocmVhZCBmcm9tIHRoZSB3cHRyIHBvbGwgQk8p
IGFuZA0KPiA+IGNhbGwgaW5pdF9tcWQsIHNvIGEgcmUtZW5hYmxlZCBjb21wdXRlIHF1ZXVlIGtl
ZXBzIGl0cyBjb250ZXh0LXNhdmVkDQo+ID4gcnB0ciBhbmQgcmVzdW1lcyBhdCB0aGUgZmlyc3Qg
dW4tY29uc3VtZWQgcGFja2V0Lg0KPiA+DQo+ID4gQWxzbyBzZXQgbW9kaWZ5PWZhbHNlIG9uIHRo
ZSBjcmVhdGUgYW5kIGtlcm5lbC1yaW5nDQo+ID4gKGFtZGdwdV9yaW5nX3RvX21xZF9wcm9wKSBw
YXRocywgc28gZXZlcnkgaW5pdF9tcWQgY2FsbGVyIHN0YXRlcyBpdHMNCj4gPiBvd24gdmFsdWUg
cmF0aGVyIHRoYW4gcmVseWluZyBvbiB0aGUgemVyb2VkIHByb3AuDQo+ID4NCj4gPiB2Mzogc2V0
IHRoZSBtcWRfcHJvcCBtb2RpZnkgZmxhZyBhbmQgY2FsbCBpbml0X21xZCBpbnN0ZWFkIG9mIGEg
c2VwYXJhdGUNCj4gPiAgICAgdXBkYXRlX21xZCBjYWxsYmFjaywgcGVyIHJldmlldy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiA+
IFN1Z2dlc3RlZC1ieTogQWxleGFuZGVyIERldWNoZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5n
LmMgICB8ICAyICsrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVl
dWUuYyB8IDIwICsrKysrKysrKysrKysrKysrKystDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjEg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMNCj4gPiBpbmRleCA2ODZjOTJlOTYwMjUuLjlmZDBh
YjBiZTQwZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmluZy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jp
bmcuYw0KPiA+IEBAIC04NDAsNiArODQwLDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3JpbmdfdG9f
bXFkX3Byb3Aoc3RydWN0DQo+IGFtZGdwdV9yaW5nICpyaW5nLA0KPiA+ICAgICAgICAgcHJvcC0+
dXNlX2Rvb3JiZWxsID0gcmluZy0+dXNlX2Rvb3JiZWxsOw0KPiA+ICAgICAgICAgcHJvcC0+ZG9v
cmJlbGxfaW5kZXggPSByaW5nLT5kb29yYmVsbF9pbmRleDsNCj4gPiAgICAgICAgIHByb3AtPmtl
cm5lbF9xdWV1ZSA9IHRydWU7DQo+ID4gKyAgICAgICAvKiBrZXJuZWwgcmluZ3MgYWx3YXlzIGJ1
aWxkIHRoZSBNUUQgZnJvbSBzY3JhdGNoLCBuZXZlciBhIE1PRElGWSAqLw0KPiA+ICsgICAgICAg
cHJvcC0+bW9kaWZ5ID0gZmFsc2U7DQo+ID4NCj4gPiAgICAgICAgIC8qIG1hcF9xdWV1ZXMgcGFj
a2V0IGRvZXNuJ3QgbmVlZCBhY3RpdmF0ZSB0aGUgcXVldWUsDQo+ID4gICAgICAgICAgKiBzbyBv
bmx5IGtpcSBuZWVkIHNldCB0aGlzIGZpZWxkLg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+IGluZGV4IDgyYmI0MzY5NDUxZS4uYzZhYzMx
OTRlNGRhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191
c2VycXVldWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2Vy
cXVldWUuYw0KPiA+IEBAIC00NzksNiArNDc5LDcgQEAgc3RhdGljIGludCBtZXNfdXNlcnFfbXFk
X2NyZWF0ZShzdHJ1Y3QNCj4gYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZSwNCj4gPiAgICAg
ICAgIHVzZXJxX3Byb3BzLT51c2VfZG9vcmJlbGwgPSB0cnVlOw0KPiA+ICAgICAgICAgdXNlcnFf
cHJvcHMtPmRvb3JiZWxsX2luZGV4ID0gcXVldWUtPmRvb3JiZWxsX2luZGV4Ow0KPiA+ICAgICAg
ICAgdXNlcnFfcHJvcHMtPmZlbmNlX2FkZHJlc3MgPSBxdWV1ZS0+ZmVuY2VfZHJ2LT5ncHVfYWRk
cjsNCj4gPiArICAgICAgIHVzZXJxX3Byb3BzLT5tb2RpZnkgPSBmYWxzZTsNCj4gPg0KPiA+ICAg
ICAgICAgaWYgKHF1ZXVlLT5xdWV1ZV90eXBlID09IEFNREdQVV9IV19JUF9DT01QVVRFKSB7DQo+
ID4gICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fYW1kZ3B1X3VzZXJxX21xZF9jb21wdXRlX2dm
eDExDQo+ID4gKmNvbXB1dGVfbXFkOyBAQCAtNjgxLDYgKzY4MiwyMCBAQCBzdGF0aWMgaW50DQo+
IG1lc191c2VycV9tcWRfY3JlYXRlKHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVl
LA0KPiA+ICAgICAgICAgcmV0dXJuIHI7DQo+ID4gIH0NCj4gPg0KPiA+ICsvKiBSZWFkIHRoZSBx
dWV1ZSdzIGxpdmUgdXNlciB3cHRyIGZyb20gaXRzIHBvbGwgQk87IDAgaWYgbm90IG1hcHBlZC4N
Cj4gPiArKi8gc3RhdGljIHU2NCBtZXNfdXNlcnFfcmVhZF91c2VyX3dwdHIoc3RydWN0IGFtZGdw
dV91c2VybW9kZV9xdWV1ZQ0KPiA+ICsqcXVldWUpIHsNCj4gPiArICAgICAgIHU2NCB1c2VyX3dw
dHIgPSAwOw0KPiA+ICsgICAgICAgdm9pZCAqd2MgPSBOVUxMOw0KPiA+ICsNCj4gPiArICAgICAg
IGlmIChxdWV1ZS0+d3B0cl9vYmoub2JqICYmDQo+ID4gKyAgICAgICAgICAgIWFtZGdwdV9ib19r
bWFwKHF1ZXVlLT53cHRyX29iai5vYmosICZ3YykgJiYgd2MpIHsNCj4gPiArICAgICAgICAgICAg
ICAgdXNlcl93cHRyID0gKih2b2xhdGlsZSB1NjQgKil3YzsNCj4gPiArICAgICAgICAgICAgICAg
YW1kZ3B1X2JvX2t1bm1hcChxdWV1ZS0+d3B0cl9vYmoub2JqKTsNCj4gPiArICAgICAgIH0NCj4g
PiArICAgICAgIHJldHVybiB1c2VyX3dwdHI7DQo+ID4gK30NCj4NCj4gQ2FuJ3Qgd2UganVzdCBz
a2lwIHRoaXM/ICBUaGUgZmlybXdhcmUgc2hvdWxkIHVwZGF0ZSB0aGUgTVFEIGFuZCBzdG9yZSB0
aGUgY3VycmVudA0KPiBycHRyL3dwdHIgd2hlbiB3ZSB1bm1hcCBpdC4gIFNvIHdoZW4gd2UgbW9k
aWZ5IHRoZSBxdWV1ZSwgYWxsIHdlIG5lZWQgdG8gZG8gaXMNCj4gc2tpcCBhbnkgY2hhbmdlcyB0
byB0aGUgcnB0ci93cnB0ciB3aGVuIHdlIG1vZGlmeSB0aGUgTVFELiAgTm8gbmVlZCB0byBzYXZl
IHRoZQ0KPiB3cHRyLiAgT3RoZXIgdGhhbiB0aGF0LCB0aGUgcGF0Y2hlcyBsb29rIGdvb2QgdG8g
bWUuDQoNClRoYW5rcyBBbGV4LiBZb3UncmUgcmlnaHQsIHdpbGwgc2tpcCB0aGlzIGluIHY0IC0g
aW5pdF9tcWQganVzdCBrZWVwcyB0aGUNCmZpcm13YXJlIGNvbnRleHQtc2F2ZWQgcnB0ci93cHRy
LCBkcm9wcGluZyB0aGUgcmVhZF91c2VyX3dwdHIgaGVscGVyLg0KVGVzdGVkIGFsbCBwYXNzLg0K
DQpKZXNzZQ0KPg0KPiBBbGV4DQo+DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IG1lc191c2VycV9j
b21wdXRlX21xZF91cGRhdGUoc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1ZQ0KPiAqcXVldWUs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1f
YW1kZ3B1X3VzZXJxX2luDQo+ID4gKmFyZ3NfaW4pICB7IEBAIC03MDcsOCArNzIyLDExIEBAIHN0
YXRpYyBpbnQNCj4gPiBtZXNfdXNlcnFfY29tcHV0ZV9tcWRfdXBkYXRlKHN0cnVjdCBhbWRncHVf
dXNlcm1vZGVfcXVldWUgKnF1ZXVlLA0KPiA+DQo+ID4gICAgICAgICB1c2VycV9wcm9wcy0+cXVl
dWVfc2l6ZSA9IGFyZ3NfaW4tPnF1ZXVlX3NpemU7DQo+ID4gICAgICAgICB1c2VycV9wcm9wcy0+
aHFkX2Jhc2VfZ3B1X2FkZHIgPSBhcmdzX2luLT5xdWV1ZV92YTsNCj4gPiArICAgICAgIHVzZXJx
X3Byb3BzLT5tb2RpZnkgPSB0cnVlOw0KPiA+ICsgICAgICAgdXNlcnFfcHJvcHMtPnVzZXJfd3B0
ciA9IG1lc191c2VycV9yZWFkX3VzZXJfd3B0cihxdWV1ZSk7DQo+ID4NCj4gPiAtICAgICAgIHJl
dHZhbCA9IG1xZF9od19kZWZhdWx0LT5pbml0X21xZChhZGV2LCAodm9pZCAqKXF1ZXVlLT5tcWQu
Y3B1X3B0ciwNCj4gdXNlcnFfcHJvcHMpOw0KPiA+ICsgICAgICAgcmV0dmFsID0gbXFkX2h3X2Rl
ZmF1bHQtPmluaXRfbXFkKGFkZXYsICh2b2lkICopcXVldWUtPm1xZC5jcHVfcHRyLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdXNlcnFfcHJvcHMpOw0KPiA+
DQo+ID4gIGZyZWU6DQo+ID4gICAgICAgICBrZnJlZShjb21wdXRlX21xZF92MTEpOw0KPiA+IC0t
DQo+ID4gMi40OS4wDQo+ID4NCg==
