Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DCEFF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD9710E09D;
	Mon, 27 Apr 2026 08:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2edgVEg/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9C210E09D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR9n7P+UJjDtGwUP7AkXoJ38RP5H4WlM2dUTk4JamUeWQPG7wZpb7bZDkgVQ7hc30/tMsRVcpII92kGwBFaCHs7TVyZ7yack0S2Rlm2CHsMX7G57Mm0GddzPDVuTxs4xpKgO2AYNz5XMthUuuX3SUwiVLzoFHNn4oJ+WEO3EeJFQaDAIJSj3asvIku7lkIc/tVNEGUOjxQiv7ydxU6DW3nrEVhVOkOAzrnynF/45EW1FUyetF3FCnZ0NuCaIlAWLxgKIs4j1C6ASevNW5fVWviwkUm0NnfmuXthvXDDZi7b8MoWtrQ1eSJPvbREY5gsdbzWpPeuSCVo/9qegnx20mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEThN6vvNhlqhq3UrZLtmVKEvWnPtwJTiy/JkbUrJrQ=;
 b=kBoOxVwwsjnayTB28uhMcSciiXN/uLnrQhsCBw0n+oQarXu86mJ8wNtIgkOG86yi6eDhpjV/6Po4f0f4D+5nRZH/0YYNBDeqoRtVnA50jHViffpLU4h9GHhYkNU2S23uZX/8AW2D3Eqf1DYHHiuI5+EZ4E1UNoV2DP4z4qaWpNlbHM5sLQtdfrNo47yeA99HrEmY2fbQz9eGfsn5tJLBK1OmBNtDxtn4S7syaN/gfpODXc/9PTwB1qfukOjLEawZ7bYrw1iQqKLcX+MD/SFZ72SOlR80xGXDCkdk5t4PUPtT08APvLX8AzcEQvcVzu3HICtEErY0sQOOkEJLflOKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEThN6vvNhlqhq3UrZLtmVKEvWnPtwJTiy/JkbUrJrQ=;
 b=2edgVEg/cSWZghzoDvEvhcyTBK+4zWLfGlR1eMWUvxCAIudi3rbUhBoCYQJRC85LF3vboisW52d1iwGKp5b4OiGFiUG8U6vmRiDTM/WwKRvQvDBRa31ZLrDQsR5r1MfDkwhvSxJjPujf6WHCYpIuhgnOj2uI3r/n3prMv0Lz3fk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.16; Mon, 27 Apr 2026 08:45:50 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 08:45:50 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 02/11] drm/amdgpu: remove deadlocks from
 amdgpu_userq_pre_reset
Thread-Topic: [PATCH 02/11] drm/amdgpu: remove deadlocks from
 amdgpu_userq_pre_reset
