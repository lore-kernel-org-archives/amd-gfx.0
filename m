Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4FEC5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 05:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6717D10E8B4;
	Tue, 25 Aug 2026 05:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wi5e/75L";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884BA10E8C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 05:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=et35te5/XNQf/kJXK5yep5K05XdQTv8zxhHVKE7WxEv5WeE8VR6mJpFC0u4DPX4tvbX8lkeDRPzW3ZEszFhRzksUZ4skPBva7GeopN+JAcZgHUVZ0HlAeZo9+KvJIDoQ35W4TQRudn/xN77196ExfeDlsO/RpBEbAX9KCm5iiM7eOQ8eWbh8eJjvvANwbdhL4MTwTagPOiMCR9OQYwv280G2qKA2XtUJyBeLi2eYODF52/4Yr20AAmU95QqU0UcGCGTK1hkQ/9D2ebMVXIwn73n5n0c5njRM8Sm1QRu7w4aVFf3mfDcQYJ14iB2WsNYDAvH2TYM5AJO3ztxpYwP2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHbccCRyzU7QfPYh8Z1TJYTnyVc0itbuBkjwFGYTd/E=;
 b=vDhEuGAhh/2hn9vWuxn8E+WwR/H/WG5IKQ+mQccx0tXiqtuMZ2Fa1fKZZT0f20tpfr84CEmNtiJbGDL/K7GoAuQfUFy6WevbMaXn6j2ht4IKQY6toS5qIjhrDm+Fdh9chDjHnvbJhkit2vM0jZ8AyXF3rG9woul2B/x2Tm62PVil1tiZZGxPaPE6aEFCltSufSkUp+XWXSJJEkSgfAwQ6rfK58JzZHJ616ZcP1QBZvzlwod9DVX2mtKG4gaiW3a4jrdUVUSiOYvnW+GQWkaO4Ole+3fM5l/gw5n7k1escB51WDLvS1Au5H1AzqBBwCWaNYlVqE/zkz/Y2XfkyecweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHbccCRyzU7QfPYh8Z1TJYTnyVc0itbuBkjwFGYTd/E=;
 b=Wi5e/75LKrV6Bratg/1zuNP3nlSLtuVlD/O1K/m1u9bfq0wYb6FtRLq3+Mb4RZ7yXwI1IfrLgk9XmJ7uBL12SisypOv4TwpuVIcCIYiiuF5PcYgfWYd7XsFa9Plz1hpcMr5QSFDraQkFkzcWE5mshlxCHG+jp9Xsj6J2rLW4uxQ=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 05:05:54 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 05:05:54 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Natalie Vock <nat@pixelcluster.dev>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhu, James" <James.Zhu@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Six, Lancelot" <Lancelot.Six@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>, Samuel Pitoiset
 <hakzsam@gmail.com>
