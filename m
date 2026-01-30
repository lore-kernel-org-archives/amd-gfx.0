Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C66E6BF1E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 15:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991EF10EA0F;
	Fri, 30 Jan 2026 15:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KqGJNPWM";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0B310EA0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 15:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPHdIoThIcnKVN65vZyTD/FobB1QpjYXFu/TbbpjXA03ORqbf7E2i5BUDg7hks6SvJ5R/aaJoReW79+e78WSVrveV+tFADCjvbAz75BU4cP9PlcBAQbrlwtc79FWG4busT5isBFpbVMRIZW1uPUvaAfD4+kLOw6cDHx4AFYO30EjOA7aDtocQ5y8cNXVPidu8X02XL8Gd4L+ElH0/rjOV35KHxbdU0/Fd2ZxZ5+Fm+KfSONI86BaDM9o/sUpyLpSC4WO50Qv91EgqO4vdysMyTZttQAwDfM4Wx9TFTNGJGbT+FVHyHeNsINhv2QZve5nrTRPqnxlyRqStLMSF2M2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gWeCayMvcDQh1gwtShsW8lL+/2SXglGdsiINq08p5M=;
 b=Lr1JCfSQb7VSS9n7zoiv/InOyT/MZ3N45ofsWCLpanfOMdaz1IkylVi51F2xLupI3DQvZ7vZEbgju70IGXF9JGCGmuQEUkNMVsJ85FniK7GsL5dluBdDgu2oLmPAttuPq3ylysUg9022CDcFpcRriKezioeiGu9kQMiS3j4o832O/tEG5UPn3Iso3e81UvhG918qp00Sk4Z6fHh1B0KoOx0JP+KulwW9EM3yzYXvFnWhMl6iT4nVn97sI4b1bFS5Nkn6Kqy3Tl+iBWTx/FozT0rLiwsG9LNbTmJg/azQz/HbHJ+mtSjK+3s8s80uts1yx9tOmiQvwh/Q+I0H+GQUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gWeCayMvcDQh1gwtShsW8lL+/2SXglGdsiINq08p5M=;
 b=KqGJNPWMfPJtySD+8uFYI52DvBge2hVHxoDs/HWt66DO5sXce1XUAbGlV4fGddOkgFW5090YKBSKiCNhVn4Iwjq3o3ZEBQiGQDFaZrwKwj7nUZLJpoZXFfh7nT4/Do+fGq9MgwXaPfHe5zzqrPlMNuib022oBTf14zOfBpVey70=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 15:51:30 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da%2]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 15:51:29 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "danijel@nausys.com" <danijel@nausys.com>
Subject: RE: [PATCH] drm/amd: Set minimum version for set_hw_resource_1 on
 gfx11 to 0x52
Thread-Topic: [PATCH] drm/amd: Set minimum version for set_hw_resource_1 on
 gfx11 to 0x52
Thread-Index: AQHckVgnTHz19f9HZk+y1qkZG2R2ObVplJ8AgAFIkEA=
Date: Fri, 30 Jan 2026 15:51:29 +0000
Message-ID: <CH0PR12MB5372A7C30E269B3DE6EB4D20F49FA@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20260129194722.2331593-1-mario.limonciello@amd.com>
 <CADnq5_MKvLhziwueZQ2HU7RUD8tr5NZH_a4TmDnYQMr+_UcCgg@mail.gmail.com>