Thread-Index: AQHc0Y4gNwusbBUTuESwOdKcXeDpZbXygRqQ
Date: Mon, 27 Apr 2026 08:45:50 +0000
Message-ID: <DS7PR12MB6005152F8AAA35880A0E999EFB362@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-2-christian.koenig@amd.com>
In-Reply-To: <20260421125513.4545-2-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-04-27T06:50:26.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA0PR12MB7580:EE_
x-ms-office365-filtering-correlation-id: 55ffea73-a1c8-4506-417b-08dea4396292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: yBPX7TXKgN0/lesqN6cnxo09nLF5VJpFnAznXmgSIqSnUdWLpNAFYa1T5VnLowMvo93IiYHrQh7ifipHpsOApqoLfgBN7di0FPi8+FXcfV348wzSUV4Z1MtUzdN4d1LoTDCAYdt6h9KCkxvvTAKRlHaaqoQbB50mjUzdR4REERsU2stzntHi9HQRPpQsifIX8e7TRgzbMXToGHVyBakVG8cd86WlZWFEhEgIMDv/7bzQvkPEUcGqhsq/fMrH9O6jm791H24aEvehGZG1jNTam06cSR7y8q+42HZ2mpPK1zfLq3qlPA6dXvSix0qfoGYmOyGAVqyM9c0oGTc8xkjfYbgu1LGPo5l/vGOElugEvli1MNNLmBtEC07X2AO4h09Q99lj5HyeqBKTU3uq1jc8dQxhKo3qEHMJ0dV836ZkWLRgETXsxDP+H8DCMNNlov49LHTUYHDSc/rMG4xdF9W351gPSxBv7j80b0B8MAFoBaNudH4qXQz5l4V3qID/YMNx66iX9+Ij3NMdn0S618OaiUicfaaC0dM2xPrR01CwyrofZkGVarVXM+6cN90etPx0qU3nMkEyjTyz0n3do/OJjLFL9BEbGVtUtLUJWvAGYghtatbZm/Lo0s+XPDCubGs5evYco/I+WC31dncYfKKAqbCAsr3IQuG5xD5wNLxAq2yeXHEKyDhbvqC8CMOqXqnwl3aLhFuC/WkrCjXZ/FK7ZmXJoa5+DBIFO4zIpihw/naFccOG0y2dAdJ0LiocrzagS9xi+zUQo0OAW4SBZzZf+jxDKUVl0DwgNc8HzTqysHM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1Y2cmNmdDJ1RGVWVUtzZXlTaVB1Nk9LUEhTM3BNcktuc0tjSS94Wm9HeERl?=
 =?utf-8?B?M2poSzJYaHhXVGM5bW5BQ0g4RTAwY2hmcm1iNGZ4M1laUWdON2JsSXhGYTRR?=
 =?utf-8?B?b3hpeWROYzJBZTBWN0xldzBYdlJFVWViU3RwMlQ3RTl0Qm41M2NUbzdQeWlE?=
 =?utf-8?B?TjFmdTdKUk5uc0NwN3F0dXRlUUdaUmRlVERYRlcyazVEaHZuRU05VVRWQkE4?=
 =?utf-8?B?TjRpMkhpZUtBTVpxTmttSG9SamJ6WThVRGh1VjVDaDRHMHhaaHFFZXBuVC9K?=
 =?utf-8?B?T2cySGZtMTRrK2VCV085N3h2UkpCMVpxQ090eFcreE9rWUZoQ1YzOGRkTXl4?=
 =?utf-8?B?M2xZK3grV0lrTURLTmFuWGk2dmVKUkgrbDlvWDVtZTRja2YrQ1ZRSlBiekE3?=
 =?utf-8?B?RTV4Wm5LQU90UWlBYjlCYkJaTGIvRm03VGZKVVc3VzNmYW8ydmhCdHlWS1FQ?=
 =?utf-8?B?U0VkR1E3MUZmK2Q0S3l6V1g1Y2w4UnRDZktHUDEvVTdqLy9CNDZEUEpEOTJJ?=
 =?utf-8?B?cVV5Z2Z3bzlYclJzV3R1a1ZnNXpBOW90ZmZ5U3Fzb2xKMy9iRk9aVkhLaVJT?=
 =?utf-8?B?SHJIVlFTcUUwdHNlWWloYUhtRnlUOWZkZERZWjlLSkFJRU1BR0dUQ0hHa2tO?=
 =?utf-8?B?NHJmRldyaitHMnFHK0UrSDRPN2NvRWpjNFNwTWlZRW5aaU42bWFZTXZqNTZs?=
 =?utf-8?B?ZktqR0lxY1RVdExjejV6ZkRLTE1uenNJeTBBZ3l2RklHc3NnT2xxVVMra3hQ?=
 =?utf-8?B?em84bFFNUzhiOFR4YWRRTTZucUxRR08rQldKekx4THpVcU1HL2ZyeHlLVHJN?=
 =?utf-8?B?bW1MN3pheHoxT0phWnhFWEk4VmNnN09Rekl3Tm42WWRuWWlIYWJmNXdsYmRL?=
 =?utf-8?B?aEVHT0IrRkx0NDhKZ2F2R2w2TnVPMUwyRStycGFJSzVyMGVFSUQ5aTJldGoy?=
 =?utf-8?B?V3F6WVcyTThFVzFrZllkT3ExSGp3MVpwQlloNEtYK1VXblhmbStjcGJqUCti?=
 =?utf-8?B?WllsZ3F2cER4eHRyd1JVOCtzbW12d3pLL2VIYzAyNUQrM2twd1hKRjN3N0Rx?=
 =?utf-8?B?L3J2dllJNkRkM3MwRjdlSWhHd1NEQ0JZZ1ZSZTA0bFQyWjZXb1I3blQvSWJT?=
 =?utf-8?B?MjRPK24wVjlmQWZkbzYzSnNVQ1RGOUszTHNtZ1ZrdGoySlYrQ2xXb0hDQ2lQ?=
 =?utf-8?B?Y2I4TG1DcVQzcy9uaU5zeVk3OHcrYkxibUMzUmt4OFBCUWpJVENVdmhCbGxj?=
 =?utf-8?B?Q1BSaXpQYTZEcjhWMW1IL1RkWFpNM2dUdlhmdkxxL1llL1M2THJoSjZ6QnRt?=
 =?utf-8?B?QUtndXR0cE52ZTlyL2tvcis4bk9FSm9lUWVrZTl4bit2YzY1SFI4Z0lxcDhB?=
 =?utf-8?B?SkVnaldsSS9OZ0cyRVI0ZHRhcmVvWGNONjBzV1JkMjFvNGxlT1lrRU5QVWVa?=
 =?utf-8?B?UEQzbTg0R0hZMlBWdk1PT2JnNVVFWWhnUGdNRWNyM0g0cGVOWlpOa3VGMVdw?=
 =?utf-8?B?Z1NJTHBoMVNITW5PYnIvUno0T2ZyUVd5d0xWOXZTVi9vZVA0VWVOcEQ0N2Rw?=
 =?utf-8?B?eGIxNWNac1dOVEV6aUEzNXVEaHNCM2tnVlRBQU9VWDZpaUlESE5lMVFrVWpF?=
 =?utf-8?B?MlZlU0hKRTNiWCsrRnZwQk1GUUo3SXZhc1AxS1ZBaEpFVXcyWjhkS1JkNFU2?=
 =?utf-8?B?cThYWXpDNXc1di81SHlEaURma1JYWit5QzcyaUtFaU02VXNYeEUrOERaS0Yr?=
 =?utf-8?B?QTl3alFXR1pNaVF5a0R1RUFCdjZySEFYbE02dlpWVFBUeUxBMVg4VG5uRjNO?=
 =?utf-8?B?TXgxTmpJSkhCUEhnbVc3ZG04bnJORmFaRTYvcng2dGVRVlZJM1BhNVdMd0lZ?=
 =?utf-8?B?ODEzaVoyOXE0aXRmS1dPQnFGbjBKb0NzTVRwTGN6SFo3MitMM2pqdjY2aXM1?=
 =?utf-8?B?YWRoQWRSWTd3VWt0ZTFzMkhRaW53K1p1ZGFQOHFvOFlWNVluK3kvcmNpbStx?=
 =?utf-8?B?N1R4ZmJYTzdzR2hFL3dibjJ4MVFjYnVHc2pEdDNSNllZV0dGS1oyNSsrMnp2?=
 =?utf-8?B?cldmSWQwSjE2ZU5PemJEbGtOTVBzd3ZBNUY2WUNQMDhvU1NyWVltRXcyM2tZ?=
 =?utf-8?B?L2VXUDNFZGNyUUNqRzBIZi9zQmJ5bDNXMDdjajlZbE1Fc3NZWUdyTG9nRWpT?=
 =?utf-8?B?WmgzQk1lZTJQL3ZzZms2WHJXN3cxbUNkN2g4cUJyZG1wOUJzRDBnajVOMzd0?=
 =?utf-8?B?ZVdtbDVhS3daT2RvbEZSRUNVTjlqK1JkNHF5M1ZtcjhLOHc4U0lwclU0Nlp3?=
 =?utf-8?Q?q7nOBis4iimJdZtYjU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ffea73-a1c8-4506-417b-08dea4396292
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 08:45:50.6386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oegyY+bx/j6sgWtJrVplcYNRH9up7SnNxHl16PbAtY2E+dZozp1Hm/6FELjY2ht/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580
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