Subject: RE: [RFC PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler
 ops to VM ioctl
Thread-Topic: [RFC PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler
 ops to VM ioctl
Thread-Index: AQHdMHHTM4H23nnYyUqG33PBq+0ThramtEcAgAeJGoA=
Date: Tue, 25 Aug 2026 05:05:53 +0000
Message-ID: <IA0PR12MB82080BCDF88122DD4E767E1390AF2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
 <20260820070143.3916329-2-srinivasan.shanmugam@amd.com>
 <6dcd3e9a-b308-44c6-a9cb-4bca149a2fde@pixelcluster.dev>
In-Reply-To: <6dcd3e9a-b308-44c6-a9cb-4bca149a2fde@pixelcluster.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-25T05:03:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|CH3PR12MB8711:EE_
x-ms-office365-filtering-correlation-id: dd0b2429-fe8f-4eae-ff21-08df02668a5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 6ZpZgsEkMLP55gfR9hO/qYEabHmH9qnjEnQo7s8xLxS6hWrrEwHM9B/yYnausYU1ZV7KAYbZp2QLfbVyv3CeQ0+n9LlhAtjwEkn8UXJabw/BDZ4kI2oEUhfWIgMyIuJ2mqAolW3rFPRRHfOiSwGA0Tmmb1SZJmZwkWlDriYGnJfBQDv/Eq0wavkUnob94reu3uONCrkrBOq0LeK8KISGFRCEG6iawAXJLe25FR/Ow7awjGxJ1Jpbk2s0v3KbRMlf65VZ0KHfUGsW9Wx3S/jhZgUu5i2tpZKLW1qLe4JQ8G9r8Ycnki1vGK6y0rVN9H3hfE6H1Qpg9RGwzKW6BOHQIvkhklGdOp8kzLamn5/5/sIYpExTORfdzTNaziD0AlRbMOgyMPfimIgYufNe4x/lfkQc0srl1sFQBWlVg3mR3lk7jPnd/Y9cHLc31J4/VMBll3EbVXTJtXfxq7en0R4fmXi2anQnlbgD+XW+KR0Le7a70/gN/zdcIYxR5MIrKEcIkEOTCWZaKBxRhCMs9zJdrPe+/SKSsgLboSJhSCuCXVqisRUzROrgM27dTq5tXmzJFPcKDFebLo16FlOTgMJeB1v1SbHl1wLHYeIQoHxBIFXfyEBGxtb6++2V0UKVyZ8kjM9FSfa58RYq1knv1HHejpAfRqFe5rQ0T2zz3GnhSJjtTeH3xxFLSyC+ciYE+7kIz97Y8Xohq7he7gHuep2WuOl9FG1tWnllxYhruWJxYoM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFpWVdYZEQ1ZXQrV2JTT2FIdFNQbUozaysxY0VtTStzVkJ5akcybkNqQ05B?=
 =?utf-8?B?VWRnaE1zeEJWN01UUFhiRlgwMkd4R3hkUUhpbmVPYzM1WjFhdDdrcFJ2Z0hr?=
 =?utf-8?B?MnFiT1FYbFo4bzZRL2VyVkRZNk5iS1p0ZkoyZ2ZCajg3eGdkNXJ5ckw1d3Z3?=
 =?utf-8?B?ZWJ0Q2Q2VnNSUW0reDcxSUh0U2tmNUxFUkwzekhzd2VKRGtoem4rdTRuMkNu?=
 =?utf-8?B?RHk0NU5JZVJtenpGY05oVGFJUUpBUVBKaHl4KzdxSnNvV1dCdFlNVDlQWGYr?=
 =?utf-8?B?VkZpcURJODM0dDZ2bURiNXhmWVNQRW5OSG8wcWNSL1Y0WXBlQTh4elhqM2dJ?=
 =?utf-8?B?OXNwQnhQdS81NVJBeTgyWGdlejQxZXRVcUU3VHRNN2U2S0FaU0daVUs5ckNx?=
 =?utf-8?B?QnZnWFpDRGYyS3lVYkdOZDN1QXBuelhQdnRlZ084cDFhck5QZEF2d2FVNTlS?=
 =?utf-8?B?V3R2bFlwRWhOVUZ5eTY5czdQZ2MwbU0wSmRJM1k0NUZQVmRnTHlDYXQySi8y?=
 =?utf-8?B?WVJ1TUJTNkkyR01qeGxVY2hSNXp0RmZUQ045MDByQnRVakpCRE5uUTFXK1NG?=
 =?utf-8?B?R3VlUVh5Y1N6OFFzVzNhcWw4dE0xM1d6QWNxY3N0cE84QmdDRGRrL0kzVGlh?=
 =?utf-8?B?Y21FeEl6d1hsRi9LanZXRmoxenE2MUpkYnBBWlNaaXJ6cy9sRC9WWUdoaE5S?=
 =?utf-8?B?eHRidUI1ODRmOUVET1hia01XTzRiT0ZnNVE5bWFxeXNNVERURGkzaUowb0Zt?=
 =?utf-8?B?QjVmOFcvRDhsZkJsWU1QWFFwaTA0SkVOaEVTdzlLWlpSTXZrOWtpSllxa0dL?=
 =?utf-8?B?RXVzd000QlpLWDQ4U1lGZGVWRlE2QTRNUHNNZTRpcVV6c2JKOTV4ZHFFUzNT?=
 =?utf-8?B?RG41cTJGUU1hbkUrRGR4dzY3djl5dWdkak11ZXlPZXhueVNtOHJ2Q2V5cmY0?=
 =?utf-8?B?YTF5YWRXOTlOVG1lcFdTd0YyVVVxS3hpTDZMZW9TU2ZFdmxwd3krRXh5ZjYv?=
 =?utf-8?B?RjRkMkZxa3hGaU9XZDIxYklLQ2ZRc2orcEh2MlNhRmFTUXljZjk1NUhvVCs4?=
 =?utf-8?B?aTNUc1B5RDVleVc4SXc3QjFISEpoL2c0aE5ZQVU0SmtuTjFTeEdqeHc1YSs2?=
 =?utf-8?B?N1lNaUJXRThaRGdDODdCdXhWVlVOdUhwSFoxRlV2ZHVVSEtrNWZXZnl4cU4z?=
 =?utf-8?B?cFoxcnpNYzFqQThOM0dmTWFQV0NGZ0RQcVZJcy9rYU0xekZCK05YWUkvZjJo?=
 =?utf-8?B?dE1WNmhuaTV1cDN6V1F6Z1RVK2l1Qk1WcE9jMDlYZi84QVVRcHd2emVsNE5M?=
 =?utf-8?B?RFJGUlV1VWp5Mkt2Y21qeG42Q0kxT3kvU2wzRjFSWWFrazMrMEJ1VjBwZ2dF?=
 =?utf-8?B?VHVESzJYTnp2eWJsN1BucEIvU09lQ2JZMUQ3SkpUMGZSUnVpWnhDeXY5R1JL?=
 =?utf-8?B?eUtySHdwN094aGVXa2ZyOHIvVlFpWENTQ3EvLzM2VkZIcWlsb2JOWGRPYUdy?=
 =?utf-8?B?K1NZbG9VTlpkYXhCYUR6djdyOG5sY0tBRnRKaVk0aGI3NFpZdkJaSEc0VWh3?=
 =?utf-8?B?MHhyK0RsRUFIaDcxd2lRcW5GMlkyVTdlaDVEbnkwSWYyQlN0dk9hVXh4TzFD?=
 =?utf-8?B?R0szckpzeDAvZ3RwTE9DTDdtSzlBaE1zcDh6ajNiOVRCZUVDb0ZvaDJsRitI?=
 =?utf-8?B?dXBVcjJKSW1DTkx4UGlSNFdxUnorSjhFZHpKd3J0NmUveEpKU29adHV3VFlE?=
 =?utf-8?B?OElkdnhrVHFZOG84ZGhwKzhwcytiMTdIWjg1SkxSWDQwallZcVJVSS9tdjNR?=
 =?utf-8?B?SFNHblhZV3hSbWJLZmV6dkIyR3lFOVBXSzlrRkV4RUZuL1YxS2hCS1IzWjVr?=
 =?utf-8?B?SzJmTEppeFFGMlZzQmQvaVR4c1MxQ2dzZDgzWkhjem5LVjJmMDhPb1pLOE9X?=
 =?utf-8?B?RTVIK0tIdlAwdU9xZDdIZmVtNithSFViUHdLeFdvanJja0NPd1I4U2ZIUjNw?=
 =?utf-8?B?d2tDZzNOYXFUV0YwbnkxQ09ic0tMNkpRY2dWOUwyUWJ6RjluMDdVZFNsWW1N?=
 =?utf-8?B?QnRGZDFUd285MkxaNkJ2ZFJvemsxQ2VJTENkK3VHNlNWL3N6Z3N5QW1ZT01h?=
 =?utf-8?B?eDlPQ09EVXQ1bUc1cGhTZElCNzRBZ1B1ZVZ3dVdFR0s3NHEyZTVWaG1uR0hJ?=
 =?utf-8?B?RXZxaFo0RVdzS3JxeGFGdStxSjZNNmU0NVpOaldxdUpFVFo0NGVmWmlVNzRQ?=
 =?utf-8?B?MUJxL1NoU3B6VGJ5endJcWVUNExpMzdNSkhXOFpMM3Z1b1Jxa2ppUHJldi8y?=
 =?utf-8?Q?mWXkdxoArDdgfMe115?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0b2429-fe8f-4eae-ff21-08df02668a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 05:05:54.0807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spozEicCqjK6p3OBTLE03bAm57sTvDLpA+17mKPFRg6vJqXWszSX14q1WvGevx5l3DoxvHFcmVWpPQP1tbPgKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYXRh
bGllIFZvY2sgPG5hdEBwaXhlbGNsdXN0ZXIuZGV2Pg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0
IDIwLCAyMDI2IDM6MjkgUE0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNB
Ti5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS3VlaGxpbmcsIEZl
bGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsNCj4gWmh1LCBKYW1lcyA8SmFtZXMuWmh1QGFt
ZC5jb20+OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgU2l4LA0KPiBMYW5jZWxv
dCA8TGFuY2Vsb3QuU2l4QGFtZC5jb20+OyBQZWxsb3V4LVByYXllciwgUGllcnJlLUVyaWMgPFBp
ZXJyZS0NCj4gZXJpYy5QZWxsb3V4LXByYXllckBhbWQuY29tPjsgVGltdXIgS3Jpc3TDs2YgPHRp
bXVyLmtyaXN0b2ZAZ21haWwuY29tPjsgU2FtdWVsDQo+IFBpdG9pc2V0IDxoYWt6c2FtQGdtYWls
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1L3VhcGk6IEFk
ZCBzZWNvbmQtbGV2ZWwgdHJhcCBoYW5kbGVyDQo+IG9wcyB0byBWTSBpb2N0bA0KPg0KPiBIaSwN
Cj4NCj4gZmlyc3Qgb2YgYWxsOiBUaGFua3MgZm9yIHdvcmtpbmcgb24gdGhpcyEgSXQncyBncmVh
dCBzZWVpbmcgdHJhcCBoYW5kbGVyIHN1cHBvcnQgY29tZQ0KPiB0b2dldGhlci4NCj4NCj4gT24g
OC8yMC8yNiAwOTowMSwgU3Jpbml2YXNhbiBTaGFubXVnYW0gd3JvdGU6DQo+ID4gV2hlbiBhIEdQ
VSBzaGFkZXIgaGl0cyBhbiBleGNlcHRpb24sIG1lbW9yeSBmYXVsdCwgb3IgZGVidWcNCj4gPiBi
cmVha3BvaW50LCB0aGUgaGFyZHdhcmUganVtcHMgdG8gdGhlIGZpcnN0LWxldmVsIHRyYXAgaGFu
ZGxlci4gVGhlDQo+ID4gZmlyc3QtbGV2ZWwgaGFuZGxlciAobWFuYWdlZCBieSB0aGUga2VybmVs
IHZpYSBDV1NSKSBjaGVja3MgdGhlIFRNQQ0KPiA+IGJ1ZmZlciBmb3IgYSBzZWNvbmQtbGV2ZWwg
aGFuZGxlciBhZGRyZXNzLiBJZiBvbmUgaXMgaW5zdGFsbGVkLCBpdA0KPiA+IGZvcndhcmRzIHRo
ZSB0cmFwIHRvIHRoYXQgdXNlcnNwYWNlIGhhbmRsZXIsIGFsbG93aW5nIHRoZSBydW50aW1lIG9y
DQo+ID4gZGVidWdnZXIgdG8gaGFuZGxlIHNoYWRlciBleGNlcHRpb25zIHdpdGhvdXQgbW9kaWZ5
aW5nIHRoZSBrZXJuZWwgdHJhcCBoYW5kbGVyLg0KPiA+DQo+ID4gS0ZEIGFscmVhZHkgc3VwcG9y
dHMgdGhpcyBmb3IgY29tcHV0ZSB3b3JrbG9hZHMuIFJlbmRlci1ub2RlIHVzZXINCj4gPiBxdWV1
ZXMgaGFkIG5vIGVxdWl2YWxlbnQgbWVjaGFuaXNtLiBBZGQgaXQuDQo+ID4NCj4gPiBUaGUgc2Vj
b25kLWxldmVsIGhhbmRsZXIgaXMgYSBwZXItVk0gc2V0dGluZyDigJQgaXQgYXBwbGllcyB0byBh
bGwNCj4gPiBzaGFkZXIgd2F2ZXMgZXhlY3V0aW5nIHVuZGVyIHRoYXQgVk1JRCByZWdhcmRsZXNz
IG9mIHF1ZXVlIHR5cGUuIEdGWA0KPiA+IGFuZCBjb21wdXRlIHF1ZXVlcyBmcm9tIHRoZSBzYW1l
IHByb2Nlc3Mgc2hhcmUgdGhlIHNhbWUgVk1JRCwgc28gb25lDQo+ID4gU0VUX0wyX1RSQVAgY2Fs
bCBjb3ZlcnMgYWxsIHF1ZXVlIHR5cGVzIGZvciB0aGF0IHByb2Nlc3MuIFRoaXMNCj4gPiBjb25m
aWd1cmF0aW9uIGlzIG5vdCBDV1NSLXNwZWNpZmljOyBDV1NSIGlzIG9ubHkgdGhlIGZpcnN0LWxl
dmVsDQo+ID4gaGFuZGxlciBtZWNoYW5pc20uIFRoZSBjb3JyZWN0IGhvbWUgZm9yIHRoaXMgc2V0
dGluZyBpcyB0aGUgVk0gaW9jdGwNCj4gPiAoRFJNX0FNREdQVV9WTSksIGZvbGxvd2luZyB0aGUg
c2FtZSBwYXR0ZXJuIGFzDQo+ID4gQU1ER1BVX1ZNX09QX1JFU0VSVkVfVk1JRC4NCj4gPg0KPiA+
IEFkZCB0d28gbmV3IFZNIGlvY3RsIG9wZXJhdGlvbnM6DQo+ID4gICAgQU1ER1BVX1ZNX09QX1NF
VF9MMl9UUkFQICAgKG9wID0gMykg4oCUIGluc3RhbGwgc2Vjb25kLWxldmVsIGhhbmRsZXINCj4g
PiAgICBBTURHUFVfVk1fT1BfQ0xFQVJfTDJfVFJBUCAob3AgPSA0KSDigJQgcmVtb3ZlIHNlY29u
ZC1sZXZlbA0KPiBoYW5kbGVyDQo+ID4NCj4gPiBFeHRlbmQgZHJtX2FtZGdwdV92bV9pbiB3aXRo
IGEgMzItYnl0ZSB1bmlvbiBmb3Igb3Atc3BlY2lmaWMgZGF0YS4gVGhlDQo+ID4gbDJ0cmFwIG1l
bWJlciBjYXJyaWVzIHRoZSBHUFUgdmlydHVhbCBhZGRyZXNzZXMgYW5kIHNpemVzIG9mIHRoZSBU
QkENCj4gPiAoaGFuZGxlciBjb2RlKSBhbmQgVE1BIChoYW5kbGVyIHNjcmF0Y2ggbWVtb3J5KS4N
Cj4NCj4gVGhpcyBzaG91bGQgYmUgYSBCTyBoYW5kbGUgYW5kIG9mZnNldCtzaXplLCBpbnN0ZWFk
LiBUaGUgQk9zIGFzc29jaWF0ZWQgd2l0aCB0aGUNCj4gVEJBL1RNQSBtdXN0IGJlIHRyYWNrZWQg
YXMgdXNlZCBieSBldmVyeSBzdWJtaXNzaW9uIGZyb20gdGhlIFZNIHRoYXQgaGFzIHRoaXMNCj4g
dHJhcCBoYW5kbGVyIGluc3RhbGxlZCwgb3RoZXJ3aXNlIHlvdSBpbnRyb2R1Y2UgYSB0b24gb2Yg
cmFjZSBjb25kaXRpb25zLiBPZmYgdGhlIHRvcA0KPiBvZiBteSBoZWFkLCBoZXJlIGFyZSBhIGZl
dzoNCj4gMS4gVGhlIEdFTSBWQSBpb2N0bCBjYW4gc3B1cmlvdXNseSBmYWlsIHRvIGFjdHVhbGx5
IHVwZGF0ZSBwYWdlIHRhYmxlcy4NCj4gICAgIFRoaXMgaXMgb2theSBhbmQgaW50ZW50aW9uYWws
IGFuZCBCT3Mgd2l0aCBvdXRkYXRlZCBwYWdlIHRhYmxlcyB3aWxsDQo+ICAgICBiZSB1cGRhdGVk
IG9uIHRoZSBuZXh0IHN1Ym1pdCBpZiB0aGV5J3JlIHVzZWQgYnkgdGhlIHN1Ym1pc3Npb24uIElm
DQo+ICAgICB0aGUgVEJBL1RNQSBCT3MgYXJlbid0IG1hcmtlZCBpbiB0aGUgc2V0IG9mIHVzZWQg
YnVmZmVycywgdGhlIFBUcyBtYXkNCj4gICAgIGVuZCB1cCBuZXZlciBiZWluZyB1cGRhdGVkIGFu
ZCBzdWJzZXF1ZW50IGFjY2Vzc2VzIHdpbGwgZmF1bHQuDQo+IDIuIFRoZSBUQkEvVE1BIG1heSBi
ZSBldmljdGVkL21vdmVkIGFyb3VuZCBjb25jdXJyZW50bHkgd2l0aCBleGVjdXRpbmcNCj4gICAg
IHN1Ym1pc3Npb25zIGlmIHRoZXNlIHN1Ym1pc3Npb25zIGRpZG4ndCBhZGQgdGhlaXIgZmVuY2Vz
IHRvIHRoZQ0KPiAgICAgVEJBL1RNQSByZXN2LCB3aGljaCB3b3VsZCBsaWtlbHkgcmFuZG9tbHkg
Y29ycnVwdCB0aGluZ3Mgb3IgaGFuZy4NCj4NCj4gQSBzaW1wbGVyIHNvbHV0aW9uIGNvdWxkIGJl
IHJlcXVpcmluZyB0aGUgVEJBL1RNQSBidWZmZXJzIHRvIGJlDQo+IFZNX0FMV0FZU19WQUxJRCwg
aW4gd2hpY2ggY2FzZSBzeW5jaHJvbml6YXRpb24gdG8gYWxsIHN1Ym1pc3Npb25zIGluIHRoZSBW
TQ0KPiBpcyB0YWtlbiBjYXJlIG9mIGF1dG9tYWdpY2FsbHkuIFRoaXMgcHJldmVudHMgZXhwb3J0
aW5nIHRoZSBUQkEvVE1BIHRvIGFuIGZkLCBidXQgSQ0KPiBkb24ndCBleHBlY3QgYW55b25lIHdv
dWxkIHdhbnQgdG8gZG8gdGhpcy4NCg0KSGkgTmF0YWxpZSwNCg0KVGhhbmtzIGZvciB0aGUgZmVl
ZGJhY2suDQoNCldlIHdpbGwgdXBkYXRlIHRoZSBVQVBJIGluIHYyIHRvIHBhc3MgQk8gaGFuZGxl
cyBhbG9uZ3NpZGUNCnRoZSBHUFUgVkEgZm9yIFRCQS9UTUEuIFRoaXMgZW5zdXJlcyB0aGUga2Vy
bmVsIGNhbiBwcm9wZXJseQ0KdHJhY2sgYW5kIHBpbiB0aGUgYnVmZmVycy4NCg0KVGhhbmtzLA0K
U3JpbmkNCg0KPg0KPiBSZWdhcmRzLA0KPiBOYXRhbGllDQo=