In-Reply-To: <CADnq5_MKvLhziwueZQ2HU7RUD8tr5NZH_a4TmDnYQMr+_UcCgg@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-30T15:48:54.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SN7PR12MB7021:EE_
x-ms-office365-filtering-correlation-id: 16718ef8-2af1-4e94-96cc-08de60176ed2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WGUrVEI5cE5VTEM0M05pNnNpbU5OWm5KUWJzYlU0TVN5a1JwSFRVVUNRZnlt?=
 =?utf-8?B?QWZxaTFiS0owdUpJYXNwQUxTRnJyUGV3VmZkU0dsWjYrN1g3Smk1Y1hPYUtS?=
 =?utf-8?B?QTB5WDA3L1A2TC9TUXIrUnNMalRIQmFJaDVxSmg0d2ZPNjAvRFoySlNXd1dj?=
 =?utf-8?B?TWx0c2k0d2d1TW9vazhQdHlvZWROLzNQWFJDUENjckZTZjFzOGFLSXRYRytB?=
 =?utf-8?B?RVQ5SmdmaVh1bWF5d0h6WkZGWnFKUldjd2xjWW0rU2xxTjk3d3FxOW5rOVRy?=
 =?utf-8?B?TTlSZnRmUVAwWDVURzY0SDdnQXdVTVFIUU93RzNEUDBsaCt5aWpNUVhkcnVS?=
 =?utf-8?B?bmxMQXowd1BrL3haQ3VaNWVQSkVxdnZiREZjdXYrT01GM21ZVjVMRDVSMVpi?=
 =?utf-8?B?b1N6U3JwY29pUzM4UGV4U05Wdkd4NGNLUWMvLzdlK3lXZ2tlL1czQkpxUUNi?=
 =?utf-8?B?Ny96Y1BFR1lsVnd5QmhRMnE5ZmxwckVHL0ZvV0hlVkpVMWhVMWIyVHdOcnV0?=
 =?utf-8?B?UXJ3NWcwMnJrYVNIYlBCWXE1OFNOMUhYQ1VSSXFIYkdjVFJwbW9YOTFHQm9C?=
 =?utf-8?B?WWVoQXNMd0xCcTdnblBMRURTVTZLb0RmNGhlWG9nNllFMTRKaU1JSkhVRlpK?=
 =?utf-8?B?aTl4TkJkTGFTRktxcEt0bG00RklIeXQ5TXRJcHpvVGt0ZlF5NklsTjd4bG1J?=
 =?utf-8?B?ZDJKaC82MEdwWjBKalg1b3dqVS9GSzJ6TE1QV2hCaFlSS2U5OXpQaUFpUVZE?=
 =?utf-8?B?emFWQnpsL01oaklYeTFVUUhIZ0lwSFliYVNwendBZnl5ME9OZ0tiQ3ZHb0Zh?=
 =?utf-8?B?ZzZXOXJ2NlpldmdueWxpYmxudlVVQXpkcmxJNStkNFZ5RDRtcVlzcFFxbGVQ?=
 =?utf-8?B?eTZKZjQxcTMwT2R0dmRTcExteWt2WnU0RXJVWCt2VktVZTJkSDl0Q0lDd2V2?=
 =?utf-8?B?dzF4dkxxVnR6VzBjQWVndjBvblZBRmpralFoWWNQYWsySnU2ZWJzL2FzYU5V?=
 =?utf-8?B?MDZmelkxSkxJOERrcTIyRGpSbkdEeHZTZy9ETWRmYUxEYkdTRUxvMVNXaEF5?=
 =?utf-8?B?RWYvK0xlTmFiaEpqZUJWVjZNTmFNa1ZrNUJqYzhLci9lY3lBeVB1ckx5RjM0?=
 =?utf-8?B?aHN2L3FTY2x1UzEvWFlnYTJGU3JSWFdoMERjak83KzV6MTRPaDl3Vm5FY1Ix?=
 =?utf-8?B?NjN0TjZKS0xzZUo0UjAyQmk3M2Z3L3VzempTbmpaMFpyRU5OZ0xteXZFU2Yr?=
 =?utf-8?B?ZkpsSGhWTU0rMW56Zjl6UHNRaThLQlQweGJKWWN1Qko2NVJOTHZPK0xUVEFw?=
 =?utf-8?B?UGNSMVVBOGVxRTVVZ2pZcFYyUCt4WjBLTDRnUDgvRkUyVzNpOXhBK3d0VkdY?=
 =?utf-8?B?TmdFY3BIRXVPMXJ5Y01iWk9KbmRLcmJpRm9lTWJnd2lTTjZHTnlNQ25EWTFK?=
 =?utf-8?B?ZW4rT3NWdmJZeWtRdVd2NE41aE5VR3NXREJDVkJraVp1QUt0ZUR0cHlkTHda?=
 =?utf-8?B?cWltVXhHSTBiQmowbWhvSUl6TDUwRk5Nd1VoamZ3QlAzMndzWHJib09hdmtI?=
 =?utf-8?B?WTA3TGswZm5YMmNKb29DaW1ITXZaYlhVSURGSzJSVUhZbkFCQXVYTk1kTWlm?=
 =?utf-8?B?VUVERnJVL0V1cnMwa090RFloTEl0TkplTFJmWm41VWhGRi9oQTBCVVpvVzNT?=
 =?utf-8?B?N2hzLzA1cnJyWUEwUkV0d2VkRXdpWjJHZ0VBZldRNEp3bkFzN0RSTHU1ZDhT?=
 =?utf-8?B?WEhVeVd1RzczUDgrOHJCU2JyWkU5MnB5ajU4QW8rb3B2QUZ1ZThsWFFjc0Fh?=
 =?utf-8?B?MUtPZ3F1R2pXeWpJMzJhWkxlSGZCcXhtWjBOYk1hRnd6Y2cvbGd1MmhDc2ZH?=
 =?utf-8?B?K0d2SU93S1hwVTNVMDF0bW5DMEh1NVdkTFBjUm1QRWFGSmxMK3VZUm5sTUJw?=
 =?utf-8?B?VCs0NVpDNzJtQVFxVXR5a0o4cUt2OEFNNHl0Yk9PYjU4MjdvUEZvdVlUalRa?=
 =?utf-8?B?Z25hNjVkeFVXcFRQdVFzMzNTc3FLcWVvcWQ3SVkxVzYyS1BGbHR4aGJYUys0?=
 =?utf-8?B?UWxNcVZESG5OdUdBeWJIMFgvdTBuU0VXSUpNaitvRnZwRVNZemdKN3pVZnpV?=
 =?utf-8?Q?f2QMQ3UGd27TLFWdGU8pC7lpr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1RJNjFNd2NHcVhPV21vWitBdkkyRlNKZ1VmTzRtZDBFbzAySndmbDJuSndv?=
 =?utf-8?B?VXRWNmhaMmJ1ektSS2JOQy9JUlByNXdQbWl4ZE83NHdNUHgwWGd2dS8zbFB0?=
 =?utf-8?B?bFBCUEhVZzl3Z0VOdTA5SU0xYUpJaytCK2c1Z0VOTG1LYkpac0V0WG9ua3Fz?=
 =?utf-8?B?NFJ2dG9SeDg4aGFmdmRrN0FWeC8wZ0FJZ2hJOUlRVmJsUkx6Q1ArbjFWd2xG?=
 =?utf-8?B?MytpSzdsZVl0UG55OHljLzZEc1NhZzBEMjdTWkcxSllDZGZ5Zy9oaUw3N2hk?=
 =?utf-8?B?dmRsWk54UW8rb3d1VjBDQng2ZXJkbGwzbENSS1FqWnJhcjRidmhBdWE4cG1q?=
 =?utf-8?B?VmdoYmxYWnI0MjNzUzIwa0IwUmlxRlNaNXJWRG1LYXdaUDdWUTFSUGt0QjJl?=
 =?utf-8?B?OS95ZER2RmhsVGN3L2RqSEpkeGZ0WTlFT1JRWnVNeE1QZzF2VHA4Qk1pSGRo?=
 =?utf-8?B?b3AyWjJEYnk5VG51dlBJNUpWWVhvbUhtcDlmbG04eFViVkowajJFZGxVNmVr?=
 =?utf-8?B?QjhETlVPbWVuNlFZSk8yMFlTZ0ZsdTJqT0NJSEQwcmgvYmJJVTdqUVNCSFhZ?=
 =?utf-8?B?Wm0vUEoxdFh1UnBhdGNKeWJwSUlBNm1iWUo0bGkrbS9Yd0JGQzhQcm5qTGcz?=
 =?utf-8?B?ejV3YXJGc0dZWmliYzVITStVenE2YnRCNzhEOGVXU3VOTTNOazBnYnowY3U4?=
 =?utf-8?B?OFBRV3RUeXhtVFI2S2hGZUoyakJoMzBVUUlRaFFiTHNtQWJab3ZDemxXN0Jz?=
 =?utf-8?B?N1VPdGRJMmtWWHJTaXhyOHBwOWoxVFdxdzRUM1ZkK01VRVc2U0Y3R1daSnNR?=
 =?utf-8?B?a3M4SUxSTTVrYUgva29hQUpyMWdUdy9sUkl5L0JOV2NHQm52R3hXdFpOQ1Nl?=
 =?utf-8?B?OURtTHAydW5XekVmMi90dWxHbldaV0NRQ1d2aG94MXZsa0IrNEV5NnlvN2xD?=
 =?utf-8?B?eUVnazNNdWxaVlp6eDFRekFSeitYOElGQjl4bVowNTcxZkdhM3o2QnN5eWlr?=
 =?utf-8?B?ZUZCenZ1Tlh3ZU0zR2lyaGRWWm9lVTg0QXZaeml4VnZnMC9pbmpWWEFLcWdX?=
 =?utf-8?B?U241dUNSVjlhV2M5bGdkc0IveVpHWHBtOVd1Q3JyNS9rTHg4SVFvVTg4enVS?=
 =?utf-8?B?UFl3ZGxlMFRlL2QxdzUrVCtYVTYxTHQ1MTlldmtVcThSWHFqRTM0bjhxS2s2?=
 =?utf-8?B?SzF2MUgzaXphaHlyZnJsSU8yK2kvNXRNU0RLQktieU45c3ZpNTRkbktFc1RY?=
 =?utf-8?B?bWRvaGI0SjB5cDJrQm1RaU8vSzRBRHNocmU1VitBNkZod1BpOVpCdVVNTzJq?=
 =?utf-8?B?N2JWSFBZdVIzakR4QzFFNncxRmtLWVlZREJtbmM0blF3R3BWcjdCUW80Tk8v?=
 =?utf-8?B?VkhYZUdUMUZkRWxqTFlad0ZLZlZVQk9icU4rY3lYdzdjUkY5MjVyMTdEdHA0?=
 =?utf-8?B?MVo1UVJyampnSlBrVks5TkVqL3VrVUUzYVN5eWVESHhjV2ZWd2tnaG9PN0VW?=
 =?utf-8?B?UFRnT3pYQTNVSjZmZnB2VnJPUzlLVW8zakhHdzQxK3hhMlF1VklGb3BGcFZK?=
 =?utf-8?B?eks1UDhUaHd2c0xFOUcvYU5hRHV3bUplTEYyVnVwcVpCTysvUmVUUGh6cmda?=
 =?utf-8?B?cWx0OUJLTWMySGROUHdKZUJyUUV2bzlNZ0t2aE1ScTlIaHFKWWxrM2Qrd1p1?=
 =?utf-8?B?Mk1vcG9haXNTZy9YYXNRTGVGTlVmQjNHcUFaMmJIcmIxUDFadjdMczlIZitJ?=
 =?utf-8?B?TTRmK1dlMkJzUERtV3A4SXcwTFdoNkxTdHVuNlBQRGQ2M2E3RFFoR1hNUzFh?=
 =?utf-8?B?UWkrdzd2b2NEbEtJdzhBVXNRRkNjMGtxa3J3d1N6SUlieE5qeCs1Q3cvR3RY?=
 =?utf-8?B?czlsUFZRSW45YStFZGxTRXNJK2t4ZzB6elJ4Yzdxd2RCVWhNeFZneVE4UjU3?=
 =?utf-8?B?dXdKVDJQbWI2aSt6NTNzbXhZZFlyaE9UTnpqQ2hUVWFSekl3QkxRVU0zR0JQ?=
 =?utf-8?B?OVNsSHdzaTVqckNWZTEzVkNBd0xSNDFPZzk1VDE1bVRqd3NzNG5WOTI5aWkz?=
 =?utf-8?B?VGZva3pCTkphQk1WYWlubmtJTzVHUlp3NzBJTDl1QW5tQXdZbnp4UGZUaTgv?=
 =?utf-8?B?Y2txQi9XdWF1WG56R0M3NGQyUXcxMDk2cWd3Vmt1YnRJWnY2NDYxZFlsalZ0?=
 =?utf-8?B?NXhjclZhaWlTMnhBQ0Zqdis2M2Z0RS9ObnJOM3B3dlVMNW5BejNwTVhUNWxo?=
 =?utf-8?B?YWErZEg3NFVYRWFJN1g3N1UvS1FKb29MeVU0TGVZdk5PcXU2N3hFUW95Q084?=
 =?utf-8?Q?Lp/NLcUPyNZaVkcjaM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16718ef8-2af1-4e94-96cc-08de60176ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 15:51:29.2134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BiXrO+vTlDrsVqPcoJmoQ2cDBFzupUkv+FFdnYauU3lhBukQkVFplWlVQfxBZeRPD9wlsb4OXJWm5PKuv8BF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KWWVzICwgSSBjYW4gY29uZmlybSB0aGF0ICBmcm9tIDB4NTIgLCB0aGUgIG1lcyBoYXZlIHRo
