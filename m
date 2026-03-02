Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EA9D58E5F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 06:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5EA610E43D;
	Mon,  2 Mar 2026 06:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eSwF2biQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487DD10E43D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 06:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uul12+FVeMP1iIFQ6u0qKBBQzBmfhWZBv4MNEh0fPQungV3SrM8X5HGel/Lof/nQj6OjYy29JBuWnSUMGlKSegdvs7/8tusJiPttew0R+P0yZ7cUt6T6AJq/9j93H34B4nBBdpfCNaM321FAO8PU8i26eGgK7Z2YGwnhavicUkGhtT0J0pPcQQ77WesiTgsUoVaml9BSres4ND4/ytG+TqQ6TxyxgckUtwNX/7ZfRJMywezjoBJugwSlMzFLqYBdjlPiuUkszTLAC2ZlhSLaAFzaodWOZdZyLSQaruG1HcLTwe5yymGDPsMs4ksx0/B3Ck7adtbvnv/1L09bU7ATGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/uAeKhtiMt+lVFrR4WG99lVK0q4p2pCKcA6lp66kYE=;
 b=jUQNMzH/mLAh4kpPkljNAkhWyRN3vTS0sIcSO0yle49PvCTJ/AkD3x4642HvhXbNUmRUHHUcXYVjfhQ3HSynCIlP3mh26QGFN3qlqAcnvZZlqbe3pavPsabGasfTW+gd1zE973PmT6p748t5BI8xSHn0KC4JT3owuBvdifi1WZ17YrfFEm8r2613d5+rnpAO5vaI6MlQTJbQkUmAInamqtnaBTI/7oOeZfcVKQblUwpS+qgRp2nSXZLgmM4hfdh6WFEDXrPpPjvFD+6zhyofJWCUEmNWHrx5+hTyIH72TATtiqiURgQeAD9MCsZIDLdvBXYPiv9F3DJdNAbRfwWDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/uAeKhtiMt+lVFrR4WG99lVK0q4p2pCKcA6lp66kYE=;
 b=eSwF2biQAlD4NZN3MTxOtL1vM6WzWE0wurF5MuNVn+82IdiMKb75uqOgzhI/Z77VJer0N2pGFzKU640SxrhZuHO8TMq7P85Yvvi1q0Z+53i4XYrZc9QpPeHnO5NgQzpT2kYvXgaxTqT6lsbVbKfGm8Qjv6+hiwo66Q6Fq9xkRzM=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.20; Mon, 2 Mar 2026 06:33:47 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 06:33:47 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid overflow when sorting pp_feature list
Thread-Topic: [PATCH] drm/amd/pm: Avoid overflow when sorting pp_feature list
Thread-Index: AQHcqguvPqnNIEbQR0CQDc5HgezZorWaxhGAgAABfoCAAAERMA==
Date: Mon, 2 Mar 2026 06:33:46 +0000
Message-ID: <DS7PR12MB6071B2EFF64C827309ACCD918E7EA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260302061242.3062232-1-asad.kamal@amd.com>
 <7e5e915c-1f12-49ac-ae0e-752b5b158e52@amd.com>
 <DM6PR12MB2972453AA557B2E090281111827EA@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2972453AA557B2E090281111827EA@DM6PR12MB2972.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-02T06:25:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS7PR12MB5816:EE_