UHVibGljDQoNClJldmlld2VkLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4N
Cg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5j
b20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDIxLCAyMDI2IDg6NTUgUE0NCj4gVG86IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpYW5nLCBQcmlrZQ0K
PiA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQu
Y29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBLb2VuaWcsIENo
cmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMDIv
MTFdIGRybS9hbWRncHU6IHJlbW92ZSBkZWFkbG9ja3MgZnJvbQ0KPiBhbWRncHVfdXNlcnFfcHJl
X3Jlc2V0DQo+DQo+IFRoZSBwdXJwb3NlIG9mIGEgR1BVIHJlc2V0IGlzIHRvIG1ha2Ugc3VyZSB0
aGF0IGZlbmNlIGNhbiBiZSBzaWduYWxlZCBhZ2FpbiBhbmQNCj4gdGhlIHNpZ25hbCBhbmQgcmVz
dW1lIHdvcmtlcnMgY2FuIG1ha2UgcHJvZ3Jlc3MgYWdhaW4uDQo+DQo+IFNvIHdhaXRpbmcgZm9y
IHRoZSByZXN1bWUgd29ya2VyIG9yIGFueSBmZW5jZSBpbiB0aGUgR1BVIHJlc2V0IHBhdGggaXMg
anVzdCB1dHRlcmx5DQo+IG5vbnNlbnNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMgfCAyNiArKysrKysrKysrKy0tLS0tLS0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJx
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiBpbmRl
eCA4ZjQ4NTIwY2I4MjIuLmI2MzJiYzNjOTUyYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gQEAgLTE0OTYsMjMgKzE0OTYsMjEgQEAgdm9pZCBh
bWRncHVfdXNlcnFfcHJlX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2KSAgew0K
PiAgICAgICBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3VzZXJxX2Z1bmNzICp1c2VycV9mdW5jczsNCj4g
ICAgICAgc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1ZSAqcXVldWU7DQo+IC0gICAgIHN0cnVj
dCBhbWRncHVfdXNlcnFfbWdyICp1cW07DQo+ICAgICAgIHVuc2lnbmVkIGxvbmcgcXVldWVfaWQ7
DQo+DQo+ICsgICAgIC8qIFRPRE86IFdlIHByb2JhYmx5IG5lZWQgYSBuZXcgbG9jayBmb3IgdGhl
IHF1ZXVlIHN0YXRlICovDQo+ICAgICAgIHhhX2Zvcl9lYWNoKCZhZGV2LT51c2VycV9kb29yYmVs
bF94YSwgcXVldWVfaWQsIHF1ZXVlKSB7DQo+IC0gICAgICAgICAgICAgdXFtID0gcXVldWUtPnVz
ZXJxX21ncjsNCj4gLSAgICAgICAgICAgICBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnVxbS0+
cmVzdW1lX3dvcmspOw0KPiAtICAgICAgICAgICAgIGlmIChxdWV1ZS0+c3RhdGUgPT0gQU1ER1BV
X1VTRVJRX1NUQVRFX01BUFBFRCkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3Vz
ZXJxX3dhaXRfZm9yX2xhc3RfZmVuY2UocXVldWUpOw0KPiAtICAgICAgICAgICAgICAgICAgICAg
dXNlcnFfZnVuY3MgPSBhZGV2LT51c2VycV9mdW5jc1txdWV1ZS0+cXVldWVfdHlwZV07DQo+IC0g
ICAgICAgICAgICAgICAgICAgICB1c2VycV9mdW5jcy0+dW5tYXAocXVldWUpOw0KPiAtICAgICAg
ICAgICAgICAgICAgICAgLyoganVzdCBtYXJrIGFsbCBxdWV1ZXMgYXMgaHVuZyBhdCB0aGlzIHBv
aW50Lg0KPiAtICAgICAgICAgICAgICAgICAgICAgICogaWYgdW5tYXAgc3VjY2VlZHMsIHdlIGNv
dWxkIG1hcCBhZ2Fpbg0KPiAtICAgICAgICAgICAgICAgICAgICAgICogaW4gYW1kZ3B1X3VzZXJx
X3Bvc3RfcmVzZXQoKSBpZiB2cmFtIGlzIG5vdCBsb3N0DQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgKi8NCj4gLSAgICAgICAgICAgICAgICAgICAgIHF1ZXVlLT5zdGF0ZSA9IEFNREdQVV9VU0VS
UV9TVEFURV9IVU5HOw0KPiAtICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3VzZXJxX2ZlbmNl
X2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKHF1ZXVlKTsNCj4gLSAgICAgICAgICAgICB9DQo+ICsg
ICAgICAgICAgICAgaWYgKHF1ZXVlLT5zdGF0ZSAhPSBBTURHUFVfVVNFUlFfU1RBVEVfTUFQUEVE
KQ0KPiArICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICsNCj4gKyAgICAgICAgICAg
ICB1c2VycV9mdW5jcyA9IGFkZXYtPnVzZXJxX2Z1bmNzW3F1ZXVlLT5xdWV1ZV90eXBlXTsNCj4g
KyAgICAgICAgICAgICB1c2VycV9mdW5jcy0+dW5tYXAocXVldWUpOw0KPiArICAgICAgICAgICAg
IC8qIGp1c3QgbWFyayBhbGwgcXVldWVzIGFzIGh1bmcgYXQgdGhpcyBwb2ludC4NCj4gKyAgICAg
ICAgICAgICAgKiBpZiB1bm1hcCBzdWNjZWVkcywgd2UgY291bGQgbWFwIGFnYWluDQo+ICsgICAg
ICAgICAgICAgICogaW4gYW1kZ3B1X3VzZXJxX3Bvc3RfcmVzZXQoKSBpZiB2cmFtIGlzIG5vdCBs
b3N0DQo+ICsgICAgICAgICAgICAgICovDQo+ICsgICAgICAgICAgICAgcXVldWUtPnN0YXRlID0g
QU1ER1BVX1VTRVJRX1NUQVRFX0hVTkc7DQo+ICsgICAgICAgICAgICAgYW1kZ3B1X3VzZXJxX2Zl
bmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKHF1ZXVlKTsNClRoZSB1c2VycSBoYW5nIGRldGVj
dGlvbiBhbmQgZmVuY2UgY29tcGxldGlvbiBtYXkgaGF2ZSBhbHJlYWR5IGJlZW4gaGFuZGxlZCBi
eSBkZXRlY3RfYW5kX3Jlc2V0KCkgaW4gYW1kZ3B1X3VzZXJxX21ncl9yZXNldF93b3JrKCkuIElu
IHRoYXQgY2FzZSwgd2UgY291bGQgdmFsaWRhdGUgdGhlIHF1ZXVlIGFuZCBmZW5jZSBzdGF0ZSBm
aXJzdCBhbmQgc2tpcCB0aGUgcmVkdW5kYW50IG9wZXJhdGlvbi4gVGhhdCdzIGFuIG9wdGlvbiBp
bXByb3ZlbWVudCwgYW5kIHRoZSBwYXRjaCBpcyBmaW5lIHdpdGggaXQgb3Igbm90LCBzbyB0aGUg
cGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPi4N
Cg0KPiAgICAgICB9DQo+ICB9DQo+DQo+IC0tDQo+IDIuNDMuMA0KDQo=