ZSBzZXRfaHdfcmVzb3VyY2VfMSBBUEkgc3VwcG9ydCBvbiBnZnhfMTEuICBBY3R1YWxseSAsIEkg
ZG9uJ3Qgc2VlIGEgb2ZmaWNpYWwgcmVsZWFzZSBvbiAweDUxIGZyb20gbWVzIHNpZGUgLCBtYXli
ZSAgaXQncyBhbiBpbnRlcm5hbCB0ZXN0aW5nICB2ZXJzaW9uLg0KDQpSZWdhcmRzDQpTaGFveXVu
LmxpdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxh
bGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50OiBUaHVyc2RheSwgSmFudWFyeSAyOSwgMjAyNiAz
OjEzIFBNDQpUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29t
PjsgTGl1LCBTaGFveXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBkYW5pamVsQG5hdXN5cy5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRybS9hbWQ6IFNldCBtaW5pbXVtIHZlcnNpb24gZm9yIHNldF9od19yZXNvdXJjZV8xIG9uIGdm
eDExIHRvIDB4NTINCg0KT24gVGh1LCBKYW4gMjksIDIwMjYgYXQgMjo1N+KAr1BNIE1hcmlvIExp
bW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4NCj4gY29tbWl0
IGY4MWNkNzkzMTE5ZTcgKCJkcm0vYW1kL2FtZGdwdTogRml4IE1FUyBpbml0IHNlcXVlbmNlIikg
Y2F1c2VkDQo+IGEgZGVwZW5kZW5jeSBvbiBuZXcgZW5vdWdoIE1FUyBmaXJtd2FyZSB0byB1c2Ug
YW1kZ3B1LiAgVGhpcyB3YXMgZml4ZWQNCj4gb24gbW9zdCBnZngxMSBhbmQgZ2Z4MTIgaGFyZHdh
cmUgd2l0aCBjb21taXQgMDE4MGUwYTVkZDVjNg0KPiAoImRybS9hbWRncHUvbWVzOiBhZGQgY29t
cGF0aWJpbGl0eSBjaGVja3MgZm9yIHNldF9od19yZXNvdXJjZV8xIiksDQo+IGJ1dCB0aGlzIGxl
ZnQgb3V0IHRoYXQgR0MgMTEuMC40IGhhZCBicmVha2FnZSBhdCBNRVMgMHg1MS4NCj4NCj4gQnVt
cCB0aGUgcmVxdWlyZW1lbnQgdG8gMHg1MiBpbnN0ZWFkLg0KDQpEbyB3ZSBrbm93IHRoYXQgMHg1
MiBhY3R1YWxseSBoYXMgaXQ/ICBAU2hhb3l1biBMaXUgY2FuIHlvdSB2ZXJpZnk/DQpBc3N1bWlu
ZyB0aGF0IGlzIGNvcnJlY3QsDQpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPg0KDQo+DQo+IFJlcG9ydGVkLWJ5OiBkYW5pamVsQG5hdXN5cy5jb20N
Cj4gQ2xvc2VzOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vl
cy80NTc2DQo+IEZpeGVzOiBmODFjZDc5MzExOWU3ICgiZHJtL2FtZC9hbWRncHU6IEZpeCBNRVMg
aW5pdCBzZXF1ZW5jZSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJp
by5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L21lc192MTFfMC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9tZXNfdjExXzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFf
MC5jDQo+IGluZGV4IDgxYmY5Mzg1ZDU1YTAuLjA5ZWJiMTNjYTVlODEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jDQo+IEBAIC0xNjczLDcgKzE2NzMsNyBAQCBz
dGF0aWMgaW50IG1lc192MTFfMF9od19pbml0KHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Js
b2NrKQ0KPiAgICAgICAgIGlmIChyKQ0KPiAgICAgICAgICAgICAgICAgZ290byBmYWlsdXJlOw0K
Pg0KPiAtICAgICAgIGlmICgoYWRldi0+bWVzLnNjaGVkX3ZlcnNpb24gJiBBTURHUFVfTUVTX1ZF
UlNJT05fTUFTSykgPj0gMHg1MCkgew0KPiArICAgICAgIGlmICgoYWRldi0+bWVzLnNjaGVkX3Zl
cnNpb24gJiBBTURHUFVfTUVTX1ZFUlNJT05fTUFTSykgPj0NCj4gKyAweDUyKSB7DQo+ICAgICAg
ICAgICAgICAgICByID0gbWVzX3YxMV8wX3NldF9od19yZXNvdXJjZXNfMSgmYWRldi0+bWVzKTsN
Cj4gICAgICAgICAgICAgICAgIGlmIChyKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIERS
TV9FUlJPUigiZmFpbGVkDQo+IG1lc192MTFfMF9zZXRfaHdfcmVzb3VyY2VzXzEsIHI9JWRcbiIs
IHIpOw0KPiAtLQ0KPiAyLjUyLjANCj4NCg==