x-ms-office365-filtering-correlation-id: b2a79cd5-4738-4fbb-85f1-08de7825a880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: DYDm/DNojr71LdcesN0SxQ6HgiwqFh5SYvGZyKefoxWfYvTW07IJ0IB4FRSiBCKhENrd4W4PIBsHABUfr7o0c1wjrhB9Tw+zZPiQPuSR79dhdoTfCf26wrM0pxygxGcu+0ZIXONDUfhMaUZV/4ZZIBCzvT+uXMk5h9R09VUHyA7ypT8EGaZI6E2iKZIjH27NEadJ/SsgQkO1utxlo7UmjBqE9YcKGSmGW+2FmFPaQMTQABpwPIGib/y5N5Q/gylurcO4dgkSmxBNDlSilp/tie6jI6/1eoIfn1Yz5mn2O4l2M9qEKmiUrG5OKWls5+4e/QtX0HW5BfQvR+aE2Tr3TWDPQBYggAEnmLUDuMQDxFrGRNE05ZkP3sELMipqY+eC5aOFobOhwAzW/faLP2HjCVmpZBgAUmhPhMWXy9wBxfMftHf3cTBuuzDHSHi4PX459Lb99vTw7tuTXRf81n+Bm8ltu5TaOJ2EpRGlorYCt8UQmTRqSXVkR7MSbnaLlc594otez0+HAiKUFZ0uBzi/MVu9LwYdiHl2WVZSUbm7LFrNxiXp+Pq0y9rRTOCQu03f3VZS2Sy1yZH4rFdPjIbGOmwRuGu8XAZyFg8Za1MuHxvKLdNSjhAr6Rc+1k9BuVjm3xp11N9q5C6QQ5Vrd4POI0hP2xo3tpceoYMl2UEDGGTljDeC1P004cd/3jIorkXtaZ5tdo8lap3LQNTL5+hOm9N+6v7NCT9MGE5Wu0oYGCQaQ6P6JYU1IVW4eYkUNZwoDxrQN+OqcxcZWjXpi5dy9JM8A7zEoHH44kRSgO6bkA4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1U0WGk1VUtyZjYzQk5IUmFZR28wTjIwd09CM1NsLzdTSG9QNlNUQng0NVVI?=
 =?utf-8?B?WFZWVFQ3TG1MWjZra0lBK1ZDVHV5SmNnczB2SWd5QVFVenZDS3hzcmVBUGF5?=
 =?utf-8?B?bHRjUTlKYmtobE1wQmRaRyt5ZmNrbCthRzhOTUU0bVRrYXUybld4MWw3Mmlu?=
 =?utf-8?B?OWcwc3J3OFE3bnNDQTkyK0FiNytZVGxTdGgwOEFNN2tyOWRlbFJJYTN2OTk1?=
 =?utf-8?B?em9QUUNza3ByVENCWm5qczlFRUJTMjdGcmg3REowdGdrMHJVdDZ2UnB4OWdR?=
 =?utf-8?B?NG1lUnhUZXkwclFGSzQ2SlFUMVZBS3ZkNnNFUzRoMUxtcVdtTElWRWV5enBl?=
 =?utf-8?B?R3o1dmYzVG9reXU1amV0bHNJcDY4QkZXNm1ubzhiVG0ycWpIRVBkeGozU1lv?=
 =?utf-8?B?TjdQaG9YemFGVWFxcVhLcWJ0eWlvNDJUenpyM2NqQTJFc291bzd1YVMyVVJV?=
 =?utf-8?B?WngxOGxMUTRXVDQ2c25sRkQveWlFNzVFUER4emVjZWpQbWtQZXEwdk80Rys3?=
 =?utf-8?B?QnhMRmhOL25acWFSRlBhVGQ3eE8zb3lLbXZ3NXcyL0dmL1ZpTGZnbnZKNy9z?=
 =?utf-8?B?WHppTEVZcnJtSUxBWWRIOEYya0xZdXBvZnhOOUltdmJ5cTJPRWpGZWVrUjMv?=
 =?utf-8?B?WW8zMUZvNnQyYWtTSzNibFZNdVZKSVRuWEVJbUFSdnBad1grTjZabmpWb1BP?=
 =?utf-8?B?MFZKSFpOWDFhUDF4eUQ1RE5wZmpmbEFmMTVIbzdyTzdjS3hnUEVyNFpNcGRm?=
 =?utf-8?B?MUIvSmdzanFBYmJ5ZDlJS0kyaVd4cFByRit4aFFXYWx0UlhFMXZqV0NMK3Ni?=
 =?utf-8?B?S0ZQb3ViS1VsdVhMUEc5bTErU04xcktKM2RHSW40ZVRMTDQ4QjZQcWRiYVdD?=
 =?utf-8?B?SDBid1JwNU5Ca3hhZ2U2TnNEQTFmL0FlTXhWRi9rTldjVWxRMFVHaGRWa0NK?=
 =?utf-8?B?b1g5RERzTkkyZXYvMlR4VWFtL29tck1XN3VBZUhGTHF3Rko2QmhaNDNXVGFw?=
 =?utf-8?B?UlRCSGI5YnR0TXZRTXNqcXJkVnMzRVVTaDBXTlZZVkZGRFk5RGJMUnd4a2lQ?=
 =?utf-8?B?amcxQjU5eXJVWTM5dVhMV3VHa1oyZVQvb0dBQWw2WTdHT0RPcjIybzNVVWhJ?=
 =?utf-8?B?L2xnWUE3MUZjTVQvVzZDNWJPQ2RNelFOQ0E1OC82TVhUd2ZDTDlEVVFoT0hG?=
 =?utf-8?B?NmNpVDNUakNOYUtaN2dWeVZDWElpb0g5c3EvSWI5RHM1eXc0OWMwZlZKeEJm?=
 =?utf-8?B?RitSZExxZ0JpVWp3UUxLRTNHc3pHU0hzRmlFTmJxVlgyNEhES1cvOW9BUGRH?=
 =?utf-8?B?NjlzeXJoWEdnejNpMkovdUtEZndhT3dvQVJTRG5jU0l4ZS9uL2toQ3ExRXo1?=
 =?utf-8?B?L1ZsUVF0V1ZoeU1McmxnMjdVSjJScGpUL1c4YjBIbHQwSkw5M3dBYTJvbWhj?=
 =?utf-8?B?QjRqckRvR3NmQURNQzlkbmZ4VHNVNWhWYzJQN1c3WDBuaXEvZm9KNGpXUzZW?=
 =?utf-8?B?S3MvcjE0OTF0NWx2cE5QN0x4aFlzVEpHNmpLYjdUNlR1MkpuMmE0YS9HYmxw?=
 =?utf-8?B?dy9QS0Y4c0Y3VFVndGhJNGZ1VmhqY1V0SjNWdFdRZ3NPVzE5N2NNWkpVem5p?=
 =?utf-8?B?dUQ3L2hua2FHUTB5TXFoMXZYcGszK1A3a1pJL2VFa0ZxRld4aXhLVWtkeno0?=
 =?utf-8?B?MUtjZ210ZXRCeC91VVdxWjJRNlNaVWlJdUhhaFhiSlZxV05tL1gwcDlxVnhW?=
 =?utf-8?B?d3A3S1F1VVhFRUVoWklVYVVNT2VFY3paNStVZWtaTHcxSFl1aEhTMUlDZThG?=
 =?utf-8?B?bEtYcVdyM3hScURBOW90RnVoNzNoQy9nVFQ1L1h5TjEyUzA2ZlVNVzQrRkF5?=
 =?utf-8?B?Nys4WEwycUYxUmVNcDBYTC9Rc1FNMm44YXhWTFZlVi9HKzFpUGIwQjVDeEtj?=
 =?utf-8?B?WFpGL25TSkh6QVJPV1IwZGlRNm5VM1FJWXJmTW1Hd01EZzV4RjhBR2pld3FJ?=
 =?utf-8?B?ekpxV1BKVzFmaUE4S0EwS2djL2RhNHFrcGd5cDA3SkdTb0R0WGdRQWM2NEVj?=
 =?utf-8?B?RUkxQk1NVGt3R3B5bWVpdGZqS25KWThKdHdxTjBOZkpsRnR6cnFzQWtOQzJx?=
 =?utf-8?B?OFRnMWhKR0c3QkIvbC9CWGNZdW4vWFF3UCtZYkpBNHoxd04zeFprUnVtTVRk?=
 =?utf-8?B?bUVjLzl5TDhvYTFleVFKQ080M0hXSTc3ZWVZU3JBRExXSDcrRUg2TVluMnc2?=
 =?utf-8?B?REEySUM1eUx6bitoSkhqVVFDVFJnLy93YnJ1Q1pJYzVWdHF3MTIvNXhyQm1O?=
 =?utf-8?Q?fE0Am3QELMw+76dyZy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a79cd5-4738-4fbb-85f1-08de7825a880
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 06:33:46.8883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMvrYUKASgQfCKexEgICAzV8B1XuB/udFULkElqFG/YGxBGU/ck7tlaxdTQYOnSurUqhTNCPmBWALmKi4FiFUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
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
Cg0KLTEgaW4gbWVtc2V0IGZpbGxzIGFsbCBieXRlcyB3aXRoIDB4RkYuIEZvciBpbnQxNl90LCB0
aGF0IGJlY29tZXMgMHhGRkZGLCB3aGljaCBpcyAtMSBpbiB0d2/igJlz4oCRY29tcGxlbWVudC4g
U28gdGhlIDwgMCBjaGVjayBzdGlsbCB3b3JrcyBhcyBpbnRlbmRlZC4NCg0KUmVnYXJkcw0KQXNh
ZA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogV2FuZywgWWFuZyhLZXZpbikg
PEtldmluWWFuZy5XYW5nQGFtZC5jb20+DQpTZW50OiBNb25kYXksIE1hcmNoIDIsIDIwMjYgMTE6
NTkgQU0NClRvOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgS2FtYWwsIEFzYWQg
PEFzYWQuS2FtYWxAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
WmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IE1hLCBMZSA8TGUuTWFAYW1k
LmNvbT47IFpoYW5nLCBNb3JyaXMgPFNoaXd1LlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIXSBk
cm0vYW1kL3BtOiBBdm9pZCBvdmVyZmxvdyB3aGVuIHNvcnRpbmcgcHBfZmVhdHVyZSBsaXN0DQoN
CltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHld
DQoNCj4+IG1lbXNldChzb3J0X2ZlYXR1cmUsIC0xLCBzaXplb2Yoc29ydF9mZWF0dXJlKSk7DQou
Li4NCj4+IGlmIChzb3J0X2ZlYXR1cmVbZmVhdHVyZV9pbmRleF0gPCAwKQ0KICAgICAgY29udGlu
dWU7DQoNCldoZW4gdGhlIGFycmF5IHR5cGUgaXMgY2hhbmdlZCBmcm9tIGludDhfdCB0byBpbnQx
Nl90LCB0aGUgY29kZSBsb2dpYyBvZiB0aGlzIG1lbXNldCgpIG1heSBub3QgY29ycmVjdGx5IGlu
aXRpYWxpemUgYWxsIGVsZW1lbnRzIHRvICctMScuDQpQbGVhc2UgbW9kaWZ5IHRoaXMgY29kZSB0
b2dldGhlciB0byBlbnN1cmUgdGhhdCB0aGUgc3Vic2VxdWVudCBjb2RlIGxvZ2ljIG1lZXRzIGV4
cGVjdGF0aW9ucy4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBN
b25kYXksIE1hcmNoIDIsIDIwMjYgMjoyMyBQTQ0KVG86IEthbWFsLCBBc2FkIDxBc2FkLkthbWFs
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdr
aW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBNYSwgTGUgPExlLk1hQGFtZC5jb20+OyBaaGFu
ZywgTW9ycmlzIDxTaGl3dS5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5n
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBBdm9pZCBvdmVyZmxv
dyB3aGVuIHNvcnRpbmcgcHBfZmVhdHVyZSBsaXN0DQoNCg0KDQpPbiAwMi1NYXItMjYgMTE6NDIg
QU0sIEFzYWQgS2FtYWwgd3JvdGU6DQo+IHBwX2ZlYXR1cmVzIHNvcnRpbmcgdXNlcyBpbnQ4X3Qg
c29ydF9mZWF0dXJlW10gdG8gc3RvcmUgZHJpdmVyIGZlYXR1cmUNCj4gZW51bSBpbmRpY2VzLiBP
biBuZXdlciBBU0lDcyB0aGUgZW51bSBpbmRleCBjYW4gZXhjZWVkIDEyNywgY2F1c2luZw0KPiBz
aWduZWQgb3ZlcmZsb3cgYW5kIHNpbGVudGx5IGRyb3BwaW5nIGVudHJpZXMgZnJvbSB0aGUgb3V0
cHV0Lg0KPiBTd2l0Y2ggdGhlIGFycmF5IHRvIGludDE2X3Qgc28gYWxsIGVudW0gaW5kaWNlcyBh
cmUgcHJlc2VydmVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBc2FkIEthbWFsIDxhc2FkLmthbWFs
QGFtZC5jb20+DQoNClJldmlld2VkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+
DQoNClRoYW5rcywNCkxpam8NCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdV9jbW4uYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211X2Ntbi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21u
LmMNCj4gaW5kZXggYzQ3MWMwZTJjYmQxLi4zMjZjODZiOTIwYTIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+IEBAIC04ODAsNyArODgwLDcgQEAgc3RhdGlj
IGNvbnN0IGNoYXIgKnNtdV9nZXRfZmVhdHVyZV9uYW1lKHN0cnVjdCBzbXVfY29udGV4dCAqc211
LA0KPiAgIHNpemVfdCBzbXVfY21uX2dldF9wcF9mZWF0dXJlX21hc2soc3RydWN0IHNtdV9jb250
ZXh0ICpzbXUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKmJ1ZikN
Cj4gICB7DQo+IC0gICAgIGludDhfdCBzb3J0X2ZlYXR1cmVbTUFYKFNNVV9GRUFUVVJFX0NPVU5U
LCBTTVVfRkVBVFVSRV9NQVgpXTsNCj4gKyAgICAgaW50MTZfdCBzb3J0X2ZlYXR1cmVbTUFYKFNN
VV9GRUFUVVJFX0NPVU5ULCBTTVVfRkVBVFVSRV9NQVgpXTsNCj4gICAgICAgc3RydWN0IHNtdV9m
ZWF0dXJlX2JpdHMgZmVhdHVyZV9tYXNrOw0KPiAgICAgICB1aW50MzJfdCBmZWF0dXJlc1syXTsN
Cj4gICAgICAgaW50IGksIGZlYXR1cmVfaW5kZXg7DQoNCg0K
