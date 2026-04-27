Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB290FF8862
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407B110E5F2;
	Mon, 27 Apr 2026 08:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LfWY0q6Z";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B266010E5F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfuzSg5hE7Szbbhd0Yagdk01odL6y8SSyONxao54aT7aYH3gdpdPHbphIgMps7C++GRRu4oCKbxMoumPFj08I3iriPf4Di+H/qU547ndFgijiHp9//d4YWCEkPBqQzcPQThXjgbtuUc4Ze7M9Y2SbasPvFEP2+DFOYhDgqllESP9FpCsL4RqlOlvg/RrlX3cunwTdWOM6ghq52mTx0eroDN/j3iXO3+HQJe29RL1+93Z/VdHhaU4SlErieDm+C0PBQwey1fKo2LCQvgS5evpQyhBX7ojr8Qeywk9TnsFLyKrb26AdQR2mwSaO2YyuHnZUEeJEdXV7lr6BvzM8n3wZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akDTUq7wbIiYJjF/T2udGoVKUOrmbEzTW+bVZJ4qTMM=;
 b=GHedDsjwL0XtpNn/lNP2NGdEu1CyM06QxphW8ir6ceD0T+oPgn0Jt8PTvXJys5QD0aHejEytfTVuG3E0wX3GbIfYgwS26C1Rh29GdclUCLF7reXMTVdYetqSm/jSkgVte9AkHXJF/YMAH5X5aNJHVswNchwSG6pfQ/PjYrnh6q616JAmyDZj25Rk1i5/bneLuGhpH9LsBhWF7avJsCiu30RDH4rTZIFpdxIE1XKytmJ+GNtWRaNG0PuUs4mCkz0b0rq8QlmXEIw9CMBIXcnn/BRESZI0kZnl3HHIo+u0MAfBSUQK4eSaSYUln7faTTbK1kH6bSsi/aK91qnSvnnl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akDTUq7wbIiYJjF/T2udGoVKUOrmbEzTW+bVZJ4qTMM=;
 b=LfWY0q6ZbkYBHLnvjOMe69tN9XCyGjJvx2EbB4onjt1PAnv2D1dw+BZbassnbi4r5L91QRT3lgcmcI63k80UEyOppICKvzVbUbiNACbhtlMgLrk5cNr3Kr+OJhV52G+ImMiM4f+9xkvxvKfoEomzYmwaTPUI6mvW0xK8hoeSf+g=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.12; Mon, 27 Apr 2026 08:09:16 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 08:09:16 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
Thread-Index: AQHc1hfT+/g/mRxeyUi136i5frsG/bXyhjYQgAAEMICAAAKJIA==
Date: Mon, 27 Apr 2026 08:09:16 +0000
Message-ID: <DM6PR12MB2972F9AD29542173B6B9A9B882362@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260427073042.3547935-1-lijo.lazar@amd.com>
 <DM6PR12MB2972472A5F44139A4439029C82362@DM6PR12MB2972.namprd12.prod.outlook.com>
 <b462125b-0cf8-4fff-996c-26a58e48e438@amd.com>
In-Reply-To: <b462125b-0cf8-4fff-996c-26a58e48e438@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-27T08:05:06.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|MN0PR12MB6030:EE_
x-ms-office365-filtering-correlation-id: 160eff8a-4f39-40c3-bf52-08dea43446bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 3B46rVPNKWxDq1dh2DyfCJcPkimCw+q8vlCfJj1gqdHN++8kQeuwOMz9oArusuqM4jhP6kv2lfqgBuUvLdjwNQC+jJpvAjGNPwkWEzfg8BK04qpRsMpAcR56k37phabmr76s4JZXQ3jFLPO2FBCa8sryKm2zxwAB2Vr5eKxJfaBlrUyB82wQGc28/QbF4bzL2RjBG0PzyIT4YtXhj5RtCu0MCi+TUvhzy1EiGOXhqw9C/ZZRGa2feSgvLakGe8lEdsDigBEJsB549HXJN6NL9/jN0gDLmndEPq6wL4BmQbMYHzsqAsz5Pg5gGrTLfelbi8cMSrfFxsTmJMGrlMrIc0EjCsOeIc3vi+ObITo9INjFZp97AaMmef7GqQEeiTmTkboe72zpyym9TtssvLmuisQ/mw8DJvAwlUDP7zw095C9PRcy/ohcbwqEQUQ2jjPc24vqg/pk01NRpdKP3Hbka4T+8LblwEyE5URIeEKJZPXyBwBGby2tLXXw0LLdteaQ+tzeleRLNQ2360/+g/6aRbGreZrKfqiFHZ7HtpHu/p9lzqXceju2z0iF0jazamZe0mlVdO91suVYLE7Yj3O9pRFYWsIhQusZEx4z7STjZuVxytULLL8CFwGHhyupq2fvkUWJoDAeqddKZk4kv7sYOYNLQMB3CuJT5Vtta9EiX4gKRoFvnHdl2xOBP577p5XCrKRtUjMdO25Ea9O0hsd5FzOhU+S96xG9wuGoTxhG4rt1USX0HWtBx4i9iv6fw5S7qVhpL5uXo2EOgogMFEHm4jnbSlf+JXz6zwj+H4Y9USc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHVjckNoaHBtNnJLYjdjMWsvem5xZ0c2b2hZUGlHTWlzQy9PRk1lOFIzb1dL?=
 =?utf-8?B?Q0k2QUlXNzZZOHZYUjA4NWNGRzgrb3U0dWgvazU0ZUFpT0d6dlh4ekxKZkFU?=
 =?utf-8?B?ZXBMY0o1NXorNWVWWUcvZFM3TXQ2M3Vxd3FTSnd1d21IYitsRFRrMG9iRldG?=
 =?utf-8?B?M3o0d2QvOUFuc1NXTHFFUndyWUpWNThNendIOG90RkpJNWV1NnduT2tGY21N?=
 =?utf-8?B?SndJWUVySnZYKzhWV0FCaVlaOTA3R2tYMCt1cDdHNkxxVlMrSFBLemphcXRU?=
 =?utf-8?B?cm52VjNLaTBaTmwyenp0bTVwUkIrQS9EdFNMeVJmWlpZTm44aUc4c3dYUGdH?=
 =?utf-8?B?WCt2ZURFdkJub2dVN0VIWXN6d1p6cDRkaTUxK1dpc1E2ekFPQVhlVE1FN0Nt?=
 =?utf-8?B?bGV0S1IwOG5wa0ZsOEwvNzJIb0tZNmE0ejBQdkRURHZubVh5YXQyem9DNlY2?=
 =?utf-8?B?VlU0Wll2Q0RoWjFRVkZiTTJyZ1NaZWxvZXZDU2Jkd0x4S3MvMFdoalRSQm1P?=
 =?utf-8?B?NXNXOGFNVDlCOEZGREVRMG8zTmpDTkw5UmVnWWc2YkNYWlJOdjdQZTIxNHhm?=
 =?utf-8?B?Zk8wMFppNGhwcnVSNWppelRQL25xM1RaRzJOS2dpb0JxOWluSXN2dXl3NGFu?=
 =?utf-8?B?NGFHTlVUZVFYN1hLZXI3ekZNK01DM3puYkgvL3liNzBQQmJXbUVyWUVDbm1F?=
 =?utf-8?B?NjNtK21ETnM0VmVZd2FjV0F5L2FFeERLcWFOU1BCTzVnZ1VjVXd0TVpXeTlh?=
 =?utf-8?B?VjZ6dnNKWXgvZWlNRWsvRU8yZjE1OFBiNlRFZnowcWNkK29iSTh4YTEvWnJo?=
 =?utf-8?B?ZVhFRERWdytFaE9LdllSajR3MmtZNU0yZXFESkdGdEI4QUFheFZhdllTS2E1?=
 =?utf-8?B?amxTQVdlUzBXT2VNekFmMGxnNVJJVlFEYU5qNWtxaGNVQWVaRFZUYURWVGFF?=
 =?utf-8?B?cGhRMjZRSjlrem5wTHhYb3VpYVEvNXVFT2RHZUR4QlBGQ0xqYWpKWGE4RUt4?=
 =?utf-8?B?Rk85QnNrRXdsWjBON2lwTWFlOEF5UUFJV0N2Y3RDakJLU2ZFYVhOd0RVWkU0?=
 =?utf-8?B?MTRLaHBWRmhIMkRZUi9CdFc3OE5OejV6YlNIM3NaN0RRYkpWaGI2Z3p2Z2Rh?=
 =?utf-8?B?VTZFaUJyTDcyQlRNSmUwSTF0VHE5UE1YYzdmVFVYTnliUG5rYk5WNE56bW5W?=
 =?utf-8?B?N3Z5QURrcEZaNWV4Qjg4UE5NenNvQ1psOGR0aFlNd0ZjZlBIa0pXSUxiWmxG?=
 =?utf-8?B?V1A1WXZ0cXd6YWY2U242Wm5KdUlhK2hibGRmUXVRVTBEeDEvRFN0cnFMYVhW?=
 =?utf-8?B?MGIwQXcwUXQ0SjVGcEE3djZpVUQzb21pQ1VNUVpTZGs1ZVVKckowSGRPK3hE?=
 =?utf-8?B?UWV1aWpMRUFETTBIcXZNcTRSRUc5MURadzdvNTM4NHpuRFlmT1ZDd0dESnFj?=
 =?utf-8?B?cnBNT0tPbzk0QUE3MS9abmJVUC81cWVtaWdQeGRXZjFicVN0cTQ5c1RQbEtl?=
 =?utf-8?B?dW00a0dMZHAvNXZ0Vy9keTJIeTVUR09pMTdhWjUzSjRTN1UrM2t6WlIxakEx?=
 =?utf-8?B?Yzg0T3VsRGhIdGxldlVyQlgvdTNublpPK1ZCTFlXc1o2amNhREVUb1VxWFQz?=
 =?utf-8?B?TGR6ME1KczZsYWdTSXI2MkZEcENwMnRzcEY4Sm43SUFXeWQzS1c0czRKYVlX?=
 =?utf-8?B?OTZUMnVLTmVGVEFPMk5GN3o4bjk0S2JzT1d3VkxIM0VzN01zaTNEa29XMEl1?=
 =?utf-8?B?TysvbHBVdDYrOGo2Y0VlZWR0OUFNQktKY1RYdVNXWFFGYis4TmJOVUkrbklh?=
 =?utf-8?B?YnRqOEtyT3NkSVRNeGFNR3c2ZXdPVUV0VFc0Z0lkREdSVmN5RGNpaTZma25r?=
 =?utf-8?B?SldJd1U2RmM5alJCRGFVTUZHV0hMNFZ2VnVLVTlnZGN2KzFFbXhWSjhPa0FH?=
 =?utf-8?B?bmptYXBEbCtNYTZYTmE4RDIvL1h3R2RwQTNvamdCMHlvYi9oUnFEclNUeGVi?=
 =?utf-8?B?QUJwUzJHUlhLcEV3UnE4MUJqU3FyN1NYR0N5N0crMDMvVEQvN1kxUTNpWUhu?=
 =?utf-8?B?a0lCNTlGTU5SV2tLSTNhNFozL05HbWhyQUpod3BnWms4SkJwNXAwL3lEazZr?=
 =?utf-8?B?Q0d0YmVhbzF6NGdkbEVDV0lFVll6RlpmQWVEdDQ1a3BJczJYWkZNbEovdjU2?=
 =?utf-8?B?a1BscW00S0xrVzJRWjg5SkQwOUFUb1VVaGVkY2tuc09HRWIzeFgzMFpKdjRT?=
 =?utf-8?B?MHZwWFFwSStMakswYVRkY0cxc2Eyc2dNVW4zVy8zcmVsMC94dG9uSWRJQW9K?=
 =?utf-8?Q?IBtB7Lv3mdClTR4tVy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160eff8a-4f39-40c3-bf52-08dea43446bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 08:09:16.5071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBg5auD3rMVs+ap8nwFmBMlfRopi0uc2dwqFUGwn94g4RX5KHsAPkCFsGO9ZYH3P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030
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

QU1EIEdlbmVyYWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBM
aWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBNb25kYXksIEFwcmlsIDI3LCAyMDI2IDE1
OjU2DQpUbzogV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBLYW1hbCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZC9wbTogQWRkIGZpbmUgZ3JhaW5lZCBmbGFnIHRvIFNNVSB2MTMuMC42DQoNCg0K
DQpPbiAyNy1BcHItMjYgMToxNiBQTSwgV2FuZywgWWFuZyhLZXZpbikgd3JvdGU6DQo+IEFNRCBH
ZW5lcmFsDQo+DQo+ICsgICAgICAgZHBtX3RhYmxlLT5mbGFncyA9IFNNVV9EUE1fVEFCTEVfRklO
RV9HUkFJTkVEOw0KPg0KPiBZb3UgbmVlZCB0byBtb3ZlIHRoaXMgbGluZSBvZiBjb2RlIHVuZGVy
IHNtdV9mZWF0dXJlX2lzX2VuYWJsZWQoKSB0byBwcmV2ZW50IHN1YnNlcXVlbnQgc211X2Ntbl9w
cmludF9kcG1fY2xrX2xldmVscygpIGVycm9ycy4NCg0KSSB0aGluayBpdCdzIGJldHRlciB0byBm
aXggdGhlIHNtdV9jbW5fcHJpbnRfZHBtX2Nsa19sZXZlbHMoKSBsb2dpYyBmb3IgdGhhdCAtIHRv
IGtlZXAgYSBzZXBhcmF0ZSBwYXRoIGZvciBkcG1fdGFibGUtPmNvdW50ID09IDEuDQoNCltrZXZp
bl06DQpObywgdGhpcyBzaG91bGQgYmUgYW4gaW5kZXBlbmRlbnQgaXNzdWUsIGFuZCB5b3UgbmVl
ZCB0byBtYWludGFpbiBjb25zaXN0ZW50IGNvZGUgbG9naWMgd2l0aCBvdGhlciBTTVUgZnVuY3Rp
b25zLg0KZS5nOiBhbGwgbG9jYXRpb25zIHdoZXJlIHRoZSBzbXVfdjEzXzBfc2V0X3NpbmdsZV9k
cG1fdGFibGUoKSBmdW5jdGlvbiBpcyBpbnZva2VkLg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0K
DQpUaGFua3MsDQpMaWpvDQoNCj4NCj4gV2l0aCB0aGF0IGZpeGVkLCB0aGUgcGF0Y2ggaXMNCj4N
Cj4gUmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCj4NCj4g
QmVzdCBSZWdhcmRzLA0KPiBLZXZpbg0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YNCj4gTGlqbyBMYXphcg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDI3LCAyMDI2
IDE1OjMxDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogWmhhbmcs
IEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEthbWFsLCBBc2FkIDxBc2FkLkthbWFsQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9wbTogQWRkIGZpbmUgZ3JhaW5lZCBmbGFn
IHRvIFNNVSB2MTMuMC42DQo+DQo+IEdmeCBjbG9jayBpcyBmaW5lIGdyYWluZWQgb24gU01VIHYx
My4wLjYvMTIgU09Dcy4gQWRkIHRoZSBmbGFnIHRvIHJlcG9ydCBjbG9jayBmcmVxdWVuY2llcyBj
b3JyZWN0bHkuDQo+DQo+IEZpeGVzOiA3MzgwMjI4NDAxYzQgKCJkcm0vYW1kL3BtOiBVc2UgZ2Vu
ZXJpYyBkcG0gdGFibGUgZm9yIFNNVXYxMw0KPiBTT0NzIikNCj4NCj4gU2lnbmVkLW9mZi1ieTog
TGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jIHwgMSArDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfNl9wcHQuYw0KPiBpbmRleCA0MGYwZDhh
Njg1YmYuLjhkMDRmNmU3M2ZkNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfNl9wcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jDQo+IEBAIC0xMTMzLDYgKzExMzMs
NyBAQCBzdGF0aWMgaW50IHNtdV92MTNfMF82X3NldF9kZWZhdWx0X2RwbV90YWJsZShzdHJ1Y3Qg
c211X2NvbnRleHQgKnNtdSkNCj4gICAgICAgICAgLyogZ2Z4Y2xrIGRwbSB0YWJsZSBzZXR1cCAq
Lw0KPiAgICAgICAgICBkcG1fdGFibGUgPSAmZHBtX2NvbnRleHQtPmRwbV90YWJsZXMuZ2Z4X3Rh
YmxlOw0KPiAgICAgICAgICBkcG1fdGFibGUtPmNsa190eXBlID0gU01VX0dGWENMSzsNCj4gKyAg
ICAgICBkcG1fdGFibGUtPmZsYWdzID0gU01VX0RQTV9UQUJMRV9GSU5FX0dSQUlORUQ7DQo+ICAg
ICAgICAgIGlmIChzbXVfY21uX2ZlYXR1cmVfaXNfZW5hYmxlZChzbXUsIFNNVV9GRUFUVVJFX0RQ
TV9HRlhDTEtfQklUKSkgew0KPiAgICAgICAgICAgICAgICAgIC8qIEluIHRoZSBjYXNlIG9mIGdm
eGNsaywgb25seSBmaW5lLWdyYWluZWQgZHBtIGlzIGhvbm9yZWQuDQo+ICAgICAgICAgICAgICAg
ICAgICogR2V0IG1pbi9tYXggdmFsdWVzIGZyb20gRlcuDQo+IC0tDQo+IDIuNDkuMA0KPg0KDQo=
